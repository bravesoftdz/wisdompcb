program WZPR574;

uses
  Forms,
  Main in 'Main.pas' {Form_Main},
  ScrapDetail in 'ScrapDetail.pas' {Form_ScrapDetail},
  searchfs in 'searchfs.pas' {Form_fasset},
  demo in 'demo.pas' {dm: TDataModule},
  Condition in 'Condition.pas' {Form_Condition};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '�豸���ϴ���';
  Application.CreateForm(Tdm, dm);
  Application.CreateForm(TForm_Main, Form_Main);
  Application.Run;
end.
