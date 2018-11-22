unit aded_method;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, DBCtrls, Mask, DB, ADODB;

type
  TForm2 = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    MaskEdit1: TMaskEdit;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    Label6: TLabel;
    aq04: TADOStoredProc;
    aq04CONTROL_NO_LENGTH: TSmallintField;
    aq04SEED_VALUE: TStringField;
    aq04SEED_FLAG: TWordField;
    Label7: TLabel;
    Edit1: TEdit;
    BitBtn3: TBitBtn;
    Label8: TLabel;
    ADOQuery1: TADOQuery;
    ADOQuery1CUST_CODE: TStringField;
    ADOQuery1CUSTOMER_NAME: TStringField;
    procedure BitBtn2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BitBtn1Enter(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure BitBtn3Click(Sender: TObject);
    procedure Edit1Click(Sender: TObject);
    procedure Edit1Exit(Sender: TObject);
  private
    { Private declarations }
   v_close:byte; 
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation
uses main, cust_search;
{$R *.dfm}

procedure TForm2.BitBtn2Click(Sender: TObject);
begin
 form1.AT370.Cancel;
 ModalResult:=mrcancel;
 v_close:=1;//�����˳�
end;

procedure TForm2.FormActivate(Sender: TObject);
var
 i,j:byte;
 v_mask:string;
begin
 v_close:=0;
 AQ04.Open;
 IF form1.AT370.State=dsinsert then //����
  begin
  if AQ04.FieldValues['seed_flag']<>1 then
   begin
    maskedit1.text := trim(AQ04.Fieldvalues['seed_value']);
    if AQ04.FieldValues['seed_flag']=2  then
    for i:=length(maskedit1.Text) downto 1 do //��������
    if (maskedit1.Text[i]<'0') or (maskedit1.Text[i]>'9') then//�ҳ��ڼ�λ��ʼΪǰ׺
    begin                                    //���������ַ���Ϊǰ׺
     maskedit1.EditMask := copy(maskedit1.Text,1,i)+copy('999999999999999',1,15-i)+';1; ';
     v_mask := maskedit1.EditMask;
     for j:=1 to i do
      insert('\',v_mask,2*j-1);      //������λ����
     maskedit1.EditMask := v_mask;
     maskedit1.text := trim(AQ04.Fieldvalues['seed_value']);
     break;
    end;
    if AQ04.FieldValues['seed_flag']=4 then
     maskedit1.Enabled :=false;
   end
  else           //��ȫ�ֹ�������
   begin
    maskedit1.Text := '';
    maskedit1.SetFocus;
   end;                                                          //���϶Ա�Ų���
  end
 else  //�༭
  begin
   maskedit1.Text := trim(form1.AT370CODE.Value);
   if aq04.FieldValues['seed_flag']=2  then     //����ǰ׺
   for i:=length(maskedit1.Text) downto 1 do
   if (maskedit1.Text[i]<'0') or (maskedit1.Text[i]>'9') then //�ҳ��ڼ�λ��ʼΪǰ׺
    begin                                                      //���������ַ���Ϊǰ׺
     maskedit1.EditMask := copy(maskedit1.Text,1,i)+copy('999999999999999',1,15-i)+';1; ';
     v_mask :=maskedit1.EditMask;
     for j:=1 to i do
     insert('\',v_mask,2*j-1);         //������λ����
     maskedit1.EditMask  := v_mask;    //���븳ֵ
     maskedit1.Text := trim(form1.AT370CODE.Value);
     break;
    end;
    if AQ04.FieldValues['seed_flag']=4 then
     maskedit1.Enabled :=false;
   adoquery1.Close;
   adoquery1.Parameters[0].Value:=form1.AT370customer_ptr.Value;
   adoquery1.Open;
   if not adoquery1.IsEmpty then
    begin
     edit1.Text:=self.ADOQuery1CUST_CODE.Value;
     edit1.Font.Color:=clwindowtext;
     label8.Caption:=self.ADOQuery1CUSTOMER_NAME.Value;
    end;
  end;
end;

procedure TForm2.BitBtn1Enter(Sender: TObject);
var
 v_end:string;
begin
 if trim(maskedit1.Text)='' then
  begin
   messagedlg('װ�˴��벻��Ϊ��!',mtinformation,[mbok],0);
   maskedit1.SetFocus;
   exit;
  end
 else
 if aq04seed_flag.Value<>1 then //�������04�ж�ȡ
  begin
   v_end:=copy(maskedit1.Text,length(trim(maskedit1.Text)),1);
   if (v_end<'0') or (v_end>'9') then
   begin
    application.MessageBox('���һλ������һ������','���ƺ���',mb_ok);
    maskedit1.SetFocus;
    exit;
   end;
  end;
end;

procedure TForm2.BitBtn1Click(Sender: TObject);
var
 v_seed,v_last,new_seed:string;
 i,v_length:byte;
begin
 form1.ADOConnection1.BeginTrans;
 form1.AT370CODE.Value:=maskedit1.Text;
 if form1.AT370.State=dsinsert then  //ֻ��������״̬�Ÿ���04
 begin
//=======================================================================
 if AQ04seed_flag.Value<>1 then //��������04���������
 begin
  v_seed := trim(maskedit1.Text);
  v_length :=length(v_seed);
 if v_seed>=trim(AQ04.FieldValues['seed_value']) then //��������Ǵ�04��ȡֵ
  for i := v_length downto 1 do                       //����data0004
  if (copy(v_seed,i,1)<'0') or (copy(v_seed,i,1)>'9') then  //�����������
  begin
   v_last := floattostr(100000000000000+
   strtofloat(copy(v_seed,i+1,v_length-i))+1);        //��׺��1
   new_seed := copy(v_seed,1,i)+copy(v_last,15-(v_length-i)+1,v_length-i);
   AQ04.Edit;            //ʹǰ׺�����׺��1
   AQ04.FieldValues['seed_value'] := new_seed;
   AQ04.Post;
   break;
  end
 else
  if i=1 then //�����һλ��Ȼ������
   begin
    v_last := floattostr(10000000000000000+strtofloat(v_seed)+1);
    new_seed := copy(v_last,16-v_length+1,v_length);
    AQ04.Edit;
    AQ04.FieldValues['seed_value'] := new_seed;
    AQ04.Post;
   end;
 end;
//=======================================================================
end;

 try
  form1.AT370.Post;
  form1.ADOConnection1.CommitTrans;
 except
  form1.ADOConnection1.RollbackTrans;
  messagedlg('���ݱ���δ�ɹ�,�������Ƿ��ظ�!',mtwarning,[mbok],0);
  maskedit1.SetFocus;
  exit;
 end;
 ModalResult:=mrok;
 v_close:=1;//�����˳�
end;

procedure TForm2.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
 if v_close=0 then //�������˳�
  form1.AT370.Cancel;
end;

procedure TForm2.BitBtn3Click(Sender: TObject);
begin
try
 frm_cust:=tfrm_cust.Create(application);
 frm_cust.ADOQuery1.Close;
 frm_cust.ADOQuery1.Parameters[1].Value:=trim(edit1.Text);
 frm_cust.ADOQuery1.Open;
 if frm_cust.ADOQuery1.IsEmpty then
  begin
   messagedlg('��������ȷ�Ŀͻ�����!',mtinformation,[mbok],0);
   edit1.SetFocus;
  end
 else
 if frm_cust.ShowModal=mrok then
  begin
   edit1.Text:=frm_cust.ADOQuery1.fieldbyname('cust_code').AsString;
   edit1.Font.Color := clwindowtext;
   label8.Caption := frm_cust.ADOQuery1.fieldbyname('customer_name').AsString;
   form1.AT370customer_ptr.Value := frm_cust.ADOQuery1.FieldValues['rkey'];
  end;
finally
 frm_cust.free;
end;
end;

procedure TForm2.Edit1Click(Sender: TObject);
begin
 if edit1.Font.Color=clwindowtext then
  begin
   edit1.SelectAll;
   edit1.Font.Color:=clblue;
  end;
end;

procedure TForm2.Edit1Exit(Sender: TObject);
begin
if (activecontrol.Name<>'BitBtn2') and (activecontrol.Name<>'BitBtn3') and (trim(edit1.Text)<>'') then
try
 frm_cust := tfrm_cust.Create(application);
 frm_cust.ADOQuery1.Close;
 frm_cust.ADOQuery1.Parameters[1].Value:=trim(edit1.Text);
 frm_cust.ADOQuery1.Open;

 if frm_cust.ADOQuery1.IsEmpty then
  begin
   messagedlg('��������ȷ�Ŀͻ�����!',mtinformation,[mbok],0);
   edit1.SetFocus;
  end
 else
 if comparetext(trim(edit1.text),trim(frm_cust.ADOQuery1.Fieldbyname('cust_code').AsString))=0 then
  begin
   edit1.Text := frm_cust.ADOQuery1.fieldbyname('cust_code').AsString;
   edit1.Font.Color := clwindowtext;
   label8.Caption := frm_cust.ADOQuery1.fieldbyname('customer_name').AsString;
   form1.AT370customer_ptr.Value := frm_cust.ADOQuery1.FieldValues['rkey'];
  end
 else
  begin
   messagedlg('��������ȷ�Ŀͻ�����!',mtinformation,[mbok],0);
   edit1.SetFocus;
  end;
finally
 frm_cust.free;
end
else
 if (activecontrol.Name<>'BitBtn2') and (activecontrol.Name<>'BitBtn3') and (trim(edit1.Text)='') then
  begin
   label8.Caption:='';
   form1.AT370customer_ptr.AsVariant := null;
  end;
end;

end.
