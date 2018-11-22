program CKBQ;

uses
  Forms,
  WZ_gUnit,
  Dialogs,
  MainFrm in 'MainFrm.pas' {frmMain},
  TagReadFrm in 'TagReadFrm.pas' {frmTagRead},
  DM in 'DM.pas' {dm1: TDataModule},
  TagCompareFrm in 'TagCompareFrm.pas' {frmBarComp},
  PrintFrm in 'PrintFrm.pas' {frmPrint},
  CmpHisFrm in 'CmpHisFrm.pas' {frmCmpHis},
  InOutFrm in 'InOutFrm.pas' {frmInOut},
  InOutHisFrm in 'InOutHisFrm.pas' {frmInOutHis},
  ResetPlaceFrm in 'ResetPlaceFrm.pas' {frmResetPlace},
  CmpFrmNew in 'CmpFrmNew.pas' {frmCmpNew},
  TagInfo in 'TagInfo.pas' {frmTagInfo},
  InOutHisZhouQiSetFrm in 'InOutHisZhouQiSetFrm.pas' {frmZhouQiSet};

//{$DEFINE DEBUGMODE}

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '�ֿ⻪Ϊ��ǩ';
  Application.CreateForm(Tdm1, dm1);
  {$IFDEF DEBUGMODE}
  FillDebugUser(gUser);
  dm1.con1.Close;
  dm1.con1.LoginPrompt := False;
  dm1.con1.ConnectionString := gUser.DBConnectString;
  dm1.con1.Open();
  Application.CreateForm(TfrmMain, frmMain);
  frmMain.Caption := '�ֿ⻪Ϊ��ǩ' + ' ' + gUser.DBName;
  {$ELSE}
  case App_Init(dm1.con1,gUser) of
    0: ShowMessage('��������ʧ�ܣ�����ϵ����Ա��');
    1:
    begin
      Application.CreateForm(TfrmMain, frmMain);
      frmMain.Caption := '�ֿ⻪Ϊ��ǩ' + ' ' + gUser.DBName;
    end;
    2: ShowMessage('ͬһ���ݿ���ֻ������һ��');
  else
  end;
  {$ENDIF}
  Application.Run;
end.
