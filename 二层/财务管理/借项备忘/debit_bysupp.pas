unit debit_bysupp;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Buttons, Grids, ExtCtrls, ToolWin, Menus,math,
  DateUtils;

type
  TForm2 = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn4: TBitBtn;
    a_or_e: TLabel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label10: TLabel;
    label11: TLabel;
    Label21: TLabel;
    Label14: TLabel;
    Label3: TLabel;
    Edit3: TEdit;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit4: TEdit;
    edit5: TEdit;
    dtpk1: TDateTimePicker;
    Edit6: TEdit;
    BitBtn2: TBitBtn;
    BitBtn5: TBitBtn;
    Edit15: TEdit;
    Edit8: TEdit;
    BitBtn3: TBitBtn;
    ComboBox1: TComboBox;
    Label8: TLabel;
    Label9: TLabel;
    Label12: TLabel;
    Edit7: TEdit;
    Edit9: TEdit;
    Edit10: TEdit;
    abbr_name: TLabel;
    ToolBar1: TToolBar;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    SpeedButton8: TSpeedButton;
    SpeedButton9: TSpeedButton;
    Label25: TLabel;
    Label13: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label26: TLabel;
    Edit_ATTACHED: TEdit;
    Edit_date: TEdit;
    Edit_fyear: TEdit;
    Edit_number: TEdit;
    Edit_PERIOD: TEdit;
    report_Check: TCheckBox;
    UpDown1: TUpDown;
    Panel1: TPanel;
    Label27: TLabel;
    Label28: TLabel;
    Edit_employee: TEdit;
    StaticText1: TStaticText;
    StaticText2: TStaticText;
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
    Label15: TLabel;
    Label16: TLabel;
    dtpk2: TDateTimePicker;
    Label17: TLabel;
    Edit11: TEdit;
    BitBtn6: TBitBtn;
    Label18: TLabel;
    procedure Edit8KeyPress(Sender: TObject; var Key: Char);
    procedure FormActivate(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn1Enter(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    function find_error(number:string):boolean;
    procedure update_04(v_seed: string);
    procedure Edit6Exit(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N11Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure N9Click(Sender: TObject);
    procedure SpeedButton9Click(Sender: TObject);
    procedure Edit_dateKeyPress(Sender: TObject; var Key: Char);
    procedure Edit_dateExit(Sender: TObject);
    procedure SGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure SGrid1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure SGrid1Exit(Sender: TObject);
    procedure SGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure Edit9Exit(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure PopupMenu3Popup(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
  private
    { Private declarations }
   check_ptr,supp_ptr,curr_ptr,accsupp_gl_ptr:integer;
   function get_col5(row:integer):currency;
   function get_col6(row:integer):currency;   
   procedure re_calculate;
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

uses datamd, curr_search, main, supplier_search, AcctSearch,
  voucher_dictionary, voucher_report,common,Pick_Item_Single,ConstVar;

{$R *.dfm}
function TForm2.get_col5(row: integer): currency;
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

function TForm2.get_col6(row: integer): currency;
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

procedure TForm2.re_calculate;
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


procedure TForm2.update_04(v_seed: string);
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

function tform2.find_error(number:string):boolean;
begin
 result := false;
 with dm.ADOQuery1 do
  begin
   close;
   sql.Clear;
   sql.Add('select rkey from data0132');
   sql.Add('where MEMO_NUMBER='''+number+'''');
   open;
   if not IsEmpty then result := true;
  end;
end;

procedure TForm2.Edit8KeyPress(Sender: TObject; var Key: Char);
begin
 if not (key in ['0'..'9','.',#8,#13]) then  //�ж��Ƿ���������
  abort
 else
  if key = chr(46) then      //�ж��Ƿ��ظ�����С����'.'
   if pos('.',(sender as tedit).Text)>0  then abort;
end;

procedure TForm2.FormActivate(Sender: TObject);
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

if self.a_or_e.Caption='0' then
 begin
  dm.ADOsp04.Close;
  dm.ADOsp04.Open;
  if dm.ADOsp04SEED_FLAG.Value<>1 then
   edit1.Text:=dm.ADOsp04SEED_VALUE.Value;
  if dm.ADOsp04SEED_FLAG.Value=4 then
   edit1.ReadOnly:=true;
 end
else       //�༭
 begin
  dm.ADO132.Close;
  dm.ADO132.Parameters[0].Value:=dm.aq132rkey.Value;
  dm.ADO132.Open;
  if dm.aq132MEMO_TP.Value=4 then
  with dm.ADOQuery1 do
   begin
    close;
    sql.Clear;
    sql.Add('select CHECK_NUMBER from data0129');
    sql.Add('where rkey='+dm.ado132srce_ptr.AsString);
    open;
    edit2.Text:=fieldvalues['CHECK_NUMBER'];
    check_ptr:=dm.ado132srce_ptr.Value;
   end
  else
   begin
    self.supp_ptr:=dm.aq132SUPP_PTR.Value;
    self.curr_ptr:=dm.aq132CURRENCY_PTR.Value;
    self.accsupp_gl_ptr:=dm.aq132ACC_PAYABLE_PTR.Value;
    if a_or_e.Caption='1' then       //��ʶ�༭
    if self.curr_ptr=1 then
     edit6.Enabled:=false
    else
     edit6.Enabled:=true;
   end;
  dm.Aqd105.Close;
  dm.Aqd105.Parameters[0].Value:=dm.AQ132rkey105.Value;
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
    if dm.Aqd106EXCH_RATE.Value>0 then
     sgrid1.Cells[3,i]:=formatfloat('0.00000000',1/dm.Aqd106EXCH_RATE.Value)
    else
     sgrid1.Cells[3,i]:='0.00';

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

  dm.ADOsp04.Close;
  dm.ADOsp04.Open;
  if dm.ADOsp04SEED_FLAG.Value=4 then
   edit1.ReadOnly:=true;
 end;//�����༭���

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
 PageControl1.ActivePageIndex:=0;

end;

procedure TForm2.BitBtn5Click(Sender: TObject);
begin
try
form_supp:=tform_supp.Create(application);
form_supp.Edit1.Text:=edit4.Text;
if form_supp.ShowModal=mrok then
 begin
 if supp_ptr<>form_supp.ADOdata0023RKEY.Value then
  begin
   edit4.Text:=form_supp.ADOdata0023CODE.Value;
   label10.Caption:=form_supp.ADOdata0023SUPPLIER_NAME.Value;
   self.supp_ptr:=form_supp.ADOdata0023RKEY.Value;
   edit5.Text:=form_supp.ADOData0023curr_code.Value;
   label11.Caption:=form_supp.ADOData0023curr_name.Value;
   self.curr_ptr:=form_supp.ADOData0023currency_ptr.Value;
   edit6.Text:=form_supp.ADOData0023BASE_TO_OTHER.AsString;
   abbr_name.Caption:=form_supp.ADOData0023abbr_name.Value;
   accsupp_gl_ptr:=form_supp.ADOData0023ACC_PAYABLE_PTR.Value;
   edit9.SetFocus;
   if self.curr_ptr=1 then
    edit6.Enabled:=false
   else
    edit6.Enabled:=true;
  end;
 end;
finally
form_supp.Free;
end;
end;

procedure TForm2.BitBtn3Click(Sender: TObject);
begin
form_curr:=tform_curr.Create(application);
if form_curr.ShowModal=mrok then
 begin
  if curr_ptr<>form_curr.ADOQuery1RKEY.Value then
   begin
     edit5.Text:=form_curr.ADOQuery1curr_code.Value;
     label11.Caption:=form_curr.ADOQuery1curr_name.Value;
     self.curr_ptr:=form_curr.ADOQuery1rkey.Value;
     edit6.Text:=form_curr.ADOQuery1BASE_TO_OTHER.AsString;
     if self.curr_ptr=1 then
      edit6.Enabled:=false
     else
      edit6.Enabled:=true;
   end;
 end;
form_curr.Free;
end;

procedure TForm2.BitBtn1Enter(Sender: TObject);
begin
if trim(edit11.Text)='' then
 begin
  showmessage('����������Ϊ��!');
  self.PageControl1.ActivePageIndex:=0;
  bitbtn6.SetFocus;
  exit;
 end;
if trim(edit1.Text)='' then
 begin
  showmessage('������Ų�����Ϊ��!');
  self.PageControl1.ActivePageIndex:=0;
  edit1.SetFocus;
  exit;
 end;

if not dm.ADOsp04.Active then dm.ADOsp04.Open;
if dm.ADOsp04SEED_FLAG.Value<>1 then
if not (edit1.Text[length(trim(edit1.Text))] in ['0'..'9']) then
 begin
  messagedlg('����������һλ������һ������!',mtinformation,[mbok],0);
  self.PageControl1.ActivePageIndex:=0;
  edit1.SetFocus;
  exit;
 end;

if strtofloat(edit8.Text)-strtofloat(edit3.Text) < 0 then
 begin
  showmessage('�ý�����ѱ�ʹ��,�����������'+edit3.Text);
  pagecontrol1.ActivePageIndex:=0;
  edit9.SetFocus;  
  exit;
 end;

if strtofloat(edit8.Text)=0 then
 begin
  showmessage('���������������');
  self.PageControl1.ActivePageIndex:=0;
  edit8.SetFocus;
  exit;
 end;

if (combobox1.ItemIndex=2) and (trim(edit2.Text)='') then
 begin                                          //Ԥ������
  showmessage('Ԥ��֧Ʊ������Ϊ��!');
  self.PageControl1.ActivePageIndex:=0;
  bitbtn2.SetFocus;
  exit;
 end
else
if trim(edit4.Text)='' then
 begin
  showmessage('��Ӧ�̲�����Ϊ��!');
  self.PageControl1.ActivePageIndex:=0;
  bitbtn5.SetFocus;
  exit;
 end;

 self.PageControl1Change(sender);
if sgrid1.RowCount>2 then
 begin
  if strtocurr(form1.RemoveInvalid(statictext1.Caption))<>
     strtocurr(form1.RemoveInvalid(statictext2.Caption)) then
   begin
    messagedlg('��Ŀ���˫����һ��!',mterror,[mbcancel],0);
    self.PageControl1.ActivePageIndex:=1;
    sgrid1.SetFocus;
    exit;
   end;

{  if strtocurr(formatfloat('0.00',strtocurr(edit8.Text)*
                                  strtocurr(edit6.Text)
                          ))<>
     strtocurr(form1.RemoveInvalid(statictext1.Caption)) then
   begin
    messagedlg('��Ŀ��������뷢Ʊ�����һ��!',mterror,[mbcancel],0);
    self.PageControl1.ActivePageIndex:=1;
    sgrid1.SetFocus;
    exit;
   end;
}
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
    messagedlg('ƾ֤�ڼ䲻����ƾ֤���ڵĻ���ڼ����޸�!',mterror,[mbcancel],0);
    self.PageControl1.ActivePageIndex:=1;
    edit_date.SetFocus;
    exit;
   end;
 end;

end;

procedure TForm2.BitBtn1Click(Sender: TObject);
var
 i:integer;
begin
if self.a_or_e.Caption='0' then  //����
begin
if self.find_error(trim(edit1.Text)) then
 begin
  dm.adosp04.close;
  dm.adosp04.Open;
  if dm.ADOsp04SEED_FLAG.Value<>1 then
  if messagedlg('��������ظ������ж�̨�����ͬʱ����,�Ƿ��Զ����±��Ϊ:'+
   dm.ADOsp04SEED_VALUE.Value,mtConfirmation,[mbYes,mbNo],0)=mrYes  then
   edit1.Text:=dm.ADOsp04SEED_VALUE.Value
  else
   begin
    pagecontrol1.ActivePageIndex:=0;
    edit1.SetFocus;
    exit;
   end
  else
   begin
    messagedlg('��������ظ����ֹ���������',mtinformation,[mbok],0);
    pagecontrol1.ActivePageIndex:=0;
    edit1.SetFocus;
    exit;
   end;
 end;

 if (sgrid1.RowCount>2) and
    (form1.vo_number(trim(self.Edit_number.Text))) then
  begin
   Edit_number.Text:=form1.get_vouchernumber(strtodate(self.Edit_date.Text));
   messagedlg('ƾ֤����ظ����ܶ���ͬʱ����,ϵͳ���Զ����±��!'+edit_number.Text,mterror,[mbcancel],0);
  end;

 dm.ACt.BeginTrans;
 try
   dm.ADO132.Close;
   dm.ADO132.Parameters[0].Value:=null;
   dm.ADO132.Open;
   dm.ADO132.Append;
   dm.ADO132MEMO_NUMBER.Value:=trim(edit1.Text);
   dm.ADO132SUPP_PTR.Value:=self.supp_ptr;
   dm.ADO132SRCE_PTR.Value:=self.supp_ptr;
   dm.ADO132warehouse_PTR.Value:=Edit11.Tag;

   dm.ADO132MEMO_TP.Value:=2;   //����
   dm.ADO132EMPL_PTR.Value:=strtoint(user_ptr);
   dm.ADO132MEMO_DATE.Value:=self.dtpk1.Date;
   dm.ADO132ENT_DATE.Value:=self.dtpk2.Date;
   dm.ADO132AMOUNT.Value:=strtofloat(edit8.Text);
   dm.ADO132AVL_AMT.Value:=dm.ADO132AMOUNT.Value;
   dm.ADO132CURRENCY_PTR.Value:=self.curr_ptr;
   dm.ADO132EX_RATE.Value:=strtofloat(edit6.Text);
   dm.ADO132MATL_TOT.Value:=strtofloat(edit9.Text);   //���ֵ
   dm.ADO132FED_TAX.Value:=strtofloat(edit10.Text);    //˰��
   dm.ADO132MISC_TOT.Value:=strtofloat(edit7.Text);   //�������
   dm.ADO132REF_NUMBER.Value:=edit15.Text;
   dm.ADO132.Post;

   dm.adosp04.Close;
   dm.adosp04.Open;
   if dm.adosp04SEED_FLAG.Value<>1 then
   self.update_04(dm.ADOsp04SEED_VALUE.Value);

  if sgrid1.RowCount>2 then
   begin
    dm.ADO104.Close;
    dm.ADO104.Open;

    with dm.ado105 do                                        //���ӻ��ƾ֤�ܱ�
    begin
     close;
     dm.ado105.Parameters[0].Value:=null;
     open;
     append;
     dm.ado105VOUCHER.Value:=self.Edit_number.Text;             //ƾ֤��
     dm.ado105BATCH_NUMBER.Value:=DM.ADO132MEMO_NUMBER.Value;  //�ο���Ʊ��
     dm.ado105TRANS_TYPE.Value:=dm.ADO104RKEY.Value;            //ҵ������
     dm.ado105VOU_TYPE.Value:=0;                              //ת��ƾ֤
     dm.ado105SOURCE_PTR.Value:=dm.ADO132RKEY.Value;              //��Ʊָ��
     dm.ado105ENTERED_BY_EMPL_PTR.Value:=dm.ADO132EMPL_PTR.Value; //������Ա
     dm.ado105ENTERED_DT.Value:=strtodate(self.Edit_date.Text);   //��������
     dm.ado105ATTACHED.Value := updown1.Position;                 //��������
     dm.ado105FYEAR.Value := strtoint(self.Edit_fyear.Text);      //������
     dm.ado105PERIOD.Value := strtoint(self.Edit_PERIOD.Text);    //����ڼ�
     dm.ADO105SUPP_PTR.Value:=dm.ADO132SUPP_PTR.Value;          //��Ӧ��
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
      dm.ado106REF_NUMBER.Value:=dm.ADO132MEMO_NUMBER.Value;
      dm.ado106DESCRIPTION.Value:=sgrid1.Cells[0,i];
       dm.ADO106PRICE.AsString := sgrid1.Cells[4,i]; //ԭ��
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
  if (self.report_Check.Checked) and (not dm.ADO105.IsEmpty) then
  begin
   Form_voucherreport:=TForm_voucherreport.Create(application);
   form_voucherreport.ppReport1.Reset;
   form_voucherreport.ppReport1.Template.FileName :=
    stringReplace(UpperCase(GetCurrentDir),'EXEC','NIERP\REPORT\',[rfReplaceAll])+
      'VOUCHER_REPORT.rtm';    //R:\NIERP\Report\VOUCHER_REPORT.rtm
   form_voucherreport.ppReport1.Template.LoadFromFile;
   Form_voucherreport.AQD105.Close;
   Form_voucherreport.AQD105.Parameters[0].Value:=dm.ADO105RKEY.Value;
   Form_voucherreport.AQD105.Open;
   Form_voucherreport.AQD106.Open;
   Form_voucherreport.AQD493.Open;
   Form_voucherreport.ppReport1.Print;
   Form_voucherreport.Free;
  end;
 self.ModalResult:=mrok;
 except
  on E: Exception do
   begin
    dm.ACt.RollbackTrans;
    messagedlg(E.Message,mterror,[mbcancel],0);
    pagecontrol1.ActivePageIndex:=0;
    edit1.SetFocus;
   end;
 end;
end
else//�༭
 begin
 dm.ADO132.Close;
 dm.ADO132.Parameters[0].Value:=dm.aq132rkey.Value;
 dm.ADO132.Open;
 if (dm.ADO132AMOUNT.Value<>dm.ADO132AVL_AMT.Value)  then
 begin
  messagedlg('�������ʹ�ò��ܱ༭!',mtinformation,[mbok],0);
  dm.ADO132.Close;
  exit;
 end;
 try
  dm.ACt.BeginTrans;
 dm.ADO132.Edit;
 dm.ADO132MEMO_NUMBER.Value:=trim(edit1.Text);
 dm.ADO132ENT_DATE.Value:=self.dtpk2.Date;
 dm.ADO132MEMO_DATE.Value:=self.dtpk1.Date;
 dm.ADO132REF_NUMBER.Value:=edit15.Text;
 if (self.ComboBox1.ItemIndex=0) then
  begin
   dm.ADO132SUPP_PTR.Value:=self.supp_ptr;
   dm.ADO132CURRENCY_PTR.Value:=self.curr_ptr;
   dm.ADO132EX_RATE.Value:=strtofloat(edit6.Text);
  end;
 dm.ADO132AMOUNT.Value:=strtofloat(edit8.Text);
 dm.ADO132AVL_AMT.Value:=dm.ADO132AMOUNT.Value-strtofloat(edit3.Text);
 dm.ADO132MATL_TOT.Value:=strtofloat(edit9.Text);   //���ֵ
 dm.ADO132FED_TAX.Value:=strtofloat(edit10.Text);    //˰��
 dm.ADO132MISC_TOT.Value:=strtofloat(edit7.Text);   //�������
 dm.ADO132.Post;

   with dm.ado105 do                                        //���ӻ��ƾ֤�ܱ�
    begin
     close;
     dm.ado105.Parameters[0].Value:=dm.Aq132rkey105.Value;
     open;
    end;
   if not dm.ado105.isempty then dm.ado105.Delete;
   dm.ADO106.Close;
   dm.ADO106.Parameters[0].Value:=dm.ADO105RKEY.Value;
   dm.ADO106.Open;

   if sgrid1.RowCount>2 then
   begin
    dm.ADO104.Close;
    dm.ADO104.Open;

    with dm.ado105 do                                        //���ӻ��ƾ֤�ܱ�
    begin
     append;
     dm.ado105VOUCHER.Value:=self.Edit_number.Text;             //ƾ֤��
     dm.ado105BATCH_NUMBER.Value:=DM.ADO132MEMO_NUMBER.Value;  //�ο���Ʊ��
     dm.ado105TRANS_TYPE.Value:=dm.ADO104RKEY.Value;            //ҵ������
     dm.ado105VOU_TYPE.Value:=0;             //����ƾ֤
     dm.ado105SOURCE_PTR.Value:=dm.ADO132RKEY.Value;              //��Ʊָ��
     dm.ado105ENTERED_BY_EMPL_PTR.Value:=dm.ADO132EMPL_PTR.Value; //������Ա
     dm.ado105ENTERED_DT.Value:=strtodate(self.Edit_date.Text);   //��������
     dm.ado105ATTACHED.Value := updown1.Position;                 //��������
     dm.ado105FYEAR.Value := strtoint(self.Edit_fyear.Text);      //������
     dm.ado105PERIOD.Value := strtoint(self.Edit_PERIOD.Text);    //����ڼ�
     dm.ADO105SUPP_PTR.Value:=dm.ADO132SUPP_PTR.Value;          //��Ӧ��
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
    dm.ado106REF_NUMBER.Value:=dm.ADO132MEMO_NUMBER.Value;
    dm.ado106DESCRIPTION.Value:=sgrid1.Cells[0,i];
     dm.ADO106PRICE.AsString := sgrid1.Cells[4,i]; //ԭ��
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
   end;//=============����ƾ֤

 dm.ACt.CommitTrans;
  if (self.report_Check.Checked) and (not dm.ADO105.IsEmpty) then
   begin
   Form_voucherreport:=TForm_voucherreport.Create(application);
   form_voucherreport.ppReport1.Reset;
   form_voucherreport.ppReport1.Template.FileName :=
    stringReplace(UpperCase(GetCurrentDir),'EXEC','NIERP\REPORT\',[rfReplaceAll])+
      'VOUCHER_REPORT.rtm';    //R:\NIERP\Report\VOUCHER_REPORT.rtm
   form_voucherreport.ppReport1.Template.LoadFromFile;
   Form_voucherreport.AQD105.Close;
   Form_voucherreport.AQD105.Parameters[0].Value:=dm.ADO105RKEY.Value;
   Form_voucherreport.AQD105.Open;
   Form_voucherreport.AQD106.Open;
   Form_voucherreport.AQD493.Open;
   Form_voucherreport.ppReport1.Print;
   Form_voucherreport.Free;
   end;
 self.ModalResult:=mrok;
 except
  on E: Exception do
   begin
    dm.ACt.RollbackTrans;
    messagedlg(E.Message,mterror,[mbcancel],0);
    pagecontrol1.ActivePageIndex:=0;
    edit1.SetFocus;
   end;
 end;

 end;
end;

procedure TForm2.Edit6Exit(Sender: TObject);
begin
if trim(edit6.Text)='' then
 begin
  showmessage('����������������!');
  edit6.SetFocus;
 end
else
 if strtofloat(edit6.Text)<=0 then
  begin
   showmessage('����������������!');
   edit6.SetFocus;
  end
 else
  begin
   edit6.Text:=formatfloat('0.0000',strtofloat(edit6.Text));
  end;
end;

procedure TForm2.N4Click(Sender: TObject);
begin
try
 form_acct:=tform_acct.Create(application);
 if form_acct.ShowModal=mrok then
  if form1.find_accterror(form_acct.ADOQuery1RKEY.Value) then
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

        if self.curr_ptr = form_curr.ADOQuery1rkey.Value then
         sgrid1.Cells[3,sgrid1.RowCount-1]:=edit6.Text
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

procedure TForm2.N5Click(Sender: TObject);
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

procedure TForm2.N11Click(Sender: TObject);
begin
try
 form_curr:=tform_curr.Create(application);
 if form_curr.ShowModal=mrok then
  begin
   if (form1.get_gltp(trim(sgrid2.Cells[0,sgrid1.row]))=0) and
      (form_curr.ADOQuery1rkey.Value>1) then
    messagedlg('��Ŀ������������',mterror,[mbcancel],0)
   else
    if (form1.get_gltp(trim(sgrid2.Cells[0,sgrid1.row]))=2) and   //��һ���
       (form1.get_glcurr_ptr(trim(sgrid2.Cells[0,sgrid1.row]))<>
       form_curr.ADOQuery1rkey.Value) then
     messagedlg('��Ŀ���㵥һ���,������ѡ�����Ҳ�һ��',mterror,[mbcancel],0)
    else
     begin
      sgrid1.Cells[2,sgrid1.Row]:=form_curr.ADOQuery1curr_code.Value;   //����
      if self.curr_ptr = form_curr.ADOQuery1rkey.Value then
       sgrid1.Cells[3,sgrid1.Row]:=edit6.Text
      else
       sgrid1.Cells[3,sgrid1.Row]:=form_curr.ADOQuery1BASE_TO_OTHER.AsString;
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

procedure TForm2.N7Click(Sender: TObject);
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

procedure TForm2.N8Click(Sender: TObject);
begin
try
form_dictionary:=Tform_dictionary.Create(application);
if form_dictionary.ShowModal=mrok then
 sgrid1.Cells[0,sgrid1.Row]:=form_dictionary.aq513DSDesigner2.Value;
finally
form_dictionary.Free;
end;
end;

procedure TForm2.N9Click(Sender: TObject);
begin
if (sgrid1.Row<>1) and (sgrid1.Row<>sgrid1.RowCount-1) then
 sgrid1.Cells[0,sgrid1.Row]:=sgrid1.Cells[0,sgrid1.Row-1]; 
end;

procedure TForm2.SpeedButton9Click(Sender: TObject);
begin
if self.a_or_e.Caption='0' then  //����
 begin
  edit_number.Text:=form1.get_vouchernumber(strtodate(Edit_date.Text));
  edit_fyear.Text:=inttostr(yearof(strtodate(Edit_date.Text)));
  edit_period.Text:=inttostr(monthof(strtodate(Edit_date.Text)));
 end
else
 messagedlg('�༭״̬�²����޸�ƾ֤���!',mterror,[mbcancel],0);
end;

procedure TForm2.Edit_dateKeyPress(Sender: TObject; var Key: Char);
begin
 if not (key in ['0'..'9','-',#8,#13]) then  //�ж��Ƿ���������
  abort
end;

procedure TForm2.Edit_dateExit(Sender: TObject);
begin
try
 strtodate(Edit_date.Text);
except
 messagedlg('���ڸ�ʽ��������!',mterror,[mbcancel],0);
 Edit_date.SetFocus;
 exit;
end;
if self.a_or_e.Caption='0' then  //����
 begin
  edit_number.Text:=form1.get_vouchernumber(strtodate(Edit_date.Text));
  edit_fyear.Text:=inttostr(yearof(strtodate(Edit_date.Text)));
  edit_period.Text:=inttostr(monthof(strtodate(Edit_date.Text)));
 end;
end;

procedure TForm2.SGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
if arow=sgrid1.RowCount-1 then
 begin
  speedbutton4.Enabled:=false;
  speedbutton5.Enabled:=false;
  speedbutton6.Enabled:=false;
  speedbutton7.Enabled:=false;
  speedbutton8.Enabled:=false;
 end
else
 begin
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
end;

procedure TForm2.SGrid1MouseDown(Sender: TObject; Button: TMouseButton;
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

procedure TForm2.SGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
 v_c:currency;
begin
if key=13 then    //�û����»س���,���ҶԵ�
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

if key=187 then    //�û�����=��,�Զ�����
 begin
  if sgrid1.Row <> sgrid1.RowCount-1 then
  begin

   if (sgrid1.Col=5) and (sgrid1.Cells[6,sgrid1.Row]='') then
   begin
    v_c:=strtocurr(form1.RemoveInvalid(statictext2.Caption))-get_col5(sgrid1.Row);
    if v_c <> 0 then
     sgrid1.Cells[5,sgrid1.Row]:=formatfloat('0.00',v_c);
   end;

   if (sgrid1.Col=6) and (sgrid1.Cells[5,sgrid1.Row]='') then
   begin
    v_c:=strtocurr(form1.RemoveInvalid(statictext1.Caption))-get_col6(sgrid1.Row);
    if v_c <> 0 then
    sgrid1.Cells[6,sgrid1.Row]:=formatfloat('0.00',v_c);
   end;

   self.re_calculate;
  end;
 end;
end;

procedure TForm2.SGrid1KeyPress(Sender: TObject; var Key: Char);
begin
if sgrid1.Col<>0 then
 if not (key in ['0'..'9','.','-',#8]) then  //�ж��Ƿ���������
  abort
 else
  if key = chr(46) then      //�ж��Ƿ��ظ�����С����'.'
   if pos('.',sgrid1.Cells[sgrid1.col,sgrid1.row])>0  then abort;
end;

procedure TForm2.SGrid1Exit(Sender: TObject);
begin
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
 SGrid1.Col:=0;
end;

procedure TForm2.SGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
begin
if (acol>3) then
 Sgrid1.Canvas.TextRect(rect,rect.right-Sgrid1.Canvas.TextWidth(Sgrid1.Cells[acol,arow])
                 -2,rect.Top+2, Sgrid1.Cells[acol,aRow]);
end;

procedure TForm2.Edit9Exit(Sender: TObject);
begin
if trim((sender as tedit).Text)='' then
  (sender as tedit).Text:='0';
(sender as tedit).Text:=formatfloat('0.00',
                         strtocurr(trim((sender as tedit).Text))
                                    );

edit8.Text:=formatfloat('0.00',strtocurr(edit9.Text)+
                           strtocurr(edit7.Text)+
                           strtocurr(edit10.Text)
                        );
end;

procedure TForm2.PageControl1Change(Sender: TObject);
var
 i:word;
 mt_error:boolean;
begin
if (a_or_e.Caption='0') or (trim(edit_number.Text)='') then
if (self.supp_ptr>0) and  (sgrid1.RowCount<=2) then
{   (strtocurr(edit8.Text)*strtocurr(edit6.Text)<>
    strtocurr(form1.RemoveInvalid(statictext1.Caption))) then
}
begin
 edit_date.Text:=datetostr(dtpk1.Date);
 edit_number.Text:=form1.get_vouchernumber(dtpk1.Date);
 Edit_fyear.Text:=inttostr(yearof(dtpk1.Date));   //������
 Edit_PERIOD.Text:=inttostr(monthof(dtpk1.Date));  //����ڼ�
 Edit_employee.Text:=form1.empl_name.Caption;
  for i:=1 to sgrid1.RowCount-2 do
   begin
    sgrid1.Rows[i].Clear;
    sgrid2.Rows[i].Clear;
   end;
  sgrid1.RowCount:=2;
  sgrid2.RowCount:=2;
  dm.ADO104.Close;
  dm.ADO104.Open;
  mt_error:=true;
  if strtocurr(edit8.Text)>0 then    //�跽������ܼƽ��
   with dm.ADOQuery1 do
   begin
    close;
    sql.Clear;
    sql.Add('SELECT Data0103.GL_ACC_NUMBER, Data0103_1.GL_DESCRIPTION,');
    sql.Add('Data0103.GL_DESCRIPTION AS DESCRIPTION,data0103.curr_tp,data0103.curr_ptr');
    sql.Add('FROM dbo.Data0103 LEFT OUTER JOIN');
    sql.Add('Data0103 Data0103_1 ON Data0103.PARENT_PTR = Data0103_1.RKEY');
    if self.accsupp_gl_ptr>0 then
     sql.Add('where Data0103.rkey='+inttostr(self.accsupp_gl_ptr))
    else
     sql.Add('where Data0103.rkey='+dm.ADO104DFLT_ACCT_01.AsString);
    open;

    case fieldbyname('curr_tp').AsInteger of
     0:                 //���������
      begin
       sgrid1.Cells[2,sgrid1.RowCount-1]:= form1.curr_code.Caption;         //����
       sgrid1.Cells[3,sgrid1.RowCount-1]:='1' ;          //����
       sgrid1.Cells[4,sgrid1.RowCount-1]:=               //���ҽ��
         Formatfloat('0.00',strtocurr(edit8.Text)*strtofloat(edit6.Text));
       sgrid2.Cells[1,sgrid2.RowCount-1]:='1';
      end;
     1:               //�������
      begin
       sgrid1.Cells[2,sgrid1.RowCount-1]:=edit5.Text;          //����
       sgrid1.Cells[3,sgrid1.RowCount-1]:=edit6.Text;          //����
       sgrid1.Cells[4,sgrid1.RowCount-1]:=edit8.Text;         //ԭ�ҽ��
       sgrid2.Cells[1,sgrid2.RowCount-1]:= inttostr(self.curr_ptr);
      end;
      2:             //���㵥һ���
       begin
        if fieldbyname('curr_ptr').AsInteger=self.curr_ptr then
        begin
         sgrid1.Cells[2,sgrid1.RowCount-1]:=edit5.Text;          //����
         sgrid1.Cells[3,sgrid1.RowCount-1]:=edit6.Text;          //����
         sgrid1.Cells[4,sgrid1.RowCount-1]:=edit8.text;         //ԭ�ҽ��
         sgrid2.Cells[1,sgrid2.RowCount-1]:= inttostr(self.curr_ptr);
        end
        else
         begin
          messagedlg('֧������л����Ŀ�����˺��㵥һ���,����֧�����Ҳ�һ��',mterror,[mbcancel],0);
          mt_error:=false;
         end;
       end;
    end; //end case
     if mt_error then
      begin
       sgrid1.Cells[0,sgrid1.RowCount-1]:=              //ժҪ
                         edit1.Text+ '['+
                         edit4.Text+
                         ABBR_NAME.Caption+']';
       sgrid1.Cells[1,sgrid1.RowCount-1]:=              //��Ŀ
                         trim(FieldValues['gl_acc_number'])+'-'+
                         trim(Fieldbyname('GL_DESCRIPTION').AsString)+'-'+
                         trim(FieldValues['DESCRIPTION']);
       sgrid1.Cells[5,sgrid1.RowCount-1]:=        //�跽���ҽ��
            formatfloat('0.00',strtocurr(edit8.Text)*strtofloat(edit6.Text));
       if self.accsupp_gl_ptr>0 then
        sgrid2.Cells[0,sgrid2.RowCount-1]:=inttostr(self.accsupp_gl_ptr)
       else
        sgrid2.Cells[0,sgrid2.RowCount-1]:=dm.ADO104DFLT_ACCT_01.AsString;

       sgrid1.RowCount:=sgrid1.RowCount+1;
       sgrid2.RowCount:=sgrid2.RowCount+1;
      end;
   end;//==============================�跽��Ӧ��Ӧ���ʿ�

  mt_error:=true;
  if strtocurr(edit9.Text)>0 then    //��������˰���
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
       sgrid1.Cells[2,sgrid1.RowCount-1]:= form1.curr_code.Caption;         //����
       sgrid1.Cells[3,sgrid1.RowCount-1]:='1' ;          //����
       sgrid1.Cells[4,sgrid1.RowCount-1]:=               //���ҽ��
         Formatfloat('0.00',strtocurr(edit9.Text)*strtofloat(edit6.Text));
       sgrid2.Cells[1,sgrid2.RowCount-1]:='1';
      end;
     1:               //�������
      begin
       sgrid1.Cells[2,sgrid1.RowCount-1]:=edit5.Text;          //����
       sgrid1.Cells[3,sgrid1.RowCount-1]:=edit6.Text;          //����
       sgrid1.Cells[4,sgrid1.RowCount-1]:=edit9.Text;         //ԭ�ҽ��
       sgrid2.Cells[1,sgrid2.RowCount-1]:= inttostr(self.curr_ptr);
      end;
      2:             //���㵥һ���
       begin
        if fieldbyname('curr_ptr').AsInteger=self.curr_ptr then
        begin
         sgrid1.Cells[2,sgrid1.RowCount-1]:=edit5.Text;          //����
         sgrid1.Cells[3,sgrid1.RowCount-1]:=edit6.Text;          //����
         sgrid1.Cells[4,sgrid1.RowCount-1]:=edit9.text;         //ԭ�ҽ��
         sgrid2.Cells[1,sgrid2.RowCount-1]:= inttostr(self.curr_ptr);
        end
        else
         begin
          messagedlg('֧������л����Ŀ�����˺��㵥һ���,����֧�����Ҳ�һ��',mterror,[mbcancel],0);
          mt_error:=false;
         end;
       end;
    end; //end case
     if mt_error then
      begin
       sgrid1.Cells[0,sgrid1.RowCount-1]:=              //ժҪ
                         edit1.Text+ '['+
                         edit4.Text+
                         ABBR_NAME.Caption+']';
       sgrid1.Cells[1,sgrid1.RowCount-1]:=              //��Ŀ
                         trim(FieldValues['gl_acc_number'])+'-'+
                         trim(Fieldbyname('GL_DESCRIPTION').AsString)+'-'+
                         trim(FieldValues['DESCRIPTION']);
       sgrid1.Cells[6,sgrid1.RowCount-1]:=        //�������ҽ��
            formatfloat('0.00',strtocurr(edit9.Text)*strtofloat(edit6.Text));
       sgrid2.Cells[0,sgrid2.RowCount-1]:=dm.ADO104DFLT_ACCT_02.AsString;

       sgrid1.RowCount:=sgrid1.RowCount+1;
       sgrid2.RowCount:=sgrid2.RowCount+1;
      end;
   end;//==============================�����Ͼ�ֵ��

  mt_error:=true;
  if strtocurr(edit10.Text)>0 then    //������ֵ˰��
   with dm.ADOQuery1 do
   begin
    close;
    sql.Clear;
    sql.Add('SELECT Data0103.GL_ACC_NUMBER, Data0103_1.GL_DESCRIPTION,');
    sql.Add('Data0103.GL_DESCRIPTION AS DESCRIPTION,data0103.curr_tp,data0103.curr_ptr');
    sql.Add('FROM dbo.Data0103 LEFT OUTER JOIN');
    sql.Add('Data0103 Data0103_1 ON Data0103.PARENT_PTR = Data0103_1.RKEY');
    sql.Add('where Data0103.rkey='+dm.ADO104DFLT_ACCT_03.AsString);
    open;

    case fieldbyname('curr_tp').AsInteger of
     0:                 //���������
      begin
       sgrid1.Cells[2,sgrid1.RowCount-1]:= form1.curr_code.Caption;         //����
       sgrid1.Cells[3,sgrid1.RowCount-1]:='1' ;          //����
       sgrid1.Cells[4,sgrid1.RowCount-1]:=               //���ҽ��
         Formatfloat('0.00',strtocurr(edit10.Text)*strtofloat(edit6.Text));
       sgrid2.Cells[1,sgrid2.RowCount-1]:='1';
      end;
     1:               //�������
      begin
       sgrid1.Cells[2,sgrid1.RowCount-1]:=edit5.Text;          //����
       sgrid1.Cells[3,sgrid1.RowCount-1]:=edit6.Text;          //����
       sgrid1.Cells[4,sgrid1.RowCount-1]:=edit10.Text;         //ԭ�ҽ��
       sgrid2.Cells[1,sgrid2.RowCount-1]:= inttostr(self.curr_ptr);
      end;
      2:             //���㵥һ���
       begin
        if fieldbyname('curr_ptr').AsInteger=self.curr_ptr then
        begin
         sgrid1.Cells[2,sgrid1.RowCount-1]:=edit5.Text;          //����
         sgrid1.Cells[3,sgrid1.RowCount-1]:=edit6.Text;          //����
         sgrid1.Cells[4,sgrid1.RowCount-1]:=edit10.text;         //ԭ�ҽ��
         sgrid2.Cells[1,sgrid2.RowCount-1]:= inttostr(self.curr_ptr);
        end
        else
         begin
          messagedlg('֧������л����Ŀ�����˺��㵥һ���,����֧�����Ҳ�һ��',mterror,[mbcancel],0);
          mt_error:=false;
         end;
       end;
    end; //end case
     if mt_error then
      begin
       sgrid1.Cells[0,sgrid1.RowCount-1]:=              //ժҪ
                         edit1.Text+ '['+
                         edit4.Text+
                         ABBR_NAME.Caption+']';
       sgrid1.Cells[1,sgrid1.RowCount-1]:=              //��Ŀ
                         trim(FieldValues['gl_acc_number'])+'-'+
                         trim(Fieldbyname('GL_DESCRIPTION').AsString)+'-'+
                         trim(FieldValues['DESCRIPTION']);
       sgrid1.Cells[6,sgrid1.RowCount-1]:=        //�������ҽ��
            formatfloat('0.00',strtocurr(edit10.Text)*strtofloat(edit6.Text));
       sgrid2.Cells[0,sgrid2.RowCount-1]:=dm.ADO104DFLT_ACCT_03.AsString;

       sgrid1.RowCount:=sgrid1.RowCount+1;
       sgrid2.RowCount:=sgrid2.RowCount+1;
      end;
   end;//==============================��˰��

  mt_error:=true;
  if strtocurr(edit7.Text)>0 then    //�����������
   with dm.ADOQuery1 do
   begin
    close;
    sql.Clear;
    sql.Add('SELECT Data0103.GL_ACC_NUMBER, Data0103_1.GL_DESCRIPTION,');
    sql.Add('Data0103.GL_DESCRIPTION AS DESCRIPTION,data0103.curr_tp,data0103.curr_ptr');
    sql.Add('FROM dbo.Data0103 LEFT OUTER JOIN');
    sql.Add('Data0103 Data0103_1 ON Data0103.PARENT_PTR = Data0103_1.RKEY');
    sql.Add('where Data0103.rkey='+dm.ADO104DFLT_ACCT_05.AsString);
    open;

    case fieldbyname('curr_tp').AsInteger of
     0:                 //���������
      begin
       sgrid1.Cells[2,sgrid1.RowCount-1]:= form1.curr_code.Caption;         //����
       sgrid1.Cells[3,sgrid1.RowCount-1]:='1' ;          //����
       sgrid1.Cells[4,sgrid1.RowCount-1]:=               //���ҽ��
         Formatfloat('0.00',strtocurr(edit7.Text)*strtofloat(edit6.Text));
       sgrid2.Cells[1,sgrid2.RowCount-1]:='1';
      end;
     1:               //�������
      begin
       sgrid1.Cells[2,sgrid1.RowCount-1]:=edit5.Text;          //����
       sgrid1.Cells[3,sgrid1.RowCount-1]:=edit6.Text;          //����
       sgrid1.Cells[4,sgrid1.RowCount-1]:=edit7.Text;         //ԭ�ҽ��
       sgrid2.Cells[1,sgrid2.RowCount-1]:= inttostr(self.curr_ptr);
      end;
      2:             //���㵥һ���
       begin
        if fieldbyname('curr_ptr').AsInteger=self.curr_ptr then
        begin
         sgrid1.Cells[2,sgrid1.RowCount-1]:=edit5.Text;          //����
         sgrid1.Cells[3,sgrid1.RowCount-1]:=edit6.Text;          //����
         sgrid1.Cells[4,sgrid1.RowCount-1]:=edit7.text;         //ԭ�ҽ��
         sgrid2.Cells[1,sgrid2.RowCount-1]:= inttostr(self.curr_ptr);
        end
        else
         begin
          messagedlg('֧������л����Ŀ�����˺��㵥һ���,����֧�����Ҳ�һ��',mterror,[mbcancel],0);
          mt_error:=false;
         end;
       end;
    end; //end case
     if mt_error then
      begin
       sgrid1.Cells[0,sgrid1.RowCount-1]:=              //ժҪ
                         edit1.Text+ '['+
                         edit4.Text+
                         ABBR_NAME.Caption+']';
       sgrid1.Cells[1,sgrid1.RowCount-1]:=              //��Ŀ
                         trim(FieldValues['gl_acc_number'])+'-'+
                         trim(Fieldbyname('GL_DESCRIPTION').AsString)+'-'+
                         trim(FieldValues['DESCRIPTION']);
       sgrid1.Cells[6,sgrid1.RowCount-1]:=        //�������ҽ��
            formatfloat('0.00',strtocurr(edit7.Text)*strtofloat(edit6.Text));
       sgrid2.Cells[0,sgrid2.RowCount-1]:=dm.ADO104DFLT_ACCT_05.AsString;

       sgrid1.RowCount:=sgrid1.RowCount+1;
       sgrid2.RowCount:=sgrid2.RowCount+1;
      end;
   end;//==============================���������

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

end;
end;

procedure TForm2.PopupMenu3Popup(Sender: TObject);
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

procedure TForm2.BitBtn6Click(Sender: TObject);
var
  InputVar: PDlgInput ;
begin
  frmPick_Item_Single := TfrmPick_Item_Single.Create(application) ;
  try
    InputVar.Fields := 'warehouse_CODE/��������/100,ABBR_NAME/�������/100,warehouse_NAME/��������/200';
    InputVar.Sqlstr := 'select rkey,warehouse_CODE,ABBR_NAME,warehouse_NAME from data0015';
    InputVar.AdoConn := dm.ACt;
    frmPick_Item_Single.InitForm_New(InputVar);
    if frmPick_Item_Single.ShowModal=mrok then
    begin
      Label18.Caption:=frmPick_Item_Single.adsPick.FieldValues['ABBR_NAME'];
      Edit11.Text := frmPick_Item_Single.adsPick.FieldValues['warehouse_CODE'];
      Edit11.Tag := frmPick_Item_Single.adsPick.FieldValues['rkey'];
    end;
  finally
    frmPick_Item_Single.adsPick.Close;
    frmPick_Item_Single.Free ;
  end;
end;

end.
