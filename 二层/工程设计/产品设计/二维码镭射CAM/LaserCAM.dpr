program LaserCAM;

uses
  Forms,
  MainFrm in 'MainFrm.pas' {Form1},
  frmEdit in 'frmEdit.pas' {Form2},
  WZ_gUnit in 'wz_gunit.pas',
  DM in 'DM.pas' {dm1: TDataModule},
  Dialogs;

//{$DEFINE DEBUGMODE}

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '��ά������CAM';
  Application.CreateForm(Tdm1, dm1);
  {$IFDEF DEBUGMODE}
  FillDebugUser(gUser);
  dm1.con1.Close;
  dm1.con1.LoginPrompt := False;
  dm1.con1.ConnectionString := gUser.DBConnectString;
  dm1.con1.Open();
  Application.CreateForm(TFORM1, form1);
  Application.CreateForm(Tdm1, dm1);
  form1.Caption := '��ά������CAM' + ' ' + gUser.DBName;
  //Application.CreateForm(TfrmFilter, frmFilter);  
  {$ELSE}
  case App_Init(dm1.con1,gUser) of
    0: ShowMessage('��������ʧ�ܣ�����ϵ����Ա��');
    1:
    begin
      Application.CreateForm(TFORM1, form1);
      form1.Caption := '��ά������CAM' + ' ' + gUser.DBName;
      //Application.CreateForm(TfrmFilter, frmFilter);
    end;
    2: ShowMessage('ͬһ���ݿ���ֻ������һ��');
  else
  end;
  {$ENDIF}
  Application.Run;
end.
