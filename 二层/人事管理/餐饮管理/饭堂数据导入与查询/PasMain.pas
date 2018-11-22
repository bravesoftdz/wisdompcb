unit PasMain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, Grids, DBGridEh,ADODB, ComCtrls;

type
  TfrmMain = class(TForm)
    Panel1: TPanel;
    btnClose: TBitBtn;
    btnImport: TBitBtn;
    btnExport: TBitBtn;
    Panel2: TPanel;
    lbFilter: TLabel;
    edtFilter: TEdit;
    dbMain: TDBGridEh;
    Panel3: TPanel;
    rgQuery: TRadioGroup;
    Label1: TLabel;
    Label2: TLabel;
    dtpkStart: TDateTimePicker;
    dtpkEnd: TDateTimePicker;
    btnQuery: TBitBtn;
    Label3: TLabel;
    lblCount: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure btnCloseClick(Sender: TObject);
    procedure btnImportClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnExportClick(Sender: TObject);
    procedure btnQueryClick(Sender: TObject);
    procedure edtFilterChange(Sender: TObject);
    procedure dbMainTitleClick(Column: TColumnEh);
    procedure dbMainKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    FBDrop:Boolean;
    preColumn:TColumnEh;
    function ExecSql(AQry:TADOQuery;ASql:string):Boolean;
    function CheckOperatorLock:Boolean;
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation

uses PasDM,common,ComObj,MyClass, PasImport,DB,DateUtils;


{$R *.dfm}
function TfrmMain.CheckOperatorLock: Boolean;
var
  table_name: string;
begin
  Result := True;
  table_name := '##WZ_ICCardImport';
   try
     DM.adoTmp.Close;
     DM.adoTmp.SQL.Clear;
     DM.adoTmp.SQL.Text:='if exists(SELECT 1 FROM tempdb.dbo.sysobjects WHERE NAME='+quotedstr(table_name)+')'+#13+
     ' select data0073.USER_FULL_NAME from '+table_name+' inner join data0073 on'+#13+
     table_name+'.rkey73=data0073.rkey'+#13+
     ' else select data0073.USER_FULL_NAME from data0073 WHERE data0073.RKey = -1 ';
     dm.adoTmp.Open;
     if DM.adoTmp.IsEmpty then
     begin
       dm.adoTmp.Close;
       dm.adoTmp.SQL.Clear;
       dm.adoTmp.SQL.Add('select '+ rkey73 +' as rkey73 into '+table_name);
       if dm.adoTmp.ExecSQL <= 0 then
       begin
         ShowMessage('����ʧ��!');
         FBDrop := False;
         Exit;
       end
       else
       begin
        FBDrop := True;
        Result := False;
       end;
       dm.adoTmp.Close;
     end
     else
     begin
       ShowMessage('�����Ѿ�������' + dm.adoTmp.fieldByName('USER_FULL_NAME').AsString +' ���ڽ��вɼ����������');
       FBDrop := False;
       Exit;
     end;
   except
    showmessage('�����쳣!');
    FBDrop := False;
    Exit;
   end;
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  if not App_init_2(DM.ADOConn) then
  begin
    ShowMessage('��������ʧ�ܣ�����ϵ����Ա');
    Application.Terminate;
  end;
  frmMain.Caption:=Application.Title;

//  rkey73:='3022';
//  vprev:='4' ;
end;

procedure TfrmMain.btnCloseClick(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TfrmMain.btnImportClick(Sender: TObject);
var
  LFileDialog:TOpenDialog;
  LSheet:Variant;
  LFileName,LSql,LConnStr:string;
  i,j:Integer;
  table_name: string;
begin
  if not (vprev='4') then
  begin
    ShowMessage('��û��Ȩ�޵��룡');
    exit;
  end;
  if  CheckOperatorLock then Exit;

  frmImport:=TfrmImport.Create(Application);
  try
    frmImport.ShowModal;
    if FBDrop then
    begin
      table_name := '##WZ_ICCardImport';
      DM.adoTmp.Close;
      DM.adoTmp.SQL.Clear;
      dm.adoTmp.SQL.Text:='if exists(SELECT 1 FROM tempdb.dbo.sysobjects WHERE NAME='+quotedstr(table_name)+')'+#13+
      ' drop table '+table_name;
      dm.adoTmp.ExecSQL;
    end;
  finally
    frmImport.Free;
  end;
end;

function TfrmMain.ExecSql(AQry: TADOQuery; ASql: string): Boolean;
begin
  Result:=True;
  AQry.Close;
  AQry.SQL.Text:=ASql;
  try
    AQry.ExecSQL;
  except
    Result:=False;
  end;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  dtpkStart.Date:= getsystem_date(DM.adoTmp,1);
  dtpkEnd.Date:=dtpkStart.Date;
end;

procedure TfrmMain.btnExportClick(Sender: TObject);
begin
  if not DM.adsMain.IsEmpty then
      Export_dbGridEH_to_Excel(dbMain,'�Ͳ���Ϣ') ;
end;

procedure TfrmMain.btnQueryClick(Sender: TObject);
var
   sdaystr,edaystr,empno:string;
   i:Integer;
begin
  if rgQuery.ItemIndex=-1 then
  begin
    ShowMessage('��ѡ���ѯ����');
    exit;
  end;
  sdaystr:=FormatDateTime('yyyy-MM-dd',dtpkStart.Date);
  edaystr:=FormatDateTime('yyyy-MM-dd',dtpkEnd.Date);        //ҹ�����ڵڶ����賿

//  sdaystr:=FormatDateTime('yyyy-MM-dd',dtpkStart.Date);
//  edaystr:=FormatDateTime('yyyy-MM-dd',dtpkEnd.Date);


  if Trim(edtFilter.Text) <> '' then empno := ' AND dbo.v_empandextra.employeecode = ' + QuotedStr(Trim(edtFilter.Text))
  else empno := '';
  DM.adsMain.Close;
  case rgQuery.ItemIndex of
    0:DM.adsMain.CommandText:=' SELECT  dbo.v_empandextra.employeecode AS ����, dbo.v_empandextra.chinesename AS ����, dbo.v_empandextra.departmentname AS ����  '+#13+
          '  ,dbo.v_empandextra.ranks as ְ��, dbo.meal_orginaldata.card_time AS ��ʱ��,dbo.meal_orginaldata.dev_id AS ����, dbo.meal_orginaldata.payed AS ���  '+#13+
          '  , CASE dbo.meal_orginaldata.company WHEN 1 THEN ''�ĺ�����'' WHEN 2 THEN ''���극��'' '+#13+
          '    WHEN 3 THEN ''�ͼ�С��'' END AS ����  '+#13+
          '  , CASE dbo.meal_orginaldata.meal_type WHEN 1 THEN ''���'' WHEN 2 THEN ''���'' '+#13+
          '    WHEN 3 THEN ''���'' WHEN 4 THEN ''ҹ��'' END AS �ͱ�  '+#13+
          '  , CASE dbo.meal_orginaldata.account_type WHEN 0 THEN ''����'' WHEN 1 THEN ''�ֽ�'' END AS �ʻ� '+#13+
          '  , dbo.v_empandextra.factorytype AS ��������,dbo.v_empandextra.status AS Ա��״̬,dbo.meal_orginaldata.dev_mark AS ˢ������  '+#13+
       ' FROM         dbo.meal_orginaldata INNER JOIN  '+#13+
       '                       dbo.v_empandextra ON dbo.meal_orginaldata.empid = dbo.v_empandextra.rkey and v_empandextra.factorytype = meal_orginaldata.factorytype '+#13+
       ' WHERE    date_e between '+ QuotedStr(sdaystr) +'  and '+ QuotedStr(edaystr) +
       '        AND (dbo.meal_orginaldata.account_type = 0) ' + empno +#13+
       ' ORDER BY dbo.v_empandextra.employeecode,dbo.meal_orginaldata.card_time ';

    1:DM.adsMain.CommandText:=' SELECT   dbo.v_empandextra.employeecode AS ����, dbo.meal_orginaldata.date_e AS ����   '+#13+
                           '       , dbo.v_empandextra.chinesename AS ����, dbo.v_empandextra.departmentname AS ����,dbo.v_empandextra.ranks AS ְ��  '+#13+
                           '       , ISNULL(SUM(CASE WHEN dbo.meal_orginaldata.meal_type=1 THEN dbo.meal_orginaldata.payed END),0) AS ���    '+#13+
                           '       , ISNULL(SUM(CASE WHEN dbo.meal_orginaldata.meal_type=2 THEN dbo.meal_orginaldata.payed END),0) AS ���    '+#13+
                           '       , ISNULL(SUM(CASE WHEN dbo.meal_orginaldata.meal_type=3 THEN dbo.meal_orginaldata.payed END),0) AS ���    '+#13+
                           '       , ISNULL(SUM(CASE WHEN dbo.meal_orginaldata.meal_type=4 THEN dbo.meal_orginaldata.payed END),0) AS ҹ��     '+#13+
                           '       , ISNULL(SUM(dbo.meal_orginaldata.payed),0) AS �ܽ��    '+#13+
                           '       , isnull(SUM(dbo.meal_orginaldata.spayed),0) AS ''�ܽ��(����)''   '+#13+
                           '       , isnull(SUM(dbo.meal_orginaldata.ppayed),0) as ''�ܽ��(����)''  '+#13+
                           '  , dbo.v_empandextra.factorytype AS ��������,dbo.v_empandextra.status AS Ա��״̬  '+#13+
                           '   FROM         dbo.meal_orginaldata INNER JOIN   '+#13+
                           '                       dbo.v_empandextra ON dbo.meal_orginaldata.empid = dbo.v_empandextra.rkey and v_empandextra.factorytype = meal_orginaldata.factorytype '+#13+
                           '   WHERE    date_e between '+ QuotedStr(sdaystr) +' and '+ QuotedStr(edaystr)   +#13+
                           '        AND (dbo.meal_orginaldata.account_type = 0) ' + empno +#13+
                           '   GROUP BY dbo.v_empandextra.employeecode,dbo.v_empandextra.chinesename,dbo.v_empandextra.ranks,  '+#13+
                           '         dbo.v_empandextra.departmentname,dbo.meal_orginaldata.date_e, dbo.v_empandextra.factorytype,dbo.v_empandextra.status ';

    2:DM.adsMain.CommandText:=' SELECT     dbo.v_empandextra.employeecode AS ����, dbo.v_empandextra.chinesename AS ����, dbo.v_empandextra.departmentname AS ����   '+#13+
                           '         , ISNULL(SUM(CASE WHEN dbo.meal_orginaldata.meal_type=1 THEN dbo.meal_orginaldata.payed END),0) AS ���    '+#13+
                           '         , ISNULL(SUM(CASE WHEN (dbo.meal_orginaldata.meal_type=1) THEN dbo.meal_orginaldata.spayed END),0) AS ''���(����)''    '+#13+
                           '         , ISNULL(SUM(CASE WHEN (dbo.meal_orginaldata.meal_type=1) THEN dbo.meal_orginaldata.ppayed END),0) AS ''���(�ֽ�)''    '+#13+
                           '         , ISNULL(SUM(CASE WHEN dbo.meal_orginaldata.meal_type=2 THEN dbo.meal_orginaldata.payed END),0) AS ���   '+#13+
                           '         , ISNULL(SUM(CASE WHEN (dbo.meal_orginaldata.meal_type=2) THEN dbo.meal_orginaldata.spayed END),0) AS ''���(����)''    '+#13+
                           '         , ISNULL(SUM(CASE WHEN (dbo.meal_orginaldata.meal_type=2) THEN dbo.meal_orginaldata.ppayed END),0) AS ''���(�ֽ�)''     '+#13+
                           '         , ISNULL(SUM(CASE WHEN dbo.meal_orginaldata.meal_type=3 THEN dbo.meal_orginaldata.payed END),0) AS ���     '+#13+
                           '         , ISNULL(SUM(CASE WHEN (dbo.meal_orginaldata.meal_type=3) THEN dbo.meal_orginaldata.spayed END),0) AS ''���(����)''     '+#13+
                           '         , ISNULL(SUM(CASE WHEN (dbo.meal_orginaldata.meal_type=3) THEN dbo.meal_orginaldata.ppayed END),0) AS ''���(�ֽ�)''    '+#13+
                           '         , ISNULL(SUM(CASE WHEN dbo.meal_orginaldata.meal_type=4 THEN dbo.meal_orginaldata.payed END),0) AS ҹ��       '+#13+
                           '         , ISNULL(SUM(CASE WHEN (dbo.meal_orginaldata.meal_type=4) THEN dbo.meal_orginaldata.spayed END),0) AS ''ҹ��(����)''     '+#13+
                           '         , ISNULL(SUM(CASE WHEN (dbo.meal_orginaldata.meal_type=4) THEN dbo.meal_orginaldata.ppayed END),0) AS ''ҹ��(�ֽ�)''    '+#13+
                           '         , ISNULL(SUM(dbo.meal_orginaldata.payed),0) AS �ܽ��       '+#13+
                           '         , ISNULL(SUM(dbo.meal_orginaldata.spayed),0) AS ''�ܽ��(����)''      '+#13+
                           '         , ISNULL(SUM(dbo.meal_orginaldata.ppayed),0) AS ''�ܽ��(�ֽ�)''     '+#13+
                           '  , dbo.v_empandextra.factorytype AS ��������,dbo.v_empandextra.status AS Ա��״̬,dbo.v_empandextra.ranks AS ְ��  '+#13+
                           '   FROM         dbo.meal_orginaldata INNER JOIN     '+#13+
                           '                       dbo.v_empandextra ON dbo.meal_orginaldata.empid = dbo.v_empandextra.rkey and v_empandextra.factorytype = meal_orginaldata.factorytype'+#13+
                           '   WHERE   date_e between '+ QuotedStr(sdaystr) +' and '+ QuotedStr(edaystr)     +#13+
                           '        AND (dbo.meal_orginaldata.account_type = 0) ' + empno +#13+
                           '   GROUP BY dbo.v_empandextra.employeecode,dbo.v_empandextra.chinesename,dbo.v_empandextra.ranks  '+#13+
                           '         ,dbo.v_empandextra.departmentname, dbo.v_empandextra.factorytype,dbo.v_empandextra.status ';

    3:DM.adsMain.CommandText:=' SELECT CASE company WHEN 1 THEN ''�ĺ�����'' WHEN 2 THEN ''���극��''    '+#13+
                           '         WHEN 3 THEN ''�ͼ�С��'' END AS ����    '+#13+
                           '       ,ISNULL(SUM(CASE WHEN MEAL_TYPE=1 THEN payed  END),0) AS ''���''     '+#13+
                           '       ,ISNULL(SUM(CASE WHEN MEAL_TYPE=2 THEN payed  END),0) AS ''�в�''     '+#13+
                           '       ,ISNULL(SUM(CASE WHEN MEAL_TYPE=3 THEN payed  END),0) AS ''���''      '+#13+
                           '       ,ISNULL(SUM(CASE WHEN MEAL_TYPE=4 THEN payed  END),0) AS ''ҹ��''     '+#13+
                           '   FROM (SELECT EMPNO,MEAL_TYPE,COMPANY,CARD_TIME,payed     '+#13+
                           '       FROM meal_orginaldata     '+#13+
                           '       WHERE dbo.meal_orginaldata.dev_id = 55 and  dbo.meal_orginaldata.company = 2  '+#13+                           '        AND (dbo.meal_orginaldata.account_type = 0) ' +#13+                           '       AND date_e between '+ QuotedStr(sdaystr) +' and '+ QuotedStr(edaystr) +') AS MEAL' +#13+                           '   GROUP BY COMPANY  ';

    4:DM.adsMain.CommandText:=' SELECT CASE company WHEN 1 THEN ''�ĺ�����'' WHEN 2 THEN ''���극��''    '+#13+
                       '         WHEN 3 THEN ''�ͼ�С��'' END AS ����    '+#13+
                       '       ,ISNULL(SUM(CASE WHEN MEAL_TYPE=1 THEN payed  END),0) AS ''���''     '+#13+
                       '       ,ISNULL(SUM(CASE WHEN MEAL_TYPE=2 THEN payed  END),0) AS ''�в�''     '+#13+
                       '       ,ISNULL(SUM(CASE WHEN MEAL_TYPE=3 THEN payed  END),0) AS ''���''      '+#13+
                       '       ,ISNULL(SUM(CASE WHEN MEAL_TYPE=4 THEN payed  END),0) AS ''ҹ��''     '+#13+
                       '   FROM (SELECT  EMPNO,MEAL_TYPE,COMPANY,CARD_TIME,payed      '+#13+
                       '       FROM meal_orginaldata     '+#13+
                       '       WHERE dbo.meal_orginaldata.dev_id <> 55  '+#13+                       '        AND (dbo.meal_orginaldata.account_type = 0) and ' +#13+                       '       date_e between '+ QuotedStr(sdaystr) +' and '+ QuotedStr(edaystr) +') AS MEAL' +#13+                       '   GROUP BY COMPANY  ';

    5:DM.adsMain.CommandText:=' SELECT CASE company WHEN 1 THEN ''�ĺ�����'' WHEN 2 THEN ''���극��''    '+#13+
                       '         WHEN 3 THEN ''�ͼ�С��'' END AS ����    '+#13+
                       '       ,ISNULL(SUM(CASE WHEN MEAL_TYPE=1 THEN payed  END),0) AS ''���''     '+#13+
                       '       ,ISNULL(SUM(CASE WHEN MEAL_TYPE=2 THEN payed  END),0) AS ''�в�''     '+#13+
                       '       ,ISNULL(SUM(CASE WHEN MEAL_TYPE=3 THEN payed  END),0) AS ''���''      '+#13+
                       '       ,ISNULL(SUM(CASE WHEN MEAL_TYPE=4 THEN payed  END),0) AS ''ҹ��''     '+#13+
                       '   FROM (SELECT  EMPNO,MEAL_TYPE,COMPANY,CARD_TIME,payed      '+#13+
                       '       FROM meal_orginaldata     '+#13+
                       '       WHERE  (dbo.meal_orginaldata.account_type = 0) and ' +#13+                       '       date_e between '+ QuotedStr(sdaystr) +' and '+ QuotedStr(edaystr) +') AS MEAL' +#13+                       '   GROUP BY COMPANY  ';

    6:DM.adsMain.CommandText:=' SELECT     dbo.v_empandextra.departmentname AS ����    '+#13+
                           '       , ISNULL(SUM(CASE WHEN dbo.meal_orginaldata.meal_type=1 THEN dbo.meal_orginaldata.payed END),0) AS ���    '+#13+
                           '       , ISNULL(SUM(CASE WHEN (dbo.meal_orginaldata.meal_type=1) THEN dbo.meal_orginaldata.spayed END),0) AS ''���(����)''    '+#13+
                           '       , ISNULL(SUM(CASE WHEN (dbo.meal_orginaldata.meal_type=1) THEN dbo.meal_orginaldata.ppayed END),0) AS ''���(�ֽ�)''    '+#13+
                           '       , ISNULL(SUM(CASE WHEN dbo.meal_orginaldata.meal_type=2 THEN dbo.meal_orginaldata.payed END),0) AS ���   '+#13+
                           '       , ISNULL(SUM(CASE WHEN (dbo.meal_orginaldata.meal_type=2) THEN dbo.meal_orginaldata.spayed END),0) AS ''���(����)''  '+#13+
                           '       , ISNULL(SUM(CASE WHEN (dbo.meal_orginaldata.meal_type=2) THEN dbo.meal_orginaldata.ppayed END),0) AS ''���(�ֽ�)''   '+#13+
                           '       , ISNULL(SUM(CASE WHEN dbo.meal_orginaldata.meal_type=3 THEN dbo.meal_orginaldata.payed END),0) AS ���   '+#13+
                           '       , ISNULL(SUM(CASE WHEN (dbo.meal_orginaldata.meal_type=3) THEN dbo.meal_orginaldata.spayed END),0) AS ''���(����)''   '+#13+
                           '       , ISNULL(SUM(CASE WHEN (dbo.meal_orginaldata.meal_type=3) THEN dbo.meal_orginaldata.ppayed END),0) AS ''���(�ֽ�)''  '+#13+
                           '       , ISNULL(SUM(CASE WHEN dbo.meal_orginaldata.meal_type=4 THEN dbo.meal_orginaldata.payed END),0) AS ҹ��    '+#13+
                           '       , ISNULL(SUM(CASE WHEN (dbo.meal_orginaldata.meal_type=4) THEN dbo.meal_orginaldata.spayed END),0) AS ''ҹ��(����)''    '+#13+
                           '       , ISNULL(SUM(CASE WHEN (dbo.meal_orginaldata.meal_type=4) THEN dbo.meal_orginaldata.ppayed END),0) AS ''ҹ��(�ֽ�)''    '+#13+
                           '       , ISNULL(SUM(dbo.meal_orginaldata.payed),0) AS �ܽ��   '+#13+
                           '       , ISNULL(SUM(dbo.meal_orginaldata.spayed),0) AS ''�ܽ��(����)''    '+#13+
                           '       , ISNULL(SUM(dbo.meal_orginaldata.ppayed),0) AS ''�ܽ��(�ֽ�)''   '+#13+
                           ' FROM         dbo.meal_orginaldata INNER JOIN      '+#13+
                           '                       dbo.v_empandextra ON dbo.meal_orginaldata.empid = dbo.v_empandextra.rkey and  v_empandextra.factorytype = meal_orginaldata.factorytype'+#13+
                           ' WHERE     date_e between '+ QuotedStr(sdaystr) +' and '+ QuotedStr(edaystr)   +#13+
                           '        AND (dbo.meal_orginaldata.account_type = 0) ' +#13+
                           ' GROUP BY dbo.v_empandextra.departmentname   ';

    7:DM.adsMain.CommandText:= 'SELECT    CASE dbo.meal_orginaldata.company WHEN 1 THEN ''�ĺ�����'' WHEN 2 THEN ''���극��''    '+#13+
		                           '	WHEN 3 THEN ''�ͼ�С��'' END AS ����        '+#13+
                               '       , ISNULL(SUM(CASE WHEN dbo.meal_orginaldata.meal_type=1 THEN dbo.meal_orginaldata.payed END),0) AS ���  '+#13+
                               '       , ISNULL(SUM(CASE WHEN (dbo.meal_orginaldata.meal_type=1) THEN dbo.meal_orginaldata.spayed END),0) AS ''���(����)'' '+#13+
                               '       , ISNULL(SUM(CASE WHEN (dbo.meal_orginaldata.meal_type=1) THEN dbo.meal_orginaldata.ppayed END),0) AS ''���(�ֽ�)''  '+#13+
                               '       , ISNULL(SUM(CASE WHEN dbo.meal_orginaldata.meal_type=2 THEN dbo.meal_orginaldata.payed END),0) AS ���    '+#13+
                               '       , ISNULL(SUM(CASE WHEN (dbo.meal_orginaldata.meal_type=2) THEN dbo.meal_orginaldata.spayed END),0) AS ''���(����)''   '+#13+
                               '       , ISNULL(SUM(CASE WHEN (dbo.meal_orginaldata.meal_type=2) THEN dbo.meal_orginaldata.ppayed END),0) AS ''���(�ֽ�)''   '+#13+
                               '       , ISNULL(SUM(CASE WHEN dbo.meal_orginaldata.meal_type=3 THEN dbo.meal_orginaldata.payed END),0) AS ���   '+#13+
                               '       , ISNULL(SUM(CASE WHEN (dbo.meal_orginaldata.meal_type=3) THEN dbo.meal_orginaldata.spayed END),0) AS ''���(����)''  '+#13+
                               '       , ISNULL(SUM(CASE WHEN (dbo.meal_orginaldata.meal_type=3) THEN dbo.meal_orginaldata.ppayed END),0) AS ''���(�ֽ�)''  '+#13+
                               '       , ISNULL(SUM(CASE WHEN dbo.meal_orginaldata.meal_type=4 THEN dbo.meal_orginaldata.payed END),0) AS ҹ��  '+#13+
                               '       , ISNULL(SUM(CASE WHEN (dbo.meal_orginaldata.meal_type=4) THEN dbo.meal_orginaldata.spayed END),0) AS ''ҹ��(����)''  '+#13+
                               '       , ISNULL(SUM(CASE WHEN (dbo.meal_orginaldata.meal_type=4) THEN dbo.meal_orginaldata.ppayed END),0) AS ''ҹ��(�ֽ�)''  '+#13+
                               '       , ISNULL(SUM(dbo.meal_orginaldata.payed),0) AS �ܽ��   '+#13+
                               '       , ISNULL(SUM(dbo.meal_orginaldata.spayed),0) AS ''�ܽ��(����)''  '+#13+
                               '       , ISNULL(SUM(dbo.meal_orginaldata.ppayed),0) AS ''�ܽ��(�ֽ�)''  '+#13+
                               '       , ISNULL(SUM(CASE WHEN meal_orginaldata.factorytype =''extra'' THEN dbo.meal_orginaldata.payed END),0) as ''�ܽ��(��Э)''    '+#13+
                               '       , ISNULL(SUM(CASE WHEN meal_orginaldata.factorytype =''local'' THEN dbo.meal_orginaldata.payed END),0) as ''�ܽ��(����Э)''   '+#13+
                               ' FROM         dbo.meal_orginaldata    '+#13+
                               ' WHERE  date_e between '+ QuotedStr(sdaystr) +' and '+ QuotedStr(edaystr)  +#13+
                               '        AND (dbo.meal_orginaldata.account_type = 0) ' +#13+
                               ' GROUP BY dbo.meal_orginaldata.company';

    8:DM.adsMain.CommandText:= 'SELECT    CASE dbo.meal_orginaldata.company WHEN 1 THEN ''�ĺ�����'' WHEN 2 THEN ''���극��''    '+#13+
                           '	WHEN 3 THEN ''�ͼ�С��'' END AS ����        '+#13+
                           '       , ISNULL(SUM(CASE WHEN dbo.meal_orginaldata.meal_type=1 THEN dbo.meal_orginaldata.payed END),0) AS ���  '+#13+
                           '       , ISNULL(SUM(CASE WHEN (dbo.meal_orginaldata.meal_type=1) THEN dbo.meal_orginaldata.spayed END),0) AS ''���(����)'' '+#13+
                           '       , ISNULL(SUM(CASE WHEN (dbo.meal_orginaldata.meal_type=1) THEN dbo.meal_orginaldata.ppayed END),0) AS ''���(�ֽ�)''  '+#13+
                           '       , ISNULL(SUM(CASE WHEN dbo.meal_orginaldata.meal_type=2 THEN dbo.meal_orginaldata.payed END),0) AS ���    '+#13+
                           '       , ISNULL(SUM(CASE WHEN (dbo.meal_orginaldata.meal_type=2) THEN dbo.meal_orginaldata.spayed END),0) AS ''���(����)''   '+#13+
                           '       , ISNULL(SUM(CASE WHEN (dbo.meal_orginaldata.meal_type=2) THEN dbo.meal_orginaldata.ppayed END),0) AS ''���(�ֽ�)''   '+#13+
                           '       , ISNULL(SUM(CASE WHEN dbo.meal_orginaldata.meal_type=3 THEN dbo.meal_orginaldata.payed END),0) AS ���   '+#13+
                           '       , ISNULL(SUM(CASE WHEN (dbo.meal_orginaldata.meal_type=3) THEN dbo.meal_orginaldata.spayed END),0) AS ''���(����)''  '+#13+
                           '       , ISNULL(SUM(CASE WHEN (dbo.meal_orginaldata.meal_type=3)  THEN dbo.meal_orginaldata.ppayed END),0) AS ''���(�ֽ�)''  '+#13+
                           '       , ISNULL(SUM(CASE WHEN dbo.meal_orginaldata.meal_type=4 THEN dbo.meal_orginaldata.payed END),0) AS ҹ��  '+#13+
                           '       , ISNULL(SUM(CASE WHEN (dbo.meal_orginaldata.meal_type=4) THEN dbo.meal_orginaldata.spayed END),0) AS ''ҹ��(����)''  '+#13+
                           '       , ISNULL(SUM(CASE WHEN (dbo.meal_orginaldata.meal_type=4) THEN dbo.meal_orginaldata.ppayed END),0) AS ''ҹ��(�ֽ�)''  '+#13+
                           '       , ISNULL(SUM(dbo.meal_orginaldata.payed),0) AS �ܽ��   '+#13+
                           '       , ISNULL(SUM(dbo.meal_orginaldata.spayed),0) AS ''�ܽ��(����)''  '+#13+
                           '       , ISNULL(SUM(dbo.meal_orginaldata.ppayed),0) AS ''�ܽ��(�ֽ�)''  '+#13+
                           '       , ISNULL(SUM(CASE WHEN meal_orginaldata.factorytype =''extra'' THEN dbo.meal_orginaldata.payed END),0) as ''�ܽ��(��Э)''    '+#13+
                           '       , ISNULL(SUM(CASE WHEN meal_orginaldata.factorytype =''local'' THEN dbo.meal_orginaldata.payed END),0) as ''�ܽ��(����Э)''   '+#13+
                           ' FROM         dbo.meal_orginaldata    '+#13+
                           ' WHERE   (dbo.meal_orginaldata.remark2 is null ) and  date_e between '+ QuotedStr(sdaystr) +' and '+ QuotedStr(edaystr)  +#13+
                           '        AND (dbo.meal_orginaldata.account_type = 0) ' +#13+
                           ' GROUP BY dbo.meal_orginaldata.company';
    9:DM.adsMain.CommandText:= 'SELECT    CASE dbo.meal_orginaldata.company WHEN 1 THEN ''�ĺ�����'' WHEN 2 THEN ''���극��''    '+#13+
                           '	WHEN 3 THEN ''�ͼ�С��'' END AS ����        '+#13+
                           '       , ISNULL(SUM(CASE WHEN dbo.meal_orginaldata.meal_type=1 THEN dbo.meal_orginaldata.payed END),0) AS ���  '+#13+
                           '       , ISNULL(SUM(CASE WHEN (dbo.meal_orginaldata.meal_type=1) THEN dbo.meal_orginaldata.spayed END),0) AS ''���(����)'' '+#13+
                           '       , ISNULL(SUM(CASE WHEN (dbo.meal_orginaldata.meal_type=1) THEN dbo.meal_orginaldata.ppayed END),0) AS ''���(�ֽ�)''  '+#13+
                           '       , ISNULL(SUM(CASE WHEN dbo.meal_orginaldata.meal_type=2 THEN dbo.meal_orginaldata.payed END),0) AS ���    '+#13+
                           '       , ISNULL(SUM(CASE WHEN (dbo.meal_orginaldata.meal_type=2) THEN dbo.meal_orginaldata.spayed END),0) AS ''���(����)''   '+#13+
                           '       , ISNULL(SUM(CASE WHEN (dbo.meal_orginaldata.meal_type=2) THEN dbo.meal_orginaldata.ppayed END),0) AS ''���(�ֽ�)''   '+#13+
                           '       , ISNULL(SUM(CASE WHEN dbo.meal_orginaldata.meal_type=3 THEN dbo.meal_orginaldata.payed END),0) AS ���   '+#13+
                           '       , ISNULL(SUM(CASE WHEN (dbo.meal_orginaldata.meal_type=3) THEN dbo.meal_orginaldata.spayed END),0) AS ''���(����)''  '+#13+
                           '       , ISNULL(SUM(CASE WHEN (dbo.meal_orginaldata.meal_type=3) THEN dbo.meal_orginaldata.ppayed END),0) AS ''���(�ֽ�)''  '+#13+
                           '       , ISNULL(SUM(CASE WHEN dbo.meal_orginaldata.meal_type=4 THEN dbo.meal_orginaldata.payed END),0) AS ҹ��  '+#13+
                           '       , ISNULL(SUM(CASE WHEN (dbo.meal_orginaldata.meal_type=4) THEN dbo.meal_orginaldata.spayed END),0) AS ''ҹ��(����)''  '+#13+
                           '       , ISNULL(SUM(CASE WHEN (dbo.meal_orginaldata.meal_type=4) THEN dbo.meal_orginaldata.ppayed END),0) AS ''ҹ��(�ֽ�)''  '+#13+
                           '       , ISNULL(SUM(dbo.meal_orginaldata.payed),0) AS �ܽ��   '+#13+
                           '       , ISNULL(SUM(dbo.meal_orginaldata.spayed),0) AS ''�ܽ��(����)''  '+#13+
                           '       , ISNULL(SUM(dbo.meal_orginaldata.ppayed),0) AS ''�ܽ��(�ֽ�)''  '+#13+
                           '       , ISNULL(SUM(CASE WHEN meal_orginaldata.factorytype =''extra'' THEN dbo.meal_orginaldata.payed END),0) as ''�ܽ��(��Э)''    '+#13+
                           '       , ISNULL(SUM(CASE WHEN meal_orginaldata.factorytype =''local'' THEN dbo.meal_orginaldata.payed END),0) as ''�ܽ��(����Э)''   '+#13+
                           ' FROM         dbo.meal_orginaldata    '+#13+
                           ' WHERE   (dbo.meal_orginaldata.remark2 is not null ) and   date_e between '+ QuotedStr(sdaystr) +' and '+ QuotedStr(edaystr)  +#13+
                           '        AND (dbo.meal_orginaldata.account_type = 0) ' +#13+
                           ' GROUP BY dbo.meal_orginaldata.company';

    10:DM.adsMain.CommandText:=' SELECT    dbo.meal_orginaldata.date_e AS ����, dbo.v_empandextra.employeecode AS ����  '+#13+
                           '       , dbo.v_empandextra.chinesename AS ����, dbo.v_empandextra.departmentname AS ����,dbo.v_empandextra.ranks as ְ��  '+#13+
                           '      ,meal_orginaldata.date_e AS �Ͳ�����    '+#13+
                           '       , ISNULL(SUM(CASE WHEN dbo.meal_orginaldata.meal_type=1 THEN dbo.meal_orginaldata.payed END),0) AS ���    '+#13+
                           '       , ISNULL(SUM(CASE WHEN dbo.meal_orginaldata.meal_type=2 THEN dbo.meal_orginaldata.payed END),0) AS ���    '+#13+
                           '       , ISNULL(SUM(CASE WHEN dbo.meal_orginaldata.meal_type=3 THEN dbo.meal_orginaldata.payed END),0) AS ���    '+#13+
                           '       , ISNULL(SUM(CASE WHEN dbo.meal_orginaldata.meal_type=4 THEN dbo.meal_orginaldata.payed END),0) AS ҹ��     '+#13+
                           '       , ISNULL(SUM(dbo.meal_orginaldata.payed),0) AS �ܽ��    '+#13+
                           '   FROM         dbo.meal_orginaldata INNER JOIN   '+#13+
                           '                       dbo.v_empandextra ON dbo.meal_orginaldata.empid = dbo.v_empandextra.rkey and  v_empandextra.factorytype = meal_orginaldata.factorytype'+#13+
                           '   WHERE   (meal_orginaldata.remark2 is not null) AND date_e between '+ QuotedStr(sdaystr) +' and '+ QuotedStr(edaystr)   +#13+
                           '        AND (dbo.meal_orginaldata.account_type = 0) ' +#13+
                           '   GROUP BY dbo.v_empandextra.employeecode,dbo.v_empandextra.chinesename,dbo.v_empandextra.ranks,  '+#13+
                           '         dbo.v_empandextra.departmentname,dbo.meal_orginaldata.date_e  ';

    11:DM.adsMain.CommandText:= ';WITH Detail AS      '+#13+
                               '   (    '+#13+
                               '       SELECT     dbo.v_empandextra.departmentname AS ����,dbo.v_empandextra.employeecode AS ����, dbo.v_empandextra.chinesename AS ����,dbo.v_empandextra.ranks as ְ��    '+#13+
                               '          , ISNULL(SUM(CASE WHEN dbo.meal_orginaldata.meal_type=1 THEN dbo.meal_orginaldata.payed END),0) AS ���        '+#13+
                               '           , ISNULL(SUM(CASE WHEN dbo.meal_orginaldata.meal_type=2 THEN dbo.meal_orginaldata.payed END),0) AS ���      '+#13+
                               '           , ISNULL(SUM(CASE WHEN dbo.meal_orginaldata.meal_type=3 THEN dbo.meal_orginaldata.payed END),0) AS ���      '+#13+
                               '           , ISNULL(SUM(CASE WHEN dbo.meal_orginaldata.meal_type=4 THEN dbo.meal_orginaldata.payed END),0) AS ҹ��       '+#13+
                               '           , ISNULL(SUM(dbo.meal_orginaldata.payed),0) AS �ܽ��       '+#13+
                               '           , ISNULL(SUM(dbo.meal_orginaldata.spayed),0) AS ''�ܽ��(����)''   '+#13+
                               '           , ISNULL(SUM(dbo.meal_orginaldata.ppayed),0) AS ''�ܽ��(�ֽ�)''    '+#13+
                               '      FROM         dbo.meal_orginaldata INNER JOIN    '+#13+
                               '                       dbo.v_empandextra ON dbo.meal_orginaldata.empid = dbo.v_empandextra.rkey and  v_empandextra.factorytype = meal_orginaldata.factorytype'+#13+
                               '       WHERE   dbo.meal_orginaldata.company=1 AND  date_e between '+ QuotedStr(sdaystr) +' and '+ QuotedStr(edaystr)     +#13+
                               '        AND (dbo.meal_orginaldata.account_type = 0) ' +#13+
                               '      GROUP BY dbo.v_empandextra.employeecode,dbo.v_empandextra.chinesename       '+#13+
                               '             ,dbo.v_empandextra.departmentname,dbo.v_empandextra.ranks            '+#13+
                               '   )                     '+#13+
                               '   ,Total AS          '+#13+
                               '   (                   '+#13+
                               '     SELECT ����+N''�ϼ�'' AS ����,'''' AS ����,'''' AS ����,'''' AS ְ��,SUM(���) AS ���,SUM(���) AS ���,SUM(���) AS ���,SUM(ҹ��) AS ҹ��      '+#13+
                               '           ,SUM(�ܽ��) AS �ܽ��,SUM([�ܽ��(����)]) AS ''�ܽ��(����)''                                       '+#13+
                               '           ,SUM([�ܽ��(�ֽ�)]) AS ''�ܽ��(�ֽ�)''                                                              '+#13+
                               '     FROM                                                                                                       '+#13+
                               '       (                                                                                                        '+#13+
                               '           SELECT     dbo.v_empandextra.departmentname AS ����,dbo.v_empandextra.employeecode AS ����, dbo.v_empandextra.chinesename AS ����,dbo.v_empandextra.ranks as ְ��      '+#13+
                               '           , ISNULL(SUM(CASE WHEN dbo.meal_orginaldata.meal_type=1 THEN dbo.meal_orginaldata.payed END),0) AS ���             '+#13+
                               '           , ISNULL(SUM(CASE WHEN dbo.meal_orginaldata.meal_type=2 THEN dbo.meal_orginaldata.payed END),0) AS ���             '+#13+
                               '           , ISNULL(SUM(CASE WHEN dbo.meal_orginaldata.meal_type=3 THEN dbo.meal_orginaldata.payed END),0) AS ���             '+#13+
                               '           , ISNULL(SUM(CASE WHEN dbo.meal_orginaldata.meal_type=4 THEN dbo.meal_orginaldata.payed END),0) AS ҹ��             '+#13+
                               '           , ISNULL(SUM(dbo.meal_orginaldata.payed),0) AS �ܽ��                 '+#13+
                               '           , ISNULL(SUM(dbo.meal_orginaldata.spayed),0) AS ''�ܽ��(����)''       '+#13+
                               '           , ISNULL(SUM(dbo.meal_orginaldata.ppayed),0) AS ''�ܽ��(�ֽ�)''       '+#13+
                               '      FROM         dbo.meal_orginaldata INNER JOIN                                    '+#13+
                                '                       dbo.v_empandextra ON dbo.meal_orginaldata.empid = dbo.v_empandextra.rkey and  v_empandextra.factorytype = meal_orginaldata.factorytype'+#13+
                               '       WHERE  dbo.meal_orginaldata.company=1 AND   date_e between '+ QuotedStr(sdaystr) +' and '+ QuotedStr(edaystr)       +#13+
                               '        AND (dbo.meal_orginaldata.account_type = 0) ' +#13+
                               '      GROUP BY dbo.v_empandextra.employeecode,dbo.v_empandextra.chinesename             '+#13+
                               '             ,dbo.v_empandextra.departmentname,dbo.v_empandextra.ranks                                   '+#13+
                               '                                                                            '+#13+
                               '        ) AS tb1                                                          '+#13+
                               '     GROUP BY ����                                                        '+#13+
                               '   ),ALLTOTAL AS                                                          '+#13+
                               '   (                                                                      '+#13+
                               '   SELECT	''���ջ���(ȫ��)'' AS ����,'''' AS ����,'''' AS ����,'''' AS ְ��                  '+#13+
                               '       ,ISNULL(SUM(CASE WHEN dbo.meal_orginaldata.meal_type=1 THEN dbo.meal_orginaldata.payed END),0) AS ���        '+#13+
                               '       , ISNULL(SUM(CASE WHEN dbo.meal_orginaldata.meal_type=2 THEN dbo.meal_orginaldata.payed END),0) AS ���         '+#13+
                               '       , ISNULL(SUM(CASE WHEN dbo.meal_orginaldata.meal_type=3 THEN dbo.meal_orginaldata.payed END),0) AS ���           '+#13+
                               '       , ISNULL(SUM(CASE WHEN dbo.meal_orginaldata.meal_type=4 THEN dbo.meal_orginaldata.payed END),0) AS ҹ��          '+#13+
                               '       , ISNULL(SUM(dbo.meal_orginaldata.payed),0) AS �ܽ��             '+#13+
                               '       , ISNULL(SUM(dbo.meal_orginaldata.spayed),0) AS ''�ܽ��(����)''     '+#13+
                               '       , ISNULL(SUM(dbo.meal_orginaldata.ppayed),0) AS ''�ܽ��(�ֽ�)''    '+#13+
                               '   FROM         dbo.meal_orginaldata                               '+#13+
                               '   WHERE  dbo.meal_orginaldata.company=1 AND  date_e between '+ QuotedStr(sdaystr) +' and '+ QuotedStr(edaystr)           +#13+
                               '        AND (dbo.meal_orginaldata.account_type = 0) ' +#13+
                               '   )                                '+#13+
                               '   SELECT * FROM (                  '+#13+
                               '       SELECT ����,����,����,ְ��,���,���,���,ҹ��,�ܽ��,[�ܽ��(����)],[�ܽ��(�ֽ�)] FROM Detail        '+#13+
                               '       UNION ALL                                                                                       '+#13+
                               '       SELECT ����,����,����,ְ��,���,���,���,ҹ��,�ܽ��,[�ܽ��(����)],[�ܽ��(�ֽ�)] FROM Total     '+#13+
                               '   ) AS t                                                                                           '+#13+
                               '   UNION ALL                                                                                        '+#13+
                               '   SELECT ����,����,����,ְ��,���,���,���,ҹ��,�ܽ��,[�ܽ��(����)],[�ܽ��(�ֽ�)] FROM ALLTOTAL      '+#13+
                               '   ORDER BY ����,���� DESC  ';

    12:DM.adsMain.CommandText:= ';WITH Detail AS      '+#13+
                               '   (    '+#13+
                               '       SELECT     dbo.v_empandextra.departmentname AS ����,dbo.v_empandextra.employeecode AS ����, dbo.v_empandextra.chinesename AS ����,dbo.v_empandextra.ranks as ְ��    '+#13+
                               '          , ISNULL(SUM(CASE WHEN dbo.meal_orginaldata.meal_type=1 THEN dbo.meal_orginaldata.payed END),0) AS ���        '+#13+
                               '           , ISNULL(SUM(CASE WHEN dbo.meal_orginaldata.meal_type=2 THEN dbo.meal_orginaldata.payed END),0) AS ���      '+#13+
                               '           , ISNULL(SUM(CASE WHEN dbo.meal_orginaldata.meal_type=3 THEN dbo.meal_orginaldata.payed END),0) AS ���      '+#13+
                               '           , ISNULL(SUM(CASE WHEN dbo.meal_orginaldata.meal_type=4 THEN dbo.meal_orginaldata.payed END),0) AS ҹ��       '+#13+
                               '           , ISNULL(SUM(dbo.meal_orginaldata.payed),0) AS �ܽ��       '+#13+
                               '           , ISNULL(SUM(dbo.meal_orginaldata.spayed),0) AS ''�ܽ��(����)''   '+#13+
                               '           , ISNULL(SUM(dbo.meal_orginaldata.ppayed),0) AS ''�ܽ��(�ֽ�)''    '+#13+
                               '      FROM         dbo.meal_orginaldata INNER JOIN    '+#13+
                              '                       dbo.v_empandextra ON dbo.meal_orginaldata.empid = dbo.v_empandextra.rkey and  v_empandextra.factorytype = meal_orginaldata.factorytype'+#13+
                               '       WHERE dbo.meal_orginaldata.dev_id=55 and  dbo.meal_orginaldata.company=2 AND  date_e between '+ QuotedStr(sdaystr) +' and '+ QuotedStr(edaystr)     +#13+
                               '      GROUP BY dbo.v_empandextra.employeecode,dbo.v_empandextra.chinesename       '+#13+
                               '             ,dbo.v_empandextra.departmentname,dbo.v_empandextra.ranks        '+#13+
                               '   )                     '+#13+
                               '   ,Total AS          '+#13+
                               '   (                   '+#13+
                               '     SELECT ����+N''�ϼ�'' AS ����,'''' AS ����,'''' AS ����,'''' AS ְ��,SUM(���) AS ���,SUM(���) AS ���,SUM(���) AS ���,SUM(ҹ��) AS ҹ��      '+#13+
                               '           ,SUM(�ܽ��) AS �ܽ��,SUM([�ܽ��(����)]) AS ''�ܽ��(����)''                                       '+#13+
                               '           ,SUM([�ܽ��(�ֽ�)]) AS ''�ܽ��(�ֽ�)''                                                              '+#13+
                               '     FROM                                                                                                       '+#13+
                               '       (                                                                                                        '+#13+
                               '           SELECT     dbo.v_empandextra.departmentname AS ����,dbo.v_empandextra.employeecode AS ����, dbo.v_empandextra.chinesename AS ���� ,dbo.v_empandextra.ranks as ְ��     '+#13+
                               '           , ISNULL(SUM(CASE WHEN dbo.meal_orginaldata.meal_type=1 THEN dbo.meal_orginaldata.payed END),0) AS ���             '+#13+
                               '           , ISNULL(SUM(CASE WHEN dbo.meal_orginaldata.meal_type=2 THEN dbo.meal_orginaldata.payed END),0) AS ���             '+#13+
                               '           , ISNULL(SUM(CASE WHEN dbo.meal_orginaldata.meal_type=3 THEN dbo.meal_orginaldata.payed END),0) AS ���             '+#13+
                               '           , ISNULL(SUM(CASE WHEN dbo.meal_orginaldata.meal_type=4 THEN dbo.meal_orginaldata.payed END),0) AS ҹ��             '+#13+
                               '           , ISNULL(SUM(dbo.meal_orginaldata.payed),0) AS �ܽ��                 '+#13+
                               '           , ISNULL(SUM(dbo.meal_orginaldata.spayed),0) AS ''�ܽ��(����)''       '+#13+
                               '           , ISNULL(SUM(dbo.meal_orginaldata.ppayed),0) AS ''�ܽ��(�ֽ�)''       '+#13+
                               '      FROM         dbo.meal_orginaldata INNER JOIN                                    '+#13+
                                '                       dbo.v_empandextra ON dbo.meal_orginaldata.empid = dbo.v_empandextra.rkey and  v_empandextra.factorytype = meal_orginaldata.factorytype'+#13+
                               '       WHERE dbo.meal_orginaldata.dev_id=55 and  dbo.meal_orginaldata.company=2 AND   date_e between '+ QuotedStr(sdaystr) +' and '+ QuotedStr(edaystr)       +#13+
                               '      GROUP BY dbo.v_empandextra.employeecode,dbo.v_empandextra.chinesename             '+#13+
                               '             ,dbo.v_empandextra.departmentname,dbo.v_empandextra.ranks                                   '+#13+
                               '                                                                            '+#13+
                               '        ) AS tb1                                                          '+#13+
                               '     GROUP BY ����                                                        '+#13+
                               '   ),ALLTOTAL AS                                                          '+#13+
                               '   (                                                                      '+#13+
                               '   SELECT	''���ջ���(ȫ��)'' AS ����,'''' AS ����,'''' AS ����,'''' AS ְ��                  '+#13+
                               '       ,ISNULL(SUM(CASE WHEN dbo.meal_orginaldata.meal_type=1 THEN dbo.meal_orginaldata.payed END),0) AS ���        '+#13+
                               '       , ISNULL(SUM(CASE WHEN dbo.meal_orginaldata.meal_type=2 THEN dbo.meal_orginaldata.payed END),0) AS ���         '+#13+
                               '       , ISNULL(SUM(CASE WHEN dbo.meal_orginaldata.meal_type=3 THEN dbo.meal_orginaldata.payed END),0) AS ���           '+#13+
                               '       , ISNULL(SUM(CASE WHEN dbo.meal_orginaldata.meal_type=4 THEN dbo.meal_orginaldata.payed END),0) AS ҹ��          '+#13+
                               '       , ISNULL(SUM(dbo.meal_orginaldata.payed),0) AS �ܽ��             '+#13+
                               '       , ISNULL(SUM(dbo.meal_orginaldata.spayed),0) AS ''�ܽ��(����)''     '+#13+
                               '       , ISNULL(SUM(dbo.meal_orginaldata.ppayed),0) AS ''�ܽ��(�ֽ�)''    '+#13+
                               '   FROM         dbo.meal_orginaldata                               '+#13+
                               '   WHERE dbo.meal_orginaldata.dev_id=55 and  dbo.meal_orginaldata.company=2 AND  date_e between '+ QuotedStr(sdaystr) +' and '+ QuotedStr(edaystr)           +#13+
                               '   )                                '+#13+
                               '   SELECT * FROM (                  '+#13+
                               '       SELECT ����,����,����,ְ��,���,���,���,ҹ��,�ܽ��,[�ܽ��(����)],[�ܽ��(�ֽ�)] FROM Detail        '+#13+
                               '       UNION ALL                                                                                       '+#13+
                               '       SELECT ����,����,����,ְ��,���,���,���,ҹ��,�ܽ��,[�ܽ��(����)],[�ܽ��(�ֽ�)] FROM Total     '+#13+
                               '   ) AS t                                                                                           '+#13+
                               '   UNION ALL                                                                                        '+#13+
                               '   SELECT ����,����,����,ְ��,���,���,���,ҹ��,�ܽ��,[�ܽ��(����)],[�ܽ��(�ֽ�)] FROM ALLTOTAL      '+#13+
                               '   ORDER BY ����,���� DESC  ';

        13:DM.adsMain.CommandText:= ';WITH Detail AS      '+#13+
                               '   (    '+#13+
                               '       SELECT     dbo.v_empandextra.departmentname AS ����,dbo.v_empandextra.employeecode AS ����, dbo.v_empandextra.chinesename AS ����,dbo.v_empandextra.ranks as ְ��    '+#13+
                               '          , ISNULL(SUM(CASE WHEN dbo.meal_orginaldata.meal_type=1 THEN dbo.meal_orginaldata.payed END),0) AS ���        '+#13+
                               '           , ISNULL(SUM(CASE WHEN dbo.meal_orginaldata.meal_type=2 THEN dbo.meal_orginaldata.payed END),0) AS ���      '+#13+
                               '           , ISNULL(SUM(CASE WHEN dbo.meal_orginaldata.meal_type=3 THEN dbo.meal_orginaldata.payed END),0) AS ���      '+#13+
                               '           , ISNULL(SUM(CASE WHEN dbo.meal_orginaldata.meal_type=4 THEN dbo.meal_orginaldata.payed END),0) AS ҹ��       '+#13+
                               '           , ISNULL(SUM(dbo.meal_orginaldata.payed),0) AS �ܽ��       '+#13+
                               '           , ISNULL(SUM(dbo.meal_orginaldata.spayed),0) AS ''�ܽ��(����)''   '+#13+
                               '           , ISNULL(SUM(dbo.meal_orginaldata.ppayed),0) AS ''�ܽ��(�ֽ�)''    '+#13+
                               '      FROM         dbo.meal_orginaldata INNER JOIN    '+#13+
                             '                       dbo.v_empandextra ON dbo.meal_orginaldata.empid = dbo.v_empandextra.rkey and  v_empandextra.factorytype = meal_orginaldata.factorytype'+#13+
                               '       WHERE dbo.meal_orginaldata.dev_id <> 55 and  dbo.meal_orginaldata.company=2 AND  date_e between '+ QuotedStr(sdaystr) +' and '+ QuotedStr(edaystr)     +#13+
                               '      GROUP BY dbo.v_empandextra.employeecode,dbo.v_empandextra.chinesename       '+#13+
                               '             ,dbo.v_empandextra.departmentname,dbo.v_empandextra.ranks           '+#13+
                               '   )                     '+#13+
                               '   ,Total AS          '+#13+
                               '   (                   '+#13+
                               '     SELECT ����+N''�ϼ�'' AS ����,'''' AS ����,'''' AS ����,'''' AS ְ��,SUM(���) AS ���,SUM(���) AS ���,SUM(���) AS ���,SUM(ҹ��) AS ҹ��      '+#13+
                               '           ,SUM(�ܽ��) AS �ܽ��,SUM([�ܽ��(����)]) AS ''�ܽ��(����)''                                       '+#13+
                               '           ,SUM([�ܽ��(�ֽ�)]) AS ''�ܽ��(�ֽ�)''                                                              '+#13+
                               '     FROM                                                                                                       '+#13+
                               '       (                                                                                                        '+#13+
                               '           SELECT     dbo.v_empandextra.departmentname AS ����,dbo.v_empandextra.employeecode AS ����, dbo.v_empandextra.chinesename AS ����,dbo.v_empandextra.ranks as ְ��      '+#13+
                               '           , ISNULL(SUM(CASE WHEN dbo.meal_orginaldata.meal_type=1 THEN dbo.meal_orginaldata.payed END),0) AS ���             '+#13+
                               '           , ISNULL(SUM(CASE WHEN dbo.meal_orginaldata.meal_type=2 THEN dbo.meal_orginaldata.payed END),0) AS ���             '+#13+
                               '           , ISNULL(SUM(CASE WHEN dbo.meal_orginaldata.meal_type=3 THEN dbo.meal_orginaldata.payed END),0) AS ���             '+#13+
                               '           , ISNULL(SUM(CASE WHEN dbo.meal_orginaldata.meal_type=4 THEN dbo.meal_orginaldata.payed END),0) AS ҹ��             '+#13+
                               '           , ISNULL(SUM(dbo.meal_orginaldata.payed),0) AS �ܽ��                 '+#13+
                               '           , ISNULL(SUM(dbo.meal_orginaldata.spayed),0) AS ''�ܽ��(����)''       '+#13+
                               '           , ISNULL(SUM(dbo.meal_orginaldata.ppayed),0) AS ''�ܽ��(�ֽ�)''       '+#13+
                               '      FROM         dbo.meal_orginaldata INNER JOIN                                    '+#13+
                                 '                       dbo.v_empandextra ON dbo.meal_orginaldata.empid = dbo.v_empandextra.rkey and  v_empandextra.factorytype = meal_orginaldata.factorytype'+#13+
                               '       WHERE dbo.meal_orginaldata.dev_id <> 55 and  dbo.meal_orginaldata.company=2 AND  date_e between '+ QuotedStr(sdaystr) +' and '+ QuotedStr(edaystr)       +#13+
                               '      GROUP BY dbo.v_empandextra.employeecode,dbo.v_empandextra.chinesename             '+#13+
                               '             ,dbo.v_empandextra.departmentname,dbo.v_empandextra.ranks                                    '+#13+
                               '                                                                            '+#13+
                               '        ) AS tb1                                                          '+#13+
                               '     GROUP BY ����                                                        '+#13+
                               '   ),ALLTOTAL AS                                                          '+#13+
                               '   (                                                                      '+#13+
                               '   SELECT	''���ջ���(ȫ��)'' AS ����,'''' AS ����,'''' AS ����,'''' AS ְ��                  '+#13+
                               '       ,ISNULL(SUM(CASE WHEN dbo.meal_orginaldata.meal_type=1 THEN dbo.meal_orginaldata.payed END),0) AS ���        '+#13+
                               '       , ISNULL(SUM(CASE WHEN dbo.meal_orginaldata.meal_type=2 THEN dbo.meal_orginaldata.payed END),0) AS ���         '+#13+
                               '       , ISNULL(SUM(CASE WHEN dbo.meal_orginaldata.meal_type=3 THEN dbo.meal_orginaldata.payed END),0) AS ���           '+#13+
                               '       , ISNULL(SUM(CASE WHEN dbo.meal_orginaldata.meal_type=4 THEN dbo.meal_orginaldata.payed END),0) AS ҹ��          '+#13+
                               '       , ISNULL(SUM(dbo.meal_orginaldata.payed),0) AS �ܽ��             '+#13+
                               '       , ISNULL(SUM(dbo.meal_orginaldata.spayed),0) AS ''�ܽ��(����)''     '+#13+
                               '       , ISNULL(SUM(dbo.meal_orginaldata.ppayed),0) AS ''�ܽ��(�ֽ�)''    '+#13+
                               '   FROM         dbo.meal_orginaldata                               '+#13+
                               '   WHERE dbo.meal_orginaldata.dev_id <> 55 and  dbo.meal_orginaldata.company=2 AND  date_e between '+ QuotedStr(sdaystr) +' and '+ QuotedStr(edaystr)           +#13+
                               '   )                                '+#13+
                               '   SELECT * FROM (                  '+#13+
                               '       SELECT ����,����,����,ְ��,���,���,���,ҹ��,�ܽ��,[�ܽ��(����)],[�ܽ��(�ֽ�)] FROM Detail        '+#13+
                               '       UNION ALL                                                                                       '+#13+
                               '       SELECT ����,����,����,ְ��,���,���,���,ҹ��,�ܽ��,[�ܽ��(����)],[�ܽ��(�ֽ�)] FROM Total     '+#13+
                               '   ) AS t                                                                                           '+#13+
                               '   UNION ALL                                                                                        '+#13+
                               '   SELECT ����,����,����,ְ��,���,���,���,ҹ��,�ܽ��,[�ܽ��(����)],[�ܽ��(�ֽ�)] FROM ALLTOTAL      '+#13+
                               '   ORDER BY ����,���� DESC  ';

    14:DM.adsMain.CommandText:= ';WITH Detail AS      '+#13+
                               '   (    '+#13+
                               '       SELECT     dbo.v_empandextra.departmentname AS ����,dbo.v_empandextra.employeecode AS ����, dbo.v_empandextra.chinesename AS ����,dbo.v_empandextra.ranks as ְ��    '+#13+
                               '          , ISNULL(SUM(CASE WHEN dbo.meal_orginaldata.meal_type=1 THEN dbo.meal_orginaldata.payed END),0) AS ���        '+#13+
                               '           , ISNULL(SUM(CASE WHEN dbo.meal_orginaldata.meal_type=2 THEN dbo.meal_orginaldata.payed END),0) AS ���      '+#13+
                               '           , ISNULL(SUM(CASE WHEN dbo.meal_orginaldata.meal_type=3 THEN dbo.meal_orginaldata.payed END),0) AS ���      '+#13+
                               '           , ISNULL(SUM(CASE WHEN dbo.meal_orginaldata.meal_type=4 THEN dbo.meal_orginaldata.payed END),0) AS ҹ��       '+#13+
                               '           , ISNULL(SUM(dbo.meal_orginaldata.payed),0) AS �ܽ��       '+#13+
                               '           , ISNULL(SUM(dbo.meal_orginaldata.spayed),0) AS ''�ܽ��(����)''   '+#13+
                               '           , ISNULL(SUM(dbo.meal_orginaldata.ppayed),0) AS ''�ܽ��(�ֽ�)''    '+#13+
                               '      FROM         dbo.meal_orginaldata INNER JOIN    '+#13+
                           '                       dbo.v_empandextra ON dbo.meal_orginaldata.empid = dbo.v_empandextra.rkey and  v_empandextra.factorytype = meal_orginaldata.factorytype'+#13+
                               '       WHERE   dbo.meal_orginaldata.company=3 AND  date_e between '+ QuotedStr(sdaystr) +' and '+ QuotedStr(edaystr)     +#13+
                               '      GROUP BY dbo.v_empandextra.employeecode,dbo.v_empandextra.chinesename       '+#13+
                               '             ,dbo.v_empandextra.departmentname,dbo.v_empandextra.ranks        '+#13+
                               '   )                     '+#13+
                               '   ,Total AS          '+#13+
                               '   (                   '+#13+
                               '     SELECT ����+N''�ϼ�'' AS ����,'''' AS ����,'''' AS ����,'''' as ְ��,SUM(���) AS ���,SUM(���) AS ���,SUM(���) AS ���,SUM(ҹ��) AS ҹ��      '+#13+
                               '           ,SUM(�ܽ��) AS �ܽ��,SUM([�ܽ��(����)]) AS ''�ܽ��(����)''                                       '+#13+
                               '           ,SUM([�ܽ��(�ֽ�)]) AS ''�ܽ��(�ֽ�)''                                                              '+#13+
                               '     FROM                                                                                                       '+#13+
                               '       (                                                                                                        '+#13+
                               '           SELECT     dbo.v_empandextra.departmentname AS ����,dbo.v_empandextra.employeecode AS ����, dbo.v_empandextra.chinesename AS ����,dbo.v_empandextra.ranks as ְ��      '+#13+
                               '           , ISNULL(SUM(CASE WHEN dbo.meal_orginaldata.meal_type=1 THEN dbo.meal_orginaldata.payed END),0) AS ���             '+#13+
                               '           , ISNULL(SUM(CASE WHEN dbo.meal_orginaldata.meal_type=2 THEN dbo.meal_orginaldata.payed END),0) AS ���             '+#13+
                               '           , ISNULL(SUM(CASE WHEN dbo.meal_orginaldata.meal_type=3 THEN dbo.meal_orginaldata.payed END),0) AS ���             '+#13+
                               '           , ISNULL(SUM(CASE WHEN dbo.meal_orginaldata.meal_type=4 THEN dbo.meal_orginaldata.payed END),0) AS ҹ��             '+#13+
                               '           , ISNULL(SUM(dbo.meal_orginaldata.payed),0) AS �ܽ��                 '+#13+
                               '           , ISNULL(SUM(dbo.meal_orginaldata.spayed),0) AS ''�ܽ��(����)''       '+#13+
                               '           , ISNULL(SUM(dbo.meal_orginaldata.ppayed),0) AS ''�ܽ��(�ֽ�)''       '+#13+
                               '      FROM         dbo.meal_orginaldata INNER JOIN                                    '+#13+
                          '                       dbo.v_empandextra ON dbo.meal_orginaldata.empid = dbo.v_empandextra.rkey and  v_empandextra.factorytype = meal_orginaldata.factorytype'+#13+
                               '       WHERE  dbo.meal_orginaldata.company=3 AND    date_e between '+ QuotedStr(sdaystr) +' and '+ QuotedStr(edaystr)       +#13+
                               '      GROUP BY dbo.v_empandextra.employeecode,dbo.v_empandextra.chinesename             '+#13+
                               '             ,dbo.v_empandextra.departmentname,dbo.v_empandextra.ranks                                    '+#13+
                               '                                                                            '+#13+
                               '        ) AS tb1                                                          '+#13+
                               '     GROUP BY ����                                                        '+#13+
                               '   ),ALLTOTAL AS                                                          '+#13+
                               '   (                                                                      '+#13+
                               '   SELECT	''���ջ���(ȫ��)'' AS ����,'''' AS ����,'''' AS ����,'''' as ְ��                  '+#13+
                               '       ,ISNULL(SUM(CASE WHEN dbo.meal_orginaldata.meal_type=1 THEN dbo.meal_orginaldata.payed END),0) AS ���        '+#13+
                               '       , ISNULL(SUM(CASE WHEN dbo.meal_orginaldata.meal_type=2 THEN dbo.meal_orginaldata.payed END),0) AS ���         '+#13+
                               '       , ISNULL(SUM(CASE WHEN dbo.meal_orginaldata.meal_type=3 THEN dbo.meal_orginaldata.payed END),0) AS ���           '+#13+
                               '       , ISNULL(SUM(CASE WHEN dbo.meal_orginaldata.meal_type=4 THEN dbo.meal_orginaldata.payed END),0) AS ҹ��          '+#13+
                               '       , ISNULL(SUM(dbo.meal_orginaldata.payed),0) AS �ܽ��             '+#13+
                               '       , ISNULL(SUM(dbo.meal_orginaldata.spayed),0) AS ''�ܽ��(����)''     '+#13+
                               '       , ISNULL(SUM(dbo.meal_orginaldata.ppayed),0) AS ''�ܽ��(�ֽ�)''    '+#13+
                               '   FROM         dbo.meal_orginaldata                               '+#13+
                               '   WHERE  dbo.meal_orginaldata.company=3 AND  date_e between '+ QuotedStr(sdaystr) +' and '+ QuotedStr(edaystr)           +#13+
                               '   )                                '+#13+
                               '   SELECT * FROM (                  '+#13+
                               '       SELECT ����,����,����,ְ��,���,���,���,ҹ��,�ܽ��,[�ܽ��(����)],[�ܽ��(�ֽ�)] FROM Detail        '+#13+
                               '       UNION ALL                                                                                       '+#13+
                               '       SELECT ����,����,����,ְ��,���,���,���,ҹ��,�ܽ��,[�ܽ��(����)],[�ܽ��(�ֽ�)] FROM Total     '+#13+
                               '   ) AS t                                                                                           '+#13+
                               '   UNION ALL                                                                                        '+#13+
                               '   SELECT ����,����,����,ְ��,���,���,���,ҹ��,�ܽ��,[�ܽ��(����)],[�ܽ��(�ֽ�)] FROM ALLTOTAL      '+#13+
                               '   ORDER BY ����,���� DESC  ';
    15:DM.adsMain.CommandText:= ';WITH Detail AS      '+#13+
                               '   (    '+#13+
                               '       SELECT     dbo.v_empandextra.departmentname AS ����,dbo.v_empandextra.employeecode AS ����, dbo.v_empandextra.chinesename AS ����,dbo.v_empandextra.ranks as ְ��    '+#13+
                               '          , ISNULL(SUM(CASE WHEN dbo.meal_orginaldata.meal_type=1 THEN dbo.meal_orginaldata.payed END),0) AS ���        '+#13+
                               '           , ISNULL(SUM(CASE WHEN dbo.meal_orginaldata.meal_type=2 THEN dbo.meal_orginaldata.payed END),0) AS ���      '+#13+
                               '           , ISNULL(SUM(CASE WHEN dbo.meal_orginaldata.meal_type=3 THEN dbo.meal_orginaldata.payed END),0) AS ���      '+#13+
                               '           , ISNULL(SUM(CASE WHEN dbo.meal_orginaldata.meal_type=4 THEN dbo.meal_orginaldata.payed END),0) AS ҹ��       '+#13+
                               '           , ISNULL(SUM(dbo.meal_orginaldata.payed),0) AS �ܽ��       '+#13+
                               '           , ISNULL(SUM(dbo.meal_orginaldata.spayed),0) AS ''�ܽ��(����)''   '+#13+
                               '           , ISNULL(SUM(dbo.meal_orginaldata.ppayed),0) AS ''�ܽ��(�ֽ�)''    '+#13+
                               '      FROM         dbo.meal_orginaldata INNER JOIN    '+#13+
                       '                       dbo.v_empandextra ON dbo.meal_orginaldata.empid = dbo.v_empandextra.rkey and  v_empandextra.factorytype = meal_orginaldata.factorytype'+#13+
                               '       WHERE    date_e between '+ QuotedStr(sdaystr) +' and '+ QuotedStr(edaystr)     +#13+
                               '      GROUP BY dbo.v_empandextra.employeecode,dbo.v_empandextra.chinesename       '+#13+
                               '             ,dbo.v_empandextra.departmentname,dbo.v_empandextra.ranks            '+#13+
                               '   )                     '+#13+
                               '   ,Total AS          '+#13+
                               '   (                   '+#13+
                               '     SELECT ����+N''�ϼ�'' AS ����,'''' AS ����,'''' AS ����,'''' AS ְ��,SUM(���) AS ���,SUM(���) AS ���,SUM(���) AS ���,SUM(ҹ��) AS ҹ��      '+#13+
                               '           ,SUM(�ܽ��) AS �ܽ��,SUM([�ܽ��(����)]) AS ''�ܽ��(����)''                                       '+#13+
                               '           ,SUM([�ܽ��(�ֽ�)]) AS ''�ܽ��(�ֽ�)''                                                              '+#13+
                               '     FROM                                                                                                       '+#13+
                               '       (                                                                                                        '+#13+
                               '           SELECT     dbo.v_empandextra.departmentname AS ����,dbo.v_empandextra.employeecode AS ����, dbo.v_empandextra.chinesename AS ����,dbo.v_empandextra.ranks as ְ��      '+#13+
                               '           , ISNULL(SUM(CASE WHEN dbo.meal_orginaldata.meal_type=1 THEN dbo.meal_orginaldata.payed END),0) AS ���             '+#13+
                               '           , ISNULL(SUM(CASE WHEN dbo.meal_orginaldata.meal_type=2 THEN dbo.meal_orginaldata.payed END),0) AS ���             '+#13+
                               '           , ISNULL(SUM(CASE WHEN dbo.meal_orginaldata.meal_type=3 THEN dbo.meal_orginaldata.payed END),0) AS ���             '+#13+
                               '           , ISNULL(SUM(CASE WHEN dbo.meal_orginaldata.meal_type=4 THEN dbo.meal_orginaldata.payed END),0) AS ҹ��             '+#13+
                               '           , ISNULL(SUM(dbo.meal_orginaldata.payed),0) AS �ܽ��                 '+#13+
                               '           , ISNULL(SUM(dbo.meal_orginaldata.spayed),0) AS ''�ܽ��(����)''       '+#13+
                               '           , ISNULL(SUM(dbo.meal_orginaldata.ppayed),0) AS ''�ܽ��(�ֽ�)''       '+#13+
                               '      FROM         dbo.meal_orginaldata INNER JOIN                                    '+#13+
                          '                       dbo.v_empandextra ON dbo.meal_orginaldata.empid = dbo.v_empandextra.rkey and  v_empandextra.factorytype = meal_orginaldata.factorytype'+#13+
                               '       WHERE   date_e between '+ QuotedStr(sdaystr) +' and '+ QuotedStr(edaystr)       +#13+
                               '      GROUP BY dbo.v_empandextra.employeecode,dbo.v_empandextra.chinesename             '+#13+
                               '             ,dbo.v_empandextra.departmentname,dbo.v_empandextra.ranks                               '+#13+
                               '                                                                            '+#13+
                               '        ) AS tb1                                                          '+#13+
                               '     GROUP BY ����                                                        '+#13+
                               '   ),ALLTOTAL AS                                                          '+#13+
                               '   (                                                                      '+#13+
                               '   SELECT	''���ջ���(ȫ��)'' AS ����,'''' AS ����,'''' AS ����,'''' AS ְ��                  '+#13+
                               '       ,ISNULL(SUM(CASE WHEN dbo.meal_orginaldata.meal_type=1 THEN dbo.meal_orginaldata.payed END),0) AS ���        '+#13+
                               '       , ISNULL(SUM(CASE WHEN dbo.meal_orginaldata.meal_type=2 THEN dbo.meal_orginaldata.payed END),0) AS ���         '+#13+
                               '       , ISNULL(SUM(CASE WHEN dbo.meal_orginaldata.meal_type=3 THEN dbo.meal_orginaldata.payed END),0) AS ���           '+#13+
                               '       , ISNULL(SUM(CASE WHEN dbo.meal_orginaldata.meal_type=4 THEN dbo.meal_orginaldata.payed END),0) AS ҹ��          '+#13+
                               '       , ISNULL(SUM(dbo.meal_orginaldata.payed),0) AS �ܽ��             '+#13+
                               '       , ISNULL(SUM(dbo.meal_orginaldata.spayed),0) AS ''�ܽ��(����)''     '+#13+
                               '       , ISNULL(SUM(dbo.meal_orginaldata.ppayed),0) AS ''�ܽ��(�ֽ�)''    '+#13+
                               '   FROM         dbo.meal_orginaldata                               '+#13+
                               '   WHERE  date_e between '+ QuotedStr(sdaystr) +' and '+ QuotedStr(edaystr)           +#13+
                               '   )                                '+#13+
                               '   SELECT * FROM (                  '+#13+
                               '       SELECT ����,����,����,ְ��,���,���,���,ҹ��,�ܽ��,[�ܽ��(����)],[�ܽ��(�ֽ�)] FROM Detail        '+#13+
                               '       UNION ALL                                                                                       '+#13+
                               '       SELECT ����,����,����,ְ��,���,���,���,ҹ��,�ܽ��,[�ܽ��(����)],[�ܽ��(�ֽ�)] FROM Total     '+#13+
                               '   ) AS t                                                                                           '+#13+
                               '   UNION ALL                                                                                        '+#13+
                               '   SELECT ����,����,����,ְ��,���,���,���,ҹ��,�ܽ��,[�ܽ��(����)],[�ܽ��(�ֽ�)] FROM ALLTOTAL      '+#13+
                               '   ORDER BY ����,���� DESC  ';

    16:DM.adsMain.CommandText:='SELECT  meal_orginaldata.empno AS ����,meal_orginaldata.employeecard AS ����    '+#13+
                               '       ,ALTERATION.oper_date AS ��ְ��������       '+#13+
                               '       ,meal_orginaldata.card_time AS ��ʱ��,meal_orginaldata.dev_id AS ����   '+#13+
                               '       ,meal_orginaldata.payed AS ���    '+#13+
                               '       ,CASE dbo.meal_orginaldata.company WHEN 1 THEN ''�ĺ�����'' WHEN 2 THEN ''���극��''    '+#13+
                               '         WHEN 3 THEN ''�ͼ�С��'' END AS ����    '+#13+
                               '       , CASE dbo.meal_orginaldata.meal_type WHEN 1 THEN ''���'' WHEN 2 THEN ''���''    '+#13+
                               '         WHEN 3 THEN ''���'' WHEN 4 THEN ''ҹ��'' END AS �ͱ�    '+#13+
                               '       , CASE dbo.meal_orginaldata.account_type WHEN 0 THEN ''����'' WHEN 1 THEN ''�ֽ�'' END AS �ʻ�    '+#13+
                               '   FROM meal_orginaldata INNER JOIN        '+#13+
                               '         (                            '+#13+
                               '         SELECT * FROM (             '+#13+
                               '               select  *              '+#13+
                               '                 ,row_number() over (partition by employeeid order by rkey desc) as row_index   '+#13+
                               '               from EMPLOYEE_ALTERATION                               '+#13+
                               '                 where oper_date between '+ QuotedStr(sdaystr + ' 00:00:00') +' and '+ QuotedStr(edaystr + ' 23:59:59') +#13+
                               '                 and type in (               '+#13+
                               '                       select datadetail.rkey from datadetail inner join         '+#13+
                               '                         datadict on datadetail.dictid=datadict.rkey      '+#13+
                               '                           where datadict.item=''��ְ����'' )      '+#13+
                               '                 and employeeid not in (select rkey from employeemsg where status = 1)     '+#13+
                               '               )	AS ALTERATION_1   ' +#13+
                               '         where row_index=1   '+#13+
                               '         ) as ALTERATION ON meal_orginaldata.EMPID = ALTERATION.employeeid     '+#13+
                               '   where  meal_orginaldata.card_time >(convert(varchar(20),dateadd(d,1,ALTERATION.oper_date),23) + '' 05:00:00'')   '+#13+
                               '     and date_e between '+ QuotedStr(sdaystr) +' and '+ QuotedStr(edaystr)  +#13+
                               '   order by ��ʱ��  ';
  end;
//  ShowMessage(DM.adsMain.CommandText);
  DM.adsMain.Open;
  if not DM.adsMain.IsEmpty then
  begin
     for i:=0 to dbMain.Columns.Count-1 do
        dbMain.Columns[i].Width:=120;
    edtFilter.ReadOnly := DM.adsMain.IsEmpty;
    lbFilter.Caption:=dbMain.Columns[0].Title.Caption;
    dbMain.Columns[0].Title.Color:=clRed;
    preColumn:=dbMain.Columns[0];
    lblCount.Caption := inttostr(dm.adsMain.RecordCount);
  end
  else
    lblCount.Caption := '0';
end;

procedure TfrmMain.edtFilterChange(Sender: TObject);
begin
  IF not  DM.adsMain.Active THEN EXIT;
  if Trim(edtFilter.Text)<>'' then
  begin
    DM.adsMain.Filtered:=False;
    DM.adsMain.Filter:= preColumn.FieldName + ' like ''%' + Trim(edtFilter.Text) + '%''';
    DM.adsMain.Filtered:=True;
  end
  else
    DM.adsMain.Filter:='';
  lblCount.Caption:=IntToStr(DM.adsMain.RecordCount);
end;

procedure TfrmMain.dbMainTitleClick(Column: TColumnEh);
begin
  if DM.adsMain.IsEmpty then Exit;
  if (Column.Title.Caption <> preColumn.Title.Caption)
        and (Column.Field.DataType in [ftString,ftWideString]) then
  begin
    lbFilter.Caption:=Column.Title.Caption;
    Column.Title.Color:=clRed;
    preColumn.Title.Color:=clBtnFace;
    edtFilter.Text:='';
    edtFilter.ReadOnly:=False;
    edtFilter.SetFocus;
    preColumn:=Column;
  end;
    
  if (column.Title.SortMarker =smDownEh) or (column.Title.SortMarker =smNoneEh) then
  begin
    column.Title.SortMarker:=smUpEh;
    DM.adsMain.Sort:=Column.FieldName;
  end
  else
  begin
    column.Title.SortMarker:=smDownEh;
    dm.adsMain.Sort:=Column.FieldName+' DESC';
  end;
end;

procedure TfrmMain.dbMainKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Chr(Key)='V') and (ssalt in Shift) then
    ShowMessage(DM.adsMain.CommandText);
end;

end.
