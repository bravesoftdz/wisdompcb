unit uCondition;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Spin, Buttons, ComCtrls;

type
  TfrmCondition = class(TForm)
    BitBtn3: TBitBtn;
    BitBtn2: TBitBtn;
    GroupBox1: TGroupBox;
    Label1: TLabel;
    Label3: TLabel;
    YJH: TSpinEdit;
    SpinEdit1: TSpinEdit;
    GroupBox2: TGroupBox;
    Label4: TLabel;
    Label2: TLabel;
    SpinEdit2: TSpinEdit;
    MJH: TSpinEdit;
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    _SearchStr:string;
    _ZYStatus:integer;//ְλ(0��,1����Ա,2ҵ��Ա,3Ӫ��Ա,4��������)
    _userptr:string;  //������
    _BMRKY:integer;   //����
  end;

var
  frmCondition: TfrmCondition;

implementation


{$R *.dfm}

procedure TfrmCondition.BitBtn2Click(Sender: TObject);

begin
 if yjh.Value>self.SpinEdit1.Value then
  messagedlg('��ʼ��Ȳ��ܴ��ڽ������!',mterror,[mbcancel],0)
 ELSE
  if mjh.Value>self.SpinEdit2.Value then
   messagedlg('��ʼ�·ݲ��ܴ��ڽ����·�!',mterror,[mbcancel],0)
 else
 ModalResult:=mrOK;

end;

end.
