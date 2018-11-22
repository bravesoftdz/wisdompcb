unit PasLogoCard_Rp33;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frxClass, frxDBSet, Datasnap.DBClient,
  Datasnap.Provider, Data.DB, Data.Win.ADODB, frxDesgn,ucommfunc,frxBarcode;

type
  TfrmLogoCard_Rp33 = class(TForm)
    con1: TADOConnection;
    qry1: TADOQuery;
    dtstprvdr1: TDataSetProvider;
    cds22: TClientDataSet;
    fdbs22: TfrxDBDataset;
    cds493s: TClientDataSet;
    fdb493: TfrxDBDataset;
    qry1rkey17: TAutoIncField;
    qry1rkey23: TAutoIncField;
    qry1������: TStringField;
    qry1��Ӧ�̴���: TStringField;
    qry1��Ӧ������: TStringField;
    qry1��Ӧ��: TStringField;
    qry1��������: TStringField;
    qry1��ע: TStringField;
    qry1����ͺ�: TStringField;
    qry1���ϱ���: TStringField;
    qry1����: TFloatField;
    qry1����: TStringField;
    frxReport1: TfrxReport;
    frxDesigner1: TfrxDesigner;
    cdsQry1: TClientDataSet;
    cds22rkey17: TAutoIncField;
    cds22rkey23: TAutoIncField;
    cds22������: TStringField;
    cds22��Ӧ�̴���: TStringField;
    cds22��Ӧ������: TStringField;
    cds22��Ӧ��: TStringField;
    cds22��������: TStringField;
    cds22��ע: TStringField;
    cds22����ͺ�: TStringField;
    cds22���ϱ���: TStringField;
    cds22����: TFloatField;
    cds22����: TStringField;
    cds22���: TFloatField;
    qry1��������: TStringField;
    cds22��������: TStringField;
    procedure cds22CalcFields(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
     procedure GetData(ARkey: string);
  end;

var
  frmLogoCard_Rp33: TfrmLogoCard_Rp33;

implementation

{$R *.dfm}

{ TfrmLogoCard_Rp33 }

procedure TfrmLogoCard_Rp33.cds22CalcFields(DataSet: TDataSet);
var Lsq:string;
begin
  Lsq:='select sum(data0022.quan_on_hand) as qty from data0022'
       +' inner join data0456 on data0022.grn_ptr=data0456.rkey'
       +' inner join data0023 on data0456.supp_ptr=data0023.rkey'
       +' inner join data0017 on data0022.INVENTORY_PTR=data0017.rkey'
       +' where data0017.rkey='+cds22Rkey17.AsString+' and data0023.rkey='+cds22Rkey23.AsString
       +' group by data0017.rkey,data0023.rkey';

  gSvrIntf.IntfGetDataBySql(Lsq,cdsQry1);
  cds22.FieldByName('���').Value:=cdsQry1.FieldByName('qty').Value;
end;

procedure TfrmLogoCard_Rp33.GetData(ARkey: string);
var
  LSql493,LSql22:string;
begin
  LSql493:= cds493s.CommandText;
  LSql22:= cds22.CommandText + ' where data0022.rkey= ' + ARkey + ' ';
  if NOT gSvrIntf.IntfGetDataBySqlArr(VarArrayOf([LSql493,LSql22]),[cds493s,cds22]) then exit;
end;

end.
