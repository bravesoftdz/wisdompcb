program wzpr012;

uses
  Forms,
  Main in 'Main.pas' {FrmMain},
  uDM in 'uDM.pas' {DM: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '��ת����';
  Application.CreateForm(TDM, DM);  
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
