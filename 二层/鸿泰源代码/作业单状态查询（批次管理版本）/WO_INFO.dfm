object frmWO_INFO: TfrmWO_INFO
  Left = 250
  Top = 157
  Width = 671
  Height = 453
  Caption = #20316#19994#21333#30456#20851#20449#24687
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 36
    Width = 655
    Height = 379
    ActivePage = TabSheet4
    Align = alClient
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnChange = PageControl1Change
    object TabSheet1: TTabSheet
      Caption = #21464#26356#35760#24405
      object Memo1: TMemo
        Left = 0
        Top = 0
        Width = 647
        Height = 351
        Align = alClient
        ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
        ReadOnly = True
        TabOrder = 0
      end
    end
    object TabSheet2: TTabSheet
      Caption = #25253#24223#20449#24687
      ImageIndex = 1
      object DBGridEh1: TDBGridEh
        Left = 0
        Top = 0
        Width = 647
        Height = 351
        Align = alClient
        Flat = True
        FooterColor = clWhite
        FooterFont.Charset = ANSI_CHARSET
        FooterFont.Color = clWindowText
        FooterFont.Height = -13
        FooterFont.Name = #23435#20307
        FooterFont.Style = []
        FooterRowCount = 1
        ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
        Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        ReadOnly = True
        SumList.Active = True
        TabOrder = 0
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -13
        TitleFont.Name = #23435#20307
        TitleFont.Style = []
        Columns = <
          item
            EditButtons = <>
            FieldName = 'REJ_CODE'
            Footers = <>
            Title.Caption = #32570#38519#20195#30721
            Width = 55
          end
          item
            EditButtons = <>
            FieldName = 'reject_description'
            Footer.Alignment = taCenter
            Footer.Value = #21512'   '#35745
            Footer.ValueType = fvtStaticText
            Footers = <>
            Title.Alignment = taCenter
            Title.Caption = #32570#38519#25551#36848
            Width = 112
          end
          item
            EditButtons = <>
            FieldName = 'dept_name'
            Footers = <>
            Title.Alignment = taCenter
            Title.Caption = #30003#35831#24037#24207
            Width = 61
          end
          item
            EditButtons = <>
            FieldName = 'resp_dept_name'
            Footers = <>
            Title.Alignment = taCenter
            Title.Caption = #36131#20219#37096#38376
            Width = 59
          end
          item
            EditButtons = <>
            FieldName = 'tdatetime'
            Footers = <>
            Title.Alignment = taCenter
            Title.Caption = #25253#24223#26085#26399
            Width = 115
          end
          item
            EditButtons = <>
            FieldName = 'qty_reject'
            Footer.FieldName = 'qty_reject'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Alignment = taCenter
            Title.Caption = #25253#24223#25968#37327
            Width = 62
          end
          item
            EditButtons = <>
            FieldName = 'panels'
            Footer.FieldName = 'panels'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Alignment = taCenter
            Title.Caption = 'PNL'#25968#37327
            Width = 60
          end
          item
            EditButtons = <>
            FieldName = 'EMPLOYEE_NAME'
            Footers = <>
            Title.Alignment = taCenter
            Title.Caption = #25253#24223#20154#21592
            Width = 57
          end>
      end
    end
    object TabSheet3: TTabSheet
      Caption = #27969#36716#20449#24687
      ImageIndex = 2
      object DBGridEh2: TDBGridEh
        Left = 0
        Top = 0
        Width = 647
        Height = 351
        Align = alClient
        Flat = True
        FooterColor = clWhite
        FooterFont.Charset = ANSI_CHARSET
        FooterFont.Color = clWindowText
        FooterFont.Height = -13
        FooterFont.Name = #23435#20307
        FooterFont.Style = []
        FooterRowCount = 1
        ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
        Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        ReadOnly = True
        SumList.Active = True
        TabOrder = 0
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -13
        TitleFont.Name = #23435#20307
        TitleFont.Style = []
        Columns = <
          item
            EditButtons = <>
            FieldName = 'WORK_ORDER_NUMBER'
            Footer.Value = #21512#35745
            Footer.ValueType = fvtStaticText
            Footers = <>
            Title.Alignment = taCenter
            Title.Caption = #20316#19994#21333#21495
            Width = 121
          end
          item
            EditButtons = <>
            FieldName = 'dptname'
            Footers = <>
            Title.Alignment = taCenter
            Title.Caption = #24037#24207
            Width = 62
          end
          item
            EditButtons = <>
            FieldName = 'step_no'
            Footers = <>
            Title.Alignment = taCenter
            Title.Caption = #27493#39588
            Width = 29
          end
          item
            EditButtons = <>
            FieldName = 'INTIME'
            Footers = <>
            Title.Alignment = taCenter
            Title.Caption = #25910#26495#26102#38388
            Width = 100
          end
          item
            EditButtons = <>
            FieldName = 'OUTTIME'
            Footers = <>
            Title.Alignment = taCenter
            Title.Caption = #36865#26495#26102#38388
            Width = 96
          end
          item
            EditButtons = <>
            FieldName = 'QTY_PROD'
            Footer.FieldName = 'QTY_PROD'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Alignment = taCenter
            Title.Caption = #20135#20986#25968#37327
          end
          item
            EditButtons = <>
            FieldName = 'wtype'
            Footer.FieldName = 'QTY_REJECT'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Alignment = taCenter
            Title.Caption = #36807#25968#31867#21035
            Width = 59
          end
          item
            EditButtons = <>
            FieldName = 'employee_name'
            Footers = <>
            Title.Alignment = taCenter
            Title.Caption = #25509#25910#20154
            Width = 45
          end
          item
            EditButtons = <>
            FieldName = 'ACTION_REF'
            Footers = <>
            Title.Alignment = taCenter
            Title.Caption = #22791#27880
            Width = 74
          end>
      end
    end
    object TabSheet4: TTabSheet
      Caption = #24037#33402#27969#31243
      ImageIndex = 3
      object DBGrid3: TDBGrid
        Left = 0
        Top = 0
        Width = 647
        Height = 351
        Align = alClient
        DataSource = dsWO_INFO
        ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
        PopupMenu = PopupMenu2
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -13
        TitleFont.Name = #23435#20307
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'step_number'
            Title.Alignment = taCenter
            Title.Caption = #27493#39588
            Width = 73
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'dept_code'
            Title.Alignment = taCenter
            Title.Caption = #24037#33402#20195#21495
            Width = 105
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'dept_name'
            Title.Alignment = taCenter
            Title.Caption = #24037#33402#21517#31216
            Width = 169
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'barcode_entry_flag'
            Title.Alignment = taCenter
            Title.Caption = #26159#21542#36807#25968
            Width = 78
            Visible = True
          end>
      end
    end
    object TabSheet5: TTabSheet
      Caption = #36820#24037#27969#31243
      ImageIndex = 5
      object DBGrid1: TDBGrid
        Left = 0
        Top = 0
        Width = 647
        Height = 351
        Align = alClient
        DataSource = dsWO_INFO
        ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
        PopupMenu = PopupMenu2
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -13
        TitleFont.Name = #23435#20307
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'step_number'
            Title.Alignment = taCenter
            Title.Caption = #27493#39588
            Width = 73
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'dept_code'
            Title.Alignment = taCenter
            Title.Caption = #24037#33402#20195#21495
            Width = 105
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'dept_name'
            Title.Alignment = taCenter
            Title.Caption = #24037#33402#21517#31216
            Width = 169
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'barcode_entry_flag'
            Title.Alignment = taCenter
            Title.Caption = #26159#21542#36807#25968
            Width = 78
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'Old_Step_NO'
            Title.Alignment = taCenter
            Title.Caption = #21407#27493#39588
            Visible = True
          end>
      end
    end
    object TabSheet6: TTabSheet
      Caption = #23436#24037#20449#24687
      ImageIndex = 4
      object DBGridEh4: TDBGridEh
        Left = 0
        Top = 0
        Width = 655
        Height = 362
        Align = alClient
        Flat = True
        FooterColor = clWhite
        FooterFont.Charset = ANSI_CHARSET
        FooterFont.Color = clWindowText
        FooterFont.Height = -13
        FooterFont.Name = #23435#20307
        FooterFont.Style = []
        FooterRowCount = 1
        ImeName = #20013#25991' ('#31616#20307') - '#25628#29399#20116#31508#36755#20837#27861
        Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        ReadOnly = True
        SumList.Active = True
        TabOrder = 0
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -13
        TitleFont.Name = #23435#20307
        TitleFont.Style = []
        Columns = <
          item
            EditButtons = <>
            FieldName = 'WORK_ORDER_NUMBER'
            Footer.Value = ' '#21512'  '#35745
            Footer.ValueType = fvtStaticText
            Footers = <>
            Title.Alignment = taCenter
            Title.Caption = #20316#19994#21333#21495
            Width = 133
          end
          item
            EditButtons = <>
            FieldName = 'mfg_date'
            Footers = <>
            Title.Alignment = taCenter
            Title.Caption = #20837#20179#26085#26399
            Width = 127
          end
          item
            EditButtons = <>
            FieldName = 'quantity'
            Footer.FieldName = 'quantity'
            Footer.ValueType = fvtSum
            Footers = <>
            Title.Alignment = taCenter
            Title.Caption = #20837#20179#25968#37327
            Width = 65
          end
          item
            EditButtons = <>
            FieldName = 'inType'
            Footer.Alignment = taCenter
            Footers = <>
            Title.Alignment = taCenter
            Title.Caption = #20837#24211#31867#21035
            Width = 145
          end
          item
            EditButtons = <>
            FieldName = 'Warehouse_name'
            Footers = <>
            Title.Alignment = taCenter
            Title.Caption = #24037#21378
            Width = 102
          end>
      end
    end
    object TabSheet7: TTabSheet
      Caption = #24037#31243#26723#26696
      ImageIndex = 6
      object DBGrid4: TDBGrid
        Left = 0
        Top = 0
        Width = 655
        Height = 362
        Align = alClient
        DataSource = DataSource8
        ImeName = #20013#25991' ('#31616#20307') - '#26497#28857#20116#31508
        Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgConfirmDelete, dgCancelOnExit]
        PopupMenu = PopupMenu9
        ReadOnly = True
        TabOrder = 0
        TitleFont.Charset = ANSI_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -13
        TitleFont.Name = #23435#20307
        TitleFont.Style = []
        Columns = <
          item
            Expanded = False
            FieldName = 'rec_no'
            Width = 55
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'file_name'
            Width = 145
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'in_date'
            Width = 119
            Visible = True
          end
          item
            Expanded = False
            FieldName = 'remark'
            Width = 215
            Visible = True
          end>
      end
    end
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 655
    Height = 36
    Align = alTop
    TabOrder = 0
    object BitBtn1: TBitBtn
      Left = 8
      Top = 5
      Width = 62
      Height = 26
      Hint = #36864#20986#31995#32479
      Caption = #36864#20986
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = BitBtn1Click
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
  end
  object PopupMenu2: TPopupMenu
    Left = 356
    Top = 248
    object MenuItem1: TMenuItem
      Caption = #26597#30475#21046#31243#21442#25968
      OnClick = MenuItem1Click
    end
  end
  object adsWO_INFO: TADODataSet
    Connection = frmMain.ADOConnection1
    CursorType = ctStatic
    Filtered = True
    LockType = ltBatchOptimistic
    Parameters = <>
    Left = 240
    Top = 304
  end
  object dsWO_INFO: TDataSource
    DataSet = adsWO_INFO
    Left = 296
    Top = 304
  end
  object ads564: TADODataSet
    Connection = frmMain.ADOConnection1
    CursorType = ctStatic
    Filtered = True
    LockType = ltBatchOptimistic
    CommandText = 
      'select rkey,rec_no, SOURCE_PTR, file_name, in_date, remark'#13#10' fro' +
      'm Data0564'#13#10'where SOURCE_PTR=:rkey'#13#10'order by rec_no'
    Parameters = <
      item
        Name = 'rkey'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = 0
      end>
    Left = 437
    Top = 160
    object ads564rkey: TAutoIncField
      FieldName = 'rkey'
      ReadOnly = True
    end
    object ads564rec_no: TIntegerField
      DisplayLabel = #24207#21495
      FieldName = 'rec_no'
    end
    object ads564SOURCE_PTR: TIntegerField
      FieldName = 'SOURCE_PTR'
    end
    object ads564file_name: TStringField
      DisplayLabel = #25991#20214#21517
      FieldName = 'file_name'
      Size = 50
    end
    object ads564in_date: TDateTimeField
      DisplayLabel = #19978#20256#26085#26399
      FieldName = 'in_date'
    end
    object ads564remark: TStringField
      DisplayLabel = #22791#27880#35828#26126
      FieldName = 'remark'
      Size = 50
    end
  end
  object DataSource8: TDataSource
    DataSet = ads564
    Left = 180
    Top = 216
  end
  object PopupMenu9: TPopupMenu
    OnPopup = PopupMenu9Popup
    Left = 313
    Top = 204
    object N33: TMenuItem
      Caption = #25171#24320#25991#20214
      OnClick = N33Click
    end
  end
  object ADOquery1: TADOQuery
    Connection = frmMain.ADOConnection1
    Parameters = <>
    Left = 456
    Top = 224
  end
end
