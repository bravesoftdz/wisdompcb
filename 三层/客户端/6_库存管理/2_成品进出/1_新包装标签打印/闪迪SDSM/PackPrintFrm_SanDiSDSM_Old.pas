unit PackPrintFrm_SanDiSDSM;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, BasePackPrintFrm_525, Bde.DBTables,
  frxClass, frxDBSet, Data.DB, Datasnap.DBClient, Vcl.StdCtrls, Vcl.Mask,
  RzEdit, Vcl.Grids, Vcl.ValEdit, Vcl.ExtCtrls, frxDesgn;

type
  TfrmPackPrint_SanDiSDSM = class(TfrmBasePackPrint_525)
  private
    { Private declarations }
  public
    { Public declarations }
    procedure BeforeSaveToDB; override;
  end;

implementation

{$R *.dfm}

procedure TfrmPackPrint_SanDiSDSM.BeforeSaveToDB;
var
  LParamID: Integer;
begin
  inherited;

  if FPackType = 1 then
  begin
    if cdsPackType.Locate('ParamName','�ͻ���ά��',[loCaseInsensitive]) then
    begin
      LParamID := cdsPackType.FieldByName('ParamID').AsInteger;

      vePackInfo.Values['�ͻ���ά��'] :=

        vePackInfo.Values['�ͻ�������'] + ';' +
        vePackInfo.Values['SDSM������'] + ';' +
        vePackInfo.Values['�ͻ��ͺ�'] + ';' +
        vePackInfo.Values['���Գ��ͱ�ע'] + ';' +
        vePackInfo.Values['PCS����'] + ';' +
        vePackInfo.Values['����'] + ';' +
        vePackInfo.Values['MSL'] + ';' +
        vePackInfo.Values['��������'] + ';' +
        vePackInfo.Values['LotNo'];// + ';' +
        //vePackInfo.Values['ë��'] + ';' +
        //vePackInfo.Values['��Ч��'];

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

end.
