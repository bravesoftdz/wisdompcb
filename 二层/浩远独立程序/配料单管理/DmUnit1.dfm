object DM: TDM
  OldCreateOrder = False
  Left = 399
  Top = 125
  Height = 457
  Width = 503
  object ADOConnection1: TADOConnection
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 40
    Top = 8
  end
  object ADOQALL2: TADOQuery
    Connection = ADOConnection1
    CursorType = ctStatic
    Filtered = True
    OnCalcFields = ADOQALL2CalcFields
    Parameters = <
      item
        Name = 'vdate1'
        DataType = ftDateTime
        Precision = 16
        Size = 16
        Value = 39346d
      end
      item
        Name = 'vdate2'
        DataType = ftDateTime
        Precision = 16
        Size = 16
        Value = 39347d
      end
      item
        Name = 'ts1'
        DataType = ftWord
        Precision = 3
        Size = 1
        Value = 9
      end
      item
        Name = 'ts2'
        DataType = ftWord
        Precision = 3
        Size = 1
        Value = 1
      end
      item
        Name = 'ts3'
        DataType = ftWord
        Precision = 3
        Size = 1
        Value = 9
      end
      item
        Name = 'ts4'
        DataType = ftWord
        Precision = 3
        Size = 1
        Value = 3
      end>
    Prepared = True
    SQL.Strings = (
      
        'SELECT     dbo.data0492.rkey, dbo.data0492.TTYPE, dbo.data0492.C' +
        'UT_NO, dbo.data0492.SO_NO, dbo.data0492.PLANNED_QTY, dbo.data049' +
        '2.PRINTED_BY_PTR,'
      
        '  dbo.data0492.ISSUED_QTY, dbo.data0492.SCH_COMPL_DATE, dbo.data' +
        '0492.ISSUE_DATE, dbo.data0492.CREATED_BY_PTR, dbo.data0492.UPANE' +
        'L1,'
      
        '  dbo.data0492.PANEL_1_QTY, dbo.data0492.Con_Flag, dbo.data0492.' +
        'UPANEL2, dbo.data0492.PANEL_2_QTY, dbo.data0492.remark, dbo.data' +
        '0492.FG_QTY,'
      
        '  dbo.data0492.QTY_REJECT, dbo.data0492.TSTATUS, dbo.data0492.WI' +
        'P_QTY, dbo.data0492.waitfor_release, dbo.data0492.ORD_REQ_QTY, d' +
        'bo.data0492.pnl1_size,'
      
        '  dbo.data0492.pnl2_size, dbo.data0492.analysis_code_3, dbo.Data' +
        '0060.PARTS_ORDERED, dbo.Data0060.SCH_DATE, dbo.Data0060.REFERENC' +
        'E_NUMBER,'
      
        '  dbo.Data0060.QTY_PLANNNED, dbo.Data0025.RKEY AS d025_rkey, dbo' +
        '.Data0025.MANU_PART_NUMBER, dbo.Data0025.MANU_PART_DESC,'
      
        '  dbo.Data0025.REMARK AS remark25, dbo.Data0025.EST_SCRAP, dbo.D' +
        'ata0025.PARENT_PTR, dbo.Data0097.PO_NUMBER, dbo.Data0008.PRODUCT' +
        '_NAME,'
      
        '  dbo.Data0005.EMPLOYEE_NAME, dbo.data0492.ISSUED_QTY * dbo.Data' +
        '0025.unit_sq AS '#25237#20135#38754#31215','
      '  dbo.Data0060.PARTS_ORDERED * dbo.Data0025.unit_sq AS '#35746#21333#38754#31215','
      
        '  CASE WHEN data0060.PARTS_ORDERED > 0 THEN round(CAST(Data0492.' +
        'ISSUED_QTY * 100 AS float) / CAST(data0060.PARTS_ORDERED AS floa' +
        't), 2)'
      
        '  ELSE 0 END AS '#36229#25237#29575', dbo.Data0010.CUSTOMER_NAME, dbo.Data0025.un' +
        'it_sq, RTRIM(CONVERT(varchar(9), dbo.Data0025.set_lngth))'
      
        '  + '#39'mm * '#39' + RTRIM(CONVERT(varchar(9), dbo.Data0025.set_width))' +
        ' + '#39'mm'#39' AS set_lngthset_width, dbo.Data0010.CUST_CODE, dbo.Data0' +
        '025.set_qty,'
      '  dbo.Data0025.BOM_STATUS, dbo.Data0025.QTY_ON_HAND,'
      
        '  CASE data0025.BOM_STATUS WHEN 0 THEN '#39#24453#21518#34917#39' WHEN 1 THEN '#39'BOM'#24453#23457#39 +
        ' WHEN 2 THEN '#39'BOM'#24453#21046#20316#39' WHEN 4 THEN '#39'BOM'#24050#23457#39' END AS bomstatus,'
      '  dbo.Data0015.WAREHOUSE_CODE, dbo.Data0015.ABBR_NAME'
      'FROM         dbo.Data0015 INNER JOIN'
      'dbo.Data0008 INNER JOIN'
      'dbo.Data0005 INNER JOIN'
      'dbo.data0492 INNER JOIN'
      
        'dbo.Data0025 ON dbo.data0492.BOM_PTR = dbo.Data0025.RKEY ON dbo.' +
        'Data0005.RKEY = dbo.data0492.CREATED_BY_PTR ON'
      
        'dbo.Data0008.RKEY = dbo.Data0025.PROD_CODE_PTR ON dbo.Data0015.R' +
        'KEY = dbo.data0492.WHOUSE_PTR INNER JOIN'
      
        'dbo.Data0010 ON dbo.data0492.COMPLETED = dbo.Data0010.RKEY LEFT ' +
        'OUTER JOIN'
      'dbo.Data0060 LEFT OUTER JOIN'
      
        'dbo.Data0097 ON dbo.Data0060.PURCHASE_ORDER_PTR = dbo.Data0097.R' +
        'KEY ON dbo.data0492.SO_NO = dbo.Data0060.SALES_ORDER'
      
        'WHERE (data0492.ISSUE_DATE >= :vdate1 )  AND (data0492.ISSUE_DAT' +
        'E <= :vdate2 )'
      '  and (data0492.tstatus <> :ts1)  and (data0492.tstatus <> :ts2)'
      '  and (data0492.tstatus <> :ts3)  and (data0492.tstatus <> :ts4)')
    Left = 48
    Top = 88
    object ADOQALL2CUT_NO: TStringField
      DisplayLabel = #37197#26009#21333#21495
      DisplayWidth = 12
      FieldName = 'CUT_NO'
      FixedChar = True
      Size = 12
    end
    object ADOQALL2MANU_PART_NUMBER: TStringField
      DisplayLabel = #26412#21378#32534#21495
      DisplayWidth = 17
      FieldName = 'MANU_PART_NUMBER'
    end
    object ADOQALL2MANU_PART_DESC: TStringField
      DisplayLabel = #23458#25143#22411#21495
      DisplayWidth = 21
      FieldName = 'MANU_PART_DESC'
      Size = 40
    end
    object ADOQALL2ORD_REQ_QTY: TIntegerField
      DisplayLabel = #24453#35745#21010#25968
      DisplayWidth = 10
      FieldName = 'ORD_REQ_QTY'
    end
    object ADOQALL2PLANNED_QTY: TIntegerField
      DisplayLabel = #35745#21010#25968#37327
      DisplayWidth = 10
      FieldName = 'PLANNED_QTY'
    end
    object ADOQALL2ISSUED_QTY: TIntegerField
      DisplayLabel = #25237#20135#25968#37327
      DisplayWidth = 10
      FieldName = 'ISSUED_QTY'
    end
    object ADOQALL2FG_QTY: TIntegerField
      DisplayLabel = #24050#20837#24211#25968
      DisplayWidth = 8
      FieldName = 'FG_QTY'
    end
    object ADOQALL2WIP_QTY: TIntegerField
      DisplayLabel = #22312#32447#25968
      DisplayWidth = 10
      FieldName = 'WIP_QTY'
    end
    object ADOQALL2QTY_REJECT: TIntegerField
      DisplayLabel = #25253#24223#25968
      DisplayWidth = 10
      FieldName = 'QTY_REJECT'
    end
    object ADOQALL2waitfor_release: TIntegerField
      DisplayLabel = #24453#21457#25918#25968
      FieldName = 'waitfor_release'
    end
    object ADOQALL2PANEL_1_QTY: TIntegerField
      DisplayLabel = 'A'#26495#25968#37327
      DisplayWidth = 7
      FieldName = 'PANEL_1_QTY'
    end
    object ADOQALL2UPANEL1: TIntegerField
      DisplayLabel = 'PCS/A'#26495
      DisplayWidth = 7
      FieldName = 'UPANEL1'
    end
    object ADOQALL2PANEL_2_QTY: TIntegerField
      DisplayLabel = 'B'#26495#25968#37327
      DisplayWidth = 7
      FieldName = 'PANEL_2_QTY'
    end
    object ADOQALL2UPANEL2: TIntegerField
      DisplayLabel = 'PCS/B'#26495
      DisplayWidth = 7
      FieldName = 'UPANEL2'
    end
    object ADOQALL2ISSUE_DATE: TDateTimeField
      DisplayLabel = #25237#20135#26085#26399
      DisplayWidth = 18
      FieldName = 'ISSUE_DATE'
    end
    object ADOQALL2printed: TStringField
      DisplayLabel = #25171#21360
      DisplayWidth = 6
      FieldKind = fkCalculated
      FieldName = 'printed'
      Size = 8
      Calculated = True
    end
    object ADOQALL2SO_NO: TStringField
      DisplayLabel = #38144#21806#35746#21333
      DisplayWidth = 13
      FieldName = 'SO_NO'
      FixedChar = True
      Size = 12
    end
    object ADOQALL2SCH_DATE: TDateTimeField
      DisplayLabel = #35745#21010#20132#36135#26399
      DisplayWidth = 11
      FieldName = 'SCH_DATE'
    end
    object ADOQALL2PARTS_ORDERED: TFloatField
      DisplayLabel = #35746#21333#25968#37327
      DisplayWidth = 9
      FieldName = 'PARTS_ORDERED'
    end
    object ADOQALL2QTY_PLANNNED: TIntegerField
      DisplayLabel = #24050#35745#21010#25968#37327
      DisplayWidth = 10
      FieldName = 'QTY_PLANNNED'
    end
    object ADOQALL2CUST_CODE: TStringField
      DisplayLabel = #23458#25143#20195#30721
      DisplayWidth = 9
      FieldName = 'CUST_CODE'
      Size = 10
    end
    object ADOQALL2CUSTOMER_NAME: TStringField
      DisplayLabel = #23458#25143#21517#31216
      DisplayWidth = 33
      FieldName = 'CUSTOMER_NAME'
      Size = 100
    end
    object ADOQALL2EMPLOYEE_NAME: TStringField
      DisplayLabel = #25237#20135#20154
      DisplayWidth = 8
      FieldName = 'EMPLOYEE_NAME'
      Size = 16
    end
    object ADOQALL2PRODUCT_NAME: TStringField
      DisplayLabel = #20135#21697#31867#21035
      DisplayWidth = 18
      FieldName = 'PRODUCT_NAME'
      Size = 30
    end
    object ADOQALL2MySTATUS: TStringField
      DisplayLabel = #23457#26680#29366#24577
      DisplayWidth = 8
      FieldKind = fkCalculated
      FieldName = 'MySTATUS'
      Size = 8
      Calculated = True
    end
    object ADOQALL2unit_sq: TFloatField
      DisplayLabel = 'PCS'#38754#31215
      DisplayWidth = 15
      FieldName = 'unit_sq'
      ReadOnly = True
    end
    object ADOQALL2set_lngthset_width: TStringField
      DisplayLabel = #20132#36135#23610#23544
      DisplayWidth = 21
      FieldName = 'set_lngthset_width'
      ReadOnly = True
      Size = 25
    end
    object ADOQALL2set_qty: TIntegerField
      DisplayLabel = 'Pcs/Set'
      DisplayWidth = 7
      FieldName = 'set_qty'
      ReadOnly = True
    end
    object ADOQALL2MyCon_Flag: TStringField
      DisplayLabel = #30830#35748#29366#24577
      FieldKind = fkCalculated
      FieldName = 'MyCon_Flag'
      Size = 8
      Calculated = True
    end
    object ADOQALL2rkey: TAutoIncField
      DisplayWidth = 10
      FieldName = 'rkey'
      ReadOnly = True
    end
    object ADOQALL2TTYPE: TWordField
      DisplayWidth = 10
      FieldName = 'TTYPE'
    end
    object ADOQALL2SCH_COMPL_DATE: TDateTimeField
      DisplayWidth = 18
      FieldName = 'SCH_COMPL_DATE'
    end
    object ADOQALL2CREATED_BY_PTR: TIntegerField
      DisplayWidth = 10
      FieldName = 'CREATED_BY_PTR'
    end
    object ADOQALL2PRINTED_BY_PTR: TSmallintField
      DisplayWidth = 13
      FieldName = 'PRINTED_BY_PTR'
    end
    object ADOQALL2remark: TStringField
      DisplayLabel = #25237#20135#22791#27880
      DisplayWidth = 61
      FieldName = 'remark'
      Size = 100
    end
    object ADOQALL2TSTATUS: TWordField
      DisplayWidth = 10
      FieldName = 'TSTATUS'
    end
    object ADOQALL2Con_Flag: TSmallintField
      DisplayWidth = 10
      FieldName = 'Con_Flag'
    end
    object ADOQALL2pnl1_size: TStringField
      DisplayWidth = 20
      FieldName = 'pnl1_size'
    end
    object ADOQALL2pnl2_size: TStringField
      DisplayWidth = 20
      FieldName = 'pnl2_size'
    end
    object ADOQALL2ANALYSIS_CODE_3: TStringField
      DisplayWidth = 50
      FieldName = 'ANALYSIS_CODE_3'
      Size = 50
    end
    object ADOQALL2REFERENCE_NUMBER: TStringField
      DisplayWidth = 30
      FieldName = 'REFERENCE_NUMBER'
      Size = 30
    end
    object ADOQALL2d025_rkey: TAutoIncField
      DisplayWidth = 10
      FieldName = 'd025_rkey'
      ReadOnly = True
    end
    object ADOQALL2remark25: TMemoField
      DisplayLabel = #21152#24037#25351#31034
      DisplayWidth = 10
      FieldName = 'remark25'
      BlobType = ftMemo
    end
    object ADOQALL2EST_SCRAP: TFloatField
      DisplayWidth = 10
      FieldName = 'EST_SCRAP'
    end
    object ADOQALL2PARENT_PTR: TIntegerField
      DisplayWidth = 10
      FieldName = 'PARENT_PTR'
    end
    object ADOQALL2PO_NUMBER: TStringField
      DisplayWidth = 25
      FieldName = 'PO_NUMBER'
      Size = 25
    end
    object ADOQALL2bom_status: TWordField
      DisplayWidth = 10
      FieldName = 'bom_status'
    end
    object ADOQALL2MyTTYPE: TStringField
      DisplayLabel = #25237#20135#31867#22411
      FieldKind = fkCalculated
      FieldName = 'MyTTYPE'
      Calculated = True
    end
    object ADOQALL2QTY_ON_HAND: TIntegerField
      FieldName = 'QTY_ON_HAND'
    end
    object ADOQALL2DSDesigner: TFloatField
      FieldName = #25237#20135#38754#31215
      ReadOnly = True
    end
    object ADOQALL2DSDesigner2: TFloatField
      FieldName = #35746#21333#38754#31215
      ReadOnly = True
    end
    object ADOQALL2DSDesigner3: TFloatField
      FieldName = #36229#25237#29575
      ReadOnly = True
    end
    object ADOQALL2bomstatus: TStringField
      DisplayLabel = 'BOM'#29366#24577
      FieldName = 'bomstatus'
      ReadOnly = True
      Size = 8
    end
    object ADOQALL2WAREHOUSE_CODE: TStringField
      DisplayLabel = #24037#21378#20195#30721
      FieldName = 'WAREHOUSE_CODE'
      Size = 5
    end
    object ADOQALL2ABBR_NAME: TStringField
      DisplayLabel = #24037#21378#31616#31216
      FieldName = 'ABBR_NAME'
      Size = 10
    end
  end
  object TemADOQuery1: TADOQuery
    Connection = ADOConnection1
    Parameters = <>
    Left = 48
    Top = 168
  end
  object TMPADO1: TADOQuery
    Connection = ADOConnection1
    CursorType = ctStatic
    EnableBCD = False
    Parameters = <
      item
        Name = 'vptr'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = 0
      end>
    SQL.Strings = (
      'select * from data0502'
      'where source_ptr =:vptr')
    Left = 43
    Top = 320
    object TMPADO1rkey: TAutoIncField
      FieldName = 'rkey'
      ReadOnly = True
    end
    object TMPADO1source_ptr: TIntegerField
      FieldName = 'source_ptr'
    end
    object TMPADO1sheet_BMP: TBlobField
      FieldName = 'sheet_BMP'
    end
    object TMPADO1pnl_bmp: TBlobField
      FieldName = 'pnl_bmp'
    end
    object TMPADO1pnl2_bmp: TBlobField
      FieldName = 'pnl2_bmp'
    end
    object TMPADO1TOTAL_PNLS_1: TSmallintField
      FieldName = 'TOTAL_PNLS_1'
    end
    object TMPADO1TOTAL_PNLS_2: TSmallintField
      FieldName = 'TOTAL_PNLS_2'
    end
    object TMPADO1UNIT_LEN: TFloatField
      FieldName = 'UNIT_LEN'
    end
    object TMPADO1UNIT_WTH: TFloatField
      FieldName = 'UNIT_WTH'
    end
    object TMPADO1UNIT_UNIT: TWordField
      FieldName = 'UNIT_UNIT'
    end
    object TMPADO1UNIT_NUM: TIntegerField
      FieldName = 'UNIT_NUM'
    end
    object TMPADO1SHT_LEN: TFloatField
      FieldName = 'SHT_LEN'
    end
    object TMPADO1SHT_WTH: TFloatField
      FieldName = 'SHT_WTH'
    end
    object TMPADO1TUSAGE: TBCDField
      FieldName = 'TUSAGE'
      Precision = 19
    end
    object TMPADO1PNL_LEN: TFloatField
      FieldName = 'PNL_LEN'
    end
    object TMPADO1PNL_WTH: TFloatField
      FieldName = 'PNL_WTH'
    end
    object TMPADO1UPANEL: TSmallintField
      FieldName = 'UPANEL'
    end
    object TMPADO1PNL_LEN_2: TFloatField
      FieldName = 'PNL_LEN_2'
    end
    object TMPADO1PNL_WTH_2: TFloatField
      FieldName = 'PNL_WTH_2'
    end
    object TMPADO1UPANEL_2: TSmallintField
      FieldName = 'UPANEL_2'
    end
    object TMPADO1minspace1: TFloatField
      FieldName = 'minspace1'
    end
    object TMPADO1minspace2: TFloatField
      FieldName = 'minspace2'
    end
  end
  object TemADOQuery2: TADOQuery
    Connection = ADOConnection1
    Parameters = <>
    Left = 48
    Top = 232
  end
  object ADOQ0026: TADOQuery
    Connection = ADOConnection1
    CursorType = ctStatic
    LockType = ltReadOnly
    Parameters = <
      item
        Name = 'rkey0025'
        Attributes = [paSigned, paNullable]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      
        'select RKEY, MANU_BOM_PTR, DEPT_PTR, INVENTORY_PTR, QTY_BOM, FLO' +
        'W_NO, ROUTE_STEP_NO, DOC_FLAG'
      'from data0026'
      'where '
      ' Data0026.DOC_FLAG='#39'Y'#39' and MANU_BOM_PTR = :rkey0025')
    Left = 320
    Top = 336
    object ADOQ0026RKEY: TAutoIncField
      FieldName = 'RKEY'
      ReadOnly = True
    end
    object ADOQ0026MANU_BOM_PTR: TIntegerField
      FieldName = 'MANU_BOM_PTR'
    end
    object ADOQ0026DEPT_PTR: TIntegerField
      FieldName = 'DEPT_PTR'
    end
    object ADOQ0026INVENTORY_PTR: TIntegerField
      FieldName = 'INVENTORY_PTR'
    end
    object ADOQ0026QTY_BOM: TFloatField
      FieldName = 'QTY_BOM'
    end
    object ADOQ0026FLOW_NO: TSmallintField
      FieldName = 'FLOW_NO'
    end
    object ADOQ0026ROUTE_STEP_NO: TSmallintField
      FieldName = 'ROUTE_STEP_NO'
    end
    object ADOQ0026DOC_FLAG: TStringField
      FieldName = 'DOC_FLAG'
      FixedChar = True
      Size = 1
    end
  end
  object DataSource1: TDataSource
    DataSet = ADOQALL2
    Left = 120
    Top = 88
  end
  object AQY468: TADOQuery
    Connection = ADOConnection1
    CursorType = ctStatic
    Parameters = <
      item
        Name = 'CUT_NO'
        DataType = ftString
        NumericScale = 255
        Precision = 255
        Size = 12
        Value = Null
      end>
    SQL.Strings = (
      
        'SELECT     CUT_NO, SO_NO, STEP, DEPT_PTR, INVENT_PTR, QUAN_BOM, ' +
        'STATUS, VENDOR, Invent_or,printit'
      'FROM         dbo.Data0468'
      'where CUT_NO = :CUT_NO '
      '')
    Left = 320
    Top = 280
    object AQY468CUT_NO: TStringField
      FieldName = 'CUT_NO'
      FixedChar = True
      Size = 12
    end
    object AQY468SO_NO: TStringField
      FieldName = 'SO_NO'
      FixedChar = True
      Size = 12
    end
    object AQY468STEP: TSmallintField
      FieldName = 'STEP'
    end
    object AQY468DEPT_PTR: TIntegerField
      FieldName = 'DEPT_PTR'
    end
    object AQY468INVENT_PTR: TIntegerField
      FieldName = 'INVENT_PTR'
    end
    object AQY468QUAN_BOM: TFloatField
      FieldName = 'QUAN_BOM'
    end
    object AQY468STATUS: TSmallintField
      FieldName = 'STATUS'
    end
    object AQY468VENDOR: TStringField
      FieldName = 'VENDOR'
      FixedChar = True
      Size = 15
    end
    object AQY468Invent_or: TSmallintField
      FieldName = 'Invent_or'
    end
    object AQY468printit: TStringField
      FieldName = 'printit'
      FixedChar = True
      Size = 1
    end
  end
end
