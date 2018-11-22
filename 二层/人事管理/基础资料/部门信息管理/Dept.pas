unit Dept;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, ComCtrls,ADODB,UDM, Menus, StdCtrls,Mdd, Buttons,
  ExtCtrls, ImgList,common;

type
    Tfm_dept = class(TForm)
    pm_tree: TPopupMenu;
    add: TMenuItem;
    mody: TMenuItem;
    del: TMenuItem;
    edt_search: TEdit;
    btn_search: TBitBtn;
    bbt_exit: TBitBtn;
    bbt_refresh: TBitBtn;
    sb_buttom: TStatusBar;
    pnl_location: TPanel;
    tv_display: TTreeView;
    dg_dept: TDBGrid;
    img_dept: TImageList;
    Label1: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    Label2: TLabel;
    Label3: TLabel;
    CheckBox1: TCheckBox;
    procedure FormCreate(Sender: TObject);
    procedure CreateNode(ParentNode:TTreeNode;Query:TADOQuery);
    procedure CreateTree();
    procedure tv_displayClick(Sender: TObject);
    procedure addClick(Sender: TObject);
    procedure bbt_exitClick(Sender: TObject);
    procedure modyClick(Sender: TObject);
    procedure delClick(Sender: TObject);
    procedure tv_displayDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure tv_displayDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure bbt_refreshClick(Sender: TObject);
    procedure pm_treePopup(Sender: TObject);
    procedure btn_searchClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure dg_deptTitleClick(Column: TColumn);
    procedure CheckBox1Click(Sender: TObject);
    //function isparent(child:TTreeNode;parent:TTreeNode):Boolean;
  private
    k: integer;
  public
    { Public declarations }
  end;

var
  fm_dept: Tfm_dept;

implementation
{$R *.dfm}

procedure Tfm_dept.CreateNode(ParentNode: TTreeNode;Query: TADOQuery);
var
  ChildNode:TTreeNode; //���ӽ��
  NodeInfo:^Integer; //rkey
  QueryTmp:TADOQuery;
begin
  QueryTmp:=TADOQuery.Create(Self);
  QueryTmp.Clone(Query);
  with QueryTmp do
  begin
    Filtered:=False;
    sort := 'departmentcode';
    Filter:= 'superior='+ IntToStr(Integer(ParentNode.Data^));
    Filtered:=true;
      
    while not Eof do
    begin
      New(NodeInfo);

      NodeInfo^:= FieldByName('rkey').AsInteger;
      ChildNode:=tv_display.Items.AddChildObject(ParentNode,FieldByName('departmentname').AsString,NodeInfo); //��Ӻ��ӽ�㣬���������ӽ����Ϣ
      childnode.ImageIndex:=0;
      CreateNode(ChildNode,Query); //�ݹ�
      Next;
    end;
    childnode.ImageIndex:=1;
    Free; //�ͷ����õ�query
  end;
end;

procedure Tfm_dept.CreateTree();
var
  BootNode:TTreeNode; //�����
  NodeInfo: ^Integer; //rkey
begin
  tv_display.Items.Clear;

  with DM.qry_dept do
  begin
    Close;
    Filtered:=False;
    Filter:='superior=0';
    Filtered:=True;
    Open;
    New(NodeInfo);
    NodeInfo^:= FieldByName('rkey').AsInteger;
    tv_display.Items.Clear;
    BootNode:=tv_display.Items.AddChildObject(nil,FieldByName('departmentname').AsString,NodeInfo); //��Ӹ���㣬�������������Ϣ
  end;

  CreateNode(BootNode,dm.qry_dept); //��������
  //tv_display.FullExpand; //չ�����������
  //tv_display.AutoExpand:=true;
  tv_display.ReadOnly:=true;
  //�����1��3��Ȩ�ޣ���ô�������û��϶�
  if (strtoint(vprev)=1) or (strtoint(vprev)=3) then tv_display.DragMode:=dmManual else tv_display.DragMode:=dmAutomatic;

end;

function isparent(child,parent:TTreeNode):Boolean;
var
  NodeTmp:TTreeNode;
begin
  NodeTmp:=child;
  while NodeTmp.Parent<>nil do
  begin
    if Integer(parent.Data^)=Integer(NodeTmp.Parent.Data^) then
      begin
        Result:=True;
        Exit;
      end;
    NodeTmp:=NodeTmp.Parent;
  end;
  Result:=False;
end;

procedure Tfm_dept.BitBtn3Click(Sender: TObject);
begin
  DM.qry_dept.Filtered := false;
  label3.Caption := inttostr(dm.qry_dept.RecordCount);
end;

procedure Tfm_dept.FormCreate(Sender: TObject);
begin
      {  
  DM.con_dept.ConnectionString:='Provider=SQLOLEDB.1;Password=wisdomtopcb1077;Persist Security Info=True;User ID=wzsa;Initial Catalog=sj_v20_live;Data Source=172.16.68.8';
  DM.con_dept.Open;
  rkey73 := '2522';
  vprev := '2';}
  if not App_Init(dm.con_dept) then
    begin
      ShowMessage('������ʧ��,�������Ա��ϵ!');
      application.Terminate;
    end
  else
 { dm.con_dept.Open;
  rkey73:= '96';
  user_ptr := '110';
  vprev := '4';  }

  begin
    //������
    CreateTree;
    dg_dept.ReadOnly:=true;
    DM.qry_dept.Sort :='departmentcode';
    if (strtoint(vprev)=1) or (strtoint(vprev)=3) then  //Ȩ��ֻ��Ȩ�޲�׼�޸�
    begin
      add.Enabled:=false;
      del.Enabled:=False;
      mody.Enabled:=false;
      Exit;
    end;
  end;
  self.Caption:=application.Title;
  k:=0;
end;

procedure Tfm_dept.tv_displayClick(Sender: TObject);
var
NodeSlt:TTreeNode;
begin
  //���ĵ����¼����õ�rkey
  if tv_display.Selected<>nil then   //showmodal���غ�����������ѡ�н�㣬��ʱȡ�����
      NodeSlt:=tv_display.Selected
  else
      NodeSlt:=tv_display.Items[0];
  //ShowMessage(IntToStr(Integer(NodeSlt.Data^)));
  with DM.qry_dept do
  begin
    Filtered:=False;
    Filter:='superior='+IntToStr(Integer(NodeSlt.Data^)) + ' or rkey='+IntToStr(Integer(NodeSlt.Data^)) ;
    Filtered:=true;
  end;
    label3.Caption := inttostr(dm.qry_dept.RecordCount);
end;

procedure Tfm_dept.addClick(Sender: TObject);
var
fm_madd:Tfm_madd;
i : Integer;
begin
  //����
  fm_madd:=Tfm_madd.Create(Application);
  fm_madd.Caption:='���Ӳ���';
  DM.qry_dept.Append;
  fm_madd.dbt_hide.Text:=IntToStr(Integer(tv_display.Selected.data^));
  if fm_madd.ShowModal=mrok then
  begin
    ShowMessage('�������ӳɹ�');
    tv_display.Items.Clear;  //�����
    CreateTree;   //�ؽ�
    for   i:=0   to   tv_display.Items.Count-1   do
    begin
      if   Pos(fm_madd.newdepname,Trim(tv_display.Items[i].Text))> 0   then
      begin
          tv_display.Items[i].Selected:=true;
          Break;
      end
    end;
  end;
  fm_madd.Free;
end;

procedure Tfm_dept.bbt_exitClick(Sender: TObject);
begin
  Close;
  Application.Terminate;
end;

procedure Tfm_dept.modyClick(Sender: TObject);
var
  fm_madd:tfm_madd;
  i : Integer;
begin
  fm_madd:=Tfm_madd.Create(Application);
  fm_madd.Caption:='�޸Ĳ�����Ϣ';
  with DM.qry_dept do
  begin
    Filtered:=False;
    Filter:='rkey='+ IntToStr(Integer(tv_display.Selected.data^));
    Filtered:=True;
    Edit;
  end;
  if fm_madd.ShowModal=mrok then
  begin
    ShowMessage('�޸Ĳ�����Ϣ�ɹ�');
    tv_display.Items.Clear;
    CreateTree;
    for   i:=0   to   tv_display.Items.Count-1   do
    begin
      if   Pos(fm_madd.newdepname,Trim(tv_display.Items[i].Text))> 0   then
      begin
        tv_display.Items[i].Selected:=true;
        tv_displayClick(tv_display);
        Break;
      end
    end;
  end;
  fm_madd.Free;
end;

procedure Tfm_dept.delClick(Sender: TObject);
begin
//ɾ������

  with DM.qry_dept do
  begin
    DM.ADOTMP.Close;
    dm.ADOTMP.SQL.Clear;
    DM.ADOTMP.SQL.Text := Format('select rkey from employeemsg where departmentid=%d ',[Integer(tv_display.Selected.data^)]);
    dm.ADOTMP.Open;
    Filtered:=False;
    Filter:='superior='+ IntToStr(Integer(tv_display.Selected.data^));
    Filtered:=True;
    if Eof then
      begin
        Filtered:=False;
        Filter:='rkey='+ IntToStr(Integer(tv_display.Selected.data^));
        Filtered:=True;
        if (FieldByName('departmentcount').AsString<>'0') or (not dm.ADOTMP.IsEmpty) then //����������Ϊ��
        begin
          ShowMessage('���µ������иò�����Ϣ������ɾ��');
          dm.ADOTMP.Close;
          Exit;
        end;
        if MessageDlg('��ȷ��Ҫɾ�� '+tv_display.Selected.Text+' ��',mtWarning,[mbyes,mbno],0)=mryes then
              Delete
        else  Exit;
      end
    else
      begin
         ShowMessage('�¼����Ų�Ϊ�գ�����ɾ��');
         Exit;
      end;
  end;
  tv_display.Items.Clear;
  CreateTree;
  if  tv_display.Items.Count <> 0 then
  tv_display.Items[0].Selected := True;
  dm.ADOTMP.Close;
end;

procedure Tfm_dept.tv_displayDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
begin
  Accept:=false;
  if (tv_display.GetNodeAt(X,Y)<>nil)and(tv_display.Selected.Level<>0) then
         Accept:=True;
end;

procedure Tfm_dept.tv_displayDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
  NodeTmp:TTreeNode;
begin
  if tv_display.GetNodeAt(X,Y)<>nil then
  begin
     NodeTmp:=tv_display.GetNodeAt(X,Y);
     if isparent(NodeTmp,tv_display.Selected) then
        begin
          ShowMessage('���������Ӳ���');
          Exit;
        end;  
     if MessageDlg('��ȷ��Ҫ�� '+tv_display.Selected.Text+' ���� '+NodeTmp.Text+' ����',mtWarning,[mbYes,mbNo],0)<>mryes then Exit;
     tv_display.Selected.MoveTo(NodeTmp,naAddChild);
     with DM.qry_dept do
       begin
          Filtered:=False;
          Filter:='rkey='+ IntToStr(Integer(tv_display.Selected.data^));
          Filtered:=true;
          Edit;
          FieldByName('superior').AsString:=IntToStr(Integer(NodeTmp.data^));
          Post;
       end;
  end;  
end;

procedure Tfm_dept.bbt_refreshClick(Sender: TObject);
begin
   tv_display.Items.Clear;
   CreateTree;
end;

procedure Tfm_dept.pm_treePopup(Sender: TObject);
begin
  if tv_display.Selected=nil then
        begin
          ShowMessage('��û��ѡ���κβ���');
          Abort;
        end;
end;

procedure Tfm_dept.btn_searchClick(Sender: TObject);
begin
  with DM.qry_dept do
  begin
     if edt_search.Text='' then
          begin
            Filtered:=False;
            Exit;
          end;
     Filtered:=False;
     Filter:='departmentcode like ''%'+ edt_search.Text +'%'' or departmentname like ''%'+ edt_search.Text +'%''';
     Filtered:=True;
  end;
     label3.Caption := inttostr(dm.qry_dept.RecordCount);
end;

procedure Tfm_dept.FormShow(Sender: TObject);
begin
   if  tv_display.Items.Count <> 0 then
   tv_display.Items[0].Selected := True;
   
end;

procedure Tfm_dept.BitBtn1Click(Sender: TObject);
begin
  if strtoint(vprev)=1 then
    begin
    showmessage('��û��Ȩ��ִ�д˲���');
    abort;
    end;
  bitbtn1.Enabled := false;
  try
  dm.ADOTMP.SQL.Text := 'exec dbo.hrsp_update_datadepartment_empcount ';
  dm.ADOTMP.ExecSQL;
  showmessage('����������Ϣͳ���Ѿ�����');
  dm.qry_dept.Active := false;
  dm.qry_dept.Active := true;  
  except on E: Exception do
    begin
      messagedlg(E.Message,mterror,[mbcancel],0);
    end;
  end;
  bitbtn1.Enabled := true;
end;

procedure Tfm_dept.BitBtn2Click(Sender: TObject);
begin
Export_dbGrid_to_Excel(dg_dept,self.Caption);
end;




procedure Tfm_dept.dg_deptTitleClick(Column: TColumn);
begin
  if column.Index in [7,8] then exit; 
  if k=0 then
  begin
    dm.qry_dept.Sort:=Column.FieldName;
    k:=1;
  end
  else
  begin  
    dm.qry_dept.Sort:=Column.FieldName+' DESC';
    k:=0;
    end;
end;

procedure Tfm_dept.CheckBox1Click(Sender: TObject);
begin
  if CheckBox1.Checked then
  begin
    with DM.qry_dept do
    begin
      Close;
      SQL.Clear;
      SQL.Text:='SELECT invalid,rkey,departmentname,departmentcode,superior,chargename,'
          +'departmentration,departmentcount,scarcity,overproofcount,max_overproof_percent,'
          +'pre_outduty,dept_totalration,dept_totalcount,dept_total_outduty FROM dbo.datadepartment' ;
      Open;
    end;
  end
  else
  begin
    with DM.qry_dept do
    begin
      Close;
      SQL.Clear;
      SQL.Text:='SELECT invalid,rkey,departmentname,departmentcode,superior,chargename,'
          +'departmentration,departmentcount,scarcity,overproofcount,max_overproof_percent,'
          +'pre_outduty,dept_totalration,dept_totalcount,dept_total_outduty '
          +'FROM dbo.datadepartment where invalid=0' ;
      Open;
    end;
  end;
  //������
  CreateTree;
end;

end.
