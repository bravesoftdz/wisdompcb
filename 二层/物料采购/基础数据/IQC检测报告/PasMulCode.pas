unit PasMulCode;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, Grids;

type
  TfrmMulCode = class(TForm)
    pnl2: TPanel;
    lbl1: TLabel;
    lbl2: TLabel;
    lbl3: TLabel;
    lbl5: TLabel;
    lbl7: TLabel;
    lbl8: TLabel;
    lbl9: TLabel;
    edtCode: TEdit;
    edtName: TEdit;
    edtQuan: TEdit;
    edtMidQuan: TEdit;
    edtCodeQuan: TEdit;
    pnl1: TPanel;
    btnSave: TBitBtn;
    btnCancel: TBitBtn;
    sg1: TStringGrid;
    btnAdd: TBitBtn;
    Label1: TLabel;
    edt1: TEdit;
    lbl4: TLabel;
    edtcreate: TEdit;
    lbl6: TLabel;
    lbl10: TLabel;
    Edit1: TEdit;
    Label2: TLabel;
    edtbatch: TEdit;
    procedure btnAddClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtMidQuanKeyPress(Sender: TObject; var Key: Char);
    procedure edtMidQuanExit(Sender: TObject);
    procedure edt1Exit(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure edtcreateChange(Sender: TObject);
    procedure edtcreateExit(Sender: TObject);
  private
    { Private declarations }
    effday:integer ;
  public
    { Public declarations }
  end;

var
  frmMulCode: TfrmMulCode;

implementation

uses DAMO,DateUtils;

{$R *.dfm}

procedure TfrmMulCode.btnAddClick(Sender: TObject);
begin
  if Trim(edtCodeQuan.Text) = '' then
  begin
    ShowMessage('�����������������ɱ�ǩ');
    exit;
  end;
  if StrToCurr(Trim(edtQuan.Text)) < StrToCurr(Trim(edtMidQuan.Text))  then
  begin
    ShowMessage('��ʽ��������������������������');
    edtMidQuan.SetFocus;
    Exit;
  end;
  sg1.Cells[0,sg1.RowCount-1]:= Trim(edtMidQuan.Text);
  sg1.Cells[1,sg1.RowCount-1]:= Trim(edt1.Text);
  sg1.Cells[2,sg1.RowCount-1]:= Trim(edtCodeQuan.Text);
  sg1.Cells[3,sg1.RowCount-1]:= Trim(edtcreate.Text);
  sg1.Cells[4,sg1.RowCount-1]:= Trim(edit1.Text);
  edtQuan.Text:= CurrToStr(StrToCurr(Trim(edtQuan.Text)) - StrToCurr(Trim(edtMidQuan.Text)));
  sg1.RowCount:= sg1.RowCount + 1;
  edtMidQuan.Text:= '';
  edt1.Text:= '';
  edtCodeQuan.Text:= '';
end;

procedure TfrmMulCode.FormShow(Sender: TObject);
begin
  sg1.Cells[0,0]:= '��ʽ����';
  sg1.Cells[1,0]:= 'ÿ��װ����';
  sg1.Cells[2,0]:= '��ǩ����';
  sg1.Cells[3,0]:= '��������';
  sg1.Cells[4,0]:= '��Ч��';
  with DM.adoTmp do
  begin
    Close;
    SQL.Text:= 'select CASE DATA0028.qte_price2 WHEN 0 THEN DATA0017.SHELF_LIFE ELSE DATA0028.qte_price2 END AS eff_Date '
            + #13+ 'from data0017 '+#13+
            ' inner join data0028 on data0017.rkey = data0028.INVENTORY_PTR  '+#13+
            'where data0028.SUPPLIER_PTR = '+ DM.adoMainSUPPLIER_POINTER.AsString +
            ' and data0017.rkey = '+ DM.adoMainrkey17.AsString;

    Open;
    if not IsEmpty then
    begin
      effday:= FieldByName('eff_Date').AsInteger;

    end;
  end;
end;

procedure TfrmMulCode.edtMidQuanKeyPress(Sender: TObject; var Key: Char);
begin
  if (Key in ['0'..'9',#8,#46]) then
  begin
    if (Key = #46) and (Pos('.',Trim(TEdit(Sender).Text))<>0) then
    Abort;
  end;
end;

procedure TfrmMulCode.edtMidQuanExit(Sender: TObject);
var
  tmp1,tmp2: Double;
  tmp:Currency;
  i:Integer;
begin
  if Trim(edtMidQuan.Text) = '' then exit;
  if not TryStrToCurr(Trim(edtMidQuan.Text),tmp) then
  begin
    ShowMessage('���ݸ�ʽ���ԣ�����������');
    edtMidQuan.SetFocus;
    exit;
  end;
  if Trim(edtMidQuan.Text) =  '0' then
  begin
    ShowMessage('��ʽ�������������0');
    edtMidQuan.SetFocus;
    exit;
  end;
end;

procedure TfrmMulCode.edt1Exit(Sender: TObject);
var
  tmp1,tmp2: Double;
  tmp:Currency;
  i:Integer;
begin
  if Trim(edtMidQuan.Text) ='' then
  begin
    ShowMessage('�˸�ʽ����������Ϊ��');
    edtMidQuan.SetFocus;
    exit;
  end;
  if Trim(edt1.Text) = '' then exit;
  if not TryStrToCurr(Trim(edt1.Text),tmp) then
  begin
    ShowMessage('���ݸ�ʽ���ԣ�����������');
    edt1.SetFocus;
    exit;
  end;
  if Trim(edt1.Text) =  '0' then
  begin
    ShowMessage('ÿ��װ�����������0');
    edt1.SetFocus;
    exit;
  end;
  i:= 1;
  tmp1:= StrToCurr(Trim(edtMidQuan.Text));
  tmp2:= StrToCurr(Trim(edt1.Text));
  while tmp1 - tmp2 > 0 do
  begin
    tmp1:= tmp1 - tmp2;
    i:= i+1;
  end;
  edtCodeQuan.Text:= IntToStr(i);
end;

procedure TfrmMulCode.btnSaveClick(Sender: TObject);
var
  i,j:Integer;
begin
//  if StrToCurr(Trim(edtQuan.Text)) <> 0 then
//  begin
//    ShowMessage('����δ��������');
//    exit;
//  end;
  DM.ADOConnection1.BeginTrans;
  try
    with DM.adoTmp do
    begin
      Close;
      SQL.Text:= 'SELECT * from data0396 where 1=0';
      Open;
      for j:=1 to sg1.rowcount -2 do
        for i:=1 to StrToInt(sg1.Cells[2,j]) do
        begin
          Append;
          FieldByName('rkey391').Value:= DM.adoMainrkey.Value;
//          if i = StrToInt(sg1.Cells[2,j]) then FieldByName('quantity').Value:= StrToCurr(sg1.Cells[0,j]) - StrToCurr(sg1.Cells[1,j])*(i-1)
//          else
          FieldByName('quantity').Value:= StrToCurr(sg1.Cells[1,j]);
          FieldByName('quan_on_hang').Value:= FieldByName('quantity').Value;
          FieldByName('batchno').Value:= Trim(edtbatch.Text);
//          FieldByName('manufacture_TDATE').Value:= StrToDate(Trim(edtcreate.Text));
          if  Trim(sg1.Cells[3,j]) <> '' then FieldByName('manufacture_TDATE').Value:= StrToDate(Trim(sg1.Cells[3,j]));
          if  Trim(sg1.Cells[4,j]) <> '' then FieldByName('extrl_date').Value:= StrToDate(Trim(sg1.Cells[4,j]));
          Post;
        end;
    end;
    DM.ADOConnection1.CommitTrans;
    ShowMessage('���ɳɹ���');
    ModalResult:= mrOk;
  except
    DM.ADOConnection1.RollbackTrans;
    ShowMessage('����ʧ�ܣ���');
  end;
end;

procedure TfrmMulCode.edtcreateChange(Sender: TObject);
var
  tmp:TDateTime;
begin
  if (Trim(edtcreate.Text)<>'') and (TryStrToDate(Trim(edtcreate.Text),tmp)=True) then
  begin
    if effday = 0 then Edit1.Text:= ''
    else Edit1.Text:=DateTimeToStr(IncDay(strtodatetime(Trim(edtcreate.Text)),effday - 1));
  end;
end;

procedure TfrmMulCode.edtcreateExit(Sender: TObject);
var
  temp:TDateTime;
begin
  if (Trim((Sender as TEdit).Text)<>'') and (TryStrToDate(Trim((Sender as TEdit).Text),temp)=False) then
  begin
    ShowMessage('��������ڸ�ʽ���ԣ�Ӧ���磺2015-11-11');
    (Sender as TEdit).SetFocus;
    Exit;
  end;
end;

end.
