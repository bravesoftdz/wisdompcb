unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, Grids, DBGrids,DateUtils,math,
  ComObj,Excel2000,ClipBrd, DB, ADODB, Menus, ComCtrls;

type
  TForm1 = class(TForm)
    BitBtn1: TBitBtn;
    Panel1: TPanel;
    DBGrid1: TDBGrid;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    ProgressBar1: TProgressBar;
    N8: TMenuItem;
    N9: TMenuItem;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure N1Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure N9Click(Sender: TObject);
    procedure N8Click(Sender: TObject);
  private
    { Private declarations }
   command_sql:widestring;
   v_colwidth: array of integer;
   dbgrid2_coltotal:integer;

   OldGridWnd : TWndMethod;
   procedure CopyDbDataToExcel(Args:array of const);
   procedure NewGridWnd (var Message : TMessage);
   function get_systemdate():tdatetime;
   function get_data444rkey(cut_date:tdatetime):integer;
   function get_MATL_DATE444(cut_date: tdatetime): tdatetime;
   function get_FG_DATE444(cut_date: tdatetime): tdatetime;
   function get_WIP_DATE444(cut_date: tdatetime): tdatetime;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses damo, term, select_calculate, status_bar, Unit_expense,common;

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  if not App_Init(dm.ADOConnection1) then
  begin
    ShowMsg('��������ʧ�ܣ�����ϵϵͳ����Ա��','��ʾ',1);
    application.Terminate;
  end;

  self.Caption :=Application.Title;

  {user_ptr:='5';
  vprev:='4';
  dm.ADOConnection1.Open;}

  DateSeparator := '-';
  ShortDateFormat := 'yyyy-mm-dd';
 OldGridWnd := DBGrid1.WindowProc;
 DBGrid1.WindowProc := NewGridWnd;
end;

function TForm1.get_systemdate: tdatetime;
begin
with dm.ADOQuery1 do
begin
 close;
 sql.Text:='select getdate() as sys_date';
 open;
 result:=fieldvalues['sys_date'];
end;
end;

function TForm1.get_data444rkey(cut_date: tdatetime): integer;
begin
with dm.ADOQuery1 do
begin
 close;
 sql.Text:='select rkey from data0444'+#13+
 'where cut_date='''+datetostr(cut_date)+'''';
 open;
 if not IsEmpty then
  result:=fieldvalues['rkey']
 else
  result:=0;
end;
end;

function TForm1.get_MATL_DATE444(cut_date: tdatetime): tdatetime;
begin
with dm.ADOQuery1 do
begin
 close;
 sql.Text:='select MATL_DATE from data0444'+#13+
 'where cut_date='''+datetostr(cut_date)+'''';
 open;
 if not IsEmpty then
  result:=fieldvalues['MATL_DATE']
 else
  result:=null;
end;
end;

function TForm1.get_FG_DATE444(cut_date: tdatetime): tdatetime;
begin
with dm.ADOQuery1 do
begin
 close;
 sql.Text:='select FG_DATE from data0444'+#13+
 'where cut_date='''+datetostr(cut_date)+'''';
 open;
 if not IsEmpty then
  result:=fieldvalues['FG_DATE']
 else
  result:=null;
end;
end;

function TForm1.get_WIP_DATE444(cut_date: tdatetime): tdatetime;
begin
with dm.ADOQuery1 do
begin
 close;
 sql.Text:='select WIP_DATE from data0444'+#13+
 'where cut_date='''+datetostr(cut_date)+'''';
 open;
 if not IsEmpty then
  result:=fieldvalues['WIP_DATE']
 else
  result:=null;
end;
end;

procedure TForm1.NewGridWnd(var Message: TMessage);
var
 IsNeg : Boolean;
begin
 if Message.Msg = WM_MOUSEWHEEL then
 begin
   IsNeg := Short(Message.WParamHi) < 0;
   if IsNeg then
     DBGrid1.DataSource.DataSet.MoveBy(1)
   else
     DBGrid1.DataSource.DataSet.MoveBy(-1)
 end
 else
   OldGridWnd(Message);
end;

procedure Tform1.CopyDbDataToExcel(Args:array of const);
var
 iCount, jCount, v_cloumn: Integer;
 XLApp: Variant;
 Sheet: Variant;
 I: Integer;
begin
 Screen.Cursor := crHourGlass;
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
 XLApp.SheetsInNewWorkbook := High(Args) + 1;

 for I := Low(Args) to High(Args) do
 begin
   XLApp.WorkBooks[1].WorkSheets[I+1].Name := self.Caption;
   Sheet := XLApp.Workbooks[1].WorkSheets[self.Caption];
   if not TDBGrid(Args[I].VObject).DataSource.DataSet.Active then
    begin
     Screen.Cursor := crDefault;
     Exit;
    end;
   TDBGrid(Args[I].VObject).DataSource.DataSet.DisableControls;
   TDBGrid(Args[I].VObject).DataSource.DataSet.first;

   v_cloumn:=0;
   for iCount := 0 to TDBGrid(Args[I].VObject).Columns.Count - 1 do
    if TDBGrid(Args[I].VObject).Columns.Items[iCount].Visible=true then
     Sheet.Cells[1, iCount + 1 - v_cloumn] :=
     TDBGrid(Args[I].VObject).Columns.Items[iCount].Title.Caption
    else
     inc(v_cloumn);

   jCount := 1;
   while not TDBGrid(Args[I].VObject).DataSource.DataSet.Eof do
   begin
     v_cloumn:=0;
     for iCount := 0 to TDBGrid(Args[I].VObject).Columns.Count - 1 do
      if TDBGrid(Args[I].VObject).Columns.Items[iCount].Visible=true then
       Sheet.Cells[jCount + 1, iCount + 1 - v_cloumn] :=
       TDBGrid(Args[I].VObject).Columns.Items[iCount].Field.AsString
      else
       inc(v_cloumn);
     Inc(jCount);
     TDBGrid(Args[I].VObject).DataSource.DataSet.Next;
   end;

   XlApp.Visible := True;
   TDBGrid(Args[I].VObject).DataSource.DataSet.EnableControls;
 end;
 Screen.Cursor := crDefault;
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
close;
application.Terminate;
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
var
 rkey:integer;
begin
 rkey:=dm.AqD451RKEY.Value;
 dm.AqD451.Close;
 dm.AqD451.Open;
 if rkey>0 then
  dm.AqD451.Locate('rkey',rkey,[]);
end;

procedure TForm1.BitBtn3Click(Sender: TObject);
begin
CopyDbDataToExcel([dbgrid1]);
end;


procedure TForm1.FormShow(Sender: TObject);
var
 i:byte;
begin
 if dm.ADOConnection1.Connected then
  begin
   command_sql:=dm.AqD451.CommandText;
   dm.AqD451.Close;
   dm.AqD451.CommandText:=dm.AqD451.CommandText+
   'and year(Data0451.closed_date) = '+inttostr(yearof(date()))+#13;
   dm.AqD451.Open;
   with form_condition do
   begin
    sgrid1.Cells[0,sgrid1.RowCount-1]:=listbox3.Items[0];
    sgrid1.Cells[2,sgrid1.RowCount-1]:='and year(Data0451.closed_date) = '+inttostr(yearof(date()));
    sgrid1.Cells[1,sgrid1.RowCount-1]:=inttostr(yearof(date()));
    sgrid1.RowCount:=sgrid1.RowCount+1;
   end;

   dbgrid2_coltotal:=dbgrid1.Width;
   setlength(v_colwidth,dbgrid1.FieldCount);
   for i:=0 to high(v_colwidth) do v_colwidth[i] := dbgrid1.Columns[i].Width;
  end;
end;

procedure TForm1.FormResize(Sender: TObject);
var
 i:byte;
begin
for i:=low(v_colwidth) to high(v_colwidth) do
 dbgrid1.Columns[i].Width:=v_colwidth[i]+
  round((dbgrid1.Width-dbgrid2_coltotal)*v_colwidth[i]/(dbgrid2_coltotal-28));
end;

procedure TForm1.BitBtn4Click(Sender: TObject);
var
 i:byte;
begin

if form_condition.ShowModal=mrok then
 begin
  dm.AqD451.Close;
  dm.AqD451.CommandText:=self.command_sql;
  for i:=1 to form_condition.SGrid1.RowCount-2 do
   dm.AqD451.CommandText:=dm.AqD451.CommandText+
   form_condition.SGrid1.Cells[2,i]+#13;
  dm.AqD451.Open;
 end;

end;

procedure TForm1.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if (chr(key)='V') and (ssalt in shift) then
  showmessage(dm.AqD451.CommandText);
end;

procedure TForm1.N1Click(Sender: TObject);
var
 star_datetime:tdatetime;
 rkey:integer;
begin
 try
  Application.CreateForm(Tform2, form2);
  if form2.ShowModal=mrok then
  begin
   dm.ADOConnection1.BeginTrans;
   try
   screen.Cursor:= crHourGlass;
   form3:=tform3.Create(application);
   form3.Show;

   star_datetime:=now;
   dm.ADO451.Close;
   dm.ADO451.Parameters.ParamByName('rkey').Value:=null;
   dm.ADO451.Open;
   dm.ADO451.Append;
   dm.ADO451FM_DATE.Value:=strtodate(form2.edit1.text);
   dm.ADO451END_DATE.Value:=strtodate(form2.edit2.text);
   dm.ADO451ACTUAL_FM_DATE.AsString:=form2.Label2.Caption;
   dm.ADO451ACTUAL_END_DATE.AsString:=form2.Label4.Caption;
   dm.ADO451CLOSED_BY.AsString:=user_ptr;
   dm.ADO451CLOSED_DATE.Value:=self.get_systemdate;
   dm.ADO451.Post;        //1���Ӻ����ڼ�
   progressbar1.Position:=10;
   form3.Label1.Caption:='��һ��:���㲿���ܹ�ʱ...';
   form3.Label9.Caption:='10';
   form3.Label5.Caption:=inttostr(SecondsBetween(now,star_datetime) div 60);
   form3.Label6.Caption:=inttostr(SecondsBetween(now,star_datetime) mod 60);
   form3.Refresh;

   with dm.aqdupdate do
   begin
    close;
    ProcedureName:='wzpr451;99';        //���㲿���ܹ�ʱ
    Parameters.Refresh;
    parameters.ParamValues['@rkey444_fm_date']:=get_data444rkey(dm.ADO451FM_DATE.Value);
    parameters.ParamValues['@rkey444_end_date']:=get_data444rkey(dm.ADO451END_DATE.Value);
    parameters.ParamValues['@fm_date']:=get_WIP_DATE444(dm.ADO451FM_DATE.Value);
    parameters.ParamValues['@end_date']:=get_WIP_DATE444(dm.ADO451END_DATE.Value);
    parameters.ParamValues['@rkey451']:=dm.ADO451RKEY.Value;
    ExecProc;
   end;

   progressbar1.Position:=20;
   form3.Label1.Caption:='�ڶ���:����ֿ���Ͻ�����...';
   form3.Label9.Caption:='20';
   form3.Label5.Caption:=inttostr(SecondsBetween(now,star_datetime) div 60);
   form3.Label6.Caption:=inttostr(SecondsBetween(now,star_datetime) mod 60);
   form3.Refresh;
  //========================================================================
   with dm.aqdupdate do
   begin
    close;//12���Ӽ������ڳ����,�������,���ڷ���,����,�˻�,�̵����,��ĩ�������(446)
    ProcedureName:='wzpr451;2';        //���Ͻ�����ƽ���
    Parameters.Refresh;
    parameters.ParamValues['@rkey444_fm_date']:=get_data444rkey(dm.ADO451FM_DATE.Value);
    parameters.ParamValues['@rkey444_end_date']:=get_data444rkey(dm.ADO451END_DATE.Value);
    parameters.ParamValues['@fm_date']:=get_MATL_DATE444(dm.ADO451FM_DATE.Value);
    parameters.ParamValues['@end_date']:=get_MATL_DATE444(dm.ADO451END_DATE.Value);
    parameters.ParamValues['@rkey451']:=dm.ADO451RKEY.Value;
    ExecProc;
   end;

   progressbar1.Position:=30;
   form3.Label1.Caption:='������:�鼯����������ϸ��...';
   form3.Label9.Caption:='30';
   form3.Label5.Caption:=inttostr(SecondsBetween(now,star_datetime) div 60);
   form3.Label6.Caption:=inttostr(SecondsBetween(now,star_datetime) mod 60);
   form3.Refresh;
  //==========================================================================
   with dm.aqdupdate do
   begin
    close;
    ProcedureName:='wzpr451;3';
    Parameters.Refresh;
    parameters.ParamValues['@fm_date']:=dm.ADO451ACTUAL_FM_DATE.Value;
    parameters.ParamValues['@end_date']:=dm.ADO451ACTUAL_END_DATE.Value;
    parameters.ParamValues['@rkey451']:=dm.ADO451RKEY.Value;
    ExecProc;
   end;

   progressbar1.Position:=45;
   form3.Label1.Caption:='���Ĳ�:�鼯�������Ļ��ܱ�...';
   form3.Label9.Caption:='45';
   form3.Label5.Caption:=inttostr(SecondsBetween(now,star_datetime) div 60);
   form3.Label6.Caption:=inttostr(SecondsBetween(now,star_datetime) mod 60);
   form3.Refresh;
  //==========================================================================
   with dm.aqdupdate do
   begin
    close;
    ProcedureName:='wzpr451;4';
    Parameters.Refresh;
    parameters.ParamValues['@rkey451']:=dm.ADO451RKEY.Value;
    ExecProc;
   end;

   progressbar1.Position:=60;
   form3.Label1.Caption:='���岽:�鼯�ֿ��Ʒ������ƽ���...';
   form3.Label9.Caption:='60';
   form3.Label5.Caption:=inttostr(SecondsBetween(now,star_datetime) div 60);
   form3.Label6.Caption:=inttostr(SecondsBetween(now,star_datetime) mod 60);
   form3.Refresh;
  //==========================================================================
   with dm.aqdupdate do
   begin//21���Ӽ����³�Ʒ�ڳ����,�������,���ڷ���,ת��,����,�̵����,��ĩ�������(372)
    close;                     //��Ʒ������ƽ���
    ProcedureName:='wzpr451;7';
    Parameters.Refresh;
    parameters.ParamValues['@rkey444_fm_date']:=get_data444rkey(dm.ADO451FM_DATE.Value);
    parameters.ParamValues['@rkey444_end_date']:=get_data444rkey(dm.ADO451END_DATE.Value);
    parameters.ParamValues['@fm_date']:=get_FG_DATE444(dm.ADO451FM_DATE.Value);
    parameters.ParamValues['@end_date']:=get_FG_DATE444(dm.ADO451END_DATE.Value);
    parameters.ParamValues['@rkey451']:=dm.ADO451RKEY.Value;
    ExecProc;
   end;
   progressbar1.Position:=80;
   form3.Label1.Caption:='������:�鼯����Ʒ������ƽ���...';
   form3.Label9.Caption:='80';
   form3.Label5.Caption:=inttostr(SecondsBetween(now,star_datetime) div 60);
   form3.Label6.Caption:=inttostr(SecondsBetween(now,star_datetime) mod 60);
   form3.Refresh;
  //==========================================================================
   with dm.aqdupdate do
   begin
    close;
    ProcedureName:='wzpr451;100';
    Parameters.Refresh;
    parameters.ParamValues['@rkey444_fm_date']:=get_data444rkey(dm.ADO451FM_DATE.Value);
    parameters.ParamValues['@rkey444_end_date']:=get_data444rkey(dm.ADO451END_DATE.Value);
    parameters.ParamValues['@fm_date']:=get_WIP_DATE444(dm.ADO451FM_DATE.Value);
    parameters.ParamValues['@end_date']:=get_WIP_DATE444(dm.ADO451END_DATE.Value);
    parameters.ParamValues['@rkey451']:=dm.ADO451RKEY.Value;
    ExecProc;
   end;
   progressbar1.Position:=99;
  //==========================================================================
   dm.ADOConnection1.CommitTrans;
   rkey:=dm.ADO451RKEY.Value;
   dm.ADOConnection1.Connected:=false;
   dm.ADOConnection1.Connected:=true;
   dm.AqD451.Close;
   dm.AqD451.Open;
   dm.AqD451.Locate('rkey',rkey,[]);
   dm.ADO451.Close;
   dm.aqdupdate.Close;
   dm.ADOQuery1.Close;

   screen.Cursor:= crDefault;
   form3.Label1.Caption:='���...';
   form3.Label9.Caption:='100';
   form3.Label5.Caption:=inttostr(SecondsBetween(now,star_datetime) div 60);
   form3.Label6.Caption:=inttostr(SecondsBetween(now,star_datetime) mod 60);
   form3.Update;
   form3.Free;

   progressbar1.Position:=0;
   messagedlg('�ڼ�ɱ��������!',mtinformation,[mbok],0)
   except
    on E: Exception do
     begin
      dm.ADOConnection1.RollbackTrans;
      messagedlg(E.Message,mterror,[mbcancel],0);
      screen.Cursor:= crDefault;
      form3.Free;
     end;
   end;
  end;
 finally
  form2.Free;
 end;
end;

procedure TForm1.N2Click(Sender: TObject);
var
 star_datetime:tdatetime;
begin
 if not dm.AqD451.Active then Exit;
 OpenQuery(dm.tmp,'select * from Data0424 where D0451_PTR = '+dm.AqD451RKEY.AsString);
 if (dm.tmp.RecordCount > 0) and //�����ǰ�Ѻ��㶩���ɱ�
 (messagedlg('�����ܹ�ʱ��ǰ�Ѻ�����Ƿ�����?',
    mtconfirmation,[mbYes,mbNo],0)=mrNo) then exit;
 if messagedlg('��ȷ��ֱ���˹���������Ƿ��Ѿ�����?',mtconfirmation,[mbYes,mbNo],0)=mrYes then
 begin
   dm.ADOConnection1.BeginTrans;
   try
     screen.Cursor:= crSqlwait;
     with dm.aqdupdate do
     begin
      close;
      ProcedureName:='wzpr451;99';        //���㲿���ܹ�ʱ
      Parameters.Refresh;
      parameters.ParamValues['@rkey444_fm_date']:=get_data444rkey(dm.AqD451FM_DATE.Value);
      parameters.ParamValues['@rkey444_end_date']:=get_data444rkey(dm.AqD451END_DATE.Value);
      parameters.ParamValues['@fm_date']:=get_WIP_DATE444(dm.AqD451FM_DATE.Value);
      parameters.ParamValues['@end_date']:=get_WIP_DATE444(dm.AqD451END_DATE.Value);
      parameters.ParamValues['@rkey451']:=dm.AqD451RKEY.Value;
      ExecProc;
     end;
     with dm.ADOQuery1 do
     begin
      close;
      sql.Text:='update data0444'+#13+
      'set CLOSED=''Y'''+#13+
       'where rkey='+inttostr(get_data444rkey(dm.AqD451FM_DATE.Value))+#13+
       'and closed=''N''';
      ExecSQL;          //�޸��ڳ�����Ϊ�Ѻ���(����Ѻ����������޸�)
     end;
     with dm.ADOQuery1 do
     begin
      close;
      sql.Text:='update data0444'+#13+
      'set CLOSED=''Y'''+#13+
       'where rkey='+inttostr(get_data444rkey(dm.AqD451END_DATE.Value));
      ExecSQL;          //�޸���ĩ����Ϊ�Ѻ���
     end;
     dm.ADOQuery1.Close;
     dm.ADOConnection1.CommitTrans;
     screen.Cursor:= crDefault;
     bitbtn2click(sender);
     messagedlg('�������!',mtinformation,[mbok],0);
   except
     on E: Exception do
     begin
       dm.ADOConnection1.RollbackTrans;
       screen.Cursor:= crDefault;
       messagedlg(E.Message,mterror,[mbcancel],0);
     end;
   end;
 end;
end;

procedure TForm1.N3Click(Sender: TObject);

begin
if dm.AqD451CLOSED_BY.Value<>StrToInt(user_ptr) then
 begin
   showmsg('ֻ�ܴ����߱��˲���ɾ�������¼!',1);
   exit;
 end;

 with dm.tmp do
  begin
   close;
   sql.Text:='SELECT max(rkey) as max_rkey FROM Data0451';
   open;
  end;

if DM.tmp.FieldByName('max_rkey').AsInteger=DM.AqD451RKEY.Value then
if messagedlg('ȷ��Ҫɾ����'+dm.AqD451no.AsString+'��ɱ����㵵����?',mtconfirmation,[mbYes,mbNo],0)=mrYes then
 try
 dm.ADOConnection1.BeginTrans;
 screen.Cursor:=  crappstart;
 with dm.ADOQuery1 do
 begin
  close;
  sql.Text:='update data0444'+#13+
  'set CLOSED=''N'''+#13+
   'where rkey='+inttostr(get_data444rkey(dm.AqD451END_DATE.Value));
  ExecSQL;          //�޸���ĩ����Ϊδ����
 end;

 with dm.ADOQuery1 do
 begin
  close;
  sql.Text:='delete data0451 where rkey='+dm.AqD451RKEY.AsString;
  ExecSQL;
 end;
 dm.ADOConnection1.CommitTrans;
 screen.Cursor:=  crDefault;
 messagedlg('�����ڼ䱻�ɹ�ɾ��!',mtinformation,[mbok],0);
 dm.AqD451.Close;
 dm.AqD451.Open;
 except
  on E: Exception do
   begin
    dm.ADOConnection1.RollbackTrans;
    messagedlg(E.Message,mterror,[mbcancel],0);
   end;
 end
else
else
 showmsg('�����¼��ɾ����ֻ�ܴӲ������һ�ʼ�¼!',1);
end;

procedure TForm1.PopupMenu1Popup(Sender: TObject);
begin
if dm.AqD451.IsEmpty then
 begin
  n2.Enabled:=false;
  n3.Enabled:=false;
  n8.Enabled:=false;
  n9.Enabled:=false;
 end
else
 begin
  n2.Enabled:=true;
  n3.Enabled:=true;
  n9.Enabled:=true;
  if dm.AqD451CLOSED.Value='N' then
   n8.Enabled:=true
  else
   n8.Enabled:=false;
 end;  
end;

procedure TForm1.N9Click(Sender: TObject);
begin
  try
   form_expense:=tform_expense.Create(application);
   form_expense.BitBtn1.Enabled:=false;
   form_expense.BitBtn2.Enabled:=false;
   form_expense.BitBtn5.Enabled:=false;
   form_expense.DBGridEh1.ReadOnly:=true;
   form_expense.ShowModal;
   dm.ADOD424.Close;   
  finally
   form_expense.Free;
  end;
end;

procedure TForm1.N8Click(Sender: TObject);
begin
  try
   form_expense:=tform_expense.Create(application);
   form_expense.ShowModal;
   dm.ADOD424.Close;
  finally
   form_expense.Free;
  end;
end;

end.
