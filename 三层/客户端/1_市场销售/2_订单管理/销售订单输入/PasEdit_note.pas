unit PasEdit_note;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,uBaseFrm,ucommfunc, Vcl.ExtCtrls,
  Vcl.StdCtrls;

type
  TfrmEdit_note = class(TfrmBase)
    Panel1: TPanel;
    Panel2: TPanel;
    Button1: TButton;
    Button2: TButton;
    Label9: TLabel;
    Edit1: TEdit;
    Memo1: TMemo;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    iMenu:Integer;
  end;

var
  frmEdit_note: TfrmEdit_note;

implementation

{$R *.dfm}

procedure TfrmEdit_note.Button1Click(Sender: TObject);
begin
  if (iMenu=0) then
  begin
    if (Trim(Edit1.Text)='') and (length(widestring(Trim(Edit1.Text)))<5) then
    begin
      ShowMessage('��ͣԭ����С��5�����֣�');
      Exit;
    end;
  end else
  if (iMenu=2) then
  begin
    if (Trim(Edit1.Text)='') and (length(widestring(Trim(Edit1.Text)))<5) then
//    if (Trim(Edit1.Text)='') or (length(Trim(Edit1.Text))-length(widestring(Trim(Edit1.Text)))<5) then
    begin
      ShowMessage('�ر�ԭ����С��5�����֣�');
      Exit;
    end;
  end;
  ModalResult:= mrOk;
end;

end.
