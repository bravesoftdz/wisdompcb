program OnLineProdschedule;

uses
  Forms,
  uMain in 'uMain.pas' {frmMain},
  UDM in 'UDM.pas' {DM: TDataModule},
  UQry in 'UQry.pas' {frmQry},
  UUpdatLevel in 'UUpdatLevel.pas' {frmUpdateLevel},
  UPause in 'UPause.pas' {frmPause},
  uWODetail in 'uWODetail.pas' {frmWoDetail};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '���߲�Ʒ�����ƻ�';
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
