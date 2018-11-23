unit qkBaseFrm;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, RzButton, Vcl.StdCtrls, RzCommon,
  RzEdit, RzBtnEdt, Vcl.DBCtrls, RzDBEdit, Vcl.Mask, Vcl.ExtCtrls;

type
  TfrmqkBase = class(TForm)
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
  public
    { Public declarations }
    ModID: Int64;
  end;


implementation

{$R *.dfm}

{ TfrmqkBase }


procedure TfrmqkBase.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  //����cafree�������������һ��
  if not (fsModal in FormState) then //modal���岻�����������޷���ȡ����
    SetWindowPos(Application.MainFormHandle,HWND_TOP,0,0,0,0,SWP_NOMOVE or SWP_NOSIZE);
end;

procedure TfrmqkBase.FormCreate(Sender: TObject);
var
  I: Integer;
begin
  //����edit ��style,��ΪƤ����edit�У�ֻ����û�б�ɫ
  for I := 0 to Self.ComponentCount - 1 do
  begin
    if (Self.Components[I] is TEdit) or
      (Self.Components[I] is TMemo) or
      (Self.Components[I] is TLabeledEdit) or
      (Self.Components[I] is TDBMemo) or
      (Self.Components[I] is TDBEdit) or
      (Self.Components[I] is TRzDBEdit) or
      (Self.Components[I] is TRzEdit) or
      (Self.Components[I] is TRzButtonEdit) or
      (Self.Components[I] is TRzMemo) or
      (Self.Components[I] is TRzDBMemo)
    then
    begin
      (Self.Components[I] as TControl).StyleElements := [seBorder];
    end;
  end;
end;

end.
