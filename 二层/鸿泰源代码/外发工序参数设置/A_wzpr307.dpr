program A_wzpr307;

uses
  Forms,
  Main in 'Main.pas' {Frm_Main},
  demo in 'demo.pas' {DM: TDataModule},
  OutParameter in 'OutParameter.pas' {Frm_OutParameter},
  Parmeter in 'Parmeter.pas' {Frm_Parmeter};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '�ⷢ�����������';
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TFrm_Main, Frm_Main);
  Application.Run;
end.
