program FactoryCalendar;

uses
  Forms,
  UMain in 'UMain.pas' {frmMain},
  UDM in 'UDM.pas' {DM: TDataModule},
  UFCEdit in 'UFCEdit.pas' {frmFCEdit},
  URTEdit in 'URTEdit.pas' {frmRTEdit};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '��ҵ����';
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
