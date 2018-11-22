unit MainFrm_Mod72;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uBaseMainFrm,ucommfunc, Vcl.Grids,System.Win.ComObj,
  DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls, DynVarsEh, Data.DB,
  Vcl.XPMan, Vcl.Menus, Datasnap.DBClient, Vcl.StdCtrls, Vcl.Buttons, EhLibVCL,
  GridsEh, DBAxisGridsEh, DBGridEh, Vcl.ExtCtrls, PasNewSales2, PasEdit_so,
  PasDeptinfo, PasEdit_note, PasNote_information,System.ZLib,shellapi,
  PasViewCredit, PasSo_report, PasMany_So_report, pasSupplier_report;

type
  Tfrm_MainMod72 = class(TfrmBaseMain)
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    BitBtn8: TBitBtn;
    GroupBox1: TGroupBox;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox6: TCheckBox;
    N3: TMenuItem;  //�ݻ�
    N8: TMenuItem; //���ݻ����ͷ�
    N6: TMenuItem;  //�༭
    n13: TMenuItem;      //�᰸
    n14: TMenuItem;   //�ӽ᰸����
    n7: TMenuItem; //���
    n16: TMenuItem; //�ύ
    n18: TMenuItem;
    n23: TMenuItem;//ȡ���ύ
    n22: TMenuItem;
    N15: TMenuItem;
    N24: TMenuItem;
    N25: TMenuItem;
    N26: TMenuItem;
    cds192: TClientDataSet;
    cds60: TClientDataSet;
    cds90: TClientDataSet;
    N27: TMenuItem;
    cds213: TClientDataSet;
    cds318: TClientDataSet;
    cds117: TClientDataSet;
    cds06: TClientDataSet;
    OpenDialog1: TOpenDialog;
    cds04: TClientDataSet;
    procedure ehMainDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure btnQryClick(Sender: TObject);
    procedure CheckBox6Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure N16Click(Sender: TObject);
    procedure N27Click(Sender: TObject);
    procedure N18Click(Sender: TObject);
    procedure N23Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure N13Click(Sender: TObject);
    procedure N14Click(Sender: TObject);
    procedure N22Click(Sender: TObject);
    procedure N26Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure pmMainPopup(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure ehMainDblClick(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
    procedure N15Click(Sender: TObject);
    procedure N24Click(Sender: TObject);
    procedure N25Click(Sender: TObject);
  private
    dNewDate:TDateTime;
    LGRName:string; //04���º�
    function GetStatusWhere: string;
    function GetCustomerWhere: string;
    procedure pact_auth();
    procedure UnPackStream(var CompressedStream: TMemoryStream);
    procedure Export_Grid_to_Excel(Grid: TStringgrid; title_caption: string;isStr: boolean);
    function ExcelToDB():Boolean;
    function update04(table_name: string; var LsName: string): string;
    function Power(x, y: extended): extended;
    function GetRkeyStr(Acds: TClientDataSet; Afield: string): string;
    { Private declarations }
  public
    { Public declarations }
    procedure GetData;override;
    procedure getRefreshClick(cds:TClientDataSet);
  end;

var
  frm_MainMod72: Tfrm_MainMod72;
const
  TmpFileDir = 'c:\tmp\';

implementation

{$R *.dfm}

{ Tfrm_MainMod72 }
function Tfrm_MainMod72.GetRkeyStr(Acds: TClientDataSet;
  Afield: string): string;
begin
  result := '';
  if Acds.IsEmpty then
    exit;

  Acds.First;
  while not Acds.Eof do
  begin
    result := result + Acds.FieldByName(Afield).asstring + ',';
    Acds.next;
  end;

  result := '(' + result + '-1)';
end;

function Tfrm_MainMod72.Power(x, y: extended): extended;
begin
  result := exp(y*ln(x));
end;

function Tfrm_MainMod72.update04(table_name: string; var LsName: string): string;
var
  i,v_length:integer;
  v_last,v_seed,new_seed:string;
begin
  if not gSvrIntf.IntfGetDataBySql('select * from data0004 where table_name='''+table_name+'''',cds04) then Exit;
  if not cds04.IsEmpty then
  begin
    v_seed:=cds04.FieldByName('SEED_VALUE').AsString;
    LsName:=v_seed;
    if cds04.FieldByName('SEED_FLAG').Value<>1 then
    begin
      v_length := length(v_seed);
      for i := v_length downto 1 do
      if (copy(v_seed,i,1)<'0') or (copy(v_seed,i,1)>'9') then  //�����������
      begin
        v_last := floattostr(power(10,v_length)+strtofloat(copy(v_seed,i+1,v_length-i))+1); //��׺��1
        new_seed := copy(v_seed,1,i)+copy(v_last,i+2,v_length-i); //ʹǰ׺�����׺��1
        break;
      end
      else
      if i=1 then //�����һλ��Ȼ������
        begin
         v_last := floattostr(power(10,v_length)+strtofloat(v_seed)+1);
         new_seed := copy(v_last,2,v_length);
        end;
    end;
  end;
  result:=new_seed;
end;

function Tfrm_MainMod72.ExcelToDB: Boolean;
var XLApp: variant;
    Sheet: Variant;
    fileName:String;
    LSql,LSql10,LSql25,LSql97,LSql23,LSql15,LSql60,Lsql04,Lsql360,lsql2:string;
    LCds,LCds10,LCds25,LCds97,LCds23,LCds15,Lcds60,Lcds04,Lcds360,Lcds97Save,Lcds2,Lcds3:TClientDataSet;
    iCount,PO_NUM97: Integer;
    Rkey25,Rkey23,Rkey15,rkey04,rkey97:string;
    tax_2:Currency;
    dDate:TDateTime;
    LPostData: OleVariant;
begin
  Result:= False;
  if OpenDialog1.Execute then  fileName:=OpenDialog1.FileName else exit;
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
  try
    XLApp.workBooks.Open(fileName);
    Sheet := XLApp.Workbooks[1].WorkSheets[1];
    for iCount:=2 to 65535 do
    begin
      if (trim(XLApp.workbooks[1].sheets[1].cells[iCount,6]) = '') then Break;
      if (trim(XLApp.workbooks[1].sheets[1].cells[iCount,7]) = '') then
      begin
       ShowMessage('�������۵���Ӧ�ı������δ��д���������');
       exit;
      end;
      if (trim(XLApp.workbooks[1].sheets[1].cells[iCount,8]) = '') then
      begin
       ShowMessage('�������۵���Ӧ�Ŀͻ�����δ��д���������');
       exit;
      end;
      if (trim(XLApp.workbooks[1].sheets[1].cells[iCount,9]) = '') then
      begin
       ShowMessage('�������۵���Ӧ���ָⷢ����Ӧ��δ��д���������');
       exit;
      end;
      if (trim(XLApp.workbooks[1].sheets[1].cells[iCount,10]) = '') then
      begin
       ShowMessage('�������۵���Ӧ�Ĺ���δ��д���������');
       exit;
      end;
    end;
    Lsql97:='select * from data0097 where 1=0';
    LSql60 := 'select * from DATA0060 where 1=0';
    Lsql04:='select * from data0004 where table_name=''data0060''';
    Lsql360:='select * from data0360 where 1=0';
    LCds97:= TClientDataSet.Create(nil);
    Lcds60:= TClientDataSet.Create(nil);
    Lcds04:= TClientDataSet.Create(nil);
    Lcds360:= TClientDataSet.Create(nil);
    LCds23:= TClientDataSet.Create(nil);
    LCds15:= TClientDataSet.Create(nil);
    LCds10:= TClientDataSet.Create(nil);
    LCds25:= TClientDataSet.Create(nil);
    LCds:= TClientDataSet.Create(nil);
    Lcds97Save:=TClientDataSet.Create(nil);
    Lcds2:=TClientDataSet.Create(nil);
    lcds3:=TClientDataSet.Create(nil);
    try
      if not gSvrIntf.IntfGetDataBySqlArr(VarArrayOf([Lsql97, LSql60,Lsql04,Lsql360]), [Lcds97Save,Lcds60,Lcds04,Lcds360]) then
      begin
        ShowMessage('�����ݿ�ȡ������ʧ�ܣ�');
        Exit;
      end;
      dDate:=gFunc.GetSvrDateTime();
      LGRName:=update04('data0060',Rkey04);
      for iCount:=2 to 65535 do
      begin
        if (trim(XLApp.workbooks[1].sheets[1].cells[iCount,6]) = '') then Break;
        LSql:='select data0060.*,data0005.EMPLOYEE_NAME from data0060 inner join data0005 '
         +'on data0060.COMM_ASSIGNED_BY_E_P=data0005.rkey where SALES_ORDER='''+Trim(XLApp.workbooks[1].sheets[1].cells[iCount,6])+'''';
        LSql25:='select Rkey from data0025 where MANU_PART_NUMBER='''+trim(XLApp.workbooks[1].sheets[1].cells[iCount,7])+'''';
        LSql10:='select data0010.Rkey,data0012.RKey,data0010.CURRENCY_PTR,data0010.CONTACT_NAME_1,data0001.exch_rate,'
         +'data0012.rkey as Rkey12,data0012.LOCATION,data0012.ship_to_contact,data0012.ship_shipping_method,data0012.ship_to_phone,data0012.SHIP_FOB from data0010 '
         +' inner join data0012 on data0010.Rkey=data0012.CUSTOMER_PTR inner join data0001 on data0010.CURRENCY_PTR=data0001.Rkey '
         +' where data0010.CUST_CODE='''+trim(XLApp.workbooks[1].sheets[1].cells[iCount,8])+''' and data0010.CUSTOMER_TYPE<>4';
        LSql97:='select data0097.Rkey from data0097 inner join data0010 on data0097.CUSTOMER_PTR=data0010.rkey where data0097.PO_NUMBER ='''
        +trim(XLApp.workbooks[1].sheets[1].cells[iCount,2])+''' and data0010.CUST_CODE='''+trim(XLApp.workbooks[1].sheets[1].cells[iCount,8])+'''';
        LSql23:='select Rkey,TAX_2 from data0023 where CODE='''+trim(XLApp.workbooks[1].sheets[1].cells[iCount,9])+'''';
        LSql15:='select Rkey from data0015 where WAREHOUSE_CODE='''+trim(XLApp.workbooks[1].sheets[1].cells[iCount,10])+''' ';

        if not gSvrIntf.IntfGetDataBySqlArr(VarArrayOf([LSql,LSql25,LSql10,LSql97,LSql23,LSql15]), [LCds,LCds25,LCds10,LCds97,LCds23,LCds15]) then
        begin
          ShowMessage('�����ݿ�ȡ������ʧ�ܣ�');
          Exit;
        end;
        if LCds.IsEmpty then
        begin
          MessageDlg('��'+inttostr(iCount)+'�����۶����ڵ���ϵͳ�в�����,��ȷ�����۶����Ƿ����!',mtInformation,[mbok],1);
          Exit;
        end;
        if LCds25.IsEmpty then
        begin
          MessageDlg('��'+inttostr(iCount)+'�б��������ϵͳ�в�����,��ȷ����������Ƿ��ѽ�����!',mtInformation,[mbok],1);
          Continue;
        end;
        Rkey25:=LCds25.FieldByName('Rkey').AsString;
        if LCds10.IsEmpty then
        begin
          MessageDlg('��'+inttostr(iCount)+'�пͻ�������ϵͳ�в�����,��ȷ���ͻ������Ƿ���ȷ!',mtInformation,[mbok],1);
          Continue;
        end;
        PO_NUM97:=0;
        if LCds97.IsEmpty then
        begin
          PO_NUM97:=1;
        end else Rkey97:=LCds97.FieldByName('Rkey').AsString;
        if LCds23.IsEmpty then
        begin
          MessageDlg('��'+inttostr(iCount)+'�й�Ӧ�̴�����ϵͳ�в����ڻ�״̬������,��ȷ���ⷢ��Ӧ�̴����Ƿ���ȷ!',mtInformation,[mbok],1);
          Continue;
        end;
        Rkey23:=LCds23.FieldByName('Rkey').AsString;
        TAX_2:=LCds23.FieldByName('TAX_2').Value;
        if LCds15.IsEmpty then
        begin
          MessageDlg('��'+inttostr(iCount)+'�й�����ϵͳ�в����ڻ�״̬������,��ȷ�����������Ƿ���ȷ!',mtInformation,[mbok],1);
          Continue;
        end;
        Rkey15:=LCds15.FieldByName('Rkey').AsString;
        if (PO_NUM97=1) then
        begin
          Lcds97Save.Append;
          Lcds97Save.FieldByName('po_number').Value:=trim(XLApp.workbooks[1].sheets[1].cells[iCount,2]);
          Lcds97Save.FieldByName('customer_ptr').Value:=LCds10.FieldByName('Rkey').AsString;
          Lcds97Save.FieldByName('po_date').Value:=FormatDateTime('yyyy-MM-dd',dDate);
          Lcds97Save.FieldByName('open_sos').Value:=0;
          Lcds97Save.FieldByName('IDkey').Value:=gFunc.CreateIDKey;
          Lcds97Save.Post;
        end;
        with Lcds60 do
        begin
          append;
          fieldbyname('ship_reg_tax_id').AsString := Rkey15;        //����ָ��
          fieldbyname('customer_ptr').AsString := LCds10.FieldByName('Rkey').AsString;        //�ͻ�ָ��
          fieldbyname('cust_part_ptr').AsString := Rkey25;       //��Ʒ�ͺ�ָ��
          if (PO_NUM97<>1) then
          fieldbyname('purchase_order_ptr').AsString :=Rkey97;  //�ɹ�����ָ��
          fieldbyname('CUST_SHIP_ADDR_PTR').AsString :=LCds10.FieldByName('Rkey12').AsString;  //װ�˵�ַָ��
          fieldbyname('CURRENCY_PTR').AsString :=LCds10.FieldByName('CURRENCY_PTR').AsString;        //��������
          fieldbyname('CUSTOMER_CONTACT').AsString :=LCds10.FieldByName('CONTACT_NAME_1').AsString;        //�ͻ�������
          fieldbyname('EXCH_RATE').AsString :=LCds.fieldbyname('EXCH_RATE').AsString;                   //����
          fieldbyname('SHIPPING_CONTACT').AsString := LCds10.FieldBYName('ship_to_contact').AsString;           //װ��������
          fieldbyname('SHIP_CONTACT_PHONE').AsString := LCds10.FieldBYName('ship_to_phone').AsString;         //װ�������˵绰
          fieldbyname('SHIPPING_METHOD').AsString :=LCds10.FieldBYName('ship_shipping_method').AsString;            //װ�˷���
          fieldbyname('FOB').AsString := LCds10.FieldBYName('ship_fob').AsString;                         //�밶�۸�
          fieldbyname('COD_FLAG').AsString :=LCds.fieldbyname('COD_FLAG').AsString;               //�����տ�
          fieldbyname('reg_tax_fixed_unused').AsString := '0';   //�Ϲ����ü��㷽��
          fieldbyname('CSI_USER_PTR').AsString := gVar.rkey73;      //ϵͳ�û�ָ��
          fieldbyname('ENTERED_BY_EMPL_PTR').AsString := gVar.rkey05; //������Աָ��
          fieldbyname('comm_assigned_by_e_p').AsString := gVar.rkey05;//ӵ��ָ����Ա
          fieldbyname('rush_charge_pct_used').AsString :=LCds.fieldbyname('rush_charge_pct_used').AsString;//�������������깤���ڲ��
          fieldbyname('so_style').AsInteger :=LCds.fieldbyname('so_style').AsInteger;        //�������
          fieldvalues['so_tp'] := 1;                  //�ӹ���ʽ1�ⷢ
          fieldbyname('SO_OLDNEW').AsString :=LCds.fieldbyname('SO_OLDNEW').AsString;     //�����¾�
          fieldbyname('RUSH_CHARGE').AsString :=LCds.fieldbyname('RUSH_CHARGE').AsString;     //��ֵ˰%;

          LSql2:='select D5_2.Rkey from data0005 D5_1 inner join data0005 as D5_2 '
          +'on D5_1.EMPLOYEE_NAME=D5_2.EMPLOYEE_NAME where D5_1.EMPLOYEE_NAME='''+Trim(LCds.fieldbyname('EMPLOYEE_NAME').AsString)+'''';
          gSvrIntf.IntfGetDataBySql(LSql2,Lcds2);
          fieldbyname('COMM_ASSIGNED_BY_E_P').AsString :=Lcds2.FieldBYName('Rkey').AsString;   //ҵ��Ա

          Fieldvalues['SUPPLIER_PTR']:=rkey23;  //�ָⷢ����Ӧ��
          Fieldvalues['TAX_2']:=tax_2;  //�ⷢ��Ӧ�����ɱ�����
          fieldbyname('STATE_PROD_TAX_FLAG').AsString :=LCds.fieldbyname('STATE_PROD_TAX_FLAG').AsString;
           fieldbyname('STATE_TOOL_TAX_FLAG').AsString :=LCds.fieldbyname('STATE_TOOL_TAX_FLAG').AsString;      //�Ƿ�Թ��߷�����˰
           fieldbyname('COMMISION_ON_TOOLING').AsString :=LCds.fieldbyname('COMMISION_ON_TOOLING').AsString;      //�����Ƿ�ת��
           fieldbyname('TAX_IN_PRICE').AsString:=LCds.fieldbyname('TAX_IN_PRICE').AsString;               //�۸��Ƿ�˰

          if (iCount<10) then
            Rkey04:=Rkey04+'0'+inttostr(iCount-1)
          else
            Rkey04:=Rkey04+inttostr(iCount);

          fieldbyname('SALES_ORDER').AsString := Rkey04;     //���۶���;
          fieldbyname('PARTS_ORDERED').AsString :=LCds.fieldbyname('PARTS_ORDERED').AsString;   //����;
          FieldByName('to_be_planned').asstring :=LCds.FieldByName('to_be_planned').asstring;   //�����ƻ�
          FieldByName('to_be_confirmed').asstring := LCds.FieldByName('to_be_confirmed').asstring; //����ȷ��
          fieldbyname('PART_PRICE').AsString :=formatfloat('0.00000000',LCds.fieldbyname('PART_PRICE').Value/0.95);      //�۸�;
          fieldbyname('REFERENCE_NUMBER').AsString :=LCds.fieldbyname('REFERENCE_NUMBER').AsString;      //�ο���ע
          fieldbyname('DISCOUNT').AsString := '0';        //�ۿ�%;
          fieldbyname('P_CODE').AsString :=LCds.fieldbyname('P_CODE').AsString;          //����;
          fieldbyname('ORIG_REQUEST_DATE').AsString :=LCds.fieldbyname('ORIG_REQUEST_DATE').AsString;  //�ͻ�����
          fieldbyname('ORIG_SCHED_SHIP_DATE').AsString :=LCds.fieldbyname('ORIG_SCHED_SHIP_DATE').AsString;//�ƻ�����
          fieldbyname('DUE_DATE').AsString :=LCds.fieldbyname('DUE_DATE').AsString;         //ԭʼ�ͻ�����
          fieldbyname('SCH_DATE').AsString :=LCds.fieldbyname('DUE_DATE').AsString;         //�ͻ�����
          fieldbyname('CONSUME_FORECASTS').AsString := '0';    //Ԥ��ķ�
          fieldbyname('BACKWARD_DAYS').AsString := '0';        //�������
          fieldbyname('FORWARD_DAYS').AsString := '0';         //��ǰ����
          fieldbyname('ANALYSIS_CODE_1').AsString := LCds.fieldbyname('ANALYSIS_CODE_1').AsString;
          fieldbyname('ANALYSIS_CODE_2').AsString := LCds.fieldbyname('ANALYSIS_CODE_2').AsString;
          fieldbyname('ANALYSIS_CODE_3').AsString := LCds.fieldbyname('ANALYSIS_CODE_3').AsString;
          fieldbyname('ANALYSIS_CODE_4').AsString := LCds.fieldbyname('ANALYSIS_CODE_4').AsString;
          fieldbyname('ANALYSIS_CODE_5').AsString := LCds.fieldbyname('ANALYSIS_CODE_5').AsString;
          fieldbyname('set_ordered').AsString := LCds.fieldbyname('set_ordered').AsString;
          fieldbyname('set_price').AsString := LCds.fieldbyname('set_price').AsString;
          fieldbyname('TOTAL_ADD_L_PRICE').AsString := LCds.fieldbyname('TOTAL_ADD_L_PRICE').AsString;    //���߷����ܼ�
          fieldbyname('ent_date').AsString:=FormatDateTime('yyyy-MM-dd HH:mm:ss',dDate);//�������� ϵͳ������ʱ��
          Fieldvalues['status']:=1;      //״̬Ϊδ�ύ(040207�޸�)
          Fieldvalues['prod_rel']:='2';  //�������ű����ȷ�ϵ�
          FieldByName('parts_alloc').AsString :=formatfloat('0.00000000',LCds.FieldByName('parts_alloc').Value/0.95); //����˰�۸�

          fieldvalues['quote_price']:=3;      //��ʾso������
          fieldbyname('RemarkSO').asstring:=LCds.fieldbyname('RemarkSO').asstring; //���۶������±�
          fieldvalues['RemarkAudit']:=LCds.fieldvalues['RemarkAudit']; //������±�
          FieldByName('D97_IDKey').Value:=Lcds97Save.FieldByName('idkey').Value;
          Post;
          //����360
          lcds360.Append;
          lcds360.FieldByName('quantity').Value:=Lcds60.FieldByName('PARTS_ORDERED').Value;
          lcds360.FieldByName('sch_date').Value:=Lcds60.FieldByName('ORIG_SCHED_SHIP_DATE').Value;
          lcds360.FieldByName('D60_IDKey').Value:=Lcds60.FieldByName('idkey').Value;
          lcds360.Post;
        end;
      end;
      //����04
      Lcds04.Edit;
      Lcds04.FieldByName('SEED_VALUE').Value:=LGRName;
      Lcds04.Post;

      if lcds97.State in [dsEdit,dsInsert] then lcds97.Post;
      if Lcds60.State in [dsEdit,dsInsert] then Lcds60.Post;
      if lcds360.State in [dsEdit,dsInsert] then lcds360.Post;
      if lcds04.State in [dsEdit,dsInsert] then lcds04.Post;

      LPostData := VarArrayCreate([0,3],varVariant);
      if (LCds97.ChangeCount > 0) then
        LPostData[0] := lcds97.Delta;
      if (Lcds60.ChangeCount > 0) then
        LPostData[1] := Lcds60.Delta;
      if (lcds360.ChangeCount > 0) then
        LPostData[2] := lcds360.Delta;
      if (lcds04.ChangeCount > 0) then
        LPostData[3] := lcds04.Delta;
//      if gSvrIntf.IntfPostModData('��������',72,LPostData,5) then
      if gSvrIntf.IntfPostDataBySqlArr(VarArrayOf(['data0097','data0060','data0360','data0004']),LPostData,lsql2,'��ݸ����','��������') then
      begin
        if (lcds97.ChangeCount > 0) then LCds97.MergeChangeLog;
        if (Lcds60.ChangeCount > 0) then Lcds60.MergeChangeLog;
        if (lcds360.ChangeCount > 0) then lcds360.MergeChangeLog;
        if (lcds04.ChangeCount > 0) then lcds04.MergeChangeLog;
        Result:=True;
      end;
    finally
//      LCds97:=free;
//      Lcds60:= free;
//      Lcds04:= free;
//      Lcds360:= free;
//      LCds23:= free;
//      LCds15:= free;
//      LCds10:= free;
//      LCds25:= free;
//      LCds:= free;
    end;
  finally
    XLApp.quit;
    Screen.Cursor := crDefault;
  end
end;

procedure Tfrm_MainMod72.Export_Grid_to_Excel(Grid: TStringgrid;
  title_caption: string; isStr: boolean);
var
  iCount, jCount,v_cloumn: Integer;
  XLApp: Variant;
  Sheet: Variant;
begin
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

  XLApp.WorkBooks[1].WorkSheets[1].Name := title_caption;
  Sheet := XLApp.Workbooks[1].WorkSheets[title_caption];
  v_cloumn := 0;
  for iCount := 0 to Grid.ColCount - 1 do
   if Grid.ColWidths[iCount]>0 then
    Sheet.Cells[1, iCount + 1-v_cloumn] := Grid.Cells[icount, 0]
   else
    inc(v_cloumn);

  for jcount := 1 to Grid.RowCount - 1 do
   begin
    v_cloumn := 0;
    for iCount := 0 to Grid.ColCount - 1 do
     if Grid.ColWidths[iCount]>0 then
     begin
       if isStr then  Sheet.Cells[jCount + 1, iCount + 1-v_cloumn].NumberFormatLocal:='@';
       Sheet.Cells[jCount + 1, iCount + 1-v_cloumn] := Grid.Cells[iCount, jcount]
     end else
      inc(v_cloumn);
   end;
  XlApp.Visible := True;
  Screen.Cursor := crDefault;
end;

procedure Tfrm_MainMod72.UnPackStream(var CompressedStream: TMemoryStream);
var
  SourceStream: TDecompressionStream;
  DestStream: TMemoryStream;
  Buffer: PChar;
  Count: integer;
  tmpstr:string;
Begin
  CompressedStream.Position:=0;
  tmpstr:='DDD';
  CompressedStream.ReadBuffer(tmpstr[1], 3);
  if tmpstr<>#6#3#1 then exit; //�ж��Ƿ�ѹ������
  CompressedStream.ReadBuffer(Count, SizeOf(Count));
  GetMem(Buffer, Count);
  DestStream := TMemoryStream.Create;
  SourceStream := TDecompressionStream.Create(CompressedStream);
  Try
    SourceStream.ReadBuffer(Buffer^, Count);
    DestStream.WriteBuffer(Buffer^, Count);
    SourceStream.Free;
    DestStream.Position := 0;//��λ��ָ��
    CompressedStream.LoadFromStream(DestStream);
  finally
    FreeMem(Buffer);
    DestStream.Free;
  end;
end;

procedure Tfrm_MainMod72.GetData;
var lsq192:string;
begin
  FMainFrmSql:= cdsMain.CommandText;
  if Trim(FMainWhere) = '' then
  begin
    dNewDate:= gFunc.GetSvrDateTime;
    FMainWhere:= ' AND Data0060.ent_date BETWEEN ' + QuotedStr(FormatDateTime('YYYY-MM-DD',dNewDate))
          + ' AND ' + QuotedStr(FormatDateTime('YYYY-MM-DD',dNewDate+1));
  end;
  FWhere2:= GetStatusWhere;
  FWhere3:= GetCustomerWhere;
  FOrderby:=' order by Data0060.rkey';
  inherited;
  Lsq192:='select artaxontax,aptaxontax,QTE_control2,ppc_control15,custcitool,'
          +'custciprod,suplcimat,custciship,CUSTCOPROD,CUSTSTAPROD,custcoTool from data0192';
  if not gSvrIntf.IntfGetDataBySql(Lsq192,cds192) then Exit;
end;

procedure Tfrm_MainMod72.getRefreshClick(cds: TClientDataSet);
begin
  btnRefreshClick(nil);
end;

function Tfrm_MainMod72.GetStatusWhere: string;
begin
  Result := ' AND  Data0060.STATUS in ( 109';
  if CheckBox6.Checked then Result:= Result + ',6';
  if CheckBox1.Checked then Result:= Result + ',1';
  if CheckBox2.Checked then Result:= Result + ',2';
  if CheckBox3.Checked then Result:= Result + ',3';
  if CheckBox4.Checked then Result:= Result + ',4';
  Result:= Result + ')';
end;

procedure Tfrm_MainMod72.N13Click(Sender: TObject);
var LFrm:TfrmEdit_note;
    Lsq60,Lsq318,Lsq117,Lsq06,Lsql,status:string;
    LPostData,AParamArr06: OleVariant;
    Lcds:TClientDataSet;
    rkey60:integer;
begin
  if not gFunc.CheckUserAuth(10,72) then  exit;
  if messagedlg('��ȷ��Ҫ�ֹ��رմ����۶�����',mtconfirmation,[mbyes,mbno],0)=mryes then
  begin
    rkey60:=cdsMain.FieldByName('D60Rkey').AsInteger;
    lcds:=TClientDataSet.Create(Application);
    LFrm := TfrmEdit_note.Create(Self);
    try
      LFrm.Label9.Caption:=' �����ļ���/�ر�ԭ��:';
      LFrm.iMenu:=2;// �ر�
      LFrm.Caption:='���۶������±�,�ر�:'+cdsmain.FieldByName('D60SALES_ORDER').AsString;
      LFrm.Memo1.Text:=cdsMain.FieldByName('RemarkSO').AsString;
      if LFrm.ShowModal=mrok then
      begin
        Lsq60:='select * from data0060 where Rkey='+cdsmain.FieldByName('D60RKEY').AsString;
        Lsq318:='select * from data0318 where 1=0';
        Lsq117:='select * from data0117 where 1=0';
        Lsql:='SELECT dbo.data0492.CUT_NO, dbo.Data0006.WORK_ORDER_NUMBER, '
                          +'       dbo.Data0006.PROD_STATUS, dbo.data0492.PLANNED_QTY, '
                          +'        dbo.data0492.ISSUED_QTY, dbo.Data0006.QUAN_SCH, '
                          +'        data0006.rkey '
                          +'  FROM dbo.Data0006 INNER JOIN '
                          +'        dbo.data0492 ON dbo.Data0006.CUT_NO = dbo.data0492.CUT_NO '
                          +'  WHERE (data0492.so_no='''+Trim(cdsmain.FieldByName('D60SALES_ORDER').AsString)+''') and '
                          +'  dbo.Data0006.PROD_STATUS in (2,3,4,5,6) '
                          +'  order by work_order_number';
        if not gSvrIntf.IntfGetDataBySqlArr(VarArrayOf([Lsq60,Lsq318,Lsq117,Lsql]),[cds60,cds318,cds117,Lcds]) then Exit;
        status:=cds60.FieldByName('status').AsString;
        cds60.Edit;
        cds60.FieldByName('RemarkSO').Value:=LFrm.Memo1.Text;
        cds60.FieldByName('status').Value:=3;    //����ر�
        cds60.Post;
        cds318.Append;
        cds318.FieldByName('SALES_ORDER_PTR').value:=cdsmain.FieldByName('D60RKEY').value;
        cds318.FieldByName('TRANS_TYPE').value:=11;
        cds318.FieldByName('TRANS_DESCRIPTION').value:='�ֹ������۶����ر�';
        cds318.FieldByName('FROM_STRING').value:= status;
        cds318.FieldByName('TO_STRING').value:='3';
        cds318.FieldByName('USER_PTR').value:=gVar.rkey73;
        cds318.FieldByName('TRANS_DATE').value:=gFunc.GetSvrDateTime;
        cds318.FieldByName('PROGRAM_SOURCE').value:=32;
        cds318.FieldByName('file_number').value:=trim(LFrm.Edit1.Text);
        cds318.Post;
        if ((not Lcds.IsEmpty) and (messagedlg('�رն�����ͬʱ�ݻ���������ҵ����?',mtConfirmation,[mbYes,mbNo],0)= mrYes)) then
        begin
//          Lsq06:='select * from data0006 where Rkey='+Lcds.FieldByName('rkey').AsString;
//          if not gSvrIntf.IntfGetDataBySql(Lsq06,cds06) then
          AParamArr06 := varArrayCreate([0, 2], varVariant);
          AParamArr06[0]:= GetRkeyStr(Lcds,'rkey');
          AParamArr06[1]:='data0006';
          AParamArr06[2]:='release_date';
          gSvrIntf.IntfspGetData('UpdateDate', AParamArr06, cds06);
          lcds.First;
          while not lcds.Eof do
          begin
            if (lcds.FieldByName('PROD_STATUS').AsInteger=4) then
            begin
              cds117.Append;
              cds117.FieldByName('Source_ptr').Value:=lcds.fieldBYName('Rkey').Value;
              cds117.FieldByName('Source_Type').Value:=2;
              cds117.FieldByName('EMPL_PTR').Value:=gVar.rkey05;
              cds117.FieldByName('Tdate').Value:=gFunc.GetSvrDateTime;
              cds117.FieldByName('Action').Value:=1;
              cds117.FieldByName('Remark').Value:='�г������ݻ������ⷢ�����ݻ�';
              cds117.Post;
            end else
            begin
              cds117.Append;
              cds117.FieldByName('Source_ptr').Value:=lcds.fieldBYName('Rkey').Value;
              cds117.FieldByName('Source_Type').Value:=2;
              cds117.FieldByName('EMPL_PTR').Value:=gVar.rkey05;
              cds117.FieldByName('Tdate').Value:=gFunc.GetSvrDateTime;
              cds117.FieldByName('Action').Value:=1;
              cds117.FieldByName('Remark').Value:='�г������ݻ����¹����ݻ�';
              cds117.Post;
            end;
            if (lcds.FieldByName('PROD_STATUS').Value<>102) or (lcds.FieldByName('PROD_STATUS').Value<>103) then
            begin
              if (lcds.FieldByName('PROD_STATUS').Value=2) then
              begin
                cds06.Locate('rkey',Lcds.FieldByName('rkey').AsString,[]);
                cds06.Edit;
                cds06.FieldByName('ENGG_STATUS').Value:=cds06.FieldByName('PROD_STATUS').Value;
                cds06.FieldByName('PROD_STATUS').Value:=102;
                cds06.Post;
              end else
              begin
                cds06.Locate('rkey',Lcds.FieldByName('rkey').AsString,[]);
                cds06.Edit;
                cds06.FieldByName('ENGG_STATUS').Value:=cds06.FieldByName('PROD_STATUS').Value;
                cds06.FieldByName('PROD_STATUS').Value:=103;
                cds06.Post;
              end;
            end;
            Lcds.Next;
          end;
        end;
        if cds60.State in [dsEdit,dsInsert] then cds60.Post;
        if cds318.State in [dsEdit,dsInsert] then cds318.Post;
        if cds117.State in [dsEdit,dsInsert] then cds117.Post;
        if cds06.State in [dsEdit,dsInsert] then cds06.Post;

        LPostData := VarArrayCreate([0,3],varVariant);
        if (cds60.ChangeCount > 0) then
          LPostData[0] := cds60.Delta;
        if (cds318.ChangeCount > 0) then
          LPostData[1] := cds318.Delta;
        if (cds117.ChangeCount > 0) then
          LPostData[2] := cds117.Delta;
        if (cds06.ChangeCount > 0) then
          LPostData[3] := cds06.Delta;
        if gSvrIntf.IntfPostDataBySqlArr(VarArrayOf(['data0060','data0318','data0117','data0006']),LPostData) then
        btnRefreshClick(nil);
      end;
      cdsMain.Locate('D60Rkey',rkey60,[])
    finally
      lcds.Free;
      LFrm.Free;
    end;
  end;
end;

procedure Tfrm_MainMod72.N14Click(Sender: TObject);
var LFrm:TfrmEdit_note;
    Lsq60,Lsq318,Lsq117,Lsq06,Lsql,status:string;
    LPostData,AParamArr06: OleVariant;
    Lcds:TClientDataSet;
    rkey60:integer;
begin
  if not gFunc.CheckUserAuth(11,72) then  exit;
  if messagedlg('��ȷ��Ҫ�ӹر��������𶯴����۶�����',mtconfirmation,[mbyes,mbno],0)=mryes then
  begin
    rkey60:=cdsMain.FieldByName('D60Rkey').AsInteger;
    lcds:=TClientDataSet.Create(Application);
    try
        Lsq60:='select * from data0060 where Rkey='+cdsmain.FieldByName('D60RKEY').AsString;
        Lsq318:='select * from data0318 where 1=0';
        Lsq117:='select * from data0117 where 1=0';
        Lsql:='SELECT dbo.data0492.CUT_NO, Data0006.WORK_ORDER_NUMBER,'
                        +'         dbo.Data0006.PROD_STATUS, dbo.data0492.PLANNED_QTY,'
                        +'          dbo.data0492.ISSUED_QTY, dbo.Data0006.QUAN_SCH,'
                        +'        data0006.rkey'
                        +'    FROM dbo.Data0006 INNER JOIN'
                        +'          dbo.data0492 ON dbo.Data0006.CUT_NO = dbo.data0492.CUT_NO '
                        +'    WHERE (data0492.so_no='''+Trim(cdsmain.FieldByName('D60SALES_ORDER').AsString)+''') and'
                        +'          (Data0006.PROD_STATUS = 103 or Data0006.PROD_STATUS = 102)'
                        +'    order by work_order_number';
      if not gSvrIntf.IntfGetDataBySqlArr(VarArrayOf([Lsq60,Lsq318,Lsq117,Lsql]),[cds60,cds318,cds117,Lcds]) then Exit;
        status:=cds60.FieldByName('status').Value;
        cds60.Edit;
        cds60.FieldByName('status').Value:=1;   //��Ч
        cds60.Post;
        cds318.Append;
        cds318.FieldByName('SALES_ORDER_PTR').value:=cdsmain.FieldByName('D60RKEY').value;
        cds318.FieldByName('TRANS_TYPE').value:=11;
        cds318.FieldByName('TRANS_DESCRIPTION').value:='�ֹ������۶����ӹر���������';
        cds318.FieldByName('FROM_STRING').value:= status;
        cds318.FieldByName('TO_STRING').value:='��Ч��';
        cds318.FieldByName('USER_PTR').value:=gVar.rkey73;
        cds318.FieldByName('TRANS_DATE').value:=gFunc.GetSvrDateTime;
        cds318.FieldByName('PROGRAM_SOURCE').value:=32;
        cds318.Post;
        if not Lcds.IsEmpty then
        begin
          AParamArr06 := varArrayCreate([0, 2], varVariant);
          AParamArr06[0]:= GetRkeyStr(Lcds,'rkey');
          AParamArr06[1]:='data0006';
          AParamArr06[2]:='release_date';
          gSvrIntf.IntfspGetData('UpdateDate', AParamArr06, cds06);
//          Lsq06:='select * from data0006 where Rkey='+Lcds.FieldByName('rkey').AsString;
//          if not gSvrIntf.IntfGetDataBySql(Lsq06,cds06) then
          lcds.First;
          while not lcds.Eof do
          begin
            if (lcds.FieldByName('PROD_STATUS').Value=102) then
            begin
              cds06.Locate('rkey',Lcds.FieldByName('rkey').AsString,[]);
              cds06.Edit;
              cds06.FieldByName('PROD_STATUS').Value:=2;
              cds06.Post;
            end else
            begin
              cds06.Locate('rkey',Lcds.FieldByName('rkey').AsString,[]);
              cds06.Edit;
              cds06.FieldByName('PROD_STATUS').Value:=cds06.FieldByName('ENGG_STATUS').Value;
              cds06.Post;
            end;
            cds117.Append;
            cds117.FieldByName('Source_ptr').Value:=lcds.fieldBYName('Rkey').Value;
            cds117.FieldByName('Source_Type').Value:=2;
            cds117.FieldByName('Empl_ptr').Value:=gVar.rkey05;
            cds117.FieldByName('Tdate').Value:=gFunc.GetSvrDateTime;
            cds117.FieldByName('Action').Value:=2;
            cds117.FieldByName('Remark').Value:='�г����ָ����¹����ָ�';
            cds117.Post;
            Lcds.Next;
          end;
        end;
        if cds60.State in [dsEdit,dsInsert] then cds60.Post;
        if cds318.State in [dsEdit,dsInsert] then cds318.Post;
        if cds117.State in [dsEdit,dsInsert] then cds117.Post;
        if cds06.State in [dsEdit,dsInsert] then cds06.Post;

        LPostData := VarArrayCreate([0,3],varVariant);
        if (cds60.ChangeCount > 0) then
          LPostData[0] := cds60.Delta;
        if (cds318.ChangeCount > 0) then
          LPostData[1] := cds318.Delta;
        if (cds117.ChangeCount > 0) then
          LPostData[2] := cds117.Delta;
        if (cds06.ChangeCount > 0) then
          LPostData[3] := cds06.Delta;
        if gSvrIntf.IntfPostDataBySqlArr(VarArrayOf(['data0060','data0318','data0117','data0006']),LPostData) then
        btnRefreshClick(nil);
      cdsMain.Locate('D60Rkey',rkey60,[])
    finally
      lcds.Free;
    end;
  end;
end;

procedure Tfrm_MainMod72.N15Click(Sender: TObject);
var LFrm:TfrmSo_report;
    LFileName:string;
begin
  inherited;
  if not gFunc.CheckUserAuth(13,72) then  exit;
  LFrm:=TfrmSo_report.Create(Self);
  try
    LFrm.GetData(cdsmain.FieldByName('D60RKEY').AsString,cdsMain.FieldByName('CUST_PART_PTR').AsString);
    LFileName := stringReplace(UpperCase(extractfilepath(paramstr(0))),
      'ERP_3_TIER\', 'ERP_3_TIER\REPORTS\�г�����_��������\', [rfReplaceAll]) +
      'sales_order.fr3';
    LFrm.frxReport1.LoadFromFile(LFileName, true);
    LFrm.frxReport1.ShowReport;
  finally
    LFrm.Free;
  end;

end;

procedure Tfrm_MainMod72.N16Click(Sender: TObject);
var Lsql,lsql2:string;
    Lcds,lcds2:TClientDataSet;
    sName:string;
    v_prod:byte;
    v_amt_ltd:integer;
    v_amount:double;
    rkey60:integer;
begin
  if not gFunc.CheckUserAuth(4,72) then  exit;
  lcds:=TClientDataSet.Create(Application);
  lcds2:=TClientDataSet.Create(Application);
  try
//    Lsql:='select ONHOLD_SALES_FLAG from data0025 where rkey='+cdsmain.FieldByName('CUST_PART_PTR').AsString;
//    if not gSvrIntf.IntfGetDataBySql(Lsql,lcds) then Exit;
//    if (Lcds.FieldByName('ONHOLD_SALES_FLAG').AsInteger=1) then
//    begin
    Lsql:=';with CTE as '
    +' ( '
    +' select data0025.MANU_PART_NUMBER,Data0025.ONHOLD_SALES_FLAG,Data0273.COPYFROMCUST_PTR,Data0273.CUSTOMER_PART_PTR '
    +' from data0273 inner join data0025 on data0273.COPYFROMCUST_PTR=data0025.rkey where Data0025.RKEY='+cdsmain.FieldByName('CUST_PART_PTR').AsString+' and ONHOLD_SALES_FLAG=1 '
    +' union all '
    +' select data0025.MANU_PART_NUMBER,Data0025.ONHOLD_SALES_FLAG,Data0273.COPYFROMCUST_PTR,Data0273.CUSTOMER_PART_PTR '
    +' from Data0273 inner join Data0025 on data0273.CUSTOMER_PART_PTR=data0025.rkey inner join cte on data0273.COPYFROMCUST_PTR=CTE.CUSTOMER_PART_PTR '
    +' ) '
    +' select * from cte where ONHOLD_SALES_FLAG=0 ';
    if not gSvrIntf.IntfGetDataBySql(Lsql,lcds) then Exit;
    if not Lcds.IsEmpty then
    begin
      sName:=Trim(Lcds.FieldByName('MANU_PART_NUMBER').AsString);
      if messagedlg('��ǰ���۵�����ͣ���ۣ������ı������Ϊ��'+sName+'�����Ƿ����?',mtConFirmation,[mbYes,mbNo],0)= mrNo then Exit;
//    end else
//    begin
//      sName:='��';
    end;
//    end;
    rkey60:=cdsMain.FieldByName('D60Rkey').AsInteger;
    v_prod:=2;
    v_amt_ltd:=0;
    v_amount:=0;
    lsql:='select prod_conf,so_amt_ltd from data0119 where CUST_PART_PTR='+cdsmain.FieldByName('CUST_PART_PTR').AsString;
    lsql2:='SELECT CUST_PART_PTR, PURCHASE_ORDER_PTR,ROUND(SUM(PARTS_ORDERED * (PARTS_ALLOC * (1 - DISCOUNT * 0.01))/ EXCH_RATE), 4) AS amount'
           +' FROM Data0060'
           +' where CUST_PART_PTR ='+cdsmain.FieldByName('CUST_PART_PTR').AsString+''
           +' and PURCHASE_ORDER_PTR ='+cdsmain.FieldByName('PURCHASE_ORDER_PTR').AsString+''
           +' GROUP BY CUST_PART_PTR, PURCHASE_ORDER_PTR';
    if not gSvrIntf.IntfGetDataBySqlArr(VarArrayOf([Lsql,lsql2]),[lcds,lcds2]) then Exit;
    if not lcds.IsEmpty then
    begin
      if (lcds.FieldByName('prod_conf').AsString<>'') then
       v_prod:=lcds.fieldvalues['prod_conf'];
      if  (lcds.FieldByName('so_amt_ltd').AsString<>'') then
       v_amt_ltd:=lcds.fieldvalues['so_amt_ltd'];
    end;
    if not lcds2.IsEmpty then v_amount:=lcds2.fieldvalues['amount'];
    if (cds192.fieldByName('ppc_control15').Value=1) then
    begin
      if v_prod=2 then
        self.pact_auth()
      else
      if v_prod=0 then
        showmessage('�ö����޷��ύ,��Ϊ���û��ͨ��ת��ȷ��!')
      else
      begin
        if v_amount <= v_amt_ltd then
          self.pact_auth()
        else
          showmessage('�ö����޷��ύ,��Ϊ�����ܽ������˰�ſ�ת�����ܽ��!');
      end;
    end else
      pact_auth();
    btnRefreshClick(nil);
    cdsMain.Locate('D60Rkey',rkey60,[])
  finally
    lcds.Free;
    lcds2.Free;
  end;
end;

procedure Tfrm_MainMod72.N18Click(Sender: TObject);
var
  LFrm:TfrmDeptinfo;
begin
  if not gFunc.CheckUserAuth(6,72) then  exit;
  LFrm:= TfrmDeptinfo.Create(nil);
  LFrm.GetData(cdsMain.FieldByName('D60Rkey').AsString);
  LFrm.ShowModal;
  LFrm.Free;
end;

procedure Tfrm_MainMod72.N22Click(Sender: TObject);
var LFrm:TfrmNote_information;
    Lcds:TClientDataSet;
    lsql:string;
begin
  if not gFunc.CheckUserAuth(12,72) then  exit;
  LFrm:= TfrmNote_information.Create(nil);
  lcds:=TClientDataSet.Create(Application);
  try
    LFrm.Caption:='���۶���:'+cdsMain.FieldByName('D60SALES_ORDER').AsString+'�����¼';
    lsql:='select user_login_name as USER_ID,USER_FULL_NAME,TRANS_DATE,TRANS_DESCRIPTION, '
          +' FROM_STRING,TO_STRING,file_number'
          +' from data0318 inner join data0073 on'
          +' data0318.user_ptr=data0073.rkey'
          +' where sales_ORDER_PTR='+cdsMain.FieldByName('D60RKEY').AsString;
    if not gSvrIntf.IntfGetDataBySql(lsql,lcds) then Exit;
    if not lcds.IsEmpty then
    begin
      lcds.First;
      while not lcds.Eof do
      begin
        LFrm.Memo1.Lines.Add(lcds.fieldbyname('trans_date').AsString+
        ' ϵͳ�û�:'+lcds.fieldbyname('user_id').AsString+' '+
        lcds.fieldbyname('user_full_name').AsString+
        lcds.fieldbyname('TRANS_DESCRIPTION').AsString);
        LFrm.Memo1.Lines.Add(' ԭֵ: '+lcds.fieldbyname('from_string').AsString+
        ' �����: '+lcds.fieldbyname('to_string').AsString+
        '   �ļ���/ԭ��:'+lcds.fieldbyname('file_number').AsString);
        lcds.Next;
      end;
    end;
    LFrm.ShowModal;
  finally
    lcds.Free;
    LFrm.Free;
  end;
end;

procedure Tfrm_MainMod72.N23Click(Sender: TObject);
var lsq60,lsq213,rkey213,lsql:string;
    LPostData: OleVariant;
    lcds:TClientDataSet;
begin
  if not gFunc.CheckUserAuth(7,72) then  exit;
  if (cdsMain.FieldByName('CSI_USER_PTR').AsString<>gVar.rkey73) then
  begin
    messagedlg('�Բ���,��û�п�дȨ��!���߸ö��������������',mtinformation,[mbok],0);
    exit;
  end else
  begin
    if messagedlg('��ȷ��Ҫɾ��������¼��?',mtConfirmation,[mbYes,mbNo],0)= mrYes then
    begin
      lcds:=TClientDataSet.Create(Application);
      try
        Lsql:='select rkey from data0090 '
             +' where auth_date is not null and '
             +' pact_ptr='+cdsMain.FieldByName('D60Rkey').AsString;
        if not gSvrIntf.IntfGetDataBySql(Lsql,lcds) then Exit;
        if not Lcds.IsEmpty then
        begin
          MessageDlg('�ö����ĺ�ͬ����������Ա,������ɾ��!',mtInformation,[mbCancel],0);
          Exit;
        end;
        lsq60 := 'select * from data0060 where rkey = ' +cdsMain.FieldByName('D60Rkey').AsString;
        if (Trim(cdsMain.FieldByName('rkey213').AsString)='') then rkey213:='-1'
        else  rkey213:=Trim(cdsMain.FieldByName('rkey213').AsString);

        lsq213:=' select * from data0213 where rkey='+rkey213;
        if not gSvrIntf.IntfGetDataBySqlArr(VarArrayOf([lsq60,lsq213]),[cds60,cds213]) then Exit;
        if not cds213.IsEmpty then
        begin
          cds213.Edit;
          cds213.FieldByName('status').Value:=3;
          cds213.FieldByName('UsedQuantity').Value:=cds213.FieldByName('UsedQuantity').Value-cdsMain.FieldByName('PARTS_ORDERED').Value;
          cds213.Post;
        end;
        cds60.Delete;

        if cds213.State in [dsEdit,dsInsert] then cds213.Post;
        if cds60.State in [dsEdit,dsInsert] then cds60.Post;

        LPostData := VarArrayCreate([0,1],varVariant);
        if (cds213.ChangeCount > 0) then
          LPostData[0] := cds213.Delta;
        if (cds60.ChangeCount > 0) then
          LPostData[1] := cds60.Delta;
        if gSvrIntf.IntfPostDataBySqlArr(VarArrayOf(['data0213','data0060']),LPostData) then
          btnRefreshClick(nil);
      finally
        lcds.Free;
      end;
    end;
  end;
end;

procedure Tfrm_MainMod72.N24Click(Sender: TObject);
begin
  inherited;
  if not gFunc.CheckUserAuth(14,72) then  exit;
  frmMany_So_report := TfrmMany_So_report.Create(Self);
  frmMany_So_report.GetData;
  frmMany_So_report.Edit1.Text:=cdsMain.FieldByName('D60SALES_ORDER').AsString;
  frmMany_So_report.ShowModal;
  frmMany_So_report.Free;
end;

procedure Tfrm_MainMod72.N25Click(Sender: TObject);
begin
  inherited;
  if not gFunc.CheckUserAuth(15,72) then  exit;
  frmSupplier_report := TfrmSupplier_report.Create(Self);
  frmSupplier_report.GetData;
  frmSupplier_report.Edit1.Text:=cdsMain.FieldByName('D60SALES_ORDER').AsString;
  frmSupplier_report.ShowModal;
  frmSupplier_report.Free;
end;

procedure Tfrm_MainMod72.N26Click(Sender: TObject);
var f,Lsql:string;
    fs: TMemoryStream;
    lcds:TClientDataSet;
begin
  if not gFunc.CheckUserAuth(16,72) then  exit;
  lcds:=TClientDataSet.Create(Application);
  try
    Lsql:='SELECT file_content,filename FROM Data0097 WHERE (file_content is not null) and RKEY ='+cdsMain.FieldByName('PURCHASE_ORDER_PTR').AsString;
    if not gSvrIntf.IntfGetDataBySql(Lsql,lcds) then Exit;
    if not Lcds.IsEmpty then
    begin
      fs := TMemoryStream.Create;
      TBlobfield(Lcds.fieldbyname('file_content')).SaveToStream(fs);
      UnPackStream(fs);
      if not DirectoryExists(TmpFileDir) then
        if not CreateDir(TmpFileDir) then  raise Exception.Create('������ʱ�ļ�Ŀ¼����: '+TmpFileDir);
      f:=TmpFileDir+Lcds.fieldbyname('filename').AsString;
      fs.SaveToFile(f);
      fs.Free;
      ShellExecute(self.Handle,nil,pchar(f),nil,nil,SW_SHOWNORMAL);
    end else
    begin
      ShowMessage('�ĵ�δ�ϴ�');
      Exit;
    end;
  finally
    lcds.Free;
  end;
end;

procedure Tfrm_MainMod72.N27Click(Sender: TObject);
var lsq60:string;
    rkey60:integer;
begin
  if not gFunc.CheckUserAuth(5,72) then  exit;
  rkey60:=cdsMain.FieldByName('D60Rkey').AsInteger;
  lsq60 := 'select * from data0060 where rkey = ' +cdsMain.FieldByName('D60Rkey').AsString;
  gSvrIntf.IntfGetDataBySql(lsq60,cds60);
  if not cds60.IsEmpty then
  begin
    cds60.Edit;
    cds60.FieldByName('status').Value:=6;//δ�ύ״̬
    cds60.Post;
  end;
  if (cds60.ChangeCount>0) then
  if gSvrIntf.IntfPostDataByTable('data0060',cds60.delta) then
  begin
    if (cds60.ChangeCount>0) then cds60.MergeChangeLog;
    btnRefreshClick(nil);
  end;
  cdsMain.Locate('D60Rkey',rkey60,[])
end;

procedure Tfrm_MainMod72.N3Click(Sender: TObject);
var LFrm:TfrmEdit_note;
    Lsq60,Lsq318,Lsq117,Lsq06,Lsql:string;
    LPostData,AParamArr06: OleVariant;
    Lcds:TClientDataSet;
    rkey60:integer;
begin
  inherited;
  if not gFunc.CheckUserAuth(8,72) then  exit;
  lcds:=TClientDataSet.Create(Application);
  LFrm := TfrmEdit_note.Create(Self);
  try
    rkey60:=cdsMain.FieldByName('D60Rkey').AsInteger;
    LFrm.Label9.Caption:=' �����ļ���/��ͣԭ��:';
    LFrm.iMenu:=0;// ��ͣ
    LFrm.Caption:='���۶������±�,�����ݻ�:'+cdsmain.FieldByName('D60SALES_ORDER').AsString;
    LFrm.Memo1.Text:=cdsMain.FieldByName('RemarkSO').AsString;
    if LFrm.ShowModal=mrok then
    begin
      Lsq60:='select * from data0060 where Rkey='+cdsmain.FieldByName('D60RKEY').AsString;
      Lsq318:='select * from data0318 where 1=0';
      Lsq117:='select * from data0117 where 1=0';
      Lsql:='SELECT dbo.data0492.CUT_NO, dbo.Data0006.WORK_ORDER_NUMBER, '
                        +'       dbo.Data0006.PROD_STATUS, dbo.data0492.PLANNED_QTY, '
                        +'        dbo.data0492.ISSUED_QTY, dbo.Data0006.QUAN_SCH, '
                        +'        data0006.rkey '
                        +'  FROM dbo.Data0006 INNER JOIN '
                        +'        dbo.data0492 ON dbo.Data0006.CUT_NO = dbo.data0492.CUT_NO '
                        +'  WHERE (data0492.so_no='''+Trim(cdsmain.FieldByName('D60SALES_ORDER').AsString)+''') and '
                        +'  dbo.Data0006.PROD_STATUS in (2,3,4,5,6) '
                        +'  order by work_order_number';
      if not gSvrIntf.IntfGetDataBySqlArr(VarArrayOf([Lsq60,Lsq318,Lsq117,Lsql]),[cds60,cds318,cds117,Lcds]) then Exit;
      cds60.Edit;
      cds60.FieldByName('RemarkSO').Value:=LFrm.Memo1.Text;
      cds60.FieldByName('status').Value:=2;  //�ݻ�
      cds60.Post;
      cds318.Append;
      cds318.FieldByName('SALES_ORDER_PTR').value:=cdsmain.FieldByName('D60RKEY').value;
      cds318.FieldByName('TRANS_TYPE').value:=10;
      cds318.FieldByName('TRANS_DESCRIPTION').value:='�������۶���״̬Ϊ����';
      cds318.FieldByName('FROM_STRING').value:= cdsMain.FieldByName('status').Value;
      cds318.FieldByName('TO_STRING').value:='�ݻ�';
      cds318.FieldByName('USER_PTR').value:=gVar.rkey73;
      cds318.FieldByName('TRANS_DATE').value:=gFunc.GetSvrDateTime;
      cds318.FieldByName('PROGRAM_SOURCE').value:=32;
      cds318.FieldByName('file_number').value:=trim(LFrm.Edit1.Text);
      cds318.Post;
      if not Lcds.IsEmpty then
      begin
          AParamArr06 := varArrayCreate([0, 2], varVariant);
          AParamArr06[0]:= GetRkeyStr(Lcds,'rkey');
          AParamArr06[1]:='data0006';
          AParamArr06[2]:='release_date';
          gSvrIntf.IntfspGetData('UpdateDate', AParamArr06, cds06);
//        Lsq06:='select * from data0006 where Rkey='+Lcds.FieldByName('rkey').AsString;
//        if not gSvrIntf.IntfGetDataBySql(Lsq06,cds06) then
        lcds.First;
        while not lcds.Eof do
        begin
          if (lcds.FieldByName('PROD_STATUS').AsInteger=4) then
          begin
            cds117.Append;
            cds117.FieldByName('Source_ptr').Value:=lcds.fieldBYName('Rkey').Value;
            cds117.FieldByName('Source_Type').Value:=2;
            cds117.FieldByName('Empl_ptr').Value:=gVar.UserName05;
            cds117.FieldByName('Tdate').Value:=gFunc.GetSvrDateTime;
            cds117.FieldByName('Action').Value:=1;
            cds117.FieldByName('Remark').Value:='�г������ݻ������ⷢ�����ݻ�';
            cds117.Post;
          end else
          begin
            cds117.Append;
            cds117.FieldByName('Source_ptr').Value:=lcds.fieldBYName('Rkey').Value;
            cds117.FieldByName('Source_Type').Value:=2;
            cds117.FieldByName('Empl_ptr').Value:=gVar.UserName05;
            cds117.FieldByName('Tdate').Value:=gFunc.GetSvrDateTime;
            cds117.FieldByName('Action').Value:=1;
            cds117.FieldByName('Remark').Value:='�г������ݻ����¹����ݻ�';
            cds117.Post;
          end;
          if (lcds.FieldByName('PROD_STATUS').Value=2) then
          begin
            cds06.Locate('rkey',Lcds.FieldByName('rkey').AsString,[]);
            cds06.Edit;
            cds06.FieldByName('ENGG_STATUS').Value:=cds06.FieldByName('PROD_STATUS').Value;
            cds06.FieldByName('PROD_STATUS').Value:=102;
            cds06.Post;
          end else
          begin
            cds06.Locate('rkey',Lcds.FieldByName('rkey').AsString,[]);
            cds06.Edit;
            cds06.FieldByName('ENGG_STATUS').Value:=cds06.FieldByName('PROD_STATUS').Value;
            cds06.FieldByName('PROD_STATUS').Value:=103;
            cds06.Post;
          end;
          Lcds.Next;
        end;
      end;
      if cds60.State in [dsEdit,dsInsert] then cds60.Post;
      if cds318.State in [dsEdit,dsInsert] then cds318.Post;
      if cds117.State in [dsEdit,dsInsert] then cds117.Post;
      if cds06.State in [dsEdit,dsInsert] then cds06.Post;

      LPostData := VarArrayCreate([0,3],varVariant);
      if (cds60.ChangeCount > 0) then
        LPostData[0] := cds60.Delta;
      if (cds318.ChangeCount > 0) then
        LPostData[1] := cds318.Delta;
      if (cds117.ChangeCount > 0) then
        LPostData[2] := cds117.Delta;
      if (cds06.ChangeCount > 0) then
        LPostData[3] := cds06.Delta;
      if gSvrIntf.IntfPostDataBySqlArr(VarArrayOf(['data0060','data0318','data0117','data0006']),LPostData) then
        btnRefreshClick(nil);
    end;
    cdsMain.Locate('D60Rkey',rkey60,[])
  finally
    lcds.Free;
    LFrm.Free;
  end;
end;

procedure Tfrm_MainMod72.N5Click(Sender: TObject);
begin
  inherited;
  if not gFunc.CheckUserAuth(1,72) then  exit;
  if frmNewSales2 = nil then
  begin
    frmNewSales2 := TfrmNewSales2.Create(Self);
    frmNewSales2.refresh:= self.getRefreshClick;
  end;
  frmNewSales2.GetData('-1');
  frmNewSales2.ClearEdit;
  frmNewSales2.init;
  frmNewSales2.Show;
end;

procedure Tfrm_MainMod72.N6Click(Sender: TObject);
var Lsql:string;
    Lcds:TClientDataSet;
    rkey60:integer;
begin
  if not gFunc.CheckUserAuth(2,72) then  exit;
  lcds:=TClientDataSet.Create(Application);
  try
    Lsql:='select rkey from data0090 '
         +' where auth_date is not null and '
         +' pact_ptr='+cdsMain.FieldByName('D60Rkey').AsString;
    if not gSvrIntf.IntfGetDataBySql(Lsql,lcds) then Exit;
    if not Lcds.IsEmpty then
    begin
      MessageDlg('�ö����ĺ�ͬ����������Ա,������༭',mtInformation,[mbCancel],0);
      Exit;
    end;
    rkey60:=cdsMain.FieldByName('D60Rkey').AsInteger;
    if frmEdit_so = nil then
    begin
      frmEdit_so := TfrmEdit_so.Create(Self);
      frmEdit_so.refresh:= self.getRefreshClick;
      cdsMain.Locate('D60Rkey',rkey60,[])
    end;
    frmEdit_so.GetData(cdsMain.FieldByName('D60Rkey').AsString,cdsMain.FieldByName('CUST_PART_PTR').AsString);
    frmEdit_so.init;
    if (cdsMain.FieldByName('rkey213').Value>0) then
    begin
      frmEdit_so.BitBtn3.Enabled:=False;
      frmEdit_so.Edit2.Enabled:=False;
      frmEdit_so.Edit1.ReadOnly:=True;
      frmEdit_so.RKeyRzBtnEdit35.ReadOnly:=True;
      frmEdit_so.RKeyRzBtnEdit36.ReadOnly:=True;
      frmEdit_so.RKeyRzBtnEdit37.ReadOnly:=True;
      frmEdit_so.BitBtn13.Enabled:=False;
    end;
    frmEdit_so.Edit2.Enabled:=True;
    frmEdit_so.btnSave.Enabled:=True;
    frmEdit_so.RKeyRzBtnEdit1.Enabled:=True;
    frmEdit_so.RKeyRzBtnEdit4.Enabled:=True;
    frmEdit_so.Edit1.Enabled:=True;
    frmEdit_so.ComboBox1.Enabled:=True;
    frmEdit_so.DBRadioGroup1.Enabled:=True;
    frmEdit_so.DBRadioGroup2.Enabled:=True;
    frmEdit_so.DBComboBox2.Enabled:=True;
    frmEdit_so.RKeyRzBtnEdit16.Enabled:=True;
    frmEdit_so.RKeyRzBtnEdit19.Enabled:=True;
    frmEdit_so.RKeyRzBtnEdit21.Enabled:=True;
    frmEdit_so.RKeyRzBtnEdit21.ReadOnly:=False;
    frmEdit_so.TabSheet2.Enabled:=True;
    frmEdit_so.TabSheet3.Enabled:=True;
    frmEdit_so.TabSheet4.Enabled:=True;
    frmEdit_so.TabSheet5.Enabled:=True;
    frmEdit_so.TabSheet6.Enabled:=True;
    frmEdit_so.Show;
    cdsMain.Locate('D60Rkey',rkey60,[])
  finally
    lcds.Free;
  end;
end;

procedure Tfrm_MainMod72.N7Click(Sender: TObject);
var Lsql:string;
    Lcds:TClientDataSet;
    rkey60:integer;
begin
  if not gFunc.CheckUserAuth(3,72) then  exit;
  lcds:=TClientDataSet.Create(Application);
  try
    if frmEdit_so = nil then
    begin
      frmEdit_so := TfrmEdit_so.Create(Self);
    end;
    rkey60:=cdsMain.FieldByName('D60Rkey').AsInteger;
    frmEdit_so.GetData(cdsMain.FieldByName('D60Rkey').AsString,cdsMain.FieldByName('CUST_PART_PTR').AsString);
    frmEdit_so.init;
    if (cdsMain.FieldByName('rkey213').Value>0) then
    begin
      frmEdit_so.BitBtn3.Enabled:=False;
      frmEdit_so.Edit2.Enabled:=False;
      frmEdit_so.Edit1.ReadOnly:=True;
      frmEdit_so.RKeyRzBtnEdit35.ReadOnly:=True;
      frmEdit_so.RKeyRzBtnEdit36.ReadOnly:=True;
      frmEdit_so.RKeyRzBtnEdit37.ReadOnly:=True;
      frmEdit_so.BitBtn13.Enabled:=False;
    end;
    frmEdit_so.Edit2.Enabled:=False;
    frmEdit_so.btnSave.Enabled:=False;
    frmEdit_so.RKeyRzBtnEdit1.Enabled:=False;
    frmEdit_so.RKeyRzBtnEdit4.Enabled:=False;
    frmEdit_so.Edit1.Enabled:=False;
    frmEdit_so.ComboBox1.Enabled:=False;
    frmEdit_so.DBRadioGroup1.Enabled:=False;
    frmEdit_so.DBRadioGroup2.Enabled:=False;
    frmEdit_so.DBComboBox2.Enabled:=False;
    frmEdit_so.RKeyRzBtnEdit16.Enabled:=false;
    frmEdit_so.RKeyRzBtnEdit19.Enabled:=false;
    frmEdit_so.RKeyRzBtnEdit21.Enabled:=false;
    frmEdit_so.TabSheet2.Enabled:=False;
    frmEdit_so.TabSheet3.Enabled:=False;
    frmEdit_so.TabSheet4.Enabled:=False;
    frmEdit_so.TabSheet5.Enabled:=False;
    frmEdit_so.TabSheet6.Enabled:=False;
    frmEdit_so.Show;
    cdsMain.Locate('D60Rkey',rkey60,[])
  finally
    lcds.Free;
  end;
end;

procedure Tfrm_MainMod72.N8Click(Sender: TObject);
var LFrm:TfrmEdit_note;
    Lsq60,Lsq318,Lsq117,Lsq06,Lsql:string;
    LPostData,AParamArr06: OleVariant;
    Lcds:TClientDataSet;
    rkey60:integer;
begin
  inherited;
  if not gFunc.CheckUserAuth(9,72) then  exit;
  lcds:=TClientDataSet.Create(Application);
  LFrm := TfrmEdit_note.Create(Self);
  try
    rkey60:=cdsMain.FieldByName('D60Rkey').AsInteger;
    LFrm.Label9.Caption:=' �ļ���/�ݻ�����ԭ��:';
    LFrm.iMenu:=1;//����
    LFrm.Caption:='���ݻ����ͷ�:'+cdsmain.FieldByName('D60SALES_ORDER').AsString;
    LFrm.Memo1.Text:=cdsMain.FieldByName('RemarkSO').AsString;
    if LFrm.ShowModal=mrok then
    begin
      Lsq60:='select * from data0060 where Rkey='+cdsmain.FieldByName('D60RKEY').AsString;
      Lsq318:='select * from data0318 where 1=0';
      Lsq117:='select * from data0117 where 1=0';
      Lsql:='SELECT dbo.data0492.CUT_NO, Data0006.WORK_ORDER_NUMBER,'
                        +'         dbo.Data0006.PROD_STATUS, dbo.data0492.PLANNED_QTY,'
                        +'          dbo.data0492.ISSUED_QTY, dbo.Data0006.QUAN_SCH,'
                        +'        data0006.rkey'
                        +'    FROM dbo.Data0006 INNER JOIN'
                        +'          dbo.data0492 ON dbo.Data0006.CUT_NO = dbo.data0492.CUT_NO '
                        +'    WHERE (data0492.so_no='''+Trim(cdsmain.FieldByName('D60SALES_ORDER').AsString)+''') and'
                        +'          (Data0006.PROD_STATUS = 103 or Data0006.PROD_STATUS = 102)'
                        +'    order by work_order_number';
      if not gSvrIntf.IntfGetDataBySqlArr(VarArrayOf([Lsq60,Lsq318,Lsq117,Lsql]),[cds60,cds318,cds117,Lcds]) then Exit;
      cds60.Edit;
      cds60.FieldByName('RemarkSO').Value:=LFrm.Memo1.Text;
      cds60.FieldByName('status').Value:=1;   //��Ч
      cds60.Post;
      cds318.Append;
      cds318.FieldByName('SALES_ORDER_PTR').value:=cdsmain.FieldByName('D60RKEY').value;
      cds318.FieldByName('TRANS_TYPE').value:=10;
      cds318.FieldByName('TRANS_DESCRIPTION').value:='�������۶���״̬Ϊ��Ч';
      cds318.FieldByName('FROM_STRING').value:= cdsMain.FieldByName('status').Value;
      cds318.FieldByName('TO_STRING').value:='��Ч��';
      cds318.FieldByName('USER_PTR').value:=gVar.rkey73;
      cds318.FieldByName('TRANS_DATE').value:=gFunc.GetSvrDateTime;
      cds318.FieldByName('PROGRAM_SOURCE').value:=32;
      cds318.FieldByName('file_number').value:=trim(LFrm.Edit1.Text);
      cds318.Post;
      if not Lcds.IsEmpty then
      begin
        AParamArr06 := varArrayCreate([0, 2], varVariant);
        AParamArr06[0]:= GetRkeyStr(Lcds,'rkey');
        AParamArr06[1]:='data0006';
        AParamArr06[2]:='release_date';
        gSvrIntf.IntfspGetData('UpdateDate', AParamArr06, cds06);
//        Lsq06:='select * from data0006 where Rkey='+Lcds.FieldByName('rkey').AsString;
//        if not gSvrIntf.IntfGetDataBySql(Lsq06,cds06) then
        lcds.First;
        while not lcds.Eof do
        begin
          if (lcds.FieldByName('PROD_STATUS').Value=102) then
          begin
            cds06.Locate('rkey',Lcds.FieldByName('rkey').AsString,[]);
            cds06.Edit;
            cds06.FieldByName('PROD_STATUS').Value:=2;
            cds06.Post;
          end else
          begin
            cds06.Locate('rkey',Lcds.FieldByName('rkey').AsString,[]);
            cds06.Edit;
            cds06.FieldByName('PROD_STATUS').Value:=cds06.FieldByName('ENGG_STATUS').Value;
            cds06.Post;
          end;
          cds117.Append;
          cds117.FieldByName('Source_ptr').Value:=lcds.fieldBYName('Rkey').Value;
          cds117.FieldByName('Source_Type').Value:=2;
          cds117.FieldByName('Empl_ptr').Value:=gVar.rkey05;
          cds117.FieldByName('Tdate').Value:=gFunc.GetSvrDateTime;
          cds117.FieldByName('Action').Value:=2;
          cds117.FieldByName('Remark').Value:='�г����ָ����¹����ָ�';
          cds117.Post;
          Lcds.Next;
        end;
      end;
      if cds60.State in [dsEdit,dsInsert] then cds60.Post;
      if cds318.State in [dsEdit,dsInsert] then cds318.Post;
      if cds117.State in [dsEdit,dsInsert] then cds117.Post;
      if cds06.State in [dsEdit,dsInsert] then cds06.Post;

      LPostData := VarArrayCreate([0,3],varVariant);
      if (cds60.ChangeCount > 0) then
        LPostData[0] := cds60.Delta;
      if (cds318.ChangeCount > 0) then
        LPostData[1] := cds318.Delta;
      if (cds117.ChangeCount > 0) then
        LPostData[2] := cds117.Delta;
      if (cds06.ChangeCount > 0) then
        LPostData[3] := cds06.Delta;
      if gSvrIntf.IntfPostDataBySqlArr(VarArrayOf(['data0060','data0318','data0117','data0006']),LPostData) then
        btnRefreshClick(nil);
    end;
    cdsMain.Locate('D60Rkey',rkey60,[])
  finally
    lcds.Free;
    LFrm.Free;
  end;
end;

procedure Tfrm_MainMod72.pact_auth;
var Lsql,lsql2,Lsql3:string;
    Lcds,lcds2,lcds3:TClientDataSet;
    LPostData: OleVariant;
begin
  lcds:=TClientDataSet.Create(Application);
  lcds2:=TClientDataSet.Create(Application);
  lcds3:=TClientDataSet.Create(Application);
  try
    Lsql:='SELECT data0091.rkey,data0091.dept_ptr,data0091.if_puthdate,data0091.puth_info '
         +'FROM data0091 INNER JOIN Data0007 ON data0091.group_ptr = Data0007.RKEY INNER JOIN '
         +'Data0008 ON Data0007.RKEY = Data0008.PR_GRP_POINTER INNER JOIN Data0025 ON Data0008.RKEY = Data0025.PROD_CODE_PTR '
         +' where data0025.rkey='+cdsMain.FieldByName('CUST_PART_PTR').AsString+' order by data0091.rkey' ;
    lsql2:='select * from data0090 where pact_ptr='+ cdsMain.FieldByName('D60rkey').AsString;
    if not gSvrIntf.IntfGetDataBySqlArr(VarArrayOf([Lsql,lsql2]),[lcds,lcds2]) then Exit;
    if not Lcds.IsEmpty then
    begin
      Lsql := 'select * from data0060 where rkey = ' + cdsMain.FieldByName('D60rkey').AsString;
      lsql2:='select * from data0090 where 1=0';
      if not gSvrIntf.IntfGetDataBySqlArr(VarArrayOf([Lsql,lsql2]),[cds60,cds90]) then Exit;
      if not cds60.IsEmpty then
      begin
        cds60.Edit;
        cds60.FieldByName('STATUS').Value:=1;
        cds60.Post;
      end;
      if (cdsMain.FieldByName('quote_price').Value=0) then
      begin
        if ((cdsMain.FieldByName('ttype').AsInteger=0) and (cds192.FieldByName('aptaxontax').Value='Y'))  //������Ҫ����
          or ((cdsMain.FieldByName('ttype').AsInteger=1) and (cds192.FieldByName('artaxontax').Value='Y')) then //������Ҫ����
        begin
          if messagedlg('����δ�����Ƿ���Ҫ�ύ������ȷ��?',mtConFirmation,[mbYes,mbNo],0)= mryes then
          begin
            if not lcds2.IsEmpty then
            while not lcds2.Eof do lcds2.Delete;
            Lcds.First;
            while not Lcds.Eof do
            begin
              cds90.Append;
              cds90.FieldByName('pact_ptr').Value:=cdsMain.FieldByName('D60rkey').Value;
              cds90.FieldByName('dept_ptr').Value:=Lcds.FieldByName('dept_ptr').Value;
              cds90.FieldByName('if_puthdate').Value:=Lcds.FieldByName('if_puthdate').Value;
              cds90.FieldByName('puth_info').Value:=Lcds.FieldByName('puth_info').Value;
              cds90.Post;
              lcds.Next;
            end;
          end else
          begin
            cds60.Edit;
            cds60.FieldByName('quote_price').Value:=3;
            cds60.FieldByName('SCH_DATE').Value:=cdsMain.FieldByName('ORIG_SCHED_SHIP_DATE').Value;
            cds60.Post;
          end;
        end else
        begin
          cds60.Edit;
          cds60.FieldByName('quote_price').Value:=3;
          cds60.FieldByName('SCH_DATE').Value:=cdsMain.FieldByName('ORIG_SCHED_SHIP_DATE').Value;
          cds60.Post;
        end;
      end;
      if cds60.State in [dsEdit,dsInsert] then cds60.Post;
      if lcds2.State in [dsEdit,dsInsert] then lcds2.Post;
      if cds90.State in [dsEdit,dsInsert] then cds90.Post;

      LPostData := VarArrayCreate([0,2],varVariant);
      if (cds60.ChangeCount > 0) then
        LPostData[0] := cds60.Delta;
      if (lcds2.ChangeCount > 0) then
        LPostData[1] := lcds2.Delta;
      if (cds90.ChangeCount > 0) then
        LPostData[2] := cds90.Delta;
      if gSvrIntf.IntfPostDataBySqlArr(VarArrayOf(['data0060','data0090','data0090']),LPostData) then
        btnRefreshClick(nil);
    end else
    begin
      showmessage('�ύ����������ɹ�,���������ò�Ʒ����������!');
      Exit;
    end;
  finally
    lcds.Free;
    lcds3.Free;
    lcds2.Free;
  end;
end;

procedure Tfrm_MainMod72.pmMainPopup(Sender: TObject);
var Lcds:TClientDataSet;
    lsql:string;
    iSet:Integer;
begin
  iset:=0;
  lcds:=TClientDataSet.Create(Application);
  try
    if not cdsMain.IsEmpty  then
    begin
      lsql:='select rkey from data0090 where auth_date is not null and pact_ptr='+cdsMain.FieldByName('D60rkey').AsString;
      if not gSvrIntf.IntfGetDataBySql(lsql,Lcds) then Exit;
      if not Lcds.IsEmpty then iSet:=1;
    end;
    N3.Enabled := false;  //�ݻ�
    N8.Enabled := true; //���ݻ����ͷ�
    N6.Enabled := true;  //�༭
    n13.Enabled := false;      //�᰸
    n14.Enabled := true;   //�ӽ᰸����
    n7.Enabled := true; //���
    n16.Enabled := false; //�ύ
    n18.Enabled := true;
    N15.Enabled := true;
    n22.Enabled := true;
    n23.Enabled := false;  //ɾ��
    N27.Enabled:=False;//ȡ���ύ
    case (not cdsMain.IsEmpty) and cdsMain.FieldByName('D60STATUS').Value of
    1:
     begin//��Ч
      n3.Enabled := true;   //�ݻ�
      N8.Enabled := false;  //���ݻ����ͷ�
      n13.Enabled := true;
      n14.Enabled:=false;
      if (cdsMain.FieldByName('D60PROD_REL').Value='1') then //PROD_REL�������
       n23.Enabled :=true
      else
       n23.Enabled :=false;
      if (cdsMain.FieldByName('QUOTE_PRICE').Value=2) then
        N6.Enabled:=True
      else
        N6.Enabled := false;  //�༭
      if (N16.Enabled=False) and (iset=0) and ((cdsMain.FieldByName('QUOTE_PRICE').Value=0) or ((cdsMain.FieldByName('QUOTE_PRICE').Value=3) and (cdsMain.FieldByName('D60PROD_REL').Value='1'))) then
        N27.Enabled:=True
      else
        N27.Enabled:=False;
     end;
    2:
     begin //�ݻ�
      n14.Enabled := false;
      N6.Enabled := false;
     end;
    3:
     begin   //�ر�
      N8.Enabled := false;   //���ݻ����ͷ�
      N6.Enabled := false;
     end;
    4:
     begin //���
      n14.Enabled := false;
      N8.Enabled := false;   //���ݻ����ͷ�
     end;
    5:
     begin //ȡ��
      n6.Enabled := false;   //�༭
      n14.Enabled := false;
      N8.Enabled := false;   //���ݻ����ͷ�
     end;
    6:
     begin//δ�ύ
      n3.Enabled := true;   //�ݻ�
      N8.Enabled := false;  //���ݻ����ͷ�
      n14.Enabled:=false;
      n13.Enabled := true;
      n16.Enabled := true;
      n23.Enabled := true;  //ɾ��
     end;
    else
     begin //�ռ�¼
      N8.Enabled := false;  //���ݻ����ͷ�
      N6.Enabled := false;  //�༭
      n14.Enabled:=false;
      n7.Enabled := false;  //���
      n16.Enabled := false; //�ύ
      n18.Enabled := false; //������Ϣ
      N15.Enabled := false; //����
      n22.Enabled := false;  //���۶������
      n23.Enabled := false;  //ɾ��
     end;
    end;
  finally
    lcds.Free;
  end;
end;

procedure Tfrm_MainMod72.BitBtn6Click(Sender: TObject);
var LFrm:TfrmViewCredit;
begin
  if not gFunc.CheckUserAuth(102,72) then  exit;
  LFrm:= TfrmViewCredit.Create(nil);
  if gFunc.CheckUserAuth(102,72) then LFrm.LsWhere:=1 else
  LFrm.LsWhere:=0;
  LFrm.ShowModal;
  LFrm.Free;
end;

procedure Tfrm_MainMod72.BitBtn7Click(Sender: TObject);
var i:Integer;
    stringgrid1:TStringGrid;
begin
  if not cdsMain.IsEmpty then
  begin
    stringgrid1:=TStringGrid.Create(Self);
    i:=1;
    with StringGrid1 do
    begin
      StringGrid1.ColCount:=10;
      StringGrid1.RowCount:=2;
      Cells[0,0]:='�ͻ��ͺ�';
      Cells[1,0]:='�ͻ�������';
      Cells[2,0]:='�ͻ����Ϻ�';
      Cells[3,0]:='��������';
      Cells[4,0]:='��������';
      Cells[5,0]:='���۶�����';
      Cells[6,0]:='�������(��)';
      Cells[7,0]:='�ͻ�����(��)';
      Cells[8,0]:='�ָⷢ����Ӧ��(��)';
      Cells[9,0]:='����(��)';
      StringGrid1.ColWidths[0]:=150;
      StringGrid1.ColWidths[1]:=120;
      StringGrid1.ColWidths[2]:=130;
      StringGrid1.ColWidths[3]:=60;
      StringGrid1.ColWidths[4]:=100;
      StringGrid1.ColWidths[5]:=80;
    end;
    cdsMain.DisableControls;
    cdsMain.First;
    while not cdsMain.Eof do
    begin
      StringGrid1.RowCount:=StringGrid1.RowCount+1;
      StringGrid1.Cells[0,i]:=cdsMain.FieldByName('MANU_PART_DESC').AsString;
      StringGrid1.Cells[1,i]:=cdsMain.FieldByName('D97PO_NUMBER').AsString;
      StringGrid1.Cells[2,i]:=cdsMain.FieldByName('ANALYSIS_CODE_2').AsString;
      StringGrid1.Cells[3,i]:=cdsMain.FieldByName('PARTS_ORDERED').AsString;
      StringGrid1.Cells[4,i]:=cdsMain.FieldByName('ENT_DATE').AsString;
      StringGrid1.Cells[5,i]:=cdsMain.FieldByName('D60SALES_ORDER').AsString;
      cdsMain.Next;
      i:=i+1;
    end;
    cdsMain.EnableControls;
    Export_Grid_to_Excel(StringGrid1,Self.Caption,False);
  end;
end;

procedure Tfrm_MainMod72.BitBtn8Click(Sender: TObject);
begin
  inherited;
  if ExcelToDB then
  begin
    ShowMessage('����ɹ���');
    btnRefreshClick(nil);
  end;
end;

procedure Tfrm_MainMod72.btnQryClick(Sender: TObject);
begin
  if cdsMainWhereInit.IsEmpty then
  begin
    cdsMainWhereInit.Append;
    cdsMainWhereInit.FieldByName('FieldName').AsString := 'DATA0060.ent_date';
    cdsMainWhereInit.FieldByName('Oper').AsString := '����';
    cdsMainWhereInit.FieldByName('FieldValue').AsString := FormatDateTime('YYYY-MM-DD',dNewDate) +
                                  ' AND ' + FormatDateTime('YYYY-MM-DD',dNewDate);
    cdsMainWhereInit.FieldByName('SeqNo').AsString := '0';
    cdsMainWhereInit.Post;
  end;
  inherited;
end;

procedure Tfrm_MainMod72.CheckBox6Click(Sender: TObject);
begin
  inherited;
  GetData;
end;

procedure Tfrm_MainMod72.ehMainDblClick(Sender: TObject);
begin
  N7Click(Sender);
end;

procedure Tfrm_MainMod72.ehMainDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
begin
  inherited;
 if (COlumn.FieldName = 'D60SCH_DATE') and
    (cdsMain.FieldByName('D60SCH_DATE').AsString<>null) and
    (cdsMain.FieldByName('D60SCH_DATE').Value>cdsMain.FieldByName('ORIG_SCHED_SHIP_DATE').Value) then
  begin
    ehMain.Canvas.Brush.color:=clyellow;
    ehMain.Canvas.Font.Color :=clblue;
    ehMain.DefaultDrawColumnCell(Rect,DataCol,Column,State);
  end;

 if (cdsMain.FieldByName('D60STATUS').Value = 1) and (cdsMain.FieldByName('quote_price').Value=2) then
  ehMain.Canvas.Font.Color := clred
 else
  if cdsMain.FieldByName('D60STATUS').Value = 6 then     //δ�ύ
  begin
   ehMain.Canvas.Font.Color :=clLime;
  end else
   if (cdsMain.FieldByName('D60STATUS').Value=2) or (cdsMain.FieldByName('D60STATUS').Value=3) or
   (cdsMain.FieldByName('D60STATUS').Value=5) then      //�ݻ�,�ر�,ȡ��
     ehMain.Canvas.Font.Color := clfuchsia;
  ehMain.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure Tfrm_MainMod72.FormShow(Sender: TObject);
begin
  inherited;
  GetData;
end;

function Tfrm_MainMod72.GetCustomerWhere: string;
begin
  if gFunc.CheckUserAuth(101,72) then Result:= '' else //101����Ϊ�Ƿ���Ҫ�ͻ����Ʋ鿴Ȩ��
  Result:= ' and data0060.customer_ptr in (SELECT customer_ptr from DATA0100 WHERE csi_ptr='+gvar.rkey73+')'+#13;
end;

end.
