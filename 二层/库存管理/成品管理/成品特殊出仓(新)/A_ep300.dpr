program A_ep300;

uses
  Forms,
  main in 'main.pas' {fm_main},
  detail in 'detail.pas' {fm_detail},
  damo in 'damo.pas' {dm: TDataModule},
  condition in 'condition.pas' {fm_condition},
  rma_search in 'rma_search.pas' {Frm_rmasearch},
  stock_search in 'stock_search.pas' {Form_Stock};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '����Ʒ������ִ���';
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(Tfm_main, fm_main);
  Application.CreateForm(Tfm_condition, fm_condition);
  Application.Run;
end.
