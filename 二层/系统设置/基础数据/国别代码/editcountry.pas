unit editcountry;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, DBCtrls, Buttons, DB, DBTables;

type
  TForm2 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
   v_close:byte;
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation
uses main;
{$R *.dfm}

procedure TForm2.BitBtn2Click(Sender: TObject);
var
v_message:integer;
begin
 if form1.adoTable1.State=dsinsert then
  begin
   form1.adoTable1.Cancel;
   v_close:=1; //�����˳�
   close;
  end;
if form1.adoTable1.Modified then
 begin
  v_message:=messagedlg('�������޸�,�Ƿ����?',mtConfirmation,[mbyes,mbno,mbcancel],0);
  if v_message=7 then
   form1.adoTable1.Cancel     //ȡ���Ե�ǰ��¼���޸İ�������
  else
   if v_message=6 then     //���޸ĵļ�¼����
     BitBtn1Click(Sender)
   else                    //cancel������Ҳ������
    exit;
 end;
 v_close:=1; //�����˳�
 close;
end;

procedure TForm2.BitBtn1Click(Sender: TObject);
begin
if dbedit1.Text='' then
 begin
  showmessage('��������Ҵ���');
  dbedit1.SetFocus;
  exit;
 end;
if dbedit2.Text='' then
 begin
  showmessage('�����������Ĺ�������');
  dbedit2.SetFocus;
  exit;
 end;

if form1.adoTable1.State=dsedit then
 begin               //���table1�ڱ༭״̬
  form1.adoTable1.Post;
  v_close:=1; //�����˳�
  close;
 end
else          //���table1������״̬(dsinert)
 begin
  form1.adoTable1.Post;
  form1.adoTable1.Append;
  dbedit1.SetFocus;
 end;
end;

procedure TForm2.FormActivate(Sender: TObject);
begin
 DBEdit1.SetFocus;
end;
procedure TForm2.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
 if v_close<>1 then
  form1.adoTable1.Cancel;
end;

procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 v_close:=0;
end;

end.
