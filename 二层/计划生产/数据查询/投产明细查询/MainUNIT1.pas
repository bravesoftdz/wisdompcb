unit MainUNIT1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, Grids, DBGrids, Menus, DB, ADODB,DateUtils,
  DBGridEh, MyClass;

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
    DataSource1: TDataSource;
    DBGridEh1: TDBGridEh;
    Label2: TLabel;
    RadioGroup1: TRadioGroup;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
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
    procedure DBGridEh1TitleBtnClick(Sender: TObject; ACol: Integer;
      Column: TColumnEh);
    procedure RadioGroup1Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure DBGridEh1ColumnMoved(Sender: TObject; FromIndex,
      ToIndex: Integer);
  private
    { Private declarations }
    PreColumn: TColumnEh;// TColumn
    rkey419:Integer;
    mc:TMyDataClass;
//    field_name:string;
    ADOQuery1sql :string;
    procedure item_click(sender:TObject);
    procedure loadField(tmp2: TADOQuery;DbGrid: TDBGridEh);
    procedure showField(rkey:Integer;dbGrid:TDBGridEh);
  public
    { Public declarations }

  end;

var
  MainForm1: TMainForm1;
  strLab:string;

implementation

USES
   common , DmUnit1 ,IF_Unit1,Pas_WorkDetails,PasViewSales,  PasFieldShow;

{$R *.dfm}
procedure TMainForm1.showField(rkey:Integer;dbGrid:TDBGridEh);
var
  i,addInt:Integer;
  tmpstr:string;
  aqtmp:TADOQuery;
  bool : Integer;
  addField:Boolean;
begin
  try
    aqtmp:=TADOQuery.Create(nil);
    aqtmp.Connection:=DM.ADOConnection1;
    tmpstr:='select Rkey, D419_ptr, D073_ptr, FieldName, FieldCaption, FieldOrder, FieldWidth, IsDisplay '+
              ' from data0849 where D419_ptr= '+ IntToStr(rkey) +' and D073_ptr= ' + rkey73;
//              +' and FormName= '+ QuotedStr(Self.Name) + ' and GridName= '+ QuotedStr(dbGrid.Name);
    if mc.OpenQuery(aqtmp,tmpstr) then
    begin
      with aqtmp do
      begin
        if not IsEmpty then
        begin
          if RecordCount >= dbGrid.Columns.Count then    //没有增加字段，按数据库的数据调整排序，可见以及宽度
          begin

              loadField(aqtmp,DbGrid);          //加载字段
          end
          else
          begin                                                  //增加了字段，把新加的字段加入数据库中
            addInt:= dbGrid.Columns.Count-RecordCount;     //存增加了多少个字段
            addField:=True;
            for i:=0 to dbGrid.Columns.Count-1 do
            begin
              First;
              while not Eof do
              begin
//                if dbGrid.Columns[i].FieldName=FieldByName('FieldName').Value then
//                begin
//                  Break;
//                end;
//                tmpstr:='insert into data0849(D419_ptr, D073_ptr, FieldName, FieldCaption, FieldOrder, FieldWidth, IsDisplay,FormName,GridName)' +
//                                        'values('+IntToStr(rkey)+','+ rkey73+','+ QuotedStr(dbGrid.Columns[i].FieldName)+','+
//                                        QuotedStr(dbGrid.Columns[i].Title.Caption)+','+ IntToStr(dbGrid.Columns.Count - addInt)+','+
//                                        IntToStr(dbGrid.Columns[i].Width)+','+ QuotedStr(BoolToStr(dbGrid.Columns[i].Visible,True)) + ','+
//                                        QuotedStr(Self.Name) +','+ QuotedStr(dbGrid.Name)+')'+#13;
//                dm.tmp.Close;
//                dm.tmp.SQL.Text:=tmpstr;
//                dm.tmp.ExecSQL;
////                mc.ExecSql(tmpstr);
//                addInt:=addInt - 1;
//                if addInt = 0 then Break;
//                Next;
                if DBGrid.Columns[i].FieldName=FieldByName('FieldName').Value then
                begin
                  addField:=False;
                  Break;
                end;
                addField:=True;
                Next;
              end;
              if addField then
              begin
                if DBGrid.Columns[i].Visible then bool:=1
                else bool:=0;
                with DM.tmp do
                begin
                  Close;
                  SQL.Clear;
                  SQL.Text:= SQL.Text+ 'insert into data0849(D419_ptr, D073_ptr, FieldName, FieldCaption, FieldOrder, FieldWidth, IsDisplay,FormName,GridName)' +
                                        'values('+IntToStr(rkey419)+','+ rkey73+','+ QuotedStr(DBGridEh1.Columns[i].FieldName)+','+
                                        QuotedStr(DBGridEh1.Columns[i].Title.Caption)+','+ IntToStr(DBGridEh1.Columns.Count - addInt)+','+
                                        IntToStr(DBGridEh1.Columns[i].Width)+','+ IntToStr(bool)+ ',''frmMain'',''dbMain'')'+#13;
                  ExecSQL;
                end;
                addInt:=addInt - 1;
                if addInt = 0 then Break;
              end;
            end;

            loadField(aqtmp,DbGrid);          //加载字段
          end;
        end
        else
        begin
          tmpstr:='';                         //如果当前使用人员当前程序在849表没找到，则新增
          for i:=0 to dbGrid.Columns.Count-1 do
          begin
            tmpstr:=tmpstr+ 'insert into data0849(D419_ptr, D073_ptr, FieldName, FieldCaption, FieldOrder, FieldWidth, IsDisplay,FormName,GridName)' +
                                  'values('+IntToStr(rkey)+','+ rkey73+','+ QuotedStr(dbGrid.Columns[i].FieldName)+','+
                                  QuotedStr(dbGrid.Columns[i].Title.Caption)+','+ IntToStr(dbGrid.Columns[i].Index)+','+
                                  IntToStr(dbGrid.Columns[i].Width)+','+ QuotedStr(BoolToStr(dbGrid.Columns[i].Visible,True)) + ','+
                                  QuotedStr(Self.Name) +','+ QuotedStr(dbGrid.Name)+')'+#13;
          end;
          dm.tmp.Close;
          dm.tmp.SQL.Text:=tmpstr;
          dm.tmp.ExecSQL;
//          mc.ExecSql(tmpstr);
        end;
      end;
    end;
  finally
//    aqtmp.Free;
  end;
end;

//procedure TMainForm1.showField(rkey:Integer;dbGrid:TDBGridEh);
//var
//  i,addInt:Integer;
//  tmpstr:string;
//  aqtmp:TADOQuery;
//begin
//  try
//    aqtmp:=TADOQuery.Create(nil);
//    aqtmp.Connection:=DM.ADOConnection1;
//    tmpstr:='select Rkey, D419_ptr, D073_ptr, FieldName, FieldCaption, FieldOrder, FieldWidth, IsDisplay '+
//              ' from data0849 where D419_ptr= '+ IntToStr(rkey) +' and D073_ptr= ' + rkey73;
////              +' and FormName= '+ QuotedStr(Self.Name) + ' and GridName= '+ QuotedStr(dbGrid.Name);
//    if mc.OpenQuery(aqtmp,tmpstr) then
//    begin
//      with aqtmp do
//      begin
//        if not IsEmpty then
//        begin
//          if RecordCount >= dbGrid.Columns.Count then    //没有增加字段，按数据库的数据调整排序，可见以及宽度
//          begin
//            Sort:='FieldOrder';
//            First;
//            while not Eof do
//            begin
//              loadField(aqtmp,DBGridEh1);       //加载字段
//              Next;
//            end;
//          end
//          else
//          begin                                                  //增加了字段，把新加的字段加入数据库中
//            addInt:= dbGrid.Columns.Count-RecordCount;     //存增加了多少个字段
//            for i:=0 to dbGrid.Columns.Count-1 do
//            begin
//              First;
//              while not Eof do
//              begin
//                if dbGrid.Columns[i].FieldName=FieldByName('FieldName').Value then
//                begin
//                  Break;
//                end;
//                tmpstr:='insert into data0849(D419_ptr, D073_ptr, FieldName, FieldCaption, FieldOrder, FieldWidth, IsDisplay,FormName,GridName)' +
//                                        'values('+IntToStr(rkey)+','+ rkey73+','+ QuotedStr(dbGrid.Columns[i].FieldName)+','+
//                                        QuotedStr(dbGrid.Columns[i].Title.Caption)+','+ IntToStr(dbGrid.Columns.Count - addInt)+','+
//                                        IntToStr(dbGrid.Columns[i].Width)+','+ QuotedStr(BoolToStr(dbGrid.Columns[i].Visible,True)) + ','+
//                                        QuotedStr(Self.Name) +','+ QuotedStr(dbGrid.Name)+')'+#13;
////                showmessage(tmpstr);
//                mc.ExecSql(tmpstr);
//                addInt:=addInt - 1;
//                if addInt = 0 then Break;
//                Next;
//              end;
//            end;
//            Close;
//            Open;
//            First;
//            while not Eof do
//            begin
//              loadField(aqtmp,DBGridEh1);          //加载字段
//              Next;
//            end;
//          end;
//        end
//        else
//        begin
//          tmpstr:='';                         //如果当前使用人员当前程序在849表没找到，则新增
//
//          for i:=0 to dbGrid.Columns.Count-1 do
//          begin
//            tmpstr:= tmpstr + 'insert into data0849(D419_ptr, D073_ptr, FieldName, FieldCaption, FieldOrder, FieldWidth, IsDisplay,FormName,GridName)' +
//                                  'values('+IntToStr(rkey)+','+ rkey73+','+ QuotedStr(dbGrid.Columns[i].FieldName)+','+
//                                  QuotedStr(dbGrid.Columns[i].Title.Caption)+','+ IntToStr(dbGrid.Columns[i].Index)+','+
//                                  IntToStr(dbGrid.Columns[i].Width)+','+ QuotedStr(BoolToStr(dbGrid.Columns[i].Visible,True)) + ','+
//                                  QuotedStr(Self.Name) +','+ QuotedStr(dbGrid.Name)+')'+#13;
//
//          end;
////          ShowMessage(tmpstr);
//          mc.ExecSql(tmpstr);
//        end;
//      end;
//    end;
//  finally
//    aqtmp.Free;
//  end;
//end;


procedure TMainForm1.loadField(tmp2: TADOQuery;DbGrid: TDBGridEh);
var
  i:Integer;
begin
  with tmp2 do
  begin
    Sort:='FieldOrder';
    First;
    while not Eof do
    begin
      for i:=0 to DbGrid.Columns.Count-1 do
      begin
        if (FieldByName('FieldName').Value=DbGrid.Columns[i].FieldName) then
        begin
          if (FieldByName('IsDisplay').Value <> DbGrid.Columns[i].Visible) or (FieldByName('FieldWidth').Value <> DbGrid.Columns[i].Width) then
          begin
            DbGrid.Columns[i].Visible:= FieldByName('IsDisplay').Value;
            DbGrid.Columns[i].Width:= FieldByName('FieldWidth').Value;
          end;

          DbGrid.Columns[i].Index:= tmp2.RecNo - 1 ;

          Break;
        end;
      end;
      Next;
    end;
  end;
end;

procedure TMainForm1.FormCreate(Sender: TObject);
begin
  if not App_init_2(dm.ADOConnection1) then
  begin
    ShowMsg('程序起动失败请联系管理员',1);
    application.Terminate;
  end;
  Caption := application.Title;

//user_ptr:='785';
//rkey73:='3022';
//vprev:='4';
//dm.ADOConnection1.Open;

  DateSeparator := '-' ;
  ShortDateFormat := 'yyyy-mm-dd';
end;

procedure TMainForm1.BitBtn1Click(Sender: TObject);
begin
  CLOSE;
end;

procedure TMainForm1.BitBtn2Click(Sender: TObject);
begin
  IF DBGrideh1.DataSource.DataSet.Active THEN
      IF DBGrideh1.DataSource.DataSet.RecordCount > 0 THEN
          Export_dbGrideh_to_Excel(DBGrideh1,'投产明细表' ) ;
          //Export_dbGridEH_to_Excel(DBGridEh1,'超补投查询');

end;

procedure TMainForm1.BitBtn5Click(Sender: TObject);
begin
//  popupmenu2.Popup(mouse.CursorPos.x,mouse.CursorPos.y);
  try
    frmFieldShow:=TfrmFieldShow.Create(Application);
    frmFieldShow.key419:=rkey419;
    if frmFieldShow.ShowModal=mryes then
    begin
      Self.showField(rkey419,DBGrideh1);
    end;
  finally
    frmFieldShow.Free;
  end;
end;

procedure TMainForm1.BitBtn3Click(Sender: TObject);
var
  i2:integer;

begin
  i2 := -1 ;
  IF DBGrideh1.DataSource.DataSet.Active THEN
  begin
    if not DBGrideh1.DataSource.DataSet.FieldByName('rkey').IsNull then
        i2 := DBGrideh1.DataSource.DataSet.FieldValues['rkey'] ;
    DBGrideh1.DataSource.DataSet.Close ;
  end;

  DBGrideh1.DataSource.DataSet.Open ;
  if i2 <> -1 then DBGrideh1.DataSource.DataSet.Locate('rkey',i2,[]);
end;

procedure TMainForm1.FormShow(Sender: TObject);
var
  i:integer;
  item:TMenuItem;
  server_date:tdatetime;
begin
//  field_name := DBGrideh1.Columns[0].FieldName ;
  PreColumn := DBGrideh1.Columns[0] ;

  for i:=1 to DBGrideh1.Columns.Count do
  begin
    item := TmenuItem.Create(self) ;
    item.Caption := dbgrideh1.Columns[i-1].Title.Caption ;
    if dbgrideh1.Columns[i-1].Visible then
        item.Checked := true ;
    item.OnClick := item_click ;
    if trim(vprev) <> '4'then
     if dbgrideh1.Columns[i-1].FieldName = 'MyPART_PRICE' then
        item.Enabled := false;
    self.PopupMenu2.Items.Add(item) ;
  end;

  ADOQuery1sql := DM.ADOQuery1.SQL.Text ;
  server_date:= getsystem_date(dm.TemADOQuery1,1);
  dm.ADOQuery1.Close ;
  dm.ADOQuery1.Parameters.ParamValues['Fromissue_date'] := server_date-1;
  dm.ADOQuery1.Parameters.ParamValues['Toissue_date'] := server_date+1;
  dm.ADOQuery1.Prepared;
  DM.ADOQuery1.Open ;
  dm.ADOQuery1.Sort:= PreColumn.FieldName;
end;

procedure TMainForm1.item_click(sender: TObject);
var
  i:byte;
begin
  (sender as tmenuItem).Checked := not ((sender as tmenuItem).Checked);
  if (sender as tmenuItem).Checked then
      begin
          for i := 0 to DBGrideh1.FieldCount-1 do
              if DBGrideh1.Columns[i].Title.Caption=(sender as tmenuItem).Caption then
                  begin
                      DBGrideh1.Columns[i].Visible:=true;
                      break;
                  end;
      end
  else
      begin
          for i := 0 to DBGrideh1.FieldCount-1 do
              if DBGrideh1.Columns[i].Title.Caption = (sender as tmenuItem).Caption then
                  begin
                      DBGrideh1.Columns[i].Visible := false;
                      break;
                  end;
      end;
end;

procedure TMainForm1.Edit1Change(Sender: TObject);
begin
  IF DBGrideh1.DataSource.DataSet.Active  THEN
      if trim(Edit1.text) <> '' then
          begin
              if PreColumn.Field.DataType  in [ftString,ftWideString]  then
                  DBGrideh1.DataSource.DataSet.Filter := PreColumn.FieldName+' like ''%'+trim(edit1.text)+'%'''
              else
               if PreColumn.Field.DataType  in [ftSmallint, ftInteger, ftWord]  then
               //dm.ADOQuery1.Fields.FieldByName(field_name).DataType
                  begin
                    try
                      strtoint(edit1.Text);
                      DBGrideh1.DataSource.DataSet.Filter := PreColumn.FieldName+' = '+trim(edit1.text) ;
                    except
                      showmessage('输入的内容不相符，只能输入数字');
                    end;
                  end
               else
                if PreColumn.Field.DataType  in [ftDate,ftTime, ftDateTime] then
                  begin
                      try
                         strtodatetime(edit1.Text);
                         DBGrideh1.DataSource.DataSet.Filter := PreColumn.FieldName+' = '''+ trim(edit1.text) +'''' ;
                      except
                         //showmessage('输入的内容不相符，只能输入日期') ;
                      end;
                  end;
          end
      else
          DBGrideh1.DataSource.DataSet.Filter := '' ;

end;

procedure TMainForm1.BitBtn4Click(Sender: TObject);
var
  i :integer;
  s:string;
begin
  s:='';
//  with TIf_Form1.Create(nil)do
//  try
   with If_Form1 do
   begin
    DateTimePicker1.Date := dm.ADOQuery1.Parameters.ParamValues['Toissue_date']-2;
    DateTimePicker2.Date := dm.ADOQuery1.Parameters.ParamValues['Toissue_date']-1 ;
    if ShowModal=mrok then
     begin
      dm.ADOQuery1.Close ;
      for i := 1 to sgrid1.RowCount-1  do
        s:=s+sgrid1.Cells[2,i];
      dm.ADOQuery1.SQL.Text:=self.ADOQuery1sql+s;
      dm.ADOQuery1.Parameters.ParamValues['Fromissue_date'] := DateTimePicker1.Date ;
      dm.ADOQuery1.Parameters.ParamValues['Toissue_date'] := DateTimePicker2.Date + 1 ;
      dm.ADOQuery1.Prepared;
      DM.ADOQuery1.Open ;
     end ;
   end;  
//  finally
//    Free ;
//  end;
end;

procedure TMainForm1.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
begin
  if not (gdFixed in State) then
   if DBGridEh1.DataSource.DataSet.Active then
    begin
     if  DBGridEh1.DataSource.DataSet.RecNo  mod 2=0 then
     begin
      DBGridEh1.Canvas.Brush.Color:=clinfobk;
      DBGridEh1.Canvas.FillRect(rect);
      DBGridEh1.Canvas.font.color:=clblack;
     end
     else
     begin
      DBGridEh1.Canvas.Brush.Color:=clwhite;
      DBGridEh1.Canvas.FillRect(rect);
      DBGridEh1.Canvas.font.color:=clblack;
     end;

     if ((State = [gdSelected]) or (State=[gdSelected,gdFocused])) then
      begin
       DBGridEh1.Canvas.Brush.Color:=RGB(0,224,224);
       DBGridEh1.Canvas.FillRect(rect);
       DBGridEh1.Canvas.font.color:=clblack;
      end;

     if dm.ADOQuery1qty_reject.Value > (dm.ADOQuery1ISSUED_QTY.Value-
                                       dm.ADOQuery1ORD_REQ_QTY.Value)*0.5 then
      DBGridEh1.Canvas.Font.Color := clred;

    DBGridEh1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
  end;

end;

procedure TMainForm1.DBGridEh1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (chr(key) = 'S') and (ssalt in shift) then
      showmessage((DBGridEh1.DataSource.DataSet as TADOQuery).SQL.Text);
end;

procedure TMainForm1.DBGridEh1TitleClick(Column: TColumnEh);
begin
 IF DBGridEh1.DataSource.DataSet.Active THEN
  begin
    if PreColumn.FieldName<>column.FieldName then
      begin
//        field_name := column.FieldName;
        label1.Caption := column.Title.Caption;
        edit1.Text := '' ;
        edit1.SetFocus;
        PreColumn.Title.Color := clBtnFace;
        Column.Title.Color := clred;
        PreColumn := column;
      end
    else
//     if field_name = column.FieldName then
      begin
        edit1.SetFocus;
        PreColumn.Title.Color := clBtnFace;
        Column.Title.Color := clred;
        PreColumn := column;
      end;
  end
  else
      showmessage('没有打开数据，请按: 查询 ');
end;

procedure TMainForm1.DBGridEh1TitleBtnClick(Sender: TObject; ACol: Integer;
  Column: TColumnEh);
begin
  if DBGridEh1.DataSource.DataSet.Active then
      (DBGridEh1.DataSource.DataSet as tadoquery).Sort := Column.FieldName;
end;

procedure TMainForm1.RadioGroup1Click(Sender: TObject);
var
  i:Integer;
begin
//  ShowMessage(IntToStr(DBGridEh1.FieldCount)+','+IntToStr(DBGridEh1.Columns.Count));
  if RadioGroup1.ItemIndex=0 then
  for i:=0 to DBGridEh1.Columns.Count-1 do
  begin
   if DBGridEh1.Columns[i].FieldName='area3_1' then
    DBGridEh1.Columns[i].FieldName:='area3';
   if DBGridEh1.Columns[i].FieldName='area2_1' then
    DBGridEh1.Columns[i].FieldName:='area2';
   if DBGridEh1.Columns[i].FieldName='area1_1' then
    DBGridEh1.Columns[i].FieldName:='area1';
   if DBGridEh1.Columns[i].FieldName='unit_sq_1' then
    DBGridEh1.Columns[i].FieldName:='unit_sq';
  end
  else
    for i:=0 to DBGridEh1.Columns.Count-1 do
    begin
     if DBGridEh1.Columns[i].FieldName='area3' then
      DBGridEh1.Columns[i].FieldName:='area3_1';
     if DBGridEh1.Columns[i].FieldName='area2' then
      DBGridEh1.Columns[i].FieldName:='area2_1';
     if DBGridEh1.Columns[i].FieldName='area1' then
      DBGridEh1.Columns[i].FieldName:='area1_1';
     if DBGridEh1.Columns[i].FieldName='unit_sq' then
      DBGridEh1.Columns[i].FieldName:='unit_sq_1';
    end
end;

procedure TMainForm1.N1Click(Sender: TObject);
begin
   strLab:=Trim(DBGridEh1.Fields[DBGridEh1.SelectedIndex].AsString);
   with TFrm_WorkDetails.Create(nil) do
   begin
     ShowModal;
     Free;
   end;
end;

procedure TMainForm1.N2Click(Sender: TObject);
begin
   if not dm.ADOQuery1.IsEmpty then 
   with TfrmViewSales.Create(nil) do
   begin
     ShowModal;
     Free;
   end;
end;

procedure TMainForm1.FormActivate(Sender: TObject);
begin
  with DM.Tmp do
  begin
    Close;
    SQL.Clear;
    SQL.Text:='select Rkey from data0419 where programe=''a_wzcx0492.exe''';
    Open;
    if not IsEmpty then
     rkey419:= FieldByName('rkey').Value;
  end;
  Self.showField(rkey419,DBGridEh1);
end;

procedure TMainForm1.DBGridEh1ColumnMoved(Sender: TObject; FromIndex,
  ToIndex: Integer);
var
  i,tmp:Integer;
begin
  if MessageDlg('列顺序已经改变，是否保存排序？',mtConfirmation,[mbYes,mbNo],0)=mrYes then
  begin
    if FromIndex>ToIndex then
    begin
      tmp:=FromIndex;
      FromIndex:=ToIndex;
      ToIndex:=tmp;
    end;
    for i:= FromIndex to ToIndex do
    begin
      with DM.tmp do
      begin
        Close;
        SQL.Clear;
        SQL.Text:='update data0849 set fieldorder='+ IntToStr(i)+' where D419_ptr='+
                IntToStr(rkey419) +' and D073_ptr='+rkey73 +
                ' and fieldname=' + QuotedStr(DBGridEh1.Columns[i].FieldName);
        ExecSQL;
      end;
    end;
  end;
end;

end.
