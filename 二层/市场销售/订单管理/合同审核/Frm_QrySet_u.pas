unit Frm_QrySet_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, StdCtrls, Buttons, Grids, Menus;

type
  TFrm_QrySet = class(TForm)
    StaticText2: TStaticText;
    SGrid1: TStringGrid;
    GroupBox6: TGroupBox;
    Label8: TLabel;
    Button3: TButton;
    ListBox3: TListBox;
    StaticText7: TStaticText;
    Button1: TButton;
    Button2: TButton;
    Button4: TButton;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    DateTimePicker1: TDateTimePicker;
    Label2: TLabel;
    DateTimePicker2: TDateTimePicker;
    Label1: TLabel;
    BitBtn7: TBitBtn;
    edtValue: TComboBox;
    procedure Button3Click(Sender: TObject);
    procedure ListBox3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure SGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure edtValueChange(Sender: TObject);

 
  private
    v_Field_List_CN,v_Field_List_EN:Variant;
  public
    { Public declarations }
  end;

var Frm_QrySet:TFrm_QrySet;
implementation

uses common,demo,Pick_Item_Single,ConstVar;
{$R *.dfm}

procedure TFrm_QrySet.Button3Click(Sender: TObject);
var
 i:integer;
 Require_str : string;
begin
  if edtValue.Visible and (trim(edtValue.Text)='') then exit;

  for i:=1 to sgrid1.RowCount-2 do
  if sgrid1.Cells[0,i]=listbox3.Items[listbox3.itemindex] then  exit;

  sgrid1.Cells[0,sgrid1.RowCount-1]:=listbox3.Items[listbox3.itemindex];
  sgrid1.Cells[1,sgrid1.RowCount-1]:=edtValue.Text;
  Require_str := string(edtValue.Items.Objects[edtValue.ItemIndex]);
  case listbox3.ItemIndex of
  0,1:
  sgrid1.Cells[2,sgrid1.RowCount-1]:=' and '+v_Field_List_EN[ListBox3.ItemIndex]+' like ''%'+edtValue.Text+'%''';
  2:
  sgrid1.Cells[2,sgrid1.RowCount-1]:=' and '+v_Field_List_EN[ListBox3.ItemIndex]+'= '+inttostr(edtValue.Tag);
  3:
  sgrid1.Cells[2,sgrid1.RowCount-1]:=' and '+v_Field_List_EN[ListBox3.ItemIndex]+ Require_str ;
  end;
  sgrid1.RowCount:=sgrid1.RowCount+1;

end;


procedure TFrm_QrySet.ListBox3Click(Sender: TObject);
var Require_str : string;
begin
  Label8.Caption := listbox3.Items[listbox3.ItemIndex];
  BitBtn7.Visible:=listbox3.ItemIndex in [1,2] ;
if listbox3.ItemIndex<>3 then
  begin
   edtValue.Style:=csSimple;
   edtValue.Text:='' ;
   Button3.Enabled:=false;
   if listbox3.ItemIndex=2 then
    edtvalue.enabled:=false;
  end
  else
  begin
    edtValue.Style:=csDropDownList;
    edtvalue.enabled:=true;
    edtValue.Items.Clear;
    Require_str := ' =0 and circle=1';
    edtValue.Items.AddObject('未提交',Tobject(Require_str));
    Require_str := '%2=0 and circle>1 ';
    edtValue.Items.AddObject('第五审未通过，需再提交',Tobject(Require_str));
    Require_str := ' between 1 and 31  and  check_status%2<>0  ';
    edtValue.Items.AddObject('联审中',Tobject(Require_str));
    Require_str := '/2%2=0 and check_status<>0 ';
        edtValue.Items.AddObject('待一审',Tobject(Require_str));
    Require_str := '/4%2=0 and check_status<>0 ';
        edtValue.Items.AddObject('待二审',Tobject(Require_str));
    Require_str := '/8%2=0 and check_status<>0 ';
        edtValue.Items.AddObject('待三审',Tobject(Require_str));
    Require_str := '/16%2=0 and check_status<>0 ';
        edtValue.Items.AddObject('待四审',Tobject(Require_str));
    Require_str := '/32%2=0 and check_status<>0 ';
        edtValue.Items.AddObject('待五审',Tobject(Require_str));
    Require_str := ' between 32 and 62  and  check_status%2<>0  ';
    edtValue.Items.AddObject('第五审已通过，待',Tobject(Require_str));
    Require_str := ' =63 ';
    edtValue.Items.AddObject('通过全部审核',Tobject(Require_str));
    Require_str := ' >63 or check_status<0 ';
    edtValue.Items.AddObject('未识别状态',Tobject(Require_str));

    edtValue.ItemIndex:=0;
    Button3.Enabled:=true;
  end;

end;

procedure TFrm_QrySet.Button4Click(Sender: TObject);
var
 i:byte;
begin
  if (sgrid1.RowCount <= 2) or (sgrid1.Row=sgrid1.RowCount-1) then exit;
  for i:=sgrid1.Row to sgrid1.RowCount-2 do sgrid1.Rows[i].Text:=sgrid1.Rows[i+1].Text;
  sgrid1.RowCount:=sgrid1.RowCount-1;
end;

procedure TFrm_QrySet.SGrid1SelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  CanSelect:=(ARow>0) and (ARow<SGrid1.RowCount-1);
end;

procedure TFrm_QrySet.FormCreate(Sender: TObject);
var i:integer;
begin
  v_Field_List_CN := VarArrayOf(['合同编号','甲方（客户）名称','送审人','状态']);
  v_Field_List_EN := VarArrayOf(['contract_number','part_A_name_ch','submit_person','check_status']);
  for i:= VarArrayLowBound(v_Field_List_CN,1) to VarArrayHighBound(v_Field_List_CN,1) do
    listbox3.Items.Add(v_Field_List_CN[i]);
  sgrid1.Cells[0,0]:='条件名';
  sgrid1.Cells[1,0]:='条件值';
  ListBox3.ItemIndex := 0;
  DateTimePicker1.Date:=date-60; DateTimePicker2.Date:=date;
end;

procedure TFrm_QrySet.BitBtn7Click(Sender: TObject);
var
  InputVar: PDlgInput ;
begin
 frmPick_Item_Single:=TfrmPick_Item_Single.Create(nil);
 try
  case ListBox3.ItemIndex of
    1:
    begin
      InputVar.Fields := 'CUST_CODE/客户编号/100,CUSTOMER_NAME/甲方（客户）名称/150,';
      InputVar.Sqlstr :='SELECT CUST_CODE,CUSTOMER_NAME '+
                        ' FROM dbo.Data0010  order by CUST_CODE';
      inputvar.KeyField:='CUSTOMER_NAME';
    end;
   2:
    begin
      InputVar.Fields := 'EMPL_CODE/送审人代码/200,EMPLOYEE_NAME/送审人名称/250';
      InputVar.Sqlstr :='SELECT RKEY, EMPL_CODE, EMPLOYEE_NAME FROM Data0005 order by 2';
      inputvar.KeyField:='RKEY';
    end;
  end;
  InputVar.AdoConn :=dm.ADOConnection1 ;
  frmPick_Item_Single.InitForm_New(InputVar);

    if frmPick_Item_Single.ShowModal=mrok then
    begin
     case ListBox3.ItemIndex of
       1: edtValue.Text := frmPick_Item_Single.adsPick.FieldValues['CUSTOMER_NAME'];
       2:
       begin
       edtValue.Text := frmPick_Item_Single.adsPick.FieldValues['EMPL_CODE'];
       edtvalue.Tag :=  frmPick_Item_Single.adsPick.Fieldbyname('RKEY').AsInteger;
       end;
     end;
     Button3.Enabled := true ;
    end;
  finally
    frmPick_Item_Single.adsPick.Close;
    frmPick_Item_Single.Free ;
  end;
end;

procedure TFrm_QrySet.edtValueChange(Sender: TObject);
begin
  Button3.Enabled:=edtValue.Text<>'';
end;




end.
