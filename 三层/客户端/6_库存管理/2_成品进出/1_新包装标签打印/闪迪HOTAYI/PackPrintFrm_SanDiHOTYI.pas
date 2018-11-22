unit PackPrintFrm_SanDiHOTYI;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BasePackPrintFrm_525, Bde.DBTables,
  frxClass, frxDBSet, Data.DB, Datasnap.DBClient, Vcl.StdCtrls, Vcl.Mask,
  RzEdit, Vcl.Grids, Vcl.ValEdit, Vcl.ExtCtrls, frxDesgn;

type
  TfrmPackReportFrm_SanDiHOTYI = class(TfrmBasePackPrint_525)
    mmoSql: TMemo;
    procedure edtWOBarKeyPress(Sender: TObject; var Key: Char);
    procedure vePackInfoValidate(Sender: TObject; ACol, ARow: Integer;
      const KeyName, KeyValue: string);
  private
    { Private declarations }
  public
    { Public declarations }
    function GetWOInfoDS(ACds: TClientDataSet): Boolean;override;
    procedure BeforeSaveToDB; override;
  end;

implementation

uses
  uCommFunc, System.DateUtils;

{$R *.dfm}

procedure TfrmPackReportFrm_SanDiHOTYI.BeforeSaveToDB;
var
  LParamID: Integer;
begin
  inherited;
//@Q60
  //if FPackType = 0 then
  begin
    if cdsPackType.Locate('ParamName','�ͻ���ά��',[loCaseInsensitive]) then
    begin
      LParamID := cdsPackType.FieldByName('ParamID').AsInteger;

      vePackInfo.Values['�ͻ���ά��'] :=
        '[)>@06@12S0002' +
        '@P'+ vePackInfo.Values['�ͻ����Ϻ�'] +
        '@1P'+ vePackInfo.Values['�������'] +
        '@31P@12VWuzhu@10V@2P@20P' +
        '@6D' + vePackInfo.Values['��������'] +
        '@14D' + vePackInfo.Values['��Ч��'] +
        '@30PY@ZN@K@16K@V@3S' +
        '@Q' + vePackInfo.Values['PCS����'] + 'NAR000@20T' +
        '@1T ' + vePackInfo.Values['���ϵ���'] + '@2T@1Z@@';


      cdsPrintDetail.First;
      while not cdsPrintDetail.Eof do
      begin
        if cdsPrintDetail.FieldByName('ParamID').AsInteger = LParamID then
        begin
          cdsPrintDetail.Edit;
          cdsPrintDetail.FieldByName('ParamValue').AsString := vePackInfo.Values['�ͻ���ά��'];
          cdsPrintDetail.Post;

        end;

        cdsPrintDetail.Next;
      end;
    end else
      ShowMessage('û�ҵ��ͻ���ά��');

  end;

end;

procedure TfrmPackReportFrm_SanDiHOTYI.edtWOBarKeyPress(Sender: TObject;
  var Key: Char);
var
  LFM: TFormatSettings;
  Y,M,D: string;
  Ldt: TDateTime;
begin
  inherited;
  if Key =#13 then
  begin
    vePackInfo.Values['��������'] := FormatDateTime('yyyymmdd',now());

    Y := copy(vePackInfo.Values['��������'],1,4);
    M := copy(vePackInfo.Values['��������'],5,2);
    D := Copy(vePackInfo.Values['��������'],7,2);

    LFM.ShortDateFormat := 'yyyy-mm-dd';
    LFM.DateSeparator := '-';
    ldt := IncMonth(StrToDate(Y+'-'+M+'-'+D,LFM),6);


    vePackInfo.Values['��Ч��'] := FormatDateTime('yyyymmdd',ldt);
    vePackInfo.Values['���ϵ���'] := vePackInfo.Values['���ϵ���'].Split(['-'])[0];
  end;
end;

function TfrmPackReportFrm_SanDiHOTYI.GetWOInfoDS(
  ACds: TClientDataSet): Boolean;

begin
  UpdateSQL1.DeleteSQL.Assign(mmoSql.Lines);
  Result := inherited GetWOInfoDS(ACds);
  if Result then
  begin
    if ACds.IsEmpty then Exit;

    if ACds.FieldByName('�ͻ�����').AsString <> '7328' then
    begin
      Result := False;
      ShowMessage('���¼���ϵͳ��ӡ');
      Exit;
    end;

  end;
end;

procedure TfrmPackReportFrm_SanDiHOTYI.vePackInfoValidate(Sender: TObject; ACol,
  ARow: Integer;const KeyName, KeyValue: string);
var
  LFM: TFormatSettings;
  Y,M,D: string;
  Ldt: TDateTime;
begin
  inherited;
  if KeyName = '��������' then
  begin
    Y := copy(vePackInfo.Values['��������'],1,4);
    M := copy(vePackInfo.Values['��������'],5,2);
    D := Copy(vePackInfo.Values['��������'],7,2);

    LFM.ShortDateFormat := 'yyyy-mm-dd';
    LFM.DateSeparator := '-';
    ldt := IncMonth(StrToDate(Y+'-'+M+'-'+D,LFM),6);


    vePackInfo.Values['��Ч��'] := FormatDateTime('yyyymmdd',ldt);
  end;
end;

end.
