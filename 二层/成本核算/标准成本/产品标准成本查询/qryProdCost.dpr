program qryProdCost;

uses
  Forms,
  main in 'main.pas' {frmMain},
  QuerySet in 'QuerySet.pas' {frmQuerySet};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '��Ʒ�ɱ���ѯ';
  Application.CreateForm(TfrmMain, frmMain);
  Application.CreateForm(TfrmQuerySet, frmQuerySet);
  Application.Run;
end.
