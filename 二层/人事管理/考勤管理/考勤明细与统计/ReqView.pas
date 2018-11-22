unit ReqView;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, DMFrm, DB, ADODB, 
  DBGridEh, Buttons, ComCtrls, Menus, Grids;

type
  TfrmReqView = class(TForm)
    pnl1: TPanel;
    pnl2: TPanel;
    lbl1: TLabel;
    dtp1: TDateTimePicker;
    lbl2: TLabel;
    dtp2: TDateTimePicker;
    edtGX: TLabeledEdit;
    cbxType: TComboBox;
    btnSearch: TSpeedButton;
    dbgrd1: TDBGridEh;
    ds1: TDataSource;
    dsReqView: TADODataSet;
    btnHZ: TSpeedButton;
    dbgrd2: TDBGridEh;
    qrySum: TADOQuery;
    ds2: TDataSource;
    pm1: TPopupMenu;
    Excel1: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure btnSearchClick(Sender: TObject);
    procedure dbgrd1TitleClick(Column: TColumnEh);
    procedure btnHZClick(Sender: TObject);
    procedure Excel1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;


  function ShowReqView(AOwner: TComponent): Integer;

implementation

uses
  DateUtils, WZ_gUnit;

{$R *.dfm}

function ShowReqView(AOwner: TComponent): Integer;
begin
  with TfrmReqView.Create(AOwner) do
  begin
    try
      Result := ShowModal;
    finally
      Free;
    end;
  end;
end;


procedure TfrmReqView.btnHZClick(Sender: TObject);
var
  LSql: string;
begin
  if dsReqView.Active then dsReqView.Close;
  if qrySum.Active then qrySum.Close;
  dbgrd1.Visible := False;
  dbgrd2.Visible := True;
  LSql := ' SELECT t.departmentname as ����,COUNT(t.employeecode) AS ����, t.employeecode AS ����, t.chinesename AS ����,' +
          ' (case t.reqtype when 0 then ''����'' when 1 then ''���'' when 2 then ''�޸Ĺ�ʱ'' end ) as ���� ' +
          ' from(SELECT  depart.departmentname,d2.employeecode, d2.chinesename, d1.reqtype ' +
          ' FROM Req d1 INNER JOIN employeemsg d2 ON d1.employeeid = d2.rkey  ' +
          ' INNER JOIN datadepartment depart ON d2.departmentid = depart.RKey  ' ;
  if cbxType.ItemIndex in [0,2] then
    LSql := LSql + ' WHERE d1.req_cardtime BETWEEN ' + QuotedStr(WZ_gUnit.gDateTimeToStr(DateOf(dtp1.Time))) + ' AND ' + QuotedStr(WZ_gUnit.gDateTimeToStr(IncSecond(IncDay(DateOf(dtp2.Time)),-1))) + ' AND d1.reqtype= ' + IntToStr(cbxType.ItemIndex)
  else
    LSql := LSql + ' WHERE d1.req_cardtime BETWEEN ' + QuotedStr(WZ_gUnit.gDateTimeToStr(DateOf(dtp1.Time))) + ' AND ' + QuotedStr(WZ_gUnit.gDateTimeToStr(IncSecond(IncDay(DateOf(dtp2.Time)),-1))) + ' AND d1.reqtype= ' + IntToStr(cbxType.ItemIndex);
  LSql := LSql + ' AND D1.ReqState = 2 ' +
          ' ) t GROUP BY t.employeecode,t.chinesename,t.reqtype,t.departmentname ';
  if Length(Trim(edtGX.Text)) > 0 then
    LSql := LSql + ' HAVING t.employeecode=' + QuotedStr(edtGX.Text);

  qrySum.Close;
  qrySum.Connection := DM1.con1;
  qrySum.SQL.Clear;
  qrySum.SQL.Add(LSql);
  qrySum.Open;
end;

procedure TfrmReqView.btnSearchClick(Sender: TObject);
var
  s: string;
begin
  if dsReqView.Active then dsReqView.Close;
  if qrySum.Active then qrySum.Close;
  dbgrd1.Visible := True;
  dbgrd2.Visible := False;
  try
    s := 'SELECT  depart.departmentname as ����,d2.employeecode as ����, d2.chinesename as ����,   (case reqstate when 0 then ''δ�ύ'' when 1 then ''���ύ'' when 2 then ''�����'' when 3 then ''�˻�'' end) as ״̬,';
    s := s + ' reqinfo as ��ע, reqperson as �ύ��, reqtime as �ύʱ��, (case reqtype when 0 then ''����'' when 1 then ''���'' when 2 then ''�޸Ĺ�ʱ'' end ) as ����, req_cardtime as ʱ��, req_starttime as ʼ,';
    s := s + ' req_endtime as ��, zbhour as ����, jbhour as �Ӱ�, dealperson as ������, dealtime as ����ʱ�� FROM Req d1 INNER JOIN employeemsg d2 ON d1.employeeid = d2.rkey ';
    s := s + ' INNER JOIN datadepartment depart ON d2.departmentid = depart.RKey  ';
    if cbxType.ItemIndex in [0,2] then
      s := s + ' WHERE req_cardtime BETWEEN :FBeginTime  AND :FEndTime  AND ReqState = :FReqState AND reqtype = :FReqType'
    else
      s := s + ' WHERE Reqtime BETWEEN :FBeginTime  AND :FEndTime AND ReqState = :FReqState AND reqtype = :FReqType' ;
    if Length(Trim(edtGX.Text)) > 0 then s := s + ' AND d2.employeecode = ' + edtGX.Text;
    dsReqView.CommandText := s;
    dsReqView.Parameters.ParamValues['FBeginTIme'] := DateOf(dtp1.Time);
    dsReqView.Parameters.ParamValues['FEndTime'] := IncSecond(IncDay(DateOf(dtp2.Time),1),-1);
    dsReqView.Parameters.ParamValues['FReqState'] := 2;
    dsReqView.Parameters.ParamValues['FReqType'] := cbxType.ItemIndex;
    dsReqView.Open;
  except
  end;
end;

procedure TfrmReqView.dbgrd1TitleClick(Column: TColumnEh);
begin
  if not Column.Field.DataSet.IsEmpty then
  begin
    if Column.Title.SortMarker = smDownEh then
    begin
      TCustomAdoDataSet(Column.Field.DataSet).Sort :=Column.Field.FieldName+' ASC';
      Column.Title.SortMarker := smUpEh;
    end
    else if Column.Title.SortMarker = smUpEh then
    begin
      TCustomAdoDataSet(Column.Field.DataSet).Sort :='';
      Column.Title.SortMarker := smNoneEh;
    end
    else if Column.Title.SortMarker = smNoneEh then
    begin
      TCustomAdoDataSet(Column.Field.DataSet).Sort :=Column.Field.FieldName+' DESC';
      Column.Title.SortMarker := smDownEh;
    end;
  end;
end;

procedure TfrmReqView.Excel1Click(Sender: TObject);
begin
  if ds1.DataSet.Active then
    WZ_gUnit.Export_dbGridEH_to_Excel(dbgrd1,'')
  else
    WZ_gUnit.Export_dbGridEH_to_Excel(dbgrd2,'');
end;

procedure TfrmReqView.FormShow(Sender: TObject);
begin
  dtp1.DateTime := IncDay(Now,-2);
  dtp2.DateTime := Now;
end;

end.
