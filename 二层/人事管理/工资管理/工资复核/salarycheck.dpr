program salarycheck;

uses
  Forms,
  frm_mian_u in 'frm_mian_u.pas' {frm_main},
  damo in 'damo.pas' {DM: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '���ʸ���';
  Application.CreateForm(TDM, DM);
  Application.CreateForm(Tfrm_main, frm_main);
  Application.Run;
end.
