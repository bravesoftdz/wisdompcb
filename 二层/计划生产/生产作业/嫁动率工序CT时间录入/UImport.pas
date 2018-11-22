unit UImport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, ExtCtrls,Excel2000,ComObj;

type
  TFrmImport = class(TForm)
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
    procedure btn_ExModelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_OpenFileClick(Sender: TObject);
    procedure btn_exitClick(Sender: TObject);
    procedure btn_checkClick(Sender: TObject);
    procedure btn_exportErrClick(Sender: TObject);
    procedure btn_importClick(Sender: TObject);
  private
    { Private declarations }
    ISchecked: integer;
    Eflag,IFlag: Integer;
  public
    { Public declarations }
  end;

var
  FrmImport: TFrmImport;

implementation
        uses common, UDM, UTimeDetail;
{$R *.dfm}

procedure TFrmImport.btn_ExModelClick(Sender: TObject);
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

 Sheet.Cells[1,1]:='�޶�������';
 Sheet.Cells[1,2]:='�������';
 Sheet.Cells[1,3]:='����';
 Sheet.Cells[1,4]:='��̨';
 Sheet.Cells[1,5]:='������';
 Sheet.Cells[1,6]:='��������';
 Sheet.Cells[1,7]:='������';
 Sheet.Cells[1,8]:='����CTʱ��';
 Sheet.Cells[1,9]:='ʵ��CTʱ��(����S��CTʱ��)';
 Sheet.Cells[1,10]:='����C��CTʱ��';
 Sheet.Cells[1,11]:='ά����';
 Sheet.Cells[1,12]:='ά��ʱ��';




   XlApp.Visible := True;

end;

procedure TFrmImport.FormShow(Sender: TObject);
begin
sg1.ColCount:=12;
 sg1.RowCount:=1 ;
 sg1.Cells[0,0]:='�޶�������';
 sg1.Cells[1,0]:='�������';
 sg1.Cells[2,0]:='����';
 sg1.Cells[3,0]:='��̨';
 sg1.Cells[4,0]:='������';
 sg1.Cells[5,0]:='��������';
 sg1.Cells[6,0]:='������';
 sg1.Cells[7,0]:='����CTʱ��';
 sg1.Cells[8,0]:='ʵ��CTʱ��(����S��CTʱ��)';
 sg1.Cells[9,0]:='����C��CTʱ��';
 sg1.Cells[10,0]:='ά����';
 sg1.Cells[11,0]:='ά��ʱ��';

  sg1.ColWidths[0]:=120;
  sg1.ColWidths[1]:=100;
  sg1.ColWidths[2]:=60;
  sg1.ColWidths[3]:=50;
  sg1.ColWidths[4]:=50;
  sg1.ColWidths[5]:=100;
  sg1.ColWidths[6]:=60;
  sg1.ColWidths[7]:=100;
  sg1.ColWidths[8]:=150;
  sg1.ColWidths[9]:=100;
  sg1.ColWidths[10]:=80;
  sg1.ColWidths[11]:=100;







end;

procedure TFrmImport.btn_OpenFileClick(Sender: TObject);
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

procedure TFrmImport.btn_exitClick(Sender: TObject);
begin
close;
end;

procedure TFrmImport.btn_checkClick(Sender: TObject);
var
  i,j,k ,flag,XFlag:Integer;
  ssql,s,sr:string;
begin
//
 ISchecked:=0;
 Eflag:=0; 

 sg1.ColCount:=sg1.ColCount+2;
 sg1.Cells[12,0]:='�Ƿ�OK';
 sg1.Cells[13,0]:='ԭ��';
 sg1.ColWidths[12]:=40;
 sg1.ColWidths[13]:=800;
 try
  for i:=1  to sg1.RowCount-1 do
  begin
     XFlag:=0;
   if  sg1.Cells[0,i]<>'' then
   begin 
    //�жϼ޶������ͣ�
   ssql:=' select Cname from data0578 where cname='''+trim(sg1.Cells[0,i])+'''   ';
   dm.OpenQry(DM.qry_temp,ssql);
   if  (dm.qry_temp.IsEmpty) or (sg1.Cells[0,i]='')  then
   begin
    sg1.Cells[12,i]:='X';
    sg1.Cells[13,i]:=sg1.Cells[13,i]+'�޶������ͺ�ϵͳ���治ƥ��!';
    XFlag:=1;
   end;

      //��������жϣ�
      if  trim(sg1.Cells[2,i])='' then
      sr:='0'
      else
      sr:=trim(sg1.Cells[2,i]);

   ssql:=' select manu_part_number from data0025 where manu_part_number='''+trim(sg1.Cells[1,i])+'''     ';       //and layers='+sr+'
   dm.OpenQry(DM.qry_temp,ssql);
   if  (dm.qry_temp.IsEmpty) or (sg1.Cells[1,i]='')  then // or (sg1.Cells[2,i]='')
    begin 
    sg1.Cells[12,i]:='X';
    sg1.Cells[13,i]:=sg1.Cells[13,i]+'���������ϵͳ���治ƥ��!';
    XFlag:=1;
   end;

       //��̨�жϣ�
   ssql:=' select mname from data0580 where mname='''+trim(sg1.Cells[3,i])+'''    ';
   dm.OpenQry(DM.qry_temp,ssql);
   if  ((not dm.qry_temp.IsEmpty) and (sg1.Cells[0,i]<>'����޶���') ) or ((dm.qry_temp.IsEmpty) and (sg1.Cells[0,i]='����޶���') )    then   //
   begin
    sg1.Cells[12,i]:='X';
    sg1.Cells[13,i]:=sg1.Cells[13,i]+'��̨��ϵͳ���治ƥ��!';
    XFlag:=1;
   end;

     //�����жϣ�
   ssql:=' select dept_name from data0034 where dept_code='''+trim(sg1.Cells[4,i])+'''    ';
   dm.OpenQry(DM.qry_temp,ssql);
   if  (dm.qry_temp.IsEmpty) or (sg1.Cells[4,i]='')  then
   begin
    sg1.Cells[12,i]:='X';
    sg1.Cells[13,i]:=sg1.Cells[13,i]+'������ϵͳ���治ƥ��!';
    XFlag:=1;
   end;

    if Xflag=0  then
    sg1.Cells[12,i]:='V'
    else
    begin
    Eflag:=1;

    end;
   end;
  end;
  ISchecked:=1;
  
 except on e:exception do
 begin
 ShowMessage('����'+e.Message);
 exit;
 end;
 end;
end;

procedure TFrmImport.btn_exportErrClick(Sender: TObject);
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

procedure TFrmImport.btn_importClick(Sender: TObject);
var
i ,j,s,Xcount,Vcount,Xcount2: integer;
ssql,ssql2, prodno,pid,cid,ct1,ct2,ct3,stackNum: string;
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

 IFlag:=0;
  try
   dm.con1.BeginTrans;

    if (Eflag=1) and  (MessageDlg('�д������ݣ���Ҫ����������ȷ��������',mtInformation,[mbOK,mbCancel],0)= mrcancel) then exit

    else
    begin
       for i:=1 to  sg1.Rowcount-1 do
       begin
       if sg1.Cells[12,i]='V' then
        begin
        //�޶�������
        ssql:=' select rkey from data0578 where cname='''+sg1.Cells[0,i]+''' ';
        cid:=dm.GetOne('rkey',ssql,dm.qry_temp);
         //�������
        ssql:=' select rkey from data0025 where manu_part_number='''+sg1.Cells[1,i]+''' ';
        ProdNo:=dm.GetOne('rkey',ssql,dm.qry_temp);
          //����
        ssql:=' select rkey from data0034 where dept_code='''+sg1.Cells[4,i]+''' ';
        pid:=dm.GetOne('rkey',ssql,dm.qry_temp);




        ssql2:='select rkey from  data0581 where cid='+cID+' and Prodno='+prodno+' and machine='''+sg1.Cells[3,i]+''' and pid='+pID+'  ';
         dm.openqry(DM.qry_temp,ssql2);

            if sg1.Cells[7,i]<>'' then
            ct1:=sg1.Cells[7,i]
            else
            ct1:='0';

             if sg1.Cells[8,i]<>'' then
            ct2:=sg1.Cells[8,i]
            else
            ct2:='0';

            if sg1.Cells[9,i]<>'' then
            ct3:=sg1.Cells[9,i]
            else
            ct3:='0';
            
             if sg1.Cells[6,i]<>'' then
            stackNum:=sg1.Cells[6,i]
            else
            stackNum:='0';


         if not DM.qry_temp.isempty then
         begin
         ssql:= 'update  data0581  set  TCTTime1='+ct1+',CTTime1='+ct2+',CTTime2='+ct3+' '+
            ' where  Cid='+CID+' and prodno='+prodno+'   and machine='''+sg1.Cells[3,i]+''' and pid='+PID+'  ' ;
              dm.execsql(DM.qry_temp,ssql);
         IFlag:=1;
         end
         else
         begin
          ssql:=' insert into data0581(cid, prodno,layer,machine,PID,stackNum,TCTTime1,CTTime1,CTTime2,Aman,ADate)'+
               'values( '+CID+' , '+prodno+' ,'''+sg1.Cells[2,i]+'''  , '''+sg1.Cells[3,i]+''' , '+PID+', '+
               ' '+stackNum+','+ct1+','+ct2+','+ct3+','+rkey73+',getdate() )';

         dm.execsql(DM.qry_temp,ssql);
         IFlag:=1;
         end;
        end;
      end;
      end;



    dm.con1.CommitTrans;
    if IFlag=1  then 
     showmessage('����ɹ�!');
     
  except on e:exception do
  begin
  ShowMessage('����'+e.Message+'----:'+ssql);
  dm.con1.RollbackTrans;
  exit;
  end;
  end;

 
   FrmTimeDetail.btn_refreshClick(sender);
   
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
    if sg1.cells[12,i]='V'  then
    begin
     Vcount:=Vcount+1;
     sg1.Rows[i].Clear;
    end;
      if sg1.cells[12,i]='X'  then
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
   // sg1.RowCount:=Xcount+1;




 end;
end;

end.
