program Pu597;

uses
  Forms,
  Umain in 'Umain.pas' {Form2},
  Upu597 in 'Upu597.pas' {DM: TDataModule},
  Uweixin in '..\�ͻ�����\Uweixin.pas' {Form5};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'Ʒ��������������';
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TForm2, Form2);
  Application.CreateForm(TForm5, Form5);
  Application.Run;
end.
