object Form8: TForm8
  Left = 0
  Top = 0
  Caption = 'Form8'
  ClientHeight = 615
  ClientWidth = 889
  Color = clSilver
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  TextHeight = 13
  object hLink2: ThLink
    Left = 600
    Top = 191
    Width = 35
    Height = 15
    Cursor = crHandPoint
    Caption = 'hLink2'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 14194235
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object hLink1: ThLink
    Left = 600
    Top = 224
    Width = 35
    Height = 15
    Cursor = crHandPoint
    Caption = 'hLink2'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = 14194235
    Font.Height = -12
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
  end
  object hLabelEx4: ThLabelEx
    Left = 680
    Top = 176
    Width = 90
    Height = 30
    Brush.Color = 10053222
    Pen.Color = 6044989
    Caption = ''
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    TextFormat = [tfCenter, tfSingleLine, tfVerticalCenter, tfWordBreak, tfWordEllipsis]
    IgnorBounds = True
    EllipseRectVertical = False
  end
  object ProgressBar1: TProgressBar
    Left = 88
    Top = 115
    Width = 150
    Height = 17
    TabOrder = 0
  end
  object hProgrsssBar1: ThProgrsssBar
    Left = 0
    Top = 0
    Width = 889
    Height = 33
    Align = alTop
    DoubleBuffered = True
    ColorScale = 10711881
    ColorBackground = 2102799
    ParentBackground = False
    Position = 25
    ParentColor = True
    Kind = pbkRoundRect
    RoundRadius = 15
    ExplicitWidth = 617
  end
  object TrackBar1: TTrackBar
    Left = 309
    Top = 112
    Width = 300
    Height = 45
    Max = 100
    Position = 1
    TabOrder = 2
    OnChange = TrackBar1Change
  end
  object Panel1: TPanel
    Left = 8
    Top = 147
    Width = 185
    Height = 41
    Caption = 'Panel1'
    TabOrder = 3
  end
  object hTrackbar1: ThTrackbar
    AlignWithMargins = True
    Left = 3
    Top = 36
    Width = 883
    Height = 29
    Align = alTop
    Position = 6.560000000000000000
    SecondPosition = 20.000000000000000000
    OnChange = hTrackbar1Change
    Color = 6901811
    ParentColor = False
    HotScroll = True
    ExplicitWidth = 611
  end
  object hColorGrid1: ThColorGrid
    Left = 320
    Top = 192
    Width = 100
    Height = 100
    BorderStyle = bsNone
    DoubleBuffered = True
    ParentDoubleBuffered = False
    TabOrder = 5
  end
  object EditEx1: TEditEx
    Left = 8
    Top = 194
    Width = 185
    Height = 23
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    AutoSelect = True
    TabOrder = 6
    ReadOnly = False
    Color = 8736536
    Text = '  .  .    '
    Mode = emDate
    ShowClearButton = True
    ShowEditButton = True
    NumberOnly = False
  end
  object ButtonFlat1: TButtonFlat
    Left = 472
    Top = 176
    Width = 90
    Height = 30
    Caption = #1050#1085#1086#1087#1082#1072
    ColorNormal = 14668740
    ColorOver = 11373924
    ColorPressed = 10451273
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    FontOver.Charset = DEFAULT_CHARSET
    FontOver.Color = clWindowText
    FontOver.Height = -13
    FontOver.Name = 'Segoe UI'
    FontOver.Style = []
    FontDown.Charset = DEFAULT_CHARSET
    FontDown.Color = clWindowText
    FontDown.Height = -13
    FontDown.Name = 'Segoe UI'
    FontDown.Style = []
    IgnorBounds = True
    RoundRectParam = 0
    ShowFocusRect = False
    TabOrder = 7
    TabStop = True
    TextFormat = [tfCenter, tfSingleLine, tfVerticalCenter]
    SubTextFont.Charset = DEFAULT_CHARSET
    SubTextFont.Color = clWhite
    SubTextFont.Height = -13
    SubTextFont.Name = 'Segoe UI'
    SubTextFont.Style = []
  end
  object CheckBoxFlat1: TCheckBoxFlat
    Left = 472
    Top = 224
    Width = 90
    Height = 30
    Caption = #1050#1085#1086#1087#1082#1072
    ColorNormal = 14668740
    ColorOver = 11373924
    ColorPressed = 10451273
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    FontOver.Charset = DEFAULT_CHARSET
    FontOver.Color = clWindowText
    FontOver.Height = -13
    FontOver.Name = 'Segoe UI'
    FontOver.Style = []
    FontDown.Charset = DEFAULT_CHARSET
    FontDown.Color = clWindowText
    FontDown.Height = -13
    FontDown.Name = 'Segoe UI'
    FontDown.Style = []
    IgnorBounds = True
    RoundRectParam = 0
    ShowFocusRect = False
    TabOrder = 8
    TabStop = True
    TextFormat = [tfCenter, tfSingleLine, tfVerticalCenter]
    SubTextFont.Charset = DEFAULT_CHARSET
    SubTextFont.Color = clWhite
    SubTextFont.Height = -13
    SubTextFont.Name = 'Segoe UI'
    SubTextFont.Style = []
  end
  object EditPanel1: TEditPanel
    Left = 8
    Top = 328
    Width = 420
    Height = 41
    Alignment = taLeftJustify
    BevelOuter = bvNone
    Caption = #1047#1072#1075#1086#1083#1086#1074#1086#1082
    Color = clWhite
    ParentBackground = False
    ShowCaption = False
    TabOrder = 10
    VerticalAlignment = tlCenter
    EnterColor = 9824250
    LeaveColor = clWhite
    EditWidth = 200
    LebelWidth = 200
    LabelFont.Charset = DEFAULT_CHARSET
    LabelFont.Color = clGray
    LabelFont.Height = -12
    LabelFont.Name = 'Segoe UI'
    LabelFont.Style = []
    EditFont.Charset = DEFAULT_CHARSET
    EditFont.Color = clWindowText
    EditFont.Height = -11
    EditFont.Name = 'Tahoma'
    EditFont.Style = []
    Text = ''
    ErrorColor = 13260
  end
  object EditPanel2: TEditPanel
    Left = 8
    Top = 375
    Width = 420
    Height = 41
    Alignment = taLeftJustify
    BevelOuter = bvNone
    Caption = #1047#1072#1075#1086#1083#1086#1074#1086#1082
    Color = clWhite
    ParentBackground = False
    ShowCaption = False
    TabOrder = 11
    VerticalAlignment = tlCenter
    EnterColor = 9824250
    LeaveColor = clWhite
    EditWidth = 200
    LebelWidth = 200
    LabelFont.Charset = DEFAULT_CHARSET
    LabelFont.Color = clGray
    LabelFont.Height = -12
    LabelFont.Name = 'Segoe UI'
    LabelFont.Style = []
    EditFont.Charset = DEFAULT_CHARSET
    EditFont.Color = clWindowText
    EditFont.Height = -11
    EditFont.Name = 'Tahoma'
    EditFont.Style = []
    Text = ''
    ErrorColor = 13260
  end
  object ListBoxEx1: TListBoxEx
    Left = 8
    Top = 422
    Width = 159
    Height = 129
    TabOrder = 12
    ItemIndex = -1
  end
  object PanelCollapsed1: TPanelCollapsed
    Left = 472
    Top = 272
    Width = 185
    Height = 300
    Caption = ' Caption'
    DefaultPaint = False
    Alignment = taLeftJustify
    BevelOuter = bvNone
    ParentBackground = False
    ShowCaption = True
    TabOrder = 13
    ShowCollapseButton = True
    Collapsed = False
    SimpleBorderColor = clSilver
    CaptionColor = clGray
    FontCaption.Charset = DEFAULT_CHARSET
    FontCaption.Color = clWhite
    FontCaption.Height = -13
    FontCaption.Name = 'Segoe UI'
    FontCaption.Style = [fsBold]
    ShowSimpleBorder = False
    CaptionHeight = 30
  end
  object hSpinEdit1: ThSpinEdit
    Left = 184
    Top = 432
    Width = 121
    Height = 21
    MaxValue = 0
    MinValue = 0
    TabOrder = 14
    Value = 0
    LightButtons = False
  end
  object hTrue1: ThTrue
    Left = 104
    Top = 224
  end
  object NotifyWindow1: TNotifyWindow
    FontCaption.Charset = DEFAULT_CHARSET
    FontCaption.Color = clWindowText
    FontCaption.Height = -16
    FontCaption.Name = 'Segoe UI'
    FontCaption.Style = []
    FontText.Charset = DEFAULT_CHARSET
    FontText.Color = clWindowText
    FontText.Height = -12
    FontText.Name = 'Segoe UI'
    FontText.Style = []
    Left = 472
    Top = 272
  end
  object NotifyPanel1: TNotifyPanel
    FontCaption.Charset = DEFAULT_CHARSET
    FontCaption.Color = clWindowText
    FontCaption.Height = -16
    FontCaption.Name = 'Tahoma'
    FontCaption.Style = []
    FontText.Charset = DEFAULT_CHARSET
    FontText.Color = clWindowText
    FontText.Height = -12
    FontText.Name = 'Tahoma'
    FontText.Style = []
    OwnerForm = Owner
    Left = 192
    Top = 240
  end
  object hTrue2: ThTrue
    Left = 384
    Top = 432
  end
end
