program A_ep302;

uses
  Forms,
  main in 'main.pas' {main_form};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '���߷��÷���';
  Application.CreateForm(Tmain_form, main_form);
  Application.Run;
end.
