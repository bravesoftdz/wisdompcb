unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DB, DBGrids, Menus, StdCtrls, Buttons, ExtCtrls, DBGridEh,DateUtils;

type
  TForm1 = class(TForm)
    DBGrid1: TDBGrid;
    PopupMenu1: TPopupMenu;
    N9: TMenuItem;
    N11: TMenuItem;
    N21: TMenuItem;
    N24: TMenuItem;
    N26: TMenuItem;
    N27: TMenuItem;
    Panel5: TPanel;
    Label1: TLabel;
    BitBtn2: TBitBtn;
    BitBtn5: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn1: TBitBtn;
    Edit1: TEdit;
    PopupMenu2: TPopupMenu;
    N1: TMenuItem;
    procedure N5Click(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure N9Click(Sender: TObject);
    procedure N15Click(Sender: TObject);
    procedure N19Click(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure N18Click(Sender: TObject);
    procedure N16Click(Sender: TObject);
    procedure N17Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure N21Click(Sender: TObject);
    procedure N23Click(Sender: TObject);
    procedure N25Click(Sender: TObject);
    procedure N24Click(Sender: TObject);
    procedure N26Click(Sender: TObject);
    procedure N27Click(Sender: TObject);
    procedure N28Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure FormShow(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
  private
    { Private declarations }

    strSQLTxt:string;

    PreColumn: TColumn;
    field_name:string;

   OldGridWnd : TWndMethod;
   procedure NewGridWnd (var Message : TMessage);
   procedure item_click(Sender: TObject);
   function return_min_sysdate(rkey60:Integer):TDateTime;//返回最早的委外入库日期
   function return_max_444():TDateTime;   //返回最大的成本截数日期
   
  public

    function cacl_deficiency(rkey10:integer; nowAmount: currency):currency;//计算客户所欠金额
  end;

var
  Form1: TForm1;

implementation

uses damo,  note, detail, cust_search,common, Unit2, 
  edit_ordernumber, date_fw, fencai_so, change_ponumber, update_gongju,
  PasQuery, ADODB;

{$R *.dfm}
procedure TForm1.item_click(Sender: TObject);
var
  i:byte;
begin
  (Sender as TmenuItem).Checked := not ((Sender as TmenuItem).Checked);
  if (Sender as TmenuItem).Checked then
  begin
    for i := 0 to DBGrid1.FieldCount - 1 do
    if DBGrid1.Columns[i].Title.Caption = (Sender as TmenuItem).Caption then
    begin
      DBGrid1.Columns[i].Visible := True ;
      Break;
    end ;
  end
  else
  begin
    for i := 0 to DBGrid1.FieldCount - 1 do
    if DBGrid1.Columns[i].Title.Caption = (Sender as TmenuItem).Caption then
    begin
      DBGrid1.Columns[i].Visible := False ;
      Break;
    end ;
  end ;
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

procedure TForm1.N5Click(Sender: TObject);
begin
 application.Terminate;
end;

procedure TForm1.PopupMenu1Popup(Sender: TObject);
begin
  n9.Enabled:=true;   //查看SO详情
  n21.Enabled:=true; //更改交货数量
  n24.Enabled:=false;  //拆分
  n26.Enabled:=true;
  n27.Enabled:=true;

  case dm.ADO60status.Value of
    1,6:
    begin
     n24.Enabled:=true;
    end;
    2: //暂缓
    begin
     n21.Enabled:=false;
    end;
    5:
    begin
     n21.Enabled:=false;
    end;
    4:
    begin
      n21.Enabled:=true; //更改交货数量
      n26.Enabled:=true;
      n24.Enabled:=false;  //拆分      
      n27.Enabled:=true;
    end;
  else
    begin
     n9.Enabled:=false;    //查看SO详情
     n21.Enabled:=false;   //更改交货数量
     n26.Enabled:=false;
     n27.Enabled:=false;
    end;
  end;
end;

procedure TForm1.N9Click(Sender: TObject);
begin
  if not dm.ADO60.IsEmpty then
  begin
    form8:=tform8.Create(application);

    Form8.Edit11.Text:=dm.ADO60SHIPPING_CONTACT.Value; //装运联络人
    Form8.Edit12.Text:=dm.ADO60SHIP_CONTACT_PHONE.Value; //联络人电话

    dm.ADOQuery3.Close;
    dm.ADOQuery3.Parameters[1].Value:=dm.ADO60rkey.Value;
    dm.ADOQuery3.Open;
    form8.ShowModal;
    dm.ADOQuery3.Close;
    form8.Free;
  end;
end;

procedure TForm1.N15Click(Sender: TObject);
begin
  form_custmer:=tform_custmer.Create(application);
  if form_custmer.ShowModal=mrok then
  begin
    dm.ADO60.Close;
    dm.ADO60.SQL.Delete(dm.ADO60.SQL.Count-2);
    dm.ADO60.SQL.Insert(dm.ADO60.SQL.Count-1,'and data0010.rkey='+form_custmer.ADODataSet1rkey.AsString);
    dm.ADO60.Open;
  end;
  form_custmer.Free;
end;

procedure TForm1.N19Click(Sender: TObject);
begin
  dm.ADO60.Close;
  dm.ADO60.SQL.Delete(dm.ADO60.SQL.Count-2);
  dm.ADO60.SQL.Insert(dm.ADO60.SQL.Count-1,'');
  dm.ADO60.Open;
end;

procedure TForm1.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (chr(key)='S') and (ssalt in shift) then
    showmessage(dm.ado60.SQL.Text);
end;

procedure TForm1.N18Click(Sender: TObject);
var
 str:string;
begin
  str:='';
  if inputquery('销售订单查找','请输入要查找的销售订单号:            ',str) then
    if trim(str)<>'' then
    begin
      dm.ADO60.Close;
      dm.ADO60.SQL.Delete(dm.ADO60.SQL.Count-2);
      dm.ADO60.SQL.Insert(dm.ADO60.SQL.Count-1,'and data0060.SALES_ORDER like ''%'+str+'%''');
      dm.ADO60.Open;
    end;
end;

procedure TForm1.N16Click(Sender: TObject);
var
 str:string;
begin
  str:='';
  if inputquery('销售订单查找','请输入要查找的产品板号:            ',str) then
    if trim(str)<>'' then
    begin
      dm.ADO60.Close;
      dm.ADO60.SQL.Delete(dm.ADO60.SQL.Count-2);
      dm.ADO60.SQL.Insert(dm.ADO60.SQL.Count-1,'and data0025.MANU_PART_NUMBER like ''%'+str+'%''');
      dm.ADO60.Open;
    end;
end;

procedure TForm1.N17Click(Sender: TObject);
var
 str:string;
begin
  str:='';
  if inputquery('销售订单查找','请输入要查找的客户采购订单号:            ',str) then
    if trim(str)<> '' then
    begin
     dm.ADO60.Close;
     dm.ADO60.SQL.Delete(dm.ADO60.SQL.Count-2);
     dm.ADO60.SQL.Insert(dm.ADO60.SQL.Count-1,'and data0097.PO_NUMBER like ''%'+str+'%''');
     dm.ADO60.Open;
    end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
 if not app_init_2(dm.ADOConnection1) then
  begin
   showmsg('程序起动失败,请联系管理!',1);
   application.Terminate;
  end;

//  dm.ADOConnection1.Connected := True;
//  rkey73:='5160';
//  vprev:='4';

  self.Caption:=application.Title;
  DateSeparator := '-';
  ShortDateFormat := 'yyyy-mm-dd';
  OldGridWnd := DBGrid1.WindowProc;
  DBGrid1.WindowProc := NewGridWnd;

//  if GetServerRegion(DM.ADOConnection1) = '深圳' then
//  begin
//    ShowMessage('旧版本程序已经停用，请使用新版系统，请联系ERP，谢谢');
//    application.Terminate;
//  end;

end;

procedure TForm1.FormActivate(Sender: TObject);

begin
  if dm.ADOConnection1.Connected then
  begin

    dm.ADO60.Close;
    dm.ADO60.Parameters[0].Value:=getsystem_date(dm.ADOQuery1,1)-15;
    dm.ADO60.Parameters[1].Value:=getsystem_date(dm.ADOQuery1,1)+1;
    dm.ADO60.Open;
    dm.ADO60.Sort :=PreColumn.FieldName; 
  end;
end;

procedure TForm1.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
  if dm.ADO60status.Value=5 then
  DBGrid1.Canvas.Font.Color := clBlue;
  DBGrid1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TForm1.N21Click(Sender: TObject);
var
 parts_ordered:integer;
 parts_price:double;
 due_date:tdatetime;
 sName:string;
begin
  if (strtoint(vprev)=1) or (strtoint(vprev)=3) then
   begin
    showmessage('对不起您只有该程序的只读权限');
    exit;
   end;
  with dm.ADOQuery1 do
   begin
    close;
    sql.Text := 'select rkey from data0064 where SO_PTR='+dm.ADO60rkey.AsString;
    open;
   end;

  if not dm.ADOQuery1.IsEmpty then
  begin
    showmsg('订单已经产生送货记录,不允许修改,请与仓库联系退仓后再修改!',1);
    Exit;
  end;

 //20161219tang修改提交之前查看订单版本是否无效，并提示新版本---
  dm.ADOQuery4.Close;
  dm.ADOQuery4.SQL.Text:='select ONHOLD_SALES_FLAG from data0025 where rkey='+inttostr(dm.ADO60CUST_PART_PTR.Value);
  dm.ADOQuery4.Open;
  if (dm.ADOQuery4.FieldByName('ONHOLD_SALES_FLAG').AsInteger=1) then
  begin
    dm.Ado273_25.Close;
    dm.Ado273_25.Parameters.ParamByName('Rkey25').Value:=dm.ADO60CUST_PART_PTR.Value;
    dm.Ado273_25.Open;
    if not dm.Ado273_25.IsEmpty then
    begin
      sName:= dm.Ado273_25.FieldByName('MANU_PART_NUMBER').AsString;
    end else
    begin
      sName:= '空';
    end;
    if messagedlg('当前销售单已暂停销售，升级的本厂编号为【'+sName+'】，是否继续?',mtConFirmation,[mbYes,mbNo],0)= mrNo then Exit;
  end;
//end 20161219tang
  try
    form4 := tform4.Create(application);
    dm.ADO60.Edit;
    //20161019tang修改以预处理下单数量不能修改
    if dm.ADO60rkey213.Value>0 then
    begin
      Form4.DBEdit1.Enabled:=False;
      Form4.DBEdit4.Enabled:=False;
    end;
    parts_ordered := dm.ADO60PARTS_ORDERED.AsInteger;
    Form4.parts_ordered:=dm.ADO60PARTS_ORDERED.AsInteger;
    parts_price := dm.ADO60part_price.Value;
    due_date := dm.ADO60ORIG_SCHED_SHIP_DATE.Value;//原计划交期
    if form4.ShowModal = mrok then
     begin
       with dm.ADOQuery1 do
        begin
          close;
          sql.Text := 'select rkey from data0064 where SO_PTR='+dm.ADO60rkey.AsString;
          open;
        end;
        if not dm.ADOQuery1.IsEmpty then  //需再次检查
        begin
          showmsg('订单已经产生送货记录,不允许修改,请与仓库联系退仓后再修改!',1);
          dm.ADO60.Cancel;
          Exit;
        end;
      if dm.ADO60so_tp.Value=1 then //如果订单为外发订单
      if return_min_sysdate(dm.ADO60rkey.Value) < return_max_444 then
      begin
        showmsg('委外订单已经入库且在成本截数日期之前,不允许修改!',1);
        dm.ADO60.Cancel;
        Exit;
      end;

      dm.ADOConnection1.BeginTrans;
      try
      if dm.ADO60PARTS_ORDERED.Value <> parts_ordered then
      begin
        dm.ADO60to_be_planned.Value := dm.ADO60PARTS_ORDERED.AsInteger-dm.ADO60qty_plannned.Value;
        if dm.ADO60to_be_planned.Value <= 0 then dm.ADO60prod_rel.Value:='3';//投产完成
        with dm.ADOQuery1 do
        begin
          close;                  //记录销售订单数量更改情况(日志文件)
          sql.Clear;
          sql.Add('insert into data0318 (SALES_ORDER_PTR,TRANS_TYPE,TRANS_DESCRIPTION,');
          sql.Add('FROM_string,TO_string,USER_PTR,TRANS_DATE,PROGRAM_SOURCE,file_number)');
          sql.Add('values ('+dm.ADO60rkey.AsString+',2,''更改销售订单数量pcs'',');
          sql.Add(''+inttostr(PARTs_ordered)+','+dm.ADO60PARTS_ORDERED.AsString+','+rkey73+',');
          sql.add('getdate(),305,'''+trim(form4.Edit1.Text)+''')');
          ExecSQL;
        end;
      end;

      if dm.ADO60PART_price.Value<>parts_price then
      begin
        with dm.ADOQuery1 do
        begin
          close;                  //记录销售订单价格更改情况(日志文件)
          sql.Clear;
          sql.Add('insert into data0318 (SALES_ORDER_PTR,TRANS_TYPE,TRANS_DESCRIPTION,');
          sql.Add('FROM_string,TO_string,USER_PTR,TRANS_DATE,PROGRAM_SOURCE,file_number)');
          sql.Add('values ('+dm.ADO60rkey.AsString+',3,''更改销售订单价格pcs'',');
          sql.Add(''+floattostr(PARTs_price)+','+dm.ADO60PART_price.AsString+','+rkey73+',');
          sql.add('getdate(),305,'''+trim(form4.Edit1.Text)+''')');
          ExecSQL;
        end;
        if dm.ADO60part_price.Value<>0 then
          with dm.ADOQuery2 do
           begin
            close;
            sql.Clear;
            sql.Add('update data0025');
            sql.Add('set latest_price=:last_price');
            sql.Add('where rkey='+dm.ADO60CUST_PART_PTR.AsString);
            if dm.ADO60tax_in_price.Value='N' then
              Parameters.ParamByName('last_price').Value:=
              formatfloat('0.0000',dm.ADO60part_price.Value/dm.ADO60EXCH_RATE.Value)
            else
              Parameters.ParamByName('last_price').Value:=
              formatfloat('0.0000',dm.ADO60part_price.Value/dm.ADO60EXCH_RATE.Value/
                                  (1+dm.ADO60RUSH_CHARGE.Value*0.01));
            ExecSQL;
           end;

        if dm.ADO60tax_in_price.Value='N' then
          dm.ADO60parts_alloc.Value:=dm.ADO60part_price.Value
        else
          dm.ADO60parts_alloc.Value:=dm.ADO60part_price.Value/
                                (1+dm.ADO60RUSH_CHARGE.Value*0.01);
      end;

       if due_DATE <> dm.ADO60ORIG_SCHED_SHIP_DATE.Value then
        with dm.ADOQuery1 do      //记录销售订单计划交期更改情况(日志文件)
        begin
          close;
          sql.Clear;
          sql.Add('insert into data0318 (SALES_ORDER_PTR,TRANS_TYPE,TRANS_DESCRIPTION,');
          sql.Add('FROM_string,TO_string,USER_PTR,TRANS_DATE,PROGRAM_SOURCE,file_number)');
          sql.Add('values ('+dm.ADO60rkey.AsString+',4,''更改销售订单计划交期'',');
          sql.Add(''''+datetostr(due_date)+''','''+dm.ADO60ORIG_SCHED_SHIP_DATE.AsString+''','+rkey73+',');
          sql.add('getdate(),305,'''+trim(form4.Edit1.Text)+''')');
          ExecSQL;
        end;
       if dm.ADO60PARTS_ORDERED.Value<=dm.ADO60PARTS_SHIPPED.Value then
        dm.ADO60status.Value:=4; //标识订单已完成


       dm.ADO60.Post;
       dm.aq360.UpdateBatch();
       if (dm.ADO60PART_price.Value<>parts_price) and (dm.ADO60so_tp.Value=1) then
       begin
        with DM.ADOQuery1 do
        begin
          close;
          sql.Clear;
          sql.Text:=
         'update data0053 '+#13+
         'set cost_pcs='+#13+
         'case when Data0025.ttype=0 then Data0060.PARTS_ALLOC*isnull(Data0060.TAX_2,0)*0.01/Data0060.EXCH_RATE'+#13+
         'else Data0060.PARTS_ALLOC/Data0060.EXCH_RATE end'+#13+
         'FROM         Data0053 INNER JOIN'+#13+
         '      data0416 ON Data0053.NPAD_PTR = data0416.rkey INNER JOIN'+#13+
         '      Data0060 ON data0416.so_ptr = Data0060.RKEY INNER JOIN'+#13+
         '      Data0025 ON Data0053.CUST_PART_PTR = Data0025.RKEY'+#13+
         'where data0416.type=3'+#13+
         'and data0416.so_ptr='+dm.ADO60RKEY.AsString;
         ExecSQL;
        end;
       end;

       DM.ADOConnection1.CommitTrans;
       ShowMessage('更新成功');
       BitBtn2Click(sender);
      except
       on E: Exception do
        begin
         dm.ADOConnection1.RollbackTrans;
         messagedlg(E.Message,mterror,[mbcancel],0);
        end;
      end;

     end
    else
     begin
      dm.ADO60.Cancel;
      dm.aq360.CancelBatch();
     end;
  finally
    form4.Free;
  end;
end;

procedure TForm1.N23Click(Sender: TObject);
begin
  form5:=tform5.Create(application);
  if form5.ShowModal=mrok then
  begin
    dm.ADO60.Close;
    dm.ADO60.Parameters[0].Value:=form5.DTpk1.Date;
    dm.ADO60.Parameters[1].Value:=form5.DTpk2.Date+1;
    dm.ADO60.Open;
  end;
  form5.Free;
end;

procedure TForm1.N25Click(Sender: TObject);
var
 rkey60:integer;
begin
  rkey60:=dm.ADO60rkey.Value;
  dm.ADO60.Close;
  dm.ADO60.Open;
  if rkey60>0 then dm.ADO60.Locate('rkey',rkey60,[]);
end;

procedure TForm1.N24Click(Sender: TObject);
var
 i,j:byte;
 reput1,reput2:single;
 sName:string;
begin
//  if (dm.ADO60qty_plannned.Value > 0) and (dm.ADO60prod_rel.Value <> '3') then //正在投产没有投完的订单不能拆分
//  begin
//    showmsg('正在投产没有投完的订单不能拆分!!!',1);
//    exit;
//  end;
  if (strtoint(vprev)=1) or (strtoint(vprev)=3) then
  begin
    showmessage('对不起您只有该程序的只读权限');
    exit;
  end;
 //20161219tang修改提交之前查看订单版本是否无效，并提示新版本---
  dm.ADOQuery4.Close;
  dm.ADOQuery4.SQL.Text:='select ONHOLD_SALES_FLAG from data0025 where rkey='+inttostr(dm.ADO60CUST_PART_PTR.Value);
  dm.ADOQuery4.Open;
  if (dm.ADOQuery4.FieldByName('ONHOLD_SALES_FLAG').AsInteger=1) then
  begin
    dm.Ado273_25.Close;
    dm.Ado273_25.Parameters.ParamByName('Rkey25').Value:=dm.ADO60CUST_PART_PTR.Value;
    dm.Ado273_25.Open;
    if not dm.Ado273_25.IsEmpty then
    begin
      sName:= dm.Ado273_25.FieldByName('MANU_PART_NUMBER').AsString;
    end else
    begin
      sName:= '空';
    end;
    if messagedlg('当前销售单已暂停销售，升级的本厂编号为【'+sName+'】，是否继续?',mtConFirmation,[mbYes,mbNo],0)= mrNo then Exit;
  end;
//end 20161219tang
  dm.ADOQuery3.Close;
  dm.ADOQuery3.Parameters[1].Value:=dm.ADO60rkey.Value;
  dm.ADOQuery3.Open;
  application.CreateForm(tform6,form6);
  form6.Edit1.Text:=dm.ADOQuery3PARTS_ORDERED.AsString;
  form6.Edit2.Text:=dm.ADOQuery3set_ordered.AsString;
  form6.Label10.Caption := dm.ADOQuery3set_qty.AsString ;
  if form6.ShowModal=mrok then
  begin
    dm.ADOConnection1.BeginTrans;
    try
      with dm.ADOQuery1 do
      begin
        close;                  //记录销售订单数量更改情况(日志文件)
        sql.Clear;
        sql.Add('insert into data0318 (SALES_ORDER_PTR,TRANS_TYPE,TRANS_DESCRIPTION,');
        sql.Add('FROM_string,TO_string,USER_PTR,TRANS_DATE,PROGRAM_SOURCE,file_number)');
        sql.Add('values ('+dm.ADO60rkey.AsString+',2,''因拆分更改销售订单数量'',');
        sql.Add(''+dm.ADO60PARTS_ORDERED.AsString+','+form6.Edit1.Text+','+rkey73+',');
        sql.add('getdate(),305,'''+trim(form6.Edit3.Text)+''')');
        ExecSQL;
      end;
      reput1:=dm.ADO60.FieldByName('REPUT_QTY').AsFloat;
      reput2:=dm.ADO60.FieldByName('REPUT_APPR_BY').AsFloat;
      dm.ADO60.Edit;
      dm.ADO60PARTS_ORDERED.Value:=strtofloat(form6.Edit1.Text);
      dm.ADO60set_ordered.Value:=strtoint(form6.Edit2.Text);
      if dm.ADO60.FieldByName('REPUT_QTY').asFloat>strtofloat(form6.Edit1.Text) then
        dm.ADO60.FieldByName('REPUT_QTY').AsFloat:=strtofloat(form6.Edit1.Text);
      if dm.ADO60.FieldByName('REPUT_APPR_BY').asFloat>strtofloat(form6.Edit1.Text) then
        dm.ADO60.FieldByName('REPUT_APPR_BY').AsFloat:=strtofloat(form6.Edit1.Text);

      if dm.ADO60PARTS_ORDERED.Value+dm.ADO60PARTS_RETURNED.Value <= dm.ADO60PARTS_SHIPPED.Value+dm.ADO60RETURNED_SHIP.Value then
        dm.ADO60status.Value:=4; //标识订单已完成

       if DM.ADOQuery3ISSUED_QTY.AsInteger=0 then    //原订单未投产那么原订单待计划数要与订单数相同
        DM.ADO60TO_BE_PLANNED.Value:=DM.ADO60PARTS_ORDERED.AsInteger;
      dm.ADO60.Post;
      dm.aq360.UpdateBatch();
      reput1:=reput1-dm.ADO60.FieldByName('PARTS_ORDERED').asFloat;
      reput2:=reput2-dm.ADO60.FieldByName('PARTS_ORDERED').asFloat;
      with dm.ADOtemp60 do
       begin
        close;
        sql.Clear;
        sql.Add('select * from data0060');
        sql.Add('where rkey='+dm.ADO60rkey.AsString);
        open;
       end;
      with dm.ADOQuery2 do     //打开评审子表
       begin
        close;
        sql.Clear;
        sql.Add('select * from data0090');
        sql.Add('where pact_ptr='+dm.ADO60rkey.AsString);
        open;
       end;

      dm.Append60.Open;
      dm.Append90.Open;
      for j:=1 to form6.SGrid1.RowCount-2 do
      begin
        dm.Append60.Append;
        for i:=2 to dm.ADOtemp60.FieldCount-1 do
         dm.Append60.FieldValues[dm.ADOtemp60.Fields[i].FieldName]:=dm.ADOtemp60.FieldValues[dm.ADOtemp60.Fields[i].FieldName];
          dm.Append60.FieldValues['sales_order']:=form6.SGrid1.Cells[0,j];         //销售订单
          dm.Append60.FieldValues['PARTS_ORDERED']:=form6.SGrid1.Cells[2,j];       //订单PCS数量
          dm.Append60.FieldValues['set_ORDERED']:=form6.SGrid1.Cells[1,j];         //订单SET数量
          dm.Append60.FieldValues['ORIG_REQUEST_DATE']:=form6.SGrid1.Cells[3,j];   //回复客户交货期
          dm.Append60.FieldValues['ORIG_SCHED_SHIP_DATE']:=form6.SGrid1.Cells[4,j]; //提交计划装运日期
          dm.Append60.FieldValues['TOTAL_ADD_L_PRICE']:=0;//工具费用
          dm.append60.FieldValues['status']:=1;        //状态 有效
          dm.append60.FieldValues['PARTS_SHIPPED']:=0;  //已装运的数量
          dm.append60.FieldValues['PARTS_RETURNED']:=0; //已退回的数量
          dm.append60.FieldValues['PARTS_INVOICED']:=0; //已开发票数量
          dm.Append60.FieldValues['QTY_PLANNNED']:=0;   //已计划的数量
          dm.Append60.FieldValues['ISSUED_QTY']:=0;     //已投产数量
          dm.Append60.FieldValues['RETURNED_SHIP']:=0;  //退货再指派数量
          if reput1>=dm.Append60.FieldByName('PARTS_ORDERED').asFloat then
          begin
            dm.Append60.FieldValues['REPUT_QTY']:=dm.Append60.FieldValues['PARTS_ORDERED'];
            reput1:=reput1-dm.Append60.FieldByName('PARTS_ORDERED').asFloat;
          end
          else
          begin
            if reput1<0 then
              dm.Append60.FieldValues['REPUT_QTY']:=0
            else
              dm.Append60.FieldValues['REPUT_QTY']:=reput1;
            reput1:=0;
          end;
          if reput2>=dm.Append60.FieldByName('PARTS_ORDERED').asFloat then
          begin
            dm.Append60.FieldValues['REPUT_APPR_BY']:=dm.Append60.FieldValues['PARTS_ORDERED'];
            reput2:=reput2-dm.Append60.FieldByName('PARTS_ORDERED').asFloat;
          end
          else
          begin
            if reput2<0 then
              dm.Append60.FieldValues['REPUT_APPR_BY']:=0
            else
            dm.Append60.FieldValues['REPUT_APPR_BY']:=reput2;
            reput2:=0;
          end;
          if DM.ADOQuery3ISSUED_QTY.AsInteger=0 then    //原订单未投产
           begin
            dm.Append60.FieldValues['TO_BE_PLANNED']:=form6.SGrid1.Cells[2,j];
           end
          else
           begin
            dm.Append60.FieldValues['TO_BE_PLANNED']:=0;  //待计划数
            dm.Append60.FieldValues['PROD_REL']:=3;       //生产发放标记  3为已投产
           end;

        dm.Append60.Post;

        with dm.ADOQuery1 do
        begin
          close;                  //新订单入库计划
          sql.Clear;
          sql.Add('insert into data0360 (so_ptr,quantity,sch_date)');
          sql.Add('values ('+dm.Append60.fieldbyname('rkey').AsString+',');
          sql.Add(''+dm.Append60.fieldbyname('PARTS_ORDERED').AsString+',');
          sql.add(''+quotedstr(form6.SGrid1.Cells[4,j])+')');
          ExecSQL;
        end;

        dm.ADOQuery2.First;
       while not dm.ADOQuery2.Eof do     //新增评审子表
        begin
         dm.Append90.Append;
         for i:=2 to 6 do
          dm.Append90.FieldValues[dm.Append90.Fields[i].FieldName] :=
                    dm.ADOQuery2.FieldValues[dm.Append90.Fields[i].FieldName];
         dm.Append90.FieldValues['pact_ptr'] := dm.Append60.FieldValues['rkey'];
         dm.Append90.Post;
         dm.ADOQuery2.Next;
        end;
      end;

     dm.ADOConnection1.CommitTrans;
     showmessage('拆分成功');
     n25click(sender);       //刷新数据
    except
    on E: Exception do
     begin
      dm.ADOConnection1.RollbackTrans;
      messagedlg(E.Message,mterror,[mbcancel],0);
     end;
    end;
  end;
 form6.Free;
 dm.ADOQuery3.Close;
 dm.ADOQuery1.Close;
 dm.ADOQuery2.Close;
 dm.ADOQuery4.Close;
 dm.Append60.Close;
 dm.Append90.Close;

 dm.aq360.Close;
end;

procedure TForm1.N26Click(Sender: TObject);
var
  old_ponumber:string;
  old_fob:string;
  old_cust_code:string;

  old_REFERENCE_NUMBER:string;
  old_CURRENCY,COMMISION_ON_TOOLING,tax_in_price:string;
  old_ORIG_REQUEST_DATE:string;
 sName:string;
begin
  if (strtoint(vprev)=1) or (strtoint(vprev)=3) then
   begin
    showmessage('对不起您只有该程序的只读权限');
    exit;
   end;
  with dm.ADOQuery1 do
   begin
    Active:=False;
    SQL.Clear;
    SQL.Add('select PARTS_SHIPPED from data0060 where sales_order='''+dm.ADO60SALES_ORDER.Value+'''');
    Active:=True;
    if FieldValues['PARTS_SHIPPED']>0 then
    begin
      ShowMessage('此订单已有出货记录，不能修改客户代码/客户订单号');
      Exit;
    end;
   end;
 //20161219tang修改提交之前查看订单版本是否无效，并提示新版本---
  dm.ADOQuery4.Close;
  dm.ADOQuery4.SQL.Text:='select ONHOLD_SALES_FLAG from data0025 where rkey='+inttostr(dm.ADO60CUST_PART_PTR.Value);
  dm.ADOQuery4.Open;
  if (dm.ADOQuery4.FieldByName('ONHOLD_SALES_FLAG').AsInteger=1) then
  begin
    dm.Ado273_25.Close;
    dm.Ado273_25.Parameters.ParamByName('Rkey25').Value:=dm.ADO60CUST_PART_PTR.Value;
    dm.Ado273_25.Open;
    if not dm.Ado273_25.IsEmpty then
    begin
      sName:= dm.Ado273_25.FieldByName('MANU_PART_NUMBER').AsString;
    end else
    begin
      sName:= '空';
    end;
    if messagedlg('当前销售单已暂停销售，升级的本厂编号为【'+sName+'】，是否继续?',mtConFirmation,[mbYes,mbNo],0)= mrNo then Exit;
  end;
//end 20161219tang
  form10:=tform10.Create(application);
  form10.rkey97 := dm.ADO60PURCHASE_ORDER_PTR.Value;
  form10.edit2.Text := dm.ADO60PO_NUMBER.Value;
  form10.edit2.Font.Color := clwindowtext;
  form10.Edit3.Text := dm.ADO60po_date.AsString;
  form10.Edit4.Text := dm.ADO60REFERENCE_NUMBER.Value;
  Form10.Edit6.Text:=dm.ADO60CUST_CODE.Value;
  Form10.Label17.Caption:=dm.ADO60CUST_CODE.Value;//20140318
  Form10.Label9.Caption:=DM.ADO60customer_name.Value;
  Form10.Label10.Caption:=dm.ADO60rkey10.Text;
  Form10.Label11.Caption:=dm.ADO60CUST_SHIP_ADDR_PTR.AsString;  //装运地址12.rkey
  old_ponumber:=dm.ADO60PO_NUMBER.Value;
  old_fob:=dm.ADO60FOB.Value;
  old_cust_code:=dm.ADO60CUST_CODE.Value;

  old_CURRENCY:=DM.ADO60CURR_CODE.Value;
  old_REFERENCE_NUMBER:=DM.ADO60REFERENCE_NUMBER.Value;
  form10.Edit5.Text:=dm.ADO60FOB.Value;               //合同号
  Form10.Edit7.Text:=dm.ADO60LOCATION.Value;           //装运地址
  Form10.Edit4.Text:=dm.ADO60REFERENCE_NUMBER.Value;  //参考
  Form10.Edit11.Text:=dm.ADO60SHIPPING_CONTACT.Value; //装运联络人
  Form10.Edit12.Text:=dm.ADO60SHIP_CONTACT_PHONE.Value; //联络人电话
  Form10.Edit8.Text:=DM.ADO60CURR_CODE.Value;
  Form10.Edit8.Tag:=DM.ADO60CURRENCY_PTR.Value;
  Form10.Edit10.Text:=DM.ADO60EXCH_RATE.Text;
  Form10.Edit13.Text:=DM.ADO60ORIG_REQUEST_DATE.AsString;//客户交期
  Form10.edt1.Text := DM.ADO60.fieldbyname('ANALYSIS_CODE_1').Asstring;
  old_ORIG_REQUEST_DATE:=DM.ADO60ORIG_REQUEST_DATE.AsString;

  if DM.ADO60tax_in_price.Value='Y' then
    Form10.CheckBox1.Checked:=True
  else
    Form10.CheckBox1.Checked:=False;
  if DM.ADO60COMMISION_ON_TOOLING.Value='Y' then
    Form10.CheckBox2.Checked:=True
  else
    Form10.CheckBox2.Checked:=False;
  Form10.Edit9.Text:=DM.ADO60RUSH_CHARGE.Text;
  with DM.ADOQuery2 do
  begin
    Close;
    SQL.Clear;
    SQL.Text:='select custciship from data0192';
    Open;
    if FieldValues['custciship']='Y' then //用户不可以修改货币
    begin
      Form10.Edit8.Enabled:=False;
      Form10.BitBtn4.Enabled:=False;
    end
    else
    begin
      Form10.Edit8.Enabled:=True;
      Form10.BitBtn4.Enabled:=True;
    end;
  end;
  if form10.ShowModal=mrok then
  begin
    with dm.ADOQuery1 do
    begin
      close;
      sql.Text := 'SELECT t112.invoice_number'+#13+
                  'FROM Data0060 t60 INNER JOIN Data0064 t64 ON t60.RKEY=t64.SO_PTR'+#13+
                  'INNER JOIN Data0439 t439 ON t64.packing_list_ptr=t439.rkey'+#13+
                  'INNER JOIN Data0112 t112 ON t439.invoice_ptr=t112.RKEY'+#13+
                  'WHERE t60.RKEY='+dm.ADO60rkey.AsString;
      open;
    end;
    if not dm.ADOQuery1.IsEmpty then
    begin
      ShowMessage('此订单已生成账龄,不能修改客户代码/客户订单号!');
      dm.ADO60.Cancel;
      Exit;
    end;
    dm.ADOConnection1.BeginTrans;
    try
      with DM.ADOQuery1 do
      begin
        Close;
        SQL.Clear;
        SQL.Add('update data0060 set ');
        SQL.Add('ANALYSIS_CODE_1 = ' + QuotedStr(form10.Edt1.Text));
        SQL.Add(' where rkey='+dm.ADO60rkey.AsString);
        ExecSQL;
      end;

      if form10.Edit6.Text<>old_cust_code then
      begin
          if not Form10.CheckBox2.Checked then   //不转厂
            COMMISION_ON_TOOLING:='N'
          else
            COMMISION_ON_TOOLING:='Y';

          if not Form10.CheckBox1.Checked then   //价格不含税
            tax_in_price:='N'
          else
            tax_in_price:='Y';
        with DM.ADOQuery1 do      //记录更改客户代码
        begin
          Close;
          SQL.Clear;
          SQL.Add('update data0060 set CUSTOMER_PTR='+Form10.Label10.Caption);
          sql.Add(',COMMISION_ON_TOOLING='''+ COMMISION_ON_TOOLING+'''');
          sql.Add(',tax_in_price='''+tax_in_price+'''');
          SQL.Add(' where rkey='+dm.ADO60rkey.AsString);
          ExecSQL;
        end;

        with dm.ADOQuery1 do
        begin
          close;                  //记录客户订单更改情况(日志文件)
          sql.Clear;
          sql.Add('insert into data0318 (SALES_ORDER_PTR,TRANS_TYPE,TRANS_DESCRIPTION,');
          sql.Add('FROM_STRING,TO_STRING,USER_PTR,TRANS_DATE,PROGRAM_SOURCE,file_number)');
          sql.Add('values ('+dm.ADO60rkey.AsString+',1,''更改客户代码'',');
          sql.Add(''''+old_cust_code+''','''+form10.Edit6.Text+''','+rkey73+',');
          sql.add('getdate(),305,'''+form10.Edit1.Text+''')');
          ExecSQL;
        end;
      end;

      //记录更改货币
      if Form10.Edit8.Text<>old_CURRENCY then
      begin
        with DM.ADOQuery1 do
         begin
          Close;
          SQL.Clear;
          SQL.Add('update data0060 set CURRENCY_PTR='+inttostr(Form10.Edit8.Tag)+',');
          SQL.Add('EXCH_RATE='+form10.Edit10.Text+' where rkey='+dm.ADO60rkey.AsString);
          ExecSQL;
         end;
        with dm.ADOQuery1 do
        begin
          close;                  //记录客户订单更改情况(日志文件)
          sql.Clear;
          sql.Add('insert into data0318 (SALES_ORDER_PTR,TRANS_TYPE,TRANS_DESCRIPTION,');
          sql.Add('FROM_STRING,TO_STRING,USER_PTR,TRANS_DATE,PROGRAM_SOURCE,file_number)');
          sql.Add('values ('+dm.ADO60rkey.AsString+',1,''更改货币'',');
          sql.Add(''''+old_CURRENCY+''','''+form10.Edit8.Text+''','+rkey73+',');
          sql.add('getdate(),305,'''+form10.Edit1.Text+''')');
          ExecSQL;
        end;
        with dm.ADOQuery2 do
         begin
          close;
          sql.Clear;
          sql.Add('update data0025');
          sql.Add('set latest_price='+formatfloat('0.0000',dm.ADO60PARTS_ALLOC.Value/
                                     strtofloat(form10.Edit10.Text)));
          sql.Add('where rkey='+dm.ADO60CUST_PART_PTR.AsString);
          ExecSQL;
         end;
      end;

      //记录更改装运地址
      if StrToInt(Form10.Label11.Caption)<>dm.ADO60CUST_SHIP_ADDR_PTR.Value then
      begin
        with DM.ADOQuery1 do
        begin
          Close;
          SQL.Clear;
          SQL.Add('update data0060 set CUST_SHIP_ADDR_PTR='+Form10.Label11.Caption+',');
          sql.Add('SHIPPING_CONTACT='+QuotedStr(form10.edit11.text));
          sql.Add(',SHIP_CONTACT_PHONE='+QuotedStr(form10.edit12.Text));
          SQL.Add(',RUSH_CHARGE ='+form10.Edit9.Text+' where rkey='+dm.ADO60rkey.AsString);
          ExecSQL;
        end;

        with dm.ADOQuery1 do
        begin
          close;                  //记录装运地点更改情况(日志文件)
          sql.Clear;
          sql.Add('insert into data0318 (SALES_ORDER_PTR,TRANS_TYPE,TRANS_DESCRIPTION,');
          sql.Add('FROM_STRING,TO_STRING,USER_PTR,TRANS_DATE,PROGRAM_SOURCE,file_number)');
          sql.Add('values ('+dm.ADO60rkey.AsString+',1,''更改装运地址'',');
          sql.Add(''''+dm.ADO60LOCATION.Value+''','''+form10.Edit7.Text+''','+rkey73+',');
          sql.add('getdate(),305,'''+form10.Edit1.Text+''')');
          ExecSQL;
        end;
      end;

      if form10.rkey97 <> dm.ADO60PURCHASE_ORDER_PTR.Value then
      begin
          with dm.ADOQuery1 do //更新60表的客户订单号指针
          begin
            close;
            sql.Clear;
            sql.Add('update data0060');
            sql.Add('set PURCHASE_ORDER_PTR='+inttostr(form10.rkey97));
            sql.Add('where rkey='+dm.ADO60rkey.AsString);
            ExecSQL;
          end;
       
          with dm.ADOQuery1 do          //更新97表的最后下单日期
          begin
            close;
            sql.Clear;
            sql.Add('update data0097');
            sql.Add('set po_date='''+form10.Edit3.Text+'''');
            sql.Add('where rkey='+inttostr(form10.rkey97));
            ExecSQL;
          end;

        with dm.ADOQuery1 do
        begin
          close;                  //记录客户订单更改情况(日志文件)
          sql.Clear;
          sql.Add('insert into data0318 (SALES_ORDER_PTR,TRANS_TYPE,TRANS_DESCRIPTION,');
          sql.Add('FROM_STRING,TO_STRING,USER_PTR,TRANS_DATE,PROGRAM_SOURCE,file_number)');
          sql.Add('values ('+dm.ADO60rkey.AsString+',1,''更改客户订单号'',');
          sql.Add(''''+old_ponumber+''','''+form10.Edit2.Text+''','+rkey73+',');
          sql.add('getdate(),305,'''+trim(form10.Edit1.Text)+''')');
          ExecSQL;
        end;
      end;

      if form10.Edit5.Text<>old_fob then
      begin
        with DM.ADOQuery1 do
        begin
          Close;
          SQL.Clear;
          SQL.Add('update data0060 set FOB='''+trim(Form10.Edit5.Text)+'''');
          SQL.Add('where rkey='+dm.ADO60rkey.AsString);
          ExecSQL;
        end;

        with dm.ADOQuery1 do
        begin
          close;                  //记录客户订单更改情况(日志文件)
          sql.Clear;
          sql.Add('insert into data0318 (SALES_ORDER_PTR,TRANS_TYPE,TRANS_DESCRIPTION,');
          sql.Add('FROM_STRING,TO_STRING,USER_PTR,TRANS_DATE,PROGRAM_SOURCE,file_number)');
          sql.Add('values ('+dm.ADO60rkey.AsString+',1,''更改合同号FOB'',');
          sql.Add(''''+old_fob+''','''+form10.Edit5.Text+''','+rkey73+',');
          sql.add('getdate(),305,'''+form10.Edit1.Text+''')');
          ExecSQL;
        end;
      end;
      if form10.Edit4.Text<>old_REFERENCE_NUMBER then
      begin
        with DM.ADOQuery1 do
        begin
          Close;
          SQL.Clear;
          SQL.Add('update data0060 set REFERENCE_NUMBER='''+trim(Form10.Edit4.Text)+'''');
          SQL.Add('where rkey='+dm.ADO60rkey.AsString);
          ExecSQL;
        end;

        with dm.ADOQuery1 do
        begin
          close;                  //记录客户订单更改情况(日志文件)
          sql.Clear;
          sql.Add('insert into data0318 (SALES_ORDER_PTR,TRANS_TYPE,TRANS_DESCRIPTION,');
          sql.Add('FROM_STRING,TO_STRING,USER_PTR,TRANS_DATE,PROGRAM_SOURCE,file_number)');
          sql.Add('values ('+dm.ADO60rkey.AsString+',1,''更改参考附注'',');
          sql.Add(''''+old_REFERENCE_NUMBER+''','''+form10.Edit4.Text+''','+rkey73+',');
          sql.add('getdate(),305,'''+form10.Edit1.Text+''')');
          ExecSQL;
        end;
      end;
  //20150709客户交期修改-------
      if (Trim(Form10.Edit13.Text)<>old_ORIG_REQUEST_DATE) then
      begin
        with DM.ADOQuery1 do
        begin
          Close;
          SQL.Clear;
          SQL.Add('update data0060 set ORIG_REQUEST_DATE='''+trim(Form10.Edit13.Text)+'''');
          SQL.Add('where rkey='+dm.ADO60rkey.AsString);
          ExecSQL;
        end;

        with dm.ADOQuery1 do
        begin
          close;                  //记录客户订单更改情况(日志文件)
          sql.Clear;
          sql.Add('insert into data0318 (SALES_ORDER_PTR,TRANS_TYPE,TRANS_DESCRIPTION,');
          sql.Add('FROM_STRING,TO_STRING,USER_PTR,TRANS_DATE,PROGRAM_SOURCE,file_number)');
          sql.Add('values ('+dm.ADO60rkey.AsString+',1,''更改客户交期'',');
          sql.Add(''''+old_ORIG_REQUEST_DATE+''','''+form10.Edit13.Text+''','+rkey73+',');
          sql.add('getdate(),305,'''+form10.Edit1.Text+''')');
          ExecSQL;
        end;
      end;

      DM.ADOConnection1.CommitTrans;
      ShowMessage('更新成功');
      BitBtn2Click(sender);
    except
     on E: Exception do
      begin
       dm.ADOConnection1.RollbackTrans;
       messagedlg(E.Message,mterror,[mbcancel],0);
      end;
    end;
//    n25click(sender);//刷新数据
  end;
  form10.Free;
end;

procedure TForm1.N27Click(Sender: TObject);
var
 i,n:byte;
 total_amount,amount:double;
 invoice_number:string;
 sName:string;
begin
  if (strtoint(vprev)=1) or (strtoint(vprev)=3) then
  begin
    showmessage('对不起您只有该程序的只读权限');
    exit;
  end;
 //20161219tang修改提交之前查看订单版本是否无效，并提示新版本---
  dm.ADOQuery4.Close;
  dm.ADOQuery4.SQL.Text:='select ONHOLD_SALES_FLAG from data0025 where rkey='+inttostr(dm.ADO60CUST_PART_PTR.Value);
  dm.ADOQuery4.Open;
  if (dm.ADOQuery4.FieldByName('ONHOLD_SALES_FLAG').AsInteger=1) then
  begin
    dm.Ado273_25.Close;
    dm.Ado273_25.Parameters.ParamByName('Rkey25').Value:=dm.ADO60CUST_PART_PTR.Value;
    dm.Ado273_25.Open;
    if not dm.Ado273_25.IsEmpty then
    begin
      sName:= dm.Ado273_25.FieldByName('MANU_PART_NUMBER').AsString;
    end else
    begin
      sName:= '空';
    end;
    if messagedlg('当前销售单已暂停销售，升级的本厂编号为【'+sName+'】，是否继续?',mtConFirmation,[mbYes,mbNo],0)= mrNo then Exit;
  end;
//end 20161219tang
  with dm.ADOQuery1 do
  begin
    close;
    sql.Text:='select rkey,invoice_number from data0112 '+
    'where sales_order_ptr='+dm.ADO60rkey.AsString +
    ' and invoice_type=2 and invoice_status<>3';
    Open;
    invoice_number:=fieldbyname('invoice_number').AsString;
  end;
  if not dm.ADOQuery1.IsEmpty then
    ShowMsg('销售订单已生成工具用发票,不能修改请与财务联系!'+invoice_number,1)
  else
  try
    form11:=tform11.Create(application);
    if form11.ShowModal=mrok then
    begin
      with dm.ADOquery2 do
      begin
        active:=false;
        sql.Clear;
        sql.Add('select * from data0062 where');
        sql.Add('so_ptr='+dm.ADO60rkey.AsString);
        active := true;
      end;
      while not dm.ADOquery2.Eof do
      begin
        with dm.ADOquery2 do
        begin
          for n:=0 to form11.StringGrid1.RowCount-1 do
          begin
           if ((FieldByName('ADDL_CAT_PTR').AsString = aStr[5,n]) and (
              (aStr[1,n]<>formatfloat('0.000',FieldValues['amount'])) or
              (aStr[2,n]<>formatfloat('0.000',FieldValues['free_amount'])) or
              (aStr[3,n]<>formatfloat('0.000',FieldValues['costfree_amount'])) or
              (aStr[4,n]<>FieldByName('TAX_FLAG').AsString))) then
           begin
             ShowMsg('数据出现异常,可能是多人操作引起，保存失败！请重试',1);  //检查数据库中的数据与更改前是否一致
             Active:= False;
             Abort;
           end;
          end;
          Next;
        end;
      end;
      dm.ADOConnection1.BeginTrans;
      try
        dm.ADOquery2.First;
        while not dm.ADOquery2.Eof do dm.ADOquery2.Delete; //首先将其全部删除
        total_amount:=0;
        for i:=1 to form11.StringGrid1.rowcount-2 do
        if (strtofloat(form11.StringGrid1.Cells[1,i])>0) or
          (strtofloat(form11.StringGrid1.Cells[2,i])>0) or
          (strtofloat(form11.StringGrid1.Cells[3,i])>0) then
        begin
          dm.ADOquery2.Append;
          dm.ADOquery2.Fieldvalues['so_ptr'] := dm.ADO60rkey.Value;
          dm.ADOquery2.FieldByName('addl_cat_ptr').asstring :=form11.StringGrid1.Cells[5,i];
          dm.ADOQuery2.FieldByName('TAX_flag').AsString := form11.StringGrid1.Cells[4,i];
          dm.ADOquery2.FieldByName('free_amount').asstring := form11.StringGrid1.Cells[2,i];
          dm.ADOquery2.FieldByName('amount').asstring := form11.StringGrid1.Cells[1,i];
          dm.ADOquery2.FieldByName('costfree_amount').asstring := form11.StringGrid1.Cells[3,i];

          total_amount:=total_amount+dm.ADOQuery2.FieldValues['amount'];
          dm.ADOquery2.post;
        end;
        amount:=dm.ADO60TOTAL_ADD_L_PRICE.Value;
        dm.ADO60.Edit;
        dm.ADO60TOTAL_ADD_L_PRICE.Value := total_amount;
        dm.ADO60.Post;
        if amount<>total_amount then
        with dm.ADOQuery1 do
        begin
          close;                  //记录销售订单更改(日志文件)
          sql.Clear;
          sql.Add('insert into data0318 (SALES_ORDER_PTR,TRANS_TYPE,TRANS_DESCRIPTION,');
          sql.Add('FROM_string,TO_string,USER_PTR,TRANS_DATE,PROGRAM_SOURCE)');
          sql.Add('values ('+dm.ADO60rkey.AsString+',12,''更改销售订单工具费用'',');
          sql.Add(''''+floattostr(amount)+''','''+floattostr(total_amount)+''','+rkey73+',');
          sql.add('getdate(),305)');
          ExecSQL;
        end;
        dm.ADOConnection1.CommitTrans;
        showmessage('更改成功！');
        BitBtn2Click(sender);
      except
        on E: Exception do
        begin
          dm.ADOConnection1.RollbackTrans;
          messagedlg(E.Message,mterror,[mbcancel],0);
        end;
      end;
    end;
  finally
    form11.Free;
  end;
end;

procedure TForm1.N28Click(Sender: TObject);
var
 str:string;
begin
 str:='';
 if inputquery('销售订单查找','请输入要查找的客户型号:            ',str) then
  if trim(str)<>'' then
  begin
   dm.ADO60.Close;
   dm.ADO60.SQL.Delete(dm.ADO60.SQL.Count-2);
   dm.ADO60.SQL.Insert(dm.ADO60.SQL.Count-1,'and data0025.MANU_PART_DESC like ''%'+str+'%''');
   dm.ADO60.Open;
  end;
end;

function TForm1.cacl_deficiency(rkey10: integer;
  nowAmount: currency): currency;
var
  V_defi:currency;
begin
  with dm.ADOQuery1 do
  begin
    close;
    sql.Clear;
    sql.Add('SELECT SUM((INVOICE_TOTAL - amount_paid - CASH_DISC)*EXCHANGE_RATE)');
    sql.Add('AS total_amount FROM dbo.Data0112');
    sql.Add('where customer_ptr='+inttostr(rkey10));
    sql.Add('and invoice_status=1');
    sql.Add('group by customer_ptr');
    open;
    v_defi:= FieldByName('total_amount').AsCurrency;
  end;  //计算用户所开出发票的所欠金额

  with dm.ADOQuery1 do
  begin
    close;
    sql.Clear;
    sql.Add('select Sum(t60.PARTS_ALLOC*t64.QUAN_SHIPPED*(1+t60.RUSH_CHARGE*0.01)/t60.EXCH_RATE) as total_amount');
    sql.Add('from data0060 t60 inner join data0064 t64 on t64.SO_PTR = t60.RKEY');
    sql.Add('left join data0439 t439 on t64.packing_list_ptr = t439.RKEY');
    sql.Add('WHERE ((t64.packing_list_ptr is null) OR (t439.invoice_ptr is null))');
    sql.Add('and t60.STATUS in (1,2,4)');
    sql.Add('and t60.CUSTOMER_PTR = '+inttostr(rkey10));
    open;
    v_defi:= v_defi+FieldByName('total_amount').AsCurrency;
  end;  //已指派未生成账龄 Add

  with dm.ADOQuery1 do
  begin
    close;
    sql.Clear;
    sql.Add('select Sum(t60.PARTS_ALLOC*(t60.PARTS_ORDERED-t60.PARTS_SHIPPED)*(1+t60.RUSH_CHARGE*0.01)/t60.EXCH_RATE)');
    sql.Add('as total_amount from data0060 t60');
    //sql.Add('where not exists(select 1 from data0064 t64 where t64.SO_PTR = t60.RKEY)');
    sql.Add('Where t60.STATUS in (1,2,4,6)');
    sql.Add('and t60.CUSTOMER_PTR = '+inttostr(rkey10));
    open;
    v_defi:= v_defi+FieldByName('total_amount').AsCurrency;
  end;  //未指派 Add

  with dm.ADOQuery1 do
  begin
    close;
    sql.Clear;
    sql.Add('select Sum((TOTAL_ADD_L_PRICE-INVD_ADD_L_PRICE)*(1+RUSH_CHARGE*0.01)/EXCH_RATE)');
    sql.Add('as total_amount from data0060');
    sql.Add('where STATUS in (1,2,4,6)');
    sql.Add('and TOTAL_ADD_L_PRICE <> 0');
    sql.Add('and INVD_ADD_L_PRICE = 0');
    sql.Add('and CUSTOMER_PTR = '+inttostr(rkey10));
    open;
    v_defi:= v_defi+FieldByName('total_amount').AsCurrency;
  end;  //工具费用 Add

  with dm.ADOQuery1 do
  begin
    close;
    sql.Clear;
    sql.Add('SELECT SUM(AVL_AMT * EX_RATE)');
    sql.Add('AS total_amount FROM dbo.Data0116');
    sql.Add('where CUST_PTR='+inttostr(rkey10));
    sql.Add('and memo_status=1');
    sql.Add('group by CUST_PTR');
    open;
    v_defi:= v_defi-FieldByName('total_amount').AsCurrency;
  end;  //计算用户贷项备忘

  with dm.ADOQuery1 do
  begin
    close;
    sql.Clear;
    sql.Add('select Sum(t60.PARTS_ALLOC*t98.QTY_RECD*(1+t60.RUSH_CHARGE*0.01)/t60.EXCH_RATE)');
    sql.Add('as total_amount from data0098 t98, data0060 t60');
    sql.Add('where t98.SO_PTR = t60.RKEY');
    sql.Add('and t98.srce_ptr is null');
    sql.Add('and t98.CUSTOMER_PTR = '+inttostr(rkey10));
    open;
    v_defi:= v_defi-FieldByName('total_amount').AsCurrency;
  end;  //已退货未生成贷项备忘 Add

  result:= v_defi + nowAmount;  //本订单总额Add
end;

procedure TForm1.BitBtn4Click(Sender: TObject);
begin
  PopupMenu2.Popup(mouse.CursorPos.x,mouse.CursorPos.y);
end;

procedure TForm1.Edit1Change(Sender: TObject);
begin
  if Trim(Edit1.Text)<>'' then
    DM.ADO60.Filter:=preColumn.FieldName+' like ''%'+ Trim(Edit1.Text)+'%'''
  else
    DM.ADO60.Filter:='';
end;

procedure TForm1.DBGrid1TitleClick(Column: TColumn);
begin
  if DM.ADO60.Sort<>Column.FieldName then
  begin
    dm.ADO60.Sort:=Column.FieldName;
  end;

  if (PreColumn.FieldName<>column.FieldName)  and
     (column.Field.DataType in [ftString,ftWideString])
  then
   begin
    label1.Caption:=column.Title.Caption;
    edit1.SetFocus;
    PreColumn.Title.Color := clBtnFace;
    Column.Title.Color := clred;
    PreColumn := column;
   end
  else
   edit1.SetFocus;
end;

procedure TForm1.FormShow(Sender: TObject);
var i:Integer;
    item:TMenuItem;
begin
  if FrmQuery=nil then  FrmQuery:=TFrmQuery.Create(Application);
  strSQLTxt:=DM.ADO60.SQL.Text;

  field_name := DBGrid1.Columns[0].FieldName;
  PreColumn := DBGrid1.Columns[0];
  DBGrid1.Columns[0].Title.Color := clred ;

  for i := 1 to DBGrid1.Columns.Count do
  begin
   item := TmenuItem.Create(self) ;
   item.Caption := DBGrid1.Columns[i - 1].Title.Caption ;
   if DBGrid1.Columns[i - 1].Visible then
    item.Checked := true ;
   item.OnClick := item_click ;
   PopupMenu2.Items.Add(item) ;
  end;
end;

procedure TForm1.BitBtn5Click(Sender: TObject);
begin
  Close;
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
var
    i:integer;
    Sqlstr,sort:string;
begin

    FrmQuery.DateTimePicker3.Date:=dm.ADO60.Parameters.ParamValues['dtpk1'];
    FrmQuery.DateTimePicker5.Date:=dm.ADO60.Parameters.ParamValues['dtpk2']-1;

  Sqlstr:='';
  if FrmQuery.ShowModal=mrok then
  begin
    screen.Cursor:=crHourGlass;
    for i:=1 to FrmQuery.SGrid1.RowCount-2 do
    if FrmQuery.sgrid1.Cells[2,i]<> '' then
     Sqlstr:=sqlstr+FrmQuery.sgrid1.Cells[2,i]+#13;
    try
      DM.ADO60.DisableControls;
      sort:=dm.ADO60.Sort;
      dm.ADO60.Close;
      dm.ADO60.SQL.Clear;
      dm.ADO60.SQL.Text:=strSQLTxt+sqlstr;
     // dm.ADO60.SQL.Delete(dm.ADO60.SQL.Count-2);
     // dm.ADO60.SQL.Insert(dm.ADO60.SQL.Count-1,Sqlstr);
     dm.ADO60.Parameters[0].Value:=FrmQuery.DateTimePicker3.Date;

      //FormatDateTime('yyyy-MM-dd',FrmQuery.DateTimePicker3.Date)+' 0:00:00';
     dm.ADO60.Parameters[1].Value:=FrmQuery.DateTimePicker5.Date+1;
      //FormatDateTime('yyyy-MM-dd',FrmQuery.DateTimePicker5.Date)+' 23:59:59';;
      DM.ADO60.Prepared;
      dm.ADO60.Open;
      dm.ADO60.Sort:=sort;
    finally
      DM.ADO60.EnableControls;
    end;
    screen.Cursor:=crDefault;
  end;
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
var
  i:integer;
  sort:string;
begin

  i := DM.ADO60rkey.AsInteger ;
  sort:= dm.ADO60.Sort;
  DM.ADO60.Close;
  DM.ADO60.Open;
  dm.ADO60.Sort:= sort;
  if i>0 then
  DM.ADO60.Locate('rkey',i,[]);

end;

function TForm1.return_min_sysdate(rkey60: Integer): TDateTime;
begin
 with dm.ADOQuery1 do
 begin
  Close;
  SQL.Text:='select min(sys_date) as mindate from data0416 where so_ptr='+inttostr(rkey60);
  open;
  if not fieldbyname('mindate').IsNull then
   result:=fieldvalues['mindate']      //查找最早的外发订单入库日期
  else
   result:=date()+1;
 end;

end;

function TForm1.return_max_444: TDateTime; //返回最大的成本截数日期
begin
 with dm.ADOQuery1 do
 begin
  close;
  sql.Text:='select max(tdate) as maxdate from data0444 ';
  open;
  if not fieldbyname('maxdate').IsNull then
   result:=fieldvalues['maxdate']
  else
   result:=date()-3650;
 end;
end;

procedure TForm1.N1Click(Sender: TObject);
begin
   if not dm.ADO60.IsEmpty then
  begin
    form2:=tform2.Create(application);

    Form2.Edt1.Text:=dm.ADO60SALES_ORDER.Value; //
    Form2.lbl3.caption:=IntToStr(dm.ADO60RKEY.Value); //
    form2.mmo1.Text:=DM.ADO60RemarkSO.Value;
    Form2.lbl3.Hide;
    form2.ShowModal;

   // dm.ADOQuery3.Close;
    form2.Free;
  end;
end;

end.
