unit uCondition;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Spin, Buttons, ComCtrls;

type
  TfrmCondition = class(TForm)
    GroupBox1: TGroupBox;
    Label1: TLabel;
    YJH: TSpinEdit;
    GroupBox2: TGroupBox;
    Label4: TLabel;
    SpinEdit2: TSpinEdit;
    BitBtn3: TBitBtn;
    BitBtn2: TBitBtn;
    Label2: TLabel;
    MJH: TSpinEdit;
    Label3: TLabel;
    SpinEdit1: TSpinEdit;
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

uses uEMPInfo;

{$R *.dfm}

procedure TfrmCondition.BitBtn2Click(Sender: TObject);

begin

 ModalResult:=mrOK;

end;

end.
