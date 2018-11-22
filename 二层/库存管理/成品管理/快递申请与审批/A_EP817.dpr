program A_EP817;

uses
  Forms,
  MainFrm in 'MainFrm.pas' {frmMain},
  DM in 'DM.pas' {dm1: TDataModule},
  WZ_gUnit,
  Dialogs,
  TranCmpFrm in 'TranCmpFrm.pas' {frmTranBaseInfo},
  AddNewBillFrm in 'AddNewBillFrm.pas' {frmAddNewBill},
  ToUserHistory in 'ToUserHistory.pas' {frmToUserHistory},
  StockPassFrm in 'StockPassFrm.pas' {frmStockPass},
  SaveBillFrm in 'SaveBillFrm.pas' {frmSaveBill},
  ViewFrm in 'ViewFrm.pas' {frmView};

//{$DEFINE DEBUGMODE}

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '�������������';
  Application.CreateForm(Tdm1, dm1);
  {$IFDEF DEBUGMODE}
  FillDebugUser(gUser);
  dm1.con1.Close;
  dm1.con1.LoginPrompt := False;
  dm1.con1.ConnectionString := gUser.DBConnectString;
  dm1.con1.Open();
  Application.CreateForm(TfrmMain, frmMain);
  frmMain.Caption := '�������������' + ' ' + gUser.DBName;
  {$ELSE}
  case App_Init(dm1.con1,gUser) of
    0: ShowMessage('��������ʧ�ܣ�����ϵ����Ա��');
    1:
    begin
      Application.CreateForm(TfrmMain, frmMain);
      frmMain.Caption := '�������������' + ' ' + gUser.DBName;
    end;
    2: ShowMessage('ͬһ���ݿ���ֻ������һ��');
  else
  end;
  {$ENDIF}
  Application.Run;
end.
