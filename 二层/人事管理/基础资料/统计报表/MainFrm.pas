unit MainFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, StdCtrls, Buttons, ExtCtrls, Grids, DBGridEh,
  TeeProcs, TeEngine, Chart, DbChart, DM, ADODB, ImgList, Series, TeePrevi;

type
  TFrmMain = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    PageControl1: TPageControl;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    ImageList1: TImageList;
    TreeView1: TTreeView;
    DBChart1: TDBChart;
    DBGridEh1: TDBGridEh;
    DBGridEh2: TDBGridEh;
    Series1: TBarSeries;
    DBGridEh3: TDBGridEh;
    DBChart5: TDBChart;
    BarSeries1: TBarSeries;
    DBChart2: TDBChart;
    BarSeries2: TBarSeries;
    DBGridEh4: TDBGridEh;
    DBChart4: TDBChart;
    BarSeries3: TBarSeries;
    TabSheet1: TTabSheet;
    DBGridEh5: TDBGridEh;
    DBChart3: TDBChart;
    BarSeries4: TBarSeries;
    DBGridEh6: TDBGridEh;
    DBChart6: TDBChart;
    BarSeries5: TBarSeries;
    procedure FormCreate(Sender: TObject);
    procedure TreeView1Click(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
  private
    { Private declarations }
    StartSqltemp, starSQLsex, DeptRkeyStr: string;
    procedure CreateTree();
    procedure CreateNode(ParentNode:TTreeNode; Query:TADOQuery);
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation
   uses common;
{$R *.dfm}
procedure TFrmMain.CreateTree();
var
  BootNode: TTreeNode; //�����
  NodeInfo: ^Integer; //rkey
begin
  if TreeView1.Items.Count <> 0 then TreeView1.Items.Clear;
  with damo.qrydept do
  begin
    Filtered := False;
    Filter := ' superior=0 ';
    Filtered := True;
    First;
    while not Eof do
    begin
      New(NodeInfo);
      NodeInfo^ := FieldByName('rkey').AsInteger;
      BootNode := TreeView1.Items.AddChildObject(nil, FieldByName('departmentname').AsString,NodeInfo); //��Ӹ���㣬�������������Ϣ
      CreateNode(BootNode, damo.qrydept);
      Next;
    end;
    First;
  end;
  TreeView1.ReadOnly := true;
  TreeView1.DragMode := dmAutomatic;
end;

procedure TFrmMain.CreateNode(ParentNode: TTreeNode;Query: TADOQuery);
var
  ChildNode: TTreeNode; //���ӽ��
  NodeInfo: ^Integer; //rkey
  QueryTmp: TADOQuery;
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
       NodeInfo^ := FieldByName('rkey').AsInteger;
       ChildNode := TreeView1.Items.AddChildObject(ParentNode,FieldByName('departmentname').AsString,NodeInfo); //��Ӻ��ӽ�㣬���������ӽ����Ϣ
       CreateNode(ChildNode,Query); //�ݹ�
       Next;
      end;
      Free; //�ͷ����õ�query
    end;
end;

procedure TFrmMain.FormCreate(Sender: TObject);
begin
  if not App_Init_2(damo.ADOConnection1) then
  begin
    ShowMsg('������ʧ������ϵ����Ա',1);
    application.Terminate;
    exit;
  end;
  Caption := application.Title;
  StartSqltemp := damo.qryempWhere.SQL.Text;
  starSQLsex := damo.qrysex.SQL.Text;
  DeptRkeyStr := '';
  damo.qrydept.Close;
  damo.qrydept.Open;
  CreateTree;
  PageControl1Change(PageControl1);
      if (StrToInt(vprev) =2) or (StrToInt(vprev) =1) then
    begin
      DBGridEh6.Visible := False;
      DBChart6.Visible := False;
    end;
end;

procedure TFrmMain.TreeView1Click(Sender: TObject);
var
  depRkey: string;
begin
  with damo.qrytemp do
  begin
    Close;
    SQL.Clear;
    SQL.Text := 'select rkey from datadepartment where departmentname = ' + QuotedStr(TreeView1.Selected.Text);
    Open;
    depRkey := IntToStr(FieldValues['rkey']);

    Close;
    SQL.Clear ;
    SQL.Add('select dbo.get_departments(:det_id) as DeptStr');
    Parameters[0].Value := depRkey;
    Prepared:=true;
    Open;
    DeptRkeyStr := FieldValues['DeptStr'];
  end;
  PageControl1Change(PageControl1);
end;

procedure TFrmMain.PageControl1Change(Sender: TObject);
var
  MinBirthday, MaxBirthday: TDateTime;
begin
  //�Ա�ͳ��
  if PageControl1.ActivePageIndex = 0 then
  begin
    damo.qrysex.Close;
    if DeptRkeyStr <> '' then
    begin
      damo.qrysex.SQL.Text := starSQLsex
        + ' inner join datadepartment on employeemsg.departmentid=datadepartment.rkey '
        + ' where employeemsg.status = 1 '
        + ' and employeemsg.departmentid in ' + DeptRkeyStr
        + ' group by sex ';
    end
    else
    begin
      damo.qrysex.SQL.Text := starSQLsex
        + ' inner join datadepartment on employeemsg.departmentid=datadepartment.rkey '
        + ' where employeemsg.status = 1 '
        + ' group by sex ';
    end;
    damo.qrysex.Open;
    DBChart1.Series[0].XLabelsSource := '�Ա�';
    DBChart1.Series[0].YValues.ValueSource := '����';
  end;
  //�����ͳ��
  if PageControl1.ActivePageIndex = 1 then
  begin
    damo.qryBirthday.Close;
    if DeptRkeyStr <> '' then
    begin
      damo.qryBirthday.SQL.Text := 'select ''1950-1960'' as ���, count(*) as ���� from employeemsg '
        + ' inner join datadepartment on employeemsg.departmentid=datadepartment.rkey '
        + ' where birthday >=''1950-01-01'' and birthday <''1960-01-01'' and status=1 '
        + ' and employeemsg.departmentid in ' + DeptRkeyStr

        + ' union '
        + ' select ''1960-1970'' as ���, count(*) as ���� from employeemsg '
        + ' inner join datadepartment on employeemsg.departmentid=datadepartment.rkey '
        + ' where birthday >=''1960-01-01'' and birthday <''1970-01-01'' and status=1 '
        + ' and employeemsg.departmentid in ' + DeptRkeyStr

        + ' union '
        + ' select ''1970-1980'' as ���, count(*) as ���� from employeemsg '
        + ' inner join datadepartment on employeemsg.departmentid=datadepartment.rkey '
        + ' where birthday >=''1970-01-01'' and birthday <''1980-01-01'' and status=1 '
        + ' and employeemsg.departmentid in ' + DeptRkeyStr

        + ' union '
        + ' select ''1980-1990'' as ���, count(*) as ���� from employeemsg '
        + ' inner join datadepartment on employeemsg.departmentid=datadepartment.rkey '
        + ' where birthday >=''1980-01-01'' and birthday <''1990-01-01'' and status=1 '
        + ' and employeemsg.departmentid in ' + DeptRkeyStr

        + ' union '
        + ' select ''1990-2010'' as ���, count(*) as ���� from employeemsg '
        + ' inner join datadepartment on employeemsg.departmentid=datadepartment.rkey '
        + ' where birthday >=''1990-01-01'' and birthday <''2010-01-01'' and status=1 '
        + ' and employeemsg.departmentid in ' + DeptRkeyStr

        + ' union '
        + ' select ''2010-2020'' as ���, count(*) as ���� from employeemsg '
        + ' inner join datadepartment on employeemsg.departmentid=datadepartment.rkey '
        + ' where birthday >=''2010-01-01'' and birthday <''2020-01-01'' and status=1 '
        + ' and employeemsg.departmentid in ' + DeptRkeyStr;
    end
    else
    begin
      damo.qryBirthday.SQL.Text := 'select ''1950-1960'' as ���, count(*) as ���� from employeemsg '
        + ' inner join datadepartment on employeemsg.departmentid=datadepartment.rkey '
        + ' where birthday >=''1950-01-01'' and birthday <''1960-01-01'' and status=1 '

        + ' union '
        + ' select ''1960-1970'' as ���, count(*) as ���� from employeemsg '
        + ' inner join datadepartment on employeemsg.departmentid=datadepartment.rkey '
        + ' where birthday >=''1960-01-01'' and birthday <''1970-01-01'' and status=1 '

        + ' union '
        + ' select ''1970-1980'' as ���, count(*) as ���� from employeemsg '
        + ' inner join datadepartment on employeemsg.departmentid=datadepartment.rkey '
        + ' where birthday >=''1970-01-01'' and birthday <''1980-01-01'' and status=1 '

        + ' union '
        + ' select ''1980-1990'' as ���, count(*) as ���� from employeemsg '
        + ' inner join datadepartment on employeemsg.departmentid=datadepartment.rkey '
        + ' where birthday >=''1980-01-01'' and birthday <''1990-01-01'' and status=1 '

        + ' union '
        + ' select ''1990-2010'' as ���, count(*) as ���� from employeemsg '
        + ' inner join datadepartment on employeemsg.departmentid=datadepartment.rkey '
        + ' where birthday >=''1990-01-01'' and birthday <''2010-01-01'' and status=1 '

        + ' union '
        + ' select ''2010-2020'' as ���, count(*) as ���� from employeemsg '
        + ' inner join datadepartment on employeemsg.departmentid=datadepartment.rkey '
        + ' where birthday >=''2010-01-01'' and birthday <''2020-01-01'' and status=1 ';
    end;
    damo.qryBirthday.Open;
    DBChart2.Series[0].XLabelsSource := '���';
    DBChart2.Series[0].YValues.ValueSource := '����';
  end;
  //�Ļ��̶�ͳ��

  if PageControl1.ActivePageIndex = 2 then
  begin
    damo.qryEducation.Close;
    if DeptRkeyStr <> '' then
    begin
      damo.qryEducation.SQL.Text := 'select count(*) ''����'', datadetail.item '
        + ' from employeemsg '
        + ' inner join Employeebasicsalary on employeemsg.rkey=Employeebasicsalary.employeeid '
        + ' inner join datadepartment on employeemsg.departmentid=datadepartment.rkey '
        + ' inner join datadetail on employeemsg.education = datadetail.rkey '
        + ' where status=1 '
        + ' and employeemsg.departmentid in ' + DeptRkeyStr
        + ' group by datadetail.item';
    end
    else
    begin
      damo.qryEducation.SQL.Text := 'select count(*) ''����'', datadetail.item '
        + ' from employeemsg '
        + ' inner join Employeebasicsalary on employeemsg.rkey=Employeebasicsalary.employeeid '
        + ' inner join datadepartment on employeemsg.departmentid=datadepartment.rkey '
        + ' inner join datadetail on employeemsg.education = datadetail.rkey '
        + ' where status=1 '
        + ' group by datadetail.item';
    end;
    damo.qryEducation.Open;
    DBChart3.Series[0].XLabelsSource := 'item';
    DBChart3.Series[0].YValues.ValueSource := '����';
  end;

   //����ͳ��

  if PageControl1.ActivePageIndex = 3 then
  begin
    damo.qryProvince.close;
    if DeptRkeyStr <> '' then
    begin
      damo.qryProvince.SQL.Text :='select * from (select count(*) as ����, '+
        '  case when  left(idcard,4)='+ QuotedStr('4414')+' then '+ QuotedStr('÷����')+
        '  when  left(idcard,2)='+ QuotedStr('44')+' then '+ QuotedStr('�㶫(÷��)')+
        '  when  left(idcard,2)='+ QuotedStr('43')+' then '+ QuotedStr('����')+
        '  when  left(idcard,2)='+ QuotedStr('42')+' then '+ QuotedStr('����')+
        '  when  left(idcard,2)='+ QuotedStr('41')+' then '+ QuotedStr('����')+
        '  when  left(idcard,2)='+ QuotedStr('45')+' then '+ QuotedStr('����')+
        '  when  left(idcard,2)='+ QuotedStr('36')+' then '+ QuotedStr('����')+
        '  when  left(idcard,2)='+ QuotedStr('51')+' or left(idcard,2)='+ QuotedStr('51')+' then '+ QuotedStr('�Ĵ�')+
        '  when  left(idcard,2)='+ QuotedStr('52')+' then '+ QuotedStr('����')+
        '  when  left(idcard,2)='+ QuotedStr('61')+' then '+ QuotedStr('����')+
        '  when  left(idcard,2)='+ QuotedStr('53')+' then '+ QuotedStr('����')+
        '  when  left(idcard,2)='+ QuotedStr('34')+' then '+ QuotedStr('����')+
        '  when  left(idcard,2)='+ QuotedStr('62')+' then '+ QuotedStr('����')+
        ' else '+ QuotedStr('��������')+' end as area from employeemsg  where status=1 '+
        ' and employeemsg.departmentid in ' + DeptRkeyStr +
        ' group by (  case when  left(idcard,4)='+ QuotedStr('4414')+' then '+ QuotedStr('÷����')+
        '  when  left(idcard,2)='+ QuotedStr('44')+' then '+ QuotedStr('�㶫(÷��)')+
        '  when  left(idcard,2)='+ QuotedStr('43')+' then '+ QuotedStr('����')+
        '  when  left(idcard,2)='+ QuotedStr('42')+' then '+ QuotedStr('����')+
        '  when  left(idcard,2)='+ QuotedStr('41')+' then '+ QuotedStr('����')+
        '  when  left(idcard,2)='+ QuotedStr('45')+' then '+ QuotedStr('����')+
        '  when  left(idcard,2)='+ QuotedStr('36')+' then '+ QuotedStr('����')+
        '  when  left(idcard,2)='+ QuotedStr('51')+' or left(idcard,2)='+ QuotedStr('51')+' then '+ QuotedStr('�Ĵ�')+
        '  when  left(idcard,2)='+ QuotedStr('52')+' then '+ QuotedStr('����')+
        '  when  left(idcard,2)='+ QuotedStr('61')+' then '+ QuotedStr('����')+
        '  when  left(idcard,2)='+ QuotedStr('53')+' then '+ QuotedStr('����')+
        '  when  left(idcard,2)='+ QuotedStr('34')+' then '+ QuotedStr('����')+
        '  when  left(idcard,2)='+ QuotedStr('62')+' then '+ QuotedStr('����')+
        ' else '+ QuotedStr('��������')+' end )'+
        ' ) as b order by ���� desc '
    end
    else
    begin
      damo.qryProvince.SQL.Text :='select * from (select count(*) as ����, '+
        ' case when  left(idcard,4)='+ QuotedStr('4414')+' then '+ QuotedStr('÷����')+
        '  when  left(idcard,2)='+ QuotedStr('44')+' then '+ QuotedStr('�㶫(÷��)')+
        '  when  left(idcard,2)='+ QuotedStr('43')+' then '+ QuotedStr('����')+
        '  when  left(idcard,2)='+ QuotedStr('42')+' then '+ QuotedStr('����')+
        '  when  left(idcard,2)='+ QuotedStr('41')+' then '+ QuotedStr('����')+
        '  when  left(idcard,2)='+ QuotedStr('45')+' then '+ QuotedStr('����')+
        '  when  left(idcard,2)='+ QuotedStr('36')+' then '+ QuotedStr('����')+
        '  when  left(idcard,2)='+ QuotedStr('51')+' or left(idcard,2)='+ QuotedStr('51')+' then '+ QuotedStr('�Ĵ�')+
        '  when  left(idcard,2)='+ QuotedStr('52')+' then '+ QuotedStr('����')+
        '  when  left(idcard,2)='+ QuotedStr('61')+' then '+ QuotedStr('����')+
        '  when  left(idcard,2)='+ QuotedStr('53')+' then '+ QuotedStr('����')+
        '  when  left(idcard,2)='+ QuotedStr('34')+' then '+ QuotedStr('����')+
        '  when  left(idcard,2)='+ QuotedStr('62')+' then '+ QuotedStr('����')+
        ' else '+ QuotedStr('��������')+' end as area from employeemsg  where status=1 '+
        ' group by (  case when  left(idcard,4)='+ QuotedStr('4414')+' then '+ QuotedStr('÷����')+
        '  when  left(idcard,2)='+ QuotedStr('44')+' then '+ QuotedStr('�㶫(÷��)')+
        '  when  left(idcard,2)='+ QuotedStr('43')+' then '+ QuotedStr('����')+
        '  when  left(idcard,2)='+ QuotedStr('42')+' then '+ QuotedStr('����')+
        '  when  left(idcard,2)='+ QuotedStr('41')+' then '+ QuotedStr('����')+
        '  when  left(idcard,2)='+ QuotedStr('45')+' then '+ QuotedStr('����')+
        '  when  left(idcard,2)='+ QuotedStr('36')+' then '+ QuotedStr('����')+
        '  when  left(idcard,2)='+ QuotedStr('51')+' or left(idcard,2)='+ QuotedStr('51')+' then '+ QuotedStr('�Ĵ�')+
        '  when  left(idcard,2)='+ QuotedStr('52')+' then '+ QuotedStr('����')+
        '  when  left(idcard,2)='+ QuotedStr('61')+' then '+ QuotedStr('����')+
        '  when  left(idcard,2)='+ QuotedStr('53')+' then '+ QuotedStr('����')+
        '  when  left(idcard,2)='+ QuotedStr('34')+' then '+ QuotedStr('����')+
        '  when  left(idcard,2)='+ QuotedStr('62')+' then '+ QuotedStr('����')+
        ' else '+ QuotedStr('��������')+' end )'+
        ' ) as b order by ���� desc '
    end;
    //ShowMessage( damo.qryProvince.SQL.Text);
    damo.qryProvince.Open;
    DBChart4.Series[0].XLabelsSource := 'area';
    DBChart4.Series[0].YValues.ValueSource := '����';   
  end;

  //����ͳ��
  if PageControl1.ActivePageIndex = 4 then
  begin
    damo.qryWorkAge.Close;
    if DeptRkeyStr <> '' then
    begin
      damo.qryWorkAge.SQL.Text := 'SELECT  count(*) WorkAge, ''1������'' as a,1 as b  '
      +' from employeemsg inner join datadepartment on employeemsg.departmentid=datadepartment.rkey '
      +' where dateadd(month,1,ondutytime)>getdate() and status=1 '
      + ' and employeemsg.departmentid in ' + DeptRkeyStr
      +' union '
      +' select count(*) WorkAge, ''1-3������'' as a,2 as b  '
      +' from employeemsg inner join datadepartment on employeemsg.departmentid=datadepartment.rkey  '
      +' where dateadd(month,1,ondutytime)<=getdate() and status=1 and dateadd(month,3,ondutytime)>getdate() '
      + ' and employeemsg.departmentid in ' + DeptRkeyStr
      +' union '
      +' SELECT count(*) WorkAge,''3-6������'' as a,3 as b '
      +'  from employeemsg inner join datadepartment on employeemsg.departmentid=datadepartment.rkey '
      +' where dateadd(month,3,ondutytime)<=getdate() and status=1 and dateadd(month,6,ondutytime)>getdate() '
        + ' and employeemsg.departmentid in ' + DeptRkeyStr
      +'    union     '
      +'   SELECT           count(*) WorkAge,''6-12������'' as a,4 as b '
      +'  from employeemsg inner join datadepartment on employeemsg.departmentid=datadepartment.rkey '
      +' where dateadd(month,6,ondutytime)<=getdate() and status=1 and dateadd(month,12,ondutytime)>getdate() '
      + ' and employeemsg.departmentid in ' + DeptRkeyStr
      +'  union  '
      +' SELECT   count(*) WorkAge,''1-2����'' as a,5 as b   '
      +'  from employeemsg inner join datadepartment on employeemsg.departmentid=datadepartment.rkey '
      +' where dateadd(month,12,ondutytime)<=getdate() and status=1 and dateadd(month,24,ondutytime)>getdate()'
        + ' and employeemsg.departmentid in ' + DeptRkeyStr

      +'  union  '
      +'  SELECT  count(*) WorkAge,''2-3����'' as a,6 as b '
      +'  from employeemsg inner join datadepartment on employeemsg.departmentid=datadepartment.rkey '
      +' where dateadd(month,24,ondutytime)<=getdate() and status=1 and dateadd(month,36,ondutytime)>getdate() '
        + ' and employeemsg.departmentid in ' + DeptRkeyStr
      +' union  '
      +'  SELECT count(*) WorkAge,''3������'' as a,7 as b  '
      +'  from employeemsg inner join datadepartment on employeemsg.departmentid=datadepartment.rkey '
      +' where dateadd(month,36,ondutytime)<=getdate() and status=1  '
      + ' and employeemsg.departmentid in ' + DeptRkeyStr
      +' order by b ';
    end
    else
    begin
      damo.qryWorkAge.SQL.Text :=  'SELECT  count(*) WorkAge, ''1������'' as a,1 as b '
      +' from employeemsg inner join datadepartment on employeemsg.departmentid=datadepartment.rkey '
      +' where dateadd(month,1,ondutytime)>getdate() and status=1 '
      +' union '
      +' select count(*) WorkAge, ''1-3������'' as a,2 as b  '
      +' from employeemsg inner join datadepartment on employeemsg.departmentid=datadepartment.rkey  '
      +' where dateadd(month,1,ondutytime)<=getdate() and status=1 and dateadd(month,3,ondutytime)>getdate() '
      +' union '
      +' SELECT count(*) WorkAge,''3-6������'' as a,3 as b '
      +'  from employeemsg inner join datadepartment on employeemsg.departmentid=datadepartment.rkey '
      +' where dateadd(month,3,ondutytime)<=getdate() and status=1 and dateadd(month,6,ondutytime)>getdate() '
      +'    union     '
      +'   SELECT           count(*) WorkAge,''6-12������'' as a,4 as b '
      +'  from employeemsg inner join datadepartment on employeemsg.departmentid=datadepartment.rkey '
      +' where dateadd(month,6,ondutytime)<=getdate() and status=1 and dateadd(month,12,ondutytime)>getdate() '
      +'  union  '
      +' SELECT   count(*) WorkAge,''1-2����'' as a,5 as b   '
      +'  from employeemsg inner join datadepartment on employeemsg.departmentid=datadepartment.rkey '
      +' where dateadd(month,12,ondutytime)<=getdate() and status=1 and dateadd(month,24,ondutytime)>getdate()'
      +'  union  '
      +'  SELECT  count(*) WorkAge,''2-3����'' as a,6 as b '
      +'  from employeemsg inner join datadepartment on employeemsg.departmentid=datadepartment.rkey '
      +' where dateadd(month,24,ondutytime)<=getdate() and status=1 and dateadd(month,36,ondutytime)>getdate() '
      +' union  '
      +'  SELECT count(*) WorkAge,''3������'' as a,7 as b  '
      +'  from employeemsg inner join datadepartment on employeemsg.departmentid=datadepartment.rkey '
      +' where dateadd(month,36,ondutytime)<=getdate() and status=1  '
      +' order by b ' ;
    end;
    damo.qryWorkAge.Open;
    DBChart5.Series[0].XLabelsSource := 'a';
    DBChart5.Series[0].YValues.ValueSource := 'WorkAge';
  end;
  //н��ͳ��
  if PageControl1.ActivePageIndex = 5 then
  begin
    if (StrToInt(vprev) =2) or (StrToInt(vprev) =1)then
    begin
      ShowMessage('н��������Ҫ��������Ȩ��');
      exit;
    end;

    damo.qrySalary.Close;
    if DeptRkeyStr <> '' then
    begin
      damo.qrySalary.SQL.Text := 'select count(*) ''����'', ''2K����'' ''н�ʷ�Χ'' from employeemsg '
        + ' inner join dbo.Employeebasicsalary on employeemsg.rkey = Employeebasicsalary.employeeid '
        + ' where F2>=0 and F2<2000 and status=1 '
        + ' and employeemsg.departmentid in ' + DeptRkeyStr

        + ' union '
        + ' select count(*) ''����'', ''2K-3K'' ''н�ʷ�Χ'' from employeemsg '
        + ' inner join dbo.Employeebasicsalary on employeemsg.rkey = Employeebasicsalary.employeeid '
        + ' where F2>=2000 and F2<3000 and status=1 '
        + ' and employeemsg.departmentid in ' + DeptRkeyStr

        + ' union '
        + ' select count(*) ''����'', ''3K-5K'' ''н�ʷ�Χ'' from employeemsg '
        + ' inner join dbo.Employeebasicsalary on employeemsg.rkey = Employeebasicsalary.employeeid '
        + ' where F2>=3000 and F2<5000 and status=1 '
        + ' and employeemsg.departmentid in ' + DeptRkeyStr

        + ' union '
        + ' select count(*) ''����'', ''5K-8K'' ''н�ʷ�Χ'' from employeemsg '
        + ' inner join dbo.Employeebasicsalary on employeemsg.rkey = Employeebasicsalary.employeeid '
        + ' where F2>=5000 and F2<8000 and status=1 '
        + ' and employeemsg.departmentid in ' + DeptRkeyStr

        + ' union '
        + ' select count(*) ''����'', ''8K-1W'' ''н�ʷ�Χ'' from employeemsg '
        + ' inner join dbo.Employeebasicsalary on employeemsg.rkey = Employeebasicsalary.employeeid '
        + ' where F2>=8000 and F2<10000 and status=1 '
        + ' and employeemsg.departmentid in ' + DeptRkeyStr

        + ' union '
        + ' select count(*) ''����'', ''1W-2W'' ''н�ʷ�Χ'' from employeemsg '
        + ' inner join dbo.Employeebasicsalary on employeemsg.rkey = Employeebasicsalary.employeeid '
        + ' where F2>=10000 and F2<=20000 and status=1 '
        + ' and employeemsg.departmentid in ' + DeptRkeyStr

        + ' union '
        + ' select count(*) ''����'', ''2W����'' ''н�ʷ�Χ'' from employeemsg '
        + ' inner join dbo.Employeebasicsalary on employeemsg.rkey = Employeebasicsalary.employeeid '
        + ' where F2>=20000 and status=1 '
        + ' and employeemsg.departmentid in ' + DeptRkeyStr;
    end
    else
    begin
      damo.qrySalary.SQL.Text := 'select count(*) ''����'', ''2K����'' ''н�ʷ�Χ'' from employeemsg '
        + ' inner join dbo.Employeebasicsalary on employeemsg.rkey = Employeebasicsalary.employeeid '
        + ' where F2>=0 and F2<2000 and status=1 '

        + ' union '
        + ' select count(*) ''����'', ''2K-3K'' ''н�ʷ�Χ'' from employeemsg '
        + ' inner join dbo.Employeebasicsalary on employeemsg.rkey = Employeebasicsalary.employeeid '
        + ' where F2>=2000 and F2<3000 and status=1 '

        + ' union '
        + ' select count(*) ''����'', ''3K-5K'' ''н�ʷ�Χ'' from employeemsg '
        + ' inner join dbo.Employeebasicsalary on employeemsg.rkey = Employeebasicsalary.employeeid '
        + ' where F2>=3000 and F2<5000 and status=1 '

        + ' union '
        + ' select count(*) ''����'', ''5K-8K'' ''н�ʷ�Χ'' from employeemsg '
        + ' inner join dbo.Employeebasicsalary on employeemsg.rkey = Employeebasicsalary.employeeid '
        + ' where F2>=5000 and F2<8000 and status=1 '

        + ' union '
        + ' select count(*) ''����'', ''8K-1W'' ''н�ʷ�Χ'' from employeemsg '
        + ' inner join dbo.Employeebasicsalary on employeemsg.rkey = Employeebasicsalary.employeeid '
        + ' where F2>=8000 and F2<10000 and status=1 '

        + ' union '
        + ' select count(*) ''����'', ''1W-2W'' ''н�ʷ�Χ'' from employeemsg '
        + ' inner join dbo.Employeebasicsalary on employeemsg.rkey = Employeebasicsalary.employeeid '
        + ' where F2>=10000 and F2<=20000 and status=1 '

        + ' union '
        + ' select count(*) ''����'', ''2W����'' ''н�ʷ�Χ'' from employeemsg '
        + ' inner join dbo.Employeebasicsalary on employeemsg.rkey = Employeebasicsalary.employeeid '
        + ' where F2>=20000 and status=1 ';
    end;
    damo.qrySalary.Open;
    DBChart6.Series[0].XLabelsSource := 'н�ʷ�Χ';
    DBChart6.Series[0].YValues.ValueSource := '����';
  end;
  damo.qryempWhere.Close;
  if DeptRkeyStr <> '' then
    damo.qryempWhere.SQL.Text := StartSqltemp + ' where status = 1 and departmentid in '
      + DeptRkeyStr + ' order by sex desc'
  else
    damo.qryempWhere.SQL.Text := StartSqltemp + ' where status = 1 order by sex desc' ;
    damo.qryempWhere.Open;
end;

procedure TFrmMain.BitBtn1Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TFrmMain.BitBtn3Click(Sender: TObject);
begin
  if PageControl1.ActivePageIndex = 0 then
    ChartPreview(Self, DBChart1);
  if PageControl1.ActivePageIndex = 1 then
    ChartPreview(Self, DBChart2);
  if PageControl1.ActivePageIndex = 2 then
    ChartPreview(Self, DBChart3);
  if PageControl1.ActivePageIndex = 3 then
    ChartPreview(Self, DBChart4);
  if PageControl1.ActivePageIndex = 4 then
    ChartPreview(Self, DBChart5);
  if PageControl1.ActivePageIndex = 5 then
    ChartPreview(Self, DBChart6);
end;

end.
