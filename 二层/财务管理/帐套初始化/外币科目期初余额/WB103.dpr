program WB103;

uses
  Forms,
  main in 'main.pas' {Form1};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '��ҿ�Ŀ�ڳ�����趨';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
