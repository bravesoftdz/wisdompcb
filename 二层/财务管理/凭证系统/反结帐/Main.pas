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

  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

uses Datamodule,common;

{$R *.dfm}

procedure TFrmMain.BitBtn2Click(Sender: TObject);
begin
  application.Terminate;
end;

procedure TFrmMain.BitBtn1Click(Sender: TObject);
var
  CurrDate: TDatetime;
begin
  CurrDate:= EncodeDate(StrToInt(Edit1.Text), StrToInt(Edit2.Text), 1);
  if dm.DS0508.fieldbyname('CONTROL_DATE').AsDateTime>=CurrDate then
  begin
    messagedlg('��ǰ����ڼ�����ڲ����ʼ��Ŀ����֮��',mtinformation,[mbok],0);
    exit;
  end;

 WITH DM.DS0105 do
  begin
   close;
   parameters.ParamByName('vfyear').Value :=strtoint(edit1.Text);
   parameters.ParamByName('vperiod').Value :=strtoint(edit2.Text);
   open;
  end;

 if dm.DS0105.recordcount>0 then
  begin
   messagedlg('��鵽��ǰ����ڼ����ѵ��˵�ƾ֤���Ƚ��з����ˣ�',mtinformation,[mbok],0);
   exit;
  end;

if dm.DS0508.fieldbyname('fasset_initlized').AsInteger = 1 then //�����ù̶��ʲ�
if dm.DS0508.fieldbyname('depre_flag').Value = 1 then      //�Ѽ����۾�
 begin
  messagedlg('�����Ѿ������۾ɣ����ȷ������۾�',mtinformation,[mbok],0);
  exit;
 end;

 if  messagedlg('ȷ��Ҫ�Ե�ǰ����ڼ���з�������',mtconfirmation,[mbYes,mbNo],0)=mrYes then 
 try
  dm.Conn.BeginTrans ;

  dm.DS0508.edit;

  if dm.DS0508.fieldbyname('fasset_initlized').AsInteger = 1 then //�����ù̶��ʲ�
  dm.DS0508.FieldByName('depre_flag').asinteger:=1;             //�Ѽ����۾�

  dm.DS0508.fieldbyname('curr_period').Value:=
    dm.DS0508.fieldbyname('curr_period').Value-1;                //����ڼ�

  if dm.DS0508.fieldbyname('curr_period').Value < 1 then          //��12��
   begin
    dm.ADOQ.Close ;
    dm.ADOQ.SQL.Text:='DELETE Data0110 WHERE FYEAR ='+edit1.Text;
    dm.ADOQ.ExecSQL;
    dm.DS0508.fieldbyname('curr_fyear').Value:=
    dm.DS0508.fieldbyname('curr_fyear').Value-1;              //������
    dm.DS0508.fieldbyname('curr_period').Value:=12;
   end;
  dm.DS0508.Post;

 edit1.text:=DM.DS0508.fieldbyname('curr_FYEAR').asstring;
 edit2.text:=DM.DS0508.fieldbyname('curr_period').asstring;

  WITH DM.DS0110 do //����103��110��ȡ��ֵ��ǰ���,��δ���,�����ۼ�(����ԭ��)
   begin
    close;
    sql.Text:='update data0103'+#13+
      'set CURRENT_PERIOD_DEBIT = Data0110.TYR_PERIOD_'+edit2.Text+'_DEBIT,'+#13+
      'CURRENT_PERIOD_CREDIT = Data0110.TYR_PERIOD_'+edit2.Text+'_CREDIT,'+#13+
      'TYR_CLOSE = Data0110.TYR_PERIOD_'+edit2.Text+'_CLOSE,'+#13+
      'CURRENT_PERIOD_DEBIT_ORIG = Data0110.TYR_PERIOD_'+edit2.Text+'_DEBIT_ORIG,'+#13+
      'CURRENT_PERIOD_CREDIT_ORIG = Data0110.TYR_PERIOD_'+edit2.Text+'_CREDIT_ORIG,'+#13+
      'TYR_CLOSE_ORIG = Data0110.TYR_PERIOD_'+edit2.Text+'_CLOSE_ORIG,'+#13+
      'TYR_DEBIT=data0103.TYR_DEBIT-Data0110.TYR_PERIOD_'+edit2.Text+'_DEBIT,'+#13+
      'TYR_CREDIT=data0103.TYR_CREDIT-Data0110.TYR_PERIOD_'+edit2.Text+'_CREDIT,'+#13+
      'TYR_DEBIT_ORIG=data0103.TYR_DEBIT_ORIG-Data0110.TYR_PERIOD_'+edit2.Text+'_DEBIT_ORIG,'+#13+
      'TYR_CREDIT_ORIG=data0103.TYR_CREDIT_ORIG-Data0110.TYR_PERIOD_'+edit2.Text+'_CREDIT_ORIG'+#13+
      'FROM Data0110 INNER JOIN'+#13+
      'Data0103 ON dbo.Data0110.GL_ACCT_PTR = dbo.Data0103.RKEY'+#13+
      'WHERE Data0110.FYEAR ='+edit1.Text;
    execsql;
   end;

  //��1�·ݷ����˵���һ���12�·�ʱ��,�����1�·������Ŀ�Ŀ��Ҫ�ڴ˴��������⴦��
  WITH DM.DS0110 do
   begin
    close;
    sql.Text:='update Data0103'+#13+
              'set CURRENT_PERIOD_DEBIT=0,CURRENT_PERIOD_CREDIT=0,TYR_CLOSE=0,'+#13+
              'CURRENT_PERIOD_DEBIT_ORIG=0,CURRENT_PERIOD_CREDIT_ORIG=0,TYR_CLOSE_ORIG=0'+#13+
              'where not exists(select 1 from Data0110 t110'+#13+
              '                 where Data0103.RKEY = t110.GL_ACCT_PTR'+#13+
              '                 and t110.FYEAR = '+edit1.Text+')';
    execsql;
   end;

  if strtoint(edit2.Text)-1 > 0 then//������֮����ڼ���ڵ���2
  WITH DM.DS0110 do //����110������δ���
   begin
    close;
    sql.Text:='update data0110'+#13+
          'set TYR_CLOSE = TYR_PERIOD_'+inttostr(strtoint(edit2.Text)-1)+'_CLOSE,'+#13+
          'TYR_CLOSE_ORIG = TYR_PERIOD_'+inttostr(strtoint(edit2.Text)-1)+'_CLOSE_ORIG'+#13+
      'FROM Data0110'+#13+
      'WHERE Data0110.FYEAR ='+edit1.Text;
    execsql;
   end
  else
    WITH DM.DS0110 do //����110������δ���
     begin
      close;
      sql.Text:='update data0110'+#13+
                'set TYR_CLOSE=0,'+#13+
                'TYR_CLOSE_ORIG=0'+#13+
        'FROM Data0110'+#13+
        'WHERE Data0110.FYEAR ='+edit1.Text;
      execsql;
     end;

  WITH DM.DS0110 do //����110��ǰ���,��δ��� ,�����ۼ�(ԭ��,����)
   begin
    close;
    sql.Text:='update data0110'+#13+
          'set TYR_DEBIT=TYR_DEBIT-TYR_PERIOD_'+edit2.Text+'_DEBIT,'+#13+
          'TYR_CREDIT=TYR_CREDIT-TYR_PERIOD_'+edit2.Text+'_CREDIT,'+#13+
          'TYR_DEBIT_ORIG=TYR_DEBIT_ORIG-TYR_PERIOD_'+edit2.Text+'_DEBIT_ORIG,'+#13+
          'TYR_CREDIT_ORIG=TYR_CREDIT_ORIG-TYR_PERIOD_'+edit2.Text+'_CREDIT_ORIG,'+#13+
          'TYR_PERIOD_'+edit2.Text+'_DEBIT=0,'+#13+
          'TYR_PERIOD_'+edit2.Text+'_CREDIT=0,'+#13+
          'TYR_PERIOD_'+edit2.Text+'_CLOSE=0,'+#13+
          'TYR_PERIOD_'+edit2.Text+'_DEBIT_ORIG=0,'+#13+
          'TYR_PERIOD_'+edit2.Text+'_CREDIT_ORIG=0,'+#13+
          'TYR_PERIOD_'+edit2.Text+'_CLOSE_ORIG=0'+#13+
      'FROM Data0110'+#13+
      'WHERE Data0110.FYEAR ='+edit1.Text;
    execsql;
   end;

  with dm.ADOQ do     //����103�ڳ����
   begin
    close;
    sql.Text:='update data0103'+#13+
      'set TYR_OPEN=tyr_close+current_period_credit-current_period_debit,'+#13+
      'TYR_OPEN_ORIG=tyr_close_orig+current_period_credit_orig-current_period_debit_orig'+#13+
      'where DB_CR=''D''';
    ExecSQL;
   end;

  with dm.ADOQ do
   begin
    close;
    sql.Text:='update data0103'+#13+
      'set TYR_OPEN=tyr_close+current_period_debit-current_period_credit,'+#13+
      'TYR_OPEN_ORIG=tyr_close_orig+current_period_debit_orig-current_period_credit_orig'+#13+
      'where DB_CR=''C''';
    ExecSQL;
   end;

  dm.Conn.CommitTrans ;
  messagedlg('�ɹ����ص���һ������ڼ�!',mtinformation,[mbok],0);
  FrmMain.close;
 except
  on E: Exception do
   begin
    dm.Conn.RollbackTrans ;
    showmessage(e.Message);
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
if  dm.Conn.Connected then
  begin
   DM.DS0508.close ;
   DM.DS0508.Open ;
   edit1.text:=DM.DS0508.fieldbyname('curr_FYEAR').asstring;
   edit2.text:=DM.DS0508.fieldbyname('curr_period').asstring;
  end;
end;

end.

