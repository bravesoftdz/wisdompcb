program HRimport;

uses
  Forms,
  Frm_main_u in 'Frm_main_u.pas' {Frm_main},
  damo in 'damo.pas' {DM: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '���µ������';
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TFrm_main, Frm_main);
  Application.Run;
end.
