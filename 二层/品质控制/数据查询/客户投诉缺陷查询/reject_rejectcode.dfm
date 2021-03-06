object Form5: TForm5
  Left = 213
  Top = 182
  Width = 696
  Height = 480
  Caption = #25353#32570#38519#32479#35745#25253#24223#36235#21183
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 688
    Height = 31
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    DesignSize = (
      688
      31)
    object SpeedButton1: TSpeedButton
      Left = 82
      Top = 3
      Width = 63
      Height = 26
      Hint = #23558#25968#25454#36755#20986#21040'EXCEL'#25991#20214#20013
      Caption = #23548#20986
      Glyph.Data = {
        F6000000424DF600000000000000760000002800000010000000100000000100
        04000000000080000000120B0000120B00001000000010000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00DADADADADADA
        DADAADADADADADADADADDADADADADAD00000000000000006666007777777706E
        EF0AA0E6666606EEF0ADDA0E66606EEF060AADA0E606EEF0000DDADA006EEF0A
        DADAADAD06EEF00DADADDAD06EEF0670DADAAD06EEF0E6670DADD06EEF0A0E66
        70DA0FFFF0ADA0EEEE0D00000ADADA00000AADADADADADADADAD}
      ParentShowHint = False
      ShowHint = True
      OnClick = SpeedButton1Click
    end
    object Label4: TLabel
      Left = 450
      Top = 11
      Width = 59
      Height = 13
      Anchors = [akTop, akRight]
      Caption = #32479#35745#21333#20301' '
    end
    object BitBtn1: TBitBtn
      Left = 9
      Top = 3
      Width = 63
      Height = 26
      Hint = #36864#20986
      Caption = #20851#38381
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = BitBtn1Click
      Glyph.Data = {
        EE000000424DEE000000000000007600000028000000100000000F0000000100
        0400000000007800000000000000000000001000000000000000000000000000
        8000008000000080800080000000800080008080000080808000C0C0C0000000
        FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00FFFFF0FFFFFF
        FFFFFFFF00FFFFFFFFFFFFF030FFFFFFFFFFFF0330FFFFFFFFFF003330000000
        0FFFF03330FF0FFFFFFFF03300FF0FFFF4FFF03330FF0FFF44FFF03330FF0FF4
        4444F03330FF0F444444F03330FF0FF44444F0330FFF0FFF44FFF030FFFF0FFF
        F4FFF00FFFFF0FFFFFFFF00000000FFFFFFF}
    end
    object ComboBox2: TComboBox
      Left = 510
      Top = 7
      Width = 89
      Height = 21
      Style = csDropDownList
      Anchors = [akTop, akRight]
      Enabled = False
      ItemHeight = 13
      ItemIndex = 0
      TabOrder = 1
      Text = #38754#31215
      OnChange = ComboBox2Change
      Items.Strings = (
        #38754#31215
        'PCS'#25968#37327)
    end
    object CheckBox1: TCheckBox
      Left = 603
      Top = 9
      Width = 51
      Height = 17
      Anchors = [akTop, akRight]
      Caption = #19977#32500
      Checked = True
      Enabled = False
      State = cbChecked
      TabOrder = 2
      OnClick = CheckBox1Click
    end
  end
  object PageControl1: TPageControl
    Left = 0
    Top = 31
    Width = 688
    Height = 419
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 1
    OnChange = PageControl1Change
    object TabSheet1: TTabSheet
      Caption = #25353#32570#38519#25968#25454#27719#24635
      object DBGridEh1: TDBGridEh
        Left = 0
        Top = 0
        Width = 680
        Height = 391
        Align = alClient
        DataSource = DataSource1
        FooterColor = clWindow
        FooterFont.Charset = DEFAULT_CHARSET
        FooterFont.Color = clWindowText
        FooterFont.Height = -13
        FooterFont.Name = #23435#20307
        FooterFont.Style = []
        FooterRowCount = 1
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
        ReadOnly = True
        SumList.Active = True
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -13
        TitleFont.Name = #23435#20307
        TitleFont.Style = []
        OnKeyDown = DBGridEh1KeyDown
        Columns = <
          item
            EditButtons = <>
            FieldName = 'REJ_CODE'
            Footers = <>
            Width = 59
          end
          item
            EditButtons = <>
            FieldName = 'REJECT_DESCRIPTION'
            Footers = <>
            Width = 199
          end
          item
            EditButtons = <>
            FieldName = 'qty_total'
            Footer.ValueType = fvtSum
            Footers = <>
          end
          item
            EditButtons = <>
            FieldName = 'sqft_total'
            Footer.ValueType = fvtSum
            Footers = <>
            Width = 134
          end>
      end
    end
    object TabSheet2: TTabSheet
      Caption = #22270#34920#23545#27604#22270
      ImageIndex = 1
      object Chart1: TChart
        Left = 0
        Top = 0
        Width = 680
        Height = 391
        AllowPanning = pmNone
        AnimatedZoom = True
        BackWall.Brush.Color = clWhite
        BackWall.Brush.Style = bsClear
        BackWall.Color = clSilver
        BottomWall.Brush.Color = clWhite
        BottomWall.Brush.Style = bsClear
        LeftWall.Brush.Color = clWhite
        LeftWall.Brush.Style = bsClear
        Title.Alignment = taLeftJustify
        Title.Font.Charset = ANSI_CHARSET
        Title.Font.Color = clBlue
        Title.Font.Height = -16
        Title.Font.Name = #23435#20307
        Title.Font.Style = []
        Title.Text.Strings = (
          #25353#32570#38519#25253#24223#25968#25454#23545#27604#22270)
        BackColor = clSilver
        BottomAxis.LabelsAngle = 270
        LeftAxis.AxisValuesFormat = '0'
        LeftAxis.LabelsFont.Charset = DEFAULT_CHARSET
        LeftAxis.LabelsFont.Color = clBlack
        LeftAxis.LabelsFont.Height = -12
        LeftAxis.LabelsFont.Name = 'Arial'
        LeftAxis.LabelsFont.Style = []
        LeftAxis.LabelsSeparation = 20
        LeftAxis.Title.Caption = #37329#39069
        LeftAxis.Title.Font.Charset = ANSI_CHARSET
        LeftAxis.Title.Font.Color = clBlue
        LeftAxis.Title.Font.Height = -16
        LeftAxis.Title.Font.Name = #23435#20307
        LeftAxis.Title.Font.Style = []
        Legend.ShadowSize = 2
        Legend.VertMargin = 4
        MaxPointsPerPage = 10
        RightAxis.AxisValuesFormat = '0'
        TopAxis.Axis.Width = 1
        TopAxis.AxisValuesFormat = '0'
        Align = alClient
        BevelOuter = bvLowered
        BorderWidth = 1
        Color = 13160660
        TabOrder = 0
        DesignSize = (
          680
          391)
        object SpeedButton2: TSpeedButton
          Left = 552
          Top = 6
          Width = 26
          Height = 25
          Hint = #19978#19968#39029
          Anchors = [akTop, akRight]
          Glyph.Data = {
            36040000424D3604000000000000360000002800000010000000100000000100
            2000000000000004000000000000000000000000000000000000FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF0080000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF0080000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF008000
            000080000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00800000008000
            000080000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF008000000080000000800000008000
            000080000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF008000000080000000800000008000
            000080000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF008000000080000000800000008000
            000080000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0080000000800000008000
            000080000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF008000
            000080000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF0080000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF0080000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
          ParentShowHint = False
          ShowHint = True
          OnClick = SpeedButton2Click
        end
        object SpeedButton3: TSpeedButton
          Left = 580
          Top = 6
          Width = 26
          Height = 25
          Hint = #19979#19968#39029
          Anchors = [akTop, akRight]
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
          ParentShowHint = False
          ShowHint = True
          OnClick = SpeedButton3Click
        end
        object SpeedButton4: TSpeedButton
          Left = 470
          Top = 6
          Width = 25
          Height = 25
          Hint = #20445#23384#22270#29255
          Anchors = [akTop, akRight]
          Glyph.Data = {
            C6050000424DC605000000000000360400002800000014000000140000000100
            08000000000090010000C40E0000C40E0000000100000000000000000000E8E0
            18008868080048484800D8D8E000C8C8C8001078F00070500000B0900800F8F8
            F800A8880800D0D8D800B8A81000A0800800C8D0D000E8E8E80068686800B0A0
            100098700800A8900800D0D0D000D8D8D80090700800B0981000C0A81000E0E0
            E0009878080090680800A0880800D8E0D800B8A01000B0901000000000000000
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
            0000000000000000000000000000000000000000000000000000000100000000
            000000130000301A1600000000000000E400F712000035A6FC00770000001300
            0700A7FC7700080613000083A600FC7700000000000035A5FC0077FFFF000000
            6800010000000000000000000000000000000000000000000000000000000000
            31000000000000E2EC0000640000660000004716000078011300000047001600
            780001130000F8461600000000000000C000F7120000C8F3EB007770F5001200
            0000ECFD7F0002000000000000001300AF000000000001000A0000884000F877
            30001A1600000100000000998400E6775400F71200000101010001D8F8001200
            450090FB7700801FF80077FFFF00FFFF6000F8120000AD84E6007760F8001200
            D80084E677000000000000FFFF000000C800E2EC0000C8E2EC00001800000000
            00000000000044F8120000400000000000000000000028F81200000000000000
            00000000000000000000000C000000000200000000000101120000872B00F877
            0000ECFD7F00000000000002000000006C00001A0200381A1600007FFF00FFFF
            000000000000381A1600000500000000870031E6770084F8120000218600E677
            9800F81200006713000010FFFF000000680001000000C8E2EC00000000000000
            7000F8120000ACF8120000D8F8001200100030001000F8400000105F5400E677
            680001000000D0F8120000D8F80012000800000000000E0000000F0505BF05BF
            05BF05BF05BF05BF05BF05BF05C7BF0000000000000000000000000000000000
            00050500E1138CE0E0E0E0E0E0E0E0E0E006BD1B00BFBF00031305050505BF05
            050505050505181B00050500C60705050F050FC70F050FC70FBF011B00BFBF00
            011B05A7C7090383BF0503030305011300050500010705091003050503031003
            0305011B00BFBF00011BBF031005BF03101010101005181300050500010705C7
            0FC709C70FC70FC70F05011300BFBF00011B03171017101710171017101B1B18
            00050500011318131813181B181318131813181300BFBF0001181BC601C618C6
            01C601C60101181800050500E11713000003C210050505050510C61800BFBF00
            01181B000010C705C705BF0FC71718C600050500E113180000100F0505000005
            A717C61800BFBF0001C61B000010C70505000005C71718C600050500E1171300
            00100F05050000050F10C60100BFBF00BD0101000010090F0510100FC7170101
            00E90500000000000300000000000000000000000005C705BF05BF0509E9BF05
            BF05BF05BF05BF05BF09}
          ParentShowHint = False
          ShowHint = True
          OnClick = SpeedButton4Click
        end
        object SpeedButton5: TSpeedButton
          Left = 442
          Top = 6
          Width = 26
          Height = 25
          Hint = #25171#21360#22270#29255
          Anchors = [akTop, akRight]
          Glyph.Data = {
            26050000424D26050000000000003604000028000000100000000F0000000100
            080000000000F000000000000000000000000001000000000000000000000000
            80000080000000808000800000008000800080800000C0C0C000C0DCC000F0C8
            A400000000000000000000000000000000000000000000000000000000000000
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
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            0000000000000000000000000000000000000000000000000000000000000000
            000000000000000000000000000000000000F0FBFF00A4A0A000808080000000
            FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00070707070707
            0707070707070707070707070000000000000000000000070707070007070707
            0707070707000700070700000000000000000000000000070007000707070707
            07FBFBFB07070000000700070707070707101010070700070007000000000000
            0000000000000007070000070707070707070707070007000700070000000000
            00000000000700070000070700FFFFFFFFFFFFFFFF000700070007070700FF00
            00000000FF000000000707070700FFFFFFFFFFFFFFFF000707070707070700FF
            0000000000FF000707070707070700FFFFFFFFFFFFFFFF000707070707070700
            00000000000000000707}
          ParentShowHint = False
          ShowHint = True
          OnClick = SpeedButton5Click
        end
        object SpeedButton6: TSpeedButton
          Left = 497
          Top = 7
          Width = 25
          Height = 24
          Hint = #25918#22823
          Anchors = [akTop, akRight]
          Glyph.Data = {
            36040000424D3604000000000000360000002800000010000000100000000100
            2000000000000004000000000000000000000000000000000000FF00FF000000
            000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000
            00000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00000000000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00000000000000000000000000FF00FF0080808000000000000000
            0000000000000000000080808000FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF0000000000000000000000000000000000C0C0C000C0C0
            C000C0C0C000C0C0C0000000000000000000FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF000000000080808000FFFF0000FFFF0000C0C0
            C000C0C0C000C0C0C000C0C0C0008080800000000000FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF008080800000000000C0C0C000FFFF0000C0C0C0000000
            000000000000C0C0C000C0C0C000C0C0C0000000000080808000FF00FF00FF00
            FF00FF00FF00FF00FF0000000000C0C0C000FFFF0000C0C0C000C0C0C0000000
            000000000000C0C0C000C0C0C000C0C0C000C0C0C00000000000FF00FF00FF00
            FF00FF00FF00FF00FF0000000000C0C0C000C0C0C00000000000000000000000
            0000000000000000000000000000C0C0C000C0C0C00000000000FF00FF00FF00
            FF00FF00FF00FF00FF0000000000C0C0C000C0C0C00000000000000000000000
            0000000000000000000000000000FFFF0000C0C0C00000000000FF00FF00FF00
            FF00FF00FF00FF00FF0000000000C0C0C000C0C0C000C0C0C000C0C0C0000000
            000000000000C0C0C000C0C0C000FFFF0000C0C0C00000000000FF00FF00FF00
            FF00FF00FF00FF00FF008080800000000000C0C0C000C0C0C000C0C0C0000000
            000000000000C0C0C000FFFF0000FFFF00000000000080808000FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF000000000080808000C0C0C000C0C0C000C0C0
            C000FFFF0000FFFF0000FFFF00008080800000000000FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000000000C0C0C000C0C0
            C000C0C0C000C0C0C0000000000000000000FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0080808000000000000000
            0000000000000000000080808000FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
          ParentShowHint = False
          ShowHint = True
          OnClick = SpeedButton6Click
        end
        object SpeedButton7: TSpeedButton
          Left = 525
          Top = 7
          Width = 25
          Height = 24
          Hint = #32553#23567
          Anchors = [akTop, akRight]
          Glyph.Data = {
            36040000424D3604000000000000360000002800000010000000100000000100
            2000000000000004000000000000000000000000000000000000FF00FF000000
            000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF000000
            00000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00000000000000000000000000FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00000000000000000000000000FF00FF0080808000000000000000
            0000000000000000000080808000FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF0000000000000000000000000000000000C0C0C000C0C0
            C000C0C0C000C0C0C0000000000000000000FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF000000000080808000FFFF0000FFFF0000C0C0
            C000C0C0C000C0C0C000C0C0C0008080800000000000FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF008080800000000000C0C0C000FFFF0000C0C0C000C0C0
            C000C0C0C000C0C0C000C0C0C000C0C0C0000000000080808000FF00FF00FF00
            FF00FF00FF00FF00FF0000000000C0C0C000FFFF0000C0C0C000C0C0C000C0C0
            C000C0C0C000C0C0C000C0C0C000C0C0C000C0C0C00000000000FF00FF00FF00
            FF00FF00FF00FF00FF0000000000C0C0C000C0C0C00000000000000000000000
            0000000000000000000000000000C0C0C000C0C0C00000000000FF00FF00FF00
            FF00FF00FF00FF00FF0000000000C0C0C000C0C0C00000000000000000000000
            0000000000000000000000000000FFFF0000C0C0C00000000000FF00FF00FF00
            FF00FF00FF00FF00FF0000000000C0C0C000C0C0C000C0C0C000C0C0C000C0C0
            C000C0C0C000C0C0C000C0C0C000FFFF0000C0C0C00000000000FF00FF00FF00
            FF00FF00FF00FF00FF008080800000000000C0C0C000C0C0C000C0C0C000C0C0
            C000C0C0C000C0C0C000FFFF0000FFFF00000000000080808000FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF000000000080808000C0C0C000C0C0C000C0C0
            C000FFFF0000FFFF0000FFFF00008080800000000000FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF000000000000000000C0C0C000C0C0
            C000C0C0C000C0C0C0000000000000000000FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF0080808000000000000000
            0000000000000000000080808000FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00
            FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00FF00}
          ParentShowHint = False
          ShowHint = True
          OnClick = SpeedButton7Click
        end
        object UpDown1: TUpDown
          Left = 636
          Top = 8
          Width = 15
          Height = 21
          Anchors = [akTop, akRight]
          Associate = Edit2
          Max = 30
          Position = 10
          TabOrder = 0
        end
        object Edit2: TEdit
          Left = 615
          Top = 8
          Width = 21
          Height = 21
          Anchors = [akTop, akRight]
          TabOrder = 1
          Text = '10'
          OnChange = Edit2Change
        end
        object Series1: TBarSeries
          ColorEachPoint = True
          Marks.ArrowLength = 10
          Marks.BackColor = clGray
          Marks.Frame.Visible = False
          Marks.Style = smsValue
          Marks.Transparent = True
          Marks.Visible = True
          SeriesColor = clRed
          ShowInLegend = False
          ValueFormat = '0.00'
          AutoMarkPosition = False
          BarBrush.Color = clWhite
          BarStyle = bsRectGradient
          Dark3D = False
          SideMargins = False
          XValues.DateTime = False
          XValues.Name = 'X'
          XValues.Multiplier = 1.000000000000000000
          XValues.Order = loAscending
          YValues.DateTime = False
          YValues.Name = 'Bar'
          YValues.Multiplier = 1.000000000000000000
          YValues.Order = loNone
        end
      end
    end
  end
  object DataSource1: TDataSource
    DataSet = ADOQuery1
    Left = 164
    Top = 119
  end
  object ADOQuery1: TADOQuery
    Connection = Form1.ADOConnection1
    CursorType = ctStatic
    Filtered = True
    LockType = ltReadOnly
    Parameters = <
      item
        Name = 'dtpk1'
        DataType = ftDateTime
        Precision = 16
        Size = 16
        Value = 39264d
      end
      item
        Name = 'dtpk2'
        DataType = ftDateTime
        Precision = 16
        Size = 16
        Value = 39295d
      end>
    SQL.Strings = (
      'SELECT TOP 100 PERCENT'
      '   Data0039.REJ_CODE,Data0039.REJECT_DESCRIPTION,'
      '      SUM(Data0118.Qty) AS qty_total,'
      
        '   ROUND(SUM(Data0118.Qty * dbo.Data0025.unit_sq), 2) AS sqft_to' +
        'tal'
      'FROM Data0101 INNER JOIN'
      '      Data0118 ON Data0101.RKEY = Data0118.SOURCE_PTR INNER JOIN'
      '      Data0025 ON '
      '      Data0101.CUSTOMER_PART_PTR = Data0025.RKEY INNER JOIN'
      
        '      Data0010 ON Data0025.CUSTOMER_PTR = Data0010.RKEY INNER JO' +
        'IN'
      '      Data0008 ON '
      '      Data0025.PROD_CODE_PTR = Data0008.RKEY INNER JOIN'
      '      Data0034 ON '
      '      Data0118.RESP_DEPT_PTR = Data0034.RKEY INNER JOIN'
      '      Data0039 ON Data0118.defect_ptr = Data0039.RKEY'
      'WHERE (Data0101.LOG_DATE >= :dtpk1) AND'
      '      (Data0101.LOG_DATE <= :dtpk2)'
      'GROUP BY Data0039.REJ_CODE,Data0039.REJECT_DESCRIPTION'
      'ORDER BY ROUND(SUM(Data0118.Qty * dbo.Data0025.unit_sq), 2) DESC')
    Left = 196
    Top = 119
    object ADOQuery1REJ_CODE: TStringField
      DisplayLabel = #32570#38519#20195#30721
      FieldName = 'REJ_CODE'
      Size = 5
    end
    object ADOQuery1REJECT_DESCRIPTION: TStringField
      DisplayLabel = #32570#38519#21517#31216
      FieldName = 'REJECT_DESCRIPTION'
      Size = 30
    end
    object ADOQuery1qty_total: TIntegerField
      DisplayLabel = #25968#37327
      FieldName = 'qty_total'
    end
    object ADOQuery1sqft_total: TFloatField
      DisplayLabel = #38754#31215
      FieldName = 'sqft_total'
      ReadOnly = True
    end
  end
  object PrintDialog1: TPrintDialog
    Left = 232
    Top = 120
  end
  object SavePictureDialog1: TSavePictureDialog
    Filter = 'Bitmaps (*.bmp)|*.bmp'
    Left = 264
    Top = 120
  end
end
