program EP009;

uses
  Forms,
  units in 'units.pas' {fm_unit},
  demo in 'demo.pas' {DM: TDataModule},
  mad in 'mad.pas' {fm_mad};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '��λ���붨��';
  Application.CreateForm(TDM, DM);
  Application.CreateForm(Tfm_unit, fm_unit);
  Application.Run;
end.
