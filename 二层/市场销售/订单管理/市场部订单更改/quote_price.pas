unit quote_price;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, Grids, DBGrids, StdCtrls, Buttons, ExtCtrls;

type
  TForm12 = class(TForm)
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    Button1: TButton;
    Button2: TButton;
    Edit1: TEdit;
    Label1: TLabel;
    BitBtn1: TBitBtn;
    RadioGroup1: TRadioGroup;
    aq85: TADOStoredProc;
    aq85RKEY: TIntegerField;
    aq85TNUMBER: TStringField;
    aq85CUST_NAME: TStringField;
    aq85CUST_PART_NO: TStringField;
    aq85Quote_type: TSmallintField;
    aq85ttype: TStringField;
    aq85quote_price: TFloatField;
    aq85quote_taxprice: TFloatField;
    aq85CURR_RATE: TFloatField;
    aq85CURR_NAME: TStringField;
    aq85EMPLOYEE_NAME: TStringField;
    aq85QTE_UNIT_PTR: TIntegerField;
    aq85TUNITS: TIntegerField;
    aq85vatax: TBCDField;
    aq85qte_unit: TStringField;
    aq85CURR_PTR: TIntegerField;
    procedure Button1Click(Sender: TObject);
    procedure Edit1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit1Change(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure aq85CalcFields(DataSet: TDataSet);
    procedure DataSource1DataChange(Sender: TObject; Field: TField);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form12: TForm12;

implementation

uses damo;

{$R *.dfm}

procedure TForm12.Button1Click(Sender: TObject);
begin
 if (not aq85.IsEmpty) then  modalresult:=mrok;
end;

procedure TForm12.Edit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key=13 then button1click(sender);
end;

procedure TForm12.Edit1Change(Sender: TObject);
begin
 IF trim(EDIT1.TEXT)<>'' THEN
  if radiogroup1.ItemIndex=0 then
   aq85.Filter := 'TNUMBER like '''+Trim(Edit1.Text)+'%'''
  else
   aq85.Filter := 'CUST_PART_NO like ''%'+trim(edit1.text)+'%'''
 ELSE
  aq85.FILTER:='';
end;

procedure TForm12.RadioGroup1Click(Sender: TObject);
begin
if radiogroup1.ItemIndex=0 then
 label1.Caption := '���۵���'
else
 label1.Caption := '��Ʒ�ͺ�';
 
edit1.SetFocus;
end;

procedure TForm12.BitBtn1Click(Sender: TObject);
begin
 edit1.Text := '';
 edit1.SetFocus;
end;

procedure TForm12.aq85CalcFields(DataSet: TDataSet);
begin
if self.aq85Quote_type.Value=0 then
 self.aq85ttype.Value:='��׼����'
else
 self.aq85ttype.Value:='ת������';
if self.aq85QTE_UNIT_PTR.Value=1 then
 self.aq85qte_unit.Value:='PCS'
else
 self.aq85qte_unit.Value:='SET';
end;

procedure TForm12.DataSource1DataChange(Sender: TObject; Field: TField);
begin
if aq85.IsEmpty then
 button1.Enabled := false
else
 button1.Enabled := true;
end;

end.
