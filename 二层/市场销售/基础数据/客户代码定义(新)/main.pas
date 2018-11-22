unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, Grids, DBGrids, ComCtrls, Menus,
  DBGridEh,DB,ADODB, ppDB, ppBands, ppStrtch, ppMemo, ppCtrls, ppVar,
  ppPrnabl, ppClass, ppCache, ppProd, ppReport, ppComm, ppRelatv, ppDBPipe;

type
  Tmainform = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    Edit1: TEdit;
    PM1: TPopupMenu;
    new: TMenuItem;
    edit: TMenuItem;
    copy: TMenuItem;
    delete: TMenuItem;
    PM2: TPopupMenu;
    Eh1: TDBGridEh;
    check: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    procedure Eh1TitleClick(Column: TColumnEh);
    procedure Edit1Change(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure deleteClick(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure newClick(Sender: TObject);
    procedure editClick(Sender: TObject);
    procedure copyClick(Sender: TObject);
    procedure checkClick(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure Eh1DblClick(Sender: TObject);
    procedure Eh1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure N3Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure PM1Popup(Sender: TObject);
  private
    { Private declarations }
    precolumn:Tcolumneh;
    sql_text:string;
    procedure item_click(sender:Tobject);
    procedure ready_new;
    procedure copydata;
    procedure checkstatus;
  public
    { Public declarations }
  end;

var
  mainform: Tmainform;

implementation
uses damo,common,condition,detail,location, note_information,Credit;

{$R *.dfm}

procedure Tmainform.FormCreate(Sender: TObject);
var i:integer;
    item:Tmenuitem;
begin
 if not app_init_2(dm.ADOConnection1) then
  begin
    showmsg('��������ʧ�ܣ�����ϵͳ����Ա��ϵ��','��ʾ',1);
    application.Terminate;
    exit;
  end;
  self.Caption:=application.Title;
   {
  vprev:='4';
  rkey73:='1502';
  user_ptr:='3';
   }
  dm.ads10.Close;
  if (strtoint(vprev)=1) or (strtoint(vprev)=3) then //Ȩ�޿��� (Andy 08.08.27)
    dm.ads10.Parameters.ParamByName('rkey73').Value:=rkey73
  else //���Ȩ��Ϊ��д(2 or 4)������Բ鿴���пͻ���Ϣ
    dm.ads10.CommandText:=(system.copy(dm.ads10.CommandText,1,pos('FROM',dm.ads10.CommandText)-1))
       +' FROM DATA0010 D10 INNER JOIN DATA0005 D05 on D10.sales_rep_ptr=D05.rkey'
       +' INNER JOIN DATA0001 D01 on D10.currency_ptr=D01.rkey'
       +' LEFT JOIN DATA0250 D250 on D10.country_ptr=D250.country_rkey WHERE 1=1 ';
  dm.ads10.Open;
  sql_text:=dm.ads10.CommandText;  //��¼ads10Ĭ��sql���
  precolumn:=eh1.Columns[0]; //��precolumn����ʼֵ
  for i:=1 to eh1.columns.Count do
  begin //��̬�����������ֶβ˵���
    item:=Tmenuitem.Create(self);
    item.Caption:=eh1.columns[i-1].Title.caption;
    if eh1.Columns[i-1].Visible then
      item.Checked:=true;
    if (item.Caption='���ʽ') and
       (strtoint(vprev)<3) then
     item.Enabled:=false;
    if (item.Caption='�۸�˰') and
       (strtoint(vprev)<3) then
     item.Enabled:=false;
    if (item.Caption='δ������೬��(����)') and
       (strtoint(vprev)<3) then
     item.Enabled:=false;
    if (item.Caption='�������ʶ') and
       (strtoint(vprev)<3) then
     item.Enabled:=false;
    item.onClick:=item_click;
    self.PM2.Items.Add(item);
  end;
end;

procedure tmainform.item_click(sender:Tobject);
var i:byte;
begin
  (sender as Tmenuitem).Checked:=not ((sender as Tmenuitem).Checked);
  if (sender as Tmenuitem).Checked then
    for i:=0 to eh1.Columns.Count-1 do
       if (sender as Tmenuitem).Caption=eh1.Columns[i].Title.Caption then
        begin
         eh1.Columns[i].Visible:=true;
         break;
        end;
  if not (sender as Tmenuitem).Checked then
    for i:=0 to eh1.Columns.Count-1 do
      if (sender as Tmenuitem).Caption=eh1.Columns[i].Title.Caption then
      begin
        eh1.Columns[i].Visible:=false;
        break;
      end;
end;

procedure Tmainform.ready_new;
begin   //������¼�����ó�ʼ��Ϣ
  with dm do
  begin
    aq10.Open;
    aq10.Append;
    aq12.Close;
    aq12.Parameters[0].Value:=null;
    aq12.Open;
    aq10customer_type.Value:=1;  //״̬Ϊ����
    aq10country_ptr.Value:=3;    //����Ϊ�й�
    aq10currency_ptr.Value:=1;   //����Ϊ�����
    aq10cust_ent_date.Value:=getsystem_date(aqtmp,1);  //��������Ϊ����
    aq10edi_in_logging.Value:=0;     //�����ܿͻ�Ϊ��
    aq10credit_rating.Value:=3;     //��Ϣ�ȼ�Ϊ��
    aq10CREDIT_LIMIT.Value:=0;     //��Ϣ�޶�Ϊ0
    aq10cod_flag.Value:='N';      //��������
    aq10REG_TAX_FIXED_UNUSED.Value:='0';  //��Ʊ���ڼ��㷽��
    aq10discount_days.Value:=0;   //�������
    aq10net_pay.Value:=30;        //����������
    aq10discount_pct.Value:=0;    //��۱���
    aq10days_early_schedule.Value:=0;  //�ƻ���ǰ����Ϊ1��
    aq10edi_flag_for_invoice.Value:=0; //��������۸�ʱ�Ƿ�˰
    aq10edi_flag_for_soack.Value:=0;   //�Ƿ�ת��
    aq10DO_SMOOTHING.Value:=0;         //�Ƿ����   
    aq10smoothing_threshold.Value:=0;  //Ա������
    aq10quote_factor.Value:=0;         //���۳�������
    aq10APPLY_IN_TRANSIT.Value:=0;    //װ�䵥��ʽ
    aq10CONSUME_FORECASTS.Value:=0;   //���Ա�֤���ڽ���
    aq10COFC_FILENAME.Value:='N';     //Ӧ���ʿ����֪ͨ
    aq10QUOTE_FACTOR1.Value:=0;      //�����µ�0����1����
  end;
end;

procedure Tmainform.copydata;
var  v_copy:array[2..103] of variant;    //Ӧ��д�ɶ�̬���飬��̬��ֵ�����±�
     i:word;
begin
  dm.aq10.Close;
  dm.aq10.Parameters[0].Value:=dm.ads10rkey.Value;
  dm.aq10.Open;
  for i:=2 to 103 do //���¸���data0010�ͻ���Ϣ��
    v_copy[i]:=dm.aq10.Fields[i].Value;

  dm.aq10.Append;
  for i:=2 to 103 do
    dm.aq10.FieldValues[dm.aq10.Fields[i].FieldName]:=v_copy[i];
   dm.aq10credit_rating.Value:=3;     //��Ϣ�ȼ�Ϊ��
   dm.aq10CREDIT_LIMIT.Value:=0;     //��Ϣ�޶�Ϊ0

  with dm.aqtmp do  //���¸���װ����Ϣ
  begin
    close;
    sql.Text:='select RKEY,CUSTOMER_PTR,LOCATION,SHIP_TO_ADDRESS_1,SHIP_TO_ADDRESS_2,'+
      'SHIP_TO_ADDRESS_3,STATE,ZIP,SHIP_TO_CONTACT,SHIP_TO_PHONE,SHIP_TO_FAX,SREP_PTR_1,'+
      'SREP_PTR_2,SREP_PTR_3,SREP_PTR_4,SREP_PTR_5,SREP_1_COMM,SREP_2_COMM,SREP_3_COMM,'+
      'SREP_4_COMM,SREP_5_COMM,SREP_1_ALLOC,SREP_2_ALLOC,SREP_3_ALLOC,SREP_4_ALLOC,'+
      'SREP_5_ALLOC,SHIP_CTAX_PTR,SHIP_SHIPPING_METHOD,SHIP_LEAD_TIME,SHIP_REG_TAX_ID,'+
      'STATE_SHIP_TAX_FLAG,STATE_PROD_TAX_FLAG,STATE_TOOL_TAX_FLAG,LANGUAGE_FLAG,'+
      'COUNTRY_PTR,LOCNAME_FOR_FORM,SHP_ADDR1_FOR_FORM,SHP_ADDR2_FOR_FORM,'+
      'SHP_ADDR3_FOR_FORM,SHP_ANALYSIS_CODE1,SHP_ANALYSIS_CODE2,SHP_ANALYSIS_CODE3,'+
      'EMAIL_FOR_CONTACT,S4_BARCODE_LABLE,S3_BARCODE_LABLE,PACKGE_BARCODE_LABLE,'+
      'MISC_BARCODE_LABLE,COFC_FORMAT_FILENAME,EXPIRED_DATE '+
      'from Data0012 where customer_ptr=:cust_ptr';
    parameters[0].Value:=dm.ads10rkey.Value;
    open;
  end;

  with dm.aq12 do
  begin
    close;
    parameters[0].Value:=null;
    open;
    while not dm.aqtmp.Eof do
    begin
      append;
      for i := 2 to 48 do //��rkey,customer_ptr������
        fieldvalues[fields[i].FieldName]:=dm.aqtmp.FieldValues[dm.aqtmp.fields[i].FieldName];
      post;
      dm.aqtmp.Next;
    end;
  end;   //װ�˵ص㸴�����
end;

procedure Tmainform.checkstatus;
begin
  dm.aq10.Close;
  dm.aq10.Parameters[0].Value:=dm.ads10rkey.Value;
  dm.aq10.LockType:=ltreadonly;  //ֻ��ģʽ
  dm.aq10.Open;
  dm.aq12.Close;
  dm.aq12.Parameters[0].Value:=dm.ads10rkey.Value;
  dm.aq12.LockType:=ltreadonly; //ֻ��ģʽ
  dm.aq12.Open;
  cust_detail.BitBtn1.enabled:=false;
  cust_detail.BitBtn4.enabled:=false;
  cust_detail.BitBtn5.enabled:=false;
  cust_detail.BitBtn6.enabled:=false;
  cust_detail.BitBtn7.enabled:=false;
  cust_detail.MaskEdit1.enabled:=false;
  cust_detail.ComboBox1.enabled:=false;
  cust_detail.Edit1.enabled:=false;
  cust_detail.Edit2.enabled:=false;
  cust_detail.Edit3.enabled:=false;
  cust_detail.Edit4.enabled:=false;
  cust_detail.memo1.enabled:=false;
  cust_detail.memo2.enabled:=false;
  cust_detail.memo3.enabled:=false;
  cust_detail.memo4.enabled:=false;
  cust_detail.memo5.enabled:=false;
  cust_detail.memo6.enabled:=false;
  cust_detail.mmo1.enabled:=false;
  cust_detail.PM1.Items.Delete(2); //ɾ��"���"��"ɾ��"�˵�
  cust_detail.PM1.Items.Delete(0);
end;

procedure Tmainform.Eh1TitleClick(Column: TColumnEh);
begin
    if column.Title.SortMarker=smupeh then
    begin
      column.Title.SortMarker:=smdowneh;
      dm.ads10.IndexFieldNames:=column.FieldName+' DESC';
    end
    else
    begin
      column.Title.SortMarker:=smupeh;
      dm.ads10.IndexFieldNames:=column.FieldName;
    end;

  if (column.ReadOnly) and (precolumn.FieldName<>column.FieldName) then
  begin //�Ȱѷ��ַ��͵�column��readonly������Ϊfalse,���ַ��Ͳ�����edit����
    label1.Caption:='������'+column.Title.Caption;
    precolumn.Title.Color:=clbtnface;
    column.Title.Color:=clred;
    precolumn:=column;
    edit1.Text:='';
  end;
  edit1.SetFocus;
end;

procedure Tmainform.Edit1Change(Sender: TObject);
begin
  if trim(edit1.Text)<>'' then
    dm.ads10.Filter:=precolumn.FieldName+' like ''%'+trim(edit1.text)+'%'''
  else dm.ads10.Filter:='';
end;

procedure Tmainform.BitBtn1Click(Sender: TObject);
begin
  close;
  application.Terminate;
end;

procedure Tmainform.BitBtn2Click(Sender: TObject);
begin
  dm.ads10.Close;
  dm.ads10.Open;
end;

procedure Tmainform.BitBtn3Click(Sender: TObject);
var i:byte;
begin
  if condition_form.ShowModal=mrok then
  with dm.ads10 do
  begin
    close;
    commandtext:=sql_text; //�ָ�Ĭ�����
    for i:=1 to condition_form.SGrid1.RowCount-1 do
      CommandText:=CommandText+condition_form.SGrid1.cells[2,i];
    open;
  end;
end;

procedure Tmainform.BitBtn4Click(Sender: TObject);
begin
  if not dm.ads10.IsEmpty then
  export_dbgrideh_to_excel(eh1,self.Caption);
end;

procedure Tmainform.BitBtn5Click(Sender: TObject);
begin
  pm2.Popup(mouse.CursorPos.X,mouse.CursorPos.Y);
end;

procedure Tmainform.newClick(Sender: TObject);
var bk:integer;
begin
  if (strtoint(vprev)=1) or (strtoint(vprev)=3) then
    showmessage('�Բ�����ֻ�иó����ֻ��Ȩ�ޣ�')
  else
  try
    ready_new;  //����ʼ����
    hide;  //����������
    cust_detail:=Tcust_detail.Create(application);
    cust_detail.is_copy:=0;  //�½��Ǹ���
    if cust_detail.showmodal=mrok then
    begin
      dm.ads10.Close;
      dm.ads10.Open;
      bk:=dm.aq10rkey.Value;
      dm.ads10.Locate('rkey',bk,[]);
    end;
  finally
    dm.aq10.Close;
    cust_detail.Free;
  end;
end;

procedure Tmainform.editClick(Sender: TObject);
var bk:integer;
begin
  if (strtoint(vprev)=1) or (strtoint(vprev)=3) then
    showmessage('�Բ�����ֻ�иó����ֻ��Ȩ�ޣ�')
  else
   try
    dm.aq10.Close;
    dm.aq10.Parameters[0].Value:=dm.ads10rkey.Value;
    dm.aq10.Open;
    dm.aq10.Edit;
    dm.aq12.Close;
    dm.aq12.Parameters[0].Value:=dm.aq10RKEY.Value;
    dm.aq12.Open;
    hide;
    cust_detail:=Tcust_detail.Create(application);
    cust_detail.is_copy:=3;  //�༭
    if cust_detail.ShowModal=mrok then
     begin
      dm.ads10.Close;
      dm.ads10.Open;
      bk:=dm.aq10rkey.Value;
      dm.ads10.Locate('rkey',bk,[]);
     end;
   finally
    dm.aq10.Close;
    cust_detail.Free;
   end;
end;

procedure Tmainform.copyClick(Sender: TObject);
var bk:integer;
begin
  if (strtoint(vprev)=1) or (strtoint(vprev)=3) then
    showmessage('�Բ�����ֻ�иó����ֻ��Ȩ�ޣ�')
  else
  try
    copydata;  //copy�ͻ���Ϣ��װ����Ϣ
    hide;
    cust_detail:=Tcust_detail.Create(application);
    cust_detail.is_copy:=1;
    if cust_detail.showmodal=mrok then
    begin
      dm.ads10.Close;
      dm.ads10.Open;
      bk:=dm.aq10rkey.Value;
      dm.ads10.Locate('rkey',bk,[]);
    end;
  finally
    dm.aq10.Close;
    cust_detail.Free;
  end;
end;

procedure Tmainform.checkClick(Sender: TObject);
begin
 try
   cust_detail:=Tcust_detail.Create(application);
   checkstatus;
   hide;
   cust_detail.is_copy:=2; //���ģʽ
   if cust_detail.ShowModal<>mrok then begin end;
 finally
   dm.aq10.Close;
   dm.aq12.Close;
   cust_detail.Free;
   dm.aq10.LockType:=ltoptimistic;
   dm.aq12.LockType:=ltBatchOptimistic;
 end;
end;

procedure Tmainform.deleteClick(Sender: TObject);
begin  //ע������δ��װ���ӱ�ɾ�������ݿ������ϵ����ɾ����
  if (strtoint(vprev)=1) or (strtoint(vprev)=3) then
    messagedlg('�Բ���!��û�иó���Ŀ�дȨ��',mtconfirmation,[mbcancel],0)
  else if messagedlg('��ȷ��Ҫɾ��������¼��',mtconfirmation,[mbyes,mbno],0)=mryes then
  begin
    dm.ADOConnection1.BeginTrans;
    try
      with dm.aqtmp do
      begin
        close;
        sql.Text:='delete data0011 where ((source_type=1010) or (source_type=2010) or (source_type=3010) '+
                'or (source_type=4010) or (source_type=5010) or (source_type=6010) or (source_type=7010)) '+
                'and file_pointer='+dm.ads10rkey.AsString;
        execsql;//ɾ�����۵�����Ʊ��װ�䵥������ȷ�ϡ����ñ������ͻ��ر�Ҫ���һ����±�
        close;
        sql.Text:='delete data0010 where rkey='+dm.ads10rkey.AsString;
        execsql; //ɾ���ͻ���Ϣ
      end;
      dm.ADOConnection1.CommitTrans;
      messagedlg('����ɾ���ɹ���',mtconfirmation,[mbok],0);
      dm.ads10.Close;
      dm.ads10.Open;
    except
      messagedlg('����ɾ���ÿͻ������ܴ˿ͻ��ѱ�����ʹ�ã�',mtwarning,[mbcancel],0);
      dm.ADOConnection1.RollbackTrans;
    end;
  end;

      if dm.ADOConnection1.Connected then
      begin
             try
                  DM.ADOConnection1.BeginTrans;
                  DM.ADO248_1.Close;
                  DM.ADO248_1.Parameters[0].Value:=dm.ads10rkey.Value;
                  DM.ADO248_1.Open;
                  while not DM.ADO248_1.IsEmpty do
                  DM.ADO248_1.Delete;
                  DM.ADO248_1.Close;
                  DM.ADOConnection1.CommitTrans;
                  except
                        on e:Exception do
                        begin
                          DM.ADOConnection1.RollbackTrans;
                          ShowMessage('��������г��ִ���'+#13+'����ԭ��'+e.Message);
                        end;
             end;
      end;
end;

procedure Tmainform.N2Click(Sender: TObject);
begin
  try
    dm.aq493.Open;
    dm.ppReport1.Print;
  finally
    dm.aq493.Close;
  end;
end;

procedure Tmainform.Eh1DblClick(Sender: TObject);
begin
  editclick(sender);
end;

procedure Tmainform.Eh1KeyDown(Sender:TObject;var Key:Word;Shift:TShiftState);
begin
  if (chr(key)='V')  and (ssalt in shift)then
     showmessage(dm.ads10.CommandText);
end;

procedure Tmainform.N3Click(Sender: TObject);
begin
  with TForm11.Create(Application) do
  begin
    try
      Caption := dm.ads10abbr_name.AsString+':�����¼';
      with dm.tmp do
      begin
        close;
        sql.Clear;
        sql.Add('select user_login_name as USER_ID,USER_FULL_NAME,TRANS_DATE,TRANS_DESCRIPTION, ');
        sql.Add('FROM_STRING,TO_STRING,file_number');
        sql.Add('from data0318 inner join data0073 on');
        sql.Add('data0318.user_ptr=data0073.rkey');
        sql.Add('where WORK_ORDER_PTR='+dm.ads10rkey.AsString);
        sql.Add('order by TRANS_DATE');
        open;
      end;
      while not dm.tmp.Eof do
      begin
        Memo1.Lines.Add(dm.tmp.fieldbyname('trans_date').AsString+
        ' ϵͳ�û�:'+dm.tmp.fieldbyname('user_id').AsString+' '+
        dm.tmp.fieldbyname('user_full_name').AsString+
        dm.tmp.fieldbyname('TRANS_DESCRIPTION').AsString);
        Memo1.Lines.Add(' ԭֵ: '+dm.tmp.fieldbyname('from_string').AsString+
        ' �����: '+dm.tmp.fieldbyname('to_string').AsString+
        '   ���ԭ��:'+dm.tmp.fieldbyname('file_number').AsString);
        dm.tmp.Next;
      end;
      ShowModal;
    finally
      Free;
    end;
  end;
end;

procedure Tmainform.N4Click(Sender: TObject);
begin
 if (strtoint(vprev)=1) or (strtoint(vprev)=3) then
    showmessage('�Բ�����ֻ�иó����ֻ��Ȩ�ޣ�')
  else
 try
   CreditForm:=TCreditForm.Create(application);
    with CreditForm.ADO310 do
    begin
     close;
     Parameters[0].Value:=dm.ads10rkey.Value;
     open;
    end;
   CreditForm.ShowModal;
 finally
  CreditForm.ADO310.Close;
  CreditForm.Free;
 end;
end;



procedure Tmainform.PM1Popup(Sender: TObject);
var
 menu_enable:boolean;
begin
  menu_enable:=not dm.ads10.IsEmpty;

  edit.Enabled:=menu_enable;
  copy.Enabled:=menu_enable;
  check.Enabled:=menu_enable;
  delete.Enabled:=menu_enable;
  N3.Enabled:=menu_enable;
  N2.Enabled:=menu_enable;
  N4.Enabled:=menu_enable;

end;



end.
