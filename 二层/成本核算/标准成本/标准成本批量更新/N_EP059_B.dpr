program N_EP059_B;

uses
  Forms,
  main_059_B in 'main_059_B.pas' {frmmain_059B},
  QuerySet in 'QuerySet.pas' {frmQuerySet};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '��Ʒ��׼�ɱ���������';
  Application.CreateForm(Tfrmmain_059B, frmmain_059B);
  Application.Run;
end.
