object Form1: TForm1
  Left = 231
  Top = 133
  Width = 731
  Height = 480
  Caption = #20869#37096#36153#29992#25903#20986#22788#29702
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  OnResize = FormResize
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 723
    Height = 43
    Align = alTop
    BevelOuter = bvNone
    TabOrder = 0
    object Label1: TLabel
      Left = 202
      Top = 17
      Width = 52
      Height = 13
      Alignment = taRightJustify
      Caption = #25903#31080#32534#21495
    end
    object BitBtn1: TBitBtn
      Left = 2
      Top = 10
      Width = 56
      Height = 25
      Hint = #36864#20986#31995#32479
      Caption = #36864#20986
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 116
      Top = 10
      Width = 62
      Height = 25
      Hint = #23548#20986#25968#25454#21040'Excel'
      Caption = #23548#20986'Excel'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnClick = BitBtn2Click
    end
    object Edit1: TEdit
      Left = 260
      Top = 13
      Width = 121
      Height = 21
      TabOrder = 0
      OnChange = Edit1Change
    end
    object GroupBox2: TGroupBox
      Left = 388
      Top = 0
      Width = 243
      Height = 41
      Caption = #21457#31080#26085#26399
      TabOrder = 1
      object Label2: TLabel
        Left = 5
        Top = 20
        Width = 13
        Height = 13
        Caption = #20174
      end
      object Label3: TLabel
        Left = 125
        Top = 20
        Width = 13
        Height = 13
        Caption = #21040
      end
      object dtpk1: TDateTimePicker
        Left = 23
        Top = 16
        Width = 95
        Height = 21
        CalAlignment = dtaLeft
        Date = 38763
        Time = 38763
        DateFormat = dfShort
        DateMode = dmComboBox
        Kind = dtkDate
        ParseInput = False
        TabOrder = 0
        OnCloseUp = dtpk1CloseUp
        OnExit = dtpk1CloseUp
      end
      object dtpk2: TDateTimePicker
        Left = 140
        Top = 16
        Width = 100
        Height = 21
        CalAlignment = dtaLeft
        Date = 38763
        Time = 38763
        DateFormat = dfShort
        DateMode = dmComboBox
        Kind = dtkDate
        ParseInput = False
        TabOrder = 1
        OnCloseUp = dtpk1CloseUp
        OnExit = dtpk1CloseUp
      end
    end
    object BitBtn3: TBitBtn
      Left = 58
      Top = 10
      Width = 58
      Height = 25
      Hint = #21047#26032
      Caption = #21047#26032
      ParentShowHint = False
      ShowHint = True
      TabOrder = 4
      OnClick = BitBtn3Click
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 43
    Width = 723
    Height = 366
    Align = alClient
    DataSource = dm.DataSource1
    Options = [dgTitles, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit]
    PopupMenu = PopupMenu1
    ReadOnly = True
    TabOrder = 1
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
        FieldName = 'CHECK_NUMBER'
        Title.Color = clRed
        Width = 68
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'BANK_NAME'
        Width = 110
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'CURR_NAME'
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'EX_RATE'
        ReadOnly = False
        Width = 62
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'AMOUNT'
        ReadOnly = False
        Width = 56
        Visible = True
      end
      item
        Expanded = False
        FieldName = #25910#27454#20154#21592
        Width = 73
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'EMPLOYEE_NAME'
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'TDATE'
        ReadOnly = False
        Width = 82
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'v_type'
        ReadOnly = False
        Width = 62
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'v_status'
        ReadOnly = False
        Width = 53
        Visible = True
      end>
  end
  object GroupBox1: TGroupBox
    Left = 0
    Top = 409
    Width = 723
    Height = 44
    Align = alBottom
    Caption = #25903#31080#29366#24577
    TabOrder = 2
    object user_ptr: TLabel
      Left = 336
      Top = 16
      Width = 7
      Height = 13
      Caption = '3'
      Visible = False
    end
    object vprev: TLabel
      Left = 361
      Top = 16
      Width = 7
      Height = 13
      Visible = False
    end
    object db_ptr: TLabel
      Left = 384
      Top = 16
      Width = 7
      Height = 13
      Caption = '0'
      Visible = False
    end
    object Label4: TLabel
      Left = 303
      Top = 16
      Width = 105
      Height = 13
      Caption = #20184#27454#24635#35745'('#26412#20301#24065')'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlue
      Font.Height = -13
      Font.Name = #23435#20307
      Font.Style = []
      ParentFont = False
    end
    object CheckBox1: TCheckBox
      Left = 96
      Top = 16
      Width = 60
      Height = 17
      Caption = #26410#28165
      Checked = True
      State = cbChecked
      TabOrder = 0
      OnClick = CheckBox1Click
    end
    object CheckBox2: TCheckBox
      Left = 168
      Top = 16
      Width = 68
      Height = 17
      Caption = #24050#28165
      TabOrder = 1
      OnClick = CheckBox1Click
    end
    object CheckBox3: TCheckBox
      Left = 240
      Top = 16
      Width = 64
      Height = 17
      Caption = #21462#28040
      TabOrder = 2
      OnClick = CheckBox1Click
    end
    object Edit2: TEdit
      Left = 408
      Top = 12
      Width = 104
      Height = 21
      Color = cl3DLight
      ReadOnly = True
      TabOrder = 3
      Text = '0.00'
    end
  end
  object PopupMenu1: TPopupMenu
    OnPopup = PopupMenu1Popup
    Left = 176
    Top = 232
    object N1: TMenuItem
      Caption = #36153#29992#25903#20986
      OnClick = N1Click
    end
    object N4: TMenuItem
      Caption = #32534#36753
      OnClick = N4Click
    end
    object N5: TMenuItem
      Caption = #26816#26597
      OnClick = N5Click
    end
    object N6: TMenuItem
      Caption = #21462#28040#12288
      OnClick = N6Click
    end
  end
end
