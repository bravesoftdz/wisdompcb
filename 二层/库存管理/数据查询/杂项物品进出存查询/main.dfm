object Form1: TForm1
  Left = 415
  Top = 288
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #26434#39033#29289#21697#36827#20986#23384#26597#35810
  ClientHeight = 324
  ClientWidth = 636
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label19: TLabel
    Left = 547
    Top = 264
    Width = 49
    Height = 13
    Caption = 'Label19'
    Visible = False
  end
  object Label20: TLabel
    Left = 542
    Top = 279
    Width = 49
    Height = 13
    Caption = 'Label20'
    Visible = False
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 90
    Width = 281
    Height = 204
    Caption = #29289#21697#20837#20179#26126#32454
    TabOrder = 3
    object Label1: TLabel
      Left = 106
      Top = 30
      Width = 52
      Height = 13
      Caption = #20837#20179#21333#21495
    end
    object Label4: TLabel
      Left = 109
      Top = 29
      Width = 52
      Height = 13
      Caption = #36215#22987#26085#26399
      Visible = False
    end
    object Label5: TLabel
      Left = 107
      Top = 75
      Width = 52
      Height = 13
      Caption = #32456#27490#26085#26399
      Visible = False
    end
    object StaticText1: TStaticText
      Left = 8
      Top = 21
      Width = 89
      Height = 17
      Alignment = taCenter
      AutoSize = False
      BevelInner = bvLowered
      BevelOuter = bvNone
      Caption = #26465#20214#39033#30446
      Color = clGrayText
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindow
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      TabOrder = 0
    end
    object ListBox1: TListBox
      Left = 8
      Top = 38
      Width = 89
      Height = 157
      ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
      ItemHeight = 13
      Items.Strings = (
        #20837#20179#21333#21495
        #29289#21697#21517#31216
        #29289#21697#35268#26684
        #29289#21697#31867#21035
        #25910#36135#26085#26399
        #20379#24212#21830
        #20837#20179#20154#21592
        #37319#36141#35746#21333#21495
        #24037#21378
        #29615#20445#26631#35782)
      TabOrder = 2
      OnClick = ListBox1Click
    end
    object Edit1: TEdit
      Left = 104
      Top = 47
      Width = 137
      Height = 21
      TabOrder = 4
      OnKeyUp = Edit1KeyUp
    end
    object BitBtn1: TBitBtn
      Left = 248
      Top = 45
      Width = 25
      Height = 25
      TabOrder = 3
      Visible = False
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
    object BitBtn2: TBitBtn
      Left = 131
      Top = 160
      Width = 89
      Height = 25
      Caption = #22686#21152
      TabOrder = 8
      OnClick = BitBtn2Click
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF0080000000FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF0080000000FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF008000000080000000FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00800000008000000080000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00800000008000000080000000800000008000
        0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00800000008000000080000000800000008000
        0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00800000008000000080000000800000008000
        0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF0080000000800000008000000080000000FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF008000000080000000FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF0080000000FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF0080000000FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
    end
    object dtpk1: TDateTimePicker
      Left = 167
      Top = 23
      Width = 98
      Height = 21
      Date = 38901.459449317130000000
      Time = 38901.459449317130000000
      ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
      TabOrder = 1
      Visible = False
    end
    object dtpk2: TDateTimePicker
      Left = 167
      Top = 70
      Width = 98
      Height = 21
      Date = 38901.461032615740000000
      Time = 38901.461032615740000000
      ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
      TabOrder = 6
      Visible = False
    end
    object ComboBox1: TComboBox
      Left = 105
      Top = 47
      Width = 137
      Height = 21
      ItemHeight = 13
      TabOrder = 5
      Visible = False
      OnChange = ComboBox1Change
    end
    object RadioGroup4: TRadioGroup
      Left = 104
      Top = 88
      Width = 137
      Height = 63
      ItemIndex = 0
      Items.Strings = (
        #30456#20284' like'
        #31561#20110' =')
      TabOrder = 7
    end
  end
  object GroupBox2: TGroupBox
    Left = 8
    Top = 90
    Width = 281
    Height = 204
    Caption = #29289#21697#20986#20179#26126#32454
    TabOrder = 4
    object Label2: TLabel
      Left = 108
      Top = 33
      Width = 52
      Height = 13
      Caption = #20986#20179#21333#21495
    end
    object Label6: TLabel
      Left = 109
      Top = 32
      Width = 52
      Height = 13
      Caption = #36215#22987#26085#26399
      Visible = False
    end
    object Label7: TLabel
      Left = 107
      Top = 78
      Width = 52
      Height = 13
      Caption = #32456#27490#26085#26399
      Visible = False
    end
    object ListBox2: TListBox
      Left = 8
      Top = 38
      Width = 89
      Height = 157
      ItemHeight = 13
      Items.Strings = (
        #20986#20179#21333#21495
        #29289#21697#21517#31216
        #29289#21697#35268#26684
        #29289#21697#31867#21035
        #39046#29992#37096#38376
        #39046#29992#26085#26399
        #39046#26009#20154#21592
        #24037#21378
        #29615#20445#26631#35782
        #39046#26009#21333#21495
        #29983#20135#21333#21495)
      TabOrder = 2
      OnClick = ListBox2Click
    end
    object StaticText3: TStaticText
      Left = 8
      Top = 21
      Width = 89
      Height = 17
      Alignment = taCenter
      AutoSize = False
      BevelInner = bvLowered
      BevelOuter = bvNone
      Caption = #26465#20214#39033#30446
      Color = clGrayText
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindow
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      TabOrder = 0
    end
    object Edit2: TEdit
      Left = 107
      Top = 51
      Width = 137
      Height = 21
      TabOrder = 5
      OnKeyUp = Edit2KeyUp
    end
    object BitBtn7: TBitBtn
      Left = 248
      Top = 48
      Width = 25
      Height = 25
      TabOrder = 3
      Visible = False
      OnClick = BitBtn7Click
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
    object BitBtn8: TBitBtn
      Left = 132
      Top = 160
      Width = 89
      Height = 25
      Caption = #22686#21152
      TabOrder = 8
      OnClick = BitBtn8Click
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF0080000000FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF0080000000FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF008000000080000000FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00800000008000000080000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00800000008000000080000000800000008000
        0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00800000008000000080000000800000008000
        0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00800000008000000080000000800000008000
        0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF0080000000800000008000000080000000FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF008000000080000000FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF0080000000FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF0080000000FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
    end
    object dtpk3: TDateTimePicker
      Left = 168
      Top = 30
      Width = 98
      Height = 21
      Date = 38901.459449317130000000
      Time = 38901.459449317130000000
      ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
      TabOrder = 1
      Visible = False
    end
    object dtpk4: TDateTimePicker
      Left = 167
      Top = 73
      Width = 98
      Height = 21
      Date = 38901.461032615740000000
      Time = 38901.461032615740000000
      ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
      TabOrder = 6
      Visible = False
    end
    object ComboBox2: TComboBox
      Left = 107
      Top = 51
      Width = 137
      Height = 21
      ItemHeight = 13
      TabOrder = 4
      Visible = False
      OnChange = ComboBox2Change
    end
    object RadioGroup3: TRadioGroup
      Left = 104
      Top = 88
      Width = 137
      Height = 63
      ItemIndex = 0
      Items.Strings = (
        #30456#20284' like'
        #31561#20110' =')
      TabOrder = 7
    end
  end
  object GroupBox3: TGroupBox
    Left = 8
    Top = 90
    Width = 281
    Height = 204
    Caption = #24403#21069#24211#23384#29366#20917
    TabOrder = 5
    object Label3: TLabel
      Left = 106
      Top = 36
      Width = 52
      Height = 13
      Caption = #29289#21697#21517#31216
    end
    object ComboBox3: TComboBox
      Left = 105
      Top = 56
      Width = 137
      Height = 21
      ItemHeight = 13
      TabOrder = 4
      Visible = False
      OnChange = ComboBox3Change
    end
    object StaticText4: TStaticText
      Left = 8
      Top = 21
      Width = 89
      Height = 17
      Alignment = taCenter
      AutoSize = False
      BevelInner = bvLowered
      BevelOuter = bvNone
      Caption = #26465#20214#39033#30446
      Color = clGrayText
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindow
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      TabOrder = 0
    end
    object ListBox3: TListBox
      Left = 8
      Top = 38
      Width = 89
      Height = 157
      ItemHeight = 13
      Items.Strings = (
        #29289#21697#21517#31216
        #29289#21697#31867#21035
        #29289#21697#35268#26684
        #24037#21378
        #20379#24212#21830
        #37319#36141#35746#21333
        #20179#24211#20195#30721)
      TabOrder = 1
      OnClick = ListBox3Click
    end
    object Edit3: TEdit
      Left = 104
      Top = 56
      Width = 137
      Height = 21
      TabOrder = 3
      OnKeyUp = Edit3KeyUp
    end
    object BitBtn9: TBitBtn
      Left = 248
      Top = 54
      Width = 25
      Height = 25
      TabOrder = 2
      OnClick = BitBtn9Click
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
    object BitBtn10: TBitBtn
      Left = 130
      Top = 160
      Width = 89
      Height = 26
      Caption = #22686#21152
      TabOrder = 6
      OnClick = BitBtn10Click
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF0080000000FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF0080000000FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF008000000080000000FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00800000008000000080000000FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00800000008000000080000000800000008000
        0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00800000008000000080000000800000008000
        0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00800000008000000080000000800000008000
        0000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF0080000000800000008000000080000000FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF008000000080000000FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF0080000000FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF0080000000FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
        FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
    end
    object RadioGroup2: TRadioGroup
      Left = 104
      Top = 88
      Width = 137
      Height = 63
      ItemIndex = 0
      Items.Strings = (
        #30456#20284' like'
        #31561#20110' =')
      TabOrder = 5
    end
  end
  object RadioGroup1: TRadioGroup
    Left = 78
    Top = 22
    Width = 447
    Height = 49
    Caption = #29289#21697#29366#24577#26597#35810
    Columns = 3
    ItemIndex = 0
    Items.Strings = (
      #29289#21697#20837#20179
      #29289#21697#20986#20179
      #24403#21069#24211#23384)
    TabOrder = 0
    OnClick = RadioGroup1Click
  end
  object StaticText2: TStaticText
    Left = 291
    Top = 93
    Width = 248
    Height = 17
    Alignment = taCenter
    AutoSize = False
    BevelInner = bvLowered
    BevelOuter = bvNone
    Caption = #24050#23450#20041#30340#26465#20214
    Color = clGrayText
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindow
    Font.Height = -13
    Font.Name = #23435#20307
    Font.Style = [fsBold]
    ParentColor = False
    ParentFont = False
    TabOrder = 6
  end
  object sgrid1: TStringGrid
    Left = 291
    Top = 110
    Width = 248
    Height = 184
    ColCount = 3
    FixedCols = 0
    RowCount = 2
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = #23435#20307
    Font.Style = []
    Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRowSelect]
    ParentFont = False
    PopupMenu = PopupMenu1
    ScrollBars = ssVertical
    TabOrder = 8
    OnMouseDown = sgrid1MouseDown
    OnSelectCell = sgrid1SelectCell
    ColWidths = (
      77
      165
      287)
  end
  object BitBtn3: TBitBtn
    Left = 550
    Top = 96
    Width = 75
    Height = 24
    Caption = #26597#25214
    TabOrder = 7
    OnClick = BitBtn3Click
    Kind = bkOK
  end
  object BitBtn5: TBitBtn
    Left = 550
    Top = 148
    Width = 75
    Height = 24
    Caption = #37325#32622
    TabOrder = 9
    OnClick = BitBtn5Click
    Kind = bkRetry
  end
  object BitBtn6: TBitBtn
    Left = 550
    Top = 203
    Width = 75
    Height = 24
    Caption = #36864#20986
    TabOrder = 10
    OnClick = BitBtn6Click
    Kind = bkClose
  end
  object BitBtn4: TBitBtn
    Left = 552
    Top = 24
    Width = 75
    Height = 25
    Caption = #25130#25968
    TabOrder = 1
    OnClick = BitBtn4Click
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
  object BitBtn11: TBitBtn
    Left = 552
    Top = 52
    Width = 75
    Height = 25
    Caption = #25130#25968#26597#35810
    TabOrder = 2
    OnClick = BitBtn11Click
  end
  object PopupMenu1: TPopupMenu
    Left = 489
    Top = 168
    object N1: TMenuItem
      Caption = #21024#38500
      OnClick = N1Click
    end
  end
  object ADOQuery1: TADOQuery
    Connection = dm.ADOConnection1
    Parameters = <>
    SQL.Strings = (
      
        'SELECT SUBSTRING(CONVERT(varchar, getdate(),120), 1, 10) AS date' +
        '1')
    Left = 384
    Top = 216
    object ADOQuery1date1: TStringField
      FieldName = 'date1'
      ReadOnly = True
    end
  end
  object ADOQuery2: TADOQuery
    Connection = dm.ADOConnection1
    Filtered = True
    Parameters = <>
    SQL.Strings = (
      'select description from data0075'
      'order by description')
    Left = 448
    Top = 216
    object ADOQuery2description: TStringField
      FieldName = 'description'
      FixedChar = True
    end
  end
end
