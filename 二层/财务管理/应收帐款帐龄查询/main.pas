unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, DB, ADODB, ComCtrls, ExtCtrls, Grids,DateUtils,
   Math,Excel2000,ClipBrd,ComObj, DBGrids;
type
 TExcludeColumns = set of 0..255;

type
  TForm1 = class(TForm)
    StringGrid1: TStringGrid;
    Panel1: TPanel;
    Edit1: TEdit;
    Label4: TLabel;
    dtpk1: TDateTimePicker;
    dtpk2: TDateTimePicker;
    Label3: TLabel;
    ADOConnection1: TADOConnection;
    Label1: TLabel;
    BitBtn1: TBitBtn;
    Label2: TLabel;
    Edit2: TEdit;
    BitBtn6: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn4: TBitBtn;
    Label5: TLabel;
    Label6: TLabel;
    BitBtn3: TBitBtn;
    abbr_name: TLabel;
    exch_rate: TLabel;
    ADOQuery1: TADOQuery;
    tax_id_no: TLabel;
    AQ_balance: TADOQuery;
    AQ_balanceCUSTOMER_PTR: TIntegerField;
    AQ_balanceCURRENCY_PTR: TIntegerField;
    AQ_balanceDSDesigner: TBCDField;
    AQ_balanceDSDesigner3: TFloatField;
    aq_lengrece: TADOQuery;
    aq_lengreceCUSTOMER_PTR: TIntegerField;
    aq_lengreceCURRENCY_PTR: TIntegerField;
    aq_lengreceDSDesigner: TBCDField;
    aq_lengreceDSDesigner3: TFloatField;
    aq_lengyirece: TADOQuery;
    aq_lengyireceSRCE_PTR: TIntegerField;
    aq_lengyireceCURRECY_PTR: TIntegerField;
    aq_lengyireceDSDesigner: TFloatField;
    aq_lengyireceDSDesigner3: TFloatField;
    AQ_lengcredit: TADOQuery;
    AQ_lengcreditCUST_PTR: TIntegerField;
    AQ_lengcreditCURRENCY_PTR: TIntegerField;
    AQ_lengcreditDSDesigner: TBCDField;
    AQ_lengcreditDSDesigner3: TFloatField;
    aq_finarece: TADOQuery;
    aq_finarececustomer_ptr: TIntegerField;
    aq_finarececurrency_ptr: TIntegerField;
    aq_finareceDSDesigner: TBCDField;
    aq_finareceDSDesigner3: TFloatField;
    aq_finayirece: TADOQuery;
    aq_finayirecesrce_ptr: TIntegerField;
    aq_finayirececurrecy_ptr: TIntegerField;
    aq_finayireceDSDesigner: TFloatField;
    aq_finayireceDSDesigner3: TFloatField;
    AQ_finacredit: TADOQuery;
    AQ_finacreditcust_ptr: TIntegerField;
    AQ_finacreditcurrency_ptr: TIntegerField;
    AQ_finacreditDSDesigner: TBCDField;
    AQ_finacreditDSDesigner3: TFloatField;
    StringGrid2: TStringGrid;
    ProgressBar1: TProgressBar;
    CheckBox1: TCheckBox;
    aq01: TADOQuery;
    aq01rkey: TIntegerField;
    aq01curr_code: TStringField;
    aq01BASE_TO_OTHER: TFloatField;
    aq_lengreceDSDesigner2: TFloatField;
    aq_lengyireceDSDesigner2: TFloatField;
    AQ_lengcreditDSDesigner2: TFloatField;
    aq_finareceDSDesigner2: TFloatField;
    aq_finayireceDSDesigner2: TFloatField;
    AQ_finacreditDSDesigner2: TFloatField;
    AQ_balanceDSDesigner2: TFloatField;
    RadioGroup1: TRadioGroup;
    customer_type: TLabel;
    sales_rep_name: TLabel;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Edit1Exit(Sender: TObject);
    procedure Edit2Exit(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure dtpk1Exit(Sender: TObject);

    procedure SetOptimalGridCellWidth(sg: TStringGrid;
     ExcludeColumns: TExcludeColumns);
    procedure get_leng6(rkey10, rkey01: integer; var yishou,yishou_b :currency);
    procedure get_balance(rkey10,rkey01 :integer; var yishou,yishou_b :currency);
    procedure get_leng2_5(rkey10, rkey01: integer;dtpk_1,dtpk_2:tdatetime;
      var yishou,yishou_b :currency);
    procedure get_leng_1(rkey10, rkey01: integer;dtpk_1:tdatetime;
      var yishou,yishou_b :currency);
    procedure BitBtn3Click(Sender: TObject);
    function get_currency(currency:integer):integer;
    function get_customer(customer_ptr: integer): integer;
    function get_cust_curr(customer_ptr,currency_ptr: integer): integer;
    procedure CheckBox1Click(Sender: TObject);
    function find_date(array_date:array of currency): boolean;
    procedure StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
   rkey10,rkey01:integer;
   v_date0,v_date1,v_date2,v_date3,v_date4:tdatetime;
   newrow,newcol:integer;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  function RemoveInvalid(where: string): string;

implementation

uses curr_search, customer_search,common;

{$R *.dfm}
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

function TForm1.get_currency(currency: integer): integer;
var
 i:integer;
begin
result:=0;
for i:=1 to stringgrid2.RowCount-2 do
 if strtoint(stringgrid2.Cells[1,i])=currency then
  begin
   result:=i;
   break;
  end;
end;

function TForm1.get_customer(customer_ptr: integer): integer;
var
 i:integer;
begin
result:=0;
for i:=1 to stringgrid2.RowCount-2 do
 if strtoint(stringgrid2.Cells[0,i])=customer_ptr then
  begin
   result:=i;
   break;
  end;
end;

function TForm1.get_cust_curr(customer_ptr,currency_ptr: integer): integer;
var
 i:integer;
begin
result:=0;
for i:=1 to stringgrid2.RowCount-1 do //未确定货币,未确定客户时string行与数据行一致
 if strtoint(stringgrid2.Cells[0,i])>0 then
 if (strtoint(stringgrid2.Cells[0,i])=customer_ptr) and
    (strtoint(stringgrid2.Cells[1,i])=currency_ptr) then
  begin
   result:=i;
   break;
  end;
end;

procedure tform1.SetOptimalGridCellWidth(sg: TStringGrid;
  ExcludeColumns: TExcludeColumns);
 var
  i : Integer;
  j : Integer;
  max_width : Integer;
begin
with sg do
 begin
  Canvas.Font.Assign(Font);
  for i := 0 to (ColCount - 1) do
  begin
   if i in ExcludeColumns then Continue;
   max_width := 0;
   for j := 0 to (RowCount - 1) do
    max_width := Math.Max(max_width,Canvas.TextWidth(Cells[i,j]));
   if max_width > 0 then
    ColWidths[i] := max_width + 4
   else
    ColWidths[i] := DefaultColWidth;
  end; { for }
 end;
end;

procedure TForm1.get_balance(rkey10, rkey01: integer;
          var yishou,yishou_b :currency);
begin                                     //当前余额
yishou:=0;
yishou_b:=0;
with aq_balance do
 begin
  close;
  sql.Delete(7);
  sql.Insert(7,'AND CUSTOMER_PTR='+inttostr(rkey10)+' and currency_ptr='+inttostr(rkey01));
  sql.Delete(8);
  sql.Insert(8,'');
  sql.Delete(18);
  sql.Insert(18,'and  cust_ptr='+inttostr(rkey10)+' and currency_ptr='+inttostr(rkey01));
  sql.Delete(19);
  sql.Insert(19,'');
  open;
  while not Eof do
   begin
    yishou:=yishou+self.AQ_balanceDSDesigner.Value;
    if radiogroup1.ItemIndex=0 then
     yishou_b:=yishou_b+self.AQ_balanceDSDesigner2.Value
    else
     yishou_b:=yishou_b+self.AQ_balanceDSDesigner3.Value;
    next;
   end;
 end;
end;

procedure TForm1.get_leng6(rkey10, rkey01: integer;
   var yishou,yishou_b :currency);
begin
yishou:=0;
yishou_b:=0;
with aq_balance do
 begin
  close;
  sql.Delete(7);
  sql.Insert(7,'and CUSTOMER_PTR='+inttostr(rkey10)+' and currency_ptr='+inttostr(rkey01));
  sql.Delete(8);
  sql.Insert(8,'and invoice_date > '''+datetostr(dtpk2.Date)+'''');
  sql.Delete(18);
  sql.Insert(18,'and  cust_ptr='+inttostr(rkey10)+' and currency_ptr='+inttostr(rkey01));
  sql.Delete(19);
  sql.Insert(19,'and RMA_DATE > '''+datetostr(dtpk2.Date)+'''');
  Prepared:=true;
  open;
  while not Eof do
   begin
    yishou:=yishou+self.AQ_balanceDSDesigner.Value;
    if radiogroup1.ItemIndex=0 then
     yishou_b:=yishou_b+self.AQ_balanceDSDesigner2.Value
    else
     yishou_b:=yishou_b+self.AQ_balanceDSDesigner3.Value;
    next;
   end;
 end;
end;

procedure TForm1.get_leng2_5(rkey10, rkey01: integer;dtpk_1,dtpk_2:tdatetime;
   var yishou,yishou_b :currency);
begin
yishou:=0;
yishou_b:=0;
with aq_balance do
 begin
  close;
  sql.Delete(7);
  sql.Insert(7,'and CUSTOMER_PTR='+inttostr(rkey10)+' and currency_ptr='+inttostr(rkey01));
  sql.Delete(8);
  sql.Insert(8,'and invoice_date >= '''+datetostr(dtpk_1)+''' and invoice_date <= '''+datetostr(dtpk_2)+'''');
  sql.Delete(18);
  sql.Insert(18,'and cust_ptr='+inttostr(rkey10)+' and currency_ptr='+inttostr(rkey01));
  sql.Delete(19);
  sql.Insert(19,'and RMA_DATE >= '''+datetostr(dtpk_1)+''' and RMA_DATE <= '''+datetostr(dtpk_2)+'''');
  Prepared:=true;
  open;
  while not Eof do
   begin
    yishou:=yishou+self.AQ_balanceDSDesigner.Value;
    if radiogroup1.ItemIndex=0 then
     yishou_b:=yishou_b+self.AQ_balanceDSDesigner2.Value
    else
     yishou_b:=yishou_b+self.AQ_balanceDSDesigner3.Value;
    next;
   end;
 end;
end;

procedure TForm1.get_leng_1(rkey10, rkey01: integer;dtpk_1:tdatetime;
   var yishou,yishou_b :currency);
begin
yishou:=0;
yishou_b:=0;
with aq_balance do
 begin
  close;
  sql.Delete(7);
  sql.Insert(7,'and CUSTOMER_PTR='+inttostr(rkey10)+' and currency_ptr='+inttostr(rkey01));
  sql.Delete(8);
  sql.Insert(8,'and invoice_date <= '''+datetostr(dtpk_1)+'''');
  sql.Delete(18);
  sql.Insert(18,'and  cust_ptr='+inttostr(rkey10)+' and currency_ptr='+inttostr(rkey01));
  sql.Delete(19);
  sql.Insert(19,'and RMA_DATE <= '''+datetostr(dtpk_1)+'''');
  Prepared:=true;
  open;
  while not Eof do
   begin
    yishou:=yishou+self.AQ_balanceDSDesigner.Value;
    if radiogroup1.ItemIndex=0 then
     yishou_b:=yishou_b+self.AQ_balanceDSDesigner2.Value
    else
     yishou_b:=yishou_b+self.AQ_balanceDSDesigner3.Value;
    next;
   end;
 end;
end;

function TForm1.find_date(array_date:array of currency): boolean;
var
 i:word;
begin
result:=false;
 if checkbox1.Checked then
  for i:=0 to 15 do
   begin
    if array_date[i]<>0 then
     begin
      result:=true;
      break;
     end;
   end
 else
  for i:=0 to 8 do
   begin
    if array_date[i]<>0 then
     begin
      result:=true;
      break;
     end;
   end;
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
application.Terminate;
end;

procedure TForm1.BitBtn6Click(Sender: TObject);
begin
try
form_customer:=tform_customer.Create(application);
if form_customer.ShowModal=mrok then
 begin

  edit1.Text:=form_customer.ADOQuery1CUST_CODE.Value;
  label5.Caption:=form_customer.ADOQuery1CUSTOMER_NAME.Value;
  abbr_name.Caption:=form_customer.ADOQuery1abbr_name.Value;
  tax_id_no.Caption:= trim(form_customer.ADOQuery1FED_TAX_ID_NO.Value);
  edit2.Text:=form_customer.ADOQuery1CURR_CODE.Value;
  label6.Caption:=form_customer.ADOQuery1CURR_NAME.Value;

  customer_type.Caption:=form_customer.ADOQuery1CUSTOMER_TYPE.Value;
  sales_rep_name.Caption:=form_customer.ADOQuery1SALES_REP_NAME.Value;

  exch_rate.Caption:=form_customer.ADOQuery1BASE_TO_OTHER.AsString;
  rkey10:=form_customer.ADOQuery1rkey.Value;
  rkey01:=form_customer.ADOQuery1CURRENCY_PTR.Value;

 end
else
 edit1.SetFocus; 
finally
 form_customer.Free;
end;
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
begin
form_curr:=tform_curr.Create(application);
if form_curr.ShowModal=mrok then
 begin
  edit2.Text:=form_curr.ADOQuery1CURR_CODE.Value;
  label6.Caption:=form_curr.ADOQuery1CURR_NAME.Value;
  exch_rate.Caption:=form_curr.ADOQuery1base_to_other.AsString;
  rkey01:=form_curr.ADOQuery1RKEY.Value;
 end
else
 edit2.SetFocus; 
form_curr.Free;
end;

procedure TForm1.Edit1Exit(Sender: TObject);
begin
if trim(edit1.Text)<>'' then
begin
 with adoquery1 do
  begin
   close;
   sql.Clear;
   sql.Add('SELECT     dbo.Data0010.RKEY, dbo.Data0010.CUST_CODE, dbo.Data0010.CUSTOMER_NAME, dbo.Data0005.EMPLOYEE_NAME as SALES_REP_NAME, ');
   sql.Add(' CASE dbo.Data0010.CUSTOMER_TYPE WHEN 1 THEN ''正常'' WHEN 2 THEN ''新合作'' WHEN 3 THEN ''控制'' WHEN 4 THEN ''停止'' END AS CUSTOMER_TYPE, ');
   sql.Add(' dbo.Data0001.CURR_CODE, dbo.Data0001.CURR_NAME, dbo.Data0001.BASE_TO_OTHER, ');
   sql.Add(' dbo.Data0010.CURRENCY_PTR, dbo.Data0010.ABBR_NAME, dbo.Data0010.FED_TAX_ID_NO ');
   sql.Add('FROM dbo.Data0010 INNER JOIN ');
   sql.Add(' dbo.Data0005 ON dbo.Data0010.SALES_REP_PTR = dbo.Data0005.RKEY INNER JOIN ');
   sql.Add(' dbo.Data0001 ON dbo.Data0010.CURRENCY_PTR = dbo.Data0001.RKEY');
   sql.Add('where dbo.Data0010.CUST_CODE='''+trim(edit1.Text)+'''');
   open;
   if not IsEmpty then
   begin
    label5.Caption:=fieldvalues['CUSTOMER_NAME'];
    abbr_name.Caption:=fieldvalues['abbr_name'];
    edit2.Text:=fieldvalues['CURR_CODE'];
    label6.Caption:=fieldvalues['CURR_NAME'];
    exch_rate.Caption:=fieldbyname('BASE_TO_OTHER').AsString;
    rkey10:=fieldvalues['rkey'];
    rkey01:=fieldvalues['CURRENCY_PTR'];
    tax_id_no.Caption:= trim(fieldbyname('FED_TAX_ID_NO').AsString);
    customer_type.Caption:=fieldvalues['CUSTOMER_TYPE'];
    sales_rep_name.Caption:=fieldvalues['sales_rep_name'];
   end
   else
    begin
     messagedlg('客户代码输入错误!',mterror,[mbcancel],0);
     edit1.SetFocus;
    end;
  end;
end
else
 begin
  rkey10:=0;
  label5.Caption:='';
  abbr_name.Caption:='';
  tax_id_no.Caption:='';
  customer_type.Caption:='';
  sales_rep_name.Caption:='';
 end;
end;

procedure TForm1.Edit2Exit(Sender: TObject);
begin
if trim(edit2.Text)<>'' then
begin
 with adoquery1 do
  begin
   close;
   sql.Clear;
   sql.Add('select CURR_CODE,CURR_NAME,RKEY,BASE_TO_OTHER');
   sql.Add('from data0001');
   sql.Add('where CURR_CODE='''+trim(edit2.Text)+'''');
   open;
   if not IsEmpty then
   begin
    label6.Caption:=fieldvalues['CURR_NAME'];
    exch_rate.Caption:=fieldbyname('BASE_TO_OTHER').AsString;
    rkey01:=fieldvalues['rkey'];
   end
   else
   begin
    messagedlg('货币代码输入错误!',mterror,[mbcancel],0);
    edit2.SetFocus;
   end;
  end;
end
else
 begin
  rkey01:=0;
  label6.Caption:='';
  exch_rate.Caption:='0';
 end;
end;

procedure TForm1.FormShow(Sender: TObject);
begin
if  ADOConnection1.Connected then
begin
 self.rkey10:=0;
 self.rkey01:=0;
 with ADOQuery1 do
 begin
  close;
  sql.Clear;
  sql.Add('select getdate() as sys_date');
  open;
  dtpk2.Date:=strtodate(datetostr(fieldvalues['sys_date']))-
                        dayof(fieldvalues['sys_date']);
  dtpk1.Date:=dtpk2.Date- dayof(dtpk2.Date)+1;
  self.v_date4:=dtpk1.Date-1;
  self.v_date3:=v_date4-dayof(v_date4);
  self.v_date2:=v_date3-dayof(v_date3);
  self.v_date1:=v_date2-dayof(v_date2);
  self.v_date0:=v_date1-dayof(v_date1);
 end;
end;
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
  with stringgrid1 do
  begin
    cells[0,0]:='客户代码';
    cells[1,0]:='客户简称';
    cells[2,0]:='货币';
    cells[3,0]:='汇率';

    cells[4,0]:='客户状态';
    cells[5,0]:='业务员';
    cells[6,0]:='付款方式';
    cells[7,0]:='期初欠款';
    cells[8,0]:='本期应收';
    cells[9,0]:='本期收款';
    cells[10,0]:='本期扣款';
    cells[11,0]:='期末余额';
    cells[12,0]:='期后应收';
    cells[13,0]:='期后收款';
    cells[14,0]:='期后扣款';
    cells[15,0]:='当前余额';

{    cells[4,0]:='付款方式';
    cells[5,0]:='期初欠款';
    cells[6,0]:='本期应收';
    cells[7,0]:='本期收款';
    cells[8,0]:='本期扣款';
    cells[9,0]:='期末余额';
    cells[10,0]:='期后应收';
    cells[11,0]:='期后收款';
    cells[12,0]:='期后扣款';
    cells[13,0]:='当前余额';   }

{    cells[14,0]:='<='+datetostr(self.v_date1);
    cells[15,0]:='<='+datetostr(self.v_date2);
    cells[16,0]:='<='+datetostr(self.v_date3);
    cells[17,0]:='<='+datetostr(self.v_date4);
    cells[18,0]:='<='+datetostr(dtpk2.Date);
    cells[19,0]:='>'+datetostr(dtpk2.Date);
 }   
  end;
 self.rkey10:=0;
 self.rkey01:=0; 
end;

procedure TForm1.BitBtn4Click(Sender: TObject);
var
 yishou,yishou_b:currency;
 i,v_i:integer;
 total_amount,total_amount_b,total_amount_allb:array[0..15] of currency;
begin
IF DTPK1.Date>dtpk2.Date then
 messagedlg('开始日期不能大于结束日期!',mterror,[mbcancel],0)
else
begin
 if stringgrid1.RowCount>2 then //重新初始化查询结果表格
 begin
  for i:=1 to stringgrid1.RowCount-1  do stringgrid1.Rows[i].Clear;
  for i:=1 to stringgrid2.RowCount-1  do stringgrid2.Rows[i].Clear;
  stringgrid1.RowCount:=2;
  stringgrid2.RowCount:=2;
 end;

 screen.Cursor:=crSQLWait;
 if checkbox1.Checked then
  begin
    stringgrid1.cells[16,0]:='<='+datetostr(self.v_date0);
    stringgrid1.cells[17,0]:='<='+datetostr(self.v_date1);
    stringgrid1.cells[18,0]:='<='+datetostr(self.v_date2);
    stringgrid1.cells[19,0]:='<='+datetostr(self.v_date3);
    stringgrid1.cells[20,0]:='<='+datetostr(self.v_date4);
    stringgrid1.cells[21,0]:='<='+datetostr(dtpk2.Date);
    stringgrid1.cells[22,0]:='>'+datetostr(dtpk2.Date);
  end;

if (rkey10 > 0) and (rkey01 > 0) then    //确定了客户同时确定货币
 begin
  aq_lengrece.Close;
  aq_lengrece.SQL.Delete(aq_lengrece.SQL.Count-2);
  aq_lengrece.SQL.Insert(aq_lengrece.SQL.Count-1,'and CUSTOMER_PTR='+inttostr(rkey10)+' and currency_ptr='+inttostr(rkey01));
  aq_lengrece.Parameters[0].Value:=dtpk1.Date;
  aq_lengrece.Parameters[1].Value:=dtpk2.Date;
  aq_lengrece.Open;                       //本期应收数据

  aq_lengyirece.Close;
  aq_lengyirece.SQL.Delete(aq_lengyirece.SQL.Count-2);
  aq_lengyirece.SQL.Insert(aq_lengyirece.SQL.Count-1,'and srce_ptr='+inttostr(rkey10)+' and CURRECY_PTR='+inttostr(rkey01));
  aq_lengyirece.Parameters[0].Value:=dtpk1.Date;
  aq_lengyirece.Parameters[1].Value:=dtpk2.Date;
  aq_lengyirece.Open;                    //本期已收数据

  aq_lengcredit.Close;
  aq_lengcredit.SQL.Delete(aq_lengcredit.SQL.Count-2);
  aq_lengcredit.SQL.Insert(aq_lengcredit.SQL.Count-1,'and cust_ptr='+inttostr(rkey10)+' and CURRENCY_PTR='+inttostr(rkey01));
  aq_lengcredit.Parameters[0].Value:=dtpk1.Date;
  aq_lengcredit.Parameters[1].Value:=dtpk2.Date;
  aq_lengcredit.Open;                    //本期扣款(贷方信用)

  aq_finarece.Close;
  aq_finarece.SQL.Delete(aq_finarece.SQL.Count-2);
  aq_finarece.SQL.Insert(aq_finarece.SQL.Count-1,'and CUSTOMER_PTR='+inttostr(rkey10)+' and currency_ptr='+inttostr(rkey01));
  aq_finarece.Parameters[0].Value:=dtpk2.Date;
  aq_finarece.Open;                       //期后应收数据

  aq_finayirece.Close;
  aq_finayirece.SQL.Delete(aq_finayirece.SQL.Count-2);
  aq_finayirece.SQL.Insert(aq_finayirece.SQL.Count-1,'and srce_ptr='+inttostr(rkey10)+' and CURRECY_PTR='+inttostr(rkey01));
  aq_finayirece.Parameters[0].Value:=dtpk2.Date;
  aq_finayirece.Open;                    //期后已收数据

  aq_finacredit.Close;
  aq_finacredit.SQL.Delete(aq_finacredit.SQL.Count-2);
  aq_finacredit.SQL.Insert(aq_finacredit.SQL.Count-1,'and cust_ptr='+inttostr(rkey10)+' and CURRENCY_PTR='+inttostr(rkey01));
  aq_finacredit.Parameters[0].Value:=dtpk2.Date;
  aq_finacredit.Open;                    //期后扣款(贷方信用)
  progressbar1.Position:=30;

  stringgrid1.RowCount:=3;
  stringgrid1.cells[0,1]:=edit1.Text;         //客户代码
  stringgrid1.cells[1,1]:=abbr_name.Caption;  //客户简称
  stringgrid1.cells[2,1]:=edit2.Text;         //货币
  stringgrid1.cells[3,1]:=exch_rate.Caption;  //汇率

  stringgrid1.cells[4,1]:=customer_type.Caption;   //客户状态
  stringgrid1.cells[5,1]:=sales_rep_name.Caption;  //业务员

  stringgrid1.cells[6,1]:=tax_id_no.Caption;  //付款方式
  stringgrid1.cells[1,2]:='本币总计';

  stringgrid1.cells[8,1]:=Formatfloat('#,##0.00',self.aq_lengreceDSDesigner.Value);  //'本期应收';
  stringgrid1.cells[9,1]:=Formatfloat('#,##0.00',self.aq_lengyireceDSDesigner.Value);//'本期收款';
  stringgrid1.cells[10,1]:=Formatfloat('#,##0.00',self.aq_lengcreditDSDesigner.Value);//'本期扣款';
  stringgrid1.cells[12,1]:=Formatfloat('#,##0.00',self.aq_finareceDSDesigner.Value);//'期后应收';
  stringgrid1.cells[13,1]:=Formatfloat('#,##0.00',self.aq_finayireceDSDesigner.Value);//'期后收款';
  stringgrid1.cells[14,1]:=Formatfloat('#,##0.00',self.aq_finacreditDSDesigner.Value);//'期后扣款';

  if radiogroup1.ItemIndex=0 then
  begin
   stringgrid1.cells[8,2]:=Formatfloat('#,##0.00',self.aq_lengreceDSDesigner2.Value); //'本期应收本币';
   stringgrid1.cells[9,2]:=Formatfloat('#,##0.00',self.aq_lengyireceDSDesigner2.Value);//'本期收款本币';
   stringgrid1.cells[10,2]:=Formatfloat('#,##0.00',self.aq_lengcreditDSDesigner2.Value);//'本期扣款本币';
   stringgrid1.cells[12,2]:=Formatfloat('#,##0.00',self.aq_finareceDSDesigner2.Value);//'期后应收本币';
   stringgrid1.cells[13,2]:=Formatfloat('#,##0.00',self.aq_finayireceDSDesigner2.Value);//'期后收款本币';
   stringgrid1.cells[14,2]:=Formatfloat('#,##0.00',self.aq_finacreditDSDesigner2.Value);//'期后扣款本币';
  end
  else
  begin
   stringgrid1.cells[8,2]:=Formatfloat('#,##0.00',self.aq_lengreceDSDesigner3.Value); //'本期应收本币';
   stringgrid1.cells[9,2]:=Formatfloat('#,##0.00',self.aq_lengyireceDSDesigner3.Value);//'本期收款本币';
   stringgrid1.cells[10,2]:=Formatfloat('#,##0.00',self.aq_lengcreditDSDesigner3.Value);//'本期扣款本币';
   stringgrid1.cells[12,2]:=Formatfloat('#,##0.00',self.aq_finareceDSDesigner3.Value);//'期后应收本币';
   stringgrid1.cells[13,2]:=Formatfloat('#,##0.00',self.aq_finayireceDSDesigner3.Value);//'期后收款本币';
   stringgrid1.cells[14,2]:=Formatfloat('#,##0.00',self.aq_finacreditDSDesigner3.Value);//'期后扣款本币';
  end;

  self.get_balance(rkey10,rkey01,yishou,yishou_b);
  stringgrid1.cells[15,1]:=Formatfloat('#,##0.00',yishou);   //'当前余额
  stringgrid1.cells[15,2]:=Formatfloat('#,##0.00',yishou_b); //'当前余额本币

  stringgrid1.cells[11,1]:=Formatfloat('#,##0.00',yishou+
                                     aq_finacreditDSDesigner.Value+
                                     aq_finayireceDSDesigner.Value-
                                     aq_finareceDSDesigner.Value);//'期末余额';
  if radiogroup1.ItemIndex=0 then
  stringgrid1.cells[11,2]:=Formatfloat('#,##0.00',yishou_b+
                                 aq_finacreditDSDesigner2.Value+
                                 aq_finayireceDSDesigner2.Value-
                                 aq_finareceDSDesigner2.Value)  //'期末余额本币';
  else
  stringgrid1.cells[11,2]:=Formatfloat('#,##0.00',yishou_b+
                                 aq_finacreditDSDesigner3.Value+
                                 aq_finayireceDSDesigner3.Value-
                                 aq_finareceDSDesigner3.Value); //'期末余额本币';
  progressbar1.Position:=70;
  stringgrid1.cells[7,1]:=Formatfloat('#,##0.00',
     strtocurr(RemoveInvalid(stringgrid1.cells[11,1]))+
     aq_lengcreditDSDesigner.Value+
     aq_lengyireceDSDesigner.Value-
     aq_lengreceDSDesigner.Value);  //'期初欠款';
 if radiogroup1.ItemIndex=0 then
  stringgrid1.cells[7,2]:=Formatfloat('#,##0.00',
    strtocurr(RemoveInvalid(stringgrid1.cells[11,2]))+
    aq_lengcreditDSDesigner2.Value+
    aq_lengyireceDSDesigner2.Value-
    aq_lengreceDSDesigner2.Value) //'本期初欠款本币';
 else
  stringgrid1.cells[7,2]:=Formatfloat('#,##0.00',
    strtocurr(RemoveInvalid(stringgrid1.cells[11,2]))+
    aq_lengcreditDSDesigner3.Value+
    aq_lengyireceDSDesigner3.Value-
    aq_lengreceDSDesigner3.Value); //'本期初欠款本币';
  progressbar1.Position:=80;

  if checkbox1.Checked then
   begin
  self.get_leng6(rkey10,rkey01,yishou,yishou_b);
  stringgrid1.cells[22,1]:=Formatfloat('#,##0.00',yishou);         //第六区间
  stringgrid1.cells[22,2]:=Formatfloat('#,##0.00',yishou_b);

  self.get_leng2_5(rkey10,rkey01,dtpk1.Date,dtpk2.Date,yishou,yishou_b);
  stringgrid1.cells[21,1] := Formatfloat('#,##0.00',yishou);       //第五区间
  stringgrid1.cells[21,2] := Formatfloat('#,##0.00',yishou_b);

  self.get_leng2_5(rkey10,rkey01,self.v_date3+1,self.v_date4,yishou,yishou_b);
  stringgrid1.cells[20,1] := Formatfloat('#,##0.00',yishou);       //第四区间
  stringgrid1.cells[20,2] := Formatfloat('#,##0.00',yishou_b);

  self.get_leng2_5(rkey10,rkey01,self.v_date2+1,self.v_date3,yishou,yishou_b);
  stringgrid1.cells[19,1] := Formatfloat('#,##0.00',yishou);       //第三区间
  stringgrid1.cells[19,2] := Formatfloat('#,##0.00',yishou_b);

  self.get_leng2_5(rkey10,rkey01,self.v_date1+1,self.v_date2,yishou,yishou_b);
  stringgrid1.cells[18,1] := Formatfloat('#,##0.00',yishou);       //第二区间
  stringgrid1.cells[18,2] := Formatfloat('#,##0.00',yishou_b);

  self.get_leng2_5(rkey10,rkey01,self.v_date0+1,self.v_date1,yishou,yishou_b);
  stringgrid1.cells[17,1] := Formatfloat('#,##0.00',yishou);       //第一区间
  stringgrid1.cells[17,2] := Formatfloat('#,##0.00',yishou_b);

  self.get_leng_1(rkey10,rkey01,self.v_date0,yishou,yishou_b);
  stringgrid1.cells[16,1] := Formatfloat('#,##0.00',yishou);       //第零区间
  stringgrid1.cells[16,2] := Formatfloat('#,##0.00',yishou_b);

  end;
  progressbar1.Position:=100;
 end
else
 if (rkey10 > 0) and (rkey01 = 0) then  //确定了客户但未确定货币
  begin
   for i:=0 to 15 do total_amount_b[i]:=0;

   aq_lengrece.Close;      //本期应收数据
   aq_lengrece.SQL.Delete(aq_lengrece.SQL.Count-2);
   aq_lengrece.SQL.Insert(aq_lengrece.SQL.Count-1,'and CUSTOMER_PTR='+inttostr(rkey10));
   aq_lengrece.Parameters[0].Value:=dtpk1.Date;
   aq_lengrece.Parameters[1].Value:=dtpk2.Date;
   aq_lengrece.Open;
   aq_lengyirece.Close;       //本期已收数据
   aq_lengyirece.SQL.Delete(aq_lengyirece.SQL.Count-2);
   aq_lengyirece.SQL.Insert(aq_lengyirece.SQL.Count-1,'and srce_ptr='+inttostr(rkey10));
   aq_lengyirece.Parameters[0].Value:=dtpk1.Date;
   aq_lengyirece.Parameters[1].Value:=dtpk2.Date;
   aq_lengyirece.Open;
   aq_lengcredit.Close;       //本期扣款(贷方信用)
   aq_lengcredit.SQL.Delete(aq_lengcredit.SQL.Count-2);
   aq_lengcredit.SQL.Insert(aq_lengcredit.SQL.Count-1,'and cust_ptr='+inttostr(rkey10));
   aq_lengcredit.Parameters[0].Value:=dtpk1.Date;
   aq_lengcredit.Parameters[1].Value:=dtpk2.Date;
   aq_lengcredit.Open;
   aq_finarece.Close;
   aq_finarece.SQL.Delete(aq_finarece.SQL.Count-2);
   aq_finarece.SQL.Insert(aq_finarece.SQL.Count-1,'and CUSTOMER_PTR='+inttostr(rkey10));
   aq_finarece.Parameters[0].Value:=dtpk2.Date;
   aq_finarece.Open;                       //期后应收数据
   aq_finayirece.Close;
   aq_finayirece.SQL.Delete(aq_finayirece.SQL.Count-2);
   aq_finayirece.SQL.Insert(aq_finayirece.SQL.Count-1,'and srce_ptr='+inttostr(rkey10));
   aq_finayirece.Parameters[0].Value:=dtpk2.Date;
   aq_finayirece.Open;                    //期后已收数据
   aq_finacredit.Close;
   aq_finacredit.SQL.Delete(aq_finacredit.SQL.Count-2);
   aq_finacredit.SQL.Insert(aq_finacredit.SQL.Count-1,'and cust_ptr='+inttostr(rkey10));
   aq_finacredit.Parameters[0].Value:=dtpk2.Date;
   aq_finacredit.Open;                    //期后扣款(贷方信用)
   with aq_balance do        //当前余额查询
   begin
    close;
    sql.Delete(7);
    sql.Insert(7,'and CUSTOMER_PTR='+inttostr(rkey10));
    sql.Delete(8);
    sql.Insert(8,'');
    sql.Delete(18);
    sql.Insert(18,'and cust_ptr='+inttostr(rkey10));
    sql.Delete(19);
    sql.Insert(19,'');
    open;
   end;

   while not aq_lengrece.Eof do
    begin
     if checkbox1.Checked then
      for i:=7 to 22 do stringgrid1.cells[i,stringgrid1.RowCount-1]:='0.00'
     else
      for i:=7 to 15 do stringgrid1.cells[i,stringgrid1.RowCount-1]:='0.00';

     stringgrid1.cells[0,stringgrid1.RowCount-1]:= edit1.Text;         //客户代码
     stringgrid1.cells[1,stringgrid1.RowCount-1]:= abbr_name.Caption;  //客户简称

     stringgrid1.cells[4,stringgrid1.RowCount-1]:= customer_type.Caption;    //客户状态
     stringgrid1.cells[5,stringgrid1.RowCount-1]:= sales_rep_name.Caption;  //业务员

     with adoquery1 do
      begin
       close;
       sql.Clear;
       sql.Add('select CURR_CODE,BASE_TO_OTHER from data0001');
       sql.Add('where rkey='+aq_lengreceCURRENCY_PTR.AsString);
       open;
      end;
     stringgrid1.cells[2,stringgrid1.RowCount-1]:=adoquery1.FieldValues['curr_code'];//货币
     stringgrid1.cells[3,stringgrid1.RowCount-1]:=adoquery1.fieldbyname('BASE_TO_OTHER').AsString;//汇率
     stringgrid1.cells[6,stringgrid1.RowCount-1]:= tax_id_no.Caption;  //付款方式
                                            //本期应收原币;
     stringgrid1.cells[8,stringgrid1.RowCount-1]:= Formatfloat('#,##0.00',aq_lengreceDSDesigner.Value);

     if radiogroup1.ItemIndex=0 then          //记帐汇率本期应收本币
      total_amount_b[1]:=total_amount_b[1]+aq_lengreceDSDesigner2.Value
     else                                    //浮动汇率本期应收本币
      total_amount_b[1]:=total_amount_b[1]+aq_lengreceDSDesigner3.Value;

     stringgrid2.Cells[0,stringgrid2.RowCount-1]:= inttostr(rkey10);
     stringgrid2.Cells[1,stringgrid2.RowCount-1]:= aq_lengreceCURRENCY_PTR.AsString;
     stringgrid1.RowCount:=stringgrid1.RowCount+1;
     stringgrid2.RowCount:=stringgrid2.RowCount+1;
     aq_lengrece.Next;
    end;
  progressbar1.Position:=10;

  while not aq_lengyirece.Eof do
   begin
    if aq_lengrece.Locate('CURRENCY_PTR',aq_lengyireceCURRECY_PTR.Value,[]) then
     begin
      stringgrid1.cells[9,aq_lengrece.RecNo]:=Formatfloat('#,##0.00',aq_lengyireceDSDesigner.Value);//'本期收款';
      if radiogroup1.ItemIndex=0 then
      total_amount_b[2]:=total_amount_b[2]+aq_lengyireceDSDesigner2.Value
      else
      total_amount_b[2]:=total_amount_b[2]+aq_lengyireceDSDesigner3.Value;
     end
    else      //如倮货币没有那么增加stringgrid1记录
     begin
      if checkbox1.Checked then
       for i:=7 to 22 do stringgrid1.cells[i,stringgrid1.RowCount-1]:='0.00'
      else
       for i:=7 to 15 do stringgrid1.cells[i,stringgrid1.RowCount-1]:='0.00';
      stringgrid1.cells[0,stringgrid1.RowCount-1]:= edit1.Text;         //客户代码
      stringgrid1.cells[1,stringgrid1.RowCount-1]:= abbr_name.Caption;  //客户简称

      stringgrid1.cells[4,stringgrid1.RowCount-1]:= customer_type.Caption;    //客户状态
      stringgrid1.cells[5,stringgrid1.RowCount-1]:= sales_rep_name.Caption;   //业务员

      with adoquery1 do
      begin
       close;
       sql.Clear;
       sql.Add('select CURR_CODE,BASE_TO_OTHER from data0001');
       sql.Add('where rkey='+aq_lengyireceCURRECY_PTR.AsString);
       open;
      end;
      stringgrid1.cells[2,stringgrid1.RowCount-1]:=adoquery1.FieldValues['curr_code'];//货币
      stringgrid1.cells[3,stringgrid1.RowCount-1]:=adoquery1.fieldbyname('BASE_TO_OTHER').AsString;//汇率
      stringgrid1.cells[6,stringgrid1.RowCount-1]:= tax_id_no.Caption;  //付款方式

      stringgrid1.cells[9,stringgrid1.RowCount-1]:= Formatfloat('#,##0.00',aq_lengyireceDSDesigner.Value);//'本期应收';
      if radiogroup1.ItemIndex=0 then
      total_amount_b[2]:=total_amount_b[2]+aq_lengyireceDSDesigner2.Value
      else
      total_amount_b[2]:=total_amount_b[2]+aq_lengyireceDSDesigner3.Value;
      stringgrid2.Cells[0,stringgrid2.RowCount-1]:= inttostr(rkey10);
      stringgrid2.Cells[1,stringgrid2.RowCount-1]:= aq_lengyireceCURRECY_PTR.AsString;
      stringgrid1.RowCount:=stringgrid1.RowCount+1;
      stringgrid2.RowCount:=stringgrid2.RowCount+1;
     end;
    aq_lengyirece.Next;
   end;
  progressbar1.Position:=20;

  while not aq_lengcredit.Eof do
   begin
    i:= get_currency(AQ_lengcreditCURRENCY_PTR.Value);
    if i > 0 then
     begin
      stringgrid1.cells[10,i]:=Formatfloat('#,##0.00',aq_lengcreditDSDesigner.Value);//'本期扣款';
      if radiogroup1.ItemIndex=0 then
      total_amount_b[3]:=total_amount_b[3]+aq_lengcreditDSDesigner2.Value
      else
      total_amount_b[3]:=total_amount_b[3]+aq_lengcreditDSDesigner3.Value;
     end
    else      //如倮货币没有那么增加stringgrid1记录
     begin
      if checkbox1.Checked then
       for i:=7 to 22 do stringgrid1.cells[i,stringgrid1.RowCount-1]:='0.00'
      else
       for i:=7 to 15 do stringgrid1.cells[i,stringgrid1.RowCount-1]:='0.00';

      stringgrid1.cells[0,stringgrid1.RowCount-1]:= edit1.Text;         //客户代码
      stringgrid1.cells[1,stringgrid1.RowCount-1]:= abbr_name.Caption;  //客户简称

      stringgrid1.cells[4,stringgrid1.RowCount-1]:= customer_type.Caption;    //客户状态
      stringgrid1.cells[5,stringgrid1.RowCount-1]:= sales_rep_name.Caption;  //业务员

      with adoquery1 do
      begin
       close;
       sql.Clear;
       sql.Add('select CURR_CODE,BASE_TO_OTHER from data0001');
       sql.Add('where rkey='+AQ_lengcreditCURRENCY_PTR.AsString);
       open;
      end;
      stringgrid1.cells[2,stringgrid1.RowCount-1]:=adoquery1.FieldValues['curr_code'];//货币
      stringgrid1.cells[3,stringgrid1.RowCount-1]:=adoquery1.fieldbyname('BASE_TO_OTHER').AsString;//汇率
      stringgrid1.cells[6,stringgrid1.RowCount-1]:= tax_id_no.Caption;  //付款方式

      stringgrid1.cells[10,stringgrid1.RowCount-1]:= Formatfloat('#,##0.00',aq_lengcreditDSDesigner.Value);//'本期扣款';
      if radiogroup1.ItemIndex=0 then
      total_amount_b[3]:=total_amount_b[3]+aq_lengcreditDSDesigner2.Value
      else
      total_amount_b[3]:=total_amount_b[3]+aq_lengcreditDSDesigner3.Value;
      stringgrid2.Cells[0,stringgrid2.RowCount-1]:= inttostr(rkey10);
      stringgrid2.Cells[1,stringgrid2.RowCount-1]:= aq_lengcreditCURRENCY_PTR.AsString;
      stringgrid1.RowCount:=stringgrid1.RowCount+1;
      stringgrid2.RowCount:=stringgrid2.RowCount+1;
     end;
    aq_lengcredit.Next;
   end;
  progressbar1.Position:=30;

  while not aq_finarece.Eof do
   begin
    i:= get_currency(aq_finarececurrency_ptr.Value);
    if i > 0 then
     begin
      stringgrid1.cells[12,i]:=Formatfloat('#,##0.00',aq_finareceDSDesigner.Value);//'本期收款';
      if radiogroup1.ItemIndex=0 then
      total_amount_b[5]:=total_amount_b[5]+aq_finareceDSDesigner2.Value
      else
      total_amount_b[5]:=total_amount_b[5]+aq_finareceDSDesigner3.Value;      
     end
    else      //如倮货币没有那么增加stringgrid1记录
     begin
      if checkbox1.Checked then
       for i:=7 to 22 do stringgrid1.cells[i,stringgrid1.RowCount-1]:='0.00'
      else
       for i:=7 to 15 do stringgrid1.cells[i,stringgrid1.RowCount-1]:='0.00';
      stringgrid1.cells[0,stringgrid1.RowCount-1]:= edit1.Text;         //客户代码
      stringgrid1.cells[1,stringgrid1.RowCount-1]:= abbr_name.Caption;  //客户简称

      stringgrid1.cells[4,stringgrid1.RowCount-1]:= customer_type.Caption;    //客户状态
      stringgrid1.cells[5,stringgrid1.RowCount-1]:= sales_rep_name.Caption;  //业务员

      with adoquery1 do
      begin
       close;
       sql.Clear;
       sql.Add('select CURR_CODE,BASE_TO_OTHER from data0001');
       sql.Add('where rkey='+aq_finarececurrency_ptr.AsString);
       open;
      end;
      stringgrid1.cells[2,stringgrid1.RowCount-1]:=adoquery1.FieldValues['curr_code'];//货币
      stringgrid1.cells[3,stringgrid1.RowCount-1]:=adoquery1.fieldbyname('BASE_TO_OTHER').AsString;//汇率
      stringgrid1.cells[6,stringgrid1.RowCount-1]:= tax_id_no.Caption;  //付款方式

      stringgrid1.cells[12,stringgrid1.RowCount-1]:= Formatfloat('#,##0.00',aq_finareceDSDesigner.Value);//'款后应收';
      if radiogroup1.ItemIndex=0 then
      total_amount_b[5]:=total_amount_b[5]+aq_finareceDSDesigner2.Value
      else
      total_amount_b[5]:=total_amount_b[5]+aq_finareceDSDesigner3.Value;
      stringgrid2.Cells[0,stringgrid2.RowCount-1]:= inttostr(rkey10);
      stringgrid2.Cells[1,stringgrid2.RowCount-1]:= aq_finareceCURRENCY_PTR.AsString;
      stringgrid1.RowCount:=stringgrid1.RowCount+1;
      stringgrid2.RowCount:=stringgrid2.RowCount+1;
     end;
    aq_finarece.Next;
   end;
  progressbar1.Position:=40;

  while not aq_finayirece.Eof do
   begin
    i:= get_currency(aq_finayirececurrecy_ptr.Value);
    if i > 0 then
     begin
      stringgrid1.cells[13,i]:=Formatfloat('#,##0.00',aq_finayireceDSDesigner.Value);
      if radiogroup1.ItemIndex=0 then
      total_amount_b[6]:=total_amount_b[6]+aq_finayireceDSDesigner2.Value
      else
      total_amount_b[6]:=total_amount_b[6]+aq_finayireceDSDesigner3.Value;
     end
    else      //如倮货币没有那么增加stringgrid1记录
     begin
      if checkbox1.Checked then
       for i:=7 to 22 do stringgrid1.cells[i,stringgrid1.RowCount-1]:='0.00'
      else
       for i:=7 to 15 do stringgrid1.cells[i,stringgrid1.RowCount-1]:='0.00';
      stringgrid1.cells[0,stringgrid1.RowCount-1]:= edit1.Text;         //客户代码
      stringgrid1.cells[1,stringgrid1.RowCount-1]:= abbr_name.Caption;  //客户简称

      stringgrid1.cells[4,stringgrid1.RowCount-1]:= customer_type.Caption;    //客户状态
      stringgrid1.cells[5,stringgrid1.RowCount-1]:= sales_rep_name.Caption;  //业务员

      with adoquery1 do
      begin
       close;
       sql.Clear;
       sql.Add('select CURR_CODE,BASE_TO_OTHER from data0001');
       sql.Add('where rkey='+aq_finayirececurrecy_ptr.AsString);
       open;
      end;
      stringgrid1.cells[2,stringgrid1.RowCount-1]:=adoquery1.FieldValues['curr_code'];//货币
      stringgrid1.cells[3,stringgrid1.RowCount-1]:=adoquery1.fieldbyname('BASE_TO_OTHER').AsString;//汇率
      stringgrid1.cells[6,stringgrid1.RowCount-1]:= tax_id_no.Caption;  //付款方式

      stringgrid1.cells[13,stringgrid1.RowCount-1]:= Formatfloat('#,##0.00',aq_finayireceDSDesigner.Value);
      if radiogroup1.ItemIndex=0 then
      total_amount_b[6]:=total_amount_b[6]+aq_finayireceDSDesigner2.Value
      else
      total_amount_b[6]:=total_amount_b[6]+aq_finayireceDSDesigner3.Value;
      stringgrid2.Cells[0,stringgrid2.RowCount-1]:= inttostr(rkey10);
      stringgrid2.Cells[1,stringgrid2.RowCount-1]:= aq_finayireceCURRECY_PTR.AsString;
      stringgrid1.RowCount:=stringgrid1.RowCount+1;
      stringgrid2.RowCount:=stringgrid2.RowCount+1;
     end;

    aq_finayirece.Next;
   end;
  progressbar1.Position:=50;

  while not aq_finacredit.Eof do
   begin
    i:= get_currency(self.AQ_finacreditcurrency_ptr.Value);
    if i > 0 then
     begin
      stringgrid1.cells[14,i]:=Formatfloat('#,##0.00',aq_finacreditDSDesigner.Value);
      if radiogroup1.ItemIndex=0 then
      total_amount_b[7]:=total_amount_b[7]+aq_finacreditDSDesigner2.Value
      else
      total_amount_b[7]:=total_amount_b[7]+aq_finacreditDSDesigner3.Value;
     end
    else      //如倮货币没有那么增加stringgrid1记录
     begin
      if checkbox1.Checked then
       for i:=7 to 22 do stringgrid1.cells[i,stringgrid1.RowCount-1]:='0.00'
      else
       for i:=7 to 15 do stringgrid1.cells[i,stringgrid1.RowCount-1]:='0.00';
      stringgrid1.cells[0,stringgrid1.RowCount-1]:= edit1.Text;         //客户代码
      stringgrid1.cells[1,stringgrid1.RowCount-1]:= abbr_name.Caption;  //客户简称

      stringgrid1.cells[4,stringgrid1.RowCount-1]:= customer_type.Caption;    //客户状态
      stringgrid1.cells[5,stringgrid1.RowCount-1]:= sales_rep_name.Caption;  //业务员

      with adoquery1 do
      begin
       close;
       sql.Clear;
       sql.Add('select CURR_CODE,BASE_TO_OTHER from data0001');
       sql.Add('where rkey='+AQ_finacreditcurrency_ptr.AsString);
       open;
      end;
      stringgrid1.cells[2,stringgrid1.RowCount-1]:=adoquery1.FieldValues['curr_code'];//货币
      stringgrid1.cells[3,stringgrid1.RowCount-1]:=adoquery1.fieldbyname('BASE_TO_OTHER').AsString;//汇率
      stringgrid1.cells[6,stringgrid1.RowCount-1]:= tax_id_no.Caption;  //付款方式

      stringgrid1.cells[14,stringgrid1.RowCount-1]:= Formatfloat('#,##0.00',aq_finacreditDSDesigner.Value);
      if radiogroup1.ItemIndex=0 then
      total_amount_b[7]:=total_amount_b[7]+aq_finacreditDSDesigner2.Value
      else
      total_amount_b[7]:=total_amount_b[7]+aq_finacreditDSDesigner3.Value;
      stringgrid2.Cells[0,stringgrid2.RowCount-1]:= inttostr(rkey10);
      stringgrid2.Cells[1,stringgrid2.RowCount-1]:= aq_finacreditCURRENCY_PTR.AsString;
      stringgrid1.RowCount:=stringgrid1.RowCount+1;
      stringgrid2.RowCount:=stringgrid2.RowCount+1;
     end;
    aq_finacredit.Next;
   end;
   progressbar1.Position:=60;

   while not aq_balance.Eof do
    begin
    i:= get_currency(self.AQ_balanceCURRENCY_PTR.Value);
    if i > 0 then
     begin
      stringgrid1.cells[15,i]:=Formatfloat('#,##0.00',
                strtocurr(RemoveInvalid(stringgrid1.cells[15,i]))+
                AQ_balanceDSDesigner.Value);//当前余额
      if radiogroup1.ItemIndex=0 then
      total_amount_b[8]:=total_amount_b[8]+AQ_balanceDSDesigner2.Value
      else
      total_amount_b[8]:=total_amount_b[8]+AQ_balanceDSDesigner3.Value;
     end
    else      //如倮货币没有那么增加stringgrid1记录
     begin
      if checkbox1.Checked then
       for i:=7 to 22 do stringgrid1.cells[i,stringgrid1.RowCount-1]:='0.00'
      else
       for i:=7 to 15 do stringgrid1.cells[i,stringgrid1.RowCount-1]:='0.00';
      stringgrid1.cells[0,stringgrid1.RowCount-1]:= edit1.Text;         //客户代码
      stringgrid1.cells[1,stringgrid1.RowCount-1]:= abbr_name.Caption;  //客户简称

      stringgrid1.cells[4,stringgrid1.RowCount-1]:= customer_type.Caption;    //客户状态
      stringgrid1.cells[5,stringgrid1.RowCount-1]:= sales_rep_name.Caption;  //业务员

      with adoquery1 do
      begin
       close;
       sql.Clear;
       sql.Add('select CURR_CODE,BASE_TO_OTHER from data0001');
       sql.Add('where rkey='+AQ_balanceCURRENCY_PTR.AsString);
       open;
      end;
      stringgrid1.cells[2,stringgrid1.RowCount-1]:=adoquery1.FieldValues['curr_code'];//货币
      stringgrid1.cells[3,stringgrid1.RowCount-1]:=adoquery1.fieldbyname('BASE_TO_OTHER').AsString;//汇率
      stringgrid1.cells[6,stringgrid1.RowCount-1]:= tax_id_no.Caption;  //付款方式

      stringgrid1.cells[15,stringgrid1.RowCount-1]:= Formatfloat('#,##0.00',AQ_balanceDSDesigner.Value);
      if radiogroup1.ItemIndex=0 then
      total_amount_b[8]:=total_amount_b[8]+AQ_balanceDSDesigner2.Value
      else
      total_amount_b[8]:=total_amount_b[8]+AQ_balanceDSDesigner3.Value;

      stringgrid2.Cells[0,stringgrid2.RowCount-1]:= inttostr(rkey10);
      stringgrid2.Cells[1,stringgrid2.RowCount-1]:= self.AQ_balanceCURRENCY_PTR.AsString;
      stringgrid1.RowCount:=stringgrid1.RowCount+1;
      stringgrid2.RowCount:=stringgrid2.RowCount+1;
     end;
     aq_balance.Next;
    end;
  progressbar1.Position:=70;

  for i:=1 to stringgrid2.RowCount-2 do
   begin
    stringgrid1.cells[11,i]:=Formatfloat('#,##0.00',
                       strtocurr(RemoveInvalid(stringgrid1.cells[15,i]))+
                       strtocurr(RemoveInvalid(stringgrid1.cells[14,i]))+
                       strtocurr(RemoveInvalid(stringgrid1.cells[13,i]))-
                       strtocurr(RemoveInvalid(stringgrid1.cells[12,i])));//'期末余额';

    stringgrid1.cells[7,i]:=Formatfloat('#,##0.00',
                       strtocurr(RemoveInvalid(stringgrid1.cells[11,i]))+
                       strtocurr(RemoveInvalid(stringgrid1.cells[10,i]))+
                       strtocurr(RemoveInvalid(stringgrid1.cells[9,i]))-
                       strtocurr(RemoveInvalid(stringgrid1.cells[8,i])));  //'期初欠款';
   if checkbox1.Checked then
    begin
    self.get_leng6(strtoint(stringgrid2.Cells[0,i]),strtoint(stringgrid2.Cells[1,i]),
                 yishou,yishou_b);
    stringgrid1.cells[22,i]:=Formatfloat('#,##0.00',yishou);         //第六区间
    total_amount_b[15]:=total_amount_b[15]+yishou_b;

    self.get_leng2_5(strtoint(stringgrid2.Cells[0,i]),strtoint(stringgrid2.Cells[1,i]),
                   dtpk1.Date,dtpk2.Date,yishou,yishou_b);
    stringgrid1.cells[21,i] := Formatfloat('#,##0.00',yishou);       //第五区间
    total_amount_b[14]:=total_amount_b[14]+yishou_b;

    self.get_leng2_5(strtoint(stringgrid2.Cells[0,i]),strtoint(stringgrid2.Cells[1,i]),
                   self.v_date3+1,self.v_date4,yishou,yishou_b);
    stringgrid1.cells[20,i] := Formatfloat('#,##0.00',yishou);       //第四区间
    total_amount_b[13]:=total_amount_b[13]+yishou_b;

    self.get_leng2_5(strtoint(stringgrid2.Cells[0,i]),strtoint(stringgrid2.Cells[1,i]),
                   self.v_date2+1,self.v_date3,yishou,yishou_b);
    stringgrid1.cells[19,i] := Formatfloat('#,##0.00',yishou);       //第三区间
    total_amount_b[12] := total_amount_b[12]+yishou_b;

    self.get_leng2_5(strtoint(stringgrid2.Cells[0,i]),strtoint(stringgrid2.Cells[1,i]),
                   self.v_date1+1,self.v_date2,yishou,yishou_b);
    stringgrid1.cells[18,i] := Formatfloat('#,##0.00',yishou);       //第二区间
    total_amount_b[11] := total_amount_b[11]+yishou_b;

    self.get_leng2_5(strtoint(stringgrid2.Cells[0,i]),strtoint(stringgrid2.Cells[1,i]),
                   self.v_date0+1,self.v_date1,yishou,yishou_b);
    stringgrid1.cells[17,i] := Formatfloat('#,##0.00',yishou);       //第一区间
    total_amount_b[10] := total_amount_b[10]+yishou_b;

    self.get_leng_1(strtoint(stringgrid2.Cells[0,i]),strtoint(stringgrid2.Cells[1,i]),
                  self.v_date0,yishou,yishou_b);
    stringgrid1.cells[16,i] := Formatfloat('#,##0.00',yishou);       //第零区间
    total_amount_b[9] := total_amount_b[9]+yishou_b;
    end;
   end;
   progressbar1.Position:=90;
   if self.find_date(total_amount_b) then                 //处理最后一行数据
   begin
   stringgrid1.cells[1,stringgrid1.RowCount-1]:='本币总计';
   if checkbox1.Checked then
   for i:=7 to 22 do
    stringgrid1.cells[i,stringgrid1.RowCount-1]:=Formatfloat('#,##0.00', total_amount_b[i-7])
   else
    for i:=7 to 15 do
     stringgrid1.cells[i,stringgrid1.RowCount-1]:=Formatfloat('#,##0.00', total_amount_b[i-7]);

    stringgrid1.cells[11,stringgrid1.RowCount-1]:=Formatfloat('#,##0.00',
                       strtocurr(RemoveInvalid(stringgrid1.cells[15,stringgrid1.RowCount-1]))+
                       strtocurr(RemoveInvalid(stringgrid1.cells[14,stringgrid1.RowCount-1]))+
                       strtocurr(RemoveInvalid(stringgrid1.cells[13,stringgrid1.RowCount-1]))-
                       strtocurr(RemoveInvalid(stringgrid1.cells[12,stringgrid1.RowCount-1])));//'期末余额';

    stringgrid1.cells[7,stringgrid1.RowCount-1]:=Formatfloat('#,##0.00',
                       strtocurr(RemoveInvalid(stringgrid1.cells[11,stringgrid1.RowCount-1]))+
                       strtocurr(RemoveInvalid(stringgrid1.cells[10,stringgrid1.RowCount-1]))+
                       strtocurr(RemoveInvalid(stringgrid1.cells[9,stringgrid1.RowCount-1]))-
                       strtocurr(RemoveInvalid(stringgrid1.cells[8,stringgrid1.RowCount-1])));  //'期初欠款';
   end;
   progressbar1.Position:=100;
  end
 else
 if (rkey10 = 0) and (rkey01 > 0) then  //确定了货币但未确定客户
  begin
   for i:=0 to 15 do
    begin
     total_amount_b[i]:=0;
     total_amount[i]:=0;
    end;
   aq_lengrece.Close;      //本期应收数据        1
   aq_lengrece.SQL.Delete(aq_lengrece.SQL.Count-2);
   aq_lengrece.SQL.Insert(aq_lengrece.SQL.Count-1,'and CURRENCY_PTR='+inttostr(rkey01));
   aq_lengrece.Parameters[0].Value:=dtpk1.Date;
   aq_lengrece.Parameters[1].Value:=dtpk2.Date;
   aq_lengrece.Open;
   aq_lengyirece.Close;       //本期已收数据         2
   aq_lengyirece.SQL.Delete(aq_lengyirece.SQL.Count-2);
   aq_lengyirece.SQL.Insert(aq_lengyirece.SQL.Count-1,'and CURRECY_PTR='+inttostr(rkey01));
   aq_lengyirece.Parameters[0].Value:=dtpk1.Date;
   aq_lengyirece.Parameters[1].Value:=dtpk2.Date;
   aq_lengyirece.Open;
  aq_lengcredit.Close;       //本期扣款(贷方信用)    3
  aq_lengcredit.SQL.Delete(aq_lengcredit.SQL.Count-2);
  aq_lengcredit.SQL.Insert(aq_lengcredit.SQL.Count-1,'and CURRENCY_PTR='+inttostr(rkey01));
  aq_lengcredit.Parameters[0].Value:=dtpk1.Date;
  aq_lengcredit.Parameters[1].Value:=dtpk2.Date;
  aq_lengcredit.Open;
  aq_finarece.Close;                //期后应收数据    4
  aq_finarece.SQL.Delete(aq_finarece.SQL.Count-2);
  aq_finarece.SQL.Insert(aq_finarece.SQL.Count-1,'and CURRENCY_PTR='+inttostr(rkey01));
  aq_finarece.Parameters[0].Value:=dtpk2.Date;
  aq_finarece.Open;
  aq_finayirece.Close;               //期后已收数据   5
  aq_finayirece.SQL.Delete(aq_finayirece.SQL.Count-2);
  aq_finayirece.SQL.Insert(aq_finayirece.SQL.Count-1,'and CURRECY_PTR='+inttostr(rkey01));
  aq_finayirece.Parameters[0].Value:=dtpk2.Date;
  aq_finayirece.Open;
  aq_finacredit.Close;            //期后扣款(贷方信用)   6
  aq_finacredit.SQL.Delete(aq_finacredit.SQL.Count-2);
  aq_finacredit.SQL.Insert(aq_finacredit.SQL.Count-1,'and CURRENCY_PTR='+inttostr(rkey01));
  aq_finacredit.Parameters[0].Value:=dtpk2.Date;
  aq_finacredit.Open;
  with aq_balance do              //当前余额查询    7
   begin
    close;
    sql.Delete(7);
    sql.Insert(7,'and CURRENCY_PTR='+inttostr(rkey01));
    sql.Delete(8);
    sql.Insert(8,'');
    sql.Delete(18);
    sql.Insert(18,'and CURRENCY_PTR='+inttostr(rkey01));
    sql.Delete(19);
    sql.Insert(19,'');
    open;
   end;

   while not aq_lengrece.Eof do
    begin
    if checkbox1.Checked then
     for i:=7 to 22 do stringgrid1.cells[i,stringgrid1.RowCount-1]:='0.00'
    else
     for i:=7 to 15 do stringgrid1.cells[i,stringgrid1.RowCount-1]:='0.00';

     with adoquery1 do
      begin
       close;
       sql.Clear;
       sql.Add('SELECT  Data0010.CUST_CODE, Data0010.ABBR_NAME,');
       SQL.Add('Data0010.FED_TAX_ID_NO, CASE dbo.Data0010.CUSTOMER_TYPE ');
       sql.Add('WHEN 1 THEN ''正常'' WHEN 2 THEN ''新合作'' WHEN 3 THEN ''控制''');
       sql.Add('WHEN 4 THEN ''停止'' END AS CUSTOMER_TYPE, Data0005.EMPLOYEE_NAME as SALES_REP_NAME');
       sql.Add('FROM  Data0010 INNER JOIN ');
       sql.Add('Data0005 ON dbo.Data0010.SALES_REP_PTR = dbo.Data0005.RKEY ');
       sql.Add('where dbo.Data0010.rkey='+aq_lengrececustomer_ptr.AsString);
       open;
      end;
     stringgrid1.cells[0,stringgrid1.RowCount-1]:= adoquery1.FieldValues['CUST_CODE']; //客户代码
     stringgrid1.cells[1,stringgrid1.RowCount-1]:= adoquery1.FieldValues['abbr_name'];  //客户简称
     stringgrid1.cells[2,stringgrid1.RowCount-1]:=edit2.Text;//货币
     stringgrid1.cells[3,stringgrid1.RowCount-1]:=exch_rate.Caption;//汇率
     stringgrid1.cells[4,stringgrid1.RowCount-1]:= adoquery1.FieldValues['CUSTOMER_TYPE'];    //客户状态
     stringgrid1.cells[5,stringgrid1.RowCount-1]:= adoquery1.FieldValues['SALES_REP_NAME'];   //业务员
     stringgrid1.cells[6,stringgrid1.RowCount-1]:= adoquery1.fieldbyname('FED_TAX_ID_NO').AsString;  //付款方式
     stringgrid1.cells[8,stringgrid1.RowCount-1]:= Formatfloat('#,##0.00',aq_lengreceDSDesigner.Value);//'本期应收';
     if radiogroup1.ItemIndex=0 then
     total_amount_b[1]:=total_amount_b[1]+aq_lengreceDSDesigner2.Value
     else
     total_amount_b[1]:=total_amount_b[1]+aq_lengreceDSDesigner3.Value;

     total_amount[1]:=total_amount[1]+aq_lengreceDSDesigner.Value;

     stringgrid2.Cells[0,stringgrid2.RowCount-1]:= aq_lengreceCUSTOMER_PTR.AsString;
     stringgrid2.Cells[1,stringgrid2.RowCount-1]:= inttostr(rkey01);
     stringgrid1.RowCount:=stringgrid1.RowCount+1;
     stringgrid2.RowCount:=stringgrid2.RowCount+1;
     aq_lengrece.Next;
    end;
  progressbar1.Position:=10;

  while not aq_lengyirece.Eof do
   begin
    if aq_lengrece.Locate('CUSTOMER_PTR',aq_lengyireceSRCE_PTR.Value,[]) then
     begin
      stringgrid1.cells[9,aq_lengrece.RecNo]:=Formatfloat('#,##0.00',aq_lengyireceDSDesigner.Value);
      if radiogroup1.ItemIndex=0 then
      total_amount_b[2]:=total_amount_b[2]+aq_lengyireceDSDesigner2.Value
      else
      total_amount_b[2]:=total_amount_b[2]+aq_lengyireceDSDesigner3.Value;
      total_amount[2]:=total_amount[2]+aq_lengyireceDSDesigner.Value;
     end
    else      //如倮客户没有那么增加stringgrid1记录
     begin
      if checkbox1.Checked then
       for i:=7 to 22 do stringgrid1.cells[i,stringgrid1.RowCount-1]:='0.00'
      else
       for i:=7 to 15 do stringgrid1.cells[i,stringgrid1.RowCount-1]:='0.00';
     with adoquery1 do
      begin
       close;
       sql.Clear;
       sql.Add('SELECT Data0010.CUST_CODE,Data0010.ABBR_NAME, ');
       sql.Add('Data0010.FED_TAX_ID_NO, CASE Data0010.CUSTOMER_TYPE ');
       sql.Add('WHEN 1 THEN ''正常'' WHEN 2 THEN ''新合作'' WHEN 3 THEN ''控制''');
       sql.Add('WHEN 4 THEN ''停止'' END AS CUSTOMER_TYPE, Data0005.EMPLOYEE_NAME as SALES_REP_NAME');
       sql.Add('FROM       dbo.Data0010 INNER JOIN ');
       sql.Add('           dbo.Data0005 ON dbo.Data0010.SALES_REP_PTR = dbo.Data0005.RKEY ');
       sql.Add('where dbo.Data0010.rkey='+aq_lengyireceSRCE_PTR.AsString);
       open;
      end;

      stringgrid1.cells[0,stringgrid1.RowCount-1]:= adoquery1.FieldValues['CUST_CODE'];//客户代码
      stringgrid1.cells[1,stringgrid1.RowCount-1]:= adoquery1.FieldValues['abbr_name'];//客户简称
      stringgrid1.cells[2,stringgrid1.RowCount-1]:=edit2.Text;//货币
      stringgrid1.cells[3,stringgrid1.RowCount-1]:=exch_rate.Caption;//汇率

      stringgrid1.cells[4,stringgrid1.RowCount-1]:= adoquery1.FieldValues['CUSTOMER_TYPE'];    //客户状态
      stringgrid1.cells[5,stringgrid1.RowCount-1]:= adoquery1.FieldValues['SALES_REP_NAME'];   //业务员

      stringgrid1.cells[6,stringgrid1.RowCount-1]:= adoquery1.fieldbyname('FED_TAX_ID_NO').AsString;//付款方式
      stringgrid1.cells[9,stringgrid1.RowCount-1]:= Formatfloat('#,##0.00',aq_lengyireceDSDesigner.Value);//'本期收款';
      if radiogroup1.ItemIndex=0 then
      total_amount_b[2]:=total_amount_b[2]+aq_lengyireceDSDesigner2.Value
      else
      total_amount_b[2]:=total_amount_b[2]+aq_lengyireceDSDesigner3.Value;
      total_amount[2]:=total_amount[2]+aq_lengyireceDSDesigner.Value;

      stringgrid2.Cells[0,stringgrid2.RowCount-1]:= aq_lengyireceSRCE_PTR.AsString;
      stringgrid2.Cells[1,stringgrid2.RowCount-1]:= inttostr(rkey01);
      stringgrid1.RowCount:=stringgrid1.RowCount+1;
      stringgrid2.RowCount:=stringgrid2.RowCount+1;
     end;
    aq_lengyirece.Next;
   end;
  progressbar1.Position:=20;
  while not aq_lengcredit.Eof do
   begin
    i:= self.get_customer(AQ_lengcreditCUST_PTR.Value);
    if i > 0 then
     begin
      stringgrid1.cells[10,i]:=Formatfloat('#,##0.00',aq_lengcreditDSDesigner.Value);//'本期扣款';
      if radiogroup1.ItemIndex=0 then
      total_amount_b[3]:=total_amount_b[3]+aq_lengcreditDSDesigner2.Value
      else
      total_amount_b[3]:=total_amount_b[3]+aq_lengcreditDSDesigner3.Value;
      total_amount[3]:=total_amount[3]+aq_lengcreditDSDesigner.Value;
     end
    else      //如倮货币没有那么增加stringgrid1记录
     begin
      if checkbox1.Checked then
       for i:=7 to 22 do stringgrid1.cells[i,stringgrid1.RowCount-1]:='0.00'
      else
       for i:=7 to 15 do stringgrid1.cells[i,stringgrid1.RowCount-1]:='0.00';
     with adoquery1 do
      begin
       close;
       sql.Clear;
       sql.Add('SELECT     dbo.Data0010.CUST_CODE, dbo.Data0010.ABBR_NAME,');
       sql.Add('dbo.Data0010.FED_TAX_ID_NO, CASE Data0010.CUSTOMER_TYPE ');
       sql.Add('WHEN 1 THEN ''正常'' WHEN 2 THEN ''新合作'' WHEN 3 THEN ''控制''');
       SQL.Add('WHEN 4 THEN ''停止'' END AS CUSTOMER_TYPE,Data0005.EMPLOYEE_NAME as SALES_REP_NAME');
       sql.Add('FROM  Data0010 INNER JOIN ');
       sql.Add('Data0005 ON Data0010.SALES_REP_PTR = Data0005.RKEY ');
       sql.Add('where dbo.Data0010.rkey='+AQ_lengcreditCUST_PTR.AsString);
       open;
      end;

      stringgrid1.cells[0,stringgrid1.RowCount-1]:= adoquery1.FieldValues['CUST_CODE'];//客户代码
      stringgrid1.cells[1,stringgrid1.RowCount-1]:= adoquery1.FieldValues['abbr_name'];//客户简称

      stringgrid1.cells[2,stringgrid1.RowCount-1]:=edit2.text;//货币
      stringgrid1.cells[3,stringgrid1.RowCount-1]:=exch_rate.Caption;//汇率

      stringgrid1.cells[4,stringgrid1.RowCount-1]:= adoquery1.FieldValues['CUSTOMER_TYPE'];    //客户状态
      stringgrid1.cells[5,stringgrid1.RowCount-1]:= adoquery1.FieldValues['SALES_REP_NAME'];   //业务员

      stringgrid1.cells[6,stringgrid1.RowCount-1]:= adoquery1.fieldbyname('FED_TAX_ID_NO').AsString;//付款方式
      stringgrid1.cells[10,stringgrid1.RowCount-1]:= Formatfloat('#,##0.00',aq_lengcreditDSDesigner.Value);//'本期扣款';
      if radiogroup1.ItemIndex=0 then
      total_amount_b[3]:=total_amount_b[3]+aq_lengcreditDSDesigner2.Value
      else
      total_amount_b[3]:=total_amount_b[3]+aq_lengcreditDSDesigner3.Value;

      total_amount[3]:=total_amount[3]+aq_lengcreditDSDesigner.Value;

      stringgrid2.Cells[0,stringgrid2.RowCount-1]:= AQ_lengcreditCUST_PTR.AsString;
      stringgrid2.Cells[1,stringgrid2.RowCount-1]:= inttostr(rkey01);
      stringgrid1.RowCount:=stringgrid1.RowCount+1;
      stringgrid2.RowCount:=stringgrid2.RowCount+1;
     end;
    aq_lengcredit.Next;
   end;
  progressbar1.Position:=30;

  while not aq_finarece.Eof do
   begin
    i:= self.get_customer(self.aq_finarececustomer_ptr.Value);
    if i > 0 then
     begin
      stringgrid1.cells[12,i]:=Formatfloat('#,##0.00',aq_finareceDSDesigner.Value);//'期后应收';
      if radiogroup1.ItemIndex=0 then
      total_amount_b[5]:=total_amount_b[5]+aq_finareceDSDesigner2.Value
      else
      total_amount_b[5]:=total_amount_b[5]+aq_finareceDSDesigner3.Value;
      total_amount[5]:=total_amount[5]+aq_finareceDSDesigner.Value;
     end
    else      //如倮货币没有那么增加stringgrid1记录
     begin
      if checkbox1.Checked then
       for i:=7 to 22 do stringgrid1.cells[i,stringgrid1.RowCount-1]:='0.00'
      else
       for i:=7 to 15 do stringgrid1.cells[i,stringgrid1.RowCount-1]:='0.00';
     with adoquery1 do
      begin
       close;
       sql.Clear;
       sql.Add('SELECT Data0010.CUST_CODE,Data0010.ABBR_NAME, Data0010.FED_TAX_ID_NO,');
       sql.Add('CASE Data0010.CUSTOMER_TYPE WHEN 1 THEN ''正常''');
       sql.Add('WHEN 2 THEN ''新合作'' WHEN 3 THEN ''控制''');
       sql.Add('WHEN 4 THEN ''停止'' END AS CUSTOMER_TYPE, Data0005.EMPLOYEE_NAME as SALES_REP_NAME');
       sql.Add('FROM dbo.Data0010 INNER JOIN ');
       sql.Add(' Data0005 ON dbo.Data0010.SALES_REP_PTR = dbo.Data0005.RKEY ');
       sql.Add('where Data0010.rkey='+aq_finarececustomer_ptr.AsString);
       open;
      end;
      stringgrid1.cells[0,stringgrid1.RowCount-1]:= adoquery1.FieldValues['CUST_CODE'];//客户代码
      stringgrid1.cells[1,stringgrid1.RowCount-1]:=  adoquery1.FieldValues['abbr_name'];//客户简称
      stringgrid1.cells[2,stringgrid1.RowCount-1]:=edit2.Text; //货币
      stringgrid1.cells[3,stringgrid1.RowCount-1]:=exch_rate.caption; //汇率

      stringgrid1.cells[4,stringgrid1.RowCount-1]:= adoquery1.FieldValues['CUSTOMER_TYPE'];    //客户状态
      stringgrid1.cells[5,stringgrid1.RowCount-1]:= adoquery1.FieldValues['SALES_REP_NAME'];   //业务员

      stringgrid1.cells[6,stringgrid1.RowCount-1]:= adoquery1.fieldbyname('FED_TAX_ID_NO').AsString;//付款方式
      stringgrid1.cells[12,stringgrid1.RowCount-1]:= Formatfloat('#,##0.00',aq_finareceDSDesigner.Value);//'期后应收';
      if radiogroup1.ItemIndex=0 then
      total_amount_b[5]:=total_amount_b[5]+aq_finareceDSDesigner2.Value
      else
      total_amount_b[5]:=total_amount_b[5]+aq_finareceDSDesigner3.Value;

      total_amount[5]:=total_amount[5]+aq_finareceDSDesigner.Value;

      stringgrid2.Cells[0,stringgrid2.RowCount-1]:= aq_finarececustomer_ptr.AsString;
      stringgrid2.Cells[1,stringgrid2.RowCount-1]:= inttostr(rkey01);
      stringgrid1.RowCount:=stringgrid1.RowCount+1;
      stringgrid2.RowCount:=stringgrid2.RowCount+1;
     end;
    aq_finarece.Next;
   end;
  progressbar1.Position:=40;

  while not aq_finayirece.Eof do
   begin
    i:= self.get_customer(self.aq_finayirecesrce_ptr.Value);
    if i > 0 then
     begin
      stringgrid1.cells[13,i]:=Formatfloat('#,##0.00',aq_finayireceDSDesigner.Value);  //期后收款
      if radiogroup1.ItemIndex=0 then
      total_amount_b[6]:=total_amount_b[6]+aq_finayireceDSDesigner2.Value
      else
      total_amount_b[6]:=total_amount_b[6]+aq_finayireceDSDesigner3.Value;
      total_amount[6]:=total_amount[6]+aq_finayireceDSDesigner.Value;
     end
    else      //如倮客户没有那么增加stringgrid1记录
     begin
      if checkbox1.Checked then
       for i:=7 to 22 do stringgrid1.cells[i,stringgrid1.RowCount-1]:='0.00'
      else
       for i:=7 to 15 do stringgrid1.cells[i,stringgrid1.RowCount-1]:='0.00';
      with adoquery1 do
      begin
       close;
       sql.Clear;
       sql.Add('SELECT Data0010.CUST_CODE,Data0010.ABBR_NAME,Data0010.FED_TAX_ID_NO,');
       sql.Add('CASE Data0010.CUSTOMER_TYPE WHEN 1 THEN ''正常''');
       sql.Add('WHEN 2 THEN ''新合作'' WHEN 3 THEN ''控制''');
       sql.Add('WHEN 4 THEN ''停止'' END AS CUSTOMER_TYPE, Data0005.EMPLOYEE_NAME as SALES_REP_NAME');
       sql.Add('FROM dbo.Data0010 INNER JOIN ');
       sql.Add('dbo.Data0005 ON dbo.Data0010.SALES_REP_PTR = dbo.Data0005.RKEY ');
       sql.Add('where dbo.Data0010.rkey='+aq_finayirecesrce_ptr.AsString);
       open;
      end;
      stringgrid1.cells[0,stringgrid1.RowCount-1]:= adoquery1.FieldValues['CUST_CODE'];//客户代码
      stringgrid1.cells[1,stringgrid1.RowCount-1]:=  adoquery1.FieldValues['abbr_name'];//客户简称

      stringgrid1.cells[2,stringgrid1.RowCount-1]:=edit2.Text; //货币
      stringgrid1.cells[3,stringgrid1.RowCount-1]:=exch_rate.caption; //汇率

      stringgrid1.cells[4,stringgrid1.RowCount-1]:= adoquery1.FieldValues['CUSTOMER_TYPE'];    //客户状态
      stringgrid1.cells[5,stringgrid1.RowCount-1]:= adoquery1.FieldValues['SALES_REP_NAME'];   //业务员

      stringgrid1.cells[6,stringgrid1.RowCount-1]:= adoquery1.fieldbyname('FED_TAX_ID_NO').AsString;//付款方式
      stringgrid1.cells[13,stringgrid1.RowCount-1]:= Formatfloat('#,##0.00',aq_finayireceDSDesigner.Value); //期后收款
      if radiogroup1.ItemIndex=0 then
       total_amount_b[6]:=total_amount_b[6]+aq_finayireceDSDesigner2.Value
      else
       total_amount_b[6]:=total_amount_b[6]+aq_finayireceDSDesigner3.Value;
      total_amount[6]:=total_amount[6]+aq_finayireceDSDesigner.Value;

      stringgrid2.Cells[0,stringgrid2.RowCount-1]:= aq_finayirecesrce_ptr.AsString;
      stringgrid2.Cells[1,stringgrid2.RowCount-1]:= inttostr(rkey01);
      stringgrid1.RowCount:=stringgrid1.RowCount+1;
      stringgrid2.RowCount:=stringgrid2.RowCount+1;
     end;

    aq_finayirece.Next;
   end;
  progressbar1.Position:=50;

  while not aq_finacredit.Eof do
   begin
    i:= self.get_customer(self.AQ_finacreditcust_ptr.Value);
    if i > 0 then
     begin
      stringgrid1.cells[14,i]:=Formatfloat('#,##0.00',aq_finacreditDSDesigner.Value);//期后扣款
      if radiogroup1.ItemIndex=0 then
      total_amount_b[7]:=total_amount_b[7]+aq_finacreditDSDesigner2.Value
      else
      total_amount_b[7]:=total_amount_b[7]+aq_finacreditDSDesigner3.Value;
      total_amount[7]:=total_amount[7]+aq_finacreditDSDesigner.Value;
     end
    else    //如倮货币没有那么增加stringgrid1记录
     begin
      if checkbox1.Checked then
       for i:=7 to 22 do stringgrid1.cells[i,stringgrid1.RowCount-1]:='0.00'
      else
       for i:=7 to 15 do stringgrid1.cells[i,stringgrid1.RowCount-1]:='0.00';
     with adoquery1 do
      begin
       close;
       sql.Clear;
       sql.Add('SELECT Data0010.CUST_CODE, Data0010.ABBR_NAME, Data0010.FED_TAX_ID_NO,');
       sql.Add('CASE Data0010.CUSTOMER_TYPE WHEN 1 THEN ''正常'' ');
       sql.Add('WHEN 2 THEN ''新合作'' WHEN 3 THEN ''控制''');
       sql.Add('WHEN 4 THEN ''停止'' END AS CUSTOMER_TYPE, Data0005.EMPLOYEE_NAME as SALES_REP_NAME');
       sql.Add('from data0010 inner join');
       sql.Add('Data0005 ON dbo.Data0010.SALES_REP_PTR = dbo.Data0005.RKEY ');
       sql.Add('where dbo.Data0010.rkey='+AQ_finacreditcust_ptr.AsString);
       open;
      end;
      stringgrid1.cells[0,stringgrid1.RowCount-1]:= adoquery1.FieldValues['CUST_CODE'];//客户代码
      stringgrid1.cells[1,stringgrid1.RowCount-1]:=  adoquery1.FieldValues['abbr_name'];//客户简称

      stringgrid1.cells[2,stringgrid1.RowCount-1]:=edit2.Text; //货币
      stringgrid1.cells[3,stringgrid1.RowCount-1]:=exch_rate.caption; //汇率

      stringgrid1.cells[4,stringgrid1.RowCount-1]:= adoquery1.FieldValues['CUSTOMER_TYPE'];    //客户状态
      stringgrid1.cells[5,stringgrid1.RowCount-1]:= adoquery1.FieldValues['SALES_REP_NAME'];   //业务员

      stringgrid1.cells[6,stringgrid1.RowCount-1]:= adoquery1.fieldbyname('FED_TAX_ID_NO').AsString;//付款方式
      stringgrid1.cells[14,stringgrid1.RowCount-1]:= Formatfloat('#,##0.00',aq_finacreditDSDesigner.Value);  //期后扣款
      if radiogroup1.ItemIndex=0 then
      total_amount_b[7]:=total_amount_b[7]+aq_finacreditDSDesigner2.Value
      else
      total_amount_b[7]:=total_amount_b[7]+aq_finacreditDSDesigner3.Value;
      total_amount[7]:=total_amount[7]+aq_finacreditDSDesigner.Value;

      stringgrid2.Cells[0,stringgrid2.RowCount-1]:= AQ_finacreditcust_ptr.AsString;
      stringgrid2.Cells[1,stringgrid2.RowCount-1]:= inttostr(rkey01);
      stringgrid1.RowCount:=stringgrid1.RowCount+1;
      stringgrid2.RowCount:=stringgrid2.RowCount+1;
     end;
    aq_finacredit.Next;
   end;
  progressbar1.Position:=60;

  while not aq_balance.Eof do
   begin
    i := self.get_customer(AQ_balanceCUSTOMER_PTR.Value);
    if i > 0 then
     begin
      stringgrid1.cells[15,i]:=Formatfloat('#,##0.00',
                           strtocurr(RemoveInvalid(stringgrid1.cells[15,i]))+
                           AQ_balanceDSDesigner.Value);//当前余额
      if radiogroup1.ItemIndex=0 then
      total_amount_b[8]:=total_amount_b[8]+AQ_balanceDSDesigner2.Value
      else
      total_amount_b[8]:=total_amount_b[8]+AQ_balanceDSDesigner3.Value;
      total_amount[8]:=total_amount[8]+AQ_balanceDSDesigner.Value;
     end
    else      //如倮货币没有那么增加stringgrid1记录
     begin
      if checkbox1.Checked then
       for i:=7 to 22 do stringgrid1.cells[i,stringgrid1.RowCount-1]:='0.00'
      else
       for i:=7 to 15 do stringgrid1.cells[i,stringgrid1.RowCount-1]:='0.00';
      with adoquery1 do
      begin
       close;
       sql.Clear;
       sql.Add('SELECT Data0010.CUST_CODE, Data0010.ABBR_NAME, Data0010.FED_TAX_ID_NO,');
       sql.Add('CASE dbo.Data0010.CUSTOMER_TYPE WHEN 1 THEN ''正常''');
       sql.Add('WHEN 2 THEN ''新合作'' WHEN 3 THEN ''控制''');
       sql.Add('WHEN 4 THEN ''停止'' END AS CUSTOMER_TYPE, Data0005.EMPLOYEE_NAME as SALES_REP_NAME');
       sql.Add('FROM       dbo.Data0010 INNER JOIN ');
       sql.Add(' dbo.Data0005 ON dbo.Data0010.SALES_REP_PTR = dbo.Data0005.RKEY ');
       sql.Add('where dbo.Data0010.rkey='+AQ_balanceCUSTOMER_PTR.AsString);
       open;
      end;
      stringgrid1.cells[0,stringgrid1.RowCount-1]:= adoquery1.FieldValues['CUST_CODE'];//客户代码
      stringgrid1.cells[1,stringgrid1.RowCount-1]:=  adoquery1.FieldValues['abbr_name'];//客户简称

      stringgrid1.cells[2,stringgrid1.RowCount-1]:=edit2.Text; //货币
      stringgrid1.cells[3,stringgrid1.RowCount-1]:=exch_rate.caption; //汇率

      stringgrid1.cells[4,stringgrid1.RowCount-1]:= adoquery1.FieldValues['CUSTOMER_TYPE'];    //客户状态
      stringgrid1.cells[5,stringgrid1.RowCount-1]:= adoquery1.FieldValues['SALES_REP_NAME'];   //业务员

      stringgrid1.cells[6,stringgrid1.RowCount-1]:= adoquery1.fieldbyname('FED_TAX_ID_NO').AsString;//付款方式
      stringgrid1.cells[15,stringgrid1.RowCount-1]:= Formatfloat('#,##0.00',AQ_balanceDSDesigner.Value);//当前余额

      if radiogroup1.ItemIndex=0 then
      total_amount_b[8]:=total_amount_b[8]+AQ_balanceDSDesigner2.Value
      else
      total_amount_b[8]:=total_amount_b[8]+AQ_balanceDSDesigner3.Value;

      total_amount[8]:=total_amount[8]+AQ_balanceDSDesigner.Value;

      stringgrid2.Cells[0,stringgrid2.RowCount-1]:= self.AQ_balanceCUSTOMER_PTR.AsString;
      stringgrid2.Cells[1,stringgrid2.RowCount-1]:= inttostr(rkey01);
      stringgrid1.RowCount:=stringgrid1.RowCount+1;
      stringgrid2.RowCount:=stringgrid2.RowCount+1;
     end;
    aq_balance.Next;
   end;
  progressbar1.Position:=70;

  for i:=1 to stringgrid2.RowCount-2 do
  begin
   stringgrid1.cells[11,i]:=Formatfloat('#,##0.00',
                       strtocurr(RemoveInvalid(stringgrid1.cells[15,i]))+
                       strtocurr(RemoveInvalid(stringgrid1.cells[14,i]))+
                       strtocurr(RemoveInvalid(stringgrid1.cells[13,i]))-
                       strtocurr(RemoveInvalid(stringgrid1.cells[12,i])));//'期末余额';

   stringgrid1.cells[7,i]:=Formatfloat('#,##0.00',
                       strtocurr(RemoveInvalid(stringgrid1.cells[11,i]))+
                       strtocurr(RemoveInvalid(stringgrid1.cells[10,i]))+
                       strtocurr(RemoveInvalid(stringgrid1.cells[9,i]))-
                       strtocurr(RemoveInvalid(stringgrid1.cells[8,i])));  //'期初欠款';
   if (checkbox1.Checked) and (strtoint(stringgrid2.Cells[0,i])>0) then
    begin
     get_leng6(strtoint(stringgrid2.Cells[0,i]),strtoint(stringgrid2.Cells[1,i]),
                 yishou,yishou_b);
     stringgrid1.cells[22,i]:=Formatfloat('#,##0.00',yishou);         //第六区间
     total_amount_b[15]:=total_amount_b[15]+yishou_b;
     total_amount[15]:=total_amount[15]+yishou;

     get_leng2_5(strtoint(stringgrid2.Cells[0,i]),strtoint(stringgrid2.Cells[1,i]),
                   dtpk1.Date,dtpk2.Date,yishou,yishou_b);
     stringgrid1.cells[21,i] := Formatfloat('#,##0.00',yishou);       //第五区间
     total_amount_b[14]:=total_amount_b[14]+yishou_b;
     total_amount[14]:=total_amount[14]+yishou;

     get_leng2_5(strtoint(stringgrid2.Cells[0,i]),strtoint(stringgrid2.Cells[1,i]),
                   self.v_date3+1,self.v_date4,yishou,yishou_b);
     stringgrid1.cells[20,i] := Formatfloat('#,##0.00',yishou);       //第四区间
     total_amount_b[13]:=total_amount_b[13]+yishou_b;
     total_amount[13]:=total_amount[13]+yishou;

     get_leng2_5(strtoint(stringgrid2.Cells[0,i]),strtoint(stringgrid2.Cells[1,i]),
                   self.v_date2+1,self.v_date3,yishou,yishou_b);
     stringgrid1.cells[19,i] := Formatfloat('#,##0.00',yishou);       //第三区间
     total_amount_b[12] := total_amount_b[12]+yishou_b;
     total_amount[12] := total_amount[12]+yishou;

     get_leng2_5(strtoint(stringgrid2.Cells[0,i]),strtoint(stringgrid2.Cells[1,i]),
                   self.v_date1+1,self.v_date2,yishou,yishou_b);
     stringgrid1.cells[18,i] := Formatfloat('#,##0.00',yishou);       //第二区间
     total_amount_b[11] := total_amount_b[11]+yishou_b;
     total_amount[11] := total_amount[11]+yishou;

     get_leng2_5(strtoint(stringgrid2.Cells[0,i]),strtoint(stringgrid2.Cells[1,i]),
                   self.v_date0+1,self.v_date1,yishou,yishou_b);
     stringgrid1.cells[17,i] := Formatfloat('#,##0.00',yishou);       //第一区间
     total_amount_b[10] := total_amount_b[10]+yishou_b;
     total_amount[10] := total_amount[10]+yishou;

     get_leng_1(strtoint(stringgrid2.Cells[0,i]),strtoint(stringgrid2.Cells[1,i]),
                  v_date1,yishou,yishou_b);
     stringgrid1.cells[16,i] := Formatfloat('#,##0.00',yishou);       //第零区间
     total_amount_b[9] := total_amount_b[9]+yishou_b;
     total_amount[9] := total_amount[9]+yishou;
    end;
   end;
   progressbar1.Position:=90;

  if self.find_date(total_amount) then   //找到有数量则处理原币小计,及本币总计
  begin
  stringgrid1.cells[1,stringgrid1.RowCount-1]:='小计'+edit2.Text;
  Stringgrid2.Cells[0,stringgrid2.RowCount-1]:='0';
  Stringgrid2.Cells[1,stringgrid2.RowCount-1]:='0';
  if checkbox1.Checked then
  for i:=7 to 22 do
   stringgrid1.cells[i,stringgrid1.RowCount-1]:=Formatfloat('#,##0.00', total_amount[i-7])
  else
  for i:=7 to 15 do
   stringgrid1.cells[i,stringgrid1.RowCount-1]:=Formatfloat('#,##0.00', total_amount[i-7]);
   stringgrid1.cells[11,stringgrid1.RowCount-1]:=Formatfloat('#,##0.00',
                       strtocurr(RemoveInvalid(stringgrid1.cells[15,stringgrid1.RowCount-1]))+
                       strtocurr(RemoveInvalid(stringgrid1.cells[14,stringgrid1.RowCount-1]))+
                       strtocurr(RemoveInvalid(stringgrid1.cells[13,stringgrid1.RowCount-1]))-
                       strtocurr(RemoveInvalid(stringgrid1.cells[12,stringgrid1.RowCount-1]))); //'期末余额';
   stringgrid1.cells[7,stringgrid1.RowCount-1]:=Formatfloat('#,##0.00',
                       strtocurr(RemoveInvalid(stringgrid1.cells[11,stringgrid1.RowCount-1]))+
                       strtocurr(RemoveInvalid(stringgrid1.cells[10,stringgrid1.RowCount-1]))+
                       strtocurr(RemoveInvalid(stringgrid1.cells[9,stringgrid1.RowCount-1]))-
                       strtocurr(RemoveInvalid(stringgrid1.cells[8,stringgrid1.RowCount-1])));  //'期初欠款';
  stringgrid1.RowCount:=stringgrid1.RowCount+1;
  stringgrid2.RowCount:=stringgrid2.RowCount+1;

                                     //处理最后一行本币总计
  stringgrid1.cells[1,stringgrid1.RowCount-1]:='本币总计';
  Stringgrid2.Cells[0,stringgrid2.RowCount-1]:='0';
  Stringgrid2.Cells[1,stringgrid2.RowCount-1]:='0';
  if checkbox1.Checked then
   for i:=7 to 22 do
    stringgrid1.cells[i,stringgrid1.RowCount-1]:=Formatfloat('#,##0.00', total_amount_b[i-7])
  else
   for i:=7 to 15 do
    stringgrid1.cells[i,stringgrid1.RowCount-1]:=Formatfloat('#,##0.00', total_amount_b[i-7]);
   stringgrid1.cells[11,stringgrid1.RowCount-1]:=Formatfloat('#,##0.00',
                       strtocurr(RemoveInvalid(stringgrid1.cells[15,stringgrid1.RowCount-1]))+
                       strtocurr(RemoveInvalid(stringgrid1.cells[14,stringgrid1.RowCount-1]))+
                       strtocurr(RemoveInvalid(stringgrid1.cells[13,stringgrid1.RowCount-1]))-
                       strtocurr(RemoveInvalid(stringgrid1.cells[12,stringgrid1.RowCount-1])));//'期末余额';
   stringgrid1.cells[7,stringgrid1.RowCount-1]:=Formatfloat('#,##0.00',
                       strtocurr(RemoveInvalid(stringgrid1.cells[11,stringgrid1.RowCount-1]))+
                       strtocurr(RemoveInvalid(stringgrid1.cells[10,stringgrid1.RowCount-1]))+
                       strtocurr(RemoveInvalid(stringgrid1.cells[9,stringgrid1.RowCount-1]))-
                       strtocurr(RemoveInvalid(stringgrid1.cells[8,stringgrid1.RowCount-1])));  //'期初欠款';
  end;
  progressbar1.Position:=100;
  end
 else
 begin        //未确定客户未确定货币
   v_i:=1;
   stringgrid1.RowCount:=1;
   stringgrid2.RowCount:=1;
   aq_lengrece.Close;        //本期应收数据       1
   aq_lengrece.SQL.Delete(aq_lengrece.SQL.Count-2);
   aq_lengrece.SQL.Insert(aq_lengrece.SQL.Count-1,'');
   aq_lengrece.Parameters[0].Value:=dtpk1.Date;
   aq_lengrece.Parameters[1].Value:=dtpk2.Date;
   aq_lengrece.Open;
   aq_lengyirece.Close;       //本期已收数据     2
   aq_lengyirece.SQL.Delete(aq_lengyirece.SQL.Count-2);
   aq_lengyirece.SQL.Insert(aq_lengyirece.SQL.Count-1,'');
   aq_lengyirece.Parameters[0].Value:=dtpk1.Date;
   aq_lengyirece.Parameters[1].Value:=dtpk2.Date;
   aq_lengyirece.Open;
   aq_lengcredit.Close;       //本期扣款(贷方信用)  3
   aq_lengcredit.SQL.Delete(aq_lengcredit.SQL.Count-2);
   aq_lengcredit.SQL.Insert(aq_lengcredit.SQL.Count-1,'');
   aq_lengcredit.Parameters[0].Value:=dtpk1.Date;
   aq_lengcredit.Parameters[1].Value:=dtpk2.Date;
   aq_lengcredit.Open;
   aq_finarece.Close;        //期后应收数据      4
   aq_finarece.SQL.Delete(aq_finarece.SQL.Count-2);
   aq_finarece.SQL.Insert(aq_finarece.SQL.Count-1,'');
   aq_finarece.Parameters[0].Value:=dtpk2.Date;
   aq_finarece.Open;
   aq_finayirece.Close;        //期后已收数据     5
   aq_finayirece.SQL.Delete(aq_finayirece.SQL.Count-2);
   aq_finayirece.SQL.Insert(aq_finayirece.SQL.Count-1,'');
   aq_finayirece.Parameters[0].Value:=dtpk2.Date;
   aq_finayirece.Open;
   aq_finacredit.Close;          //期后扣款(贷方信用)   6
   aq_finacredit.SQL.Delete(aq_finacredit.SQL.Count-2);
   aq_finacredit.SQL.Insert(aq_finacredit.SQL.Count-1,'');
   aq_finacredit.Parameters[0].Value:=dtpk2.Date;
   aq_finacredit.Open;

  for i:=0 to 15 do total_amount_allb[i]:=0;

  aq01.Open;
  while not aq01.Eof do
  begin
   for i:=0 to 15 do
    begin
     total_amount_b[i]:=0;
     total_amount[i]:=0;
    end;
   aq_lengrece.Filter:='CURRENCY_PTR='+self.aq01rkey.AsString;  //本期应收 1
   while not aq_lengrece.Eof do
    begin
     stringgrid1.RowCount:=stringgrid1.RowCount+1;
     stringgrid2.RowCount:=stringgrid2.RowCount+1;
     if checkbox1.Checked then
      for i:=7 to 22 do stringgrid1.cells[i,stringgrid1.RowCount-1]:='0.00'
     else
      for i:=7 to 15 do stringgrid1.cells[i,stringgrid1.RowCount-1]:='0.00';
     with adoquery1 do
      begin
       close;
       sql.Clear;
       sql.Add('SELECT     dbo.Data0010.CUST_CODE, dbo.Data0010.ABBR_NAME,');
       sql.Add('Data0010.FED_TAX_ID_NO, CASE dbo.Data0010.CUSTOMER_TYPE WHEN 1 THEN ''正常'' WHEN 2 THEN ''新合作'' WHEN 3 THEN ''控制'' WHEN 4 THEN ''停止'' END AS CUSTOMER_TYPE,');
       sql.Add('dbo.Data0005.EMPLOYEE_NAME as SALES_REP_NAME ');
       sql.Add('FROM       dbo.Data0010 INNER JOIN ');
       sql.Add(' dbo.Data0005 ON dbo.Data0010.SALES_REP_PTR = dbo.Data0005.RKEY ');
       sql.Add('where dbo.Data0010.rkey='+aq_lengrececustomer_ptr.AsString);
       open;
      end;
     stringgrid1.cells[0,stringgrid1.RowCount-1] := adoquery1.FieldValues['CUST_CODE']; //客户代码
     stringgrid1.cells[1,stringgrid1.RowCount-1] := adoquery1.FieldValues['abbr_name'];  //客户简称
     stringgrid1.cells[2,stringgrid1.RowCount-1] := self.aq01curr_code.Value;//货币
     stringgrid1.cells[3,stringgrid1.RowCount-1] := self.aq01BASE_TO_OTHER.AsString;  //汇率

     stringgrid1.cells[4,stringgrid1.RowCount-1]:= adoquery1.FieldValues['CUSTOMER_TYPE'];    //客户状态
     stringgrid1.cells[5,stringgrid1.RowCount-1]:= adoquery1.FieldValues['SALES_REP_NAME'];   //业务员

     stringgrid1.cells[6,stringgrid1.RowCount-1] := adoquery1.fieldbyname('FED_TAX_ID_NO').AsString;  //付款方式
     stringgrid1.cells[8,stringgrid1.RowCount-1] := Formatfloat('#,##0.00',aq_lengreceDSDesigner.Value);//'本期应收';
     if radiogroup1.ItemIndex=0 then
     total_amount_b[1] := total_amount_b[1]+aq_lengreceDSDesigner2.Value
     else
     total_amount_b[1] := total_amount_b[1]+aq_lengreceDSDesigner3.Value;

     total_amount[1] := total_amount[1]+aq_lengreceDSDesigner.Value;
     stringgrid2.Cells[0,stringgrid2.RowCount-1] := aq_lengreceCUSTOMER_PTR.AsString;
     stringgrid2.Cells[1,stringgrid2.RowCount-1] := self.aq01rkey.AsString;
     aq_lengrece.Next;
    end;
  progressbar1.Position:=10;

  aq_lengyirece.Filter := 'CURRECY_PTR='+aq01rkey.AsString;  //本期已收 2
  while not aq_lengyirece.Eof do
   begin
    i:=get_cust_curr(aq_lengyireceSRCE_PTR.Value,aq01rkey.Value);
    if i > 0 then                          //找到客户货币相同的记录
     begin
      stringgrid1.cells[9,i]:=Formatfloat('#,##0.00',aq_lengyireceDSDesigner.Value);
      if radiogroup1.ItemIndex=0 then
      total_amount_b[2]:=total_amount_b[2]+aq_lengyireceDSDesigner2.Value
      else
      total_amount_b[2]:=total_amount_b[2]+aq_lengyireceDSDesigner3.Value;
      total_amount[2]:=total_amount[2]+aq_lengyireceDSDesigner.Value;
     end
    else                                   //如倮客户没有那么增加stringgrid1记录
     begin
      stringgrid1.RowCount:=stringgrid1.RowCount+1;
      stringgrid2.RowCount:=stringgrid2.RowCount+1;
      if checkbox1.Checked then
       for i:=7 to 22 do stringgrid1.cells[i,stringgrid1.RowCount-1]:='0.00'
      else
       for i:=7 to 15 do stringgrid1.cells[i,stringgrid1.RowCount-1]:='0.00';
      with adoquery1 do
      begin
       close;
       sql.Clear;
       sql.Add('SELECT     dbo.Data0010.CUST_CODE, dbo.Data0010.ABBR_NAME, ');
       sql.Add('dbo.Data0010.FED_TAX_ID_NO, CASE dbo.Data0010.CUSTOMER_TYPE WHEN 1 THEN ''正常'' WHEN 2 THEN ''新合作'' WHEN 3 THEN ''控制'' WHEN 4 THEN ''停止'' END AS CUSTOMER_TYPE,');
       sql.Add('dbo.Data0005.EMPLOYEE_NAME as SALES_REP_NAME ');
       sql.Add('FROM       dbo.Data0010 INNER JOIN ');
       sql.Add('           dbo.Data0005 ON dbo.Data0010.SALES_REP_PTR = dbo.Data0005.RKEY ');
       sql.Add('where dbo.Data0010.rkey='+aq_lengyireceSRCE_PTR.AsString);
       open;
      end;
      stringgrid1.cells[0,stringgrid1.RowCount-1]:= adoquery1.FieldValues['CUST_CODE'];//客户代码
      stringgrid1.cells[1,stringgrid1.RowCount-1]:= adoquery1.FieldValues['abbr_name'];//客户简称
      stringgrid1.cells[2,stringgrid1.RowCount-1]:=self.aq01curr_code.Value;//货币
      stringgrid1.cells[3,stringgrid1.RowCount-1]:=self.aq01BASE_TO_OTHER.AsString;//汇率

      stringgrid1.cells[4,stringgrid1.RowCount-1]:= adoquery1.FieldValues['CUSTOMER_TYPE'];    //客户状态
      stringgrid1.cells[5,stringgrid1.RowCount-1]:= adoquery1.FieldValues['SALES_REP_NAME'];   //业务员

      stringgrid1.cells[6,stringgrid1.RowCount-1]:= adoquery1.fieldbyname('FED_TAX_ID_NO').AsString;//付款方式
      stringgrid1.cells[9,stringgrid1.RowCount-1]:= Formatfloat('#,##0.00',aq_lengyireceDSDesigner.Value);//'本期应收';
      if radiogroup1.ItemIndex=0 then
      total_amount_b[2]:=total_amount_b[2]+aq_lengyireceDSDesigner2.Value
      else
      total_amount_b[2]:=total_amount_b[2]+aq_lengyireceDSDesigner3.Value;
      total_amount[2]:=total_amount[2]+aq_lengyireceDSDesigner.Value;
      stringgrid2.Cells[0,stringgrid2.RowCount-1]:= aq_lengyireceSRCE_PTR.AsString;
      stringgrid2.Cells[1,stringgrid2.RowCount-1]:= self.aq01rkey.AsString;
     end;
    aq_lengyirece.Next;
   end;
  progressbar1.Position:=20;

  aq_lengcredit.Filter:='CURRENCY_PTR='+self.aq01rkey.AsString; //本期扣款  3
  while not aq_lengcredit.Eof do
   begin
    i:= self.get_cust_curr(AQ_lengcreditCUST_PTR.Value,aq01rkey.Value);
    if i > 0 then
     begin
      stringgrid1.cells[10,i]:=Formatfloat('#,##0.00',aq_lengcreditDSDesigner.Value);//'本期收款';
      if radiogroup1.ItemIndex=0 then
      total_amount_b[3]:=total_amount_b[3]+aq_lengcreditDSDesigner2.Value
      else
      total_amount_b[3]:=total_amount_b[3]+aq_lengcreditDSDesigner3.Value;
      total_amount[3]:=total_amount[3]+aq_lengcreditDSDesigner.Value;
     end
    else      //如倮货币没有那么增加stringgrid1记录
     begin
      stringgrid1.RowCount:=stringgrid1.RowCount+1;
      stringgrid2.RowCount:=stringgrid2.RowCount+1;
      if checkbox1.Checked then
       for i:=7 to 22 do stringgrid1.cells[i,stringgrid1.RowCount-1]:='0.00'
      else
       for i:=7 to 15 do stringgrid1.cells[i,stringgrid1.RowCount-1]:='0.00';
     with adoquery1 do
      begin
       close;
       sql.Clear;
       sql.Add('SELECT     dbo.Data0010.CUST_CODE, dbo.Data0010.ABBR_NAME, ');
       sql.Add(' dbo.Data0010.FED_TAX_ID_NO, CASE dbo.Data0010.CUSTOMER_TYPE WHEN 1 THEN ''正常'' WHEN 2 THEN ''新合作'' WHEN 3 THEN ''控制'' WHEN 4 THEN ''停止'' END AS CUSTOMER_TYPE,');
       sql.Add(' dbo.Data0005.EMPLOYEE_NAME as SALES_REP_NAME ');
       sql.Add('FROM       dbo.Data0010 INNER JOIN ');
       sql.Add('           dbo.Data0005 ON dbo.Data0010.SALES_REP_PTR = dbo.Data0005.RKEY ');
       sql.Add('where dbo.Data0010.rkey='+AQ_lengcreditCUST_PTR.AsString);
       open;
      end;

      stringgrid1.cells[0,stringgrid1.RowCount-1]:= adoquery1.FieldValues['CUST_CODE'];//客户代码
      stringgrid1.cells[1,stringgrid1.RowCount-1]:= adoquery1.FieldValues['abbr_name'];//客户简称
      stringgrid1.cells[2,stringgrid1.RowCount-1]:=self.aq01curr_code.Value;//货币
      stringgrid1.cells[3,stringgrid1.RowCount-1]:=self.aq01BASE_TO_OTHER.AsString;//汇率

      stringgrid1.cells[4,stringgrid1.RowCount-1]:= adoquery1.FieldValues['CUSTOMER_TYPE'];    //客户状态
      stringgrid1.cells[5,stringgrid1.RowCount-1]:= adoquery1.FieldValues['SALES_REP_NAME'];   //业务员

      stringgrid1.cells[6,stringgrid1.RowCount-1]:= adoquery1.fieldbyname('FED_TAX_ID_NO').AsString;//付款方式
      stringgrid1.cells[10,stringgrid1.RowCount-1]:= Formatfloat('#,##0.00',aq_lengcreditDSDesigner.Value);//'本期扣款';
      if radiogroup1.ItemIndex=0 then
      total_amount_b[3]:=total_amount_b[3]+aq_lengcreditDSDesigner2.Value
      else
      total_amount_b[3]:=total_amount_b[3]+aq_lengcreditDSDesigner3.Value;

      total_amount[3]:=total_amount[3]+aq_lengcreditDSDesigner.Value;

      stringgrid2.Cells[0,stringgrid2.RowCount-1]:= AQ_lengcreditCUST_PTR.AsString;
      stringgrid2.Cells[1,stringgrid2.RowCount-1]:= self.aq01rkey.AsString;
     end;
    aq_lengcredit.Next;
   end;
  progressbar1.Position:=30;

  aq_finarece.Filter:='CURRENCY_PTR='+self.aq01rkey.AsString; //期后应收 4
  while not aq_finarece.Eof do
   begin
    i:= self.get_cust_curr(self.aq_finarececustomer_ptr.Value,aq01rkey.Value);
    if i > 0 then
     begin
      stringgrid1.cells[12,i]:=Formatfloat('#,##0.00',aq_finareceDSDesigner.Value);//'本期收款';
      if radiogroup1.ItemIndex=0 then
      total_amount_b[5]:=total_amount_b[5]+aq_finareceDSDesigner2.Value
      else
      total_amount_b[5]:=total_amount_b[5]+aq_finareceDSDesigner3.Value;
      total_amount[5]:=total_amount[5]+aq_finareceDSDesigner.Value;
     end
    else      //如倮货币没有那么增加stringgrid1记录
     begin
      stringgrid1.RowCount:=stringgrid1.RowCount+1;
      stringgrid2.RowCount:=stringgrid2.RowCount+1;
      if checkbox1.Checked then
       for i:=7 to 22 do stringgrid1.cells[i,stringgrid1.RowCount-1]:='0.00'
      else
       for i:=7 to 15 do stringgrid1.cells[i,stringgrid1.RowCount-1]:='0.00';
      with adoquery1 do
      begin
       close;
       sql.Clear;
       sql.Add('SELECT     dbo.Data0010.CUST_CODE, dbo.Data0010.ABBR_NAME,');
       sql.Add(' dbo.Data0010.FED_TAX_ID_NO, CASE dbo.Data0010.CUSTOMER_TYPE WHEN 1 THEN ''正常'' WHEN 2 THEN ''新合作'' WHEN 3 THEN ''控制'' WHEN 4 THEN ''停止'' END AS CUSTOMER_TYPE,');
       sql.Add(' dbo.Data0005.EMPLOYEE_NAME as SALES_REP_NAME ');
       sql.Add('FROM       dbo.Data0010 INNER JOIN ');
       sql.Add(' dbo.Data0005 ON dbo.Data0010.SALES_REP_PTR = dbo.Data0005.RKEY ');
       sql.Add('where dbo.Data0010.rkey='+aq_finarececustomer_ptr.AsString);
       open;
      end;
      stringgrid1.cells[0,stringgrid1.RowCount-1]:= adoquery1.FieldValues['CUST_CODE'];//客户代码
      stringgrid1.cells[1,stringgrid1.RowCount-1]:=  adoquery1.FieldValues['abbr_name'];//客户简称
      stringgrid1.cells[2,stringgrid1.RowCount-1]:=self.aq01curr_code.Value; //货币
      stringgrid1.cells[3,stringgrid1.RowCount-1]:=self.aq01BASE_TO_OTHER.AsString; //汇率

      stringgrid1.cells[4,stringgrid1.RowCount-1]:= adoquery1.FieldValues['CUSTOMER_TYPE'];    //客户状态
      stringgrid1.cells[5,stringgrid1.RowCount-1]:= adoquery1.FieldValues['SALES_REP_NAME'];   //业务员

      stringgrid1.cells[6,stringgrid1.RowCount-1]:= adoquery1.fieldbyname('FED_TAX_ID_NO').AsString;//付款方式
      stringgrid1.cells[12,stringgrid1.RowCount-1]:= Formatfloat('#,##0.00',aq_finareceDSDesigner.Value);//'本期扣款';
      if radiogroup1.ItemIndex=0 then
      total_amount_b[5]:=total_amount_b[5]+aq_finareceDSDesigner2.Value
      else
      total_amount_b[5]:=total_amount_b[5]+aq_finareceDSDesigner3.Value;

      total_amount[5]:=total_amount[5]+aq_finareceDSDesigner.Value;
      stringgrid2.Cells[0,stringgrid2.RowCount-1]:= aq_finarececustomer_ptr.AsString;
      stringgrid2.Cells[1,stringgrid2.RowCount-1]:= self.aq01rkey.AsString;
     end;
    aq_finarece.Next;
   end;
  progressbar1.Position:=40;

  aq_finayirece.Filter:='CURRECY_PTR='+self.aq01rkey.AsString;  //期后已收  5
  while not aq_finayirece.Eof do
   begin
    i:= self.get_cust_curr(self.aq_finayirecesrce_ptr.Value,aq01rkey.Value);
    if i > 0 then
     begin
      stringgrid1.cells[13,i]:=Formatfloat('#,##0.00',aq_finayireceDSDesigner.Value);
      if radiogroup1.ItemIndex=0 then
      total_amount_b[6]:=total_amount_b[6]+aq_finayireceDSDesigner2.Value
      else
      total_amount_b[6]:=total_amount_b[6]+aq_finayireceDSDesigner3.Value;
      total_amount[6]:=total_amount[6]+aq_finayireceDSDesigner.Value;
     end
    else      //如倮客户没有那么增加stringgrid1记录
     begin
      stringgrid1.RowCount:=stringgrid1.RowCount+1;
      stringgrid2.RowCount:=stringgrid2.RowCount+1;
      if checkbox1.Checked then
       for i:=7 to 22 do stringgrid1.cells[i,stringgrid1.RowCount-1]:='0.00'
      else
       for i:=7 to 15 do stringgrid1.cells[i,stringgrid1.RowCount-1]:='0.00';
      with adoquery1 do
      begin
       close;
       sql.Clear;
       sql.Add('SELECT     dbo.Data0010.CUST_CODE, dbo.Data0010.ABBR_NAME,');
       sql.Add(' dbo.Data0010.FED_TAX_ID_NO, CASE dbo.Data0010.CUSTOMER_TYPE WHEN 1 THEN ''正常'' WHEN 2 THEN ''新合作'' WHEN 3 THEN ''控制'' WHEN 4 THEN ''停止'' END AS CUSTOMER_TYPE,');
       sql.Add(' dbo.Data0005.EMPLOYEE_NAME as SALES_REP_NAME ');
       sql.Add('FROM       dbo.Data0010 INNER JOIN ');
       sql.Add(' dbo.Data0005 ON dbo.Data0010.SALES_REP_PTR = dbo.Data0005.RKEY ');
       sql.Add('where dbo.Data0010.rkey='+aq_finayirecesrce_ptr.AsString);
       open;
      end;
      stringgrid1.cells[0,stringgrid1.RowCount-1]:= adoquery1.FieldValues['CUST_CODE'];//客户代码
      stringgrid1.cells[1,stringgrid1.RowCount-1]:=  adoquery1.FieldValues['abbr_name'];//客户简称
      stringgrid1.cells[2,stringgrid1.RowCount-1]:=self.aq01curr_code.Value; //货币
      stringgrid1.cells[3,stringgrid1.RowCount-1]:=self.aq01BASE_TO_OTHER.AsString; //汇率

      stringgrid1.cells[4,stringgrid1.RowCount-1]:= adoquery1.FieldValues['CUSTOMER_TYPE'];    //客户状态
      stringgrid1.cells[5,stringgrid1.RowCount-1]:= adoquery1.FieldValues['SALES_REP_NAME'];   //业务员

      stringgrid1.cells[6,stringgrid1.RowCount-1]:= adoquery1.fieldbyname('FED_TAX_ID_NO').AsString;//付款方式
      stringgrid1.cells[13,stringgrid1.RowCount-1]:= Formatfloat('#,##0.00',aq_finayireceDSDesigner.Value);
      if radiogroup1.ItemIndex=0 then
      total_amount_b[6]:=total_amount_b[6]+aq_finayireceDSDesigner2.Value
      else
      total_amount_b[6]:=total_amount_b[6]+aq_finayireceDSDesigner3.Value;
      total_amount[6]:=total_amount[6]+aq_finayireceDSDesigner.Value;
      stringgrid2.Cells[0,stringgrid2.RowCount-1]:= aq_finayirecesrce_ptr.AsString;
      stringgrid2.Cells[1,stringgrid2.RowCount-1]:= self.aq01rkey.AsString;
     end;
    aq_finayirece.Next;
   end;
  progressbar1.Position:=50;

  aq_finacredit.Filter:='CURRENCY_PTR='+self.aq01rkey.AsString;//期后扣款 6
  while not aq_finacredit.Eof do
   begin
    i:= self.get_cust_curr(self.AQ_finacreditcust_ptr.Value,aq01rkey.Value);
    if i > 0 then
     begin
      stringgrid1.cells[14,i]:=Formatfloat('#,##0.00',aq_finacreditDSDesigner.Value);
      if radiogroup1.ItemIndex=0 then
      total_amount_b[7]:=total_amount_b[7]+aq_finacreditDSDesigner2.Value
      else
      total_amount_b[7]:=total_amount_b[7]+aq_finacreditDSDesigner3.Value;
      total_amount[7]:=total_amount[7]+aq_finacreditDSDesigner.Value;
     end
    else      //如倮货币没有那么增加stringgrid1记录
     begin
      stringgrid1.RowCount:=stringgrid1.RowCount+1;
      stringgrid2.RowCount:=stringgrid2.RowCount+1;
      if checkbox1.Checked then
       for i:=7 to 22 do stringgrid1.cells[i,stringgrid1.RowCount-1]:='0.00'
      else
       for i:=7 to 15 do stringgrid1.cells[i,stringgrid1.RowCount-1]:='0.00';
      with adoquery1 do
      begin
       close;
       sql.Clear;
       sql.Add('SELECT     dbo.Data0010.CUST_CODE, dbo.Data0010.ABBR_NAME,');
       sql.Add(' dbo.Data0010.FED_TAX_ID_NO, CASE dbo.Data0010.CUSTOMER_TYPE WHEN 1 THEN ''正常'' WHEN 2 THEN ''新合作'' WHEN 3 THEN ''控制'' WHEN 4 THEN ''停止'' END AS CUSTOMER_TYPE,');
       sql.Add(' dbo.Data0005.EMPLOYEE_NAME as SALES_REP_NAME ');
       sql.Add('FROM       dbo.Data0010 INNER JOIN ');
       sql.Add('           dbo.Data0005 ON dbo.Data0010.SALES_REP_PTR = dbo.Data0005.RKEY ');
       sql.Add('where dbo.Data0010.rkey='+AQ_finacreditcust_ptr.AsString);
       open;
      end;
      stringgrid1.cells[0,stringgrid1.RowCount-1]:= adoquery1.FieldValues['CUST_CODE'];//客户代码
      stringgrid1.cells[1,stringgrid1.RowCount-1]:=  adoquery1.FieldValues['abbr_name'];//客户简称
      stringgrid1.cells[2,stringgrid1.RowCount-1]:=self.aq01curr_code.Value; //货币
      stringgrid1.cells[3,stringgrid1.RowCount-1]:=self.aq01BASE_TO_OTHER.AsString; //汇率

      stringgrid1.cells[4,stringgrid1.RowCount-1]:= adoquery1.FieldValues['CUSTOMER_TYPE'];    //客户状态
      stringgrid1.cells[5,stringgrid1.RowCount-1]:= adoquery1.FieldValues['SALES_REP_NAME'];   //业务员

      stringgrid1.cells[6,stringgrid1.RowCount-1]:= adoquery1.fieldbyname('FED_TAX_ID_NO').AsString;//付款方式
      stringgrid1.cells[14,stringgrid1.RowCount-1]:= Formatfloat('#,##0.00',aq_finacreditDSDesigner.Value);
      if radiogroup1.ItemIndex=0 then
      total_amount_b[7]:=total_amount_b[7]+aq_finacreditDSDesigner2.Value
      else
      total_amount_b[7]:=total_amount_b[7]+aq_finacreditDSDesigner3.Value;
      total_amount[7]:=total_amount[7]+aq_finacreditDSDesigner.Value;
      stringgrid2.Cells[0,stringgrid2.RowCount-1]:= AQ_finacreditcust_ptr.AsString;
      stringgrid2.Cells[1,stringgrid2.RowCount-1]:= self.aq01rkey.AsString;
     end;
    aq_finacredit.Next;
   end;
  progressbar1.Position:=60;


  with aq_balance do              //当前余额查询    7
   begin
    close;
    sql.Delete(7);
    sql.Insert(7,'and CURRENCY_PTR='+aq01rkey.AsString);
    sql.Delete(8);
    sql.Insert(8,'');
    sql.Delete(18);
    sql.Insert(18,'and CURRENCY_PTR='+aq01rkey.AsString);
    sql.Delete(19);
    sql.Insert(19,'');
    open;
   end;

//  aq_balance.Filter:='CURRENCY_PTR='+self.aq01rkey.AsString; //款末余额 7
  while not aq_balance.Eof do
   begin
    i := get_cust_curr(self.AQ_balanceCUSTOMER_PTR.Value,aq01rkey.Value);
    if i > 0 then
     begin
      stringgrid1.cells[15,i]:=Formatfloat('#,##0.00',strtocurr(RemoveInvalid(stringgrid1.cells[15,i]))+
                                       AQ_balanceDSDesigner.Value);//当前余额
      if radiogroup1.ItemIndex=0 then
      total_amount_b[8]:=total_amount_b[8]+AQ_balanceDSDesigner2.Value
      else
      total_amount_b[8]:=total_amount_b[8]+AQ_balanceDSDesigner3.Value;
      total_amount[8]:=total_amount[8]+AQ_balanceDSDesigner.Value;
     end
    else      //如倮货币没有那么增加stringgrid1记录
     begin
      stringgrid1.RowCount:=stringgrid1.RowCount+1;
      stringgrid2.RowCount:=stringgrid2.RowCount+1;
      if checkbox1.Checked then
       for i:=7 to 22 do stringgrid1.cells[i,stringgrid1.RowCount-1]:='0.00'
      else
       for i:=7 to 15 do stringgrid1.cells[i,stringgrid1.RowCount-1]:='0.00';
     with adoquery1 do
      begin
       close;
       sql.Clear;
       sql.Add('SELECT     dbo.Data0010.CUST_CODE, dbo.Data0010.ABBR_NAME, ');
       sql.Add('Data0010.FED_TAX_ID_NO, CASE dbo.Data0010.CUSTOMER_TYPE WHEN 1 THEN ''正常'' WHEN 2 THEN ''新合作'' WHEN 3 THEN ''控制'' WHEN 4 THEN ''停止'' END AS CUSTOMER_TYPE,');
       sql.Add(' dbo.Data0005.EMPLOYEE_NAME as SALES_REP_NAME ');
       sql.Add('FROM       dbo.Data0010 INNER JOIN ');
       sql.Add('           dbo.Data0005 ON dbo.Data0010.SALES_REP_PTR = dbo.Data0005.RKEY ');
       sql.Add('where dbo.Data0010.rkey='+AQ_balanceCUSTOMER_PTR.AsString);
       open;
      end;
      stringgrid1.cells[0,stringgrid1.RowCount-1]:= adoquery1.FieldValues['CUST_CODE'];//客户代码
      stringgrid1.cells[1,stringgrid1.RowCount-1]:=  adoquery1.FieldValues['abbr_name'];//客户简称
      stringgrid1.cells[2,stringgrid1.RowCount-1]:=self.aq01curr_code.Value; //货币
      stringgrid1.cells[3,stringgrid1.RowCount-1]:=self.aq01BASE_TO_OTHER.AsString; //汇率

      stringgrid1.cells[4,stringgrid1.RowCount-1]:= adoquery1.FieldValues['CUSTOMER_TYPE'];    //客户状态
      stringgrid1.cells[5,stringgrid1.RowCount-1]:= adoquery1.FieldValues['SALES_REP_NAME'];   //业务员

      stringgrid1.cells[6,stringgrid1.RowCount-1]:= adoquery1.fieldbyname('FED_TAX_ID_NO').AsString;//付款方式
      stringgrid1.cells[15,stringgrid1.RowCount-1]:= Formatfloat('#,##0.00',AQ_balanceDSDesigner.Value);
      if radiogroup1.ItemIndex=0 then
      total_amount_b[8]:=total_amount_b[8]+AQ_balanceDSDesigner2.Value
      else
      total_amount_b[8]:=total_amount_b[8]+AQ_balanceDSDesigner3.Value;
      total_amount[8]:=total_amount[8]+AQ_balanceDSDesigner.Value;
      stringgrid2.Cells[0,stringgrid2.RowCount-1]:= self.AQ_balanceCUSTOMER_PTR.AsString;
      stringgrid2.Cells[1,stringgrid2.RowCount-1]:= self.aq01rkey.AsString;
     end;
     aq_balance.Next;
   end;
  progressbar1.Position:=70;

  for i:=v_i to stringgrid2.RowCount-1 do
   begin
   stringgrid1.cells[11,i]:=Formatfloat('#,##0.00',
                       strtocurr(RemoveInvalid(stringgrid1.cells[15,i]))+
                       strtocurr(RemoveInvalid(stringgrid1.cells[14,i]))+
                       strtocurr(RemoveInvalid(stringgrid1.cells[13,i]))-
                       strtocurr(RemoveInvalid(stringgrid1.cells[12,i]))); //'期末余额';

   stringgrid1.cells[7,i]:=Formatfloat('#,##0.00',
                       strtocurr(RemoveInvalid(stringgrid1.cells[11,i]))+
                       strtocurr(RemoveInvalid(stringgrid1.cells[10,i]))+
                       strtocurr(RemoveInvalid(stringgrid1.cells[9,i]))-
                       strtocurr(RemoveInvalid(stringgrid1.cells[8,i])));  //'期初欠款';
  if checkbox1.Checked then
   begin
   get_leng6(strtoint(stringgrid2.Cells[0,i]),strtoint(stringgrid2.Cells[1,i]),
                 yishou,yishou_b);
   stringgrid1.cells[22,i]:=Formatfloat('#,##0.00',yishou);         //第六区间
   total_amount_b[15] := total_amount_b[15]+yishou_b;
   total_amount[15] := total_amount[15]+yishou;

   self.get_leng2_5(strtoint(stringgrid2.Cells[0,i]),strtoint(stringgrid2.Cells[1,i]),
                   dtpk1.Date,dtpk2.Date,yishou,yishou_b);
   stringgrid1.cells[21,i] := Formatfloat('#,##0.00',yishou);       //第五区间
   total_amount_b[14] := total_amount_b[14]+yishou_b;
   total_amount[14] := total_amount[14]+yishou;

   self.get_leng2_5(strtoint(stringgrid2.Cells[0,i]),strtoint(stringgrid2.Cells[1,i]),
                   self.v_date3+1,self.v_date4,yishou,yishou_b);
   stringgrid1.cells[20,i] := Formatfloat('#,##0.00',yishou);       //第四区间
   total_amount_b[13] := total_amount_b[13]+yishou_b;
   total_amount[13] := total_amount[13]+yishou;

   self.get_leng2_5(strtoint(stringgrid2.Cells[0,i]),strtoint(stringgrid2.Cells[1,i]),
                   self.v_date2+1,self.v_date3,yishou,yishou_b);
   stringgrid1.cells[19,i] := Formatfloat('#,##0.00',yishou);       //第三区间
   total_amount_b[12] := total_amount_b[12]+yishou_b;
   total_amount[12] := total_amount[12]+yishou;

   self.get_leng2_5(strtoint(stringgrid2.Cells[0,i]),strtoint(stringgrid2.Cells[1,i]),
                   self.v_date1+1,self.v_date2,yishou,yishou_b);
   stringgrid1.cells[18,i] := Formatfloat('#,##0.00',yishou);       //第二区间
   total_amount_b[11] := total_amount_b[11]+yishou_b;
   total_amount[11] := total_amount[11]+yishou;

   self.get_leng2_5(strtoint(stringgrid2.Cells[0,i]),strtoint(stringgrid2.Cells[1,i]),
                   self.v_date0+1,self.v_date1,yishou,yishou_b);
   stringgrid1.cells[17,i] := Formatfloat('#,##0.00',yishou);       //第一区间
   total_amount_b[10] := total_amount_b[10]+yishou_b;
   total_amount[10] := total_amount[10]+yishou;

   self.get_leng_1(strtoint(stringgrid2.Cells[0,i]),strtoint(stringgrid2.Cells[1,i]),
                  self.v_date0,yishou,yishou_b);
   stringgrid1.cells[16,i] := Formatfloat('#,##0.00',yishou);       //第0区间
   total_amount_b[9] := total_amount_b[9]+yishou_b;
   total_amount[9] := total_amount[9]+yishou;
    end;
   end;
  progressbar1.Position:=90;

  if self.find_date(total_amount) then   //处理原币小计及本币合计
  begin
  stringgrid1.RowCount:=stringgrid1.RowCount+1;
  stringgrid2.RowCount:=stringgrid2.RowCount+1;
  stringgrid1.cells[1,stringgrid1.RowCount-1]:='小计'+self.aq01curr_code.Value;
  Stringgrid2.Cells[0,stringgrid2.RowCount-1]:='0';
  Stringgrid2.Cells[1,stringgrid2.RowCount-1]:='0';
  if checkbox1.Checked then
  for i:=7 to 22 do
   stringgrid1.cells[i,stringgrid1.RowCount-1]:=Formatfloat('#,##0.00', total_amount[i-7])
  else
   for i:=7 to 15 do
    stringgrid1.cells[i,stringgrid1.RowCount-1]:=Formatfloat('#,##0.00', total_amount[i-7]);
  stringgrid1.cells[11,stringgrid1.RowCount-1]:=Formatfloat('#,##0.00',
                       strtocurr(RemoveInvalid(stringgrid1.cells[15,stringgrid1.RowCount-1]))+
                       strtocurr(RemoveInvalid(stringgrid1.cells[14,stringgrid1.RowCount-1]))+
                       strtocurr(RemoveInvalid(stringgrid1.cells[13,stringgrid1.RowCount-1]))-
                       strtocurr(RemoveInvalid(stringgrid1.cells[12,stringgrid1.RowCount-1])));//'期末余额';
  stringgrid1.cells[7,stringgrid1.RowCount-1]:=Formatfloat('#,##0.00',
                       strtocurr(RemoveInvalid(stringgrid1.cells[11,stringgrid1.RowCount-1]))+
                       strtocurr(RemoveInvalid(stringgrid1.cells[10,stringgrid1.RowCount-1]))+
                       strtocurr(RemoveInvalid(stringgrid1.cells[9,stringgrid1.RowCount-1]))-
                       strtocurr(RemoveInvalid(stringgrid1.cells[8,stringgrid1.RowCount-1])));  //'期初欠款';

  stringgrid1.RowCount:=stringgrid1.RowCount+1;
  stringgrid2.RowCount:=stringgrid2.RowCount+1;
  stringgrid1.cells[1,stringgrid1.RowCount-1]:='本币合计';//处理最后一行
  stringgrid2.Cells[0,stringgrid2.RowCount-1]:='0';
  stringgrid2.Cells[1,stringgrid2.RowCount-1]:='0';
  if checkbox1.Checked then
   for i:=7 to 22 do
   begin
    stringgrid1.cells[i,stringgrid1.RowCount-1]:=Formatfloat('#,##0.00', total_amount_b[i-7]);
    total_amount_allb[i-7]:=total_amount_allb[i-7]+total_amount_b[i-7];
   end
  else
   for i:=7 to 15 do
   begin
    stringgrid1.cells[i,stringgrid1.RowCount-1]:=Formatfloat('#,##0.00', total_amount_b[i-7]);
    total_amount_allb[i-7]:=total_amount_allb[i-7]+total_amount_b[i-7];
   end;
   stringgrid1.cells[11,stringgrid1.RowCount-1]:=Formatfloat('#,##0.00',
                       strtocurr(RemoveInvalid(stringgrid1.cells[15,stringgrid1.RowCount-1]))+
                       strtocurr(RemoveInvalid(stringgrid1.cells[14,stringgrid1.RowCount-1]))+
                       strtocurr(RemoveInvalid(stringgrid1.cells[13,stringgrid1.RowCount-1]))-
                       strtocurr(RemoveInvalid(stringgrid1.cells[12,stringgrid1.RowCount-1])));//'期末余额';
   stringgrid1.cells[7,stringgrid1.RowCount-1]:=Formatfloat('#,##0.00',
                       strtocurr(RemoveInvalid(stringgrid1.cells[11,stringgrid1.RowCount-1]))+
                       strtocurr(RemoveInvalid(stringgrid1.cells[10,stringgrid1.RowCount-1]))+
                       strtocurr(RemoveInvalid(stringgrid1.cells[9,stringgrid1.RowCount-1]))-
                       strtocurr(RemoveInvalid(stringgrid1.cells[8,stringgrid1.RowCount-1])));  //'期初欠款';
  end;

  progressbar1.Position:=100;
  v_i:=stringgrid2.RowCount;  //标识下一个循环(区间余额)的开始位
  aq01.Next;
 end;


  if self.find_date(total_amount_allb) then   //本币总计
  begin
   stringgrid1.RowCount:=stringgrid1.RowCount+1;
   stringgrid2.RowCount:=stringgrid2.RowCount+1;
   stringgrid1.cells[1,stringgrid1.RowCount-1]:='本币总计';
   Stringgrid2.Cells[0,stringgrid2.RowCount-1]:='0';
   Stringgrid2.Cells[1,stringgrid2.RowCount-1]:='0';
   if checkbox1.Checked then
   for i:=7 to 22 do
    stringgrid1.cells[i,stringgrid1.RowCount-1]:=Formatfloat('#,##0.00', total_amount_allb[i-7])
   else
   for i:=7 to 15 do
    stringgrid1.cells[i,stringgrid1.RowCount-1]:=Formatfloat('#,##0.00', total_amount_allb[i-7]);
   stringgrid1.cells[11,stringgrid1.RowCount-1]:=Formatfloat('#,##0.00',
                       strtocurr(RemoveInvalid(stringgrid1.cells[15,stringgrid1.RowCount-1]))+
                       strtocurr(RemoveInvalid(stringgrid1.cells[14,stringgrid1.RowCount-1]))+
                       strtocurr(RemoveInvalid(stringgrid1.cells[13,stringgrid1.RowCount-1]))-
                       strtocurr(RemoveInvalid(stringgrid1.cells[12,stringgrid1.RowCount-1])));//'期末余额';
   stringgrid1.cells[7,stringgrid1.RowCount-1]:=Formatfloat('#,##0.00',
                       strtocurr(RemoveInvalid(stringgrid1.cells[11,stringgrid1.RowCount-1]))+
                       strtocurr(RemoveInvalid(stringgrid1.cells[10,stringgrid1.RowCount-1]))+
                       strtocurr(RemoveInvalid(stringgrid1.cells[9,stringgrid1.RowCount-1]))-
                       strtocurr(RemoveInvalid(stringgrid1.cells[8,stringgrid1.RowCount-1])));  //'期初欠款';
  end;

  if stringgrid1.RowCount>1 then
   begin
    stringgrid1.FixedRows:=1;
    stringgrid2.FixedRows:=1;
   end
  else
   begin
    stringgrid1.RowCount:=2;
    stringgrid2.RowCount:=2;
    stringgrid1.FixedRows:=1;
    stringgrid2.FixedRows:=1;
   end;

  end;   //end未确定客户,未确定货币

 SetOptimalGridCellWidth(stringgrid1,[]);  //使所有stringgrid单元格宽度自适应
 AQ_balance.Filter:='';
 aq_lengrece.Filter:='';
 aq_lengyirece.Filter:='';
 AQ_lengcredit.Filter:='';
 aq_finarece.Filter:='';
 aq_finayirece.Filter:='';
 AQ_finacredit.Filter:='';

 self.AQ_balance.Close;
 self.aq_lengrece.Close;
 self.aq_lengyirece.Close;
 self.AQ_lengcredit.Close;
 self.aq_finarece.Close;
 self.aq_finayirece.Close;
 self.AQ_finacredit.Close;

 aq01.Close;

 screen.Cursor:=crDefault;
end;
end;

procedure TForm1.dtpk1Exit(Sender: TObject);
begin
  self.v_date4:=dtpk1.Date-1;
  self.v_date3:=v_date4-dayof(v_date4);
  self.v_date2:=v_date3-dayof(v_date3);
  self.v_date1:=v_date2-dayof(v_date2);
  self.v_date0:=v_date1-dayof(v_date1);  
end;

procedure TForm1.BitBtn3Click(Sender: TObject);
var
 iCount, jCount: Integer;
 XLApp: Variant;
 Sheet: Variant;
begin
 Screen.Cursor := crHourGlass;
 if not VarIsEmpty(XLApp) then
 begin
   XLApp.DisplayAlerts := False;
   XLApp.Quit;
   VarClear(XLApp);
 end;
 try
   XLApp := CreateOleObject('Excel.Application');
 except
   Screen.Cursor := crDefault;
   Exit;
 end;
 XLApp.WorkBooks.Add;
 XLApp.SheetsInNewWorkbook := 1;

 XLApp.WorkBooks[1].WorkSheets[1].Name := self.Caption;
 Sheet := XLApp.Workbooks[1].WorkSheets[self.Caption];
 if stringgrid1.RowCount<=2 then
  begin
   Screen.Cursor := crDefault;
   Exit;
  end;

 for iCount := 0 to stringgrid1.ColCount - 1 do
  Sheet.Cells[1, iCount + 1] := stringgrid1.Cells[icount,0];

 for jcount :=1  to stringgrid1.RowCount-1 do
  for iCount := 0 to stringgrid1.ColCount - 1 do
   Sheet.Cells[jCount + 1, iCount + 1 ] := stringgrid1.Cells[icount,jcount] ;

 XlApp.Visible := True;
 Screen.Cursor := crDefault;
end;



procedure TForm1.CheckBox1Click(Sender: TObject);
begin
if checkbox1.Checked then
 begin
  stringgrid1.ColCount:=23;
  stringgrid1.cells[16,0]:='<='+datetostr(self.v_date0);
  stringgrid1.cells[17,0]:='<='+datetostr(self.v_date1);
  stringgrid1.cells[18,0]:='<='+datetostr(self.v_date2);
  stringgrid1.cells[19,0]:='<='+datetostr(self.v_date3);
  stringgrid1.cells[20,0]:='<='+datetostr(self.v_date4);
  stringgrid1.cells[21,0]:='<='+datetostr(dtpk2.Date);
  stringgrid1.cells[22,0]:='>'+datetostr(dtpk2.Date);
 end
else
 begin
  stringgrid1.ColCount:=16;
 end;
end;

procedure TForm1.StringGrid1SelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
 newrow:=arow;
 newcol:=acol;
 stringgrid1.Refresh;
end;

procedure TForm1.StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
begin
 If (acol>4) then
 begin
   Stringgrid1.Canvas.TextRect(rect,
        rect.right-Stringgrid1.Canvas.TextWidth(trim(Stringgrid1.Cells[aCol,aRow]))-2,
        rect.Top+2,
        trim(Stringgrid1.Cells[aCol,aRow]));

  if arow=newrow then
   begin
    if acol=newcol then
      begin
       stringgrid1.Canvas.Brush.Color := clred;
       stringgrid1.Canvas.FrameRect(rect);
      end
    else
      begin
       stringgrid1.Canvas.Brush.Color := clblue;
       stringgrid1.Canvas.FrameRect(rect);
      end;
   end;
 end;  
end;

procedure TForm1.FormCreate(Sender: TObject);

begin
if not app_init_2(ADOConnection1) then
 begin
  showmsg('程序起动失败,请与管理员联系!',1);
  application.Terminate;
 end;
 self.Caption:= application.Title;

end;

end.

