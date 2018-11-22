unit Unit_fg;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, TeEngine, Series, TeeProcs, Chart,
  ToolWin, ComCtrls, Grids, DBGridEh, ImgList, Spin, DB, OleServer,
  Excel2000,ClipBrd, Menus, ExcelXP,ComObj;

type
  TForm_fg = class(TForm)
    Panel1: TPanel;
    SpeedButton4: TSpeedButton;
    SpeedButton1: TSpeedButton;
    BitBtn8: TBitBtn;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    PageControl2: TPageControl;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    DBGridEh1: TDBGridEh;
    DBGridEh2: TDBGridEh;
    ToolBar1: TToolBar;
    Chart1: TChart;
    Series1: TBarSeries;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    SpinEdit1: TSpinEdit;
    ImageList1: TImageList;
    DataSource1: TDataSource;
    DataSource2: TDataSource;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    Label1: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    Edit2: TEdit;
    Label3: TLabel;
    Edit3: TEdit;
    n2: TMenuItem;
    Label4: TLabel;
    Edit4: TEdit;
    Label5: TLabel;
    Edit5: TEdit;
    procedure SpeedButton1Click(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
    procedure SpinEdit1Change(Sender: TObject);
    procedure ToolButton4Click(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure PageControl2Change(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure DBGridEh1TitleClick(Column: TColumnEh);
    procedure FormCreate(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure DBGridEh2TitleClick(Column: TColumnEh);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure n2Click(Sender: TObject);
  private
    { Private declarations }
    precolumn1,precolumn2:Tcolumneh;
  public
    FD444rkey: string;
    v_tdate:TDateTime;
    { Public declarations }
  end;

var
  Form_fg: TForm_fg;

implementation
uses damo,unit_report2, Unit_progress,Unit_lot, common, unit_changepcs;

{$R *.dfm}

procedure TForm_fg.SpeedButton1Click(Sender: TObject);
begin
  self.Close;
end;

procedure TForm_fg.BitBtn8Click(Sender: TObject);
begin
 try
  form_report2:=tform_report2.Create(application);
  form_report2.QRLabel1.Caption:='���޵�·�����޹�˾';
  form_report2.vdate.Caption:=dm.ADOQ444.fieldbyname('cut_date').asstring;
  form_report2.QuickRep1.Preview; 
 finally
  form_report2.Free;
 end; 
end;

procedure TForm_fg.SpinEdit1Change(Sender: TObject);
begin
 Self.Chart1.MaxPointsPerPage:=strtoint(spinedit1.Text);
end;

procedure TForm_fg.ToolButton4Click(Sender: TObject);
begin
 chart1.NextPage;
end;

procedure TForm_fg.ToolButton3Click(Sender: TObject);
begin
 chart1.PreviousPage;
end;

procedure TForm_fg.ToolButton1Click(Sender: TObject);
begin
  if messagedlg('ȷ��Ҫ��ӡ��',mtinformation,[mbyes,mbno],0)=mryes then
  begin
   chart1.Print;
   Messagedlg('��ӡ��ϣ�',mtinformation,[mbOk],0);
  end;
end;

procedure TForm_fg.PageControl2Change(Sender: TObject);
begin
 self.Series1.Clear;
 dm.ADOD449.First;
 while not dm.ADOD449.Eof do
 begin
  Series1.Add(dm.ADOD449std_matl_cost.Value+dm.ADOD449std_ovhd_cost.Value,
            dm.ADOD449prod_code.Value);
  dm.ADOD449.Next;
 end;
end;

procedure TForm_fg.SpeedButton4Click(Sender: TObject);
var
//  eaApps1: TExcelApplication;
     y   : integer;
  tsList : TStringList;
  s,s1,t : string;
  XLApp: Variant;
  Sheet : Variant;
  vleng:integer;
  vstr:string;

  iCount, jCount, v_cloumn: Integer;


begin
  if messagedlg('Ҫ���������ϵ�����EXCEL�ļ���',mtconfirmation,[mbYes,mbNo],0)<>mrYes then exit;
{  eaapps1:=TExcelApplication.Create(self);
  try
    eaapps1.connect;
  except
    messagedlg('�Ƿ���ȷ��װ��EXCEL��',mtinformation,[mbok],0);
    Abort;
  end;
 }


   if pagecontrol1.ActivePageIndex=0 then
 begin
  if DBGridEh1.DataSource.DataSet.IsEmpty then exit;
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
  XLApp.SheetsInNewWorkbook := 1;

  XLApp.WorkBooks[1].WorkSheets[1].Name := tabsheet2.Caption;
  Sheet := XLApp.Workbooks[1].WorkSheets[tabsheet2.Caption];
  DBGridEh1.DataSource.DataSet.DisableControls;
  DBGridEh1.DataSource.DataSet.first;

  v_cloumn := 0;
  for iCount := 0 to DBGridEh1.Columns.Count - 1 do
    if DBGridEh1.Columns.Items[iCount].Visible = true then
      Sheet.Cells[1, iCount + 1 - v_cloumn] :=
        DBGridEh1.Columns[iCount].Title.Caption
    else
      inc(v_cloumn);

  jCount := 1;
  while not DBGridEh1.DataSource.DataSet.Eof do
  begin
    v_cloumn := 0;
    for iCount := 0 to DBGridEh1.Columns.Count - 1 do
      if DBGridEh1.Columns[iCount].Visible = true then
        Sheet.Cells[jCount + 1, iCount + 1 - v_cloumn] :=
          DBGridEh1.Columns[iCount].Field.AsString
      else
        inc(v_cloumn);
    Inc(jCount);
    DBGridEh1.DataSource.DataSet.Next;
  end;

  sheet.rows[1].insert;
  sheet.rows[1].insert;
  sheet.rows[1].insert;
  sheet.cells[1,1]:=self.Caption+tabsheet2.Caption;
  sheet.cells[1,1].font.size:=18;
  sheet.cells[1,1].font.bold:=true;
  sheet.cells[2,1]:='����ʱ��:'+dm.ADOQ444.FieldByName('tdate').AsString;
  datetimetostring(t,'yyyy-MM-dd hh:mm:ss',now);
  sheet.cells[3,1]:='����ʱ��:'+t;

  XlApp.Visible := True;
  Screen.Cursor := crDefault;
  DBGridEh1.DataSource.DataSet.First;
  DBGridEh1.DataSource.DataSet.EnableControls;
 end;



  if pagecontrol1.ActivePageIndex=1 then
 begin
  if DBGridEh2.DataSource.DataSet.IsEmpty then exit;
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
  XLApp.SheetsInNewWorkbook := 1;

  XLApp.WorkBooks[1].WorkSheets[1].Name := tabsheet2.Caption;
  Sheet := XLApp.Workbooks[1].WorkSheets[tabsheet2.Caption];
  DBGridEh2.DataSource.DataSet.DisableControls;
  DBGridEh2.DataSource.DataSet.first;

  v_cloumn := 0;
  for iCount := 0 to DBGridEh2.Columns.Count - 1 do
    if DBGridEh2.Columns.Items[iCount].Visible = true then
      Sheet.Cells[1, iCount + 1 - v_cloumn] :=
        DBGridEh2.Columns[iCount].Title.Caption
    else
      inc(v_cloumn);

  jCount := 1;
  while not DBGridEh2.DataSource.DataSet.Eof do
  begin
    v_cloumn := 0;
    for iCount := 0 to DBGridEh2.Columns.Count - 1 do
      if DBGridEh2.Columns[iCount].Visible = true then
        Sheet.Cells[jCount + 1, iCount + 1 - v_cloumn] :=
          DBGridEh2.Columns[iCount].Field.AsString
      else
        inc(v_cloumn);
    Inc(jCount);
    DBGridEh2.DataSource.DataSet.Next;
  end;

  sheet.rows[1].insert;
  sheet.rows[1].insert;
  sheet.rows[1].insert;
  sheet.cells[1,1]:=self.Caption+tabsheet2.Caption;
  sheet.cells[1,1].font.size:=18;
  sheet.cells[1,1].font.bold:=true;
  sheet.cells[2,1]:='����ʱ��:'+dm.ADOQ444.FieldByName('tdate').AsString;//form1.SGrid1.Cells[1,form1.sgrid1.row];
  datetimetostring(t,'yyyy-MM-dd hh:mm:ss',now);
  sheet.cells[3,1]:='����ʱ��:'+t;

  XlApp.Visible := True;
  Screen.Cursor := crDefault;
  DBGridEh2.DataSource.DataSet.First;
  DBGridEh2.DataSource.DataSet.EnableControls;
 end;



 { if not VarIsEmpty(XLApp) then
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

  XLApp.SheetsInNewWorkbook := 2;
  XLApp.WorkBooks.Add;
  Application.CreateForm(TForm_Progress, Form_Progress);

//  eaapps1.Workbooks.Add(xlWBATWorksheet,0);
//  eaapps1.worksheets.Add(null,null,1,null,0);


  Form_Progress.show;
  Form_Progress.Label1.Caption :='���ڻ������ݱ�';
  Form_Progress.Label1.refresh;
  XLApp.WorkBooks[1].WorkSheets[1].Name := PageControl1.Pages[0].Caption;
  aSheet := XLApp.Workbooks[1].WorkSheets[1];

//aSheet:=eaapps1.Worksheets[1];
  //---------//��ʼ������һҳ
  DbgridEh1.DataSource.DataSet.DisableControls; //��ֹ����

  s:=#9;
  tsList:=TStringList.Create;
  try
    for y:=0 to DbgridEh1.Columns.Count-1 do
      s:=s+DbgridEh1.Columns.Items[y].Title.Caption+#9;
    tsList.Add(s);
    DbgridEh1.DataSource.DataSet.First;
    while not DbgridEh1.DataSource.DataSet.Eof do
      begin
        s:=inttostr(Dbgrideh1.DataSource.DataSet.RecNo)+#9;
        for y:=0 to Dbgrideh1.Columns.Count-1 do
          begin
            s1:=DbgridEh1.Columns.Items[y].Field.text;
            s:=s+s1+#9;
          end;
        tsList.Add(s);
        DbgridEh1.DataSource.DataSet.Next;

        if Dbgrideh1.DataSource.DataSet.RecordCount div 100>0 then //������
          Form_Progress.ProgressBar1.Position:=Dbgrideh1.DataSource.DataSet.RecNo
            div (Dbgrideh1.DataSource.DataSet.RecordCount div 100)
        else Form_Progress.ProgressBar1.Position:=100;
      end;
    clipboard.Clear;
    Clipboard.AsText:=tsList.Text;
  finally
    tsList.Free;
//  eaapps1.Disconnect;
    aSheet.Paste;
    clipboard.Clear;
  end;

  if dbgrideh1.Columns.Count<=26  then
    vstr:=chr(dbgrideh1.Columns.Count+97)       //96
  else
   begin
    vstr:=chr(strtoint(floattostr(int(dbgrideh1.Columns.Count/26)+96)))
        +chr(strtoint(floattostr(dbgrideh1.Columns.Count-26*int(dbgrideh1.Columns.Count/26)+97)));  //96
   end;

//  eaapps1.Disconnect;
  asheet.rows[1].insert;
  asheet.rows[1].insert;
  asheet.rows[1].insert;
  asheet.cells[1,3]:='�������ϸ����';
  asheet.cells[1,3].font.size:=18;
  asheet.cells[1,3].font.bold:=true;
  asheet.cells[2,1]:='����ʱ��:'+dm.ADOQ444.FieldByName('tdate').AsString;
  datetimetostring(t,'yyyy-MM-dd hh:mm:ss',now);
  asheet.cells[3,1]:='����ʱ��:'+t;
  asheet.Range['a4',vstr+inttostr(dbgridEh1.DataSource.DataSet.RecordCount+4)].Borders.LineStyle :=1;
  asheet.columns.ColumnWidth :=10;
  asheet.Range['b1','b1'].ColumnWidth :=20;
//  asheet.Name :='��������ܷ���';

  //-------//��ʼ�����ڶ�ҳ
  DbgridEh2.DataSource.DataSet.DisableControls;

  Form_Progress.Label1.Caption :='���ڻ������ݱ�(2)';
  Form_Progress.Label1.refresh;
  XLApp.WorkBooks[1].WorkSheets[2].Name := PageControl1.Pages[1].Caption;
  aSheet := XLApp.Workbooks[1].WorkSheets[2];
 // aSheet:=eaapps1.Worksheets[2];

  s:=#9;
  tsList:=TStringList.Create;
  try
    for y:=0 to DbgridEh2.Columns.Count-1 do
      s:=s+DbgridEh2.Columns.Items[y].Title.Caption+#9;
    tsList.Add(s);
    DbgridEh2.DataSource.DataSet.First;
    while not DbgridEh2.DataSource.DataSet.Eof do
      begin
        s:=inttostr(Dbgrideh2.DataSource.DataSet.RecNo)+#9;
        for y:=0 to Dbgrideh2.Columns.Count-1 do
          begin
            s1:=DbgridEh2.Columns.Items[y].Field.text;
            s:=s+s1+#9;
          vleng:=trunc(500*(dbgrideh2.DataSource.DataSet.RecNo/dbgrideh2.DataSource.DataSet.RecordCount));
          form_progress.ProgressBar1.Position:=vleng;
          end;
        tsList.Add(s);
        DbgridEh2.DataSource.DataSet.Next;
      end;
    clipboard.Clear;
    Clipboard.AsText:=tsList.Text;
  finally
    tsList.Free;
//    eaapps1.Disconnect;
    aSheet.Paste;
    clipboard.Clear;
  end;

  if DbgridEh2.Columns.Count<=26
    then vstr:=chr(DbgridEh2.Columns.Count+97)
  else begin
    vstr:=chr(strtoint(floattostr(int(DbgridEh2.Columns.Count/26)+96)))
        +chr(strtoint(floattostr(DbgridEh2.Columns.Count-26*int(DbgridEh2.Columns.Count/26)+96)));
  end;

//  eaapps1.Disconnect;
  asheet.rows[1].insert;
  asheet.rows[1].insert;
  asheet.rows[1].insert;
  asheet.cells[1,3]:='�������ܷ���';
  asheet.cells[1,3].font.size:=18;
  asheet.cells[1,3].font.bold:=true;
  asheet.cells[2,1]:='����ʱ��:'+dm.ADOQ444.FieldByName('tdate').AsString;
  datetimetostring(t,'yyyy-MM-dd hh:mm:ss',now);
  asheet.cells[3,1]:='����ʱ��:'+t;
  asheet.Range['a4',vstr+inttostr(dbgridEh2.DataSource.DataSet.RecordCount+4)].Borders.LineStyle :=1;
  asheet.columns.ColumnWidth :=10;
  asheet.Range['b1','b1'].ColumnWidth :=20;

//  asheet.Name :='�������ܷ���';
//  eaapps1.Visible[0]:=true;         // display Excel files
  XlApp.Visible := True;
  Form_Progress.free;

  DbgridEh1.DataSource.DataSet.EnableControls;
  DbgridEh2.DataSource.DataSet.EnableControls;
end;

procedure TForm_fg.N1Click(Sender: TObject);
begin
 try
  Form_lot:=tForm_lot.Create(application);
  Form_lot.vttype1:=2;
  with Form_lot do
  begin
   ADO410_16.close;
   ADO410_16.CommandText:=ADO410_16.CommandText+
   ' and data0451.ACTUAL_FM_DATE<'+
   QuotedStr(FormatDateTime('YYYY-MM-DD HH:mm:ss',v_tdate));
   ADO410_16.Parameters.ParamByName('rkey06').Value:=dm.ADO449wo_ptr.Value;
   ADO410_16.Open;
   ShowModal;
  end;
 finally
  Form_lot.ADO410_16.close;
  Form_lot.Free;
 end;          }
end;

procedure TForm_fg.DBGridEh1TitleClick(Column: TColumnEh);
begin
  if column.Title.SortMarker=smupeh then
  begin
    column.Title.SortMarker:=smdowneh;
    dm.ado449.IndexFieldNames:=column.FieldName+' DESC';
  end
  else
  begin
    column.Title.SortMarker:=smupeh;
    dm.ado449.IndexFieldNames:=column.FieldName;
  end;

  if (column.ReadOnly) and (precolumn1.FieldName<>column.FieldName) then
  begin //�Ȱѷ��ַ��͵�column��readonly������Ϊfalse,���ַ��Ͳ�����edit����
    label1.Caption:='������'+column.Title.Caption;
    precolumn1.Title.Color:=clbtnface;
    column.Title.Color:=clred;
    precolumn1:=column;
    edit1.Text:='';
  end;
  edit1.SetFocus;
end;

procedure TForm_fg.FormCreate(Sender: TObject);
begin
  precolumn1:=dbgrideh1.Columns[0];
  precolumn2:=dbgrideh2.Columns[0];
end;

procedure TForm_fg.Edit1Change(Sender: TObject);
begin
  if trim(edit1.Text)<>'' then
   case pagecontrol1.ActivePageIndex of
    0:dm.ado449.Filter:=precolumn1.FieldName+' like ''%'+trim(edit1.text)+'%''';
    1:dm.adod449.Filter:=precolumn2.FieldName+' like ''%'+trim(edit1.text)+'%''';
   end
  else
   case pagecontrol1.ActivePageIndex of
    0:dm.ado449.Filter:='';
    1:dm.adod449.Filter:='';
   end;
end;

procedure TForm_fg.PageControl1Change(Sender: TObject);
begin
  edit1.Text:='';
  case pagecontrol1.ActivePageIndex of
   0:label1.Caption:='������'+precolumn1.Title.Caption;
   1:label1.Caption:='������'+precolumn2.Title.Caption;
  end;
end;

procedure TForm_fg.DBGridEh2TitleClick(Column: TColumnEh);
begin
  if column.Title.SortMarker=smupeh then
  begin
    column.Title.SortMarker:=smdowneh;
    dm.adod449.IndexFieldNames:=column.FieldName+' DESC';
  end
  else
  begin
    column.Title.SortMarker:=smupeh;
    dm.adod449.IndexFieldNames:=column.FieldName;
  end;

  if (column.ReadOnly) and (precolumn2.FieldName<>column.FieldName) then
  begin //�Ȱѷ��ַ��͵�column��readonly������Ϊfalse,���ַ��Ͳ�����edit����
    label1.Caption:='������'+column.Title.Caption;
    precolumn2.Title.Color:=clbtnface;
    column.Title.Color:=clred;
    precolumn2:=column;
    edit1.Text:='';
  end;
  edit1.SetFocus;
end;

procedure TForm_fg.PopupMenu1Popup(Sender: TObject);
begin
  with dm.tmp do
  begin
   close;
   sql.Text:='select CLOSED from data0444 where rkey = ' + FD444rkey;
   Open;
  end;
  n2.Enabled := (vprev = '4') and (dm.tmp.FieldByName('CLOSED').AsString = 'Y')
end;

procedure TForm_fg.n2Click(Sender: TObject);
var
  LFrm: TfrmChangePcsPrice;
begin
  LFrm := TfrmChangePcsPrice.Create(Self);
  try
    LFrm.FD444rkey := FD444rkey;
    LFrm.edt1.Text := dm.ADO449.fieldbyname('std_matl_cost_per_pcs').AsString;
    LFrm.edt2.Text := dm.ADO449.fieldbyname('std_ovhd_cost_per_pcs').AsString;
    LFrm.FType := 'FG';
    if LFrm.ShowModal = mrok then
    begin
      dm.tmp.Close;
      dm.tmp.SQL.Text := 'select matl_cst_in_fg_closed,ovhd_cst_in_fg_closed,OVHD_CST_IN_SFG_CLOSED,MATL_CST_IN_SFG_CLOSED from data0444 where rkey = ' + fd444rkey;
      dm.tmp.Open;
      Edit2.Text := dm.tmp.fieldbyname('matl_cst_in_fg_closed').AsString;
      Edit3.Text := dm.tmp.fieldbyname('ovhd_cst_in_fg_closed').AsString;
      Edit4.Text := dm.tmp.fieldbyname('OVHD_CST_IN_SFG_CLOSED').AsString;
      Edit5.Text := dm.tmp.fieldbyname('MATL_CST_IN_SFG_CLOSED').AsString;
    end;
  finally
    LFrm.Free;
  end;
end;

procedure TForm_fg.N1Click(Sender: TObject);
begin
 try
  Form_lot:=tForm_lot.Create(application);
  Form_lot.vttype1:=2;
  with Form_lot do
  begin
   ADO410_16.close;
   ADO410_16.CommandText:=ADO410_16.CommandText+
   ' and data0451.ACTUAL_FM_DATE<'+
   QuotedStr(FormatDateTime('YYYY-MM-DD HH:mm:ss',v_tdate));
   ADO410_16.Parameters.ParamByName('rkey06').Value:=dm.ADO449wo_ptr.Value;
   ADO410_16.Open;
   ShowModal;
  end;
 finally
  Form_lot.ADO410_16.close;
  Form_lot.Free;
 end;
end;


end.
