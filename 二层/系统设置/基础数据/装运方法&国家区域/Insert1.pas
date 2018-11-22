unit Insert1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, DBCtrls, Buttons,DB, ADODB;

type
  TForm_Insert1 = class(TForm)
    bitSave: TBitBtn;
    bitCancel: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    DBEdit1: TDBEdit;
    MaskEdit1: TMaskEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    Edit1: TEdit;
    BitBtn1: TBitBtn;
    Label7: TLabel;
    Label8: TLabel;
    ADO10: TADODataSet;
    ADO10RKEY: TAutoIncField;
    ADO10CUST_CODE: TStringField;
    ADO10CUSTOMER_NAME: TStringField;
    procedure FormActivate(Sender: TObject);
    procedure bitSaveClick(Sender: TObject);
    procedure bitCancelClick(Sender: TObject);
    procedure MaskEdit1KeyPress(Sender: TObject; var Key: Char);
    procedure BitBtn1Click(Sender: TObject);
    procedure Edit1Click(Sender: TObject);
    procedure Edit1Exit(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
    edit:boolean;
  public
    { Public declarations }
  end;

var
  Form_Insert1: TForm_Insert1;

implementation

uses Main, Customer, dmo;

{$R *.dfm}


procedure TForm_Insert1.FormActivate(Sender: TObject);
var
 i,j:byte;
 v_mask:string;
begin
  dmo.DM.ds370.Open;
  dmo.DM.ds04.Open;
  if dmo.DM.ds370.State=dsInsert then  //����
  begin
    if dmo.DM.ds04SEED_FLAG.Value<>1 then     //��ȫ�ֹ�������
    begin
      maskedit1.text := trim(dmo.DM.ds04SEED_VALUE.Value);
      if dmo.DM.ds04SEED_FLAG.Value=2  then
        for i:=length(trim(maskedit1.Text)) downto 1 do   //��������
          if (maskedit1.Text[i]<'0') or (maskedit1.Text[i]>'9') then //�ҳ��ڼ�λ��ʼΪǰ׺
          begin                                    //���������ַ���Ϊǰ׺
            maskedit1.EditMask := copy(maskedit1.Text,1,i)+copy('999999999999999',1,15-i)+';1; ';
            v_mask := maskedit1.EditMask;
            for j:=1 to i do
            insert('\',v_mask,2*j-1);      //������λ����
            maskedit1.EditMask := v_mask;
            maskedit1.text := trim(dmo.DM.ds04SEED_VALUE.Value);
            break;
          end;
          if dmo.DM.ds04SEED_FLAG.Value=4 then
            maskedit1.Enabled :=false;
    end
    else
    begin
      maskedit1.Text := '';
      maskedit1.SetFocus;
    end;                                                     //���϶Ա�Ų���
     end
     else  //�༭
     begin
       maskedit1.Text := trim(dmo.DM.ds370CODE.Value);
       if dmo.DM.ds04SEED_FLAG.Value=2  then     //����ǰ׺
         for i:=length(trim(maskedit1.Text)) downto 1 do
           if (maskedit1.Text[i]<'0') or (maskedit1.Text[i]>'9') then //�ҳ��ڼ�λ��ʼΪǰ׺
           begin                                                      //���������ַ���Ϊǰ׺
             maskedit1.EditMask := copy(maskedit1.Text,1,i)+copy('999999999999999',1,15-i)+';1; ';
             v_mask :=maskedit1.EditMask;
             for j:=1 to i do
             insert('\',v_mask,2*j-1);         //������λ����
             maskedit1.EditMask  := v_mask;    //���븳ֵ
             maskedit1.Text := trim(dmo.DM.ds370CODE.Value);
             break;
           end;
           if dmo.DM.ds04SEED_FLAG.Value=4 then
             maskedit1.Enabled :=false;
             ADO10.Close;
             ADO10.Parameters[0].Value:=dmo.DM.ds370customer_ptr.Value;
             ADO10.Open;
           if not ADO10.IsEmpty then
           begin
             edit1.Text:=self.ADO10CUST_CODE.Value;
             edit1.Font.Color:=clwindowtext;
             label8.Caption:=self.ADO10CUSTOMER_NAME.Value;
           end;
      end;
end;

procedure TForm_Insert1.bitSaveClick(Sender: TObject);
var
text,last:string;
i,len:byte;
begin
  if Trim(Self.MaskEdit1.Text)='' then
  begin
    ShowMessage('װ�˴��벻��Ϊ�գ�������װ�˴���');
    Self.MaskEdit1.SetFocus;
    Exit;
  end;
  if dmo.DM.ds04SEED_FLAG.Value<>1 then //�������04�ж�ȡ
  begin
    text:=copy(maskedit1.Text,length(trim(maskedit1.Text)),1);
    if (text<'0') or (text>'9') then
    begin
    application.MessageBox('���һλ������һ������','���ƺ���',mb_ok);
    maskedit1.SetFocus;
    exit;
   end;
  end;
  dmo.DM.ADOConnection1.BeginTrans;
  dmo.DM.ds370CODE.Value:=maskedit1.Text;
  if dmo.DM.ds370.State=dsInsert then  //ֻ��������״̬�Ÿ���04
  begin
    if dmo.DM.ds04SEED_FLAG.Value<>1 then //��������04���������
    begin
      text := trim(maskedit1.Text);
      len :=length(text);
      if text>=trim(dmo.DM.ds04SEED_VALUE.Value) then //��������Ǵ�04��ȡֵ
      for i := len downto 1 do                       //����data0004
      if (copy(text,i,1)<'0') or (copy(text,i,1)>'9') then  //�����������
      begin
        last := floattostr(100000000000000+
        strtofloat(copy(text,i+1,len-i))+1);        //��׺��1
        dmo.DM.ds04.Edit;           //ʹǰ׺�����׺��1
        dmo.DM.ds04SEED_VALUE.Value := copy(text,1,i)+copy(last,15-(len-i)+1,len-i);
        dmo.DM.ds04.Post;
        break;
      end
      else
        if i=1 then //�����һλ��Ȼ������
        begin
          last := floattostr(10000000000000000+strtofloat(text)+1);
          dmo.DM.ds04.Edit;
          dmo.DM.ds04SEED_VALUE.Value := copy(last,16-len+1,len);
          dmo.DM.ds04.Post;
        end;
     end;
  end;
  try
    dmo.DM.ds370.Post;
    dmo.DM.ADOConnection1.CommitTrans;
  except
    dmo.DM.ADOConnection1.RollbackTrans;
    messagedlg('���ݱ���δ�ɹ�,�������Ƿ��ظ�!',mtwarning,[mbok],0);
    maskedit1.SetFocus;
    exit;
 end;
   ModalResult:=mrok;
end;

procedure TForm_Insert1.bitCancelClick(Sender: TObject);
var smg:integer;
begin
  smg:=0;
  if dmo.DM.ds370.State=dsInsert then
  begin
    if edit then
      smg:=MessageDlg('�Ƿ�Ҫ�������ݣ�',mtConfirmation,[mbYes,mbNo,mbCancel],0)
    else
      dmo.DM.ds370.Cancel;
      ModalResult:=mrCancel;
  end
  else
  begin
    if (dmo.DM.ds370.Modified) or (edit) then
      smg:=messagedlg('�������޸ģ��Ƿ񱣴����ݣ�',mtConfirmation,[mbyes,mbno,mbcancel],0);
  end;
  if smg=7 then    //no�����浱ǰ��¼���޸�
  begin
    dmo.DM.ds370.Cancel;
    ModalResult:=mrCancel;
  end
  else
  begin
    if smg=6 then   //yes���浱ǰ��¼���޸�
    begin
      bitSaveClick(sender);
    end
    else           //ȡ���Ե�ǰ��¼���޸�
    begin
      dmo.DM.ds370.Cancel;
      ModalResult:=mrCancel;
    end;
  end;
end;

procedure TForm_Insert1.MaskEdit1KeyPress(Sender: TObject; var Key: Char);
begin
  edit:=True;
end;

procedure TForm_Insert1.BitBtn1Click(Sender: TObject);
begin
  try
    Form_Customer:=TForm_Customer.Create(Application);
    Form_Customer.ds10.Close;
    Form_Customer.ds10.Parameters[0].Value:=Trim(Edit1.Text);
    Form_Customer.ds10.Open;
    if Form_Customer.ds10.IsEmpty then
    begin
      messagedlg('��������ȷ�Ŀͻ�����!',mtinformation,[mbok],0);
      Edit1.SetFocus;
    end
    else
    begin
      if Form_Customer.ShowModal=mrok then
      begin
        edit1.Text:=Form_Customer.ds10CUST_CODE.Value;
        edit1.Font.Color:=clWindowText;
        Label8.Caption:=Form_Customer.ds10CUSTOMER_NAME.Value;
        dmo.DM.ds370CUSTOMER_PTR.Value:=Form_Customer.ds10RKEY.Value;
      end;
    end;
  finally
    Form_Customer.Free;
  end;
end;

procedure TForm_Insert1.Edit1Click(Sender: TObject);
begin
  if Edit1.Font.Color=clwindowtext then
  begin
    Edit1.SelectAll;
    edit1.Font.Color:=clBlue;
  end;
end;

procedure TForm_Insert1.Edit1Exit(Sender: TObject);
begin
  if (activecontrol.Name='bitSave') and (Trim(Edit1.Text)<>'') then
  begin
    Form_Customer:=TForm_Customer.Create(application);
    Form_Customer.ds10.Close;
    Form_Customer.ds10.Parameters[0].Value:=Trim(Edit1.Text);
    Form_Customer.ds10.Open;
    if Form_Customer.ds10.IsEmpty then
    begin
      messagedlg('��������ȷ�Ŀͻ�����!',mtinformation,[mbok],0);
      Edit1.SetFocus;
    end
    else
    begin
      if (Trim(Edit1.Text)<>'') and (Trim(dmo.DM.ds370CUSTOMER_PTR.Text)<>'') then
      begin
        edit1.Text:=Form_Customer.ds10CUST_CODE.Value;
        edit1.Font.Color:=clWindowText;
        Label8.Caption:=Form_Customer.ds10CUSTOMER_NAME.Value;
        dmo.DM.ds370CUSTOMER_PTR:=Form_Customer.ds10RKEY;
      end
      else
        messagedlg('��������ȷ�Ŀͻ�����!',mtinformation,[mbok],0);
      Edit1.SetFocus;
    end;
  end
  else
  begin
    Label8.Caption:='';
    dmo.DM.ds370CUSTOMER_PTR.AsVariant:=null;
  end;
end;

procedure TForm_Insert1.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  dmo.DM.ds370.Cancel;
end;
end.
