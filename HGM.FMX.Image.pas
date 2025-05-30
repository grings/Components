unit HGM.FMX.Image;

interface

uses
  System.Classes, System.Types, System.SysUtils, FMX.Forms, FMX.Graphics,
  FMX.Objects, System.Threading, System.Generics.Collections,
  System.Net.HttpClient;

type
  TCallbackObject = record
    Owner: TComponent;
    Bitmap: TBitmap;
    Url: string;
    Task: ITask;
    OnDone: TProc<Boolean>;
    procedure Done(const Success: Boolean);
  end;

  TObjectOwner = class(TComponent)
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
  end;

  TBitmapHelper = class helper for TBitmap
  private
    class var
      Pool: TThreadPool;
      FCallbackList: TThreadList<TCallbackObject>;
      FObjectOwner: TComponent;
      FClient: THTTPClient;
      FCachePath: string;
    class function UrlToCacheName(const Url: string): string;
    class procedure AddCallback(Callback: TCallbackObject);
    class procedure Ready(const Url: string; Stream: TStream);
    class function Get(const URL: string): TMemoryStream; static;
    class function GetClient: THTTPClient; static;
    class procedure SetCachePath(const Value: string); static;
    class function FindCached(const Url: string; out Stream: TMemoryStream): Boolean; static;
    class procedure AddCache(const Url: string; Stream: TMemoryStream);
    class procedure AddCacheFileName(const FileName: string; Stream: TMemoryStream);
    class function FindCachedFileName(const FileName: string; out Stream: TMemoryStream): Boolean; static;
  public
    class procedure RemoveCallback(const AOwner: TComponent);
    class procedure CancelAll;
    procedure LoadFromUrl(const Url: string; UseCache: Boolean = True);
    procedure LoadFromUrlAsync(AOwner: TComponent; const Url: string; Cache: Boolean = True; OnDone: TProc<Boolean> = nil); overload;
    // Cache first check
    procedure LoadFromUrlAsyncCF(AOwner: TComponent; const Url: string; Cache: Boolean = True; OnDone: TProc<Boolean> = nil); overload;
    procedure LoadFromUrlAsyncCF(AOwner: TComponent; const Url, CachedFileName: string; OnDone: TProc<Boolean> = nil); overload;
    procedure LoadFromResource(ResName: string); overload;
    procedure LoadFromResource(Instanse: NativeUInt; ResName: string); overload;
    procedure SaveToStream(Stream: TStream; const Ext: string); overload;
    procedure SaveToFile(const AFileName: string; const Ext: string); overload;
    class function CreateFromUrl(const Url: string; UseCache: Boolean = True): TBitmap;
    class function CreateFromResource(ResName: string; Url: string = ''): TBitmap;
    class property Client: THTTPClient read GetClient;
    class property CachePath: string read FCachePath write SetCachePath;
  end;

implementation

uses
  FMX.Surfaces, FMX.Types, FMX.Consts, System.Hash, System.IOUtils;

{ TBitmapHelper }

class procedure TBitmapHelper.AddCallback(Callback: TCallbackObject);
begin
  Callback.Owner.FreeNotification(FObjectOwner);
  FCallbackList.Add(Callback);
end;

class procedure TBitmapHelper.CancelAll;
begin
  var List := FCallbackList.LockList;
  try
    for var i := List.Count - 1 downto 0 do
      List[i].Task.Cancel;
    List.Clear;
  finally
    FCallbackList.UnlockList;
  end;
end;

class function TBitmapHelper.CreateFromResource(ResName, Url: string): TBitmap;
begin
  Result := TBitmap.Create;
  Result.LoadFromResource(ResName);
end;

class function TBitmapHelper.CreateFromUrl(const Url: string; UseCache: Boolean): TBitmap;
begin
  Result := TBitmap.Create;
  Result.LoadFromUrl(Url, False);
end;

procedure TBitmapHelper.LoadFromResource(ResName: string);
begin
  LoadFromResource(HInstance, ResName);
end;

procedure TBitmapHelper.LoadFromResource(Instanse: NativeUInt; ResName: string);
var
  Mem: TResourceStream;
begin
  Mem := TResourceStream.Create(Instanse, ResName, RT_RCDATA);
  try
    Mem.Position := 0;
    Self.LoadFromStream(Mem);
  finally
    Mem.Free;
  end;
end;

procedure TBitmapHelper.LoadFromUrl(const Url: string; UseCache: Boolean);
var
  Mem: TMemoryStream;
begin
  Mem := Get(Url);
  try
    Mem.Position := 0;
    Self.LoadFromStream(Mem);
  finally
    Mem.Free;
  end;
end;

class function TBitmapHelper.Get(const URL: string): TMemoryStream;
begin
  if URL.IsEmpty then
    raise Exception.Create('Empty URL');
  Result := TMemoryStream.Create;
  try
    if (GetClient.Get(URL, Result).StatusCode = 200) and (Result.Size > 0) then
      Result.Position := 0
    else
    begin
      Result.Free;
      Result := nil;
    end;
  except
    Result.Free;
    Result := nil;
  end;
end;

class function TBitmapHelper.GetClient: THTTPClient;
begin
  if not Assigned(FClient) then
  begin
    FClient := THTTPClient.Create;
    FClient.HandleRedirects := True;
  end;
  Result := FClient;
end;

class function TBitmapHelper.FindCached(const Url: string; out Stream: TMemoryStream): Boolean;
begin
  Result := False;
  Stream := nil;
  var FileName := TPath.Combine(FCachePath, UrlToCacheName(Url));
  if TFile.Exists(FileName) then
  try
    Stream := TMemoryStream.Create;
    Stream.LoadFromFile(FileName);
    Result := True;
  except
    Stream.Free;
    Stream := nil;
  end;
end;

class function TBitmapHelper.FindCachedFileName(const FileName: string; out Stream: TMemoryStream): Boolean;
begin
  Result := False;
  Stream := nil;
  var FilePath := TPath.Combine(FCachePath, FileName);
  if TFile.Exists(FilePath) then
  try
    Stream := TMemoryStream.Create;
    Stream.LoadFromFile(FilePath);
    Result := True;
  except
    Stream.Free;
    Stream := nil;
  end;
end;

class procedure TBitmapHelper.AddCacheFileName(const FileName: string; Stream: TMemoryStream);
begin
  var FilePath := TPath.Combine(FCachePath, FileName);
  try
    if TFile.Exists(FilePath) then
      TFile.Delete(FilePath);
  except
    Exit;
  end;
  try
    Stream.SaveToFile(FilePath);
  except
    //
  end;
end;

class procedure TBitmapHelper.AddCache(const Url: string; Stream: TMemoryStream);
begin
  var FileName := TPath.Combine(FCachePath, UrlToCacheName(Url));
  try
    if TFile.Exists(FileName) then
      TFile.Delete(FileName);
  except
    Exit;
  end;
  try
    Stream.SaveToFile(FileName);
  except
    //
  end;
end;

procedure TBitmapHelper.LoadFromUrlAsync(AOwner: TComponent; const Url: string; Cache: Boolean; OnDone: TProc<Boolean>);
begin
  if AOwner = nil then
    raise Exception.Create('You must specify an owner (responsible) who will ensure that the Bitmap is not destroyed before the owner');
  var Callback: TCallbackObject;
  Callback.Owner := AOwner;
  Callback.Bitmap := Self;
  Callback.Url := Url;
  Callback.OnDone := OnDone;
  Callback.Task := TTask.Create(
    procedure
    begin
      try
        var Mem: TMemoryStream;
        if not FindCached(Url, Mem) then
        begin
          Mem := Get(Url);
          if Cache and Assigned(Mem) then
            AddCache(Url, Mem);
        end;
        TThread.ForceQueue(nil,
          procedure
          begin
            Ready(Url, Mem);
          end);
      except
        TThread.ForceQueue(nil,
          procedure
          begin
            Ready(Url, nil);
          end);
      end;
    end, Pool);
  AddCallback(Callback);
  Callback.Task.Start;
end;

procedure TBitmapHelper.LoadFromUrlAsyncCF(AOwner: TComponent; const Url, CachedFileName: string; OnDone: TProc<Boolean>);
begin
  var Stream: TMemoryStream;
  if FindCachedFileName(CachedFileName, Stream) then
  try
    Stream.Position := 0;
    try
      LoadFromStream(Stream);
      if Assigned(OnDone) then
        OnDone(True);
      Exit;
    except
      // reload
    end;
  finally
    Stream.Free;
  end;
  if AOwner = nil then
    raise Exception.Create('You must specify an owner (responsible) who will ensure that the Bitmap is not destroyed before the owner');
  var Callback: TCallbackObject;
  Callback.Owner := AOwner;
  Callback.Bitmap := Self;
  Callback.Url := Url;
  Callback.OnDone := OnDone;
  Callback.Task := TTask.Create(
    procedure
    begin
      try
        var Mem := Get(Url);
        if Assigned(Mem) then
          AddCacheFileName(CachedFileName, Mem);
        TThread.ForceQueue(nil,
          procedure
          begin
            Ready(Url, Mem);
          end);
      except
        TThread.ForceQueue(nil,
          procedure
          begin
            Ready(Url, nil);
          end);
      end;
    end, Pool);
  AddCallback(Callback);
  Callback.Task.Start;
end;

procedure TBitmapHelper.LoadFromUrlAsyncCF(AOwner: TComponent; const Url: string; Cache: Boolean; OnDone: TProc<Boolean>);
begin
  if Url.IsEmpty then
  begin
    if Assigned(OnDone) then
      OnDone(False);
    Exit;
  end;
  var Stream: TMemoryStream;
  if FindCached(Url, Stream) then
  try
    Stream.Position := 0;
    try
      LoadFromStream(Stream);
      if Assigned(OnDone) then
        OnDone(True);
    except
      if Assigned(OnDone) then
        OnDone(False);
    end;
    Exit;
  finally
    Stream.Free;
  end;
  LoadFromUrlAsync(AOwner, Url, Cache, OnDone);
end;

class procedure TBitmapHelper.Ready(const Url: string; Stream: TStream);
begin
  try
    var List := FCallbackList.LockList;
    try
      for var i := List.Count - 1 downto 0 do
      begin
        var Item := List[i];
        if Item.Url <> Url then
          Continue;
        var Success: Boolean := False;
        try
          if Assigned(Stream) then
          try
            Stream.Position := 0;
            Item.Bitmap.LoadFromStream(Stream);
            Success := True;
          except
            //
          end;
        finally
          Item.Done(Success);
        end;
        List.Delete(i);
      end;
    finally
      FCallbackList.UnlockList;
    end;
  finally
    Stream.Free;
  end;
end;

class procedure TBitmapHelper.RemoveCallback(const AOwner: TComponent);
begin
  var List := FCallbackList.LockList;
  try
    for var i := List.Count - 1 downto 0 do
      if List[i].Owner = AOwner then
      begin
        List[i].Task.Cancel;
        List.Delete(i);
      end;
  finally
    FCallbackList.UnlockList;
  end;
end;

procedure TBitmapHelper.SaveToFile(const AFileName, Ext: string);
var
  Stream: TFileStream;
begin
  Stream := TFileStream.Create(AFileName, fmCreate);
  try
    SaveToStream(Stream, Ext);
  finally
    Stream.Free;
  end;
end;

procedure TBitmapHelper.SaveToStream(Stream: TStream; const Ext: string);
var
  Surf: TBitmapSurface;
begin
  TMonitor.Enter(Self);
  try
    Surf := TBitmapSurface.Create;
    try
      Surf.Assign(Self);
      if not TBitmapCodecManager.SaveToStream(Stream, Surf, Ext) then
        raise EBitmapSavingFailed.Create(SBitmapSavingFailed);
    finally
      Surf.Free;
    end;
  finally
    TMonitor.Exit(Self);
  end;
end;

class procedure TBitmapHelper.SetCachePath(const Value: string);
begin
  FCachePath := Value;
end;

class function TBitmapHelper.UrlToCacheName(const Url: string): string;
begin
  Result := THashMD5.GetHashString(Url);
end;

{ TObjectOwner }

procedure TObjectOwner.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if Operation <> TOperation.opRemove then
    Exit;
  var List := TBitmap.FCallbackList.LockList;
  try
    for var i := List.Count - 1 downto 0 do
      if List[i].Owner = AComponent then
      begin
        List[i].Task.Cancel;
        List.Delete(i);
      end;
  finally
    TBitmap.FCallbackList.UnlockList;
  end;
end;

{ TCallbackObject }

procedure TCallbackObject.Done(const Success: Boolean);
begin
  if Assigned(OnDone) then
  try
    OnDone(Success);
  except
    //
  end;
end;

initialization
  TBitmap.Pool := TThreadPool.Create;
  TBitmap.FCallbackList := TThreadList<TCallbackObject>.Create;
  TBitmap.FObjectOwner := TObjectOwner.Create(nil);
  TBitmap.FClient := nil;

finalization
  TBitmap.Pool.Free;
  TBitmap.FCallbackList.Free;
  TBitmap.FObjectOwner.Free;
  TBitmap.FClient.Free;

end.

