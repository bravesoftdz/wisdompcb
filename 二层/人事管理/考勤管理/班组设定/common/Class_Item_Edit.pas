{******************************************************************************}
{                                                                              }
{Code Maker: Jacky Zhong                                                       }
{Date: Jun. 17. 2007                                                           }
{Comments: �õ�Ԫ��һ�����ڵ�������ĸ��׿��ࡣ��װ�˻������������ڼ̳�        }
{���ܣ�1.������������Զ���adodataset���ӵı��Լ�dbgrid��ʾ���ֶ�            }
{      2.��ѯ�����������е��ֶΣ����������ַ���ѯ���ݡ�Ҳ�����ڲ��ҿ������ѯ}
{                                                                              }
{******************************************************************************}

unit Class_Item_Edit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Grids, DBGrids, StdCtrls, Menus, ComCtrls,db,
  ADODB;

type

//�ֶ�����ṹ���������ڼ�¼�ֶ�����ʽ
  PSort = record
   KeyField: array  of string;
   SortType : array  of string; //1������2������
  end;

  TfrmClass_Item_Edit = class(TForm)
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
    procedure DBGrid1CellClick(Column: TColumn);
    procedure btnRefreshClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure edtKeyValueChange(Sender: TObject);
  private
    { Private declarations }
    Tmp_Input:string;//����Ĳ�����ֵ
    function ReturnSortType(KeyField:string):string;//�ڼ�¼FSort�в�������ʽ��û�ҵ��ͷ���''����������ʽ����Ϊ�෴����ֵ���磺ԭ��������ȡֵ��͸�Ϊ����
    //�ж����ݱ�0277��¼�Ƿ���Ա�ɾ�����߱༭,true���ɱ༭��false����(ע�⣺�����д��������override���ǣ���Ҫinherited)
//    function Check_Data0277_Edit_State(keyValue:string):boolean;virtual;
    procedure DoSort;//����
  public
    { Public declarations }
    KeyField: string;//��Ҫ�ֶΣ�������֤�������ݱ��¼�Ƿ��ظ���
    FSort: PSort; //�洢�����ֶμ�¼
    procedure DoDelete;virtual;//ɾ��
  end;

var
  frmClass_Item_Edit: TfrmClass_Item_Edit;

implementation
uses constVar,common;
{$R *.dfm}

procedure TfrmClass_Item_Edit.btnDeleteClick(Sender: TObject);
begin
  DoDelete;
end;

procedure TfrmClass_Item_Edit.Button4Click(Sender: TObject);
begin
  close;
end;

procedure TfrmClass_Item_Edit.DBGrid1TitleClick(Column: TColumn);
begin
//��������
  DoSort;
end;

procedure TfrmClass_Item_Edit.DBGrid1KeyPress(Sender: TObject; var Key: Char);
begin
  if Key= Chr(vk_Back) then
    Tmp_input:=copy(Tmp_input,1,Length(Tmp_input)-1)
  else
  begin
    if key<>chr(vk_return) then
    Tmp_Input:=Tmp_Input+Key;
    adsMaster.Locate(Dbgrid1.SelectedField.FieldName,Tmp_input,[loPartialKey]);
  end;
  StatusBar1.Panels[1].Text := Tmp_Input;
end;

procedure TfrmClass_Item_Edit.DBGrid1CellClick(Column: TColumn);
begin
  StatusBar1.Panels[1].Text := Tmp_Input;
  label_Key_Field.Caption := '���ң�'+GetColumnCaption(dbgrid1.SelectedField.FieldName,dbgrid1);
end;

procedure TfrmClass_Item_Edit.btnRefreshClick(Sender: TObject);
begin
  adsMaster.Close;
  adsMaster.open;
  FormActivate(Sender);
end;

function TfrmClass_Item_Edit.ReturnSortType(KeyField: string): string;
var
  i:integer;
begin
  result := '';
  for i := Low(FSort.KeyField) to high(FSort.KeyField) do
  begin
    if Fsort.KeyField[i] = trim(KeyField) then
    begin
      result := Fsort.SortType[i];
//ȡֵ�󣬸ı�����ʽ�������´�ȡ���෴������ʽ
      if Fsort.SortType[i]='ASC' then
        Fsort.SortType[i]:='DESC'
      else
        Fsort.SortType[i]:='ASC';
    end;
  end;
end;

procedure TfrmClass_Item_Edit.DoSort;
var
  SortType:string;
begin
  SortType:=ReturnSortType(Dbgrid1.SelectedField.FieldName);
  if SortType <> '' then
    adsMaster.Sort := Dbgrid1.SelectedField.FieldName +' '+SortType;
end;

procedure TfrmClass_Item_Edit.FormActivate(Sender: TObject);
begin
  StatusBar1.Panels[2].Text := '����'+IntToStr(adsMaster.RecordCount)+' �ʼ�¼';
end;



{
function TfrmClass_Item_Edit.Check_Data0277_Edit_State(
  keyValue: string): boolean;
begin
  result := not((keyvalue= 'GENUNIT') or
            (keyvalue= 'GENPARAM') or
            (keyvalue= 'BOM') or
            (keyvalue= 'COST') or
            (keyvalue= 'SO'));
end;
 }
procedure TfrmClass_Item_Edit.DoDelete;
begin
  if Msg_Dlg_Ask('ȷ��ɾ����¼��','��ʾ',1) then
  begin
    if not DeleteRecord(adsMaster,KeyField,adsMaster.fieldByName(KeyField).Value) then
      ShowMsg('ɾ��ʧ�ܣ�����','��ʾ',1);
  end;
  FormActivate(self);
end;

procedure TfrmClass_Item_Edit.edtKeyValueChange(Sender: TObject);
begin
  adsMaster.Locate(dbgrid1.SelectedField.FieldName,trim(edtKeyValue.Text),[loPartialKey]);
end;

end.
