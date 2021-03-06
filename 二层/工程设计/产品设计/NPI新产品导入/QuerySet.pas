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
    rg1: TRadioGroup;
    DateTimePicker3: TDateTimePicker;
    DateTimePicker4: TDateTimePicker;
    DateTimePicker5: TDateTimePicker;
    DateTimePicker6: TDateTimePicker;
    Label3: TLabel;
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
  common, damo,Pick_Item_Single,ConstVar, DB;
{$R *.dfm}

procedure TfrmQuerySet.FormCreate(Sender: TObject);
var i:integer;
begin
  v_Field_List_CN := VarArrayOf(['NPI编号','评审主题','本厂编号','客户型号','创建人工号','提交评审日期','最后评审通过日期','产品类别代码','评审流程代码','层数']);
  v_Field_List_EN := VarArrayOf(['data0600.NPI_NUMBER','data0600.NIP_NAME','data0025.MANU_PART_NUMBER','Data0025.MANU_PART_DESC',
  'Data0005.EMPL_CODE','DATA0600.submit_date','DATA0600.auth_date','Data0008.PROD_CODE','data0600.v_ttype', 'Data0025.LAYERS']);
  for i:= VarArrayLowBound(v_Field_List_CN,1) to VarArrayHighBound(v_Field_List_CN,1) do
  listbox3.Items.Add(v_Field_List_CN[i]);
  sgrid1.Cells[0,0]:='条件名';
  sgrid1.Cells[1,0]:='条件值';
  ListBox3.ItemIndex := 0;
//  DateTimePicker1.Date:=common.getsystem_date(dm.tmp,0)-7;
//  DateTimePicker2.Date:=common.getsystem_date(dm.tmp,0);
  BitBtn6.Visible := False;
end;

procedure TfrmQuerySet.BitBtn6Click(Sender: TObject);
var
  InputVar: PDlgInput ;
begin
  frmPick_Item_Single:=TfrmPick_Item_Single.Create(nil);
  try
    case ListBox3.ItemIndex of
      2,3:
      begin
        InputVar.Fields := 'manu_part_number/本厂编号/100,manu_part_desc/客户型号/150,ANALYSIS_CODE_2/客户物料号/150,abbr_name/工厂简称/100';
        InputVar.Sqlstr := 'select data0025.rkey,data0025.manu_part_number,data0025.manu_part_desc,'+
        'data0025.ANALYSIS_CODE_2,data0015.abbr_name'+
        ' from data0025 inner join data0015 on data0025.PROD_ROUTE_PTR=data0015.rkey '+
        ' where data0025.parent_ptr is null and tstatus=1 order by manu_part_number';
        inputvar.KeyField := 'manu_part_number';
      end;
      4:
      begin
        InputVar.Fields := 'EMPL_CODE/人员代码/150,EMPLOYEE_NAME/人员名称/200';
        InputVar.Sqlstr := 'select rkey,EMPL_CODE,EMPLOYEE_NAME from data0005 order by EMPL_CODE';
        Inputvar.KeyField:='EMPL_CODE';
      end;

      7:
      begin
        InputVar.Fields := 'PROD_CODE/产品类别代码/150,PRODUCT_NAME/产品类别名称/200';
        InputVar.Sqlstr := 'SELECT  RKEY, PROD_CODE, PRODUCT_NAME FROM dbo.Data0008 order by PROD_CODE';
        Inputvar.KeyField:='PROD_CODE';
      end;
    end;
    InputVar.AdoConn := dm.ADOConnection1 ;
    frmPick_Item_Single.InitForm_New(InputVar);
    if frmPick_Item_Single.ShowModal=mrok then
    begin
      case ListBox3.ItemIndex of
      2:edtValue.Text:=frmPick_Item_Single.adsPick.fieldbyname('manu_part_number').AsString;
      3:edtValue.Text:=frmPick_Item_Single.adsPick.fieldbyname('manu_part_desc').AsString;
      4: edtValue.Text:=frmPick_Item_Single.adsPick.fieldbyname('EMPL_CODE').AsString;
      7: edtValue.Text := frmPick_Item_Single.adsPick.fieldbyname('PROD_CODE').AsString;
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
    0,1,2,3,8:
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
    4,7,9:
    begin
      sgrid1.Cells[1,sgrid_row]:=' = '+edtValue.Text;
      sgrid1.Cells[2,sgrid_row]:=' and '+v_Field_List_EN[ListBox3.ItemIndex]+' = '''+edtValue.Text+'''';
    end;
    5,6:
    begin
      SGrid1.Cells[1,sgrid_row]:=Label8.Caption+DateToStr(DateTimePicker3.Date)+FormatDateTime(' HH:mm:ss',DateTimePicker4.Time)+
      Label3.Caption+DateToStr(DateTimePicker5.Date)+FormatDateTime(' HH:mm:ss',DateTimePicker6.Time);
 
//      SGrid1.Cells[2,sgrid_row]:=' and Data0417.user_date>='+quotedstr(formatdatetime('YYYY-MM-DD',dtpk1.Date))+
//                                ' and Data0417.user_date<= '+quotedstr(formatdatetime('YYYY-MM-DD',dtpk2.Date+1));
      SGrid1.Cells[2,sgrid_row]:=' and '+v_Field_List_EN[ListBox3.ItemIndex]+'>=('+quotedstr(DateToStr(DateTimePicker3.Date)+
      FormatDateTime(' HH:mm:ss',DateTimePicker4.Time))+ ') and '+v_Field_List_EN[ListBox3.ItemIndex]+'<=('+
      quotedstr(DateToStr(DateTimePicker5.Date)+ FormatDateTime(' HH:mm:ss',DateTimePicker6.Time))+')';

    end;
  end;
end;

procedure TfrmQuerySet.btnAddClick(Sender: TObject);
var i:byte;
begin
  if (listbox3.itemindex<>5) and (listbox3.itemindex<>6) and (Trim(edtValue.Text)='') then exit;
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
  BitBtn6.visible := (ListBox3.ItemIndex = 2) or (ListBox3.ItemIndex = 3) or
                   (ListBox3.ItemIndex = 4) or (ListBox3.ItemIndex = 7) ;
  edtValue.ReadOnly := (ListBox3.ItemIndex = 4) or (ListBox3.ItemIndex = 7);
  edtValue.Visible:= (ListBox3.ItemIndex <> 5) and (ListBox3.ItemIndex <> 6) ;
  rg1.Visible := (ListBox3.ItemIndex <> 4) and (ListBox3.ItemIndex <> 5) and (ListBox3.ItemIndex <> 6) and
      (ListBox3.ItemIndex <> 7) and (ListBox3.ItemIndex <> 9);
  rg1.ItemIndex :=0;
  DateTimePicker3.Date := getsystem_date(DM.tmp,1);
  DateTimePicker4.Time := getsystem_date(DM.tmp,0);
  DateTimePicker5.Date := getsystem_date(DM.tmp,1);
  DateTimePicker6.Time := getsystem_date(DM.tmp,0);
  DateTimePicker3.Visible := (ListBox3.ItemIndex=5) or (ListBox3.ItemIndex=6) ;
  DateTimePicker4.Visible := (ListBox3.ItemIndex=5) or (ListBox3.ItemIndex=6) ;
  DateTimePicker5.Visible := (ListBox3.ItemIndex=5) or (ListBox3.ItemIndex=6) ;
  DateTimePicker6.Visible := (ListBox3.ItemIndex=5) or (ListBox3.ItemIndex=6) ;
  if (ListBox3.ItemIndex=5) or (ListBox3.ItemIndex=6)  then
    Label8.Caption :='从'
  else
    Label8.Caption := listbox3.Items[listbox3.ItemIndex]+':';
  Label3.Caption := '到';
  Label3.Visible :=(ListBox3.ItemIndex=5) or (ListBox3.ItemIndex=6) ;
  
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

procedure TfrmQuerySet.SGrid1SelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  CanSelect:=(ARow>0) and (ARow<SGrid1.RowCount-1);
end;

procedure TfrmQuerySet.rg1Click(Sender: TObject);
begin
 // if ListBox3.ItemIndex <> 11 then
  if rg1.ItemIndex=1 then
  begin
    edtValue.ReadOnly :=(ListBox3.ItemIndex = 2)or (ListBox3.ItemIndex = 3) or (ListBox3.ItemIndex = 4)
    or (ListBox3.ItemIndex = 7);
    edtValue.Text:='';
  end
  else
  begin
   edtValue.ReadOnly :=False;
   edtValue.ReadOnly := (ListBox3.ItemIndex = 4) or (ListBox3.ItemIndex = 7) ;
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
