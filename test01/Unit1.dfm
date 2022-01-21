object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'FFVideo v2.0'
  ClientHeight = 574
  ClientWidth = 1184
  Color = clBtnFace
  DoubleBuffered = True
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Position = poScreenCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  DesignSize = (
    1184
    574)
  TextHeight = 13
  object grpVideoInput: TGroupBox
    Left = 8
    Top = 8
    Width = 416
    Height = 209
    Caption = '1'#12289#35270#39057#36755#20837#21015#34920#65306
    TabOrder = 0
    DesignSize = (
      416
      209)
    object lstVideoInput: TListBox
      Left = 3
      Top = 20
      Width = 405
      Height = 177
      Anchors = [akLeft, akTop, akRight, akBottom]
      ItemHeight = 13
      TabOrder = 0
      OnClick = lvVideoInputClick
    end
  end
  object grpVideoFormat: TGroupBox
    Left = 8
    Top = 228
    Width = 416
    Height = 338
    Anchors = [akLeft, akTop, akBottom]
    Caption = '2'#12289#35270#39057#26684#24335#21015#34920#65306
    TabOrder = 1
    DesignSize = (
      416
      338)
    object lstVideoFormat: TListBox
      Left = 12
      Top = 20
      Width = 392
      Height = 306
      Anchors = [akLeft, akTop, akRight, akBottom]
      Font.Charset = GB2312_CHARSET
      Font.Color = clBlack
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = []
      ItemHeight = 13
      ParentFont = False
      PopupMenu = pmVideoPreview
      TabOrder = 0
      OnClick = lstVideoFormatClick
      OnDblClick = btnPreviewClick
    end
  end
  object grp1: TGroupBox
    Left = 430
    Top = 8
    Width = 746
    Height = 558
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = '3'#12289#39044#35272#12289#25130#22270#12289'MP4'#32534#30721#12289#25512#27969#65306
    TabOrder = 2
    DesignSize = (
      746
      558)
    object imgSnap: TImage
      Left = 566
      Top = 113
      Width = 170
      Height = 145
      Anchors = [akTop, akRight]
      Picture.Data = {
        07544269746D6170F2010000424DF20100000000000036000000280000000100
        00006F0000000100180000000000BC0100000000000000000000000000000000
        0000FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00}
      Stretch = True
      ExplicitLeft = 642
    end
    object lbl2: TLabel
      Left = 566
      Top = 428
      Width = 60
      Height = 13
      Anchors = [akTop, akRight]
      Caption = #25512#27969#22320#22336#65306
    end
    object lbl1: TLabel
      Left = 566
      Top = 342
      Width = 107
      Height = 13
      Anchors = [akTop, akRight]
      Caption = 'MP4 '#25991#20214#20445#23384#36335#24452#65306
    end
    object lbl3: TLabel
      Left = 566
      Top = 270
      Width = 131
      Height = 13
      Anchors = [akTop, akRight]
      Caption = 'MP4 '#30828#20214#21152#36895#32534#30721#31867#22411#65306
    end
    object pnlVideo: TPanel
      Left = 13
      Top = 20
      Width = 544
      Height = 526
      Anchors = [akLeft, akTop, akRight, akBottom]
      BevelOuter = bvNone
      BorderStyle = bsSingle
      Caption = 'pnlVideo'
      Color = clWhite
      Ctl3D = False
      DoubleBuffered = True
      ParentBackground = False
      ParentCtl3D = False
      ParentDoubleBuffered = False
      ShowCaption = False
      TabOrder = 0
    end
    object btnPreview: TButton
      Left = 566
      Top = 18
      Width = 170
      Height = 38
      Anchors = [akTop, akRight]
      Caption = #24320#22987
      Enabled = False
      TabOrder = 1
      OnClick = btnPreviewClick
    end
    object btnSnap: TButton
      Left = 566
      Top = 62
      Width = 170
      Height = 38
      Anchors = [akTop, akRight]
      Caption = #25130#22270
      Enabled = False
      TabOrder = 2
      OnClick = btnSnapClick
    end
    object edtLive: TEdit
      Left = 566
      Top = 447
      Width = 167
      Height = 21
      Anchors = [akTop, akRight]
      TabOrder = 3
      Text = 'rtmp://localhost:1935/live'
    end
    object edtSavePath: TEdit
      Left = 566
      Top = 361
      Width = 167
      Height = 21
      Anchors = [akTop, akRight]
      Enabled = False
      TabOrder = 4
      Text = 'D:\'
    end
    object chkLive: TCheckBox
      Left = 566
      Top = 474
      Width = 97
      Height = 17
      Anchors = [akTop, akRight]
      Caption = #25512#27969
      Enabled = False
      TabOrder = 5
      OnClick = chkLiveClick
    end
    object chkMP4Record: TCheckBox
      Left = 566
      Top = 388
      Width = 97
      Height = 17
      Anchors = [akTop, akRight]
      Caption = 'MP4 '#32534#30721
      Enabled = False
      TabOrder = 6
      OnClick = chkMP4RecordClick
    end
    object cbbHardAccel: TComboBox
      Left = 566
      Top = 292
      Width = 145
      Height = 21
      Style = csDropDownList
      Anchors = [akTop, akRight]
      Enabled = False
      ItemIndex = 0
      TabOrder = 7
      Text = #26080#30828#20214#21152#36895
      Items.Strings = (
        #26080#30828#20214#21152#36895
        'Intel '#35270#39057#21345#30828#20214#21152#36895
        'Nvidia '#35270#39057#21345#30828#20214#21152#36895)
    end
  end
  object pmVideoPreview: TPopupMenu
    AutoHotkeys = maManual
    Left = 92
    Top = 336
    object mniVideoPrevideo: TMenuItem
      Caption = #35270#39057#39044#35272
      OnClick = btnPreviewClick
    end
  end
end
