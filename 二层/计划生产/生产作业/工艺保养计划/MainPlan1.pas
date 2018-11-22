unit MainPlan1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, MC, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, dxSkinsCore, dxSkinsDefaultPainters,
  dxSkinsdxStatusBarPainter, dxSkinscxPCPainter, //cxPCdxBarPopupMenu,
  dxSkinsdxBarPainter, Menus, ppEndUsr, ppBands, ppPrnabl, ppClass,
  ppCtrls, ppCache, ppProd, ppReport, ppComm, ppRelatv, ppDB, ppDBPipe, DB,
  DBClient, cds, Provider, ADODB, dxBar, cxClasses, ImgList, ActnList,StrUtils,
  Grids, DBGridEh, ToolWin, ComCtrls, cxPC, StdCtrls, RzPanel, ExtCtrls,
  dxStatusBar, Buttons, RzEdit, RzDBEdit, RzDBBnEd, DBButtonEdit, DBCtrls,
  DBCtrlsEh, Mask;

type
  TMainPlan1_f = class(TMC_f)
    cdsMainFASSET_CODE: TStringField;
    cdsMainFASSET_NAME: TStringField;
    cdsMainLOCATION: TStringField;
    cdsMainDEPT_CODE: TStringField;
    cdsMainDEPT_NAME: TStringField;
    cdsMaind417_ptr: TAutoIncField;
    cdsChildMainCycl: TStringField;
    cdsChildItem: TWideStringField;
    cdsChildMainMeth: TWideStringField;
    cdsChildChecAcce: TWideStringField;
    cdsChildD804_ptr: TIntegerField;
    cdsChildrkey: TAutoIncField;
    cdsChildMainDate: TDateTimeField;
    cdsChildStatus: TSmallintField;
    cdsChildMaintMan: TWideStringField;
    cdsChildAcceptan: TWideStringField;
    cdsChildttype: TSmallintField;
    cdsChildAcceEval: TWideStringField;
    cdsChildPlanMainDate: TDateTimeField;
    Button1: TButton;
    cds804: TClientDataSet;
    cds804selected: TBooleanField;
    cds804PlanMainDate: TStringField;
    cds804d417_ptr: TIntegerField;
    cds804FASSET_CODE: TStringField;
    cds804FASSET_NAME: TStringField;
    cds804LOCATION: TStringField;
    cds804DEPT_CODE: TStringField;
    cds804DEPT_NAME: TStringField;
    cds804cycl_duration: TIntegerField;
    cds804InteTime: TIntegerField;
    cds804rkey: TIntegerField;
    cds804D417_ptr_1: TIntegerField;
    cds804number: TSmallintField;
    cds804MainCycl: TStringField;
    cds804Item: TWideStringField;
    cds804MainMeth: TWideStringField;
    cds804ChecAcce: TWideStringField;
    cds804defauMan: TWideStringField;
    cdsChildD417_ptr: TIntegerField;
    dtChildMainCycl: TStringField;
    dtChildItem: TWideStringField;
    dtChildMainMeth: TWideStringField;
    dtChildChecAcce: TWideStringField;
    dtChildD417_ptr: TIntegerField;
    dtChildrkey: TAutoIncField;
    dtChildD804_ptr: TIntegerField;
    dtChildPlanMainDate: TDateTimeField;
    dtChildMainDate: TDateTimeField;
    dtChildStatus: TWordField;
    dtChildMaintMan: TWideStringField;
    dtChildAcceptan: TWideStringField;
    dtChildttype: TWordField;
    dtChildAcceEval: TWideStringField;
    Button4: TButton;
    btn_NoticeMain: TButton;
    cdsMainPlanMainDate: TDateTimeField;
    cds417: TClientDataSet;
    cds417FASSET_CODE: TStringField;
    cds417FASSET_NAME: TStringField;
    cds417LOCATION: TStringField;
    cds417DEPT_CODE: TStringField;
    cds417DEPT_NAME: TStringField;
    GroupBox2: TGroupBox;
    Label17: TLabel;
    Label18: TLabel;
    bt_Find: TSpeedButton;
    DateTimePicker3: TDateTimePicker;
    DateTimePicker4: TDateTimePicker;
    GroupBox3: TGroupBox;
    Filter_Label: TLabel;
    Filter_Edit: TEdit;
    btn_StartMain: TButton;
    btn_SubmAppr: TButton;
    btn_ConfAcce: TButton;
    btn_ChangeMan: TButton;
    dtChildEndMainDate: TDateTimeField;
    cdsChildEndMainDate: TDateTimeField;
    Button9: TButton;
    dtChildRemark: TWideStringField;
    cdsChildRemark: TWideStringField;
    cdsAddPlan: TClientDataSet;
    cdsMainAcceptan: TStringField;
    cdsMainAcceCode: TStringField;
    dtChildAcceptan_ptr: TIntegerField;
    cdsChildAcceptan_ptr: TIntegerField;
    cdsChildMainTime: TBCDField;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    edt_MainCycl: TDBEdit;
    edt_Status: TDBEdit;
    edt_MaintMan: TDBEdit;
    edt_Acceptan: TDBEdit;
    edt_MainMeth: TDBMemo;
    dtedt_PlanMainDate: TDBDateTimeEditEh;
    dtedt_EndMainDate: TDBDateTimeEditEh;
    edt_ChecAcce: TDBMemo;
    edt_Item: TDBMemo;
    edt_AcceEval: TDBMemo;
    edt_ttype: TDBComboBox;
    dtedt_BeginMainDate: TDBDateTimeEditEh;
    edt_AcceCode: TDBButtonEdit;
    Label21: TLabel;
    edt_MainTime: TDBEdit;
    dtChildMainExecStat: TStringField;
    cdsChildMainExecStat: TStringField;
    dtChildAcceCode: TStringField;
    cdsChildAcceCode: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure cdsChildStatusGetText(Sender: TField; var Text: String;
      DisplayText: Boolean);
    procedure cdsChildttypeGetText(Sender: TField; var Text: String;
      DisplayText: Boolean);
    procedure cdsChildttypeSetText(Sender: TField; const Text: String);
    procedure dspChildGetTableName(Sender: TObject; DataSet: TDataSet;
      var TableName: String);
    procedure DghMainKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dghChildKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btn_SubmApprClick(Sender: TObject);
    procedure btn_ConfAcceClick(Sender: TObject);
    procedure btn_NoticeMainClick(Sender: TObject);
    procedure btn_ChangeManClick(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure cdsMainFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure bt_FindClick(Sender: TObject);
    procedure Filter_EditChange(Sender: TObject);
    procedure DghMainTitleClick(Column: TColumnEh);
    procedure FormShow(Sender: TObject);
    procedure btn_StartMainClick(Sender: TObject);
    procedure Button9Click(Sender: TObject);
    procedure cdsChildCalcFields(DataSet: TDataSet);
    procedure MainGrid_PopupMenuPopup(Sender: TObject);
    procedure cdsChildStatusChange(Sender: TField);
  private
    Curr_date:TDateTime;
    FilterFieldName:string;

    procedure SetFilterComponent(Column: TColumnEh);
    procedure ChildDataSetOpen;override;
    procedure SetToolbarButtonStatus(Flag: Boolean); override;
   // procedure SetButtonStatus;                       override;
    procedure SetMultiSelectButtonStatus;            override;
     { Private declarations }
  public
    { Public declarations }
  end;

var
  MainPlan1_f: TMainPlan1_f;


implementation

uses DM_f, PublicFile, formSelectMultiItem, MainPlan, formInputDlg,
   LogWriteform, SelectItem_unt;

{$R *.dfm}

procedure TMainPlan1_f.SetMultiSelectButtonStatus;
var
  i:Integer;
  BM:Pointer;
  Statu7,Statu3,Statu5,Statu2,Statu4,Statu6:Boolean;
  procedure ButtonStatus;
  begin
    with cdsChild do
    if FieldByName('Status').AsInteger=1 then    //��ִ��
    begin
     // Statu1:=False;       //1	��ִ��
    //  Statu5:=True;       //5	��֪ͨ
      Statu3:=False;       //3	ִ����
      Statu6:=False;       //6	����ͣ
      Statu4:=False;       //4	������
      Statu2:=False;       //2	������
    end
    else
    if FieldByName('Status').AsInteger =5 then    //��֪ͨ
    begin
     // Statu1:=False;       //1	��ִ��
      Statu5:=False;        //5	��֪ͨ
      //Statu3:=True;        //3	ִ����
      Statu6:=False;       //6	����ͣ
      Statu4:=False;       //4	������
      Statu2:=False;       //2	������
    end
    else
    if FieldByName('Status').AsInteger=3 then     //ִ����
    begin
      //Statu1:=False;       //1	��ִ��
      Statu5:=False;        //5	��֪ͨ
      Statu3:=False;        //3	ִ����
//      Statu6:=True;        //6	����ͣ
//      Statu4:=True;        //4	������
      Statu2:=False;       //2	������
    end
    else
    if FieldByName('Status').AsInteger =6 then    //����ͣ
    begin
     // Statu1:=False;       //1	��ִ��
      Statu5:=False;        //5	��֪ͨ
//      Statu3:=True;        //3	ִ����
      Statu6:=False;        //6	����ͣ
      Statu4:=False;        //4	������
      Statu2:=False;       //2	������
    end
    else
    if FieldByName('Status').AsInteger =4 then    // ������
    begin
    //  Statu1:=False;       //1	��ִ��
      Statu5:=False;        //5	��֪ͨ
      Statu3:=False;        //3	ִ����
      Statu6:=False;        //6	����ͣ
      Statu4:=False;        //4	������
//      Statu2:=True;       //2	������
    end
    else
    if FieldByName('Status').AsInteger=2 then    //������
    begin
     // Statu1:=False;       //1	��ִ��
      Statu5:=False;        //5	��֪ͨ
      Statu3:=False;        //3	ִ����
      Statu6:=False;        //6	����ͣ
      Statu4:=False;        //4	������
      Statu2:=False;       //2	������
    end;
  end;   
begin
  Statu5:=True;        //5	��֪ͨ
  Statu3:=True;        //3	ִ����
  Statu6:=True;        //6	����ͣ
  Statu4:=True;        //4	������
  Statu2:=True;       //2	������

  with  dghChild do
  begin
    if SelectedRows.Count>1 then
    begin
      try
        Screen.Cursor := crHourGlass;
        BM:=cdsChild.GetBookmark;
        cdsChild.DisableControls ;
        cdsChild.F_IsBatchOperating:=True;
        for   i:= 0 to SelectedRows.Count-1 do
        begin
          cdsChild.GotoBookmark(pointer(SelectedRows.Items[i]));
          ButtonStatus;      //���ù��̣����õ�ǰ��ť��״ֵ̬��
        end;
        //EditStatus:=False;          //����Ƕ���ѡ���ʱ�򣬱༭��ť���ɲ�����
      finally
        cdsChild.GotoBookmark(BM);
        cdsChild.FreeBookmark(BM);
        cdsChild.EnableControls;
        cdsChild.F_IsBatchOperating:=False;
        Screen.Cursor := crDefault;
      end;
      btn_StartMain.Enabled:=Statu3;   // ��ʼ����
      btn_SubmAppr .Enabled:=Statu4;   //�ύ����
      btn_ConfAcce .Enabled:=Statu2;   //ȷ������

      btn_ChangeMan .Enabled:=False;   //���������ѡ���ʱ�򣬡����ı����ˡ���ť���ɲ�����
    end  ;
  end;
 // 1	��ִ��;2	������;3	ִ����;4	������;5	��֪ͨ;6	����ͣ;7	�ѽ���;8	�����˻�
//  Button7.Enabled:=  btnStatu7 and (StrToInt(vprev)in [2,3,4]);//֪ͨ����    
end;

procedure TMainPlan1_f.SetToolbarButtonStatus(Flag: Boolean);
begin
  dxBarManager.LockUpdate:=True;
  with   ActiveGridEH.DataSource.DataSet as TClientDataSet do
  begin
    tblAdd.Enabled:=Flag and (StrToInt(vprev)in [2,4]);
    actAdd.Enabled:=Flag and (StrToInt(vprev)in [2,4]);

    tblEdit.Enabled:=Flag and (StrToInt(vprev)in [2,4])and(IsEmpty=False);
    actEdit.Enabled:=Flag and (StrToInt(vprev)in [2,4])and(IsEmpty=False);

    tblDelete.Enabled:=( Flag)and(IsEmpty=False) and (StrToInt(vprev)in [2,4]);
    actDelete.Enabled:=( Flag)and(IsEmpty=False) and (StrToInt(vprev)in [2,4]);

    if ActiveGridEH=DghMain then
    begin
      tblDelete.Enabled:=False;   //����������ɾ����ť���������
      actDelete.Enabled:=False;
      tblAdd.Enabled:=False;      //����������������ť���������
      actAdd.Enabled:=False;
      tblEdit.Enabled:=False;
      actEdit.Enabled:=False;

      if cdsMain.Active then       //(cdsMain.UpdateStatus=usModified)
      if (cdsMain.ChangeCount>0)or(cdsMain.State in [dsEdit,dsInsert])    then
      begin
        tblCancel.Enabled:=True;
        actCancel.Enabled:=True;
      end
      else
      begin
        tblCancel.Enabled:=False;
        actCancel.Enabled:=False;
      end;
    end
    else
    if ActiveGridEH=dghChild then
    begin
      if (cdsChild.ChangeCount>0)or(cdsChild.State in [dsEdit,dsInsert])    then
      begin
        tblCancel.Enabled:=True;
        actCancel.Enabled:=True;
      end
      else
      begin
        tblCancel.Enabled:=False;
        actCancel.Enabled:=False;
      end;
    end;

    if ((cdsMain.State  in [dsEdit,dsInsert])or(cdsMain.ChangeCount>0))
                or((cdsChild.State  in [dsEdit,dsInsert])or(cdsChild.ChangeCount>0))and(StrToInt(vprev)in [2,4])  then
      begin
        tblSave.Enabled:=True;
        actSave.Enabled:=True;
        tblfind.Enabled:=False;
        actFind.Enabled:= False;
        tblRefresh.Enabled:=False;
        actRefresh .Enabled:= False;
        tblExport.Enabled:=False;
        actExport.Enabled:=False; //����
        tblExit.Enabled:=False;   //�˳�
        tblPrint.Enabled:= False;      //��ӡ
        tblDesign.Enabled:=False ;      //�������
        tblFilter.Enabled:= False;
        tblReject.Enabled:=False ;   //���ύ
        tblExpand.Enabled:=False ;   //�ύ
        tblConfirm.Enabled:=False;   //���
        tblUConfirm.Enabled:=False;  //�����
      end
    else
      begin
        tblSave.Enabled:=False;
        actSave.Enabled:=False;
        tblfind.Enabled:= True;
        actFind.Enabled:= True;
        tblRefresh .Enabled:=True;
        actRefresh .Enabled:=True;
        tblExport.Enabled:=True;
        actExport.Enabled:=True;
        tblExit.Enabled:=True;
        tblPrint.Enabled:= True   and (StrToInt(vprev)in [2,4]);      //��ӡ
        tblDesign.Enabled:=True   and (StrToInt(vprev)in [2,4]) ;      //�������
        tblFilter.Enabled:= True;
        tblReject.Enabled:=True   and (StrToInt(vprev)in [2,4]) ;   //���ύ
        tblExpand.Enabled:=True   and (StrToInt(vprev)in [2,4]) ;   //�ύ
        tblConfirm.Enabled:=True  and (StrToInt(vprev)in [2,4]);   //���
        tblUConfirm.Enabled:=True and (StrToInt(vprev)in [2,4]);  //�����
      end ;
  end;

  with cdsChildstatus do    //����״ֵ̬��Ȩ���룬���ô��ڵ���Щ����ɱ༭��
  begin                     //1	��ִ��;2	������;3	ִ����;4	������;5	��֪ͨ;6	����ͣ;7	�ѽ���;8	�����˻�
  
    if (AsInteger in [1])and (StrToInt(vprev) in [2,4]) then//���״̬��1	��ִ�У������ƻ����ںͱ�����ʼʱ��ɱ༭��
    begin
      ControlsSetReadOnly([dtedt_PlanMainDate,dtedt_BeginMainDate,dtedt_EndMainDate,edt_MaintMan,edt_ttype,edt_AcceEval]);
      ControlsSetReadOnly([edt_MaintMan],False);
      dghChild.FieldColumns['PlanMainDate'].ReadOnly:=true ;
      dghChild.FieldColumns['BeginMainDate'].ReadOnly:=true;
      dghChild.FieldColumns['EndMainDate'].ReadOnly:=true;
      dghChild.FieldColumns['MaintMan'].ReadOnly:=False;
      dghChild.FieldColumns['ttype'].ReadOnly:=true;
      dghChild.FieldColumns['AcceEval'].ReadOnly:=true;

      btn_NoticeMain .Enabled:=true;//:֪ͨ����;
      btn_StartMain  .Enabled:=false;//��ʼ����;
      btn_SubmAppr   .Enabled:=false;//�ύ����;
      btn_ConfAcce   .Enabled:=false;//ȷ������
    end
    else
    if (AsInteger in [5])and (StrToInt(vprev) in [2,4]) then//���״̬��5	��֪ͨ�������ƻ����ںͱ�����ʼʱ��ɱ༭��
    begin
      ControlsSetReadOnly([dtedt_PlanMainDate,dtedt_EndMainDate,edt_MaintMan,edt_ttype,edt_AcceEval]);
      ControlsSetReadOnly([dtedt_BeginMainDate],False);

      dghChild.FieldColumns['PlanMainDate'].ReadOnly:=true;
      dghChild.FieldColumns['BeginMainDate'].ReadOnly:=False;
      dghChild.FieldColumns['EndMainDate'].ReadOnly:=true;
      dghChild.FieldColumns['MaintMan'].ReadOnly:=true;
      dghChild.FieldColumns['ttype'].ReadOnly:=true;
      dghChild.FieldColumns['AcceEval'].ReadOnly:=true;

      btn_NoticeMain .Enabled:=false;//:֪ͨ����;
      btn_StartMain  .Enabled:=true;//��ʼ����;
      btn_SubmAppr   .Enabled:=false;//�ύ����;
      btn_ConfAcce   .Enabled:=false;//ȷ������
    end
    else
    if (AsInteger in [3])and (StrToInt(vprev) in [2,4]) then//���״̬��3	ִ���У������ƻ����ںͱ�����ʼʱ��ɱ༭��
    begin
      ControlsSetReadOnly([dtedt_PlanMainDate,dtedt_BeginMainDate,edt_MaintMan,edt_ttype,edt_AcceEval]);
      ControlsSetReadOnly([dtedt_EndMainDate],False);

      dghChild.FieldColumns['PlanMainDate'].ReadOnly:=true;
      dghChild.FieldColumns['BeginMainDate'].ReadOnly:=true;
      dghChild.FieldColumns['EndMainDate'].ReadOnly:=False;
      dghChild.FieldColumns['MaintMan'].ReadOnly:=true;
      dghChild.FieldColumns['ttype'].ReadOnly:=true;
      dghChild.FieldColumns['AcceEval'].ReadOnly:=true;

      btn_NoticeMain .Enabled:=false;//:֪ͨ����;
      btn_StartMain  .Enabled:=false;//��ʼ����;
      btn_SubmAppr   .Enabled:=true;//�ύ����;
      btn_ConfAcce   .Enabled:=false;//ȷ������
    end
    else
    if (AsInteger in [4])and (StrToInt(vprev) in [2,4]) then  //�����4	�����գ����������ֶοɱ༭��
    begin
      ControlsSetReadOnly([dtedt_PlanMainDate,dtedt_BeginMainDate,edt_MaintMan]);
      ControlsSetReadOnly([dtedt_EndMainDate,edt_ttype,edt_AcceEval],False);

      dghChild.FieldColumns['PlanMainDate'].ReadOnly:=true;
      dghChild.FieldColumns['BeginMainDate'].ReadOnly:=true;
      dghChild.FieldColumns['EndMainDate'].ReadOnly:=true;
      dghChild.FieldColumns['MaintMan'].ReadOnly:=true;
      dghChild.FieldColumns['ttype'].ReadOnly:=False;
      dghChild.FieldColumns['AcceEval'].ReadOnly:=False;

      btn_NoticeMain .Enabled:=false;//:֪ͨ����;
      btn_StartMain  .Enabled:=false;//��ʼ����;
      btn_SubmAppr   .Enabled:=false;//�ύ����;
      btn_ConfAcce   .Enabled:=true;//ȷ������
    end
    else
    if (AsInteger in [2])and (StrToInt(vprev) in [2,4]) then    //2	������
    begin
      ControlsSetReadOnly([dtedt_PlanMainDate,dtedt_BeginMainDate,dtedt_EndMainDate,edt_MaintMan,edt_ttype,edt_AcceEval]);
      dghChild.FieldColumns['PlanMainDate'].ReadOnly:=true;
      dghChild.FieldColumns['BeginMainDate'].ReadOnly:=true;
      dghChild.FieldColumns['EndMainDate'].ReadOnly:=true;
      dghChild.FieldColumns['MaintMan'].ReadOnly:=true;
      dghChild.FieldColumns['ttype'].ReadOnly:=True;
      dghChild.FieldColumns['AcceEval'].ReadOnly:=True;

      btn_NoticeMain .Enabled:=false;//:֪ͨ����;
      btn_StartMain  .Enabled:=false;//��ʼ����;
      btn_SubmAppr   .Enabled:=false;//�ύ����;
      btn_ConfAcce   .Enabled:=false;//ȷ������  
    end;
  end;
  btn_ChangeMan.Enabled:=(cdsChild.FieldByName('MaintMan').IsNull=false)and(cdsChild.FieldByName('MaintMan').AsString<>'')   ;
  with ActiveGridEH do
  begin
    if  DataSource.DataSet.Eof  then
    begin
    tblNext.Enabled:=False ;
    tblLast.Enabled:=False ;
    end
    else
    begin
    tblNext.Enabled:=True ;
    tblLast.Enabled:=True ;
    end;

    if  DataSource.DataSet.Bof  then
    begin
    tblPrior.Enabled:=False     ;
    tblFirst.Enabled:=False     ;
    end
    else
    begin
    tblPrior.Enabled:=True     ;
    tblFirst.Enabled:=True     ;
    end;
  end;

  if tblExit.Enabled then
     actClose.ImageIndex:=102
  else
     actClose.ImageIndex:=107;

  if tblAdd.Enabled then
     actAdd.ImageIndex:=3
  else
     actAdd.ImageIndex:=58;

  if tblEdit.Enabled then
     actEdit.ImageIndex:=4
  else
     actEdit.ImageIndex:=62;

  if tblSave.Enabled then
     actSave.ImageIndex:=137
  else
     actSave.ImageIndex:=60;

  if tblCancel.Enabled then
     actCancel.ImageIndex:=5
  else
     actCancel.ImageIndex:=55;

  if tblDelete.Enabled then
     actDelete.ImageIndex:=6
  else
     actDelete.ImageIndex:=57;

  if tblFind.Enabled then
     actFind.ImageIndex:=17
  else
     actFind.ImageIndex:=64;

  if tblRefresh.Enabled then
     actRefresh.ImageIndex:=103
  else
     actRefresh.ImageIndex:=106;

  if tblFirst.Enabled then
     actFirst.ImageIndex:=99
  else
     actFirst.ImageIndex:=96;

  if tblPrior.Enabled then
     actPrior.ImageIndex:=95
  else
     actPrior.ImageIndex:=94;

  if tblNext.Enabled then
     actNext.ImageIndex:=100
  else
     actNext.ImageIndex:=101;

  if tblLast.Enabled then
     actlast.ImageIndex:=97
  else
     actLast.ImageIndex:=98;

  if tblDesign.Enabled then
     actDesign.ImageIndex:=127
  else
     actDesign.ImageIndex:=132;

  if tblExpand.Enabled then
     actExpand.ImageIndex:=131
  else
     actExpand.ImageIndex:=135;

  if tblReject.Enabled then
     actReject.ImageIndex:=130
  else
     actReject.ImageIndex:=136;

  if tblPrint.Enabled then
     actPrint.ImageIndex:=19
  else
     actPrint.ImageIndex:=66;

  if tblExport.Enabled then
     actExport.ImageIndex:=119
  else
     actExport.ImageIndex:=120;

  if tblCancelFilter.Enabled then
     actCancelFilter.ImageIndex:= 128
  else
     actCancelFilter.ImageIndex:=133;

  if tblFilter.Enabled then
     actFilter.ImageIndex:=    129
  else
     actFilter.ImageIndex:= 134;

  if tblConfirm.Enabled then
     actConfirm.ImageIndex:=114
  else
     actConfirm.ImageIndex:= 116;

  if tblUConfirm.Enabled then
     actUConfirm.ImageIndex:=115
  else
     actUConfirm.ImageIndex:= 117;

  dxBarManager.LockUpdate:=False;
end;

procedure TMainPlan1_f.ChildDataSetOpen;
begin
  with cdsChild do
  begin
    if cdsMain.IsEmpty=False then
    begin
      Close;
      CommandText:=F_SQLSelectFrom+#13+'where CONVERT(VARCHAR(10),data0810.[PlanMainDate],120)='
        +QuotedStr(cdsMain.FieldByName('PlanMainDate').AsString)
        +' and data0804.[D417_ptr]='+ cdsMain.FieldByName('d417_ptr').AsString
        +#13+F_sqlOrderby;
      Open;
    end
    else
    begin
      Close;
      CommandText:=F_SQLSelectFrom+#13+'where 1=2'
      +#13+F_sqlOrderby;
      Open;
    end;
  end;
end;

procedure TMainPlan1_f.FormCreate(Sender: TObject);
begin  
  inherited;
  Curr_Date:=GetDataBaseDate(cdsRead,2) ;
  DateTimePicker3.Date:=Curr_Date;
  DateTimePicker4.Date:=Curr_Date+7;
  bt_FindClick(nil);

  ChildDataSetOpen;
  IsMC:=False;
  SetFilterComponent(DghMain.FieldColumns['FASSET_NAME']); 

  FindDisplayFields:=VarArrayOf(['PlanMainDate','FASSET_CODE','FASSET_NAME','LOCATION','DEPT_CODE','DEPT_NAME']);

  ControlsSetReadOnly([
    edt_MainCycl,dtedt_PlanMainDate,dtedt_BeginMainDate,dtedt_EndMainDate,
    edt_MainTime,edt_Item,edt_MainMeth,edt_ChecAcce,
    edt_Status,edt_MaintMan,edt_Acceptan,edt_AcceCode,edt_ttype,edt_AcceEval]);

  if MainPlan_f.cds832.Active=False then
    MainPlan_f.cds832.Open;

  var_DropDown_Info:=TDropDownInfo.Create();
  with var_DropDown_Info do
  begin
    L_ColsInfo:='DEPT_CODE/���Ŵ���/100,DEPT_NAME/��������/120';
    L_FindDataSet           :=MainPlan_f.cds0034;
    L_DropdownColumn        :='DEPT_CODE';
    L_ListDataSetFilterField:='DEPT_CODE';
    L_ListResultField       :='DEPT_CODE';
    L_GetValueField         :='DEPT_CODE';
  end;
  DropDown_Info_List.Add(var_DropDown_Info) ;

  var_DropDown_Info:=TDropDownInfo.Create();
  with var_DropDown_Info do
  begin
    L_ColsInfo:='FASSET_CODE/�豸����/100,DEPT_NAME/�豸����/120';
    L_FindDataSet           :=cds417;
    L_DropdownColumn        :='FASSET_CODE';
    L_ListDataSetFilterField:='FASSET_CODE';
    L_ListResultField       :='FASSET_CODE';
    L_GetValueField         :='FASSET_CODE';
  end;
  DropDown_Info_List.Add(var_DropDown_Info) ;
end;

procedure TMainPlan1_f.cdsChildStatusGetText(Sender: TField;
  var Text: String; DisplayText: Boolean);
begin
  inherited;
  if (Sender.IsNull=False)then
  Text:=MainPlan_f.cds832.Lookup('rkey',Sender.AsInteger,'MainExecStat');
end;

procedure TMainPlan1_f.cdsChildttypeGetText(Sender: TField;
  var Text: String; DisplayText: Boolean);
begin
  inherited;
  if   Sender.Value=1 then
    Text:= '��'
  else
  if   Sender.Value=2 then
    Text:= '��'
  else
  if   Sender.Value=3 then
    Text:= 'һ��'
  else
  if   Sender.Value=4 then
    Text:= '��'     ; 
end;

procedure TMainPlan1_f.cdsChildttypeSetText(Sender: TField;
  const Text: String);
begin
  inherited;

  if Text= '��'   then
     Sender.Value:=1
  else
  if Text= '��'  then
     Sender.Value:=2
  else
  if Text= 'һ��'  then
     Sender.Value:=3
  else
  if Text= '��'   then
     Sender.Value:=4    ;
end;

procedure TMainPlan1_f.dspChildGetTableName(Sender: TObject;
  DataSet: TDataSet; var TableName: String);
begin
  inherited;
  TableName:='data0810';
end;

procedure TMainPlan1_f.DghMainKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  with   (Sender as TDBGridEh ).DataSource.DataSet  do
  if (Key in[VK_down])and(RecNo=RecordCount ) then    //��������¼����ҵ�ǰ��¼�ŵ����ܼ�¼��
  begin
    Key:=0;
  end;
end;

procedure TMainPlan1_f.dghChildKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  with   (Sender as TDBGridEh ).DataSource.DataSet  do
  if (Key in[VK_down])and(RecNo=RecordCount ) then    //��������¼����ҵ�ǰ��¼�ŵ����ܼ�¼��
  begin
    Key:=0;
  end;
end;

procedure TMainPlan1_f.btn_SubmApprClick(Sender: TObject);
  function  ExecBeforeCheck():Boolean;
  var
    strMsg:string;
    i:Integer;
  begin
    Result:=True;
    with cdsChild do
    if   dghChild.SelectedRows.Count   >   1   then
    begin
      try
        F_IsBatchOperating :=True;
        DisableControls;
        Screen.Cursor := crHourGlass;
        for   i:=0 to  dghChild.SelectedRows.Count   -   1   do
        begin
          GotoBookmark(pointer(dghChild.SelectedRows.Items[i]));
          if (FieldByName('MaintMan').IsNull)or(FieldByName('MaintMan').AsString='') then
            strMsg:=strMsg+'��ϸ���'+IntToStr(i+1)+'�У��ֶΣ���'
            +cdsChild.FieldByName('MaintMan').DisplayLabel+'����ֵ����Ϊ�գ�����'+#13 ;
        end;

      finally
        F_IsBatchOperating :=False;
        EnableControls;
        Screen.Cursor := crDefault;
      end;
    end
    else
    begin
      if (FieldByName('MaintMan').IsNull)or(FieldByName('MaintMan').AsString='') then
        strMsg:=strMsg+'��ϸ���'+IntToStr(RecNo)+'�У��ֶΣ���'
            +cdsChild.FieldByName('MaintMan').DisplayLabel+'����ֵ����Ϊ�գ�����'+#13 ;
    end;
    if strMsg<>'' then
    begin
      MsgError(Copy(strMsg,0,Length(strMsg)-1));
      Result:=False;
    end;
  end;
var
  i:Integer;
  Curr_date1:TDateTime;
begin
  inherited;
  with   cdsChild  do
  if (Active)and(not IsEmpty ) then
  if ExecBeforeCheck  then
  begin         
    if messagebox(Self.Handle,'��ȷ��Ҫ�ύ������','ѯ��',MB_yesno+MB_iconquestion)=idNo then
      Exit ;
    if State in [dsEdit,dsInsert] then
      Post;

    if   dghChild.SelectedRows.Count   >   1   then  //����û�ѡ�����������1�������С�
      begin
        Curr_date1:=GetDataBaseDate(cdsRead,1);
        try
          try
            F_IsBatchOperating :=True;
            DisableControls;
            Screen.Cursor := crHourGlass;
            DM.ADOConnection1.BeginTrans;
            for   i:=   dghChild.SelectedRows.Count   -   1   downto   0   do
            begin
              GotoBookmark(pointer(dghChild.SelectedRows.Items[i]));
              Edit;
              FieldByName('Status').Value:=4;                  //��״̬��Ϊ����
              if (FieldByName('EndMainDate').IsNull)then
                FieldByName('EndMainDate').Value:= Curr_date1;
              Post;
            end;

            if (IsLog)then
            if Log_Add(Data_Info)=False  then
              Exit;
            if ApplyUpdates(0)=0 then
              begin
                if IsLog then
                begin
                  if Log_Save() then
                  begin
                    DM.ADOConnection1.CommitTrans;    //����1
                  end
                  else
                  begin
                    DM.ADOConnection1.RollbackTrans;
                  end;
                end
                else
                begin
                  DM.ADOConnection1.CommitTrans;         //����2
                end;
              end
            else
              DM.ADOConnection1.RollbackTrans;
          finally
            F_IsBatchOperating :=False;
            EnableControls;
            Screen.Cursor := crDefault;
          end;
        except
          on e:Exception do
          begin
            DM.ADOConnection1.RollbackTrans;
            Cancel;
            Refresh;
            MsgError('֪ͨʧ�ܣ�'+#13#10+e.Message);
          end;
        end;
      end
    else
      begin
        try
          try
            Screen.Cursor := crHourGlass;
            DM.ADOConnection1.BeginTrans;
            Edit;
            FieldByName('Status').Value:=4;                  //��״̬��Ϊ����֪ͨ ��
            if (FieldByName('EndMainDate').IsNull)then
                FieldByName('EndMainDate').Value:= GetDataBaseDate(cdsRead,1);
            Post;
            
            if ApplyUpdates(0)=0 then
              DM.ADOConnection1.CommitTrans
            else
              DM.ADOConnection1.RollbackTrans;
          finally
            Screen.Cursor := crDefault;
          end;
        except
          on e:Exception do
          begin
            if DM.ADOConnection1.InTransaction then
              DM.ADOConnection1.RollbackTrans;
            Cancel;
            Refresh;
            MsgError('֪ͨʧ�ܣ�'+#13#10+e.Message);
          end;
        end;
      end;
    SetButtonStatus;
    dsMainStateChange(nil);
  end;
end;

procedure TMainPlan1_f.btn_ConfAcceClick(Sender: TObject);
var
  i:Integer;
  str_AcceCode:string;
begin
  inherited;
  with   cdsChild  do
  if (Active)and(not IsEmpty ) then
  begin
    if Show_Item_frm(MainPlan_f.cds005,'AcceCode',cdsMain.FieldByName('AcceCode').AsString,'',nil,'ѡ��������') then
      str_AcceCode:=MainPlan_f.cds005.FieldByName('AcceCode').AsString
    else
      Exit;

    if State in [dsEdit,dsInsert] then
      Post;
    
    if   dghChild.SelectedRows.Count   >   1   then  //����û�ѡ�����������1�������С�
      begin
        try
          try
            F_IsBatchOperating :=True;
            DisableControls;
            Screen.Cursor := crHourGlass;
            DM.ADOConnection1.BeginTrans;
            for   i:=   dghChild.SelectedRows.Count   -   1   downto   0   do
            begin
              GotoBookmark(pointer(dghChild.SelectedRows.Items[i]));
              Edit;
              FieldByName('Status').Value:=2;                  //��״̬��Ϊ����
              if (FieldByName('AcceCode').Value<>str_AcceCode)then
              begin
                FieldByName('Acceptan_ptr').Value  :=MainPlan_f.cds005.FieldByName('rkey').Value;
                FieldByName('AcceCode').Value      :=MainPlan_f.cds005.FieldByName('AcceCode').Value;
                FieldByName('Acceptan').Value      :=MainPlan_f.cds005.FieldByName('AcceName').Value; ;
              end;
              Post;
            end;

            if (IsLog)then
            if Log_Add(Data_Info)=False  then
              Exit;
            if ApplyUpdates(0)=0 then
              begin
                if IsLog then
                begin
                  if Log_Save() then
                  begin
                    DM.ADOConnection1.CommitTrans;    //����1
                  end
                  else
                  begin
                    DM.ADOConnection1.RollbackTrans;
                  end;
                end
                else
                begin
                  DM.ADOConnection1.CommitTrans;         //����2
                end;
              end
            else
              DM.ADOConnection1.RollbackTrans;
          finally
            F_IsBatchOperating :=False;
            EnableControls;
            Screen.Cursor := crDefault;
          end;
        except
          on e:Exception do
          begin
            if DM.ADOConnection1.InTransaction then
              DM.ADOConnection1.RollbackTrans;
            Cancel;
            Refresh;
            MsgError('֪ͨʧ�ܣ�'+#13#10+e.Message);
          end;
        end;
      end
    else
      begin
        try
          try
            Screen.Cursor := crHourGlass;
            DM.ADOConnection1.BeginTrans;
            Edit;
            FieldByName('Status').Value:=2;                  //��״̬��Ϊ����֪ͨ ��
              if (FieldByName('AcceCode').Value<>str_AcceCode)then
              begin
                FieldByName('Acceptan_ptr').Value  :=MainPlan_f.cds005.FieldByName('rkey').Value;
                FieldByName('AcceCode').Value      :=MainPlan_f.cds005.FieldByName('AcceCode').Value;
                FieldByName('Acceptan').Value      :=MainPlan_f.cds005.FieldByName('AcceName').Value; ;
              end;
            Post;

            if (IsLog)then
            if Log_Add(Data_Info)=False  then
              Exit;            
            if ApplyUpdates(0)=0 then
              begin
                if IsLog then
                begin
                  if Log_Save() then
                  begin
                    DM.ADOConnection1.CommitTrans;    //����1
                  end
                  else
                  begin
                    DM.ADOConnection1.RollbackTrans;
                  end;
                end
                else
                begin
                  DM.ADOConnection1.CommitTrans;         //����2
                end;
              end
            else
              DM.ADOConnection1.RollbackTrans;
          finally
            Screen.Cursor := crDefault;
          end;
        except
          on e:Exception do
          begin
            if DM.ADOConnection1.InTransaction then
              DM.ADOConnection1.RollbackTrans;
            Cancel;
            Refresh;
            MsgError('֪ͨʧ�ܣ�'+#13#10+e.Message);
          end;
        end;
      end;
    SetButtonStatus;
    dsMainStateChange(nil);
  end;
end;

procedure TMainPlan1_f.btn_NoticeMainClick(Sender: TObject);
  function  ExecBeforeCheck():Boolean;
  var
    strMsg:string;
  begin
    Result:=True;
    cdsRead.Data:=   cdsChild.Data;
    with cdsRead do
    begin
      while  not Eof  do
      begin
        if (FieldByName('MaintMan').IsNull)or(FieldByName('MaintMan').AsString='') then
          strMsg:=strMsg+'��ϸ���'+IntToStr(RecNo)+'�У��ֶΣ���'
          +cdsChild.FieldByName('MaintMan').DisplayLabel+'����ֵ����Ϊ�գ�����'+#13 ;
        Next;  
      end;
    end;
    if strMsg<>'' then
    begin
      MsgError(Copy(strMsg,0,Length(strMsg)-1));
      Result:=False;
    end;
  end;
var
  TempTable:string;
  IsSenderMsg:Boolean;
  vPhone,str_SQL:string;
begin
  inherited;
  IsSenderMsg:=True;
  if ExecBeforeCheck then
  with   cdsChild  do
  if (Active)and(not IsEmpty ) then
  begin
    if messagebox(Self.Handle,'��ȷ��Ҫ֪ͨ�����Ա���б�����','ѯ��',MB_yesno+MB_iconquestion)=idNo then
      Exit ;
    if State in [dsEdit,dsInsert] then
      Post;

    TempTable:='##PhoneMsg'+IntToStr(UserRKEY);   //��ʱ���͵�½�û�ָ���������ʹ��ͬ���û�ͬʱ������Ҳ�����໥Ӱ�졣
    with cdsChild do
      begin
        try
          try
            F_IsBatchOperating :=True;
            DisableControls;
            Screen.Cursor := crHourGlass;
            DM.ADOConnection1.BeginTrans;

            if messagebox(Self.Handle,'��Ҫ�ֻ�����֪ͨ�����˶Ը��豸Ҫ���б�����','ѯ��',MB_yesno+MB_iconquestion)= idNo then
            IsSenderMsg:=False;

            First;
            while not Eof do
            begin
              Edit;
              FieldByName('status').Value:=5;                  //��״̬��Ϊ����֪ͨ��
              Post;
             { if   IsSenderMsg=True then
              with cdsRead do
              begin
                Close;
                CommandText:=
                //���������Ǹ�������Ա�����ֻ�����
                 'insert into '+TempTable+'(FASSET_ptr,Phone,Msg)'      //���͸��豸��Ŷ�Ӧ���ŵĶԾ���Ϣ�����˵ļ�¼������ʱ����
                +#13+'select distinct data0417.rkey,data0804.MainPhone Phone,data0015.ABBR_NAME+'' ���ţ�''+DEPT_NAME+'' �豸���룺''+FASSET_CODE+''���豸���ƣ�''+FASSET_NAME+''��Ԥ��'' '
                +#13+' +CONVERT(varchar(100),data0810.PlanMainDate, 23)+''���б�����''as msg  '
                +#13+'from data0810 '
                +#13+'join data0804 on data0810.d804_ptr=data0804.rkey '
                +#13+'join data0417 on data0804.d417_ptr=data0417.rkey '
                +#13+'join data0034 on data0417.Dept_Ptr=data0034.rkey '
                +#13+'join data0015 on data0417.warehouse_ptr=data0015.rkey  '
                +#13+'where (not data0804.MainPhone is null)and(data0804.MainPhone <> '''' ) and data0810.rkey=  '+cdsChildrkey.AsString;
                ShowMessage(CommandText); 
                //Execute;
              end;  }
              Next;
            end;

            Log_Add(data_info);
            if ApplyUpdates(0)=0 then
              begin
                if IsLog then
                begin
                  if Log_Save() then
                  begin
                    DM.ADOConnection1.CommitTrans;    //����1
                  end
                  else
                  begin
                    DM.ADOConnection1.RollbackTrans;
                  end;
                end
                else
                begin
                  DM.ADOConnection1.CommitTrans;         //����2
                  
                end;
              end
            else
              DM.ADOConnection1.RollbackTrans;
          finally
            F_IsBatchOperating :=False;
            EnableControls;
            Screen.Cursor := crDefault;
          end;

          if   IsSenderMsg=True then
          with cdsRead do
          begin
            str_SQL:='select data0005.Phone from data0417 '
              +' join data0005 on data0417.Acceptan_ptr=data0005.rkey '
              +' where data0417.rkey='+CdsMain.fieldByName('d417_ptr').AsString ;
            vPhone:=SQLResultValue(DM.cdsRead,str_SQL);
            if  vPhone<>'' then
            begin
              DM.cdsRead1.CommandText:=  'insert [172.18.9.10].[WzSmsCenter].dbo.[tblsms_outbox]'+
                        '(phonenumber,messagecontent,sendername,companyid) '+
                        'values ('+quotedstr(vPhone)+','
                        +quotedstr('�豸���룺'+cdsMain.FieldByName('FASSET_CODE').AsString+'���豸���ƣ�'+cdsMain.FieldByName('FASSET_NAME').AsString+'��Ԥ��'
                +#13+cdsMain.FieldByName('PlanMainDate').AsString+'���б�����')
                        +','+quotedstr(UserName)+',9)';
              DM.cdsRead1.Execute;
            end;
          end;
        except
          on e:Exception do
          begin
            if  DM.ADOConnection1.InTransaction then
            DM.ADOConnection1.RollbackTrans;
            Cancel;
            Refresh;
            MsgError('֪ͨʧ�ܣ�'+#13#10+e.Message);
          end;
        end;
      end  ;

    SetButtonStatus;
    dsMainStateChange(dsMain);
  end;
end;

procedure TMainPlan1_f.btn_ChangeManClick(Sender: TObject);
var
  str_SQL:string;
  i:Integer;
begin
  inherited;
  with   cdsChild  do
  if (Active)and(not IsEmpty ) then
  begin
    if messagebox(Self.Handle,'��ȷ��Ҫ���ĵ�ǰ������Ŀ��Ĭ�ϱ�������','ѯ��',MB_yesno+MB_iconquestion)=idNo then
      Exit ;

    if State in [dsEdit,dsInsert] then
      Post;
    
    if   dghChild.SelectedRows.Count   >   1   then  //����û�ѡ�����������1�������С�
      begin
        try
          try
            F_IsBatchOperating :=True;
            DisableControls;
            Screen.Cursor := crHourGlass;
            DM.ADOConnection1.BeginTrans;
            for   i:=   dghChild.SelectedRows.Count   -   1   downto   0   do
            begin
              GotoBookmark(pointer(dghChild.SelectedRows.Items[i]));
                str_SQL:='declare @rkey int ,@defauMan Nvarchar(100) '
                +' set @rkey='+FieldByName('D804_ptr').AsString+' set @defauMan='+QuotedStr(FieldByName('MaintMan').AsString)
                +' if exists(select * from data0804 where rkey=@rkey and defauMan<>@defauMan)'
                +' update data0804 set defauMan=@defauMan where rkey=@rkey';
              cdsRead.CommandText:=str_SQL;
              cdsRead.Execute;
            end;
            
            if ApplyUpdates(0)=0 then
              DM.ADOConnection1.CommitTrans
            else
              DM.ADOConnection1.RollbackTrans;
          finally
            F_IsBatchOperating :=False;
            EnableControls;
            Screen.Cursor := crDefault;
          end;
        except
          on e:Exception do
          begin
            if DM.ADOConnection1.InTransaction then
              DM.ADOConnection1.RollbackTrans;
            Cancel;
            Refresh;
            MsgError('֪ͨʧ�ܣ�'+#13#10+e.Message);
          end;
        end;
      end
    else
      begin
        try
          try
            Screen.Cursor := crHourGlass;
            DM.ADOConnection1.BeginTrans;
              str_SQL:='declare @rkey int ,@defauMan Nvarchar(100) '
              +' set @rkey='+FieldByName('D804_ptr').AsString+' set @defauMan='+QuotedStr(FieldByName('MaintMan').AsString)
              +' if exists(select * from data0804 where rkey=@rkey and defauMan<>@defauMan)'
              +' update data0804 set defauMan=@defauMan where rkey=@rkey';
            cdsRead.CommandText:=str_SQL;
            cdsRead.Execute;

            if ApplyUpdates(0)=0 then
              DM.ADOConnection1.CommitTrans
            else
              DM.ADOConnection1.RollbackTrans;
          finally
            Screen.Cursor := crDefault;
          end;
        except
          on e:Exception do
          begin
            if DM.ADOConnection1.InTransaction then
              DM.ADOConnection1.RollbackTrans;
            Cancel;
            Refresh;
            MsgError('֪ͨʧ�ܣ�'+#13#10+e.Message);
          end;
        end;
      end;
    SetButtonStatus;
    dsMainStateChange(nil);
  end;
end;

procedure TMainPlan1_f.Edit1Change(Sender: TObject);
begin
  inherited;
  cdsMain.Filtered:=False;
  cdsMain.Filtered:=True;
end;

procedure TMainPlan1_f.cdsMainFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  inherited;
  if Trim(Filter_Edit.Text) <>'' then
  Accept:=AnsiContainsText(DataSet.FieldByName(FilterFieldName).AsString,Filter_Edit.Text ) ;
end;

procedure TMainPlan1_f.SetFilterComponent(Column: TColumnEh);
begin
  if Column.Field.DataType in[ftString,ftWideString] then
  begin
    Filter_Label.Caption:=Column.Field.DisplayLabel;
    Filter_Label.Left:=5;
    Filter_Edit.Left:=10+ Filter_Label.Width;
    if UpperCase(Column.Field.FieldName)<>UpperCase(FilterFieldName) then
    begin
     Filter_Edit.Text:='';
     FilterFieldName:= Column.Field.FieldName;
    end;
  end;
end;

procedure TMainPlan1_f.bt_FindClick(Sender: TObject);
begin
  inherited;
  cdsMain.Close;
  cdsMain.CommandText:=cdsMain.F_SQLSelectFrom +#13
    +'where Cast(convert(varchar(10),[PlanMainDate],120)as smalldatetime) BETWEEN ' +#13
    +QuotedStr(DateToStr(DateTimePicker3.Date))+' and '+QuotedStr(DateToStr(DateTimePicker4.Date))+#13
    +cdsMain.F_SQLOrderBy  ;
  cdsMain.Open;
end;

procedure TMainPlan1_f.Filter_EditChange(Sender: TObject);
begin
  inherited;
  with cdsMain do
  if trim(Filter_Edit.Text) <> '' then
  begin
    Filtered := False;
    Filtered := true;
  end
  else
    Filtered := False;
end;

procedure TMainPlan1_f.DghMainTitleClick(Column: TColumnEh);
begin
  inherited;
  SetFilterComponent(Column);
end;

procedure TMainPlan1_f.FormShow(Sender: TObject);
begin
  inherited;
  DghMain.ReadOnly:=True;
  Data_Info[0].L_IsWrite:=False ;  //�ϱ����Ҫд����־��Ĭ������Ҫд���
  Data_Info[1].L_LogFields:= VarArrayOf(['PlanMainDate','beginMainDate','EndMainDate',
  'MaintMan','AcceCode','Acceptan','ttype','AcceEval','MainExecStat']);
end;

procedure TMainPlan1_f.btn_StartMainClick(Sender: TObject);
var
  i:Integer;
  Curr_date1:TDateTime;
begin
  inherited;
  with   cdsChild  do
  if (Active)and(not IsEmpty ) then
  begin         
    if messagebox(Self.Handle,'��ȷ��Ҫ��ʼ������','ѯ��',MB_yesno+MB_iconquestion)=idNo then
      Exit ;
    if State in [dsEdit,dsInsert] then
      Post;
    Curr_date1:=GetDataBaseDate(cdsRead,1) ;
    if   dghChild.SelectedRows.Count   >   1   then  //����û�ѡ�����������1�������С�
      begin
        try
          try
            F_IsBatchOperating :=True;
            DisableControls;
            Screen.Cursor := crHourGlass;
            DM.ADOConnection1.BeginTrans;
            for   i:=   dghChild.SelectedRows.Count   -   1   downto   0   do
            begin
              GotoBookmark(pointer(dghChild.SelectedRows.Items[i]));
              Edit;
              FieldByName('Status').Value:=3;                  //��״̬��Ϊ����
              if (FieldByName('BeginMainDate').IsNull)then
                FieldByName('BeginMainDate').Value:= Curr_date1;
              Post;
            end;

            if (IsLog)then
            if Log_Add(Data_Info)=False  then
              Exit;
            if ApplyUpdates(0)=0 then
              begin
                if IsLog then
                begin
                  if Log_Save() then
                  begin
                    DM.ADOConnection1.CommitTrans;    //����1
                  end
                  else
                  begin
                    DM.ADOConnection1.RollbackTrans;
                  end;
                end
                else
                begin
                  DM.ADOConnection1.CommitTrans;         //����2
                end;
              end
            else
              DM.ADOConnection1.RollbackTrans;
          finally
            F_IsBatchOperating :=False;
            EnableControls;
            Screen.Cursor := crDefault;
          end;
        except
          on e:Exception do
          begin
            DM.ADOConnection1.RollbackTrans;
            Cancel;
            Refresh;
            MsgError('֪ͨʧ�ܣ�'+#13#10+e.Message);
          end;
        end;
      end
    else
      begin
        try
          try
            Screen.Cursor := crHourGlass;
            DM.ADOConnection1.BeginTrans;
            Edit;
            FieldByName('Status').Value:=3;                  //��״̬��Ϊ����֪ͨ ��
            if (FieldByName('BeginMainDate').IsNull)then
                FieldByName('BeginMainDate').Value:= GetDataBaseDate(cdsRead,1);
            Post;

            if (IsLog)then
            if Log_Add(Data_Info)=False  then
              Exit;
            if ApplyUpdates(0)=0 then
              begin
                if IsLog then
                begin
                  if Log_Save() then
                  begin
                    DM.ADOConnection1.CommitTrans;    //����1
                  end
                  else
                  begin
                    DM.ADOConnection1.RollbackTrans;
                  end;
                end
                else
                begin
                  DM.ADOConnection1.CommitTrans;         //����2
                end;
              end
            else
              DM.ADOConnection1.RollbackTrans;
          finally
            Screen.Cursor := crDefault;
          end;
        except
          on e:Exception do
          begin
            if DM.ADOConnection1.InTransaction then
              DM.ADOConnection1.RollbackTrans;
            Cancel;
            Refresh;
            MsgError('֪ͨʧ�ܣ�'+#13#10+e.Message);
          end;
        end;
      end;
    SetButtonStatus;
    dsMainStateChange(nil);
  end;
end;

procedure TMainPlan1_f.Button9Click(Sender: TObject);
var
  strOut:string;
begin
  inherited;
  if InputDlg(Self.Handle,'��ͣ','������ͣԭ��',strOut) then
  try
    DM.ADOConnection1.BeginTrans;
    with cdsChild do
    begin
      First;
      while not Eof do
      begin
        Edit;
        FieldByName('RKEY832').Value:=6;
        FieldByName('Remark').Value  := strOut;
        Post;
      end ;

      if ApplyUpdates(0)=0 then
      begin
        DM.ADOConnection1.CommitTrans;
      end
      else
      begin
        DM.ADOConnection1.RollbackTrans;
      end;

      dsMainStateChange(nil);
      SetButtonStatus;
    end;
  except
    if  DM.ADOConnection1.InTransaction then
    DM.ADOConnection1.RollbackTrans;
    
  end;
end;

procedure TMainPlan1_f.cdsChildCalcFields(DataSet: TDataSet);
begin
  inherited;
  with DataSet do
  if (FieldByName('EndMainDate').IsNull=False)and (FieldByName('BeginMainDate').IsNull=False)  then
  begin                            
    FieldByName('MainTime').Value:=
    MinutesDiff(FieldByName('EndMainDate').Value,FieldByName('BeginMainDate').Value);
  end;
end;

procedure TMainPlan1_f.MainGrid_PopupMenuPopup(Sender: TObject);
begin
  inherited;
  if Islog and (ActiveGridEH=dghChild) then
    N_SeeLog.Visible:=True
  else
    N_SeeLog.Visible:=False ;
end;

procedure TMainPlan1_f.cdsChildStatusChange(Sender: TField);
begin
  inherited;
  with MainPlan_f.cds832 do
  begin
    if Active=False then
    Open;

    if Filtered then
    Filtered:=False;

    with Sender.DataSet do
    if not(State in [dsEdit,dsInsert]) then
    Edit;

    if Sender.IsNull then
    begin
      cdsMain.FieldByName('MainExecStat').Value:=null;
    end
    else
    begin
      if Locate('rkey',Sender.Value,[loCaseInsensitive]) then
        begin
        cdsChildMainExecStat.Value := FieldByName('MainExecStat').Value ;
        end
      else
        begin
        cdsMain.FieldByName('MainExecStat').Value:=null;
        end;
    end;
  end;
end;

end.
