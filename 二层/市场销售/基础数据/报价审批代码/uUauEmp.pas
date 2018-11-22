unit uUauEmp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls;

type
  TfrmAuEmp = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    BitBtn1: TBitBtn;
    Label3: TLabel;
    procedure BitBtn1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Edit1Exit(Sender: TObject);
  private
    { Private declarations }
  public
    _UID:string;
  end;

var
  frmAuEmp: TfrmAuEmp;

implementation

uses uEmp;

{$R *.dfm}
//�û�
procedure TfrmAuEmp.BitBtn1Click(Sender: TObject);
begin
 try
  frmEmp:=TfrmEmp.Create(application);
  frmEmp.Edit1.Text := trim(edit1.Text);
  if frmEmp.ADOQuery1.IsEmpty then
   begin
    messagedlg('û���ҵ���ؼ�¼!',mtinformation,[mbcancel],0);
    edit1.SetFocus;
   end
  else
  if frmEmp.ShowModal=mrok then
   begin
    edit1.Text := frmEmp.ADOQuery1.FieldValues['user_id'];
    edit1.Font.Color := clwindowtext;
    Label4.Caption:=frmEmp.ADOQuery1.FieldValues['user_full_name'];
    _UID:= frmEmp.ADOQuery1.fieldbyname('rkey').AsString ;
    edit2.SetFocus;
   end
  else
   edit1.SetFocus; 
 finally
  frmEmp.free;
 end;
end;
//�û����Ƿ���ȷ
procedure TfrmAuEmp.Edit1Exit(Sender: TObject);
begin
if (activecontrol.Name<>'BitBtn1') and (trim(edit1.Text)<>'') then
 try
  frmEmp := TfrmEmp.Create(Application);
  frmEmp.Edit1.Text:=trim(edit1.Text);
 if comparetext(trim(edit1.text),trim(frmEmp.ADOQuery1.Fieldbyname('user_id').AsString))=0 then
  begin
   edit1.Font.Color:=clwindowtext;
   label4.Caption := frmEmp.ADOQuery1.FieldValues['user_full_name'];
   _UID:= frmEmp.ADOQuery1.fieldbyname('rkey').AsString;
  end
 else
  begin
   messagedlg('�û����Ʋ���ȷ,�����������ѡ��',mtinformation,[mbok],0);
   label4.Caption:='';
   edit1.SetFocus;
  end;
 finally
  frmEmp.free;
 end
else
 edit1.Font.Color :=clblue;
end;
//����
procedure TfrmAuEmp.Button1Click(Sender: TObject);
begin
 if trim(edit2.Text)='' then edit2.Text:='0';
 if trim(edit3.Text)='' then edit3.Text:='0';
 try
  strtofloat(trim(edit2.Text));
  strtofloat(trim(edit3.Text));
 except
   on E: Exception do
     begin
      messagedlg('���ޣ����޲�����ֵ������',mtinformation,[mbok],0);
      exit;
     end;
 end;

if trim(edit1.Text)='' then
 begin
  messagedlg('�û����벻��Ϊ��!',mtwarning,[mbcancel],0);
  edit1.SetFocus;
  exit;
 end;
//==============================================================================
if strtofloat(trim(edit3.Text))=0 then
 begin
  messagedlg('��Ҫ�����Ͽ�����!',mtwarning,[mbcancel],0);
  edit3.SetFocus;
  exit;
 end;
//==============================================================================
 ModalResult:=mrok;
end;


end.
