unit UImport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, ExtCtrls,OleServer, Excel2000,ComObj;

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
    lbl1: TLabel;
    procedure btn_exitClick(Sender: TObject);
    procedure btn_ExModelClick(Sender: TObject);
    procedure btn_OpenFileClick(Sender: TObject);
    procedure btn_exportErrClick(Sender: TObject);
    procedure btn_checkClick(Sender: TObject);
    procedure btn_importClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    lst,lst2:  TStringList;
    procedure load_xls_to_sgrid(fileName:String; grid:TStringGrid);
  public
    { Public declarations }
  end;

var
  FrmImport: TFrmImport;

implementation

uses UDM,common, UMain;

{$R *.dfm}

procedure TFrmImport.btn_exitClick(Sender: TObject);
begin
close;
end;

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

 Sheet.Cells[1,1]:='��׼����';
 Sheet.Cells[1,2]:='�ɱ�����';
 Sheet.Cells[1,3]:='���ϱ��';
 Sheet.Cells[1,4]:='�빺��λ����';
 Sheet.Cells[1,5]:='���õ�λ����';
 Sheet.Cells[1,6]:='ת����';
 Sheet.Cells[1,7]:='���Ϲ���';
 Sheet.Cells[1,8]:='����1';
 Sheet.Cells[1,9]:='����2';
 Sheet.Cells[1,10]:='����3';
 Sheet.Cells[1,11]:='����4';
 Sheet.Cells[1,12]:='������Ƶ��';

  Sheet.Cells[1,13]:='���챣��һ��';
 Sheet.Cells[1,14]:='����һ�κ�����';
 Sheet.Cells[1,15]:='��Ա������';
 Sheet.Cells[1,16]:='Ա������/��';
 Sheet.Cells[1,17]:='ÿ��ÿ��ʹ������';
 Sheet.Cells[1,18]:='���չ̶�ʱ��';
 Sheet.Cells[1,19]:='ÿ���ü���';
 Sheet.Cells[1,20]:='ÿ���ö���';
 Sheet.Cells[1,21]:='����������';
 Sheet.Cells[1,22]:='������/ƽ��';
 Sheet.Cells[1,23]:='��Ӧ�������';
 Sheet.Cells[1,24]:='��������';

  Sheet.Cells[1,25]:='���ص�λ����';
 Sheet.Cells[1,26]:='������λ����';
 Sheet.Cells[1,27]:='��ע';
 Sheet.Cells[1,28]:='��������';
 Sheet.Cells[1,29]:='����Ƶ������';
 Sheet.Cells[1,30]:='����ʽ';
 Sheet.Cells[1,31]:='��ʽ����';





   XlApp.Visible := True;


end;

procedure TFrmImport.btn_OpenFileClick(Sender: TObject);
var
  fileName: string;
begin
 if sg1.rowcount>=2 then
    sg1.rowcount:=1;

 if dlgOpen1.Execute then  fileName:=dlgOpen1.FileName else exit;
  try
  load_xls_to_sgrid(fileName,sg1);

  except on e:exception do
 begin
 ShowMessage('����'+e.Message);
 exit;
 end;
end;


end;

procedure TFrmImport.load_xls_to_sgrid(fileName:String; grid:TStringGrid);
var //��Excel�ж�ȡ���ݵ� Grid
  iCount, jCount: Integer;
  XLApp: variant;
  Sheet: Variant;
begin
  Screen.Cursor := crHourGlass;
  if not VarIsEmpty(XLApp) then
   begin
    XLApp.DisplayAlerts := False;
    XLApp.Quit;
    VarClear(XLApp);
   end;
  try
   XLApp := CreateOleObject('Excel.Application'); //����OLE����
  except
   Screen.Cursor := crDefault;
   Exit;
  end;
   try
     XLApp.workBooks.Open(fileName);
     Sheet := XLApp.Workbooks[1].WorkSheets[1];
     for iCount:=2 to 65535 do
      begin
       if trim(XLApp.workbooks[1].sheets[1].cells[iCount,1]) = '' then
         break
       else
        begin
         grid.RowCount:=grid.RowCount+1;
        for jCount:=1 to 31 do
   //    grid.Cells[jCount-1,iCount-1]:=XLApp.workbooks[1].sheets[1].cells[iCount,jCount];
         grid.Cells[jCount-1,iCount-1]:=sheet.cells[iCount,jCount];
        end;
      end;
     XLApp.workbooks[1].close;
   finally
     XLApp.quit;
     Screen.Cursor := crDefault;
   end
end;


procedure TFrmImport.btn_exportErrClick(Sender: TObject);
var

  XLApp: Variant;
  Sheet: Variant;
  i,j: Integer;
begin
 if dm.eflag=0  then
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


   if sg1.Cells[31,i]='X' then
   Sheet.cells[i+1,j+1]:=sg1.Cells[j,i];

  end;





   XlApp.Visible := True;

end;

procedure TFrmImport.btn_checkClick(Sender: TObject);
var
  i,j,k ,l,l2,flag,XFlag,ISchecked:Integer;
  ssql,s,sr,str:string;
  //lst,lst2: TStringList;
begin
//
 ISchecked:=0;
 dm.Eflag:=0; 

 sg1.ColCount:=sg1.ColCount+2;
 sg1.Cells[31,0]:='�Ƿ�OK';
 sg1.Cells[32,0]:='ԭ��';
 sg1.ColWidths[31]:=40;
 sg1.ColWidths[32]:=800;
 try
    for i:=1  to sg1.RowCount-1 do
    begin
         XFlag:=0;
       if  sg1.Cells[0,i]='' then
        begin
        sg1.Cells[31,i]:='X';
        sg1.Cells[32,i]:=sg1.Cells[32,i]+'��׼���벻��Ϊ��!';
        XFlag:=1;
        end;


        //�жϳɱ����ģ�
       ssql:=' select rkey from data0034 where dept_code='''+trim(sg1.Cells[1,i])+'''   ';
       dm.OpenQry(DM.qry_temp,ssql);
       if  (dm.qry_temp.IsEmpty) or (sg1.Cells[1,i]='')  then
       begin
        sg1.Cells[31,i]:='X';
        sg1.Cells[32,i]:=sg1.Cells[32,i]+'�ɱ����ĺ�ϵͳ���治ƥ��!';
        XFlag:=1;
       end;

          //���Ϲ��������жϣ�
       ssql:=' select rkey from data0496 where group_desc='''+trim(sg1.Cells[6,i])+'''   ';
       dm.OpenQry(DM.qry_temp,ssql);
       if  (dm.qry_temp.IsEmpty) or (sg1.Cells[1,i]='')  then
       begin
        sg1.Cells[31,i]:='X';
        sg1.Cells[32,i]:=sg1.Cells[32,i]+'�ɱ����ĺ�ϵͳ���治ƥ��!';
        XFlag:=1;
       end;


       //���ϱ����жϣ�
        str:=trim(sg1.Cells[2,i]);
        if  (Pos('��',str)>0) or (str='') then
        begin
         sg1.Cells[31,i]:='X';
         sg1.Cells[32,i]:=sg1.Cells[32,i]+'�в��ϱ������涺�Ų��Ի��߲��ϱ���Ϊ�գ���˶Ժ��ٵ���!';
         XFlag:=1;
        end;

        if str<>'' then
        begin
         lst:=TStringList.Create;
         lst.CommaText:= str;
         for l:=0 to lst.Count-1 do
         begin
          ssql:=' select rkey from data0017 where inv_part_number='''+lst[l]+'''   ';
          dm.OpenQry(DM.qry_temp,ssql);
          if  (dm.qry_temp.IsEmpty) then
          begin
          sg1.Cells[31,i]:='X';
          sg1.Cells[32,i]:=sg1.Cells[32,i]+'���ϱ���'''+lst[l]+'''��ϵͳ���治ƥ��!';
          XFlag:=1;
          end;

         end;
        end;

          //��������жϣ�
        str:=trim(sg1.Cells[22,i]);
        if  (Pos('��',str)>0) or (str='') then
        begin
         sg1.Cells[31,i]:='X';
         sg1.Cells[32,i]:=sg1.Cells[32,i]+'�й���������涺�Ų��Ի��߹������Ϊ�գ���˶Ժ��ٵ���!';
         XFlag:=1;
        end;

        if str<>'' then
        begin
         lst2:=TStringList.Create;
         lst2.CommaText:= str;
         for l2:=0 to lst2.count-1 do
         begin
          ssql:=' select rkey from data0034 where dept_code='''+lst2[l2]+'''   ';
          dm.OpenQry(DM.qry_temp,ssql);
          if  (dm.qry_temp.IsEmpty) then
          begin
          sg1.Cells[31,i]:='X';
          sg1.Cells[32,i]:=sg1.Cells[32,i]+'�������'''+lst2[l2]+'''��ϵͳ���治ƥ��!';
          XFlag:=1;
          end;

         end;
        end;


      //�빺��λ��
        ssql:=' select rkey from data0002 where unit_name='''+trim(sg1.Cells[3,i])+'''   ';

     dm.OpenQry(DM.qry_temp,ssql);
     if  (dm.qry_temp.IsEmpty)  and (trim(sg1.Cells[3,i])<>'')   then
     begin
      sg1.Cells[31,i]:='X';
      sg1.Cells[32,i]:=sg1.Cells[32,i]+'�빺��λ��ϵͳ���治ƥ��!';
      XFlag:=1;
     end;
       //���õ�λ�ж�
      ssql:=' select rkey from data0002 where unit_name='''+trim(sg1.Cells[4,i])+'''   ';

     dm.OpenQry(DM.qry_temp,ssql);
     if  (dm.qry_temp.IsEmpty)  and (trim(sg1.Cells[4,i])<>'')   then
     begin
      sg1.Cells[31,i]:='X';
      sg1.Cells[32,i]:=sg1.Cells[32,i]+'���õ�λ��ϵͳ���治ƥ��!';
      XFlag:=1;
     end;

          //���ص�λ�ж�
      ssql:=' select rkey from data0002 where unit_name='''+trim(sg1.Cells[24,i])+'''   ';

     dm.OpenQry(DM.qry_temp,ssql);
     if  (dm.qry_temp.IsEmpty) and (trim(sg1.Cells[24,i])<>'')    then
     begin
      sg1.Cells[31,i]:='X';
      sg1.Cells[32,i]:=sg1.Cells[32,i]+'���ص�λ��ϵͳ���治ƥ��!';
      XFlag:=1;
     end;

      //������λ�ж�
      ssql:=' select rkey from data0002 where unit_name='''+trim(sg1.Cells[25,i])+'''   ';
     dm.OpenQry(DM.qry_temp,ssql);
     if  (dm.qry_temp.IsEmpty)  and (trim(sg1.Cells[25,i])<>'')  then
     begin
      sg1.Cells[31,i]:='X';
      sg1.Cells[32,i]:=sg1.Cells[32,i]+'������λ��ϵͳ���治ƥ��!';
      XFlag:=1;
     end;

    //����
      ssql:=' select rkey from data0015 where warehouse_code='''+trim(sg1.Cells[27,i])+'''   ';
     dm.OpenQry(DM.qry_temp,ssql);
     if  (dm.qry_temp.IsEmpty) or (sg1.Cells[27,i]='')  then
     begin
      sg1.Cells[31,i]:='X';
      sg1.Cells[32,i]:=sg1.Cells[32,i]+'�������ź�ϵͳ���治ƥ��!';
      XFlag:=1;
     end;


      if Xflag=0  then
      sg1.Cells[31,i]:='V'
      else
      DM.Eflag:=1;


    end;
   ISchecked:=1;
   showmessage('������!');
 except on e:exception do
 begin
 ShowMessage('����'+e.Message);
 exit;
 end;
 end;

end;

procedure TFrmImport.btn_importClick(Sender: TObject);
var
i ,j,s,Xcount,Vcount,Xcount2,m,n,ISchecked,IFlag,eflag: integer;
ssql,ssql2, prodno,pid,ppid,PurUnit,UseUnit,FacUnit,OUnit,MType ,FacUse,FacDay,IsFormula  :string;
isMcount,IsFreq,IsTime,IsFac,FDays,FUse ,MCount ,Muse ,TCount ,TUse ,wh,control_ptr,str,str2 :string;
lst, lst2: TStringList ;
 Formula:Variant;
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
  if not dm.con1.InTransaction then  dm.con1.BeginTrans;

    if (dm.Eflag=1) and  (MessageDlg('�д������ݣ���Ҫ����������ȷ��������',mtInformation,[mbOK,mbCancel],0)= mrcancel) then exit

    else
    begin
       for i:=1 to  sg1.Rowcount-1 do
       begin
       if sg1.Cells[31,i]='V' then
        begin
         //�ȱ�������136
         
        //�ɱ����ģ�
        ssql:=' select rkey from data0034 where Dept_code='''+sg1.Cells[1,i]+''' ';
        ppid:=dm.GetOne('rkey',ssql,dm.qry_temp);

          //������
        ssql:=' select rkey from data0015 where warehouse_code='''+sg1.Cells[27,i]+''' ';
       wh:=dm.GetOne('rkey',ssql,dm.qry_temp);



        //�빺��λ��
        ssql:=' select rkey from data0002 where unit_name='''+sg1.Cells[3,i]+''' ';
        PurUnit:=dm.GetOne('rkey',ssql,dm.qry_temp);

        if PurUnit='' then PurUnit:='null';

          //���õ�λ��
        ssql:=' select rkey from data0002 where unit_name='''+sg1.Cells[4,i]+''' ';
        UseUnit:=dm.GetOne('rkey',ssql,dm.qry_temp);
        if UseUnit='' then UseUnit:='null';

          //���ص�λ��
        ssql:=' select rkey from data0002 where unit_name='''+sg1.Cells[24,i]+''' ';
        FacUnit:=dm.GetOne('rkey',ssql,dm.qry_temp);
        if FacUnit='' then FacUnit:='null';

          //������λ��
        ssql:=' select rkey from data0002 where unit_name='''+sg1.Cells[25,i]+''' ';
        OUnit:=dm.GetOne('rkey',ssql,dm.qry_temp);
        if OUnit='' then OUnit:='null';

         //�������ͣ�
        ssql:=' select rkey from data0496 where group_desc='''+sg1.Cells[6,i]+''' ';
        MType:=dm.GetOne('rkey',ssql,dm.qry_temp);

        //������Ƶ�ʣ�
        if Trim(sg1.cells[11,i])<>''  then
        begin
         if Trim(sg1.cells[11,i])='��' then
          IsFreq:='1'
          else isfreq:='0';
        end
        else   isfreq:='0';


         //��Ա������
        if Trim(sg1.cells[14,i])<>''  then
        begin
         if Trim(sg1.cells[14,i])='��' then
          IsMcount:='1'
          else isMcount:='0';
        end
        else isMcount:='0';

         //���̶�ʱ�䣺
        if Trim(sg1.cells[17,i])<>''  then
        begin
         if Trim(sg1.cells[17,i])='��' then
          IsTime:='1'
          else IsTime:='0';
        end
         else IsTime:='0';

        //���������أ�
        if Trim(sg1.cells[20,i])<>''  then
        begin
         if Trim(sg1.cells[20,i])='��' then
          IsFac:='1'
          else   IsFac:='0';
        end
         else IsFac:='0';

         
        //���������أ�
        if Trim(sg1.cells[29,i])<>''  then
        begin
         if Trim(sg1.cells[29,i])='��' then
          IsFormula:='1'
          else   IsFormula:='0';
        end
         else IsFormula:='0';

          //���챣��һ�Σ�
          if Trim(sg1.cells[12,i])<>''  then
         FDays:= Trim(sg1.cells[12,i])
        else
          FDays:='0' ;

       //����һ��������
         if Trim(sg1.cells[13,i])<>''  then
         FUse:= Trim(sg1.cells[13,i])
        else
         FUse:='0' ;

          //Ա��������
         if Trim(sg1.cells[15,i])<>''  then
          MCount:=Trim(sg1.cells[15,i])
        else
         MCount:='0' ;
         
          //ÿ��ʹ������
         if Trim(sg1.cells[16,i])<>''  then
          Muse:=Trim(sg1.cells[16,i])
        else
         Muse:='0' ;

         //ÿ�¼��Σ�
         if Trim(sg1.cells[18,i])<>''  then
          TCount:=  Trim(sg1.cells[18,i])
        else
          TCount:='0';

         //ÿ��������
         if Trim(sg1.cells[19,i])<>''  then
          TUse:=Trim(sg1.cells[19,i])
        else
         TUse:='0' ;

          //���ģ�
         if Trim(sg1.cells[21,i])<>''  then
          FacUse:=Trim(sg1.cells[21,i])
        else
         FacUse:='0' ;

         
          //����������
         if Trim(sg1.cells[28,i])<>''  then
          FacDay:=Trim(sg1.cells[28,i])
        else
         FacDay:='0' ;

         //if  sg1.cells[28,i]<>'' then
            Formula:=sg1.cells[30,i];


        ssql2:='select rkey from  data0136 where control_name='''+Trim(sg1.cells[0,i])+''' ';
         dm.openqry(DM.qry_temp,ssql2);
         if not DM.qry_temp.isempty then
         begin
         ssql:= 'update  data0136  set  DeptID_p='+PPID+',warehouse_ptr='+wh+' ,PurUnit='+PurUnit+',useUnit='+useUnit+' , '+
                ' crate= '+Trim(sg1.cells[5,i])+',PgroupID='+MType+', property='''+Trim(sg1.cells[7,i])+''',property2='''+Trim(sg1.cells[8,i])+''',  '+
               ' property3='''+Trim(sg1.cells[9,i])+''',property4='''+Trim(sg1.cells[10,i])+''', '+
                '  IsFreq='+IsFreq+',IsMcount='+IsMcount+',IsSTime='+IsTime+',IsFactor='+IsFac+',Fdays='+Fdays+',FAmountused='+Fuse+',  '+
               ' Mcount='+Mcount+',Mused='+Muse+',Tcount='+Tcount+',Tused='+Tuse+',stan_consume='+FacUse+',facname='''+Trim(sg1.cells[23,i])+''',fac_unit='+FacUnit+',Unit_ptr='+Ounit+' '+
               ',FacDay= '+FacDay+' ,IsFormula='+IsFormula+',Formula_ptr=(case when '''+Formula+'''<>'''' then '''+Formula+''' else null end     )'+
                ' where  control_name='''+Trim(sg1.cells[0,i])+'''  ' ;
             dm.execsql(DM.qry_temp,ssql);
         IFlag:=1;
         end
         else
         begin
          ssql:=' insert into data0136(control_name,unit_ptr,warehouse_ptr,stan_consume, '+
                '  DeptID_p,PurUnit,UseUnit,CRate,PGroupID,property,property2,property3,property4,'+
               '  isfreq,Fdays,Famountused,IsMCount,Mcount,Mused,IsSTime,TCount,Tused,IsFactor,FacName,remark,Fac_unit,FacDay,IsFormula,Formula_ptr) '+
               '  values('''+Trim(sg1.cells[0,i])+''', '+Ounit+','+wh+','+FacUse+', '+
                ' '+PPID+','+PurUnit+','+useUnit+', '+Trim(sg1.cells[5,i])+','+MType+','''+Trim(sg1.cells[7,i])+''', '''+Trim(sg1.cells[8,i])+''','''+Trim(sg1.cells[9,i])+''', '+
               '  '''+Trim(sg1.cells[10,i])+''','+IsFreq+','+Fdays+','+Fuse+','+IsMcount+','+Mcount+','+Muse+','+IsTime+','+TCount+','+Tuse+','+IsFac+','''+Trim(sg1.cells[23,i])+''', '+
               '  '''+Trim(sg1.cells[26,i])+''','+FacUnit+','+FacDay+','+IsFormula+' ,'''+Formula+''')   ';
         dm.execsql(DM.qry_temp,ssql);
         IFlag:=1;
         end;

         //control_ptr
           ssql:=' select rkey from data0136 where control_name='''+sg1.Cells[0,i]+''' ';
         control_ptr:=dm.GetOne('rkey',ssql,dm.qry_temp);


         ////////////////////////////////////////////////////////////////
         str2:=trim(sg1.Cells[22,i]);
         lst2:=TStringList.Create;
         lst2.CommaText:= str2;
         //���򱣴� 154��
         for m:=0  to lst2.Count-1 do
         begin
           ssql:=' select rkey from data0034 where dept_code='''+lst2[m]+''' '  ;
             pid:= inttostr(dm.GetOne('rkey',ssql,dm.qry_temp));
          ssql:= ' select control_ptr from data0154 where control_ptr='+control_ptr+' and dept_ptr= '+pid+'';
          dm.openqry(DM.qry_temp,ssql);
          if not dm.qry_temp.isempty  then
          begin
//           ssql:= 'update data0154 set dept_ptr='+pid+' where control_ptr='+control_ptr+' ' ;
//          dm.execsql(DM.qry_temp,ssql);
          end
          else
          begin
            ssql:='insert into data0154(control_ptr,dept_ptr) values('+control_ptr+','+pid+')';
            dm.execsql(DM.qry_temp,ssql);
          end;
         end;

         //////////////////////////////////////////////////////////////////////////
         // ���ϱ��뱣��155��
          str:=trim(sg1.Cells[2,i]);
         lst:=TStringList.Create;
         lst.CommaText:= str;
         for n:=0  to lst.Count-1 do
         begin
           ssql:=' select rkey from data0017 where inv_part_number='''+lst[n]+''' ' ;
             prodno:= inttostr(dm.GetOne('rkey',ssql,dm.qry_temp));
          ssql:= ' select control_ptr from data0155 where control_ptr='+control_ptr+' and invt_ptr= '+prodno+'';
          dm.openqry(DM.qry_temp,ssql);
          if not dm.qry_temp.isempty  then
          begin
//           ssql:= 'update data0155 set invt_ptr='+pid+' where control_ptr='+control_ptr+' ' ;
//          dm.execsql(DM.qry_temp,ssql);
          end
          else
          begin
           ssql:='insert into data0155(control_ptr,invt_ptr) values('+control_ptr+','+prodno+')';
            dm.execsql(DM.qry_temp,ssql);
          end;
         end;



        end;
      end;

    end;



    dm.con1.CommitTrans;
    if IFlag=1  then 
     showmessage('����ɹ�!');
       close;
  except on e:exception do
  begin
  ShowMessage('����'+e.Message+'----:'+ssql);
  dm.con1.RollbackTrans;
  exit;
  end;
  end;

 
   //FrmMain.btn_refreshClick(sender);
   
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


        close;

 end;

end;

procedure TFrmImport.FormShow(Sender: TObject);
begin
 sg1.ColCount:=31;
 sg1.RowCount:=1 ;
 sg1.Cells[0,0]:='��׼����';
 sg1.Cells[1,0]:='�ɱ����ı��';
 sg1.Cells[2,0]:='���ϱ���';
 sg1.Cells[3,0]:='�빺��λ����';
 sg1.Cells[4,0]:='���õ�λ����';
 sg1.Cells[5,0]:='ת����';
 sg1.Cells[6,0]:='�����������';
 sg1.Cells[7,0]:='����1';
 sg1.Cells[8,0]:='����2';
 sg1.Cells[9,0]:='����3';
 sg1.Cells[10,0]:='����4';
 sg1.Cells[11,0]:='������Ƶ��';

 sg1.Cells[12,0]:='���챣��һ��';
 sg1.Cells[13,0]:='����һ�κ�����';
 sg1.Cells[14,0]:='��Ա������';
 sg1.Cells[15,0]:='Ա������/��';
 sg1.Cells[16,0]:='ÿ��ÿ��ʹ����';
 sg1.Cells[17,0]:='���̶�ʱ��';
 sg1.Cells[18,0]:='ÿ���ü���';
 sg1.Cells[19,0]:='ÿ���ö���';
 sg1.Cells[20,0]:='����������';
 sg1.Cells[21,0]:='������/ƽ��';
 sg1.Cells[22,0]:='�������';
 sg1.Cells[23,0]:='��������';

 sg1.Cells[24,0]:='���ص�λ����';
 sg1.Cells[25,0]:='������λ����';
 sg1.Cells[26,0]:='��ע';
 sg1.Cells[27,0]:='��������';
  sg1.Cells[28,0]:='����Ƶ������';
 sg1.Cells[29,0]:='����ʽ';
  sg1.Cells[30,0]:='��ʽ����';


  sg1.ColWidths[0]:=120;
  sg1.ColWidths[1]:=100;
  sg1.ColWidths[2]:=200;
  sg1.ColWidths[3]:=50;
  sg1.ColWidths[4]:=50;
  sg1.ColWidths[5]:=50;
  sg1.ColWidths[6]:=50;
  sg1.ColWidths[7]:=50;
  sg1.ColWidths[8]:=50;
  sg1.ColWidths[9]:=50;
  sg1.ColWidths[10]:=50;
  sg1.ColWidths[11]:=50;

   sg1.ColWidths[12]:=60;
  sg1.ColWidths[13]:=60;
  sg1.ColWidths[14]:=60;
  sg1.ColWidths[15]:=50;
  sg1.ColWidths[16]:=50;
  sg1.ColWidths[17]:=50;
  sg1.ColWidths[18]:=60;
  sg1.ColWidths[19]:=50;
  sg1.ColWidths[20]:=60;
  sg1.ColWidths[21]:=60;
  sg1.ColWidths[22]:=180;
  sg1.ColWidths[23]:=60;

  sg1.ColWidths[24]:=60;
  sg1.ColWidths[25]:=60;
  sg1.ColWidths[26]:=100;
  sg1.ColWidths[27]:=100;
  sg1.ColWidths[27]:=80;

end;

end.
