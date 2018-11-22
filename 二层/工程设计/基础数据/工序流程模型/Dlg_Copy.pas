unit Dlg_Copy;

interface

uses
  SysUtils, Windows, Messages, Classes, Graphics, Controls,
  StdCtrls, ExtCtrls, Forms;

type
  TfrmDlg_Copy = class(TForm)
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    Label2: TLabel;
    edtModName: TEdit;
    edtModDesc: TEdit;
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  end;

var
  frmDlg_Copy: TfrmDlg_Copy;

implementation
uses common ,MyClass;
{$R *.DFM}

procedure TfrmDlg_Copy.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if modalresult = mrok then
  begin
    if trim(edtModName.Text)='' then
    begin
      ShowMsg('ģ�����Ʋ���Ϊ��',1);
      canclose:=false;
      exit;
    end
    else
    if MyDataClass.IsExists('select rKey from data0504 where Eng_Flow_Name='+QuotedStr(trim(edtModName.Text))) then
    begin
      ShowMsg('��ǰģ�������Ѿ�����,�����ظ�,����������','��ʾ',1);
      canclose := false;
      exit;
    end;
  end;
end;

end.
