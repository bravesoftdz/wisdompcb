unit MainUNIT1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, Grids, DBGrids, Menus, DB, ADODB,DateUtils,
  DBGridEh, ppComm, ppRelatv, ppProd, ppClass, ppReport, ppPrnabl, ppCtrls,
  ppBands, ppCache
  ;

type
  TMainForm1 = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    Edit1: TEdit;
    Label1: TLabel;
    PopupMenu2: TPopupMenu;
    DBGridEh1: TDBGridEh;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N8: TMenuItem;
    N10: TMenuItem;
    BitBtn6: TBitBtn;
    PopupMenu3: TPopupMenu;
    N14: TMenuItem;
    Panel2: TPanel;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    Label2: TLabel;
    Label3: TLabel;
    N2: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    StringGrid1: TStringGrid;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure DBGridEh1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGridEh1TitleClick(Column: TColumnEh);
    procedure N4Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N10Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure N14Click(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
  private
    { Private declarations }
    vcut_no:string;
    PreColumn: TColumnEh;
    field_name:string;
     user_ptrCaption,vprevCaption :string;
    ADOQALL2sql :string;

    procedure item_click(sender:TObject);


    procedure PrintMo(ttype:string);
    procedure PrintMo2(ttype:string;const vRadioGroup1ItemIndex:integer);

  public
    { Public declarations }
  end;

var
  MainForm1: TMainForm1;

implementation

USES
   common ,DmUnit1,IF_Unit1,ConstVar,EditBom
   ,TReport,   MulPrinUnit1;

{$R *.dfm}

procedure TMainForm1.BitBtn1Click(Sender: TObject);
begin
  CLOSE;
end;

procedure TMainForm1.BitBtn2Click(Sender: TObject);
begin
  IF DBGridEh1.DataSource.DataSet.Active THEN
      IF DBGridEh1.DataSource.DataSet.RecordCount > 0 THEN
          Export_dbGridEH_to_Excel(DBGridEh1,'生产投产管理') ;
end;

procedure TMainForm1.BitBtn5Click(Sender: TObject);
begin
  popupmenu2.Popup(mouse.CursorPos.x,mouse.CursorPos.y);
end;

procedure TMainForm1.BitBtn3Click(Sender: TObject);
var
  i:integer;
begin
  i := -1 ;
  IF DBGridEh1.DataSource.DataSet.Active THEN
      begin
          if not DBGridEh1.DataSource.DataSet.IsEmpty then
              i := DBGridEh1.DataSource.DataSet.FieldValues['RKEY'] ;
          DBGridEh1.DataSource.DataSet.Close ;
      end;
  DBGridEh1.DataSource.DataSet.Open ;
  if i <> -1 then DBGridEh1.DataSource.DataSet.Locate('RKEY',i,[]);
end;

procedure TMainForm1.FormCreate(Sender: TObject);
begin

 if not App_Init(dm.ADOConnection1 ) then
  begin
    ShowMsg('程序起动失败请联系管理员',1);
    application.Terminate;
  end;
  Caption := application.Title;

 // user_ptr:='3';
 // vprev:='4';


  user_ptrCaption :=  user_ptr;
  vprevCaption :=  vprev;
  DateSeparator := '-' ;
  ShortDateFormat := 'yyyy-mm-dd' ;

end;



procedure TMainForm1.FormShow(Sender: TObject);
var
  i:byte;
  item:TMenuItem;
begin
  if not dm.ADOConnection1.Connected then
      application.Terminate ;

  field_name := DBGridEh1.Columns[0].FieldName ;
  Label1.Caption := DBGridEh1.Columns[0].Title.Caption ;
  PreColumn := DBGridEh1.Columns[0] ;

  for i := 1 to DBGridEh1.Columns.Count do
  begin
   item := TmenuItem.Create(self) ;
   item.Caption := DBGridEh1.Columns[i - 1].Title.Caption ;
   if DBGridEh1.Columns[i - 1].Visible then
    item.Checked := true ;
   item.OnClick := item_click ;
   self.PopupMenu2.Items.Add(item) ;
  end;

  ADOQALL2sql := dm.ADOQALL2.SQL.Text ;
  DM.ads494SQL:=dm.ads494.commandText;
  dm.ADOQALL2.Parameters.ParamValues['vdate1'] := getsystem_date(dm.TemADOQuery1,1);
  dm.ADOQALL2.Parameters.ParamValues['vdate2'] := getsystem_date(dm.TemADOQuery1,1) + 1;
  dm.ADOQALL2.Prepared ;
  dm.ADOQALL2.Open ;
  dm.ADOQALL2.Sort:= PreColumn.FieldName;

end;

procedure TMainForm1.item_click(sender: TObject);
var
  i:byte;
begin
  (sender as tmenuItem).Checked := not ((sender as tmenuItem).Checked);
  if (sender as tmenuItem).Checked then
      begin
          for i := 0 to DBGridEh1.FieldCount - 1 do
              if DBGridEh1.Columns[i].Title.Caption = (sender as tmenuItem).Caption then
                  begin
                      DBGridEh1.Columns[i].Visible := true ;
                      break ;
                  end ;
      end
  else
      begin
          for i := 0 to DBGridEh1.FieldCount - 1 do
              if DBGridEh1.Columns[i].Title.Caption = (sender as tmenuItem).Caption then
                  begin
                      DBGridEh1.Columns[i].Visible := false ;
                      break ;
                  end ;
      end ;
end;

procedure TMainForm1.Edit1Change(Sender: TObject);
begin
  if DBGridEh1.DataSource.DataSet.FieldByName(field_name).FieldKind <> fkCalculated then
      if DBGridEh1.DataSource.DataSet.FieldByName(field_name).DataType in [ftString,ftWideString]  then   //, ftWord,
          begin
              DBGridEh1.DataSource.DataSet.Filter := '' ;

              if trim(Edit1.text) <> '' then
                  begin
                      if DBGridEh1.DataSource.DataSet.FieldByName(field_name).DataType in  [ftString, ftWideString]  then
                          begin
                              if DBGridEh1.DataSource.DataSet.Filter <> '' then
                                  DBGridEh1.DataSource.DataSet.Filter := DBGridEh1.DataSource.DataSet.Filter + ' and ' +  field_name + ' like ''%' + trim(edit1.text) + '%'''
                              else
                                  DBGridEh1.DataSource.DataSet.Filter := field_name + ' like ''%' + trim(edit1.text) + '%''' ;
                          end
                      else if DBGridEh1.DataSource.DataSet.FieldByName(field_name).DataType in  [ftSmallint, ftInteger]  then
                          begin
                              if DBGridEh1.DataSource.DataSet.Filter <> '' then
                                  DBGridEh1.DataSource.DataSet.Filter := DBGridEh1.DataSource.DataSet.Filter + ' and ' + field_name+' >= ' + inttostr(strtointdef(edit1.text,0))
                              else
                                  DBGridEh1.DataSource.DataSet.Filter := field_name + ' >= ' + inttostr(strtointdef(edit1.text,0)) ;
                          end;
                  end ;
          end ;
end ;

procedure TMainForm1.BitBtn4Click(Sender: TObject);
var
  i :integer;
begin

   If_Form1.DateTimePicker1.Date:= dm.ADOQALL2.Parameters.ParamValues['vdate1'];
   If_Form1.DateTimePicker2.Date:= dm.ADOQALL2.Parameters.ParamValues['vdate2']-1;
   if If_Form1.ShowModal = mrok then
     begin

      dm.ADOQALL2.Close ;
      dm.ADOQALL2.SQL.Text:=ADOQALL2SQL;

      for i := 1 to If_Form1.sgrid1.RowCount - 2  do
       dm.ADOQALL2.SQL.Add(trim(If_Form1.sgrid1.Cells[2,i])) ;

      dm.ADOQALL2.Parameters.ParamValues['vdate1'] := If_Form1.DateTimePicker1.Date;
      dm.ADOQALL2.Parameters.ParamValues['vdate2'] := If_Form1.DateTimePicker2.Date+1;
      dm.ADOQALL2.Prepared ;
      dm.ADOQALL2.Open ;
     end ;

end;

procedure TMainForm1.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
begin
   if dm.ADOQALL2QTY_REJECT.Value > (dm.ADOQALL2ISSUED_QTY.Value-
                                     dm.ADOQALL2ORD_REQ_QTY.Value)*0.5 then
    DBGridEh1.Canvas.Font.Color := clred;

  DBGridEh1.DefaultDrawColumnCell(Rect, DataCol, Column, State) ;
end;

procedure TMainForm1.DBGridEh1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (chr(key) = 'S') and (ssalt in shift) then
      showmessage((DBGridEh1.DataSource.DataSet as TADOQuery).SQL.Text)
  else if (key = 46) and (ssCtrl in shift) then
      abort() ;
  //showmessage(inttostr(Key));

end;

procedure TMainForm1.DBGridEh1TitleClick(Column: TColumnEh);
begin
  IF DBGridEh1.DataSource.DataSet.Active THEN
   begin
    if DBGridEh1.DataSource.DataSet.FieldByName(Column.FieldName).FieldKind = fkCalculated then
     begin
      exit ;
     end ;

    if field_name <> column.FieldName then
      begin
       label1.Caption := column.Title.Caption ;
       field_name := column.FieldName ;
       edit1.SetFocus ;
       PreColumn.Title.Color := clBtnFace ;
       Column.Title.Color := clred ;
       PreColumn := column ;
       dm.ADOQALL2.Sort:= PreColumn.FieldName;
       Edit1Change(Edit1);
     end
    else
      edit1.SetFocus ;
   end;
end;

procedure TMainForm1.N4Click(Sender: TObject);
begin
 if (vprevCaption = '1') or (vprevCaption = '3') then
  begin
   showmsg('你只有检查权限，不能更改数据!',1);
   exit;
  end;
  IF DBGridEh1.DataSource.DataSet.IsEmpty THEN EXIT ;
  if (dm.ADOQALL2CUT_NO.Value<>'')or (dm.ADOQALL2CUT_NO.Value<>null) then
  begin
    dm.TemADOQuery1.Close ;
    dm.TemADOQuery1.SQL.Clear ;
    dm.TemADOQuery1.SQL.Add('Select Con_Flag From data0492 where Cut_NO = '+
                            quotedstr(dm.ADOQALL2CUT_NO.Value));
    DM.TemADOQuery1.Open ;
    if (dm.TemADOQuery1.RecordCount>0) then
    begin
    if dm.TemADOQuery1.Fieldbyname('Con_Flag').AsInteger <> 0 then
     begin
      Application.MessageBox(PChar('配料单' + DM.ADOQALL2CUT_NO.AsString + '已确认，不能再修改！'),'提示',MB_OK+MB_IconInformation) ;
      DM.TemADOQuery1.Close ;
      EXIT ;
     end ;
    end;

  DM.TemADOQuery1.Close ;
  end;

  Application.CreateForm(TFrmEditBom, FrmEditBom);
  TRY
   dm.ADOQALL2.Edit;
//   DM.ftp:=2;
    if FrmEditBom.showmodal = mrok then
     begin
      BitBtn3Click(Sender);
     end ;
  FINALLY
      FrmEditBom.Free ;
  END ;


end;

procedure TMainForm1.PrintMo(ttype: string);
begin
  With dm.TMPADO1 do //显示CUTTING
  begin
    close ;
    Parameters.ParamValues['vptr'] :=
    DBGridEh1.DataSource.DataSet.fieldbyname('d025_rkey').AsInteger ;
    prepared ;
    open ;
  end;

  if ttype = '1' then
  begin
    Application.CreateForm(TFrmReport, FrmReport);
   { try
      FrmReport.ppImage1.Picture.Assign(Load_JPG_Pic_From_DB(dm.TMPADO1sheet_BMP));
    except
      showmessage('不能打印开料图');
    end;  }
    FrmReport.Rkey0025 := dm.ADOQALL2D025_RKEY.AsInteger ;

    WITH FrmReport.Adoquery1 do
    begin
      Close ;
      parameters.ParamByName('vcut_no').Value :=
        DBGridEh1.DataSource.DataSet.Fieldbyname('cut_no').asstring;
//      parameters.ParamByName('cut_no').Value :=
//        DBGridEh1.DataSource.DataSet.Fieldbyname('cut_no').asstring;
      open;
    end ;
    FrmReport.ppReport1.Reset;
    FrmReport.ppReport1.Template.FileName :=
                  stringReplace(UpperCase(GetCurrentDir),'EXEC','NIERP\REPORT\',[rfReplaceAll])+'\Newmoreport.rtm';
    FrmReport.ppReport1.Template.LoadFromFile;
    try
      FrmReport.ppImage1.Picture.Assign(Load_JPG_Pic_From_DB(dm.TMPADO1sheet_BMP));
    except
      showmessage('不能打印开料图');
    end;

    FrmReport.ppReport1.SaveAsTemplate:=False;
    FrmReport.ppReport1.Print;
    FrmReport.Free ;
  end;
end;

procedure TMainForm1.N1Click(Sender: TObject);
var tmpAdo,tmpAdo2:TADOQuery;
   vbomstate3,i,j:integer;
   sName,sGp_Prt,d17RKey:string;
begin
  if dm.ADOQALL2.Eof then exit ;
  if (vprevCaption = '1') or (vprevCaption = '3') then
  begin
    showmsg('你只有检查权限，不能打印配料单',1);
    exit;
  end;

  if (dm.ADOQALL2.FieldByName('tstatus').asinteger = 1) or   // '未审核';
     (dm.ADOQALL2.FieldByName('tstatus').asinteger = 3) then   // '已取消';
  begin
    Messagedlg(dm.ADOQALL2.fieldbyname('cut_no').asstring + '超投数量尚未被批准！',mtInformation,[mbOk],0);
    exit;
  end;                       
//20150123修改 MyCon_Flag状态未确认不能打印--------------------
  dm.TemADOQuery1.close ;
  dm.TemADOQuery1.SQL.Clear ;
  dm.TemADOQuery1.SQL.Add('select COST_CONTROL1 from data0192');  //COST_CONTROL2
  dm.TemADOQuery1.Prepared ;
  dm.TemADOQuery1.Open ;
  if ((dm.ADOQALL2Con_Flag.AsInteger<>2) and
     (dm.TemADOQuery1.FieldByName('COST_CONTROL1').asinteger = 0)) then
  begin
    showmsg('配料单未确认，不能打印配料单',1);
    exit;
  end;
//-end20150123-------------------------
//  vbomstate3 := dm.ADOQALL2bom_status.asinteger ;
//
//  if (vbomstate3 = 0) or (vbomstate3 = 2) or (vbomstate3 = 3) then
//  begin
//    dm.TemADOQuery1.close ;
//    dm.TemADOQuery1.SQL.Clear ;
//    dm.TemADOQuery1.SQL.Add('select COST_CONTROL1 from data0192');  //COST_CONTROL2
//    dm.TemADOQuery1.Prepared ;
//    dm.TemADOQuery1.Open ;
//
//    if dm.TemADOQuery1.FieldByName('COST_CONTROL1').asinteger = 0 then   //0不允许输出配料单
//    begin
//      Messagedlg(dm.ADOQALL2.fieldbyname('cut_no').asstring + 'BOM尚未提交!',mtInformation,[mbOk],0);
//      dm.TemADOQuery1.close ;
//      exit;
//    end
//    else
//    if Messagedlg(dm.ADOQALL2.fieldbyname('cut_no').asstring + 'BOM尚未提交,是否继续?',mtconfirmation,[mbYes,mbNo],0) = mrNo then
//    begin
//      dm.TemADOQuery1.Close ;
//      exit ;
//    end;
//    dm.TemADOQuery1.Close ;
//  end ;
//-----------2013.07.11修改工序参数与材料参数不一致时，查询278表PROTECTION_FLAG是否为1，为1必须一致，否则不通过
   try
     try
       tmpAdo:=TADOQuery.Create(Application);
       tmpAdo.Connection:=DM.ADOConnection1;
       tmpAdo2:=TADOQuery.Create(Application);
       tmpAdo2.Connection:=DM.ADOConnection1;
       StringGrid1.RowCount:=2;
       StringGrid1.Rows[1].Clear;
       tmpAdo2.Close;
       tmpAdo2.SQL.Clear;
       tmpAdo2.SQL.Text:='select dbo.data0468.*,dbo.data0017.group_ptr from dbo.data0468'
                        +'  inner join dbo.data0017 on dbo.data0468.INVENT_PTR=dbo.data0017.Rkey'
                        +'  inner join dbo.data0492 on dbo.data0468.CUT_NO=dbo.data0492.CUT_NO'
                        +'  where  dbo.data0468.CUT_NO=:Cut_No';
       tmpAdo2.Parameters.ParamByName('cut_no').Value:=DM.ADOQALL2CUT_NO.Value;
       tmpAdo2.Open;
       if not tmpAdo2.IsEmpty then
       begin
         tmpAdo2.First;
         while not tmpAdo2.Eof do
         begin
           sGp_Prt:=Trim(tmpAdo2.FieldBYName('group_ptr').AsString);
           d17RKey:=Trim(tmpAdo2.fieldByName('INVENT_PTR').AsString);
           StringGrid1.RowCount:=2;
           StringGrid1.Rows[1].Clear;
           tmpAdo.Close;
           tmpAdo.SQL.Clear;
           tmpAdo.SQL.Text:='SELECT dbo.Data0499.PARAMETER_PTR, dbo.Data0499.DEF_VALUE, dbo.Data0499.SEQ_NO, dbo.Data0278.PARAMETER_NAME,'
            +'dbo.Data0278.PARAMETER_DESC, dbo.Data0002.UNIT_NAME,dbo.data0499.inv_group_ptr,dbo.data0278.Rkey as d278RKey'
            +' FROM dbo.Data0499'
            +' INNER JOIN dbo.Data0278 ON dbo.Data0499.PARAMETER_PTR = dbo.Data0278.RKEY'
            +' INNER JOIN dbo.Data0002 ON dbo.Data0278.UNIT_PTR = dbo.Data0002.RKEY'
            +' where  data0499.ttype=0 and data0499.inv_group_ptr =:group_ptr'
            +' order by data0499.seq_no';
           tmpAdo.Parameters.ParamByName('group_ptr').Value:=StrToInt(sGp_Prt);
           tmpAdo.Open;
           if (tmpAdo.RecordCount>0) then
           begin
             while not tmpAdo.Eof do
             begin
               stringgrid1.Cells[0,StringGrid1.RowCount-1] := tmpAdo.FieldByName('seq_no').AsString;
               stringgrid1.Cells[1,StringGrid1.RowCount-1] := tmpAdo.FieldByName('PARAMETER_NAME').AsString;
               StringGrid1.Cells[3,StringGrid1.RowCount-1] := tmpAdo.FieldByName('UNIT_NAME').AsString;
               StringGrid1.Cells[4,StringGrid1.RowCount-1] := tmpAdo.FieldByName('d278RKey').AsString;
               StringGrid1.RowCount:=StringGrid1.RowCount+1;
               tmpAdo.Next;
             end;
             StringGrid1.RowCount:=StringGrid1.RowCount-1;
           end;
           tmpAdo.Close;
           tmpAdo.SQL.Clear;
           tmpAdo.SQL.Add('select * from dbo.data0017 where Rkey=:INV_PART_NUMBER');
           tmpAdo.Parameters.ParamByName('INV_PART_NUMBER').Value:=d17RKey;
           tmpAdo.Open;
           if (tmpAdo.RecordCount>0) then
           begin
             for  i:=1  to 10 do
             begin
               sGp_Prt:=tmpAdo.FieldByName('IES_PARAMETER_VALUE'+IntTostr(i)).AsString;
               if ((sGp_Prt='') or (sGp_Prt=null)) then Break;
                 stringgrid1.Cells[2,i] := tmpAdo.FieldByName('IES_PARAMETER_VALUE'+IntTostr(i)).AsString;
             end;
           end;
            dm.ads494.Close;                      //制程参数
            dm.ads494.CommandText:=DM.ads494SQL+' and data0494.step_number='+tmpAdo2.fieldByName('STEP').AsString;                      //制程参数
            dm.ads494.Parameters[0].Value:=DM.ADOQALL2d025_rkey.Value;
            dm.ads494.Open;
            if not dm.ads494.IsEmpty then
            while not DM.ads494.Eof do
            begin
              sName:=DM.ads494PARAMETER_NAME.Value;
              for i :=1  to StringGrid1.RowCount do
              begin
                if (sName=Trim(StringGrid1.Cells[1,i])) then
                begin
                  if (UpperCase(Trim(DM.ads494PARAMETER_VALUE.AsString))<>UpperCase(Trim(StringGrid1.Cells[2,i]))) then
                  begin
                    tmpAdo.Close;
                    tmpAdo.SQL.Clear;
                    tmpAdo.SQL.Text:='select * from dbo.data0278 where PROTECTION_FLAG=1 and Rkey='+Trim(StringGrid1.Cells[4,i]);
                    tmpAdo.Open;
                    if not tmpAdo.IsEmpty then
                    begin
                      ShowMsg('参数名为【'+sName+'】参数必须相同，请更正！',1);
                      Exit;
                    end;
                  end;
                end;
              end;
              DM.ads494.Next;
            end;
           tmpAdo2.Next;
         end;
       end;
     except
       tmpAdo.Close;
       tmpAdo.Connection:=nil;
       tmpAdo.Free;
       tmpAdo2.Close;
       tmpAdo2.Connection:=nil;
       tmpAdo2.Free;
     end;
   finally
     tmpAdo.Close;
     tmpAdo.Connection:=nil;
     tmpAdo.Free;
     tmpAdo2.Close;
     tmpAdo2.Connection:=nil;
     tmpAdo2.Free;
   end;
//------------end 2013.07.11修改-------
  PrintMo('1') ;
  bitbtn3click(sender);
end;

procedure TMainForm1.N10Click(Sender: TObject);
var i,j,control,k:integer;
    tmpAdo,tmpAdo2:TADOQuery;
    sName,sGp_Prt,d17RKey:string;
begin
  if (vprevCaption = '1') or (vprevCaption = '3') then
  begin
    showmsg('你只有检查权限，不能打印配料单',1);
    exit;
  end;
  dm.TemADOQuery1.close ;
  dm.TemADOQuery1.SQL.Clear ;
  dm.TemADOQuery1.SQL.Add('select COST_CONTROL1 from data0192');  //COST_CONTROL2
  dm.TemADOQuery1.Open ;
  control:=dm.TemADOQuery1.FieldByName('COST_CONTROL1').asinteger; //=0必须审核再打印（去掉勾选）
  dm.TemADOQuery1.close ;
  MulPrinForm1 := TMulPrinForm1.Create(application) ;
  try
    MulPrinForm1.StG1.Cells[0,0] := '配料单号';
    MulPrinForm1.StG2.Cells[0,0] := '配料单号';
    dm.ADOQALL2.First ;
    while not dm.ADOQALL2.Eof do
    begin
//20150513修改。。
      if ((dm.ADOQALL2PRINTED_BY_PTR.Value=0) and (control=1) and ((dm.ADOQALL2.FieldByName('tstatus').asinteger = 0) or (dm.ADOQALL2.FieldByName('tstatus').asinteger = 2))) then
      begin
        MulPrinForm1.StG1.RowCount := MulPrinForm1.StG1.RowCount + 1;
        MulPrinForm1.StG1.Cells[0,MulPrinForm1.StG1.RowCount - 2] := DM.ADOQALL2CUT_NO.AsString ;
      end;
      if ((dm.ADOQALL2PRINTED_BY_PTR.Value=0) and (control=0) and ((dm.ADOQALL2.FieldByName('tstatus').asinteger = 0) or (dm.ADOQALL2.FieldByName('tstatus').asinteger = 2)) and (dm.ADOQALL2.FieldByName('Con_Flag').asinteger=2)) then
      begin
        MulPrinForm1.StG1.RowCount := MulPrinForm1.StG1.RowCount + 1;
        MulPrinForm1.StG1.Cells[0,MulPrinForm1.StG1.RowCount - 2] := DM.ADOQALL2CUT_NO.AsString ;
      end;
//      if (control=0) and
//         ((dm.ADOQALL2bom_status.Value=0) or
//         (dm.ADOQALL2bom_status.Value=2) or
//         (dm.ADOQALL2bom_status.Value=3))
//      then
//      else
//        if dm.ADOQALL2PRINTED_BY_PTR.Value=0 then      //配料单未打印
//          if (dm.ADOQALL2.FieldByName('tstatus').asinteger = 0) or     //不审
//            (dm.ADOQALL2.FieldByName('tstatus').asinteger = 2)         //已审
//          then
//          begin
//            MulPrinForm1.StG1.RowCount := MulPrinForm1.StG1.RowCount + 1;
//            MulPrinForm1.StG1.Cells[0,MulPrinForm1.StG1.RowCount - 2] := DM.ADOQALL2CUT_NO.AsString ;
//          end;

      dm.ADOQALL2.Next ;
    end ;

    if MulPrinForm1.showmodal = mrOk then
    begin
      if MulPrinForm1.StG2.RowCount > 2 then
      begin
        for i := 1 to MulPrinForm1.StG2.RowCount - 2 do
        begin
        //-----------2013.07.11修改工序参数与材料参数不一致时，查询278表PROTECTION_FLAG是否为1，为1必须一致，否则不通过
           try
             try
               tmpAdo:=TADOQuery.Create(Application);
               tmpAdo.Connection:=DM.ADOConnection1;
               tmpAdo2:=TADOQuery.Create(Application);
               tmpAdo2.Connection:=DM.ADOConnection1;
               tmpAdo2.Close;
               tmpAdo2.SQL.Clear;
               tmpAdo2.SQL.Text:='select dbo.data0468.*,dbo.data0017.group_ptr,dbo.data0492.Con_Flag from dbo.data0468'
                                +'  inner join dbo.data0017 on dbo.data0468.INVENT_PTR=dbo.data0017.Rkey'
                                +'  inner join dbo.data0492 on dbo.data0468.CUT_NO=dbo.data0492.CUT_NO'
                                +'  where  dbo.data0468.CUT_NO=:Cut_No';
               tmpAdo2.Parameters.ParamByName('cut_no').Value:=MulPrinForm1.StG2.Cells[0,i];
               tmpAdo2.Open;
               if not tmpAdo2.IsEmpty then
               begin
                 tmpAdo2.First;
                 while not tmpAdo2.Eof do
                 begin
//                   if (tmpAdo2.FieldByName('Con_Flag').AsInteger<>2) then
//                   begin
//                     ShowMsg('配料单【'+MulPrinForm1.StG2.Cells[0,i]+'】未确认不能打印！',1);
//                     Exit;
//                   end;
                   for k:=1 to StringGrid1.RowCount do StringGrid1.Rows[k].Clear;
                   StringGrid1.RowCount:=2;
                   StringGrid1.Rows[1].Clear;
                   sGp_Prt:=Trim(tmpAdo2.FieldBYName('group_ptr').AsString);
                   d17RKey:=Trim(tmpAdo2.fieldByName('INVENT_PTR').AsString);
                   tmpAdo.Close;
                   tmpAdo.SQL.Clear;
                   tmpAdo.SQL.Text:='SELECT dbo.Data0499.PARAMETER_PTR, dbo.Data0499.DEF_VALUE, dbo.Data0499.SEQ_NO, dbo.Data0278.PARAMETER_NAME,'
                    +'dbo.Data0278.PARAMETER_DESC, dbo.Data0002.UNIT_NAME,dbo.data0499.inv_group_ptr,dbo.data0278.Rkey as d278RKey'
                    +' FROM dbo.Data0499'
                    +' INNER JOIN dbo.Data0278 ON dbo.Data0499.PARAMETER_PTR = dbo.Data0278.RKEY'
                    +' INNER JOIN dbo.Data0002 ON dbo.Data0278.UNIT_PTR = dbo.Data0002.RKEY'
                    +' where  data0499.ttype=0 and data0499.inv_group_ptr =:group_ptr'
                    +' order by data0499.seq_no';
                   tmpAdo.Parameters.ParamByName('group_ptr').Value:=StrToInt(sGp_Prt);
                   tmpAdo.Open;
                   if (tmpAdo.RecordCount>0) then
                   begin
                     while not tmpAdo.Eof do
                     begin
                       stringgrid1.Cells[0,StringGrid1.RowCount-1] := tmpAdo.FieldByName('seq_no').AsString;
                       stringgrid1.Cells[1,StringGrid1.RowCount-1] := tmpAdo.FieldByName('PARAMETER_NAME').AsString;
                       StringGrid1.Cells[3,StringGrid1.RowCount-1] := tmpAdo.FieldByName('UNIT_NAME').AsString;
                       StringGrid1.Cells[4,StringGrid1.RowCount-1] := tmpAdo.FieldByName('d278RKey').AsString;
                       StringGrid1.RowCount:=StringGrid1.RowCount+1;
                       tmpAdo.Next;
                     end;
                     StringGrid1.RowCount:=StringGrid1.RowCount-1;
                   end;
                   tmpAdo.Close;
                   tmpAdo.SQL.Clear;
                   tmpAdo.SQL.Add('select * from dbo.data0017 where Rkey=:INV_PART_NUMBER');
                   tmpAdo.Parameters.ParamByName('INV_PART_NUMBER').Value:=d17RKey;
                   tmpAdo.Open;
                   if (tmpAdo.RecordCount>0) then
                   begin
                     for  j:=1 to 10 do
                     begin
                       sGp_Prt:=tmpAdo.FieldByName('IES_PARAMETER_VALUE'+IntTostr(j)).AsString;
                       if ((sGp_Prt='') or (sGp_Prt=null)) then Break;
                         stringgrid1.Cells[2,j] := tmpAdo.FieldByName('IES_PARAMETER_VALUE'+IntTostr(j)).AsString;
                     end;
                   end;
                   if DM.ADOQALL2.Locate('CUT_NO',MulPrinForm1.StG2.Cells[0,i],[]) then
                   begin
                      dm.ads494.Close;                      //制程参数
                      dm.ads494.CommandText:=DM.ads494SQL+' and data0494.step_number='+tmpAdo2.fieldByName('STEP').AsString;                      //制程参数
                      dm.ads494.Parameters[0].Value:=DM.ADOQALL2d025_rkey.Value;
                      dm.ads494.Open;
                      if not dm.ads494.IsEmpty then
                      while not DM.ads494.Eof do
                      begin
                        sName:=DM.ads494PARAMETER_NAME.Value;
                        for j :=1  to StringGrid1.RowCount do
                        begin
                          if (sName=Trim(StringGrid1.Cells[1,j])) then
                          begin
                            if (UpperCase(Trim(DM.ads494PARAMETER_VALUE.AsString))<>UpperCase(Trim(StringGrid1.Cells[2,j]))) then
                            begin
                              tmpAdo.Close;
                              tmpAdo.SQL.Clear;
                              tmpAdo.SQL.Text:='select * from dbo.data0278 where PROTECTION_FLAG=1 and Rkey='+Trim(StringGrid1.Cells[4,j]);
                              tmpAdo.Open;
                              if not tmpAdo.IsEmpty then
                              begin
                                ShowMsg('参数名为【'+sName+'】参数必须相同，请更正！',1);
                                Exit;
                              end;
                            end;
                          end;
                        end;
                        DM.ads494.Next;
                      end;
                   end;
                   tmpAdo2.Next;
                 end;
               end;
             except
               tmpAdo.Close;
               tmpAdo.Connection:=nil;
               tmpAdo.Free;
             end;
           finally
             tmpAdo.Close;
             tmpAdo.Connection:=nil;
             tmpAdo.Free;
           end;
        //------------end 2013.07.11修改-------

            PrintMo2('1',0 ) ;
        end ;
        bitbtn3click(sender);
      end;
    end ;
  finally
    MulPrinForm1.Free ;
  end;
end;

procedure TMainForm1.PrintMo2(ttype: string;const vRadioGroup1ItemIndex:integer);
begin
  With dm.TMPADO1 do //显示CUTTING
  begin
    close ;
    Parameters.ParamValues['vptr'] := DBGridEh1.DataSource.DataSet.fieldbyname('d025_rkey').AsInteger ;
    prepared ;
    open ;
  end;

  if ttype = '1' then
  begin
    Application.CreateForm(TFrmReport, FrmReport);
{    try
      FrmReport.ppImage1.Picture.Assign(Load_JPG_Pic_From_DB(dm.TMPADO1sheet_BMP));
    except
      showmessage('不能打印开料图');
    end;
 }
    FrmReport.Rkey0025 := dm.ADOQALL2D025_RKEY.AsInteger ;

    WITH FrmReport.Adoquery1 do
    begin
      Close ;
      parameters.ParamByName('vcut_no').Value := DBGridEh1.DataSource.DataSet.Fieldbyname('cut_no').asstring;
 //     parameters.ParamByName('cut_no').Value := DBGridEh1.DataSource.DataSet.Fieldbyname('cut_no').asstring;
      open;
    end ;
  end;

  vcut_no := DBGridEh1.DataSource.DataSet.fieldbyname('cut_no').asstring;
  if not FrmReport.ADOQuery1.IsEmpty then
  begin
    FrmReport.ppReport1.Reset;
    FrmReport.ppReport1.Template.FileName :=
                  stringReplace(UpperCase(GetCurrentDir),'EXEC','NIERP\REPORT\',[rfReplaceAll])+'Newmoreport.rtm';
    FrmReport.ppReport1.Template.LoadFromFile;
    try
      FrmReport.ppImage1.Picture.Assign(Load_JPG_Pic_From_DB(dm.TMPADO1sheet_BMP));
    except
      showmessage('不能打印开料图');
    end;
    FrmReport.ppReport1.SaveAsTemplate:=False;
    FrmReport.ppReport1.DeviceType := 'Printer';
    FrmReport.ppReport1.ShowPrintDialog := False;
    FrmReport.ppReport1.Print;
  end;
  FrmReport.Free;
end;

procedure TMainForm1.BitBtn6Click(Sender: TObject);
begin
  popupmenu3.Popup(mouse.CursorPos.x,mouse.CursorPos.y);
end;

procedure TMainForm1.N14Click(Sender: TObject);
begin
  With dm.TMPADO1 do //显示CUTTING
  begin
       close ;
       Parameters.ParamValues['vptr'] := null;//DBGridEh1.DataSource.DataSet.fieldbyname('d025_rkey').AsInteger ;
       prepared ;
       open ;
  end;
  Application.CreateForm(TFrmReport, FrmReport);

  FrmReport.Rkey0025 := dm.ADOQALL2D025_RKEY.AsInteger ;

//so
  WITH FrmReport.Adoquery1 do
  begin
    Close ;
    parameters.ParamByName('vcut_no').Value := null;//DBGridEh1.DataSource.DataSet.Fieldbyname('cut_no').asstring;
 //   parameters.ParamByName('cut_no').Value := null;//DBGridEh1.DataSource.DataSet.Fieldbyname('cut_no').asstring;
    open;
  end ;
  FrmReport.ppReport1.Reset;
  FrmReport.ppReport1.Template.FileName :=
    stringReplace(UpperCase(GetCurrentDir),'EXEC','NIERP\REPORT\',[rfReplaceAll])+'Newmoreport.rtm';
  FrmReport.ppReport1.Template.LoadFromFile;
  FrmReport.ppReport1.SaveAsTemplate:=true;
  FrmReport.ppDesigner1.ShowModal ;
  FrmReport.Free ;
end;

procedure TMainForm1.N8Click(Sender: TObject);
var tmpAdo:TADOQuery;
sql_text:string;
begin
  if (vprevCaption = '1') or (vprevCaption = '3') then
  begin
   showmessage('你只有检查权限，不能更改数据!');
   exit;
  end;
  IF DBGridEh1.DataSource.DataSet.IsEmpty THEN EXIT ;
  IF dm.TemADOQuery1.Active then dm.TemADOQuery1.Close ;
  dm.TemADOQuery1.SQL.Clear ;
  dm.TemADOQuery1.SQL.Add('Select Con_Flag From data0492 where Cut_NO = :Cut_NO');
  dm.TemADOQuery1.Parameters.ParamValues['Cut_NO'] := DM.ADOQALL2CUT_NO.AsString ;
  DM.TemADOQuery1.Open ;
  if dm.TemADOQuery1.Fieldbyname('Con_Flag').AsInteger <>0 then
    begin
      Application.MessageBox(PChar('配料单' + DM.ADOQALL2CUT_NO.AsString + '已确认，不能再修改！'),'提示',MB_OK+MB_IconInformation) ;
      EXIT ;
    end ;
  DM.TemADOQuery1.Close ;


 if Messagedlg('以前的配额将会删除,是否继续',mtInformation,[mbYes, mbNo],0) =  mryes then
 try
  dm.ADOConnection1.BeginTrans ;
  dm.adoq0026.Close ;
  dm.adoq0026.Parameters.ParamValues['rkey0025'] :=  dm.ADOQALL2d025_rkey.AsInteger ;
  dm.adoq0026.Prepared ;
  dm.adoq0026.Open ;

  sql_text:='delete data0468 where CUT_NO='+quotedstr(dm.ADOQALL2CUT_NO.Value);
  dm.TemADOQuery1.Close;
  dm.TemADOQuery1.SQL.Text:=sql_text;
  dm.TemADOQuery1.ExecSQL;

  dm.aqy468.Close ;
  dm.aqy468.Parameters.ParamValues['CUT_NO'] :=  dm.ADOQALL2CUT_NO.AsString ;
  dm.aqy468.Prepared ;
  dm.aqy468.Open ;

  while not dm.aqy468.Eof do dm.aqy468.Delete ;

  while not dm.adoq0026.Eof do
   begin                                           //
    dm.aqy468.Append ;
    dm.aqy468CUT_NO.AsString :=  dm.ADOQALL2CUT_NO.AsString  ;
    dm.aqy468SO_NO.AsString := dm.ADOQALL2SO_NO.AsString ;
    dm.aqy468STEP.AsInteger := dm.adoq0026ROUTE_STEP_NO.AsInteger ;
    dm.aqy468DEPT_PTR.AsString := dm.ADOQ0026DEPT_PTR.AsString ;
    dm.aqy468INVENT_PTR.AsString := dm.ADOQ0026INVENTORY_PTR.AsString ;
    dm.aqy468QUAN_BOM.AsString := format('%.8f',[dm.ADOQALL2ISSUED_QTY.AsInteger *
                                                 dm.ADOQ0026QTY_BOM.AsFloat]) ;
    dm.aqy468PRINTIT.AsString := dm.ADOQ0026DOC_FLAG.AsString;
    dm.aqy468VENDOR.AsString := '';
    dm.aqy468Invent_or.AsString := '0';
    dm.aqy468.Post; //加
    dm.adoq0026.next;
   end;

   //    dm.aqy468.Post;tang2013-3-13注
   dm.ADOConnection1.CommitTrans ;
   showmessage('重算配额完成');
  except
   on E: Exception do
    begin
     dm.ADOConnection1.RollbackTrans;
     messagedlg(E.Message,mterror,[mbcancel],0);
    end;
  end;
end;

procedure TMainForm1.CheckBox1Click(Sender: TObject);
begin
dm.ADOQALL2.Close;
if checkbox1.Checked then
 dm.ADOQALL2.Parameters.ParamByName('ts1').Value:=9
else
 dm.ADOQALL2.Parameters.ParamByName('ts1').Value:=0;
if checkbox2.Checked then
 dm.ADOQALL2.Parameters.ParamByName('ts2').Value:=9
else
 dm.ADOQALL2.Parameters.ParamByName('ts2').Value:=1;
if checkbox3.Checked then
 dm.ADOQALL2.Parameters.ParamByName('ts3').Value:=9
else
 dm.ADOQALL2.Parameters.ParamByName('ts3').Value:=2;
if checkbox4.Checked then
 dm.ADOQALL2.Parameters.ParamByName('ts4').Value:=9
else
 dm.ADOQALL2.Parameters.ParamByName('ts4').Value:=3;
dm.ADOQALL2.Open;
end;

procedure TMainForm1.PopupMenu1Popup(Sender: TObject);
begin
 if dm.ADOQALL2.IsEmpty then
  begin
   n1.Enabled:=false;
   n4.Enabled:=false;
   n5.Enabled:=false;
   n8.Enabled:=false;
   n10.Enabled:=false;
  end
 else
  begin
   if dm.ADOQALL2PRINTED_BY_PTR.Value > 0 then
    n1.Enabled:=false
   else
    n1.Enabled:=true;
   n4.Enabled:=true;
   n8.Enabled:=true;
   n10.Enabled:=true;

  if dm.ADOQALL2PRINTED_BY_PTR.Value > 0 then
   if strtoint(vprevCaption) = 4 then
    n5.Enabled:=true
   else
    n5.Enabled:=false
  else
   n5.Enabled:=false;
  end;
end;

procedure TMainForm1.N5Click(Sender: TObject);
begin
dm.ADOQALL2.Edit;
dm.ADOQALL2.FieldByName('printed_by_ptr').asinteger := 0 ;
dm.ADOQALL2.Post;
end;

procedure TMainForm1.N6Click(Sender: TObject);
begin
  Application.CreateForm(TFrmEditBom, FrmEditBom);
  TRY
    FrmEditBom.stg2.PopupMenu:=nil;
//    DM.ftp:=5;
    FrmEditBom.BitBtn1.Enabled:=false;
    FrmEditBom.DBMemo1.ReadOnly:=true;
    FrmEditBom.DBEdit4.ReadOnly:=true;
    FrmEditBom.showmodal;
  FINALLY
    FrmEditBom.Free ;
  END ;

end;

end.
