program AccountChange;

uses
  Forms,
  MainFrm in 'MainFrm.pas' {FrmMain},
  AddFrm in 'AddFrm.pas' {FrmAdd},
  damo in 'damo.pas' {DM: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Ա�����ױ䶯';
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
