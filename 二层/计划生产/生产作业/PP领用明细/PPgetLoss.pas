unit PPgetLoss;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, ExtCtrls, Mask, DBCtrls, StdCtrls, Grids, DBGridEh,
  ComCtrls, Buttons, jpeg;

type
  TfrmgetLoss = class(TForm)
    Panel2: TPanel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    btnExit: TBitBtn;
    btnQuery: TBitBtn;
    edtBarCode: TEdit;
    Edit1: TEdit;
    DateTimePicker1: TDateTimePicker;
    BitBtn7: TBitBtn;
    DBGridEh1: TDBGridEh;
    Panel1: TPanel;
    Splitter2: TSplitter;
    Splitter3: TSplitter;
    Panel3: TPanel;
    DBMemo1: TDBMemo;
    Panel7: TPanel;
    Panel4: TPanel;
    Panel9: TPanel;
    Panel10: TPanel;
    Label4: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    DBEdit7: TDBEdit;
    DBEdit8: TDBEdit;
    DBEdit9: TDBEdit;
    DBEdit10: TDBEdit;
    DBEdit11: TDBEdit;
    DBEdit12: TDBEdit;
    Panel5: TPanel;
    imgCY: TImage;
    Panel8: TPanel;
    Splitter1: TSplitter;
    DataSource1: TDataSource;
    Label6: TLabel;
    Edit2: TEdit;
    procedure btnExitClick(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure edtBarCodeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtBarCodeChange(Sender: TObject);
    procedure edtBarCodeKeyPress(Sender: TObject; var Key: Char);
    procedure DBGridEh1CellClick(Column: TColumnEh);
    procedure Edit2KeyPress(Sender: TObject; var Key: Char);
    procedure btnQueryClick(Sender: TObject);
  private
    { Private declarations }
    iYNber:Integer;//�Ƿ���ڵ���
    strSQLTxt:string;
    iSelStart,iSelLen,iSumLen:Integer;
    startTime,startTime2,startTime3,startTime4,startTime5,startTime6,endTime:LONGLONG;
  public
    { Public declarations }
  end;

var
  frmgetLoss: TfrmgetLoss;

implementation
uses PasDM,common,myclass,Pick_Item_Single,ConstVar;

{$R *.dfm}

procedure TfrmgetLoss.btnExitClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmgetLoss.BitBtn7Click(Sender: TObject);
var InputVar: PDlgInput ;
begin
  frmPick_Item_Single:=TfrmPick_Item_Single.Create(nil);
  try
    InputVar.Fields := 'EMPL_CODE/Ա������/150,EMPLOYEE_NAME/����/200';
    InputVar.Sqlstr :='select rkey,EMPL_CODE,EMPLOYEE_NAME '+
                      'from data0005 where ACTIVE_FLAG=''Y'' order by rkey';
    inputvar.KeyField:='rkey';
    InputVar.AdoConn:=dm.ADOConnection1;
    frmPick_Item_Single.InitForm_New(InputVar);
    if frmPick_Item_Single.ShowModal=mrok then
    begin
      Edit1.Text:=trim(frmPick_Item_Single.adsPick.FieldValues['EMPLOYEE_NAME']);
      Edit1.Tag:=frmPick_Item_Single.adsPick.FieldValues['rkey'];
      edtBarCode.SetFocus;
    end;
  finally
    frmPick_Item_Single.Free ;
  end;
end;

procedure TfrmgetLoss.FormShow(Sender: TObject);
begin
  iYNber:=0;
  iSelStart:=0;iSelLen:=0;iSumLen:=0;
  startTime:=0;startTime2:=0;startTime3:=0;startTime4:=0;startTime5:=0;startTime6:=0;endTime:=0;
  BitBtn7.SetFocus;
  DateTimePicker1.Date:=getsystem_date(DM.tmp,1);
  strSQLTxt:=DM.Ado732.SQL.Text;
    edtBarCode.Text:='';
    dm.cds732hao.Close;
    DM.cds732hao.Params.ParamByName('NUMBER').Value:='aaaaaaaa';
    dm.cds732hao.Open;
end;

procedure TfrmgetLoss.edtBarCodeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
//  if ((ssCtrl in Shift) and (chr(Key) in ['C', 'c'])) then Key:=0;
//  if ((ssCtrl in Shift) and (chr(Key) in ['V', 'v'])) then
//  begin
//    ShowMessage('����CTRL+V!');
//    edtBarCode.Text:='';
//    edtBarCode.SetFocus;
//  end;
end;

procedure TfrmgetLoss.edtBarCodeChange(Sender: TObject);
begin
  iSelStart:=edtBarCode.SelStart;
  iSelLen:=Length(edtBarCode.Text);
  if (iSelLen=1) then startTime:=GetTickCount;
  if (iSelLen=2) then startTime2:=GetTickCount;
  if (iSelLen=3) then startTime3:=GetTickCount;
  if (iSelLen=4) then startTime4:=GetTickCount;
end;

procedure TfrmgetLoss.edtBarCodeKeyPress(Sender: TObject; var Key: Char);
var
  LCYImg: TjpegImage;
begin
  if (Key=#13) then
  begin
//    endTime:=GetTickCount;
//    if (((startTime2-startTime)<>(startTime4-startTime3)) and ((endTime-startTime)>5000)) then
//    begin
//      ShowMsg('�����ֹ�������ҵ����',1);
//      edtBarCode.Text:='';
//      Exit;
//    end;
    dm.cds732hao.Close;
    DM.cds732hao.Params.ParamByName('NUMBER').Value:= Trim(edtBarCode.Text);
    dm.cds732hao.Open;
//--������ñ�������������֮��------------------
    if (dm.cds732haomatrece_flag.Value=null) or (dm.cds732haomatrece_flag.Value='δ����') then
    begin
      ShowMsg('��ҵ����û�����������ϣ����Ƚ����������ã�',1);
      edtBarCode.SetFocus;
      Exit;
    end;
//-end������ñ�������������֮��------------------
    if not VarIsNull(DM.cds732hao.FieldByName('layers_image').Value) then
    begin
      LCYImg := Load_JPG_Pic_From_DB(DM.cds732hao.FieldByName('layers_image'));
      imgCY.Picture.Bitmap.Assign(LCYImg);
      imgCY.Stretch:=False;
      LCYImg.Free;
    end else imgCY.Picture:=nil;
    if DM.cds732hao.Locate('WORK_ORDER_NUMBER',edtBarCode.Text,[loCaseInsensitive]) then
    begin
      iYNber:=1;
      Edit2.Tag:=DM.cds732haopanel_qty_e.Value-dm.cds732haopick_material_qty_e.Value;
//      ShowMessage(IntToStr(Edit2.Tag));
      Edit2.Text:=IntToStr(DM.cds732haopanel_qty_e.Value-dm.cds732haopick_material_qty_e.Value);
      DBGridEh1.Columns[0].ReadOnly:=False;
      DBGridEh1.datasource.dataset.fields[0].readonly:=false;
      DBGridEh1.SetFocus;
      if not (DM.cds732hao.State in [dsEdit]) then
        DM.cds732hao.Edit;
      DM.cds732hao.FieldByName('IsSelected').AsInteger:= 1;
      btnQuery.SetFocus;
    end
    else
    begin
      iYNber:=0;
      edtBarCode.SelectAll;
    end;
  end;
end;

procedure TfrmgetLoss.DBGridEh1CellClick(Column: TColumnEh);
var
  LCYImg: TjpegImage;
begin
  with Column.Field.DataSet do
  if active then
  begin
    if not VarIsNull(DM.cds732.FieldByName('layers_image').Value) then
    begin
      LCYImg := Load_JPG_Pic_From_DB(DM.cds732.FieldByName('layers_image'));
      imgCY.Picture.Bitmap.Assign(LCYImg);
      LCYImg.Free;
    end;
  end;
end;

procedure TfrmgetLoss.Edit2KeyPress(Sender: TObject; var Key: Char);
begin
  if not (key in ['0'..'9','.',#8,'.']) then  //�ж��Ƿ���������
  abort
  else
  if (pos('.',Edit2.Text)>0)  then     //�ж��Ƿ��ظ�����С����'.'
  if key = chr(46)  then abort;
end;

procedure TfrmgetLoss.btnQueryClick(Sender: TObject);
var iNum,iResult:Integer;
    tmpAdo:TADOQuery;
begin
  if (Trim(Edit1.Text)='') then
  begin
    ShowMsg('��ѡ�������ˣ�',1);
    edtBarCode.SetFocus;
    Exit;
  end;
  if (Trim(Edit2.Text)='') then
  begin
    ShowMsg('��ȷ��PP�������������',1);
    edtBarCode.SetFocus;
    Exit;
  end;
  if dm.cds732hao.RecordCount<=0 then
  begin
    ShowMsg('û�����ü�¼�����ѯ��',1);
    edtBarCode.SetFocus;
    Exit;
  end;
//����֮ǰ��������������ܴ���Ĭ������ֵ
  if (StrToInt(edit2.Text)>Edit2.Tag) then
  begin
    ShowMsg('PP����������������������������������ȷ������������',1);
    edtBarCode.SetFocus;
    Exit;
  end;
  if (Edit2.Tag=0) then
  begin
    ShowMsg('PP���Ĭ����������Ϊ0����������ɨ����ҵ�����룡',1);
    edtBarCode.SetFocus;
    Exit;
  end;
  if (edit2.Text='0') then
  begin
    ShowMsg('PP���������������ȷ��������ȷ������������',1);
    edtBarCode.SetFocus;
    Exit;
  end;
// end���
  if dm.cds732hao.RecordCount>0 then
  begin
    iNum:=0;
    try
      DM.cds732hao.DisableControls;
      DM.cds732hao.First;
      while not dm.cds732hao.Eof do
      begin
        if (dm.cds732hao.FieldByName('IsSelected').AsInteger=1) then iNum:=iNum+1;
        dm.cds732hao.Next;
      end;
      if (iNum>=2) then
      begin
        ShowMsg('һ��ֻ������һ����ҵ����PP����ֻ��ѡһ�м��ɣ�',1);
        Exit;
      end;
    finally
      DM.cds732hao.EnableControls;
    end;
    try
   //����734------------
      iResult:=0;
      tmpAdo:=TADOQuery.Create(Application);
      tmpAdo.Connection:=dm.ADOConnection1;
      tmpAdo.Close;
      tmpAdo.SQL.Clear;
      tmpAdo.SQL.Text:='insert into dbo.data0734 (rkey732,rkey733,user_ptr,create_ptr,create_date,ttype,pick_mater_qty) '
      +'values (:rkey732,:rkey733,:user_ptr,:create_ptr,:create_date,:ttype,:pick_mater_qty)';
      tmpAdo.Parameters.ParamByName('rkey732').Value:=DM.cds732haorkey732.AsInteger;
      tmpAdo.Parameters.ParamByName('rkey733').Value:=DM.cds732haoRkey733.AsInteger;
      tmpAdo.Parameters.ParamByName('user_ptr').Value:=Edit1.Tag;
      tmpAdo.Parameters.ParamByName('create_ptr').Value:=user_ptr;
      tmpAdo.Parameters.ParamByName('create_date').Value:=getsystem_date(DM.tmp,0);
      tmpAdo.Parameters.ParamByName('ttype').Value:='1';//�������
      tmpAdo.Parameters.ParamByName('pick_mater_qty').Value:=StrToInt(Edit2.text);
      tmpAdo.ExecSQL;
// �޸Ķ�Ӧ733�������PP����Ϊ��д����
      tmpAdo.Close;
      tmpAdo.SQL.Clear;
      tmpAdo.SQL.Text:='select * from dbo.data0733 where Rkey='+DM.cds732haoRkey733.AsString;
      tmpAdo.Open;
      if (not tmpAdo.IsEmpty) then
      iResult:=tmpAdo.FieldByName('pick_material_qty_e').asInteger;
      tmpAdo.Close;
      tmpAdo.SQL.Clear;
      tmpAdo.SQL.Text:='update dbo.data0733 set pick_material_qty_e='+intToStr(iResult+StrToInt(Edit2.Text))+' where Rkey='+DM.cds732haoRkey733.AsString;
      tmpAdo.ExecSQL;
  //end ����734------------
    finally
      tmpAdo.Close;
      tmpAdo.Connection:=nil;
      tmpAdo.Free;
    end;
//end ����734------------

//�����ҵ��-----
    iYNber:=0;
    edtBarCode.Text:='';
    Edit2.Text:='';
    dm.cds732hao.Close;
    DM.cds732hao.Params.ParamByName('NUMBER').Value:='aaaaaaaa';
    dm.cds732hao.Open;
    edtBarCode.SetFocus;
    imgCY.Picture:=nil;
  end;
  
end;

end.
