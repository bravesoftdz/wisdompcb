object Form_report: TForm_report
  Left = 334
  Top = 181
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = #25253#34920#25968#25454#23450#20041
  ClientHeight = 460
  ClientWidth = 459
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object Memo1: TMemo
    Left = 15
    Top = 272
    Width = 425
    Height = 75
    ImeName = #20013#25991' ('#31616#20307') - '#26497#28857#20116#31508
    ScrollBars = ssBoth
    TabOrder = 0
  end
  object Memo2: TMemo
    Left = 8
    Top = 352
    Width = 425
    Height = 81
    ImeName = #20013#25991' ('#31616#20307') - '#26497#28857#20116#31508
    ScrollBars = ssBoth
    TabOrder = 1
  end
  object DataSource1: TDataSource
    DataSet = ADS25
    Left = 128
    Top = 48
  end
  object ADS25: TADODataSet
    Connection = DM.ADOConnection1
    CursorType = ctStatic
    LockType = ltReadOnly
    OnCalcFields = ADS25CalcFields
    CommandText = 
      'SELECT Data0025.RKEY, Data0025.MANU_PART_NUMBER as '#26412#21378#32534#21495', '#13#10'     ' +
      ' Data0025.MANU_PART_DESC as '#23458#25143#22411#21495',Data0010.CUST_CODE AS '#23458#25143#20195#30721', '#13#10' ' +
      '     Data0010.CUSTOMER_NAME AS '#23458#25143#21517#31216', Data0010.ABBR_NAME AS '#23458#25143#31616#31216',' +
      ' '#13#10'      Data0008.PROD_CODE AS '#31867#22411#20195#30721', Data0008.PRODUCT_NAME AS '#31867#22411 +
      #21517#31216', '#13#10'      Data0005_3.EMPLOYEE_NAME AS '#26816#26597#20154#21592', Data0025.CHECK_DAT' +
      'E AS '#26816#26597#26085#26399', '#13#10'      Data0005_1.EMPLOYEE_NAME AS '#23457#26680#20154#21592',Data0025.AUD' +
      'ITED_DATE AS '#23457#26680#26085#26399', '#13#10'      Data0005_2.EMPLOYEE_NAME AS '#20462#35746#20154#21592',Data' +
      '0025.LAST_MODIFIED_DATE AS '#20462#35746#26085#26399','#13#10'     Data0025.SAMPLE_NR AS '#26679#26495#32534 +
      #21495',Data0025.ANALYSIS_CODE_2 AS '#23458#25143#29289#26009#21495', '#13#10'Data0025.LAYERS AS '#23618#25968',Dat' +
      'a0025.ANALYSIS_CODE_1 AS '#20132#36135#23610#23544'SET, '#13#10'Data0025.ANALYSIS_CODE_5 AS ' +
      #21333#21482#23610#23544'PCS, Data0025.ANALYSIS_CODE_4 AS '#25340#29256#23610#23544'SPEL, '#13#10'Data0025.pcs_sq' +
      ' AS '#21333#21482#38754#31215'PCS, Data0025.unit_sq AS '#21333#21482#38754#31215'SET, '#13#10'     Data0025.spell_' +
      'sq AS '#21333#21482#38754#31215'SPEL, Data0025.layers_info AS '#23618#21387#32467#26500','#13#10'Data0025.REMARK a' +
      's '#21152#24037#25351#31034',Data0025.ENG_NOTE as '#24037#31243#22791#27880', barcode_flag,'#13#10'Data0025.EST_SC' +
      'RAP as '#25253#24223#29575' , Data0025.SHELF_LIFE as '#29983#20135#21608#26399', NOPB_flag,'#13#10'      Data' +
      '0025.REVIEW_DAYS as '#26377#25928#26399#22825#25968', Data0025.MFG_LEAD_TIME as '#21046#36896#25552#21069#26399', '#13#10'  ' +
      '    Data0025.ANALYSIS_CODE_3 as '#22823#26009#35268#26684', Data0025.REPORT_UNIT_VALUE' +
      '1 AS '#21333#21482#37325#37327'g, '#13#10'      dbo.Data0025.OPT_LOT_SIZE as '#27969#36716#25209#37327',data0025.Q' +
      'TY_BOM as '#21387#21512#27604#20363','#13#10'case Data0025.ONHOLD_SALES_FLAG when 0 then '#39#26377#25928 +
      #39' when 1 then '#39#36807#26399#39' end as '#38144#21806#29366#24577', '#13#10#13#10'case Data0025.TSTATUS'#13#10'   wh' +
      'en 0 then '#39#24453#21046#20316#39' when 1 then '#39#24050#23457#26680#39' when 2 then '#39#23457#36864#22238#39' when 3 then ' +
      #39#24453#26816#26597#39#13#10'   when 4 then '#39#24453#23457#26680#39' when 5 then '#39#26816#36864#22238#39' when 6 then '#39#26410#25552#20132#39' ' +
      'end as '#23457#25209#29366#24577','#13#10'case when ltrim(data0025.CURRENT_REV)='#39'Y'#39' then '#39#26080#21348 +
      #32032#39' else '#39#39' end as '#21348#32032#35201#27714','#13#10'case   Data0025.ttype  when 0 then '#39#37327#20135#39 +
      ' when 1 then '#39#26679#26495#39'  end as '#37327#20135#26679#26495','#13#10'case Data0025.green_flag when '#39 +
      'Y'#39' then '#39'4G'#26631#35782#39'  else '#39' '#39' end as '#26631#35782'4G,'#13#10'case when data0025.PARENT' +
      '_PTR is null then '#39#22806#23618#39' ELSE '#39#20869#23618#39' end as  '#20135#21697#24615#36136','#13#10'data0025.layers_' +
      'image as '#21387#21512#22270#29255','#13#10'data0025.flod_number as '#38075#23380#21472#26495#25968',data0025.ZDR_TYPE ' +
      'as '#38075#23380#21442#25968','#13#10'data0025.ORIG_CUSTOMER as '#20851#32852#21407#23458#25143', vcut_B,vcut_T,vcut_X,' +
      'gf_A,gf_L,gf_T  '#13#10'FROM dbo.Data0008 INNER JOIN'#13#10'      dbo.Data00' +
      '25 ON '#13#10'      dbo.Data0008.RKEY = dbo.Data0025.PROD_CODE_PTR INN' +
      'ER JOIN'#13#10'      dbo.Data0010 ON '#13#10'      dbo.Data0025.CUSTOMER_PTR' +
      ' = dbo.Data0010.RKEY LEFT OUTER JOIN'#13#10'      dbo.Data0005 Data000' +
      '5_3 ON '#13#10'      dbo.Data0025.CHECK_BY_PTR = Data0005_3.RKEY LEFT ' +
      'OUTER JOIN'#13#10'      dbo.Data0005 Data0005_2 ON '#13#10'      dbo.Data002' +
      '5.LAST_MODIFIED_BY_PTR = Data0005_2.RKEY LEFT OUTER JOIN'#13#10'      ' +
      'dbo.Data0005 Data0005_1 ON dbo.Data0025.AUDITED_BY_PTR = Data000' +
      '5_1.RKEY'#13#10'where data0025.rkey=:rkey'
    Parameters = <
      item
        Name = 'rkey'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = 0
      end>
    Left = 97
    Top = 48
    object ADS25RKEY: TIntegerField
      FieldName = 'RKEY'
      ReadOnly = True
    end
    object ADS25DSDesigner: TStringField
      FieldName = #26412#21378#32534#21495
    end
    object ADS25DSDesigner2: TStringField
      FieldName = #23458#25143#22411#21495
      Size = 40
    end
    object ADS25DSDesigner3: TStringField
      FieldName = #23458#25143#20195#30721
      Size = 10
    end
    object ADS25DSDesigner4: TStringField
      FieldName = #23458#25143#21517#31216
      Size = 100
    end
    object ADS25DSDesigner5: TStringField
      FieldName = #23458#25143#31616#31216
      Size = 10
    end
    object ADS25DSDesigner6: TStringField
      FieldName = #31867#22411#20195#30721
      Size = 10
    end
    object ADS25DSDesigner7: TStringField
      FieldName = #31867#22411#21517#31216
      Size = 30
    end
    object ADS25DSDesigner8: TStringField
      FieldName = #26816#26597#20154#21592
      Size = 16
    end
    object ADS25DSDesigner9: TDateTimeField
      FieldName = #26816#26597#26085#26399
    end
    object ADS25DSDesigner10: TStringField
      FieldName = #23457#26680#20154#21592
      Size = 16
    end
    object ADS25DSDesigner11: TDateTimeField
      FieldName = #23457#26680#26085#26399
    end
    object ADS25DSDesigner12: TStringField
      FieldName = #20462#35746#20154#21592
      Size = 16
    end
    object ADS25DSDesigner13: TDateTimeField
      FieldName = #20462#35746#26085#26399
    end
    object ADS25DSDesigner14: TStringField
      FieldName = #26679#26495#32534#21495
      Size = 15
    end
    object ADS25DSDesigner15: TStringField
      FieldName = #23458#25143#29289#26009#21495
      Size = 50
    end
    object ADS25DSDesigner16: TWordField
      FieldName = #23618#25968
    end
    object ADS25SET: TStringField
      FieldName = #20132#36135#23610#23544'SET'
      Size = 30
    end
    object ADS25PCS: TStringField
      FieldName = #21333#21482#23610#23544'PCS'
      Size = 30
    end
    object ADS25SPEL: TStringField
      FieldName = #25340#29256#23610#23544'SPEL'
      Size = 30
    end
    object ADS25PCS2: TFloatField
      FieldName = #21333#21482#38754#31215'PCS'
    end
    object ADS25SET2: TFloatField
      FieldName = #21333#21482#38754#31215'SET'
    end
    object ADS25SPEL2: TFloatField
      FieldName = #21333#21482#38754#31215'SPEL'
    end
    object ADS25DSDesigner17: TMemoField
      FieldName = #23618#21387#32467#26500
      BlobType = ftMemo
    end
    object ADS25DSDesigner18: TMemoField
      FieldName = #21152#24037#25351#31034
      BlobType = ftMemo
    end
    object ADS25DSDesigner19: TStringField
      FieldName = #24037#31243#22791#27880
      Size = 200
    end
    object ADS25DSDesigner20: TFloatField
      FieldName = #25253#24223#29575
    end
    object ADS25DSDesigner21: TIntegerField
      FieldName = #29983#20135#21608#26399
    end
    object ADS25DSDesigner22: TSmallintField
      FieldName = #26377#25928#26399#22825#25968
    end
    object ADS25DSDesigner23: TSmallintField
      FieldName = #21046#36896#25552#21069#26399
    end
    object ADS25DSDesigner24: TStringField
      FieldName = #22823#26009#35268#26684
      Size = 50
    end
    object ADS25g: TBCDField
      FieldName = #21333#21482#37325#37327'g'
      Precision = 9
    end
    object ADS25DSDesigner25: TIntegerField
      FieldName = #27969#36716#25209#37327
    end
    object ADS25DSDesigner26: TStringField
      FieldName = #38144#21806#29366#24577
      ReadOnly = True
      Size = 4
    end
    object ADS25DSDesigner27: TStringField
      FieldName = #23457#25209#29366#24577
      ReadOnly = True
      Size = 6
    end
    object ADS25DSDesigner28: TStringField
      FieldName = #37327#20135#26679#26495
      ReadOnly = True
      Size = 4
    end
    object ADS25DSDesigner30: TStringField
      FieldName = #20135#21697#24615#36136
      ReadOnly = True
      Size = 4
    end
    object ADS25Field1: TWideStringField
      FieldKind = fkCalculated
      FieldName = #20840#23616#21442#25968'1'
      Size = 2000
      Calculated = True
    end
    object ADS25Field2: TWideStringField
      FieldKind = fkCalculated
      FieldName = #20840#23616#21442#25968'2'
      Size = 2000
      Calculated = True
    end
    object ADS25DSDesigner31: TWordField
      FieldName = #21387#21512#27604#20363
    end
    object ADS25DSDesigner32: TStringField
      FieldName = #21348#32032#35201#27714
      ReadOnly = True
      Size = 6
    end
    object ADS25barcode_flag: TWordField
      FieldName = 'barcode_flag'
    end
    object ADS25NOPB_flag: TWordField
      FieldName = 'NOPB_flag'
    end
    object ADS25DSDesigner35: TBlobField
      FieldName = #21387#21512#22270#29255
    end
    object ADS25DSDesigner33: TIntegerField
      FieldName = #38075#23380#21472#26495#25968
    end
    object ADS25DSDesigner34: TWideStringField
      FieldName = #38075#23380#21442#25968
      Size = 50
    end
    object strngfldADS25DSDesigner36: TStringField
      FieldName = #20851#32852#21407#23458#25143
      Size = 30
    end
    object ADS25DSDesigner4G: TStringField
      FieldName = #26631#35782'4G'
      ReadOnly = True
      Size = 6
    end
    object ADS25vcut_B: TStringField
      FieldName = 'vcut_B'
      Size = 30
    end
    object ADS25vcut_T: TStringField
      FieldName = 'vcut_T'
      Size = 30
    end
    object ADS25vcut_X: TStringField
      FieldName = 'vcut_X'
      Size = 30
    end
    object ADS25gf_A: TStringField
      FieldName = 'gf_A'
      Size = 30
    end
    object ADS25gf_L: TStringField
      FieldName = 'gf_L'
      Size = 30
    end
    object ADS25gf_T: TStringField
      FieldName = 'gf_T'
      Size = 30
    end
  end
  object ads279: TADODataSet
    Connection = DM.ADOConnection1
    CursorType = ctStatic
    LockType = ltReadOnly
    CommandText = 
      'SELECT TOP 100 PERCENT Data0278.PARAMETER_NAME , '#13#10'      Data027' +
      '8.PARAMETER_DESC,'#13#10'    Data0279.PARAMETER_VALUE ,Data0002.UNIT_C' +
      'ODE'#13#10'FROM dbo.Data0279 INNER JOIN'#13#10'      dbo.Data0278 ON '#13#10'     ' +
      ' dbo.Data0279.PARAMETER_PTR = dbo.Data0278.RKEY INNER JOIN'#13#10'    ' +
      '  dbo.Data0002 ON dbo.Data0278.UNIT_PTR = dbo.Data0002.RKEY'#13#10'WHE' +
      'RE (Data0279.IES_PROD = 1) AND '#13#10'               (data0278.status' +
      '=0) and'#13#10'               (Data0279.SOURCE_PTR = :rkey) and'#13#10'     ' +
      '          (Data0279.PARAMETER_VALUE <> :value)'#13#10'ORDER BY dbo.Dat' +
      'a0279.IES_CRP'
    Parameters = <
      item
        Name = 'rkey'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'value'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 30
        Value = #39#39
      end>
    Left = 65
    Top = 48
    object ads279PARAMETER_NAME: TStringField
      FieldName = 'PARAMETER_NAME'
      Size = 10
    end
    object ads279PARAMETER_DESC: TStringField
      FieldName = 'PARAMETER_DESC'
    end
    object ads279PARAMETER_VALUE: TStringField
      FieldName = 'PARAMETER_VALUE'
      Size = 30
    end
    object ads279UNIT_CODE: TStringField
      FieldName = 'UNIT_CODE'
      Size = 5
    end
  end
  object ads38: TADODataSet
    Connection = DM.ADOConnection1
    CursorType = ctStatic
    LockType = ltReadOnly
    OnCalcFields = ads38CalcFields
    CommandText = 
      'SELECT data0038.grade_note,Data0034.DEPT_CODE as '#24037#24207#20195#30721', Data0034.' +
      'DEPT_NAME as '#24037#24207#21517#31216', '#13#10'      Data0038.STEP_NUMBER, Data0038.toolin' +
      'g_rev as '#24037#20855#29256#26412', '#13#10'      Data0034.BARCODE_ENTRY_FLAG as '#36807#25968', Data00' +
      '38.OUTP_SPFC as '#20135#20986', '#13#10'      Data0038.DEF_ROUT_INST as '#22791#27880', data00' +
      '38.SOURCE_PTR'#13#10'FROM Data0038 INNER JOIN'#13#10'      Data0034 ON dbo.D' +
      'ata0038.DEPT_PTR = Data0034.RKEY'#13#10'WHERE  (Data0038.SOURCE_PTR = ' +
      ':rkey) and'#13#10'                (data0034.visible_in_mi <> :visible)' +
      #13#10'order by Data0038.STEP_NUMBER'
    Parameters = <
      item
        Name = 'rkey'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = 0
      end
      item
        Name = 'visible'
        Attributes = [paNullable]
        DataType = ftWord
        Precision = 3
        Size = 1
        Value = 2
      end>
    Left = 96
    Top = 77
    object ads38DSDesigner: TStringField
      FieldName = #24037#24207#20195#30721
      Size = 10
    end
    object ads38DSDesigner2: TStringField
      FieldName = #24037#24207#21517#31216
      Size = 30
    end
    object ads38STEP_NUMBER: TSmallintField
      DisplayLabel = #27493#39588
      FieldName = 'STEP_NUMBER'
    end
    object ads38DSDesigner3: TStringField
      FieldName = #24037#20855#29256#26412
      Size = 10
    end
    object ads38DSDesigner4: TStringField
      FieldName = #36807#25968
      Size = 1
    end
    object ads38DSDesigner5: TBCDField
      FieldName = #20135#20986
      Precision = 19
    end
    object ads38DSDesigner6: TStringField
      FieldName = #22791#27880
      Size = 400
    end
    object ads38SOURCE_PTR: TIntegerField
      FieldName = 'SOURCE_PTR'
    end
    object ads38WideStringField: TWideStringField
      FieldKind = fkCalculated
      FieldName = #24037#33402#21442#25968
      Size = 2000
      Calculated = True
    end
    object ads38grade_note: TWideStringField
      FieldName = 'grade_note'
      Size = 2048
    end
  end
  object DataSource2: TDataSource
    DataSet = ads38
    Left = 128
    Top = 77
  end
  object ads494: TADODataSet
    Connection = DM.ADOConnection1
    CursorType = ctStatic
    Filtered = True
    LockType = ltReadOnly
    CommandText = 
      'SELECT dbo.Data0278.PARAMETER_NAME, dbo.Data0278.PARAMETER_DESC,' +
      ' '#13#10'      dbo.Data0494.PARAMETER_VALUE, dbo.Data0002.UNIT_CODE,'#13#10 +
      'data0494.step_number'#13#10'FROM dbo.Data0494 INNER JOIN'#13#10'      dbo.Da' +
      'ta0278 ON '#13#10'      dbo.Data0494.PARAMETER_PTR = dbo.Data0278.RKEY' +
      ' INNER JOIN'#13#10'      dbo.Data0002 ON dbo.Data0278.UNIT_PTR = dbo.D' +
      'ata0002.RKEY'#13#10'where data0494.custpart_ptr = :source_ptr and'#13#10'   ' +
      '        Data0494.PARAMETER_VALUE <> :value and'#13#10'           data0' +
      '494.doc_flag='#39'Y'#39#13#10'order by data0494.step_number, data0494.seq_no'
    Parameters = <
      item
        Name = 'source_ptr'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end
      item
        Name = 'value'
        Attributes = [paNullable]
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 30
        Value = Null
      end>
    Left = 64
    Top = 77
    object ads494PARAMETER_NAME: TStringField
      FieldName = 'PARAMETER_NAME'
      Size = 10
    end
    object ads494PARAMETER_DESC: TStringField
      FieldName = 'PARAMETER_DESC'
    end
    object ads494PARAMETER_VALUE: TStringField
      FieldName = 'PARAMETER_VALUE'
      Size = 30
    end
    object ads494UNIT_CODE: TStringField
      FieldName = 'UNIT_CODE'
      Size = 5
    end
    object ads494step_number: TSmallintField
      FieldName = 'step_number'
    end
  end
  object ads192: TADODataSet
    Connection = DM.ADOConnection1
    CursorType = ctStatic
    LockType = ltReadOnly
    CommandText = 'SELECT ENG_CONTROL2, ENG_CONTROL16'#13#10'FROM dbo.Data0192'
    Parameters = <>
    Left = 97
    Top = 15
    object ads192ENG_CONTROL2: TWordField
      DisplayLabel = #19981#26174#31034#20026#31354#30340#21046#31243#21442#25968
      FieldName = 'ENG_CONTROL2'
    end
    object ads192ENG_CONTROL16: TWordField
      DisplayLabel = #19981#26174#31034#20026#31354#30340#20840#23616#21442#25968
      FieldName = 'ENG_CONTROL16'
    end
  end
  object ppReport1: TppReport
    AutoStop = False
    DataPipeline = ppDB38
    PassSetting = psTwoPass
    PrinterSetup.BinName = 'Default'
    PrinterSetup.DocumentName = 'Report'
    PrinterSetup.PaperName = 'A4'
    PrinterSetup.PrinterName = 'Default'
    PrinterSetup.mmMarginBottom = 350
    PrinterSetup.mmMarginLeft = 6350
    PrinterSetup.mmMarginRight = 6350
    PrinterSetup.mmMarginTop = 5350
    PrinterSetup.mmPaperHeight = 297000
    PrinterSetup.mmPaperWidth = 210000
    PrinterSetup.PaperSize = 9
    SaveAsTemplate = True
    Template.FileName = 'D:\HTWISDOMPCB\NIERP\REPORT\MANU_INSTRUCTION.RTM'
    Units = utMillimeters
    CachePages = True
    DeviceType = 'Screen'
    OutlineSettings.CreateNode = True
    OutlineSettings.CreatePageNodes = True
    OutlineSettings.Enabled = False
    OutlineSettings.Visible = False
    PreviewFormSettings.WindowState = wsMaximized
    PreviewFormSettings.ZoomSetting = zsPercentage
    PreviewFormSettings.ZoomPercentage = 140
    TextSearchSettings.DefaultString = '<FindText>'
    TextSearchSettings.Enabled = True
    Left = 200
    Top = 79
    Version = '7.01'
    mmColumnWidth = 0
    DataPipelineName = 'ppDB38'
    object ptlbnd1: TppTitleBand
      Visible = False
      PrintHeight = phDynamic
      mmBottomOffset = 0
      mmHeight = 0
      mmPrintPosition = 0
    end
    object phdrbnd1: TppHeaderBand
      PrintHeight = phDynamic
      mmBottomOffset = 0
      mmHeight = 32808
      mmPrintPosition = 0
      object ppDBText3: TppDBText
        UserName = 'DBText3'
        AutoSize = True
        DataField = #26412#21378#32534#21495
        DataPipeline = ppDB25
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = #23435#20307
        Font.Size = 10
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'ppDB25'
        mmHeight = 4022
        mmLeft = 22754
        mmTop = 22754
        mmWidth = 14055
        BandType = 0
      end
      object ppDBText4: TppDBText
        UserName = 'DBText4'
        AutoSize = True
        DataField = #23458#25143#22411#21495
        DataPipeline = ppDB25
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = #23435#20307
        Font.Size = 10
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'ppDB25'
        mmHeight = 4022
        mmLeft = 22754
        mmTop = 27781
        mmWidth = 14055
        BandType = 0
      end
      object ppLabel7: TppLabel
        UserName = 'Label7'
        Caption = #26412#21378#32534#21495':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = #23435#20307
        Font.Size = 10
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3969
        mmLeft = 5292
        mmTop = 22754
        mmWidth = 15875
        BandType = 0
      end
      object ppLabel8: TppLabel
        UserName = 'Label8'
        Caption = #23458#25143#22411#21495':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = #23435#20307
        Font.Size = 10
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3969
        mmLeft = 5292
        mmTop = 27781
        mmWidth = 15875
        BandType = 0
      end
      object ppLabel9: TppLabel
        UserName = 'Label9'
        Caption = #23458#25143#20195#30721':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = #23435#20307
        Font.Size = 10
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3969
        mmLeft = 5292
        mmTop = 17198
        mmWidth = 15875
        BandType = 0
      end
      object ppDBText12: TppDBText
        UserName = 'DBText12'
        AutoSize = True
        DataField = #23458#25143#20195#30721
        DataPipeline = ppDB25
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = #23435#20307
        Font.Size = 10
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'ppDB25'
        mmHeight = 4022
        mmLeft = 22754
        mmTop = 17198
        mmWidth = 14055
        BandType = 0
      end
      object ppDBText13: TppDBText
        UserName = 'DBText13'
        AutoSize = True
        DataField = #20135#21697#24615#36136
        DataPipeline = ppDB25
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = #23435#20307
        Font.Size = 10
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'ppDB25'
        mmHeight = 4022
        mmLeft = 75406
        mmTop = 17198
        mmWidth = 14055
        BandType = 0
      end
      object ppDBText14: TppDBText
        UserName = 'DBText14'
        AutoSize = True
        DataField = #31867#22411#21517#31216
        DataPipeline = ppDB25
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = #23435#20307
        Font.Size = 10
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'ppDB25'
        mmHeight = 4022
        mmLeft = 75406
        mmTop = 22754
        mmWidth = 14055
        BandType = 0
      end
      object ppLabel11: TppLabel
        UserName = 'Label11'
        Caption = #20135#21697#31867#22411':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = #23435#20307
        Font.Size = 10
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3969
        mmLeft = 58473
        mmTop = 22754
        mmWidth = 15875
        BandType = 0
      end
      object ppLabel12: TppLabel
        UserName = 'Label12'
        Caption = #20135#21697#24615#36136':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = #23435#20307
        Font.Size = 10
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3969
        mmLeft = 58473
        mmTop = 17198
        mmWidth = 15875
        BandType = 0
      end
      object ppLabel15: TppLabel
        UserName = 'Label15'
        Caption = #21333#21482#23610#23544':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = #23435#20307
        Font.Size = 10
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3969
        mmLeft = 112448
        mmTop = 17198
        mmWidth = 15875
        BandType = 0
      end
      object ppLabel16: TppLabel
        UserName = 'Label16'
        Caption = #20132#36135#23610#23544':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = #23435#20307
        Font.Size = 10
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3969
        mmLeft = 112448
        mmTop = 22754
        mmWidth = 15875
        BandType = 0
      end
      object ppLabel17: TppLabel
        UserName = 'Label17'
        Caption = #25340#29256#23610#23544':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = #23435#20307
        Font.Size = 10
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3969
        mmLeft = 112448
        mmTop = 27781
        mmWidth = 15875
        BandType = 0
      end
      object ppDBText16: TppDBText
        UserName = 'DBText16'
        AutoSize = True
        DataField = #21333#21482#23610#23544'PCS'
        DataPipeline = ppDB25
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = #23435#20307
        Font.Size = 10
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'ppDB25'
        mmHeight = 4022
        mmLeft = 130704
        mmTop = 17198
        mmWidth = 19389
        BandType = 0
      end
      object ppDBText17: TppDBText
        UserName = 'DBText17'
        AutoSize = True
        DataField = #20132#36135#23610#23544'SET'
        DataPipeline = ppDB25
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = #23435#20307
        Font.Size = 10
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'ppDB25'
        mmHeight = 4022
        mmLeft = 130704
        mmTop = 22754
        mmWidth = 19389
        BandType = 0
      end
      object ppDBText18: TppDBText
        UserName = 'DBText18'
        AutoSize = True
        DataField = #25340#29256#23610#23544'SPEL'
        DataPipeline = ppDB25
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = #23435#20307
        Font.Size = 10
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'ppDB25'
        mmHeight = 4022
        mmLeft = 130704
        mmTop = 27781
        mmWidth = 21167
        BandType = 0
      end
      object ppDBImage1: TppDBImage
        UserName = 'DBImage1'
        MaintainAspectRatio = False
        Stretch = True
        DataField = 'Company_Icon'
        DataPipeline = ppDB493
        GraphicType = 'Bitmap'
        ParentDataPipeline = False
        DataPipelineName = 'ppDB493'
        mmHeight = 14817
        mmLeft = 794
        mmTop = 0
        mmWidth = 23548
        BandType = 0
      end
      object ppDBText11: TppDBText
        UserName = 'DBText11'
        AutoSize = True
        DataField = 'Company_Name'
        DataPipeline = ppDB493
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = #23435#20307
        Font.Size = 16
        Font.Style = [fsBold]
        ParentDataPipeline = False
        TextAlignment = taCentered
        Transparent = True
        DataPipelineName = 'ppDB493'
        mmHeight = 6435
        mmLeft = 62669
        mmTop = 1323
        mmWidth = 68072
        BandType = 0
      end
      object ppLabel13: TppLabel
        UserName = 'Label13'
        Caption = 'Manufacturing Instructions'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = #23435#20307
        Font.Size = 12
        Font.Style = [fsBold]
        TextAlignment = taCentered
        Transparent = True
        mmHeight = 4763
        mmLeft = 67469
        mmTop = 8731
        mmWidth = 56092
        BandType = 0
      end
      object ppSystemVariable2: TppSystemVariable
        UserName = 'SystemVariable2'
        VarType = vtDateTime
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = #23435#20307
        Font.Size = 10
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3969
        mmLeft = 162454
        mmTop = 4233
        mmWidth = 30163
        BandType = 0
      end
      object ppSystemVariable1: TppSystemVariable
        UserName = 'SystemVariable1'
        VarType = vtPageSetDesc
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = #23435#20307
        Font.Size = 10
        Font.Style = []
        TextAlignment = taRightJustified
        Transparent = True
        mmHeight = 3969
        mmLeft = 172509
        mmTop = 9260
        mmWidth = 19579
        BandType = 0
      end
      object ppVariable3: TppVariable
        UserName = 'Variable3'
        CalcOrder = 2
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = #23435#20307
        Font.Size = 10
        Font.Style = []
        Transparent = True
        Visible = False
        mmHeight = 3969
        mmLeft = 42863
        mmTop = 8731
        mmWidth = 19050
        BandType = 0
      end
      object ppImage6: TppImage
        UserName = 'Image6'
        MaintainAspectRatio = False
        Stretch = True
        Picture.Data = {
          0A544A504547496D6167651E280000FFD8FFE000104A46494600010100000100
          010000FFDB004300010101010101010101010101010101010101010101010101
          0101010101010101010101010101010101010101010101010101010101010101
          0101010101010101FFDB00430101010101010101010101010101010101010101
          0101010101010101010101010101010101010101010101010101010101010101
          01010101010101010101010101FFC00011080088008303012200021101031101
          FFC4001F0000010501010101010100000000000000000102030405060708090A
          0BFFC400B5100002010303020403050504040000017D01020300041105122131
          410613516107227114328191A1082342B1C11552D1F02433627282090A161718
          191A25262728292A3435363738393A434445464748494A535455565758595A63
          6465666768696A737475767778797A838485868788898A92939495969798999A
          A2A3A4A5A6A7A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6
          D7D8D9DAE1E2E3E4E5E6E7E8E9EAF1F2F3F4F5F6F7F8F9FAFFC4001F01000301
          01010101010101010000000000000102030405060708090A0BFFC400B5110002
          0102040403040705040400010277000102031104052131061241510761711322
          328108144291A1B1C109233352F0156272D10A162434E125F11718191A262728
          292A35363738393A434445464748494A535455565758595A636465666768696A
          737475767778797A82838485868788898A92939495969798999AA2A3A4A5A6A7
          A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6D7D8D9DAE2E3
          E4E5E6E7E8E9EAF2F3F4F5F6F7F8F9FAFFDA000C03010002110311003F00FEFE
          28A28A0028A29AEE91AB3BB2A222B3BBBB05544504B3331202AA804B31200009
          271400EA09001248000C9278000EA49EC057E2BFED55FF000598F879F0FBE236
          A3FB347EC61F0AFC61FB77FED6704CDA7DEFC3CF83882FFC0DF0F6F183C6D79F
          13FE21C025D1346834B94C13EABA55B5D3EA8B6521915A160057845B7EC09FF0
          54AFDB9BECFE21FDBFBF6CFBCFD99FE1F6A5E4DF8FD97FF62AB97F0F4FA5324A
          49D2FC4BF186E44DAD6B96D7768DE4DEC36D238525D1240496A076D2EDA5F9BF
          96FF007D93EE7EC17C65FDB53F648FD9EB4DBDD57E357ED1DF077E1CDA69C8F2
          DF2F88BC77A0C37D6B1A0CB34DA55BDE5C6A8831D3367F31042E4A903E0FBEFF
          0082F97FC12B23923FEC0FDA6EC3C75692072355F01F82BC77E26D240560AA7F
          B42CFC3A207597930BC4D2472AAB32390327ABF82BFF000443FF0082687C13BC
          BED72CBF66AF0C7C48F17EB325BDC6BDE33F8D577AAFC5BF10EB5796F10892EA
          F25F1BDE6AF651B1518315AD9C10B7574762CC7F41FC31F00BE05782B4F8B48F
          077C17F851E14D2A18E3861D37C39F0EFC23A2D8C5142A5628E3B4D3B48B6811
          2352422AA0540485033407BBE6FEE5FE67E610FF0082FAFF00C131F237FC68F1
          344991BE597E14FC4548A25CFCD24AE7C3F848E319791CF0A80B1E95EDBF09BF
          E0B11FF04C8F8DBADCDE19F87BFB66FC17BFF135B083ED7E1ED6B5E9FC25AB5A
          1BA245B8B8B6F1559E8C10CA41DA448CA307711835F793FC30F869223C727C3C
          F03491C88D1C91BF84B4074747055D1D5B4F2AC8CA4AB2B0218120820D7CD3F1
          4BFE09D3FB09FC67B7BC83E23FEC95F00F5F96FD254BBD493E19785749D6E612
          C62272FADE8DA6E9FAAB3040046CD764C5D63DADCD1AF5FCADFAB0D3B3FBD3FC
          2CBF33EB3F0FF89FC37E2CD3E3D5BC2BE21D0FC4DA54C018B53F0FEAD61ACE9F
          2861B94C77BA75C5CDB382BC8DB29C8E4715B95F81FE24FF008212F82BE14DEC
          3E2EFF008277FED45FB427EC3DE30D217529F48F0B786FC6FACF8F7E0A6A37B7
          FB1847E22F875E31BCD4EDE6B1B7955A5816CE78E480BBA4636B2ECE13FE1E13
          FF000516FF0082724B1E8FFF00053CFD9D1BE3C7C02B2956DD3F6DFF00D92F46
          BCD6A0D174E82D91A6D5FE2FFC22891F54D05AE2ECBC168FA2A43118D1A7951D
          4503B5F677F2D9EF6B2E8DF9277F23FA2BA2BC63E02FED0FF057F69EF873A37C
          58F80BF11BC31F137C05AEC4AF67AEF8675282FA2867D8AD369FA8C08DF68D37
          53B466315DD85EC50DCC12AB2BC7C64FB3D04851451400514514005145140195
          AEEBBA2F85F45D5BC49E23D574FD0BC3FA169D79AB6B5AD6AD77058699A5697A
          7C0F737B7F7F7B72F1DBDADA5ADBC724D3CF33A471C68CCCC00AFE6DBC65F1AF
          F6A3FF0082DCF8CFC53F06FF00640F1878AFF665FF0082727853C4373E17F8B7
          FB5869D6B3E99F11BF68F82D2468357F0A7C0996758A4D3BC237BE55D69BA8F8
          93E43736933CACC9E6D9257C91FF00054FFF00828AFC2DFDAF7F6C2F017FC13F
          7C43F13FC63F07FF00E09EBE19F89D61E0BFDB0BF693F0C58EAF0F833C71F12B
          CB927D07E01DC7C40D36DE5D2B47F0EDEEA8B6DA77892EE5BC487ED534571334
          96968D19FEB5FE16F817E1F7C33F875E0CF027C29D1742F0F7C39F0CF87749D2
          FC1DA5786A2B48F448340B7B28534D7D3DAC47D9AE21B8B611DC0BC8DA4FB619
          0DD34B234A5D82BE1B3B6AD5D765E7E6FF002D3E5E2BFB257EC59FB377EC43F0
          D2CFE167ECE3F0D745F02E851ECB8D67548A2179E2AF176ABE5A473EBBE2FF00
          12DC87D57C41AC5D045F3AEEFAE1F01552348D1428FAA28A282428A28A0028A2
          8A002AB5ED959EA3697361A85A5B5FD8DE4125B5E595E4115D5A5D5BCC8526B7
          B9B79D5E19E19518A4914A8C8EA4AB29048AB345007F3E9FB477FC12E3E2DFEC
          AFF10FC49FB677FC120759B1F857F166EA64D73E2D7EC91AADECD6FF00B3EFED
          156560AD25DD859E85BBFB3FC0FE33BDB7F322B1D534D8EDEDA4BA93CF212E96
          20FF007C7FC13B7FE0A37F0AFF00E0A05F0EF5CBFD1748D5BE17FC71F861AA49
          E11F8F7FB3EF8D42D8F8FF00E14F8DAC1BECDA958EA1A74A52E2EF439EED1DF4
          8D6628CDBDD5AC96E5D9649503FE89D7E117FC14CBF610F88DE15F88BA6FFC14
          FBFE09FB6B0F857F6D1F83763F6BF897E09D3D2483C31FB577C24D322797C43E
          01F1AE8B69E5C1AAF8BA0D2D6E1BC2BAE48AFA824EAB6E3CF9FC8560ABDF47BF
          46FF0027E5D9F4F43F7768AF92BF621FDB13E177EDD5FB39F817F685F8557A0E
          9DE23B6974EF14F86EE1D46B3E03F1DE8E56D3C59E07F10DB67CDB3D5FC3FAA2
          CB6D3433AA4AD09826748DA468D3EB5A090A28A2800AFC93FF0082C27ED77E3C
          FD9C7F678D03E15FC008A3D53F6B1FDAEFC6761FB3E7ECEFA2ADCB5ADC5AF88B
          C5ABF64D77C66F711C73B595AF833449E7D5BEDB2C26DE2BA5B7DCC08AFD6CAF
          E793F67A917F6F2FF82D87ED23FB415E5C59EBBF04FF00E09B9E12B5FD993E0F
          4513CCD027C7AF18DB2EA9F16F56BFB39C3595CDDE8F6AF2D8E91A9DAA8B8B55
          6850CC0AED20D6F77AA5ADBBF97DFBF91F73FECE7FF04B9FD9BFE14FEC0BA6FE
          C25F113C11A1FC51F04F89B40BBBAF8D577E21B5FB5DDFC46F895E271F6FF187
          8F2FEF66692EA2D76E75A9659F4ED42096396C6282DE3804710789BF2F3E1D7C
          49FDA27FE084DF1174AF81BFB45DFF008D3E3DFF00C12DBC6FE2BB7D0FE05FED
          2978FA8F897C6FFB2AB6A8667B1F871F191E3B7B8BAB9F055A3FEE742F134D27
          93169D6D3106036535BCBFD3BD7F9CDFFC1D1DFB427C7EF0D7FC1463C45F06BC
          39F1BFE2BE81F07B5BFD9DBE145D6B3F0A747F1CEBD61F0F356BAD46EBC51FDA
          173A8784ADEF1347BAB8BEFB3DBFDAE696D9A49FC88BCC66D8B80A82E7972DF7
          D75D7E7EBE67FA23785FC51E1CF1B787745F1778435CD2FC4BE17F11E9B6BAC6
          83AFE897B06A3A4EAFA65EC4B35A5F585EDB3C905C5BCF13064923723AA9C306
          037ABFC85BC13AAFFC15CBE17FECD7A27C5DF86DE20FDBCBE1FF00EC81A36872
          EA7E1BF885E0BF127C47D0FE06E97E1B5D4AE6CA7BED1F50D2B514D22D7484D5
          E3BCB6964B785614BC8EE15B0558D7B8781ACBFE0E01F89FE13D13C79F0D2FFF
          00E0A87F103C0FE25B38F51F0F78BBC21E2CF8A9AE787B5AB194662BBD3B52B3
          D69E19E19072AC0838209033417EC7FBF13FD5E68AFF002C5D27C6FF00F07157
          ECCF7371F157548BFE0A43E1CB1D234EBE8EF755F8ABA778FBC5BE10B4B19216
          3797377A3F89AE750D2CCB042AD24776F6C66B6C192260C2BF48FF00E09D9FF0
          7517ED15E00F1BF86FE1EFEDF965A47C5BF85DA96A5FD97AA7C5CF0FE8369E18
          F88FE0B375771DBC379ABE87A6436BA4EB7A3E8B1EE6D4035AFF006F5CAAC8ED
          379A73409D292D5352B6F67AFDC7FA0BD15CCF833C63E18F885E13F0E78E7C17
          AD58F88BC27E2DD1AC35FF000EEB9A64E97361AA693A9DBA5D595E5B4D192AF1
          CB0C8A48CEE46DC8E15D5947F0F5FF000757FED39FB4B7C0DFDA5BF67AD1BE08
          FED0BF1A7E0F68FAB7C25D5EFF0055D27E19FC45F12F8334ED4EFA3D66FE38EF
          6FED344BEB486EAE923458D27995A4545550400282231E676BD8FEEAE8AFCB9F
          F822CF8DBC69F11BFE0987FB2478D7E21F8BFC4BE3CF196BDF0FEFAEF5DF16F8
          BF58BDD7FC47AD5D278AFC4102DCEA9AC6A32CD7B7D3AC11450ACB3CAEE228A3
          4076A281FA8D412F46D760A28A2803F9B7F13E9D17FC1223FE0A91A178EF455B
          4F0CFEC21FF0533F1341E18F1F697142F6BE1BF841FB5BC6927F61789D3CB64D
          3342D27E268B93677290D9ACB7FAC4933CD33185597FA48AFCFF00FF0082A07E
          C9569FB69FEC49F1BBE0AC127F67F8D8F875BC71F09BC4905AC375AA7853E2AF
          80DBFE125F056B9A30995921D4BFB46C7FB3229C83E5C5A8CCC06E0A4647FC12
          93F6A7D4BF6BEFD85BE087C53F15A3DAFC4DD2F439BE1BFC5ED2AE2749F50D2F
          E277C38BA97C27E298B5228495BDBEBAD357559C3053BEFCE140C5037AA4FE4F
          F4F3DB4F96E7E8BD1451408F1FFDA0BE28E93F04BE067C5DF8BBAE5CC767A57C
          37F875E2FF0018DE5CCAC12289342D12F2F91A472405433431AB313C039AFCC2
          FF00820AFC2CD67C0FFF0004EDF875F11FC657306ADF11BF69AF13F8DFF690F1
          D78863D3E2D3E7D6AFFE28F88AFB5BD29E78E32C5D2D34492C6DAD9DDD898402
          A76B015D77FC174FC5A3C2BFF04B2FDAC2DCF998F1BF82ACBE1BBF948CCC61F1
          D6B9A6E83708CCAC8638E6B6BA9A096507E48E4635F7A7ECAFF0F34BF84BFB34
          7C01F863A2D9C3A7E93E03F83DF0EFC2DA758DB9261B5B4D1BC2BA5D94304659
          9D8AC6B105059D89C64B127340FECFABFC97FF006C7BDD7F99EFFC1D51FF0029
          61BFFF00B36FF839FF00A55E2EAFF4C2AFF33DFF0083AA3FE52C37FF00F66DFF
          00073FF4ABC5D41A51F8D7A33FB18FF820CF87340F18FF00C113BF626F0AF8AF
          46D33C47E1AF10FC19F1468FAE683AD5941A8E95AB6957DF117C796D79A7EA16
          37492DBDD5A5C40ED14B0CB1B2321C63A57C71F11BE10FC7CFF82177C43D63E3
          E7ECAFA3F8B3E377FC133BC75E2CFED6F8E9FB2B69E97FAEF8ABF6655D4360D4
          3E20FC1588BDC5C4DE12B66DD35F786D145BD9D9411DA4BE5C36F673BFDC3FF0
          6FAFFCA1B7F60EFF00B257AEFF00EACCF1CD7EC4DD5ADADF5B5C595EDB417967
          7904B6B7769750C7716D756D3C6D14F6F7104CAF14F04D13B472C52A347246CC
          8EACA48210DD9BEAAEEEBBEAFF001F3FF3678CFC00FDA07E0CFED61F07BC23F1
          B7E0778CB45F88DF0B7C7DA625F68DADE9CC9342EACA05DE97AB58CA3CFD3757
          D3A626D754D22FE28AEECAE51A29E21F296FE097FE0E99FF008279FC34FD9ABE
          37FC33FDAA7E0D787344F05F85BF68AB8D6F44F893E16D22236560FF001474C8
          D7514F11E93A5411A58D8C7AF691F699B5CF2B61B8D4E38A548951881FBE1F1F
          BF64BF8FDFF048EF8BBE2DFDB7BFE09C3E1AD53E217ECB3E2FBEBEF14FED7DFB
          07D9DF5D1B1819D9EE352F8BBF012C161BA4D1F5BD3E069EE75BF0D58C1B6F23
          592EA286EC99215FC2CFF8395BFE0A51FB3A7EDBBF0ABF62CF0C7C00F118F14C
          5326BDF183C528F13DAEADE02BEB8B08BC3D1F81BC5DA7CC166D33C4F0C97773
          2DCD932B044B4760FCE005D3BA9AE5774F7F4DDA7F77CF747EDC7FC1AA5FB45F
          89BE2FFF00C13CB59F855E2BD525D5EEFF00675F897A97833C3B3CECCD2D8781
          35D8A4D57C31A212CCE5E3D28DB6A4B14ACDBE44B8DA55446057E2BFFC1E03FF
          002751FB35FF00D91BD6BFF4F9A8D7EB0FFC1A41F08B5CF077EC33F177E2AEAD
          677D6365F187E345CFF60ADE40D0457BA5F816C6E34B5D56C378569ECAF26D55
          D62B95CC33181BCB66D8D8FCA0FF0083BF94BFED55FB3420EAFF000775851F56
          D775003F9D052B7B576DAFFAA3FAAAFF00821490BFF049CFD8CD988555F86FA8
          966240000F1878909249E0003924F0057DCBA9FED7DFB2768BE283E08D63F69C
          FD9F74AF19ADE41A7B784B51F8C7F0F2CBC482FEE702DAC8E8773E228F521777
          048F26DCDB79B2E46C46CD7F9B368FFB7EFEDE3FB677ECD3FB2FFF00C12B7F61
          CF08FC45D3B49F01F826F341F1FD87C34BD9EC3C55F142EAEBC417BAB4B7BE21
          F13433D8AF853C15A3457A8E54EA5A77DA2482777BB9CECB75F70D57FE0D51FF
          0082A69D2DFC7B75AA7ECF5ADF8A12D62D58E987E24F89AF3E203DDC71892381
          759BFF000C0B67D5A0FB91C9FDBFFBB906C8AE011409D3577CF3516EED2DDAEC
          DFAF6FF836FF004A9B3BDB3D46D60BED3EEEDAFACAE6312DB5E59CF15CDADC44
          DF76482E20778A58DBB3C6ECA7B1AB35FE567FB20FFC1497FE0A1DFF00046AFD
          A36E3E1B7C52FF00859DFF0008BF87B5C4B3F8B7FB367C5CD4354D4EDAE74F96
          E76DDEB1E18BCD52E6F65B2D505B079748D5748D46E34A9908411BAB9AFF004D
          AFD9ABF685F86FFB567C0BF869FB41FC24D5D35AF007C51F0C58789B42BA0713
          C29749B6EB4FBD88E1E0BED3AED27B3BA86454759212DB423A921138385B54D3
          D9ADBFAFCFA753DCABF9F6FF00825A5849FB37FF00C145FF00E0AADFB16DB680
          FE1FF02DCFC49F08FED69F0C59E5436FABD9FC67D2D13C65369D06F2D0456DE2
          3B268A78D5110CC923AAE304FF004135F819F12ED355F875FF0007117ECEBE25
          B7BE5B5F0BFC7DFD84FE25F82F5AB168DD05EF8A3E1D78A9B5AD1AE5670CB1CA
          EB61782D85B957917994328C0212BED2EEBF269FE499FBE745145023F9EBFF00
          839CEEEEED3FE09777E2D2EEEAD05E7ED41FB2AD85DFD9AE25B7FB558DDFC5ED
          123BAB2B8F29D0CD697319F2EE2DE4DD14C9F2C88C38AFE80745821B6D1B49B6
          B78D61B7B7D32C2082241848A18AD628E28D47654455551D8015F8B5FF00070C
          F802D3C7DFF04B9F8C8F7766F78BE02F187C26F89F014BA96D7EC975E06F881A
          2EAD05FB1888F3D2D58191AD64CC571F7240578AFD7EF85FE208BC59F0D7E1FF
          008A219C5CC5E21F05F863594B8000130D4B45B2BB32E17E51BCCA5B0BF28CE0
          718A07F657ACBF289DD57F99EFFC1D51FF002961BFFF00B36FF839FF00A55E2E
          AFF4C2AFF33DFF0083AA3FE52C37FF00F66DFF00073FF4ABC5D41A51F8D7A338
          4FD8FBFE0E55FDB23F620FD9ABE12FECA7F0D3E157ECCDE20F02FC17F0FDD786
          BC39ACF8E62F1EB78B2FECEF35BD57C4124BAD9D23C5DA6E9A6E96EF58B88D0D
          AD8DBA1B78E12C864DEEDF4A7FC4601FF0501FFA223FB1D7FDF8F89FFF00CDE5
          7F451FF0438FD83BF628F8B5FF0004A0FD8B3E237C50FD93FF0067BF883E3EF1
          57C35D66FBC4BE33F18FC25F04F88BC4DAFDEC3F107C65631DE6AFAD6ABA35D6
          A1A85CA5A5ADB5B2CB733C8EB0C1144A5638D157F577FE1D93FF0004EBFF00A3
          1DFD957FF0C5FC39FF00E67E81B9D3BBFDDF57D7CFB5FCBFABB3F836F891FF00
          07557FC14EBE2E787753F0C7817C3BF037E18EA177A74D6CFAFF00C26F07789F
          C53E24D305C128352820F12EA5E2AB68268F26385E6B3FB317C7CAD2E0D7E6C7
          C0EFF82617FC1443F6D1D37E20FED01E10FD9BBE2378B7C296B26A3E3DF1AF89
          AFB4FB7F01DFF8FA63722F7C43A67C3EB4D52CA08F53F17DE44D34B69A6C5A6D
          BDAA3B875057E46FF52FF879FB0F7EC6DF09353BDD6BE187ECB1FB3FF80357D4
          AD23B0D4352F097C26F046857B7B650CC2E62B5B9B8D3F458259A08E7026489D
          8AAC837819E6BEA28E38E2458E2448A34015238D5511140C05555015401C0000
          0074A03DAA8FC1051F37AB6BB77FC5FDE7E617FC122FE3F7EC8FF197F62EF853
          E19FD914CFE1CF09FC1CF0ED87C36F12FC28F11C634DF88BF0BFC59E1F885B78
          83C3DE3BD0E72B7F6BAC2EAE2F2596F668560D419CCD6E4211147FC93FFC1DFA
          EB1FED57FB3448E7091FC1DD61DCFA2A6BBA8331FC0026BFA36FDB97FE09BFF1
          53E1D7C62BEFF828D7FC131AE747F873FB59E8761797BF16BE0D3C46C3E187ED
          69A0428B3DEE8BE2AD32CFCBB6B5F1D4B042E34ED7638567D4AE56013BB6A115
          ABC9FC697FC1C11FB75F82FF006F3F1A7C00F1DE91E15F14FC32F8A3F0FBE15F
          887C05F1E3E0DF8DB4ABAD27C4DF0BBE27D85D5CDCEAFA0C8976AADA9E90C6EA
          39B47D660060BDB690293E7C532A82A6AF24D5DF7EAD3BADFCBCFF0053FACAFF
          008366BF611F0D7ECCFF00B097877E3F6BBA1469F1ABF6A112F8CBC41AB5EC50
          4BA8E8DE07B6BDB8B1F08F85B4FB958D6487499ADED1BC4724392F2DCEAA0CAE
          EB0C4A9FD22D7C53FF0004DF82CADBF606FD8F61D3C462D47ECF1F0B1D7CA6DE
          9E6CBE13D365B8C37AFDA5E5DC3F85B72F18C57DAD419B6E4DB7BB7FD7DC7F25
          DFF0760FEC69E0CF1F7EC91E1BFDB2F4BD2ACB4FF895F01BC53A0F873C45AE5B
          59FF00A7F88FE1DF8D3514D121D17509A2DBE647A5F88EF74DBEB4BAB912BC11
          B4B6B1B2452803CCBFE0D09FDA435CF14FC0CFDA4BF662D7EF26B9B0F84FE37D
          13C75E0313DC4B3BC1A478EAD6E4F89ACD04D23F916B6BAB5B69BF63B7842431
          ACB31080B1CFED1FFC178ACB4DBFFF008252FED730EA90DBCF6C9E08D3AE634B
          9DBE5ADE5AF88F489ECA45DDC79B15D4713C247CC24552B83835FCB47FC19EFF
          006F3FB527ED4054DD1D38FC0ED13ED3B4BFD8CDF1F15E82603363E4FB4F93E7
          7945BE7F2FCCDBC668354EF4649FD9926BCAED7F9BFBCFF412AFC2EFDB464369
          FF000598FF0082575C42925F4B79E08FDA3F4F9ACEDD732D85B368FA4B9D5AE0
          9F97EC8AC3CA7DBF38603B1AFDD1AFC1BFDA535AB2F167FC17AFFE09F5F0E2DA
          E215D57C07FB2E7ED0DF157508E32CF72BA4DFDDD9F87ED7ED09CA456D3DEDA3
          C514A70CD36507045064B7F94BF267EF251451408F8CBFE0A25F066EBF685FD8
          5FF6AEF83160ED16A5F103E0778FB45D2A78C0335B6AA344B9BDD32E6DF39C5C
          DBDF5A4135B91F309910AE4E05787FFC119FE365A7C7BFF8266FEC8FE34875B7
          F10EA3A47C2BD1BE1DF893569A75B8B9BAF147C370DE0CD75AEE553F35D9BCD1
          D9AE4B00C65666206457E9C4F0C5730CD6F3C6B2C13C5243344E3292452A1492
          360782AE8C55877048AFE7F7FE091D7975FB2FFED73FF0511FF826BF88A4B1B1
          B2F00FC579BF6A0F801A5D969E74CB35F825F1C2E06A93D8D902DF67BC9B47F1
          25CBC7702C963581666F3615219A82BECB5D9DD7E4D7E5F71FD03D7F99EFFC1D
          51FF002961BFFF00B36FF839FF00A55E2EAFF4C2AFF331FF0083ABF51D3ED7FE
          0AC97F15CDF59DBCBFF0CDDF06DBCB9EEA08A4DA6EBC5F86D923AB60E0E0E307
          07141747E35E8CFECFBFE0DF5FF9436FEC1DFF0064AF5DFF00D599E39AFD90AF
          C6CFF837C658E6FF0082357EC19245224B1B7C2BD7B6C91BABA363E26F8E94ED
          65254E1815383C1041E41AFD93A0CE5BBF57F98514514082BFCECBFE0EE1F86D
          E07F0E7ED9FF00067C59E1EF0D695A1F88FE227C1D9FFE135D574CB58AD27F11
          DCE99ABEA76B63A86A821445BAD421B575B6379266696186159198A6E3FE89B5
          FE7B5FF0784EA963A6FED51FB354B75776B0345F0675A9C473DCC30348B1EB9A
          8BE0091D4E0EDC6E008141A52F8D7F5D51FD08FF00C1BC5FF0519F845FB567EC
          57F0B3E034DE21D2B44FDA1BF67EF0A47E09F187C3EBABBB7B6D4757F0FE873C
          D1E87E2FF0BDACB22DC6ADA349A349636FA9C90C6D2E9FA8C171F6844B796091
          BFA14AFF00238F895FB347ED8BFF0004BAD5BF657FDB33E1DEBBE21D27C39F14
          3C0BE1DF8B3F07FE3F7832CAE87876C6F6FF004FB6BFD67C07E3196DCDCD9D9C
          D66B7021D434BD71D74CD6F4D9609A17926730C1FBDBA47FC1E1BF162DBE13E8
          FA15FF00EC7DE1CD63E2F5AF87EC6CB55F88EBF1252DFC13AB6BD04291DE6BD0
          F8220D0C6A367697AEAD38D357C46EB03BB2A4BE58545072A4DEB4FDE8BECF6D
          76D5FE3F7F77FA9FFF0007567ED63E16F853FB065A7ECD16FAA86F88FF00B4A7
          8BF40B6B5D2AC2FA18F52D33C13E0CD521F12EB1AFEA169BC5CFF62DE6A3A659
          683E72232C97776213F28723E48FF833F3F67FD7745F85FF00B547ED29AC5935
          BE89E3BF17786BE1C7816E8C722FDBADFC25697371E307DCEAA8CB6BAAB6950C
          4626756591CB10C00AFE6F7E1A7C28FF0082837FC17F3F6CEB9F14EA577ABF8C
          B57F106A4B178CFE2B5E6993DB7C22F811F0F62BE5F3346D15D14584363A446C
          6DB48F0CD85C5D6ADA9EA4625D4260EE6E93FD3C7F643FD97BE1CFEC67FB3A7C
          2DFD9BFE16598B6F09FC34F0D5968C978F1471DEEBBAA88D64D63C43A9B46ABE
          76A1AC6A066BB9E490C922AB470B4B208831072F721C974DB7795BA6DA7E5F77
          99F49D7E01FECC7776DFB42FFC176FF6E9F8B89A2DC8D1FF0064BF80BF0A7F66
          8F0F789DBCB934ED4FC41E2C9AEBC6DE2EB2D3A742E0B69BE7C56F7F1168D96E
          429D8CAD9AFDA1F8F5F187C2DFB3EFC15F8A7F1BBC6B7D67A7785FE16F817C47
          E35D5EE6FEE63B3B530E85A65C5E4368F732B247149A85DC70585B9661BAE2E6
          241F33015F94DFF041CF845E2CF0DFEC79AF7ED27F12ADF58B4F8A1FB737C5EF
          1DFED4BE27D3B5F649353D0345F1B6A92C1E06F0E09163422C2C3C2B63617761
          19DDFB8D4449BD84802864B697A25F3BA7F9267EDA514514082BF9EDFF0082C9
          F83FC69FB2EFC66FD963FE0AEBF08B4AD4752BDFD9875BFF008565FB4FF87F44
          B6BBBBBBF15FECBDF10F508ECFC4B7EDA569ED10D5750F07DD5D36A305EEA3F6
          88F49B2DD71188D6DC91FD09572DE39F04F85BE24F837C53F0FBC6FA359788BC
          1FE35D0355F0C789F42D46259EC756D0F5AB29B4FD4AC2E62604345716B3C919
          3C32921D486504034ECFCBAAEEBAA23F00F8E7C2DF137C13E13F889E09D5ECF5
          FF000878DBC3FA5789FC37ACE9F3C77167A8E8FACD9C57D63730CD1332307826
          5DE031292078D8075603CEBE207ECC3FB35FC58F109F177C52FD9EFE08FC49F1
          5B58DB698DE26F1F7C29F02F8C3C40DA6D9190D9E9E759F10685A86A26CAD0CD
          29B6B5373E4406590C51A976CFE177EC11F12FC4DFF04B5FDAB753FF00824FFE
          D0FABEA137C02F883A86B3E37FF8277FC6BD7E690E99A8787751BB6BCD57F67B
          D7B54B93E5D9F88BC272CC53C3F1BCAB67340D15859967B88F1FD21D00F47A3F
          46BB3FEACFB3BA39AF07782FC1DF0EFC33A4782FC01E14F0DF81FC1DA05BBDA6
          85E14F08687A6786BC37A2DAC93CD7525B693A1E8D6B65A669D6EF73713DC3C3
          676B0C6D3CD2CACA6491D8F4B45140828A28A002BC73E24FECEDFB3FFC65BFB2
          D57E2F7C0DF83FF15353D36D5EC74ED47E237C35F06F8DEFAC2CA466792CECEE
          FC4BA2EA7716B6AEEECEF0412244CCCCC50924D7B1D1401E6DE20F837F093C55
          F0F3FE1527893E19780B5CF85A2C20D2D3E1D6A5E12D0AEFC130E9D6ABB6D2CA
          DBC332D8B68F6B6F683FE3D22B7B3896D700C023201AFC36FDACFF00E0DB5FF8
          274FC70F05F8F6F7E0AFC2AD2BF679F8F3AE4C9AE7843E27787350F12EA1A168
          9E23B397ED56D6BA9780AFF58BBF0C4FE17D42555B5D5F4DB0D2AD27FB231365
          2C522ED93FA12A281A6D6CDAF467F3EDFF0004B8FDB2B4EF81FE2F1FF04C6FDA
          F7E0E7C38FD937F6AFF05CB71078064F02F8674DF067C22FDAB3C33A75B2C70F
          C46F87F7D656D69A7EA1E2FBFB4812E3C41A6CF2BEA17B3B35CDAA907CA3FD04
          D7C1BFB7DFFC13DBE08FFC140FE16DBF833E24C3A8F85BE20783EEDBC49F067E
          35F83E76D2BE237C21F1DDAC6D268FE26F0CEB36CD15C98AD2F960B8BDD22794
          D8EA31C46299016DE3F17345FF0082BE7ED07FF04CCF0AF8DBF650FF00829C78
          175AF1FF00ED1FE09F0A187F650F8C3E03D2353D4FC2FF00B6ACB3DCAE89E0BD
          2D9AD6279745F1D4DA8DCE976DE2AB76224889BA7655BE92DE39C1D93B5B7EAB
          F55E5F8AF43E82FF0082BAF8D6FBF6C7F8E7FB3EFF00C11E3E166A0F7577F1A3
          5BD1BE2FFED877DA618AEC7817F663F046A96FA94DA4EBD03A3C68BF10B5A82C
          F4D86DDDE2B868D209A30524CD7EFB785FC35A27833C35E1EF07F86AC20D2BC3
          9E14D0F49F0DE81A5DB2EDB7D3745D0EC2DF4CD2EC205FE186D2C6D60B78C764
          8C57E48FFC1247F628F893F04BC23F113F6B0FDAC678BC41FB707ED8BAD47F11
          FE31EA12C4857E1CF876E9167F077C1AD03EF35A697E0DD3248ADAFC234725D5
          FA81771ACF6A457EC5D0276D12D97E2DEFFE5F2BF50A28A281051451401F187E
          DDBFB0F7C25FDBE3E04EB5F063E278BFD135049E1D7FE1DFC48F0E38B3F1AFC3
          0F1DE987CFD07C5DE16D523F2EE6DAE2CAF1226BDB38E7861D4ECC49693B2EE4
          962FCC1FD8A3FE0A0BF177F658F89BA37FC13B3FE0AA97F6FE14F8C36772FA0F
          ECEBFB546A4E961F0B7F6A1F0959916FA235C7886E4C565A2FC4416CB1437D61
          A9496D25EDD2C892A41388DAEBFA0DAF997F6B1FD8FF00F67CFDB6BE11EB7F05
          BF68BF87DA578EBC1FAB46D2594D3C62DBC43E16D5D36BD8F88FC23AFC2A351F
          0FEBDA65D456F79677D652A0FB45B41F688AE224F28834FA3DBCB75E6BFCBAF9
          6EBE99565755746574650CACA432B2B0CAB2B0C82A4104104820E4714B5FCD9E
          9565FF000543FF0082414EBA4DA58F8BBFE0A6BFB04E99712BD83432C7FF000D
          65F02BC27044EC2CA4594983E24787F42B581AE1A7CCBAA5C195A18D6DF6A28F
          D35FD92FFE0AB5FB0DFED98834DF851F1A347D1FE20DB5B25C6B9F07FE26C6DF
          0EBE2B786DD9D6236FAC7843C48D697493F9A4A2A59CB765F6330F941200E576
          BAD57757B2F5EDDB5DFA5CFD17A29AACAEAAE8CAE8EA191D486565600AB2B024
          32B0208209041041C53A81051451400515E61F153E35FC22F81DE19D47C65F18
          7E25782BE1AF8634AB596F6FB59F19788B4CD0AD21B6854BCB227DBAE2296E0A
          202C63B68E694AAB30421491F867F103FE0B33F14BF6A9F13EABF047FE08F3FB
          3B6BFF00B4CF8AC349A7EA9FB53FC43D3F52F047ECA9F0FC5C40B25978821F10
          DFDBC37BE3FB3903EDB71A424110BB5114D0CC8C370349BF4EEF45F79FA7FF00
          B72FEDFF00FB3C7EC01F0BA5F889F1B7C452CDAD6A64587C3DF857E178D759F8
          9DF143C473BFD9EC3C3FE0AF0ADBB36A3A95C5DDDB25BBDD88459DB3362494CC
          D1C327E677EC43FB147ED03FB5A7ED17A5FF00C1503FE0A65A15BE93E3FD2ADA
          E93F63AFD92E730EA1E1AFD987C0DAAFEF2DB5EF1044EAF0EA3F1535AB4FB3DD
          EA97530792C2ED918886E2D230DEE7FB17FF00C124F48F85FF0014A6FDAFBF6D
          4F893A87ED8DFB6E6B50C4C9F117C6D6CAFE03F8476E5370F0EFC18F044E1F4C
          F0CDA5AB36C7D5843F6DBA9A28EF225B59D5641FB3540EE95D27BAB37B69D52F
          2BEEF76B4B257B94514504851451400514514005145140057E797ED63FF04ADF
          D85BF6CF99758F8D7F027C352F8E20BEB5D56CBE27782BCFF00FC4AB4D52C1DA
          4B2BEFF84CBC2AFA66AF7925BCAC5C26A33DDC52602CA8CA14028A0136B54ECF
          BA3E04FF0087437EDA3F01ADF597FD88BFE0AB9FB40782A3BA99EE742F067ED1
          9A4E91F1DFC11E1FDA736BA5DA0D6623AB1D1A25FDD9B73279A579323B7CD5D3
          5B785BFE0E16F8776696D17C4BFD82FE3F4F651C486FF57F0A78CFE1E4DACBCA
          02CB2C90D8DC5BC362D6C7320540AB37DD1C514505733EB67EA95FA75DDEC393
          5CFF008388757922D3A6F04FFC13DBC250DC3912F8861D6BC7DAD49A7AA2970C
          34C7D41C5CF9ACA212154B2093CCE36D6349FB1AFF00C170BE30EB6CDF18FF00
          E0A63F09FE0E7802FEC05B5EF843F672F81B6B1789ADE56691A5B8B6F19F8AA3
          96E52528E91284768D442B226D76624A2815FC97DC9F6EF7EDF8B3B4F84DFF00
          0410FD91B44D6F4CF1B7ED3DE35F8DDFB76FC45D2752BAD56CBC4DFB507C41D6
          3C59A3DBDC5E3EF9A283C0B6D756FE15FB22F11416F75657690DBA88416519AF
          D9EF06F827C1DF0EBC37A5F837C01E15F0EF82BC25A1DB259E8DE19F0A68DA7E
          81A16976B1A854B7B0D2B4BB7B5B2B5895540090C28300514500DB7BBB9D3D14
          5140828A28A0028A28A00FFFD9}
        mmHeight = 7938
        mmLeft = 174625
        mmTop = 23019
        mmWidth = 8996
        BandType = 0
      end
      object ppLabel59: TppLabel
        UserName = 'Label59'
        Caption = #27773#36710#26495
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clRed
        Font.Name = #23435#20307
        Font.Size = 14
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 5556
        mmLeft = 25135
        mmTop = 1588
        mmWidth = 16404
        BandType = 0
      end
      object ppDBText45: TppDBText
        UserName = 'DBText45'
        DataField = #21348#32032#35201#27714
        DataPipeline = ppDB25
        Font.Charset = GB2312_CHARSET
        Font.Color = clRed
        Font.Name = #40657#20307
        Font.Size = 16
        Font.Style = [fsBold]
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'ppDB25'
        mmHeight = 6435
        mmLeft = 143404
        mmTop = 9260
        mmWidth = 25665
        BandType = 0
      end
      object ppLabel60: TppLabel
        UserName = 'Label60'
        Caption = 'RoHS'
        Font.Charset = GB2312_CHARSET
        Font.Color = clRed
        Font.Name = #40657#20307
        Font.Size = 14
        Font.Style = [fsBold]
        Transparent = True
        mmHeight = 5556
        mmLeft = 43127
        mmTop = 1323
        mmWidth = 12965
        BandType = 0
      end
      object ppVariable6: TppVariable
        UserName = 'Variable6'
        CalcOrder = 3
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = #23435#20307
        Font.Size = 10
        Font.Style = []
        Transparent = True
        mmHeight = 3969
        mmLeft = 154782
        mmTop = 23548
        mmWidth = 21696
        BandType = 0
      end
    end
    object ppDetailBand1: TppDetailBand
      PrintHeight = phDynamic
      mmBottomOffset = 0
      mmHeight = 5027
      mmPrintPosition = 0
      object ppLine16: TppLine
        UserName = 'Line16'
        ParentHeight = True
        ParentWidth = True
        Position = lpRight
        StretchWithParent = True
        Weight = 0.750000000000000000
        mmHeight = 5027
        mmLeft = 0
        mmTop = 0
        mmWidth = 197300
        BandType = 4
      end
      object ppLine1: TppLine
        UserName = 'Line1'
        ParentHeight = True
        ParentWidth = True
        StretchWithParent = True
        Weight = 0.750000000000000000
        mmHeight = 5027
        mmLeft = 0
        mmTop = 0
        mmWidth = 197300
        BandType = 4
      end
      object ppDBText2: TppDBText
        UserName = 'DBText2'
        AutoSize = True
        DataField = #24037#24207#21517#31216
        DataPipeline = ppDB38
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = #23435#20307
        Font.Size = 9
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDB38'
        mmHeight = 3969
        mmLeft = 10583
        mmTop = 529
        mmWidth = 14023
        BandType = 4
      end
      object pdbm1: TppDBMemo
        UserName = 'pdbm1'
        CharWrap = False
        DataField = #24037#33402#21442#25968
        DataPipeline = ppDB38
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = #23435#20307
        Font.Size = 9
        Font.Style = []
        Stretch = True
        Transparent = True
        DataPipelineName = 'ppDB38'
        mmHeight = 4233
        mmLeft = 28840
        mmTop = 529
        mmWidth = 150284
        BandType = 4
        mmBottomOffset = 0
        mmOverFlowOffset = 0
        mmStopPosition = 0
        mmLeading = 0
      end
      object ppDBText20: TppDBText
        UserName = 'DBText20'
        DataField = 'STEP_NUMBER'
        DataPipeline = ppDB38
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDB38'
        mmHeight = 3969
        mmLeft = 529
        mmTop = 529
        mmWidth = 9260
        BandType = 4
      end
      object ppLine11: TppLine
        UserName = 'Line11'
        ParentHeight = True
        Position = lpLeft
        StretchWithParent = True
        Weight = 0.750000000000000000
        mmHeight = 5027
        mmLeft = 0
        mmTop = 0
        mmWidth = 4498
        BandType = 4
      end
      object ppLine12: TppLine
        UserName = 'Line12'
        ParentHeight = True
        Position = lpLeft
        StretchWithParent = True
        Weight = 0.750000000000000000
        mmHeight = 5027
        mmLeft = 9790
        mmTop = 0
        mmWidth = 2381
        BandType = 4
      end
      object ppLine13: TppLine
        UserName = 'Line13'
        ParentHeight = True
        Position = lpLeft
        StretchWithParent = True
        Weight = 0.750000000000000000
        mmHeight = 5027
        mmLeft = 28310
        mmTop = 0
        mmWidth = 1323
        BandType = 4
      end
      object ppLine15: TppLine
        UserName = 'Line15'
        ParentHeight = True
        Position = lpLeft
        StretchWithParent = True
        Weight = 0.750000000000000000
        mmHeight = 5027
        mmLeft = 179652
        mmTop = 0
        mmWidth = 2381
        BandType = 4
      end
      object ppDBText21: TppDBText
        UserName = 'DBText21'
        AutoSize = True
        DataField = #24037#20855#29256#26412
        DataPipeline = ppDB38
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = 'Arial'
        Font.Size = 9
        Font.Style = []
        Transparent = True
        DataPipelineName = 'ppDB38'
        mmHeight = 4233
        mmLeft = 179917
        mmTop = 529
        mmWidth = 16933
        BandType = 4
      end
    end
    object ppFooterBand1: TppFooterBand
      mmBottomOffset = 0
      mmHeight = 14023
      mmPrintPosition = 0
      object ppLine3: TppLine
        UserName = 'Line3'
        ParentHeight = True
        ParentWidth = True
        Weight = 0.750000000000000000
        mmHeight = 14023
        mmLeft = 0
        mmTop = 0
        mmWidth = 197300
        BandType = 8
      end
      object ppLabel3: TppLabel
        UserName = 'Label3'
        Caption = #21046#20316':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = #23435#20307
        Font.Size = 10
        Font.Style = []
        Transparent = True
        mmHeight = 4022
        mmLeft = 3175
        mmTop = 1588
        mmWidth = 8805
        BandType = 8
      end
      object ppDBText5: TppDBText
        UserName = 'DBText5'
        AutoSize = True
        DataField = #20462#35746#20154#21592
        DataPipeline = ppDB25
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = #23435#20307
        Font.Size = 10
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'ppDB25'
        mmHeight = 4022
        mmLeft = 14817
        mmTop = 1058
        mmWidth = 14055
        BandType = 8
      end
      object ppDBText6: TppDBText
        UserName = 'DBText6'
        AutoSize = True
        DataField = #20462#35746#26085#26399
        DataPipeline = ppDB25
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = #23435#20307
        Font.Size = 10
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'ppDB25'
        mmHeight = 4022
        mmLeft = 14817
        mmTop = 6085
        mmWidth = 14055
        BandType = 8
      end
      object ppLine2: TppLine
        UserName = 'Line2'
        Weight = 0.750000000000000000
        mmHeight = 265
        mmLeft = 12435
        mmTop = 5556
        mmWidth = 26723
        BandType = 8
      end
      object ppLabel4: TppLabel
        UserName = 'Label4'
        Caption = #22797#26680':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = #23435#20307
        Font.Size = 10
        Font.Style = []
        Transparent = True
        mmHeight = 3969
        mmLeft = 58738
        mmTop = 1588
        mmWidth = 8731
        BandType = 8
      end
      object ppDBText7: TppDBText
        UserName = 'DBText7'
        AutoSize = True
        DataField = #26816#26597#20154#21592
        DataPipeline = ppDB25
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = #23435#20307
        Font.Size = 10
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'ppDB25'
        mmHeight = 4022
        mmLeft = 70379
        mmTop = 1058
        mmWidth = 14055
        BandType = 8
      end
      object ppDBText8: TppDBText
        UserName = 'DBText8'
        AutoSize = True
        DataField = #26816#26597#26085#26399
        DataPipeline = ppDB25
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = #23435#20307
        Font.Size = 10
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'ppDB25'
        mmHeight = 4022
        mmLeft = 70379
        mmTop = 5821
        mmWidth = 14055
        BandType = 8
      end
      object ppLine4: TppLine
        UserName = 'Line4'
        Weight = 0.750000000000000000
        mmHeight = 265
        mmLeft = 67998
        mmTop = 5292
        mmWidth = 26723
        BandType = 8
      end
      object ppLabel5: TppLabel
        UserName = 'Label5'
        Caption = #23457#26680':'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = #23435#20307
        Font.Size = 10
        Font.Style = []
        Transparent = True
        mmHeight = 3969
        mmLeft = 109538
        mmTop = 1588
        mmWidth = 8731
        BandType = 8
      end
      object ppDBText9: TppDBText
        UserName = 'DBText9'
        AutoSize = True
        DataField = #23457#26680#20154#21592
        DataPipeline = ppDB25
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = #23435#20307
        Font.Size = 10
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'ppDB25'
        mmHeight = 4022
        mmLeft = 121179
        mmTop = 1323
        mmWidth = 14055
        BandType = 8
      end
      object ppLine5: TppLine
        UserName = 'Line5'
        Weight = 0.750000000000000000
        mmHeight = 265
        mmLeft = 118798
        mmTop = 5556
        mmWidth = 26723
        BandType = 8
      end
      object ppDBText10: TppDBText
        UserName = 'DBText10'
        AutoSize = True
        DataField = #23457#26680#26085#26399
        DataPipeline = ppDB25
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = #23435#20307
        Font.Size = 10
        Font.Style = []
        ParentDataPipeline = False
        Transparent = True
        DataPipelineName = 'ppDB25'
        mmHeight = 4022
        mmLeft = 121179
        mmTop = 6085
        mmWidth = 14055
        BandType = 8
      end
      object ppLabel6: TppLabel
        UserName = 'Label6'
        Caption = #25991#20214#32534#21495#65306' HT'#65293'RD'#65293'001   A/0'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Name = #23435#20307
        Font.Size = 10
        Font.Style = []
        Transparent = True
        mmHeight = 3969
        mmLeft = 146315
        mmTop = 10054
        mmWidth = 51065
        BandType = 8
      end
    end
    object ppSummaryBand1: TppSummaryBand
      mmBottomOffset = 0
      mmHeight = 0
      mmPrintPosition = 0
    end
    object ppPageStyle1: TppPageStyle
      EndPage = 0
      SinglePage = 0
      StartPage = 0
      mmBottomOffset = 0
      mmHeight = 13229
      mmPrintPosition = 0
    end
    object ppGroup2: TppGroup
      BreakName = 'SOURCE_PTR'
      DataPipeline = ppDB38
      OutlineSettings.CreateNode = True
      ReprintOnSubsequentPage = False
      UserName = 'Group2'
      mmNewColumnThreshold = 0
      mmNewPageThreshold = 0
      DataPipelineName = 'ppDB38'
      object ppGroupHeaderBand2: TppGroupHeaderBand
        mmBottomOffset = 0
        mmHeight = 0
        mmPrintPosition = 0
      end
      object ppGroupFooterBand2: TppGroupFooterBand
        PrintHeight = phDynamic
        mmBottomOffset = 0
        mmHeight = 5027
        mmPrintPosition = 0
        object ppSubReport4: TppSubReport
          UserName = 'SubReport4'
          ExpandAll = False
          NewPrintJob = False
          OutlineSettings.CreateNode = True
          TraverseAllData = False
          DataPipelineName = 'ppDB30'
          mmHeight = 5027
          mmLeft = 0
          mmTop = 0
          mmWidth = 197300
          BandType = 5
          GroupNo = 0
          mmBottomOffset = 0
          mmOverFlowOffset = 0
          mmStopPosition = 0
          object ppChildReport4: TppChildReport
            AutoStop = False
            DataPipeline = ppDB30
            PrinterSetup.BinName = 'Default'
            PrinterSetup.DocumentName = 'Report'
            PrinterSetup.PaperName = 'A4'
            PrinterSetup.PrinterName = 'Default'
            PrinterSetup.mmMarginBottom = 350
            PrinterSetup.mmMarginLeft = 6350
            PrinterSetup.mmMarginRight = 6350
            PrinterSetup.mmMarginTop = 5350
            PrinterSetup.mmPaperHeight = 297000
            PrinterSetup.mmPaperWidth = 210000
            PrinterSetup.PaperSize = 9
            Units = utMillimeters
            Version = '7.01'
            mmColumnWidth = 0
            DataPipelineName = 'ppDB30'
            object ptlbnd2: TppTitleBand
              mmBottomOffset = 0
              mmHeight = 0
              mmPrintPosition = 0
            end
            object phdrbnd2: TppHeaderBand
              mmBottomOffset = 0
              mmHeight = 0
              mmPrintPosition = 0
            end
            object ppDetailBand5: TppDetailBand
              mmBottomOffset = 0
              mmHeight = 6085
              mmPrintPosition = 0
              object ppLine60: TppLine
                UserName = 'Line60'
                ParentHeight = True
                Position = lpLeft
                Weight = 0.750000000000000000
                mmHeight = 6085
                mmLeft = 0
                mmTop = 0
                mmWidth = 794
                BandType = 4
              end
              object ppLine61: TppLine
                UserName = 'Line61'
                ParentHeight = True
                Position = lpLeft
                Weight = 0.750000000000000000
                mmHeight = 6085
                mmLeft = 7938
                mmTop = 0
                mmWidth = 2381
                BandType = 4
              end
              object ppDBText32: TppDBText
                UserName = 'DBText32'
                AutoSize = True
                DataField = #24207#21495
                DataPipeline = ppDB30
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = #23435#20307
                Font.Size = 10
                Font.Style = []
                Transparent = True
                DataPipelineName = 'ppDB30'
                mmHeight = 4022
                mmLeft = 529
                mmTop = 794
                mmWidth = 7027
                BandType = 4
              end
              object ppLine62: TppLine
                UserName = 'Line62'
                ParentHeight = True
                Position = lpLeft
                Weight = 0.750000000000000000
                mmHeight = 6085
                mmLeft = 22225
                mmTop = 0
                mmWidth = 2117
                BandType = 4
              end
              object ppDBText33: TppDBText
                UserName = 'DBText33'
                AutoSize = True
                DataField = #31867#22411
                DataPipeline = ppDB30
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = #23435#20307
                Font.Size = 9
                Font.Style = []
                Transparent = True
                DataPipelineName = 'ppDB30'
                mmHeight = 3641
                mmLeft = 8731
                mmTop = 794
                mmWidth = 6350
                BandType = 4
              end
              object ppLine63: TppLine
                UserName = 'Line63'
                ParentHeight = True
                Position = lpLeft
                Weight = 0.750000000000000000
                mmHeight = 6085
                mmLeft = 31485
                mmTop = 0
                mmWidth = 3440
                BandType = 4
              end
              object ppDBText34: TppDBText
                UserName = 'DBText301'
                AutoSize = True
                DataField = #23618#27425
                DataPipeline = ppDB30
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = #23435#20307
                Font.Size = 10
                Font.Style = []
                Transparent = True
                DataPipelineName = 'ppDB30'
                mmHeight = 4022
                mmLeft = 23283
                mmTop = 794
                mmWidth = 7027
                BandType = 4
              end
              object ppLine64: TppLine
                UserName = 'Line402'
                ParentHeight = True
                Position = lpLeft
                Weight = 0.750000000000000000
                mmHeight = 6085
                mmLeft = 44186
                mmTop = 0
                mmWidth = 2381
                BandType = 4
              end
              object ppDBText35: TppDBText
                UserName = 'DBText35'
                AutoSize = True
                DataField = #21442#32771#23618
                DataPipeline = ppDB30
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = #23435#20307
                Font.Size = 10
                Font.Style = []
                Transparent = True
                DataPipelineName = 'ppDB30'
                mmHeight = 4022
                mmLeft = 32808
                mmTop = 794
                mmWidth = 10541
                BandType = 4
              end
              object ppLine65: TppLine
                UserName = 'Line41'
                ParentHeight = True
                Position = lpLeft
                Weight = 0.750000000000000000
                mmHeight = 6085
                mmLeft = 58738
                mmTop = 0
                mmWidth = 1323
                BandType = 4
              end
              object ppLine66: TppLine
                UserName = 'Line66'
                ParentHeight = True
                Position = lpLeft
                Weight = 0.750000000000000000
                mmHeight = 6085
                mmLeft = 73554
                mmTop = 0
                mmWidth = 529
                BandType = 4
              end
              object ppLine67: TppLine
                UserName = 'Line67'
                ParentHeight = True
                Position = lpLeft
                Weight = 0.750000000000000000
                mmHeight = 6085
                mmLeft = 88900
                mmTop = 0
                mmWidth = 1058
                BandType = 4
              end
              object ppLine68: TppLine
                UserName = 'Line44'
                ParentHeight = True
                Position = lpLeft
                Weight = 0.750000000000000000
                mmHeight = 6085
                mmLeft = 103188
                mmTop = 0
                mmWidth = 2910
                BandType = 4
              end
              object ppLine69: TppLine
                UserName = 'Line69'
                ParentHeight = True
                Position = lpLeft
                Weight = 0.750000000000000000
                mmHeight = 6085
                mmLeft = 118798
                mmTop = 0
                mmWidth = 2910
                BandType = 4
              end
              object ppLine70: TppLine
                UserName = 'Line70'
                ParentHeight = True
                Position = lpLeft
                Weight = 0.750000000000000000
                mmHeight = 6085
                mmLeft = 136790
                mmTop = 0
                mmWidth = 4763
                BandType = 4
              end
              object ppLine71: TppLine
                UserName = 'Line71'
                ParentHeight = True
                Position = lpLeft
                Weight = 0.750000000000000000
                mmHeight = 6085
                mmLeft = 156634
                mmTop = 0
                mmWidth = 12965
                BandType = 4
              end
              object ppLine72: TppLine
                UserName = 'Line72'
                ParentHeight = True
                Position = lpLeft
                Weight = 0.750000000000000000
                mmHeight = 6085
                mmLeft = 175419
                mmTop = 0
                mmWidth = 3704
                BandType = 4
              end
              object ppDBText36: TppDBText
                UserName = 'DBText36'
                AutoSize = True
                DataField = #23458#25143#32447#23485
                DataPipeline = ppDB30
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = #23435#20307
                Font.Size = 10
                Font.Style = []
                Transparent = True
                DataPipelineName = 'ppDB30'
                mmHeight = 4022
                mmLeft = 44715
                mmTop = 794
                mmWidth = 14055
                BandType = 4
              end
              object ppDBText37: TppDBText
                UserName = 'DBText37'
                AutoSize = True
                DataField = #23458#25143#32447#36317
                DataPipeline = ppDB30
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = #23435#20307
                Font.Size = 10
                Font.Style = []
                Transparent = True
                DataPipelineName = 'ppDB30'
                mmHeight = 4022
                mmLeft = 59531
                mmTop = 794
                mmWidth = 14055
                BandType = 4
              end
              object ppDBText38: TppDBText
                UserName = 'DBText34'
                AutoSize = True
                DataField = #25104#21697#38459#25239
                DataPipeline = ppDB30
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = #23435#20307
                Font.Size = 10
                Font.Style = []
                Transparent = True
                DataPipelineName = 'ppDB30'
                mmHeight = 4022
                mmLeft = 74613
                mmTop = 794
                mmWidth = 14055
                BandType = 4
              end
              object ppDBText39: TppDBText
                UserName = 'DBText39'
                AutoSize = True
                DataField = #35843#25972#32447#23485
                DataPipeline = ppDB30
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = #23435#20307
                Font.Size = 10
                Font.Style = []
                Transparent = True
                DataPipelineName = 'ppDB30'
                mmHeight = 4022
                mmLeft = 89429
                mmTop = 794
                mmWidth = 14055
                BandType = 4
              end
              object ppDBText40: TppDBText
                UserName = 'DBText40'
                AutoSize = True
                DataField = #35843#25972#32447#36317
                DataPipeline = ppDB30
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = #23435#20307
                Font.Size = 10
                Font.Style = []
                Transparent = True
                DataPipelineName = 'ppDB30'
                mmHeight = 4022
                mmLeft = 104246
                mmTop = 794
                mmWidth = 14055
                BandType = 4
              end
              object ppDBText41: TppDBText
                UserName = 'DBText41'
                AutoSize = True
                DataField = #32511#27833#21069#38459#25239
                DataPipeline = ppDB30
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = #23435#20307
                Font.Size = 10
                Font.Style = []
                Transparent = True
                DataPipelineName = 'ppDB30'
                mmHeight = 4022
                mmLeft = 119592
                mmTop = 794
                mmWidth = 17568
                BandType = 4
              end
              object ppDBText42: TppDBText
                UserName = 'DBText38'
                AutoSize = True
                DataField = #38459#25239#25511#21046#33539#22260
                DataPipeline = ppDB30
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = #23435#20307
                Font.Size = 10
                Font.Style = []
                Transparent = True
                DataPipelineName = 'ppDB30'
                mmHeight = 4022
                mmLeft = 137848
                mmTop = 794
                mmWidth = 21082
                BandType = 4
              end
              object ppDBText43: TppDBText
                UserName = 'DBText43'
                AutoSize = True
                DataField = #21407#22987#21040#38108#30382#36317#31163
                DataPipeline = ppDB30
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = #23435#20307
                Font.Size = 10
                Font.Style = []
                Transparent = True
                DataPipelineName = 'ppDB30'
                mmHeight = 4022
                mmLeft = 157163
                mmTop = 794
                mmWidth = 24596
                BandType = 4
              end
              object ppDBText44: TppDBText
                UserName = 'DBText401'
                AutoSize = True
                DataField = #35843#25972#21518#21040#38108#36317#31163
                DataPipeline = ppDB30
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = #23435#20307
                Font.Size = 10
                Font.Style = []
                Transparent = True
                DataPipelineName = 'ppDB30'
                mmHeight = 4022
                mmLeft = 176742
                mmTop = 794
                mmWidth = 24596
                BandType = 4
              end
              object ppLine73: TppLine
                UserName = 'Line73'
                ParentHeight = True
                ParentWidth = True
                Position = lpBottom
                Weight = 0.750000000000000000
                mmHeight = 6085
                mmLeft = 0
                mmTop = 0
                mmWidth = 197300
                BandType = 4
              end
              object ppLine74: TppLine
                UserName = 'Line74'
                ParentHeight = True
                ParentWidth = True
                Position = lpRight
                Weight = 0.750000000000000000
                mmHeight = 6085
                mmLeft = 0
                mmTop = 0
                mmWidth = 197300
                BandType = 4
              end
            end
            object ppSummaryBand5: TppSummaryBand
              mmBottomOffset = 0
              mmHeight = 0
              mmPrintPosition = 0
            end
            object ppGroup8: TppGroup
              BreakName = 'source_ptr'
              DataPipeline = ppDB30
              KeepTogether = True
              OutlineSettings.CreateNode = True
              UserName = 'Group8'
              mmNewColumnThreshold = 0
              mmNewPageThreshold = 0
              DataPipelineName = 'ppDB30'
              object ppGroupHeaderBand8: TppGroupHeaderBand
                mmBottomOffset = 0
                mmHeight = 17463
                mmPrintPosition = 0
                object ppLabel42: TppLabel
                  UserName = 'Label42'
                  Caption = #38459#25239#34920
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clBlack
                  Font.Name = #23435#20307
                  Font.Size = 14
                  Font.Style = [fsBold]
                  Transparent = True
                  mmHeight = 5630
                  mmLeft = 89959
                  mmTop = 0
                  mmWidth = 14859
                  BandType = 3
                  GroupNo = 0
                end
                object ppShape3: TppShape
                  UserName = 'Shape3'
                  ParentWidth = True
                  mmHeight = 10054
                  mmLeft = 0
                  mmTop = 7408
                  mmWidth = 197300
                  BandType = 3
                  GroupNo = 0
                end
                object ppLine48: TppLine
                  UserName = 'Line48'
                  Position = lpLeft
                  Weight = 0.750000000000000000
                  mmHeight = 10054
                  mmLeft = 7938
                  mmTop = 7408
                  mmWidth = 4233
                  BandType = 3
                  GroupNo = 0
                end
                object ppLine49: TppLine
                  UserName = 'Line49'
                  Position = lpLeft
                  Weight = 0.750000000000000000
                  mmHeight = 10054
                  mmLeft = 22225
                  mmTop = 7408
                  mmWidth = 4498
                  BandType = 3
                  GroupNo = 0
                end
                object ppLine50: TppLine
                  UserName = 'Line50'
                  Position = lpLeft
                  Weight = 0.750000000000000000
                  mmHeight = 10054
                  mmLeft = 31485
                  mmTop = 7408
                  mmWidth = 2117
                  BandType = 3
                  GroupNo = 0
                end
                object ppLine51: TppLine
                  UserName = 'Line51'
                  Position = lpLeft
                  Weight = 0.750000000000000000
                  mmHeight = 10054
                  mmLeft = 44186
                  mmTop = 7408
                  mmWidth = 5292
                  BandType = 3
                  GroupNo = 0
                end
                object ppLine52: TppLine
                  UserName = 'Line52'
                  Position = lpLeft
                  Weight = 0.750000000000000000
                  mmHeight = 10054
                  mmLeft = 58738
                  mmTop = 7408
                  mmWidth = 2646
                  BandType = 3
                  GroupNo = 0
                end
                object ppLine53: TppLine
                  UserName = 'Line53'
                  Position = lpLeft
                  Weight = 0.750000000000000000
                  mmHeight = 10054
                  mmLeft = 73554
                  mmTop = 7408
                  mmWidth = 4498
                  BandType = 3
                  GroupNo = 0
                end
                object ppLine54: TppLine
                  UserName = 'Line54'
                  Position = lpLeft
                  Weight = 0.750000000000000000
                  mmHeight = 10054
                  mmLeft = 88900
                  mmTop = 7408
                  mmWidth = 3440
                  BandType = 3
                  GroupNo = 0
                end
                object ppLine55: TppLine
                  UserName = 'Line55'
                  Position = lpLeft
                  Weight = 0.750000000000000000
                  mmHeight = 10054
                  mmLeft = 103188
                  mmTop = 7408
                  mmWidth = 5556
                  BandType = 3
                  GroupNo = 0
                end
                object ppLabel43: TppLabel
                  UserName = 'Label43'
                  Caption = #24207#21495
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clBlack
                  Font.Name = #23435#20307
                  Font.Size = 10
                  Font.Style = []
                  Transparent = True
                  mmHeight = 3969
                  mmLeft = 529
                  mmTop = 10583
                  mmWidth = 7144
                  BandType = 3
                  GroupNo = 0
                end
                object ppLabel44: TppLabel
                  UserName = 'Label44'
                  Caption = #31867#22411
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clBlack
                  Font.Name = #23435#20307
                  Font.Size = 10
                  Font.Style = []
                  Transparent = True
                  mmHeight = 3969
                  mmLeft = 11377
                  mmTop = 10583
                  mmWidth = 7144
                  BandType = 3
                  GroupNo = 0
                end
                object ppLabel45: TppLabel
                  UserName = 'Label45'
                  Caption = #23618#27425
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clBlack
                  Font.Name = #23435#20307
                  Font.Size = 10
                  Font.Style = []
                  Transparent = True
                  mmHeight = 3969
                  mmLeft = 23548
                  mmTop = 10583
                  mmWidth = 7144
                  BandType = 3
                  GroupNo = 0
                end
                object ppLabel46: TppLabel
                  UserName = 'Label402'
                  Caption = #21442#32771#23618
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clBlack
                  Font.Name = #23435#20307
                  Font.Size = 10
                  Font.Style = []
                  Transparent = True
                  mmHeight = 3969
                  mmLeft = 32544
                  mmTop = 10583
                  mmWidth = 10583
                  BandType = 3
                  GroupNo = 0
                end
                object ppLabel47: TppLabel
                  UserName = 'Label41'
                  Caption = #23458#25143#32447#23485
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clBlack
                  Font.Name = #23435#20307
                  Font.Size = 10
                  Font.Style = []
                  Transparent = True
                  mmHeight = 3969
                  mmLeft = 44715
                  mmTop = 10583
                  mmWidth = 14023
                  BandType = 3
                  GroupNo = 0
                end
                object ppLabel48: TppLabel
                  UserName = 'Label48'
                  Caption = #23458#25143#32447#36317
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clBlack
                  Font.Name = #23435#20307
                  Font.Size = 10
                  Font.Style = []
                  Transparent = True
                  mmHeight = 3969
                  mmLeft = 59267
                  mmTop = 10583
                  mmWidth = 14023
                  BandType = 3
                  GroupNo = 0
                end
                object ppLabel49: TppLabel
                  UserName = 'Label49'
                  Caption = #25104#21697#38459#25239
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clBlack
                  Font.Name = #23435#20307
                  Font.Size = 10
                  Font.Style = []
                  Transparent = True
                  mmHeight = 3969
                  mmLeft = 74348
                  mmTop = 10583
                  mmWidth = 14023
                  BandType = 3
                  GroupNo = 0
                end
                object ppLabel50: TppLabel
                  UserName = 'Label50'
                  Caption = #35843#25972#32447#23485
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clBlack
                  Font.Name = #23435#20307
                  Font.Size = 10
                  Font.Style = []
                  Transparent = True
                  mmHeight = 3969
                  mmLeft = 89165
                  mmTop = 10583
                  mmWidth = 14023
                  BandType = 3
                  GroupNo = 0
                end
                object ppLabel51: TppLabel
                  UserName = 'Label51'
                  Caption = #35843#25972#32447#36317
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clBlack
                  Font.Name = #23435#20307
                  Font.Size = 10
                  Font.Style = []
                  Transparent = True
                  mmHeight = 3969
                  mmLeft = 103981
                  mmTop = 10583
                  mmWidth = 14023
                  BandType = 3
                  GroupNo = 0
                end
                object ppLabel52: TppLabel
                  UserName = 'Label52'
                  Caption = #21407#22987#21040#38108
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clBlack
                  Font.Name = #23435#20307
                  Font.Size = 10
                  Font.Style = []
                  mmHeight = 3969
                  mmLeft = 158486
                  mmTop = 8467
                  mmWidth = 14023
                  BandType = 3
                  GroupNo = 0
                end
                object ppLabel53: TppLabel
                  UserName = 'Label53'
                  Caption = #35843#25972#21518#21040
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clBlack
                  Font.Name = #23435#20307
                  Font.Size = 10
                  Font.Style = []
                  mmHeight = 3969
                  mmLeft = 179388
                  mmTop = 8467
                  mmWidth = 14023
                  BandType = 3
                  GroupNo = 0
                end
                object ppLine56: TppLine
                  UserName = 'Line56'
                  Position = lpLeft
                  Weight = 0.750000000000000000
                  mmHeight = 10054
                  mmLeft = 118798
                  mmTop = 7408
                  mmWidth = 3969
                  BandType = 3
                  GroupNo = 0
                end
                object ppLine57: TppLine
                  UserName = 'Line57'
                  Position = lpLeft
                  Weight = 0.750000000000000000
                  mmHeight = 10054
                  mmLeft = 136790
                  mmTop = 7408
                  mmWidth = 4763
                  BandType = 3
                  GroupNo = 0
                end
                object ppLabel54: TppLabel
                  UserName = 'Label46'
                  Caption = #32511#27833#21069#38459#25239
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clBlack
                  Font.Name = #23435#20307
                  Font.Size = 10
                  Font.Style = []
                  mmHeight = 3969
                  mmLeft = 119063
                  mmTop = 10583
                  mmWidth = 17727
                  BandType = 3
                  GroupNo = 0
                end
                object ppLine58: TppLine
                  UserName = 'Line302'
                  Position = lpLeft
                  Weight = 0.750000000000000000
                  mmHeight = 10054
                  mmLeft = 156634
                  mmTop = 7408
                  mmWidth = 8731
                  BandType = 3
                  GroupNo = 0
                end
                object ppLabel55: TppLabel
                  UserName = 'Label47'
                  Caption = #38459#25239#25511#21046
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clBlack
                  Font.Name = #23435#20307
                  Font.Size = 10
                  Font.Style = []
                  mmHeight = 3969
                  mmLeft = 139700
                  mmTop = 8467
                  mmWidth = 14023
                  BandType = 3
                  GroupNo = 0
                end
                object ppLine59: TppLine
                  UserName = 'Line59'
                  Position = lpLeft
                  Weight = 0.750000000000000000
                  mmHeight = 10054
                  mmLeft = 175419
                  mmTop = 7408
                  mmWidth = 2646
                  BandType = 3
                  GroupNo = 0
                end
                object ppLabel56: TppLabel
                  UserName = 'Label56'
                  Caption = #33539#22260
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clBlack
                  Font.Name = #23435#20307
                  Font.Size = 10
                  Font.Style = []
                  Transparent = True
                  mmHeight = 3969
                  mmLeft = 142875
                  mmTop = 12700
                  mmWidth = 7144
                  BandType = 3
                  GroupNo = 0
                end
                object ppLabel57: TppLabel
                  UserName = 'Label57'
                  Caption = #30382#36317#31163
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clBlack
                  Font.Name = #23435#20307
                  Font.Size = 10
                  Font.Style = []
                  Transparent = True
                  mmHeight = 3969
                  mmLeft = 160073
                  mmTop = 12700
                  mmWidth = 10583
                  BandType = 3
                  GroupNo = 0
                end
                object ppLabel58: TppLabel
                  UserName = 'Label58'
                  Caption = #38108#30382#36317#31163
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clBlack
                  Font.Name = #23435#20307
                  Font.Size = 10
                  Font.Style = []
                  Transparent = True
                  mmHeight = 3969
                  mmLeft = 179388
                  mmTop = 12700
                  mmWidth = 14023
                  BandType = 3
                  GroupNo = 0
                end
              end
              object ppGroupFooterBand8: TppGroupFooterBand
                mmBottomOffset = 0
                mmHeight = 0
                mmPrintPosition = 0
              end
            end
          end
        end
      end
    end
    object ppGroup1: TppGroup
      BreakName = 'SOURCE_PTR'
      DataPipeline = ppDB38
      OutlineSettings.CreateNode = True
      ReprintOnSubsequentPage = False
      UserName = 'Group1'
      mmNewColumnThreshold = 0
      mmNewPageThreshold = 0
      DataPipelineName = 'ppDB38'
      object ppGroupHeaderBand1: TppGroupHeaderBand
        PrintHeight = phDynamic
        mmBottomOffset = 0
        mmHeight = 12171
        mmPrintPosition = 0
        object pdbm2: TppDBMemo
          UserName = 'pdbm2'
          CharWrap = False
          DataField = #20840#23616#21442#25968'1'
          DataPipeline = ppDB25
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = #23435#20307
          Font.Size = 10
          Font.Style = []
          ParentDataPipeline = False
          Stretch = True
          Transparent = True
          DataPipelineName = 'ppDB25'
          mmHeight = 4233
          mmLeft = 4233
          mmTop = 7938
          mmWidth = 91281
          BandType = 3
          GroupNo = 1
          mmBottomOffset = 0
          mmOverFlowOffset = 0
          mmStopPosition = 0
          mmLeading = 0
        end
        object pdbm3: TppDBMemo
          UserName = 'pdbm3'
          CharWrap = False
          DataField = #20840#23616#21442#25968'2'
          DataPipeline = ppDB25
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = #23435#20307
          Font.Size = 10
          Font.Style = []
          ParentDataPipeline = False
          Stretch = True
          Transparent = True
          DataPipelineName = 'ppDB25'
          mmHeight = 4233
          mmLeft = 98954
          mmTop = 7938
          mmWidth = 91281
          BandType = 3
          GroupNo = 1
          mmBottomOffset = 0
          mmOverFlowOffset = 0
          mmStopPosition = 0
          mmLeading = 0
        end
        object ppLabel18: TppLabel
          UserName = 'Label18'
          Caption = #21442#25968#21517#31216
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = #23435#20307
          Font.Size = 10
          Font.Style = []
          TextAlignment = taRightJustified
          Transparent = True
          mmHeight = 3969
          mmLeft = 6085
          mmTop = 2117
          mmWidth = 14023
          BandType = 3
          GroupNo = 1
        end
        object ppLabel19: TppLabel
          UserName = 'Label19'
          Caption = #21442#25968#20540
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = #23435#20307
          Font.Size = 10
          Font.Style = []
          TextAlignment = taRightJustified
          Transparent = True
          mmHeight = 3969
          mmLeft = 44979
          mmTop = 2117
          mmWidth = 10583
          BandType = 3
          GroupNo = 1
        end
        object ppLine9: TppLine
          UserName = 'Line9'
          Weight = 0.750000000000000000
          mmHeight = 265
          mmLeft = 2910
          mmTop = 6879
          mmWidth = 96838
          BandType = 3
          GroupNo = 1
        end
        object ppLabel20: TppLabel
          UserName = 'Label20'
          Caption = #21442#25968#21517#31216
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = #23435#20307
          Font.Size = 10
          Font.Style = []
          TextAlignment = taRightJustified
          Transparent = True
          mmHeight = 3969
          mmLeft = 102129
          mmTop = 2117
          mmWidth = 14023
          BandType = 3
          GroupNo = 1
        end
        object ppLabel21: TppLabel
          UserName = 'Label21'
          Caption = #21442#25968#20540
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = #23435#20307
          Font.Size = 10
          Font.Style = []
          TextAlignment = taRightJustified
          Transparent = True
          mmHeight = 3969
          mmLeft = 141023
          mmTop = 2117
          mmWidth = 10583
          BandType = 3
          GroupNo = 1
        end
        object ppLine10: TppLine
          UserName = 'Line10'
          Weight = 0.750000000000000000
          mmHeight = 265
          mmLeft = 98954
          mmTop = 6879
          mmWidth = 94456
          BandType = 3
          GroupNo = 1
        end
        object ppLine8: TppLine
          UserName = 'Line8'
          ParentWidth = True
          Weight = 0.750000000000000000
          mmHeight = 794
          mmLeft = 0
          mmTop = 1323
          mmWidth = 197300
          BandType = 3
          GroupNo = 1
        end
      end
      object ppGroupFooterBand1: TppGroupFooterBand
        PrintHeight = phDynamic
        mmBottomOffset = 0
        mmHeight = 5027
        mmPrintPosition = 0
        object ppSubReport3: TppSubReport
          UserName = 'SubReport3'
          ExpandAll = False
          NewPrintJob = False
          OutlineSettings.CreateNode = True
          TraverseAllData = False
          DataPipelineName = 'ppDB2901'
          mmHeight = 5027
          mmLeft = 0
          mmTop = 0
          mmWidth = 197300
          BandType = 5
          GroupNo = 1
          mmBottomOffset = 0
          mmOverFlowOffset = 0
          mmStopPosition = 0
          object ppChildReport3: TppChildReport
            AutoStop = False
            DataPipeline = ppDB2901
            PrinterSetup.BinName = 'Default'
            PrinterSetup.DocumentName = 'Report'
            PrinterSetup.PaperName = 'A4'
            PrinterSetup.PrinterName = 'Default'
            PrinterSetup.mmMarginBottom = 350
            PrinterSetup.mmMarginLeft = 6350
            PrinterSetup.mmMarginRight = 6350
            PrinterSetup.mmMarginTop = 5350
            PrinterSetup.mmPaperHeight = 297000
            PrinterSetup.mmPaperWidth = 210000
            PrinterSetup.PaperSize = 9
            Units = utMillimeters
            Version = '7.01'
            mmColumnWidth = 0
            DataPipelineName = 'ppDB2901'
            object ptlbnd3: TppTitleBand
              mmBottomOffset = 0
              mmHeight = 0
              mmPrintPosition = 0
            end
            object phdrbnd3: TppHeaderBand
              Visible = False
              mmBottomOffset = 0
              mmHeight = 0
              mmPrintPosition = 0
            end
            object ppDetailBand4: TppDetailBand
              mmBottomOffset = 0
              mmHeight = 4233
              mmPrintPosition = 0
              object ppLine20: TppLine
                UserName = 'Line20'
                ParentHeight = True
                ParentWidth = True
                Position = lpBottom
                Weight = 0.750000000000000000
                mmHeight = 4233
                mmLeft = 0
                mmTop = 0
                mmWidth = 197300
                BandType = 4
              end
              object ppLine7: TppLine
                UserName = 'Line301'
                ParentHeight = True
                ParentWidth = True
                Position = lpRight
                Weight = 0.750000000000000000
                mmHeight = 4233
                mmLeft = 0
                mmTop = 0
                mmWidth = 197300
                BandType = 4
              end
              object ppDBText22: TppDBText
                UserName = 'DBText22'
                AutoSize = True
                DataField = #20992#20855
                DataPipeline = ppDB2901
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = 'Arial'
                Font.Size = 10
                Font.Style = []
                TextAlignment = taCentered
                Transparent = True
                DataPipelineName = 'ppDB2901'
                mmHeight = 4022
                mmLeft = 3985
                mmTop = 211
                mmWidth = 7112
                BandType = 4
              end
              object ppDBText23: TppDBText
                UserName = 'DBText23'
                AutoSize = True
                DataField = #31526#21495
                DataPipeline = ppDB2901
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = 'Arial'
                Font.Size = 10
                Font.Style = []
                TextAlignment = taCentered
                Transparent = True
                DataPipelineName = 'ppDB2901'
                mmHeight = 4022
                mmLeft = 16156
                mmTop = 211
                mmWidth = 7112
                BandType = 4
              end
              object ppDBText24: TppDBText
                UserName = 'DBText24'
                AutoSize = True
                DataField = #25104#21697#23380#24452
                DataPipeline = ppDB2901
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = 'Arial'
                Font.Size = 10
                Font.Style = []
                TextAlignment = taCentered
                Transparent = True
                DataPipelineName = 'ppDB2901'
                mmHeight = 3969
                mmLeft = 25400
                mmTop = 265
                mmWidth = 21696
                BandType = 4
              end
              object ppDBText25: TppDBText
                UserName = 'DBText25'
                AutoSize = True
                DataField = 'PTH'#23380
                DataPipeline = ppDB2901
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = 'Arial'
                Font.Size = 10
                Font.Style = []
                TextAlignment = taCentered
                Transparent = True
                DataPipelineName = 'ppDB2901'
                mmHeight = 3969
                mmLeft = 48948
                mmTop = 265
                mmWidth = 9790
                BandType = 4
              end
              object ppDBText26: TppDBText
                UserName = 'DBText26'
                AutoSize = True
                DataField = #20844#24046
                DataPipeline = ppDB2901
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = 'Arial'
                Font.Size = 10
                Font.Style = []
                TextAlignment = taCentered
                Transparent = True
                DataPipelineName = 'ppDB2901'
                mmHeight = 3969
                mmLeft = 61648
                mmTop = 0
                mmWidth = 15346
                BandType = 4
              end
              object ppDBText27: TppDBText
                UserName = 'DBText27'
                AutoSize = True
                DataField = #38075#21632
                DataPipeline = ppDB2901
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = 'Arial'
                Font.Size = 10
                Font.Style = []
                TextAlignment = taCentered
                Transparent = True
                DataPipelineName = 'ppDB2901'
                mmHeight = 4022
                mmLeft = 86519
                mmTop = 211
                mmWidth = 7112
                BandType = 4
              end
              object ppDBText28: TppDBText
                UserName = 'DBText28'
                AutoSize = True
                DataField = 'PCS'#23380#25968
                DataPipeline = ppDB2901
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = 'Arial'
                Font.Size = 10
                Font.Style = []
                Transparent = True
                DataPipelineName = 'ppDB2901'
                mmHeight = 4022
                mmLeft = 99484
                mmTop = 265
                mmWidth = 14309
                BandType = 4
              end
              object ppDBText29: TppDBText
                UserName = 'DBText29'
                AutoSize = True
                DataField = 'A'#26495#23380#25968
                DataPipeline = ppDB2901
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = 'Arial'
                Font.Size = 10
                Font.Style = []
                Transparent = True
                DataPipelineName = 'ppDB2901'
                mmHeight = 4022
                mmLeft = 119063
                mmTop = 0
                mmWidth = 12996
                BandType = 4
              end
              object ppDBText30: TppDBText
                UserName = 'DBText30'
                AutoSize = True
                DataField = 'B'#26495#23380#25968
                DataPipeline = ppDB2901
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = 'Arial'
                Font.Size = 10
                Font.Style = []
                Transparent = True
                DataPipelineName = 'ppDB2901'
                mmHeight = 4022
                mmLeft = 137319
                mmTop = 0
                mmWidth = 12996
                BandType = 4
              end
              object ppDBText31: TppDBText
                UserName = 'DBText31'
                AutoSize = True
                DataField = #22791#27880
                DataPipeline = ppDB2901
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = 'Arial'
                Font.Size = 10
                Font.Style = []
                Transparent = True
                DataPipelineName = 'ppDB2901'
                mmHeight = 3969
                mmLeft = 157692
                mmTop = 0
                mmWidth = 7144
                BandType = 4
              end
              object ppLine21: TppLine
                UserName = 'Line21'
                ParentHeight = True
                Position = lpLeft
                Weight = 0.750000000000000000
                mmHeight = 4233
                mmLeft = 0
                mmTop = 0
                mmWidth = 2381
                BandType = 4
              end
              object ppLine22: TppLine
                UserName = 'Line22'
                ParentHeight = True
                Position = lpLeft
                Weight = 0.750000000000000000
                mmHeight = 4233
                mmLeft = 14552
                mmTop = 0
                mmWidth = 2381
                BandType = 4
              end
              object ppLine23: TppLine
                UserName = 'Line23'
                ParentHeight = True
                Position = lpLeft
                Weight = 0.750000000000000000
                mmHeight = 4233
                mmLeft = 24606
                mmTop = 0
                mmWidth = 2381
                BandType = 4
              end
              object pln1: TppLine
                UserName = 'pln1'
                ParentHeight = True
                Position = lpLeft
                Weight = 0.750000000000000000
                mmHeight = 4233
                mmLeft = 48154
                mmTop = 0
                mmWidth = 2381
                BandType = 4
              end
              object pln2: TppLine
                UserName = 'pln2'
                ParentHeight = True
                Position = lpLeft
                Weight = 0.750000000000000000
                mmHeight = 4233
                mmLeft = 59531
                mmTop = 0
                mmWidth = 2381
                BandType = 4
              end
              object pln3: TppLine
                UserName = 'pln3'
                ParentHeight = True
                Position = lpLeft
                Weight = 0.750000000000000000
                mmHeight = 4233
                mmLeft = 81756
                mmTop = 0
                mmWidth = 2381
                BandType = 4
              end
              object pln4: TppLine
                UserName = 'pln4'
                ParentHeight = True
                Position = lpLeft
                Weight = 0.750000000000000000
                mmHeight = 4233
                mmLeft = 98425
                mmTop = 0
                mmWidth = 2381
                BandType = 4
              end
              object pln5: TppLine
                UserName = 'pln5'
                ParentHeight = True
                Position = lpLeft
                Weight = 0.750000000000000000
                mmHeight = 4233
                mmLeft = 118534
                mmTop = 0
                mmWidth = 2381
                BandType = 4
              end
              object pln6: TppLine
                UserName = 'pln6'
                ParentHeight = True
                Position = lpLeft
                Weight = 0.750000000000000000
                mmHeight = 4233
                mmLeft = 136525
                mmTop = 0
                mmWidth = 2381
                BandType = 4
              end
              object pln7: TppLine
                UserName = 'pln7'
                ParentHeight = True
                Position = lpLeft
                Weight = 0.750000000000000000
                mmHeight = 4233
                mmLeft = 155575
                mmTop = 0
                mmWidth = 2381
                BandType = 4
              end
            end
            object ppSummaryBand4: TppSummaryBand
              mmBottomOffset = 0
              mmHeight = 0
              mmPrintPosition = 0
            end
            object ppGroup4: TppGroup
              BreakName = 'ppLabel28'
              BreakType = btCustomField
              KeepTogether = True
              OutlineSettings.CreateNode = True
              UserName = 'Group4'
              mmNewColumnThreshold = 0
              mmNewPageThreshold = 0
              DataPipelineName = ''
              object ppGroupHeaderBand4: TppGroupHeaderBand
                mmBottomOffset = 0
                mmHeight = 16404
                mmPrintPosition = 0
                object ppShape2: TppShape
                  UserName = 'Shape2'
                  ParentWidth = True
                  mmHeight = 6085
                  mmLeft = 0
                  mmTop = 10319
                  mmWidth = 197300
                  BandType = 3
                  GroupNo = 0
                end
                object ppLabel28: TppLabel
                  UserName = 'Label28'
                  Caption = #20992#20855
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clBlack
                  Font.Name = 'Arial'
                  Font.Size = 10
                  Font.Style = []
                  Transparent = True
                  mmHeight = 3969
                  mmLeft = 4498
                  mmTop = 11377
                  mmWidth = 7144
                  BandType = 3
                  GroupNo = 0
                end
                object ppLabel29: TppLabel
                  UserName = 'Label29'
                  Caption = #31526#21495
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clBlack
                  Font.Name = 'Arial'
                  Font.Size = 10
                  Font.Style = []
                  Transparent = True
                  mmHeight = 3969
                  mmLeft = 15875
                  mmTop = 11377
                  mmWidth = 7144
                  BandType = 3
                  GroupNo = 0
                end
                object ppLabel30: TppLabel
                  UserName = 'Label30'
                  Caption = #25104#21697#23380#24452
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clBlack
                  Font.Name = 'Arial'
                  Font.Size = 10
                  Font.Style = []
                  Transparent = True
                  mmHeight = 3969
                  mmLeft = 25135
                  mmTop = 11377
                  mmWidth = 21960
                  BandType = 3
                  GroupNo = 0
                end
                object ppLabel31: TppLabel
                  UserName = 'Label31'
                  Caption = 'PTH'
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clBlack
                  Font.Name = 'Arial'
                  Font.Size = 10
                  Font.Style = []
                  Transparent = True
                  mmHeight = 3969
                  mmLeft = 49742
                  mmTop = 11377
                  mmWidth = 7144
                  BandType = 3
                  GroupNo = 0
                end
                object ppLabel32: TppLabel
                  UserName = 'Label32'
                  Caption = #20844#24046
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clBlack
                  Font.Name = 'Arial'
                  Font.Size = 10
                  Font.Style = []
                  Transparent = True
                  mmHeight = 3969
                  mmLeft = 65088
                  mmTop = 11377
                  mmWidth = 7144
                  BandType = 3
                  GroupNo = 0
                end
                object ppLabel33: TppLabel
                  UserName = 'Label33'
                  Caption = #38075#21632
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clBlack
                  Font.Name = 'Arial'
                  Font.Size = 10
                  Font.Style = []
                  Transparent = True
                  mmHeight = 3969
                  mmLeft = 84667
                  mmTop = 11377
                  mmWidth = 7144
                  BandType = 3
                  GroupNo = 0
                end
                object ppLabel34: TppLabel
                  UserName = 'Label34'
                  Caption = #21333#20803#23380#25968
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clBlack
                  Font.Name = 'Arial'
                  Font.Size = 10
                  Font.Style = []
                  Transparent = True
                  mmHeight = 3969
                  mmLeft = 100806
                  mmTop = 11377
                  mmWidth = 14288
                  BandType = 3
                  GroupNo = 0
                end
                object ppLabel35: TppLabel
                  UserName = 'Label35'
                  Caption = 'A'#26495#23380#25968
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clBlack
                  Font.Name = 'Arial'
                  Font.Size = 10
                  Font.Style = []
                  Transparent = True
                  mmHeight = 3969
                  mmLeft = 120915
                  mmTop = 11377
                  mmWidth = 12965
                  BandType = 3
                  GroupNo = 0
                end
                object ppLabel36: TppLabel
                  UserName = 'Label36'
                  Caption = 'B'#26495#23380#25968
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clBlack
                  Font.Name = 'Arial'
                  Font.Size = 10
                  Font.Style = []
                  Transparent = True
                  mmHeight = 3969
                  mmLeft = 137848
                  mmTop = 11377
                  mmWidth = 12965
                  BandType = 3
                  GroupNo = 0
                end
                object ppLabel37: TppLabel
                  UserName = 'Label37'
                  Caption = #22791#27880
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clBlack
                  Font.Name = 'Arial'
                  Font.Size = 10
                  Font.Style = []
                  Transparent = True
                  mmHeight = 3969
                  mmLeft = 164571
                  mmTop = 11377
                  mmWidth = 7144
                  BandType = 3
                  GroupNo = 0
                end
                object ppLabel38: TppLabel
                  UserName = 'Label38'
                  Caption = #20108#38075#21632#34920
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clBlack
                  Font.Name = #23435#20307
                  Font.Size = 14
                  Font.Style = [fsBold]
                  TextAlignment = taCentered
                  Transparent = True
                  mmHeight = 5630
                  mmLeft = 88568
                  mmTop = 3969
                  mmWidth = 19981
                  BandType = 3
                  GroupNo = 0
                end
                object pln8: TppLine
                  UserName = 'pln8'
                  ParentWidth = True
                  Weight = 0.750000000000000000
                  mmHeight = 3175
                  mmLeft = 0
                  mmTop = 0
                  mmWidth = 197300
                  BandType = 3
                  GroupNo = 0
                end
                object pln9: TppLine
                  UserName = 'pln9'
                  Position = lpLeft
                  Weight = 0.750000000000000000
                  mmHeight = 6085
                  mmLeft = 14552
                  mmTop = 10319
                  mmWidth = 2910
                  BandType = 3
                  GroupNo = 0
                end
                object pln10: TppLine
                  UserName = 'pln10'
                  Position = lpLeft
                  Weight = 0.750000000000000000
                  mmHeight = 6085
                  mmLeft = 24606
                  mmTop = 10319
                  mmWidth = 2910
                  BandType = 3
                  GroupNo = 0
                end
                object pln11: TppLine
                  UserName = 'pln11'
                  Position = lpLeft
                  Weight = 0.750000000000000000
                  mmHeight = 6085
                  mmLeft = 47890
                  mmTop = 10319
                  mmWidth = 2910
                  BandType = 3
                  GroupNo = 0
                end
                object pln12: TppLine
                  UserName = 'pln12'
                  Position = lpLeft
                  Weight = 0.750000000000000000
                  mmHeight = 6085
                  mmLeft = 59267
                  mmTop = 10319
                  mmWidth = 2910
                  BandType = 3
                  GroupNo = 0
                end
                object pln13: TppLine
                  UserName = 'pln13'
                  Position = lpLeft
                  Weight = 0.750000000000000000
                  mmHeight = 6085
                  mmLeft = 81492
                  mmTop = 10319
                  mmWidth = 2910
                  BandType = 3
                  GroupNo = 0
                end
                object pln14: TppLine
                  UserName = 'pln14'
                  Position = lpLeft
                  Weight = 0.750000000000000000
                  mmHeight = 6085
                  mmLeft = 98161
                  mmTop = 10319
                  mmWidth = 2910
                  BandType = 3
                  GroupNo = 0
                end
                object pln15: TppLine
                  UserName = 'Line401'
                  Position = lpLeft
                  Weight = 0.750000000000000000
                  mmHeight = 6085
                  mmLeft = 118269
                  mmTop = 10319
                  mmWidth = 2910
                  BandType = 3
                  GroupNo = 0
                end
                object pln16: TppLine
                  UserName = 'pln16'
                  Position = lpLeft
                  Weight = 0.750000000000000000
                  mmHeight = 6085
                  mmLeft = 136261
                  mmTop = 10319
                  mmWidth = 2910
                  BandType = 3
                  GroupNo = 0
                end
                object pln17: TppLine
                  UserName = 'pln17'
                  Position = lpLeft
                  Weight = 0.750000000000000000
                  mmHeight = 6085
                  mmLeft = 155311
                  mmTop = 10319
                  mmWidth = 2910
                  BandType = 3
                  GroupNo = 0
                end
              end
              object ppGroupFooterBand4: TppGroupFooterBand
                mmBottomOffset = 0
                mmHeight = 0
                mmPrintPosition = 0
              end
            end
            object raCodeModule2: TraCodeModule
              ProgramStream = {00}
            end
          end
        end
      end
    end
    object ppGroup3: TppGroup
      BreakName = 'SOURCE_PTR'
      DataPipeline = ppDB38
      OutlineSettings.CreateNode = True
      ReprintOnSubsequentPage = False
      UserName = 'Group3'
      mmNewColumnThreshold = 0
      mmNewPageThreshold = 0
      DataPipelineName = 'ppDB38'
      object ppGroupHeaderBand3: TppGroupHeaderBand
        mmBottomOffset = 0
        mmHeight = 0
        mmPrintPosition = 0
      end
      object ppGroupFooterBand3: TppGroupFooterBand
        PrintHeight = phDynamic
        mmBottomOffset = 0
        mmHeight = 5292
        mmPrintPosition = 0
        object ppSubReport6: TppSubReport
          UserName = 'SubReport6'
          ExpandAll = False
          NewPrintJob = False
          OutlineSettings.CreateNode = True
          TraverseAllData = False
          DataPipelineName = 'ppDB29'
          mmHeight = 5027
          mmLeft = 0
          mmTop = 265
          mmWidth = 197300
          BandType = 5
          GroupNo = 2
          mmBottomOffset = 0
          mmOverFlowOffset = 0
          mmStopPosition = 0
          object ppChildReport6: TppChildReport
            AutoStop = False
            DataPipeline = ppDB29
            PrinterSetup.BinName = 'Default'
            PrinterSetup.DocumentName = 'Report'
            PrinterSetup.PaperName = 'A4'
            PrinterSetup.PrinterName = 'Default'
            PrinterSetup.mmMarginBottom = 350
            PrinterSetup.mmMarginLeft = 6350
            PrinterSetup.mmMarginRight = 6350
            PrinterSetup.mmMarginTop = 5350
            PrinterSetup.mmPaperHeight = 297000
            PrinterSetup.mmPaperWidth = 210000
            PrinterSetup.PaperSize = 9
            Units = utMillimeters
            Version = '7.01'
            mmColumnWidth = 0
            DataPipelineName = 'ppDB29'
            object ptlbnd4: TppTitleBand
              mmBottomOffset = 0
              mmHeight = 0
              mmPrintPosition = 0
            end
            object phdrbnd4: TppHeaderBand
              Visible = False
              mmBottomOffset = 0
              mmHeight = 0
              mmPrintPosition = 0
            end
            object ppDetailBand7: TppDetailBand
              mmBottomOffset = 0
              mmHeight = 4233
              mmPrintPosition = 0
              object pln18: TppLine
                UserName = 'Line20'
                ParentHeight = True
                ParentWidth = True
                Position = lpBottom
                Weight = 0.750000000000000000
                mmHeight = 4233
                mmLeft = 0
                mmTop = 0
                mmWidth = 197300
                BandType = 4
              end
              object pln19: TppLine
                UserName = 'Line301'
                ParentHeight = True
                ParentWidth = True
                Position = lpRight
                Weight = 0.750000000000000000
                mmHeight = 4233
                mmLeft = 0
                mmTop = 0
                mmWidth = 197300
                BandType = 4
              end
              object ppDBText51: TppDBText
                UserName = 'DBText22'
                AutoSize = True
                DataField = #20992#20855
                DataPipeline = ppDB29
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = 'Arial'
                Font.Size = 10
                Font.Style = []
                TextAlignment = taCentered
                Transparent = True
                DataPipelineName = 'ppDB29'
                mmHeight = 4022
                mmLeft = 3985
                mmTop = 211
                mmWidth = 7112
                BandType = 4
              end
              object ppDBText52: TppDBText
                UserName = 'DBText23'
                AutoSize = True
                DataField = #31526#21495
                DataPipeline = ppDB29
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = 'Arial'
                Font.Size = 10
                Font.Style = []
                TextAlignment = taCentered
                Transparent = True
                DataPipelineName = 'ppDB29'
                mmHeight = 4022
                mmLeft = 16156
                mmTop = 211
                mmWidth = 7112
                BandType = 4
              end
              object ppDBText53: TppDBText
                UserName = 'DBText24'
                AutoSize = True
                DataField = #25104#21697#23380#24452
                DataPipeline = ppDB29
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = 'Arial'
                Font.Size = 10
                Font.Style = []
                TextAlignment = taCentered
                Transparent = True
                DataPipelineName = 'ppDB29'
                mmHeight = 3969
                mmLeft = 25400
                mmTop = 265
                mmWidth = 21696
                BandType = 4
              end
              object ppDBText54: TppDBText
                UserName = 'DBText25'
                AutoSize = True
                DataField = 'PTH'#23380
                DataPipeline = ppDB29
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = 'Arial'
                Font.Size = 10
                Font.Style = []
                TextAlignment = taCentered
                Transparent = True
                DataPipelineName = 'ppDB29'
                mmHeight = 3969
                mmLeft = 48948
                mmTop = 265
                mmWidth = 9790
                BandType = 4
              end
              object ppDBText55: TppDBText
                UserName = 'DBText26'
                AutoSize = True
                DataField = #20844#24046
                DataPipeline = ppDB29
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = 'Arial'
                Font.Size = 10
                Font.Style = []
                TextAlignment = taCentered
                Transparent = True
                DataPipelineName = 'ppDB29'
                mmHeight = 3969
                mmLeft = 61648
                mmTop = 0
                mmWidth = 15346
                BandType = 4
              end
              object ppDBText56: TppDBText
                UserName = 'DBText27'
                AutoSize = True
                DataField = #38075#21632
                DataPipeline = ppDB29
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = 'Arial'
                Font.Size = 10
                Font.Style = []
                TextAlignment = taCentered
                Transparent = True
                DataPipelineName = 'ppDB29'
                mmHeight = 4022
                mmLeft = 86519
                mmTop = 211
                mmWidth = 7112
                BandType = 4
              end
              object ppDBText57: TppDBText
                UserName = 'DBText28'
                AutoSize = True
                DataField = 'PCS'#23380#25968
                DataPipeline = ppDB29
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = 'Arial'
                Font.Size = 10
                Font.Style = []
                Transparent = True
                DataPipelineName = 'ppDB29'
                mmHeight = 4022
                mmLeft = 99484
                mmTop = 265
                mmWidth = 14309
                BandType = 4
              end
              object ppDBText58: TppDBText
                UserName = 'DBText29'
                AutoSize = True
                DataField = 'A'#26495#23380#25968
                DataPipeline = ppDB29
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = 'Arial'
                Font.Size = 10
                Font.Style = []
                Transparent = True
                DataPipelineName = 'ppDB29'
                mmHeight = 4022
                mmLeft = 119063
                mmTop = 0
                mmWidth = 12996
                BandType = 4
              end
              object ppDBText59: TppDBText
                UserName = 'DBText30'
                AutoSize = True
                DataField = 'B'#26495#23380#25968
                DataPipeline = ppDB29
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = 'Arial'
                Font.Size = 10
                Font.Style = []
                Transparent = True
                DataPipelineName = 'ppDB29'
                mmHeight = 4022
                mmLeft = 137319
                mmTop = 0
                mmWidth = 12996
                BandType = 4
              end
              object ppDBText60: TppDBText
                UserName = 'DBText31'
                AutoSize = True
                DataField = #22791#27880
                DataPipeline = ppDB29
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = 'Arial'
                Font.Size = 10
                Font.Style = []
                Transparent = True
                DataPipelineName = 'ppDB29'
                mmHeight = 3969
                mmLeft = 158221
                mmTop = 0
                mmWidth = 7144
                BandType = 4
              end
              object pln20: TppLine
                UserName = 'Line21'
                ParentHeight = True
                Position = lpLeft
                Weight = 0.750000000000000000
                mmHeight = 4233
                mmLeft = 0
                mmTop = 0
                mmWidth = 2381
                BandType = 4
              end
              object pln21: TppLine
                UserName = 'Line22'
                ParentHeight = True
                Position = lpLeft
                Weight = 0.750000000000000000
                mmHeight = 4233
                mmLeft = 14552
                mmTop = 0
                mmWidth = 2381
                BandType = 4
              end
              object pln22: TppLine
                UserName = 'Line23'
                ParentHeight = True
                Position = lpLeft
                Weight = 0.750000000000000000
                mmHeight = 4233
                mmLeft = 24606
                mmTop = 0
                mmWidth = 2381
                BandType = 4
              end
              object pln23: TppLine
                UserName = 'Line24'
                ParentHeight = True
                Position = lpLeft
                Weight = 0.750000000000000000
                mmHeight = 4233
                mmLeft = 48154
                mmTop = 0
                mmWidth = 2381
                BandType = 4
              end
              object pln24: TppLine
                UserName = 'Line25'
                ParentHeight = True
                Position = lpLeft
                Weight = 0.750000000000000000
                mmHeight = 4233
                mmLeft = 59531
                mmTop = 0
                mmWidth = 2381
                BandType = 4
              end
              object pln25: TppLine
                UserName = 'Line26'
                ParentHeight = True
                Position = lpLeft
                Weight = 0.750000000000000000
                mmHeight = 4233
                mmLeft = 81756
                mmTop = 0
                mmWidth = 2381
                BandType = 4
              end
              object pln26: TppLine
                UserName = 'Line27'
                ParentHeight = True
                Position = lpLeft
                Weight = 0.750000000000000000
                mmHeight = 4233
                mmLeft = 98425
                mmTop = 0
                mmWidth = 2381
                BandType = 4
              end
              object pln27: TppLine
                UserName = 'Line28'
                ParentHeight = True
                Position = lpLeft
                Weight = 0.750000000000000000
                mmHeight = 4233
                mmLeft = 118534
                mmTop = 0
                mmWidth = 2381
                BandType = 4
              end
              object pln28: TppLine
                UserName = 'Line29'
                ParentHeight = True
                Position = lpLeft
                Weight = 0.750000000000000000
                mmHeight = 4233
                mmLeft = 136525
                mmTop = 0
                mmWidth = 2381
                BandType = 4
              end
              object pln29: TppLine
                UserName = 'Line30'
                ParentHeight = True
                Position = lpLeft
                Weight = 0.750000000000000000
                mmHeight = 4233
                mmLeft = 155575
                mmTop = 0
                mmWidth = 2381
                BandType = 4
              end
            end
            object ppSummaryBand7: TppSummaryBand
              mmBottomOffset = 0
              mmHeight = 0
              mmPrintPosition = 0
            end
            object ppGroup12: TppGroup
              BreakName = 'ppLabel28'
              BreakType = btCustomField
              KeepTogether = True
              OutlineSettings.CreateNode = True
              UserName = 'Group4'
              mmNewColumnThreshold = 0
              mmNewPageThreshold = 0
              DataPipelineName = ''
              object ppGroupHeaderBand12: TppGroupHeaderBand
                mmBottomOffset = 0
                mmHeight = 16404
                mmPrintPosition = 0
                object ppShape1: TppShape
                  UserName = 'Shape2'
                  ParentWidth = True
                  mmHeight = 6085
                  mmLeft = 0
                  mmTop = 10319
                  mmWidth = 197300
                  BandType = 3
                  GroupNo = 0
                end
                object ppLabel1: TppLabel
                  UserName = 'Label28'
                  Caption = #20992#20855
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clBlack
                  Font.Name = 'Arial'
                  Font.Size = 10
                  Font.Style = []
                  Transparent = True
                  mmHeight = 3969
                  mmLeft = 4498
                  mmTop = 11377
                  mmWidth = 7144
                  BandType = 3
                  GroupNo = 0
                end
                object ppLabel22: TppLabel
                  UserName = 'Label29'
                  Caption = #31526#21495
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clBlack
                  Font.Name = 'Arial'
                  Font.Size = 10
                  Font.Style = []
                  Transparent = True
                  mmHeight = 3969
                  mmLeft = 15875
                  mmTop = 11377
                  mmWidth = 7144
                  BandType = 3
                  GroupNo = 0
                end
                object ppLabel68: TppLabel
                  UserName = 'Label30'
                  Caption = #25104#21697#23380#24452
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clBlack
                  Font.Name = 'Arial'
                  Font.Size = 10
                  Font.Style = []
                  Transparent = True
                  mmHeight = 3969
                  mmLeft = 25135
                  mmTop = 11377
                  mmWidth = 21960
                  BandType = 3
                  GroupNo = 0
                end
                object ppLabel69: TppLabel
                  UserName = 'Label31'
                  Caption = 'PTH'
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clBlack
                  Font.Name = 'Arial'
                  Font.Size = 10
                  Font.Style = []
                  Transparent = True
                  mmHeight = 3969
                  mmLeft = 49742
                  mmTop = 11377
                  mmWidth = 7144
                  BandType = 3
                  GroupNo = 0
                end
                object ppLabel70: TppLabel
                  UserName = 'Label32'
                  Caption = #20844#24046
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clBlack
                  Font.Name = 'Arial'
                  Font.Size = 10
                  Font.Style = []
                  Transparent = True
                  mmHeight = 3969
                  mmLeft = 65088
                  mmTop = 11377
                  mmWidth = 7144
                  BandType = 3
                  GroupNo = 0
                end
                object ppLabel71: TppLabel
                  UserName = 'Label33'
                  Caption = #38075#21632
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clBlack
                  Font.Name = 'Arial'
                  Font.Size = 10
                  Font.Style = []
                  Transparent = True
                  mmHeight = 3969
                  mmLeft = 84667
                  mmTop = 11377
                  mmWidth = 7144
                  BandType = 3
                  GroupNo = 0
                end
                object ppLabel72: TppLabel
                  UserName = 'Label34'
                  Caption = #21333#20803#23380#25968
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clBlack
                  Font.Name = 'Arial'
                  Font.Size = 10
                  Font.Style = []
                  Transparent = True
                  mmHeight = 3969
                  mmLeft = 100806
                  mmTop = 11377
                  mmWidth = 14288
                  BandType = 3
                  GroupNo = 0
                end
                object ppLabel73: TppLabel
                  UserName = 'Label35'
                  Caption = 'A'#26495#23380#25968
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clBlack
                  Font.Name = 'Arial'
                  Font.Size = 10
                  Font.Style = []
                  Transparent = True
                  mmHeight = 3969
                  mmLeft = 120915
                  mmTop = 11377
                  mmWidth = 12965
                  BandType = 3
                  GroupNo = 0
                end
                object ppLabel74: TppLabel
                  UserName = 'Label36'
                  Caption = 'B'#26495#23380#25968
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clBlack
                  Font.Name = 'Arial'
                  Font.Size = 10
                  Font.Style = []
                  Transparent = True
                  mmHeight = 3969
                  mmLeft = 137848
                  mmTop = 11377
                  mmWidth = 12965
                  BandType = 3
                  GroupNo = 0
                end
                object ppLabel75: TppLabel
                  UserName = 'Label37'
                  Caption = #22791#27880
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clBlack
                  Font.Name = 'Arial'
                  Font.Size = 10
                  Font.Style = []
                  Transparent = True
                  mmHeight = 3969
                  mmLeft = 164571
                  mmTop = 11377
                  mmWidth = 7144
                  BandType = 3
                  GroupNo = 0
                end
                object ppLabel76: TppLabel
                  UserName = 'Label38'
                  Caption = #19968#38075#21632#34920
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clBlack
                  Font.Name = #23435#20307
                  Font.Size = 14
                  Font.Style = [fsBold]
                  TextAlignment = taCentered
                  Transparent = True
                  mmHeight = 5630
                  mmLeft = 88567
                  mmTop = 3969
                  mmWidth = 19981
                  BandType = 3
                  GroupNo = 0
                end
                object pln30: TppLine
                  UserName = 'Line19'
                  ParentWidth = True
                  Weight = 0.750000000000000000
                  mmHeight = 3175
                  mmLeft = 0
                  mmTop = 0
                  mmWidth = 197300
                  BandType = 3
                  GroupNo = 0
                end
                object pln31: TppLine
                  UserName = 'Line35'
                  Position = lpLeft
                  Weight = 0.750000000000000000
                  mmHeight = 6085
                  mmLeft = 14552
                  mmTop = 10319
                  mmWidth = 2910
                  BandType = 3
                  GroupNo = 0
                end
                object pln32: TppLine
                  UserName = 'Line36'
                  Position = lpLeft
                  Weight = 0.750000000000000000
                  mmHeight = 6085
                  mmLeft = 24606
                  mmTop = 10319
                  mmWidth = 2910
                  BandType = 3
                  GroupNo = 0
                end
                object pln33: TppLine
                  UserName = 'Line37'
                  Position = lpLeft
                  Weight = 0.750000000000000000
                  mmHeight = 6085
                  mmLeft = 47890
                  mmTop = 10319
                  mmWidth = 2910
                  BandType = 3
                  GroupNo = 0
                end
                object pln34: TppLine
                  UserName = 'Line38'
                  Position = lpLeft
                  Weight = 0.750000000000000000
                  mmHeight = 6085
                  mmLeft = 59267
                  mmTop = 10319
                  mmWidth = 2910
                  BandType = 3
                  GroupNo = 0
                end
                object pln35: TppLine
                  UserName = 'Line39'
                  Position = lpLeft
                  Weight = 0.750000000000000000
                  mmHeight = 6085
                  mmLeft = 81492
                  mmTop = 10319
                  mmWidth = 2910
                  BandType = 3
                  GroupNo = 0
                end
                object pln36: TppLine
                  UserName = 'Line40'
                  Position = lpLeft
                  Weight = 0.750000000000000000
                  mmHeight = 6085
                  mmLeft = 98161
                  mmTop = 10319
                  mmWidth = 2910
                  BandType = 3
                  GroupNo = 0
                end
                object pln37: TppLine
                  UserName = 'Line401'
                  Position = lpLeft
                  Weight = 0.750000000000000000
                  mmHeight = 6085
                  mmLeft = 118269
                  mmTop = 10319
                  mmWidth = 2910
                  BandType = 3
                  GroupNo = 0
                end
                object pln38: TppLine
                  UserName = 'Line42'
                  Position = lpLeft
                  Weight = 0.750000000000000000
                  mmHeight = 6085
                  mmLeft = 136261
                  mmTop = 10319
                  mmWidth = 2910
                  BandType = 3
                  GroupNo = 0
                end
                object pln39: TppLine
                  UserName = 'Line43'
                  Position = lpLeft
                  Weight = 0.750000000000000000
                  mmHeight = 6085
                  mmLeft = 155311
                  mmTop = 10319
                  mmWidth = 2910
                  BandType = 3
                  GroupNo = 0
                end
              end
              object ppGroupFooterBand12: TppGroupFooterBand
                mmBottomOffset = 0
                mmHeight = 0
                mmPrintPosition = 0
              end
            end
            object raCodeModule6: TraCodeModule
              ProgramStream = {00}
            end
          end
        end
      end
    end
    object ppGroup9: TppGroup
      BreakName = 'SOURCE_PTR'
      DataPipeline = ppDB38
      OutlineSettings.CreateNode = True
      ReprintOnSubsequentPage = False
      UserName = 'Group9'
      mmNewColumnThreshold = 0
      mmNewPageThreshold = 0
      DataPipelineName = 'ppDB38'
      object ppGroupHeaderBand9: TppGroupHeaderBand
        mmBottomOffset = 0
        mmHeight = 4763
        mmPrintPosition = 0
        object ppLabel67: TppLabel
          UserName = 'Label67'
          Caption = #21046#31243#21442#25968
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 10
          Font.Style = []
          Transparent = True
          mmHeight = 3969
          mmLeft = 67998
          mmTop = 529
          mmWidth = 14288
          BandType = 3
          GroupNo = 4
        end
        object ppLabel2: TppLabel
          UserName = 'Label2'
          Caption = #24037#24207#21517#31216
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 10
          Font.Style = []
          Transparent = True
          mmHeight = 3969
          mmLeft = 11113
          mmTop = 265
          mmWidth = 14288
          BandType = 3
          GroupNo = 4
        end
        object ppLabel23: TppLabel
          UserName = 'Label23'
          Caption = #27493#39588
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 10
          Font.Style = []
          Transparent = True
          mmHeight = 3969
          mmLeft = 1323
          mmTop = 0
          mmWidth = 7144
          BandType = 3
          GroupNo = 4
        end
        object ppLabel24: TppLabel
          UserName = 'Label24'
          Caption = #24037#20855
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = 'Arial'
          Font.Size = 10
          Font.Style = []
          Transparent = True
          mmHeight = 3969
          mmLeft = 185738
          mmTop = 529
          mmWidth = 10583
          BandType = 3
          GroupNo = 4
        end
        object pln40: TppLine
          UserName = 'pln40'
          Weight = 0.750000000000000000
          mmHeight = 529
          mmLeft = 0
          mmTop = 0
          mmWidth = 197115
          BandType = 3
          GroupNo = 4
        end
        object pln41: TppLine
          UserName = 'pln41'
          Position = lpLeft
          Weight = 0.750000000000000000
          mmHeight = 4763
          mmLeft = 9790
          mmTop = 0
          mmWidth = 794
          BandType = 3
          GroupNo = 4
        end
        object pln42: TppLine
          UserName = 'pln42'
          Position = lpLeft
          Weight = 0.750000000000000000
          mmHeight = 4763
          mmLeft = 28310
          mmTop = 0
          mmWidth = 1058
          BandType = 3
          GroupNo = 4
        end
        object pln43: TppLine
          UserName = 'pln43'
          Position = lpLeft
          Weight = 0.750000000000000000
          mmHeight = 4763
          mmLeft = 179652
          mmTop = 0
          mmWidth = 794
          BandType = 3
          GroupNo = 4
        end
        object pln44: TppLine
          UserName = 'pln44'
          Position = lpLeft
          Weight = 0.750000000000000000
          mmHeight = 4763
          mmLeft = 197115
          mmTop = 0
          mmWidth = 13229
          BandType = 3
          GroupNo = 4
        end
        object pln45: TppLine
          UserName = 'pln45'
          Position = lpLeft
          Weight = 0.750000000000000000
          mmHeight = 6615
          mmLeft = 0
          mmTop = 0
          mmWidth = 1323
          BandType = 3
          GroupNo = 4
        end
      end
      object ppGroupFooterBand9: TppGroupFooterBand
        PrintHeight = phDynamic
        mmBottomOffset = 0
        mmHeight = 5027
        mmPrintPosition = 0
        object ppSubReport2: TppSubReport
          UserName = 'SubReport2'
          ExpandAll = False
          NewPrintJob = False
          OutlineSettings.CreateNode = True
          TraverseAllData = False
          DataPipelineName = 'ppDB25'
          mmHeight = 5027
          mmLeft = 0
          mmTop = 0
          mmWidth = 197300
          BandType = 5
          GroupNo = 3
          mmBottomOffset = 0
          mmOverFlowOffset = 0
          mmStopPosition = 0
          object ppChildReport2: TppChildReport
            AutoStop = False
            DataPipeline = ppDB25
            PrinterSetup.BinName = 'Default'
            PrinterSetup.DocumentName = 'Report'
            PrinterSetup.PaperName = 'A4'
            PrinterSetup.PrinterName = 'Default'
            PrinterSetup.mmMarginBottom = 350
            PrinterSetup.mmMarginLeft = 6350
            PrinterSetup.mmMarginRight = 6350
            PrinterSetup.mmMarginTop = 5350
            PrinterSetup.mmPaperHeight = 297000
            PrinterSetup.mmPaperWidth = 210000
            PrinterSetup.PaperSize = 9
            Units = utMillimeters
            Version = '7.01'
            mmColumnWidth = 0
            DataPipelineName = 'ppDB25'
            object ptlbnd5: TppTitleBand
              mmBottomOffset = 0
              mmHeight = 0
              mmPrintPosition = 0
            end
            object phdrbnd5: TppHeaderBand
              Visible = False
              mmBottomOffset = 0
              mmHeight = 0
              mmPrintPosition = 0
            end
            object ppDetailBand3: TppDetailBand
              PrintHeight = phDynamic
              mmBottomOffset = 0
              mmHeight = 5292
              mmPrintPosition = 0
              object pdbm4: TppDBMemo
                UserName = 'pdbm4'
                CharWrap = False
                DataField = #23618#21387#32467#26500
                DataPipeline = ppDB25
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = #26032#23435#20307
                Font.Size = 10
                Font.Style = []
                Stretch = True
                Transparent = True
                DataPipelineName = 'ppDB25'
                mmHeight = 4763
                mmLeft = 2646
                mmTop = 529
                mmWidth = 179123
                BandType = 4
                mmBottomOffset = 0
                mmOverFlowOffset = 0
                mmStopPosition = 0
                mmLeading = 0
              end
            end
            object ppSummaryBand3: TppSummaryBand
              mmBottomOffset = 0
              mmHeight = 0
              mmPrintPosition = 0
            end
            object ppGroup5: TppGroup
              BreakName = 'ppLabel27'
              BreakType = btCustomField
              OutlineSettings.CreateNode = True
              NewPage = True
              UserName = 'Group5'
              mmNewColumnThreshold = 0
              mmNewPageThreshold = 0
              DataPipelineName = ''
              object ppGroupHeaderBand5: TppGroupHeaderBand
                PrintHeight = phDynamic
                mmBottomOffset = 0
                mmHeight = 12435
                mmPrintPosition = 0
                object ppLabel27: TppLabel
                  UserName = 'Label27'
                  Caption = #23618#21387#22270':'
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clBlack
                  Font.Name = #23435#20307
                  Font.Size = 14
                  Font.Style = [fsBold]
                  TextAlignment = taCentered
                  Transparent = True
                  mmHeight = 5556
                  mmLeft = 76729
                  mmTop = 1058
                  mmWidth = 17463
                  BandType = 3
                  GroupNo = 0
                end
                object pln46: TppLine
                  UserName = 'pln46'
                  ParentWidth = True
                  Weight = 0.750000000000000000
                  mmHeight = 2117
                  mmLeft = 0
                  mmTop = 0
                  mmWidth = 197300
                  BandType = 3
                  GroupNo = 0
                end
                object ppImage4: TppImage
                  UserName = 'Image4'
                  MaintainAspectRatio = False
                  mmHeight = 10319
                  mmLeft = 14023
                  mmTop = 2116
                  mmWidth = 13229
                  BandType = 3
                  GroupNo = 0
                end
                object ppVariable5: TppVariable
                  UserName = 'Variable5'
                  CalcOrder = 0
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clBlack
                  Font.Name = #23435#20307
                  Font.Size = 14
                  Font.Style = []
                  Transparent = True
                  mmHeight = 5630
                  mmLeft = 120650
                  mmTop = 3704
                  mmWidth = 22479
                  BandType = 3
                  GroupNo = 0
                end
              end
              object ppGroupFooterBand5: TppGroupFooterBand
                mmBottomOffset = 0
                mmHeight = 0
                mmPrintPosition = 0
              end
            end
            object raCodeModule3: TraCodeModule
              ProgramStream = {
                01060F5472614576656E7448616E646C65720B50726F6772616D4E616D65060F
                5661726961626C65354F6E43616C630B50726F6772616D54797065070B747450
                726F63656475726506536F7572636506D770726F636564757265205661726961
                626C65354F6E43616C63287661722056616C75653A2056617269616E74293B0D
                0A626567696E0D0A0D0A696620444232355B276C61796572735F696E666F275D
                3D2727207468656E0D0A626567696E0D0A206C6162656C32372E76697369626C
                653A3D66616C73653B0D0A202020656E640D0A2020656C73650D0A2062656769
                6E20202020202020202020202020202020202020202020202020200D0A206C61
                62656C32372E76697369626C653A3D747275653B0D0A656E643B0D0A0D0A0D0A
                0D0A656E643B0D0A0D436F6D706F6E656E744E616D6506095661726961626C65
                35094576656E744E616D6506064F6E43616C63074576656E74494402210000}
            end
          end
        end
      end
    end
    object ppGroup7: TppGroup
      BreakName = 'SOURCE_PTR'
      DataPipeline = ppDB38
      OutlineSettings.CreateNode = True
      ReprintOnSubsequentPage = False
      UserName = 'Group7'
      mmNewColumnThreshold = 0
      mmNewPageThreshold = 0
      DataPipelineName = 'ppDB38'
      object ppGroupHeaderBand7: TppGroupHeaderBand
        mmBottomOffset = 0
        mmHeight = 0
        mmPrintPosition = 0
      end
      object ppGroupFooterBand7: TppGroupFooterBand
        PrintHeight = phDynamic
        mmBottomOffset = 0
        mmHeight = 5027
        mmPrintPosition = 0
        object ppSubReport5: TppSubReport
          UserName = 'SubReport5'
          ExpandAll = False
          KeepTogether = True
          NewPrintJob = False
          OutlineSettings.CreateNode = True
          TraverseAllData = False
          DataPipelineName = 'ppDB25'
          mmHeight = 5027
          mmLeft = 0
          mmTop = 0
          mmWidth = 197300
          BandType = 5
          GroupNo = 4
          mmBottomOffset = 0
          mmOverFlowOffset = 0
          mmStopPosition = 0
          object ppChildReport5: TppChildReport
            AutoStop = False
            DataPipeline = ppDB25
            PrinterSetup.BinName = 'Default'
            PrinterSetup.DocumentName = 'Report'
            PrinterSetup.PaperName = 'A4'
            PrinterSetup.PrinterName = 'Default'
            PrinterSetup.mmMarginBottom = 350
            PrinterSetup.mmMarginLeft = 6350
            PrinterSetup.mmMarginRight = 6350
            PrinterSetup.mmMarginTop = 5350
            PrinterSetup.mmPaperHeight = 297000
            PrinterSetup.mmPaperWidth = 210000
            PrinterSetup.PaperSize = 9
            Units = utMillimeters
            Version = '7.01'
            mmColumnWidth = 0
            DataPipelineName = 'ppDB25'
            object ptlbnd6: TppTitleBand
              mmBottomOffset = 0
              mmHeight = 9260
              mmPrintPosition = 0
              object ppLabel14: TppLabel
                UserName = 'Label14'
                Caption = '<<<v-cut '#26012#36793#22270'>>>'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = #23435#20307
                Font.Size = 14
                Font.Style = []
                Transparent = True
                mmHeight = 5556
                mmLeft = 77523
                mmTop = 3175
                mmWidth = 44715
                BandType = 1
              end
              object pln47: TppLine
                UserName = 'pln47'
                Weight = 0.750000000000000000
                mmHeight = 265
                mmLeft = 529
                mmTop = 2117
                mmWidth = 196057
                BandType = 1
              end
              object pln48: TppLine
                UserName = 'pln48'
                Position = lpBottom
                Weight = 0.750000000000000000
                mmHeight = 1058
                mmLeft = 1058
                mmTop = 7938
                mmWidth = 195263
                BandType = 1
              end
              object pln49: TppLine
                UserName = 'pln49'
                Position = lpLeft
                Weight = 0.750000000000000000
                mmHeight = 6350
                mmLeft = 794
                mmTop = 2381
                mmWidth = 2381
                BandType = 1
              end
              object pln50: TppLine
                UserName = 'pln50'
                Position = lpLeft
                Weight = 0.750000000000000000
                mmHeight = 6879
                mmLeft = 196321
                mmTop = 2381
                mmWidth = 2381
                BandType = 1
              end
              object ppVariable1: TppVariable
                UserName = 'Variable1'
                CalcOrder = 0
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = #23435#20307
                Font.Size = 14
                Font.Style = []
                Transparent = True
                mmHeight = 5556
                mmLeft = 34660
                mmTop = 2646
                mmWidth = 22490
                BandType = 1
              end
              object ppVariable2: TppVariable
                UserName = 'Variable2'
                CalcOrder = 1
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = #23435#20307
                Font.Size = 14
                Font.Style = []
                Transparent = True
                mmHeight = 5556
                mmLeft = 131498
                mmTop = 2117
                mmWidth = 22490
                BandType = 1
              end
              object ppVariable4: TppVariable
                UserName = 'Variable4'
                CalcOrder = 2
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = #23435#20307
                Font.Size = 14
                Font.Style = []
                Transparent = True
                mmHeight = 5556
                mmLeft = 163248
                mmTop = 2646
                mmWidth = 22490
                BandType = 1
              end
            end
            object ppDetailBand6: TppDetailBand
              mmBottomOffset = 0
              mmHeight = 37042
              mmPrintPosition = 0
              object pln51: TppLine
                UserName = 'pln51'
                Position = lpBottom
                Weight = 0.750000000000000000
                mmHeight = 529
                mmLeft = 1058
                mmTop = 36513
                mmWidth = 195527
                BandType = 4
              end
              object pln52: TppLine
                UserName = 'pln52'
                Position = lpLeft
                Weight = 0.750000000000000000
                mmHeight = 36777
                mmLeft = 794
                mmTop = 0
                mmWidth = 2381
                BandType = 4
              end
              object ppImage5: TppImage
                UserName = 'Image5'
                MaintainAspectRatio = False
                Picture.Data = {
                  0A544A504547496D616765090F0000FFD8FFE000104A46494600010101006000
                  600000FFDB004300080606070605080707070909080A0C140D0C0B0B0C191213
                  0F141D1A1F1E1D1A1C1C20242E2720222C231C1C2837292C30313434341F2739
                  3D38323C2E333432FFDB0043010909090C0B0C180D0D1832211C213232323232
                  3232323232323232323232323232323232323232323232323232323232323232
                  32323232323232323232323232FFC0001108008E00BC03012200021101031101
                  FFC4001F0000010501010101010100000000000000000102030405060708090A
                  0BFFC400B5100002010303020403050504040000017D01020300041105122131
                  410613516107227114328191A1082342B1C11552D1F02433627282090A161718
                  191A25262728292A3435363738393A434445464748494A535455565758595A63
                  6465666768696A737475767778797A838485868788898A92939495969798999A
                  A2A3A4A5A6A7A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6
                  D7D8D9DAE1E2E3E4E5E6E7E8E9EAF1F2F3F4F5F6F7F8F9FAFFC4001F01000301
                  01010101010101010000000000000102030405060708090A0BFFC400B5110002
                  0102040403040705040400010277000102031104052131061241510761711322
                  328108144291A1B1C109233352F0156272D10A162434E125F11718191A262728
                  292A35363738393A434445464748494A535455565758595A636465666768696A
                  737475767778797A82838485868788898A92939495969798999AA2A3A4A5A6A7
                  A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6D7D8D9DAE2E3
                  E4E5E6E7E8E9EAF2F3F4F5F6F7F8F9FAFFDA000C03010002110311003F00F7FA
                  28A2800A28A2800A28A2800A28A2800A2B9AD4BC79A0695797F6B3DC5C49269C
                  8B25F1B7B49665B556E85D95481C64E3AE0138E2BA0B6B982F2D61BAB69525B7
                  991648A4439575232083DC1068025A28A2800A28A2800A28A2800A28A2800A28
                  A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2803C834FD0F5ED
                  7356F8816BA3EBF6DA6C736A12432C6D65E63B6E85402240E0A7538C0383935D
                  DFC3FBC8EFFE1F681710DBFD9E2FB1468916FDFB428DA064F5E9587A77C35817
                  5DD6B53D5DD6E25D527672F652CD6AF1A100796591C1743B464138270702BBAB
                  4B4B7B0B486D2D218E0B7850247146B85451D001401351451400514514005145
                  14005145140051451400514514005145140051581AD78BF4ED0AF56D2EEDF539
                  24281F36DA7CD32E0923EF22919E3A5677FC2C9D13FE7CF5CFFC13DCFF00F114
                  01D8515C88F88BA39C62C35EE4161FF126B9E40CE4FDCF63F953C7C40D319770
                  D33C4257206468B758C9C63F83BE47E7401D5D15CABF8F2C510B2E8BE25723F8
                  5743B9C9FCD0544BF10AD09E7C3BE2A1C1E4E893FF00F13401D7D15C6BFC48D3
                  205125E691E22B3B704092E6EB499A38A204E373B118007735C64DF14B58F11F
                  8FAF3C29E1E89A2D3CDCA5B9D5A2B579A4B7014873B47032E000CDC28049C83F
                  2807B2D15E25E2AF11F8D3C05E28D3D666BE7F090B880DD5FDC62E99903ED72C
                  CA80C7B832FC9EAA3079615DCC1F12B4FBAB78AE2DF41F13CD04A81E3923D1E6
                  65752320820608239CD007694571FF00F0B0ED7FE85CF157FE0927FF000A72F8
                  FED995C8F0E78A7083273A34C3B81C6473D7A0FAF6A00EBA8AE5478E612B01FF
                  00847BC4B89890BFF12A938E71F37F77EAD8F5A913C671C93984787FC4418027
                  2DA7385E0EDFBC78EA3A6791CF4E6803A6A2B9FF00F84ABFEA03AE7FE01FFF00
                  5EA7D175F93589191F43D5B4EDA9BF75F448809C91B46D76C9E33E98239CF140
                  1B3581E21D4B56B6BDD374FD1D2CBED37A651E65E6F291844C8385E4F38E323E
                  B5BF581AB01FF096F874EE19CDCF1DCFEEC5004170BE3865FF004797C3B19C75
                  9229DF9C8F461DB3F98F4C1AED17C442A9B6F7C2C081F313697072727A7EF38E
                  31EBFD075D450063E849E244FB47FC2413E952E76F91FD9F0C91E3AEEDDBD9B3
                  FC38C63BD6C5145001451450014514500145145001451450043776B05FD9CF67
                  7512CB6F3C6D14B1B747461820FD41AE47E1FCD369D15FF846F4462EB43748A1
                  748CAFDA2D19479329E305B0A55B19C1435DA5717E34822D1354D3BC70A655FE
                  CD06DEFC431EF32DA48403B80E488DB1271D006E2801FE3378B5DBDB0F05A484
                  B6A07ED1A8AC6E55D2C90E58E41046F7091F7C867F4C8EC15422855002818000
                  E00AF3BF09F8934080DEEB9AE78834BB4D6355712B5ADCDEC4925A403FD4C241
                  3904210CC3FBCCD5D2FF00C277E0FF00FA1AF43FFC18C3FF00C55007414573FF
                  00F09DF83FFE86BD0FFF000630FF00F1547FC277E0FF00FA1AF43FFC18C3FF00
                  C55007414573FF00F09DF83FFE86BD0FFF000630FF00F1547FC277E0FF00FA1A
                  F43FFC18C3FF00C55007414573FF00F09DF83FFE86BD0FFF000630FF00F1547F
                  C277E0FF00FA1AF43FFC18C3FF00C55007415E6DE31F893E1AF0EF8D74CB3D4A
                  EAEA29ECD9DA75581CA05788ED6CE3E6E7038CE093EF8E9DBC7DE0E4EBE2AD13
                  A13C5FC47A7D1BF4AF28F88A3C25E26F88BE16D56DFC4BA408619366A120BB5E
                  238DB7AF43CE7E65C8F51D87001EF0AC19430CE08CF2307F2A5AE5FF00E163F8
                  2FFE868D2BFF000257FC6B7B4ED4ACB57B08EFB4EBA8AEAD25CEC9A160CAD824
                  1C11EE08FC2802D514514005145140051451400514514005145140056278C6E2
                  4B3F046BD750ECF3A0D3AE258CBA0701963665255810790382315B75CCFC43D4
                  AC74AF87DAECFA836DB77B3920C6D2DB9A41B1460104E4B0EE3EA3AD0065E9FA
                  DF83DF4E87CFB6B69EEA38D56E441A6348524D9B88212338F6F5C8C7514EFF00
                  848FC11FF40A9FFF0009DB9FFE335E7FE048F51F09F8A6E351B9BE1369EC6CAC
                  B543803F793C2B2C7313C6556597CA1C0C230F435EF1401C3FFC247E08FF00A0
                  54FF00F84EDCFF00F19A3FE123F047FD02A7FF00C276E7FF008CD771450070FF
                  00F091F823FE8153FF00E13B73FF00C668FF00848FC11FF40A9FFF0009DB9FFE
                  335DC51401C3FF00C247E08FFA054FFF0084EDCFFF0019AB4BE2BF0BAFEED6C3
                  501B484DA3C3F77C1EC31E4FB74F6AEBA8A00E424F1468502B797A06B5260938
                  8FC3D72327AF7887524D5797C6BA2C5298CF8675F3962B19FEC1987987FD9CA6
                  7A0279C700D76F5E23F17FC67A868FF10FC2B6FA6477127F67B9BB99218F779A
                  5BE5641EA447BB3E82407E801DB1F18E8E42B1F08F888904E07F604D91C75FBB
                  EE7F5AE9341D560D5EC1A6B7D3EFAC63490C7E55EDA35BBF40721580E39EBEA0
                  FA56946EB2C6B221CAB00C0FA834EA0028A28A0028A28A0028AAF7D636DA9D8C
                  D65790ACD6D3A149636E8CA7A835CBFF00C2ABF037FD0B363FF7C9FF001A00EC
                  28AE3FFE155F81BFE859B1FF00BE4FF8D1FF000AAFC0DFF42CD8FF00DF27FC68
                  03B0A2B8FF00F8557E06FF00A166C7FEF93FE347FC2ABF037FD0B363FF007C9F
                  F1A00EC2BCC7C7D6D77E2BB8D5ECA19B6E93A2E977324E11C9F3AF24858468CA
                  A0B6114EFE3A9751835D2A7C36F0524F1CC3C2FA5EE8D42806DD4A918C72A782
                  7DC8CF7AB977A3E9BA2F85B56B7D2F4FB5B181E096468ADA258D4B7978CE1401
                  9C01F9500723E0FD32DB57BAF17E97A85B3BDADDC160AEAC840746B38D72ADEA
                  0A9E87208EDC5749E11D60B68C74DD56E235D574A7FB15DEF6DA5D900DB28071
                  C3A147FF008163B5627801A3FF0084B3C44811BCD161A5334877F2A606014027
                  1C10C72B81F363A824F5BA8F86340D5EE45CEA7A1E997B70142096E6D2391B68
                  E832C09C726802E2EA166C322EA1EA472E052FDBECFF00E7EE0FFBF82B1FFE10
                  4F07FF00D0A9A1FF00E0BA1FFE268FF8413C1FFF0042A687FF0082E87FF89A00
                  D8FB7D9FFCFDC1FF007F051F6FB3FF009FB83FEFE0AC7FF8413C1FFF0042A687
                  FF0082E87FF89A3FE104F07FFD0A9A1FFE0BA1FF00E2680363EDF67FF3F707FD
                  FC147DBAD3B5CC4C7B057049FA01D6B1FF00E104F07FFD0A9A1FFE0BA1FF00E2
                  6A483C17E15B5B88AE2DFC35A3433C4E1E3923B08959181C82085C820F39A00D
                  CAE5FC49FF002367837FEC213FFE91CF5D4572FE24FF0091B3C1BFF6109FFF00
                  48E7A00D3D7350D4EC23B35D2B4B8F50B8B8B910B2CB73E4244BB198BB36D638
                  1B40C019E6B87D2BE26EBBACDE7892D2CBC2D64F73E1F768EE233ABB033105C1
                  F2BF71CF319EBB7A8AF4DAF1BF842DFF00172FE25AE3AEA64E777FD369FB77FA
                  F6FC6803D76CAE1AEEC2DEE5A33134B12C86327254919C7E153D145001451450
                  014514500145145001595AE5E6B3670C4DA368F0EA523311224B79F670831D41
                  DAD9FA56AD1401E4DF10FC63E3BD17C1B757CBA1DAE8ED1BC78BC8B515B965CB
                  818F2CC401CF4AADE1CF1BFC41F1068D78BAD783921B192DA50D7D96B6D8BE5E
                  77796E497CE7AAE073EC6BD859430C3004641E477155356824B9D1AFADE15DD2
                  CB6F2222E7192548039A00F28B3F195B783B5DD7EFAF34DD4EE635D2B4BE6D2D
                  FCC5004726599B3B507CD8F988270700E2ADF82FE33BF8BB55BE853C377C2DE0
                  0A53ECABE7B00777CD21F942F400019393DC024751E14D1351D37C47AADDDDDB
                  F9704FA7E9F0C6DBD4EE789240E300E460B0FAE78CD74B6FA5E9F677971796D6
                  16B05D5C90679A28555E523A6E6032DF8D00601F1A4C02FF00C523E2539049FF
                  00458F8C2838FF0059DC9DBF507B609E9A097CFB78A6F2E48FCC40DB241865C8
                  CE08EC6A4A2800A2AA6A1737167A7DCDC416A2E668D774700902994FF7412301
                  89E0678CE3919E386F0D7C59B0F12697AD5E25A2D8C9A4A6F9ADEF6E3CB6C73C
                  E76E07423D738040C83401E894567E8B7F71AA6950DEDCD97D8DE61B84065123
                  28F4620601EBC0CE3D6B42800A8A5B68269A1965823925818BC4EC8098D882A4
                  A9EC7048E3B122A5A2801B24692C6D1C88AE8E0AB2B0C820F504564D8F84FC37
                  A65E477961E1FD2AD2EA3CEC9A0B28E375C820E180C8C8247E35B14500145145
                  001451450014514500145145001451450014514500145145001451450035CB2A
                  128BB9BB0CE2BE74F1D69C34DF10A7C4EF0DE9AB2E8A978A6EB74A556E9C38FD
                  F2A81C217030F93970180C609FA0B52D32CF58B096C6FE113DACA312444901C7
                  A1C1E47B5668F0678746807421A4DB8D299FCC36A01D85B39CF5F5A00B5E1ED5
                  EC35EF0FD8EABA5E3EC775109235C00573D5480480C0E4100F506B4EB2F45F0E
                  68FE1D8E68F47D3A0B249DF7C8B0AE031F5C56A5001451450014514500145145
                  0014514500145145001451450014514500145145001451450014514500145145
                  0014514500145145001451450014514500145145007FFFD9}
                mmHeight = 34396
                mmLeft = 4233
                mmTop = 1852
                mmWidth = 38629
                BandType = 4
              end
              object pln53: TppLine
                UserName = 'Line801'
                Position = lpLeft
                Weight = 0.750000000000000000
                mmHeight = 36777
                mmLeft = 100013
                mmTop = 0
                mmWidth = 2381
                BandType = 4
              end
              object pln54: TppLine
                UserName = 'pln54'
                Position = lpLeft
                Weight = 0.750000000000000000
                mmHeight = 36777
                mmLeft = 196321
                mmTop = 0
                mmWidth = 1058
                BandType = 4
              end
              object ppLabel61: TppLabel
                UserName = 'Label61'
                Caption = 'vcut_B:'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = #23435#20307
                Font.Size = 12
                Font.Style = []
                Transparent = True
                mmHeight = 4826
                mmLeft = 45508
                mmTop = 6350
                mmWidth = 14817
                BandType = 4
              end
              object ppLabel62: TppLabel
                UserName = 'Label62'
                Caption = 'vcut_T:'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = #23435#20307
                Font.Size = 11
                Font.Style = []
                Transparent = True
                mmHeight = 4498
                mmLeft = 45508
                mmTop = 16669
                mmWidth = 14552
                BandType = 4
              end
              object ppLabel63: TppLabel
                UserName = 'Label63'
                Caption = 'vcut_X:'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = #23435#20307
                Font.Size = 11
                Font.Style = []
                Transparent = True
                mmHeight = 4498
                mmLeft = 45508
                mmTop = 26988
                mmWidth = 15346
                BandType = 4
              end
              object ppDBText15: TppDBText
                UserName = 'DBText15'
                DataField = 'vcut_B'
                DataPipeline = ppDB25
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = #23435#20307
                Font.Size = 12
                Font.Style = []
                Transparent = True
                DataPipelineName = 'ppDB25'
                mmHeight = 4763
                mmLeft = 60325
                mmTop = 6350
                mmWidth = 39158
                BandType = 4
              end
              object ppDBText46: TppDBText
                UserName = 'DBText46'
                DataField = 'vcut_T'
                DataPipeline = ppDB25
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = #23435#20307
                Font.Size = 12
                Font.Style = []
                Transparent = True
                DataPipelineName = 'ppDB25'
                mmHeight = 4763
                mmLeft = 60325
                mmTop = 16404
                mmWidth = 39158
                BandType = 4
              end
              object ppDBText47: TppDBText
                UserName = 'DBText47'
                DataField = 'vcut_X'
                DataPipeline = ppDB25
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = #23435#20307
                Font.Size = 12
                Font.Style = []
                Transparent = True
                DataPipelineName = 'ppDB25'
                mmHeight = 4763
                mmLeft = 60325
                mmTop = 26723
                mmWidth = 38894
                BandType = 4
              end
              object ppImage7: TppImage
                UserName = 'Image7'
                MaintainAspectRatio = False
                Picture.Data = {
                  0A544A504547496D616765F50E0000FFD8FFE000104A46494600010101006000
                  600000FFDB004300080606070605080707070909080A0C140D0C0B0B0C191213
                  0F141D1A1F1E1D1A1C1C20242E2720222C231C1C2837292C30313434341F2739
                  3D38323C2E333432FFDB0043010909090C0B0C180D0D1832211C213232323232
                  3232323232323232323232323232323232323232323232323232323232323232
                  32323232323232323232323232FFC0001108008600BA03012200021101031101
                  FFC4001F0000010501010101010100000000000000000102030405060708090A
                  0BFFC400B5100002010303020403050504040000017D01020300041105122131
                  410613516107227114328191A1082342B1C11552D1F02433627282090A161718
                  191A25262728292A3435363738393A434445464748494A535455565758595A63
                  6465666768696A737475767778797A838485868788898A92939495969798999A
                  A2A3A4A5A6A7A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6
                  D7D8D9DAE1E2E3E4E5E6E7E8E9EAF1F2F3F4F5F6F7F8F9FAFFC4001F01000301
                  01010101010101010000000000000102030405060708090A0BFFC400B5110002
                  0102040403040705040400010277000102031104052131061241510761711322
                  328108144291A1B1C109233352F0156272D10A162434E125F11718191A262728
                  292A35363738393A434445464748494A535455565758595A636465666768696A
                  737475767778797A82838485868788898A92939495969798999AA2A3A4A5A6A7
                  A8A9AAB2B3B4B5B6B7B8B9BAC2C3C4C5C6C7C8C9CAD2D3D4D5D6D7D8D9DAE2E3
                  E4E5E6E7E8E9EAF2F3F4F5F6F7F8F9FAFFDA000C03010002110311003F00F7FA
                  28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A28A2800A
                  28A2800A28AE3FC45F12B41F0C6AEFA65F25F3DC2246EDF67B632AAEF385048E
                  8491800D007614573FE15F19693E31B7BA9B4A33E2D65F26559E3F2D95F19C60
                  F35D050014514500145145001451450014514500145145001451450014515535
                  2D46DF4AB2375725F66F4894229666777088A07A96651E9CF240E6802DD1597A
                  3EB90EB0D7708B79ED2F2CE411DCDADC6C2F11650EB928CCA72AC0F0C7AE0E08
                  22B52800A28A2800A28A2800AE33E23C31AF87EDE558D048FAAD80770A32C05C
                  26327BE326BB3AE4FE21699ACEADE1FB7B7D12D60B8B94BFB79D9669BCB01237
                  F33AE3B9551F89F4A00E9E1B682DDA468608E3695B7C851002EDEA71D4D4B515
                  B34CF6B0BDC462399914C880E42B63919EF8352D00145145001454371776D689
                  BEE6E22857FBD23851FAD55FEDDD1FFE82B63FF8109FE3401A14567FF6EE8FFF
                  00415B1FFC084FF1A3FB7747FF00A0AD8FFE0427F8D00685159FFDBBA3FF00D0
                  56C7FF000213FC68FEDDD1FF00E82B63FF008109FE3401A14567FF006EE8FF00
                  F415B1FF00C084FF001A3FB7747FFA0AD8FF00E0427F8D00685159FF00DBBA3F
                  FD056C7FF0213FC68FEDDD1FFE82B63FF8109FE3401A158DE2AB8D46D3C39733
                  694B335D2B47CC11096458CC8A246443C33842E40C1C90383D0D9FEDDD1FFE82
                  B63FF8109FE347F6EE8FFF00415B1FFC084FF1A00E43C19A6DCD9FC47F1ADE1B
                  0BB86C2F56C1AD669D580976C4CADCB724E739CF23BE322BBFACFF00EDDD1FFE
                  82B63FF8109FE354B56F19787B45D365BFBBD56D7C88865BCB903B7E001C9A00
                  DDA2990CB1CF0A4D13078E450CAC3A1079069F40051451400532696382179A56
                  091C6A5998F400724D3EB9FF001DFF00C93CF12FFD82AEBFF4535006B69BA8DA
                  EADA7417F6532CD6D3A078DD4E41156AB8FF00857FF24BFC3DFF005E83F99AEC
                  2800A28A28030FC4FE11D17C61631D9EB569F688A37DE9862ACA7D88E45727FF
                  000A2BC03FF40B9FFF0002E5FF00E2ABD228A00F37FF008515E01FFA05CFFF00
                  8172FF00F1547FC28AF00FFD02E7FF00C0B97FF8AAF48A2803CDFF00E1457807
                  FE8173FF00E05CBFFC551FF0A2BC03FF0040B9FF00F02E5FFE2ABD228A00F37F
                  F8515E01FF00A05CFF00F8172FFF001547FC28AF00FF00D02E7FFC0B97FF008A
                  AF48A2803CDFFE1457807FE8173FFE05CBFF00C5571DE2DF83FE1EF0D6A506B7
                  1E9B2DCF86E28C8D42DD6E1FCC84647EF579CB606EC8C8F604F5F79A64D1473C
                  2F0CAA1E3914AB29E841E08A00F32B1F82FF000E752B0B7BEB4D3E596DEE2359
                  2375BC908652323F8AB3F57FD9FF00C3B71A9E9B2696BF65B28CC9F6D8A49647
                  6981036ED39E30727DF35ACB78FF000CB5E7B5BA2CBE0EB942F6F31E4594E4FF
                  00AA24F44207CB93C1E3B815178D3E3168BA169D6175A4DFD9EA26E4B078EDA6
                  8E5922F97E5DCA1B8E4F7EE3140193E19F829E0F923BDB3D4ACE7B9B9B39CC6D
                  3FDA9D7783C8E170062BA4B2F82BE05B0BFB7BC834B93CEB795654DF73232EE5
                  391904E08C8E86ADF873C4DE0DD27478623E2AD0CDC483CC9DCEA116E673C9CF
                  CDDB38FC2B5BFE13BF07FF00D0D7A1FF00E0C61FFE2A8037D542285500281800
                  0E00A5AE7FFE13BF07FF00D0D7A1FF00E0C61FFE2A8FF84EFC1FFF00435E87FF
                  0083187FF8AA00E828AE7FFE13BF07FF00D0D7A1FF00E0C61FFE2A8FF84EFC1F
                  FF00435E87FF0083187FF8AA00E82B82F8ADE2AB2F0FF83F53B3BEB7BB0BA8D8
                  CF6D05CA461A2133C6C1518E7209E4F4C601E6B77FE13BF07FFD0D7A1FFE0C61
                  FF00E2AB88F8B3AA7843C55F0FEFADA3F1268F35D5A8FB5DB4716A111669115B
                  0000DC920B0C60E73C7382002D7C17F16E99AC784ED342B3F39AEB4AB48FED2E
                  C984CB16F941CE4918E78C7A135E9B5E2BF0626F0B7857C2C2E6FBC4DA125F5F
                  2AC8CAF751452C4BD7CB71BB248249C9E79C718AF4AFF84EFC1FFF00435E87FF
                  0083187FF8AA00E828A8ADAE60BCB68EE6D678E7B79543C72C4E195D4F4208E0
                  8A96800A28A2800A28A2800A28A2800A28A2800A28A28039BF88304571F0EFC4
                  6B2C6AE174CB875C8E8C22620FE75E73E0FF0082DE0ED6FC1BA3EA97905D9B9B
                  AB48E594A5C100B1504E076AF4AF1DFF00C93CF12FFD82AEBFF453557F871FF2
                  4DBC39FF0060F87FF411401CBFFC281F037FCFBDF7FE051FF0A3FE140F81BFE7
                  DEFBFF00028FF857A851401E5FFF000A07C0DFF3EF7DFF008147FC28FF008503
                  E06FF9F7BEFF00C0A3FE15EA14500797FF00C281F037FCFBDF7FE051FF000A3F
                  E140F81BFE7DEFBFF028FF00857A851401E5FF00F0A07C0DFF003EF7DFF8147F
                  C28FF8503E06FF009F7BEFFC0A3FE15EA14500797FFC281F037FCFBDF7FE051F
                  F0A3FE140F81BFE7DEFBFF00028FF857A8514014746D26D742D1ED34BB2565B5
                  B58C4718639381EA7BD5EA28A0028A28A0028A28A0028A28A0028A28A0028A29
                  19822966202819249E00A00E43E28EB16DA37C37D724BA2D8B9B492D23C0CFCF
                  2232AFEA6BCCFC33F10BC77A6F85B49B2B1F05433DA43691243319F06450A30D
                  D7BF5FC6B5BC5F1C9E369FC59A8FDA66B8F0CE8DA45CC56C88CC90CB7C8AC59C
                  8246F29D9B057A60F073DFFC3962DF0DBC3658927FB3A11C9EC1050079FF00FC
                  2CFF0088BFF42241FF00811FFD7A3FE167FC45FF00A1120FFC08FF00EBD7B3D1
                  401E31FF000B3FE22FFD08907FE047FF005E8FF859FF00117FE84483FF00023F
                  FAF5ECF450078C7FC2CFF88BFF0042241FF811FF00D7A3FE167FC45FFA1120FF
                  00C08FFEBD7B3D1401E31FF0B3FE22FF00D08907FE047FF5E8FF00859FF117FE
                  84483FF023FF00AF5ECF585E35D424D2BC0DAF5F433982782C2668651D564D87
                  611EFBB1401E6BFF000B3FE22FFD08907FE047FF005E8FF859FF00117FE84483
                  FF00023FFAF5E97E0DD58EB9E0CD1F5360C1AE2D2366DCC58EEC60E49EBC83CD
                  6E500733E06D735CF106872DE6BDA3AE97722E1A38E156DC1E30AA4367EA587E
                  15D3514500723E3493C751C967FF0008743A5C8843FDA7EDA4E41E36E391EF5C
                  B7DA3E377FCF9786FF0033FF00C557ABD1401E51F68F8DDFF3E5E1BFCCFF00F1
                  547DA3E377FCF9786FF33FFC557ABD1401E51F68F8DDFF003E5E1BFCCFFF0015
                  47DA3E377FCF9786FF0033FF00C557ABD1401E51F68F8DDFF3E5E1BFCCFF00F1
                  547DA3E377FCF9786FF33FFC557ABD70D7BF187C07A7DFDC595D6BC12E2DE568
                  A551693B0565382321083C8EA0E280307ED1F1BBFE7CBC37F99FFE2AB9AF1578
                  A3E29595C69BE1CD65747B5FF8485DAC6296D54B32EE2A8C41DDC11E60C1AEAB
                  55F8FBE0AB06B73673DCEA68E584A2DA07478F8E0E240A1B278EBC5617C45D66
                  C3C43E2BF851AAE99389ECEE7532D1C80119C4D6E08C1E4104107E9401DD6AFA
                  15AF86BE0D6AFA3DA222C76BA25C212AA06F6F25B739C7727249F7ABBF0E3FE4
                  9B7873FEC1F0FF00E822AC78EFFE49E7897FEC1575FF00A29AB99D13C61A4782
                  FE0EF87752D5E66543610AC7146019256DA385048CFE600A00F46A2BCD74EF8E
                  DE04BCB149EEB5296C6562D9B79AD6567501881928ACBC800F04E338ADAD13E2
                  97837C47AC41A4E93ACFDA2FA7DDE5C5F6599376D52C7964007009E4D0074171
                  AE69769AA5BE993DFC11DF5C7FA9B767F9E4FA0EFEB5A15C7EB9FF002543C21F
                  F5E9A8FF00282BB0A0028A28A002BCFF00E33C3A94FF000D7504D3635623E7B8
                  639F921556672060E7818ED8CE72315E815CFF008EFF00E49E7897FEC1575FFA
                  29A803CFBE004FAEAF87AE6CB53B797EC2A239AC677903028C0FCA00E98C03CF
                  AE3B57B0D71FF0AFFE497F87BFEBD07F335D8500145145001451450014514500
                  1451450015464D174A9646924D32CDDDC96666814924F524E2AF51401CCEBBF0
                  FF00C2FE238A08752D262686172E2384984138C6494209C73DEB82F8A7651DBF
                  8EFE16DA595B2450C3A91090C1185544592DCF0A380001F8015EC74C78A39195
                  9E346643952CA0953ED40185E3BFF9279E25FF00B055D7FE8A6AC9F07E8FA7EB
                  FF0008742D3355B58EEACE7D3A11244F9E7E518208E411D88E4576ACA1D4AB00
                  548C10470450AA1142A80140C00070050061E93E0DF0EE89A645A7D96916A2DA
                  22DB04A82461B98B1F99B24F24F535A30693A6DB4CB35BE9F6914ABF75E38555
                  876E0815728A00F3DF18EA773A6F8FFC397D1687ABDF5BDA5BDDA4B259D9BCAA
                  0C822DBCA83FDC3DBFAE3A0F0B7886FBC4126A525CE8F77A75AC32A25B1BA85E
                  279414058ED700F0C48E9DABA2A2800A28A2800AC9F14E9F3EADE11D6B4DB50A
                  6E2EEC278220C700BBC6CA327B726B5A8A00E7BC0BA3DDE81E08D234ABE082EA
                  D6011C811B70CE4F435D0D145001451450014514500145145001451450014514
                  5001451450014514500145145001451450014514500145145001451450014514
                  5007FFD9}
                mmHeight = 35190
                mmLeft = 101600
                mmTop = 0
                mmWidth = 41275
                BandType = 4
              end
              object ppLabel64: TppLabel
                UserName = 'Label64'
                Caption = 'A:'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = #23435#20307
                Font.Size = 12
                Font.Style = []
                Transparent = True
                mmHeight = 4826
                mmLeft = 147638
                mmTop = 6879
                mmWidth = 4233
                BandType = 4
              end
              object ppLabel65: TppLabel
                UserName = 'Label65'
                Caption = 'T:'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = #23435#20307
                Font.Size = 11
                Font.Style = []
                Transparent = True
                mmHeight = 4445
                mmLeft = 147638
                mmTop = 17198
                mmWidth = 3895
                BandType = 4
              end
              object ppLabel66: TppLabel
                UserName = 'Label66'
                Caption = 'L:'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = #23435#20307
                Font.Size = 11
                Font.Style = []
                Transparent = True
                mmHeight = 4445
                mmLeft = 147638
                mmTop = 27517
                mmWidth = 3895
                BandType = 4
              end
              object ppDBText48: TppDBText
                UserName = 'DBText48'
                DataField = 'gf_A'
                DataPipeline = ppDB25
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = #23435#20307
                Font.Size = 12
                Font.Style = []
                Transparent = True
                DataPipelineName = 'ppDB25'
                mmHeight = 4763
                mmLeft = 155046
                mmTop = 7144
                mmWidth = 38365
                BandType = 4
              end
              object ppDBText49: TppDBText
                UserName = 'DBText49'
                DataField = 'gf_T'
                DataPipeline = ppDB25
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = #23435#20307
                Font.Size = 12
                Font.Style = []
                Transparent = True
                DataPipelineName = 'ppDB25'
                mmHeight = 4763
                mmLeft = 154782
                mmTop = 16933
                mmWidth = 38100
                BandType = 4
              end
              object ppDBText50: TppDBText
                UserName = 'DBText50'
                DataField = 'gf_L'
                DataPipeline = ppDB25
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = #23435#20307
                Font.Size = 12
                Font.Style = []
                Transparent = True
                DataPipelineName = 'ppDB25'
                mmHeight = 4763
                mmLeft = 154782
                mmTop = 27252
                mmWidth = 37835
                BandType = 4
              end
            end
            object ppSummaryBand6: TppSummaryBand
              mmBottomOffset = 0
              mmHeight = 0
              mmPrintPosition = 0
            end
            object raCodeModule5: TraCodeModule
              ProgramStream = {
                01060F5472614576656E7448616E646C65720B50726F6772616D4E616D65060F
                5661726961626C65314F6E43616C630B50726F6772616D54797065070B747450
                726F63656475726506536F757263650C4401000070726F636564757265205661
                726961626C65314F6E43616C63287661722056616C75653A2056617269616E74
                293B0D0A626567696E0D0A696620444232355B27766375745F42275D3D272720
                7468656E0D0A626567696E0D0A206C6162656C36312E76697369626C653A3D66
                616C73653B0D0A206C6162656C36322E76697369626C653A3D66616C73653B0D
                0A206C6162656C36332E76697369626C653A3D66616C73653B0D0A20696D6167
                65352E76697369626C653A3D66616C73653B0D0A656E640D0A656C73650D0A62
                6567696E0D0A6C6162656C36312E76697369626C653A3D747275653B0D0A206C
                6162656C36322E76697369626C653A3D747275653B0D0A206C6162656C36332E
                76697369626C653A3D747275653B0D0A20696D616765352E76697369626C653A
                3D747275653B0D0A656E643B0D0A0D0A0D0A656E643B0D0A0D436F6D706F6E65
                6E744E616D6506095661726961626C6531094576656E744E616D6506064F6E43
                616C63074576656E74494402210001060F5472614576656E7448616E646C6572
                0B50726F6772616D4E616D65060F5661726961626C65324F6E43616C630B5072
                6F6772616D54797065070B747450726F63656475726506536F757263650C4201
                000070726F636564757265205661726961626C65324F6E43616C632876617220
                56616C75653A2056617269616E74293B0D0A626567696E0D0A69662044423235
                5B2767665F41275D3D2727207468656E0D0A626567696E0D0A206C6162656C36
                342E76697369626C653A3D66616C73653B0D0A206C6162656C36352E76697369
                626C653A3D66616C73653B0D0A206C6162656C36362E76697369626C653A3D66
                616C73653B0D0A20696D616765372E76697369626C653A3D66616C73653B0D0A
                656E640D0A656C73650D0A626567696E0D0A6C6162656C36342E76697369626C
                653A3D747275653B0D0A206C6162656C36352E76697369626C653A3D74727565
                3B0D0A206C6162656C36362E76697369626C653A3D747275653B0D0A20696D61
                6765372E76697369626C653A3D747275653B0D0A656E643B0D0A0D0A0D0A656E
                643B0D0A0D436F6D706F6E656E744E616D6506095661726961626C6532094576
                656E744E616D6506064F6E43616C63074576656E74494402210001060F547261
                4576656E7448616E646C65720B50726F6772616D4E616D65060F566172696162
                6C65344F6E43616C630B50726F6772616D54797065070B747450726F63656475
                726506536F757263650C5502000070726F636564757265205661726961626C65
                344F6E43616C63287661722056616C75653A2056617269616E74293B0D0A6265
                67696E0D0A0D0A2069662028444232355B27766375745F42275D3D2727292061
                6E642028444232355B2767665F41275D3D27272029207468656E0D0A62656769
                6E0D0A206C6162656C31342E76697369626C653A3D66616C73653B0D0A0D0A20
                706C6E34372E76697369626C653A3D66616C73653B0D0A20706C6E34382E7669
                7369626C653A3D66616C73653B0D0A20706C6E34392E76697369626C653A3D66
                616C73653B0D0A20706C6E35302E76697369626C653A3D66616C73653B0D0A20
                706C6E35312E76697369626C653A3D66616C73653B0D0A20706C6E35322E7669
                7369626C653A3D66616C73653B0D0A206C696E653830312E76697369626C653A
                3D66616C73653B0D0A20706C6E35342E76697369626C653A3D66616C73653B0D
                0A200D0A200D0A656E640D0A656C73650D0A626567696E0D0A6C6162656C3134
                2E76697369626C653A3D747275653B0D0A0D0A20706C6E34372E76697369626C
                653A3D747275653B0D0A20706C6E34382E76697369626C653A3D747275653B0D
                0A20706C6E34392E76697369626C653A3D747275653B0D0A20706C6E35302E76
                697369626C653A3D747275653B0D0A20706C6E35312E76697369626C653A3D74
                7275653B0D0A20706C6E35322E76697369626C653A3D747275653B0D0A206C69
                6E653830312E76697369626C653A3D747275653B0D0A20706C6E35342E766973
                69626C653A3D747275653B0D0A200D0A200D0A656E643B0D0A0D0A0D0A656E64
                3B0D0A0D436F6D706F6E656E744E616D6506095661726961626C653409457665
                6E744E616D6506064F6E43616C63074576656E74494402210000}
            end
          end
        end
      end
    end
    object ppGroup10: TppGroup
      BreakName = 'SOURCE_PTR'
      DataPipeline = ppDB38
      OutlineSettings.CreateNode = True
      ReprintOnSubsequentPage = False
      UserName = 'Group10'
      mmNewColumnThreshold = 0
      mmNewPageThreshold = 0
      DataPipelineName = 'ppDB38'
      object ppGroupHeaderBand10: TppGroupHeaderBand
        mmBottomOffset = 0
        mmHeight = 0
        mmPrintPosition = 0
      end
      object ppGroupFooterBand10: TppGroupFooterBand
        PrintHeight = phDynamic
        mmBottomOffset = 0
        mmHeight = 10583
        mmPrintPosition = 0
        object ppSubReport1: TppSubReport
          UserName = 'SubReport1'
          ExpandAll = False
          NewPrintJob = False
          OutlineSettings.CreateNode = True
          TraverseAllData = False
          DataPipelineName = 'ppDB502'
          mmHeight = 5027
          mmLeft = 0
          mmTop = 5556
          mmWidth = 197300
          BandType = 5
          GroupNo = 5
          mmBottomOffset = 0
          mmOverFlowOffset = 0
          mmStopPosition = 0
          object ppChildReport1: TppChildReport
            AutoStop = False
            DataPipeline = ppDB502
            PrinterSetup.BinName = 'Default'
            PrinterSetup.DocumentName = 'Report'
            PrinterSetup.PaperName = 'A4'
            PrinterSetup.PrinterName = 'Default'
            PrinterSetup.mmMarginBottom = 350
            PrinterSetup.mmMarginLeft = 6350
            PrinterSetup.mmMarginRight = 6350
            PrinterSetup.mmMarginTop = 5350
            PrinterSetup.mmPaperHeight = 297000
            PrinterSetup.mmPaperWidth = 210000
            PrinterSetup.PaperSize = 9
            Units = utMillimeters
            Version = '7.01'
            mmColumnWidth = 0
            DataPipelineName = 'ppDB502'
            object ptlbnd7: TppTitleBand
              mmBottomOffset = 0
              mmHeight = 0
              mmPrintPosition = 0
            end
            object phdrbnd6: TppHeaderBand
              Visible = False
              PrintHeight = phDynamic
              mmBottomOffset = 0
              mmHeight = 0
              mmPrintPosition = 0
            end
            object ppDetailBand2: TppDetailBand
              PrintHeight = phDynamic
              mmBottomOffset = 0
              mmHeight = 157163
              mmPrintPosition = 0
              object ppImage1: TppImage
                UserName = 'Image1'
                MaintainAspectRatio = False
                Stretch = True
                mmHeight = 71702
                mmLeft = 1323
                mmTop = 5556
                mmWidth = 95250
                BandType = 4
              end
              object ppImage2: TppImage
                UserName = 'Image2'
                MaintainAspectRatio = False
                Stretch = True
                mmHeight = 71702
                mmLeft = 99219
                mmTop = 5556
                mmWidth = 95250
                BandType = 4
              end
              object ppLabel40: TppLabel
                UserName = 'Label40'
                Caption = 'A'#26495#25340#29256#22270':'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = #23435#20307
                Font.Size = 10
                Font.Style = []
                Transparent = True
                mmHeight = 3969
                mmLeft = 1852
                mmTop = 265
                mmWidth = 17727
                BandType = 4
              end
              object ppLabel41: TppLabel
                UserName = 'Label401'
                Caption = 'B'#26495#25340#29256#22270':'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = #23435#20307
                Font.Size = 10
                Font.Style = []
                Transparent = True
                mmHeight = 3969
                mmLeft = 102129
                mmTop = 265
                mmWidth = 17727
                BandType = 4
              end
              object ppLabel39: TppLabel
                UserName = 'Label39'
                Caption = #22823#26009#25340#29256#22270':'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = #23435#20307
                Font.Size = 10
                Font.Style = []
                Transparent = True
                mmHeight = 3969
                mmLeft = 1852
                mmTop = 79375
                mmWidth = 19315
                BandType = 4
              end
              object ppLabel26: TppLabel
                UserName = 'Label26'
                Caption = #24037#31243#22791#27880':'
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = #23435#20307
                Font.Size = 10
                Font.Style = []
                Transparent = True
                mmHeight = 3969
                mmLeft = 100542
                mmTop = 79111
                mmWidth = 15875
                BandType = 4
              end
              object pdbm5: TppDBMemo
                UserName = 'pdbm5'
                CharWrap = False
                DataField = #24037#31243#22791#27880
                DataPipeline = ppDB25
                Font.Charset = DEFAULT_CHARSET
                Font.Color = clBlack
                Font.Name = #23435#20307
                Font.Size = 10
                Font.Style = []
                ParentDataPipeline = False
                Stretch = True
                Transparent = True
                DataPipelineName = 'ppDB25'
                mmHeight = 5027
                mmLeft = 100013
                mmTop = 85725
                mmWidth = 95779
                BandType = 4
                mmBottomOffset = 0
                mmOverFlowOffset = 0
                mmStopPosition = 0
                mmLeading = 0
              end
              object ppImage3: TppImage
                UserName = 'Image3'
                MaintainAspectRatio = False
                Stretch = True
                mmHeight = 71702
                mmLeft = 1588
                mmTop = 83873
                mmWidth = 95250
                BandType = 4
              end
            end
            object ppSummaryBand2: TppSummaryBand
              mmBottomOffset = 0
              mmHeight = 0
              mmPrintPosition = 0
            end
            object ppGroup6: TppGroup
              BreakName = 'ppLabel25'
              BreakType = btCustomField
              OutlineSettings.CreateNode = True
              NewPage = True
              UserName = 'Group6'
              mmNewColumnThreshold = 0
              mmNewPageThreshold = 0
              DataPipelineName = ''
              object ppGroupHeaderBand6: TppGroupHeaderBand
                mmBottomOffset = 0
                mmHeight = 7673
                mmPrintPosition = 0
                object pln55: TppLine
                  UserName = 'pln55'
                  ParentWidth = True
                  Weight = 0.750000000000000000
                  mmHeight = 2646
                  mmLeft = 0
                  mmTop = 1323
                  mmWidth = 197300
                  BandType = 3
                  GroupNo = 0
                end
                object ppLabel25: TppLabel
                  UserName = 'Label25'
                  Caption = #24320#26009#22270
                  Font.Charset = DEFAULT_CHARSET
                  Font.Color = clBlack
                  Font.Name = #23435#20307
                  Font.Size = 14
                  Font.Style = [fsBold]
                  TextAlignment = taCentered
                  Transparent = True
                  mmHeight = 5556
                  mmLeft = 80433
                  mmTop = 2117
                  mmWidth = 15081
                  BandType = 3
                  GroupNo = 0
                end
              end
              object ppGroupFooterBand6: TppGroupFooterBand
                mmBottomOffset = 0
                mmHeight = 0
                mmPrintPosition = 0
              end
            end
            object raCodeModule1: TraCodeModule
              ProgramStream = {00}
            end
          end
        end
        object pdbm6: TppDBMemo
          UserName = 'pdbm6'
          CharWrap = False
          DataField = #21152#24037#25351#31034
          DataPipeline = ppDB25
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = #23435#20307
          Font.Size = 8
          Font.Style = []
          ParentDataPipeline = False
          Stretch = True
          Transparent = True
          DataPipelineName = 'ppDB25'
          mmHeight = 3704
          mmLeft = 15346
          mmTop = 1323
          mmWidth = 182034
          BandType = 5
          GroupNo = 5
          mmBottomOffset = 0
          mmOverFlowOffset = 0
          mmStopPosition = 0
          mmLeading = 0
        end
        object ppLabel10: TppLabel
          UserName = 'Label10'
          Caption = #21152#24037#25351#31034':'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clBlack
          Font.Name = #23435#20307
          Font.Size = 10
          Font.Style = []
          TextAlignment = taRightJustified
          Transparent = True
          mmHeight = 3969
          mmLeft = 0
          mmTop = 1323
          mmWidth = 15875
          BandType = 5
          GroupNo = 5
        end
        object pln56: TppLine
          UserName = 'pln56'
          Weight = 0.750000000000000000
          mmHeight = 529
          mmLeft = 0
          mmTop = 0
          mmWidth = 197115
          BandType = 5
          GroupNo = 5
        end
      end
    end
    object ppGroup11: TppGroup
      BreakName = 'SOURCE_PTR'
      DataPipeline = ppDB38
      KeepTogether = True
      OutlineSettings.CreateNode = True
      UserName = 'Group11'
      mmNewColumnThreshold = 0
      mmNewPageThreshold = 0
      DataPipelineName = 'ppDB38'
      object ppGroupHeaderBand11: TppGroupHeaderBand
        mmBottomOffset = 0
        mmHeight = 0
        mmPrintPosition = 0
      end
      object ppGroupFooterBand11: TppGroupFooterBand
        mmBottomOffset = 0
        mmHeight = 0
        mmPrintPosition = 0
      end
    end
    object raCodeModule4: TraCodeModule
      ProgramStream = {
        01060F5472614576656E7448616E646C65720B50726F6772616D4E616D65060F
        5661726961626C65334F6E43616C630B50726F6772616D54797065070B747450
        726F63656475726506536F75726365147F01000070726F636564757265205661
        726961626C65334F6E43616C63287661722056616C75653A2056617269616E74
        293B0D0A626567696E0D0A0D0A20696620444232355B27424152434F44455F46
        4C4147275D203D31207468656E0D0A0D0A2020206C6162656C35392E76697369
        626C653A3D747275650D0A2020656C73650D0A2020206C6162656C35392E7669
        7369626C653A3D66616C73653B200D0A200D0A696620444232355B274E4F5042
        5F666C6167275D3D31207468656E0D0A496D616765362E76697369626C653A3D
        747275650D0A656C73650D0A496D616765362E76697369626C653A3D66616C73
        653B0D0A0D0A696620444232355B27E6A087E8AF863447275D203D2027E6A087
        E8AF86344727207468656E0D0A626567696E0D0A20206C6162656C36302E7669
        7369626C653A3D20747275653B0D0A2020656E640D0A20656C73650D0A206265
        67696E0D0A20206C6162656C36302E76697369626C653A3D2066616C73653B0D
        0A2020656E643B0D0A0D0A0D0A656E643B0D0A0D436F6D706F6E656E744E616D
        6506095661726961626C6533094576656E744E616D6506064F6E43616C630745
        76656E74494402210001060F5472614576656E7448616E646C65720B50726F67
        72616D4E616D65060F5661726961626C65364F6E43616C630B50726F6772616D
        54797065070B747450726F63656475726506536F7572636506DA70726F636564
        757265205661726961626C65364F6E43616C63287661722056616C75653A2056
        617269616E74293B0D0A626567696E0D0A0D0A0D0A696620444232355B276C61
        796572735F696E666F275D3D2727207468656E0D0A626567696E0D0A20737562
        7265706F7274322E76697369626C653A3D66616C73653B0D0A202020656E640D
        0A2020656C73650D0A20626567696E2020202020202020202020202020202020
        2020202020202020200D0A7375627265706F7274322E76697369626C653A3D74
        7275653B0D0A656E643B0D0A0D0A656E643B0D0A0D436F6D706F6E656E744E61
        6D6506095661726961626C6536094576656E744E616D6506064F6E43616C6307
        4576656E74494402210000}
    end
  end
  object ppDB38: TppDBPipeline
    DataSource = DataSource2
    OpenDataSource = False
    UserName = 'DB38'
    Left = 160
    Top = 79
    MasterDataPipelineName = 'ppDB25'
    object ppDB38ppField1: TppField
      FieldAlias = #24037#24207#20195#30721
      FieldName = #24037#24207#20195#30721
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 0
      Searchable = False
      Sortable = False
    end
    object ppDB38ppField2: TppField
      FieldAlias = #24037#24207#21517#31216
      FieldName = #24037#24207#21517#31216
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 1
      Searchable = False
      Sortable = False
    end
    object ppDB38ppField3: TppField
      FieldAlias = 'STEP_NUMBER'
      FieldName = 'STEP_NUMBER'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 2
      Searchable = False
      Sortable = False
    end
    object ppDB38ppField4: TppField
      FieldAlias = #24037#20855#29256#26412
      FieldName = #24037#20855#29256#26412
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 3
      Searchable = False
      Sortable = False
    end
    object ppDB38ppField5: TppField
      FieldAlias = #36807#25968
      FieldName = #36807#25968
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 4
      Searchable = False
      Sortable = False
    end
    object ppDB38ppField6: TppField
      FieldAlias = #20135#20986
      FieldName = #20135#20986
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 5
      Searchable = False
      Sortable = False
    end
    object ppDB38ppField7: TppField
      FieldAlias = #22791#27880
      FieldName = #22791#27880
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 6
      Searchable = False
      Sortable = False
    end
    object ppDB38ppField8: TppField
      FieldAlias = 'SOURCE_PTR'
      FieldName = 'SOURCE_PTR'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 7
      Searchable = False
      Sortable = False
    end
    object ppDB38ppField9: TppField
      FieldAlias = #24037#33402#21442#25968
      FieldName = #24037#33402#21442#25968
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 8
      Searchable = False
      Sortable = False
    end
    object ppDB38ppField10: TppField
      FieldAlias = 'grade_note'
      FieldName = 'grade_note'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 9
      Searchable = False
      Sortable = False
    end
  end
  object ads502: TADODataSet
    Connection = DM.ADOConnection1
    CursorType = ctStatic
    LockType = ltReadOnly
    CommandText = 
      'SELECT sheet_BMP as '#24320#26009#22270', pnl_bmp as A'#25340#29256#22270', '#13#10'pnl2_bmp as B'#25340#29256#22270', TO' +
      'TAL_PNLS_2 as A'#25340#29256#25968', '#13#10'TOTAL_PNLS_1 as B'#25340#29256#25968','#13#10' UNIT_LEN as '#21333#20803#38271', U' +
      'NIT_WTH as '#21333#20803#23485', '#13#10'UNIT_NUM as '#21333#20803#25968', SHT_LEN as '#22823#26009#38271','#13#10' SHT_WTH as ' +
      #22823#26009#23485', TUSAGE as '#22823#26009#21033#29992#29575', '#13#10'PNL_LEN as A'#26495#38271', PNL_WTH as A'#26495#23485','#13#10' UPANEL' +
      ' as A'#26495'PCS'#25968','#13#10' PNL_LEN_2 as B'#26495#38271',PNL_WTH_2 as B'#26495#23485','#13#10' UPANEL_2 as B' +
      #26495'PCS'#25968#13#10'FROM dbo.Data0502'#13#10'where source_ptr=:rkey'
    DataSource = DataSource1
    MasterFields = 'rkey'
    Parameters = <
      item
        Name = 'rkey'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Value = Null
      end>
    Left = 96
    Top = 110
    object ads502DSDesigner: TBlobField
      FieldName = #24320#26009#22270
    end
    object ads502A: TBlobField
      FieldName = 'A'#25340#29256#22270
    end
    object ads502B: TBlobField
      FieldName = 'B'#25340#29256#22270
    end
    object ads502A2: TSmallintField
      FieldName = 'A'#25340#29256#25968
    end
    object ads502B2: TSmallintField
      FieldName = 'B'#25340#29256#25968
    end
    object ads502DSDesigner2: TFloatField
      FieldName = #21333#20803#38271
    end
    object ads502DSDesigner3: TFloatField
      FieldName = #21333#20803#23485
    end
    object ads502DSDesigner4: TIntegerField
      FieldName = #21333#20803#25968
    end
    object ads502DSDesigner5: TFloatField
      FieldName = #22823#26009#38271
    end
    object ads502DSDesigner6: TFloatField
      FieldName = #22823#26009#23485
    end
    object ads502DSDesigner7: TBCDField
      FieldName = #22823#26009#21033#29992#29575
      Precision = 19
    end
    object ads502A3: TFloatField
      FieldName = 'A'#26495#38271
    end
    object ads502A4: TFloatField
      FieldName = 'A'#26495#23485
    end
    object ads502APCS: TSmallintField
      FieldName = 'A'#26495'PCS'#25968
    end
    object ads502B3: TFloatField
      FieldName = 'B'#26495#38271
    end
    object ads502B4: TFloatField
      FieldName = 'B'#26495#23485
    end
    object ads502BPCS: TSmallintField
      FieldName = 'B'#26495'PCS'#25968
    end
  end
  object DataSource3: TDataSource
    DataSet = ads502
    Left = 128
    Top = 110
  end
  object ppDB25: TppDBPipeline
    DataSource = DataSource1
    OpenDataSource = False
    RangeEnd = reCurrentRecord
    RangeBegin = rbCurrentRecord
    UserName = 'DB25'
    Left = 160
    Top = 48
    object ppDB25ppField1: TppField
      FieldAlias = 'RKEY'
      FieldName = 'RKEY'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 0
      Searchable = False
      Sortable = False
    end
    object ppDB25ppField2: TppField
      FieldAlias = #26412#21378#32534#21495
      FieldName = #26412#21378#32534#21495
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 1
      Searchable = False
      Sortable = False
    end
    object ppDB25ppField3: TppField
      FieldAlias = #23458#25143#22411#21495
      FieldName = #23458#25143#22411#21495
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 2
      Searchable = False
      Sortable = False
    end
    object ppDB25ppField4: TppField
      FieldAlias = #23458#25143#20195#30721
      FieldName = #23458#25143#20195#30721
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 3
      Searchable = False
      Sortable = False
    end
    object ppDB25ppField5: TppField
      FieldAlias = #23458#25143#21517#31216
      FieldName = #23458#25143#21517#31216
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 4
      Searchable = False
      Sortable = False
    end
    object ppDB25ppField6: TppField
      FieldAlias = #23458#25143#31616#31216
      FieldName = #23458#25143#31616#31216
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 5
      Searchable = False
      Sortable = False
    end
    object ppDB25ppField7: TppField
      FieldAlias = #31867#22411#20195#30721
      FieldName = #31867#22411#20195#30721
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 6
      Searchable = False
      Sortable = False
    end
    object ppDB25ppField8: TppField
      FieldAlias = #31867#22411#21517#31216
      FieldName = #31867#22411#21517#31216
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 7
      Searchable = False
      Sortable = False
    end
    object ppDB25ppField9: TppField
      FieldAlias = #26816#26597#20154#21592
      FieldName = #26816#26597#20154#21592
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 8
      Searchable = False
      Sortable = False
    end
    object ppDB25ppField10: TppField
      FieldAlias = #26816#26597#26085#26399
      FieldName = #26816#26597#26085#26399
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 9
      Searchable = False
      Sortable = False
    end
    object ppDB25ppField11: TppField
      FieldAlias = #23457#26680#20154#21592
      FieldName = #23457#26680#20154#21592
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 10
      Searchable = False
      Sortable = False
    end
    object ppDB25ppField12: TppField
      FieldAlias = #23457#26680#26085#26399
      FieldName = #23457#26680#26085#26399
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 11
      Searchable = False
      Sortable = False
    end
    object ppDB25ppField13: TppField
      FieldAlias = #20462#35746#20154#21592
      FieldName = #20462#35746#20154#21592
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 12
      Searchable = False
      Sortable = False
    end
    object ppDB25ppField14: TppField
      FieldAlias = #20462#35746#26085#26399
      FieldName = #20462#35746#26085#26399
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 13
      Searchable = False
      Sortable = False
    end
    object ppDB25ppField15: TppField
      FieldAlias = #26679#26495#32534#21495
      FieldName = #26679#26495#32534#21495
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 14
      Searchable = False
      Sortable = False
    end
    object ppDB25ppField16: TppField
      FieldAlias = #23458#25143#29289#26009#21495
      FieldName = #23458#25143#29289#26009#21495
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 15
      Searchable = False
      Sortable = False
    end
    object ppDB25ppField17: TppField
      FieldAlias = #23618#25968
      FieldName = #23618#25968
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 16
      Searchable = False
      Sortable = False
    end
    object ppDB25ppField18: TppField
      FieldAlias = #20132#36135#23610#23544'SET'
      FieldName = #20132#36135#23610#23544'SET'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 17
      Searchable = False
      Sortable = False
    end
    object ppDB25ppField19: TppField
      FieldAlias = #21333#21482#23610#23544'PCS'
      FieldName = #21333#21482#23610#23544'PCS'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 18
      Searchable = False
      Sortable = False
    end
    object ppDB25ppField20: TppField
      FieldAlias = #25340#29256#23610#23544'SPEL'
      FieldName = #25340#29256#23610#23544'SPEL'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 19
      Searchable = False
      Sortable = False
    end
    object ppDB25ppField21: TppField
      FieldAlias = #21333#21482#38754#31215'PCS'
      FieldName = #21333#21482#38754#31215'PCS'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 20
      Searchable = False
      Sortable = False
    end
    object ppDB25ppField22: TppField
      FieldAlias = #21333#21482#38754#31215'SET'
      FieldName = #21333#21482#38754#31215'SET'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 21
      Searchable = False
      Sortable = False
    end
    object ppDB25ppField23: TppField
      FieldAlias = #21333#21482#38754#31215'SPEL'
      FieldName = #21333#21482#38754#31215'SPEL'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 22
      Searchable = False
      Sortable = False
    end
    object ppDB25ppField24: TppField
      FieldAlias = #23618#21387#32467#26500
      FieldName = #23618#21387#32467#26500
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 23
      Searchable = False
      Sortable = False
    end
    object ppDB25ppField25: TppField
      FieldAlias = #21152#24037#25351#31034
      FieldName = #21152#24037#25351#31034
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 24
      Searchable = False
      Sortable = False
    end
    object ppDB25ppField26: TppField
      FieldAlias = #24037#31243#22791#27880
      FieldName = #24037#31243#22791#27880
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 25
      Searchable = False
      Sortable = False
    end
    object ppDB25ppField27: TppField
      FieldAlias = #25253#24223#29575
      FieldName = #25253#24223#29575
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 26
      Searchable = False
      Sortable = False
    end
    object ppDB25ppField28: TppField
      FieldAlias = #29983#20135#21608#26399
      FieldName = #29983#20135#21608#26399
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 27
      Searchable = False
      Sortable = False
    end
    object ppDB25ppField29: TppField
      FieldAlias = #26377#25928#26399#22825#25968
      FieldName = #26377#25928#26399#22825#25968
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 28
      Searchable = False
      Sortable = False
    end
    object ppDB25ppField30: TppField
      FieldAlias = #21046#36896#25552#21069#26399
      FieldName = #21046#36896#25552#21069#26399
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 29
      Searchable = False
      Sortable = False
    end
    object ppDB25ppField31: TppField
      FieldAlias = #22823#26009#35268#26684
      FieldName = #22823#26009#35268#26684
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 30
      Searchable = False
      Sortable = False
    end
    object ppDB25ppField32: TppField
      FieldAlias = #21333#21482#37325#37327'g'
      FieldName = #21333#21482#37325#37327'g'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 31
      Searchable = False
      Sortable = False
    end
    object ppDB25ppField33: TppField
      FieldAlias = #27969#36716#25209#37327
      FieldName = #27969#36716#25209#37327
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 32
      Searchable = False
      Sortable = False
    end
    object ppDB25ppField34: TppField
      FieldAlias = #38144#21806#29366#24577
      FieldName = #38144#21806#29366#24577
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 33
      Searchable = False
      Sortable = False
    end
    object ppDB25ppField35: TppField
      FieldAlias = #23457#25209#29366#24577
      FieldName = #23457#25209#29366#24577
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 34
      Searchable = False
      Sortable = False
    end
    object ppDB25ppField36: TppField
      FieldAlias = #37327#20135#26679#26495
      FieldName = #37327#20135#26679#26495
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 35
      Searchable = False
      Sortable = False
    end
    object ppDB25ppField37: TppField
      FieldAlias = #20135#21697#24615#36136
      FieldName = #20135#21697#24615#36136
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 36
      Searchable = False
      Sortable = False
    end
    object ppDB25ppField38: TppField
      FieldAlias = #20840#23616#21442#25968'1'
      FieldName = #20840#23616#21442#25968'1'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 37
      Searchable = False
      Sortable = False
    end
    object ppDB25ppField39: TppField
      FieldAlias = #20840#23616#21442#25968'2'
      FieldName = #20840#23616#21442#25968'2'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 38
      Searchable = False
      Sortable = False
    end
    object ppDB25ppField40: TppField
      FieldAlias = #21387#21512#27604#20363
      FieldName = #21387#21512#27604#20363
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 39
      Searchable = False
      Sortable = False
    end
    object ppDB25ppField41: TppField
      FieldAlias = #21348#32032#35201#27714
      FieldName = #21348#32032#35201#27714
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 40
      Searchable = False
      Sortable = False
    end
    object ppDB25ppField42: TppField
      FieldAlias = 'barcode_flag'
      FieldName = 'barcode_flag'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 41
      Searchable = False
      Sortable = False
    end
    object ppDB25ppField43: TppField
      FieldAlias = 'NOPB_flag'
      FieldName = 'NOPB_flag'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 42
      Searchable = False
      Sortable = False
    end
    object ppDB25ppField44: TppField
      FieldAlias = #21387#21512#22270#29255
      FieldName = #21387#21512#22270#29255
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 43
      Searchable = False
      Sortable = False
    end
    object ppDB25ppField45: TppField
      FieldAlias = #38075#23380#21472#26495#25968
      FieldName = #38075#23380#21472#26495#25968
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 44
      Searchable = False
      Sortable = False
    end
    object ppDB25ppField46: TppField
      FieldAlias = #38075#23380#21442#25968
      FieldName = #38075#23380#21442#25968
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 45
      Searchable = False
      Sortable = False
    end
    object ppDB25ppField47: TppField
      FieldAlias = #20851#32852#21407#23458#25143
      FieldName = #20851#32852#21407#23458#25143
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 46
      Searchable = False
      Sortable = False
    end
    object ppDB25ppField48: TppField
      FieldAlias = #26631#35782'4G'
      FieldName = #26631#35782'4G'
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 47
      Searchable = False
      Sortable = False
    end
    object pfldDB25ppField49: TppField
      FieldAlias = 'vcut_B'
      FieldName = 'vcut_B'
      FieldLength = 10
      DisplayWidth = 10
      Position = 48
    end
    object pfldDB25ppField50: TppField
      FieldAlias = 'vcut_T'
      FieldName = 'vcut_T'
      FieldLength = 10
      DisplayWidth = 10
      Position = 49
    end
    object pfldDB25ppField51: TppField
      FieldAlias = 'vcut_X'
      FieldName = 'vcut_X'
      FieldLength = 10
      DisplayWidth = 10
      Position = 50
    end
    object pfldDB25ppField52: TppField
      FieldAlias = 'gf_A'
      FieldName = 'gf_A'
      FieldLength = 10
      DisplayWidth = 10
      Position = 51
    end
    object pfldDB25ppField53: TppField
      FieldAlias = 'gf_L'
      FieldName = 'gf_L'
      FieldLength = 10
      DisplayWidth = 10
      Position = 52
    end
    object pfldDB25ppField54: TppField
      FieldAlias = 'gf_T'
      FieldName = 'gf_T'
      FieldLength = 10
      DisplayWidth = 10
      Position = 53
    end
  end
  object ppDB502: TppDBPipeline
    DataSource = DataSource3
    OpenDataSource = False
    RangeEnd = reCurrentRecord
    RangeBegin = rbCurrentRecord
    UserName = 'DB502'
    Left = 160
    Top = 110
    MasterDataPipelineName = 'ppDB25'
    object ppDB502ppField1: TppField
      FieldAlias = #24320#26009#22270
      FieldName = #24320#26009#22270
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 0
      Searchable = False
      Sortable = False
    end
    object ppDB502ppField2: TppField
      FieldAlias = 'A'#25340#29256#22270
      FieldName = 'A'#25340#29256#22270
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 1
      Searchable = False
      Sortable = False
    end
    object ppDB502ppField3: TppField
      FieldAlias = 'B'#25340#29256#22270
      FieldName = 'B'#25340#29256#22270
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 2
      Searchable = False
      Sortable = False
    end
    object ppDB502ppField4: TppField
      FieldAlias = 'A'#25340#29256#25968
      FieldName = 'A'#25340#29256#25968
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 3
      Searchable = False
      Sortable = False
    end
    object ppDB502ppField5: TppField
      FieldAlias = 'B'#25340#29256#25968
      FieldName = 'B'#25340#29256#25968
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 4
      Searchable = False
      Sortable = False
    end
    object ppDB502ppField6: TppField
      FieldAlias = #21333#20803#38271
      FieldName = #21333#20803#38271
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 5
      Searchable = False
      Sortable = False
    end
    object ppDB502ppField7: TppField
      FieldAlias = #21333#20803#23485
      FieldName = #21333#20803#23485
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 6
      Searchable = False
      Sortable = False
    end
    object ppDB502ppField8: TppField
      FieldAlias = #21333#20803#25968
      FieldName = #21333#20803#25968
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 7
      Searchable = False
      Sortable = False
    end
    object ppDB502ppField9: TppField
      FieldAlias = #22823#26009#38271
      FieldName = #22823#26009#38271
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 8
      Searchable = False
      Sortable = False
    end
    object ppDB502ppField10: TppField
      FieldAlias = #22823#26009#23485
      FieldName = #22823#26009#23485
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 9
      Searchable = False
      Sortable = False
    end
    object ppDB502ppField11: TppField
      FieldAlias = #22823#26009#21033#29992#29575
      FieldName = #22823#26009#21033#29992#29575
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 10
      Searchable = False
      Sortable = False
    end
    object ppDB502ppField12: TppField
      FieldAlias = 'A'#26495#38271
      FieldName = 'A'#26495#38271
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 11
      Searchable = False
      Sortable = False
    end
    object ppDB502ppField13: TppField
      FieldAlias = 'A'#26495#23485
      FieldName = 'A'#26495#23485
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 12
      Searchable = False
      Sortable = False
    end
    object ppDB502ppField14: TppField
      FieldAlias = 'A'#26495'PCS'#25968
      FieldName = 'A'#26495'PCS'#25968
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 13
      Searchable = False
      Sortable = False
    end
    object ppDB502ppField15: TppField
      FieldAlias = 'B'#26495#38271
      FieldName = 'B'#26495#38271
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 14
      Searchable = False
      Sortable = False
    end
    object ppDB502ppField16: TppField
      FieldAlias = 'B'#26495#23485
      FieldName = 'B'#26495#23485
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 15
      Searchable = False
      Sortable = False
    end
    object ppDB502ppField17: TppField
      FieldAlias = 'B'#26495'PCS'#25968
      FieldName = 'B'#26495'PCS'#25968
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 16
      Searchable = False
      Sortable = False
    end
  end
  object ads29: TADODataSet
    Connection = DM.ADOConnection1
    CursorType = ctStatic
    LockType = ltReadOnly
    CommandText = 
      'SELECT SEQ_NO as '#24207#21495',SEQ_NR AS '#20992#20855','#13#10' MARK as '#31526#21495', HOLES_DIA as '#25104#21697#23380 +
      #24452','#13#10' PTH as PTH'#23380', TOLERANCE as '#20844#24046', '#13#10' DRILL_DIA as '#38075#21632', UNIT as P' +
      'CS'#23380#25968','#13#10' PANEL_A as A'#26495#23380#25968', PANEL_B AS B'#26495#23380#25968', '#13#10'REMARK as '#22791#27880',SET_UNM' +
      'BER AS SE'#23380#25968#13#10'FROM dbo.Data0029'#13#10'where flow_no=0 and source_ptr=:' +
      'rkey'#13#10'ORDER BY SEQ_NO'
    DataSource = DataSource1
    MasterFields = 'rkey'
    Parameters = <
      item
        Name = 'rkey'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 96
    Top = 143
    object ads29DSDesigner7: TSmallintField
      FieldName = #24207#21495
    end
    object ads29DSDesigner: TStringField
      FieldName = #20992#20855
      Size = 5
    end
    object ads29DSDesigner2: TStringField
      FieldName = #31526#21495
      Size = 6
    end
    object ads29DSDesigner3: TStringField
      FieldName = #25104#21697#23380#24452
      Size = 10
    end
    object ads29PTH: TStringField
      FieldName = 'PTH'#23380
      Size = 1
    end
    object ads29DSDesigner4: TStringField
      FieldName = #20844#24046
      Size = 15
    end
    object ads29DSDesigner5: TStringField
      FieldName = #38075#21632
      Size = 9
    end
    object ads29PCS: TStringField
      FieldName = 'PCS'#23380#25968
      Size = 10
    end
    object ads29A: TStringField
      FieldName = 'A'#26495#23380#25968
      Size = 6
    end
    object ads29B: TStringField
      FieldName = 'B'#26495#23380#25968
      Size = 6
    end
    object ads29DSDesigner6: TStringField
      FieldName = #22791#27880
      Size = 30
    end
    object ads29SE: TStringField
      FieldName = 'SE'#23380#25968
      Size = 6
    end
  end
  object DataSource4: TDataSource
    DataSet = ads29
    Left = 128
    Top = 144
  end
  object ppDB29: TppDBPipeline
    DataSource = DataSource4
    OpenDataSource = False
    UserName = 'DB29'
    Left = 160
    Top = 144
    MasterDataPipelineName = 'ppDB25'
    object ppDB29ppField1: TppField
      FieldAlias = #24207#21495
      FieldName = #24207#21495
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 0
      Searchable = False
      Sortable = False
    end
    object ppDB29ppField2: TppField
      FieldAlias = #20992#20855
      FieldName = #20992#20855
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 1
      Searchable = False
      Sortable = False
    end
    object ppDB29ppField3: TppField
      FieldAlias = #31526#21495
      FieldName = #31526#21495
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 2
      Searchable = False
      Sortable = False
    end
    object ppDB29ppField4: TppField
      FieldAlias = #25104#21697#23380#24452
      FieldName = #25104#21697#23380#24452
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 3
      Searchable = False
      Sortable = False
    end
    object ppDB29ppField5: TppField
      FieldAlias = 'PTH'#23380
      FieldName = 'PTH'#23380
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 4
      Searchable = False
      Sortable = False
    end
    object ppDB29ppField6: TppField
      FieldAlias = #20844#24046
      FieldName = #20844#24046
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 5
      Searchable = False
      Sortable = False
    end
    object ppDB29ppField7: TppField
      FieldAlias = #38075#21632
      FieldName = #38075#21632
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 6
      Searchable = False
      Sortable = False
    end
    object ppDB29ppField8: TppField
      FieldAlias = 'PCS'#23380#25968
      FieldName = 'PCS'#23380#25968
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 7
      Searchable = False
      Sortable = False
    end
    object ppDB29ppField9: TppField
      FieldAlias = 'A'#26495#23380#25968
      FieldName = 'A'#26495#23380#25968
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 8
      Searchable = False
      Sortable = False
    end
    object ppDB29ppField10: TppField
      FieldAlias = 'B'#26495#23380#25968
      FieldName = 'B'#26495#23380#25968
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 9
      Searchable = False
      Sortable = False
    end
    object ppDB29ppField11: TppField
      FieldAlias = #22791#27880
      FieldName = #22791#27880
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 10
      Searchable = False
      Sortable = False
    end
    object ppDB29ppField12: TppField
      FieldAlias = 'SE'#23380#25968
      FieldName = 'SE'#23380#25968
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 11
      Searchable = False
      Sortable = False
    end
  end
  object ads493: TADODataSet
    Active = True
    Connection = DM.ADOConnection1
    CursorType = ctStatic
    LockType = ltReadOnly
    CommandText = 'select * from data0493'#13#10
    Parameters = <>
    Left = 96
    Top = 176
    object ads493Company_Name: TStringField
      FieldName = 'Company_Name'
      Size = 50
    end
    object ads493Company_Name2: TStringField
      FieldName = 'Company_Name2'
      Size = 50
    end
    object ads493Company_Name3: TStringField
      FieldName = 'Company_Name3'
      Size = 50
    end
    object ads493ship_address: TStringField
      FieldName = 'ship_address'
      Size = 50
    end
    object ads493Company_Icon: TBlobField
      FieldName = 'Company_Icon'
    end
    object ads493SITE_INFO_ADD_1: TStringField
      FieldName = 'SITE_INFO_ADD_1'
      FixedChar = True
      Size = 50
    end
    object ads493SITE_INFO_ADD_2: TStringField
      FieldName = 'SITE_INFO_ADD_2'
      FixedChar = True
      Size = 50
    end
    object ads493SITE_INFO_ADD_3: TStringField
      FieldName = 'SITE_INFO_ADD_3'
      FixedChar = True
      Size = 50
    end
    object ads493SITE_INFO_PHONE: TStringField
      FieldName = 'SITE_INFO_PHONE'
      FixedChar = True
      Size = 30
    end
  end
  object DataSource5: TDataSource
    DataSet = ads493
    Left = 128
    Top = 176
  end
  object ppDB493: TppDBPipeline
    DataSource = DataSource5
    RangeEnd = reCurrentRecord
    RangeBegin = rbCurrentRecord
    UserName = 'DB493'
    Left = 160
    Top = 176
    object ppDB493ppField1: TppField
      FieldAlias = 'Company_Name'
      FieldName = 'Company_Name'
      FieldLength = 0
      DisplayWidth = 0
      Position = 0
    end
    object ppDB493ppField2: TppField
      FieldAlias = 'Company_Name2'
      FieldName = 'Company_Name2'
      FieldLength = 50
      DisplayWidth = 50
      Position = 1
    end
    object ppDB493ppField3: TppField
      FieldAlias = 'Company_Name3'
      FieldName = 'Company_Name3'
      FieldLength = 50
      DisplayWidth = 50
      Position = 2
    end
    object ppDB493ppField4: TppField
      FieldAlias = 'ship_address'
      FieldName = 'ship_address'
      FieldLength = 50
      DisplayWidth = 50
      Position = 3
    end
    object ppDB493ppField5: TppField
      FieldAlias = 'Company_Icon'
      FieldName = 'Company_Icon'
      FieldLength = 0
      DataType = dtBLOB
      DisplayWidth = 10
      Position = 4
      Searchable = False
      Sortable = False
    end
    object ppDB493ppField6: TppField
      FieldAlias = 'SITE_INFO_ADD_1'
      FieldName = 'SITE_INFO_ADD_1'
      FieldLength = 50
      DisplayWidth = 50
      Position = 5
    end
    object ppDB493ppField7: TppField
      FieldAlias = 'SITE_INFO_ADD_2'
      FieldName = 'SITE_INFO_ADD_2'
      FieldLength = 50
      DisplayWidth = 50
      Position = 6
    end
    object ppDB493ppField8: TppField
      FieldAlias = 'SITE_INFO_ADD_3'
      FieldName = 'SITE_INFO_ADD_3'
      FieldLength = 50
      DisplayWidth = 50
      Position = 7
    end
    object ppDB493ppField9: TppField
      FieldAlias = 'SITE_INFO_PHONE'
      FieldName = 'SITE_INFO_PHONE'
      FieldLength = 30
      DisplayWidth = 30
      Position = 8
    end
  end
  object ppDesigner1: TppDesigner
    Caption = 'ReportBuilder'
    DataSettings.SessionType = 'BDESession'
    DataSettings.AllowEditSQL = False
    DataSettings.CollationType = ctASCII
    DataSettings.DatabaseType = dtParadox
    DataSettings.IsCaseSensitive = True
    DataSettings.SQLType = sqBDELocal
    Position = poScreenCenter
    Report = ppReport1
    IniStorageType = 'IniFile'
    IniStorageName = '($WINSYS)\RBuilder.ini'
    WindowHeight = 400
    WindowLeft = 100
    WindowTop = 50
    WindowWidth = 600
    WindowState = wsMaximized
    Left = 200
    Top = 112
  end
  object ADS30: TADODataSet
    Connection = DM.ADOConnection1
    CursorType = ctStatic
    LockType = ltReadOnly
    CommandText = 
      'select SEQ_NO as '#39#24207#21495#39', type as '#39#31867#22411#39', layer as '#39#23618#27425#39', refe_layer a' +
      's '#39#21442#32771#23618#39', line_width as '#39#23458#25143#32447#23485#39', line_ofsight as '#39#23458#25143#32447#36317#39','#13#10'adjust_l' +
      'inewidth as '#39#35843#25972#32447#23485#39', adjust_lineofsight as '#39#35843#25972#32447#36317#39', adjust_impedan' +
      'ce as '#39#32511#27833#21069#38459#25239#39', product_impedance as '#39#25104#21697#38459#25239#39', '#13#10'impedance_scope as' +
      ' '#39#38459#25239#25511#21046#33539#22260#39', orig_juli as '#39#21407#22987#21040#38108#30382#36317#31163#39', adjust_jiuli as '#39#35843#25972#21518#21040#38108#36317#31163#39' , s' +
      'ource_ptr from DATA0030'#13#10'where  source_ptr=:rkey'#13#10'order by SEQ_N' +
      'O'
    DataSource = DataSource1
    IndexFieldNames = 'source_ptr'
    MasterFields = 'rkey'
    Parameters = <
      item
        Name = 'rkey'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 259
    Top = 174
    object ADS30DSDesigner: TSmallintField
      FieldName = #24207#21495
    end
    object ADS30DSDesigner2: TStringField
      FieldName = #31867#22411
      Size = 8
    end
    object ADS30DSDesigner3: TStringField
      FieldName = #23618#27425
      Size = 5
    end
    object ADS30DSDesigner4: TStringField
      FieldName = #21442#32771#23618
      Size = 10
    end
    object ADS30DSDesigner5: TStringField
      FieldName = #23458#25143#32447#23485
      Size = 10
    end
    object ADS30DSDesigner7: TBCDField
      FieldName = #35843#25972#32447#23485
      Precision = 5
      Size = 2
    end
    object ADS30DSDesigner8: TBCDField
      FieldName = #35843#25972#32447#36317
      Precision = 5
      Size = 2
    end
    object ADS30DSDesigner9: TStringField
      FieldName = #32511#27833#21069#38459#25239
      Size = 10
    end
    object ADS30DSDesigner10: TStringField
      FieldName = #25104#21697#38459#25239
      Size = 10
    end
    object ADS30DSDesigner11: TStringField
      FieldName = #38459#25239#25511#21046#33539#22260
    end
    object ADS30DSDesigner13: TBCDField
      FieldName = #35843#25972#21518#21040#38108#36317#31163
      Precision = 8
      Size = 3
    end
    object ADS30source_ptr: TIntegerField
      FieldName = 'source_ptr'
    end
    object ADS30DSDesigner6: TStringField
      FieldName = #23458#25143#32447#36317
      Size = 50
    end
    object ADS30DSDesigner12: TStringField
      FieldName = #21407#22987#21040#38108#30382#36317#31163
      Size = 50
    end
  end
  object DataSource6: TDataSource
    DataSet = ADS30
    Left = 291
    Top = 174
  end
  object ppDB30: TppDBPipeline
    DataSource = DataSource6
    UserName = 'DB30'
    Left = 323
    Top = 174
    MasterDataPipelineName = 'ppDB25'
    object ppDB30ppField1: TppField
      Alignment = taRightJustify
      FieldAlias = #24207#21495
      FieldName = #24207#21495
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 0
      Position = 0
    end
    object ppDB30ppField2: TppField
      FieldAlias = #31867#22411
      FieldName = #31867#22411
      FieldLength = 8
      DisplayWidth = 8
      Position = 1
    end
    object ppDB30ppField3: TppField
      FieldAlias = #23618#27425
      FieldName = #23618#27425
      FieldLength = 5
      DisplayWidth = 5
      Position = 2
    end
    object ppDB30ppField4: TppField
      FieldAlias = #21442#32771#23618
      FieldName = #21442#32771#23618
      FieldLength = 10
      DisplayWidth = 10
      Position = 3
    end
    object ppDB30ppField5: TppField
      FieldAlias = #23458#25143#32447#23485
      FieldName = #23458#25143#32447#23485
      FieldLength = 10
      DisplayWidth = 10
      Position = 4
    end
    object ppDB30ppField6: TppField
      Alignment = taRightJustify
      FieldAlias = #35843#25972#32447#23485
      FieldName = #35843#25972#32447#23485
      FieldLength = 2
      DataType = dtDouble
      DisplayWidth = 6
      Position = 5
    end
    object ppDB30ppField7: TppField
      Alignment = taRightJustify
      FieldAlias = #35843#25972#32447#36317
      FieldName = #35843#25972#32447#36317
      FieldLength = 2
      DataType = dtDouble
      DisplayWidth = 6
      Position = 6
    end
    object ppDB30ppField8: TppField
      FieldAlias = #32511#27833#21069#38459#25239
      FieldName = #32511#27833#21069#38459#25239
      FieldLength = 10
      DisplayWidth = 10
      Position = 7
    end
    object ppDB30ppField9: TppField
      FieldAlias = #25104#21697#38459#25239
      FieldName = #25104#21697#38459#25239
      FieldLength = 10
      DisplayWidth = 10
      Position = 8
    end
    object ppDB30ppField10: TppField
      FieldAlias = #38459#25239#25511#21046#33539#22260
      FieldName = #38459#25239#25511#21046#33539#22260
      FieldLength = 20
      DisplayWidth = 20
      Position = 9
    end
    object ppDB30ppField11: TppField
      Alignment = taRightJustify
      FieldAlias = #35843#25972#21518#21040#38108#36317#31163
      FieldName = #35843#25972#21518#21040#38108#36317#31163
      FieldLength = 3
      DataType = dtDouble
      DisplayWidth = 9
      Position = 10
    end
    object ppDB30ppField12: TppField
      Alignment = taRightJustify
      FieldAlias = 'source_ptr'
      FieldName = 'source_ptr'
      FieldLength = 0
      DataType = dtInteger
      DisplayWidth = 10
      Position = 11
    end
    object ppDB30ppField13: TppField
      FieldAlias = #23458#25143#32447#36317
      FieldName = #23458#25143#32447#36317
      FieldLength = 50
      DisplayWidth = 50
      Position = 12
    end
    object ppDB30ppField14: TppField
      FieldAlias = #21407#22987#21040#38108#30382#36317#31163
      FieldName = #21407#22987#21040#38108#30382#36317#31163
      FieldLength = 50
      DisplayWidth = 50
      Position = 13
    end
  end
  object ADODataSet1: TADODataSet
    Connection = DM.ADOConnection1
    CursorType = ctStatic
    LockType = ltReadOnly
    CommandText = 
      'SELECT SEQ_NO as '#24207#21495',SEQ_NR AS '#20992#20855','#13#10' MARK as '#31526#21495', HOLES_DIA as '#25104#21697#23380 +
      #24452','#13#10' PTH as PTH'#23380', TOLERANCE as '#20844#24046', '#13#10' DRILL_DIA as '#38075#21632', UNIT as P' +
      'CS'#23380#25968','#13#10' PANEL_A as A'#26495#23380#25968', PANEL_B AS B'#26495#23380#25968', '#13#10'REMARK as '#22791#27880',SET_UNM' +
      'BER AS SE'#23380#25968#13#10'FROM dbo.Data0029'#13#10'where flow_no>=1 and source_ptr=' +
      ':rkey'#13#10'ORDER BY  flow_no,SEQ_NO'
    DataSource = DataSource1
    MasterFields = 'rkey'
    Parameters = <
      item
        Name = 'rkey'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    Left = 96
    Top = 207
    object SmallintField1: TSmallintField
      FieldName = #24207#21495
    end
    object StringField1: TStringField
      FieldName = #20992#20855
      Size = 5
    end
    object StringField2: TStringField
      FieldName = #31526#21495
      Size = 6
    end
    object StringField3: TStringField
      FieldName = #25104#21697#23380#24452
      Size = 10
    end
    object StringField4: TStringField
      FieldName = 'PTH'#23380
      Size = 1
    end
    object StringField5: TStringField
      FieldName = #20844#24046
      Size = 15
    end
    object StringField6: TStringField
      FieldName = #38075#21632
      Size = 9
    end
    object StringField7: TStringField
      FieldName = 'PCS'#23380#25968
      Size = 10
    end
    object StringField8: TStringField
      FieldName = 'A'#26495#23380#25968
      Size = 6
    end
    object StringField9: TStringField
      FieldName = 'B'#26495#23380#25968
      Size = 6
    end
    object StringField10: TStringField
      FieldName = #22791#27880
      Size = 30
    end
    object StringField11: TStringField
      FieldName = 'SE'#23380#25968
      Size = 6
    end
  end
  object DataSource7: TDataSource
    DataSet = ADODataSet1
    Left = 128
    Top = 208
  end
  object ppDB2901: TppDBPipeline
    DataSource = DataSource7
    UserName = 'DB2901'
    Left = 160
    Top = 208
    MasterDataPipelineName = 'ppDB25'
    object pfldDB2901ppField1: TppField
      FieldAlias = #24207#21495
      FieldName = #24207#21495
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 0
      Searchable = False
      Sortable = False
    end
    object pfldDB2901ppField2: TppField
      FieldAlias = #20992#20855
      FieldName = #20992#20855
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 1
      Searchable = False
      Sortable = False
    end
    object pfldDB2901ppField3: TppField
      FieldAlias = #31526#21495
      FieldName = #31526#21495
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 2
      Searchable = False
      Sortable = False
    end
    object pfldDB2901ppField4: TppField
      FieldAlias = #25104#21697#23380#24452
      FieldName = #25104#21697#23380#24452
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 3
      Searchable = False
      Sortable = False
    end
    object pfldDB2901ppField5: TppField
      FieldAlias = 'PTH'#23380
      FieldName = 'PTH'#23380
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 4
      Searchable = False
      Sortable = False
    end
    object pfldDB2901ppField6: TppField
      FieldAlias = #20844#24046
      FieldName = #20844#24046
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 5
      Searchable = False
      Sortable = False
    end
    object pfldDB2901ppField7: TppField
      FieldAlias = #38075#21632
      FieldName = #38075#21632
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 6
      Searchable = False
      Sortable = False
    end
    object pfldDB2901ppField8: TppField
      FieldAlias = 'PCS'#23380#25968
      FieldName = 'PCS'#23380#25968
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 7
      Searchable = False
      Sortable = False
    end
    object pfldDB2901ppField9: TppField
      FieldAlias = 'A'#26495#23380#25968
      FieldName = 'A'#26495#23380#25968
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 8
      Searchable = False
      Sortable = False
    end
    object pfldDB2901ppField10: TppField
      FieldAlias = 'B'#26495#23380#25968
      FieldName = 'B'#26495#23380#25968
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 9
      Searchable = False
      Sortable = False
    end
    object pfldDB2901ppField11: TppField
      FieldAlias = #22791#27880
      FieldName = #22791#27880
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 10
      Searchable = False
      Sortable = False
    end
    object pfldDB2901ppField12: TppField
      FieldAlias = 'SE'#23380#25968
      FieldName = 'SE'#23380#25968
      FieldLength = 0
      DataType = dtNotKnown
      DisplayWidth = 0
      Position = 11
      Searchable = False
      Sortable = False
    end
  end
end
