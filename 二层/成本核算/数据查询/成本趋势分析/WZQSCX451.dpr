program WZQSCX451;

uses
  Forms,
  main in 'main.pas' {Form1},
  damo in 'damo.pas' {DM: TDataModule},
  analysis in 'analysis.pas' {Form2};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '�ɱ����Ʒ���';
  Application.CreateForm(TDM, DM);  
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
