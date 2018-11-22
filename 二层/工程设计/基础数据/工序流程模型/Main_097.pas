{******************************************************************************}
{                                                                              }
{Code Maker: Jacky Zhong                                                       }
{Date: Apr. 07. 2007                                                           }
{Comments:                                                                     }
{���ܣ�1.������������Զ���adodataset���ӵı��Լ�dbgrid��ʾ���ֶ�            }
{      2.��ѯ�����������е��ֶΣ����������ַ���ѯ���ݡ�Ҳ�����ڲ��ҿ������ѯ}
{                                                                              }
{******************************************************************************}

unit Main_097;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Grids, DBGrids, StdCtrls, Menus, ComCtrls,db,
  ADODB;

type

  TfrmMain_097 = class(TForm)
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
    N6: TMenuItem;
    Button1: TButton;
    ADOStoredProc1: TADOStoredProc;
    procedure btnDeleteClick(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure DBGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure btnRefreshClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
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
    function ExecCopy(rKey:integer;ModName,ModDesc:string;var NewRkey:integer):boolean;
  public
    { Public declarations }
//    FSort: PSort; //�洢�����ֶμ�¼
    procedure DoDelete;virtual;//ɾ��
  end;

var
  frmMain_097: TfrmMain_097;

implementation
uses constVar,common,MyClass,Edit_Data0505,Dlg_Copy;
{$R *.dfm}

procedure TfrmMain_097.btnDeleteClick(Sender: TObject);
begin
  if (strtoint(vprev)=1) or (strtoint(vprev)=3) then
    messagedlg('�Բ���!��û�иó���Ŀ�дȨ��',mtinformation,[mbCancel],0)
  else if not adsMaster.IsEmpty then
    DoDelete;
end;

procedure TfrmMain_097.Button4Click(Sender: TObject);
begin
  close;
end;

procedure TfrmMain_097.DBGrid1TitleClick(Column: TColumn);
begin
//��������
  Tmp_Field := Column.FieldName;
  PreColumn.Title.Color := clBtnFace;
  Column.Title.Color := clred;
  PreColumn := column;
  DoSort;
  label_Key_Field.Caption := '���ң�'+ Column.Title.Caption;
end;

procedure TfrmMain_097.DBGrid1KeyPress(Sender: TObject; var Key: Char);
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

procedure TfrmMain_097.btnRefreshClick(Sender: TObject);
begin
  adsMaster.Close;
  adsMaster.open;
  FormActivate(Sender);
end;

procedure TfrmMain_097.DoSort;
begin
  adsMaster.Sort := Tmp_Field +' ASC';
end;

procedure TfrmMain_097.FormActivate(Sender: TObject);
begin
  StatusBar1.Panels[2].Text := '����'+IntToStr(adsMaster.RecordCount)+' �ʼ�¼';
end;

function TfrmMain_097.Check_Data_Edit_State(
  keyValue: string): boolean;
begin
end;
 
procedure TfrmMain_097.DoDelete;
begin
  if Msg_Dlg_Ask('ȷ��ɾ����¼��','��ʾ',1) then
  begin
//    if not DeleteRecord(adsMaster,KeyField,adsMaster.fieldByName(KeyField).Value) then
    if not MyDataClass.ExecSql(' delete from data0506 where ttype=1 and source_ptr ='+frmMain_097.adsMaster.fieldByName('rKey').Asstring +//in (select rkey from data0505 where eng_flow_ptr='+ frmMain_097.adsMaster.fieldByName('rKey').Asstring+') '+
                               ' delete from data0505 where eng_flow_ptr='+frmMain_097.adsMaster.fieldByName('rKey').Asstring +
                               ' delete from data0504 where rkey='+adsMaster.fieldByName('rKey').AsString) then
      ShowMsg('ɾ��ʧ�ܣ�����','��ʾ',1)
    else
    begin
      adsMaster.close;
      adsMaster.Open;
      FormActivate(self);
    end;
  end;
end;

procedure TfrmMain_097.btnNewClick(Sender: TObject);
begin
  if (strtoint(vprev)=1) or (strtoint(vprev)=3) then
    messagedlg('�Բ���!��û�иó���Ŀ�дȨ��',mtinformation,[mbCancel],0)
  else
  begin
    with TfrmEdit_Data0505.Create(Application) do
    try
      InitForm(em_Add,-100);
  //    ShowModal;
    finally
      free;
    end;
    FormActivate(sender);
  end;
end;

procedure TfrmMain_097.btnEditClick(Sender: TObject);
begin
{  if not Check_Data_Edit_State(trim(Is_NUll(adsMaster.fieldByName(KeyField).AsString,''))) then
  begin
    ShowMsg('�ü�¼��ϵͳ��ֵ�����ܱ༭','��ʾ',1);
    exit;
  end;}
  if (strtoint(vprev)=1) or (strtoint(vprev)=3) then
    messagedlg('�Բ���!��û�иó���Ŀ�дȨ��',mtinformation,[mbCancel],0)
  else
  begin
    with TfrmEdit_Data0505.Create(Application) do
    try
      InitForm(em_Edit,adsMaster.fieldbyName('rKey').AsInteger);
  //    ShowModal;
    finally
      free;
    end;
    FormActivate(sender);
  end;
end;

procedure TfrmMain_097.PopupMenu1Popup(Sender: TObject);
begin
//  N2.Enabled:= Check_Data_Edit_State(trim(Is_NUll(adsMaster.fieldByName(KeyField).AsString,'')));
//  N4.Enabled:= N2.Enabled;
end;

procedure TfrmMain_097.FormShow(Sender: TObject);
begin
//  ADOConnection1.Connected := true;
  adsMaster.Close;
  adsMaster.open;
  KeyField :='ENG_FLOW_NAME';
  Tmp_Field:= KeyField;
  PreColumn:= DBGrid1.Columns[0];
//���ṹ������ֵ����¼ÿ���ֶ�����ķ���
  MyDataClass :=TMyDataClass.Create(ADOConnection1);
end;

procedure TfrmMain_097.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  MyDataClass.Free;
end;

procedure TfrmMain_097.edtKeyValueChange(Sender: TObject);
begin
  if trim(edtKeyValue.text)<>'' then
  begin
    adsMaster.Filter:=Tmp_Field+ ' like '''+trim(edtKeyValue.TEXT)+'*''';
    adsMaster.Filtered := true;
  end
  else
    adsMaster.Filtered:= false;
end;

procedure TfrmMain_097.FormCreate(Sender: TObject);
begin
  if not App_Init(ADOConnection1) then
  begin
    ShowMsg('��������ʧ�ܣ�����ϵϵͳ����Ա��','��ʾ',1);
    application.Terminate;
  end;

//  vprev:='4';
//  App_Test( ADOConnection1);
  OldGridWnd := DBGrid1.WindowProc;
  DBGrid1.WindowProc := NewGridWnd;
  self.Caption :=Application.Title;
end;

procedure TfrmMain_097.NewGridWnd(var Message: TMessage);
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

procedure TfrmMain_097.N6Click(Sender: TObject);
begin
  with TfrmEdit_Data0505.Create(application)do
  try
    InitForm(em_Browse,adsMaster.fieldByName('rKey').AsInteger);
  finally
    free;
  end;
end;

procedure TfrmMain_097.Button1Click(Sender: TObject);
var
  NewRKey:integer;
begin
  if (strtoint(vprev)=1) or (strtoint(vprev)=3) then
  begin
    messagedlg('�Բ���!��û�иó���Ŀ�дȨ��',mtinformation,[mbCancel],0);
    exit;
  end;
  NewRKey:=-1000;
  with TfrmDlg_Copy.Create(Application)do
  try
    if showmodal = mrok then
    begin
      if not ExecCopy(adsMaster.fieldByName('rKey').AsInteger,trim(edtModName.Text),trim(edtModDesc.Text),NewRKey) then
      begin
        ShowMsg('����ʧ�ܣ����飡',1);
        exit;
      end;
    end;
  finally
    free;
  end;
  if NewRKey=-1000 then exit;
//  ShowMsg('New rkey:'+IntToStr(NewrKey),1);
  adsMaster.Close;
  adsMaster.open;
  adsMaster.Locate('rKey',NewRKey,[loCaseInsensitive]);
  FormActivate(Sender);
end;

function TfrmMain_097.ExecCopy(rKey:integer;ModName, ModDesc: string;var NewRkey:integer):boolean;
var
  spName:string;
  Params:Array [0..4] of variant;
  Direction: array [0..4] of TParameterDirection;
begin
{  spName := 'Copy_Eng_Flow';

  Params[0] := 0;
  Params[1] := rKey;
  Params[2] := ModName;
  Params[3] :=  ModDesc;
  Params[4] :=  0;

  Direction[0] := pdReturnValue;
  Direction[1] := pdInput;
  Direction[2] := pdInput;
  Direction[3] := pdInput;
  Direction[4] := pdOutput;
  try
    MyDataCLass.ExecProc(spName, Params, Direction);
    newRKey:= VarAsType(Params[4],varInteger);
  finally
    result := VarAsType(Params[0],varInteger)=0;//0���³ɹ�������ʧ��
  end;}
  ADOStoredProc1.Parameters.ParamByName('@rkey_Org').Value:=rKey;
  ADOStoredProc1.Parameters.ParamByName('@ModName').Value:=ModName;
  ADOStoredProc1.Parameters.ParamByName('@ModDesc').Value:=ModDesc;
//  ADOStoredProc1.Parameters.ParamByName('@rKey_New').Value:=0;
  try
    ADOStoredProc1.ExecProc;
    result := ADOStoredProc1.Parameters.ParamByName('@RETURN_VALUE').Value=0;
    NewRkey:= ADOStoredProc1.Parameters.ParamByName('@rKey_New').Value;
  except
    result := false;
  end;
end;

end.
