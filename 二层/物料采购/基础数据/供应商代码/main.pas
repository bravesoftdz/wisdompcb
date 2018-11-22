unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, Grids, DBGridEh, StdCtrls, Buttons, ExtCtrls,Db,Adodb;

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
    Eh1: TDBGridEh;
    PM1: TPopupMenu;
    new: TMenuItem;
    edit: TMenuItem;
    copy: TMenuItem;
    check: TMenuItem;
    delete: TMenuItem;
    N1: TMenuItem;
    PM2: TPopupMenu;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Eh1TitleClick(Column: TColumnEh);
    procedure newClick(Sender: TObject);
    procedure editClick(Sender: TObject);
    procedure copyClick(Sender: TObject);
    procedure checkClick(Sender: TObject);
    procedure deleteClick(Sender: TObject);
    procedure Eh1DblClick(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure Eh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure N4Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure PM1Popup(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure N8Click(Sender: TObject);
  private
    precolumn:Tcolumneh;
    sql_text:string;
    procedure item_click(sender:Tobject); //�����˵�
    procedure ready_new;  //������¼�����ó�ʼ��Ϣ
    procedure copydata;   //����
    procedure checkstatus; //������״̬
    function ChangeRGB(Ai:Integer):Boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  mainform: Tmainform;

implementation
uses common,damo,condition,detail, uAlter_Info;

{$R *.dfm}

procedure Tmainform.FormCreate(Sender: TObject);
var i:integer;
    item:Tmenuitem;
begin
  if not app_init_2(dm.ADOConnection1) then
  begin
    showmsg('��������ʧ�ܣ�����ϵϵͳ����Ա��','��ʾ',1);
    application.Terminate;
  end;
  self.Caption:=application.Title;


//  user_ptr:='851';
//  vprev:='4';
//  dm.ADOConnection1.Open;

  dm.ads23.Close;
  dm.ads23.Open;
  sql_text:=dm.ads23.CommandText;  //��¼ads05Ĭ��sql���
  precolumn:=eh1.Columns[0]; //��precolumn����ʼֵ
  for i:=0 to eh1.columns.Count-1 do
  begin //��̬�����������ֶβ˵���
    item:=Tmenuitem.Create(self);
    item.Caption:=eh1.columns[i].Title.caption;
    if eh1.Columns[i].Visible then item.Checked:=true;
    item.onClick:=item_click;
    self.PM2.Items.Add(item);
    if (i in [17,18]) and ((vprev='1') or (vprev='2')) then item.Enabled:=false;
  end;
end;

procedure Tmainform.ready_new;
begin   //������¼�����ó�ʼ��Ϣ
  with dm do
  begin
    aq23.Open;
    aq23.Append;
    aq24.Close;
    aq24.Parameters[0].Value:=null;
    aq24.Open;
    aq23status.Value:=0;  //״̬Ϊ����
    aq23put_all_inv_hold.Value:='N';
    aq23country_ptr.Value:=3;    //����Ϊ�й�
    aq23currency_ptr.Value:=1;   //����Ϊ�����
    aq23suppier_ent_date.Value:=getsystem_date(aqtmp,1);  //��������Ϊ����
    aq23brother_flag.Value:=false; //������˾
    aq23payment_terms.Value:=0;  //����������
    aq23discount.Value:=0;       //�����ۿ�1
    aq23discount_days.Value:=0;  //�����ۿ�����1
    aq23discount2.Value:=0;      //�����ۿ�2
    aq23discount2_days.Value:=0; //�����ۿ�����2
    aq23edi_out_new_po.Value:=0;  //�Ƿ�ΪVMI��Ӧ��0:��;1:��
  end;
end;

procedure Tmainform.copydata;  //����
var  v_copy:array[2..62] of variant;
     i:word;
begin
  dm.aq23.Close;
  dm.aq23.Parameters[0].Value:=dm.ads23rkey.Value;
  dm.aq23.Open;
  for i:=2 to 62 do //���¸���data0023��Ӧ����Ϣ��
    v_copy[i]:=dm.aq23.Fields[i].Value;
  dm.aq23.Append;
  for i:=2 to 62 do
    dm.aq23.FieldValues[dm.aq23.Fields[i].FieldName]:=v_copy[i];
  with dm.aqtmp do  //���¸���װ����Ϣ
  begin
    close;
    sql.Clear;
    sql.Add('select RKEY,SUPPLIER_PTR,FACTORY_LOCATION,FACTORY_ADDRESS_1,STATE,ZIP,CONTACT,'+
            'PHONE,FAX,FOB,CITY_TAX_PTR,SHIPPING_METHOD,SHIPPING_LEAD_TIME,STATE_SHIP_TAX_FLAG,'+
            'STATE_MISC_TAX_FLAG,STATE_INVT_TAX_FLAG,LANGUAGE_FLAG,COUNTRY_PTR,EMAIL_FOR_CONTACT '+
            'from data0024 where supplier_ptr=:aq23.rkey' );
    parameters[0].Value:=dm.ads23rkey.Value;
    open;
  end;

  with dm.aq24 do
  begin
    close;
    parameters[0].Value:=null;
    open;
    while not dm.aqtmp.Eof do
    begin
      append;
      for i := 2 to 18 do //��rkey,SUPPLIER_PTR������
        fieldvalues[fields[i].FieldName]:=dm.aqtmp.FieldValues[dm.aqtmp.fields[i].FieldName];
      post;
      dm.aqtmp.Next;
    end;
  end;   //װ�˵ص㸴�����
end;

procedure Tmainform.checkstatus; //������ģʽ
begin
  dm.aq23.Close;
  dm.aq23.Parameters[0].Value:=dm.ads23rkey.Value;
  dm.aq23.LockType:=ltreadonly;  //ֻ��ģʽ
  dm.aq23.Open;
  dm.aq24.Close;
  dm.aq24.Parameters[0].Value:=dm.ads23rkey.Value;
  dm.aq24.LockType:=ltreadonly; //ֻ��ģʽ
  dm.aq24.Open;
  detail_info.BitBtn1.enabled:=false;
  detail_info.BitBtn4.enabled:=false;
  detail_info.BitBtn5.enabled:=false;
  detail_info.BitBtn6.enabled:=false;
  detail_info.BitBtn7.enabled:=false;
  detail_info.BitBtn8.enabled:=false;
  detail_info.BitBtn9.enabled:=false;
  detail_info.MaskEdit1.enabled:=false;
  detail_info.Edit1.enabled:=false;
  detail_info.Edit2.enabled:=false;
  detail_info.Edit3.enabled:=false;
  detail_info.Edit4.enabled:=false;
  detail_info.Edit5.enabled:=false;
  detail_info.memo1.enabled:=false;
  detail_info.memo2.enabled:=false;
  detail_info.memo3.enabled:=false;
  detail_info.dbedtMen.Enabled:=False;
  detail_info.PM1.Items.Delete(2); //ɾ��"���"��"�༭"��"ɾ��"�����˵�
  detail_info.PM1.Items.Delete(1);
  detail_info.PM1.Items.Delete(0);
  detail_info.DBComboBox1.Enabled:=False;
  detail_info.BitBtn12.enabled:=false;
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

procedure Tmainform.BitBtn1Click(Sender: TObject);
begin
  close;
  application.Terminate;
end;

procedure Tmainform.BitBtn2Click(Sender: TObject);
begin
  dm.ads23.Close;
  dm.ads23.Open;
end;

procedure Tmainform.BitBtn3Click(Sender: TObject);
var i:byte;
begin
  if condition_form.ShowModal=mrok then
  with dm.ads23 do
  begin
    close;
    commandtext:=sql_text;
    for i:=1 to condition_form.SGrid1.RowCount-1 do
      commandtext:=commandtext+condition_form.SGrid1.Cells[2,i];
    open;
  end;
end;

procedure Tmainform.BitBtn4Click(Sender: TObject);
begin
  if (strtoint(vprev)=1) or (strtoint(vprev)=3) then
    showmessage('�Բ�����û��Ȩ�޵������ϣ�')
  else
    export_dbgrideh_to_excel(eh1,self.Caption);
end;

procedure Tmainform.BitBtn5Click(Sender: TObject);
begin
  pm2.Popup(mouse.CursorPos.X,mouse.CursorPos.Y);
end;

procedure Tmainform.Edit1Change(Sender: TObject);
begin
  if trim(edit1.Text)<>'' then
    dm.ads23.Filter:=precolumn.FieldName+' like ''%'+trim(edit1.Text)+'%'''
  else dm.ads23.Filter:='';
end;

procedure Tmainform.Eh1TitleClick(Column: TColumnEh);
begin
  if column.Title.SortMarker=smupeh then
  begin
    column.Title.SortMarker:=smdowneh;
    dm.ads23.IndexFieldNames:=column.FieldName+' DESC';
  end
  else begin
    column.Title.SortMarker:=smupeh;
    dm.ads23.IndexFieldNames:=column.FieldName;
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

procedure Tmainform.newClick(Sender: TObject);
var bk:integer;
begin
  if (strtoint(vprev)=1) or (strtoint(vprev)=3) then
    showmessage('�Բ�����ֻ�иó����ֻ��Ȩ�ޣ�')
  else
  try
    ready_new;  //����ʼ����
    hide;  //����������
    detail_info:=Tdetail_info.Create(application);
    detail_info.is_copy:=0;  //�½��Ǹ���
    detail_info.lbl5.Caption:= 'δ������';
    if detail_info.showmodal=mrok then
    begin
      dm.ads23.Close;
      dm.ads23.Open;
      bk:=dm.aq23rkey.Value;
      dm.ads23.Locate('rkey',bk,[]);
    end;
  finally
    dm.aq23.Close;
    detail_info.Free;
  end;
end;

procedure Tmainform.editClick(Sender: TObject);
var bk:integer;
begin
  if (strtoint(vprev)=1) or (strtoint(vprev)=3) then
    showmessage('�Բ�����ֻ�иó����ֻ��Ȩ�ޣ�')
  else
  try
    dm.aq23.Close;
    dm.aq23.Parameters[0].Value:=dm.ads23rkey.Value;
    dm.aq23.Open;
    dm.aq23.Edit;
    dm.aq24.Close;
    dm.aq24.Parameters[0].Value:=dm.aq23RKEY.Value;
    dm.aq24.Open;
    hide;
    detail_info:=Tdetail_info.Create(application);
    detail_info.is_copy:=3;  //�༭
    with dm.aqtmp do
    begin
      Close;
      SQL.Text:= 'select case when AttachFile IS NULL THEN 0 ELSE 1 END from data0023  where rkey = ' + dm.ads23rkey.AsString;
      Open;
      if Fields[0].Value = 0 then detail_info.lbl5.Caption:= 'δ������'
      else detail_info.lbl5.Caption:='�Ѵ�����';
    end;

    if detail_info.ShowModal=mrok then
    begin
      dm.ads23.Close;
      dm.ads23.Open;
      bk:=dm.aq23rkey.Value;
      dm.ads23.Locate('rkey',bk,[]);
    end;
  finally
    dm.aq23.Close;
    detail_info.Free;
  end;
end;

procedure Tmainform.copyClick(Sender: TObject);
var bk:integer;
begin
  if (strtoint(vprev)=1) or (strtoint(vprev)=3) then
    showmessage('�Բ�����ֻ�иó����ֻ��Ȩ�ޣ�')
  else
  try
    copydata;  //copy��Ϣ��װ����Ϣ
    hide;
    detail_info:=Tdetail_info.Create(application);
    detail_info.is_copy:=1;
    detail_info.dbedtMen.Enabled:=True;
    detail_info.lbl5.Caption:= 'δ������';
    if detail_info.showmodal=mrok then
    begin
      dm.ads23.Close;
      dm.ads23.Open;
      bk:=dm.aq23rkey.Value;
      dm.ads23.Locate('rkey',bk,[]);
    end;
  finally
    dm.aq23.Close;
    detail_info.Free;
  end;
end;

procedure Tmainform.checkClick(Sender: TObject);
begin
 try
   detail_info:=Tdetail_info.Create(application);
   checkstatus;
   hide;
   detail_info.is_copy:=2; //���ģʽ
   detail_info.DBEdit13.Enabled:=false;
    with dm.aqtmp do
    begin
      Close;
      SQL.Text:= 'select case when AttachFile IS NULL THEN 0 ELSE 1 END from data0023  where rkey = ' + dm.ads23rkey.AsString;
      Open;
      if Fields[0].Value = 0 then detail_info.lbl5.Caption:= 'δ������'
      else detail_info.lbl5.Caption:='�Ѵ�����';
    end;
   if detail_info.ShowModal<>mrok then begin end;
 finally
   dm.aq23.Close;
   dm.aq24.Close;
   detail_info.Free;
   dm.aq23.LockType:=ltoptimistic;
   dm.aq24.LockType:=ltBatchOptimistic;
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
        sql.Clear;
        sql.Add('delete data0011 where rkey in (:p1,:p2,:p3,:p4)');
        parameters.ParamByName('p1').Value:=dm.ads23po_note_pad_ptr.AsInteger;
        parameters.ParamByName('p2').Value:=dm.ads23debmem_note_pad_ptr.AsInteger;
        parameters.ParamByName('p3').Value:=dm.ads23rfq_note_pad_ptr.AsInteger;
        parameters.ParamByName('p4').Value:=dm.ads23common_pad_ptr.AsInteger;
        execsql;//ɾ���ɹ������������¼��һ����Ѷ���������±�
        close;
        sql.Clear;
        sql.Add('delete data0023 where rkey='+dm.ads23rkey.AsString);
        execsql; //ɾ���ͻ���Ϣ
        close;
      end;
      dm.ADOConnection1.CommitTrans;
      messagedlg('����ɾ���ɹ���',mtconfirmation,[mbok],0);
      dm.ads23.Close;
      dm.ads23.Open;
    except
      messagedlg('����ɾ���ÿͻ������ܴ˿ͻ��ѱ�����ʹ�ã�',mtwarning,[mbcancel],0);
      dm.ADOConnection1.RollbackTrans;
    end;
  end;
end;

procedure Tmainform.Eh1DblClick(Sender: TObject);
begin
  editclick(sender);
end;

procedure Tmainform.N2Click(Sender: TObject);
begin
  with TForm1.Create(Application) do
  begin
    try
      Caption := dm.ads23abbr_name.AsString+':�����¼';
      with dm.aqtmp do
      begin
        close;
        sql.Clear;
        sql.Add('select user_login_name as USER_ID,USER_FULL_NAME,TRANS_DATE,TRANS_DESCRIPTION, ');
        sql.Add('FROM_STRING,TO_STRING,file_number');
        sql.Add('from data0318 inner join data0073 on');
        sql.Add('data0318.user_ptr=data0073.rkey');
        sql.Add('where supplier_ptr='+dm.ads23rkey.AsString);
        sql.Add('order by TRANS_DATE');
        open;
      end;
      while not dm.aqtmp.Eof do
      begin
        Memo1.Lines.Add(dm.aqtmp.fieldbyname('trans_date').AsString+
        ' ϵͳ�û�:'+dm.aqtmp.fieldbyname('user_id').AsString+' '+
        dm.aqtmp.fieldbyname('user_full_name').AsString+
        dm.aqtmp.fieldbyname('TRANS_DESCRIPTION').AsString);
        Memo1.Lines.Add(' ԭֵ: '+dm.aqtmp.fieldbyname('from_string').AsString+
        ' �����: '+dm.aqtmp.fieldbyname('to_string').AsString+
        '   �����ļ���:'+dm.aqtmp.fieldbyname('file_number').AsString);
        dm.aqtmp.Next;
      end;
      ShowModal;
    finally
      Free;
    end;
  end;
end;

procedure Tmainform.Eh1DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
begin
  if DM.ads23flag.Value = 1 then  Eh1.Canvas.Font.Color:= clRed;
  if DM.ads23flag.Value = 2 then  Eh1.Canvas.Font.Color:= clOlive;
  if DM.ads23flag.Value = 3 then  Eh1.Canvas.Font.Color:= clBlue;
  Eh1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

function Tmainform.ChangeRGB(Ai: Integer):Boolean;
begin
  Result:= False;
  try
    with dm.aqtmp do
    begin
      close;
      sql.text := 'Update data0023 set flag ='+ IntToStr(AI) +' where rkey=' + dm.ads23rkey.AsString;
      ExecSQL;
    end;
    Result:= True;
  except
    ShowMessage('����ʧ�ܣ�');
  end;
end;

procedure Tmainform.N4Click(Sender: TObject);
begin
  if ChangeRGB(1) then BitBtn2Click(nil);
end;

procedure Tmainform.N5Click(Sender: TObject);
begin
if ChangeRGB(2) then BitBtn2Click(nil);
end;

procedure Tmainform.N6Click(Sender: TObject);
begin
if ChangeRGB(3) then BitBtn2Click(nil);
end;

procedure Tmainform.PM1Popup(Sender: TObject);
begin
  N3.Enabled := StrToInt(vprev) > 2;
end;

procedure Tmainform.N7Click(Sender: TObject);
begin
  if ChangeRGB(0) then BitBtn2Click(nil);
end;

procedure Tmainform.N8Click(Sender: TObject);
begin
 with dm.aqtmp do
 begin
  Close;
  SQL.Text:= 'select case when AttachFile IS NULL THEN 0 ELSE 1 END from data0023  where rkey = ' + dm.ads23rkey.AsString;
  Open;
  if Fields[0].Value = 0 then
  begin
   ShowMessage('δ������');
   Exit;
  end;
 end;
 dm.aq23.Close;
 dm.aq23.Parameters[0].Value:=dm.ads23rkey.Value;
 dm.aq23.Open;
 dm.aq23.Edit;
 dm.aq24.Close;
 dm.aq24.Parameters[0].Value:=dm.aq23RKEY.Value;
 dm.aq24.Open;
 detail_info:=Tdetail_info.Create(application);
 detail_info.NOpen.OnClick(Sender);
 detail_info.Free;
end;

end.
