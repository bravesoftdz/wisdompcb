unit Report2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseForm, DB, ADODB, Menus, Grids, DBGridEh, StdCtrls, Buttons,
  ExtCtrls;

type
  TfrmReport2 = class(TfrmBaseForm)
    aqQueryINV_PART_NUMBER: TStringField;
    aqQueryINV_PART_DESCRIPTION: TStringField;
    aqQueryUNIT_NAME: TStringField;
    aqQueryGROUP_DESC: TStringField;
    aqQueryput_total: TBCDField;
    aqQuerySTOCK_SELL: TFloatField;
    aqQueryput_price: TBCDField;
    aqQueryREPORT_VALUE1: TFloatField;
    aqQueryput_notax: TBCDField;
    aqQuerytotal_weigth: TBCDField;
    aqQuerytotal_area: TFloatField;
    aqQueryWAREHOUSE_NAME: TStringField;
    procedure edtFilterChange(Sender: TObject);
    procedure btnQueryClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmReport2: TfrmReport2;

implementation

uses condition;

{$R *.dfm}

procedure TfrmReport2.edtFilterChange(Sender: TObject);
begin
  inherited;
  //此处不能删除,否则不触发父窗体的edtFilterChange
end;

procedure TfrmReport2.btnQueryClick(Sender: TObject);
var
  i:byte;
  vCondition: widestring;
begin
  inherited;
  with frmCondition do
  begin
    dtpk1.Date:= Now-7;
    dtpk2.Date:= Now;
    if ShowModal = mrok then
    begin
      with aqQuery do
      begin
        Close;
        Parameters[0].Value:= frmCondition.Link;
        for i:= 1 to frmCondition.SGrid1.RowCount - 2 do
          vCondition:= vCondition + frmCondition.SGrid1.Cells[2,i] + #13;
        Parameters[1].Value:= 'and t207.TDATE Between '''+formatdatetime('yyyy-mm-dd ',dtpk1.Date)+formatdatetime('hh:nn:ss',dtpk1_1.Time)+
                              ''' and '''+formatdatetime('yyyy-mm-dd ',dtpk2.Date)+formatdatetime('hh:nn:ss',dtpk2_2.Time)+''''+char(13)+vCondition;
        Parameters[2].Value:= 'Order By inv_part_number';
        Open;
      end;
    end;
  end;
end;

end.
