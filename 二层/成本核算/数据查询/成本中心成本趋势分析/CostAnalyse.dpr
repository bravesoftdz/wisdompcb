program CostAnalyse;

uses
  Forms,
  UCostAnalyse in 'UCostAnalyse.pas' {FrmCostAnalyse},
  UDm in 'UDm.pas' {DM: TDataModule},
  UCostPeriod in 'UCostPeriod.pas' {frmCostPeriod};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '�ɱ����ĳɱ����Ʒ���';
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TFrmCostAnalyse, FrmCostAnalyse);
  Application.Run;
end.
