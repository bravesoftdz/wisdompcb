program EP172;

uses
  Forms,
  Main in 'Main.pas' {FrmMain},
  Getfile in 'Getfile.pas' {FrmGetfile};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '���񱨱���';
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
