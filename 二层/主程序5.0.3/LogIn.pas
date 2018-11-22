unit LogIn;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,Inifiles, DB, ADODB,Winsock, RzCmboBx, Mask, RzEdit,
  RzButton, ExtCtrls, RzPanel, Buttons,DateUtils, IdBaseComponent,
  IdComponent, IdTCPConnection, IdTCPClient,IdFTP,ShellApi;

type
  TfrmLogin = class(TForm)
    RzGroupBox1: TRzGroupBox;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    SpeedButton1: TSpeedButton;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    ComboBox3: TComboBox;
    Edit1: TEdit;
    IdFTP1: TIdFTP;
    Button1: TBitBtn;
    Button2: TBitBtn;
    procedure FormActivate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Edit1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Tab(Sender: TObject; var Key: Word;
     Shift: TShiftState);
    procedure ComboBox2Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
   program_ini:Tinifile;
   procedure indert_173(v_type:Boolean);
   function findlogin_error(rkey73:Integer):Boolean;
   function return_logininformation(rkey73:Integer):string;
  public
    { Public declarations }
  end;

var
  frmLogin: TfrmLogin;

implementation

uses damo,common,Md5,main,ConstVar;

{$R *.dfm}

procedure TfrmLogin.Tab(Sender: TObject; var Key: Word;
  Shift: TShiftState);
Begin
  if (key=VK_Down) or (key=13) then
   SelectNext(ActiveControl,True,True);
  if key=VK_Up then
   SelectNext(ActiveControl,False,True);
  Key:=0;
end;

procedure TfrmLogin.FormCreate(Sender: TObject);
begin
  Cur_Dir:=uppercase(extractfilepath(paramstr(0)));
end;

procedure TfrmLogin.FormActivate(Sender: TObject);
var
 LS: TStringList;
 filename,main_programe:string;
 main_program_ini:Tinifile;
 Local_Ver_Info: PFile_Ver_INfo;
 process:Integer;
begin
 LS := TStringList.Create;
 filename:=Cur_Dir+'WISDOMPCB.INI';
 main_programe:=Cur_Dir+'MAINPROGRAM.INI';

 program_ini:=Tinifile.Create(filename);
 main_program_ini:=Tinifile.Create(main_programe);

 FTP_SRV_IP:=program_ini.ReadString('FTP������','������IP','');
 FTP_User:=program_ini.ReadString('FTP������','�û���','');
 FTP_Pswd:=program_ini.ReadString('FTP������','����','');

 self.IdFTP1.Host := FTP_SRV_IP;      //ftp����
 self.idftp1.Username := FTP_User;    //ftp�û�
 self.idftp1.Password := FTP_Pswd;    //ftp����

  try
   if not idftp1.Connected then idftp1.Connect;
   if idftp1.Connected then
    begin
     IdFTP1.ChangeDir('/EXEC');
     idftp1.List(LS,'MAINPROGRAM.INI',true);
     if IdFTP1.DirectoryListing.Items[0].ModifiedDate >
       Get_File_Modify_Time(main_programe) then
      try
       IdFTP1.Get(uppercase(trim(IdFTP1.DirectoryListing.Items[0].FileName)),
            main_programe,true,false);
      except
       showmsg('�������������°汾�ļ�ʧ��:'+main_programe,1);
      end;
    end;
  except
   idftp1.Disconnect;
   idftp1.Abort;
   idftp1.Quit;
  end;
  Local_Ver_Info := GetFileVersion(application.ExeName);    // �ж��������Ƿ������µİ汾
  if main_program_ini.ReadString('������','�汾','')<>Local_Ver_Info.FileVersion then
  if Msg_Dlg_Ask('���������������°汾�Ƿ��������³���?','������ʾ',1) then
   begin
    process:=GetCurrentProcessId;
    shellexecute(0,'open',pchar(Cur_Dir+'update_progarm.exe'),PChar(IntToStr(process)),nil,sw_show);
    close;
    Application.Terminate;
   end;
  try
   if not idftp1.Connected then idftp1.Connect;
   if idftp1.Connected then
    begin
     IdFTP1.ChangeDir('/EXEC');
     idftp1.List(LS,'WISDOMPCB.INI',true);
     if IdFTP1.DirectoryListing.Items[0].ModifiedDate >
       Get_File_Modify_Time(filename) then
      try
       IdFTP1.Get(uppercase(trim(IdFTP1.DirectoryListing.Items[0].FileName)),
            FileName,true,false);
      except
       showmsg('���������ļ�ʧ��:'+FileName,1);
      end;
     idftp1.Disconnect;
    end;
  except
   idftp1.Disconnect;
   idftp1.Abort;
   idftp1.Quit;
  end;
 program_ini.ReadSection('���ݿ�',combobox2.Items);
 program_ini.ReadSection('�û�',combobox3.Items);

 combobox2.ItemIndex:=program_ini.ReadInteger('Ĭ������','���ݿ�',0);
 combobox1.Text:=program_ini.ReadString('������',combobox2.Text,'');
 combobox3.Text:=program_ini.ReadString('Ĭ���û�','�û���','');

 if trim(combobox3.Text)<>'' then
  edit1.SetFocus
 else
  combobox3.SetFocus;
end;

procedure TfrmLogin.indert_173(v_type: Boolean);
begin
 with dm.adsTmp do
  begin
    close;
    sql.Text:='INSERT INTO DATA0173'+#13+
    '(csi_ptr, compute_name, network_ip, login_date, type,active_flag)'+#13+
    'VALUES ('+dm.ADOData0073RKEY.AsString+','+QuotedStr(GetLocalName)+','+#13+
    QuotedStr(GetLocalIP)+',getdate()'+#13+
    ','+inttostr(Ord(v_type))+',1)';
    ExecSQL;
  end;
 if v_type then
 with dm.adsTmp do
  begin
    close;
    sql.Text:='update DATA0173'+#13+
             'set active_flag=0'+#13+
             'where  type=0'+#13+
             'and csi_ptr='+dm.ADOData0073RKEY.AsString;
    ExecSQL;
  end;
end;

function TfrmLogin.findlogin_error(rkey73: Integer): Boolean;
var
  logindate:TDateTime;
  recordcount:Integer;
begin
 with dm.adsTmp do
 begin
   close;
   sql.Text:='select top 3 csi_ptr,login_date from data0173 '+
             'where csi_ptr='+inttostr(rkey73)+
             ' and type=0 and active_flag=1 '+
             'order by login_date desc';
   open;
 end;
 recordcount := dm.adsTmp.RecordCount;
 if not dm.adsTmp.IsEmpty then
  logindate:=dm.adsTmp.FieldValues['login_date']
 else
  logindate:=Now;
 if (recordcount >= 3) and (MinutesBetween(logindate,getsystem_date(dm.adsTmp,0))<= 240)then
  Result := True
 else
  Result := false;
end;

function TfrmLogin.return_logininformation(rkey73: Integer): string;
begin
 with dm.adsTmp do
 begin
   close;
   sql.Text:='select top 1 network_ip,compute_name,login_date from data0173 '+
             'where csi_ptr='+inttostr(rkey73)+
             ' and type=1 '+
             'order by login_date desc';
   open;
   if not IsEmpty then
    Result:='����������:'+fieldbyname('login_date').AsString+#13+
             '����:'+fieldbyname('compute_name').AsString+',IP:'+
             fieldbyname('network_ip').AsString
   else
    Result:='';
 end;
end;

procedure TfrmLogin.Button1Click(Sender: TObject);
var
  title_name:string;
  vprog:pchar;
  ZAppName: array[0..127] of char;
  Found: HWND;
begin
 if trim(combobox1.Text)='' then
  begin
   showmessage('������ERP������������!');
   combobox1.SetFocus;
  end
 else
 begin
  try
    screen.Cursor := crHourglass;
    if dm.adoconnection1.Connected then dm.ADOConnection1.Connected:=false;
     dm.adoconnection1.ConnectionString:=
     'Provider=SQLOLEDB.1;Password='+Base64_Decode('PAGHinBrPnB1WAYbKz46')+
     ';Persist Security Info=True;User ID='+Base64_Decode('P6THWh')+';';
    dm.adoconnection1.ConnectionString:=
          dm.adoconnection1.ConnectionString+'Initial Catalog='+
          program_ini.ReadString('���ݿ�',combobox2.Text,'')+';';
    dm.adoconnection1.ConnectionString:=
    dm.adoconnection1.ConnectionString+'Data Source=' + trim(combobox1.Text);
    dm.adoconnection1.Connected := true;
  except
   showmessage('���ݿ����Ӳ��ɹ���������������Ƿ���ȷ��');
   screen.Cursor:= crDefault;
   combobox2.SetFocus;
   exit;
  end;

  with dm do begin
   adsTmp.close;
   adsTmp.SQL.Text:='select ENG_MI_FILE_NO,part_location from data0192';
   adsTmp.open;
  end;

  if  dm.adsTmp.Fieldbyname('part_location').AsString<>
  MD5Print(MD5String(Base64_Encode(dm.adsTmp.Fieldbyname('ENG_MI_FILE_NO').AsString))) then
  begin
    dm.adoconnection1.Connected := false;
    screen.Cursor:= crDefault;
    Messagedlg('���������к��ѹ���,���������Ӧ����ϵ!',mterror,[mbcancel],0);
    exit;
  end;

  dm.ADOData0073.Close;
  dm.ADOData0073.Parameters.ParamValues['login_id']:=TRIM(combobox3.Text);
  dm.ADOData0073.Open;

 if dm.ADOData0073.IsEmpty then  //�û�������ȷ
  begin
   showmessage('�û�������ȷ,����������');
   combobox3.Text:='';
   combobox3.SetFocus;
   screen.Cursor:= crDefault;
  end
 else       //�û�����ȷ�ж������Ƿ���ȷ
  begin
   if self.findlogin_error(DM.ADOData0073RKEY.Value) then
   begin
    Messagedlg('�û��������������������,��4��Сʱ������!',mtinformation,[mbOk],0);
    edit1.SetFocus ;
    dm.adoconnection1.Connected := false;
    screen.Cursor:= crDefault;
   end
   else
   if (MD5Print(MD5String(trim(edit1.Text))) <> trim(dm.adodata0073PASSWORD.value))
     and (trim(dm.ADOData0073PASSWORD.value)<>'') then
   begin
    Messagedlg('���벻��ȷ,��ע�����ִ�Сд��',mtinformation,[mbOk],0);
    indert_173(False);
    combobox3.Text:='';
    edit1.Text:='';
    edit1.SetFocus ;
    dm.adoconnection1.Connected := false;
    screen.Cursor:= crDefault;
   end
  else
   if (trim(dm.ADOData0073NETWORK_IP.Value) <> '') and  //���޶�IP,δʹ��ָ��IP����
      (trim(dm.ADOData0073NETWORK_IP.Value) <> GetLocalIP)  then
    begin
     Messagedlg('�û����IP�����쳣���������Ա��ϵ!',mterror,[mbcancel],0);
     dm.adoconnection1.Connected := false;
     screen.Cursor:= crDefault;
    end
   else
   if (trim(dm.ADOData0073COMPUTER.Value)<>'') and
      (UpperCase(trim(dm.ADOData0073COMPUTER.Value))<>UpperCase(GetLocalName))  then
    begin
     Messagedlg('���û��Ѿ��ڵ�����'+dm.ADOData0073COMPUTER.Value+
     '����'+dm.ADOData0073LOGIN_IN_TIME.AsString+'����,�������˳�!',mterror,[mbcancel],0);
     dm.adoconnection1.Connected := false;
     screen.Cursor:= crDefault;
    end
   else
    begin
     dm.ASPSYSUSERLIFE.Close;
     dm.ASPSYSUSERLIFE.ExecProc;
     if dm.ASPSYSUSERLIFE.Parameters.ParamValues['@active']=false then
      begin
       showmsg('�����ļ�֤�鵽��,���빩Ӧ����ϵ!',1);
       dm.adoconnection1.Connected:=false;
       screen.Cursor:= crDefault;
      end
     else
      with Tform_main.Create(application)do
      try
       password:=trim(self.Edit1.text);
       application.Title:=application.Title+self.combobox2.Text;
       title_name:= application.Title;
       application.Title:='OnlyOne'+ IntToStr(HInstance);
       vprog:=pchar(title_name);
       strpcopy(ZAppName,vprog);       Found := FindWindow(nil,ZAppName);       if Found <> 0 then        begin         ShowWindow(Found, SW_SHOWMINIMIZED);         ShowWindow(Found, SW_SHOWNORMAL);         self.close;         application.Terminate;         exit;        end;
       application.Title := title_name;

       program_ini.WriteString('�û�',combobox3.Text,'');
       program_ini.WriteString('Ĭ���û�','�û���',combobox3.Text);
       program_ini.WriteInteger('Ĭ������','���ݿ�',combobox2.ItemIndex);
       dm.ADOData0073.Edit;
       dm.ADOData0073.FieldValues['NETWORK_ID']:= GetLocalIP;
       dm.ADOData0073.FieldValues['COMPUTER']:= GetLocalName;
       dm.ADOData0073.FieldValues['LOGIN_IN_TIME']:=getsystem_date(dm.adsTmp,0);
       dm.ADOData0073.Post;

       Label2.Caption:=return_logininformation(dm.ADOData0073RKEY.Value);
       Self.indert_173(True);
       user_ptr:=dm.ADOData0073.fieldbyName('rKey').AsString;
       rkey73:=dm.ADOData0073.fieldbyName('rKey').AsString;
       screen.Cursor:= crDefault;

       frmlogin.hide;
       Statusbar1.Panels[2].Text :=dm.ADOData0073USER_full_name.Value;  //�û���
       Statusbar1.Panels[1].Text :=self.ComboBox2.Text;   //���ݿ�
       Statusbar1.Panels[0].Text :=self.combobox1.Text;  //������
       Action6.Enabled:=dm.ADOData0073RKEY.Value=1;

       if ShowModal=mrcancel then
        button2click(sender);
      finally
       free;
      end;

    end;
  end;

 end;
end;

procedure TfrmLogin.Edit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key=13 then  Button1Click(sender);
end;

procedure TfrmLogin.SpeedButton1Click(Sender: TObject);
var
 i:integer;
begin
for i:=1 to combobox3.Items.Count do
 program_ini.DeleteKey('�û�',combobox3.Items[i-1]);
combobox3.Items.Clear;
combobox3.Text :='';
end;

procedure TfrmLogin.Button2Click(Sender: TObject);
begin
 close;
 application.Terminate;
end;

procedure TfrmLogin.ComboBox2Change(Sender: TObject);
begin
 combobox1.Text:=program_ini.ReadString('������',combobox2.Text,'');
end;

procedure TfrmLogin.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
 CanClose:=False;
 Application.Minimize;
end;

end.
