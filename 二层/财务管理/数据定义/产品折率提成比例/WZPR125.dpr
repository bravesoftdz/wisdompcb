program WZPR125;

uses
  Forms,
  UWzpr125 in 'UWzpr125.pas' {Main_Form},
  UDetail in 'UDetail.pas' {Detail_Form};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '��Ʒ������ɱ���';
  Application.CreateForm(TMain_Form, Main_Form);
  Application.CreateForm(TDetail_Form, Detail_Form);
  Application.Run;
end.
