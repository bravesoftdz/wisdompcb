program invt_stock;

uses
  Forms,
  MainF in 'MainF.pas' {Main_Form},
  UDetail in 'UDetail.pas' {Detail_Form},
  UDM in 'UDM.pas' {DM: TDataModule},
  UDTime in 'UDTime.pas' {Time_Form};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '���Ͽ��';
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TMain_Form, Main_Form);
  Application.Run;
end.
