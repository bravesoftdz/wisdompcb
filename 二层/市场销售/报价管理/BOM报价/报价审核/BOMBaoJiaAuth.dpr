program BOMBaoJiaAuth;

uses
  MidasLib,
  Vcl.Dialogs,
  Vcl.Forms,
  BOMBaoJiaEditFrm in '..\���۵�\BOMBaoJiaEditFrm.pas' {frmEditBOMBaoJia},
  BOMBaoJiaInputPCsSize in '..\���۵�\BOMBaoJiaInputPCsSize.pas' {frmBOMPaoJiainPutPCSSize},
  BOMBaoJiaMainFrm in '..\���۵�\BOMBaoJiaMainFrm.pas' {frmMainBOMBaoJia},
  BomBaoJiaQueryFrm in '..\���۵�\BomBaoJiaQueryFrm.pas' {frmBomBaoJiaQuery},
  BOMPricePrintSetFrm in '..\���۵�\BOMPricePrintSetFrm.pas' {frmBomPricePrintSet},
  CalcImpl in '..\���۵�\CalcImpl.pas',
  CalcIntf in '..\���۵�\CalcIntf.pas',
  RptDM in '..\���۵�\RptDM.pas' {dmRpt: TDataModule},
  RptDMOut in '..\���۵�\RptDMOut.pas' {dmRptOut: TDataModule},
  ShenPiFrm in '..\���۵�\ShenPiFrm.pas' {frmShenPi},
  DataIntf in '..\Common\DataIntf.pas',
  DBImpl in '..\Common\DBImpl.pas',
  DM in '..\Common\DM.pas' {dm1: TDataModule},
  WZ_gUnit in '..\Common\WZ_gUnit.pas';

{$R *.res}

//{$DEFINE DEBUGMODE}

begin
  Application.Initialize;
  Application.Title := 'BOM�������';
  Application.CreateForm(Tdm1, dm1);
  {$IFDEF DEBUGMODE}
  FillDebugUser(gUser);
  //gUser.User_Permit := '1';
//  gUser.User_Ptr := '1284';
  dm1.con1.Close;
  dm1.con1.LoginPrompt := False;
  dm1.con1.ConnectionString := gUser.DBConnectString;
  dm1.con1.Open();
  dm1.GetLookUpData;
  Application.CreateForm(TfrmMainBOMBaoJia, frmMainBOMBaoJia);
  frmMainBOMBaoJia.FIsAuth := True;
  frmMainBOMBaoJia.Caption := 'BOM�������' + ' ' + gUser.DBName;
  {$ELSE}
  case App_Init(dm1.con1,gUser) of
    0: ShowMessage('��������ʧ�ܣ�����ϵ����Ա��');
    1:
    begin
      dm1.GetLookUpData;
      Application.CreateForm(TfrmMainBOMBaoJia, frmMainBOMBaoJia);
      frmMainBOMBaoJia.Caption := 'BOM�������' + ' ' + gUser.DBName;
      frmMainBOMBaoJia.FIsAuth := True;
    end;
    2: ShowMessage('ͬһ���ݿ���ֻ������һ��');
  else
  end;
  {$ENDIF}
  Application.Run;

end.
