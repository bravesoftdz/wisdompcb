unit invoice_search;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, StdCtrls, ADODB, Grids, DBGrids;

type
  TForm_rma = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    ADODataSet1: TADODataSet;
    Button1: TButton;
    Button2: TButton;
    ADODataSet1RMA_DATE: TDateTimeField;
    ADODataSet1PART_PRICE: TFloatField;
    ADODataSet1RUSH_CHARGE: TBCDField;
    ADODataSet1sys_date: TDateTimeField;
    ADODataSet1PROD_CODE: TStringField;
    ADODataSet1PRODUCT_NAME: TStringField;
    ADODataSet1PRODUCT_DESC: TStringField;
    ADODataSet1QTY_RECD: TBCDField;
    ADODataSet1tax_in_price: TStringField;
    ADODataSet1sales_order: TStringField;
    ADODataSet1RMA_NUMBER: TStringField;
    procedure Edit1Change(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
   field_name:string;
   OldGridWnd : TWndMethod;
   procedure NewGridWnd (var Message : TMessage);
  public
    { Public declarations }
  end;

var
  Form_rma: TForm_rma;

implementation

uses DAMO;

{$R *.dfm}
procedure TForm_rma.NewGridWnd(var Message: TMessage);
var
 IsNeg : Boolean;
begin
 if Message.Msg = WM_MOUSEWHEEL then
 begin
   IsNeg := Short(Message.WParamHi) < 0;
   if IsNeg then
     DBGrid1.DataSource.DataSet.MoveBy(1)
   else
     DBGrid1.DataSource.DataSet.MoveBy(-1)
 end
 else
   OldGridWnd(Message);
end;

procedure TForm_rma.Edit1Change(Sender: TObject);
begin
 if trim(Edit1.text)<>'' then
  adodataset1.Filter := field_name+' like ''%'+trim(edit1.text)+'%'''
 else
  adodataset1.filter := '';
 if adodataset1.IsEmpty then
  button1.Enabled:=false
 else
  button1.Enabled:=true; 
end;

procedure TForm_rma.FormActivate(Sender: TObject);
begin
field_name:='RMA_NUMBER';
end;

procedure TForm_rma.DBGrid1TitleClick(Column: TColumn);
var
 i:byte;
begin
if (column.FieldName<>adodataset1.IndexFieldNames) then
 adodataset1.IndexFieldNames:=column.FieldName;

if (column.ReadOnly) and (field_name<>column.FieldName) then
 begin
  label1.Caption:=column.Title.Caption;
  self.field_name:=column.FieldName;
  edit1.SetFocus;
  for i:=0 to dbgrid1.FieldCount-1 do
   if dbgrid1.Columns[i].Title.Color= clred then
    dbgrid1.Columns[i].Title.Color:= clbtnface;
  column.Title.Color:=clred;
 end
else
 edit1.SetFocus;
end;

procedure TForm_rma.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if (key=13) and (not adodataset1.IsEmpty) then ModalResult:=mrok;
 if (chr(key)='V') and (ssalt in shift) then
  showmessage(adodataset1.CommandText);
end;

procedure TForm_rma.DBGrid1DblClick(Sender: TObject);
begin
if not adodataset1.IsEmpty then ModalResult:=mrok;
end;

procedure TForm_rma.FormCreate(Sender: TObject);
begin
 OldGridWnd := DBGrid1.WindowProc;
 DBGrid1.WindowProc := NewGridWnd;
end;

procedure TForm_rma.Button1Click(Sender: TObject);
begin
 if dbgrid1.SelectedRows.Count>=1 then
  ModalResult:=mrok
 else
  showmessage('����ѡ��һ���˻�����!')
end;

end.
