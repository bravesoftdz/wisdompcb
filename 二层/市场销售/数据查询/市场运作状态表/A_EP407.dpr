program A_EP407;

uses
  Forms,
  Unit1 in 'Unit1.pas' {FrmMain},
  Unit2 in 'Unit2.pas' {Form2};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '�г�����״̬';
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
