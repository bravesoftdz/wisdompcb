program Department;

uses
  Forms,
  PasMain in 'PasMain.pas' {frmMain},
  PasDM in 'PasDM.pas' {DM: TDataModule},
  PasDepart in 'PasDepart.pas' {frmDepart},
  PasSearch in 'PasSearch.pas' {frmSearch},
  UQryCount in 'UQryCount.pas' {FrmQryCount};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '������Ϣ����';
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
