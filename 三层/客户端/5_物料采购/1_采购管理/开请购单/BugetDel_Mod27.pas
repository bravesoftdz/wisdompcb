unit BugetDel_Mod27;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,uBaseFrm, Vcl.StdCtrls, Vcl.Grids;

type
  TfrmBugetDel_Mod27 = class(TfrmBase)
    Label1: TLabel;
    Edit1: TEdit;
    editor1: TStringGrid;
    Button1: TButton;
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmBugetDel_Mod27: TfrmBugetDel_Mod27;

implementation

{$R *.dfm}

procedure TfrmBugetDel_Mod27.FormActivate(Sender: TObject);
begin
  inherited;
 editor1.Cells[0,0] := '�·�';
 editor1.Cells[1,0] := '�޶�';
 editor1.Cells[2,0] := '�ѱ�ʹ��';
 editor1.Cells[3,0] := '��ʹ�ö�';
 editor1.Cells[0,1] := '1 �·�';
 editor1.Cells[0,2] := '2 �·�';
 editor1.Cells[0,3] := '3 �·�';
 editor1.Cells[0,4] := '4 �·�';
 editor1.Cells[0,5] := '5 �·�';
 editor1.Cells[0,6] := '6 �·�';
 editor1.Cells[0,7] := '7 �·�';
 editor1.Cells[0,8] := '8 �·�';
 editor1.Cells[0,9] := '9 �·�';
 editor1.Cells[0,10] := '10�·�';
 editor1.Cells[0,11] := '11�·�';
 editor1.Cells[0,12] := '12�·�';
 editor1.Cells[0,13] := 'ȫ��ϼ�';
end;

end.
