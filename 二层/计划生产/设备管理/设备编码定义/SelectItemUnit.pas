unit SelectItemUnit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs,  StdCtrls, ExtCtrls, DB,StrUtils,
  Buttons, Grids, DBGrids, ADODB, DBClient, Menus;

type
  TfrmSelectItem = class(TForm)
    pnl2: TPanel;
    pnl1: TPanel;
    Edit1: TEdit;
    ds1: TDataSource;
    bt1: TSpeedButton;
    dgh1: TDBGrid;
    Button1: TButton;
    Label1: TLabel;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Edit1KeyPress(Sender: TObject; var Key: Char);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Dgh1DblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure bt1Click(Sender: TObject);
    procedure dgh1CellClick(Column: TColumn);
    procedure dgh1TitleClick(Column: TColumn);
    procedure N1Click(Sender: TObject);
    procedure dgh1KeyPress(Sender: TObject; var Key: Char);
  private
    procedure cdsFilterRecord(DataSet: TDataSet;
         var Accept: Boolean);
 //   VResultFieldName:string;
    { Private declarations }
  public
    FilterFieldName:string;
    { Public declarations }
  end;

var
  frmSelectItem: TfrmSelectItem;

Function ShowAddListForm(AHandle:THandle; ADODataSet: TDataSet;AFilterField:string;
    FilterFieldValue:string; L,T,W:Integer;FormCaption:PChar=nil;GridNotDisplayFields:TStrings=nil):Boolean; StdCall;

implementation

//uses DBEditBit;

//uses AddListUnit;


{$R *.dfm}
Function ShowAddListForm(AHandle:THandle; ADODataSet: TDataSet;AFilterField:string;
    FilterFieldValue:string; L,T,W:Integer;FormCaption:PChar=nil;GridNotDisplayFields:TStrings=nil):Boolean; StdCall;
var
  s:string;
  I_S,I_F:Integer;
  colt:TColumn;
begin
  Result:=False;
  Application.Handle:=AHandle;

  try
    frmSelectItem:=TfrmSelectItem.Create(Application);
//    frmSelectItem.Font.Size:= (ADODataSet.Owner as TForm).Font.Size;
//    frmSelectItem.Font.Charset:= (ADODataSet.Owner as TForm).Font.Charset;
//    frmSelectItem.Font.Name:= (ADODataSet.Owner as TForm).Font.Name;
    with frmSelectItem do
    begin
 //     vResultFieldName:=ResultFieldName;
      if  FormCaption='' then
        Caption:='选择'
      else
        Caption:=FormCaption;

      ds1.DataSet:=ADODataSet;
      if ds1.DataSet.Active =False then
        ds1.DataSet.Open;   {  }
      ADODataSet.OnFilterRecord:= cdsFilterRecord;
      if GridNotDisplayFields<>nil then
      begin
        for I_S:=0 to GridNotDisplayFields.Count-1 do
        begin
          for I_F:=0 to dgh1.FieldCount-1 do
          begin
            if (dgh1.Columns[I_F].FieldName=GridNotDisplayFields[I_S]) then
            begin
              dgh1.Columns[I_F].Visible:=False;
              Break    ;
            end;
          end;
        end;
      end;

     { for i:=0 to  FieldList.Count-1 do
      begin
        colt:=dgh1.Columns.Add;
        colt.FieldName:= FieldList[i];
      end; }
      FilterFieldName:= AFilterField;
      Edit1.Text:= FilterFieldValue;

      frmSelectItem.Left:=L;
      frmSelectItem.Top:=T;
      frmSelectItem.Width:=w;
     // frmSelectItem.Height:= w / 4 * 3);
      if frmSelectItem.ShowModal=mrOk then
      Result:=True;

    end;
  finally
  //  frmSelectItem.Free;
  end;
end;

procedure TfrmSelectItem.cdsFilterRecord(DataSet: TDataSet;
  var Accept: Boolean);
var
  strTemp: String;
begin
  Accept:=(AnsiContainsText(DataSet.FieldByName(FilterFieldName).AsString,Edit1.Text )) ;
  //Accept:=(Pos(Edit1.Text, DataSet.FieldByName(FilterFieldName).AsString)>0) ;
end;

procedure TfrmSelectItem.FormShow(Sender: TObject);
var
  i:Integer;
begin
  if dgh1.DataSource.DataSet is TClientDataSet then
  begin
    with  dgh1.DataSource.DataSet as TClientDataSet do
    if ReadOnly=False then
    begin

      dgh1.PopupMenu:= PopupMenu1;
    end
    else
      dgh1.PopupMenu:= nil;
  end
  else
  if dgh1.DataSource.DataSet is TADODataSet then
  begin
    with  dgh1.DataSource.DataSet as TADODataSet do
    if LockType=ltReadOnly then
    begin
      dgh1.PopupMenu:= PopupMenu1;
    end
    else
      dgh1.PopupMenu:= nil;
  end;

  for I := 0 to Dgh1.FieldCount - 1 do
  begin
    if UpperCase(Dgh1.Fields[i].FieldName)=UpperCase(FilterFieldName) then
    begin
      Dgh1.SelectedIndex:=i;
      Dgh1TitleClick(Dgh1.Columns[i]);
      Exit;
    end;
  end;

  Dgh1.SetFocus;
  Edit1.SetFocus;
//  Edit1.SetFocus;
//  FilterFieldName:= Dgh1.DataSource.DataSet.FieldList[0].FieldName;
//  Label1.Caption:=  Dgh1.DataSource.DataSet.FieldList[0].DisplayLabel;
//  Label1.Left:=5;
//  Edit1.Left:=10+label1.Width;
//  bt1.Left:=Edit1.Left+edit1.Width+5;
end;

procedure TfrmSelectItem.N1Click(Sender: TObject);
begin
  dgh1.DataSource.DataSet.Delete;
end;

procedure TfrmSelectItem.Edit1Change(Sender: TObject);
var
  strsql: string;
begin
  with (Dgh1.DataSource.DataSet as TDataSet) do
  if trim(Edit1.Text) <> '' then
  begin
    Filtered := False;
    Filtered := true;
  end
  else
    Filtered := False;
//  strsql := '';
//  if trim(Edit1.Text) <> '' then
//  begin
//    if dgh1.DataSource.DataSet.FieldByName(FilterFieldName).DataType in [ftDate,ftDateTime] then
//      strsql :=  FilterFieldName+' = ' + QuotedStr(trim(Edit1.Text))
//    else
//      strsql :=  FilterFieldName+' like ''%' + trim(Edit1.Text) + '%''';
//  end   ;
//
//  if strsql <> '' then
//  begin
//   // ShowMessage(strsql);
//    Dgh1.DataSource.DataSet.Filter := strsql;
//    Dgh1.DataSource.DataSet.Filtered := true;
//  end
//  else
//  begin
//    Dgh1.DataSource.DataSet.Filter := '';
//    Dgh1.DataSource.DataSet.Filtered := false;
//  end;
end;

procedure TfrmSelectItem.Edit1KeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#13 then
  Dgh1DblClick(Sender);
end;

procedure TfrmSelectItem.FormClose(Sender: TObject;
  var Action: TCloseAction);
  var
    BM:Pointer ;
begin

  if dgh1.DataSource.DataSet is TClientDataSet then
  begin
    with dgh1.DataSource.DataSet as TClientDataSet  do
    begin
      if State in [dsInsert,dsEdit] then
      Post;
      if ChangeCount>0   then
      begin
        ApplyUpdates(0);

        try
          bm:=GetBookmark;//书签。
          Refresh;
          GotoBookmark(BM);  // 重新定位到书签
        finally
          FreeBookmark(bm ) ;
        end;
      end;
    end;
  end
  else
  if dgh1.DataSource.DataSet is TCustomADODataSet then
  begin
    with dgh1.DataSource.DataSet as TCustomADODataSet  do
    begin
      if State in [dsInsert,dsEdit] then
      Post;
    end;
  end;
end;

procedure TfrmSelectItem.Dgh1DblClick(Sender: TObject);
begin
  Button1.Click;
end;

procedure TfrmSelectItem.FormCreate(Sender: TObject);
begin;
end;

procedure TfrmSelectItem.bt1Click(Sender: TObject);
begin
  self.Edit1.Text:='';
  if Dgh1.DataSource.DataSet.Filtered then
  Dgh1.DataSource.DataSet.Filtered :=False;
end;

procedure TfrmSelectItem.dgh1CellClick(Column: TColumn);
begin
//  FilterFieldName:=dgh1.SelectedField.FieldName;
//  Label1.Caption:=  Dgh1.DataSource.DataSet.FieldByName(FilterFieldName).DisplayLabel;
//  Label1.Left:=5;
//  Edit1.Left:=10+label1.Width;
//  bt1.Left:=Edit1.Left+edit1.Width+5;
end;

procedure TfrmSelectItem.dgh1TitleClick(Column: TColumn);
begin
   Label1.Caption:=Column.Field.DisplayLabel;
   Label1.Left:=5;
   Edit1.Left:=10+ Label1.Width;
   bt1.Left:= Edit1.Left+ Edit1.Width+5;
   if UpperCase(Column.Field.FieldName)<>UpperCase(FilterFieldName) then
   begin
     Edit1.Text:='';
     FilterFieldName:= Column.Field.FieldName;
   end;
end;

procedure TfrmSelectItem.dgh1KeyPress(Sender: TObject; var Key: Char);
begin
  if Key=#13 then
  Button1.Click;
end;

end.
