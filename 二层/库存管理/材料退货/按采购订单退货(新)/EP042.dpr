program EP042;

uses
  Forms,
  main in 'main.pas' {fm_main},
  detail in 'detail.pas' {fm_detail},
  damo in 'damo.pas' {dm: TDataModule},
  condition in 'condition.pas' {fm_condition},
  add_detail in 'add_detail.pas' {fm_add};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '生产物料退货给供应商';
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(Tfm_main, fm_main);
  Application.CreateForm(Tfm_condition, fm_condition);
  Application.Run;
end.
