unit uPB;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.StdCtrls, Vcl.Buttons, IdComponent,
  IdFTP, IdFTPCommon, IdFTPList, IniFiles, IdGlobal, IdBaseComponent,
  IdTCPConnection, IdTCPClient, IdExplicitTLSClientServerBase,
  Vcl.Samples.Gauges;

const base64 = 'oeJzcNn7YV5ZKv+EhQaC3Xu/WiO24PDylRdqkGjI9TwUFrxL1bMHfpA6gsSt0Bm8';

type
  TfrmPB = class(TForm)
    IdFTP1: TIdFTP;
    lbl: TLabel;
    gg_ShowWorking: TGauge;
    btn_Abort: TSpeedButton;
    procedure IdFTP1Work(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCount: Int64);
    procedure IdFTP1WorkBegin(ASender: TObject; AWorkMode: TWorkMode;
      AWorkCountMax: Int64);
    procedure IdFTP1WorkEnd(ASender: TObject; AWorkMode: TWorkMode);
    procedure FormCreate(Sender: TObject);
    procedure btn_AbortClick(Sender: TObject);
  private
    IP,UID,PSW,FileDir: string;
    function Base64_Decode(a: string): string;stdcall;
    function mimedecode(a: string): Integer;stdcall;
  public
    FTransferrignData: Boolean;    //�Ƿ��ڴ�������
    FBytesToTransfer: LongWord;    //������ֽڴ�С
    FAbortTransfer: Boolean;       //ȡ�����ݴ���
    STime: TDateTime;             //ʱ��
    FAverageSpeed: Double;        //ƽ���ٶ�
    function ConnectFTP(Host, UId, PSW, FileDir: string):Boolean;stdcall;  //����FTP
    function UpLoadFTP(FileName: PAnsiChar):Boolean;stdcall;    //�ϴ��ļ�
    function DownLoadFTP(DataBaseFileName,dlgFileName: PAnsiChar):Boolean;stdcall;  //�����ļ�
    function DeleteFTP(FileName: PAnsiChar):Boolean;stdcall;    //ɾ���ļ�
  end;

var
  frmPB: TfrmPB;

implementation

{$R *.dfm}

procedure TfrmPB.FormCreate(Sender: TObject);
var
  MyIniFile: TIniFile;
begin
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

procedure TfrmPB.IdFTP1Work(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCount: Int64);
var
  S: String;
  TotalTime: TDateTime;
  H, M, Sec, MS: Word;
  DLTime: Double;
begin
  Application.ProcessMessages;
  try
    TotalTime :=  Now - STime;      //�ѻ��ѵ�ʱ��
    DecodeTime(TotalTime, H, M, Sec, MS);  //����ʱ��
    Sec := Sec + M * 60 + H * 3600;  //ת�����������
    DLTime := Sec + MS / 1000;      //��ȷ������
    if DLTime > 0 then
      FAverageSpeed := (AWorkCount / 1024) / DLTime;   //��ƽ���ٶ�
    if FAverageSpeed > 0 then
    begin
      Sec := Trunc(((gg_ShowWorking.MaxValue - AWorkCount) / 1024) / FAverageSpeed);
      S := Format('%2d:%2d:%2d', [Sec div 3600, (Sec div 60) mod 60, Sec mod 60]);
      S := 'ʣ��ʱ�� ' + S;
    end
    else
      S := '';
    S := FormatFloat('0.00 KB/s', FAverageSpeed) + '; ' + S;
    case AWorkMode of
      wmRead: lbl.Caption:= '�����ٶ� ' + S;
      wmWrite: lbl.Caption:= '�ϴ��ٶ� ' + S;
    end;
    if FAbortTransfer then   //ȡ�����ݴ���
      IdFTP1.Abort;
    gg_ShowWorking.Progress := AWorkCount;
    FAbortTransfer := false;
  except
    IdFTP1.Abort;
  end;
end;

procedure TfrmPB.IdFTP1WorkBegin(ASender: TObject; AWorkMode: TWorkMode;
  AWorkCountMax: Int64);
begin
  try
    FTransferrignData := True;
    btn_Abort.Enabled:= True;
    FAbortTransfer := False;
    STime := Now;
    if AWorkCountMax > 0 then
    begin
      gg_ShowWorking.MaxValue := AWorkCountMax;
    end
    else
    begin
      gg_ShowWorking.MaxValue := FBytesToTransfer;
    end;
    FAverageSpeed := 0;
  except
    IdFTP1.Abort;
  end;
end;

procedure TfrmPB.IdFTP1WorkEnd(ASender: TObject; AWorkMode: TWorkMode);
begin
  try
    btn_Abort.Enabled := False;
    FTransferrignData := False;
    FBytesToTransfer := 0;
    gg_ShowWorking.Progress := 0;
    FAverageSpeed := 0;
    lbl.Caption := '�������';
  except
    IdFTP1.Abort;
  end;
end;

function TfrmPB.Base64_Decode(a: string): string;
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

procedure TfrmPB.btn_AbortClick(Sender: TObject);
begin
  FAbortTransfer := True;
end;

function TfrmPB.ConnectFTP(Host, UId, PSW, FileDir: string): Boolean;
var
  vList: TStrings;
begin
  Result:= False;
  try
    IdFTP1.Passive := True; //����ģʽ:����ģʽ
    IdFTP1.Host := Host;
    IdFTP1.Username := UId;  //FTP�������û���
    IdFTP1.Password := PSW;  //FTP����������
    IdFTP1.ReadTimeout := 120000;
    IdFTP1.ConnectTimeout := 120000;  //��ʱʱ��(2����)����λ����
    IdFTP1.Connect();  //���ӵ�ftp
    IdFTP1.ChangeDir(FileDir);  //����FileDir:=BJ_Data��Ŀ¼{��ʼĿ¼IdFTP1.RetrieveCurrentDir}
    vList:= TStringList.Create;
    try
      IdFTP1.List(vList);  //�õ�BJ_DataĿ¼�������ļ��б�
    finally
      vList.Free;
    end;
    Result:= True;
    lbl.Caption:='����FTP�������ɹ���׼���У����Ժ�...';
    Application.ProcessMessages;
  except
    Showmessage('����FTP������ʧ��!');
    Exit;
  end;
end;



function TfrmPB.DeleteFTP(FileName: PAnsiChar): Boolean;
var
  i: Integer;
  t: TIdFTPListItem;
  setMark: string;
begin
  Result:= False;
  if not frmPB.IdFTP1.Connected then
  begin
    if ConnectFTP(IP,UID,PSW,FileDir) then
    begin
      try
//        IdFTP1.TransferType:= ftBinary;
        for i:= 0 to frmPB.IdFTP1.DirectoryListing.Count - 1 do
        begin
          t:= frmPB.IdFTP1.DirectoryListing.Items[i];  //�ӵ�ǰĿ¼���ļ����б�õ��ļ������Ϣ
          if t.FileName = strpas(FileName) then
          begin
            setMark:= 'Find';
            try
              if frmPB.IdFTP1.DirectoryListing.Items[i].ItemType = ditFile then  //������ļ�
              begin
                frmPB.IdFTP1.Delete(t.FileName);
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
        frmPB.IdFTP1.Disconnect;
      end;
    end;
  end;
end;



function TfrmPB.DownLoadFTP(DataBaseFileName, dlgFileName: PAnsiChar): Boolean;
var
  i: integer;
  t: TIdFTPListItem;
  setMark: string;
begin
  Result:= False;
  if not frmPB.IdFTP1.Connected then
  begin
    if ConnectFTP(IP,UID,PSW,FileDir) then
    begin
      try
        frmPB.IdFTP1.TransferType:= ftBinary;  //ָ��Ϊ�������ļ� ���ı��ļ�ftASCII
        for i:= 0 to frmPB.IdFTP1.DirectoryListing.Count - 1 do
        begin
          t:= frmPB.IdFTP1.DirectoryListing.Items[i];  //�ӵ�ǰĿ¼���ļ����б�õ��ļ������Ϣ
          if t.FileName = strpas(DataBaseFileName) then
          begin
            setMark:= 'Find';
            try
              if frmPB.IdFTP1.DirectoryListing.Items[i].ItemType = ditFile then  //������ļ�
              begin
                if FileExists(strpas(dlgFileName)) then
                  if MessageDlg('���ļ��Ѵ���,�Ƿ񸲸�?',mtConfirmation,[mbYes,mbNo],0) = mrNo then Exit;
                frmPB.IdFTP1.Get(t.FileName,strpas(dlgFileName),False,True);  //���ص�����,����,֧�ֶϵ�����
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
        frmPB.IdFTP1.Disconnect;
      end;
    end;
  end;
end;

function TfrmPB.mimedecode(a: string): Integer;
begin
  if Length(a) = 0 then
  begin
    Result := -1;
    Exit;
  end;
  Result := pos(a, base64) - 1;
end;

function TfrmPB.UpLoadFTP(FileName: PAnsiChar): Boolean;
var
  i,j: Integer;
  setMark: string;
  LastTimeTransfer:Int64;
  LSourceStream:TFileStream;
begin
  Result:= False;
  LastTimeTransfer:=-1;
  if not IdFTP1.Connected then
  begin
    if ConnectFTP(IP,UID,PSW,FileDir) then
    begin
      try
        for i:= 0 to IdFTP1.DirectoryListing.Count - 1 do
        begin
          if IdFTP1.DirectoryListing.Items[i].FileName = ExtractFileName(strpas(FileName)) then
          begin                         //���ҵ�ͬ�����ļ�
            LastTimeTransfer:= IdFTP1.Size(ExtractFileName(strpas(FileName)));
            if LastTimeTransfer>0 then  //���ļ���С����0
            begin
              setMark:= 'Find';
              Break;
            end;
          end;
        end;
        if setMark = 'Find' then
        begin
          ShowMessage('���ļ���FTP���������Ѵ���,��������!');
          Exit;
//            if MessageDlg('���ļ���FTP���������Ѵ���,�Ƿ񸲸�?', mtConfirmation,[mbYes,mbNo],0) = mrNo then Exit;
        end;
        if IdFTP1.Connected then
        begin
          IdFTP1.TransferType := ftBinary;
          try
//            LastTimeTransfer:= IdFTP1.Size(ExtractFileName(strpas(FileName)));
            if LastTimeTransfer=0 then  //ftp���������ڴ��ļ�,�Ҵ�СΪ0,����
            begin
              LSourceStream:= TFileStream.Create(ExtractFileName(strpas(FileName)), fmOpenRead or fmShareDenyNone); //�����ļ�����
              LSourceStream.Seek(LastTimeTransfer, 0);//���ļ���ָ�����һ���ϴ���λ�ã�
              IdFTP1.Put(LSourceStream, ExtractFileName(strpas(FileName)), True); //���ļ�����ʽ������
            end
            else
              IdFTP1.Put(strpas(FileName),ExtractFileName(strpas(FileName)));  //�ϴ�
            ShowMessage('�ļ��ϴ��ɹ�!');
          except on E: Exception do
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
        end;
        Result:= True;
      finally
        IdFTP1.Disconnect;
      end;
    end;
  end;
end;

end.
