unit EditFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, Grids, DBGridEh, Mask, DBCtrls, DB,
  ADODB, DM, Menus;

type
  TfrmEdit = class(TForm)
    pnl1: TPanel;
    btnSave: TBitBtn;
    btnCancel: TBitBtn;
    pnl2: TPanel;
    pnl3: TPanel;
    pnl4: TPanel;
    eh1: TDBGridEh;
    lbl1: TLabel;
    dbedtListNumber: TDBEdit;
    lbl2: TLabel;
    dbedtVersion: TDBEdit;
    lbl3: TLabel;
    lbl4: TLabel;
    lbl5: TLabel;
    lbl6: TLabel;
    dbedtmanu_part_number3: TDBEdit;
    lbl7: TLabel;
    lbl8: TLabel;
    dbedtmanu_part_number5: TDBEdit;
    lbl9: TLabel;
    dbedtRemark: TDBEdit;
    qry800: TADOQuery;
    btn1: TBitBtn;
    btn2: TBitBtn;
    ds800: TDataSource;
    ds801: TDataSource;
    edtManuPartNumber: TEdit;
    edtHarLinkPeop: TEdit;
    edtCreateUser: TEdit;
    edtAuitUser: TEdit;
    pm1: TPopupMenu;
    mniadd1: TMenuItem;
    mniAdd2: TMenuItem;
    mniN3: TMenuItem;
    mniDele: TMenuItem;
    mniEdit: TMenuItem;
    ads801: TADODataSet;
    ads801RKEY: TAutoIncField;
    ads801RKEY800: TIntegerField;
    ads801Type: TWordField;
    ads801RKEY17: TIntegerField;
    ads801Qty: TIntegerField;
    ads801Param: TStringField;
    ads801Position: TStringField;
    ads801Remark: TStringField;
    ads801FAILURE_RATE: TBCDField;
    ads801VENDOR: TWideStringField;
    ads801MainPtr: TIntegerField;
    ads801INV_PART_NUMBER: TStringField;
    ads801INV_DESCRIPTION: TStringField;
    ads801INV_NAME: TStringField;
    ads801ListNumber: TIntegerField;
    procedure btn1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure edtManuPartNumberExit(Sender: TObject);
    procedure pm1Popup(Sender: TObject);
    procedure mniadd1Click(Sender: TObject);
    procedure mniAdd2Click(Sender: TObject);
    procedure mniEditClick(Sender: TObject);
    procedure mniDeleClick(Sender: TObject);
    procedure ads801CalcFields(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
    function GetData(RKey: Integer): Boolean;
    function SaveCheck: Boolean;
  end;

var
  frmEdit: TfrmEdit;

implementation

uses
  Pick_Item_Single,ConstVar;

{$R *.dfm}

{ TfrmEdit }

function TfrmEdit.GetData(RKey: Integer): Boolean;
begin
  Application.HintPause := 1;
  qry800.Close;
  qry800.Parameters[0].Value := RKey;
  qry800.Open;
  ads801.Close;
  ads801.Parameters[0].Value := RKey;
  ads801.Open;
  //ads801.Sort := 'ListNumber';
//  eh1.Columns[0]

  Result := True;
end;

procedure TfrmEdit.btn1Click(Sender: TObject);
var
  LFrm: TfrmPick_Item_Single;
  LInPut: PDlgInput;
begin
//  edtBCBH.SetFocus;
  LFrm := TfrmPick_Item_Single.Create(Self);
  LInPut.AdoConn := dm1.con1;
  try
    LInPut.KeyField := 'MANU_PART_NUMBER';

    LInPut.Fields:= 'MANU_PART_NUMBER/�������/100,MANU_PART_DESC/�ͻ��ͺ�/180,'+
                       'ANALYSIS_CODE_2/�ͻ����Ϻ�/180';

    LInPut.Sqlstr := ' SELECT d25.rkey as rkey25,D25.MANU_PART_NUMBER, D25.ANALYSIS_CODE_2, D25.MANU_PART_DESC from data0025 d25 ' +
                     ' where d25.parent_ptr is null or d25.parent_ptr = 0';

    if edtManuPartNumber.Text <> '' then
      LInPut.Sqlstr := LInPut.Sqlstr + ' and manu_part_number like ' + QuotedStr('%'+edtManuPartNumber.Text+'%');
    LFrm.InitForm_New(LInPut);
    if LFrm.ShowModal = mrOK then
    begin
      edtManuPartNumber.Text := LFrm.adsPick1.fieldbyname('MANU_PART_NUMBER').AsString;
      edtManuPartNumber.Tag := LFrm.adsPick1.fieldbyname('rkey25').AsInteger;
      edtManuPartNumberExit(edtManuPartNumber);
    end;
  finally
    LFrm.Free;
  end;
end;

procedure TfrmEdit.btn2Click(Sender: TObject);
var
  LFrm: TfrmPick_Item_Single;
  LInPut: PDlgInput;
begin
  LFrm := TfrmPick_Item_Single.Create(Self);
  LInPut.AdoConn := dm1.con1;
  try
    LInPut.Fields:= 'EMPL_CODE/��Ա����/200,EMPLOYEE_NAME/��Ա����/280';
    LInPut.Sqlstr := ' SELECT rkey,EMPL_CODE,EMPLOYEE_NAME FROM data0005';
    LFrm.InitForm_New(LInPut);
    if LFrm.ShowModal = mrOK then
    begin
      edtHarLinkPeop.Text := LFrm.adsPick1.fieldbyname('EMPLOYEE_NAME').AsString;
      edtHarLinkPeop.Tag := LFrm.adsPick1.fieldbyname('rkey').AsInteger;
    end;
  finally
    LFrm.Free;
  end;

end;

procedure TfrmEdit.btnSaveClick(Sender: TObject);
var
  bExist: Boolean;
  lrkey81: Integer;
  lInvName,lListNum: string;

  bIsEdit: Boolean;
begin
  bIsEdit := qry800.FieldByName('Rkey').AsInteger <> 0;
  bExist := False;
  if SaveCheck then
  begin
    if not bIsEdit then
    begin
    dm1.qrytmp.Close;
    dm1.qrytmp.SQL.Text := 'select 1 from data0800 where active = 1 and rkey25=' + IntToStr(edtManuPartNumber.Tag);
    dm1.qrytmp.Open;
    if not dm1.qrytmp.IsEmpty then
    begin
      if MessageBox(Handle,'��ͬ�ͺ�ֻ�ܴ���һ����Ч��¼����������Ὣ������������������Ч','��ʾ',MB_YESNO) = IDYes then
      begin
        bExist := True;
      end else
      begin
        Exit;
      end;
    end;
    end;
    qry800.Edit;
    qry800.FieldByName('rkey25').AsInteger := edtManuPartNumber.Tag;
    if edtHarLinkPeop.Tag = 0 then
    begin
      qry800.FieldByName('HardwareLinkman_PTR').Value := null;
    end else
      qry800.FieldByName('HardwareLinkman_PTR').Value := edtHarLinkPeop.Tag;
    qry800.FieldByName('CreateBy_PTR').Value := edtCreateUser.Tag;
    qry800.Post;




    dm1.con1.BeginTrans;
    try
      try
        //��ʷ�汾����Ϊ��Ч
        if not bIsEdit then
        begin
        dm1.qrytmp.Close;
        dm1.qrytmp.SQL.Text := 'update data0800 set active = 0 where rkey25='+ IntToStr(edtManuPartNumber.Tag);
        dm1.qrytmp.ExecSQL;
        end;

        qry800.UpdateBatch();

        //801
        ads801.DisableControls;
        ads801.First;
        while not ads801.Eof do
        begin
          ads801.Edit;
          ads801.FieldByName('RKEY800').AsInteger := qry800.fieldbyname('rkey').AsInteger;
          ads801.FieldByName('ListNumber').AsString := IntToStr(ads801.RecNo);
          ads801.Post;
          ads801.Next;
        end;
        ads801.UpdateBatch();

        //801 mainptr
        ads801.DisableControls;
        ads801.First;
        while not ads801.Eof do
        begin
          if ads801.FieldByName('type').AsInteger = 0 then
          begin
            lrkey81 := ads801.fieldbyname('rkey').AsInteger;
            lInvName := ads801.fieldbyname('INV_NAME').AsString;
            lListNum := ads801.fieldbyname('ListNumber').AsString;
          end else
          begin
            //if ads801.fieldbyname('INV_NAME').AsString = lInvName then
            begin
              ads801.Edit;
              ads801.FieldByName('MainPtr').AsInteger := lrkey81;
              ads801.Post;
            end;
          end;

          ads801.Next;
        end;
        ads801.EnableControls;
        ads801.UpdateBatch();
        
        DM1.con1.CommitTrans;
        ModalResult := mrOk;
      except
        on E: Exception do
        begin
          dm1.con1.RollbackTrans;
          ShowMessage('����ʧ�ܣ� ' + e.Message);
        end;
      end;
    finally
      if dm1.con1.InTransaction then
        dm1.con1.RollbackTrans;
    end;
  end;
end;

procedure TfrmEdit.btnCancelClick(Sender: TObject);
begin
  ModalResult := mrCancel;
end;

procedure TfrmEdit.edtManuPartNumberExit(Sender: TObject);
begin
  dm1.qrytmp.Close;
  dm1.qrytmp.SQL.Text := 'select rkey from data0025 where manu_part_number=' + QuotedStr(edtManuPartNumber.Text);
  dm1.qrytmp.Open;
  if dm1.qrytmp.IsEmpty then
  begin
    edtManuPartNumber.Hint := '���������Ч';
    edtManuPartNumber.ShowHint := True;
    edtManuPartNumber.Color := clRed;
    edtManuPartNumber.Tag := 0;
  end else
  begin
    edtManuPartNumber.Tag := dm1.qrytmp.fieldbyname('rkey').AsInteger;
    edtManuPartNumber.Color := clWindow;
    edtManuPartNumber.ShowHint := False;
  end;
end;

function TfrmEdit.SaveCheck: Boolean;
begin
  Result := False;
  if edtManuPartNumber.ShowHint = True then
  begin
    ShowMessage(edtManuPartNumber.Hint);
    Exit;
  end;
  if qry800.FieldByName('ListNumber').AsString = '' then
  begin
    ShowMessage('���嵥��ű�����д');
    Exit;
  end;
  if qry800.FieldByName('Version').AsString = '' then
  begin
    ShowMessage('�汾������д');
    Exit;
  end;

  ads801.DisableControls;
  try
    ads801.First;
    while not ads801.Eof do
    begin
      if ads801.FieldByName('qty').AsInteger = 0 then
      begin
        ShowMessage(ads801.fieldbyname('INV_DESCRIPTION').AsString + ' ��������Ϊ 0');
        exit;
      end;
      ads801.Next;
    end;
  finally
    ads801.EnableControls;
  end;
  
  Result := True;
end;

procedure TfrmEdit.pm1Popup(Sender: TObject);
begin
  mniAdd2.Enabled := ads801.FieldByName('type').AsInteger = 0;
  mniAdd2.Enabled := not ads801.IsEmpty;
  mniEdit.Enabled := not ads801.IsEmpty;
  mniDele.Enabled := not ads801.IsEmpty;
end;

procedure TfrmEdit.mniadd1Click(Sender: TObject);
var
  LFrm: TfrmPick_Item_Single;
  LInPut: PDlgInput;

  LNo: Integer;
begin
  LFrm := TfrmPick_Item_Single.Create(Self);
  LInPut.AdoConn := dm1.con1;
  try
    LInPut.Fields:= 'INV_PART_NUMBER/���ϱ���/150,INV_DESCRIPTION/���Ϲ��/150,INV_NAME/��������/100,FAILURE_RATE/ʧ����/150';
    LInPut.Sqlstr := ' SELECT data0017.rkey as rkey17,Data0017.INV_PART_NUMBER,Data0017.INV_DESCRIPTION,Data0017.INV_NAME,Data0017.FAILURE_RATE FROM Data0017 ' +
                      ' INNER JOIN Data0496 on Data0017.GROUP_PTR = Data0496.RKEY  order by INV_NAME';   //WHERE Data0496.GROUP_NAME = ''NA''
    LFrm.InitForm_New(LInPut);
    if LFrm.ShowModal = mrOK then
    begin
      if ads801.Locate('rkey17',LFrm.adsPick1.fieldbyname('rkey17').AsString,[loCaseInsensitive]) then
      begin
        ShowMessage('�Ѿ���ӹ���ǰ����');
        Exit;
      end;
      LNo := ads801.RecordCount;
      ads801.Append;
      ads801.FieldByName('ListNumber').AsInteger := LNo+1;
      ads801.FieldByName('type').AsInteger := 0;
      ads801.FieldByName('RKEY17').AsInteger := LFrm.adsPick1.fieldbyname('rkey17').AsInteger;
      ads801.FieldByName('FAILURE_RATE').AsString := LFrm.adsPick1.fieldbyname('FAILURE_RATE').AsString;
      ads801.FieldByName('qty').AsInteger := 0;
      ads801.Post;

    end;
  finally
    LFrm.Free;
  end;

end;

procedure TfrmEdit.mniAdd2Click(Sender: TObject);
var
  LFrm: TfrmPick_Item_Single;
  LInPut: PDlgInput;
  ltmpQty: Integer;

  LstNo: Integer;
begin
  ltmpQty := ads801.fieldbyname('qty').AsInteger;
  LFrm := TfrmPick_Item_Single.Create(Self);

  LInPut.AdoConn := dm1.con1;
  try
    LInPut.Fields:= 'INV_PART_NUMBER/���ϱ���/150,INV_DESCRIPTION/���Ϲ��/150,INV_NAME/��������/100,FAILURE_RATE/ʧ����/150';
    LInPut.Sqlstr := ' SELECT data0017.rkey as rkey17,Data0017.INV_PART_NUMBER,Data0017.INV_DESCRIPTION,Data0017.INV_NAME,Data0017.FAILURE_RATE FROM Data0017 ' +
' INNER JOIN Data0496 on Data0017.GROUP_PTR = Data0496.RKEY WHERE Data0017.INV_NAME = '+QuotedStr(ads801.fieldbyname('INV_NAME').AsString);
    LFrm.InitForm_New(LInPut);
    if LFrm.ShowModal = mrOK then
    begin
      if ads801.Locate('rkey17',LFrm.adsPick1.fieldbyname('rkey17').AsString,[loCaseInsensitive]) then
      begin
        ShowMessage('�Ѿ���ӹ���ǰ����');
        Exit;
      end;
      //

      LstNo := ads801.fieldbyname('ListNumber').AsInteger;
      ads801.DisableControls;
      ads801.IndexFieldNames := '';
      ads801.First;
      try
        while not ads801.Eof do
        begin
          if ads801.FieldByName('ListNumber').AsInteger > LstNo then
          begin
            ads801.Edit;
            ads801.FieldByName('ListNumber').AsInteger := ads801.FieldByName('ListNumber').AsInteger + 1;
            ads801.Post;
          end;
          ads801.Next;
        end;
      finally
        ads801.IndexFieldNames := 'ListNumber';
        ads801.EnableControls;
      end;


      ads801.Append;
      ads801.FieldByName('ListNumber').AsInteger := LstNo + 1;
      ads801.FieldByName('type').AsInteger := 1;
      ads801.FieldByName('RKEY17').AsInteger := LFrm.adsPick1.fieldbyname('rkey17').AsInteger;
      ads801.FieldByName('FAILURE_RATE').AsString := LFrm.adsPick1.fieldbyname('FAILURE_RATE').AsString;
      ads801.FieldByName('qty').AsInteger := ltmpqty;
      ads801.Post;
      ads801.Locate('RKEY17',LFrm.adsPick1.fieldbyname('rkey17').AsInteger,[loCaseInsensitive]);
    end;
  finally
    LFrm.Free;
  end;

end;

procedure TfrmEdit.mniEditClick(Sender: TObject);
var
  LFrm: TfrmPick_Item_Single;
  LInPut: PDlgInput;
begin
  LFrm := TfrmPick_Item_Single.Create(Self);
  LInPut.AdoConn := dm1.con1;
  try
    LInPut.Fields:= 'INV_PART_NUMBER/���ϱ���/150,INV_DESCRIPTION/���Ϲ��/150,INV_NAME/��������/100,FAILURE_RATE/ʧ����/150';
    LInPut.Sqlstr := ' SELECT data0017.rkey as rkey17,Data0017.INV_PART_NUMBER,Data0017.INV_DESCRIPTION,Data0017.INV_NAME,Data0017.FAILURE_RATE FROM Data0017 ' +
' INNER JOIN Data0496 on Data0017.GROUP_PTR = Data0496.RKEY WHERE Data0017.INV_NAME = '+QuotedStr(ads801.fieldbyname('INV_NAME').AsString) + ' order by INV_NAME';
    LFrm.InitForm_New(LInPut);
    if LFrm.ShowModal = mrOK then
    begin
      if ads801.Locate('rkey17',LFrm.adsPick1.fieldbyname('rkey17').AsString,[loCaseInsensitive]) then
      begin
        ShowMessage('�Ѿ���ӹ���ǰ����');
        Exit;
      end;
      ads801.Edit;
//      ads801.FieldByName('type').AsInteger := 1;
      ads801.FieldByName('RKEY17').AsInteger := LFrm.adsPick1.fieldbyname('rkey17').AsInteger;
      ads801.FieldByName('FAILURE_RATE').AsString := LFrm.adsPick1.fieldbyname('FAILURE_RATE').AsString;
      ads801.Post;      
    end;
  finally
    LFrm.Free;
  end;

end;

procedure TfrmEdit.mniDeleClick(Sender: TObject);
begin
  if ads801.FieldByName('type').AsInteger = 1 then
  begin
  if MessageBox(Handle,'�Ƿ�ɾ��','��ʾ',MB_YESNO) = IDYes then
  begin
    ads801.Delete;
  end;
  end else
  begin
  if MessageBox(Handle,'��ɾ����ǰ���Ϻ�������','��ʾ',MB_YESNO) = IDYes then
  begin
    if ads801.RecNo = ads801.RecordCount then
    begin
      ads801.Delete;
    end else
    begin
      ads801.Delete;
    while ads801.FieldByName('type').AsInteger = 1 do
    begin
      ads801.Delete;
    end;
    end;

  end;
  end;
end;

procedure TfrmEdit.ads801CalcFields(DataSet: TDataSet);
var
  Lqry: TADOQuery;
begin
  Lqry := TADOQuery.Create(Self);
  try
    Lqry.Connection := dm1.con1;
    Lqry.SQL.Text := 'select * from data0017 where rkey = ' + IntToStr(DataSet.fieldbyname('rkey17').asinteger);
    Lqry.Open;
    if Lqry.IsEmpty then exit;
    DataSet.FieldByName('INV_PART_NUMBER').AsString := Lqry.fieldbyname('INV_PART_NUMBER').AsString;
    DataSet.FieldByName('INV_DESCRIPTION').AsString := Lqry.fieldbyname('INV_DESCRIPTION').AsString;
    DataSet.FieldByName('INV_NAME').AsString := Lqry.fieldbyname('INV_NAME').AsString;

  finally
    Lqry.Free;
  end
end;

end.
