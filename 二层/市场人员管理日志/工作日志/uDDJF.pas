unit uDDJF;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, ExtCtrls, StdCtrls;

type
  TfrmDDJF = class(TForm)
    Panel3: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    Edit1: TEdit;
    Edit2: TEdit;
    DDSL: TEdit;
    JHSL: TEdit;
    QHSL: TEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure Edit1Exit(Sender: TObject);
    procedure DDSLKeyPress(Sender: TObject; var Key: Char);
  private
    _CostPTR,_CPPTR:integer;
    function New709():boolean;
    function Edit709():boolean;
    procedure Get709();
  public
    _isedit:boolean;
  end;

var
  frmDDJF: TfrmDDJF;

implementation

uses uCostomer, uCPInfo, uDM;

{$R *.dfm}
function checkchar(const pstr:string;const pkey:char):boolean;
var
 i,iLast:integer;
begin
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

function TfrmDDJF.New709():boolean;
var
 vrkey:integer;
begin
  dm.AQery.Close ;
  dm.AQery.SQL.Text:='SELECT * FROM data0709 WHERE (RKEY IS NULL)';
  dm.AQery.Open ;
  try

    dm.AQery.Append ;
    dm.AQery.FieldValues['PTR708']:=dm.AQery708RKEY.Value;    //708��ָ��
    dm.AQery.FieldValues['PTR10']:=_CostPTR;                  //�ͻ�ָ��
    dm.AQery.FieldValues['PTR50']:=_CPPTR;                    //��Ʒָ��
    dm.AQery.FieldValues['DDSL']:=strtofloat(DDSL.Text);      //��������
    dm.AQery.FieldValues['JHSL']:=strtofloat(JHSL.Text);      //��������
    dm.AQery.FieldValues['QHSL']:=strtofloat(QHSL.Text);      //Ƿ������

    dm.AQery.Post;
    messagedlg('����ɹ�������',mtinformation,[mbok],0);
    vrkey:=dm.AQery.FieldValues['rkey'];
    dm.ADS709.Close;
    dm.ADS709.Open ;
    dm.ADS709.Locate('rkey',vrkey,[]);
    result:=true;
  except
   on E: Exception do
     begin
      messagedlg(E.Message,mtinformation,[mbok],0);
      result:=false;
     end;
  end;

end;
function TfrmDDJF.Edit709():boolean;
var
 vrkey:integer;
begin
  dm.AQery.Close ;
  dm.AQery.SQL.Text:='SELECT * FROM data0709 WHERE (RKEY ='+dm.ADS709.FieldByName('rkey').AsString+')';
  dm.AQery.Open ;
  try
    dm.AQery.Edit;

    dm.AQery.FieldValues['PTR708']:=dm.AQery708RKEY.Value;    //708��ָ��
    dm.AQery.FieldValues['PTR10']:=_CostPTR;                  //�ͻ�ָ��
    dm.AQery.FieldValues['PTR50']:=_CPPTR;                    //��Ʒָ��
    dm.AQery.FieldValues['DDSL']:=strtofloat(DDSL.Text);      //��������
    dm.AQery.FieldValues['JHSL']:=strtofloat(JHSL.Text);      //��������
    dm.AQery.FieldValues['QHSL']:=strtofloat(QHSL.Text);      //Ƿ������
    dm.AQery.Post;
    messagedlg('����ɹ�������',mtinformation,[mbok],0);
    vrkey:=dm.ADS709.FieldValues['rkey'];
    dm.ADS709.Close;
    dm.ADS709.Open ;
    dm.ADS709.Locate('rkey',vrkey,[]);
    result:=true;
  except
   on E: Exception do
     begin
      messagedlg(E.Message,mtinformation,[mbok],0);
      result:=false;
     end;
  end;
end;
procedure TfrmDDJF.Get709();
var
 i,j:integer;
begin
 for i:=0 to ControlCount-1 do
  begin
   if Controls[i].ClassName ='TEdit' then
    for j:=0 to dm.ADS709.FieldCount-1 do
     if Controls[i].Name =dm.ADS709.Fields[j].FieldName then
      (Controls[i] as TEdit).Text:=dm.ADS709.Fields[j].Value;
  end; //end for
 //�ͻ�
 dm.AQery.Close ;
 dm.AQery.SQL.Text:='select *  from data0010 where rkey='+dm.ADS709.FieldByName('PTR10').AsString;
 dm.AQery.Open ;
 if dm.AQery.RecordCount<>0 then
  begin
   edit1.Text :=dm.AQery.FieldValues['CUST_CODE'];
   Label2.Caption:=dm.AQery.FieldValues['CUSTOMER_NAME'];
   _CostPTR:=dm.AQery.FieldValues['rkey'];
  end;
 //��Ʒ
 dm.AQery.Close ;
 dm.AQery.SQL.Text:='select RKEY, MANU_PART_NUMBER, MANU_PART_DESC  from data0025 where rkey='+dm.ADS709.FieldByName('PTR50').AsString;
 dm.AQery.Open ;
 if dm.AQery.RecordCount<>0 then
  begin
   edit2.Text :=dm.AQery.FieldValues['MANU_PART_NUMBER'];
   Label4.Caption:=dm.AQery.FieldValues['MANU_PART_DESC'];
   _CPPTR:=dm.AQery.FieldValues['rkey'];
  end;
end;

procedure TfrmDDJF.FormShow(Sender: TObject);
begin
 if _isedit then
  Get709();
end;
//�ͻ�
procedure TfrmDDJF.BitBtn1Click(Sender: TObject);
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
//��Ʒ
procedure TfrmDDJF.BitBtn2Click(Sender: TObject);
begin
  Application.CreateForm(TfrmCPInfo, frmCPInfo);
  frmCPInfo.AQery50.Open ;
  if trim(edit2.Text)<>'' then
   frmCPInfo.Edit1.Text:=trim(edit2.Text);
  if frmCPInfo.ShowModal=mrOk then
  begin
   edit2.Text:=frmCPInfo.AQery50MANU_PART_NUMBER.Value;
   Label4.Caption:=frmCPInfo.AQery50MANU_PART_DESC.Value ;
   _CPPTR:=frmCPInfo.AQery50RKEY.Value;
  end;

  frmCPInfo.Free();
end;
//����
procedure TfrmDDJF.SpeedButton1Click(Sender: TObject);
begin
 if _CostPTR=0 then
  begin
   messagedlg('�ͻ�����Ϊ�գ�����',mtinformation,[mbok],0);
   exit;
  end;
 if _CPPTR=0 then
  begin
   messagedlg('��Ʒ����Ϊ�գ�����',mtinformation,[mbok],0);
   exit;
  end;
 try
  strtofloat(DDSL.Text);
  strtofloat(JHSL.Text);
  strtofloat(QHSL.Text);
 if not _isedit then
   begin
    if New709() =false then exit;
   end
  else
   begin
    if Edit709()=false then exit;
   end;
  close; 
 except
   on E: Exception do
     begin
      messagedlg(E.Message,mtinformation,[mbok],0);
     end;
 end;
end;

procedure TfrmDDJF.SpeedButton2Click(Sender: TObject);
begin
 close;
end;

procedure TfrmDDJF.Edit1Exit(Sender: TObject);
begin
 //�ͻ�
 if Edit1.Text='' then exit;
 dm.AQery.Close ;
 dm.AQery.SQL.Text:='select *  from data0010 where CUST_CODE='''+Edit1.Text+'''';
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

procedure TfrmDDJF.DDSLKeyPress(Sender: TObject; var Key: Char);
begin
 if key=#13 then exit;
 if checkchar(TEdit(Sender).Text, key)=false then
    begin
      showmessage('���������֣�����');
      abort;
    end;
end;

end.
