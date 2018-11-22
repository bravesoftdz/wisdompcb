unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGridEh, StdCtrls, Buttons, ExtCtrls, Menus, DB, ADODB;

type
  Tfm_main = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    BitBtn1: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    Edit1: TEdit;
    BitBtn2: TBitBtn;
    eh1: TDBGridEh;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    pm2: TPopupMenu;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    pm3: TPopupMenu;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure eh1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure eh1TitleClick(Column: TColumnEh);
    procedure Edit1Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure eh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
  private
    { Private declarations }
    precolumn:Tcolumneh;
    sql_text:string;
    v_colwidth: array[0..8] of integer;
    procedure item_click(sender:Tobject);
    function set_lock(modal:byte):boolean;   //modal��1�༭2ɾ��
    function account_maxdate:Tdatetime;  //��ȡ���ĳɱ���������
  public
    { Public declarations }
  end;

var
  fm_main: Tfm_main;

implementation

uses damo,common, condition, detail,MyClass,ModifyUnitWeight_U,Frm_YSCond_u,
  cust_del;

{$R *.dfm}

procedure Tfm_main.FormCreate(Sender: TObject);
var i:byte;
    item:Tmenuitem;
begin
  if dm.ADOConnection1.Connected then
    begin
      showmessage('�����ڲ���ģʽ�����У����ڷ�������ǰ�ر����Ӻ���룡');
      rkey73:='1502';
      user_ptr:='3';
      vprev:='4';
    end
  else
    if not app_init_2(dm.ADOConnection1) then
      begin
        showmsg('��������ʧ�ܣ�����ϵͳ����Ա��ϵ��',1);
        application.Terminate;
      end;

//      rkey73:='1502';
//      user_ptr:='3';
//      vprev:='4';

 MyDataClass :=TMyDataClass.Create(dm.ADOConnection1);
 user_ptr:=inttostr(MyDataClass.Get_Sql_Value('SELECT EMPLOYEE_PTR  FROM   dbo.Data0073  WHERE  RKEY ='+rkey73));
 self.Caption:=application.Title;
 DateSeparator:='-';
 ShortDateFormat:='yyyy-mm-dd';
 LongDateFormat:='yyyy-mm-dd HH:mm:ss';
 sql_text:=dm.ads64.CommandText;  //��¼ads64Ĭ��sql���
 precolumn:=eh1.Columns[0]; //��precolumn����ʼֵ

 for i:=1 to eh1.columns.Count do
 begin //��̬�����������ֶβ˵���
  item:=Tmenuitem.Create(self);
  item.Caption:=eh1.columns[i-1].Title.caption;
  if eh1.Columns[i-1].Visible then
   item.Checked:=true;
  item.onClick:=item_click;
  self.PM2.Items.Add(item);
 end;
end;

procedure Tfm_main.item_click(sender:Tobject);
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

function Tfm_main.account_maxdate:Tdatetime;
begin
 with dm.aqtmp do
 begin
  close;
  sql.Text:='select max(fg_date) as maxdate from data0444 ';
  open;
 // if not IsEmpty then result:=fieldvalues['maxdate']  ������ѧ��������䲻��ʹ��EMPTY��ֵ�ж�
  if not fieldbyname('maxdate').IsNull then
   result:=fieldvalues['maxdate']
  else
   result:=date()-3650;
 end;
end;

function Tfm_main.set_lock(modal:byte):boolean;  //modal��1�༭2ɾ��
begin
 result:=false;
  with dm.aqtmp do
  begin
   Close;
   SQL.Text:='if exists(SELECT * FROM tempdb.dbo.sysobjects WHERE NAME=''##d64'')'+#13+
     ' select rkey from ##d64 where rkey='+dm.ADS64.fieldbyname('rkey').AsString+#13+
     ' else select top 0 * from data0064 ';
   Open;
   if not isempty then
   begin
    if modal=1 then  //�༭ģʽ
     messagedlg('��ǰ���ּ�¼�������û��������޷��༭��',mtwarning,[mbok],0)
    else
     messagedlg('��ǰ���ּ�¼�������û��������޷��˲֣�',mtwarning,[mbok],0);
    exit;
   end
   else
   begin
    if modal=1 then  //���Ϊ�༭�����������rkey
    begin
     close;
     SQL.Text:='if exists(SELECT * FROM tempdb.dbo.sysobjects WHERE NAME=''##d64'')'+#13+
       ' begin set identity_insert ##d64 on '+#13+
       ' insert ##d64(rkey) values( '''+dm.ADS64.fieldbyname('rkey').AsString+''') '+
       ' set identity_insert ##d64 off end '+#13+
       ' else select rkey into ##d64 from data0064 where rkey='''+dm.ADS64.fieldbyname('rkey').AsString+'''';
     execsql;
    end;
    result:=true;
   end;
  end;
end;

procedure Tfm_main.BitBtn1Click(Sender: TObject);
begin
 application.Terminate;
end;

procedure Tfm_main.BitBtn3Click(Sender: TObject);
var rkey64:integer;
begin
 if dm.ADS64.Active then
 begin
   rkey64:=dm.ADS64rkey.Value;
   dm.ADS64.Close;
   dm.ADS64.Open;
   if rkey64>0 then dm.ADS64.Locate('rkey',rkey64,[]);
 end; 
end;

procedure Tfm_main.BitBtn4Click(Sender: TObject);
begin
 pm3.Popup(mouse.CursorPos.X,mouse.CursorPos.Y);
end;

procedure Tfm_main.BitBtn2Click(Sender: TObject);
begin
 if not dm.ADS64.IsEmpty then
  export_dbgrideh_to_excel(eh1,'����װ��ָ��--���ݵ���');
end;

procedure Tfm_main.eh1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if (chr(key)='S') and (ssalt in shift) then
   showmessage(dm.ADS64.CommandText);
end;

procedure Tfm_main.eh1TitleClick(Column: TColumnEh);
begin
  if column.Title.SortMarker=smupeh then
  begin
    column.Title.SortMarker:=smdowneh;
    dm.ads64.IndexFieldNames:=column.FieldName+' DESC';
  end
  else begin
    column.Title.SortMarker:=smupeh;
    dm.ads64.IndexFieldNames:=column.FieldName;
  end;

  if (column.Field.DataType in [ftString,ftWideString]) and
     (precolumn.FieldName<>column.FieldName) then
  begin //�Ȱѷ��ַ��͵�column��readonly������Ϊfalse,���ַ��Ͳ�����edit����
    label1.Caption:='������'+column.Title.Caption;
    precolumn.Title.Color:=clbtnface;
    column.Title.Color:=clred;
    precolumn:=column;
    edit1.Text:='';
  end;
  edit1.SetFocus;
end;

procedure Tfm_main.Edit1Change(Sender: TObject);
begin
  if trim(edit1.Text)<>'' then
    dm.ads64.Filter:=precolumn.FieldName+' like ''%'+trim(edit1.text)+'%'''
  else dm.ads64.Filter:='';
end;

procedure Tfm_main.FormShow(Sender: TObject);
var i:byte;
begin
  for i:=0 to 8 do v_colwidth[i]:=eh1.Columns[i].Width;
// dm.ADS64.Parameters.ParamByName('dtpk1').Value:=datetostr(getsystem_date(dm.aqtmp,1));
// dm.ADS64.Parameters.ParamByName('dtpk2').Value:=datetostr(getsystem_date(dm.aqtmp,1)+1);
  dm.ADS64.parameters.ParamByName('dtpk1').Value:=DateToStr(fm_condition.dtpk1.Date)+ FormatDateTime(' HH:mm:ss',fm_condition.dtpk3.Time);
  dm.ADS64.parameters.ParamByName('dtpk2').Value:=DateToStr(fm_condition.dtpk2.Date)+ FormatDateTime(' HH:mm:ss',fm_condition.dtpk4.Time);
  dm.ADS64.Prepared;
  dm.ADS64.Open;
end;

procedure Tfm_main.eh1DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
begin
 if (dm.ADS64if_ship.Value='��װ��') then //�����ѵ�������
  eh1.Canvas.Font.Color := clred;//clolive;
 eh1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end; 

procedure Tfm_main.PopupMenu1Popup(Sender: TObject);
begin
 if dm.ADS64.IsEmpty then
 begin
  n2.Enabled:=false;
  n3.Enabled:=false;
  n4.Enabled:=false;
  N7.Enabled:=False;
 end
 else begin
  n3.Enabled:=true;
  n2.Enabled:=dm.ADS64if_ship.Value='δװ��';
  n4.Enabled:=dm.ADS64if_ship.Value='δװ��';
  N7.Enabled:=true;
 end;
end; 

procedure Tfm_main.BitBtn5Click(Sender: TObject);
begin
 pm2.Popup(mouse.CursorPos.X,mouse.CursorPos.Y);
end;

procedure Tfm_main.N1Click(Sender: TObject);
begin
 if (strtoint(vprev)=1) or (strtoint(vprev)=3) then
  messagedlg('�Բ���,��ֻ�б������ֻ��Ȩ��!',mtinformation,[mbok],0)
 else begin
  fm_detail:=Tfm_detail.Create(application);
  fm_detail.v_modal:=1;   //����
  //fm_detail.user_ptr:=user_ptr;
  fm_detail.Edit2.Text:=datetimetostr(getsystem_date(dm.aqtmp,0));
  fm_detail.bt_autoassign.Enabled:=false;
  dm.AQ64.close;
  dm.AQ64.parameters[0].Value:=null;
  dm.AQ64.open;
  dm.AQ64.Append;
  if fm_detail.ShowModal=mrok then
  begin
   dm.ADS64.Close;
   dm.ADS64.Open;
   dm.ADS64.Locate('rkey',dm.AQ64rkey.Value,[]);
  end;
  fm_detail.Free;
 end;
end;

procedure Tfm_main.N2Click(Sender: TObject);
begin
 if (strtoint(vprev)=1) or (strtoint(vprev)=3) then
  messagedlg('�Բ���,��ֻ�б������ֻ��Ȩ��!',mtinformation,[mbok],0)
 else
 begin
  dm.AQ64.Close;
  dm.AQ64.Parameters[0].Value:=dm.ADS64rkey.Value;
  dm.AQ64.Open;
  if (dm.AQ64PACKING_SLIP_FLAG.Value='1') then
  begin
   showmessage('���ܱ༭��ѡ���ָ�������Ѿ�װ�ˡ�');//���ύ���Ѽ��ӻ��ѳ��ֲ��ܱ༭
   exit;
  end;
  
  if IS_FG_counting then
  begin
   showmessage('װ��ָ�ɶ�Ӧ�Ĳ��������̵�״̬�����ܱ༭��');
   exit;
  end;
  if account_maxdate>dm.AQ64DATE_ASSIGN.Value then
   begin
    showmessage('�ɱ��������ڴ���ָ������,���ܱ༭!');
    exit;
   end;

  if set_lock(1) then  //δ����
  begin
   fm_detail:=Tfm_detail.Create(application);
   fm_detail.v_modal:=2; //�༭
   fm_detail.enter_detail;
   if fm_detail.ShowModal=mrok then
   begin
    dm.ADS64.Close;
    dm.ADS64.Prepared;
    dm.ADS64.Open;
    dm.ADS64.Locate('rkey',dm.AQ64rkey.Value,[]);
   end;
   with dm.aqtmp do   //���۱�����˳���ɾ�������ļ�¼
   begin
    Close;
    SQL.Text:='if exists(SELECT * FROM tempdb.dbo.sysobjects WHERE NAME=''##d64'')'+#13+
      ' select rkey from ##d64 where rkey='+dm.ADS64.fieldbyname('rkey').AsString+#13+
      ' else select top 0 * from data0415 ';
    Open;
    if not isempty then delete;
   end;
   fm_detail.Free;
  end;
 end;
end;

procedure Tfm_main.N3Click(Sender: TObject);
begin
 fm_detail:=Tfm_detail.Create(application);
 fm_detail.v_modal:=3;  //���
 //fm_detail.user_ptr:=user_ptr;
 fm_detail.btsave.Enabled:=false;
 fm_detail.Edit15.Enabled:=false;
 fm_detail.Edit16.Enabled:=false;
 fm_detail.bt_autoassign.Enabled:=false;
 fm_detail.sg1.PopupMenu:=nil;
 fm_detail.SG1.Options:=fm_detail.SG1.Options-[goEditing]+[goRowselect];
 fm_detail.enter_detail;
 if fm_detail.ShowModal=mrok then
 begin
  dm.ADS64.Close;
  dm.ADS64.Open;
  dm.ADS64.Locate('rkey',dm.AQ64rkey.Value,[]);
 end;
 fm_detail.Free;
end;

procedure Tfm_main.N4Click(Sender: TObject);     //ɾ��
begin
 if (strtoint(vprev)=1) or (strtoint(vprev)=3) then
 begin
  messagedlg('�Բ���,��ֻ�б������ֻ��Ȩ��!',mtinformation,[mbok],0);
  exit;
 end;

 if IS_FG_counting then
 begin
  showmessage('װ��ָ�ɶ�Ӧ�Ĳ��������̵�״̬�������˲֣�');
  exit;
 end;
 if account_maxdate>dm.ADS64date_assign.Value then
 begin
  showmessage('ѡ���װ��ָ���Ѿ�����ɱ��������˲֣�');
  exit;
 end;
 with dm.aqtmp do
 begin
  Close;
  sql.Clear;
  SQL.Add('select data0053.* from data0064 inner join data0052 on');
  sql.Add('data0052.so_shp_ptr=data0064.rkey');
  sql.Add('inner join data0053 on data0053.rkey=data0052.DATA0053_PTR');
  sql.Add('where data0064.rkey='+dm.ADS64rkey.AsString+' and data0053.CUST_PART_PTR<>'+dm.ADS64rkey25.AsString);
  Open;
 end;
 if not dm.aqtmp.IsEmpty then
 begin
  showmessage('ѡ���װ��ָ������ؿ��Ĳ�Ʒָ���ѷ����仯�������˲֣�');
  exit;
 end;
 if set_lock(2) then  //��¼δ����
  if messagedlg('��ȷ��Ҫɾ��ѡ�е�װ��ָ����?',mtconfirmation,[mbyes,mbno],0)=mrYes then
  begin
   dm.AQ64.Close;
   dm.AQ64.Parameters[0].Value:=dm.ADS64rkey.Value;
   dm.AQ64.Open;
   if (dm.AQ64PACKING_SLIP_FLAG.Value='1') then
   begin
    showmessage('�����˲֣�ѡ���ָ�������Ѿ�װ�ˡ�');
    exit;
   end;
   try
    dm.ADOConnection1.BeginTrans;
    fm_detail.del_old_data;
    dm.AQ64.Delete;   //ɾ��64���֣�������ɾ�������ӱ�52
    dm.ADOConnection1.CommitTrans;
    dm.ADS64.Close;
    dm.ADS64.Open;
   except
    dm.ADOConnection1.RollbackTrans;
    showmessage('ָ���˲ֲ������ɹ��������ָ�ɼ�¼�Ƿ������ͻ��˻�����');
   end; //end try
  end;
end;

procedure Tfm_main.FormDestroy(Sender: TObject);
begin
 MyDataClass.Free;
end;

procedure Tfm_main.BitBtn6Click(Sender: TObject);
begin
  if (strtoint(vprev)=1) or (strtoint(vprev)=3) then
  begin
    showmessage('��Ǹ����û��Ȩ���޸ĵ��أ�');
    Exit;
  end;
  FrmModifyUnitWeight:=TFrmModifyUnitWeight.Create(Application);
  //FrmModifyUnitWeight.user_ptr:=user_ptr;
  if not dm.ADS64.IsEmpty then
    FrmModifyUnitWeight.edtManuPartNumber.Text:=dm.ADS64manu_part_number.AsString;
  FrmModifyUnitWeight.ShowModal;
  FrmModifyUnitWeight.Free;
end;

procedure Tfm_main.N5Click(Sender: TObject);
var i:byte;
begin
 if fm_condition.ShowModal=mrok then
 with dm.ads64 do
 begin
   close;
   commandtext:=sql_text; //�ָ�Ĭ�����
   for i:=1 to fm_condition.SGrid1.RowCount-1 do
     CommandText:=CommandText+fm_condition.SGrid1.cells[2,i];
//  parameters.ParamByName('dtpk1').Value:=fm_condition.dtpk1.Date;
//  parameters.ParamByName('dtpk2').Value:=fm_condition.dtpk2.Date+1;
   parameters.ParamByName('dtpk1').Value:=DateToStr(fm_condition.dtpk1.Date)+ FormatDateTime(' HH:mm:ss',fm_condition.dtpk3.Time);
   parameters.ParamByName('dtpk2').Value:=DateToStr(fm_condition.dtpk2.Date)+ FormatDateTime(' HH:mm:ss',fm_condition.dtpk4.Time);
   Prepared;
   open;
 end;

end;

procedure Tfm_main.N6Click(Sender: TObject);
begin
  TFrm_YSCond.QryDo;
end;

procedure Tfm_main.N7Click(Sender: TObject);
begin
 if (strtoint(vprev)=1) or (strtoint(vprev)=3) then
  messagedlg('�Բ���,��ֻ�б������ֻ��Ȩ��!',mtinformation,[mbok],0)
 else begin
   dm.ADS64.Edit;
   try
     Fcust_del:=TFcust_del.Create(Application);
     if Fcust_del.ShowModal=mrok then
       dm.ADS64.Post
     else
       dm.ADS64.Cancel;
   finally
      Fcust_del.Free;
   end;

 end;
end;

end.
