unit UImport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Grids,OleServer, Excel2000,ComObj;

type
  TFrmImport = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    btn_ExModel: TButton;
    btn_exit: TButton;
    btn_OpenFile: TButton;
    btn_check: TButton;
    btn_import: TButton;
    sg1: TStringGrid;
    OpenDialog1: TOpenDialog;
    btn_exportErr: TButton;
    procedure FormShow(Sender: TObject);
    procedure btn_OpenFileClick(Sender: TObject);
    procedure btn_checkClick(Sender: TObject);
    procedure btn_importClick(Sender: TObject);
    procedure btn_ExModelClick(Sender: TObject);
    procedure btn_exportErrClick(Sender: TObject);
    procedure btn_exitClick(Sender: TObject);
  private
    { Private declarations }
    ISchecked: integer;
    Eflag: Integer;
  public
    { Public declarations }
  end;

var
  FrmImport: TFrmImport;

implementation
         uses common, udm, UMain;
{$R *.dfm}

procedure TFrmImport.FormShow(Sender: TObject);
begin
//
sg1.ColCount:=6;
 sg1.RowCount:=1 ;
 sg1.Cells[0,0]:='����';
 sg1.Cells[1,0]:='����';
 sg1.Cells[2,0]:='����';
 sg1.Cells[3,0]:='����';
 sg1.Cells[4,0]:='����';
 sg1.Cells[5,0]:='��ע';

  sg1.ColWidths[0]:=50;
  sg1.ColWidths[1]:=100;
  sg1.ColWidths[2]:=100;
  sg1.ColWidths[3]:=100;
  sg1.ColWidths[4]:=50;
  sg1.ColWidths[5]:=150;




end;

procedure TFrmImport.btn_OpenFileClick(Sender: TObject);
var
  fileName: string;
begin
 if sg1.rowcount>=2 then
    sg1.rowcount:=1;

 if OpenDialog1.Execute then  fileName:=OpenDialog1.FileName else exit;
  try
  common.load_xls_to_sgrid(fileName,sg1);

  except on e:exception do
 begin
 ShowMessage('����'+e.Message);
 exit;
 end;
end;

end;

procedure TFrmImport.btn_checkClick(Sender: TObject);
var
  i,j,k ,flag,XFlag:Integer;
  ssql,s:string;
begin
//
 ISchecked:=0;
 Eflag:=0; 
 XFlag:=0;
 sg1.ColCount:=sg1.ColCount+2;
 sg1.Cells[6,0]:='�Ƿ�OK';
 sg1.Cells[7,0]:='ԭ��';
 sg1.ColWidths[6]:=40;
 sg1.ColWidths[7]:=800;
 try
  for i:=1  to sg1.RowCount-1 do
  begin
   if  sg1.Cells[0,i]<>'' then
   begin 
    //�жϹ��ź������ܷ���ϻ���ϵͳ���ܲ����ҵ�
   ssql:=' select employeecode from employeemsg where employeecode='''+trim(sg1.Cells[0,i])+'''  and chineseName='''+trim(sg1.Cells[1,i])+'''   ';
   dm.OpenQry(DM.qry_temp,ssql);
   if  (dm.qry_temp.IsEmpty) or (sg1.Cells[0,i]='') or (sg1.Cells[1,i]='') then
   begin
    sg1.Cells[6,i]:='X';
    sg1.Cells[7,i]:=sg1.Cells[7,i]+'���ź�������ƥ��!';
    XFlag:=1;
   end;


   //�ж����¸�ʽ�Ƿ���ȷ��
     flag:=0;
   if  (Length(Trim(sg1.Cells[2,i]))<>7) or (Trim(sg1.Cells[2,i])='') then
   begin
    flag:=1;
   // XFlag:=1;
   end;
  // k:=Length(Trim(sg1.Cells[2,i]))-2;
   // s:=copy(Trim(sg1.Cells[2,i]),Length(Trim(sg1.Cells[2,i]))-2,2);
   k:= StrToInt(copy(Trim(sg1.Cells[2,i]),Length(Trim(sg1.Cells[2,i]))-1,2));
    if  (k>12) then
     flag:=1;


   if flag=1 then
   begin
    sg1.Cells[6,i]:='X';
    sg1.Cells[7,i]:=sg1.Cells[7,i]+' ���¸�ʽ����!';
    XFlag:=1;
   end;
   ////////////
  //�ж�����
  if ((sg1.Cells[3,i]<>'��ĩ') and (sg1.Cells[3,i]<>'�ڼ�')) or (sg1.Cells[3,i]='')   then
  begin
     sg1.Cells[6,i]:='X';
    sg1.Cells[7,i]:=sg1.Cells[7,i]+' ��������!';
    XFlag:=1;
  end;

  if Xflag=0  then
   sg1.Cells[6,i]:='V'
  else
  begin
   Eflag:=1;
   //sg1.Rows[i].font.Color:=clRed;
  end; 
 // ��������Ϊ���֣�
//     if sg1.Cells[4,i]=''  then
//  begin
//     sg1.Cells[6,i]:='X';
//    sg1.Cells[7,i]:=sg1.Cells[7,i]+'��������!';
//  end;

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

procedure TFrmImport.btn_importClick(Sender: TObject);
var
i ,j, atype,EmpID,Vcount,Xcount,Xcount2,s: integer;
ssql,ssql2, EmpCode,YM,memo,days: string;
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

    if (Eflag=1) and  (MessageDlg('�д���������Ҫ����������ȷ��������',mtInformation,[mbOK,mbCancel],0)= mrcancel) then exit

    else
    begin
       for i:=1 to  sg1.Rowcount-1 do
       begin
       if sg1.Cells[6,i]='V' then
        begin
        EmpCode:=sg1.Cells[0,i];
        ssql:=' select rkey from employeemsg where employeecode='''+EmpCode+''' ';
        EmpID:=dm.GetOne('rkey',ssql,dm.qry_temp);
        YM:=sg1.Cells[2,i];
        if sg1.Cells[3,i]='��ĩ' then
         atype:=0
        else
         atype:=1;
         if sg1.Cells[4,i]<>'' then
        days:=sg1.Cells[4,i]
        else
        days:='0';

        memo:=sg1.Cells[5,i];
    
        ssql2:='select rkey from  OverWorkApply where employeeid='+inttostr(EmpID)+' and YearMonth='''+ym+''' and atype='+inttostr(atype)+' ';
         dm.openqry(DM.qry_temp,ssql2);

         if DM.qry_temp.RecordCount>0 then
         ssql:= 'update  OverWorkApply  set  status=1 ,days='+days+',remark='''+memo+'''  where  employeeid='+inttostr(EmpID)+' and YearMonth='''+ym+''' and atype='+inttostr(atype)+' '
         else 
          ssql:=' insert into OverWorkApply(employeeid, YearMonth,AType,days,status,remark)'+
               'values('+inttostr(EmpID)+','''+ym+''','+inttostr(atype)+','+days+',1,'''+memo+'''  )';

        dm.execsql(DM.qry_temp,ssql);
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
 
   frmMain.btn_refreshClick(sender);
   
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
   // sg1.RowCount:=Xcount+1;

 end;
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

 Sheet.Cells[1,1]:='����';
 Sheet.Cells[1,2]:='����';
 Sheet.Cells[1,3]:='����';
 Sheet.Cells[1,4]:='����';
 Sheet.Cells[1,5]:='����';
 Sheet.Cells[1,6]:='��ע';

 Sheet.Cells[2,1]:='3001';
 Sheet.Cells[2,2]:='����';
 Sheet.Cells[2,3]:='2015-11';
 Sheet.Cells[2,4]:='��ĩ';
 Sheet.Cells[2,5]:='3.5';
 Sheet.Cells[2,6]:='����';


   XlApp.Visible := True;
   
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


   if sg1.Cells[6,i]='X' then
   Sheet.cells[i+1,j+1]:=sg1.Cells[j,i];

  end;





   XlApp.Visible := True;

end;

procedure TFrmImport.btn_exitClick(Sender: TObject);
begin
close;
end;

end.
