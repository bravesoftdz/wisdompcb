unit BOMBaoJiaAddNewType;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RzButton, Vcl.StdCtrls, Vcl.Mask,
  RzEdit, RzLabel;

type
  TfrmBOMBaoJiaAddNewType = class(TForm)
    lbl1: TRzLabel;
    edt1: TRzEdit;
    btn1: TRzButton;
    btn2: TRzButton;
    procedure btn1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


implementation

{$R *.dfm}

procedure TfrmBOMBaoJiaAddNewType.btn1Click(Sender: TObject);
begin
  if edt1.Text = '' then
  begin
    ShowMessage('���ֲ���Ϊ��');
    Exit;
  end;
  ModalResult := mrOk;
end;

procedure TfrmBOMBaoJiaAddNewType.btn2Click(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

end.
