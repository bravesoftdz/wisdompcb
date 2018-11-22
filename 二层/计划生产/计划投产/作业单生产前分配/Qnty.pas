unit Qnty;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TfrmQnty = class(TForm)
    edt_PNL: TEdit;
    Label3: TLabel;
    Label2: TLabel;
    edt_PCS: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    procedure BitBtn1Click(Sender: TObject);
    procedure edt_PNLKeyPress(Sender: TObject; var Key: Char);
    procedure edt_PNLExit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    MinQty,MaxQty:Double;
  end;

var
  frmQnty: TfrmQnty;

implementation

{$R *.dfm}

procedure TfrmQnty.BitBtn1Click(Sender: TObject);
begin
  if ((edt_PNL.Text = '') or (edt_PCS.Text = '')) then
  begin
    MessageBox(Handle, 'PNL������PCS��������Ϊ�գ������룡', '����', MB_OK + MB_ICONSTOP);
    edt_PCS.SetFocus;
    Abort;
  end
  else
  if ((StrToFloat(edt_PCS.Text) < MinQty) or (StrToFloat(edt_PCS.Text) > MaxQty)) then
  begin
    ShowMessage('PCS���������ڷ�Χ��'+FloatToStr(MinQty)+'~'+FloatToStr(MaxQty)+'֮�䣬���������룡');
    edt_PCS.SetFocus;
    Abort;
  end
  else
    ModalResult := mrOk;
end;

procedure TfrmQnty.edt_PNLKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in['0'..'9',#8]) then Key:= #0;
end;

procedure TfrmQnty.edt_PNLExit(Sender: TObject);
begin
  if StrToFloat((Sender as TEdit).Text) = 0 then
  begin
    MessageBox(Handle, 'PNL������PCS��������Ϊ0�����飡', '����', MB_OK + MB_ICONSTOP);
    Abort;
  end;
end;

end.
