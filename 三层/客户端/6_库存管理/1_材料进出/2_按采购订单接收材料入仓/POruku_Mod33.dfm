inherited frmPOruku_Mod33: TfrmPOruku_Mod33
  Caption = #25353'PO'#20837#20179#26126#32454
  ClientHeight = 450
  ClientWidth = 984
  WindowState = wsMaximized
  OnClose = FormClose
  ExplicitWidth = 1000
  ExplicitHeight = 488
  PixelsPerInch = 96
  TextHeight = 13
  inherited pnlMain: TPanel
    Width = 984
    Height = 450
    ExplicitLeft = 0
    ExplicitTop = 0
    ExplicitWidth = 984
    ExplicitHeight = 450
    inherited pnl1: TPanel
      Width = 982
      ExplicitLeft = 1
      ExplicitTop = 1
      ExplicitWidth = 982
      inherited btnSave: TBitBtn
        OnClick = btnSaveClick
      end
      inherited btnClose: TBitBtn
        OnClick = btnCloseClick
      end
    end
    inherited pnl2: TPanel
      Width = 982
      Height = 415
      ExplicitLeft = 1
      ExplicitTop = 34
      ExplicitWidth = 982
      ExplicitHeight = 415
      object Panel1: TPanel
        Left = 1
        Top = 1
        Width = 980
        Height = 165
        Align = alTop
        TabOrder = 0
        object Label1: TLabel
          Left = 8
          Top = 15
          Width = 60
          Height = 13
          AutoSize = False
          Caption = #20837#24211#21333#21495
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object Label5: TLabel
          Left = 8
          Top = 43
          Width = 60
          Height = 13
          AutoSize = False
          Caption = #37319#36141#21333#21495
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object Label12: TLabel
          Left = 240
          Top = 43
          Width = 30
          Height = 13
          AutoSize = False
          Caption = #24037#21378
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object Label7: TLabel
          Left = 28
          Top = 104
          Width = 30
          Height = 13
          AutoSize = False
          Caption = #22791#27880
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object Label9: TLabel
          Left = 227
          Top = 15
          Width = 40
          Height = 13
          AutoSize = False
          Caption = #20379#24212#21830
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object Label11: TLabel
          Left = 241
          Top = 73
          Width = 30
          Height = 13
          AutoSize = False
          Caption = #36135#24065
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object Label14: TLabel
          Left = 655
          Top = 14
          Width = 30
          Height = 13
          AutoSize = False
          Caption = #27719#29575
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object Label3: TLabel
          Left = 631
          Top = 101
          Width = 60
          Height = 13
          AutoSize = False
          Caption = #36865#36135#26085#26399
        end
        object Label13: TLabel
          Left = 589
          Top = 71
          Width = 100
          Height = 13
          AutoSize = False
          Caption = #20379#24212#21830#36865#36135#21333#21495
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object Label16: TLabel
          Left = 631
          Top = 43
          Width = 60
          Height = 13
          AutoSize = False
          Caption = #36865#36135#20154#21592
          Font.Charset = ANSI_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = #23435#20307
          Font.Style = []
          ParentFont = False
        end
        object Label4: TLabel
          Left = 9
          Top = 74
          Width = 48
          Height = 13
          Alignment = taRightJustify
          Caption = #35831#36141#37096#38376
        end
        object CheckBox3: TCheckBox
          Left = 545
          Top = 134
          Width = 145
          Height = 17
          Caption = #23384#20179#20301#32622#25353#24037#21378#36807#28388
          Checked = True
          State = cbChecked
          TabOrder = 0
        end
        object redt1: TRKeyRzBtnEdit
          Left = 61
          Top = 9
          Width = 148
          Height = 21
          Text = ''
          Color = clInfoBk
          ReadOnly = True
          TabOrder = 1
          ButtonKind = bkFind
          ButtonVisible = False
          AltBtnWidth = 15
          ButtonWidth = 15
          DataSource = ds456
          DataSourceField = 'GRN_NUMBER'
          DisplayModID = 0
          ForceOnFocus = True
        end
        object redt2: TRKeyRzBtnEdit
          Left = 61
          Top = 39
          Width = 148
          Height = 21
          Text = ''
          Color = clInfoBk
          ReadOnly = True
          TabOrder = 2
          ButtonKind = bkFind
          ButtonVisible = False
          AltBtnWidth = 15
          ButtonWidth = 15
          DataSource = ds456
          DataSourceField = 'PO_PTR'
          DispalyTableName = 'data0070'
          DisplaytextField = 'PO_NUMBER'
          DisplayRetKeyField = 'rkey'
          DisplayModID = 33
          ForceOnFocus = True
        end
        object redt3: TRKeyRzBtnEdit
          Left = 270
          Top = 39
          Width = 71
          Height = 21
          Text = ''
          Color = clInfoBk
          ReadOnly = True
          TabOrder = 3
          ButtonKind = bkFind
          ButtonVisible = False
          AltBtnWidth = 15
          ButtonWidth = 15
          DataSource = ds456
          DataSourceField = 'warehouse_ptr'
          DispalyTableName = 'data0015'
          DisplaytextField = 'WAREHOUSE_CODE'
          DisplayRetKeyField = 'Rkey'
          DisplayNoteField = 'WAREHOUSE_NAME'
          DisplayModID = 33
          ForceOnFocus = True
        end
        object redt4: TRKeyRzBtnEdit
          Left = 61
          Top = 101
          Width = 468
          Height = 21
          Text = ''
          TabOrder = 4
          ButtonKind = bkFind
          ButtonVisible = False
          AltBtnWidth = 15
          ButtonWidth = 15
          DataSource = ds456
          DataSourceField = 'REF_NUMBER'
          DisplayModID = 0
          ForceOnFocus = True
        end
        object redt5: TRKeyRzBtnEdit
          Left = 270
          Top = 9
          Width = 71
          Height = 21
          Text = ''
          Color = clInfoBk
          ReadOnly = True
          TabOrder = 5
          ButtonKind = bkFind
          ButtonVisible = False
          AltBtnWidth = 15
          ButtonWidth = 15
          DataSource = ds456
          DataSourceField = 'SUPP_PTR'
          DispalyTableName = 'data0023'
          DisplaytextField = 'code'
          DisplayRetKeyField = 'Rkey'
          DisplayNoteField = 'SUPPLIER_NAME'
          DisplayModID = 33
          ForceOnFocus = True
        end
        object redt7: TRKeyRzBtnEdit
          Left = 684
          Top = 10
          Width = 133
          Height = 21
          Text = ''
          Color = clInfoBk
          ReadOnly = True
          TabOrder = 6
          ButtonKind = bkFind
          ButtonVisible = False
          AltBtnWidth = 15
          ButtonWidth = 15
          DataSource = ds456
          DataSourceField = 'exch_rate'
          DisplayModID = 0
          ForceOnFocus = True
        end
        object redt8: TRKeyRzBtnEdit
          Left = 684
          Top = 37
          Width = 133
          Height = 21
          Text = ''
          TabOrder = 7
          ButtonKind = bkFind
          ButtonVisible = False
          AltBtnWidth = 15
          ButtonWidth = 15
          DataSource = ds456
          DataSourceField = 'ship_BY'
          DisplayModID = 0
          ForceOnFocus = True
        end
        object redt9: TRKeyRzBtnEdit
          Left = 684
          Top = 67
          Width = 133
          Height = 21
          Text = ''
          TabOrder = 8
          ButtonKind = bkFind
          ButtonVisible = False
          AltBtnWidth = 15
          ButtonWidth = 15
          DataSource = ds456
          DataSourceField = 'DELIVER_NUMBER'
          DisplayModID = 0
          ForceOnFocus = True
        end
        object Button1: TButton
          Left = 680
          Top = 129
          Width = 66
          Height = 25
          Caption = #20840#37096#25509#25910
          TabOrder = 9
          OnClick = Button1Click
        end
        object dtpReqDate: TDateTimePicker
          Left = 684
          Top = 99
          Width = 133
          Height = 21
          Date = 42626.476985127320000000
          Time = 42626.476985127320000000
          Color = clWhite
          TabOrder = 10
        end
        object redt6: TRKeyRzBtnEdit
          Left = 270
          Top = 69
          Width = 71
          Height = 21
          Text = ''
          Color = clInfoBk
          ReadOnly = True
          TabOrder = 11
          ButtonKind = bkFind
          ButtonVisible = False
          AltBtnWidth = 15
          ButtonWidth = 15
          DataSource = ds456
          DataSourceField = 'currency_ptr'
          DispalyTableName = 'data0001'
          DisplaytextField = 'CURR_CODE'
          DisplayRetKeyField = 'rkey'
          DisplayNoteField = 'CURR_NAME'
          DisplayModID = 33
          ForceOnFocus = True
        end
        object Button2: TButton
          Left = 752
          Top = 129
          Width = 67
          Height = 25
          Caption = #25353'IQC'#25509#25910
          TabOrder = 12
          OnClick = Button2Click
        end
        object redt10: TRKeyRzBtnEdit
          Left = 61
          Top = 69
          Width = 148
          Height = 21
          Text = ''
          Color = clInfoBk
          ReadOnly = True
          TabOrder = 13
          ButtonKind = bkFind
          ButtonVisible = False
          AltBtnWidth = 15
          ButtonWidth = 15
          DataSource = ds456
          DataSourceField = 'PO_PTR'
          DispalyTableName = 'data0070'
          DisplaytextField = 'PO_REV_NO'
          DisplayRetKeyField = 'rkey'
          DisplayModID = 33
          ForceOnFocus = True
        end
        object CheckBox2: TCheckBox
          Left = 407
          Top = 134
          Width = 132
          Height = 17
          Caption = #20445#23384#21518#25171#21360#20837#20179#21333
          TabOrder = 14
        end
      end
      object Panel2: TPanel
        Left = 1
        Top = 166
        Width = 980
        Height = 248
        Align = alClient
        Caption = 'Panel2'
        TabOrder = 1
        object StringGrid2: TStringGrid
          Left = 1
          Top = 1
          Width = 978
          Height = 246
          Align = alClient
          ColCount = 2
          DefaultColWidth = 80
          RowCount = 2
          TabOrder = 1
          OnKeyDown = StringGrid2KeyDown
          OnKeyPress = StringGrid2KeyPress
          OnKeyUp = StringGrid2KeyUp
          OnSelectCell = StringGrid2SelectCell
        end
        object StringGrid1: TStringGrid
          Left = 1
          Top = 1
          Width = 978
          Height = 246
          Align = alClient
          ColCount = 2
          Ctl3D = False
          DoubleBuffered = True
          RowCount = 2
          Options = [goFixedVertLine, goFixedHorzLine, goVertLine, goHorzLine, goRangeSelect, goColSizing, goEditing]
          ParentCtl3D = False
          ParentDoubleBuffered = False
          PopupMenu = PopupMenu1
          TabOrder = 0
          OnDrawCell = StringGrid1DrawCell
          OnKeyDown = StringGrid1KeyDown
          OnKeyPress = StringGrid1KeyPress
          OnKeyUp = StringGrid1KeyUp
          OnSelectCell = StringGrid1SelectCell
        end
        object CBloc: TComboBox
          Left = 272
          Top = 156
          Width = 84
          Height = 21
          Style = csDropDownList
          DoubleBuffered = True
          ParentDoubleBuffered = False
          TabOrder = 2
          Visible = False
          OnExit = CBlocExit
          OnKeyDown = CBlocKeyDown
        end
        object ComboBox3: TComboBox
          Left = 641
          Top = 156
          Width = 105
          Height = 21
          TabOrder = 3
          Visible = False
          OnExit = ComboBox3Exit
          OnKeyDown = ComboBox3KeyDown
        end
        object dtpk1: TDateTimePicker
          Left = 462
          Top = 156
          Width = 97
          Height = 21
          Date = 42668.000000000000000000
          Format = 'yyyy-MM-dd'
          Time = 42668.000000000000000000
          TabOrder = 4
          Visible = False
          OnExit = dtpk1Exit
          OnKeyDown = dtpk1KeyDown
        end
      end
    end
  end
  object cds04: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 360
    Top = 232
  end
  object cds16: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 416
    Top = 232
  end
  object cds70: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 480
    Top = 232
  end
  object cds391: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 536
    Top = 232
  end
  object cds71: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 592
    Top = 232
  end
  object cds72: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 648
    Top = 232
  end
  object cds456: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 176
    Top = 232
  end
  object cds22: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 232
    Top = 232
  end
  object cds235: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 296
    Top = 232
  end
  object ds456: TDataSource
    DataSet = cds456
    Left = 176
    Top = 288
  end
  object cds17: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 712
    Top = 232
  end
  object cds14: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 778
    Top = 238
  end
  object cds314: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 826
    Top = 238
  end
  object cds192: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 896
    Top = 240
  end
  object PopupMenu1: TPopupMenu
    OnPopup = PopupMenu1Popup
    Left = 472
    Top = 280
    object IQC1: TMenuItem
      Caption = #36873#25321'IQC'#26816#27979
      OnClick = IQC1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object N2: TMenuItem
      Caption = #19981#25509#25910
      OnClick = N2Click
    end
  end
  object cds71_2: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 592
    Top = 288
  end
  object cds72_2: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 648
    Top = 288
  end
end
