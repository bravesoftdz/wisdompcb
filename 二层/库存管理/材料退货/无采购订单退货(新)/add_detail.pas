unit add_detail;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons;

type
  Tfm_add = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    BitBtn1: TBitBtn;
    BitBtn3: TBitBtn;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    BitBtn4: TBitBtn;
    Label5: TLabel;
    Edit4: TEdit;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure Edit2KeyPress(Sender: TObject; var Key: Char);
    procedure Edit2Exit(Sender: TObject);
    procedure Edit3Exit(Sender: TObject);
  private
    { Private declarations }
    rkey76:integer;
  public
    { Public declarations }
    function check_stock():boolean;  //����Ƿ����̵������
  end;

var
  fm_add: Tfm_add;

implementation

uses damo,common,constvar,pick_item_single;

{$R *.dfm}

function Tfm_add.check_stock():boolean;
begin
 result:=false;
 with dm.aqtmp do
 begin
  close;
  sql.Text:='SELECT D92.PHY_COUNT_NO,D92.TDATE,D05.EMPLOYEE_NAME '+
    'FROM Data0005 D05 INNER JOIN Data0092 D92 ON D05.RKEY=D92.EMPLOYEE_PTR '+
    'WHERE (D92.STATUS=''0'')';
  open;
  if not isempty then
  begin
   messagedlg('���ܽ����˻��������ֿ����ڽ��в����̵㣬�̵����:'+
     fieldvalues['PHY_COUNT_NO'],mtinformation,[mbcancel],0);
   result:=true;
  end;
 end;
end;

procedure Tfm_add.BitBtn1Click(Sender: TObject);
begin
 if check_stock then exit;  //�̵�״̬������������
 if strtofloat(edit2.Text)=0 then
 begin
  messagedlg('�˻�����������Ϊ�㣡',mtinformation,[mbok],0);
  edit2.SetFocus;
  exit;
 end;
 if trim(edit3.Text)='' then
 begin
  messagedlg('���մ��벻����Ϊ�գ�',mtinformation,[mbok],0);
  edit3.SetFocus;
  exit;
 end;
 with dm.aqtmp do
 begin
  close;
  sql.Text:='select * from data0017 where rkey='+dm.AQ22inventory_ptr.AsString;
  open;
  if fieldvalues['quan_on_hand']<strtofloat(Edit2.text) then
  begin
   showmessage('�����˻�ʧ�ܣ������ܿ�����Ѳ��������˻���');
   exit;
  end;
 end;
//==============================================================================
 dm.ADOConnection1.BeginTrans;
 try
  with dm.aqtmp do
  begin
   close;   //���������˻���¼��96
   sql.Text:='select * from data0096 where rkey is null';
   open;
   append;
   fieldvalues['rej_ptr']:= rkey76;
   fieldvalues['invt_ptr'] := dm.AQ22inventory_ptr.Value;
   fieldvalues['inv_tran_ptr'] := dm.AQ22rkey.Value;
   fieldbyname('empl_ptr').AsString := user_ptr;
   fieldvalues['tdate']:=getsystem_date(dm.aqtmp1,0);
   fieldbyname('quan_rejd').AsString := trim(edit2.Text);
   fieldvalues['flag'] := '2';//�������˻�����Ӧ��
   fieldvalues['reference_number']:=trim(edit4.Text);
   post;
  end;

  dm.AQ22.Edit;  //���������ϸ
  dm.AQ22quan_to_be_shipped.Value:=dm.AQ22quan_to_be_shipped.Value+strtofloat(Edit2.text);
  dm.AQ22quan_on_hand.Value := dm.AQ22quan_on_hand.Value-strtocurr(Edit2.text);
  dm.AQ22.Post;
  
  with dm.aqtmp do //���²�������
  begin
   close;
   sql.Text:='update data0017 set quan_on_hand=quan_on_hand-'+Edit2.text+' where rkey='+dm.AQ22inventory_ptr.AsString;
   execsql;
  end;
  
 except
  on e:exception do
  begin
   dm.ADOConnection1.RollbackTrans;
   showmessage('����'+e.Message);
  // showmessage('���²��ɹ������ܶ��û�ͬʱ�����������ѷ����仯��');
   exit;
  end;
 end;
 self.ModalResult:=mrok;
 dm.ADOConnection1.CommitTrans;
 dm.AQ96.Close;
 dm.AQ96.Open;
 dm.AQ96.Last;
end;

procedure Tfm_add.BitBtn3Click(Sender: TObject);
begin
 close;
end;

procedure Tfm_add.BitBtn4Click(Sender: TObject);
var inputvar: PDlgInput; //����
begin
 frmpick_item_single:=Tfrmpick_item_single.Create(application);
 try
  inputvar.Fields:='code/���մ���/130,reject_description/����ԭ��/240';
  inputvar.Sqlstr:='select rkey,code,reject_description from data0076 order by code';
  inputvar.KeyField:='code';
  inputvar.InPut_value:=edit3.Text;
  inputvar.AdoConn:=dm.ADOConnection1;
  frmpick_item_single.InitForm_New(inputvar);
  if (frmpick_item_single.ShowModal=mrok) and (not frmpick_item_single.adsPick.IsEmpty) then
  begin
   edit3.Text:=trim(frmpick_item_single.adsPick.FieldValues['code']);
   label4.Caption:=trim(frmpick_item_single.adsPick.FieldValues['reject_description']);
   rkey76:=frmpick_item_single.adsPick.FieldValues['rkey'];
  end;
 finally
  frmpick_item_single.adsPick.Close;
  frmpick_item_single.Free;
 end;
end;

procedure Tfm_add.Edit2KeyPress(Sender: TObject; var Key: Char);
begin
 if (key = chr(46)) then
 if pos('.',edit2.Text)>0 then abort;     //С���㲻���ظ�
 if not (key in ['0'..'9','.',#8]) then abort;//�ж��Ƿ���������
end;

procedure Tfm_add.Edit2Exit(Sender: TObject);
begin
 if trim(edit2.Text) = '' then  edit2.Text := '0';
 if strtofloat(edit2.Text) > strtofloat(edit1.Text) then
 begin
  messagedlg('�˻��������ܴ��ڵ�ǰ��������!',mterror,[mbcancel],0);
  edit2.SetFocus;
 end
 else edit2.Text := formatfloat('0.000',strtofloat(edit2.Text));
end;

procedure Tfm_add.Edit3Exit(Sender: TObject);
begin
 if (trim(edit3.Text)<>'') then
  with dm.aqtmp do
  begin
   Close;
   SQL.Text:='select rkey,code,reject_description from data0076 '+
     'where code='+quotedstr(edit3.Text);
   Open;
   if not IsEmpty then
   begin
    label4.Caption:=FieldValues['reject_description'];
    rkey76:=FieldValues['rkey'];
   end
   else begin
    showmessage('������ľ��մ��벻���ڣ����������룡');
    label4.Caption:='';
    edit3.SetFocus;
   end;
  end
 else label4.Caption:='';
end;

end.
