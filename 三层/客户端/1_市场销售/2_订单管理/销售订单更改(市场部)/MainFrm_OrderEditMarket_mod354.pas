unit MainFrm_OrderEditMarket_mod354;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,uCommFunc,ubasemainfrm, DBGridEhGrouping,
  ToolCtrlsEh, DBGridEhToolCtrls, DynVarsEh, Data.DB, Vcl.XPMan, Vcl.Menus,
  Datasnap.DBClient, Vcl.StdCtrls, Vcl.Buttons, EhLibVCL, GridsEh,
  DBAxisGridsEh, DBGridEh, Vcl.ExtCtrls, Data.Win.ADODB;

type
  TfrmMain_OrderEditMarket_mod354 = class(TfrmBaseMain)
    mni_QtyModi: TMenuItem;
    mni_CustModi: TMenuItem;
    mni_FeesModi: TMenuItem;
    mni_splitOrder: TMenuItem;
    mni_OrderDetail: TMenuItem;
    qrytemp: TADOQuery;
    cdsTemp: TClientDataSet;
    strngfldSALES_ORDER: TStringField;
    strngfldCUST_CODE: TStringField;
    strngfld_name: TStringField;
    strngfldMANU_PART_NUMBER: TStringField;
    strngfldMANU_PART_DESC: TStringField;
    strngfldPO_NUMBER: TStringField;
    strngfldEMPLOYEE_NAME: TStringField;
    fltfldPARTS_ORDERED: TFloatField;
    fltfldPARTS_SHIPPED: TFloatField;
    strngfld_status: TStringField;
    dtmfldORIG_SCHED_SHIP_DATE: TDateTimeField;
    strngfldFOB: TStringField;
    strngfldqrytempsotp: TStringField;
    dtmfldENT_DATE: TDateTimeField;
    procedure mni_OrderDetailClick(Sender: TObject);
    procedure btnQryClick(Sender: TObject);
    procedure mni_QtyModiClick(Sender: TObject);
    procedure mni_CustModiClick(Sender: TObject);
    procedure mni_FeesModiClick(Sender: TObject);
    procedure mni_splitOrderClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    FMSql:string;
    function return_min_sysdate(Arkey60:Integer):TDateTime;//���������ί���������
    function return_max_444():TDateTime;   //�������ĳɱ���������
  public
    { Public declarations }
    procedure GetData;override;
  end;

var
  frmMain_OrderEditMarket_mod354: TfrmMain_OrderEditMarket_mod354;

implementation
  uses OrderDetailFrm_mod354,QtyEditFrm_mod354,CustEditFrm_mod354,SplitOrderFrm_mod354,ToolCostEditFrm_mod354;
{$R *.dfm}

procedure TfrmMain_OrderEditMarket_mod354.btnQryClick(Sender: TObject);
begin
  inherited;
    FMainWhereID:=0;
    cdsMainWhereInit.Append;
    cdsMainWhereInit.FieldByName('FieldName').AsString := 'data0060.ent_date';
    cdsMainWhereInit.FieldByName('Oper').AsString := '����';
    cdsMainWhereInit.FieldByName('FieldValue').AsString := FormatDateTime('yyyy-mm-dd',gfunc.GetSvrDateTime-15) +
                                  ' AND ' + FormatDateTime('YYYY-MM-DD',gfunc.GetSvrDateTime+1);
    cdsMainWhereInit.FieldByName('SeqNo').AsString := '6';
    cdsMainWhereInit.Post;
end;

procedure TfrmMain_OrderEditMarket_mod354.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  frmMain_OrderEditMarket_mod354:=nil;
end;

procedure TfrmMain_OrderEditMarket_mod354.GetData;
var
Lsql94,Lsql275:string;
begin
    try
      FMainFrmSql:= cdsMain.CommandText;

      if trim(FMainWhere) = '' then
        FMainWhere := ' and data0060.ENT_DATE >= '''+formatdatetime('yyyy-MM-dd hh:mm:ss',gFunc.GetSvrDateTime()-15)+''' '+
                       ' and  data0060.ENT_DATE <='''+formatdatetime('yyyy-MM-dd hh:mm:ss',gFunc.GetSvrDateTime()+1)+'''  ' ;

      //FOrderby := ' ORDER BY Data0015.ABBR_NAME,data0077.seq_no  ';
      //showmessage(FMainFrmSql+FMainWhere+FOrderby);

    except on e:Exception do
    begin
    ShowMessage('����'+e.Message);
    exit;
    end;
   end;
    inherited;
end;

procedure TfrmMain_OrderEditMarket_mod354.mni_CustModiClick(Sender: TObject);
var
  Lold_ponumber:string;
  Lold_fob:string;
  Lold_cust_code:string;
  Lold_REFERENCE_NUMBER:string;
  Lold_CURRENCY,LCOMMISION_ON_TOOLING,Ltax_in_price,LOCustName,LOIndate:string;
  Lold_ORIG_REQUEST_DATE:string;
  LsName,Lsql:string;
  LFrm:TfrmCustEdit_mod354 ;
  Lcds60,Lcds318,Lcds25,Lcds97:TClientDataSet;
  LPostData:OleVariant;
  i,Lrkey60:integer;
begin
  inherited;
   if not gfunc.CheckUserAuth(2,354) then
   begin
    showmessage('�Բ�����û��Ȩ��');
    exit;
   end;

   if cdsMain.FieldByName('PARTS_SHIPPED').AsFloat>0 then
    begin
      ShowMessage('�˶������г�����¼�������޸Ŀͻ�����/�ͻ�������');
      Exit;
    end;

   Lsql:='select ONHOLD_SALES_FLAG from data0025 where rkey='+cdsmain.FieldByName('CUST_PART_PTR').AsString;  //CUST_PART_PTR
   gSvrintf.IntfGetDataBySql(Lsql, cdsTemp);

  if (cdsTemp.FieldByName('ONHOLD_SALES_FLAG').AsInteger=1) then
  begin
       Lsql:= ';with CTE as '+
        ' (select data0025.MANU_PART_NUMBER,Data0025.ONHOLD_SALES_FLAG,Data0273.COPYFROMCUST_PTR,Data0273.CUSTOMER_PART_PTR'+
        ' from data0273 inner join data0025 on data0273.CUSTOMER_PART_PTR=data0025.rkey where Data0025.RKEY='+cdsmain.FieldByName('CUST_PART_PTR').AsString +
        ' union all'+
        ' select data0025.MANU_PART_NUMBER,Data0025.ONHOLD_SALES_FLAG,Data0273.COPYFROMCUST_PTR,Data0273.CUSTOMER_PART_PTR'+
        ' from Data0273 inner join Data0025 on data0273.CUSTOMER_PART_PTR=data0025.rkey'+
        ' inner join cte on data0273.COPYFROMCUST_PTR=CTE.CUSTOMER_PART_PTR)'+
        ' select * from cte where ONHOLD_SALES_FLAG=0 ';
      gSvrintf.IntfGetDataBySql(Lsql, cdsTemp);
    if not cdsTemp.IsEmpty then
    begin
      LsName:= cdsTemp.FieldByName('MANU_PART_NUMBER').AsString;
    end else
    begin
      LsName:= '��';
    end;
    if messagedlg('��ǰ���۵�����ͣ���ۣ������ı������Ϊ��'+LsName+'�����Ƿ����?',mtConFirmation,[mbYes,mbNo],0)= mrNo then Exit;
  end;

      LFrm:= TfrmCustEdit_mod354.Create(nil);
      LCds60:=TClientDataSet.Create(nil);
      LCds318:=TClientDataSet.Create(nil);
      LCds25:=TClientDataSet.Create(nil);
      LCds97:=TClientDataSet.Create(nil);

   try
      Lfrm.GetData(cdsMain.FieldByName('rkey').asstring);
      Lfrm.Frkey97:=cdsMain.fieldbyname('PURCHASE_ORDER_PTR').AsInteger;
      LFrm.Frkey10:=cdsMain.FieldByName('CUSTOMER_PTR').AsInteger;       //rkey10
      LFrm.Frkey12:=cdsMain.FieldByName('CUST_SHIP_ADDR_PTR').AsInteger;  //װ�˵�ַ12.rkey
      LFrm.edt_shipAddr.Tag:= cdsMain.FieldByName('CUST_SHIP_ADDR_PTR').AsInteger;
      Lfrm.edt_custno.hint:=cdsMain.FieldByName('CUST_CODE').asstring;

      LFrm.edt_OCustName.Text:= cdsMain.fieldbyname('ORIG_CUSTOMER').AsString;   //tao20171219  ORIG_CUSTOMER
      LFrm.edt_indate.text:= FormatDateTime('yyyy-MM-dd hh:mm:ss',cdsMain.fieldbyname('ENT_date').asdatetime); //tao20171219  ENT_DATE

      LoInDate:= FormatDateTime('yyyy-MM-dd hh:mm:ss',cdsMain.fieldbyname('ENT_date').asdatetime);  //tao20171219
      LOCustName:=cdsMain.fieldbyname('ORIG_CUSTOMER').AsString;;
      //LFrm.cds60.edit;
      Lold_ponumber:=cdsMain.FieldByName('PO_NUMBER').asstring;     //�ͻ�������PO_NUMBER
      Lold_fob:=cdsMain.FieldByName('FOB').asstring;               //��ͬ�� FOB
      Lold_cust_code:=cdsMain.FieldByName('CUST_CODE').asstring;   //CUST_CODE
      Lold_CURRENCY:=cdsMain.FieldByName('CURR_CODE').asstring;     //CURR_CODE
      Lold_REFERENCE_NUMBER:=cdsMain.FieldByName('REFERENCE_NUMBER').asstring;  //REFERENCE_NUMBER
      Lold_ORIG_REQUEST_DATE:=cdsMain.FieldByName('ORIG_REQUEST_DATE').asstring;  //ORIG_REQUEST_DATE


     Lsql:='select custciship from data0192';
     gSvrintf.IntfGetDataBySql(Lsql, cdsTemp);
    if cdsTemp.FieldByName('custciship').asstring='Y' then //�û��������޸Ļ���
     LFrm.edt_curr.Enabled:=false
    else
     LFrm.edt_curr.Enabled:=true;

   if LFrm.ShowModal=mrok then
   begin
     Lsql := 'SELECT t112.invoice_number'+#13+
                  ' FROM Data0060 t60 INNER JOIN Data0064 t64 ON t60.RKEY=t64.SO_PTR'+#13+
                  ' INNER JOIN Data0439 t439 ON t64.packing_list_ptr=t439.rkey'+#13+
                  ' INNER JOIN Data0112 t112 ON t439.invoice_ptr=t112.RKEY'+#13+
                  ' WHERE t60.RKEY='+cdsmain.FieldByName('rkey').AsString;
      gSvrintf.IntfGetDataBySql(Lsql, cdsTemp);

    if not cdsTemp.IsEmpty then
    begin
      ShowMessage('�˶�������������,�����޸Ŀͻ�����/�ͻ�������!');
      Exit;
    end;

    Lsql:='select * from data0060 where rkey='+cdsmain.FieldByName('rkey').AsString;
    gSvrIntf.IntfGetDataBySql(Lsql,Lcds60);

    for i:=2 to Lcds60.FieldCount-1 do
    begin
    Lcds60.Edit;
    Lcds60.FieldValues[Lcds60.Fields[i].FieldName]:=LFrm.cds60.FieldValues[Lcds60.Fields[i].FieldName];
    Lcds60.Post;
    end;

    Lcds60.Edit;
    Lcds60.FieldByName('ANALYSIS_CODE_1').Value:=Lfrm.cds60.FieldByName('ANALYSIS_CODE_1').asstring; //ANALYSIS_CODE_1
    Lcds60.Post;

    LSql:='select * from data0318 where 1=2';
    gSvrintf.IntfGetDataBySql(Lsql, Lcds318);

    //1.���Ŀͻ�
      if LFrm.edt_custNo.text<>Lold_cust_code then
      begin
          if not Lfrm.chk2.Checked then   //��ת��
            LCOMMISION_ON_TOOLING:='N'
          else
            LCOMMISION_ON_TOOLING:='Y';

          if not LFrm.chk1.Checked then   //�۸񲻺�˰
            Ltax_in_price:='N'
          else
            Ltax_in_price:='Y';

        Lcds60.Edit;
        Lcds60.FieldByName('CUSTOMER_PTR').Value:=Lfrm.cds60.FieldByName('CUSTOMER_PTR').asinteger;
        Lcds60.FieldByName('COMMISION_ON_TOOLING').Value:=LCOMMISION_ON_TOOLING;
        Lcds60.FieldByName('tax_in_price').Value:=Ltax_in_price;
        //Lcds60.FieldByName('exch_rate').Value:=Lfrm.cds60.FieldByName('exch_rate').Value;
        Lcds60.Post;

        Lcds318.Append;
        Lcds318.fieldbyname('SALES_ORDER_PTR').value:=cdsMain.FieldByName('rkey').asinteger;
        Lcds318.fieldbyname('TRANS_TYPE').value:=1;
        Lcds318.fieldbyname('TRANS_DESCRIPTION').value:='���Ŀͻ�����';
        Lcds318.fieldbyname('FROM_STRING').value:= Lold_cust_code;
        Lcds318.fieldbyname('TO_STRING').value:=LFrm.edt_custNo.text;
        Lcds318.fieldbyname('USER_PTR').value:= StrToInt(gVar.rkey73);
        Lcds318.fieldbyname('TRANS_DATE').value:= Now;
        Lcds318.fieldbyname('PROGRAM_SOURCE').value:= 305;
        Lcds318.fieldbyname('file_number').value:= Trim(Lfrm.edt_file.Text);
        Lcds318.Post;
      end;

      //2.��¼���Ļ���
      if Lfrm.edt_curr.Text<>Lold_CURRENCY then
      begin
        Lcds60.Edit;
        Lcds60.FieldByName('CURRENCY_PTR').Value:=Lfrm.cds60.FieldByName('CURRENCY_PTR').asinteger;
        Lcds60.FieldByName('EXCH_RATE').Value:=Lfrm.cds60.FieldByName('EXCH_RATE').asfloat;
        Lcds60.Post;

        Lcds318.Append;
        Lcds318.fieldbyname('SALES_ORDER_PTR').value:=cdsMain.FieldByName('rkey').asinteger;
        Lcds318.fieldbyname('TRANS_TYPE').value:=1;
        Lcds318.fieldbyname('TRANS_DESCRIPTION').value:='���Ļ���';
        Lcds318.fieldbyname('FROM_STRING').value:= Lold_CURRENCY;
        Lcds318.fieldbyname('TO_STRING').value:=LFrm.edt_curr.text;
        Lcds318.fieldbyname('USER_PTR').value:= StrToInt(gVar.rkey73);
        Lcds318.fieldbyname('TRANS_DATE').value:= Now;
        Lcds318.fieldbyname('PROGRAM_SOURCE').value:= 305;
        Lcds318.fieldbyname('file_number').value:= Trim(Lfrm.edt_file.Text);
        Lcds318.Post;

       Lsql:='select * From data0025 where rkey='+cdsmain.FieldByName('CUST_PART_PTR').asstring;
       gSvrintf.IntfGetDataBySql(Lsql, Lcds25);

        Lcds25.Edit;
        Lcds25.FieldByName('latest_price').Value:=formatfloat('0.0000',cdsMain.FieldByName('PARTS_ALLOC').asfloat/  //PARTS_ALLOC
                                     strtofloat(LFrm.edt_rate.Text)) ;
        Lcds25.Post;
      end;

      //3.��¼����װ�˵�ַ
      if Lfrm.Frkey12<>cdsMain.Fieldbyname('CUST_SHIP_ADDR_PTR').asinteger then  //CUST_SHIP_ADDR_PTR
      begin
        Lcds60.Edit;
        Lcds60.FieldByName('CUST_SHIP_ADDR_PTR').Value:=Lfrm.edt_shipAddr.tag;
        Lcds60.FieldByName('SHIPPING_CONTACT').Value:=Lfrm.cds60.FieldByName('SHIPPING_CONTACT').asstring;
        Lcds60.FieldByName('SHIP_CONTACT_PHONE').Value:=Lfrm.cds60.FieldByName('SHIP_CONTACT_PHONE').asstring;
        Lcds60.FieldByName('RUSH_CHARGE').Value:=Lfrm.cds60.FieldByName('RUSH_CHARGE').AsFloat;  //RUSH_CHARGE
        Lcds60.Post;

        Lcds318.Append;
        Lcds318.fieldbyname('SALES_ORDER_PTR').value:=cdsMain.FieldByName('rkey').asinteger;
        Lcds318.fieldbyname('TRANS_TYPE').value:=1;
        Lcds318.fieldbyname('TRANS_DESCRIPTION').value:='����װ�˵�ַ';
        Lcds318.fieldbyname('FROM_STRING').value:= cdsMain.FieldByName('LOCATION').AsString;
        Lcds318.fieldbyname('TO_STRING').value:=LFrm.cds60.FieldByName('LOCATION').AsString;
        Lcds318.fieldbyname('USER_PTR').value:= StrToInt(gVar.rkey73);
        Lcds318.fieldbyname('TRANS_DATE').value:= Now;
        Lcds318.fieldbyname('PROGRAM_SOURCE').value:= 305;
        Lcds318.fieldbyname('file_number').value:= Trim(Lfrm.edt_file.Text);
        Lcds318.Post;
      end;

      //4. 97
      if Lfrm.Frkey97 <> cdsMain.FieldByName('PURCHASE_ORDER_PTR').asinteger then  //PURCHASE_ORDER_PTR
      begin
        Lcds60.Edit;
        Lcds60.FieldByName('PURCHASE_ORDER_PTR').Value:=Lfrm.Frkey97;
        Lcds60.Post;

        Lcds318.Append;
        Lcds318.fieldbyname('SALES_ORDER_PTR').value:=cdsMain.FieldByName('rkey').asinteger;
        Lcds318.fieldbyname('TRANS_TYPE').value:=1;
        Lcds318.fieldbyname('TRANS_DESCRIPTION').value:='���Ŀͻ�������';
        Lcds318.fieldbyname('FROM_STRING').value:= Lold_ponumber;
        Lcds318.fieldbyname('TO_STRING').value:=LFrm.cds60.FieldByName('PO_NUMBER').asstring;
        Lcds318.fieldbyname('USER_PTR').value:= StrToInt(gVar.rkey73);
        Lcds318.fieldbyname('TRANS_DATE').value:= Now;
        Lcds318.fieldbyname('PROGRAM_SOURCE').value:= 305;
        Lcds318.fieldbyname('file_number').value:= Trim(Lfrm.edt_file.Text);
        Lcds318.Post;

        LSql:='select * From data0097  where rkey='+inttostr(LFrm.Frkey97);
        gSvrintf.IntfGetDataBySql(Lsql, Lcds97);

        Lcds97.Edit;
        Lcds97.FieldByName('po_date').Value:=Lfrm.cds60.FieldByName('po_date').AsDateTime;
        Lcds97.Post;
      end;

      //5.��ͬ��
      if Lfrm.cds60.FieldByName('fob').AsString<>Lold_fob then
      begin
        Lcds60.Edit;
        Lcds60.FieldByName('FOB').Value:=Lfrm.cds60.FieldByName('fob').AsString;
        Lcds60.Post;

        Lcds318.Append;
        Lcds318.fieldbyname('SALES_ORDER_PTR').value:=cdsMain.FieldByName('rkey').asinteger;
        Lcds318.fieldbyname('TRANS_TYPE').value:=1;
        Lcds318.fieldbyname('TRANS_DESCRIPTION').value:='���ĺ�ͬ��FOB';
        Lcds318.fieldbyname('FROM_STRING').value:= Lold_fob;
        Lcds318.fieldbyname('TO_STRING').value:=Lfrm.cds60.FieldByName('fob').AsString;
        Lcds318.fieldbyname('USER_PTR').value:= StrToInt(gVar.rkey73);
        Lcds318.fieldbyname('TRANS_DATE').value:= Now;
        Lcds318.fieldbyname('PROGRAM_SOURCE').value:= 305;
        Lcds318.fieldbyname('file_number').value:= Trim(Lfrm.edt_file.Text);
        Lcds318.Post;
      end;

      //6.�ͻ������Ÿ���
      if Lfrm.cds60.FieldByName('REFERENCE_NUMBER').asstring<>Lold_REFERENCE_NUMBER then    //REFERENCE_NUMBER
      begin
        Lcds60.Edit;
        Lcds60.FieldByName('REFERENCE_NUMBER').Value:=Lfrm.cds60.FieldByName('REFERENCE_NUMBER').asstring;
        Lcds60.Post;

        Lcds318.Append;
        Lcds318.fieldbyname('SALES_ORDER_PTR').value:=cdsMain.FieldByName('rkey').asinteger;
        Lcds318.fieldbyname('TRANS_TYPE').value:=1;
        Lcds318.fieldbyname('TRANS_DESCRIPTION').value:='���Ĳο���ע';
        Lcds318.fieldbyname('FROM_STRING').value:= Lold_REFERENCE_NUMBER;
        Lcds318.fieldbyname('TO_STRING').value:=Lfrm.cds60.FieldByName('REFERENCE_NUMBER').asstring;
        Lcds318.fieldbyname('USER_PTR').value:= StrToInt(gVar.rkey73);
        Lcds318.fieldbyname('TRANS_DATE').value:= Now;
        Lcds318.fieldbyname('PROGRAM_SOURCE').value:= 305;
        Lcds318.fieldbyname('file_number').value:= Trim(Lfrm.edt_file.Text);
        Lcds318.Post;
      end;

    //7.�ͻ������޸�-------
      if (Lfrm.cds60.FieldByName('ORIG_REQUEST_DATE').value<>Lold_ORIG_REQUEST_DATE) then  //ORIG_REQUEST_DATE
      begin
        Lcds60.Edit;
        Lcds60.FieldByName('ORIG_REQUEST_DATE').Value:=Lfrm.cds60.FieldByName('ORIG_REQUEST_DATE').AsDateTime;
        Lcds60.Post;

        Lcds318.Append;
        Lcds318.fieldbyname('SALES_ORDER_PTR').value:=cdsMain.FieldByName('rkey').asinteger;
        Lcds318.fieldbyname('TRANS_TYPE').value:=1;
        Lcds318.fieldbyname('TRANS_DESCRIPTION').value:='���Ŀͻ�����';
        Lcds318.fieldbyname('FROM_STRING').value:= Lold_ORIG_REQUEST_DATE;
        Lcds318.fieldbyname('TO_STRING').value:=DateToStr(Lfrm.cds60.FieldByName('ORIG_REQUEST_DATE').AsDateTime);
        Lcds318.fieldbyname('USER_PTR').value:= StrToInt(gVar.rkey73);
        Lcds318.fieldbyname('TRANS_DATE').value:= Now;
        Lcds318.fieldbyname('PROGRAM_SOURCE').value:= 305;
        Lcds318.fieldbyname('file_number').value:= Trim(Lfrm.edt_file.Text);
        Lcds318.Post;
      end;

      //8.�µ�����-------
      if (Lfrm.cds60.FieldByName('ENT_date').value <>LoInDate) then  //ORIG_REQUEST_DATE
      begin
        Lcds60.Edit;
        Lcds60.FieldByName('ENT_date').Value:=Lfrm.cds60.FieldByName('ENT_date').AsDateTime;
        Lcds60.Post;

        Lcds318.Append;
        Lcds318.fieldbyname('SALES_ORDER_PTR').value:=cdsMain.FieldByName('rkey').AsInteger ;
        Lcds318.fieldbyname('TRANS_TYPE').value:=1;
        Lcds318.fieldbyname('TRANS_DESCRIPTION').value:='�����µ�����';
        Lcds318.fieldbyname('FROM_STRING').value:= LoInDate;
        Lcds318.fieldbyname('TO_STRING').value:=DateToStr(Lfrm.cds60.FieldByName('ENT_date').AsDateTime);
        Lcds318.fieldbyname('USER_PTR').value:= StrToInt(gVar.rkey73);
        Lcds318.fieldbyname('TRANS_DATE').value:= Now;
        Lcds318.fieldbyname('PROGRAM_SOURCE').value:= 305;
        Lcds318.fieldbyname('file_number').value:= Trim(Lfrm.edt_file.Text);
        Lcds318.Post;
      end;

    //9.ԭ�����ͻ�����
      if Lfrm.cds60.FieldByName('ORIG_CUSTOMER').AsString<> LOCustName then    //REFERENCE_NUMBER
      begin
        Lcds60.Edit;
        Lcds60.FieldByName('ORIG_CUSTOMER').Value:=Lfrm.cds60.FieldByName('ORIG_CUSTOMER').AsString;
        Lcds60.Post;

        Lcds318.Append;
        Lcds318.fieldbyname('SALES_ORDER_PTR').value:=cdsMain.FieldByName('rkey').AsInteger;
        Lcds318.fieldbyname('TRANS_TYPE').value:=1;
        Lcds318.fieldbyname('TRANS_DESCRIPTION').value:='����ԭ�����ͻ�';
        Lcds318.fieldbyname('FROM_STRING').value:=  LOCustName;
        Lcds318.fieldbyname('TO_STRING').value:=Lfrm.cds60.FieldByName('ORIG_CUSTOMER').asstring;
        Lcds318.fieldbyname('USER_PTR').value:= StrToInt(gVar.rkey73);
        Lcds318.fieldbyname('TRANS_DATE').value:= Now;
        Lcds318.fieldbyname('PROGRAM_SOURCE').value:= 305;
        Lcds318.fieldbyname('file_number').value:= Trim(Lfrm.edt_file.Text);
        Lcds318.Post;
      end;

      Lrkey60:= cdsMain.fieldbyname('rkey').asinteger;
       LPostData := varArrayCreate([0,3], varVariant);
      if Lcds60.ChangeCount>0 then
       LPostData[0] := Lcds60.Delta;
      if Lcds318.ChangeCount>0 then
       LPostData[1] := Lcds318.Delta;
      if Lcds25.ChangeCount>0 then
       LPostData[2] := Lcds25.Delta;
      if Lcds97.ChangeCount>0 then
       LPostData[3] := Lcds97.Delta;

      if gSvrIntf.IntfPostModData('��������', 354, LPostData,2) then
      begin
        showmessage('�޸ĳɹ�!');
        btnRefreshClick(sender);
        cdsMain.Locate('rkey',LRkey60,[]);
      end;
   end;
  finally
    Lfrm.Free;
    Lcds60.free;
    Lcds318.free;
    Lcds25.free;
    Lcds97.free;
  end;
end;

procedure TfrmMain_OrderEditMarket_mod354.mni_FeesModiClick(Sender: TObject);
var
LFrm:TfrmToolCostEdit_mod354 ;
 i,n:byte;
 Ltotal_amount,Lamount:double;
 Linvoice_number:string;
 LsName,Lsql:string;
 Lcds60,Lcds318,Lcds62:TClientDataSet;
 LpostData:OleVariant;
 Lrkey60:Integer;
begin
  inherited;
  if not gFunc.CheckUserAuth(3,354) then
  begin
    showmessage('�Բ�����ֻ�иó����ֻ��Ȩ��');
    exit;
  end;
 //�޸��ύ֮ǰ�鿴�����汾�Ƿ���Ч������ʾ�°汾---
   Lsql:='select ONHOLD_SALES_FLAG from data0025 where rkey='+cdsMain.FieldByName('CUST_PART_PTR').AsString;
   gSvrintf.IntfGetDataBySql(Lsql, cdsTemp);
   if (cdstemp.FieldByName('ONHOLD_SALES_FLAG').AsInteger=1) then  //��ͣ����
   begin
       Lsql:=' ;with CTE as  '+
      ' (select data0025.MANU_PART_NUMBER,Data0025.ONHOLD_SALES_FLAG,Data0273.COPYFROMCUST_PTR,Data0273.CUSTOMER_PART_PTR '+
      ' from data0273 inner join data0025 on data0273.CUSTOMER_PART_PTR=data0025.rkey'+
      ' where Data0025.RKEY='+cdsmain.fieldbyname('CUST_PART_PTR').asstring+
      ' union all'+
      ' select data0025.MANU_PART_NUMBER,Data0025.ONHOLD_SALES_FLAG,Data0273.COPYFROMCUST_PTR,Data0273.CUSTOMER_PART_PTR'+
      ' from Data0273'+
      ' inner join Data0025 on data0273.CUSTOMER_PART_PTR=data0025.rkey'+
      ' inner join cte on data0273.COPYFROMCUST_PTR=CTE.CUSTOMER_PART_PTR )'+
      ' select * from cte where ONHOLD_SALES_FLAG=0' ;
      gSvrintf.IntfGetDataBySql(Lsql, cdsTemp);

    if not Cdstemp.IsEmpty then
    begin
      LsName:=Cdstemp.FieldByName('MANU_PART_NUMBER').AsString;
    end else
    begin
      LsName:= '��';
    end;
    if messagedlg('��ǰ���۵��ͺ�����ͣ���ۣ������ı������Ϊ��'+LsName+'�����Ƿ����?',mtConFirmation,[mbYes,mbNo],0)= mrNo then Exit;
   end;

  LSql:='select rkey,invoice_number from data0112 '+
    ' where sales_order_ptr='+cdsMain.FieldByName('rkey').AsString +
    ' and invoice_type=2 and invoice_status<>3';
   gSvrintf.IntfGetDataBySql(Lsql, cdsTemp);
    Linvoice_number:=cdsTemp.fieldbyname('invoice_number').AsString;

   if not cdsTemp.IsEmpty then
   begin
    showmessage('���۶��������ɹ����÷�Ʊ,�����޸����������ϵ!'+Linvoice_number) ;
    exit;
   end;

  LFrm:= TfrmToolCostEdit_mod354.Create(self);
  LFrm.Frkey60:=cdsMain.fieldbyname('rkey').asinteger;
  Lcds60:=TClientDataSet.Create(nil);
  Lcds318:=TClientDataSet.Create(nil);
  Lcds62:=TClientDataSet.Create(nil);

  try
   if LFrm.ShowModal=mrok then
   begin
    Lsql:='select * from data0062 where so_ptr='+cdsMain.FieldByName('rkey').AsString;
    gSvrintf.IntfGetDataBySql(Lsql, Lcds62);

      //������ݿ��е����������ǰ�Ƿ�һ��
      if not Lcds62.isempty then
      while not Lcds62.Eof do
      begin
        with Lcds62 do
        begin
          for n:=0 to LFrm.sg1.RowCount-1 do
          begin
           if ((Lcds62.FieldByName('ADDL_CAT_PTR').AsString = LFrm.LStr[5,n]) and (
              (LFrm.LStr[1,n]<>formatfloat('0.000',Lcds62.fieldbyname('amount').AsCurrency)) or
              (LFrm.LStr[2,n]<>formatfloat('0.000',Lcds62.fieldbyname('free_amount').AsCurrency)) or
              (LFrm.LStr[3,n]<>formatfloat('0.000',Lcds62.fieldbyname('costfree_amount').AsCurrency)) or
              (LFrm.LStr[4,n]<>Lcds62.FieldByName('TAX_FLAG').AsString))) then
           begin
             showmessage('���ݳ����쳣,�����Ƕ��˲������𣬱���ʧ�ܣ�������');
             Exit;
           end;
          end;
          Lcds62.Next;
        end;
      end;

        if not Lcds62.isempty then
        begin
        Lcds62.First;
        while not Lcds62.Eof do Lcds62.Delete; //���Ƚ���ȫ��ɾ��
        Ltotal_amount:=0;
        end;

        for i:=1 to LFrm.sg1.rowcount-2 do
        if (strtofloat(LFrm.sg1.Cells[1,i])>0) or
          (strtofloat(LFrm.sg1.Cells[2,i])>0) or
          (strtofloat(LFrm.sg1.Cells[3,i])>0) then
        begin
          Lcds62.Append;
          Lcds62.Fieldvalues['so_ptr'] := cdsMain.FieldByName('rkey').asinteger;
          Lcds62.FieldByName('addl_cat_ptr').asstring :=LFrm.sg1.Cells[5,i];
          Lcds62.FieldByName('TAX_flag').AsString := LFrm.sg1.Cells[4,i];
          Lcds62.FieldByName('free_amount').asstring := LFrm.sg1.Cells[2,i];
          Lcds62.FieldByName('amount').asstring := LFrm.sg1.Cells[1,i];
          Lcds62.FieldByName('costfree_amount').asstring := LFrm.sg1.Cells[3,i];

          Ltotal_amount:=Ltotal_amount+Lcds62.FieldValues['amount'];
          Lcds62.post;
        end;

       Lsql:='select * from data0060 where rkey='+cdsMain.fieldbyname('rkey').asstring;
       gSvrIntf.IntfGetDataBySql(Lsql,LCds60);

        Lamount:=cdsMain.FieldByName('TOTAL_ADD_L_PRICE').AsFloat;   //TOTAL_ADD_L_PRICE
        LCds60.Edit;
        LCds60.FieldByName('TOTAL_ADD_L_PRICE').Value := Ltotal_amount;
        LCds60.Post;
        if Lamount<>Ltotal_amount then  //��¼���۶�������(��־�ļ�)
        begin
        Lsql:='select * From data0318 where 1=2';
         gSvrIntf.IntfGetDataBySql(Lsql,LCds318);
        Lcds318.Append;
        Lcds318.fieldbyname('SALES_ORDER_PTR').value:=cdsMain.FieldByName('rkey').asinteger;
        Lcds318.fieldbyname('TRANS_TYPE').value:=12;
        Lcds318.fieldbyname('TRANS_DESCRIPTION').value:='�������۶������߷���';
        Lcds318.fieldbyname('FROM_STRING').value:= FloatToStr(Lamount);
        Lcds318.fieldbyname('TO_STRING').value:=FloatToStr(Ltotal_amount);
        Lcds318.fieldbyname('USER_PTR').value:= StrToInt(gVar.rkey73);
        Lcds318.fieldbyname('TRANS_DATE').value:= Now;
        Lcds318.fieldbyname('PROGRAM_SOURCE').value:= 305;
        Lcds318.Post;
        end;

      LPostData := varArrayCreate([0,2], varVariant);
      if Lcds60.ChangeCount>0 then
       LPostData[0] := Lcds60.Delta;
      if Lcds318.ChangeCount>0 then
       LPostData[1] := Lcds318.Delta;
      if Lcds62.ChangeCount>0 then
       LPostData[2] := Lcds62.Delta;

      Lrkey60:= cdsMain.fieldbyname('rkey').asinteger;
      if gSvrIntf.IntfPostModData('��������', 354, LPostData,4) then
      begin
        showmessage('�޸ĳɹ�!');
        btnRefreshClick(sender);
        cdsMain.Locate('rkey',LRkey60,[]);
      end;
   end;
  finally
    Lfrm.Free;
    Lcds60.free;
    LCds318.free;
    LCds62.free;
  end;
end;

procedure TfrmMain_OrderEditMarket_mod354.mni_OrderDetailClick(Sender: TObject);
var
LFrm: TfrmOrderDetail_mod354;
begin
  inherited;
  Lfrm:=TfrmOrderDetail_mod354.Create(nil);
  try
    LFrm.getdata(cdsMain.FieldByName('rkey').AsString);
    LFrm.edt_man.Text:= cdsmain.FieldByName('SHIPPING_CONTACT').asstring; //SHIPPING_CONTACT
    LFrm.edt_tel.Text:= cdsmain.FieldByName('SHIP_CONTACT_PHONE').asstring; //SHIP_CONTACT_PHONE
    Lfrm.ShowModal;
  finally
    Lfrm.Free;
  end;
end;

procedure TfrmMain_OrderEditMarket_mod354.mni_QtyModiClick(Sender: TObject);
var
LFrm:TfrmQtyEdit_mod354 ;
Lsql:string;
LPostData:OleVariant;
 Lparts_ordered:integer;
 Lparts_price:double;
 Ldue_date:tdatetime;
 LsName:string;
 Lcds318,Lcds60,Lcds25,Lcds53:TClientDataSet;
 i:integer;
 Lrkey60:integer;
 begin
  inherited;

   if not gfunc.CheckUserAuth(1, 354) then
   begin
    showmessage('�Բ�����ֻ�иó����ֻ��Ȩ��');
    exit;
   end;

  Lsql:=' select rkey from data0064 where SO_PTR='+cdsmain.FieldByName('rkey').AsString;
  gSvrintf.IntfGetDataBySql(Lsql, cdsTemp);

  if not cdsTemp.IsEmpty then
  begin
    ShowMessage('�����Ѿ������ͻ���¼,�������޸�,����ֿ���ϵ�˲ֺ����޸�!');
    Exit;
  end;

 // �޸��ύ֮ǰ�鿴�����汾�Ƿ���Ч������ʾ�°汾---
  Lsql:='select ONHOLD_SALES_FLAG from data0025 where rkey='+cdsmain.fieldbyname('CUST_PART_PTR').asstring;
  gSvrintf.IntfGetDataBySql(Lsql, cdsTemp);

  if (cdsTemp.FieldByName('ONHOLD_SALES_FLAG').AsInteger=1) then
  begin
   Lsql:=' ;with CTE as  '+
      ' (select data0025.MANU_PART_NUMBER,Data0025.ONHOLD_SALES_FLAG,Data0273.COPYFROMCUST_PTR,Data0273.CUSTOMER_PART_PTR '+
      ' from data0273 inner join data0025 on data0273.CUSTOMER_PART_PTR=data0025.rkey'+
      ' where Data0025.RKEY='+cdsmain.fieldbyname('CUST_PART_PTR').asstring+
      ' union all'+
      ' select data0025.MANU_PART_NUMBER,Data0025.ONHOLD_SALES_FLAG,Data0273.COPYFROMCUST_PTR,Data0273.CUSTOMER_PART_PTR'+
      ' from Data0273'+
      ' inner join Data0025 on data0273.CUSTOMER_PART_PTR=data0025.rkey'+
      ' inner join cte on data0273.COPYFROMCUST_PTR=CTE.CUSTOMER_PART_PTR )'+
      ' select * from cte where ONHOLD_SALES_FLAG=0' ;
      gSvrintf.IntfGetDataBySql(Lsql, cdsTemp);

    if not cdsTemp.IsEmpty then
    begin
      LsName:= cdsTemp.FieldByName('MANU_PART_NUMBER').AsString;
    end else
    begin
      LsName:= '��';
    end;
    if messagedlg('��ǰ���۵�����ͣ���ۣ������ı������Ϊ��'+LsName+'�����Ƿ����?',mtConFirmation,[mbYes,mbNo],0)= mrNo then Exit;
  end;

   LFrm:= TfrmQtyEdit_mod354.Create(self);
   Lcds60:=TClientDataSet.Create(nil);
   Lcds318:=TClientDataSet.Create(nil);
   Lcds25:=TClientDataSet.Create(nil);
   Lcds53:=TClientDataSet.Create(nil);

  try

    Lfrm.GetData(cdsMain.FieldByName('rkey').AsString);

    Lparts_ordered:= cdsMain.FieldByName('PARTS_ORDERED').AsInteger;
    LFrm.FParts_ordered:=cdsMain.FieldByName('PARTS_ORDERED').AsInteger;
    LFrm.FParts_ordered:=cdsMain.FieldByName('PARTS_ORDERED').AsInteger;  //PARTS_ORDERED
    Lparts_price := cdsMain.FieldByName('part_price').Value;  //part_price
    Ldue_date :=  cdsMain.FieldByName('ORIG_SCHED_SHIP_DATE').AsDateTime ;//ԭ�ƻ����� ORIG_SCHED_SHIP_DATE

    // �޸���Ԥ�����µ����������޸�
    if cdsMain.FieldByName('rkey213').Value>0 then
    begin
      Lfrm.dbedt_set_ordered.Enabled:=False;
      Lfrm.dbedt_PARTS_ORDERED.Enabled:=False;
    end;

   if LFrm.ShowModal = mrok then
   begin
    Lsql := 'select rkey from data0064 where SO_PTR='+cdsMain.FieldByName('rkey').AsString;
    gSvrintf.IntfGetDataBySql(Lsql, cdsTemp);

      if not cdsTemp.IsEmpty then  //���ٴμ��
      begin
        ShowMessage('�����Ѿ������ͻ���¼,�������޸�,����ֿ���ϵ�˲ֺ����޸�!');
        Exit;
      end;
    if cdsMain.FieldByName('so_tp').Value=1 then //�������Ϊ�ⷢ����  so_tp
    if return_min_sysdate(cdsMain.FieldByName('rkey').Value) < return_max_444 then
    begin
      ShowMessage('ί�ⶩ���Ѿ�������ڳɱ���������֮ǰ,�������޸�!');
      Exit;
    end;

    Lsql:='select * from data0318 where 1=2';
    gSvrIntf.IntfGetDataBySql(Lsql,Lcds318);

    Lsql:='select * from data0060 where rkey='+cdsmain.FieldByName('rkey').AsString;
    gSvrIntf.IntfGetDataBySql(Lsql,Lcds60);

    for i:=2 to Lcds60.FieldCount-1 do
    begin
    Lcds60.Edit;
    Lcds60.FieldValues[Lcds60.Fields[i].FieldName]:=LFrm.cds60.FieldValues[Lcds60.Fields[i].FieldName];
    Lcds60.Post;
    end;

    Lcds60.Edit;
    //���۶�����������
    if LFrm.cds60.FieldByName('PARTS_ORDERED').asinteger <> Lparts_ordered then  //PARTS_ORDERED
    begin  // to_be_planned         PARTS_ORDERED          qty_plannned

     Lcds60.FieldByName('PARTS_ORDERED').Value:=LFrm.cds60.FieldByName('PARTS_ORDERED').asinteger;
     Lcds60.FieldByName('to_be_planned').Value:=LFrm.cds60.FieldByName('PARTS_ORDERED').asinteger-cdsMain.FieldByName('qty_plannned').asinteger;
     Lcds60.FieldByName('set_ORDERED').Value:= LFrm.cds60.FieldByName('set_ORDERED').asinteger;

     if LFrm.cds60.FieldByName('PARTS_ORDERED').asinteger-cdsMain.FieldByName('qty_plannned').asinteger <= 0 then
      Lcds60.FieldByName('prod_rel').Value:='3';  //�������ű��Ϊ��Ͷ��

       //��¼���۶��������������(��־�ļ�)
      Lcds318.Append;
      Lcds318.FieldByName('SALES_ORDER_PTR').Value:=cdsMain.FieldByName('rkey').asinteger;
      Lcds318.FieldByName('TRANS_TYPE').Value:=2;
      Lcds318.FieldByName('TRANS_DESCRIPTION').Value:= '�������۶�������pcs';
      Lcds318.FieldByName('FROM_string').Value:= LPARTs_ordered;
      Lcds318.FieldByName('TO_string').Value:=LFrm.cds60.FieldByName('PARTS_ORDERED').asinteger;
      Lcds318.FieldByName('USER_PTR').Value:= gVar.rkey73;
      Lcds318.FieldByName('TRANS_DATE').Value:= Now;
      Lcds318.FieldByName('PROGRAM_SOURCE').Value:= 305;
      Lcds318.FieldByName('file_number').Value:=trim(LFrm.edt_file.Text);
      Lcds318.post;
    end;


   //���۶����۸����
      if Lfrm.cds60.FieldByName('part_price').Value<>Lparts_price then
      begin
        //��¼���۶����۸�������(��־�ļ�)
        Lcds318.Append;
        Lcds318.FieldByName('SALES_ORDER_PTR').Value:=cdsMain.FieldByName('rkey').asinteger;
        Lcds318.FieldByName('TRANS_TYPE').Value:=3;
        Lcds318.FieldByName('TRANS_DESCRIPTION').Value:= '�������۶����۸�pcs';
        Lcds318.FieldByName('FROM_string').Value:= Lparts_price;
        Lcds318.FieldByName('TO_string').Value:=Lfrm.cds60.FieldByName('part_price').AsString;
        Lcds318.FieldByName('USER_PTR').Value:= gVar.rkey73;
        Lcds318.FieldByName('TRANS_DATE').Value:= Now;
        Lcds318.FieldByName('PROGRAM_SOURCE').Value:= 305;
        Lcds318.FieldByName('file_number').Value:=trim(LFrm.edt_file.Text);
        Lcds318.post;

          if Lfrm.cds60.FieldByName('part_price').Value<>0 then
          begin
           Lsql:='select * From data0025 where rkey='+cdsmain.FieldByName('CUST_PART_PTR').AsString;
           gSvrIntf.IntfGetDataBySql(Lsql,Lcds25);
           LCds25.Edit;
           if LFrm.cds60.FieldByName('tax_in_price').Value='N' then          //part_price    EXCH_RATE
           Lcds25.FieldByName('latest_price').Value:= formatfloat('0.0000', LFrm.cds60.FieldByName('part_price').asfloat/
                                                              LFrm.cds60.FieldByName('EXCH_RATE').asfloat)
           else
           Lcds25.FieldByName('latest_price').Value:=  formatfloat('0.0000', LFrm.cds60.FieldByName('part_price').asfloat/LFrm.cds60.FieldByName('EXCH_RATE').asfloat/
                                  (1+LFrm.cds60.FieldByName('RUSH_CHARGE').asfloat*0.01) );  //RUSH_CHARGE
           Lcds25.Post;
          end;

         Lcds60.FieldByName('part_price').Value:= Lfrm.cds60.FieldByName('part_price').asfloat;
         Lcds60.FieldByName('set_price').Value:= LFrm.cds60.FieldByName('set_price').asfloat;

         Lcds60.post;
         Lcds60.edit;
        if Lfrm.cds60.FieldByName('tax_in_price').Value='N' then   // �۸��Ƿ�˰ tax_in_price
          Lcds60.FieldByName('parts_alloc').Value:=Lfrm.cds60.FieldByName('part_price').asfloat   //����˰�۸�PCS parts_alloc    part_price
        else
          Lcds60.FieldByName('parts_alloc').Value:=Lfrm.cds60.FieldByName('part_price').asfloat/
                                (1+Lfrm.cds60.FieldByName('RUSH_CHARGE').asfloat*0.01); //��ֵ˰��% RUSH_CHARGE
        Lcds60.post;
        Lcds60.edit;
        Lcds60.FieldByName('parts_alloc1').Value:=Lcds60.FieldByName('parts_alloc').asfloat;
      end;

    //���۶����ƻ����ڸ���
     if Ldue_DATE <> LFrm.cds60.FieldByName('ORIG_SCHED_SHIP_DATE').AsDateTime then   //ORIG_SCHED_SHIP_DATE
     begin

      Lcds60.FieldByName('ORIG_SCHED_SHIP_DATE').Value:=LFrm.cds60.FieldByName('ORIG_SCHED_SHIP_DATE').AsDateTime;

     if LFrm.cds60.FieldByName('PARTS_ORDERED').AsInteger<=Lfrm.cds60.FieldByName('PARTS_SHIPPED').AsInteger then  //PARTS_SHIPPED
       Lcds60.FieldByName('status').Value:=4; //��ʶ���������

      //��¼���۶����ƻ����ڸ������(��־�ļ�)
      Lcds318.Append;
      Lcds318.FieldByName('SALES_ORDER_PTR').Value:=cdsMain.FieldByName('rkey').AsInteger;
      Lcds318.FieldByName('TRANS_TYPE').Value:=4;
      Lcds318.FieldByName('TRANS_DESCRIPTION').Value:= '�������۶����ƻ�����';
      Lcds318.FieldByName('FROM_string').Value:= Ldue_DATE;
      Lcds318.FieldByName('TO_string').Value:=LFrm.cds60.FieldByName('ORIG_SCHED_SHIP_DATE').AsDateTime;
      Lcds318.FieldByName('USER_PTR').Value:= gVar.rkey73;
      Lcds318.FieldByName('TRANS_DATE').Value:= Now;
       Lcds318.FieldByName('PROGRAM_SOURCE').Value:= 305;
      Lcds318.FieldByName('file_number').Value:=trim(LFrm.edt_file.Text);
      Lcds318.post;
      end;

     if ( Lfrm.cds60.FieldByName('part_price').AsFloat<>Lparts_price ) and (LFrm.cds60.FieldByName('so_tp').asinteger=1) then
     begin   //so_tp �������

     Lsql:= ' select data0053.* FROM  Data0053 INNER JOIN'+#13+
       ' data0416 ON Data0053.NPAD_PTR = data0416.rkey INNER JOIN'+#13+
       ' ata0060 ON data0416.so_ptr = Data0060.RKEY INNER JOIN'+#13+
       ' Data0025 ON Data0053.CUST_PART_PTR = Data0025.RKEY'+#13+
       ' where data0416.type=3'+#13+
       ' and data0416.so_ptr='+cdsMain.FieldByName('rkey').AsString;
      gSvrIntf.IntfGetDataBySql(LSql,Lcds53);
      if not Lcds53.IsEmpty  then
      begin
      Lcds53.Edit;
      Lcds53.FieldByName('cost_pcs').Value:=Lfrm.cds60.FieldByName('PARTS_ALLOC').AsFloat*Lfrm.cds60.FieldByName('TAX_2').AsFloat
            *0.01/Lfrm.cds60.FieldByName('EXCH_RATE').AsFloat ;
      Lcds53.Post;
      end;
      end;

      Lcds60.Post;
     LPostData := varArrayCreate([0, 4], varVariant);
    if Lcds318.ChangeCount>0 then
     LPostData[0] := Lcds318.Delta;
    if Lcds25.ChangeCount>0 then
     LPostData[1] := Lcds25.Delta;
    if Lcds60.ChangeCount>0 then
     LPostData[2] := Lcds60.Delta;
    if Lcds53.ChangeCount>0 then
     LPostData[3] := Lcds53.Delta;
    if Lfrm.cds360.ChangeCount>0 then
     LPostData[4] := Lfrm.cds360.Delta;

    Lrkey60:= cdsMain.fieldbyname('rkey').asinteger;
    if gSvrIntf.IntfPostModData('��������', 354, LPostData,1) then
    begin
      showmessage('�޸ĳɹ�!');
      btnRefreshClick(sender);
      cdsMain.Locate('rkey',LRkey60,[]);
    end;

   end;

  finally
    Lfrm.Free;
    LCds60.free;
    Lcds25.free;
    Lcds53.free;
    Lcds318.free;
  end;
end;

procedure TfrmMain_OrderEditMarket_mod354.mni_splitOrderClick(Sender: TObject);
var
 LFrm:TfrmSplitOrder_mod354 ;
 i,j:byte;
 Lreput1,Lreput2:single;
 LsName:string;
 Lcds60,LCds60N,Lcds318,Lcds360,Lcds90:TClientDataSet;
 LpostData,LPostData2:OleVariant;
 Lsql:string;
 LRkey60:integer;
begin
  inherited;
   if not gFunc.CheckUserAuth(4,354) then
   begin
    showmessage('�Բ�����û��Ȩ��');
    exit;
   end;

   //�޸��ύ֮ǰ�鿴�����汾�Ƿ���Ч������ʾ�°汾---
   Lsql:='select ONHOLD_SALES_FLAG from data0025 where rkey='+cdsMain.FieldByName('CUST_PART_PTR').AsString;
   gSvrintf.IntfGetDataBySql(Lsql, cdsTemp);
   if (cdstemp.FieldByName('ONHOLD_SALES_FLAG').AsInteger=1) then  //��ͣ����
   begin
       Lsql:=' ;with CTE as  '+
      ' (select data0025.MANU_PART_NUMBER,Data0025.ONHOLD_SALES_FLAG,Data0273.COPYFROMCUST_PTR,Data0273.CUSTOMER_PART_PTR '+
      ' from data0273 inner join data0025 on data0273.CUSTOMER_PART_PTR=data0025.rkey'+
      ' where Data0025.RKEY='+cdsmain.fieldbyname('CUST_PART_PTR').asstring+
      ' union all'+
      ' select data0025.MANU_PART_NUMBER,Data0025.ONHOLD_SALES_FLAG,Data0273.COPYFROMCUST_PTR,Data0273.CUSTOMER_PART_PTR'+
      ' from Data0273'+
      ' inner join Data0025 on data0273.CUSTOMER_PART_PTR=data0025.rkey'+
      ' inner join cte on data0273.COPYFROMCUST_PTR=CTE.CUSTOMER_PART_PTR )'+
      ' select * from cte where ONHOLD_SALES_FLAG=0' ;
      gSvrintf.IntfGetDataBySql(Lsql, cdsTemp);

    if not Cdstemp.IsEmpty then
    begin
      LsName:=Cdstemp.FieldByName('MANU_PART_NUMBER').AsString;
    end else
    begin
      LsName:= '��';
    end;
    if messagedlg('��ǰ���۵��ͺ�����ͣ���ۣ������ı������Ϊ��'+LsName+'�����Ƿ����?',mtConFirmation,[mbYes,mbNo],0)= mrNo then Exit;
   end;

  LFrm:= TfrmSplitOrder_mod354.Create(self);
  Lcds60:=TClientDataSet.Create(nil);
  Lcds60N:=TClientDataSet.Create(nil);
  Lcds318:=TClientDataSet.Create(nil);
  Lcds360:=TClientDataSet.Create(nil);
  Lcds90:=TClientDataSet.Create(nil);

  try
  Lfrm.GetData(cdsMain.FieldByName('rkey').AsString);
  LFrm.FPARTS_SHIPPED:=cdsmain.FieldByName('PARTS_SHIPPED').asinteger;
  LFrm.FRETURNED_SHIP:=cdsmain.FieldByName('RETURNED_SHIP').asinteger;   //���˻���
  LFrm.FISSUED_QTY:=cdsmain.FieldByName('ISSUED_QTY').asinteger;     //��Ͷ������
  Lfrm.edt_qtySet.Text:=LFrm.cds60.FieldByName('set_ordered').AsString;
  LFrm.edt_qtyPcs.Text:=LFrm.cds60.FieldByName('PARTS_ORDERED').AsString;
  LFrm.lbl_setqty.Caption:=Lfrm.cds60.FieldByName('set_qty').AsString;   //25��Ľ�����Ԫ��

   if LFrm.ShowModal=mrok then
   begin
     //��¼���۶��������������(��־�ļ�)
     Lsql:='select * From data0318 where 1=2';
    gSvrIntf.IntfGetDataBySql(Lsql,Lcds318);

    Lsql:='select * From data0060 where rkey='+cdsMain.FieldByName('rkey').AsString;
    gSvrIntf.IntfGetDataBySql(Lsql,Lcds60);

    for i:=2 to Lcds60.FieldCount-1 do
    begin
    Lcds60.Edit;
    Lcds60.FieldValues[Lcds60.Fields[i].FieldName]:=LFrm.cds60.FieldValues[Lcds60.Fields[i].FieldName];
    Lcds60.Post;
    end;

    LCds318.Append;
    Lcds318.fieldbyname('SALES_ORDER_PTR').value:=cdsMain.FieldByName('rkey').asinteger;
    Lcds318.fieldbyname('TRANS_TYPE').value:=2;
    Lcds318.fieldbyname('TRANS_DESCRIPTION').value:= '���ָ������۶�������';
    Lcds318.fieldbyname('FROM_string').value:=cdsMain.FieldByName('parts_ordered').AsString;
    Lcds318.fieldbyname('TO_string').value:=Lfrm.edt_qtyPcs.Text;
    Lcds318.fieldbyname('USER_PTR').value:=StrToInt(gVar.rkey73);
    Lcds318.fieldbyname('TRANS_DATE').value:= now;
    Lcds318.fieldbyname('PROGRAM_SOURCE').value:=  305;
    Lcds318.fieldbyname('file_number').value:= trim(LFrm.edt_file.text);
    Lcds318.post;

      Lreput1:=cdsMain.FieldByName('REPUT_QTY').AsFloat;//��ǩ��ӡ����
      Lreput2:=cdsMain.FieldByName('REPUT_APPR_BY').AsFloat; //���ύ�������

      Lcds60.Edit;
      Lcds60.FieldByName('PARTS_ORDERED').Value:=strtofloat(LFrm.edt_qtyPcs.Text);  //PARTS_ORDERED
      Lcds60.FieldByName('set_ordered').Value:=strtoint(LFrm.edt_qtySet.Text);  //set_ordered
      Lcds60.Post;

      Lcds60.Edit;
      if cdsMain.FieldByName('REPUT_QTY').asFloat>strtofloat(Lfrm.edt_qtyPcs.Text) then
        Lcds60.FieldByName('REPUT_QTY').AsFloat:=strtofloat(LFrm.edt_qtyPcs.Text);
      if Lcds60.FieldByName('REPUT_APPR_BY').asFloat>strtofloat(LFrm.edt_qtyPcs.Text) then
        Lcds60.FieldByName('REPUT_APPR_BY').AsFloat:=strtofloat(LFrm.edt_qtyPcs.Text);
       //PARTS_ORDERED           PARTS_RETURNED                                 PARTS_SHIPPED        RETURNED_SHIP
      if Lcds60.FieldByName('PARTS_ORDERED').asinteger+Lcds60.FieldByName('PARTS_RETURNED').asinteger <=
            CdsMain.FieldByName('PARTS_SHIPPED').asinteger+CdsMain.FieldByName('RETURNED_SHIP').asinteger then
        Lcds60.FieldByName('status').asinteger:=4; //��ʶ���������
       //��Ͷ������ISSUED_QTY
       if Lfrm.cds60.FieldByName('ISSUED_QTY').AsInteger=0 then    //ԭ����δͶ����ôԭ�������ƻ���Ҫ�붩������ͬ
        Lcds60.FieldByName('TO_BE_PLANNED').asinteger:=LFrm.cds60.FieldByName('PARTS_ORDERED').AsInteger;    // TO_BE_PLANNED   PARTS_ORDERED
      Lcds60.Post;

      Lreput1:=Lreput1-Lcds60.FieldByName('PARTS_ORDERED').asFloat;
      Lreput2:=Lreput2-Lcds60.FieldByName('PARTS_ORDERED').asFloat;

      //�������¶���
      LSql:='select * From data0060 where 1=2';
      gSvrIntf.IntfGetDataBySql(Lsql,Lcds60N);

                    //�¶������ƻ�
      Lsql:='select * From data0360 where 1=2';
      gSvrIntf.IntfGetDataBySql(Lsql,Lcds360) ;

      LSql:='select * From data0090 where 1=2';
      gSvrIntf.IntfGetDataBySql(Lsql,Lcds90);

      LFrm.cds60N.First;
      while not LFrm.cds60N.Eof do
      begin
        LCds60N.Append;

         for i:=2 to Lcds60.FieldCount-1 do
          LCds60N.FieldValues[Lcds60.Fields[i].FieldName]:=Lcds60.FieldValues[Lcds60.Fields[i].FieldName];

          LCds60N.fieldbyname('IDKey').value:=gfunc.CreateIDKey;
          LCds60N.FieldValues['sales_order']:=LFrm.cds60N.FieldByName('SALES_ORDER').asstring;         //���۶���
          LCds60N.FieldValues['PARTS_ORDERED']:=LFrm.cds60N.FieldByName('parts_ordered').asinteger;       //����PCS����
          LCds60N.FieldValues['set_ORDERED']:=LFrm.cds60N.FieldByName('Set_ordered').asinteger;         //����SET����
          LCds60N.FieldValues['ORIG_REQUEST_DATE']:=LFrm.cds60N.FieldByName('ORIG_REQUEST_DATE').AsDateTime;   //�ظ��ͻ�������
          LCds60N.FieldValues['ORIG_SCHED_SHIP_DATE']:=LFrm.cds60N.FieldByName('ORIG_SCHED_SHIP_DATE').AsDateTime; //�ύ�ƻ�װ������
          LCds60N.FieldValues['TOTAL_ADD_L_PRICE']:=0;//���߷���
          LCds60N.FieldValues['status']:=1;        //�ٳ�ԭ��״̬����
          LCds60N.FieldValues['PARTS_SHIPPED']:=0;  //��װ�˵�����
          LCds60N.FieldValues['PARTS_RETURNED']:=0; //���˻ص�����
          LCds60N.FieldValues['PARTS_INVOICED']:=0; //�ѿ���Ʊ����
          LCds60N.FieldValues['QTY_PLANNNED']:=0;   //�Ѽƻ�������
          LCds60N.FieldValues['ISSUED_QTY']:=0;     //��Ͷ������
          LCds60N.FieldValues['RETURNED_SHIP']:=0;  //�˻���ָ������
          Lcds60N.post;

          Lcds60N.edit;
          if Lreput1>=LFrm.cds60N.FieldByName('parts_ordered').AsInteger then
          begin
            LCds60N.FieldValues['REPUT_QTY']:=LFrm.cds60N.FieldByName('parts_ordered').AsInteger;
            Lreput1:=Lreput1-LFrm.cds60N.FieldByName('parts_ordered').AsInteger;
          end
          else
          begin
            if Lreput1<0 then
              LCds60N.FieldValues['REPUT_QTY']:=0
            else
              LCds60N.FieldValues['REPUT_QTY']:=Lreput1;
            Lreput1:=0;
          end;
          if Lreput2>=LCds60N.FieldByName('PARTS_ORDERED').asFloat then
          begin
            LCds60N.FieldValues['REPUT_APPR_BY']:=LCds60N.FieldValues['PARTS_ORDERED'];
            Lreput2:=Lreput2-LCds60N.FieldByName('PARTS_ORDERED').asFloat;
          end
          else
          begin
            if Lreput2<0 then
              LCds60N.FieldValues['REPUT_APPR_BY']:=0
            else
            LCds60N.FieldValues['REPUT_APPR_BY']:=Lreput2;
            Lreput2:=0;
          end;
          if LFrm.cds60.FieldByName('ISSUED_QTY').AsInteger=0 then    //ԭ����δͶ�� ISSUED_QTY
           begin
            LCds60N.FieldValues['TO_BE_PLANNED']:=LFrm.cds60N.FieldByName('parts_ordered').AsInteger;
           end
          else
           begin
            LCds60N.FieldValues['TO_BE_PLANNED']:=0;  //���ƻ���
            LCds60N.FieldValues['PROD_REL']:=3;       //�������ű��  3Ϊ��Ͷ��
           end;

        LCds60N.Post;

       Lcds360.append;
       Lcds360.FieldByName('D60_IDKey').Value:= LCds60N.FieldByName('IDKey').AsString;
       Lcds360.FieldByName('quantity').Value:=LCds60N.FieldByName('parts_ordered').AsInteger;
       Lcds360.FieldByName('sch_date').Value:=LCds60N.FieldByName('ORIG_SCHED_SHIP_DATE').AsDateTime;
       Lcds360.Post;

      //�����ӱ�
      LSql:='select * From data0090 where pact_ptr='+cdsMain.FieldByName('rkey').AsString;
      gSvrIntf.IntfGetDataBySql(Lsql,cdstemp);

       cdstemp.First;
       while not cdstemp.Eof do     //���������ӱ�
        begin
         Lcds90.Append;
         for i:=2 to 6 do
          Lcds90.FieldValues[Lcds90.Fields[i].FieldName] :=
                    cdstemp.FieldValues[Lcds90.Fields[i].FieldName];
         Lcds90.FieldValues['D60_IDkey'] := Lcds60N.FieldValues['IDKey'];
         Lcds90.Post;
         cdstemp.Next;
        end;
       Lfrm.cds60N.Next;
      end;

      LPostData := varArrayCreate([0, 5], varVariant);
      if LCds60.ChangeCount>0 then
       LPostData[0] := LCds60.Delta;
      if Lcds318.ChangeCount>0 then
       LPostData[1] := Lcds318.Delta;
      if LFrm.cds360.ChangeCount>0 then
       LPostData[2] := LFrm.cds360.Delta;
      if Lcds60N.ChangeCount>0 then
       LPostData[3] := Lcds60N.Delta;
      if Lcds360.ChangeCount>0 then
       LPostData[4] := Lcds360.Delta;
      if Lcds90.ChangeCount>0 then
       LPostData[5] := Lcds90.Delta;

      Lrkey60:= cdsMain.fieldbyname('rkey').asinteger;
      if gSvrIntf.IntfPostModData('��������', 354, LPostData,3) then
      begin
        showmessage('�޸ĳɹ�!');
        btnRefreshClick(btnRefresh);
        cdsMain.Locate('rkey',LRkey60,[]);
      end;
   end;
  finally
    Lfrm.Free;
    Lcds60.free;
    LCds60N.free;
    Lcds318.free;
    Lcds360.free;
    Lcds90.free;
  end;

end;

function TfrmMain_OrderEditMarket_mod354.return_max_444: TDateTime;
var
Lsql:string;
begin
   Lsql:='select max(tdate) as maxdate from data0444 ';
   gSvrIntf.IntfGetDataBySql(Lsql,cdstemp);

  if not cdsTemp.fieldbyname('maxdate').IsNull then
   result:=cdsTemp.FieldByName('maxdate').AsDateTime
  else
   result:=date()-3650;
end;

function TfrmMain_OrderEditMarket_mod354.return_min_sysdate(
  Arkey60: Integer): TDateTime;
  var
  Lsql:string;
begin
 Lsql:='select min(sys_date) as mindate from data0416 where so_ptr='+inttostr(Arkey60);
  gSvrIntf.IntfGetDataBySql(Lsql,cdstemp);
  if not cdstemp.fieldbyname('mindate').IsNull then
   result:=cdstemp.fieldvalues['mindate']      //����������ⷢ�����������
  else
   result:=date()+1;
end;

end.
