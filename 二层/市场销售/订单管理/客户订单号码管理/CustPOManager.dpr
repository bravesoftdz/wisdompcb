program CustPOManager;

uses
  Forms,
  main in 'main.pas' {frmMain},
  condition in 'condition.pas' {frmCondition},
  Detail in 'Detail.pas' {frmDetail};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '�ͻ������������';
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmCondition, frmCondition);
  Application.Run;
end.
