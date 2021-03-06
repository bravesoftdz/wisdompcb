unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, Menus, Grids, DBGrids, Clipbrd, ComCtrls,
  copy_product;

type
  TForm1 = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    BitBtn1: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    Edit1: TEdit;
    PopupMenu2: TPopupMenu;
    DBGrid1: TDBGrid;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    Panel2: TPanel;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    CheckBox6: TCheckBox;
    CheckBox7: TCheckBox;
    N5: TMenuItem;
    BitBtn6: TBitBtn;
    N6: TMenuItem;
    N7: TMenuItem;
    design_report: TPopupMenu;
    MI1: TMenuItem;
    ECN1: TMenuItem;
    N8: TMenuItem;
    C1: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    TreeView1: TTreeView;
    N11: TMenuItem;
    nN12: TMenuItem;
    mniCopyAll: TMenuItem;
    MI2: TMenuItem;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure BitBtn5Click(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure Edit1Change(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormCreate(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure MI1Click(Sender: TObject);
    procedure ECN1Click(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure C1Click(Sender: TObject);
    procedure N9Click(Sender: TObject);
    procedure N10Click(Sender: TObject);
    procedure N11Click(Sender: TObject);
    procedure nN12Click(Sender: TObject);
    procedure mniCopyAllClick(Sender: TObject);
    procedure MI2Click(Sender: TObject);
  private
    { Private declarations }
    PreColumn: TColumn;
    sql_text: tstringlist;
    OldGridWnd: TWndMethod;
    apnl_qty, apnl_pcs, bpnl_qty, bpnl_pcs, lam2: string;
//   rkey08,sales_flag,rkey10,rkey25,rkey15 :integer;
    procedure NewGridWnd(var Message: TMessage);
    procedure item_click(sender: TObject);
    function find_error(): boolean;
    function find_cutparameter_erroe(rkey25: Integer): Boolean;
    function find_LAMparameter_erroe(rkey25: Integer): Boolean;
    function find_allerror(rkey25: integer): boolean;
    function find_rkey278(rkey278: integer; link_database: string): integer;
    function find_rkey34(rkey34: integer; link_database: string): integer;
    function set_lock(rkey25: string; modal: byte): boolean;  //modal：1编辑
    procedure get_treedate(rkey25: integer; treeview: Ttreeview);
    function get_date0025toprkey(rkey25: integer): integer;
    function table_name(): string;
  public
    { Public declarations }
    procedure CopyAllMIStruct(ASelfrkey25, ASOurceRkey25: Integer);
    function CopyOneMiStruct(var ASelfrkey25: Integer; AParentRkey25, ASourceRkey25: Integer): Boolean;
    procedure CopyMI(AFrm: TForm3; ATag: Integer);
    function CheckSpeck_UZ: Boolean; //检查参数 板料尺寸UZ 是否全部一致
  end;

var
  Form1: TForm1;

implementation

uses
  damo, common, term, product_MIDetail, append_productin, report_data,
  reportselect, report_data1, DB, ADODB, quality_trace, product_search,
  MITreeFrm, note_information, StrUtils;

{$R *.dfm}

function TForm1.set_lock(rkey25: string; modal: byte): boolean;  //modal：1编辑
begin
  result := false;
  with dm.aqtmp do
  begin
    Close;
    SQL.Text := 'if exists(SELECT * FROM tempdb.dbo.sysobjects WHERE NAME=' + quotedstr(rkey25) + ')' + #13 + ' select data0073.USER_FULL_NAME from ' + rkey25 + ' inner join data0073 on' + #13 + rkey25 + '.rkey73=data0073.rkey' + #13 + ' else select top 0 * from data0025 ';
    Open;
    if not isempty then
      messagedlg('当前记录被用户:' + fieldbyname('USER_FULL_NAME').AsString + '锁定,无法操作!', mtwarning, [mbok], 0)
    else
    begin
      if modal = 1 then  //如果为编辑则创建表,插入锁定的创建的系统用户
      begin
        close;
        SQL.Text := 'select ' + rkey73 + 'as rkey73 into ' + rkey25;
        execsql;
      end;
      result := true;
    end;
  end;
end;

procedure TForm1.FormCreate(Sender: TObject);

begin
  if not app_init_2(dm.ADOConnection1) then
  begin
    showmsg('程序起动失败,请联系管理员!', 1);
    application.Terminate;
    exit;
  end;
  self.caption := application.Title;


// rkey73:='1';
// vprev:='4';
// DM.ADOConnection1.Open;

  DateSeparator := '-';
  ShortDateFormat := 'yyyy-mm-dd';
  OldGridWnd := DBGrid1.WindowProc;
  DBGrid1.WindowProc := NewGridWnd;
end;

procedure TForm1.NewGridWnd(var Message: TMessage);
var
  IsNeg: Boolean;
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

procedure tform1.item_click(sender: TObject);
var
  i: byte;
begin
  (sender as tmenuItem).Checked := not ((sender as tmenuItem).Checked);
  if (sender as tmenuItem).Checked then
  begin
    for i := 0 to dbgrid1.FieldCount - 1 do
      if dbgrid1.Columns[i].Title.Caption = (sender as tmenuItem).Caption then
      begin
        dbgrid1.Columns[i].Visible := true;
        break;
      end;
  end
  else
  begin
    for i := 0 to dbgrid1.FieldCount - 1 do
      if dbgrid1.Columns[i].Title.Caption = (sender as tmenuItem).Caption then
      begin
        dbgrid1.Columns[i].Visible := false;
        break;
      end;
  end;
end;

function TForm1.find_error: boolean;
begin
  result := false;

  if trim(dm.AQY0025MANU_PART_NUMBER.Value) = '' then
  begin
    messagedlg('本厂编号不允许为空!', mterror, [mbcancel], 0);
    result := true;
    exit;
  end;

  if trim(dm.AQY0025MANU_PART_DESC.Value) = '' then
  begin
    messagedlg('客户型号不允许为空!', mterror, [mbcancel], 0);
    result := true;
    exit;
  end;

  if dm.AQY0025PARENT_PTR.Value > 0 then
  begin
    if dm.AQY0025QTY_BOM.Value <= 0 then
    begin
      messagedlg(dm.AQY0025MANU_PART_NUMBER.Value + '压合比例分子输入有误!', mterror, [mbcancel], 0);
      result := true;
      exit;
    end;

    if dm.AQY0025QTY_PARENTBOM.Value <= 0 then
    begin
      messagedlg(dm.AQY0025MANU_PART_NUMBER.Value + '压合比例分母输入有误!', mterror, [mbcancel], 0);
      result := true;
      exit;
    end;

    if dm.AQY0025BOM_STEP.Value <= 0 then
    begin
      messagedlg(dm.AQY0025MANU_PART_NUMBER.Value + '压合步骤输入有误!', mterror, [mbcancel], 0);
      result := true;
      exit;
    end
    else
    begin
      with dm.ADOQuery1 do
      begin
        close;
        sql.Text := 'SELECT Data0038.STEP_NUMBER, dbo.Data0034.DEPT_CODE,' + #13 + 'Data0034.DEPT_NAME, Data0034.BARCODE_ENTRY_FLAG' + #13 + 'FROM Data0038 INNER JOIN' + #13 + 'dbo.Data0034 ON dbo.Data0038.DEPT_PTR = dbo.Data0034.RKEY' + #13 + 'where data0038.SOURCE_PTR=' + dm.AQY0025PARENT_PTR.AsString + #13 + 'and Data0038.STEP_NUMBER=' + dm.AQY0025BOM_STEP.AsString + #13 + 'and data0034.IS_COST_DEPT=1 and data0034.BARCODE_ENTRY_FLAG=''Y''';
        open;
      end;
      if dm.ADOQuery1.IsEmpty then
      begin
        messagedlg(dm.AQY0025MANU_PART_NUMBER.Value + '压合步骤输入有误,步骤号在父层中没有找到对应的工序!', mterror, [mbcancel], 0);
        result := true;
        exit;
      end
    end;
  end;

  if (dm.AQY0025SO_UNIT.Value = '无要求') or (trim(dm.AQY0025SO_UNIT.Value) = '') then
  begin
    messagedlg('没有确定最终交货形式!', mterror, [mbcancel], 0);
    result := true;
    exit;
  end;

  dm.ads279.close;                           //全局参数
  dm.ads279.Parameters[0].Value := dm.AQY0025RKEY.Value;
  dm.ads279.Open;
  if dm.ads279.IsEmpty then
  begin
    messagedlg(dm.AQY0025MANU_PART_NUMBER.Value + '还没有输入全局参数!', mterror, [mbcancel], 0);
    result := true;
    dm.ads279.close;
    exit;
  end
  else
    while not dm.ads279.Eof do
    begin
      if (dm.ads279status3.Value = 1) and (trim(dm.ads279PARAMETER_VALUE.Value) = '') then
      begin
        messagedlg(dm.AQY0025MANU_PART_NUMBER.Value + '全局参数为不允许为空的重要参数!', mterror, [mbcancel], 0);
        result := true;
        dm.ads279.close;
        exit;
      end;
      dm.ads279.Next;
    end;
  dm.ads279.close;

  dm.ads494.Close;                      //制程参数
  dm.ads494.Parameters[0].Value := dm.AQY0025RKEY.Value;
  DM.ads494.Open;
  dm.ads494.Filter := '';
  while not dm.ads494.Eof do
  begin
    if (dm.ads494flow_spfc_flag.Value = 'Y') and     // 重点参数
      (dm.ads494after_flag.Value <> 'Y') and       //不是后补参数
      (trim(dm.ads494PARAMETER_VALUE.Value) = '') then   //参数为空
    begin
      messagedlg('第' + DM.ads494step_number.AsString + '步制程参数为不允许为空的重要参数!', mterror, [mbcancel], 0);
      result := true;
      dm.ads494.Close;
      exit;
    end;
    dm.ads494.Next;
  end;
  dm.ads494.Close;

end;

function TForm1.find_cutparameter_erroe(rkey25: Integer): Boolean;
begin
  Result := False;
  with dm.ADOQuery1 do
  begin
    Close;
    sql.Text := 'SELECT  Data0279.PARAMETER_VALUE,Data0278.SPEC_RKEY ' + 'FROM    dbo.Data0279 INNER JOIN ' + 'dbo.Data0278 ON dbo.Data0279.PARAMETER_PTR = dbo.Data0278.RKEY ' + 'WHERE     (dbo.Data0278.SPEC_RKEY IN (''1'', ''2'', ''3'', ''4'')) ' + 'AND (dbo.Data0279.SOURCE_PTR = ' + inttostr(rkey25) + ') ' + 'AND (dbo.Data0279.IES_PROD = 1) ' + 'ORDER BY dbo.Data0278.SPEC_RKEY';
    Open;
    while not Eof do
    begin
      if (Trim(FieldByName('spec_rkey').AsString) = '1') and (Self.apnl_qty <> Trim(FieldByName('PARAMETER_VALUE').AsString)) then
      begin
        Result := True;
        Break;
      end
      else if (Trim(FieldByName('spec_rkey').AsString) = '2') and (Self.bpnl_qty <> Trim(FieldByName('PARAMETER_VALUE').AsString)) then
      begin
        Result := True;
        Break;
      end
      else if (Trim(FieldByName('spec_rkey').AsString) = '3') and (Self.apnl_pcs <> Trim(FieldByName('PARAMETER_VALUE').AsString)) then
      begin
        Result := True;
        Break;
      end
      else if (Trim(FieldByName('spec_rkey').AsString) = '4') and (Self.bpnl_pcs <> Trim(FieldByName('PARAMETER_VALUE').AsString)) then
      begin
        Result := True;
        Break;
      end;

      dm.ADOQuery1.Next;
    end;
  end;
end;

function TForm1.find_allerror(rkey25: integer): boolean;
begin
  result := false;
  with dm.ADOQuery3 do                      //第二层
  begin
    close;
    sql.Text := 'select rkey,MANU_PART_NUMBER from data0025 where parent_ptr=' + inttostr(rkey25);
    open;
    while not dm.ADOQuery3.Eof do
    begin
      dm.AQY0025.Close;
      dm.AQY0025.Parameters[0].Value := dm.ADOQuery3.FieldValues['rkey'];
      dm.AQY0025.Open;
      if not self.find_error then
      begin
        if self.find_cutparameter_erroe(dm.AQY0025RKEY.Value) then
        begin
          if MessageBox(Handle, PChar(dm.AQY0025MANU_PART_NUMBER.Value + '与外层开料参数不一致,是否继续.'), '提示', MB_YESNO) = IDYes then
          begin

          end
          else
          begin
            result := true;
            break;
          end;
        end;
        if self.find_LAMparameter_erroe(dm.AQY0025RKEY.Value) then
        begin
          if MessageBox(Handle, PChar(dm.AQY0025MANU_PART_NUMBER.Value + '板料规格不一致，是否继续.'), '提示', MB_YESNO) = IDYes then
          begin

          end
          else
          begin
            result := true;
            break;
          end;
        end;
        with dm.ADOQuery2 do         //第三层
        begin
          close;
          sql.Text := 'select rkey,MANU_PART_NUMBER from data0025 where parent_ptr=' + dm.ADOQuery3.fieldbyname('rkey').AsString;
          open;
          while not dm.ADOQuery2.Eof do
          begin
            dm.AQY0025.Close;
            dm.AQY0025.Parameters[0].Value := dm.ADOQuery2.FieldValues['rkey'];
            dm.AQY0025.Open;
            if not self.find_error then
            begin
              if self.find_cutparameter_erroe(dm.AQY0025RKEY.Value) then
              begin
                if MessageBox(Handle, PChar(dm.AQY0025MANU_PART_NUMBER.Value + '与外层开料参数不一致,是否继续.'), '提示', MB_YESNO) = IDYes then
                begin

                end
                else
                begin
                  result := true;
                  break;
                end;

              end;
              if self.find_LAMparameter_erroe(dm.AQY0025RKEY.Value) then
              begin
                if MessageBox(Handle, PChar(dm.AQY0025MANU_PART_NUMBER.Value + '板料规格不一致，是否继续.'), '提示', MB_YESNO) = IDYes then
                begin

                end
                else
                begin
                  result := true;
                  break;
                end;
              end;
              with dm.ADOQuery4 do         //第四层
              begin
                close;
                sql.Text := 'select rkey,MANU_PART_NUMBER from data0025 where parent_ptr=' + dm.ADOQuery2.fieldbyname('rkey').AsString;
                open;
                while not dm.ADOQuery4.Eof do
                begin
                  dm.AQY0025.Close;
                  dm.AQY0025.Parameters[0].Value := dm.ADOQuery4.FieldValues['rkey'];
                  dm.AQY0025.Open;
                  if not self.find_error then
                  begin
                    if self.find_cutparameter_erroe(dm.AQY0025RKEY.Value) then
                    begin
                      if MessageBox(Handle, PChar(dm.AQY0025MANU_PART_NUMBER.Value + '与外层开料参数不一致,是否继续.'), '提示', MB_YESNO) = IDYes then
                      begin

                      end
                      else
                      begin
                        result := true;
                        break;
                      end;

                    end;
                    if self.find_LAMparameter_erroe(dm.AQY0025RKEY.Value) then
                    begin
                      if MessageBox(Handle, PChar(dm.AQY0025MANU_PART_NUMBER.Value + '板料规格不一致，是否继续.'), '提示', MB_YESNO) = IDYes then
                      begin

                      end
                      else
                      begin
                        result := true;
                        break;
                      end;
                    end;
                  end
                  else
                  begin
                    result := true;
                    break;
                  end;
                  dm.ADOQuery4.Next;
                end;
              end;
            end
            else
            begin
              result := true;
              break;
            end;
            dm.ADOQuery2.Next;
          end;
        end;
      end
      else
      begin
        result := true;
        break;
      end;
      dm.ADOQuery3.Next;
    end;
  end;
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
  application.Terminate;
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
begin
  Export_dbGrid_to_Excel(dbgrid1, self.Caption)
end;

procedure TForm1.FormShow(Sender: TObject);
var
  i: byte;
  item: TMenuItem;
begin
  if dm.ADOConnection1.Connected then
  begin
    dm.ads82.Open;
    PreColumn := DBGrid1.Columns[0];
    dm.ADS25.Close;
    dm.ADS25.Parameters.ParamByName('dtpk1').Value := getsystem_date(dm.adoquery1, 1) - 90;
    dm.ADS25.Parameters.ParamByName('dtpk2').Value := getsystem_date(dm.adoquery1, 1);
    dm.ADS25.Prepared;
    dm.ADS25.Open;
    sql_text := tstringlist.Create;
    sql_text.Text := dm.ADS25.CommandText;
    for i := 1 to dbgrid1.FieldCount do
    begin
      item := TmenuItem.Create(self);
      item.Caption := dbgrid1.Columns[i - 1].Title.Caption;
      if dbgrid1.Columns[i - 1].Visible then
        item.Checked := true;
      item.OnClick := item_click;
      self.PopupMenu2.Items.Add(item);
    end;
    with dm.adoquery4 do
    begin
      close;
      sql.Clear;
      sql.Add('select EMPLOYEE_PTR from data0073');
      sql.Add('where rkey=' + rkey73);
      open;
      user_ptr := fieldbyname('employee_ptr').asstring;
    end;
  end;
end;

procedure TForm1.DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if (chr(Key) = 'V') and (ssalt in Shift) then
    showmessage(dm.ADs25.CommandText);
end;

procedure TForm1.BitBtn5Click(Sender: TObject);
begin
  PopupMenu2.Popup(mouse.CursorPos.X, mouse.CursorPos.Y);
end;

procedure TForm1.DBGrid1TitleClick(Column: TColumn);
begin
  if (Column.FieldName <> dm.ADs25.IndexFieldNames) then
    dm.ADs25.IndexFieldNames := Column.FieldName;

  if (Column.ReadOnly) and (PreColumn <> Column) then
  begin
    label1.Caption := Column.Title.Caption;
    edit1.SetFocus;
    PreColumn.Title.Color := clBtnFace;
    Column.Title.Color := clred;
    PreColumn := Column;
  end
  else
    edit1.SetFocus;
end;

procedure TForm1.Edit1Change(Sender: TObject);
begin
  if trim(Edit1.text) <> '' then
    dm.ADs25.Filter := PreColumn.FieldName + ' like ''%' + trim(edit1.text) + '%'''
  else
    dm.ADs25.filter := '';
end;

procedure TForm1.BitBtn3Click(Sender: TObject);
var
  rkey: integer;
begin
  rkey := dm.ads25rKEY.Value;
  dm.ADS25.Close;
  dm.ADS25.Prepared;
  dm.ADS25.Open;
  if rkey > 0 then
    dm.ADS25.Locate('rkey', rkey, []);
end;

procedure TForm1.BitBtn4Click(Sender: TObject);
var
  i: byte;
begin
  form_condition.dtpk1.Date := dm.ADs25.Parameters.ParamValues['dtpk1'];
  form_condition.dtpk2.Date := dm.ADs25.Parameters.ParamValues['dtpk2'];
  if form_condition.ShowModal = mrok then
  begin

    sql_text.Delete(24);
    sql_text.Delete(24);

    case form_condition.ComboBox2.ItemIndex of
      0:
        begin
          sql_text.Insert(24, 'where data0025.CUSTPART_ENT_DATE >=:dtpk1 and');
          sql_text.Insert(25, 'data0025.CUSTPART_ENT_DATE-1 <=:dtpk2 and');
        end;
      1:
        begin
          sql_text.Insert(24, 'where data0025.LAST_MODIFIED_DATE >=:dtpk1 and');
          sql_text.Insert(25, 'data0025.LAST_MODIFIED_DATE-1 <=:dtpk2 and');
        end;
      2:
        begin
          sql_text.Insert(24, 'where data0025.AUDITED_DATE >=:dtpk1 and');
          sql_text.Insert(25, 'data0025.AUDITED_DATE-1 <=:dtpk2 and');
        end;
    end;

    dm.ADs25.Close;
    dm.ADs25.CommandText := sql_text.Text;
    for i := 1 to form_condition.SGrid1.RowCount - 2 do
      dm.ADs25.CommandText := dm.ADs25.CommandText + form_condition.SGrid1.Cells[2, i] + #13;
    dm.ADs25.Parameters.ParamByName('dtpk1').Value := form_condition.dtpk1.Date;
    dm.ADs25.Parameters.ParamByName('dtpk2').Value := form_condition.dtpk2.Date;
    dm.ADS25.Prepared;
    dm.ADs25.Open;
  end;
end;

procedure TForm1.CheckBox1Click(Sender: TObject);
begin
  dm.ADS25.Close;
  if checkbox1.Checked then
    dm.ADS25.Parameters.ParamValues['v6'] := 9
  else
    dm.ADS25.Parameters.ParamValues['v6'] := 6;

  if checkbox2.Checked then
    dm.ADS25.Parameters.ParamValues['v0'] := 9
  else
    dm.ADS25.Parameters.ParamValues['v0'] := 0;

  if checkbox3.Checked then
    dm.ADS25.Parameters.ParamValues['v3'] := 9
  else
    dm.ADS25.Parameters.ParamValues['v3'] := 3;

  if checkbox4.Checked then
    dm.ADS25.Parameters.ParamValues['v4'] := 9
  else
    dm.ADS25.Parameters.ParamValues['v4'] := 4;

  if checkbox5.Checked then
    dm.ADS25.Parameters.ParamValues['v1'] := 9
  else
    dm.ADS25.Parameters.ParamValues['v1'] := 1;

  if checkbox6.Checked then
    dm.ADS25.Parameters.ParamValues['v5'] := 9
  else
    dm.ADS25.Parameters.ParamValues['v5'] := 5;

  if checkbox7.Checked then
    dm.ADS25.Parameters.ParamValues['v2'] := 9
  else
    dm.ADS25.Parameters.ParamValues['v2'] := 2;
  dm.ADS25.Prepared;
  dm.ADS25.Open;
end;

procedure TForm1.N1Click(Sender: TObject);
var
  rkey: integer;
begin
  if (strtoint(vprev) = 1) or (strtoint(vprev) = 3) then
    messagedlg('对不起!您没有该程序的可写权限', mtinformation, [mbok], 0)
  else if set_lock(self.table_name(), 1) then  //锁定成功
  begin
    dm.AQY0025.Close;
    dm.AQY0025.Parameters[0].Value := dm.ADS25rkey.Value;
    dm.AQY0025.Open;

    if dm.AQY0025TSTATUS.Value = dm.ads25TSTATUS.Value then
    try
      application.CreateForm(tForm2, Form2);
   dm.qryTmp.Close;
   dm.qryTmp.SQL.Text := 'select * from Print2D_BarDef where rkey = ' + IntToStr(dm.AQY0025.fieldbyname('print2dkey').asinteger);
   dm.qryTmp.Open;

    if not dm.qryTmp.IsEmpty then
    begin

      Form2.edtPrint2D.Text := dm.qryTmp.fieldbyname('BarName').AsString;
      Form2.edtPrint2D.Tag := dm.AQY0025.fieldbyname('print2dkey').AsInteger;

    end;


      dm.AQY0025.Edit;
      dm.AQY0025LAST_MODIFIED_DATE.Value := getsystem_date(dm.adoquery1, 0);
      dm.AQY0025LAST_MODIFIED_BY_PTR.Value := strtoint(user_ptr);
//   dm.AQY0025TSTATUS.Value:=0;
      if form2.ShowModal = mrok then
      begin
        rkey := dm.ADS25rkey.Value;
        dm.ADS25.Close;
        dm.ADS25.Prepared;
        dm.ADS25.Open;
        if rkey > 0 then
          dm.ADS25.Locate('rkey', rkey, []);
      end;

      with dm.aqtmp do   //无论保存或退出都删除锁定的记录
      begin
        Close;
        SQL.Text := 'if exists(SELECT * FROM tempdb.dbo.sysobjects WHERE NAME=' + quotedstr(table_name) + ')' + #13 + ' drop table ' + self.table_name();
        execsql;
      end;

    finally
      form2.free;
    end
    else
      messagedlg('状态发生变更不能编辑', mtinformation, [mbcancel], 0);
  end;

end;

procedure TForm1.N2Click(Sender: TObject);
begin
  try
    application.CreateForm(tForm2, Form2);
    dm.AQY0025.Close;
    dm.AQY0025.Parameters[0].Value := dm.ADS25rkey.Value;
    dm.AQY0025.Open;
    form2.status.Caption := '1'; //代表检查

   dm.qryTmp.Close;
   dm.qryTmp.SQL.Text := 'select * from Print2D_BarDef where rkey = ' + IntToStr(dm.AQY0025.fieldbyname('print2dkey').asinteger);
   dm.qryTmp.Open;

    if not dm.qryTmp.IsEmpty then
    begin

      Form2.edtPrint2D.Text := dm.qryTmp.fieldbyname('BarName').AsString;
      Form2.edtPrint2D.Tag := dm.AQY0025.fieldbyname('print2dkey').AsInteger;

    end;

    if form2.ShowModal = mrok then
    begin

    end;
  finally
    form2.free;
  end
end;

procedure TForm1.N3Click(Sender: TObject);
var
  ENG_CONTROL: byte;
  infor: string;
begin

  if (strtoint(vprev) = 1) or (strtoint(vprev) = 3) then
    messagedlg('对不起!您没有该程序的可写权限', mtinformation, [mbok], 0)
  else if set_lock(Self.table_name(), 0) then  //未锁定
  begin
    dm.AQY0025.Close;
    dm.AQY0025.Parameters[0].Value := dm.ADS25rkey.Value;
    dm.AQY0025.Open;

    //黄志辉需求
    //当全局拼版尺寸和工序中拼版尺寸不一致的时候，则提示
    //2017-6-22
    if not CheckSpeck_UZ then Exit;
    //-------
    //-------2017-6-22 end-----



    if dm.AQY0025TSTATUS.Value = dm.ads25TSTATUS.Value then
    begin
      if not self.find_error then     //查找首层线路错误数据
      begin
        with dm.ADOQuery1 do
        begin
          Close;
          sql.Text := 'SELECT  Data0279.PARAMETER_VALUE,Data0278.SPEC_RKEY ' + 'FROM    dbo.Data0279 INNER JOIN ' + 'dbo.Data0278 ON dbo.Data0279.PARAMETER_PTR = dbo.Data0278.RKEY ' + 'WHERE     (dbo.Data0278.SPEC_RKEY IN (''1'', ''2'', ''3'', ''4'', ''u'')) ' + 'AND (dbo.Data0279.SOURCE_PTR = ' + dm.AQY0025RKEY.AsString + ') ' + 'AND (dbo.Data0279.IES_PROD = 1) ' + 'ORDER BY dbo.Data0278.SPEC_RKEY';
          Open;
          while not Eof do
          begin
            if Trim(FieldByName('spec_rkey').AsString) = '1' then
              Self.apnl_qty := Trim(FieldByName('PARAMETER_VALUE').AsString)
            else if Trim(FieldByName('spec_rkey').AsString) = '2' then
              Self.bpnl_qty := Trim(FieldByName('PARAMETER_VALUE').AsString)
            else if Trim(FieldByName('spec_rkey').AsString) = '3' then
              Self.apnl_pcs := Trim(FieldByName('PARAMETER_VALUE').AsString)
            else if Trim(FieldByName('spec_rkey').AsString) = '4' then
              Self.bpnl_pcs := Trim(FieldByName('PARAMETER_VALUE').AsString)
            else if UpperCase(Trim(FieldByName('spec_rkey').AsString)) = 'U' then
              Self.lam2 := Trim(FieldByName('PARAMETER_VALUE').AsString);
            next;
          end;
        end;

        if not self.find_allerror(dm.AQY0025RKEY.Value) then  //查找内层错误数据
        begin
          with dm.ADOQuery1 do
          begin
            close;
            sql.Text := 'SELECT ENG_CONTROL1 FROM dbo.Data0192';
            open;
            ENG_CONTROL := fieldbyname('ENG_CONTROL1').AsInteger; //提交后是否检查
          end;
          dm.AQY0025.Close;
          dm.AQY0025.Parameters[0].Value := dm.ADS25rkey.Value;
          dm.AQY0025.Open;
          dm.AQY0025.Edit;
          if ENG_CONTROL = 0 then     //提交后无需工程检查直接进入待审核
            dm.AQY0025TSTATUS.Value := 4
          else                      //提交后需要先进入待检查状态
            dm.AQY0025TSTATUS.Value := 3;
          dm.AQY0025ALLOW_EDIT_FLAG.Value := 'N';
          dm.AQY0025.Post;
     //---提交前提示与此产品拼版尺寸或交货尺寸相同的产品，工程做防呆设计
          dm.ads279.close;   //全局参数
          dm.ads279.Parameters[0].Value := dm.AQY0025RKEY.Value;
          dm.ads279.Open;
          application.CreateForm(Tform2, form2);
          infor := '';
          if dm.AQY0025ttype.Value = 0 then  //量产板才做防呆检查
            if form2.find_setpnlmin(infor) then
              showmsg('产品:' + infor + '与本产品拼版尺寸相同或交货尺寸非常接近，建议增加工程防呆设计！', 1);
          if infor <> '' then
          begin
            infor := '产品:' + infor + '与本产品拼版尺寸相同或交货尺寸非常接近，建议增加工程防呆设计!';
            clipboard.Clear;
            Clipboard.AsText := infor;
          end;
          form2.Free;
          dm.ads279.close;
          dm.AQY0025.Close;
          bitbtn3click(Sender);
        end;
      end;
    end
    else
    begin
      messagedlg('状态发生变更不能提交!', mtinformation, [mbcancel], 0);
      dm.AQY0025.Close;
    end;
  end;
end;

procedure TForm1.N5Click(Sender: TObject);
begin

  if (strtoint(vprev) = 1) or (strtoint(vprev) = 3) then
    messagedlg('对不起!您没有该程序的可写权限', mtinformation, [mbok], 0)
  else if messagedlg('您确认将该产品退回吗?', mtConfirmation, [mbYes, mbNo], 0) = mrYes then
    if set_lock(self.table_name(), 0) then  //未锁定
    begin
      dm.AQY0025.Close;
      dm.AQY0025.Parameters[0].Value := dm.ADS25rkey.Value;
      dm.AQY0025.Open;
      if dm.AQY0025TSTATUS.Value = dm.ads25TSTATUS.Value then
      begin
        dm.AQY0025.Close;
        dm.AQY0025.Parameters[0].Value := dm.ADS25rkey.Value;
        dm.AQY0025.Open;
        dm.AQY0025.Edit;
        dm.AQY0025TSTATUS.Value := 6;
        dm.AQY0025ONHOLD_SALES_FLAG.Value := 0;
        dm.AQY0025.Post;
        with dm.ADOQuery1 do
        begin
          Close;
          SQL.Clear;
          SQL.Add('update data0273 set status=1 where CUSTOMER_PART_PTR=' + dm.ADS25rkey.AsString);
          ExecSQL;
        end;
        bitbtn3click(Sender);
      end
      else
        messagedlg('状态发生变更不能退回!', mtinformation, [mbcancel], 0);
    end;

end;

procedure TForm1.BitBtn6Click(Sender: TObject);
begin
  design_report.Popup(mouse.CursorPos.X, mouse.CursorPos.Y);
end;

procedure TForm1.N6Click(Sender: TObject);
var
   ckstr,STR1,STR2:string;
begin
  SetCurrentDir(extractfilepath(paramstr(0)));
  form_reportselect := tform_reportselect.Create(application);
  if form_reportselect.ShowModal = mrok then
  begin
    form_report := tform_report.Create(application);
    with form_report do
    begin
      ppReport1.Reset;
      ppReport1.Template.FileName := stringReplace(UpperCase(extractfilepath(paramstr(0))), 'EXEC\', 'NIERP\REPORT\', [rfReplaceAll]) + 'Manu_instruction.rtm';           //R:\NIERP\Report\Manu_instruction.rtm
      ppReport1.Template.LoadFromFile;
      ppreport1.SaveAsTemplate := false;

      ads192.Open;
      ads279.Close;
      ads279.Parameters.ParamValues['rkey'] := dm.ADS25rkey.Value;
      if ads192ENG_CONTROL16.Value = 1 then       //不显示为空的全局参数
        ads279.Parameters.ParamValues['value'] := ''
      else
        ads279.Parameters.ParamValues['value'] := '#@#@#';
      ads279.Open;

      ads25.Close;
      ads25.Parameters[0].Value := dm.ADS25rkey.Value;
      ads25.Open;

      ads494.Close;
      ads494.Parameters.ParamValues['source_ptr'] := dm.ADS25rkey.Value;
      if ads192ENG_CONTROL2.Value = 1 then       //不显示为空的制程参数
        ads494.Parameters.ParamValues['value'] := ''
      else
        ads494.Parameters.ParamValues['value'] := '#@#@#';
      ads494.Open;

      ads38.Close;
      ads38.Parameters.ParamValues['rkey'] := dm.ADS25rkey.Value;
      if form_reportselect.CheckBox3.Checked then
        ads38.Parameters.ParamValues['visible'] := 1
      else
        ads38.Parameters.ParamValues['visible'] := 2;
      ads38.Open;
      ads502.Open;
      //ads29.Open;
      ADS30.Open;
      //------------添加钻咀表条件-------------------
      with Form_reportselect do
      begin
       if (CheckBox4.Checked=False) and (CheckBox7.Checked=False)and (CheckBox8.Checked=False) then
       begin
        form_report.ppSubReport3.Visible := false;
       end
       else
       begin
        ckstr:='';
        if CheckBox4.Checked then ckstr:='0,';
        if CheckBox7.Checked then ckstr:=ckstr+'1,';
        if CheckBox8.Checked then ckstr:=ckstr+'2,';
        ads29.CommandText:=ads29.CommandText+'and flow_no IN('+ copy(ckstr,0,Length(ckstr)-1)+') ORDER BY SEQ_NO';
       end;
      end;
      ads29.Open;


      form_report.ppImage3.Picture.Assign(Load_JPG_Pic_From_DB(ads502DSDesigner));
      if ads502A3.Value > 0 then
        form_report.ppimage1.Picture.Assign(Load_JPG_Pic_From_DB(ads502A));

      if ads502B.AsVariant <> null then
        form_report.ppimage2.Picture.Assign(Load_JPG_Pic_From_DB(ads502B));

      if (not ADS25DSDesigner35.IsNull) and (form_reportselect.CheckBox6.Checked) then
      begin
        form_report.ppImage4.Visible := True;
        form_report.ppImage4.Picture.Assign(Load_JPG_Pic_From_DB(ADS25DSDesigner35));
      end
      else
        form_report.ppImage4.Visible := False;

      if not form_reportselect.CheckBox1.Checked then
        form_report.ppSubReport1.Visible := false;

      if not form_reportselect.CheckBox2.Checked then
        form_report.ppSubReport2.Visible := false;

      if not Form_reportselect.CheckBox5.Checked then
        Form_report.ppSubReport4.Visible := false;
    end;
    form_report.ppReport1.Print;
    form_report.Free;
  end;
  form_reportselect.Free;
end;

procedure TForm1.PopupMenu1Popup(Sender: TObject);
begin
  n1.Enabled := false;
  n2.Enabled := false;
  n3.Enabled := false;
  n4.Enabled := false;
  n5.Enabled := false;
  n6.Enabled := false;
  MI2.Enabled := false;
  n8.Enabled := false;
  n7.Enabled := false;
  c1.Enabled := false;
  n9.Enabled := false;
  N10.Enabled := false;
  nN12.Enabled := not DM.ADS25.IsEmpty;
  case dm.ADS25TSTATUS.Value of
    6:
      begin
        n2.Enabled := true;
        n7.Enabled := true;
      end;
    0:
      begin
        n1.Enabled := true;
        n2.Enabled := true;
        n3.Enabled := true;
        n4.Enabled := true;
        n5.Enabled := true;
        n6.Enabled := true;
        n8.Enabled := true;
        n7.Enabled := true;
        c1.Enabled := true;
        MI2.Enabled := true;
      end;
    3:
      begin
        n2.Enabled := true;
        n6.Enabled := true;
        MI2.Enabled := true;
        n8.Enabled := true;
        n7.Enabled := true;
      end;
    4:
      begin
        n2.Enabled := true;
        n6.Enabled := true;
        MI2.Enabled := true;
        n8.Enabled := true;
        n7.Enabled := true;
      end;
    1:
      begin
        n2.Enabled := true;
        n6.Enabled := true;
        MI2.Enabled := true;
        n8.Enabled := true;
        n7.Enabled := true;
        N9.Enabled := true;
        n10.Enabled := ((N9.Enabled) and (dm.ADS25quality_status.Value = false));
      end;
    5:
      begin
        n1.Enabled := true;
        n2.Enabled := true;
        n5.Enabled := true;
        n6.Enabled := true;
        MI2.Enabled := true;
        n8.Enabled := true;
        n7.Enabled := true;
      end;
    2:
      begin
        n1.Enabled := true;
        n2.Enabled := true;
        n5.Enabled := true;
        n6.Enabled := true;
        MI2.Enabled := true;
        n8.Enabled := true;
        n7.Enabled := true;
      end;
  end;

  if dm.ADS25.IsEmpty then
  begin
    n1.Enabled := false;
    n2.Enabled := false;
    n3.Enabled := false;
    n4.Enabled := false;
    n5.Enabled := false;
    n6.Enabled := false;
    n8.Enabled := false;
    n7.Enabled := false;
    c1.Enabled := false;
    N9.Enabled := false;
    N10.Enabled := false;
    MI2.Enabled := false;
  end;

  N11.Enabled := N3.Enabled;
  mniCopyAll.Enabled := N1.Enabled;

end;

procedure TForm1.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect; DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if (dm.ADS25TSTATUS.Value = 5) or (dm.ADS25TSTATUS.Value = 2) then
    DBGrid1.Canvas.Font.Color := clred
  else if (dm.ADS25TSTATUS.Value = 6) then
    DBGrid1.Canvas.Font.Color := cllime;

  DBGrid1.DefaultDrawColumnCell(Rect, DataCol, Column, State);

end;

procedure TForm1.DBGrid1DblClick(Sender: TObject);
begin
  if (dm.ADS25TSTATUS.Value = 5) or (dm.ADS25TSTATUS.Value = 2) then
    N7Click(Sender);
  if (dm.ADS25TSTATUS.Value = 0) then
    N1Click(Sender);
end;

procedure TForm1.N7Click(Sender: TObject);
begin
  with dm.ADOQuery1 do
  begin
    close;
    sql.Text := 'select FILE_POINTER,SOURCE_TYPE,memo_text,NOTE_PAD_LINE_1 from data0011' + #13 + 'where SOURCE_TYPE=25 and' + #13 + 'FILE_POINTER=' + dm.ADS25rkey.AsString;
    open;
    if not isempty then
      messagedlg('备注如下:' + #13 + fieldbyname('memo_text').AsString + #13 + fieldbyname('NOTE_PAD_LINE_1').AsString, mtinformation, [mbok], 0);
  end;
end;

procedure TForm1.MI1Click(Sender: TObject);
begin
  SetCurrentDir(extractfilepath(paramstr(0)));
  form_report := tform_report.Create(application);

  form_report.ppReport1.Reset;
  form_report.ppReport1.Template.FileName := stringReplace(UpperCase(extractfilepath(paramstr(0))), 'EXEC\', 'NIERP\REPORT\', [rfReplaceAll]) + 'Manu_instruction.rtm';
  form_report.ppReport1.Template.LoadFromFile;
  form_report.ppReport1.SaveAsTemplate := true;

  form_report.ppDesigner1.ShowModal;
  form_report.Free;
end;

procedure TForm1.ECN1Click(Sender: TObject);
begin
  SetCurrentDir(extractfilepath(paramstr(0)));
  form_report1 := tform_report1.Create(application);

  form_report1.ppReport1.Reset;
  form_report1.ppReport1.Template.FileName := stringReplace(UpperCase(extractfilepath(paramstr(0))), 'EXEC\', 'NIERP\REPORT\', [rfReplaceAll]) + 'ECN_LIST.RTM';        //R:\NIERP\Report\ECN_LIST.RTM
  form_report1.ppReport1.Template.LoadFromFile;
  form_report1.ppReport1.SaveAsTemplate := true;
  form_report1.ppDesigner1.ShowModal;
  form_report1.Free;
end;

procedure TForm1.N8Click(Sender: TObject);
begin
  SetCurrentDir(extractfilepath(paramstr(0)));
  Form_report1 := TForm_report1.Create(application);
  form_report1.ppReport1.Reset;
  form_report1.ppReport1.Template.FileName := stringReplace(UpperCase(extractfilepath(paramstr(0))), 'EXEC\', 'NIERP\REPORT\', [rfReplaceAll]) + 'ECN_LIST.RTM';
  form_report1.ppReport1.Template.LoadFromFile;
  form_report1.ppReport1.SaveAsTemplate := False;

  with form_report1 do
  begin
    aq35.Close;
    aq35.Parameters[0].Value := dm.ADS25rkey.Value;
    aq35.Open;
    ppreport1.Print;
  end;
  form_report1.Free;
end;

function TForm1.find_rkey278(rkey278: integer; link_database: string): integer;
begin
  with dm.ADOQuery3 do
  begin
    close;
    sql.Text := 'select rkey from data0278 where PARAMETER_NAME=' + '(select PARAMETER_NAME from ' + link_database + 'dbo.data0278 ' + 'where rkey=' + inttostr(rkey278) + ')';
    open;
    if IsEmpty then
      result := 0
    else
      result := fieldbyname('rkey').AsInteger;
  end;
end;

function TForm1.find_rkey34(rkey34: integer; link_database: string): integer;
begin
  with dm.ADOQuery3 do
  begin
    close;
    sql.Text := 'select rkey from data0034 where DEPT_CODE=' + '(select DEPT_CODE from ' + link_database + 'dbo.data0034 ' + 'where rkey=' + inttostr(rkey34) + ')';
    open;
    if IsEmpty then
      result := 0
    else
      result := fieldbyname('rkey').AsInteger;
  end;
end;

procedure TForm1.C1Click(Sender: TObject);
begin

  if (strtoint(vprev) = 1) or (strtoint(vprev) = 3) then
    messagedlg('对不起!您没有该程序的可写权限', mtinformation, [mbok], 0)
  else if set_lock(self.table_name(), 0) then  //未锁定
  try
    form3 := tform3.Create(application);

    if (Sender as Tmenuitem).Tag = 1 then
      with form3 do
      begin
        combobox2.Enabled := true;
        bitbtn5.Enabled := true;
      end;

    if form3.ShowModal = mrok then
    begin
      CopyMI(Form3, (Sender as TMenuItem).Tag);
    end;
  finally
    form3.Free;
  end;

end;

procedure TForm1.N9Click(Sender: TObject);
begin
  if (strtoint(vprev) = 1) or (strtoint(vprev) = 3) then
    messagedlg('对不起!您没有该程序的可写权限', mtinformation, [mbok], 0)
  else
  begin
    try
      application.CreateForm(tForm5, Form5);
      dm.AQY0025.Close;
      dm.AQY0025.Parameters[0].Value := dm.ADS25rkey.Value;
      dm.AQY0025.Open;
      if form5.ShowModal = mrok then
      begin
      end;
    finally
      form5.free;
    end
  end;
end;

procedure TForm1.N10Click(Sender: TObject);
var
  i, rkey0025: integer;
  node: ttreenode;
begin
  if (strtoint(vprev) = 1) or (strtoint(vprev) = 3) then
    messagedlg('对不起!您没有该程序的可写权限', mtinformation, [mbok], 0)
  else
  begin
    TreeView1.Items.Clear;
    self.get_treedate(dm.ADS25rkey.Value, treeview1);
    node := TreeView1.Items.Item[0];
    rkey0025 := 0;
    for i := 0 to TreeView1.Items.Count - 1 do
    begin
      TreeView1.Select(node);
      dm.ADO31.Close;
      dm.ADO31.Parameters[0].Value := Pinteger(TreeView1.Items.Item[i].data)^;
      dm.ADO31.Open;
      if dm.ADO31.IsEmpty then
      begin
        rkey0025 := Pinteger(TreeView1.Items.Item[i].data)^;
        break;
      end;
    end;
    if rkey0025 <> 0 then
    begin
      with dm.ADOQuery1 do
      begin
        close;
        sql.Text := 'select MANU_PART_NUMBER from data0025 where rkey=' + inttostr(rkey0025);
        open;
      end;
      showmessage('产品' + dm.ADOQuery1.fieldbyname('MANU_PART_NUMBER').AsString + '还没有品质跟踪信息！');
    end
    else
    begin
      dm.AQY0025.Close;
      dm.AQY0025.Parameters[0].Value := dm.ADS25rkey.Value;
      dm.AQY0025.Open;
      dm.AQY0025.Edit;
      dm.AQY0025quality_status.Value := true;
      dm.AQY0025quality_user.Value := strtoint(user_ptr);
      dm.AQY0025quality_date.Value := common.getsystem_date(dm.ADOQuery1, 0);
      dm.AQY0025.Post;
      BitBtn3Click(Sender);
      showmessage('产品品质跟踪信息提交成功！');
    end;
  end;
end;

function TForm1.get_date0025toprkey(rkey25: integer): integer;
var
  rkey: integer;
begin
  with dm.ADOQuery2 do
  begin
    close;
    sql.Text := 'select parent_ptr from data0025 where rkey=' + inttostr(rkey25);
    open;
    rkey := fieldbyname('parent_ptr').AsInteger; //等于父值
  end;

  if rkey <= 0 then
    rkey := rkey25       //如果产品顶层等于自己
  else
    with dm.ADOQuery2 do
    begin
      close;
      sql.Text := 'select parent_ptr from data0025 where rkey=' + inttostr(rkey);
      open;
      if FieldByName('parent_ptr').AsInteger > 0 then
      begin
        rkey := fieldbyname('parent_ptr').AsInteger;  //如果有爷爷等于爷爷值
        with dm.ADOQuery3 do
        begin
          close;
          sql.Text := 'select parent_ptr from data0025 where rkey=' + inttostr(rkey);
          open;
          if FieldByName('parent_ptr').AsInteger > 0 then
            rkey := fieldbyname('parent_ptr').AsInteger;  //如果有太公等于太公值
        end;
      end;
    end;
  result := rkey;
end;

procedure TForm1.get_treedate(rkey25: integer; treeview: Ttreeview);
var
  node: ttreenode;   //treeview控件的节点变量
  rkey0025: ^integer;
begin

  with dm.ADOQuery1 do
  begin
    close;
    sql.Text := 'select rkey,MANU_PART_NUMBER from data0025 where rkey=' + inttostr(get_date0025toprkey(rkey25));
    open;
    new(rkey0025);
    rkey0025^ := fieldvalues['rkey'];
    node := treeview.Items.AddObject(nil, fieldbyname('MANU_PART_NUMBER').AsString, rkey0025); //增加顶层节点
    node.ImageIndex := 0;  //为第一层节点定义图画
  end;

  with dm.ADOQuery1 do
  begin
    close;
    sql.Text := 'select rkey,MANU_PART_NUMBER from data0025 where parent_ptr=' + inttostr(get_date0025toprkey(rkey25));
    open;
    while not dm.ADOQuery1.Eof do
    begin
      new(rkey0025);
      rkey0025^ := dm.ADOQuery1.fieldvalues['rkey'];
      node := treeview.Items.AddChildObject(node, fieldbyname('MANU_PART_NUMBER').AsString, rkey0025);
      node.ImageIndex := 1;
      with dm.ADOQuery2 do
      begin
        close;
        sql.Text := 'select rkey,MANU_PART_NUMBER from data0025 where parent_ptr=' + dm.ADOQuery1.fieldbyname('rkey').AsString;
        open;
        while not dm.ADOQuery2.Eof do
        begin
          new(rkey0025);
          rkey0025^ := dm.ADOQuery2.fieldvalues['rkey'];
          node := treeview.Items.AddChildObject(node, dm.ADOQuery2.fieldbyname('MANU_PART_NUMBER').AsString, rkey0025);
          node.ImageIndex := 2;

          with dm.ADOQuery3 do
          begin
            close;
            sql.Text := 'select rkey,MANU_PART_NUMBER from data0025 where parent_ptr=' + dm.ADOQuery2.fieldbyname('rkey').AsString;
            open;
            while not dm.ADOQuery3.Eof do
            begin
              new(rkey0025);
              rkey0025^ := dm.ADOQuery3.fieldvalues['rkey'];
              node := treeview.Items.AddChildObject(node, dm.ADOQuery3.fieldbyname('MANU_PART_NUMBER').AsString, rkey0025);
              node.ImageIndex := 3;
              node := node.Parent;
              dm.ADOQuery3.Next;
            end;
          end;

          node := node.Parent;
          dm.ADOQuery2.Next;
        end;
      end;
      node := node.Parent; //节点指向其父节点值
      dm.ADOQuery1.Next;
    end;
  end;

  treeview.FullExpand; //全部展开
  treeview.Items[0].Selected := true;
end;

function TForm1.find_LAMparameter_erroe(rkey25: Integer): Boolean;
begin
  Result := False;
  with dm.ADOQuery1 do
  begin
    Close;
    sql.Text := 'SELECT  Data0279.PARAMETER_VALUE,Data0278.SPEC_RKEY ' + 'FROM    dbo.Data0279 INNER JOIN ' + 'dbo.Data0278 ON dbo.Data0279.PARAMETER_PTR = dbo.Data0278.RKEY ' + 'WHERE     (dbo.Data0278.SPEC_RKEY IN (''u'')) ' + 'AND (dbo.Data0279.SOURCE_PTR = ' + inttostr(rkey25) + ') ' + 'AND (dbo.Data0279.IES_PROD = 1) ' + 'ORDER BY dbo.Data0278.SPEC_RKEY';
    Open;
    while not Eof do
    begin
      if (UpperCase(Trim(FieldByName('spec_rkey').AsString)) = 'U') and (Self.lam2 <> Trim(FieldByName('PARAMETER_VALUE').AsString)) then
      begin
        Result := True;
        Break;
      end;
      dm.ADOQuery1.Next;
    end;
  end;
end;

procedure TForm1.N11Click(Sender: TObject);
var
  LFrm: TfrmMITree;
  LRkey, LBackNote: string;
  lsql: string;
  I: Integer;
begin
  if (strtoint(vprev) = 1) or (strtoint(vprev) = 3) then
  begin
    messagedlg('对不起!您没有该程序的可写权限', mtinformation, [mbok], 0);
    Exit;
  end;
  if not set_lock(Self.table_name(), 0) then
    exit; //未锁定

  LFrm := TfrmMITree.Create(Self);
  try
    LFrm.CreateTreeWithTopMiRkey25(DM.ADS25.fieldbyname('rkey').AsInteger);
    for I := 0 to Length(LFrm.FNodeArr) - 1 do
    begin
      if (LFrm.FNodeArr[I].d25status <> 0) and (LFrm.FNodeArr[I].d25status <> 5) then
        LFrm.FNodeArr[I].lockedcheck := 1;
    end;

    if LFrm.ShowModal = mrok then
    begin
      LRkey := LFrm.GetCheckRkey25;
      for I := 0 to Length(LFrm.FNodeArr) - 1 do
      begin
        if LFrm.IsNodeChecked(LFrm.FNodeArr[I].node) then
          LBackNote := LBackNote + LFrm.FNodeArr[I].node.Text + ' , ';
      end;

      DM.ADOConnection1.BeginTrans;
      try
        //填写日志
        if not DM.SqlOpen(' select EMPLOYEE_NAME, getdate() as dttime from data0005 where rkey= ' + user_ptr) then
          Exit;
        LBackNote := DM.qryTmp.fieldbyname('EMPLOYEE_NAME').AsString + ' 日期：' + DM.qryTmp.fieldbyname('dttime').AsString + ' 分层提交MI检查：' + LBackNote;
        lsql := 'insert into data0011(SOURCE_TYPE,FILE_POINTER,NOTE_PAD_LINE_1) ' + ' values(25,' + dm.ADS25rkey.AsString + ',' + QuotedStr(LBackNote) + ')';
        if not DM.SqlExec(lsql) then
          Exit;

        //分层提交
        lsql := 'update data0025 set TSTATUS = 3,ALLOW_EDIT_FLAG = ''N'' where rkey in ' + LRkey + ' and tstatus in (0,5) ';
        if not DM.SqlExec(lsql) then
          Exit;

        BitBtn3Click(BitBtn3);
        DM.ADOConnection1.CommitTrans;
        ShowMessage('操作成功');
      finally
        if DM.ADOConnection1.InTransaction then
        begin
          DM.ADOConnection1.RollbackTrans;
          ShowMessage('操作失败');
        end;
      end;
    end;
  finally
    LFrm.Free;
  end;

end;

procedure TForm1.nN12Click(Sender: TObject);
begin
  form11 := tform11.Create(application);
  form11.Caption := dm.ADS25MANU_PART_NUMBER.Value + ':变更记录';
  with dm.ADOQuery2 do
  begin
    close;
    sql.Clear;
    sql.Add('select user_login_name as USER_ID,USER_FULL_NAME,TRANS_DATE,TRANS_DESCRIPTION, ');
    sql.Add('FROM_STRING,TO_STRING,file_number');
    sql.Add('from data0318 inner join data0073 on');
    sql.Add('data0318.user_ptr=data0073.rkey');
    sql.Add('where CUSTOMER_PART_PTR=' + dm.ADS25rkey.AsString);
    open;
  end;
  while not dm.ADOQuery2.Eof do
  begin
    form11.Memo1.Lines.Add(dm.ADOQuery2.fieldbyname('trans_date').AsString + ' 系统用户:' + dm.ADOQuery2.fieldbyname('user_id').AsString + ' ' + dm.ADOQuery2.fieldbyname('user_full_name').AsString + dm.ADOQuery2.fieldbyname('TRANS_DESCRIPTION').AsString);
    form11.Memo1.Lines.Add(' 原值: ' + dm.ADOQuery2.fieldbyname('from_string').AsString + ' 变更后: ' + dm.ADOQuery2.fieldbyname('to_string').AsString + '   关联文件号:' + dm.ADOQuery2.fieldbyname('file_number').AsString);

    dm.ADOQuery2.Next;
  end;
  form11.ShowModal;
  form11.Free;
end;

function TForm1.table_name: string;
var
  pos_i: integer;
  Catalog, catalog_db: string;
begin
  pos_i := Pos('Catalog=', db_ptr);
  Catalog := Copy(db_ptr, pos_i + 8, Length(db_ptr) - (pos_i + 8));
  catalog_db := Copy(Catalog, 1, Pos(';', Catalog) - 1);
  Result := '##d25_' + dm.ADS25rkey.AsString + '_' + catalog_db;
end;

procedure TForm1.mniCopyAllClick(Sender: TObject);
var
  database: string;
begin
  DM.SqlOpen('select 1 from data0025 where PARENT_PTR = ' + DM.ADS25.fieldbyname('rkey').AsString);
  if not dm.qryTmp.IsEmpty then
  begin
    ShowMessage('该型号已经有了内层禁止复制');
    Exit;
  end;
  if not set_lock(self.table_name(), 0) then
    Exit;

  try
    form_product := tform_product.Create(application);
  //database:= '['+edit2.Text+'].'+
   //program_ini.ReadString('数据库',combobox2.Text,'')+'.';
    form_product.Caption := '全部复制数据'; //combobox2.Text +':'+ form_product.Caption;

    form_product.adoquery1.Close;
    form_product.adoquery1.CommandText := 'SELECT data0025.rkey,Data0025.MANU_PART_NUMBER,Data0025.MANU_PART_DESC, ' + 'Data0025.PROD_CODE_PTR,Data0025.CUSTOMER_PTR, ' + 'Data0025.PROD_ROUTE_PTR,Data0025.ONHOLD_SALES_FLAG,' + 'Data0008.PRODUCT_NAME, Data0010.CUST_CODE,Data0025.LAYERS, ' + 'case Data0025.ttype ' + 'when 0 then ''量产'' when 1 then ''样板''  end as batch_or_former ' + 'FROM ' + database + 'dbo.Data0008 INNER JOIN ' + database + 'dbo.Data0025 ON ' + 'Data0008.RKEY =Data0025.PROD_CODE_PTR INNER JOIN ' + database + 'dbo.Data0010 ON Data0025.CUSTOMER_PTR = Data0010.RKEY ' + 'where ' + //Data0025.MANU_PART_NUMBER like '+quotedstr(edit1.Text+'%')+
      ' data0025.PARENT_PTR is null and ONHOLD_SALES_FLAG = 0 ';
    form_product.adoquery1.Open;

    if form_product.adoquery1.IsEmpty then
    begin
      messagedlg('没有找到需要复制的产品', mtinformation, [mbcancel], 0);

    end
    else if form_product.ShowModal = mrok then
    begin
      CopyAllMIStruct(DM.ADS25.fieldbyname('rkey').AsInteger, Form_product.adoquery1.fieldbyname('rkey').AsInteger);
    end;
  finally
    Form_product.Free;
  end;
end;

procedure TForm1.CopyAllMIStruct(ASelfrkey25, ASOurceRkey25: Integer);
type
  TTreeStruct = record
    SourceRkey: integer;
    SelfRkey: integer;
  end;
var
  LQry: TADOQuery;
  LSql: string;
  LSelfRkey, LParentRkey: Integer;
  LTreeArr: array of TTreeStruct;
  I: Integer;
  J: Integer;
begin

  LSql := ';WITH CTE(RKey,Lv,MANU_PART_NUMBER,parent_ptr) ' + ' AS (SELECT RKey,1,MANU_PART_NUMBER,isnull(parent_ptr,0) ' + ' FROM Data0025 WHERE RKey = ' + IntToStr(ASOurceRkey25) + ' UNION ALL  ' + ' SELECT D25.RKey,CTE.Lv+1,D25.MANU_PART_NUMBER,d25.parent_ptr ' + ' FROM Data0025 D25 INNER JOIN CTE ON D25.PARENT_PTR = CTE.RKey ) SELECT * FROM CTE ORDER BY CTE.LV asc';
  LQry := TADOQuery.Create(Self);
  try
    LQry.SQL.Add(LSql);
    LQry.Connection := dm.ADOConnection1;
    LQry.Prepared := True;
    LQry.Open;
    LQry.First;
    while not LQry.Eof do
    begin
      LParentRkey := 0;
      for I := 0 to Length(LTreeArr) - 1 do
      begin
        if LTreeArr[I].SourceRkey = LQry.FieldByName('parent_ptr').AsInteger then
        begin
          LParentRkey := LTreeArr[I].SelfRkey;
          Break;
        end;
      end;

      if LQry.FieldByName('parent_ptr').AsInteger = 0 then
      begin
        LSelfRkey := ASelfrkey25;
        LParentRkey := 0;
      end
      else
        LSelfRkey := 0;
//      else
//      begin
//        if LParentRkey <> LQry.FieldByName('parent_ptr').AsInteger then
//        begin
//          LParentRkey := LSelfRkey;
//        end;
//        LSelfRkey := 0;
//      end;

      CopyOneMiStruct(LSelfRkey, LParentRkey, LQry.fieldbyname('rkey').AsInteger);
      SetLength(LTreeArr, Length(LTreeArr) + 1);
      LTreeArr[High(LTreeArr)].SelfRkey := LSelfRkey;
      LTreeArr[High(LTreeArr)].SourceRkey := LQry.FieldByName('rkey').AsInteger;

      LQry.Next;
    end;
  finally
    LQry.Free;
  end;

  form3 := TForm3.Create(Self);
  Form3.link_database := ' ';
  try
    Form3.StringGrid1.RowCount := Length(LTreeArr) + 2;
    for I := 0 to Length(LTreeArr) - 1 do
    begin
      Form3.StringGrid1.Cells[3, I + 1] := IntToStr(LTreeArr[I].SourceRkey);
      Form3.StringGrid1.Cells[2, I + 1] := IntToStr(LTreeArr[I].SelfRkey);
    end;
    CopyMI(Form3, 0);
  finally
    Form3.Free;
  end;

end;

function TForm1.CopyOneMiStruct(var ASelfrkey25: Integer; AParentRkey25, ASourceRkey25: Integer): Boolean;
var
  LQry: TADOQuery;
  LSql: string;
  I: Integer;
  LNotCopyFiled: TStringList;
begin
  Result := False;
  LQry := TADOQuery.Create(Self);
  LQry.Connection := dm.ADOConnection1;
  LNotCopyFiled := TStringList.Create;
  try
    LNotCopyFiled.Add(uppercase('RKEY'));
    LNotCopyFiled.Add(uppercase('CREATED_BY_EMPL_PTR'));
    LNotCopyFiled.Add(uppercase('LAST_SO_DATE'));
    LNotCopyFiled.Add(uppercase('TSTATUS'));
    LNotCopyFiled.Add(uppercase('CHECK_BY_PTR'));
    LNotCopyFiled.Add(uppercase('CHECK_DATE'));
    LNotCopyFiled.Add(uppercase('AUDITED_BY_PTR'));
    LNotCopyFiled.Add(uppercase('AUDITED_DATE'));
    LNotCopyFiled.Add(uppercase('ALLOW_EDIT_FLAG'));
    LNotCopyFiled.Add(uppercase('ONHOLD_SALES_FLAG'));
    LNotCopyFiled.Add(uppercase('CUSTPART_ENT_DATE'));
    LNotCopyFiled.Add(uppercase('LAST_MODIFIED_BY_PTR'));
    LNotCopyFiled.Add(uppercase('LAST_MODIFIED_DATE'));
    LNotCopyFiled.Add(uppercase('BOM_STATUS'));
    LNotCopyFiled.Add(uppercase('BOM_APPR_BY'));
    LNotCopyFiled.Add(uppercase('BOM_APPR_DATE'));
    LNotCopyFiled.Add(uppercase('COST_APPR_BY'));
    LNotCopyFiled.Add(uppercase('COST_APPR_DATE'));
    LNotCopyFiled.Add(uppercase('candidate_BY'));
    LNotCopyFiled.Add(uppercase('candidate_DATE'));
    LNotCopyFiled.Add(uppercase('quality_status'));
    LNotCopyFiled.Add(uppercase('quality_user'));
    LNotCopyFiled.Add(uppercase('quality_date'));
    LNotCopyFiled.Add(uppercase('ORIG_CUSTOMER'));
//    LNotCopyFiled.Add(uppercase('RKEY'));
//    LNotCopyFiled.Add(uppercase('RKEY'));
//    LNotCopyFiled.Add(uppercase('RKEY'));
      //data0025
    LQry.SQL.Text := 'select * from data0025 where rkey = ' + IntToStr(ASelfrkey25);
    LQry.Open;
    DM.SqlOpen('select * from data0025 where rkey = ' + IntToStr(ASourceRkey25));
    if LQry.IsEmpty then
      LQry.Append
    else
      LQry.Edit;

    for I := 0 to dm.qryTmp.Fields.Count - 1 do
    begin
      if LNotCopyFiled.IndexOf(UpperCase(LQry.Fields[I].FieldName)) <> -1 then
        Continue;
      LQry.Fields[I].Value := DM.qryTmp.Fields[I].Value;
    end;

    if AParentRkey25 <> 0 then
    begin
      LQry.FieldByName('parent_ptr').AsInteger := AParentRkey25;
      LQry.FieldByName('manu_part_number').AsString := DM.ADS25.fieldbyname('manu_part_number').AsString + RightStr(LQry.FieldByName('manu_part_number').AsString, Length(LQry.FieldByName('manu_part_number').AsString) - Pos('.', LQry.FieldByName('manu_part_number').AsString) + 1);
    end
    else
    begin
      LQry.FieldByName('manu_part_number').AsString := dm.ADS25.fieldbyname('manu_part_number').AsString;
    end;

    LQry.Post;

    ASelfrkey25 := LQry.fieldbyname('rkey').AsInteger;

  finally
    LQry.Free;
    LNotCopyFiled.Free;
  end;

end;

procedure TForm1.CopyMI(AFrm: TForm3; ATag: Integer);
var
  i, j: word;
  customer, parent, ttype, qty_hand, CREATED_ptr, warehouse_ptr: integer;
  PROD_PTR, LAYERS: integer;
  analysis_2, analysis_3, memo_text,dataname,msg: string;
  CREATED_date: tdatetime;
  REPORT_UNIT_VALUE1, EST_SCRAP: Currency;
begin
  msg:= '';
  dm.D279ParamChangeEventEnable(False);
  DM.D494ParamChangeEventEnable(False);
  try
    dm.ADOConnection1.BeginTrans;
    screen.Cursor := crappstart;
    try
      for i := 1 to AFrm.StringGrid1.RowCount - 2 do
      begin
        with dm.ADOQuery1 do
        begin
          close;
          sql.Text := 'select * from ' + AFrm.link_database + 'dbo.data0025 where rkey=' + AFrm.StringGrid1.Cells[3, i];
          open;
        end;
        dm.AQY0025.Close;
        dm.AQY0025.Parameters[0].Value := AFrm.StringGrid1.Cells[2, i];
        dm.AQY0025.Open;
        customer := dm.AQY0025CUSTOMER_PTR.Value;
        parent := dm.AQY0025PARENT_PTR.Value;
        warehouse_ptr := dm.AQY0025PROD_ROUTE_PTR.Value; //工厂指针
        PROD_PTR := dm.AQY0025PROD_CODE_PTR.Value;       //产品类型
        LAYERS := dm.AQY0025LAYERS.Value;                //层数
        ttype := dm.AQY0025ttype.Value;                  //产品属性
        qty_hand := dm.AQY0025QTY_ON_HAND.Value;         //库存
        analysis_2 := dm.AQY0025ANALYSIS_CODE_2.Value;   //客户物料号
        analysis_3 := dm.AQY0025ANALYSIS_CODE_3.Value;   //大料规格
        memo_text := dm.AQY0025memo_text.Value;         //市场备注
        CREATED_ptr := dm.AQY0025CREATED_BY_EMPL_PTR.Value;  //创建人员
        CREATED_date := dm.AQY0025CUSTPART_ENT_DATE.AsDateTime;   //创建日期
        REPORT_UNIT_VALUE1 := dm.AQY0025REPORT_UNIT_VALUE1.Value; //产品重量
        EST_SCRAP := dm.AQY0025EST_SCRAP.Value;  //报废率
        dm.AQY0025.edit;
        for j := 3 to dm.AQY0025.FieldCount - 4 do  //最后三个字段不需要复制
        begin
          if UpperCase(dm.AQY0025.Fields[j].FieldName) = 'SAMPLE_NR' then
            Continue; //跳过测试成型备注
          if UpperCase(dm.AQY0025.Fields[j].FieldName) = 'RKEY' then
            Continue; //
          if UpperCase(dm.AQY0025.Fields[j].FieldName) = 'GRADE_CODE' then
            Continue;
          if UpperCase(dm.AQY0025.Fields[j].FieldName) = 'ORIG_CUSTOMER' then
            Continue;
          if UpperCase(dm.AQY0025.Fields[j].FieldName) = 'LAST_SO_DATE' then
            Continue;
          dm.AQY0025.Fields[j].Value := dm.ADOQuery1.fieldbyname(dm.AQY0025.Fields[j].FieldName).Value;
        end;

        dm.AQY0025PROD_ROUTE_PTR.Value := warehouse_ptr;
        dm.AQY0025PROD_CODE_PTR.Value := PROD_PTR;       //产品类型
        dm.AQY0025CREATED_BY_EMPL_PTR.Value := CREATED_ptr;
//   dm.AQY0025CUSTPART_ENT_DATE.AsDateTime:=getsystem_date(dm.adoquery1,1);
//    dm.AQY0025CUSTPART_ENT_DATE.AsDateTime:= CREATED_date;
        dm.AQY0025CUSTPART_ENT_DATE.AsString := FormatDateTime('YYYY-MM-DD HH:MM', CREATED_date);     //zsp修改于20170607
        dm.AQY0025ANALYSIS_CODE_2.Value := analysis_2;
        dm.AQY0025ANALYSIS_CODE_3.Value := analysis_3;
        dm.AQY0025memo_text.Value := memo_text;           //市场备注
        dm.AQY0025REPORT_UNIT_VALUE1.Value := REPORT_UNIT_VALUE1; //单位重量
        dm.AQY0025LAST_MODIFIED_DATE.AsString := FormatDateTime('YYYY-MM-DD HH:MM', getsystem_date(dm.adoquery1, 0));
        dm.AQY0025LAST_MODIFIED_BY_PTR.Value := strtoint(user_ptr);
        dm.AQY0025TSTATUS.Value := 0;
        dm.AQY0025CHECK_BY_PTR.AsVariant := null;
        dm.AQY0025CHECK_DATE.AsVariant := null;
        dm.AQY0025AUDITED_BY_PTR.AsVariant := null;
        dm.AQY0025AUDITED_DATE.AsVariant := null;
        dm.AQY0025ENG_ROUTE_PTR.AsVariant := null;    //流程模型指针
        dm.AQY0025ALLOW_EDIT_FLAG.Value := 'Y';       //允许编辑
        dm.AQY0025ONHOLD_SALES_FLAG.Value := 0;       //可以销售
        dm.AQY0025ONHOLD_RELEASE_FLAG.Value := 1;     //工单发出暂缓
        dm.AQY0025ONHOLD_PLANNING_FLAG.Value := 1;    //投产暂缓
        dm.AQY0025CUSTOMER_PTR.Value := customer;     //客户指针
        dm.AQY0025EST_SCRAP.Value := EST_SCRAP;  //报废率
        if parent > 0 then
          dm.AQY0025PARENT_PTR.Value := parent
        else
          dm.AQY0025PARENT_PTR.AsVariant := null;
        dm.AQY0025ttype.Value := ttype;
        dm.AQY0025QTY_ON_HAND.Value := qty_hand;
        dm.AQY0025.Post;

        dm.ads502.Close;      //拼版图
        dm.ads502.Parameters[0].Value := AFrm.StringGrid1.Cells[2, i];
        dm.ads502.Open;
        if not dm.ads502.IsEmpty then
          dm.ads502.Delete;
        with dm.ADOQuery1 do
        begin
          close;
          sql.Text := 'select * from ' + AFrm.link_database + 'dbo.data0502 where source_ptr=' + AFrm.StringGrid1.Cells[3, i];
          open;
        end;
        if not dm.ADOQuery1.IsEmpty then
        begin
          dm.ads502.Append;
          for j := 1 to 22 do
            dm.ads502.Fields[j].Value := dm.ADOQuery1.FieldValues[dm.ads502.Fields[j].FieldName];
          dm.ads502source_ptr.Value := strtoint(AFrm.StringGrid1.Cells[2, i]);
          dm.ads502.Post;
          dm.ads502.UpdateBatch();
        end;

        dm.ads279.close;
        dm.ads279.Parameters[0].Value := AFrm.StringGrid1.Cells[2, i];
        dm.ads279.Open;
        while not dm.ads279.Eof do
          dm.ads279.Delete;
        with dm.ADOQuery1 do      //全局参数
        begin
          close;
          sql.Text := 'select data0279.PARAMETER_PTR, data0279.PARAMETER_VALUE ,' + #13 + 'data0279.IES_PROD,data0279.IES_CRP,data0278.status4' + #13 + 'from ' + AFrm.link_database + 'dbo.data0279 inner join ' + AFrm.link_database + 'dbo.data0278' + #13 + 'on data0279.PARAMETER_PTR=data0278.rkey' + #13 + 'where data0279.IES_PROD=1 and' + #13 + 'data0279.source_ptr=' + AFrm.StringGrid1.Cells[3, i] + #13 + 'order by data0279.IES_CRP';
          open;
          if not isempty then
          begin
            while not eof do
            begin
              dm.ads279.Append;
              for j := 1 to 4 do
                dm.ads279.Fields[j].Value := FieldValues[dm.ads279.Fields[j].FieldName];
              dm.ads279source_PTR.Value := strtoint(AFrm.StringGrid1.Cells[2, i]);
              if ATag = 1 then
                dm.ads279PARAMETER_PTR.Value := self.find_rkey278(Fieldbyname('PARAMETER_PTR').AsInteger, AFrm.link_database);

              if fieldbyname('status4').AsInteger = 1 then
                dm.ads279PARAMETER_VALUE.Value := '';
              next;
            end;
            dm.ads279.UpdateBatch();
          end;
        end;
        with dm.ADOQuery1 do
        begin
          close;
          sql.Text := 'update data0279' + #13 + 'set PARAMETER_VALUE='''' ' + #13 + 'FROM  dbo.Data0279 INNER JOIN' + #13 + 'dbo.Data0278 ON dbo.Data0279.PARAMETER_PTR = dbo.Data0278.RKEY' + #13 + 'WHERE  (dbo.Data0278.STATUS4 = 1) and (data0279.IES_PROD=1)' + #13 +  //参数定义为不复制,全局
            ' and   data0279.source_ptr=' + AFrm.StringGrid1.Cells[2, i];
          ExecSQL;
        end;

        DM.ADOQuery1.Close;
        DM.ADOQuery1.SQL.Clear;
        DM.ADOQuery1.SQL.Add('DELETE FROM Data0038 where Data0038.source_ptr=:rkey');
        DM.ADOQuery1.Parameters[0].Value := AFrm.StringGrid1.Cells[2, i];
        DM.ADOQuery1.ExecSQL;

        dm.ADS38.Close;                         //打开工艺流程
        dm.ADS38.Parameters[0].Value := AFrm.StringGrid1.Cells[2, i];
        dm.ADS38.Open;

        dm.ads494.Close;                      //制程参数
        dm.ads494.Parameters[0].Value := AFrm.StringGrid1.Cells[2, i];
        DM.ads494.Open;
        dm.ads494.Filter := '';
        while not dm.ads494.Eof do
          dm.ads494.Delete;
        dm.ads494.UpdateBatch();     //提前向数据库保存一次，清空

        with dm.ADOQuery1 do
        begin
          close;
          sql.Text := 'SELECT Data0034.ACTIVE_FLAG,Data0038.SOURCE_PTR, Data0038.DEPT_PTR, Data0038.DEF_ROUT_INST, Data0038.STEP_NUMBER,' + #13
                      + 'Data0038.tooling_rev,Data0038.OUTP_SPFC,Data0038.tool_old_rev,data0038.grade_note FROM ' + AFrm.link_database
                      + 'dbo.Data0038' + #13 + 'inner join ' + AFrm.link_database + 'dbo.data0034' + #13 + 'on data0038.DEPT_PTR=data0034.rkey' + #13
                      + 'where data0038.source_ptr=' + AFrm.StringGrid1.Cells[3, i] + #13
//                      + 'and data0034.ACTIVE_FLAG=0' + #13
                      + ' order by data0038.step_number';
          open;
          if not isempty then
          begin
            while not eof do
            begin
              if dm.ADOQuery1.Fields[0].AsInteger = 0 then
              begin
                dm.ADS38.Append;
                for j := 2 to DM.ADOQuery1.Fields.Count - 1 do
                begin
                  DM.ADS38.FieldByName(dm.ADOQuery1.Fields[J].FieldName).Value := DM.ADOQuery1.Fields[J].Value;
                end;
  //                dm.ADS38.Fields[j].Value := dm.adoquery1.FieldValues[dm.ADS38.Fields[j].FieldName];
                dm.ADS38SOURCE_PTR.Value := strtoint(AFrm.StringGrid1.Cells[2, i]);
                dm.ADS38STEP_NUMBER.Value := dm.ADOQuery1.RecNo;    //重新工序序号编码
                if ATag = 1 then
                  dm.ADS38DEPT_PTR.Value := self.find_rkey34(Fieldbyname('DEPT_PTR').AsInteger, AFrm.link_database);
                dm.ADS38.Post;

                with dm.ADOQuery2 do
                begin
                  close;
                  sql.Text := 'SELECT Data0494.PARAMETER_PTR, Data0494.PARAMETER_VALUE,data0278.PARAMETER_NAME,' + #13 +
                    'Data0494.custpart_ptr,Data0494.step_number,Data0494.seq_no,Data0494.Doc_Flag,' + #13 +
                    'Data0494.after_flag, Data0494.flow_spfc_flag,Data0494.outp_spfc_flag,data0278.status4,' + #13 +
                    'data0494.TaskTopLimt,data0494.TaskLowLimt,data0494.InnerTopLimt,data0494.InnerLowLimt,data0494.SpecialNote ' +
                    'FROM ' + AFrm.link_database + 'dbo.Data0494 inner join ' + AFrm.link_database + 'dbo.data0278' + #13 + 'on data0494.PARAMETER_PTR=data0278.rkey' + #13 + 'where Data0494.custpart_ptr = ' + AFrm.StringGrid1.Cells[3, i] + #13 + 'and data0494.step_number = ' + dm.ADOQuery1.fieldbyname('STEP_NUMBER').AsString + #13 + 'order by Data0494.step_number,Data0494.seq_no';
                  open;
                  while not eof do
                  begin
                    dm.ads494.Append;
                    for j := 0 to 8 do
                      dm.ads494.Fields[j].Value := dm.ADOQuery2.FieldValues[dm.ads494.Fields[j].FieldName];
                    dm.ads494custpart_ptr.Value := strtoint(AFrm.StringGrid1.Cells[2, i]);
                    dm.ads494step_number.Value := dm.ADOQuery1.RecNo;
                    DM.ads494.FieldByName('TaskTopLimt').AsString := DM.ADOQuery2.fieldbyname('TaskTopLimt').AsString;
                    DM.ads494.FieldByName('TaskLowLimt').AsString := DM.ADOQuery2.fieldbyname('TaskLowLimt').AsString;
                    DM.ads494.FieldByName('InnerTopLimt').AsString := DM.ADOQuery2.fieldbyname('InnerTopLimt').AsString;
                    DM.ads494.FieldByName('InnerLowLimt').AsString := DM.ADOQuery2.fieldbyname('InnerLowLimt').AsString;
                    DM.ads494.FieldByName('SpecialNote').AsString := DM.ADOQuery2.fieldbyname('SpecialNote').AsString;

                    if ATag = 1 then
                      dm.ads494PARAMETER_PTR.Value := self.find_rkey278(dm.ADOQuery2.Fieldbyname('PARAMETER_PTR').AsInteger, AFrm.link_database);
            //if fieldbyname('status4').AsInteger=1 then
            //dm.ads494PARAMETER_VALUE.Value:='';
                    dm.ads494.Post;
                    dm.ADOQuery2.Next;
                  end;
                end;
              end
              else
              begin
                dataname := Copy (db_ptr, AnsiPos('Initial Catalog=',db_ptr) +16,Pos(';',Copy(db_ptr, AnsiPos('Initial Catalog=',db_ptr) +16,Length(db_ptr)))-1);
                if (dataname = 'wisdompcb_rb') then    //软件特殊要求，后将改为控制开关
                begin
                  msg:= msg +  dm.ADOQuery1.FieldByName('STEP_NUMBER').AsString + ',';
                end;
              end;

              dm.ADOQuery1.Next;
            end;

          end;
        end;

        dm.ADS38.UpdateBatch();
        dm.ads494.UpdateBatch();

        with dm.ADOQuery1 do
        begin
          close;
          sql.Text := 'update data0494' + #13 + 'set PARAMETER_VALUE='''' ' + #13 + 'FROM  dbo.data0494 INNER JOIN' + #13 + 'dbo.Data0278 ON dbo.data0494.PARAMETER_PTR = dbo.Data0278.RKEY' + #13 + 'WHERE  (dbo.Data0278.STATUS4 = 1)' + #13 + ' and   data0494.custpart_ptr=' + AFrm.StringGrid1.Cells[2, i];
          ExecSQL;
        end;     //清除制程参数中不需要复制的部份

        with dm.ADOQuery2 do     //29 钻咀表
        begin
          close;
          sql.Text := 'SELECT SOURCE_PTR,SEQ_NR, MARK, HOLES_DIA, PTH, TOLERANCE, DRILL_DIA,' + #13 + 'UNIT, PANEL_A, PANEL_B, REMARK,SEQ_NO,SET_UNMBER' + #13 + 'FROM dbo.Data0029' + #13 + 'where source_ptr =' + AFrm.StringGrid1.Cells[2, i];
          open;
          while not eof do
            delete;
        end;

        with dm.ADOQuery1 do
        begin
          close;
          sql.Text := 'SELECT SOURCE_PTR,SEQ_NR, MARK, HOLES_DIA, PTH, TOLERANCE, DRILL_DIA,' + #13 + 'UNIT, PANEL_A, PANEL_B, REMARK,SEQ_NO,SET_UNMBER' + #13 + 'FROM ' + AFrm.link_database + 'dbo.Data0029' + #13 + 'where source_ptr=' + AFrm.StringGrid1.Cells[3, i];
          open;
          while not eof do
          begin
            dm.ADOQuery2.Append;
            for j := 1 to 12 do
              dm.adoquery2.Fields[j].Value := FieldValues[dm.adoquery2.Fields[j].FieldName];
            dm.ADOQuery2.FieldValues['SOURCE_PTR'] := strtoint(AFrm.StringGrid1.Cells[2, i]);
            dm.ADOQuery2.Post;
            next;
          end;
        end;

        with dm.ADOQuery2 do  //---复制ecn履历表 -andy 08-11-14
        begin
          close;
          sql.Text := 'SELECT part_ptr,serial_no,part_number,text,source,if_gerber,' + #13 + 'create_employee,engineer,ecn_no,enter_date' + #13 + 'FROM dbo.Data0035' + #13 + 'where part_ptr =' + AFrm.StringGrid1.Cells[2, i];
          open;
          while not eof do
            delete;
        end;
        with dm.ADOQuery1 do
        begin
          close;
          sql.Text := 'SELECT part_ptr,serial_no,part_number,text,source,if_gerber,' + #13 + 'create_employee,engineer,ecn_no,enter_date' + #13 + 'FROM ' + AFrm.link_database + 'dbo.Data0035' + #13 + 'where part_ptr =' + AFrm.StringGrid1.Cells[3, i];
          open;
          while not eof do
          begin
            dm.ADOQuery2.Append;
            for j := 1 to 9 do
              dm.adoquery2.Fields[j].Value := FieldValues[dm.adoquery2.Fields[j].FieldName];
            dm.ADOQuery2.FieldValues['part_ptr'] := strtoint(AFrm.StringGrid1.Cells[2, i]);
            dm.ADOQuery2.Post;
            next;
          end;
        end;

    //复制阻抗表
        dm.qryTmp.Close;
        DM.qryTmp.SQL.Text := 'delete from data0030 where source_ptr = ' + AFrm.StringGrid1.Cells[2, i];
        dm.qryTmp.ExecSQL;

        dm.qryTmp.Close;
        DM.qryTmp.SQL.Text := 'insert into data0030(SEQ_NO,source_ptr,type,MARK,layer,refe_layer,' + 'line_width,line_ofsight,impedance,adjust_linewidth,adjust_lineofsight,adjust_impedance,' + 'product_impedance,impedance_scope,orig_juli,adjust_jiuli,coupon ) ' + 'select SEQ_NO,' + AFrm.StringGrid1.Cells[2, i] + ' as source_ptr,type,MARK,layer,refe_layer,line_width,' + 'line_ofsight,impedance,adjust_linewidth,adjust_lineofsight, ' + ' adjust_impedance,product_impedance,impedance_scope,orig_juli,adjust_jiuli,coupon ' + ' from ' + AFrm.link_database + 'dbo.data0030 where source_ptr = ' + AFrm.StringGrid1.Cells[3, i];
        DM.qryTmp.ExecSQL;

        with dm.ADOQuery1 do
        begin
          close;
          sql.Text := 'delete from data0011' + #13 + 'where SOURCE_TYPE=25 and' + #13 + 'FILE_POINTER=' + AFrm.StringGrid1.Cells[2, i];
          ExecSQL;
        end;

        with dm.ADOQuery1 do
        begin
          Close;
          sql.Text := 'insert into data0011(FILE_POINTER,SOURCE_TYPE,memo_text) ' + 'select ' + AFrm.StringGrid1.Cells[2, i] + ' as FILE_POINTER,SOURCE_TYPE,memo_text from ' + AFrm.link_database + 'dbo.data0011 ' + 'where SOURCE_TYPE=25 and ' + 'FILE_POINTER=' + AFrm.StringGrid1.Cells[3, i];
          ExecSQL;
        end;

      end;

      dm.ADOConnection1.CommitTrans;
      dm.ads502.Close;
      dm.AQY0025.Close;
      dm.ads279.Close;
      dm.ADS38.Close;
      dm.ads494.Close;
      dm.ADS279_0.Close;

      if msg <> '' then ShowMessage('第 ' + copy(msg,1,Length(msg)-1)+ ' 步骤为无效工序，没有复制工艺流程！');
      messagedlg('数据复制成功!', mtinformation, [mbok], 0);
      screen.Cursor := crdefault;
    except
      on E: Exception do
      begin
        dm.ADOConnection1.RollbackTrans;
        screen.Cursor := crdefault;
        messagedlg(E.Message, mterror, [mbcancel], 0);
      end;
    end;
  finally
    dm.D279ParamChangeEventEnable(True);
    DM.D494ParamChangeEventEnable(True);
  end;

end;

function TForm1.CheckSpeck_UZ: Boolean;
var
  LQry,lqry2: TADOQuery;
  LGlob,LDept: string;
  LChildDlob,LChildDept: string;
begin
  Result := True;
  LQry := TADOQuery.Create(Self);
  lqry2 := TADOQuery.Create(Self);
  try
    LQry.Connection := DM.ADOConnection1;
    lqry2.Connection := DM.ADOConnection1;
    LQry.SQL.Text := ';WITH CTE(RKey,Lv,MANU_PART_NUMBER,parent_ptr) ' + ' AS (SELECT RKey,1,MANU_PART_NUMBER,isnull(parent_ptr,0) ' + ' FROM Data0025 WHERE RKey = ' + IntToStr(DM.AQY0025.fieldbyname('rkey').AsInteger) + ' UNION ALL  ' + ' SELECT D25.RKey,CTE.Lv+1,D25.MANU_PART_NUMBER,d25.parent_ptr ' + ' FROM Data0025 D25 INNER JOIN CTE ON D25.PARENT_PTR = CTE.RKey ) SELECT * FROM CTE ORDER BY CTE.LV asc';
    LQry.Open;
    LQry.First;
    while not LQry.Eof do
    begin
      lqry2.SQL.Text := 'SELECT d279.PARAMETER_VALUE from data0279 d279 inner join Data0278 d278 ON d279.PARAMETER_PTR = d278.RKEY WHERE d278.SPEC_RKEY = ''UZ'' and d279.SOURCE_PTR = ' + lqry.fieldbyname('rkey').AsString;
      LQry2.Open;
      if not lqry2.IsEmpty then
      begin
        LChildDlob := lqry2.fieldbyname('PARAMETER_VALUE').AsString;
        if LGlob = '' then
          LGlob := lqry2.fieldbyname('PARAMETER_VALUE').AsString
        else
        begin
          if LGlob <> lqry2.fieldbyname('PARAMETER_VALUE').AsString then
            ShowMessage(LQry.fieldbyname('MANU_PART_NUMBER').AsString + ' 全局参数板料尺寸与顶层不一致，请注意！');
        end;
      end else
        LChildDlob := '-0';

      lqry2.SQL.Text := ' SELECT d494.PARAMETER_VALUE from Data0494 d494 inner join Data0278 d278 ON d494.PARAMETER_PTR = d278.RKEY WHERE d278.SPEC_RKEY = ''LS'' AND d494.custpart_ptr = ' + lqry.fieldbyname('rkey').AsString ;
      LQry2.Open;
      if not lqry2.IsEmpty then
      begin
        LChildDept := lqry2.fieldbyname('PARAMETER_VALUE').AsString;
        if LDept = '' then
          LDept := lqry2.fieldbyname('PARAMETER_VALUE').AsString
        else
        begin
          if LDept <> lqry2.fieldbyname('PARAMETER_VALUE').AsString then
            ShowMessage(LQry.fieldbyname('MANU_PART_NUMBER').AsString + ' 工序参数板料尺寸与顶层不一致，请注意！');
        end;
      end else
        LChildDept := '-0';

      if (LChildDlob <> LChildDept) and (LChildDlob <> '-0') and ( LChildDept <> '-0') then
      begin
        ShowMessage(LQry.fieldbyname('MANU_PART_NUMBER').AsString + ' 工序参数板料尺寸与全局参数不一致，请注意！');
        Result := False;
      end;
      LQry.Next;
    end;
  finally
    LQry.Free;
    lqry2.Free;
  end;
end;

procedure TForm1.MI2Click(Sender: TObject);
var
  STR1,STR2:string;
begin
  SetCurrentDir(extractfilepath(paramstr(0)));
  form_reportselect := tform_reportselect.Create(application);
  if form_reportselect.ShowModal = mrok then
  begin
    form_report := tform_report.Create(application);
    with form_report do
    begin
      ppReport1.Reset;
      ppReport1.Template.FileName := stringReplace(UpperCase(extractfilepath(paramstr(0))), 'EXEC\', 'NIERP\REPORT\', [rfReplaceAll]) + 'Manu_instruction.rtm';           //R:\NIERP\Report\Manu_instruction.rtm
      ppReport1.Template.LoadFromFile;
      ppreport1.SaveAsTemplate := False;

      DM.ADOQuery1.Close;
      DM.ADOQuery1.SQL.Text := ';WITH CTE(RKey,Lv,MANU_PART_NUMBER,PARENT_PTR) ' +
        ' AS (SELECT RKey,0,MANU_PART_NUMBER,PARENT_PTR ' +
        ' FROM Data0025 WHERE RKey = '+ dm.ADS25rkey.AsString +' UNION ALL  ' +
        ' SELECT D25.RKey,CTE.Lv+1,D25.MANU_PART_NUMBER,d25.PARENT_PTR ' +
        ' FROM Data0025 D25 INNER JOIN CTE ON D25.PARENT_PTR = CTE.RKey ) SELECT rkey FROM CTE ORDER BY lv asc';
      DM.ADOQuery1.Open;

      while not DM.ADOQuery1.Eof do
      begin
        ads192.Open;
        ads279.Close;
        ads279.Parameters.ParamValues['rkey'] := DM.ADOQuery1.FieldByName('rkey').Value;
        if ads192ENG_CONTROL16.Value = 1 then       //不显示为空的全局参数
          ads279.Parameters.ParamValues['value'] := ''
        else
          ads279.Parameters.ParamValues['value'] := '#@#@#';
        ads279.Open;

        ads25.Close;
        ads25.Parameters[0].Value := DM.ADOQuery1.FieldByName('rkey').Value;
        ads25.Open;

        ads494.Close;
        ads494.Parameters.ParamValues['source_ptr'] := DM.ADOQuery1.FieldByName('rkey').Value;
        if ads192ENG_CONTROL2.Value = 1 then       //不显示为空的制程参数
          ads494.Parameters.ParamValues['value'] := ''
        else
          ads494.Parameters.ParamValues['value'] := '#@#@#';
        ads494.Open;

        ads38.Close;
        ads38.Parameters.ParamValues['rkey'] := DM.ADOQuery1.FieldByName('rkey').Value;
        if form_reportselect.CheckBox3.Checked then
          ads38.Parameters.ParamValues['visible'] := 1
        else
          ads38.Parameters.ParamValues['visible'] := 2;
        ads38.Open;
        ads502.Open;
        ads29.Open;
        ADS30.Open;
        form_report.ppImage3.Picture.Assign(Load_JPG_Pic_From_DB(ads502DSDesigner));
        if ads502A3.Value > 0 then
          form_report.ppimage1.Picture.Assign(Load_JPG_Pic_From_DB(ads502A));

        if ads502B.AsVariant <> null then
          form_report.ppimage2.Picture.Assign(Load_JPG_Pic_From_DB(ads502B));

        if (not ADS25DSDesigner35.IsNull) and (form_reportselect.CheckBox6.Checked) then
        begin
          form_report.ppImage4.Visible := True;
          form_report.ppImage4.Picture.Assign(Load_JPG_Pic_From_DB(ADS25DSDesigner35));
        end
        else
          form_report.ppImage4.Visible := False;

        if not form_reportselect.CheckBox1.Checked then
          form_report.ppSubReport1.Visible := false;

        if not form_reportselect.CheckBox2.Checked then
          form_report.ppSubReport2.Visible := false;

        if not form_reportselect.CheckBox4.Checked then
          form_report.ppSubReport3.Visible := false;
        if not Form_reportselect.CheckBox5.Checked then
          Form_report.ppSubReport4.Visible := false;

        form_report.ppReport1.Print;
        
        dm.ADOQuery1.Next;
      end;
    end;
    form_report.Free;
  end;
  form_reportselect.Free;
end;

end.

