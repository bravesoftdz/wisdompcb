program ProcessTime;

uses
  Forms,
  UFrmMain in 'UFrmMain.pas' {FrmMain},
  UDM in 'UDM.pas' {DM: TDataModule},
  UQry in 'UQry.pas' {FrmQry};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '��������ʱ���ֶ�ͳ��';
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
