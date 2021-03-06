unit dpment_search;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, Buttons, DB, ADODB;

type
  TForm_dept = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    BitBtn1: TBitBtn;
    DBGrid1: TDBGrid;
    Button1: TButton;
    Button2: TButton;
    DataSource1: TDataSource;
    ADOQuery1: TADOQuery;
    ADOQuery1rkey: TIntegerField;
    ADOQuery1dept_code: TStringField;
    ADOQuery1dept_name: TStringField;
    procedure Edit1Change(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
    procedure DBGrid1TitleClick(Column: TColumn);
  private
    { Private declarations }
   field_name:string; 
  public
    { Public declarations }
  end;

var
  Form_dept: TForm_dept;

implementation

uses damo;

{$R *.dfm}

procedure TForm_dept.Edit1Change(Sender: TObject);
begin
 IF trim(EDIT1.TEXT)<>'' THEN
  adoQUERY1.Filter:=self.field_name+' like ''%'+trim(EDIT1.TEXT)+'%'''
 ELSE
  adoQUERY1.FILTER:='';
end;

procedure TForm_dept.BitBtn1Click(Sender: TObject);
begin
 edit1.Text:='';
 edit1.SetFocus;
end;

procedure TForm_dept.DBGrid1DblClick(Sender: TObject);
begin
if  (not adoquery1.IsEmpty) then
 ModalResult:=mrok;
end;

procedure TForm_dept.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if (key=13) and (not adoquery1.IsEmpty) then  ModalResult:=mrok;
end;

procedure TForm_dept.FormCreate(Sender: TObject);
begin
 adoquery1.Open;
 field_name:=dbgrid1.Columns[0].FieldName;
end;

procedure TForm_dept.DataSource1DataChange(Sender: TObject; Field: TField);
begin
if adoquery1.IsEmpty then
 button1.Enabled:=false
else
 button1.Enabled:=true;
end;

procedure TForm_dept.DBGrid1TitleClick(Column: TColumn);
var
 i:integer;
begin

if (field_name<>column.FieldName) then
 begin
  for i:=0 to dbgrid1.Columns.Count-1 do
   dbgrid1.Columns[i].Title.Color:=clBtnface;
  column.Title.Color:=clRed;
  adoquery1.Sort:= column.FieldName;
  field_name:=column.FieldName;
  label1.Caption:=column.Title.Caption;
  edit1.SetFocus;  
 end;
end;

end.
