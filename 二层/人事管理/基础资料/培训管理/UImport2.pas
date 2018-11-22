unit UImport2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, ExtCtrls,OleServer, Excel2000,ComObj, DB, ADODB;

type
  TfrmImport2 = class(TForm)
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
    qrytemp: TADOQuery;
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
  frmImport2: TfrmImport2;

implementation
          uses common, UDM, UMain;
{$R *.dfm}

procedure TfrmImport2.btn_ExModelClick(Sender: TObject);
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

  Sheet.Cells[1,1]:='��������';
  Sheet.Cells[1,2]:='ְ������';
  Sheet.Cells[1,3]:='�γ̱��';
  Sheet.Cells[1,4]:='�γ�����';
  Sheet.Cells[1,5]:='�γ����';



   XlApp.Visible := True;


end;

procedure TfrmImport2.btn_exitClick(Sender: TObject);
begin
close;
end;

procedure TfrmImport2.btn_OpenFileClick(Sender: TObject);
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

procedure TfrmImport2.FormShow(Sender: TObject);
begin
  sg1.ColCount:=6;
  sg1.RowCount:=1 ;

  sg1.Cells[0,0]:='��������';
  sg1.Cells[1,0]:='ְ������';
  sg1.Cells[2,0]:='�γ̱��';
  sg1.Cells[3,0]:='�γ�����';
  sg1.Cells[4,0]:='�γ�����';
  sg1.Cells[5,0]:='�Ƿ�OK';
  sg1.Cells[6,0]:='ԭ��';

  sg1.ColWidths[0]:=120;
  sg1.ColWidths[1]:=100;
  sg1.ColWidths[2]:=100;
  sg1.ColWidths[3]:=120;
  sg1.ColWidths[4]:=80;
  sg1.ColWidths[5]:=200;
end;

procedure TfrmImport2.btn_checkClick(Sender: TObject);
var
  i,j,k ,flag,XFlag,DeptID,PostID,tc_ptr,CTypeID:Integer;
  ssql,s:string;
begin
 ISchecked:=0;
 Eflag:=0;

 try
  for i:=1  to sg1.RowCount-1 do
  begin
    XFlag:=0;
  if  sg1.Cells[0,i]<>'' then
   begin
    //1.�жϲ��ź͸�λ�Ƿ��ظ���
   ssql:=' select rkey from datadepartment where departmentName='''+trim(sg1.Cells[0,i])+'''   ';
   common.OpenQuery(dm.qry_temp,ssql);
    if  (not dm.qry_temp.IsEmpty)  then
    Deptid:=dm.qry_temp.fieldbyname('rkey').AsInteger
    else
    begin
    sg1.Cells[4,i]:='X';
    sg1.Cells[5,i]:=sg1.Cells[5,i]+'�������Ʋ���!';
    XFlag:=1;
    end;

   ssql:=' select rkey from datadetail where dictid=1 and item='''+trim(sg1.Cells[1,i])+'''   ';
   common.OpenQuery(dm.qry_temp,ssql);
    if  (not dm.qry_temp.IsEmpty)  then
    PostID:=dm.qry_temp.fieldbyname('rkey').AsInteger
    else
    begin
    sg1.Cells[5,i]:='X';
    sg1.Cells[6,i]:=sg1.Cells[6,i]+'ְ�����Ʋ���!';
    XFlag:=1;
    end;

    if trim(sg1.Cells[4,i])='��ְ��ѵ' then
     CTypeID:=0
    else if trim(sg1.Cells[4,i])='��ǰ��ѵ' then
     CTypeID:=1
    else if trim(sg1.Cells[4,i])='�ڸ���ѵ' then
     CTypeID:=2
    else
    begin
    sg1.Cells[5,i]:='X';
    sg1.Cells[6,i]:=sg1.Cells[6,i]+'�γ���𲻶�!';
    XFlag:=1;
    end;


   ssql:=' select rkey from trainclass where  ccode='''+trim(sg1.Cells[2,i])+''' and cName='''+trim(sg1.Cells[3,i])+'''  ';
   common.OpenQuery(dm.qry_temp,ssql);
    if  ( dm.qry_temp.IsEmpty)  then
   begin
    sg1.Cells[5,i]:='X';
    sg1.Cells[6,i]:=sg1.Cells[6,i]+'�γ̱�Ż��߿γ����Ʋ���!';
    XFlag:=1;
   end
   else tc_ptr:= dm.qry_temp.fieldbyname('rkey').AsInteger;

   ssql:=' select a.rkey  '+
   ' from DeptPostTrainClass_main a '+
   ' inner join  DeptPostTrainClass_detail b on a.rkey=b.m_ptr '+
   ' where  a.Deptid='+inttostr(DeptID)+' and a.PostID='+inttostr(PostID)+' and a.CType='+inttostr(ctypeID)+' and b.tc_ptr ='+inttostr(tc_ptr)+' ';
   common.OpenQuery(dm.qry_temp,ssql);
   if  (not dm.qry_temp.IsEmpty)  then
   begin
    sg1.Cells[5,i]:='X';
    sg1.Cells[6,i]:=sg1.Cells[6,i]+'���š�ְ�񡢿γ����Ϳγ��ظ�!';
    XFlag:=1;
   end;


    if Xflag=0  then
     sg1.Cells[5,i]:='V'
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
 ISchecked:=0;
 exit;
 end;
 end;

end;

procedure TfrmImport2.btn_exportErrClick(Sender: TObject);
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


   if sg1.Cells[4,i]='X' then
   Sheet.cells[i+1,j+1]:=sg1.Cells[j,i];

  end;

   XlApp.Visible := True;

end;

procedure TfrmImport2.btn_importClick(Sender: TObject);
var
i ,j, atype,EmpID,Vcount,Xcount,Xcount2,s: integer;
ssql,ssql2 ,YM,memo,THours: string;
Deptid, PostID,tc_ptr,CTypeID,MRkey:string;
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
       if sg1.Cells[5,i]='V' then
        begin
        ssql:=' select rkey from DataDepartment where departmentname='''+sg1.Cells[0,i]+''' ';
        DeptID:=IntToStr(dm.GetOne('rkey',ssql,dm.qry_temp));

        ssql:=' select rkey from DataDetail where dictid=1 and item='''+sg1.Cells[1,i]+''' ';
        PostID:=IntToStr(dm.GetOne('rkey',ssql,dm.qry_temp));

        ssql:=' select rkey from trainclass where ccode='''+sg1.Cells[2,i]+''' ';
        tc_ptr:=IntToStr(dm.GetOne('rkey',ssql,dm.qry_temp));

          if trim(sg1.Cells[4,i])='��ְ��ѵ' then
           CTypeID:='0'
          else if trim(sg1.Cells[4,i])='��ǰ��ѵ' then
           CTypeID:='1'
          else if trim(sg1.Cells[4,i])='�ڸ���ѵ' then
           CTypeID:='2';
           
         //����DeptPostTrainClass_main����

         ssql:=' select rkey  from  DeptPostTrainClass_main'+
               ' where deptid='+DeptID+' and postid='+PostID+' and ctype='+ctypeid+'';
        dm.OpenQry(qrytemp,ssql) ;
        if  qrytemp.IsEmpty then
        begin
        ssql:=' insert into DeptPostTrainClass_main(DeptID,PostID,ctype)'+
               'values('+DeptID+','+PostID+','+ctypeid+')';
        dm.execsql(qrytemp,ssql) ;
         ssql:=' select rkey  from  DeptPostTrainClass_main'+
               ' where deptid='+DeptID+' and postid='+PostID+' and ctype='+ctypeid+' ';
        dm.OpenQry(qrytemp,ssql) ;
        MRkey:=qrytemp.fieldbyname('rkey').AsString;
        end
        else
        MRkey:=qrytemp.fieldbyname('rkey').AsString;

        ssql:=' select rkey  from  DeptPostTrainClass_Detail'+
               ' where M_ptr='+Mrkey+' and tc_ptr='+tc_ptr+' ';
        dm.OpenQry(qrytemp,ssql) ;
        //����DeptPostTrainClass_detail��
        if qrytemp.IsEmpty then
        begin
        ssql:=' insert into DeptPostTrainClass_detail(M_ptr,tc_ptr)'+
               'values('+Mrkey+','+tc_ptr+')';
        dm.execsql(qrytemp,ssql) ;
        end;
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
   // sg1.RowCount:=Xcount+1;

 end;

end;

end.
