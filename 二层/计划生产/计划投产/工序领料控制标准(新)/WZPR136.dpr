program WZPR136;

uses
  Forms,
  UMain in 'UMain.pas' {FrmMain},
  UModi in 'UModi.pas' {frmModi},
  UDM in 'UDM.pas' {DM: TDataModule},
  USelProcess in 'USelProcess.pas' {FrmSelProcess},
  UQry in 'UQry.pas' {FrmQry},
  USelMateriel in 'USelMateriel.pas' {FrmSelMateriel},
  USelMan in 'USelMan.pas' {FrmSelMan},
  UImport in 'UImport.pas' {FrmImport};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '����������ı�׼';
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
