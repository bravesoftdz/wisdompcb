program JHFoolProofSystem;

uses
  Forms,
  Main in 'Main.pas' {Form_main},
  Damo in 'Damo.pas' {DM: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '�����ߴ������ѯ';
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TForm_main, Form_main);
  Application.Run;
end.
