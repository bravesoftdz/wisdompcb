program A_WZCX113;

uses
  Forms,
  Frm_detail_u in 'Frm_detail_u.pas' {Frm_detail},
  Frm_main_u in 'Frm_main_u.pas' {Frm_main};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '��Ʒ���ϲ�ѯ';
  Application.CreateForm(TFrm_main, Frm_main);
  Application.Run;
end.
