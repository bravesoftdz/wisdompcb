unit Unit_outser;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, StdCtrls, Buttons, ExtCtrls, Grids, DBGrids, DB, ADODB;

type
  TForm_outser = class(TForm)
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    Label1: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Edit1: TEdit;
    PopupMenu1: TPopupMenu;
    N8: TMenuItem;
    BitBtn3: TBitBtn;
    DataSource1: TDataSource;
    ADOQuery1: TADOQuery;
    ADOQuery1INV_DESCRIPTION: TStringField;
    ADOQuery1MAT_CODE: TStringField;
    ADOQuery1WEI_SIZE: TBCDField;
    ADOQuery1LEN_SIZE: TBCDField;
    ADOQuery1rkey: TAutoIncField;
    ADOQuery1QUAN_ON_HAND: TIntegerField;
    ADOQuery1REMARK: TStringField;
    ADOQuery1mat_desc: TStringField;
    key15: TLabel;
    ADOQuery1PeiLiaoDan: TStringField;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure FormShow(Sender: TObject);
  private
   field_name :string;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_outser: TForm_outser;

implementation

 uses damo,remaout_form, Unit_numin, Unit_numout, remain_form;
{$R *.dfm}

procedure TForm_outser.FormCreate(Sender: TObject);
begin
 field_name:='mat_code';
 self.ADOQuery1.Open;
end;

procedure TForm_outser.BitBtn1Click(Sender: TObject);
begin
self.Close;
end;

procedure TForm_outser.BitBtn2Click(Sender: TObject);
begin
 edit1.Text:='';
 edit1.SetFocus;
end;

procedure TForm_outser.N8Click(Sender: TObject);
begin
try
 form_numout:=tform_numout.Create(application);
 //==================== 给form_numout初始化 ====================================
 with form_numout do
 begin
  edit1.Text:=self.ADOQuery1MAT_CODE.Value;
  edit2.Text:=self.ADOQuery1mat_desc.Value;
  edit3.Text:=self.ADOQuery1LEN_SIZE.AsString;
  edit4.Text:=self.ADOQuery1WEI_SIZE.AsString;
  edit6.Text:=self.ADOQuery1QUAN_ON_HAND.AsString;
 end;
//=======================给form_remaout赋值=====================================
 if form_numout.ShowModal=mrok then
 begin
  if (form_remaout.SGrid1.RowCount>=2)and (form_remaout.SGrid1.Cells[0,1]<>'') then
   begin
    form_remaout.SGrid1.RowCount:=form_remaout.SGrid1.RowCount+1;
    form_remaout.SGrid2.RowCount:=form_remaout.SGrid2.RowCount+1;
   end;
   with form_remaout do
   begin
    sgrid1.Cells[0,sgrid1.RowCount-1]:=form_numout.Edit1.Text;
    sgrid1.Cells[1,sgrid1.RowCount-1]:=form_numout.Edit2.Text;
    sgrid1.Cells[2,sgrid1.RowCount-1]:=form_numout.Edit3.Text ;
    sgrid1.Cells[3,sgrid1.RowCount-1]:=form_numout.Edit4.Text ;
    sgrid1.Cells[4,sgrid1.RowCount-1]:=form_numout.Edit5.Text ;
    sgrid1.Cells[5,sgrid1.RowCount-1]:=form_numout.Edit6.Text ;
    sgrid2.Cells[0,sgrid1.RowCount-1]:=self.ADOQuery1rkey.AsString;
    sgrid2.Cells[1,sgrid1.RowCount-1]:=self.ADOQuery1QUAN_ON_HAND.AsString;//记录仓库的库存量
   end;
  self.ADOQuery1.Delete;
 end;
finally
  form_numout.Free;
end;
end;

procedure TForm_outser.Edit1Change(Sender: TObject);
begin
 if (trim(Edit1.text)<>'')and
  ((field_name='MAT_CODE') or (field_name='mat_desc') or (field_name='REMARK')or (field_name='PeiLiaoDan') ) then
  self.ADOQuery1.Filter := field_name+' like ''%'+trim(edit1.text)+'%'''
 else
  if trim(edit1.Text)<>''  then self.ADOQuery1.Filter:=field_name+'='+trim(edit1.Text)
 else
 self.ADOQuery1.filter:= '';
end;

procedure TForm_outser.DBGrid1TitleClick(Column: TColumn);
var
 i:byte;
begin
if (field_name<>column.FieldName)and (column.ReadOnly)  then
 begin
  label1.Caption:=column.Title.Caption;
  field_name:=column.FieldName;
  edit1.SetFocus;
  for i:=0 to dbgrid1.FieldCount-1 do
   if dbgrid1.Columns[i].Title.Color= clred then
    dbgrid1.Columns[i].Title.Color:= clbtnface;
  column.Title.Color:=clred;
 end
else
 edit1.SetFocus;
 self.ADOQuery1.Sort:=column.FieldName;
end;

procedure TForm_outser.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if (shift=[ssalt])and ((key=ord('s')) or (key=ord('S')))
then showmessage(adoquery1.SQL.Text);
end;

procedure TForm_outser.DBGrid1KeyPress(Sender: TObject; var Key: Char);
begin
 if key=#13 then form_outser.N8Click(sender);
end;

procedure TForm_outser.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
if ((field_name='WEI_SIZE') or (field_name='LEN_SIZE')or (field_name='QUAN_ON_HAND'))then
 if not (key in ['0'..'9',#8,#13]) then abort;
end;

procedure TForm_outser.FormShow(Sender: TObject);
begin
DBGrid1TitleClick(dbgrid1.Columns.Items[0]);
end;

end.
