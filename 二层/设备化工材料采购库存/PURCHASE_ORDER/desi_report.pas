unit desi_report;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ppDB, ppComm, ppRelatv, ppDBPipe, DB, ppProd, ppClass, ppReport,
  ppCtrls, ppBands, ppVar, ppPrnabl, ppCache, ppStrtch, ppMemo;

type
  TForm14 = class(TForm)
    ppDB0070: TppDBPipeline;
    ppDB71: TppDBPipeline;
    DataSource1: TDataSource;
    ppDB7011: TppDBPipeline;
    DataSource2: TDataSource;
    ppDB493: TppDBPipeline;
    ppReport1: TppReport;
    ppDB70: TppDBPipeline;
    DataSource3: TDataSource;
    ppDB15: TppDBPipeline;
    ppDB70ppField53: TppField;
    DataSource4: TDataSource;
    ppDB11: TppDBPipeline;
    ppDB0070ppField21: TppField;
    ppDB0070ppField22: TppField;
    DataSource5: TDataSource;
    DB207011: TppDBPipeline;
    ppDB71ppField21: TppField;
    ppDB71ppField24: TppField;
    ppDB71ppField26: TppField;
    ppDB71ppField27: TppField;
    ppTitleBand1: TppTitleBand;
    ppDBText1: TppDBText;
    ppDBImage1: TppDBImage;
    ppLabel1: TppLabel;
    ppLabel2: TppLabel;
    ppDBText4: TppDBText;
    ppDBText5: TppDBText;
    ppLabel9: TppLabel;
    ppLabel12: TppLabel;
    ppDBText8: TppDBText;
    ppLabel40: TppLabel;
    ppDBText31: TppDBText;
    ppLabel44: TppLabel;
    ppDBText32: TppDBText;
    ppLabel46: TppLabel;
    ppLabel47: TppLabel;
    ppDBText33: TppDBText;
    ppLabel45: TppLabel;
    ppLabel68: TppLabel;
    ppLabel70: TppLabel;
    ppLabel72: TppLabel;
    ppLabel73: TppLabel;
    ppDBText47: TppDBText;
    ppDBText50: TppDBText;
    ppDBText51: TppDBText;
    ppDBText54: TppDBText;
    ppDBText55: TppDBText;
    ppLabel8: TppLabel;
    ppLine1: TppLine;
    ppLabel3: TppLabel;
    ppDBText3: TppDBText;
    ppDBText6: TppDBText;
    ppDBText9: TppDBText;
    ppDBText10: TppDBText;
    ppLabel6: TppLabel;
    ppDBText11: TppDBText;
    ppLabel24: TppLabel;
    ppLabel25: TppLabel;
    ppDBText2: TppDBText;
    ppHeaderBand1: TppHeaderBand;
    ppShape1: TppShape;
    ppLine28: TppLine;
    ppLine29: TppLine;
    ppLine32: TppLine;
    ppLine33: TppLine;
    ppLine34: TppLine;
    ppLabel48: TppLabel;
    ppLabel49: TppLabel;
    ppLabel52: TppLabel;
    ppLabel54: TppLabel;
    ppLabel55: TppLabel;
    ppLabel7: TppLabel;
    ppLabel10: TppLabel;
    ppLabel11: TppLabel;
    ppLabel13: TppLabel;
    ppLabel14: TppLabel;
    ppLabel16: TppLabel;
    ppLine8: TppLine;
    ppLine10: TppLine;
    ppLabel17: TppLabel;
    ppDetailBand1: TppDetailBand;
    ppDBCalc4: TppDBCalc;
    ppDBText34: TppDBText;
    ppDBText37: TppDBText;
    ppDBText38: TppDBText;
    ppLine35: TppLine;
    ppLine40: TppLine;
    ppDBText39: TppDBText;
    ppDBText40: TppDBText;
    ppLine3: TppLine;
    ppLine4: TppLine;
    ppLine5: TppLine;
    ppLine6: TppLine;
    ppLine7: TppLine;
    ppDBText7: TppDBText;
    ppLine9: TppLine;
    ppLine11: TppLine;
    ppDBText16: TppDBText;
    ppDBText17: TppDBText;
    ppDBMemo1: TppDBMemo;
    ppFooterBand1: TppFooterBand;
    ppLabel62: TppLabel;
    ppLine53: TppLine;
    ppLabel67: TppLabel;
    ppDBText49: TppDBText;
    ppLabel20: TppLabel;
    ppLabel21: TppLabel;
    ppLabel22: TppLabel;
    ppLabel26: TppLabel;
    ppLabel27: TppLabel;
    ppLine15: TppLine;
    ppLine16: TppLine;
    ppLine18: TppLine;
    ppDBText13: TppDBText;
    ppSummaryBand1: TppSummaryBand;
    ppLine17: TppLine;
    ppLabel61: TppLabel;
    ppLine2: TppLine;
    ppLine12: TppLine;
    ppLabel38: TppLabel;
    ppLabel23: TppLabel;
    ppLabel4: TppLabel;
    ppLabel19: TppLabel;
    ppLine13: TppLine;
    ppLine14: TppLine;
    ppLabel5: TppLabel;
    ppDBText18: TppDBText;
    ppDBText14: TppDBText;
    ppImage1: TppImage;
    ppImage2: TppImage;
    function SmallTOBig(small:real):string;
    procedure ppReport1BeforePrint(Sender: TObject);
    procedure ppReport1PreviewFormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form14: TForm14;

implementation
uses damo;
{$R *.dfm}
function Tform14.SmallTOBig(small:real):string;
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

procedure TForm14.ppReport1BeforePrint(Sender: TObject);
//var
// v_ship_tax,v_misc_tax,misc_base:single;
begin
 pplabel38.Caption:=SmallTOBig(dm.ADO70SUB_TOTAL.Value);//��д
//^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
{v_ship_tax:=0;      //�����������������˰��
 v_misc_tax:=0;
 misc_base:=0;
if dm.ADO70STATE_SHIP_TAX_FLAG.Value='Y' then
 v_ship_tax :=dm.ADO70SHIPPING_COST.Value*dm.ADO70FEDERAL_TAX.Value/100;
if dm.ADO70STATE_MISC_TAX_FLAG.Value='Y' then
 begin
  dm.ado200.First;
  while not dm.ADO200.Eof do
   begin
    if dm.ADO200TAXABLE.Value='Y' then
     misc_base := misc_base+ dm.ADO200AMOUNT.Value;
    dm.ADO200.Next;
   end;
  v_misc_tax := misc_base*dm.ADO70FEDERAL_TAX.Value*0.01;
 end;
 ppLabel36.Caption := formatfloat('0.00',v_ship_tax+v_misc_tax);} //����װ��˰
//^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  with dm.ADOQuery2 do
   begin
    active:=false;         //��ȡװ�˵ص���Ϣ
    sql.Clear;
    sql.Add('select factory_address_1,factory_address_2,factory_address_3,');
    sql.Add('CONTACT,PHONE,FAX');
    sql.Add('from data0024');
    sql.Add('where rkey='+dm.ADO70SUPP_FAC_ADD_PTR.AsString);
    active:=true;
    ppLabel5.Caption := trim(fieldbyname('factory_address_1').AsString);//+
//                        trim(fieldbyname('factory_address_2').AsString)+
//                        trim(fieldbyname('factory_address_3').AsString);
{   ppLabel14.Caption := fieldbyname('contact').AsString;
    ppLabel15.Caption := fieldbyname('phone').AsString;
    ppLabel16.Caption := fieldbyname('fax').AsString;}
   end;
//^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
end;

procedure TForm14.ppReport1PreviewFormCreate(Sender: TObject);
begin
// ppReport1.PreviewForm.WindowState := wsMaximized;
end;

end.
