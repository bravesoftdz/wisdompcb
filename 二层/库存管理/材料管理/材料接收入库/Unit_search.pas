unit Unit_search;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, Grids, DBGrids, StdCtrls, Buttons;

type
  Tform_unit = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    BitBtn1: TBitBtn;
    Button1: TButton;
    Button2: TButton;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    ADOQuery1: TADOQuery;
    ADOQuery1rkey: TIntegerField;
    ADOQuery1unit_code: TStringField;
    ADOQuery1unit_name: TStringField;
    procedure DBGrid1DblClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  form_unit: Tform_unit;

implementation
uses data_module;
{$R *.dfm}

procedure Tform_unit.DBGrid1DblClick(Sender: TObject);
begin
if not adoquery1.IsEmpty then ModalResult:=mrok;
end;

procedure Tform_unit.BitBtn1Click(Sender: TObject);
begin
 edit1.Text:='';
 edit1.SetFocus;
end;

procedure Tform_unit.Edit1Change(Sender: TObject);
begin
IF trim(EDIT1.TEXT)<>'' THEN
 adoQUERY1.Filter:='unit_code like '''+trim(EDIT1.TEXT)+'%'''
ELSE
 adoQUERY1.FILTER:='';
if adoquery1.IsEmpty then
 button1.Enabled:=false
else
 button1.Enabled:=true;
end;

procedure Tform_unit.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if (key=13) and (not adoquery1.IsEmpty) then ModalResult:=mrok;
end;

procedure Tform_unit.FormCreate(Sender: TObject);
begin
 adoquery1.Open;
if adoquery1.IsEmpty then
 button1.Enabled:=false
else
 button1.Enabled:=true; 
end;

end.
