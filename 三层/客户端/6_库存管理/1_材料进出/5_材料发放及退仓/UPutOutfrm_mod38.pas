unit UPutOutfrm_mod38;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,uBaseFrm,System.Math;

type



  TfrmPutOut_mod38 = class(TfrmBase)
    pnl1: TPanel;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    btn1: TBitBtn;
    btnCancel: TBitBtn;
    edtQtyOnHnad: TEdit;
    edtUnitName: TEdit;
    edtThisQty: TEdit;
    lbl4: TLabel;
    edtBomQty: TEdit;
    chkSended: TCheckBox;
    lbl5: TLabel;
    edtIssuedQty: TEdit;
    procedure btn1Click(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure edtThisQtyKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
  public
    { Public declarations }

  // FQty: Double;
  end;

var
  frmPutOut_mod38: TfrmPutOut_mod38;

implementation

{$R *.dfm}

procedure TfrmPutOut_mod38.btn1Click(Sender: TObject);
var
n:integer;
n2,n3:Currency;
begin
  inherited;
   n:=ceil(strtocurr(edtBomQty.text)-strtocurr(edtIssuedQty.Text));//���ɷ���
  //showmessage(IntToStr(N)) ;
  n2:=strtocurr(edtBomQty.text)-strtocurr(edtIssuedQty.Text); //�ɷ���
  n3:= strtocurr(edtThisQty.text); //��ǰ������

 if  (self.Tag=1)  and  (n3>n2) and (n3<n)  then
  begin   //�����ϵ�
   if messagedlg('���������������Ƿ������',mtWarning,[mbYes,mbNo],0)<>mrYes then
      Exit;
  end
  else if (self.Tag=1) and (n3>n)   then
  begin
    ShowMessage('������������:'+inttostr(n));
    Exit;
  end
  else if  (self.Tag=2)  and  (strtocurr(edtThisQty.text)>(strtocurr(edtBomQty.text)-strtocurr(edtIssuedQty.Text)))  then
  begin   //�����ϵ�
    showmessage('��������������');
      Exit;
  end ;


  if strtocurr(edtThisQty.text)>strtocurr(edtQtyOnHnad.text)then
   begin
    showmessage('�����������ܴ������п����');
   exit;
   end;

  if strtocurr(trim(edtThisQty.Text))<=0 then
  begin
    messagedlg('�Բ���,���ܷ�������С����Ĳ���!!!',mterror,[mbcancel],0);
    edtThisQty.SetFocus;
    exit;
  end;

   ModalResult:=mrok;
end;

procedure TfrmPutOut_mod38.btnCancelClick(Sender: TObject);
begin
  inherited;
   close;
end;

procedure TfrmPutOut_mod38.edtThisQtyKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
if not (key in [ '0'..'9',#8,chr(VK_delete)]) then key:=char(0);
end;

end.
