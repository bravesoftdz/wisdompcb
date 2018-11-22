unit find_SALES_ORDER_Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, findUnit1, DB, ADODB, StdCtrls, Buttons, ExtCtrls, Grids,
  DBGridEh;

type
  Tfind_SALES_ORDER_Form2 = class(TfindForm1)
    ADOStoredProc1SALES_ORDER: TStringField;
    procedure Edit1Change(Sender: TObject);
    procedure Temp_DBGridEh1TitleBtnClick(Sender: TObject; ACol: Integer;
                                          Column: TColumnEh);
    procedure Button1Click(Sender: TObject);
    procedure Temp_DBGridEh1DblClick(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  find_SALES_ORDER_Form2: Tfind_SALES_ORDER_Form2;

implementation

{$R *.dfm}

procedure Tfind_SALES_ORDER_Form2.Edit1Change(Sender: TObject);
begin//���¼�ÿ�ζ�Ҫ�Ķ�
  inherited;
  self.EditDataChange(sender,ADOStoredProc1,'sales_order');

end;

procedure Tfind_SALES_ORDER_Form2.Temp_DBGridEh1TitleBtnClick(
  Sender: TObject; ACol: Integer; Column: TColumnEh);
begin//���¼�ÿ�ζ�Ҫ�Ķ�
  inherited;
  if not Temp_DBGridEh1.DataSource.DataSet.Active then exit;
  //���ֻ��һ����¼���������������
  if Temp_DBGridEh1.DataSource.DataSet.RecordCount <= 1 then exit;
  // self.TitleBtnSort1(sender,acol,column,adoquery,1)
  TitleBtnSort1(sender,acol,column,ADOStoredProc1);

  Label1.Caption :=self.vColumn1.Title.Caption;

end;

procedure Tfind_SALES_ORDER_Form2.Button1Click(Sender: TObject);
begin
  if ADOStoredProc1.RecordCount >0 then
    inherited;

end;
        
procedure Tfind_SALES_ORDER_Form2.Temp_DBGridEh1DblClick(Sender: TObject);
begin
  inherited;
  if ADOStoredProc1.RecordCount >0 then
     Button1Click(sender);
end;

procedure Tfind_SALES_ORDER_Form2.BitBtn1Click(Sender: TObject);
begin
  inherited;
  edit1.Text := '';
end;

end.
