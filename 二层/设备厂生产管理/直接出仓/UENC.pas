unit UENC;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, Grids, DBCtrlsEh, DBCtrls, StdCtrls, Mask, Buttons,
  ExtCtrls, ComCtrls;

type
  TNEC_Form = class(TForm)
    Panel1: TPanel;
    BitBtn9: TBitBtn;
    BtnSave: TBitBtn;
    Panel2: TPanel;
    Label1: TLabel;
    Label3: TLabel;
    Label7: TLabel;
    Label4: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label15: TLabel;
    Label18: TLabel;
    MaskEdit1: TMaskEdit;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    SGrid1: TStringGrid;
    flag_Lb: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    DateTimePicker1: TDateTimePicker;
    procedure N1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BtnSaveClick(Sender: TObject);
    procedure BtnSaveEnter(Sender: TObject);
  private
    function returen_rkey08(proc_code:string):integer;
    function returen_rkey16(loca_code: string): integer;
    procedure update_04(v_seed: string);
    function find_numbererror(number:string):boolean;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  NEC_Form: TNEC_Form;
  function Power(x, y : extended) : extended;
implementation

uses UPROD, UDM, UWZSB_060,common;

{$R *.dfm}

function TNEC_Form.find_numbererror(number:string):boolean;
begin
 result := false;
 with dm.ADOQuery1 do
  begin
   close;
   sql.Clear;
   sql.Add('select rkey from wzcp0060');
   sql.Add('where sales_order = '''+number+'''');
   open;
   if not IsEmpty then  result := true;
  end;
end;

procedure TNEC_Form.N1Click(Sender: TObject);
begin
Prod_Form:=tProd_Form.Create(application);
if Prod_Form.ShowModal=mrok then
 begin
    sgrid1.Cells[0,sgrid1.RowCount-1]:=Prod_Form.Edit1.Text;
    sgrid1.Cells[1,sgrid1.RowCount-1]:=Prod_Form.Label2.Caption;
    sgrid1.Cells[2,sgrid1.RowCount-1]:=Prod_Form.Edit3.Text;
    sgrid1.Cells[3,sgrid1.RowCount-1]:=Prod_Form.Edit4.Text;
    sgrid1.Cells[4,sgrid1.RowCount-1]:=Prod_Form.Edit8.Text;
    sgrid1.Cells[5,sgrid1.RowCount-1]:=Prod_Form.Edit7.Text;
    sgrid1.Cells[6,sgrid1.RowCount-1]:=Prod_Form.Edit2.Text;
    sgrid1.RowCount:=sgrid1.RowCount+1;
  end;
 Prod_Form.Free;
end;


procedure TNEC_Form.FormShow(Sender: TObject);
begin
sgrid1.Cells[0,0]:='��Ʒ����';
sgrid1.Cells[1,0]:='��Ʒ����';
sgrid1.Cells[2,0]:='�ֿ�';
sgrid1.Cells[3,0]:='��������';
sgrid1.Cells[4,0]:='���ÿ��';
sgrid1.Cells[5,0]:='��ע';
SGrid1.ColWidths[6]:=-1;
end;


procedure TNEC_Form.PopupMenu1Popup(Sender: TObject);
begin
if sgrid1.Row= sgrid1.RowCount-1 then
  n2.Enabled:=false
else
  n2.Enabled:=true;
end;

procedure TNEC_Form.N2Click(Sender: TObject);
var
 i:word;
begin
 for i:= sgrid1.Row to sgrid1.RowCount-2 do
   sgrid1.Rows[i]:=sgrid1.rows[i+1];

 sgrid1.RowCount:=sgrid1.RowCount-1;
end;

procedure TNEC_Form.FormActivate(Sender: TObject);
begin
if strtoint(self.flag_Lb.Caption)=0 then //����
 begin
  self.DateTimePicker1.Date:=now;
  dm.ADO04.Close;
  dm.ADO04.Open;
  if dm.ADO04SEED_FLAG.Value<>1 then
  MaskEdit1.Text:=dm.ADO04SEED_VALUE.Value;
 end
else     //�༭���߼��
 begin
  MaskEdit1.Text:=dm.ADS60sales_order.Value;
  self.DateTimePicker1.Date:=dm.ADS60sales_date.Value;
  edit1.Text:=  dm.ADS60location.Value;
  edit2.Text:=  dm.ADS60ship_method.Value;
  edit3.Text:=  dm.ADS60contact_name.Value;
  edit4.Text:=  dm.ADS60cont_phone.Value;
  edit5.Text:=dm.ADS60remark.Value;
  dm.ADS63.First;
  while not dm.ADS63.Eof do
   begin
    sgrid1.Cells[0,sgrid1.RowCount-1]:=dm.ADS63PROD_CODE.Value; //'��Ʒ����';
    sgrid1.Cells[1,sgrid1.RowCount-1]:=dm.ADS63PRODUCT_NAME.Value;// '��Ʒ����';
    sgrid1.Cells[2,sgrid1.RowCount-1]:=dm.ADS63LOCATION.Value;// '�ֿ�';
    sgrid1.Cells[3,sgrid1.RowCount-1]:= dm.ADS63quantity.AsString;// ���
    sgrid1.Cells[4,sgrid1.RowCount-1]:=dm.ADS63qty_onhand.AsString; // '��������';
    sgrid1.Cells[5,sgrid1.RowCount-1]:=dm.ADS63remark.Value; //'��ע';
    sgrid1.Cells[6,sgrid1.RowCount-1]:=dm.ADS63CODE.Value; //�ֿ����

    sgrid1.RowCount:=sgrid1.RowCount+1;
    dm.ADS63.Next;
   end;
    dm.ADS63.First;
  end;
end;

procedure TNEC_Form.update_04(v_seed: string);
var
 i,v_length:integer;
 v_last,new_seed:string;
begin
 dm.ado04.Close;
 dm.ado04.Open;
 if dm.ADO04SEED_FLAG.Value<>1 then
 begin
 v_length := length(v_seed);
 for i := v_length downto 1 do
  if (copy(v_seed,i,1)<'0') or (copy(v_seed,i,1)>'9') then  //�����������
   begin
    v_last := floattostr(power(10,v_length-1)+strtofloat(copy(v_seed,i+1,v_length-i))+1); //��׺��1
    new_seed := copy(v_seed,1,i)+copy(v_last,i+1,v_length-i);
    dm.Ado04.Edit; //ʹǰ׺�����׺��1
    dm.ADO04SEED_VALUE.Value := new_seed;
    dm.Ado04.Post;
    break;
   end
  else
   if i=1 then //�����һλ��Ȼ������
    begin
     v_last := floattostr(power(10,v_length)+strtofloat(v_seed)+1);
     new_seed := copy(v_last,2,v_length);
     dm.Ado04.Edit;
     dm.ADO04SEED_VALUE.Value := new_seed;
     dm.Ado04.Post;
    end;
 end;
end;

function Power(x, y : extended) : extended;
begin
 result := exp(y*ln(x));
end;

function TNEC_Form.returen_rkey16(loca_code: string): integer;
begin
 with dm.ADOQuery1 do
  begin
   close;
   sql.Clear;
   sql.Add('select rkey from data0016');
   sql.Add('where code='''+loca_code+'''');
   open;
   if isempty then
    result:=0
   else
    result:=fieldvalues['rkey'];
  end;
end;

function TNEC_Form.returen_rkey08(proc_code: string): integer;
begin
 with dm.ADOQuery1 do
  begin
   close;
   sql.Clear;
   sql.Add('select rkey from data0008');
   sql.Add(' where prod_code='''+proc_code+'''');
   open;
   if isempty then
    result:=0
   else
    result:=fieldvalues['rkey'];
  end;
end;

procedure TNEC_Form.BtnSaveClick(Sender: TObject);
var
 i:word;
begin
if strtoint(self.flag_Lb.Caption)=0 then
 begin
  if self.find_numbererror(trim(maskedit1.Text)) then
  begin
   if messagedlg('��ֱ���ظ�,�����ж�̨�����ͬʱ����,�Ƿ��Զ����±��?',mtConfirmation,
   [mbYes,mbNo],0)=mrYes  then
    begin
    dm.ado04.Close;
    dm.ado04.Open;
    maskedit1.Text:=dm.ado04SEED_VALUE.Value;
    end
   else
    begin
     exit;
    end;
  end;
  dm.ADOConnection1.BeginTrans;
  try
    self.update_04(trim(maskedit1.Text)); //���¿�����
    dm.ADSSB60.Close;
    dm.ADSSB60.Parameters[0].Value:=null;
    dm.ADSSB60.Open;
    dm.ADSSB60.Append;
    dm.ADSSB60sales_order.Value:=Maskedit1.Text;
    dm.ADSSB60sales_date.Value:=self.DateTimePicker1.Date;
    dm.ADSSB60type.Value:=2;
    dm.ADSSB60status.Value:=1;
    dm.ADSSB60ent_date.Value:=now;
    dm.ADSSB60ent_user_ptr.Value:= strtoint(user_ptr);
    dm.ADSSB60SHIP_METHOD.Value:= self.Edit2.Text;
    dm.ADSSB60LOCATION.Value:= self.Edit1.Text;
    dm.ADSSB60CONTACT_NAME.Value:=self.Edit3.Text;
    dm.ADSSB60CONT_PHONE.Value:=self.Edit4.Text;
    dm.ADSSB60remark.Value:=self.Edit5.Text;
    dm.ADSSB60.Post;
    dm.ADSSB63.Close;
    dm.ADSSB63.Parameters[0].Value:=dm.ADSSB60rkey.Value;
    dm.ADSSB63.Open;
    for i:=1 to sgrid1.RowCount-2 do
    begin
        dm.ADSSB63.AppendRecord([dm.ADSSB60rkey.Value,
                              returen_rkey08(trim(sgrid1.Cells[0,i])),
                              returen_rkey16(trim(sgrid1.Cells[6,i])),
                              strtocurr(sgrid1.Cells[3,i]),
                              sgrid1.Cells[5,i],
                              dm.ADSSB60sales_date.Value]);
    end;

    dm.ADOConnection1.CommitTrans;
    self.ModalResult:=mrok;
  except
   dm.ADOConnection1.RollbackTrans;
   messagedlg('���ݱ���ʧ��,�������ɹ�',mterror,[mbcancel],0);
   self.ModalResult:=mrCancel;
  end;
 end
else
 begin
  dm.ADOConnection1.BeginTrans;
  try
  dm.ADSSB60.Close;
  dm.ADSSB60.Parameters[0].Value:=dm.ADS60rkey.Value;
  dm.ADSSB60.Open;
  dm.ADSSB60.Edit;
  dm.ADSSB60sales_date.Value:=self.DateTimePicker1.Date;
  dm.ADSSB60status.Value:=1;
  dm.ADSSB60ent_date.Value:=now;
  dm.ADSSB60ent_user_ptr.Value:=strtoint(user_ptr);//strtoint(.user_ptr);
  dm.ADSSB60SHIP_METHOD.Value:=self.Edit2.Text;
  dm.ADSSB60LOCATION.Value:=self.Edit1.Text;
  dm.ADSSB60CONTACT_NAME.Value:=self.Edit3.Text;
  dm.ADSSB60CONT_PHONE.Value:=self.Edit4.Text;
  dm.ADSSB60remark.Value:=self.Edit5.Text;
  dm.ADSSB60.Post;

  dm.ADSSB63.Close;
  dm.ADSSB63.Parameters[0].Value:=dm.ADSSB60rkey.Value;
  dm.ADSSB63.Open;
  while not dm.ADSSB63.Eof do dm.ADSSB63.Delete;
  for i:=1 to sgrid1.RowCount-2 do
   dm.ADSSB63.AppendRecord([dm.ADSSB60rkey.Value,
                              returen_rkey08(trim(sgrid1.Cells[0,i])),
                              returen_rkey16(trim(sgrid1.Cells[6,i])),
                              strtocurr(sgrid1.Cells[3,i]),
                              sgrid1.Cells[5,i],
                              dm.ADSSB60sales_date.Value]);

   dm.ADOConnection1.CommitTrans;
   self.ModalResult:=mrok;
  except
   dm.ADOConnection1.RollbackTrans;
   messagedlg('���ݱ���ʧ��,�������ɹ�!',mterror,[mbcancel],0);
   self.ModalResult:=mrCancel;
  end;
 end;
 
end;

procedure TNEC_Form.BtnSaveEnter(Sender: TObject);
begin
if trim(maskedit1.Text)='' then
 begin
  messagedlg('���۵��Ų���Ϊ��!!!',mterror,[mbcancel],0);
  maskedit1.SetFocus;
  exit;
 end;
dm.ADO04.Close;
dm.ado04.Open;
if (dm.ADO04SEED_FLAG.Value<>1) and
(not (maskedit1.Text[length(trim(maskedit1.Text))] in ['0'..'9'])) then
 begin
  messagedlg('���ֵ������һλ������һ������!',mtinformation,[mbok],0);
  maskedit1.SetFocus;
  exit;
 end;

if sgrid1.RowCount<=2 then
 begin
  messagedlg('������ϸ����Ϊ��,������!',mterror,[mbcancel],0);
  sgrid1.SetFocus;
  exit;
 end;
if dm.ExistInventory(self.Handle) then  //�����̵�
  begin
    BitBtn9.SetFocus;
    Exit;
  end;

end;

end.
