unit uSKJH;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, ExtCtrls, StdCtrls, ComCtrls;

type
  TfrmSKJH = class(TForm)
    Panel3: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    Edit1: TEdit;
    BitBtn1: TBitBtn;
    HJYS: TEdit;
    DQYS: TEdit;
    YSJE: TEdit;
    SKRQ: TDateTimePicker;
    HZSTATUS: TRadioGroup;
    CQTS: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    CQJE: TEdit;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label13: TLabel;
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure Edit1Exit(Sender: TObject);
    procedure HJYSKeyPress(Sender: TObject; var Key: Char);
  private
    _CostPTR:integer;
    function New713():boolean;
    function Edit713():boolean;
    procedure Get713();
  public
    _isedit:boolean;
  end;

var
  frmSKJH: TfrmSKJH;

implementation

uses uCostomer, uDM;

{$R *.dfm}
function checkchar(const pstr:string;const pkey:char):boolean;
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

//����
function TfrmSKJH.New713():boolean;
var
 vrkey:integer;
begin
  dm.AQery.Close ;
  dm.AQery.SQL.Text:='SELECT * FROM data0713 WHERE (RKEY IS NULL)';
  dm.AQery.Open ;
  try

    dm.AQery.Append ;
    dm.AQery.FieldValues['PTR']:=dm.AQery712.FieldValues['rkey'];//712��ָ��
    dm.AQery.FieldValues['PTR10']:=_CostPTR;                  //�ͻ�10ָ��
    dm.AQery.FieldValues['HJYS']:=strtofloat(HJYS.Text);      //��Ƿ����
    dm.AQery.FieldValues['DQYS']:=strtofloat(DQYS.Text);      //���ڻ���
    dm.AQery.FieldValues['YSJE']:=strtofloat(YSJE.Text);      //Ӧ�ս��
    dm.AQery.FieldValues['SKRQ']:=SKRQ.Date ;                 //�տ�����
    dm.AQery.FieldValues['CQTS']:=strtofloat(CQTS.Text);      //��������
    dm.AQery.FieldValues['CQJE']:=strtofloat(CQJE.Text);      //��������
    dm.AQery.FieldValues['HZSTATUS']:=HZSTATUS.ItemIndex;         //�����Բ�(0��������,1��������,2ֹͣ����)
    dm.AQery.Post;
    messagedlg('����ɹ�������',mtinformation,[mbok],0);
    vrkey:=dm.AQery.FieldValues['rkey'];
    dm.ADS713.Close;
    dm.ADS713.Open ;
    dm.ADS713.Locate('rkey',vrkey,[]);
    result:=true;
  except
   on E: Exception do
     begin
      messagedlg(E.Message,mtinformation,[mbok],0);
      result:=false;
     end;
  end;
end;
//�༭
function TfrmSKJH.Edit713():boolean;
var
 vrkey:integer;
begin
  dm.AQery.Close ;
  dm.AQery.SQL.Text:='SELECT * FROM data0713 WHERE (RKEY ='+dm.ADS713.FieldByName('rkey').AsString+')';
  dm.AQery.Open ;
  try
    dm.AQery.Edit;
    dm.AQery.FieldValues['PTR10']:=_CostPTR;                  //�ͻ�10ָ��
    dm.AQery.FieldValues['HJYS']:=strtofloat(HJYS.Text);      //��Ƿ����
    dm.AQery.FieldValues['DQYS']:=strtofloat(DQYS.Text);      //���ڻ���
    dm.AQery.FieldValues['YSJE']:=strtofloat(YSJE.Text);      //Ӧ�ս��
    dm.AQery.FieldValues['SKRQ']:=SKRQ.Date ;                 //�տ�����
    dm.AQery.FieldValues['CQTS']:=strtofloat(CQTS.Text);      //��������
    dm.AQery.FieldValues['CQJE']:=strtofloat(CQJE.Text);      //��������
    dm.AQery.FieldValues['HZSTATUS']:=HZSTATUS.ItemIndex;         //�����Բ�(0��������,1��������,2ֹͣ����)
    dm.AQery.Post;
    messagedlg('����ɹ�������',mtinformation,[mbok],0);
    vrkey:=dm.ADS713.FieldValues['rkey'];
    dm.ADS713.Close;
    dm.ADS713.Open ;
    dm.ADS713.Locate('rkey',vrkey,[]);
    result:=true;
  except
   on E: Exception do
     begin
      messagedlg(E.Message,mtinformation,[mbok],0);
      result:=false;
     end;
  end;

end;
procedure TfrmSKJH.Get713();
var
 i,j:integer;
begin
 for i:=0 to ControlCount-1 do
  begin
   if Controls[i].ClassName ='TEdit' then
    for j:=0 to dm.ADS713.FieldCount-1 do
     if Controls[i].Name =dm.ADS713.Fields[j].FieldName then
      (Controls[i] as TEdit).Text:=dm.ADS713.Fields[j].Value;
   if Controls[i].ClassName ='TDateTimePicker' then
    for j:=0 to dm.ADS713.FieldCount-1 do
     if Controls[i].Name =dm.ADS713.Fields[j].FieldName then
      (Controls[i] as TDateTimePicker).Date :=dm.ADS713.Fields[j].Value;
  end; //end for
 //��������
 HZSTATUS.ItemIndex:=dm.ADS713.FieldValues['HZSTATUS'];
 //�ͻ�
 dm.AQery.Close ;
 dm.AQery.SQL.Text:='select *  from data0010 where rkey='+dm.ADS713.FieldByName('PTR10').AsString;
 dm.AQery.Open ;

 edit1.Text :=dm.AQery.FieldValues['CUST_CODE'];
 Label2.Caption:=dm.AQery.FieldValues['CUSTOMER_NAME'];
 _CostPTR:=dm.AQery.FieldValues['rkey'];

end;
procedure TfrmSKJH.FormShow(Sender: TObject);
begin
 if _isedit then
  Get713()
 else
 skrq.Date:=date();
end;
//�ͻ�
procedure TfrmSKJH.BitBtn1Click(Sender: TObject);
begin
  Application.CreateForm(TfrmCostomer, frmCostomer);
  frmCostomer.AQery10.Open ;
  if trim(edit1.Text)<>'' then
   frmCostomer.Edit1.Text:=trim(edit1.Text);
  if frmCostomer.ShowModal=mrOk then
  begin
   edit1.Text:=frmCostomer.AQery10CUST_CODE.Value;
   Label2.Caption:=frmCostomer.AQery10CUSTOMER_NAME.Value ;
   _CostPTR:=frmCostomer.AQery10Rkey.Value;
  end;

  frmCostomer.Free();
end;
//����
procedure TfrmSKJH.SpeedButton1Click(Sender: TObject);
var
 i:integer;
begin
 if trim(Edit1.Text)='' then
  begin
   messagedlg('�ͻ�����Ϊ�գ�����',mtinformation,[mbok],0);
  end;

 try

  for i:=0 to ControlCount-1 do
    if Controls[i].ClassName  ='TEdit' then
     if (Controls[i].Name <>'Edit1') then
      strtofloat(TEdit(Controls[i]).Text);
  if not _isedit then
   begin
    if New713() =false then exit;
   end
  else
   begin
    if Edit713()=false then exit;
   end;
  close;
 except
   on E: Exception do
     begin
      messagedlg(E.Message,mtinformation,[mbok],0);
     end;
 end;
end;

procedure TfrmSKJH.SpeedButton2Click(Sender: TObject);
begin
 close;
end;

procedure TfrmSKJH.Edit1Exit(Sender: TObject);
begin
//�ͻ�
 if trim(edit1.Text )='' then exit;
 dm.AQery.Close ;
 dm.AQery.SQL.Text:='select *  from data0010 where CUST_CODE='''+trim(Edit1.Text)+'''';
 dm.AQery.Open ;
 if dm.AQery.RecordCount<>0 then
  begin
   edit1.Text :=dm.AQery.FieldValues['CUST_CODE'];
   Label2.Caption:=dm.AQery.FieldValues['CUSTOMER_NAME'];
   _CostPTR:=dm.AQery.FieldValues['rkey'];
  end
 else
  begin
    showmessage('�ͻ������ڣ�����');
   _CostPTR:=0;
   Label2.Caption:='';
   edit1.Text :='';
  end;
end;

procedure TfrmSKJH.HJYSKeyPress(Sender: TObject; var Key: Char);
begin
 if key=#13 then exit;
 if checkchar(TEdit(Sender).Text, key)=false then
    begin
      showmessage('���������֣�����');
      abort;
    end;
end;

end.
