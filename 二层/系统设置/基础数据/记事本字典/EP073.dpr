program EP073;

uses
  Forms,
  main in 'MAIN.PAS' {Form1},
  editnote in 'EDITNOTE.PAS' {Form2};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '���±����Ͽ�';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
