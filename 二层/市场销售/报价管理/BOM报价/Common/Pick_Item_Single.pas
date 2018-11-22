unit Pick_Item_Single;

interface

uses Windows, Messages,SysUtils, Classes, Graphics, Forms, Controls, StdCtrls,
  Buttons, ExtCtrls, Grids, DBGrids, DB, ADODB,StrUtils,variants,
  ComCtrls, DBClient,Dialogs, DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls,
  DynVarsEh, EhLibVCL, GridsEh, DBAxisGridsEh, DBGridEh;

type
  PDlgInput = record
    Fields,  //ѡ����Dbgrid��ʾ���ֶ���Ϣ,�����ʽΪ'Field1/Caption1,Field2/Caption'
    KeyField,  //���������Ϊ����Ϊ'rkey'
    Sqlstr:string; //���ݼ���sql��ѯ
    InPut_value : variant;    //���ڶ�λ�ڵ�ǰ��ֵ�ļ�¼
    AdoConn: TAdoConnection; //�����Ado����
  end;

  TfrmPick_Item_Single = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    OKBtn: TButton;
    CancelBtn: TButton;
    Label1: TLabel;
    edtKeyValue: TEdit;
    adsPick1: TADODataSet;


    dsPick: TDataSource;
    StatusBar1: TStatusBar;
    eh1: TDBGridEh;
    procedure DBGrid1DblClick(Sender: TObject);
    procedure DBGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure edtKeyValueChange(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dsPickDataChange(Sender: TObject; Field: TField);
    procedure eh1TitleClick(Column: TColumnEh);
  private
    { Private declarations }
    KeyField: string;
    Tmp_Input:string;//Tmp_input����Ĳ�����ֵ
    PreColumn: TColumnEh; //�ϴ�ѡ���column
    procedure Add_Grid_Fields(Fields:string);overload;
    procedure Add_Grid_Fields_New(StrFields:string);overload;
    procedure Adjust_Column_Width;
  public
    adsPick:TADODataSet;
    procedure InitForm(InputVar: PDlgInput);
    procedure InitForm_New(InputVar: PDlgInput;dst:TADODataSet=nil); //�ɴ����ֶεĿ��,��ʽ:'FieldName1/Caption1/width1,FieldName2/Caption2/width2,...'
    function Get_Rslt:variant;//������ѡ�ļ�¼��ֵ
  end;

var
  frmPick_Item_Single: TfrmPick_Item_Single;

implementation

{$R *.dfm}

{ TfrmPick_Item_Single }


procedure TfrmPick_Item_Single.Add_Grid_Fields(Fields:string);
var
  i,j:integer;
  Left_str,right_str,FieldName,FieldCaption:string;
  NewColumn:TColumnEh;
begin
  if Fields='' then exit;
  //���ֶ���Ϣ���л�ȡÿ���ֶ������Լ���ʾcaption
  i:= Pos(',',fields);
  if i > 0 then //�ҵ����ֶηָ����
  begin
    left_str:= leftStr(Fields,i-1);     //��ȡ��һ���ֶβ���
    right_str:=rightStr(Fields,Length(Fields)-i);//��ȡ���˵�һ���ֶ�ʣ�ಿ��
  end
  else
    left_str := Fields; //���û���ҵ�','

  j:=Pos('/',left_str);
  if j>0 then //�����'/'�ָ���ţ���ʾ��Ч
  begin
    FieldName:= leftstr(left_str,j-1);
    FieldCaption:=rightStr(left_str,Length(left_str)-j);
    NewColumn:= eh1.Columns.Add;
    NewColumn.FieldName := FieldName;
    NewColumn.Title.Caption := FieldCaption;
  end;
  Add_Grid_Fields(right_str); //�ݹ����㣬ֱ�������ֶ�ȫ���ֽ���ȫ
  Caption := 'ѡ��'+eh1.Columns[0].Title.caption;
end;

function TfrmPick_Item_Single.Get_Rslt: variant;
begin
  result := adsPick.fieldbyName(KeyField).Value;
end;

procedure TfrmPick_Item_Single.InitForm(InputVar: PDlgInput);
begin
  adsPick:=adsPick1;
  dsPick.DataSet:=adsPick;

  adsPick.Connection := InputVar.AdoConn;
  adsPick.CommandText := InputVar.Sqlstr;
  adsPick.Close;
  adsPick.open;
  if InputVar.KeyField = '' then
    KeyField :='rKey'
  else
    KeyField :=InputVar.KeyField;
  if VarAsType(InputVar.InPut_value,varString) <> '' then
    adsPick.Locate(KeyField,InputVar.InPut_value,[]);
  Add_Grid_Fields(InputVar.Fields);
//������λ�Ŀ��
  Adjust_Column_Width;
  PreColumn:= eh1.Columns[0];
  PreColumn.title.Color := clred;
  Caption := 'ѡ��'+eh1.Columns[0].Title.caption;
end;

procedure TfrmPick_Item_Single.DBGrid1DblClick(Sender: TObject);
begin
if not self.adsPick.IsEmpty then
  ModalResult := mrok;
end;

procedure TfrmPick_Item_Single.Adjust_Column_Width;
var
  i :integer;
  TotalSize:integer;
begin
  TotalSize:=0;
  for i := 0 to eh1.Columns.Count - 1 do
    TotalSize := TotalSize + eh1.Columns[i].Field.DisplayWidth;

  for i := 0 to eh1.Columns.Count - 1 do
    eh1.Columns[i].Width := trunc((eh1.Columns[i].Field.DisplayWidth / TotalSize)*eh1.ClientWidth);
end;

procedure TfrmPick_Item_Single.DBGrid1KeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key= Chr(vk_Back) then
    Tmp_input:=copy(Tmp_input,1,Length(Tmp_input)-1)
  else
  begin
    if key<>chr(vk_return) then
    Tmp_Input:=Tmp_Input+Key;
    adsPick.Locate(precolumn.FieldName,Tmp_input,[loPartialKey]);
  end;
  StatusBar1.Panels[1].Text := Tmp_Input;
  
end;


procedure TfrmPick_Item_Single.edtKeyValueChange(Sender: TObject);
begin

  if trim(edtKeyValue.text)<>'' then
  begin
    adsPick.Filter:=PreColumn.FieldName+ ' like ''*'+trim(edtKeyValue.TEXT)+'*''';
  end
  else
    adsPick.Filter:='';
end;


procedure TfrmPick_Item_Single.eh1TitleClick(Column: TColumnEh);
begin
if adspick.IndexFieldNames<>column.FieldName then
 begin
  adsPick.IndexFieldNames := column.FieldName;
  StatusBar1.Panels[1].Text := Column.Title.Caption;
 end;

if (precolumn.FieldName<>column.FieldName) and
  (eh1.DataSource.DataSet.FieldByName(column.FieldName).DataType in [ftString, ftWideString]) then
 begin
  PreColumn.Title.Color := clBtnFace;
  Column.Title.Color := clred;
  PreColumn := column;
  edtkeyvalue.SetFocus;
  label1.Caption:=column.Title.Caption;
 end;
end;

procedure TfrmPick_Item_Single.Add_Grid_Fields_New(StrFields: string);
var
  i,j,k,TotalWidth,ColWidth:integer;
  Left_str,right_str,FieldName,FieldCaption,TmpStr:string;
  NewColumn:TColumnEh;
begin
  TotalWidth:=0;
  while StrFields <> '' do begin
    //���ֶ���Ϣ���л�ȡÿ���ֶ������Լ���ʾcaption
    i:= Pos(',',StrFields);
    if i > 0 then //�ҵ����ֶηָ����
    begin
      left_str:= leftStr(StrFields,i-1);     //��ȡ��һ���ֶβ���
      right_str:=rightStr(StrFields,Length(StrFields)-i);//��ȡ���˵�һ���ֶ�ʣ�ಿ��
    end
    else
    begin
      left_str := StrFields; //���û���ҵ�','
      right_str:='';
    end;

    j:=Pos('/',left_str);  //��һ��'/'
    if j>0 then //�����'/'�ָ���ţ���ʾ��Ч
    begin
      ColWidth := 0;
      FieldName:= leftstr(left_str,j-1);
//      FieldCaption:=rightbStr(left_str,Length(left_str)-j);
      TmpStr:=rightStr(left_str,Length(left_str)-j);
      k:= Pos('/',Tmpstr);     // �ڶ���'/'
      if K > 0 then  //�����ֶο������
      begin
        FieldCaption:=leftStr(Tmpstr,k-1);
        ColWidth := StrToInt(rightStr(Tmpstr,length(tmpstr)-k));
        TotalWidth := TotalWidth + ColWidth;
      end
      else
        FieldCaption:=Tmpstr;
      NewColumn:= eh1.Columns.Add;
      NewColumn.FieldName := FieldName;
      NewColumn.Title.Caption := FieldCaption;
      if ColWidth <> 0 then
        NewColumn.Width := ColWidth;
    end;
    StrFields:= right_str;
  end;
//  if self.Width < TotalWidth +28 then  
   self.width := TotalWidth + 35;
end;

procedure TfrmPick_Item_Single.InitForm_New(InputVar: PDlgInput;dst:TADODataSet=nil);
var
 search_option:tlocateoptions;
  I: Integer;
begin
  if dst=nil then
  begin
    adsPick:=adsPick1;
    adsPick.Connection := InputVar.AdoConn;
    adsPick.CommandText := InputVar.Sqlstr;
    adsPick.Close;
    adsPick.open;
  end else
    adsPick:=dst;
  dsPick.DataSet:=adsPick;

  if InputVar.KeyField = '' then
    KeyField :='rKey'
  else
    KeyField :=InputVar.KeyField;
  search_option := [lopartialkey];
  if VarAsType(InputVar.InPut_value,varString) <> '' then
    adsPick.Locate(KeyField,InputVar.InPut_value,search_option);
  Add_Grid_Fields_New(InputVar.Fields);
//������λ�Ŀ��
  PreColumn:= eh1.Columns[0];
  PreColumn.title.Color := clred;
  label1.Caption:=precolumn.Title.Caption;
  Caption := 'ѡ��'+eh1.Columns[0].Title.caption;

  for I := 0 to eh1.Columns.Count - 1 do
  begin
    eh1.Columns[i].STFilter.Visible:=True;
  end;
end;

procedure TfrmPick_Item_Single.DBGrid1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
 if (chr(key)='V') and (ssalt in shift) then
  ShowMessage(ADspick.CommandText);
end;

procedure TfrmPick_Item_Single.dsPickDataChange(Sender: TObject;
  Field: TField);
begin
if self.adsPick.IsEmpty then
 okbtn.Enabled := false
else
 okbtn.Enabled := true;
end;


end.
