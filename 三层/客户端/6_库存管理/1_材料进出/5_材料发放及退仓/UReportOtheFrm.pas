unit UReportOtheFrm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,uBaseFrm, Data.DB, Data.Win.ADODB,
  frxClass, frxDBSet, Datasnap.DBClient,uCommFunc;

type
  TfrmReportOther_mod38 = class(TFrmBase)
    cds457: TClientDataSet;
    cds208: TClientDataSet;
    frxrprt2: TfrxReport;
    frxdbdtst457: TfrxDBDataset;
    frxdbdtst208: TfrxDBDataset;
    qry457: TADOQuery;
    qry208: TADOQuery;
    cds493: TClientDataSet;
    qry493: TADOQuery;
    strngfldqry493��˾����1: TStringField;
    strngfldqry493��˾����2: TStringField;
    strngfldqry493��˾����3: TStringField;
    strngfldqry493��˾��ַ: TStringField;
    blbfldqry493��˾ͼ��: TBlobField;
    strngfldqry493��˾λ��1: TStringField;
    strngfldqry493��˾λ��2: TStringField;
    strngfldqry493��˾λ��3: TStringField;
    strngfldqry493�绰: TStringField;
    frxdbdtst493: TfrxDBDataset;
    qry457RKEY: TAutoIncField;
    qry457GON_NUMBER: TStringField;
    qry457REF_NUMBER: TStringField;
    qry457CREATE_DATE: TDateTimeField;
    qry457ABBR_NAME: TStringField;
    qry457TTYPE: TSmallintField;
    qry457DEPT_CODE: TStringField;
    qry457DEPT_NAME: TStringField;
    qry457EMPLOYEE_NAME: TStringField;
    qry457������Ա: TStringField;
    qry457��������: TStringField;
    qry457״̬: TStringField;
    qry457��ע: TStringField;
    qry208goods_name: TStringField;
    qry208goods_guige: TStringField;
    qry208goods_type: TStringField;
    qry208rohs: TStringField;
    qry208UNIT_NAME: TStringField;
    qry208rkey: TAutoIncField;
    qry208SOURCE_PTR: TIntegerField;
    qry208DEPT_PTR: TIntegerField;
    qry208GON_PTR: TIntegerField;
    qry208TRANSACTION_PTR: TIntegerField;
    qry208GL_HDR_PTR: TIntegerField;
    qry208TDATE: TDateTimeField;
    qry208QUANTITY: TFloatField;
    qry208RTN_QUANTITY: TFloatField;
    qry208D457_IDKey: TStringField;
  private
    { Private declarations }
  public
    { Public declarations }

   procedure GetData(ARkey:string);
  end;

var
  frmReportOther_mod38: TfrmReportOther_mod38;

implementation

{$R *.dfm}

{ TfrmReportOther_mod38 }

procedure TfrmReportOther_mod38.GetData(ARkey: string);
var
  Lsql457, Lsql208,Lsql493: string;
begin

  Lsql457 := 'SELECT dbo.Data0457.RKEY, dbo.Data0457.GON_NUMBER,  '+
' dbo.Data0457.REF_NUMBER,'+
' dbo.Data0457.CREATE_DATE,'+
' dbo.Data0015.ABBR_NAME, data0457.TTYPE,'+
' dbo.Data0034.DEPT_CODE, dbo.Data0034.DEPT_NAME,'+
' dbo.Data0005.EMPLOYEE_NAME,'+
' Data0005_1.EMPLOYEE_NAME as ������Ա,'+
' case data0457.ttype when 1 then ''�����ϵ�''   '+
' when 2 then ''����'' when 3 then ''���ϵ�����''   '+
' when 4 then ''���˲�'' when 5 then ''������Ʒ''   '+
' when 6 then ''���˲�'' '+
' end as ��������,'+
' case data0457.status when 0 then ''���''    ' +
' when 1 then ''���'' '+
' end as ״̬,Data0457.Cut_No as ��ע   '+
' FROM dbo.Data0457 INNER JOIN '+
' dbo.Data0015 ON dbo.Data0457.warehouse_ptr = dbo.Data0015.RKEY INNER JOIN '+
' dbo.Data0034 ON dbo.Data0457.dept_ptr = dbo.Data0034.RKEY INNER JOIN  '+
' dbo.Data0005 ON dbo.Data0457.RECD_BY = dbo.Data0005.RKEY INNER JOIN  '+
' dbo.Data0005 Data0005_1 ON dbo.Data0457.CREATE_BY = Data0005_1.RKEY  '+
' where data0457.rkey='+ARKey;


  Lsql208 := ' select  b.goods_name ,b.goods_guige  ,b.goods_type  , b.rohs   , '+
' c.UNIT_NAME ,a.QUANTITY'+
 ' from data0208  a'+
'  inner join Data0235 b  on a.SOURCE_PTR=b.RKEY'+
'  inner join Data0002 c on b.unit_ptr=c.rkey'+
'  where a.GON_PTR= '+ARKey+'';

 Lsql493:=' SELECT Company_Name as ��˾����1, '+
' Company_Name2 as ��˾����2,'+
' Company_Name3 as ��˾����3,'+
' ship_address as ��˾��ַ,'+
' Company_Icon as ��˾ͼ��,'+
' SITE_INFO_ADD_1 as ��˾λ��1,'+
' SITE_INFO_ADD_2 as ��˾λ��2,'+
' SITE_INFO_ADD_3 as ��˾λ��3,'+
' SITE_INFO_PHONE as �绰'+
' FROM DATA0493';

   gSvrIntf.IntfGetDataBySqlArr(VarArrayOf([ Lsql457, Lsql208,Lsql493]),
    [ cds457, cds208,cds493]);
end;

end.
