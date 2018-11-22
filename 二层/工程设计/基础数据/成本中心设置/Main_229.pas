{******************************************************************************}
{                                                                              }
{Code Maker: Jacky Zhong                                                       }
{Date: May. 05. 2007                                                           }
{Comments:                                                                     }
{���ܣ�1.������������Զ���adodataset���ӵı��Լ�dbgrid��ʾ���ֶ�            }
{      2.��ѯ�����������е��ֶΣ����������ַ���ѯ���ݡ�Ҳ�����ڲ��ҿ������ѯ}
{                                                                              }
{******************************************************************************}

unit Main_229;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Grids, DBGrids, StdCtrls, Menus, ComCtrls,db,
  ADODB;

type

  TfrmMain_229 = class(TForm)
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
    adsMaster: TADODataSet;
    dsMaster: TDataSource;
    N6: TMenuItem;
    Button1: TButton;
    procedure btnDeleteClick(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure DBGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure btnRefreshClick(Sender: TObject);
    procedure btnNewClick(Sender: TObject);
    procedure btnEditClick(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edtKeyValueChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
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
    Tmp_Field_Value:variant;
    procedure DoDelete;virtual;//ɾ��
  end;

var
  frmMain_229: TfrmMain_229;

implementation
uses constVar,common,MyClass,SubEdit,dm;
{$R *.dfm}

procedure TfrmMain_229.FormCreate(Sender: TObject);
begin



//  user_ptr:='785';
//  vprev:='4';
//  dmcon.ADOConnection1.Open;


  if not App_Init(dmcon.ADOConnection1) then
  begin
    ShowMsg('��������ʧ�ܣ�����ϵϵͳ����Ա��','��ʾ',1);
    application.Terminate;
  end;


  self.Caption :=Application.Title;


  
  with dmCon do begin
    aqMatrl.Close;
    aqMatrl.Open;
    aqMatrlGroup.Close;
    aqMatrlGroup.Open;
  end;
  Tmp_Field_Value:='';
  OldGridWnd := DBGrid1.WindowProc;
  DBGrid1.WindowProc := NewGridWnd;
end;

procedure TfrmMain_229.btnDeleteClick(Sender: TObject);
begin
  if (strtoint(vprev)=1) or (strtoint(vprev)=3) then
    messagedlg('�Բ���!��û�иó���Ŀ�дȨ��',mtinformation,[mbCancel],0)
  else if not adsMaster.IsEmpty then
    DoDelete;
end;

procedure TfrmMain_229.Button4Click(Sender: TObject);
begin
  close;
end;

procedure TfrmMain_229.DBGrid1TitleClick(Column: TColumn);
begin
//��������
  Tmp_Field := Column.FieldName;
  PreColumn.Title.Color := clBtnFace;
  Column.Title.Color := clred;
  PreColumn := column;
  DoSort;
  label_Key_Field.Caption := '���ң�'+ Column.Title.Caption;
end;

procedure TfrmMain_229.DBGrid1KeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmMain_229.btnRefreshClick(Sender: TObject);
var
  FieldValue:string;
begin
  FieldValue:= adsMaster.fieldbyName('rKey').AsString;
  adsMaster.Close;
  adsMaster.open;
  adsMaster.Locate('rKey',FieldValue,[]);
  StatusBar1.Panels[2].Text := '����'+IntToStr(adsMaster.RecordCount)+' �ʼ�¼';
end;

procedure TfrmMain_229.DoSort;
begin
  adsMaster.Sort := Tmp_Field +' ASC';
end;

function TfrmMain_229.Check_Data_Edit_State(
  keyValue: string): boolean;
begin
end;
 
procedure TfrmMain_229.DoDelete;
var Sqlstr:string;
begin
  if Msg_Dlg_Ask('ȷ��ɾ����¼��','��ʾ',1) then
  begin
    Tmp_Field_Value:= adsMaster.fieldbyName('Dept_Code').AsString;
    Sqlstr:='delete from data0506 where  ttype=3 and source_ptr='+ adsMaster.fieldbyName('rKey').AsString+
            ' delete from data0034 where rKey='+adsMaster.fieldbyName('rKey').AsString;
    if not MydataClass.ExecSql(sqlstr) then
      ShowMsg('ɾ��ʧ��',1);

  end;
end;

procedure TfrmMain_229.btnNewClick(Sender: TObject);
begin
  if (strtoint(vprev)=1) or (strtoint(vprev)=3) then
    messagedlg('�Բ���!��û�иó���Ŀ�дȨ��',mtinformation,[mbCancel],0)
  else
  begin
{    with TfrmEdit_Data0506.Create(Application) do
    try
      Enter(em_Add,'-100');
  //    ShowModal;
    finally
      free;
    end;
    FormActivate(sender);
 } end;
end;

procedure TfrmMain_229.btnEditClick(Sender: TObject);
begin
  if (strtoint(vprev)=1) or (strtoint(vprev)=3) then
    messagedlg('�Բ���!��û�иó���Ŀ�дȨ��',mtinformation,[mbCancel],0)
  else
  begin
    frmSubEdit:= TfrmSubEdit.Create(Application);
    try
      frmSubEdit.rkey34:= self.adsMaster.fieldbyName('rKey').value;
      frmSubEdit.Enter(em_Edit,self.adsMaster.fieldbyName('rKey').value);
  //    ShowModal;
    finally
      frmSubEdit.free;
    end;
    btnRefreshClick(sender);
  end;
end;

procedure TfrmMain_229.PopupMenu1Popup(Sender: TObject);
begin
//  N2.Enabled:= Check_Data_Edit_State(trim(Is_NUll(adsMaster.fieldByName(KeyField).AsString,'')));
//  N4.Enabled:= N2.Enabled;
end;

procedure TfrmMain_229.FormShow(Sender: TObject);
begin
//  ADOConnection1.Connected := true;
  adsMaster.Close;
  adsMaster.open;
  KeyField :='Dept_Code';
  Tmp_Field:= KeyField;
  PreColumn:= DBGrid1.Columns[0];
//���ṹ������ֵ����¼ÿ���ֶ�����ķ���
  MyDataClass :=TMyDataClass.Create(dmcon.ADOConnection1);

  StatusBar1.Panels[2].Text := '����'+IntToStr(adsMaster.RecordCount)+' �ʼ�¼';
end;

procedure TfrmMain_229.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  MyDataClass.Free;
end;

procedure TfrmMain_229.edtKeyValueChange(Sender: TObject);
begin
  if trim(edtKeyValue.text)<>'' then
  begin
    adsMaster.Filter:=Tmp_Field+ ' like ''*'+trim(edtKeyValue.TEXT)+'*''';
    adsMaster.Filtered := true;
  end
  else
    adsMaster.Filtered:= false;
end;

procedure TfrmMain_229.NewGridWnd(var Message: TMessage);
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

procedure TfrmMain_229.N6Click(Sender: TObject);
begin
    frmSubEdit:= TfrmSubEdit.Create(Application);
    try
      frmSubEdit.Enter(em_Browse,self.adsMaster.fieldbyName('rKey').value);
  //    ShowModal;
    finally
      frmSubEdit.free;
    end;

end;

procedure TfrmMain_229.Button1Click(Sender: TObject);
begin
  if not DBGrid1.DataSource.DataSet.IsEmpty then
    Export_dbGrid_to_Excel(DBGrid1, '�ɱ���������');
end;

end.
