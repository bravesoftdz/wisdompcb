unit UImport22;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, Grids, StdCtrls, ExtCtrls,OleServer, Excel2000,ComObj;

type
  TfrmImport22 = class(TForm)
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
    procedure btn_importClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    ISchecked: integer;
    Eflag: Integer;
  public
    { Public declarations }
  end;

var
  frmImport22: TfrmImport22;

implementation

uses UDM, UMain,common;

{$R *.dfm}

procedure TfrmImport22.btn_ExModelClick(Sender: TObject);
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
  Sheet.Cells[1,2]:='��Ŀ����';
  Sheet.Cells[1,3]:='�������';
  Sheet.Cells[1,4]:='�������';
  Sheet.Cells[1,5]:='���';
  Sheet.Cells[1,6]:='A��';
  Sheet.Cells[1,7]:='B��';
  Sheet.Cells[1,8]:='C��';
  Sheet.Cells[1,9]:='D��';
  Sheet.Cells[1,10]:='��ȷ��';


   XlApp.Visible := True;
end;

procedure TfrmImport22.btn_exportErrClick(Sender: TObject);
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
   if sg1.Cells[10,i]='X' then
   Sheet.cells[i+1,j+1]:=sg1.Cells[j,i];
  end;

   XlApp.Visible := True;
end;

procedure TfrmImport22.btn_exitClick(Sender: TObject);
begin
close;
end;

procedure TfrmImport22.btn_OpenFileClick(Sender: TObject);
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

procedure TfrmImport22.btn_checkClick(Sender: TObject);
var
  i,j,k ,flag,XFlag ,tc_ptr,CTypeID:Integer;
  ssql,s:string;
  checkfloat:Double;
begin
 ISchecked:=0;
 Eflag:=0;

 try
  for i:=1  to sg1.RowCount-1 do
  begin
    XFlag:=0;
  if  sg1.Cells[0,i]<>'' then
   begin
    //1.�жϿγ��Ƿ����
   Ssql:=' select rkey from trainclass  where ccode='''+trim(sg1.Cells[0,i])+'''   ';
   common.OpenQuery(dm.qry_temp,ssql);
    if  not ( dm.qry_temp.IsEmpty)  then
    sg1.Cells[12,i]:=dm.qry_temp.fieldbyname('rkey').AsString
    else
    begin
    sg1.Cells[10,i]:='X';
    sg1.Cells[11,i]:=sg1.Cells[11,i]+'�γ̱�Ų���!';
    XFlag:=1;
    end;

   //��Ŀ����
   if (sg1.Cells[1,i]<>'ѡ��') and  (sg1.Cells[1,i]<>'�ж�') then
   begin
    sg1.Cells[10,i]:='X';
    sg1.Cells[11,i]:=sg1.Cells[11,i]+'��Ŀ���Ͳ���!';
    XFlag:=1;
   end;

   //���������
    if not TryStrToFloat(Trim(sg1.cells[2,i]),checkfloat) then     
    begin
    sg1.Cells[10,i]:='X';
    sg1.Cells[11,i]:=sg1.Cells[11,i-1] + ' ��ѵ�������� ';
    XFlag:=1;
    end;

    if Xflag=0  then
     sg1.Cells[10,i]:='V'
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

procedure TfrmImport22.btn_importClick(Sender: TObject);
var
i ,j, atype,EmpID,Vcount,Xcount,Xcount2,s: integer;
ssql,ssql2 ,YM,memo,THours: string;
 PTypeID,MRkey:string;
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
     dm.con.BeginTrans;
      if (Eflag=1) and  (MessageDlg('�д���������Ҫ����������ȷ��������',mtInformation,[mbOK,mbCancel],0)= mrcancel) then exit
      else
      begin
      for i:=1 to  sg1.Rowcount-1 do
      begin
       if sg1.Cells[10,i]='V' then
       begin
        if trim(sg1.Cells[1,i])='�ж�' then
         PTypeID:='0'
        else if trim(sg1.Cells[1,i])='ѡ��' then
         PTypeID:='1' ;

           //����DeptPostTrainClass_main����
           ssql:=' select rkey  from  paperMain '+
                 ' where tc_ptr='+sg1.Cells[12,i]+'  ';
          dm.OpenQry(qrytemp,ssql) ;
          if  qrytemp.IsEmpty then
          begin
            ssql:=' insert into paperMain(tc_ptr,AScore)'+
                   'values('+sg1.Cells[12,i]+', 100)';
            dm.execsql(qrytemp,ssql) ;
             ssql:=' select rkey  from  paperMain'+
                   ' where tc_ptr='+sg1.Cells[12,i]+' ';
            dm.OpenQry(qrytemp,ssql) ;
            MRkey:=qrytemp.fieldbyname('rkey').AsString;
          end
          else
          begin
          MRkey:=qrytemp.fieldbyname('rkey').AsString;
          //ssql:='update paperMain set tc_ptr='+sg1.Cells[12,i]+' where  tc_ptr='+sg1.Cells[12,i]+' '
          end;

          ssql:=' select rkey  from  paperDetail'+
                 ' where M_ptr='+Mrkey+' and PNo='+sg1.Cells[2,i]+' ';
          dm.OpenQry(qrytemp,ssql) ;
          //����DeptPostTrainClass_detail��
          if qrytemp.IsEmpty then
          begin
          ssql:=' insert into paperDetail(M_ptr,PType,PNo,PContent,A,B,C,D,PRight,Ascore)'+
                 'values('+MRkey+','+PTypeID+','+sg1.Cells[2,i]+','''+sg1.Cells[4,i]+''','''+sg1.Cells[5,i]+''','''+sg1.Cells[6,i]+''','''+sg1.Cells[7,i]+''', '+
                 ''''+sg1.Cells[8,i]+''','''+sg1.Cells[9,i]+''','+sg1.Cells[3,i]+'  )';
          dm.execsql(qrytemp,ssql) ;
          end
          else
          begin
            ssql:='update paperDetail set PType='+PTypeID+' ,PContent='''+sg1.Cells[4,i]+''', A='''+sg1.Cells[5,i]+''',B='''+sg1.Cells[6,i]+''','+
                'C='''+sg1.Cells[7,i]+''',D='''+sg1.Cells[8,i]+''',PRight='''+sg1.Cells[9,i]+''',Ascore='+sg1.Cells[3,i]+' where M_ptr='+MRkey+' and PNo='+sg1.Cells[2,i]+'';
           dm.execsql(qrytemp,ssql) ;
          end;
       end;
      end;

    dm.con.CommitTrans;
    showmessage('����ɹ�!');
  end;
  
  except on e:exception do
  begin
  ShowMessage('����'+e.Message+ssql);
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
    if sg1.cells[4,i]='V'  then
    begin
     Vcount:=Vcount+1;
     sg1.Rows[i].Clear;
    end;
      if sg1.cells[4,i]='X'  then
      Xcount:=Xcount+1;
    end;
    
      Xcount2:=0;
    //�ǿ������ƣ�
    for i:=1 to sg1.RowCount-1 do
    begin
     if sg1.cells[0,i]='' then
     for j:=1 to sg1.RowCount-1 do
     begin
      if  (sg1.cells[4,j]='X') and  (Xcount2<=Xcount)  then
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

procedure TfrmImport22.FormShow(Sender: TObject);
begin
  sg1.ColCount:=13;
  sg1.RowCount:=1 ;

  sg1.Cells[0,0]:='�γ̱��';
  sg1.Cells[1,0]:='��Ŀ����';
  sg1.Cells[2,0]:='���';
  sg1.Cells[3,0]:='�������';
  sg1.Cells[4,0]:='��Ŀ����';
  sg1.Cells[5,0]:='A��';
  sg1.Cells[6,0]:='B��';
  sg1.Cells[7,0]:='C��';
  sg1.Cells[8,0]:='D��';
  sg1.Cells[9,0]:='��ȷ��';
  sg1.Cells[10,0]:='�Ƿ�OK';
  sg1.Cells[11,0]:='����˵��';
  sg1.Cells[12,0]:='tc_ptr';

  sg1.ColWidths[0]:=100;
  sg1.ColWidths[1]:=100;
  sg1.ColWidths[2]:=100;
  sg1.ColWidths[3]:=100;
  sg1.ColWidths[4]:=200;
  sg1.ColWidths[5]:=120;
  sg1.ColWidths[6]:=120;
  sg1.ColWidths[7]:=120;
  sg1.ColWidths[8]:=120;
  sg1.ColWidths[9]:=120;
  sg1.ColWidths[10]:=50;
  sg1.ColWidths[11]:=200;
  sg1.ColWidths[12]:=-1;

end;

end.
