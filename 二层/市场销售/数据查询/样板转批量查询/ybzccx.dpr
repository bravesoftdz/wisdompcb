program ybzccx;

uses
  Forms,
  main in 'main.pas' {mainform};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '��Ʒת�����ʲ�ѯ';
  Application.CreateForm(Tmainform, mainform);
  Application.Run;
end.
