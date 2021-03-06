unit CostAllocationDetail;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGridEh, StdCtrls, Buttons, ExtCtrls, DB, ComCtrls;

type
  Tfrm_CostAllocationDetail = class(TForm)
    Panel1: TPanel;
    BitBtn4: TBitBtn;
    DBGridEh1: TDBGridEh;
    DataSource1: TDataSource;
    StatusBar1: TStatusBar;
    Label1: TLabel;
    Edit1: TEdit;
    BitBtn3: TBitBtn;
    procedure SpeedButton1Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure DBGridEh1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure DBGridEh1TitleClick(Column: TColumnEh);
  private
    PreColumn:TColumnEh;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_CostAllocationDetail: Tfrm_CostAllocationDetail;

implementation

uses dmao,common;

{$R *.dfm}

procedure Tfrm_CostAllocationDetail.SpeedButton1Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure Tfrm_CostAllocationDetail.BitBtn4Click(Sender: TObject);
begin
  if not dm.ADOD410.IsEmpty then
  if MessageDlg('您确认导出数据到Excel吗?',mtConfirmation,[mbYes, mbNo],0) =mryes then
  Export_dbGridEH_to_Excel(self.DBGridEh1,self.Caption);
end;

procedure Tfrm_CostAllocationDetail.DBGridEh1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (ssAlt in Shift)  and  (Key=86) then
  showmessage(DM.ADOD410.CommandText);
end;

procedure Tfrm_CostAllocationDetail.FormShow(Sender: TObject);
begin
  PreColumn := DBGridEh1.Columns[0];
  StatusBar1.Panels[0].Text :='记录数：'+IntToStr(dm.ADOD410.RecordCount);
end;

procedure Tfrm_CostAllocationDetail.Edit1Change(Sender: TObject);
begin
  if trim(Edit1.text)<>'' then
    dbgrideh1.DataSource.DataSet.Filter := PreColumn.FieldName+' like ''%'+trim(edit1.text)+'%'''
  else
    dbgrideh1.DataSource.DataSet.Filter:='';
end;

procedure Tfrm_CostAllocationDetail.DBGridEh1TitleClick(Column: TColumnEh);
begin
  if (column.Title.SortMarker = smDownEh) or (column.Title.SortMarker = smNoneEh) then
  begin
    column.Title.SortMarker := smUpEh;
    dm.ADOD410.IndexFieldNames := Column.FieldName;
  end
  else
  begin
    column.Title.SortMarker:=smDownEh;
    dm.ADOD410.IndexFieldNames:=Column.FieldName+' DESC';
  end;

  if (PreColumn.FieldName<>column.FieldName)  and
    (column.Field.DataType in [ftString,ftWideString]) then
  begin
    label1.Caption:=column.Title.Caption;
    edit1.SetFocus;
    PreColumn.Title.Color := clBtnFace;
    Column.Title.Color := clred;
    PreColumn := column;
  end
  else
  edit1.SetFocus;
end;

end.
