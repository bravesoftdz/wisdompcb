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
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_condition: TForm_condition;

implementation

uses  damo, employee_search, customer_search;

{$R *.dfm}

procedure TForm_condition.update_sgrid(sgrid_row: byte);
begin
 sgrid1.Cells[0,sgrid_row]:=listbox3.Items[listbox3.itemindex];
 sgrid1.Cells[1,sgrid_row]:=edit3.Text;

 case listbox3.ItemIndex of
 0:
  sgrid1.Cells[2,sgrid_row]:='and data0273.ecn_no LIKE ''%'+edit3.Text+'%''';
 1:
  sgrid1.Cells[2,sgrid_row]:='and Data0010.CUST_code LIKE ''%'+edit3.Text+'%''';
 2:
  sgrid1.Cells[2,sgrid_row]:='and Data0025.manu_part_number LIKE ''%'+edit3.Text+'%''';
 3:
  sgrid1.Cells[2,sgrid_row]:='and Data0025.manu_part_desc LIKE ''%'+edit3.Text+'%''';
 4:
  sgrid1.Cells[2,sgrid_row]:='and Data0025_1.manu_part_number LIKE ''%'+edit3.Text+'%''';
 5:
  sgrid1.Cells[2,sgrid_row]:='and Data0025_1.manu_part_desc LIKE ''%'+edit3.Text+'%''';
 6:
  sgrid1.Cells[2,sgrid_row]:='and Data0005.empl_code LIKE ''%'+edit3.Text+'%''';
 7:
  begin
   sgrid1.Cells[2,sgrid_row]:='and data0273.tooling_close= '+inttostr(combobox1.ItemIndex+1);
   sgrid1.Cells[1,sgrid_row]:=combobox1.Text;
  end;
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
 1:bitbtn6.Visible:=true;
 2:;
 3:;
 4:;
 5:;
 6:bitbtn6.Visible:=true;
 7:begin          //�������
    combobox1.Visible:=TRUE;
    edit3.Visible:=false;
    button3.Enabled:=true;
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

 self.update_sgrid(sgrid1.RowCount-1);
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
 end
else 
if button3.Enabled then button3.OnClick(sender);
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
begin
case self.ListBox3.ItemIndex of
1:
 begin
  form_customer:=tform_customer.Create(application);
  if form_customer.ShowModal=mrok then
  begin
   edit3.Text:=form_customer.ads10CUST_CODE.Value;
   button3.Enabled:=true;
  end;
  form_customer.Free;
 end;
6:
 begin
  form_employee:=tform_employee.Create(application);
  if form_employee.ShowModal=mrok then
  begin
   edit3.Text:=form_employee.ADOQuery1EMPL_CODE.Value;
   button3.Enabled:=true;
  end;
  form_employee.Free;
 end;
4:
 begin

 end;

end;
end;

end.
