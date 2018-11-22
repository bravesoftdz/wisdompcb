unit PasYear;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  TfrmYear = class(TForm)
    Label1: TLabel;
    edtYear: TEdit;
    btnCancel: TBitBtn;
    btnConfirm: TBitBtn;
    Label2: TLabel;
    procedure FormShow(Sender: TObject);
    procedure btnConfirmClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    strState:Integer;
  end;

var
  frmYear: TfrmYear;

implementation

uses DAMO,common,DateUtils;

{$R *.dfm}

procedure TfrmYear.FormShow(Sender: TObject);
begin
  if strState=1 then
  begin
    Label1.Caption:='��ͬ�ӳ�';
    Label2.Caption:='��';
    edtYear.Text:='3';
  end
  else
  begin
    edtYear.Text:= DateToStr(IncYear(getsystem_date(DM.adoTime,1),3));
    Label1.Caption:='��������';
    Label2.Caption:='';
  end;
end;

procedure TfrmYear.btnConfirmClick(Sender: TObject);
var
  e:TDateTime;
begin
  if strState=2 then
  begin
    if not TryStrToDate(Trim(edtYear.Text),e) then
    begin
      ShowMessage('���ڸ�ʽ���ԣ����������룡');
      edtYear.SetFocus;
      exit;
    end;
  end;
  ModalResult:=mrYes;
end;

end.
