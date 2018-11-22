unit UReportFrm_mod38;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,uBaseFrm, Data.Win.ADODB, frxClass,
  frxDBSet, Data.DB, Datasnap.DBClient,ucommfunc;

type
  TfrmReport_mod38 = class(TFrmBase)
    cds457: TClientDataSet;
    cds207: TClientDataSet;
    frxrprt2: TfrxReport;
    frxdbdtst457: TfrxDBDataset;
    frxdbdtst207: TfrxDBDataset;
    qry457: TADOQuery;
    qry207: TADOQuery;
    atncfldqry457RKEY: TAutoIncField;
    strngfldqry457GON_NUMBER: TStringField;
    strngfldqry457REF_NUMBER: TStringField;
    dtmfldqry457CREATE_DATE: TDateTimeField;
    strngfldqry457ABBR_NAME: TStringField;
    smlntfldqry457TTYPE: TSmallintField;
    strngfldqry457DEPT_CODE: TStringField;
    strngfldqry457DEPT_NAME: TStringField;
    strngfldqry457EMPLOYEE_NAME: TStringField;
    strngfldqry457������Ա: TStringField;
    strngfldqry457��������: TStringField;
    strngfldqry457״̬: TStringField;
    strngfldqry457��ע: TStringField;
    strngfldqry207INV_PART_NUMBER: TStringField;
    strngfldqry207INV_NAME: TStringField;
    strngfldqry207INV_DESCRIPTION: TStringField;
    bcdfldqry207QUANTITY: TBCDField;
    fltfldqry207RTN_QUANTITY: TFloatField;
    strngfldqry207UNIT_NAME: TStringField;
    strngfldqry207rohs: TStringField;
    strngfldqry207SUPPLIER2: TStringField;
    intgrfldqry207D0022_PTR: TIntegerField;
    bcdfldqry207QUAN_ON_HAND: TBCDField;
    intgrfldqry207INVENTORY_PTR: TIntegerField;
    atncfldqry207RKEY: TAutoIncField;
    bcdfldqry207hand17: TBCDField;
    strngfldqry207ABBR_NAME: TStringField;
    cds493: TClientDataSet;
    qry493: TADOQuery;
    frxdbdtst493: TfrxDBDataset;
    strngfldqry493��˾����1: TStringField;
    strngfldqry493��˾����2: TStringField;
    strngfldqry493��˾����3: TStringField;
    strngfldqry493��˾��ַ: TStringField;
    blbfldqry493��˾ͼ��: TBlobField;
    strngfldqry493��˾λ��1: TStringField;
    strngfldqry493��˾λ��2: TStringField;
    strngfldqry493��˾λ��3: TStringField;
    strngfldqry493�绰: TStringField;
  private
    { Private declarations }
  public
    { Public declarations }

  procedure GetData(ARkey:string);
  end;

var
  frmReport_mod38: TfrmReport_mod38;

implementation

{$R *.dfm}

{ TfrmReport_mod38 }

procedure TfrmReport_mod38.GetData;
var
  Lsql457, Lsql207,Lsql493: string;
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


  Lsql207 := 'SELECT Data0017.INV_PART_NUMBER,Data0017.INV_NAME,Data0017.INV_DESCRIPTION,Data0207.QUANTITY, '+
' Data0207.RTN_QUANTITY,Data0002.UNIT_NAME,Data0022.rohs,Data0022.SUPPLIER2,Data0207.D0022_PTR,'+
' Data0022.QUAN_ON_HAND,Data0207.INVENTORY_PTR,Data0207.RKEY,Data0017.QUAN_ON_HAND AS hand17,'+
' Data0023.ABBR_NAME'+
' FROM   Data0207 INNER JOIN' +
' Data0017 ON Data0207.INVENTORY_PTR = Data0017.RKEY INNER JOIN'+
' Data0022 ON Data0207.D0022_PTR = Data0022.RKEY INNER JOIN' +
' Data0002 ON Data0022.LOCATION_PTR_FROM = Data0002.RKEY INNER JOIN'+
' Data0456 ON Data0022.GRN_PTR = Data0456.RKEY INNER JOIN'+
' Data0023 ON Data0456.SUPP_PTR = Data0023.RKEY' +
' where gon_ptr='+ARKey+' ';

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

   gSvrIntf.IntfGetDataBySqlArr(VarArrayOf([ Lsql457, Lsql207,Lsql493]),
    [ cds457, cds207,cds493]);
end;

end.
