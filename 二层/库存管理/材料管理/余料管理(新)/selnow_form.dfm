object Form_selnow: TForm_selnow
  Left = 113
  Top = 229
  Width = 1206
  Height = 551
  Caption = #21382#21490#24211#23384#26597#35810
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 0
    Top = 41
    Width = 1190
    Height = 472
    Align = alClient
    DataSource = dm.DataSource4
    ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
    Options = [dgEditing, dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgConfirmDelete, dgCancelOnExit]
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = #23435#20307
    TitleFont.Style = []
    OnKeyDown = DBGrid1KeyDown
    OnTitleClick = DBGrid1TitleClick
    Columns = <
      item
        Expanded = False
        FieldName = 'MAT_CODE'
        ReadOnly = False
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'mat_desc'
        Width = 265
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'LEN_SIZE'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'WEI_SIZE'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'mianji'
        Title.Caption = #38754#31215#65288#24179#26041#31859#65289
        Width = 110
        Visible = True
      end
      item
        Expanded = False
        FieldName = #20986#20837#20179#29366#24577
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'PeiLiaoDan'
        Title.Caption = #37197#26009#21333#21495
        Width = 120
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'number'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'quan_on_hand'
        Title.Caption = #21363#26102#24211#23384
        Width = 56
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TDATE'
        Width = 120
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'EMPLOYEE_NAME'
        Title.Caption = #20986#20837#20179#20154#21592
        Width = 78
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'STD_COST'
        Title.Caption = #26631#20934#20215#26684
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'STD_COST_2'
        Title.Caption = #20313#26009#20215#26684
        Width = 74
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'receivestatus'
        Title.Caption = #26448#26009#29366#24577
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'REMARK'
        Title.Caption = #22791#27880
        Visible = True
      end>
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 1190
    Height = 41
    Align = alTop
    BevelInner = bvRaised
    BevelOuter = bvLowered
    TabOrder = 1
    object lblFilter: TLabel
      Left = 192
      Top = 16
      Width = 52
      Height = 13
      Alignment = taRightJustify
      Caption = #20313#26009#32534#30721
    end
    object BitBtn1: TBitBtn
      Left = 6
      Top = 6
      Width = 60
      Height = 30
      Caption = #36864#20986
      TabOrder = 0
      OnClick = BitBtn1Click
      Kind = bkClose
    end
    object BitBtn3: TBitBtn
      Left = 67
      Top = 6
      Width = 60
      Height = 30
      Caption = #23548#20986
      TabOrder = 1
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
    object edtFilter: TEdit
      Left = 248
      Top = 12
      Width = 109
      Height = 21
      ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#25340#38899#36755#20837#27861
      TabOrder = 2
      OnChange = edtFilterChange
    end
  end
end
