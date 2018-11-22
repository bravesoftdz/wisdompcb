unit Unit1;

interface

uses
  SysUtils, Classes, DB, ADODB,Dialogs;

type
  TDM = class(TDataModule)
    DataSource1: TDataSource;
    ADOConnection1: TADOConnection;
    ADOTable1: TADOTable;
    ADOTable1PR_GRP_CODE: TStringField;
    ADOTable1PRODUCT_GROUP_NAME: TStringField;
    ADOTable1RKEY: TAutoIncField;
    procedure ADOTable1AfterDelete(DataSet: TDataSet);
    procedure ADOTable1PostError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
    procedure ADOTable1DeleteError(DataSet: TDataSet; E: EDatabaseError;
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

procedure TDM.ADOTable1AfterDelete(DataSet: TDataSet);
begin
messagedlg('���ݱ��ɹ�ɾ��!',mtinformation,[mbok],0);
end;

procedure TDM.ADOTable1PostError(DataSet: TDataSet; E: EDatabaseError;
  var Action: TDataAction);
begin
 messagedlg('����ʧ��,�����������Ƿ��ظ�!',mtwarning,[mbok],0);
 abort;
end;

procedure TDM.ADOTable1DeleteError(DataSet: TDataSet; E: EDatabaseError;
  var Action: TDataAction);
begin
 messagedlg('����ɾ��ʧ�ܣ��ѱ�������������!!!',mtwarning,[mbok],0);
 abort;
end;

end.

