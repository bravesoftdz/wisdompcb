program Mark01;

uses
  Forms,
  main in 'main.pas' {Form1},
  condition in 'condition.pas' {Form_condition};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '������ϸ';
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm_condition, Form_condition);
  Application.Run;
end.
