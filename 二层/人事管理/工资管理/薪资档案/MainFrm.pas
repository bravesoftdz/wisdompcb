unit MainFrm;

interface

uses
  Windows, Messages, SysUtils, StrUtils, Menus, ExtCtrls,  StdCtrls,
  Buttons, Grids, DBGridEh, ComCtrls, Variants, Classes, Graphics,
  Controls, Forms, Dialogs, DB, ADODB,  common,OleCtrls, FrmEmpSalary,
   damo, DateUtils,DBGrids, ComObj, ActnList;

type
  TFrmMain = class(TForm)
    DBGridEh1: TDBGridEh;
    Panel1: TPanel;
    Label1: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn5: TBitBtn;
    edt_1: TEdit;
    RadioGroup1: TRadioGroup;
    PopupMenu1: TPopupMenu;
    CheckBox1: TCheckBox;
    lblCount: TLabel;
    PageControl1: TPageControl;
    ts1: TTabSheet;
    ts2: TTabSheet;
    DBGridEH2: TDBGridEh;
    Label2: TLabel;
    Label3: TLabel;
    SpeedButton4: TSpeedButton;
    ComboBox1: TComboBox;
    Timer1: TTimer;
    PopupMenu2: TPopupMenu;
    N1: TMenuItem;
    BitBtn4: TBitBtn;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    Label4: TLabel;
    Label6: TLabel;
    Edit1: TEdit;
    Panel2: TPanel;
    N3: TMenuItem;
    N5: TMenuItem;
    N2: TMenuItem;
    N4: TMenuItem;
    N6: TMenuItem;
    BitBtn8: TBitBtn;
    BitBtn9: TBitBtn;
    ActionList1: TActionList;
    Action1: TAction;
    pnl1: TPanel;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure DBGridEh1TitleClick(Column: TColumnEh);
    procedure edt_1Change(Sender: TObject);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure RadioGroup1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure DBGridEH2DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure DBGridEH2GetCellParams(Sender: TObject; Column: TColumnEh;
      AFont: TFont; var Background: TColor; State: TGridDrawState);
    procedure DBGridEH2TitleClick(Column: TColumnEh);
    procedure DBGridEh1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGridEH2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Timer1Timer(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure DBGridEh1CellClick(Column: TColumnEh);
    procedure PopupMenu2Popup(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure BitBtn9Click(Sender: TObject);
    procedure Action1Execute(Sender: TObject);
  private
    { Private declarations }
    PreColumn: TColumnEh;
    field_name, StrsTemp, statusTag, sysMoth : string;
    Q_salary_original_str :string;
    Q_salary_new_str :string;
    procedure item_click(sender: TObject);
    procedure GetItemsInfo(salaryaccountrkey: Integer; statusTag: string;Q_salary_new_str:string; sysMoths: string = '');
    procedure GetSalaryInfo(sender: TObject);
  public

  end;

var
  FrmMain: TFrmMain;

implementation

uses
  ExcelFrm, UQuery   , u_hideitem;
  
{$R *.dfm}
//�����ֶΣ�������ʾ�ֶΡ�
procedure TfrmMain.item_click(sender: TObject);
var
  i: byte;
begin
  (sender as tmenuItem).Checked := not ((sender as tmenuItem).Checked);
  if (sender as tmenuItem).Checked then
    begin
      for i := 0 to DBGridEh1.Columns.Count - 1 do
      begin
        if DBGridEh1.Columns[i].Title.Caption = (sender as tmenuItem).Caption then
        begin
          DBGridEh1.Columns[i].Visible := true;
          break;
        end ;
      end;
    end
  else
  begin
    for i := 0 to DBGridEh1.FieldCount - 1 do
    begin
      if DBGridEh1.Columns[i].Title.Caption = (sender as tmenuItem).Caption then
      begin
        DBGridEh1.Columns[i].Visible := false;
        break;
      end;
    end;
  end ;
end;

procedure TfrmMain.GetItemsInfo(salaryaccountrkey: Integer; statusTag: string; Q_salary_new_str:string; sysMoths: string = '');
var
  A, B: Array of String;  //����A���� datafield������B���� itemname
  Index, i: Integer;
  str: string;
begin
  with DM.qrytemp do
  begin
    //�����������Ͳ�ѯ����Ӧ��������������Ŀ�������Ŀ����
    close;
    SQL.Clear;
    SQL.Text := 'select datafield, itemname from DesignSalaryItem where datasourcetype=2 and accountid= ' + inttostr(DM.salaryaccountrkey);
    Open;
    Setlength(A, RecordCount); //��������A�ĳ���
    Setlength(B, RecordCount); //����B�ĳ���
    Setlength(DM.C, RecordCount); //����B�ĳ���
    DM.c_len := RecordCount;
    Index := 0;
    First;
    While Not Eof Do
    begin
      A[Index] := FieldByName('datafield').asString;
      B[Index] := FieldByName('itemname').asString;
      DM.C[Index] := FieldByName('datafield').asString;
      Inc(Index);
      Next;
    end;
    //ѭ���ۼӽ��ֶ�datafieldת��Ϊ�ֶ�itemname, ������Employeebasicsalary���datafield��ʾitemname��
    StrsTemp := '';
    for i := 0 to RecordCount - 1 do
    begin
      StrsTemp := StrsTemp + A[i] + ' as ' + B[i] + ',' ;
    end;
    StrsTemp := copy(StrsTemp, 1, length(StrsTemp) - 1);
  end;
  if PageControl1.ActivePageIndex = 0 then
  begin
    if not DM.qry1.Active then
    begin
     with DM.qry1 do
      begin
        Close;
        SQL.Clear;
        SQL.Text := 'select employeemsg.rkey, employeemsg.status, Employeebasicsalary.freshflag,  '
          + 'employeecode as Ա������,chinesename as Ա������,departmentname as ��������,'
          + ' employeemsg.ondutytime as ��ְʱ��,outdutytime as ��ְʱ��,datadetail.item as ְ��, '
          + ' (select max(effect_date) from basicsalary_alteration where itemname like '+#39+'%����%'+#39
          + ' and basicsalary_alteration.employeeid=employeemsg.rkey and effect_flag=1 and effect_date>employeemsg.ondutytime ) as �ϴε�н,'
          + ' v_employee_workage_detail.workagestr as ����, '
          + ' isnull(v_employee_salarychangetimes.salarychangetimes,0) as ��н����,'
          + ' '
          //ǰ12�в��ܸ�
          + StrsTemp
          + ',case '
          + 'when employeemsg.status = 1 then ''��'' '
          + 'when employeemsg.status = 2 then ''��'' '
          + 'end ''�Ƿ���ְ'''
          + ' from Employeebasicsalary  join employeemsg on Employeebasicsalary.employeeid=employeemsg.rkey '
          + ' left join DesignSalaryItem on employeemsg.wagetype=DesignSalaryItem.rkey '
          + ' left join datadepartment on  employeemsg.departmentid = datadepartment.rkey '
          + ' left join datadetail on  employeemsg.position = datadetail.rkey '
          + ' left join v_employee_salarychangetimes on employeemsg.rkey=v_employee_salarychangetimes.employeeid '
          + ' left join v_employee_workage_detail  on v_employee_workage_detail.rkey=employeemsg.rkey '
          + ' where employeemsg.wagetype=' + IntToStr(salaryaccountrkey)
          + ' and status in ' + statusTag
          + ' and datadepartment.rkey in (select departmentid from hr_permission '
          + ' where operator_ptr= ' + rkey73
          + ' and program_ptr=(select rkey from data0419 where programe =''EmpSalary.exe'')) '
          + Q_salary_new_str
          + ' order by freshflag, datadepartment.departmentname,employeemsg.employeecode ';//
        //ѭ����DBGridEh1�ı����FieldName��ֵ
       str:=SQL.Text;
        Open;
        DBGridEh1.Columns.Clear;
        for i := 0 to FieldCount - 1 do
        begin
          DBGridEh1.Columns[i].Title.Caption := Fields[i].FieldName;
          DBGridEh1.Columns[i].FieldName := Fields[i].FieldName;
          if i in [7,10] then  DBGridEh1.columns[i].width := 70  //��ְ���ڣ��ϴε�н����
          else DBGridEh1.columns[i].width := 3*length(DBGridEh1.Columns[i].Title.Caption)+45;
        end;
        //����û��ֵ����
        for i := FieldCount to DBGridEh1.Columns.Count - 1 do
          DBGridEh1.Columns[i].Visible := False;
      end;
      DBGridEh1.Columns[0].Visible := False;  //����statusֵ
      DBGridEh1.Columns[1].Visible := False;  //����rkeyֵ
     // DBGridEh1.Columns[2].Visible := False;  //����freshflagֵ
      DBGridEh1.SelectedRows.CurrentRowSelected := False;
      DBGridEh1.FrozenCols :=4;
      field_name := DBGridEh1.Columns[2].FieldName;
      PreColumn := DBGridEh1.Columns[2];
      DBGridEh1.Columns[2].Title.Color := clred ;
      label1.Caption := DBGridEh1.Columns[3].Title.Caption;

    end;
  end;
  if PageControl1.ActivePageIndex = 1 then
  begin
    if not DM.qry2.Active then
    begin
      with DM.qry2 do
      begin
        //��ȡ��ǰ����
        with DM.qrytemp do
        begin
          if (BitBtn6.Tag = 0) then
          begin
            sysMoth := '';
            Close;
            SQL.Clear;
            SQl.Text := 'select convert(varchar(100), getdate(), 23) as sysMonth ';
            Open;
            sysMoth := Copy(FieldValues['sysMonth'], 0, Length(FieldValues['sysMonth']) - 3);
          end;
        end;

        Screen.Cursor := crHourGlass;
        Close;
        SQL.Clear;
        SQL.Text := 'select accountid, employeecode ''Ա������'', chinesename ''Ա������'', '
          + 'departmentname ''��������'', position_item ''ְ��'', yearmonth ''�·�'', '
          + StrsTemp + ' from V_employeebasicsalary '
          + 'where yearmonth = ' + QuotedStr(sysMoth) + ' and accountid = ' + IntToStr(salaryaccountrkey)
          + ' and status in ' + statusTag;
        Open;
        Screen.Cursor := crDefault;

        //ѭ����DBGridEh1�ı����FieldName��ֵ
        DBGridEh2.Columns.Clear;
        for i := 0 to FieldCount - 1 do
        begin
          DBGridEh2.Columns[i].Title.Caption := Fields[i].FieldName;
          DBGridEh2.Columns[i].FieldName := Fields[i].FieldName;
          if i <= 2 then DBGridEh2.columns[i].width := 75
          else DBGridEh2.columns[i].width := 95;
        end;
        DBGridEh2.Columns[0].Visible := False;
        //����û��ֵ����
        for i := FieldCount  to DBGridEh2.Columns.Count - 1 do
          DBGridEh2.Columns[i].Visible := False;
        DBGridEh2.SelectedRows.CurrentRowSelected := False;
        field_name := DBGridEh2.Columns[1].FieldName;
        PreColumn := DBGridEh2.Columns[1];
        DBGridEh2.Columns[1].Title.Color := clred ;
        label1.Caption := DBGridEh2.Columns[1].Title.Caption;
      end;
    end;
  end;
end;

procedure Tfrmmain.GetSalaryInfo(sender: TObject);
begin
  with DM.qrytemp do
  begin
    //��ʼ���������ͣ���ȡ��һ���������ͣ�Ĭ�ϣ���rkey
    DM.salaryaccountrkey := -1;
    close;
    SQL.Clear;
    SQL.Text := 'select * from salaryaccount where accountname= ' + QuotedStr(RadioGroup1.Items.Strings[RadioGroup1.ItemIndex]);
    Open;
    DM.salaryaccountrkey := FieldValues['rkey'];
  end;
  if PageControl1.ActivePageIndex = 0 then
  begin
    if CheckBox1.Checked then GetItemsInfo(DM.salaryaccountrkey, '(1,2)',Q_salary_new_str)
    else GetItemsInfo(DM.salaryaccountrkey, '(1)',Q_salary_new_str);
  end;

  if PageControl1.ActivePageIndex = 1 then
  begin
    if CheckBox1.Checked then GetItemsInfo(DM.salaryaccountrkey, '(1,2)',Q_salary_new_str, sysMoth)
    else GetItemsInfo(DM.salaryaccountrkey, '(1)', sysMoth);
  end;
end;

procedure TFrmMain.FormCreate(Sender: TObject);
var
  i: Integer;
  item: TMenuItem;
begin
  //
  rkey73:='3023';
  vprev:='2';

  if not App_init_2(DM.ADOConnection1) then
  begin
    ShowMsg('������ʧ������ϵ����Ա',1);
    application.Terminate;
    exit;
  end;





  Caption := application.Title;
  PageControl1.ActivePageIndex := 0;
  //��ȡ�������Ͷ�Ӧ��н�ʹ̶���Ŀ
  Q_salary_new_str :='';
  with DM.qrytemp do
  begin
    //��ʼ���������ͣ���ȡ��һ���������ͣ�Ĭ�ϣ���rkey
    close;
    SQL.Clear;
    SQL.Text := 'select *, getdate() as nowdate from salaryaccount';
    Open;
    Edit1.Text := Copy(fieldByName('nowdate').AsString, 1, 4);
    if not IsEmpty then
    begin
      RadioGroup1.Columns := RecordCount;
      First;
      for i := 0 to RecordCount - 1 do
      begin
        if i = 0 then DM.salaryaccountrkey := FieldByName('rkey').Value;
        RadioGroup1.Items.Add(FieldValues['accountname']);
        Next;
      end;
      RadioGroup1.ItemIndex := 0;
    end;
  end;

  if DM.ADOConnection1.Connected then
  begin
    for i := 3 to DBGridEh1.Columns.Count do
    begin
        item := TmenuItem.Create(self) ;
        item.Caption := DBGridEh1.Columns[i-1].Title.Caption ;
        if DBGridEh1.Columns[i-1].Visible then
            item.Checked := true ;
        item.OnClick := item_click ;
        PopupMenu1.Items.Add(item) ;
    end;
  end;
  
  dm.ADOTMP.SQL.Clear;
  dm.ADOTMP.SQL.Text := 'select substring(convert (nvarchar(20),getdate(),120),1,7) as nowdate ' ;
  dm.ADOTMP.Open;
  DM.nowyearmonth :=   DM.ADOTMP.FieldByName('nowdate').AsString;
  DM.ADOTMP.Close;
  DM.ADOTMP.SQL.Clear;

end;

procedure TFrmMain.BitBtn2Click(Sender: TObject);
var
  i,j, Index,idIndex: Integer;
  Account,A, B: Array of string;
  Strs: String;
begin
  try
    //��ѯԱ�����ף���Ա��н�ʱ��в����ڵģ���Ա����Ϣ���д��ڵ��������ͣ�
    with DM.qrytemp do
    begin
      close;
      SQL.Clear;
      SQL.Text := 'select distinct wagetype from employeemsg where rkey not in (select employeeid from dbo.Employeebasicsalary ) '
        + 'and wagetype in(select accountid from dbo.DesignSalaryItem) ';
      Open;
      if fieldByName('wagetype').isNull then Exit;
      Setlength(Account, DM.qrytemp.RecordCount);
      idIndex:=0;
      First;
      while not Eof do
      begin
        Account[idIndex]:= fieldByName('wagetype').AsString;
        Inc(idIndex);
        Next;
      end;
      
      DM.ADOConnection1.BeginTrans;
      //��Employeebasicsalary���в���������Ա������δ��н�ʹ̶����д��ڵ�Ա��rkey
      close;
      SQL.Clear;
      SQL.Text := 'insert into Employeebasicsalary(employeeid) '
        + 'select rkey from employeemsg  '
        + 'where  status<> 0  and  rkey not in (select employeeid from dbo.Employeebasicsalary ) '
        + 'and wagetype in(select accountid from dbo.DesignSalaryItem) ';
      ExecSQL;

      //��DesignSalaryItem�еĹ̶���ֵ���µ�Employeebasicsalary���й̶����ֵ
      for j:=0 to High(Account) do
      begin
        close;
        SQL.Clear;
        SQL.Text := 'select datafield, fixedmoney from DesignSalaryItem where datasourcetype=2 and accountid='+ Account[j];
        Open;
        Setlength(A, DM.qrytemp.RecordCount); //��������A�ĳ���
        Setlength(B, DM.qrytemp.RecordCount); //����B�ĳ���
        Index := 0;
        Strs:='';
        First;
        While Not Eof Do
        begin
          A[Index] := FieldByName('datafield').asString;
          B[Index] := FieldByName('fixedmoney').asString;
          Inc(Index);
          Next;
        end;
        for i := 0 to RecordCount - 1 do
        begin
          Strs := Strs + A[i] + ' = ' + B[i] + ',' ;
        end;

        //�����½���Ա��н�ʹ̶���Ŀ�ĳ�ʼ���
        Strs := Copy(Strs, 0, Length(Strs) - 1 );
        Close;
        SQL.Clear;
  //      SQL.Text := 'update Employeebasicsalary set ' + Strs + ' where freshflag=0';
        SQL.Text:= 'update Employeebasicsalary set '+ Strs +#13+
                   'from Employeebasicsalary inner join employeemsg on employeebasicsalary.employeeid=employeemsg.rkey '+ #13+
                   'where Employeebasicsalary.freshflag=0 and employeemsg.wagetype= '+Account[j];
//        ShowMessage(SQL.Text);
        ExecSQL;
      end;

    end;
    DM.ADOConnection1.CommitTrans;
    DM.qry1.Close;
    GetSalaryInfo(Sender);
    //GetItemsInfo(DM.salaryaccountrkey, '(1)');
    DM.qry1.Open;
  except
    on e: Exception do
    begin
      DM.ADOConnection1.RollbackTrans;
      ShowMessage('���������쳣�����Ժ����ԣ�');
    end;
  end;
end;

procedure TFrmMain.DBGridEh1TitleClick(Column: TColumnEh);
begin
  if DBGridEh1.DataSource.DataSet.FieldByName(Column.FieldName).FieldKind = fkCalculated then exit ;
  if (column.Title.SortMarker =smDownEh) or (column.Title.SortMarker =smNoneEh) then
  begin
    column.Title.SortMarker:=smUpEh;
    DM.qry1.Sort:=Column.FieldName;
  end
  else
  begin
    column.Title.SortMarker:=smDownEh;
    DM.qry1.Sort:=Column.FieldName+' DESC';
  end;
  if DBGridEh1.DataSource.DataSet.FieldByName(Column.FieldName).DataType in [ftDate, ftTime, ftDateTime] then exit;
  if (field_name <> column.FieldName) then
  begin
    label1.Caption := column.Title.Caption ;
    field_name := column.FieldName ;
    edt_1.SetFocus;
    PreColumn.Title.Color := clBtnFace ;
    Column.Title.Color := clred ;
    PreColumn := column ;
    edt_1Change(edt_1);
  end
  else
    edt_1.SetFocus;
end;

procedure TFrmMain.edt_1Change(Sender: TObject);
begin
  if PageControl1.ActivePageIndex = 0 then
  begin
    DBGridEh1.DataSource.DataSet.Filtered := True;
    if DBGridEh1.DataSource.DataSet.FieldByName(field_name).FieldKind = fkCalculated then  exit;
    if DBGridEh1.DataSource.DataSet.FieldByName(field_name).DataType in [ftString,ftWideString,ftSmallint,ftInteger]  then
    begin
      if trim(edt_1.text) <> '' then
        begin
          if DBGridEh1.DataSource.DataSet.FieldByName(field_name).DataType in  [ftString, ftWideString]  then
            begin
              DBGridEh1.DataSource.DataSet.Filter:=' (' +  field_name + ' like ''%' + trim(edt_1.text) + '%'')' ;
            end
          else
            if DBGridEh1.DataSource.DataSet.FieldByName(field_name).DataType in  [ftSmallint, ftInteger]  then
            begin
              DBGridEh1.DataSource.DataSet.Filter:=' (' + field_name+' >= ' + inttostr(strtointdef(edt_1.text,0))+')';
            end;
        end
      else
        DBGridEh1.DataSource.DataSet.Filter:='';
    end;
  end;
  if PageControl1.ActivePageIndex = 1 then
  begin
    DBGridEh2.DataSource.DataSet.Filtered := True;
    if DBGridEh2.DataSource.DataSet.FieldByName(field_name).FieldKind = fkCalculated then  exit;
    if DBGridEh2.DataSource.DataSet.FieldByName(field_name).DataType in [ftString,ftWideString,ftSmallint,ftInteger]  then
    begin
      if trim(edt_1.text) <> '' then
        begin
          if DBGridEh2.DataSource.DataSet.FieldByName(field_name).DataType in  [ftString, ftWideString]  then
            begin
              DBGridEh2.DataSource.DataSet.Filter:=' (' +  field_name + ' like ''%' + trim(edt_1.text) + '%'')' ;
            end
          else
            if DBGridEh2.DataSource.DataSet.FieldByName(field_name).DataType in  [ftSmallint, ftInteger]  then
            begin
              DBGridEh2.DataSource.DataSet.Filter:=' (' + field_name+' >= ' + inttostr(strtointdef(edt_1.text,0))+')';
            end;
        end
      else
        DBGridEh2.DataSource.DataSet.Filter:='';
    end;
  end;
end;

procedure TFrmMain.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
begin
  If DM.qry1.FieldByName('status').AsInteger = 2 then
  Begin
      DBGridEh1.Canvas.Font.Color := clRed;
      DBGridEh1.DefaultDrawColumnCell(Rect, DataCol, Column, [gdFixed, gdFocused, gdSelected]);
  End;
  if DM.qry1.FieldByName('freshflag').AsInteger = 0 then
  begin
      DBGridEh1.Canvas.Brush.Color := clMoneyGreen;
      DBGridEh1.Canvas.Font.Color := clRed;
      DBGridEh1.DefaultDrawColumnCell(Rect, DataCol, Column, [gdFixed, gdFocused, gdSelected]);
  end;
end;

procedure TFrmMain.RadioGroup1Click(Sender: TObject);
begin
  DM.qry1.Active := False;
  DM.qry2.Active := False;
  GetSalaryInfo(Sender);
end;

procedure TFrmMain.BitBtn1Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TFrmMain.BitBtn3Click(Sender: TObject);
begin

  if PageControl1.ActivePageIndex = 0 then
    Export_dbGridEH_to_Excel(DBGridEh1, 'Ա��н����ϸ');
  if PageControl1.ActivePageIndex = 1 then
    Export_dbGridEH_to_Excel(DBGridEh2, 'Ա������н����ϸ');
end;

procedure TFrmMain.BitBtn5Click(Sender: TObject);
begin
  popupmenu1.Popup(mouse.CursorPos.x,mouse.CursorPos.y);
end;

procedure TFrmMain.CheckBox1Click(Sender: TObject);
begin
  DM.qry1.Active := False;
  DM.qry2.Active := False;
  GetSalaryInfo(Sender);
end;

procedure TFrmMain.PageControl1Change(Sender: TObject);
begin
  GetSalaryInfo(Sender);
end;

procedure TFrmMain.DBGridEH2DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
var
  AddMonth: Integer;
begin
  with  (Sender as TDBGridEh)do
  begin
    if ((State=[gdSelected]))then
      Canvas.Brush.Color:=clInactiveCaption;           //���ñ��ѡ���������ɫ
    DefaultDrawColumnCell(Rect,datacol,Column,state);
  end;
end;

procedure TFrmMain.DBGridEH2GetCellParams(Sender: TObject;
  Column: TColumnEh; AFont: TFont; var Background: TColor;
  State: TGridDrawState);
begin
  if (Sender as TDBGridEh).SumList.RecNo mod 2 = 1 then
   Background := cl3DLight;
end;

procedure TFrmMain.DBGridEH2TitleClick(Column: TColumnEh);
begin
  if DBGridEh2.DataSource.DataSet.FieldByName(Column.FieldName).FieldKind = fkCalculated then exit ;
  if (column.Title.SortMarker =smDownEh) or (column.Title.SortMarker =smNoneEh) then
  begin
    column.Title.SortMarker:=smUpEh;
    DM.qry2.Sort:=Column.FieldName;
  end
  else
  begin
    column.Title.SortMarker:=smDownEh;
    DM.qry2.Sort:=Column.FieldName+' DESC';
  end;
  if DBGridEh2.DataSource.DataSet.FieldByName(Column.FieldName).DataType in [ftDate, ftTime, ftDateTime] then exit;
  if (field_name <> column.FieldName) then
  begin
    label1.Caption := column.Title.Caption ;
    field_name := column.FieldName ;
    edt_1.SetFocus;
    PreColumn.Title.Color := clBtnFace ;
    Column.Title.Color := clred ;
    PreColumn := column ;
    edt_1Change(edt_1);
  end
  else
    edt_1.SetFocus;
end;

//��ʾ��ǰн�ʵ�����SQL���
procedure TFrmMain.DBGridEh1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (ssAlt in Shift)  and  (Key=86) then
  showmessage(DM.qry1.SQL.Text);
end;

//��ʾ����н�ʵ�����SQL���
procedure TFrmMain.DBGridEH2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (ssAlt in Shift)  and  (Key=86) then
  showmessage(DM.qry2.SQL.Text);
end;

//��timer�ؼ�ʱ�̼�¼��ǰ��ʾн�ʼ�¼�ı���
procedure TFrmMain.Timer1Timer(Sender: TObject);
begin
  if PageControl1.ActivePageIndex = 0 then
  begin
    if DM.qry1.Active then
      lblCount.Caption := '��ǰ��ʾ��¼�� ' + IntToStr(DM.qry1.RecordCount) + ' ��';
  end;

  if PageControl1.ActivePageIndex = 1 then
  begin
    if DM.qry2.Active then
    lblCount.Caption := '��ǰ��ʾ��¼�� ' + IntToStr(DM.qry2.RecordCount) + ' ��';
    Label4.Caption := '��ǰ��ʾ��¼Ϊ��' + copy(sysMoth, 1, 4) + '��'
      + Copy(sysMoth, 6, 2) + '�·�' + ' Ա����н�ʵ���';
  end; 
end;

//��ѯ��Ա������н���д��ڵ���������
procedure TFrmMain.N1Click(Sender: TObject);
begin
  with DM.qrytemp do
  begin
    Close;
    SQL.Clear;
    SQL.Text := 'select distinct accountid from V_employeebasicsalary ' + ' where employeecode = ' + QuotedStr(DM.qry1.FieldValues['Ա������']);
    Open;
    if IsEmpty then
    begin
      ShowMessage('�Բ��𣬲��޼�¼��');
      Exit;
    end;
  end;

  SalaryFrm := TSalaryFrm.Create(Application);
  SalaryFrm.ShowModal;
  SalaryFrm.Free;
end;

//��һ��
procedure TFrmMain.BitBtn4Click(Sender: TObject);
var
  AddMonth: Integer;
  AddMonthStr: string;
begin
  BitBtn6.Tag := 1;
  DM.qry2.Active := False;
  AddMonth := StrToInt(Copy(sysMoth, 6, 2)) - 1;
  if AddMonth <> 0 then
  begin
    if (AddMonth < 10) then AddMonthStr :=  '0' + IntToStr(AddMonth)
    else AddMonthStr := IntToStr(AddMonth);
    sysMoth := Copy(sysMoth, 1, 5)+ AddMonthStr;
  end;
  if AddMonth = 0 then
  begin
    sysMoth := IntToStr(strtoint(Copy(sysMoth, 1, 4)) - 1) + '-12';
  end;
  GetSalaryInfo(Sender);
end;

//����
procedure TFrmMain.BitBtn6Click(Sender: TObject);
begin
  BitBtn6.Tag := 0;
  DM.qry2.Active := False;
  GetSalaryInfo(Sender);
end;

//��һ��
procedure TFrmMain.BitBtn7Click(Sender: TObject);
var
  AddMonth: Integer;
  AddMonthStr: string;
begin
  BitBtn6.Tag := 1;
  DM.qry2.Active := False;
  AddMonth := StrToInt(Copy(sysMoth, 6, 2)) + 1;
  if AddMonth <> 13 then
  begin
    if (AddMonth < 10) then AddMonthStr :=  '0' + IntToStr(AddMonth)
    else AddMonthStr := IntToStr(AddMonth);
    sysMoth := Copy(sysMoth, 1, 5)+ AddMonthStr;
  end;
  if AddMonth = 13 then
  begin
    sysMoth := IntToStr(strtoint(Copy(sysMoth, 1, 4)) + 1) + '-01';
  end;
  GetSalaryInfo(Sender);
end;

//��תʱ������
procedure TFrmMain.SpeedButton4Click(Sender: TObject);
var
  AddMonth: Integer;
  AddMonthStr: string;
begin
  if Length(Edit1.Text) <> 4 then
  begin
    ShowMessage('���������ݲ��ԣ����������룡');
    Edit1.SetFocus;
    Exit;
  end;
  BitBtn6.Tag := 1;
  DM.qry2.Active := False;
  AddMonth := StrToInt(ComboBox1.text);
  if (AddMonth < 10) then AddMonthStr :=  '0' + IntToStr(AddMonth)
  else AddMonthStr := IntToStr(AddMonth);
  sysMoth := Edit1.Text + '-' + AddMonthStr;
  GetSalaryInfo(Sender);
end;

//�ı�����������
procedure TFrmMain.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in [#8,'0'..'9']) then Key := #0;
end;

//������½���Ա����н����Ŀ����ֱ�ӽ��б༭��  ������༭��
procedure TFrmMain.DBGridEh1CellClick(Column: TColumnEh);
begin
  DBGridEh1.ReadOnly := False;
  if DM.qry1.FieldByName('freshflag').AsInteger = 0 then
    begin
      if (DBGridEh1.Col > 12) and (DBGridEh1.Col < DBGridEh1.Columns.Count) then
        DBGridEh1.ReadOnly := False
      else DBGridEh1.ReadOnly := True;
    end
  else
    DBGridEh1.ReadOnly := True;
end;

//�Ҽ��˵�����������
procedure TFrmMain.PopupMenu2Popup(Sender: TObject);
begin

  if DM.qry1.FieldByName('freshflag').Value = 1 then
  begin
    N1.Enabled := True;
    N3.Enabled := False;
    N6.Enabled := true;
  end;
  if DM.qry1.FieldByName('freshflag').Value = 0 then
  begin
    N1.Enabled := False;
    N3.Enabled := True;
    N6.Enabled := false;
  end;

  if  (FormatDateTime('yyyy-MM',dm.qry1.FieldByName('��ְʱ��').AsDateTime))<> DM.nowyearmonth then
  begin
    N6.Enabled := false;
  end;


end;

//�Զ���������ɫ����ְ��͸�λ���ʣ�ְ���ʱ�׼ = ��λ���ʱ�׼ = (�ۺϹ��ʱ�׼ - �������ʱ�׼)/2��
procedure TFrmMain.N3Click(Sender: TObject);
var
  i, accountid: Integer;
  StrTemp: array of string;
begin
  if  not strtoint(vprev) in [2, 4] then
  begin
    messagedlg('�Բ���! ����Ȩ�ޣ���д������������ϵ����Ա��',mtinformation,[mbok],0);
    Exit;
  end;
  with DM.qrytemp do
  begin
    close;
    SQL.Clear;
    SQL.Text := 'select * from salaryaccount where accountname= ' + QuotedStr(RadioGroup1.Items.Strings[RadioGroup1.ItemIndex]);
    Open;
    accountid := FieldValues['rkey'];

    Close;
    SQL.Clear;
    SQL.Text := 'select datafield, itemname from dbo.DesignSalaryItem '
      + ' where datafield in (''F2'', ''F3'', ''F4'', ''F5'') and accountid = ' + IntToStr(accountid)
      + ' order by datafield';
    Open;
  end;
  SetLength(StrTemp, 4);
  DM.qrytemp.First;
  for i := 0 to DM.qrytemp.RecordCount - 1 do
  begin
    StrTemp[i] := DM.qrytemp.FieldValues['itemname'];
    DM.qrytemp.Next;
  end;

  if TMenuItem(Sender).Tag = 0 then
  begin
    if DM.qry1.FieldByName('freshflag').Value = 0 then
    begin
      DM.qry1.Edit;
      if  (DM.qry1.FieldValues[StrTemp[0]] - DM.qry1.FieldValues[StrTemp[1]]) < 0 then  DM.qry1.FieldByName(StrTemp[2]).Value:=0
      else DM.qry1.FieldByName(StrTemp[2]).Value := (DM.qry1.FieldValues[StrTemp[0]] - DM.qry1.FieldValues[StrTemp[1]]) / 2;
      DM.qry1.FieldByName(StrTemp[3]).Value := DM.qry1.FieldByName(StrTemp[2]).Value;
    end;
  end;
end;

//�����½���Աн�ʵ���
procedure TFrmMain.N5Click(Sender: TObject);
begin
  if  not strtoint(vprev) in [2, 4] then
  begin
    messagedlg('�Բ���! ����Ȩ�ޣ���д������������ϵ����Ա��',mtinformation,[mbok],0);
    Exit;
  end;
  if MessageBox(Handle,'����󲻿���ֱ�����޸ģ��Ժ�ֻ����н�ʵ�������ȷ��������?','��ʾ',MB_YESNO+MB_ICONWARNING+MB_DEFBUTTON2)=IDNO	then exit;
  DM.qry1.Edit;
  DM.qry1.FieldByName('freshflag').Value := 1;
  DM.qry1.UpdateBatch(arAll);
end;

procedure TFrmMain.N2Click(Sender: TObject);
var
  i: Integer;
begin
  FrmExcel := TFrmExcel.Create(nil);
  if FrmExcel.ShowModal = mrok then
  begin
    
  end;
  FrmExcel.Free;
  DM.qry1.Close;
  GetSalaryInfo(Sender);
  //GetItemsInfo(DM.salaryaccountrkey, '(1)');
  DM.qry1.Open;
  //BitBtn2Click(sender);
end;

procedure TFrmMain.BitBtn8Click(Sender: TObject);
var
 i:byte;
begin
with Query_Form do
 begin
      with dm.ADOTMP do
      begin
        close;
        sql.Text:='select getdate() as sys_date';
        open;
        dtpk2.Date:=StrToDateTime(fieldvalues['sys_date']);
        dtpk1.Date:=dtpk2.Date-31;
      end;

 if ShowModal=mrok then
    begin
      //ShowMessage('1');
      Q_salary_new_str:='and 1=1 ';
     for i:=1 to SGrid1.RowCount-2 do
      Q_salary_new_str:= Q_salary_new_str+SGrid1.Cells[2,i]+#13;
     try
       //ShowMessage('2');
        DM.qry1.Close;
        GetSalaryInfo(Sender);
        //GetItemsInfo(DM.salaryaccountrkey, '(1)');
        DM.qry1.Open;
       //FrmMain.GetSalaryInfo(Sender);
     except
      showmessage('��ѯʧ��');
      end;
    end;
  end;
end;

procedure TFrmMain.N6Click(Sender: TObject);
begin
  if  not strtoint(vprev) in [4] then
  begin
    messagedlg('�Բ���! ����Ȩ�ޣ�д��������������ϵ����Ա��',mtinformation,[mbok],0);
    Exit;
  end;
  //if MessageBox(Handle,'����󲻿���ֱ�����޸ģ��Ժ�ֻ����н�ʵ�������ȷ��������?','��ʾ',MB_YESNO+MB_ICONWARNING+MB_DEFBUTTON2)=IDNO	then exit;
  DM.ADOTMP.SQL.Clear;
  DM.ADOTMP.SQL.Text := 'select * from basicsalary_alteration where employeeid='+inttostr(DM.qry1.FieldByName('rkey').Value);
  try
    dm.ADOTMP.Open;
    if  dm.ADOTMP.Eof  then
    begin
      DM.qry1.Edit;
      DM.qry1.FieldByName('freshflag').Value := 0;
      DM.qry1.UpdateBatch(arAll);
    end
  else
    begin
      ShowMessage('�Ѿ��е�н��¼���޷�����!');
      DM.adotmp.Close;
    end;
  except
    begin
      ShowMessage('�ж��Ƿ��е�н��¼��ʱ��ʧ��');
      exit;
    end;
  end;    
end;

procedure TFrmMain.BitBtn9Click(Sender: TObject);
begin
      try
          frm_hideitem :=Tfrm_hideitem.Create(nil);
        if frm_hideitem.ShowModal=mrok then
          begin
          end;
      finally
          frm_hideitem.Free;
      end;
end;

procedure TFrmMain.Action1Execute(Sender: TObject);
begin
  bitbtn9.Visible := true;
end;

end.



