program WZ_CardMgr;


{$R 'CallerResource.res' 'CallerResource.rc'}

uses
  Forms,
  Dialogs,
  MainFrm in 'MainFrm.pas' {frmMain},
  WZ_gUnit in 'WZ_gUnit.pas',
  DMFrm in 'DMFrm.pas' {DM1: TDataModule},
  Eastriver_API in 'Eastriver_API.pas',
  Eastriver_Helper in 'Eastriver_Helper.pas',
  DataMgr in 'DataMgr.pas';

{$R *.res}

//{$DEFINE DEBUGMODE}

begin
  Application.Initialize;
  Application.Title := '���ڿ��ɼ�';
  Application.CreateForm(TDM1, DM1);
  {$IFDEF DEBUGMODE}
  FillDebugUser(gUser);
  dm1.con1.Close;
  dm1.con1.LoginPrompt := False;
  dm1.con1.ConnectionString := gUser.DBConnectString;
  dm1.con1.Open();
  Application.CreateForm(TfrmMain, frmMain);
  frmMain.Caption := '���ڿ��ɼ�' + ' ' + gUser.DBName;
  if frmMain.CheckOperatorLock then Exit;
  {$ELSE}
  case App_Init(dm1.con1,gUser) of
    0: ShowMessage('��������ʧ�ܣ�����ϵ����Ա��');
    1:
    begin
      Application.CreateForm(TfrmMain, frmMain);
      frmMain.Caption := '���ڿ��ɼ�' + ' ' + gUser.DBName;
      if frmMain.CheckOperatorLock then Exit;
    end;
    2: ShowMessage('ͬһ���ݿ���ֻ������һ��');
  else
  end;
//      Application.CreateForm(TfrmMain, frmMain);
//      frmMain.Caption := '���ڿ��ɼ�' + ' ' + gUser.DBName;
//      if frmMain.CheckOperatorLock then Exit;
  {$ENDIF}
  if LoadDll(DLL_NAME) then
    Application.Run
  else
    ShowMessage('���ؽӿڶ�̬��ʧ��');
  FreeDll;
end.
