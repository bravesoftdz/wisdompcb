unit PasHistoryPrice;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, DBGridEhGrouping, ToolCtrlsEh,uBaseFrm,ucommfunc,
  DBGridEhToolCtrls, DynVarsEh, Vcl.StdCtrls, EhLibVCL, GridsEh, DBAxisGridsEh,
  DBGridEh, Vcl.ExtCtrls, Data.DB, Datasnap.DBClient;

type
  TfrmHistoryPrice = class(TfrmBase)
    Panel1: TPanel;
    Panel2: TPanel;
    DBGridEh1: TDBGridEh;
    Button1: TButton;
    ds60_Price: TDataSource;
    cds60_Price: TClientDataSet;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    iEN:Integer;//0������1�༭
    { Public declarations }
    procedure GetData(ARkey25:string);
  end;

var
  frmHistoryPrice: TfrmHistoryPrice;

implementation

{$R *.dfm}

{ TfrmHistoryPrice }

procedure TfrmHistoryPrice.Button1Click(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmHistoryPrice.GetData(ARkey25: string);
var LSQL60:string;
begin
  if (iEN=0) then
  LSQL60:=cds60_Price.CommandText+' and data0060.cust_part_ptr='+ARkey25+' order by ent_date desc'
  else
  LSQL60:='select sales_order,ent_date,po_number,parts_ordered,part_price,'
  +' case data0060.so_tp when 0 then ''����'' when 1 then ''�ⷢ'' when 2 then ''���Ƴ�'' end as sotp,data0023.code'
  +' from data0060 inner join data0097 on data0060.purchase_order_ptr=data0097.rkey'
  +' left outer join data0023 on Data0060.supplier_ptr = data0023.RKEY'
  +' where cust_part_ptr='+ARkey25+' order by ent_date desc';
  gSvrIntf.IntfGetDataBySql(LSQL60,cds60_Price);
end;

end.
