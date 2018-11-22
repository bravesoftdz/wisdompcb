unit UImport5;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, Grids, StdCtrls, ExtCtrls, Excel2000,ComObj;

type
  TfrmImport5 = class(TForm)
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
    procedure btn_exitClick(Sender: TObject);
    procedure btn_ExModelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_importClick(Sender: TObject);
    procedure btn_exportErrClick(Sender: TObject);
    procedure btn_OpenFileClick(Sender: TObject);
    procedure btn_checkClick(Sender: TObject);
  private
    { Private declarations }
     ISchecked: integer;
     Eflag: Integer;
       err:Boolean;
  public
    { Public declarations }
  end;

var
  frmImport5: TfrmImport5;

implementation
    uses UDM,common, UMain;
{$R *.dfm}

procedure TfrmImport5.btn_exitClick(Sender: TObject);
begin
  close;
end;

procedure TfrmImport5.btn_ExModelClick(Sender: TObject);
begin
  Export_Grid_to_Excel(sg1,Caption,True);
end;

procedure TfrmImport5.FormShow(Sender: TObject);
begin
  with sg1 do
  begin
    sg1.RowCount:=3;
    Cells[0,0]:='Ա������';
    Cells[1,0]:='��ѵ���';
    Cells[2,0]:='��ѵ����';
    Cells[3,0]:='��ʼ����';
    Cells[4,0]:='��ʼʱ��';
    Cells[5,0]:='��������';
    Cells[6,0]:='����ʱ��';
    Cells[7,0]:='��ѵʱ��(����)';
    Cells[8,0]:='��ѵ��ʦ';
    Cells[9,0]:='��ѵ�ص�';
    Cells[10,0]:='��ѵ�ɼ�';
    Cells[11,0]:='��ѵ���';
    Cells[12,0]:='��ѵ����';
    Cells[13,0]:='����״��(δ���/���)';
    Cells[14,0]:='��ѵ����';
    Cells[15,0]:='��ѵ����';
    Cells[16,0]:='������Ч��';
    Cells[17,0]:='�ؼ���λ';

    Cells[18,0]:='�γ̱��';
    Cells[19,0]:='�γ�����';
    Cells[20,0]:='��ѵ���';
    Cells[21,0]:='��ѵ��ʽ';
    Cells[22,0]:='���˷�ʽ';

    Cells[23,0]:='�Ƿ�OK';  //V�� X ����
    Cells[24,0]:='������Ϣ';


    Cells[0,1]:='10010';
    Cells[1,1]:='2013060001';
    Cells[2,1]:='��ѵר������';
    Cells[3,1]:='2013-10-01';
    Cells[4,1]:='9:30';
    Cells[5,1]:='2013-10-02';
    Cells[6,1]:='10:30';
    Cells[7,1]:='60';
    Cells[8,1]:='����';
    Cells[9,1]:='��¥������';
    Cells[10,1]:='98';
    Cells[11,1]:='�ϸ�';
    Cells[12,1]:='��ѵ����';
    Cells[13,1]:='���';
    Cells[14,1]:='ר��';
    Cells[15,1]:='100';
    Cells[16,1]:='2014-10-01';
    Cells[17,1]:='����ƬԱ';

    Cells[18,1]:='��ݸ������';
    Cells[19,1]:='��ݸ������';

    Cells[20,1]:='��ݸ������';
    Cells[21,1]:='��ݸ������';
    Cells[22,1]:='��ݸ������';
 end;

end;

procedure TfrmImport5.btn_importClick(Sender: TObject);
var
i ,j, atype,EmpID,Vcount,Xcount,Xcount2,s,TStatus: integer;
Lsql,Lsql2 : string;
daystr,Key:string;
begin

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
    if (Eflag=1) and  (MessageDlg('�д���������Ҫ����������ȷ��������',mtInformation,[mbOK,mbCancel],0)= mrcancel) then exit

    else
    begin
     for i:=1 to  sg1.Rowcount-1 do
     begin
     if sg1.Cells[23,i]='V' then
      begin
       if  sg1.Cells[13,i]='�����'  then
         TStatus :=1
       else   TStatus :=0;
       
        Lsql:= 'if exists(select * from tempdb.dbo.sysobjects where id = object_id(N''tempdb..#trainimport'') and type=''U'') '+ #13+
            'drop table #trainimport '+#13+
            'create table #trainimport(employeeid int,employeecode nvarchar(20),train_no varchar(50),train_topics nvarchar(50), '+
            ' startdate datetime,starttime varchar(20),enddate datetime,endtime varchar(20),train_time float, '+
            ' teacher nvarchar(50),train_place nvarchar(30),train_grade nvarchar(20),train_result nvarchar(20), '+
            ' train_content nvarchar(200),train_status int,train_feels money,effective_date datetime,oprator_ptr int, '+
            ' oprate_time datetime,traintype nvarchar(20),typeid int,feels_payed bit,ptr_flag bit,dbflag bit,deptid int,keyid int,KeyPosition varchar(40), '+
            'ccode varchar(20),cname varchar(30),tc_ptr int,Ctype varchar(10),Ttype varchar(10),Etype varchar(10), CtypeiD int, TTYpeID int,ETYpeid int,postID int)';
      dm.execsql(dm.qry_temp,Lsql);

      Lsql:= 'insert into #trainimport values(0,'+ QuotedStr(sg1.Cells[0,i])+','+ QuotedStr(sg1.Cells[1,i])+','+ QuotedStr(sg1.Cells[2,i])+','+
              QuotedStr(sg1.Cells[3,i])+','+ QuotedStr(sg1.Cells[4,i])+','+ QuotedStr(sg1.Cells[5,i])+','+QuotedStr(sg1.Cells[6,i])+','+ sg1.Cells[7,i]+','+
              QuotedStr(sg1.Cells[8,i])+','+QuotedStr(sg1.Cells[9,i])+','+QuotedStr(sg1.Cells[10,i])+','+ QuotedStr(sg1.Cells[11,i])+','+
              QuotedStr(sg1.Cells[12,i])+','+inttostr(TStatus)+','+ sg1.Cells[15,i]+','+ QuotedStr(sg1.Cells[16,i]) +','+ user_ptr+','+
              QuotedStr(FormatDateTime('yyyy-MM-dd',getsystem_date(DM.qry_temp,1)))+','+QuotedStr(sg1.Cells[14,i])+',0,0,0,0,0,null,' +
              QuotedStr(sg1.Cells[17,i])+','+QuotedStr(sg1.Cells[18,i])+','+QuotedStr(sg1.Cells[19,i])+ ',0,'+QuotedStr(sg1.Cells[20,i])+ ','+QuotedStr(sg1.Cells[21,i])+ ' '+
              ','+QuotedStr(sg1.Cells[22,i])+ ',-1,-1,-1,-1)';
      dm.execsql(dm.qry_temp,Lsql);

      Lsql:='update #trainimport set employeeid = employeemsg.rkey,typeid = datadetail.rkey,deptid = employeemsg.departmentid,postid=employeemsg.position ,tc_ptr=isnull(trainclass.rkey,0) ' + #13+
                ' ,keyid = isnull(hr_KeyPosition.rkey,0)'+#13+
                ',CtypeID=(case when #trainimport.ctype=''��ְ��ѵ''  then 0  when #trainimport.ctype=''��ǰ��ѵ''  then 1 when #trainimport.ctype=''�ڸ���ѵ''  then 2 else -1 end )'+  #13+
                ',TtypeID=(case when #trainimport.ttype=''��������''  then 0  when #trainimport.Ttype=''ʵ����ѵ''  then 1 when #trainimport.Ttype=''������ѵ''  then 2 else -1 end )'+  #13+
                ',EtypeID=(case when #trainimport.Etype=''���Կ���''  then 0  when #trainimport.Etype=''���Կ���''  then 1 when #trainimport.Etype=''ʵ�ٿ���''  then 2 when #trainimport.Etype=''���߿���''  then 3 else -1 end )'+  #13+
                'from #trainimport  '+  #13+
                ' inner join employeemsg on #trainimport.employeecode=employeemsg.employeecode '+  #13+
                'inner join datadetail on #trainimport.traintype=datadetail.item '+#13+
                'left join trainclass  on #trainimport.ccode=trainclass.ccode   '+#13+
                'left join hr_KeyPosition on #trainimport.deptid = hr_KeyPosition.deptid and #trainimport.KeyPosition = hr_KeyPosition.positionname ';
               dm.execsql(dm.qry_temp,Lsql);

         LSql:=  'select * from #trainimport';
         dm.openqry(dm.qry_temp,Lsql);

       Lsql:='select rkey,employeeid,Train_no from employee_train where employeeid ='+
                DM.qry_temp.FieldByName('employeeid').AsString +' and tc_ptr = '+ DM.qry_temp.FieldByName('tc_ptr').AsString +
                ' and Deptid='+DM.qry_temp.FieldByName('DeptID').AsString+' and postID='+DM.qry_temp.FieldByName('POstID').AsString+' '+
                ' and convert(char(7),startdate,120)='''+formatdatetime('yyyy-MM',DM.qry_temp.FieldByName('startdate').AsDateTime)+''' ';
               // ShowMessage(Lsql);
        dm.openqry(dm.qry_temp,Lsql);
        if dm.qry_temp.IsEmpty then
        begin
         Lsql:='insert into employee_train(employeeid, Train_NO, Train_topics, startdate, starttime, enddate, endtime, Train_time, Teacher, ' +
                  'Train_place, Train_grade, Train_result, Train_content, Train_status, ptr_flag, type_ptr, train_feels, effective_date, ' +
                  'feels_payed, oprator_ptr, oprate_time, employeecode,KeyPositionId,tc_ptr,DeptID,Ctype,TType,ETYpe,postID)'+#13+
                  'select employeeid,train_no,train_topics,startdate,starttime,enddate,endtime,train_time,teacher,train_place,train_grade, '+
                  'train_result,train_content,train_status,ptr_flag,typeid,train_feels,effective_date,feels_payed,oprator_ptr,oprate_time,employeecode,keyid,tc_ptr,DeptID '+ #13+
                  ',CtypeID,TTypeID,ETYpeID,postid'+ #13+
                  'from #trainimport where (employeeid <>0 and typeid <>0 ) ';  //and dbflag=0
        dm.execsql(DM.qry_temp,Lsql);
        end;
//        else
//        begin
//         Lsql:='update  Employee_Train set score='+floattostr(Lfrm.FAScore)+',Train_result='''+LResult+''' '  +
//         ' where employeeid='+qry66.fieldbyname('rkey').AsString+' and tc_ptr='+qry66.fieldbyname('tc_ptr').AsString+
//         ' DeptID='+qry66.fieldbyname('departmentid').AsString+',PostID= '+qry66.fieldbyname('position').AsString+
//         ' and convert(char(7),startdate,120)=''convert(char(7),getdate(),120)'' ';
//            dm.execsql(DM.qry_temp,Lsql);
//        end;
      end;
     end;
    end;

 except on e:exception do
 begin
 ShowMessage('����'+e.Message);
 exit;
 end;
 end;
 showmessage('����ɹ�!');
 
  
   
 if eflag=0  then
 begin
 for i:=1 to  sg1.RowCount-1 do
  sg1.Rows[i].Clear;
  sg1.RowCount:=1;
  end
  else
  begin
     s:=0;
      Xcount:=0;
    for i:=1 to sg1.RowCount-1 do          
    begin
    if sg1.cells[6,i]='V'  then
    begin
     Vcount:=Vcount+1;
     sg1.Rows[i].Clear;
    end;
      if sg1.cells[6,i]='X'  then
      Xcount:=Xcount+1;
    end;
    
      Xcount2:=0;
    //�ǿ������ƣ�
    for i:=1 to sg1.RowCount-1 do
    begin
     if sg1.cells[0,i]='' then
     for j:=1 to sg1.RowCount-1 do
     begin
      if  (sg1.cells[6,j]='X') and  (Xcount2<=Xcount)  then
       begin
        Xcount2:=Xcount2+1;
        sg1.Rows[i].Text:=sg1.Rows[j].Text;
        sg1.Rows[j].Clear;
         exit;
       end;
     end;
    end;


 end;
end;

procedure TfrmImport5.btn_exportErrClick(Sender: TObject);
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


   if sg1.Cells[6,i]='X' then
   Sheet.cells[i+1,j+1]:=sg1.Cells[j,i];

  end;





   XlApp.Visible := True;
end;

procedure TfrmImport5.btn_OpenFileClick(Sender: TObject);
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

procedure TfrmImport5.btn_checkClick(Sender: TObject);
var
  i,j,k ,flag,XFlag:Integer;
  Lsql,s:string;
   checkDate:TDateTime;
   checkfloat:Double;
begin
//
 ISchecked:=0;
 Eflag:=0;
 XFlag:=0;
 sg1.ColCount:=sg1.ColCount+2;
 sg1.Cells[23,0]:='�Ƿ�OK';
 sg1.Cells[24,0]:='ԭ��';
 sg1.ColWidths[23]:=40;
 sg1.ColWidths[24]:=800;
 try
  for i:=1  to sg1.RowCount-1 do
  begin
   if  sg1.Cells[0,i]<>'' then
   begin
      //�жϹ��ź������ܷ���ϻ���ϵͳ���ܲ����ҵ�
     Lsql:=' select employeecode from employeemsg where employeecode='''+trim(sg1.Cells[0,i])+'''   ';
     dm.OpenQry(DM.qry_temp,Lsql);
     if  (dm.qry_temp.IsEmpty) or (sg1.Cells[0,i]='')  then
     begin
      sg1.Cells[23,i]:='X';
      sg1.Cells[24,i]:=sg1.Cells[7,i]+'���Ų�����!';
      XFlag:=1;
     end;

     //�ж����¸�ʽ�Ƿ���ȷ��
     if not TryStrToDate(Trim(sg1.cells[3,i]),checkDate) then
     begin
     sg1.Cells[23,i]:='X';
     sg1.Cells[24,i]:=sg1.Cells[24,i] + ' ��ʼ���ڸ�ʽ���� ';
     XFlag:=1;
     end;
     if not TryStrToDateTime(Trim(sg1.cells[4,i]),checkDate) then
     begin
     sg1.Cells[23,i]:='X';
     sg1.Cells[24,i]:=sg1.Cells[24,i] + ' ��ʼʱ���ʽ���� ';
     XFlag:=1;
     end;
     if not TryStrToDate(Trim(sg1.cells[5,i]),checkDate) then
     begin
     sg1.Cells[23,i]:='X';
     sg1.Cells[24,i]:=sg1.Cells[24,i] + ' �������ڸ�ʽ���� ';
     XFlag:=1;
     end;
     if not TryStrToDateTime(Trim(sg1.cells[6,i]),checkDate) then
     begin
     sg1.Cells[23,i]:='X';
     sg1.Cells[24,i]:=sg1.Cells[24,i] + ' ����ʱ���ʽ���� ';
     XFlag:=1;
     end;

     if (sg1.Cells[13,i]<>'�����') and  (sg1.Cells[13,i]<>'δ���') then
     begin
     sg1.Cells[23,i]:='X';
     sg1.Cells[24,i]:=sg1.Cells[24,i] + ' ���״���������� ';
     XFlag:=1;
     end;

     //��ѵ���ã�
      if not TryStrToFloat(Trim(sg1.cells[15,i]),checkfloat) then      //��ѵ����
      begin
      sg1.Cells[23,i]:='X';
      sg1.Cells[24,i]:=sg1.Cells[24,i-1] + ' ��ѵ�������� ';
      XFlag:=1;
      end;

     Lsql:=' select rkey from trainclass where  ccode='''+trim(sg1.Cells[18,i])+''' and cName='''+trim(sg1.Cells[19,i])+'''  ';
     common.OpenQuery(dm.qry_temp,Lsql);
      if  ( dm.qry_temp.IsEmpty)  then
     begin
      sg1.Cells[23,i]:='X';
      sg1.Cells[24,i]:=sg1.Cells[24,i]+'�γ̱�Ż��߿γ����Ʋ���!';
      XFlag:=1;
     end ;


   //���
    if (trim(sg1.Cells[20,i])<>'��ְ��ѵ')  and  (trim(sg1.Cells[20,i])<>'��ǰ��ѵ')  and   (trim(sg1.Cells[20,i])<>'�ڸ���ѵ') then
    begin
    sg1.Cells[23,i]:='X';
    sg1.Cells[24,i]:=sg1.Cells[24,i]+'�γ���𲻶�!';
    XFlag:=1;
    end;

    //��ѵ��ʽ
    if (trim(sg1.Cells[21,i])<>'��������')  and (trim(sg1.Cells[21,i])<>'ʵ����ѵ')  and  (trim(sg1.Cells[21,i])<>'������ѵ') then
    begin
    sg1.Cells[23,i]:='X';
    sg1.Cells[24,i]:=sg1.Cells[24,i]+'��ѵ��ʽ����!';
    XFlag:=1;
    end;

    //���˷�ʽ
    if (trim(sg1.Cells[22,i])<>'���Կ���')  and (trim(sg1.Cells[22,i])<>'���Կ���')  and  (trim(sg1.Cells[22,i])<>'ʵ�ٿ���')  and  (trim(sg1.Cells[22,i])<>'���߿���')  then
    begin
    sg1.Cells[23,i]:='X';
    sg1.Cells[24,i]:=sg1.Cells[24,i]+'���˷�ʽ����!';
    XFlag:=1;
    end;

   ////////////////////////////////////////////////////////////
    if Xflag=0  then
     sg1.Cells[23,i]:='V'
    else
    begin
     Eflag:=1;
     //sg1.Rows[i].c.Color:=clRed;
    end;

    end;
   end;
  ISchecked:=1 
 except on e:exception do
 begin
 ShowMessage('����'+e.Message);
 exit;
 end;
 end;

end;

end.
