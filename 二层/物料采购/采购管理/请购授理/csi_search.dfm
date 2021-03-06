object Form_csi: TForm_csi
  Left = 306
  Top = 165
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #31995#32479#29992#25143#25628#32034
  ClientHeight = 414
  ClientWidth = 415
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
  object Label1: TLabel
    Left = 48
    Top = 14
    Width = 74
    Height = 13
    Alignment = taRightJustify
    AutoSize = False
    Caption = #29992#25143#26631#35782':'
  end
  object Edit1: TEdit
    Left = 130
    Top = 9
    Width = 151
    Height = 21
    TabOrder = 0
    OnChange = Edit1Change
    OnKeyDown = DBGrid1KeyDown
  end
  object BitBtn1: TBitBtn
    Left = 288
    Top = 7
    Width = 25
    Height = 25
    Hint = #21047#26032
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
    TabStop = False
    OnClick = BitBtn1Click
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
  object DBGrid1: TDBGrid
    Left = 0
    Top = 37
    Width = 414
    Height = 339
    DataSource = DataSource1
    Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    TabOrder = 2
    TitleFont.Charset = GB2312_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = #23435#20307
    TitleFont.Style = []
    OnDblClick = DBGrid1DblClick
    OnKeyDown = DBGrid1KeyDown
    Columns = <
      item
        Expanded = False
        FieldName = 'user_id'
        Title.Caption = #29992#25143#26631#35782
        Width = 85
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'user_full_name'
        Title.Caption = #29992#25143#21517#31216
        Width = 307
        Visible = True
      end>
  end
  object Button1: TButton
    Left = 123
    Top = 384
    Width = 75
    Height = 25
    Caption = #30830#23450
    ModalResult = 1
    TabOrder = 3
  end
  object Button2: TButton
    Left = 203
    Top = 384
    Width = 75
    Height = 25
    Caption = #21462#28040
    ModalResult = 2
    TabOrder = 4
  end
  object DataSource1: TDataSource
    DataSet = adoquery1
    Left = 344
    Top = 379
  end
  object adoquery1: TADOStoredProc
    Connection = DM.ADOConnection1
    CursorType = ctStatic
    Filtered = True
    LockType = ltReadOnly
    ProcedureName = 'ep054;5'
    Parameters = <>
    Left = 311
    Top = 380
    object adoquery1user_id: TStringField
      FieldName = 'user_id'
      Size = 10
    end
    object adoquery1user_full_name: TStringField
      FieldName = 'user_full_name'
      Size = 30
    end
    object adoquery1DEPT_CODE: TStringField
      FieldName = 'DEPT_CODE'
      Size = 10
    end
    object adoquery1dept_name: TStringField
      FieldName = 'dept_name'
      Size = 30
    end
    object adoquery1employee_ptr: TIntegerField
      FieldName = 'employee_ptr'
    end
    object adoquery1rkey: TIntegerField
      FieldName = 'rkey'
      ReadOnly = True
    end
    object adoquery1pr_id: TStringField
      FieldName = 'pr_id'
      FixedChar = True
      Size = 2
    end
  end
end
