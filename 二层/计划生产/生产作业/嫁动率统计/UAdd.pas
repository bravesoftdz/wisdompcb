unit UAdd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Menus, Grids, DBGridEh, StdCtrls, Buttons, DB, ADODB,DateUtils,
  ComCtrls;

type
  TFrmAdd = class(TForm)
    Panel1: TPanel;
    pnl1: TPanel;
    btnSave: TBitBtn;
    btnCancel: TBitBtn;
    btnLoad: TBitBtn;
    btnCalcutlate: TBitBtn;
    btnExport: TBitBtn;
    pnl2: TPanel;
    pnl3: TPanel;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    lbl7: TLabel;
    lbl8: TLabel;
    edt_BillNo: TEdit;
    edt_RTime: TEdit;
    edt_Process: TEdit;
    edt_TTime: TEdit;
    mmo1: TMemo;
    cbb_WH: TComboBox;
    btn_selProcess: TBitBtn;
    pnl4: TPanel;
    dbgrdh1: TDBGridEh;
    pnl5: TPanel;
    lbl9: TLabel;
    lbl10: TLabel;
    pm1: TPopupMenu;
    nOpen: TMenuItem;
    nEdit: TMenuItem;
    ds1: TDataSource;
    qry_ZK: TADOQuery;
    qry_LS: TADOQuery;
    qry_LB: TADOQuery;
    qry1: TADOQuery;
    btn_comp: TButton;
    qry_save: TADOQuery;
    atncfld_saverkey: TAutoIncField;
    strngfld_saveSubNo: TStringField;
    strngfld_saveWorkNO: TStringField;
    intgrfld_savePID: TIntegerField;
    intgrfld_savePQty: TIntegerField;
    dtmfld_saveODate: TDateTimeField;
    intgrfld_saveStackNum: TIntegerField;
    intgrfld_saveTTIme: TIntegerField;
    lbl11: TLabel;
    edt_TOEE: TEdit;
    Label1: TLabel;
    lbl12: TLabel;
    lbl13: TLabel;
    lbl14: TLabel;
    qry_main: TADOQuery;
    atncfld_mainrkey: TAutoIncField;
    strngfld_mainSubNo: TStringField;
    strngfld_mainWorkNO: TStringField;
    intgrfld_mainPID: TIntegerField;
    intgrfld_mainPQty: TIntegerField;
    dtmfld_mainODate: TDateTimeField;
    intgrfld_mainStackNum: TIntegerField;
    intgrfld_mainTTIme: TIntegerField;
    strngfld_maindept_code: TStringField;
    strngfld_maindept_name: TStringField;
    strngfld_mainmanu_part_number: TStringField;
    fltfld_mainRTime: TFloatField;
    fltfld_saveRTime: TFloatField;
    lbl15: TLabel;
    edt_ATTime: TEdit;
    dtp1: TDateTimePicker;
    dtp2: TDateTimePicker;
    edt_BDate: TDateTimePicker;
    edt_EDate: TDateTimePicker;
    qry_NoCT: TADOQuery;
    ds_NoCT: TDataSource;
    dbgrdh_NoCT: TDBGridEh;
    strngfld_NoCTDSDesigner: TStringField;
    strngfld_NoCTDSDesigner2: TStringField;
    strngfld_NoCTDSDesigner3: TStringField;
    strngfld_NoCTDSDesigner4: TStringField;
    procedure FormShow(Sender: TObject);
    procedure btn_selProcessClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure btnExportClick(Sender: TObject);
    procedure btnLoadClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCalcutlateClick(Sender: TObject);
    procedure btn_compClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edt_BDateExit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure edt_BDateChange(Sender: TObject);
    procedure edt_EDateChange(Sender: TObject);

  private
    { Private declarations }
    Psql:string;
    comp:integer;
    function IfExits(adate: string; wh: Integer; CID: Integer):Boolean;
  public
    { Public declarations }
  end;

var
  FrmAdd: TFrmAdd;

implementation
      uses UDM,common,Pick_Item_Single,ConstVar, UMain;
{$R *.dfm}

procedure TFrmAdd.FormShow(Sender: TObject);
var
  ssql: string;
begin
 try

   ssql:='select rkey,abbr_name from data0015';
   dm.openqry(dm.qry_temp,ssql);
   if not dm.qry_temp.isempty then
   begin
      with dm.qry_temp do
      begin
       First;
       cbb_WH.Items.Clear;
       while not eof do
       begin
       cbb_WH.Items.AddObject(fieldbyname('abbr_name').AsString,TObject(fieldbyname('rkey').AsInteger));
       Next;
       end;
      end;
   end;


     if DM.PFLag<>1 then //  ������
     begin

       with qry_Main do
       begin
       close;
       Parameters.ParamByName('subno').value:=dm.PBNo;
       open;
       end;

       if not qry_save.active then qry_save.open;

       ssql:='select a.*, b.rkey as rkey2, b.cname '+
             ' from data0582 a       '+
             ' inner join data0578 b on a.cid=b.rkey '+
             ' where  a.Bno='''+dm.PBno+''' ';

      dm.openqry(dm.qry_temp,ssql);

      edt_Process.Text:=dm.qry_temp.fieldbyname('cname').AsString;
      edt_Process.tag:= dm.qry_temp.fieldbyname('rkey2').AsInteger;
      edt_BillNo.Text:=dm.PBNo;
      edt_BDate.date:= dm.qry_temp.fieldbyname('BDate').AsDateTime;
      edt_EDate.date:= dm.qry_temp.fieldbyname('EDate').AsDateTime;
      edt_TTime.text:=dm.qry_temp.fieldbyname('ATTime2').value;

      edt_RTime.text:=dm.qry_temp.fieldbyname('ARTime').value;
      edt_ATTime.text:=dm.qry_temp.fieldbyname('ATTime').value;
      edt_TOEE.text:=dm.qry_temp.fieldbyname('WTRate').value;
      self.mmo1.text:=dm.qry_temp.fieldbyname('remark').value;

      cbb_wh.ItemIndex:=cbb_wh.Items.IndexOfObject(TObject(dm.qry_temp.Fieldbyname('whcode').AsInteger));

     end;


  if DM.PFLag=1 then
  begin
     with qry_Main do
       begin
       close;
       Parameters.ParamByName('subno').value:='-1';
       open;
       end;

       if not qry_save.active then qry_save.open;

      ds1.AutoEdit:=true;
      edt_Process.Enabled:=True;
      edt_BillNo.Enabled:=True;
      edt_BDate.Enabled:=True;
      edt_EDate.Enabled:=True;
      dtp1.Enabled:=True;
      dtp2.Enabled:=True;
      edt_TTime.Enabled:=True;
      edt_RTime.Enabled:=True;
      self.mmo1.Enabled:=true;
      cbb_wh.Enabled:=true;

      btnSave.Enabled:=true;
      btnCancel.Enabled:=true;
      btnLoad.Enabled:=true;
      btnCalcutlate.Enabled:=true;
      btnExport.Enabled:=true;
      btn_comp.Enabled:=true;
      btn_selProcess.Enabled:=true;

     edt_BDate.date:= now-1; // formatdatetime('yyyy-MM-dd',IncDay(now,-1)) ;
   edt_EDate.date:= Now; // formatdatetime('yyyy-MM-dd',now) ;
   edt_BillNo.Text:= formatdatetime('yyyyMMddhhmmss',now)   ;

  end
  else  if DM.PFLag=2 then   // �༭
  begin

      ds1.AutoEdit:=true;
      edt_Process.Enabled:=false;
      edt_BillNo.Enabled:=false;
      edt_BDate.Enabled:=false;
      edt_EDate.Enabled:=false;
         dtp1.Enabled:=false;
      dtp2.Enabled:=false;

      edt_TTime.Enabled:=false;
      edt_RTime.Enabled:=false;
      self.mmo1.Enabled:=false;
      cbb_wh.Enabled:=false;

      btnSave.Enabled:=true;
      btnCancel.Enabled:=true;
      btnLoad.Enabled:=true;
      btnCalcutlate.Enabled:=true;
      btnExport.Enabled:=true;
      btn_comp.Enabled:=true;
      btn_selProcess.Enabled:=false;

  end
    else  if DM.PFLag=3 then   // �鿴 
  begin

      ds1.AutoEdit:=false;
      edt_Process.Enabled:=false;
      edt_BillNo.Enabled:=false;
      edt_BDate.Enabled:=false;
      edt_EDate.Enabled:=false;
      dtp1.Enabled:=false ;
      dtp2.Enabled:=false;
      edt_TTime.Enabled:=false;
      edt_RTime.Enabled:=false;
      self.mmo1.Enabled:=false;
      cbb_wh.Enabled:=false;

      btnSave.Enabled:=false;
     // btnCancel.Enabled:=false;
      btnLoad.Enabled:=false;
      btnCalcutlate.Enabled:=false;
     // btnExport.Enabled:=false;
      btn_comp.Enabled:=true;
      btn_selProcess.Enabled:=false;

  end

 except on e:exception do
 begin
 ShowMessage('����'+e.Message);
 exit;
 end;
 end;

end;

procedure TFrmAdd.btn_selProcessClick(Sender: TObject);
var
  InputVar:PDlgInput;
begin
  frmPick_Item_Single:=TfrmPick_Item_Single.Create(nil);
  try
//    InputVar.Fields := 'rkey/ID/100,CName/�޶�������/250,TTIme/��Ч����ʱ��/180,WARate';
    InputVar.Fields := 'rkey/ID/100,CName/�޶�������/250,TTIme/��Ч����ʱ��/180,WARate/��Ŀ��OEE/120';
    InputVar.Sqlstr := 'select rkey,CName,TTIme,WARate from data0578';
    Inputvar.KeyField:='rkey';
    InputVar.AdoConn := dm.con1 ;
    frmPick_Item_Single.InitForm_New(InputVar);
    if frmPick_Item_Single.ShowModal=mrok then
    begin
      edt_Process.Text:= frmPick_Item_Single.adsPick.fieldbyname('CName').AsString;
      edt_TTime.text:= frmPick_Item_Single.adsPick.fieldbyname('TTIme').AsString;
      edt_TOEE.text:= frmPick_Item_Single.adsPick.fieldbyname('WARate').AsString;
      edt_Process.Tag:=frmPick_Item_Single.adsPick.fieldbyname('rkey').AsInteger;
    end;
  finally
    frmPick_Item_Single.Free;
  end;

  if not  qry_Main.IsEmpty  then
   begin
     with qry_Main do
     begin
     close;
     Parameters.ParamByName('subno').value:='-1';
     open;
     end;
   end;
    edt_BillNo.Text:= formatdatetime('yyyyMMddhhmmss',now)  ;

end;

procedure TFrmAdd.btnCancelClick(Sender: TObject);
begin
 close;
end;

procedure TFrmAdd.btnExportClick(Sender: TObject);
begin
 if  not qry_main.IsEmpty then
    if MessageDlg('��ȷ��Ҫ����������',mtInformation, [mbYes,mbNo],0)= mryes then
       Export_dbGridEH_to_Excel(dbgrdh1,'��ֵ��ϸ');
end;

procedure TFrmAdd.btnLoadClick(Sender: TObject);
var
  ssql,str_zk,str_ls,str_lb,Dstr:  string;
begin
//  if  comp=0 then
//  begin
//   showmessage('���ȱȶԹ���CTʱ��!');
//  exit;
//  end;

  screen.Cursor:=crHourGlass;
 if Trim(edt_Process.Text)='' then
 begin
 ShowMessage('���ղ���Ϊ�գ�');
  btn_selProcess.Focused;
  screen.Cursor:=crDefault;
 exit;
 end;
 if cbb_WH.Text='' then
 begin
 ShowMessage('��ѡ�񹤳���');
 cbb_WH.Focused;
 screen.Cursor:=crDefault;
 exit;
 end;

// if (Trim(edt_BDate.Text)='') or (Trim(edt_EDate.Text)='') then
// begin
// ShowMessage('��ʼ�ͽ������ڲ���Ϊ�գ�');
// screen.Cursor:=crDefault;
// exit;
// end;

 if not  qry_Main.IsEmpty  then
   begin
     with qry_Main do
     begin
     close;
     //Parameters.Clear;
     Parameters.ParamByName('subno').value:='-1';
     open;
     //requery;
     end;
   end;



   try
     qry1.close;
    qry1.sql.clear;
  if edt_Process.Text='��׼޶���' then
   qry1.sql.text:=qry_ZK.sql.text
   else if edt_Process.Text='����޶���' then
   qry1.sql.text:=qry_LS.sql.text
   else  if edt_Process.Text='�෿�޶���' then
   qry1.sql.text:=qry_LB.sql.text ;
//
 //  ShowMessage(qry1.SQL.Text);
   if edt_Process.Text='����޶���' then
   begin

   qry1.Parameters[0].Value:=edt_Process.Tag;
   qry1.Parameters[1].Value:=edt_Process.Tag;
   qry1.Parameters[2].Value:=strtodatetime( formatdatetime('yyyy-mm-dd ',edt_BDate.Date)+  formatdatetime('hh:mm:ss',dtp1.DateTime)) ;
   qry1.Parameters[3].Value:=strtodatetime( formatdatetime('yyyy-mm-dd ',edt_EDate.Date)+  formatdatetime('hh:mm:ss',dtp2.DateTime)) ;
   qry1.Parameters[4].Value:=Integer(cbb_WH.Items.Objects[cbb_WH.ItemIndex]);
   qry1.Parameters[5].Value:=edt_Process.Tag;
    //showmessage(qry1.sql.text);
   qry1.open;
   end
   else
   begin
   qry1.Parameters[0].Value:=edt_Process.Tag;
   qry1.Parameters[1].Value:=strtodatetime( formatdatetime('yyyy-mm-dd ',edt_BDate.Date)+  formatdatetime('hh:mm:ss',dtp1.DateTime)) ;
   qry1.Parameters[2].Value:=strtodatetime( formatdatetime('yyyy-mm-dd ',edt_EDate.Date)+  formatdatetime('hh:mm:ss',dtp2.DateTime)) ;
   qry1.Parameters[3].Value:=Integer(cbb_WH.Items.Objects[cbb_WH.ItemIndex]);
   qry1.Parameters[4].Value:=edt_Process.Tag;

    // showmessage(qry1.sql.text);
   qry1.open;
   end;


  if qry1.IsEmpty then
  begin
  ShowMessage('�����ϣ�');
  screen.Cursor:=crDefault;
  exit;
  end;

  //showmessage('true1');
  //�жϵ���582�Ƿ����в�����¼
  Dstr:= formatdatetime('yyyy-mm-dd ',edt_BDate.Date)+ formatdatetime('hh:mm:ss',dtp1.DateTime);
  if  IfExits(Dstr,Integer(cbb_WH.Items.Objects[cbb_WH.ItemIndex]),edt_Process.tag)=true then
  begin

   if MessageDlg('���������Ѷ�ȡ��Ҫ���¶�ȡ��ɾ��ԭ���ģ�����ɾ����ȡ��',mtInformation, [mbYes,mbNo],0)= mryes then
   begin
   ssql:=' delete from data0583 where subno='''+trim(edt_billno.Text)+'''   ';
   dm.execsql(dm.qry_temp,ssql);
   end
   else
   begin
   screen.Cursor:=crDefault;
   exit;
   end;
   end ;


  qry1.First;
  while not qry1.Eof do
  begin
  qry_Main.Append;
  qry_Main.FieldByName('subno').AsString:=Trim(edt_BillNo.Text);
  //showmessage(Trim(edt_BillNo.Text));
  qry_Main.FieldByName('workno').AsString:=qry1.FieldByName('WORK_ORDER_NUMBER').AsString;
  qry_Main.FieldByName('manu_part_number').AsString:=qry1.FieldByName('manu_part_number').AsString;
  qry_Main.FieldByName('PID').AsInteger:=qry1.FieldByName('FM_DEPT_PTR').asinteger;
  qry_Main.FieldByName('dept_code').AsString:=qry1.FieldByName('dept_code').AsString;
  qry_Main.FieldByName('dept_name').AsString:=qry1.FieldByName('dept_name').AsString;
  qry_Main.FieldByName('Pqty').AsInteger:=qry1.FieldByName('PANELS').AsInteger;
  qry_Main.FieldByName('odate').AsDateTime:=qry1.FieldByName('outtime').AsDateTime;
  qry_Main.FieldByName('stackNum').AsInteger:=qry1.FieldByName('stackNum').asinteger;
  qry_Main.FieldByName('TTime').AsInteger:=qry1.FieldByName('Ttime').asinteger;
  qry_Main.FieldByName('RTime').AsInteger:=qry1.FieldByName('RTime').asinteger;
  qry_Main.post;

  qry_save.Append;
  qry_save.FieldByName('subno').AsString:=Trim(edt_BillNo.Text);    //qry1.FieldByName('subno').value
  qry_save.FieldByName('workno').AsString:=qry1.FieldByName('WORK_ORDER_NUMBER').asstring;
   //qry_save.FieldByName('manu_part_number').AsString:=qry1.FieldByName('manu_part_number').AsString;
  qry_save.FieldByName('PID').AsInteger:=qry1.FieldByName('FM_DEPT_PTR').asinteger;
  qry_save.FieldByName('Pqty').AsInteger:=qry1.FieldByName('PANELS').AsInteger;
  qry_save.FieldByName('odate').AsDateTime:=qry1.FieldByName('outtime').AsDateTime;
  qry_save.FieldByName('stackNum').AsInteger:=qry1.FieldByName('stackNum').asinteger;
  qry_save.FieldByName('TTime').AsInteger:=qry1.FieldByName('Ttime').asinteger;
  qry_save.FieldByName('RTime').AsInteger:=qry1.FieldByName('RTime').asinteger;
  qry_save.post;

  qry1.next;
  end;



 screen.Cursor:=crDefault;
 showmessage('��ȡ���!');
  except on e:exception do
   begin
   ShowMessage('����'+e.Message);
    screen.Cursor:=crDefault;
   exit;
   end;
   end;

end;

function TFrmAdd.IfExits(adate: string; wh: Integer; CID: integer):Boolean;
var
  ssql:  string;
begin
  result:=true;
  ssql:='select Bno from data0582 where  BDate='''+adate+'''  and whcode='+inttostr(wh)+'  and cid='+inttostr(cid)+' ';
 //ShowMessage(ssql);
  dm.OpenQry(dm.qry_temp,ssql);
  if dm.qry_temp.IsEmpty then
   result:=False;

end;

procedure TFrmAdd.btnSaveClick(Sender: TObject);
var
  ssql:  string;
begin
 if Trim(edt_Process.Text)='' then
 begin
 ShowMessage('���ղ���Ϊ�գ�');
  btn_selProcess.Focused;
 exit;
 end;
 if cbb_WH.Text='' then
 begin
 ShowMessage('��ѡ�񹤳���');
 cbb_WH.Focused;
 exit;
 end;



 if trim(edt_RTime.text)='' then
 begin
 ShowMessage('���ȼ���ʵ������ʱ�䣡');
 edt_RTime.Focused;
 exit;
 end;


   with dm.con1 do
   begin
    try
    dm.con1.BeginTrans;
    
    if (dm.PFLag=1) and (not qry_main.IsEmpty) then
    begin
    //����save:
    ssql:=' insert into data0582(BNo, CID, WHCode, BDate, EDate, ATTime, ARTime, ADate, AMan, remark,WTRate,ATTime2)'+
          ' values('''+trim(edt_BillNo.Text)+''', '+inttostr(edt_Process.tag)+','''+inttostr(Integer(cbb_WH.Items.Objects[cbb_WH.ItemIndex]))+''', '+
          ' '''+formatdatetime('yyyy-mm-dd ',edt_BDate.Date)+formatdatetime('hh:mm:ss',dtp1.DateTime)+''','''+formatdatetime('yyyy-mm-dd ',edt_EDate.Date)+  formatdatetime('hh:mm:ss',dtp2.DateTime)+''','''+trim(edt_ATTime.text)+''','''+trim(edt_RTime.text)+''', '+
          ' '''+formatdatetime('yyyy-MM-dd HH:MM:SS',now)+''','+rkey73+','''+trim(mmo1.text)+''', '+trim(edt_TOEE.text)+' ,'+trim(edt_TTime.text)+')';
    //showmessage(ssql);
    dm.ExecSql(DM.qry_temp,ssql);
    end;

    //�ӱ�
    if  (not qry_main.IsEmpty)   then 
    qry_save.UpdateBatch(arAll);
    
    dm.con1.CommitTrans;

     if MessageDlg('����ɹ���  ����Ҫ���������',mtInformation, [mbYes,mbNo],0)= mryes then
     begin
       with qry_Main do
       begin
       close;
       Parameters.ParamByName('subno').value:='-1';
       open;
      // requery;
       //if qry_Main.IsEmpty then
      // ShowMessage('test');
       end;
     end
     else
     begin
       frmmain.qry_main.requery;
     Self.close;
     end;
    except on e:exception do
    begin
    dm.con1.RollbackTrans;
    ShowMessage('����'+e.message);
    exit;
    end;
    end;
   end;



end;

//�������ۺ�ʵ����Ч����ʱ��
procedure TFrmAdd.btnCalcutlateClick(Sender: TObject);
var
  ssql:  string;
  TTIME,RTime: integer;
begin
  Screen.Cursor:=crHourGlass;
 if Trim(edt_Process.Text)='' then
 begin
 ShowMessage('���ղ���Ϊ�գ�');
  btn_selProcess.Focused;
 exit;
 end;
 if cbb_WH.Text='' then
 begin
 ShowMessage('��ѡ�񹤳���');
 cbb_WH.Focused;
 exit;
 end;



 if qry_main.isempty then
 begin
 showmessage('���ȶ�ȡ���ݣ�');
 exit
 end;
  TTIME:=0 ;
  RTime:=0 ;

 qry_main.first;
 qry_Main.DisableControls ;
 while not qry_main.eof do
 begin
  TTime:=TTime+qry_main.fieldbyname('TTime').asinteger;
  RTime:=RTime+qry_main.fieldbyname('RTime').asinteger;
  qry_main.next;
 end;

edt_ATTime.text:=inttostr(TTime);
edt_RTime.text:=inttostr(RTime);

    Screen.Cursor:=crDefault;
   qry_Main.EnableControls; 

end;



procedure TFrmAdd.FormCreate(Sender: TObject);
begin


    comp:=0;
end;


procedure TFrmAdd.edt_BDateExit(Sender: TObject);
begin
   if not  qry_Main.IsEmpty  then
   begin
     with qry_Main do
     begin
     close;
     Parameters.ParamByName('subno').value:='-1';
     open;
     end;
   end;
   comp:=0;

   edt_BillNo.Text:= formatdatetime('yyyyMMddhhmmss',now)  ;
end;


procedure TFrmAdd.btn_compClick(Sender: TObject);
var
  ssql:string;
begin
//ShowMessage('�����ȹرմ˹��ܣ�');
//comp:=1;
//exit;

  try
  ssql:=' select distinct d578.cname as �޶�������, d25.MANU_PART_NUMBER as �������,d34.dept_code as ������,d34.dept_name as ��������  '+   //d25.rkey as prodno,d34.rkey as PID,d25.layers, d578.rkey as cid,
  ' FROM dbo.Data0048 d48 '+
  ' INNER JOIN  dbo.Data0006 d6 ON d48.WO_PTR = d6.RKEY '+
  ' inner join  data0034 d34  on d48.FM_DEPT_PTR=d34.rkey     '+
  ' INNER JOIN dbo.Data0025 d25 ON d6.BOM_PTR = d25.RKEY '+
  ' inner join data0579  d579   on d579.pid=d34.rkey '+
  ' inner join data0578 d578  on d578.rkey=d579.cid '+
  ' WHERE   D48.OUTTIME >= '''+(formatdatetime('yyyy-mm-dd ',edt_BDate.Date)+formatdatetime('hh:mm:ss',dtp1.DateTime))+'''  AND D48.OUTTIME <= '''+(formatdatetime('yyyy-mm-dd ',edt_EDate.Date)+formatdatetime('hh:mm:ss',dtp2.DateTime))+''' '+
  ' AND D6.wtype <> 3 '+
  ' and cast(d578.rkey as varchar(100))+''-''+ cast(d25.rkey as varchar(100))+''-''+cast(d34.rkey as varchar(100)) '+
  ' not in ( select cast(cid as varchar(100))+''-''+ cast(prodno as varchar(100))+''-''+cast(pid as varchar(100)) from data0581 ) ';
//showmessage(ssql);
dm.OpenQry(qry_NoCT,ssql);

 if not qry_NoCT.IsEmpty then
 begin
 //ShowMessage('�����б�����Ŷ�Ӧ����û��CTʱ��,����¼�룡');
 if MessageDlg('�����б�����Ŷ�Ӧ����û��CTʱ�䣬��Ҫ������',mtInformation, [mbYes,mbNo],0)= mryes then
   Export_dbGridEH_to_Excel(dbgrdh_NoCT,'û¼��CTʱ��ͳ��');
 exit;
 end;


//if not dm.qry_temp.IsEmpty then
// begin
//  if MessageDlg('�����б�����Ŷ�Ӧ����û��CTʱ�䣬�����Զ���ӵ�����CTʱ������Ȼ����¼��CTʱ�䣬��Ҫ�Զ������',mtInformation, [mbYes,mbNo],0)= mryes then
//  begin
//     dm.qry_temp.First;
//     while not dm.qry_temp.Eof do
//     begin
//     ssql:='insert into data0581(cid,prodno,pid,layer,aman,adate)values('+inttostr(dm.qry_temp.fieldbyname('cid').asinteger)+', '+
//     ' '+inttostr(dm.qry_temp.fieldbyname('prodno').asinteger)+','+inttostr(dm.qry_temp.fieldbyname('pid').asinteger)+' ,'+inttostr(dm.qry_temp.fieldbyname('layers').asinteger)+','+rkey73+',getdate())';
//     // showmessage(ssql);
//      dm.execsql(dm.qry_temp2,ssql);
//      dm.qry_temp.Next;
//     end;
//     showmessage('������ɣ���ǰȥ����CTʱ��¼������¼���ӦCTʱ��!' );
//  end  ;
//
// end
// else
// begin
// ShowMessage('��������,���Զ�ȡ���������!');
//  comp:=1;
// end;

 except on e:exception do
 begin
 ShowMessage('����'+e.Message);
 exit;
 end;
 end;


end;

procedure TFrmAdd.FormClose(Sender: TObject; var Action: TCloseAction);
begin
frmmain.qry_main.requery;
end;

procedure TFrmAdd.edt_BDateChange(Sender: TObject);
begin
 edt_BillNo.Text:= formatdatetime('yyyyMMddhhmmss',now)  ;

end;

procedure TFrmAdd.edt_EDateChange(Sender: TObject);
begin
 edt_BillNo.Text:= formatdatetime('yyyyMMddhhmmss',now)  ;

end;

end.
