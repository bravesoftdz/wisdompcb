unit UImport4;

interface

uses
   Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, ExtCtrls,OleServer, Excel2000,ComObj, DB, ADODB,DateUtils;

type
  TfrmImport4 = class(TForm)
    pnl1: TPanel;
    pnl2: TPanel;
    btn_ExModel: TButton;
    btn_exit: TButton;
    btn_exportErr: TButton;
    pnl3: TPanel;
    sg1: TStringGrid;
    pnl4: TPanel;
    btn_OpenFile: TButton;
    btn_check: TButton;
    btn_import: TButton;
    dlgOpen1: TOpenDialog;
    qrytemp: TADOQuery;
    procedure btn_ExModelClick(Sender: TObject);
    procedure btn_exportErrClick(Sender: TObject);
    procedure btn_exitClick(Sender: TObject);
    procedure btn_OpenFileClick(Sender: TObject);
    procedure btn_checkClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_importClick(Sender: TObject);
  private
    { Private declarations }
     Eflag: Integer;
     ISchecked: integer;
  public
    { Public declarations }
  end;

var
  frmImport4: TfrmImport4;

implementation
  uses common, UDM, UMain;
{$R *.dfm}

procedure TfrmImport4.btn_ExModelClick(Sender: TObject);
var
  XLApp: Variant;
  Sheet: Variant;
begin
 if not VarIsEmpty(XLApp) then
  begin
    XLApp.DisplayAlerts := False;
    XLApp.Quit;
    VarClear(XLApp);
  end;
  try
    XLApp := CreateOleObject('Excel.Application');
  except
    Screen.Cursor := crDefault;
    Exit;
  end;
  XLApp.WorkBooks.Add;
  XLApp.SheetsInNewWorkbook := 1;

  XLApp.WorkBooks[1].WorkSheets[1].Name := 'ģ��';
  Sheet := XLApp.Workbooks[1].WorkSheets['ģ��'];

  Sheet.Cells[1,1]:='�·�';
  Sheet.Cells[1,2]:='����';
  Sheet.Cells[1,3]:='�γ̱��';
  Sheet.Cells[1,4]:='��ѵ��ʼ����';
  Sheet.Cells[1,5]:= '��ѵ��ʼʱ��';
  Sheet.Cells[1,6]:='��ѵ��������';
  Sheet.Cells[1,7]:='��ѵ����ʱ��';
  Sheet.Cells[1,8]:='��ѵ��ʦ';
  Sheet.Cells[1,9]:= '��ѵ�ص�';
  Sheet.Cells[1,10]:='��ѵʱ��';
  Sheet.Cells[1,11]:='��ע';
 // Sheet.Cells[1,12]:='�Ƿ�OK';
//  Sheet.Cells[1,13]:='����˵��';


   XlApp.Visible := True;

end;

procedure TfrmImport4.btn_exportErrClick(Sender: TObject);
var

  XLApp: Variant;
  Sheet: Variant;
  i,j: Integer;
begin
 if eflag=0  then
 begin
  showmessage('û�д������ݣ�');
  exit;
 end;

  if not VarIsEmpty(XLApp) then
  begin
    XLApp.DisplayAlerts := False;
    XLApp.Quit;
    VarClear(XLApp);
  end;
  try
    XLApp := CreateOleObject('Excel.Application');
  except
    Screen.Cursor := crDefault;
    Exit;
  end;
  XLApp.WorkBooks.Add;
  XLApp.SheetsInNewWorkbook := 1;

  XLApp.WorkBooks[1].WorkSheets[1].Name := '��������';
  Sheet := XLApp.Workbooks[1].WorkSheets['��������'];

  for j:=0  to  sg1.ColCount-1  do
   for i:=0  to  sg1.RowCount-1 do
  begin
    if i=0   then
     Sheet.cells[1,j+1]:=sg1.Cells[j,0];


   if sg1.Cells[12,i]='X' then
   Sheet.cells[i+1,j+1]:=sg1.Cells[j,i];

  end;

   XlApp.Visible := True;
end;

procedure TfrmImport4.btn_exitClick(Sender: TObject);
begin
close;
end;

procedure TfrmImport4.btn_OpenFileClick(Sender: TObject);
var
  fileName: string;
begin
 if sg1.rowcount>=2 then
    sg1.rowcount:=1;

 if dlgOpen1.Execute then  fileName:=dlgOpen1.FileName else exit;
  try
  common.load_xls_to_sgrid(fileName,sg1);

  except on e:exception do
 begin
 ShowMessage('����'+e.Message);
 exit;
 end;
end;
end;

procedure TfrmImport4.btn_checkClick(Sender: TObject);
var
  i,j,k ,flag,XFlag: integer;
  DeptID,PostID,tc_ptr,ttype,PMonth:string;
  ssql,s:string;
  fDate : TDateTime;
  Ffloat:Double;
begin
 ISchecked:=0;
 Eflag:=0;

 try
  for i:=1  to sg1.RowCount-1 do
  begin
     XFlag:=0;
   if  sg1.Cells[0,i]<>'' then
   begin
    //1.�жϲ��ţ�
   ssql:='select  rkey  from Datadepartment where departmentName='''+trim(sg1.Cells[1,i])+''' ';
   common.OpenQuery(dm.qry_temp,ssql);
    if  (not dm.qry_temp.IsEmpty)  then
    begin
    DeptID:=dm.qry_temp.fieldbyname('rkey').asstring;
    sg1.Cells[13,i]:=DeptID;
    end
    else
    begin
    sg1.Cells[11,i]:='X';
    sg1.Cells[12,i]:=sg1.Cells[12,i]+'�������Ʋ�����!';
    XFlag:=1;
    end;

   //3.�γ̱�� 
   ssql:=' select rkey from trainclass where  ccode='''+trim(sg1.Cells[2,i])+''' ';
   common.OpenQuery(dm.qry_temp,ssql);
    if  ( dm.qry_temp.IsEmpty)  then
   begin
    sg1.Cells[11,i]:='X';
    sg1.Cells[12,i]:=sg1.Cells[12,i]+'�γ̱�Ų���!';
    XFlag:=1;
   end
   else
   begin
   tc_ptr:= dm.qry_temp.fieldbyname('rkey').asstring;
   sg1.Cells[14,i]:=tc_ptr;
   end;


     //�ж����¸�ʽ 
     if not TryStrToDate(Trim(sg1.cells[3,i]),fDate) then
     begin
     sg1.Cells[11,i]:='X';
     sg1.Cells[12,i]:=sg1.Cells[12,i] + ' ��ʼ���ڸ�ʽ���� ';
     XFlag:=1;
     end;

     if not TryStrToDate(Trim(sg1.cells[5,i]),fDate) then
     begin
     sg1.Cells[11,i]:='X';
     sg1.Cells[12,i]:=sg1.Cells[12,i] + ' �������ڸ�ʽ���� ';
     XFlag:=1;
     end;

     if not TryStrToDateTime(Trim(sg1.cells[4,i]),fDate) then
     begin
     sg1.Cells[11,i]:='X';
     sg1.Cells[12,i]:=sg1.Cells[12,i] + ' ��ʼʱ���ʽ���� ';
     XFlag:=1;
     end;

     if not TryStrToDateTime(Trim(sg1.cells[6,i]),fDate) then
     begin
     sg1.Cells[11,i]:='X';
     sg1.Cells[12,i]:=sg1.Cells[12,i] + ' ����ʱ���ʽ���� ';
     XFlag:=1;
     end;

    //��ѵʱ����
    if not TryStrToFloat(Trim(sg1.cells[9,i]),Ffloat) then      //��ѵ����
    begin
    sg1.Cells[11,i]:='X';
    sg1.Cells[12,i]:=sg1.Cells[12,i-1] + ' ��ѵʱ������ ';
    XFlag:=1;
    end;

//   ssql:=' select rkey  '+
//   ' from trainplan '+
//   ' where  Deptid='+(DeptID)+'   and tc_ptr ='+(tc_ptr)+' and pmonth='''+trim(sg1.Cells[0,i])+''' ';
//   common.OpenQuery(dm.qry_temp,ssql);
//   // showmessage(ssql);
//   if  (not dm.qry_temp.IsEmpty)  then
//   begin
//    sg1.Cells[4,i]:='X';
//    sg1.Cells[5,i]:=sg1.Cells[5,i]+'�·ݡ����źͿγ��ظ�!';
//    XFlag:=1;
//   end;

    if Xflag=0  then
     sg1.Cells[11,i]:='V'
    else
    begin
     Eflag:=1;
     //sg1.Rows[i].font.Color:=clRed;
    end;

    end;
   end;

  ISchecked:=1
 except on e:exception do
 begin
 ShowMessage('����'+e.Message);
 ISchecked:=0;
 exit;
 end;
 end;
end;

procedure TfrmImport4.FormShow(Sender: TObject);
begin
  sg1.ColCount:=15;
  sg1.RowCount:=1 ;
  sg1.Cells[0,0]:='�·�';
  sg1.Cells[1,0]:='����';
  sg1.Cells[2,0]:='�γ̱��';
  sg1.Cells[3,0]:='�ƻ���ʼ����';
  sg1.Cells[4,0]:='�ƻ���ʼʱ��';
  sg1.Cells[5,0]:='�ƻ���������';
  sg1.Cells[6,0]:='�ƻ�����ʱ��';
  sg1.Cells[7,0]:='��ѵ��ʦ';
  sg1.Cells[8,0]:='��ѵ�ص�';
  sg1.Cells[9,0]:='��ѵʱ��';
  sg1.Cells[10,0]:='��ע';
  sg1.Cells[11,0]:='�Ƿ�OK';
  sg1.Cells[12,0]:='����˵��';

  sg1.Cells[13,0]:='Dept_ptr';
  sg1.Cells[14,0]:='tc_ptr';

  sg1.ColWidths[0]:=60;
  sg1.ColWidths[1]:=100;
  sg1.ColWidths[2]:=100;
  sg1.ColWidths[3]:=120;
  sg1.ColWidths[4]:=80;
  sg1.ColWidths[5]:=120;
  sg1.ColWidths[6]:=80;
  sg1.ColWidths[7]:=100;
  sg1.ColWidths[8]:=100;
  sg1.ColWidths[9]:=100;
  sg1.ColWidths[10]:=120;
  sg1.ColWidths[11]:=100;
  sg1.ColWidths[12]:=300;

  sg1.ColWidths[13]:=-1;
  sg1.ColWidths[14]:=-1;
end;

procedure TfrmImport4.btn_importClick(Sender: TObject);
var
i ,j, atype,EmpID,Vcount,Xcount,Xcount2,s: integer;
Lsql,ssql,ssql2 ,YM,memo,THours: string;
//EmployeeId,Deptid, PostID,tc_ptr,MRkey,TType:string;
begin
//
 if sg1.RowCount<2  then
 begin
  ShowMessage('���ȵ�������');
  exit;
 end;

 if ISchecked=0 then
 begin
  showmessage('���ȶ����ݽ��м��!');
   btn_check.setfocus;
  exit;
 end;

 try
   dm.con.BeginTrans;
    if (Eflag=1) and  (MessageDlg('�д���������Ҫ����������ȷ��������',mtInformation,[mbOK,mbCancel],0)= mrcancel) then exit
    else
    begin
       for i:=1 to  sg1.Rowcount-1 do
       begin
       if sg1.Cells[11,i]='V' then
       begin

       Lsql:= 'if exists(select * from tempdb.dbo.sysobjects where id = object_id(N''tempdb..#TPimport'') and type=''U'') '+ #13+
            'drop table #TPimport '+#13+
            'create table #TPimport(Pmonth char(7),TCode nvarchar(20),Dname varchar(20),Bdate datetime ,Btime char(8),EDate datetime ,Etime char(8), '+
            ' teacher nvarchar(50),Place nvarchar(30),THours float, remark varchar(50), Dept_ptr int,tc_ptr int )';
          //  ShowMessage(Lsql);
           dm.execsql(dm.qry_temp,Lsql);

        Lsql:= 'insert into #TPimport values('+ QuotedStr(sg1.Cells[0,i])+','+ QuotedStr(sg1.Cells[1,i])+','+ QuotedStr(sg1.Cells[2,i])+','+
              QuotedStr(sg1.Cells[3,i])+','+ QuotedStr(sg1.Cells[4,i])+','+ QuotedStr(sg1.Cells[5,i])+','+QuotedStr(sg1.Cells[6,i])+','+ QuotedStr(sg1.Cells[7,i])+','+
              QuotedStr(sg1.Cells[8,i])+','+sg1.Cells[9,i]+','+QuotedStr(sg1.Cells[10,i])+', '+sg1.Cells[13,i]+','+sg1.Cells[14,i]+')';
         // ShowMessage(Lsql);
        dm.execsql(dm.qry_temp,Lsql);

        Lsql:='update a set  remark=b.remark,BDate=b.BDate,BTime=b.BTime,Edate=b.EDate,ETime=b.ETime, ' + #13+
              ' teacher=b.teacher,Place=b.place,THours=b.THours,Pdate=getdate() ' + #13+
                'from #TPimport b inner join trainplan a '+#13+
                '  on a.Pmonth=b.Pmonth '+#13+
                '  and a.DeptID=b.Dept_ptr '+#13+
                '  and a.tc_ptr=b.tc_ptr ';
        // ShowMessage(Lsql);
         dm.execsql(dm.qry_temp,Lsql);

       end;
      end;
    end;
  dm.con.CommitTrans;
  showmessage('����ɹ�!');
    frmMain.btn_refresh4Click(sender);
 except on e:exception do
 begin
 ShowMessage('����'+e.Message);
 dm.con.RollbackTrans;
 exit;
 end;
 end;
 

 if eflag=0  then
 begin
 for i:=1 to  sg1.RowCount-1 do
  sg1.Rows[i].Clear;
  sg1.RowCount:=1;
  end
  else
  begin
        s:=0;   //Vcount:=0;   //s:='1'; //
      Xcount:=0;
    for i:=1 to sg1.RowCount-1 do            // sg1.RowCount-1 do
    begin
    if sg1.cells[11,i]='V'  then
    begin
     Vcount:=Vcount+1;
     sg1.Rows[i].Clear;
    end;
      if sg1.cells[11,i]='X'  then
      Xcount:=Xcount+1;
    end;
    
      Xcount2:=0;
    //�ǿ������ƣ�
    for i:=1 to sg1.RowCount-1 do
    begin
     if sg1.cells[0,i]='' then
     for j:=1 to sg1.RowCount-1 do
     begin
      if  (sg1.cells[11,j]='X') and  (Xcount2<=Xcount)  then
       begin
        Xcount2:=Xcount2+1;
        sg1.Rows[i].Text:=sg1.Rows[j].Text;
        sg1.Rows[j].Clear;
         exit;
       end;
     end;
    end;
    // sg1.RowCount:=Xcount+1;

 end;

end;

end.
