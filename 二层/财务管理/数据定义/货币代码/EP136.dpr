program EP136;

uses
  Forms,
  main in 'main.pas' {Form1},
  editcurrency in 'editcurrency.pas' {Form2};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '���Ҵ���';
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
