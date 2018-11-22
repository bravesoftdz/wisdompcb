unit Edit_Data0278;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, BaseForm, DB, ADODB,StdCtrls, Mask, DBCtrls, ExtCtrls,
  Grids, DBGrids, Menus,Main_Data096, Buttons, DBGridEh;

type
  TfrmEdit_Data0278 = class(TForm)
    adsUpdate: TADODataSet;
    dsUpdate: TDataSource;
    adsUpdate_Sub: TADODataSet;
    dsUpdate_Sub: TDataSource;
    adsUpdateRKEY: TAutoIncField;
    adsUpdatePARAMETER_NAME: TStringField;
    adsUpdatePARAMETER_DESC: TStringField;
    adsUpdateCATEGORY_PTR: TIntegerField;
    adsUpdateUNIT_PTR: TIntegerField;
    adsUpdateDATA_TYPE: TWordField;
    adsUpdatePROTECTION_FLAG: TWordField;
    adsUpdateSTATUS: TWordField;
    adsUpdatestatus1: TWordField;
    adsUpdateSTATUS2: TWordField;
    adsUpdateSTATUS3: TWordField;
    adsUpdatePARAMETER_INFO: TStringField;
    adsUpdatePARAMETER_DOC_FLAG: TWordField;
    adsUpdateSEQUENCE_NO: TSmallintField;
    adsUpdateQUOTE_FLAG: TStringField;
    adsUpdatePRODUCTION_FLAG: TIntegerField;
    adsUpdateProd_Unit_base: TStringField;
    adsUpdateSPEC_RKEY: TStringField;
    adsUpdateSTATUS4: TWordField;
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    spdBtnUnit: TSpeedButton;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    dbcomboxDataType: TDBComboBox;
    DBEdit6: TDBEdit;
    DBCheckBox1: TDBCheckBox;
    DBCheckBox7: TDBCheckBox;
    DBCheckBox8: TDBCheckBox;
    DBCheckBox9: TDBCheckBox;
    DBCheckBox10: TDBCheckBox;
    btnSave: TButton;
    Button1: TButton;
    DBCheckBox2: TDBCheckBox;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    Label9: TLabel;
    N2: TMenuItem;
    adsUpdatemin_value: TFloatField;
    adsUpdatemax_value: TFloatField;
    GroupBox1: TGroupBox;
    Label10: TLabel;
    DBEdit7: TDBEdit;
    Label11: TLabel;
    DBEdit8: TDBEdit;
    adsUpdate_Subrkey: TAutoIncField;
    adsUpdate_SubPARAMETER_PTR: TIntegerField;
    adsUpdate_SubSEQUENCE_NO: TSmallintField;
    adsUpdate_SubTVALUE: TStringField;
    ehDBGrid_Sub1: TDBGridEh;
    dbchkQUOTE_FLAG: TDBCheckBox;
    dbchkQUOTE_FLAG1: TDBCheckBox;
    adsUpdateRFQMiParam: TBooleanField;
    adsUpdateRFQMustParam: TBooleanField;
    grp1: TGroupBox;
    rbGolb: TRadioButton;
    rbDept: TRadioButton;
    cbxBp: TCheckBox;
    cbxBomPrice: TComboBox;
    intgrfldUpdateBomPriceType: TIntegerField;
    procedure adsUpdateAfterScroll(DataSet: TDataSet);
    procedure adsUpdate_SubBeforeEdit(DataSet: TDataSet);
    procedure adsUpdate_SubBeforeDelete(DataSet: TDataSet);
    procedure adsUpdateDATA_TYPEGetText(Sender: TField; var Text: String;
      DisplayText: Boolean);
    procedure adsUpdateDATA_TYPESetText(Sender: TField;
      const Text: String);
    procedure btnSaveClick(Sender: TObject);
    procedure adsUpdatePARAMETER_NAMEValidate(Sender: TField);
    procedure adsUpdateUNIT_PTRGetText(Sender: TField; var Text: String;
      DisplayText: Boolean);
    procedure spdBtnUnitClick(Sender: TObject);
    procedure adsUpdateCATEGORY_PTRGetText(Sender: TField;
      var Text: String; DisplayText: Boolean);
    procedure adsUpdate_SubBeforeInsert(DataSet: TDataSet);
    procedure adsUpdate_SubNewRecord(DataSet: TDataSet);
    procedure adsUpdateNewRecord(DataSet: TDataSet);
    procedure adsUpdate_SubBeforePost(DataSet: TDataSet);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure dbcomboxDataTypeChange(Sender: TObject);
    procedure ehDBGrid_Sub1TitleClick(Column: TColumnEh);
    procedure FormShow(Sender: TObject);
    procedure cbxBpClick(Sender: TObject);
  private
    { Private declarations }
    Run_Mode:byte;//����ģʽ 1�������2��������3���༭
    SeqNo:integer;
    procedure Set_Run_Mode;//���ô�����༭���ģʽ��
    function Check_Unique_Value(KeyValue:string):boolean; //��֤��������Ƿ��Ѿ��������ݱ���,true�������ڣ�false����
    function Check_Before_Post:boolean;//����ǰ��������������
  public
    { Public declarations }
   //��ں�����enter_mode����ģʽ 1�������2��������3���༭
    procedure Enter(EnterMode:byte;KeyValue:string);
  end;

var
  frmEdit_Data0278: TfrmEdit_Data0278;

implementation
uses MyClass,ConstVar,Common;
{$R *.dfm}

procedure TfrmEdit_Data0278.adsUpdateAfterScroll(DataSet: TDataSet);
begin
  inherited;
  MyDataClass.OpenDataSetByPara(adsUpdate.fieldByName('rkey').Value,adsUpdate_Sub);
end;

procedure TfrmEdit_Data0278.adsUpdate_SubBeforeEdit(DataSet: TDataSet);
begin
  adsUpdate.Edit;
end;

procedure TfrmEdit_Data0278.adsUpdate_SubBeforeDelete(DataSet: TDataSet);
begin
  if not Msg_Dlg_Ask('ȷ��ɾ����¼��','��ʾ',1) then abort;
  adsUpdate.Edit;
end;

function TfrmEdit_Data0278.Check_Unique_Value(KeyValue: string): boolean;
var
  Sqlstr:string;
begin
  begin
    Sqlstr:='select * from data0278 where PARAMETER_NAME='+QuotedStr(trim(KeyValue));
    result := not MyDataClass.IsExists(sqlstr);
//    result := adsMaster.aqTmp.IsEmpty;
    if not result then
      ShowMsg('�ò����Ѿ����ڣ�������¼�룬����!','����',1);
  end;
end;

procedure TfrmEdit_Data0278.Set_Run_Mode;
begin
  btnSave.Enabled := Run_Mode <> em_Browse;
  if not btnSave.Enabled then
    adsUpdate.LockType := ltReadOnly
  else
    adsUpdate.LockType := ltBatchOptimistic;
  adsUpdate_Sub.LockType := adsUpdate.LockType;
  spdBtnUnit.Enabled := btnSave.Enabled;
end;

procedure TfrmEdit_Data0278.Enter(EnterMode: byte;KeyValue:string);
begin
  Run_Mode:= EnterMode;
  Set_Run_Mode;
  MyDataClass.OpenDataSetByPara(KeyValue,adsUpdate);
  case adsUpdate.FieldByName('CATEGORY_PTR').asinteger of
    2: rbGolb.Checked := True;
    3: rbDept.Checked := True;
  end;
  if adsUpdate.FieldByName('BomPriceType').AsInteger > 0 then
  begin
    cbxBp.Checked := True;
    cbxBomPrice.ItemIndex := adsUpdate.FieldByName('BomPriceType').AsInteger -1;
  end else
  begin
    cbxBp.Checked := False;
    cbxBomPrice.Enabled := False;
  end;


//  RadioGroup1.ItemIndex:= adsUpdate.FieldByName('CATEGORY_PTR').asinteger-2;
  if Run_Mode = em_Add then
  begin
//    RadioGroup1.ItemIndex:= 1;  //Ĭ��Ϊ�Ƴ̲���
    rbDept.Checked := True;
    adsUpdate.Append;
  end
  else
    GroupBox1.Visible:=adsUpdate.FieldByName('DATA_TYPE').AsInteger=1;
  if Run_Mode= em_edit then
    adsUpdate.Edit;
  
  Showmodal;
end;

procedure TfrmEdit_Data0278.adsUpdateDATA_TYPEGetText(Sender: TField;
  var Text: String; DisplayText: Boolean);
begin
  case Sender.AsInteger of
    1: text := '������';
    2: text := '�ַ���';
  end;
end;

procedure TfrmEdit_Data0278.adsUpdateDATA_TYPESetText(Sender: TField;
  const Text: String);
begin
  if Text = '������' then
    Sender.AsInteger := 1
  else
   if Text = '�ַ���' then
     Sender.AsInteger := 2
    else
      begin
        ShowMsg('��Ч�����ͣ�������ѡ��','��ʾ',1);
        abort;
      end;
end;

procedure TfrmEdit_Data0278.btnSaveClick(Sender: TObject);
begin
  if not Check_Before_Post then abort;
  with frmMain_Data096 do begin
//���ݸ�ֵ
//1����������
    try
      if not adsUpdate.Connection.InTransaction then
        adsUpdate.Connection.BeginTrans;
//2����������
      //adsUpdateCATEGORY_PTR.Value:=RadioGroup1.ItemIndex+2;
      //�����������
      if rbGolb.Checked then adsUpdateCATEGORY_PTR.AsInteger := 2;
      if rbDept.Checked then adsUpdateCATEGORY_PTR.AsInteger := 3;

      if cbxBp.Checked then
      begin
        adsUpdate.FieldByName('BomPriceType').AsInteger := cbxBomPrice.ItemIndex +1;
      end else
      begin
        adsUpdate.FieldByName('BomPriceType').AsInteger := 0;
      end;

      adsUpdate.UpdateBatch(arAll);
//3�������ӱ�
//     (1).�����ֶ�  �����ֶ� Parameter_ptr��ֵ
      if not MyDataClass.UpdateValueToField(adsUpdate_Sub,adsUpdate.fieldByName('rKey').value,'Parameter_ptr') then
        abort;
//    (2).�������ݱ�
      adsUpdate_Sub.UpdateBatch(arAll);
      adsUpdate.Connection.CommitTrans;  //�ύ����
    except
      adsUpdate.Connection.RollbackTrans; //�ع�����
      begin
        ShowMsg('��������ʧ�ܣ�����!','����',1);
        abort;
      end;
    end;
  end;
  close;
end;

procedure TfrmEdit_Data0278.adsUpdatePARAMETER_NAMEValidate(
  Sender: TField);
begin
  if Run_Mode = em_Add then //�����������¼����ô��Ҫ��֤����Ƿ��ظ�
    if not Check_Unique_Value(Sender.AsString) then abort;
end;

function TfrmEdit_Data0278.Check_Before_Post: boolean;
var
  tmpStr:string;
begin
  result := true;
  if trim(Is_NULL(adsUpdate.fieldByName('PARAMETER_NAME').Value,''))='' then
  begin
    result := false;
    ShowMsg('�������������','��ʾ',1);
  end
  else if adsUpdate.fieldByName('DATA_TYPE').IsNull then
  begin
    result := false;
    ShowMsg('��ѡ���������','��ʾ',1);
  end
  else if adsUpdate.fieldByName('UNIT_PTR').IsNull then
  begin
    result := false;
    ShowMsg('��ѡ��λ','��ʾ',1);
  end;
  if not Formula_Verify.Verify_Formula(Dbedit6.Text,tmpstr) then
  begin
    result := false;
    ShowMsg('��ʽ��֤ʧ��: '+trim(tmpstr),'��ʾ',1);
    exit;
  end;
  if adsUpdate.fieldByName('DATA_TYPE').AsInteger=1 then //����
  begin
    if ((DBEdit7.Text='') and (DBEdit8.Text<>'')) or ((DBEdit7.Text<>'') and (DBEdit8.Text='')) or
       (adsUpdate.fieldByName('min_value').AsFloat>adsUpdate.fieldByName('max_value').AsFloat) then
    begin
      result := false;
      ShowMsg('�����������ֵ���Ч��Χ! '+trim(tmpstr),'��ʾ',1);
    end;
  end else begin
    DBEdit7.Text:='';
    DBEdit8.Text:='';
  end;

end;

procedure TfrmEdit_Data0278.adsUpdateUNIT_PTRGetText(Sender: TField;
  var Text: String; DisplayText: Boolean);
begin
  if Sender.IsNull then exit;
    text := Get_Unit_Name(sender.Value);
end;

procedure TfrmEdit_Data0278.spdBtnUnitClick(Sender: TObject);
var
  FDlgInput: PDlgInput;
  Tmp_rslt: variant;
begin
  FDlgInput.Fields:='Unit_code/��λ����,Unit_Name/��λ����';
  FDlgInput.Sqlstr:= 'select rKey,Unit_code,Unit_Name from data0002';
  FDlgInput.AdoConn := frmMain_data096.ADOConnection1;
  Tmp_rslt:= Pick_Single_Item(FDlgInput);
  if not VarIsNull(Tmp_rslt) then
  begin
    adsUpdate.edit;
    adsUpdate.FieldByName('UNIT_PTR').Value :=Tmp_rslt;

  end;
end;

procedure TfrmEdit_Data0278.adsUpdateCATEGORY_PTRGetText(Sender: TField;
  var Text: String; DisplayText: Boolean);
begin
//  if Sender.IsNull then exit;
//  text := Get_Eng_Param_Type(Sender.Value);
end;

procedure TfrmEdit_Data0278.adsUpdate_SubBeforeInsert(DataSet: TDataSet);
begin
  SeqNo:= Get_Max_SeqNo(DataSet,'Sequence_no');
  adsUpdate.Edit;
end;

procedure TfrmEdit_Data0278.adsUpdate_SubNewRecord(DataSet: TDataSet);
begin
  DataSet.FieldByName('Sequence_no').Value:= SeqNo+1;
end;

procedure TfrmEdit_Data0278.adsUpdateNewRecord(DataSet: TDataSet);
begin
  DataSet.FieldByName('STATUS').Value := 0;
  DataSet.FieldByName('status1').Value := 0;
  DataSet.FieldByName('STATUS2').Value := 0;
  DataSet.FieldByName('STATUS3').Value := 0;
  DataSet.FieldByName('STATUS4').Value := 0;
  DataSet.FieldByName('QUOTE_FLAG').Value := 0;
end;

procedure TfrmEdit_Data0278.adsUpdate_SubBeforePost(DataSet: TDataSet);
begin
  if trim(Is_NUll(DataSet.FieldByName('TVALUE').Value,''))='' then
  begin
    ShowMsg('��������ֵ','��ʾ',1);
    abort;
  end;
end;

procedure TfrmEdit_Data0278.PopupMenu1Popup(Sender: TObject);
begin
  N1.Enabled := btnSave.Enabled;
  N2.Enabled := btnSave.Enabled;
end;

procedure TfrmEdit_Data0278.N1Click(Sender: TObject);
begin
  adsUpdate_Sub.Delete;
end;

procedure TfrmEdit_Data0278.N2Click(Sender: TObject);
begin
  adsUpdate_Sub.Append;
end;

procedure TfrmEdit_Data0278.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  frmMain_data096.Tmp_Field_Value:= trim(DBEdit1.Text);
end;

procedure TfrmEdit_Data0278.dbcomboxDataTypeChange(Sender: TObject);
begin
  GroupBox1.Visible:=dbcomboxDataType.ItemIndex=0;
end;

procedure TfrmEdit_Data0278.ehDBGrid_Sub1TitleClick(Column: TColumnEh);
begin
if (Column.Title.SortMarker = smNoneEh) or (Column.Title.SortMarker = smDownEh) then
begin
  TCustomAdoDataSet(Column.Field.DataSet).Sort :=Column.Field.FieldName+' ASC';
  Column.Title.SortMarker := smUpEh;
end
else
if Column.Title.SortMarker = smUpEh then
begin
  TCustomAdoDataSet(Column.Field.DataSet).Sort :=Column.Field.FieldName+' DESC';
  Column.Title.SortMarker := smDownEh;
end ;
end;

procedure TfrmEdit_Data0278.FormShow(Sender: TObject);
begin
  if Run_Mode = em_Browse then
  begin
    grp1.Enabled := False;
    cbxBp.Enabled := False;
    cbxBomPrice.Enabled := False;
  end;
  cbxBp.Visible := vprev = '4';
  cbxBomPrice.Visible := vprev = '4';
end;

procedure TfrmEdit_Data0278.cbxBpClick(Sender: TObject);
begin
  cbxBomPrice.Enabled := cbxBp.Checked;
end;

end.
