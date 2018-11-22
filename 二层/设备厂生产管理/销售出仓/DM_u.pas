unit DM_u;

interface

uses
  SysUtils, Classes, DB, ADODB,windows, DBClient, Provider,mask,Dialogs,StrUtils;

type
  TDM = class(TDataModule)
    ADOCon: TADOConnection;
    tmp: TADOQuery;
    DS1: TDataSource;
    DS2: TDataSource;
    ADO60: TADOQuery;
    ADO63: TADOQuery;
    ADO60_1: TADOQuery;
    ADO63_1: TADOQuery;
    DS3: TDataSource;
    ADO60rkey: TIntegerField;
    ADO60sales_order: TStringField;
    ADO60sales_date: TDateTimeField;
    ADO60customer_ptr: TIntegerField;
    ADO60type: TWordField;
    ADO60status: TWordField;
    ADO60ship_method: TStringField;
    ADO60location: TStringField;
    ADO60SALES_REP_PTR: TIntegerField;
    ADO60ent_date: TDateTimeField;
    ADO60ent_user_ptr: TIntegerField;
    ADO60currency_ptr: TIntegerField;
    ADO60exch_rate: TBCDField;
    ADO60total_amount: TBCDField;
    ADO60CONTACT_NAME: TStringField;
    ADO60CONT_PHONE: TStringField;
    ADO60TAX_cate: TStringField;
    ADO60pay_method: TStringField;
    ADO60invoice_ptr: TIntegerField;
    ADO60remark: TStringField;
    ADO60CUST_CODE: TStringField;
    ADO60CUSTOMER_NAME: TStringField;
    ADO60CURR_CODE: TStringField;
    ADO60CURR_NAME: TStringField;
    ADO60sorder: TStringField;
    ADO60EMPL_CODE: TStringField;
    ADO60EMPLOYEE_NAME: TStringField;
    ADO60status_c: TStringField;
    ADO63rkey: TIntegerField;
    ADO63so_ptr: TIntegerField;
    ADO63prod_ptr: TIntegerField;
    ADO63location_ptr: TIntegerField;
    ADO63cp71_ptr: TIntegerField;
    ADO63price: TBCDField;
    ADO63tax_rate: TBCDField;
    ADO63returen_qty: TBCDField;
    ADO63remark: TStringField;
    ADO63CODE: TStringField;
    ADO63LOCATION: TStringField;
    ADO63PROD_CODE: TStringField;
    ADO63PRODUCT_NAME: TStringField;
    ADO63PRODUCT_DESC: TStringField;
    ADO71: TADOQuery;
    DS4: TDataSource;
    ADO63_2: TADOQuery;
    DS5: TDataSource;
    ADO60EMPL_CODE_a: TStringField;
    ADO60EMPLOYEE_NAME_a: TStringField;
    ADO63D0468_PTR: TIntegerField;
    ADO63total_price: TBCDField;
    ADO63unit_name: TStringField;
    ADO63quantity: TBCDField;
    ADO71rkey: TIntegerField;
    ADO71so_ptr: TIntegerField;
    ADO71prod_ptr: TIntegerField;
    ADO71price: TBCDField;
    ADO71tax_rate: TBCDField;
    ADO71complete_date: TDateTimeField;
    ADO71remark: TStringField;
    ADO71PROD_CODE: TStringField;
    ADO71PRODUCT_NAME: TStringField;
    ADO71PRODUCT_DESC: TStringField;
    ADO71qty_onhand: TBCDField;
    ADO71sales_order: TStringField;
    ADO71sales_date: TDateTimeField;
    ADO71quantity: TFloatField;
    ADO71PARTS_SHIPPED: TFloatField;
    ADO71returen_qty: TFloatField;
    ADO71QTY_PLANED: TFloatField;
    ADO71Field: TFloatField;
    ADO71Field2: TFloatField;
    ADO60_1rkey: TAutoIncField;
    ADO60_1sales_order: TStringField;
    ADO60_1sales_date: TDateTimeField;
    ADO60_1customer_ptr: TIntegerField;
    ADO60_1type: TWordField;
    ADO60_1status: TWordField;
    ADO60_1ship_method: TStringField;
    ADO60_1location: TStringField;
    ADO60_1SALES_REP_PTR: TIntegerField;
    ADO60_1ent_date: TDateTimeField;
    ADO60_1ent_user_ptr: TIntegerField;
    ADO60_1currency_ptr: TIntegerField;
    ADO60_1exch_rate: TBCDField;
    ADO60_1total_amount: TBCDField;
    ADO60_1CONTACT_NAME: TStringField;
    ADO60_1CONT_PHONE: TStringField;
    ADO60_1TAX_cate: TStringField;
    ADO60_1pay_method: TStringField;
    ADO60_1invoice_ptr: TIntegerField;
    ADO60_1remark: TStringField;
    ADO60_1CONF_BY_EMPL_PTR: TIntegerField;
    ADO60_1CONF_DATE: TDateTimeField;
    ADO60_1MO_PTR: TIntegerField;
    wdstrngfldADO60_1PO_NO: TWideStringField;
    ADO60CONF_BY_EMPL_PTR: TIntegerField;
    ADO60CONF_DATE: TDateTimeField;
    ADO60MO_PTR: TIntegerField;
    wdstrngfldADO60PO_NO: TWideStringField;
    qry493: TADOQuery;
    qry493company_Icon: TBlobField;
    ds493: TDataSource;
    wdstrngfldqry493Company_Name: TWideStringField;
    Ado492: TADOQuery;
    ADO63d8remark: TMemoField;
    procedure ADO60AfterScroll(DataSet: TDataSet);
  private

  public
     function GetNo(edt:TMaskEdit;ikey:string;tp:integer=0):boolean;
     function ExistInventory(HD:THandle):Boolean;
  end;

var
  DM: TDM;
  Frkey60:integer;
implementation

{$R *.dfm}

function TDM.ExistInventory(HD:THandle):Boolean;
begin                          //���ڼ���Ƿ����δ��ĳ�Ʒ�̵��¼������20121101
  Result:=False;
  with tmp do
  begin
    Close;
    SQL.Clear;
    SQL.Text:='select rkey from data0214 where STATUS=0';
    Open;
    if not IsEmpty then
    begin
      MessageBox(HD,'�ִ���δ��ĳ�Ʒ�̵��¼�����ȴ���','����',MB_ok+MB_iconStop);
      Result:=True;
    end;
    Close;
  end;
end;

procedure TDM.ADO60AfterScroll(DataSet: TDataSet);
begin
  ADO63.Close;
  ADO63.Parameters[0].Value:=DataSet.FieldValues['rkey'];
  ADO63.Open;
end;

function TDM.GetNo(edt: TMaskEdit; ikey: string;tp:integer=0):boolean;
var i,iL:integer;
    s,sL:string;
    B:boolean;
    table_name:string;
begin
  result:=false;
  DM.Tmp.Close;
  DM.Tmp.SQL.Text:='select SEED_VALUE,seed_flag,table_name  from data0004  where rkey ='+ikey;
  DM.Tmp.Open;
  if DM.Tmp.IsEmpty or (DM.Tmp.Fields[1].AsInteger=1) then   //��ȫ�ֶ�
  begin
    result:=true;
    exit;
  end;

  s:=trim(DM.Tmp.Fields[0].AsString);
  table_name:=trim(DM.Tmp.Fields[2].AsString);
  if DM.Tmp.Fields[1].AsInteger=2 then        //�̶�����,ϵͳ���Զ��������룬Ҳ���������(���Ϻ�)
  begin
    iL:=length(s);
    for i:=iL downto 1 do
      if not (s[i] in ['0'..'9']) then begin sL:=inttostr(i); break; end;
    edt.editmask:=copy(s,1,i)+'!'+copy('9999999999',i+1,iL-i)+';1;_';
    edt.ReadOnly:=false;
    if tp=0 then
      edt.Text:=s
    else begin
      DM.Tmp.Close;
      DM.Tmp.SQL.Text:='select top 1 sales_order from '+table_name+' where sales_order='''+edt.Text+'''';
      DM.Tmp.Open;
      if not DM.Tmp.IsEmpty then
      begin
        showmessage('�����ظ�,����������...');
        exit;
      end ;

      DM.Tmp.Close;
      DM.Tmp.SQL.Text:='select top 1 sales_order from '+table_name+' order by sales_order desc';
      DM.Tmp.Open;
      if DM.Tmp.IsEmpty or (DM.Tmp.Fields[0].AsString<=edt.Text) then
      begin
        DM.Tmp.Close;
        if sL<>'' then
          DM.Tmp.SQL.Text:='update data0004 set SEED_VALUE=left(SEED_VALUE,'+sL+')+right(''00000''+cast(cast(right(SEED_VALUE,len(SEED_VALUE)-'+sL+') as int)+1 as varchar(6)),6) '+
                           'where rkey='+ikey
        else
          DM.Tmp.SQL.Text:='update data0004 set SEED_VALUE=cast(SEED_VALUE as int)+1 '+
                           'where rkey='+ikey;
        DM.Tmp.ExecSQL;
      end;

    end;
  end else if DM.Tmp.Fields[1].AsInteger=3 then begin      //ϵͳ�����������޸�
    edt.ReadOnly:=false;
    if tp=0 then
      edt.Text:=DM.Tmp.Fields[0].AsString
    else begin
      iL:=length(s);
      for i:=iL downto 1 do
        if not (s[i] in ['0'..'9']) then begin sL:=inttostr(i); break; end;
      DM.Tmp.Close;
        if sL<>'' then
          DM.Tmp.SQL.Text:='update data0004 set SEED_VALUE=left(SEED_VALUE,'+sL+')+right(''00000''+cast(cast(right(SEED_VALUE,len(SEED_VALUE)-'+sL+') as int)+1 as varchar(6)),6) '+
                           'where rkey='+ikey
        else  //ȫ������
          DM.Tmp.SQL.Text:='update data0004 set SEED_VALUE=cast(SEED_VALUE as int)+1 '+
                           'where rkey='+ikey;
      DM.Tmp.ExecSQL;
    end;
  end else if DM.Tmp.Fields[1].AsInteger=4 then begin  //ֻ��ϵͳ����
    edt.ReadOnly:=true;
    if tp=0 then
      edt.Text:=DM.Tmp.Fields[0].AsString
    else begin
      iL:=length(s);
      for i:=iL downto 1 do
        if not (s[i] in ['0'..'9']) then begin sL:=inttostr(i); break; end;
      B:=true;
      while B do
      begin
        DM.Tmp.Close;
        if sL<>'' then
          DM.Tmp.SQL.Text:='update data0004 set SEED_VALUE=left(SEED_VALUE,'+sL+')+right(''00000''+cast(cast(right(SEED_VALUE,len(SEED_VALUE)-'+sL+') as int)+1 as varchar(6)),6) '+
                           'where rkey='+ikey+' and SEED_VALUE='''+edt.Text+''''
        else
          DM.Tmp.SQL.Text:='update data0004 set SEED_VALUE=cast(SEED_VALUE as int)+1 '+
                           'where rkey='+ikey+' and SEED_VALUE='''+edt.Text+'''';
        if DM.Tmp.ExecSQL=0 then
        begin
          DM.Tmp.Close;
          DM.Tmp.SQL.Text:='select SEED_VALUE  from data0004  where rkey ='+ikey;
          DM.Tmp.Open;
          edt.Text:=DM.Tmp.Fields[0].AsString;
        end else
          B:=false;
      end;
    end;
  end ;
  result:=true;
end;

end.
