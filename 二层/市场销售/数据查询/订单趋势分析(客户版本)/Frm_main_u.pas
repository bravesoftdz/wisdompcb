unit Frm_main_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, DB, ADODB, ComCtrls, ExtCtrls, Grids, StdCtrls, Buttons,
  dateutils;

type
  TFrm_main = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    GroupBox6: TGroupBox;
    Label8: TLabel;
    ComboBox1: TComboBox;
    Edit3: TEdit;
    Button3: TButton;
    BitBtn6: TBitBtn;
    ListBox3: TListBox;
    StaticText7: TStaticText;
    SGrid1: TStringGrid;
    StaticText2: TStaticText;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    RadioGroup1: TRadioGroup;
    dtpk1: TDateTimePicker;
    dtpk2: TDateTimePicker;
    ADOConnection1: TADOConnection;
    tmp: TADOQuery;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    dtt1: TDateTimePicker;
    dtt2: TDateTimePicker;
    GroupBox1: TGroupBox;
    RadioButton1: TRadioButton;
    RadioButton3: TRadioButton;
    RadioButton2: TRadioButton;
    RadioButton4: TRadioButton;
    GroupBox2: TGroupBox;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    procedure BitBtn3Click(Sender: TObject);
    procedure ListBox3Click(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Edit3KeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
//    wh_ptr:integer;
   procedure update_sgrid(sgrid_row: byte);    
  public
    { Public declarations }
  end;

var
  Frm_main: TFrm_main;

implementation

uses common,Frm_detail_u,Pick_Item_Single,ConstVar;

{$R *.dfm}

procedure TFrm_main.FormCreate(Sender: TObject);
begin
  if not app_init_2(ADOConnection1) then
  begin
    showmsg('程序启动失败,请与管理员联系!',1);
    application.Terminate;
  end;
  caption:=application.Title;

  DateSeparator := '-';
  ShortDateFormat := 'yyyy-mm-dd';

//  user_ptr:='4';
//  vprev:='4';
//  ADOConnection1.Open;

  sgrid1.Cells[0,0]:='条件名';
  sgrid1.Cells[1,0]:='条件值';
  dtpk2.Date:=getsystem_date(tmp,1);
  dtpk1.Date:=dtpk2.Date-dayof(dtpk2.Date)+1;
  ListBox3.ItemIndex:=0;
end;

procedure TFrm_main.BitBtn3Click(Sender: TObject);
begin
  close;
end;

procedure TFrm_main.ListBox3Click(Sender: TObject);
var TmpAdo:TADOQuery;
begin
  label8.Caption:=listbox3.Items[listbox3.itemindex];
  edit3.Text:='';
  edit3.Visible:=listbox3.ItemIndex in [0..7,11];
  button3.Enabled:=listbox3.ItemIndex in [8..10,12,13];
  combobox1.Visible:=listbox3.ItemIndex in [8..9,12,13];
  bitbtn6.Visible:=listbox3.ItemIndex in [0..3,5..7,11];
  RadioButton1.Checked:=true;
  RadioButton4.Visible:=listbox3.ItemIndex<>4;
  GroupBox1.Visible:=edit3.Visible;
  groupbox2.Visible :=listbox3.ItemIndex=10;

  case listbox3.ItemIndex of
   8:
   begin
    combobox1.Items.Clear;
    ComboBox1.Style:=csOwnerDrawFixed;
    combobox1.Items.Add('量产');
    combobox1.Items.Add('样板');
    combobox1.ItemIndex:=0;
   end;
   9:
   begin
    combobox1.Items.Clear;
    ComboBox1.Style:=csOwnerDrawFixed;
    combobox1.Items.Add('自制');
    combobox1.Items.Add('外发');
    combobox1.Items.Add('半制程');
    combobox1.ItemIndex:=0;
   end;
  12:
  begin
    try
      TmpAdo:=TADOQuery.Create(Application);
      TmpAdo.Connection:=ADOConnection1;
      try
        ComboBox1.Items.Clear;
        ComboBox1.Style:=csDropDown;
        TmpAdo.Close;
        TmpAdo.SQL.Text:='select data0338.tvalue from data0278 inner join data0338 on data0278.Rkey=data0338.parameter_ptr where  data0278.SPEC_RKEY=''js''';
        TmpAdo.Open;
        while not TmpAdo.Eof do
        begin
          ComboBox1.Items.Add(TmpAdo.FieldBYName('tvalue').AsString);
          TmpAdo.Next;
        end;
        ComboBox1.ItemIndex:=-1;
      except
        tmpAdo.Close;
        tmpAdo.Connection := nil;
        tmpAdo.Free;
        tmpAdo := nil;
      end;
    finally
      tmpAdo.Close;
      tmpAdo.Connection:=nil;
      tmpAdo.Free;
    end;
  end;
  13:
  begin
    combobox1.Items.Clear;
    ComboBox1.Style:=csOwnerDrawFixed;
    combobox1.Items.Add('正式订单');
    combobox1.Items.Add('备品订单');
    combobox1.ItemIndex:=0;
  end;
  end;
end;

procedure TFrm_main.Edit3Change(Sender: TObject);
begin
  button3.Enabled:=trim(edit3.Text)<>'' ;
end;

procedure TFrm_main.Edit3KeyPress(Sender: TObject; var Key: Char);
begin
 if listbox3.ItemIndex=4 then
   if not (key in ['0'..'9',#8,#13]) then  //判断是否输入数字
    abort;
 if (key=#13) and (button3.Enabled=true) then
   button3.SetFocus;
end;

procedure TFrm_main.N1Click(Sender: TObject);
var i:byte;
begin
  for i:=sgrid1.Row to sgrid1.RowCount-2 do sgrid1.Rows[i].Text:=sgrid1.Rows[i+1].Text;
  sgrid1.RowCount:=sgrid1.RowCount-1;
end;

procedure TFrm_main.BitBtn2Click(Sender: TObject);
var i:byte;
begin
  for i:=1 to sgrid1.RowCount-2 do sgrid1.Rows[i].Clear;
  sgrid1.RowCount:=2;
end;

procedure TFrm_main.update_sgrid(sgrid_row: byte);
var
  s,s1:string;
  procedure Con(s:string);
  begin
    if RadioButton1.Checked then
    begin
     sgrid1.Cells[1,sgrid_row]:=RadioButton1.Caption+edit3.Text;
     sgrid1.Cells[2,sgrid_row]:=s+' = '''+edit3.Text+''' ';
    end else if RadioButton2.Checked then
    begin
     sgrid1.Cells[1,sgrid_row]:=RadioButton2.Caption+edit3.Text;
     sgrid1.Cells[2,sgrid_row]:=s+' <> '''+edit3.Text+''' ';
    end else if RadioButton3.Checked then
    begin
     sgrid1.Cells[1,sgrid_row]:=RadioButton3.Caption+edit3.Text;
     sgrid1.Cells[2,sgrid_row]:=s+' > '''+edit3.Text+''' ';
    end else if RadioButton4.Checked then
    begin
     sgrid1.Cells[1,sgrid_row]:=RadioButton4.Caption+edit3.Text;
     sgrid1.Cells[2,sgrid_row]:=s+' like ''%'+edit3.Text+'%'' ';
    end ;
  end;

begin
  sgrid1.Cells[0,sgrid_row]:=listbox3.Items[listbox3.itemindex];
  if (listbox3.itemindex=8) or (listbox3.itemindex=9) then
 //   sgrid1.Cells[1,sgrid_row]:=edit3.Text
//  else
    sgrid1.Cells[1,sgrid_row]:=combobox1.Text;
   
  case listbox3.ItemIndex of
   0:Con('and data0025.manu_part_number');
   1:Con('and data0025.manu_part_desc');

   2:Con('and data0010.cust_code');
   3:Con('and data0008.prod_code');
   4:Con('and data0025.layers');

   5:Con('and data0015.warehouse_code');
   6:Con('and data0007.pr_grp_code');
   7:Con('and data0005.EMPL_CODE');

   8:sgrid1.Cells[2,sgrid_row]:='and data0025.ttype = '+inttostr(ComboBox1.ItemIndex);
   9:sgrid1.Cells[2,sgrid_row]:='and data0060.so_tp = '+inttostr(ComboBox1.ItemIndex);

   10:
   begin
          s1:= '';
          s := '';
          if CheckBox1.Checked then
            begin
              s1 := s1 + CheckBox1.Caption  + ';' ;
              if s = '' then
               s := '1'
              else
               s := s + ',1';
            end;
          if CheckBox2.Checked then
            begin
              s1 := s1 + CheckBox2.Caption + ';'  ;
              if s = '' then
                  s := '2'
              else
                  s := s + ',2';
            end;
          if CheckBox3.Checked then
           begin
            s1 := s1 + CheckBox3.Caption  + ';' ;
            if s = '' then
                s := '3'
            else
                s := s + ',3';
           end;
          if CheckBox4.Checked then
            begin
              s1 := s1 + CheckBox4.Caption + ';'  ;
              if s = '' then
                  s := '4'
              else
                  s := s + ',4';
            end;
          if CheckBox5.Checked then
            begin
              s1 := s1 + CheckBox5.Caption + ';'  ;
              if s = '' then
                  s := '5'
              else
                  s := s + ',5';
            end;
          if CheckBox6.Checked then
            begin
              s1 := s1 + CheckBox6.Caption + ';'  ;
              if s = '' then
                  s := '6'
              else
                  s := s + ',6';
            end;
            {}
          s := '('+s+')';
          sgrid1.Cells[1,sgrid_row] := s1;
          sgrid1.Cells[2,sgrid_row]:=' and data0060.STATUS in ' + s;
   end;
   11:Con('and data0025.ORIG_CUSTOMER');
   12:
   begin
     if (Trim(combobox1.Text)='') then
     begin
       sgrid1.Cells[2,sgrid_row]:=' and 1=1';
       sgrid1.Cells[1,sgrid_row]:=combobox1.Text;
     end else
     begin
       sgrid1.Cells[2,sgrid_row]:=' and data0025.CPJS like ''%'+combobox1.Text+'%''';
       sgrid1.Cells[1,sgrid_row]:=combobox1.Text;
     end;
   end;
   13:
   begin
     sgrid1.Cells[2,sgrid_row]:='and data0060.so_style = '+inttostr(ComboBox1.ItemIndex);
     sgrid1.Cells[1,sgrid_row]:=combobox1.Text;
   end;
  end;
end;

procedure TFrm_main.Button3Click(Sender: TObject);
var i:byte;
begin
  for i:=1 to sgrid1.RowCount-2 do
  if sgrid1.Cells[0,i]=listbox3.Items[listbox3.itemindex]  then
  begin
    self.update_sgrid(i);
    exit;
  end;
 self.update_sgrid(sgrid1.RowCount-1);
 sgrid1.RowCount:=sgrid1.RowCount+1;
end;

procedure TFrm_main.BitBtn6Click(Sender: TObject);
var InputVar: PDlgInput ;
begin
 frmPick_Item_Single:=TfrmPick_Item_Single.Create(nil);
 try
  case self.ListBox3.ItemIndex of
    0:
    begin
      InputVar.Fields := 'MANU_PART_NUMBER/本厂编号/89,MANU_PART_DESC/客户型号/149,'+
                         'ANALYSIS_CODE_2/客户物料号/116,CUST_CODE/客户代码/74,ABBR_NAME/客户简称/84';
      InputVar.Sqlstr :='SELECT dbo.Data0025.PROD_CODE_PTR, dbo.Data0008.PROD_CODE,'+#13+
                        'dbo.Data0008.PRODUCT_NAME, dbo.Data0010.CUST_CODE,'+#13+
                        'dbo.Data0010.ABBR_NAME, dbo.Data0025.RKEY AS rkey25,'+#13+
                        'dbo.Data0025.MANU_PART_NUMBER, dbo.Data0025.MANU_PART_DESC,'+#13+
                        'dbo.Data0025.ANALYSIS_CODE_2, dbo.Data0025.set_lngth, dbo.Data0025.set_width,'+#13+
                        'dbo.Data0025.set_qty'+#13+
                        'FROM dbo.Data0025 INNER JOIN dbo.Data0008 '+
                        'ON dbo.Data0025.PROD_CODE_PTR = dbo.Data0008.RKEY INNER JOIN dbo.Data0010 '+
                        'ON dbo.Data0025.CUSTOMER_PTR = dbo.Data0010.RKEY'+#13+
                        'order by dbo.Data0025.MANU_PART_NUMBER';
      inputvar.KeyField:='MANU_PART_NUMBER';
    end;
    1:
    begin
      InputVar.Fields := 'MANU_PART_DESC/客户型号/149,'+
                         'ANALYSIS_CODE_2/客户物料号/116,CUST_CODE/客户代码/74,ABBR_NAME/客户简称/84';
      InputVar.Sqlstr :='SELECT dbo.Data0025.PROD_CODE_PTR, dbo.Data0008.PROD_CODE,'+#13+
                        'dbo.Data0008.PRODUCT_NAME, dbo.Data0010.CUST_CODE,'+#13+
                        'dbo.Data0010.ABBR_NAME, dbo.Data0025.RKEY AS rkey25,'+#13+
                        'dbo.Data0025.MANU_PART_NUMBER, dbo.Data0025.MANU_PART_DESC,'+#13+
                        'dbo.Data0025.ANALYSIS_CODE_2, dbo.Data0025.set_lngth, dbo.Data0025.set_width,'+#13+
                        'dbo.Data0025.set_qty'+#13+
                        'FROM dbo.Data0025 INNER JOIN dbo.Data0008 '+
                        'ON dbo.Data0025.PROD_CODE_PTR = dbo.Data0008.RKEY INNER JOIN dbo.Data0010 '+
                        'ON dbo.Data0025.CUSTOMER_PTR = dbo.Data0010.RKEY'+#13+
                        'order by dbo.Data0025.MANU_PART_NUMBER';
      inputvar.KeyField:='MANU_PART_DESC';
    end;
    2:
    begin
      InputVar.Fields:='CUST_CODE/客户代码/110,CUSTOMER_NAME/客户名称/251,abbr_name/简称/125';
      InputVar.Sqlstr:='SELECT dbo.Data0010.CUST_CODE, dbo.Data0010.CUSTOMER_NAME,'+
                       'data0010.abbr_name FROM dbo.Data0010 order  by cust_code';
      inputvar.KeyField:='CUST_CODE';
    end;
    3:
    begin
      InputVar.Fields := 'PROD_CODE/产品类型/110,PRODUCT_NAME/类型名称/285';
      InputVar.Sqlstr :='SELECT RKEY, PROD_CODE, PRODUCT_NAME'+#13+
                        'FROM dbo.Data0008 order by PROD_CODE ';
      inputvar.KeyField:='PROD_CODE';
    end;
    5:
    begin
      InputVar.Fields:='WAREHOUSE_CODE/工厂代码/110,WAREHOUSE_NAME/工厂名称/251,abbr_name/简称/125';
      InputVar.Sqlstr:='SELECT rkey,warehouse_code,warehouse_name,abbr_name '+
                       'from data0015 order  by warehouse_code';
      inputvar.KeyField:='warehouse_code';
    end;
    6:
    begin
      InputVar.Fields:='pr_grp_code/组别代码/110,product_group_name/组别名称/251';
      InputVar.Sqlstr:='select pr_grp_code,product_group_name  from data0007 order by pr_grp_code';
      inputvar.KeyField:='pr_grp_code';
    end;
    7:
    begin
      InputVar.Fields:='EMPL_CODE/业务员代码/110,abbr_name/业务员名称/251';
      InputVar.Sqlstr:='select EMPL_CODE,abbr_name from data0005 order by EMPL_CODE';
      inputvar.KeyField:='EMPL_CODE';
    end;
    11:
    begin
      InputVar.Fields:='CUST_CODE/客户代码/110,CUSTOMER_NAME/客户名称/251,abbr_name/简称/125';
      InputVar.Sqlstr:='SELECT dbo.Data0010.CUST_CODE, dbo.Data0010.CUSTOMER_NAME,'+
                       'data0010.abbr_name FROM dbo.Data0010 order  by abbr_name';
      inputvar.KeyField:='abbr_name';
    end;

  end;

  inputvar.InPut_value:=edit3.Text;
  InputVar.AdoConn := ADOConnection1 ;
  frmPick_Item_Single.InitForm_New(InputVar);
  if frmPick_Item_Single.ShowModal=mrok then
  begin
    case self.ListBox3.ItemIndex of
     0:edit3.Text:=trim(frmPick_Item_Single.adsPick.FieldValues['MANU_PART_NUMBER']);
     1:edit3.Text:=trim(frmPick_Item_Single.adsPick.FieldValues['MANU_PART_DESC']);
     2:edit3.Text:=trim(frmPick_Item_Single.adsPick.FieldValues['CUST_CODE']);
     3:edit3.Text:=trim(frmPick_Item_Single.adsPick.FieldValues['PROD_CODE']);

     5:edit3.Text:=trim(frmPick_Item_Single.adsPick.FieldValues['warehouse_code']);
     6:edit3.Text:=trim(frmPick_Item_Single.adsPick.FieldValues['pr_grp_code']);
     7:edit3.Text:=trim(frmPick_Item_Single.adsPick.FieldValues['EMPL_CODE']);
    11:edit3.Text:=trim(frmPick_Item_Single.adsPick.FieldValues['abbr_name']);
    end;
    button3.SetFocus;
  end else edit3.SetFocus;
 finally
   frmPick_Item_Single.Free ;
 end;
 
end;

procedure TFrm_main.BitBtn1Click(Sender: TObject);
var i:integer;
    select,where,group,order:string;
begin
 try
  screen.Cursor:=crappstart;
  case radiogroup1.ItemIndex of
   0:
    begin
     select:='Select convert(varchar,data0060.ENT_DATE,23) D, null as name,';
     group:='GROUP BY CONVERT(varchar,data0060.ENT_DATE,23) ';
     order:='ORDER BY CONVERT(varchar,data0060.ENT_DATE,23)';
    end;
   1:
    begin
     select:='SELECT datepart(yy,data0060.ENT_DATE)*100+datepart(mm,data0060.ENT_DATE) M,null as name,';
     group:='GROUP BY datepart(yy,data0060.ENT_DATE)*100+datepart(mm,data0060.ENT_DATE) ';
     order:='ORDER BY datepart(yy,data0060.ENT_DATE)*100+datepart(mm,data0060.ENT_DATE)';
    end;
   2:
    begin
     select:='SELECT data0007.pr_grp_code, data0007.product_group_name as name,';
     group:='GROUP BY data0007.pr_grp_code, data0007.product_group_name ';
     order:='ORDER BY data0007.pr_grp_code ';
    end;
   3:
    begin
     select:='SELECT data0005.EMPL_CODE,data0005.EMPLOYEE_NAME as name,';
     group:='GROUP BY data0005.EMPL_CODE,data0005.EMPLOYEE_NAME ';
     order:='ORDER BY data0005.EMPL_CODE ';
    end;
   4:
    begin
     select:='SELECT Data0008.PROD_CODE as code,Data0008.PRODUCT_NAME as name,';
     group:='GROUP BY Data0008.PROD_CODE,Data0008.PRODUCT_NAME ';
     order:='ORDER BY Data0008.PROD_CODE ';
    end;
   5:
    begin
     select:='SELECT  Data0010.CUST_CODE as code,Data0010.ABBR_NAME as name,';
     group:='GROUP BY Data0010.CUST_CODE,Data0010.ABBR_NAME ';
     order:='ORDER BY Data0010.CUST_CODE ';
    end;
   6:
    begin
     select:='SELECT Data0025.MANU_PART_NUMBER as code,Data0025.MANU_PART_DESC as name,';
     group:='GROUP BY Data0025.MANU_PART_NUMBER,Data0025.MANU_PART_DESC,data0025.ORIG_CUSTOMER ';
     order:='ORDER BY Data0025.MANU_PART_NUMBER ';
    end;
  end;
  if RadioGroup1.ItemIndex<6 then     //当用户按产品汇总时，增加了字段关联原客户
   select:=select+'sum(data0060.PARTS_ORDERED) Qty,sum(data0060.PARTS_ORDERED*data0025.unit_sq) Area,'+
        'round(sum((data0060.PARTS_ORDERED*data0060.parts_alloc+data0060.TOTAL_ADD_L_PRICE/(1+RUSH_CHARGE*0.01))/data0060.exch_rate),2) NotaxMount,'+
        'round(sum((data0060.PARTS_ORDERED*data0060.parts_alloc*(1+RUSH_CHARGE*0.01)+data0060.TOTAL_ADD_L_PRICE)/data0060.exch_rate),2) taxMount'+#13+
        'FROM dbo.Data0060 INNER JOIN '+#13+
        '     dbo.Data0025 ON dbo.Data0060.CUST_PART_PTR = dbo.Data0025.RKEY INNER JOIN '+#13+
        '     dbo.Data0010 ON dbo.Data0060.CUSTOMER_PTR = dbo.Data0010.RKEY INNER JOIN '+#13+
        '     dbo.Data0008 ON dbo.Data0025.PROD_CODE_PTR = dbo.Data0008.RKEY INNER JOIN '+#13+
        '     dbo.Data0005 ON dbo.Data0060.COMM_ASSIGNED_BY_E_P = dbo.Data0005.RKEY INNER JOIN '+#13+
        '     dbo.Data0015 ON dbo.Data0060.SHIP_REG_TAX_ID = dbo.Data0015.RKEY inner join '+
        'data0007 on data0008.PR_GRP_POINTER=data0007.rkey '
  else
   select:=select+'sum(data0060.PARTS_ORDERED) Qty,sum(data0060.PARTS_ORDERED*data0025.unit_sq) Area,'+
        'round(sum((data0060.PARTS_ORDERED*data0060.parts_alloc+data0060.TOTAL_ADD_L_PRICE/(1+RUSH_CHARGE*0.01))/data0060.exch_rate),2) NotaxMount,'+
        'round(sum((data0060.PARTS_ORDERED*data0060.parts_alloc*(1+RUSH_CHARGE*0.01)+data0060.TOTAL_ADD_L_PRICE)/data0060.exch_rate),2) taxMount,'+
        'data0025.ORIG_CUSTOMER'+#13+
        'FROM dbo.Data0060 INNER JOIN '+#13+
        '     dbo.Data0025 ON dbo.Data0060.CUST_PART_PTR = dbo.Data0025.RKEY INNER JOIN '+#13+
        '     dbo.Data0010 ON dbo.Data0060.CUSTOMER_PTR = dbo.Data0010.RKEY INNER JOIN '+#13+
        '     dbo.Data0008 ON dbo.Data0025.PROD_CODE_PTR = dbo.Data0008.RKEY INNER JOIN '+#13+
        '     dbo.Data0005 ON dbo.Data0060.COMM_ASSIGNED_BY_E_P = dbo.Data0005.RKEY INNER JOIN '+#13+
        '     dbo.Data0015 ON dbo.Data0060.SHIP_REG_TAX_ID = dbo.Data0015.RKEY inner join '+
        'data0007 on data0008.PR_GRP_POINTER=data0007.rkey ';

  where:='WHERE 1=1 ';
  for i:=1 to sgrid1.RowCount-2 do  where:=where+sgrid1.Cells[2,i]+' ';

  where:=where+' and data0060.ENT_DATE >='+''''+(formatdatetime('yyyy-mm-dd ',dtpk1.Date)+
         formatdatetime('hh:nn:ss',dtt1.DateTime))+''''+
         ' and data0060.ENT_DATE <='+''''+(formatdatetime('yyyy-mm-dd ',dtpk2.Date)+
         formatdatetime('hh:nn:ss',dtt2.DateTime))+'''';
  if (vprev='1') or (vprev='3') then
    where:=where+' and data0010.rkey in (SELECT  CUSTOMER_PTR '+ #13 +
                 ' FROM dbo.DATA0100 '+ #13 +
                 ' WHERE  CSI_PTR = '+rkey73+' )';

  Frm_detail:=TFrm_detail.Create(nil);
  Frm_detail.ttype:=RadioGroup1.ItemIndex;
  Frm_detail.ttype_name:=radiogroup1.Items[radiogroup1.itemindex];

  if (vprev='1') or (vprev='2') then
   begin
     Frm_detail.Eh1.Columns[4].Visible:=false;
     Frm_detail.Eh1.Columns[5].Visible:=false;
     Frm_detail.ComboBox2.Items.Clear;
     Frm_detail.ComboBox2.Items.Add('数量');
     Frm_detail.ComboBox2.Items.Add('面积');
     Frm_detail.ComboBox2.ItemIndex:=0;
   end;

  with Frm_detail.ADOQuery1 do
  begin
    close;
    sql.text:=select+where+' '+#13+group+' '+#13+order;
    open;
  end;
  Frm_detail.ShowModal;
 finally
  Frm_detail.Free;
  screen.Cursor:=crdefault;
 end;
end;

end.
