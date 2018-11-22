unit Edit_Data0505;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, Buttons, ADODB, DB, StdCtrls, DBCtrls, Mask,
  ImgList, Menus, Grids, DBGrids;

type

  PTreeValue= ^TTreeValue; //����ָ��
  TTreeValue = record      //��ż�¼ֵ
    rKey,dept_ptr,
    ttype:integer; //ttype:0վ��,1����
    bEditMode:byte;//0.���,1.����,2.�޸� 
//    IsNew:boolean;
  end;
  {���ͼ�¼��λ������:
   TreeValue.rKey:����
   �������վ��,��ô��Ҫ��TreeValue.rKey����һ����ʱ����ֵ,������վ��(������ͬ����վ��,
   ����ʱδ���浽���ݿ�,��û��rKey��ֵ,������data0505��Supervisor_ptr�ֶ�����ʱ���,����ǰ��Ҫ���).
  }
  TfrmEdit_Data0505 = class(TForm)
    Panel1: TPanel;
    TreeView1: TTreeView;
    Panel2: TPanel;
    btnExpand: TSpeedButton;
    btnCollapse: TSpeedButton;
    Panel3: TPanel;
    adsData0505: TADODataSet;
    aqTmp: TADOQuery;
    Panel4: TPanel;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    SpeedButton7: TSpeedButton;
    SpeedButton8: TSpeedButton;
    SpeedButton9: TSpeedButton;
    SpeedButton10: TSpeedButton;
    SpeedButton11: TSpeedButton;
    SpeedButton12: TSpeedButton;
    SpeedButton13: TSpeedButton;
    SpeedButton14: TSpeedButton;
    SpeedButton15: TSpeedButton;
    SpeedButton16: TSpeedButton;
    Label6: TLabel;
    SpeedButton17: TSpeedButton;
    Combobox3: TComboBox;
    Memo1: TDBMemo;
    SpeedButton18: TSpeedButton;
    SpeedButton19: TSpeedButton;
    SpeedButton20: TSpeedButton;
    spbtnSave: TSpeedButton;
    SpeedButton22: TSpeedButton;
    DBEdit1: TDBEdit;
    Label1: TLabel;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label3: TLabel;
    dsData050: TDataSource;
    adsTreeData: TADODataSet;
    ImageList: TImageList;
    PopupMenu1: TPopupMenu;
    N11: TMenuItem;
    N3: TMenuItem;
    N15: TMenuItem;
    N5: TMenuItem;
    N12: TMenuItem;
    N4: TMenuItem;
    N7: TMenuItem;
    N13: TMenuItem;
    N8: TMenuItem;
    N14: TMenuItem;
    DBGrid1: TDBGrid;
    Splitter1: TSplitter;
    ADOQuery1: TADOQuery;
    adsUpdate_Sub: TADODataSet;
    checkboxNew: TCheckBox;
    dsParameters: TDataSource;
    adsParameters: TADODataSet;
    procedure btnExpandClick(Sender: TObject);
    procedure btnCollapseClick(Sender: TObject);
    procedure SpeedButton22Click(Sender: TObject);
    procedure SpeedButton17Click(Sender: TObject);
    procedure TreeView1Collapsed(Sender: TObject; Node: TTreeNode);
    procedure TreeView1GetImageIndex(Sender: TObject; Node: TTreeNode);
    procedure TreeView1GetSelectedIndex(Sender: TObject; Node: TTreeNode);
    procedure spbtnSaveClick(Sender: TObject);
    procedure TreeView1Click(Sender: TObject);
    procedure TreeView1Changing(Sender: TObject; Node: TTreeNode;
      var AllowChange: Boolean);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure N11Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure N14Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N15Click(Sender: TObject);
    procedure N12Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure Combobox3Change(Sender: TObject);
    procedure SpeedButton15Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton16Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure adsData0505BeforeEdit(DataSet: TDataSet);
    procedure adsData0505BeforeInsert(DataSet: TDataSet);
    procedure adsData0505BeforeDelete(DataSet: TDataSet);
    procedure DBEdit2Change(Sender: TObject);
  private
    { Private declarations }
    KeyValue,EnterMode:integer;
//    procedure On
    MaxrKey,StepIncNum:integer;//IncNum:progressbar��������
    procedure ExpandTree;
    procedure CreateTreeView(NodeName:string;Node:TTreeNode;level:integer);//�����������úܶ�DataSet��Դ,��ʹ��
    function Check_Before_Post:boolean;
    function UpdateDetail:boolean;//���¹����˳��
    function LocateDataSetItem(TreeNode:TTreeNode):boolean;//��λ��¼
    function AddItem(ItemType:byte;AddType:byte):boolean;//��������Ŀ
    procedure ReleaseTreeValue;//�ͷ�ָ���ڴ�
    function DeleteNodeData(Node:TTreeNode;ChildNode:boolean):boolean;//ɾ���ڵ㲢�ͷŵ����ڵ�ָ��ռ�õ��ڴ�
    function Update_Eng_Param:boolean;
    procedure FieldOnChange(Sender: TField);
  public
    { Public declarations }
    procedure InitForm(pEnterMode:byte;pValue:integer);//���ڳ�ʼ��
  end;

var
  frmEdit_Data0505: TfrmEdit_Data0505;

implementation
uses Main_097,Common,MYClass,ConstVar,processShow;
{$R *.dfm}

procedure TfrmEdit_Data0505.btnExpandClick(Sender: TObject);
begin
  TreeView1.FullExpand;
end;

procedure TfrmEdit_Data0505.btnCollapseClick(Sender: TObject);
begin
  TreeView1.FullCollapse;
end;

procedure TfrmEdit_Data0505.SpeedButton22Click(Sender: TObject);
begin
  close;
end;

procedure TfrmEdit_Data0505.InitForm(pEnterMode:byte;pValue:integer);
var
  aqQuery:TAdoQuery;
begin
//  BtnCancel.Enabled:= BtnSave.Enabled;
  spbtnSave.Enabled := false;
  EnterMode:=pEnterMode;
  KeyValue:= pValue;
  try
    aqQuery:= TadoQuery.Create(self);
    aqQuery.Connection := frmMain_097.ADOConnection1;
    Get_Eng_Table_Formula_List(aqQuery);
    aqQuery.First;
    while not aqQuery.Eof do begin
      Combobox3.Items.Add(aqQuery.fieldbyName('FXY').AsString);
      aqQuery.next;
    end;
  finally
    aqQuery.close;
    aqQuery.free;
  end;
  if EnterMode = em_Add then //1.��� 2.���� 3.�༭
  begin
    frmMain_097.adsMaster.Append;
    adsData0505.close;
    adsData0505.Parameters[0].Value := -100; //��
    adsData0505.open;
    caption := caption + ' [����]';
  end
  else
  begin
    adsData0505.close;
    adsData0505.Parameters[0].Value := frmMain_097.adsMaster.FieldByName('rKey').Value;
    adsData0505.open;
    ExpandTree;
//    CreateTreeView('0',nil,1);
    MyDataClass.OpenDataSetByPara(frmMain_097.adsMaster.fieldbyName('rkey').Value,adsParameters);    
  end;
  if EnterMode =em_Browse  then //���
  begin
    caption := caption + ' [���]';
  end else if enterMode=em_edit then
    caption := caption + ' [�޸�]';
  Memo1.ReadOnly := (EnterMode = em_browse);
  DBEdit1.ReadOnly := Memo1.ReadOnly;
  DBEdit2.ReadOnly := Memo1.ReadOnly;
  adsData0505.FieldByName('formula').OnChange:= FieldOnChange;
  ShowModal;
end;

procedure TfrmEdit_Data0505.SpeedButton17Click(Sender: TObject);
var
  tmp_value:string;
  sp1,sp2:string;
  i,j:integer;
begin
  if EnterMode= em_Browse then exit;
  tmp_value:= Pick_Eng_Param('',frmMain_097.ADOConnection1,2);
  if tmp_value <> '' then
  begin
    adsData0505.Edit;
    sp1:=' ';
    sp2:=' ';
    i:=Memo1.SelStart ;
    j:=Memo1.CaretPos.y;
    if copy(Memo1.Text,i,1)=' ' then sp1:='';
    if copy(Memo1.Text,i+1,1)=' ' then sp2:='';
    memo1.Lines[j]:=copy(memo1.Lines[j],1,i)+sp1+trim(tmp_value)+sp2+copy(memo1.Lines[j],i+1,length(memo1.Lines[j])-i);
    Memo1.SelStart:=i+length(sp1)+length(trim(tmp_value))+length(sp2);
    Memo1.SetFocus ;
  end;
end;

procedure TfrmEdit_Data0505.TreeView1Collapsed(Sender: TObject;
  Node: TTreeNode);
begin
  if Node.HasChildren then
    if Node.Expanded then
      Node.ImageIndex := 1
    else
      Node.ImageIndex := 0;
  TreeView1.Repaint;
end;

procedure TfrmEdit_Data0505.TreeView1GetImageIndex(Sender: TObject;
  Node: TTreeNode);
begin
  if Node.HasChildren then
    if Node.Expanded then
      Node.ImageIndex := 1
    else
      Node.ImageIndex := 0;
end;

procedure TfrmEdit_Data0505.ExpandTree;
VAR
  level:integer;
  mynode:Array [0..9] of Ttreenode;
  nodeTxt:string;
  ptrValue: PTreeValue; //��¼ÿ����Ա����Ϣ,
begin

  adsTreeData.Close;
  adsTreeData.CommandText:=' exec Eng_Flow_Expand '+IntToStr(KeyValue);
  adsTreeData.Open;
  Treeview1.Enabled:=True;
  Treeview1.Items.Clear;   
//���ø��ڵ�
//  mynode[level]:=Treeview.items.add(nil,RootText);
//  mynode[level].ImageIndex:=0;
  with adsTreeData do  begin
    try                                            
      while not Eof do
      begin
        level:=FieldByName('LevelId').asinteger;
        if fieldbyname('ttype').Asinteger=0 then //վ��
          nodeTxt:=trim(FieldByName('node_name').AsString)
        else
        begin
          if level > 1 then
            nodeTxt:=trim(FieldByName('Dept_Name').AsString)+'['+trim(fieldvalues['Dept_code'])+']'
          else
            nodeTxt:=trim(FieldByName('Dept_Name').AsString);
        end;
        if level>0 then
        begin
          New(ptrValue);
          ptrValue.rKey := FieldByName('rKey').asinteger;
          ptrValue.ttype := FieldByName('ttype').asinteger;
          ptrValue.dept_ptr := FieldByName('Dept_ptr').asinteger; //���ڹ���
//          ptrValue.IsNew := false;
          ptrValue.bEditMode := 0;
          if Level= 1 then
            mynode[level]:=Treeview1.items.AddObject(nil,nodeTxt,ptrValue)
          else
            mynode[level]:=Treeview1.items.AddChildObject(mynode[level-1],nodeTxt,ptrValue);
          if FieldByName('ttype').asinteger = 0 then
            mynode[level].ImageIndex:=0
          else
            mynode[level].ImageIndex:=2;
        end;
        next;//��һ����¼
      end;
    finally;
      close;
    End;
  end;
//  TreeView1.FullExpand;
{  TreeView1.Items.Clear ;
  adsTreeData.First;
  with adsTreeData do begin
    while not eof do begin
    if fieldbyname('parent').asinteger>0 then
    begin
        for i:=0 to TreeView1.items.count-1 do
        begin
          if Pinteger(TreeView1.items[i].data)^=fieldbyname('parent').asinteger then
            node:= TreeView1.items[i];
        end;

        if fieldbyname('ttype').asstring='0' then //���ӵ�
        begin
           NODE:=TreeView1.Items.Addchild(node,copy(fieldvalues['node_name'],1,10));
           Node.ImageIndex := 0;
        end else
        begin
           NODE:=TreeView1.Items.Addchild(node,fieldvalues['dept_name']+'['+fieldvalues['dept_code']+']');
           Node.ImageIndex := 2;
        end;
    end else
    begin
        if fieldbyname('ttype').asinteger=0 then
          NODE:=TreeView1.Items.Addchild(nil,copy(fieldvalues['node_name'],1,10))
        else
          NODE:=TreeView1.Items.Addchild(nil,fieldvalues['dept_name']);

        if fieldbyname('ttype').asstring='0' then //���ӵ�
           Node.ImageIndex := 0 else
             Node.ImageIndex := 2;
    end;

    next;
  end;
  if adsTreeData.IsEmpty then
  begin
    Node:=TreeView1.Items.Add(nil,'�հ�');
    Node.ImageIndex := 0;
  end;
  end;}
end;

procedure TfrmEdit_Data0505.TreeView1GetSelectedIndex(Sender: TObject;
  Node: TTreeNode);
begin
  Node.SelectedIndex := Node.ImageIndex;
end;

procedure TfrmEdit_Data0505.spbtnSaveClick(Sender: TObject);
begin
  if adsdata0505.RecordCount > 0 then
  begin
    if adsdata0505.RecordCount > 30 then //30:100����3��30��ѭ��������,���Բ�������Ϊ30������
      StepIncNum := 1
    else
      StepIncNum := 30 div adsdata0505.RecordCount;
  end
  else
      StepIncNum := 1;
  if not Assigned(frmProcessShow) then
  try
    frmProcessShow := TfrmProcessShow.Create(Application);
    frmProcessShow.Show;
    if Check_Before_Post then
    begin
      if not frmMain_097.ADOConnection1.InTransaction then
         frmMain_097.ADOConnection1.BeginTrans;
      try
  //1.��������,�����������¼,���ɵõ�һ�������rkey
        frmMain_097.adsMaster.UpdateBatch(arAll);
  //2.�����ӱ�data0505��eng_flow_ptrֵ
        if not MyDataClass.UpdateValueToField(adsData0505,frmMain_097.adsMaster.fieldByName('rKey').Value,'Eng_Flow_ptr') then
        //if not UpdateDetail then
          abort;
        frmProcessShow.IncStep(StepIncNum,'���ڴ�������...');
  //3.�����ӱ�data0505
        adsData0505.UpdateBatch(arAll);

        if not Update_Eng_Param then    //�����̲���
          abort;
  //4.�ӱ����������ļ�¼,�ͻ����һ��rekey��ֵ,���������ӱ��parent��ֵ��step��ֵ
        if not UpdateDetail then
          abort;

        if not MyDataClass.ExecSql('update data0505 set Supervisor_ptr=NULL where eng_flow_ptr='+frmMain_097.adsMaster.fieldByName('rKey').Asstring) then
          abort;
        frmMain_097.ADOConnection1.CommitTrans;
        frmProcessShow.IncStep(StepIncNum,'���ݴ������');
        spbtnSave.Enabled := false;
      except
        frmMain_097.ADOConnection1.RollbackTrans;
        begin
          ShowMsg('��������ʧ�ܣ�����!','����',1);
          abort;
        end;
      end;
    end
    else
      abort;
    close;
  finally
    frmProcessShow.hide;
    frmProcessShow.Free;
    frmProcessShow:= nil;
  end;
end;

function TfrmEdit_Data0505.Check_Before_Post: boolean;
var
  i:integer;
  sExpr:string;
begin
  frmProcessShow.IncStep(StepIncNum,'���ڼ����������...');
  result := true;
  if trim(DBEdit1.Text)='' then
  begin
    ShowMsg('ģ�����Ʋ���Ϊ��','��ʾ',1);
    result := false;
    exit;
  end;
  frmProcessShow.IncStep(StepIncNum,'���ڼ���ģ�������Ƿ��ظ�...');
  if EnterMode= em_Add then
  if MyDataClass.IsExists('select rKey from data0504 where Eng_Flow_Name='+QuotedStr(trim(DBEdit1.Text))) then
  begin
    ShowMsg('��ǰģ�������Ѿ�����,�����ظ�,����������','��ʾ',1);
    result := false;
    exit;
  end;
  //��֤���й�ʽ��ȷ��
  if adsdata0505.IsEmpty then
  begin
    ShowMsg('������ϸ����Ϊ��','��ʾ',1);
    result := false;
    exit;
  end;
  frmProcessShow.IncStep(StepIncNum,'���ڼ���վ��͹���...');
  for i:= 0 to TreeView1.Items.Count-1 do
  begin
    frmProcessShow.IncStep(StepIncNum,'���ڼ���'+TreeView1.Items[i].text+'��ʽ�Ƿ���ȷ...');
    if LocateDataSetItem(Treeview1.Items[i]) then
//      if not (checkboxNew.Checked and ( not PTreeValue(TreeView1.Items[i].Data)^.IsNew)) then //ֻ��Ҫ�����¼�¼
//      if not (checkboxNew.Checked and ( PTreeValue(TreeView1.Items[i].Data)^.bEditMode=0)) then //ֻ��Ҫ�����¼�¼
        if not Logic_Formula_Check(adsData0505.FieldByName('FORMULA').Asstring,frmMain_097.ADOConnection1,sExpr) then
        begin
          result := false;
          break;
        end;
  end;
end;

function TfrmEdit_Data0505.UpdateDetail: boolean;
var
  i,rKey:integer;
  ParentNo:integer;
begin
//�����ӱ��step��parent
  frmProcessShow.IncStep(StepIncNum,'���ڴ�������...');
  try
    for i:= 0 to TreeView1.Items.Count-1 do
    begin
      frmProcessShow.IncStep(StepIncNum,'���ڴ�������...');
      if LocateDataSetItem(Treeview1.Items[i]) then
      begin
        adsData0505.Edit;
        adsData0505.FieldByName('Step').AsInteger := i+1;
        adsData0505.Post;
        if adsData0505.FieldByName('parent').AsInteger= -9999 then //û�ж��常���,��ôҪ�Ѹ�����ҵ�
        begin
          if LocateDataSetItem(Treeview1.Items[i].Parent) then
            ParentNo:= adsData0505.FieldByName('rKey').Value
          else
          begin
            ShowMsg('���ݱ���δ�ҵ�����ż�¼:'+Treeview1.Items[i].Parent.Text,'��ʾ',1);
            result := false;
            break;
          end;
          if LocateDataSetItem(Treeview1.Items[i]) then
          begin
            adsData0505.Edit;
            adsData0505.FieldByName('parent').Value :=ParentNo;
            adsData0505.Post;
          end;
        end;
      end
      else
      begin
        ShowMsg('û���ҵ���Ӧ��վ���¼'+TreeView1.items[i].Text,'��ʾ',1);
        result := false;
        exit;
      end;
    end;
    adsData0505.UpdateBatch(arAll);
    result := true;
  except
    result := false;
  end;
end;

procedure TfrmEdit_Data0505.TreeView1Click(Sender: TObject);
var
  rKey:integer;
  FieldName,FieldValue:string;
begin
  if TreeView1.Selected = nil then exit;
//  if PTreeValue(TreeView1.Selected.Data)^.IsNew then //������վ��
  if PTreeValue(TreeView1.Selected.Data)^.bEditMode = 1 then //������վ��
    FieldName:='Supervisor_ptr'  //��ʱ���һ��rKeyֵ,��������վ��(δ���浽���ݿ�,��ʵ�ʵ�rKey)
  else
    FieldName:='rKey';
  FieldValue:=IntToStr(PTreeValue(TreeView1.Selected.Data)^.rKey);
  if not adsData0505.Locate(FieldName,FieldValue,[]) then
  begin
    ShowMsg('û���ҵ���Ӧ�ļ�¼'+TreeView1.Selected.Text,'��ʾ',1);
    abort;
  end;
end;

procedure TfrmEdit_Data0505.TreeView1Changing(Sender: TObject;
  Node: TTreeNode; var AllowChange: Boolean);
var
  rKey:integer;
  FieldName,FieldValue:string;
begin
//  if PTreeValue(Node.Data)^.IsNew then //������վ��
  if PTreeValue(Node.Data)^.bEditMode = 1 then //������վ��
    FieldName:='Supervisor_ptr'  //��ʱ���һ��rKeyֵ,��������վ��(δ���浽���ݿ�,��ʵ�ʵ�rKey)
  else
    FieldName:='rKey';
  FieldValue:=IntToStr(PTreeValue(Node.Data)^.rKey);
  if not adsData0505.Locate(FieldName,FieldValue,[]) then
  begin
    ShowMsg('û���ҵ���Ӧ�ļ�¼'+Node.Text,'��ʾ',1);
    abort;
  end;

end;

procedure TfrmEdit_Data0505.PopupMenu1Popup(Sender: TObject);
begin
  if EnterMode = em_Browse then abort;
  if Assigned(TreeView1.Selected) then //δѡ��Node
  begin
    N15.Visible := TreeView1.Selected.ImageIndex <> 2 ;//����
    N7.Visible := TreeView1.Selected.ImageIndex <> 2 ;//����
    N8.Visible := TreeView1.Selected.ImageIndex <> 2 ;//����
  end;
end;

procedure TfrmEdit_Data0505.N11Click(Sender: TObject);
begin
  if not AddItem(1,1) then
    ShowMsg('���վ��ʧ��','��ʾ',1);
end;

function TfrmEdit_Data0505.LocateDataSetItem(TreeNode: TTreeNode): boolean;
var
  FieldName,FieldValue:string;
begin
//  if PTreeValue(TreeNode.data)^.IsNew then//������Item,������վ�㻹�ǹ���,��Ҫ��Supervisor_ptr'���Ҷ�λ��DataSet
  if PTreeValue(TreeNode.data)^.bEditMode = 1 then//������Item,������վ�㻹�ǹ���,��Ҫ��Supervisor_ptr'���Ҷ�λ��DataSet
    FieldName:= 'Supervisor_ptr'
  else
    FieldName:= 'rKey';
  FieldValue:= IntToStr(PTreeValue(TreeNode.data)^.rKey);
  result := adsData0505.Locate(FieldName,FieldValue,[])
end;

function TfrmEdit_Data0505.AddItem(ItemType, AddType: byte): boolean;
var
  InputString: string;
  vrkey:integer;
  Node,NodeNew:TTreeNode;
  ptrValue:PTreeValue;
begin
  result := true;
  try
    MaxrKey := Get_Max_SeqNo(adsData0505,'Supervisor_ptr');
    Node:=Treeview1.Selected ;
    with adsData0505 do begin
      if ItemType = 1 then //1.վ��,2.����
      begin
        InputString:= InputBox('����վ��', 'վ������:', '');
        if trim(InputString)='' then exit;
        append;
        fieldbyname('ttype').asstring:='0';
        fieldbyname('node_name').asstring:=Inputstring;
      end
      else
      begin  //����
        InputString:= VarAsType(Pick_Eng_Flow('',frmMain_097.ADOConnection1,1),varString);
        if trim(InputString)='' then exit;
        append;
        fieldbyname('ttype').asstring:='1';
        fieldbyname('Dept_ptr').asstring:=Inputstring;
        InputString:= MyDataClass.Get_Sql_Value('select rtrim(Dept_Name)+''[''+rtrim(Dept_Code)+'']'' as F01 from data0034 where rKey='+Inputstring);
      end;
      if copy(IntToStr(MaxrKey),1,3) <> '911' then
        fieldbyname('Supervisor_ptr').Asstring := '911'+IntToStr(MaxrKey+1)
      else
        fieldbyname('Supervisor_ptr').Asstring := IntToStr(MaxrKey+1);
      New(ptrValue);
      ptrValue.rKey := fieldbyname('Supervisor_ptr').Asinteger;
      ptrValue.ttype := FieldByName('ttype').asinteger;
//      ptrValue.IsNew := true;
      ptrValue.bEditMode := 1;
      if AddType = 1 then //���ƽ��վ��
        NodeNew:=Treeview1.items.AddObject(Node,Inputstring,ptrValue)
      else if AddType = 2 then //����վ��
        NodeNew:=Treeview1.items.InsertObject(Node,Inputstring,ptrValue)
      else if AddType = 3 then //�����վ��
        NodeNew:=Treeview1.items.AddChildObject(Node,Inputstring,ptrValue);
      if FieldByName('ttype').asinteger = 0 then
        NodeNew.ImageIndex:=0
      else
        NodeNew.ImageIndex:=2;
      if NodeNew.parent<>nil then
      begin
        if not PTreeValue(NodeNew.parent.data)^.bEditMode = 1 then
//        if not PTreeValue(NodeNew.parent.data)^.IsNew then
          fieldbyname('parent').asinteger:=PTreeValue(NodeNew.parent.data)^.rKey
        else
          fieldbyname('parent').asinteger:=-9999 //-9999�����������,��Ҫ���¸����
      end
      else
        fieldbyname('parent').asinteger:=0;
    end;
    result := true;
  except
    result := false;
  end;
  spbtnSave.Enabled := result;
end;

procedure TfrmEdit_Data0505.ReleaseTreeValue;
var
  i:integer;
  pNode: PTreeValue;
  Node : TTreeNode;
begin
  if Treeview1.Items.Count = 0 then
    exit;
  Node := Treeview1.Items.GetFirstNode;
  for i := 0 to Treeview1.Items.Count-1 do
  begin
    pNode := Treeview1.Items.Item[i].Data;
    if (pNode <> nil) and (Node.Level>0) then
    begin
      Dispose(pNode);
      pNode:=nil;
    end;
    Node:=Node.GetNext;
  end;
end;

procedure TfrmEdit_Data0505.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  ReleaseTreeValue;//�ͷ�ָ���ڴ�
end;

procedure TfrmEdit_Data0505.N14Click(Sender: TObject);
var
  i:integer;
  Node,node1:TtreeNode;
begin
  IF Treeview1.Items.Count =1 then
  begin
    ShowMsg('����ɾ���ýڵ㣬�����Ϊ�գ�','��ʾ', 1);
    exit;
  end;
  Node:=Treeview1.selected;
  IF Treeview1.Selected.HasChildren then
  begin
    if not Msg_Dlg_Ask('��Ҫ��������ȫ��ɾ����?','��ʾ',1) then exit;
    for i:=0 to Treeview1.Selected.count-1 do //ɾ���ӽӵ��¼
    begin
      node1:=Treeview1.Selected.Item[i];
      if not DeleteNodeData(Node1,true) then  //
      begin
        ShowMsg('ɾ��ʧ��','��ʾ',1);
        exit;
      end;
    end;
//    if Treeview1.Selected.parent<>nil then
//      Treeview1.Selected.parent.Selected := true;
  end;
  if not DeleteNodeData(Node,false) then //ɾ�����ڵ�
  begin
    ShowMsg('ɾ��ʧ��','��ʾ',1);
    exit;
  end;
  Treeview1.Items.Delete(Node);
  if Treeview1.Selected.parent<>nil then
    Treeview1.Selected.parent.Selected := true;
  spbtnSave.Enabled := true;
end;

function TfrmEdit_Data0505.DeleteNodeData(Node: TTreeNode;ChildNode:boolean):boolean;
var
  PValue:PTreeValue;
  i:integer; 
begin
  result := false;
  if Node.HasChildren and ChildNode then
  begin
    for i := 0 to Node.Count - 1 do
      result := DeleteNodeData(Node.Item[i],true);
    result:= DeleteNodeData(Node,false);
  end
  else
  begin
    PValue:= Node.Data;
    if LocateDataSetItem(Node) then
    begin
      adsData0505.delete;                          //ɾ�����ݼ�¼
      if (pValue <> nil) then
      begin
        Dispose(pValue);  //�ͷ�ָ���ڴ�
        pValue:= nil;
      end;
      result := true;
    end
    else
    begin
      result := false;
      ShowMsg('û���ҵ���صļ�¼,ɾ��ʧ��!','��ʾ',1);
    end;
  end;
  
end;

procedure TfrmEdit_Data0505.N3Click(Sender: TObject);
begin
  if not AddItem(1,2) then
    ShowMsg('����վ��ʧ��','��ʾ',1);
end;

procedure TfrmEdit_Data0505.N15Click(Sender: TObject);
begin
  if not AddItem(1,3) then
    ShowMsg('�����վ��ʧ��','��ʾ',1);
end;

procedure TfrmEdit_Data0505.N12Click(Sender: TObject);
begin
  if not AddItem(2,1) then
    ShowMsg('��ӹ���ʧ��','��ʾ',1);
end;

procedure TfrmEdit_Data0505.N4Click(Sender: TObject);
begin
  if not AddItem(2,2) then
    ShowMsg('���빤��ʧ��','��ʾ',1);
end;

procedure TfrmEdit_Data0505.N7Click(Sender: TObject);
begin
  if not AddItem(2,3) then
    ShowMsg('����ӹ���ʧ��','��ʾ',1);
end;

procedure TfrmEdit_Data0505.N8Click(Sender: TObject);
var
  InputString: string;
  node:TTreeNode;
  ClickedOK:boolean;
begin
  node:=Treeview1.Selected;
  Inputstring:= Node.Text;
  ClickedOK := InputQuery('�µ�վ������', '��վ������:', Inputstring);
  if ClickedOK then
  begin
    if trim(InputString)='' then exit;
      if CompareStr(Node.Text,trim(Inputstring))<>0 then
        if LocateDataSetItem(Node) then
        begin
          adsData0505.edit;
          adsData0505.fieldbyname('node_name').asstring:=Inputstring;
          adsData0505.Post ;
          node.Text :=Inputstring;
          spbtnSave.Enabled := true;
        end;
  end;
end;


procedure TfrmEdit_Data0505.Combobox3Change(Sender: TObject);
var
  sp1,sp2:string;
  i,j:integer;
begin
  if EnterMode= em_browse then exit;
  adsData0505.Edit;
  sp1:=' ';
  sp2:=' ';
  i:=Memo1.SelStart ;
  j:=Memo1.CaretPos.y;
  if copy(Memo1.Text,i,1)=' ' then sp1:='';
  if copy(Memo1.Text,i+1,1)=' ' then sp2:='';
  memo1.Lines[j]:=copy(memo1.Lines[j],1,i)+sp1+trim(Combobox3.Text)+sp2+copy(memo1.Lines[j],i+1,length(memo1.Lines[j])-i);
  Memo1.SelStart:=i+1+length(sp1)+pos('(',trim(Combobox3.Text));
  Memo1.SelLength:=3;
  Memo1.SetFocus ;
end;

procedure TfrmEdit_Data0505.SpeedButton15Click(Sender: TObject);
begin
  if EnterMode= em_browse then exit;
  Memo1.clear
end;

procedure TfrmEdit_Data0505.SpeedButton3Click(Sender: TObject);
var
  sp1,sp2:string;
  i,j:integer;
  symbol_txt:string;
begin
  if EnterMode= em_browse then exit;
  adsData0505.Edit;
  symbol_txt:=(Sender as TSpeedButton).Caption;
  if symbol_txt = 'IF' then
    symbol_txt := 'IF( , , )';
  sp1:=' ';
  sp2:=' ';
  i:=Memo1.SelStart ;
  j:=Memo1.CaretPos.y;
  if copy(Memo1.Text,i,1)=' ' then sp1:='';
  if copy(Memo1.Text,i+1,1)=' ' then sp2:='';
  memo1.Lines[j]:=copy(memo1.Lines[j],1,i)+sp1+trim(symbol_txt)+sp2+copy(memo1.Lines[j],i+1,length(memo1.Lines[j])-i);
  Memo1.SelStart:=i+1+length(sp1)+pos('(',trim(symbol_txt));
  Memo1.SelLength:=3;
  Memo1.SetFocus ;
end;

procedure TfrmEdit_Data0505.SpeedButton16Click(Sender: TObject);
var tmp:string;
begin
  tmp:='';
  if not Logic_Formula_Check(Memo1.text,frmMain_097.ADOConnection1,tmp) then
    abort;
  ShowMsg('��֤ͨ��','��ʾ',1);
end;

function TfrmEdit_Data0505.Update_Eng_Param: boolean;
var
  vstring,vstring1:string;
begin
  frmProcessShow.IncStep(StepIncNum,'���ڸ��¹��̲���...');
  result := true;
  try
    MyDataClass.OpenDataSetByPara(frmMain_097.adsMaster.fieldbyName('rkey').Value,adsUpdate_sub);
    MyDataClass.DeleteTable(adsUpdate_Sub);
    Adoquery1.close;
    Adoquery1.open;
    adsData0505.First;
    while not adsData0505.Eof do begin //ѭ����Ŀ��
      if trim(Memo1.text)<>'' then
      begin
        //����ɵļ�¼, �Ͳ�����
//        if not (checkboxNew.Checked and (copy(adsData0505.FieldByName('Supervisor_ptr').AsString,1,3)<>'911'))then //ֻ��Ҫ�����¼�¼
        begin
          vstring := AnsiUpperCase(' '+ Memo1.Text+' ');
          Adoquery1.first;
          with Adoquery1 do
          while not eof do                             //�Բ�����ѭ��
          begin
            vstring1:=' '+AnsiUpperCase(trim(fieldbyname('Parameter_name').AsString))+' ';
            if pos(vstring1,vstring)>0 then
            begin
              frmProcessShow.IncStep(StepIncNum,'���ڸ��¹��̲���...');
              if not adsUpdate_Sub.Locate('Parameter_ptr', AdoQuery1.fieldbyname('rkey').asstring,[]) then
              begin
                adsUpdate_Sub.Append;
                adsUpdate_Sub.FieldByName('Parameter_ptr').asstring:= AdoQuery1.fieldbyname('rkey').asstring;
                adsUpdate_Sub.FieldByName('Source_ptr').asstring:= frmMain_097.adsMaster.fieldbyName('rkey').Value;
                adsUpdate_Sub.FieldByName('ttype').asstring:= '1';
                adsUpdate_Sub.Post;
              end;
            end;
            next;
          end;
        end;
      end;
      adsData0505.next;
    end;
    Adoquery1.close;
//    if adsUpdate_sub.Modified then
    adsUpdate_sub.UpdateBatch(arAll);
//    MyDataClass.OpenDataSetByPara(frmMain_167.adsMaster.fieldbyName('rkey').Asstring,adsParamList);
  except
    result := false;
  end;
end;

procedure TfrmEdit_Data0505.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if spbtnSave.Enabled then
  begin
    canclose:= Msg_Dlg_Ask('��ǰ�޸�û�б�����,��ȷ�������޸Ĳ��˳���?','��ʾ',1);
    if canclose then
      if  frmMain_097.adsMaster.State in dsEditModes then
         frmMain_097.adsMaster.CancelUpdates;
  end
  else
    if frmMain_097.adsMaster.State in dsEditModes then
      frmMain_097.adsMaster.CancelUpdates;
end;

procedure TfrmEdit_Data0505.adsData0505BeforeEdit(DataSet: TDataSet);
begin
  frmMain_097.adsMaster.edit;
  spbtnSave.Enabled := true;
  if treeview1.Selected <> nil then
  begin
    if PTreeValue(treeview1.Selected.data)^.bEditMode = 0 then
    begin
      PTreeValue(treeview1.Selected.data)^.bEditMode := 2;
    end;
  end
  else
  begin
    ShowMsg('û���ҵ���Ӧ����Ŀ!','��ʾ',1);
    abort;
  end;
end;

procedure TfrmEdit_Data0505.adsData0505BeforeInsert(DataSet: TDataSet);
begin
  frmMain_097.adsMaster.edit;
  spbtnSave.Enabled := true;
end;

procedure TfrmEdit_Data0505.adsData0505BeforeDelete(DataSet: TDataSet);
begin
  frmMain_097.adsMaster.edit;
  spbtnSave.Enabled := true;
end;

procedure TfrmEdit_Data0505.FieldOnChange(Sender: TField);
var
  tmpstr:string;
begin
{  if copy(IntToStr(MaxrKey),1,3)='911' then
    tmpstr:= IntToStr(MaxrKey+2)
  else
    tmpstr:= '911'+IntToStr(MaxrKey+2);
//�����ǰ��¼����������,��ô��Ҫ����ʱ���ֶ�Supervisor_ptr�и�һ��'9110001'�����,�ڸ��¹��̲�����ʱ��,����ʶ��ù�ʽ�Ƿ��޸Ĺ�.
  if uppercase(sender.FieldName) = 'FORMULA' then
  begin
//    if Sender.IsNull then exit;
    if treeview1.Selected <> nil then
    begin
      if PTreeValue(treeview1.Selected.data)^.bEditMode <> 1 then
      begin
        adsData0505.FieldByName('Supervisor_ptr').Asstring := tmpstr;
      end;
    end
    else
    begin
      ShowMsg('û���ҵ���Ӧ����Ŀ!','��ʾ',1);
      abort;
    end;
  end;}
end;

procedure TfrmEdit_Data0505.DBEdit2Change(Sender: TObject);
begin
  if EnterMode= em_browse then abort;
  frmMain_097.adsMaster.Edit;
  spbtnSave.Enabled := true;
end;

procedure TfrmEdit_Data0505.CreateTreeView(NodeName: string;
  Node: TTreeNode;level:integer);
var  mLocalName: string;  TreeNode: TTreeNode;
     Ads_Tmp: TADODataSet;
     nodeTxt:string;
  ptrValue: PTreeValue; //��¼ÿ����Ա����Ϣ,
begin
  ADS_Tmp := TADODataSet.Create(Self);
  ADS_Tmp.Connection := frmMain_097.ADOConnection1;
  ADS_Tmp.LockType := ltBatchOptimistic;
  with ADS_Tmp do  begin
    Close;
    CommandText := //' select * from data0505 P where eng_flow_ptr=12 and IsNULL(parent,0)='+NodeName+' order by step';
                   ' select P.rkey, p.tType, p.Parent, p.Dept_ptr,P.Node_Name,P.step from data0505 P '+
                   ' where Eng_Flow_ptr='+IntTostr(KeyValue)+' and IsNULL(parent,0)='+NodeName+' order by step';
    Open;
    First;
    while not Eof do begin
      if fieldbyname('ttype').Asinteger=0 then //վ��
        nodeTxt:=trim(FieldByName('node_name').AsString)
      else
      begin
        if level > 1 then
          nodeTxt:=trim(FieldByName('Dept_Name').AsString)+'['+trim(fieldvalues['Dept_code'])+']'
        else
          nodeTxt:=trim(FieldByName('Dept_Name').AsString);
      end;
      if level>0 then
      begin
        New(ptrValue);
        ptrValue.rKey := FieldByName('rKey').asinteger;
        ptrValue.ttype := FieldByName('ttype').asinteger;
        ptrValue.dept_ptr := FieldByName('Dept_ptr').asinteger; //���ڹ���
//          ptrValue.IsNew := false;
        ptrValue.bEditMode := 0;
        if Level= 1 then
          TreeNode:=Treeview1.items.AddObject(nil,nodeTxt,ptrValue)
        else
          TreeNode:=Treeview1.items.AddChildObject(node,nodeTxt,ptrValue);
        if FieldByName('ttype').asinteger = 0 then
          TreeNode.ImageIndex:=0
        else
          TreeNode.ImageIndex:=2;
      end;
      Inc(Level);
      mLocalName := FieldbyName('rKey').Asstring;
      CreateTreeView(mLocalName, TreeNode,Level);
      Next;
    end;
  end;
end;

end.
