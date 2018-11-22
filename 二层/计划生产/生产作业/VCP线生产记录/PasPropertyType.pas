unit PasPropertyType;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Grids, DBGridEh, ExtCtrls, DB, ADODB, Menus;

type
  TFrmPropertyType = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Label1: TLabel;
    edtName: TEdit;
    DBGridEh1: TDBGridEh;
    BitBtn5: TBitBtn;
    BitBtn2: TBitBtn;
    DataSource1: TDataSource;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    procedure BitBtn5Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    iType:Integer;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmPropertyType: TFrmPropertyType;

implementation

uses common,PasDM,PasPublic, PasNewPdRecord, PasType;

{$R *.dfm}

procedure TFrmPropertyType.BitBtn5Click(Sender: TObject);
begin
  modalresult:=mrok;
end;

procedure TFrmPropertyType.FormShow(Sender: TObject);
begin
  edtName.Text:='';
  edtName.SetFocus;
  DM.ado198.Close;
  dm.ado198.Open;
  iType:=0;
end;

procedure TFrmPropertyType.N1Click(Sender: TObject);
begin
  if (strtoint(vprev)<>4)  then
  begin
    messagedlg('�Բ���,����Ȩ�޲���',mtinformation,[mbok],0);
    Exit;
  end;
  if (not DM.Ado198.IsEmpty) then
  begin
    if (Application.MessageBox('ȷ��ɾ��������', '������ʾ', MB_OKCANCEL + MB_ICONINFORMATION) = IDCANCEL) then Exit;
    DeleteRecordOver('Data0198',DM.Ado198Rkey.Text,DM.ADOConnection,'Data0181','d198_Ptr','Rkey','','');
    DM.ado198.Close;
    dm.ado198.Open;
  end;
end;

procedure TFrmPropertyType.BitBtn2Click(Sender: TObject);
var tmpAdo:TADOQuery;
begin
  if (Trim(edtName.Text)='') then
  begin
    ShowMsg('�������Ʋ���Ϊ�գ�',1);
    edtName.SetFocus;
    Exit;
  end;
  try
    tmpAdo:=TADOQuery.Create(Application);
    tmpAdo.Connection:=dm.ADOConnection;
    tmpAdo.Close;
    tmpAdo.SQL.Clear;
    tmpAdo.SQL.Text:='insert into dbo.Data0198 (sName,sType) Values (:sName,:sType)';
    tmpAdo.Parameters.ParamByName('sName').Value:=Trim(edtName.Text);
    tmpAdo.Parameters.ParamByName('sType').Value:=iType;
    tmpAdo.ExecSQL;
    ShowMsg('����ɹ���',1);
    DM.ado198.Close;
    dm.ado198.Open;
    edtName.Text:='';
    edtName.SetFocus;
  finally
    tmpAdo.Close;
    tmpAdo.Connection:=nil;
    tmpAdo.Free;
  end;
end;

end.
