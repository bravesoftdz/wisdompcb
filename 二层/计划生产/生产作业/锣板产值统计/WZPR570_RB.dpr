program WZPR570_RB;

uses
  Forms,
  DAMO in 'DAMO.pas' {DM: TDataModule},
  PasMain in 'PasMain.pas' {frmMain},
  PasQuery in 'PasQuery.pas' {frmQuery},
  PasModify in 'PasModify.pas' {frmModify},
  PasParaEdit in 'PasParaEdit.pas' {frmParaEdit};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '����ֵͳ��';
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
