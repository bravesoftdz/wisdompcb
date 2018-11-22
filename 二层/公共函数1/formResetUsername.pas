unit formResetUsername;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, ADODB;

type
  TfrmResetUsername = class(TForm)
    btOK: TButton;
    btCancel: TButton;
    edtUsername: TEdit;
    edtPassword: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    procedure btOKClick(Sender: TObject);
    procedure btCancelClick(Sender: TObject);
    procedure edtUsernameKeyPress(Sender: TObject; var Key: Char);
    procedure edtPasswordKeyPress(Sender: TObject; var Key: Char);
  private
    procedure MsgError(msg:string);
    { Private declarations }
  public
    { Public declarations }
  end;

Function ShowResetUsernameForm(AHandle:THandle;var AADOQuery: TADOQuery;
  out AUsernameRkey,AEmployeeRkey,AUser_rights:string;AFormCaption:PChar=nil):Boolean; StdCall;

var
  frmResetUsername: TfrmResetUsername;
  qryTemp:TADOQuery;
  vResetUserRkey:string;
  vEMPLOYEE_PTR,vUser_rights :string;

implementation

uses md5;

{$R *.dfm}

Function ShowResetUsernameForm(AHandle:THandle;var AADOQuery: TADOQuery;
  out AUsernameRkey,AEmployeeRkey,AUser_rights:string;AFormCaption:PChar=nil):Boolean; StdCall;
var
  s:string;
  i:Integer;
begin
  Result:=False;
  Application.Handle:=AHandle;
  try
    frmResetUsername:=TfrmResetUsername.Create(Application);
    with  frmResetUsername do
    begin
      if  AFormCaption='' then
        Caption:='�������û�����'
      else
        Caption:=AFormCaption;

      qryTemp:= AADOQuery;

      if ShowModal=mrOk then
      begin
        AUsernameRkey := vResetUserRkey;
        AEmployeeRkey := vEMPLOYEE_PTR;
        AUser_rights  := vUser_rights;
        Result:=True;
      end;
    end ;
  finally
    frmResetUsername.Free;
  end;
end;

procedure TfrmResetUsername.MsgError(msg:string);
begin
  messagedlg(msg,mterror,[mbok],0);
end;

procedure TfrmResetUsername.btOKClick(Sender: TObject);
var
  vFunction_id :string ;

begin
  if Trim(edtUsername.Text) ='' then
  begin
    MsgError('�û�������Ϊ�գ�' );
    edtUsername.SetFocus;
    Exit;
  end;
  if Trim(edtPassword.Text) ='' then
  begin
    MsgError('���벻��Ϊ�գ�' );
    edtPassword.SetFocus;
    Exit;
  end;
  with qryTemp do
  begin
    Close;
    SQL.Clear;
    SQL.Text:='select rkey,EMPLOYEE_PTR,Password from data0073 where user_Login_name='+QuotedStr(edtUsername.Text);
    Open;
    if  IsEmpty then
    begin
      MsgError('�û��������ڣ����������룡');
      edtUsername.SetFocus ;
      Exit;
    end;
    if FieldValues['PASSWORD']<>MD5Print(MD5String(trim(edtPassword.Text))) then
    begin
      MsgError('���벻��ȷ�����������룡');
      edtPassword.SetFocus;
      Exit;
    end;
    vResetUserRkey:= FieldValues['rkey'] ;           //����û���������ͨ�������õ�ǰ���������û�����RKEY��ֵ��
    vEMPLOYEE_PTR:=  FieldValues['EMPLOYEE_PTR'] ;

    Close;
    SQL.Clear;
    SQL.Text:='select * from data0419 where programe='+QuotedStr(Extractfilename(application.exename));
    Open;
    if  IsEmpty then
    begin
      MsgError('��Data0419����û���ҵ�'+Extractfilename(application.exename)+'�ļ�¼��');
      Exit;
    end;
    vFunction_id  :=FieldValues['rkey'];           //��ȡ��ǰ������ data0419���е�RKEYֵ

    Close;
    SQL.Clear;
    SQL.Text:='select user_rights from data0074 where user_ptr='+vResetUserRkey+' and function_id ='+vFunction_id;
    Open;
    vUser_rights := FieldValues['user_rights'];
    close;
  end;
  
  ModalResult:=mrOk;
end;

procedure TfrmResetUsername.btCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmResetUsername.edtUsernameKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key=#13 then
  if Trim((Sender as TEdit).Text)<>'' then
  edtPassword.SetFocus;
end;

procedure TfrmResetUsername.edtPasswordKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key=#13 then
  if Trim((Sender as TEdit).Text)<>'' then
  btOK.SetFocus;
end;

end.
