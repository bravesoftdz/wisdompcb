program WorktimeReport;

uses
  Forms,
  main in 'main.pas' {frm_Main},
  dmo in 'dmo.pas' {DM: TDataModule},
  common in 'D:\vss_lyh\���򹫹���λ\common.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '���ڻ��ܱ���';
  Application.CreateForm(TDM, DM);
  Application.CreateForm(Tfrm_Main, frm_Main);
  Application.Run;
end.
