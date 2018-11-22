program WZCX56;

uses
  Forms,
  pasOnlineQuery in 'pasOnlineQuery.pas' {FrmOnlineQuery},
  PasQuery in 'PasQuery.pas' {FrmQuery},
  PasDispatchSMS in 'PasDispatchSMS.pas' {FrmDispatchSMS},
  PasPublic in 'PasPublic.pas',
  PasStepPause in 'PasStepPause.pas' {frmStepPause},
  PasBatchPause in 'PasBatchPause.pas' {FrmBatchPause},
  Pick_Item_Single in 'Pick_Item_Single.pas',
  PasAllPause in 'PasAllPause.pas' {FrmAllPause},
  PasCollect in 'PasCollect.pas' {FrmCollect},
  pasSetFieldName in 'pasSetFieldName.pas' {frmSetFieldName},
  PasDM in 'PasDM.pas' {DM: TDataModule};

{$R *.res}

begin
  Application.Initialize;
  if GetTimeStory = ts_12 then {���Ϊ 12 Сʱ������ʾΪ 24 Сʱ��}
     SetTimeStory(ts_24);
//  else                         {//���Ϊ 24 Сʱ������ʾΪ 12 Сʱ��}
//     SetTimeStory(ts_12);
  Application.Title := '����Ʒ�����ɹ���ѯ';
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TFrmOnlineQuery, FrmOnlineQuery);
  Application.CreateForm(TFrmQuery, FrmQuery);
  Application.Run;
end.
