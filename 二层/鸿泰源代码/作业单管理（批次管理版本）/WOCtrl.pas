//****************************************************************************//
//ģ������: ��ҵ�����ƹ���                                                    //
//����:1.��ҵ��������Ϣ����                                                   //
//     2.��ҵ����ͣ                                                           //
//     3.��ҵ���ָ�                                                           //
//     4.��ҵ������                                                           //
//     5.��ҵ����������                                                       //
//     6.��ҵ�����                                                           //
//     7.��ҵ�����                                                           //
//��������������ĵ�:��ҵ�������������.doc                                   //
//****************************************************************************//
unit WOCtrl;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, StdCtrls, Grids, DBGrids, ComCtrls, Buttons, ExtCtrls,
  DBGridEh, Menus;

type
  TfrmWOCtrl = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    StatusBar1: TStatusBar;
    DBGridEh1: TDBGridEh;
    dtpStartDate: TDateTimePicker;
    dtpEndDate: TDateTimePicker;
    Label1: TLabel;
    labelKey: TLabel;
    PopupMenu1: TPopupMenu;
    PopupMenu2: TPopupMenu;
    MenuItem1: TMenuItem;
    MenuItem3: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    Panel2: TPanel;
    RadioGroup1: TRadioGroup;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    BitBtn6: TBitBtn;
    edtKey: TEdit;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    PopupMenu3: TPopupMenu;
    N13: TMenuItem;
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
    RadioGroup2: TRadioGroup;
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure dtpStartDateChange(Sender: TObject);
    procedure edtKeyChange(Sender: TObject);
    procedure edtKeyKeyPress(Sender: TObject; var Key: Char);
    procedure DBGridEh1TitleClick(Column: TColumnEh);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure MenuItem1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure RadioGroup1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure PopupMenu2Popup(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure N9Click(Sender: TObject);
    procedure N13Click(Sender: TObject);
    procedure N14Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure N12Click(Sender: TObject);
    procedure N11Click(Sender: TObject);
    procedure DBGridEh1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure N17Click(Sender: TObject);
    procedure N16Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure N18Click(Sender: TObject);
    procedure N19Click(Sender: TObject);
    procedure N20Click(Sender: TObject);
    procedure N21Click(Sender: TObject);
    procedure N22Click(Sender: TObject);
    procedure N23Click(Sender: TObject);
    procedure RadioGroup2Click(Sender: TObject);
  private
    { Private declarations }
    vColumn:TColumnEh;
    StartDate,EndDate:TDatetime;
    procedure DoSearch(subSql:string);
    procedure item_click(sender:TObject);
    procedure RefreshData(rKey:integer);//ˢ������
    function WO_Pause(rKey:integer;remark:string):boolean;//��ҵ����ͣ����
    function WO_DE_Pause(rKey:integer;remark:string):boolean;//��ҵ���ָ�����
    function Update_WO_LOG(WOrKey,Action:integer;Remark:string):boolean;//��ҵ��������־

    function WO_ReWork(rKey,StepNo,Priority,ProdRKey:integer;remark:string):boolean;//��ҵ������
    function WO_Change_Flow(rKey,StepNo,Priority,prodRkey:integer;remark:string;Is_Last_Step:boolean):boolean;//��ҵ���������
    function WO_Split(rKey,PCS,PNL:integer;NEW_WONO,Remark:string):boolean;//��ҵ�����
    procedure Single_Print(rKey:integer;subPrint,ipdPrint:boolean;print29: Boolean = False;print502: Boolean = False);
    procedure Single_equipmentPrint(rKey25:integer);
  public
    { Public declarations }
  end;

var
  frmWOCtrl: TfrmWOCtrl;

implementation
uses MyClass,ConstVar,common,QuerySet,dm,WO_INFO,Dlg_WO_Pause_Note,Dlg_WO_Flow_Chng,Dlg_WO_Split,
  report_data,Dlg_Single_Print,mul_report, equipment_report;
{$R *.dfm}

procedure TfrmWOCtrl.FormShow(Sender: TObject);
begin
  vColumn:=DBGridEh1.Columns[0];
  labelKey.Caption:=vColumn.Title.Caption;
  dtpStartDate.Date := date-3;
  dtpEndDate.Date := date;

end;

procedure TfrmWOCtrl.BitBtn1Click(Sender: TObject);
begin
  close;
end;

procedure TfrmWOCtrl.BitBtn3Click(Sender: TObject);
var
  sqlstr:string;
begin
  if dmcon.adsWOCtrlList.Active then
     RefreshData(dmcon.adsWOCtrlList.fieldbyName('rKey').AsInteger)
  else
  begin
    sqlstr:=sqlstr+' and D06.ent_datetime>='+QuotedStr(Formatdatetime('yyyy-mm-dd',Date))+' and D06.ent_datetime<'+QuotedStr(Formatdatetime('yyyy-mm-dd',Date+1));
    DoSearch(sqlstr);
  end;
end;

procedure TfrmWOCtrl.BitBtn2Click(Sender: TObject);
begin
  if dmcon.adsWOCtrlList.IsEmpty then exit;
  Export_dbGridEH_to_Excel(DBGridEh1,'��ҵ���б�')
end;

procedure TfrmWOCtrl.BitBtn4Click(Sender: TObject);
var
  i:integer;
  sqlstr:string;
begin
  with TfrmQuerySet.Create(Application)do
  try
    FType:=1;
    RadioGroup1.Visible:=true;
    if StartDate > 100 then
      dtpk1.Date:= StartDate
    else
      dtpk1.Date:= date;
    if EndDate > 100 then
      dtpk2.Date:= EndDate
    else
      dtpk2.Date:=date;
    if ShowModal = mrOk then
    begin
      for i:=1 to sgrid1.RowCount-2 do
      begin
        if sgrid1.Cells[2,i]<> '' then
          Sqlstr:=sqlstr+sgrid1.Cells[2,i];
      end;
      StartDate:=dtpk1.Date;
      EndDate:=dtpk2.Date;
      sqlstr:=sqlstr+' and D06.ent_datetime>='+QuotedStr(Formatdatetime('yyyy-mm-dd',dtpk1.Date))+' and D06.ent_datetime<'+QuotedStr(Formatdatetime('yyyy-mm-dd',dtpk2.Date+1));
      if RadioGroup1.ItemIndex=0 then
        sqlstr:=sqlstr+' and D06.Trav_Printed_By_Ptr=0 '
      else if RadioGroup1.ItemIndex=1 then
        sqlstr:=sqlstr+' and D06.Trav_Printed_By_Ptr>0 ';
    end;
  finally
    free;
  end;
  DoSearch(sqlstr);
end;

procedure TfrmWOCtrl.dtpStartDateChange(Sender: TObject);
var  tmpstr1,Tmpstr2,sFilter,Status_filter:string;
begin
  if not dmcon.adsWOCtrlList.Active then abort;
  if vColumn.Field.DataType in [ftDate, ftDateTime] then
  begin
    TmpStr1:= QuotedStr(DateToStr(dtpStartDate.Date));
    TmpStr2:= QuotedStr(DateToStr(dtpEndDate.Date+1));
    if RadioGroup1.ItemIndex = 9 then
      Status_filter := ''
    else
      Status_filter := ' and prod_Status_CN='+ QuotedStr(RadioGroup1.Items[RadioGroup1.ItemIndex]);

    sFilter := vColumn.Field.FieldName+'>='+TmpStr1+ ' AND ' +vColumn.Field.FieldName+'<'+TmpStr2;
    dmcon.adsWOCtrlList.Filter := sFilter+Status_filter;
    dmcon.adsWOCtrlList.Filtered:= true;
  end;
{  if not dmcon.adsWOCtrlList.Active then abort;
  TmpStr1:= QuotedStr(DateToStr(dtpStartDate.Date));
  TmpStr2:= QuotedStr(DateToStr(dtpEndDate.Date+1));
  if vColumn.Field.DataType in [ftDate, ftDateTime] then
  begin
    sFilter := vColumn.Field.FieldName+'>='+TmpStr1+ ' AND ' +vColumn.Field.FieldName+'<'+TmpStr2;
    dmcon.adsWOCtrlList.Filter := sFilter;
    dmcon.adsWOCtrlList.Filtered:= true;
  end;}
end;

procedure TfrmWOCtrl.edtKeyChange(Sender: TObject);
var tmpstr,sFilter,Status_filter:string;
DATASET:TCustomADoDATASET;
begin
  DATASET := TCustomAdoDataSet(DBGridEh1.DataSource.DataSet);
  if not DATASET.Active then abort;
  tmpstr:= trim(edtKey.Text);
  if RadioGroup1.ItemIndex = 9 then
    Status_filter := ''
  else
    Status_filter := ' and prod_Status_CN='+ QuotedStr(RadioGroup1.Items[RadioGroup1.ItemIndex]);

  if TmpStr='' then
  begin
    if Status_filter<>'' then
      DATASET.Filter := Stringreplace(Status_filter,' and ','',[])
    else
      DATASET.Filter := '';
    DATASET.Filtered:= true;
  end
  else
  begin
//    if (DBGridEh1.SelectedField.DataType in [ftString,ftWideString,ftMemo]) then
    if (vColumn.Field.DataType in [ftString,ftWideString,ftMemo]) then
    begin
      sFilter := '*'+uppercase(TmpStr)+'*';
      DATASET.Filter := vColumn.Field.FieldName+' Like '+ QuotedStr(sFilter)+Status_filter;
      DATASET.Filtered:= true;
    end
    else if vColumn.Field.DataType in [ftSmallint, ftInteger, ftWord, ftFloat, ftCurrency, ftBCD,ftLargeint] then
    begin
      if TmpStr='-' then exit;
      sFilter := vColumn.Field.FieldName+'>='+TmpStr+Status_filter;//DBGrid3.SelectedField.FieldName+'>='+TmpStr+' AND '+ DBGrid3.SelectedField.FieldName+'<'+IntToStr(Get_Filter_Of_Fixed_Int(StrToFloat(TmpStr)));
      DATASET.Filter := sFilter;
      DATASET.Filtered:= true;
    end
    else if vColumn.Field.DataType in [ftDate, ftDateTime] then
    begin
      if not IsDatetime(TmpStr) then exit;
      sFilter := '>='+QuotedStr(TmpStr);
      DATASET.Filter := vColumn.Field.FieldName + sFilter+Status_filter;
      DATASET.Filtered:= true;
    end;
  end;
{  if not dmcon.adsWOCtrlList.Active then abort;
  tmpstr:= trim(edtKey.Text);
  if TmpStr='' then
    dmcon.adsWOCtrlList.Filtered:= false
  else
  begin
    if (vColumn.Field.DataType in [ftString,ftWideString,ftMemo]) then
    begin
      sFilter := '*'+uppercase(TmpStr)+'*';
      dmcon.adsWOCtrlList.Filter := vColumn.Field.FieldName+' Like '+ QuotedStr(sFilter);
      dmcon.adsWOCtrlList.Filtered:= true;
    end
    else if vColumn.Field.DataType in [ftSmallint, ftInteger, ftWord, ftFloat, ftCurrency, ftBCD,ftLargeint] then
    begin
      if TmpStr='-' then exit;
      if not IS_Float(TmpStr) then exit;
      sFilter := vColumn.Field.FieldName+'>='+TmpStr;//DBGrid3.SelectedField.FieldName+'>='+TmpStr+' AND '+ DBGrid3.SelectedField.FieldName+'<'+IntToStr(Get_Filter_Of_Fixed_Int(StrToFloat(TmpStr)));
      dmcon.adsWOCtrlList.Filter := sFilter;
      dmcon.adsWOCtrlList.Filtered:= true;
    end
    else if vColumn.Field.DataType in [ftDate, ftDateTime] then
    begin
      if not IsDatetime(TmpStr) then exit;
      sFilter := '>='+QuotedStr(TmpStr);
      dmcon.adsWOCtrlList.Filter := vColumn.Field.FieldName + sFilter;
      dmcon.adsWOCtrlList.Filtered:= true;
    end;
  end;}
end;

procedure TfrmWOCtrl.edtKeyKeyPress(Sender: TObject; var Key: Char);
begin
  if not Dmcon.adsWOCtrlList.Active  then
  begin
    showmessage('���ѯ����¼���ٹ���...');
    abort;
  end;
  if vColumn.Field.DataType in [ftSmallint, ftInteger, ftWord, ftLargeint] then
  begin
    if (length((Sender as TEdit).Text)=20) and (key<>chr(8)) then Abort;
    if Key='.' then abort;
//    if (pos('.',(Sender as TEdit).Text)>0) and (key='.') then abort;
    if (pos(key,'-0123456789.')=0) and (key<>chr(8)) then
      Abort;
    if (pos('-',(Sender as TEdit).Text)>0) and (key='-') then abort;
    if Length((Sender as TEdit).text)>0 then
      if (key='-') then abort;
  end
  else if  vColumn.Field.DataType in [ftFloat, ftCurrency, ftBCD] then
  begin
    if (length((Sender as TEdit).Text)=20) and (key<>chr(8)) then Abort;
    if (pos('.',(Sender as TEdit).Text)>0) and (key='.') then abort;
    if (pos(key,'-0123456789.')=0) and (key<>chr(8)) then
      Abort;
    if (pos('-',(Sender as TEdit).Text)>0) and (key='-') then abort;
    if Length((Sender as TEdit).text)>0 then
      if (key='-') then abort;
  end ;
end;

procedure TfrmWOCtrl.DoSearch(subSql: string);
var
  sqlstr:widestring;
  i:integer;
begin
  if subsql='' then exit;
  sqlstr:=uppercase(dmcon.adsWOCtrlList.CommandText);
  i:=Pos('WHERE',sqlstr);
  if i = 0 then
  begin
    ShowMsg('SQL������,����ϵϵͳ����Ա',1);
    abort;
  end;
  Sqlstr:=copy(sqlstr,1,i-1);
  dmcon.adsWOCtrlList.Close;
  dmcon.adsWOCtrlList.CommandText := sqlstr+' WHERE (1=1) '+subsql ;
  dmcon.adsWOCtrlList.Prepared;
  dmcon.adsWOCtrlList.open;
  StatusBar1.Panels[1].Text := IntToStr(dmcon.adsWOCtrlList.RecordCount);
end;

procedure TfrmWOCtrl.DBGridEh1TitleClick(Column: TColumnEh);
//var OldIndex:string;
begin
  vColumn.Title.Color:=clBtnFace;
  vColumn := Column;
  vColumn.Title.Color:=clred;
  labelKey.Caption := Column.Title.Caption;
  if (Column.Grid.DataSource=nil) or
  (Column.Grid.DataSource.DataSet=nil) or
  (not Column.Grid.DataSource.DataSet.Active) then
    Exit;

  if Column.Title.SortMarker = smDownEh then
  begin
    TCustomAdoDataSet(Column.Field.DataSet).Sort :=Column.Field.FieldName+' ASC';
    Column.Title.SortMarker := smUpEh;
  end
  else if Column.Title.SortMarker = smUpEh then
  begin
    TCustomAdoDataSet(Column.Field.DataSet).Sort :='';
    Column.Title.SortMarker := smNoneEh;
  end
  else if Column.Title.SortMarker = smNoneEh then
  begin
    TCustomAdoDataSet(Column.Field.DataSet).Sort :=Column.Field.FieldName+' DESC';
    Column.Title.SortMarker := smDownEh;
  end;{end case}
  if dmcon.adsWOCtrlList.IsEmpty then abort;
  edtKey.Visible:= not (Column.Field.DataType in [ftDate, ftDateTime]);
  labelKey.Visible:= edtKey.Visible;
end;

procedure TfrmWOCtrl.PopupMenu1Popup(Sender: TObject);
var
  i:integer;
  MI:TMenuItem;
begin
  while PopupMenu1.Items.Count>0 do
    PopupMenu1.Items[0].free;
  for i:= 0 to DBGridEh1.Columns.Count- 1 do
  begin
    MI:=TmenuItem.Create(self);
    MI.Caption:=DBGridEh1.Columns[i].Title.Caption;
    if DBGridEh1.Columns[i].Visible then
      MI.Checked:=true;
    MI.OnClick:=item_click;
    self.PopupMenu1.Items.Add(MI);
  end;
end;

procedure TfrmWOCtrl.item_click(sender: TObject);
var
 i:byte;
begin
  (sender as tmenuItem).Checked := not ((sender as tmenuItem).Checked);
  for i:=0 to DBGridEh1.Columns.Count-1 do
    if DBGridEh1.Columns[i].Title.Caption=(sender as tmenuItem).Caption then
    begin
      DBGridEh1.Columns[i].Visible:=(sender as tmenuItem).Checked;
      break;
    end;
end;


procedure TfrmWOCtrl.BitBtn5Click(Sender: TObject);
begin
  popupmenu1.Popup(mouse.CursorPos.x,mouse.CursorPos.y);
end;

procedure TfrmWOCtrl.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
//var
//  i,j:integer;
begin
{  i:=dmcon.adsWOCtrlList.FieldByName('TSTATUS').Asinteger;
  j:=dmcon.adsWOCtrlList.FieldByName('COST_APPR_BY').Asinteger;
  if (j>0) then
  begin
    DBGridEh1.Canvas.Font.Color   :=clred;
  end;
  DBGridEh1.DefaultDrawColumnCell(Rect,DataCol,Column,State);}
  if Dmcon.adsWOCtrlList.FieldByName('Print_Status').AsString = '�Ѵ�ӡ' then
    DBGridEh1.Canvas.Font.Color   :=clTeal;
  DBGridEh1.DefaultDrawColumnCell(Rect,DataCol,Column,State);
end;

procedure TfrmWOCtrl.MenuItem1Click(Sender: TObject);
begin
if dmcon.adsWOCtrlList.fieldByName('rkey').AsInteger>0 then
  with TfrmWO_INFO.Create(Application)do
  try
    Enter(dmcon.adsWOCtrlList.fieldByName('rkey').Value,dmcon.adsWOCtrlList.fieldByName('Bom_ptr').Value);
  finally
    free;
  end;
end;

procedure TfrmWOCtrl.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  DBGridEh1.DataSource.DataSet.Filter:='';
  DBGridEh1.DataSource.DataSet.Filtered:=false;
  DBGridEh1.DataSource.DataSet.Close;
end;

procedure TfrmWOCtrl.RadioGroup1Click(Sender: TObject);
begin
{  if RadioGroup1.ItemIndex = 9 then
    dmcon.adsWOCtrlList.Filtered := false
  else
  begin
    dmcon.adsWOCtrlList.Filtered := false;
    dmcon.adsWOCtrlList.Filter := 'prod_Status_CN='+ QuotedStr(RadioGroup1.Items[RadioGroup1.ItemIndex]);
    dmcon.adsWOCtrlList.Filtered:= true;
  end;}

  if not Dmcon.adsWOCtrlList.Active  then
  begin
    showmessage('���ѯ����¼���ٹ���...');
    exit;
  end;

  if vColumn = nil then
  begin
    if RadioGroup1.ItemIndex = 9 then
      dmcon.adsWOCtrlList.Filter := ''
    else
      dmcon.adsWOCtrlList.Filter := 'prod_Status_CN='+ QuotedStr(RadioGroup1.Items[RadioGroup1.ItemIndex]);
    dmcon.adsWOCtrlList.Filtered:=true;  
  end
  else
  begin
    if vColumn.Field.DataType in [ftDate, ftDateTime] then
      dtpStartDateChange(sender)
    else
      edtKeyChange(sender);
  end;
end;

procedure TfrmWOCtrl.N2Click(Sender: TObject);
var
  rKey:integer;
  remark:string;
begin
  if (strtoint(vprev)=1) or (strtoint(vprev)=3) then
  begin
    ShowMsg('�Բ���!��û�иó���Ŀ�дȨ��',1);
    exit;
  end;
  if Dmcon.tmpQry.Active then Dmcon.tmpQry.Close ;
  Dmcon.tmpQry.SQL.Clear ;
  Dmcon.tmpQry.SQL.Add('select rkey from data0400 where status = 0');
  Dmcon.tmpQry.Prepared ;
  Dmcon.tmpQry.Open ;
  if not Dmcon.tmpQry.IsEmpty then
  begin
    Dmcon.tmpQry.Close ;
    Dmcon.tmpQry.SQL.Clear ;
    ShowMsg('���������̵�,���ܲ���',1);
    exit;
  end;
  Dmcon.tmpQry.Close ;
  Dmcon.tmpQry.SQL.Clear ;  
//��ͣ����,�ж���ҵ��״̬�Ƿ�Ϊ"������",��������ͣ
  if dmcon.adsWOCtrlList.FieldByName('Prod_status').AsInteger in [3,4] then
  begin
    rKey:=dmcon.adsWOCtrlList.FieldByName('rKey').AsInteger;
    with TfrmDlg_WO_Pause_Note.Create(Application)do
    try
      InitForm(rKey,1);
      if ShowModal = mrok then
      begin
        remark:='��'+dmcon.adsWOCtrlList.FieldByName('prod_status_cn').AsString+'ת�ݻ�; '+ Memo2.Text;
        if WO_Pause(rKey,remark) then
          RefreshData(rKey);
      end
    finally
      free;
    end;
  end
  else
    ShowMsg('ֻ��״̬Ϊ�����е���ҵ�����ܱ��ݻ�,����',1);
end;

function TfrmWOCtrl.WO_Pause(rKey: integer;remark:string):boolean;
var
  sqlstr:string;
begin
{	������
1��	�޸���ҵ��״̬Ϊ"�������ݻ�"����������data0006��Prod_status ֵΪ103
2��	��¼�ݻ���־����¼�ݻ��Ĳ����ˣ�����ʱ�����Ϣ��Data0017������¼��Source_Type=2��Action����Ϊ1
}
  try
    if not dmcon.ADOConnection1.InTransaction then
      dmcon.ADOConnection1.BeginTrans;
    sqlstr:='update data0006 set prod_status =103,ENGG_STATUS=prod_status where prod_status in (3,4) and rKey='+IntToStr(rKey);
    if not MyDataClass.ExecSql(sqlstr) then
      abort;
    if not Update_WO_LOG(rKey,1,remark) then
      abort;
    dmcon.ADOConnection1.CommitTrans;
    result := true;
  except
    dmcon.ADOConnection1.RollbackTrans;
    result := false;
    ShowMsg('��ҵ����ͣ��������ʧ�ܣ�',1);
  end;
end;

function TfrmWOCtrl.Update_WO_LOG(WOrKey, Action: integer;
  Remark: string): boolean;
var
  sqlstr:string;
begin
  sqlstr:=' insert into data0117(Source_ptr,Source_Type,NOTEPAD_PTR,Empl_ptr,Tdate,Action,Remark) '+
          ' values ('+IntToStr(WoRkey)+',2,0,'+User_ptr+',getdate(),'+IntToStr(Action)+','+QuotedStr(remark)+')';
  result := MyDataClass.ExecSql(sqlstr);
end;

function TfrmWOCtrl.WO_DE_Pause(rKey: integer; remark: string): boolean;
var
  sqlstr:string;
begin
{	������
1��	�޸���ҵ��״̬Ϊ"������"����������data0006��Prod_status ֵΪ3
2��	��¼�ݻ���־����¼�ݻ��Ĳ����ˣ�����ʱ�����Ϣ��Data0017������¼��Source_Type=2��Action����Ϊ2
}
  try
    if not dmcon.ADOConnection1.InTransaction then
      dmcon.ADOConnection1.BeginTrans;
    sqlstr:='update data0006 set prod_status =case when ENGG_STATUS>0 then ENGG_STATUS else 3 end,engg_status=null where prod_status=103 and rKey='+IntToStr(rKey);
    if not MyDataClass.ExecSql(sqlstr) then
      abort;
    if not Update_WO_LOG(rKey,2,remark) then
      abort;
    dmcon.ADOConnection1.CommitTrans;
    result := true;
  except
    dmcon.ADOConnection1.RollbackTrans;
    result := false;
    ShowMsg('��ҵ���ָ���������ʧ�ܣ�',1);
  end;
end;

procedure TfrmWOCtrl.RefreshData(rKey: integer);
begin
  if not dmcon.adsWOCtrlList.Active then exit;
  dmcon.adsWOCtrlList.close;
  dmcon.adsWOCtrlList.open;
  dmcon.adsWOCtrlList.Locate('rKey',rKey,[]);
  StatusBar1.Panels[1].Text := IntToStr(dmcon.adsWOCtrlList.RecordCount);
end;

procedure TfrmWOCtrl.N3Click(Sender: TObject);
var
  rKey:integer;
  remark:string;
begin
  if (strtoint(vprev)=1) or (strtoint(vprev)=3) then
  begin
    ShowMsg('�Բ���!��û�иó���Ŀ�дȨ��',1);
    exit;
  end;
  if Dmcon.tmpQry.Active then Dmcon.tmpQry.Close ;
  Dmcon.tmpQry.SQL.Clear ;
  Dmcon.tmpQry.SQL.Add('select rkey from data0400 where status = 0');
  Dmcon.tmpQry.Prepared ;
  Dmcon.tmpQry.Open ;
  if not Dmcon.tmpQry.IsEmpty then
      begin
          Dmcon.tmpQry.Close ;
          Dmcon.tmpQry.SQL.Clear ;
          ShowMsg('���������̵�,���ܲ���',1);
          exit;
      end;
  Dmcon.tmpQry.Close ;
  Dmcon.tmpQry.SQL.Clear ;  
//�ָ�����,�ж���ҵ��״̬�Ƿ�Ϊ"�������ݻ�",������ָ�
  if dmcon.adsWOCtrlList.FieldByName('Prod_status').AsInteger = 103 then
  begin
    rKey:=dmcon.adsWOCtrlList.FieldByName('rKey').AsInteger;
    with TfrmDlg_WO_Pause_Note.Create(Application)do
    try
      Caption := '��ҵ���ָ�������ע';
      InitForm(rKey,2);
      if ShowModal = mrok then
      begin
        remark:= Memo2.Text;
        if WO_DE_Pause(rKey,remark) then
          RefreshData(rKey);
      end
    finally
      free;
    end;
  end
  else
    ShowMsg('ֻ��״̬Ϊ�������ݻ�����ҵ�����ܱ��ָ�,����',1);
end;

procedure TfrmWOCtrl.MenuItem2Click(Sender: TObject);//��ҵ����������������ɾ����
begin
  if (strtoint(vprev)=1) or (strtoint(vprev)=3) then
  begin
    ShowMsg('�Բ���!��û�иó���Ŀ�дȨ��',1);
    exit;
  end;
  if Dmcon.tmpQry.Active then Dmcon.tmpQry.Close ;
  Dmcon.tmpQry.SQL.Clear ;
  Dmcon.tmpQry.SQL.Add('select rkey from data0400 where status = 0');
  Dmcon.tmpQry.Prepared ;
  Dmcon.tmpQry.Open ;
  if not Dmcon.tmpQry.IsEmpty then
      begin
          Dmcon.tmpQry.Close ;
          Dmcon.tmpQry.SQL.Clear ;
          ShowMsg('���������̵�,���ܲ���',1);
          exit;
      end;
  Dmcon.tmpQry.Close ;
  Dmcon.tmpQry.SQL.Clear ;  
//����,�ж���ҵ��״̬�Ƿ�Ϊ"������",�����践��
  if (dmcon.adsWOCtrlList.FieldByName('Prod_status').AsInteger = 3) or (dmcon.adsWOCtrlList.FieldByName('prod_status').AsInteger = 5) or (dmcon.adsWOCtrlList.FieldByName('prod_status').AsInteger = 6) then
  begin
    if dmcon.adsWOCtrlList.FieldByName('wtype').AsInteger > 0 then
    begin
      ShowMsg('��ǰ��ҵ�����ڷ���״̬,���������',1);
      exit;
    end;
    with TfrmDlg_WO_Flow_Chng.Create(Application)do
    try
      InitForm(dmcon.adsWOCtrlList.fieldbyName('rKey').Value,1,dmcon.adsWOCtrlList.fieldbyName('bom_ptr').Value);
      if Showmodal=mrok then
      begin
        if WO_ReWork(dmcon.adsWOCtrlList.fieldbyName('rKey').Value,StrtoInt(copy(comboxStepNew.Text,1,3)),edtPriorityNew.value,dmcon.adsWOCtrlList.fieldbyName('bom_ptr').Value,Memo2.text)then
          RefreshData(dmcon.adsWOCtrlList.fieldbyName('rKey').Asinteger);
      end;
    finally
      free;
    end
  end
  else
    ShowMsg('ֻ��״̬Ϊ"������","�����"��"������"����ҵ�����ܱ�����,����',1);
end;

procedure TfrmWOCtrl.PopupMenu2Popup(Sender: TObject);
begin
  if not dmcon.adsWOCtrlList.Active then abort;
  //MenuItem2.Enabled :=dmcon.adsWOCtrlList.FieldByName('prod_status').AsInteger in [3,5,6];  //��������
  N1.Enabled := dmcon.adsWOCtrlList.FieldByName('wtype').AsInteger > 0 ;                      //��������
  N2.Enabled := dmcon.adsWOCtrlList.FieldByName('prod_status').AsInteger in [3,4] ;           //��ͣ����
  N3.Enabled := dmcon.adsWOCtrlList.FieldByName('prod_status').AsInteger = 103 ;              //�ָ�����
  //MenuItem4.Enabled := dmcon.adsWOCtrlList.FieldByName('prod_status').AsInteger in [2,3,5,6]; //��ҵ�����
  N6.Enabled :=dmcon.adsWOCtrlList.FieldByName('prod_status').AsInteger = 3 ;                 //��ҵ������
  N8.Enabled :=dmcon.adsWOCtrlList.FieldByName('prod_status').AsInteger in [3,4,5,6];         //�����ӡ��ҵ��
  n11.Enabled:=n8.Enabled;
  N16.Enabled:=N8.Enabled;
  N19.Enabled:=dmcon.adsWOCtrlList.FieldByName('PROD_STATUS').AsInteger = 2;                  //�ر���ҵ��(������)
  N20.Enabled:=dmcon.adsWOCtrlList.FieldByName('WTYPE').AsInteger > 0;                        //�����ӡ������ҵ��
end;

function TfrmWOCtrl.WO_ReWork(rKey,StepNo,Priority,ProdRKey: integer; remark: string): boolean;
var
  sqlstr:string;
begin
{3)	������ҵ�����߼�¼����ԭ������ű�Ϊ����ָ���Ĺ����裬����ԭ����ż�¼��data0056���ֶ�wType ���������ܼ�¼����ǰ�Ĺ���λ�ã�����������ʱ������λ���ֻص�ԭ����λ�á�
5)	��������־����¼��������ҵ���������ˣ�ʱ�����Ϣ�������ݱ�data0117�����Ӽ�¼��Source_Type=2��Action����Ϊ5}

  try
    if not dmcon.ADOConnection1.InTransaction then
      dmcon.ADOConnection1.BeginTrans;
    //����������ҵ���Ĺ���        //��������  �Ӱ�ʱ��        ����������                  ����������
    sqlstr:=' update data0056 set wType=Step,intime=getdate(),Step='+InttoStr(StepNo)+', Dept_ptr = (select Dept_ptr from data0038 where source_ptr='+IntToStr(ProdRkey)+' and step_number='+InttoStr(StepNo)+')  where Wo_ptr='+InttoStr(rKey);
    if not MyDataClass.ExecSql(sqlstr) then
      abort;
    //�������ȼ�������ҵ��״̬Ϊ������
    sqlstr:=' update data0006 set prod_status=3 ,PRIORITY_CODE='+InttoStr(Priority)+' where rKey='+InttoStr(rKey);
    if not MyDataClass.ExecSql(sqlstr) then
      abort;

    //��������־,5:����
    if not Update_WO_LOG(rKey,5,remark) then
      abort;
    dmcon.ADOConnection1.CommitTrans;
    result := true;
  except
    dmcon.ADOConnection1.RollbackTrans;
    result := false;
    ShowMsg('��ҵ����������ʧ�ܣ�',1);
  end;
end;

procedure TfrmWOCtrl.N1Click(Sender: TObject);
var
  sqlstr:string;
begin
  if (strtoint(vprev)=1) or (strtoint(vprev)=3) then
  begin
    ShowMsg('�Բ���!��û�иó���Ŀ�дȨ��',1);
    exit;
  end;
    if Dmcon.tmpQry.Active then Dmcon.tmpQry.Close ;
  Dmcon.tmpQry.SQL.Clear ;
  Dmcon.tmpQry.SQL.Add('select rkey from data0400 where status = 0');
  Dmcon.tmpQry.Prepared ;
  Dmcon.tmpQry.Open ;
  if not Dmcon.tmpQry.IsEmpty then
      begin
          Dmcon.tmpQry.Close ;
          Dmcon.tmpQry.SQL.Clear ;
          ShowMsg('���������̵�,���ܲ���',1);
          exit;
      end;
  Dmcon.tmpQry.Close ;
  Dmcon.tmpQry.SQL.Clear ;
{1��	����56����ҵ�����߼�¼���ѷ���ǰ���򣬸���Ϊ��ǰ����(WType�ֶ�)������ǰ�������Ϊ0}
//�ж���ҵ���Ƿ񷵹�״̬,����Ͳ��ܽ�������
  if dmcon.adsWOCtrlList.FieldByName('wtype').AsInteger = 0 then
  begin
    ShowMsg('��ǰ��ҵ�����Ƿ���״̬,���ܽ�������',1);
    exit;
  end;
  try
    if not dmcon.ADOConnection1.InTransaction then
      dmcon.ADOConnection1.BeginTrans;
    //����������ҵ���Ĺ���,�ѷ���״̬��Ϊ��,wType 0:����,����ֵ������
    Sqlstr:=' update data0056 set Dept_ptr = (select Dept_ptr from data0038 where source_ptr='+dmcon.adsWOCtrlList.fieldbyName('bom_ptr').Asstring+' and step_number=D56.wType) from data0056 D56 where Wo_ptr='+dmcon.adsWOCtrlList.FieldByName('rKey').Asstring+#13+#10+
            ' update data0056 set Step=wType,wType=0 where Wo_ptr='+dmcon.adsWOCtrlList.FieldByName('rKey').Asstring
           +' update Data0006'  //���������������״̬
           +' set Data0006.PROD_STATUS = 5'
           +' FROM Data0006 INNER JOIN'
                 +' Data0056 ON Data0006.RKEY = Data0056.WO_PTR INNER JOIN'
                 +' Data0025 ON Data0006.BOM_PTR = Data0025.RKEY'
           +' WHERE (Data0006.PROD_STATUS = 3)'
                  +' and (Data0025.PARENT_PTR is null)'
                   +' AND (Data0056.STEP IN'
                     +' (SELECT MAX(step_number)'
                    +' FROM data0038 INNER JOIN'
                          +' data0034 ON data0038.dept_ptr = data0034.rkey'
                    +' WHERE data0038.source_ptr = data0025.rkey AND'
                          +' data0034.barcode_entry_flag = ''Y'' '
                          +' )) AND (Data0006.RKEY ='+ dmcon.adsWOCtrlList.FieldByName('rKey').Asstring+')'
           +' update Data0006'  //�����ڲ���ҵ����״̬
           +' set Data0006.PROD_STATUS = 6'
           +' FROM Data0006 INNER JOIN'
                 +' Data0056 ON Data0006.RKEY = Data0056.WO_PTR INNER JOIN'
                 +' Data0025 ON Data0006.BOM_PTR = Data0025.RKEY'
           +' WHERE (Data0006.PROD_STATUS = 3)'
                  +' and (Data0025.PARENT_PTR is not null)'
                   +' AND (Data0056.STEP IN'
                     +' (SELECT MAX(step_number)'
                    +' FROM data0038 INNER JOIN'
                          +' data0034 ON data0038.dept_ptr = data0034.rkey'
                    +' WHERE data0038.source_ptr = data0025.rkey AND'
                          +' data0034.barcode_entry_flag = ''Y'' '
                          +' )) AND (Data0006.RKEY ='+ dmcon.adsWOCtrlList.FieldByName('rKey').Asstring+')'
           +' Delete Data0238 Where WO_PTR = '+ dmcon.adsWOCtrlList.FieldByName('rKey').Asstring;

    if not MyDataClass.ExecSql(sqlstr) or not Update_WO_LOG(dmcon.adsWOCtrlList.FieldByName('rKey').AsInteger,5,'��������') then
    begin
      dmcon.ADOConnection1.RollbackTrans;
      ShowMsg('��ҵ��������������ʧ�ܣ�',1);
      abort;
    end;
    dmcon.ADOConnection1.CommitTrans;
    RefreshData(dmcon.adsWOCtrlList.fieldbyName('rKey').Asinteger);
  except
    dmcon.ADOConnection1.RollbackTrans;
    ShowMsg('��ҵ��������������ʧ�ܣ�',1);
  end;
end;

procedure TfrmWOCtrl.N6Click(Sender: TObject);
var
  Is_Last_Step:boolean;
begin
  if (strtoint(vprev)=1) or (strtoint(vprev)=3) then
  begin
    ShowMsg('�Բ���!��û�иó���Ŀ�дȨ��',1);
    exit;
  end;
  if Dmcon.tmpQry.Active then Dmcon.tmpQry.Close ;
  Dmcon.tmpQry.SQL.Clear ;
  Dmcon.tmpQry.SQL.Add('select rkey from data0400 where status = 0');
  Dmcon.tmpQry.Prepared ;
  Dmcon.tmpQry.Open ;
  if not Dmcon.tmpQry.IsEmpty then
      begin
          Dmcon.tmpQry.Close ;
          Dmcon.tmpQry.SQL.Clear ;
          ShowMsg('���������̵�,���ܲ���',1);
          exit;
      end;
  Dmcon.tmpQry.Close ;
  Dmcon.tmpQry.SQL.Clear ;
//����,�ж���ҵ��״̬�Ƿ�Ϊ"������",��������
  if dmcon.adsWOCtrlList.FieldByName('Prod_status').AsInteger = 3 then
  begin
    if dmcon.adsWOCtrlList.FieldByName('wtype').AsInteger > 0 then
    begin
      ShowMsg('��ǰ��ҵ�����ڷ���״̬,������������������',1); //������������ܵ�������
      exit;
    end; 
    with TfrmDlg_WO_Flow_Chng.Create(Application)do
    try
      InitForm(dmcon.adsWOCtrlList.fieldbyName('rKey').Value,2,dmcon.adsWOCtrlList.fieldbyName('bom_ptr').Value);
      if Showmodal=mrok then
      begin
        Is_Last_Step:= comboxStepNew.ItemIndex = comboxStepNew.Items.Count - 1;
        if WO_Change_Flow(dmcon.adsWOCtrlList.fieldbyName('rKey').Value,StrtoInt(copy(comboxStepNew.Text,1,3)),edtPriorityNew.value,dmcon.adsWOCtrlList.fieldbyName('bom_ptr').Value,'�ɵ�:'+dmcon.adsWOCtrlList.fieldbyName('step').AsString +' ������:'+inttostr(strtoint(copy(comboxStepNew.Text,1,3)))+'�� ԭ��:'+Memo2.text,Is_Last_Step)then
          RefreshData(dmcon.adsWOCtrlList.fieldbyName('rKey').Asinteger);
      end;
    finally
      free;
    end
  end
  else
    ShowMsg('ֻ��״̬Ϊ�����е���ҵ�����ܱ�����,����',1);
end;

function TfrmWOCtrl.WO_Change_Flow(rKey, StepNo, Priority,prodRkey: integer;
  remark: string;Is_Last_Step:boolean): boolean;
var
  sqlstr:string;
begin
{1��	����������ҵ�����������߼�¼data0056���ѹ������Ϊ�����Ĺ����衣
2��	�������Ĺ����Ƿ����һ����������ǣ���ô����ƷΪ��㣬��ô�Ѳ�Ʒ״̬�ı�Ϊ"�����"��������ڲ�����ͰѲ�Ʒ״̬��Ϊ"������"
3��	������־����¼�����ˣ�����ʱ�䣬���͵���Ϣ��Data0017������¼��Source_Type=2��Action����Ϊ7
4)  ��ѯ0025��������ĺ�Ĺ�����Ҫѹ���Ӳ�������WIPMAT_STATUS��ֵ��Ϊ0 ����
}
  try
    if not dmcon.ADOConnection1.InTransaction then
      dmcon.ADOConnection1.BeginTrans;
    //����������ҵ���Ĺ���,�������ȼ�
    sqlstr:=' update data0056 set Step='+InttoStr(StepNo)+', Dept_ptr = (select Dept_ptr from data0038 where source_ptr='+IntToStr(ProdRkey)+' and step_number='+InttoStr(StepNo)+') where Wo_ptr='+InttoStr(rKey)+#13+#10+
            ' update data0006 set PRIORITY_CODE='+InttoStr(Priority)+' where rKey='+InttoStr(rKey);
    if not MyDataClass.ExecSql(sqlstr) then
      abort;

    //############�������20121029  {�����data0025�д��ں͵�ǰ���Ĺ�����ͬ�ļ�¼����set WIPMAT_STATUS=0}
    with Dmcon.tmpQry  do
    begin
      Close;
      SQL.Clear;
      SQL.Text:='if exists(select * from data0025 '
        +'where PARENT_PTR in (  select BOM_PTR from  data0006  '
                              +' where WORK_ORDER_NUMBER='+quotedStr(Dmcon.adsWOCtrlList.FieldByName('WORK_ORDER_NUMBER').AsString)
                              +')'
        +' and BOM_STEP='+InttoStr(StepNo)+' ) '
        +' begin '
        +'   update data0006  set WIPMAT_STATUS=0'
        +'   where WORK_ORDER_NUMBER='+quotedStr(Dmcon.adsWOCtrlList.FieldByName('WORK_ORDER_NUMBER').AsString)
        +' end  ';
      ExecSQL;
    end;
    //############

    if Is_Last_Step then //��������һ��������,��ô���Ĳ�Ʒ״̬
    sqlstr:=' IF exists(select 1 from data0025 D25 inner join Data0006 D06 on D25.rKey=D06.Bom_ptr where IsNULL(D25.parent_ptr,0)>0 and D06.rKey='+IntToStr(rKey)+' ) '+#13+#10+
            ' update data0006 set prod_status=6 where rKey='+ IntToStr(rKey)+#13+#10+
            ' else '+#13+#10+
            ' update data0006 set prod_status=5 where rKey='+ IntToStr(rKey);
    if not MyDataClass.ExecSql(sqlstr) then
      abort;
    //��������־,5:����
    if not Update_WO_LOG(rKey,7,remark) then
      abort;
    dmcon.ADOConnection1.CommitTrans;
    result := true;
  except
    dmcon.ADOConnection1.RollbackTrans;
    result := false;
    ShowMsg('��ҵ���������ʧ�ܣ�',1);
  end;
end;

procedure TfrmWOCtrl.MenuItem4Click(Sender: TObject);//��ҵ����֣�������ɾ����
var
  prod_status:integer;
begin
  if (strtoint(vprev)=1) or (strtoint(vprev)=3) then
  begin
    ShowMsg('�Բ���!��û�иó���Ŀ�дȨ��',1);
    exit;
  end;
  if Dmcon.tmpQry.Active then Dmcon.tmpQry.Close ;
  Dmcon.tmpQry.SQL.Clear ;
  Dmcon.tmpQry.SQL.Add('select rkey from data0400 where status = 0');
  Dmcon.tmpQry.Prepared ;
  Dmcon.tmpQry.Open ;
  if not Dmcon.tmpQry.IsEmpty then
  begin
    Dmcon.tmpQry.Close ;
    Dmcon.tmpQry.SQL.Clear ;
    ShowMsg('���������̵�,���ܲ���',1);
    exit;
  end;
  Dmcon.tmpQry.Close ;
  Dmcon.tmpQry.SQL.Clear ;
  prod_status:= dmcon.adsWOCtrlList.FieldByName('Prod_status').AsInteger;

 { if prod_status <> 2 then
  begin
      //�жϹ����Ƿ�������
    sqlstr:='select 1  from data0034 where PERMIT_SPLIT_LOT=1 and rKey= '+dmcon.adsWOCtrlList.FieldByName('Dept_ptr').Asstring;
    if not MyDataClass.IsExists(sqlstr) then
    begin
      ShowMsg('��ǰ������������ҵ��',1);
      exit;
    end;
  end; }
  //if (prod_status = 3) or (prod_status=5) or (prod_status=6) then //״̬Ϊ�������䡢����֣������е���ҵ�����������
  if (prod_status = 2) or (prod_status = 3) or (prod_status=5) or (prod_status=6) then //״̬Ϊ�������䡢����֣������е���ҵ�����������
  begin
    if dmcon.adsWOCtrlList.FieldByName('wtype').AsInteger > 0 then
    begin
      ShowMsg('��ǰ��ҵ�����ڷ���״̬,���������',1);
      exit;
    end;
    frmDlg_WO_Split :=  TfrmDlg_WO_Split.Create(Application);
    with frmDlg_WO_Split do
    try
      My_prod_status := prod_status;
      if Showmodal=mrok then
      begin
        if WO_Split(dmcon.adsWOCtrlList.fieldbyName('rKey').Asinteger,StrToINt(edtNewPCS.Text),StrToInt(edtNewPNL.Text),edtNewWONO.Text,memo1.Text) then
        begin
          RefreshData(dmcon.adsWOCtrlList.fieldbyName('rKey').Asinteger);
          ShowMsg('�����ҵ���ɹ���',1);
        end
        else
          ShowMsg('�����ҵ��ʧ�ܣ�',1);
      end;
    finally
      free;
    end
  end
  else
    ShowMsg('ֻ��״̬Ϊ:�����䡢����֣������е���ҵ�����ܱ����,����',1);
end;

function TfrmWOCtrl.WO_Split(rKey, PCS, PNL: integer; NEW_WONO,
  Remark: string): boolean;
  function HasIn56(WN: string; out RKey56: Integer): Boolean;
  var
    LQry: TADOQuery;
    LS: TStringList;
  begin
    LQry := TADOQuery.Create(Self);
    LS := TStringList.Create;
    try
      LS.Clear;
      LS.Add('SELECT D56.* FROM Data0056 D56 ');
      LS.Add('INNER JOIN Data0006 D06 ON D56.WO_PTR = D06.RKey ');
      LS.Add('WHERE D06.WORK_ORDER_NUMBER = ' + QuotedStr(WN));
      Dmcon.SQLOpen(LQry,LS);
      if LQry.IsEmpty then Result := False else Result := True;
      if Result then RKey56 := LQry.FieldByName('RKey').AsInteger else RKey56 := 0;
    finally
      LQry.Close;
      LQry.Free;
      LS.Free;
    end;
  end;
var
  LQry: TADOQuery;
  LS: TStringList;
  RKey56: Integer;
begin
  dmcon.aspWO_Split.Parameters.ParamByName('@OrgRkey').Value :=rKey;
  dmcon.aspWO_Split.Parameters.ParamByName('@WONO').Value :=NEW_WONO;
  dmcon.aspWO_Split.Parameters.ParamByName('@PCS').Value :=PCS;
  dmcon.aspWO_Split.Parameters.ParamByName('@PNL').Value :=PNL;
  dmcon.aspWO_Split.Parameters.ParamByName('@User_ptr').Value :=StrToInt(User_ptr);
  dmcon.aspWO_Split.Parameters.ParamByName('@Remark').Value :=Remark;
  dmcon.aspWO_Split.Parameters.ParamByName('@type').Value :=1;
  dmcon.aspWO_Split.ExecProc;
  result :=dmcon.aspWO_Split.Parameters.ParamByName('@RETURN_VALUE').Value=0;
  if HasIn56(NEW_WONO, RKey56) then
  begin
    if not Assigned(frmDlg_WO_Split) then Exit;
    LQry := TADOQuery.Create(Self);
    LS := TStringList.Create;
    try
      LS.Add('UPDATE Data0056 SET REFERENCE = ' + QuotedStr(frmDlg_WO_Split.Edit1.Text));
      LS.Add(' WHERE RKey=' + IntToStr(RKey56));
      Dmcon.SQLExec(LQry,LS);
    finally
      LQry.Close;
      LQry.Free;
      LS.Free;
    end;
  end;  
end;

procedure TfrmWOCtrl.N8Click(Sender: TObject);
var
  b_OK,b_print_Layers,b_print_impedance,b_print_29, b_print_2901, b_print_502:boolean;
begin
  if strtoint(vprev)<>4 then
  begin
   ShowMsg('�Բ���!��û�иó���Ĵ�ӡȨ��',1);
   exit;
  end;
//ֻ��״̬Ϊ�������У��ⷢ����������֣����������ҵ�����ܴ�ӡ��
  with TfrmDlg_Single_Print.Create(application) do
  try
    b_OK:= Showmodal = mrok ;
    b_print_Layers:=checkbox1.checked;
    b_print_impedance:=CheckBox2.Checked;
    b_print_29 := cbx1.checked;
    b_print_2901 := cbx1.checked;
    b_print_502 := cbx2.Checked;
  finally
    free;
  end;
  if not b_Ok then exit;
  with tform_report.Create(application) do
  TRY
    ads06.Close;
    ads06.Parameters.ParamValues['rkey06']:=
      dmcon.adsWOCtrlList.FieldValues['rkey'];
    ads06.Open;
    ADS25.Open;
    ads38.Open;
    ads493.Open;
    ADS30.Open;
    ads29.Open;
    ADODataSet1.Open;
    ads238.Open;
    ads502.Close;
    ads502.Open;

    ppReport1.Reset;
    ppReport1.Template.FileName :=
      stringReplace(UpperCase(GetCurrentDir),'EXEC','NIERP\REPORT\',[rfReplaceAll])+
        'Manu_workorder.rtm';
    ppReport1.Template.LoadFromFile;

    ppSubReport1.Visible := b_print_impedance;
    ppSubReport2.Visible := b_print_Layers;
    ppSubReport3.Visible := b_print_29;
    ppSubReport4.Visible := b_print_502;
    ppSubReport5.Visible := b_print_2901;

//����ͼ

      if (not ads502DSDesigner.IsNull) then
      begin
        ppImage8.Picture.Assign(Load_JPG_Pic_From_DB(ads502DSDesigner));
      end;

       if ads502A3.Value>0 then
        ppImage9.Picture.Assign(Load_JPG_Pic_From_DB(ads502A))
       else
        ppImage9.Visible := False;

       if ads502B.AsVariant <> null then
        ppImage10.Picture.Assign(Load_JPG_Pic_From_DB(ads502B))
       else
        ppImage10.Visible := False;


    ppreport1.SaveAsTemplate:=false;
    if not ADS25.Active then
    begin
      ADS25.Close;
      ADS25.Parameters[0].Value := ads06.fieldbyname('BOM_PTR').AsInteger;
      ADS25.Open;
    end;
    if (not ADS25DSDesigner29.IsNull) then
    begin
      ppImage7.Visible:=True;
      ppImage7.Picture.Assign(Load_JPG_Pic_From_DB(ADS25DSDesigner29));
    end
    else
      ppImage7.Visible:=False;


    ppreport1.Print;
    self.BitBtn3Click(sender);
  FINALLY
    Free;
  END;     
end;

procedure TfrmWOCtrl.Single_Print(rKey: integer;subPrint,ipdPrint:boolean;print29: Boolean = False;print502: Boolean = False);
begin
  with tform_report.Create(application) do
  try
    ads06.Close;
    ads06.Parameters.ParamValues['rkey06']:=rKey;
    ads06.Open;
    if not ADS25.Active then
    begin
      ADS25.Close;
      ADS25.Parameters[0].Value := ads06.fieldbyname('BOM_PTR').AsInteger;
      ADS25.Open;
    end;

    ads06.Open;
    //ADS25.Open;
    ads38.Open;
    ads493.Open;
    ADS30.Open;
    ads29.Open;
    ads238.Open;
    ads502.Close;
    ads502.Open;

    ppReport1.Reset;
    ppReport1.Template.FileName :=
      stringReplace(UpperCase(GetCurrentDir),'EXEC','NIERP\REPORT\',[rfReplaceAll])+
        'Manu_workorder.rtm';
    ppReport1.Template.LoadFromFile;

    ppSubReport1.Visible:=ipdPrint;
    ppSubReport2.Visible:=subPrint;
    ppSubReport3.Visible := print29;


    ppSubReport4.Visible := print502;

//����ͼ

      if (not ads502DSDesigner.IsNull) then
      begin
        ppImage8.Picture.Assign(Load_JPG_Pic_From_DB(ads502DSDesigner));
      end;

       if ads502A3.Value>0 then
        ppImage9.Picture.Assign(Load_JPG_Pic_From_DB(ads502A))
       else
        ppImage9.Visible := False;

       if ads502B.AsVariant <> null then
        ppImage10.Picture.Assign(Load_JPG_Pic_From_DB(ads502B))
       else
        ppImage10.Visible := False;

    ppreport1.DeviceType:='Printer';
    ppreport1.ShowPrintDialog:=false;
    ppreport1.SaveAsTemplate:=false;
    if (not ADS25DSDesigner29.IsNull) then
    begin
      ppImage7.Visible:=True;
      ppImage7.Picture.Assign(Load_JPG_Pic_From_DB(ADS25DSDesigner29));
    end
    else
      ppImage7.Visible:=False;
    ppreport1.Print;
  FINALLY
    Free;
  END;
end;

procedure TfrmWOCtrl.N9Click(Sender: TObject);
var
  i:integer;
  subsql:string;
begin
  if strtoint(vprev)<>4 then
  begin
   ShowMsg('�Բ���!��û�иó���Ĵ�ӡȨ��',1);
   exit;
  end;
//ֻ��״̬Ϊ�������У��ⷢ����������֣����������ҵ�����ܴ�ӡ��
  with TForm_mulreport.Create(application) do
  try
    if Showmodal = mrok then
    begin
      subsql:='';
      for i:=1 to StG2.RowCount-2 do
      begin
        Single_Print(StrToInt(StG2.cells[2,i]),CheckBox1.Checked,CheckBox2.Checked,cbx1.checked, cbx2.Checked);
        if subsql='' then
          subsql:=StG2.cells[2,i]
        else
          subsql:=subsql+','+StG2.cells[2,i];
      end;
   self.BitBtn3Click(sender);

    end;
  finally
    free;
  end;
end;



procedure TfrmWOCtrl.N13Click(Sender: TObject);
begin
  with tform_report.Create(application) do
  try
    ppReport1.Reset;
    ppReport1.Template.FileName :=
      stringReplace(UpperCase(GetCurrentDir),'EXEC','NIERP\REPORT\',[rfReplaceAll])+
        'Manu_workorder.rtm';
    ppReport1.Template.LoadFromFile;
    ppReport1.SaveAsTemplate:=true;
    ppDesigner1.ShowModal;
  FINALLY
    Free;
  END;
end;

procedure TfrmWOCtrl.N14Click(Sender: TObject);
begin
  with tform_equipmentreport.Create(application) do
  try
    ppReport1.Reset;
    ppReport1.Template.FileName :=
      stringReplace(GetCurrentDir,'EXEC','NIERP\REPORT\',[rfReplaceAll])+
        'equipment_report.rtm';
    ppReport1.Template.LoadFromFile;
    ppReport1.SaveAsTemplate:=true;
    ppDesigner1.ShowModal;
  FINALLY
    Free;
  END;
end;

procedure TfrmWOCtrl.BitBtn6Click(Sender: TObject);
begin
  popupmenu3.Popup(mouse.CursorPos.x,mouse.CursorPos.y);
end;

procedure TfrmWOCtrl.Single_equipmentPrint(rKey25: integer);
begin
  with tform_equipmentreport.Create(application) do
  try
    ADS25.Close;
    ADS25.Parameters.ParamValues['bom_ptr']:=rKey25;
    ADS25.Open;
    ppReport1.Reset;
    ppReport1.Template.FileName :=
      stringReplace(GetCurrentDir,'EXEC','NIERP\REPORT\',[rfReplaceAll])+
        'equipment_report.rtm';
    ppReport1.Template.LoadFromFile;
    ppReport1.SaveAsTemplate:=false;

    ppreport1.DeviceType:='Printer';
    ppreport1.ShowPrintDialog:=false;
    ppreport1.Print;
  FINALLY
    Free;
  END;
end;

procedure TfrmWOCtrl.N12Click(Sender: TObject);
var
  i:integer;
begin
  if strtoint(vprev)<>4 then
  begin
   ShowMsg('�Բ���!��û�иó���Ĵ�ӡȨ��',1);
   exit;
  end;

  with TForm_mulreport.Create(application) do
  try
   checkbox1.Visible:=false;
   caption:='������ӡ��ҵ�������豸';
   if Showmodal = mrok then
    for i:=1 to StG2.RowCount-2 do
     Single_equipmentPrint(StrToInt(StG2.cells[4,i]));
  finally
    free;
  end;
end;

procedure TfrmWOCtrl.N11Click(Sender: TObject);

begin
  if strtoint(vprev)<>4 then
  begin
   ShowMsg('�Բ���!��û�иó���Ŀ�дȨ��',1);
   exit;
  end;
//ֻ��״̬Ϊ�������У��ⷢ����������֣����������ҵ�����ܴ�ӡ��

  with tform_equipmentreport.Create(application) do
  TRY
    ads25.Close;
    ads25.Parameters.ParamValues['bom_ptr']:=
          dmcon.adsWOCtrlList.FieldValues['bom_ptr'];
    ads25.Open;
    ppReport1.Reset;
    ppReport1.Template.FileName :=
      stringReplace(GetCurrentDir,'EXEC','NIERP\REPORT\',[rfReplaceAll])+
        'equipment_report.rtm';
    ppReport1.Template.LoadFromFile;
    ppReport1.SaveAsTemplate:=false;

    ppreport1.Print;

  FINALLY
   Free;
  END;

end;





procedure TfrmWOCtrl.DBGridEh1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (ssAlt in Shift)  and  (Key=86) then
  showmessage(TADODataSet(DBGridEh1.DataSource.DataSet).CommandText);
end;

procedure TfrmWOCtrl.N17Click(Sender: TObject);
begin
  with tform_equipmentreport.Create(application) do
  try
    ppReport1.Reset;
    ppReport1.Template.FileName :=
      stringReplace(UpperCase(GetCurrentDir),'EXEC','NIERP\REPORT\',[rfReplaceAll])+
        'qa_track_report.rtm';
    ppReport1.Template.LoadFromFile;
    ppReport1.SaveAsTemplate:=true;
    ppDesigner1.ShowModal;
  FINALLY
    Free;
  END;

//D:\SJSYS\NIERP\REPORT\qa_track_report.rtm
end;

procedure TfrmWOCtrl.N16Click(Sender: TObject);
begin
  if strtoint(vprev)<>4 then
  begin
   ShowMsg('�Բ���!��û�иó���Ŀ�дȨ��',1);
   exit;
  end;
//ֻ��״̬Ϊ�������У��ⷢ����������֣����������ҵ�����ܴ�ӡ��

  with tform_equipmentreport.Create(application) do
  TRY
    ads25.Close;
    ads25.Parameters.ParamValues['bom_ptr']:=
          dmcon.adsWOCtrlList.FieldValues['bom_ptr'];
    ads25.Open;
    ppReport1.Reset;
    ppReport1.Template.FileName :=
      stringReplace(UpperCase(GetCurrentDir),'EXEC','NIERP\REPORT\',[rfReplaceAll])+
        'qa_track_report.rtm';
    ppReport1.Template.LoadFromFile;
    ppReport1.SaveAsTemplate:=false;

    ppreport1.Print;

  FINALLY
   Free;
  END;

end;

procedure TfrmWOCtrl.FormCreate(Sender: TObject);
begin
  WindowState:=wsMaximized    ;
end;

procedure TfrmWOCtrl.N18Click(Sender: TObject);
var
  prod_status:integer;
//  sqlstr:string;
begin
  if (strtoint(vprev)=1) or (strtoint(vprev)=3) then
  begin
    ShowMsg('�Բ���!��û�иó���Ŀ�дȨ��',1);
    exit;
  end;
  if Dmcon.tmpQry.Active then Dmcon.tmpQry.Close ;
  Dmcon.tmpQry.SQL.Clear ;
  Dmcon.tmpQry.SQL.Add('select rkey from data0400 where status = 0');
  Dmcon.tmpQry.Prepared ;
  Dmcon.tmpQry.Open ;
  if not Dmcon.tmpQry.IsEmpty then
  begin
    Dmcon.tmpQry.Close ;
    Dmcon.tmpQry.SQL.Clear ;
    ShowMsg('���������̵�,���ܲ���',1);
    exit;
  end;
  Dmcon.tmpQry.Close ;
  Dmcon.tmpQry.SQL.Clear ;
  prod_status:= dmcon.adsWOCtrlList.FieldByName('Prod_status').AsInteger;
  if (prod_status = 2) then //�˴�ֻ������"������"����ҵ��
  begin
    frmDlg_WO_Split :=  TfrmDlg_WO_Split.Create(Application);
    with frmDlg_WO_Split do
    try
      My_prod_status := prod_status;
      if Showmodal=mrok then
      begin
        if WO_Split(dmcon.adsWOCtrlList.fieldbyName('rKey').Asinteger,StrToINt(edtNewPCS.Text),StrToInt(edtNewPNL.Text),edtNewWONO.Text,memo1.Text) then
        begin
          RefreshData(dmcon.adsWOCtrlList.fieldbyName('rKey').Asinteger);
          ShowMsg('�����ҵ���ɹ���',1);
        end
        else
          ShowMsg('�����ҵ��ʧ�ܣ�',1);
      end;
    finally
      free;
    end;  
  end
  else
    ShowMsg('�˴�ֻ������״̬Ϊ��[������]����ҵ��'+#13+#13+'�����в���뵽[��ҵ��״̬��ѯ]���������',1);
end;

procedure TfrmWOCtrl.N19Click(Sender: TObject);
var
  Sqlstr: string;
begin
  {�ȼ����رյ���ҵ���Ƿ����ڲ�����¼}
  with Dmcon.tmp do
  begin
    close;
    sql.Clear;
    sql.Add('Select * from Data0489 where wo_ptr='+dmcon.adsWOCtrlList.FieldByName('RKEY').AsString);
    open;
  end;
  if Dmcon.tmp.RecordCount>0 then
  begin
    Showmessage('����ҵ�������ڲ�����¼,������ر�!');
    Abort;
  end;

  if MessageBox(Handle, '���������ɻָ���ȷ���ر���ҵ����', '����', MB_OKCANCEL +
    MB_ICONQUESTION) = IDCANCEL then Abort;
  sqlstr:= 'Update data0006 set PROD_STATUS = 202 where RKEY ='+dmcon.adsWOCtrlList.FieldByName('RKEY').AsString;
  sqlstr:= sqlstr+' Update data0492 set Issued_Qty=Issued_Qty-'+dmcon.adsWOCtrlList.FieldByName('QUAN_SCH').AsString
                 +',waitfor_release=waitfor_release-'+dmcon.adsWOCtrlList.FieldByName('QUAN_SCH').AsString;
  if dmcon.adsWOCtrlList.FieldByName('PANEL_A_B').AsInteger = 0 then
    sqlstr:= sqlstr+',PANEL_1_QTY=PANEL_1_QTY-'+dmcon.adsWOCtrlList.FieldByName('PANELS').AsString
  else
    sqlstr:= sqlstr+',PANEL_2_QTY=PANEL_2_QTY-'+dmcon.adsWOCtrlList.FieldByName('PANELS').AsString;
  sqlstr:= sqlstr+' where CUT_NO='+QuotedStr(dmcon.adsWOCtrlList.FieldByName('CUT_NO').AsString);
  if sqlstr<>'' then
  begin
    if not MyDataclass.ExecSql(sqlstr) then
      ShowMsg('�ر���ҵ��ʧ��',1)
    else
      ShowMsg('�����ɹ�',1);
  end;
  RefreshData(dmcon.adsWOCtrlList.fieldbyName('RKEY').Asinteger);
end;

procedure TfrmWOCtrl.N20Click(Sender: TObject);
begin
  if strtoint(vprev)<>4 then
  begin
    ShowMsg('�Բ���!��û�иó���Ĵ�ӡȨ��',1);
    Exit;
  end;
  { TODO -olrl -c : ��ӡ������ҵ�� 2013-05-30 8:34:49 }
  with TForm_report.Create(Application) do
  TRY
    ads06.Close;
    ads06.Parameters.ParamValues['rkey06']:=
      dmcon.adsWOCtrlList.FieldValues['rkey'];
    ads06.Open;
    ppReport2.Reset;
    ppReport2.Template.FileName :=
      stringReplace(UpperCase(GetCurrentDir),'EXEC','NIERP\REPORT\',[rfReplaceAll])+
        'Manu_ReWorkorder.rtm';
    ppReport2.Template.LoadFromFile;
    ppreport2.SaveAsTemplate:=false;
    ppreport2.Print;
    self.BitBtn3Click(sender);
  FINALLY
    Free;
  END;
end;

procedure TfrmWOCtrl.N21Click(Sender: TObject);
begin
  { TODO -olrl -c : ������ҵ����� 2013-05-30 8:54:20 }
  with tform_report.Create(application) do
  try
    ppReport2.Reset;
    ppReport2.Template.FileName :=
      stringReplace(UpperCase(GetCurrentDir),'EXEC','NIERP\REPORT\',[rfReplaceAll])+
        'Manu_ReWorkorder.rtm';
    ppReport2.Template.LoadFromFile;
    ppReport2.SaveAsTemplate:=true;
    ppDesigner2.ShowModal;
  FINALLY
    Free;
  END;
end;

procedure TfrmWOCtrl.N22Click(Sender: TObject);
begin
if strtoint(vprev)<>4 then
  begin
   ShowMsg('�Բ���!��û�иó���Ŀ�дȨ��',1);
   exit;
  end;
//ֻ��״̬Ϊ�������У��ⷢ����������֣����������ҵ�����ܴ�ӡ��

  with tform_equipmentreport.Create(application) do
  TRY
    ads25.Close;
    ads25.Parameters.ParamValues['bom_ptr']:=
          dmcon.adsWOCtrlList.FieldValues['bom_ptr'];
    ads25.Open;
    ppReport1.Reset;
    ppReport1.Template.FileName :=
      stringReplace(UpperCase(GetCurrentDir),'EXEC','NIERP\REPORT\',[rfReplaceAll])+
        'qa_track_report_2.rtm';
    ppReport1.Template.LoadFromFile;
    ppReport1.SaveAsTemplate:=false;

    ppreport1.Print;

  FINALLY
   Free;
  END;

end;

procedure TfrmWOCtrl.N23Click(Sender: TObject);
begin
  with tform_equipmentreport.Create(application) do
  try
    ppReport1.Reset;
    ppReport1.Template.FileName :=
      stringReplace(UpperCase(GetCurrentDir),'EXEC','NIERP\REPORT\',[rfReplaceAll])+
        'qa_track_report_2.rtm';
    ppReport1.Template.LoadFromFile;
    ppReport1.SaveAsTemplate:=true;
    ppDesigner1.ShowModal;
  FINALLY
    Free;
  END;
end;

procedure TfrmWOCtrl.RadioGroup2Click(Sender: TObject);
var
  i: Integer;
begin
  if RadioGroup2.ItemIndex=1 then  //�������
  begin
    for i:= 0 to DBGridEh1.Columns.Count-1 do
    begin
      if UpperCase(DBGridEh1.Columns[i].FieldName)='UNIT_SQ_INCLUDINGBOADER' then DBGridEh1.Columns[i].Visible:= False;
      if UpperCase(DBGridEh1.Columns[i].FieldName)='UNIT_SQ' then DBGridEh1.Columns[i].Visible:= True;
    end;
  end
  else if RadioGroup2.ItemIndex=0 then  //�����
  begin
    for i:= 0 to DBGridEh1.Columns.Count-1 do
    begin
      if UpperCase(DBGridEh1.Columns[i].FieldName)='UNIT_SQ' then DBGridEh1.Columns[i].Visible:= False;
      if UpperCase(DBGridEh1.Columns[i].FieldName)='UNIT_SQ_INCLUDINGBOADER' then DBGridEh1.Columns[i].Visible:= True;
    end;                                            
  end
  else
  begin
    for i:= 0 to DBGridEh1.Columns.Count-1 do
    begin
      if UpperCase(DBGridEh1.Columns[i].FieldName)='UNIT_SQ' then DBGridEh1.Columns[i].Visible:= False;
      if UpperCase(DBGridEh1.Columns[i].FieldName)='UNIT_SQ_INCLUDINGBOADER' then DBGridEh1.Columns[i].Visible:= False;
    end;
  end;
end;

end.
