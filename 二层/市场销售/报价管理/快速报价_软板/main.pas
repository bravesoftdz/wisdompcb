unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, ExtCtrls, Menus, StdCtrls, Buttons;

type
  TForm1 = class(TForm)
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N61: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N6: TMenuItem;
    N62: TMenuItem;
    N9: TMenuItem;
    BitBtn1: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    Edit1: TEdit;
    Label1: TLabel;
    PopupMenu2: TPopupMenu;
    N10: TMenuItem;
    BitBtn6: TBitBtn;
    N11: TMenuItem;
    N12: TMenuItem;
    N13: TMenuItem;
    PopupMenu3: TPopupMenu;
    N14: TMenuItem;
    N15: TMenuItem;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure FormShow(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure N1Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure N9Click(Sender: TObject);
    procedure N10Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure N11Click(Sender: TObject);
    procedure N12Click(Sender: TObject);
    procedure N14Click(Sender: TObject);
    procedure N15Click(Sender: TObject);
    procedure N13Click(Sender: TObject);
  private
    { Private declarations }
   PreColumn: TColumn;
   field_name,sql_text:string;
   OldGridWnd : TWndMethod;
   procedure NewGridWnd (var Message : TMessage);

   procedure item_click(sender:TObject);
   procedure get_authdate(rkey264:integer);
   function find_salesorder(rkey85:integer):boolean;
   function find_invtpricechange(rkey85,quote_ttype:integer):boolean;
  public
    { Public declarations }
   procedure print_report(rkey85:integer);
  end;

var
  Form1: TForm1;

implementation

uses damo,common, term, quote_detail, auth_info, quote_overdue,
  quote_report, DB;

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
  if not app_init_2(dm.ADOConnection1) then
  begin
   ShowMsg('程序启动失败，请与系统管理员联系！','提示',1);
   application.Terminate;
   exit;
  end;

//   dm.ADOConnection1.Open;
//  rkey73:= '1';
//  user_ptr := '3';
//  vprev := '4';

 self.Caption:=application.title;
 DateSeparator := '-';
 ShortDateFormat := 'yyyy-mm-dd';

 OldGridWnd := DBGrid1.WindowProc;
 DBGrid1.WindowProc := NewGridWnd;
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

function TForm1.find_salesorder(rkey85: integer): boolean;
begin
with dm.adoquery1 do
begin
 close;
 sql.Text:='select rkey from data0060 where qte_ptr='+inttostr(rkey85);
 open;
 if isempty then
  result:=false
 else
  result:=true;
end;

end;

procedure TForm1.get_authdate(rkey264: integer);
var
 rkey14:integer;
begin
with dm.ADOQuery1 do
begin
 close;
 sql.Text:='delete from data0274 where qte_ptr='+dm.ADS85rkey.AsString;
 execsql;
end;

 with dm.ADOQuery1 do
  begin
   close;
   sql.Clear;
   sql.Add('select * from data0014 where rkey is null');
   open;
   append;
   fieldvalues['MESSAGE'] := '有一张报价单需要通过您的审批,报价人员:'+
                             dm.ADS85EMPLOYEE_NAME.Value+' 报价编号:'+
                             dm.ADS85TNUMBER.Value+
                             ' 提交日期:'+datetimetostr(getsystem_date(dm.adoquery3,0));
   fieldvalues['whosend']:= strtoint(rkey73);
   post;
   rkey14:=fieldvalues['rkey'];
  end;

with dm.ADOQuery1 do
 begin
  close;
  sql.Clear;
  sql.Add('SELECT USER_PTR FROM Data0265');
  sql.Add('WHERE (lower_limit >= :total1)');
  sql.Add('and (upper_limit <= :total2)');
  sql.Add('and (AUTH_GROUP_PTR='+inttostr(rkey264)+')');
  sql.Add('ORDER BY rkey');
  Parameters.ParamValues['total1']:=dm.ADS85rate_margin.Value;
  Parameters.ParamValues['total2']:=dm.ADS85rate_margin.Value;
  open;
 end;
with dm.ADOQuery2 do
 begin
  close;
  sql.Text:='select qte_ptr,user_ptr,auth_flag,ranking from data0274'+#13+
             'where qte_ptr='+dm.ADS85rkey.AsString;
  open;
 end;
while not dm.ADOQuery1.Eof do
begin
 dm.ADOQuery2.Append;
 dm.ADOQuery2.FieldValues['qte_ptr']:=dm.ADS85rkey.Value;
 dm.ADOQuery2.FieldValues['user_ptr']:=dm.ADOQuery1.FieldValues['USER_PTR'];
 dm.ADOQuery2.FieldValues['ranking']:=dm.ADOQuery1.RecNo;
 if dm.ADOQuery1.RecNo=1 then
  dm.ADOQuery2.FieldValues['auth_flag']:='Y'
 else
  dm.ADOQuery2.FieldValues['auth_flag']:='N';
 dm.ADOQuery2.Post;
   with dm.ADOQuery3 do
    begin
     close;
     sql.Clear;
     sql.Add('select * from data0314 where rkey is null');
     open;
     append;
     fieldvalues['emp_ptr']:=dm.ADOQuery2.FieldValues['user_ptr'];
     fieldvalues['d14_ptr']:= rkey14;
     post;
    end;
 dm.ADOQuery1.Next;
end;
end;

function TForm1.find_invtpricechange(rkey85,
  quote_ttype: integer): boolean;
begin
if quote_ttype=0 then //内销报价单
 with dm.ADOQuery1 do
  begin
   close;
   sql.Clear;
   sql.Add('SELECT Data0253.RKEY');
   sql.Add('FROM Data0028 INNER JOIN');
   sql.Add('Data0253 ON Data0028.RKEY = Data0253.d0028_ptr ');
   sql.Add('where Data0028.qte_price1 > Data0253.d0028_price and');
   sql.Add(' data0253.quote_ptr='+inttostr(rkey85));
   open;
  end
else              //转厂报价单
 with dm.ADOQuery1 do
  begin
   close;
   sql.Clear;
   sql.Add('SELECT Data0253.RKEY');
   sql.Add('FROM Data0028 INNER JOIN');
   sql.Add('Data0253 ON Data0028.RKEY = Data0253.d0028_ptr ');
   sql.Add('where Data0028.qte_price2 > Data0253.d0028_price and');
   sql.Add(' data0253.quote_ptr='+inttostr(rkey85));
   open;
  end;
 if not dm.ADOQuery1.IsEmpty then
  result:=true
 else
  result:=false;
end;

procedure TForm1.print_report(rkey85: integer);
var
 i:word;
 s:string;
begin
 form_report:=tform_report.Create(application);
 with form_report do
 begin
  ADS85.Close;
  ads85.Parameters[0].Value:=rkey85;
  ads85.Open;
  ads511.Open;
  ads253.Open;
  ads431.open;
  ads432.open;
  ads432t.Open;
  ads061.Open;
  ADS8501.Open;

  form_report.ppReport1.Reset;
  {form_report.ppReport1.Template.FileName :=
    {stringReplace(GetCurrentDir,'','\',[rfReplaceAll])+   
      'D:\vss文档\原程序代码\市场销售\报价管理\新快速报价_软板\fastquote_report_FPC.rtm';  }
   form_report.ppReport1.Template.FileName :=
    stringReplace(GetCurrentDir,'EXEC','NIERP\REPORT\',[rfReplaceAll])+
      'fastquote_report_FPC.rtm';  

  form_report.ppReport1.Template.LoadFromFile;
  ppImage1.Picture.Assign(Load_JPG_Pic_From_DB(ads511sheet_BMP));
  s:='                    ';
 for i:=1 to ads431.RecordCount do
  begin
   if odd(ads431.RecordCount) then
    if i<=(ads431.RecordCount+1)/2 then
    begin
     ppMemo1.Lines.Add(trim(ADS431PARAMETER_DESC.Value)+':'+
     copy(s,1,20-length(trim(ADS431PARAMETER_DESC.Value)))+
     trim(ADS431UNIT_VALUE.Value));
    end
    else
    begin
     ppMemo2.Lines.Add(trim(ADS431PARAMETER_DESC.Value)+':'+
     copy(s,1,20-length(trim(ADS431PARAMETER_DESC.Value)))+
     trim(ADS431UNIT_VALUE.Value));
    end
   else
    if i<=(ads431.RecordCount)/2 then
    begin
     ppMemo1.Lines.Add(trim(ADS431PARAMETER_DESC.Value)+':'+
     copy(s,1,20-length(trim(ADS431PARAMETER_DESC.Value)))+
     trim(ADS431UNIT_VALUE.Value));
    end
    else
    begin
     ppMemo2.Lines.Add(trim(ADS431PARAMETER_DESC.Value)+':'+
     copy(s,1,20-length(trim(ADS431PARAMETER_DESC.Value)))+
     trim(ADS431UNIT_VALUE.Value));
    end;
   ads431.Next;
  end;
 end;
 form_report.ppReport1.Print;
 form_report.Free;
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
application.Terminate;
end;

procedure TForm1.BitBtn3Click(Sender: TObject);
var
 rkey:integer;
begin
rkey:=dm.ads85rKEY.Value;
dm.ADS85.Close;
dm.ADS85.Open;
if rkey>0 then dm.ADS85.Locate('rkey',rkey,[]);
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
begin
Export_dbGrid_to_Excel(dbgrid1,self.Caption)
end;

procedure TForm1.Edit1Change(Sender: TObject);
begin
 if trim(Edit1.text)<>'' then
  dm.ADs85.Filter := field_name+' like ''%'+trim(edit1.text)+'%'''
 else
  dm.ADs85.filter := '';
end;

procedure TForm1.DBGrid1TitleClick(Column: TColumn);
begin
if (column.FieldName<>dm.ADs85.IndexFieldNames) then
 dm.ADs85.IndexFieldNames:=column.FieldName;

if (column.ReadOnly) and (field_name<>column.FieldName) then
 begin
  label1.Caption:=column.Title.Caption;
  self.field_name:=column.FieldName;
  edit1.SetFocus;
  PreColumn.Title.Color := clBtnFace;
  Column.Title.Color := clred;
  PreColumn := column;
 end
else
 edit1.SetFocus;
end;

procedure tform1.item_click(sender:TObject);
var
 i:byte;
begin
(sender as tmenuItem).Checked := not ((sender as tmenuItem).Checked);
if (sender as tmenuItem).Checked then
 begin
  for i:=0 to dbgrid1.FieldCount-1 do
  if dbgrid1.Columns[i].Title.Caption=(sender as tmenuItem).Caption then
   begin
    dbgrid1.Columns[i].Visible:=true;
    break;
   end;
 end
else
 begin
  for i:=0 to dbgrid1.FieldCount-1 do
  if dbgrid1.Columns[i].Title.Caption=(sender as tmenuItem).Caption then
   begin
    dbgrid1.Columns[i].Visible:=false;
    break;
   end;
 end;
end;

procedure TForm1.FormShow(Sender: TObject);
var i:byte;
    item:TMenuItem;
begin
   if dm.ADOConnection1.Connected then
   begin

        with dm.adoquery3 do
        begin
         close;
         sql.Clear;
         sql.Add('select QTE_CONTROL1 from data0192');
         open;
         dm.qte_type := fieldbyname('QTE_CONTROL1').AsInteger; //基价计算方式
        end;
        field_name := DBGrid1.Columns[0].FieldName;
        PreColumn := DBGrid1.Columns[0];
        application.CreateForm(tform_overdue,form_overdue);
        with form_overdue.ADS85 do
        begin
         close;
         Parameters[0].Value:=getsystem_date(dm.adoquery1,1);
         open;
        end;
        if not form_overdue.ADS85.IsEmpty then form_overdue.ShowModal;
        form_overdue.ADS85.Close;
        form_overdue.Free;

        dm.ADS85.Close;

    if strtoint(vprev) in [1,3] then
    begin
     dm.ADS85.CommandText:=dm.ADS85.CommandText+ 'and data0085.CUST_PTR in (select d10.rkey from data0010 d10 ' +
      ' inner join data0100 d100 on d10.rkey = d100.CUSTOMER_PTR ' +
      ' where d100.CSI_PTR  = ' + rkey73 + ') ';
    end;

    //    if strtoint(vprev) < 3 then
    //          dm.ADS85.CommandText:=dm.ADS85.CommandText+'and Data0085.QBY_EMPL_PTR='+common.user_ptr+#13;

        dm.ADS85.Parameters.ParamByName('dtpk1').Value:=getsystem_date(dm.adoquery1,1)-3;
        dm.ADS85.Parameters.ParamByName('dtpk2').Value:=getsystem_date(dm.adoquery1,1);
        dm.ADS85.Prepared;
        dm.ADS85.Open;
        sql_text := dm.ADS85.CommandText;

        for i:=1 to dbgrid1.FieldCount do
        begin
             item:=TmenuItem.Create(self);
             item.Caption:=dbgrid1.Columns[i-1].Title.Caption;
             if dbgrid1.Columns[i-1].Visible then
              item.Checked:=true;
             item.OnClick:=item_click;
             self.PopupMenu2.Items.Add(item);
        end;
   end;
end;

procedure TForm1.BitBtn5Click(Sender: TObject);
begin
  popupmenu2.Popup(mouse.CursorPos.x,mouse.CursorPos.y);
end;

procedure TForm1.BitBtn4Click(Sender: TObject);
var i:byte;
begin
 form_condition.dtpk1.Date:=dm.ADs85.Parameters.ParamValues['dtpk1'];
 form_condition.dtpk2.Date:=dm.ADs85.Parameters.ParamValues['dtpk2'];
 if form_condition.ShowModal=mrok then
 begin
  dm.ADs85.Close;
  dm.ADs85.CommandText:=sql_text;
  for i:=1 to form_condition.SGrid1.RowCount-2 do
   dm.ADs85.CommandText:=dm.ADs85.CommandText+
   form_condition.SGrid1.Cells[2,i]+#13;
  dm.ADs85.Parameters.ParamByName('dtpk1').Value:=form_condition.dtpk1.Date;
  dm.ADs85.Parameters.ParamByName('dtpk2').Value:=form_condition.dtpk2.Date;
  dm.ADS85.Prepared;
  dm.ADs85.Open;
 end;
end;

procedure TForm1.DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
 if (chr(key)='V') and (ssalt in shift) then
  showmessage(dm.ADs85.CommandText);
end;

procedure TForm1.N1Click(Sender: TObject);
begin
 if (strtoint(vprev)=1) or (strtoint(vprev)=3) then
  messagedlg('对不起!您没有该程序的可写权限',mtinformation,[mbok],0)
 else
 try
  form2:=tform2.Create(application);
  dm.ADSA85.Close;
  dm.ADSa85.Parameters[0].Value:=null;
  dm.ADSa85.Open;
  dm.ADSa85.Append;
  dm.ADSA85QTE_DATE.Value:=getsystem_date(dm.adoquery1,1);
  dm.ADSA85EXPIRATION_DATE.Value:=dm.ADSA85QTE_DATE.Value+60;
  dm.ADSA85QUOTE_TYPE.Value:=0;   //内销
  dm.ADSA85TTYPE.Value:=0;       //快速报价
  dm.ADSA85ttype2.Value:=0;      //类型0,新单
  dm.ADSA85QTE_UNIT_PTR.Value:=1; //按PCS报价
  dm.ADSA85CUST_QTE_FACTOR.Value:=0;//额外加价率%
  dm.ADSA85SALES_DISCOUNT.Value:=0; //销售折扣%
  dm.ADSA85vatax.Value:=0;          //增值税率
  dm.ADSA85QBY_EMPL_PTR.AsString:=common.user_ptr; //报价人员
  dm.ADSA85AUDITED_STATUS.Value:=0;  //状态未提交
  dm.ADSA85QTE_CONTROL5.Value:='N';  //没有计算
  dm.ADO04.Close;
  dm.ADO04.Open;

  if dm.ADO04SEED_FLAG.Value<>1 then
  begin
   dm.adsa85tnumber.value:=dm.ADO04SEED_VALUE.Value;
   if dm.ADO04SEED_FLAG.Value=4 then
   form2.DBEdit1.ReadOnly:=true;
  end;
  if form2.ShowModal=mrok then
  begin
   
   dm.ADS85.Close;
   dm.ADS85.Open;
   dm.ADS85.Locate('rkey',dm.ADSA85RKEY.Value,[]);
   dm.ADSA85.Close;
   dm.ads432.Close;
   dm.ado8501.Close;
   dm.ads431.Close;
   dm.ads511.Close;
   dm.ads278.Close;

  end
  else begin
   dm.ADSA85.Close;
   dm.ads432.Close;
   dm.ado8501.Close;
   dm.ads431.Close;
   dm.ads511.Close;
   dm.ads278.Close;
  end;

 finally
  form2.Free;
 end; //try end
end;

procedure TForm1.N3Click(Sender: TObject);
begin
if (strtoint(vprev)=1) or (strtoint(vprev)=3) then
 messagedlg('对不起!您没有该程序的可写权限',mtinformation,[mbok],0)
else
begin
dm.ADSA85.Close;
dm.ADSa85.Parameters[0].Value:=dm.ADS85rkey.Value;
dm.ADSa85.Open;
if dm.ADSA85AUDITED_STATUS.Value=dm.ADS85AUDITED_STATUS.Value then
try
form2:=tform2.Create(application);
dm.ADSa85.Edit;
dm.ADSA85AUDITED_STATUS.Value:=0;

  dm.ADO04.Close;
  dm.ADO04.Open;
  if dm.ADO04SEED_FLAG.Value=4 then
   form2.DBEdit1.ReadOnly:=true;

if form2.ShowModal=mrok then
 begin

  dm.ADS85.Close;
  dm.ADS85.Open;
  dm.ADS85.Locate('rkey',dm.ADSA85RKEY.Value,[]);
  dm.ADSA85.Close;
  DM.ads432.Close;
  dm.ads431.Close;
  dm.ads511.Close;
  dm.ads278.Close;
 end
else
 begin
  dm.ADSA85.Close;
  DM.ads432.Close;
  dm.ads431.Close;
  dm.ads511.Close;
  dm.ads278.Close;
 end;
finally
 form2.Free;
end
else
 messagedlg('状态发生变生不能编辑',mtinformation,[mbcancel],0);
end;
end;

procedure TForm1.N4Click(Sender: TObject);
begin
try
form2:=tform2.Create(application);
 dm.ADSA85.Close;
 dm.ADSa85.Parameters[0].Value:=dm.ADS85rkey.Value;
 dm.ADSa85.Open;
 with form2 do
  begin
   bitbtn1.Enabled:=false;
   dbedit1.ReadOnly:=true;
   dbedit2.Enabled:=false;
   dbedit3.Enabled:=false;
   dbedit4.Enabled:=false;
   dbedit5.Enabled:=false;
   dbedit6.Enabled:=false;
   dbedit7.Enabled:=false;
   dbedit8.Enabled:=false;
   dbedit9.Enabled:=false;
   dbedit10.Enabled:=false;
   dbedit11.Enabled:=false;
   dbedit12.Enabled:=false;
   dbedit13.Enabled:=false;
   dbedit15.Enabled:=false;
   dbedit16.Enabled:=false;
   dbedit31.Enabled:=false;
   dbedit32.Enabled:=false;
   dbedit35.Enabled:=false;
   DBEdit37.Enabled:=false;
   DBEdit38.Enabled:=false;   
   dbmemo1.Enabled:=false;
   dbradiogroup1.Enabled:=false;
   edit1.Enabled:=false;
   edit2.Enabled:=false;
   edit3.Enabled:=false;
   edit4.Enabled:=false;
   edit5.Enabled:=false;
   edit6.Enabled:=false;
   combobox3.Enabled:=false;
   bitbtn3.Enabled:=false;
   bitbtn4.Enabled:=false;
   bitbtn5.Enabled:=false;
   bitbtn7.Enabled:=false;
   bitbtn8.Enabled:=false;
   button1.Enabled:=false;
   speedbutton1.Enabled:=false;
   speedbutton2.Enabled:=false;
   speedbutton3.Enabled:=false;
   dbmemo2.Enabled:=false;
   stringgrid1.Enabled:=false;
   checkbox1.Visible:=false;
   bitbtn13.Visible:=true;       //检查时可以打印
  end;

 form2.ShowModal;
 dm.ADSA85.Close;
 DM.ads432.Close;
 dm.ads431.Close;
 dm.ads511.Close;
 dm.ads278.Close; 
finally
 form2.Free;
end;
end;

procedure TForm1.N5Click(Sender: TObject);
begin
if (strtoint(vprev)=1) or (strtoint(vprev)=3) then
 messagedlg('对不起!您没有该程序的可写权限',mtinformation,[mbok],0)
else
begin
 dm.ADSA85.Close;
 dm.ADSa85.Parameters[0].Value:=dm.ADS85rkey.Value;
 dm.ADSa85.Open;
 if dm.ADSA85QTE_CONTROL5.Value='N' then
  begin
   showmsg('报价单没有完成计算暂时不能提交!',1);
   dm.ADSA85.Close;
  end
 else
 if dm.ADSA85AUDITED_STATUS.Value=dm.ADS85AUDITED_STATUS.Value then
  try
   dm.ADOConnection1.BeginTrans;
   self.get_authdate(dm.ADSA85PROD_ROUTE_PTR.Value);
   dm.ADSA85.Edit;
   dm.ADSA85AUDITED_STATUS.Value:=1; //待审批
   dm.ADSA85APPRV_BY_PTR.Value:=strtoint(common.user_ptr);   //提交人员
   dm.ADSA85APPRV_DATE.Value:=getsystem_date(dm.adoquery1,0); //提交日期
   dm.ADSA85.Post;
   dm.ADOConnection1.CommitTrans;
   self.BitBtn3Click(sender);
   dm.ADSA85.Close;
  except
   on E: Exception do
    begin
     dm.ADOConnection1.RollbackTrans;
     messagedlg(E.Message,mterror,[mbcancel],0);
    end;
  end
 else
  messagedlg('状态发生变生不能提交',mtinformation,[mbcancel],0);
end;
end;

procedure TForm1.N7Click(Sender: TObject);
begin
 application.CreateForm(tform_authinfo,form_authinfo);
 dm.ads274.Open;
 Form_authinfo.ShowModal;
 dm.ads274.Close;
 form_authinfo.Free;
end;

procedure TForm1.N6Click(Sender: TObject);
begin
if (strtoint(vprev)=1) or (strtoint(vprev)=3) then
 messagedlg('对不起!您没有该程序的可写权限',mtinformation,[mbok],0)
else
if dm.ADS85QBY_EMPL_PTR.Value<>strtoint(common.user_ptr) then
 messagedlg('删除操作只能创建人员本身可以进行!',mterror,[mbcancel],0)
else
if messagedlg('确认要删除该条报价记录吗?',mtconfirmation,[mbYes,mbNo],0)=mrYes then
 begin
 dm.ADSA85.Close;
 dm.ADSa85.Parameters[0].Value:=dm.ADS85rkey.Value;
 dm.ADSa85.Open;
 if dm.ADSA85AUDITED_STATUS.Value=dm.ADS85AUDITED_STATUS.Value  then
 try
 dm.ADOConnection1.BeginTrans;
 dm.ADSA85.Delete;
 dm.ADOConnection1.CommitTrans;
 self.BitBtn3Click(sender);
 dm.ADSA85.Close;
 messagedlg('删除操作成功',mtinformation,[mbok],0);
 except
  on E: Exception do
   begin
    dm.ADOConnection1.RollbackTrans;
    messagedlg(E.Message,mterror,[mbcancel],0);
   end;
 end
 else
  messagedlg('状态发生变生不能删除',mtinformation,[mbcancel],0);
 end;
end;

procedure TForm1.N2Click(Sender: TObject);
var i:integer;
begin
        if (strtoint(vprev)=1) or (strtoint(vprev)=3) then
         messagedlg('对不起!您没有该程序的可写权限',mtinformation,[mbok],0)
        else
        try
              screen.Cursor:=crHourGlass;
              form2:=tform2.Create(application);
              form2.aped_fg.Caption:='1'; //代表复制新增

              with dm.ADOQuery1 do
              begin
                   close;
                   sql.Text:='select * from data0085 where rkey='+dm.ADS85rkey.AsString;
                   open;
              end;
              dm.ADSA85.Close;
              dm.ADSa85.Parameters[0].Value:=null;
              dm.ADSa85.Open;
              dm.ADSa85.Append;
              for i:=1 to dm.ADSA85.FieldCount-1 do
                  dm.ADSA85.Fields[i].Value:=dm.ADOQuery1.FieldValues[dm.ADSA85.Fields[i].FieldName];
              dm.ADSA85QTE_DATE.Value:=getsystem_date(dm.adoquery1,1);    //报价日期
              dm.ADSA85EXPIRATION_DATE.Value:=dm.ADSA85QTE_DATE.Value+60; //有效期
              dm.ADSA85QBY_EMPL_PTR.AsString:=common.user_ptr; //报价人员
              dm.ADSA85AUDITED_STATUS.Value:=0;  //状态未提交
              OpenQuery(dm.ADOQuery1,'select QTE_BASE_TO_OTHER from data0001 where rkey='+dm.ADSA85CURR_PTR.AsString);
              dm.ADSA85CURR_RATE.Value:=dm.ADOQuery1.FieldValues['QTE_BASE_TO_OTHER'];
              dm.ADO04.Close;
              dm.ADO04.Open;
              if dm.ADO04SEED_FLAG.Value<>1 then
               begin
                dm.adsa85tnumber.value:=dm.ADO04SEED_VALUE.Value;
                if dm.ADO04SEED_FLAG.Value=4 then
                 form2.DBEdit1.ReadOnly:=true;
               end;

              with dm.ADOQuery1 do
              begin
               close;
               sql.Text:='select * from data0511 where source_ptr='+dm.ADS85rkey.AsString;
               open;
              end;
               dm.ads511.close;
               dm.ads511.Parameters[0].Value:=0;
               dm.ads511.open;            //打开拼版结构
               dm.ads511.Append;
              for i:=1 to 22 do
               dm.ADS511.Fields[i].Value:=dm.ADOQuery1.FieldValues[dm.ADS511.Fields[i].FieldName];
              dm.ads511source_ptr.Value:=0;

               dm.ads431.Close;
               dm.ads431.Parameters[0].Value:=0;
               dm.ads431.Open;         //打开报价参数

                  with dm.ADOQuery1 do
                  begin
                       close;
                       SQL.Clear;
                       sql.Text:='select * from data0431 where qte_ptr='+dm.ADS85rkey.AsString+#13+
                                 'order by rkey';
                       open;
                  end;
                  while not dm.ADOQuery1.Eof do
                  begin
                       dm.ads431.Append;
                       for i:=0 to 3 do
                              dm.ADS431.Fields[i].Value:= dm.ADOQuery1.FieldValues[dm.ADS431.Fields[i].FieldName];
                       dm.ads431QTE_PTR.Value:=0;
                       dm.ads431.Post;
                       dm.ADOQuery1.Next;
                  end;
                 screen.Cursor:=crDefault;
                 if form2.ShowModal=mrok then
                 begin
                  dm.ADS85.Close;
                  dm.ADS85.Open;
                  dm.ADS85.Locate('rkey',dm.ADSA85RKEY.Value,[]);
                  dm.ADSA85.Close;
                  DM.ads432.Close;
                  dm.ads431.Close;
                  dm.ads511.Close;
                 end
                 else begin
                  dm.ADSA85.Close;
                  DM.ads432.Close;
                  dm.ads431.Close;
                  dm.ads511.Close;
                 end;
        finally
            form2.Free;
        end;

end;



procedure TForm1.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
 if (dm.ADS85DSDesigner2.Value='被退回') then
  DBGrid1.Canvas.Font.Color := clred
 else
  if (dm.ADS85DSDesigner2.Value='待审批') then
   DBGrid1.Canvas.Font.Color := cllime
  else
   if (dm.ADS85DSDesigner2.Value='已过期') then
    DBGrid1.Canvas.Font.Color := claqua;

  DBGrid1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TForm1.PopupMenu1Popup(Sender: TObject);
begin
if dm.ADS85.IsEmpty then
 begin
  n2.Enabled:=false;     //复制
  n3.Enabled:=false;     //编辑
  n4.Enabled:=false;     //检查
  n5.Enabled:=false;     //提交审批
  n6.Enabled:=false;     //删除
  n7.Enabled:=false;     //审批信息
  n8.Enabled:=false;     //打印
  n9.Enabled:=false;     //延长有效期
  n10.Enabled:=false;    //取消审批
  N11.Enabled:=false;    //修改客户型号
 end
else
begin
  n2.Enabled:=true;     //复制
  n3.Enabled:=false;
  n4.Enabled:=true;     //检查
  n5.Enabled:=false;
  n6.Enabled:=false;
  n7.Enabled:=true;
  n8.Enabled:=true;     //打印
  n9.Enabled:=false;
  n10.Enabled:=true;
  N11.Enabled:=true;    //修改客户型号
 case dm.ADS85AUDITED_STATUS.Value of // 0未提交,1待审批,2已过期,3已审批,4退回
  0:begin              //未提交
     n3.Enabled:=true;
     n5.Enabled:=true;
     n6.Enabled:=true;
     n7.Enabled:=false;
     n10.Enabled:=false;
     N11.Enabled:=False;    //修改客户型号
    end;
  1:;               //待审批
  2:begin
     n9.Enabled:=true;
     n10.Enabled:=false;
    end;
  3:;
  4:begin
     n3.Enabled:=true;
     n6.Enabled:=true;
     n10.Enabled:=false;
     N11.Enabled:=False;    //修改客户型号
    end;
 end;
end;

end;

procedure TForm1.DBGrid1DblClick(Sender: TObject);
var
 info:string;
begin
if dm.ADS85AUDITED_STATUS.Value=4 then
begin
 OpenQuery(dm.ADOQuery1,'select employee_name from data0005 where rkey='+dm.ADS85APPRV_BY_PTR.AsString);
 info:=dm.ADOQuery1.FieldValues['employee_name'];
 info:=info+'于日期:'+dm.ADS85apprv_date.AsString+' 退回,原因如下:'+#13+
       dm.ADS85cust_add2.Value;
 showmessage(info);      
end
else
 if not dm.ADS85.IsEmpty then
  n4click(sender);
end;

procedure TForm1.N9Click(Sender: TObject);
var
 due:boolean;
 str:string;
begin
if (strtoint(vprev)=1) or (strtoint(vprev)=3) then
 messagedlg('对不起!您没有该程序的可写权限',mtinformation,[mbok],0)
else
if dm.ADS85QBY_EMPL_PTR.Value<>strtoint(common.user_ptr) then
 messagedlg('延长有效期只能创建人员本身可以进行!',mterror,[mbcancel],0)
else
if not find_invtpricechange(dm.ADS85rkey.Value,dm.ADS85quote_type.Value) then
 try
  dm.ADSA85.Close;
  dm.ADSa85.Parameters[0].Value:=dm.ADS85rkey.Value;
  dm.ADSa85.Open;
  due:=true;
  str:=datetostr(getsystem_date(dm.adoquery1,1)+10);
  if inputquery('原有效期'+dm.ADSA85EXPIRATION_DATE.AsString,
    '请输入报价单'+trim(dm.ADSA85TNUMBER.Value)+'新有效期:',str) then
  while due do
   begin
    try
     strtodate(str);
     due:=false;
    except
     showmessage('日期格式不正确请重新输入');
    end;
   end;


  if not due then
  begin
   dm.ADOConnection1.BeginTrans;
   dm.ADSA85.Edit;
   dm.ADSA85AUDITED_STATUS.Value:=3;
   dm.ADSA85EXPIRATION_DATE.AsString:=str;
   dm.ADSA85.Post;
   dm.ADOConnection1.CommitTrans;
   self.BitBtn3Click(sender);
   dm.ADSA85.Close;
  end;
 except
  on E: Exception do
   begin
    dm.ADOConnection1.RollbackTrans;
    messagedlg(E.Message,mterror,[mbcancel],0);
   end;
 end
else
 messagedlg('报价材料已经调高了价格,不能再延长有效期!!!',mterror,[mbcancel],0);

end;

procedure TForm1.N10Click(Sender: TObject);
begin
if self.find_salesorder(dm.ADS85rkey.Value) then
 messagedlg('对不起!报价单已被使用不用取消审批!',mtinformation,[mbok],0)
else
if (strtoint(vprev)<>4) then
 messagedlg('对不起!只有高级权限才可以取消审批!',mtinformation,[mbok],0)
else
begin
 dm.ADSA85.Close;
 dm.ADSa85.Parameters[0].Value:=dm.ADS85rkey.Value;
 dm.ADSa85.Open;
if dm.ADSA85AUDITED_STATUS.Value=dm.ADS85AUDITED_STATUS.Value then
try
 dm.ADOConnection1.BeginTrans;
 dm.ADSA85.Edit;
 dm.ADSA85AUDITED_STATUS.Value:=0; //未提交
 dm.ADSA85.Post;
 dm.ADOConnection1.CommitTrans;
 self.BitBtn3Click(sender);
 dm.ADSA85.Close;
except
 on E: Exception do
  begin
   dm.ADOConnection1.RollbackTrans;
   messagedlg(E.Message,mterror,[mbcancel],0);
  end;
end
else
 messagedlg('状态发生变生不能取消提交',mtinformation,[mbcancel],0);
end;
end;

procedure TForm1.BitBtn6Click(Sender: TObject);
begin
  popupmenu3.Popup(mouse.CursorPos.x,mouse.CursorPos.y);

end;

procedure TForm1.N11Click(Sender: TObject);
var
 row:string;
begin
 row:=dm.ADS85CUST_PART_NO.Value;

 if InputQuery('信息输入', '请输入新的客户型号:',row) then
  begin
   dm.AQtmp.Close;
   dm.AQtmp.SQL.Clear;
   dm.AQtmp.SQL.Text:='update data0085 set CUST_PART_NO='+QuotedStr(row)+
   ' where rkey='+dm.ADS85rkey.AsString;
   if dm.AQtmp.ExecSQL>0 then
    begin
     showmsg('保存成功',1);
     self.BitBtn3Click(sender);
    end
   else
    showmsg('保存失败,请与管理员系联',1);
  end; 
end;

procedure TForm1.N12Click(Sender: TObject);
begin
self.print_report(dm.ADS85rkey.Value);
end;

procedure TForm1.N14Click(Sender: TObject);
begin
 form_report:=tform_report.Create(application);
  form_report.ppReport1.Reset;
  {form_report.ppReport1.Template.FileName :=
    stringReplace(GetCurrentDir,'','\',[rfReplaceAll])+
   '\fastquote_report_FPC.rtm';  }
  form_report.ppReport1.Template.FileName :=
    stringReplace(GetCurrentDir,'EXEC','NIERP\REPORT\',[rfReplaceAll])+
      'fastquote_report_FPC.rtm';
  form_report.ppReport1.Template.LoadFromFile;
  form_report.ppReport1.SaveAsTemplate:=True;
 form_report.ppDesigner1.ShowModal;
 form_report.Free;
end;

procedure TForm1.N15Click(Sender: TObject);
begin
 form_report:=tform_report.Create(application);
  form_report.ppReport1.Reset;
 { form_report.ppReport1.Template.FileName :=
    stringReplace(GetCurrentDir,'','\',[rfReplaceAll])+'\'+
      '\fastquote_easyreport_FPC.rtm'; }
  form_report.ppReport1.Template.FileName :=
    stringReplace(GetCurrentDir,'EXEC','NIERP\REPORT\',[rfReplaceAll])+
      'fastquote_easyreport_FPC.rtm';   
  form_report.ppReport1.Template.LoadFromFile;
  form_report.ppReport1.SaveAsTemplate:=true;
 form_report.ppDesigner1.ShowModal;
 form_report.Free;
end;

procedure TForm1.N13Click(Sender: TObject);
var
 i:word;
 s:string;
begin
 form_report:=tform_report.Create(application);
 with form_report do
 begin
  ADS85.Close;
  ads85.Parameters[0].Value:=dm.ADS85rkey.Value;
  ads85.Open;
  ads511.Open;
  ads253.Open;
  ads431.open;
  ads432.open;
  ads432t.Open;

  form_report.ppReport1.Reset;
   { form_report.ppReport1.Template.FileName :=
    stringReplace(GetCurrentDir,'','\',[rfReplaceAll])+
      '\fastquote_easyreport.rtm';   }
  form_report.ppReport1.Template.FileName :=
    stringReplace(GetCurrentDir,'EXEC','NIERP\REPORT\',[rfReplaceAll])+
      'fastquote_easyreport_FPC.rtm';   
  form_report.ppReport1.Template.LoadFromFile;
  ppImage1.Picture.Assign(Load_JPG_Pic_From_DB(ads511sheet_BMP));
  s:='                    ';
   for i:=1 to ads431.RecordCount do
    begin
     if odd(ads431.RecordCount) then
      if i<=(ads431.RecordCount+1)/2 then
      begin
       ppMemo1.Lines.Add(trim(ADS431PARAMETER_DESC.Value)+':'+
       copy(s,1,20-length(trim(ADS431PARAMETER_DESC.Value)))+
       trim(ADS431UNIT_VALUE.Value));
      end
      else
      begin
       ppMemo2.Lines.Add(trim(ADS431PARAMETER_DESC.Value)+':'+
       copy(s,1,20-length(trim(ADS431PARAMETER_DESC.Value)))+
       trim(ADS431UNIT_VALUE.Value));
      end
     else
      if i<=(ads431.RecordCount)/2 then
      begin
       ppMemo1.Lines.Add(trim(ADS431PARAMETER_DESC.Value)+':'+
       copy(s,1,20-length(trim(ADS431PARAMETER_DESC.Value)))+
       trim(ADS431UNIT_VALUE.Value));
      end
      else
      begin
       ppMemo2.Lines.Add(trim(ADS431PARAMETER_DESC.Value)+':'+
       copy(s,1,20-length(trim(ADS431PARAMETER_DESC.Value)))+
       trim(ADS431UNIT_VALUE.Value));
      end;
     ads431.Next;
    end;
 end;
 form_report.ppReport1.Print;
 form_report.Free;
end;

end.
