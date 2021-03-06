unit WO_INFO;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, Grids, DBGrids, Menus, StdCtrls,AdoDB, ExtCtrls,
  Buttons, DB, DBGridEh;

type
  TfrmWO_INFO = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet6: TTabSheet;
    DBGrid3: TDBGrid;
    PopupMenu2: TPopupMenu;
    MenuItem1: TMenuItem;
    Memo1: TMemo;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    adsWO_INFO: TADODataSet;
    dsWO_INFO: TDataSource;
    DBGridEh1: TDBGridEh;
    DBGridEh4: TDBGridEh;
    DBGridEh2: TDBGridEh;
    TabSheet5: TTabSheet;
    DBGrid1: TDBGrid;
    procedure PageControl1Change(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    WO_Rkey,prod_rkey:integer;
  public
   parent_ptr:integer;
    procedure Enter(v_Wo_Rkey,v_Prod_rKey,wtype56:integer);
    { Public declarations }
  end;

var
  frmWO_INFO: TfrmWO_INFO;

implementation

uses PasDM,Route_Param;
{$R *.dfm}

procedure TfrmWO_INFO.PageControl1Change(Sender: TObject);
var
  sqlstr:string;
  AdoqryTmp:TAdoQuery;
begin
  sqlstr:='';
  adsWO_INFO.Close;
  
  DBGridEh1.DataSource:=nil ;
  DBGridEh2.DataSource:=nil ;
  DBGridEh4.DataSource:=nil ;
  case PageControl1.ActivePageIndex of
    0 :  begin
           Memo1.Clear;

           try
             sqlstr:= 'select t6.FLOW_NO,t6.PROJ_START_DATE,isnull(t5.employee_name,'''') as emp_name '+
                      'from Data0006 t6 left join data0005 t5 '+
                      'on t6.USER_PTR = t5.rkey where t6.RKEY='+IntToStr(WO_Rkey);
             AdoqryTmp:=TAdoQuery.Create(nil);
             with AdoqryTmp do
             begin
               Connection := dm.ADOConnection1;
               SQL.Clear;
               SQL.Add(sqlstr);
               Open;
               if FieldByName('FLOW_NO').AsInteger = 1 then  //拆分新增
               begin
                 Memo1.Lines.Add('=== 拆分新增于'+fieldbyname('PROJ_START_DATE').asstring+'   经由:'+fieldbyname('emp_name').asstring+' ===');
               end;
             end;
             sqlstr:= ' select data0117.*,data0005.employee_name from data0005,data0117 '+
                      ' where data0117.source_type>1 and data0117.source_ptr='+IntToStr(WO_Rkey)+
                      ' and data0117.empl_ptr=data0005.rkey';
             AdoqryTmp.Close;
             AdoqryTmp.SQL.Clear;
             AdoqryTmp.SQL.Add(sqlstr);
             AdoqryTmp.Open;
             AdoqryTmp.First;
             with AdoqryTmp do
             while not AdoqryTmp.Eof do begin
                case Fieldbyname('action').asinteger of
                0:   Memo1.Lines.Add('=== 从报废中创建于'+fieldbyname('tdate').asstring+'   经由:'+fieldbyname('employee_name').asstring+' ===');
                1:   Memo1.Lines.Add('=== 暂停生产于'+fieldbyname('tdate').asstring+'   经由:'+fieldbyname('employee_name').asstring+' ===');
                2:   Memo1.Lines.Add('=== 恢复生产于'+fieldbyname('tdate').asstring+'   经由:'+fieldbyname('employee_name').asstring+' ===');
                3:   Memo1.Lines.Add('=== 取消作业单于'+fieldbyname('tdate').asstring+'   经由:'+fieldbyname('employee_name').asstring+' ===');
                4:   Memo1.Lines.Add('=== 恢复作业单于'+fieldbyname('tdate').asstring+'   经由:'+fieldbyname('employee_name').asstring+' ===');
                5:   Memo1.Lines.Add('=== 作业单变返工'+fieldbyname('tdate').asstring+'   经由:'+fieldbyname('employee_name').asstring+' ===');
                6:   Memo1.Lines.Add('=== 数量分拆(尾数)于'+fieldbyname('tdate').asstring+'   经由:'+fieldbyname('employee_name').asstring+' ===');
                7:   Memo1.Lines.Add('=== 更改作业单于'+fieldbyname('tdate').asstring+'   经由:'+fieldbyname('employee_name').asstring+' ===');
                8:   Memo1.Lines.Add('===修改作业单数量于'+fieldbyname('tdate').asstring+'   经由:'+fieldbyname('employee_name').asstring+' ===');
                9:   Memo1.Lines.Add('=== 数量分拆(待返工)于'+fieldbyname('tdate').asstring+'   经由:'+fieldbyname('employee_name').asstring+' ===');
                10:  Memo1.Lines.Add('=== 数量分拆(待报废)于'+fieldbyname('tdate').asstring+'   经由:'+fieldbyname('employee_name').asstring+' ===');
                11:  Memo1.Lines.Add('=== 作业单申请返工于'+fieldbyname('tdate').asstring+'   经由:'+fieldbyname('employee_name').asstring+' ===');
                12:  Memo1.Lines.Add('=== 作业单申请报废于'+fieldbyname('tdate').asstring+'   经由:'+fieldbyname('employee_name').asstring+' ===');
                13:  Memo1.Lines.Add('=== MRB鉴定返工确认于'+fieldbyname('tdate').asstring+'   经由:'+fieldbyname('employee_name').asstring+' ===');
                14:  Memo1.Lines.Add('=== MRB鉴定报废确认于'+fieldbyname('tdate').asstring+'   经由:'+fieldbyname('employee_name').asstring+' ===');
                15:  Memo1.Lines.Add('=== MRB鉴定退回于'+fieldbyname('tdate').asstring+'   经由:'+fieldbyname('employee_name').asstring+' ===');

                end;
                if trim(fieldbyname('remark').asstring)<>'' then
                  Memo1.Lines.Add(fieldbyname('remark').asstring);
                next;
             end;
           finally
             AdoqryTmp.Close;
             AdoqryTmp.Free;
           end;
         end;
    1 :begin
         sqlstr:=
'SELECT TOP 100 PERCENT dbo.Data0039.REJECT_DESCRIPTION, dbo.Data0034.DEPT_NAME, d34.DEPT_NAME AS resp_dept_name, '+
 'dbo.Data0058.QTY_REJECT, dbo.Data0058.PANELS, dbo.Data0058.TDATETIME, dbo.Data0039.REJ_CODE,data0005.EMPLOYEE_NAME '+
 'FROM dbo.Data0058 INNER JOIN '+
  'dbo.Data0034 AS d34 ON dbo.Data0058.RESP_DEPT_PTR = d34.RKEY INNER JOIN '+
  'dbo.Data0039 ON dbo.Data0039.RKEY = dbo.Data0058.REJECT_PTR INNER JOIN '+
  'dbo.Data0034 ON dbo.Data0058.DEPT_PTR = dbo.Data0034.RKEY INNER JOIN '+
  'data0005 on data0058.EMPL_PTR=data0005.rkey '+
'WHERE (dbo.Data0058.TTYPE <> 2) AND '+
'(dbo.Data0058.WO_PTR ='+IntToStr(WO_Rkey)+') '+
'ORDER BY dbo.Data0058.TDATETIME';

{' select data0039.reject_description,data0034.dept_name,'+
      ' a.dept_name as resp_dept_name,data0058.qty_reject,data0058.panels,tdatetime '+
      ' from data0039,data0034,data0058 left outer join data0034 a '+
      ' on data0058.resp_dept_ptr=a.rkey where data0058.reject_ptr=data0039.rkey '+
      ' and data0058.dept_ptr=data0034.rkey and data0058.wo_ptr='+IntToStr(WO_Rkey);
}
         DBGridEh1.DataSource:=dsWO_INFO;
      end;
    2 : begin
           sqlstr:=' SELECT Data0006.WORK_ORDER_NUMBER,Data0048.INTIME,Data0048.OUTTIME,data0034.dept_name as dptname,'+
                ' Data0048.QTY_PROD,Data0048.QTY_REJECT,Data0048.panels,data0005.employee_name,data0048.step_no,data0048.ACTION_REF, '+
                ' (case when data0048.wtype=0 then ''正常'' when data0048.wtype=2 then ''返工'' when data0048.wtype=3 then ''外发'' end) wtype '+
                ' FROM Data0006 inner join Data0048 on Data0048.WO_PTR=Data0006.RKEY left outer join data0005 on data0048.empl_ptr=data0005.rkey '+
                ' left outer join Data0034 ON Data0048.FM_dept_PTR=Data0034.RKEY WHERE data0048.wo_ptr= '+IntToStr(WO_Rkey)+' ORDER BY DATA0048.STEP_NO,DATA0048.INTIME';
          DBGridEh2.DataSource:=dsWO_INFO;
        end;
    3 :begin
         sqlstr:=' select data0038.rkey,data0038.def_ROUT_inst,step_number,data0038.def_rout_inst,data0034.dept_code, '+
                ' data0034.dept_name,data0034.barcode_entry_flag from data0038,data0034 '+
                ' where data0038.source_ptr='+IntToStr(prod_rkey)+' and data0038.dept_ptr=data0034.rkey order by data0038.step_number ';
         DBGrid3.DataSource:=dsWO_INFO;
       end;
    4 :begin
         sqlstr:=' select data0238.rkey,data0238.def_ROUT_inst,step_number,data0238.def_rout_inst,data0034.dept_code, '+
                ' data0034.dept_name,data0034.barcode_entry_flag,data0238.Old_Step_NO from data0238,data0034 '+
                ' where data0238.WO_PTR='+IntToStr(WO_Rkey)+' and data0238.dept_ptr=data0034.rkey order by data0238.step_number ';
         DBGrid3.DataSource:=dsWO_INFO;
       end;
    5 :begin
        if parent_ptr=0 then
         sqlstr:=' SELECT  D06.WORK_ORDER_NUMBER,D53.quantity, D53.mfg_date,D15.abbr_name as Warehouse_name, '+
                 '(case when d53.rma_ptr=0 then ''正常过数入仓'' '+
                      'when d53.rma_ptr=1 then ''退货重检入仓'' '+
                      'when d53.rma_ptr=2 then ''返修重检入仓'' '+
                      'when d53.rma_ptr=3 then ''直接入仓'' '+
                      'when d53.rma_ptr=4 then ''委外加工入仓'' '+
                      'when d53.rma_ptr=5 then ''委外加工退货入仓'' '+
                      'when d53.rma_ptr=6 then ''销售退货入仓'' '+
                      'when d53.rma_ptr=7 then ''转换入仓'' '+
                      'when d53.rma_ptr=8 then ''盘点入仓'' end) as inType '+
                ' FROM Data0006 D06 , data0053 D53,Data0015 D15 WHERE D53.WORK_ORDER_PTR=D06.RKEY and D15.rKey=D53.WHSE_Ptr '+
                ' AND D06.RKEY='+IntToStr(WO_Rkey)+' ORDER BY D53.MFG_DATE '
        else
         sqlstr:=
          'SELECT TOP 100 PERCENT dbo.Data0006.WORK_ORDER_NUMBER, dbo.Data0489.TDATE as mfg_date, '+
              'dbo.Data0489.QTY as quantity, dbo.Data0005.EMPLOYEE_NAME as inType, '+
              'dbo.Data0015.ABBR_NAME AS warehouse_name '+
          'FROM    dbo.Data0489 INNER JOIN '+
              'dbo.Data0006 ON dbo.Data0489.WO_PTR = dbo.Data0006.RKEY INNER JOIN '+
              'dbo.data0492 ON dbo.Data0006.CUT_NO = dbo.data0492.CUT_NO INNER JOIN '+
              'dbo.Data0015 ON dbo.data0492.WHOUSE_PTR = dbo.Data0015.RKEY LEFT OUTER JOIN '+
              'dbo.Data0005 ON dbo.Data0489.user_ptr = dbo.Data0005.RKEY '+
           'where data0489.source_ptr='+IntToStr(WO_Rkey)+' '+
           'ORDER BY MFG_DATE';
         DBGridEh4.DataSource:=dsWO_INFO;
       end;
  end;
  if PageControl1.ActivePageIndex>0 then
  begin
    adsWO_INFO.CommandText := sqlstr;
    adsWO_INFO.Open;
  end;
end;

procedure TfrmWO_INFO.MenuItem1Click(Sender: TObject);
begin
  with TFrmRoutParam.Create(Application) do
  try
    InitForm(adsWO_INFO.fieldByName('rkey').Value,adsWO_INFO.fieldByName('def_ROUT_inst').value);
    ShowModal;
  finally
    free;
  end;
end;

procedure TfrmWO_INFO.Enter(v_Wo_Rkey, v_Prod_rKey, wtype56: integer);
begin
  WO_Rkey:=v_WO_Rkey;
  prod_rkey:=v_prod_rkey;
  PageControl1.ActivePageIndex := 0;
  PageControl1Change(nil);
  if wtype56 = 0 then
    PageControl1.Pages[4].TabVisible:= False
  else
    PageControl1.Pages[4].TabVisible:= True;
  ShowModal;
end;

procedure TfrmWO_INFO.BitBtn1Click(Sender: TObject);
begin
  close;
end;

procedure TfrmWO_INFO.FormActivate(Sender: TObject);
begin
if self.parent_ptr>0 then
 dbgrideh4.Columns[3].Title.caption:='分配人员';
end;

end.
