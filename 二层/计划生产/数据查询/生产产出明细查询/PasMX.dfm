object frmMX: TfrmMX
  Left = 435
  Top = 218
  Width = 646
  Height = 408
  Caption = '��ϸ'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = '����'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 630
    Height = 370
    Align = alClient
    TabOrder = 0
    object Panel2: TPanel
      Left = 1
      Top = 1
      Width = 628
      Height = 327
      Align = alClient
      TabOrder = 0
  object DBGridEh1: TDBGridEh
    Left = 0
    Top = 38
    Width = 1131
    Height = 570
    Align = alClient
    DataSource = DataSource1
    FooterColor = cl3DLight
    FooterFont.Charset = DEFAULT_CHARSET
    FooterFont.Color = clWindowText
    FooterFont.Height = -13
    FooterFont.Name = '����'
    FooterFont.Style = []
    FooterRowCount = 1
    OptionsEh = [dghFixed3D, dghHighlightFocus, dghClearSelection, dghRowHighlight]
    ReadOnly = True
    SumList.Active = True
    TabOrder = 1
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = '����'
    TitleFont.Style = []
    OnDrawColumnCell = DBGridEh1DrawColumnCell
    OnKeyDown = DBGridEh1KeyDown
    OnTitleClick = DBGridEh1TitleClick
    Columns = <
      item
        EditButtons = <>
        FieldName = 'WORK_ORDER_NUMBER'
        Footer.Value = '�ϼ�'
        Footer.ValueType = fvtStaticText
        Footers = <>
        Width = 103
      end
      item
        EditButtons = <>
        FieldName = 'MANU_PART_NUMBER'
        Footers = <>
        Width = 73
      end
      item
        EditButtons = <>
        FieldName = 'MANU_PART_DESC'
        Footers = <>
        Width = 130
      end
      item
        EditButtons = <>
        FieldName = 'DEPT_CODE'
        Footers = <>
        Title.Caption = '�������'
        Width = 81
      end
      item
        EditButtons = <>
        FieldName = 'DEPT_NAME'
        Footers = <>
        Title.Caption = '��������'
        Width = 107
      end
      item
        EditButtons = <>
        FieldName = 'dept_code2'
        Footers = <>
        Visible = False
        Width = 82
      end
      item
        EditButtons = <>
        FieldName = 'dept_name2'
        Footers = <>
        Visible = False
        Width = 114
      end
      item
        EditButtons = <>
        FieldName = 'dept_code1'
        Footers = <>
      end
      item
        EditButtons = <>
        FieldName = 'dept_name1'
        Footers = <>
        Width = 89
      end
      item
        EditButtons = <>
        FieldName = 'total_sqft'
        Footer.ValueType = fvtSum
        Footers = <>
        Width = 80
      end
      item
        EditButtons = <>
        FieldName = 'QTY_PROD2'
        Footer.FieldName = 'QTY_PROD2'
        Footer.ValueType = fvtSum
        Footers = <>
        Title.Caption = 'PCS��'
        Width = 68
      end
      item
        EditButtons = <>
        FieldName = 'PANELS'
        Footer.FieldName = 'PANELS'
        Footer.ValueType = fvtSum
        Footers = <>
        Title.Caption = 'PNL����'
        Width = 68
      end
      item
        EditButtons = <>
        FieldName = 'INTIME'
        Footers = <>
        Title.Caption = '�հ�ʱ��'
        Visible = False
        Width = 91
      end
      item
        EditButtons = <>
        FieldName = 'OUTTIME'
        Footers = <>
        Width = 76
      end
      item
        EditButtons = <>
        FieldName = 'ͣ��Сʱ'
        Footers = <>
      end
      item
        EditButtons = <>
        FieldName = 'DataValues'
        Footers = <>
        Title.Alignment = taCenter
        Title.Caption = '�����깤Сʱ��(����)'
        Width = 80
      end
      item
        EditButtons = <>
        FieldName = 'ModernDate34'
        Footers = <>
        Title.Caption = '�����������ʱ��'
        Width = 110
      end
      item
        EditButtons = <>
        FieldName = 'FLOW_NO'
        Footers = <>
        Title.Caption = '��ͣСʱ��'
        Width = 70
      end
      item
        EditButtons = <>
        FieldName = 'YS'
        Footers = <>
        Title.Caption = '�Ƿ�׼��'
        Width = 56
      end
      item
        EditButtons = <>
        FieldName = 'PRIORITY_name'
        Footers = <>
        Title.Caption = '�����̶�'
        Width = 80
      end
      item
        EditButtons = <>
        FieldName = 'PARTS_PER_PANEL'
        Footers = <>
        Visible = False
      end
      item
        EditButtons = <>
        FieldName = 'pnl_size'
        Footers = <>
        Visible = False
      end
      item
        EditButtons = <>
        FieldName = 'panel_ln'
        Footers = <>
        Title.Alignment = taCenter
        Title.Caption = 'PNL��'
        Width = 60
      end
      item
        EditButtons = <>
        FieldName = 'panel_wd'
        Footers = <>
        Title.Alignment = taCenter
        Title.Caption = 'PNL��'
        Width = 60
      end
      item
        EditButtons = <>
        FieldName = 'step_no'
        Footers = <>
        Width = 38
      end
      item
        EditButtons = <>
        FieldName = 'C_WTYPE'
        Footers = <>
      end
      item
        EditButtons = <>
        FieldName = 'CUST_CODE'
        Footers = <>
        Width = 69
      end
      item
        EditButtons = <>
        FieldName = 'PROD_CODE'
        Footers = <>
      end
      item
        EditButtons = <>
        FieldName = 'PRODUCT_NAME'
        Footers = <>
        Visible = False
        Width = 92
      end
      item
        EditButtons = <>
        FieldName = 'CUT_NO'
        Footers = <>
      end
      item
        EditButtons = <>
        FieldName = 'SO_NO'
        Footers = <>
      end
      item
        EditButtons = <>
        FieldName = 'ENT_DATETIME'
        Footers = <>
        Title.Caption = 'Ͷ������'
        Visible = False
        Width = 83
      end
      item
        EditButtons = <>
        FieldName = 'SCH_COMPL_DATE'
        Footers = <>
        Title.Caption = '�ƻ��깤����'
        Visible = False
        Width = 94
      end
      item
        EditButtons = <>
        FieldName = 'EMPLOYEE_NAME'
        Footers = <>
        Title.Alignment = taCenter
        Title.Caption = '������Ա'
        Width = 60
      end
      item
        EditButtons = <>
        FieldName = 'ABBR_NAME'
        Footers = <>
        Title.Caption = '��������'
      end
      item
        EditButtons = <>
        FieldName = 'ABBR_NAME_1'
        Footers = <>
        Title.Caption = 'Ͷ�Ϲ���'
      end
      item
        EditButtons = <>
        FieldName = 'ACTION_REF'
        Footers = <>
        Title.Caption = '��ע'
        Width = 56
      end
      item
        EditButtons = <>
        FieldName = 'PARAMETER_VALUE'
        Footers = <>
        Title.Caption = '��������'
        Visible = False
        Width = 87
      end
      item
        EditButtons = <>
        FieldName = 'SAMPLE_NR'
        Footers = <>
        Width = 118
      end
      item
        EditButtons = <>
        FieldName = 'CPJS'
        Footers = <>
      end>
  end
    object Panel3: TPanel
      Left = 1
      Top = 328
      Width = 628
      Height = 41
      Align = alBottom
      TabOrder = 1
      object Button1: TButton
        Left = 272
        Top = 6
        Width = 66
        Height = 27
        Caption = '�ر�'
        TabOrder = 0
      end
    end
  end
  object DataSource1: TDataSource
    DataSet = ADOQuery1
    Left = 225
    Top = 121
  end
  object ADOQuery1: TADOQuery
    Connection = Form1.ADOConnection1
    CursorType = ctStatic
    LockType = ltReadOnly
    Parameters = <
      item
        Name = 'dtpk1'
        Attributes = [paNullable]
        DataType = ftDateTime
        NumericScale = 3
        Precision = 23
        Size = 16
        Value = Null
      end
      item
        Name = 'dtpk2'
        Attributes = [paNullable]
        DataType = ftDateTime
        NumericScale = 3
        Precision = 23
        Size = 16
        Value = Null
      end
      item
        Name = 'Rkey34'
        Attributes = [paSigned]
        DataType = ftInteger
        Precision = 10
        Size = 4
        Value = Null
      end>
    SQL.Strings = (
      
        'SELECT     TOP (100) PERCENT Data0025.MANU_PART_NUMBER, Data0025' +
        '.MANU_PART_DESC,data0025.SAMPLE_NR,'
      
        ' dbo.Data0006.WORK_ORDER_NUMBER, dbo.Data0006.ENT_DATETIME,dbo.D' +
        'ata0006.SCH_COMPL_DATE,dbo.Data0034.DEPT_CODE,'
      
        '  dbo.Data0034.DEPT_NAME, dbo.Data0048.QTY_PROD as QTY_PROD2, db' +
        'o.Data0048.PANELS,Data0048.ACTION_REF,'
      
        '    dbo.Data0048.INTIME,dbo.Data0048.OUTTIME, dbo.Data0006.CUT_N' +
        'O,dbo.data0005.EMPLOYEE_NAME,'
      
        '  dbo.Data0010.CUST_CODE, dbo.Data0008.PROD_CODE, dbo.data0492.S' +
        'O_NO,'
      
        '  Data0034_1.DEPT_CODE AS dept_code1, dbo.Data0048.STEP_NO,Data0' +
        '048.PARAMETER_VALUE,'
      '  Data0034_1.DEPT_NAME AS dept_name1, dbo.Data0008.PRODUCT_NAME,'
      
        '  dbo.Data0006.PARTS_PER_PANEL, dbo.Data0006.pnl_size,dbo.data00' +
        '06.panel_ln,dbo.data0006.panel_wd,'
      
        '  ROUND(dbo.Data0048.QTY_PROD * dbo.Data0025.unit_sq, 6) AS tota' +
        'l_sqft,'
      
        '  ROUND(dbo.Data0048.QTY_PROD * dbo.Data0006.panel_ln * dbo.Data' +
        '0006.panel_wd'
      '  * 0.000001 / dbo.Data0006.PARTS_PER_PANEL, 6) AS total_sq,'
      
        '  CASE dbo.data0048.WTYPE WHEN 0 THEN ''��������'' WHEN 2 THEN ''��������'' ' +
        'WHEN 3 THEN ''�ⷢ����'' END AS C_WTYPE,'
      
        '  Data0034_2.DEPT_CODE AS dept_code2, Data0034_2.DEPT_NAME AS de' +
        'pt_name2, D15_1.ABBR_NAME,D15_2.ABBR_NAME,'
      ''
      
        'cast(DATEDIFF(n, Data0048.INTIME, Data0048.OUTTIME)/60 as float)' +
        '+'
      
        'round(cast((DATEDIFF(mi, Data0048.INTIME, Data0048.OUTTIME) % 60' +
        ') as float) /60,2)  as ͣ��Сʱ,'
      ''
      
        ' ISNULL(D586.DataValues,0) AS DataValues,DATEADD(HH, ISNULL(D586' +
        '.DataValues,0), Data0048.INTIME) AS ModernDate34,D586.PRIORITY_n' +
        'ame,'
      ' '
      
        'dbo.Data0034.Rkey as d34Rkey,dbo.Data0006.PROD_STATUS,data0025.C' +
        'PJS,data0048.FLOW_NO,'
      
        'case when (cast(DATEDIFF(n, Data0048.INTIME, Data0048.OUTTIME)/6' +
        '0 as float)+'
      
        'round(cast((DATEDIFF(mi, Data0048.INTIME, Data0048.OUTTIME) % 60' +
        ') as float) /60,2)-Data0048.FLOW_NO-ISNULL(D586.DataValues,0))<=' +
        '0 then ''��''  else ''��'' end as YS'
      'FROM         dbo.Data0048 INNER JOIN'
      
        '    dbo.Data0006 ON dbo.Data0048.WO_PTR = dbo.Data0006.RKEY INNE' +
        'R JOIN'
      
        '    dbo.Data0034 ON dbo.Data0048.FM_DEPT_PTR = dbo.Data0034.RKEY' +
        ' INNER JOIN'
      
        '    dbo.Data0025 ON dbo.Data0006.BOM_PTR = dbo.Data0025.RKEY lef' +
        't JOIN'
      
        '    dbo.data0005 on dbo.data0048.EMPL_PTR=dbo.data0005.Rkey INNE' +
        'R JOIN'
      
        '    dbo.Data0008 ON dbo.Data0025.PROD_CODE_PTR = dbo.Data0008.RK' +
        'EY INNER JOIN'
      
        '    dbo.data0492 ON dbo.Data0006.CUT_NO = dbo.data0492.CUT_NO IN' +
        'NER JOIN'
      
        '    dbo.Data0034 AS Data0034_1 ON dbo.Data0034.BIG_DEPT_PTR = Da' +
        'ta0034_1.RKEY INNER JOIN'
      
        '    dbo.Data0010 ON dbo.data0492.COMPLETED = dbo.Data0010.RKEY I' +
        'NNER JOIN'
      
        '    dbo.data0007 ON data0007.RKEY=data0008.PR_GRP_POINTER INNER ' +
        'JOIN'
      
        '    dbo.Data0015 D15_1 ON dbo.Data0048.warehouse_ptr = D15_1.RKE' +
        'Y INNER JOIN'
      
        '    dbo.Data0015 D15_2 ON dbo.Data0492.WHOUSE_PTR=D15_2.RKEY LEF' +
        'T OUTER JOIN'
      
        '    dbo.Data0034 AS Data0034_2 ON dbo.Data0048.TO_DEPT_PTR = Dat' +
        'a0034_2.RKEY LEFT OUTER JOIN'
      
        '   dbo.Data0060 ON dbo.data0492.SO_NO = dbo.Data0060.SALES_ORDER' +
        '  LEFT OUTER JOIN'
      
        '      (SELECT     Rkey34, DataValues,TType,data0283.PRIORITY_nam' +
        'e'
      
        '        FROM          dbo.data0586  inner join data0283 on data0' +
        '586.TType=data0283.PRIORITY_CODE '
      
        '       ) AS D586 ON Data0034.RKEY = D586.Rkey34 and D586.rkey34=' +
        'data0048.FM_DEPT_PTR and Data0006.PRIORITY_CODE=D586.TType'
      'WHERE (dbo.Data0048.OUTTIME >= :dtpk1) AND'
      
        '      (dbo.Data0048.OUTTIME <= :dtpk2)  and data0034.rkey=:Rkey3' +
        '4'
      'ORDER BY ͣ��Сʱ desc,data0048.STEP_NO '
      '')
    Left = 329
    Top = 121
    object ADOQuery1MANU_PART_NUMBER: TStringField
      FieldName = 'MANU_PART_NUMBER'
      Size = 30
    end
    object ADOQuery1MANU_PART_DESC: TStringField
      FieldName = 'MANU_PART_DESC'
      Size = 80
    end
    object ADOQuery1SAMPLE_NR: TStringField
      FieldName = 'SAMPLE_NR'
      Size = 50
    end
    object ADOQuery1WORK_ORDER_NUMBER: TStringField
      FieldName = 'WORK_ORDER_NUMBER'
      Size = 22
    end
    object ADOQuery1ENT_DATETIME: TDateTimeField
      FieldName = 'ENT_DATETIME'
    end
    object ADOQuery1SCH_COMPL_DATE: TDateTimeField
      FieldName = 'SCH_COMPL_DATE'
    end
    object ADOQuery1DEPT_CODE: TStringField
      FieldName = 'DEPT_CODE'
      Size = 10
    end
    object ADOQuery1DEPT_NAME: TStringField
      FieldName = 'DEPT_NAME'
      Size = 30
    end
    object ADOQuery1QTY_PROD2: TIntegerField
      FieldName = 'QTY_PROD2'
    end
    object ADOQuery1PANELS: TIntegerField
      FieldName = 'PANELS'
    end
    object ADOQuery1ACTION_REF: TStringField
      FieldName = 'ACTION_REF'
      Size = 50
    end
    object ADOQuery1INTIME: TDateTimeField
      FieldName = 'INTIME'
    end
    object ADOQuery1OUTTIME: TDateTimeField
      FieldName = 'OUTTIME'
    end
    object ADOQuery1CUT_NO: TStringField
      FieldName = 'CUT_NO'
      FixedChar = True
      Size = 12
    end
    object ADOQuery1EMPLOYEE_NAME: TStringField
      FieldName = 'EMPLOYEE_NAME'
      Size = 16
    end
    object ADOQuery1CUST_CODE: TStringField
      FieldName = 'CUST_CODE'
      Size = 10
    end
    object ADOQuery1PROD_CODE: TStringField
      FieldName = 'PROD_CODE'
      Size = 10
    end
    object ADOQuery1SO_NO: TStringField
      FieldName = 'SO_NO'
      FixedChar = True
      Size = 12
    end
    object ADOQuery1dept_code1: TStringField
      FieldName = 'dept_code1'
      Size = 10
    end
    object ADOQuery1STEP_NO: TSmallintField
      FieldName = 'STEP_NO'
    end
    object ADOQuery1PARAMETER_VALUE: TStringField
      FieldName = 'PARAMETER_VALUE'
      Size = 50
    end
    object ADOQuery1dept_name1: TStringField
      FieldName = 'dept_name1'
      Size = 30
    end
    object ADOQuery1PRODUCT_NAME: TStringField
      FieldName = 'PRODUCT_NAME'
      Size = 30
    end
    object ADOQuery1PARTS_PER_PANEL: TFloatField
      FieldName = 'PARTS_PER_PANEL'
    end
    object ADOQuery1pnl_size: TStringField
      FieldName = 'pnl_size'
    end
    object ADOQuery1panel_ln: TFloatField
      FieldName = 'panel_ln'
    end
    object ADOQuery1panel_wd: TFloatField
      FieldName = 'panel_wd'
    end
    object ADOQuery1total_sqft: TFloatField
      FieldName = 'total_sqft'
      ReadOnly = True
    end
    object ADOQuery1total_sq: TFloatField
      FieldName = 'total_sq'
      ReadOnly = True
    end
    object ADOQuery1C_WTYPE: TStringField
      FieldName = 'C_WTYPE'
      ReadOnly = True
      Size = 8
    end
    object ADOQuery1dept_code2: TStringField
      FieldName = 'dept_code2'
      Size = 10
    end
    object ADOQuery1dept_name2: TStringField
      FieldName = 'dept_name2'
      Size = 30
    end
    object ADOQuery1ABBR_NAME: TStringField
      FieldName = 'ABBR_NAME'
      Size = 10
    end
    object ADOQuery1ABBR_NAME_1: TStringField
      FieldName = 'ABBR_NAME_1'
      Size = 10
    end
    object ADOQuery1DSDesigner: TFloatField
      FieldName = 'ͣ��Сʱ'
      ReadOnly = True
    end
    object ADOQuery1DataValues: TFloatField
      FieldName = 'DataValues'
      ReadOnly = True
    end
    object ADOQuery1ModernDate34: TDateTimeField
      FieldName = 'ModernDate34'
      ReadOnly = True
    end
    object ADOQuery1PRIORITY_name: TStringField
      FieldName = 'PRIORITY_name'
      Size = 10
    end
    object ADOQuery1d34Rkey: TIntegerField
      FieldName = 'd34Rkey'
      ReadOnly = True
    end
    object ADOQuery1PROD_STATUS: TSmallintField
      FieldName = 'PROD_STATUS'
    end
    object ADOQuery1CPJS: TStringField
      FieldName = 'CPJS'
      Size = 30
    end
    object ADOQuery1FLOW_NO: TSmallintField
      FieldName = 'FLOW_NO'
    end
    object ADOQuery1YS: TStringField
      FieldName = 'YS'
      ReadOnly = True
      Size = 2
    end
  end
end
