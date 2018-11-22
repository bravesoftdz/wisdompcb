unit condition;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, DB, ADODB, ComCtrls, ExtCtrls, Grids, StdCtrls, Buttons,
  dateutils;

type
  TForm_condition = class(TForm)
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
    dtpk1: TDateTimePicker;
    dtpk2: TDateTimePicker;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    dtt1: TDateTimePicker;
    dtt2: TDateTimePicker;
    RadioGroup3: TRadioGroup;
    procedure ListBox3Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure SGrid1Click(Sender: TObject);
    procedure SGrid1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure N1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure Edit3KeyPress(Sender: TObject; var Key: Char);
    procedure Edit3Exit(Sender: TObject);
  private
    { Private declarations }
    wh_ptr:integer;
   procedure update_sgrid(sgrid_row: byte);    
  public
    { Public declarations }
  end;

var
  Form_condition: TForm_condition;

implementation

uses common,Pick_Item_Single ,ConstVar, main;

{$R *.dfm}

procedure TForm_condition.ListBox3Click(Sender: TObject);
var TmpAdo:TADOQuery;
begin
label8.Caption:=listbox3.Items[listbox3.itemindex];
edit3.Text:='';
edit3.Visible:=true;
button3.Enabled:=false;
bitbtn6.Visible:=false;
combobox1.Visible:=false;
radiogroup3.Visible:=false;

case listbox3.ItemIndex of
 0:bitbtn6.Visible:=true;
 1:
 begin
  edit3.Visible:=false;
  combobox1.Visible := true;
  button3.Enabled := true;
  combobox1.Items.Clear;
  combobox1.Items.Add('��������');
  combobox1.Items.Add('��Ӧ�̱���');
  combobox1.Items.Add('�ͻ�����');
  combobox1.Items.Add('�г�����');
  combobox1.Items.Add('����');
  combobox1.ItemIndex:=0;
 end;
 2:bitbtn6.Visible:=true;
 3:bitbtn6.Visible:=true;
 4:bitbtn6.Visible:=true;
 5:bitbtn6.Visible:=true;
 6:;
 7:
 begin
  edit3.Visible:=false;
  combobox1.Visible:=true;
  button3.Enabled:=true;
  combobox1.Items.Clear;
  combobox1.Items.Add('����');
  combobox1.Items.Add('����');
  combobox1.ItemIndex:=0;
 end;
 8:
 begin
  edit3.Visible:=false;
  combobox1.Visible:=true;
  button3.Enabled:=true;
  combobox1.Items.Clear;
  combobox1.Items.Add('�ڲ�');
  combobox1.Items.Add('���');
  combobox1.ItemIndex:=0;
 end;
 9:radiogroup3.Visible:=true;
 10:;
 11:;
 12:
 begin
    edit3.Visible:=false;
    combobox1.Visible:=true;
    button3.Enabled:=true;
    combobox1.Items.Clear;
    combobox1.Items.Add('��������');
    combobox1.Items.Add('�̵㱨��');
    combobox1.ItemIndex:=0;
 end;
 13:bitbtn6.Visible:=true;
 14,15,16:;

 17:
   begin
    try
      edit3.Visible:=false;
      button3.Enabled:=True;
      combobox1.Visible:=True;
      TmpAdo:=TADOQuery.Create(Application);
      TmpAdo.Connection:=Form1.ADOConnection1;
      try
        combobox1.Items.Clear;
        combobox1.Style:=csDropDown;
        TmpAdo.Close;
        TmpAdo.SQL.Text:='select data0338.tvalue from data0278 inner join data0338 on data0278.Rkey=data0338.parameter_ptr where  data0278.SPEC_RKEY=''js''';
        TmpAdo.Open;
        while not TmpAdo.Eof do
        begin
          combobox1.Items.Add(TmpAdo.FieldBYName('tvalue').AsString);
          TmpAdo.Next;
        end;
        combobox1.ItemIndex:=-1;
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
 end;
end;

procedure TForm_condition.FormActivate(Sender: TObject);
begin
  sgrid1.Cells[0,0]:='������';
  sgrid1.Cells[1,0]:='����ֵ';
  listbox3.Selected[0]:=true;
  self.ListBox3.OnClick(sender);
end;

procedure TForm_condition.Edit3Change(Sender: TObject);
begin
  if trim(edit3.Text)<>'' then
    button3.Enabled:=true
  else button3.Enabled:=false;
end;

procedure TForm_condition.Edit3KeyPress(Sender: TObject; var Key: Char);
begin
 if listbox3.ItemIndex=9 then
   if not (key in ['0'..'9',#8,#13]) then  //�ж��Ƿ���������
     abort;
 if (key=#13) and (button3.Enabled=true) then
   button3.SetFocus;
end;

procedure TForm_condition.Edit3Exit(Sender: TObject);
begin
  if (trim(edit3.Text)<>'') and (listbox3.ItemIndex in [0,2,3,4,13]) then
  with Form1.ADOQuery1 do
  begin
    Close;
    case listbox3.ItemIndex of
      0:sql.Text:='select rej_code from data0039 where rej_code='''+trim(edit3.text)+'''';
      2:sql.Text:='select dept_code from data0034 where (ttype<>''2'') and (ttype<>''3'') '+
                  'and dept_code='''+trim(edit3.text)+'''';
      3:sql.Text:='select cust_code from data0010 where cust_code='''+trim(edit3.text)+'''';
      4:sql.Text:='select prod_code from data0008 where prod_code='''+trim(edit3.text)+'''';
      13:sql.Text:='select rkey,warehouse_code from data0015 where warehouse_code='''+trim(edit3.text)+'''';
    end;
    open;
    if isempty then
    begin
      case listbox3.ItemIndex of
        0:showmessage('�������ȱ�ݴ��벻���ڣ������䣡');
        2:showmessage('������Ĳ��Ŵ��벻���ڣ������䣡');
        3:showmessage('������Ŀͻ����벻���ڣ������䣡');
        4:showmessage('������Ĳ�Ʒ���Ͳ����ڣ������䣡');
        13:showmessage('������Ĺ������벻���ڣ������䣡');
      end; //case����
      edit3.Text:='';
      edit3.SetFocus;
    end
    else if listbox3.ItemIndex=13 then
      wh_ptr:=fieldvalues['rkey'];
  end;
end;

procedure TForm_condition.SGrid1Click(Sender: TObject);
begin
  if button3.Enabled then
    button3click(sender);
end;

procedure TForm_condition.SGrid1MouseDown(Sender:TObject;Button:TMouseButton;Shift:TShiftState; X, Y: Integer);
var column,row:longint;//�Ҽ�ѡ��stringgrid�ؼ��ķ���
begin
  if button=mbright then
  begin
    SGrid1.MouseToCell(x,y,column,row);
    if row<>0 then SGrid1.Row:=row;
  end
  else if button3.Enabled then
    button3.OnClick(sender);
end;

procedure TForm_condition.N1Click(Sender: TObject);
var i:byte;
begin
  for i:=sgrid1.Row to sgrid1.RowCount-2 do
    sgrid1.Rows[i].Text:=sgrid1.Rows[i+1].Text;
  sgrid1.RowCount:=sgrid1.RowCount-1;
end;

procedure TForm_condition.BitBtn2Click(Sender: TObject);
var i:byte;
begin
  for i:=1 to sgrid1.RowCount-2 do
    sgrid1.Rows[i].Clear;
  sgrid1.RowCount:=2;
end;

procedure TForm_condition.update_sgrid(sgrid_row: byte);
begin
 sgrid1.Cells[0,sgrid_row]:=listbox3.Items[listbox3.itemindex];
 sgrid1.Cells[1,sgrid_row]:=trim(edit3.Text);
 case listbox3.ItemIndex of
 0:sgrid1.Cells[2,sgrid_row]:='and Data0039.REJ_CODE = '''+edit3.Text+'''';
 1:
  begin
  sgrid1.Cells[2,sgrid_row]:='and data0039.REJ_TYPE = '+inttostr(combobox1.ItemIndex);
  sgrid1.Cells[1,sgrid_row]:=combobox1.Text;
  end;
 2:sgrid1.Cells[2,sgrid_row]:='and Data0034.dept_code = '''+edit3.Text+'''';
 3:sgrid1.Cells[2,sgrid_row]:='and Data0010.CUST_CODE = '''+edit3.Text+'''';
 4: sgrid1.Cells[2,sgrid_row]:='and data0008.prod_code = '''+edit3.Text+'''';
 5:sgrid1.Cells[2,sgrid_row]:='and data0025.manu_part_number like ''%'+edit3.Text+'%''';
 6:sgrid1.Cells[2,sgrid_row]:='and data0025.manu_part_desc like ''%'+edit3.Text+'%''';
 7:
  begin
   sgrid1.Cells[2,sgrid_row]:='and Data0025.ttype = '+inttostr(combobox1.ItemIndex);
   sgrid1.Cells[1,sgrid_row]:=combobox1.Text;
  end;
 8:
  begin
   if combobox1.ItemIndex=0 then
     sgrid1.Cells[2,sgrid_row]:='and data0025.PARENT_PTR  > 0 '
   else
     sgrid1.Cells[2,sgrid_row]:='and data0025.PARENT_PTR  IS NULL ';
   sgrid1.Cells[1,sgrid_row]:=combobox1.Text;
  end;
 9:
 begin
  sgrid1.Cells[1,sgrid_row]:=radiogroup3.Items[radiogroup3.itemindex]+edit3.Text;
  case radiogroup3.ItemIndex of
   0:sgrid1.Cells[2,sgrid_row]:='and data0025.layers = '+edit3.Text;
   1:sgrid1.Cells[2,sgrid_row]:='and data0025.layers > '+edit3.Text;
   2:sgrid1.Cells[2,sgrid_row]:='and data0025.layers <> '+edit3.Text;
  end;
 end;
 10:sgrid1.Cells[2,sgrid_row]:='and data0058.MRB_NO like ''%'+edit3.Text+'%''';
 11:sgrid1.Cells[2,sgrid_row]:='and data0006.WORK_ORDER_NUMBER like ''%'+edit3.Text+'%''';
 12:
  begin
   sgrid1.Cells[2,sgrid_row]:='and Data0058.ttype = '+inttostr(combobox1.ItemIndex);
   sgrid1.Cells[1,sgrid_row]:=combobox1.Text;
  end;
  13:sgrid1.Cells[2,sgrid_row]:='and Data0058.warehouse_ptr = '+inttostr(wh_ptr);
  14:sgrid1.Cells[2,sgrid_row]:='and data0492.SO_NO like ''%'+edit3.Text+'%''';
  15:sgrid1.Cells[2,sgrid_row]:='and data0025.SAMPLE_NR like ''%'+edit3.Text+'%''';
  16:sgrid1.Cells[2,sgrid_row]:='and data0025.ORIG_CUSTOMER like ''%'+edit3.Text+'%''';
  17:
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
 end;  //end case

end;


procedure TForm_condition.Button3Click(Sender: TObject);
var i:byte;
begin
 for i:=1 to sgrid1.RowCount-2 do
  if sgrid1.Cells[0,i]=listbox3.Items[listbox3.itemindex] then
   begin
    self.update_sgrid(i);
    exit;
   end;
 self.update_sgrid(sgrid1.RowCount-1);
 sgrid1.RowCount:=sgrid1.RowCount+1;
end;


procedure TForm_condition.BitBtn6Click(Sender: TObject);
var InputVar: PDlgInput ;
begin
 frmPick_Item_Single:=TfrmPick_Item_Single.Create(application);
 try
  case self.ListBox3.ItemIndex of
  0:
  begin
    InputVar.Fields:='REJ_CODE/ȱ�ݴ���/104,REJECT_DESCRIPTION/ȱ������/175,���/���/50,����/����/71';
    InputVar.Sqlstr:='SELECT RKEY,REJ_CODE,REJECT_DESCRIPTION,case REJECT_DEFECT_FLAG '+
      'when ''D'' then ''����Ʒ'' when ''R'' then ''����Ʒ'' end as ���,'+
      'case rej_type when 0 then ''��������'' when 1 then ''��Ӧ�̱���'' '+
      'when 2 then ''�ͻ�����'' when 3 then ''�г�����'' when 4 then ''����'' end as ���� '+
      'FROM  Data0039 ORDER BY REJ_CODE';
    inputvar.KeyField:='REJ_CODE';
  end;
  2:
  begin
    InputVar.Fields:='DEPT_CODE/�������/106,DEPT_NAME/��������/221,����/����/65';
    InputVar.Sqlstr:='SELECT rkey,DEPT_CODE, DEPT_NAME,BARCODE_ENTRY_FLAG,'+
      'case data0034.ttype when ''1'' then  ''��������'' '+
      'when ''4'' then ''��������'' when ''5'' then ''��������'' end as ����'+#13+
      'FROM dbo.Data0034'+#13+
      'WHERE (TTYPE <> ''2'') and (TTYPE <> ''3'')'+#13+
      'ORDER BY DEPT_CODE';
    inputvar.KeyField:='DEPT_CODE';
  end;
  3:
  begin
    InputVar.Fields:='CUST_CODE/�ͻ�����/110,CUSTOMER_NAME/�ͻ�����/251,abbr_name/���/125';
    InputVar.Sqlstr:='SELECT dbo.Data0010.CUST_CODE, dbo.Data0010.CUSTOMER_NAME,'+
    'data0010.abbr_name FROM dbo.Data0010 order  by cust_code';
    inputvar.KeyField:='CUST_CODE';
  end;
  4:
  begin
    InputVar.Fields := 'PROD_CODE/��Ʒ����/110,PRODUCT_NAME/��������/285';
    InputVar.Sqlstr :='SELECT RKEY, PROD_CODE, PRODUCT_NAME'+#13+
      'FROM dbo.Data0008'+#13+
      'order  by PROD_CODE';
    inputvar.KeyField:='PROD_CODE';
  end;
  5:
  begin
    InputVar.Fields := 'MANU_PART_NUMBER/�������/89,MANU_PART_DESC/�ͻ��ͺ�/149,'+
      'ANALYSIS_CODE_2/�ͻ����Ϻ�/116,CUST_CODE/�ͻ�����/74,ABBR_NAME/�ͻ����/84';
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
  13:
  begin
    InputVar.Fields:='WAREHOUSE_CODE/��������/110,WAREHOUSE_NAME/��������/251,abbr_name/���/125';
    InputVar.Sqlstr:='SELECT rkey,warehouse_code,warehouse_name,abbr_name '+
      'from data0015 order  by warehouse_code';
    inputvar.KeyField:='warehouse_code';
  end;
  end;//end case
  inputvar.InPut_value:=edit3.Text;
  InputVar.AdoConn := form1.ADOConnection1 ;
  frmPick_Item_Single.InitForm_New(InputVar);
  if frmPick_Item_Single.ShowModal=mrok then
  begin
    case self.ListBox3.ItemIndex of
     0:edit3.Text:=trim(frmPick_Item_Single.adsPick.FieldValues['REJ_CODE']);
     2:edit3.Text:=trim(frmPick_Item_Single.adsPick.FieldValues['DEPT_CODE']);
     3:edit3.Text:=trim(frmPick_Item_Single.adsPick.FieldValues['CUST_CODE']);
     4:edit3.Text:=trim(frmPick_Item_Single.adsPick.FieldValues['PROD_CODE']);
     5:edit3.Text:=trim(frmPick_Item_Single.adsPick.FieldValues['MANU_PART_NUMBER']);
     13:
     begin
       edit3.Text:=trim(frmPick_Item_Single.adsPick.FieldValues['warehouse_code']);
       wh_ptr:=frmPick_Item_Single.adsPick.FieldValues['rkey'];
     end;
    end;
    button3.SetFocus;
  end
  else edit3.SetFocus;
 finally
   frmPick_Item_Single.adsPick.Close;
   frmPick_Item_Single.Free ;
 end; //end try
end;

end.
