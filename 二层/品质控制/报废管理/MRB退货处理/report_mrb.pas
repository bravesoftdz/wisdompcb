unit report_mrb;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, ppDB, ppComm, ppRelatv, ppDBPipe, ppProd, ppClass,
  ppReport, ppCtrls, ppPrnabl, ppBands, ppCache, ppEndUsr;

type
  TForm_report = class(TForm)
    AQ414: TADOQuery;
    AQ414rkey: TAutoIncField;
    AQ414number414: TStringField;
    AQ414qty_rece: TIntegerField;
    AQ414qty_to_be_reworked: TIntegerField;
    AQ414qty_to_be_remaked: TIntegerField;
    AQ414sys_date414: TDateTimeField;
    AQ414EMPLOYEE_NAME: TStringField;
    AQ414number415: TStringField;
    AQ414ABBR_NAME10: TStringField;
    AQ414status: TWordField;
    AQ414v_status: TStringField;
    AQ414QTY_REWORKED: TIntegerField;
    AQ414QTY_REMAKED: TIntegerField;
    AQ414custpart_ptr: TIntegerField;
    AQ414quantity: TIntegerField;
    AQ414qty_received: TIntegerField;
    DataSource1: TDataSource;
    AQ414cust_code: TStringField;
    AQ414customer_name: TStringField;
    AQ99: TADOQuery;
    AQ99REJ_CODE: TStringField;
    AQ99REJECT_DESCRIPTION: TStringField;
    AQ99REJECT_DEFECT_FLAG: TStringField;
    AQ99QUANTITY: TIntegerField;
    AQ99TDATE: TDateTimeField;
    AQ99REFERENCE_NUMBER: TStringField;
    DataSource2: TDataSource;
    DataSource3: TDataSource;
    Aq493: TADOQuery;
    Aq493Company_Name: TStringField;
    Aq493Company_Name2: TStringField;
    Aq493Company_Name3: TStringField;
    Aq493ship_address: TStringField;
    Aq493Company_Icon: TBlobField;
    Aq493SITE_INFO_ADD_1: TStringField;
    Aq493SITE_INFO_ADD_2: TStringField;
    Aq493SITE_INFO_ADD_3: TStringField;
    Aq493SITE_INFO_PHONE: TStringField;
    ppDB493: TppDBPipeline;
    ppDB414: TppDBPipeline;
    ppDB99: TppDBPipeline;
    ppReport1: TppReport;
    AQ99v_type: TStringField;
    ppTitleBand1: TppTitleBand;
    ppDBText5: TppDBText;
    ppDBText6: TppDBText;
    ppDBText7: TppDBText;
    ppDBText8: TppDBText;
    ppDBText9: TppDBText;
    ppDBText10: TppDBText;
    ppDBText11: TppDBText;
    ppLabel1: TppLabel;
    ppLabel2: TppLabel;
    ppLabel3: TppLabel;
    ppLabel4: TppLabel;
    ppDBText12: TppDBText;
    ppLabel5: TppLabel;
    ppDBText13: TppDBText;
    ppLabel6: TppLabel;
    ppLabel7: TppLabel;
    ppLabel8: TppLabel;
    ppLabel9: TppLabel;
    ppLabel10: TppLabel;
    ppHeaderBand1: TppHeaderBand;
    ppShape1: TppShape;
    ppLabel11: TppLabel;
    ppLabel12: TppLabel;
    ppLabel13: TppLabel;
    ppLabel14: TppLabel;
    ppLine8: TppLine;
    ppLine9: TppLine;
    ppLine10: TppLine;
    ppLine11: TppLine;
    ppDetailBand1: TppDetailBand;
    ppLine1: TppLine;
    ppDBText1: TppDBText;
    ppDBText2: TppDBText;
    ppDBText3: TppDBText;
    ppDBText4: TppDBText;
    ppLine2: TppLine;
    ppLine3: TppLine;
    ppLine4: TppLine;
    ppLine5: TppLine;
    ppLine6: TppLine;
    ppLine7: TppLine;
    ppFooterBand1: TppFooterBand;
    ppLabel15: TppLabel;
    ppDBText14: TppDBText;
    AQ414MANU_PART_NUMBER: TStringField;
    AQ414MANU_PART_DESC: TStringField;
    ppDesigner1: TppDesigner;
    procedure AQ99CalcFields(DataSet: TDataSet);
    procedure AQ414CalcFields(DataSet: TDataSet);
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

procedure TForm_report.AQ99CalcFields(DataSet: TDataSet);
begin
 if self.AQ99REJECT_DEFECT_FLAG.Value='D' then
  self.AQ99v_type.Value := '����Ʒ'
 else
  self.AQ99v_type.Value := '����Ʒ';
end;

procedure TForm_report.AQ414CalcFields(DataSet: TDataSet);
begin
 case AQ414status.Value of
  1:self.AQ414v_status.Value:='δ�ύ';
  2:self.AQ414v_status.Value:='������';
  3:self.AQ414v_status.Value:='�����';
 end;
end;

end.
