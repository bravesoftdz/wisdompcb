program EP211;

uses
  Forms,
  main in 'main.pas' {Form1},
  price_info in 'price_info.pas' {Form2},
  note in 'NOTE.PAS' {edit_note};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '��Ӧ���ʸ��Ͽ�(AVL)';
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
