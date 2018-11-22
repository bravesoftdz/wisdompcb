program WZPR835;

uses
  Forms,
  Main in 'Main.pas' {Frm_Main},
  damo in 'damo.pas' {DM: TDataModule},
  ColsDisplaySet_unt in 'ColsDisplaySet_unt.pas' {ColsDisplaySet_frm},
  QuerySet in 'QuerySet.pas' {frmQuerySet},
  formGetUserRights in 'formGetUserRights.pas' {frmGetUserRights},
  Recordt in 'Recordt.pas' {frm_Recordt},
  task in '..\..\vss\����ͼ��\task.pas' {Frm_Task},
  HistoryAdd in 'HistoryAdd.pas' {frm_HistoryAdd},
  Employee in 'Employee.pas' {Frm_Employee},
  ProjectTime in 'ProjectTime.pas' {frm_ProjectTime},
  QueryProjectTime in 'QueryProjectTime.pas' {frm_ProjectTimeQuery};

{$R *.res}

begin
  Application.Initialize;
  Application.Title := 'ʩ���ӿյ���ҵ��������¼';
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TFrm_Main, Frm_Main);
  Application.CreateForm(TfrmQuerySet, frmQuerySet);
  Application.CreateForm(Tfrm_ProjectTimeQuery, frm_ProjectTimeQuery);
  Application.Run;
end.
