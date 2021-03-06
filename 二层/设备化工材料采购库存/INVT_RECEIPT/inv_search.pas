unit inv_search;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, Grids, DBGrids, StdCtrls, Buttons, ExtCtrls;

type
  Tform_inv = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    BitBtn1: TBitBtn;
    Button1: TButton;
    Button2: TButton;
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    RadioGroup1: TRadioGroup;
    ADOQuery1: TADOQuery;
    ADOQuery1RKEY: TIntegerField;
    ADOQuery1INV_PART_NUMBER: TStringField;
    ADOQuery1INV_PART_DESCRIPTION: TStringField;
    ADOQuery1manufacturer_name: TStringField;
    ADOQuery1PREF_SUPPLIER_PTR: TIntegerField;
    ADOQuery1stock_purch: TFloatField;
    ADOQuery1purch_unit_ptr: TIntegerField;
    ADOQuery1AVL_FLAG: TStringField;
    ADOQuery1INV_NAME: TStringField;
    ADOQuery1INV_DESCRIPTION: TStringField;
    ADOQuery1STOCK_UNIT_PTR: TIntegerField;
    ADOQuery1unit_code: TStringField;
    ADOQuery1unit_name: TStringField;
    ADOQuery1SHELF_LIFE: TSmallintField;
    procedure Edit1Change(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure RadioGroup1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  form_inv: Tform_inv;

implementation
uses  data_module;
{$R *.dfm}

procedure Tform_inv.Edit1Change(Sender: TObject);
begin
if trim(Edit1.text)<>'' then
 if radiogroup1.ItemIndex=0 then
  Adoquery1.Filter :='INV_PART_NUMBER like '''+Trim(Edit1.Text)+'%'''
 else
  Adoquery1.Filter :='INV_PART_description like ''%'+Trim(Edit1.Text)+'%'''
else
 Adoquery1.filter:=''; 
if adoquery1.IsEmpty then
 button1.Enabled:=false
else
 button1.Enabled:=true;
end;

procedure Tform_inv.BitBtn1Click(Sender: TObject);
begin
 edit1.Text :='';
 edit1.SetFocus;
end;

procedure Tform_inv.DBGrid1DblClick(Sender: TObject);
begin
if not adoquery1.IsEmpty then ModalResult:=mrok;
end;

procedure Tform_inv.DBGrid1KeyDown(Sender: TObject; var Key: Word;
 Shift: TShiftState);
begin
 if (key=13) and (not adoquery1.IsEmpty) then ModalResult:=mrok;
end;

procedure Tform_inv.RadioGroup1Click(Sender: TObject);
begin
 label1.Caption := radiogroup1.Items.Strings[radiogroup1.itemindex];
 edit1.SetFocus;
end;

end.
