program WZPR570;

uses
  Forms,
  DAMO in 'DAMO.pas' {DM: TDataModule},
  PasMain in 'PasMain.pas' {frmMain},
  PasQuery in 'PasQuery.pas' {frmQuery},
  PasModify in 'PasModify.pas' {frmModify},
  PasTable in 'PasTable.pas' {frmTable},
  PasParaEdit in 'PasParaEdit.pas' {frmParaEdit};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '��ײ�ֵͳ��';
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
