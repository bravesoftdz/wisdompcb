program A_EP081_WF;

uses
  Forms,
  main in '..\�ֹ��ⷢ����\main.pas' {frmMain},
  DM in '..\�ֹ��ⷢ����\DM.pas' {dmcon: TDataModule},
  WO_Count in '..\�ֹ��ⷢ����\WO_Count.pas' {frmWO_Count},
  Dlg_WO_Qty in '..\�ֹ��ⷢ����\Dlg_WO_Qty.pas' {frmDlg_WO_Qty};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := '�ֹ��ⷢ����';
  Application.CreateForm(Tdmcon, dmcon);
  Application.CreateForm(TfrmMain, frmMain);
  Application.Run;
end.
