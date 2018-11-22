unit WO_Release;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGridEh, ComCtrls, StdCtrls, Buttons, ExtCtrls,db,DBClient,ADODB;

type
  TfrmWO_Release = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    labelKey: TLabel;
    btnExecRelease: TSpeedButton;
    BitBtn1: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn2: TBitBtn;
    edtKey: TEdit;
    dtpStartDate: TDateTimePicker;
    dtpEndDate: TDateTimePicker;
    DBGridEh1: TDBGridEh;
    btnSelectAll: TSpeedButton;
    btnClearAll: TSpeedButton;
    StatusBar1: TStatusBar;
    btnRefresh: TSpeedButton;
    BitBtn4: TBitBtn;
    btnexp: TBitBtn;
    procedure btnSelectAllClick(Sender: TObject);
    procedure btnClearAllClick(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure DBGridEh1TitleClick(Column: TColumnEh);
    procedure BitBtn1Click(Sender: TObject);
    procedure edtKeyChange(Sender: TObject);
    procedure edtKeyKeyPress(Sender: TObject; var Key: Char);
    procedure dtpStartDateChange(Sender: TObject);
    procedure btnExecReleaseClick(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure DBGridEh1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure btnexpClick(Sender: TObject);
  private
    StepIncNum:integer;
    vColumn:TColumnEh;
    StartDate,EndDate:TDatetime;
    procedure OpenWOList(rKey:integer);                  //������ҵ���б�
    function ExecRelease:boolean;                               //������ҵ������
    function ReleaseWO(ProdRkey,WORkey:integer;prod_status:integer=3):boolean; //������ҵ������
    procedure DoSearch(subSql:string);
    function Check_Before_Release(rKey60:integer):boolean;//����ǰ�����ҵ��״̬
    function IsAuth(cut_no: string): Boolean;
  public

  end;

var
  frmWO_Release: TfrmWO_Release;

implementation

uses MyClass,dm,common,ProcessShow,QuerySet,Frm_FacSel_u;
{$R *.dfm}

procedure TfrmWO_Release.btnSelectAllClick(Sender: TObject);
begin
  if not dmcon.cdsWOReleaseList.Active then exit;
  MyDataClass.UpdateValueToField(dmcon.cdsWOReleaseList,true,'IsSelected');
end;

procedure TfrmWO_Release.btnClearAllClick(Sender: TObject);
begin
  if not dmcon.cdsWOReleaseList.Active then exit;
  MyDataClass.UpdateValueToField(dmcon.cdsWOReleaseList,false,'IsSelected');
end;

procedure TfrmWO_Release.btnRefreshClick(Sender: TObject);
var
  rKey:integer;
  sqlstr:string;
begin
  if dmcon.cdsWOReleaseList.Active then
  begin
    rKey:=dmcon.cdsWOReleaseList.FieldByName('rKey').AsInteger;
    OpenWOList(rKey);
  end else begin
//    sqlstr:=sqlstr+' and D06.ent_datetime>='+QuotedStr(Formatdatetime('yyyy-mm-dd',Date))+' and D06.ent_datetime<'+QuotedStr(Formatdatetime('yyyy-mm-dd',Date+1));
    sqlstr:=sqlstr+' and 1=1 ';
    DoSearch(sqlstr);
  end;
end;

procedure TfrmWO_Release.DBGridEh1TitleClick(Column: TColumnEh);
var OldIndex:string;
begin
  vColumn.Title.Color:=clBtnFace;
  vColumn := Column;
  vColumn.Title.Color:=clred;
  labelKey.Caption := Column.Title.Caption;
  if (Column.Grid.DataSource=nil) or (Column.Grid.DataSource.DataSet=nil) or (not Column.Grid.DataSource.DataSet.Active) then
    Exit;
  OldIndex:=TClientDataSet(Column.Field.DataSet).IndexName;

  if OldIndex<>'' then
  begin
    TClientDataSet(Column.Field.DataSet).IndexName:='';
    TClientDataSet(Column.Field.DataSet).DeleteIndex(OldIndex);
  end;
  if Column.Title.SortMarker = smDownEh then
  begin
    TClientDataSet(Column.Field.DataSet).AddIndex('px',Column.Field.FieldName,[ixPrimary]);
    TClientDataSet(Column.Field.DataSet).IndexName:='px';
    Column.Title.SortMarker := smUpEh;
  end
  else if Column.Title.SortMarker = smUpEh then
    Column.Title.SortMarker := smNoneEh
  else if Column.Title.SortMarker = smNoneEh then
  begin
    TClientDataSet(Column.Field.DataSet).AddIndex('px',Column.Field.FieldName,[ixDescending]);//�Ѿ�������Ͱ���������
    TClientDataSet(Column.Field.DataSet).IndexName:='px';
    Column.Title.SortMarker := smDownEh;
  end;
  if dmcon.cdsWOReleaseList.IsEmpty then abort;
  edtKey.Visible:= not(Column.Field.DataType  in [ftDate, ftDateTime]);
  labelKey.Visible:= edtKey.Visible;
end;

procedure TfrmWO_Release.OpenWOList(rKey: integer);
begin
  with dmcon do
  begin
    ReSet_Sort(DBGridEh1);
    adsWOReleaseList.Close;
    adsWOReleaseList.Open;
    StatusBar1.Panels[1].Text := IntToStr(dmcon.cdsWOReleaseList.RecordCount);
    if rKey > 0 then cdsWOReleaseList.Locate('rkey',rKey,[]);
  end;
end;

procedure TfrmWO_Release.BitBtn1Click(Sender: TObject);
begin
  close;
end;

procedure TfrmWO_Release.edtKeyChange(Sender: TObject);
var tmpstr,sFilter:string;
begin
  if not dmcon.cdsWOReleaseList.Active then abort;
  tmpstr:= trim(edtKey.Text);
  if TmpStr='' then
    dmcon.cdsWOReleaseList.Filtered:= false
  else
  begin
    if (vColumn.Field.DataType in [ftString,ftWideString,ftMemo]) then
    begin
      sFilter := '%'+uppercase(TmpStr)+'%';
      dmcon.cdsWOReleaseList.Filter := vColumn.Field.FieldName+' Like '+ QuotedStr(sFilter);
      dmcon.cdsWOReleaseList.Filtered:= true;
    end
    else if vColumn.Field.DataType in [ftSmallint, ftInteger, ftWord, ftFloat, ftCurrency, ftBCD,ftLargeint] then
    begin
      if TmpStr='-' then exit;
      sFilter := vColumn.Field.FieldName+'>='+TmpStr;
      dmcon.cdsWOReleaseList.Filter := sFilter;
      dmcon.cdsWOReleaseList.Filtered:= true;
    end
    else if vColumn.Field.DataType in [ftDate, ftDateTime] then
    begin
      if not IsDatetime(TmpStr) then exit;
      sFilter := '>='+QuotedStr(TmpStr);
      dmcon.cdsWOReleaseList.Filter := vColumn.Field.FieldName + sFilter;
      dmcon.cdsWOReleaseList.Filtered:= true;
    end;
  end;
end;

procedure TfrmWO_Release.edtKeyKeyPress(Sender: TObject; var Key: Char);
begin
  if vColumn.Field.DataType in [ftSmallint, ftInteger, ftWord, ftLargeint] then
  begin
    if (length((Sender as TEdit).Text)=20) and (key<>chr(8)) then Abort;
    if Key='.' then abort;
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

procedure TfrmWO_Release.dtpStartDateChange(Sender: TObject);
var  tmpstr1,Tmpstr2,sFilter:string;
begin
  if not dmcon.cdsWOReleaseList.Active then abort;
  TmpStr1:= QuotedStr(DateToStr(dtpStartDate.Date));
  TmpStr2:= QuotedStr(DateToStr(dtpEndDate.Date+1));
  if vColumn.Field.DataType in [ftDate, ftDateTime] then
  begin
    sFilter := vColumn.Field.FieldName+'>='+TmpStr1+ ' AND ' +vColumn.Field.FieldName+'<'+TmpStr2;
    dmcon.cdsWOReleaseList.Filter := sFilter;
    dmcon.cdsWOReleaseList.Filtered:= true;
  end;
end;

function TfrmWO_Release.ExecRelease:boolean;
var
  old_filter:string;
  i:integer;
  bk:Tbookmark;
  iStatus:integer;
begin
  with dmcon do begin
  if not cdsWOReleaseList.Active then exit;
  try
    old_filter:= cdsWOReleaseList.Filter;
    cdsWOReleaseList.Filter := 'IsSelected=1';
    cdsWOReleaseList.Filtered := true;
    i:=cdsWOReleaseList.RecordCount;
    if i =0 then
    begin
      ShowMsg('��ѡ����ҵ��!',1);
      abort;
    end;
    result:=true;
    with TFrm_FacSel.Create(nil) do
    try
      if showmodal=mrok then
      begin
        if RdBtn_self.checked then iStatus:=3 else iStatus:=4;
      end else begin
        result:=false;
        exit;
      end;
    finally
      free;
    end;
    frmProcessShow := TfrmProcessShow.Create(Application);
    frmProcessShow.Show;
    StepIncNum := 100 div (i+1);
    frmProcessShow.IncStep(StepIncNum,'���ڴ�����ҵ������...');
    cdsWOReleaseList.First;
    while not cdsWOReleaseList.Eof do
    begin
      frmProcessShow.IncStep(StepIncNum,'���ڷ�����ҵ��: '+cdsWOReleaseList.fieldbyName('WORK_ORDER_NUMBER').AsString );
      frmProcessShow.Update;
      if not Check_Before_Release(cdsWOReleaseList.fieldbyName('RKEY').AsInteger) then abort;
      if not ReleaseWO(cdsWOReleaseList.fieldbyName('Bom_ptr').AsInteger, cdsWOReleaseList.fieldbyName('RKEY').AsInteger,iStatus) then
      begin
        if ADOConnection1.InTransaction then ADOConnection1.RollbackTrans;
        ShowMsg('������ҵ��: '+cdsWOReleaseList.fieldbyName('WORK_ORDER_NUMBER').AsString+'ʧ��,����',1);
        abort;
      end;
      cdsWOReleaseList.next;
    end;
    frmProcessShow.hide;
    ShowMsg('������ҵ�������!',1);
  finally
    if old_filter <> '' then
    begin
      cdsWOReleaseList.Filter := old_filter;
      cdsWOReleaseList.Filtered := true;
    end
    else
    begin
      cdsWOReleaseList.Filter :='';
      cdsWOReleaseList.Filtered := false;
    end;
    if frmProcessShow <> nil then frmProcessShow.Free;
  end;
  end;
end;

function TfrmWO_Release.ReleaseWO(ProdRkey,WORkey: integer;prod_status:integer=3): boolean;
var
  sqlstr:string;
  i,j:integer;
begin
  result := false;
  with dmcon do
  begin
//1.���鹤�������Ƿ���,���û�н���,��ô��ֹ����,����false
    qryENGFlow.Close;
    qryENGFlow.Parameters.ParamByName('vptr').Value :=ProdRkey;
    qryENGFlow.Parameters.ParamByName('vstep').Value :=1;
    qryENGFlow.open;
    if qryENGFlow.IsEmpty then
    begin
      ShowMsg('�ò�Ʒ�Ĺ������̻�û���������ܷ���!',1);
      exit;
    end;
//2.������ҵ���Ƿ���56�����߼�¼,�����,��ô��ֹ����,����false
    sqlstr:=' select * from data0056 where wo_ptr='+IntTosTr(WORkey);
    if MyDataClass.IsExists(sqlstr) then
    begin
      ShowMsg('����ҵ���Ѿ������������ߣ�����!',1);
      exit;
    end;
//3.����56���߼�
    try
    //���ݸ����������񱣻�
      if not ADOConnection1.InTransaction then
        ADOConnection1.BeginTrans;
      qryENGFlow.First;
      qryENGFlow.Locate('barcode_entry_flag','Y',[]) ;
      sqlstr:= 'Insert into data0056(wo_ptr,dept_ptr,intime,qty_backlog,panels,step,employee_ptr,loc_ptr,wtype,TDate)'+
               ' values('+IntToStr(WoRkey)+','+qryENGFlow.FieldByName('dept_ptr').AsString+',getdate(),'+
               IntToStr(cdsWOReleaseList.fieldbyname('quan_sch').AsInteger-cdsWOReleaseList.fieldbyname('quan_rej').AsInteger-cdsWOReleaseList.fieldbyname('quan_prod').AsInteger)+','+
               cdsWOReleaseList.fieldbyname('panels').AsString+','+qryENGFlow.fieldbyname('step_number').AsString+','+ User_ptr+','+cdsWOReleaseList.fieldbyname('WHOUSE_PTR').AsString+','+
               cdsWOReleaseList.fieldbyname('wtype').AsString+',getdate())';
      if not MyDataClass.ExecSql(sqlstr) then
      begin
        ShowMsg('������Ԥ�ڴ���,����������ҵ�����߼�¼ʧ�ܣ�����ϵϵͳ����Ա!',1);
        exit;
      end;
  //4.������ҵ��״̬Ϊ:������,�ͷ�������
      Dmcon.tmpQry.Close;
      Dmcon.tmpQry.SQL.Text:='select count(data0038.step_number),getdate() from data0034 inner join data0038 on '+
                             'data0038.dept_ptr=data0034.rkey where data0038.source_ptr='+cdsWOReleaseList.fieldbyname('bom_ptr').AsString+
                             ' and data0034.barcode_entry_flag=''Y''';
      Dmcon.tmpQry.Open;
      sysdate:=Dmcon.tmpQry.fields[1].AsDateTime;
      if Dmcon.tmpQry.fields[0].AsInteger>1  then
        sqlstr:='update data0006 set prod_status = '+inttostr(prod_status)+',release_date=getdate() where rKey='+IntToStr(WoRkey)
      else if Dmcon.tmpQry.fields[0].AsInteger=1 then begin //��������ֻ��һ������
        Dmcon.tmpQry.Close;
        Dmcon.tmpQry.SQL.Text:='select parent_ptr from data0025 where rkey='+cdsWOReleaseList.fieldbyname('bom_ptr').AsString;
        Dmcon.tmpQry.Open;
        if Dmcon.tmpQry.Fields[0].AsInteger>0 then     //is son ,������
          sqlstr:='update data0006 set prod_status = 6,release_date=getdate() where rKey='+IntToStr(WoRkey)
        else                                           //has not son �����
          sqlstr:='update data0006 set prod_status = 5,release_date=getdate() where rKey='+IntToStr(WoRkey);
      end else begin
        ShowMsg('δ������������,������!',1);
        exit;
      end;
      Dmcon.tmpQry.Close;

      if not MyDataClass.ExecSql(sqlstr)then
      begin
        ShowMsg('������Ԥ�ڴ���,������ҵ��״̬ʧ�ܣ�����ϵϵͳ����Ա!',1);
        exit;
      end;
  //5.�������ϵ�492:Waitfor_release������������ WIP_Qty����
      sqlstr:=' update data0492 set waitfor_release=IsNULL(waitfor_release,0)-'+IntToStr(cdsWOReleaseList.fieldbyname('quan_sch').AsInteger-cdsWOReleaseList.fieldbyname('quan_rej').AsInteger-cdsWOReleaseList.fieldbyname('quan_prod').AsInteger)+
              ' ,WIP_Qty=ISNULL(WIP_QTY,0)+'+ IntToStr(cdsWOReleaseList.fieldbyname('quan_sch').AsInteger-cdsWOReleaseList.fieldbyname('quan_rej').AsInteger-cdsWOReleaseList.fieldbyname('quan_prod').AsInteger)+
              ' FROM dbo.Data0006 INNER JOIN dbo.data0492 ON dbo.Data0006.CUT_NO = dbo.data0492.CUT_NO where Data0006.rKey= '+IntToStr(WoRkey);
      if not MyDataClass.ExecSql(sqlstr)then
      begin
        ShowMsg('������Ԥ�ڴ���,�������ϵ���������ʧ�ܣ�����ϵϵͳ����Ա!',1);
        exit;
      end;
  //6.�����һ����Ҫ�����Ĺ��������1,��ô,ǰ�漸����Ҫ�����Ĺ�����Ҫ��48������֮ǰ�������ת��¼
      j:=qryENGFlow.Fieldbyname('step_number').asinteger;
      if j >1 then
      begin
        qryENGFlow.first;
        ADO0048.close;
        ADO0048.open;
        for i:=1 to j - 1 do
        begin
          ado0048.Append;
          ado0048.FieldByName('wo_ptr').Asinteger:= cdsWOReleaseList.fieldbyname('rkey').Asinteger ;
          ado0048.FieldByName('fm_dept_ptr').Asinteger:= qryENGFlow.fieldbyname('dept_ptr').Asinteger ;
          ado0048.FieldByName('step_no').AsString:= qryENGFlow.fieldbyname('step_number').AsString ;
          qryENGFlow.Next;
          ado0048.FieldByName('to_dept_ptr').AsString:= qryENGFlow.fieldbyname('dept_ptr').AsString ;
          ado0048.FieldByName('intime').value := sysdate;
          ado0048.FieldByName('outtime').value := sysdate;
          ado0048.FieldByName('qty_prod').AsString:= cdsWOReleaseList.fieldbyname('quan_sch').AsString ;
          ado0048.FieldByName('panels').AsString:= cdsWOReleaseList.fieldbyname('panels').AsString ;
          ado0048.FieldByName('empl_ptr').value :=user_ptr;
          with tmp do
          begin
            Close;
            SQL.Clear;
            SQL.Add('select distinct BIG_DEPT_PTR from data0034 where RKEY in('
                  +ado0048.FieldByName('fm_dept_ptr').AsString+','+ado0048.FieldByName('to_dept_ptr').AsString+')');
            Open;
          end;
          if tmp.RecordCount <= 1 then
            ado0048.FieldByName('put_type').AsInteger:= 0
          else
            ado0048.FieldByName('put_type').AsInteger:= 1;
          if prod_status<>4 then  //not�ⷢ
            ado0048.FieldByName('wtype').AsInteger:= cdsWOReleaseList.fieldbyname('wtype').AsInteger
          else
            ado0048.FieldByName('wtype').AsInteger:=3;
          ado0048.FieldByName('qty_reject').AsInteger:= 0 ;
          ADO0048.FieldByName('warehouse_ptr').AsInteger:=cdsWOReleaseList.fieldbyname('WHOUSE_PTR').AsInteger;
          ado0048.Post;
        end;
        ado0048.UpdateBatch(arAll);
      end;
      ADOConnection1.CommitTrans;
      result := true;
    except
      ADOConnection1.RollbackTrans;
    end;
  end;
end;

procedure TfrmWO_Release.btnExecReleaseClick(Sender: TObject);
begin
  if (strtoint(vprev)=1) or (strtoint(vprev)=3) then
  begin
    ShowMsg('�Բ���!��û�иó���Ŀ�дȨ��',1);
    exit;
  end;
  if ExecRelease then
    btnRefreshClick(sender);
end;

procedure TfrmWO_Release.BitBtn4Click(Sender: TObject);
var
  i:integer;
  sqlstr:string;
begin
  with TfrmQuerySet.Create(Application)do
  try
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
      sqlstr:=sqlstr+' and D06.ent_datetime>='+QuotedStr(Formatdatetime('yyyy-mm-dd',dtpk1.Date))+' and D06.ent_datetime<'+QuotedStr(Formatdatetime('yyyy-mm-dd',dtpk2.Date+1)) 
    end;
  finally
    free;
  end;
  DoSearch(sqlstr);
end;

procedure TfrmWO_Release.DoSearch(subSql: string);
var
  sqlstr:widestring;
  i:integer;
begin
  if subsql='' then exit;
  sqlstr:=uppercase(dmcon.adsWOReleaseList.CommandText);
  i:=Pos('WHERE',sqlstr);
  if i = 0 then
  begin
    ShowMsg('SQL������,����ϵϵͳ����Ա',1);
    abort;
  end;
  ReSet_Sort(DBGridEh1);
  Sqlstr:=copy(sqlstr,1,i-1);
  dmcon.adsWOReleaseList.Close;
  dmcon.adsWOReleaseList.CommandText := sqlstr+' WHERE  (D06.WIPMAT_STATUS = 1) and (D06.PROD_STATUS=2) '+subsql +' ORDER BY D06.WORK_ORDER_NUMBER';
  dmcon.adsWOReleaseList.open;
  StatusBar1.Panels[1].Text := IntToStr(dmcon.adsWOReleaseList.RecordCount);
end;

procedure TfrmWO_Release.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  dmcon.adsWOReleaseList.Close;
end;

function TfrmWO_Release.Check_Before_Release(rKey60: integer): boolean;
var
  sqlstr:string;
begin
  sqlstr:=' select D492.cut_no,D492.TStatus,D06.WIPMAT_STATUS,D06.PROD_STATUS,D25.ONHOLD_RELEASE_FLAG FROM Data0006 D06 '+
          ' INNER JOIN DATA0492 D492 ON D492.CUT_NO=D06.CUT_NO '+
          ' INNER JOIN DATA0025 D25 ON D06.BOM_PTR=D25.RKEY '+
          ' Where D06.rKey='+IntToStr(rKey60);
  MyDataClass.OpenQuery(dmcon.tmpQry,sqlstr);
  if dmcon.tmpQry.IsEmpty then
  begin
    result := false;
    ShowMsg('��ǰ��ҵ��û���ҵ�,�����Ѿ�����״̬���,����!',1);
  end
//  else if not IsAuth(dmcon.tmpQry.FieldByName('cut_no').AsString) then
    else if dmcon.tmpQry.FieldByName('TStatus').AsInteger = 1 then
  begin
    result := false;
    ShowMsg('����ҵ�������ϵ�δ���,��������,����!',1);
  end else if  dmcon.tmpQry.FieldByName('WIPMAT_STATUS').AsInteger = 0 then
  begin
    result := false;
    ShowMsg('����ҵ�����ڲ�û�з���,��������,����!',1);
  end else if dmcon.tmpQry.FieldByName('PROD_STATUS').AsInteger <> 2 then
  begin
    result := false;
    ShowMsg('����ҵ�����Ǵ�����״̬,��������,����!',1);
  end else if dmcon.tmpQry.FieldByName('ONHOLD_RELEASE_FLAG').AsInteger = 1 then
  begin
    result := false;
    ShowMsg('�ò�Ʒ��ҵ���ѷ����ݻ�,��������,����!',1);
  end
  else
    result := true;
  dmcon.tmpQry.Close;
end;

procedure TfrmWO_Release.FormShow(Sender: TObject);
begin
  vColumn:=DBGridEh1.Columns[2];
  labelKey.Caption:=vColumn.Title.Caption;
end;

procedure TfrmWO_Release.DBGridEh1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (ssAlt in Shift)  and  (Key=86) then
  showmessage(Dmcon.adsWOReleaseList.CommandText);
end;

procedure TfrmWO_Release.FormCreate(Sender: TObject);
begin
  WindowState:=wsMaximized    ;
end;

function TfrmWO_Release.IsAuth(cut_no: string): Boolean;
var
  new_no:string;
  LQry:TADOQuery;
begin
  Result:= False;
  new_no:= Copy(cut_no,1,Pos('-',cut_no))+ '0';
  LQry:= TADOQuery.Create(nil);
  try
    LQry.Connection:= Dmcon.ADOConnection1;
    LQry.close;
    LQry.sql.Text:='SELECT TSTATUS FROM DATA0492 WHERE CUT_NO = ' + QuotedStr(new_no);
    LQry.Open;
    if not LQry.IsEmpty then
    begin
      if (LQry.FieldByName('TSTATUS').Value = 0)
            or (LQry.FieldByName('TSTATUS').Value = 2) then Result:= True;
    end;
  finally
    LQry.free;
  end;
end;

procedure TfrmWO_Release.btnexpClick(Sender: TObject);
begin
  if not Dmcon.cdsWOReleaseList.IsEmpty then
  begin
    if MessageDlg('��ȷ��Ҫ����������',mtInformation, [mbYes,mbNo],0)= mryes then
       Export_dbGridEH_to_Excel(DBGridEh1,'��ҵ��');
  end;
end;

end.
