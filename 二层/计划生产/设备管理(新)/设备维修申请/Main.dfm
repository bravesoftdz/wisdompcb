object frm_Main: Tfrm_Main
  Left = 184
  Top = 141
  Width = 1038
  Height = 610
  Caption = #35774#22791#32500#20462#30003#35831
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
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1022
    Height = 41
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 524
      Top = 16
      Width = 52
      Height = 13
      Caption = #30003#35831#21333#21495
    end
    object Label4: TLabel
      Left = 740
      Top = 16
      Width = 117
      Height = 13
      Caption = #34920#26684#24038#36793#22266#23450#26639#30446#65306
    end
    object BitClose: TBitBtn
      Left = 8
      Top = 4
      Width = 70
      Height = 33
      Hint = #36864#20986#31243#24207
      Caption = #36864#20986
      TabOrder = 0
      OnClick = BitCloseClick
      Glyph.Data = {
        DE010000424DDE01000000000000760000002800000024000000120000000100
        0400000000006801000000000000000000001000000000000000000000000000
        80000080000000808000800000008000800080800000C0C0C000808080000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00388888888877
        F7F787F8888888888333333F00004444400888FFF444448888888888F333FF8F
        000033334D5007FFF4333388888888883338888F0000333345D50FFFF4333333
        338F888F3338F33F000033334D5D0FFFF43333333388788F3338F33F00003333
        45D50FEFE4333333338F878F3338F33F000033334D5D0FFFF43333333388788F
        3338F33F0000333345D50FEFE4333333338F878F3338F33F000033334D5D0FFF
        F43333333388788F3338F33F0000333345D50FEFE4333333338F878F3338F33F
        000033334D5D0EFEF43333333388788F3338F33F0000333345D50FEFE4333333
        338F878F3338F33F000033334D5D0EFEF43333333388788F3338F33F00003333
        4444444444333333338F8F8FFFF8F33F00003333333333333333333333888888
        8888333F00003333330000003333333333333FFFFFF3333F00003333330AAAA0
        333333333333888888F3333F00003333330000003333333333338FFFF8F3333F
        0000}
      NumGlyphs = 2
    end
    object BitRefresh: TBitBtn
      Left = 77
      Top = 4
      Width = 70
      Height = 33
      Hint = #21047#26032
      Caption = #21047#26032
      TabOrder = 1
      OnClick = BitRefreshClick
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        04000000000080000000120B0000120B00001000000010000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF00C0C0C00000FFFF00FF000000C0C0C000FFFF0000FFFFFF00DADADADADADA
        DADABFBFBDADADADADADDADADBFADADADADAADADAD000DADADADDADAD0FBF0DA
        DADAADAD0F7FBF0DADADDAD0F7F87BF0DADAAD0F7F87BFB70DADD0F7F87BFB78
        80DA000F87BFB78880ADDAD00BFB78880ADAADADA0B7888740ADDADADA088804
        440AADADADA000A04440DADADADADADA0440ADADADADADADA00D}
    end
    object BtnExportToExcel: TBitBtn
      Left = 146
      Top = 4
      Width = 70
      Height = 33
      Hint = #23548#20986#25968#25454
      Caption = #23548#20986
      TabOrder = 2
      OnClick = BtnExportToExcelClick
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        04000000000080000000120B0000120B00001000000010000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00DADADADADADA
        DADAADADADADADADADADDADADADADAD00000000000000006666007777777706E
        EF0AA0E6666606EEF0ADDA0E66606EEF060AADA0E606EEF0000DDADA006EEF0A
        DADAADAD06EEF00DADADDAD06EEF0670DADAAD06EEF0E6670DADD06EEF0A0E66
        70DA0FFFF0ADA0EEEE0D00000ADADA00000AADADADADADADADAD}
    end
    object BitQuery: TBitBtn
      Left = 215
      Top = 4
      Width = 70
      Height = 33
      Hint = #26597#35810#26465#20214
      Caption = #26597#35810
      TabOrder = 3
      OnClick = BitQueryClick
      Glyph.Data = {
        F2060000424DF206000000000000360400002800000019000000190000000100
        080000000000BC0200001217000012170000000100000000000000000000F8F8
        0000B0B0B00080808000F8600000F0F8F80060606000C8F8C80048484800D0E0
        E00098300000F8C89800F8F8980060000000F898000098989800F86060003030
        3000F8F83000F8F8C800F8E8C800C8C8C800F8F8F8001818180070707000C0C0
        C000E8E8E8005050500000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        00000013000088331700000000000000E400F712000035A6FC00770000001300
        0700A7FC7700080613000083A600FC7700000000000035A5FC0077FFFF000000
        7C00010000000000000000000000000000000000000000000000000000000000
        4300000000000039F000008800008A0098006317000078011300009863001700
        78000113000090631700000000000000C000F7120000C8F3EB007770F5001200
        0000ECFD7F0002000000000000001300F2000100000001000A0000884000F877
        8800331700000100000000998400E6775400F71200000101010001D8F8001200
        450090FB7700801FF80077FFFF00FFFF6000F8120000AD84E6007760F8001200
        D80084E677000000000000FFFF000000E40039F00000E439F000001800000000
        00000000000044F8120000400000000000000000000028F81200000000000000
        00000000000000000000000C000000000200000000000101120000872B00F877
        0000ECFD7F00000000000002000000009000001A020090331700007FFF00FFFF
        00000000000090331700000500000000870031E6770084F8120000218600E677
        9800F81200006713000010FFFF0000007C0001000000E439F000000000000000
        7000F8120000ACF8120000D8F8001200100030001000F8400000105F5400E677
        7C0001000000D0F8120000D8F80012000800000000000E000000161616161616
        1616161616161616161616161616161616161600000016161616161616161616
        1616161616161616161616161616160000001616161616161616161616161616
        16161616161616161616160000001616161616161616161616161616161616F9
        0F161616161616000000161616161616161616161616161616160A0E040D1616
        1616160000001616161616161616181B1B1B1B1B1B0A0E0ED90D1B0816161600
        00001616161616161616181515151515B50E010E0D030F181616160000001616
        16161616161618050505050F0EFB048302151A0F051616000000161616161616
        1616180909090A0E0E040D0F090505031616160000001616161616161616180F
        150600010E0D03150505050F051616000000161616161602020318A318030211
        E30F19191905050316161600000016161616180B0C1513070B181706030F0F0F
        0F05050F05161600000016161616180C0715130FE90B18171909090909050503
        161616000000161616020B1A14151312120B0B170F0F0F0F0F05050F05161600
        00001616160213131A0907AA0F12191702190219020509031616160000001616
        160213050515140F0F0F0B1802090909A709191816161600000016161602131A
        0515071212121818191A050509190F06161616000000161616090F0C14091319
        0B0F18190219051903061B08161616000000161616161618180B0B0B0F18091A
        0505051505091902051616000000161616161616031818180F14050505050515
        09191B05161616000000161616161616161603091A05050505050515191B1616
        1616160000001616161616161616031902191902190219020F16161616161600
        0000161616161616161616161605161616160505161616161616160000001616
        1616161616161616161616161616161616161616161616000000161616161616
        16161616161616161616161616161616161616000000}
    end
    object BitFieldsVisable: TBitBtn
      Left = 284
      Top = 4
      Width = 70
      Height = 33
      Hint = #36873#25321#35201#26174#31034#30340#23383#27573
      Caption = #23383#27573
      PopupMenu = PopupMenu1
      TabOrder = 4
      OnClick = BitFieldsVisableClick
      Glyph.Data = {
        0E070000424D0E0700000000000036040000280000001A0000001A0000000100
        080000000000D80200001217000012170000000100000000000000000000D0C8
        C80078787800383838000088080050F85800B8B8B800F8F8F800004800006060
        600080F8880000F00800A0A0A000E0E0E0009898980030303000E8E8E800C0C0
        C00000A80800A8A8A80020F83000D8D8D800C8C8C800505050009090900000D8
        080068686800F0F0F0008080880010F8200098F8A000B0B0B00060F86800D0D0
        D0003850380000A0080090F898000058000008080800C8D0C80008F818007070
        70008080800000980800C8D0D00058F8600088888800D0C8D00068F87000A0F8
        A00000F8080028F8300000B0080000E0080018F8200098F89800000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000000000000000000000000000
        000000130000904C1A00000000000000E400F712000035A6FC00770000001300
        0700A7FC7700080613000083A600FC7700000000000035A5FC0077FFFF000000
        2000010000000000000000000000000000000000000000000000000000000000
        31000000000000F1F500006400006600C800651A00007801130000C865001A00
        780001130000C0651A00000000000000C000F7120000C8F3EB007770F5001200
        0000ECFD7F0002000000000000001300E8000100000001000A0000884000F877
        90004C1A00000100000000998400E6775400F71200000101010001D8F8001200
        450090FB7700801FF80077FFFF00FFFF6000F8120000AD84E6007760F8001200
        D80084E677000000000000FFFF0000003000F1F5000030F1F500001800000000
        00000000000044F8120000400000000000000000000028F81200000000000000
        00000000000000000000000C000000000200000000000101120000872B00F877
        0000ECFD7F00000000000002000000006C00001A0200984C1A00007FFF00FFFF
        000000000000984C1A00000500000000870031E6770084F8120000218600E677
        9800F81200006713000010FFFF00000020000100000030F1F500000000000000
        7000F8120000ACF8120000D8F8001200100030001000F8400000105F5400E677
        200001000000D0F8120000D8F80012000800000000000E000000070707070700
        0000000000000000000000000000000000070707000007070707002222222222
        2222222222222222222222222200070700000707070700222222222222222222
        2222222222222222220007070000070707070022222222222222222222222222
        2222222222000707000007070707002222222222222222222222222222222222
        2200070700000707070700220000000000000000000000000000000022000707
        0000070707070022170E0E0E0E0E180E0E0E0E0E0E0E0E002200070700000707
        07070022171313130C1C1A0C1313131313131300220007070000070707070022
        1706061F1809252E1F060606060606002200070700000707070700220911060E
        09239C1A0E061111111111002200070700000707070700221A110C1A34191908
        1A0C11012C0127002200070700000707070700221A0602343514302308291321
        1515150022000707000007070707002229160514050A0DC233D82202060D1000
        220007070000070707070022021B1B070707071B1B312D12081F070022000707
        000007070707002202070707070707070710312D23291B002200070700000707
        07070022021B1B1B1B1B1B1B1B1B0D1E2D201000220007070000070707070022
        290D0D0D0D0D0D0D0D0D0D1524C20DAF2200070700000707070700221A151515
        151515151515151515151500220007070000070707070022092F27212C161616
        0127210116162F002200070700000707070700220F090029291A29F50F171709
        1A0F09002200070700000707070700222222002E0D151017290E111F0E0F2222
        22000707000007070707002222222200002E10290E2121000022222222000707
        0000070707070022222222222200111829210022222222222200070700000707
        0707070000000000000002211F00000000000000000707070000070707070707
        0707070707070300110007070707070707070707000007070707070707070707
        0707170F2A03070707070707070707070000}
    end
    object BitBtn: TBitBtn
      Left = 358
      Top = 4
      Width = 129
      Height = 33
      Hint = #26597#35810#32500#20462#20154#21592#20449#24687
      Caption = #35774#22791#32500#20462#20154#21592#26597#35810
      TabOrder = 5
      OnClick = BitBtnClick
      Glyph.Data = {
        36060000424D3606000000000000360400002800000020000000100000000100
        08000000000000020000610B0000610B00000001000000000000000000003300
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
        EEEEEE8383ADEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
        EEEEEEEEE3AD82EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEF1E3AC
        ACACE38283ADAD82EEEEEEEEEEF1E3ACACACE3EEEEEEEEEEEEEEEEEEF1E3E2DF
        F0DF81E3AC83ADAD82EEEEEEF1E3E281DF8181E3EEEEEEEEEEEEEEEEE3DFDFF0
        F056E1DFE3AD82AD83EEEEEEE38181DFDFDFDF81E3EEEEEEEEEEEEEEEFDF81E2
        E2DEDFE1DFE38282AD82EEEEEF8181E2E2DE81DF81E3EEEEEEEEEEE356DFE2AC
        ACE2DEDF56EFE382E383EEE3DF81E2ACACE2DE81DFEFE3EEEEEEF1EFE156E1E1
        81ACE281E1DFAC82EEADF1EFDFDFDFDF81ACE281DF81ACEEEEEEDEE1E1E1DF57
        56E2ACE2DFF0ACEEEEEEDEDFDFDF81DFDFE2ACE281DFACEEEEEE57DFE1F0DFDF
        DFE1ACE2F0F0ACEEEEEEDF81DFDF818181DFACE2DFDFACEEEEEEDFDE2BDFAC81
        F0E1E2EFF0DFACEEEEEE81DEDF81AC81DFDFE2EFDF81ACEEEEEE81D7E1E1D7AC
        F0568181F081E3EEEEEE81D7DFDFD7ACDFDF8181DF81E3EEEEEEDE81AC2BE1F0
        E1F0DFDF56DEF1EEEEEEDE81ACDFDFDFDFDF8181DFDEF1EEEEEEEE8157E12BE1
        E15656F081E3EEEEEEEEEE81DFDFDFDFDFDFDFDF81E3EEEEEEEEEEEEEEEE812B
        2BE15681E3F1EEEEEEEEEEEEEEEE81DFDFDFDF81E3F1EEEEEEEEEEEEEEEEEEE3
        DEDEE3F1EEEEEEEEEEEEEEEEEEEEEEE3DEDEE3F1EEEEEEEEEEEE}
      NumGlyphs = 2
    end
    object Edit1: TEdit
      Left = 580
      Top = 8
      Width = 121
      Height = 21
      TabOrder = 6
      OnChange = Edit1Change
    end
    object Edit2: TEdit
      Left = 860
      Top = 8
      Width = 41
      Height = 21
      TabOrder = 7
      Text = '7'
    end
    object UpDown1: TUpDown
      Left = 901
      Top = 8
      Width = 16
      Height = 21
      Associate = Edit2
      Position = 7
      TabOrder = 8
      OnChangingEx = UpDown1ChangingEx
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 512
    Width = 1022
    Height = 41
    Align = alBottom
    TabOrder = 1
    object GroupBox1: TGroupBox
      Left = 0
      Top = 0
      Width = 537
      Height = 41
      Caption = #29366#24577
      TabOrder = 0
      object CheckBox1: TCheckBox
        Left = 8
        Top = 16
        Width = 65
        Height = 17
        Caption = #26410#25552#20132
        Checked = True
        State = cbChecked
        TabOrder = 0
        OnClick = CheckBox1Click
      end
      object CheckBox2: TCheckBox
        Left = 79
        Top = 16
        Width = 65
        Height = 17
        Caption = #24453#21463#29702
        Checked = True
        State = cbChecked
        TabOrder = 1
        OnClick = CheckBox1Click
      end
      object CheckBox3: TCheckBox
        Left = 151
        Top = 16
        Width = 65
        Height = 17
        Caption = #24050#21463#29702
        TabOrder = 2
        OnClick = CheckBox1Click
      end
      object CheckBox4: TCheckBox
        Left = 222
        Top = 16
        Width = 65
        Height = 17
        Caption = #24050#23436#24037
        Checked = True
        State = cbChecked
        TabOrder = 3
        OnClick = CheckBox1Click
      end
      object CheckBox5: TCheckBox
        Left = 294
        Top = 16
        Width = 65
        Height = 17
        Caption = #24050#39564#25910
        TabOrder = 4
        OnClick = CheckBox1Click
      end
      object CheckBox6: TCheckBox
        Left = 365
        Top = 16
        Width = 65
        Height = 17
        Caption = #34987#36864#22238
        TabOrder = 5
        OnClick = CheckBox1Click
      end
      object CheckBox7: TCheckBox
        Left = 437
        Top = 16
        Width = 65
        Height = 17
        Caption = #24050#26242#20572
        Checked = True
        State = cbChecked
        TabOrder = 6
        OnClick = CheckBox1Click
      end
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 553
    Width = 1022
    Height = 19
    Panels = <
      item
        Width = 300
      end
      item
        Width = 50
      end>
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 41
    Width = 1022
    Height = 471
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 3
    OnChange = PageControl1Change
    object TabSheet1: TTabSheet
      Caption = #32500#20462#35774#22791
      object DBGridEh1: TDBGridEh
        Left = 0
        Top = 0
        Width = 1014
        Height = 443
        Align = alClient
        DataSource = DM.DataSource1
        FooterColor = clWindow
        FooterFont.Charset = DEFAULT_CHARSET
        FooterFont.Color = clWindowText
        FooterFont.Height = -13
        FooterFont.Name = #23435#20307
        FooterFont.Style = []
        FrozenCols = 7
        OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghRowHighlight]
        PopupMenu = PopupMenu2
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -13
        TitleFont.Name = #23435#20307
        TitleFont.Style = []
        OnDrawColumnCell = DBGridEh1DrawColumnCell
        OnKeyDown = DBGridEh1KeyDown
        OnTitleClick = DBGridEh1TitleClick
        Columns = <
          item
            EditButtons = <>
            FieldName = 'NUMBER'
            Footers = <>
            Title.Caption = #30003#35831#21333#21495
            Title.Color = clRed
            Title.SortIndex = 1
            Title.SortMarker = smUpEh
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'EMPLOYEE_NAME'
            Footers = <>
            Title.Caption = #30003#25253#20154
            Width = 49
          end
          item
            EditButtons = <>
            FieldName = 'EMPL_CODE'
            Footers = <>
            Title.Caption = #30003#25253#20154#20195#30721
            Visible = False
          end
          item
            EditButtons = <>
            FieldName = 'CONTACT_NAME'
            Footers = <>
            Title.Caption = #32852#32476#20154
            Width = 54
          end
          item
            EditButtons = <>
            FieldName = 'CONTACT_PHONE'
            Footers = <>
            Title.Caption = #32852#32476#30005#35805
            Width = 82
          end
          item
            EditButtons = <>
            FieldName = 'FASSET_CODE'
            Footers = <>
            Title.Caption = #35774#22791#32534#30721
            Width = 77
          end
          item
            EditButtons = <>
            FieldName = 'FASSET_DESC'
            Footers = <>
            Title.Caption = #35774#22791#21517#31216
            Width = 155
          end
          item
            EditButtons = <>
            FieldName = 'status_c'
            Footers = <>
            Title.Caption = #29366#24577
            Width = 54
          end
          item
            EditButtons = <>
            FieldName = 'DEPT_CODE'
            Footers = <>
            Title.Caption = #37096#38376#20195#30721
            Visible = False
          end
          item
            EditButtons = <>
            FieldName = 'DEPT_NAME'
            Footers = <>
            Title.Caption = #37096#38376#21517#31216
            Width = 95
          end
          item
            EditButtons = <>
            FieldName = 'PLACE'
            Footers = <>
            Title.Caption = #20351#29992#22320#28857
            Width = 95
          end
          item
            EditButtons = <>
            FieldName = 'equipment_grade'
            Footers = <>
            Title.Caption = #35774#22791#32423#21035
          end
          item
            EditButtons = <>
            FieldName = 'failure_grade'
            Footers = <>
            Title.Caption = #25925#38556#32423#21035
            Width = 56
          end
          item
            EditButtons = <>
            FieldName = 'failure_degree'
            Footers = <>
            Title.Caption = #25925#38556#31243#24230
          end
          item
            EditButtons = <>
            FieldName = 'failure_dat'
            Footers = <>
            Title.Caption = #25925#38556#26085#26399
          end
          item
            EditButtons = <>
            FieldName = 'failure_circs'
            Footers = <>
            Title.Caption = #25925#38556#35828#26126
            Width = 300
          end
          item
            EditButtons = <>
            FieldName = 'ent_date'
            Footers = <>
            Title.Caption = #36755#20837#26085#26399
            Visible = False
            Width = 141
          end
          item
            EditButtons = <>
            FieldName = 'referring_date'
            Footers = <>
            Title.Caption = #25552#20132#26085#26399
            Width = 141
          end
          item
            EditButtons = <>
            FieldName = 'maintain_text'
            Footers = <>
            Title.Caption = #32500#20462#35760#24405#35828#26126
            Width = 279
          end
          item
            EditButtons = <>
            FieldName = 'ABBR_NAME'
            Footers = <>
            Title.Caption = #24037#21378
          end
          item
            EditButtons = <>
            FieldName = 'validate_Description'
            Footers = <>
            Title.Caption = #39564#25910#24847#35265
            Width = 181
          end
          item
            EditButtons = <>
            FieldName = 'validate_appraise'
            Footers = <>
            Title.Caption = #39564#25910#35780#20215
            Width = 70
          end
          item
            EditButtons = <>
            FieldName = 'tslr'
            Footers = <>
            Title.Caption = #25237#35785#20869#23481
            Width = 214
          end>
      end
    end
    object TabSheet2: TTabSheet
      Caption = #30456#20851#35828#26126
      ImageIndex = 1
      object Label2: TLabel
        Left = 8
        Top = 8
        Width = 85
        Height = 13
        Caption = #25925#38556#24773#20917#35828#26126':'
      end
      object Meno1: TMemo
        Left = 94
        Top = 0
        Width = 673
        Height = 73
        TabOrder = 0
      end
      object GroupBox2: TGroupBox
        Left = 8
        Top = 88
        Width = 761
        Height = 233
        Caption = #32500#20462#20449#24687
        TabOrder = 1
        object Label3: TLabel
          Left = 11
          Top = 23
          Width = 59
          Height = 13
          Caption = #21463#29702#26085#26399':'
        end
        object Label5: TLabel
          Left = 11
          Top = 47
          Width = 46
          Height = 13
          Caption = #21463#29702#20154':'
        end
        object Label6: TLabel
          Left = 11
          Top = 71
          Width = 59
          Height = 13
          Caption = #23436#24037#26085#26399':'
        end
        object Label7: TLabel
          Left = 328
          Top = 20
          Width = 65
          Height = 13
          Caption = #32500#20462#20154#21592#65306
        end
        object Label8: TLabel
          Left = 328
          Top = 42
          Width = 65
          Height = 13
          Caption = #32500#20462#35760#24405#65306
        end
        object Label9: TLabel
          Left = 548
          Top = 20
          Width = 65
          Height = 13
          Caption = #24322#24120#31867#21035#65306
        end
        object Edit3: TEdit
          Left = 69
          Top = 18
          Width = 120
          Height = 21
          TabOrder = 0
        end
        object Edit4: TEdit
          Left = 69
          Top = 42
          Width = 121
          Height = 21
          TabOrder = 1
        end
        object Edit5: TEdit
          Left = 69
          Top = 66
          Width = 121
          Height = 21
          TabOrder = 2
        end
        object DBGrid1: TDBGrid
          Left = 2
          Top = 111
          Width = 757
          Height = 120
          Align = alBottom
          DataSource = DM.DataSource2
          TabOrder = 3
          TitleFont.Charset = DEFAULT_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -13
          TitleFont.Name = #23435#20307
          TitleFont.Style = []
          Columns = <
            item
              Expanded = False
              FieldName = 'part_name'
              Title.Caption = #38646#20214#21517#31216
              Width = 124
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'part_desc'
              Title.Caption = #38646#20214#35268#26684
              Width = 165
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'quantity'
              Title.Caption = #20351#29992#25968#37327
              Width = 59
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'supplier_name'
              Title.Caption = #20379#24212#21830
              Width = 161
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'amout'
              Title.Caption = #37329#39069
              Width = 59
              Visible = True
            end
            item
              Expanded = False
              FieldName = 'remart'
              Title.Caption = #22791#27880
              Width = 112
              Visible = True
            end>
        end
        object Edit6: TEdit
          Left = 384
          Top = 15
          Width = 121
          Height = 21
          TabOrder = 4
        end
        object Meno2: TMemo
          Left = 384
          Top = 42
          Width = 353
          Height = 49
          TabOrder = 5
        end
        object Edit7: TEdit
          Left = 616
          Top = 15
          Width = 121
          Height = 21
          TabOrder = 6
        end
      end
      object GroupBox3: TGroupBox
        Left = 8
        Top = 320
        Width = 761
        Height = 89
        Caption = #39564#25910#24773#20917#35828#26126
        TabOrder = 2
        object Label10: TLabel
          Left = 12
          Top = 27
          Width = 65
          Height = 13
          Caption = #39564#25910#26085#26399#65306
        end
        object Label11: TLabel
          Left = 11
          Top = 56
          Width = 65
          Height = 13
          Caption = #39564#25910#20154#21592#65306
        end
        object Label12: TLabel
          Left = 269
          Top = 24
          Width = 65
          Height = 13
          Caption = #39564#25910#35780#20215#65306
        end
        object DBDateTimeEditEh1: TDBDateTimeEditEh
          Left = 73
          Top = 24
          Width = 121
          Height = 21
          DataField = 'validate_date'
          DataSource = DM.DataSource1
          EditButtons = <>
          Kind = dtkDateEh
          ReadOnly = True
          TabOrder = 0
          Visible = True
        end
        object Edit8: TEdit
          Left = 72
          Top = 56
          Width = 121
          Height = 21
          TabOrder = 1
        end
        object Meno3: TMemo
          Left = 336
          Top = 24
          Width = 385
          Height = 49
          TabOrder = 2
        end
      end
    end
  end
  object PopupMenu1: TPopupMenu
    AutoHotkeys = maManual
    Left = 328
    Top = 24
  end
  object PopupMenu2: TPopupMenu
    OnPopup = PopupMenu2Popup
    Left = 680
    Top = 289
    object N1: TMenuItem
      Caption = #26032#24314
      OnClick = N1Click
    end
    object N2: TMenuItem
      Caption = #32534#36753
      OnClick = N2Click
    end
    object N3: TMenuItem
      Caption = #25552#20132#21463#29702
      OnClick = N3Click
    end
    object N4: TMenuItem
      Caption = #21024#38500
      OnClick = N4Click
    end
    object N5: TMenuItem
      Caption = #21462#28040#25552#20132
      OnClick = N5Click
    end
    object N6: TMenuItem
      Caption = #39564#25910
      OnClick = N6Click
    end
    object N7: TMenuItem
      Caption = #25237#35785
      OnClick = N7Click
    end
    object N8: TMenuItem
      Caption = #29366#24577#35760#24405
      OnClick = N8Click
    end
    object N9: TMenuItem
      Caption = #25237#35785#35760#24405
      OnClick = N9Click
    end
    object N10: TMenuItem
      Caption = #37325#26032#30331#38470
      OnClick = N10Click
    end
  end
end
