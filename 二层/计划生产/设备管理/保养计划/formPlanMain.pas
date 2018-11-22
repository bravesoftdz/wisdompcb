unit formPlanMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, MC, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, dxSkinsCore, dxSkinsDefaultPainters,
  dxSkinsdxStatusBarPainter, dxSkinscxPCPainter, dxSkinsdxBarPainter,
  ppEndUsr, ppBands, ppPrnabl, ppClass, ppCtrls, ppCache, ppProd, ppReport,
  ppComm, ppRelatv, ppDB, ppDBPipe, Menus, DBClient, cds, DB, Provider,
  ADODB, dxBar, cxClasses, ImgList, ActnList, Grids, DBGridEh, ToolWin,
  ComCtrls, cxPC, StdCtrls, RzPanel, ExtCtrls, dxStatusBar, Buttons,StrUtils,
  Mask, DBCtrls,DateUtils;

type
  TfrmPlanMain = class(TMC_f)
    cdsMainFASSET_NAME: TStringField;
    cdsMainMainExecStat: TStringField;
    cdsMainUser_Full_Name: TStringField;
    cdsMainImpact: TStringField;
    cdsMainDEPT_NAME: TStringField;
    cdsMainABBR_NAME: TStringField;
    cdsMainequipment_grade: TStringField;
    cdsMainLOCATION: TStringField;
    cdsMainrkey: TAutoIncField;
    cdsMainPlanMainDate: TDateTimeField;
    cdsMainDeviNumb: TStringField;
    cdsMainDeviType: TStringField;
    cdsMainMainCycl: TStringField;
    cdsMainRKEY832: TIntegerField;
    cdsMainStarMainTime: TDateTimeField;
    cdsMainActuCompTime: TDateTimeField;
    cdsMainMainImpl: TWideStringField;
    cdsMainRemarks: TStringField;
    cdsMainTimeCons: TBCDField;
    cdsMainMainAcce_UserPtr: TIntegerField;
    cdsMainStdTimeCons: TBCDField;
    dtMainFASSET_NAME: TStringField;
    dtMainMainExecStat: TStringField;
    dtMainUser_Full_Name: TStringField;
    dtMainImpact: TStringField;
    dtMainDEPT_NAME: TStringField;
    dtMainABBR_NAME: TStringField;
    dtMainequipment_grade: TStringField;
    dtMainLOCATION: TStringField;
    dtMainrkey: TAutoIncField;
    dtMainPlanMainDate: TDateTimeField;
    dtMainDeviNumb: TStringField;
    dtMainDeviType: TStringField;
    dtMainMainCycl: TStringField;
    dtMainRKEY832: TIntegerField;
    dtMainStarMainTime: TDateTimeField;
    dtMainActuCompTime: TDateTimeField;
    dtMainMainImpl: TWideStringField;
    dtMainRemarks: TStringField;
    dtMainTimeCons: TBCDField;
    dtMainMainAcce_UserPtr: TIntegerField;
    dtMainStdTimeCons: TBCDField;
    GroupBox2: TGroupBox;
    ComboBox1: TComboBox;
    RadioGroup2: TRadioGroup;
    GroupBox1: TGroupBox;
    SpeedButton1: TSpeedButton;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    Label1: TLabel;
    edit1: TEdit;
    cds0015: TClientDataSet;
    cds0015RKEY: TIntegerField;
    cds0015WAREHOUSE_CODE: TStringField;
    cds0015ABBR_NAME: TStringField;
    PopupMenuInButton4: TPopupMenu;
    N_Acceptance: TMenuItem;
    N_OtherAcceptance: TMenuItem;
    Button1: TButton;
    Button7: TButton;
    cmdUpdate: TADOCommand;
    cds832: TClientDataSet;
    cds832RKEY: TIntegerField;
    cds832MainExecStat: TStringField;
    cds0073: TClientDataSet;
    cds0073rkey: TIntegerField;
    cds0073User_Full_Name: TStringField;
    cdsChildrkey: TAutoIncField;
    cdsChildWork_ptr: TIntegerField;
    cdsChildWorkDate: TDateTimeField;
    cdsChildBeginTime: TDateTimeField;
    cdsChildEndTime: TDateTimeField;
    cdsChildTimeRest: TBCDField;
    cdsChildEmpl_ptr: TIntegerField;
    cdsChildStatus: TIntegerField;
    cdsChildWorkTime: TBCDField;
    cdsChildRemark: TStringField;
    cdsChildEMPL_CODE: TStringField;
    cdsChildEMPLOYEE_NAME: TStringField;
    cdsChildMainexecStat: TStringField;
    dtChildrkey: TAutoIncField;
    dtChildWork_ptr: TIntegerField;
    dtChildWorkDate: TDateTimeField;
    dtChildBeginTime: TDateTimeField;
    dtChildEndTime: TDateTimeField;
    dtChildTimeRest: TBCDField;
    dtChildEmpl_ptr: TIntegerField;
    dtChildStatus: TIntegerField;
    dtChildWorkTime: TBCDField;
    dtChildRemark: TStringField;
    dtChildEMPL_CODE: TStringField;
    dtChildEMPLOYEE_NAME: TStringField;
    dtChildMainexecStat: TStringField;
    btn_New: TButton;
    cds0005: TClientDataSet;
    cds0005RKEY: TAutoIncField;
    cds0005EMPL_CODE: TStringField;
    cds0005EMPLOYEE_NAME: TStringField;
    cmdUpdate1: TADOCommand;
    btn_Delete: TButton;
    PopupMenuInButton3: TPopupMenu;
    N_StartMain: TMenuItem;
    N_OtherStartMain: TMenuItem;
    Button11: TButton;
    Button12: TButton;
    cds0073EMPLOYEE_PTR: TIntegerField;
    cds0073USER_LOGIN_NAME: TStringField;
    Label2: TLabel;
    DBEdit1: TDBEdit;
    Label3: TLabel;
    DBEdit2: TDBEdit;
    Label4: TLabel;
    DBEdit3: TDBEdit;
    Label5: TLabel;
    DBEdit4: TDBEdit;
    Label6: TLabel;
    DBEdit5: TDBEdit;
    Label7: TLabel;
    DBEdit6: TDBEdit;
    Label8: TLabel;
    DBEdit7: TDBEdit;
    Label9: TLabel;
    DBEdit8: TDBEdit;
    Label10: TLabel;
    DBEdit9: TDBEdit;
    Label11: TLabel;
    DBEdit10: TDBEdit;
    Label12: TLabel;
    DBEdit11: TDBEdit;
    Label13: TLabel;
    DBEdit12: TDBEdit;
    Label14: TLabel;
    DBEdit13: TDBEdit;
    Label15: TLabel;
    DBEdit14: TDBEdit;
    Label16: TLabel;
    edt_StdTimeCons: TDBEdit;
    Label17: TLabel;
    edt_MainImpl: TDBEdit;
    Label18: TLabel;
    DBEdit17: TDBEdit;
    Label19: TLabel;
    mo_Remarks: TDBMemo;
    Button8: TButton;
    PopupMenuInButton10: TPopupMenu;
    N_EndPause: TMenuItem;
    N_OtherEndPause: TMenuItem;
    Button3: TButton;
    Button9: TButton;
    Button10: TButton;
    Button2: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    cdsMainAccomplish: TFloatField;
    Label20: TLabel;
    DBEdit15: TDBEdit;
    Button13: TButton;
    Button14: TButton;
    cds0417: TClientDataSet;
    cds0417FASSET_CODE: TStringField;
    cds0417FASSET_NAME: TStringField;
    cds0417FASSET_DESC: TStringField;
    Button15: TButton;
    cds0417rkey: TIntegerField;
    cds0417DEPT_CODE: TStringField;
    cds0417DEPT_NAME: TStringField;
    dtMaind40_Location: TStringField;
    cdsMaind40_Location: TStringField;
    Label21: TLabel;
    DBEdit16: TDBEdit;
    cds840: TClientDataSet;
    cds840rkey: TIntegerField;
    cds840Location: TStringField;
    dtChildDayShift: TWordField;
    cdsChildDayShift: TSmallintField;
    cds0034: TClientDataSet;
    cds0034RKEY: TIntegerField;
    cds0034DEPT_CODE: TStringField;
    cds0034DEPT_NAME: TStringField;
    QryResultTime: TADOQuery;
    procedure FormCreate(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure RadioGroup2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure edit1Change(Sender: TObject);
    procedure cdsMainFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure DghMainTitleClick(Column: TColumnEh);
    procedure DghMainGetCellParams(Sender: TObject; Column: TColumnEh;
      AFont: TFont; var Background: TColor; State: TGridDrawState);
    procedure N_OtherAcceptanceClick(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button4MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Button1Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure cdsMainRKEY832Change(Sender: TField);
    procedure N_AcceptanceClick(Sender: TObject);
    procedure cdsMainMainAcce_UserPtrChange(Sender: TField);
    procedure btn_NewClick(Sender: TObject);
    procedure cdsMainAfterInsert(DataSet: TDataSet);
    procedure Button11Click(Sender: TObject);
    procedure cdsChildStatusChange(Sender: TField);
    procedure btn_DeleteClick(Sender: TObject);
    procedure N_StartMainClick(Sender: TObject);
    procedure Button3MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure N_OtherStartMainClick(Sender: TObject);
    procedure cdsChildEndTimeChange(Sender: TField);
    procedure cdsChildTimeRestChange(Sender: TField);
    procedure Button12Click(Sender: TObject);
    procedure dghChildKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button9Click(Sender: TObject);
    procedure Button10MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure N_EndPauseClick(Sender: TObject);
    procedure N_OtherEndPauseClick(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure cdsMainCalcFields(DataSet: TDataSet);
    procedure cdsMainAccomplishGetText(Sender: TField; var Text: String;
      DisplayText: Boolean);
    procedure DghMainKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button13Click(Sender: TObject);
    procedure Button14Click(Sender: TObject);
    procedure Button15Click(Sender: TObject);
    procedure cdsMainAfterOpen(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
  private
    FilterFieldName:string;
    strStatusValue:string;
    Function  Newline(str:String;AddSpaces:string='') :string;
    procedure Acceptanceby(UserKey:string);
    procedure StartMaintenance(vEmpl_ptr:Integer);
    procedure Exec_EndPauseClick(vEmployeeRkey:string);
    { Private declarations }
  public
    strPlanMainDate:string;
    function EmployeeStatusCheck(vEmpl_ptr:string;out vNUMBER:string):Boolean;
    function SaveData():Boolean; override;
    function DeleteSaveData():Boolean; override;
    procedure SetToolbarButtonStatus(Flag: Boolean);override;
    function SaveBeforeCheck():Boolean; override;
    procedure SetButtonStatus;override;
    procedure SetMultiSelectButtonStatus;override;
    procedure RightsSetDataSetReadOnly; override;
    { Public declarations }
  end;

var
  frmPlanMain: TfrmPlanMain;
  vSUPLFEDSHIP,vSUPLFEDMAT,vSUPLFEDMISC:string;    //���Ͷ�����
  btnStatu7,btnStatu3,btnStatu5,btnStatu2,btnStatu4,btnStatu8,N_OtherAcceptanceStatu:Boolean;
  DeleteStatus,EditStatus:Boolean;

implementation

uses DM_f, PublicFile,formResetUsername, formGetUserRights,
   formMultiSelectedItem, formInputDlg, formPlanMain02, formPlanMain3,
   formPlanMain04, formPlanMain05, form_msg, formPlanMain01;
 // formPlanMain01,

{$R *.dfm}

procedure TfrmPlanMain.RightsSetDataSetReadOnly;
begin
  if not(StrToInt(vprev) in [2,3,4]) then    //
  begin
    cdsMain  .ReadOnly:=True;
    cdsChild .ReadOnly:=True;
  end
  else
  begin
    cdsMain  .ReadOnly:=False;
    cdsChild .ReadOnly:=False;
  end  ;
  if not(StrToInt(vprev) in [2,3,4]) then    //
  begin
    DghMain  .ReadOnly:=True;
    dghChild .ReadOnly:=True;
  end
  else
  begin
    DghMain  .ReadOnly:=False;
    dghChild .ReadOnly:=False;
  end ;
end;

procedure TfrmPlanMain.SetMultiSelectButtonStatus;
  procedure ButtonStatus;
  begin
    with cdsMain do
    if FieldByName('RKEY832').AsInteger=1 then    //��ִ��
    begin

    end
    else
    if FieldByName('RKEY832').AsInteger =5 then    //��֪ͨ
    begin
      btnStatu7    :=False ;//֪ͨ����
    end
    else
    if FieldByName('RKEY832').AsInteger=3 then     //ִ����
    begin
      btnStatu7    :=False ;//֪ͨ����
    end
    else
    if FieldByName('RKEY832').AsInteger =6 then    //����ͣ
    begin
      btnStatu7    :=False ;//֪ͨ����
    end
    else
    if FieldByName('RKEY832').AsInteger =4 then    // ������
    begin
      btnStatu7    :=False ;//֪ͨ����
    end
    else
    if FieldByName('RKEY832').AsInteger=2 then    //������
    begin
      btnStatu7    :=False ;//֪ͨ����
    end     ;
  end;
var
  i:Integer;
  BM:Pointer;
begin
  btnStatu7:=true;
  with  DghMain do
  begin
    if SelectedRows.Count>1 then
    begin
      try
        Screen.Cursor := crHourGlass;
        BM:=DtMain.GetBookmark;
        cdsMain.DisableControls ;
        for   i:= 0 to SelectedRows.Count-1 do
        begin
          cdsMain.GotoBookmark(pointer(SelectedRows.Items[i]));
          ButtonStatus;      //���ù��̣����õ�ǰ��ť��״ֵ̬��
        end;
        EditStatus:=False;          //����Ƕ���ѡ���ʱ�򣬱༭��ť���ɲ�����
      finally
        cdsMain.GotoBookmark(BM);
        cdsMain.FreeBookmark(BM);
        cdsMain.EnableControls;
        Screen.Cursor := crDefault;
      end;
    end
    else
      ButtonStatus;
  end;
  Button7.Enabled:=  btnStatu7 and (StrToInt(vprev)in [2,3,4]);//֪ͨ����
end;

function TfrmPlanMain.SaveData():Boolean;
var
  f_Staff_Sum_house :real;
begin
  Result:=True;
  try
    Screen.Cursor := crHourGlass;
    try
      DM.ADOConnection1.BeginTrans;
      with cdsMain do
      begin
        if State in [dsEdit,dsInsert] then
          Post;

        if UpdateStatus =usModified then    {���data0847�����Ӧ��¼��������һ�м�¼����������޸�,���ڼ�¼���µı�׼����ʱ��}
        if FieldByName('StdTimeCons').IsNull=False then
        if VarToStr(FieldByName('StdTimeCons').NewValue)<>VarToStr(FieldByName('StdTimeCons').OldValue) then
        begin
          with cdsRead do
          begin
            Close;
            CommandText:= 'if not exists(select  * from data0847 join data0417 on [D417_ptr]=data0417.rkey '
                       +#13+'                     where FASSET_CODE ='+QuotedStr(cdsMain.FieldByName('DeviNumb').AsString)
                       +#13+' and [MainCycl]='+QuotedStr(cdsMain.FieldByName('MainCycl').AsString)+') '
                       +#13+'    insert into data0847([D417_ptr],[MainCycl],[StdTimeCons]) '
                       +#13+'    select rkey ,'+QuotedStr(cdsMain.FieldByName('MainCycl').AsString)
                       +#13+','+cdsMain.FieldByName('StdTimeCons').AsString+' from  data0417 where  FASSET_CODE ='
                               +#13+QuotedStr(cdsMain.FieldByName('DeviNumb').AsString)
                       +#13+'else '
                       +#13+'    update data0847 set [StdTimeCons]= '+cdsMain.FieldByName('StdTimeCons').AsString
                       +#13+'    from data0847 join data0417 on [D417_ptr]=data0417.rkey '
                       +#13+'    where FASSET_CODE ='+QuotedStr(cdsMain.FieldByName('DeviNumb').AsString)
                       +#13+' and [MainCycl]='+QuotedStr(cdsMain.FieldByName('MainCycl').AsString) ;
            Execute;
          end;
        end;
        //�ۼ��ӱ�����й�Ա�Ĺ���ʱ�䣬��д������
        if cdsMainRKEY832.AsInteger in [ 4,2] then//������  ,������
        begin
          cdsRead.Close;               //�رպ������ݡ�
          cdsRead.Data:=(cdsChild.Data);
          with cdsRead do
          begin
            First;
            f_Staff_Sum_house:=0;
            while not Eof do
            begin
              if FieldByName('WorkTime').Value>0  then    //����ʱ��
              f_Staff_Sum_house:= f_Staff_Sum_house+ FieldByName('WorkTime').Value;
              Next;
            end;
            cdsMain.Edit;
            cdsMainTimeCons.Value:=  f_Staff_Sum_house ;
          end;        
          cdsMain.Post;
        end;
        
        if ApplyUpdates(0)=0 then    //=0��������ɹ�
        begin
          with cdsChild do
          begin
            if State in [dsEdit,dsInsert] then
              Post;
            if ApplyUpdates(0)=0 then     //����0������ʧ��
            begin
              DM.ADOConnection1.CommitTrans;
            end
            else
            begin
              DM.ADOConnection1.RollbackTrans;
              Result:=False;
            end;
          end;
        end
        else
        begin
          DM.ADOConnection1.RollbackTrans;
          Result:=False;
        end
      end;
    except
      on e:Exception do
      begin
        if DM.ADOConnection1.InTransaction then
        DM.ADOConnection1.RollbackTrans;
        MsgError('����ʧ�ܣ�ԭ���ǣ�'+e.Message);
      end;
    end;
    dsMainStateChange(nil);
  finally    
    Screen.Cursor := crDefault;
  end;
end;

function TfrmPlanMain.DeleteSaveData():Boolean;
  function AllDelete():Boolean;
  begin
    Result:=True;
    try
      Screen.Cursor := crHourGlass;
      try
        DM.ADOConnection1.BeginTrans;
        try
          cdsMain.F_IsBatchOperating :=True;
          cdsChild.F_IsBatchOperating:=True;
          while cdsChild.IsEmpty=false do
          cdsChild.Delete;

          cdsMain.Delete;
          if cdsChild.ApplyUpdates(0)=0 then    //=0��������ɹ�
          begin
            with cdsMain do
            begin
              if ChangeCount >0 then
              if ApplyUpdates(0)>0 then     //����0������ʧ��
              begin
                DM.ADOConnection1.RollbackTrans;
                Result:=False;
              end;
            end;
          end
          else
            begin
            DM.ADOConnection1.RollbackTrans;
            Result:=False;
            end;

          DM.ADOConnection1.CommitTrans;
          ChildDataSetOpen;
        finally
          cdsChild.F_IsBatchOperating:=False;
          cdsMain.F_IsBatchOperating:=False;
        end;
      except
        if  DM.ADOConnection1.InTransaction then
        DM.ADOConnection1.RollbackTrans;
        cdsMain.CancelUpdates;
        cdsChild.CancelUpdates;
        ChildDataSetOpen;
      end;
    finally
      Screen.Cursor := crDefault;
    end;
  end;
begin
  Result:=True;
  with ActiveGridEH.DataSource.DataSet as Tcds  do
  if Active and (not IsEmpty) then
  begin
    if (ActiveGridEH= dghchild)then    //������ӱ�� ,ȡ��ɾ���Ĺ���
    begin

    end
    else
    if (ActiveGridEH= dghMain)then     //��������������
    if DeleteBeforeCheck then
    begin
      if messagebox(Self.Handle,'��ȷ��Ҫɾ����ǰѡ�����ŵ�����?ɾ���󽫲��ָܻ���','ѯ��',MB_YESNO+MB_iconquestion)=idYes then
      if AllDelete =False then
        Result:=False;
    end;
  end;
  dsMainStateChange(nil);
end;

function TfrmPlanMain.SaveBeforeCheck():Boolean  ;
var
  strMsg:string;
  I_Row :Integer;
begin
  Result:=True;
  if cdsChild.State in [dsEdit ,dsInsert] then
  cdsChild.Post;

  begin
    DM.cdsRead.Data:=cdsChild.Data;
    DM.cdsRead1.Data:=cdsChild.Data;
    with DM.cdsRead do
    try
      DisableControls ;
      First;
      for I_Row:=0 to RecordCount-1 do
      begin
        if FieldByName('Status').Value=3 then
        begin
          DM.cdsRead1.First;
          while not DM.cdsRead1.Eof do
          begin
            if FieldByName('rkey').AsInteger    <> DM.cdsRead1.FieldByName('rkey').AsInteger then      //�������ͬһ�м�¼��
            if FieldByName('Empl_ptr').AsInteger = DM.cdsRead1.FieldByName('Empl_ptr').AsInteger then  //������Ƽ�¼�Ĺ�Աָ����ڵ�ǰ�еĹ�Աָ��
            if FieldByName('BeginTime').Value     <= DM.cdsRead1.FieldByName('EndTime').Value then     //������Ƽ�¼�Ľ���ʱ����ڻ���ڵ�ǰ�еĿ�ʼʱ��
            begin            
              strMsg:=strMsg+'��ϸ���'+IntToStr(I_Row+1)+'�У��ֶΣ���'
                   +cdsChild.FieldByName('BeginTime').DisplayLabel+'����ֵ����С�ڻ�����ϴεĽ���ʱ�䣡����'+#13;
            end;    
            DM.cdsRead1.Next;
          end;
        end;
        Next;
      end;
    finally
      EnableControls;
      Close;
    end;
  end;

  if strMsg<>'' then
  begin
    MsgError(Copy(strMsg,0,Length(strMsg)-1));
    Result:=False;
  end;
end;

function TfrmPlanMain.EmployeeStatusCheck(vEmpl_ptr:string;out vNUMBER:string):Boolean;
begin
  Result:=False;
  with cdsRead do
  begin
    Close;
    CommandText:='select NUMBER from data0842 join data0567 on data0842.work_ptr=data0567.rkey where data0842.empl_ptr='
      +vEmpl_ptr+' and data0842.[status]=3';
    Open;
    if IsEmpty=False then         //����ù�Ա����δ��ɵļ�¼������ֵΪ��
    begin
      MsgError('����ά�޵�����'+FieldByName('NUMBER').AsString+'������ִ���е�״̬������') ;
      Result:=True;
    end;

    Close;
    CommandText:='select CONVERT(varchar(100),PlanMainDate, 23)+'' ''+DeviNumb+'' ''+MainCycl as NUMBER'
         +' from data0831 join data0848 on data0848.work_ptr=data0831.rkey '
         +' where data0848.empl_ptr='+vEmpl_ptr+' and data0848.[status]=3';
    Open;
    if IsEmpty=False then         //����ù�Ա����δ��ɵļ�¼������ֵΪ��
    begin
      MsgError('���ڱ���������'+FieldByName('NUMBER').AsString+'������ִ���е�״̬������') ;
      Result:=True;
    end;
  end;
end;

procedure TfrmPlanMain.FormCreate(Sender: TObject);
begin
 if not App_init_2(dm.ADOConnection1 ) then
  begin
    ShowMessage('��������ʧ�ܣ�����ϵϵͳ����Ա��');
    application.Terminate;
    exit;
  end;
  Caption:=application.Title ; {}

 { dm.ADOConnection1.Close;
  dm.ADOConnection1.ConnectionString:='Provider=SQLOLEDB.1;Password=wisdomtopcb1077;Persist Security Info=True;User ID=wzsa;Initial Catalog=sj_v20_live;Data Source=172.16.68.8';
  dm.ADOConnection1.Open;
  UserRKEY := 2522;
  vprev:='4';    }

  inherited;
  Curr_Date:=GetDataBaseDate(cdsread,2);
  SetEmployeeInfo(dtRead,dxStatusBar1);
  with  cds0015 do
  begin
    Open;
    First;
    while not Eof do
    begin
      ComboBox1.Items.Add(Trim(FieldByName('ABBR_NAME').AsString));
      Next;
    end;
    ComboBox1.Items.Add('ȫ��');
    ComboBox1.ItemIndex:= ComboBox1.Items.Count-1;
  end;
  CheckBox1Click(nil);
  RadioGroup2Click(nil) ;

  if StrToInt(vprev)in[3,4] then
    Button1.Enabled:=True
  else
    Button1.Enabled:=False;

  FilterFieldName:='DeviNumb';
  FindDisplayFields:=VarArrayOf(['PlanMainDate','DeviNumb','DEPT_NAME','FASSET_NAME',
      'ABBR_NAME','equipment_grade','LOCATION','DeviType','MainCycl','MainExecStat','d40_Location','StarMainTime',
     'ActuCompTime','TimeCons','StdTimeCons','Accomplish','MainImpl','User_Full_Name','Remarks' ]);
  FindFieldsName      :=VarArrayOf(['d40_Location']);
  FindQueryFieldsName :=VarArrayOf(['d40.Location']);
  Find_Def_FieldName  :=VarArrayOf(['PlanMainDate']);
  Find_Def_Oper       :=VarArrayOf(['>']);
  Find_Def_FieldValue :=VarArrayOf([DateToStr(GetDataBaseDate(cdsRead,2)-10)]);
  Find_Def_Field2Value :=VarArrayOf(['']);
end;

procedure TfrmPlanMain.CheckBox1Click(Sender: TObject);
begin
  inherited;
  strStatusValue:='';
  if CheckBox4.Checked and  CheckBox1.Checked and CheckBox2.Checked and CheckBox3.Checked and CheckBox5.Checked and CheckBox6.Checked then
    Exit;                               //�����¼��6��״̬��Ҫ��ѯ�Ļ����˳�����Ϊ�ò�ѯ������������Ҫ���ڣ���ѯ�ٶȻ���졣
    //1��ִ��
  if CheckBox1.Checked then
    strStatusValue:='1,';
     //3ִ����
  if CheckBox2.Checked then
    strStatusValue:=strStatusValue+'3,';
      //4������
  if CheckBox3.Checked then
    strStatusValue:=strStatusValue+'4,';
      //2������
  if CheckBox4.Checked then
    strStatusValue:=strStatusValue+'2,';
    //5��֪ͨ
  if CheckBox5.Checked then
    strStatusValue:=strStatusValue+'5,';
    //6����ͣ
  if CheckBox6.Checked then
    strStatusValue:=strStatusValue+'6,';
  //1��ִ��3ִ����4������ 2������5��֪ͨ6����ͣ
  if  strStatusValue<>'' then
  begin                            //    ȥ�������һ��","
    strStatusValue:=' and RKEY832 in ('+copy(strStatusValue,0,Length(strStatusValue)-1)+')';
  end;
end;

procedure TfrmPlanMain.RadioGroup2Click(Sender: TObject);
begin
  inherited;
  if strPlanMainDate=''then       {������û��ڲ�ѯ���ڵ�ȷ����strPlanMainDate������ֵ��
                                ���Խ�ִ�в�ѯ���ڷ��ص�SQL������ִ��RadioGroup2Ĭ�ϵĲ�ѯ������}
  with RadioGroup2   do
  begin
    if ItemIndex=0 then
    begin
        strPlanMainDate:=' PlanMainDate>GetDate()-10 and PlanMainDate<='+QuotedStr(DateTostr(Date));
    end
    else
    if ItemIndex=1 then
    begin
        strPlanMainDate:=' PlanMainDate>GetDate()-10 and PlanMainDate='+QuotedStr(DateTostr(Date+1));
    end
    else
    if ItemIndex=2 then
    begin
        strPlanMainDate:=' PlanMainDate>GetDate()-10 and PlanMainDate='+QuotedStr(DateTostr(Date+2));
    end
    else
    if ItemIndex=3 then
    begin
        strPlanMainDate:=' PlanMainDate>GetDate()-10 ';
    end ;
  end;

  begin
    if  cds0015.Active=False then
    cds0015.Open;
    if cds0015.Filtered then
    cds0015.Filtered:=False;
    cds0015.First;
    if ComboBox1.ItemIndex <> cds0015.RecordCount   then//���COMBOBX1ѡ��Ĳ������(ȫ��)һ����
    begin
      cds0015.MoveBy(ComboBox1.ItemIndex);
      if strPlanMainDate<>'' then
        strPlanMainDate:=strPlanMainDate+' and DeviNumb in (select FASSET_CODE from data0417 where warehouse_ptr='+cds0015RKEY.AsString+')'
      else
        strPlanMainDate:= ' DeviNumb in (select FASSET_CODE from data0417 where warehouse_ptr='+cds0015RKEY.AsString+')' ;

     // ShowMessage(strPlanMainDate);
    end;
  end;

  if strPlanMainDate<>'' then
     strPlanMainDate:=#13+'where '  + strPlanMainDate + strStatusValue// +ResultAnd(MainTableWhere)+ MainTableWhere
  else
     strPlanMainDate:=#13+'where 1=1 '+ strStatusValue; //+ResultAnd(MainTableWhere)+ MainTableWhere  ;

  cdsMain.Close;
  cdsMain.CommandText:=cdsMain.F_SQLSelectFrom+strPlanMainDate +#13+cdsMain.F_SQLOrderBy ;
  cdsMain.Open;
  strPlanMainDate:='';        //ÿ�β�ѯ�������丳��ֵ��
end;

procedure TfrmPlanMain.SpeedButton1Click(Sender: TObject);
begin
  inherited;
  RadioGroup2Click(nil) ;
end;

procedure TfrmPlanMain.edit1Change(Sender: TObject);
begin
  with cdsMain do
  if trim(Edit1.Text) <> '' then
  begin
    Filtered := False;
    Filtered := true;
  end
  else
    Filtered := False;
end;

procedure TfrmPlanMain.cdsMainFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  inherited;
  if Trim(Edit1.Text) <>'' then
    Accept:=AnsiContainsText(UpperCase(DataSet.FieldByName(FilterFieldName).AsString),UpperCase(Edit1.Text )) ;
end;

procedure TfrmPlanMain.DghMainTitleClick(Column: TColumnEh);
begin
  inherited;
  if Column.Field.DataType in[ftString,ftWideString] then
  if UpperCase(Column.Field.FieldName)<>UpperCase(FilterFieldName) then
  begin
    Edit1.Text:='';
    FilterFieldName:= Column.Field.FieldName;
    Label1.Caption:=Column.Field.DisplayLabel;
    Edit1.Left:=Label1.Left+5+ Label1.Width;
  end;
end;

procedure TfrmPlanMain.DghMainGetCellParams(Sender: TObject;
  Column: TColumnEh; AFont: TFont; var Background: TColor;
  State: TGridDrawState);
begin
  inherited;
  with  cdsMain  do    //����������ļƻ����������ǽ��죬�ұ�������״̬�Ǵ�ִ�У���ɫ��ʾ
  begin
    if FieldByName('RKEY832').AsInteger=1 then
    begin
      if (FieldByName('PlanMainDate').AsDateTime<=Date) then
        AFont.Color:= clRed
      else                 //����������ļƻ����������ǽ��죬�ұ�������״̬�Ǵ�ִ�У���ɫ��ʾ
      if (FieldByName('PlanMainDate').AsDateTime=Date+1) then
        AFont.Color:= clBlue;   //   clLime
    end
    else
    if  FieldByName('RKEY832').AsInteger=6then
       AFont.Color:= clGreen;
  end;
end;

procedure TfrmPlanMain.SetToolbarButtonStatus(Flag: Boolean);
begin
  dxBarManager.LockUpdate:=True;
  with   ActiveGridEH.DataSource.DataSet as TClientDataSet do
  begin
    tblAdd.Enabled:=Flag and (StrToInt(vprev)in [2,4]);
    actAdd.Enabled:=Flag and (StrToInt(vprev)in [2,4]);

    tblEdit.Enabled:=Flag and (StrToInt(vprev)in [2,3,4]);
    actEdit.Enabled:=Flag and (StrToInt(vprev)in [2,3,4]);

    tblDelete.Enabled:=( Flag)and(IsEmpty=False) and (StrToInt(vprev)in [4]) and (cdsMainRKEY832.AsInteger=1);
    actDelete.Enabled:=( Flag)and(IsEmpty=False) and (StrToInt(vprev)in [4]) and (cdsMainRKEY832.AsInteger=1);

    if ActiveGridEH=DghMain then
    begin
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
      tblDelete.Enabled:=False;   //���ѡ�������ӱ��ɾ����ť������
      actDelete.Enabled:=False;
//      tblEdit.Enabled:=  False;   //���ѡ�������ӱ�񣬱༭��ť������
//      actEdit.Enabled:=  False;
    end;

    if ((cdsMain.State  in [dsEdit,dsInsert])or(cdsMain.ChangeCount>0))
                or((cdsChild.State  in [dsEdit,dsInsert])or(cdsChild.ChangeCount>0))and(StrToInt(vprev)in [2,3,4])  then
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
        tblPrint.Enabled:= True   and (StrToInt(vprev)in [2,3,4]);      //��ӡ
        tblDesign.Enabled:=True   and (StrToInt(vprev)in [2,3,4]) ;      //�������
        tblFilter.Enabled:= True;
        tblReject.Enabled:=True   and (StrToInt(vprev)in [2,3,4]) ;   //���ύ
        tblExpand.Enabled:=True   and (StrToInt(vprev)in [2,3,4]) ;   //�ύ
        tblConfirm.Enabled:=True  and (StrToInt(vprev)in [2,3,4]);   //���
        tblUConfirm.Enabled:=True and (StrToInt(vprev)in [2,3,4]);  //�����
      end ;
  end;

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
     actSave.ImageIndex:=60; // 60

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

  if tblExport.Enabled then   //����EXCEL��ť
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
     actConfirm.ImageIndex:= 116; //actUConfirm

  if tblUConfirm.Enabled then
     actUConfirm.ImageIndex:=115
  else
     actUConfirm.ImageIndex:= 117;

  dxBarManager.LockUpdate:=False;
end;

procedure TfrmPlanMain.SetButtonStatus;
 { procedure ButtonStatus(ADataSet:TClientDataSet);
  begin
    with ADataSet do
    if FieldByName('RKEY832').AsInteger=1 then    //��ִ��
    begin
//      DeleteStatus :=False ;
//      EditStatus   :=False ;
//      btnStatu7    :=False ;//֪ͨ����
      
      btnStatu8    :=False; //ȡ��֪ͨ
      btnStatu3    :=False ;//��ʼ����
      btnStatu5    :=False ;//��ͣ����
      btnStatu2    :=False ;//�ύ����
      btnStatu4    :=False ;//����ͨ��
      N_OtherAcceptanceStatu:= False;  //�������û�����
    end
    else
    if FieldByName('RKEY832').AsInteger =5 then    //��֪ͨ
    begin
      DeleteStatus :=False ;
//      EditStatus   :=False ;
      btnStatu7    :=False ;//֪ͨ����
//      btnStatu3    :=False ;//��ʼ����
      btnStatu5    :=False ;//��ͣ����
      btnStatu2    :=False ;//�ύ����
      btnStatu4    :=False ;//����ͨ��
      N_OtherAcceptanceStatu:= False;  //�������û�����
    end
    else
    if FieldByName('RKEY832').AsInteger=3 then     //ִ����
    begin
      DeleteStatus :=False ;
//      EditStatus   :=False ;
      btnStatu8    :=False; //ȡ��֪ͨ
      btnStatu7    :=False ;//֪ͨ����
      btnStatu3    :=False ;//��ʼ����
//      btnStatu5    :=False ;//��ͣ����
//      btnStatu2    :=False ;//�ύ����
      btnStatu4    :=False ;//����ͨ��
      N_OtherAcceptanceStatu:= False;  //�������û�����
    end
    else
    if FieldByName('RKEY832').AsInteger =6 then    //����ͣ
    begin
      DeleteStatus :=False ;
      EditStatus   :=False ;
      btnStatu8    :=False; //ȡ��֪ͨ
      btnStatu7    :=False ;//֪ͨ����
      btnStatu3    :=False ;//��ʼ����
//      btnStatu5    :=False ;//��ͣ����
      btnStatu2    :=False ;//�ύ����
      btnStatu4    :=False ;//����ͨ��
      N_OtherAcceptanceStatu:= False;  //�������û�����
    end
    else
    if FieldByName('RKEY832').AsInteger =4 then    // ������
    begin
      DeleteStatus :=False ;
      EditStatus   :=False ;
      btnStatu8    :=False; //ȡ��֪ͨ
      btnStatu7    :=False ;//֪ͨ����
      btnStatu3    :=False ;//��ʼ����
//      btnStatu5    :=False ;//��ͣ����
      btnStatu2    :=False ;//�ύ����
//      btnStatu4    :=False ;//����ͨ��
//N_OtherAcceptanceStatu:= False;  //�������û�����
    end
    else
    if FieldByName('RKEY832').AsInteger=2 then    //������
    begin
      DeleteStatus :=False ;
      EditStatus   :=False ;
      btnStatu8    :=False; //ȡ��֪ͨ
      btnStatu7    :=False ;//֪ͨ����
      btnStatu3    :=False ;//��ʼ����
//      btnStatu5    :=False ;//��ͣ����
      btnStatu2    :=False ;//�ύ����
      btnStatu4    :=False ;//����ͨ��
      N_OtherAcceptanceStatu:= False;  //�������û�����
    end     ;
  end;    }

begin
  with cdsMain do
  if FieldByName('RKEY832').AsInteger=1 then    //��ִ��
  begin
    if  (StrToInt(vprev)in [3,4]) then
    begin
      DghMain.FieldColumns['PlanMainDate'].ReadOnly:=false; //�ƻ�����ʱ��
      DghMain.FieldColumns['DeviType'].ReadOnly:=false; //��������
      DghMain.FieldColumns['MainCycl'].ReadOnly:=false; //��������
    end
    else
    begin
      DghMain.FieldColumns['PlanMainDate'].ReadOnly:=true; //�ƻ�����ʱ��
      DghMain.FieldColumns['DeviType'].ReadOnly:=true; //��������
      DghMain.FieldColumns['MainCycl'].ReadOnly:=true; //��������
    end  ;

    DghMain.FieldColumns['MainImpl'].ReadOnly:=true; //������
    DghMain.FieldColumns['Remarks'].ReadOnly:=true; //// ������¼����
    Button7.Enabled:=True and(StrToInt(vprev)in [2,3,4]);           //֪ͨ����
    Button8.Enabled:=False;          //ȡ��֪ͨ
    Button3.Enabled:=False;          //��ʼ����
    N_OtherStartMain.Enabled:=False; //�������û�����
    Button9.Enabled:=False;          //��ʼ��ͣ
    Button10.Enabled:=False;         //��ͣ����
    N_OtherEndPause.Enabled:=False;  //�������û���ͣ����
    Button2.Enabled:=False;          //�ύ����
    Button4.Enabled:=False;          //����ͨ��
    N_OtherAcceptance.Enabled:= False;//�������û�����
    btn_New.Enabled:= False;         // ����
    ControlsSetReadOnly([edt_MainImpl,mo_Remarks],True,clInactiveCaptionText);
    ControlsSetReadOnly([edt_StdTimeCons],False,clWindow);                  //������Ҫ����޸�
    dghChild.ReadOnly:=True;
  end
  else
  if FieldByName('RKEY832').AsInteger =5 then    //��֪ͨ
  begin
    DghMain.FieldColumns['PlanMainDate'].ReadOnly:=true; //�ƻ�����ʱ��
    DghMain.FieldColumns['DeviType'].ReadOnly:=true; //��������
    DghMain.FieldColumns['MainCycl'].ReadOnly:=true; //��������
    DghMain.FieldColumns['MainImpl'].ReadOnly:=true; //������
    DghMain.FieldColumns['Remarks'].ReadOnly:=true; //// ������¼����
    Button7.Enabled:=False;//֪ͨ����
    Button8.Enabled:=True and(StrToInt(vprev)in [2,3,4]);          //ȡ��֪ͨ
    Button3.Enabled:=True and(StrToInt(vprev)in [2,3,4]);//��ʼ����
    N_OtherStartMain.Enabled:=True and(StrToInt(vprev)in [2,3,4]);//�������û�����
    Button9.Enabled:=False;          //��ʼ��ͣ
    Button10.Enabled:=False;         //��ͣ����
    N_OtherEndPause.Enabled:=False;  //�������û���ͣ����
    Button2.Enabled:=False;//�ύ����
    Button4.Enabled:=False; //����ͨ��
    N_OtherAcceptance.Enabled:= False;  //�������û�����
    btn_New.Enabled:= False;// ����
    ControlsSetReadOnly([edt_MainImpl,mo_Remarks],True,clInactiveCaptionText);
    ControlsSetReadOnly([edt_StdTimeCons],False,clWindow);                  //������Ҫ����޸�
    dghChild.ReadOnly:=True;
  end
  else
  if FieldByName('RKEY832').AsInteger=3 then     //ִ����
  begin
    DghMain.FieldColumns['PlanMainDate'].ReadOnly:=true; //�ƻ�����ʱ��
    DghMain.FieldColumns['DeviType'].ReadOnly:=true; //��������
    DghMain.FieldColumns['MainCycl'].ReadOnly:=true; //��������
    if  (StrToInt(vprev)in [4]) then
    begin
      DghMain.FieldColumns['StdTimeCons'].ReadOnly:=false;
      DghMain.FieldColumns['StarMainTime'].ReadOnly:=false;// ��ʼ����ʱ��
      DghMain.FieldColumns['ActuCompTime'].ReadOnly:=false;// ʵ�����ʱ��
      edt_StdTimeCons.ReadOnly:=false;
      dghChild.FieldColumns['BeginTime'].ReadOnly:=false;
      dghChild.FieldColumns['EndTime'].ReadOnly:=false;
      dghChild.FieldColumns['TimeRest'].ReadOnly:=false;//��;��Ϣʱ��
    end;
    //������Ҫ�����е�Ȩ�޿��޸ı�׼ά��ʱ��
    DghMain.FieldColumns['StdTimeCons'].ReadOnly:=false;

    DghMain.FieldColumns['MainImpl'].ReadOnly:=false; //������
    DghMain.FieldColumns['Remarks'].ReadOnly:=false; //// ������¼����
    Button7.Enabled:=False;//֪ͨ����
    Button8.Enabled:=False;          //ȡ��֪ͨ
    Button3.Enabled:=False;//��ʼ����
    N_OtherStartMain.Enabled:=False;//�������û�����
    Button9.Enabled:=True and(StrToInt(vprev)in [2,3,4]);          //��ʼ��ͣ
    Button10.Enabled:=False;         //��ͣ����
    N_OtherEndPause.Enabled:=False;  //�������û���ͣ����
    Button2.Enabled:=True and(StrToInt(vprev)in [2,3,4]);//�ύ����
    Button4.Enabled:=False; //����ͨ��
    N_OtherAcceptance.Enabled:= False;  //�������û�����
    btn_New.Enabled:= True and(StrToInt(vprev)in [2,3,4]);// ����
    if StrToInt(vprev) in [2,3,4]then
    ControlsSetReadOnly([edt_MainImpl,mo_Remarks],False,clWindow);
    //������Ҫ�����е�Ȩ�޿��޸ı�׼ά��ʱ��
//    if vprev='4' then                        //��������Ȩ�ޣ��ſ��޸ı�׼����ʱ��
      ControlsSetReadOnly([edt_StdTimeCons],False,clWindow);

    if  (StrToInt(vprev)in [2,3,4])  then
    dghChild.ReadOnly:=False ;
  end
  else
  if FieldByName('RKEY832').AsInteger =6 then    //����ͣ
  begin
    DghMain.FieldColumns['PlanMainDate'].ReadOnly:=true; //�ƻ�����ʱ��
    DghMain.FieldColumns['DeviType'].ReadOnly:=true; //��������
    DghMain.FieldColumns['MainCycl'].ReadOnly:=true; //��������
    DghMain.FieldColumns['MainImpl'].ReadOnly:=true; //������
    DghMain.FieldColumns['Remarks'].ReadOnly:=true; //// ������¼����
    Button7.Enabled:=False;//֪ͨ����
    Button8.Enabled:=False;          //ȡ��֪ͨ
    Button3.Enabled:=False;//��ʼ����
    N_OtherStartMain.Enabled:=False;//�������û�����
    Button9.Enabled:=False;          //��ʼ��ͣ
    Button10.Enabled:=True and(StrToInt(vprev)in [2,3,4]);         //��ͣ����
    N_OtherEndPause.Enabled:=True and(StrToInt(vprev)in [2,3,4])  ;  //�������û���ͣ����
    Button2.Enabled:=False;//�ύ����
    Button4.Enabled:=False; //����ͨ��
    N_OtherAcceptance.Enabled:= False;  //�������û�����
    btn_New.Enabled:= False;// ����
    ControlsSetReadOnly([edt_MainImpl,mo_Remarks],True,clInactiveCaptionText);
    ControlsSetReadOnly([edt_StdTimeCons],False,clWindow);                  //������Ҫ����޸�
    if  (StrToInt(vprev)in [2,3,4])  then
    dghChild.ReadOnly:=False;
  end
  else
  if FieldByName('RKEY832').AsInteger =4 then    // ������
  begin
    if  (StrToInt(vprev)in [4]) then
    begin
      DghMain.FieldColumns['StdTimeCons'].ReadOnly:=false;
      DghMain.FieldColumns['StarMainTime'].ReadOnly:=false;// ��ʼ����ʱ��
      DghMain.FieldColumns['ActuCompTime'].ReadOnly:=false;// ʵ�����ʱ��
      edt_StdTimeCons.ReadOnly:=false;
      dghChild.FieldColumns['BeginTime'].ReadOnly:=false;
      dghChild.FieldColumns['EndTime'].ReadOnly:=false;
      dghChild.FieldColumns['TimeRest'].ReadOnly:=false;//��;��Ϣʱ��
    end;
    DghMain.FieldColumns['PlanMainDate'].ReadOnly:=true; //�ƻ�����ʱ��
    DghMain.FieldColumns['DeviType'].ReadOnly:=true; //��������
    DghMain.FieldColumns['MainCycl'].ReadOnly:=true; //��������
    DghMain.FieldColumns['MainImpl'].ReadOnly:=true; //������
    DghMain.FieldColumns['Remarks'].ReadOnly:=true; //// ������¼����
    Button7.Enabled:=False;//֪ͨ����
    Button8.Enabled:=False;          //ȡ��֪ͨ
    Button3.Enabled:=False;//��ʼ����
    N_OtherStartMain.Enabled:=False;//�������û�����
    Button9.Enabled:=False;          //��ʼ��ͣ
    Button10.Enabled:=False;         //��ͣ����
    N_OtherEndPause.Enabled:=False;  //�������û���ͣ����
    Button2.Enabled:=False;//�ύ����
    Button4.Enabled:=True and(StrToInt(vprev)in [2,3,4]); //����ͨ��
    N_OtherAcceptance.Enabled:= True and(StrToInt(vprev)in [2,3,4])  ;  //�������û�����
    btn_New.Enabled:= False;// ����
    ControlsSetReadOnly([edt_MainImpl,mo_Remarks],True,clInactiveCaptionText);
    ControlsSetReadOnly([edt_StdTimeCons],False,clWindow);                  //������Ҫ����޸�
    dghChild.ReadOnly:=false;
  end
  else
  if FieldByName('RKEY832').AsInteger=2 then    //������
  begin
    if  (StrToInt(vprev)in [4]) then
    begin
      DghMain.FieldColumns['StdTimeCons'].ReadOnly:=false;
      DghMain.FieldColumns['StarMainTime'].ReadOnly:=false;// ��ʼ����ʱ��
      DghMain.FieldColumns['ActuCompTime'].ReadOnly:=false;// ʵ�����ʱ��
      edt_StdTimeCons.ReadOnly:=false;
      dghChild.FieldColumns['BeginTime'].ReadOnly:=false;
      dghChild.FieldColumns['EndTime'].ReadOnly:=false;
      dghChild.FieldColumns['TimeRest'].ReadOnly:=false;//��;��Ϣʱ��
    end;
    DghMain.FieldColumns['PlanMainDate'].ReadOnly:=true; //�ƻ�����ʱ��
    DghMain.FieldColumns['DeviType'].ReadOnly:=true; //��������
    DghMain.FieldColumns['MainCycl'].ReadOnly:=true; //��������
    DghMain.FieldColumns['MainImpl'].ReadOnly:=true; //������
    DghMain.FieldColumns['Remarks'].ReadOnly:=true; //// ������¼����
    Button7.Enabled:=False;//֪ͨ����
    Button8.Enabled:=False;          //ȡ��֪ͨ
    Button3.Enabled:=False;//��ʼ����
    N_OtherStartMain.Enabled:=False;//�������û�����
    Button9.Enabled:=False;          //��ʼ��ͣ
    Button10.Enabled:=False;         //��ͣ����
    N_OtherEndPause.Enabled:=False;  //�������û���ͣ����
    Button2.Enabled:=False;//�ύ����
    Button4.Enabled:=False; //����ͨ��
    N_OtherAcceptance.Enabled:= False;  //�������û�����
    btn_New.Enabled:= False;// ����
    ControlsSetReadOnly([edt_StdTimeCons,edt_MainImpl,mo_Remarks],True ,clInactiveCaptionText);
    dghChild.ReadOnly:=false;
  end;

  with cdsChild do
  if FieldByName('Status').AsInteger=3 then    //ִ����
  begin
    btn_Delete.Enabled:=True;// ɾ��
    Button11.Enabled:=True;  //���ν���
    dghChild.FieldColumns['Remark'].ReadOnly:=False;
  end
  else
  begin
    btn_Delete.Enabled:=False;// ɾ��
    Button11.Enabled:=False;  //���ν���
    dghChild.FieldColumns['Remark'].ReadOnly:=True;
  end   ;
end;

procedure TfrmPlanMain.N_OtherAcceptanceClick(Sender: TObject);
var
  vUsernameRkey,vEmployeeRkey,vUser_rights:string;
begin
  inherited;
  if GetUserRights(Self,DM.ADOConnection1,vUsernameRkey, vEmployeeRkey,vUser_rights,'�������û�����') then
  begin
    if (StrToInt(vUser_rights) in[2,3,4])=False then
    begin
      MsgError('��û�����յ�Ȩ�ޣ�');
      Exit;
    end;

    Acceptanceby(vUsernameRkey) ;
  end;
end;

procedure TfrmPlanMain.Acceptanceby(UserKey:string);

begin
  if (cdsMain.Active)and(not cdsMain.IsEmpty ) then
  begin

    if cdsMain.State in [dsEdit,dsInsert] then
      cdsMain.Post;

    with   DghMain.DataSource.DataSet as Tcds   do
    begin
      try
        try
          Screen.Cursor := crHourGlass;
          Edit;
          FieldByName('RKEY832').Value:=2;                  //��״̬��Ϊ�������� ��
          FieldByName('MainAcce_UserPtr').Value:=UserKey  ;  //������
          Post;
          ApplyUpdates(0) ;
        finally
          Screen.Cursor := crDefault;
        end;
      except
        on e:Exception do
        begin
          cdsMain.Cancel;
          MsgError('�ύʧ�ܣ�'+#13#10+e.Message);
        end;
      end;
    end;
    dsMainStateChange(nil) ;
    SetButtonStatus;
  end;
end;

procedure TfrmPlanMain.Button7Click(Sender: TObject);
var
  i:integer;
  TempTable:string;
  IsSenderMsg:Boolean;
begin
  IsSenderMsg:=True;
  if (cdsMain.Active)and(not cdsMain.IsEmpty ) then
  begin
    if messagebox(Self.Handle,'��ȷ��Ҫ֪ͨ�����Ա���б�����','ѯ��',MB_yesno+MB_iconquestion)=idNo then
      Exit ;

    TempTable:='##PhoneMsg'+IntToStr(UserRKEY);   //��ʱ���͵�½�û�ָ���������ʹ��ͬ���û�ͬʱ������Ҳ�����໥Ӱ�졣

    if cdsMain.State in [dsEdit,dsInsert] then
      cdsMain.Post;

    with   DghMain.DataSource.DataSet as TClientDataSet  do
    if   DghMain.SelectedRows.Count   >   1   then  //����û�ѡ�����������1�������С�
      begin
        try
          try
            cdsMain.F_IsBatchOperating :=True;
            cdsMain.DisableControls;
            Screen.Cursor := crHourGlass;
            DM.ADOConnection1.BeginTrans;
            with cdsRead do
            begin
              Close;                                              //��ʱ���Ѿ����ڣ��ͽ���ɾ�������´���
              CommandText:='if Exists(select * from tempdb.dbo.sysobjects  where name= '+QuotedStr(TempTable)+' and type= ''U'') '
                        +' drop table '+TempTable+' create table  '+TempTable+' (Phone varchar(15),FASSET_ptr int,Msg varchar(1000)) '
                        +' Create CLUSTERED INDEX INDEX'+TempTable+' ON '+TempTable+' ([Phone],[FASSET_ptr])';
              Execute;
            end;

            if messagebox(Self.Handle,'��Ҫ�����ֻ�����֪ͨ���Ÿ����˸��豸Ҫ�������б�����','ѯ��',MB_yesno+MB_iconquestion)= idNo then
            IsSenderMsg:=False;

            for   i:=   DghMain.SelectedRows.Count   -   1   downto   0   do
            begin
              GotoBookmark(pointer(DghMain.SelectedRows.Items[i]));
              Edit;
              FieldByName('RKEY832').Value:=5;                  //��״̬��Ϊ����֪ͨ��
              Post;
              if ApplyUpdates(0)=0 then
              begin

                cmdUpdate.Parameters.ParamByName('v1PlanMainDate').Value:=DateToStr(cdsMain.FieldByName('PlanMainDate').Value);
                cmdUpdate.Parameters.ParamByName('v2MainCycl').Value:=cdsMain.FieldByName('MainCycl').Value;
                cmdUpdate.Parameters.ParamByName('v3DeviNumb').Value:=cdsMain.FieldByName('DeviNumb').Value;
                cmdUpdate.Parameters.ParamByName('v4MainCycl').Value:=cdsMain.FieldByName('MainCycl').Value;
                cmdUpdate.Parameters.ParamByName('v5DeviNumb').Value:=cdsMain.FieldByName('DeviNumb').Value;
                cmdUpdate.Parameters.ParamByName('v7MainCycl').Value:=cdsMain.FieldByName('MainCycl').Value;
                cmdUpdate.Execute;                                   //ִ�иô洢���̣�������һ�εı����ƻ���
              end
              else
              DM.ADOConnection1.RollbackTrans;

              if   IsSenderMsg=True then
              with cdsRead do
              begin
                Close;
                CommandText:=                     //���͸��豸��Ŷ�Ӧ���ŵĶԾ���Ϣ�����˵ļ�¼������ʱ����
                 'insert into '+TempTable+'(FASSET_ptr,Phone,Msg)'
                +#13+'(select distinct data0417.rkey, data0834.Phone,ABBR_NAME+'' ���ţ�''+DEPT_NAME+'' �豸���룺''+FASSET_CODE+''���豸���ƣ�''+FASSET_NAME+''��Ԥ��'' '
                +#13+' +CONVERT(varchar(100),data0831.PlanMainDate, 23)+''���б�����''as msg  '
                +#13+'from data0417  '
                +#13+'join data0034 on data0417.Dept_Ptr=data0034.rkey  '
                +#13+'join data0834 on data0834.DeptCode=data0034.Dept_Code and  data0834.warehouse_ptr=data0417.warehouse_ptr   '
                +#13+'join data0831 on data0831.DeviNumb=data0417.Fasset_Code '
                +#13+'join data0015 on data0417.warehouse_ptr=data0015.rkey '
                +#13+'where data0831.rkey=  '+cdsMainrkey.AsString+')';

                Execute;
              end;
            end;
            DM.ADOConnection1.CommitTrans;
          finally
            cdsMain.F_IsBatchOperating :=False;
            cdsMain.EnableControls;
            Screen.Cursor := crDefault;
          end;
          with cdsRead do
          begin
            Close;
            CommandText:='SELECT distinct  Phone,Msg FROM '+TempTable;
            Open;
            if IsEmpty=False then
            if   IsSenderMsg=True then
            while not Eof do
            begin
              DM.cdsRead1.CommandText:=  'insert [172.18.9.10].[WzSmsCenter].dbo.[tblsms_outbox]'+//'insert ['+vSUPLFEDSHIP+'].'+vSUPLFEDMAT+'.dbo.'+vSUPLFEDMISC+
                        '(phonenumber,messagecontent,sendername,companyid) '+
                        'values ('+quotedstr(FieldByName('Phone').AsString)+','+quotedstr(FieldByName('Msg').AsString)+','+quotedstr(UserName)+',9)';
              DM.cdsRead1.Execute;
              Next;
            end;
          end;
        except
          on e:Exception do
          begin
            DM.ADOConnection1.RollbackTrans;
            cdsMain.Cancel;
            cdsMain.Refresh;
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
            FieldByName('RKEY832').Value:=5;                  //��״̬��Ϊ����֪ͨ ��
            Post;
            if ApplyUpdates(0)=0 then
            begin
              cmdUpdate.Parameters.ParamByName('v1PlanMainDate').Value:=DateToStr(cdsMain.FieldByName('PlanMainDate').Value);
              cmdUpdate.Parameters.ParamByName('v2MainCycl').Value:=cdsMain.FieldByName('MainCycl').Value;
              cmdUpdate.Parameters.ParamByName('v3DeviNumb').Value:=cdsMain.FieldByName('DeviNumb').Value;
              cmdUpdate.Parameters.ParamByName('v4MainCycl').Value:=cdsMain.FieldByName('MainCycl').Value;
              cmdUpdate.Parameters.ParamByName('v5DeviNumb').Value:=cdsMain.FieldByName('DeviNumb').Value;
              cmdUpdate.Parameters.ParamByName('v7MainCycl').Value:=cdsMain.FieldByName('MainCycl').Value;
              cmdUpdate.Execute;                                   //ִ�иô洢���̣�������һ�εı����ƻ���
            end
            else
              DM.ADOConnection1.RollbackTrans;

            DM.ADOConnection1.CommitTrans;
          finally
            Screen.Cursor := crDefault;
          end;

          if messagebox(Self.Handle,'��Ҫ�����ֻ�����֪ͨ���Ÿ����˸��豸Ҫ�������б�����','ѯ��',MB_yesno+MB_iconquestion)= idYes then
          with cdsRead do
          begin
            Close;
            CommandText:=                     //���͸��豸��Ŷ�Ӧ���ŵĶԾ���Ϣ�����˵ļ�¼������ʱ����
            'select distinct data0834.Phone,ABBR_NAME+'' ���ţ�''+DEPT_NAME+'' �豸���룺''+FASSET_CODE+''���豸���ƣ�''+FASSET_NAME+''��Ԥ��'' '
            +#13+' +CONVERT(varchar(100),data0831.PlanMainDate, 23)+''���б�����''as msg  '
            +#13+'from data0417  '
            +#13+'join data0034 on data0417.Dept_Ptr=data0034.rkey  '
            +#13+'join data0834 on data0834.DeptCode=data0034.Dept_Code and  data0834.warehouse_ptr=data0417.warehouse_ptr   '
            +#13+'join data0831 on data0831.DeviNumb=data0417.Fasset_Code '
            +#13+'join data0015 on data0417.warehouse_ptr=data0015.rkey '
            +#13+'where data0831.rkey=  '+cdsMainrkey.AsString;
            Open;

            while not Eof do
            begin
              DM.cdsRead1.CommandText:='insert [172.18.9.10].[WzSmsCenter].dbo.[tblsms_outbox]'//'insert ['+vSUPLFEDSHIP+'].'+vSUPLFEDMAT+'.dbo.'+vSUPLFEDMISC

                        +'(phonenumber,messagecontent,sendername,companyid) '
                        +#13+'values ('+quotedstr(FieldByName('Phone').AsString)+','
                           +quotedstr(FieldByName('Msg').AsString)+','+quotedstr(UserName)+',9)';
              Next;
            end;
          end;
        except
          on e:Exception do
          begin
         //   DM.ADOConnection1.RollbackTrans;    //�������ݿ��ʱ�򣬲���ʹ������
            cdsMain.Cancel;
            cdsMain.Refresh;
            MsgError('֪ͨʧ�ܣ�'+#13#10+e.Message);
          end;
        end;
      end;
    SetButtonStatus;
    dsMainStateChange(nil);
  end;

end;

procedure TfrmPlanMain.Button4MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  ptObject: TPoint;
begin
  with TButton(Sender) do
  ptObject := Parent.ClientToScreen(Point(Left,Top ));
  PopupMenuInButton4.Popup(ptObject.X,ptObject.Y);
end;

procedure TfrmPlanMain.Button1Click(Sender: TObject);
begin
  inherited;
  if cdsMain.State in [dsInsert,dsEdit] then
    cdsMain.Post;

    frmMultiSelectedItem:= TfrmMultiSelectedItem.Create(Self);
    with frmMultiSelectedItem do
    begin
      Caption:=(Sender as TButton).Caption;
      if   ShowModal=mrOK then
      begin
        try
          cdsMain.F_IsBatchOperating:=True;
          Screen.Cursor := crHourGlass;
          cdsMain.DisableControls;
          dt1.First;
          while not Dt1.Eof do
          begin
            if Dgh1.FieldColumns['selected'].Field.AsBoolean=True then
            begin
              cdsMain.Append;
              cdsMain.FieldByName('PlanMainDate').Value:=Dt1.FieldByName('PlanMainDate').Value;
              cdsMain.FieldByName('DeviNumb').Value    :=Dt1.FieldByName('Fasset_Code').Value;
              cdsMain.FieldByName('FASSET_NAME').Value :=Dt1.FieldByName('FASSET_NAME').Value;
              cdsMain.FieldByName('DEPT_Name').Value   :=Dt1.FieldByName('DEPT_Name').Value;
              cdsMain.FieldByName('ABBR_NAME').Value   :=Dt1.FieldByName('ABBR_NAME').Value;
              cdsMain.FieldByName('equipment_grade').Value :=Dt1.FieldByName('equipment_grade').Value;
              cdsMain.FieldByName('LOCATION').Value    :=Dt1.FieldByName('LOCATION').Value;
              cdsMain.FieldByName('DeviType').Value    :=Dt1.FieldByName('DeviType').Value;
              cdsMain.FieldByName('MainCycl').Value    :=Dt1.FieldByName('MainCycl').Value;
              cdsMain.FieldByName('RKEY832').Value     :=1;
              cdsMain.FieldByName('StdTimeCons').Value :=Dt1.FieldByName('StdTimeCons').Value;
              cdsMain.Post;

              Dt1.Edit;
              Dt1.FieldByName('selected').AsBoolean:=False;
              Dt1.Post;
            end;
              Dt1.Next;
          end;
          cdsMain.ApplyUpdates(0);
        finally
          cdsMain.F_IsBatchOperating:=False;
          Dt1.EnableControls;
          cdsMain.EnableControls;
          ChildDataSetOpen;
          Screen.Cursor := crDefault;
        end;
        Self.dsMainStateChange(nil);
        Self.SetButtonStatus;
      end;
      Free;

    end;
end;

Function  TfrmPlanMain.Newline(str:String;AddSpaces:string='') :string;
begin
  Result:='';
  if str<>  '' then
  begin
    str:=str+#10#13+AddSpaces;        //��4���ո���Ϣ�Ĳ�νṹ����
    Result:=  str;
  end;
end;

procedure TfrmPlanMain.StartMaintenance(vEmpl_ptr:Integer);
var
  NowDate:TDateTime;
  vEMPLOYEE_NAME:string;
  vNUMBER:string;
begin
  try
    Screen.Cursor := crHourGlass;
    if (cdsMain.Active)and( not cdsMain.IsEmpty) then
    begin
      if EmployeeStatusCheck(IntToStr(vEmpl_ptr),vNUMBER) then
      begin
        Exit;
      end;

      if  cds0005.Active=False then
        cds0005.Open;
      if cds0005.Locate('rkey',vEmpl_ptr,[])=False   then
      begin
        MsgError('û���ҵ���Ĺ�Ա��Ϣ���޷���ӣ�����');
        Exit;
      end;
      vEMPLOYEE_NAME:=cds0005.Lookup('rkey',vEmpl_ptr,'EMPLOYEE_NAME')   ;

      if cdsMain.State in [dsEdit,dsInsert] then
        cdsMain.Post;

      NowDate:=GetDataBaseDate(cdsRead,1);
      try
        with   DghMain.DataSource.DataSet   do
        begin
          try
            DM.ADOConnection1.BeginTrans;
            with cdsMain do
            begin
              Edit;
              FieldByName('MainImpl').Value:=vEMPLOYEE_NAME;
              FieldByName('RKEY832').Value:=3;     //��״̬��Ϊ����ִ�� ��
              if FieldByName('StarMainTime').IsNull then  //��� '������ʼʱ��'�ǿգ���ȡ��ǰ���ݿ��������ʱ��
                FieldByName('StarMainTime').value:= NowDate;
              Post;
              if ApplyUpdates(0)=0 then
              begin
                with cdsChild do
                if Active then
                begin
                  Append;
                  if cds0005.Locate('rkey',vEmpl_ptr,[])   then
                  begin
                    FieldByName('Work_ptr').Value:=cdsMainrkey.Value;
                    FieldByName('WorkDate').Value:=DateToStr(NowDate);
                    FieldByName('BeginTime').Value:=NowDate;//GetDataBaseDate(cdsRead,1);
                    FieldByName('Status').Value:=3;
                    FieldByName('TimeRest').Value:=2.5;
                    FieldByName('Empl_ptr').Value:=cds0005Rkey.Value;
                    FieldByName('EMPL_CODE').Value:=cds0005EMPL_CODE.Value;
                    FieldByName('EMPLOYEE_NAME').Value:=cds0005EMPLOYEE_NAME.Value;
                    Post;
                    if ApplyUpdates(0)<>0 then
                      DM.ADOConnection1.RollbackTrans;
                  end
                  else
                  begin
                    DM.ADOConnection1.RollbackTrans;
                    MsgError('û���ҵ���Ĺ�Ա��Ϣ���޷���ӣ�����');
                  end ;
                end;
              end
              else
                DM.ADOConnection1.RollbackTrans;
            end;
            DM.ADOConnection1.CommitTrans;
          except
            on e:Exception do
            begin
              DM.ADOConnection1.RollbackTrans;
              cdsMain.Cancel;
              cdsChild.Cancel;
              MsgError('�ύʧ�ܣ�'+#13#10+e.Message);
            end;
          end;
        end;
      finally
        SetButtonStatus;       //���������ұ߰�ť��״̬��
        dsMainStateChange(nil);
      end;
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TfrmPlanMain.Button5Click(Sender: TObject);
begin
  inherited;
  if Assigned (frmPlanMain02)=False then
  frmPlanMain02:= TfrmPlanMain02.Create(Self);
  with  frmPlanMain02 do
  begin
    with  cdsMain   do
    begin
      Close;
      Params.ParamByName('vRkey831').Value:= self.cdsMain.FieldByName('Rkey').Value;
      Open;
    end;
    Caption:=(Sender as TButton).Caption;        //�����ڱ��⸳ֵ
    ShowModal;
  end;
end;

procedure TfrmPlanMain.Button2Click(Sender: TObject);
  procedure Effective(var strMsg:string;NowDate:TDateTime;SelectedRowNo:Integer=0);
  var
    msg,AddSpaces:string;
  begin
    msg:='';
    with   cdsMain  do
    begin
      if DghMain.SelectedRows.Count>1 then
        AddSpaces:='               '  //15���ո�      //���к�ѡ�����ʱ����Ϣ�ַ����Ļ᲻һ���������㲻ͬ������
      else
        AddSpaces:='        ';  //8 ���ո�

      if (FieldByName('Remarks').IsNull)or(FieldByName('Remarks').AsString='') then
      begin
        msg:=Newline(msg,AddSpaces)+'�С�'+FieldByName('Remarks').DisplayLabel+'����ֵ����Ϊ�գ�'
      end ;

      if  FieldByName('ActuCompTime').IsNull then
      begin
        if FieldByName('StarMainTime').AsDateTime>= NowDate then
        begin
          msg:= Newline(msg,AddSpaces)+'�С�' +FieldByName('ActuCompTime').DisplayLabel+'��������ֵ��'
          +DatetimetoStr(NowDate)+',������С�ڻ���ڡ�'+FieldByName('StarMainTime').DisplayLabel+'����';
        end;
      end
      else
      begin
        if FieldByName('StarMainTime').AsDateTime>= FieldByName('ActuCompTime').AsDateTime then
        begin
          msg:= Newline(msg,AddSpaces)+'�С�'
          +FieldByName('ActuCompTime').DisplayLabel+'��������С�ڻ���ڡ�'+FieldByName('StarMainTime').DisplayLabel+'����';
        end;
      end;

      with cdsRead do
      begin
        Close;
        CommandText:='select max(stop_end_date)as stop_end_date from data0833 where rkey831='+cdsMain.FieldByName('rkey').AsString ;
        Open;

        if (IsEmpty=False)then
        if cdsMain.FieldByName('ActuCompTime').IsNull then
        begin
          if    NowDate<FieldByName('stop_End_Date').AsDateTime then
          begin
            msg:= Newline(msg,AddSpaces)+'�С�' +cdsMain.FieldByName('ActuCompTime').DisplayLabel+'��������ֵ��'
            +DatetimetoStr(NowDate)+',������С�ڻ���ڡ���ͣ����ʱ�䡱��';
          end;
        end
        else
        begin
          if cdsMain.FieldByName('ActuCompTime').AsDateTime<FieldByName('stop_End_Date').AsDateTime then
          begin
            msg:= Newline(msg,AddSpaces)+'�С�'
            +cdsMain.FieldByName('ActuCompTime').DisplayLabel+'��������С�ڻ���ڡ���ͣ����ʱ�䡱��';
          end;
        end;
      end;
    end ;

    if msg<>'' then
    begin
      if DghMain.SelectedRows.Count>1 then
        strMsg:=Newline(strMsg)+'��ǰѡ����'+inttoStr(SelectedRowNo+1)+'�У�' +Msg
      else
        strMsg:=Newline(strMsg)+'��ǰ��¼' +Msg
    end;
  end;

  function Inspection(Grid:TDBGridEh; NowDate:TDateTime):Boolean;
  var
    i:Integer;
    strMsg:string;
  begin                                  {���ܣ������û���ѡ�����л��Ƕ��У�����Effective���̶�ѡ���ļ�¼�н�����Ч��飬����Υ������Ϣд��strMsg��}
    Result:=False;
    with   Grid.DataSource.DataSet   do
    if   Grid.SelectedRows.Count   >   1   then  //����û�ѡ�����������1�������С�
    begin
      try
        DisableControls;
        for   i:= 0 to Grid.SelectedRows.Count - 1 do  //����¼�Ƿ�Ϊ��,�ǿռ��˳�
        begin
          GotoBookmark(pointer(Grid.SelectedRows.Items[i]));
          Effective(strMsg,NowDate,i);
        end;
      finally
        EnableControls;
      end;
    end
    else
      begin
        Effective(strMsg,NowDate);
      end;
    if strMsg<>'' then
    begin
      MsgError(strMsg);
      Result:=True;
    end;
  end;
var
  NowDate:TDateTime;
begin
  if (cdsMain.Active)and(not cdsMain.IsEmpty ) then
  begin
  //������ǰҪ�ж��Ƿ���״̬��ִ���еĹ�Ա��¼
    with cdsRead do
    begin
      Data:=cdsChild.Data;
      First;
      while not Eof do
      begin
        if FieldByName('Status').AsInteger=3 then
        begin
          MsgError('��ǰ������������״̬�ǡ�ִ���С��Ĺ�Ա��¼������');
          Exit;
        end;
        Next;
      end;
    end;
    NowDate:=GetDataBaseDate(cdsRead,1);
    if  Inspection(DghMain,NowDate) then    //������δͨ�����˳���
      Exit;
    if messagebox(Self.Handle,'��ȷ��Ҫ�ύ������','ѯ��',MB_yesno+MB_iconquestion)=idNo then
      Exit ;
    if cdsMain.State in [dsEdit,dsInsert] then
      cdsMain.Post;

    try
      try
        DM.ADOConnection1.BeginTrans;
        Screen.Cursor := crHourGlass;
        with  cdsMain do
        begin
          Edit;
          FieldByName('RKEY832').Value:=4;     //��״̬��Ϊ4������
          if (FieldByName('ActuCompTime').IsNull)or(FieldByName('ActuCompTime').AsString='') then  //��� '������ʼʱ��'�ǿգ���ȡ��ǰ���ݿ��������ʱ��
              FieldByName('ActuCompTime').value:= NowDate;                         //��ֵ�ᴥ��cdsMainActuCompTimeChange�¼��������档
          if cdsMain.State in [dsEdit] then
            Post;
          if ApplyUpdates(0)=0 then
          begin
            //������Ҫ�󣬱����ƻ���֪ͨ����ʱ���Ϳ�ʼ������һ�εı����ƻ�����ˣ���δ������ߡ�
                                                                          //�ر�˵������D2010�Ŀ��������£��������Ĳ���ֵ�������ַ���Ҫ��������������������Ϊ WideString,������ܻ��������ط����ҵ���������Сʱ����
//            cmdUpdate.Parameters.ParamByName('v1PlanMainDate').Value:=DateToStr(cdsMain.FieldByName('PlanMainDate').Value);
//            cmdUpdate.Parameters.ParamByName('v2MainCycl').Value:=cdsMain.FieldByName('MainCycl').Value;
//            cmdUpdate.Parameters.ParamByName('v3DeviNumb').Value:=cdsMain.FieldByName('DeviNumb').Value;
//            cmdUpdate.Parameters.ParamByName('v4MainCycl').Value:=cdsMain.FieldByName('MainCycl').Value;
//            cmdUpdate.Parameters.ParamByName('v5DeviNumb').Value:=cdsMain.FieldByName('DeviNumb').Value;
//            cmdUpdate.Parameters.ParamByName('v7MainCycl').Value:=cdsMain.FieldByName('MainCycl').Value;
//            cmdUpdate.Execute;                                   //ִ�иô洢���̣�������һ�εı����ƻ���
          end
          else
            DM.ADOConnection1.RollbackTrans;
        end;
        DM.ADOConnection1.CommitTrans;
      except
        on e:Exception do
        begin
          DM.ADOConnection1.RollbackTrans;
          cdsMain.Refresh;
          MsgError('�ύʧ�ܣ�'+#13#10+e.Message);
        end;
      end
    finally
      Screen.Cursor := crDefault;
    end;

    SetButtonStatus;
    dsMainStateChange(nil);
  end;

end;

procedure TfrmPlanMain.Button8Click(Sender: TObject);
begin
  inherited;
  with   cdsMain  do
  if (Active)and(not IsEmpty ) then
  begin
    if messagebox(Self.Handle,'��ȷ��Ҫȡ��֪ͨ��','ѯ��',MB_yesno+MB_iconquestion)=idNo then
      Exit ;
    Edit;
    FieldByName('RKEY832').Value:=1;                  //��״̬��Ϊ����֪ͨ��
    Post;
    ApplyUpdates(0);

    dsMainStateChange(nil);
    SetButtonStatus;
  end
end;

procedure TfrmPlanMain.cdsMainRKEY832Change(Sender: TField);
begin
  inherited;
  with cds832 do
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
        cdsMainMainExecStat.Value := FieldByName('MainExecStat').Value ;
        end
      else
        begin
        cdsMain.FieldByName('MainExecStat').Value:=null;
        end;
    end;
  end;
end;

procedure TfrmPlanMain.N_AcceptanceClick(Sender: TObject);
begin
  inherited;
  if messagebox(Self.Handle,'��ȷ��Ҫ����ͨ����','ѯ��',MB_yesno+MB_iconquestion)=idNo then
    Exit ;
  Acceptanceby(IntToStr(UserRKEY) );
end;

procedure TfrmPlanMain.cdsMainMainAcce_UserPtrChange(Sender: TField);
begin
  inherited;
  with cds0073 do
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
      cdsMain.FieldByName('User_Full_Name').Value:=null;
    end
    else
    begin
      if Locate('rkey',Sender.Value,[loCaseInsensitive]) then
        begin
        cdsMainUser_Full_Name.Value := FieldByName('User_Full_Name').Value ;
        end
      else
        begin
        cdsMain.FieldByName('User_Full_Name').Value:=null;
        end;
    end;
  end;
end;

procedure TfrmPlanMain.btn_NewClick(Sender: TObject);
var
  vUsernameRkey,vEmployeeRkey,vUser_rights,vNUMBER:string;
  NowDate:TDateTime;
begin
  try
    Screen.Cursor := crHourGlass;

    cdsRead.Data:=cdsChild.Data;
    cdsRead.First;
    if   cdsRead.IsEmpty then
    begin
      if messagebox(Self.Handle,Pchar('��ѡ��ı����������ǡ�'+cdsMainPlanMainDate.AsString+'���豸�����ǡ�'+cdsMainFASSET_NAME.asString +'����'
           +#13+'��Ҫ������'),'ѯ��',MB_yesno+MB_iconquestion)=idNo then
        Exit ;
    end
    else
    begin
      if messagebox(Self.Handle,Pchar('��ѡ��ı����������ǡ�'+cdsMainPlanMainDate.AsString+'���豸�����ǡ�'+cdsMainFASSET_NAME.asString +'����'
           +#13+ '��һ�������ǡ�'+cdsRead.FieldByName('EMPLOYEE_NAME').asString +'��,��Ҫ������'),'ѯ��',MB_yesno+MB_iconquestion)=idNo then
        Exit ;
    end ;
    cdsRead.Close;

    if GetUserRights(Self,DM.ADOConnection1,vUsernameRkey, vEmployeeRkey,vUser_rights,'�����û���������') then
    begin
      if (strtoint(vUser_rights)in [2,3,4])=False then
      begin
        messagedlg('�Բ���,��û����ӹ�Ա��Ȩ�ޣ�',mtinformation,[mbok],0)  ;
        Exit ;
      end;

      if EmployeeStatusCheck(vEmployeeRkey,vNUMBER) then
      begin
        Exit;
      end;

      if cdsChild.IsEmpty=False then
      with cdsRead do
      begin
        Close;
        CommandText:='select rkey from data0848 where [Work_ptr]='+cdsChildWork_ptr.AsString
        +' and  WorkDate=CONVERT(VARCHAR(10),GETDATE(),120) and Empl_ptr='+vEmployeeRkey+' and EndTime>=getDate()' ;
        Open;
        if IsEmpty=False then
        begin
          MsgError('������ڱ�ά�޵��Ѵ��ڹ�����¼�����εĿ�ʼʱ�䲻��С��'+#13+'������ϴεĽ���ʱ�䣬����޷���ӣ�����');
          Exit;
        end;
      end;

      with cdsChild do
      if Active then
      begin
        Append;
        if cds0005.Active=False then
          cds0005.Open;
        if cds0005.Locate('rkey',vEmployeeRkey,[])   then
        begin
          NowDate:=GetDataBaseDate(cdsRead,1);
          FieldByName('Work_ptr').Value:=cdsMainrkey.Value;
          FieldByName('WorkDate').Value:=DateToStr(NowDate);
          FieldByName('BeginTime').Value:=NowDate  ;
          FieldByName('Status').Value:=3;
          FieldByName('TimeRest').Value:=2.5;
          FieldByName('Empl_ptr').Value:=cds0005Rkey.Value;
          FieldByName('EMPL_CODE').Value:=cds0005EMPL_CODE.Value;
          FieldByName('EMPLOYEE_NAME').Value:=cds0005EMPLOYEE_NAME.Value;
          Post;
          ApplyUpdates(0);
        end;
        SetButtonStatus;
        dsMainStateChange(nil);
      end;
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TfrmPlanMain.cdsMainAfterInsert(DataSet: TDataSet);
begin
  inherited;
  AddDefaultValues(cdsMain,cdsMain.F_TableName,Self);
end;
{����Ϊ�ӱ��ʼ��ͣ�Ĺ��ܣ�����ʱ������
procedure TfrmPlanMain.Button9Click(Sender: TObject);
  procedure Effective(Grid:TDBGridEh;var strMsg:string;NowDate:TDateTime;SelectedRowNo:Integer=0);
  var
    msg,AddSpaces:string;
  begin
    msg:='';
    if Grid.SelectedRows.Count>1 then
      AddSpaces:='               '  //15���ո�      //���к�ѡ�����ʱ����Ϣ�ַ����Ļ᲻һ���������㲻ͬ������
    else
      AddSpaces:='        ';  //8 ���ո�

    with  cdsChild  do
    begin
      if (FieldByName('BeginTime').AsDateTime>=NowDate) then
      begin
       // ShowMessage(FieldByName('BeginTime').AsString+':'+datetimetostr(NowDate));
        msg:=Newline(msg,AddSpaces)+'�С�'+FieldByName('BeginTime').DisplayLabel+'����ֵ���ܴ��ڻ���ڵ�ǰϵͳʱ�䣡'
      end ;
    end ;

    if msg<>'' then
    begin
      if Grid.SelectedRows.Count>1 then
        strMsg:=Newline(strMsg)+'��ǰѡ����'+inttoStr(SelectedRowNo+1)+'�У�' +Msg
      else
        strMsg:=Newline(strMsg)+'��ǰ��¼' +Msg
    end;
  end;

  function Inspection(Grid:TDBGridEh;var NowDate:TDateTime):Boolean;
  var
    i:Integer;
    strMsg:string;
  begin                                //  ���ܣ������û���ѡ�����л��Ƕ��У�����Effective���̶�ѡ���ļ�¼�н�����Ч��飬����Υ������Ϣд��strMsg��
    Result:=False;
    with   Grid.DataSource.DataSet   do
    if   Grid.SelectedRows.Count   >   1   then  //����û�ѡ�����������1�������С�
    begin
      try
        DisableControls;
        for   i:= 0 to Grid.SelectedRows.Count - 1 do  //����¼�Ƿ�Ϊ��,�ǿռ��˳�
        begin
          GotoBookmark(pointer(Grid.SelectedRows.Items[i]));
          Effective(Grid,strMsg,NowDate,i);
        end;
      finally
        EnableControls;
      end;
    end
    else
      begin
        Effective(Grid,strMsg,NowDate);
      end;
    if strMsg<>'' then
    begin
      ShowMessage(strMsg);
      Result:=True;
    end;
  end;
  procedure Exec(var NowDate:TDateTime;strReason:string);
  begin
    with cdsRead do
    begin
      Close;                                                     //FormatDateTime('yyyy-m-d h:n:s',NowDate)
      CommandText:='insert into DATA0849([Work_ptr],[stop_begin_date],[remark]) '
      +' values('+cdsChild.FieldByName('rkey').AsString+','+QuotedStr(FormatDateTime('yyyy-m-d h:n:s',NowDate))+','+QuotedStr(strReason)+')';

      Execute;
    end;

    with cdsChild do
    begin
      Edit;
      FieldByName('Status').Value:=6;     //��״̬��Ϊ������ͣ ��     6	����ͣ
      Post;
    end;
  end;
var
//  i:Integer;
  NowDate:TDateTime;
  strReason :string;
  vUsernameRkey,vEmployeeRkey,vUser_rights:string;
begin
  if cds0073.Active=False then
  cds0073.Open;
  
  with cdsChild do
  if (Active)and( not IsEmpty) then
  if GetUserRights(Self,dm.ADOConnection1,vUsernameRkey, vEmployeeRkey,vUser_rights,
  '��Աά�޼�¼��ͣ',cds0073.Lookup('EMPLOYEE_PTR',cdsChildEmpl_ptr.AsInteger,'USER_LOGIN_NAME')) then
  begin
    if (strtoint(vUser_rights)in [2,4])=False then
    begin
      messagedlg('�Բ���,��û��Ȩ�ޣ�',mtinformation,[mbok],0)  ;
      Exit ;
    end;
    if cdsChildEmpl_ptr.AsInteger<> StrToInt(vEmployeeRkey )then
    begin
      messagedlg('�Բ���,��ֻ�ܲ����Լ��Ĺ�ʱ��¼��',mtinformation,[mbok],0)  ;
      Exit ;
    end;

    if InputDlg(Self.Handle,'��ͣ','������ͣԭ��',strReason)=false then   //����û�����ȡ�����˳�
      Exit;

    if State in [dsEdit,dsInsert] then
      Post;

    NowDate:=GetDataBaseSmallDate(DM.cdsRead);

    if  Inspection(dghChild,NowDate) then    //������δͨ�����˳���
      Exit;

    try
      //DisableControls;
      with   dghChild.DataSource.DataSet   do
//      if   dghChild.SelectedRows.Count > 1 then  //����û�ѡ�����������1�������С�
//        begin
//          try
//            try
//              Screen.Cursor := crHourGlass;
//              DM.ADOConnection.BeginTrans;
//              for   i:=   dghChild.SelectedRows.Count   -   1   downto   0   do
//              begin
//                GotoBookmark(pointer(dghChild.SelectedRows.Items[i]));
//                Exec(NowDate,strReason);
//              end;
//              DM.ADOConnection.CommitTrans;
//            finally
//              Screen.Cursor := crDefault;
//            end;
//          except
//            on e:Exception do
//            begin
//              DM.ADOConnection.RollbackTrans;
//              Refresh;
//              ShowMessage('�ύʧ�ܣ�'+#13#10+e.Message);
//            end;
//          end;
//        end
//      else     //����û�ѡ���1�С�
      begin
        try
          try
            Screen.Cursor := crHourGlass;
            DM.ADOConnection1.BeginTrans;
            Exec(NowDate,strReason);
            cdsChild.ApplyUpdates(0);
            DM.ADOConnection1.CommitTrans;
          finally
            Screen.Cursor := crDefault;
          end;
        except
          on e:Exception do
          begin
            DM.ADOConnection1.RollbackTrans;
            Refresh;
            ShowMessage('�ύʧ�ܣ�'+#13#10+e.Message);
          end;
        end;
      end;
    finally
//      DtMain.Refresh;
      SetButtonStatus;       //���������ұ߰�ť��״̬��
    //  EnableControls;
    end;
  end;
end;    }

 {  //����Ϊ�ӱ��ʼ��ͣ�Ĺ��ܣ�����ʱ������
procedure TfrmPlanMain.Button10Click(Sender: TObject);
  procedure Effective(Grid:TDBGridEh;var strMsg:string;NowDate:TDateTime;SelectedRowNo:Integer=0);
  var
    msg,AddSpaces:string;
  begin
    msg:='';
    if Grid.SelectedRows.Count>1 then
      AddSpaces:='               '  //15���ո�      //���к�ѡ�����ʱ����Ϣ�ַ����Ļ᲻һ���������㲻ͬ������
    else
      AddSpaces:='        ';  //8 ���ո�

    with cdsRead do
    begin
      Close;
      CommandText:='select * from DATA0843 where Work_ptr='+ cdsChild.FieldByName('rkey').AsString
        +' and [stop_end_date] is null and [stop_begin_date]>='+QuotedStr(FormatDateTime('yyyy-m-d h:n:s',NowDate));
    //    ShowMessage(SQL.Text);
      Open;
      if IsEmpty=False then
      begin
        msg:=Newline(msg,AddSpaces)+'�С���ͣ��ʼʱ�䡱��ֵ���ܴ��ڻ���ڵ�ǰϵͳʱ�䣡'
      end ;
    end ;

    if msg<>'' then
    begin
      if Grid.SelectedRows.Count>1 then
        strMsg:=Newline(strMsg)+'��ǰѡ����'+inttoStr(SelectedRowNo+1)+'�У�' +Msg
      else
        strMsg:=Newline(strMsg)+'��ǰ��¼' +Msg
    end;
  end;

  function Inspection(Grid:TDBGridEh;var NowDate:TDateTime):Boolean;
  var
    i:Integer;
    strMsg:string;
  begin   // ���ܣ������û���ѡ�����л��Ƕ��У�����Effective���̶�ѡ���ļ�¼�н�����Ч��飬����Υ������Ϣд��strMsg��
    Result:=False;
    with   Grid.DataSource.DataSet   do
    if   Grid.SelectedRows.Count   >   1   then  //����û�ѡ�����������1�������С�
    begin
      try
        DisableControls;
        for   i:= 0 to Grid.SelectedRows.Count - 1 do  //����¼�Ƿ�Ϊ��,�ǿռ��˳�
        begin
          GotoBookmark(pointer(Grid.SelectedRows.Items[i]));
          Effective(Grid,strMsg,NowDate,i);
        end;
      finally
        EnableControls;
      end;
    end
    else
      begin
        Effective(Grid,strMsg,NowDate);
      end;
    if strMsg<>'' then
    begin
      ShowMessage(strMsg);
      Result:=True;
    end;
  end;

  procedure Exec(var NowDate:TDateTime);
  var
    Sum_Date:Real;
  begin
    Sum_Date:=0;
    with frmPlanMain3.cdsMain do
    begin
      Close;
      Params.ParamByName('vWork_ptr').Value:=cdsChildrkey.Value;
      Open;
      if IsEmpty=False then
      begin
        Last;               //���ݼ��ƶ������һ�С�
        if FieldByName('stop_end_date').IsNull then
        begin
          Edit;
          FieldByName('stop_end_date').Value:=  FormatDateTime('yyyy-m-d h:n:s',NowDate);
          Post;
        end;
        Sum_Date:=0;
        while not bof do
        begin
          DM.qry0843ResultTime.Close;
          DM.qry0843ResultTime.Parameters.ParamByName('vbeginTime').Value:=FieldByName('stop_begin_date').Value;
          DM.qry0843ResultTime.Parameters.ParamByName('vEndTime').Value:=FieldByName('stop_end_date').Value;
          DM.qry0843ResultTime.Open;
          if DM.qry0843ResultTime.FieldList[0].IsNull=False then
          Sum_Date:= DM.qry0843ResultTime.FieldList[0].Value;
          Prior;
        end;
      end;
    end;

    with cdsChild do
    begin
      Edit;
      FieldByName('Status').Value:=3;     //��״̬��Ϊ��ִ���� ��     3	ִ����
      FieldByName('TimeCons').Value :=Sum_Date;// DM.ADOQuery1.Fields[0].Value;  //��ͣʱ��
      Post;
      //ApplyUpdates(0);
    end;
//    DM.ADOQuery1.Close;
  end;
var
//  i:Integer;
  NowDate:TDateTime;
  vUsernameRkey,vEmployeeRkey,vUser_rights:string;
  vNUMBER:string;
begin
  if cds0073.Active=False then
  cds0073.Open;
  
  with cdsChild do
  if (Active)and( not IsEmpty) then
  if GetUserRights(Self,dm.ADOConnection1,vUsernameRkey, vEmployeeRkey,vUser_rights,
  '��ͣ����',cds0073.Lookup('EMPLOYEE_PTR',cdsChildEmpl_ptr.AsInteger,'USER_LOGIN_NAME')) then
  begin
    if (strtoint(vUser_rights)in [2,4])=False then
    begin
      messagedlg('�Բ���,��û��Ȩ�ޣ�',mtinformation,[mbok],0)  ;
      Exit ;
    end;
    if cdsChildEmpl_ptr.AsInteger<> StrToInt(vEmployeeRkey )then
    begin
      messagedlg('�Բ���,��ֻ�ܲ����Լ��Ĺ�ʱ��¼��',mtinformation,[mbok],0)  ;
      Exit ;
    end;

    if State in [dsEdit,dsInsert] then
      Post;

    if EmployeeStatusCheck(vEmployeeRkey,vNUMBER) then
    begin
      Exit;
    end;

    NowDate:=GetDataBaseSmallDate(DM.cdsRead);

    if  Inspection(dghChild,NowDate) then    //������δͨ�����˳���
      Exit;

    try
      DisableControls;
      with   dghChild.DataSource.DataSet   do
//      if   dghChild.SelectedRows.Count > 1 then  //����û�ѡ�����������1�������С�
//        begin
//          try
//            try
//              Screen.Cursor := crHourGlass;
//              DM.ADOConnection.BeginTrans;
//              for   i:=   dghChild.SelectedRows.Count   -   1   downto   0   do
//              begin
//                GotoBookmark(pointer(dghChild.SelectedRows.Items[i]));
//                Exec(NowDate);
//              end;
//              DM.ADOConnection.CommitTrans;
//            finally
//              Screen.Cursor := crDefault;
//            end;
//          except
//            on e:Exception do
//            begin
//              DM.ADOConnection.RollbackTrans;
//              Refresh;
//              ShowMessage('�ύʧ�ܣ�'+#13#10+e.Message);
//            end;
//          end;
//        end
//      else     //����û�ѡ���1�С�
      begin
        try
          try
            Screen.Cursor := crHourGlass;
            DM.ADOConnection1.BeginTrans;
            Exec(NowDate);
            cdsChild.ApplyUpdates(0);
            DM.ADOConnection1.CommitTrans;
          finally
            Screen.Cursor := crDefault;
          end;
        except
          on e:Exception do
          begin
            DM.ADOConnection1.RollbackTrans;
            Refresh;
            ShowMessage('�ύʧ�ܣ�'+#13#10+e.Message);
          end;
        end;
      end;
    finally
//      DtMain.Refresh;
      SetButtonStatus;       //���������ұ߰�ť��״̬��
      EnableControls;
    end;
  end;

end;     }

procedure TfrmPlanMain.Button11Click(Sender: TObject);
  procedure Exec(NowDate:TDateTime);
  begin
    with cdsChild do
    begin
      Edit;
      FieldByName('Status').Value:=7;     //��״̬��Ϊ7	�ѽ���
      if FieldByName('EndTime').IsNull then  //��� '������ʼʱ��'�ǿգ���ȡ��ǰ���ݿ��������ʱ��
        FieldByName('EndTime').value:= NowDate;

      Post;
    end;
  end;
var
  NowDate:TDateTime;
  IsLast:Boolean;
  f_Staff_Sum_house :real;
  strReason:string;
  vUsernameRkey,vEmployeeRkey,vUser_rights:string;
  BeginTime,endTime,S:Integer;
begin
  if (cdsChild.Active=False)or(  cdsChild.IsEmpty) then
  Exit;

  if (cdsChildBeginTime.IsNull=False) then
    BeginTime:= HourOf(cdsChildBeginTime.AsDateTime);

  if (cdsChildEndTime.IsNull=False) then
    endTime:= HourOf(cdsChildEndTime.AsDateTime)
  else
    endTime:= HourOf(Now);
  if cdsChildBeginTime.IsNull =False then
  begin
    if  cdsChildEndTime.IsNull=False then
    begin
      if  cdsChildEndTime.Value<cdsChildBeginTime.Value then
      begin
        ShowMessage('�������ڲ���С�ڿ�ʼ���ڣ�����');
        Exit;
      end;
    end
    else
    begin
      if  Now<cdsChildBeginTime.Value then
      begin
        ShowMessage('�������ڲ���С�ڿ�ʼ���ڣ�����');
        Exit;
      end;
    end;
  end  ;
  if cdsChildEndTime.IsNull then
    NowDate:=GetDataBaseDate(cdsRead,1)
  else
    NowDate:=  cdsChildEndTime.Value ;
  if ((BeginTime<8) and  (endTime>=8))or(MinutesBetween(cdsChildBeginTime.Value,NowDate)>720) then
  begin
    S:=Show_Msg(Self,'������ȷ����İ��',['']);

    if s=1 then
      begin

      end
    else
    if  S=2 then
      begin
        if  cdsChild.State<>dsEdit then    cdsChild.Edit   ;
        cdsChild.FieldByName('DayShift').Value:=2 ;
      end
    else
      Exit;
  end;

  with cdsMain do
  if (State =dsEdit) then
  begin
    Post;
  end;

  if cdsChild.State in [dsEdit,dsInsert] then
    cdsChild.Post;

  NowDate:=GetDataBaseDate(cdsRead,1);

  if  cdsChildEndTime.IsNull=False then
  if  cdsChildEndTime.Value<=cdsChildBeginTime.Value then
  begin
    MsgError('����ʱ�䲻��С�ڻ���ڿ�ʼʱ�䣡����');
    Exit;
  end;
  try
    Screen.Cursor := crHourGlass;

    DM.cdsRead1.Data:=(cdsChild.Data);
    with DM.cdsRead1 do    //����Ƿ�ֻ��һ��������δ��״̬
    begin
      IsLast:=True;
      First;
      while not Eof do
      begin                     //�������״̬�����ڡ��ѽ�����,�Ҳ��ǵ�ǰѡ���У�����ѭ��
        if (FieldByName('Status').AsInteger<>7)
             and (FieldByName('rkey').AsInteger<>cdsChild.FieldByName('rkey').AsInteger) then
        begin
          islast:=False;
          break;
        end;
        Next;
      end;
    end;
    if IsLast=False then
      begin
        with cds0073 do
        if  Active=False  then
        Open;

        if GetUserRights(Self,DM.ADOConnection1,vUsernameRkey, vEmployeeRkey,vUser_rights,
                 '��Ա������¼����',cds0073.Lookup('EMPLOYEE_PTR',cdsChildEmpl_ptr.AsInteger,'USER_LOGIN_NAME')) then
        begin
          if (strtoint(vUser_rights)in [2,3,4])=False then
          begin
            messagedlg('�Բ���,��û�н�����Ա��Ȩ�ޣ�',mtinformation,[mbok],0)  ;
            Exit ;
          end;
          if cdsChildEmpl_ptr.AsInteger<> StrToInt(vEmployeeRkey )then
          begin
            messagedlg('�Բ���,��ֻ�ܲ����Լ��Ĺ�ʱ��¼��',mtinformation,[mbok],0)  ;
            Exit ;
          end;
          Exec(NowDate)   ;
          cdsChild.ApplyUpdates(0);
        end;
      end
    else
    begin
      if messagedlg('�������һ��״̬�ǡ�ִ���С��Ĺ�Ա��¼����Ҫ�깤�ñ�������?'+#13
                 +'�깤��YES����ͣ��NO��',mtconfirmation,[mbyes,mbno],0)=mrYes then
        begin
          if (cdsMainRemarks.IsNull)or(cdsMainRemarks.Value='')  then
          begin
            MsgError('�ֶΡ�'+cdsMainRemarks.DisplayLabel+'����ֵ����Ϊ�գ�����');
            cxPageControl1.ActivePageIndex:=1;
            mo_Remarks.SetFocus;
            Exit;
          end;
          with cds0073 do
          if  Active=False  then
          Open;
          if GetUserRights(Self,DM.ADOConnection1,vUsernameRkey, vEmployeeRkey,vUser_rights,
              '�������깤',cds0073.Lookup('EMPLOYEE_PTR',cdsChildEmpl_ptr.AsInteger,'USER_LOGIN_NAME')) then
          begin
            if (strtoint(vUser_rights)in [2,3,4])=False then
            begin
              messagedlg('�Բ���,��û�н�����Ա��Ȩ�ޣ�',mtinformation,[mbok],0)  ;
              Exit ;
            end;
            if cdsChildEmpl_ptr.AsInteger<> StrToInt(vEmployeeRkey )then
            begin
              messagedlg('�Բ���,��ֻ�ܲ����Լ��Ĺ�ʱ��¼��',mtinformation,[mbok],0)  ;
              Exit ;
            end;

            try
              DM.ADOConnection1.BeginTrans;
              Exec(NowDate);
              with cdsMain do
              begin
                Edit;
                FieldByName('RKEY832').Value:=4;     //��״̬��Ϊ����ִ�� ��
                if (FieldByName('ActuCompTime').IsNull)or(FieldByName('ActuCompTime').AsString='') then  //��� '������ʼʱ��'�ǿգ���ȡ��ǰ���ݿ��������ʱ��
                    FieldByName('ActuCompTime').value:= NowDate;                         //��ֵ�ᴥ��cdsMainActuCompTimeChange�¼��������档
                                                                                 //�ر�˵������D2010�Ŀ��������£��������Ĳ���ֵ�������ַ���Ҫ��������������������Ϊ WideString,������ܻ��������ط����ҵ���������Сʱ����
//                ������Ҫ�󣬱����ƻ���֪ͨ����ʱ���Ϳ�ʼ������һ�εı����ƻ�����ˣ���δ������ߡ�
//                cmdUpdate.Parameters.ParamByName('v1PlanMainDate').Value:=DateToStr(cdsMain.FieldByName('PlanMainDate').Value);
//                cmdUpdate.Parameters.ParamByName('v2MainCycl').Value:=cdsMain.FieldByName('MainCycl').Value;
//                cmdUpdate.Parameters.ParamByName('v3DeviNumb').Value:=cdsMain.FieldByName('DeviNumb').Value;
//                cmdUpdate.Parameters.ParamByName('v4MainCycl').Value:=cdsMain.FieldByName('MainCycl').Value;
//                cmdUpdate.Parameters.ParamByName('v5DeviNumb').Value:=cdsMain.FieldByName('DeviNumb').Value;
//                cmdUpdate.Parameters.ParamByName('v7MainCycl').Value:=cdsMain.FieldByName('MainCycl').Value;
//                cmdUpdate.Execute;
              end;
              cdsRead.Close;               //�رպ����¸������ݡ�
              cdsRead.Data:=(cdsChild.Data);
              with cdsRead do
              begin
                First;
                f_Staff_Sum_house:=0;
                while not Eof do
                begin
                  if FieldByName('WorkTime').Value>0  then    //����ʱ��
                  f_Staff_Sum_house:= f_Staff_Sum_house+ FieldByName('WorkTime').Value;
                  Next;
                end;
                cdsMainTimeCons.Value:=  f_Staff_Sum_house ;
              end;
              cdsMain.Post;

              if cdsMain.ApplyUpdates(0)=0 then
              begin
                if cdsChild.ApplyUpdates(0)<>0 then
                dm.ADOConnection1.RollbackTrans;
              end
              else
                dm.ADOConnection1.RollbackTrans;

              DM.ADOConnection1.CommitTrans;
            except
              on e:Exception do
              begin
                DM.ADOConnection1.RollbackTrans;
                cdsChild.Refresh;
                MsgError('�ύʧ�ܣ�'+#13#10+e.Message);
              end
            end;
          end;
        end
      else
        begin
          if InputDlg(Self.Handle,'��ͣ','������ͣԭ��',strReason) then
          try
            with cds0073 do
            if  Active=False  then
            Open;
            if GetUserRights(Self,DM.ADOConnection1,vUsernameRkey, vEmployeeRkey,vUser_rights,
            '��������ͣ',cds0073.Lookup('EMPLOYEE_PTR',cdsChildEmpl_ptr.AsInteger,'USER_LOGIN_NAME')) then
            begin
              if (strtoint(vUser_rights)in [2,3,4])=False then
              begin
                messagedlg('�Բ���,��û�н�����Ա��Ȩ�ޣ�',mtinformation,[mbok],0)  ;
                Exit ;
              end;
              if cdsChildEmpl_ptr.AsInteger<> StrToInt(vEmployeeRkey )then
              begin
                messagedlg('�Բ���,��ֻ�ܲ����Լ��Ĺ�ʱ��¼��',mtinformation,[mbok],0)  ;
                Exit ;
              end;
            end;
            DM.ADOConnection1.BeginTrans;
            Exec(NowDate);
            with cdsMain do
            begin
              Edit;
              FieldByName('RKEY832').Value:=6;
              Post;
              if ApplyUpdates(0)=0 then
              begin
                if cdsChild.ApplyUpdates(0)=0 then
                begin
                  with cdsRead do
                  begin
                    Close;
                    CommandText:='insert into dbo.DATA0833(rkey831,stop_begin_date,remark) values('
                                                          +cdsMainRkey.AsString+',getdate(),'+QuotedStr(strReason)+')';
                    Execute;
                  end;
                  DM.ADOConnection1.CommitTrans;
                end
                else
                  DM.ADOConnection1.RollbackTrans;
              end
              else
              begin
                DM.ADOConnection1.RollbackTrans;
              end;
            end;
          except
            DM.ADOConnection1.RollbackTrans;
          end;
        end;
    end;
  finally
    Screen.Cursor := crDefault;
    dsMainStateChange(nil);
    SetButtonStatus;       //���������ұ߰�ť��״̬��
  end;

end;

procedure TfrmPlanMain.cdsChildStatusChange(Sender: TField);
begin
  inherited;
  with cds832 do
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
      cdsChild.FieldByName('MainExecStat').Value:=null;
    end
    else
    begin
      if Locate('rkey',Sender.Value,[loCaseInsensitive]) then
        begin
        cdsChildMainexecStat.Value := FieldByName('MainExecStat').Value ;
        end
      else
        begin
        cdsChild.FieldByName('MainExecStat').Value:=null;
        end;
    end;
  end;
end;

procedure TfrmPlanMain.btn_DeleteClick(Sender: TObject);
var
  vUsernameRkey,vEmployeeRkey,vUser_rights:string;
  UniqueRecord:Boolean;
begin
  UniqueRecord:=False;
  if cds0073.Active=False then
  cds0073.Open;
  with cdsChild do
  if (Active)and( not IsEmpty) then
  begin
    if recordcount=1 then
    begin
      if  messagedlg('Ψһ�����˼���ɾ������ȷ����ά�޵����˻ص�������״̬��?',mtconfirmation,[mbyes,mbcancel],0)=mrCancel then
      begin
        Exit;
      end
      else
      begin
        UniqueRecord:=True;
      end;
    end;
    if GetUserRights(Self,DM.ADOConnection1,vUsernameRkey, vEmployeeRkey,vUser_rights,'ɾ��',
      cds0073.Lookup('EMPLOYEE_PTR',cdsChildEmpl_ptr.AsInteger,'USER_LOGIN_NAME')) then
    begin
      if (strtoint(vUser_rights)in [2,3,4])=False then
      begin
        messagedlg('�Բ���,��û��Ȩ�ޣ�',mtinformation,[mbok],0)  ;
        Exit ;
      end;
      if cdsChildEmpl_ptr.AsInteger<> StrToInt(vEmployeeRkey )then
      begin
        messagedlg('�Բ���,��ֻ�ܲ����Լ��Ĺ�ʱ��¼��',mtinformation,[mbok],0)  ;
        Exit ;
      end;
      if UniqueRecord then
      begin
        cdsMain.Edit;
        cdsMain.FieldByName('RKEY832').Value:=5;   //��Ϊ��֪ͨ
        cdsMain.Post;
        if cdsMain.ApplyUpdates(0) =0 then
        begin
          Delete;
          ApplyUpdates(0);
          SetButtonStatus;
          dsMainStateChange(nil);
        end;
      end
      else
      begin
      Delete;
      ApplyUpdates(0);
      SetButtonStatus;
      dsMainStateChange(nil);
      end
    end;
  end;
end;

procedure TfrmPlanMain.N_StartMainClick(Sender: TObject);
begin
  inherited;
  if messagebox(Self.Handle,'��ȷ��Ҫ��ʼ������','ѯ��',MB_yesno+MB_iconquestion)=idNo then
    Exit ;
  StartMaintenance(EmplRKEY);
end;

procedure TfrmPlanMain.Button3MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  ptObject: TPoint;
begin
  with TButton(Sender) do
  ptObject := Parent.ClientToScreen(Point(Left,Top ));
  PopupMenuInButton3.Popup(ptObject.X,ptObject.Y);

end;

procedure TfrmPlanMain.N_OtherStartMainClick(Sender: TObject);
var
  vUsernameRkey,vEmployeeRkey,vUser_rights:string;
begin
  inherited;
  if GetUserRights(Self,DM.ADOConnection1,vUsernameRkey, vEmployeeRkey,vUser_rights,'�������û�����') then
  begin
    if (StrToInt(vUser_rights) in[2,3,4])=False then
    begin
      MsgError('��û�����յ�Ȩ�ޣ�');
      Exit;
    end;

    StartMaintenance(StrToInt(vEmployeeRkey)) ;
  end;

end;

procedure TfrmPlanMain.cdsChildEndTimeChange(Sender: TField);
begin
  inherited;
  QryResultTime.Close;
  QryResultTime.Parameters.ParamByName('vbeginTime').Value:=cdsChildBeginTime.Value;
  QryResultTime.Parameters.ParamByName('vEndTime').Value:=cdsChildEndTime.Value;
  QryResultTime.Open;
  cdsChildTimeRest.Value:= QryResultTime.FieldList[0].Value;
end;

procedure TfrmPlanMain.cdsChildTimeRestChange(Sender: TField);
var
  strSQL:string;
begin
  inherited;
  with  cdsChild do
  if FieldByName('EndTime').IsNull=False then
  begin
    strSQL:='SELECT datediff( minute ,'+QuotedStr(FormatDateTime('yyyy-m-d h:n:s',FieldByName('BeginTime').Value))
         +','+QuotedStr(FormatDateTime('yyyy-m-d h:n:s',FieldByName('EndTime').Value))+' )';
    if FieldByName('TimeRest').Value>0 then   //��;��Ϣʱ��
      strSQL:=strSQL+'-'+  FloatToStr(FieldByName('TimeRest').Value*60) ;
    FieldByName('WorkTime').Value:=StrToFloat(SQLResultValue(cdsRead,strSQL))/60;//ʵ�ʹ���ʱ��
  end;
end;

procedure TfrmPlanMain.Button12Click(Sender: TObject);
begin
  inherited;
  frmPlanMain3.cdsMain.Close;
  frmPlanMain3.cdsMain.Params.ParamByName('vWork_ptr').Value:=cdsChildrkey.Value;
  frmPlanMain3.cdsMain.Open;
  frmPlanMain3.ShowModal;

end;

procedure TfrmPlanMain.dghChildKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key in[VK_INSERT,VK_delete] then   //  , VK_down
  begin
    Key:=0;
  end
  else
  with   (Sender as TDBGridEh ).DataSource.DataSet  do
  if (Key in[VK_down])and(RecNo=RecordCount ) then    //��������¼����ҵ�ǰ��¼�ŵ����ܼ�¼��
  begin
    Key:=0;
  end;
end;

procedure TfrmPlanMain.Button9Click(Sender: TObject);  //��ͣ���� ��ť
var
  strOut:string;
begin           
  inherited;
//��ͣǰҪ�ж��Ƿ���״̬��ִ���еĹ�Ա��¼
  with cdsRead do
  begin
    Data:=cdsChild.Data;
    First;
    while not Eof do
    begin
      if FieldByName('Status').AsInteger=3 then
      begin
        MsgError('��ǰ������������״̬�ǡ�ִ���С��Ĺ�Ա��¼������');
        Exit;
      end;
      Next;
    end;
  end;

  if InputDlg(Self.Handle,'��ͣ','������ͣԭ��',strOut) then
  try
    DM.ADOConnection1.BeginTrans;
    with cdsMain do
    begin
      Edit;
      FieldByName('RKEY832').Value:=6;
      Post;
      if ApplyUpdates(0)=0 then
      begin
        with cdsRead do
        begin
          Close;
          CommandText:='insert into dbo.DATA0833(rkey831,stop_begin_date,remark) values('
                                                +cdsMainRkey.AsString+',getdate(),'+strOut+')';
          Execute;
        end;

      end
      else
      begin
        DM.ADOConnection1.RollbackTrans;
      end;
      dsMainStateChange(nil);
      SetButtonStatus;
    end;
  except
    DM.ADOConnection1.RollbackTrans;
  end;

end;

procedure TfrmPlanMain.Button10MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  ptObject: TPoint;
begin
  with TButton(Sender) do
  ptObject := Parent.ClientToScreen(Point(Left,Top ));
  PopupMenuInButton10.Popup(ptObject.X,ptObject.Y);

end;

procedure TfrmPlanMain.Exec_EndPauseClick(vEmployeeRkey:string);
var
  vNUMBER:string;
begin
  if EmployeeStatusCheck(vEmployeeRkey,vNUMBER) then
  begin
    Exit;
  end;

  if cdsChild.IsEmpty=False then
  with cdsRead do
  begin
    Close;
    CommandText:='select rkey from data0848 where [Work_ptr]='+cdsMainrkey.AsString
    +' and Empl_ptr='+vEmployeeRkey+' and EndTime>=getDate()' ;
    Open;
    if IsEmpty=False then
    begin
      MsgError('�޷�����µĹ�Ա��¼����Ϊ���εĿ�ʼʱ�䲻��С�ڻ�����ϴεĽ���ʱ�䣡����');
      Exit;
    end;
  end;
  
  try
    with cdsChild do
    if Active then
    begin
      Append;
      if cds0005.Active=False then
        cds0005.Open;
      if cds0005.Locate('rkey',vEmployeeRkey,[])   then
      begin
        FieldByName('Work_ptr').Value:=cdsMainrkey.Value;
        FieldByName('WorkDate').Value:=Date;
        FieldByName('BeginTime').Value:=GetDataBaseDate(cdsRead,1);
        FieldByName('Status').Value:=3;
        FieldByName('TimeRest').Value:=2.5;
        FieldByName('Empl_ptr').Value:=cds0005Rkey.Value;
        FieldByName('EMPL_CODE').Value:=cds0005EMPL_CODE.Value;
        FieldByName('EMPLOYEE_NAME').Value:=cds0005EMPLOYEE_NAME.Value;
        Post;

        DM.ADOConnection1.BeginTrans;
        if ApplyUpdates(0) =0 then
        begin
          cdsMain.Edit;
          cdsMain.FieldByName('RKEY832').Value:=3;
          cdsMain.Post;
          if cdsMain.ApplyUpdates(0) =0 then
          begin
            with cdsRead do
            begin
              Close;          //����ͣ��¼�Ľ���ʱ����д��
              CommandText:='update dbo.DATA0833 set stop_end_date=getdate() where rkey831='+cdsMainrkey.AsString +' and stop_end_date is null';
              Execute;
            end;
            DM.ADOConnection1.CommitTrans;
          end
          else
          begin
            DM.ADOConnection1.RollbackTrans;
          end;
        end
        else
        begin
          DM.ADOConnection1.RollbackTrans;
        end;

      end;
      SetButtonStatus;
      dsMainStateChange(nil);
    end;
  except
    DM.ADOConnection1.RollbackTrans;
  end;
end;
procedure TfrmPlanMain.N_EndPauseClick(Sender: TObject);

begin
  inherited;   //   ��ͣ����
  if messagebox(Self.Handle,'��ȷ��Ҫ��ͣ������','ѯ��',MB_yesno+MB_iconquestion)=idNo then
  Exit ;
  Exec_EndPauseClick(IntToStr(EmplRKEY)) ;
end;

procedure TfrmPlanMain.N_OtherEndPauseClick(Sender: TObject);
var
  vUsernameRkey,vEmployeeRkey,vUser_rights:string;
begin
  inherited;
  if GetUserRights(Self,DM.ADOConnection1,vUsernameRkey, vEmployeeRkey,vUser_rights,'�������û���ͣ����') then
  begin
    if (StrToInt(vUser_rights) in[2,3,4])=False then
    begin
      MsgError('��û����ͣ������Ȩ�ޣ�');
      Exit;
    end;

    Exec_EndPauseClick(vEmployeeRkey) ;
  end;
end;

procedure TfrmPlanMain.Button6Click(Sender: TObject);
begin
  inherited;     //������¼ ��ť
  if Assigned(frmPlanMain01)=False then
  begin
    Application.CreateForm(TfrmPlanMain01, frmPlanMain01);
  end;
  with  frmPlanMain01 do
  begin
    cdsMain.Close;
    cdsMain.CommandText:= cdsMain.F_SQLSelectFrom+#13
      +'where d31.DeviNumb='+QuotedStr(Self.cdsMainDeviNumb.AsString) +' and d31.MainCycl='+QuotedStr(Self.cdsMainMainCycl.AsString);
    cdsMain.Open;
    ShowModal;
  end;
end;

procedure TfrmPlanMain.cdsMainCalcFields(DataSet: TDataSet);
begin
  inherited;
  with DataSet do
  begin
    if (cdsMainStdTimeCons.Value>0)and(cdsMainTimeCons.Value>0) then
    FieldByName('Accomplish').Value:=
       FieldByName('TimeCons').Value/FieldByName('StdTimeCons').Value ;

  end;                                          
end;

procedure TfrmPlanMain.cdsMainAccomplishGetText(Sender: TField;
  var Text: String; DisplayText: Boolean);
begin
  inherited;
  Text := FloatToStr(round(Sender.AsFloat * 10000)/100) + '%';
end;

procedure TfrmPlanMain.DghMainKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key in[VK_INSERT,VK_delete] then   //  , VK_down
  begin
    Key:=0;
  end
  else
  with   (Sender as TDBGridEh ).DataSource.DataSet  do
  if (Key in[VK_down])and(RecNo=RecordCount ) then    //��������¼����ҵ�ǰ��¼�ŵ����ܼ�¼��
  begin
    Key:=0;
  end;
end;

procedure TfrmPlanMain.Button13Click(Sender: TObject);
begin
  inherited;
  with cdsMain do
  begin
    Edit;
    FieldByName('RKEY832').Value:=5;                  //��״̬��Ϊ����֪ͨ��
    Post;
    ApplyUpdates(0);
  end;
end;

procedure TfrmPlanMain.Button14Click(Sender: TObject);
begin
  inherited;
  if Assigned(frmPlanMain04)=False then
  Application.CreateForm(TfrmPlanMain04, frmPlanMain04);
  frmPlanMain04.cdsMain.Open;
  
  frmPlanMain04.ShowModal;
end;

procedure TfrmPlanMain.Button15Click(Sender: TObject);
begin
  inherited;
  if Assigned(frmPlanMain05)=False then
  Application.CreateForm(TfrmPlanMain05, frmPlanMain05);

  frmPlanMain05.ShowModal;
end;

procedure TfrmPlanMain.cdsMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  cdsMain.Locate('PlanMainDate',DateToStr(Now),[loPartialKey])  ;
end;

procedure TfrmPlanMain.FormShow(Sender: TObject);
begin
  inherited;
  var_DropDown_Info:=TDropDownInfo.Create();
  with var_DropDown_Info do
  begin
    L_SourceDataSet         :=cdsMain;
    L_GridName              :=DghMain;
    L_ColsInfo              :='FASSET_CODE/�豸����/100,FASSET_NAME/�豸����/200,FASSET_DESC/�豸����/150,DEPT_CODE/���Ŵ���/50,DEPT_NAME/��������/80';
    L_FindDataSet           :=cds0417;
    L_DropdownColumn        :='DeviNumb';
    L_ListDataSetFilterField:='FASSET_CODE';
    L_ListResultField       :='FASSET_CODE';
    L_GetValueField         :='DeviNumb';
//    L_SourceField           :=varArrayOf(['createBy_PTR','EMPLOYEE_NAME']);
//    L_ResultField           :=varArrayOf(['rkey','EMPLOYEE_NAME']);
//    DropDownInfo_Init(var_DropDown_Info);
  end;
  DropDown_Info_List.Add(var_DropDown_Info) ;

  var_DropDown_Info:=TDropDownInfo.Create();
  with var_DropDown_Info do
  begin
    L_SourceDataSet         :=cdsMain;
    L_GridName              :=DghMain;
   // L_ColsInfo:='EMPL_CODE/��Ա����/80,EMPLOYEE_NAME/��Ա����/120'; // rkey//0,
    L_FindDataSet           :=cds0015;
    L_DropdownColumn        :='ABBR_NAME';
    L_ListDataSetFilterField:='ABBR_NAME';
    L_ListResultField       :='ABBR_NAME';
    L_GetValueField         :='ABBR_NAME';
//    L_SourceField           :=varArrayOf(['createBy_PTR','EMPLOYEE_NAME']);
//    L_ResultField           :=varArrayOf(['rkey','EMPLOYEE_NAME']);
//    DropDownInfo_Init(var_DropDown_Info);
  end;
  DropDown_Info_List.Add(var_DropDown_Info) ;

  var_DropDown_Info:=TDropDownInfo.Create();
  with var_DropDown_Info do
  begin
    L_SourceDataSet         :=cdsMain;
    L_GridName              :=DghMain;
   // L_ColsInfo:='EMPL_CODE/��Ա����/80,EMPLOYEE_NAME/��Ա����/120'; // rkey//0,
    L_FindDataSet           :=cds840;
    L_DropdownColumn        :='d40_Location';
    L_ListDataSetFilterField:='Location';
    L_ListResultField       :='Location';
    L_GetValueField         :='d40_Location';
//    L_SourceField           :=varArrayOf(['createBy_PTR','EMPLOYEE_NAME']);
//    L_ResultField           :=varArrayOf(['rkey','EMPLOYEE_NAME']);
//    DropDownInfo_Init(var_DropDown_Info);
  end;
  DropDown_Info_List.Add(var_DropDown_Info) ;

  var_DropDown_Info:=TDropDownInfo.Create();
  with var_DropDown_Info do
  begin
    L_SourceDataSet         :=cdsMain;
    L_GridName              :=DghMain;
   // L_ColsInfo:='EMPL_CODE/��Ա����/80,EMPLOYEE_NAME/��Ա����/120'; // rkey//0,
    L_FindDataSet           :=cds832;
    L_DropdownColumn        :='MainExecStat';
    L_ListDataSetFilterField:='MainExecStat';
    L_ListResultField       :='MainExecStat';
    L_GetValueField         :='MainExecStat';
//    L_SourceField           :=varArrayOf(['createBy_PTR','EMPLOYEE_NAME']);
//    L_ResultField           :=varArrayOf(['rkey','EMPLOYEE_NAME']);
//    DropDownInfo_Init(var_DropDown_Info);
  end;
  DropDown_Info_List.Add(var_DropDown_Info) ;

  var_DropDown_Info:=TDropDownInfo.Create();
  with var_DropDown_Info do
  begin
    L_SourceDataSet         :=cdsMain;
    L_GridName              :=DghMain;
   // L_ColsInfo:='EMPL_CODE/��Ա����/80,EMPLOYEE_NAME/��Ա����/120'; // rkey//0,
    L_FindDataSet           :=cds0034;
    L_DropdownColumn        :='DEPT_NAME';
    L_ListDataSetFilterField:='DEPT_NAME';
    L_ListResultField       :='DEPT_NAME';
    L_GetValueField         :='DEPT_NAME';
//    L_SourceField           :=varArrayOf(['createBy_PTR','EMPLOYEE_NAME']);
//    L_ResultField           :=varArrayOf(['rkey','EMPLOYEE_NAME']);
//    DropDownInfo_Init(var_DropDown_Info);
  end;
  DropDown_Info_List.Add(var_DropDown_Info) ;
end;

end.
