unit UContractPayDetail;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, Grids, DBGridEh, DB, ADODB, Menus;

type
  TfrmCPayDetail = class(TForm)
    pnl1: TPanel;
    pnl2: TPanel;
    pnl3: TPanel;
    btn_Save: TBitBtn;
    btn_close: TBitBtn;
    eh617: TDBGridEh;
    ds617: TDataSource;
    qry617: TADOQuery;
    atncfldqry617rkey: TAutoIncField;
    intgrfldqry617po_ptr: TIntegerField;
    qry617pay_percent: TBCDField;
    qry617pay_amount: TBCDField;
    qry617pay_complete: TBooleanField;
    dtmfldqry617pay_date: TDateTimeField;
    wrdfldqry617pay_type: TWordField;
    qry617auth_status: TBooleanField;
    wdstrngfldqry617remark: TWideStringField;
    lbl1: TLabel;
    pm1: TPopupMenu;
    mni_del: TMenuItem;
    qry617pay_over: TBooleanField;
    lbl2: TLabel;
    lbl_money: TLabel;
    procedure btn_closeClick(Sender: TObject);
    procedure btn_SaveClick(Sender: TObject);
    procedure eh617ColExit(Sender: TObject);
    procedure eh617KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure eh617Exit(Sender: TObject);
    procedure qry617BeforeInsert(DataSet: TDataSet);
    procedure mni_delClick(Sender: TObject);
    procedure qry617BeforeScroll(DataSet: TDataSet);
  private
    { Private declarations }
    function CheckPer:boolean;
    function checkDate:boolean;
  public
    { Public declarations }
    Frkey70 :string;
    FSUB_TOTAL70:Double;
   procedure GetData(arkey70:string);
  end;

var
  frmCPayDetail: TfrmCPayDetail;

implementation
     uses damo,common;
{$R *.dfm}

procedure TfrmCPayDetail.btn_closeClick(Sender: TObject);
begin
close;
end;

procedure TfrmCPayDetail.btn_SaveClick(Sender: TObject);
var i : Double;
begin

 if qry617.IsEmpty then Exit;

  qry617.DisableControls;
  try
   qry617.First;
   while not qry617.Eof do
   begin
   qry617.Edit;
   qry617.Fieldbyname('po_ptr').Value:=StrToInt(self.Frkey70);
   if  (qry617.Fieldbyname('pay_type').asstring='') or (qry617.Fieldbyname('pay_date').asstring='')  then
   begin
   showmessage('ʱ�䡢�ٷֱȡ����������Ͳ���Ϊ�գ�');
   exit;
   end;
   qry617.Post;
   qry617.Next;
   end;
  finally
  qry617.EnableControls;
  end;

  if not CheckPer then
   begin
   ShowMessage('�ܰٷֱȱ���Ϊ100��');
   Exit;
   end;

   if not CheckDate then
   begin
   ShowMessage('��������ڲ��ܱ�ǰ���С��');
   Exit;
   end;

   qry617.First;
   while not qry617.Eof do
   begin
    i:=i+ qry617.FieldValues['pay_amount'];
    qry617.Next;
   end;
//   if FSUB_TOTAL70<>i then
//   begin
//     ShowMessage('���֮�Ͳ������ܼƼ۸�,�����¼���');
//     exit;
//   end;



   qry617.UpdateBatch(arall);

   self.ModalResult:=mrok;

end;

procedure TfrmCPayDetail.GetData(arkey70: string);
begin
   qry617.Close;
   qry617.Parameters[0].Value:=arkey70;
   qry617.Open;
   
end;

procedure TfrmCPayDetail.eh617ColExit(Sender: TObject);
var
  LRow:integer;
begin
  with (Sender  as TDBGridEh) do
  begin
    if (eh617.SelectedIndex=0) and (eh617.Fields[0].Text<>'') then //ʱ��
     begin
     // LRow:=eh617.Row-1;
     // eh617.SelectedIndex:=1;
     end;
    if (eh617.SelectedIndex=1) and (eh617.Fields[1].Text<>'') then //�ٷֱ�
     begin
       //eh617.SelectedIndex:=2;
      if StrToFloat(eh617.Fields[1].Text)>100  then eh617.SelectedIndex:=1;
      if not (qry617.State in [dsedit,dsinsert])then qry617.edit;
      eh617.Fields[2].Text:= (FormatFloat('0.00',StrToFloat(eh617.Fields[1].Text)*self.FSUB_TOTAL70/100.0)) ;
       //eh617.SelectedIndex:=2;
     end;

    // if (eh617.SelectedIndex=3) and (eh617.Fields[3].Text<>'') then //��������
     // eh617.SelectedIndex:=4;

    if   (qry617.State in [dsedit,dsinsert])then qry617.post;
  end;
end;

procedure TfrmCPayDetail.eh617KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin

   if   (Key<>13)  then Exit;                       //       and  (Key<>38)  and  (Key<>40) 

   if  not (qry617.State in [dsedit,dsinsert]) then qry617.edit;

   if (eh617.SelectedIndex=0) and (eh617.Fields[0].Text<>'') then //ʱ��
     eh617.SelectedIndex:=1;

    if (eh617.SelectedIndex=1) and (eh617.Fields[1].Text<>'') then //�ٷֱ�
     begin
       eh617.SelectedIndex:=3;
      if StrToFloat(eh617.Fields[1].Text)>100  then eh617.SelectedIndex:=1;
      if not (qry617.State in [dsedit,dsinsert])then qry617.edit;
      eh617.Fields[2].Text:= (FormatFloat('0.00',StrToFloat(eh617.Fields[1].Text)*self.FSUB_TOTAL70/100.0)) ;
     end;

     if (eh617.SelectedIndex=3) and (eh617.Fields[3].Text<>'') then //��������
      eh617.SelectedIndex:=4;
    if   (qry617.State in [dsedit,dsinsert])then qry617.post;
end;

procedure TfrmCPayDetail.eh617Exit(Sender: TObject);
var
  LPer , LMoney: Double;
begin
   if qry617.IsEmpty then Exit;
  qry617.DisableControls;
  try
   qry617.First;
   LPer:=0; LMoney:=0;
   while not qry617.Eof do
   begin
   if  qry617.Fieldbyname('pay_percent').asstring<>'' then
   begin
   LPer:=LPer+qry617.Fieldbyname('pay_percent').Value;
   qry617.edit;
   qry617.Fieldbyname('pay_amount').asstring:= FloatToStr(qry617.Fieldbyname('pay_percent').asfloat*self.FSUB_TOTAL70/100.0);
   qry617.post;
   end;
    if  qry617.Fieldbyname('pay_amount').asstring<>'' then
   LMoney:=LMoney+qry617.Fieldbyname('pay_amount').Value;
   qry617.Next;
   end;
   if LPEr<>100 then
   begin
   ShowMessage('�ܰٷֱȱ�����100,��ȷ�Ϻ��������룡');
   eh617.SetFocus;
   Exit;
   end;
//   if LMoney<>FSUB_TOTAL70 then
//   begin
//   ShowMessage('�ܽ����ɹ������ܸ������,��ȷ�Ϻ��������룡');
//   eh617.SetFocus;
//   Exit;
//   end;
  finally
  qry617.EnableControls;
  end;

end;


function TfrmCPayDetail.CheckPer: boolean;
var
  LPer : Double;
begin
  result:=true;
   if qry617.IsEmpty then Exit;
  qry617.DisableControls;
  try
   qry617.First;
   LPer:=0;
   while not qry617.Eof do
   begin
   if qry617.Fieldbyname('pay_percent').asstring<>'' then 
   LPer:=LPer+qry617.Fieldbyname('pay_percent').Value;
   qry617.Next;
   end;
   if LPEr>100 then
    result:=false;
  finally
  qry617.EnableControls;
  end;

end;

procedure TfrmCPayDetail.mni_delClick(Sender: TObject);
begin
 if qry617.IsEmpty  then Exit;
 qry617.Delete;
end;

function TfrmCPayDetail.checkDate: boolean;
var
  LDate : TDateTime;
begin
  result:=true;
   if qry617.IsEmpty then Exit;
  qry617.DisableControls;
  try
   LDate:=StrToDateTime('1991-01-01');
   qry617.First;
   while not qry617.Eof do
   begin
   if  (LDate>StrToDateTime('1991-01-01')) and  (LDate>=qry617.Fieldbyname('pay_date').asdatetime) then
   begin
   result:=false;
   exit;
   end;
   LDate:=qry617.Fieldbyname('pay_date').asdatetime;
   qry617.Next;
   end;
  finally
  qry617.EnableControls;
  end;
end;

procedure TfrmCPayDetail.qry617BeforeScroll(DataSet: TDataSet);
begin
// if not (qry617.State in [dsedit,dsinsert])then qry617.edit;
// if (eh617.Fields[1].Text<>'') then 
// eh617.Fields[2].Text:= (FormatFloat('0.00',StrToFloat(eh617.Fields[1].Text)*self.FSUB_TOTAL70/100.0)) ;
end;

procedure TfrmCPayDetail.qry617BeforeInsert(DataSet: TDataSet);
begin
  if ( not  checkDate) and (qry617.recordcount>1)  then
  begin
  ShowMessage('��������ڲ��ܱ�ǰ���С��');
  exit;
  end;
  
  if CheckPer=false then
  begin
  ShowMessage('�ܰٷֱȲ��ܴ���100');
  exit;
  end;

  if eh617.Fields[0].Text='' then exit;
  if   (eh617.Fields[1].Text='') or  (eh617.Fields[2].Text='') or (eh617.Fields[3].Text='') then
  begin
  ShowMessage('ʱ�䡢�ٷֱȡ����������Ͷ�����Ϊ�գ�');
   qry617.last;
  exit;
  end;
end;


end.
