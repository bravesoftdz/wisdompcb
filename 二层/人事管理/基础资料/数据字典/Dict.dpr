program Dict;

uses
  Forms,
  main in 'main.pas' {Form_Main},
  dmo in 'dmo.pas' {DM: TDataModule},
  InsertDetail in 'InsertDetail.pas' {Form_InsertDetail},
  common in '..\..\..\..\..\vss_lyh\���򹫹���λ\common.pas',
  form_Main1 in 'form_Main1.pas' {frm_Main1};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '�����ֵ�';
  Application.HelpFile := '';
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TForm_Main, Form_Main);
  
  Application.Run;
end.
