unit SupplieReturnMX;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uBaseEditFrm,ucommfunc, Vcl.StdCtrls,
  Vcl.Buttons, Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.Mask, RzEdit, RzBtnEdt,
  uRKeyBtnEdit, Data.DB, Datasnap.DBClient,uBaseSinglePickListFrm;

type
  TfrmSupplieReturnMX = class(TfrmBaseEdit)
    Label4: TLabel;
    Label10: TLabel;
    Label2: TLabel;
    Label1: TLabel;
    Label9: TLabel;
    Label13: TLabel;
    Label3: TLabel;
    Label11: TLabel;
    Label8: TLabel;
    Label7: TLabel;
    Label6: TLabel;
    Label12: TLabel;
    Edit8: TEdit;
    Edit9: TEdit;
    Edit10: TEdit;
    cds724: TClientDataSet;
    cds149: TClientDataSet;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    cds134: TClientDataSet;
    cds04: TClientDataSet;
    Edit11: TEdit;
    Edit12: TEdit;
    BitBtn2: TBitBtn;
    procedure Edit8Exit(Sender: TObject);
    procedure Edit8KeyPress(Sender: TObject; var Key: Char);
    procedure BitBtn2Click(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure Edit9KeyPress(Sender: TObject; var Key: Char);
    procedure btnCloseClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    LGRName:string; //04���º�
    function Power(x, y : extended) : extended;
    function update04(table_name:string;var LsName:string):string;
    procedure getdate(ARkey:string);
  end;

var
  frmSupplieReturnMX: TfrmSupplieReturnMX;

implementation

{$R *.dfm}

{ TfrmSupplieReturnMX }

procedure TfrmSupplieReturnMX.BitBtn2Click(Sender: TObject);
var LFrm: TfrmSinglePickList;
begin
  LFrm := TfrmSinglePickList.Create(Self);
  try
    LFrm.InitWithPickID(564,6);
    if LFrm.ShowModal = mrOk then
    begin
      Edit12.Text:=LFrm.cdsPick.FieldByName('EMPLOYEE_NAME').AsString;
      Edit12.Tag:=LFrm.cdsPick.FieldByName('rkey').Value;
    end;
  finally
    LFrm.Free;
  end;
end;

procedure TfrmSupplieReturnMX.btnCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmSupplieReturnMX.btnSaveClick(Sender: TObject);
var Lcds:TClientDataSet;
    LsName:string;
    LPostData: OleVariant;
begin
  inherited;
  Lcds:=TClientDataSet.Create(Self);
  try
    if strtofloat(Edit8.Text)=0 then
    begin
      messagedlg('�˻�����Ϊ��!',mtinformation,[mbok],0);
      Edit8.SetFocus;
      exit;
    end;
    if trim(Edit12.Text)='' then
    begin
      messagedlg('����ѡ��������Ա!',mtinformation,[mbok],0);
      exit;
    end;
    gSvrIntf.IntfGetDataBySql('select * from data0724 where GON_NUMBER = ''' + Trim(Edit11.Text)+'''',Lcds);
    if not Lcds.IsEmpty then
    begin
      if messagedlg('��ֱ���ظ�,�����ж�̨�����ͬʱ����,�Ƿ��Զ����±��?',mtConfirmation,[mbYes,mbNo],0)=mrYes  then
      begin
        LGRName:=update04('data0724',LsName);
        Edit11.Text:=LsName;
      end;
    end;
    //����724
    cds724.Append;
    cds724.FieldByName('GON_NUMBER').Value:=Trim(Edit11.Text);//���ֵ���
    cds724.FieldByName('warehouse_ptr').Value:=Edit3.Tag;//����
    cds724.FieldByName('TTYPE').Value:=0;
    cds724.FieldByName('CREATE_BY').Value:=gVar.rkey05; //������Ա
    cds724.FieldByName('CREATE_DATE').Value:=gFunc.GetSvrDateTime; //��������
    cds724.FieldByName('REF_NUMBER').Value:=Trim(Edit10.Text);//��ע
    cds724.FieldByName('RECD_BY').Value:=Edit12.Tag;//�˻���Ա
    cds724.FieldByName('supplier_ptr').Value:=Edit2.Tag; //��Ӧ��
    cds724.FieldByName('status').Value:=0;
    cds724.FieldByName('idkey').Value := gFunc.CreateIDKey;
    cds724.Post;
    //����149
    cds149.Append;
    cds149.FieldByName('D0134_PTR').Value:=Edit11.Tag;
    cds149.FieldByName('INVENTORY_PTR').Value:=Edit1.Tag;
    cds149.FieldByName('RTN_QUANTITY').Value:=strtofloat(Edit8.Text);
    if Trim(Edit9.Text)='' then Edit9.Text:='0';
    cds149.FieldByName('tax_price').Value:=strtofloat(Edit9.Text);
    cds149.FieldByName('TAX_2').Value:=StrToFloat(Edit7.Text);
    cds149.FieldByName('D724_IDKey').Value:=cds724.FieldByName('idkey').Value;
    cds149.Post;
    //����04
    gSvrIntf.IntfGetDataBySql('select * from data0004 where table_name=''data0724''',cds04);
    cds04.Edit;
    cds04.FieldByName('SEED_VALUE').Value:=LGRName;
    cds04.Post;
    //����134

    gSvrIntf.IntfGetDataBySql('select * from Data0134 where rkey='+IntToStr(Edit11.Tag)+'',cds134);
    cds134.Edit;
    cds134.FieldByName('quan_on_hand').Value:=cds134.FieldByName('quan_on_hand').Value-strtofloat(Edit8.text);
    cds134.Post;

    if cds724.State in [dsEdit,dsInsert] then cds724.Post;
    if cds149.State in [dsEdit,dsInsert] then cds149.Post;
    if cds04.State in [dsEdit,dsInsert] then cds04.Post;
    if cds134.State in [dsEdit,dsInsert] then cds134.Post;
    LPostData := VarArrayCreate([0,3],varVariant);
    if cds724.ChangeCount > 0 then
      LPostData[0] := cds724.Delta;
    if cds149.ChangeCount > 0 then
      LPostData[1] := cds149.Delta;
    if cds04.ChangeCount > 0 then
      LPostData[2] := cds04.Delta;
    if cds134.ChangeCount > 0 then
      LPostData[3] := cds134.Delta;
    if gSvrIntf.IntfPostModData('��������',564,LPostData,2) then
    begin
      cds724.MergeChangeLog;
      cds149.MergeChangeLog;
      cds04.MergeChangeLog;
      cds134.MergeChangeLog;
      ShowMessage('����ɹ�');
      Close;
    end;
  finally
    Lcds.Free;
  end;
end;

procedure TfrmSupplieReturnMX.Edit8Exit(Sender: TObject);
begin
  inherited;
  if trim(Edit8.Text) = '' then  Edit8.Text := '0';
  if strtofloat(Edit8.Text) > strtofloat(edit6.Text) then
  begin
    messagedlg('�˻��������ܴ��ڵ�ǰ�������!',mterror,[mbcancel],0);
    Edit8.SetFocus;
  end
  else Edit8.Text := formatfloat('0.000',strtofloat(Edit8.Text));
end;

procedure TfrmSupplieReturnMX.Edit8KeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if not (CharInSet (Key,['0'..'9','.',#8,#13])) then  //�ж��Ƿ���������
  abort
  else
  if (pos('.',Edit8.Text)>0)  then     //�ж��Ƿ��ظ�����С����'.'
  if key = chr(46)  then abort;
end;

procedure TfrmSupplieReturnMX.Edit9KeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if not (CharInSet(Key,['0'..'9','.',#8,#13])) then  //�ж��Ƿ���������
  abort
  else
  if (pos('.',Edit9.Text)>0)  then     //�ж��Ƿ��ظ�����С����'.'
  if key = chr(46)  then abort;
end;

procedure TfrmSupplieReturnMX.getdate(ARkey: string);
var
  LSq724,LSq149: string;
begin
  // data0724
  LSq724 := 'select * from data0724 where Rkey = 0' ;
  // data0149
  LSq149 := 'select * from data0149 where GON_PTR = 0 ';

  if not gSvrIntf.IntfGetDataBySqlArr(VarArrayOf([LSq724,LSq149]),[cds724,cds149]) then Exit;

  if (not cds724.IsEmpty) and (cds724.FieldByName('IDKEY').AsString = '') then
  begin
    cds724.Edit;
    cds724.FieldByName('IDKEY').AsString := gFunc.CreateIDKey;
    cds724.Post;
  end;
  cds149.DisableControls;
  try
    cds149.First;
    while not cds149.Eof do
    begin
      cds149.Edit;
      cds149.FieldByName('D724_IDKey').AsString := cds724.FieldByName('IDKEY').AsString;
      cds149.Post;
      cds149.Next;
    end;
    cds149.First;
  finally
    cds149.EnableControls;
  end;
end;

function TfrmSupplieReturnMX.Power(x, y: extended): extended;
begin
  result := exp(y*ln(x));
end;

function TfrmSupplieReturnMX.update04(table_name: string;
  var LsName: string): string;
var
  i,v_length:integer;
  v_last,v_seed,new_seed:string;
begin
  if not gSvrIntf.IntfGetDataBySql('select * from data0004 where table_name='''+table_name+'''',cds04) then Exit;
  if not cds04.IsEmpty then
  begin
    v_seed:=cds04.FieldByName('SEED_VALUE').AsString;
    LsName:=v_seed;
    if cds04.FieldByName('SEED_FLAG').Value<>1 then
    begin
      v_length := length(v_seed);
      for i := v_length downto 1 do
      if (copy(v_seed,i,1)<'0') or (copy(v_seed,i,1)>'9') then  //�����������
      begin
        v_last := floattostr(power(10,v_length)+strtofloat(copy(v_seed,i+1,v_length-i))+1); //��׺��1
        new_seed := copy(v_seed,1,i)+copy(v_last,i+2,v_length-i); //ʹǰ׺�����׺��1
        break;
      end
      else
      if i=1 then //�����һλ��Ȼ������
        begin
         v_last := floattostr(power(10,v_length)+strtofloat(v_seed)+1);
         new_seed := copy(v_last,2,v_length);
        end;
    end;
  end;
  result:=new_seed;
end;

end.
