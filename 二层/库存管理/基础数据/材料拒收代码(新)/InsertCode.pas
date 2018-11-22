unit InsertCode;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Mask, DBCtrls,DB,Main,ADODB;

type
  TForm_InsertCode = class(TForm)
    btnSave: TBitBtn;
    btnCancel: TBitBtn;
    lblCode: TLabel;
    lblDescription: TLabel;
    eitDescription: TDBEdit;
    MaskEdit1: TMaskEdit;
    procedure btnCancelClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure MaskEdit1KeyPress(Sender: TObject; var Key: Char);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_InsertCode: TForm_InsertCode;
  v_edit:boolean;
implementation

{$R *.dfm}

procedure TForm_InsertCode.FormActivate(Sender: TObject);
var
 i,j:byte;
 code_mask:string;
begin
  v_edit := false;
  if Form_Main.ds76.FieldValues['code']<>null then //�༭״̬
  begin
    maskedit1.Text := trim(Form_Main.ds76CODE.Value);
    if Form_Main.ds04SEED_FLAG.Value=2  then
      for i:=length(maskedit1.Text) downto 1 do
        if (maskedit1.Text[i]<'0') or (maskedit1.Text[i]>'9') then //�ҳ��ڼ�λ��ʼΪǰ׺
        begin                             //���������ַ���Ϊǰ׺
          maskedit1.EditMask := copy(maskedit1.Text,1,i)+copy('99999',1,5-i)+';1; ';
          code_mask :=maskedit1.EditMask;
          for j:=1 to i do
            insert('\',code_mask,2*j-1);      //������λ����
          maskedit1.EditMask  := code_mask;
          maskedit1.Text := trim(Form_Main.ds76CODE.Value);
          break;
        end;
  end
  else        //����״̬
    if Form_Main.ds04.FieldValues['seed_flag']<>1 then //�����Ų����ֹ�����
      begin
        maskedit1.text := trim(Form_Main.ds04SEED_VALUE.Value);
        if Form_Main.ds04SEED_FLAG.Value=2  then
          for i:=length(maskedit1.Text) downto 1 do //��������
            if (maskedit1.Text[i]<'0') or (maskedit1.Text[i]>'9') then//�ҳ��ڼ�λ��ʼΪǰ׺
            begin                                    //���������ַ���Ϊǰ׺
              maskedit1.EditMask := copy(maskedit1.Text,1,i)+copy('99999',1,5-i)+';1; ';
              code_mask := maskedit1.EditMask;
              for j:=1 to i do
                insert('\',code_mask,2*j-1);      //������λ����
              maskedit1.EditMask := code_mask;
              maskedit1.text := trim(Form_Main.ds04SEED_VALUE.Value);
              break;
            end;
      end
    else                                           //���������ֹ�����
      maskedit1.Text := '';
      if Form_Main.ds04SEED_FLAG.Value=4 then
      begin
        maskedit1.Enabled :=false;
        self.eitDescription.SetFocus;
      end
      else
        maskedit1.SetFocus;
end;

procedure TForm_InsertCode.btnSaveClick(Sender: TObject);
var
 i,code_length:byte;
 code_seed,code_end:string;
begin
  if trim(maskedit1.Text)= '' then
    begin
      messagedlg('���Ͼ��մ��벻��Ϊ��!',mtinformation,[mbok],0);
      maskedit1.SetFocus;
      exit;
    end
  else
    if Form_Main.ds04SEED_FLAG.Value<>1 then //�������04�ж�ȡ
    begin
      code_end:=copy(maskedit1.Text,length(trim(maskedit1.Text)),1);
      if (code_end<'0') or (code_end>'9') then
      begin
        application.MessageBox('���һλ������һ������','���ƺ���',mb_ok);
        maskedit1.SetFocus;
        exit;
      end;
    end;
    if trim(Self.eitDescription.Text)= '' then
    begin
      messagedlg('���Ͼ�����������Ϊ��!',mtinformation,[mbok],0);
      Self.eitDescription.SetFocus;
      exit;
    end;
  Form_Main.ds76CODE.Value:=maskedit1.Text;
  if Form_Main.ds76.State=dsEdit then     //����Ǳ༭״̬
    begin
      Form_Main.ds76.Post;
      Form_Main.Show;
      close;
    end
  else     //��Ҫ������״̬
  begin
    Form_Main.ds76.Post;
    if Form_Main.ds04SEED_FLAG.Value<>1 then
    begin
      code_seed := trim(maskedit1.Text);
      code_length :=length(code_seed);
      if code_seed>=trim(Form_Main.ds04SEED_VALUE.Value) then    //��������Ǵ�04��ȡֵ
        for i := length(code_seed) downto 1 do                       // ����data0004
          if (copy(code_seed,i,1)<'0') or (copy(code_seed,i,1)>'9') then  //�����������
          begin
            Form_Main.ds04.Edit;            //ʹǰ׺�����׺��1
            Form_Main.ds04SEED_VALUE.Value := copy(code_seed,1,i)+copy(inttostr(10000+strtoint(copy(code_seed,i+1,code_length-i))+1),5-(code_length-i)+1,code_length-i);
            Form_Main.ds04.Post;
            break;
          end
          else
            if i=1 then //�����һλ��Ȼ������
            begin
              Form_Main.ds04.Edit;
              Form_Main.ds04SEED_VALUE.Value:= copy(inttostr(100000+strtoint(code_seed)+1),6-code_length+1,code_length);
              Form_Main.ds04.Post;
            end;
    end;
    Form_Main.ds76.Append;
    if Form_Main.ds04SEED_FLAG.Value<>1 then
    begin
      maskedit1.Text := trim(Form_Main.ds04SEED_VALUE.Value);
      self.eitDescription.SetFocus;
    end
    else
    begin
      maskedit1.Text := '';
      maskedit1.SetFocus;
    end;
 end;
end;

procedure TForm_InsertCode.btnCancelClick(Sender: TObject);
var smg:integer;
begin
  smg:=0;
  if Form_Main.ds76.State=dsInsert then
  begin
    if v_edit then
      smg:=messagedlg('�Ƿ񱣴�����?',mtConfirmation,[mbyes,mbno,mbcancel],0);
  end
  else
  begin
    if (Form_Main.ds76.Modified) or (v_edit) then
      smg:=messagedlg('�������޸ģ��Ƿ񱣴����ݣ�',mtConfirmation,[mbyes,mbno,mbcancel],0);
  end;
  if smg=7 then    //no�����浱ǰ��¼���޸�
  begin
    Form_Main.ds76.Cancel;
    Form_Main.Show;
    close;
  end
  else
  begin
    if smg=6 then   //yes���浱ǰ��¼���޸�
    begin
      btnSaveClick(sender);
    end
    else           //ȡ���Ե�ǰ��¼���޸�
    begin
      Form_Main.Show;
      close;
    end;
  end;
end;

procedure TForm_InsertCode.MaskEdit1KeyPress(Sender: TObject;
  var Key: Char);
begin
  v_edit:=true;
end;

procedure TForm_InsertCode.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  Form_Main.ds76.Cancel;
end;

end.
