program EP170;

uses
  Forms,
  main in 'main.pas' {FrmMain};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '��������';
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
