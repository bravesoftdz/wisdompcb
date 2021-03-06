unit DmUnit1;

interface

uses
  SysUtils, Classes, DB, ADODB;

type
  TDM = class(TDataModule)
    ADOConnection1: TADOConnection;
    ADOQuery1: TADOQuery;
    ADOQuery2: TADOQuery;
    ADOQuery1RKEY: TAutoIncField;
    ADOQuery1MANU_PART_NUMBER: TStringField;
    ADOQuery1MANU_PART_DESC: TStringField;
    ADOQuery1CUST_CODE: TStringField;
    ADOQuery1ABBR_NAME: TStringField;
    ADOQuery1CUSTOMER_NAME: TStringField;
    ADOQuery1PROD_CODE: TStringField;
    ADOQuery1PRODUCT_NAME: TStringField;
    ADOQuery1LAYERS: TWordField;
    ADOQuery1ANALYSIS_CODE_2: TStringField;
    ADOQuery1CREATED_BY_EMPLOYEE_NAME: TStringField;
    ADOQuery1CUSTPART_ENT_DATE: TDateTimeField;
    ADOQuery1LAST_MODIFIED_EMPLOYEE_NAME: TStringField;
    ADOQuery1LAST_MODIFIED_DATE: TDateTimeField;
    ADOQuery1CHECK_EMPLOYEE_NAME: TStringField;
    ADOQuery1CHECK_DATE: TDateTimeField;
    ADOQuery1AUDITED_EMPLOYEE_NAME: TStringField;
    ADOQuery1AUDITED_DATE: TDateTimeField;
    ADOQuery1CREATED_BY_EMPL_PTR: TIntegerField;
    ADOQuery1PROD_CODE_PTR: TIntegerField;
    ADOQuery1CUSTOMER_PTR: TIntegerField;
    ADOQuery1CHECK_BY_PTR: TIntegerField;
    ADOQuery1AUDITED_BY_PTR: TIntegerField;
    ADOQuery1LAST_MODIFIED_BY_PTR: TIntegerField;
    ADOQuery1MyTSTATUS: TStringField;
    ADOQuery1TSTATUS: TWordField;
    ADOQuery1Mygreen_flag: TStringField;
    TemADOQuery1: TADOQuery;
    ADOQuery2RKEY: TAutoIncField;
    ADOQuery2MANU_PART_NUMBER: TStringField;
    ADOQuery2MANU_PART_DESC: TStringField;
    ADOQuery2LAYERS: TWordField;
    ADOQuery2SO_UNIT: TStringField;
    ADOQuery2pcs_lngth: TBCDField;
    ADOQuery2pcs_width: TBCDField;
    ADOQuery2set_lngth: TBCDField;
    ADOQuery2set_width: TBCDField;
    ADOQuery2green_flag: TStringField;
    ADOQuery2ANALYSIS_CODE_2: TStringField;
    ADOQuery2memo_text: TMemoField;
    ADOQuery2set_qty: TIntegerField;
    ADOQuery2CUSTOMER_PTR: TIntegerField;
    ADOQuery2PROD_CODE_PTR: TIntegerField;
    ADOQuery2CUSTPART_ENT_DATE: TDateTimeField;
    ADOQuery2CREATED_BY_EMPL_PTR: TIntegerField;
    ADOQuery2TSTATUS: TWordField;
    ADOQ02780002: TADOQuery;
    ADOQ02780002RKEY: TAutoIncField;
    ADOQ02780002PARAMETER_NAME: TStringField;
    ADOQ02780002PARAMETER_DESC: TStringField;
    ADOQ02780002UNIT_NAME: TStringField;
    ADOQ02780002SPEC_RKEY: TStringField;
    ADOQ02780002DATA_TYPE: TWordField;
    ADOQ02780002MyDATA_TYPE: TStringField;
    ADOQ0338: TADOQuery;
    ADOQuery2ttype: TWordField;
    ADOQuery1ttype: TWordField;
    ADOQuery1Myttype: TStringField;
    ADOQuery1OPT_LOT_SIZE: TIntegerField;
    ADOQuery1EST_SCRAP: TFloatField;
    ADOQuery1SHELF_LIFE: TIntegerField;
    ADOQuery1MFG_LEAD_TIME: TSmallintField;
    ADOQuery2OPT_LOT_SIZE: TIntegerField;
    ADOQuery2EST_SCRAP: TFloatField;
    ADOQuery2SHELF_LIFE: TIntegerField;
    ADOQuery2MFG_LEAD_TIME: TSmallintField;
    ADOQuery2REMARK: TMemoField;
    ADOQuery2ENG_NOTE: TStringField;
    ADOQuery2ANALYSIS_CODE_3: TStringField;
    ADOQuery2ANALYSIS_CODE_5: TStringField;
    ADOQuery2ANALYSIS_CODE_1: TStringField;
    ADOQuery2ENG_ROUTE_PTR: TIntegerField;
    ADOQuery2pcs_sq: TFloatField;
    ADOQuery2unit_sq: TFloatField;
    ADOQuery2QTY_BOM: TWordField;
    ADOQ_119: TADOQuery;
    ADOQ_119RKEY: TAutoIncField;
    ADOQ_119CUST_PART_PTR: TIntegerField;
    ADOQ_119ENT_DATE: TDateTimeField;
    ADOQ_119PROD_CONF: TWordField;
    ADOQ_119PROD_CONF_BY_PTR: TIntegerField;
    ADOQ_119PROD_CONF_DATE: TDateTimeField;
    ADOQ_119REFERENCE: TStringField;
    ADOQ_119SO_AMT_LTD: TIntegerField;
    ADOQ0318: TADOQuery;
    ADOQ0318RKEY: TAutoIncField;
    ADOQ0318CUSTOMER_PART_PTR: TIntegerField;
    ADOQ0318TRANS_TYPE: TSmallintField;
    ADOQ0318TRANS_DESCRIPTION: TStringField;
    ADOQ0318FROM_STRING: TStringField;
    ADOQ0318TO_STRING: TStringField;
    ADOQ0318USER_PTR: TIntegerField;
    ADOQ0318TRANS_DATE: TDateTimeField;
    ADOQ0318PROGRAM_SOURCE: TSmallintField;
    ADOQ0318file_number: TStringField;
    ADOQuery2prod_route_ptr: TIntegerField;
    ADOQuery2current_rev: TStringField;
    ADOQuery2REVIEW_DAYS: TSmallintField;
    ADOQuery1ANCESTOR_PTR: TIntegerField;
    tmp: TADOQuery;
    ADOQuery2spell_qty: TIntegerField;
    ADOQuery2spell_lngth: TBCDField;
    ADOQuery2spell_width: TBCDField;
    ADOQuery2nopb_flag: TWordField;
    ADOQuery2REACH: TBooleanField;
    ADOQuery4: TADOQuery;
    AQY0025: TADOQuery;
    AQY0025RKEY: TAutoIncField;
    AQY0025MANU_PART_NUMBER: TStringField;
    AQY0025MANU_PART_DESC: TStringField;
    AQY0025PARENT_PTR: TIntegerField;
    AQY0025QTY_BOM: TWordField;
    AQY0025BOM_STEP: TWordField;
    AQY0025CREATED_BY_EMPL_PTR: TIntegerField;
    AQY0025ENG_ROUTE_PTR: TIntegerField;
    AQY0025PROD_ROUTE_PTR: TIntegerField;
    AQY0025REMARK: TMemoField;
    AQY0025ENG_NOTE: TStringField;
    AQY0025memo_text: TMemoField;
    AQY0025PROD_CODE_PTR: TIntegerField;
    AQY0025OPT_LOT_SIZE: TIntegerField;
    AQY0025EST_SCRAP: TFloatField;
    AQY0025SHELF_LIFE: TIntegerField;
    AQY0025REVIEW_DAYS: TSmallintField;
    AQY0025PARTS_NUM: TIntegerField;
    AQY0025CUSTOMER_PTR: TIntegerField;
    AQY0025MFG_LEAD_TIME: TSmallintField;
    AQY0025LAST_SO_DATE: TDateTimeField;
    AQY0025REPORT_UNIT_VALUE1: TBCDField;
    AQY0025TSTATUS: TWordField;
    AQY0025CHECK_BY_PTR: TIntegerField;
    AQY0025CHECK_DATE: TDateTimeField;
    AQY0025AUDITED_BY_PTR: TIntegerField;
    AQY0025AUDITED_DATE: TDateTimeField;
    AQY0025ALLOW_EDIT_FLAG: TStringField;
    AQY0025ONHOLD_SALES_FLAG: TWordField;
    AQY0025ONHOLD_RELEASE_FLAG: TWordField;
    AQY0025ONHOLD_PLANNING_FLAG: TWordField;
    AQY0025CUSTPART_ENT_DATE: TDateTimeField;
    AQY0025LAST_MODIFIED_BY_PTR: TIntegerField;
    AQY0025LAST_MODIFIED_DATE: TDateTimeField;
    AQY0025ANALYSIS_CODE_2: TStringField;
    AQY0025ANALYSIS_CODE_3: TStringField;
    AQY0025LAYERS: TWordField;
    AQY0025green_flag: TStringField;
    AQY0025set_lngth: TBCDField;
    AQY0025set_width: TBCDField;
    AQY0025set_qty: TIntegerField;
    AQY0025unit_sq: TFloatField;
    AQY0025ANALYSIS_CODE_1: TStringField;
    AQY0025pcs_lngth: TBCDField;
    AQY0025pcs_width: TBCDField;
    AQY0025pcs_sq: TFloatField;
    AQY0025ANALYSIS_CODE_5: TStringField;
    AQY0025spell_lngth: TBCDField;
    AQY0025spell_width: TBCDField;
    AQY0025spell_qty: TIntegerField;
    AQY0025spell_sq: TFloatField;
    AQY0025ANALYSIS_CODE_4: TStringField;
    AQY0025SO_UNIT: TStringField;
    AQY0025ttype: TWordField;
    AQY0025layers_info: TMemoField;
    AQY0025QTY_ON_HAND: TIntegerField;
    AQY0025barcode_flag: TWordField;
    AQY0025current_rev: TStringField;
    AQY0025QTY_PARENTBOM: TWordField;
    AQY0025nopb_flag: TWordField;
    AQY0025TUSAGE: TBCDField;
    AQY0025quality_status: TBooleanField;
    AQY0025quality_user: TIntegerField;
    AQY0025quality_date: TDateTimeField;
    AQY0025ANCESTOR_PTR: TIntegerField;
    ADS38: TADODataSet;
    ADS38rkey: TAutoIncField;
    ADS38SOURCE_PTR: TIntegerField;
    ADS38DEPT_PTR: TIntegerField;
    ADS38DEF_ROUT_INST: TStringField;
    ADS38STEP_NUMBER: TSmallintField;
    ADS38tooling_rev: TStringField;
    ADS38OUTP_SPFC: TBCDField;
    ADS38tool_old_rev: TStringField;
    ads279: TADODataSet;
    ads279source_PTR: TIntegerField;
    ads279PARAMETER_PTR: TIntegerField;
    ads279PARAMETER_VALUE: TStringField;
    ads279IES_PROD: TSmallintField;
    ads279IES_CRP: TSmallintField;
    ads497: TADODataSet;
    ads497PARAMETER_PTR: TIntegerField;
    ads497PARAMETER_VALUE: TStringField;
    ads497SOURCE_PTR: TIntegerField;
    ads497ROUTE_STEP_PTR: TIntegerField;
    ads497SEQ_NO: TIntegerField;
    adsa273: TADODataSet;
    adsa273RKEY: TAutoIncField;
    adsa273CUSTOMER_PTR: TIntegerField;
    adsa273CUSTOMER_PART_PTR: TIntegerField;
    adsa273COPYFROMCUST_PTR: TIntegerField;
    adsa273ENTERED_BY: TIntegerField;
    adsa273VERIFIED_BY: TIntegerField;
    adsa273ENTERED_DATE: TDateTimeField;
    adsa273VERIFIED_DATE: TDateTimeField;
    adsa273STATUS: TSmallintField;
    adsa273SOURCE: TSmallintField;
    adsa273TEXT1: TStringField;
    adsa273TEXT2: TStringField;
    adsa273TEXT3: TStringField;
    adsa273TEXT4: TStringField;
    adsa273ECN_NO: TStringField;
    adsa273text: TStringField;
    adsa273Tooling_close: TWordField;
    adsa273remark: TStringField;
    adsa273last_modi_by_ptr: TIntegerField;
    adsa273last_modi_date: TDateTimeField;
    adsa273ECNB1: TStringField;
    adsa273ECNB2: TStringField;
    adsa273ECNB3: TStringField;
    adsa273ECNB4: TStringField;
    adsa273ECNB5: TStringField;
    adsa273ECNA1: TStringField;
    adsa273ECNA2: TStringField;
    adsa273ECNA3: TStringField;
    adsa273ECNA4: TStringField;
    adsa273ECNA5: TStringField;
    adsa273ECNSTART: TWordField;
    adsa273del: TWordField;
    ads494: TADODataSet;
    ads494PARAMETER_PTR: TIntegerField;
    ads494PARAMETER_VALUE: TStringField;
    ads494custpart_ptr: TIntegerField;
    ads494step_number: TSmallintField;
    ads494seq_no: TSmallintField;
    ads494Doc_Flag: TStringField;
    ads494after_flag: TStringField;
    ads494flow_spfc_flag: TStringField;
    ads279_1: TADODataSet;
    IntegerField1: TIntegerField;
    IntegerField2: TIntegerField;
    StringField1: TStringField;
    SmallintField1: TSmallintField;
    SmallintField2: TSmallintField;
    AQY0025REACH: TBooleanField;
    dsFindRFQ: TDataSource;
    aqFindRFQ: TADOQuery;
    aqFindRFQRKEY: TAutoIncField;
    aqFindRFQRFQNo: TStringField;
    aqFindRFQStatus: TWordField;
    aqFindRFQCust_Id: TStringField;
    aqFindRFQCust_Name: TStringField;
    aqFindRFQCust_Addr: TStringField;
    aqFindRFQSalesMan: TStringField;
    aqFindRFQTechContact: TStringField;
    aqFindRFQTel: TStringField;
    aqFindRFQMail: TStringField;
    aqFindRFQFileName: TStringField;
    aqFindRFQFilePath: TStringField;
    aqFindRFQPartsId: TStringField;
    aqFindRFQPOType: TStringField;
    aqFindRFQCreateId: TIntegerField;
    aqFindRFQCreateDate: TDateTimeField;
    aqFindRFQLastModifyId: TIntegerField;
    aqFindRFQLastModifyDate: TDateTimeField;
    aqFindRFQAuditId: TIntegerField;
    aqFindRFQAuditDate: TDateTimeField;
    aqFindRFQTPOType: TStringField;
    aqRFQParam: TADOQuery;
    aqRFQParamRKEY: TAutoIncField;
    aqRFQParamPARAMETER_PTR: TIntegerField;
    aqRFQParamGroup_Type: TWordField;
    aqRFQParamGroup_Name: TStringField;
    aqRFQParamSEQ_NO: TSmallintField;
    aqRFQParamParam_ptr: TIntegerField;
    aqRFQParamPARAMETER_DESC: TStringField;
    aqRFQParamParam_Value: TStringField;
    aqRFQParamMustInput: TWordField;
    aqParamName: TADOQuery;
    aqParamNameRKEY: TAutoIncField;
    aqParamNamePARAMETER_NAME: TStringField;
    aqParamNamePARAMETER_DESC: TStringField;
    aqParamNameUNIT_CODE: TStringField;
    aqParamNameUNIT_NAME: TStringField;
    aqParamNameDATA_TYPE: TWordField;
    aqParamNamemin_value: TFloatField;
    aqParamNamemax_value: TFloatField;
    ADOQuery1RFQNo: TStringField;
    ADOQuery2RFQNo: TStringField;
    AQY0025RFQNo: TStringField;
    ADOQuery1memotext: TMemoField;
    ADOQuery1ORIG_CUSTOMER: TStringField;
    ADOQuery2ORIG_CUSTOMER: TStringField;
    qry1: TADOQuery;
    ADOQuery1SAMPLE_NR: TStringField;
    ADOQuery2SAMPLE_NR: TStringField;
    AQY0025SAMPLE_NR: TStringField;
    ADOQuery2pricing_principle: TWordField;
    dsADOQuery2: TDataSource;
    ADOQuery1pricing_principle: TStringField;
    ADOQ0338rkey: TAutoIncField;
    ADOQ0338PARAMETER_PTR: TIntegerField;
    ADOQ0338SEQUENCE_NO: TSmallintField;
    ADOQ0338TVALUE: TStringField;
    ADOQuery2CustFileName: TStringField;
    ADOQuery2RoHS: TBooleanField;
    AQY0025RoHS: TBooleanField;
    ADOQuery2print2dkey: TIntegerField;
    ADOQuery2grade_code: TStringField;
    procedure ADOQuery1memotextGetText(Sender: TField; var Text: String;
      DisplayText: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM: TDM;

implementation

{$R *.dfm}

procedure TDM.ADOQuery1memotextGetText(Sender: TField; var Text: String;
  DisplayText: Boolean);
begin
   Text:=Sender.AsString;
end;

end.
