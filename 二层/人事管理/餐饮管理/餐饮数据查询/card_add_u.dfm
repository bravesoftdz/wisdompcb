object frm_card_add: Tfrm_card_add
  Left = 351
  Top = 262
  BorderIcons = [biMinimize]
  BorderStyle = bsSingle
  Caption = #34917#21345#31383#21475
  ClientHeight = 263
  ClientWidth = 409
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 16
    Top = 40
    Width = 57
    Height = 13
    AutoSize = False
    Caption = #21592#24037#24037#21495
  end
  object Label2: TLabel
    Left = 16
    Top = 72
    Width = 65
    Height = 13
    AutoSize = False
    Caption = #21592#24037#22995#21517
  end
  object Label3: TLabel
    Left = 109
    Top = 73
    Width = 84
    Height = 13
    Caption = #36873#20013#30340#21592#24037#22995#21517
  end
  object Label4: TLabel
    Left = 221
    Top = 73
    Width = 52
    Height = 13
    Caption = #21592#24037'ID'
    Visible = False
  end
  object Label5: TLabel
    Left = 277
    Top = 73
    Width = 72
    Height = 13
    Caption = #26159#21542#26412#21378'0'#25110'1'
    Visible = False
  end
  object Label6: TLabel
    Left = 16
    Top = 104
    Width = 57
    Height = 13
    AutoSize = False
    Caption = #34917#21345#26102#38388
  end
  object Label7: TLabel
    Left = 16
    Top = 136
    Width = 49
    Height = 13
    AutoSize = False
    Caption = #26426#22120#21495
  end
  object Label8: TLabel
    Left = 248
    Top = 136
    Width = 48
    Height = 13
    Caption = #26426#22120#22320#22336
    Visible = False
  end
  object Label9: TLabel
    Left = 328
    Top = 136
    Width = 24
    Height = 13
    Caption = #39184#21035
    Visible = False
  end
  object Label10: TLabel
    Left = 143
    Top = 17
    Width = 252
    Height = 13
    AutoSize = False
    Caption = '*'#38480#24403#21069#22312#32844#25110#20004#20010#26376#20869#31163#32844#21592#24037
    Color = clMenu
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
  end
  object Label11: TLabel
    Left = 232
    Top = 103
    Width = 169
    Height = 13
    AutoSize = False
    Caption = '*'#35831#36755#20837#20934#30830#30340#26085#26399#26102#38388
    Color = clMenu
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clMaroon
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentColor = False
    ParentFont = False
  end
  object Edit1: TEdit
    Left = 101
    Top = 34
    Width = 97
    Height = 21
    Enabled = False
    TabOrder = 0
  end
  object BitBtn1: TBitBtn
    Left = 200
    Top = 32
    Width = 25
    Height = 25
    TabOrder = 1
    OnClick = BitBtn1Click
    Glyph.Data = {
      76010000424D7601000000000000760000002800000020000000100000000100
      04000000000000010000120B0000120B00001000000000000000000000000000
      800000800000008080008000000080008000808000007F7F7F00BFBFBF000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333000000000
      333333777777777F33333330B00000003333337F7777777F3333333000000000
      333333777777777F333333330EEEEEE033333337FFFFFF7F3333333300000000
      333333377777777F3333333330BFBFB03333333373333373F33333330BFBFBFB
      03333337F33333F7F33333330FBFBF0F03333337F33337F7F33333330BFBFB0B
      03333337F3F3F7F7333333330F0F0F0033333337F7F7F773333333330B0B0B03
      3333333737F7F7F333333333300F0F03333333337737F7F33333333333300B03
      333333333377F7F33333333333330F03333333333337F7F33333333333330B03
      3333333333373733333333333333303333333333333373333333}
    NumGlyphs = 2
  end
  object MaskEdit1: TMaskEdit
    Left = 101
    Top = 96
    Width = 120
    Height = 21
    EditMask = '!9999/99/00 00:00:00;1;_'
    MaxLength = 19
    TabOrder = 2
    Text = '    -  -     :  :  '
  end
  object Edit2: TEdit
    Left = 101
    Top = 130
    Width = 97
    Height = 21
    Enabled = False
    TabOrder = 3
  end
  object BitBtn2: TBitBtn
    Tag = 1
    Left = 199
    Top = 128
    Width = 25
    Height = 25
    TabOrder = 4
    OnClick = BitBtn1Click
    Glyph.Data = {
      36060000424D3606000000000000360400002800000020000000100000000100
      08000000000000020000520B0000520B00000001000000000000000000003300
      00006600000099000000CC000000FF0000000033000033330000663300009933
      0000CC330000FF33000000660000336600006666000099660000CC660000FF66
      000000990000339900006699000099990000CC990000FF99000000CC000033CC
      000066CC000099CC0000CCCC0000FFCC000000FF000033FF000066FF000099FF
      0000CCFF0000FFFF000000003300330033006600330099003300CC003300FF00
      330000333300333333006633330099333300CC333300FF333300006633003366
      33006666330099663300CC663300FF6633000099330033993300669933009999
      3300CC993300FF99330000CC330033CC330066CC330099CC3300CCCC3300FFCC
      330000FF330033FF330066FF330099FF3300CCFF3300FFFF3300000066003300
      66006600660099006600CC006600FF0066000033660033336600663366009933
      6600CC336600FF33660000666600336666006666660099666600CC666600FF66
      660000996600339966006699660099996600CC996600FF99660000CC660033CC
      660066CC660099CC6600CCCC6600FFCC660000FF660033FF660066FF660099FF
      6600CCFF6600FFFF660000009900330099006600990099009900CC009900FF00
      990000339900333399006633990099339900CC339900FF339900006699003366
      99006666990099669900CC669900FF6699000099990033999900669999009999
      9900CC999900FF99990000CC990033CC990066CC990099CC9900CCCC9900FFCC
      990000FF990033FF990066FF990099FF9900CCFF9900FFFF99000000CC003300
      CC006600CC009900CC00CC00CC00FF00CC000033CC003333CC006633CC009933
      CC00CC33CC00FF33CC000066CC003366CC006666CC009966CC00CC66CC00FF66
      CC000099CC003399CC006699CC009999CC00CC99CC00FF99CC0000CCCC0033CC
      CC0066CCCC0099CCCC00CCCCCC00FFCCCC0000FFCC0033FFCC0066FFCC0099FF
      CC00CCFFCC00FFFFCC000000FF003300FF006600FF009900FF00CC00FF00FF00
      FF000033FF003333FF006633FF009933FF00CC33FF00FF33FF000066FF003366
      FF006666FF009966FF00CC66FF00FF66FF000099FF003399FF006699FF009999
      FF00CC99FF00FF99FF0000CCFF0033CCFF0066CCFF0099CCFF00CCCCFF00FFCC
      FF0000FFFF0033FFFF0066FFFF0099FFFF00CCFFFF00FFFFFF00000080000080
      000000808000800000008000800080800000C0C0C00080808000191919004C4C
      4C00B2B2B200E5E5E5005A1E1E00783C3C0096646400C8969600FFC8C800465F
      82005591B9006EB9D7008CD2E600B4E6F000D8E9EC0099A8AC00646F7100E2EF
      F100C56A31000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000EEEEEEEEEEEE
      EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
      EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE0000000000EE
      EEEEEEEE0000000000EE8181818181EEEEEEEEEE8181818181EE00DF2B2B00EE
      EEEEEEEE00DF2B2B00EE81ACE2E281EEEEEEEEEE81ACE2E281EE00DF2B2B00EE
      EEEEEEEE00DF2B2B00EE81ACE2E281EEEEEEEEEE81ACE2E281EE000000000000
      00D700000000000000EE81818181818181D781818181818181EE00DF2B2B002B
      002B00DF002B2B2B00EE81ACE2E281E281E281AC81E2E2E281EE00DF2B2B002B
      00EE00DF002B2B2B00EE81ACE2E281E281EE81AC81E2E2E281EE00DF2B2B002B
      00EE00DF002B2B2B00EE81ACE2E281E281EE81AC81E2E2E281EEEE0000000000
      002B000000000000EEEEEE818181818181E2818181818181EEEEEEEE00DF2B2B
      00D700DF002B00EEEEEEEEEE81ACE2E281D781AC81E281EEEEEEEEEE00000000
      00EE0000000000EEEEEEEEEE8181818181EE8181818181EEEEEEEEEEEE002B00
      EEEEEE002B00EEEEEEEEEEEEEE81E281EEEEEE81E281EEEEEEEEEEEEEEDFD700
      EEEEEEDFD700EEEEEEEEEEEEEEACD781EEEEEEACD781EEEEEEEEEEEEEE2B2B2B
      EEEEEE2B2B2BEEEEEEEEEEEEEEE2E2E2EEEEEEE2E2E2EEEEEEEEEEEEEEEEEEEE
      EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE}
    NumGlyphs = 2
  end
  object Button1: TButton
    Left = 48
    Top = 176
    Width = 75
    Height = 25
    Caption = #30830#23450
    TabOrder = 5
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 256
    Top = 176
    Width = 75
    Height = 25
    Caption = #21462#28040
    ModalResult = 2
    TabOrder = 6
    OnClick = Button2Click
  end
  object CheckBox1: TCheckBox
    Left = 48
    Top = 224
    Width = 345
    Height = 17
    Caption = #34917#21345#28155#21152#23436#25104#21518#33258#21160#26174#31034#34917#21345#35760#24405
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
    TabOrder = 7
  end
end
