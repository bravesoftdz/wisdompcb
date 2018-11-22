unit FileGroup;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, MC_unt, ADODB, DB, RzEdit, RzDBEdit, RzDBBnEd, DBButtonEdit,
  DBCtrls, DBCtrlsEh, StdCtrls, Mask, Buttons, Menus, cds, ImgList,
  ppEndUsr, ppBands, ppPrnabl, ppClass, ppCtrls, ppCache, ppProd, ppReport,
  ppComm, ppRelatv, ppDB, ppDBPipe, DBClient, Provider, Grids, DBGridEh,
  ComCtrls, ExtCtrls, RzPanel, RzButton,
  DateUtils,ShellAPI,StrUtils;  

type
  TFileGroup_f = class(TMC_frm)
    cdsChildrkey: TAutoIncField;
    cdsChildD805_ptr: TIntegerField;
    cdsChildFileType: TSmallintField;
    cdsChildRemarks: TStringField;
    cds0023: TClientDataSet;
    cds0023RKEY: TIntegerField;
    cds0023CODE: TStringField;
    cds0023ABBR_NAME: TStringField;
    cdsMainCODE: TStringField;
    cdsMainABBR_NAME: TStringField;
    cdsMainUSER_FULL_NAME: TStringField;
    cdsMainrkey: TAutoIncField;
    cdsMainD023_ptr: TIntegerField;
    cdsMainINV_Type: TStringField;
    cdsMainModel: TStringField;
    cdsMainTestDate: TDateTimeField;
    cdsMainEffeDate: TDateTimeField;
    cdsMainStatus: TSmallintField;
    cdsMainTemporTo: TDateTimeField;
    cdsMainD073_ptr: TIntegerField;
    cdsMainEntrTime: TDateTimeField;
    cdsMainRemarks: TStringField;
    dtMainCODE: TStringField;
    dtMainABBR_NAME: TStringField;
    dtMainUSER_FULL_NAME: TStringField;
    dtMainrkey: TAutoIncField;
    dtMainD023_ptr: TIntegerField;
    dtMainINV_Type: TStringField;
    dtMainModel: TStringField;
    dtMainTestDate: TDateTimeField;
    dtMainEffeDate: TDateTimeField;
    dtMainStatus: TWordField;
    dtMainTemporTo: TDateTimeField;
    dtMainD073_ptr: TIntegerField;
    dtMainEntrTime: TDateTimeField;
    dtMainRemarks: TStringField;
    dtMainTemporBy: TBooleanField;
    cdsMainTemporBy: TBooleanField;
    cdsMainRepoVali: TStringField;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    qryTemp: TADOQuery;
    cdsChildFileName: TStringField;
    cds_INV_Type: TClientDataSet;
    cds_INV_TypeINV_Type: TStringField;
    dtMainINV_Name: TStringField;
    cdsMainINV_Name: TStringField;
    dtMainRoHsFree: TStringField;
    cdsMainRoHsFree: TStringField;
    btn_Open: TButton;
    btn_Upload: TButton;
    bt_Expand: TButton;
    bt_Confirm: TButton;
    bt_Return: TButton;
    bt_UConfirm: TButton;
    btn_TemporarilyBy: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    edt_ABBR_NAME: TDBEdit;
    edt_Model: TDBEdit;
    edt_RepoVali: TDBEdit;
    edt_Status: TDBEdit;
    edt_TemporTo: TDBEdit;
    edt_USER_FULL_NAME: TDBEdit;
    edt_EntrTime: TDBEdit;
    DBMemo_Remarks: TDBMemo;
    dbDate_TestDate: TDBDateTimeEditEh;
    dbDate_EffeDate: TDBDateTimeEditEh;
    DBCheckBox_TemporBy: TDBCheckBox;
    edt_CODE: TDBButtonEdit;
    edt_INV_Type: TDBButtonEdit;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    edt_FileName: TDBEdit;
    DBMemo2_Remarks: TDBMemo;
    DBComboBox_FileType: TDBComboBox;
    BtFind: TSpeedButton;
    GroupBox1: TGroupBox;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    GroupBox2: TGroupBox;
    Filter_Label: TLabel;
    Filter_Edit: TEdit;
    GroupBox3: TGroupBox;
    CheckBox_Status1: TCheckBox;
    CheckBox_Status2: TCheckBox;
    CheckBox_Status3: TCheckBox;
    CheckBox_Status4: TCheckBox;
    CheckBox_Status5: TCheckBox;
    dt0023: TADODataSet;
    dt0023RKEY: TAutoIncField;
    dt0023CODE: TStringField;
    dt0023ABBR_NAME: TStringField;
    btn_ToCancel: TButton;
    Button2: TButton;
    Button3: TButton;
    cdsMainv_Status: TStringField;
    CheckBox_Status6: TCheckBox;
    dt_INV_Type: TADODataSet;
    dt_INV_TypeINV_Type: TStringField;
    dtMainSGS_NO: TStringField;
    cdsMainSGS_NO: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure cdsMainCODEChange(Sender: TField);
    procedure cdsMainNewRecord(DataSet: TDataSet);
    procedure cdsMainTestDateChange(Sender: TField);
    procedure cdsMainCurrentDateCalcFields(DataSet: TDataSet);
    procedure DghMainGetCellParams(Sender: TObject; Column: TColumnEh;
      AFont: TFont; var Background: TColor; State: TGridDrawState);
    procedure cdsMainRepoValiGetText(Sender: TField; var Text: String;
      DisplayText: Boolean);
    procedure cdsChildFileTypeGetText(Sender: TField; var Text: String;
      DisplayText: Boolean);
    procedure cdsChildFileTypeSetText(Sender: TField; const Text: String);
    procedure btn_OpenClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
//    procedure actConfirmExecute(Sender: TObject);
//    procedure actUConfirmExecute(Sender: TObject);
    procedure btn_UploadClick(Sender: TObject);
    procedure btn_TemporarilyByClick(Sender: TObject);
    procedure btn_ToCancelClick(Sender: TObject);
    procedure cdsMainAfterInsert(DataSet: TDataSet);
    procedure dspMainGetTableName(Sender: TObject; DataSet: TDataSet;
      var TableName: String);
    procedure BtFindClick(Sender: TObject);
    procedure DghMainTitleClick(Column: TColumnEh);
    procedure Filter_EditChange(Sender: TObject);
    procedure cdsMainFilterRecord(DataSet: TDataSet; var Accept: Boolean);
    procedure CheckBox_Status1Click(Sender: TObject);
    procedure cdsMainAfterEdit(DataSet: TDataSet);
    procedure cdsChildAfterEdit(DataSet: TDataSet);
    procedure cdsChildAfterDelete(DataSet: TDataSet);
    procedure bt_ExpandClick(Sender: TObject);
    procedure bt_ConfirmClick(Sender: TObject);
    procedure bt_ReturnClick(Sender: TObject);
    procedure bt_UConfirmClick(Sender: TObject);
    procedure tblSaveClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
  private
    FilterFieldName:string;
    str_FilterText:string;
    CurrentDate:TDateTime;
    procedure Set_ToolbarButtonStatus(Flag: Boolean); override;
    function SaveBeforeCheck ():Boolean;             override;
    procedure SetFilterComponent(Column: TColumnEh);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FileGroup_f: TFileGroup_f;
  const
  TmpFileDir = 'c:\tmp\';

implementation

uses PublicFile,  PubFunc, TemporarilyBy, formInputDlg, LogWrite_unt,
  DM_unt;

{$R *.dfm}

function TFileGroup_f.SaveBeforeCheck():Boolean  ;
var
  strMsg,strSQL,str_Filter:string;
  I_Row :Integer;
begin
  Result:=True;
  with cdsMain do
  begin
    if State in [dsEdit ,dsInsert] then
    Post;
    if FieldByName('D023_ptr').IsNull then
      strMsg:=strMsg+'������ֶΣ���'+FieldByName('ABBR_NAME').DisplayLabel+'����ֵ����Ϊ�գ�����'+#13;
    if (FieldByName('INV_Type').IsNull)or(FieldByName('INV_Type').AsString='') then
      strMsg:=strMsg+'������ֶΣ���'+FieldByName('INV_Type').DisplayLabel+'����ֵ����Ϊ�գ�����'+#13;
    if (FieldByName('Model').IsNull)or(FieldByName('Model').AsString='') then
      strMsg:=strMsg+'������ֶΣ���'+FieldByName('Model').DisplayLabel+'����ֵ����Ϊ�գ�����'+#13;

    if (FieldByName('Model').IsNull=False)or(FieldByName('Model').AsString='')then
    if (UpdateStatus=usInserted)
         or((UpdateStatus=usModified) and ((UpperCase(FieldByName('Model').NewValue)<>UpperCase(FieldByName('Model').OldValue)))
           ) then
    begin
      strSQL:='select * from data0805 where Model='+QuotedStr(FieldByName('Model').NewValue);
      if RecordExists(strSQL,DM_frm.cdsRead)then
      begin
        strMsg:=strMsg+'������ֶΣ���'+FieldByName('Model').DisplayLabel+'����ֵ��'+trim(FieldByName('Model').NewValue)
          +'���Ѿ����ڣ�����'+#13
      end;
    end;
  end;

  if cdsChild.State in [dsEdit ,dsInsert] then     //usModified
  cdsChild.Post;
  with DM_frm.cdsClone do
  try
    Close;
    Data:= cdsChild.Data;
    DisableControls ;
    First;
    for I_Row:=0 to RecordCount-1 do
    begin
      if FieldByName('FileType').IsNull then //���ϱ���
        strMsg:=strMsg+'�ӱ���'+IntToStr(I_Row+1)+'�У��ֶΣ���'+cdsChild.FieldByName('FileType').DisplayLabel+'����ֵ����Ϊ�գ�����'+#13 ;
      Next;
    end;

    if FieldByName('FileType').IsNull=False then  // ��ʾ�ظ���¼����
    begin
      DM_frm.cdsTemp.data:=Data;
      Last;
      for I_Row:=RecordCount-1 downto 0 do
      begin
        str_Filter:= 'FileType='+FieldByName('FileType').AsString;
        DM_frm.cdsTemp.Filter:= str_Filter;
        DM_frm.cdsTemp.Filtered:=True;

        if DM_frm.cdsTemp.RecordCount >=2 then
        begin
          strMsg:=strMsg+'�ӱ���'+IntToStr(I_Row+1)+'�У��ֶΣ���'
          +cdsChild.FieldByName('FileType').DisplayLabel+'����ֵ���ظ�������'+#13 ;
        end;
        while not DM_frm.cdsTemp.Eof do    //�����ļ�¼�����Ǽ���ж����ظ��ļ�¼ȫ��ɾ����
        DM_frm.cdsTemp.Delete;
        DM_frm.cdsTemp.Filtered:=False;
        Prior;
      end;
    end;
  finally
    Close;
    DM_frm.cdsTemp.Close;
  end;

  if strMsg<>'' then
  begin
    MsgError(Copy(strMsg,0,Length(strMsg)-1));
    Result:=False;
  end;
end;

procedure TFileGroup_f.Set_ToolbarButtonStatus(Flag: Boolean);
begin
  if  NeedSave then
  if (cdsMain.F_IsBatchOperating<>True)
              or(cdsChild.F_IsBatchOperating<>True) then
  begin                        //ֻ��������=false ��ʱ�򣬲�ִ�а�ťˢ�¡�
    with   ActiveGridEH.DataSource.DataSet as TClientDataSet do
    begin
      tblAdd.Enabled:=(not Flag) and (StrToInt(vprev)in [2,4]);
      tblEdit.Enabled:=(not Flag) and (StrToInt(vprev)in [2,4])and(IsEmpty=False);
      if ActiveGridEH=DghMain then
      begin
        tblDelete.Enabled:=(not Flag)and(IsEmpty=False) and (StrToInt(vprev)in [2,4])
          and (cdsMainStatus.AsInteger in[1]);
        if cdsMain.Active then
        if (cdsMain.ChangeCount>0)or(cdsMain.State in [dsEdit,dsInsert])    then
        begin
          tblCancel.Enabled:=True;
        end
        else
        begin
          tblCancel.Enabled:=False;
        end;
      end
      else
      if ActiveGridEH=dghChild then
      begin
        tblDelete.Enabled:=(not Flag)and(IsEmpty=False) and (StrToInt(vprev)in [2,4])
          and (cdsMainStatus.AsInteger in[1,4,5]);
        if (cdsChild.ChangeCount>0)or(cdsChild.State in [dsEdit,dsInsert])    then
        begin
          tblCancel.Enabled:=True;
        end
        else
        begin
          tblCancel.Enabled:=False;
        end;
      end;

      if ((cdsMain.State  in [dsEdit,dsInsert])or(cdsMain.ChangeCount>0))
                  or((cdsChild.State  in [dsEdit,dsInsert])or(cdsChild.ChangeCount>0))and(StrToInt(vprev)in [2,4])  then
        begin
          tblSave.     Enabled:=True;
          tblfind.     Enabled:=False;
          tblRefresh.  Enabled:=False;
          tblExport.   Enabled:=False;
          tblPrint.    Enabled:= False;      //��ӡ
          tblDesign.   Enabled:=False ;      //�������
          tblFilter.   Enabled:= False;
          bt_Expand.   Enabled:=False ;   //�ύ
          bt_Confirm.  Enabled :=False;   //���
          bt_UConfirm .Enabled :=False;  //����
          bt_Return   .Enabled  :=False;  //�˻�
          Button2     .Enabled  :=False;  //ʧЧ
          Button3     .Enabled  :=False;  //��������
        end
      else
        begin
          tblSave.Enabled:=False;
          tblfind.Enabled:= True;
          tblRefresh .Enabled:=True;
          tblExport.Enabled:=True;
          tblPrint.Enabled:= (StrToInt(vprev)in [2,4]);      //��ӡ
          tblDesign.Enabled:=(StrToInt(vprev)in [2,4]) ;      //�������
          tblFilter.Enabled:= True;
          bt_Expand.Enabled:=(StrToInt(vprev)in [2,4]) and (cdsMainStatus.AsInteger=1) ;   //�ύ
          bt_Confirm.Enabled:=(StrToInt(vprev)in [4]) and (cdsMainStatus.AsInteger=2) ;   //���
          bt_UConfirm.Enabled:= (StrToInt(vprev)in [4]) and (cdsMainStatus.AsInteger=3) ;   //����
          bt_Return .Enabled:= (StrToInt(vprev)in [4]) and (cdsMainStatus.AsInteger=2) ;   //�˻�
          Button2      .Enabled  := (StrToInt(vprev)in [4]) and (cdsMainStatus.AsInteger<>6);  //ʧЧ
          Button3      .Enabled  := (StrToInt(vprev)in [4]) and (cdsMainStatus.AsInteger=6);  //��������
        end ;
    end;

    with cdsMainstatus do    //����״ֵ̬��Ȩ���룬���ô��ڵ���Щ����ɱ༭��
    if ( (AsInteger in [1,4,5]) or (cdsMain.FieldByName('RepoVali').Value<=0) )
                    and (StrToInt(vprev) in [2,4]) then                           // 1δ�ύ��2 ���ύ��3����ˣ�4��������5���˻أ�6��ʧЧ
    begin                         
      {(��״̬=1δ�ύ��4��������5���˻أ����ߣ�������Ч��<=0��)and(Ȩ����=2��4)}
      setControlsReadOnly([edt_CODE,edt_INV_Type,edt_Model,dbDate_TestDate,dbDate_EffeDate,
          DBMemo_Remarks,DBComboBox_FileType,DBMemo2_Remarks],False);

      DghMain .ReadOnly:=False;
      dghChild.ReadOnly:=False;
      btn_Upload.Enabled:=cdsChildFileType.IsNull=False ;
    end
    else
    if (AsInteger in [2,3]) then
    begin
      setControlsReadOnly([edt_CODE,edt_INV_Type,edt_Model,dbDate_TestDate,dbDate_EffeDate,
          DBMemo_Remarks,DBComboBox_FileType,DBMemo2_Remarks]);
      DghMain .ReadOnly:=True;
      dghChild.ReadOnly:=True;
      btn_Upload.Enabled:=  False;
    end;
    Set_ButtonStatus;    //���ݼ���״̬��������ʱ�����������ұ�����������״̬��20141116���
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

  btn_Open.Enabled:= (cdsChild.FieldByName('FileName').IsNull=False)and(cdsChild.FieldByName('FileName').Value<>'');
  btn_TemporarilyBy.Enabled:= (cdsMainTemporBy.AsBoolean=False)and(StrToInt(vprev)=4);
  btn_ToCancel     .Enabled:= (cdsMainTemporBy.AsBoolean)and(StrToInt(vprev)=4);
end;

procedure TFileGroup_f.FormCreate(Sender: TObject);
begin
  IsLog:=True;

  if not App_init_2(dm_frm.ADOConnection1 ) then
  begin
    ShowMessage('��������ʧ�ܣ�����ϵϵͳ����Ա��');
    application.Terminate;
    exit;
  end;
  Caption:=application.Title ; {}

//  DM_frm.ADOConnection1.Close;
//  DM_frm.ADOConnection1.ConnectionString:='Provider=SQLOLEDB.1;Password=wisdomtopcb1077;Persist Security Info=True;User ID=wzsa;Initial Catalog=sj_v20_live;Data Source=172.16.68.8';
//  DM_frm.ADOConnection1.Open;
//  UserRKEY :=2522 ;// 2012
//  EmplRKEY:=2995;
//  vprev:='4';
  inherited;
  CurrentDate:=GetDataBaseDate(dtread,ADateTime);
  SetEmployeeInfo(dtRead,StatusBar1);
  cdsMain.CommandText:= cdsMain.F_SQLSelectFrom+#13+cdsMain.F_SQLOrderBy;
  cdsMain.Open;

  var_DropDown_Info:=TDropDownInfo.Create();
  with var_DropDown_Info do
  begin
    L_SourceDataSet         :=cdsMain;
    L_GridName              :=DghMain;
    L_ListDataSet           :=dt0023;
    L_ColsInfo              :='CODE/����/80,ABBR_NAME/����/120';
    L_DropdownColumn        :='CODE';
    L_ListDataSetFilterField:='CODE';
    L_ListResultField       :='CODE';
    L_GetValueField         :='CODE';
    L_SourceField           :=varArrayOf(['D023_ptr','ABBR_NAME']);//�ı䷢���󣬻�ȡֵ���ֶ�
    L_ResultField           :=varArrayOf(['rkey','ABBR_NAME']);//�ı䷢���󣬴���Щ�ֶλ�ȡֵ
    DropDownInfo_Init(var_DropDown_Info);
    edt_CODE.F_ColsInfo:= L_ColsInfo;
  end;
  DropDown_Info_List.Add(var_DropDown_Info) ;

  var_DropDown_Info:=TDropDownInfo.Create();
  with var_DropDown_Info do
  begin
    L_SourceDataSet         :=cdsMain;
    L_GridName              :=DghMain;
    L_ListDataSet           :=dt_INV_Type;
    L_ColsInfo              :='INV_Type/���/80';
    L_DropdownColumn        :='INV_Type';
    L_ListDataSetFilterField:='INV_Type';
    L_ListResultField       :='INV_Type';
    L_GetValueField         :='INV_Type';
    DropDownInfo_Init(var_DropDown_Info);
    edt_INV_Type.F_ColsInfo:= L_ColsInfo;
  end;
  DropDown_Info_List.Add(var_DropDown_Info) ;

  var_DropDown_Info:=TDropDownInfo.Create();
  with var_DropDown_Info do
  begin
    L_DropdownColumn:='Status';
    L_AddPickList:=varArrayOf(['δ�ύ','���ύ','�����','������','���˻�','��ʧЧ']);
    L_PickListResultValues:=varArrayOf([1,2,3,4,5,6]);
  end;
  DropDown_Info_List.Add(var_DropDown_Info) ;
  
  Find_DisplayFields:=vararrayOf(['CODE','ABBR_NAME','INV_Type','Model','RoHsFree','SGS_NO','TestDate',
  'EffeDate','Status','TemporBy','TemporTo','USER_FULL_NAME','EntrTime','Remarks']);
  isMc:=False;

  SetControlsReadOnly([edt_ABBR_NAME,edt_RepoVali,edt_Status,edt_TemporTo,
  edt_USER_FULL_NAME,edt_EntrTime,edt_FileName]);
  SetColsReadOnly(DghMain,['ABBR_NAME','RepoVali','v_Status','TemporTo','TemporBy','USER_FULL_NAME','EntrTime']);
  SetColsReadOnly(dghChild,['FileName']);
  FirstControl:=edt_CODE;
  LastControl:=DBMemo_Remarks;
  SetFilterComponent(DghMain.FieldColumns['CODE']);

  Log_Data_Info[0].L_LogFields:=varArrayOF(['CODE','INV_Type','INV_Name','Model',
     'RoHsFree','TestDate','EffeDate','Status','TemporBy','TemporTo']);
  Log_Data_Info[1].L_LogFields:=varArrayOF(['FileType','FileName']);
end;

procedure TFileGroup_f.cdsMainCODEChange(Sender: TField);
begin
  inherited;
  with cds0023 do
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
      cdsMain.FieldByName('D023_ptr').Value:=null;
      cdsMain.FieldByName('ABBR_NAME').Value:=null ;
    end
    else
    begin
      if Locate('Code',Sender.Value,[loCaseInsensitive]) then
        begin
        cdsMainD023_ptr.Value := FieldByName('rkey').Value ;
        cdsMainABBR_NAME.Value:= FieldByName('ABBR_NAME').Value
        end
      else
        begin
        cdsMain.FieldByName('D023_ptr').Value:=null;
        cdsMain.FieldByName('ABBR_NAME').Value:=null ;
        end;
    end;
  end;
end;

procedure TFileGroup_f.cdsMainNewRecord(DataSet: TDataSet);
begin
  inherited;
  with    DataSet do       //������¼ʱ��Ĭ��ֵ
  begin
    FieldByName('RepoVali').Value:=1;               //������Ч��ȷ��
    FieldByName('Status').Value:=1;                 //״̬
    FieldByName('TemporBy').Value:=0;                 //��ʱͨ��
    FieldByName('D073_ptr').Value:=UserRKEY;        //¼����
    FieldByName('USER_FULL_NAME').Value:=USER_FULL_NAME;  //¼����
    FieldByName('EntrTime').Value:=GetDataBaseDate(dtread,ADateTime);  //¼��ʱ��
  end;
end;

procedure TFileGroup_f.cdsMainTestDateChange(Sender: TField);
begin
  inherited;
  if Sender.IsNull then
    cdsMain.FieldByName('EffeDate').Value:=null
  else
    cdsMainEffeDate.Value:=IncYear(Sender.Value); //����1��
end;

procedure TFileGroup_f.cdsMainCurrentDateCalcFields(DataSet: TDataSet);
begin
  inherited;
  with   DataSet do
  begin
    if FieldByName('Status').AsInteger=1 then
      FieldByName('v_Status').AsString:='δ�ύ'
    else
    if FieldByName('Status').AsInteger=2 then
      FieldByName('v_Status').AsString:='���ύ'
    else
    if FieldByName('Status').AsInteger=3 then
      FieldByName('v_Status').AsString:='�����'
    else
    if FieldByName('Status').AsInteger=4 then
      FieldByName('v_Status').AsString:='������'
    else
    if FieldByName('Status').AsInteger=5 then
      FieldByName('v_Status').AsString:='���˻�'
    else
    if FieldByName('Status').AsInteger=6 then
      FieldByName('v_Status').AsString:='��ʧЧ' ;
  end;
  
  if DataSet.FieldByName('EffeDate').IsNull=False then
  DataSet.FieldByName('RepoVali').Value:=intToStr( trunc(DataSet.FieldByName('EffeDate').Value)-trunc(CurrentDate)) ;
end;

procedure TFileGroup_f.DghMainGetCellParams(Sender: TObject;
  Column: TColumnEh; AFont: TFont; var Background: TColor;
  State: TGridDrawState);
begin
  inherited;
  if DghMain.DataSource.DataSet.FieldByName('RepoVali').IsNull=False then
  if (DghMain.DataSource.DataSet.FieldByName('RepoVali').AsInteger>0) and
     (DghMain.DataSource.DataSet.FieldByName('RepoVali').AsInteger<=30) then
    AFont.Color:=clBlue//clYellow
  else
  if DghMain.DataSource.DataSet.FieldByName('RepoVali').AsInteger<=0 then
    AFont.Color:=clRed;
end;

procedure TFileGroup_f.cdsMainRepoValiGetText(Sender: TField;
  var Text: String; DisplayText: Boolean);
begin
  inherited;
  if Sender.IsNull=False then
  begin
    if Sender.Value>30 then
      Text:='��Ч����'
    else
    if (Sender.Value>0) and (Sender.Value<=30) then
      Text:='��Ҫ����'
    else
    if Sender.Value<=0 then
      Text:='�ѹ���' ;
  end;    
end;

procedure TFileGroup_f.cdsChildFileTypeGetText(Sender: TField;
  var Text: String; DisplayText: Boolean);
begin
  inherited;
  if Sender.Value=1 then
    Text:='SGS'
  else
  if Sender.Value=2 then
    Text:='MSDS'
  else
  if Sender.Value=3 then
    Text:='����Э��'
  else
  if Sender.Value=4 then
    Text:='�������ñ���';
end;

procedure TFileGroup_f.cdsChildFileTypeSetText(Sender: TField;
  const Text: String);
begin
  inherited;
  if Text='SGS' then
    Sender.Value:=1
  else
  if Text='MSDS' then
    Sender.Value:=2
  else
  if Text='����Э��' then
    Sender.Value:=3
  else
  if Text='�������ñ���' then
    Sender.Value:=4    ;
end;

procedure TFileGroup_f.btn_OpenClick(Sender: TObject);
var
  f: string;
  fs: TMemoryStream;
begin
  try
    Screen.Cursor := crHourGlass;
    with qryTemp do
    begin
      Close;
      SQL.Clear;
      SQL.Text:='select VCUT_BMP,filename from data0806 where [rkey]='+cdsChildrkey.AsString;
      Open;

      fs:=TMemoryStream.Create;
      TBlobfield(FieldByName('VCUT_BMP')).SaveToStream(fs);
      if not DirectoryExists(TmpFileDir) then
        if not CreateDir(TmpFileDir) then
          raise Exception.Create('������ʱ�ļ�Ŀ¼����: '+TmpFileDir);
      UnPackStream(fs);
      f:=TmpFileDir+FieldByName('filename').AsString;
      fs.SaveToFile(f);
      fs.Free;
      ShellExecute(0,'open',pchar(f),nil,nil,SW_SHOWNORMAL);
    end
  finally
    Screen.Cursor := crDefault;
  end;

end ;

procedure TFileGroup_f.FormShow(Sender: TObject);
begin
  inherited;
  dsMainStateChange(dsMain) ;
  Curr_Date:=GetDataBaseDate(dtRead,ADateTime) ;
  CheckBox_Status1Click(nil);

  Panel_Above.Align := alClient;
  Panel_Below.Align := alBottom;
  Splitter1.Align   := alBottom;
  Panel_Below.Height:= 250;
end;


procedure TFileGroup_f.btn_UploadClick(Sender: TObject);
var
  i:integer;
  s:string;
  fs: TMemoryStream;
begin
  tblSaveClick(nil);
  Screen.Cursor := crHourGlass;
  try       
    if cdsChildFileName.AsString<>''then
    if Messagedlg('�ļ���:'+cdsChildFileName.AsString+'�Ѿ�����,ȷ����Ҫ������',mtconfirmation,[mbYES,mbNO],0)=mrNo  then
      Exit;

    OpenDialog1.DefaultExt :='*.*';
    OpenDialog1.Filter :='';
    OpenDialog1.FileName:='';
    if OpenDialog1.Execute then
    begin
      for i:=length(OpenDialog1.FileName) downto 1 do
      begin
        if OpenDialog1.FileName[i]<>'\' then
          s:=OpenDialog1.FileName[i]+s
        else
          break;
      end;
      fs := TMemoryStream.Create;
      fs.LoadFromFile(OpenDialog1.FileName);
      if fs.Size>10*1024*1024 then
      begin
        MsgWarning('�ļ���С���ܳ���10M,�����������ļ��ٱ���...');
        fs.Free;
        exit;
      end;
      PackStream(fs);    
      try
        try
          DM_frm.ADOConnection1.BeginTrans;
          with qryTemp do
          begin
            Close;
            SQL.Clear;
            SQL.Add('update data0806 set VCUT_BMP= :file_data_s '+
            'where [rkey]= '+cdsChildRkey.AsString);
            Parameters.ParamByName('file_data_s').LoadFromStream(fs,ftBlob);
            ExecSQL;
          end;
          if not(cdsChild.State in [dsEdit,dsInsert]) then
            cdsChild.Edit;
          cdsChild.FieldByName('FileName').Value:=s;
          cdsChild.Post;
          if IsLog then
          Log_Add(Log_Data_Info);
          if cdsChild.ApplyUpdates(0)<>0 then
          begin
            DM_frm.ADOConnection1.RollbackTrans;
            Exit;
          end;
                    //�û��ϴ��ļ�֮�����״̬���Ǵ��ύ�����ӡ�����������Ϊ�����ύ����
          if  cdsMainStatus.Value<>1 then
          begin
            if not(cdsMain.State in [dsEdit,dsInsert]) then
              cdsMain.Edit;
            cdsMainStatus.Value:=1;
            cdsMain.Post;
          end;
          if cdsMain.ApplyUpdates(0)=0 then
          begin
            if IsLog then
            begin
              if Log_Save then
                DM_frm.ADOConnection1.CommitTrans
              else
              begin
                DM_frm.ADOConnection1.RollbackTrans;
                Exit;
              end;
            end
            else
              DM_frm.ADOConnection1.CommitTrans;
          end
          else
          begin
            DM_frm.ADOConnection1.RollbackTrans;
          end ;

          MsgInfo('�ļ��ϴ��ɹ�!!!');
        except
          on e: exception do
          begin
            if  DM_frm.ADOConnection1.InTransaction then
            DM_frm.ADOConnection1.RollbackTrans;
            MsgError('�½��ļ�Ŀ¼ʧ��,ԭ���ǣ�'+e.message);
            Exit;
          end;
        end;
      finally
        fs.Free;
        dsMainStateChange(dsMain);
      end;
    end ;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TFileGroup_f.btn_TemporarilyByClick(Sender: TObject);
var
  TemporarilyBy_f: TTemporarilyBy_f;
begin
  inherited;
  begin
    TemporarilyBy_f := TTemporarilyBy_f.Create(Application);
    try
      if TemporarilyBy_f.ShowModal=mrok then
      begin
        if not(cdsMain.State in [dsEdit,dsInsert]) then
          cdsMain.Edit;
        cdsMainTemporBy.Value:=True;

        cdsMain.FieldByName('TemporTo').Value:=formatdatetime('yyyy-mm-dd',TemporarilyBy_f.DateTimePicker1.Date);//dateformat TemporarilyBy_f.DateTimePicker1.Date;
        cdsMain.Post;
        Log_Add(Log_Data_Info)  ;
        DM_frm.ADOConnection1.BeginTrans;
        try
          if cdsMain.ApplyUpdates(0)=0 then
          begin
            if Log_Save then
              DM_frm.ADOConnection1.CommitTrans
            else
              DM_frm.ADOConnection1.RollbackTrans ;
          end
          else
            DM_frm.ADOConnection1.RollbackTrans;
        except
          if DM_frm.ADOConnection1.InTransaction then
          DM_frm.ADOConnection1.RollbackTrans;
        end;
        dsMainStateChange(nil);
      end;
    finally
      TemporarilyBy_f.Free;
    end;
  end;
end;

procedure TFileGroup_f.btn_ToCancelClick(Sender: TObject);
begin
  inherited;
  if Msg_Ask('��Ҫȡ��ͨ����',[mbYes, mbNo]) =mryes then
  begin
    if not(cdsMain.State in [dsEdit,dsInsert]) then
      cdsMain.Edit;
    cdsMainTemporBy.Value:=False;
    cdsMain.FieldByName('TemporTo').Value:=null;
    cdsMain.Post;
    Log_Add(Log_Data_Info);
    DM_frm.ADOConnection1.BeginTrans;
    try
      if cdsMain.ApplyUpdates(0)=0 then
        begin
          if Log_Save then
            DM_frm.ADOConnection1.CommitTrans
          else
            DM_frm.ADOConnection1.RollbackTrans;
        end
      else
        DM_frm.ADOConnection1.RollbackTrans;
    except
      if DM_frm.ADOConnection1.InTransaction then
      DM_frm.ADOConnection1.RollbackTrans;
    end;
    dsMainStateChange(nil);
  end;
end;

procedure TFileGroup_f.cdsMainAfterInsert(DataSet: TDataSet);
begin
  inherited;
  if PageControl_M.ActivePageIndex=1 then
  if  FirstControl<>nil then
    FirstControl.SetFocus;
end;

procedure TFileGroup_f.dspMainGetTableName(Sender: TObject;
  DataSet: TDataSet; var TableName: String);
begin
  inherited;
  TableName:='data0805';      //����ʱ������޸ĵı���
end;

procedure TFileGroup_f.BtFindClick(Sender: TObject);
var
  str_SQL:string;
begin
  inherited;
  if CheckBox1.Checked then
    str_SQL:='1';
  if CheckBox2.Checked then
  begin
    if str_SQL='' then
      str_SQL:='2'
    else
      str_SQL:=str_SQL+',2';
  end;
  if CheckBox3.Checked then
  begin
    if str_SQL='' then
      str_SQL:='3'
    else
      str_SQL:=str_SQL+',3';
  end;
  if str_SQL<>'' then
  begin
    str_SQL:=' where [Vali] in ('+ str_SQL+')';
    cdsMain.Close;
    cdsMain.CommandText:=cdsMain.F_SQLSelectFrom+#13+ str_SQL+#13+cdsMain.F_SQLOrderBy;
    cdsMain.Open;
  end
  else
  begin
    cdsMain.Close;
    cdsMain.CommandText:=cdsMain.F_SQLSelectFrom+#13+cdsMain.F_SQLOrderBy;
    cdsMain.Open;
  end;
end;

procedure TFileGroup_f.SetFilterComponent(Column: TColumnEh);
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

procedure TFileGroup_f.DghMainTitleClick(Column: TColumnEh);
begin
  inherited;
  SetFilterComponent(Column)  ;
end;

procedure TFileGroup_f.Filter_EditChange(Sender: TObject);
begin
  inherited;
  with cdsMain do
  if trim(Filter_Edit.Text) <> '' then
  begin
    Filtered := False;
    if str_FilterText<>'' then
    Filter:= str_FilterText;
    Filtered := true;
  end
  else
    Filtered := False;
end;

procedure TFileGroup_f.cdsMainFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  inherited;
  if Trim(Filter_Edit.Text) <>'' then
  Accept:=AnsiContainsText(DataSet.FieldByName(FilterFieldName).AsString,Filter_Edit.Text ) ;
end;

procedure TFileGroup_f.CheckBox_Status1Click(Sender: TObject);
begin
  inherited;
  str_FilterText:='';
  if CheckBox_Status1.Checked then
    str_FilterText:='Status=1';

  if CheckBox_Status2.Checked then
  begin
    if str_FilterText='' then
      str_FilterText:='Status=2'
    else
      str_FilterText:=str_FilterText+' or Status=2'
  end;

  if CheckBox_Status3.Checked then
  begin
    if str_FilterText='' then
      str_FilterText:='Status=3'
    else
      str_FilterText:=str_FilterText+' or Status=3'
  end;

  if CheckBox_Status4.Checked then
  begin
    if str_FilterText='' then
      str_FilterText:='Status=4'
    else
      str_FilterText:=str_FilterText+' or Status=4'
  end;

  if CheckBox_Status5.Checked then
  begin
    if str_FilterText='' then
      str_FilterText:='Status=5'
    else
      str_FilterText:=str_FilterText+' or Status=5'
  end;

  if CheckBox_Status6.Checked then
  begin
    if str_FilterText='' then
      str_FilterText:='Status=6'
    else
      str_FilterText:=str_FilterText+' or Status=6'
  end;

  cdsMain.Filtered:=False;
  cdsMain.Filter:= str_FilterText;
  cdsMain.Filtered:=True;
end;

procedure TFileGroup_f.cdsMainAfterEdit(DataSet: TDataSet);
begin
  inherited;
  if  cdsMainStatus.AsInteger=5 then
  begin
    if cdsMain.State<> dsEdit then
      cdsMain.Edit;
    cdsMainStatus.AsInteger:= 1;
  end;
end;

procedure TFileGroup_f.cdsChildAfterEdit(DataSet: TDataSet);
begin
  inherited;
  if  cdsMainStatus.AsInteger=5 then
  begin
    if cdsMain.State<> dsEdit then
      cdsMain.Edit;
    cdsMainStatus.AsInteger:= 1;
  end;
end;

procedure TFileGroup_f.cdsChildAfterDelete(DataSet: TDataSet);
begin
  inherited;
  if  cdsMainStatus.AsInteger=4 then
  begin
    if cdsMain.State<> dsEdit then
      cdsMain.Edit;
    cdsMainStatus.AsInteger:= 1;
  end;
end;

procedure TFileGroup_f.bt_ExpandClick(Sender: TObject);
var
  strMsg:string;
  I_Row:Integer;
begin
  strMsg:='';
  with cdsMain do
  begin
    if (FieldByName('TestDate').IsNull) then
      strMsg:=strMsg+'������ֶΣ���'+FieldByName('TestDate').DisplayLabel+'����ֵ����Ϊ�գ�����'+#13;
    if (FieldByName('EffeDate').IsNull) then
      strMsg:=strMsg+'������ֶΣ���'+FieldByName('EffeDate').DisplayLabel+'����ֵ����Ϊ�գ�����'+#13;
  end;
  with cdsChild do
  begin
    if IsEmpty then   //  or(FieldByName('FileName').IsNull)or(FieldByName('FileName').AsString='')
      strMsg:=strMsg+'��û���ϴ��ļ�������'+#13
    else
    begin
      DM_frm.cdsClone.Data:= Data;
      for I_Row:=0 to DM_frm.cdsClone.RecordCount-1 do
      begin
        if (DM_frm.cdsClone.FieldByName('FileName').IsNull)or(DM_frm.cdsClone.FieldByName('FileName').AsString='') then
          strMsg:=strMsg+'�ӱ���'+IntToStr(I_Row+1)+'�У��ļ���δ�ϴ�������'+#13 ;
        DM_frm.cdsClone.Next;
      end;
      DM_frm.cdsClone.Close;
    end;
  end;
  if strMsg<>'' then
  begin
    MsgError(strMsg);
    Exit;
  end;

  if Msg_Ask('��ȷ��Ҫ�ύ�����',[mbYes,mbNo])  =mrNo then
  Exit;
  with cdsMain do
  begin
    if not(State in [dsEdit,dsInsert])then
    Edit;
    FieldByName('Status').Value:=2;
    Post;
    tblSaveClick(nil);
  end;
end;

procedure TFileGroup_f.bt_ConfirmClick(Sender: TObject);
var
  strMsg:string;
begin
  inherited;
  with cdsMain do
  begin
    if (FieldByName('TestDate').IsNull) then
      strMsg:=strMsg+'������ֶΣ���'+FieldByName('TestDate').DisplayLabel+'����ֵ����Ϊ�գ�����'+#13;
    if (FieldByName('EffeDate').IsNull) then
      strMsg:=strMsg+'������ֶΣ���'+FieldByName('EffeDate').DisplayLabel+'����ֵ����Ϊ�գ�����'+#13;
  end;
  with cdsChild do
  begin
    if IsEmpty or(FieldByName('FileType').IsNull)or(FieldByName('FileType').AsString='') then
      strMsg:=strMsg+'��û���ϴ��ļ�������'+#13;
  end;
  if strMsg<>'' then
  begin
    MsgError(strMsg);
    Exit;
  end;

  if Msg_Ask('��ȷ��Ҫ�����',[mbYes,mbNo])  =mrNo then
  Exit;

  with cdsMain do
  begin
    if not(State in [dsEdit,dsInsert])then
    Edit;
    FieldByName('Status').Value:=3;
    if FieldByName('TemporBy').AsBoolean then           //���ͨ����ʱ���������ʱͨ�� ��Ϊ�棬ȡ��
    begin
      FieldByName('TemporBy').Value:=False;
      FieldByName('TemporTo').Value:=null;
    end;
    Post;
    tblSaveClick(nil);
  end;
end;

procedure TFileGroup_f.bt_ReturnClick(Sender: TObject);
var
  str:string;
begin
  inherited;
  if InputDlg(Self.Handle,'�����˻�ԭ��','',str)then
  begin
    with cdsMain do
    begin
      if not(State in [dsEdit,dsInsert])then
      Edit;
      FieldByName('Status').Value:=5;
      if  (FieldByName('Remarks').IsNull)or(FieldByName('Remarks').AsString='')  then
        FieldByName('Remarks').Value:='�˻�ԭ��'+str 
      else
        FieldByName('Remarks').Value:=FieldByName('Remarks').Value+'��'+#13+'�˻�ԭ��'+str;
      Post;
      tblSaveClick(nil);
    end;
  end;
end;

procedure TFileGroup_f.bt_UConfirmClick(Sender: TObject);
begin
  inherited;
  if Msg_Ask('��ȷ��Ҫ�˻����±༭��',[mbYes,mbNo])  =mrNo then
  Exit;

  with cdsMain do
  begin
    if not(State in [dsEdit,dsInsert])then
    Edit;
    FieldByName('Status').Value:=4;
    Post;
    tblSaveClick(nil);
  end;
end;

procedure TFileGroup_f.tblSaveClick(Sender: TObject);
begin
  if (cdsMain.UpdateStatus=usInserted)and(cdsChild.IsEmpty) then
  begin
    with cdsChild do
    begin
      Append;
      FieldByName('FileType').Value:=1;
      Append;
      FieldByName('FileType').Value:=2;
      Append;
      FieldByName('FileType').Value:=3;
      Append;
      FieldByName('FileType').Value:=4;
      Post;
    end;
  end;
  inherited;   
end;

procedure TFileGroup_f.Button2Click(Sender: TObject);
begin
  inherited;
  if Msg_Ask('��ȷ��Ҫ���ü�¼�޸�ΪʧЧ��',[mbYes,mbNo])  =mrNo then
  Exit;

  with cdsMain do
  begin
    if not(State in [dsEdit,dsInsert])then
    Edit;
    FieldByName('Status').Value:=6;
    Post;
    tblSaveClick(nil);
  end;
end;

procedure TFileGroup_f.Button3Click(Sender: TObject);
begin
  inherited;
  if Msg_Ask('��ȷ��Ҫ���ü�¼�޸�Ϊ��Ч��',[mbYes,mbNo])  =mrNo then
  Exit;

  with cdsMain do
  begin
    if not(State in [dsEdit,dsInsert])then
    Edit;
    FieldByName('Status').Value:=1;
    Post;
    tblSaveClick(nil);
  end;
end;

end.
