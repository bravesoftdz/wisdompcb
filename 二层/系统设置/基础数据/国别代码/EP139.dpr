program EP139;

uses
  Forms,
  main in 'main.pas' {Form1},
  editcountry in 'editcountry.pas' {Form2};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '���һ����';
  Application.CreateForm(TForm1, Form1);
  Application.CreateForm(TForm2, Form2);
  Application.Run;
end.
