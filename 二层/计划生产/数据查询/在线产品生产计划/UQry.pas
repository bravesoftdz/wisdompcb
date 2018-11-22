unit UQry;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Menus, StdCtrls, Buttons, Grids, DB, ADODB;

type
  TfrmQry = class(TForm)
    pnl1: TPanel;
    StaticText2: TStaticText;
    SGrid1: TStringGrid;
    GroupBox6: TGroupBox;
    Label8: TLabel;
    rgType: TRadioGroup;
    edtValue: TEdit;
    Button3: TButton;
    BitBtn6: TBitBtn;
    ListBox3: TListBox;
    StaticText7: TStaticText;
    Button4: TButton;
    cbbJS: TComboBox;
    Panel3: TPanel;
    ComboBox3: TComboBox;
    Edit1: TEdit;
    Button1: TButton;
    Button2: TButton;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    qrytemp: TADOQuery;
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure ListBox3Click(Sender: TObject);
    procedure edtValueKeyPress(Sender: TObject; var Key: Char);
    procedure BitBtn6Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    v_Field_List_CN,v_Field_List_EN:Variant;
    grid_add_flag : Integer;
     procedure update_sgrid(sgrid_row:byte);
  public
    { Public declarations }
  end;

var
  frmQry: TfrmQry;

implementation

uses udm,common,Pick_Item_Single,ConstVar;

{$R *.dfm}

procedure TfrmQry.Button3Click(Sender: TObject);
var i:byte;
    flag : Integer;

begin
  flag := 0;
  grid_add_flag := 0;
  if (listbox3.itemindex < 8) and (trim(edtValue.Text)='') then exit;
  if (listbox3.itemindex = 16) and (trim(edtValue.Text)='') then exit;
  if (ListBox3.ItemIndex = 18) and (Trim(cbbJS.Text)='') then Exit;
  if (ListBox3.ItemIndex = 19) and (Trim(Edit1.Text)='') then Exit;
  //�˴��ж��ظ���Ӧ�ÿ��Ǹ��ǣ���A_EP002
 for i:=1 to sgrid1.RowCount-2 do
  if sgrid1.Cells[0,i]=listbox3.Items[listbox3.itemindex]  then
   begin
    self.update_sgrid(i);
    flag := 1;
    exit;
   end;
   if flag = 0 then
   begin
      grid_add_flag := 2;
      self.update_sgrid(sgrid1.RowCount-1);
      if grid_add_flag = 1 then
      begin
        sgrid1.RowCount:=sgrid1.RowCount+1;
        SGrid1.Cells[0,SGrid1.RowCount-1]:='';
        SGrid1.Cells[1,SGrid1.RowCount-1]:='';
        SGrid1.Cells[2,SGrid1.RowCount-1]:='';
      end;
   end;
end;

 procedure TfrmQry.update_sgrid(sgrid_row:byte);
 begin

  if (listbox3.itemindex < 8) or (ListBox3.ItemIndex=17) then
  begin
    if grid_add_flag =2 then grid_add_flag := 1;  //�����жϣ�����������£������ 1
    if  rgType.ItemIndex = 0 then
    begin
      sgrid1.Cells[1,sgrid_row]:=' like '+edtValue.Text;
      sgrid1.Cells[2,sgrid_row]:=' and '+v_Field_List_EN[ListBox3.ItemIndex]+' LIKE ''''%'+edtValue.Text+'%'''' '
    end else begin
      sgrid1.Cells[1,sgrid_row]:=' = '+edtValue.Text;
      sgrid1.Cells[2,sgrid_row]:=' and '+v_Field_List_EN[ListBox3.ItemIndex]+' = '''''+edtValue.Text+''''' ' ;
    end;
  end
  else if listbox3.itemindex in [12,13] then
  begin
    qrytemp.Close;
    qrytemp.SQL.Text:='select rkey from data0015 where warehouse_code='''+edtValue.Text+''' ';
    qrytemp.Open;
    if qrytemp.IsEmpty then
    begin
      showmessage('�������벻����...');
      edtValue.SetFocus;
      Button3.Enabled := True;
      exit;
    end
    else
    begin
      if grid_add_flag =2 then grid_add_flag := 1;  //�ж�ͨ��������������£������ 1
      sgrid1.Cells[1,sgrid_row]:=edtValue.Text;
      sgrid1.Cells[2,sgrid_row]:=' and '+v_Field_List_EN[ListBox3.ItemIndex]+'='+qrytemp.Fields[0].AsString;
    end;
  end
  else if listbox3.itemindex in [14,15] then
  begin
     if grid_add_flag =2 then grid_add_flag := 1;  //�����жϣ�����������£������ 1
    if  rgType.ItemIndex = 0 then
    begin
      sgrid1.Cells[1,sgrid_row]:=' like '+edtValue.Text;
      sgrid1.Cells[2,sgrid_row]:=' and '+v_Field_List_EN[ListBox3.ItemIndex]+' LIKE ''''%'+edtValue.Text+'%'''' ';
    end else begin
      sgrid1.Cells[1,sgrid_row]:=' = '+edtValue.Text;
      sgrid1.Cells[2,sgrid_row]:=' and '+v_Field_List_EN[ListBox3.ItemIndex]+' = '''''+edtValue.Text+'''''  ' ;
    end;
  end
  else if ListBox3.ItemIndex in [18] then
  begin
    if grid_add_flag =2 then grid_add_flag := 1;  //�����жϣ�����������£������ 1
    if  rgType.ItemIndex = 0 then
    begin
      sgrid1.Cells[1,sgrid_row]:=' like '+ cbbJS.Text;
      sgrid1.Cells[2,sgrid_row]:=' and '+v_Field_List_EN[ListBox3.ItemIndex]+' LIKE ''''%'+ cbbJS.Text+'%'''''
    end else begin
      sgrid1.Cells[1,sgrid_row]:=' = '+ cbbJS.Text;
      sgrid1.Cells[2,sgrid_row]:=' and '+v_Field_List_EN[ListBox3.ItemIndex]+' = '''''+edtValue.Text+''''' ' ;
    end;
  end
  else if listbox3.itemindex in [16] then
  begin
     if grid_add_flag =2 then grid_add_flag := 1;  //�����жϣ�����������£������ 1
    if  rgType.ItemIndex = 0 then
    begin
      sgrid1.Cells[1,sgrid_row]:=' = '+edtValue.Text;
      sgrid1.Cells[2,sgrid_row]:=' and '+v_Field_List_EN[ListBox3.ItemIndex]+' = '+edtValue.Text;
    end
    else
    if    rgType.ItemIndex = 1 then
    begin
      sgrid1.Cells[1,sgrid_row]:=' <> '+edtValue.Text;
      sgrid1.Cells[2,sgrid_row]:=' and '+v_Field_List_EN[ListBox3.ItemIndex]+' <> '+edtValue.Text;
    end
    else
    if  rgType.ItemIndex = 2 then
    begin
       sgrid1.Cells[1,sgrid_row]:=' > '+edtValue.Text;
      sgrid1.Cells[2,sgrid_row]:=' and '+v_Field_List_EN[ListBox3.ItemIndex]+' > '+edtValue.Text;
    end;
    end
  else
  begin
     if grid_add_flag =2 then grid_add_flag := 1;  //�����жϣ�����������£������ 1
    sgrid1.Cells[1,sgrid_row]:=rgType.Items[rgType.itemindex];
    if ((listbox3.itemindex = 9) or (listbox3.itemindex = 10)) and (rgType.ItemIndex = 1 ) then //��ҵ������,0����,
      sgrid1.Cells[2,sgrid_row]:=' and '+v_Field_List_EN[ListBox3.ItemIndex]+' >0 '
    else 
      sgrid1.Cells[2,sgrid_row]:=' and '+v_Field_List_EN[ListBox3.ItemIndex]+' = ' +IntToStr(rgType.ItemIndex);
  end;
  if ListBox3.ItemIndex=19 then
  begin
   if grid_add_flag =2 then grid_add_flag := 1;  //�����жϣ�����������£������
      sgrid1.Cells[1,sgrid_row]:=ComboBox3.Text+edit1.Text;
      sgrid1.Cells[2,sgrid_row]:=' and '+v_Field_List_EN[ListBox3.ItemIndex]+combobox3.Text+edit1.Text;
  end;
  sgrid1.Cells[0,sgrid_row]:=listbox3.Items[listbox3.itemindex];
 end;
 
procedure TfrmQry.Button4Click(Sender: TObject);
var i:byte;
begin
 if sgrid1.RowCount <= 2 then exit;
 for i:=sgrid1.Row to sgrid1.RowCount-2 do
  sgrid1.Rows[i].Text:=sgrid1.Rows[i+1].Text;
 sgrid1.RowCount:=sgrid1.RowCount-1;
end;

procedure TfrmQry.ListBox3Click(Sender: TObject);
begin
 //ShowMessage(IntToStr(ListBox3.ItemIndex));  ������16
  edtValue.Text:='';
  BitBtn6.visible := listbox3.ItemIndex in[2,4,7,12,13,14,17];
  cbbJS.Visible:= ListBox3.ItemIndex = 18;
  Panel3.Visible:=ListBox3.ItemIndex=19;
  if ListBox3.ItemIndex=19 then Edit1.SetFocus;
//  (listbox3.ItemIndex = 2) or (listbox3.ItemIndex = 4)
//                 or (listbox3.ItemIndex = 7) or (listbox3.ItemIndex = 12);
  edtValue.Visible := (listbox3.ItemIndex <8) or (listbox3.ItemIndex in [12,13,14,15,16,17]);
 // rgType.Visible := not edtValue.Visible;
  rgType.Visible:= True;


  if  listbox3.ItemIndex<8 then
  begin
    rgType.Items.Clear;
    rgType.Items.Add('����');
    rgType.Items.Add('����');
    rgType.ItemIndex := 1;
  end else
  if listbox3.ItemIndex=8 then
  begin
    rgType.Items.Clear;
    rgType.Items.Add('����Ͷ��');
    rgType.Items.Add('����Ͷ��');
    rgType.Items.Add('��MRB��Ͷ');
    rgType.Items.Add('��MRB����');
    rgType.Items.Add('�����Ͷ��');
    rgType.ItemIndex := 0;
  end
  else if listbox3.ItemIndex=9 then
  begin
    rgType.Items.Clear;
    rgType.Items.Add('����');
    rgType.Items.Add('����');
    rgType.ItemIndex := 0;
  end
  else if listbox3.ItemIndex=10 then
  begin
    rgType.Items.Clear;
    rgType.Items.Add('���');
    rgType.Items.Add('�ڲ�');
    rgType.ItemIndex := 0;
  end
  else if listbox3.ItemIndex=11 then
  begin
    rgType.Items.Clear;
    rgType.Items.Add('����');
    rgType.Items.Add('����');
    rgType.ItemIndex := 0;
  end
  else if listbox3.ItemIndex in[12,13] then
  begin
    rgType.Visible:= False;
  end
  else if listbox3.ItemIndex in [14,15] then
  begin
    rgType.Items.Clear;
    rgType.Items.Add('����');
    rgType.Items.Add('����');
    rgType.ItemIndex := 0;
  end
  else if listbox3.ItemIndex in [16] then
  begin
    rgType.Items.Clear;
    rgType.Items.Add('����=');
    rgType.Items.Add('������<>');
    rgType.Items.Add('����>');
    rgType.ItemIndex := 0;
  end
  else if ListBox3.ItemIndex in [18] then
  begin

    cbbJS.Items.Clear;
    cbbJS.Style:=csDropDown;
    qrytemp.Close;
    qrytemp.SQL.Text:='select data0338.tvalue from data0278 inner join data0338 on data0278.Rkey=data0338.parameter_ptr where  data0278.SPEC_RKEY=''js''';
    qrytemp.Open;
    while not qrytemp.Eof do
    begin
      cbbJS.Items.Add(qrytemp.FieldBYName('tvalue').AsString);
     qrytemp.Next;
    end;
    cbbJS.ItemIndex:=-1;
  end;

  Label8.Caption := listbox3.Items[listbox3.ItemIndex];
end;

procedure TfrmQry.edtValueKeyPress(Sender: TObject; var Key: Char);
begin
  if key=#13 then
    Button3Click(sender);
end;

procedure TfrmQry.BitBtn6Click(Sender: TObject);
  var InputVar: PDlgInput ;
      s:string;
begin
  frmPick_Item_Single:=TfrmPick_Item_Single.Create(nil);
  try
    case ListBox3.ItemIndex of
      2: begin
          InputVar.Fields := 'Dept_Code/�������/120,Dept_Name/��������/250';
          InputVar.Sqlstr := 'select rKey,Dept_Code,Dept_Name from data0034 where ttype=''1'' ORDER by dept_code';
          inputvar.KeyField:='Dept_Code';
         end;
      4: begin
          InputVar.Fields := 'PROD_code/��Ʒ���/120,Product_name/��Ʒ����/250';
          InputVar.Sqlstr := 'select rKey,PROD_code,Product_name from data0008 order by PROD_code';
          inputvar.KeyField:='PROD_code';
         end;
      7: begin
          InputVar.Fields := 'Cust_Code/�ͻ�����/120,ABBR_NAME/�ͻ����/250';
          InputVar.Sqlstr := 'select rKey,Cust_Code,ABBR_NAME,Customer_name from data0010 order by Cust_Code';
          inputvar.KeyField:='Cust_Code';
         end;
      12:begin
          InputVar.Fields := 'warehouse_code/��������/80,warehouse_name/��������/200,ABBR_NAME/�������/150';
          InputVar.Sqlstr :='select rkey,(warehouse_code+''      '') as warehouse_code,warehouse_name,ABBR_NAME from data0015';
          inputvar.KeyField:='';
         end;
      13:begin
          InputVar.Fields := 'warehouse_code/��������/80,warehouse_name/��������/200,ABBR_NAME/�������/150';
          InputVar.Sqlstr :='select rkey,(warehouse_code+''      '') as warehouse_code,warehouse_name,ABBR_NAME from data0015';
          inputvar.KeyField:='';
         end;
     14: begin
          InputVar.Fields := 'Cust_Code/�ͻ�����/120,ABBR_NAME/�ͻ����/250';
          InputVar.Sqlstr := 'select rKey,Cust_Code,ABBR_NAME,Customer_name from data0010 order by Cust_Code';
          inputvar.KeyField:='Cust_Code';
         end;
     17: begin
          InputVar.Fields := 'PR_GRP_CODE/�����/120,PRODUCT_GROUP_NAME/�������/250';
          InputVar.Sqlstr := 'select rKey,PR_GRP_CODE,PRODUCT_GROUP_NAME from data0007 order by PR_GRP_CODE';
          inputvar.KeyField:='PROD_code';
         end;
    end;

    InputVar.AdoConn := dm.con1 ;
    frmPick_Item_Single.InitForm_New(InputVar);
    if frmPick_Item_Single.ShowModal=mrok then
    case ListBox3.ItemIndex of
       2:edtValue.Text:=frmPick_Item_Single.adsPick.fieldbyname('Dept_Code').AsString;
       4:edtValue.Text:=frmPick_Item_Single.adsPick.fieldbyname('PROD_code').AsString;
       7:edtValue.Text:=frmPick_Item_Single.adsPick.fieldbyname('Cust_Code').AsString;
      12:edtValue.Text:=frmPick_Item_Single.adsPick.fieldbyname('warehouse_code').AsString;
      13:edtValue.Text:=frmPick_Item_Single.adsPick.fieldbyname('warehouse_code').AsString;
      14:edtValue.Text:=frmPick_Item_Single.adsPick.fieldbyname('ABBR_NAME').AsString;
      17:edtValue.Text:=frmPick_Item_Single.adsPick.fieldbyname('PR_GRP_CODE').AsString;
    end;
  finally
    frmPick_Item_Single.Free;
  end;

  button3.Enabled:= trim(edtValue.Text) <> '';
end;

procedure TfrmQry.FormCreate(Sender: TObject);
var i:integer;
begin
  v_Field_List_CN :=
  VarArrayOf(['��ҵ����','�������','�������','�ͻ��ͺ�','��Ʒ����',
  '���ϵ���','�������','�ͻ�����','Ͷ������','����״̬',
  '��/���','��Ʒ����','Ͷ����������','��ǰ����','����ԭ�ͻ�',
  '���Գ��ͱ�ע','����','��Ʒ���','��Ʒ����','�������']);
  v_Field_List_EN := VarArrayOf(['d06.work_order_number','d25.MANU_PART_NUMBER','d34.dept_code',
   'd25.Manu_Part_Desc','D08.Prod_Code','D06.CUT_NO','D492.SO_NO','D10.CUST_Code','D492.TType','ISNULL(D56.WType,0)',
   'ISNULL(D25.Parent_ptr,0)','d25.ttype','D492.whouse_ptr','D56.LOC_PTR','D25.ORIG_CUSTOMER','D25.SAMPLE_NR',
   'd25.layers','D07.PR_GRP_CODE','d25.CPJS','d60.parts_ordered * d25.unit_sq']);

  for i:= VarArrayLowBound(v_Field_List_CN,1) to VarArrayHighBound(v_Field_List_CN,1) do
    listbox3.Items.Add(v_Field_List_CN[i]);
  sgrid1.Cells[0,0]:='������';
  sgrid1.Cells[1,0]:='����ֵ';

  ListBox3.ItemIndex := 0;
  ListBox3Click(sender);
  rgType.ItemIndex:=1;

end;

end.
