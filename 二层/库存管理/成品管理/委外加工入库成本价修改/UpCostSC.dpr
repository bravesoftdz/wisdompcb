program UpCostSC;

uses
  Forms,
  Unit1 in 'Unit1.pas' {Form1},
  ExcelImport in 'ExcelImport.pas' {frmExcelImport};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'ί��ӹ����ɱ����޸�';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
