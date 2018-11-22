unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ComCtrls, ExtCtrls, StdCtrls, DBCtrls, Grids, DBGrids, Mask,
  Menus, ADODB, Buttons, Spin,DateUtils;

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

    function GetTrans():integer;
    function GetPRkey(prky:integer;var parent_ptr:integer):boolean;
    function updateGL(const pCurrD,pCurrC:currency;vgl:integer;dbcr:char):boolean;
    function Restore103(const prkey:integer):boolean;    //�ָ�103
    procedure update_110_PROFIT(rkey103:integer;typ_close:currency);
    function SaveBeforClose():boolean;
    function DelTrans(const prkey:integer):boolean;     //����ƾ֤
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

uses udm,common;

{$R *.dfm}
function TFrmMain.GetPRkey(prky:integer;var parent_ptr:integer):boolean;
begin
 dm.ADOQ.Close;
 dm.ADOQ.SQL.Text:='SELECT PARENT_PTR'+#13+
                   'FROM Data0103'+#13+
                   'WHERE RKEY ='+inttostr(prky);
 dm.ADOQ.Open;
 if dm.ADOQ.FieldValues['PARENT_PTR']>0 then
  begin
   parent_ptr:=dm.ADOQ.FieldValues['PARENT_PTR'];
   result:=true;
  end
 else
  result:=false;
end;

function TFrmMain.updateGL(const pCurrD,pCurrC:currency; vgl:integer;dbcr:char):boolean;
var
  parent_ptr:integer;
begin
 try
 if dbcr='D' then
  begin
   dm.DS0103.Close;
   dm.DS0103.Parameters.ParamValues['debit'] := pCurrD;
   dm.DS0103.Parameters.ParamValues['credit'] := 0;
   dm.DS0103.Parameters.ParamValues['debit_orig'] := pCurrC;
   dm.DS0103.Parameters.ParamValues['credit_orig'] := 0;
   dm.DS0103.Parameters.ParamValues['rkey'] := vgl;
   dm.ds0103.ExecSQL;
  end
  else
   begin
    dm.DS0103.Close;
    dm.DS0103.Parameters.ParamValues['debit'] := 0;
    dm.DS0103.Parameters.ParamValues['credit'] := pCurrD;
    dm.DS0103.Parameters.ParamValues['debit_orig'] := 0;
    dm.DS0103.Parameters.ParamValues['credit_orig'] := pCurrC;
    dm.DS0103.Parameters.ParamValues['rkey'] := vgl;
    dm.ds0103.ExecSQL;
   end;

  dm.DS103P.Close;
  dm.DS103P.Parameters[0].Value:=vgl;
  dm.DS103P.Open;
  dm.DS103P.Edit;
  if dm.DS103PDB_CR.Value ='D' then
   begin
    dm.DS103PTYR_CLOSE.Value:= dm.DS103PTYR_OPEN.Value+
                              dm.DS103PCURRENT_PERIOD_DEBIT.Value-
                              dm.DS103PCURRENT_PERIOD_CREDIT.Value;
    dm.ds103pTYR_CLOSE_ORIG.Value:= dm.ds103pTYR_OPEN_ORIG.Value+
                              dm.ds103pCURRENT_PERIOD_DEBIT_ORIG.Value-
                              dm.ds103pCURRENT_PERIOD_CREDIT_ORIG.Value;
   end
  else
   begin
    dm.DS103PTYR_CLOSE.Value:= dm.DS103PTYR_OPEN.Value+
                              dm.DS103PCURRENT_PERIOD_CREDIT.Value-
                              dm.DS103PCURRENT_PERIOD_DEBIT.Value;
    dm.ds103pTYR_CLOSE_ORIG.Value:= dm.ds103pTYR_OPEN_ORIG.Value+
                              dm.ds103pCURRENT_PERIOD_CREDIT_ORIG.Value-
                              dm.ds103pCURRENT_PERIOD_DEBIT_ORIG.Value;
   end;
 dm.DS103P.Post;

 parent_ptr:=0;
 if self.GetPRkey(vgl,parent_ptr) then
  updateGL(pCurrD,pCurrC,parent_ptr,dbcr);

  result:=true;
 except
  result:=false;
 end;
end;


function TFrmMain.GetTrans():integer;
var
 vsql:string;
begin
 vsql:='select rkey from data0105 ';
 vsql:= vsql+' where FYEAR='+edit1.Text;
 vsql:= vsql+' and PERIOD='+edit2.Text;
 vsql:= vsql+' and SPECIAL_POSTING =''A''';
 vsql:= vsql+' and STATUS =3';
 dm.ADOQ.close;
 dm.ADOQ.SQL.Clear;
 dm.ADOQ.SQL.Text:=vsql;
 dm.ADOQ.Open;
 if dm.ADOQ.IsEmpty then
  result:=0
 else
  result:=dm.ADOQ.FieldValues['rkey'];
end;

function TFrmMain.Restore103(const prkey:integer):boolean;
begin         //�ָ����ÿ�Ŀ����ת����ǰ״̬
 try
  result:=true; 
  dm.DS0106.Close;
  dm.DS0106.Parameters.ParamByName('vrkey').Value :=prkey;
  dm.DS0106.open;
  dm.DS0106.First;
  while not dm.DS0106.eof do
   begin
    if not updategl(dm.DS0106AMOUNT.Value,dm.DS0106AMOUNT.Value,
                    dm.DS0106GL_ACCT_NO_PTR.Value,
                    dm.DS0106D_C.Value[1]) then
      begin
       result:=false;
       break;
      end;
    dm.DS0106.next;
    ProgressBar1.Position :=
     trunc(100*dm.DS0106.recno/dm.DS0106.recordcount);
   end;//while
 except
  result:=false;
 end;
end;

function TFrmMain.DelTrans(const prkey:integer):boolean;
var                       //*******���ϼ���ƾ֤*******//
  msql:string;
begin
 try
  dm.ADOQ.Close;
  dm.ADOQ.SQL.Clear ;
  msql:='update Data0105';
  msql:=msql+' set STATUS =5';
  msql:=msql+' where (rkey='+inttostr(prkey)+')';
  dm.ADOQ.SQL.text:=msql;
  dm.ADOQ.ExecSQL;
  result:=true; 
 except
   result:=false;
 end;
end;


procedure TFrmMain.update_110_PROFIT(rkey103:integer;typ_close:currency);
var
 parent_ptr:integer;
begin
  dm.ds110.Close;
  dm.DS110.Parameters.ParamByName('vY').Value:=strtoint(edit1.Text);
  dm.DS110.Parameters.ParamByName('rkey103').Value:=rkey103;
  dm.ds110.open;

  dm.ds110.edit;
  dm.ds110.fieldbyname('TYR_PERIOD_'+edit2.Text+'_PROFIT').AsCurrency:=typ_close;  
  dm.DS110.Post;

  parent_ptr:=0;
  if self.GetPRkey(rkey103,parent_ptr) then
  update_110_PROFIT(parent_ptr,0);
end;

function TFrmMain.SaveBeforClose():boolean;
begin
 try
  dm.ADOQ.Close;  //����Ҫ����ת����δ�ɱ����õ��������
  dm.ADOQ.SQL.Clear;
  dm.ADOQ.SQL.Text:='update data0110'+#13+
      'set TYR_PERIOD_'+edit2.Text+'_PROFIT = 0'+#13+
      'FROM Data0103 INNER JOIN'+#13+
      'Data0110 ON Data0103.RKEY = Data0110.GL_ACCT_PTR INNER JOIN'+#13+
      'Data0103 Data0103_1 ON Data0103.auto_trans_ptr = Data0103_1.RKEY'+#13+
      'WHERE (dbo.Data0103.ACC_TP = 4)'+#13+
      'AND (Data0110.FYEAR ='+edit1.Text+')';
  dm.ADOQ.ExecSQL;

  dm.ADOQ.Close;  //���ɱ����ÿ�Ŀ�Զ���תָ���Ŀ�Ŀ����
  dm.ADOQ.SQL.Clear;
  dm.ADOQ.SQL.Text:='SELECT Data0103.auto_trans_ptr'+#13+
   'FROM Data0103 INNER JOIN'+#13+
   'Data0103 Data0103_1 ON'+#13+
   'Data0103.auto_trans_ptr = Data0103_1.RKEY'+#13+
   'WHERE (Data0103.ACC_TP = 4)'+#13+
   'GROUP BY Data0103.auto_trans_ptr';
  dm.ADOQ.Open;

  while not dm.ADOQ.Eof do
   begin
    update_110_PROFIT(dm.ADOQ.Fieldbyname('auto_trans_ptr').AsInteger,
                      0);
    dm.ADOQ.Next;
   end;

  result:=true;
 except
  result:=false;
 end;
end;

procedure TFrmMain.BitBtn2Click(Sender: TObject);
begin
application.Terminate;
end;

//********1.�ָ��������Ŀ����ת����ǰ״̬                 ********
//********2.���±��������Ŀ.���ڽ��=���ڽ��-sum(�����Ŀ�������)
//********3.���±��������Ŀ.������=������-sum(�����Ŀ�������)
//********4.ɾ��ת��ƾ֤                                   ********
//********5.sum(�ӿ�Ŀ���ڷ�����衢��))                 ********
//********6.sum(�ӿ�Ŀ�������󣨽衢��))                   ********
//********7.sum(�ӿ�Ŀ������衢��))                   ********
//********8.sum(�ӿ�Ŀ��ĩ���衢��))                  ********
//*****************************************************************
procedure TFrmMain.BitBtn1Click(Sender: TObject);
begin

  if GetTrans()=0 then
   begin
    messagedlg('����û�н�ת�ɱ����õ�ƾ֤��',mtinformation,[mbok],0);
    exit;
   end;

  dm.ADOCnn.BeginTrans ;
  screen.Cursor:=crHourGlass;
  try

  if not SaveBeforClose() then //110��δ������
   begin
    dm.ADOCnn.RollbackTrans ;
    screen.Cursor:=crDefault;
    messagedlg('����ת�ɱ�����ǰ���������ʧ��!',mterror,[mbcancel],0);
    exit;
   end;

  if not Restore103(GetTrans()) then
   begin
    dm.ADOCnn.RollbackTrans ;
    screen.Cursor:=crDefault;
    messagedlg('����ת�ɱ����ò���ʧ��!',mterror,[mbcancel],0);
    exit;
   end;

  if not DelTrans(GetTrans()) then  //���Զ���ת��ƾ֤�������˴���
   begin
    dm.ADOCnn.RollbackTrans ;
    screen.Cursor:=crDefault;
    messagedlg('����ƾ֤����ʧ��!',mterror,[mbcancel],0);
    exit;
   end;

  dm.ADOCnn.CommitTrans;
  screen.Cursor:=crDefault;
  messagedlg('����ת�ɱ��������!',mtinformation,[mbok],0);
  FrmMain.Close;
 except
  on E: Exception do
   begin
    dm.ADOCnn.RollbackTrans ;
    screen.Cursor:=crDefault;
    messagedlg(E.Message,mterror,[mbcancel],0);
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
if dm.ADOCnn.Connected then
  begin

   DM.DS0508.close ;
   DM.DS0508.Open ;
   edit1.text:=dm.DS0508.fieldbyname('curr_FYEAR').asstring;
   edit2.text:=dm.DS0508.fieldbyname('curr_period').asstring;
  end;
end;

end.
