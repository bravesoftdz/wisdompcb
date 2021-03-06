unit uMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, StdCtrls, ExtCtrls, Buttons, Menus,common,ComObj,
  DBGridEh, DBCtrls,ActnList,DB, AppEvnts;

type
  Tmain = class(TForm)
    Panel1: TPanel;
    vpass: TLabel;
    BitBtn1: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn6: TBitBtn;
    PopupMenu1: TPopupMenu;
    N15: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    BtBrush: TBitBtn;
    BitBtn2: TBitBtn;
    N4: TMenuItem;
    N5: TMenuItem;
    PopupMenu3: TPopupMenu;
    MenuItem1: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N14: TMenuItem;
    N17: TMenuItem;
    FA1: TMenuItem;
    edtFilter: TEdit;
    F2: TMenuItem;
    ApplicationEvents1: TApplicationEvents;
    Panel2: TPanel;
    Panel4: TPanel;
    DBGridEh1: TDBGridEh;
    DBMemo1: TDBMemo;
    Panel3: TPanel;
    PopupMenu2: TPopupMenu;
    N3: TMenuItem;
    Panel5: TPanel;
    DBGridEh2: TDBGridEh;
    N10: TMenuItem;
    FA2: TMenuItem;
    Label1: TLabel;
    Panel6: TPanel;
    DBGridEh3: TDBGridEh;
    Panel7: TPanel;
    Panel8: TPanel;
    DBMemo2: TDBMemo;
    Panel9: TPanel;
    DBMemo3: TDBMemo;
    Panel10: TPanel;
    DBMemo4: TDBMemo;
    Label9: TLabel;
    Label3: TLabel;
    lblFilter: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    N11: TMenuItem;
    N12: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure edtFilterChange(Sender: TObject);
    procedure BtBrushClick(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DBGrid1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure DBGridEh2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure DBGridEh2TitleClick(Column: TColumnEh);
    procedure item_click(sender: TObject);
    procedure DBGridEh2DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure DBGridEh2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGridEh1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ApplicationEvents1Message(var Msg: tagMSG;
      var Handled: Boolean);
    procedure N15Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure F2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure DBGridEh3DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure PopupMenu2Popup(Sender: TObject);
    procedure N10Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure PopupMenu3Popup(Sender: TObject);
    procedure FA1Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure N11Click(Sender: TObject);
    procedure N12Click(Sender: TObject);
  

   private
   field_name:string;
   PreColumn: TColumnEh;
   paixu2:string;
   procedure init;
    { Private declarations }
  public
  sqltext :string;
  procedure CopyDbDataToExcel(Args:array of const);
    { Public declarations }
  end;

var
  main: Tmain;
  last_check_dept :Integer;
  last_check_deptindex :Integer;
  last_d746_rkey :Integer;
  people_department: Integer; //操作员部门
  rkey,rkey745:Integer;

implementation
uses  uDM,u_frmbusinessprocess,frm_edit_u,frm_new_u, frm_check_u,
  DEPT_Edit, DEPT_Check, uShenhe,so_report, Unit_remser,Pick_WorkShop,ADODB;

{$R *.dfm}

procedure Tmain.FormCreate(Sender: TObject);
begin
if not app_init(dm.ADOConnection1) then
  begin
    common.ShowMsg('程序启动失败,请联系系统管理员',1);
    application.Terminate;
  end;

 { dm.ADOConnection1.Open;
  vprev:='4';
  user_ptr:='571';
  rkey73 := '1'; } 
  

  Caption := application.Title;


 init;
 end;

procedure Tmain.edtFilterChange(Sender: TObject);
begin


   if DBGridEh2.DataSource.DataSet.FieldByName(field_name).FieldKind = fkCalculated then  exit;
  if DBGridEh2.DataSource.DataSet.FieldByName(field_name).DataType in [ftString,ftWideString,ftSmallint,ftInteger]  then
  begin
    if trim(edtFilter.text) <> '' then
      begin
        if DBGridEh2.DataSource.DataSet.FieldByName(field_name).DataType in  [ftString, ftWideString]  then
          DBGridEh2.DataSource.DataSet.Filter:=' (' +  field_name + ' like ''%' + trim(edtFilter.text) + '%'')'
        else if DBGridEh2.DataSource.DataSet.FieldByName(field_name).DataType in  [ftSmallint, ftInteger]  then
          DBGridEh2.DataSource.DataSet.Filter:=' (' + field_name+' >= ' + inttostr(strtointdef(edtFilter.text,0))+')';
      end
    else
      DBGridEh2.DataSource.DataSet.Filter:='';
  end;


end;

procedure Tmain.BtBrushClick(Sender: TObject);
begin
dm.ADO0745.Close;
dm.ADO0745.CommandText:=self.sqltext;
dm.ADO0745.Open;
end;

procedure Tmain.BitBtn3Click(Sender: TObject);
begin
CopyDbDataToExcel([DBGridEh2]);
end;

procedure Tmain.BitBtn1Click(Sender: TObject);
begin
application.Terminate;
end;

procedure Tmain.CopyDbDataToExcel(Args:array of const);
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


procedure Tmain.BitBtn2Click(Sender: TObject);
begin
  if (strtoint(vprev)<>4)  then
   messagedlg('对不起!您没有定义流程可写权限',mtinformation,[mbok],0)
  else
 begin
 try
         frmbusinessprocess:=Tfrmbusinessprocess.Create(nil);
        if frmbusinessprocess.ShowModal=mrok then
          begin
          end;
      finally

          frmbusinessprocess.Free;
      end;
end;
end;

procedure Tmain.FormShow(Sender: TObject);
begin
 dm.ADO0745.Close;
 dm.ADO0745.Open;
 sqltext:=dm.ADO0745.CommandText;

 dm.ADO0745.Active := True;
 dm.ADO0746.Active := True;

 with  dm.ADO0746 do
 begin
 close;
 Parameters.ParamByName('rkey745').Value:=dm.ADO0745Rkey.Value;
 Open;
 end;

 with  dm.ADO0740 do
 begin
 close;
 Parameters.ParamByName('rkey745').Value:=dm.ADO0745Rkey.Value;
 Parameters.ParamByName('rkey25').Value:=dm.ADO0745RKEY25.Value;
 Open;
 end;





end;

procedure Tmain.DBGrid1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
{with  dm.ADO0743 do
  begin
  close;
  //Parameters.ParamByName('rkey738').Value:=dm.ADO0738Rkey.Value;
  Open;
  end;   }
end;

procedure Tmain.DBGridEh2MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin


 with  dm.ADO0746 do
  begin
  close;
  Parameters.ParamByName('rkey745').Value:=dm.ADO0745Rkey.Value;
  Open;
  end;

  with  dm.ADO0740 do
  begin
  close;
  Parameters.ParamByName('rkey745').Value:=dm.ADO0745Rkey.Value;
  Parameters.ParamByName('rkey25').Value:=dm.ADO0745RKEY25.Value;
  Open;
  end;


end;

procedure Tmain.DBGridEh2TitleClick(Column: TColumnEh);

begin
  if DBGridEh2.DataSource.DataSet.FieldByName(Column.FieldName).FieldKind = fkCalculated then  exit ;
  if (column.Title.SortMarker =smDownEh) or (column.Title.SortMarker =smNoneEh) then
    begin
      column.Title.SortMarker:=smUpEh;
      DM.ADO0745.Sort:=Column.FieldName;
    end
  else
    begin
      column.Title.SortMarker:=smDownEh;
      DM.ADO0745.Sort:=Column.FieldName+' DESC';
    end;
//  DM.ADO541AfterScroll(DM.ADO541);
  if DBGridEh2.DataSource.DataSet.FieldByName(Column.FieldName).DataType in [ftDate, ftTime, ftDateTime] then exit;
  if (field_name <> column.FieldName) then
    begin
      if
     (column.FieldName <> 'CreateDate')  and
     (column.FieldName <> 'QUAN_ON_HAND')  then
      lblFilter.Caption := column.Title.Caption ;
      field_name := column.FieldName ;
      edtFilter.SetFocus;
      PreColumn.Title.Color := clBtnFace ;
      Column.Title.Color := clred ;
      PreColumn :=column ;
      edtFilterChange(edtFilter);
    end
  else
    edtFilter.SetFocus;

end;

procedure Tmain.item_click(sender: TObject);
var
  i:byte;
begin
  (sender as tmenuItem).Checked := not ((sender as tmenuItem).Checked);
  if (sender as tmenuItem).Checked then
  begin
    for i := 0 to DBGridEh2.FieldCount - 1 do
    if DBGridEh2.Columns[i].Title.Caption = (sender as tmenuItem).Caption then
    begin
      DBGridEh2.Columns[i].Visible := true;
      break;
    end;
  end else begin
    for i := 0 to DBGridEh2.FieldCount - 1 do
    if DBGridEh2.Columns[i].Title.Caption = (sender as tmenuItem).Caption then
    begin
      DBGridEh2.Columns[i].Visible := false;
      break;
    end;
  end;
end;


procedure Tmain.init;
var  i:byte;
  item:TMenuItem;
begin
  field_name := DBGridEh2.Columns[0].FieldName;
  PreColumn := DBGridEh2.Columns[0];
  DBGridEh2.Columns[0].Title.Color := clred ;
  for i := 1 to DBGridEh2.Columns.Count do
    begin
      item := TmenuItem.Create(self);
      item.Caption := DBGridEh2.Columns[i - 1].Title.Caption;
      item.Checked :=DBGridEh2.Columns[i - 1].Visible ;
      item.OnClick := item_click ;
    //showmessage('ok');
  end;
end;


procedure Tmain.DBGridEh2DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
begin
    if dm.ADO0745check_status.AsInteger=0
   then  DBGridEh2.Canvas.Font.Color := clFuchsia;
    if dm.ADO0745check_status.AsInteger=1
   then  DBGridEh2.Canvas.Font.Color := clGreen;
      if dm.ADO0745check_status.AsInteger=2
   then  DBGridEh2.Canvas.Font.Color := clolive;
  DBGridEh2.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure Tmain.DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
begin
  if dm.DataSource4.DataSet.FieldByName('check_status').AsInteger = 1
  then DBGridEh1.Canvas.Font.Color := clmaroon;
  DBGridEh1.DefaultDrawColumnCell(Rect,DataCol,Column,State);
end;

procedure Tmain.DBGridEh2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
IF (ssalt in shift) and ((KEY=ORD('S')) OR (KEY=ORD('s')))
then showmessage(dm.ADO0745.CommandText);
end;

procedure Tmain.DBGridEh1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
IF (ssalt in shift) and ((KEY=ORD('S')) OR (KEY=ORD('s')))
then showmessage(dm.ADO0746.SQL.Text);
end;

procedure Tmain.ApplicationEvents1Message(var Msg: tagMSG;
  var Handled: Boolean);
begin
 if  (DBGridEh2.Focused)  And  (Msg.message  =  WM_MOUSEWHEEL)  then
       begin
           if  Msg.wParam  >  0  then    
               SendMessage(DBGridEh2.Handle,  WM_KEYDOWN,  VK_UP,  0)
           else
               SendMessage(DBGridEh2.Handle,  WM_KEYDOWN,  VK_DOWN,  0);
           Handled  :=  True;

           with  dm.ADO0746 do
           begin
           close;
           Parameters.ParamByName('rkey745').Value:=dm.ADO0745Rkey.Value;
           Open;
           end;

          with  dm.ADO0740 do
          begin
          close;
          Parameters.ParamByName('rkey745').Value:=dm.ADO0745Rkey.Value;
          Parameters.ParamByName('rkey25').Value:=dm.ADO0745RKEY25.Value;
          Open;
          end;
       end;
end;

procedure Tmain.N15Click(Sender: TObject);
begin
 if (strtoint(vprev)=1) or (strtoint(vprev)=3)  then
   messagedlg('对不起!您只有该程序的可读权限',mtinformation,[mbok],0)
  else
 begin
    try
        Frm_New:=TFrm_New.Create(application);
        dm.ADOD04.Active:=false;
        dm.ADOD04.Active:=true;
        Frm_New.edit1.Text:=dm.ADOD04.FieldValues['seed_value'];
        Frm_New.dt1.DateTime:=Now;
        Frm_New.Label67.Visible:=False;
        if dm.ADOD04SEED_FLAG.Value=3 then Frm_New.Edit1.ReadOnly:=false;
        if Frm_New.ShowModal=mrok then
          begin
            if not   dm.ADO0745.IsEmpty   then
            begin
            dm.ADO0745.Close;
            dm.ADO0745.Open;
            end
            else
            begin
            dm.ADO0745.Close;
            dm.ADO0745.Parameters[0].Value:='';
            dm.ADO0745.Open;
            end;
            dm.ADO0745.Locate('F_NUM',Frm_New.Edit1.text,[]);
          end;
      finally
        Frm_New.Free;
      end;
end;
end;

procedure Tmain.N1Click(Sender: TObject);
var
    rkey25:Integer;
    rkey10:Integer;
    rkey60:Integer;
begin
   if (strtoint(vprev)=1) or (strtoint(vprev)=3)  then
   messagedlg('对不起!您只有该程序的可读权限',mtinformation,[mbok],0)
  else
  begin
  try
  IF dm.ADO0745.IsEmpty then
  BEGIN
  showmessage('没有可编辑的资料!');
  Exit;
  end;

  Frm_Edit:=tFrm_Edit.Create(application);

  with Frm_Edit do
  begin
  Edit2.Enabled:=False;
  SpeedButton5.Enabled:=False;
  rkey25:=dm.ADO0745RKEY25.Value;
  rkey10:=dm.ADO0745RKEY10.Value;
  rkey60:=dm.ADO0745RKEY60.Value;

  with dm.ADOQuery1 do
  begin
  close;
  sql.Clear;
  SQL.Text:='select RKEY as rkey25,MANU_PART_NUMBER,MANU_PART_DESC from data0025 where RKEY='+quotedstr(inttostr(rkey25));
  open;
  end;

  with  dm.ADO0746 do
  begin
  close;
  Parameters.ParamByName('rkey745').Value:=dm.ADO0745Rkey.Value;
  Open;
  end;

  with dm.ADOTMP1 do
  begin
  close;
  sql.Clear;
  SQL.Text:='select RKEY as rkey10,ABBR_NAME from data0010 where RKEY='+quotedstr(inttostr(rkey10));
  open;
  end;

  with dm.ADOTMP2 do
  begin
  close;
  sql.Clear;
  SQL.Text:='select RKEY as rkey60,SALES_ORDER from data0060 where RKEY='+quotedstr(inttostr(rkey60));
  open;
  end;

  with  dm.QueryofbpTMP do
  begin
  close;
  Parameters.ParamByName('d741_ptr').Value:=dm.ADO0745check_type.AsString;
  Open;
  end;

  Edit1.text:=dm.ADO0745F_NUM.AsString;
  Edit1.Enabled:=False;
  Edit2.text:=dm.ADOQuery1.fieldbyname('MANU_PART_NUMBER').value;
  label67.Caption :=dm.ADOQuery1.fieldbyname('MANU_PART_DESC').value;
  label25.Caption:=dm.ADOQuery1.fieldbyname('rkey25').AsString;
  label10.Caption:=dm.ADOTMP1.fieldbyname('rkey10').AsString;
  Label60.Caption:=dm.ADOTMP2.fieldbyname('rkey60').AsString;
  Edit6.Text:=dm.ADOTMP2.fieldbyname('SALES_ORDER').AsString;
  Edit3.text:=dm.ADOTMP1.fieldbyname('ABBR_NAME').value;
  dt1.DateTime:=dm.ADO0745CreateDate.Value;
  edit4.Text :=dm.QueryofbpTMP.FieldValues['name'];
  Memo2.Text:=dm.ADO0745BEIZHU.Value;
  Edit5.Text:=dm.ADO0745QUAN_ON_HAND.AsString;
  Label_742deptstr.Caption :=dm.QueryofbpTMP.FieldValues['dept_name'];
  end;

  if Frm_Edit.ShowModal=mrok then
  begin
  dm.ADO0745.Edit;


  dm.ADO0745BEIZHU.Value:=Frm_Edit.Memo2.Text;
  dm.ADO0745RKEY25.Value:=StrToInt(Frm_Edit.Label25.caption);
  dm.ADO0745RKEY10.AsString:=Frm_Edit.Label10.caption;
  dm.ADO0745RKEY60.AsString:=Frm_Edit.Label60.caption;
  dm.ADO0745CreateDate.Value:=Frm_Edit.dt1.DateTime;
  dm.ADO0745QUAN_ON_HAND.AsString:=Frm_Edit.Edit5.Text;
  dm.ADO0745CreateDate.Value:=Frm_Edit.dt1.DateTime;

  if Frm_Edit.Label_741rkey.Caption<>'Label_741rkey' then
  dm.ADO0745check_type.AsString:=Frm_Edit.Label_741rkey.Caption;  // 审批流程rkey




  rkey745:=dm.ADO0745Rkey.Value;
  ShowMsg('编辑操作成功!',1);
  dm.ADO0745.Locate('Rkey',dm.ADO0745Rkey.Value,[]);

  end;

  finally
  Frm_Edit.Free;
  end;



end;
end;

procedure Tmain.F2Click(Sender: TObject);
var
    rkey25:Integer;
    rkey10:Integer;
    rkey60:Integer;
begin
  // if (strtoint(vprev)=1) or (strtoint(vprev)=3)  then
  // messagedlg('对不起!您只有该程序的可读权限',mtinformation,[mbok],0)
 // else
 // begin
  try
  IF dm.ADO0745.IsEmpty then
  BEGIN
  showmessage('没有可检查的资料!');
  Exit;
  end;

  Frm_Check:=tFrm_Check.Create(application);

  with Frm_Check do
  begin
  rkey25:=dm.ADO0745RKEY25.Value;
  rkey10:=dm.ADO0745RKEY10.Value;
  rkey60:=dm.ADO0745RKEY60.Value;

  with dm.ADOQuery1 do
  begin
  close;
  sql.Clear;
  SQL.Text:='select RKEY as rkey25,MANU_PART_NUMBER,MANU_PART_DESC from data0025 where RKEY='+quotedstr(inttostr(rkey25));
  open;
  end;

  with  dm.ADO0746 do
  begin
  close;
  Parameters.ParamByName('rkey745').Value:=dm.ADO0745Rkey.Value;
  Open;
  end;

  with dm.ADOTMP1 do
  begin
  close;
  sql.Clear;
  SQL.Text:='select RKEY as rkey10,ABBR_NAME from data0010 where RKEY='+quotedstr(inttostr(rkey10));
  open;
  end;

  with dm.ADOTMP2 do
  begin
  close;
  sql.Clear;
  SQL.Text:='select RKEY as rkey60,SALES_ORDER from data0060 where RKEY='+quotedstr(inttostr(rkey60));
  open;
  end;

  with  dm.QueryofbpTMP do
  begin
  close;
  Parameters.ParamByName('d741_ptr').Value:=dm.ADO0745check_type.AsString;
  Open;
  end;

  Edit1.text:=dm.ADO0745F_NUM.AsString;
  Edit1.Enabled:=False;
  Edit2.text:=dm.ADOQuery1.fieldbyname('MANU_PART_NUMBER').value;
  label67.Caption :=dm.ADOQuery1.fieldbyname('MANU_PART_DESC').value;
  label25.Caption:=dm.ADOQuery1.fieldbyname('rkey25').AsString;
  label10.Caption:=dm.ADOTMP1.fieldbyname('rkey10').AsString;
  Label60.Caption:=dm.ADOTMP2.fieldbyname('rkey60').AsString;
  Edit6.Text:=dm.ADOTMP2.fieldbyname('SALES_ORDER').AsString;
  Edit3.text:=dm.ADOTMP1.fieldbyname('ABBR_NAME').value;
  dt1.DateTime:=dm.ADO0745CreateDate.Value;
  edit4.Text :=dm.QueryofbpTMP.FieldValues['name'];
  Memo2.Text:=dm.ADO0745BEIZHU.Value;
  Edit5.Text:=dm.ADO0745QUAN_ON_HAND.AsString;
  Label_742deptstr.Caption :=dm.QueryofbpTMP.FieldValues['dept_name'];

  //锁定
  Edit2.Enabled:=False;
  Edit3.Enabled:=False;
  Edit4.Enabled:=False;
  Edit5.Enabled:=False;
  Edit6.Enabled:=False;
  dt1.Enabled:=False;
  SpeedButton5.Enabled:=False;
  SpeedButton4.Enabled:=False;
  SpeedButton3.Enabled:=False;
  SpeedButton6.Enabled:=False;
  SpeedButton1.Enabled:=False;
  Memo2.Enabled:=False;
  Frm_Check.ShowModal;
  end;
  finally
  Frm_Check.Free;
  end;

//end;
end;

procedure Tmain.N3Click(Sender: TObject);
begin
  if (strtoint(vprev)=1) or (strtoint(vprev)=3)  then
   messagedlg('对不起!您只有该程序的可读权限',mtinformation,[mbok],0)
  else
  begin
  try
  IF dm.ADO0740.IsEmpty then
  BEGIN
  showmessage('没有可编辑的资料!');
  Exit;
  end;

    FrmDEPT_Edit:=tFrmDEPT_Edit.Create(application);
    with  FrmDEPT_Edit do
    begin
    Memo1.Text:=VarToStrDef(dm.ADO0740.fieldbyname('DifficultPoint').Value,'');
    Memo2.Text:=VarToStrDef(dm.ADO0740.fieldbyname('BEIZHU').Value,'');
    Memo3.Text:=VarToStrDef(dm.ADO0740.fieldbyname('TestResult').Value,'');
    Edit1.Text:=dm.ADO0740.fieldbyname('DEPT_CODE').Value;
    end;

    if FrmDEPT_Edit.ShowModal<>mrok then
    begin
    dm.ADO0740.Edit;
    dm.ADO0740.fieldbyname('DifficultPoint').Value:=FrmDEPT_Edit.Memo1.Text;
    dm.ADO0740.fieldbyname('BEIZHU').Value:=FrmDEPT_Edit.Memo2.Text;
    dm.ADO0740.fieldbyname('TestResult').Value:=FrmDEPT_Edit.Memo3.Text;

    if (FrmDEPT_Edit.Memo1.Text<>'') or (FrmDEPT_Edit.Memo2.Text<>'') or  (FrmDEPT_Edit.Memo3.Text<>'') then
    ShowMsg('编辑操作成功!',1);

    dm.ADO0740.Locate('Rkey',dm.ADO0740Rkey.Value,[]);
    end;

    finally
    FrmDEPT_Edit.Free;
    end;
    end;

end;

procedure Tmain.DBGridEh3DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
begin
if dm.ADO0740DifficultPoint.value<>''
   then  DBGridEh3.Canvas.Font.Color := clFuchsia;

 if dm.ADO0740BEIZHU.value<>''
 then  DBGridEh3.Canvas.Font.Color := clFuchsia;

 if dm.ADO0740TestResult.value<>''
 then DBGridEh3.Canvas.Font.Color := clBlue;
  DBGridEh3.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure Tmain.PopupMenu2Popup(Sender: TObject);
begin

if not dm.ADO0740.IsEmpty then
begin
N11.Enabled:=True;
N12.Enabled:=True;
N10.Enabled:=True;
end
else
begin
N11.Enabled:=False;
N12.Enabled:=False;
N10.Enabled:=False;
end;







    if (dm.ADO0745check_status.AsInteger=2) and (not dm.ADO0740.IsEmpty)then
    begin
    N3.Enabled := false;
    end
    else
    N3.Enabled := True;



 if (dm.ADO0745check_status.AsInteger=2) and (not dm.ADO0740.IsEmpty)then
    begin
    N12.Enabled := false;
    end
    else
    N12.Enabled := True;



    if (dm.ADO0745check_status.AsInteger>0) and (not dm.ADO0740.IsEmpty)then
    begin
    N11.Enabled := false;
    end
    else
    N11.Enabled := True;  













end;
procedure Tmain.N10Click(Sender: TObject);
begin
try
  IF dm.ADO0740.IsEmpty then
  BEGIN
  showmessage('没有可编辑的资料!');
  Exit;
  end;

    FrmDEPTCheck:=tFrmDEPTCheck.Create(application);
    with  FrmDEPTCheck do
    begin
    Memo1.Text:=dm.ADO0740.fieldbyname('DifficultPoint').Value;
    Memo2.Text:=dm.ADO0740.fieldbyname('BEIZHU').Value;
    Memo3.Text:=dm.ADO0740.fieldbyname('TestResult').Value;
    Edit1.Text:=dm.ADO0740.fieldbyname('DEPT_CODE').Value;
    
    ShowModal
    end;
    dm.ADO0740.Locate('Rkey',dm.ADO0740Rkey.Value,[]);
    finally
    FrmDEPTCheck.Free;
    end;
end;

procedure Tmain.N2Click(Sender: TObject);
begin
  if (strtoint(vprev)<>4)  then
   messagedlg('对不起!您没有该程序的可写权限',mtinformation,[mbok],0)
  else
  begin
  IF dm.ADO0745.IsEmpty then
  BEGIN
  showmessage('没有可删除的资料!');
  Exit;
  end;

 if messagedlg('确定要删除该纪录吗?',mtconfirmation,[mbyes,mbno],0)=mryes then
 try
 dm.ADOConnection1.BeginTrans;

 with dm.ADODel do
 begin
 close;
 Parameters.ParamByName('rkey').Value:=dm.ADO0745Rkey.AsInteger;
 open;
 end;


 BtBrushClick(Sender);
 dm.ADOConnection1.CommitTrans;
 except
 on e :exception do
  begin
   dm.ADOConnection1.RollbackTrans;
   showmessage(e.Message);
  end;
 end;
end;
end;

procedure Tmain.N4Click(Sender: TObject);
var 
    circle :Integer;
    bptype: integer;
begin
   circle := dm.ADO0745circle.AsInteger;
    bptype := dm.ADO0745check_type.AsInteger;
     try
        Frm_Shenhe:=TFrm_Shenhe.Create(nil);
        Frm_Shenhe.Caption :='提交确认';
        Frm_Shenhe.Label2.Caption:=dm.ADO0745.FieldValues['F_NUM'];
        Frm_Shenhe.Label6.Caption:=dm.ADO0745.FieldValues['MANU_PART_NUMBER'];
        Frm_Shenhe.Label8.Caption:=dm.ADO0745.FieldValues['CUSTOMER_NAME'];
        Frm_Shenhe.Label4.Caption:='自审提交';
        Frm_Shenhe.RichEdit1.Text:=dm.ADO0745.fieldvalues['送审人意见'];
        if Frm_Shenhe.ShowModal=mrok then
          begin
            rkey745:=dm.ADO0745Rkey.Value;
            dm.ADOTMP1.SQL.Clear;
            dm.ADO0745.Active:=false;




            with dm.ADOTMP3 do
            begin
            close;
            sql.Clear;
            SQL.Text:='alter table FA0746  NOCHECK constraint all'+ #13+
            ' select 1';
            open;
            end;
            if circle=1 then
            dm.ADOTMP1.SQL.Text:=' insert into FA0746(d745_ptr,d34_index,d34_ptr,check_status) '+
                   ' select '+inttostr(rkey745)+',d34_index,d34_ptr ,0 from FA0741 a join FA0742 b on a.rkey=b.d741_ptr '+
                   ' where  a.rkey='+inttostr(bptype) +
                   ' and not  exists (select * from FA0746 where d745_ptr='+inttostr(rkey745)+')'+
                 ' update  FA0745 set check_status=1 '+
                 ', submit_date=getdate() '+
                 ', submit_suggestion='+quotedstr(Frm_Shenhe.RichEdit1.Text)+
                 '  from FA0745 where rkey='+quotedstr(inttostr(rkey745))
            else
               dm.ADOTMP1.SQL.Text:=' update  FA0745 set check_status=1 '+
                 ', submit_date=getdate() '+
                 ', submit_suggestion='+quotedstr(Frm_Shenhe.RichEdit1.Text)+
                 '  from FA0745 where rkey='+quotedstr(inttostr(rkey745));


            ShowMsg('提交审核操作成功!',1);
            dm.ADOTMP1.ExecSQL;
            dm.ADOTMP1.SQL.Text:='';


            with dm.ADOTMP3 do
            begin
            close;
            sql.Clear;
            SQL.Text:='alter table FA0746  CHECK constraint all'+ #13+
            ' select 1';
            open;
            end;

            dm.ADO0745.Active:=true;
            //dm.ADO0738.Sort:=paixu2;
            dm.ADO0745.Locate('Rkey',rkey745,[]);

             with  dm.ADO0746 do
             begin
             close;
             Parameters.ParamByName('rkey745').Value:=dm.ADO0745Rkey.Value;
             Open;
             end;
            
          end;
      finally
        Frm_Shenhe.Free;
      end;

end;

procedure Tmain.N5Click(Sender: TObject);
begin
      rkey745:=dm.ADO0745.fieldbyname('rkey').Value;
      dm.ADOTMP1.SQL.Clear;
      dm.ADO0745.Active:=false;
      dm.ADOTMP1.SQL.Text:='update  FA0745 set check_status=0  from FA0745 '+
        ' where rkey='+quotedstr(inttostr(rkey745));
      dm.ADOTMP1.ExecSQL;
      dm.ADOTMP1.SQL.Text:='';
      dm.ADO0745.Active:=true;
     // dm.ADO0738.Sort:=paixu2;
      dm.ADOTMP1.SQL.Clear;

      with  dm.ADOTMP1 do
      begin
      SQL.Clear;
      SQL.Text:='delete FA0746 '+
      ' where d745_ptr='+quotedstr(inttostr(rkey745));
      ExecSQL;
      end;

      with  dm.ADOQuery6 do
      begin
      Close;
      Parameters[0].Value:=rkey745;
      Open;
      end;
      dm.ADO0745.Close;
      dm.ADO0745.Open;

      ShowMsg('取消审核操作成功!',1);
      dm.ADO0745.Locate('Rkey',rkey745,[]);

       with  dm.ADO0746 do
       begin
       close;
       Parameters.ParamByName('rkey745').Value:=dm.ADO0745Rkey.Value;
       Open;
       end;
end;

procedure Tmain.N6Click(Sender: TObject);
var rkey_746 :Integer;
   FA745status : integer;
begin
  rkey_746 :=dm.ADO0746rkey.AsInteger;
  rkey745:=dm.ADO0745Rkey.Value;
  paixu2:=dm.ADO0745.Sort;

   dm.ADODataSet_ud2.close;
   dm.ADODataSet_ud2.Parameters.ParamByName('rkey').Value:=strtoint(user_ptr);
   dm.ADODataSet_ud2.Open;
   people_department:=dm.ADODataSet_ud2.FieldValues['employee_id'];//部门 -------->>>

  if (Tmenuitem(Sender).Tag in [1]) then
    begin
       with dm.ADOQuery2 do
        begin
        Close;
        Parameters[0].Value:=dm.ADO0745rkey.Value;
        Open;
        end;

        with dm.ADOQuery3 do
        begin
        Close;
        Parameters[0].Value:=dm.ADO0745rkey.Value;
        Open;
        end;

       if (dm.ADOQuery2sl.Value=dm.ADOQuery3sl.Value) and (dm.ADO0740TestResult.Value='') and (not dm.ADO0740.IsEmpty )  then
        begin
        ShowMessage('请先填写测试结果');
        Exit;
        end;


      try

        Frm_Shenhe:=TFrm_Shenhe.Create(nil);
        Frm_Shenhe.Caption := inttostr(dm.ADO0746d34_index.Value)+'审,审核部门:'+dm.ADO0746dept_name.AsString;
        Frm_Shenhe.Label2.Caption:=dm.ADO0745.FieldValues['F_NUM'];
        Frm_Shenhe.Label6.Caption:=dm.ADO0745.FieldValues['MANU_PART_NUMBER'];
        Frm_Shenhe.Label8.Caption:=dm.ADO0745.FieldValues['CUSTOMER_NAME'];
        Frm_Shenhe.Label4.Caption:='第 '+inttostr(dm.ADO0746d34_index.AsInteger)+' 审';
        Frm_Shenhe.RichEdit1.Enabled:=False;
        Frm_Shenhe.RichEdit1.visible:=False;
     

        if Frm_Shenhe.ShowModal=mrok then
        begin
          dm.ADOTMP1.SQL.Clear;
          dm.ADOTMP1.SQL.Text:='select [check_status] from FA0746 where rkey='+quotedstr(inttostr(rkey_746));
          dm.ADOTMP1.Open;
          if (dm.ADOTMP1.FieldByName('check_status').AsInteger = dm.ADO0746check_status.AsInteger) then
            begin
              dm.ADOTMP1.Close;
              dm.ADO0746.Active:= False;
              dm.ADOTMP1.SQL.Text:='update  FA0746 '+
                  ' set check_status=1 '+
                  ', check_person='+user_ptr+
                  ', check_time=getdate()'+
                  ' from FA0746 where rkey='+inttostr(rkey_746);
              dm.ADOTMP1.ExecSQL;

              dm.ADOTMP1.SQL.Text:='';
              //需要判断是否审核完成
              dm.ADOTMP1.Close;
              dm.ADOTMP1.SQL.Clear;
              dm.ADOTMP1.SQL.Text:='select * from  FA0746 '+
                  ' where check_status=0 and d745_ptr='+inttostr(rkey745);
              dm.ADOTMP1.ExecSQL;
              dm.ADOTMP1.Open;
              if dm.ADOTMP1.Eof then
              begin
                dm.ADO0745.Active := false;
                dm.ADOTMP2.SQL.Text :='update FA0745 set check_status=2 from FA0745 where rkey='+inttostr(rkey745);
                dm.ADOTMP2.ExecSQL;
                dm.ADO0745.Active := True;
                dm.ADO0745.Sort:=paixu2;
                dm.ADO0745.Locate('rkey',rkey745,[]);
              end;

              dm.ADO0746.Active := true;
              dm.ADO0746.Locate('rkey',rkey_746,[]);
              DBGridEh1.SetFocus;
            end
            else
              begin
                dm.ADOTMP1.Close;
                showmessage('审核状态已经发生改变');
                dm.ADO0746.Active:= False;
               dm.ADO0746.Locate('rkey',rkey_746,[]);
                dm.ADO0746.Active := true;
                exit;
              end;

        end;
      finally
        Frm_Shenhe.Free;
      end;
  end;


  if (Tmenuitem(Sender).Tag in [2]) then
  begin


    dm.ADOTMP1.SQL.Clear;
    dm.ADOTMP1.SQL.Text:='select [check_status] from FA0745 where rkey='+quotedstr(inttostr(rkey745));
    dm.ADOTMP1.Open;
    FA745status := dm.ADOTMP1.FieldByName('check_status').AsInteger;
    if ((dm.ADOTMP1.FieldByName('check_status').AsInteger =2) and (dm.ADO0746d34_ptr.AsInteger <>last_check_dept) ) then
     begin
        ShowMessage('审核过程已经全部完成,非最后的部门不可取消审核,请与合同审核监管部门人员联系');
        exit;
     end;

    dm.ADOTMP1.SQL.Clear;
    dm.ADOTMP1.SQL.Text:='select [check_status] from FA0746 where rkey='+quotedstr(inttostr(rkey_746));
    dm.ADOTMP1.Open;

      if (dm.ADOTMP1.FieldByName('check_status').AsInteger = dm.ADO0746check_status.AsInteger) then
      begin
          dm.ADOTMP1.Close;
          dm.ADO0746.Active:= False;
          dm.ADOTMP1.SQL.Text:='update  FA0746 '+
              ' set check_status=0 '+
              ', check_time=getdate()'+
              ' from FA0746 where rkey='+inttostr(rkey_746);
          dm.ADOTMP1.ExecSQL;
      dm.ADOTMP1.SQL.Text:='';

      if FA745status=2 then
      begin
          //ShowMessage('');
          dm.ADO0745.Active := false;
          dm.ADOTMP1.SQL.Clear;
          dm.ADOTMP1.SQL.Text:=' update FA0745 '+
                  ' set check_status=1'+
                  ' from FA0745 where rkey='+inttostr(rkey745);
           dm.ADOTMP1.ExecSQL;
           dm.ADO0745.Active := True;
           dm.ADO0745.Sort:=paixu2;
           dm.ADO0745.Locate('rkey',rkey745,[]);
      end;

      dm.ADO0746.Active := true;
      dm.ADO0746.Locate('rkey',rkey_746,[]);
      DBGridEh1.SetFocus;

      end
      else
      begin
        dm.ADOTMP1.Close;
        showmessage('审核状态已经发生改变');
        dm.ADO0746.Active:= False;
        dm.ADO0746.Locate('rkey',rkey_746,[]);
        dm.ADO0746.Active := true;
        exit;
      end;
    end;

    if (Tmenuitem(Sender).Tag in [3]) then
  begin
   if MessageBox(Handle,'确定退回送审人吗?'+#13+#13+'此操作会将所有已通过的审核标识为未审核'+#13+#13+'而且此操作不可逆','提示',MB_YESNO+MB_ICONWARNING+MB_DEFBUTTON2)=IDNO	then exit;
        dm.ADO0745.Active := false;
        dm.ADO0746.Active := false;
        dm.ADOTMP1.Close;

        dm.ADOTMP1.SQL.Text:='update  FA0746 '+
        ' set check_status=0 '+
        ' from FA0746 where d745_ptr='+inttostr(rkey745)+
        ' update  FA0746 '+
        ' set check_person='+user_ptr+
        ', check_time=getdate()'+
        ' from FA0746 where rkey='+inttostr(last_d746_rkey)+
        ' update FA0745 '+
        ' set check_status=0,circle=circle+1 '+
        ' from FA0745 where rkey='+inttostr(rkey745);
        dm.ADOTMP1.ExecSQL;
        dm.ADOTMP1.SQL.Text:='';

        dm.ADO0745.Active := True;
        dm.ADO0745.Sort:=paixu2;
        dm.ADO0745.Locate('rkey',rkey745,[]);

        dm.ADO0746.Active := true;
        dm.ADO0746.Locate('rkey',rkey_746,[]);
        DBGridEh1.SetFocus;
  end;
end;

procedure Tmain.PopupMenu3Popup(Sender: TObject);
var max_index: Integer;
begin
  dm.ADODataSet_ud2.close;
  //dm.ADODataSet_ud2.Parameters.ParamByName('rkey').Value:=3;
   dm.ADODataSet_ud2.Parameters.ParamByName('rkey').Value:=strtoint(user_ptr);
   dm.ADODataSet_ud2.Open;
   people_department:=dm.ADODataSet_ud2.FieldValues['employee_id'];//部门 -------->>>


   N6.Enabled := False; //审核
   N8.Enabled := false;       //取消审核
   N14.Enabled := false;      //退回送审人

  { if (dm.ADO0745check_status.AsInteger=2)and (not dm.ADO0746.IsEmpty)then
    begin
    N8.Enabled := false;
    end
    else
    begin
    N8.Enabled := True;
    end;}




  if not  dm.ADO0745.IsEmpty then
  begin
    dm.ADOTMP1.SQL.Clear;
    dm.ADOTMP1.SQL.Text := 'select top 1 rkey,d745_ptr,d34_index,d34_ptr,check_person,check_time,check_status  from FA0746 where d745_ptr='+inttostr(dm.ADO0745Rkey.Value)+' order by d34_index desc ';
    dm.ADOTMP1.Open;
     if not  dm.ADOTMP1.IsEmpty   then
     begin
       max_index := dm.ADOTMP1.FieldByName('d34_index').AsInteger;
       last_check_dept:= dm.ADOTMP1.FieldByName('d34_ptr').AsInteger;
       last_check_deptindex := dm.ADOTMP1.FieldByName('d34_index').AsInteger;
       last_d746_rkey := dm.ADOTMP1.FieldByName('rkey').AsInteger;
     end;
     dm.ADOTMP1.Close;
     dm.ADOTMP1.SQL.Clear;

    if not dm.ADO0746.IsEmpty then begin
          //审核状态为0 ,部门对得上,有4权限,
       if (dm.ADO0745check_status.AsInteger=1) and
          (dm.ADO0746check_status.AsInteger=0) and
          (dm.ADO0746d34_ptr.AsInteger =people_department) and
          ( (vprev ='4'))
          then N6.Enabled := true;

        //审核状态为1 ,部门对得上,有4权限,
       if (dm.ADO0746check_status.AsInteger=1) and
          (dm.ADO0746d34_ptr.AsInteger =people_department) and
          ((vprev ='4')) and
          (dm.ADO0746check_person.AsString = user_ptr)
          then N8.Enabled := true;







         //审核状态为0 ,部门对得上,4权限,最后一个部门,可以退审
       if (dm.ADO0745check_status.AsInteger=1) and
          (dm.ADO0746check_status.AsInteger=0) and
          (dm.ADO0746d34_ptr.AsInteger =people_department) and
          (vprev ='4') and
          (dm.ADO0746d34_index.AsInteger = max_index)
          then N14.Enabled := true;
    end;

    end;
end;

procedure Tmain.FA1Click(Sender: TObject);
begin
  if dm.ADO0740.IsEmpty then
  begin
  ShowMessage('没有可打印的资料');
  Exit;
  end;

  Form_report := tform_report.Create(application);
  with dm.ADOTMP1 do
  begin
  close;
  sql.Clear;
  SQL.Text:='select MANU_PART_NUMBER from data0025 where RKEY='+quotedstr(inttostr(dm.ADO0745RKEY25.Value));
  open;
  end;


  Form_report.aq740.Close;
  form_report.aq740.Parameters.ParamByName('RKEY745').Value:=dm.ADO0745Rkey.Value;
  form_report.aq740.Open;

  form_report.aq745.Close;
  form_report.aq745.Parameters.ParamByName('rkey10').Value:=dm.ADO0745Rkey10.Value;
  form_report.aq745.Open;


  form_report.aq005.Close;
  form_report.aq005.Parameters.ParamByName('AUDITED_ptr').Value:=dm.ADO0745AUDITED_ptr.Value;
  form_report.aq005.Open;

  form_report.ppReport1.Reset;
  form_report.ppReport1.Template.FileName :=
  stringReplace(UpperCase(extractfilepath(paramstr(0))),'EXEC\','NIERP\REPORT\',[rfReplaceAll])+'FATest.rtm';
  form_report.ppReport1.Template.LoadFromFile;
  form_report.ppReport1.SaveAsTemplate:=False;

  form_report.ppReport1.Print;
  form_report.Free;


end;

procedure Tmain.BitBtn6Click(Sender: TObject);
begin
 if (strtoint(vprev)<>4)  then
   messagedlg('对不起!您没有定义流程可写权限',mtinformation,[mbok],0)
  else
 begin
try
form_report:= Tform_report.Create(application);
form_report.ppReport1.Reset;
form_report.ppReport1.Template.FileName :=
  stringReplace(UpperCase(extractfilepath(paramstr(0))),'EXEC\','NIERP\REPORT\',[rfReplaceAll])+'FATest.rtm';
form_report.ppReport1.Template.LoadFromFile;
form_report.ppReport1.SaveAsTemplate:=true;
form_report.ppdesigner1.ShowModal;
finally
form_report.Free;
end;
end;
end;

procedure Tmain.PopupMenu1Popup(Sender: TObject);
var cancle_flag :Integer;
begin
   N4.Enabled := False;
   N5.Enabled := False;
   cancle_flag := 0;




   if not dm.ADO0746.Eof  then
   begin
    dm.ADOTMP1.Close;
    dm.ADOTMP1.SQL.Clear;
    dm.ADOTMP1.SQL.Text :='select * from FA0746 where check_status=1 and d745_ptr='+inttostr(dm.ADO0745.fieldbyname('rkey').Value);
    dm.ADOTMP1.ExecSQL;
    dm.ADOTMP1.Open;
    if not dm.ADOTMP1.Eof then cancle_flag := 0 else  cancle_flag := 1;
   end;

  // if ((dm.ADO0738check_status.AsInteger = 0) )
  // then N2.Enabled := True;

   if ((dm.ADO0745check_status.AsInteger>0) )then
   begin
    N1.Enabled := false;
    end
    else
    N1.Enabled := True;


    if (dm.ADO0745check_status.AsInteger >0)then
    begin
    N2.Enabled := false;
    end
    else
    N2.Enabled := True;



   if ((dm.ADO0745check_status.AsInteger = 0) and (dm.ADO0745AUDITED_ptr.AsInteger=strtoint(user_ptr)))
   then N4.Enabled := True;

   if    (  (cancle_flag=1)and (dm.ADO0745check_status.AsInteger = 1) and (dm.ADO0745AUDITED_ptr.AsInteger=strtoint(user_ptr)) )
   then N5.Enabled := true;


end;

procedure Tmain.BitBtn4Click(Sender: TObject);
var i: integer;
    Sqlstr:string;
begin
   form_remser:=tform_remser.Create(application);
 if form_remser.ShowModal = mrok then
 begin
  if form_remser.sgrid1.RowCount-2>0 then
    begin
      for i:=1 to form_remser.sgrid1.RowCount-2
     do
      if  form_remser.sgrid1.Cells[2,i]<> '' then Sqlstr:=sqlstr+form_remser.sgrid1.Cells[2,i];
     end;

 
 end;

end;

procedure Tmain.N11Click(Sender: TObject);
begin
 with TfrmPick_WorkShop.Create(Application)do
  try
     with  dm.ADO0740 do
     begin
     close;
     Parameters.ParamByName('rkey745').Value:=dm.ADO0745Rkey.Value;
     Parameters.ParamByName('rkey25').Value:=dm.ADO0745RKEY25.Value;
     Open;
     end;

     with  dm.adsPickWorkShop do
     begin
     close;
     Parameters.ParamByName('rkey25').Value:=dm.ADO0745RKEY25.Value;
     Open;
     end;

     Enter(dm.ADO0740.fieldByname('rKey').AsInteger);
     dm.Insert740.close;
     dm.Insert740.open;
    if ShowModal = mrok then
    begin

      with dm do begin
        cdsPickWorkShop.First;
        while not cdsPickWorkShop.Eof do begin
          if cdsPickWorkShop.FieldByName('IsSelected').AsBoolean then
          if not Insert740.Locate('RKEY745',dm.cdsPickWorkShop.fieldbyName('rKey').AsInteger,[]) then
          begin
            Insert740.Append;
            Insert740.FieldByName('RKEY745').Value:=dm.ADO0745rkey.value;
            Insert740.FieldByName('RKEY34').Value :=dm.cdsPickWorkShop.fieldbyName('rKey').AsInteger;
            Insert740.FieldByName('TestDate').Value :=Now;
            Insert740.FieldByName('Create_ptr').Value :=user_ptr;
            Insert740.Post;
          end;
          cdsPickWorkShop.next;
        end;
      end;

    with  dm.ADO0740 do
    begin
    close;
    Parameters.ParamByName('rkey745').Value:=dm.ADO0745Rkey.Value;
    Parameters.ParamByName('rkey25').Value:=dm.ADO0745RKEY25.Value;
    Open;
    end;
    end;
  finally
    release;
  end;
end;



procedure Tmain.N12Click(Sender: TObject);
begin
  if (strtoint(vprev)<>4)  then
   messagedlg('对不起!您没有该程序的可写权限',mtinformation,[mbok],0)
  else
  begin
  IF dm.ADO0740.IsEmpty then
  BEGIN
  showmessage('没有可删除的资料!');
  Exit;
  end;

 if messagedlg('确定要删除该纪录吗?',mtconfirmation,[mbyes,mbno],0)=mryes then
 try
 dm.ADOConnection1.BeginTrans;

 with dm.ADODel740 do
 begin
 close;
 Parameters.ParamByName('RKEY745').Value:=dm.ADO0745Rkey.AsInteger;
 Parameters.ParamByName('RKEY34').Value:=dm.ADO0740RKEY34.AsInteger;
 open;
 end;


 dm.ADO0745.Locate('Rkey',dm.ADO0745Rkey.Value,[]);

 with  dm.ADO0740 do
 begin
 close;
 Parameters.ParamByName('rkey745').Value:=dm.ADO0745Rkey.Value;
 Parameters.ParamByName('rkey25').Value:=dm.ADO0745RKEY25.Value;
 Open;
 end;

 //BtBrushClick(Sender);
 dm.ADOConnection1.CommitTrans;
 except
 on e :exception do
  begin
   dm.ADOConnection1.RollbackTrans;
   showmessage(e.Message);
  end;
 end;
end;
end;

end.





