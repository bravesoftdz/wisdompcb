unit DMUnit1;

interface

uses
  SysUtils, Classes, DB, ADODB,Dialogs;

type
  TDM = class(TDataModule)
    ADOConnection1: TADOConnection;
    ADODataSet2: TADODataSet;
    DataSource1: TDataSource;
    ADODataSet2WORK_ORDER_NUMBER: TStringField;
    ADODataSet2QUAN_SCH: TFloatField;
    ADODataSet2QUAN_REJ: TFloatField;
    ADODataSet2QUAN_PROD: TFloatField;
    ADODataSet2FLOW_NO: TSmallintField;
    ADODataSet2wtype: TWordField;
    ADODataSet2put_type: TWordField;
    ADODataSet2ENGG_STATUS: TSmallintField;
    ADODataSet2PROD_STATUS: TSmallintField;
    ADODataSet2ENGG_PROD_FLAG: TSmallintField;
    ADODataSet2SCH_COMPL_DATE: TDateTimeField;
    ADODataSet2PROJ_START_DATE: TDateTimeField;
    ADODataSet2PROJ_COMPL_DATE: TDateTimeField;
    ADODataSet2CANCEL_HOLD_DATE: TDateTimeField;
    ADODataSet2ACT_COMPL_DATE: TDateTimeField;
    ADODataSet2PLANNED_QTY: TFloatField;
    ADODataSet2RELEASE_DATE: TDateTimeField;
    ADODataSet2DEPT_CODE: TStringField;
    ADODataSet2DEPT_NAME: TStringField;
    ADODataSet2PROD_CODE: TStringField;
    ADODataSet2PRODUCT_NAME: TStringField;
    ADODataSet2MANU_PART_NUMBER: TStringField;
    ADODataSet2My_PROD_STATUS: TStringField;
    ADODataSet2My_wtype: TStringField;
    ADODataSet2My_number1: TFloatField;
    ADODataSet2rkey06: TIntegerField;
    ADODataSet2BOM_PTR: TIntegerField;
    tmp: TADOQuery;
    ADODataSet1: TADODataSet;
    ADODataSet1rkey: TAutoIncField;
    ADODataSet1MANU_PART_NUMBER: TStringField;
    ADODataSet1MANU_PART_DESC: TStringField;
    ADODataSet1ENT_DATE: TDateTimeField;
    ADODataSet1SCH_DATE: TDateTimeField;
    ADODataSet1ENAME60: TStringField;
    ADODataSet1ENAME492: TStringField;
    ADODataSet1PARTS_ORDERED: TFloatField;
    ADODataSet1set_ordered: TIntegerField;
    ADODataSet1PARTS_SHIPPED: TFloatField;
    ADODataSet1PARTS_RETURNED: TFloatField;
    ADODataSet1PARTS_ALLOC: TFloatField;
    ADODataSet1PARTS_INVOICED: TFloatField;
    ADODataSet1FOB: TStringField;
    ADODataSet1CUT_NO: TStringField;
    ADODataSet1ISSUE_DATE: TDateTimeField;
    ADODataSet1ISSUED_QTY: TIntegerField;
    ADODataSet1SALES_ORDER: TStringField;
    ADODataSet1STATUS: TWordField;
    ADODataSet1PO_NUMBER: TStringField;
    ADODataSet1CUST_CODE: TStringField;
    ADODataSet1CUSTOMER_NAME: TStringField;
    ADODataSet1ABBR_NAME: TStringField;
    ADODataSet1PRODUCT_NAME: TStringField;
    ADODataSet1myStatus: TStringField;
    ADODataSet1ttype: TWordField;
    ADODataSet1tstatus: TWordField;
    ADODataSet1status492: TStringField;
    ADODataSet1type492: TStringField;
    procedure ADODataSet2CalcFields(DataSet: TDataSet);
    procedure ADODataSet1CalcFields(DataSet: TDataSet);
    procedure ADODataSet1AfterClose(DataSet: TDataSet);
    procedure ADODataSet1AfterScroll(DataSet: TDataSet);
    procedure ADODataSet1BeforeOpen(DataSet: TDataSet);
  private
    rkey06:integer;
    vfind:boolean;
    procedure Set_find1(const Value: boolean);
  public
    property find1:boolean write Set_find1;
  end;

var
  DM: TDM;
  sysDate:TDatetime;
implementation

{$R *.dfm}

procedure TDM.Set_find1(const Value: boolean);
begin
  vfind:=value;
end;

procedure TDM.ADODataSet2CalcFields(DataSet: TDataSet);
begin
  if ADODataSet2.Active then
  begin
    ADODataSet2My_number1.Value :=ADODataSet2QUAN_SCH.Value-ADODataSet2QUAN_REJ.Value
                                  -ADODataSet2QUAN_PROD.Value;
    case self.ADODataSet2wtype.Value of
      0:self.ADODataSet2My_wtype.Value:='';
      1:self.ADODataSet2My_wtype.Value:='';
      2:self.ADODataSet2My_wtype.Value:='';
    end;

    case self.ADODataSet2PROD_STATUS.Value of
      1:self.ADODataSet2My_PROD_STATUS.Value:='�ȴ����';
      2:self.ADODataSet2My_PROD_STATUS.Value:='������';
      3:self.ADODataSet2My_PROD_STATUS.Value:='������';
      4:self.ADODataSet2My_PROD_STATUS.Value:='�ⷢ����';
      5:self.ADODataSet2My_PROD_STATUS.Value:='�����';
      6:self.ADODataSet2My_PROD_STATUS.Value:='������';
      9:self.ADODataSet2My_PROD_STATUS.Value:='��������';
      101:self.ADODataSet2My_PROD_STATUS.Value:='����ݻ�';
      102:self.ADODataSet2My_PROD_STATUS.Value:='����ǰ�ݻ�';
      103:self.ADODataSet2My_PROD_STATUS.Value:='�������ݻ�';
      201:self.ADODataSet2My_PROD_STATUS.Value:='��ȡ��';
      202:self.ADODataSet2My_PROD_STATUS.Value:='ȡ��';
      203:self.ADODataSet2My_PROD_STATUS.Value:='��ȡ��';
    end;
  end;
end;

procedure TDM.ADODataSet1CalcFields(DataSet: TDataSet);
begin
  case ADODataSet1STATUS.Value of
    1: ADODataSet1MySTATUS.Value:='��Ч��';
    2: ADODataSet1MySTATUS.Value:='�ݻ�';
    3: ADODataSet1MySTATUS.Value:='�ѹر�';
    4: ADODataSet1MySTATUS.Value:='�����';
    5: ADODataSet1MySTATUS.Value:='��ȡ��';
    6: ADODataSet1MySTATUS.Value:='δ�ύ';
  end;
  case ADODataSet1tstatus.Value of
    0:ADODataSet1status492.Value:='�����';
    1:ADODataSet1status492.Value:='δ���';
    2:ADODataSet1status492.Value:='�����';
    3:ADODataSet1status492.Value:='��ȡ��';
  end;
  case ADODataSet1ttype.Value of
    0:ADODataSet1type492.Value:='����Ͷ��';
    1:ADODataSet1type492.Value:='����Ͷ��';
    2:ADODataSet1type492.Value:='��MRB����';
    3:ADODataSet1type492.Value:='��MRB����';
    4:ADODataSet1type492.Value:='�����Ͷ��';
  end;
end;

procedure TDM.ADODataSet1AfterClose(DataSet: TDataSet);
begin
  vfind:=false;
end;

procedure TDM.ADODataSet1AfterScroll(DataSet: TDataSet);
begin
  ADODataSet2.Close;
  ADODataSet2.Parameters.ParamValues['cut_no'] := ADODataSet1CUT_NO.Value ;
  ADODataSet2.Open;
end;

procedure TDM.ADODataSet1BeforeOpen(DataSet: TDataSet);
begin
 vfind:=false;
end;

end.
