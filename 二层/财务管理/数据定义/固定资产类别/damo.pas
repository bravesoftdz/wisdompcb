unit damo;

interface

uses
  SysUtils, Classes, DB, ADODB,Dialogs;

type
  TDM = class(TDataModule)
    DataSource1: TDataSource;
    ADOConnection1: TADOConnection;
    ADOQuery1: TADOQuery;
    ADOQuery1type: TStringField;
    ADOQuery1RKEY: TSmallintField;
    ADOQuery1FASSET_TYPE: TStringField;
    ADOQuery1depr_mthd_ptr: TIntegerField;
    ADOQuery1expected_life: TFloatField;
    ADOQuery1expected_surplus_rate: TFloatField;
    ADOQuery1prechar1: TStringField;
    procedure ADOQuery1CalcFields(DataSet: TDataSet);
    procedure ADOQuery1PostError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
    procedure ADOQuery1EditError(DataSet: TDataSet; E: EDatabaseError;
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
 case dm.ADOQuery1.FieldByName('depr_mthd_ptr').AsInteger of
  0: dm.ADOQuery1type.AsString:='�������۾�';
  1: dm.ADOQuery1type.AsString:='ƽ�����޷�';
  2: dm.ADOQuery1type.AsString:='��������';
  3: dm.ADOQuery1type.AsString:='˫�����ݼ���';
  4: dm.ADOQuery1type.AsString:='�������޷�';
 end;
end;
procedure TDM.ADOQuery1PostError(DataSet: TDataSet; E: EDatabaseError;
  var Action: TDataAction);
begin
 messagedlg('�����ύ�����Ƿ�����!',mtwarning,[mbok],0);
 abort;
end;

procedure TDM.ADOQuery1EditError(DataSet: TDataSet; E: EDatabaseError;
  var Action: TDataAction);
begin
 messagedlg('���������Ƿ�ɾ������!',mtwarning,[mbok],0);
 abort;
end;

end.
