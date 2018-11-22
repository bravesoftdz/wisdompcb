unit UPHourEdit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls;

type
  TfrmPHourEdit = class(TForm)
    btn1: TButton;
    btn2: TButton;
    lbl1: TLabel;
    edt_PHour: TEdit;
    procedure edt_PHourKeyPress(Sender: TObject; var Key: Char);
    procedure btn1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    FPHour:Double;
    
  end;

var
  frmPHourEdit: TfrmPHourEdit;

implementation

{$R *.dfm}

procedure TfrmPHourEdit.edt_PHourKeyPress(Sender: TObject; var Key: Char);
begin
if not (key in [ '0'..'9',#8,chr(VK_delete)]) then key:=char(0);
end;

procedure TfrmPHourEdit.btn1Click(Sender: TObject);
begin
   if Trim(edt_PHour.Text)<>''  then
    if  StrToFloat(Trim(edt_PHour.Text))<0  then
    begin
    ShowMessage('����ʱ����Ϊ������');
    exit;
    end;
    if  StrToFloat(Trim(edt_PHour.Text))>FPHour then
    begin
    ShowMessage('����ʱ���ܴ��ڼƻ���ʱ��'+floattostr(FPHour)+ 'Сʱ��');
    exit;
    end;
  self.ModalResult:=mrok;
end;

end.
