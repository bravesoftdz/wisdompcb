unit quality_trace;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, DBCtrls, ExtCtrls, ComCtrls, Grids, ImgList;

type
  TForm2 = class(TForm)
    Panel1: TPanel;
    rkey25: TLabel;
    status: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    DBText1: TDBText;
    DBText2: TDBText;
    Label33: TLabel;
    Label65: TLabel;
    Label57: TLabel;
    Label58: TLabel;
    DBText3: TDBText;
    DBText4: TDBText;
    Label67: TLabel;
    Label66: TLabel;
    BitBtn2: TBitBtn;
    BitBtn1: TBitBtn;
    BitBtn11: TBitBtn;
    HeaderControl1: THeaderControl;
    TreeView1: TTreeView;
    ImageList1: TImageList;
    SGrid1: TStringGrid;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn9: TBitBtn;
    dtpk1: TDateTimePicker;
    procedure FormActivate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure TreeView1Change(Sender: TObject; Node: TTreeNode);
    procedure SGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn11Click(Sender: TObject);
    procedure SGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SGrid1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure SGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure dtpk1Exit(Sender: TObject);
    procedure BitBtn9Click(Sender: TObject);
  private
    str_list:TStringList;
    { Private declarations }
    procedure get_treedate(rkey25:integer;treeview:Ttreeview);
    function get_date0025toprkey(rkey25: integer):integer;
    procedure update_31(rkey25:integer);//����31��
    function find_31(rkey25:integer):boolean;//�ж��Ƿ��һ������
  public
    { Public declarations }
    procedure inti;
  end;

var
  Form2: TForm2;

implementation

uses demo,ADODB,DB,common, frm_ProcedureReport1,Pick_Item_Single,ConstVar;

{$R *.dfm}

function TForm2.get_date0025toprkey(rkey25: integer):integer;
var
 rkey:integer;
begin
with dm.ADOQuery2 do
 begin
  close;
  sql.Text:='select parent_ptr from data0025 where rkey='+inttostr(rkey25);
  open;
  rkey := fieldbyname('parent_ptr').AsInteger; //���ڸ�ֵ
 end;

 if rkey <= 0 then
  rkey:=rkey25       //�����Ʒ��������Լ�
 else
  with dm.ADOQuery2 do
  begin
   close;
   sql.Text:='select parent_ptr from data0025 where rkey='+inttostr(rkey);
   open;
   if FieldByName('parent_ptr').AsInteger > 0 then
    begin
     rkey := fieldbyname('parent_ptr').AsInteger;  //�����үү����үүֵ
     with dm.ADOQuery3 do
      begin
       close;
       sql.Text:='select parent_ptr from data0025 where rkey='+inttostr(rkey);
       open;
       if FieldByName('parent_ptr').AsInteger > 0 then
         rkey := fieldbyname('parent_ptr').AsInteger;  //�����̫������̫��ֵ
      end;
    end;
  end;
 result:=rkey;
end;

procedure TForm2.get_treedate(rkey25: integer;treeview:Ttreeview);
var
 node:ttreenode;   //treeview�ؼ��Ľڵ����
 rkey0025:^integer;
begin

with dm.ADOQuery1 do
 begin
  close;
  sql.Text:='select rkey,MANU_PART_NUMBER from data0025 where rkey='+
              inttostr(get_date0025toprkey(rkey25));
  open;
  new(rkey0025);
  rkey0025^:=fieldvalues['rkey'];
  node:=treeview.Items.AddObject
  (nil,fieldbyname('MANU_PART_NUMBER').AsString,rkey0025); //���Ӷ���ڵ�
  node.ImageIndex:=0;  //Ϊ��һ��ڵ㶨��ͼ��
 end;

with dm.ADOQuery1 do
 begin
  close;
  sql.Text:='select rkey,MANU_PART_NUMBER from data0025 where parent_ptr='+
              inttostr(get_date0025toprkey(rkey25));
  open;
  while not dm.ADOQuery1.Eof do
  begin
   new(rkey0025);
   rkey0025^:= dm.ADOQuery1.fieldvalues['rkey'];
   node:=treeview.Items.AddChildObject
      (node,fieldbyname('MANU_PART_NUMBER').AsString,rkey0025);
   node.ImageIndex := 1;
   with dm.ADOQuery2 do
    begin
     close;
     sql.Text:='select rkey,MANU_PART_NUMBER from data0025 where parent_ptr='+
              dm.ADOQuery1.fieldbyname('rkey').AsString;
     open;
     while not dm.ADOQuery2.Eof do
     begin
      new(rkey0025);
      rkey0025^:= dm.ADOQuery2.fieldvalues['rkey'];
      node:=treeview.Items.AddChildObject
       (node, dm.ADOQuery2.fieldbyname('MANU_PART_NUMBER').AsString,rkey0025);
      node.ImageIndex := 2;

       with dm.ADOQuery3 do
        begin
         close;
         sql.Text:='select rkey,MANU_PART_NUMBER from data0025 where parent_ptr='+
                  dm.ADOQuery2.fieldbyname('rkey').AsString;
         open;
         while not dm.ADOQuery3.Eof do
         begin
          new(rkey0025);
          rkey0025^:= dm.ADOQuery3.fieldvalues['rkey'];
          node:=treeview.Items.AddChildObject
           (node, dm.ADOQuery3.fieldbyname('MANU_PART_NUMBER').AsString,rkey0025);
          node.ImageIndex := 3;
          node:=node.Parent;
          dm.ADOQuery3.Next;
         end;
        end;

      node:=node.Parent;
      dm.ADOQuery2.Next;
     end;
    end;
   node:=node.Parent; //�ڵ�ָ���丸�ڵ�ֵ
   dm.ADOQuery1.Next;
  end;
 end;

 treeview.FullExpand; //ȫ��չ��
 treeview.Items[0].Selected:=true;
end;


procedure TForm2.FormActivate(Sender: TObject);
begin
self.get_treedate(dm.AQY0025RKEY.Value,treeview1);
if dm.AQY0025PROD_ROUTE_PTR.Value>0 then
  with dm.ADOQuery1 do
  begin
   close;
   sql.Text:='select WAREHOUSE_CODE,ABBR_NAME from data0015'+#13+
             'where rkey='+dm.AQY0025PROD_ROUTE_PTR.AsString;
   open;
   label66.Caption:=fieldbyname('WAREHOUSE_CODE').AsString;
   label67.Caption:=fieldbyname('ABBR_NAME').AsString;
  end;
end;

procedure TForm2.FormShow(Sender: TObject);
begin
//sgrid1.Cells[0,0]:='����';
//sgrid1.Cells[1,0]:='��������';
//sgrid1.Cells[2,0]:='QA���ȷ��ǩ��';
//sgrid1.Cells[3,0]:='��������(SET)�ͱ���ԭ��';
//sgrid1.Cells[4,0]:='�������ȷ��ǩ��(��עʱ��)';
//sgrid1.Cells[5,0]:='�������ʱ��';
//sgrid1.Cells[6,0]:='�հ����ǩ��(��עʱ��)';
//sgrid1.Cells[7,0]:='�����ѵ�';
//sgrid1.Cells[8,0]:='����ָ��RKEY34';

//2017-3-20tangע---
//sgrid1.Cells[0,0]:='����';
//sgrid1.Cells[1,0]:='��������';
//sgrid1.Cells[2,0]:='�����ѵ�';
//sgrid1.Cells[3,0]:='���Ʒ���';
//sgrid1.Cells[4,0]:='��������';
//sgrid1.Cells[5,0]:='Ʒ��״��';
//sgrid1.Cells[6,0]:='������';
//sgrid1.Cells[7,0]:='���ʱ��';
//sgrid1.Cells[8,0]:='����ָ��RKEY34';
//SGrid1.Cells[9,0]:='�Ƴ̲���';
//SGrid1.ColWidths[8] := 0;
//SGrid1.ColWidths[9] :=1000;
  inti;
  dtpk1.Date:=getsystem_date(DM.ADOQuery2,0)
end;


procedure TForm2.BitBtn2Click(Sender: TObject);
begin
self.ModalResult:=mrcancel;
end;

procedure TForm2.TreeView1Change(Sender: TObject; Node: TTreeNode);
var
i,j:integer;
begin
  rkey25.Caption:=inttostr(Pinteger(Node.data)^);
  node.SelectedIndex:=4;
  dm.AQY0025.Close;
  dm.AQY0025.Parameters[0].Value:=strtoint(rkey25.Caption);
  dm.AQY0025.Open;
  if not find_31(strtoint(rkey25.Caption)) then //�ж��Ƿ�Ϊ��һ������
  begin//����ǵ�һ�������ȴ�38���ȡ����͹�������
    dm.ADS38.Close;
    dm.ADS38.Parameters[0].Value:=strtoint(rkey25.Caption);
    dm.ADS38.Open;

  dm.ADS38.First;
  form2.sgrid1.RowCount:=dm.ADS38.RecordCount+1;
  i:=1;
  while not dm.ADS38.Eof do
  begin
//2017-3-20tangע---
//  sgrid1.Cells[0,i]:=dm.ADS38STEP_NUMBER.AsString;
//  sgrid1.Cells[1,i]:=dm.ADS38dept_name.Value;//ֻ��ȡ�����б�,��������ֶ�Ϊ��
//  sgrid1.Cells[2,i]:='';
//  sgrid1.Cells[3,i]:='';
//  sgrid1.Cells[4,i]:='';
//  sgrid1.Cells[5,i]:='';
//  sgrid1.Cells[6,i]:='';
//  sgrid1.Cells[7,i]:='';
//  sgrid1.Cells[8,i]:=dm.ADS38DEPT_PTR.AsString;
//  SGrid1.Cells[9,i]:=DM.ADS38WideStringField.AsString;
  sgrid1.Cells[str_list.IndexOfName('����'),i]:=dm.ADS38STEP_NUMBER.AsString;
  sgrid1.Cells[str_list.IndexOfName('��������'),i]:=dm.ADS38dept_name.Value;//ֻ��ȡ�����б�,��������ֶ�Ϊ��
  SGrid1.Cells[str_list.IndexOfName('�Ƴ̲���'),i]:=DM.ADS38WideStringField.AsString;
  sgrid1.Cells[str_list.IndexOfName('Ʒ��״��'),i]:='�������쳣��Ʒ�ʺϸ�';
  sgrid1.Cells[str_list.IndexOfName('������'),i]:='';
  sgrid1.Cells[str_list.IndexOfName('���ʱ��'),i]:='';
  sgrid1.Cells[str_list.IndexOfName('Rkey34'),i]:=dm.ADS38DEPT_PTR.AsString;
  Inc(i);
  dm.ADS38.Next;
  end;
  end
  else //������ǵ�һ���������Զ�����31���е�����
  begin
  dm.ADS38.Close;
  dm.ADS38.Parameters[0].Value:=strtoint(rkey25.Caption);
  dm.ADS38.Open;
  dm.ADS38.First;
  dm.ADS31.Close;
  dm.ADS31.Parameters[0].Value:=strtoint(rkey25.Caption);
  dm.ADS31.Open;
  dm.ADS31.First;
  j:=0;
  while not dm.ADS38.Eof do//�жϲ�Ʒ���������Ƿ��б仯
  begin
  with dm.ADOQuery1 do
  begin
  close;
  sql.Clear;
  sql.Text:='select * from data0031 where source_ptr=:rkey25 and dept_ptr=:rkey34 and step_number=:number';
  Parameters[0].Value:=strtoint(rkey25.Caption);
  Parameters[1].Value:=dm.ADS38DEPT_PTR.Value;
  Parameters[2].Value:=dm.ADS38STEP_NUMBER.Value;
  open;
  end;
  if not dm.ADOQuery1.IsEmpty then j:=j+1;
  dm.ADS38.Next;
  end;
  if (dm.ADS38.RecordCount<>dm.ADS31.RecordCount) or (dm.ADS31.RecordCount<>j) then//�����Ʒ���������б仯
  begin
  if messagedlg('��Ʒ���������б仯,�Զ�����Ʒ�ʸ�������,�ظ���������������Ʒ�ʸ�����Ϣ!',mtconfirmation,[mbyes],0)=mryes then
  begin
  form2.sgrid1.RowCount:=dm.ADS38.RecordCount+1;
  i:=1;
  dm.ADS38.First;
  while not dm.ADS38.Eof do
  begin
//2017-3-20tangע---
//  sgrid1.Cells[0,i]:=dm.ADS38STEP_NUMBER.AsString;
//  sgrid1.Cells[1,i]:=dm.ADS38dept_name.Value;
    sgrid1.Cells[str_list.IndexOfName('����'),i]:=dm.ADS38STEP_NUMBER.AsString;
    sgrid1.Cells[str_list.IndexOfName('��������'),i]:=dm.ADS38dept_name.Value;//ֻ��ȡ�����б�,��������ֶ�Ϊ��
  dm.aq31.Close;
  dm.aq31.Parameters[0].Value:=strtoint(rkey25.Caption);
  dm.aq31.Parameters[1].Value:=dm.ADS38DEPT_PTR.Value;
  dm.aq31.Open;
  if (not dm.aq31.IsEmpty) and (dm.aq31.RecordCount=1) then
  begin
    SGrid1.Cells[str_list.IndexOfName('�Ƴ̲���'),i]:=dm.ADS31WideStringField.AsString;
    sgrid1.Cells[str_list.IndexOfName('Ʒ��״��'),i]:=dm.aq31FLOW_QTY.AsString;
    sgrid1.Cells[str_list.IndexOfName('������'),i]:=dm.aq31rece_gaffetconfir.Value;
    sgrid1.Cells[str_list.IndexOfName('���ʱ��'),i]:=dm.aq31technology_diff.Value;
//2017-3-20tangע---
//  sgrid1.Cells[2,i]:=dm.aq31QA_CONFIRMATION.Value;
//  sgrid1.Cells[3,i]:=dm.aq31SCRAP_QTY_reason.Value;
//  sgrid1.Cells[4,i]:=dm.aq31gaffer_confirmation.Value;
//  sgrid1.Cells[5,i]:=dm.aq31FLOW_QTY.AsString;
//  sgrid1.Cells[6,i]:=dm.aq31rece_gaffetconfir.Value;
//  sgrid1.Cells[7,i]:=dm.aq31technology_diff.Value;
//  SGrid1.Cells[9,i]:=dm.ADS31WideStringField.AsString;
  end
  else
  begin
    SGrid1.Cells[str_list.IndexOfName('�Ƴ̲���'),i]:='';
    sgrid1.Cells[str_list.IndexOfName('Ʒ��״��'),i]:='';
    sgrid1.Cells[str_list.IndexOfName('������'),i]:='';
    sgrid1.Cells[str_list.IndexOfName('���ʱ��'),i]:='';
//2017-3-20tangע---
//  sgrid1.Cells[2,i]:='';
//  sgrid1.Cells[3,i]:='';
//  sgrid1.Cells[4,i]:='';
//  sgrid1.Cells[5,i]:='';
//  sgrid1.Cells[6,i]:='';
//  sgrid1.Cells[7,i]:='';
//  SGrid1.Cells[9,i]:='';
  end;
    sgrid1.Cells[str_list.IndexOfName('Rkey34'),i]:=dm.ADS38DEPT_PTR.AsString;
//  sgrid1.Cells[8,i]:=dm.ADS38DEPT_PTR.AsString;
  Inc(i);
  dm.ADS38.Next;
  end;
  end;
  end
  else//��Ʒ����û�б仯ʱֱ�Ӵ�31���ж�ȡƷ�ʸ�����Ϣ
  begin
  form2.sgrid1.RowCount:=dm.ADS31.RecordCount+1;
  i:=1;
  while not dm.ADS31.Eof do
  begin
    sgrid1.Cells[str_list.IndexOfName('����'),i]:=dm.ADS31STEP_NUMBER.AsString;
    sgrid1.Cells[str_list.IndexOfName('��������'),i]:=dm.ADS31dept_name.Value;
    SGrid1.Cells[str_list.IndexOfName('�Ƴ̲���'),i]:=dm.ADS31WideStringField.AsString;
    sgrid1.Cells[str_list.IndexOfName('Ʒ��״��'),i]:=dm.ADS31FLOW_QTY.AsString;
    sgrid1.Cells[str_list.IndexOfName('������'),i]:=dm.ADS31rece_gaffetconfir.Value;
    sgrid1.Cells[str_list.IndexOfName('���ʱ��'),i]:=dm.ADS31technology_diff.Value;
    sgrid1.Cells[str_list.IndexOfName('Rkey34'),i]:=dm.ADS31DEPT_PTR.AsString;

//2017-3-20tangע---
//  form2.SGrid1.Cells[0,i]:=dm.ADS31STEP_NUMBER.AsString;
//  form2.SGrid1.Cells[1,i]:=dm.ADS31dept_name.Value;
//  form2.SGrid1.Cells[2,i]:=dm.ADS31QA_CONFIRMATION.Value;
//  form2.SGrid1.Cells[3,i]:=dm.ADS31SCRAP_QTY_reason.Value;
//  form2.SGrid1.Cells[4,i]:=dm.ADS31gaffer_confirmation.Value;
//  form2.SGrid1.Cells[5,i]:=dm.ADS31FLOW_QTY.AsString;
//  form2.SGrid1.Cells[6,i]:=dm.ADS31rece_gaffetconfir.Value;
//  form2.SGrid1.Cells[7,i]:=dm.ADS31technology_diff.Value;
//  form2.SGrid1.Cells[8,i]:=dm.ADS31DEPT_PTR.AsString;
//  form2.SGrid1.Cells[9,i]:=dm.ADS31WideStringField.AsString;
  Inc(i);
  dm.ADS31.Next;
  end;
  end;
  end;
end;

procedure TForm2.SGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
  if (ACol =str_list.IndexOfName('������')) then
  begin
    BitBtn9.Width := 22;
    BitBtn9.Height := SGrid1.DefaultRowHeight;
    BitBtn9.Left :=TreeView1.Width+30+SGrid1.ColWidths[str_list.IndexOfName('��������')]+SGrid1.ColWidths[str_list.IndexOfName('�Ƴ̲���')]+SGrid1.ColWidths[str_list.IndexOfName('Ʒ��״��')]+56;
    BitBtn9.Top := SGrid1.Top+ARow*BitBtn9.Height+ARow*1+2;
    BitBtn9.Visible := True;
    if trim(SGrid1.Cells[acol,arow])<>'' then
      BitBtn9.Click;
  end
  else
    BitBtn9.Visible :=false;
 if acol<3 then
  sgrid1.Options:=sgrid1.Options-[goEditing]
 else
  sgrid1.Options:=sgrid1.Options+[goEditing];
end;

procedure TForm2.update_31(rkey25:integer);
var
i:integer;
begin
  dm.ADO31.Close;
  dm.ADO31.Parameters[0].Value:=rkey25;
  dm.ADO31.Open;
  for i:=1 to sgrid1.RowCount-1 do
    begin
//     dm.ADO31.Append;
//     dm.ADO31SOURCE_PTR.Value:=rkey25;     //25.rkey
//     dm.ADO31STEP_NUMBER.Value:=strtoint(sgrid1.Cells[0,i]);  //����
//     dm.ADO31DEPT_PTR.Value:=strtoint(sgrid1.Cells[8,i]);//34rkeyָ��
//     dm.ADO31technology_diff.Value:=sgrid1.Cells[2,i];// �����ѵ�
//     dm.ADO31SCRAP_QTY_reason.Value:=sgrid1.Cells[3,i];// ���Ʒ���
//     dm.ADO31gaffer_confirmation.Value:=sgrid1.Cells[4,i];//��������
//     dm.ADO31QA_CONFIRMATION.Value:=sgrid1.Cells[5,i];//Ʒ��״��
//     dm.ADO31rece_gaffetconfir.Value:=sgrid1.Cells[6,i];//������
//     dm.ADO31FLOW_QTY.Value:=sgrid1.Cells[7,i];//���ʱ��
//     dm.ADO31.Post;

//2017-3-20tangע---
//     dm.ADO31.Append;
//     dm.ADO31SOURCE_PTR.Value:=rkey25;     //25.rkey
//     dm.ADO31STEP_NUMBER.Value:=strtoint(sgrid1.Cells[0,i]);  //����
//     dm.ADO31DEPT_PTR.Value:=strtoint(sgrid1.Cells[8,i]);//34rkeyָ��
//     dm.ADO31technology_diff.Value:=sgrid1.Cells[7,i];// ���ʱ��
//     dm.ADO31SCRAP_QTY_reason.Value:=sgrid1.Cells[3,i];// ���Ʒ���
//     dm.ADO31gaffer_confirmation.Value:=sgrid1.Cells[4,i];//��������
//     dm.ADO31QA_CONFIRMATION.Value:=sgrid1.Cells[2,i];//�����ѵ�
//     dm.ADO31rece_gaffetconfir.Value:=sgrid1.Cells[6,i];//������
//     dm.ADO31FLOW_QTY.Value:=sgrid1.Cells[5,i];// Ʒ��״��
//     dm.ADO31.Post;
     dm.ADO31.Append;
     dm.ADO31SOURCE_PTR.Value:=rkey25;     //25.rkey
     dm.ADO31STEP_NUMBER.Value:=strtoint(sgrid1.Cells[str_list.IndexOfName('����'),i]);  //����
     dm.ADO31DEPT_PTR.Value:=strtoint(sgrid1.Cells[str_list.IndexOfName('Rkey34'),i]);//34rkeyָ��
     dm.ADO31technology_diff.Value:=sgrid1.Cells[str_list.IndexOfName('���ʱ��'),i];// ���ʱ��
     dm.ADO31rece_gaffetconfir.Value:=sgrid1.Cells[str_list.IndexOfName('������'),i];//������
     dm.ADO31FLOW_QTY.Value:=sgrid1.Cells[str_list.IndexOfName('Ʒ��״��'),i];// Ʒ��״��
     dm.ADO31.Post;
    end;
end;

function TForm2.find_31(rkey25:integer):boolean;
begin
result:=false;
with dm.ADOQuery1 do
begin
close;
sql.Clear;
sql.Text:='select * from data0031 where source_ptr=:rkey25';
Parameters[0].Value:=rkey25;
open;
if not IsEmpty then result:=true;
end;
end;

procedure TForm2.BitBtn1Click(Sender: TObject);
begin
dm.ADOConnection1.BeginTrans;
try
if not find_31(strtoint(rkey25.Caption)) then//����(��ز�Ʒ31�����޼�¼ʱ)
begin
self.update_31(strtoint(rkey25.Caption));
end
else//����(��ز�Ʒ31�����Ѵ��ڼ�¼ʱ)
begin
with dm.ADOQuery1 do//��ɾ��31���е���ؼ�¼
begin
SQL.Clear;
sql.Text:='delete from data0031 where source_ptr=:rkey25';
Parameters[0].Value:=strtoint(rkey25.Caption);
ExecSQL;
end;
self.update_31(strtoint(rkey25.Caption));//����������ز�Ʒ31���еļ�¼
end;
with dm.ADOQuery1 do//�ı�25���Ʒ����״̬
begin
close;
sql.Clear;
sql.Text:='update data0025 set quality_status=0 where rkey='+rkey25.Caption;
ExecSQL;
end;
dm.ADOConnection1.CommitTrans;
showmessage('���ݱ���ɹ�,���ύ��ƷƷ�ʸ��ٱ�!');
if TreeView1.Selected.Level=0 then
 begin
 dm.ADS25.Close;
 dm.ADS25.Prepared;
 dm.ADS25.Open;
 dm.ADS25.Locate('rkey',rkey25.Caption,[]);
 end;
Close;
except
 on E: Exception do
  begin
   dm.ADOConnection1.RollbackTrans;
   messagedlg(E.Message,mterror,[mbcancel],0);
  end;
end;
end;

{procedure TForm2.SGrid1KeyPress(Sender: TObject; var Key: Char);
begin
if sgrid1.Col=5 then
begin
 if not (key in ['0'..'9',#8,#13]) then  //�ж��Ƿ���������
  abort;
end;
end;}

procedure TForm2.BitBtn11Click(Sender: TObject);
begin
dm.ADOConnection1.BeginTrans;
try
if not find_31(strtoint(rkey25.Caption)) then//����(��ز�Ʒ31�����޼�¼ʱ)
begin
self.update_31(strtoint(rkey25.Caption));
end
else//����(��ز�Ʒ31�����Ѵ��ڼ�¼ʱ)
begin
with dm.ADOQuery1 do//��ɾ��31���е���ؼ�¼
begin
SQL.Clear;
sql.Text:='delete from data0031 where source_ptr=:rkey25';
Parameters[0].Value:=strtoint(rkey25.Caption);
ExecSQL;
end;
self.update_31(strtoint(rkey25.Caption));//����������ز�Ʒ31���еļ�¼
end;
with dm.ADOQuery1 do//�ı�25���Ʒ����״̬
begin
close;
sql.Clear;
sql.Text:='update data0025 set quality_status=0 where rkey='+rkey25.Caption;
ExecSQL;
end;
dm.ADOConnection1.CommitTrans;
showmessage('���ݱ���ɹ�,���ύ��ƷƷ�ʸ��ٱ�!');
if TreeView1.Selected.Level=0 then
 begin
 dm.ADS25.Close;
 dm.ADS25.Prepared;
 dm.ADS25.Open;
 dm.ADS25.Locate('rkey',rkey25.Caption,[]);
 end;
except
 on E: Exception do
  begin
   dm.ADOConnection1.RollbackTrans;
   messagedlg(E.Message,mterror,[mbcancel],0);
  end;
end;
end;


procedure TForm2.SGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   IF (KEY=13) and (SGrid1.row<SGrid1.RowCount-1) then
   SGrid1.row:=SGrid1.row+1;
   if (chr(key)='D') and (ssCtrl in shift) and (sgrid1.Row>1)
  then
  begin
   sgrid1.Cells[sgrid1.col,sgrid1.row]:=
   sgrid1.Cells[sgrid1.col,sgrid1.row-1];
  end;
end;

procedure TForm2.SGrid1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var column,row:integer;
begin
 if button=mbright then
 begin
  (sender as tstringgrid).MouseToCell(x,y,column,row);
   if row<>0 then
  (sender as tstringgrid).Row:=row;
  (sender as tstringgrid).Col:=column;
 end;
end;

procedure TForm2.BitBtn3Click(Sender: TObject);
begin
  if MessageDlg('��ȷ�ϵ������ݵ�Excel��?',mtConfirmation,[mbYes, mbNo],0) =mryes then
  Export_Grid_to_Excel(self.SGrid1,self.Caption);
end;

procedure TForm2.BitBtn4Click(Sender: TObject);
begin
 if strtoint(vprev)=1 then
  begin
   ShowMsg('�Բ���!��û�иó���Ŀ�дȨ��',1);
   exit;
  end;
//ֻ��״̬Ϊ�������У��ⷢ����������֣����������ҵ�����ܴ�ӡ��

  with Tfrm_ProcedureReport.Create(application) do
  TRY
    ads25.Close;
    ads25.Parameters.ParamValues['MANU_PART_NUMBER']:=
          DM.AQY0025MANU_PART_NUMBER.Value;
    ads25.Open;
    ppReport1.Reset;
    ppReport1.Template.FileName :=
      stringReplace(UpperCase(GetCurrentDir),'EXEC','NIERP\REPORT\',[rfReplaceAll])+
        'wzpr031.rtm';
    ppReport1.Template.LoadFromFile;
    ppReport1.SaveAsTemplate:=false;

    ppreport1.Print;

  FINALLY
   Free;
  END;
end;

procedure TForm2.inti;
var j,i:integer;
begin
  SGrid1.Update;
  for j :=SGrid1.RowCount-1  downto 1  do
  begin
    for i:=0 to SGrid1.ColCount do
    begin
      SGrid1.Cells[i,j]:='';
    end;
    if (SGrid1.rowcount>2) then SGrid1.rowcount := SGrid1.rowcount - 1;
  end;
  str_list := TStringList.Create;
  str_list.Add('����=INV_NAME');
  str_list.Add('��������=frequency');
  str_list.Add('�Ƴ̲���=controlTarget');
  str_list.Add('Ʒ��״��=controlLowerLimit');
  str_list.Add('������=controlUpperLimit');
  str_list.Add('���ʱ��=testResult');
  str_list.Add('RKEY34=Rkey');
  SGrid1.ColCount:=str_list.Count;
  for j := 0 to str_list.Count-1  do    //SGrd��ӵ�һ�е��ֶ���
  begin
    SGrid1.Cells[j,0] := str_list.Names[j];
  end;
  SGrid1.Height:=26;
  SGrid1.FixedRows:=1;
  SGrid1.ColWidths[str_list.IndexOfName('����')]:=30;
  SGrid1.ColWidths[str_list.IndexOfName('��������')]:=80;
  SGrid1.ColWidths[str_list.IndexOfName('�Ƴ̲���')]:=500;
  SGrid1.ColWidths[str_list.IndexOfName('Ʒ��״��')]:=135;
  SGrid1.ColWidths[str_list.IndexOfName('������')]:=70;
  SGrid1.ColWidths[str_list.IndexOfName('���ʱ��')]:=100;
  SGrid1.ColWidths[str_list.IndexOfName('RKEY34')]:=-1;
end;

procedure TForm2.SGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
begin
  if (gdSelected  in State) then
  begin
    if (ACol =str_list.IndexOfName('���ʱ��')) then
    begin
      dtpk1.Width := 100;
      dtpk1.Height := SGrid1.DefaultRowHeight;
      dtpk1.Left :=TreeView1.Width+30+SGrid1.ColWidths[str_list.IndexOfName('��������')]+SGrid1.ColWidths[str_list.IndexOfName('�Ƴ̲���')]+SGrid1.ColWidths[str_list.IndexOfName('Ʒ��״��')]+SGrid1.ColWidths[str_list.IndexOfName('������')]+8;
      dtpk1.Top := SGrid1.Top+ARow*dtpk1.Height+ARow*1+2;
      dtpk1.Visible := True;
      if trim(SGrid1.Cells[acol,arow])<>'' then
        dtpk1.Date:=strtodate(SGrid1.Cells[acol,arow]);
    end
    else
      dtpk1.Visible :=false;
  end;
end;

procedure TForm2.dtpk1Exit(Sender: TObject);
begin
  SGrid1.Cells[str_list.IndexOfName('���ʱ��'),SGrid1.Row]:=datetostr(dtpk1.Date);
end;

procedure TForm2.BitBtn9Click(Sender: TObject);
var InputVar: PDlgInput ;
begin
  try
    frmPick_Item_Single := TfrmPick_Item_Single.Create(application) ;
    InputVar.Fields := 'empl_code/Ա������/160,employee_Name/Ա������/250';
    InputVar.Sqlstr :='select data0005.empl_code,data0005.employee_Name,data0034.DEPT_NAME '
                     +' from data0005 inner join data0034 on data0005.employee_id=data0034.rkey'
                     +' left join dbo.Data0073 on dbo.Data0073.EMPLOYEE_PTR = dbo.Data0005.RKEY'
                     +' left join dbo.Data0015 ON dbo.Data0015.RKEY = dbo.Data0073.warehouse_ptr'
                     +' where data0005.ACTIVE_FLAG=''Y'' and Data0034.DEPT_NAME like ''%��Ʒ%'' and data0015.warehouse_code=''D0001''';
    inputvar.KeyField:='empl_code';
    InputVar.AdoConn := dm.ADOConnection1;
    frmPick_Item_Single.InitForm_New(InputVar)  ;
    if frmPick_Item_Single.ShowModal=mrok then
    begin
      SGrid1.Cells[str_list.IndexOfName('������'),SGrid1.Row]:=frmPick_Item_Single.adsPick.FieldValues['employee_Name'];
    end;
  finally
    frmPick_Item_Single.adsPick.Close;
    frmPick_Item_Single.Free ;
  end;
end;

end.
