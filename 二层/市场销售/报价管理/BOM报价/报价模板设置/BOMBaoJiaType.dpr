program BOMBaoJiaType;

uses
  Vcl.Forms,
  Vcl.Dialogs,
  WZ_gUnit,
  BOMBaoJiaTypeMainFrm in 'BOMBaoJiaTypeMainFrm.pas' {frmMainBOMBaoJiaType},
  DM in '..\Common\DM.pas' {dm1: TDataModule},
  BOMBaojiaTypeEditFrm in 'BOMBaojiaTypeEditFrm.pas' {frmBomBaoJiaTypeEdit},
  AddTypeDeptFrm in 'AddTypeDeptFrm.pas' {frmAddTypeDept},
  BOMBaoJiaAddNewType in 'BOMBaoJiaAddNewType.pas' {frmBOMBaoJiaAddNewType},
  BOMBaoJiaTypeEditCaiLiao in 'BOMBaoJiaTypeEditCaiLiao.pas' {frmBomBaoJiaTypeEditCaiLiao},
  BOMBaoJiaTypeAddGolbParamFrm in 'BOMBaoJiaTypeAddGolbParamFrm.pas' {frmBOMBaoJiaTypeAddGolbParam};

{$R *.res}

//{$DEFINE DEBUGMODE}

begin
  Application.Initialize;
  Application.Title := 'BOM�����������̶���';
  Application.CreateForm(Tdm1, dm1);
  {$IFDEF DEBUGMODE}
  FillDebugUser(gUser);
  dm1.con1.Close;
  dm1.con1.LoginPrompt := False;
  //dm1.con1.ConnectionString := gUser.DBConnectString;
  dm1.con1.Open();
  dm1.GetLookUpData;
  Application.CreateForm(TfrmMainBOMBaoJiaType, frmMainBOMBaoJiaType);
  frmMainBOMBaoJiaType.Caption := 'BOM�����������̶���' + ' ' + gUser.DBName;
  {$ELSE}
  case App_Init(dm1.con1,gUser) of
    0: ShowMessage('��������ʧ�ܣ�����ϵ����Ա��');
    1:
    begin
      dm1.GetLookUpData;
      Application.CreateForm(TfrmMainBOMBaoJiaType, frmMainBOMBaoJiaType);
      frmMainBOMBaoJiaType.Caption := 'BOM�����������̶���' + ' ' + gUser.DBName;
    end;
    2: ShowMessage('ͬһ���ݿ���ֻ������һ��');
  else
  end;
  {$ENDIF}
  Application.Run;
end.
