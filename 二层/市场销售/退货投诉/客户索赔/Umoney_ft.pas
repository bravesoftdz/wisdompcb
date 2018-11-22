unit Umoney_ft;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TForm_money = class(TForm)
    Edit4: TEdit;
    Label15: TLabel;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    Label8: TLabel;
    Label3: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure Edit2KeyPress(Sender: TObject; var Key: Char);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    stats:Byte;
    { Public declarations }
  end;

var
  Form_money: TForm_money;

implementation

uses Udemo,ConstVar,Pick_Item_Single;

{$R *.dfm}

procedure TForm_money.BitBtn3Click(Sender: TObject);
var inputvar: PDlgInput;
begin
 frmPick_Item_Single:=TfrmPick_Item_Single.Create(nil);
 try
  InputVar.Fields := 'DEPT_CODE/���Ŵ���/200,DEPT_NAME/��������/200';
  InputVar.Sqlstr :='SELECT RKEY, DEPT_CODE ,DEPT_NAME FROM data0034 WHERE ACTIVE_FLAG=0';
  inputvar.KeyField:='rkey';
  InputVar.AdoConn := DM.ADOConnection1 ;
  frmPick_Item_Single.InitForm_New(InputVar);
  if frmPick_Item_Single.ShowModal=mrok then
  begin
   Edit4.Text:=frmPick_Item_Single.adsPick.FieldValues['DEPT_CODE'];
   Label8.Caption:=frmPick_Item_Single.adsPick.FieldValues['DEPT_NAME'];
   Edit4.tag:=frmPick_Item_Single.adsPick.Fieldbyname('rkey').AsInteger;
  end ;
 finally
 frmPick_Item_Single.Free ;
 end;
end;

procedure TForm_money.BitBtn4Click(Sender: TObject);
var inputvar: PDlgInput;
begin
 frmPick_Item_Single:=TfrmPick_Item_Single.Create(nil);
 try
  InputVar.Fields := 'employeecode/Ա������/200,chinesename/Ա������/200';
  InputVar.Sqlstr :='SELECT rkey, chinesename, employeecode FROM employeemsg WHERE status=1 ';
  inputvar.KeyField:='rkey';
  InputVar.AdoConn := DM.ADOConnection1 ;
  frmPick_Item_Single.InitForm_New(InputVar);
  if frmPick_Item_Single.ShowModal=mrok then
  begin
   Edit1.Text:=frmPick_Item_Single.adsPick.FieldValues['employeecode'];
   Label3.Caption:=frmPick_Item_Single.adsPick.FieldValues['chinesename'];
   Edit1.tag:=frmPick_Item_Single.adsPick.Fieldbyname('rkey').AsInteger;
  end ;
 finally
 frmPick_Item_Single.Free ;
 end;
end;

procedure TForm_money.Edit2KeyPress(Sender: TObject; var Key: Char);
begin
   if not (key in ['0'..'9','.',#8,#13]) then  //�ж��Ƿ���������
   abort
  else
  if key = chr(46) then      //�ж��Ƿ��ظ�����С����'.'
 if pos('.',(sender as TEdit).Text)>0 then  //С���㲻���ظ�
  abort;
end;

procedure TForm_money.BitBtn1Click(Sender: TObject);

begin

 if edit4.text='' then
 begin
  ShowMessage('���Ų���Ϊ��!');
  Exit;
 end;
 if edit1.text='' then
 begin
  ShowMessage('��Ա����Ϊ��!');
  Exit;
 end;
 if edit2.text='' then
 begin
  ShowMessage('����Ϊ��!');
  Exit;
 end;
 if  not DM.ADO618pres.IsEmpty then
 begin
    DM.ADO618pres.First;
    while not DM.ADO618pres.Eof do
    begin
     if DM.ADO618presemp_ptr.Value = Edit1.Tag  then
     begin
       ShowMessage('��Ա�Ѵ��ڻ���������');
       exit;
     end;
     DM.ADO618pres.Next;
    end;
 end;
 with DM.ADO618pres do
 begin
  Append;
  DM.ADO618pressel_n.Value :=DM.ADO618pres.RecordCount+1;
  DM.ADO618presemp_ptr.Value:=Edit1.Tag;
  DM.ADO618presdep_ptr.Value:=Edit4.Tag;
  DM.ADO618pressp_money.AsString:=Edit2.Text;
  Post;
 end;
 Edit1.Clear;
 Edit2.Clear;
 Edit4.Clear;
 Label3.Caption:='';
 Label8.Caption:='';
end;

end.
