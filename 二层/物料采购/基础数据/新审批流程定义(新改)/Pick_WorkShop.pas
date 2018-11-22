unit Pick_WorkShop;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Grids, DBGridEh, StdCtrls,DBClient,DB, Provider, ADODB,StrUtils;

type
  TfrmPick_WorkShop = class(TForm)
    Panel1: TPanel;
    DBGridEh1: TDBGridEh;
    labelKey: TLabel;
    Panel2: TPanel;
    OKBtn: TButton;
    CancelBtn: TButton;
    CheckBox1: TCheckBox;
    edtKey: TEdit;
    ads73: TADODataSet;
    DataSource1: TDataSource;
    ads73clientds: TClientDataSet;
    ads73provide: TDataSetProvider;
    ads73IsSelected: TBooleanField;
    ads73rKey: TIntegerField;
    ads73USER_LOGIN_NAME: TStringField;
    ads73USER_FULL_NAME: TStringField;
    ads73clientdsIsSelected: TBooleanField;
    ads73clientdsrKey: TIntegerField;
    ads73clientdsUSER_LOGIN_NAME: TStringField;
    ads73clientdsUSER_FULL_NAME: TStringField;
    procedure DBGridEh1DblClick(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure DBGridEh1TitleClick(Column: TColumnEh);
    procedure edtKeyChange(Sender: TObject);
    procedure edtKeyKeyPress(Sender: TObject; var Key: Char);
    procedure DBGridEh1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ads73clientdsFilterRecord(DataSet: TDataSet;
      var Accept: Boolean);
    procedure FormShow(Sender: TObject);
  private
    PreColumn: TColumnEh;
    { Private declarations }
  public
    { Public declarations }
    procedure Enter(rKey:integer);
  end;

var
  frmPick_WorkShop: TfrmPick_WorkShop;

implementation
uses DM_u,MyClass,common;
{$R *.dfm}

{ TfrmPick_WorkShop }

procedure TfrmPick_WorkShop.Enter(rKey: integer);
begin
  ReSet_Sort(DBGridEh1);
  
  ads73clientds.Filter:='';
  ads73clientds.Filtered:=false;

  ads73clientds.Close;
  ads73clientds.Open;

  MyDataClass.UpdateValueToField(ads73clientds,checkbox1.Checked,'IsSelected');
  ads73clientds.Locate('rKey',rKey,[]);
end;

procedure TfrmPick_WorkShop.DBGridEh1DblClick(Sender: TObject);
begin
  Modalresult := mrok;
end;

procedure TfrmPick_WorkShop.CheckBox1Click(Sender: TObject);
begin
  MyDataClass.UpdateValueToField(ads73clientds,checkbox1.Checked,'IsSelected');
end;

procedure TfrmPick_WorkShop.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
 canclose:=true;
  if Modalresult = mrok then
  begin
    try
      ads73clientds.DisableControls;
      MyDataClass.Set_Filter('IsSelected=1',ads73clientds);
      if ads73clientds.IsEmpty then
      begin
        ShowMsg('������û�',1);
        canclose:= false;
        ads73clientds.Filter:='';
        ads73clientds.Filtered := false;
        exit;
      end;
    finally
      ads73clientds.EnableControls;
    end;
  end;
end;

procedure TfrmPick_WorkShop.DBGridEh1TitleClick(Column: TColumnEh);
var OldIndex:string;
begin
  edtKey.Enabled:= not ads73clientds.IsEmpty;
  if ads73clientds.IsEmpty then abort;
  if trim(Column.Title.Caption)='ѡ��' then
    labelKey.Caption :='������'
  else
   labelKey.Caption :='����(' +Column.Title.Caption+')��';
  if (Column.Grid.DataSource=nil) or (Column.Grid.DataSource.DataSet=nil) or (not Column.Grid.DataSource.DataSet.Active) then
    Exit;
  OldIndex:=TClientDataSet(Column.Field.DataSet).IndexName;

  if OldIndex<>'' then
  begin
    TClientDataSet(Column.Field.DataSet).IndexName:='';
    TClientDataSet(Column.Field.DataSet).DeleteIndex(OldIndex);
  end;
  if Column.Title.SortMarker = smDownEh then
  begin
    TClientDataSet(Column.Field.DataSet).AddIndex('px',Column.Field.FieldName,[ixPrimary]);
    TClientDataSet(Column.Field.DataSet).IndexName:='px';
    Column.Title.SortMarker := smUpEh;
  end
  else if Column.Title.SortMarker = smUpEh then
  begin
//      TClientDataSet(Column.Field.DataSet).DeleteIndex('px');
      Column.Title.SortMarker := smNoneEh;
  end
  else if Column.Title.SortMarker = smNoneEh then
  begin
    TClientDataSet(Column.Field.DataSet).AddIndex('px',Column.Field.FieldName,[ixDescending]);//�Ѿ�������Ͱ���������
    TClientDataSet(Column.Field.DataSet).IndexName:='px';
    Column.Title.SortMarker := smDownEh;
  end;{end case}
  if (PreColumn.FieldName<>column.FieldName)  and
     (column.Field.DataType in [ftString,ftWideString])
  then PreColumn := column;
end;

procedure TfrmPick_WorkShop.edtKeyChange(Sender: TObject);
//var tmpstr,sFilter:string;
//    DATASET:TClientDATASET;
begin
//  if not ads73clientds.Active then abort;
//  DataSet:=ads73clientds;
//  tmpstr:= trim(edtKey.Text);
//  if TmpStr='' then
//    DataSet.Filtered:= false
//  else
//  begin
//    if (DBGridEh1.SelectedField.DataType in [ftString,ftWideString,ftMemo]) then
//    begin
//      sFilter := '%'+uppercase(TmpStr)+'%';
//      DataSet.Filter := DBGridEh1.SelectedField.FieldName+' Like '+ QuotedStr(sFilter);
//      DataSet.Filtered:= False;
//      DataSet.Filtered:= true;
//    end
//    else if DBGridEh1.SelectedField.DataType in [ftSmallint, ftInteger, ftWord, ftFloat, ftCurrency, ftBCD,ftLargeint] then
//    begin
//      if TmpStr='-' then exit;
//      sFilter := DBGridEh1.SelectedField.FieldName+'>='+TmpStr;//DBGrid3.SelectedField.FieldName+'>='+TmpStr+' AND '+ DBGrid3.SelectedField.FieldName+'<'+IntToStr(Get_Filter_Of_Fixed_Int(StrToFloat(TmpStr)));
//      DataSet.Filter := sFilter;
//      DataSet.Filtered:= False;
//      DataSet.Filtered:= true;
//    end
//    else if DBGridEh1.SelectedField.DataType in [ftDate, ftDateTime] then
//    begin
//      if not IsDatetime(TmpStr) then exit;
//      sFilter := '>='+QuotedStr(TmpStr);
//      DataSet.Filter := DBGridEh1.SelectedField.FieldName + sFilter;
//      DataSet.Filtered:= False;
//      DataSet.Filtered:= true;
//    end;
//  end;
  with ads73clientds do
  if trim(edtKey.Text) <> '' then
  begin
    Filtered := False;
    Filtered := true;
  end
  else
    Filtered := False;
end;

procedure TfrmPick_WorkShop.edtKeyKeyPress(Sender: TObject; var Key: Char);
begin
  if DBGridEh1.SelectedField.DataType in [ftSmallint, ftInteger, ftWord, ftLargeint] then
  begin
    if (length((Sender as TEdit).Text)=20) and (key<>chr(8)) then Abort;
    if Key='.' then abort;
//    if (pos('.',(Sender as TEdit).Text)>0) and (key='.') then abort;
    if (pos(key,'-0123456789.')=0) and (key<>chr(8)) then
      Abort;
    if (pos('-',(Sender as TEdit).Text)>0) and (key='-') then abort;
    if Length((Sender as TEdit).text)>0 then
      if (key='-') then abort;
  end
  else if  DBGridEh1.SelectedField.DataType in [ftFloat, ftCurrency, ftBCD] then
  begin
    if (length((Sender as TEdit).Text)=20) and (key<>chr(8)) then Abort;
    if (pos('.',(Sender as TEdit).Text)>0) and (key='.') then abort;
    if (pos(key,'-0123456789.')=0) and (key<>chr(8)) then  Abort;
    if (pos('-',(Sender as TEdit).Text)>0) and (key='-') then abort;
    if Length((Sender as TEdit).text)>0 then
    if (key='-') then abort;
  end ;
end;

procedure TfrmPick_WorkShop.DBGridEh1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if (chr(key)='V') and (ssalt in shift) then
  showmessage(ads73.CommandText);
end;

procedure TfrmPick_WorkShop.ads73clientdsFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
begin
  if Assigned(edtKey) then
  if Trim(edtKey.Text) <>'' then
    Accept:=AnsiContainsText(UpperCase(DataSet.FieldByName(PreColumn.FieldName).AsString),UpperCase(edtKey.Text) ) ;
end;

procedure TfrmPick_WorkShop.FormShow(Sender: TObject);
begin
  PreColumn := DBGridEh1.Columns[1] ;
end;

end.
