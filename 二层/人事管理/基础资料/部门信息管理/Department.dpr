program Department;

uses
  Forms,
  Dept in 'Dept.pas' {fm_dept},
  UDM in 'UDM.pas' {DM: TDataModule},
  Mdd in 'Mdd.pas' {fm_madd};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '������Ϣ����';
  Application.CreateForm(TDM, DM);
  Application.CreateForm(Tfm_dept, fm_dept);
  Application.Run;
end.
