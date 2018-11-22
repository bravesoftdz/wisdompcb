unit frm_mian_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Grids, DBGrids, StdCtrls, Buttons,common, ComCtrls,
  DB, ADODB, DBGridEh, Menus;

type
  Tfrm_main = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    Panel2: TPanel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn6: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    DBGrid1: TDBGrid;
    TabSheet2: TTabSheet;
    btn_save: TBitBtn;
    btn_audit: TBitBtn;
    btn_NoAudit: TBitBtn;
    qry_Main: TADOQuery;
    ds: TDataSource;
    qry_MainYearMonth: TStringField;
    qry_Mainremark: TStringField;
    qry_MainODate: TDateTimeField;
    qry_Mainstatus: TIntegerField;
    qry_Mainrkey: TAutoIncField;
    qry_Mainstatus2: TStringField;
    qry_Mainoperator: TStringField;
    PopupMenu1: TPopupMenu;
    N_del: TMenuItem;
    DBGrid2: TDBGrid;
    fltfld_Maindays: TFloatField;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure btn_saveClick(Sender: TObject);
    procedure btn_auditClick(Sender: TObject);
    procedure btn_NoAuditClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure N_delClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_main: Tfrm_main;

implementation

uses damo;

{$R *.dfm}

procedure Tfrm_main.BitBtn1Click(Sender: TObject);
begin
self.Close;
end;

procedure Tfrm_main.FormCreate(Sender: TObject);
begin

//    user_ptr:='3'; //��ԱID
//   vprev:='4';    //Ȩ��
//   rkey73:='3062';   //



  if not app_init(dm.ADOConnection1) then
  begin
    common.ShowMsg('��������ʧ��,����ϵϵͳ����Ա',1);
    application.Terminate;
  end;




   
    self.Caption :=Application.Title;
    //damo.people_right:=strtoint(vprev);//Ȩ��
    //damo.op_people:=strtoint(user_ptr);//��ǰ����Ա
    dm.ADOConnection1.Open;

   DateSeparator := '-';
   ShortDateFormat := 'yyyy-mm-dd';
   if dm.ADOConnection1.Connected then
      dm.ADOQuery1.Active :=true;
end;

procedure Tfrm_main.BitBtn2Click(Sender: TObject);
begin
if strtoint(vprev)  in [1,3] then
begin
showmessage('û�п�дȨ��');
exit;
end;
bitbtn2.Enabled := false;
dm.ADOTMP.SQL.Text :='insert into salarycheck(checkyearmonth) '+
  ' select   '+
  ' substring(convert(nvarchar(20), '+
  ' dateadd(month,1,(max(checkyearmonth)+'+#39+'-01'+#39+')), '+
  ' 120),1,7) from salarycheck  ';
dm.ADOTMP.ExecSQL;
dm.ADOQuery1.Active := false;
dm.ADOQuery1.Active := true;
dm.ADOQuery1.Last;
dm.ADOQuery1.Sort := 'checkyearmonth';
bitbtn2.Enabled := true;

end;

procedure Tfrm_main.BitBtn3Click(Sender: TObject);
var str_yearmonth :string;
begin
  if strtoint(vprev)  in [1,3] then
  begin
  showmessage('û�п�дȨ��');
  exit;
  end;
  if dm.ADOQuery1ischeck.Value = 1 then
  begin
  showmessage('�������ظ����');
  exit;
  end;
  str_yearmonth := dm.ADOQuery1checkyearmonth.Value;
  dm.ADOTMP.SQL.Clear;
  dm.ADOTMP.SQL.Text :=' update salarycheck '+
    ' set ischeck=1,checkman='+user_ptr+',checkdate=getdate(),checkdesc='+#39+#39+
    ' from salarycheck '+
    ' where ischeck=0 and checkyearmonth='+#39+str_yearmonth+#39 ;
  dm.ADOTMP.ExecSQL;
  dm.ADOQuery1.Active := false;
  dm.ADOQuery1.Active := true;
  dm.ADOQuery1.Locate('checkyearmonth',str_yearmonth,[]);
end;

procedure Tfrm_main.BitBtn6Click(Sender: TObject);
var str_yearmonth :string;
begin
  if strtoint(vprev)  in [1,2,3] then
  begin
  showmessage('û�п�дȨ��');
  exit;
  end;
  if dm.ADOQuery1ischeck.Value = 0 then
  begin
  showmessage('δ���״̬�����Է����');
  exit;
  end;
  str_yearmonth := dm.ADOQuery1checkyearmonth.Value;
  dm.ADOTMP.SQL.Clear;
  dm.ADOTMP.SQL.Text :=' update salarycheck '+
    ' set ischeck=0,checkman='+user_ptr+',checkdate=getdate(),checkdesc='+#39+'�����'+#39+
    ' from salarycheck '+
    ' where ischeck=1 and checkyearmonth='+#39+str_yearmonth+#39 ;
  dm.ADOTMP.ExecSQL;
  dm.ADOQuery1.Active := false;
  dm.ADOQuery1.Active := true;
  dm.ADOQuery1.Locate('checkyearmonth',str_yearmonth,[]);
end;

procedure Tfrm_main.BitBtn4Click(Sender: TObject);
var str_yearmonth :string;
begin
  if strtoint(vprev)  in [1,3] then
  begin
  showmessage('û�п�дȨ��');
  exit;
  end;
  if dm.ADOQuery1ischeck.Value = 1 then
  begin
  showmessage('����˵Ĺ����·ݲ����Լ���');
  exit;
  end;
  str_yearmonth := dm.ADOQuery1checkyearmonth.Value;
  dm.ADOTMP.SQL.Clear;
  dm.ADOTMP.SQL.Text :=' update salarycheck '+
    ' set actived=1 '+
    ' from salarycheck '+
    ' where actived=0 and checkyearmonth='+#39+str_yearmonth+#39 ;
  dm.ADOTMP.ExecSQL;
  dm.ADOTMP.SQL.Clear;
  dm.ADOTMP.SQL.Text :=' update salarycheck '+
    ' set actived=0 '+
    ' from salarycheck '+
    ' where actived=1 and checkyearmonth<>'+#39+str_yearmonth+#39 ;
  dm.ADOTMP.ExecSQL;
  dm.ADOQuery1.Active := false;
  dm.ADOQuery1.Active := true;
  dm.ADOQuery1.Locate('checkyearmonth',str_yearmonth,[]);
end;
      
procedure Tfrm_main.BitBtn5Click(Sender: TObject);
var str_yearmonth :string;
begin
  if strtoint(vprev)  in [1,3] then
  begin
  showmessage('û�п�дȨ��');
  exit;
  end;
  if dm.ADOQuery1actived.Value = 0 then
  begin
  showmessage('δ������·ݲ����Գ�ʼ��');
  exit;
  end;
  bitbtn5.Enabled := false;
  str_yearmonth := dm.ADOQuery1checkyearmonth.Value;
  dm.ADOTMP.SQL.Clear;
  dm.ADOTMP.SQL.Text :=' exec dbo.hrsp_InitWage '+#39+str_yearmonth+#39  ;
  dm.ADOTMP.ExecSQL;
  dm.ADOTMP.SQL.Clear;
  showmessage('��ʼ�����');
  bitbtn5.Enabled := true;
end;

procedure Tfrm_main.btn_saveClick(Sender: TObject);
begin

    if strtoint(vprev)  in [1,3] then
    begin
    showmessage('û�п�дȨ��');
    exit;
    end;

   if  qry_Main.IsEmpty  then exit;
    if qry_main.fieldbyname('status').asinteger=1  then
     begin
     ShowMessage('����˲����޸�!');
     exit;
     end;

    qry_main.Append;
     
    qry_Main.UpdateBatch(arall);
    qry_Main.Requery;
    qry_Main.Last;


end;

procedure Tfrm_main.btn_auditClick(Sender: TObject);
var
 rkey: integer;
 ssql: string;
 bk: Tbookmark;
begin
  if strtoint(vprev)  in [1,3] then
  begin
  showmessage('û�п�дȨ��');
  exit;
  end;

 if   qry_Main.IsEmpty then exit;
   bk:=qry_Main.GetBookmark;
  rkey:= qry_main.fieldbyname('rkey').asinteger;
  if qry_main.fieldbyname('status').asinteger=1  then  exit;

  ssql:= ' update overworkset  set status=1 , ODate= getdate(), oper_id='+user_ptr+'  where rkey='+inttostr(rkey)+'';

  try
  execsql(dm.ADOTMP,ssql);
  qry_Main.close;
    qry_main.open;
    qry_Main.GotoBookmark(bk);
 // showmessage('��˳ɹ���');  
 except on e:exception do
 begin
 ShowMessage('����'+e.Message);
 exit;
 end;
 end;
end;

procedure Tfrm_main.btn_NoAuditClick(Sender: TObject);
var
 rkey: integer;
 ssql: string;
 bk: Tbookmark;
begin
 if strtoint(vprev)  in [1,3] then
  begin
  showmessage('û�п�дȨ��');
  exit;
  end;



 if   qry_Main.IsEmpty then exit;
      bk:=qry_Main.GetBookmark;
  rkey:= qry_main.fieldbyname('rkey').asinteger;
  if qry_main.fieldbyname('status').asinteger=0  then  exit;

  ssql:= ' update overworkset  set status=0 , ODate=getdate(), oper_id='+user_ptr+' ,remark=''�����''  where rkey='+inttostr(rkey)+'';

  //ShowMessage(ssql);
  try
  execsql(dm.ADOTMP,ssql);

  qry_Main.Requery;
  qry_Main.GotoBookmark(bk);
   // qry_main.open;
 except on e:exception do
 begin
 ShowMessage('����'+e.Message);
 exit;
 end;
 end;
end;

procedure Tfrm_main.FormShow(Sender: TObject);
begin
 if not  qry_main.active  then  qry_main.Open;
end;

procedure Tfrm_main.N_delClick(Sender: TObject);
var  ssql: string;
begin

 if qry_main.IsEmpty  then exit;

 try
 ssql:=' delete from overworkset  where rkey= '+inttostr(qry_Main.fieldbyname('rkey').asinteger)+' ';
 ExecSql(dm.ADOTMP,ssql);
 except on e:exception do
 begin
 ShowMessage('����'+e.Message);
 exit;
 end;
end;


 qry_Main.Requery;
 qry_Main.Last;

end;

end.
