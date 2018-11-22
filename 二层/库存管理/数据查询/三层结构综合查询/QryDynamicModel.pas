{******************************************************************************}
{                                                                              }
{Code Maker: Jacky Zhong                                                       }
{Date: MAR. 27. 2007                                                           }
{Comments:��̬��ѯ����,�̳���"ͨ�ò�ѯ����"                                    }
{ �̳й�ϵ: TfrmQueryStandard--> TfrmQryDynamicModel                           }
{1.�ṩ��ѯ�������ù���,SQL��֤,�����ز�ѯ������ݼ�                           }
{2.��װ�˲�ѯ��������,��¼����,����,��ӡ,�ȹ���                                }
{3.��ڲ���:ģ����,��ѯ���ݼ�                                                }
{�����ݱ�qry_Column_List����ģ�����λ��Ϣ,                                    }
{4.�ɶ����ѯ�����DBGridҪ��ʾ���ֶ�,�����������                             }
{5.�ɶ����ѯ�����DBGrid��ĳ���ֶ��Ƿ�Ҫͳ��,ͳ�Ʒ�ʽ(ƽ��,����)              }
{6.���ݴ��侭��ѹ���ͽ�ѹ,�ɼ�����������                                       }
{******************************************************************************}
unit QryDynamicModel;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, QueryStandard, Menus, ImgList, DB, DBClient, ComCtrls, Grids,
  DBGridEh, RzTabs, RzButton, ExtCtrls, ToolWin, StdCtrls, Mask, RzEdit,
  RzDTP;

type
  TfrmQryDynamicModel = class(TfrmQueryStandard)
    cdsColumnList: TClientDataSet;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure N8Click(Sender: TObject);
    procedure spbtnExecClick(Sender: TObject);
    procedure N9Click(Sender: TObject);
    procedure DBGrid3ColumnMoved(Sender: TObject; FromIndex,
      ToIndex: Integer);
    procedure DBGrid3ColWidthsChanged(Sender: TObject);
    procedure PopupMenu2Popup(Sender: TObject);
  private
    { Private declarations }
    Colum_Changed:boolean;
  public
    { Public declarations }
    procedure InitForm(qryNo:integer;ItemData,pvData:OLEVAriant);overload;//vpData[0]:�Ѷ���õĲ�ѯ����;vpData[1],��ѯ���ݽ��,sqlstr:��ѯ����
  end;

var
  frmQryDynamicModel: TfrmQryDynamicModel;

implementation

uses Client_FUnc,PUBFunc,QryColumnSet;
{$R *.dfm}

{ TfrmQryDynamicModel }

procedure TfrmQryDynamicModel.InitForm(qryNo: integer; ItemData,pvData: OLEVAriant);
var
  vData:OleVariant;
  ErrorMsg:wideString;
begin
//  vData := VarArrayCreate([0,1], varVariant);
  if not coMyQuery.Get_Qry_Condition(qryNo,vData,ErrorMsg) then
  begin
    ShowMsg('��ȡ����������ʧ�ܣ�',1);
    abort;
  end
  else
  begin
    cdsMaster.Data:= vData[0];
    if VarIsEmpty(ItemData) then
    begin
      cdsItems.Data := vData[1];
      cdsItems.First;
      while not cdsItems.Eof do begin
        cdsItems.edit;
        cdsItems.FieldByName('nType').Value := 'AND';
        cdsItems.FieldByName('nOperator').Value := '=';
        if Uppercase(trim(cdsItems.FieldByName('DataType').Asstring))='D' then
        begin
          cdsItems.FieldByName('nOperator').Value := 'BETWEEN';
          cdsItems.FieldByName('InputValue').Value :=QuotedStr(FormatDatetime('yyyy-mm-dd',Get_Month_First_Day(date)))+' AND '+QuotedStr(FormatDatetime('yyyy-mm-dd',Date));
        end;
        cdsItems.next;
      end;
      cdsItems.first;
    end
    else
      cdsItems.Data := ItemData;
//    if VarIsEmpty(vpData)
    cdsQueryData.data := pvData;
    cdsColumnList.Data := vData[2];
    Add_Columns_ToDBGrid(dbgrid3,cdsColumnList);
  end;
  dtpStartDate.Date := date;
  dtpEndDate.Date := date;
  if DBGRid3.Columns.Count > 0 then
    DBGrid3CellClick(DBGRid3.Columns[0]);
  Colum_Changed:=false;
  Show;
end;

procedure TfrmQryDynamicModel.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  inherited;
  Action := cafree;
  frmQryDynamicModel := nil;
end;

procedure TfrmQryDynamicModel.N8Click(Sender: TObject);
var
  vData:OleVariant;
  ErrorMsg:wideString;
begin
  inherited;
//  if ((strToInt(vprev)=2) or (strToInt(vprev)=4)) then
  begin
    with TfrmQryColumnSet.Create(Application) do
    try
      InitForm(cdsMaster.FieldByName('QryNo').Value);
      if Showmodal = mrok then
      begin
        if not coMyQuery.Get_Sql_Data('select * from qry_Column_List where qryNo='+cdsMaster.FieldByName('QryNo').Asstring,vData,ErrorMsg) then
        begin
          ShowMsg('��ȡ����������ʧ��:��'+ErrorMsg,1);
          abort;
        end
        else
        begin
          cdsColumnList.Data := vData;
          Reset_Grid_Columns(dbgrid3,cdsColumnList);//Add_Columns_ToDBGrid(dbgrid3,cdsColumnList);
        end;
      end;
    finally
      free;
    end;
  end
//  else
//    ShowMsg('�Բ���,��û��������λ��ʾ��Ȩ��!',1);
end;

procedure TfrmQryDynamicModel.spbtnExecClick(Sender: TObject);
var
  Sqlstr,ErrorMsg:Widestring;
  vData:OleVariant;
  MainSql:string;
  i : integer;
  D : Double;
begin
  i := GetTickCount;
  ReSet_Sort(DBGRid3);
  MainSql := cdsMaster.FieldByName('PreSqlstr').AsString;
  cdsQueryData.Filtered:= false;
  if cdsItems.State in dsEditModes then
    cdsItems.Post;
  if not Check_Fields_Values then exit;
  sqlstr:= Get_Rslt;
  Sqlstr:= MainSql+sqlstr+ cdsMaster.FieldByName('sufSqlStr').AsString;
  cdsQueryData.IndexName := '';
//  if coMyQuery.Get_Sql_Data(sqlstr,vData,ErrorMsg) then
  if coMyQuery.Get_Sql_Data_With_Compressed(sqlstr,vData,ErrorMsg) then
  begin
    if DeCompress_Data(vData) then
      cdsQueryData.Data := vData
    else
      ShowMsg('���ݽ�ѹ��ʧ�ܣ�����',1);
  end
  else
  begin
    ShowMsg('���ز�ѯ����ʧ�ܣ�����',1);
    exit;
  end;
  D := (GetTickCount - i)/1000;
  StatusBar1.Panels[2].Text := '����ʱ: '+FloatToStr(D)+'��';
end;

procedure TfrmQryDynamicModel.N9Click(Sender: TObject);
var
  vData:OleVariant;
  ErrorMsg:wideString;
begin
  inherited;
  if ((strToInt(vprev)=2) or (strToInt(vprev)=4)) then
  begin
    if Save_Grid_Columns_Change(cdsMaster.FieldByName('QryNo').Value,dbgrid3,cdsColumnList) then
      Colum_Changed:= false; //column_change saved and finished
  end
  else
    ShowMsg('�Բ���,��û��������λ��ʾ��Ȩ��!',1);
  inherited;
end;

procedure TfrmQryDynamicModel.DBGrid3ColumnMoved(Sender: TObject;
  FromIndex, ToIndex: Integer);
begin
  inherited;
{  if ((strToInt(vprev)=2) or (strToInt(vprev)=4)) then
    Colum_Changed:=true
  else
    abort;}
end;

procedure TfrmQryDynamicModel.DBGrid3ColWidthsChanged(Sender: TObject);
begin
  inherited;
{  if ((strToInt(vprev)=2) or (strToInt(vprev)=4)) then
    Colum_Changed:=true
  else
    abort;}
end;

procedure TfrmQryDynamicModel.PopupMenu2Popup(Sender: TObject);
begin
  inherited;
  N9.Enabled := Colum_Changed;
end;

end.
