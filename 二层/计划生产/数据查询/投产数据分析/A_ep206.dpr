program A_ep206;

uses
  Forms,
  condition in 'condition.pas' {condition_form},
  damo in 'damo.pas' {dm: TDataModule},
  detail in 'detail.pas' {detail_form},
  UTogather in 'UTogather.pas' {frmTotather};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Ͷ���������';
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(Tcondition_form, condition_form);
  Application.CreateForm(TfrmTotather, frmTotather);
  Application.Run;
end.
