program WZCX_R;

uses
  Forms,
  main in 'main.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '�̶��ʲ������۾���Ϣ��ѯ';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
