unit mrb_reworked;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGridEh, ExtCtrls, DB, ADODB, StdCtrls, Buttons;

type
  TForm_MRBREWORKED = class(TForm)
    ads414: TADODataSet;
    DataSource1: TDataSource;
    ads414rkey: TIntegerField;
    ads414custpart_ptr: TIntegerField;
    ads414number: TStringField;
    ads414sys_date: TDateTimeField;
    ads414CUST_CODE: TStringField;
    ads414MANU_PART_NUMBER: TStringField;
    ads414MANU_PART_DESC: TStringField;
    ads414ABBR_NAME: TStringField;
    Panel1: TPanel;
    Panel2: TPanel;
    DBGridEh1: TDBGridEh;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label1: TLabel;
    Edit1: TEdit;
    BitBtn3: TBitBtn;
    ads414qty_to_be_reworked: TIntegerField;
    ads414OPT_LOT_SIZE: TIntegerField;
    ads414EST_SCRAP: TFloatField;
    ads414CUSTOMER_PTR: TIntegerField;
    ads414qty_rece: TIntegerField;
    procedure BitBtn3Click(Sender: TObject);
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
    procedure FormActivate(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure DBGridEh1TitleClick(Column: TColumnEh);
    procedure DBGridEh1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGridEh1DblClick(Sender: TObject);
  private
    { Private declarations }
    PreColumn: TColumnEh;
  public
    { Public declarations }
  end;

var
  Form_MRBREWORKED: TForm_MRBREWORKED;

implementation

uses damo;

{$R *.dfm}

procedure TForm_MRBREWORKED.BitBtn3Click(Sender: TObject);
begin
edit1.Text:='';
end;

procedure TForm_MRBREWORKED.DataSource1DataChange(Sender: TObject;
  Field: TField);
begin
if ads414.IsEmpty then
 bitbtn1.Enabled := false
else
 bitbtn1.Enabled := true;
end;

procedure TForm_MRBREWORKED.FormActivate(Sender: TObject);
begin
 self.ads414.Open;
 PreColumn := DBGridEH1.Columns[0];
end;

procedure TForm_MRBREWORKED.Edit1Change(Sender: TObject);
begin
if (trim(edit1.Text)<> '')  then
 ADS414.Filter:=PreColumn.FieldName+' like ''%'+trim(edit1.Text)+'%'''
else
 ADS414.Filter:='';
end;

procedure TForm_MRBREWORKED.DBGridEh1TitleClick(Column: TColumnEh);
begin
 if column.Title.SortMarker =smDownEh then
  begin
   column.Title.SortMarker:=smUpEh;
   ads414.IndexFieldNames:=Column.FieldName;
  end
 else
  begin
   column.Title.SortMarker:=smDownEh;
   ads414.IndexFieldNames:=Column.FieldName+' DESC';
  end;

if (column.ReadOnly) and (PreColumn.FieldName<>column.FieldName) then
 begin
  label1.Caption:=column.Title.Caption;
  edit1.SetFocus;
  PreColumn.Title.Color := clBtnFace;
  Column.Title.Color := clred;
  PreColumn := column;
 end
else
 edit1.SetFocus;

end;

procedure TForm_MRBREWORKED.DBGridEh1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if (chr(key)='V') and (ssalt in shift) then
  showmessage(ads414.CommandText);

if (key=13) and (not ads414.IsEmpty) then  modalresult:=mrok;  
end;

procedure TForm_MRBREWORKED.DBGridEh1DblClick(Sender: TObject);
begin
if not ads414.IsEmpty then modalresult := mrok;
end;

end.
