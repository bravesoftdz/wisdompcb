unit edit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DBCtrls, Mask, Buttons;

type
  TForm3 = class(TForm)
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
  Form3: TForm3;

implementation

uses main;

{$R *.dfm}

procedure TForm3.Button2Click(Sender: TObject);
begin
    Close;
    v_close:=1;
    Form1.ADOTable1.Cancel;
    Form1.Show;

end;

procedure TForm3.Button1Click(Sender: TObject);
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
    if form1.ADOTable1.Modified then
    begin
         form1.ADOTable1.Post;
    end;
  except
    MessageDlg('����ʧ�ܣ���������Ƿ��ظ�',mtwarning,[mbok],0);
    exit;
    end;
   close;
   v_close:=1;
   form1.Show;
end;

procedure TForm3.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if v_close<>1 then
  begin
    Form1.ADOTable1.Cancel;
    Form1.Show;
  end;
end;

end.
