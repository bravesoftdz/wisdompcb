object Form_baseprice: TForm_baseprice
  Left = 334
  Top = 219
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #22522#20215#25628#32034
  ClientHeight = 414
  ClientWidth = 470
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
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
    Top = 38
    Width = 470
    Height = 335
    Align = alClient
    DataSource = DataSource1
    Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = GB2312_CHARSET
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
        FieldName = 'ROW_NAME'
        Title.Color = clRed
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ROW_VALUE'
        ReadOnly = False
        Width = 81
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'KLAmount'
        Width = 73
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'sampleAmount'
        Width = 71
        Visible = True
      end>
  end
  object Panel1: TPanel
    Left = 0
    Top = 373
    Width = 470
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    TabOrder = 2
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
      Left = 242
      Top = 9
      Width = 75
      Height = 25
      Caption = #21462#28040
      ModalResult = 2
      TabOrder = 1
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 470
    Height = 38
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object Label1: TLabel
      Left = 73
      Top = 14
      Width = 39
      Height = 13
      Alignment = taRightJustify
      Caption = #22522#20215#21517
      Font.Charset = GB2312_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object MaskEdit1: TMaskEdit
      Left = 117
      Top = 9
      Width = 153
      Height = 21
      TabOrder = 1
      OnChange = MaskEdit1Change
      OnKeyDown = DBGrid1KeyDown
    end
    object BitBtn2: TBitBtn
      Left = 275
      Top = 7
      Width = 25
      Height = 25
      Hint = #21047#26032
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
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
  end
  object DataSource1: TDataSource
    DataSet = ADOQuery1
    Left = 304
    Top = 379
  end
  object ADOQuery1: TADODataSet
    Connection = dm.ADOConnection1
    CursorType = ctStatic
    Filtered = True
    LockType = ltReadOnly
    CommandText = 
      'select rkey, ROW_NAME, ROW_VALUE,PROD_ROUTE_PTR,'#13#10'KLAmount,sampl' +
      'eAmount'#13#10'from data0346'#13#10
    IndexFieldNames = 'ROW_NAME'
    Parameters = <>
    Left = 335
    Top = 379
    object ADOQuery1rkey: TIntegerField
      FieldName = 'rkey'
      ReadOnly = True
    end
    object ADOQuery1ROW_NAME: TStringField
      DisplayLabel = #22522#20215#21517
      FieldName = 'ROW_NAME'
      Size = 30
    end
    object ADOQuery1ROW_VALUE: TFloatField
      DisplayLabel = #22522#20215
      FieldName = 'ROW_VALUE'
    end
    object ADOQuery1PROD_ROUTE_PTR: TIntegerField
      FieldName = 'PROD_ROUTE_PTR'
    end
    object ADOQuery1KLAmount: TBCDField
      DisplayLabel = #24320#25289#36153
      FieldName = 'KLAmount'
      Precision = 18
      Size = 2
    end
    object ADOQuery1sampleAmount: TBCDField
      DisplayLabel = #26679#21697#36153
      FieldName = 'sampleAmount'
      Precision = 18
      Size = 2
    end
  end
end
