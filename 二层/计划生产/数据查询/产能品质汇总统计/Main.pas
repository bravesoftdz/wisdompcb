unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, Grids, DBGridEh, ComCtrls, unionCon,
  DM, DateUtils, TS, common, HistoryMain, Menus, ActiveX;

type
  TFrmMain = class(TForm)
    pnl1: TPanel;
    bbt_1: TBitBtn;
    dgh_main: TDBGridEh;
    dtp1: TDateTimePicker;
    lb_1: TLabel;
    dtp2: TDateTimePicker;
    lb_2: TLabel;
    dtp3: TDateTimePicker;
    dtp4: TDateTimePicker;
    bbt_4: TBitBtn;
    lb_3: TLabel;
    bbt_3: TBitBtn;
    bbt_2: TBitBtn;
    bbt_8: TBitBtn;
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    procedure bbt_3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure bbt_4Click(Sender: TObject);
    procedure bbt_2Click(Sender: TObject);
    procedure bbt_6Click(Sender: TObject);
    procedure bbt_1Click(Sender: TObject);
    procedure dgh_mainDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FrmMain: TFrmMain;

implementation

{$R *.dfm}
  
procedure TFrmMain.bbt_3Click(Sender: TObject);
begin
  FrmunionCon := TFrmunionCon.Create(Application);
  FrmunionCon.ShowModal;
  FrmunionCon.Free;
end;

//ͳ��
procedure TFrmMain.FormCreate(Sender: TObject);
begin

  if not app_init(damo.con1) then
  begin
    common.ShowMsg('��������ʧ��,����ϵϵͳ����Ա',1);
    application.Terminate;
    exit;
  end;
  Caption := application.Title;
  dtp1.Date := now - 1;
  dtp3.Date := now ;
end;

procedure TFrmMain.bbt_4Click(Sender: TObject);
var
  i, j: Integer;
  Strs: string;
begin
  //���뵽729����
  if strtoint(vprev) <> 4 then
  begin
    messagedlg('�Բ���! ��û�б�������ݵ�Ȩ��',mtinformation,[mbok],0);
    Exit;
  end;

  if dgh_main.RowCount <= 2 then
  begin
    ShowMessage('��ǰ��¼Ϊ�գ�����ʧ�ܣ�');
    Exit;
  end;

  with Damo.qrytemp do
  begin
    Close;
    SQL.Text :=  'select rkey from data0729 where Date='+ QuotedStr(DateToStr(dtp1.Date))
      + ' and ControlItemName='+ QuotedStr(damo.qry729.FieldValues['������ĿN']);
    Open;
    if not FieldByName('rkey').IsNull then
    begin
      ShowMessage('ʱ�� '+ DateToStr(dtp1.Date) + ' ���б����¼�������鿴��ʷ��¼��');
      Exit;
    end;
  end;
  try
    damo.qry729.First;
    for i := 0 to dgh_main.RowCount - 2 do
    begin
      for j := 0 to damo.qry729.FieldCount - 1 do
      begin
        Strs := Strs + '''' + string(damo.qry729.FieldValues[damo.qry729.Fields[j].FieldName]) + '''' + ',';
      end;
      Strs := '(' + Copy(Strs, 0, (Length(Strs) - 1)) + ')';
      with damo.qrytemp do
      begin
        Close;
        SQL.Clear;
        SQL.Text := 'insert into data0729 values' + Strs;
        ExecSQL;
      end;
      damo.qry729.Next;
      Strs := '';
    end;
    ShowMessage('�ף��ü�¼�ѱ���ɹ���');
  except
    on e: Exception do
    begin
      ShowMessage(e.Message);
    end;
  end; 
end;

procedure TFrmMain.bbt_2Click(Sender: TObject);
var
  i: Integer;
begin
  try
    FrmTS := TFrmTS.Create(Application);
    FrmTS.ShowModal;
    FrmTS.Free;
    with damo.qry729 do
    begin
      Close;
      SQL.Clear;
      SQL.Text := 'exec GetResultND :dtp1,:dtp2,:dtp3,:Daycount';
      Parameters.ParamByName('dtp1').Value := DateToStr(dtp1.Date) + ' ' + TimeToStr(dtp2.Time);
      Parameters.ParamByName('dtp2').Value := DateToStr(dtp3.Date) + ' ' + TimeToStr(dtp4.Time);
      Parameters.ParamByName('dtp3').Value := DateToStr(StartOfTheMonth(dtp1.Date)) + ' ' + TimeToStr(dtp2.Time);
      if Trim(Edit1.Text) = '' then
        Parameters.ParamByName('Daycount').Value := DaysBetween(dtp3.Date,StartOfTheMonth(dtp1.Date))
      else
        Parameters.ParamByName('Daycount').Value := StrToInt(Edit1.text);
      Open;
      //ѭ����dbgrd1�ı����FieldName��ֵ
      for i := 0 to FieldCount - 1 do
      begin
        dgh_main.Columns[i].FieldName := Fields[i].FieldName;
      end;
    end;
  except
    on e: Exception do
    begin
      ShowMessage(e.Message);
    end;
  end;
end;

procedure TFrmMain.bbt_6Click(Sender: TObject);
begin
  FrmHistory := TFrmHistory.create(Application);
  FrmHistory.ShowModal;
  FrmHistory.free;
end;

procedure TFrmMain.bbt_1Click(Sender: TObject);
begin
  application.Terminate;
end;

procedure TFrmMain.dgh_mainDrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
begin
  inherited;
  with dgh_main do
  begin
  if ((State = [gdSelected]) or (State=[gdSelected,gdFocused])) then
  begin
    Canvas.Font.Color :=ClYellow;
    Canvas.Brush.Color :=ClNavy;
  end
  else
  begin
  if Damo.ds729.DataSet.RecNo mod 2 <> 0 then {�жϵ�ǰ��������������ż����}
    Canvas.brush.Color :=ClWhite {����������У�DBGrid�����԰�ɫ��ʾ}
  else
    Canvas.brush.Color :=$00EAEAEA; {�����ż���У�DBGrid������ǳ��ɫ��ʾ}
  end;
  DefaultDrawColumnCell(Rect, DataCol, Column, State); {���кܹؼ��ģ�һ����Ҫ��©��}
  end;
end;

end.
