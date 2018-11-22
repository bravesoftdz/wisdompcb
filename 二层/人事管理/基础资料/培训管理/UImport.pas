unit UImport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, ExtCtrls,OleServer, Excel2000,ComObj;

type
  TfrmImport = class(TForm)
    pnl1: TPanel;
    Panel1: TPanel;
    btn_ExModel: TButton;
    btn_exit: TButton;
    btn_exportErr: TButton;
    Panel2: TPanel;
    sg1: TStringGrid;
    Panel3: TPanel;
    btn_OpenFile: TButton;
    btn_check: TButton;
    btn_import: TButton;
    OpenDialog1: TOpenDialog;
    procedure btn_ExModelClick(Sender: TObject);
    procedure btn_exitClick(Sender: TObject);
    procedure btn_OpenFileClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_checkClick(Sender: TObject);
    procedure btn_exportErrClick(Sender: TObject);
    procedure btn_importClick(Sender: TObject);
  private
    { Private declarations }
    ISchecked: integer;
    Eflag: Integer;
  public
    { Public declarations }
  end;

var
  frmImport: TfrmImport;

implementation
          uses common, UDM, UMain;
{$R *.dfm}

procedure TfrmImport.btn_ExModelClick(Sender: TObject);
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

  Sheet.Cells[1,1]:='�γ̱��';
  Sheet.Cells[1,2]:='�γ�����';
//  Sheet.Cells[1,3]:='�γ�����';
//  Sheet.Cells[1,4]:='�γ����';
//  Sheet.Cells[1,5]:='��ѵ��ʽ';
//  Sheet.Cells[1,6]:='���˷�ʽ';
//  Sheet.Cells[1,7]:='��ѵʱ��';


   XlApp.Visible := True;
end;

procedure TfrmImport.btn_exitClick(Sender: TObject);
begin
close;
end;

procedure TfrmImport.btn_OpenFileClick(Sender: TObject);
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

procedure TfrmImport.FormShow(Sender: TObject);
begin
  sg1.ColCount:=9;
  sg1.RowCount:=1 ;
  sg1.Cells[0,0]:='�γ̱��';
  sg1.Cells[1,0]:='�γ�����';
//  sg1.Cells[2,0]:='�γ�����';
//  sg1.Cells[3,0]:='�γ����';
//  sg1.Cells[4,0]:='��ѵ��ʽ';
//  sg1.Cells[5,0]:='���˷�ʽ';
//  sg1.Cells[6,0]:='��ѵʱ��';
  sg1.Cells[2,0]:='�Ƿ�OK';
  sg1.Cells[3,0]:='ԭ��';

  sg1.ColWidths[0]:=50;
  sg1.ColWidths[1]:=100;
  sg1.ColWidths[2]:=80;
  sg1.ColWidths[3]:=200;
//  sg1.ColWidths[4]:=80;
//  sg1.ColWidths[5]:=80;
//  sg1.ColWidths[6]:=80;
//  sg1.ColWidths[7]:=80;
//  sg1.ColWidths[8]:=200;



end;

procedure TfrmImport.btn_checkClick(Sender: TObject);
var
  i,j,k ,flag,XFlag:Integer;
  ssql,s:string;
begin
//
 ISchecked:=0;
 Eflag:=0;


 try
  for i:=1  to sg1.RowCount-1 do
  begin
   XFlag:=0;
   if  sg1.Cells[0,i]<>'' then
   begin


   if (sg1.Cells[0,i]='') then
   begin
    sg1.Cells[2,i]:='X';
    sg1.Cells[3,i]:=sg1.Cells[3,i]+'��Ų���Ϊ��!';
    XFlag:=1;
   end;


    //�жϿγ����
//    if ((sg1.Cells[2,i]<>'��ѵ') and (sg1.Cells[2,i]<>'��ѵ')) or (sg1.Cells[2,i]='')   then
//    begin
//       sg1.Cells[7,i]:='X';
//      sg1.Cells[8,i]:=sg1.Cells[8,i]+' �γ��������!';
//      XFlag:=1;
//    end;
//
   // �жϿγ�����
//    ssql:='select rkey  from datadetail  where dictid=27 and item='''+trim(sg1.Cells[3,i])+''' ';
//    common.OpenQuery(dm.qry_temp,ssql);
//   if  (dm.qry_temp.IsEmpty)  then
//   begin
//    sg1.Cells[7,i]:='X';
//    sg1.Cells[8,i]:=sg1.Cells[8,i]+' �γ��������!';
//    XFlag:=1;
//   end;
// 
    //�ж���ѵ��ʽ
//    if ((sg1.Cells[4,i]<>'��������') and (sg1.Cells[4,i]<>'ʵ����ѵ') and  (sg1.Cells[4,i]<>'������ѵ'))   or (sg1.Cells[4,i]='')   then
//    begin
//       sg1.Cells[7,i]:='X';
//      sg1.Cells[8,i]:=sg1.Cells[8,i]+' ��ѵ��ʽ����!';
//      XFlag:=1;
//    end;
//
    //�жϿ��˷�ʽ
//    if ((sg1.Cells[5,i]<>'���Կ���') and (sg1.Cells[5,i]<>'���Կ���') and  (sg1.Cells[5,i]<>'ʵ�ٿ���') and  (sg1.Cells[5,i]<>'���߿���')) or (sg1.Cells[5,i]='')   then
//    begin
//       sg1.Cells[7,i]:='X';
//      sg1.Cells[8,i]:=sg1.Cells[8,i]+' ���˷�ʽ����!';
//      XFlag:=1;
//    end;

    if Xflag=0  then
     sg1.Cells[2,i]:='V'
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

procedure TfrmImport.btn_exportErrClick(Sender: TObject);
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


   if sg1.Cells[2,i]='X' then
   Sheet.cells[i+1,j+1]:=sg1.Cells[j,i];

  end;

   XlApp.Visible := True;

end;

procedure TfrmImport.btn_importClick(Sender: TObject);
var
i ,j, atype,EmpID,Vcount,Xcount,Xcount2,s: integer;
ssql,ssql2 ,YM,memo,THours: string;
Deptid, PostID:string;
CType, CType2,TType,EType:string;

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
       if sg1.Cells[2,i]='V' then
        begin

//        if sg1.Cells[2,i]='��ѵ' then
//         CType:='0'
//        else
//         CType:='1';

//        ssql:='select rkey from datadetail  where dictid=27 and item='''+trim(sg1.Cells[3,i])+''' ' ;
//        dm.OpenQry(dm.qry_temp,ssql);
//        if not DM.qry_temp.IsEmpty then
//        ctype2:=DM.qry_temp.fieldbyname('rkey').asstring;

//        if sg1.Cells[4,i]='�γ�����' then
//         TType:='0'
//        else   if sg1.Cells[4,i]='ʵ����ѵ' then
//         TType:='1'
//        else
//         TType:='2';
//
//        if sg1.Cells[5,i]='���Կ���' then
//         EType:='0'
//        else   if sg1.Cells[5,i]='���Կ���' then
//         EType:='1'
//        else   if sg1.Cells[5,i]='ʵ�ٿ���' then
//         EType:='2'
//        else
//         EType:='3' ;
//
//        if sg1.Cells[6,i]<>'' then
//        THours:=sg1.Cells[6,i]
//        else
//        THours:='0';

        ssql2:='select rkey from  TrainClass where   CCode= '''+sg1.Cells[0,i]+''' ';
         dm.openqry(DM.qry_temp,ssql2);

         if DM.qry_temp.RecordCount>0 then
         ssql:= 'update  TrainClass  set  CName='''+trim(sg1.Cells[1,i])+''' '+
               //' CType='+CType+',CType2='+CType2+', TType='+TType+', EType='+EType+',THours='+THours+' '+
               ' where CCode='''+sg1.Cells[0,i]+''''
         else
          ssql:=' insert into TrainClass(CCode, CName)'+   //,CType,CType2,TType,EType,THours
               'values('''+trim(sg1.Cells[0,i])+''','''+trim(sg1.Cells[1,i])+''')';  //,'+CType+','+CType2+','+TType+','+EType+','+THours+' 

        dm.execsql(DM.qry_temp,ssql);
        end;
      end;
      end;
   dm.con.CommitTrans;
  showmessage('����ɹ�!');
  frmMain.btn_refresh2Click(sender);

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
    if sg1.cells[2,i]='V'  then
    begin
     Vcount:=Vcount+1;
     sg1.Rows[i].Clear;
    end;
      if sg1.cells[2,i]='X'  then
      Xcount:=Xcount+1;
    end;
    
      Xcount2:=0;
    //�ǿ������ƣ�
    for i:=1 to sg1.RowCount-1 do
    begin
     if sg1.cells[0,i]='' then
     for j:=1 to sg1.RowCount-1 do
     begin
      if  (sg1.cells[2,j]='X') and  (Xcount2<=Xcount)  then
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
