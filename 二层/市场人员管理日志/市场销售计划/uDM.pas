unit uDM;

interface

uses
  SysUtils, Classes, DB, ADODB;

type
  TDM = class(TDataModule)
    Conn: TADOConnection;
    AQery704: TADOQuery;
    ADS705: TADODataSet;
    DataSource1: TDataSource;
    DataSource2: TDataSource;
    DataSource3: TDataSource;
    DataSource4: TDataSource;
    AQery704RKEY: TIntegerField;
    AQery704YJH: TIntegerField;
    AQery704MJH: TIntegerField;
    AQery704MJHJE: TBCDField;
    AQery704YJHJE: TBCDField;
    AQery704LJJE: TBCDField;
    AQery704SQJHJE: TBCDField;
    AQery704SQWCJE: TBCDField;
    AQery704BQMBJE: TBCDField;
    AQery704BQJHJE: TBCDField;
    AQery704status: TIntegerField;
    AQery704CJRPTR: TIntegerField;
    AQery704CJRQ: TDateTimeField;
    AQery704Note: TStringField;
    ADS705RKEY: TIntegerField;
    ADS705ptr704: TIntegerField;
    ADS705PTR10: TIntegerField;
    ADS705BQJHDD: TBCDField;
    ADS705BQJHYP: TIntegerField;
    ADS705BQJHJE: TBCDField;
    ADS705ZYCL: TStringField;
    ADS705XYSTATUS: TIntegerField;
    ADS705ABBR_NAME: TStringField;
    AQery704CStatus: TStringField;
    AQery704EMPLOYEE_NAME: TStringField;
    ADS705CXYSTATUS: TStringField;
    ADS706: TADODataSet;
    ADS706RKEY: TIntegerField;
    ADS706PTR704: TIntegerField;
    ADS706PTR10: TIntegerField;
    ADS706KHMC: TStringField;
    ADS706GMRS: TIntegerField;
    ADS706ZYCP: TStringField;
    ADS706PCBYL: TBCDField;
    ADS706TXDZ: TStringField;
    ADS706TXDH: TStringField;
    ADS706TXRXM: TStringField;
    ADS706HZYX: TIntegerField;
    ADS706CHZYX: TStringField;
    ADS707: TADODataSet;
    ADS707RKEY: TIntegerField;
    ADS707PTR: TIntegerField;
    ADS707PTR10: TIntegerField;
    ADS707HJYS: TBCDField;
    ADS707DQYS: TBCDField;
    ADS707JHYS: TBCDField;
    ADS707JHRQ: TDateTimeField;
    ADS707HZSTATUS: TIntegerField;
    ADS707ABBR_NAME: TStringField;
    ADS707CHZSTATUS: TStringField;
    AQery: TADOQuery;
    AQery704YZNBL: TBCDField;
    AQery704YWWJE: TBCDField;
    AQery704WWZNBL: TBCDField;
    AQery704SQXCJE: TBCDField;
    AQery704SQWCBL: TBCDField;
    AQery704BQXCJE: TBCDField;
    AQery704BQJHBL: TBCDField;
    ADS705CPSL: TBCDField;
    ADS705PTR5: TIntegerField;
    ADS707CQTS: TBCDField;
    AQery704EMPL_CODE: TStringField;
    ADS705CCPStatus: TStringField;
    ADS705CPStatus: TIntegerField;
    AQery704JHID: TStringField;
    AQery4: TADOQuery;
    AQery5: TADOQuery;
    AQery704CZYStatus: TStringField;
    AQery704ZYStatus: TIntegerField;
    AQery704ZYRBM: TIntegerField;
    AQery704DEPT_NAME: TStringField;
    AQery704DEPT_CODE: TStringField;
    AQery5RKEY: TAutoIncField;
    AQery5EMPL_CODE: TStringField;
    AQery5EMPLOYEE_NAME: TStringField;
    AQery5EMPLOYEE_ID: TIntegerField;
    AQery5popedom: TWordField;
    AQery5ZY: TStringField;
    AQery5BMRKY: TAutoIncField;
    procedure AQery704CalcFields(DataSet: TDataSet);
    procedure ADS705CalcFields(DataSet: TDataSet);
    procedure ADS706CalcFields(DataSet: TDataSet);
    procedure ADS707CalcFields(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM: TDM;

implementation

{$R *.dfm}
//����Ŀ��
procedure TDM.AQery704CalcFields(DataSet: TDataSet);
begin
 case dm.AQery704.FieldByName('status').Value of
  0: dm.AQery704.FieldValues['cstatus']:='����';
  1: dm.AQery704.FieldValues['cstatus']:='һ��';
  2: dm.AQery704.FieldValues['cstatus']:='��';
 end;
 // ְλ
 case  dm.AQery704.FieldByName('ZYStatus').Value of
  0: dm.AQery704.FieldValues['CZYStatus']:='��';
  1: dm.AQery704.FieldValues['CZYStatus']:='����Ա';
  2: dm.AQery704.FieldValues['CZYStatus']:='ҵ��Ա';
  3: dm.AQery704.FieldValues['CZYStatus']:='Ӫ������';
  4: dm.AQery704.FieldValues['CZYStatus']:='��������';
 end;

end;
//���ܿͻ�
procedure TDM.ADS705CalcFields(DataSet: TDataSet);
begin
 case dm.ADS705.FieldByName('XYSTATUS').Value of
  0: dm.ADS705.FieldValues['cXYSTATUS']:='��';
  1: dm.ADS705.FieldValues['cXYSTATUS']:='��';
  2: dm.ADS705.FieldValues['cXYSTATUS']:='һ��';
  3: dm.ADS705.FieldValues['cXYSTATUS']:='��';
 end;
//��Ʒ����
 case dm.ADS705.FieldByName('CPStatus').Value of
  0: dm.ADS705.FieldValues['CCPStatus']:='�����';
  1: dm.ADS705.FieldValues['CCPStatus']:='˫���';
  2: dm.ADS705.FieldValues['CCPStatus']:='�����';
 end;
end;
 //�����ƻ���
procedure TDM.ADS706CalcFields(DataSet: TDataSet);
begin
 case dm.ADS706.FieldByName('HZYX').Value of
  0: dm.ADS706.FieldValues['CHZYX']:='�ǳ�����';
  1: dm.ADS706.FieldValues['CHZYX']:='�п���';
  2: dm.ADS706.FieldValues['CHZYX']:='��ʱ�������';
 end;

end;
//�ƻ��տ�
procedure TDM.ADS707CalcFields(DataSet: TDataSet);
begin
 case dm.ADS707.FieldByName('HZSTATUS').Value of
  0: dm.ADS707.FieldValues['CHZSTATUS']:='��������';
  1: dm.ADS707.FieldValues['CHZSTATUS']:='���ƺ���';
  2: dm.ADS707.FieldValues['CHZSTATUS']:='ֹͣ����';
 end;
end;

end.
