unit add;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DBCtrls, Mask, Buttons;

type
  TForm2 = class(TForm)
    DBEdit1: TDBEdit;
    DBMemo1: TDBMemo;
    Button1: TButton;
    Button2: TButton;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);

  private
     v_close:byte;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

uses main;

{$R *.dfm}

procedure TForm2.Button2Click(Sender: TObject);
begin
    Close;
    v_close:=1;
    Form1.ADOQuery2.Cancel;
    Form1.Show;

end;

procedure TForm2.Button1Click(Sender: TObject);
var
   flag:Integer;
begin
  if DbEdit1.Text='' then
  begin
    MessageDlg('������ͻ����',mtinformation,[mbOk],0);
    DbEdit1.SetFocus;
    exit;
  end;
  if DbMemo1.Text='' then
  begin
    MessageDlg('����������',mtinformation,[mbok],0);
    DbMemo1.SetFocus;
    exit;
  end;
  try
    if form1.ADOQuery2.Modified then
    begin
      flag:=MessageDlg('�˼�¼���޸ģ��Ƿ����',mtinformation,[mbyes,mbno,mbcancel],0);
      if flag=7 then
         form1.ADOQuery2.Cancel
      else if flag=6 then
         form1.ADOQuery2.Post
      else
         exit;
    end;
  except
    MessageDlg('����ʧ�ܣ���������Ƿ��ظ�',mtwarning,[mbok],0);
    exit;
    end;
   close;
   v_close:=1;
   form1.Show;
end;

procedure TForm2.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if v_close<>1 then
  begin
    Form1.ADOQuery2.Cancel;
    Form1.Show;
  end;
end;

end.
