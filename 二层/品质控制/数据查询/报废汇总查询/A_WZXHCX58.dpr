program A_WZXHCX58;

uses
  Forms,
  main in 'main.pas' {main_form},
  detail in 'detail.pas' {detail_form},
  demo in 'demo.pas' {DM: TDataModule},
  UTogather in 'UTogather.pas' {frmTotather};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '���ϻ��ܲ�ѯ';
  Application.CreateForm(TDM, DM);
  Application.CreateForm(Tmain_form, main_form);
  Application.Run;
end.
