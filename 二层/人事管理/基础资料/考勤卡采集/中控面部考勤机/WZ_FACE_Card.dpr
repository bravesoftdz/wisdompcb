program WZ_FACE_Card;

{$R 'CallerResource.res' 'CallerResource.rc'}

uses
  Forms,
  WZ_gUnit,
  Dialogs,
  Windows,
  ActiveX,
  MainFrm in 'MainFrm.pas' {frmMain},
  FaceDllInterface in 'FaceDllInterface.pas',
  zkemkeeper_TLB in 'zkemkeeper_TLB.pas';

{$R *.res}

// {$DEFINE DEBUGMODE}

begin
  CoInitialize(nil);
  try
  if not FaceDllInterface.LoadDevLib then Exit;
  Application.Initialize;
  Application.Title := '�沿���ڿ��ɼ�';
  Application.CreateForm(TfrmMain, frmMain);
  {$IFDEF DEBUGMODE}
  //FillDebugUser(gUser);
  frmMain.con1.Close;
  frmMain.con1.LoginPrompt := False;
  frmMain.con1.ConnectionString := gUser.DBConnectString;
  frmMain.con1.Open();
  {$ELSE}
  case App_Init(frmMain.con1, gUser) of
    0:begin
      ShowMessage('��������ʧ�ܣ�����ϵ����Ա��');
      Exit;
    end;
    1:;
    2:begin
      ShowMessage('ͬһ���ݿ���ֻ������һ��');
      Exit;
    end;
  else
    Exit;
  end;
  {$ENDIF}
  frmMain.Caption := '�沿���ڿ��ɼ�' + ' ' + gUser.DBName;
  Application.Run;
  CoUnInitialize;
  finally
    FreeFaceLib;
  end;

end.
