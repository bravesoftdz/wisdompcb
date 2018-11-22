unit flowpara_edit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, DBCtrls, Grids, DBGrids, Mask,
  Menus, DB,ADODB, ComCtrls, DBGridEh;

type
  TForm_flowpara = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    BitBtn1: TBitBtn;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    Label2: TLabel;
    DBText1: TDBText;
    Label3: TLabel;
    DBEdit3: TDBEdit;
    DBText2: TDBText;
    DBEdit4: TDBEdit;
    Label4: TLabel;
    DBMemo1: TDBMemo;
    DBNavigator1: TDBNavigator;
    DBEdit5: TDBEdit;
    Label5: TLabel;
    DBCheckBox1: TDBCheckBox;
    CheckBox1: TCheckBox;
    Label6: TLabel;
    DBEdit6: TDBEdit;
    Label7: TLabel;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    pnl1: TPanel;
    mmograde_note: TDBMemo;
    lbl1: TLabel;
    pgc1: TPageControl;
    tsParam: TTabSheet;
    DBGrid1: TDBGrid;
    tsBom: TTabSheet;
    ehBOM: TDBGridEh;
    pm1: TPopupMenu;
    N4: TMenuItem;
    N5: TMenuItem;
    btnBom: TBitBtn;
    procedure CheckBox1Click(Sender: TObject);
    procedure DBNavigator1Click(Sender: TObject; Button: TNavigateBtn);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure DBGrid1ColExit(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure ehBOMCellClick(Column: TColumnEh);
    procedure ehBOMColumns4EditButtonClick(Sender: TObject;
      var Handled: Boolean);
    procedure pgc1Change(Sender: TObject);
    procedure ehBOMColumns0EditButtonClick(Sender: TObject;
      var Handled: Boolean);
    procedure BitBtn1Click(Sender: TObject);
    procedure btnBomClick(Sender: TObject);
    procedure ehBOMColumns3EditButtonClick(Sender: TObject;
      var Handled: Boolean);
  private
    { Private declarations }
   OldGridWnd : TWndMethod;
   ExprStr:string;
   procedure NewGridWnd (var Message : TMessage);
   procedure  get_value(rkey278:integer);

   procedure InheriteParams(DrillPms:boolean);
   function CalcBomPartQty(var ExprStr:string;AStepNumber: Integer;rkey25:Integer):double;//����BOM��������
   function Calc_Eng_Table(rkey, s_Y, s_X, d_Y, d_X: string): variant; //���㹤�̱�
   function Update_Expr_Param_Value(DAtaSet:TCustomADODataSet;var Exprstr:string;AStep: Integer = -1):boolean;
   function Calc_Expr_Parma(var str_Expr: string; AdoConn: TAdoConnection; out Out_Value: double): boolean; //������ʽ��ֵ(�����Ѿ���ֵ)
   function GetSupp(abbname:string):Integer;
  public
    { Public declarations }
    procedure ads494AfterScroll(DataSet: TDataSet);
  end;
type
 TMyDBGrid=class(TDBGrid);

var
  Form_flowpara: TForm_flowpara;

implementation

uses damo, PickEngNote, parameter_search, product_MIDetail,Pick_Item_Single,ConstVar,common,MyClass;

{$R *.dfm}
procedure TForm_flowpara.NewGridWnd(var Message: TMessage);
var
 IsNeg : Boolean;
begin
 if Message.Msg = WM_MOUSEWHEEL then
 begin
   IsNeg := Short(Message.WParamHi) < 0;
   if IsNeg then
     DBGrid1.DataSource.DataSet.MoveBy(1)
   else
     DBGrid1.DataSource.DataSet.MoveBy(-1)
 end
 else
   OldGridWnd(Message);
end;

procedure  TForm_flowpara.get_value(rkey278:integer);
begin
  with dm.ADOQuery1 do
   begin
    close;
    sql.Clear;
    sql.Add('select tvalue from data0338 where parameter_ptr='+inttostr(rkey278));
    open;
   end;
  if not dm.adoquery1.IsEmpty then
   begin
    //DBComboBox1.Items.Clear;
    dbgrid1.Columns[5].PickList.Clear;
    while not dm.adoquery1.eof do
     begin
     // DBComboBox1.Items.Add(trim(dm.adoquery1.FieldValues['tvalue']));
     dbgrid1.Columns[5].PickList.Add(trim(dm.adoquery1.FieldValues['tvalue']));
      dm.adoquery1.Next;
     end;
   end
  else
   //DBComboBox1.Items.Clear;
   dbgrid1.Columns[5].PickList.Clear;
end;

procedure TForm_flowpara.CheckBox1Click(Sender: TObject);
begin
if checkbox1.Checked then
 begin
  dm.ads494.Filter:='step_number='+dm.ADS38STEP_NUMBER.AsString;
  dm.ads26.Filter:='route_step_no='+dm.ADS38STEP_NUMBER.AsString;
  if dbedit4.Enabled then dbgrid1.PopupMenu:=PopupMenu1;
  bitbtn3.Enabled:=true;

 end
else
 begin
  dm.ads494.Filter:='';
  dm.ads26.Filter:='';
  dbgrid1.PopupMenu:=nil;
  bitbtn3.Enabled:=false;
 end;
 DBGrid1.ReadOnly := DM.ads494.IsEmpty;
end;

procedure TForm_flowpara.DBNavigator1Click(Sender: TObject;
  Button: TNavigateBtn);
begin
 CheckBox1Click(sender);
end;

procedure TForm_flowpara.DBGrid1CellClick(Column: TColumn);
begin
if column.Index<5 then dbgrid1.SelectedIndex:=5;
if DBGrid1.DataSource.DataSet.RecNo = 1 then
 self.get_value(dm.ads494PARAMETER_PTR.Value);
end;

procedure TForm_flowpara.DBGrid1ColExit(Sender: TObject);
begin
//If DBGrid1.SelectedField.FieldName = DBComboBox1.DataField then
// DBComboBox1.Visible := false;
end;

procedure TForm_flowpara.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
 with TMyDBGrid(Sender) do
 begin
  if DataLink.ActiveRecord=Row-1 then
   begin
    Canvas.Font.Color:=clWhite;
    Canvas.Brush.Color:=$00800040;
   end
  else
   begin
    Canvas.Brush.Color:=Color;
    Canvas.Font.Color:=Font.Color;
   end;

  if dm.ads494flow_spfc_flag.Value='Y' then
   Canvas.Font.Color := clred;
   
  DefaultDrawColumnCell(Rect,DataCol,Column,State);
 end;
end;

procedure TForm_flowpara.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if (key=40) and        //������¼�ͷ��������һ����¼
  (dm.ads494.RecNo = dm.ads494.RecordCount) then abort;

 if key=45 then abort; //������insert��

 if (key=46) and (ssCtrl in shift) then abort;//��ɾ����¼

{ if (key=112) and
    (dbcombobox1.Visible) and
    (dbcombobox1.Enabled) then
  begin                         //F1����������
   dbcombobox1.SetFocus;
   dbcombobox1.DroppedDown := true;
  end;
  }
end;

procedure TForm_flowpara.DBGrid1KeyPress(Sender: TObject; var Key: Char);
begin
 if dm.ads494DATATYPE.Value='����' then
 if not (key in ['0'..'9','.',#8,#13]) then  //�ж��Ƿ���������
  abort;

{if (key <> chr(9)) then
 begin
  if (DBGrid1.SelectedField.FieldName =DBComboBox1.DataField) and
     (dbcombobox1.Items.Count > 0) and
     (dbcombobox1.Enabled) then
   begin
    DBComboBox1.SetFocus;
    SendMessage(DBComboBox1.Handle,WM_Char,word(Key),0);
   end;
 end;
 }
end;

procedure TForm_flowpara.FormCreate(Sender: TObject);
begin
 OldGridWnd := DBGrid1.WindowProc ;
 DBGrid1.WindowProc := NewGridWnd;
 DM.ads494.AfterScroll := ads494AfterScroll;
end;

procedure TForm_flowpara.BitBtn2Click(Sender: TObject);
begin
frmpickengnote:=tfrmpickengnote.Create(application);
if frmpickengnote.ShowModal=mrok then
begin
 dm.ADS38.Edit;
 dm.ADS38DEF_ROUT_INST.Value:=dm.ADS38DEF_ROUT_INST.Value+
  frmpickengnote.ADOQuery1.fieldbyname('PROD_ROUT_INST').AsString;
 dm.ads38.Post; 
end;
frmpickengnote.Free;
end;

procedure TForm_flowpara.N1Click(Sender: TObject);
var
 spfc_flag:string;
begin
try
 form_parameter:=tform_parameter.Create(application);
 if form_parameter.ShowModal=mrok then
  begin
    if form_parameter.ADOQuery1status3.Value=1 then
    spfc_flag:='Y';
    dm.ads494.AppendRecord([form_parameter.ADOQuery1RKEY.Value,
                            '',
                            dm.ADS38SOURCE_PTR.Value,
                            dm.ADS38STEP_NUMBER.Value,
                            dm.ads494.RecordCount+1,
                            'Y',
                            '',
                            spfc_flag,
                            '']);
  end;
finally
 form_parameter.Free;
end;
  DBGrid1.ReadOnly := DM.ads494.IsEmpty;
end;

procedure TForm_flowpara.N2Click(Sender: TObject);
var
 step_number,seq_no:word;
 spfc_flag:string;
begin
try
 form_parameter:=tform_parameter.Create(application);
 if form_parameter.ShowModal=mrok then
  begin
   if dm.ads494.IsEmpty then
    seq_no:=1
   else
    begin
     step_number:=dm.ads494.RecNo;
     seq_no:=dm.ads494seq_no.Value;
     dm.ads494.DisableControls;
     while not dm.ads494.Eof do
     begin
      dm.ads494.Edit;
      dm.ads494seq_no.Value:=dm.ads494seq_no.Value+1;
      dm.ads494.Post;
      dm.ads494.Next;
     end;
     dm.ads494.MoveBy(step_number-dm.ads494.RecNo);
     dm.ads494.EnableControls;
    end;

    if form_parameter.ADOQuery1status3.Value=1 then
    spfc_flag:='Y';
    dm.ads494.InsertRecord([form_parameter.ADOQuery1RKEY.Value,
                            '',
                            dm.ADS38SOURCE_PTR.Value,
                            dm.ADS38STEP_NUMBER.Value,
                            seq_no,
                            'Y',
                            '',
                            spfc_flag,
                            '']);
  end;
finally
 form_parameter.Free;
end;
  DBGrid1.ReadOnly := DM.ads494.IsEmpty;
end;

procedure TForm_flowpara.N3Click(Sender: TObject);
var
 step_number:word;
begin
if dm.ads494.RecNo = dm.ads494.RecordCount then
begin
 dm.ads494.Delete;
end
else
 begin
  dm.ads494.Delete;

  step_number := dm.ads494.RecNo;
  dm.ads494.DisableControls;
  while not dm.ads494.Eof do
   begin
    dm.ads494.Edit;
    dm.ads494seq_no.Value := dm.ads494seq_no.Value-1;
    dm.ads494.Post;
    dm.ads494.Next;
   end;
   dm.ads494.MoveBy(step_number-dm.ads494.RecNo);
   dm.ads494.EnableControls;

 end;
 DBGrid1.ReadOnly := DM.ads494.IsEmpty;
end;

procedure TForm_flowpara.BitBtn3Click(Sender: TObject);
var
  i:Integer;
  lqry: TADOQuery;
begin
  lqry := TADOQuery.Create(Self);
  lqry.Connection := DM.ADOConnection1;
  try
  lqry.Close;   //=====���ܸı�adoquery1�����
  lqry.SQL.Text:=
   'SELECT PARAMETER_PTR, TValue, Doc_Flag, after_flag, formula,'+#13+
  'flow_spfc_flag, SEQ_NO, outp_spfc_flag '+#13+
  'FROM dbo.Data0506'+#13+
  'WHERE TTYPE = 3 AND '+#13+
  'SOURCE_PTR = '+dm.ADS38DEPT_PTR.AsString+#13+
  'ORDER BY SEQ_NO';
  lqry.Open;

  while not lqry.Eof do
  begin
   if dm.ads494.Locate('step_number;PARAMETER_PTR',VarArrayOf([DM.ADS38.FieldValues['STEP_NUMBER'],lqry.FieldValues['PARAMETER_PTR']]),[]) then
    begin

      DM.D494ParamChangeEventEnable(False);
      try
        dm.ads494.Edit;
        if (trim(dm.ads494PARAMETER_VALUE.Value)='') and (trim(lqry.Fieldbyname('formula').AsString)<>'') then
        begin
         dm.ads494PARAMETER_VALUE.Value:=
                   form2.cacl_flowpara(lqry.Fieldbyname('TValue').AsString,
                                 trim(lqry.Fieldbyname('formula').AsString));
        end;
        if DM.ads494seq_no.Value <> lqry.FieldByName('SEQ_NO').Value then
          DM.ads494seq_no.Value := lqry.FieldByName('SEQ_NO').Value;
        if DM.ads494after_flag.Value <> lqry.FieldByName('after_flag').Value then
          DM.ads494after_flag.Value:= lqry.FieldByName('after_flag').AsString;
        dm.ads494.Post;
     finally
       DM.ads494PARAMETER_VALUEChange(dm.ads494PARAMETER_VALUE);
        dm.D494ParamChangeEventEnable(True);
     end;
     
    end
   else
    dm.ads494.AppendRecord([lqry.FieldValues['PARAMETER_PTR'],
                          //  lqry.FieldValues['TValue'],

                 form2.cacl_flowpara(lqry.Fieldbyname('TValue').AsString,
                               trim(lqry.Fieldbyname('formula').AsString)),

                            dm.ADS38SOURCE_PTR.Value,
                            dm.ADS38STEP_NUMBER.Value,
                            lqry.FieldValues['SEQ_NO'],
//                            dm.ads494.RecordCount+1,
                            lqry.FieldValues['Doc_Flag'],   //�Ƿ��ӡ
                            lqry.Fieldbyname('after_flag').asstring, //�Ƿ��
                            lqry.FieldValues['flow_spfc_flag'],//�Ƿ��ص�
                            lqry.FieldValues['outp_spfc_flag']
                            ]);

   lqry.Next;
  end;                  //=======���ܸı�adoquery1�����

 if not dm.ads89.Active then  dm.ads89.Open;  //��������Ϣ(ֻ�ж�����)
 dm.ads89.DisableControls;

 dm.ads494.DisableControls;
 i:=1;
 dm.ads494.First;
 while not dm.ads494.Eof do
 begin
  dm.ads494.Edit;
  dm.ads494seq_no.Value:=i;

  if trim(dm.ads494PARAMETER_VALUE.Value)='' then
  if dm.ads89.Locate('PARAMETER_NAME',dm.ads494PARAMETER_NAME.Value,[]) then
  begin
   dm.ads494PARAMETER_VALUE.Value:=dm.ads89tvalue.Value;
  end;

  dm.ads494.Next;
  Inc(i);
 end;

 dm.ads89.First;
 dm.ads494.First;
 dm.ads89.EnableControls;
 dm.ads494.EnableControls;
 finally
  lqry.Free;
 end;

end;

procedure TForm_flowpara.ads494AfterScroll(DataSet: TDataSet);
begin
  self.get_value(dm.ads494PARAMETER_PTR.Value);
end;

procedure TForm_flowpara.FormDestroy(Sender: TObject);
begin
  DM.ads494.AfterScroll := nil;
end;

procedure TForm_flowpara.FormShow(Sender: TObject);
begin
  DBGrid1.ReadOnly := DM.ads494.IsEmpty;
end;

procedure TForm_flowpara.PopupMenu1Popup(Sender: TObject);
begin
  N3.Enabled := not DM.ads494.IsEmpty;
end;

procedure TForm_flowpara.N4Click(Sender: TObject);
var
  InputVar:PDlgInput;
begin
  dm.ads26.append;
  DM.ads26.FieldByName('DEPT_PTR').Value := DM.ADS38DEPT_PTR.Value;
  DM.ads26.FieldByName('DEPT_NAME').Value := DM.ADS38dept_name.Value;
  DM.ads26.FieldByName('ROUTE_STEP_NO').Value := DM.ADS38STEP_NUMBER.Value;
  DM.ads26.FieldByName('FLOW_NO').Value := 1;
  DM.ads26.Post;

  ehBOM.Columns[2].AlwaysShowEditButton:= True;
  ehBOM.Columns[3].AlwaysShowEditButton:= True;
  ehBOM.Columns[6].AlwaysShowEditButton:= True;

//  frmPick_Item_Single:=TfrmPick_Item_Single.Create(nil);
//  try
//    InputVar.Fields := 'INV_PART_NUMBER/���ϱ���/180,INV_NAME/��������/80,INV_DESCRIPTION/��������/300';
//    InputVar.Sqlstr := 'SELECT Data0017.RKEY,Data0017.INV_PART_NUMBER,Data0017.INV_NAME,Data0017.INV_DESCRIPTION '+ #13+
//                       '       ,data0002.UNIT_CODE,Data0017.GROUP_PTR  '+ #13+
//                       '   from Data0017         '+ #13+
//                       '       inner JOIN Data0002 on Data0017.STOCK_UNIT_PTR = Data0002.rkey  '+ #13+
//                       '       inner JOIN Data0496 on Data0017.GROUP_PTR = Data0496.rkey  '+ #13+
//                       '       inner JOIN Data0498 on Data0498.INV_GROUP_PTR = Data0496.rkey  '+ #13+
//                       '       inner JOIN Data0034 on Data0034.RKEY = Data0498.DEPT_PTR  '+ #13+
//                       '   WHERE  Data0017.ACTIVE_FLAG = ''Y'' AND DATA0034.RKEY = ' + DM.ADS38DEPT_PTR.AsString;
//    Inputvar.KeyField:='';
//
//    InputVar.AdoConn := dm.ADOConnection1 ;
//    frmPick_Item_Single.InitForm_New(InputVar);
//    if frmPick_Item_Single.ShowModal=mrok then
//    begin
//      dm.ads26.append;
//      DM.ads26.FieldByName('MANU_BOM_PTR').Value := DM.AQY0025RKEY.Value;
//      DM.ads26.FieldByName('DEPT_PTR').Value := DM.ADS38DEPT_PTR.Value;
//      DM.ads26.FieldByName('DEPT_NAME').Value := DM.ADS38dept_name.Value;
//      DM.ads26.FieldByName('ROUTE_STEP_NO').Value := DM.ADS38STEP_NUMBER.Value;
//      DM.ads26.FieldByName('INVENTORY_PTR').Value := frmPick_Item_Single.adsPick.fieldbyname('rkey').Value;
//      DM.ads26.FieldByName('FLOW_NO').Value := 1;
//      DM.ads26.FieldByName('INV_PART_NUMBER').Value := frmPick_Item_Single.adsPick.fieldbyname('INV_PART_NUMBER').Value;
//      DM.ads26.FieldByName('INV_NAME').Value := frmPick_Item_Single.adsPick.fieldbyname('INV_NAME').Value;
//      DM.ads26.FieldByName('INV_DESCRIPTION').Value := frmPick_Item_Single.adsPick.fieldbyname('INV_DESCRIPTION').Value;
//      DM.ads26.FieldByName('UNIT_CODE').Value := frmPick_Item_Single.adsPick.fieldbyname('UNIT_CODE').Value;
//      DM.ads26.FieldByName('GROUP_PTR').Value := frmPick_Item_Single.adsPick.fieldbyname('GROUP_PTR').Value;
//      DM.ads26.Post;
////      ShowMessage(DM.ads26supplier_ptr.AsString);
//    end;
//  finally
//    frmPick_Item_Single.Free;
//  end;
end;

procedure TForm_flowpara.N5Click(Sender: TObject);
begin
  DM.ads26.Delete;
  if DM.ads26.IsEmpty then
  begin
    ehBOM.Columns[2].AlwaysShowEditButton:= False;
    ehBOM.Columns[3].AlwaysShowEditButton:= False;
    ehBOM.Columns[6].AlwaysShowEditButton:= False;
  end
  else
  begin
    ehBOM.Columns[2].AlwaysShowEditButton:= True;
    ehBOM.Columns[3].AlwaysShowEditButton:= True;
    ehBOM.Columns[6].AlwaysShowEditButton:= True;
  end;
end;

procedure TForm_flowpara.ehBOMCellClick(Column: TColumnEh);
begin
//  if Column.Index = 0 then
//  begin
//    Column.PickList.Clear;
//    with DM.qryTmp do
//    begin
//      Close;
//      SQL.Text:= 'SELECT rkey,BOM_NAME FROM DATA0498 WHERE DEPT_PTR = ' + DM.ADS38DEPT_PTR.AsString + ' ORDER BY SEQ_NO';
//      Open;
//      if NOT IsEmpty then
//      begin
//        while not Eof do
//        begin
////          ehBOM.Columns[0].KeyList.Add(FieldByName('rkey').AsString);
//          ehBOM.Columns[0].PickList.Add(FieldByName('BOM_NAME').AsString);
////          Column.PickList.AddObject(Trim(FieldByName('BOM_NAME').AsString),Pointer(FieldByName('rkey').AsInteger));
//          Next;
//        end;
//      end;
//    end;
//  end;
end;

procedure TForm_flowpara.ehBOMColumns4EditButtonClick(Sender: TObject;
  var Handled: Boolean);
var
  InputVar:PDlgInput;
begin
  if DM.ads26INVENTORY_PTR.AsInteger = 0 then
  begin
    ShowMessage('����ѡ����ϣ���');
    Exit;
  end;
  frmPick_Item_Single:=TfrmPick_Item_Single.Create(nil);
  try
    InputVar.Fields := 'CODE/��Ӧ�̴���/50,SUPPLIER_NAME/��Ӧ������/300,ABBR_NAME/���/300';
    InputVar.Sqlstr := 'SELECT Data0023.rkey,Data0023.CODE,Data0023.SUPPLIER_NAME,Data0023.ABBR_NAME '+ #13+
                       ' FROM Data0023    '+ #13+
                       '     INNER JOIN  Data0028 on Data0028.SUPPLIER_PTR = Data0023.RKEY  '+ #13+
                       '     INNER JOIN Data0017 on Data0028.INVENTORY_PTR = Data0017.RKEY  '+ #13+
                       ' WHERE Data0023.status=0 and Data0017.RKEY = ' + DM.ads26INVENTORY_PTR.AsString;
    Inputvar.KeyField:='';

    InputVar.AdoConn := dm.ADOConnection1 ;
    frmPick_Item_Single.InitForm_New(InputVar);
    if frmPick_Item_Single.ShowModal=mrok then
    begin
      dm.ads26.edit;
      DM.ads26.FieldByName('supplier_ptr').Value := frmPick_Item_Single.adsPick.fieldbyname('rkey').Value;
      DM.ads26.FieldByName('ABBR_NAME').Value := frmPick_Item_Single.adsPick.fieldbyname('ABBR_NAME').Value;
      DM.ads26.Post;
    end;
  finally
    frmPick_Item_Single.Free;
  end;
end;

procedure TForm_flowpara.pgc1Change(Sender: TObject);
begin
  if pgc1.ActivePageIndex = 1 then
  begin
    if DM.ads26.IsEmpty then
    begin
      ehBOM.Columns[2].AlwaysShowEditButton:= False;
      ehBOM.Columns[3].AlwaysShowEditButton:= False;
      ehBOM.Columns[6].AlwaysShowEditButton:= False;
    end
    else
    begin
      ehBOM.Columns[2].AlwaysShowEditButton:= True;
      ehBOM.Columns[3].AlwaysShowEditButton:= True;
      ehBOM.Columns[6].AlwaysShowEditButton:= True;
    end;
  end;
end;

procedure TForm_flowpara.ehBOMColumns0EditButtonClick(Sender: TObject;
  var Handled: Boolean);
var
  InputVar:PDlgInput;
begin
  frmPick_Item_Single:=TfrmPick_Item_Single.Create(nil);
  try
    InputVar.Fields := 'BOM_NAME/BOM��������/400';
    InputVar.Sqlstr := 'SELECT rkey,BOM_NAME,Data0498.FORMULA FROM DATA0498 WHERE DEPT_PTR = ' + DM.ADS38DEPT_PTR.AsString + ' ORDER BY SEQ_NO';
    Inputvar.KeyField:='';

    InputVar.AdoConn := dm.ADOConnection1 ;
    frmPick_Item_Single.InitForm_New(InputVar);
    if frmPick_Item_Single.ShowModal=mrok then
    begin
      ExprStr:= frmPick_Item_Single.adsPick.fieldbyname('FORMULA').Value;
      dm.ads26.Edit;
      DM.ads26.FieldByName('D498_ptr').Value := frmPick_Item_Single.adsPick.fieldbyname('rkey').Value;
      DM.ads26.FieldByName('BOM_NAME').Value := frmPick_Item_Single.adsPick.fieldbyname('BOM_NAME').Value;
//      DM.ads26.FieldByName('DEPT_PTR').Value := DM.ADS38DEPT_PTR.Value;
//      DM.ads26.FieldByName('DEPT_NAME').Value := DM.ADS38dept_name.Value;
//      DM.ads26.FieldByName('ROUTE_STEP_NO').Value := DM.ADS38STEP_NUMBER.Value;
//      DM.ads26.FieldByName('FLOW_NO').Value := 1;
      DM.ads26.Post;
    end;
  finally
    frmPick_Item_Single.Free;
  end;
end;


procedure TForm_flowpara.BitBtn1Click(Sender: TObject);
begin
//  with dm.ads26 do
//  begin
//    First;
//    while not Eof do
//    begin
//      if (DM.ads26D498_ptr.AsInteger =0) or (DM.ads26DEPT_PTR.AsInteger = 0) then
//      begin
//        ShowMessage('BOMû��ѡ��BOM���ͻ��߲��ϣ���');
//        exit;
//      end;
//      Next;
//    end;
//  end;
  ModalResult:= mrOk;
end;

procedure TForm_flowpara.btnBomClick(Sender: TObject);
var
  sqlstr,subSql,ExprStr,F01,F02,F03:string;
  RecNO,istep,Suppint:integer;
  Supp:string;
begin

//  InheriteParams(False);   //�̳в���  497

  while not dm.ads26.Eof do
  DM.ads26.Delete;

//1.ѭ������,
//3.������ÿ���������
  with dm do begin
    ads498.DisableControls;
    ads494.DisableControls;
    try
  //1.ÿ������ѭ��,
      try
        ads498.First;
        istep:=1;
        while not ads498.Eof do
        begin
          if trim(ads498.fieldbyName('FORMULA').Asstring)='' then
          begin
            showmessage(inttostr(istep)+'���裺'+#13+'�������Ϲ�ʽ����Ϊ��,����...');
            abort;
          end;
           DM.aqGroupParam.Close;
           DM.aqGroupParam.Parameters[0].Value := ads498.fieldbyName('INV_GROUP_PTR').Value;
           DM.aqGroupParam.Open;
//          frmProcessShow.IncStep(StepIncNum,'���ڴ�����'+adsMatrlGroupList.fieldByName('INV_GROUP_PTR').Asstring+'...');

          //2.����ÿ���������õĲ���,�����ϱ�0017�ж�λÿ�����,
          ads494.First;
          RecNO:=0;
          Sqlstr:='select data0017.rkey,inv_part_number,INV_NAME,INV_DESCRIPTION,data0002.UNIT_Code,group_ptr from data0017 inner JOIN Data0002 on Data0017.STOCK_UNIT_PTR = Data0002.rkey where group_ptr='+QuotedStr(ads498.fieldByName('INV_GROUP_PTR').Asstring);
          //ѭ��BOM�Ĳ���
          subSql:='';
          while not ads494.eof do
          begin
            if Pos('��Ӧ��',ads494PARAMETER_DESC.AsString)>0 then Supp:= ads494PARAMETER_VALUE.AsString;
           if trim(ads494.FieldByName('parameter_value').AsString) <> '' then
            begin
              if aqGroupParam.Locate('INV_Group_ptr;Parameter_Ptr',varArrayOf([ads498.FieldByName('INV_GROUP_PTR').value
              ,ads494.FieldByName('Parameter_Ptr').value]),[loCaseInsensitive]) then
              begin
                if aqGroupParam.FieldByName('ttype').Asinteger= 0 then //0���ϲ���,1��Ʒ����
                begin
                  inc(RecNo);
                  Subsql:= Subsql + ' and ies_parameter_value'+IntToStr(aqGroupParam.FieldByname('SEQ_NO').asinteger)+'='+QuotedStr(trim(ads494.FieldByName('parameter_value').AsString));
                end;
              end;
            end;
            ads494.Next;
          end;

          if (ads498.FieldByName('required').Value='Y') and (SubSql='') then
          begin
            showmessage(inttostr(istep)+'��������в���,����ֵ����Ϊ��...');
            abort;
          end;

          if SubSql <>'' then
          begin
//            ShowMessage(sqlstr+SubSql);
            aqMaterials.close;
            aqMaterials.SQL.Clear;
            aqMaterials.SQL.Add(sqlstr+SubSql);

            try
            aqMaterials.open;
            except
              showmessage(inttostr(istep)+'����'+'-'+inttostr(RecNo)+'����ֵ����'+#13+sqlstr+SubSql);
              abort;
            end;
            Suppint:= GetSupp(Supp);

//            if Suppint = 0 then
//            begin
//              ShowMessage('�����й�Ӧ�̼��Ϊ�գ�����д');
//              abort;
//            end;
            //0017���Ҳ���

            if aqMaterials.IsEmpty then
            begin
              showmessage(trim(ads498.fieldbyName('Dept_Code').AsString)+'-'+trim(ads498.fieldbyName('BOM_NAME').AsString)+ ' û���ҵ�ƥ��Ĳ���,���������ֵ!');
              abort;
            end
            else if aqMaterials.RecordCount > 1 then
            begin
              showmessage('�ʺ� '+trim(ads498.fieldbyName('Dept_Code').AsString)+'-'+trim(ads498.fieldbyName('BOM_NAME').AsString)+ ' �Ĳ��ϲ�ֹһ��,����!');
              abort;
            end
            else
            begin
              ads26.Append;
              ads26.FieldByName('Manu_BOM_Ptr').Value := DM.AQY0025RKEY.Value;
              ads26.FieldByName('Dept_Ptr').Value := ads498.fieldbyName('rKey').value;
              ads26.FieldByName('Dept_Name').Value := ads498.fieldbyName('DEPT_NAME').value;
              ads26.FieldByName('Inventory_Ptr').Value := aqMaterials.fieldbyName('rKey').value;
              ads26.FieldByName('INV_PART_NUMBER').Value := aqMaterials.fieldbyName('INV_PART_NUMBER').value;
              ads26.FieldByName('INV_NAME').Value := aqMaterials.fieldbyName('INV_NAME').value;
              ads26.FieldByName('INV_DESCRIPTION').Value := aqMaterials.fieldbyName('INV_DESCRIPTION').value;
              ads26.FieldByName('BOM_NAME').Value := ads498.fieldbyName('BOM_NAME').value;
              ads26.FieldByName('Route_Step_No').Value := ADS38STEP_NUMBER.Value;
              ads26.FieldByName('Doc_Flag').Value := ads498.fieldbyName('Doc_Flag').value;
              if Suppint <> 0 then
              ads26.FieldByName('supplier_ptr').Value := Suppint;
              ads26.FieldByName('ABBR_NAME').Value := Supp;
              ads26.FieldByName('UNIT_CODE').Value :=aqMaterials.fieldbyName('UNIT_CODE').value;
              ads26.FieldByName('FLOW_NO').Value :=  1;
              ads26.FieldByName('D498_ptr').Value :=  ads498.fieldbyName('MGRkey').value;
              ads26.FieldByName('GROUP_PTR').Value :=  aqMaterials.fieldbyName('GROUP_PTR').value;

//              frmProcessShow.IncStep(StepIncNum,'���ڼ���BOM��������...');
              ExprStr:=' '+trim(ads498.fieldbyName('FORMULA').Asstring)+' ';
              try
                try
//                  aqIESParams.Filter := 'step_number=' + adsMatrlGroupList.fieldbyname('step_number').AsString;
//                  aqIESParams.Filtered := True;
                  ads26.FieldByName('Qty_Bom').Value := CalcBomPartQty(ExprStr,ads494.fieldbyname('step_number').AsInteger,DM.AQY0025RKEY.AsInteger);
                finally
                  //aqIESParams.Filtered := False;
                end;
              except
                ShowMessage(inttostr(istep)+'����������ʽ�������:'+trim(ads498.fieldbyName('FORMULA').Asstring));
                abort;
              end;
              ads26.Post;
            end;
          end;
          ads498.Next;
          inc(istep);
        end;
      except
        try
          if ads26.RecordCount > 0 then ads26.CancelBatch(arAll);
        except
        end;
//        if spbtnSave.Enabled then  spbtnSave.Enabled:= false;
        ShowMessage('����BOMʧ��!');
      end;
    finally
      ads26.Filter:= '';
      ads498.first;
      ads498.EnableControls;
      adsBOMParams.EnableControls;
    end;
  end;
end;

procedure TForm_flowpara.InheriteParams(DrillPms: boolean);
var
  Driller_Rec_NO:integer;
  bFind:boolean;
begin
  with DM do begin
//    frmProcessShow.IncStep(StepIncNum,'���ڴ�������������������...');
    ads498.DisableControls;
    try
//      DBGridEh1.DataSource:=nil;
      Driller_Rec_NO:=0;
      if DrillPms then ads498.Filter:='Spec_rKey=1';
      ads498.First;
  //1.ÿ������ѭ��,
      while not ads498.Eof do begin
      //2.����ÿ������Ĳ������,�Ӳ�������Ĳ�����499�и��Ʋ�����497��
//        frmProcessShow.IncStep(StepIncNum,'���ڴ���'+DM.ads498.FieldByName('DEPT_CODE').asstring+','+DM.ads498.FieldByName('BOM_NAME').asstring+'����������...');
        aqGroupParam.Filtered := false;
        aqGroupParam.Filter := 'Inv_Group_Ptr='+ads498.FieldByName('INV_GROUP_PTR').AsString;
        aqGroupParam.Filtered := true;
//        if ads498.FieldByName('Spec_rKey').Asstring = '1' then //�ò������������,��ôҪ��������л�ȡ����
//        begin
//          Inc(Driller_Rec_NO);
//          aqDrillersValue.MoveBy(Driller_Rec_NO-aqDrillersValue.RecNo);
//        end;

        while not aqGroupParam.Eof do
        begin
          bFind:=false;
          if adsBOMParams.IsEmpty then
            bFind:= false
          else
            bFind:= adsBOMParams.Locate('SOURCE_PTR;ROUTE_STEP_PTR;PARAMETER_PTR',VarArrayOf([DM.ads498.fieldByName('MGRkey').AsString,DM.ads498.fieldByName('EFRkey').AsString,aqGroupParam.FieldByName('PARAMETER_PTR').AsString]),[loCaseInsensitive]);
          if not bFind then
          begin
            adsBOMParams.Append;
            adsBOMParams.FieldByName('PARAMETER_PTR').AsString := aqGroupParam.FieldByName('PARAMETER_PTR').AsString;
            adsBOMParams.FieldByName('SEQ_NO').AsString := aqGroupParam.FieldByName('SEQ_NO').AsString;
            adsBOMParams.FieldByName('PARAMETER_VALUE').AsString := aqGroupParam.FieldByName('DEF_Value').AsString;
           //3.���������,�ٶ�ÿ������������Ӧ�Ĺ����Ƴ̲���494,�����,��Ѳ���ֵȡ����.
//            if aqIESParams.Locate('PARAMETER_PTR',VarArrayOf([aqGroupParam.FieldByName('PARAMETER_PTR').AsString]),[loCaseInsensitive]) then
//              adsBOMParams.FieldByName('PARAMETER_VALUE').AsString := aqIESParams.FieldByName('PARAMETER_VALUE').AsString;

              if ads494.Locate('Parameter_ptr;step_number',VarArrayOf([aqGroupParam.FieldByName('PARAMETER_PTR').AsInteger,DM.ADS38STEP_NUMBER.AsInteger]),[loCaseInsensitive]) then //�Ƴ̲���
                adsBOMParams.FieldByName('PARAMETER_VALUE').AsString := ads494.FieldByName('PARAMETER_VALUE').AsString;

            //4.�������������,��ô�ʹ�������ȡ��ֵ
//            if uppercase(trim(adsBOMParams.FieldByName('spec_rKey').AsString)) = 'X' then //����ֱ��
//              if aqDrillersValue.RecNo <> aqDrillersValue.RecordCount then //���һ����¼˵�������������ķ�Χ
//                if IS_Float(aqDrillersValue.FieldByName('DRILL_DIA').AsString) then
//                  adsBOMParams.FieldByName('PARAMETER_VALUE').AsString := aqDrillersValue.FieldByName('DRILL_DIA').AsString;
//            if uppercase(trim(adsBOMParams.FieldByName('spec_rKey').AsString)) = 'Y' then //�������
//              if aqDrillersValue.RecNo <> aqDrillersValue.RecordCount then //���һ����¼˵�������������ķ�Χ
//              begin
//                if not (Pos('TOTAL',UpperCase(aqDrillersValue.FieldByName('unit').AsString)) > 0 ) then
//                begin
//                  if (trim(aqDrillersValue.FieldByName('Panel_A').AsString)<>'') and IS_Float(aqDrillersValue.FieldByName('DRILL_DIA').AsString) then
//                    adsBOMParams.FieldByName('PARAMETER_VALUE').AsString := aqDrillersValue.FieldByName('Panel_A').AsString
//                  else if (trim(aqDrillersValue.FieldByName('Panel_B').AsString)<>'') and IS_Float(aqDrillersValue.FieldByName('DRILL_DIA').AsString) then
//                    adsBOMParams.FieldByName('PARAMETER_VALUE').AsString := aqDrillersValue.FieldByName('Panel_B').AsString ;  //B��Ҫ���µĲ�Ʒ����
//                end;
//              end;

               // if IS_Float(aqDrillersValue.FieldByName('DRILL_DIA').AsString) then   //�ɱ���A���ÿPCS����Ϊ��׼
                //  adsBOMParams.FieldByName('PARAMETER_VALUE').AsString := aqDrillersValue.FieldByName('Panel_A').AsString;
            adsBOMParams.Post;
          end
          else //�Ѿ����ڵĲ���
          begin
            //�޸ı�ע��ԭ�������Ѿ����ڵĲ����Ͳ����»�ü̳еĲ���ֵ�����ڸ�Ϊ���в�����Ҫ���´�499���
            begin
              adsBOMParams.edit;
              if adsBOMParams.FieldByName('SEQ_NO').IsNull then
                adsBOMParams.FieldByName('SEQ_NO').Asinteger:= aqGroupParam.FieldByName('SEQ_NO').Asinteger;
              //��ò���������
              adsBOMParams.FieldByName('PARAMETER_VALUE').Asstring := aqGroupParam.FieldByName('DEF_Value').AsString;
              //����Ƴ̲�����,���ȡ�Ƴ̲���
              if ads494.Locate('Parameter_ptr;step_number',VarArrayOf([adsBOMParams.FieldByName('PARAMETER_PTR').AsInteger,ads498.fieldbyname('step_number').AsInteger]),[loCaseInsensitive]) then //�Ƴ̲���
                adsBOMParams.FieldByName('PARAMETER_VALUE').AsString := ads494.FieldByName('PARAMETER_VALUE').AsString;
              //���������,��ô�ʹ��������ȡ��
//              if uppercase(trim(adsBOMParams.FieldByName('spec_rKey').AsString)) = 'X' then //����ֱ��
//                if aqDrillersValue.RecNo <> aqDrillersValue.RecordCount then //���һ����¼˵�������������ķ�Χ
//                  if IS_Float(aqDrillersValue.FieldByName('DRILL_DIA').AsString) then
//                    adsBOMParams.FieldByName('PARAMETER_VALUE').AsString := aqDrillersValue.FieldByName('DRILL_DIA').AsString;
//              if uppercase(trim(adsBOMParams.FieldByName('spec_rKey').AsString)) = 'Y' then //�������
//                if aqDrillersValue.RecNo <> aqDrillersValue.RecordCount then //���һ����¼˵�������������ķ�Χ
//                begin
//                  if not (Pos('TOTAL',UpperCase(aqDrillersValue.FieldByName('unit').AsString)) >0 ) then
//                  begin
//                    if (trim(aqDrillersValue.FieldByName('Panel_A').AsString)<>'') and IS_Float(aqDrillersValue.FieldByName('DRILL_DIA').AsString) then
//                      adsBOMParams.FieldByName('PARAMETER_VALUE').AsString := aqDrillersValue.FieldByName('Panel_A').AsString
//                    else if (trim(aqDrillersValue.FieldByName('Panel_B').AsString)<>'') and IS_Float(aqDrillersValue.FieldByName('DRILL_DIA').AsString) then
//                      adsBOMParams.FieldByName('PARAMETER_VALUE').AsString := aqDrillersValue.FieldByName('Panel_B').AsString ;
//                  end;
//                end;
              adsBOMParams.Post;
            end ;
          end;
          aqGroupParam.next;
        end;
        DM.ads498.Next;
      end;
    finally
      DM.ads498.Filter:='';
      aqGroupParam.Filter := '';
      aqGroupParam.Filtered := false;
//      DBGridEh1.DataSource:=dsBOMParams;
      DM.ads498.first;
      DM.ads498.EnableControls;
    end;
  end;
end;

function TForm_flowpara.CalcBomPartQty(var ExprStr: string; AStepNumber,
  rkey25: Integer): double;
var
  i,j:integer;
  X,Y:string;
  rkey,s_Y,s_X,d_Y,d_X:String;
  x_DataType,y_DataType:byte;
  TmpDataSet:TAdoDataSet;
  rslt_value:variant;
  Tmpstr:string;
begin
//���̱�
  with dm do begin
    Tmpstr:=ExprStr;
    //�ӹ�ʽ���滻��BOM,PD�ַ������ڼ��㹫ʽ.
    ExprStr:= StringReplace(ExprStr,' BOM.',' ',[rfReplaceAll]);
    ExprStr:= StringReplace(ExprStr,' PD.',' ',[rfReplaceAll]);
    adsParamsInfo.Close;
    adsParamsInfo.Open;
    try
      TmpDataSet:= TADoDataSet.Create(self);
      TmpDataSet.LockType := ltBatchOptimistic;
      TmpDataSet.Clone(adsParamsInfo);
//      aqPubParams.Close;
//      aqPubParams.Parameters[0].Value := rkey25;
//      aqPubParams.Open;
//      adsBOMParams.Close;
//      adsBOMParams.Parameters[0].Value := rkey25;
//      adsBOMParams.Open;
//      aqIESParams.Close;
//      aqIESParams.Parameters[0].Value := rkey25;
//      aqIESParams.open;
      adsParamsInfo.Close;
      adsParamsInfo.Open;
    //1.����ʽ�еĹ��̱�,
      aqEngTable.Close;
      aqEngTable.Open;
      aqEngTable.First;
      while not aqEngTable.Eof do
      begin
        i:= Pos(' '+trim(aqEngTable.fieldbyName('FXY').AsString)+' ',ExprStr);
        if i > 0 then //�ڹ�ʽ���ҵ��˹��̱�
        begin
          rKey:= aqEngTable.fieldbyName('rKey').AsString;
          x:= aqEngTable.fieldbyName('FX').AsString;
          y:= aqEngTable.fieldbyName('FY').AsString;
          s_x:='';s_y:='';d_x:='1';d_y:='1';
          if x <> '' then
          begin
            if TmpDataSet.Locate('rKey',x,[loCaseInsensitive]) then
              x_DataType:= TmpDataSet.fieldByName('Data_Type').AsInteger
            else
            begin
              ShowMessage('û���ҵ����̱�:'+trim(aqEngTable.fieldbyName('FXY').AsString)+'��X��������ֵ');
              abort;
            end;
//            if aqPubParams.Locate('Parameter_ptr',x,[loCaseInsensitive]) then  //ȫ�ֲ���
//              s_x:= aqPubParams.FieldByName('Parameter_value').AsString
//            else if adsBOMParams.Locate('Parameter_ptr',x,[loCaseInsensitive]) then //���ϲ���
//              s_x:= adsBOMParams.FieldByName('Parameter_value').AsString
//            else if aqIESParams.Locate('Parameter_ptr;step_number',VarArrayOf([x,AStepNumber]),[loCaseInsensitive]) then //�Ƴ̲���
//              s_x:= aqIESParams.FieldByName('Parameter_value').AsString
//            else begin
//               dm.qryTmp.Close;
//               dm.qryTmp.SQL.Text:='select parameter_name+'' ''+parameter_desc from data0278 where rkey='+x;
//               dm.qryTmp.Open;
//               ShowMessage('���󹤳̲���:'+trim(dm.qryTmp.fields[0].AsString)+'�ڱ���Ʒ�в�����');
//               dm.qryTmp.Close;
//               abort;
//            end;
            if ads279.Locate('Parameter_ptr',x,[loCaseInsensitive]) then  //ȫ�ֲ���
              s_x:= ads279.FieldByName('Parameter_value').AsString
            else if ads497.Locate('Parameter_ptr',x,[loCaseInsensitive]) then //���ϲ���
              s_x:= ads497.FieldByName('Parameter_value').AsString
            else if ads494.Locate('Parameter_ptr;step_number',VarArrayOf([x,AStepNumber]),[loCaseInsensitive]) then //�Ƴ̲���
              s_x:= ads494.FieldByName('Parameter_value').AsString
            else begin
               dm.qryTmp.Close;
               dm.qryTmp.SQL.Text:='select parameter_name+'' ''+parameter_desc from data0278 where rkey='+x;
               dm.qryTmp.Open;
               ShowMessage('���󹤳̲���:'+trim(dm.qryTmp.fields[0].AsString)+'�ڱ���Ʒ�в�����');
               dm.qryTmp.Close;
               abort;
            end;

            if trim(s_x) = '' then
            begin
              if not DM.adsParamsInfo.Locate('rkey',ads494.fieldbyName('PARAMETER_PTR').AsString,[])  then Exit;
              ShowMessage(trim(adsParamsInfo.fieldbyName('parameter_name').AsString)+'�����в���û�и�ֵ');
              abort;
            end;
            if x_DataType= 1 then //����
            begin
              d_x:=s_x;
              s_x:='';
            end;
          end;
          if y <> '' then
          begin
            if TmpDataSet.Locate('rKey',y,[loCaseInsensitive]) then
              y_DataType:= TmpDataSet.fieldByName('Data_Type').AsInteger
            else
            begin
              ShowMessage('û���ҵ����̱�:'+trim(aqEngTable.fieldbyName('Eng_Table_Desc').AsString)+'��y��������ֵ');
              abort;
            end;
//            if aqPubParams.Locate('Parameter_ptr',y,[loCaseInsensitive]) then  //ȫ�ֲ���
//              s_y:= aqPubParams.FieldByName('Parameter_value').AsString
//            else if aqIESParams.Locate('Parameter_ptr',y,[loCaseInsensitive]) then //�Ƴ̲���
//              s_y:= aqIESParams.FieldByName('Parameter_value').AsString
//            else if adsBOMParams.Locate('Parameter_ptr',y,[loCaseInsensitive]) then //BOM����
//              s_y:= adsBOMParams.FieldByName('Parameter_value').AsString
//            else begin
//               dm.qryTmp.Close;
//               dm.qryTmp.SQL.Text:='select parameter_name+'' ''+parameter_desc from data0278 where rkey='+y;
//               dm.qryTmp.Open;
//               ShowMessage('���󹤳̲���:'+trim(dm.qryTmp.fields[0].AsString)+'�ڱ���Ʒ�в�����');
//               dm.qryTmp.Close;
//               abort;
//            end;
            if ads279.Locate('Parameter_ptr',y,[loCaseInsensitive]) then  //ȫ�ֲ���
              s_y:= ads279.FieldByName('Parameter_value').AsString
            else if ads494.Locate('Parameter_ptr',y,[loCaseInsensitive]) then //�Ƴ̲���
              s_y:= ads494.FieldByName('Parameter_value').AsString
            else if ads497.Locate('Parameter_ptr',y,[loCaseInsensitive]) then //BOM����
              s_y:= ads497.FieldByName('Parameter_value').AsString
            else begin
               dm.qryTmp.Close;
               dm.qryTmp.SQL.Text:='select parameter_name+'' ''+parameter_desc from data0278 where rkey='+y;
               dm.qryTmp.Open;
               ShowMessage('���󹤳̲���:'+trim(dm.qryTmp.fields[0].AsString)+'�ڱ���Ʒ�в�����');
               dm.qryTmp.Close;
               abort;
            end;
            if trim(s_y) = '' then
            begin
              if not DM.adsParamsInfo.Locate('rkey',ads494.fieldbyName('PARAMETER_PTR').AsString,[])  then Exit;
              ShowMessage(trim(adsParamsInfo.fieldbyName('parameter_name').AsString)+'�����в���û�и�ֵ');
              abort;
            end;
            if y_DataType= 1 then //����
            begin
              d_y:=s_y;
              s_y:='';
            end;
          end;

          rslt_value:=Calc_Eng_Table(rKey,s_x,s_y,d_x,d_y);//���㲢���ع��̱���ֵ

        //  rslt_value:=MyDataClass.Get_Sql_Value('Exec WZPR085 ' + rKey + ',' + QuotedStr(s_x) + ',' + QuotedStr(s_y) + ',' + d_x + ',' + d_y;);

          if rslt_value = NULL then
          begin
            ShowMessage('�����쳣��û��ȡ�����̱���Ӧ����ֵ��'+trim(aqEngTable.fieldbyName('FXY').AsString));
            abort;
          end;

          if aqEngTable.FieldByName('data_type').AsInteger=1 then//������
            ExprStr:= StringReplace(ExprStr,' '+trim(aqEngTable.fieldbyName('FXY').AsString)+' ',rslt_value,[rfReplaceAll])
          else
            ExprStr:= StringReplace(ExprStr,' '+trim(aqEngTable.fieldbyName('FXY').AsString)+' ',QuotedStr(rslt_value),[rfReplaceAll])
        end;
        aqEngTable.next;
      end;

  //4.����ȫ�ֲ���
      Update_Expr_Param_Value(ads279,ExprStr,-1);
  //3.������� ����
      Update_Expr_Param_Value(ads497,ExprStr,-1);
  //2.�����Ƴ̲���
      Update_Expr_Param_Value(ads494,ExprStr,AStepNumber);
  //5.���㹫ʽ

//  ShowMessage(ExprStr);
      if not Calc_Expr_Parma(ExprStr,ads498.Connection,result) then
      begin
        ShowMessage('�������,��ʽ:'+tmpstr+#13+#10+',��ֵ��:'+ExprStr);
        abort;
      end;
    finally
      TmpDataSet.Close;
      TmpDataSet.free;
    end;
  end;
end;

function TForm_flowpara.Calc_Eng_Table(rkey, s_Y, s_X, d_Y,
  d_X: string): variant;
var
  Sqlstr: string;
begin
  Sqlstr := 'Exec autocal85 ' + rKey + ',' + QuotedStr(s_x) + ',' + QuotedStr(s_y) + ',' + d_x + ',' + d_y;

  DM.qrytmp.close;
  DM.qrytmp.SQL.Clear;
  DM.qrytmp.SQL.Add(sqlstr);
  DM.qrytmp.EnableBCD := False;
  try
    DM.qrytmp.Open;
    result := DM.qrytmp.Fields[0].Value;
  except
    showmessage('����:'+sqlstr);
    abort;
  end;
end;

function TForm_flowpara.Update_Expr_Param_Value(DAtaSet: TCustomADODataSet;
  var Exprstr: string; AStep: Integer): boolean;
begin
  DAtaSet.Filtered:=False;
  DAtaSet.first;
  while not DAtaSet.eof do
  begin

    if DM.adsParamsInfo.Locate('rkey',DAtaSet.fieldbyName('PARAMETER_PTR').AsString,[]) then
    begin
//    ShowMessage(DM.adsParamsInfo.fieldbyName('Parameter_name').AsString);
      if Pos(' '+trim(DM.adsParamsInfo.fieldbyName('Parameter_name').AsString)+' ',ExprStr) > 0 then
      begin
        if AStep <> - 1 then
        begin
          if DAtaSet.FieldByName('step_number').AsInteger <> AStep then
          begin
            DAtaSet.next;
            Continue;
          end;
        end;
        if trim(DAtaSet.fieldbyName('Parameter_value').AsString)='' then
        begin
  //        ShowMessage(DM.adsParamsInfo.fieldbyName('Parameter_name').AsString + ' ����ֵΪ��');
  //        Exit;
          if DM.adsParamsInfo.fieldbyName('Data_Type').AsInteger = 1 then //����
            ExprStr:= StringReplace(ExprStr,' '+trim(DM.adsParamsInfo.fieldbyName('Parameter_name').AsString)+' ',' '+'0'+' ',[rfReplaceAll])
          else
            ExprStr:= StringReplace(ExprStr,' '+trim(DM.adsParamsInfo.fieldbyName('Parameter_name').AsString)+' ',' '+QuotedStr('')+' ',[rfReplaceAll]);
        end;

         if DM.adsParamsInfo.fieldbyName('Data_Type').AsInteger = 1 then //����
           ExprStr:= StringReplace(ExprStr,' '+trim(DM.adsParamsInfo.fieldbyName('Parameter_name').AsString)+' ',' '+trim(DAtaSet.FieldByName('Parameter_value').AsString)+' ',[rfReplaceAll])
         else
           ExprStr:= StringReplace(ExprStr,' '+trim(DM.adsParamsInfo.fieldbyName('Parameter_name').AsString)+' ',' '''+trim(DAtaSet.FieldByName('Parameter_value').AsString)+''' ',[rfReplaceAll]);
        // break;
      end;
    end;
    DAtaSet.next;
  end;
  DAtaSet.Filtered:=False;
end;

function TForm_flowpara.Calc_Expr_Parma(var str_Expr: string;
  AdoConn: TAdoConnection; out Out_Value: double): boolean;
begin
  Result:= False;
  DM.qrytmp.close;
  DM.qrytmp.SQL.Clear;
  DM.qrytmp.SQL.Text:='select 1.0 * ' + str_expr;
  DM.qrytmp.EnableBCD := False;
  try
    DM.qrytmp.Open;
//    if not dm.qrytmp.isempty then
    Out_Value := DM.qrytmp.Fields[0].Value;
    Result:= True;
  except
    showmessage('����:'+DM.qrytmp.SQL.Text);
    abort;
  end;
end;

function TForm_flowpara.GetSupp(abbname: string): Integer;
begin
  Result:= 0;
  DM.qrytmp.close;
  DM.qrytmp.SQL.Clear;
  DM.qrytmp.SQL.Text:= 'select rkey from data0023 where ABBR_NAME = '+ QuotedStr(abbname);
  DM.qrytmp.EnableBCD := False;
  try
    DM.qrytmp.Open;
    if not dm.qrytmp.isempty then
    result := DM.qrytmp.Fields[0].Value;
  except
    showmessage('����:'+DM.qrytmp.SQL.Text);
    abort;
  end;
end;

procedure TForm_flowpara.ehBOMColumns3EditButtonClick(Sender: TObject;
  var Handled: Boolean);
var
  InputVar:PDlgInput;
begin
  if DM.ads26D498_ptr.AsInteger = 0 then
  begin
    ShowMessage('����ѡ��BOM�������ƣ���');
    Exit;
  end;

  frmPick_Item_Single:=TfrmPick_Item_Single.Create(nil);
  try
    InputVar.Fields := 'INV_PART_NUMBER/���ϱ���/180,INV_NAME/��������/120,INV_DESCRIPTION/��������/200'  +
                       ',IES_PARAMETER_VALUE1/IES����1/70,IES_PARAMETER_VALUE2/IES����2/70,IES_PARAMETER_VALUE3/IES����3/70'+
                       ',IES_PARAMETER_VALUE4/IES����4/70,IES_PARAMETER_VALUE5/IES����5/70,IES_PARAMETER_VALUE6/IES����6/70'+
                       ',IES_PARAMETER_VALUE7/IES����7/70,IES_PARAMETER_VALUE8/IES����8/70,IES_PARAMETER_VALUE9/IES����9/70'+
                       ',IES_PARAMETER_VALUE10/IES����10/70';
    InputVar.Sqlstr := 'SELECT Data0017.RKEY,Data0017.INV_PART_NUMBER,Data0017.INV_NAME,Data0017.INV_DESCRIPTION '+ #13+
                       '       ,data0002.UNIT_CODE,Data0017.GROUP_PTR  '+ #13+
                       '       ,data0017.IES_PARAMETER_VALUE1,data0017.IES_PARAMETER_VALUE2,data0017.IES_PARAMETER_VALUE3 '+ #13+
                       '       ,data0017.IES_PARAMETER_VALUE4,data0017.IES_PARAMETER_VALUE5,data0017.IES_PARAMETER_VALUE6 '+ #13+
                       '       ,data0017.IES_PARAMETER_VALUE7,data0017.IES_PARAMETER_VALUE8,data0017.IES_PARAMETER_VALUE9 '+ #13+
                       '       ,data0017.IES_PARAMETER_VALUE10  '+ #13+
                       '   from Data0017         '+ #13+
                       '       inner JOIN Data0002 on Data0017.STOCK_UNIT_PTR = Data0002.rkey  '+ #13+
                       '       inner JOIN Data0496 on Data0017.GROUP_PTR = Data0496.rkey  '+ #13+
                       '       inner JOIN Data0498 on Data0498.INV_GROUP_PTR = Data0496.rkey  '+ #13+
                       '       inner JOIN Data0034 on Data0034.RKEY = Data0498.DEPT_PTR  '+ #13+
                       '   WHERE Data0496.IsMaster = 1 AND  Data0017.ACTIVE_FLAG = ''Y'' AND DATA0034.RKEY = ' + DM.ADS38DEPT_PTR.AsString  + #13+
                       '          AND Data0498.RKEY = '+ DM.ads26D498_ptr.AsString;
    Inputvar.KeyField:='';

    InputVar.AdoConn := dm.ADOConnection1 ;
    frmPick_Item_Single.InitForm_New(InputVar);
    if frmPick_Item_Single.ShowModal=mrok then
    begin
      dm.ads26.Edit;
      DM.ads26.FieldByName('MANU_BOM_PTR').Value := DM.AQY0025RKEY.Value;
//      DM.ads26.FieldByName('DEPT_PTR').Value := DM.ADS38DEPT_PTR.Value;
//      DM.ads26.FieldByName('DEPT_NAME').Value := DM.ADS38dept_name.Value;
//      DM.ads26.FieldByName('ROUTE_STEP_NO').Value := DM.ADS38STEP_NUMBER.Value;
      DM.ads26.FieldByName('INVENTORY_PTR').Value := frmPick_Item_Single.adsPick.fieldbyname('rkey').Value;
//      DM.ads26.FieldByName('FLOW_NO').Value := 1;
      DM.ads26.FieldByName('INV_PART_NUMBER').Value := frmPick_Item_Single.adsPick.fieldbyname('INV_PART_NUMBER').Value;
      DM.ads26.FieldByName('INV_NAME').Value := frmPick_Item_Single.adsPick.fieldbyname('INV_NAME').Value;
      DM.ads26.FieldByName('INV_DESCRIPTION').Value := frmPick_Item_Single.adsPick.fieldbyname('INV_DESCRIPTION').Value;
      DM.ads26.FieldByName('UNIT_CODE').Value := frmPick_Item_Single.adsPick.fieldbyname('UNIT_CODE').Value;
      DM.ads26.FieldByName('GROUP_PTR').Value := frmPick_Item_Single.adsPick.fieldbyname('GROUP_PTR').Value;
      DM.ads26.FieldByName('QTY_BOM').Value:= CalcBomPartQty(ExprStr,DM.ads26ROUTE_STEP_NO.AsInteger,DM.AQY0025RKEY.Value);
      DM.ads26.Post;
//      ShowMessage(DM.ads26supplier_ptr.AsString);
    end;
  finally
    frmPick_Item_Single.Free;
  end;
end;

end.
