unit diretc_intlist;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls;

type
  TForm5 = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    ComboBox1: TComboBox;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Button1: TButton;
    Button2: TButton;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    BitBtn2: TBitBtn;
    BitBtn1: TBitBtn;
    rkey17: TLabel;
    rkey16: TLabel;
    rkey02: TLabel;
    Label9: TLabel;
    Edit7: TEdit;
    Edit8: TEdit;
    Label8: TLabel;
    Label10: TLabel;
    SHELF_LIFE: TLabel;
    procedure ComboBox1Change(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure Edit1Exit(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Edit2Exit(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Edit3KeyPress(Sender: TObject; var Key: Char);
    procedure Edit5Exit(Sender: TObject);
    procedure Edit4Exit(Sender: TObject);
    procedure Edit3Exit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form5: TForm5;

implementation

uses inv_search, data_module, direct_ware, Unit_search;

{$R *.dfm}

procedure TForm5.ComboBox1Change(Sender: TObject);
begin
 dm.aq16.MoveBy(combobox1.ItemIndex+1-dm.aq16.RecNo);
 rkey16.Caption:=dm.aq16rkey.AsString;
end;

procedure TForm5.BitBtn2Click(Sender: TObject);
begin
 try
  form_inv := tform_inv.Create(application);
  form_inv.ADOQuery1.Close;
  form_inv.ADOQuery1.Parameters.ParamByName('rkey15').Value:=form4.warehouse_ptr;
  form_inv.ADOQuery1.Parameters.ParamByName('INV_NAME').Value:='%'+trim(edit1.Text)+'%';
  form_inv.ADOQuery1.Open;
  if form_inv.ADOQuery1.IsEmpty then
   begin
    messagedlg('û���ҵ���ؼ�¼!',mtinformation,[mbcancel],0);
    edit2.SetFocus;
   end
  else
  if form_inv.ShowModal = mrok then
   begin
    edit1.Text:=form_inv.ADOQuery1INV_PART_NUMBER.Value;
    edit7.Text:=form_inv.ADOQuery1INV_NAME.Value;
    edit8.Text:=form_inv.ADOQuery1INV_DESCRIPTION.Value;
    rkey17.Caption:=form_inv.ADOQuery1RKEY.AsString;
    rkey02.Caption:=form_inv.ADOQuery1STOCK_UNIT_PTR.AsString;
    edit2.Text:=form_inv.ADOQuery1unit_code.Value;
    label9.Caption:=form_inv.ADOQuery1unit_name.Value;
    SHELF_LIFE.Caption:=form_inv.adoquery1SHELF_LIFE.asstring;
   end
  else
   edit1.SetFocus;
 finally
  form_inv.free;
 end;
end;

procedure TForm5.Edit1Exit(Sender: TObject);
begin
if (activecontrol.Name<>'BitBtn2') and (activecontrol.Name<>'Button2')
   and (trim(edit1.Text)<>'') then
 try
  form_inv := tform_inv.Create(application);
  form_inv.ADOQuery1.Close;
  form_inv.ADOQuery1.Parameters.ParamByName('rkey15').Value:=form4.warehouse_ptr;
  form_inv.ADOQuery1.Parameters.ParamByName('INV_NAME').Value:='%'+trim(edit1.Text)+'%';
  form_inv.ADOQuery1.Open;
  if comparetext(trim(edit1.text),trim(form_inv.ADOQuery1inv_part_number.Value))=0 then
   begin
    if form_inv.ADOQuery1RKEY.Value<>strtoint(rkey17.Caption) then
     begin
      edit7.Text:=form_inv.ADOQuery1INV_NAME.Value;
      edit8.Text:=form_inv.ADOQuery1INV_DESCRIPTION.Value;
      rkey17.Caption:=form_inv.ADOQuery1RKEY.AsString;
      rkey02.Caption:=form_inv.ADOQuery1STOCK_UNIT_PTR.AsString;
      edit2.Text:=form_inv.ADOQuery1unit_code.Value;
      label9.Caption:=form_inv.ADOQuery1unit_name.Value;
      SHELF_LIFE.Caption:=form_inv.adoquery1SHELF_LIFE.asstring;
     end;
   end
  else
   begin
    messagedlg('ԭ���Ϻ��벻��ȷ,�����������ѡ��',mtinformation,[mbok],0);
    edit7.Text:='';
    edit8.Text:='';
    edit1.SetFocus;
   end;
 finally
  form_inv.Free;
 end
else
if (activecontrol.Name<>'BitBtn2') and (activecontrol.Name<>'Button2')
 and (trim(edit1.Text) = '') then
 begin
  label8.Caption := '';
  rkey17.Caption:='0';
  rkey02.Caption:='0';
  edit2.Text:='';
  label9.Caption:='';
 end;
end;

procedure TForm5.BitBtn1Click(Sender: TObject);
begin
form_unit:=tform_unit.Create(application);
if form_unit.ShowModal=mrok then
 begin
  edit2.Text:=form_unit.ADOQuery1unit_code.Value;
  label9.Caption:=form_unit.ADOQuery1unit_name.Value;
  rkey02.Caption:=form_unit.ADOQuery1rkey.AsString;
 end;
form_unit.Free;
end;

procedure TForm5.Edit2Exit(Sender: TObject);
begin
if (activecontrol.Name<>'BitBtn1') and (activecontrol.Name<>'Button2')
    and (trim(edit2.Text)<>'') then
 try
  form_unit:=tform_unit.Create(application);
  form_unit.Edit1.Text :=trim(edit2.Text);
 if comparetext(trim(edit2.text),trim(form_unit.ADOQuery1unit_code.Value))=0 then
   begin
    label9.Caption := form_unit.ADOQuery1unit_name.Value;
    rkey02.Caption := form_unit.ADOQuery1rkey.AsString;
   end
  else
   begin
    messagedlg('��λ����ȷ,�����������ѡ��',mtinformation,[mbok],0);
    label9.Caption := '';
    edit2.SetFocus;
   end;
 finally
  form_unit.free;
 end
else
if (activecontrol.Name<>'BitBtn1') and (activecontrol.Name<>'Button2')
    and (trim(edit2.Text)='') then
 begin
  label9.Caption := '';
  rkey02.Caption:='0';
 end;
end;

procedure TForm5.Button1Click(Sender: TObject);
begin
if trim(edit1.Text)='' then
 begin
  showmessage('���ϱ��벻����Ϊ��!');
  edit1.SetFocus;
  exit;
 end;
if trim(edit2.Text)='' then
 begin
  showmessage('��λ������Ϊ��!');
  edit2.SetFocus;
  exit;
 end;
if strtoint(rkey16.Caption)=0 then
 begin
  showmessage('���λ�ò�����Ϊ��!');
  combobox1.SetFocus;
  exit;
 end;
if strtofloat(edit3.Text)<=0 then
 begin
  showmessage('����������������!');
  edit3.SetFocus;
  exit;
 end;
 with form4 do
 begin
  strgrid1.Cells[0,strgrid1.RowCount-1] := self.Edit1.Text;
  strgrid1.Cells[1,strgrid1.RowCount-1] := self.edit7.Text;
  strgrid1.Cells[2,strgrid1.RowCount-1] := self.edit8.Text;
  strgrid1.Cells[3,strgrid1.RowCount-1] := self.combobox1.Text;
  strgrid1.Cells[4,strgrid1.RowCount-1] := self.label9.Caption;
  strgrid1.Cells[5,strgrid1.RowCount-1] := self.edit3.Text;
  strgrid1.Cells[6,strgrid1.RowCount-1] := self.edit4.Text;
  strgrid1.Cells[7,strgrid1.RowCount-1] := self.edit5.Text;
  strgrid1.Cells[8,strgrid1.RowCount-1] := self.edit6.Text;
  stgrid2.Cells[0,stgrid2.RowCount-1] :=rkey17.Caption;
  stgrid2.Cells[1,stgrid2.RowCount-1] :=rkey02.Caption;
  stgrid2.Cells[2,stgrid2.RowCount-1] :=rkey16.Caption;
  stgrid2.Cells[3,stgrid2.RowCount-1] :=SHELF_LIFE.Caption;
  stgrid2.RowCount:=stgrid2.RowCount+1;
  strgrid1.RowCount:=strgrid1.RowCount+1;
 end;
rkey17.Caption:='0';
rkey02.Caption:='0';
SHELF_LIFE.Caption:='0';
edit1.Text:='';
edit7.Text:='';
edit8.Text:='';
label9.Caption:='';
edit2.Text:='';
edit3.Text:='0.00';
edit4.Text:='0.000';
edit5.Text:='0.00';
edit1.SetFocus;
end;

procedure TForm5.Edit3KeyPress(Sender: TObject; var Key: Char);
begin
 if not (key in ['0'..'9','.',#8,#13]) then  //�ж��Ƿ���������
  abort
 else
  if key = chr(46) then      //�ж��Ƿ��ظ�����С����'.'
   if pos('.',(sender as tedit).Text)>0  then abort;
end;

procedure TForm5.Edit5Exit(Sender: TObject);
begin
if edit5.Text = '' then edit5.Text := '0';
 edit5.Text := formatfloat('0.00',strtofloat(edit5.Text));
end;

procedure TForm5.Edit4Exit(Sender: TObject);
begin
if edit4.Text = '' then edit4.Text := '0';
 edit4.Text := formatfloat('0.000',strtofloat(edit4.Text));
end;

procedure TForm5.Edit3Exit(Sender: TObject);
begin
if edit3.Text = '' then edit3.Text := '0';
 edit3.Text := formatfloat('0.00',strtofloat(edit3.Text));
end;

end.

