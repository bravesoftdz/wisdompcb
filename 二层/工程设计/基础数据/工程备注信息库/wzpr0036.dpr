program wzpr0036;

uses
  Forms,
  main in 'main.pas' {Form1},
  add in 'add.pas' {Form2},
  edit in 'edit.pas' {Form3};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '���̱�ע��Ϣ��';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
