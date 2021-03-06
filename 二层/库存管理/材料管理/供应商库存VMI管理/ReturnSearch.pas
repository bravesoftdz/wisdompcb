unit ReturnSearch;

interface

uses
   Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, Grids, ExtCtrls, StdCtrls, Buttons, Mask, ComCtrls;

type
  TForm_ReturnSearch = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Button1: TButton;
    ListBox1: TListBox;
    Edit1: TEdit;
    BitBtn4: TBitBtn;
    SGrid1: TStringGrid;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    CheckBox1: TCheckBox;
    Label2: TLabel;
    dtpk1: TDateTimePicker;
    Label3: TLabel;
    dtpk2: TDateTimePicker;
    procedure FormCreate(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure Edit1Exit(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
  private
    { Private declarations }
  procedure update_sgrid(sgrid_row:byte);
  public
    { Public declarations }
  end;

var
  Form_ReturnSearch: TForm_ReturnSearch;

implementation

uses demo,pick_item_single,constvar;

{$R *.dfm}

procedure TForm_ReturnSearch.FormCreate(Sender: TObject);
begin
 sgrid1.Cells[0,0]:='条件名称';
 sgrid1.Cells[1,0]:='条件值';
 listbox1.ItemIndex:=0;
 self.ListBox1click(sender);
 dtpk1.Date:=now-90;
 dtpk2.Date:=now;
end;
procedure TForm_ReturnSearch.update_sgrid(sgrid_row: byte);
begin
 sgrid1.Cells[0,sgrid_row]:=listbox1.Items[listbox1.itemindex];
 sgrid1.Cells[1,sgrid_row]:=trim(edit1.Text);
 case listbox1.ItemIndex of
  0:sgrid1.Cells[2,sgrid_row]:=' and data0017.inv_part_number='''+trim(edit1.Text)+'''';
  1:sgrid1.Cells[2,sgrid_row]:=' and data0133.GRN_NUMBER='''+trim(edit1.Text)+'''';
  2:sgrid1.Cells[2,sgrid_row]:=' and data0023.code='''+trim(edit1.Text)+'''';
  3:sgrid1.Cells[2,sgrid_row]:=' and data0015.warehouse_code='''+trim(edit1.Text)+'''';
  4:sgrid1.Cells[2,sgrid_row]:=' and data0016.code='''+trim(edit1.Text)+'''';
 end;
end;


procedure TForm_ReturnSearch.ListBox1Click(Sender: TObject);
begin
 label1.Caption:=listbox1.Items[listbox1.itemindex]+'：';
 edit1.Text:='';
 bitbtn4.Visible:=listbox1.ItemIndex in [0,2,3,4];
end;
procedure TForm_ReturnSearch.Edit1Change(Sender: TObject);
begin
  if trim(edit1.Text)<>'' then button1.Enabled:=true
  else button1.Enabled:=false;
end;

procedure TForm_ReturnSearch.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if key=#13 then button1.SetFocus;
end;

procedure TForm_ReturnSearch.Edit1Exit(Sender: TObject);
begin
 if (listbox1.ItemIndex<>1) and (trim(edit1.Text)<>'') then
  with dm.tmpt do
  begin
   close;
   case listbox1.ItemIndex of
    0:sql.Text:='select rkey from data0017 where inv_part_number='''+trim(edit1.Text)+'''';
    2:sql.Text:='select rkey from data0023 where code='''+trim(edit1.Text)+'''';
    3:sql.Text:='select rkey from data0015 where warehouse_code='''+trim(edit1.Text)+'''';
    4:sql.Text:='select rkey from data0016 where code='''+trim(edit1.Text)+'''';
   end;
   open;
   if isempty then
   begin
    showmessage(label1.caption+'输入错误，请重新输入！');
    edit1.Text:='';
    edit1.SetFocus;
   end;
  end;
end;
procedure TForm_ReturnSearch.BitBtn4Click(Sender: TObject);
var inputvar: PDlgInput;
begin
 frmpick_item_single:=Tfrmpick_item_single.Create(application);
 try
  case listbox1.ItemIndex of
   0:
   begin
    inputvar.Fields:='code/材料编码/200,name/材料描述/300';
    inputvar.Sqlstr:='select rkey,inv_part_number as code,inv_part_description as name from data0017 order by inv_part_number';
    inputvar.KeyField:='code';
   end;
   2:
   begin
    inputvar.Fields:='code/供应商代码/100,name/供应商名称/270';
    inputvar.Sqlstr:='select rkey,code,supplier_name as name from data0023 order by code';
    inputvar.KeyField:='code';
   end;
   3:
   begin
    inputvar.Fields:='code/工厂代码/130,name/工厂名称/240';
    inputvar.Sqlstr:='select rkey,warehouse_code as code,warehouse_name as name from data0015 order by warehouse_code';
    inputvar.KeyField:='code';
   end;
   4:
   begin
    inputvar.Fields:='code/材料编码/130,name/客户名称/240';
    inputvar.Sqlstr:='select rkey,code,location as name from data0016 order by code';
    inputvar.KeyField:='code';
   end;
  end;

  inputvar.InPut_value:=edit1.Text;
  inputvar.AdoConn:=dm.ADOConnection1;
  frmpick_item_single.InitForm_New(inputvar);
  if frmpick_item_single.ShowModal=mrok then
  begin
   edit1.Text:=trim(frmpick_item_single.adsPick.FieldValues['code']);
   button1.SetFocus;
  end
  else edit1.SetFocus;
 finally
  frmpick_item_single.adsPick.Close;
  frmpick_item_single.Free;
 end;
end;
procedure TForm_ReturnSearch.Button1Click(Sender: TObject);
var i:byte;
begin
  for i:=1 to sgrid1.RowCount-2 do
   if sgrid1.Cells[0,i]=listbox1.Items[listbox1.ItemIndex] then
   begin
     update_sgrid(i);
     exit;
   end;
  update_sgrid(sgrid1.RowCount-1);
  sgrid1.RowCount:=sgrid1.RowCount+1;
end;

procedure TForm_ReturnSearch.BitBtn2Click(Sender: TObject);
var i:byte;
begin  //重置，即清空sgrid数据
  for i:=1 to sgrid1.RowCount-1 do
    sgrid1.Rows[i].Clear;
  sgrid1.RowCount:=2;
end;

procedure TForm_ReturnSearch.N1Click(Sender: TObject);
var i:byte;
begin
  if sgrid1.RowCount>2 then
  begin
   for i:=sgrid1.Row to sgrid1.RowCount-2 do
    sgrid1.Rows[i].Text:=sgrid1.Rows[i+1].Text;
   sgrid1.RowCount:=sgrid1.RowCount-1;
  end
  else sgrid1.Rows[sgrid1.Row].Clear;
end;

procedure TForm_ReturnSearch.PopupMenu1Popup(Sender: TObject);
begin
 if (sgrid1.Row>0) and (sgrid1.Row<sgrid1.RowCount-1) then
  n1.Enabled:=true
 else n1.Enabled:=false;
end;

end.
