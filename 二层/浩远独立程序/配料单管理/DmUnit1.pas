
unit DmUnit1;
//  Provider=SQLOLEDB.1;Password=WZtopcberp_1077;Persist Security Info=True;User ID=wzsp;Initial Catalog=WISDOMPCB;Data Source=172.16.1.57;Use Procedure for Prepare=1;Auto Translate=True;Packet Size=4096;Workstation ID=W119;Use Encryption for Data=False;Tag with column collation when possible=False
interface

uses
  SysUtils, Classes, DB, ADODB,DateUtils;

type
  TDM = class(TDataModule)
    ADOConnection1: TADOConnection;
    ADOQALL2: TADOQuery;
    TemADOQuery1: TADOQuery;
    ADOQALL2rkey: TAutoIncField;
    ADOQALL2TTYPE: TWordField;
    ADOQALL2CUT_NO: TStringField;
    ADOQALL2SO_NO: TStringField;
    ADOQALL2PLANNED_QTY: TIntegerField;
    ADOQALL2ISSUED_QTY: TIntegerField;
    ADOQALL2SCH_COMPL_DATE: TDateTimeField;
    ADOQALL2ISSUE_DATE: TDateTimeField;
    ADOQALL2CREATED_BY_PTR: TIntegerField;
    ADOQALL2PRINTED_BY_PTR: TSmallintField;
    ADOQALL2UPANEL1: TIntegerField;
    ADOQALL2PANEL_1_QTY: TIntegerField;
    ADOQALL2UPANEL2: TIntegerField;
    ADOQALL2PANEL_2_QTY: TIntegerField;
    ADOQALL2remark: TStringField;
    ADOQALL2FG_QTY: TIntegerField;
    ADOQALL2WIP_QTY: TIntegerField;
    ADOQALL2ORD_REQ_QTY: TIntegerField;
    ADOQALL2QTY_REJECT: TIntegerField;
    ADOQALL2TSTATUS: TWordField;
    ADOQALL2Con_Flag: TSmallintField;
    ADOQALL2pnl1_size: TStringField;
    ADOQALL2pnl2_size: TStringField;
    ADOQALL2ANALYSIS_CODE_3: TStringField;
    ADOQALL2PARTS_ORDERED: TFloatField;
    ADOQALL2SCH_DATE: TDateTimeField;
    ADOQALL2REFERENCE_NUMBER: TStringField;
    ADOQALL2QTY_PLANNNED: TIntegerField;
    ADOQALL2d025_rkey: TAutoIncField;
    ADOQALL2MANU_PART_NUMBER: TStringField;
    ADOQALL2MANU_PART_DESC: TStringField;
    ADOQALL2remark25: TMemoField;
    ADOQALL2EST_SCRAP: TFloatField;
    ADOQALL2PARENT_PTR: TIntegerField;
    ADOQALL2PO_NUMBER: TStringField;
    ADOQALL2CUST_CODE: TStringField;
    ADOQALL2CUSTOMER_NAME: TStringField;
    ADOQALL2PRODUCT_NAME: TStringField;
    ADOQALL2EMPLOYEE_NAME: TStringField;
    ADOQALL2MySTATUS: TStringField;
    ADOQALL2printed: TStringField;
    ADOQALL2unit_sq: TFloatField;
    ADOQALL2set_lngthset_width: TStringField;
    ADOQALL2set_qty: TIntegerField;
    TMPADO1: TADOQuery;
    ADOQALL2bom_status: TWordField;
    TMPADO1rkey: TAutoIncField;
    TMPADO1source_ptr: TIntegerField;
    TMPADO1sheet_BMP: TBlobField;
    TMPADO1pnl_bmp: TBlobField;
    TMPADO1pnl2_bmp: TBlobField;
    TMPADO1TOTAL_PNLS_1: TSmallintField;
    TMPADO1TOTAL_PNLS_2: TSmallintField;
    TMPADO1UNIT_LEN: TFloatField;
    TMPADO1UNIT_WTH: TFloatField;
    TMPADO1UNIT_UNIT: TWordField;
    TMPADO1UNIT_NUM: TIntegerField;
    TMPADO1SHT_LEN: TFloatField;
    TMPADO1SHT_WTH: TFloatField;
    TMPADO1TUSAGE: TBCDField;
    TMPADO1PNL_LEN: TFloatField;
    TMPADO1PNL_WTH: TFloatField;
    TMPADO1UPANEL: TSmallintField;
    TMPADO1PNL_LEN_2: TFloatField;
    TMPADO1PNL_WTH_2: TFloatField;
    TMPADO1UPANEL_2: TSmallintField;
    TMPADO1minspace1: TFloatField;
    TMPADO1minspace2: TFloatField;
    ADOQALL2MyCon_Flag: TStringField;
    TemADOQuery2: TADOQuery;
    ADOQALL2MyTTYPE: TStringField;
    ADOQALL2waitfor_release: TIntegerField;
    ADOQ0026: TADOQuery;
    ADOQ0026RKEY: TAutoIncField;
    ADOQ0026MANU_BOM_PTR: TIntegerField;
    ADOQ0026DEPT_PTR: TIntegerField;
    ADOQ0026INVENTORY_PTR: TIntegerField;
    ADOQ0026QTY_BOM: TFloatField;
    ADOQ0026FLOW_NO: TSmallintField;
    ADOQ0026ROUTE_STEP_NO: TSmallintField;
    ADOQ0026DOC_FLAG: TStringField;
    ADOQALL2DSDesigner: TFloatField;
    ADOQALL2DSDesigner3: TFloatField;
    DataSource1: TDataSource;
    ADOQALL2bomstatus: TStringField;
    AQY468: TADOQuery;
    AQY468CUT_NO: TStringField;
    AQY468SO_NO: TStringField;
    AQY468STEP: TSmallintField;
    AQY468DEPT_PTR: TIntegerField;
    AQY468INVENT_PTR: TIntegerField;
    AQY468QUAN_BOM: TFloatField;
    AQY468STATUS: TSmallintField;
    AQY468VENDOR: TStringField;
    AQY468Invent_or: TSmallintField;
    AQY468printit: TStringField;
    ADOQALL2DSDesigner2: TFloatField;
    ADOQALL2QTY_ON_HAND: TIntegerField;
    ADOQALL2WAREHOUSE_CODE: TStringField;
    ADOQALL2ABBR_NAME: TStringField;
    procedure ADOQALL2CalcFields(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM: TDM;

implementation

{$R *.dfm}


procedure TDM.ADOQALL2CalcFields(DataSet: TDataSet);
begin
case  ADOQALL2tstatus.Value of
0:  ADOQALL2MySTATUS.AsString := '已审核';
1:  ADOQALL2MySTATUS.AsString := '未审核';
2:  ADOQALL2MySTATUS.AsString := '不审核';
3:  ADOQALL2MySTATUS.AsString := '已取消';
end;

  if ADOQALL2printed_by_ptr.asinteger > 0 then
   ADOQALL2printed.asstring := '已打印'
  else
   ADOQALL2printed.asstring := '未打印';

  if ADOQALL2Con_Flag.asinteger = 2 then
   ADOQALL2MyCon_Flag.asstring := '已确认'
  else
   ADOQALL2MyCon_Flag.asstring := '未确认';

  case ADOQALL2TTYPE.AsInteger of
  0:ADOQALL2MyTTYPE.AsString := '订单投产';
  1:ADOQALL2MyTTYPE.AsString := '补料投产';
  2:ADOQALL2MyTTYPE.AsString := '按MRB退货投产';
  3:ADOQALL2MyTTYPE.AsString := '按MRB退货返修';
  4:ADOQALL2MyTTYPE.AsString := '按板号投产';
  end;

end;

end.

