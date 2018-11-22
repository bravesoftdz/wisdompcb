//*******************************//
//*���FTP�ϴ�����ɾ���ļ��Ĺ���*//
//*******By lrl 2014.04.25*******//
//*******************************//
unit uMain;

interface

uses System.Classes, Controls, Vcl.Dialogs, System.SysUtils, IdFTP, IdFTPCommon,
     IdFTPList, IniFiles, IdComponent;

const base64 = 'oeJzcNn7YV5ZKv+EhQaC3Xu/WiO24PDylRdqkGjI9TwUFrxL1bMHfpA6gsSt0Bm8';
type
  TMyClass = class(TObject)
    IdFTP1: TIdFTP;
    function ConnectFTP(Host, UId, PSW, FileDir: string):Boolean;stdcall;  //����FTP
  private
    IP,UID,PSW,FileDir: string;
    function Base64_Decode(a: string): string;stdcall;
    function mimedecode(a: string): Integer;stdcall;
  public
    function UpLoadFTP(FileName: PAnsiChar):Boolean;stdcall;    //�ϴ��ļ�
    function DownLoadFTP(DataBaseFileName,dlgFileName: PAnsiChar):Boolean;stdcall;  //�����ļ�
    function DeleteFTP(FileName: PAnsiChar):Boolean;stdcall;    //ɾ���ļ�
  constructor Create;
  destructor Destroy;
end;

implementation

{ TMyClass }

function TMyClass.Base64_Decode(a: string): string;
var
  w1,w2,w3,w4,n: Integer;
  retry: string;
begin
  n := 1;
  while n <= Length(a) do begin
    w1 := mimedecode(a[n]);
    w2 := mimedecode(a[n + 1]);
    w3 := mimedecode(a[n + 2]);
    w4 := mimedecode(a[n + 3]);
    if w2 >= 0 then retry := retry + chr(((w1 * 4 + Trunc(w2 / 16)) and 255));
    if w3 >= 0 then retry := retry + chr(((w2 * 16 + Trunc(w3 / 4)) and 255));
    if w4 >= 0 then retry := retry + chr(((w3 * 64 + w4) and 255));
    n := n + 4;
  end;
  result := retry;
end;

function TMyClass.ConnectFTP(Host, UId, PSW, FileDir: string): Boolean;
var
  vList: TStrings;
begin
  Result:= False;
  try
    IdFTP1.Passive := True; //����ģʽ:����ģʽ
    IdFTP1.Host := Host;
    IdFTP1.Username := UId;  //FTP�������û���
    IdFTP1.Password := PSW;  //FTP����������
    IdFTP1.ReadTimeout := 18000;
    IdFTP1.ConnectTimeout := 18000;  //��ʱʱ�䣬��λ����
    IdFTP1.Connect();  //���ӵ�ftp
    IdFTP1.ChangeDir(FileDir);  //����FileDir:=BJ_Data��Ŀ¼{��ʼĿ¼IdFTP1.RetrieveCurrentDir}
    vList:= TStringList.Create;
    try
      IdFTP1.List(vList);  //�õ�BJ_DataĿ¼�������ļ��б�
    finally
      vList.Free;
    end;
    Result:= True;
//    ShowMessage('����FTP�������ɹ�!');
  except
    Showmessage('����FTP������ʧ��!');
    Exit;
  end;
end;

constructor TMyClass.Create;
var
  MyIniFile: TIniFile;
begin
  IdFTP1:= TIdFTP.Create(nil);
  MyIniFile:= TIniFile.Create(ExtractFilePath(ParamStr(0))+'FTP_Link.ini');
  try
    IP:= MyIniFile.ReadString('FTP������','������IP','172.18.0.15');
    UID:= MyIniFile.ReadString('FTP������','�û���','erpmk');
    PSW:= Base64_Decode(MyIniFile.ReadString('FTP������','����','i/V12ur1WAY'));  //���ܺ�:erpmkpcb
    FileDir:=MyIniFile.ReadString('FTP������','����ʱЧ�ĵ�Ŀ¼','BJ_Data');
  finally
    MyIniFile.Free;
  end;
end;

function TMyClass.DeleteFTP(FileName: PAnsiChar): Boolean;
var
  i: Integer;
  t: TIdFTPListItem;
  setMark: string;
begin
  Result:= False;
  if not IdFTP1.Connected then
  begin
    if ConnectFTP(IP,UID,PSW,FileDir) then
    begin
      try
//        IdFTP1.TransferType:= ftBinary;
        for i:= 0 to IdFTP1.DirectoryListing.Count - 1 do
        begin
          t:= IdFTP1.DirectoryListing.Items[i];  //�ӵ�ǰĿ¼���ļ����б�õ��ļ������Ϣ
          if t.FileName = strpas(FileName) then
          begin
            setMark:= 'Find';
            try
              if IdFTP1.DirectoryListing.Items[i].ItemType = ditFile then  //������ļ�
              begin
                IdFTP1.Delete(t.FileName);
              end;
              ShowMessage('�ļ�ɾ���ɹ�!');
              Result:= True;
            except
              ShowMessage('�ļ�ɾ��ʧ��!');
              Abort;
            end;
          end;
        end;
        if setMark <> 'Find' then
          ShowMessage('δ�ҵ���Ҫɾ�����ļ�!');
      finally
        IdFTP1.Disconnect;
      end;
    end;
  end;
end;

destructor TMyClass.Destroy;
begin
  if Assigned(IdFTP1) then
    IdFTP1.Free;
end;

function TMyClass.DownLoadFTP(DataBaseFileName, dlgFileName: PAnsiChar): Boolean;
var
  i: integer;
  t: TIdFTPListItem;
  setMark: string;
begin
  Result:= False;
  if not IdFTP1.Connected then
  begin
    if ConnectFTP(IP,UID,PSW,FileDir) then
    begin
      try
        IdFTP1.TransferType:= ftBinary;  //ָ��Ϊ�������ļ� ���ı��ļ�ftASCII
        for i:= 0 to IdFTP1.DirectoryListing.Count - 1 do
        begin
          t:= IdFTP1.DirectoryListing.Items[i];  //�ӵ�ǰĿ¼���ļ����б�õ��ļ������Ϣ
          if t.FileName = strpas(DataBaseFileName) then
          begin
            setMark:= 'Find';
            try
              if IdFTP1.DirectoryListing.Items[i].ItemType = ditFile then  //������ļ�
              begin
                if FileExists(strpas(dlgFileName)) then
                  if MessageDlg('���ļ��Ѵ���,�Ƿ񸲸�?',mtConfirmation,[mbYes,mbNo],0) = mrNo then Exit;
                IdFTP1.Get(t.FileName,strpas(dlgFileName),False,True);  //���ص�����,����,֧�ֶϵ�����
//                if Pos('.',ExtractFileName(strpas(dlgFileName)))<=0 then
//                  RenameFile(strpas(dlgFileName),strpas(dlgFileName)+ExtractFileExt(strpas(DataBaseFileName)) );//Ϊ���ص��ļ����Ϻ�׺
              end;
              ShowMessage('�ļ����سɹ�!');
              Result:= True;
            except
              on E: Exception do
              begin
                ShowMessage('�ļ�����ʧ��!');
                Abort;
              end;
            end;
            //Break;  //��ͬ�ļ���׺��Ҫ�������
          end;
        end;
        if setMark <> 'Find' then
          ShowMessage('δ�ҵ���Ҫ���ص��ļ�!');
      finally
        IdFTP1.Disconnect;
      end;
    end;
  end;
end;

function TMyClass.mimedecode(a: string): Integer;
begin
  if Length(a) = 0 then
  begin
    Result := -1;
    Exit;
  end;
  Result := pos(a, base64) - 1;
end;

function TMyClass.UpLoadFTP(FileName: PAnsiChar): Boolean;
var
  i,j: Integer;
  setMark: string;
begin
  Result:= False;
  if not IdFTP1.Connected then
  begin
    if ConnectFTP(IP,UID,PSW,FileDir) then
    begin
      try
        try
          for i:= 0 to IdFTP1.DirectoryListing.Count - 1 do
          begin
            if IdFTP1.DirectoryListing.Items[i].FileName = ExtractFileName(strpas(FileName)) then
            begin
              setMark:= 'Find';
              Break;
            end;
          end;
          if setMark = 'Find' then
          begin
            ShowMessage('���ļ���FTP���������Ѵ���,��������!');
            Exit;
//            if MessageDlg('���ļ���FTP���������Ѵ���,�Ƿ񸲸�?',
//                           mtConfirmation,[mbYes,mbNo],0) = mrNo then Exit;
          end;
          if IdFTP1.Connected then
          begin
            IdFTP1.TransferType := ftBinary;
            IdFTP1.Put(strpas(FileName),ExtractFileName(strpas(FileName)));  //�ϴ�
          end;
          ShowMessage('�ļ��ϴ��ɹ�!');
          Result:= True;
        except
          ON E:Exception do
          begin
            IdFTP1.Abort;
            for j:= 0 to IdFTP1.DirectoryListing.Count - 1 do  //��ɾ���ϴ�ʧ�ܵ��ļ�
            begin
              if IdFTP1.DirectoryListing.Items[j].FileName = strpas(FileName) then
              begin
                if IdFTP1.DirectoryListing.Items[j].ItemType = ditFile then  //������ļ�
                  IdFTP1.Delete(IdFTP1.DirectoryListing.Items[j].FileName);
              end;
            end;
            ShowMessage('�ļ��ϴ�ʧ��!'+#13+E.Message);
            Abort;
          end;
        end;
      finally
        IdFTP1.Disconnect;
      end;
    end;
  end;
end;

end.
