unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Grids, DBGrids;

type
  TForm1 = class(TForm)
    GroupBox1: TGroupBox;
    BitBtn1: TBitBtn;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    DBGrid1: TDBGrid;
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses damo,ass_add,ass_edit,common;
{$R *.dfm}

procedure TForm1.FormShow(Sender: TObject);
begin

dm.ADOQuery1.Open;
dm.ado0525.Open;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  application.CreateForm(tform_add, form_add);
  form_add.ShowModal;
  form_add.Free;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
 application.CreateForm(tform_edit,form_edit);
 if not dm.ADOQuery1.IsEmpty then
 begin
 form_edit.Edit1.Text:=trim(dm.ADOQuery1.FieldValues['fasset_alt_type']);
 if dm.ADOQuery1ALT_FLAG.AsInteger=0 then form_edit.RadioButton1.Checked:=true
  else
    form_edit.RadioButton2.Checked:=true;
 form_edit.ShowModal;
 end
 else
 messagedlg('���ݼ�Ϊ�գ��޷����б༭��',mtwarning,[mbok],0);
 form_edit.Free;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
 dm.ado0525.Parameters[0].Value:=dm.ADOQuery1.FieldValues['rkey'];
 dm.ado0525.Close;
 dm.ado0525.Open;
 if not dm.ado0525.IsEmpty then
  begin
   messagedlg('���ݷ�����ͻ,�޷�ɾ����',mtwarning,[mbcancel],0);
   exit;
   end;
 if  not dm.ADOQuery1.IsEmpty  then
 begin
  try
  dm.ADOConnection1.BeginTrans;
  if messagedlg('ȷ��Ҫɾ���ù̶��ʲ��䶯��ʽ��',mtconfirmation,[mbYes,mbNo],0)=mrYes then
  begin
  dm.ADOQuery1.Delete ;
  dm.ADOConnection1.CommitTrans;
  messagedlg('����ɾ���ɹ�',mtinformation,[mbok],0);
  end;
  except
   on e: exception do
   begin
   dm.ADOConnection1.RollbackTrans;
   dm.ADOQuery1.Cancel;
   messagedlg(e.Message,mtwarning,[mbcancel],0);
   end;
  end;
end
 else
  messagedlg('���ݼ�Ϊ�գ��޷�ɾ����',mtwarning,[mbok],0);
end;

procedure TForm1.FormCreate(Sender: TObject);

begin
 if not App_Init(dm.ADOConnection1) then
  begin
   ShowMsg('��������ʧ�ܣ�����ϵϵͳ����Ա��','��ʾ',1);
   application.Terminate;
  end;
  self.Caption :=Application.Title;
  DateSeparator := '-';
  ShortDateFormat := 'yyyy-mm-dd';
 end;

end.
