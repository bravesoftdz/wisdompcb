program WZPR127;

uses
  Forms,
  main in 'main.pas' {Form_Main},
  common in 'D:\vss_lyh\���򹫹���λ\common.pas',
  Seach in 'Seach.pas' {Form_Seach},
  Supplier in 'Supplier.pas' {Form_Supplier},
  dmo in 'dmo.pas' {DM: TDataModule},
  Add in 'Add.pas' {Form_Add};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '��Ӧ��˰Ʊ��Ϣ';
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TForm_Main, Form_Main);
  Application.Run;
end.
