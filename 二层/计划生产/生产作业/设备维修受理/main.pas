unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, Grids, DBGridEh, ComCtrls, StdCtrls, Buttons, ExtCtrls,StrUtils,
  Mask, DBCtrls, DBGrids, DB, ADODB, DBClient, RzPanel,SelectItemUnit,DateUtils,
  ToolWin,comobj,DBGridEhImpExp;

type
  TForm1 = class(TForm)
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N_Complete: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    PopupMenu2: TPopupMenu;
    Panel2: TPanel;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    N_Pause: TMenuItem;
    N14: TMenuItem;
    N15: TMenuItem;
    N16: TMenuItem;
    N17: TMenuItem;
    N18: TMenuItem;
    N19: TMenuItem;
    N20: TMenuItem;
    N21: TMenuItem;
    N22: TMenuItem;
    N23: TMenuItem;
    Panel5: TPanel;
    BitBtn11: TBitBtn;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox1: TCheckBox;
    CheckBox0: TCheckBox;
    Panel6: TPanel;
    Label13: TLabel;
    dtpk1: TDateTimePicker;
    Label14: TLabel;
    dtpk2: TDateTimePicker;
    Panel7: TPanel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    DBGridEh1: TDBGridEh;
    Panel3: TPanel;
    dghChild: TDBGridEh;
    Panel4: TPanel;
    RzToolbar1: TRzToolbar;
    btn_New: TButton;
    btn_Save: TButton;
    btn_Cancel: TButton;
    btn_Delete: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Button7: TButton;
    Splitter1: TSplitter;
    TabSheet3: TTabSheet;
    Label19: TLabel;
    DBEdit6: TDBEdit;
    Label20: TLabel;
    DBEdit7: TDBEdit;
    Label21: TLabel;
    DBEdit8: TDBEdit;
    Label22: TLabel;
    DBEdit9: TDBEdit;
    Label23: TLabel;
    DBEdit10: TDBEdit;
    Label25: TLabel;
    DBEdit12: TDBEdit;
    Label26: TLabel;
    DBEdit13: TDBEdit;
    Label27: TLabel;
    z: TDBEdit;
    Label28: TLabel;
    DBEdit15: TDBEdit;
    Label29: TLabel;
    Label30: TLabel;
    edt_maintain_empl: TDBEdit;
    Label31: TLabel;
    Label32: TLabel;
    cbb_fail_type: TDBComboBox;
    Label33: TLabel;
    DBEdit16: TDBEdit;
    Label34: TLabel;
    DBEdit18: TDBEdit;
    Label35: TLabel;
    DBEdit19: TDBEdit;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    DBEdit22: TDBEdit;
    Label39: TLabel;
    Label40: TLabel;
    DBEdit24: TDBEdit;
    Label41: TLabel;
    DBEdit25: TDBEdit;
    Label42: TLabel;
    DBEdit26: TDBEdit;
    Label43: TLabel;
    DBEdit27: TDBEdit;
    Label44: TLabel;
    edt_disposal_date: TDBEdit;
    Label45: TLabel;
    edt_complete_date: TDBEdit;
    DBMemo5: TDBMemo;
    DBMemo6: TDBMemo;
    edt_FaultName: TDBEdit;
    btn_FaultName: TSpeedButton;
    tlb1: TToolBar;
    btInsert: TSpeedButton;
    btEdit: TSpeedButton;
    btPost: TSpeedButton;
    btCancel: TSpeedButton;
    btDelete: TSpeedButton;
    btFilter: TSpeedButton;
    btRefresh: TSpeedButton;
    btOut: TSpeedButton;
    btPrior: TSpeedButton;
    btNext: TSpeedButton;
    btUpload: TSpeedButton;
    btDownload: TSpeedButton;
    SpeedButton2: TSpeedButton;
    btPrint: TSpeedButton;
    btClose: TSpeedButton;
    BitBtn13: TBitBtn;
    BitBtn14: TBitBtn;
    BitBtn15: TBitBtn;
    Label1: TLabel;
    Edit1: TEdit;
    Label24: TLabel;
    DBEdit14: TDBEdit;
    Label2: TLabel;
    DBEdit1: TDBEdit;
    DBMemo1: TDBMemo;
    mo_maintain_text: TDBMemo;
    Label3: TLabel;
    DBEdit2: TDBEdit;
    Panel1: TPanel;
    DBGrid1: TDBGrid;
    CheckBox8: TCheckBox;
    Label4: TLabel;
    edt_Location: TDBEdit;
    btn_Location: TSpeedButton;
    Label5: TLabel;
    DBEdit4: TDBEdit;
    Label7: TLabel;
    edt_PLACE: TDBEdit;
    N_EndPause: TMenuItem;
    N_OtherEndPause: TMenuItem;
    N2: TMenuItem;
    N_ColumnsSet: TMenuItem;
    PopupMenu3: TPopupMenu;
    N_ChildColumnsSet: TMenuItem;
    SaveDialog1: TSaveDialog;
    N12: TMenuItem;
    N13: TMenuItem;
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure DBGridEh1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGridEh1TitleClick(Column: TColumnEh);
    procedure BitBtn3Click(Sender: TObject);
    procedure CheckBox0Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure N_CompleteClick(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure N_PauseClick(Sender: TObject);
    procedure BitBtn9Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure N14Click(Sender: TObject);
    procedure N15Click(Sender: TObject);
    procedure N16Click(Sender: TObject);
    procedure N17Click(Sender: TObject);
    procedure N20Click(Sender: TObject);
    procedure N22Click(Sender: TObject);
    procedure N23Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn_SaveClick(Sender: TObject);
    procedure btn_CancelClick(Sender: TObject);
    procedure btn_DeleteClick(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure btn_NewClick(Sender: TObject);
    procedure BitBtn10Click(Sender: TObject);
    procedure dghChildKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BitBtn11Click(Sender: TObject);
    procedure bit_FaultDescClick(Sender: TObject);
    procedure dghChildKeyPress(Sender: TObject; var Key: Char);
    procedure btn_FaultNameClick(Sender: TObject);
    procedure btCloseClick(Sender: TObject);
    procedure btRefreshClick(Sender: TObject);
    procedure btPriorClick(Sender: TObject);
    procedure btNextClick(Sender: TObject);
    procedure btCancelClick(Sender: TObject);
    procedure btPostClick(Sender: TObject);
    procedure btOutClick(Sender: TObject);
    procedure btFilterClick(Sender: TObject);
    procedure CheckBox8Click(Sender: TObject);
    procedure btn_LocationClick(Sender: TObject);
    procedure N_EndPauseClick(Sender: TObject);
    procedure N_OtherEndPauseClick(Sender: TObject);
    procedure N_ColumnsSetClick(Sender: TObject);
    procedure N_ChildColumnsSetClick(Sender: TObject);
    procedure N12Click(Sender: TObject);
    procedure N13Click(Sender: TObject);
  private
    { Private declarations }
    vEMPLOYEE_NAME:string;
    PreColumn: TColumnEh;
    empl_code,empl_name:string;
    procedure item_click(sender:TObject);
    function find_error(v_rkey,v_status:Integer):Boolean;
    Function  Newline(str:String;AddSpaces:string='') :string;
    procedure DghReadOnlyFocus(Sender :TDBGridEh);
    procedure KeyPressDBGridEH(Sender: TDBGridEh; var Key: Char;F:TForm) ;
    procedure Exec_EndPause(vEmployeeRkey:string);
  public
    FilterFieldName:string;
    b_Processing:Boolean;//��ά�޵���״̬����ͣ��Ϊ��ͣ����ʱ�����ά����Ա��״̬����ͣ�ģ�ѯ���Ƿ�Ҫͬ����ͣ������
    procedure ColNotReadOnlyFocus(F:TForm;Ds:TDataSet);
    procedure SetStatus ;
    procedure DBGridEHColumnsButtonClick(Sender: TObject;var Handled: Boolean);
    Function  SQLResultValue(FDataSet:TADOQuery;strSQL:string):string;
    procedure ComponentSetReadOnly(Win_Control:array of TControl;IsReadOnly:Boolean=True);
    function  EmployeeStatusCheck(vEmpl_ptr:string;out vNUMBER:string):Boolean;
    procedure SaveToExcel(ADataSet:TDataSet;savedialog1:tsavedialog;row:integer=2;col :integer=2);
    procedure OutputExcelStd(AForm:TForm;ADBGridEh:TDBGridEh);
    { Public declarations }
  end;

var
  Form1: TForm1;
  vSUPLFEDSHIP,vSUPLFEDMAT,vSUPLFEDMISC:string;    //���Ͷ�����
  strStatus    :string;
  F_IsBatchOperating:Boolean;//��������

implementation

uses damo,common,ConstVar,  return,
  unusual_cate,  formResetUsername, formPause, form_See, formInputDlg,
   formMain2, formFindcds,  form_msg, PublicFunc, ColsDisplaySet_unt;

{$R *.dfm}

function TForm1.EmployeeStatusCheck(vEmpl_ptr:string;out vNUMBER:string):Boolean;
begin
  Result:=False;
  with DM.Adoquery1 do
  begin
    Close;
    SQL.Clear;
    SQL.Text:='select NUMBER from data0842 join data0567 on data0842.work_ptr=data0567.rkey where data0842.empl_ptr='
      +vEmpl_ptr+' and data0842.[status]=3';
    Open;
    if IsEmpty=False then         //����ù�Ա����δ��ɵļ�¼������ֵΪ��
    begin
      ShowMessage('����ά�޵�����'+FieldByName('NUMBER').AsString+'������ִ���е�״̬������') ;
      Result:=True;
    end;

    Close;
    SQL.Clear;
    SQL.Text:='select CONVERT(varchar(100),PlanMainDate, 23)+'' ''+DeviNumb+'' ''+MainCycl as NUMBER'
         +' from data0831 join data0848 on data0848.work_ptr=data0831.rkey '
         +' where data0848.empl_ptr='+vEmpl_ptr+' and data0848.[status]=3';
    Open;
    if IsEmpty=False then         //����ù�Ա����δ��ɵļ�¼������ֵΪ��
    begin
      ShowMessage('���ڱ���������'+FieldByName('NUMBER').AsString+'������ִ���е�״̬������') ;
      Result:=True;
    end;
  end;
end;

procedure TForm1.ComponentSetReadOnly(Win_Control:array of TControl ;IsReadOnly:Boolean=True);   //���ã�ET(self);��ET��MYFORMNAME��
var
  i:integer;
begin   //�贰���ϵ�����Edit��Combobox��ؼ����á�
  for i:=0 to High(Win_Control)  do
  begin
    if (Win_Control[i] is TDBEdit) then
      begin
        TDBEdit(Win_Control[i]).ReadOnly:=IsReadOnly ;
        if  IsReadOnly then
          TDBEdit(Win_Control[i]).Color:=clInactiveCaptionText
        else
          TDBEdit(Win_Control[i]).Color:=clWindow;
      end
    else
    if (Win_Control[i] is TDBComboBox) then
      begin
        TDBComboBox(Win_Control[i]).ReadOnly:=IsReadOnly ;
        if  IsReadOnly then
          TDBComboBox(Win_Control[i]).Color:=clInactiveCaptionText
        else
          TDBComboBox(Win_Control[i]).Color:=clWindow;
      end
    else
    if (Win_Control[i] is TDBRadioGroup) then
      begin
        TDBRadioGroup(Win_Control[i]).ReadOnly:=IsReadOnly;
        if  IsReadOnly then
          TDBRadioGroup(Win_Control[i]).Color:=clInactiveCaptionText
        else
          TDBRadioGroup(Win_Control[i]).Color:=clWindow;
      end
    else
    if (Win_Control[i] is TDBMemo) then
      begin
        TDBMemo(Win_Control[i]).ReadOnly:=IsReadOnly ;
        if  IsReadOnly then
          TDBMemo(Win_Control[i]).Color:=clInactiveCaptionText
        else
          TDBMemo(Win_Control[i]).Color:=clWindow;
      end
    else
    if (Win_Control[i] is TDBCheckBox) then
      begin
        TDBCheckBox(Win_Control[i]).ReadOnly:=IsReadOnly;
      end
    else
    if (Win_Control[i] is TSpeedButton) then
      begin
        TSpeedButton(Win_Control[i]).Enabled:= not IsReadOnly;
      end                 ;
  end;
end;

procedure TForm1.SetStatus ;
begin
  with DM.cds567 do
  if  (State in[dsEdit,dsInsert])or(ChangeCount>0) then
    begin
      btPost.Enabled:=(StrToInt(vprev)in [2,3,4]);
      btCancel.Enabled:=True;
      btRefresh.Enabled:=False;
      btNext.Enabled:=False;
      btPrior.Enabled:=False;
    end
  else
    begin
      btPost.Enabled:=False;
      btCancel.Enabled:=False;
      btRefresh.Enabled:=True;
      btNext.Enabled:=True;
      btPrior.Enabled:=True;
    end;

  if DM.cds567STATUS.AsInteger=2 then
  begin
    ComponentSetReadOnly([cbb_fail_type,edt_maintain_empl,mo_maintain_text,btn_FaultName,edt_Location,btn_Location],False);
    btn_FaultName.Enabled:=StrToInt(vprev)=4;
  end
  else
  begin
    ComponentSetReadOnly([cbb_fail_type,edt_maintain_empl,mo_maintain_text,btn_FaultName,edt_Location,btn_Location]);
  end;
  if (DM.cds567STATUS.AsInteger in [3])  then
  begin
    if (StrToInt(vprev)= 4)  then
    ComponentSetReadOnly([edt_disposal_date,edt_complete_date,cbb_fail_type],False);
    if (StrToInt(vprev)= 3)  then
    ComponentSetReadOnly([cbb_fail_type],False);
  end
  else
    ComponentSetReadOnly([edt_disposal_date,edt_complete_date]) ;

  if ((StrToInt(vprev) in[ 2,3])and (DM.cds842Status.AsInteger =3))or((StrToInt(vprev) in[ 4]))  then
  begin
    dghChild.FieldColumns['Remark'].ReadOnly:=False;
  end
  else
    dghChild.FieldColumns['Remark'].ReadOnly:=true;

    btn_Delete.Enabled:=(DM.qry0843.IsEmpty)and(DM.cDS567STATUS.AsInteger in[2])and(DM.cds842Status.AsInteger=3)
             and (DM.cds842.IsEmpty=False)and(not (DM.cds842.State in [dsEdit,dsInsert])or(DM.cds842.ChangeCount>0)); // ɾ��
    Button4.Enabled:=DM.cds842Status.AsInteger=3;         // ��ʼ��ͣ
    Button5.Enabled:=DM.cds842Status.AsInteger=6;        //��ͣ����
    Button6.Enabled:=DM.cds842Status.AsInteger=3;         //���ν���
    Button7.Enabled:=(DM.cds842.IsEmpty=False);         //��ͣ��¼
    btn_New.Enabled:=(not (DM.cds842.State in [dsEdit,dsInsert])or(DM.cds842.ChangeCount>0))and(DM.cDS567STATUS.AsInteger in[2]);


  if (DM.cds842.State in [dsEdit,dsInsert])or(DM.cds842.ChangeCount>0)then
  begin
    btn_Save.Enabled:=True;
    btn_Cancel.Enabled:=True;
  end
  else
  begin
    btn_Save.Enabled:=False;
    btn_Cancel.Enabled:=False;
  end  ;
end;

Function  TForm1.Newline(str:String;AddSpaces:string='') :string;
begin
  Result:='';
  if str<>  '' then
  begin
    str:=str+#10#13+AddSpaces;        //��4���ո���Ϣ�Ĳ�νṹ����
    Result:=  str;
  end;
end;

procedure TForm1.DBGridEHColumnsButtonClick(Sender: TObject;var Handled: Boolean);  //
var
  i,I_DropDataSetCount:Integer;
  I_Left,I_Top,I_Width,X,H:Integer;
  Vpoint:   Tpoint;
  FieldsDisplayWidth:Integer;
begin
  FieldsDisplayWidth:=0;
  with ((Sender as TControl).Parent).Parent as TDBGridEh do
  begin
    if  DataSource.DataSet is TClientDataSet then
    if ((((Sender as TControl).Parent).Parent as TDBGridEh).DataSource.DataSet as TClientDataSet).ReadOnly then
    Exit;
    if  DataSource.DataSet is TCustomADODataSet then
    if (DataSource.DataSet as TCustomADODataSet).LockType=ltReadOnly then
    Exit;
    if ReadOnly then        //�����ǰ���ؼ���ֻ�����˳���
    Exit;
  end;

  with ((Sender as TControl).Parent).Parent as TDBGridEh do  //Button�ĸ���EDIT��EDIT�ĸ�����DBGRIDEH�ؼ�
  begin
    try
      begin
        for i:=0 to High( DropDown_Info) do
        begin
          if Name= DropDown_Info[i].L_GridName.Name then  //��ǰ����������������= ����DropDown_Info�еı����
          if UpperCase(DropDown_Info[i].L_DropdownColumn)=UpperCase(SelectedField.FieldName)  then
          with DropDown_Info[i] do
          begin
            Vpoint   := (Sender as TControl).Parent.ClientToScreen(Point((Sender as TControl).Left,(Sender as TControl).Top));
            I_Top:= Vpoint.y+(Sender as TControl).Height;
            if I_Top+250>Screen.Height-30 then
              I_Top:=Vpoint.y-250;
            if L_FormWidth=0 then
            begin
              for I_DropDataSetCount:=0 to L_ListDataSetName.FieldCount-1 do
              begin
                if  L_ListDataSetName.Fields[I_DropDataSetCount].Visible then
                FieldsDisplayWidth :=FieldsDisplayWidth+L_ListDataSetName.Fields[I_DropDataSetCount].DisplayWidth ;
              end;
              L_FormWidth:=(FieldsDisplayWidth*64 div 10)+35;   //  �Զ����������������ڵ���ʾ���
            end;
            if L_FormWidth<330 then
              I_Width:=330     //����С��330
            else
              I_Width:=L_FormWidth;
            if I_Width>700 then
              I_Width:=700;     //���ܳ���700

            if L_FormHeight  =0 then
              H:=240
            else
              H:=L_FormHeight;
            x:=Screen.Width- Vpoint.X-I_Width+ (Sender as TControl).Parent.Width;
            if x<0 then
              I_Left:=Screen.Width -I_Width//- (Sender as TControl).Parent.Width
            else
              I_Left:= Vpoint.X- (Sender as TControl).Parent.Width;

            if  (Screen.Height-I_Top)< h then   //��Ļ�ĸ߶�-�ؼ���ť���ڵĸ߶�  С�ڵ������ڵĸ߶�
              I_Top:=Screen.Height-h;
            if L_ListDataSetName.Active=False then
              L_ListDataSetName.Open;                  //
            if L_FormType<=1 then
            begin
              if ShowAddListForm(Self,L_ListDataSetName,L_ListDataSetFilterField,
                        Trim(L_GridName.FieldColumns[L_DropdownColumn].Field.asstring),
                        I_Left,I_Top,I_Width) then   //
              begin
                if not (L_GridName.DataSource.DataSet.State in [dsEdit,dsInsert]) then
                  L_GridName.DataSource.DataSet.Edit;
                L_GridName.DataSource.DataSet.FieldByName(L_GetValueField).Value :=
                              L_ListDataSetName.FieldByName(L_ListResultField).value;
              end  ;
              if L_ListDataSetName.Filtered then
              L_ListDataSetName.Filtered :=False;

              Break;
            end;
          end;
        end;
      end;
    finally

    end;
  end;
end;

Function  TForm1.SQLResultValue(FDataSet:TADOQuery;strSQL:string):string;
begin
  with  FDataSet do
  begin
    Result:='';
    Close;
    SQL.Clear;
    SQL.Text:=strSQL;
    Open;
    if  FieldList[0].IsNull  then
      Result:=''
    else
    Result:=FieldList[0].Value;
    Close;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  curr_date:tdatetime;  
begin
  if not App_init_2(dm.ADOConnection) then
  begin
    showmsg('������ʧ������ϵ����Ա!',1);
    application.Terminate;
    exit;
  end;     {}

  { user_ptr:='1037';
  rkey73:='2522' ;  //  1679
  dm.ADOConnection.ConnectionString:='Provider=SQLOLEDB.1;Password=wisdomtopcb1077;'
  +'Persist Security Info=True;User ID=wzsa;Initial Catalog=sj_v20_live;Data Source=172.16.68.8';
  dm.ADOConnection.Open;
  vprev:='4';}

   
  with DM.ADOQuery1 do
  begin
    Close;
    SQL.Clear;
    SQL.Text:='select EMPLOYEE_PTR,d5.EMPLOYEE_NAME from data0073 d3 join data0005 d5 on d5.rkey=d3.EMPLOYEE_PTR where  d3.rkey='+rkey73;
    Open;
    user_ptr:=Fields[0].AsString;
    vEMPLOYEE_NAME:= Fields[1].AsString;
    Close;
  end;
  self.Caption:=application.Title;
  DateSeparator := '-';
  ShortDateFormat := 'yyyy-mm-dd';

  with DM.ADOQuery1 do
  begin
    Close;
    SQL.Clear;
    SQL.Text:='select SUPLFEDSHIP,SUPLFEDMAT,SUPLFEDMISC from data0192';
    Open;
    if  IsEmpty=False then
    begin
      vSUPLFEDSHIP :=FieldByName('SUPLFEDSHIP').AsString;
      vSUPLFEDMAT  :=FieldByName('SUPLFEDMAT').AsString;
      vSUPLFEDMISC :=FieldByName('SUPLFEDMISC').AsString;
    end;
    Close;
  end;
  curr_date := getsystem_date(dm.adoquery1,1);
  dtpk1.Date:= strtodate(formatdatetime('yyyy-mm-dd',curr_date))-7;
  dtpk2.Date:= strtodate(formatdatetime('yyyy-mm-dd',curr_date))+1;

  FilterFieldName:='NUMBER';
  with dm.ADOQuery1 do
  begin
    Close;
    SQL.Clear;
    sql.Text:='select unusual_cate from data0043';
    Open;
    DisableControls;
    First;
    cbb_fail_type.Clear;
    while not Eof do
    begin
      cbb_fail_type.Items.Add(FieldValues['unusual_cate']);
      Next;
    end;
    EnableControls;
  end;
  with DM.qry0073 do
  if  Active=False  then
  Open;

  if (StrToInt(vprev) = 4)  then
  begin
    dghChild.FieldColumns['BeginTime'].ReadOnly:=False;
    dghChild.FieldColumns['EndTime'].ReadOnly:=False;
    dghChild.FieldColumns['TimeRest'].ReadOnly:=False;
    dghChild.FieldColumns['Remark'].ReadOnly:=False;
  end;
end;

function TForm1.find_error(v_rkey, v_status: Integer): Boolean;
begin
  with dm.ADOQuery1 do
  begin
    Close;
    sql.Text:='select rkey from data0567 '+
              'where rkey='+inttostr(v_rkey)+
              ' and status='+inttostr(v_status);
    open;
  end;
  if dm.ADOQuery1.IsEmpty then
    Result:=True
  else
    result:=false;
end;

procedure tform1.item_click(sender:TObject);
var i:byte;
begin
  (sender as tmenuItem).Checked := not ((sender as tmenuItem).Checked);
  if (sender as tmenuItem).Checked then
  begin
    for i:=0 to DBGridEh1.FieldCount-1 do
    if DBGridEh1.Columns[i].Title.Caption=(sender as tmenuItem).Caption then
    begin
    DBGridEh1.Columns[i].Visible:=true;
    break;
    end;
  end
  else
  begin
    for i:=0 to DBGridEh1.FieldCount-1 do
    if DBGridEh1.Columns[i].Title.Caption=(sender as tmenuItem).Caption then
    begin
      DBGridEh1.Columns[i].Visible:=false;
      break;
    end;
  end;
end;

procedure TForm1.BitBtn6Click(Sender: TObject);
begin
  N_ColumnsSetClick(nil)
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
  close;
  application.Terminate;
end;

procedure TForm1.FormShow(Sender: TObject);
var
 i:integer;
 item:TMenuItem;
begin
  if  dm.ADOConnection.Connected then
  begin
    self.PageControl1.ActivePageIndex:=0;
    CheckBox0Click(nil);
    BitBtn11Click(nil)   ;
    PreColumn := DBGridEH1.Columns[0];
    for i:=1 to DBGrideh1.Columns.Count do
    begin
      item := TmenuItem.Create(self) ;
      item.Caption := dbgrideh1.Columns[i-1].Title.Caption ;
      if dbgrideh1.Columns[i-1].Visible then
        item.Checked := true ;
      item.OnClick := item_click ;
      self.PopupMenu2.Items.Add(item) ;
    end;
    with dm.ADOQuery1 do
    begin
      close;
      sql.Text:='select empl_code,EMPLOYEE_NAME from data0005 '+
               'where rkey='+user_ptr;
      Open;
      self.empl_code:=fieldbyname('empl_code').AsString;
      self.empl_name:=fieldbyname('EMPLOYEE_NAME').AsString;
    end;
  end;

  if StrToInt(vprev)<>4 then
  begin
    dghChild.FieldColumns['BeginTime'].ReadOnly:=true;
    dghChild.FieldColumns['EndTime'].ReadOnly:=true;
    dghChild.FieldColumns['TimeRest'].ReadOnly:=true;   //��;��Ϣʱ��
  end
  ELSE
  begin
    dghChild.FieldColumns['BeginTime'].ReadOnly:=FALSE;
    dghChild.FieldColumns['EndTime'].ReadOnly:=FALSE;
    dghChild.FieldColumns['TimeRest'].ReadOnly:=FALSE;   //��;��Ϣʱ��
  end;
  ResetGridColumns(Self,DM.ADOConnection,StrToInt(rkey73),StrToInt(vprev)=2);

  Find_Curr_Date := getsystem_date(dm.adoquery1,1);
end;

procedure TForm1.Edit1Change(Sender: TObject);
begin
  with (DM.cds567) do
  if trim(Edit1.Text) <> '' then
  begin
    Filtered := False;
    Filtered := true;
  end
  else
    Filtered := False;
end;

procedure TForm1.DBGridEh1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (chr(key)='V') and (ssalt in shift) then
    showmessage(dm.cDS567.CommandText);
end;

procedure TForm1.DBGridEh1TitleClick(Column: TColumnEh);
var
  OldIndex: string;
begin
  with (Column.Grid.DataSource.DataSet as TClientDataSet) do
  begin
    OldIndex:= DM.cds567.IndexName;
    if OldIndex <> '' then
    begin
      IndexName:= '';
      DeleteIndex(OldIndex);
    end;
    case Column.Title.SortMarker of
      smNoneEh,
      smUpEh  :
      begin
        AddIndex('px', Column.Field.FieldName, [ixDescending]);
        Column.Title.SortMarker:= smDownEh;
      end;
      smDownEh:
      begin
        AddIndex('px', Column.Field.FieldName, [ixPrimary]);
        Column.Title.SortMarker:= smUpEh;
      end;
    end;
    IndexName:= 'px';
  end;
   if Column.Field.DataType in[ftString,ftWideString] then
   if UpperCase(Column.Field.FieldName)<>UpperCase(FilterFieldName) then
   begin
     Edit1.Text:='';
     FilterFieldName:= Column.Field.FieldName;
     Label1.Caption:=Column.Field.DisplayLabel;
     Edit1.Left:=Label1.Left+5+ Label1.Width;
   end;
end;

procedure TForm1.BitBtn3Click(Sender: TObject);
begin
  DM.cds567.Refresh;
end;

procedure TForm1.CheckBox0Click(Sender: TObject);
begin
  strStatus:='';
  if (CheckBox0.Checked) and(CheckBox1.Checked) and( CheckBox2.Checked )and( CheckBox3.Checked)
                     and (CheckBox4.Checked) and (CheckBox5.Checked) and (CheckBox6.Checked) then
  begin
    Exit;
  end;
  if CheckBox0.Checked then
  strStatus:='0,';

  if checkbox1.Checked then
  strStatus:=strStatus+'1,';

  if checkbox2.Checked then
  strStatus:=strStatus+'2,';

  if checkbox3.Checked then
  strStatus:=strStatus+'3,';

  if checkbox4.Checked then
  strStatus:=strStatus+'4,';

  if checkbox5.Checked then
  strStatus:=strStatus+'5,';

  if checkbox6.Checked then
  strStatus:=strStatus+'6,';

  if  strStatus<>'' then
    strStatus:=#13+'and  status in ('+Copy( strStatus,0,Length(strStatus)-1)+')';
end;

procedure TForm1.N1Click(Sender: TObject);
var
  vNUMBER:string;
begin
  try
    Screen.Cursor := crHourGlass;
    if (strtoint(vprev)=1)  then
      messagedlg('�Բ���,��ֻ�б������ֻ��Ȩ��',mtinformation,[mbok],0)
    else
    if not Self.find_error(dm.cDS567RKEY.Value,dm.cDS567STATUS.Value) then
    begin
      if EmployeeStatusCheck(user_ptr,vNUMBER)  then
      begin
        Exit;
      end;
      if messagebox(Self.Handle,'��ȷ��Ҫ��ʼ������','ѯ��',MB_YESNO)=idNo then
      begin
        Exit;
      end;
      if not Self.find_error(dm.cDS567RKEY.Value,dm.cDS567STATUS.Value) then
      begin
        try
          DM.ADOConnection.BeginTrans;
          dm.cDS567.Edit;
          dm.cDS567disposal_emplptr.Value:=StrToInt(user_ptr);
          dm.cDS567maintain_empl.Value:= vEMPLOYEE_NAME;
          dm.cDS567disposal_date.Value:= getsystem_date(dm.adoquery1,0);
          dm.cDS567STATUS.Value:=2;
          if  DM.cds567D417_D840_ptr.IsNull=False then
          DM.cds567D840_ptr.Value :=  DM.cds567D417_D840_ptr.Value;
          if  DM.cds567D417_Location.IsNull=False then
          DM.cds567Location.Value := DM.cds567D417_Location.Value;
          dm.cDS567.Post;
          if dm.cDS567.ApplyUpdates(0)=0 then
          begin
            with  DM.cmdUpdate1 do            //��DATA0841�����һ�иı�״̬�ļ�¼��
            begin
              CommandText:='insert into [dbo].[DATA0841]([D567_ptr],[User_ptr],[Status_ptr],[Record_date])'
                    +'values('+DM.cDS567RKEY.AsString+','+rkey73+','+dm.cDS567STATUS.AsString+','
                    +QuotedStr(FormatDateTime('yyyy-MM-dd H:mm:ss',dm.cDS567disposal_date.Value))+')';
              Execute;                                              //�Զ����ά�������ά����Ա��¼��
              CommandText:='insert into data0842(Work_ptr,WorkDate,BeginTime,Empl_ptr,[Status])values('
              +DM.cDS567RKEY.AsString+',CONVERT(VARCHAR(10),GETDATE(),120),'
              + QuotedStr(FormatDateTime('yyyy-MM-dd H:mm:ss',dm.cDS567disposal_date.Value))
              +','+user_ptr+','+'3' +')' ;
              Execute;
            end;
            DM.ADOConnection.CommitTrans;
          end
          else
          begin
            dm.ADOConnection.RollbackTrans;
          end;
        except  on E: Exception do
          begin
            dm.ADOConnection.RollbackTrans;
            messagedlg(E.Message,mterror,[mbcancel],0);
          end;
        end;
      end;
      dm.cDS567.Refresh;
      with dm.cds842 do
      begin
        Close;
        Params.ParamByName('vWork_ptr').Value:=dm.cDS567RKEY.Value;
        Open;
      end;
      SetStatus;
    end;
  finally    
    Screen.Cursor := crDefault;
  end;
end;

procedure TForm1.N4Click(Sender: TObject);
begin
  try
    Screen.Cursor := crHourGlass;
    if (strtoint(vprev)=1)  then
    begin
      messagedlg('�Բ���,��ֻ�б������ֻ��Ȩ��',mtinformation,[mbok],0);
      Exit;
    end;
    if messagebox(Self.Handle,'��ȷ��Ҫȡ��������','ѯ��',MB_YESNO)=idNo then
    begin
      Exit;
    end;
    if (dm.cDS567disposal_emplptr.Value<>StrToInt(user_ptr))and(strtoint(vprev)<>4) then
    begin
      messagedlg('ֻ�������˲���ȡ���������������Ȩ�ޣ�',mtinformation,[mbok],0);
      Exit;
    end;

    if not Self.find_error(dm.cDS567RKEY.Value,dm.cDS567STATUS.Value) then
    begin
      try
        DM.ADOConnection.BeginTrans;
        dm.cDS567.Edit;
        dm.cDS567disposal_emplptr.AsVariant:=null;
        dm.cDS567disposal_date.AsVariant:= null;
        dm.cDS567STATUS.Value:=1;
        dm.cDS567.FieldByName('stop_house').Value:=Null;
        dm.cDS567.Post;
        if dm.cDS567.ApplyUpdates(0)=0 then
        begin
          with  DM.cmdUpdate1 do
          begin
            //��DATA0841�����һ�иı�״̬�ļ�¼��
            CommandText:='insert into [dbo].[DATA0841]([D567_ptr],[User_ptr],[Status_ptr],[Record_date])'
                  +'values('+DM.cDS567RKEY.AsString+','+rkey73+','+dm.cDS567STATUS.AsString+','
                  +QuotedStr(FormatDateTime('yyyy-MM-dd H:mm:ss',getsystem_date(dm.adoquery1,0)))+')';
            Execute;

            //ɾ��ά����Ա��ͣ��Ϣ
            if dm.cds842.FieldByName('rkey').IsNull=False then
            begin
              CommandText:='delete data0843 where Work_ptr='+dm.cds842.FieldByName('rkey').AsString;
              Execute  ;
            end;

            // ɾ��ά�������ά����Ա��¼��
            CommandText:='delete data0842 where Work_ptr= '+ DM.cDS567RKEY.AsString;
            Execute;

            //ɾ��ά�޵���ͣ��Ϣ
            CommandText:='delete data0577 where rkey567= '+ DM.cDS567RKEY.AsString;
            Execute;
          end;
          DM.ADOConnection.CommitTrans;
        end
        else
          dm.ADOConnection.RollbackTrans;
      except
        on E: Exception do
        begin
          if dm.ADOConnection.InTransaction=true then
          dm.ADOConnection.RollbackTrans;
          messagedlg(E.Message,mterror,[mbcancel],0);
          DM.cds567.Cancel;
          DM.cds567.CancelUpdates;
        end;
      end;
      DM.cds842.Close;
      DM.cds842.Open;
      DM.cds567.Refresh;
      SetStatus;
    end;
  finally    
    Screen.Cursor := crDefault;
  end;
end;

procedure TForm1.PopupMenu1Popup(Sender: TObject);
begin
  n1.Enabled  :=(dm.cDS567STATUS.Value in[1,8])and(StrToInt(vprev)in [2,3,4]);   //��ʼ����
  N14.Enabled :=(dm.cDS567STATUS.Value=1)                                    ;   //�������û�����
  n4.Enabled  :=(dm.cDS567STATUS.Value=2) and(StrToInt(vprev)in [2,3,4]);        //ȡ������
  n16.Enabled :=(dm.cDS567STATUS.Value=2)                                  ;     //�������û�ȡ������ //and(StrToInt(vprev)in [2,4])
  N_Complete.Enabled  :=(dm.cDS567STATUS.Value=2) and(StrToInt(vprev)in [2,3,4]);//�깤����
  N15.Enabled :=(dm.cDS567STATUS.Value=2)                                       ;//�������û��깤
  n6.Enabled  :=(dm.cDS567STATUS.Value=3)and(StrToInt(vprev)in [2,3,4]);         //ȡ���깤
  n20.Enabled :=(dm.cDS567STATUS.Value=3)                                       ;//�������û�ȡ���깤  // and(StrToInt(vprev)in [2,4])
  N7.Enabled      :=(n1.Enabled)        and(StrToInt(vprev)in [  4]);            //�˻�����
  N9.Enabled      :=(dm.cDS567STATUS.Value in [2,3])and(StrToInt(vprev)in [2,3,4]);//�༭ά�޼�¼
  N17.Enabled     :=(DM.cDS567STATUS.Value in[2,4,5,6])                         ;//�������û�ά����ͣ    ,3,4,5,6
  N_EndPause.Enabled     :=(DM.cDS567STATUS.Value=6)and(StrToInt(vprev)in [2,3,4]);//��ͣ����
  N_OtherEndPause.Enabled     :=(DM.cDS567STATUS.Value=6);                       //�������û���ͣ����
end;

procedure TForm1.N_CompleteClick(Sender: TObject);
var
  f_Staff_Sum_house :real;
begin
  if (strtoint(vprev)=1) then
  begin
    messagedlg('�Բ���,��ֻ�б������ֻ��Ȩ��',mtinformation,[mbok],0);
    Exit;
  end;
        //�����ǰ�����û�<>������ �Ͳ������Ȩ�ޣ��������깤
  if (DM.cDS567disposal_emplptr.Value<>StrToInt(user_ptr))and(strtoint(vprev)<>4) then
  begin
    MessageDlg('��û�и�ά�޵��깤��Ȩ�ޣ�ֻ�������˻����Ȩ���˲ſ��깤��',mtInformation,[mbOK],0);
    Exit;
  end;
  with DM.cds842  do
  begin
    if (State in[dsInsert ,dsEdit])then
    Post;
    if(changeCount>0)then
    ApplyUpdates(0);

    if(changeCount>0)then
    Exit;
  end;
  with DM.ADOQuery1 do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select * from data0842 where [Work_ptr]=' +dm.cDS567RKEY.AsString);
    SQL.Add(' and [Status]in(3,6) ');
    Open;
    if IsEmpty=False then
    begin
      ShowMessage('��ϸ����״̬�ǡ�ִ���С��Ĺ�Ա��¼�����Ƚ���������');
      Exit;
    end;
  end;
  with DM.ADOQuery1 do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select rkey from data0577 where rkey567= '+dm.cDS567RKEY.AsString);
    SQL.Add(' and stop_end_date>getdate() ');            //��ѯ��ǰ��ͣ��¼���Ƿ��д��ڵ�ǰʱ��ļ�¼
    Open;
    if not IsEmpty then
    begin
      messagedlg('��ͣ����ʱ�䲻�ܴ���ϵͳʱ�䣡',mterror,[mbok],0);
      Exit;
    end;
  end;
  if (trim(dm.cDS567fail_type.Value)='') or (trim(dm.cDS567maintain_empl.Value)='') or (trim(dm.cDS567maintain_text.Value)='') then
  begin
    messagedlg('�Բ���,��������ά����Ϣ!',mtinformation,[mbok],0);
    PageControl1.TabIndex:=1;
    cbb_fail_type.SetFocus;
    exit;
  end;
  if dm.cDS567D840_ptr.IsNull then
  begin
    messagedlg('���豸����С�顱��ֵ����Ϊ�գ�����',mtinformation,[mbok],0);
    PageControl1.TabIndex:=1;
    edt_Location.SetFocus;
    exit;
  end;

  if messagebox(Self.Handle,'��ȷ��Ҫ�깤��','ѯ��',MB_YESNO)=idNo then
  begin
    Exit;
  end;

  if not Self.find_error(dm.cDS567RKEY.Value,dm.cDS567STATUS.Value) then
  begin
    try
      DM.ADOConnection.BeginTrans;
      begin
        dm.cDS567.Edit;
        DM.cDS567STATUS.Value:=3;
        DM.cDS567complete_date.Value:= getsystem_date(dm.adoquery1,0);
        DM.cDS567completion_emplptr.Value:=StrToInt(user_ptr);

        with DM.cds842 do
        begin
          DisableControls;
          First;
          f_Staff_Sum_house:=0;
          while not Eof do
          begin
            if FieldByName('WorkTime').Value>0  then
            f_Staff_Sum_house:= f_Staff_Sum_house+ FieldByName('WorkTime').Value;
            Next;
          end;
          EnableControls;

          DM.cDS567Staff_Sum_house.Value:=  f_Staff_Sum_house ;
        end;
        DM.cDS567.Post;
      end;
      if DM.cDS567.ApplyUpdates(0)=0 then
      begin
        with  DM.cmdUpdate1 do            //��DATA0841�����һ�иı�״̬�ļ�¼��
        begin
          CommandText:='insert into [dbo].[DATA0841]([D567_ptr],[User_ptr],[Status_ptr],[Record_date])'
                +'values('+DM.cDS567RKEY.AsString+','+rkey73+','+dm.cDS567STATUS.AsString+','
                +QuotedStr(FormatDateTime('yyyy-MM-dd H:mm:ss',DM.cDS567complete_date.Value))+')';
          Execute;
        end;
        DM.ADOConnection.CommitTrans;
      end
      else
        dm.ADOConnection.RollbackTrans;
      
    except
      on E: Exception do
      begin
        dm.ADOConnection.RollbackTrans;
        messagedlg(E.Message,mterror,[mbcancel],0);
      end;
    end;
    DM.cds567.Refresh;
    DM.cds842.Refresh;
    SetStatus;
  end;
end;

procedure TForm1.N6Click(Sender: TObject);
begin
  try
    Screen.Cursor := crHourGlass;
    if (strtoint(vprev)=1)  then
    begin
      messagedlg('�Բ���,��ֻ�б������ֻ��Ȩ��',mtinformation,[mbok],0);
      Exit;
    end;

    if messagebox(Self.Handle,'��ȷ��Ҫȡ���깤��','ѯ��',MB_YESNO)=idNo then
    begin
      Exit;
    end;

    if (DM.cDS567completion_emplptr.Value<>StrToInt(user_ptr))and(strtoint(vprev)<>4) then
    begin
      MessageDlg('��û�и�ά�޵�ȡ���깤��Ȩ��,ֻ���깤�˻����Ȩ���˲ſ��깤��',mtInformation,[mbOK],0);
      Exit;
    end;

    if not Self.find_error(dm.cDS567RKEY.Value,dm.cDS567STATUS.Value) then
    begin
      try
        DM.ADOConnection.BeginTrans;
        dm.cDS567.Edit;
        dm.cDS567complete_date.AsVariant  := null;
        DM.cDS567completion_emplptr.AsVariant := null;
        dm.cDS567STATUS.Value:=2;
        dm.cDS567.Post;
        if dm.cDS567.ApplyUpdates(0)=0 then
        begin
          with  DM.cmdUpdate1 do            //��DATA0841�����һ�иı�״̬�ļ�¼��
          begin
            CommandText:='insert into [dbo].[DATA0841]([D567_ptr],[User_ptr],[Status_ptr],[Record_date])'
                  +'values('+DM.cDS567RKEY.AsString+','+rkey73+','+dm.cDS567STATUS.AsString+','
                  +QuotedStr(FormatDateTime('yyyy-MM-dd H:mm:ss',getsystem_date(dm.adoquery1,0)))+')';
            Execute;
          end;

          DM.ADOConnection.CommitTrans;
        end
        else
          dm.ADOConnection.RollbackTrans;

      except
        on E: Exception do
        begin
          dm.ADOConnection.RollbackTrans;
          messagedlg(E.Message,mterror,[mbcancel],0);
        end;
      end;
      dm.cDS567.Refresh;
      DM.cds842.Refresh;
      SetStatus;
    end;
  finally    
    Screen.Cursor := crDefault;
  end;
end;

procedure TForm1.Exec_EndPause(vEmployeeRkey:string);
var
  vNUMBER:string;
  NowDate:TDateTime;
  strSQL:string;
begin
  try
    Screen.Cursor := crHourGlass;
    if EmployeeStatusCheck(vEmployeeRkey,vNUMBER) then
    begin
      Exit;
    end;

    NowDate:= getsystem_date(dm.adoquery1,0) ;
    try
      with DM.cds842 do
      if Active then
      begin
        Append;
        if DM.cds0005.Active=False then
          DM.cds0005.Open;
        if DM.cds0005.Locate('rkey',vEmployeeRkey,[])   then
        begin
          FieldByName('Work_ptr').Value:=DM.cds567RKEY.Value;
          FieldByName('WorkDate').Value:=Date;
          FieldByName('BeginTime').Value:=NowDate;
          FieldByName('Status').Value:=3;
          FieldByName('TimeRest').Value:=2.5;
          FieldByName('Empl_ptr').Value:=DM.cds0005Rkey.Value;
          FieldByName('EMPL_CODE').Value:=DM.cds0005EMPL_CODE.Value;
          FieldByName('EMPLOYEE_NAME').Value:=DM.cds0005EMPLOYEE_NAME.Value;
          Post;

          DM.ADOConnection.BeginTrans;
          if ApplyUpdates(0) =0 then
          begin
            DM.cds567.Edit;
            DM.cds567STATUS.Value:=2;
            DM.cds567.Post;
            begin
              with dm.cmdUpdate1 do
              begin
                Close;          //����ͣ��¼�Ľ���ʱ����д��
                CommandText:='update dbo.DATA0577 set stop_end_date=getdate() where rkey567='+dm.cds567RKEY.AsString +' and stop_end_date is null';
                Execute;
                //��DATA0841�����һ�иı�״̬�ļ�¼��
                Close;  
                CommandText:='insert into [dbo].[DATA0841]([D567_ptr],[User_ptr],[Status_ptr],[Record_date])'
                      +'values('+DM.cDS567RKEY.AsString+','+rkey73+','+dm.cDS567STATUS.AsString+','
                      +QuotedStr(FormatDateTime('yyyy-MM-dd H:mm:ss',NowDate))+')';
                Execute;
              end;

              strSQL:= 'select isnull(cast(sum(datediff(minute,[stop_begin_date],[stop_end_date]))as dec(10,2))/60,0)  '
                 +' from data0577 where rkey567='+dm.cDS567.FieldByName('rkey').AsString ;

              with DM.cDS567 do
              begin
                Edit;
                FieldByName('stop_house').Value:= SQLResultValue(DM.ADOQuery1,strSQL);
                Post;
                if ApplyUpdates(0)<>0 then
                DM.ADOConnection.RollbackTrans;
              end;
              DM.ADOConnection.CommitTrans;
            end;
          end
          else
          begin
            DM.ADOConnection.RollbackTrans;
          end;
        end;
        DM.cds567.Refresh;
        DM.cds567AfterScroll(nil);
        DM.DataSource1StateChange(nil);
      end;
    except
      DM.ADOConnection.RollbackTrans;
    end;
  finally    
    Screen.Cursor := crDefault;
  end;    
end;

procedure TForm1.N7Click(Sender: TObject);
begin
  if messagedlg('��ȷ��Ҫ�˻ظù���������?',mtConfirmation,[mbyes,mbno],0)=mryes then
  if not Self.find_error(dm.cDS567RKEY.Value,dm.cDS567STATUS.Value) then
  begin
    Form_Return:=TForm_Return.Create(Application);
    Form_Return.Caption:='�˻�ԭ��';
    Form_Return.Label1.Caption:='�˻�ԭ��:';
    if Form_Return.ShowModal=mrok then
    begin
      try
        DM.ADOConnection.BeginTrans;
        dm.cDS567.Edit;
        dm.cDS567disposal_emplptr.Value:=StrToInt(user_ptr);
        dm.cDS567disposal_date.Value:= getsystem_date(dm.adoquery1,0);
        dm.cDS567maintain_text.Value:=Form_Return.Memo1.Lines.Text;
        dm.cDS567STATUS.Value:=5;
        dm.cDS567.Post;
        if dm.cDS567.ApplyUpdates(0)<>0 then
        begin
          dm.ADOConnection.RollbackTrans;
        end;

        with  DM.cmdUpdate1 do            //��DATA0841�����һ�иı�״̬�ļ�¼��
        begin
          CommandText:='insert into [dbo].[DATA0841]([D567_ptr],[User_ptr],[Status_ptr],[Record_date])'
                +'values('+DM.cDS567RKEY.AsString+','+rkey73+','+dm.cDS567STATUS.AsString+','
                +QuotedStr(FormatDateTime('yyyy-MM-dd H:mm:ss',dm.cDS567disposal_date.Value))+')';
          Execute;
        end;
        DM.ADOConnection.CommitTrans;
      except
        on E: Exception do
        begin
          dm.ADOConnection.RollbackTrans;
          messagedlg(E.Message,mterror,[mbcancel],0);
        end;
      end;
      BitBtn3Click(Sender);
    end;
  end;
end;

procedure TForm1.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
begin
  if dm.cDS567status.Value = 2 then
     DBGridEh1.Canvas.Font.Color := clred
  else if dm.cDS567status.Value = 1 then
     DBGridEh1.Canvas.Font.Color := clTeal
  else if dm.cDS567status.Value = 0 then
     DBGridEh1.Canvas.Font.Color := clfuchsia
  else if dm.cDS567status.Value = 3 then
     DBGridEh1.Canvas.Font.Color := clGreen
  else if DM.cDS567status.Value= 6 then
     DBGridEh1.Canvas.Font.Color:=clFuchsia;
  DBGridEh1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TForm1.N_PauseClick(Sender: TObject);
var
  frmPause: TfrmPause;
begin
  frmPause:= TfrmPause.Create(Application);
  try
    with frmPause   do
    begin
      vEmplRkey:=StrToInt(user_ptr);
      vRights:=StrToInt(vprev);
      with  DM.qry577 do
      begin
        Close;
        Parameters.ParamByName('vRkey567').Value:=DM.cDS567RKEY.Value;
        Open;
      end;

      ShowModal;
    end;
  finally
    frmPause.Free;
  end;
end;

procedure TForm1.BitBtn9Click(Sender: TObject);
begin
  Frm_unusual_cate:=TFrm_unusual_cate.Create(Application);
  Frm_unusual_cate.ADO43.Open;
  Frm_unusual_cate.ShowModal;
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
  CheckBox0Click(nil);
  WindowState:= wsMaximized;
end;

procedure TForm1.N14Click(Sender: TObject);
var
  vUsernameRkey,vEmployeeRkey,vUser_rights,vNUMBER:string;
begin
  try
    Screen.Cursor := crHourGlass;
    if ShowResetUsernameForm(Self,dm.ADOConnection,vUsernameRkey, vEmployeeRkey,vUser_rights,'�������û�����') then
    begin
      if (strtoint(vUser_rights)in [2,3,4])=False then
      begin
        messagedlg('�Բ���,��û�������Ȩ�ޣ�',mtinformation,[mbok],0)  ;
        Exit ;
      end;
      if EmployeeStatusCheck(vEmployeeRkey,vNUMBER)  then
      begin
        Exit;
      end;
      if not Self.find_error(dm.cDS567RKEY.Value,dm.cDS567STATUS.Value) then
      begin
        try
          if DM.cds0005.Active=False then
          DM.cds0005.Open;
          dm.cDS567.Edit;
          dm.cDS567disposal_emplptr.Value:=StrToInt(vEmployeeRkey);
          dm.cDS567disposal_date.Value:= getsystem_date(dm.adoquery1,0);
          dm.cDS567maintain_empl.Value:=DM.cds0005.Lookup('rkey',vEmployeeRkey,'EMPLOYEE_NAME') ;
          dm.cDS567STATUS.Value:=2;
          dm.cDS567.Post;

          DM.ADOConnection.BeginTrans;
          if dm.cDS567.ApplyUpdates(0)=0 then
          begin
            with  DM.cmdUpdate1 do            //��DATA0841�����һ�иı�״̬�ļ�¼��
            begin
              CommandText:='insert into [dbo].[DATA0841]([D567_ptr],[User_ptr],[Status_ptr],[Record_date])'
                    +'values('+DM.cDS567RKEY.AsString+','+vUsernameRkey+','+dm.cDS567STATUS.AsString+','
                    +QuotedStr(FormatDateTime('yyyy-MM-dd H:mm:ss',dm.cDS567disposal_date.Value))+')';
              Execute;
                                              //�Զ����ά�������ά����Ա��¼��
              CommandText:='insert into data0842(Work_ptr,WorkDate,BeginTime,Empl_ptr,[Status])values('
              +DM.cDS567RKEY.AsString+',CONVERT(VARCHAR(10),GETDATE(),120),'//getDate()'
              +QuotedStr(FormatDateTime('yyyy-MM-dd H:mm:ss',dm.cDS567disposal_date.Value))
              +','+vEmployeeRkey+','+'3' +')' ;
              Execute;
            end;
            DM.ADOConnection.CommitTrans;
          end
          else
          begin
            dm.ADOConnection.RollbackTrans;
          end;
        except
          on E: Exception do
          begin
            dm.ADOConnection.RollbackTrans;
            messagedlg(E.Message,mterror,[mbcancel],0);
          end;
        end;
      end;
      dm.cDS567.Refresh;
      DM.cds842.Close;
      DM.cds842.Open;
      SetStatus;
    end;
  finally    
    Screen.Cursor := crDefault;
  end;
end;

procedure TForm1.N15Click(Sender: TObject);
var
  vUsernameRkey,vEmployeeRkey,vUser_rights:string;
  f_Staff_Sum_house :real;
begin
  with DM.cds842  do
  begin
    if (State in[dsInsert ,dsEdit])then
    Post;
    if(changeCount>0)then
    ApplyUpdates(0);

    if(changeCount>0)then
    Exit;
  end;
  with DM.ADOQuery1 do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select * from data0842 where [Work_ptr]=' +dm.cDS567RKEY.AsString);
    SQL.Add(' and [Status]in(3,6) ');
    Open;
    if IsEmpty=False then
    begin
      ShowMessage('��ϸ����״̬�ǡ�ִ���С��Ĺ�Ա��¼�����Ƚ���������');
      Exit;
    end;
  end;
  with DM.ADOQuery1 do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select rkey from data0577 where rkey567= '+dm.cDS567RKEY.AsString);
    SQL.Add(' and stop_end_date>getdate() ');            //��ѯ��ǰ��ͣ��¼���Ƿ��д��ڵ�ǰʱ��ļ�¼
    Open;
    if not IsEmpty then
    begin
      messagedlg('��ͣ����ʱ�䲻�ܴ���ϵͳʱ�䣡',mterror,[mbok],0);
      Exit;
    end;
  end;
  if (trim(dm.cDS567fail_type.Value)='') or (trim(dm.cDS567maintain_empl.Value)='') or (trim(dm.cDS567maintain_text.Value)='') then
  begin
    messagedlg('�Բ���,��������ά����Ϣ!',mtinformation,[mbok],0);
    PageControl1.TabIndex:=1;
    cbb_fail_type.SetFocus;
    exit;
  end;
  if dm.cDS567D840_ptr.IsNull then
  begin
    messagedlg('���豸����С�顱��ֵ����Ϊ�գ�����',mtinformation,[mbok],0);
    PageControl1.TabIndex:=1;
    edt_Location.SetFocus;
    exit;
  end;

  if ShowResetUsernameForm(Self,dm.ADOConnection,vUsernameRkey, vEmployeeRkey,vUser_rights,'�������û��깤') then
  begin
    if (strtoint(vUser_rights)in [2,3,4])=False then
    begin
      messagedlg('�Բ���,��û���깤��Ȩ�ޣ�',mtinformation,[mbok],0);
      Exit;
    end;

        //�����ǰ�����û�<>������ �Ͳ������Ȩ�ޣ��������깤
    if (DM.cDS567disposal_emplptr.Value<>StrToInt(vEmployeeRkey))and(strtoint(vUser_rights)<>4) then
    begin
      MessageDlg('��û�и�ά�޵��깤��Ȩ�ޣ�ֻ�������˻����Ȩ���˲ſ��깤��',mtInformation,[mbOK],0);
      Exit;
    end;

    with DM.ADOQuery1 do
    begin
      Close;
      SQL.Clear;
      SQL.Add('select * from data0567 join data0577 on data0567.rkey= data0577.rkey567 ');
      SQL.Add('and data0567.disposal_date>data0577.stop_begin_date where data0567.rkey='+dm.cDS567RKEY.AsString);            //��ѯ��ǰ��ͣ��¼���Ƿ��д���ϵͳ��ǰʱ��ļ�¼
      Open;
      if not IsEmpty then
      begin
        messagedlg('����ʱ�䲻��С����ͣ��ʼʱ�䣡',mterror,[mbok],0);
        Exit;
      end;
    end;

    with DM.ADOQuery1 do
    begin
      Close;
      SQL.Clear;
      SQL.Add('select rkey from data0577 where rkey567= '+dm.cDS567RKEY.AsString);
      SQL.Add(' and stop_end_date>getdate() ');            //��ѯ��ǰ��ͣ��¼���Ƿ��д���ϵͳ��ǰʱ��ļ�¼
      Open;
      if not IsEmpty then
      begin
        messagedlg('��ͣ����ʱ�䲻�ܴ���ϵͳʱ�䣡',mterror,[mbok],0);
        Exit;
      end;
    end;

    if not Self.find_error(dm.cDS567RKEY.Value,dm.cDS567STATUS.Value) then
    begin
      try
        DM.ADOConnection.BeginTrans;
        begin
          dm.cDS567.Edit;
          DM.cDS567STATUS.Value:=3;
          DM.cDS567complete_date.Value:= getsystem_date(dm.adoquery1,0);
          DM.cDS567completion_emplptr.Value:=StrToInt(vEmployeeRkey);

          with DM.cds842 do
          begin
            DisableControls;
            First;
            f_Staff_Sum_house:=0;
            while not Eof do
            begin
              if FieldByName('WorkTime').Value>0  then    //����ʱ��
              f_Staff_Sum_house:= f_Staff_Sum_house+ FieldByName('WorkTime').Value;
              Next;
            end;
            EnableControls;

            DM.cDS567Staff_Sum_house.Value:=  f_Staff_Sum_house ;
          end;
          DM.cDS567.Post;
        end;
        if DM.cDS567.ApplyUpdates(0)=0 then
        begin
          with  DM.cmdUpdate1 do            //��DATA0841�����һ�иı�״̬�ļ�¼��
          begin
            CommandText:='insert into [dbo].[DATA0841]([D567_ptr],[User_ptr],[Status_ptr],[Record_date])'
                  +'values('+DM.cDS567RKEY.AsString+','+vUsernameRkey+','+dm.cDS567STATUS.AsString+','
                  +QuotedStr(FormatDateTime('yyyy-MM-dd H:mm:ss',DM.cDS567complete_date.Value))+')';
            Execute;
          end;
          DM.ADOConnection.CommitTrans;
        end
        else
          dm.ADOConnection.RollbackTrans;
      except
        on E: Exception do
        begin
          dm.ADOConnection.RollbackTrans;
          messagedlg(E.Message,mterror,[mbcancel],0);
        end;
      end;
      DM.cds567.Refresh;
      DM.cds842.Refresh;
      SetStatus;
    end;
  end;
end;

procedure TForm1.N16Click(Sender: TObject);
var
  vUsernameRkey,vEmployeeRkey,vUser_rights:string;
begin
  try
    Screen.Cursor := crHourGlass;
    if ShowResetUsernameForm(Self,dm.ADOConnection,vUsernameRkey, vEmployeeRkey,vUser_rights,'�������û�ȡ������') then
    begin
      if (strtoint(vUser_rights)in [2,3,4])=False then
      begin
        messagedlg('�Բ���,��û��ȡ�������Ȩ�ޣ�',mtinformation,[mbok],0)  ;
        Exit ;
      end;

      if (dm.cDS567disposal_emplptr.Value<>StrToInt(vEmployeeRkey))and(strtoint(vUser_rights)<>4) then
      begin
        messagedlg('ֻ�������˲���ȡ���������������Ȩ�ޣ�',mtinformation,[mbok],0);
        Exit;
      end;

      if not Self.find_error(dm.cDS567RKEY.Value,dm.cDS567STATUS.Value) then
      begin
        try
          DM.ADOConnection.BeginTrans;
          dm.cDS567.Edit;
          dm.cDS567disposal_emplptr.AsVariant:=null;
          dm.cDS567disposal_date.AsVariant:= null;
          dm.cDS567STATUS.Value:=1;
          dm.cDS567.FieldByName('stop_house').Value:=Null;
          dm.cDS567.Post;
          if dm.cDS567.ApplyUpdates(0)=0 then
          begin
            with  DM.cmdUpdate1 do
            begin
              //��DATA0841�����һ�иı�״̬�ļ�¼��
              CommandText:='insert into [dbo].[DATA0841]([D567_ptr],[User_ptr],[Status_ptr],[Record_date])'
                    +'values('+DM.cDS567RKEY.AsString+','+vUsernameRkey+','+dm.cDS567STATUS.AsString+','
                    +QuotedStr(FormatDateTime('yyyy-MM-dd H:mm:ss',getsystem_date(dm.adoquery1,0)))+')';
              Execute;

              //ɾ��ά����Ա��ͣ��Ϣ
              if dm.cds842.FieldByName('rkey').IsNull=False then
              begin
                CommandText:='delete data0843 where Work_ptr='+dm.cds842.FieldByName('rkey').AsString;
                Execute  ;
              end;
              // ɾ��ά�������ά����Ա��¼��
              CommandText:='delete data0842 where Work_ptr= '+ DM.cDS567RKEY.AsString;
              Execute;
              //ɾ��ά�޵���ͣ��Ϣ
              CommandText:='delete data0577 where rkey567= '+ DM.cDS567RKEY.AsString;
              Execute;
            end;
            DM.ADOConnection.CommitTrans;
          end
          else
            dm.ADOConnection.RollbackTrans;
        except
          on E: Exception do
          begin
            dm.ADOConnection.RollbackTrans;
            messagedlg(E.Message,mterror,[mbcancel],0);
          end;
        end;
        DM.cds842.Refresh;
        DM.cds567.Refresh;
        SetStatus;
      end;
    end;
  finally    
    Screen.Cursor := crDefault;
  end;
end;

procedure TForm1.N17Click(Sender: TObject);
var
  vUsernameRkey,vEmployeeRkey,vUser_rights:string;
begin
  if ShowResetUsernameForm(Self,dm.ADOConnection,vUsernameRkey, vEmployeeRkey,vUser_rights,'�������û���ͣ') then
  begin
    with frmPause   do
    begin
      vEmplRkey:=StrToInt(vEmployeeRkey);
      vRights:=StrToInt(vUser_rights);   // ��Ȩ�����ֵ���� frmPause���壬������SHOW�¼��жԱ��������ã����û��ܷ������
      with  DM.qry577 do
      begin
        Close;
        Parameters.ParamByName('vRkey567').Value:=DM.cDS567RKEY.Value;
        Open;
      end;
      ShowModal;
    end;
  end;
end;

procedure TForm1.N20Click(Sender: TObject);
var
  vUsernameRkey,vEmployeeRkey,vUser_rights:string;
begin
  try
    Screen.Cursor := crHourGlass;
    if ShowResetUsernameForm(Self,dm.ADOConnection,vUsernameRkey, vEmployeeRkey,vUser_rights,'�������û�ȡ���깤') then
    begin
      if (strtoint(vUser_rights)=1)  then
      begin
        messagedlg('�Բ���,��ֻ�б������ֻ��Ȩ��',mtinformation,[mbok],0);
        Exit;
      end;
      if (DM.cDS567completion_emplptr.Value<>StrToInt(vEmployeeRkey))and(strtoint(vUser_rights)<>4) then
      begin
        MessageDlg('��û�и�ά�޵�ȡ���깤��Ȩ��,ֻ���깤�˻����Ȩ���˲ſ��깤��',mtInformation,[mbOK],0);
        Exit;
      end;
      if not Self.find_error(dm.cDS567RKEY.Value,dm.cDS567STATUS.Value) then
      begin
        try
          DM.ADOConnection.BeginTrans;
          dm.cDS567.Edit;
          dm.cDS567complete_date.AsVariant  := null;
          DM.cDS567completion_emplptr.AsVariant := null;
          dm.cDS567STATUS.Value:=2;
          dm.cDS567.Post;
          if dm.cDS567.ApplyUpdates(0)=0 then
          begin
            with  DM.cmdUpdate1 do            //��DATA0841�����һ�иı�״̬�ļ�¼��
            begin
              CommandText:='insert into [dbo].[DATA0841]([D567_ptr],[User_ptr],[Status_ptr],[Record_date])'
                    +'values('+DM.cDS567RKEY.AsString+','+rkey73+','+dm.cDS567STATUS.AsString+','
                    +QuotedStr(FormatDateTime('yyyy-MM-dd H:mm:ss',getsystem_date(dm.adoquery1,0)))+')';
              Execute;
            end;
            DM.ADOConnection.CommitTrans;
          end
          else
            dm.ADOConnection.RollbackTrans;
        except
          on E: Exception do
          begin
            dm.ADOConnection.RollbackTrans;
            messagedlg(E.Message,mterror,[mbcancel],0);
          end;
        end;
        DM.cds567.Refresh;
        DM.cds842.Refresh;
        SetStatus;
      end;
    end;
  finally    
    Screen.Cursor := crDefault;
  end;
end;

procedure TForm1.N22Click(Sender: TObject);
begin
  if Assigned(frm_See)=False then
    Application.CreateForm(Tfrm_See, frm_See);
  with DM do
  begin
    qry_841.Close;
    qry_841.Parameters.ParamByName('vD567_ptr').Value:=cDS567rkey.Value;
    qry_841.Open;
    frm_See.DataSource1.DataSet:=qry_841;
    frm_See.Caption:='״̬��¼';
    frm_See.ShowModal;
  end;
end;

procedure TForm1.N23Click(Sender: TObject);
begin
  if Assigned(frm_See)=False then
    Application.CreateForm(Tfrm_See, frm_See);
  with DM do
  begin
    qry_841_1.Close;
    qry_841_1.Parameters.ParamByName('vD567_ptr').Value:=cDS567rkey.Value;
    qry_841_1.Open;
    frm_See.DataSource1.DataSet:=qry_841_1;
    frm_See.Caption:='Ͷ�߼�¼';
    frm_See.ShowModal;
  end;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
var
  s,i:integer;
begin
  with DM.cds842 do
  if Active and ((state in [dsInsert,dsEdit])or (changeCount>0))or
  (DM.cds567.Active and ((DM.cds567.state in [dsInsert,dsEdit])or (DM.cds567.changeCount>0)))then
  begin
    S:= messagedlg('���ݻ�û�б���,��Ҫ������?',mtconfirmation,[mbyes,mbno,mbcancel],0);
    if S = mryes  then
      begin
        if (state in [dsInsert,dsEdit]) then
        Post ;
        ApplyUpdates(0)  ;
        if  DM.cds567.state =dsEdit then
         DM.cds567.Post;
        DM.cds567.ApplyUpdates(0)  ;
      end
    else
    if S = mrcancel then
      abort;
  end ;
  SaveColsInfo(Self,StrToInt(rkey73));

  for I:=0 to  High(Query_Info ) do
  FreeAndNil(Query_Info[I]);
  for I:=0 to  High(DropDown_Info ) do
  FreeAndNil(DropDown_Info[I]);
end;

procedure TForm1.btn_SaveClick(Sender: TObject);
var
  f_Staff_Sum_house :real;
begin
  if DM.cds842.State in [dsInsert,dsEdit ]then
  DM.cds842.Post;
    if DM.cds842.Active then
    begin
      if DM.cds567STATUS.AsInteger in [3,4] then
      begin
        DM.cdsTemp.Close;               //�رպ������ݡ�
        DM.cdsTemp.Data:= DM.cds842.Data;
        with  DM.cdsTemp do
        begin
          First;
          f_Staff_Sum_house:=0;
          while not Eof do
          begin
            if FieldByName('WorkTime').Value>0  then    //����ʱ��
            f_Staff_Sum_house:= f_Staff_Sum_house+ FieldByName('WorkTime').Value;
            Next;
          end;
          if DM.cDS567.State<>dsEdit then DM.cDS567.Edit;
          DM.cDS567Staff_Sum_house.Value:=  f_Staff_Sum_house ;
          DM.cDS567.Post;
        end;
      end;
      DM.ADOConnection.BeginTrans;
      if DM.cds842.ApplyUpdates(0)=0 then
      begin
        if DM.cDS567.ApplyUpdates(0)=0 then
          DM.ADOConnection.CommitTrans
        else
          DM.ADOConnection.RollbackTrans;
      end
      else
        DM.ADOConnection.RollbackTrans;
      SetStatus;
    end;
end;

procedure TForm1.btn_CancelClick(Sender: TObject);
begin
  with DM.cds842 do
  if Active then
  begin
    Cancel;
    CancelUpdates;
  end;
  SetStatus;
end;

procedure TForm1.btn_DeleteClick(Sender: TObject);
var
  vUsernameRkey,vEmployeeRkey,vUser_rights:string;
  UniqueRecord:Boolean;
begin
  UniqueRecord:=False;
  with DM.qry0073 do
  if  Active=False  then
  Open;
  with DM.cds842 do
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
    if ShowResetUsernameForm(Self,dm.ADOConnection,vUsernameRkey, vEmployeeRkey,vUser_rights,'ɾ��',
          DM.qry0073.Lookup('EMPLOYEE_PTR',DM.cds842Empl_ptr.AsInteger,'USER_LOGIN_NAME')) then
    begin
      if (strtoint(vUser_rights)in [2,3,4])=False then
      begin
        messagedlg('�Բ���,��û��Ȩ�ޣ�',mtinformation,[mbok],0)  ;
        Exit ;
      end;
      if DM.cds842Empl_ptr.AsInteger<> StrToInt(vEmployeeRkey )then
      begin
        messagedlg('�Բ���,��ֻ�ܲ����Լ��Ĺ�ʱ��¼��',mtinformation,[mbok],0)  ;
        Exit ;
      end;
      if UniqueRecord then
      begin
        DM.cds567.Edit;
        DM.cds567.FieldByName('STATUS').Value:=1;
        DM.cds567.Post;
        if DM.cds567.ApplyUpdates(0) =0 then
        begin
          DM.cds842.Delete;
          DM.cds842.ApplyUpdates(0);
          SetStatus;
        end;
        DM.cds567.Refresh;
      end
      else
      begin
        DM.cds842.Delete;
        DM.cds842.ApplyUpdates(0);
        SetStatus;
      end;
    end;
  end;
end;

procedure TForm1.Button4Click(Sender: TObject);
  procedure Effective(Grid:TDBGridEh;var strMsg:string;NowDate:TDateTime;SelectedRowNo:Integer=0);
  var
    msg,AddSpaces:string;
  begin
    msg:='';
    if Grid.SelectedRows.Count>1 then
      AddSpaces:='               '  //15���ո�      //���к�ѡ�����ʱ����Ϣ�ַ����Ļ᲻һ���������㲻ͬ������
    else
      AddSpaces:='        ';
    with  DM.cds842  do
    begin
      if (FieldByName('BeginTime').AsDateTime>=NowDate) then
      begin
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
    with DM.ADOQuery1 do
    begin
      Close;
      SQL.Clear;                                                      //FormatDateTime('yyyy-m-d h:n:s',NowDate)
      SQL.Text:='insert into DATA0843([Work_ptr],[stop_begin_date],[remark]) '
      +' values('+DM.cds842.FieldByName('rkey').AsString+','+QuotedStr(FormatDateTime('yyyy-m-d h:n:s',NowDate))+','+QuotedStr(strReason)+')';

      ExecSQL;
    end;

    with DM.cds842 do
    begin
      Edit;
      FieldByName('Status').Value:=6;     //��״̬��Ϊ������ͣ ��     6	����ͣ
      Post;
    end;
  end;
var
  NowDate:TDateTime;
  strReason :string;
  vUsernameRkey,vEmployeeRkey,vUser_rights:string;
begin
  with DM.cds842 do
  if (Active)and( not IsEmpty) then
  if ShowResetUsernameForm(Self,dm.ADOConnection,vUsernameRkey, vEmployeeRkey,vUser_rights,
  '��Աά�޼�¼��ͣ',DM.qry0073.Lookup('EMPLOYEE_PTR',DM.cds842Empl_ptr.AsInteger,'USER_LOGIN_NAME')) then
  begin
    if (strtoint(vUser_rights)in [2,3,4])=False then
    begin
      messagedlg('�Բ���,��û��Ȩ�ޣ�',mtinformation,[mbok],0)  ;
      Exit ;
    end;
    if DM.cds842Empl_ptr.AsInteger<> StrToInt(vEmployeeRkey )then
    begin
      messagedlg('�Բ���,��ֻ�ܲ����Լ��Ĺ�ʱ��¼��',mtinformation,[mbok],0)  ;
      Exit ;
    end;

    if InputDlg(Self.Handle,'��ͣ','������ͣԭ��',strReason)=false then   //����û�����ȡ�����˳�
      Exit;
    if State in [dsEdit,dsInsert] then
      Post;
    NowDate:=getsystem_date(dm.adoquery1,0);
    if  Inspection(dghChild,NowDate) then    //������δͨ�����˳���
      Exit;
    try
      with   dghChild.DataSource.DataSet   do
      begin
        try
          try
            Screen.Cursor := crHourGlass;
            DM.ADOConnection.BeginTrans;
            Exec(NowDate,strReason);
            DM.ADOConnection.CommitTrans;
          finally
            Screen.Cursor := crDefault;
          end;
        except
          on e:Exception do
          begin
            DM.ADOConnection.RollbackTrans;
            Refresh;
            ShowMessage('�ύʧ�ܣ�'+#13#10+e.Message);
          end;
        end;
      end;
    finally
      SetStatus;       //���������ұ߰�ť��״̬��
    end;
  end;
end;

procedure TForm1.Button5Click(Sender: TObject);
  procedure Effective(Grid:TDBGridEh;var strMsg:string;NowDate:TDateTime;SelectedRowNo:Integer=0);
  var
    msg,AddSpaces:string;
  begin
    msg:='';
    if Grid.SelectedRows.Count>1 then
      AddSpaces:='               '  //15���ո�      //���к�ѡ�����ʱ����Ϣ�ַ����Ļ᲻һ���������㲻ͬ������
    else
      AddSpaces:='        ';  //8 ���ո�

    with DM.ADOQuery1 do
    begin
      Close;
      SQL.Clear;
      SQL.Text:='select * from DATA0843 where Work_ptr='+ DM.cds842.FieldByName('rkey').AsString
        +' and [stop_end_date] is null and [stop_begin_date]>='+QuotedStr(FormatDateTime('yyyy-m-d h:n:s',NowDate));
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
  begin    {���ܣ������û���ѡ�����л��Ƕ��У�����Effective���̶�ѡ���ļ�¼�н�����Ч��飬����Υ������Ϣд��strMsg��}
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
    with DM.qry0843 do
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
        Sum_Date:= DM.qry0843ResultTime.FieldList[0].Value;
        Prior;
      end;
    end;

    with DM.cds842 do
    begin
      Edit;
      FieldByName('Status').Value:=3;     //��״̬��Ϊ��ִ���� ��     3	ִ����
      FieldByName('TimeCons').Value :=Sum_Date;// DM.ADOQuery1.Fields[0].Value;  //��ͣʱ��
      Post;
    end;
    DM.ADOQuery1.Close;
  end;
var
  NowDate:TDateTime;
  vUsernameRkey,vEmployeeRkey,vUser_rights:string;
begin
  with DM.cds842 do
  if (Active)and( not IsEmpty) then
  if ShowResetUsernameForm(Self,dm.ADOConnection,vUsernameRkey, vEmployeeRkey,vUser_rights,
  '��ͣ����',DM.qry0073.Lookup('EMPLOYEE_PTR',DM.cds842Empl_ptr.AsInteger,'USER_LOGIN_NAME')) then
  begin
    if (strtoint(vUser_rights)in [2,3,4])=False then
    begin
      messagedlg('�Բ���,��û��Ȩ�ޣ�',mtinformation,[mbok],0)  ;
      Exit ;
    end;
    if DM.cds842Empl_ptr.AsInteger<> StrToInt(vEmployeeRkey )then
    begin
      messagedlg('�Բ���,��ֻ�ܲ����Լ��Ĺ�ʱ��¼��',mtinformation,[mbok],0)  ;
      Exit ;
    end;

    if State in [dsEdit,dsInsert] then
      Post;
    NowDate:=getsystem_date(dm.adoquery1,0);
    if  Inspection(dghChild,NowDate) then    //������δͨ�����˳���
      Exit;
    try
      DisableControls;
      with   dghChild.DataSource.DataSet   do
      begin
        try
          try
            Screen.Cursor := crHourGlass;
            DM.ADOConnection.BeginTrans;
            Exec(NowDate);
            DM.cds842.ApplyUpdates(0);
            DM.ADOConnection.CommitTrans;
          finally
            Screen.Cursor := crDefault;
          end;
        except
          on e:Exception do
          begin
            DM.ADOConnection.RollbackTrans;
            Refresh;
            ShowMessage('�ύʧ�ܣ�'+#13#10+e.Message);
          end;
        end;
      end;
    finally
      SetStatus;       //���������ұ߰�ť��״̬��
      EnableControls;
    end;
  end;
end;

procedure TForm1.Button6Click(Sender: TObject);
  procedure Exec(NowDate:TDateTime);
  begin
    with DM.cds842 do
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
  NowDate:=getsystem_date(dm.adoquery1,0);
  if (DM.cds842BeginTime.IsNull=False) then
    BeginTime:= HourOf(DM.cds842BeginTime.AsDateTime);

  if (DM.cds842endTime.IsNull=False) then
    endTime:= HourOf(DM.cds842endTime.AsDateTime)
  else
    endTime:= HourOf(NowDate);
  if DM.cds842BeginTime.IsNull =False then
  begin
    if   DM.cds842endTime.IsNull=False then
    begin
      if  DM.cds842endTime.Value<DM.cds842BeginTime.Value then
      begin
        ShowMessage('�������ڲ���С�ڿ�ʼ���ڣ�����');
        Exit;
      end;
    end
    else
    begin
      if  NowDate < DM.cds842BeginTime.Value then
      begin
        ShowMessage('�������ڲ���С�ڿ�ʼ���ڣ�����');
        Exit;
      end;
    end;
  end  ;

  if DM.cds842endTime.IsNull = False then
    NowDate:=  DM.cds842endTime.Value ;
  if ((BeginTime<8) and  (endTime>=8))or(MinutesBetween(DM.cds842BeginTime.Value,NowDate)>720) then
  begin
    S:=Show_Msg(Self,'������ȷ����İ��',['']);
    if s=1 then
      begin

      end
    else
    if  S=2 then
      begin
        if  DM.cds842.State<>dsEdit then    DM.cds842.Edit   ;
        DM.cds842.FieldByName('DayShift').Value:=2 ;
      end
    else
      Exit;
  end;

  if (DM.cds842.Active=False)or(  DM.cds842.IsEmpty) then
  Exit;
  with DM.cds567 do
  if (State =dsEdit) then
  begin
    Post;
    ApplyUpdates(0);
  end;

  if DM.cds842.State in [dsEdit,dsInsert] then
    DM.cds842.Post;

  NowDate:=getsystem_date(dm.adoquery1,0);
  with DM.ADOQuery1 do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select * from DATA0843 where Work_ptr='+dm.cds842rkey.AsString
             +' and stop_end_date>'+QuotedStr(FormatDateTime('yyyy-m-d h:n:s',NowDate)));
    Open;
    if IsEmpty=False then
    begin
      ShowMessage('��ͣ����ʱ�����ڵ�ǰϵͳʱ�䣡����');
      Exit;
    end;
  end;
  if  DM.cds842EndTime.IsNull=False then
  if  DM.cds842EndTime.Value<=DM.cds842BeginTime.Value then
  begin
    ShowMessage('����ʱ�䲻��С�ڻ���ڿ�ʼʱ�䣡����');
    Exit;
  end;
  try
    Screen.Cursor := crHourGlass;

    DM.cdsTemp.CloneCursor(DM.cds842 ,True);
    with DM.cdsTemp do    //����Ƿ�ֻ��һ��������δ��״̬
    begin
      IsLast:=True;
      First;
      while not Eof do
      begin                     //�������״̬�����ڡ��ѽ�����,�Ҳ��ǵ�ǰѡ���У�����ѭ��
        if (FieldByName('Status').AsInteger<>7)
             and (FieldByName('rkey').AsInteger<>DM.cds842.FieldByName('rkey').AsInteger) then
        begin
          islast:=False;
          break;
        end;
        Next;
      end;
    end;
    if IsLast=False then
      begin
        with DM.qry0073 do
        if  Active=False  then
        Open;
           
        if ShowResetUsernameForm(Self,dm.ADOConnection,vUsernameRkey, vEmployeeRkey,vUser_rights,
                 '��Աά�޼�¼����',DM.qry0073.Lookup('EMPLOYEE_PTR',DM.cds842Empl_ptr.AsInteger,'USER_LOGIN_NAME')) then
        begin
            if (strtoint(vUser_rights)in [2,3,4])=False then
            begin
              messagedlg('�Բ���,��û�н�����Ա��Ȩ�ޣ�',mtinformation,[mbok],0)  ;
              Exit ;
            end;
            if DM.cds842Empl_ptr.AsInteger<> StrToInt(vEmployeeRkey )then
            begin
              messagedlg('�Բ���,��ֻ�ܲ����Լ��Ĺ�ʱ��¼��',mtinformation,[mbok],0)  ;
              Exit ;
            end;
          NowDate:=getsystem_date(dm.adoquery1,0);
          Exec(NowDate)   ;
          DM.cds842.ApplyUpdates(0);
        end;
      end
    else
    begin
      if messagedlg('�������һ��״̬�ǡ�ִ���С��Ĺ�Ա��¼����Ҫ�깤��ά��������?'+#13
                 +'�깤��YES����ͣ��NO��',mtconfirmation,[mbyes,mbno],0)=mrYes then
        begin
          
          if (trim(dm.cDS567fail_type.Value)='') or (trim(dm.cDS567maintain_empl.Value)='')
                   or (trim(dm.cDS567maintain_text.Value)='') then
          begin
            messagedlg('�Բ���,��������ά����Ϣ!',mtinformation,[mbok],0);
            PageControl1.TabIndex:=1;
            cbb_fail_type.SetFocus;
            exit;
          end;

          if trim(dm.cDS567Location.Value)='' then
          begin
            messagedlg('�Բ���,��������ά����Ϣ!',mtinformation,[mbok],0);
            PageControl1.TabIndex:=1;
            edt_Location.SetFocus;
            exit;
          end;

          if dm.cDS567D840_ptr.IsNull then
          begin
            messagedlg('���豸����С�顱��ֵ����Ϊ�գ�����',mtinformation,[mbok],0);
            PageControl1.TabIndex:=1;
            edt_Location.SetFocus;
            exit;
          end;

          if (Trim(edt_FaultName.Text)='')and(btn_FaultName.Enabled) then
          if messagedlg('��û������������ƣ���ȷ������������?',mtconfirmation,[mbyes,mbcancel],0)=mrCancel then
          begin
            PageControl1.TabIndex:=1;
            edt_FaultName.SetFocus;
            exit;
          end;
          with DM.qry0073 do
          if  Active=False  then
          Open;
          if ShowResetUsernameForm(Self,dm.ADOConnection,vUsernameRkey, vEmployeeRkey,vUser_rights,
              'ά�޵��깤',DM.qry0073.Lookup('EMPLOYEE_PTR',DM.cds842Empl_ptr.AsInteger,'USER_LOGIN_NAME')) then
          begin
            if (strtoint(vUser_rights)in [2,3,4])=False then
            begin
              messagedlg('�Բ���,��û�н�����Ա��Ȩ�ޣ�',mtinformation,[mbok],0)  ;
              Exit ;
            end;
            if DM.cds842Empl_ptr.AsInteger<> StrToInt(vEmployeeRkey )then
            begin
              messagedlg('�Բ���,��ֻ�ܲ����Լ��Ĺ�ʱ��¼��',mtinformation,[mbok],0)  ;
              Exit ;
            end;
            NowDate:=getsystem_date(dm.adoquery1,0);
            try
              DM.ADOConnection.BeginTrans;
              dm.cDS567.Edit;
              DM.cDS567STATUS.Value:=3;
              DM.cDS567complete_date.Value:= NowDate;
              DM.cDS567completion_emplptr.Value:=StrToInt(vEmployeeRkey);
              with  DM.cmdUpdate1 do            //��DATA0841�����һ�иı�״̬�ļ�¼��
              begin
                CommandText:='insert into [dbo].[DATA0841]([D567_ptr],[User_ptr],[Status_ptr],[Record_date])'
                      +'values('+DM.cDS567RKEY.AsString+','+vUsernameRkey+','+dm.cDS567STATUS.AsString+','
                      +QuotedStr(FormatDateTime('yyyy-MM-dd H:mm:ss',DM.cDS567complete_date.Value))+')';
                Execute;
              end;
              Exec(DM.cDS567complete_date.Value);

              DM.cdsTemp.Close;               //�رպ����¸������ݡ�
              DM.cdsTemp.Data:= DM.cds842.Data;
              with  DM.cdsTemp do
              begin
                First;
                f_Staff_Sum_house:=0;
                while not Eof do
                begin
                  if FieldByName('WorkTime').Value>0  then    //����ʱ��
                  f_Staff_Sum_house:= f_Staff_Sum_house+ FieldByName('WorkTime').Value;
                  Next;
                end;
                DM.cDS567Staff_Sum_house.Value:=  f_Staff_Sum_house ;
              end;
              dm.cDS567.Post;
              if dm.cDS567.ApplyUpdates(0)=0 then
              begin
                if DM.cds842.ApplyUpdates(0)<>0 then
                begin
                dm.ADOConnection.RollbackTrans;
                Exit;
                end
              end
              else
                begin
                dm.ADOConnection.RollbackTrans;
                Exit;
                end ;
              DM.ADOConnection.CommitTrans;

              dm.cDS567.Refresh;
              DM.cds842.Refresh;
            except
              on e:Exception do
              begin
                DM.ADOConnection.RollbackTrans;
                DM.cds842.Refresh;
                ShowMessage('�ύʧ�ܣ�'+#13#10+e.Message);
              end
            end;
          end;
        end
      else
        begin
          if InputDlg(Self.Handle,'��ͣ','������ͣԭ��',strReason) then   //����û�����ȡ�����˳�
          begin
            with DM.qry0073 do
            if  Active=False  then
            Open;
            if ShowResetUsernameForm(Self,dm.ADOConnection,vUsernameRkey, vEmployeeRkey,vUser_rights,
            'ά�޵���ͣ',DM.qry0073.Lookup('EMPLOYEE_PTR',DM.cds842Empl_ptr.AsInteger,'USER_LOGIN_NAME')) then
            begin
              if (strtoint(vUser_rights)in [2,3,4])=False then
              begin
                messagedlg('�Բ���,��û�н�����Ա��Ȩ�ޣ�',mtinformation,[mbok],0)  ;
                Exit ;
              end;
              if DM.cds842Empl_ptr.AsInteger<> StrToInt(vEmployeeRkey )then
              begin
                messagedlg('�Բ���,��ֻ�ܲ����Լ��Ĺ�ʱ��¼��',mtinformation,[mbok],0)  ;
                Exit ;
              end;
              NowDate:=getsystem_date(dm.adoquery1,0);
              try
                DM.ADOConnection.BeginTrans;
                Exec(NowDate);
                if dm.cds842.ApplyUpdates(0)<>0 then
                begin
                  dm.ADOConnection.RollbackTrans;
                  Exit;
                end;

                if  DM.cDS567.State<>dsEdit then
                  DM.cDS567.Edit;
                DM.cDS567STATUS.AsInteger:=6 ;
                DM.cDS567.Post;
                if dm.cDS567.ApplyUpdates(0)<>0 then
                begin
                  dm.ADOConnection.RollbackTrans;
                  Exit;
                end;

                with DM.cmdUpdate1 do
                begin
                  CommandText:='insert into DATA0577([rkey567],[stop_begin_date],[remark]) '
                  +'values('+DM.cDS567.FieldByName('rkey').AsString+',CONVERT(varchar(100),GETDATE(),120)'+','+QuotedStr(strReason)+')';
                  Execute;

                  CommandText:='insert into [dbo].[DATA0841]([D567_ptr],[User_ptr],[Status_ptr],[Record_date])'
                        +'values('+DM.cDS567RKEY.AsString+','+vUsernameRkey+','+dm.cDS567STATUS.AsString+','
                        +QuotedStr(FormatDateTime('yyyy-MM-dd H:mm:ss',NowDate))+')';
                  Execute;
                end;

                DM.ADOConnection.CommitTrans;
                dm.cds567.Refresh;
              except
                on e:Exception do
                begin
                  DM.ADOConnection.RollbackTrans;
                  DM.cds842.Refresh;
                  ShowMessage('�ύʧ�ܣ�'+#13#10+e.Message);
                end;
              end  ;
            end;
          end;
        end;
    end;
  finally
    Screen.Cursor := crDefault;
    SetStatus;       //���������ұ߰�ť��״̬��
  end;
end;

procedure TForm1.btn_NewClick(Sender: TObject);
var
  vUsernameRkey,vEmployeeRkey,vUser_rights,vNUMBER:string;
begin
  try
    Screen.Cursor := crHourGlass;
    if ShowResetUsernameForm(Self,dm.ADOConnection,vUsernameRkey, vEmployeeRkey,vUser_rights,'�����û���������') then
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
      if DM.cds842.IsEmpty=False then
      with DM.ADOQuery1 do
      begin
        Close;
        SQL.Clear;
        SQL.Text:='select rkey from data0842 where [Work_ptr]='+dm.cds842Work_ptr.AsString
        +' and  WorkDate=CONVERT(VARCHAR(10),GETDATE(),120) and Empl_ptr='+vEmployeeRkey+' and EndTime>=getDate()' ;
        Open;
        if IsEmpty=False then
        begin
          ShowMessage('������ڱ�ά�޵��Ѵ��ڹ�����¼�����εĿ�ʼʱ�䲻��С��'+#13+'������ϴεĽ���ʱ�䣬����޷���ӣ�����');
          Exit;
        end;
      end;
      with DM.cds842 do
      if Active then
      begin
        Append;
        if DM.cds0005.Active=False then
          DM.cds0005.Open;
        if DM.cds0005.Locate('rkey',vEmployeeRkey,[])   then
        begin
          FieldByName('EMPL_CODE').Value:=DM.cds0005EMPL_CODE.Value;
          FieldByName('EMPLOYEE_NAME').Value:=DM.cds0005EMPLOYEE_NAME.Value;
          Post;
          ApplyUpdates(0);
        end;
        SetStatus;
      end;
    end;
  finally    
    Screen.Cursor := crDefault;
  end;
end;

procedure TForm1.BitBtn10Click(Sender: TObject);
begin
  if  Assigned(frmMain2)=False then
  Application.CreateForm(TfrmMain2, frmMain2);
  frmMain2.ADOQuery1.Open;
  frmMain2.ShowModal;
end;

procedure TForm1.dghChildKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (chr(key)='V') and (ssalt in shift) then
    showmessage(dm.cds842.CommandText);

  if Key=vk_down then                //�����������
  if DM.cds842.RecNo=DM.cds842.RecordCount then  //����������һ�С�
  Key:=0;
end;

procedure TForm1.BitBtn11Click(Sender: TObject);
begin
  if VarIsNull(dtpk1.Date )and( (dtpk1.Date>=Now)or(dtpk1.Date<=Now))   then
  begin
    ShowMessage('������ֹ���ڲ���Ϊ�ջ�����Ч�ģ���');
    Exit;
  end;
  try
    Screen.Cursor := crHourGlass;
    with DM.cDS567 do
    begin
      Close;
      CommandText:=Dm.ad567Copy.SQL.Text+ 'where failure_date>='+QuotedStr(DatetoStr(dtpk1.Date))
                          +' and failure_date<='+QuotedStr(DatetoStr(dtpk2.Date))
                          +strStatus;
      Open;
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TForm1.bit_FaultDescClick(Sender: TObject);
var
  Vpoint:Tpoint;
begin
  with DM.qry_D0846 do
  begin
    Close;
    Parameters.ParamByName('vFASSET_CODE').Value:= Trim(DM.cDS567FASSET_CODE.Value);
    Open;
  end;
  with  edt_FaultName  do
  begin
    Vpoint:= Parent.ClientToScreen(Point(Left,Top));
    if ShowAddListForm(self,DM.qry_D0846,'FaultName',Text,Vpoint.x,Vpoint.y+Height,400)then
    begin
      if not (DM.cDS567.State in [dsEdit,dsInsert]) then
      DM.cDS567.Edit;
      dm.cDS567D846_ptr.value:=   DM.qry_D0846.FieldByName('rkey').AsInteger;
      DM.cDS567.Post;
      DM.cDS567.ApplyUpdates(0);
    end;
  end ;
end;

procedure TForm1.dghChildKeyPress(Sender: TObject; var Key: Char);
begin
  KeyPressDBGridEH(Sender as TDBGridEh, key,self);
end;

procedure TForm1.KeyPressDBGridEH(Sender: TDBGridEH; var Key: Char;F:TForm);
var
i:integer;
begin
  if Key = #13 then
  if f.ActiveControl = Sender then
  begin
    if TDBGridEH(f.ActiveControl).SelectedIndex= TDBGridEH(f.ActiveControl).FieldCount-1 then  //���ѡ�������һ�С�
    begin
      DghReadOnlyFocus(Sender as TDBGridEh);
      Key := #0;
    end
    else
    begin
      for i:=TDBGridEH(f.ActiveControl).SelectedIndex+1 to TDBGridEH(f.ActiveControl).FieldCount-1 do //
      begin
        if (TDBGridEH(f.ActiveControl).Columns[i].ReadOnly=false) and (TDBGridEH(f.ActiveControl).Columns[i].Visible=true) then
          begin
            TDBGridEH(f.ActiveControl).SelectedIndex :=i; //TDBGridEH(f.ActiveControl).SelectedIndex+1
            Key := #0;
            exit;
          end
        else
        if I=TDBGridEH(f.ActiveControl).FieldCount-1  then
          begin
            DghReadOnlyFocus(Sender as TDBGridEh);
             //TDBGridEH(f.ActiveControl).SelectedIndex:=0 ;      //�������ص�һ�С�
            Key := #0;
          end;
      end;
    end;
  end;
end;

procedure TForm1.ColNotReadOnlyFocus(F:TForm;Ds:TDataSet);
var
  i:Integer;
begin
  for i:=0 to F.ComponentCount-1 do
  begin
    if (F.Components[i] is TDBGridEh) then
    if (F.Components[i] as TDBGridEh).DataSource.DataSet=Ds then
    begin
      DghReadOnlyFocus(F.Components[i] as TDBGridEh);
      Exit;
    end;
  end;
end;

procedure TForm1.DghReadOnlyFocus(Sender :TDBGridEh);
var
  i:Integer;
begin
  for i:=0 to   (Sender as TDBGridEh).FieldCount-1   do
  begin
    if ((Sender as TDBGridEh).Columns[i].ReadOnly=false)and ((Sender as TDBGridEh).Columns[i].Visible=True ) then   //������ֶε�ֻ��Ϊ��
    begin
      (Sender as TDBGridEh).SelectedIndex:=i;            //���ֶλ�ý��㡣
      Exit;
    end;
  end;
end;

procedure TForm1.btn_FaultNameClick(Sender: TObject);
var
  Vpoint:Tpoint;
begin
  with DM.qry_D0846 do
  begin
    Close;
    Parameters.ParamByName('vFASSET_CODE').Value:= Trim(DM.cDS567FASSET_CODE.Value);
    Open;
  end;
  with  edt_FaultName  do
  begin
    Vpoint:= Parent.ClientToScreen(Point(Left,Top));
    if ShowAddListForm(self,DM.qry_D0846,'FaultName',Text,Vpoint.x,Vpoint.y+Height,400)then
    begin
      if not (DM.cDS567.State in [dsEdit,dsInsert]) then
      DM.cDS567.Edit;
      dm.cDS567FaultName.value:=   DM.qry_D0846.FieldByName('FaultName').Value;
      DM.cDS567.Post;
      DM.cDS567.ApplyUpdates(0)  ;
    end;
  end
end;

procedure TForm1.btCloseClick(Sender: TObject);
var
  s:integer;
begin
  with DM.cds567 do
  begin
    if Active then
    if (ChangeCount>0)or (State in [dsInsert,dsEdit])then
    begin
      s:=messagebox(Self.Handle,'���ݻ�û�б��棬��Ҫ������','��ʾ',MB_yesnocancel+MB_iconquestion)  ;
      if s=idyes then
        btPost.Click
      else
      if s=idCancel then
      begin
        Abort;
      end
      else
      if s=idNo then
      begin
        Cancel;
        CancelUpdates;
      end;
    end;
  end;
  Close;
end;

procedure TForm1.btRefreshClick(Sender: TObject);
begin
  DM.cds567.Refresh;

end;

procedure TForm1.btPriorClick(Sender: TObject);
begin
  with dm.cds567 do
  if Active then
  begin
    Prior;
  end
end;

procedure TForm1.btNextClick(Sender: TObject);
begin
  with dm.cds567 do
  if Active then
  begin
    Next;
  end
end;

procedure TForm1.btCancelClick(Sender: TObject);
begin
  with dm.cds567 do
  if Active then
  begin
    Cancel;
    CancelUpdates;
    SetStatus;
  end;
end;

procedure TForm1.btPostClick(Sender: TObject);
begin
  with dm.cds567 do
  if Active then
  begin
    if state =dsEdit then
    Post;
    ApplyUpdates(0);
  end;
  SetStatus;
end;

procedure TForm1.btOutClick(Sender: TObject);
begin
  try
    F_IsBatchOperating:=True;
    OutputExcelStd(Self,DBGridEh1);
  finally
    F_IsBatchOperating:=False;
  end;
end;

procedure TForm1.OutputExcelStd(AForm:TForm;ADBGridEh:TDBGridEh);
var
  ExpClass:TDBGridEhExportClass  ;
  Ext:String;
  FFileName:string;
  SaveDialog1:TSaveDialog;
begin
  SaveDialog1:=TSaveDialog.Create(AForm);
  SaveDialog1.Filter:='*.xls|*.xls|*.csv|*.csv|*.htm|*.htm|*.txt|*.txt';
  SaveDialog1.FileName := AForm.Caption;
  if SaveDialog1.Execute then
  begin
    case SaveDialog1.FilterIndex of
      1: begin ExpClass := TDBGridEhExportAsXLS;  Ext := 'xls'; end;
      2: begin ExpClass := TDBGridEhExportAsCSV;  Ext := 'csv'; end;
      3: begin ExpClass := TDBGridEhExportAsHTML; Ext := 'htm'; end;
      4: begin ExpClass := TDBGridEhExportAsText; Ext := 'txt'; end;
    else
      ExpClass := nil; Ext := '';
    end;

    if ExpClass <> nil then
    begin
      if UpperCase(Copy(SaveDialog1.FileName,Length(SaveDialog1.FileName)-2,3)) <>
          UpperCase(Ext) then
        FFileName := SaveDialog1.FileName + '.' + Ext;
      if   FileExists(FFileName)   then
      if messagedlg('�ļ���'+FFileName+'���Ѿ�����,��Ҫ������?',mtconfirmation,[mbyes,mbno],0)=mrNo then
        Exit;
      try
        Screen.Cursor := crHourGlass;
        ADBGridEh.DataSource.DataSet.DisableControls;
        SaveDBGridEhToExportFile(ExpClass,ADBGridEh,FFileName,True);    //����ȫ�����ݡ�
      finally
        ADBGridEh.DataSource.DataSet.EnableControls;
        Screen.Cursor := crDefault;
      end;
    end;
  end;
end;

procedure TForm1.SaveToExcel(ADataSet:TDataSet;savedialog1:tsavedialog;row:integer=2;col :integer=2);
var //�������ݵ��Ի���ָ����Excel�ļ��У�������ݼ��ļ�¼��������ִ�иù��̡�
  FvExcel: Variant;
  column,i: Integer;
begin
  if ADataSet.RecordCount<1 then
  begin
    ShowMessage('û����Ҫ�����ļ�¼��');
    exit;
  end;

  try
    FvExcel := CreateOleObject('Excel.Application');
  except
    Application.MessageBox('��Excelʧ��',PChar(Application.Title),MB_ICONERROR);
    exit;
  end;
  FvExcel.Visible := false;
  FvExcel.Caption := '';
  if saveDialog1.Execute then
  begin
    FvExcel.WorkBooks.Open(saveDialog1.FileName); //�򿪹�����
    FvExcel.WorkSheets[1].Activate;  //���õ�1��������Ϊ�������
    ADataSet.First;
    while not (ADataSet.Eof) do
    begin
      column:=col ;
      for i := 1 to ADataSet.FieldCount do
      begin
        FvExcel.Cells.Item[row + 1, column] := ADataSet.Fields[i -1].AsString;
        column := column + 1;
      end;
      ADataSet.Next;
      row := row + 1;
    end;
    FvExcel.Visible := True;
  end;
end;

procedure TForm1.btFilterClick(Sender: TObject);
var
  StrWhere :string;
begin
  try
    Screen.Cursor := crHourGlass;
    if High( Query_Info)<0 then
    begin
      SetLength(Query_Info,11);
      Query_Info[0]:=TQueryInfo.Create();
      with Query_Info[0] do
      begin
        L_ListDataSetName       :=DM.cds0005;
        L_DropdownColumn        :='EMPLOYEE_NAME';   //��Ա
        L_ListResultField       :='EMPLOYEE_NAME';
      end;
      Query_Info[1]:=TQueryInfo.Create();
      with Query_Info[1] do
      begin
        L_ListDataSetName       :=DM.cds0005;
        L_DropdownColumn        :='EMPL_CODE';   //��Ա����
        L_ListResultField       :='EMPL_CODE';
      end;
      Query_Info[2]:=TQueryInfo.Create();
      with Query_Info[2] do
      begin
        L_ListDataSetName       :=DM.AQ0034;
        L_DropdownColumn        :='DEPT_NAME';
        L_ListResultField       :='DEPT_NAME';
      end;
      Query_Info[3]:=TQueryInfo.Create();
      with Query_Info[3] do
      begin
        L_ListDataSetName       :=DM.AQ0034;
        L_DropdownColumn        :='DEPT_CODE';
        L_ListResultField       :='DEPT_CODE';
      end;
      Query_Info[4]:=TQueryInfo.Create();
      with Query_Info[4] do
      begin
        L_ListDataSetName       :=DM.dt0417;
        L_DropdownColumn        :='FASSET_CODE';
        L_ListResultField       :='FASSET_CODE';
      end;
      Query_Info[5]:=TQueryInfo.Create();
      with Query_Info[5] do
      begin
        L_ListDataSetName       :=DM.dt0417;
        L_DropdownColumn        :='FASSET_NAME';
        L_ListResultField       :='FASSET_NAME';
      end;
      Query_Info[6]:=TQueryInfo.Create();
      with Query_Info[6] do
      begin
        L_ListDataSetName       :=DM.aq0015;
        L_DropdownColumn        :='abbr_name';   //��Ա����
        L_ListResultField       :='abbr_name';
      end;
      Query_Info[7]:=TQueryInfo.Create();
      with Query_Info[7] do
      begin
        L_ListDataSetName       :=DM.aq0015;
        L_DropdownColumn        :='warehouse_code';   //��Ա����
        L_ListResultField       :='warehouse_code';
      end;
      Query_Info[8]:=TQueryInfo.Create();
      with Query_Info[8] do
      begin
        L_ListDataSetName       :=DM.cds0005;
        L_DropdownColumn        :='disposal_emplcode';   //��Ա����
        L_ListResultField       :='EMPL_CODE';
      end;
      Query_Info[9]:=TQueryInfo.Create();
      with Query_Info[9] do
      begin
        L_ListDataSetName       :=DM.cds0005;
        L_DropdownColumn        :='completion_emplcode';   //��Ա����
        L_ListResultField       :='EMPL_CODE';
      end;
      Query_Info[10]:=TQueryInfo.Create();
      with Query_Info[10] do
      begin
        L_ListDataSetName       :=DM.qryD840;
        L_DropdownColumn        :='D417_Location';   //��Ա����
        L_ListResultField       :='Location';
      end;
    end;
    FindFieldsName:=varArrayOf(['Data0840.Location']);
    FindQueryFieldsName:=varArrayOf(['D417_Location']);
    if ShowfrmFindcds(Self,DM.cds567,StrWhere,[''],
    ['NUMBER','EMPL_CODE','EMPLOYEE_NAME','DEPT_CODE','DEPT_NAME','FASSET_CODE','FASSET_NAME','PLACE','failure_date','D417_Location',
        'disposal_emplcode','disposal_emplname','disposal_date','completion_emplcode',                                                            
        'completion_emplname','complete_date','maintain_empl','abbr_name','warehouse_code','EquiType'],
        ['abbr_name','EMPLOYEE_NAME','EMPL_CODE','disposal_emplcode','disposal_emplname','completion_emplcode','completion_emplname','D417_Location'],
        ['data0015.abbr_name','data0005.EMPLOYEE_NAME','data0005.EMPL_CODE',
        'data0005_1.EMPL_CODE','data0005_1.EMPLOYEE_NAME','data0005_2.EMPL_CODE','data0005_2.EMPLOYEE_NAME','Data0840.Location'],
       [],[],[],[],470) then
    begin
      with DM.cDS567  do
      begin
        Close;
        CommandText:=Dm.ad567Copy.SQL.Text+ 'where 1=1 '
                            +strStatus+#13+'and '+StrWhere;
        Open;
      end;
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TForm1.CheckBox8Click(Sender: TObject);
begin
  with DM.qry_data0468 do
  if  CheckBox8.Checked then
  begin
    if Parameters.ParamByName('vd567_ptr').Value<>DM.cds567RKEY.Value then
    begin
      Close;
      Parameters.ParamByName('vd567_ptr').Value:=DM.cds567RKEY.Value;
      Open;
    end
    else
      Open;
  end
  else
    Close;
end;

procedure TForm1.btn_LocationClick(Sender: TObject);
var
  Vpoint:Tpoint;
begin
  with  edt_Location  do
  begin
    Vpoint:= Parent.ClientToScreen(Point(Left,Top));
    if ShowAddListForm(self,DM.QryD840,'Location',Text,Vpoint.x,Vpoint.y+Height,400)then
    begin
      if not (DM.cDS567.State in [dsEdit,dsInsert]) then
      DM.cDS567.Edit;
      
      dm.cDS567Location.value:=   DM.QryD840.FieldByName('Location').Value;

      DM.cDS567.Post;
      mo_maintain_text.SetFocus;
    end;
  end;
end;

procedure TForm1.N_EndPauseClick(Sender: TObject);
begin
  if messagebox(Self.Handle,'��ȷ��Ҫ��ͣ������','ѯ��',MB_yesno+MB_iconquestion)=idNo then
  Exit ;
  Exec_EndPause(user_ptr) ;
end;

procedure TForm1.N_OtherEndPauseClick(Sender: TObject);
var
  vUsernameRkey,vEmployeeRkey,vUser_rights:string;
begin
  if ShowResetUsernameForm(Self,DM.ADOConnection,vUsernameRkey, vEmployeeRkey,vUser_rights,'�������û���ͣ����') then
  begin
    if (StrToInt(vUser_rights) in[2,3,4])=False then
    begin
      ShowMessage('��û����ͣ������Ȩ�ޣ�');
      Exit;
    end;
    Exec_EndPause(vEmployeeRkey) ;
  end;
end;

procedure TForm1.N_ColumnsSetClick(Sender: TObject);
begin
  show_ColsDisplaySet_frm (Self,DBGridEh1,StrToInt(rkey73)) ;
end;

procedure TForm1.N_ChildColumnsSetClick(Sender: TObject);
begin
  show_ColsDisplaySet_frm (Self,dghChild,StrToInt(rkey73)) ;
end;

procedure TForm1.N12Click(Sender: TObject);
begin
  SetFrozenField(Self,DBGridEh1,DBGridEh1.SelectedField.FieldName,StrToInt(rkey73));
end;

procedure TForm1.N13Click(Sender: TObject);
begin
  CancelFrozenField(Self,DBGridEh1,StrToInt(rkey73));
end;

end.
