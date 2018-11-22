unit Log;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,IniFiles;

type
  TfrmLog = class(TForm)
    Label1: TLabel;
    edtConStr: TEdit;
    Label2: TLabel;
    edtServer: TEdit;
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure ReadLogInfo;
  public
    { Public declarations }
  end;

var
  frmLog: TfrmLog;

implementation
uses ConstDeclare,Client_Func,DmConn,PUbFunc,SrvQuery_TLB;
{$R *.dfm}

procedure TfrmLog.Button1Click(Sender: TObject);
var
  ErrorMsg:widestring;
begin
  if trim(edtConStr.Text) = '' then
  begin
    ShowMsg('��ȡ���������ַ���ʧ�ܣ�',1);
    abort;
  end;
  with pdmConn do begin
    try
      SocketConnection1.Connected := false;
      SocketConnection1.Address := edtServer.Text;
      SocketConnection1.ServerName := 'SrvQuery.CoQuery';
      SocketConnection1.Connected := true;
    except
      ShowMsg('���ӷ�����ʧ�ܣ�����ϵϵͳ����Ա','��ʾ',1);
      abort;
    end;
    coMyQuery := ICoQueryDisp(IDispatch(pdmConn.SocketConnection1.AppServer));
    if not coMyQuery.Set_Ado_Conn_Str(trim(edtConStr.Text),ErrorMsg) then
    begin
      ShowMsg('��������ʧ�ܣ�'+ErrorMsg,1);
      abort;
    end
    else
      Modalresult := mrok;
  end;
end;

procedure TfrmLog.Button2Click(Sender: TObject);
begin
  close;
end;

procedure TfrmLog.FormShow(Sender: TObject);

    function OpenFile(FileName:string;var ErrorMsg:string):string;//���ļ�
    var
    F: TextFile;
    S: string;
    begin
      try
        AssignFile(F, FileName); { File selected in dialog }
        Reset(F);
        Readln(F, S); { Read first line of file }
        result := S; { Put string in a TEdit control }
        CloseFile(F);
      except
        on E:Exception do
          ErrorMsg:=E.Message;
      end;
    end;
begin
  ReadLogInfo;
//  edtConStr.Text := OpenFile('C:\dbconn\qryConn.cds',tmp);//App_Init;
{
3.Com+�����״̬����
�õĵ�3��ϵͳ,Ӧ������Ӧ����Ŀͻ���,ռ�ø��ٵķ�������Դ.Com+������
}

end;

procedure TfrmLog.ReadLogInfo;
var 
  filename,DBName:string;
  myinifile:TIniFile; 
begin
  filename:=ExtractFilePath(Application.ExeName)+'Login.ini';
  myinifile:=TInifile.Create(filename);
  try
    edtServer.Text:=myinifile.readstring('LogIn_Info','SERVER_IP_SS',' ');
    edtConStr.text:=myinifile.readString('LogIn_Info','CONN_STR_SS',' ');
  finally
    myinifile.free;
  end;
end;

end.
