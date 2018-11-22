unit formGetUserRights;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, ADODB, DBClient;

type
  TfrmGetUserRights = class(TForm)
    btOK: TButton;
    btCancel: TButton;
    edtUsername: TEdit;
    edtPassword: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    cdsTemp: TClientDataSet;
    ADODataSet1: TADODataSet;
    procedure btOKClick(Sender: TObject);
    procedure btCancelClick(Sender: TObject);
    procedure edtUsernameKeyPress(Sender: TObject; var Key: Char);
    procedure edtPasswordKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
  private
   // cdsTemp:TClientDataSet;
    procedure MsgError(msg:string);
    { Private declarations }
  public
    { Public declarations }
  end;

Function GetUserRights(SelfForm:TForm;Aconn: TADOConnection;
  out AUsernameRkey,AEmployeeRkey,AUser_rights:string;AFormCaption:PChar=nil;
  DefaultLoginName:string=''):Boolean; StdCall;

var
  frmGetUserRights: TfrmGetUserRights;

  vResetUserRkey:string;
  vEMPLOYEE_PTR,vUser_rights :string;

implementation

uses md5;

{$R *.dfm}

Function GetUserRights(SelfForm:TForm;Aconn: TADOConnection;
  out AUsernameRkey,AEmployeeRkey,AUser_rights:string;AFormCaption:PChar=nil;
  DefaultLoginName:string=''):Boolean; StdCall;
//var
//  s:string;
//  i:Integer;
begin
  Result:=False;
 // Application.Handle:=AHandle;
  try
    frmGetUserRights:=TfrmGetUserRights.Create(Application);
    frmGetUserRights.Font.Size    := SelfForm.Font.Size;
    frmGetUserRights.Font.Charset := SelfForm.Font.Charset;
    frmGetUserRights.Font.Name    := SelfForm.Font.Name;
    with  frmGetUserRights do
    begin
      if  AFormCaption='' then
        Caption:='�������û�����'
      else
        Caption:=AFormCaption;
      with ADODataSet1 do
      begin
        Connection:=Aconn;
      end;
     { cdsTemp.ProviderName:= CDataSet.ProviderName;
      with  CDataSet do
      begin
        cdsTemp.ProviderName:= ProviderName;
        if RemoteServer<>nil then
        cdsTemp.RemoteServer:=RemoteServer;
      end; }

      if  DefaultLoginName<>'' then
        edtUsername.Text:=DefaultLoginName;

      if ShowModal=mrOk then
      begin
        AUsernameRkey := vResetUserRkey;
        AEmployeeRkey := vEMPLOYEE_PTR;
        AUser_rights  := vUser_rights;
        Result:=True;
      end;
    end ;
  finally
    frmGetUserRights.Free;
  end;
end;

procedure TfrmGetUserRights.MsgError(msg:string);
begin
  messagedlg(msg,mterror,[mbok],0);
end;

procedure TfrmGetUserRights.btOKClick(Sender: TObject);
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
  with ADODataSet1 do      // cdsTemp
  begin
    Close;
    CommandText:='select rkey,EMPLOYEE_PTR,Password from data0073 where user_Login_name='+QuotedStr(edtUsername.Text);
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
    CommandText:='select * from data0419 where programe='+QuotedStr(Extractfilename(application.exename));
    Open;
    if  IsEmpty then
    begin
      MsgError('��Data0419����û���ҵ�'+Extractfilename(application.exename)+'�ļ�¼��');
      Exit;
    end;
    vFunction_id  :=FieldValues['rkey'];           //��ȡ��ǰ������ data0419���е�RKEYֵ

    Close;
    CommandText:='select user_rights from data0074 where user_ptr='+vResetUserRkey+' and function_id ='+vFunction_id;
    Open;
    vUser_rights :=IntToStr( FieldByName('user_rights').AsInteger);
    close;
  end;
  
  ModalResult:=mrOk;
end;

procedure TfrmGetUserRights.btCancelClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmGetUserRights.edtUsernameKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key=#13 then
  if Trim((Sender as TEdit).Text)<>'' then
  edtPassword.SetFocus;
end;

procedure TfrmGetUserRights.edtPasswordKeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key=#13 then
  if Trim((Sender as TEdit).Text)<>'' then
  btOK.Click;
end;

procedure TfrmGetUserRights.FormShow(Sender: TObject);
begin
  edtUsername.SetFocus;
  if edtUsername.Text<>'' then
  edtUsername.SelectAll;
  
end;

end.
