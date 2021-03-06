unit frm_check_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, ExtCtrls, StdCtrls, ComCtrls;

type
    TFrm_Check = class(TForm)
    Panel1: TPanel;
    SpeedButton2: TSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Label3: TLabel;
    Edit3: TEdit;
    SpeedButton3: TSpeedButton;
    Label5: TLabel;
    Edit4: TEdit;
    SpeedButton4: TSpeedButton;
    pnl1: TPanel;
    pnl2: TPanel;
    SpeedButton5: TSpeedButton;
    Label71: TLabel;
    Label25: TLabel;
    Label67: TLabel;
    Label10: TLabel;
    Label_742deptstr: TLabel;
    Label_741rkey: TLabel;
    Label8: TLabel;
    dt1: TDateTimePicker;
    Label4: TLabel;
    Label6: TLabel;
    Edit6: TEdit;
    SpeedButton6: TSpeedButton;
    Label7: TLabel;
    Memo2: TMemo;
    SpeedButton1: TSpeedButton;
    Edit5: TEdit;
    Label60: TLabel;
    procedure SpeedButton5Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure update_04(v_seed:string);
    procedure btn1Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure Edit5KeyPress(Sender: TObject; var Key: Char);
    procedure SpeedButton6Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Frm_Check: TFrm_Check;
function Power(x, y : extended) : extended;


implementation
 uses common,Pick_Item_Single,ConstVar, uDM, part_search;
{$R *.dfm}

procedure TFrm_Check.SpeedButton5Click(Sender: TObject);
begin
frmcustpart := tfrmcustpart.Create(application);
  with frmcustpart.ADOQuery1 do
  begin
    close;
    if  edit4.Text<>'' then
    begin
    frmcustpart.ADOQuery1.Close;
    frmcustpart.ADOQuery1.Open;
    end
    else
    begin
    frmcustpart.ADOQuery1.SQL.Add(' and MANU_PART_NUMBER LIKE ''%'+Trim(edit4.Text)+'%''');
    end;
    open;
  end;
  frmcustpart.Edit1.Text:=trim(edit2.Text);
 if frmcustpart.ADOQuery1.IsEmpty then
  begin
   messagedlg('请输入正确的产品型号!',mtinformation,[mbok],0);
   edit4.SetFocus;
  end
  else
 if frmcustpart.ShowModal=mrok then
  if frmcustpart.ADOQuery1.FieldByName('onhold_sales_flag').AsString='1' then
    messagedlg('此产品型号已暂缓销售!',mtwarning,[mbcancel],0)
  else
   with dm.ADOQuery1 do
    begin
      close;
      sql.Clear;
      sql.Add('select ORIG_CUSTOMER from data0025 where MANU_PART_NUMBER='''+edit4.Text+'''');
      open;
    end;
   Edit2.Text := trim(frmcustpart.ADOQuery1.fieldvalues['manu_part_number']);
   label71.Caption:=edit2.Text;
   edit4.Font.Color := clwindowtext;
   Edit3.Text:= dm.ADOQuery1.FieldByName('ORIG_CUSTOMER').AsString;
   Edit3.Text:= frmcustpart.ADOQuery1.FieldByName('ABBR_NAME').AsString;
   Label10.Caption := frmcustpart.ADOQuery1.fieldbyname('rkey10').AsString;
   Label67.Visible:=True;
   label67.Caption := frmcustpart.ADOQuery1.fieldbyname('manu_part_desc').AsString;
   label25.Caption:=frmcustpart.ADOQuery1.fieldbyname('rkey25').AsString;

   //dm.ADOFaTest.Parameters.ParamByName('MANU_PART_NUMBER').Value:=Edit4.Text;


end;



procedure TFrm_Check.Button1Click(Sender: TObject);
begin
dm.ADOTMP1.Close;
dm.ADOTMP1.SQL.Clear;
dm.ADOTMP1.SQL.Text:='' ;

end;

procedure TFrm_Check.SpeedButton2Click(Sender: TObject);
begin
close;
end;

procedure TFrm_Check.update_04(v_seed: string);
var
 i,v_length:integer;
 v_last,new_seed:string;
begin
 v_length := length(v_seed);
 for i := v_length downto 1 do
  if not (v_seed[i] in ['0'..'9']) then   //如果不是数字
   begin
    v_last := floattostr(power(10,v_length-1)+strtofloat(copy(v_seed,i+1,v_length-i))+1); //后缀加1
    new_seed := copy(v_seed,1,i)+copy(v_last,i+1,v_length-i);
    dm.adod04.Edit; //使前缀不变后缀加1
    dm.adod04SEED_VALUE.Value := new_seed;
    dm.adod04.Post;
    break;
   end
  else
   if i=1 then //如果第一位仍然是数字
    begin
     v_last := floattostr(power(10,v_length)+strtofloat(v_seed)+1);
     new_seed := copy(v_last,2,v_length);
     dm.adod04.Edit;
     dm.adod04SEED_VALUE.Value := new_seed;
     dm.adod04.Post;
    end;
end;

function Power(x, y : extended) : extended;
begin
result := exp(y*ln(x));
end;


procedure TFrm_Check.btn1Click(Sender: TObject);
begin
if Edit4.Text='' then
  begin
    showmessage('审核流程不能为空...');
    Edit4.SetFocus;
    exit;
  end;
 
  try
   dm.ADOTMP1.SQL.Clear;
   dm.ADOTMP1.SQL.Text:=      ' ' ;
    dm.ADOTMP1.ExecSQL;
    ShowMessage('保存成功');
   except
     ShowMessage('流程定义失败');
   end;
end;

procedure TFrm_Check.SpeedButton3Click(Sender: TObject);
var
  InputVar: PDlgInput ;
begin
    frmPick_Item_Single := TfrmPick_Item_Single.Create(application) ;
  try
    InputVar.Fields := 'RKEY/序号/100,CUST_CODE/客户代码/100,CUSTOMER_NAME/客户名称/277,ABBR_NAME/客户简称/100';
    InputVar.Sqlstr := 'select RKEY,CUST_CODE,CUSTOMER_NAME,ABBR_NAME from Data0010 where CUSTOMER_TYPE<>4';
    InputVar.AdoConn := DM.ADOConnection1 ;
    frmPick_Item_Single.InitForm_New(InputVar)  ;
    if frmPick_Item_Single.ShowModal=mrok then
    begin
      Edit3.Text := frmPick_Item_Single.adsPick.FieldValues['ABBR_NAME'];
      Label10.Caption := frmPick_Item_Single.adsPick.FieldValues['RKEY'];
      Edit3.Font.Color:=clwindowtext;

    end;
  finally
    frmPick_Item_Single.adsPick.Close;
    frmPick_Item_Single.Free ;
  end;

end;

procedure TFrm_Check.SpeedButton4Click(Sender: TObject);
var
  InputVar: PDlgInput ;
begin
  frmPick_Item_Single := TfrmPick_Item_Single.Create(application) ;
  try
  frmPick_Item_Single.Width :=800;
  frmPick_Item_Single.Height :=600;
  InputVar.Fields := 'type_code/审批代码/80,name/审批流程名称/100,dept_name/审批流程/650';
  InputVar.Sqlstr :=dm.Queryofbp.SQL.Text;
  InputVar.AdoConn := dm.ADOConnection1;
  frmPick_Item_Single.InitForm_New(InputVar) ;
  if frmPick_Item_Single.ShowModal=mrok then
  begin
      edit4.Text := frmPick_Item_Single.adsPick.FieldValues['name'];
      Label_741rkey.Caption:=frmPick_Item_Single.adsPick.FieldValues['d741_ptr'];
      Label_742deptstr.Caption :=frmPick_Item_Single.adsPick.FieldValues['dept_name'];



  end;
  finally
  frmPick_Item_Single.adsPick.Close;
  frmPick_Item_Single.Free ;
  end;

end;

procedure TFrm_Check.Edit5KeyPress(Sender: TObject; var Key: Char);
begin
if not (key in ['0'..'9',#8,#13]) then abort;
end;

procedure TFrm_Check.SpeedButton6Click(Sender: TObject);
var
  InputVar: PDlgInput ;
begin
 frmPick_Item_Single := TfrmPick_Item_Single.Create(application) ;
  try
    inputvar.Fields:='sales_order/销售订单/70,sch_date/回复交期/80,cust_code/客户代码/50,manu_part_number/本厂编号/80,'+
     'manu_part_desc/客户型号/90,parts_margin/订单欠数/60,po_number/客户订单号/120,set_qty/交货单元数/30,parts_ordered/订单数量/60,total_shipped/装运数量/60,'+
     'REPUT_APPR_BY/提交入库/60,v_type/加工形式/40,abbrname23/供应商/50,'+
     'reference_number/订单参考/120,ABBR_NAME/工厂/50,STATUS60/订单状态/60,ANALYSIS_CODE_2/客户物料号/90';

     inputvar.Sqlstr:='select d25.rkey,d25.manu_part_number,d25.manu_part_desc,d25.report_unit_value1,'+
     'd25.qty_on_hand,d97.po_number,d97.po_date,d12.location,d60.rkey as rkey60,d60.purchase_order_ptr,'+
     'd60.shipping_method,d60.sales_order,d60.ent_date,d60.sch_date,d60.reference_number,'+
     'case d60.commision_on_tooling when ''Y'' then ''转厂'' else ''内销'' end as v_kind,'+
     'case D60.so_tp WHEN 0 THEN ''自制'' WHEN 1 THEN ''外发'' WHEN 2 THEN ''半制程'' end as v_type,'+
     'D60.PARTS_ALLOC as part_price,D60.state_prod_tax_flag,D60.state_tool_tax_flag,D60.discount,D60.rush_charge,'+
     'd60.parts_ordered,d60.parts_shipped,d60.parts_returned,d60.returned_ship,d60.REPUT_APPR_BY,'+
     'D60.parts_shipped+D60.returned_ship-D60.parts_returned as total_shipped,'+
     'D60.parts_ordered-D60.parts_shipped+D60.parts_returned-D60.returned_ship as parts_margin,'+
     'd10.rkey as rkey10,d10.cust_code,d10.customer_name,d15.ABBR_NAME,d25.set_qty, '+
     'data0023.abbr_name as abbrname23 , case d60.STATUS when 1 then ''有效'' '+
     'when 2 then ''暂缓'' when 3 then ''关闭'' end as STATUS60  ,d25.ANALYSIS_CODE_2 '+
     'from data0060 d60 inner join data0025 d25 on d60.cust_part_ptr=d25.rkey '+
     'inner join data0010 d10 on d60.customer_ptr=d10.rkey '+
     'inner join data0097 d97 on d60.purchase_order_ptr=d97.rkey '+
     'inner join data0012 d12 on d60.cust_ship_addr_ptr=d12.rkey '+
     'inner join data0015 d15 on d60.SHIP_REG_TAX_ID=d15.rkey '+
     'LEFT OUTER JOIN Data0023 ON d60.supplier_ptr = Data0023.RKEY '+
     'where d60.status in (1 , 2) and d60.prod_rel<>3';

    InputVar.AdoConn := DM.ADOConnection1 ;
    frmPick_Item_Single.InitForm_New(InputVar)  ;
    if frmPick_Item_Single.ShowModal=mrok then
    begin

      Edit6.Text := frmPick_Item_Single.adsPick.FieldValues['sales_order'];
      Label60.Caption := frmPick_Item_Single.adsPick.FieldValues['rkey60'];

    end;
  finally
    frmPick_Item_Single.adsPick.Close;
    frmPick_Item_Single.Free ;
  end;

end;


procedure TFrm_Check.SpeedButton1Click(Sender: TObject);
begin
 
 modalresult:=mrok;

end;



end.

