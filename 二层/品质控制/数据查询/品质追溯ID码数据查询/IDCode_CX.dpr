program IDCode_CX;

uses
  Forms,
  PasMain in 'PasMain.pas' {frmMain},
  DAMO in 'DAMO.pas' {DM: TDataModule},
  PasQuery in 'PasQuery.pas' {frmQuery},
  PasQReq in 'PasQReq.pas' {frmQRep},
  PasReport in 'PasReport.pas' {frmReport};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Ʒ��׷��ID��ʶ���ʲ�ѯ';
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
