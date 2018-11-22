unit CommFrm_Mod29;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls,
  DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls, DynVarsEh, Data.DB,
  Datasnap.DBClient, EhLibVCL, GridsEh, DBAxisGridsEh, DBGridEh,uBaseFrm;

type
  TfrmComm_Mod29 = class(TfrmBase)
    pnl1: TPanel;
    pnl2: TPanel;
    btnClose: TBitBtn;
    eh1: TDBGridEh;
    cds1: TClientDataSet;
    ds1: TDataSource;
    btnS: TBitBtn;
    procedure eh1DblClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    procedure GetData(ARkey:string;AType:Integer);
    procedure InitCds();
  end;

var
  frmComm_Mod29: TfrmComm_Mod29;

implementation

uses uCommFunc;

{$R *.dfm}

{ TfrmComm_Mod29 }

procedure TfrmComm_Mod29.eh1DblClick(Sender: TObject);
begin
  ModalResult:= mrOk;
end;

procedure TfrmComm_Mod29.GetData(ARkey: string; AType: Integer);
var
  LSql:string;
begin
  case AType of
    1:
    begin
      LSql:=' SELECT Data0017.INV_PART_NUMBER AS ���ϱ���,Data0017.INV_NAME AS ��������   ' + #13 +
            '        ,Data0017.INV_DESCRIPTION AS ���Ϲ��,Data0496.GROUP_NAME AS �������    ' + #13 +
            '        ,Data0016.LOCATION AS �ֿ�,SUM(Data0022.QUAN_ON_HAND)  AS �������    ' + #13 +
            '        ,CASE SUM(Data0022.QUANTITY) WHEN 0 THEN NULL   ' + #13 +
            '         ELSE ROUND(SUM(Data0022.QUANTITY * Data0022.tax_price * Data0456.exch_rate) ' + #13 +
            '             / SUM(Data0022.QUANTITY),4) END AS ƽ���۸� ' + #13 +
            '        ,ROUND(SUM(Data0022.QUAN_ON_HAND * Data0022.tax_price * Data0456.exch_rate),3) AS ���  ' + #13 +
            '        ,Data0002.UNIT_CODE AS �����λ,Data0071.reason AS �빺ԭ��  ' + #13 +
            '        ,Data0022.BARCODE_ID AS ��ע, Data0023.ABBR_NAME AS ��Ӧ��  ' + #13 +
            '        ,Data0019.inv_group_name AS �������,''ͨ�ÿ��'' AS �������  ' + #13 +
            '    FROM   Data0022 INNER JOIN     ' + #13 +
            '          Data0017 ON Data0022.INVENTORY_PTR = Data0017.RKEY INNER JOIN     ' + #13 +
            '           Data0496 ON Data0017.GROUP_PTR = Data0496.RKEY INNER JOIN   ' + #13 +
            '           Data0019 ON Data0496.group_ptr = Data0019.rkey INNER JOIN    ' + #13 +
            '           Data0002 ON Data0022.LOCATION_PTR_FROM = Data0002.RKEY INNER JOIN ' + #13 +
            '           Data0456 ON Data0022.GRN_PTR = Data0456.RKEY INNER JOIN       ' + #13 +
            '           Data0015 ON Data0456.warehouse_ptr = Data0015.RKEY INNER JOIN  ' + #13 +
            '           Data0023 ON Data0456.SUPP_PTR = Data0023.RKEY LEFT OUTER JOIN  ' + #13 +
            '           Data0016 ON Data0022.LOCATION_PTR = Data0016.RKEY left join  ' + #13 +
            '           Data0071 ON Data0022.SOURCE_PTR = dbo.Data0071.RKEY      ' + #13 +
            '    WHERE  (Data0022.QUAN_ON_HAND <> 0)        ' + #13 +
            '     and (data0017.rkey=' + ARkey + ')         ' + #13 +
            '    GROUP BY Data0017.INV_PART_NUMBER, Data0017.INV_NAME,  ' + #13 +
            '           Data0017.INV_DESCRIPTION,Data0496.GROUP_NAME,Data0002.UNIT_CODE, Data0071.reason, Data0022.BARCODE_ID,  ' + #13 +
            '           Data0023.ABBR_NAME,Data0019.inv_group_name,Data0016.LOCATION    ' + #13 +
            '  union all       ' + #13 +
            '    SELECT Data0017.INV_PART_NUMBER,Data0017.INV_NAME,Data0017.INV_DESCRIPTION,Data0496.GROUP_NAME,   ' + #13 +
            '           Data0016.LOCATION,SUM(DATA0134.QUAN_ON_HAND) AS quan_total, ' + #13 +
            '           CASE SUM(Data0134.QUANTITY) WHEN 0 THEN NULL      ' + #13 +
            '           ELSE ROUND(SUM(Data0134.QUANTITY * Data0134.tax_price * Data0133.exch_rate)   ' + #13 +
            '           / SUM(Data0134.QUANTITY),4) END AS avl_price,      ' + #13 +
            '           ROUND(SUM(Data0134.QUAN_ON_HAND * Data0134.tax_price * Data0133.exch_rate),3) AS amount,    ' + #13 +
            '           Data0002.UNIT_CODE,Data0071.reason, Data0134.BARCODE_ID,Data0023.ABBR_NAME,Data0019.inv_group_name,''VMI���'' AS type   ' + #13 +
            '    FROM   Data0017 INNER JOIN            ' + #13 +
            '           Data0496 ON Data0017.GROUP_PTR = Data0496.RKEY INNER JOIN   ' + #13 +
            '           Data0019 ON Data0496.group_ptr = Data0019.rkey INNER JOIN    ' + #13 +
            '           DATA0134 ON Data0017.RKEY = DATA0134.INVENTORY_PTR INNER JOIN    ' + #13 +
            '           Data0002 ON DATA0134.UNIT_PTR = Data0002.RKEY INNER JOIN   ' + #13 +
            '          DATA0133 INNER JOIN     ' + #13 +
            '           Data0023 ON DATA0133.SUPP_PTR = Data0023.RKEY ON DATA0134.GRN_PTR = DATA0133.RKEY INNER JOIN   ' + #13 +
            '           Data0016 ON DATA0134.LOCATION_PTR = Data0016.RKEY LEFT JOIN  ' + #13 +
            '           dbo.Data0071 ON dbo.DATA0134.SOURCE_PTR = dbo.Data0071.RKEY   ' + #13 +
            '    WHERE  (data0134.quan_on_hand>0)       ' + #13 +
            '       and  (DATA0134.INVENTORY_ptr = ' + ARkey + ')     ' + #13 +
            '    GROUP BY Data0017.INV_PART_NUMBER,Data0017.INV_NAME,Data0017.INV_DESCRIPTION,Data0496.GROUP_NAME,Data0002.UNIT_CODE,  ' + #13 +
            '                     Data0071.reason, Data0134.BARCODE_ID, Data0023.ABBR_NAME,Data0019.inv_group_name,Data0016.LOCATION   ' + #13 +
            '    ORDER BY Data0017.INV_PART_NUMBER, Data0017.INV_DESCRIPTION    ';
    end;
    2:
    begin
      LSql:=' SELECT     dbo.Data0023.CODE AS ��Ӧ�̴���, dbo.Data0071.QUAN_ORD - dbo.Data0071.QUAN_RECD + dbo.Data0071.QUAN_RETN AS ��;����   ' + #13 +
            '          , dbo.Data0023.ABBR_NAME As ��Ӧ������,dbo.Data0071.tax_price AS ��˰����  ' + #13 +
            '          , dbo.Data0071.TAX_2 AS [˰��%], dbo.Data0071.REQ_DATE AS ��������    ' + #13 +
            '          , dbo.Data0070.PO_NUMBER AS �빺���, dbo.Data0071.reason AS �빺ԭ��   ' + #13 +
            '          , dbo.Data0071.rohs AS ROHS, dbo.Data0002.UNIT_NAME AS ��λ   ' + #13 +
            '          , ISNULL(dbo.Data0005.EMPLOYEE_NAME, dbo.Data0070.ANALYSIS_CODE_1)  AS �빺��Ա  ' + #13 +
            '  FROM         dbo.Data0068 LEFT OUTER JOIN        ' + #13 +
            '                        dbo.Data0005 ON dbo.Data0068.REQ_BY = dbo.Data0005.RKEY LEFT OUTER JOIN    ' + #13 +
            '                        dbo.Data0069 ON dbo.Data0068.RKEY = dbo.Data0069.PURCH_REQ_PTR RIGHT OUTER JOIN    ' + #13 +
            '                        dbo.Data0071 INNER JOIN        ' + #13 +
            '                        dbo.Data0070 ON dbo.Data0071.PO_PTR = dbo.Data0070.RKEY INNER JOIN    ' + #13 +
            '                        dbo.Data0023 ON dbo.Data0070.SUPPLIER_POINTER = dbo.Data0023.RKEY INNER JOIN    ' + #13 +
            '                        dbo.Data0002 ON dbo.Data0071.PURCHASE_UNIT_PTR = dbo.Data0002.RKEY ON dbo.Data0069.RKEY = dbo.Data0071.rkey69  ' + #13 +
            '  WHERE     (dbo.Data0070.STATUS = 5) AND (dbo.Data0071.QUAN_ORD - dbo.Data0071.QUAN_RECD + dbo.Data0071.QUAN_RETN > 0)   ' + #13 +
            '     and  (dbo.Data0071.INVT_PTR = ' + ARkey + ')' ;
    end;
    3:
    begin
      LSql:='SELECT TOP 50 Data0001.CURR_NAME AS ����, dbo.Data0023.ABBR_NAME AS ��Ӧ��  ' + #13 +
            '      , Data0071.QUAN_ORD AS ����, dbo.Data0071.PRICE AS �۸�    ' + #13 +
            '      , Data0071.REQ_DATE AS ��������, dbo.Data0002.UNIT_NAME AS ��λ   ' + #13 +
            '      , data0071.tax_price As ��˰��,data0071.extra_req AS ����Ҫ��   ' + #13 +
            '      , data0071.tax_2 AS [˰��%],data0071.QUAN_RECD AS �������    ' + #13 +
            '      , data0071.reason as �빺ԭ��    ' + #13 +
            '  FROM   Data0071 INNER JOIN    ' + #13 +
            '       data0070	on data0071.PO_PTR=data0070.rkey inner join    ' + #13 +
            '         Data0023 ON dbo.Data0070.SUPPLIER_POINTER = dbo.Data0023.RKEY INNER JOIN   ' + #13 +
            '         Data0001 ON       ' + #13 +
            '         Data0070.CURRENCY_PTR = dbo.Data0001.RKEY INNER JOIN    ' + #13 +
            '         Data0002 ON dbo.Data0071.PURCHASE_UNIT_PTR = dbo.Data0002.RKEY    ' + #13 +
            '  WHERE data0070.STATUS in(5,6,7)    ' + #13 +
            '      and (dbo.Data0071.INVT_PTR = ' + ARkey + ')'  + #13 +
            '  ORDER BY  dbo.Data0071.REQ_DATE DESC ';
    end;
    4:
    begin
      LSql:= ' SELECT NP_CODE AS ���±�����,NOTE_PAD_LINE_1 AS ����1,NOTE_PAD_LINE_2 AS ����2   ' + #13 +
             '   ,NOTE_PAD_LINE_3 AS ����3,NOTE_PAD_LINE_4 AS ����4    ' + #13 +
             '  FROM data0013 order by np_code  ';
    end;
    5:
    begin
      LSql:= ' SELECT dbo.Data0023.ABBR_NAME AS ��Ӧ��,dbo.Data0001.CURR_NAME AS ����    ' + #13 +
             '       , dbo.Data0028.PRICE_1 AS �۸�, dbo.Data0028.TAX_2 AS ˰��   ' + #13 +
             '       , data0028.tax_flag AS �۸�˰, dbo.Data0002.UNIT_NAME AS ��λ   ' + #13 +
             '       , dbo.Data0028.LEAD_TIME AS [����ʱ��(��)], dbo.Data0028.AVL_FLAG AS �ʸ��Ͽ�   ' + #13 +
             '   FROM dbo.Data0028 INNER JOIN      ' + #13 +
             '         dbo.Data0001 ON dbo.Data0028.CURRENCY_PTR = dbo.Data0001.RKEY INNER JOIN   ' + #13 +
             '         dbo.Data0002 ON       ' + #13 +
             '         dbo.Data0028.PURCHASE_UNIT_PTR = dbo.Data0002.RKEY INNER JOIN   ' + #13 +
             '         dbo.Data0023 ON dbo.Data0028.SUPPLIER_PTR = dbo.Data0023.RKEY   ' + #13 +
             '   WHERE data0028.INVENTORY_PTR = ' + ARkey;
    end;
  end;
  if not gSvrIntf.IntfGetDataBySql(LSql,cds1) then Exit;
end;

procedure TfrmComm_Mod29.InitCds;
var
  i:Integer;
begin
  for i := 0 to eh1.Columns.Count - 1 do
    eh1.Columns[i].Width := 80;
end;

end.
