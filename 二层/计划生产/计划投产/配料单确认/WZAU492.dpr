program WZAU492;

uses
  Forms,
  main in 'main.pas' {Form1},
  DAMO in 'DAMO.pas' {DM: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '���ϵ�ȷ��';
  Application.CreateForm(TDM, DM);  
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
