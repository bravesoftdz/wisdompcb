unit Edit_Data0277;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls,db;

type
  TfrmEdit_Data0277 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    rgStatus: TRadioGroup;
    Label3: TLabel;
    edtName: TEdit;
    edtDesc: TEdit;
    btnSave: TButton;
    btnCancel: TButton;
    procedure btnSaveClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    { Private declarations }
    Run_Mode:byte;//����ģʽ 1�������2��������3���༭
    procedure Set_Run_Mode;//���ô�����༭���ģʽ��
    function Check_Unique_Value(KeyValue:string):boolean; //��֤��������Ƿ��Ѿ��������ݱ���,true�������ڣ�false����
  public
    { Public declarations }
   //��ں�����enter_mode����ģʽ 1�������2��������3���༭
    procedure Enter(EnterMode:byte);
end;

var
  frmEdit_Data0277: TfrmEdit_Data0277;

implementation
uses common,constVar,Main_Data095,MyClass;
{$R *.dfm}

{ TfrmEdit_Data0277 }

procedure TfrmEdit_Data0277.Enter(EnterMode: byte);
begin
//  ads_Tmp.Locate(,FieldValue,[loCaseInsensitive ]);//���ҵļ�¼��ֵ������ȫƥ��
  //ֱ�Ӵ����ݱ��л�ȡ����
  Run_Mode:= EnterMode;
  if Run_Mode <> em_Add then
  begin
    edtName.Text := Is_Null(frmMain_Data095.adsMaster.fieldbyName('CATEGORY_NAME').AsString,'');
    edtDesc.Text := Is_Null(frmMain_Data095.adsMaster.fieldbyName('CATEGORY_DESC').AsString,'');
    rgStatus.ItemIndex:= Is_Null(frmMain_Data095.adsMaster.fieldbyName('STATUS').AsInteger,1)-1;
  end;
  Set_Run_Mode;
  Showmodal;
end;

procedure TfrmEdit_Data0277.btnSaveClick(Sender: TObject);
begin
  inherited;
  if Run_Mode = em_Add then //�����������¼����ô��Ҫ��֤����Ƿ��ظ�
    if not Check_Unique_Value(trim(edtName.Text)) then abort;
  with frmMain_Data095 do begin
    if run_Mode = em_Add then //����
      adsMaster.Append
    else  if run_Mode = em_Edit then //�༭
    begin
      adsMaster.Locate('CATEGORY_NAME',trim(edtName.Text),[loCaseInsensitive]);//���ҵļ�¼��ֵ������ȫƥ��
      adsMaster.Edit;
    end;
//���ݸ�ֵ
    adsMaster.FieldByName('CATEGORY_NAME').Value := edtName.Text;
    adsMaster.FieldByName('CATEGORY_DESC').Value := edtDesc.Text;
    adsMaster.fieldbyName('STATUS').AsInteger := rgStatus.ItemIndex +1;
    adsMaster.Post;
    if not MyDataClass.SaveData(adsMaster,true) then
    begin
      ShowMsg('��������ʧ�ܣ�����!','����',1);
      abort;
    end;
  end;
  close;
end;

procedure TfrmEdit_Data0277.Set_Run_Mode;
begin
  btnSave.Enabled := Run_Mode <> em_Browse;
  edtName.readonly := not btnSave.Enabled;
  edtDesc.readonly := not btnSave.Enabled;
  rgStatus.Enabled := btnSave.Enabled;
end;

function TfrmEdit_Data0277.Check_Unique_Value(KeyValue:string): boolean;
var
  Sqlstr:string;
begin
  if KeyValue = '' then //��ֵ����ͨ����֤
  begin
    ShowMsg('������Ʋ���Ϊ�գ�����!','����',1);
    result := false;
  end
  else
  begin
    Sqlstr:='select * from data0277 where CATEGORY_NAME='+QuotedStr(KeyValue);
    result := not MyDataClass.IsExists(sqlstr);
//    result := adsMaster.aqTmp.IsEmpty;
    if not result then
      ShowMsg('������Ѿ����ڣ�������¼�룬����!','����',1);
  end;
end;

procedure TfrmEdit_Data0277.FormActivate(Sender: TObject);
begin
  inherited;
  edtName.SetFocus;
end;

end.
