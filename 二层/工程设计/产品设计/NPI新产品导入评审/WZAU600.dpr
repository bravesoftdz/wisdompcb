program WZAU600;

uses
  Forms,
  main in 'main.pas' {Frm_main},
  detail in 'detail.pas' {Frm_authinfo},
  demo in 'demo.pas' {DM: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'NPI�²�Ʒ��������';
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TFrm_main, Frm_main);
  Application.Run;
end.
