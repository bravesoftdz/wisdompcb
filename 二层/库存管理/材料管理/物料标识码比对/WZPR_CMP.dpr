program WZPR_CMP;

uses
  Forms,
  Main in 'Main.pas' {frmMain};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '���ϱ�ʶ��ȶ�';
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
