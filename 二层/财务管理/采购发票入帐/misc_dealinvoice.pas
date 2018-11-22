unit misc_dealinvoice;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, ExtCtrls, Menus, Grids, ToolWin,DateUtils;

type
  TForm4 = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn3: TBitBtn;
    add_edit: TLabel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Bevel1: TBevel;
    Label1: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Edit1: TEdit;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Edit9: TEdit;
    BitBtn2: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    Edit10: TEdit;
    Edit11: TEdit;
    DateTimePicker3: TDateTimePicker;
    Label14: TLabel;
    Label18: TLabel;
    ComboBox1: TComboBox;
    ToolBar1: TToolBar;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    SpeedButton8: TSpeedButton;
    SpeedButton9: TSpeedButton;
    Label25: TLabel;
    Panel1: TPanel;
    Label19: TLabel;
    Label23: TLabel;
    Edit_employee: TEdit;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label24: TLabel;
    Label26: TLabel;
    Edit_fyear: TEdit;
    Edit_number: TEdit;
    Edit_PERIOD: TEdit;
    Edit_date: TEdit;
    report_Check: TCheckBox;
    Edit_ATTACHED: TEdit;
    UpDown1: TUpDown;
    SGrid1: TStringGrid;
    sgrid2: TStringGrid;
    PopupMenu3: TPopupMenu;
    N4: TMenuItem;
    N5: TMenuItem;
    N11: TMenuItem;
    N7: TMenuItem;
    N10: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    abbr_name: TLabel;
    procedure Edit7KeyPress(Sender: TObject; var Key: Char);
    procedure Edit7KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DateTimePicker1Exit(Sender: TObject);
    procedure DateTimePicker2Exit(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BitBtn1Enter(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure update_04(v_seed:string);
    procedure Edit5Exit(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure re_calculate;
    procedure N4Click(Sender: TObject);
    function find_accterror(rkey103: integer): boolean;
    function get_vouchernumber(inv_date: tdatetime): string;
    function find_invoerror(number: string): boolean;
    function vo_number(number: string): boolean;
    function get_gltp(rkey103: string): integer;
    function get_glcurr_ptr(rkey103: string): integer;
    procedure N5Click(Sender: TObject);
    procedure N11Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure N9Click(Sender: TObject);
    procedure SpeedButton9Click(Sender: TObject);
    procedure Edit_dateExit(Sender: TObject);
    procedure Edit_dateKeyPress(Sender: TObject; var Key: Char);
    procedure SGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure SGrid1Exit(Sender: TObject);
    procedure SGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure SGrid1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure PopupMenu3Popup(Sender: TObject);
    procedure SGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    function get_col5(row:integer):currency;
    function get_col6(row:integer):currency;
  private
    { Private declarations }
    warehouse_ptr,supp_ptr,currency_ptr:integer;
  public
    { Public declarations }
    acc_gl_ptr:integer;
  end;

var
  Form4: TForm4;
  function Power(x, y : extended) : extended;
  function RemoveInvalid(where: string): string;

implementation

uses datamd, warehouse_search, supplier_search, curr_search, main,
  AcctSearch, voucher_dictionary, voucher_report,common;

{$R *.dfm}
function TForm4.get_col5(row: integer): currency;
var
 i:integer;
begin
result:=0;
 for i:=1 to sgrid1.RowCount-2 do
  begin
   if (trim(sgrid1.Cells[5,i])<>'') and (i<>row) then
   result:=result+strtocurr(sgrid1.Cells[5,i]);
  end;
end;

function TForm4.get_col6(row: integer): currency;
var
 i:integer;
begin
result:=0;
 for i:=1 to sgrid1.RowCount-2 do
  begin
   if (trim(sgrid1.Cells[6,i])<>'') and (i<>row) then
   result:=result+strtocurr(sgrid1.Cells[6,i]);
  end;
end;

function TForm4.get_gltp(rkey103: string): integer;
begin
with dm.ADOQuery1 do
 begin
  close;
  sql.Clear;
  sql.Add('select curr_tp from data0103');
  sql.Add('where rkey='+rkey103);
  open;
  result:=fieldbyname('curr_tp').AsInteger;
 end;
end;

function TForm4.get_glcurr_ptr(rkey103: string): integer;
begin
with dm.ADOQuery1 do
 begin
  close;
  sql.Clear;
  sql.Add('select curr_ptr from data0103');
  sql.Add('where rkey='+rkey103);
  open;
  result:=fieldbyname('curr_ptr').AsInteger;
 end;
end;

function TForm4.vo_number(number: string): boolean;
begin
result:=false;
with dm.ADOQuery1 do
 begin
  close;
  sql.Clear;
  sql.Add('select rkey from data0105');
  sql.Add('where VOUCHER='''+number+'''');
  open;
  if not IsEmpty then  result:=true;
 end;
end;

function TForm4.find_accterror(rkey103: integer): boolean;
begin
with dm.ADOQuery1 do
 begin
  close;
  sql.Clear;
  sql.Add('select rkey from data0128 where GL_ACCT_PTR='+inttostr(rkey103));
  open;
 end;
if not dm.ADOQuery1.IsEmpty then
 result:=true
else
 result:=false;
end;

procedure TForm4.re_calculate;
var
 i:word;
 vdb,vcr:currency;
begin
vdb:=0;
vcr:=0;
 for i:=1 to sgrid1.RowCount-2 do
  begin
   if trim(sgrid1.cells[5,i])<>'' then
    vdb:=vdb+strtocurr(trim(sgrid1.cells[5,i]));
   if trim(sgrid1.cells[6,i])<>'' then
    vcr:=vcr+strtocurr(trim(sgrid1.cells[6,i]));
  end;
statictext1.Caption:=Floattostrf(vdb,ffNumber,10,2);
statictext2.Caption:=Floattostrf(vcr,ffNumber,10,2);
end;

function TForm4.get_vouchernumber(inv_date: tdatetime): string;
var
 voucher:string;
 pr_req:integer;
begin
 voucher:='TA'+copy(inttostr(yearof(inv_date)),3,2);  //���
 if length(inttostr(monthof(inv_date))) < 2 then
  voucher := voucher+'0'+inttostr(monthof(inv_date))
 else
  voucher := voucher+inttostr(monthof(inv_date));      //�·�
 with dm.ADOQuery1 do
  begin
   close;
   sql.Clear;
   sql.Add('select top 1 VOUCHER from data0105');
   sql.Add('where VOUCHER like '''+voucher+'%''');
   sql.Add('order by voucher desc');
   open;
  end;
 if dm.ADOQuery1.IsEmpty then
  begin
   voucher:= voucher+'00001';
  end
 else
  begin
   pr_req := strtoint(copy(dm.ADOQuery1.fieldvalues['VOUCHER'],
   length(trim(voucher))+1,5));
   pr_req := 100000+pr_req+1;
   voucher := voucher+copy(inttostr(pr_req),2,5);
  end;
 result:=voucher;
end;

function RemoveInvalid(where: string): string;
 var
  tstr: string;
begin
  tstr:=where;
  while pos(',', tstr)>0 do
    tstr:=copy(tstr,1,pos(',',tstr)-1) +
       copy(tstr,pos(',',tstr)+1,length(tstr)-pos(',',tstr));
  Result:=tstr;
end;

procedure TForm4.Edit7KeyPress(Sender: TObject; var Key: Char);
begin
 if not (key in ['0'..'9','.',#8,#13]) then  //�ж��Ƿ���������
  abort
 else
  if key = chr(46) then      //�ж��Ƿ��ظ�����С����'.'
   if pos('.',(sender as tedit).Text)>0  then abort;
end;

procedure TForm4.Edit7KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key<>9 then
 begin
  if trim((sender as tedit).Text) = '' then (sender as tedit).Text := '0';
  edit6.Text:=formatfloat('0.00',strtofloat(edit7.Text)+
                                 strtofloat(edit8.Text)+
                                 strtofloat(edit9.Text));
 end;
end;

procedure TForm4.DateTimePicker1Exit(Sender: TObject);
begin
if datetimepicker1.Date>self.DateTimePicker2.Date then
 begin
  showmessage('��Ʊ���ڲ��ܴ��ڸ�������!');
  self.DateTimePicker1.SetFocus;
 end;
end;

procedure TForm4.DateTimePicker2Exit(Sender: TObject);
begin
if datetimepicker1.Date>self.DateTimePicker2.Date then
 begin
  showmessage('�������ڲ���С�ڷ�Ʊ����!');
  self.DateTimePicker2.SetFocus;
 end;
end;

procedure TForm4.BitBtn2Click(Sender: TObject);
begin
form_wh:=tform_wh.Create(application);
if form_wh.ShowModal=mrok then
 begin
  edit2.Text:=form_wh.ADOQuery1WAREHOUSE_CODE.Value;
  label8.Caption:=form_wh.ADOQuery1ABBR_NAME.Value;
  self.warehouse_ptr:=form_wh.ADOQuery1RKEY.Value;
 end;
form_wh.Free;
end;

procedure TForm4.BitBtn4Click(Sender: TObject);
begin
form_supp:=tform_supp.Create(application);
if form_supp.ShowModal=mrok then
 begin
  edit3.Text:=form_supp.ADOQuery1CODE.Value;
  label9.Caption:=form_supp.ADOQuery1SUPPLIER_NAME.Value;
  self.abbr_name.Caption:=form_supp.adoquery1abbr_name.value;
  self.supp_ptr:=form_supp.ADOQuery1RKEY.Value;
  self.currency_ptr:=form_supp.ADOQuery1CURRENCY_PTR.Value;
  edit4.Text:=form_supp.ADOQuery1curr_code.Value;
  label14.Caption:=form_supp.ADOQuery1curr_name.Value;
  edit5.Text:=form_supp.ADOQuery1BASE_TO_OTHER.AsString;
  self.DateTimePicker2.Date:=self.DateTimePicker1.Date+form_supp.ADOQuery1PAYMENT_TERMS.value;
  acc_gl_ptr:=form_supp.ADOQuery1ACC_PAYABLE_PTR.Value;
 end;
form_supp.Free;
end;

procedure TForm4.BitBtn5Click(Sender: TObject);
begin
form_curr:=tform_curr.Create(application);
if form_curr.ShowModal=mrok then
 begin
  edit4.Text:=form_curr.ADOQuery1CURR_code.Value;
  label14.Caption:=form_curr.ADOQuery1CURR_NAME.Value;
  self.currency_ptr:=form_curr.ADOQuery1RKEY.Value;
  edit5.Text:=form_curr.ADOQuery1BASE_TO_OTHER.AsString;
  if self.currency_ptr=1 then
   edit5.Enabled:=false
  else
   edit5.Enabled:=true;
 end;
form_curr.Free;
end;

procedure TForm4.FormActivate(Sender: TObject);
var
 i:integer;
begin
sgrid1.Cells[0,0]:='��ĿժҪ';
sgrid1.Cells[1,0]:='��Ŀ���뼰����';
sgrid1.Cells[2,0]:='����';
sgrid1.Cells[3,0]:='����';
sgrid1.Cells[4,0]:='ԭ�ҽ��';
sgrid1.Cells[5,0]:='�跽(����)';
sgrid1.Cells[6,0]:='����(����)';

if add_edit.Caption='0' then     //����
 begin
  dm.ADOSP04.Close;
  dm.ADOSP04.Open;
  if dm.ADOSP04SEED_FLAG.Value<>1 then
  edit1.Text:=dm.ADOSP04SEED_VALUE.Value;
  if dm.ADOSP04SEED_FLAG.Value=4 then
   Edit1.ReadOnly:=True;  
  self.DateTimePicker1.Date:=form1.sys_shortdate;
  self.DateTimePicker2.Date:=form1.sys_shortdate;
  self.DateTimePicker3.Date:=form1.sys_shortdate;
 end
else      //�༭���߼��
 begin
  self.warehouse_ptr:=dm.Aq107warehouse_ptr.Value;
  self.supp_ptr:=dm.Aq107supp_ptr.Value;
  self.currency_ptr:=dm.Aq107currency_ptr.Value;
  if self.currency_ptr=1 then
   edit5.Enabled:=false
  else
   edit5.Enabled:=true;

  dm.ADO107.Close;
  dm.ADO107.Parameters[0].Value:=dm.Aq107rkey.Value;
  dm.ADO107.Open;
  edit10.Text:=dm.Ado107tax_invoice_amt.AsString;
  self.DateTimePicker3.Date:=dm.Ado107tax_invoice_date.Value;
  edit11.Text:=dm.Ado107tax_invoice_ref.Value;

  dm.ADO107.Close;
  dm.Aqd105.Close;
  dm.Aqd105.Parameters[0].Value:=dm.Aq107rkey105.Value;
  dm.Aqd105.Open;
  if not dm.Aqd105.IsEmpty then
  begin
  self.Edit_number.Text:=dm.Aqd105VOUCHER.Value;
  self.Edit_date.Text:=dm.Aqd105ENTERED_DT.AsString;
  self.Edit_fyear.Text:=dm.Aqd105FYEAR.AsString;
  self.Edit_PERIOD.Text:=dm.Aqd105PERIOD.AsString;
  updown1.Position:=dm.Aqd105ATTACHED.Value;
  self.Edit_employee.Text:=dm.Aqd105EMPLOYEE_NAME.Value;
  dm.Aqd106.Close;
  dm.Aqd106.Parameters[0].Value:=dm.Aqd105rkey.Value;
  dm.Aqd106.Open;
  sgrid1.RowCount:=dm.Aqd106.RecordCount+2;
  sgrid2.RowCount:=sgrid1.RowCount;
  for i:=1 to dm.Aqd106.RecordCount do
   begin
    sgrid1.Cells[0,i]:=dm.Aqd106DESCRIPTION.Value;
    sgrid1.Cells[1,i]:=dm.Aqd106gl_desc.Value;
    sgrid1.Cells[2,i]:=dm.aqd106curr_code.value;
    sgrid1.Cells[4,i]:=dm.Aqd106PRICE.AsString;
     //formatfloat('0.00',dm.Aqd106AMOUNT.value*     //ԭ��
      //                             dm.Aqd106EXCH_RATE.Value);
    sgrid1.Cells[3,i]:=formatfloat('0.00000000',1/dm.Aqd106EXCH_RATE.Value);
    sgrid2.Cells[0,i]:=dm.Aqd106GL_ACCT_NO_PTR.AsString;
    sgrid2.Cells[1,i]:=dm.Aqd106CURR_PTR.AsString;
    if dm.Aqd106D_C.Value='D' then
     sgrid1.Cells[5,i]:=formatfloat('0.00',dm.Aqd106AMOUNT.Value)
    else
     sgrid1.Cells[6,i]:=formatfloat('0.00',dm.Aqd106AMOUNT.Value);
    dm.Aqd106.Next;
   end;
  dm.Aqd105.Close;
  dm.Aqd106.Close;
  end;
 end;

if sgrid1.RowCount=2 then
 begin
  speedbutton3.Enabled:=false;
  speedbutton4.Enabled:=false;
  speedbutton5.Enabled:=false;
  speedbutton6.Enabled:=false;
  speedbutton7.Enabled:=false;
  speedbutton8.Enabled:=false;
 end
else
 self.re_calculate();//���¼��������
self.PageControl1.ActivePageIndex:=0;
end;

procedure TForm4.BitBtn1Enter(Sender: TObject);
begin
if trim(edit1.Text)='' then
 begin
  showmessage('��Ʊ��Ų�����Ϊ��!');
  edit1.SetFocus;
  exit;
 end;
 
if not dm.Adosp04.Active then dm.adosp04.Open;
if (dm.adosp04SEED_FLAG.Value<>1) and
  (not (edit1.Text[length(trim(edit1.Text))] in ['0'..'9'])) then
 begin
  messagedlg('��Ʊ������һλ������һ������!',mtinformation,[mbok],0);
  edit1.SetFocus;
  exit;
 end;

if trim(edit2.Text)='' then
 begin
  showmessage('����ѡ��һ������!');
  edit2.SetFocus;
  exit;
 end;

if trim(edit3.Text)='' then
 begin
  showmessage('����ѡ��һ����Ӧ��!');
  edit3.SetFocus;
  exit;
 end;

if strtofloat(edit6.Text)<=0 then
 begin
  showmessage('��Ʊ�ܽ������ڵ�����');
  edit8.SetFocus;
  exit;
 end;

 self.PageControl1Change(sender);
if sgrid1.RowCount>2 then
 begin
  if strtocurr(RemoveInvalid(statictext1.Caption))<>
     strtocurr(RemoveInvalid(statictext2.Caption)) then
   begin
    messagedlg('��Ŀ���˫����һ��!',mterror,[mbcancel],0);
    self.PageControl1.ActivePageIndex:=1;
    sgrid1.SetFocus;
    exit;
   end;

  if strtocurr(formatfloat('0.00',strtocurr(edit6.Text)*strtofloat(edit5.Text)))<>
     strtocurr(RemoveInvalid(statictext2.Caption)) then
   begin
    messagedlg('��Ŀ��������뷢Ʊ�����һ��!',mterror,[mbcancel],0);
    self.PageControl1.ActivePageIndex:=1;
    sgrid1.SetFocus;
    exit;
   end;

  if not dm.Aqd508.Active then dm.Aqd508.Open;
  if (strtoint(Edit_fyear.Text) < dm.Aqd508CURR_FYEAR.Value) or
     ((strtoint(Edit_fyear.Text) <= dm.Aqd508CURR_FYEAR.Value) and
     (strtoint(Edit_PERIOD.Text) < dm.Aqd508CURR_PERIOD.Value)) then
   begin
    messagedlg('ƾ֤��Ȼ����ڼ�С�ڵ�ǰ�����Ȼ����ڼ�!',mterror,[mbcancel],0);
    self.PageControl1.ActivePageIndex:=1;
    self.Edit_date.SetFocus;
    exit;
   end;
  if (strtoint(self.Edit_PERIOD.Text) <> monthof(strtodate(edit_date.text))) then
   begin
    messagedlg('ƾ֤�ڼ䲻����ƾ֤�����޵Ļ���ڼ����޸�!',mterror,[mbcancel],0);
    self.PageControl1.ActivePageIndex:=1;
    edit_date.SetFocus;
    exit;
   end;
 end;

end;

procedure TForm4.BitBtn1Click(Sender: TObject);
var
 i:integer;
begin
if add_edit.Caption='0' then
 begin
  if self.find_invoerror(trim(edit1.Text)) then
  begin
   dm.adosp04.Close;
   dm.adosp04.Open;
   if dm.adosp04SEED_FLAG.Value<>1 then
    begin
     if messagedlg('��Ʊ����ظ����ܶ���ͬʱ����,�Ƿ��Զ����±��Ϊ:'+
      dm.adosp04SEED_VALUE.Value,mtconfirmation,[mbyes,mbno],0)=mryes then
      Edit1.Text:=dm.adosp04SEED_VALUE.Value
     else
      begin
       PageControl1.ActivePageIndex:=0;
       edit1.SetFocus;
       exit;
      end;
    end
   else
    begin
     messagedlg('��������ظ�!���ֹ���������',mterror,[mbok],0);
     PageControl1.ActivePageIndex:=0;
     edit1.SetFocus;
     exit;
    end;
  end;

  if sgrid1.RowCount>2 then
  if self.vo_number(trim(self.Edit_number.Text)) then
   begin
    Edit_number.Text:=get_vouchernumber(strtodate(self.Edit_date.Text));
    messagedlg('ƾ֤����ظ����ܶ���ͬʱ����,ϵͳ���Զ����±��:'+edit_number.Text,mterror,[mbcancel],0);
   end;

  dm.ACt.BeginTrans;
  try
  dm.ADO107.Close;
  dm.ADO107.Parameters[0].Value:=null;
  dm.ADO107.Open;
  dm.ADO107.Append;
  dm.ADO107INVOICE_NO.Value:=trim(edit1.Text);
  dm.ADO107SUPP_PTR.Value:=self.supp_ptr;
  dm.ADO107CURRENCY_PTR.Value:=self.currency_ptr;
  dm.ADO107EX_RATE.AsString:=edit5.Text;
  dm.ADO107warehouse_ptr.Value:=self.warehouse_ptr;
  dm.ADO107EMPL_PTR.Value:=strtoint(user_ptr);
  dm.ADO107INV_TP.Value:=inttostr(ComboBox1.ItemIndex);
  dm.ADO107STATUS.Value:=1;
  dm.ADO107INV_TOTAL.Value:=strtofloat(edit6.Text);
  dm.ADO107MATL_TOT.Value:=strtofloat(edit8.Text);
  dm.ADO107FED_TAX.Value:=strtofloat(edit9.Text);
  dm.ADO107MISC_TOT.Value:=strtofloat(edit7.Text);
  dm.ADO107INV_DATE.Value:=self.DateTimePicker1.Date;
  dm.ADO107DUE_DATE.Value:=self.DateTimePicker2.Date;
  dm.ADO107ENT_DATE.Value:=form1.sys_longdate;
  dm.ADO107tax_invoice_amt.Value:=strtocurr(edit10.Text);
  dm.ADO107tax_invoice_date.Value:=self.DateTimePicker3.Date;
  dm.ADO107tax_invoice_ref.Value:=trim(edit11.Text);
  dm.ADO107.Post;
   dm.adosp04.Close;
   dm.adosp04.Open;
  if dm.adosp04SEED_FLAG.Value<>1 then
  update_04(trim(dm.ADOSP04SEED_VALUE.Value)); //����04������

   if sgrid1.RowCount>2 then
   begin
    dm.ADO104.Close;
    case self.ComboBox1.ItemIndex of
     0,2,4:dm.ADO104.Parameters[0].Value:=1;
     1:dm.ADO104.Parameters[0].Value:=2;
     3:dm.ADO104.Parameters[0].Value:=12;
    end;
    dm.ADO104.Open;
    with dm.ado105 do                                        //���ӻ��ƾ֤�ܱ�
    begin
     close;
     dm.ado105.Parameters[0].Value:=null;
     open;
     append;
     dm.ado105VOUCHER.Value:=self.Edit_number.Text;             //ƾ֤��
     dm.ado105BATCH_NUMBER.Value:=DM.ADO107INVOICE_NO.Value;  //�ο���Ʊ��
     dm.ado105TRANS_TYPE.Value:=dm.ADO104RKEY.Value;            //ҵ������
     dm.ado105VOU_TYPE.Value:=0;
     dm.ado105SOURCE_PTR.Value:=dm.ADO107RKEY.Value;              //��Ʊָ��
     dm.ado105ENTERED_BY_EMPL_PTR.Value:=dm.ADO107EMPL_PTR.Value; //������Ա
     dm.ado105ENTERED_DT.Value:=strtodate(self.Edit_date.Text);      //��������
     dm.ado105ATTACHED.Value := updown1.Position;                 //��������
     dm.ado105FYEAR.Value := strtoint(self.Edit_fyear.Text);      //������
     dm.ado105PERIOD.Value := strtoint(self.Edit_PERIOD.Text);         //����ڼ�
     dm.ado105supp_PTR.Value:=dm.ADO107SUPP_PTR.value;
     post;
    end;

    dm.ADO106.Close;
    dm.ADO106.Parameters[0].Value:=dm.ADO105RKEY.Value;
    dm.ADO106.Open;
    for i:=1 to SGrid2.RowCount-2 do
    begin
    dm.ado106.Append;
    dm.ado106GL_HEADER_PTR.Value:=dm.ado105RKEY.Value;
    dm.ado106GL_ACCT_NO_PTR.AsString:=sgrid2.Cells[0,i];
    dm.ADO106CURR_PTR.AsString:=sgrid2.Cells[1,i];
    dm.ADO106EXCH_RATE.AsString:=
    Floattostrf(1/strtofloat(sgrid1.Cells[3,i]),ffFixed,12,8);
     { TODO -owilliam -cע������ : �ڱ���ƾ֤ʱ����Ҫ�� 1�ĵ��� }
    dm.ado106REF_NUMBER.Value:=dm.ADO107INVOICE_NO.Value;
    dm.ado106DESCRIPTION.Value:=sgrid1.Cells[0,i];
    dm.ADO106PRICE.AsString :=sgrid1.Cells[4,i]; //ԭ��
    if (trim(sgrid1.Cells[5,i])<>'') then
     begin
      dm.ado106AMOUNT.AsString:=sgrid1.Cells[5,i];
      dm.ado106D_C.Value:='D';               //�跽
     end
    else
     begin
      dm.ado106AMOUNT.AsString:=sgrid1.Cells[6,i];
      dm.ado106D_C.Value:='C';               //����
     end;
    dm.ado106.Post;
   end;
   end;
   //============================����ƾ֤===================

  dm.ACt.CommitTrans;
  if (self.report_Check.Checked) and (not dm.ADO105.IsEmpty)  then
  begin  //��ӡƾ֤
   form_voucherreport:=Tform_voucherreport.Create(application);
     form_voucherreport.ppReport1.Reset;
     form_voucherreport.ppReport1.Template.FileName :=
      stringReplace(GetCurrentDir,'EXEC','NIERP\REPORT\',[rfReplaceAll])+
        'VOUCHER_REPORT.rtm';    //R:\NIERP\Report\VOUCHER_REPORT.rtm
     form_voucherreport.ppReport1.Template.LoadFromFile;
   form_voucherreport.AQD105.Close;
   form_voucherreport.AQD105.Parameters[0].Value:=dm.ADO105RKEY.Value;
   form_voucherreport.AQD105.open;
   form_voucherreport.AQD106.Open;
   form_voucherreport.AQD493.Open;
   form_voucherreport.ppReport1.Print;
   form_voucherreport.Free;
  end;

  ModalResult:=mrok;
  except
   on E: Exception do
    begin
     dm.ACt.RollbackTrans;
     messagedlg(E.Message,mterror,[mbcancel],0);
     edit1.SetFocus;
    end;
  end;
 end
else      //�༭
 begin
  dm.ACt.BeginTrans;
  try
   dm.ADO107.Close;
   dm.ADO107.Parameters[0].Value:=dm.Aq107rkey.Value;
   dm.ADO107.Open;
   dm.ADO107.Edit;
   dm.ADO107INVOICE_NO.Value:=trim(edit1.Text);

   dm.ADO107SUPP_PTR.Value:=self.supp_ptr;
   dm.ADO107CURRENCY_PTR.Value:=self.currency_ptr;
   dm.ADO107EX_RATE.AsString:=edit5.Text;
   dm.ADO107warehouse_ptr.Value:=self.warehouse_ptr;

   dm.ADO107INV_DATE.Value:=self.DateTimePicker1.Date;
   dm.ADO107DUE_DATE.Value:=self.DateTimePicker2.Date;
   dm.ADO107INV_TOTAL.Value:=strtofloat(edit6.Text);
   dm.ADO107MATL_TOT.Value:=strtofloat(edit8.Text);
   dm.ADO107FED_TAX.Value:=strtofloat(edit9.Text);
   dm.ADO107MISC_TOT.Value:=strtofloat(edit7.Text);
   dm.ADO107tax_invoice_amt.Value:=strtofloat(edit10.Text);
   dm.ADO107tax_invoice_date.Value:=self.DateTimePicker3.Date;
   dm.ADO107tax_invoice_ref.Value:=edit11.Text;

   dm.ADO107.Post;

   with dm.ado105 do                                        //���ӻ��ƾ֤�ܱ�
    begin
     close;
     dm.ado105.Parameters[0].Value:=dm.Aq107rkey105.Value;
     open;
    end;
    if not dm.ado105.isempty then dm.ado105.Delete;
    dm.ADO106.Close;
    dm.ADO106.Parameters[0].Value:=dm.ADO105RKEY.Value;
    dm.ADO106.Open;

   if sgrid1.RowCount>2 then
   begin
    dm.ADO104.Close;
    case self.ComboBox1.ItemIndex of
     0,2,4:dm.ADO104.Parameters[0].Value:=1;
     1:dm.ADO104.Parameters[0].Value:=2;
     3:dm.ADO104.Parameters[0].Value:=12;
    end;
    dm.ADO104.Open;

    with dm.ado105 do                                        //���ӻ��ƾ֤�ܱ�
    begin
     append;
     dm.ado105VOUCHER.Value:=self.Edit_number.Text;             //ƾ֤��
     dm.ado105BATCH_NUMBER.Value:=DM.ADO107INVOICE_NO.Value;  //�ο���Ʊ��
     dm.ado105TRANS_TYPE.Value:=dm.ADO104RKEY.Value;            //ҵ������
     dm.ado105VOU_TYPE.Value:=0;
     dm.ado105SOURCE_PTR.Value:=dm.ADO107RKEY.Value;              //��Ʊָ��
     dm.ado105ENTERED_BY_EMPL_PTR.Value:=dm.ADO107EMPL_PTR.Value; //������Ա
     dm.ado105ENTERED_DT.Value:=strtodate(self.Edit_date.Text);      //��������
     dm.ado105ATTACHED.Value := updown1.Position;                 //��������
     dm.ado105FYEAR.Value := strtoint(self.Edit_fyear.Text);      //������
     dm.ado105PERIOD.Value := strtoint(self.Edit_PERIOD.Text);         //����ڼ�
     dm.ado105supp_PTR.Value:=dm.ADO107SUPP_PTR.value;
     post;
    end;
    for i:=1 to SGrid2.RowCount-2 do
    begin
    dm.ado106.Append;
    dm.ado106GL_HEADER_PTR.Value:=dm.ado105RKEY.Value;
    dm.ado106GL_ACCT_NO_PTR.AsString:=sgrid2.Cells[0,i];
    dm.ADO106CURR_PTR.AsString:=sgrid2.Cells[1,i];
    dm.ADO106EXCH_RATE.AsString:=
    Floattostrf(1/strtofloat(sgrid1.Cells[3,i]),ffFixed,12,8);
     { TODO -owilliam -cע������ : �ڱ���ƾ֤ʱ����Ҫ�� 1�ĵ��� }
    dm.ado106REF_NUMBER.Value:=dm.ADO107INVOICE_NO.Value;
    dm.ado106DESCRIPTION.Value:=sgrid1.Cells[0,i];
    dm.ADO106PRICE.AsString :=sgrid1.Cells[4,i]; //ԭ��
    if (trim(sgrid1.Cells[5,i])<>'') then
     begin
      dm.ado106AMOUNT.AsString:=sgrid1.Cells[5,i];
      dm.ado106D_C.Value:='D';               //�跽
     end
    else
     begin
      dm.ado106AMOUNT.AsString:=sgrid1.Cells[6,i];
      dm.ado106D_C.Value:='C';               //����
     end;
    dm.ado106.Post;
   end;
   end;

   dm.ACt.CommitTrans;
    if (self.report_Check.Checked) and (not dm.ADO105.IsEmpty)  then
    begin  //��ӡƾ֤
     form_voucherreport:=Tform_voucherreport.Create(application);
     form_voucherreport.ppReport1.Reset;
     form_voucherreport.ppReport1.Template.FileName :=
      stringReplace(GetCurrentDir,'EXEC','NIERP\REPORT\',[rfReplaceAll])+
        'VOUCHER_REPORT.rtm';    //R:\NIERP\Report\VOUCHER_REPORT.rtm
     form_voucherreport.ppReport1.Template.LoadFromFile;     
     form_voucherreport.AQD105.Close;
     form_voucherreport.AQD105.Parameters[0].Value:=dm.ADO105RKEY.Value;
     form_voucherreport.AQD105.open;
     form_voucherreport.AQD106.Open;
     form_voucherreport.AQD493.Open;
     form_voucherreport.ppReport1.Print;
     form_voucherreport.Free;
    end;
   modalresult:=mrok;
  except
   on E: Exception do
    begin
     dm.ACt.RollbackTrans;
     messagedlg(E.Message,mterror,[mbcancel],0);
     edit1.SetFocus;
    end;
  end;

 end;
end;

function TForm4.find_invoerror(number: string): boolean;
begin
 result := false;
 with dm.ADOQuery1 do
  begin
   close;
   sql.Clear;
   sql.Add('select rkey from data0107');
   sql.Add('where INVOICE_NO='''+number+'''');
   open;
   if not IsEmpty then result := true;
  end;
end;

procedure TForm4.update_04(v_seed: string);
var
 i,v_length:integer;
 v_last,new_seed:string;
begin

 v_length := length(v_seed);
 for i := v_length downto 1 do
  if (copy(v_seed,i,1)<'0') or (copy(v_seed,i,1)>'9') then  //�����������
   begin
    v_last := floattostr(power(10,v_length-1)+strtofloat(copy(v_seed,i+1,v_length-i))+1); //��׺��1
    new_seed := copy(v_seed,1,i)+copy(v_last,i+1,v_length-i);
    dm.adosp04.Edit; //ʹǰ׺�����׺��1
    dm.adosp04SEED_VALUE.Value := new_seed;
    dm.adosp04.Post;
    break;
   end
  else
   if i=1 then //�����һλ��Ȼ������
    begin
     v_last := floattostr(power(10,v_length)+strtofloat(v_seed)+1);
     new_seed := copy(v_last,2,v_length);
     dm.adosp04.Edit;
     dm.adosp04SEED_VALUE.Value := new_seed;
     dm.adosp04.Post;
    end;

end;

function Power(x, y : extended) : extended;
begin
 result := exp(y*ln(x));
end;

procedure TForm4.Edit5Exit(Sender: TObject);
begin
if trim(edit5.Text)='' then
 begin
  showmessage('����������������!');
  edit5.SetFocus;
 end
else
 if strtofloat(edit5.Text)<=0 then
  begin
   showmessage('����������������!');
   edit5.SetFocus;
  end
 else
  begin
   edit5.Text:=formatfloat('0.00000000',strtofloat(edit5.Text));
  end;
end;

procedure TForm4.PageControl1Change(Sender: TObject);
var
 i:word;
 mt_error:boolean;
begin
{ TODO -owilliam -c��� :
ƾ֤�ĵĸ������±�����·���,��һ�û�������״̬,
�ڶ��ڱ༭״̬ʱ��Ϊԭ��Ϊҵ������Ϊ��û�в���ƾ֤��
�û��޸��˷�������Ҫ�����µ�ƾ֤.
�༭ʱ����û��޸��˷�����,��ҵ���ƾ֤�����Ѿ�����,��ô
ƾ֤�ķ�������Ҫ�û������޸�,ϵͳ�������µ�ҵ���¼ }
if edit3.Text<>'' then 
if (add_edit.Caption='0') or (trim(edit_number.Text)='') then
if (strtocurr(formatfloat('0.00',strtocurr(edit6.text) * strtofloat(edit5.text)))<>
     strtocurr(RemoveInvalid(statictext2.Caption))) then
begin
 edit_date.Text:=datetostr(datetimepicker1.Date);
 edit_number.Text:=self.get_vouchernumber(datetimepicker1.Date);
 Edit_fyear.Text:=inttostr(yearof(datetimepicker1.Date));   //������
 Edit_PERIOD.Text:=inttostr(monthof(datetimepicker1.Date));  //����ڼ�
 Edit_employee.Text:=form1.empl_name.Caption;
  for i:=1 to sgrid1.RowCount-2 do
   begin
    sgrid1.Rows[i].Clear;
    sgrid2.Rows[i].Clear;
   end;
  sgrid1.RowCount:=2;
  sgrid2.RowCount:=2;
  mt_error:=true;
  dm.ADO104.Close;
  case self.ComboBox1.ItemIndex of
  0,2,4:dm.ADO104.Parameters[0].Value:=1;
  1:dm.ADO104.Parameters[0].Value:=2;
  3:dm.ADO104.Parameters[0].Value:=12;
  end;
  dm.ADO104.Open;
  if strtocurr(edit8.Text)>0 then    //����˰���
  with dm.ADOQuery1 do
   begin
    close;
    sql.Clear;
    sql.Add('SELECT Data0103.GL_ACC_NUMBER, Data0103_1.GL_DESCRIPTION,');
    sql.Add('Data0103.GL_DESCRIPTION AS DESCRIPTION,data0103.curr_tp,data0103.curr_ptr');
    sql.Add('FROM dbo.Data0103 LEFT OUTER JOIN');
    sql.Add('Data0103 Data0103_1 ON Data0103.PARENT_PTR = Data0103_1.RKEY');
    sql.Add('where Data0103.rkey='+dm.ADO104DFLT_ACCT_01.AsString);
    open;
    case fieldbyname('curr_tp').AsInteger of
      0:                 //���������
      begin
       sgrid1.Cells[2,sgrid1.RowCount-1]:= form1.curr_code.Caption;         //����
       sgrid1.Cells[3,sgrid1.RowCount-1]:='1' ;          //����
       sgrid1.Cells[4,sgrid1.RowCount-1]:=               //ԭ�ҽ��
         Formatfloat('0.00',strtocurr(edit8.Text)*strtofloat(edit5.Text));
       sgrid2.Cells[1,sgrid2.RowCount-1]:='1';
      end;
      1:               //�������
      begin
       sgrid1.Cells[2,sgrid1.RowCount-1]:=edit4.Text;       //����
       sgrid1.Cells[3,sgrid1.RowCount-1]:=edit5.Text;       //����
       sgrid1.Cells[4,sgrid1.RowCount-1]:=edit8.Text;       //ԭ�ҽ��
       sgrid2.Cells[1,sgrid2.RowCount-1]:=inttostr(self.currency_ptr)//����ָ��;
      end;
      2:             //���㵥һ���
       begin
       if fieldbyname('curr_ptr').AsInteger=self.currency_ptr then
        begin
         sgrid1.Cells[2,sgrid1.RowCount-1]:=edit4.Text;       //����
         sgrid1.Cells[3,sgrid1.RowCount-1]:=edit5.Text;      //����
         sgrid1.Cells[4,sgrid1.RowCount-1]:=edit8.Text;      //ԭ�ҽ��
         sgrid2.Cells[1,sgrid2.RowCount-1]:= inttostr(self.currency_ptr)//����ָ��;
        end
       else
        begin
         messagedlg('�Բ���Ӧ����Ϣ���������A/P��Ŀ���㵥һ���,���뷢Ʊ���Ҳ�һ��',mterror,[mbcancel],0);
         mt_error:=false;
        end;
       end;
      end;
      if mt_error then
      begin
      sgrid1.Cells[0,sgrid1.RowCount-1]:=              //ժҪ
                '['+edit3.Text+ABBR_NAME.Caption+']'+inttostr(monthof(datetimepicker1.date))+
                '�·ݲ����������-�ݹ�';

      sgrid1.Cells[1,sgrid1.RowCount-1]:=              //��Ŀ
                         trim(FieldValues['gl_acc_number'])+'-'+
                         trim(Fieldbyname('GL_DESCRIPTION').AsString)+'-'+
                         trim(FieldValues['DESCRIPTION']);
      sgrid1.Cells[5,sgrid1.RowCount-1]:=        //�跽���ҽ��
                        formatfloat('0.00',strtocurr(edit8.Text)*strtofloat(edit5.Text));
      sgrid2.Cells[0,sgrid2.RowCount-1]:=dm.ADO104DFLT_ACCT_01.AsString;
      sgrid1.RowCount:=sgrid1.RowCount+1;
      sgrid2.RowCount:=sgrid2.RowCount+1;
      end;
   end;
//==============������˰�跽���Ϸ���========================================
  mt_error:=true;
  if strtocurr(edit9.Text) > 0 then      //˰��
  with dm.ADOQuery1 do
   begin
    close;
    sql.Clear;
    sql.Add('SELECT Data0103.GL_ACC_NUMBER, Data0103_1.GL_DESCRIPTION,');
    sql.Add('Data0103.GL_DESCRIPTION AS DESCRIPTION,data0103.curr_tp,data0103.curr_ptr');
    sql.Add('FROM dbo.Data0103 LEFT OUTER JOIN');
    sql.Add('Data0103 Data0103_1 ON Data0103.PARENT_PTR = Data0103_1.RKEY');
    sql.Add('where Data0103.rkey='+dm.ADO104DFLT_ACCT_02.AsString);
    open;
    case fieldbyname('curr_tp').AsInteger of
      0:                 //���������
      begin
       sgrid1.Cells[2,sgrid1.RowCount-1]:= form1.curr_code.Caption;    //����
       sgrid1.Cells[3,sgrid1.RowCount-1]:='1' ;          //����
       sgrid1.Cells[4,sgrid1.RowCount-1]:=               //ԭ�ҽ��
         Formatfloat('0.00',strtocurr(edit9.Text)*strtofloat(edit5.Text));
       sgrid2.Cells[1,sgrid2.RowCount-1]:='1';
      end;
      1:               //�������
      begin
       sgrid1.Cells[2,sgrid1.RowCount-1]:=edit4.Text;           //����
       sgrid1.Cells[3,sgrid1.RowCount-1]:=edit5.Text;           //����
       sgrid1.Cells[4,sgrid1.RowCount-1]:=edit9.Text;      //ԭ�ҽ��
       sgrid2.Cells[1,sgrid2.RowCount-1]:=inttostr(self.currency_ptr);
      end;
      2:             //���㵥һ���
       begin
       if fieldbyname('curr_ptr').AsInteger=currency_ptr then
        begin
       sgrid1.Cells[2,sgrid1.RowCount-1]:=edit4.Text;           //����
       sgrid1.Cells[3,sgrid1.RowCount-1]:=edit5.Text;           //����
       sgrid1.Cells[4,sgrid1.RowCount-1]:=edit9.Text;         //ԭ�ҽ��
       sgrid2.Cells[1,sgrid2.RowCount-1]:=inttostr(self.currency_ptr);
        end
       else
        begin
         messagedlg('�Բ���Ӧ�����������A/P��Ŀ���㵥һ���,���뷢Ʊ���Ҳ�һ��',mterror,[mbcancel],0);
         mt_error:=false;
        end;
       end;
      end;
      if mt_error then
      begin
      sgrid1.Cells[0,sgrid1.RowCount-1]:=              //ժҪ
                '['+edit3.Text+ABBR_NAME.Caption+']'+inttostr(monthof(datetimepicker1.date))+
                '�·ݲ����������-�ݹ�';
      sgrid1.Cells[1,sgrid1.RowCount-1]:=              //��Ŀ
                         trim(FieldValues['gl_acc_number'])+'-'+
                         trim(Fieldbyname('GL_DESCRIPTION').AsString)+'-'+
                         trim(FieldValues['DESCRIPTION']);
      sgrid1.Cells[5,sgrid1.RowCount-1]:=        //�跽���ҽ��
              formatfloat('0.00',strtocurr(edit9.Text)*strtofloat(edit5.Text));
      sgrid2.Cells[0,sgrid2.RowCount-1]:=dm.ADO104DFLT_ACCT_02.AsString;
      sgrid1.RowCount:=sgrid1.RowCount+1;
      sgrid2.RowCount:=sgrid2.RowCount+1;
      end;
   end;
  //=============================����跽˰��
  mt_error:=true;
  if strtocurr(edit7.Text) > 0 then      //�������
  with dm.ADOQuery1 do
   begin
    close;
    sql.Clear;
    sql.Add('SELECT Data0103.GL_ACC_NUMBER, Data0103_1.GL_DESCRIPTION,');
    sql.Add('Data0103.GL_DESCRIPTION AS DESCRIPTION,data0103.curr_tp,data0103.curr_ptr');
    sql.Add('FROM dbo.Data0103 LEFT OUTER JOIN');
    sql.Add('Data0103 Data0103_1 ON Data0103.PARENT_PTR = Data0103_1.RKEY');
    sql.Add('where Data0103.rkey='+dm.ADO104DFLT_ACCT_04.AsString);
    open;
    case fieldbyname('curr_tp').AsInteger of
      0:                 //���������
      begin
       sgrid1.Cells[2,sgrid1.RowCount-1]:= form1.curr_code.Caption;    //����
       sgrid1.Cells[3,sgrid1.RowCount-1]:='1' ;          //����
       sgrid1.Cells[4,sgrid1.RowCount-1]:=               //ԭ�ҽ��
         Formatfloat('0.00',strtocurr(edit7.Text)*strtofloat(edit5.Text));
       sgrid2.Cells[1,sgrid2.RowCount-1]:='1';
      end;
      1:               //�������
      begin
       sgrid1.Cells[2,sgrid1.RowCount-1]:=edit4.Text;           //����
       sgrid1.Cells[3,sgrid1.RowCount-1]:=edit5.Text;           //����
       sgrid1.Cells[4,sgrid1.RowCount-1]:=edit7.Text;      //ԭ�ҽ��
       sgrid2.Cells[1,sgrid2.RowCount-1]:=inttostr(self.currency_ptr);
      end;
      2:             //���㵥һ���
       begin
       if fieldbyname('curr_ptr').AsInteger=currency_ptr then
        begin
       sgrid1.Cells[2,sgrid1.RowCount-1]:=edit4.Text;           //����
       sgrid1.Cells[3,sgrid1.RowCount-1]:=edit5.Text;           //����
       sgrid1.Cells[4,sgrid1.RowCount-1]:=edit7.Text;         //ԭ�ҽ��
       sgrid2.Cells[1,sgrid2.RowCount-1]:=inttostr(self.currency_ptr);
        end
       else
        begin
         messagedlg('�Բ���Ӧ�����������A/P��Ŀ���㵥һ���,���뷢Ʊ���Ҳ�һ��',mterror,[mbcancel],0);
         mt_error:=false;
        end;
       end;
      end;
      if mt_error then
      begin
      sgrid1.Cells[0,sgrid1.RowCount-1]:=              //ժҪ
                '['+edit3.Text+ABBR_NAME.Caption+']'+inttostr(monthof(datetimepicker1.date))+
                '�·ݲ����������-�ݹ�';
      sgrid1.Cells[1,sgrid1.RowCount-1]:=              //��Ŀ
                         trim(FieldValues['gl_acc_number'])+'-'+
                         trim(Fieldbyname('GL_DESCRIPTION').AsString)+'-'+
                         trim(FieldValues['DESCRIPTION']);
      sgrid1.Cells[5,sgrid1.RowCount-1]:=        //�跽���ҽ��
              formatfloat('0.00',strtocurr(edit7.Text)*strtofloat(edit5.Text));
      sgrid2.Cells[0,sgrid2.RowCount-1]:=dm.ADO104DFLT_ACCT_04.AsString;
      sgrid1.RowCount:=sgrid1.RowCount+1;
      sgrid2.RowCount:=sgrid2.RowCount+1;
      end;
   end;
  //=============================����跽�������
  mt_error:=true;
  if strtocurr(edit6.Text) > 0 then      //�ܼƽ��
  with dm.ADOQuery1 do
   begin
    close;
    sql.Clear;
    sql.Add('SELECT Data0103.GL_ACC_NUMBER, Data0103_1.GL_DESCRIPTION,');
    sql.Add('Data0103.GL_DESCRIPTION AS DESCRIPTION,data0103.curr_tp,data0103.curr_ptr');
    sql.Add('FROM dbo.Data0103 LEFT OUTER JOIN');
    sql.Add('Data0103 Data0103_1 ON Data0103.PARENT_PTR = Data0103_1.RKEY');
    if self.acc_gl_ptr>0 then
     sql.Add('where Data0103.rkey='+inttostr(acc_gl_ptr))
    else
     sql.Add('where Data0103.rkey='+dm.ADO104DFLT_ACCT_05.AsString);
    open;
    case fieldbyname('curr_tp').AsInteger of
      0:                 //���������
      begin
       sgrid1.Cells[2,sgrid1.RowCount-1]:= form1.curr_code.Caption;    //����
       sgrid1.Cells[3,sgrid1.RowCount-1]:='1' ;          //����
       sgrid1.Cells[4,sgrid1.RowCount-1]:=               //ԭ�ҽ��
         Formatfloat('0.00',strtocurr(edit6.Text)*strtofloat(edit5.Text));
       sgrid2.Cells[1,sgrid2.RowCount-1]:='1';
      end;
      1:               //�������
      begin
       sgrid1.Cells[2,sgrid1.RowCount-1]:=edit4.Text;           //����
       sgrid1.Cells[3,sgrid1.RowCount-1]:=edit5.Text;           //����
       sgrid1.Cells[4,sgrid1.RowCount-1]:=edit6.Text;      //ԭ�ҽ��
       sgrid2.Cells[1,sgrid2.RowCount-1]:=inttostr(self.currency_ptr);
      end;
      2:             //���㵥һ���
       begin
       if fieldbyname('curr_ptr').AsInteger=currency_ptr then
        begin
       sgrid1.Cells[2,sgrid1.RowCount-1]:=edit4.Text;           //����
       sgrid1.Cells[3,sgrid1.RowCount-1]:=edit5.Text;           //����
       sgrid1.Cells[4,sgrid1.RowCount-1]:=edit6.Text;         //ԭ�ҽ��
       sgrid2.Cells[1,sgrid2.RowCount-1]:=inttostr(self.currency_ptr);
        end
       else
        begin
         messagedlg('�Բ���Ӧ�����������A/P��Ŀ���㵥һ���,���뷢Ʊ���Ҳ�һ��',mterror,[mbcancel],0);
         mt_error:=false;
        end;
       end;
      end;
    if mt_error then
     begin
      sgrid1.Cells[0,sgrid1.RowCount-1]:=              //ժҪ
                '['+edit3.Text+ABBR_NAME.Caption+']'+inttostr(monthof(datetimepicker1.date))+
                '�·ݲ����������-�ݹ�';
      sgrid1.Cells[1,sgrid1.RowCount-1]:=              //��Ŀ
                         trim(FieldValues['gl_acc_number'])+'-'+
                         trim(Fieldbyname('GL_DESCRIPTION').AsString)+'-'+
                         trim(FieldValues['DESCRIPTION']);

      sgrid1.Cells[6,sgrid1.RowCount-1]:=        //�������ҽ��
              formatfloat('0.00',strtocurr(edit6.Text)*strtofloat(edit5.Text));

      if self.acc_gl_ptr>0 then
       sgrid2.Cells[0,sgrid2.RowCount-1]:=inttostr(acc_gl_ptr)
      else
       sgrid2.Cells[0,sgrid2.RowCount-1]:=dm.ADO104DFLT_ACCT_05.AsString;
      sgrid1.RowCount:=sgrid1.RowCount+1;
      sgrid2.RowCount:=sgrid2.RowCount+1;
     end;
   end;
  //=============================��������ܼƽ��

 self.re_calculate;
if sgrid1.RowCount=2 then
 begin
  speedbutton3.Enabled:=false;
  speedbutton4.Enabled:=false;
  speedbutton5.Enabled:=false;
  speedbutton6.Enabled:=false;
  speedbutton7.Enabled:=false;
  speedbutton8.Enabled:=false;
 end
else
 begin
  speedbutton3.Enabled:=true;
  speedbutton4.Enabled:=true;
  speedbutton5.Enabled:=true;
  speedbutton6.Enabled:=true;
  speedbutton7.Enabled:=true;
  speedbutton8.Enabled:=true;
 end;

end
end;

procedure TForm4.N4Click(Sender: TObject);
begin
try
 form_acct:=tform_acct.Create(application);
 if form_acct.ShowModal=mrok then
  if self.find_accterror(form_acct.ADOQuery1RKEY.Value) then
   messagedlg('�ÿ�Ŀ�������ֽ��ʻ�,������ת��ƾ֤��ѡȡ!',mtinformation,[mbok],0)
  else
  try
   form_curr:=tform_curr.Create(application);
   if form_curr.ShowModal=mrok then
    begin
     if (form_acct.ADOQuery1curr_tp.Value=0) and
        (form_curr.ADOQuery1rkey.Value>1) then
      messagedlg('��Ŀ������������',mterror,[mbcancel],0)
     else
      if (form_acct.ADOQuery1curr_tp.Value=2) and
         (form_acct.ADOQuery1curr_ptr.Value<>form_curr.ADOQuery1rkey.Value) then
       messagedlg('��Ŀ���㵥һ���,������ѡ�����Ҳ�һ��',mterror,[mbcancel],0)
      else
       begin
        sgrid1.Cells[0,sgrid1.RowCount-1]:=              //ժҪ
                  sgrid1.Cells[0,sgrid1.RowCount-2];

        sgrid1.Cells[1,sgrid1.RowCount-1]:=              //��Ŀ
                         trim(form_acct.ADOQuery1GL_ACC_NUMBER.Value)+'-'+
                         trim(form_acct.ADOQuery1GL_DESCRIPTION.Value)+'-'+
                         trim(form_acct.ADOQuery1DESCRIPTION_2.Value);
        sgrid1.Cells[2,sgrid1.RowCount-1]:=form_curr.ADOQuery1curr_code.Value;
        if currency_ptr=form_curr.ADOQuery1rkey.Value then
        sgrid1.Cells[3,sgrid1.RowCount-1]:=edit5.Text
        else
         sgrid1.Cells[3,sgrid1.RowCount-1]:=form_curr.ADOQuery1BASE_TO_OTHER.AsString;
        sgrid2.Cells[0,sgrid2.RowCount-1]:=form_acct.ADOQuery1rkey.AsString;
        sgrid2.Cells[1,sgrid2.RowCount-1]:=form_curr.ADOQuery1rkey.AsString;
        sgrid1.RowCount:=sgrid1.RowCount+1;
        sgrid2.RowCount:=sgrid2.RowCount+1;
        if sgrid1.RowCount=3 then
         begin
          speedbutton3.Enabled:=true;
          speedbutton4.Enabled:=true;
          speedbutton5.Enabled:=true;
          speedbutton6.Enabled:=true;
          speedbutton7.Enabled:=true;
          speedbutton8.Enabled:=true;
         end;
       end;
    end;
  finally
   form_curr.Free;
  end;
finally
 form_acct.Free;
end;
end;

procedure TForm4.N5Click(Sender: TObject);
begin
try
 form_acct:=tform_acct.Create(application);
 if form_acct.ShowModal=mrok then
  begin
   if (form_acct.ADOQuery1curr_tp.Value=0) and
      (strtoint(sgrid2.Cells[1,sgrid1.Row])>1) then
    messagedlg('��Ŀ������������',mterror,[mbcancel],0)
   else
    if (form_acct.ADOQuery1curr_tp.Value=2) and
       (form_acct.ADOQuery1curr_ptr.Value<>strtoint(sgrid2.Cells[1,sgrid1.Row])) then
     messagedlg('��Ŀ���㵥һ���,������ѡ�����Ҳ�һ��',mterror,[mbcancel],0)
    else
     begin
      sgrid1.Cells[1,sgrid1.Row]:=              //��Ŀ
                         trim(form_acct.ADOQuery1GL_ACC_NUMBER.Value)+'-'+
                         trim(form_acct.ADOQuery1GL_DESCRIPTION.Value)+'-'+
                         trim(form_acct.ADOQuery1DESCRIPTION_2.Value);
      sgrid2.Cells[0,sgrid1.Row]:=form_acct.ADOQuery1rkey.AsString;
     end;
  end;
finally
 form_acct.Free;
end;
end;

procedure TForm4.N11Click(Sender: TObject);
begin
try
 form_curr:=tform_curr.Create(application);
 if form_curr.ShowModal=mrok then
  begin
   if (self.get_gltp(trim(sgrid2.Cells[0,sgrid1.row]))=0) and
      (form_curr.ADOQuery1rkey.Value>1) then
    messagedlg('��Ŀ������������',mterror,[mbcancel],0)
   else
    if (self.get_gltp(trim(sgrid2.Cells[0,sgrid1.row]))=2) and   //��һ���
       (self.get_glcurr_ptr(trim(sgrid2.Cells[0,sgrid1.row]))<>
       form_curr.ADOQuery1rkey.Value) then
     messagedlg('��Ŀ���㵥һ���,������ѡ�����Ҳ�һ��',mterror,[mbcancel],0)
    else
     begin
      sgrid1.Cells[2,sgrid1.Row]:=form_curr.ADOQuery1curr_code.Value;   //����
      if currency_ptr=form_curr.ADOQuery1rkey.Value then
       sgrid1.Cells[3,sgrid1.Row]:=edit5.Text
      else
       sgrid1.Cells[3,sgrid1.Row]:=
                             form_curr.ADOQuery1BASE_TO_OTHER.AsString;
      sgrid2.Cells[1,sgrid1.Row]:=form_curr.ADOQuery1rkey.AsString;
     if trim(sgrid1.Cells[6,sgrid1.Row])<>'' then
      sgrid1.Cells[6,sgrid1.Row]:=formatfloat('0.00',strtocurr(sgrid1.Cells[4,sgrid1.row])*
                                                   strtofloat(sgrid1.Cells[3,sgrid1.row]))
     else
      sgrid1.Cells[5,sgrid1.Row]:=formatfloat('0.00',strtocurr(sgrid1.Cells[4,sgrid1.row])*
                                                   strtofloat(sgrid1.Cells[3,sgrid1.row]));
      self.re_calculate;
     end;
  end;
finally
 form_curr.Free;
end;
end;

procedure TForm4.N7Click(Sender: TObject);
var
 i:word;
begin
 for i:=sgrid1.Row to sgrid1.RowCount-2 do
  begin
   sgrid1.Rows[i]:=sgrid1.Rows[i+1];
   sgrid2.Rows[i]:=sgrid2.Rows[i+1];
  end;
 sgrid1.RowCount:=sgrid1.RowCount-1;
 sgrid2.RowCount:=sgrid2.RowCount-1;
if sgrid1.Row=sgrid1.RowCount-1 then
 begin
  speedbutton3.Enabled:=false;
  speedbutton4.Enabled:=false;
  speedbutton5.Enabled:=false;
  speedbutton6.Enabled:=false;
  speedbutton7.Enabled:=false;
  speedbutton8.Enabled:=false;
 end;
self.re_calculate;
end;

procedure TForm4.N8Click(Sender: TObject);
begin
try
form_dictionary:=Tform_dictionary.Create(application);
if form_dictionary.ShowModal=mrok then
 sgrid1.Cells[0,sgrid1.Row]:=form_dictionary.aq513DSDesigner2.Value;
finally
form_dictionary.Free;
end;
end;

procedure TForm4.N9Click(Sender: TObject);
begin
if (sgrid1.Row<>1) and (sgrid1.Row<>sgrid1.RowCount-1) then
 sgrid1.Cells[0,sgrid1.Row]:=sgrid1.Cells[0,sgrid1.Row-1];
end;

procedure TForm4.SpeedButton9Click(Sender: TObject);
begin
if warehouse_ptr>0 then  //����
 begin
  edit_number.Text:=self.get_vouchernumber(strtodate(Edit_date.Text));
  edit_fyear.Text:=inttostr(yearof(strtodate(Edit_date.Text)));
  edit_period.Text:=inttostr(monthof(strtodate(Edit_date.Text)));
 end
else
 messagedlg('�༭״̬�²����޸�ƾ֤���!',mterror,[mbcancel],0);
end;

procedure TForm4.Edit_dateExit(Sender: TObject);
begin
try
 strtodate(Edit_date.Text);
except
 messagedlg('���ڸ�ʽ��������!',mterror,[mbcancel],0);
 Edit_date.SetFocus;
 exit;
end;
if add_edit.Caption='0' then  //����
 begin
  edit_number.Text:=self.get_vouchernumber(strtodate(Edit_date.Text));
  edit_fyear.Text:=inttostr(yearof(strtodate(Edit_date.Text)));
  edit_period.Text:=inttostr(monthof(strtodate(Edit_date.Text)));
 end;
end;

procedure TForm4.Edit_dateKeyPress(Sender: TObject; var Key: Char);
begin
 if not (key in ['0'..'9','-',#8,#13]) then  //�ж��Ƿ���������
  abort
end;

procedure TForm4.SGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
begin
if (acol>3) then
 Sgrid1.Canvas.TextRect(rect,rect.right-Sgrid1.Canvas.TextWidth(Sgrid1.Cells[acol,arow])
                 -2,rect.Top+2, Sgrid1.Cells[acol,aRow]);
end;

procedure TForm4.SGrid1Exit(Sender: TObject);
begin
if (sgrid1.col>3) and (sgrid1.row<>sgrid1.RowCount-1) then
 begin
  if trim(sgrid1.Cells[4,sgrid1.row])='' then
   sgrid1.Cells[4,sgrid1.row]:='0';
  if sgrid1.col=5 then
  if (trim(sgrid1.Cells[5,sgrid1.row])='') and
     (trim(sgrid1.Cells[6,sgrid1.row])='') then
   sgrid1.Cells[5,sgrid1.row]:='0';

  if sgrid1.col=6 then
  if (trim(sgrid1.Cells[5,sgrid1.row])='') and
     (trim(sgrid1.Cells[6,sgrid1.row])='') then
   sgrid1.Cells[6,sgrid1.row]:='0';

  if trim(sgrid1.Cells[sgrid1.col,sgrid1.row])<>'' then
  begin
   sgrid1.Cells[sgrid1.col,sgrid1.row]:=formatfloat('0.00',
   strtofloat(sgrid1.Cells[sgrid1.col,sgrid1.row]));

    case sgrid1.Col of
    5:      //�跽
     begin
      sgrid1.Cells[6,sgrid1.Row]:='';
      sgrid1.Cells[4,sgrid1.Row]:=formatfloat('0.00',strtocurr(sgrid1.Cells[sgrid1.col,sgrid1.row])/
                                                     strtofloat(sgrid1.Cells[3,sgrid1.row]) );
     end;
    6:       //����
     begin
      sgrid1.Cells[5,sgrid1.Row]:='';
      sgrid1.Cells[4,sgrid1.Row]:=formatfloat('0.00',strtocurr(sgrid1.Cells[sgrid1.col,sgrid1.row])/
                                                     strtofloat(sgrid1.Cells[3,sgrid1.row]) );
     end;
    4:   //ԭ��
     begin
      if trim(sgrid1.Cells[6,sgrid1.Row])<>'' then
       sgrid1.Cells[6,sgrid1.Row]:=formatfloat('0.00',strtocurr(sgrid1.Cells[sgrid1.col,sgrid1.row])*
                                                     strtofloat(sgrid1.Cells[3,sgrid1.row]))
      else
       sgrid1.Cells[5,sgrid1.Row]:=formatfloat('0.00',strtocurr(sgrid1.Cells[sgrid1.col,sgrid1.row])*
                                                     strtofloat(sgrid1.Cells[3,sgrid1.row]));
     end;
    end;
    self.re_calculate;
  end;
 end;
  SGrid1.Col:=0;
end;

procedure TForm4.SGrid1KeyPress(Sender: TObject; var Key: Char);
begin
if sgrid1.Col<>0 then
 if not (key in ['0'..'9','.','-',#8]) then  //�ж��Ƿ���������
  abort
 else
  if key = chr(46) then      //�ж��Ƿ��ظ�����С����'.'
   if pos('.',sgrid1.Cells[sgrid1.col,sgrid1.row])>0  then abort;
end;

procedure TForm4.SGrid1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
 column,row:longint;//�Ҽ�ѡ��stringgrid�ؼ��ķ���
begin
if button=mbright then
 begin
   sgrid1.MouseToCell(x,y,column,row);
   if row<>0 then sgrid1.Row:=row;
   sgrid1.Col:=column;
 end;
end;

procedure TForm4.SGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
if arow=sgrid1.RowCount-1 then
 begin
  speedbutton3.Enabled:=false;
  speedbutton4.Enabled:=false;
  speedbutton5.Enabled:=false;
  speedbutton6.Enabled:=false;
  speedbutton7.Enabled:=false;
  speedbutton8.Enabled:=false;
 end
else
 begin
  speedbutton3.Enabled:=true;
  speedbutton4.Enabled:=true;
  speedbutton5.Enabled:=true;
  speedbutton6.Enabled:=true;
  speedbutton7.Enabled:=true;
  speedbutton8.Enabled:=true;
 end;

 if (acol=1) or (acol=2) or (acol=3) or (arow=sgrid1.RowCount-1) then
  sgrid1.Options:=sgrid1.Options-[goEditing]
 else
  sgrid1.Options:=sgrid1.Options+[goEditing];

if (sgrid1.col > 3) and (sgrid1.row<>sgrid1.RowCount-1) then
 begin
  if trim(sgrid1.Cells[4,sgrid1.row])='' then
   sgrid1.Cells[4,sgrid1.row]:='0';
  if sgrid1.col=5 then
  if (trim(sgrid1.Cells[5,sgrid1.row])='') and
     (trim(sgrid1.Cells[6,sgrid1.row])='') then
   sgrid1.Cells[5,sgrid1.row]:='0';
  if sgrid1.col=6 then
  if (trim(sgrid1.Cells[5,sgrid1.row])='') and
     (trim(sgrid1.Cells[6,sgrid1.row])='') then
   sgrid1.Cells[6,sgrid1.row]:='0';

if trim(sgrid1.Cells[sgrid1.col,sgrid1.row])<>'' then
 begin
  sgrid1.Cells[sgrid1.col,sgrid1.row]:=formatfloat('0.00',
  strtofloat(sgrid1.Cells[sgrid1.col,sgrid1.row]));

  case sgrid1.Col of
  5:      //�跽
   begin
    sgrid1.Cells[6,sgrid1.Row]:='';
    sgrid1.Cells[4,sgrid1.Row]:=formatfloat('0.00',strtocurr(sgrid1.Cells[sgrid1.col,sgrid1.row])/
                                                   strtofloat(sgrid1.Cells[3,sgrid1.row]) );
   end;
  6:       //����
   begin
    sgrid1.Cells[5,sgrid1.Row]:='';
    sgrid1.Cells[4,sgrid1.Row]:=formatfloat('0.00',strtocurr(sgrid1.Cells[sgrid1.col,sgrid1.row])/
                                                   strtofloat(sgrid1.Cells[3,sgrid1.row]) );
   end;
  4:   //ԭ��
   begin
    if trim(sgrid1.Cells[6,sgrid1.Row])<>'' then
     sgrid1.Cells[6,sgrid1.Row]:=formatfloat('0.00',strtocurr(sgrid1.Cells[sgrid1.col,sgrid1.row])*
                                                   strtofloat(sgrid1.Cells[3,sgrid1.row]))
    else
     sgrid1.Cells[5,sgrid1.Row]:=formatfloat('0.00',strtocurr(sgrid1.Cells[sgrid1.col,sgrid1.row])*
                                                   strtofloat(sgrid1.Cells[3,sgrid1.row]));
   end;
  end;
  self.re_calculate;
 end;
 end;
end;

procedure TForm4.PopupMenu3Popup(Sender: TObject);
begin
if sgrid1.Row=sgrid1.RowCount-1  then
 begin
  n5.Enabled:=false;
  n7.Enabled:=false;
  n8.Enabled:=false;
  n9.Enabled:=false;
  n11.Enabled:=false;
 end
else
 begin
  n5.Enabled:=true;
  n7.Enabled:=true;
  n8.Enabled:=true;
  n9.Enabled:=true;
  n11.Enabled:=true;
 end;
end;

procedure TForm4.SGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
 v_c:currency;
begin
if key=13 then    //�û�����F11��,���ҶԵ�
 begin
  if sgrid1.Row<> sgrid1.RowCount-1 then
  begin
   if (sgrid1.Col=5) and (sgrid1.Cells[6,sgrid1.Row]<>'') then
    begin
    sgrid1.Cells[5,sgrid1.Row]:=sgrid1.Cells[6,sgrid1.Row];
    sgrid1.Cells[6,sgrid1.Row]:='';
    end;
   if (sgrid1.Col=6) and (sgrid1.Cells[5,sgrid1.Row]<>'') then
    begin
    sgrid1.Cells[6,sgrid1.Row]:=sgrid1.Cells[5,sgrid1.Row];
    sgrid1.Cells[5,sgrid1.Row]:='';
    end;

  self.re_calculate;
  end;
 end;

if key=187 then    //�û�����F12��,�Զ�����
 begin
  if sgrid1.Row <> sgrid1.RowCount-1 then
  begin

   if (sgrid1.Col=5) and (sgrid1.Cells[6,sgrid1.Row]='') then
   begin
    v_c:=strtocurr(RemoveInvalid(statictext2.Caption))-get_col5(sgrid1.Row);
    if v_c <> 0 then
     sgrid1.Cells[5,sgrid1.Row]:=formatfloat('0.00',v_c);
   end;

   if (sgrid1.Col=6) and (sgrid1.Cells[5,sgrid1.Row]='') then
   begin
    v_c:=strtocurr(RemoveInvalid(statictext1.Caption))-get_col6(sgrid1.Row);
    if v_c <> 0 then
    sgrid1.Cells[6,sgrid1.Row]:=formatfloat('0.00',v_c);
   end;

   self.re_calculate;
  end;
 end;

end;

end.
