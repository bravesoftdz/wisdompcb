program EP185;

uses
  Forms,
  MAIN0 in 'MAIN0.pas' {MainForm};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '��˾��Ϣ����';
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.
