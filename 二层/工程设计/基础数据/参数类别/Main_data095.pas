{******************************************************************************}
{                                                                              }
{Code Maker: Jacky Zhong                                                       }
{Date: Jun. 17. 2007                                                           }
{Comments:                                                                     }
{���ܣ�1.������������Զ���adodataset���ӵı��Լ�dbgrid��ʾ���ֶ�            }
{      2.��ѯ�����������е��ֶΣ����������ַ���ѯ���ݡ�Ҳ�����ڲ��ҿ������ѯ}
{                                                                              }
{******************************************************************************}

unit Main_data095;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Grids, DBGrids, StdCtrls, Menus, ComCtrls,db,
  ADODB;

type

  TfrmMain_data095 = class(TForm)
    Panel1: TPanel;
    DBGrid1: TDBGrid;
    btnNew: TButton;
    btnEdit: TButton;
    btnDelete: TButton;
    Button4: TButton;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    StatusBar1: TStatusBar;
    btnRefresh: TButton;
    Panel2: TPanel;
    label_Key_Field: TLabel;
    edtKeyValue: TEdit;
    ADOConnection1: TADOConnection;
    adsMaster: TADODataSet;
    dsMaster: TDataSource;
    procedure btnDeleteClick(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure DBGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure btnRefreshClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtKeyValueChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure adsMasterNewRecord(DataSet: TDataSet);
  private
    { Private declarations }
    Tmp_Field,Tmp_Input:string;//Tmp_input����Ĳ�����ֵ, Tmp_Field: ��ǰ�����ֶ�
    KeyField: string;//��Ҫ�ֶΣ�������֤�������ݱ��¼�Ƿ��ظ���
    PreColumn: TColumn; //�ϴ�ѡ���column
    //�ж����ݱ�0277��¼�Ƿ���Ա�ɾ�����߱༭,true���ɱ༭��false����(ע�⣺�����д��������override���ǣ���Ҫinherited)
    function Check_Data_Edit_State(keyValue:string):boolean;
    procedure DoSort;//����
    procedure NewGridWnd(var Message: TMessage);

  public
    { Public declarations }
//    FSort: PSort; //�洢�����ֶμ�¼
    procedure DoDelete;virtual;//ɾ��
  end;

var
  frmMain_data095: TfrmMain_data095;

implementation
uses constVar,common,edit_data0277,MyClass;
{$R *.dfm}


procedure TfrmMain_data095.btnDeleteClick(Sender: TObject);
begin
if (strtoint(vprev)=1) or (strtoint(vprev)=3) then
 messagedlg('�Բ���!��û�иó���Ŀ�дȨ��',mtinformation,[mbCancel],0)
else
 DoDelete;
end;

procedure TfrmMain_data095.Button4Click(Sender: TObject);
begin
  close;
end;

procedure TfrmMain_data095.DBGrid1TitleClick(Column: TColumn);
begin
//��������
  Tmp_Field := Column.FieldName;
  PreColumn.Title.Color := clBtnFace;
  Column.Title.Color := clred;
  PreColumn := column;
  DoSort;
  label_Key_Field.Caption := '���ң�'+ Column.Title.Caption;
end;

procedure TfrmMain_data095.DBGrid1KeyPress(Sender: TObject; var Key: Char);
begin
  if Key= Chr(vk_Back) then
    Tmp_input:=copy(Tmp_input,1,Length(Tmp_input)-1)
  else
  begin
    if key<>chr(vk_return) then
    Tmp_Input:=Tmp_Input+Key;
    adsMaster.Locate(Tmp_Field,Tmp_input,[loPartialKey]);
  end;
  StatusBar1.Panels[1].Text := Tmp_Input;
end;

procedure TfrmMain_data095.btnRefreshClick(Sender: TObject);
begin
  adsMaster.Close;
  adsMaster.open;
  FormActivate(Sender);
end;

procedure TfrmMain_data095.DoSort;
begin
  adsMaster.Sort := Tmp_Field +' ASC';
end;

procedure TfrmMain_data095.FormActivate(Sender: TObject);
begin
  StatusBar1.Panels[2].Text := '����'+IntToStr(adsMaster.RecordCount)+' �ʼ�¼';
end;

function TfrmMain_Data095.Check_Data_Edit_State(
  keyValue: string): boolean;
begin
  result := not((keyvalue= 'GENUNIT') or
            (keyvalue= 'GENPARAM') or
            (keyvalue= 'BOM') or
            (keyvalue= 'COST') or
            (keyvalue= 'SO'));
end;
 
procedure TfrmMain_data095.DoDelete;
begin
  if not Check_Data_Edit_State(adsMaster.fieldByName(KeyField).AsString) then
  begin
    ShowMsg('�ü�¼��ϵͳ��ֵ������ɾ��','��ʾ',1);
    exit;
  end;
  if Msg_Dlg_Ask('ȷ��ɾ����¼��','��ʾ',1) then
  begin
    if not DeleteRecord(adsMaster,KeyField,adsMaster.fieldByName(KeyField).Value) then
      ShowMsg('ɾ��ʧ�ܣ�����','��ʾ',1)
    else
      FormActivate(self);
  end;
end;

procedure TfrmMain_data095.btnNewClick(Sender: TObject);
begin
if (strtoint(vprev)=1) or (strtoint(vprev)=3) then
 messagedlg('�Բ���!��û�иó���Ŀ�дȨ��',mtinformation,[mbCancel],0)
else
 begin
  with TfrmEdit_Data0277.Create(Application) do
  try
    Enter(em_Add);
  finally
    free;
  end;
  FormActivate(sender);
 end;
end;

procedure TfrmMain_data095.btnEditClick(Sender: TObject);
begin
if (strtoint(vprev)=1) or (strtoint(vprev)=3) then
 messagedlg('�Բ���!��û�иó���Ŀ�дȨ��',mtinformation,[mbCancel],0)
else
 begin
  if not Check_Data_Edit_State(trim(Is_NUll(adsMaster.fieldByName(KeyField).AsString,''))) then
   ShowMsg('�ü�¼��ϵͳ��ֵ�����ܱ༭','��ʾ',1)
  else
   begin
    with TfrmEdit_Data0277.Create(Application) do
    try
     Enter(em_Edit);
    finally
     free;
    end;
     self.FormActivate(sender);
   end;
 end;
end;

procedure TfrmMain_data095.PopupMenu1Popup(Sender: TObject);
begin
  N2.Enabled:= Check_Data_Edit_State(trim(Is_NUll(adsMaster.fieldByName(KeyField).AsString,'')));
  N4.Enabled:= N2.Enabled;
end;

procedure TfrmMain_data095.DBGrid1DblClick(Sender: TObject);
begin
  with TfrmEdit_Data0277.Create(Application) do
  try
    Enter(em_browse);
  finally
    free;
  end;
end;

procedure TfrmMain_data095.FormShow(Sender: TObject);
begin
  adsMaster.Close;
  adsMaster.open;
  KeyField :='CATEGORY_NAME';
  Tmp_Field:= KeyField;
  PreColumn:= DBGrid1.Columns[0];
  MyDataClass :=TMyDataClass.Create(ADOConnection1);
end;

procedure TfrmMain_data095.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  MyDataClass.Free;
end;

procedure TfrmMain_data095.edtKeyValueChange(Sender: TObject);
begin
  if trim(edtKeyValue.text)<>'' then
  begin
    adsMaster.Filter:=Tmp_Field+ ' like '''+trim(edtKeyValue.TEXT)+'*''';
    adsMaster.Filtered := true;
  end
  else
    adsMaster.Filtered:= false;
end;

procedure TfrmMain_data095.FormCreate(Sender: TObject);
begin
  if not App_Init(ADOConnection1) then
  begin
    ShowMsg('��������ʧ�ܣ�����ϵϵͳ����Ա��','��ʾ',1);
    application.Terminate;
  end;
  OldGridWnd := DBGrid1.WindowProc;
  DBGrid1.WindowProc := NewGridWnd;
  self.Caption :=Application.Title;
end;

procedure TfrmMain_data095.NewGridWnd(var Message: TMessage);
var
 IsNeg : Boolean;
begin
 if Message.Msg = WM_MOUSEWHEEL then
 begin
   IsNeg := Short(Message.WParamHi) < 0;
   if IsNeg then
     DBGrid1.DataSource.DataSet.MoveBy(1)
   else
     DBGrid1.DataSource.DataSet.MoveBy(-1)
 end
 else
   OldGridWnd(Message);
end;


procedure TfrmMain_data095.adsMasterNewRecord(DataSet: TDataSet);
begin
  DataSet.FieldByName('Category_Type').Value := 3;
end;

end.
