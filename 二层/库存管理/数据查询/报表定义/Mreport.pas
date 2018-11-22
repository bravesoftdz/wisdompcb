unit Mreport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, ppProd, ppClass, ppReport, ppComm, ppRelatv, ppDB,
  ppDBPipe, ppCtrls, ppBands, ppPrnabl, ppCache, ppStrtch, ppSubRpt, ppVar,
  ppModule, raCodMod, ppEndUsr;

type
  TForm_Mreport = class(TForm)
    ADO12: TADOQuery;
    DataSource1: TDataSource;
    ADO12CUST_CODE: TStringField;
    ADO12CUSTOMER_NAME: TStringField;
    ADO12SHIP_TO_ADDRESS_1: TStringField;
    ADO12SHIP_TO_CONTACT: TStringField;
    ADO12SHIP_TO_PHONE: TStringField;
    ADO12SHIP_TO_FAX: TStringField;
    ADO12ZIP: TStringField;
    ADO12SHIP_TO_ADDRESS_3: TStringField;
    ADO12SHP_ADDR2_FOR_FORM: TStringField;
    ADO12SHP_ADDR3_FOR_FORM: TStringField;
    ADO12EMAIL_FOR_CONTACT: TStringField;
    ADO12SHIP_TO_ADDRESS_2: TStringField;
    DataSource2: TDataSource;
    ADO60: TADOQuery;
    DataSource3: TDataSource;
    ADO60SALES_ORDER: TStringField;
    ADO60ANALYSIS_CODE_1: TStringField;
    ADO60ANALYSIS_CODE_2: TStringField;
    ADO60PARTS_ORDERED: TFloatField;
    ADO60set_ordered: TIntegerField;
    ADO60PART_PRICE: TFloatField;
    ADO60set_price: TFloatField;
    ADO60TOTAL_ADD_L_PRICE: TFloatField;
    ADO60EXCH_RATE: TFloatField;
    ADO60ORIG_SCHED_SHIP_DATE: TDateTimeField;
    ADO60FOB: TStringField;
    ADO60REFERENCE_NUMBER: TStringField;
    DataSource4: TDataSource;
    ADO97: TADOQuery;
    ADO97PO_NUMBER: TStringField;
    ADO97PO_DATE: TDateTimeField;
    ppDB97: TppDBPipeline;
    ppDB12: TppDBPipeline;
    ppDB60: TppDBPipeline;
    ppDB493: TppDBPipeline;
    ppReport1: TppReport;
    ADO60amount: TFloatField;
    ADO89: TADOQuery;
    DataSource5: TDataSource;
    ppDB89: TppDBPipeline;
    ppDesigner1: TppDesigner;
    ppTitleBand1: TppTitleBand;
    ppShape1: TppShape;
    ppDBText1: TppDBText;
    ppLabel1: TppLabel;
    ppDBText2: TppDBText;
    ppLabel2: TppLabel;
    ppLabel12: TppLabel;
    ppDBText10: TppDBText;
    ppLabel13: TppLabel;
    ppDBText11: TppDBText;
    ppLabel14: TppLabel;
    ppDBText12: TppDBText;
    ppLabel15: TppLabel;
    ppDBText13: TppDBText;
    ppLabel16: TppLabel;
    ppDBText14: TppDBText;
    ppLabel17: TppLabel;
    ppDBText15: TppDBText;
    ppLine2: TppLine;
    ppLine3: TppLine;
    ppLine4: TppLine;
    ppLine5: TppLine;
    ppLine7: TppLine;
    ppDBText16: TppDBText;
    ppDBText17: TppDBText;
    ppDBText18: TppDBText;
    ppLabel19: TppLabel;
    ppLabel20: TppLabel;
    ppLabel21: TppLabel;
    ppLabel22: TppLabel;
    ppLabel23: TppLabel;
    ppLabel24: TppLabel;
    ppLabel25: TppLabel;
    ppLabel26: TppLabel;
    ppLabel27: TppLabel;
    ppSystemVariable1: TppSystemVariable;
    ppLine1: TppLine;
    ppLabel3: TppLabel;
    ppLabel4: TppLabel;
    ppLabel5: TppLabel;
    ppLabel6: TppLabel;
    ppLabel7: TppLabel;
    ppLabel8: TppLabel;
    ppLabel9: TppLabel;
    ppLine8: TppLine;
    ppLine9: TppLine;
    ppLine10: TppLine;
    ppLine11: TppLine;
    ppLine12: TppLine;
    ppLine13: TppLine;
    ppLine14: TppLine;
    ppLine15: TppLine;
    ppDetailBand1: TppDetailBand;
    ppLine6: TppLine;
    ppDBText3: TppDBText;
    ppDBText4: TppDBText;
    ppDBText5: TppDBText;
    ppDBText6: TppDBText;
    ppDBText7: TppDBText;
    ppDBText8: TppDBText;
    ppDBText9: TppDBText;
    ppLine16: TppLine;
    ppLine17: TppLine;
    ppLine18: TppLine;
    ppLine19: TppLine;
    ppLine20: TppLine;
    ppLine21: TppLine;
    ppLine22: TppLine;
    ppLine23: TppLine;
    ppSummaryBand1: TppSummaryBand;
    ppLine24: TppLine;
    ppDBCalc1: TppDBCalc;
    ppLabel10: TppLabel;
    ppLabel11: TppLabel;
    ppLabel18: TppLabel;
    ppLine25: TppLine;
    ppLine26: TppLine;
    ppSubReport1: TppSubReport;
    ppChildReport1: TppChildReport;
    ppColumnHeaderBand1: TppColumnHeaderBand;
    ppLabel28: TppLabel;
    ppLabel29: TppLabel;
    ppLabel30: TppLabel;
    ppLine27: TppLine;
    ppDetailBand2: TppDetailBand;
    ppLine28: TppLine;
    ppDBText19: TppDBText;
    ppDBText20: TppDBText;
    ppDBText21: TppDBText;
    ppLine29: TppLine;
    ppLine30: TppLine;
    ppColumnFooterBand1: TppColumnFooterBand;
    ppGroup1: TppGroup;
    ppGroupHeaderBand1: TppGroupHeaderBand;
    ppGroupFooterBand1: TppGroupFooterBand;
    ADO89CAN_SHU: TWideStringField;
    ADO60MANU_PART_NUMBER: TStringField;
    ADO60manu_PART_DESC: TStringField;
    ADO89MANU_PART_NUMBER: TStringField;
    ADO89MANU_PART_DESC: TStringField;
    ADO89PARAMETER_DESC: TStringField;
    ADO89tvalue: TStringField;
    function SmallTOBig(small:real):string;
    procedure ppReport1PreviewFormCreate(Sender: TObject);
    procedure ppReport1BeforePrint(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_Mreport: TForm_Mreport;

implementation

uses DataModule;



{$R *.dfm}

procedure TForm_Mreport.ppReport1PreviewFormCreate(Sender: TObject);
begin
ppReport1.PreviewForm.WindowState := wsMaximized;
end;

function Tform_Mreport.SmallTOBig(small:real):string;
var
SmallMonth,BigMonth:string;
wei1,qianwei1:string[2];
qianwei,dianweizhi,qian:integer;
begin
{------- �޸Ĳ�����ֵ����ȷ -------}
{С������λ������Ҫ�Ļ�Ҳ���ԸĶ���ֵ}
 qianwei:=-2;

{ת���ɻ�����ʽ����Ҫ�Ļ�С�����Ӷ༸����}
 Smallmonth:=formatfloat('0.00',small);
 dianweizhi :=pos('.',Smallmonth);{С�����λ��}
{ѭ��Сд���ҵ�ÿһλ����Сд���ұ�λ�õ����}
for qian:=length(Smallmonth) downto 1 do
begin
if qian<>dianweizhi then{��������Ĳ���С����ͼ���}
begin
case strtoint(copy(Smallmonth,qian,1)) of{λ���ϵ���ת���ɴ�д}
 1:wei1:='Ҽ'; 2:wei1:='��';
 3:wei1:='��'; 4:wei1:='��';
 5:wei1:='��'; 6:wei1:='½';
 7:wei1:='��'; 8:wei1:='��';
 9:wei1:='��'; 0:wei1:='��';
end;
case qianwei of {�жϴ�дλ�ã����Լ�������real���͵����ֵ}
 -3:qianwei1:='��';
 -2:qianwei1:='��';
 -1:qianwei1:='��';
 0 :qianwei1:='Ԫ';
 1 :qianwei1:='ʰ';
 2 :qianwei1:='��';
 3 :qianwei1:='ǧ';
 4 :qianwei1:='��';
 5 :qianwei1:='ʰ';
 6 :qianwei1:='��';
 7 :qianwei1:='ǧ';
 8 :qianwei1:='��';
 9 :qianwei1:='ʮ';
 10:qianwei1:='��';
 11:qianwei1:='ǧ';
end;
 inc(qianwei); //�Զ���1
 BigMonth :=wei1+qianwei1+BigMonth;{��ϳɴ�д���}
end;
end;
 SmallTOBig:=BigMonth;
end;

procedure TForm_Mreport.ppReport1BeforePrint(Sender: TObject);
var
 v_money:double;
begin
v_money:=0;
ado60.First;
while not ado60.Eof do
 begin
  v_money:=v_money+self.ADO60amount.Value;
  ado60.Next;
 end;
ado60.First;
 pplabel18.Caption:=self.SmallTOBig(v_money);
end;

end.
