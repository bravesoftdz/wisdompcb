object frmImport: TfrmImport
  Left = 322
  Top = 159
  Width = 1060
  Height = 563
  Caption = #25209#37327#23548#20837
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object pnl1: TPanel
    Left = 0
    Top = 0
    Width = 1052
    Height = 532
    Align = alClient
    TabOrder = 0
    object TPanel
      Left = 1
      Top = 1
      Width = 1050
      Height = 530
      Align = alClient
      TabOrder = 0
      object Panel1: TPanel
        Left = 1
        Top = 1
        Width = 1048
        Height = 40
        Align = alTop
        TabOrder = 0
        object btn_ExModel: TButton
          Left = 24
          Top = 8
          Width = 75
          Height = 25
          Caption = #27169#29256#23548#20986
          TabOrder = 0
          OnClick = btn_ExModelClick
        end
        object btn_exit: TButton
          Left = 208
          Top = 8
          Width = 75
          Height = 25
          Caption = #36864#20986
          TabOrder = 2
          OnClick = btn_exitClick
        end
        object btn_exportErr: TButton
          Left = 112
          Top = 8
          Width = 89
          Height = 25
          Caption = #38169#35823#25968#25454#23548#20986
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clRed
          Font.Height = -11
          Font.Name = 'MS Sans Serif'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          OnClick = btn_exportErrClick
        end
      end
      object Panel2: TPanel
        Left = 1
        Top = 41
        Width = 1048
        Height = 455
        Align = alClient
        TabOrder = 1
        object sg1: TStringGrid
          Left = 1
          Top = 1
          Width = 1046
          Height = 453
          Align = alClient
          ColCount = 4
          FixedCols = 0
          TabOrder = 0
          ColWidths = (
            64
            64
            64
            64)
          RowHeights = (
            24
            24
            24
            24
            24)
        end
      end
      object Panel3: TPanel
        Left = 1
        Top = 496
        Width = 1048
        Height = 33
        Align = alBottom
        TabOrder = 2
        DesignSize = (
          1048
          33)
        object btn_OpenFile: TButton
          Left = 16
          Top = 8
          Width = 68
          Height = 25
          Anchors = [akLeft, akBottom]
          Caption = #25171#24320#25991#20214
          TabOrder = 1
          OnClick = btn_OpenFileClick
        end
        object btn_check: TButton
          Left = 89
          Top = 8
          Width = 70
          Height = 25
          Anchors = [akLeft, akBottom]
          Caption = #26816#26597
          TabOrder = 2
          OnClick = btn_checkClick
        end
        object btn_import: TButton
          Left = 164
          Top = 6
          Width = 68
          Height = 25
          Anchors = [akLeft, akBottom]
          Caption = #23548#20837
          TabOrder = 0
          OnClick = btn_importClick
        end
      end
    end
  end
  object OpenDialog1: TOpenDialog
    Left = 417
    Top = 65
  end
end
