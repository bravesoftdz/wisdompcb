program EP081;

uses
  Forms,
  Main_U in 'Main_U.pas' {FrmMain},
  Dm_U in 'Dm_U.pas' {DM: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '��Ʒ��ˮ������';
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
