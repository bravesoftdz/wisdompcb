unit AssigQty6;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TFrmAssigQty6 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label5: TLabel;
    Label6: TLabel;
    Edit5: TEdit;
    Edit6: TEdit;
    Label7: TLabel;
    Edit7: TEdit;
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmAssigQty6: TFrmAssigQty6;

implementation

{$R *.dfm}

procedure TFrmAssigQty6.BitBtn1Click(Sender: TObject);
begin
  try
    if strtofloat(edit4.Text)<=0 then exit;
    if strtofloat(trim(edit4.Text))>strtofloat(trim(edit7.Text)) then
    begin
      messagedlg('退回不能超过领用数量！',mtinformation,[mbok],0);
      exit;
    end;
  except
    messagedlg('数量无效！',mtinformation,[mbok],0);
    exit;
  end;
  modalresult:=mrok;
end;

end.
