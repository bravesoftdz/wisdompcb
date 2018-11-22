unit ReportFrm_Mod353;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, frxClass, frxDBSet, Data.DB, uCommFunc,
  Datasnap.DBClient, frxDesgn, Data.Win.ADODB, Datasnap.Provider;

type
  TFrmReport_Mod353 = class(TForm)
    cds209: TClientDataSet;
    cds493: TClientDataSet;
    frxdbdtst493: TfrxDBDataset;
    frxdbdtst209: TfrxDBDataset;
    frxReport1: TfrxReport;
    frxDesigner1: TfrxDesigner;
    cds493Company_Name: TStringField;
    cds493Company_Name2: TStringField;
    cds493Company_Name3: TStringField;
    cds493ship_address: TStringField;
    cds493Company_Icon: TBlobField;
    cds493SITE_INFO_ADD_1: TStringField;
    cds493SITE_INFO_ADD_2: TStringField;
    cds493SITE_INFO_ADD_3: TStringField;
    cds493SITE_INFO_PHONE: TStringField;
    cds209��Ʒ����: TStringField;
    cds209��Ʒ���: TStringField;
    cds209��Ʒ���: TStringField;
    cds209��Ӧ��: TStringField;
    cds209��ϵ��: TStringField;
    cds209��ϵ�绰: TStringField;
    cds209��ַ: TStringField;
    cds209װ������: TDateTimeField;
    cds209�ɹ�������: TStringField;
    cds209��ⵥ��: TStringField;
    cds209Ҫ������: TDateTimeField;
    cds209�ͻ�����: TStringField;
    cds209��������: TFloatField;
    cds209������λ: TStringField;
    cds209�ѽ�������: TBCDField;
    cds209���յ���: TBCDField;
    cds209�˻�����: TFloatField;
    cds209�˻���Ա: TStringField;
    cds209�˻����: TFloatField;
    cds209��������: TStringField;
    cds209װ�˷���: TWideStringField;
    cds209�˻���ע: TWideStringField;
    cds209˰��: TBCDField;
    cds209Rkey: TAutoIncField;
    cds209��������: TDateTimeField;
    cds209װ����Ա: TStringField;
  private
    { Private declarations }
  public
    procedure GetData(ARkey: string);
    { Public declarations }
  end;

var
  FrmReport_Mod353: TFrmReport_Mod353;

implementation

{$R *.dfm}

{ TFrmReport_Mod353 }

procedure TFrmReport_Mod353.GetData(ARkey: string);
begin
  gSvrIntf.IntfGetDataBySql(cds209.CommandText + ' and  Data0209.Rkey= ' + ARkey , cds209);
  gSvrIntf.IntfGetDataBySql(cds493.CommandText , cds493);
end;

end.
