unit Uimport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, Buttons, ExtCtrls, Menus, OleServer, Excel2000,
  ComObj,ComCtrls, Provider, jpeg,strUtils,dateutils, DBGridEh,IniFiles,
  DB, ADODB ;

type
  TFrmImport = class(TForm)
    Label1: TLabel;
    Label_accountid: TLabel;
    Label_rowcount: TLabel;
    Label2: TLabel;
    btn_OpenFile: TButton;
    btn_check: TButton;
    btn_import: TButton;
    StringGrid1: TStringGrid;
    btn_Outport: TButton;
    btn_OutPortModel: TButton;
    btn_quit: TButton;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    OpenDialog1: TOpenDialog;
    procedure FormCreate(Sender: TObject);
    procedure btn_quitClick(Sender: TObject);
    procedure btn_OutPortModelClick(Sender: TObject);
    procedure btn_OpenFileClick(Sender: TObject);
    procedure btn_checkClick(Sender: TObject);
    procedure btn_importClick(Sender: TObject);
    procedure btn_OutportClick(Sender: TObject);
  private
    { Private declarations }

    grid_col_count1: integer;
    s_yearmonth :string;
    procedure gridimportrebuild(Accountid: Integer);
    procedure DBupdate;

  public
    { Public declarations }
  end;

var
  FrmImport: TFrmImport;

implementation

uses Umodel, UMain, UDM,common;

{$R *.dfm}

procedure TFrmImport.FormCreate(Sender: TObject);
var i: integer;
begin
grid_col_count1:=0;
s_yearmonth := frmmain.cbb_smonth.Text ;
i:=integer(frmmain.cbb_account.Items.Objects[frmmain.cbb_account.ItemIndex]);
gridimportrebuild(i);
end;

procedure TFrmImport.gridimportrebuild(Accountid: Integer);
var
    i,j: integer;
    q_str,ss,ssql: string;
    radioX: TRadioGroup;
begin
     radioX := TRadioGroup.Create(application);
     StringGrid1.ColCount := 1;
     StringGrid1.RowCount := 3;
     if Accountid = frmmodel.rg_dayimport.Tag then
     radiox := frmmodel.rg_dayimport;
     if Accountid = frmmodel.rg_import5.Tag then
     radiox := frmmodel.rg_import5;
     if Accountid = frmmodel.rg_import6.Tag then
     radiox := frmmodel.rg_import6;
     //ShowMessage(ss);
     if radiox.ItemIndex >0 then
     begin
       ss := radiox.Items.Strings[radiox.ItemIndex];
       Label1.Caption := ss+'    �����·�:    '+s_yearmonth;
       Label_accountid.Caption := inttostr(radiox.ItemIndex);
     ssql := ' select datafield_name,datafield_F from employeesalary_rpt_model '+
                      ' where model_name ='+quotedstr(ss)+' order by f_index' ;
          dm.openqry(dm.qry_temp,ssql);
          
          if dm.qry_temp.RecordCount>0 then
          begin
            grid_col_count1 := dm.qry_temp.RecordCount+2;
            StringGrid1.ColCount := dm.qry_temp.RecordCount+2;
             stringgrid1.Cells[0,0]:='����';
             StringGrid1.Cells[0,1]:='employeecode';
             stringgrid1.Cells[1,0]:='����';
             StringGrid1.Cells[1,1]:='chinesename';
            for i:= 0 to DM.qry_temp.RecordCount-1 do
              begin
              stringgrid1.Cells[i+2,0]:= dm.qry_temp.FieldByName('datafield_name').asString;
              stringgrid1.Cells[i+2,1]:= dm.qry_temp.FieldByName('datafield_F').asString;
              DM.qry_temp.Next;
              end;
          end;
          dm.qry_temp.Close;
     end;
     btn_check.Enabled := false;
     btn_import.Enabled := false;
     btn_Outport.Enabled := false;
end;


procedure TFrmImport.btn_quitClick(Sender: TObject);
begin
close;
end;

procedure TFrmImport.btn_OutPortModelClick(Sender: TObject);
begin
  if label1.Caption=''   then
    begin
        showmessage('����ģ���������ѡ��ǰ���׵ĵ���ģ���ȡ�');
        exit;
    end;
  Export_Grid_to_Excel(stringgrid1,FrmMain.cbb_account.text+'�ĵ���ģ��') ;
end;

procedure TFrmImport.btn_OpenFileClick(Sender: TObject);
var
  fileName:String;
  iCount,limit,i,k: Integer;
  tmp1 : Single;
  XLApp: variant;
  Sheet: Variant;
begin
  btn_OutPortModel.Enabled := false;
   if label1.Caption=''   then
    begin
        showmessage('��ѡ����ģ��');
        exit;
    end;

   if OpenDialog1.Execute then  fileName:=OpenDialog1.FileName else exit;
   Screen.Cursor := crHourGlass;
   if not VarIsEmpty(XLApp) then
   begin
        XLApp.DisplayAlerts := False;
        XLApp.Quit;
        VarClear(XLApp);
   end;
   try
        XLApp := CreateOleObject('Excel.Application');
        limit := 0;
   except
        Screen.Cursor := crDefault;
        Exit;
   end;
   k := StringGrid1.ColCount;
  try
       XLApp.workBooks.Open(fileName);
       Sheet := XLApp.Workbooks[1].WorkSheets[1];
       for iCount:=1 to 50000 do
       begin
                 if (trim(XLApp.workbooks[1].sheets[1].cells[iCount,1]) <> '')
                 and (trim(XLApp.workbooks[1].sheets[1].cells[iCount,2]) <> '') then
                 begin
                    for i:=0 to k-1 do  //�ӵ�0�п�ʼ,�������
                    begin
                      stringgrid1.Cells[i,iCount+1] := trim(XLApp.workbooks[1].sheets[1].cells[iCount,i+1]);  //����ͷ
                    end;
                    stringgrid1.RowCount := iCount+2;
                    Label_rowcount.Caption :='��������:'+inttostr(iCount-1);
                    application.ProcessMessages;
                 end
                 else begin
                       Inc(limit);
                       if limit >= 6 then
                       Break;
                 end;
       end;
       XLApp.workbooks[1].close;
  finally
       XLApp.quit;
       Screen.Cursor := crDefault;
  end;
   stringgrid1.Refresh;
   stringgrid1.FixedRows := 3;
   StringGrid1.ColCount :=grid_col_count1+2;
   StringGrid1.Cells[grid_col_count1,0]:='����У��';
   StringGrid1.Cells[grid_col_count1+1,0]:='��ֵУ��';
   btn_check.Enabled := true;
   btn_import.Enabled := false;
   btn_Outport.Enabled := false;

end;

procedure TFrmImport.btn_checkClick(Sender: TObject);
var  i,j,k,flag : Integer;
     e: Extended;
     sql_string1,ssql: string;
     sql_string2: string;
     sql_string3: string;
     sql_string: string;
begin
     sql_string1:= ' if exists (select * from tempdb..sysobjects where name like '+
      QuotedStr('#employeesalary%')+' ) '
      +' drop table #employeesalary  '
      +' create table  #employeesalary(employeecode nvarchar(20),chinesename nvarchar(20),';
     sql_string2:='employeeidcheck int,resultcheck int,id int)';
     sql_string3:='';
     for  i:=2 to grid_col_count1-1 do
     begin
     sql_string3 := sql_string3+trim(stringgrid1.Cells[i,1])+' float, '
     end;
     sql_string := sql_string1+ sql_string3 + sql_string2;
     //ShowMessage(sql_string);
     dm.qry_temp.SQL.Clear;
     DM.qry_temp.SQL.Text := sql_string;
     try
      DM.qry_temp.ExecSQL;
     except
      ShowMessage('������ʱ��ʧ��,���ʧ��');
      Exit;
     end;
       sql_string1:='insert into #employeesalary(employeecode,chinesename,';
       sql_string2:='employeeidcheck,resultcheck,id)';
       sql_string3:='';
       for  i:=2 to grid_col_count1-1 do //��3������ģ��ԭ����
       begin
       sql_string3 := sql_string3+trim(stringgrid1.Cells[i,1])+', '
       end;
       sql_string:=sql_string1+ sql_string3 + sql_string2;

       for k:=3 to StringGrid1.RowCount-1 do // ������3
       begin
         DM.qry_temp.SQL.Clear;
         sql_string3:='';
         for i:=2 to StringGrid1.ColCount-3 do   //�����ӵ�3�п�ʼ��������3��
         begin
            sql_string3:=sql_string3+','+trim(stringgrid1.Cells[i,k])
         end;
         dm.qry_temp.SQL.Text := sql_string+#13
         +' Select '+ QuotedStr(trim(stringgrid1.Cells[0,k]))+','
         +QuotedStr(trim(stringgrid1.Cells[1,k]))+sql_string3+',0,0,'+inttostr(k);
         try
            flag :=0 ;
            for i:=2 to StringGrid1.ColCount-3 do //�Ե�����ʱ��֮ǰ,��ϵͳ�����ж��ܷ�תΪFLOAT��
            begin
              if TryStrToFloat(stringgrid1.Cells[i,k],e)    then
              flag := flag +0
              else flag := flag+1;
            end;
            if flag>0 then
            StringGrid1.Cells[grid_col_count1+1,k]:='X'
            else
            dm.qry_temp.ExecSQL;
         except
           StringGrid1.Cells[grid_col_count1+1,k]:='X';//��ֵ����
           Continue;
         end;

       end;
     dm.qry_temp.SQL.Clear;
     DM.qry_temp.SQL.Text:=' update #employeesalary '+
      ' set employeeidcheck=b.rkey  '+
      ' from #employeesalary a join  '+
      ' (select rkey,employeecode from employeemsg  ) b '+
      ' on a.employeecode=b.employeecode';
     try
       dm.qry_temp.ExecSQL;
     except  on e:exception do
       ShowMessage('����У�鲽��1ʧ��'+e.Message);
     end;
      dm.qry_temp.SQL.Clear;
      DM.qry_temp.SQL.Text:='select employeeidcheck,id from #employeesalary  ';//   where employeeidcheck=0
     try
      DM.qry_temp.Open;
      while not DM.qry_temp.Eof do
      begin
        i := DM.qry_temp.FieldValues['id'];
        stringgrid1.Cells[grid_col_count1,i] := inttostr(DM.qry_temp.FieldValues['employeeidcheck']);
        DM.qry_temp.Next;
      end;
      DM.qry_temp.Close;
     except on e:exception do
       ShowMessage('����У�鲽��2ʧ��'+e.message);
     end;
     dm.qry_temp.SQL.Clear;
      DM.qry_temp.SQL.Text:='select id from #employeesalary where employeeidcheck=0';//
     try
      DM.qry_temp.Open;
      while not DM.qry_temp.Eof do
      begin
        i := DM.qry_temp.FieldValues['id'];
        stringgrid1.Cells[grid_col_count1,i] :='X';
        stringgrid1.Cells[grid_col_count1+1,i] :='X';
        DM.qry_temp.Next;
      end;
      DM.qry_temp.Close;
     except   on e:exception do
       ShowMessage('����У�鲽��3ʧ��'+e.message);
     end;
     ssql:='drop table  #employeesalary  ';
     dm.ExecSQL(dm.qry_temp,ssql);

     //������
     StringGrid1.Refresh;
     ShowMessage('������');
     btn_import.Enabled := true;
     btn_outport.Enabled := true;

end;

procedure TFrmImport.btn_importClick(Sender: TObject);
begin
  if stringgrid1.RowCount<4   then
  begin
    showmessage('�޼�������');
    exit;
  end;
  if Messagedlg('��ȷ�����빤�����ݵ� '+s_yearmonth+' �·���?',mtWarning,[mbYES,mbNO],0)=6 then
    DBupdate;

end;
procedure TFrmImport.DBupdate;
var i,j,k :Integer;
    sqlstring1,sqlstring2,sqlstring3,sqlstring,ssql : string;
begin
  try
  for i:=3 to StringGrid1.RowCount-1 do
  begin
    if stringgrid1.Cells[grid_col_count1+1,i] = 'X' then
    begin
      Continue;
    end
    else
    begin
      sqlstring2 :='';
      if checkbox1.Checked = false then
          sqlstring1 := 'update employeesalary set '
      else
         sqlstring1 := 'update employeesalary set can_change_flag=1,';
         //�䶯ֵ�Ƿ�����
      if  checkbox2.Checked = false then
        sqlstring3 := ' from employeesalary where employeeid='+
        stringgrid1.Cells[grid_col_count1,i]+
        ' and yearmonth='+QuotedStr(s_yearmonth)
      else
         sqlstring3 := ' from employeesalary where employeeid='+
        stringgrid1.Cells[grid_col_count1,i]+
        ' and yearmonth='+QuotedStr(s_yearmonth)+
        ' and accountid='+label_accountid.Caption;
        //�����Ƿ�Ҫƥ��
       for j:=2 to grid_col_count1-1 do
       begin
          if sqlstring2<>'' then
          sqlstring2 := sqlstring2+','+trim(stringgrid1.Cells[j,1])+'='+
          Trim(stringgrid1.Cells[j,i])
          else
           sqlstring2 :=trim(stringgrid1.Cells[j,1])+'='+
          Trim(stringgrid1.Cells[j,i]);
       end;
       sqlstring := sqlstring1+sqlstring2+sqlstring3;
       try
         
         DM.ExecSQL(dm.qry_temp,sqlstring);
         StringGrid1.Cells[grid_col_count1+1,i]:= '�� ';//���е���ɹ������
         
       except
         StringGrid1.Cells[grid_col_count1+1,i]:= 'X';//���е���ʧ�������
         Continue;
       end;
    end;
  end;
  ShowMessage('�������');

 except on e:exception do
 begin
 ShowMessage('����'+e.Message);
 exit;
 end;
end;


end;


procedure TFrmImport.btn_OutportClick(Sender: TObject);
begin
Export_Grid_to_Excel(stringgrid1,'������') ;
end;

end.
