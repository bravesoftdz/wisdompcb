unit uEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, DBCtrls, Mask,ConstVar, ComCtrls,common;

type
  TFormEdit = class(TForm)
    Panel1: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    Label_submitdet: TLabel;
    Label_submitperson: TLabel;
    Panel2: TPanel;
    Edit1: TEdit;
    Edit4: TEdit;
    BitBtn3: TBitBtn;
    Label71: TLabel;
    Edit17: TEdit;
    BitBtn14: TBitBtn;
    DBRadioGroup2: TDBRadioGroup;
    Memo2: TMemo;
    Memo1: TMemo;
    Memo3: TMemo;
    Label67: TLabel;
    Label25: TLabel;
    Label10: TLabel;
    dt1: TDateTimePicker;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label1: TLabel;
    Label8: TLabel;
    Edit9: TEdit;
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn14Click(Sender: TObject);
    procedure Edit9KeyPress(Sender: TObject; var Key: Char);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormEdit: TFormEdit;

implementation

uses part_search, uDM,Pick_Item_Single;

{$R *.dfm}

procedure TFormEdit.BitBtn3Click(Sender: TObject);
begin
 frmcustpart := tfrmcustpart.Create(application);
  with frmcustpart.ADOQuery1 do
  begin
    close;
    frmcustpart.ADOQuery1.SQL.Add(' and MANU_PART_NUMBER LIKE ''%'+Trim(edit4.Text)+'%'''); //and data0025.customer_ptr='+inttostr(dm.ADOQuery4.FieldValues['customer_ptr'])+' ORDER BY MANU_PART_NUMBER');
    open;
  end;
  frmcustpart.Edit1.Text:=trim(edit4.Text);
 if frmcustpart.ADOQuery1.IsEmpty then
  begin
   messagedlg('请输入正确的产品型号!',mtinformation,[mbok],0);
   edit4.SetFocus;
  end
  else
 if frmcustpart.ShowModal=mrok then
  if frmcustpart.ADOQuery1.FieldByName('onhold_sales_flag').AsString='1' then
    messagedlg('此产品型号已暂缓销售!',mtwarning,[mbcancel],0)
  else
   with dm.ADOQuery1 do
    begin
      close;
      sql.Clear;
      sql.Add('select ORIG_CUSTOMER from data0025 where MANU_PART_NUMBER='''+edit4.Text+'''');
      open;
    end;
   edit4.Text := trim(frmcustpart.ADOQuery1.fieldvalues['manu_part_number']);
   label71.Caption:=edit4.Text;
   edit4.Font.Color := clwindowtext;
   Edit17.Text:= dm.ADOQuery1.FieldByName('ORIG_CUSTOMER').AsString;
   Label67.Visible:=True;
   label67.Caption := frmcustpart.ADOQuery1.fieldbyname('manu_part_desc').AsString;
   label25.Caption:=frmcustpart.ADOQuery1.fieldbyname('rkey25').AsString;
end;

procedure TFormEdit.BitBtn14Click(Sender: TObject);
var
  InputVar: PDlgInput ;
begin
    frmPick_Item_Single := TfrmPick_Item_Single.Create(application) ;
  try
    InputVar.Fields := 'RKEY/序号/100,CUST_CODE/客户代码/100,CUSTOMER_NAME/客户名称/277,ABBR_NAME/客户简称/100';
    InputVar.Sqlstr := 'select RKEY,CUST_CODE,CUSTOMER_NAME,ABBR_NAME from Data0010 where CUSTOMER_TYPE<>4';
    InputVar.AdoConn := DM.ADOConnection1 ;
    frmPick_Item_Single.InitForm_New(InputVar)  ;
    if frmPick_Item_Single.ShowModal=mrok then
    begin
      Edit17.Text := frmPick_Item_Single.adsPick.FieldValues['ABBR_NAME'];
      Label10.Caption := frmPick_Item_Single.adsPick.FieldValues['RKEY'];
      Edit17.Font.Color:=clwindowtext;
    end;
  finally
    frmPick_Item_Single.adsPick.Close;
    frmPick_Item_Single.Free ;
  end;
end;

procedure TFormEdit.Edit9KeyPress(Sender: TObject; var Key: Char);
begin
 if not (key in ['0'..'9',#8,#13]) then  //判断是否输入数字
  abort
end;

procedure TFormEdit.SpeedButton2Click(Sender: TObject);
begin
close;
end;

procedure TFormEdit.SpeedButton1Click(Sender: TObject);
begin

try
 if  Edit4.Text='' then
  begin
    showmessage('请输入本厂编号...');
    Edit4.SetFocus;
    exit;
  end;

 dm.ADOConnection1.BeginTrans;  //开始一个会话期间

  dm.ADO0738.Close;
  dm.ADO0738.Open;
  dm.ADO0738.Append;
  dm.ADO0738AUDITED_ptr.AsString:=user_ptr;
  dm.ADO0738FA_NUM.AsString:=Edit1.Text;
  dm.ADO0738RKEY25.Value:=StrToInt(Label25.caption);
  dm.ADO0738RKEY10.AsString:=Label10.caption;
  dm.ADO0738CreateDate.Value:=dt1.DateTime;
  dm.ADO0738Quality.Value:=strtoInt(Edit9.text);
  dm.ADO0738BasicTechnology.AsString:=Memo2.text;
  dm.ADO0738DifficultPoint.AsString:=Memo1.text;
  dm.ADO0738BEIZHU.AsString:=Memo3.text;
  dm.ADO0738FAStatus.Value:=0;
  dm.ADO0738.Post;
  ShowMsg('新增操作成功!',1); 
 dm.ADOConnection1.CommitTrans;
 except
 on e:exception do
 begin
  showmessage(e.Message);
  dm.ADOConnection1.RollbackTrans;
 end;
end;    
 modalresult:=mrok;


end;

end.

