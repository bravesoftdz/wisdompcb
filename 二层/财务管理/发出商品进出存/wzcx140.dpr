program wzcx140;

uses
  Forms,
  main in 'main.pas' {frmMain},
  query in 'query.pas' {frmQuery},
  wait in 'wait.pas' {frmWait};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '������Ʒ������';
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
