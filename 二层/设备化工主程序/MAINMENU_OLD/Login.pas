unit Login;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ExtCtrls, StdCtrls, Mask,winsock, jpeg;

type
  TFrmLogin = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TMaskEdit;
    Edit2: TMaskEdit;
    Panel1: TPanel;
    Image1: TImage;
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Edit2KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmLogin: TFrmLogin;

implementation
uses datamodule;

{$R *.DFM}

procedure TFrmLogin.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
IF KEY=#13 THEN edit2.setfocus
end;

procedure TFrmLogin.Edit2KeyPress(Sender: TObject; var Key: Char);
var
  vstr:array[0..15] of char;
  vstring:string;
  i:integer;

  wVersionRequested : WORD;
  wsaData : TWSAData;
  s : array[0..128] of char;
  p : PHostEnt;
  p2 : pchar;
begin
 IF KEY=#13 THEN
  begin
    With DM.ADOData0073 do
    begin
      close;
      parameters.ParamByName('@vptr').Value :=trim(Edit1.text);
      open;
    end;
    if DM.ADOData0073.eof  then
    begin
      Messagedlg('�û�������ȷ�����������룡',mtinformation,[mbOk],0);
      DM.ADOData0073.Close;
      Edit1.SetFocus ;
      exit;
    end;
    strpcopy(vstr,'*'+trim(DM.ADOData0073.fieldbyname('user_password').asstring)+'*');
    vstring:='';
    for i:=0 to 14 do
      if trim(vstr[i])<>'' then
        vstring:=vstring+chr( (word(vstr[i]) shr 1)-3);

    vstring:=copy(trim(vstring),2,length(trim(vstring))-2);
    if ansiuppercase(VString) <>ansiuppercase(trim(edit2.Text)) then
    begin
      Messagedlg('���벻��ȷ�����������룡',mtinformation,[mbOk],0);
      DM.ADOData0073.Close;
      edit2.SetFocus ;
      exit;
    end;

 {   DM.ADOUsers.close;
    DM.ADOUsers.open;
    if DM.ADOUsers.fieldbyname('user_qty').asinteger>5 then
    begin
      messagedlg('��ǰ�����û������Ѿ��ﵽ'+DM.ADOUsers.fieldbyname('user_qty').asstring+'����ȵ������û��˳�����ܵ�¼��',mtinformation,[mbok],0);
      dm.ADOData0073.Close;
      close;
      exit;
    end;
  }
    {���� WinSock}
 {   wVersionRequested := MAKEWORD(1, 1);
    WSAStartup(wVersionRequested, wsaData);

    //�������
    GetHostName(@s, 128);
    p := GetHostByName(@s);
    //IP��ַ
    p2 := iNet_ntoa(PInAddr(p^.h_addr_list^)^);

    if Trim(DM.ADOData0073.fieldbyname('network_id').asstring)<>'' then
    if trim(DM.ADOData0073.fieldbyname('computer').asstring)<>trim(p^.h_Name) then
    begin
      Messagedlg('���ʺ��Ѿ���'+trim(DM.ADOData0073.fieldbyname('computer').asstring)+'��¼�������ظ���¼��',mtinformation,[mbOk],0);
      DM.ADOData0073.Close;
      Edit1.SetFocus ;
      exit;
    end;

    DM.ADODate.Close ;
    DM.ADODate.Open;
    DM.ADOData0073.Edit;
    DM.ADOData0073.fieldbyname('network_id').asstring:=p2;
    DM.ADOData0073.fieldbyname('login_in_time').asdatetime:=dm.Adodate.fieldbyname('vdt').AsDateTime;
    DM.ADOData0073.fieldbyname('computer').asstring:=p^.h_Name;
    DM.ADOData0073.post;

    WSACleanup;   }

    close;
  end;
end;

end.
