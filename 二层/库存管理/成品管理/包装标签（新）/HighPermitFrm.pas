unit HighPermitFrm;

interface

uses Windows, SysUtils, Classes, Graphics, Forms, Controls, StdCtrls, 
  Buttons;

type
  TfrmHighPermit = class(TForm)
    Label1: TLabel;
    edtPassword: TEdit;
    OKBtn: TButton;
    CancelBtn: TButton;
    lbl1: TLabel;
    edtUserName: TEdit;
    procedure OKBtnClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

  function ShowHightPermit: Boolean;

implementation

uses
  DM,Dialogs;

{$R *.dfm}
function ShowHightPermit: Boolean;
var
  LFrm: TfrmHighPermit;
begin
  LFrm := TfrmHighPermit.Create(nil);
  try
    Result := LFrm.ShowModal = mrOk;
  finally
    LFrm.free;
  end;
end;


procedure TfrmHighPermit.OKBtnClick(Sender: TObject);
var
  LPermit: string;
begin
  LPermit := DM1.GetUserPermit(edtUserName.Text,edtPassword.Text,'�°�װ��ǩ��ӡ');
  if (LPermit = '') or (LPermit <> '4') then
  begin
    ShowMessage('�߼�Ȩ���˻���������� �� Ȩ�޲���' + LPermit + '!');
  end else
  begin
    ModalResult := mrOk;
  end;
end;

end.
 
