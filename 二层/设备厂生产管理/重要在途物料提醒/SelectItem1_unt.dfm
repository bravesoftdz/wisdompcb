object SelectItem1_frm: TSelectItem1_frm
  Left = 557
  Top = 230
  Width = 360
  Height = 250
  BorderIcons = [biSystemMenu]
  Caption = 'SelectItem1_frm'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnCreate = FormCreate
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnl2: TPanel
    Left = 0
    Top = 25
    Width = 352
    Height = 191
    Align = alClient
    BevelOuter = bvNone
    Caption = 'pnl2'
    TabOrder = 0
    object Button1: TButton
      Left = 325
      Top = 208
      Width = 75
      Height = 25
      Caption = 'Button1'
      ModalResult = 1
      TabOrder = 0
      Visible = False
    end
    object dgh1: TDBGridEh
      Left = 0
      Top = 0
      Width = 352
      Height = 191
      Align = alClient
      DataSource = ds1
      FooterColor = clWindow
      FooterFont.Charset = DEFAULT_CHARSET
      FooterFont.Color = clWindowText
      FooterFont.Height = -11
      FooterFont.Name = 'MS Sans Serif'
      FooterFont.Style = []
      PopupMenu = PopupMenu1
      TabOrder = 1
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -11
      TitleFont.Name = 'MS Sans Serif'
      TitleFont.Style = []
      OnDblClick = dgh1DblClick
      OnDrawColumnCell = dgh1DrawColumnCell
      OnGetCellParams = dgh1GetCellParams
      OnKeyDown = dgh1KeyDown
      OnKeyPress = dgh1KeyPress
      OnTitleClick = dgh1TitleClick
    end
  end
  object pnl1: TPanel
    Left = 0
    Top = 0
    Width = 352
    Height = 25
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 1
    object bt1: TSpeedButton
      Left = 236
      Top = 1
      Width = 24
      Height = 22
      Hint = #21462#28040#36755#20837
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF005656560056565600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF005656
        560092DC00007AB9000026262600FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF003E3E
        3E007AB90000AAFF25007AB9000026262600FFFFFF00FFFFFF00FFFFFF000000
        0000000000000000000000000000000000000000000056565600FFFFFF00FFFF
        FF003E3E3E0062960000AAFF25006296000056565600FFFFFF00FFFFFF003E3E
        3E007AB900007AB90000629600006296000056565600FFFFFF00FFFFFF00FFFF
        FF00FFFFFF005656560092DC000092DC000056565600FFFFFF00FFFFFF003E3E
        3E00C6FF6B008FFF6B007AB900006E6E6E00B6B6B600FFFFFF00FFFFFF00FFFF
        FF00FFFFFF007A7A7A007AB90000AAFF250026262600FFFFFF00FFFFFF003E3E
        3E00D4FF8E00ABFF8E00B8FF48006296000056565600FFFFFF00FFFFFF00FFFF
        FF00FFFFFF007A7A7A007AB90000D4FF8E0026262600FFFFFF00FFFFFF003E3E
        3E00E2FFB100AAAAAA0092DC0000AAFF25006296000056565600FFFFFF00FFFF
        FF00FFFFFF00565656007AB90000AAFF250026262600FFFFFF00FFFFFF005656
        560056565600B6B6B6005656560092DC0000D4FF8E0062960000565656003E3E
        3E003E3E3E006296000092DC000092DC000056565600FFFFFF00FFFFFF005656
        5600FFFFFF00FFFFFF00FFFFFF00565656007AB90000D4FF8E007AB900007AB9
        00007AB900007AB9000092DC0000629600007A7A7A00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00565656007AB9000092DC0000AAFF
        2500AAFF2500AAFF25007AB9000056565600FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF007A7A7A00565656005656
        560056565600565656007A7A7A00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFF
        FF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00FFFFFF00}
      ParentShowHint = False
      ShowHint = True
      OnClick = bt1Click
    end
    object Label1: TLabel
      Left = 76
      Top = 6
      Width = 32
      Height = 13
      Caption = 'Label1'
    end
    object SpeedButton1: TSpeedButton
      Left = 1
      Top = 1
      Width = 24
      Height = 22
      Hint = #21047#26032#33719#21462#26368#26032#25968#25454
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        1800000000000003000000000000000000000000000000000000FF00FFFF00FF
        CEB5A56B42316B42316B42316B42316B42316B42316B42316B42316B42316B42
        316B42316B4231FF00FFFF00FFFF00FFCEB5A5EFE7E7B5A594B5A594B5A594B5
        A594B5A594B5A594B5A594B5A594B5A594B5A5946B4231FF00FFFF00FFFF00FF
        CEB5A5F7EFE7EFE7E7EFE7DEEFDEDEE7DED6E7D6CEE7D6CEDECEC6DECEBDDECE
        BDB5A5946B4231FF00FFFF00FFFF00FFCEB5A5F7EFEFF7EFE7009C00EFE7DE42
        B53942B53973C66BE7D6CEDECEC6DECEBDB5A5946B4231FF00FFFF00FFFF00FF
        CEB5A5F7F7F7F7EFEF009C00009C00009C00009C00009C0073C66BE7D6CEDECE
        C6B5A5946B4231FF00FFFF00FFFF00FFCEB5A5FFF7F7F7F7F7009C004ACE8400
        9C00EFE7DEEFDEDE009C0073C66BE7D6CEB5A5946B4231FF00FFFF00FFFF00FF
        CEB5A5FFFFFFFFF7F7009C00009C00009C00009C00EFE7DEEFDEDE009C00E7D6
        CEB5A5946B4231FF00FFFF00FFFF00FFCEB5A5FFFFFFFFFFFFFFF7F7F7F7F7F7
        EFEFF7EFE7EFE7E7EFE7DEEFDEDEE7DED6B5A5946B4231FF00FFFF00FFFF00FF
        CEB5A5FFFFFF009C00FFFFFFFFFFFF009C00009C00009C00009C00EFE7DEEFE7
        DEB5A5946B4231FF00FFFF00FFFF00FFCEB5A5FFFFFFBDDEB5009C00FFFFFFFF
        FFFF009C004ACE84009C00EFEFE7EFE7DEB5A5946B4231FF00FFFF00FFFF00FF
        CEB5A5FFFFFFFFFFFFBDDEB5009C00009C00009C00009C00009C00F7EFEFD6BD
        B5B5A5946B4231FF00FFFF00FFFF00FFCEB5A5FFFFFFFFFFFFFFFFFFBDDEB542
        B53942B539FFFFFF009C00CEB5A56B42316B42316B4231FF00FFFF00FFFF00FF
        CEB5A5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCEB5A5F7EF
        E7DECEBD6B4231FF00FFFF00FFFF00FFCEB5A5FFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFCEB5A5DECEBD6B4231FF00FFFF00FFFF00FFFF00FF
        CEB5A5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCEB5A56B42
        31FF00FFFF00FFFF00FFFF00FFFF00FFCEB5A5CEB5A5CEB5A5CEB5A5CEB5A5CE
        B5A5CEB5A5CEB5A5CEB5A5CEB5A5FF00FFFF00FFFF00FFFF00FF}
      ParentShowHint = False
      ShowHint = True
      OnClick = SpeedButton1Click
    end
    object Edit1: TEdit
      Left = 112
      Top = 2
      Width = 122
      Height = 21
      TabOrder = 0
      OnChange = Edit1Change
      OnKeyDown = Edit1KeyDown
      OnKeyPress = Edit1KeyPress
    end
    object CheckBox2: TCheckBox
      Left = 280
      Top = 5
      Width = 97
      Height = 17
      Caption = #31934#30830#26597#25214
      TabOrder = 1
      OnClick = CheckBox2Click
    end
  end
  object ds1: TDataSource
    Left = 136
    Top = 97
  end
  object PopupMenu1: TPopupMenu
    Left = 216
    Top = 80
    object N1: TMenuItem
      Caption = #21024#38500
      OnClick = N1Click
    end
  end
end
