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
  private
    function OpenData105():boolean; //����������ȡƾ֤
    function GetProfitTrans():boolean;
    function GetcostTrans():boolean;
    { Private declarations }
  public
    { Public declarations }

  end;

var
  FrmMain: TFrmMain;

implementation

uses udm, common;

{$R *.dfm}
procedure TFrmMain.FormCreate(Sender: TObject);
begin
  if not App_Init(dm.ADOCnn) then
  begin
    ShowMsg('��������ʧ�ܣ�����ϵϵͳ����Ա��','��ʾ',1);
    application.Terminate;
    exit;
  end;
  self.Caption :=Application.Title;


  //user_ptr:='785';
 // dm.ADOCnn.Open;

  DateSeparator := '-';
  ShortDateFormat := 'yyyy-mm-dd';
  DM.tmp.close ;
  DM.tmp.SQL.Text:='select curr_FYEAR,curr_period from data0508';
  DM.tmp.Open ;
  edit1.text:=dm.tmp.fieldbyname('curr_FYEAR').asstring;
  edit2.text:=dm.tmp.fieldbyname('curr_period').asstring;
end;

function TFrmMain.GetProfitTrans():boolean;
begin
  dm.tmp.Close ;       //�Ƿ��н�ת�����ƾ֤
  dm.tmp.SQL.Text:='select rkey from data0105 '
                  +' where (PERIOD ='+edit2.Text+')'
                  +' AND (FYEAR ='+edit1.Text+')'
                  +' AND (STATUS = 3)'
                  +' and (SPECIAL_POSTING=''Y'''+')';
  dm.tmp.Open ;
  result:=not dm.tmp.IsEmpty ;
end;

function TFrmMain.GetcostTrans():boolean;
begin
  dm.tmp.Close ;
  dm.tmp.SQL.Text:='select rkey from data0105 '   //�Ƿ��н�ת�ɱ���ƾ֤
        +' where (PERIOD ='+edit2.Text+')'
        +' AND (FYEAR ='+edit1.Text+')'
        +' AND (STATUS = 3)'
        +' and (SPECIAL_POSTING=''A'''+')';
  dm.tmp.Open ;
  result:=not dm.tmp.IsEmpty ;
end;

function TFrmMain.OpenData105():boolean;   //����������ȡƾ֤
begin
  DM.tmp.close;
  DM.tmp.sql.Text:='select rkey from data0105'+#13+
            ' where data0105.fyear='+edit1.Text+#13+
            ' and data0105.period='+edit2.Text+#13+
            ' and data0105.status=3';
  DM.tmp.open;
  result:=not DM.tmp.isempty;
end;


procedure TFrmMain.BitBtn1Click(Sender: TObject);  //������
begin
  if GetProfitTrans() then
  begin
    messagedlg('��ǰ�ڼ��н�ת�������Чƾ֤,���ȷ�������',mterror,[mbcancel],0);
    exit;
  end;

  if GetcostTrans() then
  begin
    messagedlg('��ǰ�ڼ��н�ת�ɱ����õ���Чƾ֤,���ȷ���ɱ�����',mterror,[mbcancel],0);
    exit;
  end;

  if not OpenData105() then//����������ȡƾ֤
  begin
    messagedlg('û���ҵ����Է����˵�ƾ֤!',mterror,[mbcancel],0);
    exit ;
  end;

 try
   Dm.tmp.Close;
   Dm.tmp.SQL.Text:='exec DenAcct; 2 '+edit1.Text+','+edit2.Text;
   Dm.tmp.Open;
   if Dm.tmp.Fields[0].AsInteger>0 then
   begin
     BitBtn1.Enabled:=false;
     showmessage('�����ʳɹ�!');
   end else
     showmessage('������ʧ��,�������Ա��ϵ!');
 except
  on E: Exception do
   begin
    showmessage(e.Message);
   end;
 end;
end;


procedure TFrmMain.BitBtn2Click(Sender: TObject);
begin
 close;
end;

end.

