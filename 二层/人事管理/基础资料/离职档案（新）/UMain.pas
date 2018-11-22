unit UMain;

interface

uses
   Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Grids, DBGridEh, StdCtrls, Buttons, Menus, DB,ComObj, Excel97,
  ADODB, ppDB, ppBands, ppCtrls, ppPrnabl, ppClass, ppCache, ppEndUsr,
  ppProd, ppReport, ppComm, ppRelatv, ppDBPipe, ppModule, raCodMod,
  ppStrtch, ppMemo, ppSubRpt, daDataModule, ComCtrls,ExtDlgs,jpeg, DBCtrls, CommCtrl,StrUtils,DateUtils,
  OleCtrls, SHDocVw,common;

type
  TFrmMain = class(TForm)
    Panel1: TPanel;
    lbl_field: TLabel;
    lbl_Count: TLabel;
    lbl2: TLabel;
    lbl1: TLabel;
    img1: TImage;
    BitBtn1: TBitBtn;
    btn_refresh: TBitBtn;
    btn_excel: TBitBtn;
    btn_qry: TBitBtn;
    btn_Selfield: TBitBtn;
    edt_Value: TEdit;
    dtp_f: TDateTimePicker;
    dtp_t: TDateTimePicker;
    btn_SendMsg: TBitBtn;
    txt1: TStaticText;
    PopupMenu2: TPopupMenu;
    pm_field: TPopupMenu;
    N7: TMenuItem;
    N8: TMenuItem;
    pm_pre: TPopupMenu;
    N15: TMenuItem;
    N_Add: TMenuItem;
    N4: TMenuItem;
    N_Modi: TMenuItem;
    N5: TMenuItem;
    N_Audit: TMenuItem;
    N6: TMenuItem;
    N_Del: TMenuItem;
    N13: TMenuItem;
    pm_rein: TPopupMenu;
    N9: TMenuItem;
    N16: TMenuItem;
    N11: TMenuItem;
    N10: TMenuItem;
    N17: TMenuItem;
    N12: TMenuItem;
    qry_pre: TADOQuery;
    qry_quit: TADOQuery;
    qry_UpdateDep: TADOQuery;
    pgc1: TPageControl;
    TabSheet2: TTabSheet;
    dgh_pre: TDBGridEh;
    pnl0: TPanel;
    rg_status1: TRadioGroup;
    TabSheet1: TTabSheet;
    dgh_quit: TDBGridEh;
    pnl1: TPanel;
    rg_model: TRadioGroup;
    TabSheet4: TTabSheet;
    dgh_rein: TDBGridEh;
    pnl2: TPanel;
    rg_status2: TRadioGroup;
    qry_rein: TADOQuery;
    DataSource1: TDataSource;
    DataSource2: TDataSource;
    DataSource3: TDataSource;
    pnl3: TPanel;
    procedure BitBtn1Click(Sender: TObject);
    procedure btn_excelClick(Sender: TObject);
    procedure btn_SelfieldClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btn_refreshClick(Sender: TObject);
    procedure dgh_preTitleClick(Column: TColumnEh);
    procedure dgh_quitTitleClick(Column: TColumnEh);
    procedure dgh_reinTitleClick(Column: TColumnEh);
    procedure edt_ValueChange(Sender: TObject);
    procedure rg_status1Click(Sender: TObject);
    procedure rg_status2Click(Sender: TObject);
    procedure btn_qryClick(Sender: TObject);
    procedure pgc1Change(Sender: TObject);
    procedure N_AddClick(Sender: TObject);
    procedure N_DelClick(Sender: TObject);
    procedure N_ModiClick(Sender: TObject);
    procedure N12Click(Sender: TObject);
    procedure N_AuditClick(Sender: TObject);
    procedure N10Click(Sender: TObject);
    procedure N16Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure dgh_preDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure dgh_reinDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure rg_modelClick(Sender: TObject);
    procedure pm_prePopup(Sender: TObject);
    procedure pm_reinPopup(Sender: TObject);
    procedure dtp_fChange(Sender: TObject);
    procedure dtp_tChange(Sender: TObject);
    procedure dgh_preKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dgh_quitKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dgh_reinKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);


  private
    { Private declarations }

   field_name1,field_name2,field_name3, mysql: string ;
   PreField1,PreField2,PreField3: TColumnEh;
   procedure comeback(change_rkey:integer);

  procedure FieldClick(sender:Tobject);
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation
          uses UPub,udm, UQry,Pick_Item_Single, UPreAdd, UModiOutTime,
  USelEmp, UNote;
{$R *.dfm}

procedure TFrmMain.FieldClick(sender:Tobject);
var
   i: integer;
begin
//
  if (sender as TMenuItem).Checked=true then
   begin
      (sender as TMenuItem).Checked:= False;
   for i:= 0 to dgh_quit.Columns.Count-1 do 
    if dgh_quit.Columns[i].Title.Caption=(sender as TMenuItem).caption  then
      dgh_quit.Columns[i].Visible:=false;
   end

  else
  begin
        (sender as TMenuItem).Checked:= true;
   for i:= 0 to dgh_quit.Columns.Count-1 do 
    if dgh_quit.Columns[i].Title.Caption=(sender as TMenuItem).caption  then
      dgh_quit.Columns[i].Visible:=true;
   end
  end;


procedure TFrmMain.BitBtn1Click(Sender: TObject);
begin
close;
end;

procedure TFrmMain.btn_excelClick(Sender: TObject);
var
  dgh: TDBGridEh;
  title:string;
begin
 //
  //dgh:=null;
  title:='';
  
 if pgc1.ActivePageIndex=0 then
 begin
  if not qry_pre.IsEmpty then
   title:='Ԥ��ְ����';
  dgh:=dgh_pre;

 end
 else if pgc1.ActivePageIndex=1 then
 begin
  if not qry_quit.IsEmpty then
  title:='��ְ����';
  dgh:=dgh_quit;

 end
 else if pgc1.ActivePageIndex=2 then
 begin
 if not qry_rein.IsEmpty then
  title:='��ְ����';
 dgh:=dgh_rein;

 end ;
  if title<>'' then
  common.Export_dbGridEH_to_Excel(dgh,title)
  else
  ShowMessage('û������');

end;

procedure TFrmMain.btn_SelfieldClick(Sender: TObject);
begin
self.pm_field.Popup(Mouse.CursorPos.X,Mouse.CursorPos.Y);
end;

procedure TFrmMain.FormShow(Sender: TObject);
var
  MItem: TMenuItem;
  i: integer;
  ssql: string;
  f,t: Tdatetime;
begin

self.pgc1.ActivePageIndex:=0;
btn_qry.Visible:=false;
//
 

  field_name1 := dgh_pre.Columns[1].FieldName;
  PreField1 := dgh_pre.Columns[1];
  dgh_pre.Columns[1].Title.Color := clred ;

  field_name2 := dgh_quit.Columns[1].FieldName;
  PreField2 := dgh_quit.Columns[1];
  dgh_quit.Columns[1].Title.Color := clred ;

  field_name3 := dgh_rein.Columns[0].FieldName;
  PreField3 := dgh_rein.Columns[0];
  dgh_rein.Columns[0].Title.Color := clred ;

  ssql:='select rkey from data0419 where programe='+quotedstr('LZEmployee.exe');
  DM.OpenQry(dm.qrytemp,ssql);
  if not    DM.qrytemp.IsEmpty  then
  dm.program_rkey:=DM.qrytemp.fieldbyname('rkey').AsInteger;

   ssql:=format('select data0005.rkey, employee_name from data0005 inner join data0073 on data0073.employee_ptr=data0005.rkey '
      + 'where data0073.rkey=''%s'' ', [rkey73]);
  DM.OpenQry(dm.qrytemp,ssql);
  if not    DM.qrytemp.IsEmpty  then
  dm.data05_rkey:=DM.qrytemp.fieldbyname('rkey').value;

  //showmessage(rkey73);

//���ڣ�
dtp_f.Date:=IncMonth(Now,-3);
dtp_t.Date:=Incday(now,1);
 try
 //0
 qry_pre.sql.text := qry_pre.sql.text //;
     + ' and alt.orginal_departmentid in ' +
     ' (select departmentid from hr_permission where operator_ptr='+rkey73+
     ' and program_ptr='+inttostr(dm.program_rkey)+') '+
     ' order by  alt.alterdate desc ';

 with qry_pre do
 begin
  // f:= StrToDate(FormatDateTime('yyyy-mm-dd',dtp_f.date));
   //t:=  StrToDate(FormatDateTime('yyyy-mm-dd',dtp_t.date));

   qry_pre.close;
  qry_pre.Parameters[0].Value:= StrToDate(FormatDateTime('yyyy-mm-dd',dtp_f.date));
  qry_pre.Parameters[1].Value:= StrToDate(FormatDateTime('yyyy-mm-dd',dtp_t.date));
  active:=true;
 end;

  rg_status1.itemindex:=0;
  qry_pre.Filter:= ' active =0  ' ;
  qry_pre.filtered:=true;

  //1
  qry_quit.SQL.Text := qry_quit.SQL.Text //;
    + '  and employee_1.orginal_departmentid in '+
     ' (select departmentid from hr_permission where operator_ptr='+rkey73+
     ' and program_ptr='+inttostr(dm.program_rkey)+') ';

 with qry_quit do
 begin
  qry_quit.close;
  qry_quit.Parameters[0].Value:= StrToDate(FormatDateTime('yyyy-mm-dd',dtp_f.date));
  qry_quit.Parameters[1].Value:= StrToDate(FormatDateTime('yyyy-mm-dd',dtp_t.date));
  active:=true;
 end;
     mysql:=qry_quit.sql.text;

 //2
  qry_rein.sql.text := qry_rein.sql.text // ;
      + ' and alt.new_departmentid in ' +
     ' ( select departmentid from hr_permission where operator_ptr='+rkey73+
     ' and program_ptr='+inttostr(dm.program_rkey)+') '+
     ' order by  alt.alterdate desc' ;

 with qry_rein do
 begin
  qry_rein.close;
  qry_rein.Parameters[0].Value:= StrToDate(FormatDateTime('yyyy-mm-dd',dtp_f.date));
  qry_rein.Parameters[1].Value:= StrToDate(FormatDateTime('yyyy-mm-dd',dtp_t.date));
  active:=true;
 end;

   rg_status2.itemindex:=2;
    //rg_status2Click(sender);
    


 //�ֶ�menu��ʼ����

     for i:=0 to   dgh_quit.Columns.Count-1 do
     begin
       MItem:= TMenuItem.create(Self);
       MItem.Caption:=dgh_quit.Columns[i].Title.caption;
       MItem.Checked:=dgh_quit.Columns[i].Visible;
       MItem.OnClick:=FieldClick;
       MItem.Checked:=true;
       pm_field.Items.Add(MItem);
     end;


 //�����ˣ�

 ssql:=format('select data0005.rkey, employee_name from data0005 inner join data0073 on data0073.employee_ptr=data0005.rkey '
      + 'where data0073.rkey=''%s'' ', [rkey73]);
 if  common.OpenQuery(dm.qrytemp,ssql) then
  begin
  if not dm.qrytemp.IsEmpty  then
  dm.data05_rkey := dm.qrytemp.fieldbyname('rkey').asstring;
  end;


 //Ա�����ϵ�ģ�棺
    with dm.qry_tmp do
      begin
        Close;
        SQL.Clear;
        SQL.Text := 'select distinct(model_name) from dbo.employeemsg_rpt_model';
        Open;
      end;
      rg_model.Items.Clear;
      for i := 0 to dm.qry_tmp.RecordCount - 1 do
      begin
        rg_model.Items.Add(dm.qry_tmp.FieldValues['model_name']);
        dm.qry_tmp.Next;
      end;
      for i := 7 to dgh_quit.Columns.Count - 1 do
      begin
        dgh_quit.Columns[i].Visible := True;
      end;

 except on e: exception do
 begin
 ShowMessage('����: '+e.Message);
 exit;
 end;

 end;
end;

procedure TFrmMain.btn_refreshClick(Sender: TObject);
var
  ssql,err: string;
  i:integer;
begin
  //
  try
     if pgc1.ActivePage.TabIndex=0  then
     begin
       with qry_pre do
       begin

        close;
        qry_pre.Parameters[0].Value:=StrToDate(FormatDateTime('yyyy-mm-dd',dtp_f.Date));
        qry_pre.Parameters[1].Value:=StrToDate(FormatDateTime('yyyy-mm-dd',dtp_t.Date));
        open;
        //showmessage(inttostr(qry_pre.recordcount));
        lbl_Count.Caption:= IntToStr(RecordCount);
       end;
     end
     else     if pgc1.ActivePage.TabIndex=1  then
     begin
       with qry_quit do
       begin

        close;
        qry_quit.SQL.Text:=mysql;
        qry_quit.Parameters[0].Value:=StrToDate(FormatDateTime('yyyy-mm-dd',dtp_f.Date));
        qry_quit.Parameters[1].Value:=StrToDate(FormatDateTime('yyyy-mm-dd',dtp_t.Date));
        open;
        lbl_Count.Caption:= IntToStr(RecordCount);
       end;
    //
       for  i:=0  to dgh_quit.Columns.Count-1 do
        dgh_quit.Columns[i].Visible:=true;
     end
    else   if pgc1.ActivePage.TabIndex=2  then
    begin
       with qry_rein do
       begin
      //if  filtered=true then filtered:= false;
        close;
        qry_rein.Parameters[0].Value:=StrToDate(FormatDateTime('yyyy-mm-dd',dtp_f.Date));
        qry_rein.parameters[1].Value:=StrToDate(FormatDateTime('yyyy-mm-dd',dtp_t.Date));
        qry_rein.Open;
        lbl_Count.Caption:= IntToStr(qry_rein.RecordCount);
      end;
    end;
   except on e: exception do
   showmessage('����'+e.message);
   end;
   
//   lbl_Count.Caption:= IntToStr(qry_pre.recordcount);

end;

procedure TFrmMain.dgh_preTitleClick(Column: TColumnEh);
begin
   if qry_pre.FieldByName(Column.FieldName).FieldKind= fkCalculated then exit;
   if (Column.title.SortMarker=smnoneeh) or (Column.title.SortMarker=smdownEH)  then
   begin
    Column.Title.SortMarker:=smUpEh ;
    qry_pre.Sort:=Column.FieldName;
   end
    else
    begin
      column.Title.SortMarker:=smDownEh;
      qry_pre.Sort:=Column.FieldName+' DESC';
    end;

   if PreField1.FieldName<>Column.FieldName then
    begin
     lbl_field.Caption:=Column.Title.Caption;
     field_name1:=column.fieldname;
     Column.Title.Color:=clRed;
     PreField1.Title.Color:=clBtnFace;
     PreField1:=Column;
      edt_Value.SetFocus;
    end;

end;

procedure TFrmMain.dgh_quitTitleClick(Column: TColumnEh);
begin
     if qry_quit.FieldByName(Column.FieldName).FieldKind= fkCalculated then exit;
   if (Column.title.SortMarker=smnoneeh) or (Column.title.SortMarker=smdownEH)  then
   begin
    Column.Title.SortMarker:=smUpEh ;
    qry_quit.Sort:=Column.FieldName;
   end
    else
    begin
      column.Title.SortMarker:=smDownEh;
      qry_quit.Sort:=Column.FieldName+' DESC';
    end;


   if PreField2.FieldName<>Column.FieldName then
    begin
     lbl_field.Caption:=Column.Title.Caption;
     field_name2:=column.fieldname;
     Column.Title.Color:=clRed;
     PreField2.Title.Color:=clBtnFace;
     PreField2:=Column;
      edt_Value.SetFocus;
    end;
    //PreField2:=Column;
end;

procedure TFrmMain.dgh_reinTitleClick(Column: TColumnEh);
begin
   if qry_rein.FieldByName(Column.FieldName).FieldKind= fkCalculated then exit;
   if (Column.title.SortMarker=smnoneeh) or (Column.title.SortMarker=smdownEH)  then
   begin
    Column.Title.SortMarker:=smUpEh ;
    qry_rein.Sort:=Column.FieldName;
   end
    else
    begin
      column.Title.SortMarker:=smDownEh;
      qry_rein.Sort:=Column.FieldName+' DESC';
    end;

   if PreField3.FieldName<>Column.FieldName then
    begin
     lbl_field.Caption:=Column.Title.Caption;
     field_name3:=column.fieldname;
     Column.Title.Color:=clRed;
     PreField3.Title.Color:=clBtnFace;
     PreField3:=Column;
      edt_Value.SetFocus;
    end;
end;

procedure TFrmMain.edt_ValueChange(Sender: TObject);
var
  qry: TADOQuery;
  field_name,sstr: string;
  begin

 case  pgc1.ActivePageIndex of
 0:
 begin
   qry:=qry_pre;
   field_name:=field_name1;
  case  rg_status1.ItemIndex of
  0: sstr:='   active= 0  ';
  1:  sstr:='   active= 1  ';
  2: sstr:='';
 end;
 end;
 1:
 begin
   qry:=qry_quit;
   field_name:=field_name2;
   sstr:='';
 end;
 2:
 begin
   qry:=qry_rein;
   field_name:=field_name3;
   case  rg_status2.ItemIndex of
  0: sstr:='   active= 0 ';
  1:  sstr:='   active= 1 ';
  2: sstr:='';
 end;
 end;
 end;



 if Trim(edt_Value.Text)=''  then
  qry.Filter:=sstr;

if (sstr<>'') and (Trim(edt_Value.Text)<>'') then
  sstr:= ' and '+sstr;


 if qry.FieldByName(field_name).FieldKind=fkcalculated then exit;

 if  Trim(edt_Value.Text)<>'' then
 begin
 if qry.FieldByName(field_name).datatype in [ftstring,ftwidestring ] then
  begin

    qry.Filter:= field_name+' like ''%'+trim(edt_value.text)+'%'' ' +sstr;
  end;
  if qry.FieldByName(field_name).datatype in [ftsmallint,ftinteger] then
  begin

    qry.Filter:= field_name+' >= '+trim(edt_value.text) +sstr   ;
  end;

  if qry.FieldByName(field_name).datatype in [ftdate,ftdatetime] then
  begin
    
    qry.Filter:= field_name+' >= '''+formatdatetime('yyyy-mm-dd',StrToDateTime(trim(edt_value.text)))+''' ' +sstr ;
  end;
 end;
   // qry.filtered:=true;

  if  not qry.IsEmpty then
  lbl_Count.Caption:= IntToStr(qry.recordcount);

end;

procedure TFrmMain.rg_status1Click(Sender: TObject);
var str: string;
begin
// if qry_pre.IsEmpty then Exit;


   case  rg_status1.ItemIndex of
    0: str:=' active= 0 ';       //tdet.
    1:  str:=' active= 1 ';
    2: str:='';
   end;

 qry_pre.Filter:=str;

 btn_refreshClick(sender) ;
 lbl_Count.Caption:=IntToStr(qry_pre.RecordCount);



end;

procedure TFrmMain.rg_status2Click(Sender: TObject);
var
   sstr:string;
begin
 //if qry_rein.IsEmpty then Exit;
 case  rg_status2.ItemIndex of
  0: sstr:=' active= 0 ';
  1:  sstr:=' active= 1 ';
  2: sstr:='';
 end;


 qry_rein.Filter:=sstr;


   btn_refreshClick(sender);
 lbl_Count.Caption:=IntToStr(qry_rein.RecordCount);
end;

procedure TFrmMain.btn_qryClick(Sender: TObject);
 var
  Qrystr: string;
  i:Integer;
begin
//
qrystr:='';
  try
   frmQry:=TFrmQry.create(nil);
   if FrmQry.ShowModal=mrok then
   begin
     for i:=0  to FrmQry.SGrid.RowCount-2 do
     begin
      qrystr:=qrystr+ frmqry.SGrid.Cells[2,i]
     end;
     qry_quit.SQL.Text:= mysql+qrystr;
     try
     with qry_quit do
     begin
      close;
      qry_quit.Parameters[0].Value:=StrToDate(FormatDateTime('yyyy-mm-dd',dtp_f.Date));
      qry_quit.Parameters[1].Value:=StrToDate(FormatDateTime('yyyy-mm-dd',dtp_t.Date));
      open;

      end;
      except on e: exception do
      begin
      ShowMessage('����' +e.Message);
      exit;
      end;
     end;
    end;
  finally
   frmqry.free;

  end;

   lbl_Count.Caption:= IntToStr(qry_quit.recordcount);

 end;


procedure TFrmMain.pgc1Change(Sender: TObject);
begin
 if pgc1.ActivePageIndex=1  then
 btn_qry.Visible:=true
 else
 btn_qry.Visible:=false;


  dm.pg_index:=pgc1.ActivePageIndex;

 if pgc1.ActivePageIndex  in [0,2]     then
 lbl_field.Caption:='Ա������'
 else
 lbl_field.Caption:='Ա������' ;

     if pgc1.ActivePage.TabIndex=0  then
     begin
        lbl_Count.Caption:= IntToStr(qry_pre.RecordCount);
     end
     else if pgc1.ActivePage.TabIndex=1  then
     begin
        lbl_Count.Caption:= IntToStr(qry_quit.RecordCount);
     end
    else   if pgc1.ActivePage.TabIndex=2  then
    begin
        lbl_Count.Caption:= IntToStr(qry_rein.RecordCount);
    end;
end;


procedure TFrmMain.N_AddClick(Sender: TObject);
begin
 if (strtoint(vprev) = 1) or (strtoint(vprev) = 3) then
  begin
    messagedlg('�Բ���!��û�иó���Ŀ�дȨ��', mtinformation, [mbok], 0);
    abort;
  end;

  try
  FrmAdd:= TFrmAdd.create(nil);
   frmadd.grp_LZ.Visible:=true;
   FrmAdd.grp_1.Visible:=false;
    if   FrmAdd.ShowModal=mrok then
     qry_pre.Requery;



  finally
    FrmAdd.free;
  end;

   btn_refreshClick(sender);

end;


procedure TFrmMain.N_DelClick(Sender: TObject);
var i,k:  integer;
    array_1: array of string;
begin
  
 if  qry_pre.isempty then exit;

  if (strtoint(vprev) = 1) or (strtoint(vprev) = 3) then
  begin
    messagedlg('�Բ���!��û�иó���Ŀ�дȨ��', mtinformation, [mbok], 0);
    abort;
  end;
     k:=dgh_pre.SelectedRows.Count-1;
     SetLength(array_1,dgh_pre.SelectedRows.Count);
      for I := 0 to dgh_pre.SelectedRows.Count - 1 do
        begin
        qry_pre.GotoBookmark(Pointer(dgh_pre.SelectedRows.Items[I]));
        array_1[i] :=qry_pre.FieldByName('rkey').asstring;
       end;
       
        for i:=0 to k do
        begin
           if qry_pre.FieldByName('active').asinteger<>1  then
           begin
          dm.qrytemp.sql.text :='delete from employee_alteration where active=0 and rkey ='+array_1[i];
          //showmessage(dm.adotmp.sql.text);
          dm.qrytemp.ExecSQL;
          end;
        end;
        qry_pre.close;
        qry_pre.open;


end;

procedure TFrmMain.N_ModiClick(Sender: TObject);
var
  rkey: Integer;
begin
//
 if (strtoint(vprev) = 1) or (strtoint(vprev) = 3) then
  begin
    messagedlg('�Բ���!��û�иó���Ŀ�дȨ��', mtinformation, [mbok], 0);
    abort;
  end;

if qry_pre.IsEmpty then exit;

try
  FrmModiOutTime:=TFrmModiOutTime.create(nil);
 if  FrmModiOutTime.ShowModal=mrok then
 begin
  rkey:= qry_pre.fieldbyname('rkey').AsInteger;
  qry_pre.Locate('rkey',rkey,[]);
 end;

finally
  FrmModiOutTime.free;

end;

    btn_refreshClick(sender);


end;

procedure TFrmMain.N12Click(Sender: TObject);
var i,k:  integer;
    array_1: array of string;
begin


 if  qry_rein.isempty then exit;

    if  (strtoint(vprev) <> 4)  then   //(strtoint(vprev) = 1) or (strtoint(vprev) = 3)
    begin
      messagedlg('�Բ���!��û�иó���Ŀ�дȨ��', mtinformation, [mbok], 0);
      abort;
    end;
     k:=dgh_rein.SelectedRows.Count-1;
     SetLength(array_1,dgh_rein.SelectedRows.Count);
        for i := 0 to dgh_rein.SelectedRows.Count - 1 do
        begin
        qry_rein.GotoBookmark(Pointer(dgh_rein.SelectedRows.Items[i]));
        array_1[i] :=qry_rein.FieldByName('rkey').asstring;

        end;
        for i:=0 to k do
        begin
          if qry_rein.FieldByName('active').asinteger<>1  then
          begin
          dm.qrytemp.sql.text :='delete from employee_alteration where active=0 and rkey ='+array_1[i];
          dm.qrytemp.ExecSQL;
          end;
        end;
        qry_rein.requery;



end;

//��ְ��Ч
procedure TFrmMain.N_AuditClick(Sender: TObject);
var
  flag_zl_train: integer;
  ssql, ssql2, ssql3: string;
  Lfrm:TfrmNote;
  NerverHire:Boolean;
begin
  NerverHire:= False;
if qry_pre.IsEmpty then exit;
   flag_zl_train := 0;  // �����й��˱�ʶ/��ʾ1��������ݿ�
  if   (strtoint(vprev)<>4 )  then              // (strtoint(vprev)=1) or (strtoint(vprev)=3) 
    begin
      messagedlg('�Բ���!��û�иó���Ŀ�дȨ��', mtinformation, [mbok], 0);
      abort;
    end;


//          if messagedlg('��Ч�󣬲��ɻ�ԭ����ȷ��Ҫ��Ч�ü�¼��'
//            + #13 + '1�����¸�Ա��������Ϣ״̬Ϊ��ְ'
//            + #13 + '2��ɾ����Ա�����������Ϣ'
//            + #13 + '3�����¸�Ա����ͬΪ��Ч'
//            + #13 + '4������ͳ�����в�������', mtconfirmation, [mbyes,mbno],1) = mrno
//            then Exit;

    Lfrm:=TfrmNote.Create(self);
    try
      if  Lfrm.ShowModal <> mrok then Exit;
      if Lfrm.chk1.Checked then NerverHire:= True;
    finally
      Lfrm.Free;
    end;



          txt1.Caption :='��鿼�ڿ��������������ǣ��������䶯';
          Application.ProcessMessages;

          ssql := Format('select cardno_dec,ICCardno from employeecardMsg where status = 1 AND employeeid = ''%s'' ',[qry_pre.FieldValues['employeeid']]);
          DM.OpenQry(dm.qrytemp,ssql);
          if not DM.qrytemp.IsEmpty then
          begin
            ShowMessage('��Ա�����п��ڿ�δ�ջأ���ְʧ�ܣ�');
            txt1.Caption :='';
            Exit;
          end;
          txt1.Caption :='����Ƿ���Ҫ��Ա����ѵ�᰸������ǣ����ݲ������䶯';
          Application.ProcessMessages;
        if (qry_pre.fieldbyname('ttype').AsString <> '����')
        then
         begin

          ssql :=Format(' select top 1 *  from dbo.Employee_Train  '+
                   ' where feels_payed=0 and train_feels>0  and effective_date >=getdate() '+
                   ' and employeeid=''%s'' ',[qry_pre.FieldValues['employeeid']]);
          DM.OpenQry(dm.qrytemp,ssql);
            if (DM.qrytemp.FieldValues['rkey'] <> null )  then
            begin
              txt1.Caption :='';
              ShowMessage('��Ա����δ�������ѵ��������Ч�ڣ���ְʧ��');
              Exit;
            end;
          end;

 //        һ������ֻ�ܰ���һ����ְ��20171632
//        ssql:=' select rkey from  employee_alteration where type in (select rkey from datadetail where dictid=9 )  and employeeid = '+qry_pre.fieldbyname('employeeid').asstring;
//        DM.OpenQry(dm.qrytemp,ssql);
//        if  not dm.qrytemp.isempty  then
//        begin
//          ShowMessage('һ����ֻ����һ����ְ��¼�� ���飡');
//          Exit;
//        end;

          //������Ա�Զ�ȡ����ѵ����
          if (qry_pre.fieldbyname('ttype').AsString = '����')
        then
         begin
         ssql :=Format(' select top 1 *  from dbo.Employee_Train  '+
                   ' where feels_payed=0 and train_feels>0  and effective_date >=getdate() '+
                   ' and employeeid=''%s'' ',[qry_pre.FieldValues['employeeid']]);
          DM.OpenQry(dm.qrytemp,ssql);
            if (DM.qrytemp.FieldValues['rkey'] <> null )  then
            begin
              if messagedlg('��Ա������ѵ����,������Ч��,'+ #13
              +'��Ա������ѵ���˻��޷��ý᰸,'+ #13
              +'��ȷ��Ҫ��Ч�ü�¼��', mtconfirmation, [mbyes,mbno],1) = mrno
              then Exit;
              flag_zl_train := 1;
            end;
          end;
         ////////////////////////////////////////////////////////////////////////////
          //��ʼ���ݲ���
     dm.con1.BeginTrans;
      try

          if  flag_zl_train = 1 then
          begin
            //txt1.Caption :='�Զ�������ѵ����';
            //Application.ProcessMessages;
            ssql :=   ' update employee_train set feels_payed=1,'
              + ' oprator_ptr='+dm.data05_rkey+', '
              + ' oprate_time=getdate(),'
              + ' train_result=train_result+'+#39+'(����)'+#39
              + ' from  dbo.Employee_Train  '
              + ' where feels_payed=0 and train_feels>0  and effective_date >=getdate() '
              + ' and employeeid='+inttostr(qry_pre.Fieldbyname('employeeid').asinteger)+' ' ;
              
            DM.execsql(dm.qrytemp,ssql);
          end;
          //����������Ϣ
           txt1.Caption :='�������µ���';
           Application.ProcessMessages;
          ssql :=' update employeemsg set '
            + 'employeecode=isnull(new_employeecode,a.employeecode), '
            + 'departmentid=isnull(new_departmentid,a.departmentid), '
            + 'position=isnull(new_position,a.position), '
            + 'employ_type=isnull(new_employ_type,a.employ_type), '
            + 'politics_face=isnull(new_politics_face,a.politics_face), '
            + 'education=isnull(new_education,a.education), '
            + 'marriage=isnull(new_marriage,a.marriage), '
            + '[rank]=isnull(new_rank,a.[rank]), '
            + '[status]=2, '
            + 'neverhire= ' + BoolToStr(NerverHire) +', '
            + 'outdutytime=isnull(b.alterdate,getdate()) '
            + 'from  employeemsg   a '
            + 'join employee_alteration b on a.rkey=b.employeeid '
            + ' where b.rkey= '+inttostr(qry_pre.Fieldbyname('rkey').asinteger)+' '
            + ' and b.active=0 '
            + ' and b.type in (select rkey from datadetail where dictid=9) ' ;

           DM.execsql(dm.qrytemp,ssql);
           
          txt1.Caption :='ɾ�����࿼�ڵ���';
           Application.ProcessMessages;
          if ( pos('��',(qry_pre.fieldbyname('ttype').AsString))=0 )then
          begin
          //ɾ��Ա�����������Ϣ �������Ĳ�ɾ��
          ssql := Format('delete from onoffdutydata where employeeid=%s'
            + ' and checkdate>=''%s''', [qry_pre.FieldValues['employeeid'],qry_pre.FieldValues['alterdate']]);
          DM.execsql(dm.qrytemp,ssql);
          end;
          txt1.Caption :='���º�ͬΪ��Ч';
          Application.ProcessMessages;
          ssql := 'update employee_contract set status=2 where status=1 and employeeid='
                + qry_pre.fieldByName('employeeid').asstring;
          DM.execsql(dm.qrytemp,ssql);

        txt1.Caption :='������ְ����';
        Application.ProcessMessages;
        dm.qry_altSave.Parameters[0].Value := qry_pre.fieldbyname('rkey').AsInteger;
        dm.qry_altSave.Open;
        dm.qry_altSave.Edit;
        dm.qry_altSave.FieldByName('active').AsInteger:=1;
        dm.qry_altSave.fieldbyname('oper_person').asinteger:=strtoint(dm.data05_rkey);
        dm.qry_altSave.fieldbyname('oper_date').asdatetime := now;
        dm.qry_altSave.Post;
        dm.qry_altSave.UpdateBatch;
        dm.qry_altSave.close;
        txt1.Caption :='��ְ��Ч���²�������';
        Application.ProcessMessages;

        dm.qry_updateDep.execsql;   //��ְ��Ч���²�������

        //����73����ְ״̬   zsp20180424
        ssql:=' 	update Data0073 set data0073.ACTIVE_FLAG = 1   '+ #13+
              ' from Data0073       '+ #13+
              '      inner join Data0005 on Data0005.RKEY = Data0073.EMPLOYEE_PTR    '+ #13+
              '  where Data0005.ACTIVE_FLAG = ''Y'' and Data0005.EMPL_CODE ='''+qry_pre.fieldbyname('employeecode').asstring+''' ';
        dm.execsql(dm.qry_tmp,ssql);
        
        //����05�����ְ״̬ tao20180102��
        ssql:=' update  Data0005 set ACTIVE_FLAG=''N''  where ACTIVE_FLAG=''Y'' and EMPL_CODE='''+qry_pre.fieldbyname('employeecode').asstring+''' ';
        dm.execsql(dm.qry_tmp,ssql);


        ssql:='select a.rkey   ' +
              ' from  employeemsg   a' +
              '  inner  join employee_alteration b  on a.rkey=b.employeeid' +
              '   where  b.type in (select rkey from datadetail where dictid=9)' +
              '  and  b.active=1 and a.status=1  and b.rkey='+inttostr(qry_pre.Fieldbyname('rkey').asinteger)+' ' ;
        DM.openqry(dm.qrytemp,ssql);
        
       if not dm.qrytemp.IsEmpty then
       begin
       ssql:='update employee_alteration set active=0 where rkey='+inttostr(qry_pre.Fieldbyname('rkey').asinteger)+' ';
       DM.execsql(dm.qrytemp,ssql);
       ShowMessage('��Чʧ�ܣ������ԣ�');
       Exit;
       end
       else
       ShowMessage('�ü�¼��Ч�ɹ���');
       

        qry_pre.Requery;
         with qry_quit do
         begin

          close;
          qry_quit.SQL.Text:=mysql;
          qry_quit.Parameters[0].Value:=StrToDate(FormatDateTime('yyyy-mm-dd',dtp_f.Date));
          qry_quit.Parameters[1].Value:=StrToDate(FormatDateTime('yyyy-mm-dd',dtp_t.Date));
          open;
         end;

     txt1.Caption :='';

        DM.con1.CommitTrans;
      except  on e:exception do
       begin
        dm.con1.RollbackTrans;
        ShowMessage('����'+e.message);
        exit;
       end;
     end;   



end;


//��ְ��Ч
procedure TFrmMain.N10Click(Sender: TObject);
var
  ssql:string;
begin

  if qry_rein.IsEmpty then exit;

  ///ʹ������¼��Ч�����������ݿ�
  if   (strtoint(vprev) <> 4)   then    // (strtoint(vprev)=1) or (strtoint(vprev)=3)
    begin
      messagedlg('�Բ���!��û�иó���Ŀ�дȨ��', mtinformation, [mbok], 0);
      abort;
    end; 
   try
      with dm.qry_altSave do
      begin
        with dm.qrytemp do
        begin
          Close;
          SQL.Text:= 'SELECT 1 FROM EMPLOYEEMSG WHERE neverhire =1 AND RKEY = ' + qry_rein.fieldByName('employeeid').asstring ;
          Open;
          IF NOT IsEmpty THEN
          begin
            ShowMessage('��Ա���ѱ�����Ϊ����¼��Ա�������ܸ�������');
            exit;
          end;
        end;
        //Locate('rkey',qry_rein.fieldbyname('rkey').AsInteger, []); //��alt�ж�λ
        if  not qry_rein.fieldByName('New_departmentid').isnull then
          begin
            with DM.qryTemp do
              begin
               txt1.Caption :='��鲿�������Ƿ���Ա������ǣ��������䶯';
               Application.ProcessMessages;
                Close;
                SQL.Clear;
                SQL.Text := 'select * from datadepartment where rkey ='+ IntToStr(qry_rein.FieldValues['New_departmentid']);
                Open;
                if FieldByName('departmentcount').asInteger >= Round (FieldByName('departmentration').AsInteger * (1 + FieldByName('max_overproof_percent').AsInteger/100)) then
                  begin
                    showmessage('�ò��Ŷ����������������ܵ������˲��ţ����֤��');
                    txt1.Caption :='';
                    Application.ProcessMessages;
                    Exit;
                  end;
              end;
          end;
        txt1.Caption :='';
        Application.ProcessMessages;
        if messagedlg('��Ч�󣬲��ɻ�ԭ����ȷ��Ҫ��Ч�ü�¼��'
            + #13 + '1�����¸�Ա�����춯��Ϣ��������Ϣ��'
            + #13 + '2�����¸�Ա��Ա����ס�Ǽ�'
            + #13 + '3������ͳ�����в�������', mtconfirmation, [mbyes,mbno],1) = mrno then Exit;



          dm.con1.BeginTrans;
          txt1.Caption :='����������Ϣ';
          Application.ProcessMessages;
            ssql := 'update employeemsg set '
              + 'employeecode=isnull(new_employeecode,a.employeecode), '
              + 'departmentid=isnull(new_departmentid,a.departmentid), '
              + 'position=isnull(new_position,a.position), '
              + 'wagetype=isnull(new_accountid,a.wagetype), '
              + 'employ_type=isnull(new_employ_type,a.employ_type), '
              + 'politics_face=isnull(new_politics_face,a.politics_face), '
              + 'education=isnull(new_education,a.education), '
              + 'marriage=isnull(new_marriage,a.marriage), '
              + 'outdutytime=NULL,'
              + 'classgroupid=NULL,'
              + 'ondutytime= ' + QuotedStr(DateToStr(qry_rein.Fieldbyname('alterdate').asdatetime)) + ','
              //+ 'orginal_ondutytime = a.ondutytime, '
              + '[rank]=isnull(new_rank,a.[rank]), '
              + 'status = 1 '
              + 'from employeemsg a '
              + 'join employee_alteration b on a.rkey=b.employeeid '
              + ' where  '          //  a.rkey = '+qry_rein.Fieldbyname('employeeid').asstring+'
              + '   b.rkey='+qry_rein.Fieldbyname('rkey').asstring+' '
              + ' and active=0 ' ;
            dm.execsql(dm.qrytemp,ssql);
        txt1.Caption :='������Ч����²�������';
        Application.ProcessMessages;

            DM.qry_updateDep.execsql;//������Ч���²�������

            ssql := ' select * from  employee_contract where employeeid='
              + qry_rein.fieldByName('employeeid').asstring;
            dm.OpenQry(dm.qrytemp,ssql);

        //  lisa 
         txt1.Caption :='���Ա����ס�Ǽ������ְ����';
        Application.ProcessMessages;
        ssql := ' update   employeemsg_extra  set outdutytime = null  where employeecode='
              +' '''+qry_rein.fieldByName('employeecode').asstring+''' ';
            dm.execsql(dm.qrytemp,ssql);
        //end

        txt1.Caption :='�����ͬ����';
        Application.ProcessMessages;
            if dm.qrytemp.IsEmpty then
              begin
                //showmessage('�Ӻ�ͬ');
               txt1.Caption :='��Ӻ�ͬ����';
               Application.ProcessMessages;
              ssql := ' insert into dbo.employee_contract '+
                  ' (code,employeeid,startdate,probationdate,enddate,type,inputdate,'+
                  ' opration_person,status,remark) select ' +
                  QuotedStr(qry_rein.fieldByName('new_employeecode').asstring)+','+
                  qry_rein.fieldByName('employeeid').asstring+','+
                  quotedstr(DateToStr(qry_rein.fieldValues['alterdate']))+','+
                  'dateadd(day,-1,dateadd(month,3,'+quotedstr(DateToStr(qry_rein.fieldValues['alterdate']))+')), '+
                  'dateadd(day,-1,dateadd(year,3,'+quotedstr(DateToStr(qry_rein.fieldValues['alterdate']))+')), '+
                  qry_rein.fieldByName('new_employ_type').asstring+','+
                  quotedstr(DateToStr(qry_rein.fieldValues['alterdate']))+','+
                  DM.data05_rkey+','+'1,'+ quotedstr('����');
                  dm.execsql(dm.qry_tmp,ssql);
              end;

            if  not dm.qrytemp.IsEmpty then
              begin
                with DM.qryTemp do
                  begin
                    //���º�ͬΪ��Ч
                  txt1.Caption :='�޸ĺ�ͬ����';
                  Application.ProcessMessages;
                   ssql := 'update employee_contract '+
                      '  set status=1 , startdate = '+quotedstr(DateToStr(qry_rein.fieldValues['alterdate']))+','+
                      '  probationdate='+ 'dateadd(day,-1,dateadd(month,3,'+quotedstr(DateToStr(qry_rein.fieldValues['alterdate']))+')) '+','+
                      '  enddate='+ 'dateadd(day,-1,dateadd(year,3,'+quotedstr(DateToStr(qry_rein.fieldValues['alterdate']))+')) '+','+
                      '  remark=remark+'+ #39+'    ����  '+#39+
                      '  from employee_contract where  rkey in '+
                      ' ( select max(rkey) from employee_contract  where  status=2 and employeeid='+ qry_rein.fieldByName('employeeid').asstring+')';
                     dm.execsql(dm.qry_tmp,ssql);
                  end;
              end;
            dm.qrytemp.close;
            //����ǲ�С����������ְ���ظ���ǰ�Ĺ��ŵ�ʱ�򲻵���н��
           txt1.Caption :='����н������';
           Application.ProcessMessages;

            Parameters[0].Value := qry_rein.fieldbyname('rkey').AsInteger;
            Open;
            Edit;
            FieldByName('active').AsInteger:=1;
            fieldbyname('oper_person').asinteger:=strtoint(dm.data05_rkey);
            fieldbyname('oper_date').asdatetime := now;
            Post;
            UpdateBatch;
             //����н������
             if (qry_rein.fieldbyname('orginal_employeecode').asstring <> qry_rein.fieldbyname('new_employeecode').asstring )  then
             comeback(qry_rein.fieldbyname('rkey').AsInteger);

            close;
            DM.con1.CommitTrans;
            ShowMessage('�ü�¼��Ч�ɹ���');
            qry_rein.Requery;

     end;

   except  on e: Exception do
     begin
        dm.con1.RollbackTrans;
        ShowMessage('��������,�������ݲ���:+ssql');
        exit;
      end;

   end;
    txt1.Caption :='';
end ;

procedure Tfrmmain.comeback(change_rkey:integer);
var i,k:  integer;
    employeeid_str,ssql: string;
    yearmonth_str: string;
    accountid_str: string;
    nowyearmonth_str : string;
    fixedmoney_str: string;
    F3name_str: string;
    array_F: array of string;
    array_N: array of string;
 begin
  //showmessage('��н�ʱ䶯����н�ʵ���');
  SetLength(array_F,0);
  SetLength(array_N,0);
 ssql :='  select top 1 itemname,fixedmoney from dbo.DesignSalaryItem  where datafield='
  +quotedstr('F3') ;
  dm.OpenQry(dm.qry_tmp,ssql);

  fixedmoney_str := dm.qry_tmp.FieldByName('fixedmoney').asString;
  F3name_str:= dm.qry_tmp.FieldByName('itemname').asString;

 ssql := 'select employeeid,active,alterdate,'+
    ' orginal_accountid,new_accountid, '+
    ' substring(convert(nvarchar(20),dateadd(month,-1,alterdate),120),1,7) as lastmonth,'+
    ' substring(convert(nvarchar(20),alterdate,120),1,7) as nowmonth '+
    ' from employee_alteration where rkey='+inttostr(change_rkey);
  dm.OpenQry(dm.qry_tmp,ssql);

  employeeid_str := dm.qry_tmp.FieldByName('employeeid').asString;
  yearmonth_str := dm.qry_tmp.FieldByName('lastmonth').asString;
  accountid_str := dm.qry_tmp.FieldByName('new_accountid').asString;
  nowyearmonth_str  := dm.qry_tmp.FieldByName('nowmonth').asString;
    if accountid_str ='' then Exit;

  ssql := 'select itemname,datafield '+
    ' from dbo.DesignSalaryItem '+
    ' where datasourcetype=2 ' +
    ' and accountid='+accountid_str+
    ' order by  itemindex ';
   dm.OpenQry(dm.qrytemp,ssql);

   k:= dm.qrytemp.recordcount;
   i:=0;
   SetLength(array_F,k);
   SetLength(array_n,k);
      while  not dm.qryTemp.Eof do
      begin
        array_F[i] :=  dm.qryTemp.FieldByName('datafield').asString;
        array_N[i] :=  dm.qryTemp.FieldByName('itemname').asString;
        i := i+1;
        dm.qryTemp.Next;
      end;
//  dm.qry_tmp1.sql.clear;
//  dm.qry_tmp1.SQL.Text :=
//      ' update employee_alteration '+
//      ' set orginal_accountid=NULL,'+
//      ' new_accountid=NULL'+
//      ' from employee_alteration where rkey='+inttostr(change_rkey);
   if messagedlg('�Ƿ���Ҫ������ױ䶯��¼', mtconfirmation, [mbyes,mbno],0) = mryes then
   begin
    if ( dm.qry_tmp.FieldByName('active').asString = '1')
    then
      begin
        if (dm.qry_tmp.FieldByName('orginal_accountid').AsString <> dm.qry_tmp.FieldByName('new_accountid').AsString)
         then
           begin
             ssql :=
              ' insert into employee_alteration  '+
              ' (employeeid,alterdate,orginal_accountid,new_accountid,active,oper_person) '+
              ' select employeeid,substring(convert(nvarchar(20),alterdate,120)'+
              ' ,1,7)+'+#39+'-01'+#39+ ',orginal_accountid,new_accountid,active,'+dm.data05_rkey+
              ' from  employee_alteration where rkey ='+inttostr(change_rkey)+

              ' update employee_alteration '+
              ' set orginal_accountid=NULL,'+
              ' new_accountid=NULL'+
              ' from employee_alteration where rkey='+inttostr(change_rkey);
           end;
      end;
   end;
  dm.execsql(dm.qry_tmp1,ssql);
  //showmessage('�����䶯�е����ױ䶯��¼�Ѵ���');

 if messagedlg('�Ƿ���Ҫ����н���㣿#13(����ְ�ĸ�ְ����ѡ��)', mtconfirmation, [mbyes,mbno],0) = mryes   then
   begin
    //showmessage('��ѡ������');
     for i:=0 to k-1 do
     begin
       ssql :=
          'if  ( (select '+array_F[i]+' from employeebasicsalary where employeeid='+employeeid_str+')>0) '+
          ' BEGIN '+
          ' insert into basicsalary_Alteration '+
          ' (employeeid,accountid,itemname,datafield,originaldata,newdata,effect_date,'+
          ' effect_flag,operator,operate_date,remark)'+
          ' select '+employeeid_str+','+accountid_str+','+#39+array_N[i]+#39+','+#39+array_F[i]+#39+','+
           array_F[i]+',0,'+#39+yearmonth_str+'-01'+#39+','+
          ' 1,'+dm.data05_rkey+',getdate(),'+#39+'������ǰһ����ְ�·������0'+#39+
          ' from employeebasicsalary '+
          ' where employeeid='+ employeeid_str+

          ' update employeebasicsalary  '+
          ' set '+array_F[i]+'=0 from employeebasicsalary where employeeid='+ employeeid_str+
          ' end  ';
       dm.execsql(dm.qry_tmp2,ssql);
     end;
       ssql :=
           ' insert into basicsalary_Alteration '+
          ' (employeeid,accountid,itemname,datafield,originaldata,newdata,effect_date,'+
          ' effect_flag,operator,operate_date,remark)'+
          ' select '+employeeid_str+','+accountid_str+','+#39+F3name_str+#39+','+#39+'F3'+#39+','+
          ' 0,'+fixedmoney_str+','+#39+nowyearmonth_str+'-01'+#39+','+
          ' 1,'+dm.data05_rkey+',getdate(),'+#39+'�����·�,'+F3name_str+'�������'+#39+
          ' from employeebasicsalary '+
          ' where employeeid='+ employeeid_str+

          ' update employeebasicsalary  '+
          ' set '+'F3'+'='+fixedmoney_str+
          ' from employeebasicsalary where employeeid='+ employeeid_str;
        dm.execsql(dm.qry_tmp2,ssql);
       //dm.qry_tmp.Close;
   end;//�Ƿ���Ҫ����н��0  

 end;


procedure TFrmMain.N16Click(Sender: TObject);
begin
    if (strtoint(vprev) <> 4)   then    // (strtoint(vprev) = 1) or (strtoint(vprev) = 3)
  begin
    messagedlg('�Բ���!��û�иó���Ŀ�дȨ��', mtinformation, [mbok], 0);
    abort;
  end;

  try
  FrmAdd:= TFrmAdd.create(nil);
   frmadd.grp_LZ.Visible:=false;
   FrmAdd.grp_1.Visible:=true;
    if   FrmAdd.ShowModal=mrok then
     qry_rein.Requery;



  finally
    FrmAdd.free;
  end;
     btn_refreshClick(sender);
end;

procedure TFrmMain.FormCreate(Sender: TObject);
begin

// vprev := '4';
// rkey73 :='3022';


  if not App_init_2(dm.con1 ) then
  begin
    ShowMsg('������ʧ������ϵ����Ա',1);
    application.Terminate;
    exit;
  end;




 //ShowMessage(common.rkey73);



   Caption := application.Title;

 


end;

procedure TFrmMain.dgh_preDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
begin
  If qry_pre.FieldByName('active').Value = 0  then
  Begin
    dgh_pre.Canvas.Font.Color := clRed;
    If qry_pre.FieldByName('hascard').Value = '��'  then
      begin
          if (Column.Index=11) then
           begin
            dgh_pre.Canvas.Brush.Color := clgreen ;
            //dgh_grd1.Canvas.Font.Color := clmaroon ;
            dgh_pre.Canvas.FillRect(Rect);
            dgh_pre.DefaultDrawColumnCell(Rect, DataCol, Column, State);
            end;
      end;
          If qry_pre.FieldByName('hastrain').Value = 0  then
      begin
          if (Column.Index=12) then
           begin
            dgh_pre.Canvas.Brush.Color := clgreen ;
            //dgh_grd1.Canvas.Font.Color := clmaroon ;
            dgh_pre.Canvas.FillRect(Rect);
            dgh_pre.DefaultDrawColumnCell(Rect, DataCol, Column, State);
            end;
      end;
    dgh_pre.DefaultDrawColumnCell(Rect, DataCol, Column, [gdFixed,gdFocused,gdSelected]);
  End; 
end;

procedure TFrmMain.dgh_reinDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
begin
 If qry_rein.FieldByName('active').Value = 0  then
  Begin
    dgh_rein.Canvas.Font.Color := clRed;
    dgh_rein.DefaultDrawColumnCell(Rect, DataCol, Column, [gdFixed,gdFocused,gdSelected]);
  End;
end;

procedure TFrmMain.rg_modelClick(Sender: TObject);
var
  ss: string;
  i, j: Integer;
  //A: Array of integer ;
begin
//����ĳ��ģ�棬������Ӧ�ֶ�
  for i := 8 to dgh_quit.Columns.Count - 1 do
  begin
    dgh_quit.Columns[i].Visible := False;
  end;

  ss := rg_model.Items.Strings[rg_model.ItemIndex];
  with dm.qry_tmp do
  begin
    SQL.Clear;
    SQL.Text := 'select datafield_name from employeemsg_rpt_model where model_name =' +quotedstr(ss);
    Open;
  end;

  for j := 0 to dm.qry_tmp.RecordCount - 1 do
  begin
    for i := 0 to dgh_quit.Columns.Count - 1  do
    begin
      if (dm.qry_tmp.FieldValues['datafield_name'] = dgh_quit.Columns[i].Title.Caption ) then
      begin
        dgh_quit.Columns[i].Visible := True;
        //DBGridEh1.Columns[i].Index := j;
      end;//A[j] := i;
    end;
    dm.qry_tmp.Next;
  end;
   dgh_quit.Refresh;
end;

procedure TFrmMain.pm_prePopup(Sender: TObject);
begin
 if ((qry_pre.fieldByName('active').asInteger = 0 )
  and (dgh_pre.Selection.Rows.Count = 1)) then
    begin
      N_Audit.Enabled := true;
      N_del.Enabled := true;
      N_Modi.Enabled := true;
    end;

  if  (dgh_pre.Selection.Rows.Count > 1)    then
    begin
      N_modi.Enabled :=false;
      N_audit.Enabled := false;

    end;

    if qry_pre.fieldByName('active').asInteger = 1 then
    begin
      N_modi.Enabled := False;
        N_Del.Enabled := False;
          N_Audit.Enabled := False;
    end;

end;

procedure TFrmMain.pm_reinPopup(Sender: TObject);
begin
 if ((qry_rein.fieldByName('active').asInteger = 0 )
    and (dgh_rein.Selection.Rows.Count = 1))      then
    begin
      N10.Enabled := true;
      N12.Enabled := true;
    end;
  if  (dgh_rein.Selection.Rows.Count > 1)    then
    begin
      //N10.Enabled := false;
      N12.Enabled := false;
    end;

    if qry_rein.fieldByName('active').asInteger = 1 then
    begin
      N10.Enabled := False;
      N12.Enabled := False;
    end;
end;

procedure TFrmMain.dtp_fChange(Sender: TObject);
begin
    btn_refreshClick(sender);
end;

procedure TFrmMain.dtp_tChange(Sender: TObject);
begin
    btn_refreshClick(sender);
end;

procedure TFrmMain.dgh_preKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Chr(KEY)='V') and (ssalt in Shift) then
    ShowMessage(qry_pre.SQL.Text);
end;

procedure TFrmMain.dgh_quitKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Chr(KEY)='V') and (ssalt in Shift) then
    ShowMessage(qry_pre.SQL.Text);
end;

procedure TFrmMain.dgh_reinKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Chr(KEY)='V') and (ssalt in Shift) then
    ShowMessage(qry_pre.SQL.Text);
end;

end.

