unit USendDetailFrm_mod38;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,uBaseSinglePickListFrm, DBGridEhGrouping,
  ToolCtrlsEh, DBGridEhToolCtrls, DynVarsEh, Vcl.ComCtrls, Vcl.StdCtrls,
  Data.DB, Datasnap.DBClient, EhLibVCL, GridsEh, DBAxisGridsEh, DBGridEh,
  Vcl.ExtCtrls,uCommFunc, Data.Win.ADODB,System.DateUtils;

type
  TfrmSendDetail_mod38 = class(TfrmSinglePickList)
    btnClose: TButton;
    btnExport: TButton;
    GroupBox2: TGroupBox;
    Label8: TLabel;
    Label9: TLabel;
    dtpk1: TDateTimePicker;
    DTPk2: TDateTimePicker;
    qry1: TADOQuery;
    strngfldqry1���ϵ���: TStringField;
    strngfldqry1���ֵ���: TStringField;
    strngfldqry1���ϱ���: TStringField;
    strngfldqry1��������: TStringField;
    strngfldqry1���Ϲ��: TStringField;
    strngfldqry1��������: TStringField;
    strngfldqry1��Ӧ��: TStringField;
    strngfldqry1���Ϲ���: TStringField;
    strngfldqry1���ϲ��Ŵ���: TStringField;
    strngfldqry1���ϲ�������: TStringField;
    strngfldqry1��������: TStringField;
    fltfldqry1��������: TFloatField;
    strngfldqry1��λ: TStringField;
    dtmfldqry1��������: TDateTimeField;
    strngfldqry1ԭ��Ӧ�̻�����: TStringField;
    strngfldqry1������Ա: TStringField;
    strngfldqry1���ϱ�ע: TStringField;
    strngfldqry1���ϲֿ�: TStringField;
    strngfldqry1������Ա: TStringField;
    procedure btnCloseClick(Sender: TObject);
    procedure btnExportClick(Sender: TObject);
    procedure DTPk2Change(Sender: TObject);
    procedure dtpk1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure edtFilterChange(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmSendDetail_mod38: TfrmSendDetail_mod38;

implementation

{$R *.dfm}

procedure TfrmSendDetail_mod38.btnCloseClick(Sender: TObject);
begin
  inherited;
close;
end;

procedure TfrmSendDetail_mod38.btnExportClick(Sender: TObject);
begin
  inherited;
  if MessageBox(Handle,'�Ƿ񵼳���EXCEL','��ʾ',MB_YESNO) = IDYES then
  begin
    if not cdspick.IsEmpty then
    begin
      gFunc.Export_dbGridEH_to_Excel(eh1);
    end else
      ShowMessage('��������Ϊ��');
  end;

end;

procedure TfrmSendDetail_mod38.dtpk1Change(Sender: TObject);
begin
  inherited;
   cdsPick.Filter:=' �������� >= '''+formatdatetime('yyyy-MM-dd hh:mm:ss',dtpk1.Date)+''' and �������� <= '''+formatdatetime('yyyy-MM-dd hh:mm:ss',dtpk2.Date)+''' ';
   cdsPick.Filtered:=true;
end;

procedure TfrmSendDetail_mod38.DTPk2Change(Sender: TObject);
begin
  inherited;
   dtpk1Change(sender);
end;

procedure TfrmSendDetail_mod38.edtFilterChange(Sender: TObject);
var
  fDate: Tdatetime;
begin

 if (FHotColumn.Field.DataType in [ftDate, ftDateTime]) and (trim(edtFilter.text)<>'') then
    if not TryStrToDate(trim(edtFilter.text), fDate) then
    begin
      Showmessage(trim(edtFilter.text) + '�������ڸ�ʽ��');
      exit;
    end;
  inherited;
end;

procedure TfrmSendDetail_mod38.FormCreate(Sender: TObject);
begin
  inherited;
      dtpK2.Date:=gFunc.GetSvrDateTime;
       dtpk1.Date:=dtpK2.Date-dayof(dtpK2.Date)+1;
end;

end.
