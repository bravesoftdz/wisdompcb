program WZPR529;

uses
  Forms,
  Main in 'Main.pas' {Form_Main},
  Demo in 'Demo.pas' {DM: TDataModule},
  PackList in 'PackList.pas' {Form_PackList},
  PackSearch in 'PackSearch.pas' {Form_PackSearch},
  ShipAddress in 'ShipAddress.pas' {Form_ShipAddress},
  EditNote in 'EditNote.pas' {Form_EditNote},
  Customer in 'Customer.pas' {Form_Customer},
  Condition in 'Condition.pas' {Form_Condition},
  AdviceReport in 'AdviceReport.pas' {Form_Report},
  TotalPrint in 'TotalPrint.pas' {Form_TotalPrint},
  PackSelect in 'PackSelect.pas' {Form_PackSelect},
  PackDetail in 'PackDetail.pas' {Form_PackDetail};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '���ط���֪ͨ��';
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TForm_Main, Form_Main);
  Application.Run;
end.
