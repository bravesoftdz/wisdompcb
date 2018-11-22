program A_EP200;

uses
  Forms,
  MainFrm in 'MainFrm.pas' {frmMain},
  ModifyUnitWeight_U in 'ModifyUnitWeight_U.pas' {FrmModifyUnitWeight},
  WZ_gUnit in 'WZ_gUnit.pas',
  DM in 'DM.pas' {dm1: TDataModule},
  Dialogs,
  PostFrm in 'PostFrm.pas' {frmPost},
  Post06 in 'Post06.pas' {frmPost06},
  FastPostFrm in 'FastPostFrm.pas' {frmFastPost};

//{$DEFINE DEBUGMODE}

{$R *.res}

begin

//  Application.Initialize;
//  Application.Title := '����Ʒ����ύ';
//  Application.CreateForm(Tdm1, dm1);
//
//  Application.CreateForm(TfrmMain, frmMain);
//  gUser.User_Ptr:='3301';
//  Application.Run;

  Application.Initialize;
  Application.Title := '����Ʒ����ύ';
  Application.CreateForm(Tdm1, dm1);
  {$IFDEF DEBUGMODE}
  FillDebugUser(gUser);
  dm1.con1.Close;
  dm1.con1.LoginPrompt := False;
  dm1.con1.ConnectionString := gUser.DBConnectString;
  dm1.con1.Open();
  Application.CreateForm(TfrmMain, frmMain);
  frmMain.Caption := '����Ʒ����ύ' + ' ' + gUser.DBName;
  {$ELSE}
  case App_Init(dm1.con1,gUser) of
    0: ShowMessage('��������ʧ�ܣ�����ϵ����Ա��');
    1:
    begin
      Application.CreateForm(TfrmMain, frmMain);
      frmMain.Caption := '����Ʒ����ύ' + ' ' + gUser.DBName;
    end;
    2: ShowMessage('ͬһ���ݿ���ֻ������һ��');
  else
  end;
  {$ENDIF}
  Application.Run;
end.
