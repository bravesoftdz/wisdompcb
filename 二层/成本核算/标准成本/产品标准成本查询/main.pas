unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Grids, StdCtrls, Buttons, DB, ADODB,DateUtils,Math;
type
 TExcludeColumns = set of 0..255;

type
  TfrmMain = class(TForm)
    Panel1: TPanel;
    StringGrid1: TStringGrid;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn4: TBitBtn;
    ADOConnection1: TADOConnection;
    adsMain: TADODataSet;
    adsDept: TADODataSet;
    adsProdCost: TADODataSet;
    AQTMP: TADOQuery;
    CheckBox1: TCheckBox;
    adsMoreInfo: TADODataSet;
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure StringGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CheckBox1Click(Sender: TObject);
  private
    UnitType,layer_type:byte;
    Total_row,Total_All:double;
    FaWidth:array[0..79] of integer;
    procedure DoSearch(subSql:string);//ִ�в�ѯ
    procedure InitGridTitle;//��ʾStringGrid�ı���
    procedure SetOptimalGridCellWidth(sg: TStringGrid;
     ExcludeColumns: TExcludeColumns);
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation
uses common,QuerySet;
{$R *.dfm}

procedure TfrmMain.SetOptimalGridCellWidth(sg: TStringGrid;
  ExcludeColumns: TExcludeColumns);
 var
  i : Integer;
  j : Integer;
  max_width : Integer;
begin
with sg do
 begin
  Canvas.Font.Assign(Font);
  for i := 0 to (ColCount - 1) do
  begin
   if i in ExcludeColumns then Continue;
   max_width := 0;
   for j := 0 to (RowCount - 1) do
    max_width := Math.Max(max_width,Canvas.TextWidth(Cells[i,j]));
   if max_width > 0 then
    ColWidths[i] := max_width + 4
   else
    ColWidths[i] := DefaultColWidth;
  end; { for }
 end;
end;

procedure TfrmMain.BitBtn2Click(Sender: TObject);
begin
  if StringGrid1.Rowcount<=3 then exit;
  Export_Grid_to_Excel(StringGrid1,'��Ʒ�ɱ���ѯ')
end;

procedure TfrmMain.BitBtn1Click(Sender: TObject);
begin
 application.Terminate;
end;

procedure TfrmMain.DoSearch(subSql: string);
  procedure ReClearGrid;
  var i:integer;
  begin
    for i:=0 to StringGrid1.ColCount-1 do
     StringGrid1.Cells[i,2]:='';
  end;

var
  sql1,sqlstr,topsql:string;
  i,j:integer;
  sql2: string;
  ltmp,ltmp2: Double;
  ltmpstr: string;
begin
  if subsql='' then
  begin
    if StringGrid1.RowCount > 2 then
    begin
      StringGrid1.RowCount:=3;
      ReClearGrid;
    end;
    exit;
  end;
  InitGridTitle;
//1.����������Ҫͳ�ƵĲ�Ʒ
//2���г���Ʒ�Ĺ���
//3��ͳ��ÿ����Ʒ��������ĳɱ����ݣ�data0460

//��ȡ����Ʒ
  sql1:=' SELECT D25.RKEY FROM Data0025 D25 INNER JOIN '+
        ' Data0060 D60 ON D25.RKEY = D60.CUST_PART_PTR INNER JOIN '+
        ' Data0064 D64 ON D60.RKEY = D64.SO_PTR INNER JOIN'+
        ' Data0008 D08 ON D25.PROD_CODE_PTR = D08.RKEY INNER JOIN'+
        ' Data0010 D10 ON D25.CUSTOMER_PTR = D10.RKEY '+ subsql+ //�����Ӿ�
        ' GROUP BY D25.RKEY ';
  topsql:= sql1;        // ����25��Ʒ
     {   ' GROUP BY D25.RKEY ,D25.MANU_PART_NUMBER, D25.MANU_PART_DESC, D10.CUST_CODE,'+
        ' D10.ABBR_NAME, D08.PROD_CODE, D08.PRODUCT_NAME,  D25.ttype ';
      }

  if layer_type=1 then //��ѯ�ѳ������ڲ㲿����Ϣ
   begin
    sqlstr:='SELECT D025.MANU_PART_NUMBER,D025.MANU_PART_DESC,D010.CUST_CODE,'+ //�ڶ���
            'D010.ABBR_NAME, D008.PROD_CODE, D008.PRODUCT_NAME, D025.RKEY,'+
            'D025.ttype,D025.unit_sq,D025.EST_SCRAP '+
            'FROM Data0025 D025 inner join'+
            ' Data0008 D008 ON D025.PROD_CODE_PTR = D008.RKEY INNER JOIN'+
            ' Data0010 D010 ON D025.CUSTOMER_PTR = D010.RKEY'+
            //' left join tmp2 on tmp2.manu_part_number = D025.MANU_PART_NUMBER ' +
            ' where  d025.parent_ptr in ('+topsql+')'+
            ' GROUP BY D025.MANU_PART_NUMBER, D025.MANU_PART_DESC, D010.CUST_CODE,'+
            ' D010.ABBR_NAME, D008.PROD_CODE, D008.PRODUCT_NAME, D025.RKEY , '+
            'D025.ttype,D025.unit_sq, D025.EST_SCRAP';
    sqlstr:= sqlstr+#13+
    'union all'+#13+                                                    //���ϵ������Ʒ
    'SELECT D025.MANU_PART_NUMBER,D025.MANU_PART_DESC,D010.CUST_CODE,'+
            'D010.ABBR_NAME, D008.PROD_CODE, D008.PRODUCT_NAME, D025.RKEY,'+
            'D025.ttype,D025.unit_sq,D025.EST_SCRAP'+
            ' FROM Data0025 D025 inner join'+
            ' Data0008 D008 ON D025.PROD_CODE_PTR = D008.RKEY INNER JOIN'+
            ' Data0010 D010 ON D025.CUSTOMER_PTR = D010.RKEY inner join'+
            ' data0025 d025_1 on D025.parent_ptr=d025_1.rkey'+
            //' left join tmp2 on tmp2.manu_part_number = D025.MANU_PART_NUMBER ' +
            ' where  d025_1.parent_ptr in ('+topsql+')'+
            ' GROUP BY D025.MANU_PART_NUMBER, D025.MANU_PART_DESC, D010.CUST_CODE,'+
            ' D010.ABBR_NAME, D008.PROD_CODE, D008.PRODUCT_NAME, D025.RKEY,'+
            ' D025.ttype,D025.unit_sq, D025.EST_SCRAP  order by D025.MANU_PART_NUMBER ';

   sql1:='select rkey from data0025 d025 where parent_ptr in ('+sql1+')'; //�ڶ���
    sql1:= sql1+#13+              //���ϵ������Ʒ
    'union all'+#13+
    'SELECT   Data0025.RKEY'+#13+
    'FROM   dbo.Data0025 INNER JOIN'+#13+
    ' dbo.Data0025 AS Data0025_1 ON dbo.Data0025.PARENT_PTR = Data0025_1.RKEY'+#13+
    ' where Data0025_1.parent_ptr in ('+topsql+')';

   end
  else //��ѯ�ѳ�������㲿����Ϣ
    sqlstr:='SELECT D25.MANU_PART_NUMBER,D25.MANU_PART_DESC,D10.CUST_CODE,'+
            'D10.ABBR_NAME, D08.PROD_CODE, D08.PRODUCT_NAME, D25.RKEY,'+
            'D25.ttype,D25.unit_sq,D25.EST_SCRAP,SUM(D64.QUAN_SHIPPED) AS total_qty,'+
            'ROUND(SUM(D64.QUAN_SHIPPED * D25.unit_sq), 3) AS total_sqft,'+
            'ROUND(SUM(D64.QUAN_SHIPPED * D60.PARTS_ALLOC / D60.EXCH_RATE), 2) AS total_money,'+
            //'substring(max(convert(varchar,d85.qte_date,112)+convert(varchar,d85.markup)),9,7) as discount '+
            ' max(d85.rate_margin) as discount, ' +
            //' max(d85.rate_margin) as maolilv2 ' +
            ' max((d85.quote_taxprice - d85.total_cost) / d85.quote_taxprice * 100) as maolilv2 ' +
            ' FROM dbo.Data0025 D25 INNER JOIN '+
            ' Data0060 D60 ON D25.RKEY = D60.CUST_PART_PTR INNER JOIN '+
            ' Data0064 D64 ON D60.RKEY = D64.SO_PTR INNER JOIN'+
            ' Data0008 D08 ON D25.PROD_CODE_PTR = D08.RKEY INNER JOIN'+
            ' Data0010 D10 ON D25.CUSTOMER_PTR = D10.RKEY LEFT JOIN '+
            ' Data0085 D85 ON D60.QTE_PTR=D85.RKEY ' +#13+subsql+  //�����Ӿ�
            //' left join tmp2 on tmp2.manu_part_number = d25.MANU_PART_NUMBER '
            ' GROUP BY D25.MANU_PART_NUMBER, D25.MANU_PART_DESC, D10.CUST_CODE,'+
            ' D10.ABBR_NAME, D08.PROD_CODE, D08.PRODUCT_NAME, D25.RKEY , '+
            ' D25.ttype,D25.unit_sq, D25.EST_SCRAP '+//,d85.rate_margin '+
            //' tmp2.TUSAGE,tmp2.outare,tmp2.outprice,tmp2.gys ' +
            ' ORDER BY D25.MANU_PART_NUMBER ';

//    sql2 := ';with tmp1 as ' +
//            '(' +
//            ' select d25.manu_part_number,max(d207.rkey) as rkey207, max(d207.tdate)as date207 from data0207 d207 ' +
//            ' inner join data0468 d468 on d207.D0468_PTR = d468.rkey ' +
//            ' inner join data0060 d60 on d468.SO_NO = d60.SALES_ORDER ' +
//            ' inner join data0025 d25 on d25.rkey = d60.CUST_PART_PTR ' +
//            //where (d207.TDATE >= QuotedStr(formatdatetime('yyyy-mm-dd',DTPD1.Date)) AND (d207.TDATE <= '2014-02-17 23:59:00')
//            ' group by d25.manu_part_number), ' +
//            ' tmp2 as ( ' +
//            ' select d207.rkey,d25.manu_part_number, d25.TUSAGE, d17.INV_DESCRIPTION/*���*/, ' +
//            ' d468.QUAN_ISSUED*d17.STOCK_SELL as outare/*�������*/, ' +
//            ' d207.QUANTITY*d22.PRICE*d456.exch_rate as outprice/*���Ž��*/, ' +
//            ' d23.ABBR_NAME + d22.SUPPLIER2 as gys/*��Ӧ��*/ ' +
//            ' from data0207 d207 ' +
//            ' inner join tmp1 on d207.rkey = tmp1.rkey207 ' +
//            ' inner join data0468 d468 on d207.D0468_PTR = d468.rkey ' +
//            ' inner join data0492 d492 on d492.CUT_NO = d468.CUT_NO ' +
//            ' inner join data0025 d25 on d25.rkey = d492.BOM_PTR ' +
//            ' inner join data0022 d22 on d207.D0022_PTR = d22.rkey ' +
//            ' inner join data0456 d456 on d22.GRN_PTR = d456.rkey ' +
//            ' inner join data0023 d23 on d456.SUPP_PTR = d23.rkey ' +
//            ' inner join data0017 d17 on d207.INVENTORY_PTR = d17.rkey ' +
//            //where (d207.TDATE >= '2013-12-19 00:00:00') AND (d207.TDATE <= '2014-02-17 23:59:00')
//            ' ) ';

  adsMain.close;
  adsMain.CommandText:=sqlstr;      //1.��ò�Ʒ�б�
  adsMain.Prepared;
  adsMain.open;
  //���û�в�Ʒ����ô���StringGrid����
  if adsMain.IsEmpty then
  begin
    if StringGrid1.RowCount > 2 then
    begin
     StringGrid1.RowCount:=3;
     ReClearGrid;
    end;
    exit;
  end;

  //2.��ù����б�group by��ز�Ʒ��460����
  sqlstr:= ' select D.*,data0034.dept_code,data0034.dept_name,data0034.seq_nr from ('+
           ' select dept_ptr from data0460 where bom_ptr in ('+sql1+')'+
           ' group by data0460.dept_ptr) D inner join data0034 on D.dept_ptr=data0034.rkey'+
           ' where data0034.is_cost_dept=1 order by data0034.seq_nr ';
  adsDept.Close;
  adsDept.CommandText:=sqlstr;
  adsDept.Prepared;
  adsDept.Open;
  if layer_type=0 then //���
  begin
    StringGrid1.ColCount := 20 + adsDept.RecordCount;
    StringGrid1.Cells[7,1] := '����������';
    StringGrid1.Cells[StringGrid1.ColCount-7-5,1]:='������';
    StringGrid1.Cells[StringGrid1.ColCount-6-5,1]:='���ϳɱ�';
    StringGrid1.Cells[StringGrid1.ColCount-5-5,1]:='С��';
    StringGrid1.Cells[StringGrid1.ColCount-4-5,1]:='��������';
    StringGrid1.Cells[StringGrid1.ColCount-3-5,1]:='�������';
    StringGrid1.Cells[StringGrid1.ColCount-2-5,1]:='���۽��';
    StringGrid1.Cells[StringGrid1.ColCount-1-5,1]:='����ë����';
    StringGrid1.Cells[StringGrid1.ColCount-1-4,1]:='��׼�ɱ�ë����';
    StringGrid1.Cells[StringGrid1.ColCount-4,1]:='��Ӧ��';
    StringGrid1.Cells[StringGrid1.ColCount-3,1]:='���Ϲ��';
    StringGrid1.Cells[StringGrid1.ColCount-2,1]:='���Ž��';
    StringGrid1.Cells[StringGrid1.ColCount-1,1]:='�������';
    
  end
  else begin //�ڲ�
    StringGrid1.Cells[7,1] := '����������';
    StringGrid1.ColCount := 15 + adsDept.RecordCount;
    StringGrid1.Cells[StringGrid1.ColCount-3-4,1]:='������';
    StringGrid1.Cells[StringGrid1.ColCount-2-4,1]:='���ϳɱ�';
    StringGrid1.Cells[StringGrid1.ColCount-1-4,1]:='С��';
    StringGrid1.Cells[StringGrid1.ColCount-4,1]:='��Ӧ��';
    StringGrid1.Cells[StringGrid1.ColCount-3,1]:='���Ϲ��';
    StringGrid1.Cells[StringGrid1.ColCount-2,1]:='���Ž��';
    StringGrid1.Cells[StringGrid1.ColCount-1,1]:='�������';
  end;
  //���ع�����Ϣ��StringGrid��

   for i:=0 to StringGrid1.ColCount-1 do
    FaWidth[i] :=StringGrid1.ColWidths[i];

  while not adsDept.eof do begin
    StringGrid1.Cells[7+ adsDept.RecNo,0]:=adsDept.FieldByName('Dept_Code').AsString;
    StringGrid1.Cells[7+ adsDept.RecNo,1]:=adsDept.FieldByName('Dept_Name').AsString;
    adsDept.next;
  end;

  //3.��ȡ��Ʒ�ĳɱ�����
  sqlstr:= ' select Bom_ptr,dept_ptr,sum(IsNUll(MATL_PER_SQFT_1,0) + '+
      'IsNULL(MATL_PER_SQFT_2,0) +IsNULL(Sub_Producing_Cost,0) + '+
      'IsNULL(Sub_Matl_Cost,0) +  IsNULL(ProducingCost,0)) as Total'+
      ' from data0460 where bom_ptr in('+ sql1+')'+
      ' group by Bom_ptr,dept_ptr';

  adsProdCost.Close;
  adsProdCost.CommandText := sqlstr;
  adsProdCost.Prepared;
  adsProdCost.Open;
  //ͳ�ƽ��д��StringGrid
  StringGrid1.RowCount:=3+ adsMain.RecordCount;//3����Ԥ�����У�2�б��⣬1�л���
  Total_All:=0;
  for i:=2 to adsMain.RecordCount+1 do    //2���������
  begin
    StringGrid1.Rows[i].Clear;  //���Grid����
    StringGrid1.Cells[0,i]:= adsmain.fieldbyName('MANU_PART_NUMBER').AsString;
    StringGrid1.Cells[1,i]:= adsmain.fieldbyName('MANU_PART_DESC').AsString;
    StringGrid1.Cells[2,i]:= adsmain.fieldbyName('CUST_CODE').AsString;
    StringGrid1.Cells[3,i]:= adsmain.fieldbyName('ABBR_NAME').AsString;
    StringGrid1.Cells[4,i]:= adsmain.fieldbyName('PROD_CODE').AsString;
    StringGrid1.Cells[5,i]:= adsmain.fieldbyName('PRODUCT_NAME').AsString;
    if adsMoreInfo.Locate('manu_part_number',adsMain.fieldbyname('MANU_PART_NUMBER').AsString,[]) then
    begin
      StringGrid1.Cells[7,i]:= adsMoreInfo.fieldbyName('TUSAGE').AsString;
      StringGrid1.Cells[StringGrid1.ColCount-4,i]:=adsMoreInfo.fieldbyName('gys').AsString;//'��Ӧ��';
      StringGrid1.Cells[StringGrid1.ColCount-3,i]:=adsMoreInfo.fieldbyName('INV_DESCRIPTION').AsString;//'���Ϲ��';
      StringGrid1.Cells[StringGrid1.ColCount-2,i]:=adsMoreInfo.fieldbyName('outprice').AsString;//'���Ž��';
      StringGrid1.Cells[StringGrid1.ColCount-1,i]:=adsMoreInfo.fieldbyName('outare').AsString;//'�������';
    end;
    if layer_type=0 then
    begin
      StringGrid1.Cells[StringGrid1.ColCount-7-5 ,i]:= adsmain.fieldbyName('EST_SCRAP').AsString+'%';
      StringGrid1.Cells[StringGrid1.ColCount-4-5 ,i]:= adsmain.fieldbyName('total_qty').AsString;
      StringGrid1.Cells[StringGrid1.ColCount-3-5 ,i]:= adsmain.fieldbyName('total_sqft').AsString;
      StringGrid1.Cells[StringGrid1.ColCount-2-5 ,i]:= adsmain.fieldbyName('total_money').AsString;
      StringGrid1.Cells[StringGrid1.ColCount-1-5 ,i]:= adsmain.fieldbyName('discount').AsString + '%';
    end
    else StringGrid1.Cells[StringGrid1.ColCount-3-4 ,i]:= adsmain.fieldbyName('EST_SCRAP').AsString+'%';

    if adsmain.fieldbyName('ttype').asinteger = 0 then
      StringGrid1.Cells[6,i]:= '����'
    else StringGrid1.Cells[6,i]:= '����';
    //���ݲ�Ʒָ�������ˣ���ȡĳ��Ʒ�ĸ�������ĳɱ�����
    adsProdCost.Filter:='bom_ptr='+adsmain.fieldbyName('rKey').AsString;
    adsProdCost.Filtered:=true;
    Total_row:=0;
    ltmp2 := 0;
    ltmpstr := '';
    if adsProdCost.RecordCount>0 then
    begin
      for j:=1 to adsProdCost.RecordCount do
      begin
      //�ڹ����б��в�����Ӧ�Ĺ���������ҵ�����ô��д��SgringGrid
        if adsDept.Locate('Dept_ptr',adsProdCost.fieldbyName('dept_ptr').Value,[]) then
        begin
          if adsProdCost.FieldByName('Total').Asfloat <> 0 then
          begin
            ltmpstr := format('%9.5f',[adsProdCost.FieldByName('Total').asfloat*adsMain.fieldByName('Unit_sq').AsFloat]);
            ltmp2 := ltmp2+adsProdCost.FieldByName('Total').asfloat*adsMain.fieldByName('Unit_sq').AsFloat;
            if UnitType = 0 then //ͳ�Ƶ�λ��ƽ����
             begin
              Total_row:=Total_row+adsProdCost.FieldByName('Total').asfloat;
              StringGrid1.Cells[adsDept.recno+7,i]:= format('%8.3f',[adsProdCost.FieldByName('Total').asfloat]);
             end
            else begin //pcs
              Total_row:=Total_row+adsProdCost.FieldByName('Total').asfloat*adsMain.fieldByName('Unit_sq').AsFloat;
              StringGrid1.Cells[adsDept.recno+7,i]:= format('%9.5f',
                [adsProdCost.FieldByName('Total').asfloat*adsMain.fieldByName('Unit_sq').AsFloat]);
            end;
          end;
        end;
        adsProdCost.next;
      end;
    end;
    if Total_row <> 0 then
     if layer_type=0 then  //���
     begin
      StringGrid1.Cells[StringGrid1.ColCount-6-5,i]:= format('%8.3f',
        [Total_row*adsmain.fieldbyName('EST_SCRAP').ASFloat*0.01]);
      StringGrid1.Cells[StringGrid1.ColCount-5-5,i]:= format('%8.3f',
        [Total_row*(1+adsmain.fieldbyName('EST_SCRAP').ASFloat*0.01)]);


      //��׼�ɱ�ë������
      if adsmain.fieldbyName('total_qty').AsInteger * adsmain.fieldbyName('total_money').AsFloat <> 0 then
      begin
        ltmp := adsmain.fieldbyName('total_money').AsFloat / adsmain.fieldbyName('total_qty').AsInteger;
        StringGrid1.Cells[StringGrid1.ColCount-1-4 ,i] :=
        FormatFloat('0.000',(ltmp -
        ltmp2*(1+adsmain.fieldbyName('EST_SCRAP').ASFloat*0.01)) / ltmp * 100) + '%';
      end else
        StringGrid1.Cells[StringGrid1.ColCount-1-4 ,i] := '';


     end
     else begin   //�ڲ�
      StringGrid1.Cells[StringGrid1.ColCount-2-4,i]:= format('%8.3f',
        [Total_row*adsmain.fieldbyName('EST_SCRAP').ASFloat*0.01]);
      StringGrid1.Cells[StringGrid1.ColCount-1-4,i]:= format('%8.3f',
        [Total_row*(1+adsmain.fieldbyName('EST_SCRAP').ASFloat*0.01)]);
     end;

    Total_All:=Total_All+Total_Row*(1+adsmain.fieldbyName('EST_SCRAP').ASFloat*0.01);
    adsMain.Next;
  end;
  
  StringGrid1.Rows[StringGrid1.RowCount-1].Clear;
  StringGrid1.Cells[0,StringGrid1.RowCount-1]:= '�ϼ�';
  if layer_type=0 then  //���
    StringGrid1.Cells[StringGrid1.ColCount-5-5,StringGrid1.RowCount-1]:= format('%8.3f',[Total_All])
  else //�ڲ�
    StringGrid1.Cells[StringGrid1.ColCount-1-4,StringGrid1.RowCount-1]:= format('%8.3f',[Total_All]);

  if UnitType = 0 then //ƽ����
    StringGrid1.Cells[0,1]:='(��λ:ƽ����)'
  else //PCS
    StringGrid1.Cells[0,1]:='(��λ:PCS)';

  adsMain.close;
  adsDept.close;
  adsProdCost.close;
end;

procedure TfrmMain.BitBtn4Click(Sender: TObject);
var i:integer;
    sqlstr:string;
    sql2: string;
begin
  if frmQuerySet.ShowModal = mrOk then
  with frmQuerySet do
  begin
    sqlstr:=' WHERE (D64.Date_assign>='+QuotedStr(formatdatetime('yyyy-mm-dd',DTPD1.Date)
      +formatdatetime(' hh:nn:ss',dtpt1.Time))+') '
      +' and (D64.Date_assign<='+QuotedStr(formatdatetime('yyyy-mm-dd',DTPD2.Date)
      +formatdatetime(' hh:nn:ss',dtpt2.Time))+') ';
    for i:=1 to sgrid1.RowCount-2 do
     begin
      if sgrid1.Cells[2,i]<> '' then
        Sqlstr:=sqlstr+sgrid1.Cells[2,i]+#13;
     end;
    UnitType:=RadioGroup1.ItemIndex;      //ƽ�׳ɱ�,PC S�ɱ�
    layer_type:=Radiogroup2.ItemIndex;    //���,�ڲ�
    sql2 := ';with tmp1 as ' +
            '(' +
            ' select d25.manu_part_number,max(d207.rkey) as rkey207, max(d207.tdate)as date207 from data0207 d207 ' +
            ' inner join data0468 d468 on d207.D0468_PTR = d468.rkey ' +
            ' inner join data0060 d60 on d468.SO_NO = d60.SALES_ORDER ' +
            ' inner join data0025 d25 on d25.rkey = d60.CUST_PART_PTR ' +
            ' where (d207.TDATE >= ' + QuotedStr(formatdatetime('yyyy-mm-dd',DTPD1.Date)) + ') AND (d207.TDATE <= ' + QuotedStr(formatdatetime('yyyy-mm-dd',DTPD2.Date)) + ')' +
            ' group by d25.manu_part_number), ' +
            ' tmp2 as ( ' +
            ' select d207.rkey,d25.manu_part_number, d25.TUSAGE, d17.INV_DESCRIPTION/*���*/, ' +
            ' d468.QUAN_ISSUED*d17.STOCK_SELL as outare/*�������*/, ' +
            ' d207.QUANTITY*d22.PRICE*d456.exch_rate as outprice/*���Ž��*/, ' +
            ' d23.ABBR_NAME + d22.SUPPLIER2 as gys/*��Ӧ��*/ ' +
            ' from data0207 d207 ' +
            ' inner join tmp1 on d207.rkey = tmp1.rkey207 ' +
            ' inner join data0468 d468 on d207.D0468_PTR = d468.rkey ' +
            ' inner join data0492 d492 on d492.CUT_NO = d468.CUT_NO ' +
            ' inner join data0025 d25 on d25.rkey = d492.BOM_PTR ' +
            ' inner join data0022 d22 on d207.D0022_PTR = d22.rkey ' +
            ' inner join data0456 d456 on d22.GRN_PTR = d456.rkey ' +
            ' inner join data0023 d23 on d456.SUPP_PTR = d23.rkey ' +
            ' inner join data0017 d17 on d207.INVENTORY_PTR = d17.rkey ' +
            ' where (d207.TDATE >= ' + QuotedStr(formatdatetime('yyyy-mm-dd',DTPD1.Date)) + ') AND (d207.TDATE <= ' + QuotedStr(formatdatetime('yyyy-mm-dd',DTPD2.Date)) + ')' +
            ' ) select * from tmp2' ;
//            ShowMessage(sql2);
            adsMoreInfo.Close;
            adsMoreInfo.CommandText := sql2;
            adsMoreInfo.Open;
            DoSearch(sqlstr);
  end;
end;

procedure TfrmMain.InitGridTitle;
begin
  StringGrid1.Rows[0].Clear;//���Grid����
  StringGrid1.Rows[1].Clear;//���Grid����
  StringGrid1.ColCount:= 9;
  StringGrid1.Cells[0,0]:= '�������';
  StringGrid1.Cells[1,0]:= '�ͻ��ͺ�';
  StringGrid1.Cells[2,0]:= '�ͻ�����';
  StringGrid1.Cells[3,0]:= '�ͻ����';
  StringGrid1.Cells[4,0]:= '���ʹ���';
  StringGrid1.Cells[5,0]:= '��������';
  StringGrid1.Cells[6,0]:= '����/����';
  StringGrid1.Cells[8,0]:= '�ϼ�';
end;

procedure TfrmMain.FormCreate(Sender: TObject);
begin


  if not App_Init(ADOConnection1) then
  begin
    ShowMsg('��������ʧ�ܣ�����ϵϵͳ����Ա��','��ʾ',1);
    application.Terminate;
  end;


  self.Caption :=Application.Title;

end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  InitGridTitle;
  frmQuerySet.DTPD1.Date:=date()-dayof(date())+1; //���µ�һ��
  frmQuerySet.DTPD2.Date:=date();
end;

procedure TfrmMain.StringGrid1KeyDown(Sender:TObject;var Key:Word;Shift:TShiftState);
begin
 if (chr(key)='V') and (ssalt in shift) then
  showmessage(adsmain.CommandText);
end;

procedure TfrmMain.CheckBox1Click(Sender: TObject);
var
  i:integer;
  ExcludeColumns: TExcludeColumns;
begin
 for i:=0 to StringGrid1.ColCount-1 do
  if StringGrid1.ColWidths[i] < 0 then
   ExcludeColumns:=ExcludeColumns+[i];

  if CheckBox1.Checked then
   SetOptimalGridCellWidth(StringGrid1,ExcludeColumns)
  else
   for i:=0 to StringGrid1.ColCount-1 do
    if StringGrid1.ColWidths[i] > 0 then
     StringGrid1.ColWidths[i]:= FaWidth[i];
end;


end.
