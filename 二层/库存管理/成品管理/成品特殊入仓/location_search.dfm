object Form_lo: TForm_lo
  Left = 435
  Top = 275
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #20179#24211#25628#32034
  ClientHeight = 420
  ClientWidth = 421
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
    Left = 56
    Top = 12
    Width = 60
    Height = 13
    Alignment = taRightJustify
    Caption = '   '#20179#24211#20195#30721':'
  end
  object Edit1: TEdit
    Left = 120
    Top = 8
    Width = 153
    Height = 21
    TabOrder = 0
    OnChange = Edit1Change
    OnKeyDown = DBGrid1KeyDown
  end
  object BitBtn1: TBitBtn
    Left = 277
    Top = 6
    Width = 25
    Height = 25
    Hint = #21047#26032
    ParentShowHint = False
    ShowHint = True
    TabOrder = 1
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
    Top = 32
    Width = 417
    Height = 348
    DataSource = DataSource1
    Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'MS Sans Serif'
    TitleFont.Style = []
    OnDblClick = DBGrid1DblClick
    OnKeyDown = DBGrid1KeyDown
    Columns = <
      item
        Expanded = False
        FieldName = 'CODE'
        Title.Caption = #20179#24211#20195#30721
        Width = 168
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'LOCATION'
        Title.Caption = #20179#24211#21517#31216
        Width = 226
        Visible = True
      end>
  end
  object Button1: TButton
    Left = 122
    Top = 388
    Width = 75
    Height = 25
    Caption = #30830#23450
    ModalResult = 1
    TabOrder = 3
  end
  object Button2: TButton
    Left = 202
    Top = 388
    Width = 75
    Height = 25
    Caption = #21462#28040
    ModalResult = 2
    TabOrder = 4
  end
  object DataSource1: TDataSource
    DataSet = ADOQuery1
    Left = 288
    Top = 324
  end
  object ADOQuery1: TADOQuery
    Connection = DM.ADOConnection1
    CursorType = ctStatic
    Filtered = True
    LockType = ltReadOnly
    ParamCheck = False
    Parameters = <>
    Prepared = True
    SQL.Strings = (
      
        'SELECT data0016.RKEY,CODE,LOCATION ,whouse_ptr,warehouse_code,ab' +
        'br_name'
      'FROM Data0016 inner join data0015 on whouse_ptr=data0015.rkey'
      'where data0016.LOCATION_TYPE=1 and allow_putout=1'
      'ORDER BY  CODE')
    Left = 352
    Top = 348
  end
end
