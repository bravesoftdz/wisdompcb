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
    JHYS: TEdit;
    JHRQ: TDateTimePicker;
    HZSTATUS: TRadioGroup;
    CQTS: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label22: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure HJYSKeyPress(Sender: TObject; var Key: Char);
  private
    _CostPTR:integer;
    function New707():boolean;
    function Edit707():boolean;
    procedure Get707();
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
function TfrmSKJH.New707():boolean;
var
 vrkey:integer;
begin
  dm.AQery.Close ;
  dm.AQery.SQL.Text:='SELECT * FROM data0707 WHERE (RKEY IS NULL)';
  dm.AQery.Open ;
  try

    dm.AQery.Append ;
    dm.AQery.FieldValues['PTR']:=dm.AQery704.FieldValues['rkey'];//704��ָ��
    dm.AQery.FieldValues['PTR10']:=_CostPTR;                  //�ͻ�10ָ��
    dm.AQery.FieldValues['HJYS']:=strtofloat(HJYS.Text);      //��Ƿ����
    dm.AQery.FieldValues['DQYS']:=strtofloat(DQYS.Text);      //���ڻ���
    dm.AQery.FieldValues['JHYS']:=strtofloat(JHYS.Text);      //�ƻ��տ�
    dm.AQery.FieldValues['JHRQ']:=JHRQ.Date ;                 //�ƻ�����
    dm.AQery.FieldValues['CQTS']:=strtofloat(CQTS.Text);      //��������
    dm.AQery.FieldValues['HZSTATUS']:=HZSTATUS.ItemIndex;         //�����Բ�(0��������,1��������,2ֹͣ����)
    dm.AQery.Post;
    messagedlg('����ɹ�������',mtinformation,[mbok],0);
    vrkey:=dm.AQery.FieldValues['rkey'];
    dm.ADS707.Close;
    dm.ADS707.Open ;
    dm.ADS707.Locate('rkey',vrkey,[]);
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
function TfrmSKJH.Edit707():boolean;
var
 vrkey:integer;
begin
  dm.AQery.Close ;
  dm.AQery.SQL.Text:='SELECT * FROM data0707 WHERE (RKEY ='+dm.ADS707.FieldByName('rkey').AsString+')';
  dm.AQery.Open ;
  try
    dm.AQery.Edit;
    dm.AQery.FieldValues['PTR10']:=_CostPTR;                  //�ͻ�10ָ��
    dm.AQery.FieldValues['HJYS']:=strtofloat(HJYS.Text);      //��Ƿ����
    dm.AQery.FieldValues['DQYS']:=strtofloat(DQYS.Text);      //���ڻ���
    dm.AQery.FieldValues['JHYS']:=strtofloat(JHYS.Text);      //�ƻ��տ�
    dm.AQery.FieldValues['JHRQ']:=JHRQ.Date ;                 //�ƻ�����
    dm.AQery.FieldValues['CQTS']:=strtofloat(CQTS.Text);      //��������
    dm.AQery.FieldValues['HZSTATUS']:=HZSTATUS.ItemIndex;     //�����Բ�(0��������,1��������,2ֹͣ����)
    dm.AQery.Post;
    messagedlg('����ɹ�������',mtinformation,[mbok],0);
    vrkey:=dm.ADS705.FieldValues['rkey'];
    dm.ADS707.Close;
    dm.ADS707.Open ;
    dm.ADS707.Locate('rkey',vrkey,[]);
    result:=true;
  except
   on E: Exception do
     begin
      messagedlg(E.Message,mtinformation,[mbok],0);
      result:=false;
     end;
  end;

end;
procedure TfrmSKJH.Get707();
var
 i,j:integer;
begin
 for i:=0 to ControlCount-1 do
  begin
   if Controls[i].ClassName ='TEdit' then
    for j:=0 to dm.ADS707.FieldCount-1 do
     if Controls[i].Name =dm.ADS707.Fields[j].FieldName then
      (Controls[i] as TEdit).Text:=dm.ADS707.Fields[j].Value;
   if Controls[i].ClassName ='TDateTimePicker' then
    for j:=0 to dm.ADS707.FieldCount-1 do
     if Controls[i].Name =dm.ADS707.Fields[j].FieldName then
      (Controls[i] as TDateTimePicker).Date:=dm.ADS707.Fields[j].Value;
  end; //end for
 //��������
 HZSTATUS.ItemIndex:=dm.ADS707.FieldValues['HZSTATUS'];
 //�ͻ�
 dm.AQery.Close ;
 dm.AQery.SQL.Text:='select *  from data0010 where rkey='+dm.ADS707.FieldByName('PTR10').AsString;
 dm.AQery.Open ;

 edit1.Text :=dm.AQery.FieldValues['CUST_CODE'];
 Label2.Caption:=dm.AQery.FieldValues['CUSTOMER_NAME'];
 _CostPTR:=dm.AQery.FieldValues['rkey'];

end;
procedure TfrmSKJH.FormShow(Sender: TObject);
begin
 if _isedit then
  Get707()
 else
  jhrq.Date:=date(); 
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
   bitbtn1.SetFocus;
   exit;
  end;

 try

  for i:=0 to ControlCount-1 do
    if Controls[i].ClassName  ='TEdit' then
     if (Controls[i].Name <>'Edit1') then
      strtofloat(TEdit(Controls[i]).Text);
  if not _isedit then
   begin
    if New707() =false then exit;
   end
  else
   begin
    if Edit707()=false then exit;
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
