program EP007;

uses
  Forms,
  prodRSDesign in 'prodRSDesign.pas' {FrmProdRSDesign},
  NProdRSEdit in 'NProdRSEdit.pas' {FrmNProdRSEdit};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '��ֵ˰˰�ʱ�';
  Application.CreateForm(TFrmProdRSDesign, FrmProdRSDesign);
  Application.Run;
end.
