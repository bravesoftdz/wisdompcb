unit QuerySet;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, StdCtrls, Buttons, Grids, Menus, Spin,DateUtils;

type
  TfrmQuerySet = class(TForm)
    StaticText2: TStaticText;
    SGrid1: TStringGrid;
    GroupBox6: TGroupBox;
    Label8: TLabel;
    edtValue: TEdit;
    btnAdd: TButton;
    BitBtn6: TBitBtn;
    ListBox3: TListBox;
    StaticText7: TStaticText;
    btnOK: TButton;
    btnCancel: TButton;
    btnClear: TButton;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    cbbconfirm: TComboBox;
    rg1: TRadioGroup;
    procedure BitBtn6Click(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure ListBox3Click(Sender: TObject);
    procedure edtValueKeyPress(Sender: TObject; var Key: Char);
    procedure btnClearClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure SGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure rg1Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
  private
    { Private declarations }
    v_Field_List_CN,v_Field_List_EN:Variant;
     procedure update_sgrid(sgrid_row:byte);
  public
    { Public declarations }
    selecttrue :Boolean;
  end;

var
  frmQuerySet: TfrmQuerySet;

implementation
uses
  common,Main, damo,Pick_Item_Single,ConstVar, DB;
{$R *.dfm}

procedure TfrmQuerySet.BitBtn6Click(Sender: TObject);
var InputVar: PDlgInput ;
begin
  frmPick_Item_Single:=TfrmPick_Item_Single.Create(nil);
  try
    case ListBox3.ItemIndex of
    0,1:
      begin
        InputVar.Fields := 'INV_PART_NUMBER/物料编码/180,INV_PART_DESCRIPTION/物料名称及规格/250';
        InputVar.Sqlstr := 'select rKey,INV_PART_NUMBER,INV_PART_DESCRIPTION from data0017  ORDER by INV_PART_NUMBER';
        Inputvar.KeyField:='';
      end;
      2:
      begin
        InputVar.Fields := 'code/供应商代码/80,ABBR_NAME/供应商简写/120,SUPPLIER_NAME/供应商全称/250';
        InputVar.Sqlstr := 'select rkey,code,SUPPLIER_NAME,ABBR_NAME from data0023 order by code';
        Inputvar.KeyField:='code';
      end;
      3:
      begin
        InputVar.Fields := 'CURR_CODE/货币代码/120,CURR_NAME/货币/250';
        InputVar.Sqlstr := 'select rKey,CURR_CODE,CURR_NAME from data0001 ORDER by CURR_CODE';
        Inputvar.KeyField:='CURR_CODE';
      end;
      6:
      begin
        InputVar.Fields := 'USER_LOGIN_NAME/认可人员代码/120,USER_FULL_NAME/认可人员/250';
        InputVar.Sqlstr := 'select rKey,USER_LOGIN_NAME,USER_FULL_NAME from data0073 ORDER by USER_LOGIN_NAME';
        Inputvar.KeyField:='USER_LOGIN_NAME';
      end;
    end;
    InputVar.AdoConn := dm.con1 ;
    frmPick_Item_Single.InitForm_New(InputVar);
    if frmPick_Item_Single.ShowModal=mrok then
    begin
      case ListBox3.ItemIndex of
      0: edtValue.Text:=frmPick_Item_Single.adsPick.fieldbyname('INV_PART_NUMBER').AsString;
      1: edtValue.Text:=frmPick_Item_Single.adsPick.fieldbyname('INV_PART_DESCRIPTION').AsString;
      2: edtValue.Text:=frmPick_Item_Single.adsPick.fieldbyname('ABBR_NAME').AsString;
      3: edtValue.Text:=frmPick_Item_Single.adsPick.fieldbyname('CURR_NAME').AsString;
      6: edtValue.Text:=frmPick_Item_Single.adsPick.fieldbyname('USER_LOGIN_NAME').AsString;
      end;
      //edtValue.Tag:=frmPick_Item_Single.adsPick.fieldbyname('rKey').AsInteger;
    end;
  finally
    frmPick_Item_Single.Free;
  end;
end;

procedure TfrmQuerySet.update_sgrid(sgrid_row: byte);
begin
  sgrid1.Cells[0,sgrid_row]:=listbox3.Items[listbox3.itemindex];
  case ListBox3.ItemIndex of
    0,1,2:
    begin
      if rg1.ItemIndex=0 then
      begin
      sgrid1.Cells[1,sgrid_row]:=' like '+edtValue.Text;
      sgrid1.Cells[2,sgrid_row]:=' and '+v_Field_List_EN[ListBox3.ItemIndex]+' like ''%'+edtValue.Text+'%''';
      end
      else
      begin
      sgrid1.Cells[1,sgrid_row]:=' = '+edtValue.Text;
      sgrid1.Cells[2,sgrid_row]:=' and '+v_Field_List_EN[ListBox3.ItemIndex]+' = '''+edtValue.Text+'''';
      end;
    end;
    3,6:
    begin
      sgrid1.Cells[1,sgrid_row]:=' = '+edtValue.Text;
      sgrid1.Cells[2,sgrid_row]:=' and '+v_Field_List_EN[ListBox3.ItemIndex]+' = '''+edtValue.Text+'''';
    end;
    4:
    begin
      sgrid1.Cells[1,sgrid_row]:=' = '+cbbconfirm.Text;
      if cbbconfirm.Text='已认可' then
      sgrid1.Cells[2,sgrid_row]:=' and '+v_Field_List_EN[ListBox3.ItemIndex]+' = '+QuotedStr('Y');
      if cbbconfirm.Text='未认可' then
      sgrid1.Cells[2,sgrid_row]:=' and '+v_Field_List_EN[ListBox3.ItemIndex]+' = '+QuotedStr('N');
      if cbbconfirm.Text='暂时认可' then
      sgrid1.Cells[2,sgrid_row]:=' and '+v_Field_List_EN[ListBox3.ItemIndex]+' = '+QuotedStr('T');
    end;
    5:
    begin
      sgrid1.Cells[1,sgrid_row]:=' = '+cbbconfirm.Text;
      if cbbconfirm.Text='是' then
      sgrid1.Cells[2,sgrid_row]:=' and '+v_Field_List_EN[ListBox3.ItemIndex]+' = '+QuotedStr('Y');
      if cbbconfirm.Text='否' then
      sgrid1.Cells[2,sgrid_row]:=' and '+v_Field_List_EN[ListBox3.ItemIndex]+' = '+QuotedStr('N');
    end;
  end;

end;

procedure TfrmQuerySet.btnAddClick(Sender: TObject);
var i:byte;
begin
  if (listbox3.itemindex<>4) and (listbox3.itemindex<>5) and (Trim(edtValue.Text)='') then exit;
  for i:=1 to sgrid1.RowCount-2 do
  if sgrid1.Cells[0,i]=listbox3.Items[listbox3.itemindex] then
  begin
     update_sgrid(i);
     exit;
  end;
  update_sgrid(sgrid1.RowCount-1);
  sgrid1.RowCount:=sgrid1.RowCount+1;
end;

procedure TfrmQuerySet.ListBox3Click(Sender: TObject);
begin
  edtValue.Text:='';
  BitBtn6.visible := (ListBox3.ItemIndex <> 4) and (ListBox3.ItemIndex <> 5);
  edtValue.Visible := (ListBox3.ItemIndex <> 4) and (ListBox3.ItemIndex <> 5);
  cbbconfirm.Visible :=(ListBox3.ItemIndex=4) or (ListBox3.ItemIndex=5);
  Label8.Caption := listbox3.Items[listbox3.ItemIndex]+':';
  edtValue.ReadOnly := (ListBox3.ItemIndex = 3) or (ListBox3.ItemIndex = 6);
  rg1.Visible :=(ListBox3.ItemIndex = 0) or (ListBox3.ItemIndex = 1) or (ListBox3.ItemIndex = 2);
  rg1.ItemIndex :=0;
  if ListBox3.ItemIndex=4 then
  begin
    cbbconfirm.Items.Clear;
    cbbconfirm.Items.Add('已认可');
    cbbconfirm.Items.Add('未认可');
    cbbconfirm.Items.Add('暂时认可');
    cbbconfirm.ItemIndex := 0;
  end
  else
  if ListBox3.ItemIndex=5 then
  begin
    cbbconfirm.Items.Clear;
    cbbconfirm.Items.Add('是');
    cbbconfirm.Items.Add('否');
    cbbconfirm.ItemIndex := 0;
  end;
end;

procedure TfrmQuerySet.edtValueKeyPress(Sender: TObject; var Key: Char);
begin
  if key=#13 then
  btnAddClick(Sender);
end;

procedure TfrmQuerySet.btnClearClick(Sender: TObject);
var i:integer;
begin
  for i:=1 to sgrid1.RowCount-1 do
  sgrid1.Rows[i].Clear;
  SGrid1.Row := 1;
  sgrid1.RowCount:=2;
end;

procedure TfrmQuerySet.FormCreate(Sender: TObject);
var i:integer;
begin
  v_Field_List_CN := VarArrayOf(['物料编码','物料名称及规格','供应商简写','货币','认可标记','需要认可的材料项目','认可人员']);
  v_Field_List_EN := VarArrayOf(['Data0017.INV_PART_NUMBER','Data0017.INV_PART_DESCRIPTION',
  'Data0023.ABBR_NAME','Data0001.CURR_NAME','Data0028.AVL_FLAG','Data0017.AVL_FLAG','DATA0073_1.USER_LOGIN_NAME']);
  for i:= VarArrayLowBound(v_Field_List_CN,1) to VarArrayHighBound(v_Field_List_CN,1) do
  listbox3.Items.Add(v_Field_List_CN[i]);
  sgrid1.Cells[0,0]:='条件名';
  sgrid1.Cells[1,0]:='条件值';
  ListBox3.ItemIndex := 0;
end;

procedure TfrmQuerySet.SGrid1SelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  CanSelect:=(ARow>0) and (ARow<SGrid1.RowCount-1);
end;

procedure TfrmQuerySet.rg1Click(Sender: TObject);
begin
  if rg1.ItemIndex=1 then
  begin
    edtValue.ReadOnly :=(ListBox3.ItemIndex = 0)or (ListBox3.ItemIndex = 1)
                     or (ListBox3.ItemIndex = 2) or (ListBox3.ItemIndex = 3)
                     or (ListBox3.ItemIndex = 6);
    edtValue.Text:='';
  end
  else
  begin
   edtValue.ReadOnly :=False;
   edtValue.ReadOnly := (ListBox3.ItemIndex = 3) or (ListBox3.ItemIndex = 6);
  end;


end;

procedure TfrmQuerySet.N1Click(Sender: TObject);
var
  i:integer;
begin
  if sgrid1.RowCount <= 2 then exit;
  for i:=sgrid1.Row to sgrid1.RowCount-2 do
  sgrid1.Rows[i].Text:=sgrid1.Rows[i+1].Text;
  sgrid1.RowCount:=sgrid1.RowCount-1;
  if SGrid1.Row =SGrid1.RowCount-1 then
  SGrid1.Row :=1;      //如果删除的是最后一行，则选中第一行
end;

end.
