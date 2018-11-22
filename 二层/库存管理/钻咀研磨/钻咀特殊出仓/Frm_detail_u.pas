unit Frm_detail_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Spin, DBCtrls, StdCtrls, Mask, Grids, DBGrids, Buttons, ExtCtrls,
  ComCtrls, DBGridEh, Menus, DB, ADODB,DateUtils;

type
  TFrm_detail = class(TForm)
    Panel1: TPanel;
    BitBtn9: TBitBtn;
    PopupMenu1: TPopupMenu;
    N5: TMenuItem;
    Panel2: TPanel;
    SGrid: TStringGrid;
    N2: TMenuItem;
    Label1: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    Edit1: TEdit;
    DateTimePicker1: TDateTimePicker;
    Edit6: TEdit;
    Label10: TLabel;
    BtnSave: TBitBtn;
    CMBCurr: TComboBox;
    Label11: TLabel;
    SpeedButton1: TSpeedButton;
    Edit5: TComboBox;
    Label2: TLabel;
    edtReason: TEdit;
    procedure BitBtn9Click(Sender: TObject);
    procedure BtnSaveClick(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure CMBCurrChange(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SGridKeyPress(Sender: TObject; var Key: Char);
    procedure SGridKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SGridMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Edit5Change(Sender: TObject);
  private

  public
    Ftag:integer;
    FGrd:TDBGridEh;
    procedure initd;
  end;

implementation
  uses DM_u,common,Pick_Item_Single,ConstVar,Frm_detailEdt_u,Frm_Out_u;

{$R *.dfm}

procedure TFrm_detail.initd;
var i,j:integer;
strOther:string;//2012.11.28�޸�������ֵı�עΪ�������
iLift,iRight:Integer;
begin
  SGrid.ColCount:=9;
  SGrid.RowCount:=2;
  for i:=0 to 5 do
  begin
    SGrid.Cells[i,0]:=FGrd.Columns[i].Title.Caption;
    SGrid.ColWidths[i]:=FGrd.Columns[i].Width;
  end;
  SGrid.Cells[5,0]:='��Ч���';
  SGrid.Cells[6,0]:='������';

  SGrid.Cells[7,0]:='��ע';
  SGrid.Cells[8,0]:='rkey220';
  SGrid.ColWidths[8]:=-1;

  if Ftag=0 then
  begin
    self.Caption:='�����������-����';
    Edit1.Text := dm.Get_Data0004(0) ;
    DM.tmp.Close;
    DM.tmp.SQL.Text:='select getdate()';
    DM.tmp.Open;
    DateTimePicker1.DateTime:=DM.tmp.Fields[0].AsDateTime;

    DM.ADO221_1.Close;
    DM.ADO221_1.Parameters[0].Value:=-1;
    DM.ADO221_1.Open;
    DM.ADO222_1.Close;
    DM.ADO222_1.Parameters[0].Value:=-1;
    DM.ADO222_1.Open;
  end else begin
    if Ftag=1 then
    begin
      self.Caption:='�����������-�޸�';
    end else begin
      self.Caption:='�����������-�鿴';
      BtnSave.Enabled:=false;
    end;

    SpeedButton1.Enabled:=false;
    CMBCurr.Enabled:=false;
    DM.ADO221_1.Close;
    DM.ADO221_1.Parameters[0].Value:=DM.ADO221rkey.Value;
    DM.ADO221_1.Open;

    DM.ADO222_1.Close;
    DM.ADO222_1.Parameters[0].Value:=DM.ADO221rkey.Value;
    DM.ADO222_1.Open;
    Edit1.Text:=DM.ADO221_1.FieldByName('NUMBER').AsString;
    DateTimePicker1.DateTime:=DM.ADO221_1.FieldValues['sys_date'];
    Edit6.Text:=DM.ADO221_1.Fieldbyname('quantity').AsString;
//2012.11.28�޸�������ֵı�עΪ�������----------------------------------
    iLift:=Pos('[',Trim(DM.ADO221_1.Fieldbyname('reference').AsString));
    iRight:=Pos(']',Trim(DM.ADO221_1.Fieldbyname('reference').AsString));
    if (iLift=0) then
    begin
      Edit5.Text:=Trim(DM.ADO221_1.Fieldbyname('reference').AsString);
    end else
    begin
      Label2.Visible:=True;
      edtReason.Visible:=True;
      Edit5.Text:='����';
      edtReason.Text:=Copy(Trim(DM.ADO221_1.Fieldbyname('reference').AsString),iLift+1,iRight-iLift-1);
    end;
//------------------------------------------------------------------------

    CMBCurr.Tag:=DM.ADO221type.AsInteger;
    if CMBCurr.Tag=1 then CMBCurr.ItemIndex:=0 else
    if CMBCurr.Tag=2 then CMBCurr.ItemIndex:=1 else
    if CMBCurr.Tag=3 then CMBCurr.ItemIndex:=2 else
    if CMBCurr.Tag=5 then CMBCurr.ItemIndex:=3 ;
    j:=1;
    DM.ADO222.First;
    while not DM.ADO222.Eof do
    begin
      for i:=0 to 4 do
         SGrid.Cells[i,j]:=FGrd.Columns[i].Field.AsString;

      SGrid.Cells[5,j]:=DM.ADO222.fieldbyname('quan_on_hand').AsString; //'��Ч���';
      SGrid.Cells[6,j]:=DM.ADO222.fieldbyname('quantity').AsString; //'������';
      SGrid.Cells[7,j]:=DM.ADO222.fieldbyname('reference').AsString; //'��ע';
      SGrid.Cells[8,j]:=DM.ADO222.fieldbyname('bach_PTR').AsString; //'rkey220';

      SGrid.RowCount:=SGrid.RowCount+1;
      inc(j);
      DM.ADO222.Next;
    end;
  end;
end;

procedure TFrm_detail.BtnSaveClick(Sender: TObject);
var i:integer;
    strOther:string;
    tmpAdo:TADOQuery;
begin
  if SGrid.RowCount=2 then
  begin
    showmessage('���ܱ���ռ�¼...');
    exit;
  end;
  if edit1.Text='' then
  begin
    showmessage('���ֵ��Ų���Ϊ��...');
    exit;
  end;
  //2012.11.28�޸�������ֵı�עΪ�������
  if (edtReason.Visible=True) then
  begin
    if (Trim(edtReason.Text)='') then
    begin
      showmessage('��������ԭ����Ϊ��...');
      exit;
    end else
      strOther:=Edit5.Text+'['+edtReason.Text+']';
  end else strOther:=Edit5.Text;

  tmpAdo:=TADOQuery.Create(Application);
  tmpAdo.Connection:=dm.ADOCon;
  try
    tmpAdo.Close;
    tmpAdo.SQL.Clear;
    tmpAdo.SQL.Add('select * from dbo.data0223 where dBeginDate>=:DM1 and dEndDate<=:DM2 and iStatus=1');
    tmpAdo.Parameters.ParamByName('DM1').Value:=FormatDateTime('yyyy-mm-dd',StartOfTheMonth(DateTimePicker1.Date));
    tmpAdo.Parameters.ParamByName('DM2').Value:=FormatDateTime('yyyy-mm-dd',EndOfTheMonth(DateTimePicker1.Date));
    tmpAdo.Open;
    if not tmpAdo.Eof then
    begin
      ShowMsg('���µ���ĩƽ�������ˣ����ɲ�����',1);
      Exit;
    end;
  finally
    tmpAdo.Close;
    tmpAdo.Connection:=nil;
    tmpAdo.Free;
  end;

  if Ftag=0 then   //add
  begin
    Edit1.Text := dm.Get_Data0004(1,Edit1.Text) ; 
    DM.ADO221_1.Append;
    DM.ADO221_1.FieldByName('NUMBER').AsString:=Edit1.Text;
    DM.ADO221_1.FieldByName('EMPL_PTR').AsString:=user_ptr;
    DM.ADO221_1.FieldByName('sys_DATE').AsDateTime:=DateTimePicker1.DateTime;
    DM.ADO221_1.FieldByName('status').AsInteger:=0;
    DM.ADO221_1.FieldByName('QUANTITY').AsString:=Edit6.Text;
    DM.ADO221_1.FieldByName('Reference').AsString:=strOther;
    DM.ADO221_1.FieldByName('type').AsInteger:=CMBCurr.Tag;
    DM.ADO221_1.Post;

    DM.ADOCon.BeginTrans;
    try
      DM.ADO221_1.UpdateBatch(arAll);
      for i:=1 to SGrid.RowCount-2 do
        if DM.ADO222_1.Locate('bach_PTR',strtoint(sGrid.Cells[8,i]),[]) then
        begin
          DM.ADO222_1.Edit;
          DM.ADO222_1.FieldByName('head_PTR').AsInteger:=DM.ADO221_1.FieldByName('rkey').AsInteger;
          DM.ADO222_1.FieldByName('quantity').AsString:=SGrid.Cells[6,i];
          DM.ADO222_1.FieldByName('reference').AsString:=SGrid.Cells[7,i];
          DM.ADO222_1.Post;
        end else begin
          DM.ADOCon.RollbackTrans;
          showmessage('����...');
          abort;
        end;
      DM.ADO222_1.UpdateBatch(arAll);
      DM.tmp.Close;
      DM.tmp.SQL.Text:='update data0220 set quan_alloc=quan_alloc+d222.quantity from '+
                       'data0220 d220 inner join data0222 d222 on d220.rkey=d222.bach_PTR '+
                       'where d222.head_PTR='+DM.ADO221_1.FieldByName('rkey').AsString+
                       ' and d220.quan_on_hand>=d220.quan_alloc+d222.quantity';
      if DM.tmp.ExecSQL<>DM.ADO222_1.RecordCount then
      begin
        DM.ADOCon.RollbackTrans;
        showmessage('��������ʱ,��ǰ���ÿ�治��,����ʧ��...');
        exit;
      end;
      DM.ADOCon.CommitTrans;
      Frkey221:=DM.ADO221_1.FieldByName('rkey').asinteger;
      modalresult:=mrok;      
    except
      DM.ADOCon.RollbackTrans;
      showmessage('��������ʧ��...');
    end;
  end else begin  //edit
    DM.ADO221_1.Edit;
    DM.ADO221_1.FieldByName('EMPL_PTR').AsString:=user_ptr;
    DM.ADO221_1.FieldByName('sys_DATE').AsDateTime:=DateTimePicker1.DateTime;
    DM.ADO221_1.FieldByName('status').AsInteger:=0;
    DM.ADO221_1.FieldByName('QUANTITY').AsString:=Edit6.Text;
    DM.ADO221_1.FieldByName('Reference').AsString:=strOther;
    DM.ADO221_1.FieldByName('type').AsInteger:=CMBCurr.Tag;
    DM.ADO221_1.Post;

    for i:=1 to SGrid.RowCount-2 do
      if DM.ADO222_1.Locate('bach_PTR',strtoint(sGrid.Cells[8,i]),[]) then
      begin
          DM.ADO222_1.Edit;
          DM.ADO222_1.FieldByName('head_PTR').AsInteger:=DM.ADO221_1.FieldByName('rkey').AsInteger;
          DM.ADO222_1.FieldByName('quantity').AsString:=SGrid.Cells[6,i];
          DM.ADO222_1.FieldByName('reference').AsString:=SGrid.Cells[7,i];
          DM.ADO222_1.Post;
      end else begin
        DM.ADOCon.RollbackTrans;
        showmessage('����...');
        abort;
      end;

    DM.ADOCon.BeginTrans;
    try
      DM.ADO222.First;
      while not DM.ADO222.Eof do
      begin
        DM.tmp.Close;
        DM.tmp.SQL.Text:='update data0220 set quan_alloc=quan_alloc-'+DM.ADO222.fieldbyname('quantity').AsString+
                         ' where rkey='+DM.ADO222.FieldByName('bach_ptr').AsString+
                         ' and quan_alloc>='+DM.ADO222.fieldbyname('quantity').AsString ;//ԭ�������˲�
        if DM.tmp.ExecSQL=0 then
        begin
          DM.ADOCon.RollbackTrans;
          showmessage('��������ʱ,��ǰ����״̬�����ı�,����ʧ��...');
          exit;
        end;
        DM.ADO222.Next;
      end;

      DM.ADO221_1.UpdateBatch(arAll);
      DM.ADO222_1.UpdateBatch(arAll);
      DM.tmp.Close;
      DM.tmp.SQL.Text:='update data0220 set quan_alloc=quan_alloc+d222.quantity from '+
                       'data0220 d220 inner join data0222 d222 on d220.rkey=d222.bach_PTR '+
                       'where d222.head_PTR='+DM.ADO221_1.FieldByName('rkey').AsString+
                       ' and d220.Quan_on_hand>=d220.quan_alloc+d222.quantity';
      if DM.tmp.ExecSQL<>DM.ADO222_1.RecordCount then
      begin
        DM.ADOCon.RollbackTrans;
        showmessage('��������ʱ,��ǰ���ÿ�治��,����ʧ��...');
        exit;
      end;
      DM.ADOCon.CommitTrans;
      Frkey221:=DM.ADO221_1.FieldByName('rkey').asinteger;
      modalresult:=mrok;
    except
    //  on exeption 
      DM.ADOCon.RollbackTrans;
      showmessage('��������ʧ��...');
    end;

  end;
end;

procedure TFrm_detail.N5Click(Sender: TObject);
var  Qty_sum,i:integer;

begin
  TFrm_detailEdt.InitEdt(CMBCurr.Tag,sGrid);
  Qty_sum:=0;
  for i:=1 to SGrid.RowCount-2 do
    Qty_sum:=Qty_sum+strtoint(SGrid.Cells[6,i]);

  Edit6.Text:=inttostr(Qty_sum);
  CMBCurr.Enabled:=(Ftag=0) and (SGrid.RowCount=2);
  SpeedButton1.Enabled:=CMBCurr.Enabled;
end;

procedure TFrm_detail.N2Click(Sender: TObject);
var j,iSum:integer;
 i:byte;
begin
  if sgrid.RowCount <= 2 then exit;
  if DM.ADO222_1.Locate('bach_PTR',strtoint(sGrid.Cells[8,sgrid.Row]),[]) then
  begin
    DM.ADO222_1.Delete;
    Edit6.Text:=inttostr(strtoint(Edit6.Text)-strtoint(SGrid.Cells[6,sgrid.Row]));

    for i:=sgrid.Row to sgrid.RowCount-2 do sgrid.Rows[i].Text:=sgrid.Rows[i+1].Text;
    sgrid.RowCount:=sgrid.RowCount-1;

    CMBCurr.Enabled:=(Ftag=0) and (DM.ADO222_1.RecordCount=0);
    SpeedButton1.Enabled:=CMBCurr.Enabled;

  iSum:=0;
  for j:=1 to SGrid.RowCount-2 do
  begin
    iSum:=iSum+StrToInt(SGrid.Cells[6,j]);
  end;
  SGrid.Cells[5,SGrid.RowCount-1]:='�ϼ�';
  SGrid.Cells[6,SGrid.RowCount-1]:=IntToStr(iSum);

  end;
end;


procedure TFrm_detail.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key=vk_return then
    self.SelectNext(self.ActiveControl,true,true);
end;

procedure TFrm_detail.BitBtn9Click(Sender: TObject);
begin
  close;
end;

procedure TFrm_detail.PopupMenu1Popup(Sender: TObject);
begin
  if Ftag=2 then abort;
  N2.Enabled:=not ((SGrid.Row=0) or (SGrid.Row=SGrid.RowCount-1));
//  N1.Enabled:=N2.Enabled;
end;

procedure TFrm_detail.CMBCurrChange(Sender: TObject);
begin
  if CMBCurr.ItemIndex=0 then  CMBCurr.Tag:=1 else
  if CMBCurr.ItemIndex=1 then  CMBCurr.Tag:=2 else
  if CMBCurr.ItemIndex=2 then  CMBCurr.Tag:=3 else
  if CMBCurr.ItemIndex=3 then  CMBCurr.Tag:=5 ;
end;

procedure TFrm_detail.SpeedButton1Click(Sender: TObject);
var i,j,iSum:integer;
begin
  if CMBCurr.ItemIndex=-1 then
  begin
    showmessage('��ѡ�����Դ...');
    exit;
  end;
  DM.tmp.Close;
  DM.tmp.SQL.Text:='SELECT dbo.DATA0220.rkey rkey220,dbo.DATA0220.quan_on_hand-data0220.quan_alloc quantity, dbo.DATA0220.remark reference, dbo.DATA0220.INVENTORY_PTR,'+
                   'dbo.DATA0220.SUPPLIER_PTR, dbo.DATA0220.LOCATION_PTR, dbo.DATA0220.OH_degree, dbo.DATA0220.QUAN_ALLOC,'+
                   'dbo.DATA0160.LOCATION_CODE, dbo.DATA0160.LOCATION_NAME, dbo.DATA0160.TYPE, dbo.Data0017.INV_PART_NUMBER,'+
                   'dbo.Data0017.INV_PART_DESCRIPTION '+
                   'FROM dbo.DATA0220 INNER JOIN '+
                   'dbo.Data0017 ON dbo.DATA0220.INVENTORY_PTR = dbo.Data0017.RKEY INNER JOIN '+
                   'dbo.DATA0160 ON dbo.DATA0220.LOCATION_PTR = dbo.DATA0160.RKEY '+
                   'where data0160.type='+inttostr(CMBCurr.Tag)+' and dbo.DATA0220.quan_on_hand-data0220.quan_alloc>0';
  DM.tmp.Open;
  if DM.tmp.IsEmpty then
    showmessage('��ǰ����Դû�пɳ��ֵļ�¼...')
  else begin
    j:=1;
    iSum:=0;
    while not DM.tmp.Eof do
    begin
      for i:=0 to 5 do
         SGrid.Cells[i,j]:=DM.tmp.fieldbyname(FGrd.Columns[i].Field.FullName).asstring;
      SGrid.Cells[6,j]:=DM.tmp.fieldbyname('quantity').asstring;
      SGrid.Cells[7,j]:=DM.tmp.fieldbyname('reference').AsString;
      SGrid.Cells[8,j]:=DM.tmp.fieldbyname('rkey220').AsString;
      SGrid.RowCount:=SGrid.RowCount+1;
      
      iSum:=iSum+DM.tmp.fieldbyname('quantity').AsInteger;
      DM.ADO222_1.Append;
      DM.ADO222_1.FieldByName('bach_ptr').AsInteger:=DM.tmp.fieldbyname('rkey220').AsInteger;
      DM.ADO222_1.FieldByName('quantity').AsInteger:=DM.tmp.fieldbyname('quantity').AsInteger;
      DM.ADO222_1.FieldByName('reference').AsString:=DM.tmp.fieldbyname('reference').AsString;
      DM.ADO222_1.Post;
      inc(j);
      DM.tmp.Next;
    end;
    Edit6.Text:=inttostr(iSum);
    SpeedButton1.Enabled:=false;
    CMBCurr.Enabled:=false;
  end;

end;

procedure TFrm_detail.SGridKeyPress(Sender: TObject; var Key: Char);
begin
  if ((SGrid.Col<>6) and (SGrid.Col<>7)) or (SGrid.RowCount<=2) or (SGrid.Row>=SGrid.RowCount-1) then abort;
  if (SGrid.col=6) and (not (key in ['0'..'9',#8])) then abort;
end;

procedure TFrm_detail.SGridKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var sum:integer;
    i:byte;
begin
  if (SGrid.Row<=SGrid.RowCount-2) and (SGrid.Cells[6,SGrid.row]='') then SGrid.Cells[6,SGrid.row]:='0';
  if (SGrid.Row<=SGrid.RowCount-2) and (strtoint(SGrid.Cells[6,SGrid.row])>strtoint(SGrid.Cells[5,SGrid.row])) then
  SGrid.Cells[6,SGrid.row]:=SGrid.Cells[5,SGrid.row];
  sum:=0;
  for i:=1 to SGrid.RowCount-2 do sum:=sum+strtoint('0'+SGrid.Cells[6,i]);
  Edit6.Text:=inttostr(sum);
end;

procedure TFrm_detail.SGridMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
 column,row:longint;//�Ҽ�ѡ��stringgrid�ؼ��ķ���
begin
if button=mbright then
 begin
  SGrid.MouseToCell(x,y,column,row);
  if row<>0 then SGrid.Row:=row;
 end;

end;

procedure TFrm_detail.Edit5Change(Sender: TObject);
begin
  if (Trim(Edit5.Text)='����') then
  begin
    Label2.Visible:=True;
    edtReason.Visible:=True;
  end else
  begin
    Label2.Visible:=False;
    edtReason.Visible:=False;
  end;
end;

end.
