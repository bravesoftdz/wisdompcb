program HRStatistics;

uses
  Forms,
  MainFrm in 'MainFrm.pas' {FrmMain},
  DM in 'DM.pas' {damo: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '����ͳ�Ʒ�������';
  Application.CreateForm(Tdamo, damo);
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
