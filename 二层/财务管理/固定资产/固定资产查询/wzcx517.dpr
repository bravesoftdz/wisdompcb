program wzcx517;

uses
  Forms,
  uMain in 'uMain.pas' {Fmain},
  uMD in 'uMD.pas' {DM: TDataModule},
  uFFass in 'uFFass.pas' {FrmFass},
  QuerySet in 'QuerySet.pas' {frmQuerySet};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '�̶��ʲ���ѯ';
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TFmain, Fmain);
  Application.Run;
end.
