program MIGradeSet;

uses
  Forms,
  WZ_gUnit,
  Dialogs,
  MainFrm in 'MainFrm.pas' {frmMain},
  DMFrm in 'DMFrm.pas' {DM1: TDataModule},
  EditFrm in 'EditFrm.pas' {frmEdit},
  DeptAddFrm in 'DeptAddFrm.pas' {frmAddDept},
  ParamAddFrm in 'ParamAddFrm.pas' {frmParamAdd};

{$R *.res}

//{$DEFINE DEBUGMODE}

begin
  Application.Initialize;
  Application.Title := 'MI�ȼ�����';
  Application.CreateForm(Tdm1, dm1);
  {$IFDEF DEBUGMODE}
  FillDebugUser(gUser);
  dm1.con1.Close;
  dm1.con1.LoginPrompt := False;
  dm1.con1.ConnectionString := gUser.DBConnectString;
  dm1.con1.Open();
  Application.CreateForm(TfrmMain, frmMain);
  frmMain.Caption := 'MI�ȼ�����' + ' ' + gUser.DBName;
  {$ELSE}
  case App_Init(dm1.con1,gUser) of
    0: ShowMessage('��������ʧ�ܣ�����ϵ����Ա��');
    1:
    begin
      Application.CreateForm(TfrmMain, frmMain);
      frmMain.Caption := 'MI�ȼ�����' + ' ' + gUser.DBName;
    end;
    2: ShowMessage('ͬһ���ݿ���ֻ������һ��');
  else
  end;
  {$ENDIF}
  Application.Run;
end.
