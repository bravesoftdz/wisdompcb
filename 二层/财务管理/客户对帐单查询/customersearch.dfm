object FrmCustSearch: TFrmCustSearch
  Left = 308
  Top = 176
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #26597#25214#23458#25143
  ClientHeight = 414
  ClientWidth = 403
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 0
    Top = 0
    Width = 403
    Height = 33
    Cursor = crVSplit
    Align = alTop
  end
  object Label1: TLabel
    Left = 203
    Top = 14
    Width = 33
    Height = 13
    Alignment = taRightJustify
    Caption = '  '#23458#25143':'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'MS Sans Serif'
    Font.Style = []
    ParentFont = False
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 33
    Width = 403
    Height = 340
    Align = alClient
    DataSource = DataSource1
    Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDblClick = DBGrid1DblClick
    OnKeyPress = DBGrid1KeyPress
    Columns = <
      item
        Expanded = False
        FieldName = 'CUST_CODE'
        Title.Caption = #23458#25143#20195#21495
        Width = 101
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CUSTOMER_NAME'
        Title.Caption = #23458#25143#21517#31216
        Width = 273
        Visible = True
      end>
  end
  object Panel1: TPanel
    Left = 0
    Top = 373
    Width = 403
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 1
    object Button1: TButton
      Left = 131
      Top = 10
      Width = 75
      Height = 25
      Caption = #30830#23450
      ModalResult = 1
      TabOrder = 0
    end
    object Button2: TButton
      Left = 211
      Top = 10
      Width = 75
      Height = 25
      Caption = #21462#28040
      ModalResult = 2
      TabOrder = 1
    end
  end
  object MaskEdit1: TMaskEdit
    Left = 245
    Top = 9
    Width = 100
    Height = 21
    TabOrder = 2
    OnChange = MaskEdit1Change
  end
  object BitBtn2: TBitBtn
    Left = 355
    Top = 7
    Width = 25
    Height = 25
    Hint = #21047#26032
    ParentShowHint = False
    ShowHint = True
    TabOrder = 3
    TabStop = False
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
  object RadioGroup1: TRadioGroup
    Left = 16
    Top = 0
    Width = 166
    Height = 34
    Caption = #26597#25214#26041#24335
    Columns = 2
    ItemIndex = 0
    Items.Strings = (
      #25353#20195#21495
      #25353#21517#31216)
    TabOrder = 4
  end
  object DataSource1: TDataSource
    DataSet = FrmMain.ADOData0010
    Left = 192
    Top = 123
  end
end
