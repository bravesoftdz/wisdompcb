unit product_MIDetail;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, ImgList, DBCtrls, Mask,
  Grids, DBGrids, Menus, DB, ADODB,math, DBGridEh;

type
  TForm2 = class(TForm)
    Panel1: TPanel;
    BitBtn2: TBitBtn;
    BitBtn1: TBitBtn;
    HeaderControl1: THeaderControl;
    TreeView1: TTreeView;
    ImageList1: TImageList;
    ListBox1: TListBox;
    Notebook1: TNotebook;
    Label1: TLabel;
    Label2: TLabel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    DBCheckBox1: TDBCheckBox;
    Label11: TLabel;
    Label12: TLabel;
    Edit1: TEdit;
    DBRadioGroup1: TDBRadioGroup;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    DBEdit7: TDBEdit;
    DBEdit8: TDBEdit;
    DBEdit9: TDBEdit;
    DBEdit10: TDBEdit;
    DBEdit11: TDBEdit;
    DBEdit12: TDBEdit;
    DBEdit13: TDBEdit;
    Label16: TLabel;
    DBEdit14: TDBEdit;
    Label17: TLabel;
    Label18: TLabel;
    DBText1: TDBText;
    DBText2: TDBText;
    DBRadioGroup2: TDBRadioGroup;
    DBCheckBox2: TDBCheckBox;
    DBCheckBox3: TDBCheckBox;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    Panel2: TPanel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    DBEdit15: TDBEdit;
    DBEdit16: TDBEdit;
    DBEdit17: TDBEdit;
    DBEdit18: TDBEdit;
    DBEdit19: TDBEdit;
    DBEdit20: TDBEdit;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    DBEdit21: TDBEdit;
    Label32: TLabel;
    DBEdit22: TDBEdit;
    BitBtn3: TBitBtn;
    Panel3: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    Label33: TLabel;
    Panel4: TPanel;
    Edit2: TEdit;
    Label34: TLabel;
    BitBtn4: TBitBtn;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Panel6: TPanel;
    DBGrid1: TDBGrid;
    DBComboBox1: TDBComboBox;
    Edit3: TEdit;
    Label35: TLabel;
    DBEdit23: TDBEdit;
    Label36: TLabel;
    Label37: TLabel;
    Label38: TLabel;
    Edit4: TEdit;
    DBEdit24: TDBEdit;
    Label39: TLabel;
    Label40: TLabel;
    Edit5: TEdit;
    DBEdit25: TDBEdit;
    DBGrid2: TDBGrid;
    Label41: TLabel;
    DBEdit26: TDBEdit;
    DBEdit27: TDBEdit;
    DBEdit28: TDBEdit;
    Label42: TLabel;
    DBComboBox2: TDBComboBox;
    Label43: TLabel;
    DBMemo2: TDBMemo;
    Panel8: TPanel;
    Label47: TLabel;
    BitBtn9: TBitBtn;
    DBMemo3: TDBMemo;
    Panel9: TPanel;
    DBMemo4: TDBMemo;
    Panel10: TPanel;
    Label48: TLabel;
    BitBtn10: TBitBtn;
    Panel11: TPanel;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    Edit9: TEdit;
    Label49: TLabel;
    Edit10: TEdit;
    Edit11: TEdit;
    Label50: TLabel;
    Label51: TLabel;
    RadioGroup1: TRadioGroup;
    Edit12: TEdit;
    Label52: TLabel;
    Edit13: TEdit;
    Label53: TLabel;
    Edit14: TEdit;
    Label54: TLabel;
    Edit15: TEdit;
    Label55: TLabel;
    Memo1: TMemo;
    Panel12: TPanel;
    Memo2: TMemo;
    Panel13: TPanel;
    Memo3: TMemo;
    Panel14: TPanel;
    Panel15: TPanel;
    DBGrid3: TDBGrid;
    to_part_ptr: TLabel;
    from_part_ptr: TLabel;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    Label56: TLabel;
    BitBtn11: TBitBtn;
    N4: TMenuItem;
    PopupMenu2: TPopupMenu;
    N5: TMenuItem;
    PopupMenu3: TPopupMenu;
    N6: TMenuItem;
    N7: TMenuItem;
    DBCheckBox4: TDBCheckBox;
    Label57: TLabel;
    Label58: TLabel;
    DBText3: TDBText;
    DBText4: TDBText;
    PopupMenu4: TPopupMenu;
    N8: TMenuItem;
    N9: TMenuItem;
    rkey25: TLabel;
    status: TLabel;
    Label59: TLabel;
    Label60: TLabel;
    Label61: TLabel;
    DBEdit29: TDBEdit;
    DBEdit30: TDBEdit;
    DBEdit31: TDBEdit;
    DBEdit32: TDBEdit;
    DBEdit33: TDBEdit;
    Label62: TLabel;
    Label63: TLabel;
    BitBtn12: TBitBtn;
    Label64: TLabel;
    BitBtn13: TBitBtn;
    PopupMenu5: TPopupMenu;
    N10: TMenuItem;
    BitBtn14: TBitBtn;
    BitBtn15: TBitBtn;
    SpeedButton6: TSpeedButton;
    Panel16: TPanel;
    Label68: TLabel;
    Panel17: TPanel;
    SG2: TStringGrid;
    DBCheckBox5: TDBCheckBox;
    CheckBox2: TCheckBox;
    DBEdit34: TDBEdit;
    Label65: TLabel;
    DBCheckBox6: TDBCheckBox;
    Panel18: TPanel;
    StringGrid2: TStringGrid;
    Label74: TLabel;
    Label75: TLabel;
    BitBtn16: TBitBtn;
    pgc1: TPageControl;
    ts1: TTabSheet;
    ts2: TTabSheet;
    Panel5: TPanel;
    SpeedButton3: TSpeedButton;
    CheckBox1: TCheckBox;
    DBMemo1: TDBMemo;
    pnl2: TPanel;
    btnLoadCYImg: TButton;
    btnClearCY: TButton;
    rg1: TRadioGroup;
    imgCY: TImage;
    lbl1: TLabel;
    dbtxtORIG_CUSTOMER: TDBText;
    dbchkREACH: TDBCheckBox;
    lbl2: TLabel;
    cbb1: TDBComboBox;
    DBGridEh1: TDBGridEh;
    Panel19: TPanel;
    Panel20: TPanel;
    DBGridEh2: TDBGridEh;
    Label66: TLabel;
    Label67: TLabel;
    ComboBox1: TComboBox;
    PopupMenu6: TPopupMenu;
    N11: TMenuItem;
    PopupMenu7: TPopupMenu;
    N12: TMenuItem;
    DBGridEh3: TDBGridEh;
    PopupMenu8: TPopupMenu;
    N13: TMenuItem;
    DBGridEh4: TDBGridEh;
    dbchkREACH1: TDBCheckBox;
    lbl3: TLabel;
    dbedtCompress: TDBEdit;
    lbl4: TLabel;
    dbedtgrade_code: TDBEdit;
    PageControl2: TPageControl;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    StringGrid4: TStringGrid;
    TabSheet6: TTabSheet;
    Panel7: TPanel;
    Label44: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Label78: TLabel;
    Label79: TLabel;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    BitBtn8: TBitBtn;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    isopen: TCheckBox;
    DBEdit36: TDBEdit;
    DBComboBox3: TDBComboBox;
    StringGrid1: TStringGrid;
    StringGrid5: TStringGrid;
    DBCheckBox7: TDBCheckBox;
    DBComboBox4: TDBComboBox;
    Label69: TLabel;
    procedure DBGrid1CellClick(Column: TColumn);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormCreate(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure DBComboBox1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BitBtn2Click(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure DBEdit19KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBEdit20KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBEdit22KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBEdit17KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBEdit18KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBEdit15KeyPress(Sender: TObject; var Key: Char);
    procedure DBEdit21KeyPress(Sender: TObject; var Key: Char);
    procedure DBEdit21KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBEdit17Exit(Sender: TObject);
    procedure DBEdit19Exit(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure DBGrid1ColExit(Sender: TObject);
    procedure DBComboBox1KeyPress(Sender: TObject; var Key: Char);
    procedure SpeedButton1Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure BitBtn11Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure BitBtn9Click(Sender: TObject);
    procedure BitBtn10Click(Sender: TObject);
    procedure StringGrid1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure N7Click(Sender: TObject);
    procedure PopupMenu3Popup(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure StringGrid1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure StringGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
    procedure DBEdit15Exit(Sender: TObject);
    procedure TreeView1Change(Sender: TObject; Node: TTreeNode);
    procedure PopupMenu4Popup(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure N9Click(Sender: TObject);
    procedure BitBtn13Click(Sender: TObject);
    procedure N10Click(Sender: TObject);
    procedure BitBtn12Click(Sender: TObject);
    procedure BitBtn14Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure BitBtn15Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure BitBtn16Click(Sender: TObject);
    procedure rg1Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure N11Click(Sender: TObject);
    procedure N12Click(Sender: TObject);
    procedure N13Click(Sender: TObject);
    procedure PopupMenu6Popup(Sender: TObject);
    procedure PopupMenu7Popup(Sender: TObject);
    procedure PopupMenu8Popup(Sender: TObject);
  private
    { Private declarations }
   OldGridWnd : TWndMethod;
   dbgrid2wnd : TWndMethod;
   file_name:TStringList;
   ecnopen,impedance,ftp:boolean; //是否需要重新打开ecn清单
   FRkey25Arr: array [0..1021] of Integer;
   procedure NewGridWnd (var Message : TMessage);
   procedure NewGrid2Wnd (var Message : TMessage);
   procedure get_picturedata502(rkey25:integer);
   procedure get_value(rkey278:integer);
   procedure get_data0279(rkey25:integer);
   procedure update_deptcode(rkey25:integer);
//   procedure update_tecparameter(rkey25:integer);
   procedure update_IESparameter(rkey25:integer);

   procedure  get_drill(rkey25:integer;ASg: TStringGrid;AFlowNo: Integer;Aedt: tedit);
   function get_employeename(rkey05: integer):string;
   function get_mindrill(ASg: TStringGrid):single;
   function get_customer(rkey10:integer):string;
   procedure update_notebook();
   procedure get_ecninfo(to_part_ptr:integer);
   function find_spec_rkey(spec_rkey: string): boolean;
   procedure update_tecparameter(rkey25:integer);
   procedure update_drill(rkey25:integer);
   procedure get_ecnlist(rkey25:integer);
   function get_date0025toprkey(rkey25: integer):integer;
   procedure get_treedate(rkey25:integer;treeview:Ttreeview);
   procedure get_impedance(rkey25: integer);
  public
     FSg: TStringGrid;
    { Public declarations }
  end;

type
 TMyDBGrid=class(TDBGrid);

var
 Form2: TForm2;

  const
 TmpFileDir = 'c:\tmp\wisdom\';

implementation

uses damo, pcb_cutting,common, route_flow, flowpara_edit, deptcode_search,
  layer_frame, PickEngNote, append_productin, main, prod_search,
  stepnumber_search, layersdata_select, reportselect, report_data,
  product_search,jpeg, Excel2000,PubFunc,IdFTP,ShellAPI;

{$R *.dfm}
procedure TForm2.get_impedance(rkey25: integer);
var i:integer;
begin
for i:=1 to stringgrid2.RowCount-2 do  stringgrid2.Rows[i].Clear;
 with dm.ADOQuery1 do
 begin
  close;
  sql.Text:='select  SEQ_NO,coupon, MARK, layer, refe_layer, line_width, line_ofsight,'+
    'impedance, adjust_linewidth, adjust_lineofsight, adjust_impedance, product_impedance,'+
    'impedance_scope,orig_juli,adjust_jiuli,impedance_first,product_control,adjust_first,adjust_control,'+
    'type from data0030 where source_ptr='+inttostr(rkey25)+' order by seq_no ';
  open;
  stringgrid2.RowCount:=recordcount+2;
  for i:=1 to recordcount do
  begin
   stringgrid2.Cells[0,i]:=trim(fieldbyname('seq_no').AsString);
   stringgrid2.Cells[1,i]:=trim(fieldbyname('type').AsString);//类型
   stringgrid2.Cells[2,i]:=trim(fieldbyname('coupon').AsString);//coupon
   stringgrid2.Cells[3,i]:=trim(fieldbyname('layer').AsString);//层次
   stringgrid2.Cells[4,i]:=trim(fieldbyname('refe_layer').AsString);//参考层
   stringgrid2.Cells[5,i]:=trim(fieldbyname('product_impedance').AsString);//成品阻抗
   stringgrid2.Cells[6,i]:=trim(fieldbyname('adjust_impedance').AsString);//绿油前阻抗
   stringgrid2.Cells[7,i]:=trim(fieldbyname('impedance_scope').AsString);//阻抗控制范围
   stringgrid2.Cells[8,i]:=trim(fieldbyname('line_width').AsString);//客户线宽
   stringgrid2.Cells[9,i]:=trim(fieldbyname('line_ofsight').AsString); //客户线距;
   stringgrid2.Cells[10,i]:=trim(fieldbyname('orig_juli').AsString); //原始到铜皮距离;
   stringgrid2.Cells[11,i]:=trim(fieldbyname('adjust_linewidth').AsString); //调整线宽;
   stringgrid2.Cells[12,i]:=trim(fieldbyname('adjust_lineofsight').AsString); //调整线距;
   stringgrid2.Cells[13,i]:=trim(fieldbyname('adjust_jiuli').AsString); //调整后到铜皮距离;
    stringgrid2.Cells[14,i]:=trim(fieldbyname('impedance_first').AsString); //成品首件控制
   stringgrid2.Cells[15,i]:=trim(fieldbyname('product_control').AsString); //成品控制
   stringgrid2.Cells[16,i]:=trim(fieldbyname('adjust_first').AsString); //绿油前首件控制
   stringgrid2.Cells[17,i]:=trim(fieldbyname('adjust_control').AsString);  //绿油前控制
   next;
  end;
  impedance:=true;
 end;
end;

procedure Tform2.get_ecnlist(rkey25:integer);
var i:byte;
begin
 with dm.ADOQuery1 do
 begin
  close;
  sql.Text:='select serial_no,part_number,text,source,if_gerber,'
    +'engineer,enter_date,ecn_no,create_employee '
    +' from data0035 where part_ptr='+inttostr(rkey25)+' order by serial_no ';
  open;
  sg2.RowCount:=recordcount+2;
  for i:=1 to recordcount do
  begin
   sg2.Cells[0,i]:=inttostr(i);
   sg2.Cells[1,i]:=trim(fieldbyname('part_number').AsString);
   sg2.Cells[2,i]:=trim(fieldbyname('text').AsString);
   sg2.Cells[3,i]:=trim(fieldbyname('source').AsString);
   sg2.Cells[4,i]:=trim(fieldbyname('if_gerber').AsString);
   sg2.Cells[5,i]:=trim(fieldbyname('engineer').AsString);
   sg2.Cells[6,i]:=trim(fieldbyname('enter_date').AsString);
   sg2.Cells[7,i]:=trim(fieldbyname('ecn_no').AsString);
   sg2.Cells[8,i]:=trim(fieldbyname('create_employee').AsString);
   next;
  end;
  ecnopen:=true;
 end;
end;

function TForm2.find_spec_rkey(spec_rkey: string): boolean;
begin
dm.ads279.DisableControls;
result:=false;
dm.ads279.First;
while not dm.ads279.Eof do
 begin
  if trim(dm.ads279SPEC_RKEY.Value)=spec_rkey then
   begin
    result:=true;
    break;
   end;
  dm.ads279.Next;
 end;
dm.ads279.EnableControls;
end;

procedure TForm2.get_ecninfo(to_part_ptr:integer);
begin
with dm.ADOQuery1 do
begin
 close;
 sql.Text:='SELECT dbo.Data0273.ECN_NO, dbo.Data0273.text, dbo.Data0273.remark,'+#13+
      'Data0005_1.EMPLOYEE_NAME AS ent_emplname, dbo.Data0273.ENTERED_DATE,'+#13+
      'data0005_2.EMPLOYEE_NAME AS modi_emplname, dbo.Data0273.last_modi_date,'+#13+
      'data0273.SOURCE, dbo.Data0273.TEXT1, dbo.Data0273.TEXT3,'+#13+
      'data0025_1.MANU_PART_NUMBER AS from_partnumber,'+#13+
      'Data0025_2.MANU_PART_NUMBER AS to_partnumber,'+#13+
      'Data0273.COPYFROMCUST_PTR, dbo.Data0273.CUSTOMER_PART_PTR'+#13+
      'FROM dbo.Data0273 INNER JOIN'+#13+
      'dbo.Data0005 Data0005_1 ON'+#13+
      'dbo.Data0273.ENTERED_BY = Data0005_1.RKEY INNER JOIN'+#13+
      'dbo.Data0025 data0025_1 ON'+#13+
      'dbo.Data0273.COPYFROMCUST_PTR = data0025_1.RKEY INNER JOIN'+#13+
      'dbo.Data0025 Data0025_2 ON'+#13+
      'dbo.Data0273.CUSTOMER_PART_PTR = Data0025_2.RKEY LEFT OUTER JOIN'+#13+
      'dbo.Data0005 data0005_2 ON dbo.Data0273.last_modi_by_ptr = data0005_2.RKEY'+#13+
      'where data0273.CUSTOMER_PART_PTR='+inttostr(to_part_ptr);
 open;
 if not isempty then
 begin
  edit9.Text:=fieldbyname('ECN_NO').AsString;
  edit10.Text:=fieldbyname('from_partnumber').AsString;
  edit11.Text:=fieldbyname('to_partnumber').AsString;
  edit12.Text:=fieldbyname('ent_emplname').AsString;
  edit13.Text:=fieldbyname('ENTERED_DATE').AsString;
  edit14.Text:=fieldbyname('modi_emplname').AsString;
  edit15.Text:=fieldbyname('last_modi_date').AsString;
  radiogroup1.ItemIndex:=fieldbyname('source').AsInteger;
  memo2.Text:=fieldbyname('text').AsString;
  memo1.Text:=fieldbyname('remark').AsString;
  self.to_part_ptr.Caption:=fieldbyname('CUSTOMER_PART_PTR').AsString;
  self.from_part_ptr.Caption:=fieldbyname('COPYFROMCUST_PTR').AsString;
 end
else
 begin
  self.from_part_ptr.Caption:='0';
 end;
end;
end;

procedure TForm2.update_notebook;
begin
 dm.AQY0025.Close;
 dm.ads502.Close;
 dm.ads279.Close;
 dm.ADS38.Close;
 dm.ads494.Close;
 dm.ADS279_0.Close;
 dm.ads89.Close;
 edit3.Text:='';  //最后修改人
 isopen.Checked:=false;  //钻孔表需要重新打开
 ecnopen:=false; //ecn清单需要重新打开
 impedance:=false;//阻抗表需要重新打开
 memo2.ReadOnly:=false;  //ECN需要重新打开
 memo3.ReadOnly:=false;  //客户信息需要重新打开
end;

procedure  TForm2.get_value(rkey278:integer);
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
    DBComboBox1.Items.Clear;
    while not dm.adoquery1.eof do
     begin
      DBComboBox1.Items.Add(trim(dm.adoquery1.FieldValues['tvalue']));
      dm.adoquery1.Next;
     end;
   end
  else
   DBComboBox1.Items.Clear;
end;

procedure TForm2.NewGridWnd(var Message: TMessage);
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

procedure TForm2.NewGrid2Wnd(var Message: TMessage);
var
 IsNeg : Boolean;
begin
 if Message.Msg = WM_MOUSEWHEEL then
 begin
   IsNeg := Short(Message.WParamHi) < 0;
   if IsNeg then
     DBGrid2.DataSource.DataSet.MoveBy(1)
   else
     DBGrid2.DataSource.DataSet.MoveBy(-1)
 end
 else
   dbgrid2wnd(Message);
end;

procedure TForm2.get_picturedata502(rkey25:integer);
begin
 image1.Picture.Assign(nil);
 image2.Picture.Assign(nil);
 image3.Picture.Assign(nil);
 image1.Canvas.Brush.Color:=clwhite;
 image2.Canvas.Brush.Color:=clwhite;
 image3.Canvas.Brush.Color:=clwhite;
 dm.ads502.Close;
 dm.ads502.Parameters[0].Value:=rkey25;
 dm.ads502.Open;
 if not dm.ads502.IsEmpty then
 begin
 
  image1.Picture.Assign(Load_JPG_Pic_From_DB(dm.ads502sheet_BMP));

  if dm.ads502PNL_LEN.Value>0 then
   image2.Picture.Assign(Load_JPG_Pic_From_DB(dm.ads502pnl_bmp));
  if dm.ads502PNL_LEN_2.Value>0 then
   image3.Picture.Assign(Load_JPG_Pic_From_DB(dm.ads502pnl2_bmp));
 end;
end;


procedure TForm2.get_data0279(rkey25:integer);
begin
  dm.ads279.DisableControls;
  dm.ads279.close;
  dm.ads279.Parameters[0].Value:=rkey25;
  dm.ads279.Open;

  with dm.ADOQuery1 do
  begin
   close;
   sql.Text:=
   'SELECT TOP 100 PERCENT RKEY,SEQUENCE_NO FROM dbo.Data0278'+#13+
   'WHERE (CATEGORY_PTR = 2)'+#13+
   'ORDER BY SEQUENCE_NO';
   open;
  end;

  if dm.ads279.IsEmpty then
   begin
    while not dm.ADOQuery1.Eof do
     begin
      dm.ads279.Append;
      dm.ads279source_PTR.Value := rkey25;
      dm.ads279parameter_ptr.Value := dm.ADOQuery1.FieldValues['rkey'];
      dm.ads279IES_PROD.Value:=1;       //代表全局参数0代表流程判断参数
      dm.ads279IES_CRP.AsVariant:=dm.ADOQuery1.FieldValues['SEQUENCE_NO'];//排序字段
      dm.ads279.Post;
      dm.ADOQuery1.Next;
     end;
    dm.ADOQuery1.Close;
    dm.ads279.First;
   end
  else
   begin
    while not dm.ADOQuery1.Eof do
     begin
      if not dm.ads279.Locate('parameter_ptr',dm.ADOQuery1.FieldValues['rkey'],[]) then
       begin
        dm.ads279.Append;
        dm.ads279source_PTR.Value:=rkey25;
        dm.ads279parameter_ptr.Value:=dm.ADOQuery1.FieldValues['rkey'];
        dm.ads279IES_PROD.Value:=1;
        dm.ads279IES_CRP.AsVariant:=dm.ADOQuery1.FieldValues['SEQUENCE_NO'];//排序字段
        dm.ads279.Post;
       end;
       dm.ADOQuery1.Next;
     end;
    dm.ADOQuery1.Close;
    dm.ads279.First;
   end;

  dm.ads279.EnableControls;
end;

function TForm2.get_mindrill(ASg: TStringGrid):single;
var
 min_drill:single;
 i:integer;
begin
 try
  if ASg.Cells[6,1] <> '' then
    min_drill:= strtocurr(ASg.Cells[6,1]);
 except
  min_drill:=0;
 end;

 if ASg.RowCount>3 then
 for i:=2 to ASg.RowCount-2 do
 begin
    if ASg.Cells[6,i] <> '' then
    begin
      try
       strtofloat(ASg.Cells[6,i]);
      except
       Continue;
      end;
      if  strtofloat(ASg.Cells[6,i]) < min_drill then
       min_drill:= strtocurr( ASg.Cells[6,i]);
    end;
 end;
 result:=min_drill;
end;

procedure TForm2.update_tecparameter(rkey25:integer);
begin
with dm.ADOQuery1 do
 begin
  close;
  sql.Text:=
  'SELECT PARAMETER_PTR, PARAMETER_VALUE, custpart_ptr, step_number,'+#13+
  ' seq_no, Doc_Flag, after_flag, flow_spfc_flag'+#13+
  'FROM dbo.Data0494'+#13+
  'where custpart_ptr='+inttostr(rkey25);
  open;
 end;

dm.ads494.Filter:='';
dm.ads494.First;
while not dm.ads494.Eof do
begin
   dm.ADOQuery1.AppendRecord([dm.ads494PARAMETER_PTR.Value,
                              dm.ads494PARAMETER_VALUE.Value,
                              dm.ads494custpart_ptr.Value,
                              dm.ads494step_number.Value,
                              dm.ads494seq_no.Value,
                              dm.ads494Doc_Flag.Value,
                              dm.ads494after_flag.Value,
                              dm.ads494flow_spfc_flag.Value
                              ]);
 dm.ads494.Next;
end;


end;

procedure TForm2.update_drill(rkey25:integer);
var
 i:integer;
begin
with dm.ADOQuery1 do
begin
 close;
 sql.Text:='delete from data0029 where source_ptr='+inttostr(rkey25);
 execsql;
end;

with dm.ADOQuery1 do
 begin
  close;
  sql.Text:=
  'SELECT SOURCE_PTR,SEQ_NR, MARK, HOLES_DIA, PTH, TOLERANCE, DRILL_DIA,'+#13+
  'UNIT, PANEL_A, PANEL_B, REMARK,SEQ_NO'+#13+
  'FROM dbo.Data0029'+#13+
  'where source_ptr='+inttostr(rkey25);
  open;
 end;
  for i:=1 to stringgrid1.RowCount-2 do
   dm.ADOQuery1.AppendRecord([rkey25,
                              stringgrid1.Cells[0,i],
                              stringgrid1.Cells[1,i],
                              stringgrid1.Cells[2,i],
                              stringgrid1.Cells[3,i],
                              stringgrid1.Cells[4,i],
                              stringgrid1.Cells[5,i],
                              stringgrid1.Cells[6,i],
                              stringgrid1.Cells[7,i],
                              stringgrid1.Cells[8,i],
                              stringgrid1.Cells[9,i],
                              i]);
end;

procedure  TForm2.get_drill(rkey25:integer;ASg: TStringGrid;AFlowNo: Integer;AEdt: tedit);
var i:integer;
begin
for i:=1 to asg.RowCount-2 do  asg.Rows[i].Clear;
with dm.ADOQuery1 do
begin
 close;                                                            
 sql.Text:=' SELECT DG_ADJ_PTH, DG_ADJ_NPTH FROM Data0008'+#13+
            'where rkey='+dm.AQY0025PROD_CODE_PTR.AsString;
 open;
 edit7.Text:=fieldbyname('dg_adj_pth').AsString;
 edit8.Text:=fieldbyname('dg_adj_npth').AsString;
end;

with dm.ADOQuery1 do
 begin
  close;
  sql.Text:=
  'SELECT TOP 100 PERCENT SEQ_NR, MARK, HOLES_DIA, PTH, TOLERANCE, DRILL_DIA,'+#13+
  'UNIT, PANEL_A, PANEL_B, REMARK,SET_UNMBER,flow_no'+#13+
  'FROM dbo.Data0029'+#13+
  'where source_ptr='+inttostr(rkey25)+#13+
  ' and flow_no = ' + IntToStr(aflowno) +
  'ORDER BY SEQ_NO';
  open;



  asg.RowCount:=RecordCount+2;
  for i:=1 to RecordCount do
   begin
    asg.Cells[0,i]:=inttostr(i);
    asg.Cells[1,i]:=trim(fieldbyname('SEQ_NR').AsString); //'刀具';
    asg.Cells[2,i]:=trim(fieldbyname('MARK').AsString);//'符号';
    asg.Cells[3,i]:=trim(fieldbyname('HOLES_DIA').AsString);//'成品孔径';
    asg.Cells[4,i]:=trim(fieldbyname('PTH').AsString);//'PTH';
    asg.Cells[5,i]:=trim(fieldbyname('TOLERANCE').AsString);//'公差';
    asg.Cells[6,i]:=trim(fieldbyname('DRILL_DIA').AsString);//'钻咀';
    asg.Cells[7,i]:=trim(fieldbyname('UNIT').AsString);//'PCS孔数';
    asg.Cells[8,i]:=trim(fieldbyname('SET_UNMBER').AsString);//'SET孔数';
    asg.Cells[9,i]:=trim(fieldbyname('PANEL_A').AsString);//'A板孔数';
    asg.Cells[10,i]:=trim(fieldbyname('PANEL_B').AsString);//'B板孔数';
    asg.Cells[11,i]:=trim(fieldbyname('REMARK').AsString);//'备注';
    next;
   end;
 end;
 AEdt.Text:=formatfloat('0.00',(get_mindrill(asg)));
 isopen.Checked:=true;
end;

function tform2.get_customer(rkey10:integer):string;
begin
with dm.ADOQuery1 do
 begin
  close;
  sql.Clear;
  sql.Add('select RemarkSpec from data0010 where rkey = ' + inttostr(rkey10));
  open;
  if not IsEmpty then
   result:=FieldValues['RemarkSpec']
  else
   result:='';
 end;
end;

function TForm2.get_date0025toprkey(rkey25: integer):integer;
var
 rkey:integer;
begin
with dm.ADOQuery2 do
 begin
  close;
  sql.Text:='select parent_ptr from data0025 where rkey='+inttostr(rkey25);
  open;
  rkey := fieldbyname('parent_ptr').AsInteger; //等于父值
 end;

 if rkey <= 0 then
  rkey:=rkey25       //如果产是顶层等于自己
 else
  with dm.ADOQuery2 do
  begin
   close;
   sql.Text:='select parent_ptr from data0025 where rkey='+inttostr(rkey);
   open;
   if FieldByName('parent_ptr').AsInteger > 0 then
    begin
    rkey := fieldbyname('parent_ptr').AsInteger;  //如果有爷爷等于爷爷值
    with dm.ADOQuery3 do
     begin
      close;
      sql.Text:='select parent_ptr from data0025 where rkey='+inttostr(rkey);
      open;
      if FieldByName('parent_ptr').AsInteger > 0 then
        rkey := fieldbyname('parent_ptr').AsInteger;  //如果有太公等于太公值
     end;
    end;
  end;
 result:=rkey;
end;

procedure TForm2.get_treedate(rkey25: integer;treeview:Ttreeview);
var
 node:ttreenode;   //treeview控件的节点变量
 rkey0025:^integer;
 LSql: string;

 LNode: TTreeNode;
 LPRkey25: PInteger1;
 LNodeArr: array of TTreeNode;
 I: Integer;
 n: Integer;
begin
  for I := 0 to Length(FRkey25Arr) - 1 do FRkey25Arr[I] := -1;
  N := 0;
  LSql := ';WITH CTE(RKey,Lv,MANU_PART_NUMBER,PARENT_PTR) ' +
    ' AS (SELECT RKey,0,MANU_PART_NUMBER,PARENT_PTR ' +
    ' FROM Data0025 WHERE RKey = '+ IntToStr(rkey25) +' UNION ALL  ' +
    ' SELECT D25.RKey,CTE.Lv+1,D25.MANU_PART_NUMBER,d25.PARENT_PTR ' +
    ' FROM Data0025 D25 INNER JOIN CTE ON D25.PARENT_PTR = CTE.RKey ) SELECT * FROM CTE ORDER BY lv asc';
  DM.ADOQuery1.Close;
  DM.ADOQuery1.SQL.Text := LSql;
  DM.ADOQuery1.Open;
  while not DM.ADOQuery1.Eof do
  begin
    if DM.ADOQuery1.FieldByName('PARENT_PTR').AsInteger = 0 then
    begin
      LNode := treeview.Items.AddChild(nil,DM.ADOQuery1.FieldByName('MANU_PART_NUMBER').AsString);
    end else
    begin
      for I := 0 to Length(LNodeArr) - 1 do
      begin
        if Pinteger1(LNodeArr[I].Data)^ = DM.ADOQuery1.FieldByName('PARENT_PTR').AsInteger then
        begin
          LNode := treeview.Items.AddChild(LNodeArr[I],DM.ADOQuery1.FieldByName('MANU_PART_NUMBER').AsString);
          Break;
        end;
      end;
    end;


    //SetLength(FRkey25Arr,Length(FRkey25Arr)+1);
    //N := High(FRkey25arr);
    FRkey25Arr[N] := DM.ADOQuery1.FieldByName('rkey').AsInteger;
    LNode.Data := @FRkey25Arr[N];
    //ShowMessage(IntToStr(Pinteger1(LNode.Data)^));

    SetLength(LNodeArr,Length(LNodeArr) + 1);
    LNodeArr[N] := LNode;

    N := N +1;
    DM.ADOQuery1.Next;
  end;

  treeview.FullExpand; //全部展开
  treeview.Items[0].Selected:=true;
  Exit;

with dm.ADOQuery1 do
 begin
  close;
  sql.Text:='select rkey,MANU_PART_NUMBER from data0025 where rkey='+
              inttostr(get_date0025toprkey(rkey25));
  open;
  new(rkey0025);
  rkey0025^:=fieldvalues['rkey'];
  node:=treeview.Items.AddObject
  (nil,fieldbyname('MANU_PART_NUMBER').AsString,rkey0025); //增加顶层节点
  node.ImageIndex:=0;  //为第一层节点定义图画
 end;

with dm.ADOQuery1 do
 begin
  close;
  sql.Text:='select rkey,MANU_PART_NUMBER from data0025 where parent_ptr='+
              inttostr(get_date0025toprkey(rkey25));
  open;
  while not dm.ADOQuery1.Eof do
  begin
   new(rkey0025);
   rkey0025^:= dm.ADOQuery1.fieldvalues['rkey'];
   node:=treeview.Items.AddChildObject
      (node,fieldbyname('MANU_PART_NUMBER').AsString,rkey0025);
   node.ImageIndex := 1;
   with dm.ADOQuery2 do
    begin
     close;
     sql.Text:='select rkey,MANU_PART_NUMBER from data0025 where parent_ptr='+
              dm.ADOQuery1.fieldbyname('rkey').AsString;
     open;
     while not dm.ADOQuery2.Eof do
     begin
      new(rkey0025);
      rkey0025^:= dm.ADOQuery2.fieldvalues['rkey'];
      node:=treeview.Items.AddChildObject
       (node, dm.ADOQuery2.fieldbyname('MANU_PART_NUMBER').AsString,rkey0025);
      node.ImageIndex := 2;
       with dm.ADOQuery3 do
        begin
         close;
         sql.Text:='select rkey,MANU_PART_NUMBER from data0025 where parent_ptr='+
                  dm.ADOQuery2.fieldbyname('rkey').AsString;
         open;
         while not dm.ADOQuery3.Eof do
         begin
          new(rkey0025);
          rkey0025^:= dm.ADOQuery3.fieldvalues['rkey'];
          node:=treeview.Items.AddChildObject
           (node, dm.ADOQuery3.fieldbyname('MANU_PART_NUMBER').AsString,rkey0025);
          node.ImageIndex := 3;
          node:=node.Parent;
          dm.ADOQuery3.Next;
         end;
        end;
      node:=node.Parent;
      dm.ADOQuery2.Next;
     end;
    end;
   node:=node.Parent; //节点指向其父节点值
   dm.ADOQuery1.Next;
  end;
 end;

 treeview.FullExpand; //全部展开
 treeview.Items[0].Selected:=true;
end;

function TForm2.get_employeename(rkey05: integer):string;
begin
 with dm.ADOQuery1 do
 begin
  close;
  sql.Text:='select employee_name from data0005'+#13+
             'where rkey='+inttostr(rkey05);
  open;
  if isempty then
   result:=''
  else
   result:=fieldbyname('employee_name').asstring;
 end;
end;

procedure TForm2.DBGrid1CellClick(Column: TColumn);
begin
if column.Index<4 then dbgrid1.SelectedIndex:=4;
end;

procedure TForm2.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
if (gdFocused in State) then
 begin
  if (column.FieldName = DBComboBox1.DataField ) then
   begin
    DBComboBox1.Left := Rect.Left+1;
    DBComboBox1.Top := Rect.Top+2;
    DBComboBox1.Width := Rect.Right - Rect.Left+3;
    DBComboBox1.Height := Rect.Bottom - Rect.Top;
    self.get_value(dm.ads279PARAMETER_PTR.Value);
    if dbcombobox1.Items.Count > 0 then
     DBComboBox1.Visible := True
    else
     DBComboBox1.Visible := false;
   end;
 end;

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
  if dm.ads279status3.Value=1 then
   Canvas.Font.Color := clred;

  DefaultDrawColumnCell(Rect,DataCol,Column,State);
 end;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
 OldGridWnd := DBGrid1.WindowProc ;
 DBGrid1.WindowProc := NewGridWnd;
  file_name:=tstringlist.Create;
 DBGrid2Wnd := DBGrid2.WindowProc ;
 DBGrid2.WindowProc := NewGrid2Wnd;
end;

procedure TForm2.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if (key=40) and        //如果是下箭头如果是最后一条记录
  (dm.ads279.RecNo=dm.ads279.RecordCount) then abort;
 if key=45 then abort; //insert键
 if (key=46) and (ssCtrl in shift) then abort;//删除记录
 if (key=112) and
    (dbcombobox1.Visible) and
    (dbcombobox1.Enabled) then
  begin                         //F1键出现下拉
   dbcombobox1.SetFocus;
   dbcombobox1.DroppedDown:=true;
  end;
end;

procedure TForm2.DBGrid1KeyPress(Sender: TObject; var Key: Char);
begin
 if dm.ads279datatype.Value='数字' then
 if not (key in ['0'..'9','.',#8,#13]) then  //判断是否输入数字
  abort;

if (key <> chr(9)) then
 begin
  if (DBGrid1.SelectedField.FieldName =DBComboBox1.DataField) and
     (dbcombobox1.Items.Count > 0) and
     (dbcombobox1.Enabled) then
   begin
    DBComboBox1.SetFocus;
    SendMessage(DBComboBox1.Handle,WM_Char,word(Key),0);
   end;
 end;
end;

procedure TForm2.DBComboBox1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key=112 then dbcombobox1.DroppedDown:=true; //F1键出现下拉
if key=13 then dbgrid1.SetFocus;
end;

procedure TForm2.BitBtn2Click(Sender: TObject);
begin
 self.ModalResult:=mrcancel;
end;

procedure TForm2.ListBox1Click(Sender: TObject);
var
  LCYImg: TjpegImage;
begin
if dm.AQY0025RKEY.Value <> strtoint(rkey25.Caption) then
 begin
  if bitbtn11.Enabled then
  if messagedlg('更换线路层编辑,是否自动保存数据?',mtconfirmation,[mbyes,mbno],0)=mryes then
   bitbtn11click(sender);

  self.update_notebook;
  dm.AQY0025.Close;
  dm.AQY0025.Parameters[0].Value:=strtoint(rkey25.Caption);
  dm.AQY0025.Open;
  
  dm.AQY0025.Edit;
  dm.AQY0025LAST_MODIFIED_DATE.Value := getsystem_date(dm.adoquery1,1);
  dm.AQY0025LAST_MODIFIED_BY_PTR.Value:=strtoint(user_ptr);
 end;

  if not VarIsNull(DM.AQY0025.FieldByName('layers_image').Value) then
 begin
  LCYImg := Load_JPG_Pic_From_DB(DM.AQY0025.FieldByName('layers_image'));
  imgCY.Picture.Bitmap.Assign(LCYImg);
  LCYImg.Free;
 end;

if strtoint(status.Caption)=0 then
begin
 if not bitbtn1.Enabled then bitbtn1.Enabled:=true;
 if not bitbtn11.Enabled then bitbtn11.Enabled:=true;
 if not bitbtn14.Enabled then bitbtn14.Enabled:=true;
 if not bitbtn15.Enabled then bitbtn15.Enabled:=true;
end;

screen.Cursor:=crappstart;
checkbox2.Checked:=trim(dm.AQY0025current_rev.Value)='Y';
 if edit3.Text = '' then    //打开修订人员
 begin
  edit3.Text:=self.get_employeename(dm.AQY0025LAST_MODIFIED_BY_PTR.Value);
  edit4.Text:=self.get_employeename(dm.AQY0025CHECK_BY_PTR.Value);
  edit5.Text:=self.get_employeename(dm.AQY0025AUDITED_BY_PTR.Value);
  with dm.ADOQuery1 do
  begin
   close;
   sql.Text:='select PROD_CODE,PRODUCT_NAME from data0008'+#13+
             'where rkey='+dm.AQY0025PROD_CODE_PTR.AsString;
   open;
   edit1.Text:=fieldbyname('PROD_CODE').AsString;
   label15.Caption:=fieldbyname('PRODUCT_NAME').AsString;
  end;

  IF (DM.AQY0025PARENT_PTR.Value>0)  then
  begin
   dbedit32.Visible:=true;
   dbedit33.visible:=true;
   dbedit34.Visible:=true;
   label65.Visible:=true;
   bitbtn12.visible:=true;
   label64.Visible:=true;
   label62.Visible:=true;
   label63.Visible:=true;
   label64.Caption:='';
    with dm.ADOQuery1 do
    begin
     close;
     sql.Text:='SELECT dbo.Data0038.STEP_NUMBER, dbo.Data0034.DEPT_CODE,'+#13+
        'dbo.Data0034.DEPT_NAME, dbo.Data0034.BARCODE_ENTRY_FLAG'+#13+
         'FROM dbo.Data0038 INNER JOIN'+#13+
        'dbo.Data0034 ON dbo.Data0038.DEPT_PTR = dbo.Data0034.RKEY'+#13+
        'where data0038.SOURCE_PTR='+dm.AQY0025PARENT_PTR.AsString+#13+
        'and Data0038.STEP_NUMBER='+dm.AQY0025BOM_STEP.AsString;
     open;
     if not isempty then
      label64.Caption:=fieldbyname('DEPT_NAME').AsString;
    end;

  end
  else
  begin
   dbedit32.Visible:=false;
   dbedit33.Visible:=false;
   bitbtn12.Visible:=false;
   label64.Visible:=false;
   label64.Visible:=false;
   label62.Visible:=false;
   label63.Visible:=false;
   dbedit34.Visible:=false;
   label65.Visible:=false;
  end;

 end;

 if not dm.ads502.Active then
 self.get_picturedata502(dm.AQY0025RKEY.Value); //打开拼版图

 if not dm.ads279.Active then
  self.get_data0279(dm.AQY0025RKEY.Value);       //打开全局参数

 if not dm.ADS38.Active then
 BEGIN
  dm.ADS38.Close;                         //打开工艺流程
  dm.ADS38.Parameters[0].Value:=dm.AQY0025RKEY.Value;
  dm.ADS38.Open;
  dm.ads494.Close;                      //制程参数
  dm.ads494.Parameters[0].Value:=dm.AQY0025RKEY.Value;
  DM.ads494.Open;
  dm.ADS279_0.close;                       //流程判断参数
  dm.ADS279_0.Parameters[0].Value:=dm.AQY0025RKEY.Value;
  dm.ADS279_0.Open;
  dm.ads26.Close;                      //BOM
  dm.ads26.Parameters[0].Value:=dm.AQY0025RKEY.Value;
  dm.ads26.Open;
  if dm.AQY0025ENG_ROUTE_PTR.Value>0 then
  with dm.ADOQuery1 do
  begin
   close;
   sql.Text:='select ENG_FLOW_NAME,ENG_FLOW_DESC from data0504'+#13+
             'where rkey='+dm.AQY0025ENG_ROUTE_PTR.AsString;
   open;
   edit2.Text:=fieldbyname('ENG_FLOW_NAME').AsString;
   label56.Caption:=fieldbyname('ENG_FLOW_DESC').AsString;
  end;
 END;

 if not isopen.Checked then
 begin
  self.get_drill(dm.AQY0025RKEY.Value,StringGrid1,0,edit6); //打开钻孔表
  self.get_drill(dm.AQY0025RKEY.Value,StringGrid4,1,edit6); //打开钻孔表
  self.get_drill(dm.AQY0025RKEY.Value,StringGrid5,2,edit6); //打开钻孔表
  edit6.Text:=formatfloat('0.00',(get_mindrill(StringGrid1)));
 end;
 //self.get_drill(dm.AQY0025RKEY.Value);          //打开钻孔表

 if treeview1.Selected.Level=0 then       //顶层产品时需打开
 begin
 if ecnopen=false then
 begin
  get_ecnlist(dm.AQY0025RKEY.Value); //打开ECN履历表
      dm.ADS564.Close;                         //打开工艺相关文档
    dm.ADS564.Parameters[0].Value:=dm.AQY0025RKEY.Value;
    dm.ADS564.Open;
    while not dm.ads564.Eof do
    begin
     file_name.Add(dm.ads564file_name.Value+';'+'1');
     dm.ads564.Next;
    end;
    dm.ads564.First;
 end;

 if not impedance then                          //打开阻抗表
   self.get_impedance(dm.AQY0025RKEY.Value);

 if not memo2.ReadOnly then                    //打开ECN工程更改
  begin
   self.get_ecninfo(dm.AQY0025RKEY.Value);
   memo2.ReadOnly:=true;
  end;

 if not dm.ads89.Active then
  dm.ads89.Open;                                //打开评审信息

 if not memo3.ReadOnly then                    //打开客户特殊信息
  begin
   memo3.Text:=self.get_customer(dm.AQY0025CUSTOMER_PTR.Value);
   memo3.ReadOnly:=true;
  end;
    if not ftp then
   begin
     with DM.qryFileList do
     begin
       Close;
       Parameters[0].Value:= DM.ADS25rkey.Value;
       open;
     end;

     with DM.qryFtp do
     begin
       Close;
       Parameters[0].Value:= DM.qryFileList.FieldByName('FtpIDKey').AsString;
       Open;
     end;

     with DM.qryFile do
     begin
       Close;
       Parameters[0].Value:= DM.ADS25rkey.Value;
       Open;
     end;


     with DM.qryFileList2 do
     begin
       Close;
       Parameters[0].Value:= DM.ADS25rkey.Value;
       open;
     end;

     with DM.qryFtp2 do
     begin
       Close;
       Parameters[0].Value:= DM.qryFileList2.FieldByName('FtpIDKey').AsString;
       Open;
     end;

     with DM.qryFile2 do
     begin
       Close;
       Parameters[0].Value:= DM.ADS25rkey.Value;
       Open;
     end;

     ftp:=True;
   end;
 end;
 notebook1.PageIndex:=listbox1.ItemIndex+1;
 headercontrol1.Sections[2].Text:=listbox1.Items[listbox1.ItemIndex];
 screen.Cursor:=crdefault;
end;

procedure TForm2.FormActivate(Sender: TObject);
begin
 self.get_treedate(dm.AQY0025RKEY.Value,treeview1);
 notebook1.PageIndex:=0;
 stringgrid1.Cells[0,0]:='序';
 stringgrid1.Cells[1,0]:='刀具';
 stringgrid1.Cells[2,0]:='符号';
 stringgrid1.Cells[3,0]:='成品孔径';
 stringgrid1.Cells[4,0]:='PTH';
 stringgrid1.Cells[5,0]:='公差';
 stringgrid1.Cells[6,0]:='钻咀';
 stringgrid1.Cells[7,0]:='PCS孔数';
 stringgrid1.Cells[8,0]:='SET孔数';

 stringgrid1.Cells[9,0]:='A板孔数';
 stringgrid1.Cells[10,0]:='B板孔数';
 stringgrid1.Cells[11,0]:='备注';


  stringgrid4.Cells[0,0]:='序';
 stringgrid4.Cells[1,0]:='刀具';
 stringgrid4.Cells[2,0]:='符号';
 stringgrid4.Cells[3,0]:='成品孔径';
 stringgrid4.Cells[4,0]:='PTH';
 stringgrid4.Cells[5,0]:='公差';
 stringgrid4.Cells[6,0]:='钻咀';
 stringgrid4.Cells[7,0]:='PCS孔数';
 stringgrid4.Cells[8,0]:='SET孔数';

 stringgrid4.Cells[9,0]:='A板孔数';
 stringgrid4.Cells[10,0]:='B板孔数';
 stringgrid4.Cells[11,0]:='备注';


  stringgrid5.Cells[0,0]:='序';
 stringgrid5.Cells[1,0]:='刀具';
 stringgrid5.Cells[2,0]:='符号';
 stringgrid5.Cells[3,0]:='成品孔径';
 stringgrid5.Cells[4,0]:='PTH';
 stringgrid5.Cells[5,0]:='公差';
 stringgrid5.Cells[6,0]:='钻咀';
 stringgrid5.Cells[7,0]:='PCS孔数';
 stringgrid5.Cells[8,0]:='SET孔数';

 stringgrid5.Cells[9,0]:='A板孔数';
 stringgrid5.Cells[10,0]:='B板孔数';
 stringgrid5.Cells[11,0]:='备注';

 sg2.Cells[0,0]:='序号';
 sg2.Cells[1,0]:='厂编版本';
 sg2.Cells[2,0]:='变更内容摘要';
 sg2.Cells[3,0]:='来源';
 sg2.Cells[4,0]:='有无新文件';
 sg2.Cells[5,0]:='工程师';
 sg2.Cells[6,0]:='日期';
 sg2.Cells[7,0]:='ECN编号';
 sg2.ColWidths[8]:=0;

 stringgrid2.Cells[0,0]:='序';
 stringgrid2.Cells[1,0]:='类型';
 stringgrid2.Cells[2,0]:='coupon号';
 stringgrid2.Cells[3,0]:='层次';
 stringgrid2.Cells[4,0]:='参考层';
 stringgrid2.Cells[5,0]:='成品阻抗';
 stringgrid2.Cells[6,0]:='绿油前阻抗';
 stringgrid2.Cells[7,0]:='阻抗控制范围';
 stringgrid2.Cells[8,0]:='客户线宽';
 stringgrid2.Cells[9,0]:='客户线距';
 stringgrid2.Cells[10,0]:='原始到铜皮距离';
 stringgrid2.Cells[11,0]:='调整线宽';
 stringgrid2.Cells[12,0]:='调整线距';
 stringgrid2.Cells[13,0]:='调整后到铜距离';
  stringgrid2.Cells[14,0]:= '成品首件控制';
 stringgrid2.Cells[15,0]:= '成品阻抗控制';
 stringgrid2.Cells[16,0]:= '绿油前首件控制';
 stringgrid2.Cells[17,0]:= '绿油前阻抗控制';
  
 if strtoint(status.Caption)=1 then   //检查状态
 begin
  treeview1.PopupMenu:=nil;
  dbedit1.Enabled:=false;
  dbedit2.Enabled:=false;
  dbedit3.Enabled:=false;
  dbedit4.Enabled:=false;
  dbedit5.Enabled:=false;
  dbedit6.Enabled:=false;
  dbedit7.Enabled:=false;
  dbedit8.Enabled:=false;
  dbedit9.Enabled:=false;
  dbedit10.Enabled:=false;
  dbedit11.Enabled:=false;
  dbedit14.Enabled:=false;
  dbradiogroup1.Enabled:=false;
  dbcheckbox1.Enabled:=false;
  dbchkREACH.Enabled := False;
  dbcheckbox5.Enabled:=false;
  dbcheckbox6.Enabled:=false;  
  checkbox2.Enabled:=false;
  bitbtn12.Enabled:=false;
  bitbtn13.Enabled:=false;
  dbedit32.Enabled:=false;
  dbedit33.Enabled:=false;
  dbedit34.Enabled:=false;
  
  dbedit15.Enabled:=false;
  dbedit16.Enabled:=false;
  dbedit17.Enabled:=false;
  dbedit18.Enabled:=false;
  dbedit19.Enabled:=false;
  dbedit20.Enabled:=false;
  dbedit21.Enabled:=false;
  dbedit22.Enabled:=false;
  dbcombobox2.Enabled:=false;
  bitbtn3.Enabled:=false;

  speedbutton1.Enabled:=false;
  speedbutton2.Enabled:=false;
  dbcombobox1.Enabled:=false;
  dbgrid1.Columns[4].ReadOnly:=true;
  bitbtn4.Enabled:=false;
  dbgrid2.PopupMenu:=self.PopupMenu5;
  speedbutton3.Enabled:=false;
  dbmemo1.ReadOnly:=true;
  dbmemo1.PopupMenu:=nil;
  bitbtn5.Enabled:=false;
  bitbtn6.Enabled:=false;
  bitbtn7.Enabled:=false;
  bitbtn8.Enabled:=false;
  stringgrid1.Options:=stringgrid1.Options+[gorowselect];
  stringgrid1.PopupMenu:=nil;
  bitbtn9.Enabled:=false;
  bitbtn10.Enabled:=false;
  dbmemo2.ReadOnly:=true;
  dbmemo3.ReadOnly:=true;
  dbmemo4.ReadOnly:=true;
  dbedit36.Enabled:=false;       //钻孔叠板数
  DBComboBox3.Enabled:=False;    //钻孔参数
 end;
end;


procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
self.update_notebook();
 file_name.Free;
end;

procedure TForm2.SpeedButton5Click(Sender: TObject);
begin
self.get_ecninfo(dm.AQY0025RKEY.Value);
end;

procedure TForm2.SpeedButton4Click(Sender: TObject);
begin
if strtoint(from_part_ptr.Caption)>0 then
 self.get_ecninfo(strtoint(from_part_ptr.Caption))
else
 messagedlg('变更记当已到最上层!',mtinformation,[mbcancel],0);
end;

procedure TForm2.BitBtn3Click(Sender: TObject);
begin
try
 Application.CreateForm(TFrmPcbCut, FrmPcbCut);
 FrmPcbCut.Label21.Caption:=dm.AQY0025MANU_PART_NUMBER.Value;
 FrmPcbCut.Label23.Caption:=dm.ADS25CUST_CODE.Value;

 FrmPcbCut.Edit1.Text:=dm.AQY0025spell_lngth.AsString;
 FrmPcbCut.Edit3.Text:=dm.AQY0025spell_width.AsString;
 FrmPcbCut.Edit9.Text:=dm.AQY0025spell_qty.AsString;

if FrmPcbCut.ShowModal=mrok then
 begin
  dm.AQY0025spell_lngth.Value:=dm.ads502UNIT_LEN.Value;
  dm.AQY0025spell_width.Value:=dm.ads502UNIT_WTH.Value;
  dm.AQY0025spell_qty.Value:=dm.ads502UNIT_NUM.Value;
  self.DBEdit19Exit(sender);

  if dm.ads502TOTAL_PNLS_1.Value>0 then
  begin
  if find_spec_rkey('P') then //大料总PCS
   begin
    dm.ads279.Edit;
    dm.ads279PARAMETER_VALUE.Value:=inttostr(
                       strtoint(FrmPcbCut.Label36.caption)*
                       dm.ads502UNIT_NUM.Value); //每张大料实际开PCS数
    dm.ads279.Post;
    dm.ads279.First;
   end;

  if find_spec_rkey('5') then //大料利用率
   begin
    dm.ads279.Edit;
    dm.ads279PARAMETER_VALUE.Value:=dm.ads502TUSAGE.AsString;
    dm.ads279.Post;
    dm.ads279.First;
   end;
  end;

  if find_spec_rkey('1') then //PNLA拼版数
   begin
    dm.ads279.Edit;
    dm.ads279PARAMETER_VALUE.Value:=dm.ads502TOTAL_PNLS_1.AsString;
    dm.ads279.Post;
    dm.ads279.First;
   end;

  if find_spec_rkey('3') then //pnla单元数
   begin
    dm.ads279.Edit;
    dm.ads279PARAMETER_VALUE.Value:=inttostr(dm.ads502UPANEL.value*
                                           dm.ads502UNIT_NUM.Value);
    dm.ads279.Post;
    dm.ads279.First;
   end;

  if find_spec_rkey('6') then
   begin
    dm.ads279.Edit;
    dm.ads279PARAMETER_VALUE.Value:=
            DM.ads502PNL_LEN.AsString;       //PNLA长度
    dm.ads279.Post;
    dm.ads279.First;
   end;

  if find_spec_rkey('7') then
   begin
    dm.ads279.Edit;
    dm.ads279PARAMETER_VALUE.Value:=
            DM.ads502PNL_WTH.AsString;       //PNLA宽
    dm.ads279.Post;
    dm.ads279.First;
   end;

  if find_spec_rkey('H') then//PNLA尺寸字符
   begin
    dm.ads279.Edit;
    dm.ads279PARAMETER_VALUE.Value:= DM.ads502PNL_LEN.AsString+
     'mm X '+DM.ads502PNL_WTH.AsString+'mm';
    dm.ads279.Post;
    dm.ads279.First;
   end;


  if dm.ads502PNL_LEN_2.Value>0 then
  begin
  if find_spec_rkey('2') then //PNLB拼版数
   begin
    dm.ads279.Edit;
    dm.ads279PARAMETER_VALUE.Value:=dm.ads502TOTAL_PNLS_2.AsString;
    dm.ads279.Post;
    dm.ads279.First;
   end;
  if find_spec_rkey('4') then //PNLB单元数
   begin
    dm.ads279.Edit;
    dm.ads279PARAMETER_VALUE.Value:=inttostr(dm.ads502UPANEL_2.Value*
                                    dm.ads502UNIT_NUM.Value);
    dm.ads279.Post;
    dm.ads279.First;
   end;
  if find_spec_rkey('8') then
   begin
    dm.ads279.Edit;
    dm.ads279PARAMETER_VALUE.Value:=
            DM.ads502PNL_LEN_2.AsString;       //PNLB长度
    dm.ads279.Post;
    dm.ads279.First;
   end;
  if find_spec_rkey('9') then
   begin
    dm.ads279.Edit;
    dm.ads279PARAMETER_VALUE.Value:=
            DM.ads502PNL_WTH_2.AsString;       //PNLB宽
    dm.ads279.Post;
    dm.ads279.First;
   end;
  if find_spec_rkey('I') then//PNLA尺寸字符
   begin
    dm.ads279.Edit;
    dm.ads279PARAMETER_VALUE.Value:= DM.ads502PNL_LEN_2.AsString+
      'mm X '+DM.ads502PNL_WTH_2.AsString+'mm';
    dm.ads279.Post;
    dm.ads279.First;
   end;
   end;

  image1.Picture.Assign(Load_JPG_Pic_From_DB(dm.ads502sheet_BMP));
  if dm.ads502PNL_LEN.Value>0 then
   image2.Picture.Assign(Load_JPG_Pic_From_DB(dm.ads502pnl_bmp));

  if dm.ads502PNL_LEN_2.Value>0 then
   image3.Picture.Assign(Load_JPG_Pic_From_DB(dm.ads502pnl2_bmp));
 end;
finally
 FrmPcbCut.Free;
end;

end;

procedure TForm2.BitBtn1Click(Sender: TObject);
begin
dm.ADOConnection1.BeginTrans;
try

 dm.AQY0025ANALYSIS_CODE_5.Value:=dm.AQY0025pcs_lngth.AsString+'mm X '+
                                  dm.AQY0025pcs_width.AsString+'mm';
 dm.AQY0025ANALYSIS_CODE_1.Value:=dm.AQY0025set_lngth.AsString+'mm X '+
                                  dm.AQY0025set_width.AsString+'mm';
 dm.AQY0025ANALYSIS_CODE_4.Value:=dm.AQY0025spell_lngth.AsString+'mm X '+
                                  dm.AQY0025spell_width.AsString+'mm';
 dm.AQY0025.Post;
 dm.ads502.UpdateBatch();
 dm.ads279.UpdateBatch();
 dm.ADS279_0.UpdateBatch();

 self.update_deptcode(dm.AQY0025RKEY.Value);
// self.update_tecparameter(dm.AQY0025RKEY.Value);
 Self.update_IESparameter(dm.AQY0025RKEY.Value);
// dm.ADS38.UpdateBatch();

 self.update_tecparameter(dm.AQY0025RKEY.Value);

 self.update_drill(dm.AQY0025RKEY.Value);  //更新钻孔表

 dm.ADOConnection1.CommitTrans;
 self.ModalResult:=mrok;
except
 on E: Exception do
  begin
   dm.ADOConnection1.RollbackTrans;
   messagedlg(E.Message,mterror,[mbcancel],0);
  end;
end;

end;

procedure TForm2.DBEdit19KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if (chr(key)='D') and (ssCtrl in shift) then
 dm.AQY0025spell_lngth.Value:=dm.AQY0025set_lngth.Value;

end;

procedure TForm2.DBEdit20KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if (chr(key)='D') and (ssCtrl in shift) then
 dm.AQY0025spell_width.Value:=dm.AQY0025set_width.Value;
end;

procedure TForm2.DBEdit22KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if (chr(key)='D') and (ssCtrl in shift) then
 dm.AQY0025spell_qty.Value:=dm.AQY0025set_qty.Value;
end;

procedure TForm2.DBEdit17KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if (chr(key)='D') and (ssCtrl in shift) then
 dm.AQY0025set_lngth.Value:=dm.AQY0025pcs_lngth.Value;
end;

procedure TForm2.DBEdit18KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if (chr(key)='D') and (ssCtrl in shift) then
 dm.AQY0025set_width.Value:=dm.AQY0025pcs_width.Value;
end;

procedure TForm2.DBEdit15KeyPress(Sender: TObject; var Key: Char);
begin
if (key = chr(46)) then  //如果是小数点
if pos('.',(sender as TDBEdit).Text)>0 then  //小数点不能重复
  abort;
end;

procedure TForm2.DBEdit21KeyPress(Sender: TObject; var Key: Char);
begin
if (key = chr(46)) then  //如果是小数点
  abort;
end;

procedure TForm2.DBEdit21KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if (trim((sender as TDBEdit).Text)='') or
   (trim((sender as TDBEdit).Text)='0') then
   (sender as TDBEdit).Text:='1';
end;

procedure TForm2.DBEdit17Exit(Sender: TObject);
begin
if dm.AQY0025.State=dsedit then
 dm.AQY0025unit_sq.Value:=dm.AQY0025set_lngth.Value*
                         dm.AQY0025set_width.Value*0.000001
                          /dm.AQY0025set_qty.Value;
end;

procedure TForm2.DBEdit19Exit(Sender: TObject);
begin
if dm.AQY0025.State=dsedit then
 dm.AQY0025spell_sq.Value:=dm.AQY0025spell_lngth.Value*
                         dm.AQY0025spell_width.Value*0.000001
                          /dm.AQY0025spell_qty.Value;
end;

procedure TForm2.BitBtn4Click(Sender: TObject);
begin
try
form_route:=tform_route.Create(application);
form_route.Edit1.Text:=edit2.Text;
form_route.Label2.Caption:=label56.Caption;
form_route.route_ptr.Caption:=inttostr(dm.AQY0025ENG_ROUTE_PTR.value);
if form_route.ShowModal=mrok then
 begin
  edit2.Text:=form_route.Edit1.Text;
  label56.Caption:=form_route.Label2.Caption;
  dm.AQY0025ENG_ROUTE_PTR.Value:=strtoint(form_route.route_ptr.Caption);
 end;
finally
 form_route.Free;
end;
end;

procedure TForm2.DBGrid1ColExit(Sender: TObject);
begin
If DBGrid1.SelectedField.FieldName = DBComboBox1.DataField then
 DBComboBox1.Visible := false;
end;

procedure TForm2.DBComboBox1KeyPress(Sender: TObject; var Key: Char);
begin
 if dm.ads279datatype.Value='数字' then
 if not (key in ['0'..'9','.',#8,#13]) then  //判断是否输入数字
  abort;
end;

procedure TForm2.SpeedButton1Click(Sender: TObject);
begin
 dm.ads89.DisableControls;
 dm.ads279.DisableControls;
 dm.ADS279.First;
 while not dm.ads279.Eof do
 begin
  if dm.ads89.Locate('PARAMETER_NAME',dm.ads279PARAMETER_NAME.Value,[]) then
  begin
   dm.ADS279.Edit;
   dm.ads279PARAMETER_VALUE.Value:=dm.ads89tvalue.Value;
  end;
  dm.ads279.Next;
 end;
 dm.ads89.First;
 dm.ads279.First;
 dm.ads279.EnableControls;
 dm.ads89.EnableControls;

if find_spec_rkey('L') then //交货板面积
 begin
  dm.ads279.Edit;
  dm.ads279PARAMETER_VALUE.Value:=dm.AQY0025unit_sq.AsString;
  dm.ads279.Post;
  dm.ads279.First;
 end;

if find_spec_rkey('LY') then //层数
 begin
  dm.ads279.Edit;
  dm.ads279PARAMETER_VALUE.Value:=dm.AQY0025LAYERS.AsString;
  dm.ads279.Post;
  dm.ads279.First;
 end;

if find_spec_rkey('DZ') then //单元尺寸
 begin
  dm.ads279.Edit;
  dm.ads279PARAMETER_VALUE.Value:=dm.AQY0025pcs_lngth.AsString
                                       +'mm X '+dm.AQY0025pcs_width.AsString+'mm';
  dm.ads279.Post;
  dm.ads279.First;
 end;



end;

procedure TForm2.N3Click(Sender: TObject);  //编辑工序
begin
try
 form_flowpara:=tform_flowpara.Create(application);
 dm.ads494.Filter:='step_number='+dm.ADS38STEP_NUMBER.AsString;
 if form_flowpara.ShowModal=mrok then
 begin

 end;
finally
 form_flowpara.Free;
end;
end;

procedure TForm2.N2Click(Sender: TObject);   //插入工序
var
 step_number:word;
begin
try
 form_deptcode:=tform_deptcode.Create(application);
 if form_deptcode.ShowModal=mrok then
  begin
   if dm.ADS38.IsEmpty then
    step_number:=1
   else
    begin
     step_number:=dm.ADS38.RecNo;
     dm.ADS38.DisableControls;
     while not dm.ADS38.Eof do
     begin
      dm.ADS38.Edit;
      dm.ADS38STEP_NUMBER.Value:=dm.ADS38STEP_NUMBER.Value+1;
      dm.ADS38.Post;
      dm.ADS38.Next;
     end;
     dm.ADS38.MoveBy(step_number-dm.ADS38.RecNo);
     dm.ADS38.EnableControls;

     dm.ads494.IndexFieldNames:='';
     dm.ads494.Filter:='step_number >= '+inttostr(step_number);
     while not dm.ads494.Eof do
     begin
      dm.ads494.Edit;
      dm.ads494step_number.Value := dm.ads494step_number.Value+1;
      dm.ads494.Post;
      dm.ads494.Next;
     end;
     dm.ads494.IndexFieldNames := 'step_number;seq_no';
     dm.ads494.Filter:='';
    end;

   dm.ADS38.InsertRecord([dm.AQY0025RKEY.Value,
                          form_deptcode.ADOQuery1rkey.Value,
                          form_deptcode.ADOQuery1DEF_ROUT_INST.Value,
                          step_number,
                          '',
                          1]);
      dm.ADOQuery1.Close;   //=====不能改变adoquery1的语句
      dm.ADOQuery1.SQL.Text:=
'SELECT TOP 100 PERCENT PARAMETER_PTR, TValue, Doc_Flag, after_flag, formula,'+#13+
      'flow_spfc_flag, SEQ_NO'+#13+
      'FROM dbo.Data0506'+#13+
      'WHERE TTYPE = 3 AND '+#13+
      'SOURCE_PTR = '+dm.ADS38DEPT_PTR.AsString+#13+
      'ORDER BY SEQ_NO';
      dm.ADOQuery1.Open;
      while not dm.ADOQuery1.Eof do
      begin
       dm.ads494.AppendRecord([dm.ADOQuery1.FieldValues['PARAMETER_PTR'],
                               dm.ADOQuery1.FieldValues['TValue'],
                               dm.ADS38SOURCE_PTR.Value,
                               dm.ADS38STEP_NUMBER.Value,
                               dm.ADOQuery1.FieldValues['SEQ_NO'],
                               dm.ADOQuery1.FieldValues['Doc_Flag'],
                               dm.ADOQuery1.FieldValues['after_flag'],
                               dm.ADOQuery1.FieldValues['flow_spfc_flag']]);
       dm.ADOQuery1.Next;
      end;          //=======不能改变adoquery1的语句
  end;
finally
 form_deptcode.Free;
end;
end;

procedure TForm2.BitBtn11Click(Sender: TObject);
begin

dm.ADOConnection1.BeginTrans;
try
 dm.AQY0025ANALYSIS_CODE_5.Value:=dm.AQY0025pcs_lngth.AsString+'mm X '+
                                  dm.AQY0025pcs_width.AsString+'mm';
 dm.AQY0025ANALYSIS_CODE_1.Value:=dm.AQY0025set_lngth.AsString+'mm X '+
                                  dm.AQY0025set_width.AsString+'mm';
 dm.AQY0025ANALYSIS_CODE_4.Value:=dm.AQY0025spell_lngth.AsString+'mm X '+
                                  dm.AQY0025spell_width.AsString+'mm';
 dm.AQY0025.Post;
 dm.ads502.UpdateBatch();
 dm.ads279.UpdateBatch();
 dm.ADS279_0.UpdateBatch();

 dm.ADS38.UpdateBatch();
 self.update_tecparameter(dm.AQY0025RKEY.Value);

 self.update_drill(dm.AQY0025RKEY.Value);  //更新钻孔表
 dm.ADOConnection1.CommitTrans;

 dm.ADS38.Close;
 dm.ADS38.Open;
 dm.ads494.Close;
 dm.ads494.Open;
 
 dm.AQY0025.Close;
 dm.AQY0025.Open;
 dm.AQY0025.Edit;

 bitbtn11.Enabled:= not  bitbtn11.Enabled; 
except
 on E: Exception do
  begin
   dm.ADOConnection1.RollbackTrans;
   messagedlg(E.Message,mterror,[mbcancel],0);
  end;
end;
end;

procedure TForm2.N1Click(Sender: TObject);
begin
try
 form_deptcode:=tform_deptcode.Create(application);
 if form_deptcode.ShowModal=mrok then
  begin
   dm.ADS38.AppendRecord([dm.AQY0025RKEY.Value,
                          form_deptcode.ADOQuery1rkey.Value,
                          form_deptcode.ADOQuery1DEF_ROUT_INST.Value,
                          dm.ADS38.RecordCount+1,
                          '',
                          1]);
      dm.ADOQuery1.Close;   //=====不能改变adoquery1的语句
      dm.ADOQuery1.SQL.Text:=
'SELECT TOP 100 PERCENT PARAMETER_PTR, TValue, Doc_Flag, after_flag, formula,'+#13+
      'flow_spfc_flag, SEQ_NO'+#13+
      'FROM dbo.Data0506'+#13+
      'WHERE TTYPE = 3 AND '+#13+
      'SOURCE_PTR = '+dm.ADS38DEPT_PTR.AsString+#13+
      'ORDER BY SEQ_NO';
      dm.ADOQuery1.Open;
      while not dm.ADOQuery1.Eof do
      begin
       dm.ads494.AppendRecord([dm.ADOQuery1.FieldValues['PARAMETER_PTR'],
                               dm.ADOQuery1.FieldValues['TValue'],
                               dm.ADS38SOURCE_PTR.Value,
                               dm.ADS38STEP_NUMBER.Value,
                               dm.ADOQuery1.FieldValues['SEQ_NO'],
                               dm.ADOQuery1.FieldValues['Doc_Flag'],
                               dm.ADOQuery1.FieldValues['after_flag'],
                               dm.ADOQuery1.FieldValues['flow_spfc_flag']]);
       dm.ADOQuery1.Next;
      end;                  //=======不能改变adoquery1的语句
  end;
finally
 form_deptcode.Free;
end;

end;

procedure TForm2.N4Click(Sender: TObject);//删除工序
var
 step_number:word;
begin
if dm.ADS38.RecNo = dm.ADS38.RecordCount then
begin
 dm.ads494.Filter:='step_number='+dm.ADS38STEP_NUMBER.AsString;
 dm.ads494.First;
 while not dm.ads494.Eof do dm.ads494.Delete;
 dm.ads494.Filter:='';
 dm.ADS38.Delete;
end
else
 begin
  dm.ads494.Filter:='step_number='+dm.ADS38STEP_NUMBER.AsString;
  dm.ads494.First;
  while not dm.ads494.Eof do dm.ads494.Delete;
  dm.ads494.Filter:='';
  dm.ADS38.Delete;

  step_number := dm.ADS38.RecNo;
  dm.ADS38.DisableControls;
  while not dm.ADS38.Eof do
   begin
    dm.ADS38.Edit;
    dm.ADS38STEP_NUMBER.Value := dm.ADS38STEP_NUMBER.Value-1;
    dm.ADS38.Post;
    dm.ADS38.Next;
   end;
   dm.ADS38.MoveBy(step_number-dm.ADS38.RecNo);
   dm.ADS38.EnableControls;

  dm.ads494.IndexFieldNames:='';
  dm.ads494.Filter:='step_number >= '+inttostr(step_number);
  while not dm.ads494.Eof do
   begin
    dm.ads494.Edit;
    dm.ads494step_number.Value := dm.ads494step_number.Value-1;
    dm.ads494.Post;
    dm.ads494.Next;
   end;
  dm.ads494.IndexFieldNames:='step_number;seq_no';
  dm.ads494.Filter:='';

 end;
end;

procedure TForm2.PopupMenu1Popup(Sender: TObject);
begin
if dm.ADS38.IsEmpty then
 begin
  n3.Enabled:=false;
  n4.Enabled:=false;
 end
else
 begin
  n3.Enabled:=true;
  n4.Enabled:=true;
 end;
end;

procedure TForm2.SpeedButton3Click(Sender: TObject);
begin
try
 application.CreateForm(tForm_layer,Form_layer);
 Form_layer.ads93.Close;
 Form_layer.ads93.CommandText:=
   'select  RECORD_KEY,CODE, DESCRIPTION'+#13+
   'from data0193'+#13+
   'where SPEC_RKEY is null';
 Form_layer.ads93.Open;
 if Form_layer.ads93.IsEmpty then
  messagedlg('没有建立标准层压结构!',mtinformation,[mbcancel],0)
 else
 if Form_layer.ShowModal=mrok then
 begin
  if checkbox1.Checked then
   dm.AQY0025layers_info.Value:='';
  with  Form_layer do
  begin
   ads94.First;
   while not ads94.Eof do
   begin
    dbmemo1.Lines.Add(ads94TEXT_LINE.Value);
    ads94.Next;
   end;
  end;
 end;
finally
 Form_layer.Free;
end;
end;

procedure TForm2.N5Click(Sender: TObject);
begin
try
 application.CreateForm(tForm_layer,Form_layer);
 Form_layer.ads93.Close;
 Form_layer.ads93.CommandText:=
   'select  RECORD_KEY,CODE, DESCRIPTION'+#13+
   'from data0193'+#13+
   'where SPEC_RKEY =''Y''';
 Form_layer.ads93.Open;
 if Form_layer.ads93.IsEmpty then
  messagedlg('没有建立基本叠片结构!',mtinformation,[mbcancel],0)
 else
 if Form_layer.ShowModal=mrok then
 begin
  with  Form_layer do
  begin
   ads94.First;
   while not ads94.Eof do
   begin
    dbmemo1.Lines.Insert(dbmemo1.CaretPos.y,ads94TEXT_LINE.Value);
    ads94.Next;
   end;
  end;
 end;
finally
 Form_layer.Free;
end;
end;

procedure TForm2.BitBtn9Click(Sender: TObject);
begin
frmpickengnote:=tfrmpickengnote.Create(application);
if frmpickengnote.ShowModal=mrok then
begin
 dm.AQY0025REMARK.Value:=dm.AQY0025REMARK.Value+
  frmpickengnote.ADOQuery1.fieldbyname('PROD_ROUT_INST').AsString;
end;
frmpickengnote.Free;
end;

procedure TForm2.BitBtn10Click(Sender: TObject);
begin
frmpickengnote:=tfrmpickengnote.Create(application);
if frmpickengnote.ShowModal=mrok then
begin
 dm.AQY0025ENG_NOTE.Value:=dm.AQY0025ENG_NOTE.Value+
  frmpickengnote.ADOQuery1.fieldbyname('PROD_ROUT_INST').AsString;
end;
frmpickengnote.Free;
end;

procedure TForm2.StringGrid1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  column,row:integer;
begin
if button=mbright then
 begin
  (sender as tstringgrid).MouseToCell(x,y,column,row);
   if row<>0 then
  (sender as tstringgrid).Row:=row;
  (sender as tstringgrid).Col:=column;
 end;
end;

procedure TForm2.N7Click(Sender: TObject);
var
 i:word;
begin
 for i:=stringgrid1.Row to stringgrid1.RowCount-2 do
  stringgrid1.Rows[i].Text:=stringgrid1.Rows[i+1].Text;
  stringgrid1.RowCount:=stringgrid1.RowCount-1;
end;

procedure TForm2.PopupMenu3Popup(Sender: TObject);
begin
 if stringgrid1.Row=stringgrid1.RowCount-1 then
  begin
   n6.Enabled:=false;
   n7.Enabled:=false;
  end
 else
  begin
   n6.Enabled:=true;
   n7.Enabled:=true;
  end;
end;

procedure TForm2.N6Click(Sender: TObject);
var
 i:word;
begin
 for i:=stringgrid1.RowCount-2 downto stringgrid1.Row do
  stringgrid1.Rows[i+1].Text:=stringgrid1.Rows[i].Text;
  stringgrid1.Rows[stringgrid1.Row].Text:='';
  stringgrid1.RowCount:=stringgrid1.RowCount+1;
end;

procedure TForm2.StringGrid1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if (stringgrid1.Row=stringgrid1.RowCount-1) and
   (trim(stringgrid1.Rows[stringgrid1.Row].Text)<>'') then
 begin
  stringgrid1.Cells[0,stringgrid1.Row]:='T'+inttostr(stringgrid1.Row);
  stringgrid1.RowCount:=stringgrid1.RowCount+1;
 end;

end;

procedure TForm2.StringGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  IF (KEY=13) and (Stringgrid1.row<stringgrid1.RowCount-1) then
   Stringgrid1.row:=Stringgrid1.row+1;
end;

procedure TForm2.StringGrid1SelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
  var
    LSg: TStringGrid;
begin
  LSg := sender as TStringGrid;

if (lsg.Col=6)  then
 try //最少保留两位小数

 if length(lsg.Cells[lsg.Col,lsg.Row])-
    pos('.',lsg.Cells[lsg.Col,lsg.Row])<=2 then

  lsg.Cells[lsg.Col,lsg.Row]:=
   formatfloat('0.00',
   strtofloat(lsg.Cells[lsg.Col,lsg.Row]));

 except
 end;

if lsg.Col=4 then
 lsg.Cells[lsg.Col,lsg.Row]:=
  uppercase(lsg.Cells[lsg.Col,lsg.Row]);

if (lsg.Col=6) then
 edit6.Text:=formatfloat('0.00',(get_mindrill(sender as TStringgrid)));
end;

procedure TForm2.BitBtn5Click(Sender: TObject);
var
 i:word;
begin
 for i:= 1 to stringgrid1.RowCount-2 do
 try
   if trim(stringgrid1.Cells[3,i])='Y' then
    stringgrid1.Cells[5,i]:=formatfloat('0.00',
                            strtofloat(stringgrid1.Cells[2,i])+
                            strtofloat(edit7.Text))

  else
   if trim(stringgrid1.Cells[3,i])='N' then
    stringgrid1.Cells[5,i]:=formatfloat('0.00',
                            strtofloat(stringgrid1.Cells[2,i])+
                            strtofloat(edit8.Text));

 except

 end;
 edit6.Text:=formatfloat('0.00',(get_mindrill(StringGrid1)));
end;

procedure TForm2.BitBtn6Click(Sender: TObject);
var
 i:word;
begin
 for i:= 1 to stringgrid1.RowCount-2 do
 try
  if (trim(stringgrid1.Cells[3,i])='Y') and
     (roundto(strtofloat(stringgrid1.Cells[5,i]),-2)<>
      roundto(strtofloat(stringgrid1.Cells[2,i])+strtofloat(edit7.Text),-2)) then

    messagedlg('第'+inttostr(i)+'行钻咀:'+stringgrid1.Cells[2,i]+'不符沉铜孔偏差'
    ,mtinformation,[mbcancel],0)
  else
   if (trim(stringgrid1.Cells[3,i])='N') and
     (roundto(strtofloat(stringgrid1.Cells[5,i]),-2)<>
      roundto(strtofloat(stringgrid1.Cells[2,i])+strtofloat(edit8.Text),-2)) then
    messagedlg('第'+inttostr(i)+'行钻咀:'+stringgrid1.Cells[2,i]+'不符非沉铜孔偏差'
    ,mtinformation,[mbcancel],0);
 except

 end;
end;

procedure TForm2.BitBtn7Click(Sender: TObject);
var
pnla_pcs,pnlb_pcs,i:integer;
begin
 pnla_pcs:=0;
 pnlb_pcs:=0;
if find_spec_rkey('3') then //PNLA单元数
 if trim(dm.ads279PARAMETER_VALUE.Value)<>'' then
  pnla_pcs:=strtoint(dm.ads279PARAMETER_VALUE.Value);

if find_spec_rkey('4') then //PNLA单元数
 if trim(dm.ads279PARAMETER_VALUE.Value)<>'' then
  pnlb_pcs:=strtoint(dm.ads279PARAMETER_VALUE.Value);

for i:=1 to stringgrid1.RowCount-2 do
begin
 try
  if pnla_pcs>0 then
   Stringgrid1.Cells[7,i]:=
   inttostr(strtoint(trim(Stringgrid1.Cells[6,i]))*pnla_pcs+1);
  if pnlb_pcs>0 then
   Stringgrid1.Cells[8,i]:=
   inttostr(strtoint(trim(Stringgrid1.Cells[6,i]))*pnlb_pcs+1);
 except

 end;
end;
end;

procedure TForm2.BitBtn8Click(Sender: TObject);
var
 i,total_a,total_b:integer;
begin
 total_a:=0;
 total_b:=0;
 if pos('Total',stringgrid1.Cells[6,stringgrid1.RowCount-2])>0 then
 if messagedlg('孔数已经汇总是否继续?',mtconfirmation,[mbyes,mbno],0)=mrno then
  exit;

 try
 for i:=1 to stringgrid1.RowCount-2 do
  begin
   if trim(Stringgrid1.Cells[7,i])<>'' then
   total_a := total_a+strtoint(Stringgrid1.Cells[7,i]);
   if trim(Stringgrid1.Cells[8,i])<>'' then
   total_b := total_a+strtoint(Stringgrid1.Cells[8,i]);
  end;
 except
  messagedlg('PNL孔数输入有误,汇总停止!',mterror,[mbcancel],0);
  exit;
 end;

stringgrid1.Cells[6,stringgrid1.RowCount-1]:='Total:';
if total_a>0 then
stringgrid1.Cells[7,stringgrid1.RowCount-1]:=inttostr(total_a);
if total_b>0 then
stringgrid1.Cells[8,stringgrid1.RowCount-1]:=inttostr(total_b);
stringgrid1.RowCount:=stringgrid1.RowCount+1;
end;

procedure TForm2.DBEdit15Exit(Sender: TObject);
begin
if dm.AQY0025.State=dsedit then
 dm.AQY0025pcs_sq.Value:=dm.AQY0025pcs_lngth.Value*
                         dm.AQY0025pcs_width.Value*0.000001;
end;

procedure TForm2.TreeView1Change(Sender: TObject; Node: TTreeNode);
begin
 rkey25.Caption:=inttostr(Pinteger(Node.data)^);
 notebook1.PageIndex:=0;
 node.SelectedIndex:=4;
 bitbtn14.Enabled:=false;
 if node.Level =0 then
 listbox1.Items.Text:=
 '产品信息'+#13+
 '拼版设计'+#13+
 '全局参数'+#13+
 '工艺流程'+#13+
 '层压结构'+#13+
 '钻咀表'+#13+
 '备注信息'+#13+
 '工程更改'+#13+
 '评审信息'+#13+
 '客户信息'+#13+
 'ECN履历表'+#13+
 '阻抗表'+#13+
  '工程档案'+#13+
  '评审记录'+#13+
  'BOM'
 else
 listbox1.Items.Text:=
 '产品信息'+#13+
 '拼版设计'+#13+
 '全局参数'+#13+
 '工艺流程'+#13+
 '层压结构'+#13+
 '钻咀表'+#13+
 '备注信息';
end;

procedure TForm2.PopupMenu4Popup(Sender: TObject);
var node:TTreeNode;
begin
 node:=treeview1.Selected;
 if node.Level=2 then
  begin
   n8.Enabled:=false;
   n9.Enabled:=true;
  end
 else
  begin
   n8.Enabled:=true;
   if node.Level=0 then
    n9.Enabled:=false
   else
    n9.Enabled:=true;
  end;
end;

procedure TForm2.N8Click(Sender: TObject);
var
 node:ttreenode;   //treeview控件的节点变量
 rkey0025:^integer;
begin
if bitbtn11.Enabled then
 if messagedlg('新建线路层,是否自动保存数据?',mtconfirmation,[mbyes,mbno],0)=mryes then
  bitbtn11click(sender);

try
form_append:=tform_append.Create(application);
 dm.AQY0025.Close;
 dm.AQY0025.Parameters[0].Value:=rkey25.Caption;
 dm.AQY0025.Open;

if form_append.ShowModal=mrok then
 begin
  node:=treeview1.Selected;
  new(rkey0025);
  rkey0025^:=dm.AQY0025RKEY.Value;
  node:=treeview1.Items.AddChildObject
  (node,dm.AQY0025MANU_PART_NUMBER.Value,rkey0025); //增加顶层节点
  node.ImageIndex:=node.Level;  //为第一层节点定义图画
  node.SelectedIndex := node.Level;//为第一层节点定义选择之后的图画
  treeview1.Selected:=node;

  self.update_notebook;
  if bitbtn11.Enabled then bitbtn11.Enabled:=false;
  if bitbtn1.Enabled then bitbtn1.Enabled:=false;
  if bitbtn14.Enabled then bitbtn14.Enabled:=false;
  if bitbtn15.Enabled then bitbtn15.Enabled:=false;
    
 end;
finally
form_append.Free;
end;

end;

procedure TForm2.N9Click(Sender: TObject);
var
 node:ttreenode;   //treeview控件的节点变量
begin
if dm.AQY0025RKEY.Value <> strtoint(rkey25.Caption) then
 begin
  if bitbtn11.Enabled then
  if messagedlg('删除线路层,是否自动保存数据?',mtconfirmation,[mbyes,mbno],0)=mryes then
   bitbtn11click(sender);
 end;

if messagedlg('删除将是不可逆操作!您确定要删除内层吗?',mtconfirmation,[mbyes,mbno],0)=mryes then
begin
 node:=treeview1.Selected;
 if not node.HasChildren then
 begin
  dm.ADOConnection1.BeginTrans;
  try
  dm.AQY0025.Close;
  dm.AQY0025.Parameters[0].Value:=rkey25.Caption;
  dm.AQY0025.Open;
  dm.AQY0025.Delete;

   dm.ads502.Close;
   dm.ads279.Close;
   dm.ADS38.Close;
   dm.ads494.Close;
   dm.ADS279_0.Close;
   dm.ads89.Close;
 
  node.Delete;
  dm.ADOConnection1.CommitTrans;
  if bitbtn11.Enabled then bitbtn11.Enabled:=false;
  if bitbtn14.Enabled then bitbtn14.Enabled:=false;
  if bitbtn1.Enabled then bitbtn1.Enabled:=false;
  if bitbtn15.Enabled then bitbtn15.Enabled:=false;

 except
  on E: Exception do
  begin
   dm.ADOConnection1.RollbackTrans;
   messagedlg(E.Message,mterror,[mbcancel],0);
  end;
 end;
 end
 else
  messagedlg('无法删除本身带有内层的产品!',mterror,[mbcancel],0);
end;
end;

procedure TForm2.BitBtn13Click(Sender: TObject);
begin
  Form_prodcode:=tForm_prodcode.Create(application);
  if Form_prodcode.ShowModal=mrok then
  begin
   edit1.Text:=Form_prodcode.ADOQuery1prod_code.Value;
   label15.Caption:=Form_prodcode.adoquery1PRODUCT_NAME.Value;
   dm.AQY0025PROD_CODE_PTR.Value:=Form_prodcode.adoquery1RKEY.value;
   if dm.AQY0025ttype.Value=0 then
    dm.AQY0025EST_SCRAP.Value:=Form_prodcode.adoquery1EST_SCRAP.Value
   else
    dm.AQY0025EST_SCRAP.Value:=Form_prodcode.adoquery1EST_SCRAP1.Value;
   dm.AQY0025SHELF_LIFE.Value:=Form_prodcode.adoquery1LEAD_TIME.Value;
   dm.AQY0025MFG_LEAD_TIME.Value:=Form_prodcode.adoquery1MAX_DAYS_EARLY_BUILD.Value;
   dm.AQY0025OPT_LOT_SIZE.Value:=Form_prodcode.adoquery1OPT_LOT_SIZE.value;

   if Form_prodcode.adoquery1IESMODEL_PTR.Value>0 then
   IF DM.AQY0025ENG_ROUTE_PTR.Value<=0 THEN
   with dm.ADOQuery1 do
    begin
     close;
     sql.Text:='select ENG_FLOW_NAME,ENG_FLOW_DESC from data0504'+#13+
               'where rkey='+Form_prodcode.adoquery1IESMODEL_PTR.AsString;
     open;
     edit2.Text:=fieldbyname('ENG_FLOW_NAME').AsString;
     label56.Caption:=fieldbyname('ENG_FLOW_DESC').AsString;
     DM.AQY0025ENG_ROUTE_PTR.Value:=Form_prodcode.adoquery1IESMODEL_PTR.Value;
    end;

  end;
  Form_prodcode.Free;
end;

procedure TForm2.N10Click(Sender: TObject);
begin
try
 form_flowpara:=tform_flowpara.Create(application);
 dm.ads494.Filter:='step_number='+dm.ADS38STEP_NUMBER.AsString;
 with form_flowpara do
  begin
   bitbtn2.Enabled:=false;
   dbmemo1.Enabled:=false;
   dbedit4.Enabled:=false;
   dbedit5.Enabled:=false;
   dbgrid1.PopupMenu:=nil;
   dbcombobox1.Enabled:=false;
   dbgrid1.Columns[5].ReadOnly:=true;
   dbgrid1.Columns[6].ReadOnly:=true;
   dbgrid1.Columns[7].ReadOnly:=true;
   dbgrid1.Columns[8].ReadOnly:=true;
   dbgrid1.Columns[9].ReadOnly:=true;
  end;

 if form_flowpara.ShowModal=mrok then
 begin

 end;
finally
 form_flowpara.Free;
end;
end;

procedure TForm2.BitBtn12Click(Sender: TObject);
begin
form_stepnumber:=tform_stepnumber.Create(application);
if form_stepnumber.ADODataSet1.IsEmpty then
 messagedlg('请首先输入上层产品工序流程',mtinformation,[mbcancel],0)
else
if form_stepnumber.ShowModal=mrok then
begin
 dm.AQY0025BOM_STEP.Value:=form_stepnumber.ADODataSet1STEP_NUMBER.Value;
 label64.Caption:=form_stepnumber.ADODataSet1DEPT_NAME.Value;
end;
form_stepnumber.free;
end;

procedure TForm2.BitBtn14Click(Sender: TObject);
begin
if trim(dm.AQY0025MANU_PART_NUMBER.Value)='' then
 begin
  listbox1.ItemIndex:=0;
  notebook1.PageIndex:=listbox1.ItemIndex+1;
  messagedlg('本厂编号不允许为空!',mterror,[mbcancel],0);
  DBEDIT1.SetFocus;
  exit;
 end;
 
if trim(dm.AQY0025MANU_PART_DESC.Value)='' then
 begin
  listbox1.ItemIndex:=0;
  notebook1.PageIndex:=listbox1.ItemIndex+1;
  messagedlg('客户型号不允许为空!',mterror,[mbcancel],0);
  DBEDIT2.SetFocus;
  exit;
 end;

if dm.AQY0025PARENT_PTR.Value > 0 then
begin
 if dm.AQY0025QTY_BOM.Value <= 0 then
 begin
  listbox1.ItemIndex:=0;
  notebook1.PageIndex:=listbox1.ItemIndex+1;
  messagedlg('压合比例输入有误!',mterror,[mbcancel],0);
  DBEDIT33.SetFocus;
  exit;
 end;

if dm.AQY0025BOM_STEP.Value<=0 then
 begin
  listbox1.ItemIndex:=0;
  notebook1.PageIndex:=listbox1.ItemIndex+1;
  messagedlg('压合步骤输入有误!',mterror,[mbcancel],0);
  DBEDIT32.SetFocus;
  exit;
 end
else
 begin
   with dm.ADOQuery1 do
    begin
     close;
     sql.Text:='SELECT Data0038.STEP_NUMBER, dbo.Data0034.DEPT_CODE,'+#13+
        'Data0034.DEPT_NAME, Data0034.BARCODE_ENTRY_FLAG'+#13+
         'FROM Data0038 INNER JOIN'+#13+
        'dbo.Data0034 ON dbo.Data0038.DEPT_PTR = dbo.Data0034.RKEY'+#13+
        'where data0038.SOURCE_PTR='+dm.AQY0025PARENT_PTR.AsString+#13+
        'and Data0038.STEP_NUMBER='+dm.AQY0025BOM_STEP.AsString;
     open;
    end;
  if dm.ADOQuery1.IsEmpty then
  begin
  listbox1.ItemIndex:=0;
  notebook1.PageIndex:=listbox1.ItemIndex+1;
  messagedlg('压合步骤输入有误,步骤号在上父层产品中没有找到对应的工序!',mterror,[mbcancel],0);
  DBEDIT32.SetFocus;
  exit;
  end
 end;
end;

dm.ads279.DisableControls;
dm.ads279.First;
while not dm.ads279.Eof do
begin
 if (dm.ads279status3.Value=1) and
    (trim(dm.ads279PARAMETER_VALUE.Value)='') then
 begin
  listbox1.ItemIndex := 2;
  notebook1.PageIndex := listbox1.ItemIndex+1;
  messagedlg('全局参数为不允许为空的重要参数!',mterror,[mbcancel],0);
  dbgrid1.SetFocus;
  dm.ads279.EnableControls;
  exit;
 end;
 dm.ads279.Next;
end;
dm.ads279.First;
dm.ads279.EnableControls;

dm.ads494.Filter:='';
dm.ads494.First;
while not dm.ads494.Eof do
begin
 if (dm.ads494flow_spfc_flag.Value='Y') and
    (trim(dm.ads494PARAMETER_VALUE.Value)='') then
 begin
  listbox1.ItemIndex := 3;
  notebook1.PageIndex := listbox1.ItemIndex+1;
  messagedlg('第'+DM.ads494step_number.AsString+'步制程参数为不允许为空的重要参数!',
           mterror,[mbcancel],0);
  dm.ADS38.Locate('step_number',dm.ads494step_number.Value,[]);
  dbgrid2.SetFocus;
  exit;
 end;
 dm.ads494.Next;
end;
dm.ads494.First;


messagedlg('数据检查通过!',mtinformation,[mbok],0);
end;

procedure TForm2.SpeedButton2Click(Sender: TObject);
begin
form_layersdata:=tform_layersdata.Create(application);
self.get_treedate(dm.AQY0025RKEY.Value,form_layersdata.TreeView1);
if form_layersdata.ShowModal=mrok then
 begin
  with dm.ADOQuery1 do
  begin
   close;
   sql.Text:=
   'select source_PTR, PARAMETER_PTR, PARAMETER_VALUE,IES_PROD,IES_CRP'+#13+
   'from data0279'+#13+
   'where  IES_PROD=1 and'+#13+
          'source_ptr= '+form_layersdata.rkey25.Caption+#13+
   'order by IES_CRP';
   open;
  end;
 dm.ads279.DisableControls;
 dm.ADS279.First;
 while not dm.ads279.Eof do
 begin
  if dm.ADOQuery1.Locate('PARAMETER_PTR',dm.ads279PARAMETER_PTR.Value,[]) then
  begin
   dm.ADS279.Edit;
   dm.ads279PARAMETER_VALUE.Value:=dm.ADOQuery1.Fieldbyname('PARAMETER_VALUE').AsString;
   dm.ads279.Post;
  end;
  dm.ads279.Next;
 end;
 dm.ads279.First;
 dm.ads279.EnableControls;
 
 end;
form_layersdata.Free;
end;

procedure TForm2.BitBtn15Click(Sender: TObject);
var ckstr:string;
begin
form_reportselect:=tform_reportselect.Create(application);
if form_reportselect.ShowModal=mrok then
 begin
  form_report:=tform_report.Create(application);
  with form_report do
  begin
    ppReport1.Reset;
    ppReport1.Template.FileName :=
      stringReplace(UpperCase(extractfilepath(paramstr(0))),'EXEC\','NIERP\REPORT\',[rfReplaceAll])+
        'Manu_instruction.rtm';   //R:\NIERP\Report\Manu_instruction.rtm
    ppReport1.Template.LoadFromFile;
    ppreport1.SaveAsTemplate:=false;

   ads192.Open;
   ads279.Close;
   ads279.Parameters.ParamValues['rkey']:=dm.AQY0025RKEY.Value;
   if ads192ENG_CONTROL16.Value=1 then       //不显示为空的全局参数
    ads279.Parameters.ParamValues['value']:=''
   else
    ads279.Parameters.ParamValues['value']:='#@#@#';
   ads279.Open;

   ads25.Close;
   ads25.Parameters[0].Value:=dm.AQY0025RKEY.Value;
   ads25.Open;

   ads494.Close;
   ads494.Parameters.ParamValues['source_ptr']:=dm.AQY0025RKEY.Value;
   if ads192ENG_CONTROL2.Value=1 then       //不显示为空的制程参数
    ads494.Parameters.ParamValues['value']:=''
   else
    ads494.Parameters.ParamValues['value']:='#@#@#';
   ads494.Open;

   ads38.Close;
   ads38.Parameters.ParamValues['rkey']:=dm.AQY0025RKEY.Value;
   if form_reportselect.CheckBox3.Checked then
    ads38.Parameters.ParamValues['visible']:=1
   else
    ads38.Parameters.ParamValues['visible']:=2;
   ads38.Open;
   ads502.Open;
  // ads29.Open;
         //------------添加钻咀表条件-------------------
      with Form_reportselect do
      begin
       if (CheckBox4.Checked=False) and (CheckBox7.Checked=False)and (CheckBox8.Checked=False) then
       begin
        form_report.ppSubReport3.Visible := false;
       end
       else
       begin
        ckstr:='';
        if CheckBox4.Checked then ckstr:='0,';
        if CheckBox7.Checked then ckstr:=ckstr+'1,';
        if CheckBox8.Checked then ckstr:=ckstr+'2,';
        ads29.CommandText:=ads29.CommandText+'and flow_no IN('+ copy(ckstr,0,Length(ckstr)-1)+') ORDER BY SEQ_NO';
       end;
      end;
      ads29.Open;
   form_report.ppImage3.Picture.Assign(Load_JPG_Pic_From_DB(ads502DSDesigner));
   if ads502A3.Value>0 then
    form_report.ppimage1.Picture.Assign(Load_JPG_Pic_From_DB(ads502A));
   if ads502B3.Value>0 then
    form_report.ppimage2.Picture.Assign(Load_JPG_Pic_From_DB(ads502B));

    if (not ADS25DSDesigner35.IsNull) and
       (form_reportselect.CheckBox6.Checked) then
     begin
      form_report.ppImage4.Visible:=True;
      form_report.ppImage4.Picture.Assign(Load_JPG_Pic_From_DB(ADS25DSDesigner35));
     end
    else
     form_report.ppImage4.Visible:=False;

   if not form_reportselect.CheckBox1.Checked then
    form_report.ppSubReport1.Visible:=false;
   if not form_reportselect.CheckBox2.Checked then
    form_report.ppSubReport2.Visible:=false;
//   if not form_reportselect.CheckBox4.Checked then
//    form_report.ppSubReport3.Visible:=false;
   if not Form_reportselect.CheckBox5.Checked then
    Form_report.ppSubReport4.Visible:=false;
  end;

  form_report.ppReport1.Print;

  form_report.Free;
 end;
form_reportselect.Free;
end;

procedure TForm2.SpeedButton6Click(Sender: TObject);
var
 modalok:boolean;
begin
 form_product:=tform_product.Create(application);
 form_product.adoquery1.Close;
 form_product.adoquery1.Open;
 if form_product.adoquery1.IsEmpty then
  BEGIN
   messagedlg('没有找到需要复制的产品',mtinformation,[mbcancel],0);
   EDIT1.SetFocus;
  END
 else
 if form_product.ShowModal=mrok then
 begin
if not dm.ADS38.IsEmpty then
 begin
  if messagedlg('产品已经有流程数据重复制流程将有可能导致原流程及制程信息丢失,请确认?',
    mtconfirmation,[mbyes,mbno],0)=mryes then
  begin
   dm.ADS38.First;
   while not dm.ADS38.Eof do dm.ADS38.Delete;
   dm.ads494.Filter:='';
   dm.ads494.First;
   while not dm.ads494.Eof do dm.ads494.Delete;
   modalok:=true;
  end
  else
   modalok:=false;
 end
 else
  modalok:=true;
if modalok then
 begin
  with dm.ADOQuery2 do
   begin
    close;
    sql.Text:='SELECT SOURCE_PTR, DEPT_PTR, DEF_ROUT_INST, STEP_NUMBER,'+#13+
      'tooling_rev, OUTP_SPFC,tool_old_rev '+#13+
      'FROM Data0038'+#13+
      'WHERE source_ptr = '+form_product.adoquery1rkey.AsString+#13+
      'ORDER BY STEP_NUMBER';
    open;

    while not Eof do //函数中千万不能使用adoquery2
     begin
      dm.ADS38.AppendRecord([dm.AQY0025RKEY.Value,
                            fieldvalues['dept_ptr'],
                            fieldvalues['DEF_ROUT_INST'],
                            fieldvalues['STEP_NUMBER'],
                            fieldvalues['tooling_rev'],
                            fieldvalues['OUTP_SPFC'],
                            fieldvalues['tool_old_rev']]);
      Next;
     end;    //=======不能改变adoquery2的语句
   end;


  dm.ADOQuery1.Close;   //=====不能改变adoquery1的语句
  dm.ADOQuery1.SQL.Text:=
  'SELECT PARAMETER_PTR, PARAMETER_VALUE, custpart_ptr, step_number,'+#13+
  ' seq_no, Doc_Flag, after_flag, flow_spfc_flag'+#13+
  'FROM Data0494'+#13+
  'where custpart_ptr = '+form_product.adoquery1rkey.AsString+#13+
  'ORDER BY step_number,seq_no';
  dm.ADOQuery1.Open;

  while not dm.ADOQuery1.Eof do
  begin
   dm.ads494.AppendRecord([dm.ADOQuery1.FieldValues['PARAMETER_PTR'],
                           dm.ADOQuery1.Fieldbyname('PARAMETER_VALUE').AsString,
                           dm.AQY0025RKEY.Value,
                           dm.ADOQuery1.FieldValues['step_number'],
                           dm.ADOQuery1.FieldValues['SEQ_NO'],
                           dm.ADOQuery1.FieldValues['Doc_Flag'],
                           dm.ADOQuery1.FieldValues['after_flag'],
                           dm.ADOQuery1.FieldValues['flow_spfc_flag']]);
   dm.ADOQuery1.Next;
  end;          //=======不能改变adoquery1的语句

  dm.ADS38.First;
  dm.ads494.First;
 end;

 end;
 form_product.Free;
end;

procedure TForm2.BitBtn16Click(Sender: TObject);
begin
if stringgrid2.RowCount>2 then
begin
 Export_Grid_to_Excel(STRINGGRID2,DBtext3.Caption,true);
end;
end;

procedure TForm2.rg1Click(Sender: TObject);
begin
imgCY.Stretch := rg1.ItemIndex = 1;
end;

procedure TForm2.update_IESparameter(rkey25:integer);
begin
with dm.ADOQuery1 do
 begin
  close;
  sql.Text:=
  'SELECT PARAMETER_PTR, PARAMETER_VALUE, source_ptr,'+#13+
  'route_step_ptr ,seq_no'+#13+
  'FROM Data0497'+#13+
  'where rkey is null';
  open;
 end;

with dm.ADOQuery2 do
 begin
  close;
  sql.Text:=
  'SELECT rkey,DEPT_PTR, STEP_NUMBER'+#13+
  'FROM Data0038'+#13+
  'where source_ptr='+inttostr(rkey25)+#13+
  'order by STEP_NUMBER';
  open;
 end;

while not dm.ADOQuery2.Eof do
 begin
  dm.ads497.Filter:='STEP_NUMBER='+dm.ADOQuery2.fieldbyname('STEP_NUMBER').AsString+
  ' and DEPT_PTR='+dm.ADOQuery2.fieldbyname('DEPT_PTR').AsString;
  dm.ads497.First;
  while not dm.ads497.Eof do
  begin
    dm.ADOQuery1.AppendRecord([dm.ads497PARAMETER_PTR.Value,  //参数指针278
                               dm.ads497PARAMETER_VALUE.Value, //参数值
                               dm.ads497SOURCE_PTR.Value,   //成本中心材料类
                               dm.ADOQuery2.FieldByName('rkey').AsInteger,//工序代码
                               dm.ads497SEQ_NO.Value       //序号
                               ]);
    dm.ads497.Next;
  end;

   dm.ADOQuery2.Next;
 end;

end;


procedure TForm2.update_deptcode(rkey25:integer);
begin
with dm.ADOQuery1 do
begin
 close;
 sql.Text:='delete from data0494 where custpart_ptr='+inttostr(rkey25);
 execsql;
end;
with dm.ADOQuery1 do
begin
 close;
 sql.Text:='delete from data0038 where source_ptr='+inttostr(rkey25);
 execsql;
end;

with dm.ADOQuery1 do
 begin
  close;
  sql.Text:=
  'SELECT SOURCE_PTR, DEPT_PTR, DEF_ROUT_INST, STEP_NUMBER, '+#13+
  'tooling_rev, OUTP_SPFC,tool_old_rev,TOOL_REMARK,grade_note'+#13+
  'FROM Data0038'+#13+
  'where source_ptr='+inttostr(rkey25);
  open;
 end;

dm.ADS38.First;
while not dm.ADS38.Eof do
begin
   dm.ADOQuery1.AppendRecord([dm.ADS38SOURCE_PTR.Value,
                              dm.ADS38DEPT_PTR.Value,
                              dm.ADS38DEF_ROUT_INST.Value,
                              dm.ADS38STEP_NUMBER.Value,
                              dm.ADS38tooling_rev.Value,
                              dm.ADS38OUTP_SPFC.Value,
                              dm.ADS38tool_old_rev.Value,
                              dm.ADS38TOOL_REMARK.Value,
                              dm.ADS38.FieldByName('grade_note').Value]);
 dm.ADS38.Next;
end;
end;


procedure TForm2.ComboBox1Change(Sender: TObject);
begin
  DM.qryFile.Filtered:= False;
  if ComboBox1.ItemIndex = 4 then
    DM.qryFile.Filter:=''
  else
    DM.qryFile.Filter:='filetype = ' + IntToStr(ComboBox1.ItemIndex + 1);
  DM.qryFile.Filtered:= True;
end;

procedure TForm2.N11Click(Sender: TObject);
var
 filename,f:string;
 fs: TMemoryStream;
begin
if copy(file_name.Strings[dm.ads564rec_no.value],
        pos(';',file_name.Strings[dm.ads564rec_no.value])+1,1)='1' then
  begin
    DM.AQtmp.Close;
    DM.AQtmp.SQL.Text:='select vcut_bmp FROM Data0564 where rkey='+dm.ads564rkey.AsString;
    DM.AQtmp.Open;
    if dm.AQtmp.fieldbyname('vcut_bmp').IsNull then
    begin
      showmessage('此文档为空...');
      exit;
    end;
    fs := TMemoryStream.Create;
    TBlobfield(dm.AQtmp.fieldbyname('vcut_bmp')).SaveToStream(fs);
    UnPackStream(fs);
    if not DirectoryExists(TmpFileDir) then
      if not sysutils.CreateDir(TmpFileDir) then
        raise Exception.Create('创建临时文件目录错误: '+TmpFileDir);
    f:=TmpFileDir+dm.ads564file_name.AsString;
    fs.SaveToFile(f);
    fs.Free;
    ShellExecute(self.Handle,nil,pchar(f),nil,nil,SW_SHOWNORMAL);
  end
  else
   begin
    filename:= copy(file_name.Strings[dm.ads564rec_no.value],1,
                     pos(';',file_name.Strings[dm.ads564rec_no.value])-1);
    ShellExecute(self.Handle,nil,pchar(filename),nil,nil,SW_SHOWNORMAL);
   end;
end;

procedure TForm2.N12Click(Sender: TObject);
var
  LTmp:TADOQuery;
  LFTp: TIdFTP;
  LFtpDir,LFileName,LFtpName:string;
  LSaveDlg: TSaveDialog;
begin
  LSaveDlg:= TSaveDialog.Create(nil);
  LTmp:= TADOQuery.Create(nil);
  LTmp.Connection:= dm.ADOConnection1;
  LFtp:= TIdFTP.Create(nil);
  try
    LFileName:= DM.qryFile.Fields[0].AsString;
    LFtpName:= DM.qryFile.Fields[6].AsString;

//    if not DirectoryExists('D:\ENGFileTmp\') then
//    begin
//      if not CreateDir('D:\ENGFileTmp\') then
//      begin
//        LSaveDlg.FileName:= LFileName;
//        if LSaveDlg.Execute then LFileName:= LSaveDlg.FileName
//        else Exit;
//      end
//      else  LFileName:= 'D:\ENGFileTmp\' + LFileName;
//    end
//    else LFileName:= 'D:\FileTmp\' + LFileName;

    LSaveDlg.FileName:= DM.qryFile.Fields[0].AsString;
    if LSaveDlg.Execute then
    begin
      LFileName:= LSaveDlg.FileName;
      with LTmp do
      begin
        Close;
        SQL.Text:= 'SELECT top 1 Rkey, FtpIP, FtpUserName, FtpPassWord, FtpDir + isnull(SubDir_1,'''') + isnull(SubDir_2,'''') as FDir ' + #13+
                   ' from tier3_ftplist where rkey = ' + DM.qryFtp.Fields[2].AsString;
        open;
        if not IsEmpty then
        begin
          LFtp.Host := Fields[1].AsString;
          LFtp.Username := Fields[2].AsString;
          LFtp.Password := Fields[3].AsString;
          LFtpDir := Trim(Fields[4].AsString);
        end
        else
        begin
          ShowMessage('没有找到FTP服务器，请联系管理员');
          exit;
        end;
      end;
      try
        if not LFtp.Connected then LFtp.Connect(True,10000);
        if LFTp.Connected then
        begin
  //                LFTp.TransferType:= ftBinary;
          LFTp.Get(LFtpDir+LFtpName,LFileName,True);
  //        ShellExecute(0,'open',pchar(LFileName),nil,nil,SW_SHOWNORMAL);
        end;
      except
        ShowMessage('FTP链接失败,下载失败');
        Exit;
      end;
    end;
  finally
    if LFTp.Connected then LFTp.Disconnect;
    LSaveDlg.Free;
    LTmp.Free;
    LFTp.Free;
  end;
end;

procedure TForm2.N13Click(Sender: TObject);
var
  LTmp:TADOQuery;
  LFTp: TIdFTP;
  LFtpDir,LFileName,LFtpName:string;
  LSaveDlg: TSaveDialog;
begin
  LSaveDlg:= TSaveDialog.Create(nil);
  LTmp:= TADOQuery.Create(nil);
  LTmp.Connection:= dm.ADOConnection1;
  LFtp:= TIdFTP.Create(nil);
  try
    LFileName:= DM.qryFile2.Fields[0].AsString;
    LFtpName:= DM.qryFile2.Fields[5].AsString;

//    if not DirectoryExists('D:\ENGFileTmp\') then
//    begin
//      if not CreateDir('D:\ENGFileTmp\') then
//      begin
//        LSaveDlg.FileName:= LFileName;
//        if LSaveDlg.Execute then LFileName:= LSaveDlg.FileName
//        else Exit;
//      end
//      else  LFileName:= 'D:\ENGFileTmp\' + LFileName;
//    end
//    else LFileName:= 'D:\FileTmp\' + LFileName;

    LSaveDlg.FileName:= DM.qryFile2.Fields[0].AsString;
    if LSaveDlg.Execute then
    begin
      LFileName:= LSaveDlg.FileName;
      with LTmp do
      begin
        Close;
        SQL.Text:= 'SELECT top 1 Rkey, FtpIP, FtpUserName, FtpPassWord, FtpDir + isnull(SubDir_1,'''') + isnull(SubDir_2,'''') as FDir ' + #13+
                   ' from tier3_ftplist where rkey = ' + DM.qryFtp2.Fields[2].AsString;
        open;
        if not IsEmpty then
        begin
          LFtp.Host := Fields[1].AsString;
          LFtp.Username := Fields[2].AsString;
          LFtp.Password := Fields[3].AsString;
          LFtpDir := Trim(Fields[4].AsString);
        end
        else
        begin
          ShowMessage('没有找到FTP服务器，请联系管理员');
          exit;
        end;
      end;
      try
        if not LFtp.Connected then LFtp.Connect(True,10000);
        if LFTp.Connected then
        begin
  //                LFTp.TransferType:= ftBinary;
          LFTp.Get(LFtpDir+LFtpName,LFileName,True);
  //        ShellExecute(0,'open',pchar(LFileName),nil,nil,SW_SHOWNORMAL);
          ShowMessage('下载完成！');
        end;
      except
        ShowMessage('FTP链接失败,下载失败');
        Exit;
      end;
    end;
  finally
    if LFTp.Connected then LFTp.Disconnect;
    LSaveDlg.Free;
    LTmp.Free;
    LFTp.Free;
  end;
end;

procedure TForm2.PopupMenu6Popup(Sender: TObject);
begin
if dm.ads564.IsEmpty then N11.Enabled:= False;
end;

procedure TForm2.PopupMenu7Popup(Sender: TObject);
begin
n12.Enabled:= (not DM.qryFile.IsEmpty);
end;

procedure TForm2.PopupMenu8Popup(Sender: TObject);
begin
n13.Enabled:= (not DM.qryFile.IsEmpty);
end;

end.
