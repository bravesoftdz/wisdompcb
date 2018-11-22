unit uXSMB;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Spin, ExtCtrls, ComCtrls, Buttons;

type
  TfrmXSMB = class(TForm)
    YJH: TSpinEdit;
    MJH: TSpinEdit;
    YJHJE: TEdit;
    LJJE: TEdit;
    MJHJE: TEdit;
    YZNBL: TEdit;
    YWWJE: TEdit;
    WWZNBL: TEdit;
    RadioGroup1: TRadioGroup;
    Edit15: TEdit;
    DateTimePicker1: TDateTimePicker;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Panel1: TPanel;
    SQJHJE: TEdit;
    SQWCJE: TEdit;
    SQXCJE: TEdit;
    SQWCBL: TEdit;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Panel2: TPanel;
    BQMBJE: TEdit;
    BQJHJE: TEdit;
    BQXCJE: TEdit;
    BQJHBL: TEdit;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Panel3: TPanel;
    Label19: TLabel;
    Label20: TLabel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    BitBtn1: TBitBtn;
    Memo1: TMemo;
    JHID: TEdit;
    Label21: TLabel;
    Edit1: TEdit;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Label30: TLabel;
    Label31: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure MJHJEExit(Sender: TObject);
    procedure YWWJEExit(Sender: TObject);
    procedure SQJHJEExit(Sender: TObject);
    procedure BQJHJEExit(Sender: TObject);
    procedure YJHJEKeyPress(Sender: TObject; var Key: Char);
    procedure LJJEExit(Sender: TObject);
  private
    _EMPPTR:integer;//������ָ��
    _BMPTR:integer;//�����˲���ָ��
    _ZY:integer;//������ְλָ��
    function New704():boolean;
    function Edit704():boolean;
    procedure Get704();
    procedure GetID();
    procedure CreateID(pID:string);
    function NumberError(pID:string):boolean;
    function checkchar(const pstr:string;const pkey:char):boolean;
  public
    _isedit:boolean;
  end;

var
  frmXSMB: TfrmXSMB;

implementation

uses uEMPInfo, uDM, dateutils,Math;

{$R *.dfm}
function TfrmXSMB.checkchar(const pstr:string;const pkey:char):boolean;
var
 i,iLast:integer;
begin
     result:=true;
 if not (pkey in ['0'..'9','.',#8]) then  //�ж��Ƿ���������
  result:=false
 else
   if pkey='.' then
     begin
      iLast:=0;
      for i:=0 to Length(pstr) do
       if pstr[i]='.' then
        begin
         iLast:=iLast+1;
         if iLast=1 then
          begin
           result:=false;
           break;
          end;
       end;
     end
    else
     result:=true;
end;
//����Ƿ��ظ�
function TfrmXSMB.NumberError(pID:string):boolean;
begin
with dm.AQery do
 begin
  close;
  sql.Clear;
  sql.Add('select rkey from data0704');
  sql.Add('where JHID='''+pID+'''');
  open;
  if not IsEmpty then
   result:=true
  else
   result:=false;
 end;
end;
//��ȡID��
procedure TfrmXSMB.GetID();

begin
 dm.AQery4.Close;
 dm.AQery4.Open;
 if dm.AQery4.FieldValues['SEED_FLAG']<>1 then
  begin
   JHID.Text:=dm.AQery4.FieldValues['SEED_VALUE'];
   JHID.Enabled:=false;
  end
 else
  begin
   JHID.Enabled:=true;
  end;
end;
//����ID��
procedure TfrmXSMB.CreateID(pID:string);
var
  vID:string;
  vLen,i:integer;
  vLast:string;
begin
 dm.AQery4.Close;
 dm.AQery4.Open;
 if dm.AQery4.FieldValues['SEED_FLAG']=1 then exit; //�ֶ�

 vLen := length(pID);
 for i := vLen downto 1 do
  if not (pID[i] in ['0'..'9']) then   //�����������
   begin
    vLast:= floattostr(power(10,vLen-1)+strtofloat(copy(pID,i+1,vLen-i))+1); //��׺��1
    vID := copy(pID,1,i)+copy(vLast,i+1,vLen-i);
    dm.AQery4.Edit; //ʹǰ׺�����׺��1
    dm.AQery4.FieldValues['SEED_VALUE']:= vID;
    dm.AQery4.Post;
    break;
   end
  else
   if i=1 then //�����һλ��Ȼ������
    begin
     vLast := floattostr(power(10,vLen)+strtofloat(pID)+1);
     vID := copy(vLast,2,vLen);
     dm.AQery4.Edit;
     dm.AQery4.FieldValues['SEED_VALUE']:= vID;
     dm.AQery4.Post;
    end;

end;
//����
function TfrmXSMB.New704():boolean;
var
 vrkey:integer;
begin
  dm.AQery.Close ;
  dm.AQery.SQL.Text:='SELECT * FROM data0704 WHERE (RKEY IS NULL)';
  dm.AQery.Open ;
  try
    dm.AQery.Append ;
    dm.AQery.FieldValues['JHID']:=JHID.Text;           //ID��
    dm.AQery.FieldValues['YJH']:=YJH.Value;            //�ƻ����
    dm.AQery.FieldValues['MJH']:=MJH.Value;            //�ƻ��·�
    dm.AQery.FieldValues['MJHJE']:=strtofloat(MJHJE.Text);    //�¼ƻ����
    dm.AQery.FieldValues['YZNBL']:=strtofloat(YZNBL.Text);    //��ռ��ٷֱ�
    dm.AQery.FieldValues['YJHJE']:=strtofloat(YJHJE.Text);    //��ƻ����
    dm.AQery.FieldValues['YWWJE']:=strtofloat(YWWJE.Text);    //ȫ��δ��ɽ��
    dm.AQery.FieldValues['WWZNBL']:=strtofloat(WWZNBL.Text);  //δ��ռ�����
    dm.AQery.FieldValues['LJJE']:=strtofloat(LJJE.Text);      //�ۼƽ��
    dm.AQery.FieldValues['SQJHJE']:=strtofloat(SQJHJE.Text);  //���ڼƻ����
    dm.AQery.FieldValues['SQWCJE']:=strtofloat(SQWCJE.Text);  //������ɽ��
    dm.AQery.FieldValues['SQXCJE']:=strtofloat(SQXCJE.Text);  //���������
    dm.AQery.FieldValues['SQWCBL']:=strtofloat(SQWCBL.Text);  //���ռ�ƻ��ٷֱ�

    dm.AQery.FieldValues['BQJHJE']:=strtofloat(BQJHJE.Text);  //���ڼƻ����
    dm.AQery.FieldValues['BQXCJE']:=strtofloat(BQXCJE.Text);  //���������
    dm.AQery.FieldValues['BQJHBL']:=strtofloat(BQJHBL.Text);  //�ƻ���Ŀ��ٷֱ�
    dm.AQery.FieldValues['status']:=RadioGroup1.ItemIndex;    //���Ҽ���״̬(0����,1һ��,2��)
    dm.AQery.FieldValues['CJRPTR']:=_EMPPTR;                  //������
    dm.AQery.FieldValues['CJRQ']:=DateTimePicker1.Date;      //��������
    dm.AQery.FieldValues['ZYStatus']:=_ZY ; //������ְλ
    dm.AQery.FieldValues['ZYRBM']:=SELF._BMPTR; //��������������
    dm.AQery.FieldValues['Note']:=memo1.Text;                 //��ע
    dm.AQery.Post;
    messagedlg('����ɹ�������',mtinformation,[mbok],0);
    vrkey:=dm.AQery.FieldValues['rkey'];
    dm.AQery704.Close;
    dm.AQery704.Open ;
    dm.AQery704.Locate('rkey',vrkey,[]);
    result:=true;
  except
   on E: Exception do
     begin
      messagedlg(E.Message,mtinformation,[mbok],0);
      result:=false;
     end;
  end;
end;
//
function TfrmXSMB.Edit704():boolean;
var
 vrkey:integer;
begin
  dm.AQery.Close ;
  dm.AQery.SQL.Text:='SELECT * FROM data0704 WHERE (RKEY ='+dm.AQery704.FieldByName('rkey').AsString+')';
  dm.AQery.Open ;
  try
    dm.AQery.Edit;
    dm.AQery.FieldValues['JHID']:=JHID.Text;             //ID��
    dm.AQery.FieldValues['YJH']:=YJH.Value;              //�ƻ����
    dm.AQery.FieldValues['MJH']:=MJH.Value;              //�ƻ��·�
    dm.AQery.FieldValues['MJHJE']:=strtofloat(MJHJE.Text);    //�¼ƻ����
    dm.AQery.FieldValues['YZNBL']:=strtofloat(YZNBL.Text);    //��ռ��ٷֱ�
    dm.AQery.FieldValues['YJHJE']:=strtofloat(YJHJE.Text);    //��ƻ����
    dm.AQery.FieldValues['YWWJE']:=strtofloat(YWWJE.Text);    //ȫ��δ��ɽ��
    dm.AQery.FieldValues['WWZNBL']:=strtofloat(WWZNBL.Text);  //δ��ռ�����
    dm.AQery.FieldValues['LJJE']:=strtofloat(LJJE.Text);      //�ۼƽ��
    dm.AQery.FieldValues['SQJHJE']:=strtofloat(SQJHJE.Text);  //���ڼƻ����
    dm.AQery.FieldValues['SQWCJE']:=strtofloat(SQWCJE.Text);  //������ɽ��
    dm.AQery.FieldValues['SQXCJE']:=strtofloat(SQXCJE.Text);  //���������
    dm.AQery.FieldValues['SQWCBL']:=strtofloat(SQWCBL.Text);  //���ռ�ƻ��ٷֱ�
    //dm.AQery.FieldValues['BQMBJE']:=strtofloat(BQMBJE.Text);  //����Ŀ����
    dm.AQery.FieldValues['BQJHJE']:=strtofloat(BQJHJE.Text);  //���ڼƻ����
    dm.AQery.FieldValues['BQXCJE']:=strtofloat(BQXCJE.Text);  //���������
    dm.AQery.FieldValues['BQJHBL']:=strtofloat(BQJHBL.Text);  //�ƻ���Ŀ��ٷֱ�
    dm.AQery.FieldValues['status']:=RadioGroup1.ItemIndex;    //���Ҽ���״̬(0����,1һ��,2��)
    dm.AQery.FieldValues['CJRPTR']:=_EMPPTR;                  //������
    dm.AQery.FieldValues['CJRQ']:=DateTimePicker1.Date ;      //��������
    dm.AQery.FieldValues['ZYStatus']:=dm.AQery5.FieldValues['popedom']; //�ƻ���ְλ
    dm.AQery.FieldValues['ZYRBM']:=dm.AQery5.FieldValues['EMPLOYEE_ID']; //�ƻ����������� 
    dm.AQery.FieldValues['Note']:=memo1.Text;                 //��ע
    dm.AQery.Post;
    messagedlg('����ɹ�������',mtinformation,[mbok],0);
    vrkey:=dm.AQery704.FieldValues['rkey'];
    dm.AQery704.Close;
    dm.AQery704.Open ;
    dm.AQery704.Locate('rkey',vrkey,[]);
    result:=true;
  except
   on E: Exception do
     begin
      messagedlg(E.Message,mtinformation,[mbok],0);
      result:=false;
     end;
  end;
end;
procedure TfrmXSMB.Get704();
var
 i,j:integer;
begin
 for i:=0 to ControlCount-1 do
  begin
   if Controls[i].ClassName ='TEdit' then
    for j:=0 to dm.AQery704.FieldCount-1 do
     if Controls[i].Name =dm.AQery704.Fields[j].FieldName then
      (Controls[i] as TEdit).Text:=dm.AQery704.Fields[j].Value;
   if Controls[i].ClassName ='TSpinEdit' then
    for j:=0 to dm.AQery704.FieldCount-1 do
     if Controls[i].Name =dm.AQery704.Fields[j].FieldName then
      (Controls[i] as TSpinEdit).Value:=dm.AQery704.Fields[j].Value;

  end;
 for i:=0 to Panel1.ControlCount-1 do
  if Panel1.Controls[i].ClassName ='TEdit' then
   for j:=0 to dm.AQery704.FieldCount-1 do
    if Panel1.Controls[i].Name =dm.AQery704.Fields[j].FieldName then
      (Panel1.Controls[i] as TEdit).Text:=dm.AQery704.Fields[j].Value;
 for i:=0 to Panel2.ControlCount-1 do
  if Panel2.Controls[i].ClassName ='TEdit' then
   for j:=0 to dm.AQery704.FieldCount-1 do
    if Panel2.Controls[i].Name =dm.AQery704.Fields[j].FieldName then
      (Panel2.Controls[i] as TEdit).Text:=dm.AQery704.Fields[j].Value;
 BQMBJE.Text:=MJHJE.Text;

 //������
 dm.AQery5.Close ;
 dm.AQery5.Parameters.ParamValues['rky']:=dm.AQery704.FieldByName('CJRPTR').Value;
 dm.AQery5.Open ;
 edit15.Text :=dm.AQery5.FieldValues['EMPLOYEE_NAME'];
 _EMPPTR:=dm.AQery5.FieldValues['rkey'];
 edit1.Text:=dm.AQery5.FieldValues['ZY'];//ְλ
 _BMPTR:=dm.AQery5.FieldValues['EMPLOYEE_ID'] ;  //����ָ��
 _ZY:=dm.AQery5.FieldValues['popedom'];     //ְλ״ֵ̬
 //����ʱ��
 DateTimePicker1.Date:=dm.AQery704.FieldValues['CJRQ'];
 //���Ҽ���
 RadioGroup1.ItemIndex:=dm.AQery704.FieldValues['status'];
 //��ע
 memo1.Text:=dm.AQery704.FieldValues['Note'];
end;
procedure TfrmXSMB.FormCreate(Sender: TObject);
begin
 YJH.Value:=yearof(now);
 MJH.Value:=Monthof(now);
 DateTimePicker1.Date:=now; 
end;

procedure TfrmXSMB.FormShow(Sender: TObject);
begin
 if not _isedit then
  begin
   _EMPPTR:=dm.AQery5.FieldValues['rkey'];
   edit15.Text:=dm.AQery5.FieldValues['EMPLOYEE_NAME'];//������
   edit1.Text:=dm.AQery5.FieldValues['ZY'];            //ְλ
   _BMPTR:=dm.AQery5.FieldValues['EMPLOYEE_ID'] ;      //����ָ��
   _ZY:=dm.AQery5.FieldValues['popedom'];              //ְλ״ֵ̬
  end;

 if _isedit then
  Get704()
 else
  GetID(); 
end;
//����
procedure TfrmXSMB.SpeedButton1Click(Sender: TObject);
var
 i,j:integer;
begin
 if _isedit=false then
  if NumberError(trim(JHID.Text)) then
   begin
      dm.AQery4.Close;
      dm.AQery4.Open;
      if dm.AQery4.FieldValues['SEED_FLAG']<>1 then
       begin
        if messagedlg('����ظ����ܶ���ͬʱ����,�Ƿ��Զ����±��Ϊ:'+
         dm.AQery4.FieldValues['SEED_VALUE'],mtconfirmation,[mbyes,mbno],0)=mryes then
          JHID.Text:=dm.AQery4.FieldValues['SEED_VALUE']
        else
         exit;
       end
      else
       begin
        messagedlg('����ظ�!���ֹ���������',mterror,[mbok],0);
        JHID.SetFocus;
        exit;
       end;
   end;  //END  _isedit=false

 try
  for i:=0 to ControlCount-1 do
   begin
    if Controls[i].ClassName  ='TEdit' then
     if (Controls[i].Name <>'Edit1') and (Controls[i].Name <>'Edit15') and (Controls[i].Name<>'JHID') then
      strtofloat(TEdit(Controls[i]).Text);
    if Controls[i].ClassName='TPanel' then
     for j:=0 to (Controls[i] as TPanel).ControlCount-1 do
      begin
       if (Controls[i] as TPanel).Controls[j].ClassName ='TEdit' then
        strtofloat(TEdit((Controls[i] as TPanel).Controls[j]).Text);
      end
   end;

  if _EMPPTR=0 then
   begin
    messagedlg('�����˲���Ϊ�գ�����',mtinformation,[mbok],0);
    exit;
   end;

  if not _isedit then
   begin
    if New704() =false then exit;
    CreateID(trim(JHID.Text));
   end
  else
   begin
    if Edit704()=false then exit;
   end;
  //������

  close;
 except
   on E: Exception do
     begin
      messagedlg(E.Message,mtinformation,[mbok],0);
     end;
 end;
end;

procedure TfrmXSMB.BitBtn1Click(Sender: TObject);
begin
{
 Application.CreateForm(TfrmEMPINFO, frmEMPINFO);
  frmEMPINFO.AQery5.Open ;
  if trim(edit15.Text)<>'' then
   frmEMPINFO.Edit1.Text:=trim(edit15.Text);
  if frmEMPINFO.ShowModal=mrOk then
  begin
   edit1.Text:=frmEMPINFO.AQery5.FieldValues['ZY'];//ְλ
   edit15.Text:=frmEMPINFO.AQery5EMPLOYEE_NAME.Value;
   _EMPPTR:=frmEMPINFO.AQery5RKEY.Value;
   _BMPTR:=frmEMPINFO.AQery5.FieldValues['EMPLOYEE_ID'] ;  //����ָ��
   _ZY:=frmEMPINFO.AQery5.FieldValues['popedom'];     //ְλ״̬
  end;
  frmEMPINFO.Free();
 }
end;
procedure TfrmXSMB.SpeedButton2Click(Sender: TObject);
begin
 close;
end;
//�������
procedure TfrmXSMB.MJHJEExit(Sender: TObject);
begin
 BQMBJE.Text:=MJHJE.Text ;
 try
  strtofloat(YJHJE.Text);
  strtofloat(MJHJE.Text);
  YZNBL.Text:= formatfloat('0.00',strtofloat(MJHJE.Text)/strtofloat(YJHJE.Text)*100);
 except
   on E: Exception do
     begin
      messagedlg(E.Message,mtinformation,[mbok],0);
     end;
 end;
end;
//����ȫ��δ��ɱ���
procedure TfrmXSMB.YWWJEExit(Sender: TObject);
begin
 try
  strtofloat(YJHJE.Text);
  strtofloat(YWWJE.Text);
  WWZNBL.Text:= formatfloat('0.00',strtofloat(YWWJE.Text)/strtofloat(YJHJE.Text)*100);
 except
   on E: Exception do
     begin
      messagedlg(E.Message,mtinformation,[mbok],0);
     end;
 end;

end;
//��������Ŀ�� ��Ԥ��
procedure TfrmXSMB.SQJHJEExit(Sender: TObject);
begin
 try
  strtofloat(SQJHJE.Text);
  strtofloat(SQWCJE.Text);
  SQXCJE.Text:= floattostr(strtofloat(SQWCJE.Text)-strtofloat(SQJHJE.Text));
  if pos('-',SQXCJE.Text)>0  then
   SQWCBL.Text:= formatfloat('0.00',-strtofloat(SQXCJE.Text)/strtofloat(SQJHJE.Text)*100)
  else
   SQWCBL.Text:= formatfloat('0.00',strtofloat(SQXCJE.Text)/strtofloat(SQJHJE.Text)*100); 
 except
   on E: Exception do
     begin
      messagedlg(E.Message,mtinformation,[mbok],0);
     end;
 end;

end;
//���㱾��Ŀ���Ԥ��
procedure TfrmXSMB.BQJHJEExit(Sender: TObject);

begin
 try
  strtofloat(BQMBJE.Text);
  strtofloat(BQJHJE.Text);
  BQXCJE.Text:= floattostr(strtofloat(BQJHJE.Text)-strtofloat(BQMBJE.Text));
  if pos('-',BQXCJE.Text)>0  then
   BQJHBL.Text:= formatfloat('0.00',-strtofloat(BQXCJE.Text)/strtofloat(BQMBJE.Text)*100)
  else
   BQJHBL.Text:= formatfloat('0.00',strtofloat(BQXCJE.Text)/strtofloat(BQMBJE.Text)*100);
 except
   on E: Exception do
     begin
      messagedlg(E.Message,mtinformation,[mbok],0);
     end;
 end;
end;

procedure TfrmXSMB.YJHJEKeyPress(Sender: TObject; var Key: Char);
begin
if key=#13 then exit;
if checkchar(TEdit(Sender).Text, key)=false then
    begin
      showmessage('���������֣�����');
      abort;
    end;
end;
//����ȫ��δ�����
procedure TfrmXSMB.LJJEExit(Sender: TObject);
begin
 BQMBJE.Text:=MJHJE.Text ;
 try
  strtofloat(YJHJE.Text);
  strtofloat(LJJE.Text);
  YWWJE.Text:= floattostr(strtofloat(YJHJE.Text)-strtofloat(LJJE.Text)); //ȫ��δ���
  WWZNBL.Text:= formatfloat('0.00',strtofloat(YWWJE.Text)/strtofloat(YJHJE.Text)*100);//ռ����
 except
   on E: Exception do
     begin
      messagedlg(E.Message,mtinformation,[mbok],0);
     end;
 end;
end;

end.
