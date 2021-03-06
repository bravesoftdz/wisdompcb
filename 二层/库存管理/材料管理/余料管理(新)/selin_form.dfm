object Form_selin: TForm_selin
  Left = 377
  Top = 235
  Width = 894
  Height = 502
  Caption = #20313#26009#20837#20179#25552#20132#25968#26597#35810
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 0
    Top = 41
    Width = 878
    Height = 423
    Align = alClient
    DataSource = dm.DataSource2
    ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
    Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = #23435#20307
    TitleFont.Style = []
    OnDblClick = DBGrid1DblClick
    OnKeyDown = DBGrid1KeyDown
    OnTitleClick = DBGrid1TitleClick
    Columns = <
      item
        Expanded = False
        FieldName = 'MAT_CODE'
        Title.Color = clRed
        Width = 129
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'mat_desc'
        Width = 168
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'REMARK'
        Width = 88
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'LEN_SIZE'
        ReadOnly = False
        Title.Caption = #32428#21521
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'WEI_SIZE'
        ReadOnly = False
        Title.Caption = #32463#21521
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'NUMBER'
        ReadOnly = False
        Width = 59
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PeiLiaoDan'
        Title.Caption = #37197#26009#21333
        Width = 150
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ABBR_NAME'
        Width = 66
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'LOCATION'
        Width = 60
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TDATE'
        ReadOnly = False
        Width = 72
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'EMPLOYEE_NAME'
        Width = 58
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'RKEY17'
        Visible = False
      end>
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 878
    Height = 41
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    DesignSize = (
      878
      41)
    object Label1: TLabel
      Left = 343
      Top = 15
      Width = 52
      Height = 13
      Caption = #20313#26009#32534#21495
    end
    object BitBtn1: TBitBtn
      Left = 5
      Top = 6
      Width = 60
      Height = 30
      Caption = #36864#20986
      TabOrder = 0
      OnClick = BitBtn1Click
      Kind = bkClose
    end
    object BitBtn2: TBitBtn
      Left = 65
      Top = 6
      Width = 60
      Height = 30
      Caption = #21047#26032
      TabOrder = 1
      OnClick = BitBtn2Click
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
    object BitBtn3: TBitBtn
      Left = 125
      Top = 6
      Width = 60
      Height = 30
      Caption = #23548#20986
      TabOrder = 2
      OnClick = BitBtn3Click
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
    object Edit1: TEdit
      Left = 401
      Top = 11
      Width = 121
      Height = 21
      ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
      TabOrder = 3
      OnChange = Edit1Change
    end
    object GroupBox2: TGroupBox
      Left = 584
      Top = 1
      Width = 259
      Height = 38
      Anchors = [akTop, akRight]
      Caption = #26085#26399#33539#22260
      TabOrder = 4
      object Label2: TLabel
        Left = 6
        Top = 17
        Width = 20
        Height = 13
        Alignment = taRightJustify
        Caption = #20174':'
      end
      object Label3: TLabel
        Left = 134
        Top = 17
        Width = 20
        Height = 13
        Alignment = taRightJustify
        Caption = #21040':'
      end
      object dt1: TDateTimePicker
        Left = 30
        Top = 13
        Width = 97
        Height = 21
        Date = 37600.000000000000000000
        Time = 37600.000000000000000000
        ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
        TabOrder = 0
        OnExit = dt1Exit
      end
      object dt2: TDateTimePicker
        Left = 156
        Top = 13
        Width = 97
        Height = 21
        Date = 37600.000000000000000000
        Time = 37600.000000000000000000
        ImeName = #20013#25991' ('#31616#20307') - '#24494#36719#25340#38899
        TabOrder = 1
        OnExit = dt1Exit
      end
    end
    object BitBtn6: TBitBtn
      Left = 244
      Top = 6
      Width = 59
      Height = 30
      Hint = #29992#25143#33258#23450#20041#25253#34920#26684#24335
      Caption = #25171#21360
      ParentShowHint = False
      ShowHint = True
      TabOrder = 5
      OnClick = BitBtn6Click
      Glyph.Data = {
        5E060000424D5E06000000000000360400002800000017000000170000000100
        08000000000028020000C40E0000C40E0000000100000000000000000000A0E8
        F00048B0E8000028C8005068500000007800C0B8B0005060D00040402000B0B0
        900078707000F8F0D00098A8A0000878D8000060B8000000500008508000E0F0
        D800B8C0F80080A898001060A0000068D80098B8F8005050580050589000A0A0
        9000A8D0E80048A0E8003888D000E0B8E80020100000305858000040B0001048
        C000F0E0F80070B0B8006870900080B0F800C8F8C8000060D0004890F800A0D8
        E0003070C800D8F0F8009090800028507000706868000880F800E8E0F000A8C8
        D8005068B0005868A00038308000D0A09000D0B0D80090A8D800E0E0F0007090
        E0000000100098A0E8006888D800003880003030480080B0F0000028500060B0
        F800C0E0F80048405800B0D8C000C0E0E000C0E8E80038608800C0D0D0000850
        B8000068F8001858D0008080A000B0E0F000C8F0F8000050C8002090E80080B0
        E000B8D8E000A8D0B800F0F8F800F0F8D800003080007880E8000850B00040B0
        F80080A0A800D8D8F00050A0F800F8F0F8004098F00088E0F80000A0F8000008
        6000A0C8C000B0D0F000B8C8C800200828000070E8000878F0005060A0000038
        6800A8909800B0C0C8008040600068B0F000D8F8F80048C8F8000800080080C0
        D800D0D8F000001820004880D80070888800002870005860700078889000A0D0
        D0001858A8000078C00008104000E0F0F000083850000060E800C8F0F000B8E8
        F8000050A80050C0F800A8B0F000B0A0A00080C8F800E8D8E0009098A800C0F0
        F8000048D0004040400058587000383868007088A0002070F00060B0E8003888
        F00098B0B8004068A0004888F0000868E00068C8F8006098E800D8D0B000D0C0
        D000E0D8D80088807000C0A0C00090C0F800082080001090E0008090A000B8D8
        F800B0D8D80058B0F800D0E0F000708080002080F8000848A000F8F0F0001050
        D0004090E0001860B800705060000040D80010100000D0F0E80088B8F800C0C0
        E00088B8C0001018B80040586000080048001060E000A8B8B800A8D0F000A0A0
        B0003860A80070A8E000B0F0F800E0F8E80088A098006090F800E0F8F800A0B8
        B00060A0F80028181800C0D0F800C8F8F800E0F0F8000080D000E0E0E800F0F0
        E80050B0F80068A8F8006060F00080808000C0F8E8003850480020A0F8000000
        3800E8E8F0001058C0003868E000C8E0F0005888F800082068005098F0000040
        C800688890005880A000D0D0D8000010100090B8C800C8C8C800385098003840
        300098A09800D0E8E000080808001040800058586800C0E0C0000050E000D0D8
        E0000058D800687070001870F8000870D00050708800B0C8C80098C8F8002020
        080090B0B0006888E800B8F0F80050A8F000203888001870E00000186000A0F8
        F800D8E0E80070C0F800F8F8E000B0D8F800B0D8D000F8F8F800DF98FFFFFF0B
        22FFFF0B22FFC4DFFFFFFF0B22FFFF0B2200F1002EE2FFFFFFFFFFC5FFDFE21F
        04FFFFC5FFFFFFC5FF00D12E00F1A793FF0BFFFFDFE2220137F1240BFF0B22FF
        FF0026000493F02A9361DF7924C426C5C5C5E27EE2DFFFFFFF00222E37C43B79
        0737A76937E2C426C5C5C4FF931F8DFFFF00FF3CF0C5FFF0F0073C2710E2E2C4
        0BC5FFC5FFC4DF00C10022DF0726C4DFF0798F27031FE2C1F026C4C5F00BC4C1
        2E00FFFF93F0FFC4FFF01C27602793E2DF79C5F0FFC5791FFF00FFFF373CC4FF
        F05EC23C4AC7278D37797926C4E26CFF2200FFC5FF69F05E5E5E965E1C274A27
        93DADF79C12EFFC5FF0022FFDF7E57F9F0DFC23CC21C4A4A276937A56CFF22FF
        FF00FF79E2FF79C2FFF0F05EC25E3C275E271F2EFFC5FFFFFF00C4E22226FF79
        3B26C479C296C21CAD1C03E1FFFFFF0B2200E2C5C5C5FFC5793CC5C4F95E96C2
        1C275EA704FFFFC5FF0093DFC526C4FFFF79CC26C4795EC2C21CAD692404FFFF
        FF00FF379BDF0BC5FFC5793CFFF0C45EC2C21C93048D8DFFFF00FFFFFF2CDAC1
        FF26C5793B26C479C23CC2DFE17E052EFF00FFC5FFFF0B372E79FFC571C2C4F0
        F08F873735D12A61260022FFFF0B22FFFFE224DA37354C0BC49837DF4C1C4A69
        9C00FFFFFFC5FFFFFFFF0BE2FFFF981F0BC40BE22A601C69DF00FF0B22FFFF0B
        22FFFFFF22FFFF35612E2437C2C203DAFF00FFC5FFFFFFC5FFFFFFC5FFFFFFFF
        DF05275E2AA7E2FFFF0022FFFF0B22FFFF0B22FFFF0B22FFFFDF24D134DFFFFF
        FF00}
    end
    object BitBtn4: TBitBtn
      Left = 185
      Top = 6
      Width = 59
      Height = 30
      Hint = #29992#25143#33258#23450#20041#25253#34920#26684#24335
      Caption = #23450#20041
      ParentShowHint = False
      ShowHint = True
      TabOrder = 6
      OnClick = BitBtn4Click
      Glyph.Data = {
        5E060000424D5E06000000000000360400002800000017000000170000000100
        08000000000028020000C40E0000C40E0000000100000000000000000000A0E8
        F00048B0E8000028C8005068500000007800C0B8B0005060D00040402000B0B0
        900078707000F8F0D00098A8A0000878D8000060B8000000500008508000E0F0
        D800B8C0F80080A898001060A0000068D80098B8F8005050580050589000A0A0
        9000A8D0E80048A0E8003888D000E0B8E80020100000305858000040B0001048
        C000F0E0F80070B0B8006870900080B0F800C8F8C8000060D0004890F800A0D8
        E0003070C800D8F0F8009090800028507000706868000880F800E8E0F000A8C8
        D8005068B0005868A00038308000D0A09000D0B0D80090A8D800E0E0F0007090
        E0000000100098A0E8006888D800003880003030480080B0F0000028500060B0
        F800C0E0F80048405800B0D8C000C0E0E000C0E8E80038608800C0D0D0000850
        B8000068F8001858D0008080A000B0E0F000C8F0F8000050C8002090E80080B0
        E000B8D8E000A8D0B800F0F8F800F0F8D800003080007880E8000850B00040B0
        F80080A0A800D8D8F00050A0F800F8F0F8004098F00088E0F80000A0F8000008
        6000A0C8C000B0D0F000B8C8C800200828000070E8000878F0005060A0000038
        6800A8909800B0C0C8008040600068B0F000D8F8F80048C8F8000800080080C0
        D800D0D8F000001820004880D80070888800002870005860700078889000A0D0
        D0001858A8000078C00008104000E0F0F000083850000060E800C8F0F000B8E8
        F8000050A80050C0F800A8B0F000B0A0A00080C8F800E8D8E0009098A800C0F0
        F8000048D0004040400058587000383868007088A0002070F00060B0E8003888
        F00098B0B8004068A0004888F0000868E00068C8F8006098E800D8D0B000D0C0
        D000E0D8D80088807000C0A0C00090C0F800082080001090E0008090A000B8D8
        F800B0D8D80058B0F800D0E0F000708080002080F8000848A000F8F0F0001050
        D0004090E0001860B800705060000040D80010100000D0F0E80088B8F800C0C0
        E00088B8C0001018B80040586000080048001060E000A8B8B800A8D0F000A0A0
        B0003860A80070A8E000B0F0F800E0F8E80088A098006090F800E0F8F800A0B8
        B00060A0F80028181800C0D0F800C8F8F800E0F0F8000080D000E0E0E800F0F0
        E80050B0F80068A8F8006060F00080808000C0F8E8003850480020A0F8000000
        3800E8E8F0001058C0003868E000C8E0F0005888F800082068005098F0000040
        C800688890005880A000D0D0D8000010100090B8C800C8C8C800385098003840
        300098A09800D0E8E000080808001040800058586800C0E0C0000050E000D0D8
        E0000058D800687070001870F8000870D00050708800B0C8C80098C8F8002020
        080090B0B0006888E800B8F0F80050A8F000203888001870E00000186000A0F8
        F800D8E0E80070C0F800F8F8E000B0D8F800B0D8D000F8F8F800DF98FFFFFF0B
        22FFFF0B22FFC4DFFFFFFF0B22FFFF0B2200F1002EE2FFFFFFFFFFC5FFDFE21F
        04FFFFC5FFFFFFC5FF00D12E00F1A793FF0BFFFFDFE2220137F1240BFF0B22FF
        FF0026000493F02A9361DF7924C426C5C5C5E27EE2DFFFFFFF00222E37C43B79
        0737A76937E2C426C5C5C4FF931F8DFFFF00FF3CF0C5FFF0F0073C2710E2E2C4
        0BC5FFC5FFC4DF00C10022DF0726C4DFF0798F27031FE2C1F026C4C5F00BC4C1
        2E00FFFF93F0FFC4FFF01C27602793E2DF79C5F0FFC5791FFF00FFFF373CC4FF
        F05EC23C4AC7278D37797926C4E26CFF2200FFC5FF69F05E5E5E965E1C274A27
        93DADF79C12EFFC5FF0022FFDF7E57F9F0DFC23CC21C4A4A276937A56CFF22FF
        FF00FF79E2FF79C2FFF0F05EC25E3C275E271F2EFFC5FFFFFF00C4E22226FF79
        3B26C479C296C21CAD1C03E1FFFFFF0B2200E2C5C5C5FFC5793CC5C4F95E96C2
        1C275EA704FFFFC5FF0093DFC526C4FFFF79CC26C4795EC2C21CAD692404FFFF
        FF00FF379BDF0BC5FFC5793CFFF0C45EC2C21C93048D8DFFFF00FFFFFF2CDAC1
        FF26C5793B26C479C23CC2DFE17E052EFF00FFC5FFFF0B372E79FFC571C2C4F0
        F08F873735D12A61260022FFFF0B22FFFFE224DA37354C0BC49837DF4C1C4A69
        9C00FFFFFFC5FFFFFFFF0BE2FFFF981F0BC40BE22A601C69DF00FF0B22FFFF0B
        22FFFFFF22FFFF35612E2437C2C203DAFF00FFC5FFFFFFC5FFFFFFC5FFFFFFFF
        DF05275E2AA7E2FFFF0022FFFF0B22FFFF0B22FFFF0B22FFFFDF24D134DFFFFF
        FF00}
    end
  end
  object PopupMenu1: TPopupMenu
    Left = 296
    Top = 136
    object N1: TMenuItem
      Caption = #26597#30475#26469#28304#26126#32454
      OnClick = DBGrid1DblClick
    end
  end
end
