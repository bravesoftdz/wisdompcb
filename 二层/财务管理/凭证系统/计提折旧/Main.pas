unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ComCtrls, ExtCtrls, StdCtrls, DBCtrls, Grids, DBGrids, Mask,
  Menus, ADODB, Buttons, Spin,math;

type
  TFrmMain = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Edit1: TEdit;
    Edit2: TEdit;
    RichEdit1: TRichEdit;
    CheckBox1: TCheckBox;
    ProgressBar1: TProgressBar;
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private

    function GetCanceTrans():string;
    function AddNewFass():boolean;
  public
    { Public declarations }
    Function GetDH(const pDt:TDate):string;
    //��ȡ������ʱ��
    function getDate():string;
    function MtoSt(const pdt:Tdate):string;
    function GeTrans(const pDh:string):boolean;//ɾ��ƾ֤
  end;

var
  FrmMain: TFrmMain;

implementation

uses udm, DateUtils,common;

{$R *.dfm}

function TFrmMain.AddNewFass():boolean;//��������
var
 vy,vm:integer;
begin
try
 vy:=strtoint(edit1.text);
 vm:=strtoint(edit2.Text);
 dm.ADOQ.close;
 dm.ADOQ.SQL.Text:=
  'SELECT dbo.data0326.fasset_ptr, dbo.data0326.dept_ptr,'+#13+
      'data0326.FACCU_DEPT_GL_PTR,'+#13+
      'Data0517.MONTH_DEPRE_AMT * dbo.data0326.PERCENTS * 0.01 AS sum_monthamt,'+#13+
      'Data0517.ORIGINAL_VALUE, dbo.Data0517.SUMMED_DEPRE,'+#13+
      'Data0517.MONTH_DEPRE_RATE, dbo.data0326.PERCENTS,'+#13+
      'Data0517.EXPECTED_LIFE_MONTHS, dbo.Data0517.DEPRED_MONTHS,'+#13+
      'Data0517.DEPRE_MTHD_PTR,Data0517.SURPLUS'+#13+
  'FROM Data0517 INNER JOIN'+#13+
      'Data0516 ON dbo.Data0517.STATUS_PTR = dbo.Data0516.RKEY INNER JOIN'+#13+
      'Data0103 INNER JOIN'+#13+
      'data0326 ON dbo.Data0103.RKEY = dbo.data0326.FACCU_DEPT_GL_PTR ON'+#13+
      'Data0517.RKEY = dbo.data0326.fasset_ptr'+#13+
  'WHERE (dbo.Data0517.DEPRED_MONTHS < dbo.Data0517.EXPECTED_LIFE_MONTHS) AND'+#13+
       '(dbo.Data0516.IN_DEPRECIATION = 1) AND '+#13+
       '(dbo.Data0517.active_flag = 1) AND'+#13+
       '(dbo.Data0517.NET_VALUE >= Data0517.MONTH_DEPRE_AMT) AND'+#13+ //��ֵ>=���۾ɶJacky Zhong 2016-4-20
      '(dbo.Data0517.BOOK_DATE < '''+datetostr(startOfAMonth(vY,vM))+''')';
 dm.ADOQ.Open;             //1:���¼�����۾�,�ڱ�������֮ǰ
 dm.DS528.Open;

while not dm.ADOQ.Eof do
begin
 dm.DS528.Append ;
 dm.DS528.FieldValues['FYEAR']:=edit1.Text;
 dm.DS528.FieldValues['PERIOD']:=edit2.Text;
 dm.DS528.FieldValues['D0517_ptr']:=DM.ADOQ.FieldValues['fasset_ptr'];
 dm.DS528.FieldValues['ORIGINAL_VALUE']:=0;  //DM.ADOQ.FieldValues['ORIGINAL_VALUE'];
 dm.DS528.FieldValues['SUMMED_DEPRE']:=0;    //DM.ADOQ.FieldValues['SUMMED_DEPRE']+DM.ADOQ.FieldValues['sum_monthamt'];
 dm.DS528.FieldValues['DEPRE_RATE']:=DM.ADOQ.FieldValues['MONTH_DEPRE_RATE'];
 dm.DS528.FieldValues['DEPRE_AMOUNT']:=DM.ADOQ.FieldValues['sum_monthamt'];
 dm.DS528.FieldValues['dept_ptr']:=DM.ADOQ.FieldValues['dept_ptr'];
 dm.DS528.FieldValues['gl_acct_ptr']:=DM.ADOQ.FieldValues['FACCU_DEPT_GL_PTR'];
 dm.DS528.FieldValues['percents']:=DM.ADOQ.FieldValues['PERCENTS'];
 dm.DS528.FieldValues['accu_depre_months']:=DM.ADOQ.FieldValues['DEPRED_MONTHS']+1; //�Ѽ����·�+1����517����ͬ�� Jacky Zhong 2016-4-20
 dm.DS528.FieldValues['expected_depre_months']:=DM.ADOQ.FieldValues['EXPECTED_LIFE_MONTHS'];
 dm.DS528.FieldValues['depre_mthd_ptr']:=DM.ADOQ.FieldValues['depre_mthd_ptr'];
 dm.DS528.FieldValues['month_loading']:=1;
 dm.DS528.FieldValues['surplus']:=DM.ADOQ.FieldValues['surplus'];
 dm.DS528.FieldValues['voucher_ptr']:=dm.DS0105.FieldValues['rkey'];
 dm.DS528.FieldValues['month_depre_amt']:=DM.ADOQ.FieldValues['sum_monthamt'];
 dm.DS528.Post;
 ProgressBar1.Position :=
   trunc(100*dm.ADOQ.recno/dm.ADOQ.recordcount);
 dm.ADOQ.Next;
end;

 dm.ADOQ.close;
 dm.ADOQ.SQL.Text:=
  'SELECT dbo.data0326.fasset_ptr, dbo.data0326.dept_ptr,'+#13+
      'data0326.FACCU_DEPT_GL_PTR,'+#13+
      'Data0517.MONTH_DEPRE_AMT * dbo.data0326.PERCENTS * 0.01 AS sum_monthamt,'+#13+
      'Data0517.ORIGINAL_VALUE, dbo.Data0517.SUMMED_DEPRE,'+#13+
      'Data0517.MONTH_DEPRE_RATE, dbo.data0326.PERCENTS,'+#13+
      'Data0517.EXPECTED_LIFE_MONTHS, dbo.Data0517.DEPRED_MONTHS,'+#13+
      'Data0517.DEPRE_MTHD_PTR,Data0517.SURPLUS'+#13+
  'FROM Data0517 INNER JOIN'+#13+
      'Data0516 ON dbo.Data0517.STATUS_PTR = dbo.Data0516.RKEY INNER JOIN'+#13+
      'Data0103 INNER JOIN'+#13+
      'data0326 ON dbo.Data0103.RKEY = dbo.data0326.FACCU_DEPT_GL_PTR ON'+#13+
      'Data0517.RKEY = dbo.data0326.fasset_ptr'+#13+
  'WHERE (dbo.Data0517.DEPRED_MONTHS < dbo.Data0517.EXPECTED_LIFE_MONTHS) AND'+#13+
       '(dbo.Data0516.IN_DEPRECIATION = 1) AND (dbo.Data0517.active_flag = 1) AND'+#13+
      '(dbo.Data0517.BOOK_DATE >= '+quotedstr(datetostr(startOfAMonth(vY,vM)))+') and'+#13+
      '(dbo.Data0517.BOOK_DATE <= '+quotedstr(datetostr(endOfAMonth(vY,vM)))+')';
 dm.ADOQ.Open;             //2:�ڵ�ǰ����ڼ����ʵĹ̶��ʲ�,����δ������۾�,
while not dm.ADOQ.Eof do
begin
 dm.DS528.Append ;
 dm.DS528.FieldValues['FYEAR']:=edit1.Text;
 dm.DS528.FieldValues['PERIOD']:=edit2.Text;
 dm.DS528.FieldValues['D0517_ptr']:=DM.ADOQ.FieldValues['fasset_ptr'];
 dm.DS528.FieldValues['ORIGINAL_VALUE']:=0;//DM.ADOQ.FieldValues['ORIGINAL_VALUE'];
 dm.DS528.FieldValues['SUMMED_DEPRE']:=0; //DM.ADOQ.FieldValues['SUMMED_DEPRE'];
 dm.DS528.FieldValues['DEPRE_RATE']:=DM.ADOQ.FieldValues['MONTH_DEPRE_RATE'];
 dm.DS528.FieldValues['DEPRE_AMOUNT']:=0;
 dm.DS528.FieldValues['dept_ptr']:=DM.ADOQ.FieldValues['dept_ptr'];
 dm.DS528.FieldValues['gl_acct_ptr']:=DM.ADOQ.FieldValues['FACCU_DEPT_GL_PTR'];
 dm.DS528.FieldValues['percents']:=DM.ADOQ.FieldValues['PERCENTS'];
 dm.DS528.FieldValues['accu_depre_months']:=DM.ADOQ.FieldValues['DEPRED_MONTHS'];
 dm.DS528.FieldValues['expected_depre_months']:=DM.ADOQ.FieldValues['EXPECTED_LIFE_MONTHS'];
 dm.DS528.FieldValues['depre_mthd_ptr']:=DM.ADOQ.FieldValues['depre_mthd_ptr'];
 dm.DS528.FieldValues['month_loading']:=2;
 dm.DS528.FieldValues['surplus']:=DM.ADOQ.FieldValues['surplus'];   //����ֵ
 dm.DS528.FieldValues['voucher_ptr']:=null;
 dm.DS528.FieldValues['month_depre_amt']:=0;    //�����۾�
 dm.DS528.Post;
 ProgressBar1.Position :=
   trunc(100*dm.ADOQ.recno/dm.ADOQ.recordcount);
 dm.ADOQ.Next;
end;

 dm.ADOQ.close;
 dm.ADOQ.SQL.Text:=
  'SELECT dbo.data0326.fasset_ptr, dbo.data0326.dept_ptr,'+#13+
      'data0326.FACCU_DEPT_GL_PTR,'+#13+
      'Data0517.MONTH_DEPRE_AMT * dbo.data0326.PERCENTS * 0.01 AS sum_monthamt,'+#13+
      'Data0517.ORIGINAL_VALUE, dbo.Data0517.SUMMED_DEPRE,'+#13+
      'Data0517.MONTH_DEPRE_RATE, dbo.data0326.PERCENTS,'+#13+
      'Data0517.EXPECTED_LIFE_MONTHS, dbo.Data0517.DEPRED_MONTHS,'+#13+
      'Data0517.DEPRE_MTHD_PTR,Data0517.SURPLUS'+#13+
  'FROM Data0517 INNER JOIN'+#13+
      'Data0516 ON dbo.Data0517.STATUS_PTR = dbo.Data0516.RKEY INNER JOIN'+#13+
      'Data0103 INNER JOIN'+#13+
      'data0326 ON dbo.Data0103.RKEY = dbo.data0326.FACCU_DEPT_GL_PTR ON'+#13+
      'Data0517.RKEY = dbo.data0326.fasset_ptr'+#13+
  'WHERE (Data0517.DEPRED_MONTHS >= Data0517.EXPECTED_LIFE_MONTHS) AND'+#13+
       '(Data0516.IN_DEPRECIATION = 1) AND (Data0517.active_flag = 1)';
 dm.ADOQ.Open;             //3:�Ѽ�����ɵ���Ч�Ĺ̶��ʲ�,����δ�����۾�,
while not dm.ADOQ.Eof do
begin
 dm.DS528.Append ;
 dm.DS528.FieldValues['FYEAR']:=edit1.Text;
 dm.DS528.FieldValues['PERIOD']:=edit2.Text;
 dm.DS528.FieldValues['D0517_ptr']:=DM.ADOQ.FieldValues['fasset_ptr'];
 dm.DS528.FieldValues['ORIGINAL_VALUE']:=0;//DM.ADOQ.FieldValues['ORIGINAL_VALUE'];
 dm.DS528.FieldValues['SUMMED_DEPRE']:=0;  //DM.ADOQ.FieldValues['SUMMED_DEPRE'];
 dm.DS528.FieldValues['DEPRE_RATE']:=DM.ADOQ.FieldValues['MONTH_DEPRE_RATE'];
 dm.DS528.FieldValues['DEPRE_AMOUNT']:=0;
 dm.DS528.FieldValues['dept_ptr']:=DM.ADOQ.FieldValues['dept_ptr'];
 dm.DS528.FieldValues['gl_acct_ptr']:=DM.ADOQ.FieldValues['FACCU_DEPT_GL_PTR'];
 dm.DS528.FieldValues['percents']:=DM.ADOQ.FieldValues['PERCENTS'];
 dm.DS528.FieldValues['accu_depre_months']:=DM.ADOQ.FieldValues['DEPRED_MONTHS'];
 dm.DS528.FieldValues['expected_depre_months']:=DM.ADOQ.FieldValues['EXPECTED_LIFE_MONTHS'];
 dm.DS528.FieldValues['depre_mthd_ptr']:=DM.ADOQ.FieldValues['depre_mthd_ptr'];
 dm.DS528.FieldValues['month_loading']:=3;
 dm.DS528.FieldValues['surplus']:=DM.ADOQ.FieldValues['surplus'];   //����ֵ
 dm.DS528.FieldValues['voucher_ptr']:=null;
 dm.DS528.FieldValues['month_depre_amt']:=0;
 dm.DS528.Post;
 ProgressBar1.Position :=
   trunc(100*dm.ADOQ.recno/dm.ADOQ.recordcount);
 dm.ADOQ.Next;
end;

 dm.ADOQ.close;
 dm.ADOQ.SQL.Text:=
  'SELECT dbo.data0326.fasset_ptr, dbo.data0326.dept_ptr,'+#13+
      'data0326.FACCU_DEPT_GL_PTR,'+#13+
      'Data0517.MONTH_DEPRE_AMT * dbo.data0326.PERCENTS * 0.01 AS sum_monthamt,'+#13+
      'Data0517.ORIGINAL_VALUE, dbo.Data0517.SUMMED_DEPRE,'+#13+
      'Data0517.MONTH_DEPRE_RATE, dbo.data0326.PERCENTS,'+#13+
      'Data0517.EXPECTED_LIFE_MONTHS, dbo.Data0517.DEPRED_MONTHS,'+#13+
      'Data0517.DEPRE_MTHD_PTR,Data0517.SURPLUS'+#13+
  'FROM Data0517 INNER JOIN'+#13+
      'Data0516 ON dbo.Data0517.STATUS_PTR = dbo.Data0516.RKEY INNER JOIN'+#13+
      'Data0103 INNER JOIN'+#13+
      'data0326 ON dbo.Data0103.RKEY = dbo.data0326.FACCU_DEPT_GL_PTR ON'+#13+
      'Data0517.RKEY = dbo.data0326.fasset_ptr'+#13+
   'where (Data0516.IN_DEPRECIATION = 0) AND (Data0517.active_flag = 1)';
 dm.ADOQ.Open;             //4:��ǰ��Ч��,������δʹ�õĹ̶��ʲ�,����δ�����۾�,
while not dm.ADOQ.Eof do
begin
 dm.DS528.Append ;
 dm.DS528.FieldValues['FYEAR']:=edit1.Text;
 dm.DS528.FieldValues['PERIOD']:=edit2.Text;
 dm.DS528.FieldValues['D0517_ptr']:=DM.ADOQ.FieldValues['fasset_ptr'];
 dm.DS528.FieldValues['ORIGINAL_VALUE']:=0; //DM.ADOQ.FieldValues['ORIGINAL_VALUE'];
 dm.DS528.FieldValues['SUMMED_DEPRE']:=0;   //DM.ADOQ.FieldValues['SUMMED_DEPRE'];
 dm.DS528.FieldValues['DEPRE_RATE']:=DM.ADOQ.FieldValues['MONTH_DEPRE_RATE'];
 dm.DS528.FieldValues['DEPRE_AMOUNT']:=0;
 dm.DS528.FieldValues['dept_ptr']:=DM.ADOQ.FieldValues['dept_ptr'];
 dm.DS528.FieldValues['gl_acct_ptr']:=DM.ADOQ.FieldValues['FACCU_DEPT_GL_PTR'];
 dm.DS528.FieldValues['percents']:=DM.ADOQ.FieldValues['PERCENTS'];
 dm.DS528.FieldValues['accu_depre_months']:=DM.ADOQ.FieldValues['DEPRED_MONTHS'];
 dm.DS528.FieldValues['expected_depre_months']:=DM.ADOQ.FieldValues['EXPECTED_LIFE_MONTHS'];
 dm.DS528.FieldValues['depre_mthd_ptr']:=DM.ADOQ.FieldValues['depre_mthd_ptr'];
 dm.DS528.FieldValues['month_loading']:=3;
 dm.DS528.FieldValues['surplus']:=DM.ADOQ.FieldValues['surplus'];   //����ֵ
 dm.DS528.FieldValues['voucher_ptr']:=null;
 dm.DS528.FieldValues['month_depre_amt']:=0;        //�����۾�
 dm.DS528.Post;
 ProgressBar1.Position :=
   trunc(100*dm.ADOQ.recno/dm.ADOQ.recordcount);
 dm.ADOQ.Next;
end;
// Jacky zhong 2016-04-20�����Ӿ�ֵ<���۾ɶ���һ�β������۾ɵ��豸
 dm.ADOQ.close;
 dm.ADOQ.SQL.Text:=
  'SELECT dbo.data0326.fasset_ptr, dbo.data0326.dept_ptr,'+#13+
      'data0326.FACCU_DEPT_GL_PTR,'+#13+
      'Data0517.MONTH_DEPRE_AMT * dbo.data0326.PERCENTS * 0.01 AS sum_monthamt,'+#13+
      'Data0517.ORIGINAL_VALUE, dbo.Data0517.SUMMED_DEPRE,'+#13+
      'Data0517.MONTH_DEPRE_RATE, dbo.data0326.PERCENTS,'+#13+
      'Data0517.EXPECTED_LIFE_MONTHS, dbo.Data0517.DEPRED_MONTHS,'+#13+
      'Data0517.DEPRE_MTHD_PTR,Data0517.SURPLUS'+#13+
  'FROM Data0517 INNER JOIN'+#13+
      'Data0516 ON dbo.Data0517.STATUS_PTR = dbo.Data0516.RKEY INNER JOIN'+#13+
      'Data0103 INNER JOIN'+#13+
      'data0326 ON dbo.Data0103.RKEY = dbo.data0326.FACCU_DEPT_GL_PTR ON'+#13+
      'Data0517.RKEY = dbo.data0326.fasset_ptr'+#13+
  'WHERE (dbo.Data0517.DEPRED_MONTHS < dbo.Data0517.EXPECTED_LIFE_MONTHS) AND'+#13+
       '(dbo.Data0516.IN_DEPRECIATION = 1) AND (dbo.Data0517.active_flag = 1) AND'+#13+
       '(dbo.Data0517.NET_VALUE < Data0517.MONTH_DEPRE_AMT) AND'+#13+ //��ֵ<���۾ɶJacky Zhong 2016-4-20 
      '(dbo.Data0517.BOOK_DATE < '''+datetostr(startOfAMonth(vY,vM))+''')';
 dm.ADOQ.Open;             //5:��ǰ��ֵ�������۾ɶ���ڼ���
 dm.DS528.Open;

while not dm.ADOQ.Eof do
begin
 dm.DS528.Append ;
 dm.DS528.FieldValues['FYEAR']:=edit1.Text;
 dm.DS528.FieldValues['PERIOD']:=edit2.Text;
 dm.DS528.FieldValues['D0517_ptr']:=DM.ADOQ.FieldValues['fasset_ptr'];
 dm.DS528.FieldValues['ORIGINAL_VALUE']:=0;//DM.ADOQ.FieldValues['ORIGINAL_VALUE'];
 dm.DS528.FieldValues['SUMMED_DEPRE']:=0;  //DM.ADOQ.FieldValues['SUMMED_DEPRE']+DM.ADOQ.FieldValues['sum_monthamt'];
 dm.DS528.FieldValues['DEPRE_RATE']:=DM.ADOQ.FieldValues['MONTH_DEPRE_RATE'];
 dm.DS528.FieldValues['DEPRE_AMOUNT']:=0;              //��ǰû���۾ɶ�
 dm.DS528.FieldValues['dept_ptr']:=DM.ADOQ.FieldValues['dept_ptr'];
 dm.DS528.FieldValues['gl_acct_ptr']:=DM.ADOQ.FieldValues['FACCU_DEPT_GL_PTR'];
 dm.DS528.FieldValues['percents']:=DM.ADOQ.FieldValues['PERCENTS'];
 dm.DS528.FieldValues['accu_depre_months']:=DM.ADOQ.FieldValues['DEPRED_MONTHS']; 
 dm.DS528.FieldValues['expected_depre_months']:=DM.ADOQ.FieldValues['EXPECTED_LIFE_MONTHS'];
 dm.DS528.FieldValues['depre_mthd_ptr']:=DM.ADOQ.FieldValues['depre_mthd_ptr'];
 dm.DS528.FieldValues['month_loading']:=1;
 dm.DS528.FieldValues['surplus']:=DM.ADOQ.FieldValues['surplus'];
 dm.DS528.FieldValues['voucher_ptr']:=dm.DS0105.FieldValues['rkey'];
 dm.DS528.FieldValues['month_depre_amt']:=DM.ADOQ.FieldValues['sum_monthamt'];
 dm.DS528.Post;
 ProgressBar1.Position :=
   trunc(100*dm.ADOQ.recno/dm.ADOQ.recordcount);
 dm.ADOQ.Next;
end;

 result:=true;
except
  on E: Exception do
   begin
    messagedlg(E.Message,mtinformation,[mbok],0);
    result:=false;
   end;
end;
end;

function TFrmMain.GetCanceTrans():string;
begin
 dm.ADOQ.close;
 dm.ADOQ.SQL.Clear;
 dm.ADOQ.SQL.Text:='select VOUCHER from data0105'+#13+
                   'where FYEAR='+edit1.Text+#13+
                   'and PERIOD='+edit2.Text+#13+
                   'and SPECIAL_POSTING =''D'''+#13+
                   'and STATUS =5';
 dm.ADOQ.Open;
 if dm.ADOQ.IsEmpty  then
  result:=''
 else
  result:=dm.ADOQ.FieldValues['VOUCHER'];
end;

function TFrmMain.GeTrans(const pDh:string):boolean;
var                          //*******���ɼ���ƾ֤*******//
  mdt:Tdate;
  vCur,vdur:Currency;
  vY,vM:integer;
begin
 try
   result:=true;
   vY:=strtoint(edit1.Text);
   vM:=strtoint(edit2.Text);
   mdt:=endOfAMonth(vY,vM);   //����������

   dm.Qry326.Close;
   dm.Qry326.Parameters.ParamByName('vBdate').Value:=startOfAMonth(vY,vM);
   dm.Qry326.Open;
   dm.Qry0517.Close;
   dm.Qry0517.Parameters.ParamByName('vBdate').Value:=startOfAMonth(vY,vM);
   dm.Qry0517.Open;
  if (dm.Qry326.IsEmpty) or (dm.Qry0517.IsEmpty) then
   begin                          //�޽�����ݲ���ʧ��
    result:=false;
    exit;
   end;
   vcur:=0;  //ƾ֤�����ϼ�
   vdur:=0;  //ƾ֤�跽�ϼ�
   dm.DS0105.close;
   dm.DS0105.open;
   dm.DS0105.append;

   if pDh='' then
    dm.DS0105.fieldbyname('voucher').Value:=getdh(mdt)
   else
   begin
    dm.ADOQ.Close;
    dm.ADOQ.SQL.Clear;
    dm.ADOQ.SQL.Text:='delete data0105 where VOUCHER='''+pDh+'''';
    dm.ADOQ.ExecSQL;
    dm.DS0105.fieldbyname('voucher').Value:=pDh;
   end;
   dm.DS0105.Fieldbyname('batch_number').Value:='';
   dm.DS0105.Fieldbyname('entered_by_empl_ptr').asstring:=user_ptr;
   dm.DS0105.Fieldbyname('entered_dt').AsString:=datetostr(mdt);
   dm.DS0105.Fieldbyname('FYEAR').Value:=vY;
   dm.DS0105.Fieldbyname('period').Value:=vM;
   dm.DS0105.fieldbyname('vou_type').Value:=4;            //ƾ֤����
   dm.DS0105.fieldbyname('special_posting').Value:='D';  //�۾�ƾ֤��ʾ
   dm.DS0105.fieldbyname('trans_type').Value:=9; //ҵ������
   dm.DS0105.FieldByName('BATCH_NUMBER').Value:='�����۾�';
   if CheckBox1.Checked =true then
    begin
     dm.DS0105.fieldbyname('status').Value:=2;           //�������״̬
     dm.DS0105.Fieldbyname('audited_by_empl_ptr').asstring:=user_ptr;
     dm.DS0105.Fieldbyname('supervisor_ptr').asstring:=user_ptr;
    end
   else
    begin
     dm.DS0105.fieldbyname('status').Value:=0;           //δ���
    end;
   dm.DS0105.Post;                          //����ƾ֤

  if dm.DS0106.Active =false then  dm.DS0106.open;

  while not dm.Qry326.Eof do     //�����۾ɷ��ý跽��Ŀ
   with dm.DS0106 do
    begin
     append;
     Fieldbyname('gl_header_ptr').Value:=dm.DS0105.fieldbyname('rkey').Value;
     Fieldbyname('gl_acct_no_ptr').Value:=DM.Qry326FACCU_DEPT_GL_PTR.Value;
     Fieldbyname('ref_number').asstring:=DM.Qry326GL_ACC_NUMBER.Value;
     Fieldbyname('description').Value:='���᱾���۾�';
     Fieldbyname('amount').AsCurrency:=dm.Qry326sum_monthamt.Value;    //�����
     Fieldbyname('price').AsCurrency:=dm.Qry326sum_monthamt.Value;     //���
     Fieldbyname('d_c').Value:=DM.Qry326DB_CR.Value;
     Fieldbyname('CURR_PTR').Value:=1;  //����
     Fieldbyname('EXCH_RATE').Value:=1;  //����
     if dm.Qry326DB_CR.Value='D' then
      vdur:=vdur+ dm.Qry326sum_monthamt.Value
     else
      vCur:=vCur+ dm.Qry326sum_monthamt.Value;
     dm.Qry326.Next;
     ProgressBar1.Position :=
       trunc(100*dm.Qry326.recno/dm.Qry326.recordcount);
    end;//end  dm.DS0106

  while not dm.Qry0517.Eof do
   with DM.DS0106 do          //ƾ֤��¼       //�ۼ��۾ɴ�����Ŀ
    begin
     append;
     Fieldbyname('gl_header_ptr').Value:=dm.DS0105.fieldbyname('rkey').Value;
     Fieldbyname('gl_acct_no_ptr').Value:=DM.Qry0517DEPRE_ACCT_PTR.Value ;
     Fieldbyname('ref_number').asstring:=DM.Qry0517GL_ACC_NUMBER.Value;
     Fieldbyname('description').Value:='���᱾���۾�';
     Fieldbyname('srce_ptr').Value:=0;
     Fieldbyname('amount').AsCurrency:=DM.Qry0517sum_monthamt.Value;
     Fieldbyname('price').AsCurrency:=DM.Qry0517sum_monthamt.Value;
     Fieldbyname('d_c').Value:=DM.Qry0517DB_CR.Value;
     Fieldbyname('CURR_PTR').Value:=1;  //����
     Fieldbyname('EXCH_RATE').Value:=1;  //����
     if dm.Qry0517DB_CR.Value='D' then
      vdur:=vdur+ dm.Qry0517sum_monthamt.Value
     else
      vCur:=vCur+ dm.Qry0517sum_monthamt.Value;
     dm.Qry0517.Next ;
     ProgressBar1.Position :=
       trunc(100*dm.Qry0517.recno/dm.Qry0517.recordcount);
    end;//end while not dm.Qry0517.Eof

 if vdur<>vcur then    //ƾ֤�����ƽ�����ʧ��
  begin
   result:=false;
   exit;
  end;

  dm.DS0106.UpdateBatch();
 except
   result:=false;
 end;
end;


//��ȡ����
function TFrmMain.getDate():string;
begin
  DM.ADOQ.Close ;
  dm.ADOQ.SQL.Clear ;
  dm.ADOQ.SQL.Text :='select getdate() as dt';
  DM.ADOQ.OPEN;
 result:=datetostr(strtodatetime(dm.ADOQ.Fieldbyname('dt').AsString))
end;

Function TFrmMain.GetDH(const pDt:TDate):string;
var
 voucher:string;
 pr_req:integer;
begin
 voucher:='TA'+copy(inttostr(yearof(pDt)),3,2);  //���
 if length(inttostr(monthof(pDt))) < 2 then
  voucher := voucher+'0'+inttostr(monthof(pDt))
 else
  voucher := voucher+inttostr(monthof(pDt));      //�·�
 with dm.ADOQ do
  begin
   close;
   sql.Clear;
   sql.Add('select top 1 VOUCHER from data0105');
   sql.Add('where VOUCHER like '''+voucher+'%''');
   sql.Add('order by voucher desc');
   open;
  end;
 if dm.ADOQ.IsEmpty then
  begin
   voucher:= voucher+'00001';
  end
 else
  begin
   pr_req := strtoint(copy(dm.ADOQ.fieldvalues['VOUCHER'],
   length(trim(voucher))+1,5));
   pr_req := 100000+pr_req+1;
   voucher := voucher+copy(inttostr(pr_req),2,5);
  end;
 result:=voucher;
end;
//��ת���ַ�
function TFrmMain.MtoSt(const pdt:Tdate):string;
var
  mst:string;
 begin

  mst:=inttostr(monthOf(pdt));
  if Length(mst)<2 then
  mst:='0'+mst;
  result:=mst;
 end;

procedure TFrmMain.BitBtn2Click(Sender: TObject);
begin
  application.Terminate;
end;
//*****************************************************************
//********1.����ת��ƾ֤���裬�۾ɷѣ������ۼ��۾�           ******
//********2,���¹̶��ʲ���"��ǰ�Ѽ����·�"=��ǰ�Ѽ����·�+1  ******
//********3.���¹̶��ʲ���"��ǰ�ۼ��۾�"=��ǰ�ۼ��۾�+���۾ɶ�*****
//********4.���¹̶��ʲ���"��ֵ"=ԭֵ-��ǰ�ۼ��۾�*****
//*****************************************************************
procedure TFrmMain.BitBtn1Click(Sender: TObject);
var
  vy,vm:integer;
begin
  vy:=strtoint(edit1.text);
  vm:=strtoint(edit2.Text);

  if dm.DS0508.fieldbyname('depre_flag').Value = 1 then
   begin
    messagedlg('�����Ѿ������۾ɣ�',mtinformation,[mbok],0);
    exit;
   end;

  if messagedlg('��ʼ�����۾����ٴ�ȷ��!',mtconfirmation,[mbyes,mbno],0)=mryes then
  try
   dm.ADOCnn.BeginTrans ;

    if not geTrans(GetCanceTrans()) then //����ƾ֤
     begin
      dm.ADOCnn.RollbackTrans ;
      messagedlg('û�пɼ���Ĺ̶��ʲ�����ƾ֤�����ƽ�����ʧ��!',mterror,[mbcancel],0);
      exit;
     end;

     //���¼����۾���ϸ,�����������Ĺ̶��ʲ���û���۾ɽ��,������Ч�ĵ��Ѽ�����ɵĹ̶��ʲ�
    if not AddNewFass() then
     begin

      dm.ADOCnn.RollbackTrans ;
      messagedlg('�����۾���ϸʱ���ִ����������Ա��ϵ!',mterror,[mbcancel],0);
      exit;

     end;

   dm.ADOQ.Close;
   dm.ADOQ.SQL.Text:='update data0517'+#13+
   'set Data0517.SUMMED_DEPRE='+#13+     //��ǰ�ۼ��۾�
                'Data0517.SUMMED_DEPRE + Data0517.MONTH_DEPRE_AMT,'+#13+
   'Data0517.DEPRED_MONTHS=Data0517.DEPRED_MONTHS + 1,'+#13+  //��ǰ�����·�
   'Data0517.NET_VALUE='+#13+               //��ǰ��ֵ
               'Data0517.ORIGINAL_VALUE - Data0517.SUMMED_DEPRE - Data0517.MONTH_DEPRE_AMT'+#13+
   'FROM Data0517 INNER JOIN'+#13+
   'Data0516 ON Data0517.STATUS_PTR = Data0516.RKEY'+#13+
   'WHERE (Data0517.BOOK_DATE < '''+datetostr(startOfAMonth(vY,vM))+''')'+#13+
      'AND (Data0517.active_flag = 1) '+#13+
      'AND (Data0517.NET_VALUE >= Data0517.MONTH_DEPRE_AMT) '+#13+//��ֵ>=���۾ɶjacky zhong 2016-4-20
      'AND (Data0517.DEPRED_MONTHS < Data0517.EXPECTED_LIFE_MONTHS)'+#13+
      'AND (Data0516.IN_DEPRECIATION = 1)';
   dm.ADOQ.ExecSQL;
   //�޸�517�̶��ʲ���Ƭ�е�

   dm.ADOQ.Close;
   dm.ADOQ.SQL.Text:= 'update data0528 '+
         'set data0528.ORIGINAL_VALUE=Data0517.ORIGINAL_VALUE,'+
         '    data0528.SUMMED_DEPRE=Data0517.SUMMED_DEPRE '+
         'from data0528 inner join data0517 '+
         ' on data0528.d0517_ptr=data0517.rkey '+
         'where data0528.rkey in(select max(rkey) from data0528 '+
                       'where FYEAR='+edit1.Text+' and PERIOD='+edit2.Text+
                       ' group by d0517_ptr)';
   dm.ADOQ.ExecSQL;
   //�����۾���ϸ528���еĹ̶��ʲ�ԭֵ���ۼ��۾ɣ�ͬһ���ʲ��ж����ϸ�����ۼ��۾ɺ��ʲ�ԭֵֻ�ܸ���һ����¼

   //�����۾ɱ�־
   dm.DS0508.Edit;
   dm.DS0508.fieldbyname('depre_flag').AsInteger :=1;
   dm.DS0508.Post ;

   dm.ADOCnn.CommitTrans ;

   messagedlg('�����۾����!',mtinformation,[mbok],0);
  except
    on E: Exception do
     begin
      dm.ADOCnn.RollbackTrans ;
      messagedlg(E.Message,mtinformation,[mbok],0);
     end;
  end;

end;


procedure TFrmMain.FormCreate(Sender: TObject);

begin
  if not App_Init(dm.ADOCnn) then
  begin
    ShowMsg('��������ʧ�ܣ�����ϵϵͳ����Ա��','��ʾ',1);
    application.Terminate;
  end;
  self.Caption :=Application.Title;

  DateSeparator := '-';
  ShortDateFormat := 'yyyy-mm-dd';
end;

procedure TFrmMain.FormShow(Sender: TObject);
begin
if  dm.ADOCnn.Connected then
  begin

  DM.DS0508.close ;
  DM.DS0508.Open ;
  edit1.text:=DM.DS0508.fieldbyname('curr_FYEAR').asstring;
  edit2.text:=DM.DS0508.fieldbyname('curr_period').asstring;   
  end;
end;

end.

