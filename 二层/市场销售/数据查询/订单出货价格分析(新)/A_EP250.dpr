program A_EP250;

uses
  Forms,
  UMain in 'UMain.pas' {FrmMain},
  UQry in 'UQry.pas' {FrmQry},
  UDM in 'UDM.pas' {DM: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '���������۸����';
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
