object form_empl: Tform_empl
  Left = 312
  Top = 179
  Width = 376
  Height = 431
  Caption = #26597#25214#38599#21592
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = '����'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 41
    Top = 11
    Width = 63
    Height = 13
    Alignment = taRightJustify
    Caption = #38599#21592#20195#21495':'
  end
  object SpeedButton1: TSpeedButton
    Left = 237
    Top = 4
    Width = 25
    Height = 25
    Glyph.Data = {
      F6000000424DF600000000000000760000002800000010000000100000000100
      04000000000080000000120B0000120B00001000000010000000000000000000
      8000008000000080800080000000800080008080000080808000C0C0C0000000
      FF00C0C0C00000FFFF00FF000000C0C0C000FFFF0000FFFFFF00DADADADADADA
      DADABFBFBDADADADADADDADADBFADADADADAADADAD000DADADADDADAD0FBF0DA
      DADAADAD0F7FBF0DADADDAD0F7F87BF0DADAAD0F7F87BFB70DADD0F7F87BFB78
      80DA000F87BFB78880ADDAD00BFB78880ADAADADA0B7888740ADDADADA088804
      440AADADADA000A04440DADADADADADA0440ADADADADADADA00D}
    OnClick = SpeedButton1Click
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 33
    Width = 366
    Height = 330
    DataSource = DataSource1
    Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 1
    TitleFont.Charset = GB2312_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = '����'
    TitleFont.Style = []
    OnDblClick = DBGrid1DblClick
    OnKeyDown = DBGrid1KeyDown
    Columns = <
      item
        Expanded = False
        FieldName = 'EMPL_CODE'
        Title.Caption = #38599#21592#20195#21495
        Width = 114
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'EMPLOYEE_NAME'
        Title.Caption = #38599#21592#21517#31216
        Width = 230
        Visible = True
      end>
  end
  object Edit1: TEdit
    Left = 111
    Top = 7
    Width = 122
    Height = 21
    TabOrder = 0
    OnChange = Edit1Change
    OnKeyDown = DBGrid1KeyDown
  end
  object Button1: TButton
    Left = 104
    Top = 371
    Width = 75
    Height = 25
    Caption = #30830#23450
    ModalResult = 1
    TabOrder = 2
  end
  object Button2: TButton
    Left = 184
    Top = 371
    Width = 75
    Height = 25
    Caption = #21462#28040
    ModalResult = 2
    TabOrder = 3
  end
  object DataSource1: TDataSource
    DataSet = ADOQuery1
    Left = 304
    Top = 369
  end
  object ADOQuery1: TADOStoredProc
    Connection = DM.ADOConnection1
    CursorType = ctStatic
    Filtered = True
    LockType = ltReadOnly
    ProcedureName = 'ep089;3'
    Parameters = <
      item
        Name = '@RETURN_VALUE'
        DataType = ftInteger
        Direction = pdReturnValue
        Precision = 10
        Value = 0
      end>
    Left = 333
    Top = 368
  end
end
