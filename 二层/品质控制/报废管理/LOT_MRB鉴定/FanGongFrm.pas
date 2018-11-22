unit FanGongFrm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, Grids, DBGridEh, StdCtrls, ExtCtrls, ComCtrls;

type
  TfrmFG1 = class(TForm)
    pnl1: TPanel;
    pnl2: TPanel;
    btnOK: TButton;
    pnl3: TPanel;
    pnl4: TPanel;
    btnAddAll: TButton;
    btnDeleOne: TButton;
    btnAddOne: TButton;
    btnDeleAll: TButton;
    dsMISTep: TDataSource;
    qryMIStep: TADOQuery;
    lbl1: TLabel;
    lbl2: TLabel;
    lvRStep: TListView;
    lvMIStep: TListView;
    edtFGBZ: TEdit;
    lblFGBZ: TLabel;
    procedure FormShow(Sender: TObject);
    procedure btnDeleOneClick(Sender: TObject);
    procedure btnAddAllClick(Sender: TObject);
    procedure btnDeleAllClick(Sender: TObject);
    procedure btnAddOneClick(Sender: TObject);
    procedure eh1DblClick(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure edtFGBZKeyPress(Sender: TObject; var Key: Char);
  private
    { Private declarations }
    procedure GetMIPassStepData(ARkey06: string);
    function AddRStep: Boolean;
    function AddRStepToDB(ARkey06: string): Boolean;
  public
    { Public declarations }
  end;

var
  frmFG1: TfrmFG1;

implementation

uses
  DM, WZ_gUnit, HeBingGongDan, gBFUnit;

{$R *.dfm}

{ TfrmFG1 }

procedure TfrmFG1.GetMIPassStepData(ARkey06: string);
var
  LS: TStringList;
  tmpS: string;
  LItem: TListItem;
begin
  LS := TStringList.Create;
  try
    tmpS := 'SELECT D38.STEP_NUMBER, D34.DEPT_CODE,D34.DEPT_NAME,BARCODE_ENTRY_FLAG,D34.RKey AS RKey34 FROM Data0038 D38 '+
            ' INNER JOIN Data0034 D34 ON D38.DEPT_PTR = D34.RKey ' +
            ' INNER JOIN Data0006 D06 ON D06.BOM_PTR = D38.SOURCE_PTR ' +
            ' INNER JOIN Data0056 D56 ON D56.WO_PTR = D06.RKey ' +
            ' WHERE D38.STEP_NUMBER <= D56.STEP AND D06.RKey = ' + ARkey06 +
            ' ORDER BY D38.STEP_NUMBER';
    LS.Add(tmpS);
    if not DM1.SqlOpen(LS,qryMIStep) then
      ShowMessage('ȡ�÷�������ʧ��')
    else
    begin
      qryMIStep.First;
      while not qryMIStep.Eof do
      begin
        LItem := lvMIStep.Items.Add;
        LItem.Caption := qryMIStep.FieldByName('STEP_NUMBER').AsString;
        LItem.SubItems.Add(qryMIStep.fieldByName('Dept_Code').AsString);
        LItem.SubItems.Add(qryMIStep.fieldByName('Dept_Name').AsString);
        if qryMIStep.fieldByName('BARCODE_ENTRY_FLAG').AsString = 'Y' then
          LItem.SubItems.Add('��')
        else
          LItem.SubItems.Add('��');
        LItem.SubItems.Add(qryMIStep.fieldByName('BARCODE_ENTRY_FLAG').AsString);
        LItem.Data := Pointer(qryMIStep.fieldByName('RKey34').AsInteger);
        qryMIStep.Next;
      end;
      lvMIStep.Items[0].Selected := True;
      lvMIStep.Items.Delete(lvMIStep.Items.Count - 1);//ɾ����ǰ�Ĺ���,��ֹѡ��ǰ�Ĺ���
    end;
  finally
    LS.Free;
  end;
end;

procedure TfrmFG1.FormShow(Sender: TObject);
begin
  lvMIStep.Clear;
  GetMIPassStepData(DM1.adsFrmMain.FieldbyName('RKey').AsString);
  lvRStep.Clear;
end;

function TfrmFG1.AddRStep: Boolean;
var
  LItem: TListItem;
  I: Integer;
begin
  Result := False;
  if lvMIStep.Selected <> nil then
  begin
    if lvRStep.Items.Count = 0 then
    begin
      if lvMIStep.Selected.SubItems[2] <> '��' then
      begin
        ShowMessage('������һ�����ܹ�������ǹ�������!');
        Exit;
      end;
    end;

    for I := 0 to lvRStep.Items.Count - 1 do
    begin
      if StrToInt(lvRStep.Items[I].SubItems[2]) > StrToInt(lvMIStep.Selected.Caption) then
      begin
        ShowMessage('����������밴˳��������,�����MI�� ' + lvRStep.Items[lvRStep.Items.count-1].SubItems[2] + ' �����湤��');
        Exit;
      end;
    end;

    LItem := lvRStep.Items.Add;
    LItem.Caption := IntToStr(lvRStep.Items.Count);
    LItem.SubItems.Add(lvMIStep.Selected.SubItems[0]);
    LItem.SubItems.Add(lvMIStep.Selected.SubItems[1]);
    LItem.SubItems.Add(lvMIStep.Selected.Caption);
    LItem.SubItems.Add(lvMIStep.Selected.SubItems[2]);
    LItem.Data := lvMIStep.Selected.Data;
    lvMIStep.DeleteSelected;
    Result := True;
  end;
end;

procedure TfrmFG1.btnDeleOneClick(Sender: TObject);
var
  I: Integer;
  LItem: TListItem;
begin
  if lvRStep.Selected <> nil then
  begin
    for I := 0 to lvMIStep.Items.Count - 1 do
    begin
      if StrToInt(lvMIStep.Items[I].Caption) > StrToInt(lvRStep.Selected.SubItems[2]) then
        Break;
    end;
    LItem := lvMIStep.Items.Insert(I);
    LItem.Caption := lvRStep.Selected.SubItems[2];
    LItem.SubItems.Add(lvRStep.Selected.SubItems[0]);
    LItem.SubItems.Add(lvRStep.Selected.SubItems[1]);
    LItem.SubItems.Add(lvRStep.Selected.SubItems[3]);
    LItem.Data := lvRStep.Selected.Data;
  end;
  lvRStep.DeleteSelected;
  for I := 0 to lvRStep.Items.Count - 1 do
  begin
    lvRStep.Items[I].Caption := IntToStr(I+1);
  end;
end;

procedure TfrmFG1.btnAddAllClick(Sender: TObject);
begin
  while lvMIStep.Items.Count <> 0 do
  begin
    lvMIStep.Items[0].Selected := True;
    if not AddRStep then Break;
  end;
end;

procedure TfrmFG1.btnDeleAllClick(Sender: TObject);
begin
  FormShow(Self);
end;

procedure TfrmFG1.btnAddOneClick(Sender: TObject);
begin
  AddRStep;
end;

procedure TfrmFG1.eh1DblClick(Sender: TObject);
begin
  AddRStep;
end;

function TfrmFG1.AddRStepToDB(ARkey06: string): Boolean;
var
  LS: TStringList;
  I: Integer;
  nEffect: Integer;
  LCutNO_WO: string;
begin
  Result := True;
  LS := TStringList.Create;
  try
    DM1.con1.BeginTrans;
    try
      //������������뵽0238��
      for I := 0 to lvRStep.Items.Count - 1 do
      begin
        LS.Clear;
        //Insert
        LS.Add('INSERT INTO Data0238(WO_PTR,DEPT_PTR,DEF_ROUT_INST,STEP_NUMBER,tooling_rev,TOOL_REMARK, Old_Step_NO)');
        LS.Add(' (');
          //VALUES
          LS.Add(' SELECT ' + ARkey06 + ' AS ARkey06,');
          LS.Add(IntToStr(Integer(lvRStep.Items[I].Data)) + ' AS DEPT_PTR,');
          LS.Add(' D38.DEF_ROUT_INST, ');
          LS.Add(lvRStep.Items[I].Caption + ' , ');
          LS.Add(' D38.tooling_rev,D38.TOOL_REMARK ,');
          LS.Add(lvRStep.Items[I].SubItems[2]);
          //JOIN
          LS.Add(' FROM Data0038 D38 ');
          LS.Add(' INNER JOIN Data0006 D06 ON D06.BOM_PTR = D38.SOURCE_PTR ');
          //Where
          LS.Add(' WHERE D06.Rkey = ' + ARkey06);
          LS.Add(' AND D38.DEPT_PTR = ' + IntToStr(Integer(lvRStep.Items[I].Data)));
          LS.Add(' AND D38.STEP_NUMBER = ' + lvRStep.Items[I].SubItems[2]);
        //insert end
        LS.Add(' )');
        if DM1.SqlExec(LS,DM1.qrytmp,nEffect) and (nEffect > 0) then
        begin

        end else
        begin
          Result := False;
          Break;
        end;
      end;

      //����ǰ����Ĭ�ϼ��뵽���������
      LS.Clear;
      //Insert
      qryMIStep.Last;
      LS.Add('INSERT INTO Data0238(WO_PTR,DEPT_PTR,DEF_ROUT_INST,STEP_NUMBER,tooling_rev,TOOL_REMARK,Old_Step_NO)');
      LS.Add(' (');
        //VALUES
        LS.Add(' SELECT ' + ARkey06 + ' AS ARkey06,');
        LS.Add(qryMIStep.FieldByName('RKey34').AsString + ' AS DEPT_PTR,');
        LS.Add(' D38.DEF_ROUT_INST, ');
        LS.Add(IntToStr(lvRStep.Items.Count + 1) + ' , ');
        LS.Add(' D38.tooling_rev,D38.TOOL_REMARK ,');
        LS.Add(qryMIStep.FieldByName('STEP_NUMBER').AsString);
        //JOIN
        LS.Add( 'FROM Data0038 D38 ');
        LS.Add(' INNER JOIN Data0006 D06 ON D06.BOM_PTR = D38.SOURCE_PTR ');
        //Where
        LS.Add(' WHERE D06.Rkey = ' + ARkey06);
        LS.Add(' AND D38.DEPT_PTR = ' + qryMIStep.FieldByName('RKey34').AsString);
        LS.Add(' AND D38.STEP_NUMBER = ' + qryMIStep.FieldByName('STEP_NUMBER').AsString);
      //insert end
      LS.Add(' )');
      if DM1.SqlExec(LS,DM1.qrytmp,nEffect) and (nEffect > 0) then
      begin

      end else
      begin
        Result := False;
      end;      
      
      //����56���е�ǰ�Ĳ���ͷ���ǰ����
      if Result then
      begin
        LS.Clear;
        LS.Add(' UPDATE Data0056 SET DEPT_PTR = ' + IntToStr(Integer(lvRStep.Items[0].Data)) + ',');
        LS.Add(' STEP = 1' {+ lvRStep.Items[0].SubItems[2]} + ',');
        LS.Add(' WTYPE = ' + DM1.adsFrmMain.FieldByname('NowStep').AsString);
        LS.Add(' WHERE WO_PTR = ' + DM1.adsFrmMain.FieldByName('RKey').AsString);
        if DM1.SqlExec(LS,DM1.qrytmp,nEffect) and (nEffect > 0) then
        begin

        end else
        begin
          Result := False;
        end;
      end;

      //������ڲ���д��ӡ����
      if Result then
      begin
        LS.Clear;
        LS.Add('SELECT PARENT_PTR FROM Data0025 D25 ');
        LS.Add(' INNER JOIN Data0006 D06 ON D06.BOM_PTR = D25.RKey ');
        LS.Add(' WHERE D06.RKey = ' + ARkey06);
        if DM1.SqlOpen(LS,DM1.qrytmp) then
        begin
          if DM1.qrytmp.IsEmpty then
            LCutNO_WO := ''
          else
            LCutNO_WO := ExtractBurnNO(DM1.adsFrmMain.FieldByName('WORK_ORDER_NUMBER').AsString,3);
        end;
      end;
      //����06���е�wtype״̬,��ӡ����
      if Result then
      begin
        LS.Clear;
        LS.Add(' UPDATE Data0006 SET WType = 3 ,Prod_Status = 3');
        if LCutNO_WO <> '' then
          LS.Add(',CUTNO_WO = ' + QuotedStr(LCutNO_WO));
        LS.Add(' WHERE RKey = ' + DM1.adsFrmMain.FieldByName('RKey').AsString);
        if DM1.SqlExec(LS,DM1.qrytmp,nEffect) and (nEffect > 0) then
        begin

        end else
        begin
          Result := False;
        end;
      end;

      //д��־
      if Result then
      begin
        ls.Clear;
        LS.Add('INSERT INTO Data0117 VALUES(');
        LS.Add(ARkey06 + ',2,0,' + gUser.User_Ptr + ',getdate(),13,');
        LS.Add(QuotedStr(edtFGBZ.Text));
        ls.Add(')');
        if DM1.SqlExec(LS,DM1.qrytmp,nEffect) then
        begin
          Result := nEffect >= 1;
        end else
          Result := False;
      end;
      if Result then DM1.con1.CommitTrans;
    finally
      if DM1.con1.InTransaction then DM1.con1.RollbackTrans; 
    end;
    if Result then
      ModalResult := mrOk
    else
      ShowMessage('������������ʧ��');
  finally
    LS.Free;
  end;
end;

procedure TfrmFG1.btnOKClick(Sender: TObject);
begin
  if lvRStep.Items.Count = 0 then
  begin
    ShowMessage('�봴����������');
    Exit;
  end;
  AddRStepToDB(DM1.adsFrmMain.FieldByName('RKey').AsString);
end;

procedure TfrmFG1.edtFGBZKeyPress(Sender: TObject; var Key: Char);
begin
  if Length(edtFGBZ.Text) > 100 then
  begin
    ShowMessage('��ע���ܴ���100����');
    Key := #0;
    Exit;
  end;
end;

end.
