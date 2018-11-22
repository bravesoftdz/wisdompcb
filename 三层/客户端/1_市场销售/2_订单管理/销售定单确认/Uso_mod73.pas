unit Uso_mod73;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms,uBaseSinglePickListFrm, Vcl.Dialogs, DBGridEhGrouping,
  ToolCtrlsEh, DBGridEhToolCtrls, DynVarsEh, Data.DB, Vcl.XPMan, Vcl.Menus,
  Datasnap.DBClient, Vcl.StdCtrls, Vcl.Buttons, EhLibVCL, GridsEh,
  DBAxisGridsEh, DBGridEh, Vcl.ExtCtrls, uBaseMainFrm;

type
  TForm1 = class(TfrmSinglePickList)
    procedure btnOKClick(Sender: TObject);
    procedure eh1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure edtFilterChange(Sender: TObject);
  private

    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses uCommFunc;

{$R *.dfm}

procedure TForm1.btnOKClick(Sender: TObject);
var
dataset:TClientDataSet;
sql:string;
begin
 if messagedlg('ȷ�Ϸ�ȷ��?',mtConfirmation,[mbyes,mbno],1)<>mryes then exit;
 dataset:=TClientDataSet.Create(nil);
 try
  sql:='SELECT *  FROM Data0060 WHERE RKEY= '+cdsPick.FieldByName('rkey').AsString;
  gSvrIntf.IntfGetDataBySql(sql,dataset);
  if dataset.FieldByName('PROD_REL').AsString<>'2' then
  begin
   ShowMessage('״̬�����ı�,���ܷ�ȷ��');
   exit;
  end;
  with dataset do
  begin
   edit;
   fieldvalues['conf_date'] := null; //ȷ��ʱ��
   fieldvalues['prod_rel'] := '1';  //ʹ��Ϊδȷ��
   fieldvalues['conf_by_empl_ptr'] := null;
   fieldvalues['to_be_confirmed'] :=cdsPick.fieldvalues['parts_ordered'];
   post;
  end;
  gSvrIntf.IntfPostDataByTable('data0060',dataset.Delta);
  Close;
 finally
  dataset.Free;
 end;
end;
procedure TForm1.edtFilterChange(Sender: TObject);
begin
 if edtFilter.EditLabel.Caption='' then
 begin
   ShowMessage('����Ҫ������Ӧ�ı�ͷ');
   Exit;
 end;
  inherited;

end;

procedure TForm1.eh1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if (chr(key)='S') and (ssalt in shift) then
 showmessage(cdsPick.CommandText);
end;

end.
