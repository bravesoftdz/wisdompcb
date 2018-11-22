unit term;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, Grids, Menus, ExtCtrls;

type
  TForm_condition = class(TForm)
    GroupBox6: TGroupBox;
    Label8: TLabel;
    Button3: TButton;
    BitBtn6: TBitBtn;
    ListBox3: TListBox;
    StaticText7: TStaticText;
    Edit3: TEdit;
    StaticText2: TStaticText;
    SGrid1: TStringGrid;
    Button1: TButton;
    Button2: TButton;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    dtpk1: TDateTimePicker;
    dtpk2: TDateTimePicker;
    Bevel1: TBevel;
    Label3: TLabel;
    Label4: TLabel;
    ComboBox1: TComboBox;
    RadioGroup1: TRadioGroup;
    procedure ListBox3Click(Sender: TObject);
    procedure Edit3KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button3Click(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure SGrid1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure N1Click(Sender: TObject);
    procedure update_sgrid(sgrid_row:byte);
    procedure FormActivate(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_condition: TForm_condition;

implementation

uses curr_search, supplier_search, employee_search,common,Pick_Item_Single,ConstVar,
  datamd;



{$R *.dfm}

procedure TForm_condition.update_sgrid(sgrid_row: byte);
begin
 sgrid1.Cells[0,sgrid_row]:=listbox3.Items[listbox3.itemindex];
 sgrid1.Cells[1,sgrid_row]:=edit3.Text;
 case listbox3.ItemIndex of
 0:
  sgrid1.Cells[2,sgrid_row]:='and Data0132.MEMO_NUMBER LIKE ''%'+edit3.Text+'%''';
 1:
  sgrid1.Cells[2,sgrid_row]:='and data0023.CODE LIKE ''%'+edit3.Text+'%''';
 2:
  sgrid1.Cells[2,sgrid_row]:='and data0001.CURR_CODE LIKE ''%'+edit3.Text+'%''';
 3:
  BEGIN
   sgrid1.Cells[2,sgrid_row]:='and data0132.memo_tp='''+inttostr(combobox1.ItemIndex+2)+'''';
   sgrid1.Cells[1,sgrid_row]:=combobox1.Text;
  END;
 4:
  sgrid1.Cells[2,sgrid_row]:='and Data0105.VOUCHER like ''%'+edit3.Text+'%''';
 5:
  sgrid1.Cells[2,sgrid_row]:='and Data0005.empl_code like ''%'+edit3.Text+'%''';
  6:
  sgrid1.Cells[2,sgrid1.RowCount-1]:=' and Data0015.WAREHOUSE_CODE like ''%'+edit3.Text+'%''';
 end;

end;

procedure TForm_condition.ListBox3Click(Sender: TObject);
begin
label8.Caption:=listbox3.Items[listbox3.itemindex];
edit3.Text:='';
edit3.Visible:=true;
button3.Enabled:=false;
bitbtn6.Visible:=false;
combobox1.Visible:=false;
case listbox3.ItemIndex of
 0:;
 1:begin
    bitbtn6.Visible:=true;
   end;
 2:begin
    bitbtn6.Visible:=true;
   end;
 3:begin
    combobox1.Visible:=true;
    edit3.Visible:=false;
    button3.Enabled:=true;
   end;
 4:begin

   end;
 5,6:begin
    bitbtn6.Visible:=true;
   end;
 end;
end;

procedure TForm_condition.Edit3KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if trim(edit3.Text)<>'' then
 button3.Enabled:=true
else
 button3.Enabled:=false;
end;

procedure TForm_condition.Button3Click(Sender: TObject);
var
 i:byte;
begin
 for i:=1 to sgrid1.RowCount-2 do
  if sgrid1.Cells[0,i]=listbox3.Items[listbox3.itemindex]  then
   begin
    self.update_sgrid(i);
    exit;
   end;

 sgrid1.Cells[0,sgrid1.RowCount-1]:=listbox3.Items[listbox3.itemindex];
 sgrid1.Cells[1,sgrid1.RowCount-1]:=edit3.Text;
 case listbox3.ItemIndex of
 0:
  sgrid1.Cells[2,sgrid1.RowCount-1]:='and Data0132.MEMO_NUMBER LIKE ''%'+edit3.Text+'%''';
 1:
  sgrid1.Cells[2,sgrid1.RowCount-1]:='and data0023.CODE LIKE ''%'+edit3.Text+'%''';
 2:
  sgrid1.Cells[2,sgrid1.RowCount-1]:='and data0001.CURR_CODE LIKE ''%'+edit3.Text+'%''';
 3:
  BEGIN
   sgrid1.Cells[2,sgrid1.RowCount-1]:='and data0132.memo_tp='''+inttostr(combobox1.ItemIndex+2)+'''';
   sgrid1.Cells[1,sgrid1.RowCount-1]:=combobox1.Text;
  END;
 4:
  sgrid1.Cells[2,sgrid1.RowCount-1]:='and Data0105.VOUCHER like ''%'+edit3.Text+'%''';
 5:
  sgrid1.Cells[2,sgrid1.RowCount-1]:='and Data0005.empl_code like ''%'+edit3.Text+'%''';
  6:
  sgrid1.Cells[2,sgrid1.RowCount-1]:=' and Data0015.WAREHOUSE_CODE like ''%'+edit3.Text+'%''';
 end;
 sgrid1.RowCount:=sgrid1.RowCount+1;
end;

procedure TForm_condition.PopupMenu1Popup(Sender: TObject);
begin
 if sgrid1.Row=sgrid1.RowCount-1 then
  n1.Enabled:=false
 else
  n1.Enabled:=true; 
end;

procedure TForm_condition.SGrid1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
 column,row:longint;//�Ҽ�ѡ��stringgrid�ؼ��ķ���
begin
if button=mbright then
 begin
  SGrid1.MouseToCell(x,y,column,row);
  if row<>0 then SGrid1.Row:=row;
 end;
end;

procedure TForm_condition.N1Click(Sender: TObject);
var
 i:byte;
begin
 for i:=sgrid1.Row to sgrid1.RowCount-2 do
  sgrid1.Rows[i].Text:=sgrid1.Rows[i+1].Text;
 sgrid1.RowCount:=sgrid1.RowCount-1;
end;

procedure TForm_condition.FormActivate(Sender: TObject);
begin
  sgrid1.Cells[0,0]:='������';
  sgrid1.Cells[1,0]:='����ֵ';
  listbox3.Selected[0]:=true;
  self.ListBox3.OnClick(sender);
end;

procedure TForm_condition.BitBtn6Click(Sender: TObject);
var
  InputVar: PDlgInput ;
begin
case self.ListBox3.ItemIndex of
1:
 begin
  form_supp:=tform_supp.Create(application);
  if form_supp.ShowModal=mrok then
   begin
    edit3.Text:=form_supp.ADOData0023CODE.Value;
    button3.Enabled:=true;
   end;
  form_supp.Free;
 end;
2:
 begin
  form_curr:=tform_curr.Create(application);
  if form_curr.ShowModal=mrok then
   begin
    edit3.Text:=form_curr.ADOQuery1CURR_CODE.Value;
    button3.Enabled:=true;
   end;
  form_curr.Free;
 end;
3:
 begin

 end;
5:
 begin
  form_employee:=Tform_employee.Create(application);
  if form_employee.ShowModal=mrok then
   begin
    edit3.Text:=form_employee.ADOQuery1EMPL_CODE.Value;
    button3.Enabled:=true;
   end;
  form_employee.Free;
 end;
6:begin
  frmPick_Item_Single := TfrmPick_Item_Single.Create(application) ;
  try
    InputVar.Fields := 'warehouse_CODE/��������/100,ABBR_NAME/�������/100,warehouse_NAME/��������/200';
    InputVar.Sqlstr := 'select rkey,warehouse_CODE,ABBR_NAME,warehouse_NAME from data0015';
    InputVar.AdoConn := dm.ACt;
    frmPick_Item_Single.InitForm_New(InputVar);
    if frmPick_Item_Single.ShowModal=mrok then
    begin
      Edit3.Text := frmPick_Item_Single.adsPick.FieldValues['warehouse_CODE'];
      button3.Enabled:=true;
    end;
  finally
    frmPick_Item_Single.adsPick.Close;
    frmPick_Item_Single.Free ;
  end;
  end;
end;
end;

procedure TForm_condition.RadioGroup1Click(Sender: TObject);
begin
if radiogroup1.ItemIndex=0 then
 label4.Caption:='�������ڴ�:'
else
 label4.Caption:='������ڴ�:'
end;

end.
