program EP024;

uses
  Forms,
  Main in 'Main.pas' {FrmMain},
  AddItems in 'AddItems.pas' {FrmAddItems},
  EditItems in 'EditItems.pas' {FrmEditItems};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '������Ʒ���';
  Application.CreateForm(TFrmMain, FrmMain);
  Application.Run;
end.
