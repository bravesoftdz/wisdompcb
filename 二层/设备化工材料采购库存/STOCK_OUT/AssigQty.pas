unit AssigQty;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TFrmAssigQty = class(TForm)
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
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmAssigQty: TFrmAssigQty;

implementation

{$R *.dfm}

procedure TFrmAssigQty.BitBtn1Click(Sender: TObject);
begin
  try
    if strtofloat(edit4.Text)<=0 then exit;
    if strtofloat(trim(edit4.Text))>strtofloat(trim(edit3.Text)) then
    begin
      messagedlg('�������ܳ�������������',mtinformation,[mbok],0);
      exit;
    end;
  except
    messagedlg('������Ч��',mtinformation,[mbok],0);
    exit;
  end;
  modalresult:=mrok;
end;

end.
