program wzprFX079;

uses
  Forms,
  Main in 'Main.pas' {FrmMain},
  Datamodule in 'Datamodule.pas' {DM: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '������';
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
