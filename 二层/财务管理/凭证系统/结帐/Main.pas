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
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private

    function GetTrans():boolean;
    function GetFYTrans():boolean;
    function Get_profit_loss():boolean;   //��ת�����Ŀ
    procedure AddACCTo110();
  public
    { Public declarations }

  end;

var
  FrmMain: TFrmMain;

implementation

uses Datamodule,common;

{$R *.dfm}


function TFrmMain.GetFYTrans():boolean; //��ת�ɱ����ÿ�Ŀ
var
 vsql:string;
begin
 vsql:='SELECT Data0103.rkey from data0103';
 vsql:= vsql+' where Data0103.auto_trans_ptr > 0';
 vsql:= vsql+' and Data0103.tyr_close<>0';
 dm.ADOQ.close;
 dm.ADOQ.SQL.Clear;
 dm.ADOQ.SQL.Text:=vsql;
 dm.ADOQ.Open;
 if dm.ADOQ.IsEmpty then        //�ѽ�ת�ɱ�����
  result:=true
 else
  result:=false;
end;

function TFrmMain.Get_profit_loss():boolean;   //��ת�����Ŀ
var
 vsql:string;
begin
  dm.ADOQ.Close ;
  dm.ADOQ.SQL.Clear ;
  vSql :='select rkey from data0103';
  vSql:=vSql+' where ACC_TP=5';
  vSql:=vSql+' and tyr_close<>0';
  dm.ADOQ.SQL.Text :=vSql;
  dm.ADOQ.Open ;
 if dm.ADOQ.IsEmpty then
  result := true                //�ѽ�ת����
 else
  result := false;
end;

function TFrmMain.GetTrans():boolean;
var
 vsql:string;
begin
 vsql:='select rkey from data0105 ';
 vsql:= vsql+' where FYEAR='+edit1.Text;
 vsql:= vsql+' and PERIOD='+edit2.Text;
 vsql:= vsql+' and SPECIAL_POSTING =''D''';
 vsql:= vsql+' and STATUS =3';
 dm.ADOQ.close;
 dm.ADOQ.SQL.Clear;
 dm.ADOQ.SQL.Text:=vsql;
 dm.ADOQ.Open;
 if dm.ADOQ.IsEmpty then
  result:=false
 else
  result:=true;     //�����۾�
end;

procedure TFrmMain.AddACCTo110();   //������Ŀ��110
begin
 with dm.ADOQ do
 begin
  close;
  sql.Text:='SELECT RKEY,TYR_OPEN,TYR_OPEN_ORIG'+#13+
     'FROM dbo.Data0103'+#13+
     'WHERE (RKEY NOT IN'+#13+
          '(SELECT GL_ACCT_PTR'+#13+
         'FROM data0110'+#13+
         'WHERE FYEAR ='+edit1.Text+'))';
  open;
 end;

 with dm.ds0110 do
  begin
   close;
   sql.Text:='select FYEAR,GL_ACCT_PTR,TYR_OPEN,TYR_CLOSE,'+#13+
              'TYR_OPEN_ORIG,TYR_CLOSE_ORIG from data0110'+#13+
   'where rkey is null';
   open;
  end;

 while not dm.ADOQ.Eof do
  begin
   dm.ds0110.AppendRecord([strtoint(edit1.Text),
                           dm.ADOQ.FieldValues['RKEY'],
                           dm.ADOQ.FieldValues['TYR_OPEN'],
                           0,
                           dm.ADOQ.FieldValues['TYR_OPEN_ORIG'],
                           0]);
   dm.ADOQ.Next;
  end;
end;


procedure TFrmMain.BitBtn2Click(Sender: TObject);
begin
  application.Terminate;
end;

procedure TFrmMain.BitBtn1Click(Sender: TObject);
var tmpQry: TADOQuery;
begin
  WITH DM.DS0105 do
  begin
   close;
   parameters.ParamByName('vfyear').Value :=strtoint(edit1.Text);
   parameters.ParamByName('vperiod').Value :=strtoint(edit2.Text);
   open;
  end;
 if not dm.DS0105.IsEmpty then
  begin
   messagedlg('��鵽������ڼ仹��δ���ʵļ���ƾ֤�����Ƚ��е��ʺ��ٽ��ʣ�',mtinformation,[mbok],0);
   exit;
  end;

 if dm.DS0508.FieldByName('fasset_initlized').asinteger=1 then
  if not GetTrans() then
   begin
    messagedlg('��鵽������ڼ仹�м����۾ɷ��ã����ȼ����۾ɣ�',mtinformation,[mbok],0);
    exit;
   end;

  if not GetFYTrans() then
  begin
   messagedlg('��鵽��û�н�ת�ĳɱ����ã����Ƚ��з����ٽ��ʣ�',mtinformation,[mbok],0);
   exit;
  end;

  if not Get_profit_loss() then
  begin
   messagedlg('��鵽��û�н�ת���������Ŀ�����Ƚ��н�ת���ٽ��ʣ�',mtinformation,[mbok],0);
   exit;
  end;

  tmpQry:= TADOQuery.Create(nil);
  with tmpQry do
  try
    Connection:= dm.Conn;
    Close;
    SQL.Clear;
//    SQL.Add('select t103.rkey from data0103 t103 ');
//    SQL.Add('where not exists(select t110.GL_ACCT_PTR from Data0110 t110');
//    SQL.Add(' where t110.FYEAR = '''+Edit1.Text+'''');
//    SQL.Add(' and t110.GL_ACCT_PTR = t103.RKEY)');

    SQL.Add('select t106.GL_ACCT_NO_PTR');
    SQL.Add('from data0105 t105 inner join data0106 t106 on t105.RKEY=t106.GL_HEADER_PTR');
    SQL.Add('where t105.fyear='''+Edit1.Text+'''');
    SQL.Add('and t105.period='''+Edit2.Text+'''');
    SQL.Add('and not exists(select t110.GL_ACCT_PTR from Data0110 t110');
    SQL.Add('				        where t110.FYEAR = '''+Edit1.Text+'''');
    SQL.Add('				        and t110.GL_ACCT_PTR = t106.GL_ACCT_NO_PTR)');
    Open;
    if RecordCount<>0 then
    begin
      messagedlg('ƾ֤�д����»�ƿ�Ŀ������ϵϵͳ����Ա��',mtinformation,[mbok],0);
      Exit;
    end;
  finally
    Free;
  end;
  
 if messagedlg('�Ƿ�ȷ��Ҫ������ǰ����ڼ䣿',mtconfirmation,[mbYes,mbNo],0)<>mrYes
  then exit;

  try
   dm.Conn.BeginTrans ;

   with dm.ADOQ do       //�޸ı���û�з�����Ŀ�Ŀ
    begin               //��δ�������ڳ����
     close;
     sql.Text:='update data0103'+#13+
              'set tyr_close=TYR_OPEN'+#13+
              'where (CURRENT_PERIOD_DEBIT=0) and '+#13+
              '(CURRENT_PERIOD_CREDIT=0)';
     ExecSQL;
    end;
   with dm.ADOQ do       //�޸ı���û�з�����Ŀ�Ŀ
    begin               //��δ�������ڳ����
     close;
     sql.Text:='update data0103'+#13+
              'set tyr_close_orig=TYR_OPEN_orig'+#13+
              'where (CURRENT_PERIOD_DEBIT_ORIG=0) and '+#13+
              '(CURRENT_PERIOD_CREDIT_ORIG=0)';
     ExecSQL;
    end;

    WITH DM.DS0110 do
     begin
      close;
      sql.Text:='update data0110'+#13+
        'set TYR_PERIOD_'+edit2.Text+'_DEBIT=Data0103.CURRENT_PERIOD_DEBIT,'+#13+
        'TYR_PERIOD_'+edit2.Text+'_CREDIT=Data0103.CURRENT_PERIOD_CREDIT,'+#13+
        'TYR_PERIOD_'+edit2.Text+'_CLOSE=Data0103.TYR_CLOSE,'+#13+
        'TYR_PERIOD_'+edit2.Text+'_DEBIT_ORIG=Data0103.CURRENT_PERIOD_DEBIT_ORIG,'+#13+
        'TYR_PERIOD_'+edit2.Text+'_CREDIT_ORIG=Data0103.CURRENT_PERIOD_CREDIT_ORIG,'+#13+
        'TYR_PERIOD_'+edit2.Text+'_CLOSE_ORIG=Data0103.TYR_CLOSE_ORIG,'+#13+
        'TYR_DEBIT=data0110.TYR_DEBIT+Data0103.CURRENT_PERIOD_DEBIT,'+#13+
        'TYR_CREDIT=data0110.TYR_CREDIT+Data0103.CURRENT_PERIOD_CREDIT,'+#13+
        'TYR_DEBIT_ORIG=data0110.TYR_DEBIT_ORIG+Data0103.CURRENT_PERIOD_DEBIT_ORIG,'+#13+
        'TYR_CREDIT_ORIG=data0110.TYR_CREDIT_ORIG+Data0103.CURRENT_PERIOD_CREDIT_ORIG,'+#13+
        'TYR_CLOSE = Data0103.TYR_CLOSE,'+#13+
        'TYR_CLOSE_ORIG = Data0103.TYR_CLOSE_ORIG'+#13+
        'FROM dbo.Data0110 INNER JOIN'+#13+
        'dbo.Data0103 ON dbo.Data0110.GL_ACCT_PTR = dbo.Data0103.RKEY'+#13+
        'WHERE dbo.Data0110.FYEAR ='+edit1.Text;
      execsql;
     end;

    if  strtoint(edit2.text)=1 then  //�����ǰ����ڼ�Ϊһ�·�
     with dm.ADOQ do            //���챾�ڽ���ϼ�
      begin
       close;
       sql.Text:='update data0103'+#13+
                'set TYR_DEBIT=0,'+#13+
                'TYR_CREDIT=0,'+#13+
                'TYR_DEBIT_ORIG=0,'+#13+
                'TYR_CREDIT_ORIG=0';
       ExecSQL;
      end;

    with dm.ds0103 do   //�ۼƱ�����,���쵱ǰ�ڼ���,��δ���
     begin
      close;
      execsql;
     end;

    {*****���˼�� Begin*****}
    if Edit2.Text = '1' then
    with dm.ADOQ do            //����ȴ���
    begin
      close;
      sql.Text:=
      'select t1.GL_ACCT_PTR,t2.GL_ACC_NUMBER from Data0110 t1 inner join Data0103 t2 on t1.GL_ACCT_PTR = t2.RKEY'+#13+
      'where t1.FYEAR = '+edit1.Text+' and t2.DB_CR = ''D'''+#13+
      'and t1.TYR_OPEN+t1.TYR_PERIOD_1_DEBIT-t1.TYR_PERIOD_1_CREDIT<>t1.TYR_PERIOD_1_CLOSE'+#13+
      'union'+#13+
      'select t1.GL_ACCT_PTR,t2.GL_ACC_NUMBER from Data0110 t1 inner join Data0103 t2 on t1.GL_ACCT_PTR = t2.RKEY'+#13+
      'where t1.FYEAR = '+edit1.Text+' and t2.DB_CR = ''C'''+#13+
      'and t1.TYR_OPEN+t1.TYR_PERIOD_1_CREDIT-t1.TYR_PERIOD_1_DEBIT<>t1.TYR_PERIOD_1_CLOSE';
      open;
    end
    else
    {�����ƿ�Ŀ�ڽ跽: ������ĩ���+���ڽ跽���-���ڴ������ = ������ĩ���
     �����ƿ�Ŀ�ڴ���: ������ĩ���+���ڴ������-���ڽ跽��� = ������ĩ���}
    with dm.ADOQ do
    begin
      close;
      sql.Text:=
      'select t1.GL_ACCT_PTR,t2.GL_ACC_NUMBER from Data0110 t1'+#13+
      'inner join Data0103 t2 on t1.GL_ACCT_PTR = t2.RKEY'+#13+
      'where t1.FYEAR = '+edit1.Text+' and t2.DB_CR =''D'''+#13+
      'and t1.TYR_PERIOD_'+IntToStr(StrToInt(edit2.Text)-1)+'_CLOSE+t1.TYR_PERIOD_'+edit2.Text+'_DEBIT-t1.TYR_PERIOD_'+edit2.Text+'_CREDIT<>t1.TYR_PERIOD_'+edit2.Text+'_CLOSE'+#13+
      'union'+#13+
      'select t1.GL_ACCT_PTR,t2.GL_ACC_NUMBER from Data0110 t1'+#13+
      'inner join Data0103 t2 on t1.GL_ACCT_PTR = t2.RKEY'+#13+
      'where t1.FYEAR = '+edit1.Text+' and t2.DB_CR =''C'''+#13+
      'and t1.TYR_PERIOD_'+IntToStr(StrToInt(edit2.Text)-1)+'_CLOSE+t1.TYR_PERIOD_'+edit2.Text+'_CREDIT-t1.TYR_PERIOD_'+edit2.Text+'_DEBIT<>t1.TYR_PERIOD_'+edit2.Text+'_CLOSE';
      open;
    end;
    if dm.ADOQ.RecordCount <> 0 then
    begin
      dm.Conn.RollbackTrans;
      MessageDlg('����ʧ��,����:'+dm.ADOQ.fieldbyname('GL_ACC_NUMBER').AsString,  mtError, [mbOK], 0);
      Exit;
    end;
    {*****���˼��   End*****}

    {*****������Ҽ�� Begin*****}
    if Edit2.Text = '1' then
    with dm.ADOQ do            //����ȴ���
    begin
      close;
      sql.Text:=
      'select t1.GL_ACCT_PTR,t2.GL_ACC_NUMBER from Data0110 t1 inner join Data0103 t2 on t1.GL_ACCT_PTR = t2.RKEY'+#13+
      'where t1.FYEAR = '+edit1.Text+' and t2.DB_CR = ''D'' and t2.CURR_TP = 2 and t2.HAS_CHILD = 0'+#13+
      'and t1.TYR_OPEN_ORIG+t1.TYR_PERIOD_1_DEBIT_ORIG-t1.TYR_PERIOD_1_CREDIT_ORIG<>t1.TYR_PERIOD_1_CLOSE_ORIG'+#13+
      'union'+#13+
      'select t1.GL_ACCT_PTR,t2.GL_ACC_NUMBER from Data0110 t1 inner join Data0103 t2 on t1.GL_ACCT_PTR = t2.RKEY'+#13+
      'where t1.FYEAR = '+edit1.Text+' and t2.DB_CR = ''C'' and t2.CURR_TP = 2 and t2.HAS_CHILD = 0'+#13+
      'and t1.TYR_OPEN_ORIG+t1.TYR_PERIOD_1_CREDIT_ORIG-t1.TYR_PERIOD_1_DEBIT_ORIG<>t1.TYR_PERIOD_1_CLOSE_ORIG';
      open;
    end
    else
    {�����ƿ�Ŀ�ڽ跽: ������ĩ���+���ڽ跽���-���ڴ������ = ������ĩ���
     �����ƿ�Ŀ�ڴ���: ������ĩ���+���ڴ������-���ڽ跽��� = ������ĩ���}
    with dm.ADOQ do
    begin
      close;
      sql.Text:=
      'select t1.GL_ACCT_PTR,t2.GL_ACC_NUMBER from Data0110 t1'+#13+
      'inner join Data0103 t2 on t1.GL_ACCT_PTR = t2.RKEY'+#13+
      'where t1.FYEAR = '+edit1.Text+' and t2.DB_CR =''D'' and t2.CURR_TP = 2 and t2.HAS_CHILD = 0'+#13+
      'and t1.TYR_PERIOD_'+IntToStr(StrToInt(edit2.Text)-1)+'_CLOSE_ORIG+t1.TYR_PERIOD_'+edit2.Text+'_DEBIT_ORIG-t1.TYR_PERIOD_'+edit2.Text+'_CREDIT_ORIG<>t1.TYR_PERIOD_'+edit2.Text+'_CLOSE_ORIG'+#13+
      'union'+#13+
      'select t1.GL_ACCT_PTR,t2.GL_ACC_NUMBER from Data0110 t1'+#13+
      'inner join Data0103 t2 on t1.GL_ACCT_PTR = t2.RKEY'+#13+
      'where t1.FYEAR = '+edit1.Text+' and t2.DB_CR =''C'' and t2.CURR_TP = 2 and t2.HAS_CHILD = 0'+#13+
      'and t1.TYR_PERIOD_'+IntToStr(StrToInt(edit2.Text)-1)+'_CLOSE_ORIG+t1.TYR_PERIOD_'+edit2.Text+'_CREDIT_ORIG-t1.TYR_PERIOD_'+edit2.Text+'_DEBIT_ORIG<>t1.TYR_PERIOD_'+edit2.Text+'_CLOSE_ORIG';
      open;
    end;
    if dm.ADOQ.RecordCount <> 0 then
    begin
      dm.Conn.RollbackTrans;
      MessageDlg('���������ʧ��,����:'+dm.ADOQ.fieldbyname('GL_ACC_NUMBER').AsString,  mtError, [mbOK], 0);
      Exit;
    end;
    {*****������Ҽ��   End*****}

    dm.DS0508.edit;
    dm.DS0508.FieldByName('depre_flag').asinteger:=0;              //�����۾�
    dm.DS0508.fieldbyname('curr_period').Value:=
    dm.DS0508.fieldbyname('curr_period').Value+1;                //����ڼ�

    if dm.DS0508.fieldbyname('curr_period').Value>12 then          //��12��
     begin
      dm.DS0508.fieldbyname('curr_fyear').Value:=
      dm.DS0508.fieldbyname('curr_fyear').Value+1;              //������
      dm.DS0508.fieldbyname('curr_period').Value:=1;
     end;
    dm.DS0508.Post;

   edit1.text:=DM.DS0508.fieldbyname('curr_FYEAR').asstring;
   edit2.text:=DM.DS0508.fieldbyname('curr_period').asstring;

   AddACCTo110;

    dm.Conn.CommitTrans ;
    messagedlg('�Ѿ���ʼ�µĻ���ڼ�!',mtinformation,[mbok],0);
    FrmMain.close;
  except
   on E: Exception do
     begin
      dm.Conn.RollbackTrans ;
      messagedlg(e.Message,mtinformation,[mbok],0);
     end;
  end;
end;

procedure TFrmMain.FormCreate(Sender: TObject);

begin
  if not App_Init(dm.Conn) then
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
if dm.Conn.Connected then
  begin

   DM.DS0508.close ;
   DM.DS0508.Open ;

   edit1.text:=DM.DS0508.fieldbyname('curr_FYEAR').asstring;
   edit2.text:=DM.DS0508.fieldbyname('curr_period').asstring;
  end;
end;

end.

