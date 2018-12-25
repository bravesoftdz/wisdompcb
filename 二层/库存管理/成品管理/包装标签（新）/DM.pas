unit DM;

interface

uses
  SysUtils, Classes, DB, ADODB, ppDB, ppDBPipe, ppComm, ppRelatv, ppProd,
  ppClass, ppReport, ppBands, ppVar, ppBarCod, ppCtrls, ppPrnabl, ppCache,
  Graphics, jpeg, Provider, DBClient, ppModule, raCodMod, myChkBox,
  ppEndUsr, ExtCtrls;

type
  STRARR = array of string;


  TCustomType = (
    ctHW,//��Ϊ����
    ctHWZD,//��Ϊ�ն�
    ctCDHW,//�ɶ���Ϊ
    ctHWAJX,//��Ϊ������
    ctMRMT,//������̩
    //ctSAMSUNG,//����
    //ctGreatWall,//����
    ctCLS,//������
    ctZXKX,//���˿�Ѷ
    ctHS,//��˼�뵼��
    ctDH,//��
    ctDYH,//���˺�
    ctHQ,//����
    ctWT,//��̩
    ctTCL,//TCL
    ctJCKJ,//���ϿƼ�
    ctBCKJ,//�γ��Ƽ�
    ctYYD,//��ݸӢԴ��
    ctDGHS,//��ݸ��˶
    ctDGDELL,//��ݸ����
    ctSSJ,//ˮ����
    ctUnknow//����
  );

  TDM1 = class(TDataModule)
    con1: TADOConnection;
    adsFrmMain: TADODataSet;
    qrytmp: TADOQuery;
    atncfldFrmMainrkey: TAutoIncField;
    strngfldFrmMainpack_number: TStringField;
    intgrfldFrmMainso_ptr: TIntegerField;
    strngfldFrmMaindescription: TStringField;
    strngfldFrmMaincode: TStringField;
    intgrfldFrmMainqty: TIntegerField;
    strngfldFrmMainlotno: TStringField;
    strngfldFrmMainnotes: TStringField;
    adsFrmMainv_print: TBooleanField;
    dtmfldFrmMainv_date: TDateTimeField;
    intgrfldFrmMainempl_ptr: TIntegerField;
    intgrfldFrmMainpack_item: TIntegerField;
    strngfldFrmMaintype: TStringField;
    strngfldFrmMainsurface: TStringField;
    strngfldFrmMainnetWeight: TStringField;
    strngfldFrmMaingrossWeight: TStringField;
    strngfldFrmMaincaseSpec: TStringField;
    strngfldFrmMainemployee_name: TStringField;
    strngfldFrmMainMANU_PART_NUMBER: TStringField;
    strngfldFrmMainMANU_PART_DESC: TStringField;
    strngfldFrmMainANALYSIS_CODE_2: TStringField;
    strngfldFrmMainPO_NUMBER: TStringField;
    strngfldFrmMainSALES_ORDER: TStringField;
    intgrfldFrmMainREPUT_QTY: TIntegerField;
    fltfldFrmMainPARTS_ORDERED: TFloatField;
    atncfldFrmMainRKey60: TAutoIncField;
    strngfldFrmMainCUST_CODE: TStringField;
    strngfldFrmMainABBR_NAME: TStringField;
    intgrfldFrmMainset_qty: TIntegerField;
    strngfldFrmMainCURRENT_REV: TStringField;
    ppPrint: TppReport;
    adsReport: TADODataSet;
    dsReport: TDataSource;
    pdbReport: TppDBPipeline;
    adsReportDSDesigner: TSmallintField;
    adsReportDSDesigner2: TStringField;
    adsReportDSDesigner3: TStringField;
    adsReportDSDesigner4: TStringField;
    adsReportDSDesigner5: TStringField;
    adsReportDSDesigner6: TStringField;
    adsReportPCS: TIntegerField;
    adsReportDSDesigner7: TStringField;
    adsReportDSDesigner8: TStringField;
    adsReportDSDesigner9: TStringField;
    adsReportDSDesigner10: TStringField;
    adsReportDSDesigner11: TStringField;
    adsReportDSDesigner12: TStringField;
    adsReportDSDesigner13: TStringField;
    adsReportDSDesigner14: TStringField;
    adsReportDSDesigner15: TStringField;
    adsReportDSDesigner16: TStringField;
    adsReportDSDesigner17: TStringField;
    adsReportDSDesigner698: TStringField;
    adsReportDSDesigner18: TStringField;
    adsReportDSDesigner19: TStringField;
    adsReportDSDesigner20: TStringField;
    adsReportDSDesigner21: TStringField;
    adsReportDSDesigner22: TStringField;
    adsReportPCSSETS: TIntegerField;
    adsReportDSDesigner23: TStringField;
    adsReport_DN: TDateTimeField;
    adsReport_: TStringField;
    adsReport_2: TStringField;
    adsReport_3: TStringField;
    adsReport_4: TStringField;
    adsReportDSDesigner24: TStringField;
    strngfldReportDSDesigner1: TStringField;
    strngfldFrmMainORIG_CUSTOMER: TStringField;
    cdsReport: TClientDataSet;
    dspReport: TDataSetProvider;
    cdsReportCDSDesigner: TSmallintField;
    strngfldReportCDSDesigner2: TStringField;
    strngfldReportCDSDesigner3: TStringField;
    strngfldReportCDSDesigner4: TStringField;
    strngfldReportCDSDesigner5: TStringField;
    strngfldReportCDSDesigner6: TStringField;
    intgrfldReportPCS: TIntegerField;
    strngfldReportCDSDesigner7: TStringField;
    strngfldReportCDSDesigner8: TStringField;
    strngfldReportCDSDesigner9: TStringField;
    strngfldReportCDSDesigner10: TStringField;
    strngfldReportCDSDesigner11: TStringField;
    strngfldReportCDSDesigner12: TStringField;
    strngfldReportCDSDesigner13: TStringField;
    strngfldReportCDSDesigner14: TStringField;
    strngfldReportCDSDesigner15: TStringField;
    strngfldReportCDSDesigner16: TStringField;
    strngfldReportCDSDesigner17: TStringField;
    strngfldReportCDSDesigner698: TStringField;
    strngfldReportCDSDesigner18: TStringField;
    strngfldReportCDSDesigner19: TStringField;
    strngfldReportCDSDesigner20: TStringField;
    strngfldReportCDSDesigner21: TStringField;
    strngfldReportCDSDesigner22: TStringField;
    intgrfldReportPCSSETS: TIntegerField;
    strngfldReportCDSDesigner23: TStringField;
    cdsReport_DN: TDateTimeField;
    strngfldReport_1: TStringField;
    strngfldReport_2: TStringField;
    strngfldReport_3: TStringField;
    strngfldReport_4: TStringField;
    strngfldReportCDSDesigner24: TStringField;
    strngfldReportCDSDesigner1: TStringField;
    adsReportDSDesigner25: TIntegerField;
    cdsReportCDSDesigner2: TIntegerField;
    adsReportPCS2: TStringField;
    cdsReportPCS: TStringField;
    adsFrmMainpacksize: TStringField;
    adsReportCURRENT_REV: TStringField;
    adsReportmanu_part_number: TStringField;
    cdsReportCURRENT_REV: TStringField;
    cdsReportmanu_part_number: TStringField;
    adsReportANALYSIS_CODE_2: TStringField;
    cdsReportANALYSIS_CODE_2: TStringField;
    adsReportparam1: TStringField;
    cdsReportparam1: TStringField;
    adsReportCut_no: TStringField;
    adsReportCut_NO_Head: TStringField;
    adsReportSALES_ORDER: TStringField;
    cdsReportCut_NO: TStringField;
    cdsReportCut_NO_Head: TStringField;
    cdsReportSALES_ORDER: TStringField;
    adsReportparam2: TStringField;
    cdsReportparam2: TStringField;
    ppDesigner1: TppDesigner;
    adsFrmMainflag: TBooleanField;
    adsReportflag698: TBooleanField;
    cdsReportflag698: TBooleanField;
    strngfldReportP: TStringField;
    strngfldReportQPCS: TStringField;
    strngfldReportM: TStringField;
    strngfldReportD: TStringField;
    strngfldReportL: TStringField;
    strngfldReportS: TStringField;
    strngfldReportP1: TStringField;
    strngfldReportQPCS1: TStringField;
    strngfldReportM1: TStringField;
    strngfldReportD1: TStringField;
    strngfldReportL1: TStringField;
    strngfldReportS1: TStringField;
    strngfldReportM_1: TStringField;
    strngfldReportM_2: TStringField;
    strngfldReportM_3: TStringField;
    strngfldReportM_4: TStringField;
    strngfldReportLotOrder: TStringField;
    strngfldReportLotOrder1: TStringField;
    temp: TADOQuery;
    cdsReportField1P: TStringField;
    cdsReportV: TStringField;
    cdsReportField9D: TStringField;
    cdsReportField1TLotNo: TStringField;
    cdsReportP: TStringField;
    spDecToAbc36: TADOStoredProc;
    adsReportxBrode: TIntegerField;
    adsReportpsn: TStringField;
    cdsReportxBrode: TIntegerField;
    cdsReportpsn: TStringField;
    ppTitleBand1: TppTitleBand;
    ppHeaderBand1: TppHeaderBand;
    ppDetailBand1: TppDetailBand;
    ppLabel1: TppLabel;
    ppDBText1: TppDBText;
    ppLabel4: TppLabel;
    ppLabel21: TppLabel;
    ppLabel24: TppLabel;
    ppLabel25: TppLabel;
    ppLabel26: TppLabel;
    ppLabel27: TppLabel;
    ppLabel28: TppLabel;
    ppLabel29: TppLabel;
    ppDBText2: TppDBText;
    ppDBText3: TppDBText;
    ppDBText4: TppDBText;
    ppDBText5: TppDBText;
    ppLabel30: TppLabel;
    ppDBText7: TppDBText;
    ppDBText8: TppDBText;
    ppDBText37: TppDBText;
    ppLabel31: TppLabel;
    ppLabel72: TppLabel;
    ppDBText40: TppDBText;
    ppDBBarCode1: TppDBBarCode;
    ppDBBarCode24: TppDBBarCode;
    ppDBBarCode26: TppDBBarCode;
    ppDBBarCode27: TppDBBarCode;
    ppDBBarCode28: TppDBBarCode;
    ppDBBarCode29: TppDBBarCode;
    ppLabel93: TppLabel;
    ppLabel108: TppLabel;
    ppDBText49: TppDBText;
    lbl1: TppLabel;
    lbl2: TppLabel;
    lbl3: TppDBText;
    ppDBBarCode30: TppDBBarCode;
    ppImage1: TppImage;
    ppDBText6: TppDBText;
    ppLabel2: TppLabel;
    ppDBText9: TppDBText;
    ppFooterBand1: TppFooterBand;
    ppSummaryBand1: TppSummaryBand;
    //ppDetailBand1: TppDetailBand;
    //ppLabel1: TppLabel;
//    ppDBText1: TppDBText;
//    ppLabel4: TppLabel;
//    ppLabel21: TppLabel;
//    ppLabel24: TppLabel;
//    ppLabel25: TppLabel;
//    ppLabel26: TppLabel;
//    ppLabel27: TppLabel;
//    ppLabel28: TppLabel;
//    ppLabel29: TppLabel;
//    ppLabel30: TppLabel;
//    ppDBText2: TppDBText;
//    ppDBText3: TppDBText;
//    ppDBText4: TppDBText;
//    ppDBText5: TppDBText;
//    ppLabel31: TppLabel;
//    ppDBText7: TppDBText;
//    ppDBText8: TppDBText;
//    ppDBText37: TppDBText;
//    ppLabel72: TppLabel;
//    ppLabel93: TppLabel;
//    ppDBText40: TppDBText;
//    ppDBBarCode1: TppDBBarCode;
//    ppDBBarCode24: TppDBBarCode;
//    ppDBBarCode26: TppDBBarCode;
//    ppDBBarCode27: TppDBBarCode;
//    ppDBBarCode28: TppDBBarCode;
//    ppDBBarCode29: TppDBBarCode;
//    ppDBText49: TppDBText;
//    ppLabel108: TppLabel;
//    lbl1: TppLabel;
//    lbl2: TppLabel;
//    ppFooterBand1: TppFooterBand;
//    ppSummaryBand1: TppSummaryBand;
//    ppDBBarCode2: TppDBBarCode;
//    ppSystemVariable1: TppSystemVariable;
    procedure ppPrintPrintingComplete(Sender: TObject);
    procedure adsReportCalcFields(DataSet: TDataSet);
    procedure pdbReportNext(Sender: TObject);
    procedure cdsReportCalcFields(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
    F2303SCRQ: string;
    function SqlOpen(AStr: string): Boolean;
    function SqlExec(AStr: string): Boolean;
    function GetServerRegion: string;
    function GetXSDD(AManu_part_number, ACust_Code: string): string;
    function GetUserPermit(AUserName,APassWord, AExeName: string): string;
    procedure Config60REPUT_QTY(Arkey60: string);
    procedure Get2DCodeBmp(AText: string;APic: TPicture;ASize: Integer = 2);
    function SplitStrByChar(AStr: string; AChar: Char;
    out AOut: STRARR): Boolean;
  end;

  function GetCustType(ACustCode: string): TCustomType;
  function ABC36ToDec(ABC36: string): Int64;
  function DecToABC36(ADec: Int64): string;

var
  DM1: TDM1;

implementation

uses
  Dialogs, WZ_gUnit, MD5, qrcode, Math, StrUtils;

{$R *.dfm}


function TDM1.SplitStrByChar(AStr: string; AChar: Char;
  out AOut: STRARR): Boolean;
var
  I: Integer;
begin
  I := 1;
  while True do
  begin
    if I > Length(AStr) then
    begin
      SetLength(AOut,Length(AOut)+1);
      Aout[High(Aout)] := AStr;
      Break;
    end;

    if AStr[I] = AChar then
    begin
      SetLength(AOut,Length(AOut)+1);
      Aout[High(Aout)] := Copy(AStr,1,I-1);
      AStr := RightStr(AStr,Length(AStr)-I);
      I := 1;
      Continue;
    end;
    Inc(I);
  end;
  Result := True;
end;

function ABC36ToDec(ABC36: string): Int64;
var
  I: Integer;
  LABC36: string;
  LTmp: Integer;
  LRet: Int64;
  LTmp2: Int64;
  n: Integer;
begin
  LRet := 0;
  n := 0;
  LABC36 := UpperCase(ABC36);
  for I := Length(LABC36) downto 1 do
  begin
    LTmp := Ord(LABC36[I]);
    if (LTmp >= 48) and (LTmp <= 57) then
    begin
      LTmp2 := StrToInt(LABC36[I]) * Trunc(Power(36,n));
      LRet := LRet + LTmp2;
    end else
    if (LTmp >= 65) and (LTmp <= 90) then
    begin
      LTmp2 := (LTmp + 10 - 65) * Trunc(Power(36,n));
      LRet := LRet + LTmp2;
    end;
    Inc(n);
  end;
  Result := LRet;
end;



function DecToABC36(ADec: Int64): string;
begin
  DM1.spDecToAbc36.Close;
  dm1.spDecToAbc36.Parameters.ParamByName('@Dec').Value := ADec;
  DM1.spDecToAbc36.ExecProc;
  Result := DM1.spDecToAbc36.Parameters.parambyname('@out_ABC36').value;

end;
//var
//  LMod36: Int64;
//  LTmp: Int64;
//  RetStr: string;
//begin
//  LTmp := ADec;
//  repeat
//    LMod36 := LTmp mod 36;
//    if LMod36 <= 9 then
//      RetStr := RetStr + IntToStr(LMod36)
//    else
//      RetStr := RetStr + Char(LMod36 - 10 + 65);
//    LTmp := LTmp div 36;
//  until LTmp < 36;
//
//  if LTmp <> 0 then
//  begin
//    if LTmp <= 9 then
//      RetStr := RetStr + IntToStr(LTmp)
//    else
//      RetStr := RetStr + Char(LTmp - 10 + 65);
//  end;
//
//  Result :=  ReverseString(RetStr);
//end;

function GetCustType(ACustCode: string): TCustomType;
{
  ��Ϊ��1806(����),6169(��ݸ),Z0040(÷��)��2835����ɽ���ܣ�,2911,2834(������),2592,2848,(2855,2592)
  ��Ϊ�նˣ�1915(����),6005(��ݸ),Z0035(÷��),Z5249(÷��) ��2627(����)��7072(��ݸ)
  ��̩����(��Ѷ):2104(����),2109(����),Z5137(÷��)
  �ɶ���Ϊ: 1219(����),0138(÷��)
  ��Ϊ������: G1011(����)
  ���ǿ���:1202 �Ѿ�ʧЧ
  ������:1901
  ����:1850,1992,2157,2158  �Ѿ�ʧЧ
  ��˼�뵼��: S2258,2258,2516
  ���˿�Ѷ��2303,2156(����), (0275,0276,0257,1001,Z1377 ÷��) ,(7053��7345,6791 ��ݸ)
  �󻪣�2390, 2622
  ��̩��6259��ݸ
  ���˺ӣ�7100��ݸ,7101��ݸ ,6431��ݸ 6399��ݸ 7139��ݸ��7486��ݸ
  ���ڣ�6095��ݸ,6109��ݸ
  TCL��6298��ݸ ��6241 ��ݸ 7139 ��ݸ
  ���ϿƼ�: 6378��ݸ
  �γ��Ƽ�: S2763����
  ��ݸӢԴ��: 7340
  ��ݸ��˶: 7325
  ��ݸ������7364,7365,7195
}
begin
  if StrInArr(ACustCode,['1806','6169','Z0040','2835','2834','2592','2848','2855','2592','2911']) then Result := ctHW else
  if StrInArr(ACustCode,['1915','6005','Z0035','Z5249','2627','7072']) then Result := ctHWZD else
  if StrInArr(ACustCode,['2104','2109','Z5137']) then Result := ctMRMT else
  if StrInArr(ACustCode,['1219','Z0138']) then Result := ctCDHW else
  if StrInArr(ACustCode,['G1011']) then Result := ctHWAJX else
  //if StrInArr(ACustCode,['1202']) then Result := ctGreatWall else
  if StrInArr(ACustCode,['1901']) then Result := ctCLS else
  //if StrInArr(ACustCode,['1850','1992','2157','2158']) then Result := ctSAMSUNG else
  if StrInArr(ACustCode,['2303','Z0275','Z0276','Z0257','2156','Z1001','7053','7345','6791','Z1061','Z1289','2031','Z1377']) then Result := ctZXKX else
  if StrInArr(ACustCode,['S2258','2258','2516']) then Result := ctHS else
  if StrInArr(ACustCode,['2390','2622']) then Result := ctDH else
  //
  if StrInArr(ACustCode,['6259','7218']) then Result := ctWT else
  if StrInArr(ACustCode,['7100','7101','6431','6399','7139']) then Result := ctDYH else
  if StrInArr(ACustCode,['7486']) then Result := ctSSJ else
  if StrInArr(ACustCode,['6095','6109']) then Result := ctHQ else
  if StrInArr(ACustCode,['6298','6241','7139']) then Result := ctTCL else
  if StrInArr(ACustCode,['6378']) then Result := ctJCKJ else
  if StrInArr(ACustCode,['S2763','7826']) then Result := ctBCKJ else
  if StrInArr(ACustCode,['7340']) then Result := ctYYD else
  if StrInArr(ACustCode,['7325']) then Result := ctDGHS else
  if StrInArr(ACustCode,['7364','7365','7195']) then Result := ctDGDELL else
  Result := ctUnknow;
end;


{ TDM1 }

function TDM1.GetServerRegion: string;
  function GetServerIP: string;
  var
    I: Integer;
    tmpS: string;
  begin
    tmpS := gUser.DBConnectString;
    for I := pos('Data Source=',gUser.DBConnectString) to Length(gUser.DBConnectString) do
    begin
      if gUser.DBConnectString[I] = ';' then Break;
      tmpS := tmpS + gUser.DBConnectString[I];
      if gUser.DBConnectString[I] = '=' then tmpS := '';
    end;
    Result := tmpS;
  end;
var
  LServrIP: string;
  PosIndex: Integer;
  I: Integer;
  IPSec2: string;
begin
  LServrIP := GetServerIP;
  PosIndex := 0;
  for I := 1 to Length(LServrIP) do
  begin
    if LServrIP[I] = '.' then
    begin
      Inc(PosIndex);
      Continue;
    end;
    if PosIndex = 1 then
    begin
      IPSec2 := IPSec2 + LServrIP[I];
    end;
  end;
  case StrToIntdef(IPSec2,-1) of
    16:
    begin
      Result := '����';
    end;
    17:
    begin
      Result := '÷��';
    end;
    168,18:
    begin
      Result := '��ݸ';
    end;
  else
    Result := 'δ֪'
  end;
end;

function TDM1.SqlExec(AStr: string): Boolean;
begin
  //Result := False;
  try
    qrytmp.Close;
    qrytmp.SQL.Clear;
    qrytmp.SQL.Add(AStr);
    qrytmp.ExecSQL;
    Result := True;
  except
    on E: Exception do
    begin
      ShowMessage(E.Message);
      Result := False;
    end;
  end;
end;

function TDM1.SqlOpen(AStr: string): Boolean;
begin
  //Result := False;
  try
    qrytmp.Close;
    qrytmp.SQL.Clear;
    qrytmp.SQL.Add(AStr);
    qrytmp.Open;
    Result := True;
  except
    on E: Exception do
    begin
      ShowMessage(E.Message);
      Result := False;
    end;
  end;
end;

procedure TDM1.ppPrintPrintingComplete(Sender: TObject);
begin
  if not adsFrmMain.FieldByName('v_print').AsBoolean then
  begin
    adsFrmMain.Edit;
    adsFrmMain.FieldByName('v_print').Value := True;
    adsFrmMain.Post;
  end;
end;

function TDM1.GetXSDD(AManu_part_number, ACust_Code: string): string;
var
  LSql: string;
begin
  LSql := ' select d60.rkey,d60.SCH_DATE,d60.sales_order,d60.PARTS_ORDERED,d60.REPUT_QTY,d60.PARTS_RETURNED ' +
          ' from data0060 d60 ' +
          ' inner join data0025 d25 on d25.rkey = d60.CUST_PART_PTR ' +
          ' inner join data0010 d10 on d10.rkey = d60.CUSTOMER_PTR ' +
          ' where d60.PROD_REL <> ''1'' and d60.STATUS = 1 ' +
          ' and (isnull(d60.REPUT_QTY,0) < isnull(d60.PARTS_ORDERED,0) + isnull(d60.PARTS_RETURNED,0)) ' +
          ' and d25.manu_part_number = ' + QuotedStr(AManu_part_number) +
          ' and d10.CUST_CODE = ' + QuotedStr(ACust_Code) + 
          ' order by d60.SCH_DATE asc, d60.sales_order asc ' ;
  if SqlOpen(LSql) and not qrytmp.IsEmpty then
  begin
    Result := qrytmp.fieldbyname('sales_order').AsString;
  end else
    Result := '';
end;

function TDM1.GetUserPermit(AUserName, APassWord, AExeName: string): string;
var
  LSql: string;
  LMD5: MD5Digest;
  lMD5Pass: string;
  I: Integer;
begin
  Result := '';
  LMD5 := MD5String(APassWord);
  for I := 0 to Length(LMD5) - 1 do
  begin
    lMD5Pass := lMD5Pass + IntToHex(lmd5[I],2);
  end;
  LSql := ';with tmp as ' +
          ' (select rkey from data0419 where DESCRIPTION = ' + QuotedStr(AExeName) + ') ' +
          ' select d74.USER_RIGHTS from data0074 d74 ' +
          ' inner join data0073 d73 on d74.USER_PTR = d73.rkey ' +
          ' inner join tmp on tmp.rkey = d74.FUNCTION_ID ' +
          ' where d73.ACTIVE_FLAG = ''0''' +
          ' and d73.USER_LOGIN_NAME = ' + QuotedStr(AUserName) +
          ' and password = ' + QuotedStr(lMD5Pass);
  if SqlOpen(LSql) then
  begin
    if not qrytmp.IsEmpty then
    begin
      Result := qrytmp.fieldbyname('USER_RIGHTS').AsString;
    end;
  end;
end;

procedure TDM1.Config60REPUT_QTY(Arkey60: string);
var
  LSql: string;
begin
  LSql := 'update data0060 set REPUT_QTY = REPUT_APPR_BY ' +
        ' where rkey = ' + Arkey60;
  SqlExec(LSql);
end;

procedure TDM1.adsReportCalcFields(DataSet: TDataSet);
var
  LSql: string;
begin
  LSql := 'select top 1 cut_no,LEFT(CUT_NO,CHARINDEX(''-'',CUT_NO)-1) as cut_no_head from data0492 where SO_NO = ' +
          QuotedStr(adsReport.fieldbyname('SALES_ORDER').AsString) +
          ' order by cut_no desc' ;
  SqlOpen(LSql);
  if not qrytmp.IsEmpty then
  begin
    adsReport.FieldByName('Cut_NO').AsString := qrytmp.fieldbyname('cut_no').AsString;
    adsReport.FieldByName('cut_no_head').AsString := qrytmp.fieldbyname('cut_no_head').AsString;
  end;
end;

procedure TDM1.pdbReportNext(Sender: TObject);
var
  Img2DBar,Img2DBar_2: TppImage;
  I,J: Integer;
  LText: string;
  LCustType: TCustomType;
  ZXlblNum: Tpplabel;
begin
  ZXlblNum := nil;
  if DM1.adsFrmMain.FieldByName('ORIG_CUSTOMER').AsString <> '' then
  begin
    if DM1.SqlOpen('select cust_code from data0010 where abbr_name = ' + QuotedStr(DM1.adsFrmMain.fieldbyname('ORIG_CUSTOMER').AsString)) then
      LCustType := GetCustType(DM1.qrytmp.fieldbyname('cust_code').AsString)
    else
      LCustType := ctUnknow;
  end
  else
    LCustType := GetCustType(DM1.adsFrmMain.fieldbyname('CUST_CODE').AsString);

  if (DM1.adsFrmMain.FieldByName('type').AsString = '����') and (LCustType = ctDGHS) then
  begin
    DM1.ppPrint.ObjectByName(I,J,'ppImage1');
    if (I=0) or (J=0) then Exit;
    Img2DBar := DM1.ppPrint.Bands[I].Objects[J] as TppImage;

    try
      LText :=  Copy(DM1.adsReport.fieldbyname('ANALYSIS_CODE_2').AsString,1,Pos('+',DM1.adsReport.fieldbyname('ANALYSIS_CODE_2').AsString)-1) + ';';
      LText := LText + 'MWUZHU;';
      LText := LText + 'V' + DM1.adsReport.fieldbyname('�͹�����').AsString + ';';
      LText := LText + 'D' + DM1.adsReport.fieldbyname('����').AsString + ';';
      LText := LText + 'L' + DM1.adsReport.fieldbyname('CUT_NO_HEAD').AsString + ';';
      LText := LText + 'R' + adsReport.fieldbyname('���Ӳ���1').AsString ;

      Get2DCodeBmp(LText,Img2DBar.Picture);
    finally

    end;
  end;
  if (LCustType = ctWT) then
  begin
    DM1.ppPrint.ObjectByName(I,J,'ppImage1');
    Img2DBar := DM1.ppPrint.Bands[I].Objects[J] as TppImage;

    LText := DM1.adsReport.fieldbyname('�ͻ����Ϻ�').AsString + '|' +
                    adsReport.fieldbyname('PCS����').AsString + '|' +
                    DM1.adsReport.fieldbyname('�ͻ��ͺ�').AsString + '|' +
                    DM1.adsReport.fieldbyname('����').AsString + '|' +
                    DM1.adsReport.fieldbyname('���洦��').AsString + '|' +
                    Trim(DM1.adsReport.fieldbyname('�ͻ�������').AsString) + '|' +
                    'Wuzhu';
    DM1.Get2DCodeBmp(LText,Img2DBar.Picture);  
  end;
  if (LCustType = ctdgdell) then
  begin
    DM1.ppPrint.ObjectByName(I,J,'ppImage1');
    Img2DBar := DM1.ppPrint.Bands[I].Objects[J] as TppImage;


  LText := 'P' + DM1.adsReport.fieldbyname('�ͻ����Ϻ�').AsString + ',' +
           'Q' + pdbReport.Fields[pdbReport.FindField('PCS����')].AsString + ',' +
           'M' + DM1.adsReport.fieldbyname('M�������_2').AsString + ',' +
           'D' + DM1.adsReport.fieldbyname('����').AsString + ',' +
           'L' + DM1.adsReport.fieldbyname('���洦��').AsString + ',' +
           'S' + adsReport.fieldbyname('������').AsString;
//           'S' + pdbReport.Fields[pdbReport.FindField('������')].AsString;

    DM1.Get2DCodeBmp(LText,Img2DBar.Picture);

  end;
  if (LCustType = ctzxkx) then
  begin
    DM1.ppPrint.ObjectByName(I,J,'ppImage1');
    Img2DBar := DM1.ppPrint.Bands[I].Objects[J] as TppImage;
    LText := pdbReport.Fields[pdbReport.FindField('������')].AsString + '&&' +
            pdbReport.Fields[pdbReport.FindField('PCS����')].AsString + '&' +
            pdbReport.Fields[pdbReport.FindField('�ͻ����Ϻ�')].AsString + '&' +
            dm1.F2303SCRQ + '&' +
            pdbReport.Fields[pdbReport.FindField('����')].AsString + '&';
    DM1.Get2DCodeBmp(LText,Img2DBar.Picture);

    if (DM1.adsFrmMain.FieldByName('type').AsString = '����') then
    begin
    DM1.ppPrint.ObjectByName(I,J,'lblPCS');
    //ZXlblNum := DM1.ppPrint.Bands[I].Objects[J] as TppLabel;
    if Pos('�����', DM1.adsReport.FieldByName('��ע698').AsString) > 0 then
    begin
      //ZXlblNum.Caption := pdbReport.Fields[pdbReport.FindField('PCS����')].AsString + ' ����';
      if ZXlblNum <> nil then
      ZXlblNum.Caption := IntToStr(DM1.adsReport.fieldbyname('PCSÿSETS').Asinteger - 1)
        + 'X' + IntToStr(pdbReport.Fields[pdbReport.FindField('PCS����')].Value div (DM1.adsReport.fieldbyname('PCSÿSETS').AsInteger-1))
        + '=' + pdbReport.Fields[pdbReport.FindField('PCS����')].AsString;
    end else
    if Pos('˫���', DM1.adsReport.FieldByName('��ע698').AsString) > 0 then
    begin
      //ZXlblNum.Caption := pdbReport.Fields[pdbReport.FindField('PCS����')].AsString + ' ˫��';
      if ZXlblNum <> nil then
      ZXlblNum.Caption := IntToStr(DM1.adsReport.fieldbyname('PCSÿSETS').Asinteger - 2)
        + 'X' + IntToStr(pdbReport.Fields[pdbReport.FindField('PCS����')].Value div (DM1.adsReport.fieldbyname('PCSÿSETS').AsInteger-2))
        + '=' + pdbReport.Fields[pdbReport.FindField('PCS����')].AsString;

    end else
    if ZXlblNum <> nil then 
      ZXlblNum.Caption := IntToStr(DM1.adsReport.fieldbyname('PCSÿSETS').Asinteger)
        + 'X' + IntToStr(pdbReport.Fields[pdbReport.FindField('PCS����')].Value div (DM1.adsReport.fieldbyname('PCSÿSETS').AsInteger))
        + '=' + pdbReport.Fields[pdbReport.FindField('PCS����')].AsString;
    end
  end;


  if (LCustType = ctHWZD) then
  begin
    DM1.ppPrint.ObjectByName(I,J,'ppImage1');
    Img2DBar := DM1.ppPrint.Bands[I].Objects[J] as TppImage;

  LText := '[)>' + Char(30) + '06' + //' ' +
            'P' + DM1.adsReport.fieldbyname('�ͻ��ͺ�').AsString +// ' ' +
           '1P' + DM1.adsReport.fieldbyname('�������').AsString + //' ' +
           'Q' + pdbReport.Fields[pdbReport.FindField('PCS����')].AsString + //' ' +
           'V' + DM1.adsReport.fieldbyname('�͹�����').AsString + //' ' +
           '1T' + pdbReport.Fields[pdbReport.FindField('���')].AsString + //' ' +
           '9D' + pdbReport.Fields[pdbReport.FindField('����')].AsString + //' ' +
           '25B'+ pdbReport.Fields[pdbReport.FindField('xBrode')].AsString + //' ' +
           'PSN'+ pdbReport.Fields[pdbReport.FindField('Psn')].AsString + //' ' +
           'MWuZhu' + //' ' +
           '4LChina' ;//+ ' ';

//    LText := 'P' + DM1.adsReport.fieldbyname('�ͻ��ͺ�').AsString + ' ' +
//             '1P' + DM1.adsReport.fieldbyname('�������').AsString + ' ' +
//             'Q' + pdbReport.Fields[pdbReport.FindField('PCS����')].AsString + ' ' +
//             'V' + DM1.adsReport.fieldbyname('�͹�����').AsString + ' ' +
//             '1T' + pdbReport.Fields[pdbReport.FindField('���')].AsString + ' ' +
//             '9D' + pdbReport.Fields[pdbReport.FindField('����')].AsString + ' ' +
//             'MWuZhu' + ' ' +
//             '4LChina' + ' ' +
//             //'1D' + pdbReport.Fields[pdbReport.FindField('����')].AsString + ' ' +
//             //'1Q' + pdbReport.Fields[pdbReport.FindField('PCS����')].AsString + ' ' +
//             'K' + DM1.adsReport.fieldbyname('�ͻ�������').AsString;
    DM1.Get2DCodeBmp(LText,Img2DBar.Picture);
    if (DM1.adsFrmMain.FieldByName('type').AsString = '����') then
    begin
      DM1.ppPrint.ObjectByName(I,J,'ppImage2');
      Img2DBar_2 := DM1.ppPrint.Bands[I].Objects[J] as TppImage;
      LText :=  '1D' + pdbReport.Fields[pdbReport.FindField('����')].AsString + ' ' +
                '1Q' + pdbReport.Fields[pdbReport.FindField('PCS����')].AsString;
      DM1.Get2DCodeBmp(LText,Img2DBar_2.Picture,2);
    end;
  end;

  DM1.adsReport.Next;
end;

procedure TDM1.Get2DCodeBmp(AText: string;APic: TPicture;ASize: Integer);
var
  LCode2d: TQRCodeGraphic;
  LbtMap: TGraphic;
begin
  LCode2d := TQRCodeGraphic.Create();
  try
    LCode2d.Margin := 3;
    LCode2d.BlockSize := ASize;
    LCode2d.Text := AText;
    APic.Assign(LCode2d);
  finally
    LCode2d.Free;
  end;
end;

procedure TDM1.cdsReportCalcFields(DataSet: TDataSet);
begin
    DM1.cdsReport.fieldbyname('1P�������').AsString := '1P' + DM1.cdsReport.fieldbyname('�������').AsString;
    DM1.cdsReport.fieldbyname('V�͹�����').AsString := 'V' + DM1.cdsReport.fieldbyname('�͹�����').AsString;
    DM1.cdsReport.FieldByName('1TLotNo').AsString := '1T' + DM1.cdsReport.fieldbyname('���').AsString;
    DM1.cdsReport.FieldByName('9D����').AsString := '9D' + DM1.cdsReport.fieldbyname('����').AsString;
    DM1.cdsReport.FieldByName('P�ͻ��ͺ�').AsString := 'P' + DM1.cdsReport.fieldbyname('�ͻ��ͺ�').AsString;
end;

end.
