unit edit_memo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Mask, DBCtrls;

type
  TForm4 = class(TForm)
    Edit1: TEdit;
    lbl1: TLabel;
    lbl2: TLabel;
    DBEditREF_NUMBER: TDBEdit;
    lbl3: TLabel;
    DBEditDESCRIPTION: TDBEdit;
    btn1: TBitBtn;
    btn2: TBitBtn;
    procedure btn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation

uses DAMO;

{$R *.dfm}

procedure TForm4.btn2Click(Sender: TObject);
begin
  try
      DM.aqd116.Post;   //�ύ����
      Self.ModalResult := mrok;    //"Self"ָ������
  except
    MessageBox(Handle,'����ʧ�ܣ������¼�Ƿ��ظ�','��ʾ',MB_ICONINFORMATION+MB_OK);
    Abort;                   //��ֹ
  end;

end;

end.
