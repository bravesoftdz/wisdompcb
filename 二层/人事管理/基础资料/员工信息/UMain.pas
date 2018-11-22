unit UMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Grids, DBGridEh, StdCtrls, Buttons, Menus, DB,ComObj, Excel97,
  ADODB, ppDB, ppBands, ppCtrls, ppPrnabl, ppClass, ppCache, ppEndUsr,
  ppProd, ppReport, ppComm, ppRelatv, ppDBPipe, ppModule, ImgList,ComCtrls,
  ppStrtch, ppMemo, ppSubRpt, daDataModule, StrUtils, DBGrids;

type
  TMain_Form = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    BitBtn3: TBitBtn;
    BitBtn1: TBitBtn;
    BitBtn4: TBitBtn;
    Edit1: TEdit;
    BitBtn6: TBitBtn;
    BtQry: TBitBtn;
    PopupMenu1: TPopupMenu;
    PopupMenu2: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    TreeView1: TTreeView;
    ImageList1: TImageList;
    N4: TMenuItem;
    N5: TMenuItem;
    CheckBox1: TCheckBox;
    Label2: TLabel;
    Label3: TLabel;
    CheckBox2: TCheckBox;
    BitBtn2: TBitBtn;
    Panel2: TPanel;
    DBGridEh1: TDBGridEh;
    RadioGroup1: TRadioGroup;
    N6: TMenuItem;
    DBGridEh2: TDBGridEh;
    Image1: TImage;
    N7: TMenuItem;
    N8: TMenuItem;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BtQryClick(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure DBGridEh1TitleClick(Column: TColumnEh);
    procedure DBGridEh1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure TreeView1Click(Sender: TObject);
    procedure TreeView1GetImageIndex(Sender: TObject; Node: TTreeNode);
    procedure CheckBox1Click(Sender: TObject);
    procedure CheckBox2Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure RadioGroup1Click(Sender: TObject);
    procedure DBGridEh1DblClick(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure N7Click(Sender: TObject);
  private
    PreColumn: TColumnEh;
    field_name:string;
    sSql :string;
    Sqltext: string;
    procedure init;
    procedure CreateNode(ParentNode:TTreeNode;Query:TADOQuery);
    procedure CreateTree();
    procedure item_click(sender:TObject);
    { Private declarations }
  public
    SGrid_tmp1: TStringGrid;
    UserRkey: string; //73��RKEY
    { Public declarations }
  end;

var
  Main_Form: TMain_Form;

implementation

uses common,Udm,UDetail, UQuery, rpt_model, empChange, AdviceReport,
  UQueDep;

{$R *.dfm}

procedure TMain_Form.FormCreate(Sender: TObject);
begin
 if not App_init_2(dm.ADOConnection1) then
  begin
    ShowMsg('������ʧ������ϵ����Ա',1);
    application.Terminate;
    exit;
  end;
  Caption := application.Title;
  { ///------
   dm.ADOConnection1.Open;
  rkey73:= '2141';
  user_ptr := '2591';
  vprev := '4';
  ////------    }
  DateSeparator := '-';
  ShortDateFormat := 'yyyy-mm-dd';
  Sqltext := DM.employee_msg.SQL.Text;
  with DM.tmp do
  begin
    Close;
    SQL.Text := 'select data0005.rkey from data0005 inner join data0073 '
      + 'on data0005.rkey=data0073.employee_ptr where data0073.rkey = '+ rkey73;
    Open;
    if not IsEmpty then UserRkey := FieldByName('rkey').AsString;
  end;
  init;
end;

//��ʼ��
procedure TMain_Form.init;
begin
  field_name := DBGridEh1.Columns[1].FieldName;
  PreColumn := DBGridEh1.Columns[1];
  DBGridEh1.Columns[1].Title.Color := clred ;
  Self.sSql:= DM.employee_msg.SQL.Text;
  with dm.tmp1 do
  begin
    dm.employee_department.Close;
    dm.employee_department.Open;
    DM.employee_msg.Close;
    DM.employee_msg.SQL.Text := Sqltext + ' and status=1 '
      + ' and datadepartment.rkey in (select departmentid from hr_permission '
      + ' where operator_ptr= ' + rkey73
      + ' and program_ptr=(select rkey from data0419 where programe =''employeemsg.exe'')) '
      + ' order by employeecode ';
    DM.employee_msg.Open;
    CreateTree;
  end;
  //DBGridEh1.Columns[15].Visible := False;
  //DBGridEh1.Columns[16].Visible := False;
end;

procedure TMain_Form.CreateTree();
var
  BootNode: TTreeNode; //�����
  NodeInfo: ^Integer; //rkey
begin
  TreeView1.Items.Clear;
  with DM.employee_department do
  begin
    Filtered := False;
    Filter := 'superior=0';
    Filtered := True;
    First;
    while not Eof do
    begin
      New(NodeInfo);
      NodeInfo^ := FieldByName('rkey').AsInteger;
      BootNode := TreeView1.Items.AddChildObject(nil,FieldByName('departmentname').AsString,NodeInfo); //��Ӹ���㣬�������������Ϣ
      CreateNode(BootNode,DM.employee_department);
      Next;
    end;
    First;
  end;
  TreeView1.ReadOnly := true;
  TreeView1.DragMode := dmAutomatic;
end;

procedure TMain_Form.CreateNode(ParentNode: TTreeNode;Query: TADOQuery);
var
  ChildNode:TTreeNode; //���ӽ��
  NodeInfo:^Integer; //rkey
  QueryTmp:TADOQuery;
begin
    QueryTmp := TADOQuery.Create(Self);
    QueryTmp.Clone(Query);
    with QueryTmp do
    begin
      Filtered := False;
      Filter := 'superior ='+IntToStr(Integer(ParentNode.Data^));
      Filtered := true; 
      while not Eof do
      begin
       New(NodeInfo);
       NodeInfo^:=FieldByName('rkey').AsInteger;
       ChildNode:=TreeView1.Items.AddChildObject(ParentNode,FieldByName('departmentname').AsString,NodeInfo); //��Ӻ��ӽ�㣬���������ӽ����Ϣ
       CreateNode(ChildNode,Query); //�ݹ�
       Next;
      end;
      Free; //�ͷ����õ�query
    end;
end;

procedure TMain_Form.BitBtn1Click(Sender: TObject);
begin
   Application.Terminate;
end;

procedure TMain_Form.FormShow(Sender: TObject);
var
  i:integer;
  item:TMenuItem;
begin
  if dm.ADOConnection1.Connected then
  begin
      DBGridEh1TitleClick(PreColumn);
      // DBGridEh1ÿ��ά���������ڱ�
      for i:=1 to DBGridEh1.Columns.Count do
      begin
          item := TmenuItem.Create(self) ;
          item.Caption := DBGridEh1.Columns[i-1].Title.Caption ;

          if DBGridEh1.Columns[i-1].Visible then
              item.Checked := true ;
              item.OnClick := item_click ;
              PopupMenu2.Items.Add(item) ;
      end;
  end;
  Label3.Caption := inttostr(DM.employee_msg.RecordCount);
  SGrid_tmp1 := TStringGrid.Create(Self);
  with dm.tmp do
  begin
    Close;
    SQL.Clear;
    SQL.Text := 'select distinct(model_name) from dbo.employeemsg_rpt_model';
    Open;
  end;
  RadioGroup1.Items.Clear;
  for i := 0 to dm.tmp.RecordCount - 1 do
  begin
    RadioGroup1.Items.Add(dm.tmp.FieldValues['model_name']);
    dm.tmp.Next;
  end;
end;

procedure TMain_Form.BitBtn3Click(Sender: TObject);
var
  i, j:integer;
begin
  //ˢ�°�ť
  Screen.Cursor := crHourGlass;
  if DM.employee_msg.IsEmpty then exit;
  i := DM.employee_msgrkey.AsInteger ;
  DM.employee_msg.Close;
  DM.employee_msg.SQL.Text := Sqltext + ' and status=1 '
    + ' and datadepartment.rkey in (select departmentid from hr_permission '
    + ' where operator_ptr= ' + rkey73
    + ' and program_ptr=(select rkey from data0419 where programe =''employeemsg.exe'')) '
    + ' order by employeecode ';
  DM.employee_msg.Open;
  DM.employee_msg.Locate('rkey',i,[]);
  with dm.tmp do
  begin
    Close;
    SQL.Clear;
    SQL.Text := 'select distinct(model_name) from dbo.employeemsg_rpt_model';
    Open;
  end;
  RadioGroup1.Items.Clear;
  DBGridEh1.FrozenCols := 4;

  //DBGEIDEH2��ˢ��ʱ�ָ��տ�ʼ��ʾ�ֶΣ�����������棩
  for i := 0 to DBGridEh2.Columns.Count - 1 do
  begin
    DBGridEh1.Columns[i].Visible := True;
    DBGridEh1.Columns[i].FieldName := DBGridEh2.Columns[i].FieldName;
    DBGridEh1.Columns[i].Width := DBGridEh2.Columns[i].Width;
    DBGridEh1.Columns[i].Title.Caption := DBGridEh2.Columns[i].Title.Caption;
  end;
  
  for i := 0 to dm.tmp.RecordCount - 1 do
  begin
    RadioGroup1.Items.Add(dm.tmp.FieldValues['model_name']);
    dm.tmp.Next;
  end;

  //DBGridEh1.Columns[15].Visible := False;
  //DBGridEh1.Columns[16].Visible := False;

  Label3.Caption := IntToStr(DM.employee_msg.RecordCount);
  Screen.Cursor := crDefault;
end;

procedure TMain_Form.BtQryClick(Sender: TObject);
var
 i:byte;
begin
  with Query_Form do
  begin
    if ShowModal=mrok then
    begin
      with dm.employee_msg do
      begin
        close;
        SQL.Text:=self.sSql+#13;
        for i:=1 to SGrid1.RowCount-2 do
        begin
          SQL.Text:= SQL.Text + SGrid1.Cells[2,i]+#13;
        end;
        SQL.Text:= SQL.Text
          + ' and datadepartment.rkey in (select departmentid from hr_permission '
          + ' where operator_ptr= ' + rkey73
          + ' and program_ptr=(select rkey from data0419 where programe =''employeemsg.exe'')) '
          + ' order by employeecode ';
        open;
      end;
    end;
  end;
  Label3.Caption := inttostr( DM.employee_msg.RecordCount );
end;

procedure TMain_Form.BitBtn4Click(Sender: TObject);
begin
  if (StrToInt(vprev) <> 2) and (StrToInt(vprev) <> 4) then
  begin
    ShowMessage('����Ȩ�޲���������ϵ����Ա��');
    Exit;
  end;
  if DBGridEh1.DataSource.DataSet.Active then
    if DBGridEh1.DataSource.DataSet.RecordCount > 0 then
      Export_dbGridEH_to_Excel(DBGridEh1,'Ա����Ϣ') ;
end;

procedure TMain_Form.item_click(sender: TObject);
var
  i:byte;
begin
  (sender as tmenuItem).Checked := not ((sender as tmenuItem).Checked);
  if (sender as tmenuItem).Checked then
      begin
          for i := 0 to DBGridEh1.FieldCount - 1 do
              if DBGridEh1.Columns[i].Title.Caption = (sender as tmenuItem).Caption then
                  begin
                      DBGridEh1.Columns[i].Visible := true ;
                      break ;
                  end ;
      end
  else
      begin
          for i := 0 to DBGridEh1.FieldCount - 1 do
              if DBGridEh1.Columns[i].Title.Caption = (sender as tmenuItem).Caption then
                  begin
                      DBGridEh1.Columns[i].Visible := false ;
                      break ;
                  end ;
      end ;
end;

procedure TMain_Form.DBGridEh1TitleClick(Column: TColumnEh);
begin
  if DBGridEh1.DataSource.DataSet.FieldByName(Column.FieldName).FieldKind = fkCalculated then  exit ;

  if (column.Title.SortMarker =smDownEh) or (column.Title.SortMarker =smNoneEh) then
  begin
    column.Title.SortMarker:=smUpEh;
    DM.employee_msg.Sort:=Column.FieldName;
  end
  else
  begin
    column.Title.SortMarker:=smDownEh;
    DM.employee_msg.Sort:= Column.FieldName + ' DESC';
  end;

  if DBGridEh1.DataSource.DataSet.FieldByName(Column.FieldName).DataType in [ftDate, ftTime, ftDateTime] then exit;
  if (PreColumn.FieldName<>column.FieldName) and (column.ReadOnly) then
  begin
    label1.Caption:=column.Title.Caption + ':';
    self.field_name:=column.FieldName;
    edit1.SetFocus;
    PreColumn.Title.Color := clBtnFace;
    Column.Title.Color := clred;
    PreColumn := column;
  end
  else
    edit1.SetFocus;
end;

procedure TMain_Form.DBGridEh1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (chr(key)='V') and (ssalt in shift) then
    showmessage(dm.employee_msg.SQL.Text);
end;

procedure TMain_Form.Edit1Change(Sender: TObject);
var
  kl: HKL;
  i: Integer;
begin
  //   if DBGridEh1.DataSource.DataSet.FieldByName(field_name).FieldKind = fkCalculated then  exit;

  if DBGridEh1.DataSource.DataSet.FieldByName(field_name).DataType in [ftString,ftWideString,ftSmallint,ftInteger]  then
  begin
    if trim(Edit1.text) <> '' then
    begin
      if DBGridEh1.DataSource.DataSet.FieldByName(field_name).DataType in  [ftString, ftWideString]  then
        DBGridEh1.DataSource.DataSet.Filter:=' (' +  field_name + ' like ''%' + trim(edit1.text) + '%'')'
      else
      if DBGridEh1.DataSource.DataSet.FieldByName(field_name).DataType in  [ftSmallint, ftInteger]  then
        DBGridEh1.DataSource.DataSet.Filter:=' (' + field_name+' = ' + inttostr(strtointdef(edit1.text,0))+')';
    end
    else
      DBGridEh1.DataSource.DataSet.Filter:='';
  end;
   {
  if trim(Edit1.text) <> '' then
  begin
    DBGridEh1.DataSource.DataSet.Filter:= ' (' + field_name + ' like %' + trim(edit1.text) + '%) ';
  end
  else
    DBGridEh1.DataSource.DataSet.Filter:='';
    }
  Label3.Caption := IntToStr(DBGridEh1.DataSource.DataSet.RecordCount);
end;

procedure TMain_Form.BitBtn6Click(Sender: TObject);
begin
  popupmenu2.Popup(mouse.CursorPos.x,mouse.CursorPos.y);
end;

procedure TMain_Form.N1Click(Sender: TObject);
var
  QueryTmp: TADOQuery;
begin
  case Tmenuitem(Sender).Tag of
    0,1,3: //�������༭��ɾ��  ��4�鿴
    if (StrToInt(vprev) <> 2) and (StrToInt(vprev) <> 4) then
    begin
      ShowMessage('����Ȩ�޲���������ϵ����Ա��');
      Exit;
    end;
  end;

  QueryTmp:=TADOQuery.Create(Self);
  QueryTmp.Connection := DM.ADOConnection1;
  case Tmenuitem(Sender).Tag of
    0, 1, 4: //4�鿴
    with TDetail_Form.Create(nil) do
    begin
      try
        Ftag := Tmenuitem(Sender).Tag;
        initd;
        ShowModal;
      finally
        Free;
      end;
    end;
    3:
    begin
      with dm.tmp do
      begin
        Close;
        SQL.Clear;
        SQL.Text := 'select * from employeemsg where rkey='+dm.employee_msgrkey.AsString;
        Open;
        if FieldByName('roomcode').AsString <> '' then
        begin
          ShowMessage('��Ա������ס�޼�¼������ɾ������, ֻ������ְ����');
          Exit;
        end;
        Close;
        SQL.Clear;
        SQL.Text := 'select * from OnOffDutyData where employeeid='+dm.employee_msgrkey.AsString;
        Open;
        if FieldByName('CheckDate').AsString <> '' then
        begin
          ShowMessage('��Ա�����п��ڵ���������ɾ��Ա����Ϣ, ֻ������ְ�������ϵ����Ա��');
          Exit;
        end;
      end;
      if MessageBox(Handle,'ȷ��ɾ���˼�¼��?','��ʾ',MB_YESNO+MB_ICONWARNING+MB_DEFBUTTON2)=IDNO	then exit;
      DM.ADOConnection1.BeginTrans;
      try
        DM.tmp.Close;
        DM.tmp.SQL.Text:='delete from employeemsg  where rkey = '+dm.employee_msgRkey.AsString;
        if DM.tmp.ExecSQL=0 then
        begin
          DM.ADOConnection1.RollbackTrans;
          showmessage('ɾ������ʧ��,����״̬�ѷ����仯...');
        end
        else
          DM.ADOConnection1.CommitTrans;
      except  
        DM.ADOConnection1.RollbackTrans;
        showmessage('ɾ������ʧ��...');
      end;
      BitBtn3Click(nil);
    end;
  end;
  QueryTmp.Free;
end;

function isparent(child,parent:TTreeNode):Boolean;
var
  NodeTmp: TTreeNode;
begin
  NodeTmp := child;
  while NodeTmp.Parent<>nil do
  begin
    if Integer(parent.Data^) = Integer(NodeTmp.Parent.Data^) then
      begin
        Result := True;
        Exit;
      end;
    NodeTmp := NodeTmp.Parent;
  end;
  Result := False;
end;

procedure TMain_Form.TreeView1Click(Sender: TObject);
var
  NodeSlt: TTreeNode;
  P: TPoint;
  Dep_Filter: string;
begin
  GetCursorPos(P);
  P := TreeView1.ScreenToClient(P);
  if (htOnButton in TreeView1.GetHitTestInfoAt(P.X,P.Y)) then exit;
  Dep_Filter := '';
  if TreeView1.Selected <> nil then
  begin
    NodeSlt:=TreeView1.Selected;
    Dep_Filter := 'rkeydep =   ' + IntToStr(Integer(NodeSlt.Data^));
    IF not( TreeView1.Selected.HasChildren ) then
    begin
          Dep_Filter := '';
          NodeSlt:=TreeView1.Selected;
          Dep_Filter := ' rkeydep = ' + IntToStr(Integer(NodeSlt.Data^)) + ' or ' + Dep_Filter;
          delete(Dep_Filter,length(Dep_Filter)-2,2);
    end
    else
    BEGIN
      NodeSlt := TreeView1.Selected.GetFirstChild;
      if TreeView1.Selected.Level = 0 then
      begin
           Dep_Filter := '';
      end
      else
      begin
        while  (NodeSlt <> nil) and (NodeSlt.Level > TreeView1.Selected.Level) do
        begin
              Dep_Filter := ' rkeydep = ' + IntToStr(Integer(NodeSlt.Data^)) + ' or ' + Dep_Filter;
              NodeSlt := NodeSlt.GetNext;
        end;
      end;
    end;
  end;
  with DM.employee_msg do
  begin
        Filtered:=False;
        Filter:= Dep_Filter;
        Filtered:=true;
        Label3.Caption := inttostr( RecordCount );
  end;
end;

procedure TMain_Form.TreeView1GetImageIndex(Sender: TObject;
  Node: TTreeNode);
begin
  if Node.HasChildren then Node.ImageIndex:=1 else Node.ImageIndex:=2
end;

procedure TMain_Form.CheckBox1Click(Sender: TObject);
begin
    if CheckBox1.Checked = True then
    begin
          DM.employee_msg.Close;
          DM.employee_msg.SQL.Text := Sqltext + ' and dbo.employeemsg.status = 2 '
            + ' and datadepartment.rkey in (select departmentid from hr_permission '
            + ' where operator_ptr= ' + rkey73
            + ' and program_ptr=(select rkey from data0419 where programe =''employeemsg.exe'')) '
            + ' order by employeecode ';
          DM.employee_msg.Open;
    end;
    if CheckBox1.Checked = False then
    begin
          DM.employee_msg.Close;
          DM.employee_msg.SQL.Text := Sqltext + ' and dbo.employeemsg.status = 1 '
            + ' and datadepartment.rkey in (select departmentid from hr_permission '
            + ' where operator_ptr= ' + rkey73
            + ' and program_ptr=(select rkey from data0419 where programe =''employeemsg.exe'')) '
            + ' order by employeecode ';
          DM.employee_msg.Open;
    end;
    if CheckBox2.Checked = True then
    begin
          DM.employee_msg.Close;
          DM.employee_msg.SQL.Text := Sqltext
            + ' and datadepartment.rkey in (select departmentid from hr_permission '
            + ' where operator_ptr= ' + rkey73
            + ' and program_ptr=(select rkey from data0419 where programe =''employeemsg.exe'')) '
            + ' order by employeecode ';
          DM.employee_msg.Open;
    end;
    Label3.Caption := inttostr( DM.employee_msg.RecordCount );
end;

procedure TMain_Form.CheckBox2Click(Sender: TObject);
begin
    if CheckBox2.Checked = True then
    begin
          DM.employee_msg.Close;
          DM.employee_msg.SQL.Text := Sqltext
            + ' and datadepartment.rkey in (select departmentid from hr_permission '
            + ' where operator_ptr= ' + rkey73
            + ' and program_ptr=(select rkey from data0419 where programe =''employeemsg.exe'')) '
            + ' order by employeecode ';
          DM.employee_msg.Open;
    end;
    if (CheckBox2.Checked = False) and (CheckBox1.Checked = False) then
    begin
          DM.employee_msg.Close;
          DM.employee_msg.SQL.Text := Sqltext + ' and dbo.employeemsg.status = 1 '
            + ' and datadepartment.rkey in (select departmentid from hr_permission '
            + ' where operator_ptr= ' + rkey73
            + ' and program_ptr=(select rkey from data0419 where programe =''employeemsg.exe'')) '
            + ' order by employeecode ';
          DM.employee_msg.Open;
    end;
    if (CheckBox2.Checked = False) and (CheckBox1.Checked = True) then
    begin
          DM.employee_msg.Close;
          DM.employee_msg.SQL.Text := Sqltext + ' and dbo.employeemsg.status = 2 '
            + ' and datadepartment.rkey in (select departmentid from hr_permission '
            + ' where operator_ptr= ' + rkey73
            + ' and program_ptr=(select rkey from data0419 where programe =''employeemsg.exe'')) '
            + ' order by employeecode ';
          DM.employee_msg.Open;
    end;
    Label3.Caption := inttostr( DM.employee_msg.RecordCount );
end;

procedure TMain_Form.BitBtn2Click(Sender: TObject);
begin
  //�ƶ�ģ��
  if (StrToInt(vprev) <> 2) and (StrToInt(vprev) <> 4) then
  begin
    ShowMessage('����Ȩ�޲���������ϵ����Ա��');
    Exit;
  end;
  FrmModel := TFrmModel.Create(Application);
  FrmModel.ShowModal;
  FrmModel.Free;
end;

procedure TMain_Form.RadioGroup1Click(Sender: TObject);
var
  ss: string;
  i, j: Integer;
begin
  DBGridEh1.FrozenCols := 0;
  for i := 0 to DBGridEh1.Columns.Count - 1 do
  begin
    DBGridEh1.Columns[i].Visible := False;
  end;

  ss := RadioGroup1.Items.Strings[RadioGroup1.ItemIndex];
  with dm.tmp do
  begin
    SQL.Clear;
    SQL.Text := 'select datafield_name from employeemsg_rpt_model where model_name =' +quotedstr(ss);
    Open;
  end;

  for j := 0 to dm.tmp.RecordCount - 1 do
  begin
    for i := 0 to DBGridEh1.Columns.Count - 1  do
    begin
      if (dm.tmp.FieldValues['datafield_name'] = DBGridEh1.Columns[i].Title.Caption ) then
      begin
        DBGridEh1.Columns[i].Visible := True;
        DBGridEh1.Columns[i].Index := j;
      end;
    end;
    dm.tmp.Next;
  end;
end;

procedure TMain_Form.DBGridEh1DblClick(Sender: TObject);
begin
  Self.N5.Click;
end;

procedure TMain_Form.N6Click(Sender: TObject);
begin
  FrmEmpChange := TFrmEmpChange.create(Application);
  FrmEmpChange.ShowModal;
  FrmEmpChange.Free;
end;

procedure TMain_Form.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState); 
begin
 if DM.employee_msg.FieldByName('emp_contract_flag').asstring = '��ͬ������'
  then  dbgrideh1.Canvas.Font.Color := clblue ;

  if DM.employee_msg.FieldByName('serious_mistake').Value > 0
  then  dbgrideh1.Canvas.Font.Color := clRed ;
  
  dbgrideh1.DefaultDrawColumnCell(Rect, DataCol, Column, State);


end;

procedure TMain_Form.N7Click(Sender: TObject);
begin
      if  (StrToInt(vprev) = 1)  then
    begin
      ShowMessage('����Ȩ�޲���������ϵ����Ա��');
      Exit;
    end;
  Form_Report:=TForm_Report.Create(application);
  Form_Report.ADOQuery1.close;
  Form_Report.ADOQuery1.Parameters[0].Value:=dm.employee_msgrkey.AsInteger;
  Form_Report.ADOQuery1.open;
  Form_Report.ppReport1.Reset;
  Form_Report.ppReport1.Template.FileName :=
  StringReplace(GetCurrentDir,'EXEC','NIERP\REPORT\',[rfReplaceAll])+
       'hrinfo.rtm';
  Form_Report.ppReport1.Template.LoadFromFile;
  Form_Report.ppReport1.SaveAsTemplate:=false;
  Form_Report.ppReport1.OutlineSettings.Enabled:=False;
  Form_Report.ppReport1.Print;
  Form_Report.free;
end;

end.
