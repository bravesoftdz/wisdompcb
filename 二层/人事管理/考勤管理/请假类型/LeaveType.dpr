program LeaveType;

uses
  Forms,
  main in 'main.pas' {Form_Main},
  dmo in 'dmo.pas' {DM: TDataModule},
  AddLeaveType in 'AddLeaveType.pas' {Form_AddLeaveType},
  common in 'D:\vss_lyh\���򹫹���λ\common.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '�������';
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TForm_Main, Form_Main);
  Application.Run;
end.
