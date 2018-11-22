unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, ExtCtrls, Menus, StdCtrls, Buttons, ComObj, StrUtils,
  DBGridEh;

type
  TForm1 = class(TForm)
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
    Excel1: TMenuItem;
    Excel2: TMenuItem;
    N16: TMenuItem;
    N17: TMenuItem;
    N18: TMenuItem;
    DBGrid1: TDBGridEh;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
//    procedure DBGrid1TitleClick(Column: TColumn);
    procedure FormShow(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
//    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure N1Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
//    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
//      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure PopupMenu1Popup(Sender: TObject);
//    procedure DBGrid1DblClick(Sender: TObject);
    procedure N9Click(Sender: TObject);
    procedure N10Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure N11Click(Sender: TObject);
    procedure N12Click(Sender: TObject);
    procedure N14Click(Sender: TObject);
    procedure N15Click(Sender: TObject);
    procedure N13Click(Sender: TObject);
    procedure Excel1Click(Sender: TObject);
    procedure N16Click(Sender: TObject);
    procedure N17Click(Sender: TObject);
    procedure N18Click(Sender: TObject);
    procedure DBGridEh1DblClick(Sender: TObject);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure DBGridEh1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGridEh1TitleClick(Column: TColumnEh);
    procedure DBGrid1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
  private
   PreColumn: TColumnEh;
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
  quote_report,ADODB, DB, uModifyType;

{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
//
// if not app_init_2(dm.ADOConnection1) then
//  begin
//   ShowMsg('��������ʧ�ܣ�����ϵͳ����Ա��ϵ��','��ʾ',1);
//   application.Terminate;
//   exit;
//  end;

//  if GetServerRegion(dm.ADOConnection1) = '����' then
//  begin
//    ShowMessage('�ɳ����Ѿ�ֹͣʹ�ã����½�°�ϵͳ������ϵERP');
//    Application.Terminate;
//    Exit;
//  end;
 //  {
 vprev:='4';
 rkey73:='2525';
  // }
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
   fieldvalues['MESSAGE'] := '��һ�ű��۵���Ҫͨ����������,������Ա:'+
                             dm.ADS85EMPLOYEE_NAME.Value+' ���۱��:'+
                             dm.ADS85TNUMBER.Value+
                             ' �ύ����:'+datetimetostr(getsystem_date(dm.adoquery3,0));
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
if quote_ttype=0 then //�������۵�
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
else              //ת�����۵�
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
       ShowMessage(GetCurrentDir);
 form_report:=tform_report.Create(Application);

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

  form_report.ppReport1.Template.FileName :=
    stringReplace(UpperCase(GetCurrentDir),'EXEC','NIERP\REPORT\',[rfReplaceAll])+
      'fastquote_N_report.rtm';
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
  Export_dbGridEH_to_Excel(dbgrid1,self.Caption);
end;

procedure TForm1.Edit1Change(Sender: TObject);
begin
 if trim(Edit1.text)<>'' then
  dm.ADs85.Filter := field_name+' like ''%'+trim(edit1.text)+'%'''
 else
  dm.ADs85.filter := '';
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
   dm.ADOConnection1.Connected:= True;
 if dm.ADOConnection1.Connected then
 begin
{  with dm.adoquery3 do
  begin
   close;
   sql.Clear;
   sql.Add('select EMPLOYEE_PTR from data0073');
   sql.Add('where rkey='+rkey73);
   open;
   common.user_ptr:= fieldbyname('employee_ptr').asstring;
  end;
  }
  with dm.adoquery3 do
  begin
   close;
   sql.Clear;
   sql.Add('select QTE_CONTROL1 from data0192');
   open;
   dm.qte_type := fieldbyname('QTE_CONTROL1').AsInteger; //���ۼ��㷽ʽ
  end;
  field_name := DBGrid1.Columns[0].FieldName;
  PreColumn := DBGrid1.Columns[0];
//  application.CreateForm(tform_overdue,form_overdue);
//  with form_overdue.ADS85 do
//  begin
//   close;
//   Parameters[0].Value:=getsystem_date(dm.adoquery1,1);
//   open;
//  end;
//  if not form_overdue.ADS85.IsEmpty then form_overdue.ShowModal;
//  form_overdue.ADS85.Close;
//  form_overdue.Free;

  dm.ADS85.Close;

//  if strtoint(vprev) in [1,3] then
//  begin
//   dm.ADS85.CommandText:=dm.ADS85.CommandText+ 'and data0085.CUST_PTR in (select d10.rkey from data0010 d10 ' +
//    ' inner join data0100 d100 on d10.rkey = d100.CUSTOMER_PTR ' +
//    ' where d100.CSI_PTR  = ' + rkey73 + ') ';
//  end;
//   dm.ADS85.Parameters.ParamByName('dtpk1').Value:='2016-12-01';
//  dm.ADS85.Parameters.ParamByName('dtpk2').Value:='2017-01-01';
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
   dm.ADs85.CommandText:=dm.ADs85.CommandText+ ' ' + form_condition.SGrid1.Cells[2,i]+#13;
  dm.ADs85.Parameters.ParamByName('dtpk1').Value:=form_condition.dtpk1.Date;
  dm.ADs85.Parameters.ParamByName('dtpk2').Value:=form_condition.dtpk2.Date;

  dm.ADS85.Prepared;
  dm.ADs85.Open;
 end;
end;

//procedure TForm1.DBGrid1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
//begin
// if (chr(key)='V') and (ssalt in shift) then
//  showmessage(dm.ADs85.CommandText);
//end;

procedure TForm1.N1Click(Sender: TObject);
begin
 if (strtoint(vprev)=1) or (strtoint(vprev)=3) then
  messagedlg('�Բ���!��û�иó���Ŀ�дȨ��',mtinformation,[mbok],0)
 else
 try
  form2:=tform2.Create(application);
  dm.ADSA85.Close;
  dm.ADSa85.Parameters[0].Value:=null;
  dm.ADSa85.Open;
  dm.ADSa85.Append;
  dm.ADSA85QTE_DATE.Value:=getsystem_date(dm.adoquery1,1);
  dm.ADSA85EXPIRATION_DATE.Value:=dm.ADSA85QTE_DATE.Value+60;
  dm.ADSA85QUOTE_TYPE.Value:=0;   //����
  dm.ADSA85TTYPE.Value:=0;       //���ٱ���
  dm.ADSA85ttype2.Value:=0;      //����0,�µ�
  dm.ADSA85QTE_UNIT_PTR.Value:=1; //��PCS����
  dm.ADSA85CUST_QTE_FACTOR.Value:=0;//����Ӽ���%
  dm.ADSA85SALES_DISCOUNT.Value:=0; //�����ۿ�%
  dm.ADSA85vatax.Value:=0;          //��ֵ˰��
  dm.ADSA85QBY_EMPL_PTR.AsString:=common.user_ptr; //������Ա
  dm.ADSA85AUDITED_STATUS.Value:=0;  //״̬δ�ύ
  dm.ADSA85QTE_CONTROL5.Value:='N';  //û�м���
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
   dm.ads431.Close;
   dm.ads511.Close;
   dm.ads278.Close;
  end
  else begin
   dm.ADSA85.Close;
   dm.ads432.Close;
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
 messagedlg('�Բ���!��û�иó���Ŀ�дȨ��',mtinformation,[mbok],0)
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
 messagedlg('״̬�����������ܱ༭',mtinformation,[mbcancel],0);
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
   DBEdit39.Enabled:=false;
   DBEdit40.Enabled:=false;
   BitBtn18.Enabled:=false;
   dbmemo1.Enabled:=false;
   dbradiogroup1.Enabled:=false;
   edtBJSX.Enabled:=False;
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
   bitbtn13.Visible:=true;       //���ʱ���Դ�ӡ
   BitBtn16.Visible:=true;
   BitBtn17.Enabled:=False;
   DBComboBox3.Enabled:=false;
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
 messagedlg('�Բ���!��û�иó���Ŀ�дȨ��',mtinformation,[mbok],0)
else
begin
 dm.ADSA85.Close;
 dm.ADSa85.Parameters[0].Value:=dm.ADS85rkey.Value;
 dm.ADSa85.Open;
 if dm.ADSA85QTE_CONTROL5.Value='N' then
  begin
   showmsg('���۵�û����ɼ�����ʱ�����ύ!',1);
   dm.ADSA85.Close;
  end
 else
 if dm.ADSA85AUDITED_STATUS.Value=dm.ADS85AUDITED_STATUS.Value then
  try
   dm.ADOConnection1.BeginTrans;
   self.get_authdate(dm.ADSA85PROD_ROUTE_PTR.Value);
   dm.ADSA85.Edit;
   dm.ADSA85AUDITED_STATUS.Value:=1; //������
   dm.ADSA85APPRV_BY_PTR.Value:=strtoint(common.user_ptr);   //�ύ��Ա
   dm.ADSA85APPRV_DATE.Value:=getsystem_date(dm.adoquery1,0); //�ύ����
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
  messagedlg('״̬�������������ύ',mtinformation,[mbcancel],0);
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
 messagedlg('�Բ���!��û�иó���Ŀ�дȨ��',mtinformation,[mbok],0)
else
if dm.ADS85QBY_EMPL_PTR.Value<>strtoint(common.user_ptr) then
 messagedlg('ɾ������ֻ�ܴ�����Ա������Խ���!',mterror,[mbcancel],0)
else
if messagedlg('ȷ��Ҫɾ���������ۼ�¼��?',mtconfirmation,[mbYes,mbNo],0)=mrYes then
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
 messagedlg('ɾ�������ɹ�',mtinformation,[mbok],0);
 except
  on E: Exception do
   begin
    dm.ADOConnection1.RollbackTrans;
    messagedlg(E.Message,mterror,[mbcancel],0);
   end;
 end
 else
  messagedlg('״̬������������ɾ��',mtinformation,[mbcancel],0);
 end;
end;

procedure TForm1.N2Click(Sender: TObject);
var i:integer;
begin
if (strtoint(vprev)=1) or (strtoint(vprev)=3) then
 messagedlg('�Բ���!��û�иó���Ŀ�дȨ��',mtinformation,[mbok],0)
else
try
  screen.Cursor:=crHourGlass;
form2:=tform2.Create(application);
form2.aped_fg.Caption:='1'; //����������

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
dm.ADSA85QTE_DATE.Value:=getsystem_date(dm.adoquery1,1);    //��������
dm.ADSA85EXPIRATION_DATE.Value:=dm.ADSA85QTE_DATE.Value+60; //��Ч��
dm.ADSA85QBY_EMPL_PTR.AsString:=common.user_ptr; //������Ա
dm.ADSA85AUDITED_STATUS.Value:=0;  //״̬δ�ύ
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
 dm.ads511.open;            //��ƴ��ṹ
 dm.ads511.Append;
for i:=1 to 22 do
 dm.ADS511.Fields[i].Value:=dm.ADOQuery1.FieldValues[dm.ADS511.Fields[i].FieldName];
dm.ads511source_ptr.Value:=0;

 dm.ads431.Close;
 dm.ads431.Parameters[0].Value:=0;
 dm.ads431.Open;         //�򿪱��۲���

with dm.ADOQuery1 do
begin
 close;
 sql.Text:='select * from data0431 where qte_ptr='+dm.ADS85rkey.AsString+#13+
           'order by rkey';
 open;
end;
while not dm.ADOQuery1.Eof do
begin
 dm.ads431.Append;
 for i:=0 to 3 do
  dm.ADS431.Fields[i].Value:=dm.ADOQuery1.FieldValues[dm.ADS431.Fields[i].FieldName];
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

//procedure TForm1.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
//  DataCol: Integer; Column: TColumn; State: TGridDrawState);
//begin
// if (dm.ADS85DSDesigner2.Value='���˻�') then
//  DBGrid1.Canvas.Font.Color := clred
// else
//  if (dm.ADS85DSDesigner2.Value='������') then
//   DBGrid1.Canvas.Font.Color := cllime
//  else
//   if (dm.ADS85DSDesigner2.Value='�ѹ���') then
//    DBGrid1.Canvas.Font.Color := claqua;
//
//  DBGrid1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
//end;

procedure TForm1.PopupMenu1Popup(Sender: TObject);
begin
if dm.ADS85.IsEmpty then
 begin
  n2.Enabled:=false;     //����
  n3.Enabled:=false;     //�༭
  n4.Enabled:=false;     //���
  n5.Enabled:=false;     //�ύ����
  n6.Enabled:=false;     //ɾ��
  n7.Enabled:=false;     //������Ϣ
  n8.Enabled:=false;     //��ӡ
  n9.Enabled:=false;     //�ӳ���Ч��
  n10.Enabled:=false;    //ȡ������
  N11.Enabled:=false;    //�޸Ŀͻ��ͺ�
  N16.Enabled:=false;    //�������(���±���ʱЧ)
  N17.Enabled:=false;    //�޸ı�������
  N18.Enabled:=False;     //����
 end
else
begin
  n2.Enabled:=true;     //����
  n3.Enabled:=false;
  n4.Enabled:=true;     //���
  n5.Enabled:=false;
  n6.Enabled:=false;
  n7.Enabled:=true;
  n8.Enabled:=true;     //��ӡ
  n9.Enabled:=false;
  n10.Enabled:=true;
  N11.Enabled:=true;    //�޸Ŀͻ��ͺ�
  N16.Enabled:=true;    //�������
  N17.Enabled:=true;    //�޸ı�������
 case dm.ADS85AUDITED_STATUS.Value of // 0δ�ύ,1������,2�ѹ���,3������,4�˻�
  0:begin              //δ�ύ
     n3.Enabled:=true;
     n5.Enabled:=true;
     n6.Enabled:=true;
     n7.Enabled:=false;
     n10.Enabled:=false;
     N11.Enabled:=False;    //�޸Ŀͻ��ͺ�
     N17.Enabled:=False;    //�޸ı�������
    end;
  1:;               //������
  2:begin
     n9.Enabled:=true;
     n10.Enabled:=false;
     N16.Enabled:=false;
    end;
  3:N16.Enabled:=false;
  4:begin
     n3.Enabled:=true;
     n6.Enabled:=true;
     n10.Enabled:=false;
     N11.Enabled:=False;    //�޸Ŀͻ��ͺ�
     N17.Enabled:=False;    //�޸ı�������
    end;
 end;
end;

end;

//procedure TForm1.DBGrid1DblClick(Sender: TObject);
//var
// info:string;
//begin
//if dm.ADS85AUDITED_STATUS.Value=4 then
//begin
// OpenQuery(dm.ADOQuery1,'select employee_name from data0005 where rkey='+dm.ADS85APPRV_BY_PTR.AsString);
// info:=dm.ADOQuery1.FieldValues['employee_name'];
// info:=info+'������:'+dm.ADS85apprv_date.AsString+' �˻�,ԭ������:'+#13+
//       dm.ADS85cust_add2.Value;
// showmessage(info);
//end
//else
// if not dm.ADS85.IsEmpty then
//  n4click(sender);
//end;

procedure TForm1.N9Click(Sender: TObject);
var
 due:boolean;
 str:string;
begin
if (strtoint(vprev)=1) or (strtoint(vprev)=3) then
 messagedlg('�Բ���!��û�иó���Ŀ�дȨ��',mtinformation,[mbok],0)
else
if dm.ADS85QBY_EMPL_PTR.Value<>strtoint(common.user_ptr) then
 messagedlg('�ӳ���Ч��ֻ�ܴ�����Ա������Խ���!',mterror,[mbcancel],0)
else
if not find_invtpricechange(dm.ADS85rkey.Value,dm.ADS85quote_type.Value) then
 try
  dm.ADSA85.Close;
  dm.ADSa85.Parameters[0].Value:=dm.ADS85rkey.Value;
  dm.ADSa85.Open;
  due:=true;
  str:=datetostr(getsystem_date(dm.adoquery1,1)+10);
  if inputquery('ԭ��Ч��'+dm.ADSA85EXPIRATION_DATE.AsString,
    '�����뱨�۵�'+trim(dm.ADSA85TNUMBER.Value)+'����Ч��:',str) then
  while due do
   begin
    try
     strtodate(str);
     due:=false;
    except
     showmessage('���ڸ�ʽ����ȷ����������');
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
 messagedlg('���۲����Ѿ������˼۸�,�������ӳ���Ч��!!!',mterror,[mbcancel],0);

end;

procedure TForm1.N10Click(Sender: TObject);
begin
if self.find_salesorder(dm.ADS85rkey.Value) then
 messagedlg('�Բ���!���۵��ѱ�ʹ�ò���ȡ������!',mtinformation,[mbok],0)
else
if (strtoint(vprev)<>4) then
 messagedlg('�Բ���!ֻ�и߼�Ȩ�޲ſ���ȡ������!',mtinformation,[mbok],0)
else
begin
 dm.ADSA85.Close;
 dm.ADSa85.Parameters[0].Value:=dm.ADS85rkey.Value;
 dm.ADSa85.Open;
if dm.ADSA85AUDITED_STATUS.Value=dm.ADS85AUDITED_STATUS.Value then
try
 dm.ADOConnection1.BeginTrans;
 dm.ADSA85.Edit;
 dm.ADSA85AUDITED_STATUS.Value:=0; //δ�ύ
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
 messagedlg('״̬������������ȡ���ύ',mtinformation,[mbcancel],0);
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
  if (strtoint(vprev)=1) or (strtoint(vprev)=3) then
   messagedlg('�Բ���!��û�иó���Ŀ�дȨ��',mtinformation,[mbok],0)
  else
  begin
    row:=dm.ADS85CUST_PART_NO.Value;

    if InputQuery('��Ϣ����', '�������µĿͻ��ͺ�:',row) then
    begin
     dm.AQtmp.Close;
     dm.AQtmp.SQL.Clear;
     dm.AQtmp.SQL.Text:='update data0085 set CUST_PART_NO='+QuotedStr(row)+
     ' where rkey='+dm.ADS85rkey.AsString;
     if dm.AQtmp.ExecSQL>0 then
      begin
       showmsg('����ɹ�',1);
       self.BitBtn3Click(sender);
      end
     else
      showmsg('����ʧ��,�������Աϵ��',1);
    end;
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
  ShowMessage(GetCurrentDir);
  form_report.ppReport1.Template.FileName :=
    stringReplace(UpperCase(GetCurrentDir),'EXEC','NIERP\REPORT\',[rfReplaceAll])+
      'fastquote_N_report.rtm';
  form_report.ppReport1.Template.LoadFromFile;
  form_report.ppReport1.SaveAsTemplate:=true;
 form_report.ppDesigner1.ShowModal;
 form_report.Free;
end;

procedure TForm1.N15Click(Sender: TObject);
begin
 form_report:=tform_report.Create(application);
  form_report.ppReport1.Reset;
  form_report.ppReport1.Template.FileName :=
    stringReplace(UpperCase(GetCurrentDir),'EXEC','NIERP\REPORT\',[rfReplaceAll])+
      'fastquote_easyreport.rtm';
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
  form_report.ppReport1.Template.FileName :=
    stringReplace(GetCurrentDir,'EXEC','NIERP\REPORT\',[rfReplaceAll])+
      'fastquote_easyreport.rtm';
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

procedure TForm1.Excel1Click(Sender: TObject);
var
  excel,WorkBook,Sheet: Variant;
  i,j,iRow,iColumn:integer;
  vstr:string;
begin
  if not dm.ADS85.Active then exit;
  Screen.Cursor := crHourGlass;
  try
    dm.qry85.Close;                  
    dm.qry85.Parameters[0].Value:=dm.ADS85.FieldByName('RKEY').AsInteger;
    dm.qry85.Open;
    dm.qry253.Close;
    dm.qry253.Parameters[0].Value:=dm.ADS85.FieldByName('RKEY').AsInteger;
    dm.qry253.Open;
    dm.qry431.Close;
    dm.qry431.Parameters[0].Value:=dm.ADS85.FieldByName('RKEY').AsInteger;
    dm.qry431.Open;
    dm.qry432.Close;
    dm.qry432.Parameters[0].Value:=dm.ADS85.FieldByName('RKEY').AsInteger;
    dm.qry432.Open;

    try
      excel := CreateOleObject('Excel.Application');
//      WorkBook := excel.Workbooks.Add('D:\SJSYS\NIERP\Report\���۵�.xls');
      if (sender as TMenuItem).Tag = 0 then
        WorkBook := excel.Workbooks.Add(stringReplace(UpperCase(GetCurrentDir),'EXEC','NIERP\REPORT\',[rfReplaceAll])+'���۵�.xls')
      else
        WorkBook := excel.Workbooks.Add(stringReplace(UpperCase(GetCurrentDir),'EXEC','NIERP\REPORT\',[rfReplaceAll])+'Ӣ�ı��۵�.xls');
      Sheet := WorkBook.Worksheets[1];
    except
      excel := NULL;
      showmessage('���Ȱ�װExcel97/2000');
      EXIT;
    end;
    excel.Visible:=true;

    //ȡ����������
//    iRow := excel.ActiveCell.Row;
//    iColumn := excel.ActiveCell.Column;
    iRow:=excel.activeSheet.Usedrange.Rows.count;
    iColumn:= excel.activeSheet.Usedrange.Columns.count;
    for i:=1 to iRow do//���ȡֵ200
    begin
      for j:=1 to iColumn do
      begin
        if TVarData(WorkBook.activesheet.Cells[i,j].value).VType <> VarError then
            vstr:= VarToStr(WorkBook.activesheet.Cells[i,j].value)
        else
           vstr:='';
     //   vstr:= WorkBook.activesheet.Cells[i,j].value;
        if vstr<>'' then
         if copy(vstr,1,3)='ASC' then
         begin
           vstr:=form2.StrToSQL(vstr);
           WorkBook.activesheet.Cells[i,j]:=vstr;
         end;
      end;
    end;
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TForm1.N16Click(Sender: TObject);
begin
  if (strtoint(vprev)=1) or (strtoint(vprev)=3) then
    messagedlg('�Բ���!��û�иó���Ŀ�дȨ��',mtinformation,[mbok],0)
  else
  if dm.ADS85.FieldByName('PaperNO').AsString<>'' then
  begin
    with dm.ADOQuery1 do
    begin
      Close;
      SQL.Clear;
      SQL.Add('select 1 from data0242 where Quote_Status=2 and PaperNO='''+dm.ADS85.FieldByName('PaperNO').AsString+'''');
      Open;
    end;
    if dm.ADOQuery1.RecordCount>0 then
    begin
//      Showmessage('��ǰ�������ò�����֪ͨ�������Ա,�������ظ�����!');
      if MessageBox(Handle, '��ǰ�������ò�����֪ͨ�������Ա,�ظ�������ˢ�±����������,�Ƿ����?', '��ʾ', MB_OKCANCEL +
        MB_ICONQUESTION) = IDCANCEL then
      begin
        Abort;
      end;
    end;
    try
      //���±���ʱЧ��״̬:�����
      with dm.ADOQuery1 do
      begin
        Close;
        SQL.Clear;
        SQL.Add('update data0242 set Quote_Status=2,Quote_FinishTime=getdate() where PaperNO='''+dm.ADS85.FieldByName('PaperNO').AsString+'''');
        ExecSQL;
      end;

      //����֪ͨ����ʱЧ��������
      with dm.ADOQuery1 do
      begin
        Close;
        SQL.Clear;
        SQL.Text:= 'INSERT DATA0014(MESSAGE,whosend)'+#13
                  +'values(''����ʱЧ��:'+dm.ADS85.FieldByName('PaperNO').AsString+' ���۵�:'+dm.ADS85.FieldByName('TNUMBER').AsString+' �ѱ������ �������:'''+'+convert(varchar,getdate(),120)'+','+rkey73+')'+#13
                  +'DECLARE @to int'+#13
                  +'SET @to=@@Identity'+#13
                  +'INSERT DATA0314(emp_ptr,d14_ptr) SELECT t73.RKEY,@to FROM DATA0242 t242 INNER JOIN Data0073 t73 ON t242.CreateBy_PTR=t73.EMPLOYEE_PTR WHERE t242.PaperNO = '''+dm.ADS85.FieldByName('PaperNO').AsString+'''';
        ExecSQL;
      end;
      Showmessage('�����ɹ�,��֪ͨ�����Ա!');
    except
      Showmessage('����ʧ��,������!');
    end;  
  end
  else
    Showmessage('δ�ҵ���ƥ��ı���ʱЧ��!');
end;

procedure TForm1.N17Click(Sender: TObject);
begin
  if (strtoint(vprev)=1) or (strtoint(vprev)=3) then
   messagedlg('�Բ���!��û�иó���Ŀ�дȨ��',mtinformation,[mbok],0)
  else
  begin
    frmModifyType := TfrmModifyType.Create(Application);
    with frmModifyType do
    try
      cbType.ItemIndex:=cbType.Items.IndexOf(dm.ADS85.FieldByName('����').AsString);
      if ShowModal = mrOk then
      begin
        if cbType.ItemIndex<0 then Exit;
        dm.AQtmp.Close;
        dm.AQtmp.SQL.Clear;
        dm.AQtmp.SQL.Text:='UPDATE Data0085 SET ttype2='+IntToStr(cbType.ItemIndex)+
        ' WHERE RKEY='+dm.ADS85rkey.AsString;
        if dm.AQtmp.ExecSQL>0 then
        begin
          showmsg('����ɹ�',1);
          self.BitBtn3Click(sender);
        end
        else showmsg('����ʧ��,�������Աϵ��',1);
      end;
    finally
      frmModifyType.Free;
    end;
  end;
end;

procedure TForm1.N18Click(Sender: TObject);
var
  ovhd,TOTAL,CRP_EST,SHIPPING,MARKUP:Double;
  qrytmp1,qrytmp2:TADOQuery;
  i:Integer;
begin
  try
  qrytmp1:=TADOQuery.Create(nil);
  qrytmp1.Connection:=dm.ADOConnection1;
  qrytmp2:=TADOQuery.Create(nil);
  qrytmp2.Connection:=dm.ADOConnection1;
  Screen.Cursor:=crHourGlass;
    try
      dm.ADOConnection1.BeginTrans;
      for i:=0 to DBGrid1.SelectedRows.Count-1 do
      begin
        DBGrid1.DataSource.DataSet.Bookmark := DBGrid1.SelectedRows.Items[i];
        if UpperCase(dm.ADS85QTE_CONTROL5.AsString)='N'  then
        begin
    //          ShowMessage('���ȵ����ٱ���ģ�����������㣡');
          continue;
        end;
        ovhd:=0;
        TOTAL:=0;
        CRP_EST:=0;
        SHIPPING:=0;
        MARKUP:=0;

          with qrytmp1 do
          begin
            Close;
            SQL.Clear;
            sql.Text:=Format('UPDATE Data0432 SET FREE_AMOUNT= ROUND(AMOUNT*(1-Data0348.rate_margin*0.01),6) '+ #13+
                               ' FROM         dbo.Data0432 INNER JOIN  '+ #13+
                               '                       dbo.Data0348 ON dbo.Data0432.SOURCE_PTR = dbo.Data0348.RKEY  '+ #13+
                               ' WHERE Data0432.QTE_PTR= %s',[dm.ADS85rkey.AsString]);
            ExecSQL;
          end;
          with qrytmp1 do
          begin
            Close;
            SQL.Clear;
            SQL.Text:=' SELECT isnull(SUM(FREE_AMOUNT),0) as N_AMOUNT '+#13+
                      ' FROM         dbo.Data0432 INNER JOIN  '+#13+
                      '                      dbo.Data0348 ON dbo.Data0432.SOURCE_PTR = dbo.Data0348.RKEY '+#13+
                      ' WHERE QTE_PTR=' + dm.ADS85rkey.AsString;
            Open;
    //        ShowMessage(SQL.Text);
            if not IsEmpty then
            begin
              ovhd:= FieldByName('N_AMOUNT').Value;                         //���ճɱ�
              TOTAL:= dm.ADS85MATL_COST.Value + dm.ADS85base_pcscost.Value +  ovhd;       //�ܳɱ�
              CRP_EST:= TOTAL * dm.ADS85CUST_QTE_FACTOR.Value*0.01;            //����Ӽ�
              SHIPPING:= TOTAL + CRP_EST + dm.ADS85comm_cost.Value -  dm.ADS85QTE_UNITS.Value;   //�۸�����
              if dm.ADS85QTE_UNITS.Value=0 then MARKUP:=0
              else  MARKUP:= ExRoundTo( ((dm.ADS85QTE_UNITS.Value * (1 - dm.ADS85SALES_DISCOUNT.Value*0.01)
                          -  TOTAL * ( 1 + dm.ADS85CUST_QTE_FACTOR.Value*0.01 )) / dm.ADS85QTE_UNITS.Value*100),2);  //ë����

                with qrytmp2 do
                begin
                  Close;
                  SQL.Clear;
                  SQL.Text:= format(' UPDATE DATA0085 SET OVHD_N_COST= %.6f,TOTAL_N_COST=%.6f,CRPEST_N_COST=%.6f, '+
                                    ' SHIPPING_N_CHARGE=%.6f,MARKUP=%.2f  WHERE RKEY= %s ' ,
                            [ovhd,TOTAL,CRP_EST,SHIPPING,MARKUP,dm.ADS85rkey.AsString]);
        //          ShowMessage(SQL.Text);
                  ExecSQL;
                end;
            end;
          end;
      end;
      dm.ADOConnection1.CommitTrans;
      ShowMessage('������ɣ�');
    except
      on E: Exception do
      begin
        Screen.Cursor:=crDefault;
        dm.ADOConnection1.RollbackTrans;
        messagedlg(E.Message,mterror,[mbcancel],0);
      end;
    end;
  Screen.Cursor:=crDefault;
  BitBtn3Click(nil);
  finally
    qrytmp1.Free;
    qrytmp2.Free;
  end;
end;

procedure TForm1.DBGridEh1DblClick(Sender: TObject);
var
 info:string;
begin
if dm.ADS85AUDITED_STATUS.Value=4 then
begin
 OpenQuery(dm.ADOQuery1,'select employee_name from data0005 where rkey='+dm.ADS85APPRV_BY_PTR.AsString);
 info:=dm.ADOQuery1.FieldValues['employee_name'];
 info:=info+'������:'+dm.ADS85apprv_date.AsString+' �˻�,ԭ������:'+#13+
       dm.ADS85cust_add2.Value;
 showmessage(info);
end
else
 if not dm.ADS85.IsEmpty then
  n4click(sender);
end;

procedure TForm1.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
begin
 if (dm.ADS85DSDesigner2.Value='���˻�') then
  DBGrid1.Canvas.Font.Color := clred
 else
  if (dm.ADS85DSDesigner2.Value='������') then
   DBGrid1.Canvas.Font.Color := cllime
  else
   if (dm.ADS85DSDesigner2.Value='�ѹ���') then
    DBGrid1.Canvas.Font.Color := claqua;

  DBGrid1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TForm1.DBGridEh1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if (chr(key)='V') and (ssalt in shift) then
  showmessage(dm.ADs85.CommandText);
end;

procedure TForm1.DBGridEh1TitleClick(Column: TColumnEh);
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

procedure TForm1.DBGrid1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  if Button=mbRight then
    if DBGrid1.SelectedRows.Count<=1 then
    begin
      DBGrid1.SelectedRows.Clear;
      DBGrid1.SelectedRows.CurrentRowSelected:=True;
    end;
end;

end.
