program LOT_MRBCheck;

uses
  Forms,
  WZ_gUnit,
  Dialogs,
  DM in 'DM.pas' {DM1: TDataModule},
  BFMgr in 'BFMgr.pas',
  DeptFrm in 'DeptFrm.pas' {frmDeptList},
  FanGongFrm in 'FanGongFrm.pas' {frmFG1},
  HeBingGongDan in 'HeBingGongDan.pas',
  FilterFrm in 'FilterFrm.pas' {frmFilter},
  MainFrm in 'MainFrm.pas' {frmMain},
  gBFUnit in '..\���Ϲ���(��)\gUnit\gBFUnit.pas',
  NewFrm in '..\���Ϲ���(��)\��������\NewFrm.pas' {frmNew},
  BMListFrm in '..\���Ϲ���(��)\��������\BMListFrm.pas' {frmBMList};

{$R *.res}

//{$DEFINE DEBUGMODE}
begin
  Application.Initialize;
  Application.Title := 'LOT_MRB����';
  Application.CreateForm(Tdm1, dm1);
  {$IFDEF DEBUGMODE}
  FillDebugUser(gUser);
  dm1.con1.Close;
  dm1.con1.LoginPrompt := False;
  dm1.con1.ConnectionString := gUser.DBConnectString;
  dm1.con1.Open();
  Application.CreateForm(TfrmMain, frmMain);
  frmMain.Caption := 'LOT_MRB����' + ' ' + gUser.DBName;
  Application.CreateForm(TfrmDeptList, frmDeptList);
  Application.CreateForm(TfrmFG1, frmFG1);
  Application.CreateForm(TfrmFilter, frmFilter);
  {$ELSE}
  case App_Init(dm1.con1,gUser) of
    0: ShowMessage('��������ʧ�ܣ�����ϵ����Ա��');
    1:
    begin
      Application.CreateForm(TfrmMain, frmMain);
      frmMain.Caption := 'LOT_MRB����' + ' ' + gUser.DBName;
      Application.CreateForm(TfrmDeptList, frmDeptList);
      Application.CreateForm(TfrmFG1, frmFG1);
      Application.CreateForm(TfrmFilter, frmFilter);    
    end;
    2: ShowMessage('ͬһ���ݿ���ֻ������һ��');
  else
  end;
  {$ENDIF}
  Application.Run;
end.

