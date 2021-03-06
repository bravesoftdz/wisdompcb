unit remaout_form;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, Grids, StdCtrls, Mask, DBCtrls, ExtCtrls, ComCtrls,
  Buttons;

type
  TForm_remaout = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    dt1: TDateTimePicker;
    Edit2: TEdit;
    Panel2: TPanel;
    Button1: TButton;
    Button2: TButton;
    SGrid1: TStringGrid;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N3: TMenuItem;
    SGrid2: TStringGrid;
    N2: TMenuItem;
    key15: TLabel;
    key16: TLabel;
    edit1: TEdit;
    Edit3: TEdit;
    BitBtn1: TBitBtn;
    Label2: TLabel;
    key34: TLabel;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    procedure FormShow(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure SGrid1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Button1Enter(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Edit3Exit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_remaout: TForm_remaout;

implementation

uses main,damo,unit_outser,unit_numedit, Unit_numout, Unit_deptser
,common;
{$R *.dfm}

procedure TForm_remaout.FormShow(Sender: TObject);
begin
 sgrid1.Cells[0,0]:='余料编号';
 sgrid1.Cells[1,0]:='余料规格';
 sgrid1.Cells[2,0]:='纬向';
 sgrid1.Cells[3,0]:='经向';
 sgrid1.Cells[4,0]:='出仓数量';
 sgrid1.Cells[5,0]:='库存数量';
 dt1.DateTime:=strtodatetime(form1.sys_time);
 dm.ADO557add.Open;
 dm.ADO558add.Open;
 form_outser:=tform_outser.Create(self);
end;

procedure TForm_remaout.N1Click(Sender: TObject);
begin
 if self.ComboBox2.Text='' then
 begin
 ShowMessage('请先选择材料仓库!');
 exit;
 end;
 if (trim(sgrid1.Cells[0,1])='')and (sgrid1.RowCount=2)then
 begin
 form_outser.ADOQuery1.Close;
 form_outser.ADOQuery1.Parameters[0].Value:=strtoint(key15.Caption);
 form_outser.ADOQuery1.Parameters[1].Value:=strtoint(key16.Caption);
 form_outser.ADOQuery1.Open;
 end;
 form_outser.ShowModal;
end;

procedure TForm_remaout.N2Click(Sender: TObject);
begin
try
 form_numedit:=tform_numedit.Create(application);
 with form_numedit do
 begin
  edit1.Text:=self.SGrid1.Cells[0,self.SGrid1.Row];
  edit2.Text:=self.SGrid1.Cells[1,self.SGrid1.Row];
  edit3.Text:=self.SGrid1.Cells[2,self.SGrid1.Row];
  edit4.Text:=self.SGrid1.Cells[3,self.SGrid1.Row];
  edit5.Text:=self.SGrid1.Cells[4,self.SGrid1.Row];
  edit6.Text:=self.SGrid1.Cells[5,self.SGrid1.Row];
  edit1.Enabled:=false;
  edit2.Enabled:=false;
  edit3.Enabled:=false;
  edit4.Enabled:=false;
 end;
 if (form_numedit.ShowModal=mrok) then
 begin
    
 end;
  if form_numedit.Edit5.Modified then
   self.SGrid1.Cells[4,self.SGrid1.Row]:=form_numedit.Edit5.Text;
finally
 form_numedit.Free;
end;
end;

procedure TForm_remaout.N3Click(Sender: TObject);
begin
if (sgrid1.RowCount<=2)and(trim(sgrid1.Cells[0,1])<>'') then
 begin
  sgrid1.Rows[1].Text:='' ;
  sgrid2.Rows[1].Text:='' ;
 end
else if sgrid1.RowCount>2 then
 begin
  form1.GridRemoveRow(sgrid1,sgrid1.Row+1);
  form1.GridRemoveRow(sgrid2,sgrid1.Row+1);
 end;
end;

procedure TForm_remaout.ComboBox1Change(Sender: TObject);
begin
 with dm.ADOQ do
 begin
  close;
  sql.Clear;
  sql.Add('select rkey from data0015');
  sql.Add('where abbr_name ='''+trim(combobox1.Text)+'''');
  open;
  key15.Caption:=fieldbyname('rkey').AsString;
 end;
end;

procedure TForm_remaout.ComboBox2Change(Sender: TObject);
begin
 with dm.ADOQ do
 begin
 close;
 sql.Clear;
 sql.Add('select rkey from data0016');
 sql.Add('where location='''+trim(combobox2.Text)+'''');
 open;
 self.key16.Caption:=fieldbyname('rkey').AsString;
 end;
end;

procedure TForm_remaout.Button1Click(Sender: TObject);
var
 i:byte;
 v_total :integer;
begin
 try
  v_total:=0;
//============================判断输入编号是否重复==============================
    if form1.find_error(trim(edit1.text)) then
   if messagedlg('入仓编号重复,可能有多台计算机同时新增,是否自动更新编号?',mtConfirmation,
   [mbYes,mbNo],0)=mrYes  then
   begin
    dm.adoout04.Close;
    dm.adoout04.Open;
    edit1.Text:=dm.adoout04SEED_VALUE.Value;
   end
  else
   begin
    edit1.SetFocus;
    exit;
   end;

 dm.ADOConnection1.BeginTrans;
 form_outser.ADOQuery1.Cancel;
 if trim(sgrid1.Cells[0,1])<>'' then
 for i:=1 to sgrid1.RowCount-1 do  v_total:=v_total+strtoint(sgrid1.Cells[4,i]);

 //==========================增加data0558的记录=================================
 with dm.ADO558add do
 begin
  append;
  dm.ADO558addrema_number.Value:=edit1.Text;
  dm.ADO558addQUAN_ON_HAND.Value:=v_total;
  dm.ADO558addRKEY15.AsString:=key15.Caption;
  dm.ADO558addRKEY16.AsString:=key16.Caption;
  dm.ADO558addremark.Value:=edit2.Text;
  dm.ADO558addttype.Value:=2;
  dm.ADO558addkey34.AsString:=key34.Caption;
  dm.ADO558addtdate.Value:=dt1.DateTime;
  dm.ADO558addempl_by_ptr.AsString:= user_ptr;
  post;
 end;

 form1.update_04out(edit1.Text);     //更新数据库data0004

 if trim(sgrid1.Cells[0,1])<>'' then
 for i:=1 to sgrid1.RowCount-1 do
 begin
 //=========================减少data0556的记录==================================
  with dm.ADOQ do
  begin
   close;
   sql.Clear;
   sql.Add('select quan_on_hand from data0556');
   sql.Add('where rkey='+sgrid2.Cells[0,i]);
   open;
   edit;
   dm.ADOQ.FieldByName('quan_on_hand').Value:=dm.ADOQ.FieldByName('quan_on_hand').Value
                                              -strtoint(SGrid1.Cells[4,i]) ;
   post;
 end;
 //=========================增加data0557的记录===================================
  with dm.ADO557add do
  begin
   append;
   dm.ADO557addD558_PTR.AsString:=dm.ADO558addRKEY.AsString;
   dm.ADO557addNUMBER.AsString:=sgrid1.Cells[4,i];
   dm.ADO557addD556_PTR.AsString:=sgrid2.Cells[0,i];
   dm.ADO557addquan_on_hand.Value:=dm.ADOQ.FieldByName('quan_on_hand').Value;
   post;
  end;
 end; //对应for语句的begin
 dm.ADOConnection1.CommitTrans;
 except
 on e:exception do
 begin
  showmessage(e.Message);
  dm.ADOConnection1.RollbackTrans;
 end;
end;
 modalresult:=mrok;
 Form1.BitBtn2Click(Sender);
end;

procedure TForm_remaout.SGrid1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
 column,row:longint;//右键选择stringgrid控件的方法
begin
  {
if button=mbright then
 begin
  sgrid1.MouseToCell(x,y,column,row);
  if row<>0 then sgrid1.Row:=row;
 end; }
end;

procedure TForm_remaout.PopupMenu1Popup(Sender: TObject);
begin
 if (sgrid1.Row<=1)and (trim(sgrid1.Cells[0,1])='') then
 begin
  n2.Enabled:=false;
  n3.Enabled:=false;
 end
 else
  begin
  n2.Enabled:=true;
  n3.Enabled:=true;
  end;

end;

procedure TForm_remaout.Button2Click(Sender: TObject);
begin
self.Close;
end;

procedure TForm_remaout.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
form_outser.ADOQuery1.Close;
dm.ADO557add.Close;
dm.ADO558add.Close;
form_outser.Free;
end;

procedure TForm_remaout.Button1Enter(Sender: TObject);
begin
if trim(edit3.Text)=''then
 begin
  showmessage('请输入领料部门！');
  edit3.SetFocus;
  exit;
 end;
if (sgrid1.RowCount<=2) and (sgrid1.Cells[0,1]='') then
 begin
  showmessage('出仓记录为空，无法保存！');
  sgrid1.SetFocus;
  exit;
 end;
end;

procedure TForm_remaout.BitBtn1Click(Sender: TObject);
begin
try
 form_deptser:=tform_deptser.Create(application);
 if form_deptser.ShowModal=mrok then
 begin
 edit3.Text:=form_deptser.ADOQuery1dept_name.Value;
 self.key34.Caption:=form_deptser.ADOQuery1rkey.AsString;
 sgrid1.Setfocus;
 end;
finally
form_deptser.Free;
end;
end;

procedure TForm_remaout.Edit3Exit(Sender: TObject);
begin
 if trim(edit3.Text)<>'' then
 begin
  try form_deptser:=tform_deptser.create(application);
  if not form_deptser.ADOQuery1.Locate('dept_name',trim(edit3.Text),[]) then
   begin
   showmessage('请输入正确的部门名称！');
   edit3.SetFocus;
   end
 else
   self.key34.Caption:=form_deptser.ADOQuery1rkey.AsString;
 finally
 form_deptser.free;
 end;
 end;
end;

end.
