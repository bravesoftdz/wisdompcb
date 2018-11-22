unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ComCtrls, ExtCtrls, StdCtrls, DBCtrls, Grids, DBGrids, Mask,
  Menus, ADODB, Buttons, Spin;

type
  TFrmMain = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Edit1: TEdit;
    Edit2: TEdit;
    RichEdit1: TRichEdit;
    ProgressBar1: TProgressBar;
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    function finderror: string;
    function GetPRkey(prkey:integer;var parent_ptr:integer;
                                    var ty_close:currency):boolean;
    function updateGL(const pCurrD,pCurrC:currency;vgl:integer;dbcr:char):boolean;
    function getProfitPZ(const pStatus:integer):string;//��ȡ����ƾ֤
    Function GetDH(const pDt:TDate):string;     //�õ�ƾ���
    function geTrans(const pVour:string):boolean;//����ƾ֤

    function SaveProfitTo110():boolean; //���������Ŀ��ĩ��110
    procedure update_110_PROFIT(rkey103:integer;typ_close:currency);
  public
    { Public declarations }

  end;

var
  FrmMain: TFrmMain;

implementation

uses udm, DateUtils,common;

{$R *.dfm}

function TFrmMain.finderror: string;
begin
dm.ADOQ.Close;
dm.ADOQ.SQL.Clear;
dm.ADOQ.SQL.Text:='SELECT top 1 Data0103.gl_acc_number'+#13+
'FROM Data0103'+#13+
'WHERE (Data0103.TYR_CLOSE<>0)'+#13+
      'AND (Data0103.HAS_CHILD = 0)'+#13+
      'AND (Data0103.ACC_TP=5)'+#13+
      'AND (data0103.curr_tp<>0)';
dm.ADOQ.Open;
if dm.ADOQ.IsEmpty then
 result:=''
else
 result:=dm.ADOQ.fieldbyname('gl_acc_number').AsString;
dm.ADOQ.Close;
end;

function TFrmMain.GetPRkey(prkey:integer;var parent_ptr:integer;
                            var ty_close:currency):boolean;
begin
 dm.ADOQ.Close;
 dm.ADOQ.SQL.Text:='SELECT Data0103.PARENT_PTR,data0103_1.TYR_CLOSE'+#13+
                   'FROM Data0103 inner join data0103 as data0103_1'+#13+
                   'on data0103.PARENT_PTR=data0103_1.rkey'+#13+
                   'WHERE Data0103.RKEY ='+inttostr(prkey);
 dm.ADOQ.Parameters.Refresh;
 dm.ADOQ.Open;
 if dm.ADOQ.FieldValues['PARENT_PTR']>0 then
  begin
   parent_ptr:=dm.ADOQ.FieldValues['PARENT_PTR'];
   ty_close:=dm.ADOQ.FieldValues['TYR_CLOSE'];
   result:=true;
  end
 else
  result:=false;
end;

procedure TFrmMain.update_110_PROFIT(rkey103:integer;typ_close:currency);
var
 parent_ptr:integer;
 parent_close:currency;
begin
  dm.ds110.Close;
  dm.DS110.Parameters.ParamByName('vYear').Value:=strtoint(edit1.Text);
  dm.DS110.Parameters.ParamByName('rkey103').Value:=rkey103;
  dm.ds110.open;

  dm.ds110.edit;
  dm.ds110.fieldbyname('TYR_PERIOD_'+edit2.Text+'_PROFIT').AsCurrency:=typ_close;   //���ڴ���������
  dm.DS110.Post;

  parent_ptr:=0;
  parent_close:=0;
  if self.GetPRkey(rkey103,parent_ptr,parent_close) then
  update_110_PROFIT(parent_ptr,parent_close);
end;

function TFrmMain.SaveProfitTo110():boolean;   //���������Ŀ��ĩ��110
begin
 try
  dm.ADOQ.Close;  //������Ҫ��ת�������Ŀ�����,��Ϊ��ת֮���Ϊ����
  dm.ADOQ.SQL.Clear;
  dm.ADOQ.SQL.Text:='update data0110'+#13+
      'set TYR_PERIOD_'+edit2.Text+'_PROFIT = Data0103.TYR_CLOSE'+#13+
      'FROM Data0103 INNER JOIN'+#13+
      'Data0110 ON Data0103.RKEY = Data0110.GL_ACCT_PTR'+#13+
      'WHERE (dbo.Data0103.ACC_TP = 5)'+#13+
      'AND (dbo.Data0103.TYR_CLOSE <> 0)'+#13+
      'AND (dbo.Data0110.FYEAR ='+edit1.Text+')';
  dm.ADOQ.ExecSQL;

  self.update_110_PROFIT(dm.ADODSProfitrkey.Value,dm.ADODSProfitTYR_CLOSE.Value);
  result:=true;
 except
   result:=false;
 end;
end;


function  TFrmMain.getProfitPZ(const pStatus:integer):string;//��ȡ����ƾ֤
var
  msql:string;
begin
  dm.ADOQ.Close;
  dm.ADOQ.SQL.Clear ;
  msql:='select VOUCHER from Data0105';
  msql:=msql+' where (FYEAR ='+edit1.Text+' )';
  msql:=msql+' AND (PERIOD = '+edit2.Text+' )';
  msql:=msql+' AND (STATUS = '+inttostr(pStatus)+' )';
  msql:=msql+' and (SPECIAL_POSTING = ''Y'''+' )';

  dm.ADOQ.SQL.text:=msql;
  dm.ADOQ.open;

  if not dm.ADOQ.IsEmpty then      //�Ƿ��Ѿ���ת����
   result:=dm.ADOQ.FieldValues['VOUCHER']
  else
   result:='';
end;

function TFrmMain.updateGL(const pCurrD,pCurrC:currency;vgl:integer;dbcr:char):boolean;
var
  parent_ptr:integer;
  parent_close:currency;
begin
 try
  if dbcr='D' then
   begin
    dm.DS103P.Parameters.ParamValues['debit'] := pCurrD;
    dm.DS103P.Parameters.ParamValues['credit'] := 0;
    dm.DS103P.Parameters.ParamValues['debit_orig'] := pCurrC;
    dm.DS103P.Parameters.ParamValues['credit_orig'] := 0;
    dm.DS103P.Parameters.ParamValues['rkey'] := vgl;
    dm.DS103P.Execute;
   end
  else
   begin
    dm.DS103P.Parameters.ParamValues['debit'] := 0;
    dm.DS103P.Parameters.ParamValues['credit'] := pCurrD;
    dm.DS103P.Parameters.ParamValues['debit_orig'] := 0;
    dm.DS103P.Parameters.ParamValues['credit_orig'] := pCurrC;
    dm.DS103P.Parameters.ParamValues['rkey'] := vgl;
    dm.DS103P.Execute;
   end;

  dm.DS103ZR.Close;
  dm.DS103ZR.Parameters[0].Value:=vgl;
  dm.DS103ZR.Open;
  dm.DS103ZR.Edit ;

 if dm.DS103ZRDB_CR.Value ='D' then
  begin
   dm.DS103ZRTYR_CLOSE.Value:= dm.DS103ZRTYR_OPEN.Value+
                              dm.DS103ZRCURRENT_PERIOD_DEBIT.Value-
                              dm.DS103ZRCURRENT_PERIOD_CREDIT.Value;
   dm.DS103ZRTYR_CLOSE_ORIG.Value:=dm.DS103ZRTYR_OPEN_ORIG.Value+
                               dm.DS103ZRCURRENT_PERIOD_DEBIT_ORIG.Value-
                               dm.DS103ZRCURRENT_PERIOD_CREDIT_ORIG.Value;
  end
 else
  begin
   dm.DS103ZRTYR_CLOSE.Value:= dm.DS103ZRTYR_OPEN.Value+
                               dm.DS103ZRCURRENT_PERIOD_CREDIT.Value-
                               dm.DS103ZRCURRENT_PERIOD_DEBIT.Value;
   dm.DS103ZRTYR_CLOSE_ORIG.Value:= dm.DS103ZRTYR_OPEN_ORIG.Value+
                               dm.DS103ZRCURRENT_PERIOD_CREDIT_ORIG.Value-
                               dm.DS103ZRCURRENT_PERIOD_DEBIT_ORIG.Value;
  end;
 dm.DS103ZR.Post;

  parent_ptr:=0;
  parent_close:=0;
  if GetPRkey(vgl,parent_ptr,parent_close) then
   updateGL(pCurrD,pCurrC,parent_ptr,dbcr);
  result:=true;
 except
  result:=false;
 end;
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

function TFrmMain.geTrans(const pVour:string):boolean; //���ɼ���ƾ֤
var
  mdt:Tdate;
  v_dsum,v_csum:Currency;
  vY,vM:word;
begin
 try
  result:=true;
  vY:=strtoint(edit1.text);
  vM:=strtoint(edit2.Text);
  mdt:=EndOfAMonth(vY,vM);    //���������ڵ�ǰ�·������һ��
  dm.ADODS0105.close;
  dm.ADODS0105.open;
  dm.ADODS0105.append;
  if pVour='' then
   dm.ADODS0105.fieldbyname('voucher').asstring:=getdh(mdt)
  else
   begin
    dm.ADOQ.Close;
    dm.ADOQ.SQL.Clear;
    dm.ADOQ.SQL.Text:='delete data0105 where VOUCHER='''+pVour+'''';
    dm.ADOQ.ExecSQL;
    dm.ADODS0105.fieldbyname('voucher').asstring:=pVour;
   end;

   dm.ADODS0105.Fieldbyname('entered_by_empl_ptr').asstring:=user_ptr; //¼����
   dm.ADODS0105.Fieldbyname('audited_by_empl_ptr').asstring:=user_ptr; //���
   dm.ADODS0105.Fieldbyname('posted_by_empl_ptr').asstring:=user_ptr;  //������
   dm.ADODS0105.Fieldbyname('entered_dt').asstring:=datetostr(mdt);                    //¼������
   dm.ADODS0105.Fieldbyname('FYEAR').Value := strtoint(edit1.Text);
   dm.ADODS0105.Fieldbyname('period').Value := strtoint(edit2.Text);
   dm.ADODS0105.fieldbyname('vou_type').asinteger:=4;           //ƾ֤����
   dm.ADODS0105.fieldbyname('TRANS_TYPE').asinteger:=9;         //ҵ������
   dm.ADODS0105.fieldbyname('special_posting').AsString:= 'Y';  //����״̬
   dm.ADODS0105.Fieldbyname('batch_number').asstring := '��ת����';
   dm.ADODS0105.fieldbyname('status').asinteger:=3;          //���״̬�ѵ���
   dm.ADODS0105.fieldbyname('posted_dt').asstring:=datetostr(mdt);
   dm.ADODS0105.Fieldbyname('supervisor_ptr').asstring:=user_ptr;
   dm.ADODS0105.Post;

  dm.ADODT0103.First ;

  dm.ADODS0106.open;
  v_csum:=0;
  v_dsum:=0;
  while not dm.ADODT0103.eof do
   begin
    if dm.ADODT0103DB_CR.Value='D' then  //����ڽ跽,��ת���浽����
     with DM.ADODS0106 do                               
      begin
       append;
       Fieldbyname('gl_header_ptr').asinteger:=dm.ADODS0105.fieldbyname('rkey').asinteger;
       Fieldbyname('gl_acct_no_ptr').asinteger:=DM.ADODT0103rkey.Value;
       Fieldbyname('ref_number').asstring:=DM.ADODT0103GL_ACC_NUMBER.Value;
       Fieldbyname('description').asstring:='��ת���浽'+
                                       trim(DM.ADODSProfitGL_DESCRIPTION.Value);
       Fieldbyname('CURR_PTR').asinteger:=1;  //����
       Fieldbyname('EXCH_RATE').asinteger:=1; //����
       Fieldbyname('D_C').asstring:='C';
       dm.ADODS0106AMOUNT.Value:=dm.ADODT0103TYR_CLOSE.Value;
       dm.ADODS0106PRICE.Value:=dm.ADODT0103TYR_CLOSE.Value;
       post;
       if not updateGL(dm.ADODT0103TYR_CLOSE.Value,dm.ADODT0103TYR_CLOSE.Value,
                       DM.ADODT0103rkey.Value,
                       dm.ADODS0106D_C.value[1]) then
        begin
         result:=false;
         break;
        end;
        v_csum:=v_csum+dm.ADODT0103TYR_CLOSE.Value;  //�����ϼ�
      end
    else                        //����ڴ���,��ת���浽�跽
     with DM.ADODS0106 do
      begin
       append;
       Fieldbyname('gl_header_ptr').asinteger:=dm.ADODS0105.fieldbyname('rkey').asinteger;
       Fieldbyname('gl_acct_no_ptr').asinteger:=DM.ADODT0103rkey.Value;
       Fieldbyname('ref_number').asstring:=DM.ADODT0103GL_ACC_NUMBER.Value;
       Fieldbyname('description').asstring:='��ת���浽'+
                                       trim(DM.ADODSProfitGL_DESCRIPTION.Value);
       Fieldbyname('CURR_PTR').asinteger:=1;  //����
       Fieldbyname('EXCH_RATE').asinteger:=1; //����
       Fieldbyname('D_C').asstring:='D';      
       dm.ADODS0106AMOUNT.Value:=dm.ADODT0103TYR_CLOSE.Value;
       dm.ADODS0106PRICE.Value:=dm.ADODT0103TYR_CLOSE.Value;
       post;
       if not updateGL(dm.ADODT0103TYR_CLOSE.Value,dm.ADODT0103TYR_CLOSE.Value,
                       DM.ADODT0103rkey.Value,
                       dm.ADODS0106D_C.value[1]) then
        begin               //����
         result:=false;
         break;
        end;
        v_dsum:=v_dsum+dm.ADODT0103TYR_CLOSE.Value;  //�跽�ϼ�
      end;
    dm.ADODT0103.Next ;
     ProgressBar1.Position :=
       trunc(100*dm.ADODT0103.recno/dm.ADODT0103.recordcount);
   end; //end while   �跽

  with DM.ADODS0106 do    //�豾�������Ŀ
   begin
    append;
    Fieldbyname('gl_header_ptr').asinteger:=dm.ADODS0105.fieldbyname('rkey').asinteger;
    Fieldbyname('gl_acct_no_ptr').asinteger:=DM.ADODSProfitrkey.Value;
    Fieldbyname('ref_number').asstring:=DM.ADODSProfitGL_ACC_NUMBER.Value;
    Fieldbyname('description').asstring:='��ת����';
    dm.ADODS0106AMOUNT.Value := v_csum;
    dm.ADODS0106PRICE.Value := v_csum;
    Fieldbyname('d_c').asstring:='D';
    Fieldbyname('CURR_PTR').asinteger:=1;  //����
    Fieldbyname('EXCH_RATE').asinteger:=1;  //����
    post;
    if not updateGL(v_csum,v_csum,DM.ADODSProfitrkey.Value,dm.ADODS0106D_C.value[1]) then
     result:=false;
   end;

  with DM.ADODS0106 do    //�����������Ŀ
   begin
    append;
    Fieldbyname('gl_header_ptr').asinteger:=dm.ADODS0105.fieldbyname('rkey').asinteger;
    Fieldbyname('gl_acct_no_ptr').asinteger:=DM.ADODSProfitrkey.Value;
    Fieldbyname('ref_number').asstring := DM.ADODSProfitGL_ACC_NUMBER.Value;
    Fieldbyname('description').asstring := '��ת����';
    dm.ADODS0106AMOUNT.Value := v_dsum;
    dm.ADODS0106PRICE.Value := v_dsum;
    Fieldbyname('d_c').asstring := 'C';
    Fieldbyname('CURR_PTR').asinteger:=1;  //����
    Fieldbyname('EXCH_RATE').asinteger:=1;  //����
    post;
    if not updateGL(v_dsum,v_dsum,DM.ADODSProfitrkey.Value,dm.ADODS0106D_C.value[1]) then
     result:=false;
   end;

 except
  on E: Exception do
   begin
    messagedlg(E.Message,mtinformation,[mbok],0);
    result:=false;
   end;
 end;
end;

procedure TFrmMain.BitBtn2Click(Sender: TObject);
begin
  application.Terminate;
end;

procedure TFrmMain.BitBtn1Click(Sender: TObject);
var
 gl_number:string;
begin

 with dm.ADOQ do
  begin
    close;
    sql.Text:=
    'select rkey,status,voucher,posted_dt from data0105 '+
    'where data0105.fyear= '+QuotedStr(Edit1.Text)+
    ' and data0105.period= '+QuotedStr(Edit2.Text)+
    ' and data0105.status<>3 and data0105.status<>5';
    Open;
   if not IsEmpty then
   begin
    messagedlg('�û���ڼ����δ���˵�ƾ֤,���ȵ���,�ٽ�ת!',mterror,[mbcancel],0);
    exit;
   end;
  end;
  
 dm.ADODT0103.Close;
 dm.ADODT0103.open;
 dm.ADODSProfit.Close;
 dm.ADODSProfit.open;
 if dm.ADODT0103.IsEmpty then
  begin
   messagedlg('û����Ҫ��ת���������ƿ�Ŀ���!',mtinformation,[mbok],0);
   exit;
  end;

 gl_number:=  finderror;
 if gl_number <> '' then
  begin
   messagedlg('�����������ƿ�Ŀû�ж���ɲ��������:'+gl_number,mterror,[mbcancel],0);
   exit;
  end;

 if dm.ADODSProfit.IsEmpty then
  begin
   messagedlg('�����ڻ���ҵ���ƴ������������ñ��������Ӧ�Ŀ�Ŀ����!',mtinformation,[mbok],0);
   exit;
  end;

 if getProfitPZ(3)<>'' then    //����Ƿ��Ѿ���ת
  begin
   messagedlg('�Ѿ�������ת������!',mtinformation,[mbok],0);
   exit;
  end;

 try
  dm.ADOCnn.BeginTrans ;
  screen.Cursor:=crHourGlass;

  if not SaveProfitTo110() then
   begin
    dm.ADOCnn.RollbackTrans ;
    screen.Cursor:=crDefault;
    messagedlg('��ת����ǰ����������ʧ��!',mterror,[mbcancel],0);
    exit;
   end;

  if geTrans(getProfitPZ(5))=false then  //���ɽ�תƾ֤ͬʱ�Զ�����
   begin
    dm.ADOCnn.RollbackTrans ;
    screen.Cursor:=crDefault;
    messagedlg('��ת�������ʧ��!',mterror,[mbcancel],0);
    exit;
   end;

  dm.ADOCnn.CommitTrans ;
  screen.Cursor:=crDefault;
  messagedlg('��ת����ɹ�!',mtinformation,[mbok],0);
  FrmMain.Close;
 except
  on E: Exception do
   begin
    dm.ADOCnn.RollbackTrans ;
    screen.Cursor:=crDefault;
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

 // user_ptr:='3';
  DateSeparator := '-';
  ShortDateFormat := 'yyyy-mm-dd';
end;

procedure TFrmMain.FormShow(Sender: TObject);
begin
if dm.ADOCnn.Connected then
  begin
  DM.ADODS0508.close ;
  DM.ADODS0508.Open ;
  edit1.text:=dm.ADODS0508.fieldbyname('curr_FYEAR').asstring;
  edit2.text:=dm.ADODS0508.fieldbyname('curr_period').asstring;
  end;
end;

end.
