program EP045;

uses
  Forms,
  Main in 'Main.pas' {Form_Main},
  InsertCode in 'InsertCode.pas' {Form_InsertCode};

{$R *.res}

begin
  Application.Initialize;
  Application.Title:='���Ͼ������Ͽ�';
  Application.CreateForm(TForm_Main, Form_Main);
  Application.Run;
end.
