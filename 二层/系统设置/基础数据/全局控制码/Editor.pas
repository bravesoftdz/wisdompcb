unit Editor;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DBCtrls, Mask, Buttons, DB, ADODB;

type
  TForm_Editor = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Edit1: TEdit;
    Edit2: TEdit;
    ComboBox1: TComboBox;
    DBEdit1: TDBEdit;
    procedure BitBtn2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_Editor: TForm_Editor;

implementation

uses control, dmo;


{$R *.dfm}
procedure TForm_Editor.BitBtn2Click(Sender: TObject);
var smg:Integer;
begin
  if DM.ADO04.State=dsEdit then
    smg:=messagedlg('�������޸ģ��Ƿ񱣴����ݣ�',mtConfirmation,[mbyes,mbno,mbcancel],0);
  if smg=7 then    //no�����浱ǰ��¼���޸�
  begin
    DM.ADO04.Cancel;
    ModalResult:=mrCancel;
  end
  else
  begin
    if smg=6 then   //yes���浱ǰ��¼���޸�
    begin
      BitBtn1Click(sender);
    end
    else           //ȡ���Ե�ǰ��¼���޸�
    begin
      dm.ADO04.Cancel;
      ModalResult:=mrCancel;
    end;
  end;
  //Form1.Show;
  //Application.Terminate;
end;

procedure TForm_Editor.FormShow(Sender: TObject);
begin
  if (DM.ADO04rkey.Value=63) or (DM.ADO04rkey.Value=55) or
    (DM.ADO04rkey.Value=18) or (DM.ADO04rkey.Value=17) or
//    (DM.ADO04rkey.Value=26) or (DM.ADO04rkey.Value=56) or   //2013-1-30tang�޸����� (DM.ADO04rkey.Value=26)װ�䵥�ɸ���
    (DM.ADO04rkey.Value=56) or
    (DM.ADO04rkey.Value=57) or (DM.ADO04rkey.Value=2) then  //�ջ�����
  begin             //�������û����ĵĿ�����
    ComboBox1.Enabled:=False;
  end
  else
  begin
     ComboBox1.Enabled:=true;
  end;
end;

procedure TForm_Editor.BitBtn1Click(Sender: TObject);
var
  text:string;
  flag:Integer;
begin
  if Trim(ComboBox1.Text)='' then
  begin
    ShowMessage('��ʶ����Ϊ�գ���ѡ���ʶ');
    ComboBox1.SetFocus;
    Exit;
  end;
  if Trim(DBEdit1.Text)='' then
  begin
    ShowMessage('�ο�ֵ����Ϊ�գ�������ο�ֵ');
    DBEdit1.SetFocus;
    Exit;
  end;
  text:=copy(DBEdit1.Text,length(trim(DBEdit1.Text)),1);
  if (text<'0') and (text>'9') then
  begin
    Application.MessageBox('���һλ����������','���ƺ���',mb_ok);
    DBEdit1.SetFocus;
    Exit;
  end;
  if length(Trim(DBEdit1.Text))>StrToInt(Trim(DM.ADO04control_no_length.Text)) then
  begin
    Application.MessageBox('����ؼ���ĳ��Ȳ��ܴ���ָ������','���ƺ���',mb_ok);
    DBEdit1.SetFocus;
    Exit;
  end;
  if ComboBox1.Text='�ֶ�' then
  begin
    flag:=1;
  end
  else
  begin
    if ComboBox1.Text='�ɱ���ĸ' then
    begin
      flag:=3;
    end
    else
    begin
      flag:=4;
    end;
  end;
  dm.ADOConnection1.BeginTrans;
  DM.ADO04SEED_FLAG.Value:=flag;
  try
    dm.ADO04.Post;
    dm.ADOConnection1.CommitTrans;
  except
    DM.ADOConnection1.RollbackTrans;
    MessageDlg('����δ����ɹ�',mtWarning,[mbok],0);
    DBEdit1.SetFocus;
    exit;
  end;
  ModalResult:=mrOk;
end;

procedure TForm_Editor.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  dm.ADO04.Cancel;
end;

end.
