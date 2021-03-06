�
 TFORM_REPORT 0)� TPF0TForm_reportForm_reportLeft_Top� Width�Height�Caption   �bh�Color	clBtnFaceFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowTextFont.Height�	Font.Name   �[SO
Font.Style OldCreateOrderPositionpoScreenCenterPixelsPerInch`
TextHeight TADODataSetADS85
Connectiondm.ADOConnection1
CursorTypectStaticLockTypeltBatchOptimisticOnCalcFieldsADS85CalcFieldsCommandText�	  SELECT dbo.Data0085.TNUMBER, dbo.Data0085.REF_PART_NO, 
      dbo.Data0085.CUST_PART_NO, dbo.Data0085.CUST_PART_DESC, 
      dbo.Data0085.CUST_NAME, dbo.Data0085.quote_taxprice, 
      Data0001.CURR_NAME, Data0001.CURR_CODE, Data0085.CURR_RATE, 
      dbo.Data0085.vatax, dbo.Data0085.MARKUP, dbo.Data0085.QTE_DATE, 
      dbo.Data0085.EXPIRATION_DATE, dbo.Data0005.EMPLOYEE_NAME, 
      d05.EMPL_CODE as REP_CODE, d05.EMPLOYEE_NAME as SALES_REP_NAME, 
      Data0008.PROD_CODE, Data0008.PRODUCT_NAME, Data0264.CODE, 
      dbo.Data0264.QTE_APPROV_DESC, dbo.Data0346.ROW_NAME, 
      Data0085.CUST_ADD1, Data0085.NOTE_INFO, Data0085.rej_info, 
      Data0085.quote_price, Data0085.MATL_COST, Data0085.base_pcscost, 
      dbo.Data0085.ovhd_cost, dbo.Data0085.total_cost, data0085.rkey,
      dbo.Data0085.CRP_EST_QUANTITY, dbo.Data0085.comm_cost, 
      dbo.Data0085.SHIPPING_CHARGE, dbo.Data0085.QTE_UNITS,
	  data0085.SALES_ORDERS_ENTERED as 下单数量,
		case when TUNITS >0 then
		data0085.SALES_ORDERS_ENTERED*data0085.UNIT_LEN*data0085.UNIT_WTH*0.000001/TUNITS 
		else 0 end as 下单面积,
case Data0085.ttype2 when 0 then '新单' when 1 then '量产下单' 
when 2 then '调价' when 3 then '其它' when 4 then '特批项目' when 5 then '季度调价' end as 类型,
case Data0085.AUDITED_STATUS when 0 then '未提交'
when 1 then '待审批' when 2 then '已过期' 
when 3 then '已审批' when 4 then '被退回' end as 状态,
case Data0085.qte_unit_ptr when 1 then 'PCS'
when 2 then 'SET' end as 报价单位,data0085.rate_margin as 毛利率,
case Data0085.quote_type when 0 then '内销'
when 1 then '转厂' end as 销售方式,data0085.APPRV_DATE,
data0085.unit_len,data0085.unit_wth,data0085.TUNITS,
data0085.USHEET, data0085.QTE_USHEET, data0085.SpecialCrafts,DATA0085.OVHD_N_COST,
DATA0085.TOTAL_N_COST,DATA0085.CRPEST_N_COST,DATA0085.SHIPPING_N_CHARGE
FROM dbo.Data0085 INNER JOIN
      dbo.Data0005 ON dbo.Data0085.QBY_EMPL_PTR = dbo.Data0005.RKEY INNER JOIN
      dbo.Data0001 ON dbo.Data0085.CURR_PTR = dbo.Data0001.RKEY INNER JOIN
      dbo.Data0005 as d05 ON dbo.Data0085.SREP_PTR = d05.RKEY INNER JOIN
      dbo.Data0008 ON 
      dbo.Data0085.PROD_CODE_PTR = dbo.Data0008.RKEY INNER JOIN
      dbo.Data0264 ON 
      dbo.Data0085.PROD_ROUTE_PTR = dbo.Data0264.RKEY INNER JOIN
      dbo.Data0346 ON dbo.Data0085.ENGR_ROUTE_PTR = dbo.Data0346.RKEY
WHERE data0085.rkey = :rkey	FieldDefsNameTNUMBERDataTypeftStringSize
 NameREF_PART_NODataTypeftStringSize NameCUST_PART_NODataTypeftStringSizeP NameCUST_PART_DESCDataTypeftStringSize�  Name	CUST_NAMEDataTypeftStringSized Namequote_taxprice
AttributesfaFixed DataTypeftBCD	PrecisionSize Name	CURR_NAMEDataTypeftStringSize Name	CURR_CODEDataTypeftStringSize Name	CURR_RATE
AttributesfaFixed DataTypeftFloat Namevatax
AttributesfaFixed DataTypeftBCD	PrecisionSize NameMARKUP
AttributesfaFixed DataTypeftFloat NameQTE_DATE
AttributesfaFixed DataType
ftDateTime NameEXPIRATION_DATE
AttributesfaFixed DataType
ftDateTime NameEMPLOYEE_NAMEDataTypeftStringSize NameREP_CODEDataTypeftStringSize
 NameSALES_REP_NAMEDataTypeftStringSize Name	PROD_CODEDataTypeftStringSize
 NamePRODUCT_NAMEDataTypeftStringSize NameCODEDataTypeftStringSize
 NameQTE_APPROV_DESCDataTypeftStringSize( NameROW_NAMEDataTypeftStringSize Name	CUST_ADD1DataTypeftStringSized Name	NOTE_INFODataTypeftStringSize� Namerej_infoDataTypeftMemo Namequote_price
AttributesfaFixed DataTypeftBCD	PrecisionSize Name	MATL_COST
AttributesfaFixed DataTypeftFloat Namebase_pcscost
AttributesfaFixed DataTypeftBCD	PrecisionSize Name	ovhd_cost
AttributesfaFixed DataTypeftBCD	PrecisionSize Name
total_cost
AttributesfaFixed DataTypeftBCD	PrecisionSize Namerkey
Attributes
faReadonlyfaFixed DataType	ftAutoInc NameCRP_EST_QUANTITY
AttributesfaFixed DataTypeftFloat Name	comm_cost
AttributesfaFixed DataTypeftBCD	PrecisionSize NameSHIPPING_CHARGE
AttributesfaFixed DataTypeftFloat Name	QTE_UNITS
AttributesfaFixed DataTypeftFloat Name   NUSpeϑ
AttributesfaFixed DataType	ftInteger Name   NUSb��y
Attributes
faReadonlyfaFixed DataTypeftFloat Name   {|�W
Attributes
faReadonly DataTypeftStringSize Name   �r`
Attributes
faReadonly DataTypeftStringSize Name   �b�NUSMO
Attributes
faReadonly DataTypeftStringSize Name   �k)R�s
AttributesfaFixed DataTypeftBCD	PrecisionSize Name    �.U�e_
Attributes
faReadonly DataTypeftStringSize Name
APPRV_DATE
AttributesfaFixed DataType
ftDateTime Nameunit_len
AttributesfaFixed DataTypeftFloat Nameunit_wth
AttributesfaFixed DataTypeftFloat NameTUNITS
AttributesfaFixed DataType	ftInteger NameUSHEET
AttributesfaFixed DataTypeftBCD	PrecisionSize Name
QTE_USHEET
AttributesfaFixed DataTypeftBCD	PrecisionSize NameSpecialCraftsDataTypeftStringSize�  NameOVHD_N_COST
AttributesfaFixed DataTypeftBCD	PrecisionSize NameTOTAL_N_COST
AttributesfaFixed DataTypeftBCD	PrecisionSize NameCRPEST_N_COST
AttributesfaFixed DataTypeftBCD	PrecisionSize NameSHIPPING_N_CHARGE
AttributesfaFixed DataTypeftBCD	PrecisionSize  
ParametersNamerkey
AttributespaSigned DataType	ftInteger	Precision
SizeValueL  	StoreDefs	LeftPTop TStringFieldADS85TNUMBER	FieldNameTNUMBERSize
  TStringFieldADS85REF_PART_NO	FieldNameREF_PART_NO  TStringFieldADS85CUST_PART_NO	FieldNameCUST_PART_NOSize(  TStringFieldADS85CUST_PART_DESC	FieldNameCUST_PART_DESCSize�   TStringFieldADS85CUST_NAME	FieldName	CUST_NAMESized  TFloatFieldADS85quote_taxprice	FieldNamequote_taxprice  TStringFieldADS85CURR_NAME	FieldName	CURR_NAME  TStringFieldADS85CURR_CODE	FieldName	CURR_CODESize  TFloatFieldADS85CURR_RATE	FieldName	CURR_RATE  	TBCDField
ADS85vatax	FieldNamevatax	PrecisionSize  TFloatFieldADS85MARKUP	FieldNameMARKUP  TDateTimeFieldADS85QTE_DATE	FieldNameQTE_DATE  TDateTimeFieldADS85EXPIRATION_DATE	FieldNameEXPIRATION_DATE  TStringFieldADS85EMPLOYEE_NAME	FieldNameEMPLOYEE_NAMESize  TStringFieldADS85REP_CODE	FieldNameREP_CODESize  TStringFieldADS85SALES_REP_NAME	FieldNameSALES_REP_NAME  TStringFieldADS85PROD_CODE	FieldName	PROD_CODESize
  TStringFieldADS85PRODUCT_NAME	FieldNamePRODUCT_NAMESize  TStringField	ADS85CODE	FieldNameCODESize
  TStringFieldADS85QTE_APPROV_DESC	FieldNameQTE_APPROV_DESCSize(  TStringFieldADS85ROW_NAME	FieldNameROW_NAMESize  TStringFieldADS85CUST_ADD1	FieldName	CUST_ADD1Sized  TStringFieldADS85NOTE_INFO	FieldName	NOTE_INFOSize�  
TMemoFieldADS85rej_info	FieldNamerej_infoBlobTypeftMemo  TFloatFieldADS85quote_price	FieldNamequote_price  TFloatFieldADS85MATL_COST	FieldName	MATL_COST  TFloatFieldADS85base_pcscost	FieldNamebase_pcscost  TFloatFieldADS85ovhd_cost	FieldName	ovhd_cost  TFloatFieldADS85total_cost	FieldName
total_cost  	TBCDFieldADS85CRP_EST_QUANTITY	FieldNameCRP_EST_QUANTITY	PrecisionSize  TFloatFieldADS85comm_cost	FieldName	comm_cost  	TBCDFieldADS85SHIPPING_CHARGE	FieldNameSHIPPING_CHARGE	PrecisionSize  TFloatFieldADS85QTE_UNITS	FieldName	QTE_UNITS  TStringFieldADS85DSDesigner	FieldName   {|�WReadOnly	Size  TStringFieldADS85DSDesigner2	FieldName   �r`ReadOnly	Size  TStringFieldADS85DSDesigner3	FieldName   �b�NUSMOReadOnly	Size  TStringFieldADS85DSDesigner4	FieldName    �.U�e_ReadOnly	Size  TIntegerField	ADS85rkey	FieldNamerkeyReadOnly	  TFloatFieldADS85unit_len	FieldNameunit_len  TFloatFieldADS85unit_wth	FieldNameunit_wth  TIntegerFieldADS85TUNITS	FieldNameTUNITS  TDateTimeFieldADS85APPRV_DATE	FieldName
APPRV_DATE  	TBCDFieldADS85USHEET	FieldNameUSHEET	PrecisionSize  	TBCDFieldADS85QTE_USHEET	FieldName
QTE_USHEET	PrecisionSize  TCurrencyFieldADS85MATL_M2	FieldKindfkCalculated	FieldNameMATL_M2
Calculated	  TCurrencyFieldADS85BASE_M2	FieldKindfkCalculated	FieldNameBASE_M2
Calculated	  TCurrencyFieldADS85OVHD_M2	FieldKindfkCalculated	FieldNameOVHD_M2
Calculated	  TCurrencyFieldADS85TOTAL_M2	FieldKindfkCalculated	FieldNameTOTAL_M2
Calculated	  TCurrencyFieldADS85CRP_EST_M2	FieldKindfkCalculated	FieldName
CRP_EST_M2
Calculated	  TCurrencyFieldADS85COMM_M2	FieldKindfkCalculated	FieldNameCOMM_M2
Calculated	  TCurrencyFieldADS85SHIPPING_M2	FieldKindfkCalculated	FieldNameSHIPPING_M2
Calculated	  TCurrencyFieldADS85QTE_M2	FieldKindfkCalculated	FieldNameQTE_M2
Calculated	  TCurrencyFieldADS85QUOTE_NOTAX_M2	FieldKindfkCalculated	FieldNameQUOTE_NOTAX_M2
Calculated	  TCurrencyFieldADS85QUOTE_TAX_M2	FieldKindfkCalculated	FieldNameQUOTE_TAX_M2
Calculated	  	TBCDFieldADS85DSDesigner5	FieldName   �k)R�s	PrecisionSize  TIntegerFieldADS85DSDesigner6	FieldName   NUSpeϑ  TFloatFieldADS85DSDesigner7	FieldName   NUSb��yReadOnly	  TStringFieldADS85SpecialCrafts	FieldNameSpecialCraftsSize�   TFloatFieldADS85OVHD_N_COST	FieldNameOVHD_N_COST  TFloatFieldADS85TOTAL_N_COST	FieldNameTOTAL_N_COST  TFloatFieldADS85CRPEST_N_COST	FieldNameCRPEST_N_COST  TFloatFieldADS85SHIPPING_N_CHARGE	FieldNameSHIPPING_N_CHARGE   TDataSourceDataSource1DataSetADS85LeftpTop  TDataSourceDataSource2DataSetADS511LeftpTop0  TADODataSetADS511
Connectiondm.ADOConnection1
CursorTypectStaticLockTypeltBatchOptimisticCommandTextYSELECT sheet_BMP, pnl_bmp, pnl2_bmp
FROM dbo.Data0511
where data0511.source_ptr = :rkey
DataSourceDataSource1	FieldDefsName	sheet_BMPDataTypeftBlob Namepnl_bmpDataTypeftBlob Namepnl2_bmpDataTypeftBlob  MasterFieldsrkey
ParametersNamerkey
AttributespaSigned
paNullable DataType	ftInteger	Precision
Value   	StoreDefs	LeftQTop1 
TBlobFieldADS511sheet_BMP	FieldName	sheet_BMP  
TBlobFieldADS511pnl_bmp	FieldNamepnl_bmp  
TBlobFieldADS511pnl2_bmp	FieldNamepnl2_bmp   	TppReport	ppReport1AutoStopDataPipelineppDB432PrinterSetup.BinNameDefaultPrinterSetup.DocumentName   �N�T�b�NchHhPrinterSetup.PaperNameA4PrinterSetup.PrinterNameDefaultPrinterSetup.mmMarginBottom�PrinterSetup.mmMarginLeft�PrinterSetup.mmMarginRight�PrinterSetup.mmMarginTop�PrinterSetup.mmPaperHeight(� PrinterSetup.mmPaperWidthP4 PrinterSetup.PaperSize	SaveAsTemplate	UnitsutMillimeters
DeviceTypeScreenOutlineSettings.CreateNode	OutlineSettings.CreatePageNodes	OutlineSettings.EnabledOutlineSettings.VisiblePreviewFormSettings.WindowStatewsMaximizedPreviewFormSettings.ZoomSettingzs100PercentSavePrinterSetup	 TextSearchSettings.DefaultString
<FindText>TextSearchSettings.Enabled	Left� Top� Version7.01mmColumnWidth DataPipelineNameppDB432 TppTitleBandppTitleBand1mmBottomOffset mmHeight�9mmPrintPosition  	TppDBText	ppDBText1UserNameDBText1AutoSize		DataFieldCompany_NameDataPipelineppDB493Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size
Font.StylefsBold ParentDataPipelineTextAlignment
taCenteredTransparent	DataPipelineNameppDB493mmHeightGmmLeftY�  mmTopmmWidth�+ BandType  
TppDBImage
ppDBImage1UserNameDBImage1MaintainAspectRatioStretch		DataFieldCompany_IconDataPipelineppDB493GraphicTypeBitmapParentDataPipelineDataPipelineNameppDB493mmHeight�3mmLeft�mmTop"mmWidth'aBandType  TppSystemVariableppSystemVariable1UserNameSystemVariable1VarType
vtDateTimeFont.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style Transparent	mmHeight�mmLeftRr mmTop`*mmWidth}BandType  TppLabelppLabel2UserNameLabel2Caption   SbpS�e��: Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style TextAlignmenttaRightJustifiedTransparent	mmHeight�mmLeft�- mmTop+*mmWidth�=BandType  TppLabelppLabel3UserNameLabel19Caption   �N�T�b�Nb,gR�gchHhh�Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size
Font.StylefsBold TextAlignment
taCenteredTransparent	mmHeight�mmLeft� mmTop$#mmWidth��  BandType   TppHeaderBandppHeaderBand1PrintHeight	phDynamicmmBottomOffset mmHeight�� mmPrintPosition  TppShapeppShape1UserNameShape1ParentHeight	ParentWidth	mmHeight�� mmLeft mmTop mmWidth� BandType   	TppDBText	ppDBText2UserNameDBText2AutoSize		DataFieldTNUMBERDataPipelineppDB85Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style ParentDataPipelineTransparent	DataPipelineNameppDB85mmHeight�mmLeftjJmmTop4mmWidth�0BandType   TppLabelppLabel4UserNameLabel3Caption   �b�NUS�S: Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style TextAlignmenttaRightJustifiedTransparent	mmHeight�mmLeft+mmTop4mmWidth>BandType   TppLineppLine1UserNameLine1ParentWidth	Weight       ��?mmHeight^mmLeft mmTop�mmWidth� BandType   TppLabelppLabel5UserNameLabel4Caption   �[7bT�y: Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style TextAlignmenttaRightJustifiedTransparent	mmHeight�mmLeft�  mmTop4mmWidth�=BandType   	TppDBText	ppDBText3UserNameDBText3AutoSize		DataField	CUST_NAMEDataPipelineppDB85Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style ParentDataPipelineTransparent	DataPipelineNameppDB85mmHeight�mmLeftO�  mmTop4mmWidthA�  BandType   TppLabelppLabel6UserNameLabel5Caption   ,g�S�S: Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style TextAlignmenttaRightJustifiedTransparent	mmHeight�mmLeft+mmTop�mmWidth>BandType   TppLabelppLabel7UserNameLabel6Caption   �[7b�W�S: Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style TextAlignmenttaRightJustifiedTransparent	mmHeight�mmLeft�  mmTop�mmWidth>BandType   TppLabelppLabel8UserNameLabel7Caption   �[7bir�e�S: Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style TextAlignmenttaRightJustifiedTransparent	mmHeight�mmLeftFz mmTop�mmWidthsKBandType   	TppDBText	ppDBText4UserNameDBText4AutoSize		DataFieldREF_PART_NODataPipelineppDB85Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style ParentDataPipelineTransparent	DataPipelineNameppDB85mmHeight�mmLeftjJmmTop�mmWidth�>BandType   	TppDBText	ppDBText5UserNameDBText5AutoSize		DataFieldCUST_PART_NODataPipelineppDB85Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style ParentDataPipelineTransparent	DataPipelineNameppDB85mmHeight�mmLeftO�  mmTop�mmWidthXSBandType   	TppDBText	ppDBText6UserNameDBText6AutoSize		DataFieldCUST_PART_DESCDataPipelineppDB85Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style ParentDataPipelineTransparent	DataPipelineNameppDB85mmHeight�mmLeft� mmTop�mmWidth.hBandType   TppLineppLine2UserNameLine2PositionlpLeftWeight       ��?mmHeight'ammLeftHFmmTop mmWidthgBandType   TppLineppLine3UserNameLine3PositionlpLeftWeight       ��?mmHeight'ammLeft��  mmTop mmWidthgBandType   TppLineppLine4UserNameLine4PositionlpLeftWeight       ��?mmHeight'ammLeft6�  mmTop mmWidthgBandType   TppLabelppLabel9UserNameLabel8Caption   N�RXT: Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style TextAlignmenttaRightJustifiedTransparent	mmHeight�mmLeft�� mmTop+mmWidth�0BandType   	TppDBText	ppDBText7UserNameDBText7AutoSize		DataFieldSALES_REP_NAMEDataPipelineppDB85Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style ParentDataPipelineTransparent	DataPipelineNameppDB85mmHeight�mmLeft�� mmTop+mmWidth-)BandType   TppLineppLine5UserNameLine5PositionlpLeftWeight       ��?mmHeight'ammLeftZs mmTop mmWidthgBandType   TppLineppLine6UserNameLine6PositionlpLeftWeight       ��?mmHeight'ammLeft�� mmTop mmWidthgBandType   TppLineppLine7UserNameLine7ParentWidth	Weight       ��?mmHeight^mmLeft mmTop�/mmWidth� BandType   	TppDBText	ppDBText8UserNameDBText8AutoSize		DataFieldEMPLOYEE_NAMEDataPipelineppDB85Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style ParentDataPipelineTransparent	DataPipelineNameppDB85mmHeight�mmLeft�� mmTop�mmWidth-)BandType   TppLabel	ppLabel10UserNameLabel9Caption   �b�N�NXT: Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style TextAlignmenttaRightJustifiedTransparent	mmHeight�mmLeft�x mmTop�mmWidth>BandType   TppLabel	ppLabel11UserNameLabel11Caption   �b�N�S�V: Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style TextAlignmenttaRightJustifiedTransparent	mmHeight�mmLeft�� mmTop{LmmWidth>BandType   	TppDBText
ppDBText10UserNameDBText10AutoSize		DataField   {|�WDataPipelineppDB85Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style ParentDataPipelineTransparent	DataPipelineNameppDB85mmHeight�mmLeft� mmTop{LmmWidthsBandType   	TppDBText
ppDBText11UserNameDBText11AutoSize		DataFieldPRODUCT_NAMEDataPipelineppDB85Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style ParentDataPipelineTransparent	DataPipelineNameppDB85mmHeight�mmLeft� mmTop�4mmWidth`BandType   TppLabel	ppLabel12UserNameLabel12Caption   �N�T{|�W: Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style Transparent	mmHeight�mmLeft�� mmTop�4mmWidth>BandType   	TppDBText
ppDBText12UserNameDBText12AutoSize		DataField   �b�NUSMODataPipelineppDB85Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style ParentDataPipelineTransparent	DataPipelineNameppDB85mmHeight�mmLeftO�  mmTop{LmmWidth�BandType   TppLabel	ppLabel13UserNameLabel13Caption   �b�NUSMO: Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style TextAlignmenttaRightJustifiedTransparent	mmHeight�mmLeft�  mmTop{LmmWidth>BandType   TppLabel	ppLabel14UserNameLabel14Caption   USCQ�: Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style TextAlignmenttaRightJustifiedTransparent	mmHeight�mmLeft�mmTop�4mmWidth�0BandType   	TppDBText
ppDBText13UserNameDBText13AutoSize		DataFieldunit_lenDataPipelineppDB85Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style ParentDataPipelineTransparent	DataPipelineNameppDB85mmHeight�mmLeftjJmmTop�4mmWidth�"BandType   TppLabel	ppLabel15UserNameLabel15Caption   USCQ�[: Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style TextAlignmenttaRightJustifiedTransparent	mmHeight�mmLeft��  mmTop�4mmWidth�0BandType   	TppDBText
ppDBText14UserNameDBText14	DataFieldunit_wthDataPipelineppDB85Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style ParentDataPipelineTransparent	DataPipelineNameppDB85mmHeight�mmLeftO�  mmTop�4mmWidth.CBandType   	TppDBText
ppDBText15UserNameDBText15AutoSize		DataFieldTUNITSDataPipelineppDB85Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style ParentDataPipelineTransparent	DataPipelineNameppDB85mmHeight�mmLeftjJmmTop{LmmWidth�BandType   TppLabel	ppLabel16UserNameLabel16Caption   US�Npeϑ: Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style Transparent	mmHeight�mmLeft+mmTop{LmmWidth>BandType   TppLineppLine8UserNameLine8ParentWidth	Weight       ��?mmHeight	mmLeft mmTopYHmmWidth� BandType   TppLabel	ppLabel17UserNameLabel17Caption   �b�N�eg: Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style TextAlignmenttaRightJustifiedTransparent	mmHeight�mmLeft�x mmTop�4mmWidth>BandType   TppLabel	ppLabel18UserNameLabel18Caption   �[E��b�N: Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style TextAlignmenttaRightJustifiedTransparent	mmHeight�mmLeft�x mmTop{LmmWidth�=BandType   	TppDBText
ppDBText16UserNameDBText16AutoSize		DataFieldQTE_DATEDataPipelineppDB85Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style ParentDataPipelineTransparent	DataPipelineNameppDB85mmHeight�mmLeft�� mmTop�4mmWidthtEBandType   	TppDBText
ppDBText17UserNameDBText17AutoSize		DataFieldquote_taxpriceDataPipelineppDB85Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style ParentDataPipelineTransparent	DataPipelineNameppDB85mmHeight�mmLeft�� mmTop{LmmWidth�"BandType   TppLineppLine9UserNameLine9ParentWidth	Weight       ��?mmHeight"mmLeft mmTop`mmWidth� BandType   TppLineppLine10UserNameLine10PositionlpLeftWeight       ��?mmHeightHFmmLeft#v mmTop�mmWidth�BandType   TppLineppLine11UserNameLine101PositionlpLeftWeight       ��?mmHeightHFmmLeft�� mmTop�mmWidth<BandType   TppImageppImage1UserNameImage1MaintainAspectRatioStretch	mmHeightG�  mmLeftb� mmTop��  mmWidthvB BandType   TppMemoppMemo1UserNameMemo1CaptionMemo1CharWrapFont.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style Stretch	Transparent	mmHeight	�  mmLeftmmTop=�  mmWidth�  BandType mmBottomOffset mmOverFlowOffset mmStopPosition 	mmLeading   TppMemoppMemo2UserNameMemo2CaptionMemo2CharWrapFont.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style Stretch	Transparent	mmHeight��  mmLeft6�  mmTop4�  mmWidth�  BandType mmBottomOffset mmOverFlowOffset mmStopPosition 	mmLeading   TppLabel	ppLabel19UserNameLabel10Caption   �b�N�SpeFont.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style Transparent	mmHeight�mmLeft"mmTop��  mmWidth�6BandType   TppLabel	ppLabel20UserNameLabel20Caption   <PFont.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.NameArial	Font.Size

Font.Style Transparent	mmHeight�mmLeft�  mmTop��  mmWidthpBandType   TppLabel	ppLabel21UserNameLabel21Caption   yr+R�]z�Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style Transparent	mmHeight�mmLeft,$mmTop� mmWidth�6BandType   TppLabel	ppLabel22UserNameLabel22Caption   ���{!j_Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style Transparent	mmHeight�mmLeft��  mmTop%� mmWidth�6BandType   TppLabel	ppLabel23UserNameLabel23Caption	   PCS成本Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style Transparent	mmHeight�mmLeft� mmTop-� mmWidth�0BandType   TppLabel	ppLabel24UserNameLabel24Caption   �ks^s|b,gFont.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style Transparent	mmHeight�mmLeft<Z mmTop-� mmWidth7DBandType   TppSubReportppSubReport1UserName
SubReport1	ExpandAllNewPrintJobOutlineSettings.CreateNode	TraverseAllDataDataPipelineNameppDB253mmHeight�mmLeft mmTop`mmWidth� BandType mmBottomOffset mmOverFlowOffset mmStopPosition  TppChildReportppChildReport1AutoStopDataPipelineppDB253PrinterSetup.BinNameDefaultPrinterSetup.DocumentName   �N�T�b�NchHhPrinterSetup.PaperNameA4PrinterSetup.PrinterNameDefaultPrinterSetup.mmMarginBottom�PrinterSetup.mmMarginLeft�PrinterSetup.mmMarginRight�PrinterSetup.mmMarginTop�PrinterSetup.mmPaperHeight(� PrinterSetup.mmPaperWidthP4 PrinterSetup.PaperSize	UnitsutMillimetersVersion7.01mmColumnWidth DataPipelineNameppDB253 TppTitleBandppTitleBand2mmBottomOffset mmHeight�mmPrintPosition  TppLineppLine12UserNameLine12ParentHeight	ParentWidth	PositionlpBottomWeight       ��?mmHeight�mmLeft mmTop mmWidth� BandType  TppLabel	ppLabel25UserNameLabel25Caption   ir�exFont.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style Transparent	mmHeight�mmLeft�4mmTop+mmWidth�6BandType  TppLabel	ppLabel26UserNameLabel26Caption   ir�eĉ<hFont.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style Transparent	mmHeight�mmLeft��  mmTop+mmWidth�6BandType  TppLabel	ppLabel27UserNameLabel27Caption   �O�^FUFont.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style Transparent	mmHeight�mmLefto� mmTop+mmWidthW)BandType  TppLineppLine17UserNameLine17ParentHeight	PositionlpLeftWeight       ��?mmHeight�mmLeft��  mmTop mmWidth^BandType  TppLineppLine18UserNameLine18ParentHeight	PositionlpLeftWeight       ��?mmHeight�mmLeft�g mmTop mmWidth^BandType  TppLineppLine13UserNameLine29ParentHeight	PositionlpLeftWeight       ��?mmHeight�mmLeft+ mmTop mmWidth4BandType  TppLabel	ppLabel28UserNameLabel50Caption   US�NFont.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style Transparent	mmHeight�mmLeft,0 mmTop+mmWidth�BandType  TppLineppLine14UserNameLine31ParentHeight	PositionlpLeftWeight       ��?mmHeight�mmLeft� mmTop mmWidth^BandType  TppLabel	ppLabel29UserNameLabel502Caption   B\�S�k�OFont.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style Transparent	mmHeight�mmLeft'm mmTop+mmWidth�6BandType   TppDetailBandppDetailBand2mmBottomOffset mmHeight�mmPrintPosition  TppLineppLine15UserNameLine13ParentHeight	ParentWidth	PositionlpBottomWeight       ��?mmHeight�mmLeft mmTop mmWidth� BandType  	TppDBText
ppDBText21UserNameDBText21AutoSize		DataFieldINV_PART_NUMBERDataPipelineppDB253Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style Transparent	DataPipelineNameppDB253mmHeight�mmLeftEmmTopmmWidth~�  BandType  	TppDBText
ppDBText22UserNameDBText22	DataFieldINV_PART_DESCRIPTIONDataPipelineppDB253Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style Transparent	DataPipelineNameppDB253mmHeight�mmLeftֳ  mmTopmmWidthV BandType  	TppDBText
ppDBText23UserNameDBText23AutoSize		DataField	ABBR_NAMEDataPipelineppDB253Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style Transparent	DataPipelineNameppDB253mmHeight�mmLeft�� mmTopmmWidth�BandType  TppLineppLine16UserNameLine14ParentHeight	PositionlpLeftWeight       ��?mmHeight�mmLeft��  mmTop mmWidthM	BandType  TppLineppLine19UserNameLine15ParentHeight	PositionlpLeftWeight       ��?mmHeight�mmLeft�g mmTop mmWidthM	BandType  TppLineppLine20UserNameLine30ParentHeight	PositionlpLeftWeight       ��?mmHeight�mmLeft+ mmTop mmWidthM	BandType  	TppDBText	ppDBText9UserNameDBText37AutoSize		DataFieldpriceDataPipelineppDB253Font.CharsetDEFAULT_CHARSET
Font.ColorclWindowText	Font.Name   �[SO	Font.Size

Font.Style TextAlignmenttaRightJustifiedTransparent	DataPipelineNameppDB253mmHeight�mmLeft�( mmTopmmWidth$#BandType  TppLabel	ppLabel30UserNameLabel501CaptionRMBFont.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style Transparent	mmHeight�mmLeftM mmTopmmWidth�BandType  TppLineppLine21UserNameLine32ParentHeight	PositionlpLeftWeight       ��?mmHeight�mmLeft� mmTop mmWidthM	BandType  	TppDBText
ppDBText18UserNameDBText38AutoSize		DataFieldQTY_BOMDataPipelineppDB253Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style Transparent	DataPipelineNameppDB253mmHeight�mmLeftZs mmTopmmWidth�0BandType   TppSummaryBandppSummaryBand2mmBottomOffset mmHeight mmPrintPosition   TraCodeModuleraCodeModule1ProgramStream
        TppLineppLine22UserNameLine20ParentWidth	Weight       ��?mmHeight^mmLeft mmTop� mmWidth� BandType   TppLineppLine25UserNameLine25Weight       ��?mmHeight	mmLeft mmTop�  mmWidth8� BandType   TppLabel	ppLabel31UserNameLabel101Caption   �b�N�SpeFont.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style Transparent	mmHeight�mmLeftG�  mmTop��  mmWidth�6BandType   TppLabel	ppLabel49UserNameLabel201Caption   <PFont.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.NameArial	Font.Size

Font.Style Transparent	mmHeight�mmLeftu mmTopw�  mmWidthpBandType    TppDetailBandppDetailBand1mmBottomOffset mmHeight�mmPrintPosition  TppLineppLine23UserNameLine19ParentHeight	PositionlpRightWeight       ��?mmHeight�mmLefth� mmTop mmWidth�1BandType  	TppDBText
ppDBText19UserNameDBText9AutoSize		DataField
ADDER_NAMEDataPipelineppDB432Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style Transparent	DataPipelineNameppDB432mmHeight�mmLeft^mmTopmmWidth~�  BandType  	TppDBText
ppDBText20UserNameDBText18AutoSize		DataField	cac_meothDataPipelineppDB432Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style Transparent	DataPipelineNameppDB432mmHeight�mmLeft��  mmTopmmWidth�BandType  	TppDBText
ppDBText24UserNameDBText19AutoSize		DataFieldN_AMOUNTDataPipelineppDB432Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style Transparent	DataPipelineNameppDB432mmHeight�mmLeft�	 mmTopmmWidth�7BandType  	TppDBText
ppDBText25UserNameDBText20AutoSize		DataFieldcost_total_m2DataPipelineppDB432Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style Transparent	DataPipelineNameppDB432mmHeight�mmLeft�c mmTop�mmWidthJZBandType  TppLineppLine24UserNameLine11ParentHeight	PositionlpLeftWeight       ��?mmHeight�mmLeft mmTop mmWidth�3BandType   TppFooterBandppFooterBand1mmBottomOffset mmHeight�xmmPrintPosition  	TppDBMemo	ppDBMemo2UserNameDBMemo2CharWrap		DataField	NOTE_INFODataPipelineppDB85Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style ParentDataPipelineStretch	Transparent	DataPipelineNameppDB85mmHeightsKmmLeft�7mmTop�mmWidth�� BandTypemmBottomOffset mmOverFlowOffset mmStopPosition 	mmLeading   TppLabel	ppLabel32UserNameLabel32Caption   Y�l: Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style TextAlignmenttaRightJustifiedTransparent	mmHeight�mmLeftM	mmTop�mmWidth!BandType  	TppDBText
ppDBText28UserNameDBText28AutoSize		DataFieldEMPLOYEE_NAMEDataPipelineppDB85Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style ParentDataPipelineTransparent	DataPipelineNameppDB85mmHeight�mmLeft�3mmTopIemmWidthW)BandType  TppLabel	ppLabel33UserNameLabel33Caption   6RUS: Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style TextAlignmenttaRightJustifiedTransparent	mmHeightxmmLeftV
mmTopIemmWidth"BandType  TppLineppLine26UserNameLine21Weight       ��?mmHeightmmLeft�/mmTop�tmmWidthPGBandType  TppLabel	ppLabel34UserNameLabel34Caption   6RUS�eg: Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style TextAlignmenttaRightJustifiedTransparent	mmHeightxmmLeft�ummTopIemmWidth>BandType  TppLineppLine27UserNameLine22Weight       ��?mmHeight"mmLeft�  mmTop�tmmWidth:�  BandType  TppLabel	ppLabel35UserNameLabel35Caption   �[8h: Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style TextAlignmenttaRightJustifiedTransparent	mmHeightxmmLeftT mmTopIemmWidth"BandType  TppLineppLine28UserNameLine23Weight       ��?mmHeightmmLeftt mmTop�tmmWidth�QBandType  TppLabel	ppLabel40UserNameLabel40Caption    gT�[8h: Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style TextAlignmenttaRightJustifiedTransparent	mmHeightxmmLeftB� mmTopIemmWidth>BandType  TppLineppLine57UserNameLine27Weight       ��?mmHeight	mmLeft mmTop�tmmWidth�MBandType  	TppDBText
ppDBText31UserNameDBText31AutoSize		DataField
APPRV_DATEDataPipelineppDB85Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style ParentDataPipelineTransparent	DataPipelineNameppDB85mmHeight�mmLeft��  mmTopIemmWidth}BandType  TppLineppLine58UserNameLine28Weight       ��?mmHeight	mmLeft�� mmTop�tmmWidth�UBandType  TppLabel	ppLabel48UserNameLabel401Caption   �[8h�eg: Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style TextAlignmenttaRightJustifiedTransparent	mmHeightxmmLeft�b mmTopIemmWidth>BandType  TppLabel	ppLabel37UserNameLabel56Caption   dk�b�NUS�N�Q�O(u, ^\lQ�S:g�[, N�_Y O&TR��vz�vsQ#��NFont.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size
Font.StylefsBold Transparent	mmHeight]mmLeft^mmTop"mmWidthf� BandType   TppSummaryBandppSummaryBand1PrintHeight	phDynamicmmBottomOffset mmHeight�� mmPrintPosition  TppShapeppShape2UserNameShape2ParentHeight	ParentWidth	StretchWithParent	mmHeight�� mmLeft mmTop mmWidth� BandType  TppSubReportppSubReport3UserName
SubReport2	ExpandAllNewPrintJobOutlineSettings.CreateNode	ParentWidthTraverseAllDataDataPipelineNameppDB8501mmHeight�MmmLeft+mmTopN�  mmWidth�& BandTypemmBottomOffset mmOverFlowOffset mmStopPosition  TppChildReportppChildReport3AutoStopDataPipelineppDB8501PrinterSetup.BinNameDefaultPrinterSetup.DocumentName   �N�T�b�NchHhPrinterSetup.PaperNameA4PrinterSetup.PrinterNameDefaultPrinterSetup.mmMarginBottom�PrinterSetup.mmMarginLeft�PrinterSetup.mmMarginRight�PrinterSetup.mmMarginTop�PrinterSetup.mmPaperHeight(� PrinterSetup.mmPaperWidthP4 PrinterSetup.PaperSize	UnitsutMillimetersVersion7.01mmColumnWidth DataPipelineNameppDB8501 TppTitleBandppTitleBand5mmBottomOffset mmHeight mmPrintPosition   TppDetailBandppDetailBand5mmBottomOffset mmHeight�mmPrintPosition  	TppDBText
ppDBText81UserNameDBText81	DataField	Cost_NameDataPipelineppDB8501Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.NameArial	Font.Size	
Font.Style TextAlignmenttaRightJustifiedTransparent	DataPipelineNameppDB8501mmHeightmmLeftpmmTop mmWidth.CBandType  TppLabel
ppLabel105UserNameLabel105Caption   �Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.NameArial	Font.Size	
Font.Style Transparent	mmHeightmmLeft�UmmTop mmWidth�BandType  	TppDBText
ppDBText82UserNameDBText82	DataFieldCostDataPipelineppDB8501Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.NameArial	Font.Size	
Font.Style Transparent	DataPipelineNameppDB8501mmHeightxmmLeft�ommTop	mmWidth.CBandType  	TppDBText
ppDBText83UserNameDBText83	DataField
Total_CostDataPipelineppDB8501Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.NameArial	Font.Size	
Font.Style Transparent	DataPipelineNameppDB8501mmHeightxmmLeft6�  mmTop	mmWidth.CBandType   TppSummaryBandppSummaryBand5mmBottomOffset mmHeight�mmPrintPosition  TppLabel
ppLabel106UserNameLabel106Caption    g�e�b�N�Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.NameArial	Font.Size	
Font.Style Transparent	mmHeightxmmLeft5%mmTopmmWidth?BandType  	TppDBCalc	ppDBCalc1UserNameDBCalc1	DataFieldCostDataPipelineppDB8501Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.NameArial	Font.Size

Font.Style Transparent	VisibleDataPipelineNameppDB8501mmHeight�mmLeftC mmTop mmWidth.CBandType  	TppDBCalc	ppDBCalc2UserNameDBCalc2	DataField
Total_CostDataPipelineppDB8501Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.NameArial	Font.Size

Font.Style Transparent	VisibleDataPipelineNameppDB8501mmHeight�mmLeft�� mmTop mmWidth.CBandType  TppVariableppVariable1UserName	Variable2	CalcOrder Font.CharsetDEFAULT_CHARSET
Font.ColorclWindowText	Font.NameArial	Font.Size	
Font.Style Transparent	mmHeightxmmLeft�qmmTopmmWidth�4BandType  TppVariableppVariable3UserName	Variable3	CalcOrderFont.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.NameArial	Font.Size	
Font.Style Transparent	mmHeightxmmLeft6�  mmTopmmWidth�3BandType   TraCodeModuleraCodeModule2ProgramStream
�  TraEventHandlerProgramNameVariable3OnCalcProgramTypettProcedureSourceqprocedure Variable3OnCalc(var Value: Variant);
begin

Value := DBCalc2.value + DB85['QUOTE_TAX_M2'];

end;
ComponentName	Variable3	EventNameOnCalcEventID! TraEventHandlerProgramNameVariable2OnCalcProgramTypettProcedureSourcevprocedure Variable2OnCalc(var Value: Variant);
begin

Value := DB85['quote_taxprice'] + DBCalc1.value; 


end;
ComponentName	Variable2	EventNameOnCalcEventID!      TppLabel	ppLabel38UserNameLabel28Caption   Pg�e�N: Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style TextAlignmenttaRightJustifiedTransparent	mmHeight�mmLeft�3mmTop>&mmWidth�0BandType  	TppDBText
ppDBText26UserNameDBText24AutoSize		DataField	MATL_COSTDataPipelineppDB85Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style ParentDataPipelineTransparent	DataPipelineNameppDB85mmHeight�mmLeft�tmmTop>&mmWidth�7BandType  TppLabel	ppLabel39UserNameLabel29Caption   �W,g�N: Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style TextAlignmenttaRightJustifiedTransparent	mmHeight�mmLeft�3mmTop�8mmWidth�0BandType  	TppDBText
ppDBText27UserNameDBText25AutoSize		DataFieldbase_pcscostDataPipelineppDB85Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style ParentDataPipelineTransparent	DataPipelineNameppDB85mmHeight�mmLeft�tmmTop�8mmWidth�7BandType  TppLabel	ppLabel41UserNameLabel30Caption   �]z��N: Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style TextAlignmenttaRightJustifiedTransparent	mmHeight�mmLeft�3mmTopsKmmWidth�0BandType  	TppDBText
ppDBText29UserNameDBText26AutoSize		DataFieldOVHD_N_COSTDataPipelineppDB85Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style ParentDataPipelineTransparent	DataPipelineNameppDB85mmHeight�mmLeft�tmmTopsKmmWidth�0BandType  TppLabel	ppLabel42UserNameLabel31Caption   ;`b,g: Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style Transparent	mmHeight�mmLeft�3mmTop_mmWidth�0BandType  	TppDBText
ppDBText30UserNameDBText27AutoSize		DataFieldTOTAL_N_COSTDataPipelineppDB85Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style ParentDataPipelineTransparent	DataPipelineNameppDB85mmHeight�mmLeft�tmmTop_mmWidth�7BandType  TppLabel	ppLabel43UserNameLabel36Caption   �N<hR�gN+TzFont.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.StylefsBold Transparent	mmHeight�mmLeftEmmToppmmWidth<aBandType  TppLineppLine59UserNameLine24Weight       ��?mmHeight	mmLeft	mmTop
 mmWidth�* BandType  TppLabel	ppLabel44UserNameLabel38Caption   �b�^b,g: Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style TextAlignmenttaRightJustifiedTransparent	mmHeight�mmLefth&mmTop�qmmWidth�=BandType  	TppDBText
ppDBText32UserNameDBText29AutoSize		DataFieldCRP_EST_QUANTITYDataPipelineppDB85Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style ParentDataPipelineTransparent	DataPipelineNameppDB85mmHeight�mmLeft�tmmTop�qmmWidth�BandType  TppLabel	ppLabel45UserNameLabel39Caption   b,g�k)R�s% : Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style TextAlignmenttaRightJustifiedTransparent	mmHeight�mmLeft�mmTopS�  mmWidth�RBandType  	TppDBText
ppDBText33UserNameDBText30AutoSize		DataFieldMARKUPDataPipelineppDB85Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style ParentDataPipelineTransparent	DataPipelineNameppDB85mmHeight�mmLeft�tmmTopS�  mmWidth�BandType  TppLabel	ppLabel46UserNameLabel41Caption   ё��/ �b�NUSMOFont.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style Transparent	mmHeight�mmLeft�smmTopxmmWidthLYBandType  TppLineppLine60UserNameLine26Weight       ��?mmHeight	mmLeft	mmTop��  mmWidth�* BandType  TppLabel	ppLabel47UserNameLabel42Caption   ё��/ �ks^s|Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style Transparent	mmHeight�mmLeft��  mmTopxmmWidth�KBandType  	TppDBText
ppDBText34UserNameDBText32AutoSize		DataFieldquote_taxpriceDataPipelineppDB85Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style ParentDataPipelineTransparent	DataPipelineNameppDB85mmHeight�mmLeft�tmmTop��  mmWidth�"BandType  TppLabel	ppLabel97UserNameLabel43Caption   �b�N'�^: Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style TextAlignmenttaRightJustifiedTransparent	mmHeight�mmLeftM	mmTop�) mmWidth>BandType  	TppDBText
ppDBText35UserNameDBText33AutoSize		DataField	CURR_NAMEDataPipelineppDB85Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style ParentDataPipelineTransparent	DataPipelineNameppDB85mmHeight�mmLeft�XmmTop�) mmWidth�BandType  	TppDBText
ppDBText71UserNameDBText34AutoSize		DataField	CURR_RATEDataPipelineppDB85Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style ParentDataPipelineTransparent	DataPipelineNameppDB85mmHeight�mmLeft�XmmTopC< mmWidth<BandType  TppLabel	ppLabel98UserNameLabel44Caption   Gl�s: Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style TextAlignmenttaRightJustifiedTransparent	mmHeight�mmLeft,$mmTopC< mmWidth"BandType  TppLabel	ppLabel99UserNameLabel45Caption   �X<Pz% : Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style TextAlignmenttaRightJustifiedTransparent	mmHeight�mmLeft�mmTop mmWidth�6BandType  	TppDBText
ppDBText72UserNameDBText35AutoSize		DataFieldvataxDataPipelineppDB85Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style ParentDataPipelineTransparent	DataPipelineNameppDB85mmHeight�mmLeft�XmmTop mmWidth<BandType  TppLabel
ppLabel100UserNameLabel46Caption	   ���{'�^:   �Nl^Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style Transparent	mmHeight�mmLeftK= mmTopxmmWidth�mBandType  TppLabel
ppLabel101UserNameLabel47Caption   �b�N+Tz�S^: Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style TextAlignmenttaRightJustifiedTransparent	mmHeight�mmLeft�
mmTop��  mmWidthLYBandType  	TppDBMemo	ppDBMemo1UserNameDBMemo1CharWrap	DataFieldrej_infoDataPipelineppDB85Font.CharsetDEFAULT_CHARSET
Font.ColorclWindowText	Font.Name   �e�[SO	Font.Size

Font.Style ParentDataPipelineStretch	Transparent	DataPipelineNameppDB85mmHeight	�  mmLeft�� mmTop!mmWidth� BandTypemmBottomOffset mmOverFlowOffset mmStopPosition 	mmLeading   TppLabel
ppLabel102UserNameLabel37Caption   B\�S�VFont.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.StylefsBold Transparent	mmHeight�mmLeft�x mmTopgmmWidthW)BandType  TppLabel
ppLabel103UserNameLabel1Caption   �b�N( ,gMO^) : Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style TextAlignmenttaRightJustifiedTransparent	mmHeight�mmLeft�mmTop��  mmWidthvYBandType  	TppDBText
ppDBText73UserName	DBText301AutoSize		DataField	QTE_UNITSDataPipelineppDB85Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style ParentDataPipelineTransparent	DataPipelineNameppDB85mmHeight�mmLeft�smmTop��  mmWidth�"BandType  TppLineppLine61UserNameLine33PositionlpLeftWeight       ��?mmHeightY mmLeft��  mmTop!mmWidthM	BandType  TppLineppLine62UserNameLine34PositionlpLeftWeight       ��?mmHeight�, mmLeft�+ mmTop
 mmWidthV
BandType  TppLineppLine63UserNameLine35Weight       ��?mmHeight^mmLeft��  mmTopl" mmWidth�WBandType  	TppDBText
ppDBText74UserNameDBText39	DataFieldMATL_M2DataPipelineppDB85DisplayFormat#,0.00;-#,0.00Font.CharsetDEFAULT_CHARSET
Font.ColorclWindowText	Font.Name   �[SO	Font.Size

Font.Style ParentDataPipelineTransparent	DataPipelineNameppDB85mmHeight�mmLeft>�  mmTop5%mmWidth%BBandType  	TppDBText
ppDBText75UserNameDBText40	DataFieldBASE_M2DataPipelineppDB85DisplayFormat#,0.00;-#,0.00Font.CharsetDEFAULT_CHARSET
Font.ColorclWindowText	Font.Name   �[SO	Font.Size

Font.Style ParentDataPipelineTransparent	DataPipelineNameppDB85mmHeight�mmLeft>�  mmTop�8mmWidth.CBandType  	TppDBText
ppDBText76UserNameDBText41	DataFieldOVHD_M2DataPipelineppDB85DisplayFormat#,0.00;-#,0.00Font.CharsetDEFAULT_CHARSET
Font.ColorclWindowText	Font.Name   �[SO	Font.Size

Font.Style ParentDataPipelineTransparent	DataPipelineNameppDB85mmHeight�mmLeft>�  mmTop{LmmWidth.CBandType  	TppDBText
ppDBText77UserNameDBText42	DataFieldTOTAL_M2DataPipelineppDB85DisplayFormat#,0.00;-#,0.00Font.CharsetDEFAULT_CHARSET
Font.ColorclWindowText	Font.Name   �[SO	Font.Size

Font.Style ParentDataPipelineTransparent	DataPipelineNameppDB85mmHeight�mmLeft>�  mmTop_mmWidth.CBandType  	TppDBText
ppDBText78UserNameDBText43	DataField
CRP_EST_M2DataPipelineppDB85DisplayFormat#,0.00;-#,0.00Font.CharsetDEFAULT_CHARSET
Font.ColorclWindowText	Font.Name   �[SO	Font.Size

Font.Style ParentDataPipelineTransparent	DataPipelineNameppDB85mmHeight�mmLeft>�  mmTop�qmmWidth.CBandType  	TppDBText
ppDBText79UserNameDBText44	DataFieldQTE_M2DataPipelineppDB85DisplayFormat#,0.00;-#,0.00Font.CharsetDEFAULT_CHARSET
Font.ColorclWindowText	Font.Name   �[SO	Font.Size

Font.Style ParentDataPipelineTransparent	DataPipelineNameppDB85mmHeight�mmLeft-�  mmTop�  mmWidth.CBandType  	TppDBText
ppDBText80UserNameDBText45	DataFieldQUOTE_TAX_M2DataPipelineppDB85DisplayFormat#,0.00;-#,0.00Font.CharsetDEFAULT_CHARSET
Font.ColorclWindowText	Font.Name   �[SO	Font.Size

Font.Style ParentDataPipelineTransparent	DataPipelineNameppDB85mmHeight�mmLeft6�  mmTopı  mmWidth.CBandType  TppLabel
ppLabel104UserNameLabel55Caption   s^s|�N<hFont.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size
Font.StylefsBold Transparent	mmHeight�mmLeft`�  mmTop� mmWidth>BandType  TppLabel	ppLabel36UserNameLabel25Caption   yr�k�]z�: Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.StylefsBold TextAlignmenttaRightJustifiedTransparent	mmHeight�mmLeft	mmTop"W mmWidth.CBandType  	TppDBMemo	ppDBMemo5UserNameDBMemo3CharWrap	DataFieldSpecialCraftsDataPipelineppDB85Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style ParentDataPipelineStretch	Transparent	DataPipelineNameppDB85mmHeight_mmLeft7DmmTop3Y mmWidth��  BandTypemmBottomOffset mmOverFlowOffset mmStopPosition 	mmLeading   TppLineppLine64UserNameLine64Weight       ��?mmHeightmmLeft mmTop�J mmWidth�- BandType  TppSubReportppSubReport4UserName
SubReport3	ExpandAllNewPrintJobOutlineSettings.CreateNode	ParentWidthTraverseAllDataDataPipelineNameppDB061mmHeight	�  mmLeft1: mmTop
 mmWidth��  BandTypemmBottomOffset mmOverFlowOffset mmStopPosition  TppChildReportppChildReport4AutoStopDataPipelineppDB061PrinterSetup.BinNameDefaultPrinterSetup.DocumentName   �N�T�b�NchHhPrinterSetup.PaperNameA4PrinterSetup.PrinterNameDefaultPrinterSetup.mmMarginBottom�PrinterSetup.mmMarginLeft�PrinterSetup.mmMarginRight�PrinterSetup.mmMarginTop�PrinterSetup.mmPaperHeight(� PrinterSetup.mmPaperWidthP4 PrinterSetup.PaperSize	UnitsutMillimetersVersion7.01mmColumnWidth DataPipelineNameppDB061 TppTitleBandppTitleBand6mmBottomOffset mmHeight�mmPrintPosition  TppShapeppShape5UserNameShape3mmHeight�mmLeft mmTopmmWidth޴  BandType  TppLabel
ppLabel107UserNameLabel58Caption   !jwQ{|�WFont.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style Transparent	mmHeight�mmLeft4mmTop"mmWidth�6BandType  TppLineppLine65UserNameLine45PositionlpLeftWeight       ��?mmHeight�mmLeft%BmmTopmmWidthV
BandType  TppLabel
ppLabel108UserNameLabel59Caption   WYpeFont.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style Transparent	mmHeight�mmLeftaImmTop"mmWidth�BandType  TppLineppLine66UserNameLine47PositionlpLeftWeight       ��?mmHeight�mmLeft�nmmTopmmWidthV
BandType  TppLabel
ppLabel109UserNameLabel60Caption   9�(uFont.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style Transparent	mmHeight�mmLeft:�  mmTop"mmWidthsBandType   TppDetailBandppDetailBand6mmBottomOffset mmHeight�mmPrintPosition  	TppDBText
ppDBText84UserNameDBText84AutoSize		DataFieldCATEGORYDataPipelineppDB061Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style ParentDataPipelineTextAlignment
taCenteredTransparent	DataPipelineNameppDB061mmHeight�mmLeft+mmTopmmWidth�7BandType  	TppDBText
ppDBText85UserNameDBText85AutoSize	BlankWhenZero		DataFieldAMOUNTDataPipelineppDB061Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style TextAlignment
taCenteredTransparent	DataPipelineNameppDB061mmHeight�mmLeft}mmTopmmWidth�)BandType  TppLineppLine67UserNameLine46PositionlpLeftWeight       ��?mmHeight�mmLeft mmTop mmWidthV
BandType  TppLineppLine68UserNameLine48PositionlpLeftWeight       ��?mmHeight�mmLeft�nmmTop mmWidthBandType  TppLineppLine69UserNameLine49PositionlpLeftWeight       ��?mmHeight�mmLeft%BmmTop mmWidthV
BandType  TppLineppLine70UserNameLine50PositionlpLeftWeight       ��?mmHeight�mmLeftֳ  mmTop mmWidthEBandType  TppLineppLine71UserNameLine501PositionlpBottomWeight       ��?mmHeight4mmLeft mmTopgmmWidth޴  BandType  	TppDBText
ppDBText86UserNameDBText86	DataField	Mould_setDataPipelineppDB061Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.NameArial	Font.Size

Font.Style TextAlignment
taCenteredTransparent	DataPipelineNameppDB061mmHeight�mmLeft?EmmTopmmWidth>&BandType   TppSummaryBandppSummaryBand6mmBottomOffset mmHeight�mmPrintPosition  	TppDBCalc	ppDBCalc3UserNameDBCalc3	DataFieldAMOUNTDataPipelineppDB061Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style TextAlignment
taCenteredTransparent	DataPipelineNameppDB061mmHeight�mmLeft�smmTopmmWidth�;BandType  TppLineppLine72UserNameLine52PositionlpLeftWeight       ��?mmHeight�mmLeft mmTop mmWidthV
BandType  TppLineppLine73UserNameLine53PositionlpLeftWeight       ��?mmHeight�mmLeft�nmmTop mmWidthV
BandType  TppLineppLine74UserNameLine54PositionlpLeftWeight       ��?mmHeight�mmLeft%BmmTop mmWidthV
BandType  TppLineppLine75UserNameLine502PositionlpLeftWeight       ��?mmHeight�mmLeftֳ  mmTop mmWidth^BandType  TppLabel
ppLabel110UserNameLabel61Caption   T��Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style Transparent	mmHeight�mmLeft�mmTopmmWidthsBandType  TppLineppLine76UserNameLine56PositionlpBottomWeight       ��?mmHeight4mmLeft mmTopxmmWidth޴  BandType  	TppDBCalc	ppDBCalc4UserNameDBCalc4	DataField	Mould_setDataPipelineppDB061Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.NameArial	Font.Size

Font.Style TextAlignment
taCenteredTransparent	DataPipelineNameppDB061mmHeight�mmLeftHFmmTopmmWidth,$BandType      TraCodeModuleraCodeModule3ProgramStream
       TppDBPipelineppDB511
DataSourceDataSource2OpenDataSourceRangeEndreCurrentRecord
RangeBeginrbCurrentRecordUserNameDB511Left� Top2MasterDataPipelineNameppDB85 TppFieldppDB511ppField1
FieldAlias	sheet_BMP	FieldName	sheet_BMPFieldLength DataTypedtBLOBDisplayWidth
Position 
SearchableSortable  TppFieldppDB511ppField2
FieldAliaspnl_bmp	FieldNamepnl_bmpFieldLength DataTypedtBLOBDisplayWidth
Position
SearchableSortable  TppFieldppDB511ppField3
FieldAliaspnl2_bmp	FieldNamepnl2_bmpFieldLength DataTypedtBLOBDisplayWidth
Position
SearchableSortable   TADODataSetADS253
Connectiondm.ADOConnection1
CursorTypectStaticLockType
ltReadOnlyCommandText�  SELECT dbo.Data0017.INV_PART_NUMBER, dbo.Data0017.INV_PART_DESCRIPTION, 
      dbo.Data0023.ABBR_NAME, dbo.Data0002.UNIT_NAME, dbo.Data0253.price, 
      dbo.Data0253.QTY, ROUND(dbo.Data0253.QTY * dbo.Data0253.price, 6) 
      AS pcs_cost,data0253.QTY_BOM
FROM dbo.Data0253 INNER JOIN
      dbo.Data0017 ON 
      dbo.Data0253.STD_INVENT_PTR = dbo.Data0017.RKEY INNER JOIN
      dbo.Data0028 ON dbo.Data0253.D0028_PTR = dbo.Data0028.RKEY INNER JOIN
      dbo.Data0023 ON dbo.Data0028.SUPPLIER_PTR = dbo.Data0023.RKEY INNER JOIN
      dbo.Data0002 ON dbo.Data0028.PURCHASE_UNIT_PTR = dbo.Data0002.RKEY
WHERE DATA0253.quote_ptr = :rkey
DataSourceDataSource1MasterFieldsrkey
ParametersNamerkey
AttributespaSigned DataType	ftInteger	Precision
SizeValueL  LeftPTopT TStringFieldADS253INV_PART_NUMBER	FieldNameINV_PART_NUMBERSize  TStringFieldADS253INV_PART_DESCRIPTION	FieldNameINV_PART_DESCRIPTIONReadOnly	Sized  TStringFieldADS253ABBR_NAME	FieldName	ABBR_NAMESize
  TStringFieldADS253UNIT_NAME	FieldName	UNIT_NAME  TFloatFieldADS253price	FieldNameprice  TFloatField	ADS253QTY	FieldNameQTY  TFloatFieldADS253pcs_cost	FieldNamepcs_costReadOnly	   TDataSourceDataSource3DataSetADS253LeftpTopT  TppDBPipelineppDB253
DataSourceDataSource3OpenDataSourceUserNameDB253Left� TopTMasterDataPipelineNameppDB85 TppFieldppDB253ppField1
FieldAlias   Pg�ex	FieldNameINV_PART_NUMBERFieldLength DisplayWidth Position 
SearchableSortable  TppFieldppDB253ppField2
FieldAlias   Pg�eĉ<h	FieldNameINV_PART_DESCRIPTIONFieldLength DataTypedtSingleDisplayWidth Position
SearchableSortable  TppFieldppDB253ppField3
FieldAlias   �O�^FU	FieldName	ABBR_NAMEFieldLength DisplayWidth Position
SearchableSortable  TppFieldppDB253ppField4
FieldAlias   USMO	FieldName	UNIT_NAMEFieldLength DisplayWidth Position
SearchableSortable  TppFieldppDB253ppField5
FieldAlias   US�N	FieldNamepriceFieldLength DataTypedtDoubleDisplayWidth Position
SearchableSortable  TppFieldppDB253ppField6
FieldAlias   peϑ	FieldNameQTYFieldLength DataTypedtDoubleDisplayWidth Position
SearchableSortable  TppFieldppDB253ppField7
FieldAlias   b,g	FieldNamepcs_costFieldLength DataTypedtDoubleDisplayWidth Position
SearchableSortable   TDataSourceDataSource4DataSetADS431LeftpTopx  TADODataSetADS431
Connectiondm.ADOConnection1
CursorTypectStaticLockType
ltReadOnlyCommandText[  SELECT dbo.Data0278.PARAMETER_NAME, dbo.Data0278.PARAMETER_DESC, 
      dbo.Data0002.UNIT_NAME, dbo.Data0431.UNIT_VALUE
FROM dbo.Data0431 INNER JOIN
      dbo.Data0278 ON dbo.Data0431.UNIT_PTR = dbo.Data0278.RKEY INNER JOIN
      dbo.Data0002 ON dbo.Data0278.UNIT_PTR = dbo.Data0002.RKEY
where data0431.qte_ptr = :rkey
order by data0431.rkey
DataSourceDataSource1MasterFieldsrkey
ParametersNamerkey
AttributespaSigned DataType	ftInteger	Precision
ValueL  LeftPTopx TStringFieldADS431PARAMETER_NAME	FieldNamePARAMETER_NAME	FixedChar	Size
  TStringFieldADS431PARAMETER_DESC	FieldNamePARAMETER_DESC	FixedChar	  TStringFieldADS431UNIT_NAME	FieldName	UNIT_NAME  TStringFieldADS431UNIT_VALUE	FieldName
UNIT_VALUESize�    TppDBPipelineppDB431
DataSourceDataSource4OpenDataSourceUserNameDB431Left� TopxMasterDataPipelineNameppDB85 TppFieldppDB431ppField1
FieldAlias   �Spe�Nx	FieldNamePARAMETER_NAMEFieldLength DisplayWidth Position 
SearchableSortable  TppFieldppDB431ppField2
FieldAlias   �SpeT�y	FieldNamePARAMETER_DESCFieldLength DisplayWidth Position
SearchableSortable  TppFieldppDB431ppField3
FieldAlias   USMO	FieldName	UNIT_NAMEFieldLength DataTypedtSingleDisplayWidth Position
SearchableSortable  TppFieldppDB431ppField4
FieldAlias   <P	FieldName
UNIT_VALUEFieldLength DataTypedtSingleDisplayWidth Position
SearchableSortable   TADODataSetADS432
Connectiondm.ADOConnection1
CursorTypectStaticLockType
ltReadOnlyCommandText<  SELECT Data0348.ADDER_NAME,Data0432.FREE_AMOUNT as N_AMOUNT,Data0432.AMOUNT,
      data0085.usheet*Data0432.FREE_AMOUNT as cost_m2,
round(Data0432.FREE_AMOUNT*data0085.TUNITS/(data0085.UNIT_LEN*data0085.UNIT_WTH*0.000001),6) as cost_total_m2,
      case Data0348.PCENTS when 0 then '金额' else '基价百份比'
       end as cac_meoth
       FROM dbo.Data0432 INNER JOIN
      dbo.Data0348 ON dbo.Data0432.SOURCE_PTR = dbo.Data0348.RKEY
      inner join data0085 on data0432.qte_ptr=data0085.rkey
    where data0432.qte_ptr = :rkey
      order by data0432.rkey
DataSourceDataSource1MasterFieldsrkey
ParametersNamerkey
AttributespaSigned DataType	ftInteger	Precision
SizeValueL  LeftPTop�  TStringFieldADS432ADDER_NAMEDisplayWidth	FieldName
ADDER_NAME  TFloatFieldADS432AMOUNTDisplayWidth
	FieldNameAMOUNT  TFloatFieldADS432cost_m2DisplayWidth	FieldNamecost_m2ReadOnly	  TStringFieldADS432cac_meothDisplayWidth
	FieldName	cac_meothReadOnly	Size
  TFloatFieldADS432cost_total_m2	FieldNamecost_total_m2ReadOnly	  TFloatFieldADS432N_AMOUNT	FieldNameN_AMOUNTReadOnly	   TDataSourceDataSource5DataSetADS432LeftqTop�   TppDBPipelineppDB432
DataSourceDataSource5OpenDataSourceUserNameDB432Left� Top� MasterDataPipelineNameppDB85 TppFieldppDB432ppField1
FieldAlias   �]z�T�y	FieldName
ADDER_NAMEFieldLength DisplayWidth Position 
SearchableSortable  TppFieldppDB432ppField2
FieldAlias   ё��	FieldNameAMOUNTFieldLength DataTypedtDoubleDisplayWidth Position
SearchableSortable  TppFieldppDB432ppField3
FieldAlias   �ks^s|ё��	FieldNamecost_m2FieldLength DataTypedtDoubleDisplayWidth Position
SearchableSortable  TppFieldppDB432ppField4
FieldAlias   ���{�e_	FieldName	cac_meothFieldLength DisplayWidth Position
SearchableSortable  TppFieldppDB432ppField5
FieldAlias   �ks^s|ё��2 	FieldNamecost_total_m2FieldLength
DataTypedtDoubleDisplayWidth
Position  TppFieldppDB432ppField6
FieldAliasN_AMOUNT	FieldNameN_AMOUNTFieldLength
DisplayWidth
Position   TADODataSetADS432T
Connectiondm.ADOConnection1
CursorTypectStaticLockType
ltReadOnlyCommandText�SELECT dbo.Data0061.CATEGORY, dbo.Data0432.AMOUNT, dbo.Data0432.FREE_AMOUNT, 
      dbo.Data0432.TAX_FLAG
FROM dbo.Data0432 INNER JOIN
      dbo.Data0061 ON dbo.Data0432.ADDL_CAT_PTR = dbo.Data0061.RKEY
WHERE (dbo.Data0432.QTE_PTR = :rkey)
DataSourceDataSource1MasterFieldsrkey
ParametersNamerkey
AttributespaSigned DataType	ftInteger	Precision
ValueL  LeftPTop�  TStringFieldADS432TCATEGORY	FieldNameCATEGORY  TFloatFieldADS432TAMOUNT	FieldNameAMOUNT  TFloatFieldADS432TFREE_AMOUNT	FieldNameFREE_AMOUNT  TStringFieldADS432TTAX_FLAG	FieldNameTAX_FLAG	FixedChar	Size   TDataSourceDataSource6DataSetADS432TLeftpTop�   TppDBPipelineppDB432t
DataSourceDataSource6OpenDataSourceUserNameDB432tLeft� Top� MasterDataPipelineNameppDB85 TppFieldppDB432tppField1
FieldAlias   9�(u{|+R	FieldNameCATEGORYFieldLength DisplayWidth Position 
SearchableSortable  TppFieldppDB432tppField2
FieldAlias   ё��	FieldNameAMOUNTFieldLength DataTypedtDoubleDisplayWidth Position
SearchableSortable  TppFieldppDB432tppField3
FieldAlias   MQ6eё��	FieldNameFREE_AMOUNTFieldLength DataTypedtDoubleDisplayWidth Position
SearchableSortable  TppFieldppDB432tppField4
FieldAlias   /f&T+Tz	FieldNameTAX_FLAGFieldLength DataTypedtCharDisplayWidth Position
SearchableSortable   TppDBPipelineppDB493
DataSourceDataSource7RangeEndreCurrentRecord
RangeBeginrbCurrentRecordUserNameDB493Left� Top�   TADODataSetADS493
Connectiondm.ADOConnection1
CursorTypectStaticLockType
ltReadOnlyCommandTextSELECT * FROM DATA0493
Parameters LeftPTop�  TStringFieldADS493Company_Name	FieldNameCompany_NameSize2  TStringFieldADS493Company_Name2	FieldNameCompany_Name2Size2  TStringFieldADS493Company_Name3	FieldNameCompany_Name3Size2  TStringFieldADS493ship_address	FieldNameship_addressSize2  
TBlobFieldADS493Company_Icon	FieldNameCompany_Icon  TStringFieldADS493SITE_INFO_ADD_1	FieldNameSITE_INFO_ADD_1	FixedChar	Size2  TStringFieldADS493SITE_INFO_ADD_2	FieldNameSITE_INFO_ADD_2	FixedChar	Size2  TStringFieldADS493SITE_INFO_ADD_3	FieldNameSITE_INFO_ADD_3	FixedChar	Size2  TStringFieldADS493SITE_INFO_PHONE	FieldNameSITE_INFO_PHONE	FixedChar	Size   TDataSourceDataSource7DataSetADS493LeftpTop�   TppDesignerppDesigner1CaptionReportBuilderDataSettings.SessionType
BDESessionDataSettings.AllowEditSQLDataSettings.CollationTypectASCIIDataSettings.DatabaseType	dtParadoxDataSettings.IsCaseSensitive	DataSettings.SQLType
sqBDELocalPositionpoScreenCenterReport	ppReport1IniStorageTypeIniFileIniStorageName($WINSYS)\RBuilder.iniWindowHeight�
WindowLeftd	WindowTop2WindowWidthXWindowStatewsMaximizedLeft� Top�   TppDBPipelineppDB85
DataSourceDataSource1OpenDataSourceRangeEndreCurrentRecord
RangeBeginrbCurrentRecordUserNameDB85Left� Top TppFieldppDB85ppField1
FieldAliasTNUMBER	FieldNameTNUMBERFieldLength DataType
dtNotKnownDisplayWidth Position 
SearchableSortable  TppFieldppDB85ppField2
FieldAliasREF_PART_NO	FieldNameREF_PART_NOFieldLength DataType
dtNotKnownDisplayWidth Position
SearchableSortable  TppFieldppDB85ppField3
FieldAliasCUST_PART_NO	FieldNameCUST_PART_NOFieldLength DataType
dtNotKnownDisplayWidth Position
SearchableSortable  TppFieldppDB85ppField4
FieldAliasCUST_PART_DESC	FieldNameCUST_PART_DESCFieldLength DataType
dtNotKnownDisplayWidth Position
SearchableSortable  TppFieldppDB85ppField5
FieldAlias	CUST_NAME	FieldName	CUST_NAMEFieldLength DataType
dtNotKnownDisplayWidth Position
SearchableSortable  TppFieldppDB85ppField6
FieldAliasquote_taxprice	FieldNamequote_taxpriceFieldLength DataType
dtNotKnownDisplayWidth Position
SearchableSortable  TppFieldppDB85ppField7
FieldAlias	CURR_NAME	FieldName	CURR_NAMEFieldLength DataType
dtNotKnownDisplayWidth Position
SearchableSortable  TppFieldppDB85ppField8
FieldAlias	CURR_CODE	FieldName	CURR_CODEFieldLength DataType
dtNotKnownDisplayWidth Position
SearchableSortable  TppFieldppDB85ppField9
FieldAlias	CURR_RATE	FieldName	CURR_RATEFieldLength DataType
dtNotKnownDisplayWidth Position
SearchableSortable  TppFieldppDB85ppField10
FieldAliasvatax	FieldNamevataxFieldLength DataType
dtNotKnownDisplayWidth Position	
SearchableSortable  TppFieldppDB85ppField11
FieldAliasMARKUP	FieldNameMARKUPFieldLength DataType
dtNotKnownDisplayWidth Position

SearchableSortable  TppFieldppDB85ppField12
FieldAliasQTE_DATE	FieldNameQTE_DATEFieldLength DataType
dtNotKnownDisplayWidth Position
SearchableSortable  TppFieldppDB85ppField13
FieldAliasEXPIRATION_DATE	FieldNameEXPIRATION_DATEFieldLength DataType
dtNotKnownDisplayWidth Position
SearchableSortable  TppFieldppDB85ppField14
FieldAliasEMPLOYEE_NAME	FieldNameEMPLOYEE_NAMEFieldLength DataType
dtNotKnownDisplayWidth Position
SearchableSortable  TppFieldppDB85ppField15
FieldAliasREP_CODE	FieldNameREP_CODEFieldLength DataType
dtNotKnownDisplayWidth Position
SearchableSortable  TppFieldppDB85ppField16
FieldAliasSALES_REP_NAME	FieldNameSALES_REP_NAMEFieldLength DataType
dtNotKnownDisplayWidth Position
SearchableSortable  TppFieldppDB85ppField17
FieldAlias	PROD_CODE	FieldName	PROD_CODEFieldLength DataType
dtNotKnownDisplayWidth Position
SearchableSortable  TppFieldppDB85ppField18
FieldAliasPRODUCT_NAME	FieldNamePRODUCT_NAMEFieldLength DataType
dtNotKnownDisplayWidth Position
SearchableSortable  TppFieldppDB85ppField19
FieldAliasCODE	FieldNameCODEFieldLength DataType
dtNotKnownDisplayWidth Position
SearchableSortable  TppFieldppDB85ppField20
FieldAliasQTE_APPROV_DESC	FieldNameQTE_APPROV_DESCFieldLength DataType
dtNotKnownDisplayWidth Position
SearchableSortable  TppFieldppDB85ppField21
FieldAliasROW_NAME	FieldNameROW_NAMEFieldLength DataType
dtNotKnownDisplayWidth Position
SearchableSortable  TppFieldppDB85ppField22
FieldAlias	CUST_ADD1	FieldName	CUST_ADD1FieldLength DataType
dtNotKnownDisplayWidth Position
SearchableSortable  TppFieldppDB85ppField23
FieldAlias	NOTE_INFO	FieldName	NOTE_INFOFieldLength DataType
dtNotKnownDisplayWidth Position
SearchableSortable  TppFieldppDB85ppField24
FieldAliasrej_info	FieldNamerej_infoFieldLength DataType
dtNotKnownDisplayWidth Position
SearchableSortable  TppFieldppDB85ppField25
FieldAliasquote_price	FieldNamequote_priceFieldLength DataType
dtNotKnownDisplayWidth Position
SearchableSortable  TppFieldppDB85ppField26
FieldAlias	MATL_COST	FieldName	MATL_COSTFieldLength DataType
dtNotKnownDisplayWidth Position
SearchableSortable  TppFieldppDB85ppField27
FieldAliasbase_pcscost	FieldNamebase_pcscostFieldLength DataType
dtNotKnownDisplayWidth Position
SearchableSortable  TppFieldppDB85ppField28
FieldAlias	ovhd_cost	FieldName	ovhd_costFieldLength DataType
dtNotKnownDisplayWidth Position
SearchableSortable  TppFieldppDB85ppField29
FieldAlias
total_cost	FieldName
total_costFieldLength DataType
dtNotKnownDisplayWidth Position
SearchableSortable  TppFieldppDB85ppField30
FieldAliasCRP_EST_QUANTITY	FieldNameCRP_EST_QUANTITYFieldLength DataType
dtNotKnownDisplayWidth Position
SearchableSortable  TppFieldppDB85ppField31
FieldAlias	comm_cost	FieldName	comm_costFieldLength DataType
dtNotKnownDisplayWidth Position
SearchableSortable  TppFieldppDB85ppField32
FieldAliasSHIPPING_CHARGE	FieldNameSHIPPING_CHARGEFieldLength DataType
dtNotKnownDisplayWidth Position
SearchableSortable  TppFieldppDB85ppField33
FieldAlias	QTE_UNITS	FieldName	QTE_UNITSFieldLength DataType
dtNotKnownDisplayWidth Position 
SearchableSortable  TppFieldppDB85ppField34
FieldAlias   {|�W	FieldName   {|�WFieldLength DataType
dtNotKnownDisplayWidth Position!
SearchableSortable  TppFieldppDB85ppField35
FieldAlias   �r`	FieldName   �r`FieldLength DataType
dtNotKnownDisplayWidth Position"
SearchableSortable  TppFieldppDB85ppField36
FieldAlias   �b�NUSMO	FieldName   �b�NUSMOFieldLength DataType
dtNotKnownDisplayWidth Position#
SearchableSortable  TppFieldppDB85ppField37
FieldAlias    �.U�e_	FieldName    �.U�e_FieldLength DataType
dtNotKnownDisplayWidth Position$
SearchableSortable  TppFieldppDB85ppField38
FieldAliasrkey	FieldNamerkeyFieldLength DataType
dtNotKnownDisplayWidth Position%
SearchableSortable  TppFieldppDB85ppField39
FieldAliasunit_len	FieldNameunit_lenFieldLength DataType
dtNotKnownDisplayWidth Position&
SearchableSortable  TppFieldppDB85ppField40
FieldAliasunit_wth	FieldNameunit_wthFieldLength DataType
dtNotKnownDisplayWidth Position'
SearchableSortable  TppFieldppDB85ppField41
FieldAliasTUNITS	FieldNameTUNITSFieldLength DataType
dtNotKnownDisplayWidth Position(
SearchableSortable  TppFieldppDB85ppField42
FieldAlias
APPRV_DATE	FieldName
APPRV_DATEFieldLength DataType
dtNotKnownDisplayWidth Position)
SearchableSortable  TppFieldppDB85ppField43
FieldAliasUSHEET	FieldNameUSHEETFieldLength DataType
dtNotKnownDisplayWidth Position*
SearchableSortable  TppFieldppDB85ppField44
FieldAlias
QTE_USHEET	FieldName
QTE_USHEETFieldLength DataType
dtNotKnownDisplayWidth Position+
SearchableSortable  TppFieldppDB85ppField45
FieldAliasMATL_M2	FieldNameMATL_M2FieldLength DataType
dtNotKnownDisplayWidth Position,
SearchableSortable  TppFieldppDB85ppField46
FieldAliasBASE_M2	FieldNameBASE_M2FieldLength DataType
dtNotKnownDisplayWidth Position-
SearchableSortable  TppFieldppDB85ppField47
FieldAliasOVHD_M2	FieldNameOVHD_M2FieldLength DataType
dtNotKnownDisplayWidth Position.
SearchableSortable  TppFieldppDB85ppField48
FieldAliasTOTAL_M2	FieldNameTOTAL_M2FieldLength DataType
dtNotKnownDisplayWidth Position/
SearchableSortable  TppFieldppDB85ppField49
FieldAlias
CRP_EST_M2	FieldName
CRP_EST_M2FieldLength DataType
dtNotKnownDisplayWidth Position0
SearchableSortable  TppFieldppDB85ppField50
FieldAliasCOMM_M2	FieldNameCOMM_M2FieldLength DataType
dtNotKnownDisplayWidth Position1
SearchableSortable  TppFieldppDB85ppField51
FieldAliasSHIPPING_M2	FieldNameSHIPPING_M2FieldLength DataType
dtNotKnownDisplayWidth Position2
SearchableSortable  TppFieldppDB85ppField52
FieldAliasQTE_M2	FieldNameQTE_M2FieldLength DataType
dtNotKnownDisplayWidth Position3
SearchableSortable  TppFieldppDB85ppField53
FieldAliasQUOTE_NOTAX_M2	FieldNameQUOTE_NOTAX_M2FieldLength DataType
dtNotKnownDisplayWidth Position4
SearchableSortable  TppFieldppDB85ppField54
FieldAliasQUOTE_TAX_M2	FieldNameQUOTE_TAX_M2FieldLength DataType
dtNotKnownDisplayWidth Position5
SearchableSortable  TppFieldppDB85ppField55
FieldAlias   �k)R�s	FieldName   �k)R�sFieldLength DataType
dtNotKnownDisplayWidth Position6
SearchableSortable  TppFieldppDB85ppField56
FieldAlias   NUSpeϑ	FieldName   NUSpeϑFieldLength DataType
dtNotKnownDisplayWidth Position7
SearchableSortable  TppFieldppDB85ppField57
FieldAlias   NUSb��y	FieldName   NUSb��yFieldLength DataType
dtNotKnownDisplayWidth Position8
SearchableSortable  TppFieldppDB85ppField58
FieldAliasSpecialCrafts	FieldNameSpecialCraftsFieldLength DataType
dtNotKnownDisplayWidth Position9
SearchableSortable  TppFieldppDB85ppField59
FieldAliasOVHD_N_COST	FieldNameOVHD_N_COSTFieldLength
DataType
dtNotKnownDisplayWidth
Position:  TppFieldppDB85ppField60
FieldAliasTOTAL_N_COST	FieldNameTOTAL_N_COSTFieldLength
DataType
dtNotKnownDisplayWidth
Position;  TppFieldppDB85ppField61
FieldAliasCRPEST_N_COST	FieldNameCRPEST_N_COSTFieldLength
DataType
dtNotKnownDisplayWidth
Position<  TppFieldppDB85ppField62
FieldAliasSHIPPING_N_CHARGE	FieldNameSHIPPING_N_CHARGEFieldLength
DataType
dtNotKnownDisplayWidth
Position=   	TppReport	ppReport2AutoStopDataPipelineppDB432PrinterSetup.BinNameDefaultPrinterSetup.DocumentName   �N�T�b�NchHhPrinterSetup.PaperNameA4PrinterSetup.PrinterNameDefaultPrinterSetup.mmMarginBottom�PrinterSetup.mmMarginLeft�PrinterSetup.mmMarginRight�PrinterSetup.mmMarginTop�PrinterSetup.mmPaperHeight(� PrinterSetup.mmPaperWidthP4 PrinterSetup.PaperSize	UnitsutMillimeters
DeviceTypeScreenOutlineSettings.CreateNode	OutlineSettings.CreatePageNodes	OutlineSettings.EnabledOutlineSettings.VisiblePreviewFormSettings.WindowStatewsMaximizedPreviewFormSettings.ZoomSettingzs100PercentSavePrinterSetup	 TextSearchSettings.DefaultString
<FindText>TextSearchSettings.Enabled	Left� Top� Version7.01mmColumnWidth DataPipelineNameppDB432 TppTitleBandppTitleBand3mmBottomOffset mmHeight�9mmPrintPosition  	TppDBText
ppDBText36UserNameDBText1AutoSize		DataFieldCompany_NameDataPipelineppDB493Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size
Font.StylefsBold ParentDataPipelineTextAlignment
taCenteredTransparent	DataPipelineNameppDB493mmHeightGmmLeftY�  mmTopmmWidth�+ BandType  
TppDBImage
ppDBImage2UserNameDBImage1MaintainAspectRatioStretch		DataFieldCompany_IconDataPipelineppDB493GraphicTypeBitmapParentDataPipelineDataPipelineNameppDB493mmHeight�3mmLeft�mmTop"mmWidth'aBandType  TppSystemVariableppSystemVariable3UserNameSystemVariable1VarType
vtDateTimeFont.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style Transparent	mmHeight�mmLeftRr mmTop`*mmWidth}BandType  TppLabelppLabel1UserNameLabel2Caption   SbpS�e��: Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style TextAlignmenttaRightJustifiedTransparent	mmHeight�mmLeft�- mmTop+*mmWidth�=BandType  TppSystemVariableppSystemVariable4UserNameSystemVariable2VarTypevtDocumentNameFont.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size
Font.StylefsBold TextAlignment
taCenteredTransparent	mmHeight�mmLeft6 mmTop!mmWidth�tBandType   TppHeaderBandppHeaderBand2PrintHeight	phDynamicmmBottomOffset mmHeight�� mmPrintPosition  TppShapeppShape3UserNameShape1ParentHeight	ParentWidth	mmHeight�� mmLeft mmTop mmWidth� BandType   	TppDBText
ppDBText37UserNameDBText2AutoSize		DataFieldTNUMBERFont.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style ParentDataPipelineTransparent	mmHeight�mmLeftjJmmTop4mmWidthtEBandType   TppLabel	ppLabel50UserNameLabel3Caption   �b�NUS�S: Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style TextAlignmenttaRightJustifiedTransparent	mmHeight�mmLeft+mmTop4mmWidth>BandType   TppLineppLine29UserNameLine1ParentWidth	Weight       ��?mmHeight^mmLeft mmTop�mmWidth� BandType   TppLabel	ppLabel51UserNameLabel4Caption   �[7bT�y: Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style TextAlignmenttaRightJustifiedTransparent	mmHeight�mmLeft�  mmTop4mmWidth�=BandType   	TppDBText
ppDBText38UserNameDBText3AutoSize		DataField	CUST_NAMEDataPipelineppDB511Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style ParentDataPipelineTransparent	DataPipelineNameppDB511mmHeight�mmLeftO�  mmTop4mmWidth��  BandType   TppLabel	ppLabel52UserNameLabel5Caption   ,g�S�S: Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style TextAlignmenttaRightJustifiedTransparent	mmHeight�mmLeft+mmTop�mmWidth>BandType   TppLabel	ppLabel53UserNameLabel6Caption   �[7b�W�S: Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style TextAlignmenttaRightJustifiedTransparent	mmHeight�mmLeft�  mmTop�mmWidth>BandType   TppLabel	ppLabel54UserNameLabel7Caption   �[7bir�e�S: Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style TextAlignmenttaRightJustifiedTransparent	mmHeight�mmLeftFz mmTop�mmWidthsKBandType   	TppDBText
ppDBText39UserNameDBText4AutoSize		DataFieldREF_PART_NOFont.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style ParentDataPipelineTransparent	mmHeight�mmLeftjJmmTop�mmWidth�>BandType   	TppDBText
ppDBText40UserNameDBText5AutoSize		DataFieldCUST_PART_NOFont.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style ParentDataPipelineTransparent	mmHeight�mmLeftO�  mmTop�mmWidthtEBandType   	TppDBText
ppDBText41UserNameDBText6AutoSize		DataFieldCUST_PART_DESCFont.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style ParentDataPipelineTransparent	mmHeight�mmLeft� mmTop�mmWidth<aBandType   TppLineppLine30UserNameLine2PositionlpLeftWeight       ��?mmHeight'ammLeftHFmmTop mmWidthgBandType   TppLineppLine31UserNameLine3PositionlpLeftWeight       ��?mmHeight'ammLeft��  mmTop mmWidthgBandType   TppLineppLine32UserNameLine4PositionlpLeftWeight       ��?mmHeight'ammLeft6�  mmTop mmWidthgBandType   TppLabel	ppLabel55UserNameLabel8Caption   N�RXT: Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style TextAlignmenttaRightJustifiedTransparent	mmHeight�mmLeft�� mmTop+mmWidth�0BandType   	TppDBText
ppDBText42UserNameDBText7AutoSize		DataFieldSALES_REP_NAMEFont.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style ParentDataPipelineTransparent	mmHeight�mmLeft�� mmTop+mmWidthsBandType   TppLineppLine33UserNameLine5PositionlpLeftWeight       ��?mmHeight'ammLeftZs mmTop mmWidthgBandType   TppLineppLine34UserNameLine6PositionlpLeftWeight       ��?mmHeight'ammLeft�� mmTop mmWidthgBandType   TppLineppLine35UserNameLine7ParentWidth	Weight       ��?mmHeight^mmLeft mmTop�/mmWidth� BandType   	TppDBText
ppDBText43UserNameDBText8AutoSize		DataFieldEMPLOYEE_NAMEFont.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style ParentDataPipelineTransparent	mmHeight�mmLeft�� mmTop�mmWidth-)BandType   TppLabel	ppLabel56UserNameLabel9Caption   �b�N�NXT: Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style TextAlignmenttaRightJustifiedTransparent	mmHeight�mmLeft�x mmTop�mmWidth>BandType   TppLabel	ppLabel57UserNameLabel11Caption   �b�N�S�V: Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style TextAlignmenttaRightJustifiedTransparent	mmHeight�mmLeft�� mmTop{LmmWidth>BandType   	TppDBText
ppDBText44UserNameDBText10AutoSize		DataField   {|�WFont.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style ParentDataPipelineTransparent	mmHeight�mmLeft� mmTopsKmmWidthsBandType   	TppDBText
ppDBText45UserNameDBText11AutoSize		DataFieldPRODUCT_NAMEFont.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style ParentDataPipelineTransparent	mmHeight�mmLeft� mmTop�4mmWidth�DBandType   TppLabel	ppLabel58UserNameLabel12Caption   �N�T{|�W: Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style Transparent	mmHeight�mmLeft�� mmTop�4mmWidth>BandType   	TppDBText
ppDBText46UserNameDBText12AutoSize		DataField   �b�Nb__Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style ParentDataPipelineTransparent	mmHeight�mmLeftO�  mmTop{LmmWidth�BandType   TppLabel	ppLabel59UserNameLabel13Caption   �b�NUSMO: Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style TextAlignmenttaRightJustifiedTransparent	mmHeight�mmLeft�  mmTop{LmmWidth>BandType   TppLabel	ppLabel60UserNameLabel14Caption   USCQ�: Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style TextAlignmenttaRightJustifiedTransparent	mmHeight�mmLeft�mmTop�4mmWidth�0BandType   	TppDBText
ppDBText47UserNameDBText13AutoSize		DataFieldunit_lenFont.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style ParentDataPipelineTransparent	mmHeight�mmLeftjJmmTop�4mmWidth�"BandType   TppLabel	ppLabel61UserNameLabel15Caption   USCQ�[: Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style TextAlignmenttaRightJustifiedTransparent	mmHeight�mmLeft��  mmTop�4mmWidth�0BandType   	TppDBText
ppDBText48UserNameDBText14	DataFieldunit_wthFont.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style ParentDataPipelineTransparent	mmHeight�mmLeftO�  mmTop�4mmWidth.CBandType   	TppDBText
ppDBText49UserNameDBText15AutoSize		DataFieldTUNITSFont.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style ParentDataPipelineTransparent	mmHeight�mmLeftjJmmTop{LmmWidth�BandType   TppLabel	ppLabel62UserNameLabel16Caption   US�Npeϑ: Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style Transparent	mmHeight�mmLeft+mmTop{LmmWidth>BandType   TppLineppLine36UserNameLine8ParentWidth	Weight       ��?mmHeight	mmLeft mmTopYHmmWidth� BandType   TppLabel	ppLabel63UserNameLabel17Caption   �b�N�eg: Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style TextAlignmenttaRightJustifiedTransparent	mmHeight�mmLeft�x mmTop�4mmWidth>BandType   TppLabel	ppLabel64UserNameLabel18Caption   	gHeg: Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style TextAlignmenttaRightJustifiedTransparent	mmHeight�mmLeft�� mmTop{LmmWidth�0BandType   	TppDBText
ppDBText50UserNameDBText16AutoSize		DataFieldQTE_DATEFont.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style ParentDataPipelineTransparent	mmHeight�mmLeft�� mmTop�4mmWidth�>BandType   	TppDBText
ppDBText51UserNameDBText17AutoSize		DataFieldEXPIRATION_DATEFont.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style ParentDataPipelineTransparent	mmHeight�mmLeft�� mmTop{LmmWidth�7BandType   TppLineppLine37UserNameLine9ParentWidth	Weight       ��?mmHeight"mmLeft mmTop`mmWidth� BandType   TppLineppLine38UserNameLine10PositionlpLeftWeight       ��?mmHeightHFmmLeft#v mmTop�mmWidth�BandType   TppLineppLine39UserNameLine101PositionlpLeftWeight       ��?mmHeightHFmmLeft�� mmTop�mmWidth<BandType   TppImageppImage2UserNameImage1MaintainAspectRatioStretch	mmHeightG�  mmLeftb� mmToph�  mmWidthvB BandType   TppMemoppMemo3UserNameMemo1CaptionMemo1CharWrapFont.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style Stretch	Transparent	mmHeight*�  mmLeftmmTop�  mmWidth�  BandType mmBottomOffset mmOverFlowOffset mmStopPosition 	mmLeading   TppMemoppMemo4UserNameMemo2CaptionMemo2CharWrapFont.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style Stretch	Transparent	mmHeight*�  mmLeft6�  mmTop�  mmWidth�  BandType mmBottomOffset mmOverFlowOffset mmStopPosition 	mmLeading   TppLabel	ppLabel65UserNameLabel10Caption   �b�N�SpeFont.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style Transparent	mmHeight�mmLeft"mmToph�  mmWidth�6BandType   TppLabel	ppLabel66UserNameLabel20Caption   <PFont.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.NameArial	Font.Size

Font.Style Transparent	mmHeight�mmLeft��  mmToph�  mmWidth�BandType   TppLabel	ppLabel67UserNameLabel21Caption   yr+R�]z�Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style Transparent	mmHeight�mmLeft,$mmTop�� mmWidth�6BandType   TppLabel	ppLabel68UserNameLabel22Caption   ���{!j_Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style Transparent	mmHeight�mmLeft��  mmTop�� mmWidth�6BandType   TppLabel	ppLabel69UserNameLabel23Caption	   PCS成本Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style Transparent	mmHeight�mmLeft�
 mmTop�� mmWidth�0BandType   TppLabel	ppLabel70UserNameLabel24Caption   �ks^s|b,gFont.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style Transparent	mmHeight�mmLeft�d mmTopƮ mmWidth�DBandType   TppSubReportppSubReport2UserName
SubReport1	ExpandAllNewPrintJobOutlineSettings.CreateNode	TraverseAllDataDataPipelineNameppDB253mmHeight�mmLeft mmTop`mmWidth� BandType mmBottomOffset mmOverFlowOffset mmStopPosition  TppChildReportppChildReport2AutoStopDataPipelineppDB253PrinterSetup.BinNameDefaultPrinterSetup.DocumentName   �N�T�b�NchHhPrinterSetup.PaperNameA4PrinterSetup.PrinterNameDefaultPrinterSetup.mmMarginBottom�PrinterSetup.mmMarginLeft�PrinterSetup.mmMarginRight�PrinterSetup.mmMarginTop�PrinterSetup.mmPaperHeight(� PrinterSetup.mmPaperWidthP4 PrinterSetup.PaperSize	UnitsutMillimetersVersion7.01mmColumnWidth DataPipelineNameppDB253 TppTitleBandppTitleBand4mmBottomOffset mmHeight�mmPrintPosition  TppLineppLine40UserNameLine12ParentHeight	ParentWidth	PositionlpBottomWeight       ��?mmHeight�mmLeft mmTop mmWidth� BandType  TppLabel	ppLabel71UserNameLabel25Caption   ir�exFont.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style Transparent	mmHeight�mmLeft�4mmTop4mmWidth�6BandType  TppLabel	ppLabel72UserNameLabel26Caption   ir�eĉ<hFont.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style Transparent	mmHeight�mmLeft��  mmTop4mmWidth�6BandType  TppLabel	ppLabel73UserNameLabel27Caption   �O�^FUFont.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style Transparent	mmHeight�mmLeft�B mmTop4mmWidthW)BandType  TppLineppLine41UserNameLine17ParentHeight	PositionlpLeftWeight       ��?mmHeight�mmLeft��  mmTop mmWidth^BandType  TppLineppLine42UserNameLine18ParentHeight	PositionlpLeftWeight       ��?mmHeight�mmLeft� mmTop mmWidth^BandType   TppDetailBandppDetailBand3mmBottomOffset mmHeight�mmPrintPosition  TppLineppLine43UserNameLine13ParentHeight	ParentWidth	PositionlpBottomWeight       ��?mmHeight�mmLeft mmTop mmWidth� BandType  	TppDBText
ppDBText52UserNameDBText21AutoSize		DataFieldINV_PART_NUMBERDataPipelineppDB253Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style Transparent	DataPipelineNameppDB253mmHeight�mmLeft�mmTop+mmWidth�  BandType  	TppDBText
ppDBText53UserNameDBText22AutoSize		DataFieldINV_PART_DESCRIPTIONDataPipelineppDB253Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style Transparent	DataPipelineNameppDB253mmHeight�mmLeftֳ  mmTop+mmWidth:K BandType  	TppDBText
ppDBText54UserNameDBText23AutoSize		DataField	ABBR_NAMEDataPipelineppDB253Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style Transparent	DataPipelineNameppDB253mmHeight�mmLeftJ mmTop4mmWidthsBandType  TppLineppLine44UserNameLine14ParentHeight	PositionlpLeftWeight       ��?mmHeight�mmLeft��  mmTop mmWidthM	BandType  TppLineppLine45UserNameLine15ParentHeight	PositionlpLeftWeight       ��?mmHeight�mmLeft� mmTop mmWidthM	BandType   TppSummaryBandppSummaryBand3mmBottomOffset mmHeight mmPrintPosition     TppLineppLine46UserNameLine20ParentWidth	Weight       ��?mmHeight^mmLeft mmTopȨ mmWidth� BandType   TppLineppLine47UserNameLine25Weight       ��?mmHeight	mmLeft mmTop��  mmWidth8� BandType   TppLabel	ppLabel74UserNameLabel101Caption   �b�N�SpeFont.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style Transparent	mmHeight�mmLeftX�  mmToph�  mmWidth�6BandType   TppLabel	ppLabel75UserNameLabel201Caption   <PFont.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.NameArial	Font.Size

Font.Style Transparent	mmHeight�mmLeft5x mmToph�  mmWidthpBandType    TppDetailBandppDetailBand4mmBottomOffset mmHeight�mmPrintPosition  TppLineppLine48UserNameLine19ParentHeight	ParentWidth	PositionlpRightWeight       ��?mmHeight�mmLeft mmTop mmWidth� BandType  	TppDBText
ppDBText55UserNameDBText9AutoSize		DataField
ADDER_NAMEDataPipelineppDB432Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style Transparent	DataPipelineNameppDB432mmHeight�mmLeft^mmTop+mmWidth��  BandType  	TppDBText
ppDBText56UserNameDBText18AutoSize		DataField	cac_meothDataPipelineppDB432Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style Transparent	DataPipelineNameppDB432mmHeight�mmLeft��  mmTop+mmWidthsBandType  	TppDBText
ppDBText57UserNameDBText19AutoSize		DataFieldAMOUNTDataPipelineppDB432Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style TextAlignment
taCenteredTransparent	DataPipelineNameppDB432mmHeight�mmLeft0 mmTop+mmWidth�BandType  	TppDBText
ppDBText58UserNameDBText20AutoSize		DataFieldcost_m2DataPipelineppDB432Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style TextAlignment
taCenteredTransparent	DataPipelineNameppDB432mmHeight�mmLeft�� mmTop+mmWidth�BandType  TppLineppLine49UserNameLine11ParentHeight	PositionlpLeftWeight       ��?mmHeight�mmLeft mmTop mmWidth�3BandType   TppFooterBandppFooterBand2mmBottomOffset mmHeight��  mmPrintPosition  	TppDBMemo	ppDBMemo3UserNameDBMemo2CharWrap		DataField	NOTE_INFOFont.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style ParentDataPipelineStretch	Transparent	mmHeight/bmmLeft�6mmTopM	mmWidth�� BandTypemmBottomOffset mmOverFlowOffset mmStopPosition 	mmLeading   TppLabel	ppLabel76UserNameLabel32Caption   Y�l: Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style TextAlignmenttaRightJustifiedTransparent	mmHeight�mmLeftEmmTopM	mmWidth!BandType  	TppDBText
ppDBText59UserNameDBText28AutoSize		DataFieldEMPLOYEE_NAMEFont.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style ParentDataPipelineTransparent	mmHeightxmmLeft�2mmTop�xmmWidthW)BandType  TppLabel	ppLabel77UserNameLabel33Caption   6RUS: Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style TextAlignmenttaRightJustifiedTransparent	mmHeightxmmLeftM	mmTop�xmmWidth"BandType  TppLineppLine50UserNameLine21Weight       ��?mmHeightM	mmLeft�/mmTop��  mmWidthPGBandType  TppLabel	ppLabel78UserNameLabel34Caption   6RUS�eg: Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style TextAlignmenttaRightJustifiedTransparent	mmHeightxmmLeft�tmmTop�xmmWidth>BandType  TppLineppLine51UserNameLine22Weight       ��?mmHeightM	mmLeft�  mmTop��  mmWidth:�  BandType  TppLabel	ppLabel79UserNameLabel35Caption   �[8h: Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style TextAlignmenttaRightJustifiedTransparent	mmHeightxmmLeft S mmTop�xmmWidth"BandType  TppLineppLine52UserNameLine23Weight       ��?mmHeightM	mmLeftt mmTop��  mmWidth�QBandType  TppLabel	ppLabel80UserNameLabel40Caption    gT�[8h: Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style TextAlignmenttaRightJustifiedTransparent	mmHeightxmmLeft9� mmTop�xmmWidth>BandType  TppLineppLine53UserNameLine27Weight       ��?mmHeightM	mmLeft mmTop��  mmWidth�MBandType  	TppDBText
ppDBText60UserNameDBText31AutoSize		DataField
APPRV_DATEFont.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style ParentDataPipelineTransparent	mmHeightxmmLeft�  mmTop�xmmWidth}BandType  TppLineppLine54UserNameLine28Weight       ��?mmHeightM	mmLeft�� mmTop��  mmWidth�UBandType  TppLabel	ppLabel81UserNameLabel401Caption   �[8h�eg: Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style TextAlignmenttaRightJustifiedTransparent	mmHeightxmmLeft�a mmTop�xmmWidth>BandType   TppSummaryBandppSummaryBand4PrintHeight	phDynamicmmBottomOffset mmHeightl" mmPrintPosition  TppShapeppShape4UserNameShape2ParentHeight	ParentWidth	mmHeightl" mmLeft mmTop mmWidth� BandType  TppLabel	ppLabel82UserNameLabel28Caption   Pg�e�N: Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style TextAlignmenttaRightJustifiedTransparent	mmHeight�mmLeft�3mmTop>&mmWidth�0BandType  	TppDBText
ppDBText61UserNameDBText24AutoSize		DataField	MATL_COSTFont.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style ParentDataPipelineTransparent	mmHeight�mmLeft�tmmTop>&mmWidth�7BandType  TppLabel	ppLabel83UserNameLabel29Caption   �W,g�N: Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style TextAlignmenttaRightJustifiedTransparent	mmHeight�mmLeft�3mmTop�8mmWidth�0BandType  	TppDBText
ppDBText62UserNameDBText25AutoSize		DataFieldbase_pcscostFont.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style ParentDataPipelineTransparent	mmHeight�mmLeft�tmmTop�8mmWidth�0BandType  TppLabel	ppLabel84UserNameLabel30Caption   �]z��N: Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style TextAlignmenttaRightJustifiedTransparent	mmHeight�mmLeft�3mmTopsKmmWidth�0BandType  	TppDBText
ppDBText63UserNameDBText26AutoSize		DataField	ovhd_costFont.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style ParentDataPipelineTransparent	mmHeight�mmLeft�tmmTopsKmmWidth�7BandType  TppLabel	ppLabel85UserNameLabel31Caption   ;`b,g: Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style Transparent	mmHeight�mmLeft�3mmTop_mmWidth�0BandType  	TppDBText
ppDBText64UserNameDBText27AutoSize		DataField
total_costFont.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style ParentDataPipelineTransparent	mmHeight�mmLeft�tmmTop_mmWidth�7BandType  TppLabel	ppLabel86UserNameLabel36Caption   �N<hR�gFont.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.StylefsBold Transparent	mmHeight�mmLeft�.mmToppmmWidth�7BandType  TppLineppLine55UserNameLine24Weight       ��?mmHeightEmmLeft mmTop
 mmWidth:; BandType  TppLabel	ppLabel87UserNameLabel38Caption   ��Y�R�N: Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style TextAlignmenttaRightJustifiedTransparent	mmHeight�mmLeft>&mmTop�qmmWidth>BandType  	TppDBText
ppDBText65UserNameDBText29AutoSize		DataFieldCRP_EST_QUANTITYFont.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style ParentDataPipelineTransparent	mmHeight�mmLeft�tmmTop�qmmWidth<BandType  TppLabel	ppLabel88UserNameLabel39Caption   �b���s% : Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style TextAlignmenttaRightJustifiedTransparent	mmHeight�mmLeftz-mmTopS�  mmWidth�6BandType  	TppDBText
ppDBText66UserNameDBText30AutoSize		DataFieldMARKUPFont.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style ParentDataPipelineTransparent	mmHeight�mmLeft�tmmTopS�  mmWidth$#BandType  TppLabel	ppLabel89UserNameLabel41Caption   ё��/ �b�NUSMOFont.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style Transparent	mmHeight�mmLeft�smmTopxmmWidthLYBandType  TppLineppLine56UserNameLine26Weight       ��?mmHeightM	mmLeft mmTop��  mmWidth:; BandType  TppLabel	ppLabel90UserNameLabel42Caption   ё��/ �ks^s|Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style Transparent	mmHeight�mmLeft��  mmTopxmmWidth�KBandType  	TppDBText
ppDBText67UserNameDBText32AutoSize		DataFieldquote_priceFont.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style ParentDataPipelineTransparent	mmHeight�mmLeft�tmmTop*�  mmWidth�7BandType  TppLabel	ppLabel91UserNameLabel43Caption   �b�N'�^: Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style TextAlignmenttaRightJustifiedTransparent	mmHeight�mmLeft5%mmTopp�  mmWidth>BandType  	TppDBText
ppDBText68UserNameDBText33AutoSize		DataField	CURR_NAMEFont.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style ParentDataPipelineTransparent	mmHeight�mmLeft�tmmTopp�  mmWidthW)BandType  	TppDBText
ppDBText69UserNameDBText34AutoSize		DataField	CURR_RATEFont.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style ParentDataPipelineTransparent	mmHeight�mmLeft�tmmTop�  mmWidth<BandType  TppLabel	ppLabel92UserNameLabel44Caption   Gl�s: Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style TextAlignmenttaRightJustifiedTransparent	mmHeight�mmLeft@mmTop�  mmWidth"BandType  TppLabel	ppLabel93UserNameLabel45Caption   �X<Pz% : Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style TextAlignmenttaRightJustifiedTransparent	mmHeight�mmLeftz-mmTopͲ  mmWidth�6BandType  	TppDBText
ppDBText70UserNameDBText35AutoSize		DataFieldvataxFont.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style ParentDataPipelineTransparent	mmHeight�mmLeft�tmmTopͲ  mmWidthpBandType  TppLabel	ppLabel94UserNameLabel46Caption	   ���{'�^:   �Nl^Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style Transparent	mmHeight�mmLeftK= mmTopxmmWidth�mBandType  TppLabel	ppLabel95UserNameLabel47Caption   �b�N( N+Tz) : Font.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.Style TextAlignmenttaRightJustifiedTransparent	mmHeight�mmLeftV
mmTop*�  mmWidthvYBandType  	TppDBMemo	ppDBMemo4UserNameDBMemo1CharWrap	DataFieldrej_infoFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowText	Font.Name   �[SO	Font.Size

Font.Style ParentDataPipelineStretch	Transparent	mmHeight7�  mmLeft7 mmTop!mmWidth�� BandTypemmBottomOffset mmOverFlowOffset mmStopPosition 	mmLeading   TppLabel	ppLabel96UserNameLabel37Caption   B\�S�VFont.CharsetDEFAULT_CHARSET
Font.ColorclBlack	Font.Name   �[SO	Font.Size

Font.StylefsBold Transparent	mmHeight�mmLeft�x mmTopgmmWidthW)BandType  TppVariableppVariable2UserName	Variable1	CalcOrder DataTypedtDoubleFont.CharsetDEFAULT_CHARSET
Font.ColorclWindowText	Font.Name   �[SO	Font.Size

Font.Style Transparent	mmHeight�mmLeft�  mmTop>&mmWidth�>BandType    TppDesignerppDesigner2CaptionReportBuilderDataSettings.SessionType
BDESessionDataSettings.AllowEditSQLDataSettings.CollationTypectASCIIDataSettings.DatabaseType	dtParadoxDataSettings.IsCaseSensitive	DataSettings.SQLType
sqBDELocalPositionpoScreenCenterReport	ppReport2IniStorageTypeIniFileIniStorageName($WINSYS)\RBuilder.iniWindowHeight�
WindowLeftd	WindowTop2WindowWidthXWindowStatewsMaximizedLeft Top�   TADODataSetADS8501
Connectiondm.ADOConnection1
CursorTypectStaticLockType
ltReadOnlyCommandTextXSELECT   D0085_Ptr, Cost_Name, Cost, Total_Cost, Flag_tax
FROM         dbo.Data008501

DataSourceDataSource1IndexFieldNames	D0085_PtrMasterFieldsrkey
Parameters LeftPTop TIntegerFieldADS8501D0085_Ptr	FieldName	D0085_Ptr  TStringFieldADS8501Cost_Name	FieldName	Cost_NameSize2  TFloatFieldADS8501Cost	FieldNameCost  TFloatFieldADS8501Total_Cost	FieldName
Total_Cost  TStringFieldADS8501Flag_tax	FieldNameFlag_tax	FixedChar	Size   TDataSourceDataSource9DataSetADS8501LeftpTop  TppDBPipelineppDB8501
DataSourceDataSource9UserNameDB8501Left� TopMasterDataPipelineNameppDB85 TppFieldppDBPipeline1ppField1	AlignmenttaRightJustify
FieldAlias	D0085_Ptr	FieldName	D0085_PtrFieldLength DataType	dtIntegerDisplayWidth Position   TppFieldppDBPipeline1ppField2
FieldAlias	Cost_Name	FieldName	Cost_NameFieldLength2DisplayWidth2Position  TppFieldppDBPipeline1ppField3	AlignmenttaRightJustify
FieldAliasCost	FieldNameCostFieldLength DataTypedtDoubleDisplayWidth
Position  TppFieldppDBPipeline1ppField4	AlignmenttaRightJustify
FieldAlias
Total_Cost	FieldName
Total_CostFieldLength DataTypedtDoubleDisplayWidth
Position  TppFieldppDBPipeline1ppField5
FieldAliasFlag_tax	FieldNameFlag_taxFieldLengthDisplayWidthPosition   TADODataSetADS061
Connectiondm.ADOConnection1
CursorTypectStaticLockType
ltReadOnlyCommandText�  SELECT     dbo.Data0061.RKEY, dbo.Data0061.CATEGORY, dbo.Data0432.AMOUNT, dbo.Data0432.FREE_AMOUNT, dbo.Data0432.TAX_FLAG,dbo.Data0432.Mould_set
FROM         dbo.Data0432 INNER JOIN
                      dbo.Data0061 ON dbo.Data0432.ADDL_CAT_PTR = dbo.Data0061.RKEY 
WHERE (dbo.Data0432.QTE_PTR = :rkey) AND ((dbo.Data0432.Mould_set <> 0 ) AND (dbo.Data0432.Mould_set IS NOT NULL ) )

DataSourceDataSource1MasterFieldsrkey
ParametersNamerkey
AttributespaSigned DataType	ftInteger	Precision
Value   LeftPTop< TIntegerField
ADS061rkey	FieldNamerkeyReadOnly	  TStringFieldADS061CATEGORY	FieldNameCATEGORY  TFloatFieldADS061AMOUNT	FieldNameAMOUNT  TFloatFieldADS061FREE_AMOUNT	FieldNameFREE_AMOUNT  TStringFieldADS061TAX_FLAG	FieldNameTAX_FLAG	FixedChar	Size  TFloatFieldADS061Mould_set	FieldName	Mould_set   TDataSourceDataSource8DataSetADS061Left� Top<  TppDBPipelineppDB061
DataSourceDataSource8UserNameDB061Left� Top4 TppFieldppDB061ppField1	AlignmenttaRightJustify
FieldAliasrkey	FieldNamerkeyFieldLength DataType	dtIntegerDisplayWidth Position   TppFieldppDB061ppField2
FieldAliasCATEGORY	FieldNameCATEGORYFieldLengthDisplayWidthPosition  TppFieldppDB061ppField3	AlignmenttaRightJustify
FieldAliasAMOUNT	FieldNameAMOUNTFieldLength DataTypedtDoubleDisplayWidth
Position  TppFieldppDB061ppField4	AlignmenttaRightJustify
FieldAliasFREE_AMOUNT	FieldNameFREE_AMOUNTFieldLength DataTypedtDoubleDisplayWidth
Position  TppFieldppDB061ppField5
FieldAliasTAX_FLAG	FieldNameTAX_FLAGFieldLengthDisplayWidthPosition  TppFieldppDB061ppField6	AlignmenttaRightJustify
FieldAlias	Mould_set	FieldName	Mould_setFieldLength DataTypedtDoubleDisplayWidth
Position    