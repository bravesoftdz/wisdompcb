unit quote_report;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, ppDB, ppBands, ppCache, ppClass, ppDBPipe, ppComm,
  ppRelatv, ppProd, ppReport, ppCtrls, ppVar, ppPrnabl, ppStrtch, ppMemo,
  ppModule, raCodMod, ppSubRpt, ppEndUsr,raide;

type
  TForm_report = class(TForm)
    ADS85: TADODataSet;
    DataSource1: TDataSource;
    ADS85TNUMBER: TStringField;
    ADS85REF_PART_NO: TStringField;
    ADS85CUST_PART_NO: TStringField;
    ADS85CUST_PART_DESC: TStringField;
    ADS85CUST_NAME: TStringField;
    ADS85quote_taxprice: TFloatField;
    ADS85CURR_NAME: TStringField;
    ADS85CURR_CODE: TStringField;
    ADS85CURR_RATE: TFloatField;
    ADS85vatax: TBCDField;
    ADS85MARKUP: TFloatField;
    ADS85QTE_DATE: TDateTimeField;
    ADS85EXPIRATION_DATE: TDateTimeField;
    ADS85EMPLOYEE_NAME: TStringField;
    ADS85REP_CODE: TStringField;
    ADS85SALES_REP_NAME: TStringField;
    ADS85PROD_CODE: TStringField;
    ADS85PRODUCT_NAME: TStringField;
    ADS85CODE: TStringField;
    ADS85QTE_APPROV_DESC: TStringField;
    ADS85ROW_NAME: TStringField;
    ADS85CUST_ADD1: TStringField;
    ADS85NOTE_INFO: TStringField;
    ADS85rej_info: TMemoField;
    ADS85quote_price: TFloatField;
    ADS85MATL_COST: TFloatField;
    ADS85base_pcscost: TFloatField;
    ADS85ovhd_cost: TFloatField;
    ADS85total_cost: TFloatField;
    ADS85CRP_EST_QUANTITY: TBCDField;
    ADS85comm_cost: TFloatField;
    ADS85SHIPPING_CHARGE: TBCDField;
    ADS85QTE_UNITS: TFloatField;
    ADS85DSDesigner: TStringField;
    ADS85DSDesigner2: TStringField;
    ADS85DSDesigner4: TStringField;
    DataSource2: TDataSource;
    ADS511: TADODataSet;
    ADS511sheet_BMP: TBlobField;
    ADS511pnl_bmp: TBlobField;
    ADS511pnl2_bmp: TBlobField;
    ADS85rkey: TIntegerField;
    ppReport1: TppReport;
    ppDB511: TppDBPipeline;
    ADS253: TADODataSet;
    DataSource3: TDataSource;
    ADS253INV_PART_NUMBER: TStringField;
    ADS253INV_PART_DESCRIPTION: TStringField;
    ADS253ABBR_NAME: TStringField;
    ADS253UNIT_NAME: TStringField;
    ADS253price: TFloatField;
    ADS253QTY: TFloatField;
    ADS253pcs_cost: TFloatField;
    DataSource4: TDataSource;
    ADS431: TADODataSet;
    ADS431PARAMETER_NAME: TStringField;
    ADS431PARAMETER_DESC: TStringField;
    ADS431UNIT_NAME: TStringField;
    ADS431UNIT_VALUE: TStringField;
    ppDB431: TppDBPipeline;
    ADS432: TADODataSet;
    ADS432ADDER_NAME: TStringField;
    ADS432AMOUNT: TFloatField;
    ADS432cost_m2: TFloatField;
    ADS432cac_meoth: TStringField;
    DataSource5: TDataSource;
    ppDB432: TppDBPipeline;
    ADS432T: TADODataSet;
    ADS432TCATEGORY: TStringField;
    ADS432TAMOUNT: TFloatField;
    ADS432TFREE_AMOUNT: TFloatField;
    ADS432TTAX_FLAG: TStringField;
    DataSource6: TDataSource;
    ppDB432t: TppDBPipeline;
    ppDB493: TppDBPipeline;
    ADS493: TADODataSet;
    DataSource7: TDataSource;
    ADS493Company_Name: TStringField;
    ADS493Company_Name2: TStringField;
    ADS493Company_Name3: TStringField;
    ADS493ship_address: TStringField;
    ADS493Company_Icon: TBlobField;
    ADS493SITE_INFO_ADD_1: TStringField;
    ADS493SITE_INFO_ADD_2: TStringField;
    ADS493SITE_INFO_ADD_3: TStringField;
    ADS493SITE_INFO_PHONE: TStringField;
    ADS85unit_len: TFloatField;
    ADS85unit_wth: TFloatField;
    ADS85TUNITS: TIntegerField;
    ADS85APPRV_DATE: TDateTimeField;
    ppDesigner1: TppDesigner;
    ADS85USHEET: TBCDField;
    ADS85QTE_USHEET: TBCDField;
    ADS85DSDesigner3: TStringField;
    ADS85MATL_M2: TCurrencyField;
    ADS85BASE_M2: TCurrencyField;
    ADS85OVHD_M2: TCurrencyField;
    ADS85TOTAL_M2: TCurrencyField;
    ADS85CRP_EST_M2: TCurrencyField;
    ADS85COMM_M2: TCurrencyField;
    ADS85SHIPPING_M2: TCurrencyField;
    ADS85QTE_M2: TCurrencyField;
    ADS85QUOTE_NOTAX_M2: TCurrencyField;
    ADS85QUOTE_TAX_M2: TCurrencyField;
    ppDB85: TppDBPipeline;
    ADS432cost_total_m2: TFloatField;
    ppDB432ppField5: TppField;
    ADS85DSDesigner5: TBCDField;
    ppReport2: TppReport;
    ppDesigner2: TppDesigner;
    ADS253QTY_BOM: TFloatField;
    ppDB253: TppDBPipeline;
    ADS061: TADODataSet;
    ADS061rkey: TIntegerField;
    ADS061CATEGORY: TStringField;
    ADS061AMOUNT: TFloatField;
    ADS061FREE_AMOUNT: TFloatField;
    ADS061TAX_FLAG: TStringField;
    ADS061Mould_set: TFloatField;
    DataSource8: TDataSource;
    ppDB061: TppDBPipeline;
    ADS85DSDesigner6: TIntegerField;
    ADS253METAL: TStringField;
    ADS8501: TADODataSet;
    DataSource9: TDataSource;
    ADS8501D0085_Ptr: TIntegerField;
    ADS8501Cost_Name: TStringField;
    ADS8501Cost: TFloatField;
    ADS8501Flag_tax: TStringField;
    ppTitleBand3: TppTitleBand;
    ppDBText36: TppDBText;
    ppDBImage2: TppDBImage;
    ppSystemVariable2: TppSystemVariable;
    ppLabel1: TppLabel;
    ppLabel50: TppLabel;
    ppHeaderBand2: TppHeaderBand;
    ppShape3: TppShape;
    ppDBText37: TppDBText;
    ppLabel51: TppLabel;
    ppLine29: TppLine;
    ppLabel52: TppLabel;
    ppDBText38: TppDBText;
    ppLabel53: TppLabel;
    ppLabel54: TppLabel;
    ppLabel55: TppLabel;
    ppDBText39: TppDBText;
    ppDBText40: TppDBText;
    ppDBText41: TppDBText;
    ppLine30: TppLine;
    ppLine31: TppLine;
    ppLine32: TppLine;
    ppLabel56: TppLabel;
    ppDBText42: TppDBText;
    ppLine33: TppLine;
    ppLine34: TppLine;
    ppLine35: TppLine;
    ppDBText43: TppDBText;
    ppLabel57: TppLabel;
    ppLabel58: TppLabel;
    ppDBText44: TppDBText;
    ppDBText45: TppDBText;
    ppLabel59: TppLabel;
    ppDBText46: TppDBText;
    ppLabel60: TppLabel;
    ppLabel61: TppLabel;
    ppDBText47: TppDBText;
    ppLabel62: TppLabel;
    ppDBText48: TppDBText;
    ppDBText49: TppDBText;
    ppLabel63: TppLabel;
    ppLine36: TppLine;
    ppLabel64: TppLabel;
    ppLabel65: TppLabel;
    ppDBText50: TppDBText;
    ppDBText51: TppDBText;
    ppLine37: TppLine;
    ppLine38: TppLine;
    ppLine39: TppLine;
    ppImage2: TppImage;
    ppMemo3: TppMemo;
    ppMemo4: TppMemo;
    ppLabel66: TppLabel;
    ppLabel67: TppLabel;
    ppLabel68: TppLabel;
    ppLabel69: TppLabel;
    ppLine40: TppLine;
    ppLine41: TppLine;
    ppLabel70: TppLabel;
    ppLabel71: TppLabel;
    ppDetailBand3: TppDetailBand;
    ppLine42: TppLine;
    ppDBText52: TppDBText;
    ppDBText53: TppDBText;
    ppLine43: TppLine;
    ppFooterBand2: TppFooterBand;
    ppDBMemo3: TppDBMemo;
    ppLabel72: TppLabel;
    ppDBText54: TppDBText;
    ppLabel73: TppLabel;
    ppLine44: TppLine;
    ppLabel74: TppLabel;
    ppLine45: TppLine;
    ppLabel75: TppLabel;
    ppLine46: TppLine;
    ppLabel76: TppLabel;
    ppLine47: TppLine;
    ppDBText55: TppDBText;
    ppLine48: TppLine;
    ppLabel77: TppLabel;
    ppLabel78: TppLabel;
    ppLabel79: TppLabel;
    ppSummaryBand3: TppSummaryBand;
    ppLabel80: TppLabel;
    ppLine49: TppLine;
    ppLabel81: TppLabel;
    ppLine50: TppLine;
    ppDBText56: TppDBText;
    ppLabel82: TppLabel;
    ppDBText57: TppDBText;
    ppDBText58: TppDBText;
    ppLabel83: TppLabel;
    ppLabel84: TppLabel;
    ppDBText59: TppDBText;
    ppLabel85: TppLabel;
    ppLabel86: TppLabel;
    ppDBMemo4: TppDBMemo;
    ppLabel87: TppLabel;
    ppLabel88: TppLabel;
    ppDBText60: TppDBText;
    ADS8501Total_Cost: TFloatField;
    ppDB8501: TppDBPipeline;
    ppTitleBand1: TppTitleBand;
    ppDBText1: TppDBText;
    ppDBImage1: TppDBImage;
    ppSystemVariable1: TppSystemVariable;
    ppLabel2: TppLabel;
    ppLabel3: TppLabel;
    ppHeaderBand1: TppHeaderBand;
    ppShape1: TppShape;
    ppDBText2: TppDBText;
    ppLabel4: TppLabel;
    ppLine1: TppLine;
    ppLabel5: TppLabel;
    ppDBText3: TppDBText;
    ppLabel6: TppLabel;
    ppLabel7: TppLabel;
    ppLabel8: TppLabel;
    ppDBText4: TppDBText;
    ppDBText5: TppDBText;
    ppDBText6: TppDBText;
    ppLine2: TppLine;
    ppLine3: TppLine;
    ppLine4: TppLine;
    ppLabel9: TppLabel;
    ppDBText7: TppDBText;
    ppLine5: TppLine;
    ppLine6: TppLine;
    ppLine7: TppLine;
    ppDBText8: TppDBText;
    ppLabel10: TppLabel;
    ppLabel11: TppLabel;
    ppDBText10: TppDBText;
    ppDBText11: TppDBText;
    ppLabel12: TppLabel;
    ppLabel14: TppLabel;
    ppDBText13: TppDBText;
    ppLabel15: TppLabel;
    ppDBText14: TppDBText;
    ppDBText15: TppDBText;
    ppLabel16: TppLabel;
    ppLine8: TppLine;
    ppLabel17: TppLabel;
    ppLabel18: TppLabel;
    ppDBText16: TppDBText;
    ppDBText17: TppDBText;
    ppLine9: TppLine;
    ppLine10: TppLine;
    ppLine11: TppLine;
    ppLabel109: TppLabel;
    ppDBText84: TppDBText;
    ppDBText85: TppDBText;
    ppSubReport1: TppSubReport;
    ppChildReport1: TppChildReport;
    ppTitleBand2: TppTitleBand;
    ppLine12: TppLine;
    ppLine13: TppLine;
    ppLine14: TppLine;
    ppLabel25: TppLabel;
    ppLabel26: TppLabel;
    ppLabel27: TppLabel;
    ppLine17: TppLine;
    ppLine18: TppLine;
    ppLine15: TppLine;
    ppLabel28: TppLabel;
    ppLine16: TppLine;
    ppLabel29: TppLabel;
    ppLine19: TppLine;
    ppLine20: TppLine;
    ppLine21: TppLine;
    ppLabel30: TppLabel;
    ppDetailBand2: TppDetailBand;
    ppLine22: TppLine;
    ppDBText21: TppDBText;
    ppDBText22: TppDBText;
    ppDBText23: TppDBText;
    ppLine80: TppLine;
    ppLine81: TppLine;
    ppLine82: TppLine;
    ppDBText9: TppDBText;
    ppLabel110: TppLabel;
    ppLine83: TppLine;
    ppDBText18: TppDBText;
    ppLine84: TppLine;
    ppLine85: TppLine;
    ppLine86: TppLine;
    ppDBText86: TppDBText;
    ppSummaryBand2: TppSummaryBand;
    raCodeModule1: TraCodeModule;
    ppDetailBand1: TppDetailBand;
    ppLine23: TppLine;
    ppDBText19: TppDBText;
    ppDBText20: TppDBText;
    ppDBText24: TppDBText;
    ppDBText25: TppDBText;
    ppLine24: TppLine;
    ppFooterBand1: TppFooterBand;
    ppDBMemo2: TppDBMemo;
    ppLabel32: TppLabel;
    ppDBText28: TppDBText;
    ppLabel33: TppLabel;
    ppLine26: TppLine;
    ppLabel34: TppLabel;
    ppLine27: TppLine;
    ppLabel35: TppLabel;
    ppLine28: TppLine;
    ppLabel40: TppLabel;
    ppLine57: TppLine;
    ppDBText31: TppDBText;
    ppLine58: TppLine;
    ppLabel48: TppLabel;
    ppLabel36: TppLabel;
    ppLabel37: TppLabel;
    ppSummaryBand1: TppSummaryBand;
    ppShape2: TppShape;
    ppSubReport4: TppSubReport;
    ppChildReport4: TppChildReport;
    ppTitleBand6: TppTitleBand;
    ppDetailBand6: TppDetailBand;
    ppDBText90: TppDBText;
    ppDBText12: TppDBText;
    ppLabel111: TppLabel;
    ppDBText61: TppDBText;
    ppSummaryBand6: TppSummaryBand;
    ppVariable1: TppVariable;
    ppDBCalc3: TppDBCalc;
    ppLabel13: TppLabel;
    raCodeModule5: TraCodeModule;
    ppLabel38: TppLabel;
    ppDBText26: TppDBText;
    ppLabel39: TppLabel;
    ppDBText27: TppDBText;
    ppLabel41: TppLabel;
    ppDBText29: TppDBText;
    ppLabel42: TppLabel;
    ppDBText30: TppDBText;
    ppLabel43: TppLabel;
    ppLine59: TppLine;
    ppLabel44: TppLabel;
    ppDBText32: TppDBText;
    ppLabel45: TppLabel;
    ppDBText33: TppDBText;
    ppLabel46: TppLabel;
    ppLine60: TppLine;
    ppLabel47: TppLabel;
    ppDBText34: TppDBText;
    ppLabel97: TppLabel;
    ppDBText35: TppDBText;
    ppDBText71: TppDBText;
    ppLabel98: TppLabel;
    ppLabel99: TppLabel;
    ppDBText72: TppDBText;
    ppLabel100: TppLabel;
    ppLabel101: TppLabel;
    ppDBMemo1: TppDBMemo;
    ppLabel102: TppLabel;
    ppLabel103: TppLabel;
    ppDBText73: TppDBText;
    ppLine61: TppLine;
    ppLine62: TppLine;
    ppLine63: TppLine;
    ppDBText74: TppDBText;
    ppDBText75: TppDBText;
    ppDBText76: TppDBText;
    ppDBText77: TppDBText;
    ppDBText78: TppDBText;
    ppDBText79: TppDBText;
    ppDBText80: TppDBText;
    ppLabel104: TppLabel;
    ppSubReport3: TppSubReport;
    ppChildReport3: TppChildReport;
    ppTitleBand5: TppTitleBand;
    ppShape5: TppShape;
    ppLabel105: TppLabel;
    ppLine64: TppLine;
    ppLabel106: TppLabel;
    ppLine65: TppLine;
    ppLabel107: TppLabel;
    ppDetailBand5: TppDetailBand;
    ppDBText81: TppDBText;
    ppDBText82: TppDBText;
    ppLine66: TppLine;
    ppLine67: TppLine;
    ppLine68: TppLine;
    ppLine69: TppLine;
    ppLine70: TppLine;
    ppDBText83: TppDBText;
    ppSummaryBand5: TppSummaryBand;
    ppDBCalc1: TppDBCalc;
    ppLine71: TppLine;
    ppLine72: TppLine;
    ppLine73: TppLine;
    ppLine74: TppLine;
    ppLabel108: TppLabel;
    ppLine75: TppLine;
    ppDBCalc2: TppDBCalc;
    raCodeModule3: TraCodeModule;
    ppGroup1: TppGroup;
    ppGroupHeaderBand1: TppGroupHeaderBand;
    ppLabel24: TppLabel;
    ppLabel23: TppLabel;
    ppLabel22: TppLabel;
    ppLabel21: TppLabel;
    ppLine76: TppLine;
    ppLine77: TppLine;
    ppLine78: TppLine;
    ppLine79: TppLine;
    ppMemo1: TppMemo;
    ppMemo2: TppMemo;
    ppLabel19: TppLabel;
    ppLabel20: TppLabel;
    ppLine25: TppLine;
    ppLabel31: TppLabel;
    ppLabel49: TppLabel;
    ppImage1: TppImage;
    ppGroupFooterBand1: TppGroupFooterBand;
    raCodeModule4: TraCodeModule;
    procedure ADS85CalcFields(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_report: TForm_report;

implementation

uses damo;

{$R *.dfm}

procedure TForm_report.ADS85CalcFields(DataSet: TDataSet);
begin
  if self.ADS85DSDesigner3.Value='PCS' then   //���۵�Ԫ
  begin
   if dm.qte_type=1 then
   begin
     ADS85MATL_M2.Value:=ADS85MATL_COST.value*ADS85USHEET.Value;
     ADS85BASE_M2.Value:=ADS85base_pcscost.value*ADS85USHEET.Value;
     ADS85OVHD_M2.Value:=ADS85ovhd_cost.value*ADS85USHEET.Value;
     ADS85TOTAL_M2.Value:=ADS85total_cost.value*ADS85USHEET.Value;
     ADS85CRP_EST_M2.Value:=ADS85CRP_EST_QUANTITY.value*ADS85USHEET.Value;
     ADS85COMM_M2.Value:=ADS85comm_cost.value*ADS85USHEET.Value;
     ADS85SHIPPING_M2.Value:=ADS85SHIPPING_CHARGE.value*ADS85USHEET.Value;
     ADS85QTE_M2.Value:=ADS85QTE_UNITS.value*ADS85USHEET.Value;
     ADS85QUOTE_NOTAX_M2.Value:=ADS85quote_price.value*ADS85USHEET.Value;
     ADS85QUOTE_TAX_M2.Value:=ADS85quote_taxprice.value*ADS85USHEET.Value;

   end
   else
   begin
     ADS85MATL_M2.Value:=ADS85MATL_COST.value*ADS85TUNITS.Value/
                                   (ADS85UNIT_LEN.Value*ADS85UNIT_WTH.Value*0.000001);
     ADS85BASE_M2.Value:=ADS85base_pcscost.value*ADS85TUNITS.Value/
                                   (ADS85UNIT_LEN.Value*ADS85UNIT_WTH.Value*0.000001);
     ADS85OVHD_M2.Value:=ADS85ovhd_cost.value*ADS85TUNITS.Value/
                                   (ADS85UNIT_LEN.Value*ADS85UNIT_WTH.Value*0.000001);
     ADS85TOTAL_M2.Value:=ADS85total_cost.value*ADS85TUNITS.Value/
                                   (ADS85UNIT_LEN.Value*ADS85UNIT_WTH.Value*0.000001);
     ADS85CRP_EST_M2.Value:=ADS85CRP_EST_QUANTITY.value*ADS85TUNITS.Value/
                                   (ADS85UNIT_LEN.Value*ADS85UNIT_WTH.Value*0.000001);
     ADS85COMM_M2.Value:=ADS85comm_cost.value*ADS85TUNITS.Value/
                                   (ADS85UNIT_LEN.Value*ADS85UNIT_WTH.Value*0.000001);
     ADS85SHIPPING_M2.Value:=ADS85SHIPPING_CHARGE.value*ADS85TUNITS.Value/
                                   (ADS85UNIT_LEN.Value*ADS85UNIT_WTH.Value*0.000001);
     ADS85QTE_M2.Value:=ADS85QTE_UNITS.value*ADS85TUNITS.Value/
                                   (ADS85UNIT_LEN.Value*ADS85UNIT_WTH.Value*0.000001);
     ADS85QUOTE_NOTAX_M2.Value:=ADS85quote_price.value*ADS85TUNITS.Value/
                                   (ADS85UNIT_LEN.Value*ADS85UNIT_WTH.Value*0.000001);
     ADS85QUOTE_TAX_M2.Value:=ADS85quote_taxprice.value*ADS85TUNITS.Value/
                                   (ADS85UNIT_LEN.Value*ADS85UNIT_WTH.Value*0.000001);
   end;
  end
  else
  begin
   if dm.qte_type=1 then
   begin
   ADS85MATL_M2.Value:=ADS85MATL_COST.value*ADS85USHEET.Value/ADS85TUNITS.Value;
   ADS85BASE_M2.Value:=ADS85base_pcscost.value*ADS85USHEET.Value/ADS85TUNITS.Value;
   ADS85OVHD_M2.Value:=ADS85ovhd_cost.value*ADS85USHEET.Value/ADS85TUNITS.Value;
   ADS85TOTAL_M2.Value:=ADS85total_cost.value*ADS85USHEET.Value/ADS85TUNITS.Value;
   ADS85CRP_EST_M2.Value:=ADS85CRP_EST_QUANTITY.value*ADS85USHEET.Value/ADS85TUNITS.Value;
   ADS85COMM_M2.Value:=ADS85comm_cost.value*ADS85USHEET.Value/ADS85TUNITS.Value;
   ADS85SHIPPING_M2.Value:=ADS85SHIPPING_CHARGE.value*ADS85USHEET.Value/ADS85TUNITS.Value;
   ADS85QTE_M2.Value:=ADS85QTE_UNITS.value*ADS85USHEET.Value/ADS85TUNITS.Value;
   ADS85QUOTE_NOTAX_M2.Value:=ADS85quote_price.value*ADS85USHEET.Value/ADS85TUNITS.Value;
   ADS85QUOTE_TAX_M2.Value:=ADS85quote_taxprice.value*ADS85USHEET.Value/ADS85TUNITS.Value;
   end
   else
   begin
     ADS85MATL_M2.Value:=ADS85MATL_COST.value/
                                      (ADS85UNIT_LEN.Value*ADS85UNIT_WTH.Value*0.000001);
     ADS85BASE_M2.Value:=ADS85base_pcscost.value/
                                      (ADS85UNIT_LEN.Value*ADS85UNIT_WTH.Value*0.000001);
     ADS85OVHD_M2.Value:=ADS85ovhd_cost.value/
                                       (ADS85UNIT_LEN.Value*ADS85UNIT_WTH.Value*0.000001);
     ADS85TOTAL_M2.Value:=ADS85total_cost.value/
                                       (ADS85UNIT_LEN.Value*ADS85UNIT_WTH.Value*0.000001);
     ADS85CRP_EST_M2.Value:=ADS85CRP_EST_QUANTITY.value/
                                       (ADS85UNIT_LEN.Value*ADS85UNIT_WTH.Value*0.000001);
     ADS85COMM_M2.Value:=ADS85comm_cost.value/
                                       (ADS85UNIT_LEN.Value*ADS85UNIT_WTH.Value*0.000001);
     ADS85SHIPPING_M2.Value:=ADS85SHIPPING_CHARGE.value/
                                       (ADS85UNIT_LEN.Value*ADS85UNIT_WTH.Value*0.000001);
     ADS85QTE_M2.Value:=ADS85QTE_UNITS.value/
                                       (ADS85UNIT_LEN.Value*ADS85UNIT_WTH.Value*0.000001);
     ADS85QUOTE_NOTAX_M2.Value:=ADS85quote_price.value/
                                       (ADS85UNIT_LEN.Value*ADS85UNIT_WTH.Value*0.000001);
     ADS85QUOTE_TAX_M2.Value:=ADS85quote_taxprice.value/
                                       (ADS85UNIT_LEN.Value*ADS85UNIT_WTH.Value*0.000001);
   end;
  end;
end;

end.
