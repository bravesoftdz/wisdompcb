unit demo;

interface

uses
  SysUtils, Classes, DB, ADODB, Dialogs;

type
    Tfm_demo = class(TDataModule)
    ds_source: TDataSource;
    qry_adoqry: TADOQuery;
    cn_adocon: TADOConnection;
    procedure qry_adoqryDeleteError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
      procedure qry_adoqryAfterDelete(DataSet: TDataSet);
    procedure qry_adoqryPostError(DataSet: TDataSet; E: EDatabaseError;
      var Action: TDataAction);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  fm_demo: Tfm_demo;

implementation

{$R *.dfm}

procedure Tfm_demo.qry_adoqryDeleteError(DataSet: TDataSet;
  E: EDatabaseError; var Action: TDataAction);
begin
   ShowMessage('�õ�λ�ѷ���ҵ��,�޷�ɾ��');
   Abort;
end;

procedure Tfm_demo.qry_adoqryAfterDelete(DataSet: TDataSet);
begin
  ShowMessage('��λɾ���ɹ�');
end;

procedure Tfm_demo.qry_adoqryPostError(DataSet: TDataSet;
  E: EDatabaseError; var Action: TDataAction);
begin
  ShowMessage('��λ�ظ����޷��ύ');
  Abort;
end;

end.
