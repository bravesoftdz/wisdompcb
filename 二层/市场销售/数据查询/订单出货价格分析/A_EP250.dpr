program A_EP250;

uses
  Forms,
  Main_250 in 'Main_250.pas' {frmMain_250};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '���������۸����';
  Application.CreateForm(TfrmMain_250, frmMain_250);
  Application.Run;
end.
