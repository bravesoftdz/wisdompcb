program WZCP88;

uses
  Forms,
  MainFrm in 'MainFrm.pas' {FrmMain},
  EditFrm in 'EditFrm.pas' {FrmEdit},
  Damo in 'Damo.pas' {DM: TDataModule},
  QueFrm in 'QueFrm.pas' {FrmQue};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '�ⷢ�ӹ�����';
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TFrmMain, FrmMain);
  Application.CreateForm(TFrmQue, FrmQue);
  Application.Run;
end.
