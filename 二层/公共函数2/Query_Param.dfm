object frmQuery_Param: TfrmQuery_Param
  Left = 88
  Top = 150
  BorderStyle = bsDialog
  Caption = #26597#35810#26465#20214#35774#32622
  ClientHeight = 417
  ClientWidth = 620
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #23435#20307
  Font.Style = []
  FormStyle = fsMDIChild
  OldCreateOrder = True
  Position = poScreenCenter
  Visible = True
  OnClose = FormClose
  OnCloseQuery = FormCloseQuery
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 620
    Height = 360
    Align = alClient
    BevelOuter = bvNone
    Color = clWhite
    TabOrder = 0
    object Panel3: TPanel
      Left = 0
      Top = 0
      Width = 620
      Height = 57
      Align = alTop
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 0
    end
    object Panel4: TPanel
      Left = 495
      Top = 57
      Width = 125
      Height = 303
      Align = alLeft
      BevelOuter = bvNone
      ParentColor = True
      TabOrder = 1
      object btnClear: TRzBitBtn
        Left = 26
        Top = 80
        FrameColor = clWhite
        Caption = #28165#31354
        Color = clWhite
        HotTrack = True
        TabOrder = 0
        OnClick = btnClearClick
        Glyph.Data = {
          F6000000424DF600000000000000760000002800000010000000100000000100
          04000000000080000000120B0000120B00001000000000000000000000000000
          8000008000000080800080000000800080008080000080808000C0C0C0000000
          FF00C0C0C00000FFFF00FF000000C0C0C000FFFF0000FFFFFF00DADADADADADA
          DADABFBFBDADADADADADDADADBFADADADADAADADAD000DADADADDADAD0FBF0DA
          DADAADAD0F7FBF0DADADDAD0F7F87BF0DADAAD0F7F87BFB70DADD0F7F87BFB78
          80DA000F87BFB78880ADDAD00BFB78880ADAADADA0B7888740ADDADADA088804
          440AADADADA000A04440DADADADADADA0440ADADADADADADA00D}
      end
      object spbtnExec: TRzBitBtn
        Left = 26
        Top = 32
        FrameColor = clWhite
        Caption = #30830#23450
        Color = clWhite
        HotTrack = True
        TabOrder = 1
        OnClick = spbtnExecClick
        Glyph.Data = {
          36060000424D3606000000000000360400002800000020000000100000000100
          08000000000000020000320B0000320B00000001000000000000000000003300
          00006600000099000000CC000000FF0000000033000033330000663300009933
          0000CC330000FF33000000660000336600006666000099660000CC660000FF66
          000000990000339900006699000099990000CC990000FF99000000CC000033CC
          000066CC000099CC0000CCCC0000FFCC000000FF000033FF000066FF000099FF
          0000CCFF0000FFFF000000003300330033006600330099003300CC003300FF00
          330000333300333333006633330099333300CC333300FF333300006633003366
          33006666330099663300CC663300FF6633000099330033993300669933009999
          3300CC993300FF99330000CC330033CC330066CC330099CC3300CCCC3300FFCC
          330000FF330033FF330066FF330099FF3300CCFF3300FFFF3300000066003300
          66006600660099006600CC006600FF0066000033660033336600663366009933
          6600CC336600FF33660000666600336666006666660099666600CC666600FF66
          660000996600339966006699660099996600CC996600FF99660000CC660033CC
          660066CC660099CC6600CCCC6600FFCC660000FF660033FF660066FF660099FF
          6600CCFF6600FFFF660000009900330099006600990099009900CC009900FF00
          990000339900333399006633990099339900CC339900FF339900006699003366
          99006666990099669900CC669900FF6699000099990033999900669999009999
          9900CC999900FF99990000CC990033CC990066CC990099CC9900CCCC9900FFCC
          990000FF990033FF990066FF990099FF9900CCFF9900FFFF99000000CC003300
          CC006600CC009900CC00CC00CC00FF00CC000033CC003333CC006633CC009933
          CC00CC33CC00FF33CC000066CC003366CC006666CC009966CC00CC66CC00FF66
          CC000099CC003399CC006699CC009999CC00CC99CC00FF99CC0000CCCC0033CC
          CC0066CCCC0099CCCC00CCCCCC00FFCCCC0000FFCC0033FFCC0066FFCC0099FF
          CC00CCFFCC00FFFFCC000000FF003300FF006600FF009900FF00CC00FF00FF00
          FF000033FF003333FF006633FF009933FF00CC33FF00FF33FF000066FF003366
          FF006666FF009966FF00CC66FF00FF66FF000099FF003399FF006699FF009999
          FF00CC99FF00FF99FF0000CCFF0033CCFF0066CCFF0099CCFF00CCCCFF00FFCC
          FF0000FFFF0033FFFF0066FFFF0099FFFF00CCFFFF00FFFFFF00000080000080
          000000808000800000008000800080800000C0C0C00080808000191919004C4C
          4C00B2B2B200E5E5E5005A1E1E00783C3C0096646400C8969600FFC8C800465F
          82005591B9006EB9D7008CD2E600B4E6F000D8E9EC0099A8AC00646F7100E2EF
          F100C56A31000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000EEEEEEEEEEEE
          EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
          EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE0909
          EEEEEEEEEEEEEEEEEEEEEEEEEEEE8181EEEEEEEEEEEEEEEEEEEEEEEEEE091010
          09EEEEEEEEEEEEEEEEEEEEEEEE81ACAC81EEEEEEEEEEEEEEEEEEEEEE09101010
          1009EEEEEEEEEEEEEEEEEEEE81ACACACAC81EEEEEEEEEEEEEEEEEE0910101010
          101009EEEEEEEEEEEEEEEE81ACACACACACAC81EEEEEEEEEEEEEEEE0910100909
          10101009EEEEEEEEEEEEEE81ACAC8181ACACAC81EEEEEEEEEEEEEE091009EEEE
          0910101009EEEEEEEEEEEE81AC81EEEE81ACACAC81EEEEEEEEEEEE0909EEEEEE
          EE0910101009EEEEEEEEEE8181EEEEEEEE81ACACAC81EEEEEEEEEEEEEEEEEEEE
          EEEE0910101009EEEEEEEEEEEEEEEEEEEEEE81ACACAC81EEEEEEEEEEEEEEEEEE
          EEEEEE0910101009EEEEEEEEEEEEEEEEEEEEEE81ACACAC81EEEEEEEEEEEEEEEE
          EEEEEEEE09101009EEEEEEEEEEEEEEEEEEEEEEEE81ACAC81EEEEEEEEEEEEEEEE
          EEEEEEEEEE091009EEEEEEEEEEEEEEEEEEEEEEEEEE81AC81EEEEEEEEEEEEEEEE
          EEEEEEEEEEEE0909EEEEEEEEEEEEEEEEEEEEEEEEEEEE8181EEEEEEEEEEEEEEEE
          EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE
          EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEEE}
        NumGlyphs = 2
      end
      object RzBitBtn2: TRzBitBtn
        Left = 26
        Top = 248
        FrameColor = clWhite
        Caption = #36864#20986
        Color = clWhite
        HotTrack = True
        TabOrder = 2
        OnClick = RzBitBtn2Click
        Glyph.Data = {
          36060000424D3606000000000000360400002800000020000000100000000100
          08000000000000020000710B0000710B00000001000000000000000000003300
          00006600000099000000CC000000FF0000000033000033330000663300009933
          0000CC330000FF33000000660000336600006666000099660000CC660000FF66
          000000990000339900006699000099990000CC990000FF99000000CC000033CC
          000066CC000099CC0000CCCC0000FFCC000000FF000033FF000066FF000099FF
          0000CCFF0000FFFF000000003300330033006600330099003300CC003300FF00
          330000333300333333006633330099333300CC333300FF333300006633003366
          33006666330099663300CC663300FF6633000099330033993300669933009999
          3300CC993300FF99330000CC330033CC330066CC330099CC3300CCCC3300FFCC
          330000FF330033FF330066FF330099FF3300CCFF3300FFFF3300000066003300
          66006600660099006600CC006600FF0066000033660033336600663366009933
          6600CC336600FF33660000666600336666006666660099666600CC666600FF66
          660000996600339966006699660099996600CC996600FF99660000CC660033CC
          660066CC660099CC6600CCCC6600FFCC660000FF660033FF660066FF660099FF
          6600CCFF6600FFFF660000009900330099006600990099009900CC009900FF00
          990000339900333399006633990099339900CC339900FF339900006699003366
          99006666990099669900CC669900FF6699000099990033999900669999009999
          9900CC999900FF99990000CC990033CC990066CC990099CC9900CCCC9900FFCC
          990000FF990033FF990066FF990099FF9900CCFF9900FFFF99000000CC003300
          CC006600CC009900CC00CC00CC00FF00CC000033CC003333CC006633CC009933
          CC00CC33CC00FF33CC000066CC003366CC006666CC009966CC00CC66CC00FF66
          CC000099CC003399CC006699CC009999CC00CC99CC00FF99CC0000CCCC0033CC
          CC0066CCCC0099CCCC00CCCCCC00FFCCCC0000FFCC0033FFCC0066FFCC0099FF
          CC00CCFFCC00FFFFCC000000FF003300FF006600FF009900FF00CC00FF00FF00
          FF000033FF003333FF006633FF009933FF00CC33FF00FF33FF000066FF003366
          FF006666FF009966FF00CC66FF00FF66FF000099FF003399FF006699FF009999
          FF00CC99FF00FF99FF0000CCFF0033CCFF0066CCFF0099CCFF00CCCCFF00FFCC
          FF0000FFFF0033FFFF0066FFFF0099FFFF00CCFFFF00FFFFFF00000080000080
          000000808000800000008000800080800000C0C0C00080808000191919004C4C
          4C00B2B2B200E5E5E5005A1E1E00783C3C0096646400C8969600FFC8C800465F
          82005591B9006EB9D7008CD2E600B4E6F000D8E9EC0099A8AC00646F7100E2EF
          F100C56A31000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000EEEEEEEEEEEE
          F1EEEEEEEEEEEEEEEEEEEEEEEEEEEEEEF1EEEEEEEEEEEEEEEEEEEEEEEEF1E3AC
          E3F1EEEEEEEEEEEEEEEEEEEEEEF1EEACE3F1EEEEEEEEEEEEEEEEEEF1E3E28257
          57E2ACE3F1EEEEEEEEEEEEF1EEE2818181E2ACEEF1EEEEEEEEEEE382578282D7
          578181E2E3EEEEEEEEEEEE81818181D7818181E2EEEEEEEEEEEE57828989ADD7
          57797979F1EEEEEEEEEE8181DEDEACD781818181F1EEEEEEEEEE57898989ADD7
          57AAAAA2D7ADEEEEEEEE81DEDEDEACD781DEDE81D7ACEEEEEEEE57898989ADD7
          57AACEA3AD10EEEEEEEE81DEDEDEACD781DEAC81AC81EEEEEEEE5789825EADD7
          57ABCFE21110EEEEEEEE81DE8181ACD781ACACE28181EEEEEEEE578957D7ADD7
          57ABDE101010101010EE81DE56D7ACD781ACDE818181818181EE57898257ADD7
          57EE10101010101010EE81DE8156ACD781E381818181818181EE57898989ADD7
          57EE82101010101010EE81DEDEDEACD781E381818181818181EE57898989ADD7
          57ACF1821110EEEEEEEE81DEDEDEACD781ACF1818181EEEEEEEE57898989ADD7
          57ABEEAB8910EEEEEEEE81DEDEDEACD781ACE3ACDE81EEEEEEEE57828989ADD7
          57ACEEA3EE89EEEEEEEE8181DEDEACD781ACE381EEDEEEEEEEEEEEDE5E8288D7
          57A2A2A2EEEEEEEEEEEEEEDE8181DED781818181EEEEEEEEEEEEEEEEEEAC8257
          57EEEEEEEEEEEEEEEEEEEEEEEEAC818181EEEEEEEEEEEEEEEEEE}
        NumGlyphs = 2
      end
      object RzBitBtn1: TRzBitBtn
        Left = 26
        Top = 128
        FrameColor = clWhite
        Caption = #24110#21161
        Color = clWhite
        HotTrack = True
        TabOrder = 3
        Visible = False
        Glyph.Data = {
          36060000424D3606000000000000360400002800000020000000100000000100
          08000000000000020000220B0000220B00000001000000000000000000003300
          00006600000099000000CC000000FF0000000033000033330000663300009933
          0000CC330000FF33000000660000336600006666000099660000CC660000FF66
          000000990000339900006699000099990000CC990000FF99000000CC000033CC
          000066CC000099CC0000CCCC0000FFCC000000FF000033FF000066FF000099FF
          0000CCFF0000FFFF000000003300330033006600330099003300CC003300FF00
          330000333300333333006633330099333300CC333300FF333300006633003366
          33006666330099663300CC663300FF6633000099330033993300669933009999
          3300CC993300FF99330000CC330033CC330066CC330099CC3300CCCC3300FFCC
          330000FF330033FF330066FF330099FF3300CCFF3300FFFF3300000066003300
          66006600660099006600CC006600FF0066000033660033336600663366009933
          6600CC336600FF33660000666600336666006666660099666600CC666600FF66
          660000996600339966006699660099996600CC996600FF99660000CC660033CC
          660066CC660099CC6600CCCC6600FFCC660000FF660033FF660066FF660099FF
          6600CCFF6600FFFF660000009900330099006600990099009900CC009900FF00
          990000339900333399006633990099339900CC339900FF339900006699003366
          99006666990099669900CC669900FF6699000099990033999900669999009999
          9900CC999900FF99990000CC990033CC990066CC990099CC9900CCCC9900FFCC
          990000FF990033FF990066FF990099FF9900CCFF9900FFFF99000000CC003300
          CC006600CC009900CC00CC00CC00FF00CC000033CC003333CC006633CC009933
          CC00CC33CC00FF33CC000066CC003366CC006666CC009966CC00CC66CC00FF66
          CC000099CC003399CC006699CC009999CC00CC99CC00FF99CC0000CCCC0033CC
          CC0066CCCC0099CCCC00CCCCCC00FFCCCC0000FFCC0033FFCC0066FFCC0099FF
          CC00CCFFCC00FFFFCC000000FF003300FF006600FF009900FF00CC00FF00FF00
          FF000033FF003333FF006633FF009933FF00CC33FF00FF33FF000066FF003366
          FF006666FF009966FF00CC66FF00FF66FF000099FF003399FF006699FF009999
          FF00CC99FF00FF99FF0000CCFF0033CCFF0066CCFF0099CCFF00CCCCFF00FFCC
          FF0000FFFF0033FFFF0066FFFF0099FFFF00CCFFFF00FFFFFF00000080000080
          000000808000800000008000800080800000C0C0C00080808000191919004C4C
          4C00B2B2B200E5E5E5005A1E1E00783C3C0096646400C8969600FFC8C800465F
          82005591B9006EB9D7008CD2E600B4E6F000D8E9EC0099A8AC00646F7100E2EF
          F100C56A31000000000000000000000000000000000000000000000000000000
          0000000000000000000000000000000000000000000000000000EEEEEEE3DE56
          E1E1E1E1E1DFACF1EEEEEEEEEEAC8181818181818181ACF1EEEEEEEEE3E2ADE3
          E3E3E3E3DEE1F0E2E3EEEEEEAC81ADACACACACACAC8181E2ACEEEEE3DEE3D7E3
          8282ACF1D7E3DF56E2F1EEAC81ACD7ACACACACF1D7AC8181E2F1EEACE3D78210
          3482343482D7E3F0F0ACEE81ACD7AC8181AC8181ACD7AC8181ACE3E3D7580A10
          82D75E0A0A82D7E3E181AC81D7AC8181ACD7818181ACD7AC8181E3D7820A3434
          345E3434340AACE3815681D7AC818181818181818181ACAC8181E3D734343434
          5EE33434343458D7ACE181D78181818181AC81818181ACD7AC81E3E334343434
          5ED7830A343434F1E3E181AC8181818181D7AC81818181F1AC81E3AD34343434
          3488D75E343434F1E3E181AD8181818181ACD781818181F1AC81E3E334343434
          340AACD7343434D7E35681AC818181818181ACD7818181D7AC81E3D75F345EE3
          580A5ED75E105ED7ACEF81D7818181ACAC8181D7818181D7ACEFE3F1B33B5ED7
          D789D7D73435D7E381E381F1AC8181D7D7ACD7D78181D7AC81ACEEE3D7B35F83
          E3F1E35F5FADD7B3DEEEEE81D7AC81ACACF1AC8181ADD7AC81EEEEE3E3D7D7B3
          89898989D7D7E3DEF1EEEEEE81D7D7ACACACACACD7D7AC81F1EEEEEEE3ADE3D7
          D7D7D7D7E3ADACF1EEEEEEEEEE8181D7D7D7D7D7818181F1EEEEEEEEEEEEE3AD
          ADADB3ADE3E3EEEEEEEEEEEEEEEEAC8181818181ACACEEEEEEEE}
        NumGlyphs = 2
      end
    end
    object RzPageControl1: TRzPageControl
      Left = 0
      Top = 57
      Width = 495
      Height = 303
      ActivePage = TabSheet1
      Align = alLeft
      BackgroundColor = clBtnFace
      Color = 16119543
      FlatColor = 10263441
      ParentBackgroundColor = False
      ParentColor = False
      TabColors.HighlightBar = 1350640
      TabIndex = 0
      TabOrder = 2
      TabStyle = tsBackSlant
      FixedDimension = 19
      object TabSheet1: TRzTabSheet
        Color = 16119543
        Caption = #26597#35810#26465#20214
        object DBGrid1: TDBGridEh
          Left = 0
          Top = 0
          Width = 491
          Height = 280
          Align = alClient
          DataSource = dsItems
          FixedColor = clSkyBlue
          Flat = True
          FooterColor = clWindow
          FooterFont.Charset = ANSI_CHARSET
          FooterFont.Color = clWindowText
          FooterFont.Height = -13
          FooterFont.Name = #23435#20307
          FooterFont.Style = []
          Options = [dgEditing, dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgTabs, dgCancelOnExit]
          TabOrder = 0
          TitleFont.Charset = ANSI_CHARSET
          TitleFont.Color = clWindowText
          TitleFont.Height = -13
          TitleFont.Name = #23435#20307
          TitleFont.Style = []
          TitleHeight = 30
          OnDblClick = DBGrid1DblClick
          OnEditButtonClick = DBGrid1EditButtonClick
          Columns = <
            item
              EditButtons = <>
              FieldName = 'nType'
              Footers = <>
              PickList.Strings = (
                'AND'
                'OR')
              Title.Alignment = taCenter
              Title.Caption = #20851#31995
              Visible = False
            end
            item
              EditButtons = <>
              FieldName = 'FieldCaption'
              Footers = <>
              Title.Alignment = taCenter
              Title.Caption = #26597#23547#26465#20214
              Width = 95
            end
            item
              DropDownRows = 8
              DropDownShowTitles = True
              EditButtons = <>
              FieldName = 'nOperator'
              Footers = <>
              KeyList.Strings = (
                '='
                '<>'
                '<'
                '<='
                '>'
                '>='
                'LIKE'
                'BETWEEN')
              PickList.Strings = (
                #31561#20110
                #19981#31561#20110
                #23567#20110
                #23567#20110#31561#20110
                #22823#20110
                #22823#20110#31561#20110
                #30456#20284
                #33539#22260#20043#20869)
              Title.Alignment = taCenter
              Title.Caption = #26465#20214#20851#31995
              Width = 59
            end
            item
              EditButtons = <>
              FieldName = 'InputValue'
              Footers = <>
              Title.Alignment = taCenter
              Title.Caption = #26597#35810#20540
              Width = 271
            end>
        end
      end
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 360
    Width = 620
    Height = 57
    Align = alBottom
    BevelOuter = bvNone
    Color = clWhite
    TabOrder = 1
  end
  object cdsMaster: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 40
    Top = 192
  end
  object cdsItems: TClientDataSet
    Aggregates = <>
    Params = <>
    BeforeInsert = cdsItemsBeforeDelete
    BeforeDelete = cdsItemsBeforeDelete
    AfterScroll = cdsItemsAfterScroll
    Left = 40
    Top = 232
    object cdsItemsFieldCaption: TStringField
      FieldName = 'FieldCaption'
    end
    object cdsItemsFieldName: TStringField
      FieldName = 'FieldName'
    end
    object cdsItemsDataType: TStringField
      FieldName = 'DataType'
      Size = 10
    end
    object cdsItemsInputValue: TStringField
      FieldName = 'InputValue'
      OnValidate = cdsItemsInputValueValidate
      Size = 50
    end
    object cdsItemsPickItemId: TIntegerField
      FieldName = 'PickItemId'
    end
    object cdsItemsnType: TStringField
      FieldName = 'nType'
      Size = 10
    end
    object cdsItemsnOperator: TStringField
      FieldName = 'nOperator'
      OnChange = cdsItemsnOperatorChange
      Size = 10
    end
    object cdsItemsInputType: TIntegerField
      FieldName = 'InputType'
    end
    object cdsItemsPickListValue: TStringField
      FieldName = 'PickListValue'
      Size = 1000
    end
  end
  object dsItems: TDataSource
    DataSet = cdsItems
    Left = 80
    Top = 232
  end
end
