program A_EP083;

uses
  Forms,
  main in 'main.pas' {frmMain},
  Dm in 'Dm.pas' {dmcon: TDataModule},
  Worker_Edit in 'Worker_Edit.pas' {frmWorker_Edit},
  Pick_WorkShop in 'Pick_WorkShop.pas' {frmPick_WorkShop};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '�����û�Ȩ�޹���';
  Application.CreateForm(Tdmcon, dmcon);
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
