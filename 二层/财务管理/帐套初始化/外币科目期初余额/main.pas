unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DB, ExtCtrls, Grids, DBGrids, ADODB;

type
  TForm1 = class(TForm)
    ADOConnection1: TADOConnection;
    ADODataSet1: TADODataSet;
    ADODataSet1GL_ACC_NUMBER: TStringField;
    ADODataSet1GL_DESCRIPTION: TStringField;
    ADODataSet1CURR_CODE: TStringField;
    ADODataSet1CURR_NAME: TStringField;
    ADODataSet1BASE_TO_OTHER: TFloatField;
    ADODataSet1TYR_OPEN_ORIG: TBCDField;
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    DataSource1: TDataSource;
    Edit1: TEdit;
    Edit2: TEdit;
    Label1: TLabel;
    Button1: TButton;
    Button2: TButton;
    ADOQuery1: TADOQuery;
    Label2: TLabel;
    ADODataSet1dbcr: TStringField;
    ADODataSet1TYR_DEBIT_ORIG: TBCDField;
    ADODataSet1TYR_CREDIT_ORIG: TBCDField;
    ADODataSet1PARENT_PTR: TIntegerField;
    ADOCommand1: TADOCommand;
    Button3: TButton;
    Button4: TButton;
    procedure Button1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
   function find_ERROR103():STRING;
   function find_errorcurr103():string;
   function GetPRkey(prky:integer;var parent_ptr:integer):boolean;
   function updateGL(const tyr_open,tyr_d,try_c:currency;vgl:integer):boolean;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

uses common;

{$R *.dfm}
function TForm1.GetPRkey(prky:integer;var parent_ptr:integer):boolean;
begin
 adoquery1.Close;
 adoquery1.SQL.Text:='SELECT PARENT_PTR'+#13+
                   'FROM Data0103'+#13+
                   'WHERE RKEY ='+inttostr(prky);
 adoquery1.Open;
 if adoquery1.FieldValues['PARENT_PTR']>0 then
  begin
   parent_ptr:=adoquery1.FieldValues['PARENT_PTR'];
   result:=true;
  end
 else
  result:=false;
end;

function TForm1.updateGL(const tyr_open,tyr_d,try_c:currency;vgl:integer):boolean;
var
  parent_ptr:integer;
begin
 try
  self.ADOCommand1.Parameters.ParamValues['open_orig']:=tyr_open;
  self.ADOCommand1.Parameters.ParamValues['debit_orig']:=tyr_d;
  self.ADOCommand1.Parameters.ParamValues['credit_orig']:=try_c;
  self.ADOCommand1.Parameters.ParamValues['rkey']:=vgl;
  self.ADOCommand1.Execute;
  parent_ptr:=0;
  if self.GetPRkey(vgl,parent_ptr) then
   updateGL(tyr_open,tyr_d,try_c,parent_ptr); //���¸���Ŀ
  result:=true;
 except
  result:=false;
 end;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
 self.ADODataSet1.Close;
 if self.ADOQuery1.Active then
 self.ADOQuery1.Close;
 application.Terminate;
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
 self.ADOQuery1.Close;
 self.ADOQuery1.SQL.Text:='SELECT     CURR_FYEAR, CURR_PERIOD'+#13+
                          'FROM         Data0508';
 self.ADOQuery1.Open;
 edit1.Text:=self.ADOQuery1.fieldbyname('CURR_FYEAR').AsString;
 edit2.Text:=self.ADOQuery1.fieldbyname('CURR_PERIOD').AsString;
 self.ADODataSet1.Open;
end;

function TForm1.find_ERROR103: STRING;
begin
 self.ADOQuery1.Close;
 self.ADOQuery1.SQL.Text:='SELECT TOP 1 GL_ACC_NUMBER'+#13+
                          'FROM  Data0103'+#13+
                       'WHERE  (HAS_CHILD = 0) AND (CURR_TP = 1)';
 self.ADOQuery1.Open;
 result:=self.ADOQuery1.fieldbyname('GL_ACC_NUMBER').AsString;
end;

function TForm1.find_errorcurr103: string;
begin
 self.ADOQuery1.Close;
 self.ADOQuery1.SQL.Text:='SELECT GL_ACC_NUMBER'+#13+
                          'FROM Data0103'+#13+
                 'WHERE (HAS_CHILD = 0) AND (CURR_TP = 2)'+#13+
                 'AND (CURR_PTR NOT IN (SELECT RKEY'+#13+
                       'FROM Data0001))';
 self.ADOQuery1.Open;
 result:=self.ADOQuery1.fieldbyname('GL_ACC_NUMBER').AsString;
end;


procedure TForm1.Button2Click(Sender: TObject);
begin

 self.ADOConnection1.BeginTrans;
 try
 self.ADODataSet1.UpdateBatch();
 self.ADOConnection1.CommitTrans;
 self.ADODataSet1.Close;
 self.ADODataSet1.Open; 
 showmsg('���³ɹ�',1);
 except
  self.ADOConnection1.RollbackTrans;
  showmsg('����ʧ��!!!',1);
 end;

end;

procedure TForm1.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if (key=40) and        //������¼�ͷ��������һ����¼
  (ADODataSet1.RecNo=ADODataSet1.RecordCount) then abort;
 if key=45 then abort; //insert��
 if (key=46) and (ssCtrl in shift) then abort;//ɾ����¼

end;



procedure TForm1.FormCreate(Sender: TObject);
begin
  if not App_Init(self.ADOConnection1) then
  begin
    ShowMsg('��������ʧ�ܣ�����ϵϵͳ����Ա��','��ʾ',1);
    application.Terminate;
  end;
  self.Caption :=Application.Title;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
 gllnumber:string;
begin
 gllnumber:= self.find_ERROR103;
 if trim(gllnumber)<>'' then
  showmsg('������ϸ��Ŀ�ж���ɺ������п�Ŀ�����,���޸ĺ��ٸ���:'+gllnumber,1)
 else
  begin
   gllnumber:=self.find_errorcurr103;
   if trim(gllnumber)<>'' then
    showmsg('���ֺ��㵥һ�����ϸ��Ŀû�ж��嵥һ���,���޸ĺ��ٸ���:'+gllnumber,1)
   else
   try
     self.ADOConnection1.BeginTrans;
     self.ADODataSet1.UpdateBatch();   //�����ύ�޸Ĺ�������
     self.ADODataSet1.First;
     self.ADODataSet1.DisableControls;
     while not self.ADODataSet1.Eof do
     begin
      if self.ADODataSet1PARENT_PTR.Value>0 then
       self.updateGL(self.ADODataSet1TYR_OPEN_ORIG.Value,
                     self.ADODataSet1TYR_DEBIT_ORIG.Value,
                     self.ADODataSet1TYR_CREDIT_ORIG.Value,
                     self.ADODataSet1PARENT_PTR.Value);
      self.ADODataSet1.Next;
     end;
     self.ADODataSet1.First;
     self.ADODataSet1.EnableControls;

    if strtoint(edit2.Text)-1 > 0 then//������֮����ڼ���ڵ���2
     begin
       self.ADOQuery1.Close;
       self.ADOQuery1.SQL.Text:='update data0110'+#13+
        'set TYR_OPEN_ORIG=Data0103.TYR_OPEN_ORIG,'+#13+
         'TYR_PERIOD_'+inttostr(strtoint(edit2.Text)-1)+'_CLOSE_ORIG ='+#13+
         ' Data0103.TYR_OPEN_ORIG,'+#13+
         'TYR_DEBIT_ORIG=data0103.TYR_DEBIT_ORIG,'+#13+   //����跽�ϼ�
         'TYR_CREDIT_ORIG=data0103.TYR_CREDIT_ORIG,'+#13+  //��������ϼ�
         'TYR_CLOSE_ORIG=Data0103.TYR_OPEN_ORIG'+#13+         //��ĩ���
         'FROM  dbo.Data0110 INNER JOIN'+#13+
          'dbo.Data0103 ON dbo.Data0110.GL_ACCT_PTR = dbo.Data0103.RKEY'+#13+
         'where (dbo.Data0110.FYEAR = '+edit1.Text+')';
       self.ADOQuery1.ExecSQL;
     end
    else
     begin
       self.ADOQuery1.Close;
       self.ADOQuery1.SQL.Text:='update data0110'+#13+
         'set TYR_PERIOD_12_CLOSE_ORIG =Data0103.TYR_OPEN_ORIG'+#13+
         'FROM  dbo.Data0110 INNER JOIN'+#13+
          'dbo.Data0103 ON dbo.Data0110.GL_ACCT_PTR = dbo.Data0103.RKEY'+#13+
          'where (dbo.Data0110.FYEAR = '+inttostr(strtoint(edit1.Text)-1)+')';
       self.ADOQuery1.ExecSQL;

       self.ADOQuery1.Close;
       self.ADOQuery1.SQL.Text:='update data0110'+#13+
        'set TYR_OPEN_ORIG=Data0103.TYR_OPEN_ORIG,'+#13+
         'TYR_DEBIT_ORIG = 0,'+#13+
         'TYR_CREDIT_ORIG = 0,'+#13+
         'TYR_CLOSE_ORIG = 0'+#13+
         'FROM   dbo.Data0110 INNER JOIN'+#13+
          'dbo.Data0103 ON dbo.Data0110.GL_ACCT_PTR = dbo.Data0103.RKEY'+#13+
          'where (dbo.Data0110.FYEAR = '+edit1.Text+')';
       self.ADOQuery1.ExecSQL;
     end;
     self.ADOConnection1.CommitTrans;
     showmsg('���³ɹ�',1);
   except
     self.ADOConnection1.RollbackTrans;
     showmsg('����ʧ��!!!',1);
   end;
  end;

end;

procedure TForm1.Button4Click(Sender: TObject);
begin
Export_dbGrid_to_Excel(dbgrid1,self.Caption);
end;

end.
