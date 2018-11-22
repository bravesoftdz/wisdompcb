program BOMBaoJia;
{$R 'CallerResource.res' 'CallerResource.rc'}
uses
  Forms,
  MidasLib,
  Vcl.Dialogs,

  BOMBaoJiaMainFrm in 'BOMBaoJiaMainFrm.pas' {frmMainBOMBaoJia},
  BOMBaoJiaEditFrm in 'BOMBaoJiaEditFrm.pas' {frmEditBOMBaoJia},
  DM in '..\Common\DM.pas' {dm1: TDataModule},
  CalcIntf in 'CalcIntf.pas',
  CalcImpl in 'CalcImpl.pas',
  BOMBaoJiaInputPCsSize in 'BOMBaoJiaInputPCsSize.pas' {frmBOMPaoJiainPutPCSSize},
  BomBaoJiaQueryFrm in 'BomBaoJiaQueryFrm.pas' {frmBomBaoJiaQuery},
  RptDM in 'RptDM.pas' {dmRpt: TDataModule},
  BOMPricePrintSetFrm in 'BOMPricePrintSetFrm.pas' {frmBomPricePrintSet},
  RptDMOut in 'RptDMOut.pas' {dmRptOut: TDataModule},
  ShenPiFrm in 'ShenPiFrm.pas' {frmShenPi},
  WZ_gUnit;

{$R *.res}

//{$DEFINE DEBUGMODE}

begin
  Application.Initialize;
  Application.Title := 'BOM���۵�';
  Application.CreateForm(Tdm1, dm1);
  {$IFDEF DEBUGMODE}
  FillDebugUser(gUser);
//  gUser.User_Permit := '1';
  //gUser.User_Ptr := '1284';
  dm1.con1.Close;
  dm1.con1.LoginPrompt := False;
  dm1.con1.ConnectionString := gUser.DBConnectString;
  dm1.con1.Open();
  dm1.GetLookUpData;
  Application.CreateForm(TfrmMainBOMBaoJia, frmMainBOMBaoJia);
  frmMainBOMBaoJia.Caption := 'BOM���۵�' + ' ' + gUser.DBName;
  {$ELSE}
  case App_Init(dm1.con1,gUser) of
    0: ShowMessage('��������ʧ�ܣ�����ϵ����Ա��');
    1:
    begin
      dm1.GetLookUpData;
      Application.CreateForm(TfrmMainBOMBaoJia, frmMainBOMBaoJia);
      frmMainBOMBaoJia.Caption := 'BOM���۵�' + ' ' + gUser.DBName;
    end;
    2: ShowMessage('ͬһ���ݿ���ֻ������һ��');
  else
  end;
  {$ENDIF}
  Application.Run;

end.
