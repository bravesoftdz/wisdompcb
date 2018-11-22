unit damo;

interface

uses
  SysUtils, Classes, DB, ADODB,dialogs;

type
  TDM = class(TDataModule)
    ADOConnection1: TADOConnection;
    ADOQuery1: TADOQuery;
    DataSource1: TDataSource;
    ADOQuery1RKEY: TSmallintField;
    ADOQuery1FASSET_ALT_TYPE: TStringField;
    ADOQuery1ALT_FLAG: TSmallintField;
    ADOQuery1type: TStringField;
    ado0525: TADOQuery;
    procedure ADOQuery1CalcFields(DataSet: TDataSet);
    procedure ADOQuery1DeleteError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DM: TDM;

implementation

{$R *.dfm}

procedure TDM.ADOQuery1CalcFields(DataSet: TDataSet);
begin
 case dm.ADOQuery1.FieldByName('alt_flag').AsInteger of
  0: dm.ADOQuery1type.AsString:='�ʲ�����';
  1: dm.ADOQuery1type.AsString:='�ʲ�����';
 end;
end;

procedure TDM.ADOQuery1DeleteError(DataSet: TDataSet; E: EDatabaseError;
  var Action: TDataAction);
begin
messagedlg('���ݼ����ܷ�����ͻ��',mtwarning,[mbcancel],0);
abort;
end;

end.
