unit product_MIDetail;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, ImgList, DBCtrls, Mask,
  Grids, DBGrids, Menus, DB, ADODB,math, ExtDlgs, DBGridEh,Clipbrd,Excel2000,
  OleServer,ComObj, jpeg, ActnList;
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
    Panel3: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    Panel4: TPanel;
    Edit2: TEdit;
    Label34: TLabel;
    BitBtn4: TBitBtn;
    Panel5: TPanel;
    DBMemo1: TDBMemo;
    SpeedButton3: TSpeedButton;
    CheckBox1: TCheckBox;
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
    StringGrid1: TStringGrid;
    Panel7: TPanel;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    BitBtn8: TBitBtn;
    Edit6: TEdit;
    Label44: TLabel;
    Edit7: TEdit;
    Label45: TLabel;
    Label46: TLabel;
    Edit8: TEdit;
    isopen: TCheckBox;
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
    PopupMenu6: TPopupMenu;
    N11: TMenuItem;
    N12: TMenuItem;
    PopupMenu7: TPopupMenu;
    N13: TMenuItem;
    N14: TMenuItem;
    BitBtn16: TBitBtn;
    OpenDialog1: TOpenDialog;
    SavePictureDialog1: TSavePictureDialog;
    BitBtn17: TBitBtn;
    BitBtn18: TBitBtn;
    BitBtn19: TBitBtn;
    Label33: TLabel;
    Label65: TLabel;
    Label66: TLabel;
    Label67: TLabel;
    N15: TMenuItem;
    N16: TMenuItem;
    N17: TMenuItem;
    BitBtn3: TBitBtn;
    N18: TMenuItem;
    Panel16: TPanel;
    BitBtn20: TBitBtn;
    SG2: TStringGrid;
    PopupMenu8: TPopupMenu;
    N20: TMenuItem;
    N21: TMenuItem;
    N22: TMenuItem;
    N23: TMenuItem;
    N24: TMenuItem;
    Print_menu: TPopupMenu;
    MI1: TMenuItem;
    ECN1: TMenuItem;
    DBGridEh1: TDBGridEh;
    Label69: TLabel;
    PM20: TPopupMenu;
    N19: TMenuItem;
    DBCheckBox5: TDBCheckBox;
    CheckBox2: TCheckBox;
    BitBtn21: TBitBtn;
    N25: TMenuItem;
    SET1: TMenuItem;
    SET2: TMenuItem;
    N26: TMenuItem;
    N27: TMenuItem;
    N28: TMenuItem;
    N29: TMenuItem;
    PopupMenu9: TPopupMenu;
    N30: TMenuItem;
    N31: TMenuItem;
    N32: TMenuItem;
    N33: TMenuItem;
    PopupMenu10: TPopupMenu;
    N34: TMenuItem;
    N35: TMenuItem;
    N36: TMenuItem;
    N37: TMenuItem;
    N38: TMenuItem;
    Panel17: TPanel;
    Label71: TLabel;
    Label72: TLabel;
    Panel18: TPanel;
    StringGrid2: TStringGrid;
    ComboBox1: TComboBox;
    BitBtn22: TBitBtn;
    BitBtn23: TBitBtn;
    BitBtn24: TBitBtn;
    N110: TMenuItem;
    N111: TMenuItem;
    N39: TMenuItem;
    PopupMenu11: TPopupMenu;
    DRL1: TMenuItem;
    Genesis1: TMenuItem;
    PopupMenu12: TPopupMenu;
    N40: TMenuItem;
    N41: TMenuItem;
    BitBtn25: TBitBtn;
    DBGrid4: TDBGrid;
    Splitter1: TSplitter;
    DBEdit34: TDBEdit;
    Label68: TLabel;
    Genesis2: TMenuItem;
    N42: TMenuItem;
    N43: TMenuItem;
    N44: TMenuItem;
    DBCheckBox6: TDBCheckBox;
    DBEdit35: TDBEdit;
    Label70: TLabel;
    Panel19: TPanel;
    StringGrid3: TStringGrid;
    ComboBox2: TComboBox;
    PopupMenu13: TPopupMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    Panel20: TPanel;
    Image4: TImage;
    Panel21: TPanel;
    BitBtn27: TBitBtn;
    BitBtn28: TBitBtn;
    Label73: TLabel;
    Label74: TLabel;
    Label75: TLabel;
    Label76: TLabel;
    Label77: TLabel;
    ActionList1: TActionList;
    Action1: TAction;
    Action2: TAction;
    Action3: TAction;
    BitBtn26: TBitBtn;
    DBCheckBox7: TDBCheckBox;
    dbchkREACH: TDBCheckBox;
    btnTB: TSpeedButton;
    procedure DBGrid1CellClick(Column: TColumn);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormCreate(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure DBComboBox1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure BitBtn2Click(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure SpeedButton5Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure DBEdit19KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBEdit20KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBEdit22KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBEdit17KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBEdit18KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure DBEdit15KeyPress(Sender: TObject; var Key: Char);
    procedure DBEdit21KeyPress(Sender: TObject; var Key: Char);
    procedure DBEdit21KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
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
    procedure StringGrid1MouseDown(Sender: TObject; Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
    procedure N7Click(Sender: TObject);
    procedure PopupMenu3Popup(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure StringGrid1KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure StringGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer; var CanSelect: Boolean);
    procedure StringGrid1Exit(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
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
    procedure N12Click(Sender: TObject);
    procedure N11Click(Sender: TObject);
    procedure N13Click(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
    procedure N14Click(Sender: TObject);
    procedure Tab(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure BitBtn16Click(Sender: TObject);
    procedure DBEdit7Exit(Sender: TObject);
    procedure BitBtn17Click(Sender: TObject);
    procedure BitBtn18Click(Sender: TObject);
    procedure BitBtn19Click(Sender: TObject);
    procedure N15Click(Sender: TObject);
    procedure N16Click(Sender: TObject);
    procedure N17Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure N18Click(Sender: TObject);
    procedure SG2KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure SG2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure N20Click(Sender: TObject);
    procedure N21Click(Sender: TObject);
    procedure N22Click(Sender: TObject);
    procedure N24Click(Sender: TObject);
    procedure PopupMenu8Popup(Sender: TObject);
    procedure BitBtn20Click(Sender: TObject);
    procedure N23Click(Sender: TObject);
    procedure MI1Click(Sender: TObject);
    procedure ECN1Click(Sender: TObject);
    procedure SG2Exit(Sender: TObject);
    procedure PM20Popup(Sender: TObject);
    procedure N19Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BitBtn21Click(Sender: TObject);
    procedure SET1Click(Sender: TObject);
    procedure SET2Click(Sender: TObject);
    procedure Edit7KeyPress(Sender: TObject; var Key: Char);
    procedure N27Click(Sender: TObject);
    procedure N28Click(Sender: TObject);
    procedure N29Click(Sender: TObject);
    procedure PopupMenu9Popup(Sender: TObject);
    procedure N30Click(Sender: TObject);
    procedure N31Click(Sender: TObject);
    procedure N32Click(Sender: TObject);
    procedure N33Click(Sender: TObject);
    procedure StringGrid2DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure StringGrid2KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure N34Click(Sender: TObject);
    procedure N36Click(Sender: TObject);
    procedure StringGrid2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure N35Click(Sender: TObject);
    procedure N37Click(Sender: TObject);
    procedure N38Click(Sender: TObject);
    procedure PopupMenu10Popup(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure ComboBox1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure StringGrid2SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure BitBtn23Click(Sender: TObject);
    procedure BitBtn22Click(Sender: TObject);
    procedure BitBtn24Click(Sender: TObject);
    procedure N110Click(Sender: TObject);
    procedure N111Click(Sender: TObject);
    procedure N39Click(Sender: TObject);
    procedure DRL1Click(Sender: TObject);
    procedure Genesis1Click(Sender: TObject);
    procedure N40Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure N41Click(Sender: TObject);
    procedure BitBtn25Click(Sender: TObject);
    procedure Genesis2Click(Sender: TObject);
    procedure N42Click(Sender: TObject);
    procedure DBComboBox2Change(Sender: TObject);
    procedure N44Click(Sender: TObject);
    procedure DBEdit1Exit(Sender: TObject);
    procedure StringGrid2KeyPress(Sender: TObject; var Key: Char);
    procedure StringGrid3KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ComboBox2Change(Sender: TObject);
    procedure ComboBox2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure StringGrid3DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure StringGrid3KeyPress(Sender: TObject; var Key: Char);
    procedure StringGrid3SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure StringGrid3KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure MenuItem3Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure PopupMenu13Popup(Sender: TObject);
    procedure BitBtn27Click(Sender: TObject);
    procedure BitBtn28Click(Sender: TObject);
    procedure Action1Execute(Sender: TObject);
    procedure Action2Execute(Sender: TObject);
    procedure Action3Execute(Sender: TObject);
    procedure BitBtn26Click(Sender: TObject);
    procedure btnTBClick(Sender: TObject);
  private
    { Private declarations }
    BomStepFalg: Integer;
   est_scrap : single;
   OldGridWnd : TWndMethod;
   dbgrid2wnd : TWndMethod;
   ecnopen,if_post,impedance,target:boolean; //�Ƿ���Ҫ���´�ecn�嵥
   strow,file_name:Tstringlist;            //���ڽ������ַ���,���ڴ洢�ϴ��Ĺ����ĵ�
   rev:string;                              //��Ʒ�汾
   procedure NewGridWnd (var Message : TMessage);
   procedure NewGrid2Wnd (var Message : TMessage);
   procedure get_picturedata502(rkey25:integer);
   procedure get_value(rkey278:integer);
   procedure get_data0279(rkey25:integer);
   procedure  get_drill(rkey25:integer);
   function get_employeename(rkey05: integer):string;
   function get_mindrill():single;
   function get_drTrow(row:integer):string;
   function get_drTrow2(row:integer):string;
   function get_customer(rkey10:integer):string;
   procedure update_notebook();
   procedure get_ecninfo(to_part_ptr:integer);
   function find_spec_rkey(spec_rkey: string): boolean;
   procedure update_deptcode(rkey25:integer);
   procedure update_tecparameter(rkey25:integer);
   procedure update_IESparameter(rkey25:integer);
   procedure update_drill(rkey25:integer);
   procedure load_xls_to_sgrid(fileName:String; grid:TStringGrid);
   function get_date0025toprkey(rkey25: integer):integer;
   procedure get_treedate(rkey25:integer;treeview:Ttreeview);
   procedure get_ecnlist(rkey25:integer);
   procedure get_impedance(rkey25:integer);
   procedure update_impedance(rkey25:integer);
   procedure get_target(rkey25:integer);
   procedure update_target(rkey25:integer);
   procedure update_ecnlist(rkey25:integer);
 //  function find_difficulty(rkey25:integer) :boolean;

   function calaflowpara(vstr:string):string;
   function vertify3(vstring:string):string;
   procedure update_filename();
   procedure Paste(var str:string);
   function isnum(str:string):boolean;
   function hz_jiajian(str:string;jia_or_jian:byte):string;
   function dr_jishuan(dr:single):single;
   function find_33null():boolean;
   procedure update_quanju();
   procedure SaveData();

  public
    { Public declarations }
  //  nearsize_part:string; //Ѱ��ƴ��ߴ�򽻻��ߴ�����Ĳ���������ʾ
    function find_setpnlmin(var nearsize_part:string):boolean;
    function find_nearpnlmin(var nearsize_part:string;pnl_size,pnl_width:string): boolean;
    function cacl_flowpara(tvalue,par_formula :string):string;
  end;

type
 TMyDBGrid=class(TDBGrid);

var
 Form2: TForm2;
const
 TmpFileDir = 'c:\tmp\';

implementation

uses damo, common, route_flow, flowpara_edit, deptcode_search,
  layer_frame, PickEngNote, append_productin, main, prod_search,
  stepnumber_search, layersdata_select, reportselect, report_data,
  product_search, drcacle, FileReadWriteUnitClass,PCBCUT, report_data1,
  PubFunc,shellAPI, Genesis_dr, holemanager, Unit2, childpart,
  IniFiles;

{$R *.dfm}
procedure TForm2.get_impedance(rkey25: integer);
var i:integer;
begin
for i:=1 to stringgrid2.RowCount-2 do  stringgrid2.Rows[i].Clear;
 with dm.ADOQuery1 do
 begin
  close;
  sql.Text:='select  MARK, layer, refe_layer, line_width, line_ofsight,'+
    'impedance, adjust_linewidth, adjust_lineofsight, adjust_impedance, product_impedance,'+
    'impedance_scope,orig_juli,adjust_jiuli,'+
    'type from data0030 where source_ptr='+inttostr(rkey25)+' order by seq_no ';
  open;
  stringgrid2.RowCount:=recordcount+2;
  for i:=1 to recordcount do
  begin
   stringgrid2.Cells[1,i]:=trim(fieldbyname('type').AsString);//����
   //ringgrid2.Cells[2,i]:=trim(fieldbyname('mark').AsString);//���
   stringgrid2.Cells[2,i]:=trim(fieldbyname('layer').AsString);//���
   stringgrid2.Cells[3,i]:=trim(fieldbyname('refe_layer').AsString);//�ο���
   stringgrid2.Cells[4,i]:=trim(fieldbyname('product_impedance').AsString);//��Ʒ�迹
   stringgrid2.Cells[5,i]:=trim(fieldbyname('adjust_impedance').AsString);//����ǰ�迹
   stringgrid2.Cells[6,i]:=trim(fieldbyname('impedance_scope').AsString);//�迹���Ʒ�Χ
   stringgrid2.Cells[7,i]:=trim(fieldbyname('line_width').AsString);//�ͻ��߿�
   stringgrid2.Cells[8,i]:=trim(fieldbyname('line_ofsight').AsString); //�ͻ��߾�;
   //ringgrid2.Cells[10,i]:=trim(fieldbyname('impedance').AsString); //�ͻ��迹;
   stringgrid2.Cells[9,i]:=trim(fieldbyname('orig_juli').AsString); //ԭʼ��ͭƤ����;
   stringgrid2.Cells[10,i]:=trim(fieldbyname('adjust_linewidth').AsString); //�����߿�;
   stringgrid2.Cells[11,i]:=trim(fieldbyname('adjust_lineofsight').AsString); //�����߾�;
   stringgrid2.Cells[12,i]:=trim(fieldbyname('adjust_jiuli').AsString); //������ͭƤ����;
   next;
  end;
  impedance:=true;
 end;

end;

procedure TForm2.update_impedance(rkey25:integer);
var i:integer;
begin
with dm.ADOQuery1 do
begin
 close;
 sql.Text:='delete from data0030 where source_ptr='+inttostr(rkey25);
 execsql;
end;

with dm.ADOQuery1 do
 begin
  close;
  sql.Text:='select seq_no,source_ptr, MARK, layer, refe_layer, line_width, line_ofsight,'+
    'impedance, adjust_linewidth, adjust_lineofsight, adjust_impedance, product_impedance,'+
    'type,impedance_scope,orig_juli,adjust_jiuli from data0030 where source_ptr='+inttostr(rkey25)+' order by seq_no ';
  open;
 end;

  for i:=1 to stringgrid2.RowCount-2 do
   dm.ADOQuery1.AppendRecord([i,
                              rkey25,
                              '',
                              stringgrid2.Cells[2,i],
                              stringgrid2.Cells[3,i],
                              stringgrid2.Cells[7,i],
                              stringgrid2.Cells[8,i],
                              '',
                              stringgrid2.Cells[10,i],
                              stringgrid2.Cells[11,i],
                              stringgrid2.Cells[5,i],
                              stringgrid2.Cells[4,i],
                              stringgrid2.Cells[1,i],
                              stringgrid2.Cells[6,i],
                              stringgrid2.Cells[9,i],
                              stringgrid2.Cells[12,i]]);

end;

procedure TForm2.get_target(rkey25:integer);
 var i:integer;
begin
for i:=1 to stringgrid3.RowCount-2 do StringGrid3.Rows[i].Clear;
 with dm.ADOQuery1 do
 begin
  close;
  sql.Text:='select seq_no,source_ptr,layer_remark,YAB,XFB,'+
    'XFC, XFG, XEA, XED, remark from data0033 where source_ptr='+inttostr(rkey25)+' order by seq_no ';
  open;
  stringgrid3.RowCount:=recordcount+2;
  for i:=1 to recordcount do
  begin
   stringgrid3.Cells[1,i]:=trim(fieldbyname('layer_remark').AsString);//���˵��
   stringgrid3.Cells[2,i]:=trim(fieldbyname('YAB').AsString);//YAB
   stringgrid3.Cells[3,i]:=trim(fieldbyname('XFB').AsString);//XFB
   stringgrid3.Cells[4,i]:=trim(fieldbyname('XFC').AsString);//XFC
   stringgrid3.Cells[5,i]:=trim(fieldbyname('XFG').AsString);//XFG
   stringgrid3.Cells[6,i]:=trim(fieldbyname('XEA').AsString);//XEA
   stringgrid3.Cells[7,i]:=trim(fieldbyname('XED').AsString);//XED
   stringgrid3.Cells[8,i]:=trim(fieldbyname('remark').AsString);//��ע��Ϣ
   next;
  end;
  target:=True;
 end;
end;

procedure TForm2.update_target(rkey25:integer);
var i:integer;
begin
if find_33null then
begin
  with dm.ADOQuery1 do
  begin
   close;
   sql.Text:='delete from data0033 where source_ptr='+inttostr(rkey25);
   execsql;
  end;

with dm.ADOQuery1 do
 begin
  close;
  sql.Text:='select seq_no,source_ptr,layer_remark,YAB,XFB,'+
    'XFC,XFG,XEA,XED,remark from data0033 where source_ptr='+inttostr(rkey25)+' order by seq_no ';
  open;
 end;

  for i:=1 to stringgrid3.RowCount-2 do
   dm.ADOQuery1.AppendRecord([i,
                              rkey25,
                              stringgrid3.Cells[1,i],
                              stringgrid3.Cells[2,i],
                              stringgrid3.Cells[3,i],
                              stringgrid3.Cells[4,i],
                              stringgrid3.Cells[5,i],
                              stringgrid3.Cells[6,i],
                              stringgrid3.Cells[7,i],
                              stringgrid3.Cells[8,i]]);

end;
end;


procedure Tform2.get_ecnlist(rkey25:integer);
var i:integer;
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

function Tform2.vertify3(vstring:string):string;
var
  i,j,j0,j1:integer;
begin
 vstring:=' '+vstring+' ';

while POS('IF(',vstring) > 0 do
 begin
  i:=POS('IF(',vstring);
  j:=POS(',',vstring);
  j0:=POS(',',copy(vstring,j+1,length(vstring)-j));
  j1:=POS(')',copy(vstring,j+j0+1,length(vstring)-j-j0));

  try    //����IF������������ֵ1������ֵ2���������������ʽ�Ƿ�Ϸ�
   with dm.ADOQuery4 do
    begin
     close;
     sql.clear;
     sql.add('select 1 as true_or_false where '+copy(vstring,i+3,j-i-3));
     open;
    end;
  except
   showmessage('��ʽ�趨������׼ȷ'+dm.ADS38STEP_NUMBER.AsString);
   exit;
  end;

  if not dm.ADOQuery4.IsEmpty then   //��Ϊ�մ�����������,ȡ����ֵ1
   try    //����IF������������ֵ1������ֵ2�������ķ���ֵ1�Ƿ���Ч
     with dm.ADOQuery4 do
      begin
       close;
       sql.clear;
       sql.add('SELECT 1.000000*('+copy(vstring,j+1,j0-1)+') as vqty ');
       open;
      end;
   except
    showmessage('��ʽ�趨�����ķ���ֵ1��׼ȷ'+dm.ADS38STEP_NUMBER.AsString);
    exit;
   end
  else    // ����������ȡ����ֵ2
   try    //����IF������������ֵ1������ֵ2�������ķ���ֵ2�Ƿ���Ч
    with dm.ADOQuery4 do
     begin
      close;
      sql.clear;
      sql.add('SELECT 1.000000*('+copy(vstring,j+j0+1,j1-1)+') as vqty ');
      open;
     end;
   except
    showmessage('��ʽ�趨�����ķ���ֵ2��׼ȷ'+dm.ADS38STEP_NUMBER.AsString);
    exit;
   end;

   vstring:=copy(vstring,1,i-1)+dm.ADOQuery4.fieldbyname('vqty').asstring+
            copy(vstring,j+j0+j1+1,length(vstring)-j-j0-j1);
 end;

 result:='SELECT '+vstring+' as tvalue';
end;

function Tform2.calaflowpara(vstr:string):string;
var
  j:integer;
  vstring,vstring1,vstring2:string;
begin
 vstring:=' '+vstr+' ';

 while pos(' PROJECT ',vstring)>0 do//�����Ʒ�ͺű����ö��
  begin
   j:=pos(' PROJECT ',vstring);
   vstring1:=copy(vstring,1,j-1);
   vstring2:=copy(vstring,j+2+length(trim(' PROJECT ')),500-j-length(trim(' PROJECT ')));
   vstring:=vstring1+' '''+treeview1.Items[0].Text+''''+vstring2;
  end;

 dm.ADS279.DisableControls;
 dm.ads279.First ;
 while not dm.ads279.eof do
  begin
   while pos(' '+trim(dm.ads279PARAMETER_NAME.Value)+' ',vstring)>0 do //���һ�����������˶�ξ�ͨ�����ѭ����һ����
    begin
      j:=pos(' '+trim(dm.ads279PARAMETER_NAME.Value)+' ',vstring);
      vstring1:=copy(vstring,1,j-1);
      vstring2:=copy(vstring,j+2+length(trim(dm.ads279PARAMETER_NAME.Value)),
                           500-j-length(trim(dm.ads279PARAMETER_NAME.Value)));
      IF dm.ads279datatype.value='����' then    //������ֵ�ͱ���
       if pos('.',trim(dm.ads279PARAMETER_VALUE.Value))>0 then
        vstring:=vstring1+' '+trim(dm.ads279PARAMETER_VALUE.Value)+' '+vstring2
       else
        vstring:=vstring1+' '+trim(dm.ads279PARAMETER_VALUE.Value)+'.0000000'+' '+vstring2
      else     //�ַ���
       vstring:=vstring1+' '''+trim(dm.ads279PARAMETER_VALUE.Value)+''' '+vstring2;
    end;
   dm.ads279.Next;
  end;
  dm.ADS279.EnableControls;

  if POS('IF(',vstring) > 0 then
   result := vertify3(vstring)
  else
   result := 'SELECT '+vstring+' as tvalue';
end;

function Tform2.cacl_flowpara(tvalue, par_formula: string): string;
begin
 result:=tvalue;

 if par_formula<>'' then
  try
   dm.ADOQuery3.Close;
   dm.ADOQuery3.SQL.Text:=self.calaflowpara(par_formula);
   dm.ADOQuery3.Open;

  if not dm.ADOQuery3.IsEmpty then
   result:=dm.ADOQuery3.fieldbyname('tvalue').AsString;
  except

  end

end;

procedure Tform2.update_ecnlist(rkey25:integer);
var i:byte;
begin
 with dm.ADOQuery1 do
 begin
  close;
  sql.Text:='delete data0035 where part_ptr='+inttostr(rkey25);
  execsql;

  sql.Text:='select serial_no,part_number,text,source,if_gerber,'
    +'engineer,enter_date,ecn_no,create_employee,part_ptr '
    +' from data0035 where part_ptr='+inttostr(rkey25);
  open;
  for i:=1 to sg2.RowCount-2 do
   if trim(sg2.Cells[6,i])='' then
     dm.ADOQuery1.AppendRecord([i,sg2.cells[1,i],sg2.cells[2,i],sg2.cells[3,i],
       sg2.cells[4,i],sg2.cells[5,i],null,sg2.cells[7,i],
       sg2.cells[8,i],rkey25])
   else
     dm.ADOQuery1.AppendRecord([i,sg2.cells[1,i],sg2.cells[2,i],sg2.cells[3,i],
       sg2.cells[4,i],sg2.cells[5,i],strtodate(sg2.cells[6,i]),sg2.cells[7,i],
       sg2.cells[8,i],rkey25]);
 end;
end;

function TForm2.find_setpnlmin(var nearsize_part:string): boolean;
begin
  nearsize_part:='';
 with dm.ADOQuery5 do
 begin
  close;
  sql.Delete(sql.Count-2);  //ע��sql�ľ�̬���������ӿ���
  if dm.AQY0025PARENT_PTR.Value > 0 then       //�ڲ�
    sql.Insert(sql.Count-1,'and (PARENT_PTR <> '+dm.AQY0025PARENT_PTR.AsString+')')
  else                                //���
    sql.Insert(sql.Count-1,'and (PARENT_PTR is null)');

  Parameters.ParamByName('set_len_min').Value:=dm.AQY0025set_lngth.Value-1;
  Parameters.ParamByName('set_len_max').Value:=dm.AQY0025set_lngth.Value+1;
  Parameters.ParamByName('set_wth_min').Value:=dm.AQY0025set_width.Value-1;
  Parameters.ParamByName('set_wth_max').Value:=dm.AQY0025set_width.Value+1;
  Parameters.ParamByName('set_len_min1').Value:=dm.AQY0025set_width.Value-1;
  Parameters.ParamByName('set_len_max1').Value:=dm.AQY0025set_width.Value+1;
  Parameters.ParamByName('set_wth_min1').Value:=dm.AQY0025set_lngth.Value-1;
  Parameters.ParamByName('set_wth_max1').Value:=dm.AQY0025set_lngth.Value+1;
  Parameters.ParamByName('rkey').Value:=dm.AQY0025RKEY.Value;
  Prepared:=true;
  open;
  while not Eof do
  begin
   nearsize_part:=nearsize_part+Fieldbyname('number').AsString+Fieldbyname('rev').AsString+' ';
   Next;
  end;
  Close;  //����andy081030
 end;

  if Trim(nearsize_part)='' then
   result:=false
  else
   result:=true;

end;

function TForm2.find_nearpnlmin(var nearsize_part:string;pnl_size,pnl_width:string): boolean;
begin
 nearsize_part:='';
 with dm.ADOQuery1 do
 begin
  close;
  sql.Text:=
   'SELECT top 50 dbo.Data0025.MANU_PART_NUMBER'+#13+
   ' FROM  dbo.Data0279 INNER JOIN'+#13+
   '  dbo.Data0278 ON dbo.Data0279.PARAMETER_PTR = dbo.Data0278.RKEY INNER JOIN'+#13+
   '  dbo.Data0025 ON dbo.Data0279.SOURCE_PTR = dbo.Data0025.RKEY INNER JOIN'+#13+
   '  dbo.Data0279 AS Data0279_1 ON dbo.Data0025.RKEY = Data0279_1.SOURCE_PTR INNER JOIN'+#13+
   '   dbo.Data0278 AS Data0278_1 ON Data0279_1.PARAMETER_PTR = Data0278_1.RKEY'+#13+

  'where (data0025.ANALYSIS_CODE_1='+quotedstr(dm.AQY0025ANALYSIS_CODE_1.Value)+')'+#13+  //�����ߴ���ͬ

  'AND (Data0278.SPEC_RKEY = ''6'')'+#13+       //A�峤����
  'AND (DATA0025.PARENT_PTR is null)'+#13+          //���
  'AND (Data0278_1.SPEC_RKEY = ''7'')'+#13+         //A������

  'AND (Data0279.PARAMETER_VALUE >= '+quotedstr(CurrToStr(StrToCurr(pnl_size)-3))+')'+#13+  //���ڵ���A��� ����3mm
  'AND (Data0279.PARAMETER_VALUE <= '+quotedstr(CurrToStr(StrToCurr(pnl_size)+3))+')'+#13+  //С�ڵ���A��� ����3mm

  'AND (Data0279_1.PARAMETER_VALUE >= '+quotedstr(CurrToStr(StrToCurr(pnl_width)-3))+')'+#13+  //���ڵ���A��� ���3mm
  'AND (Data0279_1.PARAMETER_VALUE <= '+quotedstr(CurrToStr(StrToCurr(pnl_width)+3))+')'+#13+  //С�ڵ���A��� ���3mm

  'and (SUBSTRING(dbo.Data0025.MANU_PART_NUMBER, 1, LEN(dbo.Data0025.MANU_PART_NUMBER) - 2) <> '+
   quotedstr(Copy(dm.AQY0025MANU_PART_NUMBER.Value,1,length(dm.AQY0025MANU_PART_NUMBER.Value)-2))+')'+#13+
   'order by Data0025.MANU_PART_NUMBER desc';

  Prepared;
  open;
  while not Eof do
  begin
   nearsize_part:=nearsize_part+Fieldbyname('MANU_PART_NUMBER').AsString+' ';
   Next;
  end;
 end;

 if Trim(nearsize_part)='' then
  result:=false
 else
  result:=true;

end;

procedure TForm2.Tab(Sender: TObject; var Key: Word; Shift: TShiftState);
Begin
  if (key=VK_Down) or (key=13) then
   SelectNext(ActiveControl,True,True);
  if key=VK_Up then
   SelectNext(ActiveControl,False,True);
  Key:=0;
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
  radiogroup1.ItemIndex:=fieldbyname('source').AsInteger-1;
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
 dm.ads497.Close;
 dm.ADS279_0.Close;
 dm.ads89.Close;
 dm.ads564.Close;
 dm.ADO20.Close;
 file_name.Clear;
 edit3.Text:='';         //����޸���
 isopen.Checked:=false;  //��ױ���Ҫ���´�
 impedance:=false;       //�迹�������´�
 ecnopen:=false;         //ecn�嵥��Ҫ���´�
 target:=false;          //ѹ�ϰоر������´�
 memo2.ReadOnly:=false;  //ECN��Ҫ���´�
 memo3.ReadOnly:=false;  //�ͻ���Ϣ��Ҫ���´�
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
  if not dm.ads502pnl_bmp.IsNull then
   image2.Picture.Assign(Load_JPG_Pic_From_DB(dm.ads502pnl_bmp));

  if not dm.ads502pnl2_bmp.IsNull then
   image3.Picture.Assign(Load_JPG_Pic_From_DB(dm.ads502pnl2_bmp));
 { if strtoint(status.Caption)=0 then   //�༭
   begin
    if abs(dm.AQY0025spell_lngth.Value - dm.ads502UNIT_LEN.Value)>0.001 then
     dm.AQY0025spell_lngth.Value := dm.ads502UNIT_LEN.Value;

    if abs(dm.AQY0025spell_width.Value - dm.ads502UNIT_WTH.Value)>0.001 then
     dm.AQY0025spell_width.Value := dm.ads502UNIT_WTH.Value;

    if dm.AQY0025spell_qty.Value<>dm.ads502UNIT_NUM.Value then
     dm.AQY0025spell_qty.Value := dm.ads502UNIT_NUM.Value;  
    DBEdit19Exit(nil);   
   end;}
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
   'SELECT TOP 100 PERCENT RKEY,SEQUENCE_NO,PARAMETER_INFO FROM dbo.Data0278'+#13+
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
      dm.ads279IES_PROD.Value:=1;       //����ȫ�ֲ���0���������жϲ���
      dm.ads279IES_CRP.AsVariant:=dm.ADOQuery1.FieldValues['SEQUENCE_NO'];//�����ֶ�
      dm.ads279PARAMETER_VALUE.Value:=dm.ADOQuery1.fieldbyname('PARAMETER_INFO').AsString; //Ĭ��ֵ
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
        dm.ads279IES_CRP.AsVariant:=dm.ADOQuery1.FieldValues['SEQUENCE_NO'];//�����ֶ�
        dm.ads279PARAMETER_VALUE.Value:=dm.ADOQuery1.fieldbyname('PARAMETER_INFO').AsString; //Ĭ��ֵ
        dm.ads279.Post;
       end;
       dm.ADOQuery1.Next;
     end;
    dm.ADOQuery1.Close;
    dm.ads279.First;
   end;

  dm.ads279.EnableControls;
end;

function TForm2.get_mindrill():single;
var
 min_drill:single;
 i:integer;
begin
 try
  if stringgrid1.Cells[6,1] <> '' then
    min_drill:= strtocurr(stringgrid1.Cells[6,1]);
 except
  min_drill:=0;
 end;

 if stringgrid1.RowCount>3 then
 for i:=2 to stringgrid1.RowCount-2 do
 begin
    if stringgrid1.Cells[6,i] <> '' then
    begin
      try
       strtofloat(stringgrid1.Cells[6,i]);
      except
       Continue;
      end;
      if  strtofloat(stringgrid1.Cells[6,i]) < min_drill then
       min_drill:= strtocurr( stringgrid1.Cells[6,i]);
    end;
 end;
 result:=min_drill;
end;

function TForm2.get_drTrow(row: integer): string;
var
 i,t1:integer;
 t0:string;
begin
 if row <= 1 then
  result:='1'
 else
  for i:=row-1 downto 1 do
   if trim(stringgrid1.Cells[1,i])<>'' then
    begin
     t0:=copy(trim(stringgrid1.Cells[1,i]),2,length(trim(stringgrid1.Cells[1,i]))-1);
     try
      t1:=strtoint(t0)+1;
     except
      t1:=row;
     end;
     result:=inttostr(t1);
     break;
    end
   else
    if i=1 then
     result:='1'
    else
     result:=inttostr(row);
end;

function TForm2.get_drTrow2(row: integer): string;
var
 i:integer;
 t0:string;
begin
 if row <= 1 then
  result:='A'
 else
  for i:=row-1 downto 1 do
   if trim(stringgrid2.Cells[2,i])<>'' then
    begin
     t0 :=copy(trim(stringgrid2.Cells[2,i]),
                length(trim(stringgrid2.Cells[2,i])),1);
     result:=succ(t0[1]);
     break;
    end
   else
    if i=1 then
     result:='A';
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
  'tooling_rev, OUTP_SPFC,tool_old_rev,TOOL_REMARK'+#13+
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
                              dm.ADS38TOOL_REMARK.Value
                              ]);
 dm.ADS38.Next;
end;
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
   dm.ADOQuery1.AppendRecord([dm.ads494PARAMETER_PTR.Value,  //����ָ��278
                              dm.ads494PARAMETER_VALUE.Value, //����ֵ
                              dm.ads494custpart_ptr.Value,   //��Ʒָ��25
                              dm.ads494step_number.Value,    //��Ʒ����
                              dm.ads494seq_no.Value,        //���
                              dm.ads494Doc_Flag.Value,      //�Ƿ��ӡ
                              dm.ads494after_flag.Value,     //��
                              dm.ads494flow_spfc_flag.Value   //�Ƿ��ص�
                              ]);
 dm.ads494.Next;
end;
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
    dm.ADOQuery1.AppendRecord([dm.ads497PARAMETER_PTR.Value,  //����ָ��278
                               dm.ads497PARAMETER_VALUE.Value, //����ֵ
                               dm.ads497SOURCE_PTR.Value,   //�ɱ����Ĳ�����
                               dm.ADOQuery2.FieldByName('rkey').AsInteger,//�������
                               dm.ads497SEQ_NO.Value       //���
                               ]);
    dm.ads497.Next;
  end;

   dm.ADOQuery2.Next;
 end;

end;

procedure TForm2.update_drill(rkey25:integer);
var i:integer;
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
  'UNIT, SET_UNMBER,PANEL_A, PANEL_B, SEQ_NO,REMARK'+#13+
  'FROM dbo.Data0029'+#13+
  'where source_ptr='+inttostr(rkey25);
  open;
 end;
  for i:=1 to stringgrid1.RowCount-2 do
   dm.ADOQuery1.AppendRecord([rkey25,
                              stringgrid1.Cells[1,i],
                              stringgrid1.Cells[2,i],
                              stringgrid1.Cells[3,i],
                              stringgrid1.Cells[4,i],
                              stringgrid1.Cells[5,i],
                              stringgrid1.Cells[6,i],
                              stringgrid1.Cells[7,i],
                              stringgrid1.Cells[8,i],                              
                              stringgrid1.Cells[9,i],
                              stringgrid1.Cells[10,i],
                              i,
                              stringgrid1.Cells[11,i]]);

end;

procedure  TForm2.get_drill(rkey25:integer);
var i:integer;
begin
for i:=1 to stringgrid1.RowCount-2 do  stringgrid1.Rows[i].Clear;
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
  'UNIT, PANEL_A, PANEL_B, REMARK,SET_UNMBER'+#13+
  'FROM dbo.Data0029'+#13+
  'where source_ptr='+inttostr(rkey25)+#13+
  'ORDER BY SEQ_NO';
  open;
  stringgrid1.RowCount:=RecordCount+2;
  for i:=1 to RecordCount do
   begin
    stringgrid1.Cells[0,i]:=inttostr(i);
    stringgrid1.Cells[1,i]:=trim(fieldbyname('SEQ_NR').AsString); //'����';
    stringgrid1.Cells[2,i]:=trim(fieldbyname('MARK').AsString);//'����';
    stringgrid1.Cells[3,i]:=trim(fieldbyname('HOLES_DIA').AsString);//'��Ʒ�׾�';
    stringgrid1.Cells[4,i]:=trim(fieldbyname('PTH').AsString);//'PTH';
    stringgrid1.Cells[5,i]:=trim(fieldbyname('TOLERANCE').AsString);//'����';
    stringgrid1.Cells[6,i]:=trim(fieldbyname('DRILL_DIA').AsString);//'���';
    stringgrid1.Cells[7,i]:=trim(fieldbyname('UNIT').AsString);//'PCS����';
    stringgrid1.Cells[8,i]:=trim(fieldbyname('SET_UNMBER').AsString);//'SET����';
    stringgrid1.Cells[9,i]:=trim(fieldbyname('PANEL_A').AsString);//'A�����';
    stringgrid1.Cells[10,i]:=trim(fieldbyname('PANEL_B').AsString);//'B�����';
    stringgrid1.Cells[11,i]:=trim(fieldbyname('REMARK').AsString);//'��ע';
    next;
   end;
 end;
 edit6.Text:=formatfloat('0.00',(get_mindrill()));
 isopen.Checked:=true;
end;

function tform2.get_customer(rkey10:integer):string;
begin
with dm.ADOQuery1 do
 begin
  close;
  sql.Clear;
  sql.Add('select memo_text from data0011 where SOURCE_TYPE=6010');
  sql.Add('and FILE_POINTER='+inttostr(rkey10));
  open;
  if not IsEmpty then
   result:=FieldValues['memo_text']
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
  rkey := fieldbyname('parent_ptr').AsInteger; //���ڸ�ֵ
 end;

 if rkey <= 0 then
  rkey:=rkey25       //������Ƕ�������Լ�
 else
  with dm.ADOQuery2 do
  begin
   close;
   sql.Text:='select parent_ptr from data0025 where rkey='+inttostr(rkey);
   open;
   if FieldByName('parent_ptr').AsInteger > 0 then
    begin
     rkey := fieldbyname('parent_ptr').AsInteger;  //�����үү����үүֵ
     with dm.ADOQuery3 do
      begin
       close;
       sql.Text:='select parent_ptr from data0025 where rkey='+inttostr(rkey);
       open;
       if FieldByName('parent_ptr').AsInteger > 0 then
         rkey := fieldbyname('parent_ptr').AsInteger;  //�����̫������̫��ֵ
      end;
    end;
  end;
 result:=rkey;
end;

procedure TForm2.get_treedate(rkey25: integer;treeview:Ttreeview);
var
 node:ttreenode;   //treeview�ؼ��Ľڵ����
 rkey0025:^integer;
begin

with dm.ADOQuery1 do
 begin
  close;
  sql.Text:='select rkey,MANU_PART_NUMBER from data0025 where rkey='+
              inttostr(get_date0025toprkey(rkey25));
  open;
  new(rkey0025);
  rkey0025^:=fieldvalues['rkey'];
  node:=treeview.Items.AddObject
  (nil,fieldbyname('MANU_PART_NUMBER').AsString,rkey0025); //���Ӷ���ڵ�
  node.ImageIndex:=0;  //Ϊ��һ��ڵ㶨��ͼ��
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
   node:=node.Parent; //�ڵ�ָ���丸�ڵ�ֵ
   dm.ADOQuery1.Next;
  end;
 end;

 treeview.FullExpand; //ȫ��չ��
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

procedure TForm2.update_filename;
var
 M: TMemoryStream;
 filename:string;
begin
  dm.ads564.UpdateBatch(arAll);
  M:=TMemoryStream.Create;
  dm.ads564.First;
  while not dm.ads564.Eof do
  begin
   if copy(file_name.Strings[dm.ads564rec_no.value],
           pos(';',file_name.Strings[dm.ads564rec_no.value])+1,
           1)='0' then
    begin
      M.Clear;
      filename:= copy(file_name.Strings[dm.ads564rec_no.value],1,
                     pos(';',file_name.Strings[dm.ads564rec_no.value])-1);
      M.LoadFromFile(filename);
      PackStream(M);
      dm.AQtmp.Close;
      dm.AQtmp.SQL.text:='update data0564 set vcut_bmp=:F where rec_no='+dm.ads564rec_no.AsString+
                         ' and SOURCE_PTR='+dm.ads564SOURCE_PTR.AsString;
      dm.AQtmp.Parameters[0].LoadFromStream(M,ftblob);
      dm.AQtmp.ExecSQL;
    end;
   dm.ads564.next;
  end;
  M.Free;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
 OldGridWnd := DBGrid1.WindowProc ;
 DBGrid1.WindowProc := NewGridWnd;

 DBGrid2Wnd := DBGrid2.WindowProc ;
 DBGrid2.WindowProc := NewGrid2Wnd;
 file_name:=tstringlist.Create;
end;

procedure TForm2.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if (key=40) and        //������¼�ͷ��������һ����¼
  (dm.ads279.RecNo=dm.ads279.RecordCount) then abort;
 if key=45 then abort; //insert��
 if (key=46) and (ssCtrl in shift) then abort;//ɾ����¼
 if (key=112) and
    (dbcombobox1.Visible) and
    (dbcombobox1.Enabled) then
  begin                         //F1����������
   dbcombobox1.SetFocus;
   dbcombobox1.DroppedDown:=true;
  end;
end;

procedure TForm2.DBGrid1KeyPress(Sender: TObject; var Key: Char);
begin
 if dm.ads279datatype.Value='����' then
 if not (key in ['0'..'9','.',#8,#13]) then  //�ж��Ƿ���������
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
if key=112 then dbcombobox1.DroppedDown:=true; //F1����������
if key=13 then dbgrid1.SetFocus;
end;

procedure TForm2.BitBtn2Click(Sender: TObject);
begin
 self.ModalResult:=mrcancel;
end;

procedure TForm2.ListBox1Click(Sender: TObject);
begin
 if dm.AQY0025RKEY.Value <> strtoint(rkey25.Caption) then
 begin
  if bitbtn11.Enabled then
  if messagedlg('������·��༭,�Ƿ��Զ���������?',mtconfirmation,[mbyes,mbno],0)=mryes then
   bitbtn11click(sender);
  self.update_notebook;
  dm.AQY0025.Close;
  dm.AQY0025.Parameters[0].Value:=strtoint(rkey25.Caption);
  dm.AQY0025.Open;
  if strtoint(status.Caption)=0 then
   begin
    dm.AQY0025.Edit;
    dm.AQY0025LAST_MODIFIED_DATE.Value := getsystem_date(dm.adoquery1,1);
    dm.AQY0025LAST_MODIFIED_BY_PTR.Value:=strtoint(user_ptr);
   end;
 end;

 if strtoint(status.Caption)=0 then   //�༭
  begin
   if not bitbtn1.Enabled then bitbtn1.Enabled:=true;
   if not bitbtn11.Enabled then bitbtn11.Enabled:=true;
   if not bitbtn14.Enabled then bitbtn14.Enabled:=true;
   if not bitbtn15.Enabled then bitbtn15.Enabled:=true;
  end;

 screen.Cursor:=crappstart;
 checkbox2.Checked:= trim(dm.AQY0025current_rev.Value) = 'Y';  //��±��

 if edit3.Text = '' then    //���޶���Ա
 begin
  edit3.Text:=self.get_employeename(dm.AQY0025LAST_MODIFIED_BY_PTR.Value);
  edit4.Text:=self.get_employeename(dm.AQY0025CHECK_BY_PTR.Value);
  edit5.Text:=self.get_employeename(dm.AQY0025AUDITED_BY_PTR.Value);

  with dm.ADOQuery1 do
  begin
   close;
   sql.Text:='select PROD_CODE,PRODUCT_NAME,est_scrap_ltm,'+#13+
             'est_scrap1_lmt from data0008'+#13+
             'where rkey='+dm.AQY0025PROD_CODE_PTR.AsString;
   open;
   edit1.Text:=fieldbyname('PROD_CODE').AsString;
   label15.Caption:=fieldbyname('PRODUCT_NAME').AsString;
   if dm.AQY0025ttype.Value=0 then
    self.est_scrap:=fieldbyname('est_scrap_ltm').AsCurrency
   else
    self.est_scrap:=fieldbyname('est_scrap1_lmt').AsCurrency;
  end;

  IF (DM.AQY0025PARENT_PTR.Value>0)  then
  begin
   dbedit32.Visible:=true;
   dbedit33.visible:=true;
   dbedit34.visible:=true; //ѹ�ϱ���
   bitbtn12.visible:=true;
   label64.Caption:='';
   label64.Visible:=true;
   label62.Visible:=true;
   label63.Visible:=true;
   label68.Visible:=true;
   dbedit7.ReadOnly:=true;   //�ڲ㲻�����޸ı�����
   DBEdit1.ReadOnly:=False; //�ڲ�����޸ı������
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
     dbedit34.Visible:=false;
     bitbtn12.Visible:=false;
     label64.Visible:=false;
     label62.Visible:=false;
     label63.Visible:=false;
     label68.Visible:=false;
     dbedit7.ReadOnly:=false; //�������޸ı�����
     DBEdit1.ReadOnly:=true;
   end;

 end;

 if not dm.ads502.Active then
 self.get_picturedata502(dm.AQY0025RKEY.Value); //��ƴ��ͼ

 if not dm.ads279.Active then
  self.get_data0279(dm.AQY0025RKEY.Value);     //��ȫ�ֲ���

 if not dm.ADS38.Active then
 begin
  dm.ADS38.Close;                         //�򿪹�������
  dm.ADS38.Parameters[0].Value:=dm.AQY0025RKEY.Value;
  dm.ADS38.Open;
  dm.ads494.Close;                      //�Ƴ̲���
  dm.ads494.Parameters[0].Value:=dm.AQY0025RKEY.Value;
  dm.ads494.Open;

  dm.ads497.Close;                      //BOMѡ�ϲ���
  dm.ads497.Parameters[0].Value:=dm.AQY0025RKEY.Value;
  dm.ads497.Open;

  dm.ADS279_0.close;                    //�����жϲ���
  dm.ADS279_0.Parameters[0].Value:=dm.AQY0025RKEY.Value;
  dm.ADS279_0.Open;
  if dm.AQY0025ENG_ROUTE_PTR.Value>0 then
  with dm.ADOQuery1 do
  begin
   close;
   sql.Text:='select ENG_FLOW_NAME,ENG_FLOW_DESC from data0504'+#13+
             'where rkey='+dm.AQY0025ENG_ROUTE_PTR.AsString;
   open;
   edit2.Text:=fieldbyname('ENG_FLOW_NAME').AsString;
   label56.Caption:=fieldbyname('ENG_FLOW_DESC').AsString;
  end
  else
   begin
   edit2.Text:='';
   label56.Caption:='';
   end;
 END;

if not isopen.Checked then  self.get_drill(dm.AQY0025RKEY.Value); //����ױ�
if not target then  self.get_target(dm.AQY0025RKEY.Value);       //��ѹ�ϰоر�
if treeview1.Selected.Level=0 then       //�����Ʒʱ���
 begin

  if not memo2.ReadOnly then                    //��ECN���̸���
   begin
    self.get_ecninfo(dm.AQY0025RKEY.Value);
    memo2.ReadOnly:=true;
   end;

  if not dm.ads89.Active then  dm.ads89.Open;  //��������Ϣ(ֻ�ж�����)

  if not memo3.ReadOnly then                    //�򿪿ͻ�������Ϣ
   begin
    memo3.Text:=self.get_customer(dm.AQY0025CUSTOMER_PTR.Value);
    memo3.ReadOnly:=true;
    dm.ADO20.Close;
    dm.ADO20.Parameters[0].Value:=dm.AQY0025CUSTOMER_PTR.Value;
    dm.ADO20.Open;
   end;

  if not ecnopen then
   begin
    get_ecnlist(dm.AQY0025RKEY.Value);       //��ECN������
    dm.ADS564.Close;                         //�򿪹�������ĵ�
    dm.ADS564.Parameters[0].Value:=dm.AQY0025RKEY.Value;
    dm.ADS564.Open;
    while not dm.ads564.Eof do
    begin
     file_name.Add(dm.ads564file_name.Value+';'+'1');
     dm.ads564.Next;
    end;
    dm.ads564.First;
   end;

   if not impedance then                   //���迹��
     self.get_impedance(dm.AQY0025RKEY.Value);
 end;

 notebook1.PageIndex := listbox1.ItemIndex+1;
 headercontrol1.Sections[2].Text := listbox1.Items[listbox1.ItemIndex];

 screen.Cursor:=crdefault;
end;

procedure TForm2.FormActivate(Sender: TObject);
begin
 inputform:=Tinputform.Create(Application);
 if_post:=false;
 self.get_treedate(dm.AQY0025RKEY.Value,treeview1);
 notebook1.PageIndex:=0;
 rev:=copy(dm.AQY0025MANU_PART_NUMBER.Value,
      length(trim(dm.AQY0025MANU_PART_NUMBER.Value))-1,2);//��Ʒ�汾
 stringgrid1.Cells[0,0]:='��';
 stringgrid1.Cells[1,0]:='����';
 stringgrid1.Cells[2,0]:='����';
 stringgrid1.Cells[3,0]:='��Ʒ�׾�';
 stringgrid1.Cells[4,0]:='PTH';
 stringgrid1.Cells[5,0]:='����';
 stringgrid1.Cells[6,0]:='���';
 stringgrid1.Cells[7,0]:='PCS����';
 stringgrid1.Cells[8,0]:='SET����';

 stringgrid1.Cells[9,0]:='A�����';
 stringgrid1.Cells[10,0]:='B�����';
 stringgrid1.Cells[11,0]:='��ע';

 stringgrid2.Cells[0,0]:='��';
 stringgrid2.Cells[1,0]:='����';
 stringgrid2.Cells[2,0]:='���';
 stringgrid2.Cells[3,0]:='�ο���';
 stringgrid2.Cells[4,0]:='��Ʒ�迹';
 stringgrid2.Cells[5,0]:='����ǰ�迹';
 stringgrid2.Cells[6,0]:='�迹���Ʒ�Χ';
 stringgrid2.Cells[7,0]:='�ͻ��߿�';
 stringgrid2.Cells[8,0]:='�ͻ��߾�';
 stringgrid2.Cells[9,0]:='ԭʼ��ͭƤ����';
 stringgrid2.Cells[10,0]:='�����߿�';
 stringgrid2.Cells[11,0]:='�����߾�';
 stringgrid2.Cells[12,0]:='������ͭ����';

 sg2.Cells[0,0]:='���';
 sg2.Cells[1,0]:='����汾';
 sg2.Cells[2,0]:='�������ժҪ';
 sg2.Cells[3,0]:='��Դ';
 sg2.Cells[4,0]:='�������ļ�';
 sg2.Cells[5,0]:='����ʦ';
 sg2.Cells[6,0]:='����';
 sg2.Cells[7,0]:='ECN���';
 sg2.ColWidths[8]:=0;

 stringgrid3.Cells[0,0]:='���';
 stringgrid3.Cells[1,0]:='���˵��';
 stringgrid3.Cells[2,0]:='YAB';
 stringgrid3.Cells[3,0]:='XFB';
 stringgrid3.Cells[4,0]:='XFC';
 stringgrid3.Cells[5,0]:='XFG';
 stringgrid3.Cells[6,0]:='XEA';
 stringgrid3.Cells[7,0]:='XED';
 stringgrid3.Cells[8,0]:='��ע��Ϣ';

 if dm.AQY0025PROD_ROUTE_PTR.Value>0 then
  with dm.ADOQuery1 do
  begin
   close;
   sql.Text:='select WAREHOUSE_CODE,ABBR_NAME from data0015'+#13+
             'where rkey='+dm.AQY0025PROD_ROUTE_PTR.AsString;
   open;
   label66.Caption:=fieldbyname('WAREHOUSE_CODE').AsString;
   label67.Caption:=fieldbyname('ABBR_NAME').AsString;
  end;

 if strtoint(status.Caption)=1 then   //���״̬
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
  dbcheckbox7.Enabled:=false;
  dbcheckbox6.Enabled:=false; //��Ǧ
  checkbox2.Enabled:=false;  //��±��
  bitbtn12.Enabled:=false;
  bitbtn13.Enabled:=false;
  bitbtn16.Enabled:=false;
  bitbtn19.Enabled:=false;
  bitbtn24.Enabled:=false;
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
  BitBtn25.Enabled:=false;


  speedbutton1.Enabled:=false;
  speedbutton2.Enabled:=false;
  speedbutton6.Enabled:=false;

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
  sg2.Options:=sg2.Options+[gorowselect];
  sg2.PopupMenu:=nil;
  bitbtn9.Enabled:=false;
  bitbtn10.Enabled:=false;
  bitbtn20.Enabled:=false;
  stringgrid2.Options:=stringgrid2.Options+[gorowselect];
  stringgrid2.PopupMenu:=nil;
  stringgrid3.Options:=stringgrid3.Options+[gorowselect];
  stringgrid3.PopupMenu:=nil;
  bitbtn22.Enabled:=false;
  combobox1.Enabled:=false;
  combobox2.Enabled:=false;
//  dbmemo2.ReadOnly:=true;
  dbmemo3.ReadOnly:=true;
  dbmemo4.ReadOnly:=true;
  dbradiogroup2.ReadOnly:=true;
 end
 else
  begin
   if dm.AQY0025SO_UNIT.Value='PCS' THEN
    begin
      dbedit17.Enabled:=false;
      dbedit18.Enabled:=false;
      dbedit21.Enabled:=false;
    end;
  end;
end;


procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 if if_post then
  with dm.ADOQuery3 do
   begin
    close;            //��¼����������(��־�ļ�)
    sql.Clear;
    sql.Add('insert into data0318 (CUSTOMER_PART_PTR,TRANS_TYPE,TRANS_DESCRIPTION,');
    sql.Add('USER_PTR,file_number,TRANS_DATE,PROGRAM_SOURCE)');
    sql.Add('values ('+dm.AQY0025RKEY.AsString+',25,''�༭��Ʒ������'',');
    sql.Add(''+rkey73+',''WZMI25.EXE'',');
    sql.add(''''+datetostr(dm.AQY0025LAST_MODIFIED_DATE.Value)+''',25)');
    ExecSQL;
   end;
 self.update_notebook();
 inputform.Free;
 
end;

procedure TForm2.SpeedButton5Click(Sender: TObject);
begin
 self.get_ecninfo(dm.AQY0025RKEY.Value);
end;

procedure TForm2.SpeedButton4Click(Sender: TObject);
begin
 if strtoint(from_part_ptr.Caption)>0 then
  self.get_ecninfo(strtoint(from_part_ptr.Caption))
 else messagedlg('����ǵ��ѵ����ϲ�!',mtinformation,[mbcancel],0);
end;
   {
function TForm2.find_difficulty(rkey25: integer): boolean;
begin
result:=false;
with dm.ADOQuery1 do
 begin
  close;
  sql.Text:=
  'SELECT data0494.PARAMETER_VALUE'+#13+
  'FROM Data0494 inner join data0278'+#13+
  'on data0494.PARAMETER_PTR=data0278.rkey'+#13+
  'where data0278.SPEC_RKEY=''ZH'''+#13+
  'and data0494.custpart_ptr='+inttostr(rkey25);
  open;                      //��ͭ�ݺ��
 end;
if (not dm.ADOQuery1.IsEmpty) and
   (dm.ADOQuery1.FieldByName('PARAMETER_VALUE').AsString<>'') then
try
if strtofloat(dm.ADOQuery1.FieldByName('PARAMETER_VALUE').AsString)>=7 then
 result:=true;
except
end;

with dm.ADOQuery1 do
 begin
  close;
  sql.Text:=
  'SELECT data0494.PARAMETER_VALUE'+#13+
  'FROM Data0494 inner join data0278'+#13+
  'on data0494.PARAMETER_PTR=data0278.rkey'+#13+
  'where data0278.SPEC_RKEY=''MW'''+#13+
  'and data0494.custpart_ptr='+inttostr(rkey25);
  open;                     //����Ĥ��С�߿�
 end;
if (not dm.ADOQuery1.IsEmpty) and
  (dm.ADOQuery1.FieldByName('PARAMETER_VALUE').AsString<>'') then
try
if strtofloat(dm.ADOQuery1.FieldByName('PARAMETER_VALUE').AsString)<=0.1 then
 result:=true;
except
end;

with dm.ADOQuery1 do
 begin
  close;
  sql.Text:=
  'SELECT data0494.PARAMETER_VALUE'+#13+
  'FROM Data0494 inner join data0278'+#13+
  'on data0494.PARAMETER_PTR=data0278.rkey'+#13+
  'where data0278.SPEC_RKEY=''ML'''+#13+
  'and data0494.custpart_ptr='+inttostr(rkey25);
  open;                    //����Ĥ��С��϶
 end;
if (not dm.ADOQuery1.IsEmpty) and
  (dm.ADOQuery1.FieldByName('PARAMETER_VALUE').AsString<>'') then
try
if strtofloat(dm.ADOQuery1.FieldByName('PARAMETER_VALUE').AsString)<=0.075 then
 result:=true;
except
end;

with dm.ADOQuery1 do
 begin
  close;
  sql.Text:=
  'SELECT data0494.PARAMETER_VALUE'+#13+
  'FROM Data0494 inner join data0278'+#13+
  'on data0494.PARAMETER_PTR=data0278.rkey'+#13+
  'where data0278.SPEC_RKEY=''AP'''+#13+
  'and data0494.custpart_ptr='+inttostr(rkey25);
  open;                    //��С�׾�
 end;
if (not dm.ADOQuery1.IsEmpty) and
  (dm.ADOQuery1.FieldByName('PARAMETER_VALUE').AsString<>'') then
try
if strtofloat(dm.ADOQuery1.FieldByName('PARAMETER_VALUE').AsString)<=0.25 then
 result:=true;
except
end;

end;  }

procedure TForm2.BitBtn1Click(Sender: TObject);
var
 infor,pnla_size,pnla_width,pnla_infor:string;
 i: Integer;
  NodeName: string;
  node: TTreeNode;
begin
  try
            SaveData();
//            for i := 1 to TreeView1.Items.Count-1 do
//            begin
//              NodeName := TreeView1.Items.Item[I].Text;
//              with DM.AQtmp do
//              begin
//                Close;
//                SQL.Clear;
//                SQL.Text := 'select BOM_STEP from data0025 where MANU_PART_NUMBER=' + QuotedStr(NodeName);
//                Open;
//                if (FieldByName('BOM_STEP').AsInteger <= 0)  then
//                begin
//                  if messagedlg('�ڵ㣺 ' + NodeName + '�� ѹ�ϲ���Ϊ0������, �Ƿ��Զ���ת������ڵ�?', mtconfirmation, [mbyes,mbno], 0) = mryes then
//                  begin
//                    TreeView1.Selected := TreeView1.Items[i];
//                    listbox1.Selected[0] := True;
//                    listbox1.OnClick(ListBox1.Items.Objects[0]);
//                    notebook1.PageIndex := listbox1.ItemIndex+1;
//                    DBEdit32.SetFocus;
//                    Exit;
//                  end;
//                end;
//              end;
//            end;

            for i := 1 to TreeView1.Items.Count-1 do
            begin
              NodeName := TreeView1.Items.Item[I].Text;
              with DM.AQtmp do
              begin
                Close;
                SQL.Clear;
                SQL.Text := 'select BOM_STEP from data0025 where MANU_PART_NUMBER=' + QuotedStr(NodeName);
                Open;
                if (FieldByName('BOM_STEP').AsInteger = 1)  then
                begin
                  if messagedlg('�ڵ㣺 ' + NodeName + '�� ѹ�ϲ���Ϊ1, �Ƿ����?', mtconfirmation, [mbyes,mbno], 0) = mryes then
                  begin
                    SaveData();
                    Break;
                  end
                  else
                  begin
                    TreeView1.Selected := TreeView1.Items[i];
                    listbox1.Selected[0] := True;
                    listbox1.OnClick(ListBox1.Items.Objects[0]);
                    notebook1.PageIndex := listbox1.ItemIndex+1;
                    DBEdit32.SetFocus;
                    self.ModalResult:=mrok;
                    Break;
                  end;
                end;
              end;
            end;

      except
       on E: Exception do
        begin
         dm.ADOConnection1.RollbackTrans;
         messagedlg(E.Message,mterror,[mbcancel],0);
        end;
      end;

end;

procedure TForm2.DBEdit19KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if (chr(key)='D') and (ssCtrl in shift) then
 dm.AQY0025spell_lngth.Value:=dm.AQY0025set_lngth.Value;
 if key=13 then dbedit20.SetFocus; 
end;

procedure TForm2.DBEdit20KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if (chr(key)='D') and (ssCtrl in shift) then
 dm.AQY0025spell_width.Value:=dm.AQY0025set_width.Value;
 if key=13 then dbedit22.SetFocus; 
end;

procedure TForm2.DBEdit22KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if (chr(key)='D') and (ssCtrl in shift) then
 dm.AQY0025spell_qty.Value:=dm.AQY0025set_qty.Value;
end;

procedure TForm2.DBEdit17KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if (chr(key)='D') and (ssCtrl in shift) then
 dm.AQY0025set_lngth.Value:=dm.AQY0025pcs_lngth.Value;
 if key=13 then dbedit18.SetFocus;
end;

procedure TForm2.DBEdit18KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if (chr(key)='D') and (ssCtrl in shift) then
 dm.AQY0025set_width.Value:=dm.AQY0025pcs_width.Value;
 if key=13 then dbedit21.SetFocus;
end;

procedure TForm2.DBEdit15KeyPress(Sender: TObject; var Key: Char);
begin
if (key = chr(46)) then  //�����С����
if pos('.',(sender as TDBEdit).Text)>0 then  //С���㲻���ظ�
  abort;
end;

procedure TForm2.DBEdit21KeyPress(Sender: TObject; var Key: Char);
begin
if (key = chr(46)) then  //�����С����
  abort;
end;

procedure TForm2.DBEdit21KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
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
 form_route.Label3.Caption:= treeview1.Items[0].Text;
 form_route.route_ptr.Caption:=inttostr(dm.AQY0025ENG_ROUTE_PTR.value);
 form_route.label4.Caption:=self.rev;
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
 if dm.ads279datatype.Value='����' then
 if not (key in ['0'..'9','.',#8,#13]) then  //�ж��Ƿ���������
  abort;
end;

procedure TForm2.SpeedButton1Click(Sender: TObject);
begin
if treeview1.Selected.Level=0 then       //�����Ʒʱ���
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
end;

if find_spec_rkey('L') then //���������
 begin
  dm.ads279.Edit;
  dm.ads279PARAMETER_VALUE.Value:=formatfloat('0.00000000',dm.AQY0025unit_sq.Value);
  dm.ads279.Post;
  dm.ads279.First;
 end;

if find_spec_rkey('LY') then //����
 begin
  dm.ads279.Edit;
  dm.ads279PARAMETER_VALUE.Value:=dm.AQY0025LAYERS.AsString;
  dm.ads279.Post;
  dm.ads279.First;
 end;

if find_spec_rkey('SU') then //������λ
 begin
  dm.ads279.Edit;
  dm.ads279PARAMETER_VALUE.Value:=dm.AQY0025SO_UNIT.AsString;
  dm.ads279.Post;
  dm.ads279.First;
 end;

if find_spec_rkey('DZ') then //��Ԫ�ߴ�
 begin
  dm.ads279.Edit;
  dm.ads279PARAMETER_VALUE.Value:=dm.AQY0025pcs_lngth.AsString
                                       +'mm X '+dm.AQY0025pcs_width.AsString+'mm';
  dm.ads279.Post;
  dm.ads279.First;
 end;

if find_spec_rkey('JN') then //������Ԫ��
 begin
  dm.ads279.Edit;
  dm.ads279PARAMETER_VALUE.Value:=dm.AQY0025set_qty.AsString;
  dm.ads279.Post;
  dm.ads279.First;
 end;

if find_spec_rkey('U') then //���Ϲ��
 begin
  dm.ads279.Edit;
  dm.ads279PARAMETER_VALUE.Value:=dm.AQY0025ANALYSIS_CODE_3.Value;
  dm.ads279.Post;
  dm.ads279.First;
 end;

  if dm.ads502TOTAL_PNLS_1.Value>0 then
  begin
   if find_spec_rkey('P') then //������PCS
   begin
    dm.ads279.Edit;
    dm.ads279PARAMETER_VALUE.Value:=inttostr(
                       (dm.ads502TOTAL_PNLS_1.Value*dm.ads502UPANEL.Value+
                       dm.ads502TOTAL_PNLS_2.Value*dm.ads502UPANEL_2.Value)*
                       dm.ads502UNIT_NUM.Value); //ÿ�Ŵ���ʵ�ʿ�PCS��
    dm.ads279.Post;
    dm.ads279.First;
   end;

   if find_spec_rkey('5') then //����������%
   begin
    dm.ads279.Edit;
    dm.ads279PARAMETER_VALUE.Value:=FormatFloat('0.00',dm.ads502TUSAGE.Value);
    dm.ads279.Post;
    dm.ads279.First;
   end;
  end;

  if find_spec_rkey('1') then //PNLAƴ����
   begin
    dm.ads279.Edit;
    dm.ads279PARAMETER_VALUE.Value:=dm.ads502TOTAL_PNLS_1.AsString;
    dm.ads279.Post;
    dm.ads279.First;
   end;

  if find_spec_rkey('3') then //pnla��Ԫ�� (PCS����)
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
            DM.ads502PNL_LEN.AsString;       //PNLA����
    dm.ads279.Post;
    dm.ads279.First;
   end;

  if find_spec_rkey('7') then
   begin
    dm.ads279.Edit;
    dm.ads279PARAMETER_VALUE.Value:=
            DM.ads502PNL_WTH.AsString;       //PNLA��
    dm.ads279.Post;
    dm.ads279.First;
   end;

  if find_spec_rkey('H') then//PNLA�ߴ��ַ�
   begin
    dm.ads279.Edit;
    dm.ads279PARAMETER_VALUE.Value:= DM.ads502PNL_LEN.AsString+
     'mm X '+DM.ads502PNL_WTH.AsString+'mm';
    dm.ads279.Post;
    dm.ads279.First;
   end;

  if find_spec_rkey('2') then //PNLB ƴ����
   begin
    dm.ads279.Edit;
    if dm.ads502TOTAL_PNLS_2.Value > 0 then
     dm.ads279PARAMETER_VALUE.Value:=dm.ads502TOTAL_PNLS_2.AsString
    else
     dm.ads279PARAMETER_VALUE.Value:='';
    dm.ads279.Post;
    dm.ads279.First;
   end;

   if find_spec_rkey('4') then //PNLB ��Ԫ��
   begin
    dm.ads279.Edit;
    if dm.ads502UPANEL_2.Value > 0 then
     dm.ads279PARAMETER_VALUE.Value:=inttostr(dm.ads502UPANEL_2.Value*
                                     dm.ads502UNIT_NUM.Value)
    else
     dm.ads279PARAMETER_VALUE.Value:='';
    dm.ads279.Post;
    dm.ads279.First;
   end;

   if find_spec_rkey('8') then
   begin
    dm.ads279.Edit;
    if DM.ads502PNL_LEN_2.Value > 0 then
     dm.ads279PARAMETER_VALUE.Value:=DM.ads502PNL_LEN_2.AsString   //PNLB ����
    else
     dm.ads279PARAMETER_VALUE.Value:='';
    dm.ads279.Post;
    dm.ads279.First;
   end;

   if find_spec_rkey('9') then
   begin
    dm.ads279.Edit;
    if DM.ads502PNL_WTH_2.Value > 0 then
     dm.ads279PARAMETER_VALUE.Value:=DM.ads502PNL_WTH_2.AsString   //PNLB ��
    else
     dm.ads279PARAMETER_VALUE.Value:='';
    dm.ads279.Post;
    dm.ads279.First;
   end;

   if find_spec_rkey('I') then//PNLB �ߴ��ַ�
   begin
    dm.ads279.Edit;
    if DM.ads502PNL_LEN_2.Value > 0 then
    dm.ads279PARAMETER_VALUE.Value:= DM.ads502PNL_LEN_2.AsString+
      'mm X '+DM.ads502PNL_WTH_2.AsString+'mm'
    else
     dm.ads279PARAMETER_VALUE.Value:='';
    dm.ads279.Post;
    dm.ads279.First;
   end;
end;

procedure TForm2.N3Click(Sender: TObject);  //�༭����
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

procedure TForm2.N2Click(Sender: TObject);   //���빤��
var
 step_number:word;
 _rev:string;
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
     dm.ADS38.IndexFieldNames := '';
     dm.ADS38.Filter:='step_number >= '+inttostr(step_number);
     dm.ADS38.DisableControls;
     while not dm.ADS38.Eof do
     begin
      dm.ADS38.Edit;
      dm.ADS38STEP_NUMBER.Value:=dm.ADS38STEP_NUMBER.Value+1;
      dm.ADS38.Post;
      dm.ADS38.Next;
     end;
     dm.ADS38.IndexFieldNames:='step_number';
     dm.ADS38.Filter:='';
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
     if form_deptcode.ADOQuery1ppc_status.Value=0 then
      _rev:=''
     else
      _rev:=self.rev;
   dm.ADS38.InsertRecord([dm.AQY0025RKEY.Value,
                          form_deptcode.ADOQuery1rkey.Value,
                          form_deptcode.ADOQuery1DEF_ROUT_INST.Value,
                          step_number,
                          _rev,
                          1]);
      dm.ADOQuery1.Close;   //=====���ܸı�adoquery1�����
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
                 cacl_flowpara(dm.ADOQuery1.Fieldbyname('TValue').AsString,
                               trim(dm.ADOQuery1.Fieldbyname('formula').AsString)),
                               dm.ADS38SOURCE_PTR.Value,
                               dm.ADS38STEP_NUMBER.Value,
                               dm.ADOQuery1.FieldValues['SEQ_NO'],
                               dm.ADOQuery1.FieldValues['Doc_Flag'],
                               dm.ADOQuery1.FieldValues['after_flag'],
                               dm.ADOQuery1.FieldValues['flow_spfc_flag']]);
       dm.ADOQuery1.Next;
      end;          //=======���ܸı�adoquery1�����
   if not bitbtn11.Enabled then bitbtn11.Enabled:=true;
  end;
finally
 form_deptcode.Free;
end;
end;

procedure TForm2.update_quanju;
var
  A_H,B_I:string;
  a_pnl,b_pnl,a_pcs,b_pcs:integer;
begin
 if find_spec_rkey('5') then //����������%
   begin
    if Trim(dm.ads279PARAMETER_VALUE.Value)<> '' then
    DM.AQY0025TUSAGE.AsString:=dm.ads279PARAMETER_VALUE.Value;
    dm.ads279.First;
   end;

if find_spec_rkey('JN') then //������Ԫ��
 begin
  dm.ads279.Edit;
  dm.ads279PARAMETER_VALUE.Value:=dm.AQY0025set_qty.AsString;
  dm.ads279.Post;
  dm.ads279.First;
 end;

if find_spec_rkey('L') then //���������
 begin
  dm.ads279.Edit;
  dm.ads279PARAMETER_VALUE.Value:=formatfloat('0.00000000',dm.AQY0025unit_sq.Value);
  dm.ads279.Post;
  dm.ads279.First;
 end;
  
if (find_spec_rkey('DL')) then //������
 begin
  dm.ads494.Filter:='';
  while not dm.ads494.Eof do
  begin
   if dm.ads494SPEC_RKEY.Value='DR' then
    begin
     dm.ads279.Edit;
     dm.ads279PARAMETER_VALUE.Value:=DM.ads494PARAMETER_VALUE.Value;
     dm.ads279.Post;
     dm.ads279.First;
     break;
    end;
   dm.ads494.Next;
  end;
 end;

  if find_spec_rkey('6') then
   begin
     if Trim(dm.ads279PARAMETER_VALUE.Value)<>'' then
     A_H:=dm.ads279PARAMETER_VALUE.Value+'mm';
     dm.ads279.First;
   end;

  if find_spec_rkey('7') then
   begin
     if Trim(dm.ads279PARAMETER_VALUE.Value)<>'' then
     A_H:=A_H+' X '+dm.ads279PARAMETER_VALUE.Value+'mm';
    dm.ads279.First;
   end;

  if find_spec_rkey('H') then//PNLA�ߴ��ַ�
   begin
     if A_H<>'' then
     begin
      dm.ads279.Edit;
      dm.ads279PARAMETER_VALUE.Value:=A_H;
      dm.ads279.Post;
      dm.ads279.First;
     end;
   end;

  if find_spec_rkey('8') then
   begin
     if Trim(dm.ads279PARAMETER_VALUE.Value)<>'' then
     B_I:=dm.ads279PARAMETER_VALUE.Value+'mm';
     dm.ads279.First;
   end;

  if find_spec_rkey('9') then
   begin
     if Trim(dm.ads279PARAMETER_VALUE.Value)<>'' then
     B_I:=B_I+' X '+dm.ads279PARAMETER_VALUE.Value+'mm';
    dm.ads279.First;
   end;

  if find_spec_rkey('I') then//PNLB�ߴ��ַ�
   begin
     if B_I<>'' then
     begin
      dm.ads279.Edit;
      dm.ads279PARAMETER_VALUE.Value:=B_I;
      dm.ads279.Post;
      dm.ads279.First;
     end;
   end;

  if find_spec_rkey('1') then
   if Trim(dm.ads279PARAMETER_VALUE.Value)<>'' then
    try
     a_pnl:=dm.ads279PARAMETER_VALUE.AsInteger;
    except
     a_pnl:=0;
    end
   else
    a_pnl:=0
  else
   a_pnl:=0;

  if find_spec_rkey('2') then
   if Trim(dm.ads279PARAMETER_VALUE.Value)<>'' then
    try
     b_pnl:=dm.ads279PARAMETER_VALUE.AsInteger;
    except
     b_pnl:=0;
    end
   else
    b_pnl:=0
  else
   b_pnl:=0;

  if find_spec_rkey('3') then
   if Trim(dm.ads279PARAMETER_VALUE.Value)<>'' then
    try
     a_pcs:=dm.ads279PARAMETER_VALUE.AsInteger;
    except
     a_pcs:=0;
    end
   else
    a_pcs:=0
  else
   a_pcs:=0;

  if find_spec_rkey('4') then
   if Trim(dm.ads279PARAMETER_VALUE.Value)<>'' then
    try
     b_pcs:=dm.ads279PARAMETER_VALUE.AsInteger;
    except
     b_pcs:=0;
    end
   else
    b_pcs:=0
  else
   b_pcs:=0;

  if find_spec_rkey('P') then     //����PCS����
   begin
    dm.ads279.Edit;
    dm.ads279PARAMETER_VALUE.Value:=IntToStr(a_pnl*a_pcs+b_pnl*b_pcs);
    dm.ads279.Post;
    dm.ads279.First;
   end;

   
end;

procedure TForm2.BitBtn11Click(Sender: TObject);
var
  i: Integer;
  NodeName: string;
  node: TTreeNode;
begin

  SaveData();
//   for i := 1 to TreeView1.Items.Count-1 do      //2017-2-7ע�ͣ����������Ҫ�����ڲ㣬��û��ѹ�ϲ���
//  begin
//    NodeName := TreeView1.Items.Item[I].Text;
//    with DM.AQtmp do
//    begin
//      Close;
//      SQL.Clear;
//      SQL.Text := 'select BOM_STEP from data0025 where MANU_PART_NUMBER=' + QuotedStr(NodeName);
//      Open;
//      if (FieldByName('BOM_STEP').AsInteger <= 0)  then
//      begin
//        if messagedlg('�ڵ㣺 ' + NodeName + '�� ѹ�ϲ���Ϊ0������, �Ƿ��Զ���ת������ڵ�?', mtconfirmation, [mbyes,mbno], 0) = mryes then
//        begin
//          TreeView1.Selected := TreeView1.Items[i];
//          listbox1.Selected[0] := True;
//          listbox1.OnClick(ListBox1.Items.Objects[0]);
//          notebook1.PageIndex := listbox1.ItemIndex+1;
//          DBEdit32.SetFocus;
//          Exit;
//        end;
//      end;
//    end;
//  end;

  for i := 1 to TreeView1.Items.Count-1 do
  begin
    NodeName := TreeView1.Items.Item[I].Text;
    with DM.AQtmp do
    begin
      Close;
      SQL.Clear;
      SQL.Text := 'select BOM_STEP from data0025 where MANU_PART_NUMBER=' + QuotedStr(NodeName);
      Open;
      if (FieldByName('BOM_STEP').AsInteger = 1)  then
      begin
        if messagedlg('�ڵ㣺 ' + NodeName + '�� ѹ�ϲ���Ϊ1, �Ƿ����?', mtconfirmation, [mbyes,mbno], 0) = mryes then
        begin
          SaveData();
          Break;
        end
        else
        begin
          TreeView1.Selected := TreeView1.Items[i];
          listbox1.Selected[0] := True;
          listbox1.OnClick(ListBox1.Items.Objects[0]);
          notebook1.PageIndex := listbox1.ItemIndex+1;
          DBEdit32.SetFocus;
          Break;
        end;
      end;
    end;
  end;
end;

procedure TForm2.N1Click(Sender: TObject);
var
 _rev:string;
begin
try
 form_deptcode:=tform_deptcode.Create(application);
 if form_deptcode.ShowModal=mrok then
  begin
   if form_deptcode.ADOQuery1ppc_status.Value=0 then
    _rev:=''
   else
    _rev:=self.rev;
   dm.ADS38.AppendRecord([dm.AQY0025RKEY.Value,
                          form_deptcode.ADOQuery1rkey.Value,
                          form_deptcode.ADOQuery1DEF_ROUT_INST.Value,
                          dm.ADS38.RecordCount+1,
                          _rev,
                          1]);
      dm.ADOQuery1.Close;   //=���ܸı�adoquery1�����
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
                 cacl_flowpara(dm.ADOQuery1.Fieldbyname('TValue').AsString,
                               trim(dm.ADOQuery1.Fieldbyname('formula').AsString)),
                               dm.ADS38SOURCE_PTR.Value,
                               dm.ADS38STEP_NUMBER.Value,
                               dm.ADOQuery1.FieldValues['SEQ_NO'],
                               dm.ADOQuery1.FieldValues['Doc_Flag'],
                               dm.ADOQuery1.FieldValues['after_flag'],
                               dm.ADOQuery1.FieldValues['flow_spfc_flag']]);
       dm.ADOQuery1.Next;
      end;                  //=======���ܸı�adoquery1�����
    if not bitbtn11.Enabled then bitbtn11.Enabled:=true;
  end;
finally
 form_deptcode.Free;
end;

end;

procedure TForm2.N4Click(Sender: TObject);//ɾ������
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
  if not bitbtn11.Enabled then bitbtn11.Enabled:=true;
end;

procedure TForm2.PopupMenu1Popup(Sender: TObject);
begin
if dm.ADS38.IsEmpty then
 begin
  n3.Enabled:=false;
  n4.Enabled:=false;
  n27.Enabled:=false;
  n28.Enabled:=false;
  n29.Enabled:=false;
 end
else
 begin
  n3.Enabled:=true;
  n4.Enabled:=true;
  n29.Enabled:=true;
  if dm.ADS38STEP_NUMBER.Value=1 then
   n27.Enabled:=false
  else
   n27.Enabled:=true;
  if dm.ADS38STEP_NUMBER.Value=dm.ADS38.RecordCount then
   n28.Enabled:=false
  else
   n28.Enabled:=true;
 end;
end;

procedure TForm2.SpeedButton3Click(Sender: TObject);
begin
try
 application.CreateForm(tForm_layer,Form_layer);
 Form_layer.ads93.Close;
 Form_layer.ads93.CommandText:=
   'select  RECORD_KEY,CODE, DESCRIPTION,layers_info'+#13+
   'from data0193'+#13+
   'where SPEC_RKEY <>''Y''';
 Form_layer.ads93.Open;
 if Form_layer.ads93.IsEmpty then
  messagedlg('û�н�����׼��ѹ�ṹ!',mtinformation,[mbcancel],0)
 else
 if Form_layer.ShowModal=mrok then
 begin
  if checkbox1.Checked then  dm.AQY0025layers_info.Value:='';
  dbmemo1.Lines.Add(Form_layer.ads93layers_info.Value);
  if not bitbtn11.Enabled then bitbtn11.Enabled:=true;  
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
   'select  RECORD_KEY,CODE, DESCRIPTION,layers_info'+#13+
   'from data0193'+#13+
   'where SPEC_RKEY =''Y''';
 Form_layer.ads93.Open;
 if Form_layer.ads93.IsEmpty then
  messagedlg('û�н���������Ƭ�ṹ!',mtinformation,[mbcancel],0)
 else
 if Form_layer.ShowModal=mrok then
 begin
  dbmemo1.Lines.Insert(dbmemo1.CaretPos.y,Form_layer.ads93layers_info.Value);
  if not bitbtn11.Enabled then bitbtn11.Enabled:=true;  
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
var column,row:integer;
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
var i:word;
begin
 for i:=stringgrid1.Row to stringgrid1.RowCount-2 do
  begin
   stringgrid1.Rows[i].Text:=stringgrid1.Rows[i+1].Text;
   stringgrid1.Cells[0,i]:=inttostr(i);
  end;
  stringgrid1.RowCount:=stringgrid1.RowCount-1;
if not bitbtn11.Enabled then bitbtn11.Enabled:=true; 
end;

procedure TForm2.PopupMenu3Popup(Sender: TObject);
begin
 if stringgrid1.Row=stringgrid1.RowCount-1 then
  begin
   n6.Enabled:=false;
   n7.Enabled:=false;
   n16.Enabled:=false;
   n110.Enabled:=false;
   n111.Enabled:=false;
  end
 else
  begin
   n6.Enabled:=true;
   n7.Enabled:=true;
   n16.Enabled:=true;
   n110.Enabled:=true;
   n111.Enabled:=true;
  end;
 if stringgrid1.Row=1 then
  n15.Enabled:=false
 else
  n15.Enabled:=true;
 n18.Enabled:=stringgrid1.RowCount>2;  
end;

procedure TForm2.N6Click(Sender: TObject);
var i:word;
begin
 for i:=stringgrid1.RowCount-2 downto stringgrid1.Row do
  begin
   stringgrid1.Rows[i+1].Text:=stringgrid1.Rows[i].Text;
   stringgrid1.Cells[0,i+1]:=inttostr(i+1);
  end;
  stringgrid1.Rows[stringgrid1.Row].Text:='';
  stringgrid1.Cells[0,stringgrid1.Row]:= inttostr(stringgrid1.Row);
  stringgrid1.RowCount:=stringgrid1.RowCount+1;
if not bitbtn11.Enabled then bitbtn11.Enabled:=true;  
end;

procedure TForm2.StringGrid1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if (stringgrid1.Row=stringgrid1.RowCount-1) and
   (trim(stringgrid1.Rows[stringgrid1.Row].Text)<>'') then
 begin
  stringgrid1.Cells[0,stringgrid1.Row]:=inttostr(stringgrid1.Row);
  stringgrid1.Cells[1,stringgrid1.Row]:='T'+get_drTrow(stringgrid1.Row);
  stringgrid1.RowCount:=stringgrid1.RowCount+1;
  if not bitbtn11.Enabled then bitbtn11.Enabled:=true;
 end;
end;

procedure TForm2.StringGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   IF (KEY=13) and (Stringgrid1.row<stringgrid1.RowCount-1) then
   Stringgrid1.row:=Stringgrid1.row+1;
 if (chr(key)='D') and (ssCtrl in shift) and (stringgrid1.Row>1) then
  begin
   stringgrid1.Cells[stringgrid1.col,stringgrid1.row]:=
   stringgrid1.Cells[stringgrid1.col,stringgrid1.row-1];
  end;

if (chr(key)='R') and (ssCtrl in shift) and (bitbtn7.Enabled) then
 n11click(sender);
if (chr(key)='A') and (ssCtrl in shift) and (bitbtn7.Enabled) then
 n12click(sender);
if (chr(key)='T') and (ssCtrl in shift) and (bitbtn8.Enabled) then
 n13click(sender);
if (chr(key)='X') and (ssCtrl in shift) and (bitbtn8.Enabled) then
 n14click(sender);
end;

procedure TForm2.StringGrid1SelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
if (stringgrid1.Col=6)  then
 try //���ٱ�����λС��

 if length(stringgrid1.Cells[stringgrid1.Col,stringgrid1.Row])-
    pos('.',stringgrid1.Cells[stringgrid1.Col,stringgrid1.Row])<=2 then

  stringgrid1.Cells[stringgrid1.Col,stringgrid1.Row]:=
   formatfloat('0.00',
   strtofloat(stringgrid1.Cells[stringgrid1.Col,stringgrid1.Row]));

 except
 end;

if stringgrid1.Col=4 then
 stringgrid1.Cells[stringgrid1.Col,stringgrid1.Row]:=
  uppercase(stringgrid1.Cells[stringgrid1.Col,stringgrid1.Row]);

if (stringgrid1.Col=6) then
 edit6.Text:=formatfloat('0.00',(get_mindrill()));
end;

procedure TForm2.StringGrid1Exit(Sender: TObject);
begin
if (stringgrid1.Col=6)  then
 try //���ٱ�����λС��

 if length(stringgrid1.Cells[stringgrid1.Col,stringgrid1.Row])-
    pos('.',stringgrid1.Cells[stringgrid1.Col,stringgrid1.Row])<=2 then

  stringgrid1.Cells[stringgrid1.Col,stringgrid1.Row]:=
   formatfloat('0.00',
   strtofloat(stringgrid1.Cells[stringgrid1.Col,stringgrid1.Row]));

 except
 end;

if stringgrid1.Col=4 then
 stringgrid1.Cells[stringgrid1.Col,stringgrid1.Row]:=
  uppercase(stringgrid1.Cells[stringgrid1.Col,stringgrid1.Row]);

if (stringgrid1.Col=6) then
 edit6.Text:=formatfloat('0.00',(get_mindrill()));
end;

function TForm2.dr_jishuan(dr:single): single;
begin
 result:=round(dr*20)/20;
end;

procedure TForm2.BitBtn6Click(Sender: TObject);
var
 i:word;
 err:boolean;
begin
 err:=false;
 for i:= 1 to stringgrid1.RowCount-2 do
 try
  if (trim(stringgrid1.Cells[4,i])='Y') and
     (roundto(strtofloat(stringgrid1.Cells[6,i]),-2)<>
      roundto(dr_jishuan(strtofloat(stringgrid1.Cells[3,i]))+strtofloat(edit7.Text),-2)) then
   begin
    messagedlg('��'+inttostr(i)+'�����:'+stringgrid1.Cells[3,i]+'������ͭ��ƫ��'
    ,mtinformation,[mbcancel],0);
    err:=true;
   end
  else
   if (trim(stringgrid1.Cells[4,i])='N') and
     (roundto(strtofloat(stringgrid1.Cells[6,i]),-2)<>
      roundto(dr_jishuan(strtofloat(stringgrid1.Cells[3,i]))+strtofloat(edit8.Text),-2)) then
    begin
     messagedlg('��'+inttostr(i)+'�����:'+stringgrid1.Cells[3,i]+'�����ǳ�ͭ��ƫ��'
     ,mtinformation,[mbcancel],0);
     err:=true;
    end;
 except

 end;
 
if not err then
  common.ShowMsg('��׼��ͨ��!',1);
end;

procedure TForm2.BitBtn7Click(Sender: TObject);

begin
 PopupMenu6.Popup(mouse.CursorPos.X,mouse.CursorPos.Y);
end;

procedure TForm2.DBEdit15Exit(Sender: TObject);
begin
if dm.AQY0025.State=dsedit then
 begin
  dm.AQY0025pcs_sq.Value:=dm.AQY0025pcs_lngth.Value*
                         dm.AQY0025pcs_width.Value*0.000001;
  if dm.AQY0025SO_UNIT.Value='PCS' THEN
   begin
    dm.AQY0025set_lngth.Value:=dm.AQY0025pcs_lngth.Value;
    dm.AQY0025set_width.Value:=dm.AQY0025pcs_width.Value;
    dm.AQY0025unit_sq.Value:=dm.AQY0025pcs_sq.Value;
   end;
 end;
end;


procedure TForm2.TreeView1Change(Sender: TObject; Node: TTreeNode);
begin
       rkey25.Caption:=inttostr(Pinteger(Node.data)^);
       notebook1.PageIndex:=0;
       node.SelectedIndex:=4;
       bitbtn14.Enabled:=false;
       if node.Level =0 then
       begin
        listbox1.Items.Text:=
        '��Ʒ��Ϣ'+#13+
        'ƴ�����'+#13+
        'ȫ�ֲ���'+#13+
        '��������'+#13+
        '��ѹ�ṹ'+#13+
        '��ױ�'+#13+
        '��ע��Ϣ'+#13+
        'ѹ�ϰоر�'#13+
        '���̸���'+#13+
        '������Ϣ'+#13+
        '�ͻ���Ϣ'+#13+
        'ECN������'+#13+
        '�迹��'+#13+
        '���̵���';
        btnTB.Visible := True;
       end
       else
       begin
        listbox1.Items.Text:=
        '��Ʒ��Ϣ'+#13+
        'ƴ�����'+#13+
        'ȫ�ֲ���'+#13+
        '��������'+#13+
        '��ѹ�ṹ'+#13+
        '��ױ�'+#13+
        '��ע��Ϣ'+#13+
        'ѹ�ϰоر�';
        btnTB.Visible := False;
       end;   
end;

procedure TForm2.PopupMenu4Popup(Sender: TObject);
var node:TTreeNode;
begin
 node:=treeview1.Selected;
 if node.Level=3 then
  begin
   n8.Enabled:=false;
   n44.Enabled:=False;
   n9.Enabled:=true;
  end
 else
  begin
   n8.Enabled:=true;
   n44.Enabled:=true;
   if node.Level=0 then
    n9.Enabled:=false
   else
    n9.Enabled:=true;
  end;
end;

procedure TForm2.N8Click(Sender: TObject);  //�½��ڲ�
var
 node:ttreenode;   //treeview�ؼ��Ľڵ����
 rkey0025:^integer;
begin
if bitbtn11.Enabled then
 if messagedlg('�½���·��,�Ƿ��Զ���������?',mtconfirmation,[mbyes,mbno],0)=mryes then
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
  (node,dm.AQY0025MANU_PART_NUMBER.Value,rkey0025); //���Ӷ���ڵ�
  node.ImageIndex:=node.Level;  //Ϊ��һ��ڵ㶨��ͼ��
  node.SelectedIndex := node.Level;//Ϊ��һ��ڵ㶨��ѡ��֮���ͼ��
  treeview1.Selected:=node;   //��ת�����TreeView1Change

  self.update_notebook;
  if bitbtn11.Enabled then bitbtn11.Enabled:=false;
  if bitbtn1.Enabled then bitbtn1.Enabled:=false;
  if bitbtn14.Enabled then bitbtn14.Enabled:=false;
  if bitbtn15.Enabled then bitbtn15.Enabled:=false;

  DBEdit32.Text:='';
 end;
finally
form_append.Free;
end;

end;

procedure TForm2.N9Click(Sender: TObject); //ɾ���ڲ�
var
 node:ttreenode;   //treeview�ؼ��Ľڵ����
 rkey:integer;
begin
if dm.AQY0025RKEY.Value <> strtoint(rkey25.Caption) then
 begin
  if bitbtn11.Enabled then
  if messagedlg('ɾ����·��,�Ƿ��Զ���������?',mtconfirmation,[mbyes,mbno],0)=mryes then
   bitbtn11click(sender);
 end;

if messagedlg('ɾ�����ǲ��������!��ȷ��Ҫɾ���ڲ���?',mtconfirmation,[mbyes,mbno],0)=mryes then
begin
 node:=treeview1.Selected;
 if not node.HasChildren then
 begin
  dm.ADOConnection1.BeginTrans;
  try
  dm.AQY0025.Close;
  dm.AQY0025.Parameters[0].Value:=rkey25.Caption;
  dm.AQY0025.Open;
  rkey:=dm.AQY0025PARENT_PTR.Value;
  dm.AQY0025.Delete;

  with dm.ADOQuery1 do
   begin
    close;
    sql.Text:='update  data0025 '+
             'set PARTS_NUM = isnull(PARTS_NUM,0)-1 '+
             'where rkey='+inttostr(rkey);
    ExecSQL;
   end;
   dm.ads502.Close;
   dm.ads279.Close;
   dm.ADS38.Close;
   dm.ads494.Close;
   dm.ads497.Close;
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
  messagedlg('�޷�ɾ����������ڲ�Ĳ�Ʒ!',mterror,[mbcancel],0);
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
   if dm.AQY0025PARENT_PTR.Value<=0 then
   if dm.AQY0025ttype.Value=0 then
    begin
     dm.AQY0025EST_SCRAP.Value:=Form_prodcode.adoquery1EST_SCRAP.Value;
     self.est_scrap:=Form_prodcode.adoquery1est_scrap_ltm.value;
    end
   else
    begin
     dm.AQY0025EST_SCRAP.Value:=Form_prodcode.adoquery1EST_SCRAP1.Value;
     self.est_scrap:=Form_prodcode.adoquery1est_scrap1_lmt.Value;
    end;
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
   bitbtn3.Enabled:=false;

   dbmemo1.ReadOnly:=true;
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
 messagedlg('�����������ϲ��Ʒ��������',mtinformation,[mbcancel],0)
else
if form_stepnumber.ShowModal=mrok then
begin
 dm.AQY0025BOM_STEP.Value:=form_stepnumber.ADODataSet1STEP_NUMBER.Value;
 label64.Caption:=form_stepnumber.ADODataSet1DEPT_NAME.Value;
end;
form_stepnumber.free;
end;

procedure TForm2.BitBtn14Click(Sender: TObject);
var
 infor,pnla_size,pnla_width,pnla_infor:string;
begin
 if trim(dm.AQY0025MANU_PART_NUMBER.Value)='' then
 begin
  listbox1.ItemIndex:=0;
  notebook1.PageIndex:=listbox1.ItemIndex+1;
  messagedlg('������Ų�����Ϊ��!',mterror,[mbcancel],0);
  DBEDIT1.SetFocus;
  exit;
 end;
 
 if trim(dm.AQY0025MANU_PART_DESC.Value)='' then
 begin
  listbox1.ItemIndex:=0;
  notebook1.PageIndex:=listbox1.ItemIndex+1;
  messagedlg('�ͻ��ͺŲ�����Ϊ��!',mterror,[mbcancel],0);
  DBEDIT2.SetFocus;
  exit;
 end;

 if dm.AQY0025PARENT_PTR.Value > 0 then  //�ڲ�
 begin
  if dm.AQY0025QTY_BOM.Value <= 0 then
  begin
   listbox1.ItemIndex:=0;
   notebook1.PageIndex:=listbox1.ItemIndex+1;
   messagedlg('ѹ�ϱ�����������!',mterror,[mbcancel],0);
   DBEDIT33.SetFocus;
   exit;
  end;

  if dm.AQY0025QTY_PARENTBOM.Value <= 0 then
  begin
   listbox1.ItemIndex:=0;
   notebook1.PageIndex:=listbox1.ItemIndex+1;
   messagedlg('ѹ�ϱ�����������!',mterror,[mbcancel],0);
   DBEDIT34.SetFocus;
   exit;
  end;

  if (dm.AQY0025BOM_STEP.Value<=0) then
  begin
   listbox1.ItemIndex:=0;
   notebook1.PageIndex:=listbox1.ItemIndex+1;
   messagedlg('ѹ�ϲ�����������!',mterror,[mbcancel],0);
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
       'and Data0038.STEP_NUMBER='+dm.AQY0025BOM_STEP.AsString+#13+
       'and data0034.IS_COST_DEPT=1';
    open;
   end;
   if dm.ADOQuery1.IsEmpty then
   begin
   listbox1.ItemIndex:=0;
   notebook1.PageIndex:=listbox1.ItemIndex+1;
   messagedlg('ѹ�ϲ�����������,��������ϸ����Ʒ��û���ҵ���Ӧ�Ĺ���!',mterror,[mbcancel],0);
   DBEDIT32.SetFocus;
   exit;
   end
  end;
 end;
 {
 else
 if dm.AQY0025EST_SCRAP.Value<=0 then
 begin
  listbox1.ItemIndex:=0;
  notebook1.PageIndex:=listbox1.ItemIndex+1;
  messagedlg('��㱨���ʲ�����Ϊ��!',mterror,[mbcancel],0);
  DBEDIT7.SetFocus;
  exit;
 end;
 }
 if (dm.AQY0025SO_UNIT.Value='��Ҫ��') or
   (trim(dm.AQY0025SO_UNIT.Value)='') then
 begin
  listbox1.ItemIndex:=1;
  notebook1.PageIndex:=listbox1.ItemIndex+1;
  messagedlg('û��ȷ�����ս�����ʽ!',mterror,[mbcancel],0);
  DBcombobox2.SetFocus;
  exit;
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
   messagedlg('ȫ�ֲ���Ϊ������Ϊ�յ���Ҫ����!',mterror,[mbcancel],0);
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
  if (dm.ads494flow_spfc_flag.Value = 'Y') and    //�ص㵫
     (dm.ads494after_flag.Value <> 'Y') and       //���Ǻ󲹲���
     (trim(dm.ads494PARAMETER_VALUE.Value) = '') then
  begin
   listbox1.ItemIndex := 3;
   notebook1.PageIndex := listbox1.ItemIndex+1;
   messagedlg('��'+DM.ads494step_number.AsString+'���Ƴ̲���Ϊ������Ϊ�յ���Ҫ����!',
           mterror,[mbcancel],0);
   dm.ADS38.Locate('step_number',dm.ads494step_number.Value,[]);
   dbgrid2.SetFocus;
   exit;
  end;
  dm.ads494.Next;
 end;
dm.ads494.First;

 infor:='';
 if (dm.AQY0025ttype.Value=0) and (dm.AQY0025PARENT_PTR.Value=0) then  //����,��������������
  if self.find_setpnlmin(infor) then
   infor:='������Ʒ�뱾��Ʒ�����ߴ�ǳ��ӽ�,�������ӹ��̷������:'+#13+infor;

  pnla_size:='';
  pnla_width:='';
  pnla_infor:='';

  if find_spec_rkey('6') then pnla_size:= dm.ads279PARAMETER_VALUE.Value ;  //PNLA�ߴ��ַ�
  if find_spec_rkey('7') then pnla_width:= dm.ads279PARAMETER_VALUE.Value ;  //PNLA�ߴ�(��)

 if (dm.AQY0025PARENT_PTR.Value = 0) and (dm.AQY0025ttype.Value=0) then  //���,����
  if (pnla_size<>'') and (pnla_width<>'') and
      (self.find_nearpnlmin(pnla_infor,pnla_size,pnla_width)) then
     infor:= infor+#13+'������Ʒ�뱾��Ʒ�����ߴ���ͬ������A��ߴ�����3mm,�������ӹ��̷������!'+#13+pnla_infor;


 if Trim(infor)<>'' then
  begin
   clipboard.Clear;
   Clipboard.AsText:=infor;
//   common.ShowMsg('��Ʒƴ��ߴ���ͬ�������,��������������ߴ���ͬ�Ĳ�Ʒ��Ϣ�Ѹ��Ƶ�ճ����,������Ҫ�뼰ʱճ��!',1);
   common.ShowMsg(infor,1);
  end;

 messagedlg('���ݼ��ͨ��!',mtinformation,[mbok],0);
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
begin
 Print_menu.Popup(mouse.CursorPos.X,mouse.CursorPos.Y);
end;

procedure TForm2.SpeedButton6Click(Sender: TObject);
var modalok:boolean;
begin
 form_product:=tform_product.Create(application);
 form_product.adoquery1.Close;
 form_product.adoquery1.Open;
 if form_product.adoquery1.IsEmpty then
  BEGIN
   messagedlg('û���ҵ���Ҫ���ƵĲ�Ʒ',mtinformation,[mbcancel],0);
   EDIT1.SetFocus;
  END
 else
 if form_product.ShowModal=mrok then
 begin
if not dm.ADS38.IsEmpty then
 begin
  if messagedlg('��Ʒ�Ѿ������������ظ������̽��п��ܵ���ԭ���̼��Ƴ���Ϣ��ʧ,��ȷ��?',
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

    while not Eof do //������ǧ����ʹ��adoquery2
     begin
      dm.ADS38.AppendRecord([dm.AQY0025RKEY.Value,
                            fieldvalues['dept_ptr'],
                            fieldvalues['DEF_ROUT_INST'],
                            fieldvalues['STEP_NUMBER'],
                            fieldvalues['tooling_rev'],
                            fieldvalues['OUTP_SPFC'],
                            fieldvalues['tool_old_rev']]);
      Next;
     end;    //=======���ܸı�adoquery2�����
   end;


  dm.ADOQuery1.Close;   //=====���ܸı�adoquery1�����
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
  end;          //=======���ܸı�adoquery1�����

  dm.ADS38.First;
  dm.ads494.First;
 end;

 end;
 form_product.Free;
end;


procedure TForm2.N12Click(Sender: TObject);
var
pnla_pcs,pnlb_pcs,i:integer;
//set_pcs:integer;
begin
 pnla_pcs:=0;
 pnlb_pcs:=0;
// set_pcs:=0;
if find_spec_rkey('3') then //PNLA��Ԫ��
 if trim(dm.ads279PARAMETER_VALUE.Value)<>'' then
  pnla_pcs:=strtoint(dm.ads279PARAMETER_VALUE.Value);

if find_spec_rkey('4') then //PNLB��Ԫ��
 if trim(dm.ads279PARAMETER_VALUE.Value)<>'' then
  pnlb_pcs:=strtoint(dm.ads279PARAMETER_VALUE.Value);
 {
if find_spec_rkey('JN') then //set��Ԫ��
 if trim(dm.ads279PARAMETER_VALUE.Value)<>'' then
  set_pcs := strtoint(dm.ads279PARAMETER_VALUE.Value);
  }
for i:=1 to stringgrid1.RowCount-2 do
 try
  if pnla_pcs>0 then
   Stringgrid1.Cells[9,i]:=
   inttostr(strtoint(trim(Stringgrid1.Cells[7,i]))*pnla_pcs+1);
  if pnlb_pcs>0 then
   Stringgrid1.Cells[10,i]:=
   inttostr(strtoint(trim(Stringgrid1.Cells[7,i]))*pnlb_pcs+1);
  {
  if set_pcs > 0 then
   Stringgrid1.Cells[8,i]:=
   inttostr(strtoint(trim(Stringgrid1.Cells[7,i]))*set_pcs);
  }
  if not bitbtn11.Enabled then bitbtn11.Enabled:=true;
 except

 end;

end;

procedure TForm2.N11Click(Sender: TObject);
var
pnla_pcs,pnlb_pcs:integer;
//set_pcs:integer;
begin
 pnla_pcs:=0;
 pnlb_pcs:=0;
// set_pcs := 0;
if find_spec_rkey('3') then //PNLA��Ԫ��
 if trim(dm.ads279PARAMETER_VALUE.Value)<>'' then
  pnla_pcs:=strtoint(dm.ads279PARAMETER_VALUE.Value);

if find_spec_rkey('4') then //PNLB��Ԫ��
 if trim(dm.ads279PARAMETER_VALUE.Value)<>'' then
  pnlb_pcs:=strtoint(dm.ads279PARAMETER_VALUE.Value);
{
if find_spec_rkey('JN') then //set��Ԫ��
 if trim(dm.ads279PARAMETER_VALUE.Value)<>'' then
  set_pcs := strtoint(dm.ads279PARAMETER_VALUE.Value);
 }
 try
  if pnla_pcs>0 then
   Stringgrid1.Cells[9,Stringgrid1.row]:=
   inttostr(strtoint(trim(Stringgrid1.Cells[7,Stringgrid1.row]))*pnla_pcs+1);
  if pnlb_pcs>0 then
   Stringgrid1.Cells[10,Stringgrid1.row]:=
   inttostr(strtoint(trim(Stringgrid1.Cells[7,Stringgrid1.row]))*pnlb_pcs+1);
 { if set_pcs > 0 then
   Stringgrid1.Cells[8,Stringgrid1.row]:=
   inttostr(strtoint(trim(Stringgrid1.Cells[7,Stringgrid1.row]))*set_pcs);
  }
  if not bitbtn11.Enabled then bitbtn11.Enabled:=true;
 except

 end;

end;

procedure TForm2.N13Click(Sender: TObject);   //����ȫ������
var
 i,total_a,total_b,total_set:integer;
begin
 total_a := 0;
 total_b := 0;
 total_set := 0;
 if pos('TOTAL',UpperCase(stringgrid1.Cells[7,stringgrid1.RowCount-2]))>0 then
 if messagedlg('�����Ѿ������Ƿ����?',mtconfirmation,[mbyes,mbno],0)=mrno then
  exit;

 try
 for i:=1 to stringgrid1.RowCount-2 do
  begin
   if trim(Stringgrid1.Cells[8,i])<>'' then
   total_set := total_set+strtoint(Stringgrid1.Cells[8,i]);

   if trim(Stringgrid1.Cells[9,i])<>'' then
   total_a := total_a+strtoint(Stringgrid1.Cells[9,i]);
   if trim(Stringgrid1.Cells[10,i])<>'' then
   total_b := total_b+strtoint(Stringgrid1.Cells[10,i]);
  end;
 except
  messagedlg('PNL������������,����ֹͣ!',mterror,[mbcancel],0);
  exit;
 end;

stringgrid1.Cells[7,stringgrid1.RowCount-1]:='Total:';
if total_set>0 then
stringgrid1.Cells[8,stringgrid1.RowCount-1]:=inttostr(total_set);
if total_a>0 then
stringgrid1.Cells[9,stringgrid1.RowCount-1]:=inttostr(total_a);
if total_b>0 then
stringgrid1.Cells[10,stringgrid1.RowCount-1]:=inttostr(total_b);

stringgrid1.RowCount:=stringgrid1.RowCount+1;
if not bitbtn11.Enabled then bitbtn11.Enabled:=true;
end;

procedure TForm2.BitBtn8Click(Sender: TObject);
begin
 PopupMenu7.Popup(mouse.CursorPos.X,mouse.CursorPos.Y);
end;

procedure TForm2.N14Click(Sender: TObject); //��ʽ�������
var
 i,total_a,total_b,total_set:integer;
begin
 form_drcalc:=tform_drcalc.Create(application);
 if form_drcalc.ShowModal=mrok then
  begin

   total_a:=0;
   total_b:=0;
   total_set:=0;

   try
    for i:=strtoint(form_drcalc.Edit1.text) to strtoint(form_drcalc.Edit2.text) do
    begin
     if trim(Stringgrid1.Cells[8,i])<>'' then
     total_set := total_set+strtoint(Stringgrid1.Cells[8,i]);

     if trim(Stringgrid1.Cells[9,i])<>'' then
     total_a := total_a+strtoint(Stringgrid1.Cells[9,i]);
     if trim(Stringgrid1.Cells[10,i])<>'' then
     total_b := total_b+strtoint(Stringgrid1.Cells[10,i]);

    end;
   except
    messagedlg('PNL������������,����ֹͣ!',mterror,[mbcancel],0);
    exit;
   end;

   stringgrid1.Cells[7,strtoint(form_drcalc.Edit2.text)+1]:='Total:';
   if total_set>0 then
    stringgrid1.Cells[8,strtoint(form_drcalc.Edit2.text)+1]:=inttostr(total_set);

   if total_a>0 then
    stringgrid1.Cells[9,strtoint(form_drcalc.Edit2.text)+1]:=inttostr(total_a);
   if total_b>0 then
    stringgrid1.Cells[10,strtoint(form_drcalc.Edit2.text)+1]:=inttostr(total_b);

  if not bitbtn11.Enabled then bitbtn11.Enabled:=true;

  end;
 form_drcalc.Free;
end;

procedure TForm2.BitBtn16Click(Sender: TObject);

begin
 PopupMenu11.Popup(mouse.CursorPos.X,mouse.CursorPos.Y);
end;

procedure TForm2.DBEdit7Exit(Sender: TObject);
begin
 if ExRoundTo(dm.AQY0025EST_SCRAP.Value,2)>ExRoundTo(self.est_scrap,2) then
  begin
   showmessage('�����ʲ��ܴ��ڱ�������:'+currtostr(self.est_scrap));
   dbedit7.SetFocus;
  end;
end;

procedure TForm2.BitBtn17Click(Sender: TObject);
begin
if pagecontrol1.ActivePageIndex=0 then
 if not dm.ads502sheet_BMP.IsNull then
  if self.SavePictureDialog1.Execute then
   image1.Picture.SaveToFile(self.SavePictureDialog1.FileName)
  else
 else
  messagedlg('����ƴ��ͼΪ�ղ��ܱ���!',mterror,[mbcancel],0)
else
if pagecontrol1.ActivePageIndex=1 then
 if not dm.ads502pnl_bmp.IsNull then
  if self.SavePictureDialog1.Execute then
   image2.Picture.SaveToFile(self.SavePictureDialog1.FileName)
  else
 else
  messagedlg('Aƴ��ͼΪ�ղ��ܱ���!',mterror,[mbcancel],0)
else
if pagecontrol1.ActivePageIndex=2 then
 if not dm.ads502pnl2_bmp.IsNull then
  if self.SavePictureDialog1.Execute then
   image3.Picture.SaveToFile(self.SavePictureDialog1.FileName)
  else
 else messagedlg('Bƴ��ͼΪ�ղ��ܱ���!',mterror,[mbcancel],0);
end;


procedure TForm2.BitBtn18Click(Sender: TObject);
begin
if stringgrid1.RowCount>2 then
 Export_Grid_to_Excel(STRINGGRID1,DBtext3.Caption,true);
end;

procedure TForm2.BitBtn19Click(Sender: TObject);
var
 i:integer;
begin
  OpenDialog1.DefaultExt :='*.XLS';
  OpenDialog1.Filter :='*.XLS|*.XLS';
  if OpenDialog1.Execute then
  if messagedlg('�����µ���ױ�,ԭ���ݽ���ʧ������?',mtconfirmation,[mbyes,mbno],0)=mryes then
   begin
    for i:=1 to stringgrid1.RowCount-2 do  stringgrid1.Rows[i].Clear;
     stringgrid1.RowCount:=2;
    load_xls_to_sgrid(OpenDialog1.FileName,stringgrid1);
   end;
end;

procedure TForm2.N15Click(Sender: TObject);  //��������жԵ�
var i:integer;
begin
 strow:=tstringlist.Create;
 strow.AddStrings(self.StringGrid1.Rows[stringgrid1.row]);
 for i:=2 to StringGrid1.ColCount-1 do
 begin
  StringGrid1.Cells[i,stringgrid1.row]:=StringGrid1.Cells[i,stringgrid1.row-1];
  StringGrid1.Cells[i,stringgrid1.row-1]:=strow.Strings[i];
 end;
 strow.Destroy;
 stringgrid1.row:=stringgrid1.row-1;
 if not bitbtn11.Enabled then bitbtn11.Enabled:=true;
end;

procedure TForm2.N16Click(Sender: TObject);   //��������жԵ�
var i:integer;
begin
 strow:=tstringlist.Create;
 strow.AddStrings(self.StringGrid1.Rows[stringgrid1.row]);
 for i:=2 to StringGrid1.ColCount-1 do
 begin
  StringGrid1.Cells[i,stringgrid1.row]:=StringGrid1.Cells[i,stringgrid1.row+1];
  StringGrid1.Cells[i,stringgrid1.row+1]:=strow.Strings[i];
 end;   
 strow.Destroy;
 stringgrid1.row:=stringgrid1.row+1;
 if not bitbtn11.Enabled then bitbtn11.Enabled:=true;
end;

procedure TForm2.N17Click(Sender: TObject);   //�������һ�жԵ�
var row:string;
    i:integer;
begin
 row:=inttostr(self.StringGrid1.row);
 row:=
 InputBox('��Ϣ����', '������Ե�����:      ',row);

 try
  if (strtoint(row)<=0) or (strtoint(row)>=stringgrid1.RowCount) then
   begin
    showmessage('�����к�����');
    exit;
   end;
 except
  showmessage('�����ʽ����');
  exit;
 end;

 strow:=tstringlist.Create;
 strow.AddStrings(self.StringGrid1.Rows[stringgrid1.row]);
 for i:=2 to StringGrid1.ColCount-1 do
 begin
  StringGrid1.Cells[i,stringgrid1.row]:=StringGrid1.Cells[i,strtoint(row)];
  StringGrid1.Cells[i,strtoint(row)]:=strow.Strings[i];
 end;
 strow.Destroy;
 stringgrid1.row:=strtoint(row);
 if not bitbtn11.Enabled then bitbtn11.Enabled:=true;
end;

procedure TForm2.BitBtn3Click(Sender: TObject);
begin
 Frm_PCBCUT:=TFrm_PCBCUT.Create(application);
 try
   Frm_PCBCUT.Label36.Caption:=dm.AQY0025MANU_PART_NUMBER.Value;
   Frm_PCBCUT.Label34.Caption:=dm.ADS25CUST_CODE.Value;

   Frm_PCBCUT.Edit6.Text:=dm.AQY0025set_lngth.AsString;
   Frm_PCBCUT.Edit7.Text:=dm.AQY0025set_width.AsString;
   Frm_PCBCUT.Edit8.Text:=dm.AQY0025spell_qty.AsString;
   
   if Frm_PCBCUT.ShowModal=mrok then
   begin
     dm.AQY0025set_lngth.Value:=dm.ads502UNIT_LEN.Value;
     dm.AQY0025set_width.Value:=dm.ads502UNIT_WTH.Value;
     dm.AQY0025set_qty.Value:=dm.ads502UNIT_NUM.Value;
     dm.AQY0025TUSAGE.Value:=dm.ads502TUSAGE.Value;
     self.DBEdit17Exit(sender);
     image1.Picture.Assign(Load_JPG_Pic_From_DB(dm.ads502sheet_BMP));
    // if dm.ads502PNL_LEN.Value>0 then
       image2.Picture.Assign(Load_JPG_Pic_From_DB(dm.ads502pnl_bmp));
    // if not dm.ads502pnl2_bmp.IsNull then
       image3.Picture.Assign(Load_JPG_Pic_From_DB(dm.ads502pnl2_bmp));
   end;
 finally
   Frm_PCBCUT.free;
 end;
end;



procedure TForm2.N18Click(Sender: TObject);
var i:integer;
begin
if messagedlg('ɾ��ȫ�������Ϣ,ԭ���ݽ���ʧ������?',mtconfirmation,[mbyes,mbno],0)=mryes then
 begin
  for i:=1 to stringgrid1.RowCount-2 do  stringgrid1.Rows[i].Clear;
   stringgrid1.RowCount:=2;
  if not bitbtn11.Enabled then bitbtn11.Enabled:=true;
 end;
end;

procedure TForm2.SG2KeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if (sg2.Row=sg2.RowCount-1) and (trim(sg2.Rows[sg2.Row].Text)<>'') then
 begin
  sg2.Cells[0,sg2.Row]:=inttostr(sg2.Row);
  sg2.RowCount:=sg2.RowCount+1;
  sg2.Cells[6,sg2.Row]:=datetostr(now);
 end;
end;

procedure TForm2.SG2KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  IF (KEY=13) and (sg2.row<sg2.RowCount-1) then
   sg2.row:=sg2.row+1;
end;

procedure TForm2.N20Click(Sender: TObject);
var i:word;
begin
 for i:=sg2.RowCount-2 downto sg2.Row do
  sg2.Rows[i+1].Text:=sg2.Rows[i].Text;
 sg2.Rows[sg2.Row].Text:='';
 sg2.Cells[6,sg2.Row]:=datetostr(now);
 sg2.RowCount:=sg2.RowCount+1;
 for i:=1 to sg2.RowCount-2 do
  sg2.Cells[0,i]:=inttostr(i);
end;

procedure TForm2.N21Click(Sender: TObject);
var i:word;
begin
 for i:=sg2.Row to sg2.RowCount-2 do
  sg2.Rows[i].Text:=sg2.Rows[i+1].Text;
 sg2.RowCount:=sg2.RowCount-1;
 for i:=1 to sg2.RowCount-2 do
  sg2.Cells[0,i]:=inttostr(i);
end;

procedure TForm2.N22Click(Sender: TObject);
var i:integer;
begin
 if messagedlg('��ȷ��Ҫɾ��ȫ��ECN������Ϣ��',mtconfirmation,[mbyes,mbno],0)=mryes then
 begin
  for i:=1 to sg2.RowCount-2 do sg2.Rows[i].Clear;
  sg2.RowCount:=2;
 end;
end;

procedure TForm2.PopupMenu8Popup(Sender: TObject);
begin
 if (sg2.Row=1) or (sg2.Row=sg2.RowCount-1) then
   n23.Enabled:=false
 else n23.Enabled:=true; //��һ�������һ�в���������һ�н���
 if sg2.Row>=sg2.RowCount-2 then
   n24.Enabled:=false
 else n24.Enabled:=true; //���һ�в���������һ�н���
 
 if sg2.Row=sg2.RowCount-1 then
 begin
  n20.Enabled:=false;
  n21.Enabled:=false;
 end
 else begin
  n20.Enabled:=true;
  n21.Enabled:=true;
 end;
end;

procedure TForm2.BitBtn20Click(Sender: TObject);
var rkey_25,i,j:integer;
begin
 if messagedlg('����ECN��Ϣ���������ECN������ȷ��Ҫ������',mtwarning,[mbyes,mbno],0)=mryes then
 begin
  rkey_25:=dm.AQY0025RKEY.Value;
  for i:=1 to sg2.RowCount-2 do sg2.Rows[i].Clear;
  sg2.RowCount:=2;
  i:=1;
  while rkey_25>0 do
  begin
   with dm.ADOQuery1 do
   begin
    close;
    sql.Text:='select d25.manu_part_number,d273.entered_date,d273.text,'
      +'case d273.source when 1 then ''�ڲ�'' when 2 then ''�ͻ�Ҫ��'' end as source,'
      +'d05.employee_name as engineer,d273.ecn_no,d5.employee_name as enter_user,'
      +'d273.copyfromcust_ptr,d273.customer_part_ptr '
      +' from data0273 d273 inner join data0025 d25 on d273.customer_part_ptr=d25.rkey'
      +' inner join data0005 d5 on d273.entered_by=d5.rkey'
      +' left join data0005 d05 on d273.verified_by=d05.rkey'
      +' where d273.customer_part_ptr='+inttostr(rkey_25);
    open;
    if not isempty then
    begin
     rkey_25:=fieldbyname('copyfromcust_ptr').AsInteger;
     sg2.Cells[0,i]:=inttostr(i);
     sg2.Cells[1,i]:=fieldbyname('manu_part_number').AsString;
     sg2.Cells[2,i]:=fieldbyname('text').AsString;
     sg2.Cells[3,i]:=fieldbyname('source').AsString;
     sg2.Cells[5,i]:=fieldbyname('engineer').AsString;
     sg2.Cells[6,i]:=fieldbyname('entered_date').AsString;
     sg2.Cells[7,i]:=fieldbyname('ecn_no').AsString;
     sg2.Cells[8,i]:=fieldbyname('enter_user').AsString;
     sg2.RowCount:=sg2.RowCount+1;
    end
    else rkey_25:=0;
    i:=i+1;
   end;
  end; //end while
  //-----���½���ǰ��˳�򣬰汾�ɵ͵���
  strow:=Tstringlist.Create;
  for i:=1 to ((sg2.RowCount-2) div 2) do
  begin
   strow.Clear;
   strow.AddStrings(sg2.Rows[i]);
   for j:=1 to 8 do
   begin
    sg2.Cells[j,i]:=sg2.Cells[j,sg2.rowcount-1-i];
    sg2.Cells[j,sg2.RowCount-1-i]:=strow.Strings[j];
   end;
  end;
  strow.Destroy;

 end;
end;

procedure TForm2.N23Click(Sender: TObject);
var i:byte;
begin
 strow:=Tstringlist.Create;
 strow.AddStrings(sg2.Rows[sg2.Row]);
 for i:=1 to 8 do
 begin
   sg2.Cells[i,sg2.Row]:=sg2.Cells[i,sg2.Row-1];
   sg2.cells[i,SG2.row-1]:=strow.strings[i];
 end;
 sg2.Row:=sg2.Row-1;
 strow.Destroy;
end;

procedure TForm2.N24Click(Sender: TObject);
var i:integer;
begin
 strow:=tstringlist.Create;
 strow.AddStrings(self.sg2.Rows[sg2.row]);
 for i:=1 to 8 do
 begin
  sg2.Cells[i,sg2.row]:=sg2.Cells[i,sg2.row+1];
  sg2.Cells[i,sg2.row+1]:=strow.Strings[i];
 end;
 sg2.Row:=sg2.Row+1;
 strow.Destroy;
end;

procedure TForm2.MI1Click(Sender: TObject);
begin
 form_reportselect:=tform_reportselect.Create(application);
 if form_reportselect.ShowModal=mrok then
 begin
  form_report:=tform_report.Create(application);
  with form_report do
  begin

    ppReport1.Reset;
    { ppReport1.Template.FileName :=
     'D:\vss�ĵ�\ԭ�������\�������\��Ʒ���\��ƷMI���fpc\Manu_instruction.rtm';  }
    ppReport1.Template.FileName :=
      stringReplace(UpperCase(extractfilepath(paramstr(0))),'EXEC\','NIERP\REPORT\',[rfReplaceAll])+
        'Manu_instruction_FPC.rtm'; {}  //R:\NIERP\Report\Manu_instruction.rtm
    ppReport1.Template.LoadFromFile;
    ppreport1.SaveAsTemplate:=false;
    
   ads192.Open;
   ads279.Close;
   ads279.Parameters.ParamValues['rkey']:=dm.AQY0025RKEY.Value;
   if ads192ENG_CONTROL16.Value=1 then       //����ʾΪ�յ�ȫ�ֲ���
    ads279.Parameters.ParamValues['value']:=''
   else ads279.Parameters.ParamValues['value']:='#@#@#';
   ads279.Open;

   ads25.Close;
   ads25.Parameters[0].Value:=dm.AQY0025RKEY.Value;
   ads25.Open;

   ads494.Close;
   ads494.Parameters.ParamValues['source_ptr']:=dm.AQY0025RKEY.Value;
   if ads192ENG_CONTROL2.Value=1 then       //����ʾΪ�յ��Ƴ̲���
    ads494.Parameters.ParamValues['value']:=''
   else ads494.Parameters.ParamValues['value']:='#@#@#';
   ads494.Open;

   ads38.Close;
   ads38.Parameters.ParamValues['rkey']:=dm.AQY0025RKEY.Value;
   if form_reportselect.CheckBox3.Checked then
    ads38.Parameters.ParamValues['visible']:=1
   else ads38.Parameters.ParamValues['visible']:=2;
   ads38.Open;
   ads502.Open;
   ads29.Open;
   form_report.ppImage3.Picture.Assign(Load_JPG_Pic_From_DB(ads502DSDesigner));
   if ads502A3.Value>0 then
    form_report.ppimage1.Picture.Assign(Load_JPG_Pic_From_DB(ads502A));
   if ads502B.AsVariant <> null then
    form_report.ppimage2.Picture.Assign(Load_JPG_Pic_From_DB(ads502B));

   if not form_reportselect.CheckBox1.Checked then
    form_report.ppSubReport1.Visible:=false;
   if not form_reportselect.CheckBox2.Checked then
    form_report.ppSubReport2.Visible:=false;
   if not form_reportselect.CheckBox4.Checked then
    form_report.ppSubReport3.Visible:=false;
  end;

  form_report.ppReport1.Print;
  form_report.Free;
 end;
 form_reportselect.Free;
end;

procedure TForm2.ECN1Click(Sender: TObject);
begin
  Form_report1:=TForm_report1.Create(application);
  with form_report1 do
  begin
   aq35.Close;
   aq35.Parameters[0].Value:=dm.AQY0025RKEY.Value;
   aq35.Open;
   ppreport1.Print;
  end;
  form_report1.Free;
end;

procedure TForm2.SG2Exit(Sender: TObject);
var i:byte;
begin
 for i:=1 to sg2.RowCount-2 do
  if trim(sg2.Cells[6,i])<>'' then
   try
    strtodatetime(sg2.Cells[6,i]);
   except
    showmessage('��'+inttostr(i)+'��ECN��¼�������벻��ȷ��');
    sg2.SetFocus;
    exit;
   end;
end; 

procedure TForm2.PM20Popup(Sender: TObject);
begin
 if dm.ADO20.IsEmpty then n19.Enabled:=false
 else n19.Enabled:=true;
end;

procedure TForm2.N19Click(Sender: TObject);
var f:string;
    fs:TMemoryStream;
begin
 if dm.ADO20file_content.IsNull then
 begin
   showmessage('���ĵ�Ϊ��...');
   exit;
 end;
 fs := TMemoryStream.Create;
 dm.ADO20file_content.SaveToStream(fs);
 UnPackStream(fs);
 if not DirectoryExists(TmpFileDir) then
  if not CreateDir(TmpFileDir) then  raise Exception.Create('������ʱ�ļ�Ŀ¼����: '+TmpFileDir);
 f:=TmpFileDir+dm.ADO20file_Name.AsString;
 fs.SaveToFile(f);
 fs.Free;
// setfileattributes(pchar(f),FILE_ATTRIBUTE_READONLY);
 ShellExecute(0,'open',pchar(f),nil,nil,SW_SHOWNORMAL);
end;

procedure TForm2.FormDestroy(Sender: TObject);
var sr: TSearchRec;
begin
 dm.ADO20.Close;
 if FindFirst(TmpFileDir+'*.*', faAnyFile, sr) = 0 then
 begin
  repeat
   setfileattributes(pchar(TmpFileDir+sr.name),file_attribute_normal);
   DeleteFile(TmpFileDir+sr.Name);
  until FindNext(sr) <> 0;
  FindClose(sr);
 end;
file_name.Free;

end;

procedure TForm2.BitBtn21Click(Sender: TObject);
begin
Export_dbGrid_to_Excel(dbgrid3,'�г�������Ϣ '+dbtext3.Caption)
end;

procedure TForm2.SET1Click(Sender: TObject);  //����SET�������㵥��
var
 pnla_pcs,pnlb_pcs,set_pcs:integer;
begin
 pnla_pcs := 0;
 pnlb_pcs := 0;
 set_pcs := 0;
 if find_spec_rkey('3') then //PNLA��Ԫ��
  if trim(dm.ads279PARAMETER_VALUE.Value)<>'' then
   pnla_pcs:=strtoint(dm.ads279PARAMETER_VALUE.Value);

 if find_spec_rkey('4') then //PNLB��Ԫ��
  if trim(dm.ads279PARAMETER_VALUE.Value)<>'' then
   pnlb_pcs:=strtoint(dm.ads279PARAMETER_VALUE.Value);

 if find_spec_rkey('JN') then //set��Ԫ��
  if trim(dm.ads279PARAMETER_VALUE.Value)<>'' then
   set_pcs := strtoint(dm.ads279PARAMETER_VALUE.Value);

 try
  {
  if set_pcs > 0 then
   Stringgrid1.Cells[7,Stringgrid1.row]:=
   inttostr(trunc(strtoint(trim(Stringgrid1.Cells[8,Stringgrid1.row]))/set_pcs));
  }
  if pnla_pcs>0 then
   Stringgrid1.Cells[9,Stringgrid1.row]:=
   inttostr(strtoint(trim(Stringgrid1.Cells[8,Stringgrid1.row]))*trunc(pnla_pcs/set_pcs)+1);

  if pnlb_pcs>0 then
   Stringgrid1.Cells[10,Stringgrid1.row]:=
   inttostr(strtoint(trim(Stringgrid1.Cells[8,Stringgrid1.row]))*trunc(pnlb_pcs/set_pcs)+1);

  if not bitbtn11.Enabled then bitbtn11.Enabled:=true;
 except

 end;

end;

procedure TForm2.SET2Click(Sender: TObject);   //����SET����ȫ��
var
 pnla_pcs,pnlb_pcs,i,set_pcs:integer;
begin
 pnla_pcs:=0;
 pnlb_pcs:=0;
 set_pcs:=0;
if find_spec_rkey('3') then //PNLA��Ԫ��
 if trim(dm.ads279PARAMETER_VALUE.Value)<>'' then
  pnla_pcs:=strtoint(dm.ads279PARAMETER_VALUE.Value);

if find_spec_rkey('4') then //PNLB��Ԫ��
 if trim(dm.ads279PARAMETER_VALUE.Value)<>'' then
  pnlb_pcs:=strtoint(dm.ads279PARAMETER_VALUE.Value);

if find_spec_rkey('JN') then //set��Ԫ��
 if trim(dm.ads279PARAMETER_VALUE.Value)<>'' then
  set_pcs := strtoint(dm.ads279PARAMETER_VALUE.Value);

for i:=1 to stringgrid1.RowCount-2 do
 try
  {
  if set_pcs > 0 then
   Stringgrid1.Cells[7,i]:=
   inttostr(trunc(strtoint(trim(Stringgrid1.Cells[8,i]))/set_pcs));
  }
  if pnla_pcs>0 then
   Stringgrid1.Cells[9,i]:=
   inttostr(strtoint(trim(Stringgrid1.Cells[8,i]))*trunc(pnla_pcs/set_pcs)+1);

  if pnlb_pcs>0 then
   Stringgrid1.Cells[10,i]:=
   inttostr(strtoint(trim(Stringgrid1.Cells[8,i]))*trunc(pnlb_pcs/set_pcs)+1);

  if not bitbtn11.Enabled then bitbtn11.Enabled:=true;
 except

 end;

end;

procedure TForm2.Edit7KeyPress(Sender: TObject; var Key: Char);
begin
 if not (key in ['0'..'9','.',#8,#13]) then  //�ж��Ƿ���������
  abort
 else
  if key = chr(46) then      //�ж��Ƿ��ظ�����С����'.'
   if pos('.',(sender as Tedit).Text)>0  then abort;
end;

procedure TForm2.N27Click(Sender: TObject);
var
 step_number,recd_cound:integer;
begin
 step_number:=dm.ADS38STEP_NUMBER.Value;
 recd_cound:=dm.ADS38.RecordCount;
 dm.ADS38.Edit;
 dm.ADS38STEP_NUMBER.Value:=recd_cound+1;
 dm.ADS38.Post;
 dm.ads494.Filter:='step_number='+inttostr(step_number);
 while not dm.ads494.Eof do
 begin
  dm.ads494.Edit;
  dm.ads494step_number.Value := recd_cound+1;
  dm.ads494.Post;
 end;


 dm.ADS38.MoveBy(step_number-1-dm.ADS38.RecNo);
 dm.ADS38.Edit;
 dm.ADS38STEP_NUMBER.Value:=step_number;
 dm.ADS38.Post;

 dm.ads494.Filter:='step_number='+inttostr(step_number-1);
 while not dm.ads494.Eof do
 begin
  dm.ads494.Edit;
  dm.ads494step_number.Value :=step_number ;
  dm.ads494.Post;
 end;

 dm.ADS38.Last;
 dm.ADS38.Edit;
 dm.ADS38STEP_NUMBER.Value:=step_number-1;
 dm.ADS38.Post;

 dm.ads494.Filter:='step_number='+inttostr(recd_cound+1);
 while not dm.ads494.Eof do
 begin
  dm.ads494.Edit;
  dm.ads494step_number.Value :=step_number-1 ;
  dm.ads494.Post;
 end;

 dm.ads494.Filter:='';

end;

procedure TForm2.N28Click(Sender: TObject);
var
 step_number,recd_cound:integer;
begin
 step_number:=dm.ADS38STEP_NUMBER.Value;
 recd_cound:=dm.ADS38.RecordCount;
 dm.ADS38.Edit;
 dm.ADS38STEP_NUMBER.Value:=recd_cound+1;
 dm.ADS38.Post;
 dm.ads494.Filter:='step_number='+inttostr(step_number);
 while not dm.ads494.Eof do
 begin
  dm.ads494.Edit;
  dm.ads494step_number.Value := recd_cound+1;
  dm.ads494.Post;
 end;


 dm.ADS38.MoveBy(step_number-dm.ADS38.RecNo);
 dm.ADS38.Edit;
 dm.ADS38STEP_NUMBER.Value:=step_number;
 dm.ADS38.Post;

 dm.ads494.Filter:='step_number='+inttostr(step_number+1);
 while not dm.ads494.Eof do
 begin
  dm.ads494.Edit;
  dm.ads494step_number.Value :=step_number ;
  dm.ads494.Post;
 end;

 dm.ADS38.Last;
 dm.ADS38.Edit;
 dm.ADS38STEP_NUMBER.Value:=step_number+1;
 dm.ADS38.Post;

 dm.ads494.Filter:='step_number='+inttostr(recd_cound+1);
 while not dm.ads494.Eof do
 begin
  dm.ads494.Edit;
  dm.ads494step_number.Value :=step_number+1 ;
  dm.ads494.Post;
 end;

 dm.ads494.Filter:='';

end;

procedure TForm2.N29Click(Sender: TObject);
begin
try
 form_deptcode:=tform_deptcode.Create(application);
 if form_deptcode.ShowModal=mrok then
  begin
   dm.ADS38.Edit;
   dm.ADS38DEPT_PTR.Value:=form_deptcode.ADOQuery1rkey.Value;
   dm.ADS38DEF_ROUT_INST.Value:=form_deptcode.ADOQuery1DEF_ROUT_INST.Value;
   dm.ADS38.Post;

 dm.ads494.Filter:='step_number='+dm.ADS38STEP_NUMBER.AsString;
 dm.ads494.First;
 while not dm.ads494.Eof do dm.ads494.Delete;

      dm.ADOQuery1.Close;   //=====���ܸı�adoquery1�����
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
                 cacl_flowpara(dm.ADOQuery1.Fieldbyname('TValue').AsString,
                               trim(dm.ADOQuery1.Fieldbyname('formula').AsString)),
                               dm.ADS38SOURCE_PTR.Value,
                               dm.ADS38STEP_NUMBER.Value,
                               dm.ADOQuery1.FieldValues['SEQ_NO'],
                               dm.ADOQuery1.FieldValues['Doc_Flag'],
                               dm.ADOQuery1.FieldValues['after_flag'],
                               dm.ADOQuery1.FieldValues['flow_spfc_flag']]);
       dm.ADOQuery1.Next;
      end;          //=======���ܸı�adoquery1�����
   dm.ads494.Filter:='';
   if not bitbtn11.Enabled then bitbtn11.Enabled:=true;
  end;
finally
 form_deptcode.Free;
end;

end;

procedure TForm2.PopupMenu9Popup(Sender: TObject);
begin
if dm.ads564.IsEmpty then
 begin
  n31.Enabled:=false;
  n32.Enabled:=false;
  n33.Enabled:=false;
  if strtoint(status.Caption)=0 then
   n30.Enabled:=true
  else
   n30.Enabled:=false;
 end
else
 if strtoint(status.Caption)=0 then
 begin
  n30.Enabled:=true;
  n31.Enabled:=true;
  n32.Enabled:=true;
  n33.Enabled:=true;
 end
else
 begin
  n30.Enabled:=false;
  n31.Enabled:=false;
  n32.Enabled:=false;
  n33.Enabled:=true;
 end;


end;

procedure TForm2.N30Click(Sender: TObject);
var i:integer;
    s:string;
    fs: TMemoryStream;  
begin
  OpenDialog1.DefaultExt :='*.*';
  OpenDialog1.Filter :='';
  if OpenDialog1.Execute then
  begin
    for i:=length(OpenDialog1.FileName) downto 1 do
    begin
      if  OpenDialog1.FileName[i]<>'\' then
         s:=OpenDialog1.FileName[i]+s
      else
         break;
    end;
    fs := TMemoryStream.Create;
    fs.LoadFromFile(OpenDialog1.FileName);
    if fs.Size>10*1024*1024 then
    begin
      showmessage('�ļ���С���ܳ���10M,�����������ļ��ٱ���...');
      fs.Free;
      exit;
    end;

    PackStream(fs);
    dm.ads564.Append;
    dm.ads564rec_no.Value:=dm.ads564.RecordCount;
    dm.ads564SOURCE_PTR.Value:=dm.AQY0025RKEY.Value;
    dm.ads564file_name.Value:=s;
    dm.ads564in_date.Value:=getsystem_date(dm.ADOQuery1,1);
    dm.ads564.Post;
    file_name.Add(OpenDialog1.FileName+';'+'0');
    fs.Free;
  end;
end;

procedure TForm2.N31Click(Sender: TObject);
var
 step_number:word;
begin
if Msg_Dlg_Ask('��ȷ��Ҫɾ���ü�¼��?','��ʾ��Ϣ',1) then
 begin
  file_name.Delete(dm.ads564rec_no.Value);
  if dm.ads564.RecNo=dm.ads564.RecordCount then
   dm.ads564.Delete
  else
   begin
    dm.ads564.Delete;
    step_number := dm.ads564.RecNo;
    while not dm.ads564.Eof do
     begin
      dm.ads564.Edit;
      dm.ads564rec_no.Value:=dm.ads564rec_no.Value-1;
      dm.ads564.Post;
      dm.ads564.Next;
     end;
    dm.ads564.MoveBy(step_number-dm.ads564.RecNo);
   end;
 end;
end;

procedure TForm2.N32Click(Sender: TObject);
var
 str:string;
begin
 str:=dm.ads564remark.Value;
 if inputquery('�༭��ע','�ļ���ע˵��:       ',str) then
 begin
  dm.ads564.Edit;
  dm.ads564remark.Value:=str;
  dm.ads564.Post;
 end;
end;

procedure TForm2.N33Click(Sender: TObject);
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
      showmessage('���ĵ�Ϊ��...');
      exit;
    end;
    fs := TMemoryStream.Create;
    TBlobfield(dm.AQtmp.fieldbyname('vcut_bmp')).SaveToStream(fs);
    UnPackStream(fs);
    if not DirectoryExists(TmpFileDir) then
      if not CreateDir(TmpFileDir) then
        raise Exception.Create('������ʱ�ļ�Ŀ¼����: '+TmpFileDir);
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

procedure TForm2.StringGrid2DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
begin
if (gdSelected  in State) then
 begin
  if (ACol = 1 ) then
   begin
    ComboBox1.Left := Rect.Left+1;
    ComboBox1.Top := Rect.Top+2;
    ComboBox1.Width := Rect.Right - Rect.Left+3;
    ComboBox1.Height := Rect.Bottom - Rect.Top;
    ComboBox1.Visible := True;
    if StringGrid2.Cells[acol,arow]<>'' then
     combobox1.ItemIndex:=combobox1.Items.IndexOf(StringGrid2.Cells[acol,arow])
    else
     combobox1.ItemIndex:=-1;
   end
  else
    ComboBox1.Visible :=false;
 end;


if (acol=0) and (ARow>0) and
   (ARow<>StringGrid2.RowCount-1) then
 StringGrid2.Canvas.TextRect(rect,rect.Left+2,rect.Top+2, inttostr(ARow));

end;

procedure TForm2.StringGrid2KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if (stringgrid2.Row=stringgrid2.RowCount-1) and
   (trim(stringgrid2.Rows[stringgrid2.Row].Text)<>'') then
 begin
  stringgrid2.Cells[0,stringgrid2.Row]:=inttostr(stringgrid2.Row);
  stringgrid2.RowCount:=stringgrid2.RowCount+1;
  if not bitbtn11.Enabled then bitbtn11.Enabled:=true;
 end;
end;

procedure TForm2.N34Click(Sender: TObject);
var
  i:word;
begin
 for i:=stringgrid2.Row to stringgrid2.RowCount-2 do
  stringgrid2.Rows[i].Text:=stringgrid2.Rows[i+1].Text;
  stringgrid2.RowCount:=stringgrid2.RowCount-1;
if not bitbtn11.Enabled then bitbtn11.Enabled:=true;
end;

procedure TForm2.N36Click(Sender: TObject);
var i:integer;
begin
if messagedlg('ɾ��ȫ���迹��Ϣ,ԭ���ݽ���ʧ������?',mtconfirmation,[mbyes,mbno],0)=mryes then
 begin
  for i:=1 to stringgrid2.RowCount-2 do  stringgrid2.Rows[i].Clear;
   stringgrid2.RowCount:=2;
  if not bitbtn11.Enabled then bitbtn11.Enabled:=true;
 end;
end;

procedure TForm2.StringGrid2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  IF (KEY=13) and (Stringgrid2.row<stringgrid2.RowCount-1) and
     (stringgrid2.Col<>1) then
   Stringgrid2.row:=Stringgrid2.row+1;
 if (chr(key)='D') and (ssCtrl in shift) and (stringgrid2.Row>1) then
  begin
   stringgrid2.Cells[stringgrid2.col,stringgrid2.row]:=
   stringgrid2.Cells[stringgrid2.col,stringgrid2.row-1];
  end;
end;

procedure TForm2.N35Click(Sender: TObject); //�迹�������жԵ�
var i:integer;
begin
 strow:=tstringlist.Create;
 strow.AddStrings(StringGrid2.Rows[stringgrid2.row]);
 for i:=2 to StringGrid2.ColCount-1 do
 begin
  StringGrid2.Cells[i,stringgrid2.row]:=StringGrid2.Cells[i,stringgrid2.row-1];
  StringGrid2.Cells[i,stringgrid2.row-1]:=strow.Strings[i];
 end;
 strow.Destroy;
 stringgrid2.row:=stringgrid2.row-1;
 if not bitbtn11.Enabled then bitbtn11.Enabled:=true;
end;

procedure TForm2.N37Click(Sender: TObject);
var i:integer;
begin
 strow:=tstringlist.Create;
 strow.AddStrings(self.StringGrid2.Rows[stringgrid2.row]);
 for i:=2 to StringGrid2.ColCount-1 do
 begin
  StringGrid2.Cells[i,stringgrid2.row]:=StringGrid2.Cells[i,stringgrid2.row+1];
  StringGrid2.Cells[i,stringgrid2.row+1]:=strow.Strings[i];
 end;
 strow.Destroy;
 stringgrid2.row:=stringgrid2.row+1;
 if not bitbtn11.Enabled then bitbtn11.Enabled:=true;
end;

procedure TForm2.N38Click(Sender: TObject);
var row:string;
    i:integer;
begin
 row:=inttostr(self.StringGrid2.row);
 row:=
 InputBox('��Ϣ����', '������Ե�����:      ',row);

 try
  if (strtoint(row)<=0) or (strtoint(row)>=stringgrid2.RowCount) then
   begin
    showmessage('�����к�����');
    exit;
   end;
 except
  showmessage('�����ʽ����');
  exit;
 end;

 strow:=tstringlist.Create;
 strow.AddStrings(self.StringGrid2.Rows[stringgrid2.row]);
 for i:=2 to StringGrid2.ColCount-1 do
 begin
  StringGrid2.Cells[i,stringgrid2.row]:=StringGrid2.Cells[i,strtoint(row)];
  StringGrid2.Cells[i,strtoint(row)]:=strow.Strings[i];
 end;
 strow.Destroy;
 stringgrid2.row:=strtoint(row);
 if not bitbtn11.Enabled then bitbtn11.Enabled:=true; 
end;

procedure TForm2.PopupMenu10Popup(Sender: TObject);
begin
if stringgrid2.Row = stringgrid2.RowCount-1 then
 begin
  n34.Enabled:=false;
  n37.Enabled:=false;
 end
else
 begin
  n34.Enabled:=true;
  n37.Enabled:=true;
 end;
 n36.Enabled:=stringgrid2.RowCount>2;
 n35.Enabled:=stringgrid2.Row>1;
end;

procedure TForm2.ComboBox1Change(Sender: TObject);
begin
 stringgrid2.Cells[1,stringgrid2.Row]:=combobox1.Text;
end;

procedure TForm2.ComboBox1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key=112 then combobox1.DroppedDown:=true; //F1����������
if key=13 then stringgrid2.SetFocus;
end;

procedure TForm2.StringGrid2SelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
 IF ACOL=1 THEN
  stringgrid2.Options:=stringgrid2.Options-[goEditing]
 else
  stringgrid2.Options:=stringgrid2.Options+[goEditing];
end;

procedure TForm2.BitBtn23Click(Sender: TObject);
var
 i:integer;
begin
if stringgrid2.RowCount>2 then
begin
 for i:=1 to stringgrid2.RowCount-2 do
  stringgrid2.Cells[0,i]:=inttostr(i);
 Export_Grid_to_Excel(STRINGGRID2,DBtext3.Caption,true);
end;
end;

procedure TForm2.BitBtn22Click(Sender: TObject);
var
 i:integer;
begin
  OpenDialog1.DefaultExt :='*.XLS';
  OpenDialog1.Filter :='*.XLS|*.XLS';
  if OpenDialog1.Execute then
  if messagedlg('�����µ��迹��,ԭ���ݽ���ʧ������?',mtconfirmation,[mbyes,mbno],0)=mryes then
   begin
    for i:=1 to stringgrid2.RowCount-2 do  stringgrid2.Rows[i].Clear;
     stringgrid2.RowCount:=2;
    self.load_xls_to_sgrid(OpenDialog1.FileName,stringgrid2);
   end;
end;

procedure TForm2.Paste(var str:string);
var i,x,y,tmpx,tmpy:integer;
    FromCB1:array [0..255] of array[0..255] of string;
begin
    if str = '' then
    showmessage('ճ��������Ϊ�գ��븴���������ݡ�')
    else begin
              i:=pos(#13,str);
              Delete(str,1,i+1);
              i:=pos(#13,str);
              x:=0;
              while i<>0 do
              begin
                  FromCB1[x][0]:= copy(str,1,i-1);
                  Delete(str,1,i+1);
                  Inc(x);
                  i:=pos(#13,str);
              end;
              FromCB1[x][0]:= str;
              stringgrid1.RowCount := x + 3;
              tmpx:=x;
              for x:= 0 to tmpx do
              begin
                      i:=pos(#9,FromCB1[x][0]);
                      y:=1;
                      while i<>0 do
                      begin
                          FromCB1[x][y]:= copy(FromCB1[x][0],1,i-1);
                          FromCB1[x][0]:= copy(FromCB1[x][0],i+1,length(FromCB1[x][0])-i);
                          Inc(y);
                          i:=pos(#9,FromCB1[x][0]);
                      end;
                          FromCB1[x][y]:= FromCB1[x][0];
              end;
              tmpx:= x;
              tmpy:= y;
              for x:=0 to tmpx do
              begin
                  for y:=1 to tmpy+1 do
                        stringgrid1.Cells[y-1,x+1]:=FromCB1[x][y+1];
              end;
        end;
end;


procedure TForm2.BitBtn24Click(Sender: TObject);
var
  str:string;
begin
 if (stringgrid1.RowCount > 2) and
    (not Msg_Dlg_Ask('ճ���µ���ױ�,ԭ���ݽ���ʧ������?','��Ϣ��ʾ',1)) then
 else
  begin
    str:= Clipboard.AsText;
   if (copy(str,1,1) = #9) {and (copy(str,2,4) = '���') } then
     Paste(str)
   else
     showmessage('ճ��������ݲ��������ճ�����ݣ������¸���');
  end;
end;

function TForm2.isnum(str:string):boolean;
var 
  i:integer;
begin
  for i:=1 to length(str) do
   if not (str[i] in ['0'..'9']) then
    begin
      result:=false;
      exit;
    end;
  result:=true;
end;

function TForm2.hz_jiajian(str: string; jia_or_jian: byte): string;
begin
 result:=str;
if isnum(copy(str,length(str)-1,2)) then       //�����λ������
 if jia_or_jian=1 then
  result:=copy(str,1,length(str)-2)+
                       copy(inttostr(100+
                       strtoint(copy(str,length(str)-1,2)
                                )+1),
                            2,2)
 else
  result:=copy(str,1,length(str)-2)+
                       copy(inttostr(100+
                       strtoint(copy(str,length(str)-1,2)
                                )-1),
                            2,2)
else
 if isnum(copy(str,length(str),1)) then       //���һλ������
  if jia_or_jian=1 then
   result:=copy(str,1,length(str)-1)+
                         copy(inttostr(10+
                         strtoint(copy(str,length(str),1)
                                  )+1),
                              2,1)
  else
   result:=copy(str,1,length(str)-1)+
                         copy(inttostr(10+
                         strtoint(copy(str,length(str),1)
                                  )-1),
                              2,1);
end;

procedure TForm2.N110Click(Sender: TObject);
var
 i:integer;
begin
 for i:=stringgrid1.Row+1 to stringgrid1.RowCount-1 do
  if trim(stringgrid1.Cells[1,i])<>'' then
   stringgrid1.Cells[1,i] := hz_jiajian(stringgrid1.Cells[1,i],1);//��1
end;

procedure TForm2.N111Click(Sender: TObject);
var
 i:integer;
begin
 for i:=stringgrid1.Row+1 to stringgrid1.RowCount-1 do
  if trim(stringgrid1.Cells[1,i])<>'' then
   stringgrid1.Cells[1,i] := hz_jiajian(stringgrid1.Cells[1,i],0);  //��1
end;



procedure TForm2.N39Click(Sender: TObject);
begin
frmpickengnote:=tfrmpickengnote.Create(application);
frmpickengnote.ADOQuery1.Close;
frmpickengnote.ADOQuery1.SQL.Text:=
'select * from data0036 where INST_CODE like ''dr%'' order by inst_code';
frmpickengnote.ADOQuery1.Open;
if frmpickengnote.ShowModal=mrok then
begin
 stringgrid1.Cells[11,stringgrid1.Row]:=
  frmpickengnote.ADOQuery1.fieldbyname('PROD_ROUT_INST').AsString;
end;
frmpickengnote.Free;
end;



procedure TForm2.DRL1Click(Sender: TObject);
//var
  //i:integer;
  //mytextfile:textfile;
  //s:string;
  //Hole_information_1:THole_information;
begin
     try
        inputform.OpenDialog1.Filter:='����ļ�(*.t*;*.d*)|*.t*;*.d*';
        inputform.OpenDialog1.Tag:=0;
        if inputform.OpenDialog1.Execute then
            inputform.ShowModal;
     finally
        inputform.Visible:=False;
     end;

end;

procedure TForm2.Genesis1Click(Sender: TObject);
begin
 try
  form_genesis:=Tform_genesis.Create(application);
  with form_genesis do
   begin
    jobname.Text:=LowerCase(dbtext3.Field.Value);
    pth.Text:=edit7.Text;
    npth.Text:=edit8.Text;
   end;
  form_genesis.ShowModal;
 finally
  form_genesis.Free;
 end;
end;

procedure TForm2.N40Click(Sender: TObject);
var
 i:word;
begin
if messagedlg('���Ƿ��趨��PTH��PTH��NPTH�Ĳ���?',mtconfirmation,[mbyes,mbno],0)=mryes then
begin

 for i:= 1 to stringgrid1.RowCount-2 do
 try
   if trim(stringgrid1.Cells[4,i])='Y' then
    stringgrid1.Cells[6,i]:=formatfloat('0.00',
                            dr_jishuan(strtofloat(stringgrid1.Cells[3,i]))+
                            strtofloat(edit7.Text))

  else
   if trim(stringgrid1.Cells[4,i])='N' then
    stringgrid1.Cells[6,i]:=formatfloat('0.00',
                            dr_jishuan(strtofloat(stringgrid1.Cells[3,i]))+
                            strtofloat(edit8.Text));

 except

 end;
 edit6.Text:=formatfloat('0.00',(get_mindrill()));
end;
end;

procedure TForm2.BitBtn5Click(Sender: TObject);
begin
 PopupMenu12.Popup(mouse.CursorPos.X,mouse.CursorPos.Y);
end;

procedure TForm2.N41Click(Sender: TObject);
var
 i:word;
begin
if messagedlg('���Ƿ��趨��PTH��PTH��NPTH�Ĳ���?',mtconfirmation,[mbyes,mbno],0)=mryes then
begin

 for i:= 1 to stringgrid1.RowCount-2 do
 try
   if trim(stringgrid1.Cells[4,i])='Y' then
    stringgrid1.Cells[3,i]:=formatfloat('0.00',
                            StrToCurr(stringgrid1.Cells[6,i])-StrToCurr(edit7.Text))

  else
   if trim(stringgrid1.Cells[4,i])='N' then
    stringgrid1.Cells[3,i]:=formatfloat('0.00',
                            StrToCurr(stringgrid1.Cells[6,i])-StrToCurr(edit8.Text));

 except

 end;

end;
end;

procedure TForm2.BitBtn25Click(Sender: TObject);
var
 j:integer;
begin
form_layersdata:=tform_layersdata.Create(application);
self.get_treedate(dm.AQY0025RKEY.Value,form_layersdata.TreeView1);
if form_layersdata.ShowModal=mrok then
 begin
  with dm.ADOQuery1 do
  begin
   close;
   sql.Text:=
   'select * from data0502'+#13+
   'where source_ptr= '+form_layersdata.rkey25.Caption;
   open;
  end;
  if not dm.ads502.IsEmpty then dm.ads502.Edit else  dm.ads502.Append;
  for j:=1 to 22 do
   dm.ads502.Fields[j].Value:=dm.ADOQuery1.FieldValues[dm.ads502.Fields[j].FieldName];
   dm.ads502source_ptr.Value:= dm.AQY0025RKEY.Value;
   dm.ads502.Post;

  image1.Picture.Assign(Load_JPG_Pic_From_DB(dm.ads502sheet_BMP));
  image2.Picture.Assign(Load_JPG_Pic_From_DB(dm.ads502pnl_bmp));
  image3.Picture.Assign(Load_JPG_Pic_From_DB(dm.ads502pnl2_bmp));
 end;
form_layersdata.Free;
end;

function CallPCBCut: Boolean;
type
  pfShowPCBCutFrm = function (AOwner: TComponent): Boolean;stdcall;
var
  pf: Pointer;
  hMod: HWND;
begin
  Result := False;
  with TResourceStream.Create(HInstance,'RC1',RT_RCDATA) do
  begin
    try
      SaveToFile('PCBCut.dll');
    finally
      Free;
    end;
  end;

  hMod := LoadLibrary(PChar(ExtractFilePath(ParamStr(0)) + 'PCBCut.dll'));
  if (hMod <> 0) and (hMod <> INVALID_HANDLE_VALUE) then
  begin
    pf := GetProcAddress(hMod,'ShowPCBCutFrm');
    if pf <> nil then
      Result := pfShowPCBCutFrm(pf)(nil);
    FreeLibrary(hMod);
  end;
end;

procedure TForm2.Genesis2Click(Sender: TObject);
begin
  inputform.OpenDialog1.Filter:='(*.txt)|*.txt';
  inputform.OpenDialog1.Tag:=1;
  if inputform.OpenDialog1.Execute then
      inputform.ShowModal;
end;

procedure TForm2.N42Click(Sender: TObject);
begin
  try
   Form4:=TForm4.Create(Application);
   Form4.Caption:=IntToStr(StringGrid1.Row);
   Form4.ShowModal;
  finally
   Form4.Free;
  end;
end;

procedure TForm2.DBComboBox2Change(Sender: TObject);
begin
if dbcombobox2.ItemIndex=0 then
 begin
  dbedit17.Field.Value:=dbedit15.Field.Value;
  dbedit18.Field.Value:=dbedit16.Field.Value;
  dbedit21.Field.Value:=1;
  dbedit17.Enabled:=false;
  dbedit18.Enabled:=false;
  dbedit21.Enabled:=false;
  dbedit26.Field.Value:=dbedit28.Field.Value;
 end
else
 begin
  dbedit17.Enabled:=true;
  dbedit18.Enabled:=true;
  dbedit21.Enabled:=true;
 end;
end;

procedure TForm2.N44Click(Sender: TObject);
var
 i, rkey:integer;
 node:ttreenode;   //treeview�ؼ��Ľڵ����
 rkey0025:^integer;
begin
 if bitbtn11.Enabled then
 if messagedlg('�½���·��,�Ƿ��Զ���������?',mtconfirmation,[mbyes,mbno],0)=mryes then
  bitbtn11click(sender);

 try
  form_childpart:=tform_childpart.Create(application);
  if form_childpart.ads37.Filter<>'' then
  form_childpart.ads37.Filter:='';
  if form_childpart.ShowModal=mrok then
  try
   dm.ADOConnection1.BeginTrans;
    with form_childpart do
    begin
      rkey:=StrToInt(self.rkey25.Caption);
      with dm.ADOQuery1 do
       begin
        close;
        sql.Text:='select * from data0025 where rkey='+inttostr(rkey);
        open;
       end;
      dm.AQY0025.Close;
      dm.AQY0025.Parameters[0].Value:=0;
      dm.AQY0025.Open;
      ads37.Filter:='if_select = 1';
      ads37.First;
      node:=treeview1.Selected;
      while not  ads37.Eof do
      begin                    //ѭ���ڲ���ʹ��dm.ADOQuery1
       dm.AQY0025.Append;
       for i:=1 to dm.AQY0025.FieldCount-1 do
        dm.AQY0025.Fields[i].Value:=dm.ADOQuery1.FieldValues[dm.AQY0025.Fields[i].FieldName];
       dm.AQY0025MANU_PART_NUMBER.Value := dm.AQY0025MANU_PART_NUMBER.Value+'.'+ads37part_name.Value;
      // dm.AQY0025LAYERS.Value:=ads37LAYERS.Value;
       dm.AQY0025OPT_LOT_SIZE.Value:=ads37OPT_LOT_SIZE.Value;
       dm.AQY0025PARENT_PTR.Value:=dm.ADOQuery1.FieldValues['rkey'];
       dm.AQY0025CREATED_BY_EMPL_PTR.Value:=strtoint(user_ptr);
       dm.AQY0025CUSTPART_ENT_DATE.Value:=getsystem_date(dm.adoquery2,1);
       dm.AQY0025LAST_MODIFIED_DATE.Value:=getsystem_date(dm.adoquery2,1);
       dm.AQY0025LAST_MODIFIED_BY_PTR.Value:=strtoint(user_ptr);
       DM.AQY0025QTY_ON_HAND.VALUE:=0;
       DM.AQY0025BOM_STEP.VALUE:=0;
       dm.AQY0025.Post;
       with dm.ADOQuery2 do
        begin
         close;
         sql.Text:='update  data0025 '+
                   'set PARTS_NUM=isnull(PARTS_NUM,0)+1 '+
                   'where rkey='+inttostr(rkey);
         ExecSQL;
        end;

        new(rkey0025);
        rkey0025^:=dm.AQY0025RKEY.Value;
        node:=treeview1.Items.AddChildObject
        (node,dm.AQY0025MANU_PART_NUMBER.Value,rkey0025); //���Ӷ���ڵ�
        node.ImageIndex:=node.Level;  //Ϊ��һ��ڵ㶨��ͼ��
        node:=node.Parent;
        { //�ڴ�������Ҫ�����׼��������38,494  }

        with dm.ADOQuery3 do
         begin
          close;
          sql.Text:=
          'SELECT SOURCE_PTR, DEPT_PTR, DEF_ROUT_INST, STEP_NUMBER,OUTP_SPFC '+#13+
          'FROM Data0038'+#13+
          'where source_ptr='+inttostr(dm.AQY0025RKEY.Value);
          open;
         end;
        dm.ads494.Close;                      //�Ƴ̲���
        dm.ads494.Parameters[0].Value:=dm.AQY0025RKEY.Value;
        dm.ads494.Open;
        dm.ads494.Filter:='';
        with dm.ADOQuery2 do
         begin
           Close;
           SQL.Text:=' SELECT  STEP_NUMBER, DEPT_PTR, DEF_ROUT_INST '+
                      'FROM DATA0042 where part_name='+quotedstr(ads37part_name.Value)+
                      ' order by STEP_NUMBER';
           open;
         end;
        while not dm.ADOQuery2.Eof do
        begin
          dm.ADOQuery3.AppendRecord([dm.AQY0025RKEY.Value,
                                     dm.ADOQuery2.FieldByName('DEPT_PTR').AsInteger,
                                     dm.ADOQuery2.FieldByName('DEF_ROUT_INST').AsString,
                                     dm.ADOQuery2.FieldByName('STEP_NUMBER').AsInteger,
                                     1]);
         dm.ADOQuery4.Close;   //=���ܸı�adoquery4�����
         dm.ADOQuery4.SQL.Text:=
          'SELECT TOP 100 PERCENT PARAMETER_PTR,TValue,Doc_Flag,after_flag,formula,'+#13+
          'flow_spfc_flag,SEQ_NO'+#13+
          'FROM dbo.Data0506'+#13+
          'WHERE TTYPE = 3 AND '+#13+
          'SOURCE_PTR = '+dm.ADOQuery2.FieldByName('DEPT_PTR').AsString+#13+
          'ORDER BY SEQ_NO';
         dm.ADOQuery4.Open;
          while not dm.ADOQuery4.Eof do
          begin
           dm.ads494.AppendRecord([dm.ADOQuery4.FieldValues['PARAMETER_PTR'],
                                   '',
                                   dm.AQY0025RKEY.Value,
                                   dm.ADOQuery2.FieldByName('STEP_NUMBER').AsInteger,
                                   dm.ADOQuery4.FieldValues['SEQ_NO'],
                                   dm.ADOQuery4.FieldValues['Doc_Flag'],
                                   dm.ADOQuery4.FieldValues['after_flag'],
                                   dm.ADOQuery4.FieldValues['flow_spfc_flag']]);
           dm.ADOQuery4.Next;
          end;                  //=======���ܸı�adoquery4�����
         dm.ADOQuery2.Next;
        end;
        dm.ads494.UpdateBatch();
        ads37.Next;
      end;
      dm.AQY0025.Close;
      dm.AQY0025.Parameters[0].Value:=rkey;  //�򿪶���
      dm.AQY0025.Open;
      dm.ADOQuery1.Close;
    end;

   dm.ADOConnection1.CommitTrans;
   treeview1.FullExpand; //ȫ��չ��
   common.ShowMsg('��׼�Ӳ��������ɹ�!',1);
  except
   on E: Exception do
    begin
     dm.ADOConnection1.RollbackTrans;
     screen.Cursor:=crdefault;
     messagedlg(E.Message,mterror,[mbcancel],0);
    end;
  end;
 finally
  form_childpart.Free;
 end;
end;

procedure TForm2.DBEdit1Exit(Sender: TObject);
var
 node:ttreenode;   //treeview�ؼ��Ľڵ����
begin
 node:=treeview1.Selected;
 node.Text:=DBEdit1.Text;
end;

procedure TForm2.StringGrid2KeyPress(Sender: TObject; var Key: Char);
begin
if StringGrid2.Col in [10,11,12] then
 begin
  if not (key in ['0'..'9','.',#8,#13]) then abort;
  if key = chr(46) then      //�ж��Ƿ��ظ�����С����'.'
   if pos('.',StringGrid2.Cells[StringGrid2.col,StringGrid2.row]) > 0  then abort;
 end;
end;

procedure TForm2.load_xls_to_sgrid(fileName:String; grid:TStringGrid);
var //��Excel�ж�ȡ���ݵ� Grid
  iCount, jCount: Integer;
  XLApp: variant;
  Sheet: Variant;
begin
  Screen.Cursor := crHourGlass;
  if not VarIsEmpty(XLApp) then
   begin
    XLApp.DisplayAlerts := False;
    XLApp.Quit;
    VarClear(XLApp);
   end;
  try
   XLApp := CreateOleObject('Excel.Application'); //����OLE����
  except
   Screen.Cursor := crDefault;
   Exit;
  end;
   try
     XLApp.workBooks.Open(fileName);
     Sheet := XLApp.Workbooks[1].WorkSheets[1];
     for iCount:=2 to 65535 do
      begin
       if trim(XLApp.workbooks[1].sheets[1].cells[iCount,1]) = '' then
         break
       else
        begin
         grid.RowCount:=grid.RowCount+1;
        for jCount:=1 to grid.ColCount do
   //    grid.Cells[jCount-1,iCount-1]:=XLApp.workbooks[1].sheets[1].cells[iCount,jCount];
         grid.Cells[jCount-1,iCount-1]:=sheet.cells[iCount,jCount];
        end;
      end;
     XLApp.workbooks[1].close;
   finally
     XLApp.quit;
     Screen.Cursor := crDefault;
   end
end;

procedure TForm2.StringGrid3KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
IF (KEY=13) and (Stringgrid3.row<stringgrid3.RowCount-1) then
Stringgrid3.row:=Stringgrid3.row+1;
if (chr(key)='D') and (ssCtrl in shift) and (stringgrid3.Row>1) then
begin
stringgrid3.Cells[stringgrid3.col,stringgrid3.row]:=
stringgrid3.Cells[stringgrid3.col,stringgrid3.row-1];
end;
end;

procedure TForm2.ComboBox2Change(Sender: TObject);
begin
stringgrid3.Cells[1,stringgrid3.Row]:=combobox2.Text;
end;

procedure TForm2.ComboBox2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key=112 then combobox2.DroppedDown:=true; //F1����������
if key=13 then stringgrid3.SetFocus;
end;

procedure TForm2.StringGrid3DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
begin
if (gdSelected  in State) then
 begin
  if (ACol =1) then
   begin
    ComboBox2.Left := Rect.Left+1;
    ComboBox2.Top := Rect.Top+2;
    ComboBox2.Width := Rect.Right - Rect.Left+3;
    ComboBox2.Height := Rect.Bottom - Rect.Top;
    ComboBox2.Visible := True;
    if StringGrid3.Cells[acol,arow]<>'' then
     combobox2.ItemIndex:=combobox2.Items.IndexOf(StringGrid3.Cells[acol,arow])
    else
     combobox2.ItemIndex:=-1;
   end
  else
    ComboBox2.Visible :=false;
 end;


if (acol=0) and (ARow>0) and
   (ARow<>StringGrid3.RowCount-1) then
 StringGrid3.Canvas.TextRect(rect,rect.Left+2,rect.Top+2, inttostr(ARow));

end;

procedure TForm2.StringGrid3KeyPress(Sender: TObject; var Key: Char);
begin
if StringGrid3.Col in [2,3,4,5,6,7] then
 begin
  if not (key in ['0'..'9','.',#8,#13]) then abort;
  if key = chr(46) then      //�ж��Ƿ��ظ�����С����'.'
   if pos('.',StringGrid3.Cells[StringGrid3.col,StringGrid3.row]) > 0  then abort;
 end;
end;

procedure TForm2.StringGrid3SelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
  var
  R:TRect;
begin
 IF ACOL=1 THEN
   stringgrid3.Options:=stringgrid3.Options-[goEditing]
 else
   stringgrid3.Options:=stringgrid3.Options+[goEditing];

   ComboBox2.Visible:=(ACol=1);

end;

procedure TForm2.StringGrid3KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if (stringgrid3.Row=stringgrid3.RowCount-1) and
   (trim(stringgrid3.Rows[stringgrid3.Row].Text)<>'') then
 begin
  stringgrid3.Cells[0,stringgrid3.Row]:=inttostr(stringgrid3.Row);
  stringgrid3.RowCount:=stringgrid3.RowCount+1;
  if not bitbtn11.Enabled then bitbtn11.Enabled:=true;
 end;
end;

function TForm2.find_33null:boolean;
var i:integer;
begin
result:=true;
  if StringGrid3.RowCount>2 then
  begin
    for i:=1 to StringGrid3.RowCount-2 do
    begin
      if (trim(StringGrid3.Cells[2,i])='') or
         (trim(StringGrid3.Cells[3,i])='') or
         (trim(StringGrid3.Cells[4,i])='') or
         (trim(StringGrid3.Cells[5,i])='') or
         (trim(StringGrid3.Cells[6,i])='') then
      begin
        showmessage('ѹ�ϰоر����ʧ��!�п�ֵ,����������!');
        result:=false;
        break;
      end;
    end;
  end;
end;

procedure TForm2.MenuItem1Click(Sender: TObject);
var
  i:word;
begin
 for i:=stringgrid3.Row to stringgrid3.RowCount-2 do
  stringgrid3.Rows[i].Text:=stringgrid3.Rows[i+1].Text;
  stringgrid3.RowCount:=stringgrid3.RowCount-1;
if not bitbtn11.Enabled then bitbtn11.Enabled:=true;
end;

procedure TForm2.MenuItem2Click(Sender: TObject);
var i:integer;
begin
if messagedlg('ɾ��ȫ��ѹ�ϰо���Ϣ,ԭ���ݽ���ʧ������?',mtconfirmation,[mbyes,mbno],0)=mryes then
 begin
  for i:=1 to stringgrid3.RowCount-2 do  stringgrid3.Rows[i].Clear;
   stringgrid3.RowCount:=2;
  if not bitbtn11.Enabled then bitbtn11.Enabled:=true;
 end;
end;

procedure TForm2.MenuItem3Click(Sender: TObject);
var i:integer;
begin
 strow:=tstringlist.Create;
 strow.AddStrings(StringGrid3.Rows[stringgrid3.row]);
 for i:=2 to StringGrid3.ColCount-1 do
 begin
  StringGrid3.Cells[i,stringgrid3.row]:=StringGrid3.Cells[i,stringgrid3.row-1];
  StringGrid3.Cells[i,stringgrid3.row-1]:=strow.Strings[i];
 end;
 strow.Destroy;
 stringgrid3.row:=stringgrid3.row-1;
 if not bitbtn11.Enabled then bitbtn11.Enabled:=true;
end;

procedure TForm2.MenuItem4Click(Sender: TObject);
var i:integer;
begin
 strow:=tstringlist.Create;
 strow.AddStrings(self.StringGrid3.Rows[stringgrid3.row]);
 for i:=2 to StringGrid3.ColCount-1 do
 begin
  StringGrid3.Cells[i,stringgrid3.row]:=StringGrid3.Cells[i,stringgrid3.row+1];
  StringGrid3.Cells[i,stringgrid3.row+1]:=strow.Strings[i];
 end;
 strow.Destroy;
 stringgrid3.row:=stringgrid3.row+1;
 if not bitbtn11.Enabled then bitbtn11.Enabled:=true;
end;

procedure TForm2.PopupMenu13Popup(Sender: TObject);
begin
if stringgrid3.Row = stringgrid3.RowCount-1 then
 begin
  MenuItem1.Enabled:=false;
  MenuItem4.Enabled:=false;
 end
else
 begin
  MenuItem1.Enabled:=true;
  MenuItem4.Enabled:=true;
 end;
 if stringgrid3.Row=1 then
  MenuItem3.Enabled:=false
 else
  MenuItem3.Enabled:=true;
 MenuItem2.Enabled:=stringgrid3.RowCount>2;
end;

procedure TForm2.BitBtn27Click(Sender: TObject);
var
 i:integer;
begin
if stringgrid3.RowCount>2 then
begin
 for i:=1 to stringgrid3.RowCount-2 do
  stringgrid3.Cells[0,i]:=inttostr(i);
 Export_Grid_to_Excel(STRINGGRID3,DBtext3.Caption,true);
end;
end;

procedure TForm2.BitBtn28Click(Sender: TObject);
var
 i:integer;
begin
  OpenDialog1.DefaultExt :='*.XLS';
  OpenDialog1.Filter :='*.XLS|*.XLS';
  if OpenDialog1.Execute then
  if messagedlg('�����µ�ѹ�ϰоر�,ԭ���ݽ���ʧ������?',mtconfirmation,[mbyes,mbno],0)=mryes then
   begin
    for i:=1 to stringgrid3.RowCount-2 do  stringgrid3.Rows[i].Clear;
     stringgrid3.RowCount:=2;
    self.load_xls_to_sgrid(OpenDialog1.FileName,stringgrid3);
   end;
end;

procedure TForm2.Action1Execute(Sender: TObject);
begin
   if BitBtn11.Enabled = True then
    BitBtn11Click(Sender);
end;

procedure TForm2.Action2Execute(Sender: TObject);
begin
  if BitBtn1.Enabled = True then
    BitBtn1Click(Sender);
end;

procedure TForm2.Action3Execute(Sender: TObject);
begin
   MI1Click(Sender);
end;

procedure TForm2.BitBtn26Click(Sender: TObject);
var myjpg:Tjpegimage;
    mybmp:Tbitmap;
    infile,inext:string;
    stream:TMemoryStream;
begin
  OpenDialog1.Filter :='BMP and JPG Images|*.bmp;*.jpg;*.jpeg';
  if OpenDialog1.Execute then
   begin
      if dm.ads502.RecordCount>0 then
       dm.ads502.Edit
      else
       dm.ads502.Append;
      dm.ads502source_ptr.Value:=dm.AQY0025RKEY.Value;

      infile:=OpenDialog1.FileName;
      inext:=uppercase(extractfileext(infile));
      if (inext='.JPG') or (inext='.JPEG') then  //����jpeg��ʽ�ļ�
      begin
        myjpg:=Tjpegimage.create;
        myjpg.LoadFromFile(infile);
        mybmp:=tbitmap.Create ;
        mybmp.Assign(myjpg);

        myjpg.JPEGNeeded;
        Stream:=TMemoryStream.Create;        
        myjpg.SaveToStream(stream);
        Stream.Position :=0;

       case PageControl1.ActivePageIndex of
        0:
        begin
         Image1.picture.Assign (mybmp);
         dm.ads502sheet_BMP.LoadFromStream(stream);
        end;
        1:
        begin
         Image2.picture.Assign (mybmp);
         dm.ads502pnl_bmp.LoadFromStream(stream);
        end;
        2:
        begin
         Image3.picture.Assign (mybmp);
         dm.ads502pnl2_bmp.LoadFromStream(stream);
        end;
       end;
        myjpg.Free ;
        mybmp.free;
        stream.Free;
      end
      else
      if inext='.BMP' then  //����bmp��ʽ�ļ�
      begin
        mybmp:=tbitmap.Create;
        mybmp.LoadFromFile (infile);

        myjpg:=tjpegimage.Create;
        myjpg.Assign(mybmp);

        myjpg.JPEGNeeded;
        Stream:=TMemoryStream.Create;
        myjpg.SaveToStream(stream);
        Stream.Position :=0;

       case PageControl1.ActivePageIndex of
        0:
        begin
         Image1.picture.Assign (mybmp);
         dm.ads502sheet_BMP.LoadFromStream(stream);
        end;
        1:
        begin
         Image2.picture.Assign (mybmp);
         dm.ads502pnl_bmp.LoadFromStream(stream);
        end;
        2:
        begin
         Image3.picture.Assign (mybmp);
         dm.ads502pnl2_bmp.LoadFromStream(stream);
        end;
       end;
        myjpg.Free ;
        mybmp.free;
        stream.Free;
      end;
     dm.ads502.Post;
   end;

end;

procedure TForm2.SaveData();
begin
      if dm.AQY0025PARENT_PTR.Value > 0 then  //�ڲ�
     begin
      if dm.AQY0025QTY_BOM.Value <= 0 then
      begin
       listbox1.ItemIndex:=0;
       notebook1.PageIndex:=listbox1.ItemIndex+1;
       messagedlg('ѹ�ϱ�����������!',mterror,[mbcancel],0);
       DBEDIT33.SetFocus;
       exit;
      end;

      if dm.AQY0025QTY_PARENTBOM.Value <= 0 then
      begin
       listbox1.ItemIndex:=0;
       notebook1.PageIndex:=listbox1.ItemIndex+1;
       messagedlg('ѹ�ϱ�����������!',mterror,[mbcancel],0);
       DBEDIT34.SetFocus;
       exit;
      end;
     end;
       dm.ADOConnection1.BeginTrans;
      try
       dm.AQY0025ANALYSIS_CODE_5.Value:=dm.AQY0025pcs_lngth.AsString+'mm X '+
                                        dm.AQY0025pcs_width.AsString+'mm';
       dm.AQY0025ANALYSIS_CODE_1.Value:=dm.AQY0025set_lngth.AsString+'mm X '+
                                        dm.AQY0025set_width.AsString+'mm';
      // dm.AQY0025ANALYSIS_CODE_4.Value:=dm.AQY0025spell_lngth.AsString+'mm X '+
      //                                  dm.AQY0025spell_width.AsString+'mm';

       update_quanju;
       dm.ads502.UpdateBatch();
       dm.ads279.UpdateBatch();
       dm.ADS279_0.UpdateBatch();

       self.update_deptcode(dm.AQY0025RKEY.Value);   //38
       self.update_tecparameter(dm.AQY0025RKEY.Value);  //�����Ƴ̲���494
       self.update_IESparameter(dm.AQY0025RKEY.Value);  //����IESѡ�ϲ���  497
      // if self.find_difficulty(dm.AQY0025RKEY.Value) then  //���Ҹ��Ѷ�(�Զ���ʶ)
      //  dm.AQY0025barcode_flag.Value:=1;

       if checkbox2.Checked then           //��±��
        dm.AQY0025current_rev.Value:='Y'
       else
        dm.AQY0025current_rev.Value:='N';

       dm.AQY0025.Post;
       if_post:=true;
       self.update_drill(dm.AQY0025RKEY.Value);  //������ױ�
       self.update_target(dm.AQY0025RKEY.Value); //����ѹ�ϰоر�
       if dm.AQY0025PARENT_PTR.Value=0  then       //���㱣��
       begin
        self.update_ecnlist(dm.AQY0025RKEY.Value); //����ecn������
        self.update_filename;  //���¹�������ĵ�
        self.update_impedance(dm.AQY0025RKEY.Value); //�����迹
       end;
       dm.ADOConnection1.CommitTrans;

       dm.ADS38.Close;
       dm.ADS38.Open;
       dm.ads494.Close;
       dm.ads494.Open;

       dm.ads497.Close;
       dm.ads497.Open;

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
 
procedure TForm2.btnTBClick(Sender: TObject);
var
  L25RKey, LArr25RKey: string;
  LSql: string;
  I: Integer;
begin
  if MessageBox(Handle,'ͬ��','ȷ��Ҫͬ�������ڲ���?',MB_YESNO) = IDNO then Exit;
  if TreeView1.Selected <> nil then
  begin
    if TreeView1.Selected.Level <> 0 then
    begin
      ShowMessage('��ѡ�������Ȼ��ͬ��');
      Exit;
    end;
//    BitBtn11Click(BitBtn11);
    L25RKey := IntToStr(PInteger(TreeView1.Selected.Data)^);
    LSql := 'SELECT D1.RKey AS R1,D2.RKey AS R2,D3.Rkey AS R3,D4.RKey AS R4 FROM Data0025 D1 ' +
            'LEFT JOIN Data0025 D2 ON D1.Rkey = D2.PARENT_PTR ' +
            'LEFT JOIN Data0025 D3 ON D2.RKey = D3.PARENT_PTR ' +
            'LEFT JOIN Data0025 D4 ON D3.RKey = D4.PARENT_PTR ' +
            'WHERE D1.RKey = ' + L25RKey;
    if OpenQuery(DM.qryTmp,LSql) then
    begin
      DM.qryTmp.First;
      while not DM.qryTmp.Eof do
      begin
        for I := 1 to 4 do
        begin
          if not VarIsNull(DM.qryTmp.FieldByName('R'+IntToStr(I)).Value) then
            LArr25RKey := LArr25RKey + DM.qryTmp.FieldByName('R'+ IntToStr(I)).AsString + ',';
        end;
        DM.qryTmp.Next;
      end;
      LArr25RKey := '(' + LArr25RKey + '0)';
    end;
    LSql := 'UPDATE Data0025 SET pcs_lngth = ' + DBEdit15.Field.AsString +
      ' , pcs_width = ' + DBEdit16.Field.AsString +
      ' , set_lngth = ' + DBEdit17.Field.AsString +
      ' , set_width = ' + DBEdit18.Field.AsString +
      ' , spell_lngth = ' + DBEdit19.Field.AsString +
      ' , spell_width = ' + DBEdit20.Field.AsString +
      ' , pcs_sq = ' + DBEdit28.Field.AsString +
      ' , set_qty = ' + DBEdit21.Field.AsString +
      ' , spell_qty = ' + DBEdit22.Field.AsString +
      ' , unit_sq = ' + DBEdit26.Field.AsString +
      ' , spell_sq = ' + DBEdit27.Field.AsString +
      ' , SO_UNIT = ' + QuotedStr(DBComboBox2.Field.AsString) +
      ' WHERE RKey IN ' + LArr25RKey;
    try
      DM.ADOConnection1.BeginTrans;
      if ExecSql(DM.qryTmp, LSql) then
      begin
        DM.ADOConnection1.CommitTrans;
        ShowMessage('ͬ���ɹ�');
      end else
      begin
        DM.ADOConnection1.RollbackTrans;
        ShowMessage('ͬ��ʧ��');
        ShowMessage(LSql);
      end;
    except
      DM.ADOConnection1.RollbackTrans;
      ShowMessage('ͬ��ʧ��');
    end;
  end;

end;

end.
