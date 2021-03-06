unit putprod;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, Grids, Menus,math,StrUtils;

type
  TForm_putprod = class(TForm)
    stg1: TStringGrid;
    Label1: TLabel;
    Panel2: TPanel;
    Label2: TLabel;
    stg2: TStringGrid;
    stg3: TStringGrid;
    Label3: TLabel;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Splitter1: TSplitter;
    ComboBox1: TComboBox;
    Label4: TLabel;
    Label9: TLabel;
    Edit1: TEdit;
    SpeedButton1: TSpeedButton;
    PopupMenu2: TPopupMenu;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    Splitter2: TSplitter;
    PopupMenu3: TPopupMenu;
    N6: TMenuItem;
    procedure FormActivate(Sender: TObject);
    procedure stg1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure PopupMenu2Popup(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure PopupMenu3Popup(Sender: TObject);
    procedure N6Click(Sender: TObject);
  private
    { Private declarations }
   ct_reson:string;    //超投原因
   function cutno(rkey25:integer;_type:byte):string;
   function partin(rkey25:integer):byte;
   function new_wo(rkey25: integer): byte;
   function returen_maxLOTNUM(rkey25: integer):integer;
   procedure update_04(v_seed: string);
   function maxstep(rkey25,step:integer):boolean;
   function if_waichen(rkey25:integer):boolean;
   function returen_pnlnumber(rkey25,pnlab:string):integer;
   function isnum(str:string):boolean;
  public
    { Public declarations }
   whouseptr,mrbptr,deptptr,CUSTOMER_PTR:integer; //工厂15,退货mrb414指针,返工工序34.rkey,客户指针
   so_number:string;         //销售订单
   begin_step,parts_count:byte; //返工投产开始步骤，产品部件总数
  end;

var
  Form_putprod: TForm_putprod;

implementation

uses damo,common, bominvt;

{$R *.dfm}

function TForm_putprod.cutno(rkey25: integer;_type:byte): string;
var
 i:integer;
begin
result:='';
 for i:=1 to stg1.RowCount-1 do
  if strtoint(stg1.Cells[11,i])= rkey25 then
   begin
    result:=stg1.Cells[_type,i];
    break;
   end;
end;

function TForm_putprod.new_wo(rkey25: integer): byte;
var
 sql_str:string;
begin
 sql_str:='select rkey from data0006 '+
          'where PROD_STATUS<>202 '+
          'and bom_ptr='+inttostr(rkey25);
 openquery(dm.ADOQuery1,sql_str);
 if dm.ADOQuery1.IsEmpty then
  result:=1
 else
  result:=0;
 dm.ADOQuery1.Close;
end;

function TForm_putprod.returen_maxLOTNUM(rkey25: integer): integer;
var
 sql_str:string;
begin
 sql_str:='select MAX(LOT_NUMBER) AS LOTNUMBER from data0006 '+
          'WHERE bom_ptr='+inttostr(rkey25);
 openquery(dm.ADOQuery1,sql_str);
 try
 if dm.ADOQuery1.FieldByName('LOTNUMBER').IsNull then
  result:=0
 else
  if dm.ADOQuery1.FieldByName('LOTNUMBER').Asinteger>=9999 then
   result:=0
  else
   result:=dm.ADOQuery1.FieldByName('LOTNUMBER').Asinteger;
 except
   result:=0
 end;
 dm.ADOQuery1.Close;
end;

function TForm_putprod.partin(rkey25: integer): byte; //查出当前产品下面是否有儿子
var                                     //任何一个儿子的压合步骤是否为当前产品第一步过数工数
 sql_str:string;                        //当前产品第一步过数工序不一定是第一个步骤
begin
  result:=1;
 sql_str:='select rkey,BOM_STEP from data0025 '+
          'where PARENT_PTR='+inttostr(rkey25);
 openquery(dm.ADOQuery1,sql_str);
 if not dm.ADOQuery1.IsEmpty then     //有子部件
  begin
   sql_str:=' select min(data0038.step_number) as step'+#13+
    'from data0038 inner join data0034'+#13+
    'on data0038.dept_ptr=data0034.rkey'+#13+
    'where source_ptr='+inttostr(rkey25)+#13+
    'and BARCODE_ENTRY_FLAG=''Y''';
    openquery(dm.ADOQuery2,sql_str);
    while not dm.ADOQuery1.Eof do
     begin
       if dm.ADOQuery1.FieldByName('BOM_STEP').AsInteger=
          dm.ADOQuery2.FieldByName('step').AsInteger  then
        begin
          result:=0;
          break;
        end;
      dm.ADOQuery1.Next;
     end;
  end;
 dm.ADOQuery1.Close;
end;

procedure TForm_putprod.update_04(v_seed: string);
var
 i,v_length:integer;
 v_last,new_seed:string;
begin

 if dm.aqy04SEED_FLAG.Value<>1 then
 begin
 v_length := length(v_seed);
 for i := v_length downto 1 do
  if (copy(v_seed,i,1)<'0') or (copy(v_seed,i,1)>'9') then  //如果不是数字
   begin
    v_last := floattostr(power(10,v_length-1)+strtofloat(copy(v_seed,i+1,v_length-i))+1); //后缀加1
    new_seed := copy(v_seed,1,i)+copy(v_last,i+1,v_length-i);
    dm.aqy04.Edit; //使前缀不变后缀加1
    dm.aqy04SEED_VALUE.Value := new_seed;
    dm.aqy04.Post;
    break;
   end
  else
   if i=1 then //如果第一位仍然是数字
    begin
     v_last := floattostr(power(10,v_length)+strtofloat(v_seed)+1);
     new_seed := copy(v_last,2,v_length);
     dm.aqy04.Edit;
     dm.aqy04SEED_VALUE.Value := new_seed;
     dm.aqy04.Post;
    end;
 end;
end;

function TForm_putprod.if_waichen(rkey25:integer): boolean;
var
 sql_str:string;
begin                //查出当前产品是否为外层
 sql_str:='select PARENT_PTR from data0025 '+
          'where rkey='+inttostr(rkey25)+
          ' and PARENT_PTR is null';
 openquery(dm.ADOQuery1,sql_str);
 if not dm.ADOQuery1.IsEmpty then
  result:=true       //不为空记录找到外层
 else
  result:=false;
 dm.ADOQuery1.Close;
end;

function TForm_putprod.maxstep(rkey25, step: integer): boolean;
var
 sql_str:string;
begin
sql_str:=
    'SELECT max(Data0038.STEP_NUMBER) as maxstep'+#13+
    'FROM   Data0038 INNER JOIN'+#13+
    'Data0034 ON Data0038.DEPT_PTR = Data0034.RKEY'+#13+
    'WHERE  (Data0034.BARCODE_ENTRY_FLAG = ''Y'') and'+#13+
    '(Data0038.SOURCE_PTR ='+inttostr(rkey25)+')';
openquery(dm.ADOQuery1,sql_str);
if dm.ADOQuery1.FieldByName('maxstep').AsInteger=step then
 result:=true
else
 result:=false;
dm.ADOQuery1.Close;
end;

procedure TForm_putprod.FormActivate(Sender: TObject);
begin
with stg1 do
 begin
  cells[0,0]:='配料单号';
  cells[1,0]:='本厂编号';
  cells[2,0]:='完工日期';
  cells[3,0]:='待计划数';
  cells[4,0]:='计划数';
  cells[5,0]:='投产数';
  cells[6,0]:='投A板数';
  cells[7,0]:='投B板数';
  cells[8,0]:='超投率%';
  cells[9,0]:='备注';
  cells[10,0]:='大料规格';
  cells[11,0]:='rkey25';
  ColWidths[11]:=-1;
  cells[12,0]:='A板PCS';
  cells[13,0]:='B板PCS';
  cells[14,0]:='A板尺寸';
  cells[15,0]:='B板尺寸';
  cells[16,0]:='引用库存';
  cells[17,0]:='so';
  cells[18,0]:='cusotmer_ptr';

  ColWidths[17]:=-1;
  ColWidths[18]:=-1;

 end;
with stg2 do
 begin
  cells[0,0]:='配料单号';
  cells[1,0]:='本厂编号';
  cells[2,0]:='工序代码';
  cells[3,0]:='步骤';
  cells[4,0]:='材料编码';
  cells[5,0]:='材料名称';
  cells[6,0]:='材料规格';
  cells[7,0]:='单位';
  cells[8,0]:='当前库存';
  cells[9,0]:='配额';
  cells[10,0]:='类型';
  cells[11,0]:='列印';
  cells[12,0]:='供应商';
  cells[13,0]:='rkey25';
  cells[14,0]:='rkey34';
  cells[15,0]:='rkey17';
  cells[16,0]:='rkey23';
  ColWidths[13]:=-1;
  ColWidths[14]:=-1;
  ColWidths[15]:=-1;
  ColWidths[16]:=-1;
  cells[17,0]:='退边料数量';
 end;
with stg3 do
 begin
  cells[0,0]:='配料单号';
  cells[1,0]:='本厂编号';
  cells[2,0]:='作业单号';
  cells[3,0]:='计划数量';
  cells[4,0]:='PNL数';
  cells[5,0]:='PCS数/PNL';
  cells[6,0]:='完工日期';
  cells[7,0]:='PNL长';
  cells[8,0]:='PNL宽';
  cells[9,0]:='PNL尺寸';
  cells[10,0]:='rkey25';
  cells[11,0]:='ABPNL';
  ColWidths[10]:=-1;
  ColWidths[11]:=-1;
  cells[12,0]:='紧急程度';
  cells[13,0]:='紧急程度code';
  ColWidths[13]:=-1;
 end;

self.ct_reson:='';//超投原因
speedbutton1.Enabled:=edit1.Text='超投';

if speedbutton1.Enabled then
 edit1.Color:=clfuchsia
else
 edit1.Color:=claqua;

if strtoint(vprev)=4 then
 stg2.PopupMenu:=popupmenu2
else
 stg2.PopupMenu:=nil;
 
if combobox1.ItemIndex=3 then //返工投产
 begin
  self.Splitter1.Visible:=false;
  label2.Visible:=false;
  stg2.Visible:=false;
  panel2.Height:=126;
  stg1.Align:=alclient;
 end;

end;

procedure TForm_putprod.stg1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  column, row: longint; //右键选择stringgrid控件的方法
begin
 if button = mbright then
  begin
   (Sender as tstringgrid).MouseToCell(x, y, column, row);
   if row <> 0 then
    begin
     (Sender as tstringgrid).Row := row;
    end;
  end;
end;

procedure TForm_putprod.N1Click(Sender: TObject);
begin
stg1.Cells[9,stg1.Row]:= InputBox('备注信息', '请输入备注信息      ', stg1.Cells[9,stg1.Row]);
end;

procedure TForm_putprod.N2Click(Sender: TObject);
begin
stg1.Cells[10,stg1.Row]:= InputBox('大料规格', '请输入大料规格      ', stg1.Cells[10,stg1.Row]);
end;

procedure TForm_putprod.SpeedButton1Click(Sender: TObject);
begin
self.ct_reson:=
 InputBox('信息输入', '超投原因:      ', self.ct_reson);
end;

procedure TForm_putprod.PopupMenu2Popup(Sender: TObject);
begin
if stg2.Row=stg2.RowCount-1 then
 begin
  n4.Enabled:=false;
  n5.Enabled:=false;
 end
else
 begin
  n4.Enabled:=true;
  n5.Enabled:=true;
 end;
end;

procedure TForm_putprod.N3Click(Sender: TObject);
var
 i:integer;
begin
 try
 with   TForm_bominvt.Create(application) do
  begin
     for i:=1 to self.stg1.RowCount-1 do
    begin
     combobox1.Items.Add(stg1.Cells[0,i]);
     cutno_part.Add(stg1.Cells[1,i]+';'+stg1.Cells[11,i]);
    end;
    combobox1.ItemIndex:=0;
    edit1.Text:=copy(cutno_part.Strings[0],1,
                     pos(';',cutno_part.Strings[0])-1);
    rkey25.Caption:=copy(cutno_part.Strings[0],
                         pos(';',cutno_part.Strings[0])+1,
                         length(cutno_part.Strings[0])-
                         pos(';',cutno_part.Strings[0]));

    dm.ADOQuery7.close;
    dm.ADOQuery7.Parameters.ParamByName('MANU_PART_NUMBER').Value:=edit1.Text;
    dm.ADOQuery7.open;
    edit16.Text:= dm.ADOQuery7.fieldByName('PARAMETER_VALUE').Value;


    dm.ADOQuery12.close;
    dm.ADOQuery12.Parameters.ParamByName('MANU_PART_NUMBER').Value:=edit1.Text;
    dm.ADOQuery12.open;
    edit17.Text:=dm.ADOQuery12.fieldByName('PARAMETER_VALUE').Value;






   if ShowModal=mrok then
    begin
     stg2.cells[0,stg2.RowCount-1]:=combobox1.Text; //'配料单号';
     stg2.cells[1,stg2.RowCount-1]:=edit1.Text; //'本厂编号';
     stg2.cells[2,stg2.RowCount-1]:=edit2.Text; //'工序代码';
     stg2.cells[3,stg2.RowCount-1]:=edit9.Text; //'步骤';
     stg2.cells[4,stg2.RowCount-1]:=edit3.Text; //'材料编码';
     stg2.cells[5,stg2.RowCount-1]:=edit4.Text; //'材料名称';
     stg2.cells[6,stg2.RowCount-1]:=edit5.Text; //'材料规格';
     stg2.cells[7,stg2.RowCount-1]:=edit8.Text; //'单位';
     stg2.cells[8,stg2.RowCount-1]:=Edit10.Text; //'当前库存';
     stg2.cells[12,stg2.RowCount-1]:=edit7.Text; //'供应商';
     stg2.cells[9,stg2.RowCount-1]:=edit6.text; //'配额';
     stg2.cells[10,stg2.RowCount-1]:=combobox2.Text; //'类型';

     if (Label18.Caption='普通库存') or (Label18.Caption='余料库存') then
     begin
      stg2.cells[11,stg2.RowCount-1]:='Y'
     end
     else
      stg2.cells[11,stg2.RowCount-1]:='N';


     {
     if Label18.Caption='余料库存' then
     begin
      stg2.cells[11,stg2.RowCount-1]:='Y'
     end; }

     {
     if Label18.Caption='VMI库存' then
     begin
      stg2.cells[11,stg2.RowCount-1]:='N'
     end; }

     stg2.cells[12,stg2.RowCount-1]:=edit7.Text; //'备注';
     stg2.cells[13,stg2.RowCount-1]:=rkey25.Caption; //'rkey25';
     stg2.cells[14,stg2.RowCount-1]:=rkey34.caption; //'rkey34';


      if Label18.Caption='余料库存' then
     begin
      stg2.cells[15,stg2.RowCount-1]:=rkey556.Caption; //'rkey17';
     end
     else
     begin
     stg2.cells[15,stg2.RowCount-1]:=rkey17.Caption; //'rkey17';
     end;
     stg2.cells[16,stg2.RowCount-1]:=IntToStr(BitBtn5.Tag); //rkey34
     stg2.Cells[17,stg2.RowCount-1]:=Trim(Edit14.Text);   //退边料
     stg2.RowCount:=stg2.RowCount+1;
     stg2.Row:=stg2.RowCount-2;
    end;
  end;
 finally
  Form_bominvt.Free;
 end;
end;

procedure TForm_putprod.N4Click(Sender: TObject);
var
 i:integer;
begin
 try
 with   TForm_bominvt.Create(application) do
  begin
    combobox1.Items.Add(cutno(strtoint(stg2.cells[13,stg2.row]),0));  //'配料单号';
    combobox1.ItemIndex:=0;
    edit1.Text:=cutno(strtoint(stg2.cells[13,stg2.row]),1);    //'本厂编号';
    edit9.Text:=stg2.cells[3,stg2.row]; //'步骤';
    edit3.Text:=stg2.cells[4,stg2.row]; //'材料编码';
    edit4.Text:=stg2.cells[5,stg2.row]; //'材料名称';
    edit5.Text:=stg2.cells[6,stg2.row]; //'材料规格';
    edit8.Text:=stg2.cells[7,stg2.row]; //'单位';
    edit7.Text:=stg2.cells[12,stg2.row]; //'供应商';
    edit6.text:=stg2.cells[9,stg2.row]; //'配额';



    dm.ADOQuery7.close;
    dm.ADOQuery7.Parameters.ParamByName('MANU_PART_NUMBER').Value:=edit1.Text;
    dm.ADOQuery7.open;
    edit16.Text:= dm.ADOQuery7.fieldByName('PARAMETER_VALUE').Value;


    dm.ADOQuery12.close;
    dm.ADOQuery12.Parameters.ParamByName('MANU_PART_NUMBER').Value:=edit1.Text;
    dm.ADOQuery12.open;
    edit17.Text:=dm.ADOQuery12.fieldByName('PARAMETER_VALUE').Value;


    if stg2.Cells[17,stg2.row]='' then Edit14.Text:='0'
    ELSE Edit14.Text:=stg2.Cells[17,stg2.row]; //退边料
    combobox2.ItemIndex:= //'类型';
      combobox2.Items.IndexOf(stg2.cells[10,stg2.row]);
    if (stg2.cells[11,stg2.row]='Y') and (stg2.cells[10,stg2.row]='标准') then //'';
     begin
     label18.Caption:='普通库存'
     end;

    if (stg2.cells[11,stg2.row]='Y') and (stg2.cells[10,stg2.row]='余料') then //'';
     begin
     label18.Caption:='余料库存'
     end;

    if (stg2.cells[11,stg2.row]='N') and (stg2.cells[10,stg2.row]='标准') then //'';
     begin
     label18.Caption:='VMI库存'
     end;

    edit10.Text:=stg2.cells[8,stg2.row]; //'当前库存';
    rkey25.Caption:=stg2.cells[13,stg2.row]; //'rkey25';
    rkey34.caption:=stg2.cells[14,stg2.row]; //'rkey34';
    rkey17.Caption:=stg2.cells[15,stg2.row]; //'rkey17';
    combobox1.Enabled:=false;
    combobox2.Enabled:=false;
   if ShowModal=mrok then
    begin
      stg2.cells[0,stg2.row]:=combobox1.Text; //'配料单号';
      stg2.cells[1,stg2.row]:=edit1.Text; //'本厂编号';
      stg2.cells[2,stg2.row]:=edit2.Text; //'工序代码';
      stg2.cells[3,stg2.row]:=edit9.Text; //'步骤';
      stg2.cells[4,stg2.row]:=edit3.Text; //'材料编码';
      stg2.cells[5,stg2.row]:=edit4.Text; //'材料名称';
      stg2.cells[6,stg2.row]:=edit5.Text; //'材料规格';
      stg2.cells[7,stg2.row]:=edit8.Text; //'单位';
      stg2.cells[12,stg2.row]:=edit7.Text; //'供应商';
      stg2.cells[9,stg2.row]:=edit6.text; //'配额';
      stg2.cells[10,stg2.row]:=combobox2.Text; //'类型';
      if Label18.Caption='普通库存' then
       stg2.cells[11,stg2.row]:='Y'
      else
       stg2.cells[11,stg2.row]:='N'; //'列印';
      stg2.cells[8,stg2.row]:=edit10.Text; //'当前库存';
      stg2.cells[13,stg2.row]:=rkey25.Caption; //'rkey25';
      stg2.cells[14,stg2.row]:=rkey34.caption; //'rkey34';
      stg2.cells[15,stg2.row]:=rkey17.Caption; //'rkey17';
      stg2.cells[16,stg2.row]:=IntToStr(BitBtn5.Tag); //'rkey23';
      stg2.Cells[17,stg2.row]:=Trim(Edit14.Text);  //退边料
    end;
  end;
 finally
  Form_bominvt.Free;
 end;
end;



procedure TForm_putprod.N5Click(Sender: TObject);
var
 i:integer;
begin
 for i:=stg2.Row to stg2.RowCount-2 do
  stg2.Rows[i].Text:=stg2.Rows[i+1].Text;
 stg2.RowCount:=stg2.RowCount-1;
end;

procedure TForm_putprod.BitBtn1Click(Sender: TObject);
var
 i,i_j,Max_lot,SUB_LEVELS:integer;
 wip_code:string;
begin
 if (combobox1.ItemIndex=3) then //返修投产需要检查是否正在盘点
 begin
   wip_code:=dm.find_wip_code;
   if wip_code<>'' then
   begin
    showmsg('在制品正在盘点不允许投产,盘点代码:'+wip_code,1);
    exit;
   end;
 end;

 if (combobox1.ItemIndex=4) and
    (edit1.Text='未超投') then  //合并投产
 begin
   with DM.ADOQuery1 do
   begin
     Close;
     sql.Text:=
     'SELECT  dbo.Data0060.SALES_ORDER '+
     'FROM  dbo.SpellRelation INNER JOIN'+
     ' dbo.Data0060 ON dbo.SpellRelation.PO_PTR = dbo.Data0060.RKEY'+
     ' where SpellRelation.Spellto_PTR='+stg1.Cells[11,1]+
     ' and data0060.prod_rel=''2'' and data0060.SpellTogether=1'; //订单已确认，已合并
     open;
   end;
   if dm.ADOQuery1.IsEmpty then
    begin
     showmsg('合并投产失败,可能多人同时投产',1);
     exit;
    end;
 end;

 if (combobox1.ItemIndex=0) then  //按订单投产
  with dm.ADOQuery1 do
  begin
   close;
   sql.Text:='select prod_rel,to_be_planned,qty_plannned,issued_qty'+#13+
              'from data0060 where sales_order='+quotedstr(self.so_number);
   open;
   if (FieldByName('to_be_planned').AsInteger<>dm.ADS60TO_BE_PLANNED.Value) or
      (FieldByName('prod_rel').AsInteger<>2) then
    begin
     showmsg('订单待计划数发生变化投产失败,可能多人同时对同一订单投产',1);
     exit;
    end;
  end
 else
 if (combobox1.ItemIndex=2) or (combobox1.ItemIndex=3) then
 with dm.ADOQuery1 do
  begin
   close;
      sql.Text:='select qty_to_be_reworked,qty_reworked,'+#13+
                'qty_to_be_remaked,qty_remaked,status'+#13+
                'from data0414 where rkey='+inttostr(self.mrbptr);
   open;
   if (combobox1.ItemIndex=2) then       //mrb重投
    if FieldByName('qty_remaked').AsInteger<>0 then
    begin
     showmsg('MRB待重制数发生变化投产失败,可能多人同时对同一订单投产',1);
     exit;
    end
    else
   else                           //mrb返修
    if FieldByName('qty_reworked').AsInteger<>0 then
    begin
     showmsg('MRB待返工数发生变化投产失败,可能多人同时对同一订单投产',1);
     exit;
    end
  end;

dm.aqy04.Close;
dm.aqy04.Open;

if copy(stg1.Cells[0,1],1,
        pos('-',stg1.Cells[0,1])-1)<>dm.aqy04SEED_VALUE.Value then
 begin
  showmsg('配料单号重,可能多人同时投产,其前缀将更新成:'+dm.aqy04SEED_VALUE.Value,1);
  for i:=1 to stg1.RowCount-1 do
   begin
    for i_j:=1 to stg3.RowCount-2 do
     if strtoint(stg3.Cells[10,i_j])=strtoint(stg1.cells[11,i]) then
      stg3.Cells[2,i_j]:=StringReplace(stg3.Cells[2,i_j],stg1.Cells[0,i],
                        dm.aqy04SEED_VALUE.Value+'-'+inttostr(i-1),
                        [rfReplaceAll]);
    stg1.Cells[0,i]:=dm.aqy04SEED_VALUE.Value+'-'+inttostr(i-1);
   end;
 end;

if (self.Edit1.Text='超投') and (trim(self.ct_reson)='') then
 begin
  showmsg('本次投产超投,请输入超投原因',1);
  edit1.SetFocus;
  exit;
 end;

dm.ADOConnection1.BeginTrans;
try
 dm.AQY492.Close;
 dm.AQY492.Open;
 dm.AQY468.Close;
 dm.AQY468.Open;
 dm.AQY06.Close;
 dm.AQY06.Open;
 Max_lot:=0;
for i:=1 to stg1.RowCount-1 do
begin
 dm.AQY492.Append;
 dm.AQY492TTYPE.Value:=combobox1.ItemIndex;

 dm.AQY492CUT_NO.Value:=stg1.Cells[0,i];

 if (Trim(stg1.cells[17,i])<>'') and (combobox1.ItemIndex=1) then
  self.so_number :=Trim(stg1.cells[17,i]); //合拼补料投产
                                                  //按订单或补料投产
// if (combobox1.ItemIndex=0) or (combobox1.ItemIndex=1) then
  if self.so_number<>'' then
  dm.AQY492SO_NO.Value:=self.so_number;

 if (Trim(stg1.cells[17,i])<>'') and (combobox1.ItemIndex=4) then //合并投产
  begin
   dm.AQY492SO_NO.Value:= Trim(stg1.cells[17,i]); //合拼投产销售订单
   dm.AQY492TTYPE.Value:=0;                    //合并投产的子订单应为正常投产
  end;

 dm.AQY492BOM_PTR.Value:=strtoint(stg1.cells[11,i]);
 dm.AQY492ORD_REQ_QTY.Value:=strtoint(stg1.cells[3,i]);
 dm.AQY492PLANNED_QTY.Value:=strtoint(stg1.cells[4,i]);
 dm.AQY492ISSUED_QTY.Value:=strtoint(stg1.cells[5,i]);
 dm.AQY492SCH_COMPL_DATE.Value:=StrToDateTime(stg1.Cells[2,i]);
 dm.AQY492ISSUE_DATE.Value:=getsystem_date(dm.ADOQuery1,0);
 dm.AQY492CREATED_BY_PTR.Value:=strtoint(user_ptr);
 dm.AQY492UPANEL1.Value:=strtoint(stg1.cells[12,i]);    //A板PCS数
 dm.AQY492PANEL_1_QTY.Value:=strtoint(stg1.cells[6,i]); //A板块数
 dm.AQY492UPANEL2.Value:=strtoint(stg1.cells[13,i]);    //B板PCS
 dm.AQY492PANEL_2_QTY.Value:=strtoint(stg1.cells[7,i]);  //投B板块数
 DM.AQY492operation_rate.AsString:=stg1.cells[8,i];     //预投率
 dm.AQY492remark.Value:=stg1.Cells[9,i];
 dm.AQY492analysis_code_3.Value:=stg1.Cells[10,i];
 if (self.Edit1.Text='超投') then
  dm.AQY492TSTATUS.Value:=1  //未审核
 else
  dm.AQY492TSTATUS.Value:=2;
 dm.AQY492Con_Flag.Value:=0;
 dm.AQY492WHOUSE_PTR.Value:=self.whouseptr;
 if (combobox1.ItemIndex=2) or (combobox1.ItemIndex=3) then
  dm.AQY492mrb_ptr.Value:=self.mrbptr;
 dm.AQY492pnl1_size.Value:=stg1.cells[14,i];
 dm.AQY492pnl2_size.Value:=stg1.cells[15,i];
 dm.AQY492cite_qryonhand.AsString:=stg1.cells[16,i]; //'引用库存'
 if combobox1.ItemIndex<>3 then      //不是返工投产
  begin
   dm.AQY492waitfor_release.Value := dm.AQY492ISSUED_QTY.Value;
   if self.if_waichen(dm.AQY492BOM_PTR.Value) then //如果是外层产品
    Max_lot:=self.returen_maxLOTNUM(dm.AQY492BOM_PTR.Value);
  end
 else        //返修投产
  dm.AQY492wip_qty.Value := dm.AQY492ISSUED_QTY.Value;

 dm.AQY492COMPLETED.Value:=self.CUSTOMER_PTR;   //客户代码10.rkey
 if Trim(stg1.cells[18,i])<> '' then
   dm.AQY492COMPLETED.Value:=StrToInt(stg1.cells[18,i]); //合拼投产客户代码

 dm.AQY492.Post;

 if dm.AQY492TSTATUS.Value=1 then   //超投需要审核增加审核表
  with dm.ADOQuery2 do
  begin
   close;
   sql.Text:='INSERT INTO Data0491 (MO_PTR, APP_QUAN, remark)'+#13+
             'values('+dm.AQY492rkey.AsString+','+#13+
             inttostr(dm.AQY492ISSUED_QTY.Value-dm.AQY492ORD_REQ_QTY.Value)+#13+
             ','+quotedstr(self.ct_reson)+')';
   ExecSQL;
  end;

 for i_j:=1 to stg2.RowCount-2 do
  if  strtoint(stg2.Cells[13,i_j])=dm.AQY492BOM_PTR.Value then
  begin
    dm.AQY468.Append;
   dm.AQY468CUT_NO.Value:=dm.AQY492CUT_NO.Value;
   if (combobox1.ItemIndex=0) or (combobox1.ItemIndex=1) then
    dm.AQY468SO_NO.Value:=dm.AQY492SO_NO.Value;
   dm.AQY468STEP.Value:=strtoint(stg2.cells[3,i_j]);
   dm.AQY468DEPT_PTR.Value:=strtoint(stg2.cells[14,i_j]);
   dm.AQY468INVENT_PTR.Value:=strtoint(stg2.cells[15,i_j]);
   dm.AQY468QUAN_BOM.Value:=strtofloat(stg2.cells[9,i_j]);
   dm.AQY468STATUS.Value:=0;
   dm.AQY468VENDOR.Value:=stg2.Cells[12,i_j];
   if stg2.Cells[10,i_j]='余料' then
    dm.AQY468Invent_or.Value:=1
   else
    dm.AQY468Invent_or.Value:=0;
   dm.AQY468printit.Value:=stg2.Cells[11,i_j];
   if StrToIntDef(stg2.Cells[16,i_j],0)>0 then
   dm.AQY468supplier_ptr.Value:=StrToIntDef(stg2.Cells[16,i_j],0);
   DM.AQY468offcut_qty.Value:=StrToIntDEF(stg2.Cells[17,i_j],0);

   dm.AQY468.Post;
  end; //end for i_j

 SUB_LEVELS:=1;     //作业单顺序号
 for i_j:=1 to stg3.RowCount-2 do
  if  strtoint(stg3.Cells[10,i_j])=dm.AQY492BOM_PTR.Value then
   begin
    dm.AQY06.Append;
    dm.AQY06WORK_ORDER_NUMBER.Value:=stg3.Cells[2,i_j];
    dm.AQY06CUT_NO.Value:=dm.AQY492CUT_NO.Value;
    dm.AQY06PANEL_A_B.Value:=strtoint(stg3.Cells[11,i_j]);
    dm.AQY06BOM_PTR.Value:=strtoint(stg3.Cells[10,i_j]);
    if dm.AQY492TTYPE.Value<>3 then     //不是返修投产 (需要开料做的)
     begin
      dm.AQY06PROD_STATUS.Value:=2;  //待发放
      dm.AQY06WIPMAT_STATUS.Value:=self.partin(dm.AQY06BOM_PTR.Value);
      if self.if_waichen(dm.AQY492BOM_PTR.Value) then //如果是外层产品
       begin
         dm.AQY06LOT_NUMBER.Value:=rightstr('000'+inttostr(i_j+Max_lot),4);
         if (copy(stg3.Cells[2,i_j],Pos('-',stg3.Cells[2,i_j])+2,1)='A') or   //有A,B拼版的作业单时
            (copy(stg3.Cells[2,i_j],Pos('-',stg3.Cells[2,i_j])+2,1)='B') then
          dm.AQY06CUTNO_WO.Value:=LeftStr(Trim(dm.AQY06CUT_NO.Value),
                                         Length(Trim(dm.AQY06CUT_NO.Value))-2)+
                        copy(stg3.Cells[2,i_j],Pos('-',stg3.Cells[2,i_j])+2,1)+
           RightStr(stg3.Cells[2,i_j],Pos('-',ReverseString(stg3.Cells[2,i_j])))
         ELSE
          dm.AQY06CUTNO_WO.Value:=LeftStr(Trim(dm.AQY06CUT_NO.Value),
                                         Length(Trim(dm.AQY06CUT_NO.Value))-2)+
           RightStr(stg3.Cells[2,i_j],Pos('-',ReverseString(stg3.Cells[2,i_j])));
       end;
     end
    else
     begin       //返修投产直接发放工单    返修投产工单没有批次号
      if self.maxstep(dm.AQY06BOM_PTR.Value,self.begin_step) then
       dm.AQY06PROD_STATUS.Value:=5  //待入仓
      else
       dm.AQY06PROD_STATUS.Value:=3;//生产中
      dm.AQY06WIPMAT_STATUS.Value:=1;  //内层已分配   (在线物料状态)
      dm.AQY06employee_ptr.Value:=strtoint(user_ptr);
      dm.AQY06RELEASE_DATE.Value:=dm.AQY492ISSUE_DATE.Value;
     end;
    dm.AQY06QUAN_SCH.Value:=strtofloat(stg3.Cells[3,i_j]);
    dm.AQY06PANELS.Value:=strtoint(stg3.Cells[4,i_j]);
    dm.AQY06remark_pnls.Value:=dm.AQY06PANELS.Value;
    dm.AQY06PARTS_PER_PANEL.Value:=strtofloat(stg3.Cells[5,i_j]);
    dm.AQY06SCH_COMPL_DATE.Value:=StrToDateTime(stg3.Cells[6,i_j]);
    dm.AQY06ENT_DATETIME.Value:=dm.AQY492ISSUE_DATE.Value;
    dm.AQY06panel_ln.Value:=strtofloat(stg3.Cells[7,i_j]);
    dm.AQY06panel_wd.Value:=strtofloat(stg3.Cells[8,i_j]);
    dm.AQY06pnl_size.Value:=stg3.Cells[9,i_j];

    dm.AQY06BEGIN_STEP_NO.Value:=self.begin_step;
    dm.AQY06ppc_flag.Value:=self.new_wo(dm.AQY06BOM_PTR.Value); //是否第一次投产第一张工单0否1是
    dm.AQY06WHOUSE_PTR.Value:=self.whouseptr;
    dm.AQY06SUB_LEVELS.Value:=SUB_LEVELS;     //作业单顺序号
    dm.AQY06.Post;
    Inc(SUB_LEVELS);       // SUB_LEVELS:=SUB_LEVELS+1;  (相返的操作是dec())
    if dm.AQY492TTYPE.Value=3 then //返修投产,增加56在线作业单
      with dm.ADOQuery2 do  //
       begin
        close;
        sql.Text:='SELECT  WO_PTR, DEPT_PTR, STEP, QTY_BACKLOG, PANELS, INTIME, '+
                  'TDATE,LOC_PTR FROM  Data0056 where rkey is null';
        open;
        dm.ADOQuery2.AppendRecord([dm.AQY06rkey.Value,
                                   self.deptptr,
                                   self.begin_step,
                                   dm.AQY06QUAN_SCH.Value,
                                   0,                        //返修投产在线PANEL为零
                                   dm.AQY06ENT_DATETIME.Value,
                                   dm.AQY06ENT_DATETIME.Value,
                                   dm.AQY06WHOUSE_PTR.Value]);
       end;

   end; //end for i_j

end; //end for i
 self.update_04(trim(dm.aqy04SEED_VALUE.Value));
 self.ModalResult:=mrok;
except
 on E: Exception do
  begin
   dm.ADOConnection1.RollbackTrans;
   messagedlg(E.Message,mterror,[mbcancel],0);
  end;
end;

end;


procedure TForm_putprod.PopupMenu3Popup(Sender: TObject);
begin
if (stg3.Cells[10,stg3.Row] = stg3.Cells[10,stg3.Row-1]) and  //产品与工单PNL(A或者B)一致
   (stg3.Cells[11,stg3.Row] = stg3.Cells[11,stg3.Row-1]) then
 n6.Enabled:=true
else
 n6.Enabled:=false;
end;

function TForm_putprod.returen_pnlnumber(rkey25, pnlab: string): integer;
var
 i,pnlnumber:integer;
begin
pnlnumber:=0;
for i:=1 to stg3.RowCount-2 do
 if (stg3.Cells[10,i]=rkey25) and
    (stg3.Cells[11,i]=pnlab)   then
   inc(pnlnumber);
 result:=pnlnumber;
end;

function TForm_putprod.isnum(str:string):boolean;
var 
  i:integer;
begin
  for i:=1 to length(str) do
   if not (str[i] in ['0'..'9']) then
    begin
      result:=false;
      exit;
    end;
  result:=true;
end;

procedure TForm_putprod.N6Click(Sender: TObject);
var
 i:integer;
 pnl_number:integer;
 oldstr,newstr:string;
begin
 if (combobox1.ItemIndex=4) and
    (edit1.Text='未超投') then  //合并投产
 begin
   ShowMsg('合并投产，不允许做合并作业单操作',1);
   Exit;
 end;

 stg3.cells[3,stg3.Row-1]:= inttostr(strtoint(stg3.cells[3,stg3.Row-1]) +
                            strtoint(stg3.cells[3,stg3.Row]));     //'计划数量';

 stg3.cells[4,stg3.Row-1]:= inttostr(strtoint(stg3.cells[4,stg3.Row-1])+
                            strtoint(stg3.cells[4,stg3.Row]));    //'PNL数';

 pnl_number:=self.returen_pnlnumber(stg3.Cells[10,stg3.Row],stg3.Cells[11,stg3.Row]);
 oldstr:='-'+inttostr(pnl_number)+'-';
 newstr:='-'+inttostr(pnl_number-1)+'-';

for i:=1 to stg3.RowCount-2 do
 if (stg3.Cells[10,i]=stg3.Cells[10,stg3.Row]) and
    (stg3.Cells[11,i]=stg3.Cells[11,stg3.Row])   then
  begin
     //取消作业单'-'号前面的字符，加'-'号后面字符，其中后字符需要替换（总作业单减１替换原字符）
   stg3.Cells[2,i]:=Copy(stg3.Cells[2,i],1,Pos('-',stg3.Cells[2,stg3.row])+1)+
   StringReplace(Copy(stg3.Cells[2,i],Pos('-',stg3.Cells[2,stg3.row])+2,
                      Length(stg3.Cells[2,i])-Pos('-',stg3.Cells[2,stg3.row])-1
                      ),
   oldstr,newstr,[rfIgnoreCase]);

   if i > stg3.Row then
    begin
     if isnum(copy(stg3.Cells[2,i],length(stg3.Cells[2,i])-2,3)) then       //最后三位是数字
      stg3.Cells[2,i]:=copy(stg3.Cells[2,i],1,length(stg3.Cells[2,i])-3)+
                             copy(inttostr(1000+
                             strtoint(copy(stg3.Cells[2,i],length(stg3.Cells[2,i])-2,3)
                                      )-1),
                                  2,3)
     else
      if isnum(copy(stg3.Cells[2,i],length(stg3.Cells[2,i])-1,2)) then       //最后两位是数字
       stg3.Cells[2,i]:=copy(stg3.Cells[2,i],1,length(stg3.Cells[2,i])-2)+
                             copy(inttostr(100+
                             strtoint(copy(stg3.Cells[2,i],length(stg3.Cells[2,i])-1,2)
                                      )-1),
                                  2,2)
      else
       if isnum(copy(stg3.Cells[2,i],length(stg3.Cells[2,i]),1)) then       //最后一位是数字
        stg3.Cells[2,i]:=copy(stg3.Cells[2,i],1,length(stg3.Cells[2,i])-1)+
                               copy(inttostr(10+
                               strtoint(copy(stg3.Cells[2,i],length(stg3.Cells[2,i]),1)
                                        )-1),
                                    2,1);
    end;
  end;

 for i:=stg3.Row to stg3.RowCount-2 do
  stg3.Rows[i].Text:=stg3.Rows[i+1].Text;
 stg3.RowCount:=stg3.RowCount-1;

end;

end.
