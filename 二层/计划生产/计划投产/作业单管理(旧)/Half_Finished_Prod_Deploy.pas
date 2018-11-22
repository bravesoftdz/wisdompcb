unit Half_Finished_Prod_Deploy;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGridEh, ExtCtrls, ComCtrls, StdCtrls, Buttons,DB, ADODB,
  Menus,math;

type
  TfrmHalf_Finished_Prod_Deploy = class(TForm)
    DBGridEh1: TDBGridEh;
    Panel1: TPanel;
    Label1: TLabel;
    labelKey: TLabel;
    BitBtn1: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn2: TBitBtn;
    edtKey: TEdit;
    dtpStartDate: TDateTimePicker;
    dtpEndDate: TDateTimePicker;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    Panel2: TPanel;
    DBGridEh2: TDBGridEh;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    DBGridEh3: TDBGridEh;
    Panel3: TPanel;
    Label2: TLabel;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    BitBtn4: TBitBtn;
    StatusBar1: TStatusBar;
    SpeedButton7: TSpeedButton;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    Label3: TLabel;
    procedure DBGridEh1TitleClick(Column: TColumnEh);
    procedure SpeedButton6Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure edtKeyChange(Sender: TObject);
    procedure edtKeyKeyPress(Sender: TObject; var Key: Char);
    procedure dtpStartDateChange(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure DBGridEh1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    vColumn:TColumnEh;
    StartDate,EndDate:TDatetime;
    function UpdateWOStatus(WORkey:integer;iStatus:byte):boolean;//������ҵ����״̬,Ϊ�ر�
    function ChangeWOQty(WoRkey:integer):boolean;                //������ҵ������
    function CloseWO(WOrKey:integer):boolean;                     //�ر���ҵ��
    procedure OpenWOList(rKey:integer);                           //������ҵ���б�
    function CheckSubProdQty:boolean;                            //�����Ӳ�Ʒ���ѷ��������Ƿ���������Ʒ��Ҫ
    procedure DoSearch(subSql:string);
    procedure CancelDeploy(Isall:boolean);
  public
    FisCancel:boolean;
    { Public declarations }
    procedure InitForm(AType: Integer);
  end;

var
  frmHalf_Finished_Prod_Deploy: TfrmHalf_Finished_Prod_Deploy;

implementation
uses dm,DeployWO,common,Dlg_Chng_Qty,MyClass,QuerySet;
{$R *.dfm}

procedure TfrmHalf_Finished_Prod_Deploy.DBGridEh1TitleClick(Column: TColumnEh);
begin
  vColumn.Title.Color:=clBtnFace;
  vColumn := Column;
  vColumn.Title.Color:=clred;
  labelKey.Caption := Column.Title.Caption;
  if (Column.Grid.DataSource=nil) or (Column.Grid.DataSource.DataSet=nil) or (not Column.Grid.DataSource.DataSet.Active) then
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
  end;

  if dmcon.adsProdList.IsEmpty then abort;
  edtKey.Visible:= not(Column.Field.DataType  in [ftDate, ftDateTime]);
  labelKey.Visible:= edtKey.Visible;
  Dmcon.adsProdListAfterScroll(Dmcon.adsProdList);
end;

procedure TfrmHalf_Finished_Prod_Deploy.InitForm(AType: Integer);
var s:string;
begin
  Dmcon.FType := AType;
  vColumn:=DBGridEh1.Columns[1];
  labelKey.Caption:=vColumn.Title.Caption;
  dtpStartDate.Date:= date-3;
  dtpEndDate.Date := date;
  s:='SELECT barcode_flag,D06.RKEY,D06.WORK_ORDER_NUMBER,D06.BOM_PTR,D06.QUAN_SCH,'+
     'D06.WIPMAT_STATUS,D06.ENT_DATETIME,D06.SCH_COMPL_DATE,D06.PARTS_PER_PANEL,'+
     'D06.cut_no,D06.quan_rej,D06.quan_prod,D06.panels,D492.SO_NO,D492.mrb_ptr,'+
     'D10.CUST_CODE, D25.CUSTOMER_PTR, D25.MANU_PART_NUMBER,D25.MANU_PART_DESC,D492.TType ,D08.PROD_CODE,D06.panel_A_B '+
     'FROM dbo.Data0025 D25 INNER JOIN '+
     'dbo.Data0010 D10 ON D25.CUSTOMER_PTR = D10.RKEY '+
     'INNER JOIN Data0006 D06 on D06.BOM_PTR=D25.RKEY '+
     'INNER JOIN DATA0492 D492 ON D492.CUT_NO=D06.CUT_NO '+
     'INNER JOIN DATA0008 D08 ON D08.RKEY=D25.PROD_CODE_PTR ';
  case AType of
    0:Dmcon.adsProdList.CommandText:=s+'Where  (D06.WIPMAT_STATUS = 0) and (D06.PROD_STATUS=2) ORDER BY ENT_DATETIME DESC';
    1:Dmcon.adsProdList.CommandText:=s+'Where  (D06.WIPMAT_STATUS = 0) and (D06.PROD_STATUS=3) ORDER BY ENT_DATETIME DESC';
    2:
    begin
      FisCancel := True;
//      dmcon.adsProdList.CommandText :=s+'WHERE (D06.PROD_STATUS=2) and D06.rkey in '+
//                                  '(select data0006.rkey from data0006 inner join data0025 on data0006.bom_ptr=data0025.parent_ptr '+
//                                  'inner join data0488 on data0488.WO_Ptr=data0006.rKey and data0488.bom_ptr=data0025.rkey) '+
//                                  'ORDER BY D06.WORK_ORDER_NUMBER';
      Dmcon.adsProdList.CommandText:=s+'Where  D06.RKey IN ' + '(SELECT D06_1.RKey AS Parent06RK' +
      ' FROM Data0489 D489 ' +
      ' INNER JOIN Data0006 D06_1 ON D06_1.RKey = D489.WO_PTR ' +
      ' INNER JOIN Data0006 D06_2 ON D06_2.RKey = D489.SOURCE_PTR ' +
      ' LEFT JOIN Data0056 D56 ON D06_1.RKey = D56.WO_PTR ' +
      ' INNER JOIN Data0025 D25 ON D06_2.BOM_PTR = D25.RKey ' +
      ' WHERE D56.STEP = D25.BOM_STEP OR D25.BOM_STEP = 1 )' +
      ' ORDER BY ENT_DATETIME DESC';
    end;
  end;

  ShowModal;
end;

procedure TfrmHalf_Finished_Prod_Deploy.SpeedButton6Click(Sender: TObject);
var
  i:integer;
begin
  if (strtoint(vprev)=1) or (strtoint(vprev)=3) then
  begin
    ShowMsg('�Բ���!��û�иó���Ŀ�дȨ��',1);
    exit;
  end;
  if dmcon.adsProdList.IsEmpty then exit;
  if Dmcon.adsSubProds.fieldByname('Qty_Needed').value <=0 then
  begin
    ShowMsg('���ڲ��Ʒ�����Ѿ��������,����Ҫ�ٷ���!',1);
    exit;
  end;

  i:=Dmcon.adsSubProds.fieldByname('rKey').value;
  with TfrmDeployWO.Create(Application) do
  try
    if Enter(Dmcon.adsSubProds.fieldByname('rKey').value, Dmcon.adsSubProds.fieldByname('Qty_Needed').value,Dmcon.adsProdList.fieldbyname('panel_A_B').AsInteger) then
    begin
      dmcon.adsSubProds.Close;
      dmcon.adsSubProds.Parameters[0].Value := Dmcon.adsProdList.fieldByName('rKey').Value;
      dmcon.adsSubProds.Open;
      if CheckSubProdQty then    //����ȫ������parent,��parent 0006.wipmat_status=1
        if not UpdateWOStatus(dmcon.adsProdList.fieldbyName('rKey').AsInteger,1) then
        begin
          ShowMsg('�ر���ҵ��ʧ��!����',1);
          abort;
        end;
    end;
  finally
    free;
  end;


  BitBtn3Click(sender);
  Dmcon.adsSubProds.Locate('rKey',i,[]);
end;

procedure TfrmHalf_Finished_Prod_Deploy.SpeedButton2Click(Sender: TObject);
begin
  if (strtoint(vprev)=1) or (strtoint(vprev)=3) then
  begin
    ShowMsg('�Բ���!��û�иó���Ŀ�дȨ��',1);
    exit;
  end;
  if dmcon.adsProdList.IsEmpty then exit;
  ChangeWOQty(dmcon.adsProdList.fieldbyName('rKey').Asinteger);
end;

function TfrmHalf_Finished_Prod_Deploy.ChangeWOQty(
  WoRkey: integer): boolean;
var
  i,PNL,Qty_Diff:integer;
  Sqlstr:string;
begin
 // �����ڲ�,��ȡ�ѷ�������Ϊ��С���ڲ�,�Դ�����Ϊ׼��Ϊ����Ʒ�ĸ�������
 //ע��������ת��:�ѷ������� div BOM����, PNL��,��Ҫ��PCS��ת��
  result := true;
  with dmcon do begin
    adsSubProds.First;
    i:= adsSubProds.FieldByName('quan_issued').Value div adsSubProds.FieldByName('qty_bom').Value;
    adsSubProds.next;
    while not adsSubProds.Eof do begin
      if i > (adsSubProds.FieldByName('quan_issued').Value div adsSubProds.FieldByName('qty_bom').Value) then
        i:=adsSubProds.FieldByName('quan_issued').Value div adsSubProds.FieldByName('qty_bom').Value;
      adsSubProds.next;
    end;
    PNL:= ceil(i/adsProdList.fieldbyName('PARTS_PER_PANEL').Asinteger);
    Sqlstr:='';
    with TfrmDlg_Chng_Qty.Create(Application) do
    try
      PNLQty := PNL;
      edtPcs.Text :=IntToStr(i);
      edtPNL.Text :=IntToStr(PNL);
      label4.caption := Dmcon.adsProdList.fieldByName('PARTS_PER_PANEL').AsString;

      if showmodal = mrok then
      begin
        Qty_Diff:= adsProdList.fieldByName('QUAN_SCH').asInteger - i;
        Sqlstr:=' update data0006 set QUAN_SCH= '+IntToStr(i)+',PANELS='+edtPNL.Text+' where rKey='+adsProdList.FieldByName('rKey').AsString;
        if Qty_Diff >0 then
          sqlstr:=sqlstr+' Update data0492 set Issued_Qty=Issued_Qty-'+IntToStr(Qty_Diff)+',waitfor_release=waitfor_release-'+IntToStr(Qty_Diff)+' where CUT_NO='+QuotedStr(adsProdList.FieldByName('CUT_NO').AsString);


        sqlstr:=sqlstr+' insert into data0117(SOURCE_TYPE,SOURCE_PTR,EMPL_PTR,TDATE,ACTION,remark) '+
                'values(2,'+IntToStr(WorKey)+','+user_ptr+',getdate()'+',8,''�ӹر���ҵ���д���:��ҵ�������޸�ԭPNL:'+adsProdList.fieldbyname('panels').AsString+'��PNL:'+edtPNL.Text+''')';
      end;
    finally
      free;
    end;
    if sqlstr<>'' then
    begin
      if not MyDataclass.ExecSql(sqlstr) then
      begin
        result := false;
        ShowMsg('��������ʧ��',1);
      end
      else
        OpenWOList(WorKey);
    end
    else
      result := false;
  end;
end;

function TfrmHalf_Finished_Prod_Deploy.CloseWO(WOrKey: integer): boolean;
begin
//1.�ж������ڲ��Ʒ�Ĳ����Ƿ��Ѿ���������Ʒ��Ҫ��
//2.�������,����Ʒ״̬�ı�Ϊ���ѷ��䡱wipmat_status=1
//3.���������,��ʾ�޸�����Ʒ������,�����������,��ô�͸�������Ʒ״̬,
  result := true;
  if ChangeWOQty(WorKey) then
  begin
    if UpdateWOStatus(WorKey,1) then
      OpenWOList(WorKey)
    else
    begin
      ShowMsg('������ҵ��״̬ʧ��!',1);
      result := false;
    end;
  end
  else
    result := false;
end;

procedure TfrmHalf_Finished_Prod_Deploy.OpenWOList(rKey: integer);
begin
  with dmcon do
  begin
    adsProdList.Close;
    try
      screen.Cursor:=crSQLWait;
      adsProdList.Open;
      StatusBar1.Panels[1].Text := IntToStr(dmcon.adsProdList.RecordCount);
      if rKey > 0 then  adsProdList.Locate('rkey',rKey,[]);
    finally
      screen.Cursor:=crDefault;
    end;
  end;
end;

procedure TfrmHalf_Finished_Prod_Deploy.SpeedButton4Click(Sender: TObject);
begin
  if (strtoint(vprev)=1) or (strtoint(vprev)=3) then
  begin
    ShowMsg('�Բ���!��û�иó���Ŀ�дȨ��',1);
    exit;
  end;
  if not Msg_Dlg_Ask('ȷ���򿪵�ǰ��ҵ����?','��ʾ',1) then exit;
  if UpdateWOStatus(dmcon.adsProdList.fieldbyName('rKey').AsInteger,0) then
    OpenWOList(dmcon.adsProdList.fieldbyName('rKey').AsInteger)
  else
    ShowMsg('����ҵ��ʧ��!',1);
end;

procedure TfrmHalf_Finished_Prod_Deploy.SpeedButton3Click(Sender: TObject);
begin
  if dmcon.adsProdList.IsEmpty then exit;
  if (strtoint(vprev)=1) or (strtoint(vprev)=3) then
  begin
    ShowMsg('�Բ���!��û�иó���Ŀ�дȨ��',1);
    exit;
  end;
  if MessageBox(self.Handle,pchar('����!�˲���������,���������䲢�ر���ҵ��,����'+#13+'����ʣ���������,���ڷ���ǰ��������ҵ��!'),pchar('��ʾ'),MB_OKCANCEL+MB_ICONWARNING+MB_DEFBUTTON2)=IDOK	then
    CloseWO(dmcon.adsProdList.fieldbyName('rKey').AsInteger);
end;

procedure TfrmHalf_Finished_Prod_Deploy.BitBtn1Click(Sender: TObject);
begin
  close;
end;

procedure TfrmHalf_Finished_Prod_Deploy.BitBtn3Click(Sender: TObject);
var
  rKey:integer;
begin
  if dmcon.adsProdList.Active then
    rKey:=dmcon.adsProdList.fieldbyName('rKey').AsInteger
  else
    rKey:=0;
  OpenWOList(rKey);
end;

procedure TfrmHalf_Finished_Prod_Deploy.SpeedButton1Click(Sender: TObject);
begin
  if (strtoint(vprev)=1) or (strtoint(vprev)=3) then
  begin
    ShowMsg('�Բ���!��û�иó���Ŀ�дȨ��',1);
    exit;
  end;
//ע��:�Զ�����ֻ�ܷ���ͬһ�����۶����µ���ҵ��
//1.�����ڲ�,�ж��ڲ��ѷ��������Ƿ��㹻
//2.�������,��ô�Զ������ڲ������(����һ������,ר�Ŵ����ڲ��Զ�����),
//3.����ڲ���䲻�ɹ�,��ô��ֹ����,�������
//4.��������ڲ���������㹻,��ô���йرմ���(����һ������,ר�Ŵ����Ʒ�Ĺر�)
  with dmcon do
  begin
    adsProdList.First;
    while not adsProdList.Eof do
    begin
      if adsProdList.fieldByName('ttype').AsInteger <> 4  then
      try
        if not ADOConnection1.InTransaction then  ADOConnection1.BeginTrans;
        if not AutoDeployWO(adsAuto_WO_List) then  //����ڲ���������,�Զ������ڲ������
        begin
           if ADOConnection1.InTransaction then ADOConnection1.RollbackTrans;
           if not Msg_Dlg_Ask('�Զ������ڲ�����ʧ��,��ֹ�������Ǽ�����һ����ҵ������?','��ʾ',1) then
              exit
           else
           begin
             adsProdList.Next;
             continue;
           end;
        end;
        //��������ҵ��״̬Ϊ�ر�
        dmcon.adsSubProds.Close;
        dmcon.adsSubProds.Parameters[0].Value := dmcon.adsProdList.fieldbyName('rKey').AsInteger;
        dmcon.adsSubProds.Open;

        if not UpdateWOStatus(dmcon.adsProdList.fieldbyName('rKey').AsInteger,1) then
        begin
          ShowMsg('�ر���ҵ��ʧ��!����',1);
          abort;
        end;
        ADOConnection1.CommitTrans;
      except
        ADOConnection1.RollbackTrans;
      end;
      adsProdList.Next;
    end;
  end;
end;


function TfrmHalf_Finished_Prod_Deploy.CheckSubProdQty: boolean;
begin
  result := true;
  with dmcon do
  begin
    adsSubProds.First;
    while not adsSubProds.Eof do
    begin
      if adsSubProds.FieldByName('quan_issued').Asinteger < adsSubProds.FieldByName('Qty_Total_Req').Asinteger then
      begin
        result := false;
        break;
      end;
      adsSubProds.next;
    end;
  end;
end;

function TfrmHalf_Finished_Prod_Deploy.UpdateWOStatus(
  WORkey: integer;iStatus:byte): boolean;
var
  sqlstr:string;
begin
  sqlstr:='update data0006 set wipmat_status='+IntToStr(iStatus)+' where rkey='+IntToStr(WorKey);
  result:= MyDataClass.ExecSql(sqlstr);
end;

procedure TfrmHalf_Finished_Prod_Deploy.SpeedButton5Click(Sender: TObject);
begin
  if (strtoint(vprev)=1) or (strtoint(vprev)=3) then
  begin
    ShowMsg('�Բ���!��û�иó���Ŀ�дȨ��',1);
    exit;
  end;
  if dmcon.adsProdList.IsEmpty then exit;
  if dmcon.adsProdList.fieldByName('ttype').AsInteger = 4  then
  begin
    ShowMsg('�����Ͷ������ҵ������Ҫ�ֹ����䣡',1);
    exit;
  end;

  try
    dmcon.ADOConnection1.BeginTrans;  //�Զ������ڲ� All������
    if dmcon.AutoDeployWO(dmcon.adsAuto_WO_List) and UpdateWOStatus(dmcon.adsProdList.fieldbyName('rKey').AsInteger,1) then
    begin
      dmcon.ADOConnection1.CommitTrans;
      SHowMsg('�Զ������ڲ������ɹ�','��ʾ',1);
      dmcon.adsSubProds.Close;
      dmcon.adsSubProds.Parameters[0].Value := dmcon.adsProdList.fieldbyName('rKey').AsInteger;
      dmcon.adsSubProds.Open;
    end else begin
      dmcon.ADOConnection1.RollbackTrans;
      ShowMsg('�Զ������ڲ�����ʧ��','��ʾ',1);
    end;
    BitBtn3Click(sender);
  except
    dmcon.ADOConnection1.RollbackTrans;
  end;
end;

procedure TfrmHalf_Finished_Prod_Deploy.edtKeyChange(Sender: TObject);
var tmpstr,sFilter:string;
begin
  if not dmcon.adsProdList.Active then abort;
  tmpstr:= trim(edtKey.Text);
  if TmpStr='' then
    dmcon.adsProdList.Filtered:= false
  else
  begin
    if (vColumn.Field.DataType in [ftString,ftWideString,ftMemo]) then
    begin
      sFilter := '*'+uppercase(TmpStr)+'*';
      dmcon.adsProdList.Filter := vColumn.Field.FieldName+' Like '+ QuotedStr(sFilter);
      dmcon.adsProdList.Filtered:= true;
    end
    else if vColumn.Field.DataType in [ftSmallint, ftInteger, ftWord, ftFloat, ftCurrency, ftBCD,ftLargeint] then
    begin
      if TmpStr='-' then exit;
      sFilter := vColumn.Field.FieldName+'>='+TmpStr;
      dmcon.adsProdList.Filter := sFilter;
      dmcon.adsProdList.Filtered:= true;
    end
    else if vColumn.Field.DataType in [ftDate, ftDateTime] then
    begin
      if not IsDatetime(TmpStr) then exit;
      sFilter := '>='+QuotedStr(TmpStr);
      dmcon.adsProdList.Filter := vColumn.Field.FieldName + sFilter;
      dmcon.adsProdList.Filtered:= true;
    end;
  end;
end;

procedure TfrmHalf_Finished_Prod_Deploy.edtKeyKeyPress(Sender: TObject;
  var Key: Char);
begin
  if vColumn.Field = nil then Exit;
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

procedure TfrmHalf_Finished_Prod_Deploy.dtpStartDateChange(
  Sender: TObject);
var  tmpstr1,Tmpstr2,sFilter:string;
begin
  if not dmcon.adsProdList.Active then abort;
  TmpStr1:= QuotedStr(DateToStr(dtpStartDate.Date));
  TmpStr2:= QuotedStr(DateToStr(dtpEndDate.Date+1));
  if vColumn.Field.DataType in [ftDate, ftDateTime] then
  begin
    sFilter := vColumn.Field.FieldName+'>='+TmpStr1+ ' AND ' +vColumn.Field.FieldName+'<'+TmpStr2;
    dmcon.adsProdList.Filter := sFilter;
    dmcon.adsProdList.Filtered:= true;
  end;
end;

procedure TfrmHalf_Finished_Prod_Deploy.BitBtn4Click(Sender: TObject);
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

procedure TfrmHalf_Finished_Prod_Deploy.DoSearch(subSql: string);
var
  sqlstr:widestring;
  i:integer;
begin
  if subsql='' then exit;
  sqlstr:=uppercase(dmcon.adsProdList.CommandText);
  i:=Pos('WHERE',sqlstr);
  if i = 0 then
  begin
    ShowMsg('SQL������,����ϵϵͳ����Ա',1);
    abort;
  end;
  Sqlstr:=copy(sqlstr,1,i-1);
  dmcon.adsProdList.Close;
  if not FisCancel then
    dmcon.adsProdList.CommandText := sqlstr+' WHERE (D06.WIPMAT_STATUS = 0) and (D06.PROD_STATUS<9) and (D25.RKEY IN '+
                                   ' (SELECT parent_ptr FROM data0025  WHERE parent_ptr > 0 )) '+subsql +' ORDER BY D06.WORK_ORDER_NUMBER'
  else
    dmcon.adsProdList.CommandText := sqlstr+' WHERE (D06.PROD_STATUS=2) and D06.rkey in '+
                                    '(select data0006.rkey from data0006 inner join data0025 on data0006.bom_ptr=data0025.parent_ptr '+
                                    'inner join data0488 on data0488.WO_Ptr=data0006.rKey and data0488.bom_ptr=data0025.rkey) '+
                                    subsql +' ORDER BY D06.WORK_ORDER_NUMBER';
  try
    screen.Cursor:=crSQLWait;
    dmcon.adsProdList.open;
  finally
    screen.Cursor:=crDefault;
  end;
  StatusBar1.Panels[1].Text := IntToStr(dmcon.adsProdList.RecordCount);
end;

procedure TfrmHalf_Finished_Prod_Deploy.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  dmcon.adsProdList.Filter := '';
  dmcon.adsProdList.Filtered := false;
  dmcon.adsProdList.Close;
  dmcon.adsSubProds.Close;
  dmcon.adsTransRec.close;
end;

procedure TfrmHalf_Finished_Prod_Deploy.PopupMenu1Popup(Sender: TObject);
begin
  if not DBGridEh3.DataSource.DataSet.Active or DBGridEh3.DataSource.DataSet.IsEmpty then
  abort;
end;

procedure TfrmHalf_Finished_Prod_Deploy.SpeedButton7Click(Sender: TObject);
begin
  CancelDeploy(true);
end;

procedure TfrmHalf_Finished_Prod_Deploy.N1Click(Sender: TObject);
begin
 CancelDeploy(false);
end;

procedure TfrmHalf_Finished_Prod_Deploy.CancelDeploy(Isall: boolean);
  function CanCancel: Boolean;
  var
    LQry: TADOQuery;
    LS: TStringList;
    LChildStep, LParentNowStep: Integer;
  begin
    Result := False;
    LQry := TADOQuery.Create(Self);
    LS := TStringList.Create;
    try
      LS.Add('SELECT BOM_STEP FROM Data0025 WHERE RKey = ');
      LS.Add( Dmcon.adsSubProds.FieldByName('rkey').AsString);
      if not Dmcon.SQLOpen(LQry,LS) then Exit;
      if LQry.IsEmpty then Exit;
      LChildStep := LQry.FieldByName('BOM_STEP').AsInteger;
      ls.Clear;
      LS.Add('SELECT STEP FROM Data0056 WHERE WO_PTR = ');
      LS.Add( Dmcon.adsProdList.FieldByName('rkey').AsString);
      if not Dmcon.SQLOpen(LQry,LS) then Exit;
      if LQry.IsEmpty then
        LParentNowStep := 1
      else
        LParentNowStep := LQry.FieldByName('STEP').AsInteger;
      if LParentNowStep <> LChildStep then
      begin
        ShowMessage('�Ѿ�����������ȡ������');
        Exit;
      end else
        Result := true;
    finally
      LQry.Close;
      LQry.Free;
      LS.Free;
    end;
  end;
var WO_List,Qty_List,rkey489_List:string;
    iRet:integer;
begin
  if Dmcon.adsTransRec.IsEmpty then exit;
  if (strtoint(vprev)=1) or (strtoint(vprev)=3) then
  begin
    ShowMsg('�Բ���!��û�иó���Ŀ�дȨ��',1);
    exit;
  end;
  if not CanCancel then Exit;
  WO_List:='';
  Qty_List:='';
  rkey489_List:='';

  if Isall then
  begin
    with Dmcon.adsTransRec do
    begin
      First;
      while not Eof do
      begin
        if Qty_List= '' then
          Qty_List:=FieldByName('Qty').AsString
        else
          Qty_List:=Qty_List+','+FieldByName('Qty').AsString;

        if WO_List = '' then
          WO_List:=FieldByName('Source_ptr').AsString
        else
          WO_List:=WO_List+','+FieldByName('Source_ptr').AsString;

        if rkey489_List = '' then
          rkey489_List:=FieldByName('rkey').AsString
        else
          rkey489_List:=rkey489_List+','+FieldByName('rkey').AsString;
        Next;
      end;
     end;
  end else begin
    Dmcon.tmpQry.Close;
    Dmcon.tmpQry.SQL.Text:='select rkey from data0489 WHERE rkey='+Dmcon.adsTransRec.FieldByName('rkey').AsString;
    Dmcon.tmpQry.Open;
    if Dmcon.tmpQry.IsEmpty then
    begin
      showmessage('�˷�����ҵ���Ѳ�����,������ȡ��...');
      DBGridEh3.DataSource.DataSet.Close;
      DBGridEh3.DataSource.DataSet.Open;
      exit;
    end;
    Qty_List:=Dmcon.adsTransRec.FieldByName('Qty').AsString;
    WO_List:=Dmcon.adsTransRec.FieldByName('Source_ptr').AsString;
    rkey489_List:=Dmcon.adsTransRec.FieldByName('rkey').AsString;
  end;


  Dmcon.CancelDeploy.Parameters.ParamByName('@main_WO_NO').Value:=dmcon.adsProdList.fieldByName('rKey').AsInteger;
  Dmcon.CancelDeploy.Parameters.ParamByName('@Sub_WO_List').Value:=WO_List;
  Dmcon.CancelDeploy.Parameters.ParamByName('@Qty_List').Value:=Qty_List;
  Dmcon.CancelDeploy.Parameters.ParamByName('@User_ptr').Value:=strtoint(user_ptr);
  Dmcon.CancelDeploy.Parameters.ParamByName('@IsCancel').Value:=1;
  Dmcon.CancelDeploy.Parameters.ParamByName('@rkey489_List').Value:=rkey489_List;

  Dmcon.CancelDeploy.ExecProc;
  iRet:=Dmcon.CancelDeploy.Parameters.ParamByName('@RETURN_VALUE').Value;
  if iRet=0 then
    showmessage('ȡ������ɹ�!')
  else if iRet=999 then
    showmessage('ȡ������ʧ��!')
  else
    showmessage('ĸ��������״̬δ���ڴ�����,����ȡ������!');

  DBGridEh2.DataSource.DataSet.Close;
  DBGridEh2.DataSource.DataSet.Open;
end;


procedure TfrmHalf_Finished_Prod_Deploy.DBGridEh1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (ssAlt in Shift)  and  (Key=86) then
  showmessage(Dmcon.adsProdList.CommandText);
end;

end.
