program Dict;

uses
  Forms,
  main in 'main.pas' {frm_main},
  damo in 'damo.pas' {DM: TDataModule},
  budget in 'D:\vss\ԭ�������\���¹���\��������\�����ֵ�\budget.pas' {Form_budget};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '�����ֵ�';
  Application.CreateForm(TDM, DM);
  Application.CreateForm(Tfrm_main, frm_main);
  Application.Run;
end.

