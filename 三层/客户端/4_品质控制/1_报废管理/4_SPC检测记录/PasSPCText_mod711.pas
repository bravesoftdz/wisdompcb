unit PasSPCText_mod711;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uBaseEditFrm,ucommfunc, Vcl.StdCtrls,uBaseSinglePickListFrm,
  Vcl.Buttons, Vcl.ExtCtrls, Vcl.Grids, Datasnap.DBClient, Data.DB, Vcl.ComCtrls;

type
  LgetRefreshClick=procedure (cds:TClientDataSet) of object;
  TfrmSPCText_mod711 = class(TfrmBaseEdit)
    Panel1: TPanel;
    Label1: TLabel;
    Label4: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit1: TEdit;
    BitBtn2: TBitBtn;
    BitBtn1: TBitBtn;
    Label5: TLabel;
    ComboBox1: TComboBox;
    BitBtn3: TBitBtn;
    Panel2: TPanel;
    SGrid1: TStringGrid;
    Label6: TLabel;
    cdsSPCMain: TClientDataSet;
    cdsSPCDetail: TClientDataSet;
    Label7: TLabel;
    dtpReqDate: TDateTimePicker;
    Label8: TLabel;
    DateTimePicker1: TDateTimePicker;
    Label9: TLabel;
    Label10: TLabel;
    Edit4: TEdit;
    ComboBox2: TComboBox;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btnCloseClick(Sender: TObject);
    procedure SGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure SGrid1KeyPress(Sender: TObject; var Key: Char);
  private
    function IfWarehouse: Boolean;
    { Private declarations }
  public
    Lstrwhere:string;
    iType:Integer;//�����༭״̬
    str_list:TStringList;
    refresh:LgetRefreshClick; //ˢ��
    { Public declarations }
    procedure inti;
    procedure GetData(ARkey: string);
    procedure ShowSG(IDKey:string);
  end;

var
  frmSPCText_mod711: TfrmSPCText_mod711;

implementation

{$R *.dfm}

{ TfrmSPCText_mod711 }
function TfrmSPCText_mod711.IfWarehouse: Boolean;//�ж����ݲ�������
var i:Integer;
begin
  Result:=False;
  for I := 1 to SGrid1.RowCount-1 do
  begin
    if (SGrid1.Cells[str_list.IndexOfName('���Խ��'),i]='') then
    begin
      Result:=True;
      Break;
    end;
  end;
//  for i:=1 to SGrid1.RowCount-1 do
//  begin
//    if (strtofloat(SGrid1.Cells[str_list.IndexOfName('���Խ��'),i])>0) then
//      break//������һ���������
//    else
//    if (i=SGrid1.RowCount-1) then Result:=true;
//  end;
end;

procedure TfrmSPCText_mod711.BitBtn1Click(Sender: TObject);
var LFrm: TfrmSinglePickList;
begin
  inherited;
  if (Trim(Edit1.Text)='') then
  begin
    ShowMessage('����ȷ��һ������...');
    Exit;
  end;
  LFrm := TfrmSinglePickList.Create(Self);
  try
    LFrm.InitWithPickID(711,1,' where d34_ptr= '+inttostr(Edit1.Tag)+'');
    if LFrm.ShowModal = mrOk then
    begin
      Edit2.Tag:=LFrm.cdsPick.FieldByName('Rkey').AsInteger;
      Edit2.Text:=LFrm.cdsPick.FieldByName('LineName').AsString;
      BitBtn3.Enabled:=True;
    end;
  finally
    LFrm.Free;
  end;
end;

procedure TfrmSPCText_mod711.BitBtn2Click(Sender: TObject);
var LFrm: TfrmSinglePickList;
begin
  LFrm := TfrmSinglePickList.Create(Self);
  try
    if (Trim(Edit1.Text)<>'') then
      LFrm.InitWithPickID(711,0, ' and DEPT_CODE like ''%'+Trim(Edit1.Text)+'%''')
    else  LFrm.InitWithPickID(711,0);
    if LFrm.ShowModal = mrOk then
    begin
      BitBtn2.Tag:=LFrm.cdsPick.FieldByName('Rkey').AsInteger;
      Edit1.Tag:=LFrm.cdsPick.FieldByName('d34_ptr').AsInteger;
      Edit1.Text:=LFrm.cdsPick.FieldByName('DEPT_CODE').AsString;
      Label3.Caption:=LFrm.cdsPick.FieldByName('DEPT_NAME').AsString;
      BitBtn1.Enabled:=True;
    end;
  finally
    LFrm.Free;
  end;
end;

procedure TfrmSPCText_mod711.BitBtn3Click(Sender: TObject);
var LFrm: TfrmSinglePickList;
begin
  inherited;
  if (Trim(Edit1.Text)='') then
  begin
    ShowMessage('����ȷ��һ������...');
    Exit;
  end;
  if (Trim(Edit2.Text)='') then
  begin
    ShowMessage('����ȷ����������...');
    Exit;
  end;
  LFrm := TfrmSinglePickList.Create(Self);
  try
    LFrm.InitWithPickID(711,2,' where SPC_DevInfo_LineDef.rkey= '+inttostr(Edit2.Tag)+'');
    if LFrm.ShowModal = mrOk then
    begin
      Edit3.Tag:=LFrm.cdsPick.FieldByName('Rkey').AsInteger;
      Edit3.Text:=LFrm.cdsPick.FieldByName('DevName').AsString;
      Label6.Caption:=LFrm.cdsPick.FieldByName('IDKey').AsString;
      inti;
      ShowSG(Label6.Caption);
    end;
  finally
    LFrm.Free;
  end;
end;

procedure TfrmSPCText_mod711.btnCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmSPCText_mod711.btnSaveClick(Sender: TObject);
var i:Integer;
    LPostData,LPostData2: OleVariant;
    dDate:TDateTime;
begin
  inherited;
  if (Trim(Edit1.Text)='') then
  begin
    ShowMessage('����ȷ��һ������...');
    Exit;
  end;
  if (Trim(Edit2.Text)='') then
  begin
    ShowMessage('����ȷ����������...');
    Exit;
  end;
  if (Trim(Edit3.Text)='') then
  begin
    ShowMessage('����ȷ����Ҫ�豸...');
    Exit;
  end;
  if (Trim(SGrid1.Cells[1,1])='') then
  begin
    showmessage('��Ҫ�豸������Ŀû������,��������!');
    exit;
  end;
  if IfWarehouse then
  begin
    showmessage('���Խ���Ǳ�����!');
    exit;
  end;
  dDate:=gFunc.GetSvrDateTime;
  case iType of
    0:  //����
    begin
      cdsSPCMain.Append;
      cdsSPCMain.FieldByName('IDKey').Value:= gFunc.CreateIDKey;
      cdsSPCMain.FieldByName('InPut_D05_Ptr').Value:=gVar.rkey05; //������Ա
      cdsSPCMain.FieldByName('Input_DateTime').Value:=FormatDateTime('yyyy-MM-dd',dDate); //��������
      cdsSPCMain.FieldByName('supplierName').Value:=Trim(Edit4.Text);
      cdsSPCMain.FieldByName('factoryName').Value:=Trim(ComboBox2.Text);
      cdsSPCMain.FieldByName('analysisDate').Value:=FormatDateTime('yyyy-MM-dd',dtpReqDate.Date);
      cdsSPCMain.FieldByName('analysisTime').Value:=FormatDateTime('HH:mm:ss',DateTimePicker1.Time);
      cdsSPCMain.FieldByName('analysisClass').Value:=Trim(ComboBox1.Text);
      cdsSPCMain.FieldByName('bigProcessNode').Value:=Trim(Label3.Caption);
      cdsSPCMain.FieldByName('smallProcessNode').Value:=Trim(Edit2.Text);
      cdsSPCMain.FieldByName('equipmentNode').Value:=Trim(Edit3.Text);
      cdsSPCMain.FieldByName('analyst').Value:=gVar.rkey05; //������Ա
      cdsSPCMain.FieldByName('reviewer').Value:=gVar.rkey05; //�����Ա
      cdsSPCMain.Post;
      for I := 1 to SGrid1.RowCount-1 do
      begin
        cdsSPCDetail.Append;
        cdsSPCDetail.FieldByName('IDKey').Value:= gFunc.CreateIDKey;
        cdsSPCDetail.FieldByName('Parent_IDkey').Value:= cdsSPCMain.FieldByName('IDKey').AsString;
        cdsSPCDetail.FieldByName('testItemName').Value:= SGrid1.Cells[str_list.IndexOfName('������Ŀ'),i];
        cdsSPCDetail.FieldByName('frequency').Value:= SGrid1.Cells[str_list.IndexOfName('����Ƶ��'),i];
        cdsSPCDetail.FieldByName('controlTarget').Value:= StrToFloat(SGrid1.Cells[str_list.IndexOfName('����Ŀ��'),i]);
        cdsSPCDetail.FieldByName('controlLowerLimit').Value:= StrToFloat(SGrid1.Cells[str_list.IndexOfName('��������'),i]);
        cdsSPCDetail.FieldByName('controlUpperLimit').Value:= StrToFloat(SGrid1.Cells[str_list.IndexOfName('��������'),i]);
        cdsSPCDetail.FieldByName('testResult').Value:=StrToFloat(SGrid1.Cells[str_list.IndexOfName('���Խ��'),i]);
        if (Trim(SGrid1.Cells[str_list.IndexOfName('�����'),i])<>'') then
        cdsSPCDetail.FieldByName('additiveContent').Value:= StrToFloat(SGrid1.Cells[str_list.IndexOfName('�����'),i]);
        if (Trim(SGrid1.Cells[str_list.IndexOfName('������'),i])<>'') then
        cdsSPCDetail.FieldByName('reviewResult').Value:=StrToFloat(SGrid1.Cells[str_list.IndexOfName('������'),i]);
        cdsSPCDetail.FieldByName('testUnit').Value:= SGrid1.Cells[str_list.IndexOfName('���Ե�λ'),i];
        cdsSPCDetail.Post;
      end;
      if cdsSPCMain.State in [dsEdit,dsInsert] then cdsSPCMain.Post;
      if cdsSPCDetail.State in [dsEdit,dsInsert] then cdsSPCDetail.Post;

      LPostData := VarArrayCreate([0,1],varVariant);
      LPostData2 := VarArrayCreate([0,1],varVariant);

      if cdsSPCMain.ChangeCount > 0 then
      begin
        LPostData[0] := cdsSPCMain.Delta;
        LPostData2[0]:='SPC_DevInfo_Main';
      end;
      if cdsSPCDetail.ChangeCount > 0 then
      begin
        LPostData[1] := cdsSPCDetail.Delta;
        LPostData2[1]:='SPC_DevInfo_Detail';
      end;
      if gSvrIntf.IntfPostDataBySqlArr(LPostData2,LPostData) then
      begin
        if cdsSPCMain.ChangeCount > 0 then cdsSPCMain.MergeChangeLog;
        if cdsSPCDetail.ChangeCount > 0 then cdsSPCDetail.MergeChangeLog;
        ShowMessage('����ɹ�');
        if Assigned(refresh) then
          refresh(nil);
        Edit1.Text:='';
        Edit2.Text:='';
        Edit3.Text:='';
        inti;
        BitBtn2.SetFocus;
      end;
    end;
    1: //�༭
    begin
      cdsSPCMain.Edit;
      cdsSPCMain.FieldByName('InPut_D05_Ptr').Value:=gVar.rkey05; //������Ա
      cdsSPCMain.FieldByName('Input_DateTime').Value:=FormatDateTime('yyyy-MM-dd',dDate); //��������
      cdsSPCMain.FieldByName('supplierName').Value:=Trim(Edit4.Text);
      cdsSPCMain.FieldByName('factoryName').Value:=Trim(ComboBox2.Text);
      cdsSPCMain.FieldByName('analysisDate').Value:=FormatDateTime('yyyy-MM-dd',dtpReqDate.Date);
      cdsSPCMain.FieldByName('analysisTime').Value:=FormatDateTime('HH:mm:ss',DateTimePicker1.Time);
      cdsSPCMain.FieldByName('analyst').Value:=gVar.rkey05; //������Ա
      cdsSPCMain.FieldByName('reviewer').Value:=gVar.rkey05; //�����Ա
      cdsSPCMain.Post;
      for I := 1 to SGrid1.RowCount-1 do
      begin
        cdsSPCDetail.Edit;
        cdsSPCDetail.FieldByName('testResult').Value:=StrToFloat(SGrid1.Cells[str_list.IndexOfName('���Խ��'),i]);
        if (Trim(SGrid1.Cells[str_list.IndexOfName('�����'),i])<>'') then
        cdsSPCDetail.FieldByName('additiveContent').Value:= StrToFloat(SGrid1.Cells[str_list.IndexOfName('�����'),i]);
        if (Trim(SGrid1.Cells[str_list.IndexOfName('������'),i])<>'') then
        cdsSPCDetail.FieldByName('reviewResult').Value:=StrToFloat(SGrid1.Cells[str_list.IndexOfName('������'),i]);
        cdsSPCDetail.Post;
      end;
      if cdsSPCMain.State in [dsEdit,dsInsert] then cdsSPCMain.Post;
      if cdsSPCDetail.State in [dsEdit,dsInsert] then cdsSPCDetail.Post;

      LPostData := VarArrayCreate([0,1],varVariant);
      LPostData2 := VarArrayCreate([0,1],varVariant);

      if cdsSPCMain.ChangeCount > 0 then
      begin
        LPostData[0] := cdsSPCMain.Delta;
        LPostData2[0]:='SPC_DevInfo_Main';
      end;
      if cdsSPCDetail.ChangeCount > 0 then
      begin
        LPostData[1] := cdsSPCDetail.Delta;
        LPostData2[1]:='SPC_DevInfo_Detail';
      end;
      if gSvrIntf.IntfPostDataBySqlArr(LPostData2,LPostData) then
      begin
        if cdsSPCMain.ChangeCount > 0 then cdsSPCMain.MergeChangeLog;
        if cdsSPCDetail.ChangeCount > 0 then cdsSPCDetail.MergeChangeLog;
        ShowMessage('�༭�ɹ�');
        if Assigned(refresh) then
          refresh(nil);
      end;
    end;
  end;
end;

procedure TfrmSPCText_mod711.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action:=caFree;
  frmSPCText_mod711:=nil;
end;

procedure TfrmSPCText_mod711.GetData(ARkey: string);
var
  LSqlMain,LSqlDetail: string;
begin
  LSqlMain := 'select * from SPC_DevInfo_Main where IDKey = ''' + ARkey+'''';
  LSqlDetail := 'select * from SPC_DevInfo_Detail where Parent_IDkey = ''' + ARkey+'''';
  if not gSvrIntf.IntfGetDataBySqlArr(VarArrayOf([LSqlMain,LSqlDetail]),[cdsSPCMain,cdsSPCDetail]) then Exit;
end;

procedure TfrmSPCText_mod711.inti;
var j,i:integer;
begin
  SGrid1.Update;
  for j :=SGrid1.RowCount-1  downto 1  do
  begin
    for i:=0 to SGrid1.ColCount do
    begin
      SGrid1.Cells[i,j]:='';
    end;
    if (SGrid1.rowcount>2) then SGrid1.rowcount := SGrid1.rowcount - 1;
  end;
  str_list := TStringList.Create;
  str_list.Add('������Ŀ=INV_NAME');
  str_list.Add('����Ƶ��=frequency');
  str_list.Add('����Ŀ��=controlTarget');
  str_list.Add('��������=controlLowerLimit');
  str_list.Add('��������=controlUpperLimit');
  str_list.Add('���Խ��=testResult');
  str_list.Add('�����=additiveContent');
  str_list.Add('������=reviewResult');
  str_list.Add('���Ե�λ=testUnit');
  str_list.Add('Rkey=Rkey');
  SGrid1.ColCount:=str_list.Count;
  for j := 0 to str_list.Count-1  do    //SGrd��ӵ�һ�е��ֶ���
  begin
    SGrid1.Cells[j,0] := str_list.Names[j];
  end;
  SGrid1.Height:=26;
  SGrid1.FixedRows:=1;
  SGrid1.ColWidths[str_list.IndexOfName('������Ŀ')]:=150;
  SGrid1.ColWidths[str_list.IndexOfName('����Ƶ��')]:=80;
  SGrid1.ColWidths[str_list.IndexOfName('����Ŀ��')]:=70;
  SGrid1.ColWidths[str_list.IndexOfName('��������')]:=70;
  SGrid1.ColWidths[str_list.IndexOfName('��������')]:=70;
  SGrid1.ColWidths[str_list.IndexOfName('���Խ��')]:=80;
  SGrid1.ColWidths[str_list.IndexOfName('�����')]:=80;
  SGrid1.ColWidths[str_list.IndexOfName('������')]:=80;
  SGrid1.ColWidths[str_list.IndexOfName('���Ե�λ')]:=60;
  SGrid1.ColWidths[str_list.IndexOfName('Rkey')]:=-1;
end;

procedure TfrmSPCText_mod711.SGrid1KeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if (SGrid1.Col = 5 ) then
  begin
    if not CharInSet(Key,['0'..'9','.',#8,#13]) then  //�ж��Ƿ��������ֺ�С����
      abort
    else
    if key = chr(46) then
    begin      //�ж��Ƿ��ظ�����С����'.'
      if pos('.',SGrid1.Cells[5,SGrid1.Row])>0  then abort;
    end;
  end;
  if (SGrid1.Col = 6 ) then
  begin
    if not CharInSet(Key,['0'..'9','.',#8,#13]) then  //�ж��Ƿ��������ֺ�С����
      abort
    else
    if key = chr(46) then
    begin      //�ж��Ƿ��ظ�����С����'.'
      if pos('.',SGrid1.Cells[6,SGrid1.Row])>0  then abort;
    end;
  end;
  if (SGrid1.Col = 7 ) then
  begin
    if not CharInSet(Key,['0'..'9','.',#8,#13]) then  //�ж��Ƿ��������ֺ�С����
      abort
    else
    if key = chr(46) then
    begin      //�ж��Ƿ��ظ�����С����'.'
      if pos('.',SGrid1.Cells[7,SGrid1.Row])>0  then abort;
    end;
  end;
end;

procedure TfrmSPCText_mod711.SGrid1SelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  inherited;
  if (ACol<=4) or (ACol=8) then CanSelect:=false;
  if (ACol>4) and (ARow<>SGrid1.RowCount-1) then CanSelect:=True;
end;

procedure TfrmSPCText_mod711.ShowSG(IDKey: string);
var strSQL:string;
    Lcds:TClientDataSet;
    iRow:Integer;
begin
  strSQL:='select DDCD.*,DTPD.TestParamName from dbo.SPC_Devinfo_DevTestClassDef as DDCD '
  +'inner join SPC_Devinfo_TestParamDef as DTPD on DDCD.Param_Ptr=DTPD.rkey where ParentIDKey='''+IDKey+'''';
  Lcds:=TClientDataSet.Create(Self);
  try
    gSvrintf.IntfGetDataBySql(strSQL,Lcds);
    SGrid1.RowCount:=SGrid1.RowCount+Lcds.RecordCount;
    if not Lcds.IsEmpty then
    begin
      iRow:=1;
      Lcds.First;
      while not Lcds.Eof do
      begin
        SGrid1.Cells[str_list.IndexOfName('������Ŀ'),iRow]:=Lcds.FieldByName('TestParamName').AsString;
        SGrid1.Cells[str_list.IndexOfName('����Ƶ��'),iRow]:=Lcds.FieldByName('frequency').AsString;
        SGrid1.Cells[str_list.IndexOfName('����Ŀ��'),iRow]:=Lcds.FieldByName('controlTarget').AsString;
        SGrid1.Cells[str_list.IndexOfName('��������'),iRow]:=Lcds.FieldByName('controlLowerLimit').AsString;
        SGrid1.Cells[str_list.IndexOfName('��������'),iRow]:=Lcds.FieldByName('controlUpperLimit').AsString;
        SGrid1.Cells[str_list.IndexOfName('���Ե�λ'),iRow]:=Lcds.FieldByName('testUnit').AsString;
        iRow:=iRow+1;
        Lcds.Next;
      end;
      SGrid1.RowCount:=SGrid1.RowCount-1;
      SGrid1.SetFocus;
    end else
    begin

    end;
  finally
    Lcds.Free;
  end;

end;

end.
