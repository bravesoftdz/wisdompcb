object Form6: TForm6
  Left = 309
  Top = 179
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #23457#25209#20449#24687
  ClientHeight = 274
  ClientWidth = 483
  Color = clBtnFace
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = '����'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnKeyDown = FormKeyDown
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 483
    Height = 225
    Align = alTop
    DataSource = Form1.DataSource5
    Options = [dgTitles, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = GB2312_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = '����'
    TitleFont.Style = []
    OnKeyDown = FormKeyDown
    Columns = <
      item
        Expanded = False
        FieldName = 'USER_ID'
        Width = 78
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'USER_FULL_NAME'
        Width = 156
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'auth_flag'
        Width = 68
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'auth_date'
        Width = 82
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'ranking'
        Width = 72
        Visible = True
      end>
  end
  object Button1: TButton
    Left = 206
    Top = 237
    Width = 75
    Height = 25
    Caption = #20851#38381
    ModalResult = 1
    TabOrder = 0
    OnKeyDown = FormKeyDown
  end
end
