program WZAU221;

uses
  Forms,
  main in 'main.pas' {Form1},
  damo in 'damo.pas' {DM: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '�������������';
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
