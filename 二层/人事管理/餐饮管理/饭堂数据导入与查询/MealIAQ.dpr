program MealIAQ;

uses
  Forms,
  PasMain in 'PasMain.pas' {frmMain},
  PasDM in 'PasDM.pas' {DM: TDataModule},
  PasImport in 'PasImport.pas' {frmImport};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '�������ݵ������ѯ';
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
