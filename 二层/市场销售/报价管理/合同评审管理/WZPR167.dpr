program WZPR167;

uses
  Forms,
  Contract in 'Contract.pas' {frmContract},
  damo in 'damo.pas' {dm: TDataModule},
  condition in 'condition.pas' {frmCondition},
  Detail in 'Detail.pas' {frmDetail},
  SetItem in 'SetItem.pas' {frmSetItem},
  FindRFQ in 'FindRFQ.pas' {frmFindRFQ},
  FindCust in 'FindCust.pas' {frmFindCust},
  Reports in 'Reports.pas' {frmReports},
  EditItem in 'EditItem.pas' {frmEditItem};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '��ͬ�������';
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(TfrmContract, frmContract);
  Application.CreateForm(TfrmCondition, frmCondition);
  Application.Run;
end.
