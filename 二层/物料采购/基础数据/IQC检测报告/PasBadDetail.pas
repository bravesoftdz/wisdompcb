unit PasBadDetail;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, ComCtrls;

type
  TfrmBadDetail = class(TForm)
    pnl1: TPanel;
    pnl2: TPanel;
    btnSave: TBitBtn;
    btnCancel: TBitBtn;
    lbl1: TLabel;
    edtCode: TEdit;
    btn1: TBitBtn;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    dtpk1: TDateTimePicker;
    lbl6: TLabel;
    edtQuan: TEdit;
    lbl7: TLabel;
    edtBatch: TEdit;
    btn2: TBitBtn;
    lbl8: TLabel;
    mmo1: TMemo;
    lbl9: TLabel;
    mmo2: TMemo;
    lbl10: TLabel;
    edtTracert: TEdit;
    btn3: TBitBtn;
    edtINVT: TEdit;
    btn4: TBitBtn;
    chkReport: TCheckBox;
    chkClose: TCheckBox;
    procedure btn1Click(Sender: TObject);
    procedure btn4Click(Sender: TObject);
    procedure btn3Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtQuanKeyPress(Sender: TObject; var Key: Char);
    procedure btnSaveClick(Sender: TObject);
    procedure edtCodeExit(Sender: TObject);
    procedure edtINVTExit(Sender: TObject);
  private

    procedure Init;
    { Private declarations }
  public
    EditType:Integer;//0������1�༭��2���
    { Public declarations }
  end;

var
  frmBadDetail: TfrmBadDetail;

implementation

uses
  DAMO,Pick_Item_Single,ConstVar,common;

{$R *.dfm}

procedure TfrmBadDetail.btn1Click(Sender: TObject);
var
  InputVar:PDlgInput;
begin
  frmPick_Item_Single:=TfrmPick_Item_Single.Create(nil);
  try
    InputVar.Fields := 'CODE/��Ӧ�̴���/50,ABBR_NAME/��Ӧ�̼�Ƴ�/150,SUPPLIER_NAME/��Ӧ������/250';
    InputVar.Sqlstr := 'select rkey,SUPPLIER_NAME,CODE,ABBR_NAME from data0023 order by code';
    Inputvar.KeyField:='';

    InputVar.AdoConn := dm.ADOConnection1 ;
    frmPick_Item_Single.InitForm_New(InputVar);
    if frmPick_Item_Single.ShowModal=mrok then
    begin
      edtCode.Text:= frmPick_Item_Single.adsPick.fieldbyname('ABBR_NAME').AsString;
      lbl3.Caption:= frmPick_Item_Single.adsPick.fieldbyname('SUPPLIER_NAME').AsString;
      edtCode.Tag:=frmPick_Item_Single.adsPick.fieldbyname('rKey').AsInteger;
    end;
  finally
    frmPick_Item_Single.Free;
  end;
end;

procedure TfrmBadDetail.btn4Click(Sender: TObject);
var
  InputVar:PDlgInput;
begin
  if Trim(edtCode.Text) = '' then
  begin
    ShowMessage('����ѡ��Ӧ��');
    edtCode.SetFocus;
    Exit;
  end;
  frmPick_Item_Single:=TfrmPick_Item_Single.Create(nil);
  try
    InputVar.Fields := 'INV_PART_NUMBER/���ϱ���/80,INV_PART_DESCRIPTION/��������/300';
    InputVar.Sqlstr := 'select data0017.rkey,data0017.INV_PART_NUMBER,data0017.INV_PART_DESCRIPTION '+ #13+
                       ' from data0017 inner join  '+ #13+
                       '       data0028 on data0028.INVENTORY_PTR =  data0017.rkey  '+ #13+
                       ' where data0017.inspect = ''Y'' and Data0028.SUPPLIER_PTR = '+ IntToStr(edtCode.Tag) + #13+
                       ' order by INV_PART_NUMBER';
    Inputvar.KeyField:='';

    InputVar.AdoConn := dm.ADOConnection1 ;
    frmPick_Item_Single.InitForm_New(InputVar);
    if frmPick_Item_Single.ShowModal=mrok then
    begin
      edtINVT.Text:= frmPick_Item_Single.adsPick.fieldbyname('INV_PART_NUMBER').AsString;
      lbl4.Caption:= frmPick_Item_Single.adsPick.fieldbyname('INV_PART_DESCRIPTION').AsString;
      edtINVT.Tag:=frmPick_Item_Single.adsPick.fieldbyname('rKey').AsInteger;
    end;
  finally
    frmPick_Item_Single.Free;
  end;
end;

procedure TfrmBadDetail.btn3Click(Sender: TObject);
var
  InputVar:PDlgInput;
begin
  frmPick_Item_Single:=TfrmPick_Item_Single.Create(nil);
  try
    InputVar.Fields := 'user_login_name/����/180,user_full_name/����/250';
    InputVar.Sqlstr := 'select rkey,user_login_name,user_full_name from data0073 where flag=0 order by user_login_name';
    Inputvar.KeyField:='';

    InputVar.AdoConn := dm.ADOConnection1 ;
    frmPick_Item_Single.InitForm_New(InputVar);
    if frmPick_Item_Single.ShowModal=mrok then
    begin
      edtTracert.Text:= frmPick_Item_Single.adsPick.fieldbyname('user_login_name').AsString;
      edtTracert.Tag:=frmPick_Item_Single.adsPick.fieldbyname('rKey').AsInteger;
    end;
  finally
    frmPick_Item_Single.Free;
  end;
end;

procedure TfrmBadDetail.btn2Click(Sender: TObject);
var
  InputVar:PDlgInput;
begin
  if (edtINVT.Tag = 0) or (edtCode.Tag = 0 ) then
  begin
    ShowMessage('����ѡ��Ӧ�������');
    exit;
  end;
  frmPick_Item_Single:=TfrmPick_Item_Single.Create(nil);
  try
    InputVar.Fields := 'iqc_number/IQC���/180,appl_date/��������/250';
    InputVar.Sqlstr := 'select iqc_number,appl_date from data0391 inner join  '+#13+
                       '     data0071 on data0071.rkey=data0391.rkey71 inner join  '+#13+
                       '     data0070 on data0071.po_ptr=data0070.rkey  '+#13+
                       ' where data0070.SUPPLIER_POINTER= ' + IntToStr(edtCode.Tag) +
                       '   and data0391.rkey17=' + IntToStr(edtINVT.Tag);
    Inputvar.KeyField:='';

    InputVar.AdoConn := dm.ADOConnection1 ;
    frmPick_Item_Single.InitForm_New(InputVar);
    if frmPick_Item_Single.ShowModal=mrok then
    begin
      edtBatch.Text:= frmPick_Item_Single.adsPick.fieldbyname('iqc_number').AsString;
    end;
  finally
    frmPick_Item_Single.Free;
  end;
end;

procedure TfrmBadDetail.FormShow(Sender: TObject);
begin
  if EditType = 0 then
  begin
    dtpk1.Date:=getsystem_date(DM.adoTime,1)
  end;
  Init;
end;

procedure TfrmBadDetail.edtQuanKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key in ['0'..'9',#8,#46]) then
  begin
    if (Key = #46) and (Pos('.',Trim(TEdit(Sender).Text))<>0) then
    Abort;
  end
  else Abort;
end;

procedure TfrmBadDetail.btnSaveClick(Sender: TObject);
var
  status:string;
begin
  if (chkClose.Checked) and (MessageDlg('�رո��ٺ󽫲������޸�,�Ƿ������', mtWarning, [mbYes,mbNo],0) <> mryes)  then
  begin
    exit;
  end;
  if Trim(edtCode.Text)='' then
  begin
    ShowMessage('��Ӧ�̲���Ϊ�գ�');
    edtCode.SetFocus;
    Exit;
  end;
  if Trim(edtINVT.Text)='' then
  begin
    ShowMessage('���ϲ���Ϊ�գ�');
    edtINVT.SetFocus;
    Exit;
  end;
  if Trim(edtQuan.Text)='' then
  begin
    ShowMessage('�������������ʲ���Ϊ�գ�');
    edtQuan.SetFocus;
    Exit;
  end;
  if Trim(edtTracert.Text)='' then
  begin
    ShowMessage('�����˲���Ϊ�գ�');
    edtTracert.SetFocus;
    Exit;
  end;

  with DM.adoTmp do
  begin
    Close;
    SQL.text:= 'SELECT 1 from data0028 where SUPPLIER_PTR=' + IntToStr(edtCode.Tag) +
                ' and INVENTORY_PTR=' + IntToStr(edtINVT.Tag);
    Open;
    if IsEmpty then
    begin
      ShowMessage('��ѡ��Ӧ�������û�ж���۸������Ƿ���ȷ��');
      exit;
    end;
  end;
  status:='0';
  if chkClose.Checked then status:='1';

  if EditType=0 then
  begin
    try
      with DM.adoTmp do
      begin
        Close;
        SQL.Text:='INSERT INTO QC_IQCBadRecord values('+ IntToStr(edtCode.Tag) + ',' + IntToStr(edtINVT.Tag) +
              ',' + QuotedStr(DateToStr(dtpk1.Date)) + ',' + QuotedStr(Trim(edtBatch.Text)) + ',' +
              Trim(edtQuan.Text) + ',' + QuotedStr(Trim(mmo1.Text)) + ',' + QuotedStr(Trim(mmo2.Text)) +
              ',' + QuotedStr(BoolToStr(chkReport.Checked,True)) + ',' + QuotedStr(BoolToStr(chkClose.Checked,True)) +','+ status +',' +
               IntToStr(edtTracert.Tag) + ',getdate())';
//        ShowMessage(SQL.Text);
        ExecSQL;
      end;
      ModalResult:= mrOk;
    except
      ShowMessage('����ʧ�ܣ�');
    end;
  end
  else
  begin
    try
      with DM.adoTmp do
      begin
        Close;
        SQL.Text:='update QC_IQCBadRecord set rkey23='+ IntToStr(edtCode.Tag) + ',rkey17=' + IntToStr(edtINVT.Tag) +
              ',DiscoverDate=' + QuotedStr(DateToStr(dtpk1.Date)) + ',BatchNO=' + QuotedStr(Trim(edtBatch.Text)) + ',BadQuantity=' +
              Trim(edtQuan.Text) + ',BadRemark=' + QuotedStr(Trim(mmo1.Text)) + ',Result=' + QuotedStr(Trim(mmo2.Text)) +
              ',IsReport=' + QuotedStr(BoolToStr(chkReport.Checked,True)) +
              ',IsClose=' + QuotedStr(BoolToStr(chkClose.Checked,True)) +
              ',status=' + status +
              ',TrancertMen=' + IntToStr(edtTracert.Tag) + ',ModiDate=getdate() where rkey=' + DM.adoBadRecordrkey.AsString ;
//        ShowMessage(SQL.Text);
        ExecSQL;
      end;
      ModalResult:= mrOk;
    except
      ShowMessage('����ʧ�ܣ�');
    end;
  end;
end;

procedure TfrmBadDetail.Init;
begin
  if EditType=2 then
  begin
    btnSave.Enabled:= False;
    pnl2.Enabled:=False
  end;
end;

procedure TfrmBadDetail.edtCodeExit(Sender: TObject);
begin
  if Trim(edtCode.Text) <> '' then
  begin
    with DM.adoTmp do
    begin
      Close;
      SQL.Text:= 'select rkey,SUPPLIER_NAME,CODE,ABBR_NAME from data0023 where abbr_name = '
              + QuotedStr(edtCode.Text);
      Open;
      if not IsEmpty then
      begin
        edtCode.Text:= fieldbyname('ABBR_NAME').AsString;
        lbl3.Caption:= fieldbyname('SUPPLIER_NAME').AsString;
        edtCode.Tag:= fieldbyname('rKey').AsInteger;
      end
      else
      begin
        ShowMessage('����Ĺ�Ӧ�̼�Ʋ���ȷ�����������룡��');
        edtCode.SetFocus;
        Exit;
      end;
    end;
  end;
end;

procedure TfrmBadDetail.edtINVTExit(Sender: TObject);
begin
  if Trim(edtCode.Text) = '' then
  begin
    ShowMessage('����ѡ��Ӧ��');
    edtCode.SetFocus;
    Exit;
  end;
end;

end.
