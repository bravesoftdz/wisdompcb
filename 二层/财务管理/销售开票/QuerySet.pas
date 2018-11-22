unit QuerySet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, StdCtrls, Buttons, Grids, Menus,DateUtils;

type
  TfrmQuerySet = class(TForm)
    StaticText2: TStaticText;
    SGrid1: TStringGrid;
    GroupBox6: TGroupBox;
    Label8: TLabel;
    edtValue: TEdit;
    Button3: TButton;
    BitBtn6: TBitBtn;
    ListBox3: TListBox;
    StaticText7: TStaticText;
    Button1: TButton;
    Button2: TButton;
    Button4: TButton;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    rgType: TRadioGroup;
    DTPk1: TDateTimePicker;
    DTpk2: TDateTimePicker;
    Label1: TLabel;
    Label2: TLabel;
    procedure BitBtn6Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure ListBox3Click(Sender: TObject);
    procedure edtValueKeyPress(Sender: TObject; var Key: Char);
    procedure Button4Click(Sender: TObject);
    procedure dtpk1KeyPress(Sender: TObject; var Key: Char);
    procedure edtValueChange(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    v_Field_List_CN,v_Field_List_EN:Variant;
  public
    v_form:Byte;   //0:װ�˲���,1:�˻�����

    { Public declarations }
  end;

var
  frmQuerySet: TfrmQuerySet;

implementation
uses common, damo, constvar,pick_item_single;
{$R *.dfm}

procedure TfrmQuerySet.BitBtn6Click(Sender: TObject);
var
  tmpstr:string;
  InputVar: PDlgInput;
begin
   case ListBox3.ItemIndex of
    3:tmpstr:= Pick_Prod_Type(edtValue.Text,dm.ADOConnection1,2);
    4:
 try
  frmPick_Item_Single:=TfrmPick_Item_Single.Create(application);
  InputVar.Fields:='CODE/�ֿ����/110,LOCATION/�ֿ�����/351';
  InputVar.Sqlstr:='SELECT RKEY,CODE,LOCATION FROM Data0016 where location_type=1'+
  ' order by code';
  inputvar.KeyField:='CODE';
  InputVar.AdoConn := dm.ADOConnection1 ;
  frmPick_Item_Single.InitForm_New(InputVar);
  if frmPick_Item_Single.ShowModal=mrok then
   begin
    tmpstr:=frmPick_Item_Single.adsPick.Fieldbyname('CODE').AsString;
   end
  else
   edtvalue.SetFocus;
 finally
   frmPick_Item_Single.adsPick.Close;
   frmPick_Item_Single.Free ;
 end;
    7:
 try
  frmPick_Item_Single:=TfrmPick_Item_Single.Create(application);
  InputVar.Fields:='warehouse_code/��������/110,warehouse_name/��������/300,'+
                   'abbr_name/�������/100';
  InputVar.Sqlstr:='SELECT RKEY,warehouse_code,warehouse_name,abbr_name FROM Data0015 '+
  ' order by warehouse_code';
  inputvar.KeyField:='warehouse_code';
  inputvar.InPut_value:=edtvalue.Text;
  InputVar.AdoConn := dm.ADOConnection1 ;
  frmPick_Item_Single.InitForm_New(InputVar);
  if frmPick_Item_Single.ShowModal=mrok then
   begin
    tmpstr:=frmPick_Item_Single.adsPick.Fieldbyname('warehouse_code').AsString;
   end
  else
   edtvalue.SetFocus;
 finally
   frmPick_Item_Single.adsPick.Close;
   frmPick_Item_Single.Free ;
 end;

   end;

  if tmpstr <> '' then edtValue.Text := tmpstr;
end;

procedure TfrmQuerySet.Button3Click(Sender: TObject);
var i:byte;
begin

  for i:=1 to sgrid1.RowCount-2 do
  if sgrid1.Cells[0,i]=listbox3.Items[listbox3.itemindex] then exit;

  sgrid1.Cells[0,sgrid1.RowCount-1]:=listbox3.Items[listbox3.itemindex];
  case listbox3.itemindex of
  0,1,2,3,4,5:
   begin
    if  rgType.ItemIndex = 1 then
     begin
      sgrid1.Cells[1,sgrid1.RowCount-1]:=' like '+edtValue.Text;
      sgrid1.Cells[2,sgrid1.RowCount-1]:=' and '+v_Field_List_EN[ListBox3.ItemIndex]+' LIKE ''%'+edtValue.Text+'%'''
     end
    else
     begin
      sgrid1.Cells[1,sgrid1.RowCount-1]:=' = '+edtValue.Text;
      sgrid1.Cells[2,sgrid1.RowCount-1]:=' and '+v_Field_List_EN[ListBox3.ItemIndex]+' = '''+edtValue.Text+'''' ;
     end;
   end;

  6,7:
   begin
    sgrid1.Cells[1,sgrid1.RowCount-1]:='��'+
    formatdatetime('yyyy-mm-dd ',self.dtpk1.Date)+'��'+
    formatdatetime('yyyy-mm-dd ',self.dtpk2.Date);

    sgrid1.Cells[2,sgrid1.RowCount-1]:=
    ' and '+v_Field_List_EN[ListBox3.ItemIndex]+ ' >= '+
    quotedstr(formatdatetime('yyyy-mm-dd ',self.dtpk1.Date))+

    ' and '+v_Field_List_EN[ListBox3.ItemIndex]+ ' <= '+
    quotedstr(formatdatetime('yyyy-mm-dd ',self.dtpk2.Date));
   end;
  end;

  sgrid1.RowCount:=sgrid1.RowCount+1;
end;


procedure TfrmQuerySet.ListBox3Click(Sender: TObject);
begin
  edtValue.Text := '';
  edtValue.Visible := (listbox3.ItemIndex <= 5);
  BitBtn6.visible := False;
  if edtValue.Visible then edtValue.SetFocus;
  button3.Enabled := (listbox3.ItemIndex = 6) or (listbox3.ItemIndex = 7);
  dtpk1.Visible := listbox3.ItemIndex >= 6;
  dtpk2.Visible := dtpk1.Visible;
  label1.Visible:=dtpk1.Visible;
  label2.Visible:=dtpk1.Visible;

  rgtype.Visible := listbox3.ItemIndex <= 5;

  rgType.ItemIndex := 0;
  Label8.Caption := listbox3.Items[listbox3.ItemIndex];
end;

procedure TfrmQuerySet.edtValueKeyPress(Sender: TObject; var Key: Char);
begin
  if (key=#13) and (edtvalue.Text <> '') then
    Button3Click(sender);
end;

procedure TfrmQuerySet.Button4Click(Sender: TObject);
var i:byte;
begin
 if sgrid1.RowCount <= 2 then exit;
 for i:=sgrid1.Row to sgrid1.RowCount-2 do
  sgrid1.Rows[i].Text:=sgrid1.Rows[i+1].Text;
 sgrid1.RowCount:=sgrid1.RowCount-1;
end;

procedure TfrmQuerySet.dtpk1KeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
    Button1.Click;
end;

procedure TfrmQuerySet.edtValueChange(Sender: TObject);
begin
if edtvalue.Text <> '' then
 button3.Enabled:=true
else
 button3.Enabled:=false; 
end;

procedure TfrmQuerySet.FormActivate(Sender: TObject);
var i:integer;
   curr_date:TDateTime;
begin
  if v_form=0 then
  begin
   v_Field_List_CN := VarArrayOf(['�������','�ͻ��ͺ�','�ͻ�������',
   '���۶���','װ�䵥','��Ʊ���','��Ʊ����','��������']);
   v_Field_List_EN := VarArrayOf(['data0025.MANU_PART_NUMBER','data0025.Manu_Part_Desc',
   'Data0097.PO_NUMBER','data0060.sales_order','data0439.delivery_no',
   'data0112.invoice_number','data0112.POSTED_DATE','data0439.date_sailing']);
  end
  else
  begin
   v_Field_List_CN := VarArrayOf(['�������','�ͻ��ͺ�','�ͻ�������',
   '���۶���','�˻�����','�������','��������','�˻�����']);
   v_Field_List_EN := VarArrayOf(['data0025.MANU_PART_NUMBER','data0025.Manu_Part_Desc',
    'Data0097.PO_NUMBER','data0060.sales_order','data0098.RMA_NUMBER',
    'data0116.MEMO_NUMBER','data0116.MEMO_DATE','data0098.RMA_DATE']);
  end;

  for i:= VarArrayLowBound(v_Field_List_CN,1) to VarArrayHighBound(v_Field_List_CN,1) do
    listbox3.Items.Add(v_Field_List_CN[i]);
  sgrid1.Cells[0,0]:='������';
  sgrid1.Cells[1,0]:='����ֵ';
  ListBox3.ItemIndex := 0;
  curr_date:=common.getsystem_date(dm.ADOQuery1,1);

  DTpk2.Date:=curr_date-dayof(curr_date);
  DTPk1.date:=StartOfTheMonth(DTpk2.Date);
end;

end.
