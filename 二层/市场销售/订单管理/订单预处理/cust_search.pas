unit cust_search;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, Db, DBTables, Grids, DBGrids, Mask, Buttons, ADODB, ExtCtrls;

type
  TFrm_Cust = class(TForm)
    DBGrid1: TDBGrid;
    Label1: TLabel;
    BitBtn2: TBitBtn;
    Edit1: TEdit;
    Button1: TButton;
    Button2: TButton;
    DataSource1: TDataSource;
    RadioGroup1: TRadioGroup;
    ADOQuery1: TADOQuery;
    ADOQuery1rkey: TAutoIncField;
    ADOQuery1cust_code: TStringField;
    ADOQuery1customer_name: TStringField;
    ADOQuery1currency_ptr: TIntegerField;
    ADOQuery1cod_flag: TStringField;
    ADOQuery1CONTACT_NAME_1: TStringField;
    ADOQuery1CONTACT_NAME_2: TStringField;
    ADOQuery1CONTACT_NAME_3: TStringField;
    ADOQuery1CONTACT_NAME_4: TStringField;
    ADOQuery1CONTACT_NAME_5: TStringField;
    ADOQuery1CONTACT_NAME_6: TStringField;
    ADOQuery1INTERNAL_ECN_COUNT: TSmallintField;
    ADOQuery1EXTERNAL_ECN_COUNT: TSmallintField;
    ADOQuery1EDI_FLAG_FOR_INVOICE: TSmallintField;
    ADOQuery1reg_tax_fixed_unused: TStringField;
    ADOQuery1credit_rating: TWordField;
    ADOQuery1credit_limit: TFloatField;
    ADOQuery1EDI_FLAG_FOR_SOACK: TSmallintField;
    ADOQuery1FED_TAX_ID_NO: TStringField;
    procedure DBGrid1DblClick(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure RadioGroup1Click(Sender: TObject);
    private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Frm_Cust: TFrm_Cust;

implementation
uses demo;
{$R *.DFM}

procedure TFrm_Cust.DBGrid1DblClick(Sender: TObject);
begin
if not adoquery1.IsEmpty then modalresult := mrok;
end;

procedure TFrm_Cust.BitBtn2Click(Sender: TObject);
begin
 edit1.Text := '';
 edit1.SetFocus;
end;

procedure TFrm_Cust.Edit1Change(Sender: TObject);
begin
 IF trim(EDIT1.TEXT)<>'' THEN
  if radiogroup1.ItemIndex=0 then
   ADOQuery1.Filter := 'Cust_code like ''%'+Trim(Edit1.Text)+'%'''
  else
   adoQUERY1.Filter:='customer_name like ''%'+trim(edit1.text)+'%'''
 ELSE
  adoQUERY1.FILTER:='';
if adoquery1.IsEmpty then
 button1.Enabled := false
else
 button1.Enabled := true;  
end;

procedure TFrm_Cust.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if (key=13) and (not adoquery1.IsEmpty) then  modalresult:=mrok;
  if key=27 then self.ModalResult:=mrCancel;
end;

procedure TFrm_Cust.RadioGroup1Click(Sender: TObject);
begin
if radiogroup1.ItemIndex=0 then
 label1.Caption := '�ͻ�����'
else
 label1.Caption := '�ͻ�����';
 
edit1.SetFocus;

end;

end.
