program hr_KeyPosition;

uses
  Forms,
  pasMain in 'pasMain.pas' {frmMain},
  Demo in 'Demo.pas' {DM: TDataModule},
  pasModify in 'pasModify.pas' {frmModify};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '�ؼ���λ�趨';
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
