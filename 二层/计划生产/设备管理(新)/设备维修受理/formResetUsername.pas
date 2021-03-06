unit formResetUsername;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, ADODB, Buttons;

type
  TfrmResetUsername = class(TForm)
    btOK: TButton;
    btCancel: TButton;
    edtUsername: TEdit;
    edtPassword: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    qryTemp: TADOQuery;
    procedure btOKClick(Sender: TObject);
    procedure edtUsernameKeyPress(Sender: TObject; var Key: Char);
    procedure edtPasswordKeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
  private
    procedure MsgError(msg:string);
    { Private declarations }
  public
    { Public declarations }
  end;

Function ShowResetUsernameForm(SelfForm:TForm;AConnection: TADOConnection;
  out AUsernameRkey,AEmployeeRkey,AUser_rights:string;AFormCaption:PChar=nil;
  DefaultLoginName:string=''):Boolean; StdCall;

var
  frmResetUsername: TfrmResetUsername;
  vResetUserRkey:string;
  vEMPLOYEE_PTR,vUser_rights :string;

implementation

uses damo,md5;

{$R *.dfm}

Function ShowResetUsernameForm(SelfForm:TForm;AConnection: TADOConnection;
  out AUsernameRkey,AEmployeeRkey,AUser_rights:string;AFormCaption:PChar=nil;
  DefaultLoginName:string=''):Boolean; StdCall;
//var
//  s:string;
//  i:Integer;
begin
  Result:=False;
  try
    frmResetUsername:=TfrmResetUsername.Create(Application);
    frmResetUsername.Font.Size    := SelfForm.Font.Size;
    frmResetUsername.Font.Charset := SelfForm.Font.Charset;
    frmResetUsername.Font.Name    := SelfForm.Font.Name;
    with  frmResetUsername do
    begin
      if  AFormCaption='' then
        Caption:='以其他用户操作'
      else
        Caption:=AFormCaption;

      qryTemp.Connection:= AConnection;
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
    MsgError('用户名不能为空！' );
    edtUsername.SetFocus;
    Exit;
  end;
  if Trim(edtPassword.Text) ='' then
  begin
    MsgError('密码不能为空！' );
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
      MsgError('用户名不存在，请重新输入！');
      edtUsername.SetFocus ;
      Exit;
    end;
    if FieldValues['PASSWORD']<>MD5Print(MD5String(trim(edtPassword.Text))) then
    begin
      MsgError('密码不正确，请重新输入！');
      edtPassword.SetFocus;
      Exit;
    end;
    vResetUserRkey:= FieldValues['rkey'] ;           //如果用户名和密码通过后，设置当前重新输入用户名的RKEY的值。
    vEMPLOYEE_PTR:=  FieldValues['EMPLOYEE_PTR'] ;

    Close;
    SQL.Clear;
    SQL.Text:='select * from data0419 where programe='+QuotedStr(Extractfilename(application.exename));
    Open;
    if  IsEmpty then
    begin
      MsgError('在Data0419表中没有找到'+Extractfilename(application.exename)+'的记录！');
      Exit;
    end;
    vFunction_id  :=FieldValues['rkey'];           //获取当前程序在 data0419表中的RKEY值

    Close;
    SQL.Clear;
    SQL.Text:='select user_rights from data0074 where user_ptr='+vResetUserRkey+' and function_id ='+vFunction_id;
    Open;
    vUser_rights := FieldValues['user_rights'];
    close;
  end;
  
  ModalResult:=mrOk;
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
  btOK.Click;
end;

procedure TfrmResetUsername.FormShow(Sender: TObject);
begin
  edtUsername.SetFocus;
  if edtUsername.Text<>'' then
  edtUsername.SelectAll;       
end;

end.
