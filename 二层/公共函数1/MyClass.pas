{******************************************************************************}
{                                                                              }
{   Code Maker: Jacky Zhong                                                    }
{   Date: Jun. 17. 2007                                                        }
{   Comments:�Զ����൥Ԫ�����������Զ�����,���£�                             }
{   1.���ݿ⴦���࣬��װ�˶����ݿ�Ĳ����������ṩ�ӿ�ͳһ����                 }
{   2.��ʽ��֤����֤��ʽ�Ƿ���ȷ                                               }
{   3.��ʽ������
{   4.���ͽṹչ����(Treeview)                                                 }
{******************************************************************************}

unit MyClass;
//��Ķ���

interface
uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  VCLCom, StdVcl, DBClient,Grids, DBGrids,ComCtrls,
  DB, ADODB, Provider,variants,winsock,Midas,ComConst,StrUtils;

  function Is_NUll(Input_value,Output_Value:variant):variant;  //�жϴ������ֵ�Ƿ���NULL��������һ��ָ������ֵ
const
  Int_Type= ' 2 ';
  Str_Type= ' ''X'' ';

//�Զ��������ദ���࣬��װ�����ݿ���ֲ�����
type
   TMyDataClass = class
  private
    FAdoConn : TADoConnection; //Ado��������
    aqTmp: TADoQuery;
    acmd: TAdoCommand;
    aspTmp: TADOStoredProc;

  public
    { Public declarations }
    function OpenQuery(Sqlstr:string):boolean; overload;//����sql������
    function OpenQuery(Query:TAdoQuery;Sqlstr:string):boolean; overload;//����sql������
    function OpenDataSetByPara(InPara:variant;adsTmp:TadoDataSet):boolean;overload;//�����������һ��dataset
    function OpenDataSet(DataSet:TADoDataSet;Sqlstr:string):boolean;

    function IsExists(Sqlstr:string):boolean;//����sql��ѯ�Ƿ��¼���ڣ�true����

    function Get_Sql_Value(sqlstr:string):variant;//����sql,����һ���ֶ���ֵ

    function ExecSql(Sqlstr:string):boolean;overload; //ִ��һ��sql����

    function ExecSql(Sqlstr:string;pTrans:boolean):boolean;overload; //ִ��һ��sql����
    //ִ�д洢����
    function ExecProc(ProcName: string; var ParamStrs: array of variant;
      Direction: array of TParameterDirection): boolean;overload;

    function ExecProc(ADOStoredProc: TADOStoredProc ;ProcName: string; var ParamStrs: array of variant;
      Direction: array of TParameterDirection;ExecType:byte): boolean;overload;

    //���ݸ��º�����pTrans:����������ֵ��true�ɹ���falseʧ��
    function SaveData(ads_Tmp: array of TADODataSet;pTrans:Boolean):boolean;overload;
    function UpdateValueToField(pDataSet:TDataSet;value:variant;FieldName:string):boolean;//�������ݱ�ĳ���ֶ���ֵ
    function ChangeFieldValue(pDataSet:TDataSet;Oldvalue,NewValue:variant;FieldName:string):boolean;//�������ݱ�ĳ���ֶ���ֵ

    //ɾ��ָ���ļ�¼������ֵ��FieldName�ֶΣ�fieldValue:ָ���ļ�¼��ֵ
    function DeleteRecord(ads_Tmp: TADODataSet;FieldName:string;FieldValue:variant):boolean;overload;
    procedure DeleteTable(DataSet:TDataSet);//ɾ�����ݱ����м�¼
    function Check_Unique_Field_Value(sqlstr:string):boolean;//��֤�ֶ���ֵ�Ƿ�Ψһ
    procedure Set_Filter(str_filter:string;DataSEt:TDATASET);//���ù���

    Constructor Create(AdoConn: TAdoConnection);
    Destructor Destroy;override;
  end;

type
  //�����������
  TOperator = (opLess, opLessOrEqual, opGreater, opGreaterOrEqual, opEqual,
                   opUnequal, opPlus, opMinus, opOr, opMul, opDiv, opAnd);
  const
    DataType_Float ='2';
    DataType_String ='X';

//��ʽ������
type
  TBdsProc = class
  protected
    sGeta,sGetb,sGetc,sGetd:string;
  private
    sNew,sEnd: string;
    NowPoint: integer;  //�滻��ĸʱ ��¼��ǰ�������ַ���λ��
    Fghpd: Integer;//ʶ�𲢱�����������Ƿ�ɶԳ���
    function IsCalcFh(c: Char): boolean;//�б�һ���ַ��Ƿ������
    function CopyRight(abds: String;start: Integer):String;//��ȡ�ַ������ʽ
    function BdsSs(var abds: String): Double;//����һ���ӱ��ʽ��ֵ
 //   function BdsHs(var abds: String): Double;   //�����ڵļ���
    function BdsYz(var abds: String): Double;//���ʽ���ӣ��磺15��(13+5)

    function BdsItm(var abds: String): Double;//��ȡ���ʽ�е�һ������
    
    procedure ChangeString(var sEnd,sNew: string; var Point:integer; sChar:char); //�滻��ĸ
    function IsChar(c: char):Boolean;   //�ж��Ƿ���ĸ
  public
    function PublicExplain(sSource: string): String; //`````````````````�ӿ�```````````````
    function CalcExpr(strExpr:string):double;//���㹫ʽ�����ؽ��
  end;

  TPUSHPOP = class
  private
    EndStep : Boolean;    //���һ��ʱ ��ΪTrue
    ffh: array [0..2] of Char;//��������
    value: array [0..3] of Double;//ֵ����
    flevel: Byte;//���Ӹ���
    fisfh: Boolean;//ʶ��ȴ�����ֵ�������
    function Calcsj(av1,av2: Double;fh: Char): Double;//ִ��������ֵ����������
    procedure Calccur;//�����������������ĸ�����ִ���м�����
    function IsCcFH(fh: Char): Boolean;// �ж������
  public
    constructor Create;
    procedure PushValue(avalue: Double);//����һ��������
    procedure PushFh(afh: Char);//����һ������
    function CalcValue: Double;//���㲢����ֵ
  end;




type
//��ʽ��֤��
   TFormula_Verify = class
  private
    FAdoConn : TADoConnection; //Ado��������
    aqTmp1: TADoQuery;
    aqTmp2: TADoQuery;
//    DataBase:TDataBase;
//    Query1: TQuery;
    ExprCalc:TBdsProc;
//------------------------------------------------------------------------------
    //����һ���ַ����������ָ���ַ������������
    function verify_Step_One(Input_str:string):string;  //��һ����֤
    function Verify_IF(vstring:string):string; //��֤IF����
    function poss(vstr1:string;vstr2:string):integer;
    function posss(vs:integer;vstr1:string;vstr2:string):integer;
    function Check_VFP_Sql(Sqlstr:string):boolean;//����SQL��VFP���м��飬���������������޷���SQL SERVER�д���
//------------------------------------------------------------------------------
//���ϲ����ǾɵĹ�ʽ��֤�������Ǹ��ݾͳ�������д�ģ�����Ĵ���������д��
//------------------------------------------------------------------------------
    function Calc_If_Expr(strExpr:string):string;//����If���ʽ������IF�߼����㣬���ؼ�����������string����
    function Get_Last_Phrase_Pos(strPhrase,strExpr:string):integer;//����ĳ�����ʽ�������ַ�������λ��
    function Get_PosOfPhrase_Num(strPhrase,strExpr:string;Num:integer):integer;//���ַ����в����ַ���ָ���ڼ��γ��ֵ�λ��
    function Get_PosOfbracket(strExpr:string):integer;//�����һ�������ţ�������֮ƥ���һ����')'����λ��
    function Judge_Data_Type(strExpr:string):integer;//����������ַ����жϸñ��ʽ���������ͣ�1�����֣�2���ַ� ,3.Unknow 4.�߼����ʽ
    function De_Bracket(strExpr:string):string;//������ʽ��'(',')'��ƥ�䣬��ô�������ʽ��'(',')'����
    function Replace_Expr_Factor(Input_str:string):string;//��������ŷֱ��滻��ʽ�еĲ�ͬ�������͵Ĳ�����
    procedure DeCode_FXY(strExpr:string;var X,Y:string); //���ݹ�ʽ��ֵ������X,Y����ֵ
    function Calc_FX(rKey,DataType:integer;sX,sY:string):string;//���㹤�̱������ؽ��
    function Assign_Formula_Param_Value(DataSet:TDataSet;var str_expr:string):boolean;//����Ӧ�Ĳ�����ֵ��������ʽ
    function Calc_Eng_Table(var str_expr:string):boolean;//���㹤�̱�����ֵ
    function Calc_Expr(str_Expr:string):double;//���㹫ʽ����ֵ
    function Check_Param(strExpr:string):boolean; //������ʽ�еĲ����Ƿ�Ϸ�
    function Is_Operator(C:Char):Boolean;//�ж��Ƿ����������
    function Is_Logic_Operator(C:string):Boolean;
    function Calc_Logic_Expr(str_Expr:string):boolean;
    function Get_Logic_Expr(str_Expr:string):string;
    function Pos_AndOR_Prase(str_Expr:string;Prase:string):integer;//����and or ��λ��
    function De_Logic_Prase(str_Expr:string;iType:byte;var Div_Expr:string):string;//���� And,or����2�ߵķָ���
    function Replace_Factor_Part_Cost(Cost_Dept,Part_Group:integer;Input_str:string):string;//��������ŷֱ��滻����������ʽ�еĲ�ͬ�������͵Ĳ�����
    function Pos_OF_Operator(C:string):integer;
//    function Check_
  public

    Constructor Create(AdoConn: TAdoConnection);
    Destructor Destroy;override;
    function Verify(Input_str:string):boolean;//��֤��ʽ--���ڵ�
    function Get_If_Expr(strExpr:string):string; //����IF�ı��ʽ������Ƕ��IF��������һ����ѧ������ʽ
    function Verify_Formula(Input_str:string;var output_str:string):boolean;//��֤��ʽ
    function Calc_Formula(dsParam:TDataSet;str_Expr:string):double;//����һ����ʽ����ֵ
    function Verify_Logic_Formula(Input_str:string;var output_str:string):boolean;//��֤�߼���ʽ
    function Verify_Part_Cost_Formula(Cost_Dept,Part_Group:integer;Input_str:string;var output_str:string):boolean;//��֤���������ɱ���ʽ
    function Calc_Expr_Parma(var str_Expr:string;out Out_Value:double):boolean;//����һ���Ѿ���ֵ�ı��ʽ
  end;


  type
  TMyTreeClass = class  //����չ����
  private
    { Private declarations }
    //AdoConnection ��ϵͳ�õ����ݿ�����
    FAdoConnection: TAdoConnection;
    qryTmpItem: TAdoQuery;
    SeqNo:integer;//���
    FieldName:array of string;
    FieldValue:array of variant;
    Sel_Sql:string; //��ȡ�������ݵ�Sql
    procedure Get_Tree_List_Data(TopNo:integer;LevNo: integer);overload;//�����������Item
    procedure Get_Tree_List_Data(TopNo:String;LevNo: integer);overload;//�����������Item
    procedure Get_Tree_List_Data_Up(TopNo:String;LevNo: integer);//������������ϼ�Item
    procedure Write_Tree_Item(DATASET:TDATASET);//д���ݵ����ݱ�
    procedure Create_Tree_List(TreeView : TTreeView);//������
    procedure GetFieldValue(DataSet:TDataSet);//�����ֵ

  public
    { Public declarations }
    constructor Create(AdoConnection: TAdoConnection); virtual;
    destructor Destroy; override;
{Ŀǰ���ͽṹֻ����4���ֶ�,������:1.ItemNo ������,2.SeqNo ���, 3.ItemName ��ʾ���� 4.LevNo �㼶}
    procedure Expand_My_Tree_Down(TreeView: TTReeView;TopNo,SqlStr,TreeTitle:String);overload;
    procedure Expand_My_Tree_Down(TreeView: TTReeView;TopNo:integer;SqlStr,TreeTitle:String);overload;
    procedure Get_My_Tree_Data(TopNo,SqlStr,TreeTitle:String;DataSet:TCustomAdoDATASET);
  end;

var
     MyDataClass: TMyDataClass;//���ݲ�����
     Formula_Verify:TFormula_Verify;
     MyTreeClass:TMyTreeClass;

implementation

{ TMyDataClass }

constructor TMyDataClass.Create(AdoConn: TAdoConnection);
begin
//����������Ӻ����ݲ����齨
//  FAdoConn := TADoConnection.Create(AdoConn);
  FAdoConn := AdoConn;
  aqTmp := TADoQuery.Create(nil);  //adoquery������sql���ݲ�ѯ
  aqTmp.Connection :=FAdoConn;

  acmd := TAdoCommand.Create(nil);   //command�齨
  acmd.Connection := FAdoConn;

  aspTmp := TADOStoredProc.Create(nil);//�洢�����齨
  aspTmp.Connection :=FAdoConn;
  
end;

function TMyDataClass.DeleteRecord(ads_Tmp: TADODataSet; FieldName: string;
  FieldValue: variant): boolean;
begin
  ads_Tmp.Locate(FieldName,FieldValue,[loCaseInsensitive ]);//���ҵļ�¼��ֵ������ȫƥ��
  ads_Tmp.Delete;
  result :=SaveData(ads_tmp,true); //ɾ���󱣴浽���ݿ�
end;

destructor TMyDataClass.Destroy;
begin

  inherited;
end;

function TMyDataClass.ExecProc(ProcName: string;
  var ParamStrs: array of variant; Direction: array of TParameterDirection): boolean;
var
  ADOStoredProc: TADOStoredProc;
  i: integer;
  Save_Cursor: TCursor;
begin
  Save_Cursor := Screen.Cursor;
  ADOStoredProc := TADOStoredProc.Create(application);
  try
    try
      screen.cursor := crsqlwait;
      ADOStoredProc.Connection := FAdoconn;//FAdoConnection;
      ADOStoredProc.ProcedureName := ProcName;
      for i := 0 to length(ParamStrs) - 1 do
      begin
        ADOStoredProc.Parameters.AddParameter;
        ADOStoredProc.Parameters.Items[i].Direction := Direction[i];
        if VarIsStr(ParamStrs[i]) then //�����ַ��Ͳ������ֶ����ã������������Ǻ��֣��ᷢ��ֻ�ܴ����������ֳ��ȵ��ַ���
        begin
           ADOStoredProc.Parameters.items[i].DataType := ftString;
           ADOStoredProc.Parameters.items[i].Size := 50;
        end;
        ADOStoredProc.Parameters.Items[i].Value := ParamStrs[i];
      end;
      ADOStoredProc.ExecProc;
      for i := 0 to length(Direction) - 1 do
        ParamStrs[i] := ADOStoredProc.Parameters.Items[i].Value;
      result := true;
    except
      result := false;
    end;
    screen.cursor := Save_Cursor;
  finally
    ADOStoredProc.free;
  end;
end;

function TMyDataClass.ExecSql(Sqlstr: string): boolean;
begin
  try
    acmd.CommandText := sqlstr;
    acmd.Execute;
    result := true;
  except
    result := false;
//    ShowMsg('���ݲ���ʧ�ܣ�����','��ʾ',1);
  end;
end;

function TMyDataClass.OpenQuery(Sqlstr: string): boolean;
begin
  result := false;
  aqTmp.close;
  aqTmp.SQL.Clear;
  aqTmp.SQL.Add(sqlstr);
  aqTmp.EnableBCD := False;
  try
    aqTmp.Open;
    result := true;
  except
    showmessage('����:'+sqlstr);
    abort;
//    Application.MessageBox('���ݱ��ʧ�ܣ�����','��ʾ',mb_ok);
  end;
end;


function TMyDataClass.Get_Sql_Value(sqlstr: string): variant;
begin
  if OpenQuery(sqlstr) then
    result := aqTmp.Fields[0].Value;
end;

function TMyDataClass.OpenQuery(Query: TAdoQuery; Sqlstr: string): boolean;
begin
  try
    Query.Close;
    Query.Sql.Clear;
    Query.SQL.Add(sqlstr);
    Query.Open;
    result := true;
  except
    result := false;
//    Application.MessageBox('���ݱ��ʧ�ܣ�����','��ʾ',mb_ok);
  end;
end;

function TMyDataClass.SaveData(ads_Tmp: array of TADODataSet;
  pTrans: Boolean): boolean;
var
  i:integer;
begin
  try
    if pTrans then //�������񣬱��뱣֤���е�dataset����һ��adoconnection
      if not ads_Tmp[0].Connection.InTransaction then
        ads_Tmp[0].Connection.BeginTrans;
   //�������ݸ���
    for i := low(ads_Tmp) to high(ads_Tmp) do
      ads_Tmp[i].UpdateBatch(arall);

    if pTrans then
      ads_Tmp[0].Connection.CommitTrans; //�ύ����,
    result := true;
  except
    if pTrans then
      ads_Tmp[0].Connection.RollbackTrans;//�ع�����
    result := false;
  end;
end;

function Is_NUll(Input_value,Output_Value:variant):variant;  //�жϴ������ֵ�Ƿ���NULL��������һ��ָ������ֵ
begin
  if VarIsNull(Input_Value) then
//  if Input_value = null then
    result := OutPut_value
  else
    result := Input_value;
end;

function TMyDataClass.IsExists(Sqlstr: string): boolean;
begin
  try
    OpenQuery(sqlstr);
  except
    showmessage(sqlstr);
    abort;
  end;

  result := not aqTmp.IsEmpty;
  aqTmp.Close;
end;

function TMyDataClass.OpenDataSetByPara(InPara: variant;
  adsTmp: TadoDataSet): boolean;
begin
  try
    adsTmp.Close;
    adsTmp.Parameters[0].Value := InPara;
    adsTmp.open;
    result := true;
  except
    result := false;
  end;
end;

function TMyDataClass.UpdateValueToField(pDataSet: TDataSet;
  value: variant; FieldName: string): boolean;
var
  BookMark:Tbookmark;
begin
  try
    BookMark:=pDataSet.GetBookmark;
    pDataSet.EnableControls;
    try
      pDataSet.First;
      while not pDataSet.Eof do begin
        pDataSet.Edit;
        pDataSet.FieldByName(FieldName).Value := Value;
        pDataSet.Post;
        pDataSet.Next;
      end;
      result := true;
      if BookMark <> nil then
        pDataSet.GotoBookmark(BookMark);
    except
      result := false;
    end;
  finally
    pDataSet.FreeBookmark(Bookmark);
    pDataSet.EnableControls;
  end;
end;

function TMyDataClass.OpenDataSet(DataSet: TADoDataSet;
  Sqlstr: string): boolean;
begin
  with DataSet do
  try
    Close;
    CommandText:=Sqlstr;
    Open;
    Result:=True;
  except
    Result:=False;
  end;
end;

procedure TMyDataClass.DeleteTable(DataSet: TDataSet);
begin
  try
    DataSet.DisableControls;
    try
      DataSet.First;
      while not DataSet.Eof do
        DataSet.Delete;
    except
      DataSet.EnableControls;
      Raise;
    end;
  finally
    DataSet.EnableControls;
  end;
end;

function TMyDataClass.ExecProc(ADOStoredProc: TADOStoredProc; ProcName: string;
  var ParamStrs: array of variant;
  Direction: array of TParameterDirection;ExecType:byte): boolean;
var
  i: integer;
  Save_Cursor: TCursor;
begin
    Save_Cursor := Screen.Cursor;
    try
      screen.cursor := crsqlwait;
      ADOStoredProc.Connection := FAdoconn;//FAdoConnection;
      ADOStoredProc.ProcedureName := ProcName;
      for i := 0 to length(ParamStrs) - 1 do
      begin
        ADOStoredProc.Parameters.AddParameter;
        ADOStoredProc.Parameters.Items[i].Direction := Direction[i];
        if VarIsStr(ParamStrs[i]) then //�����ַ��Ͳ������ֶ����ã������������Ǻ��֣��ᷢ��ֻ�ܴ����������ֳ��ȵ��ַ���
        begin
           ADOStoredProc.Parameters.items[i].DataType := ftString;
           ADOStoredProc.Parameters.items[i].Size := 500;
        end;
        ADOStoredProc.Parameters.Items[i].Value := ParamStrs[i];
      end;
      if ExecType = 1 then
        ADOStoredProc.ExecProc
      else
        ADOStoredProc.open;
      for i := 0 to length(Direction) - 1 do
        ParamStrs[i] := ADOStoredProc.Parameters.Items[i].Value;
      result := true;
    except
      result := false;
    end;
    screen.cursor := Save_Cursor;
end;


function TMyDataClass.ExecSql(Sqlstr: string; pTrans: boolean): boolean;
begin
  try
    if pTrans then
      if not acmd.Connection.InTransaction then
        acmd.Connection.BeginTrans;
      acmd.CommandText := sqlstr;
      acmd.Execute;
      if pTrans then
        acmd.Connection.CommitTrans;
      result := true;
    except
      if pTrans then
        acmd.Connection.RollbackTrans;
      result := false;
    end;
end;

function TMyDataClass.ChangeFieldValue(pDataSet: TDataSet; Oldvalue,
  NewValue: variant; FieldName: string): boolean;
var
  BookMark:Tbookmark;
  IsFilter:boolean;
begin
  try
    BookMark:=pDataSet.GetBookmark;
    pDataSet.EnableControls;
    IsFilter:= pDataSet.Filtered;
    if IsFilter then
      pDataSet.Filtered:= false; 
    try
      pDataSet.First;
      while not pDataSet.Eof do begin
        if pDataSet.FieldByName(FieldName).Value = OldValue then
        begin
          pDataSet.Edit;
          pDataSet.FieldByName(FieldName).Value := NewValue;
        end;
        pDataSet.Next;
      end;
      result := true;
      if BookMark <> nil then
        pDataSet.GotoBookmark(BookMark);
    except
      result := false;
    end;
    if IsFilter then
    begin
      pDataSet.Filter := FieldName+'='+VarAsType(NewValue,varstring);
      pDataSet.Filtered := true;
    end;
  finally
    pDataSet.FreeBookmark(Bookmark);
    pDataSet.EnableControls;
  end;
end;

function TMyDataClass.Check_Unique_Field_Value(sqlstr: string): boolean;
begin
  result:= not IsExists(sqlstr);
end;

procedure TMyDataClass.Set_Filter(str_filter: string;
  DataSEt: TDATASET);
begin
  DataSet.Filtered := false;
  DataSet.Filter := str_filter;
  DataSet.Filtered := true;
end;

{ TFormula_Verify }

constructor TFormula_Verify.Create(AdoConn: TAdoConnection);
var
  Sqlstr:string;
begin
//����������Ӻ����ݲ����齨
//  FAdoConn := TADoConnection.Create(AdoConn);
  FAdoConn := AdoConn;
  aqTmp1 := TADoQuery.Create(nil);  //adoquery������sql���ݲ�ѯ
  aqTmp1.Connection :=FAdoConn;
  //�򿪹��̲�����
  Sqlstr:= ' select data0278.rkey,data0278.PARAMETER_NAME,data0278.parameter_desc,data0278.data_type, '+
           ' data0278.spec_rkey,data0277.category_name,data0277.category_type,data0278.sequence_no '+
           ' from data0278,data0277 where data0278.category_ptr=data0277.rkey and category_type <> 1 '+
           ' order by data0277.category_type,data0277.category_name,DATA0278.parameter_name ';

//  Sqlstr:= ' select Unit_Code as parameter_name,data_type from data0429 order by unit_code ';


  MyDataClass.OpenQuery(aqTmp1,Sqlstr);

//��data0280��
  aqTmp2 := TADoQuery.Create(nil);  //adoquery������sql���ݲ�ѯ
  aqTmp2.Connection :=FAdoConn;
//  Sqlstr:= ' select * from data0280 ORDER by Eng_table_name ';

  Sqlstr:=' select *, FXY=IsNull(Eng_table_name,'''')+'+QuotedStr('( ')+'+ rtrim(IsNull((select Parameter_name from data0278 where rkey=M.FX),''''))+'+QuotedStr(' , ')+'+'+
          ' rtrim(IsNull((select Parameter_name from data0278 where rkey=M.FY),'+QuotedStr('1')+'))+'+QuotedStr(' )')+
          ' from data0280 M order by Eng_table_name ';
  MyDataClass.OpenQuery(aqTmp2,Sqlstr);
{  DataBase := TDataBase.Create(nil);
  DataBase.DatabaseName := 'KMERPKEY';
  DataBase.AliasName := 'KMERP_KEY';
  DataBase.ReadOnly := true;
  DataBase.LoginPrompt := false;
  DataBase.Connected := true;
  Query1 := TQuery.Create(nil);
  Query1.DatabaseName :='KMERPKEY';}
  ExprCalc:= TBdsProc.Create();
end;

destructor TFormula_Verify.Destroy;
begin
  aqTmp1.Free;
  aqTmp2.Free;
//  DataBase.Free;
//  Query1.Free;
  ExprCalc.Free;
  inherited;
end;

function TFormula_Verify.Verify(Input_str: string): boolean;
var
  tmp_sql:string;
begin
  result := false;
  if trim(Input_str)<>'' then
  begin
    if pos(' XXXXYYYY ',Input_str)>0 then  
    begin
      Application.MessageBox('XXXXYYYY'+'��ϵͳ��������,�벻Ҫʹ�ø�������Ϊ�û���������','��ʾ',mb_ok);
      exit;
    end;
    tmp_sql:= verify_step_one(Input_str+' >0');
    if Pos('SELECT',UPPERCASE(TMP_SQL))>0 THEN
      result := Check_VFP_Sql(tmp_sql)
    ELSE
      result := Check_VFP_Sql('select * from key where ' +verify_step_one(Input_str+' >0'));

    if result = false then
    begin
      tmp_sql:= verify_step_one(Input_str+' >"0"');
      if Pos('SELECT',UPPERCASE(TMP_SQL))>0 THEN
        result := Check_VFP_Sql(tmp_sql)
      ELSE
        result:= Check_VFP_Sql('select * from key where '+verify_step_one(Input_str+' >"0"'));

      if result=false then
        Application.MessageBox('���㹫ʽ�趨����ȷ! ��ע��ù�ʽֻ������ȫ�ֲ����͹��̱���','��ʾ',1);
    end;
  end
  else  //*************���ַ�����ʱͨ����֤****************
    result := true;
end;

function TFormula_Verify.verify_Step_One(Input_str: string): string;
const
  Int_Type= ' 2 ';
  Str_Type= ' ''X'' ';
var
  i,j,j0,j1,j2:integer;
  vstring1,vstring2:string;
  Expr1,Expr2,Expr3:string;
begin
  Input_str:=' '+Input_str+' ';

  Input_str:= StringReplace(Input_str,' PROJECT ',Str_Type,[rfReplaceAll]);

  Input_str:= StringReplace(Input_str,' CP_REV ',Str_Type,[rfReplaceAll]);

  Input_str:= StringReplace(Input_str,' CUST_CODE ',Str_Type,[rfReplaceAll]);

  //��֤���̲�����
  aqTmp1.Open;
  aqTmp1.First;
  while not aqTmp1.Eof do
  begin
  //���������������ֵ�ͣ���ô���� ' 2' ���滻������������ַ��ͣ���ô�� ' ''X'' '�������
    if aqTmp1.FieldByName('data_type').AsInteger=1 then
      Input_str:= StringReplace(Input_str,' '+trim(Is_Null(aqTmp1.fieldbyname('parameter_name').asstring,''))+' ',Int_Type,[rfReplaceAll])
    else
      Input_str:= StringReplace(Input_str,' '+trim(Is_Null(aqTmp1.fieldbyname('parameter_name').asstring,''))+' ',Str_Type,[rfReplaceAll]);

    aqTmp1.next;
  end;
  aqTmp1.close;
  
  while POS('SUBS[',Input_str)>0 do  //��ȡSUBS��������    �ַ���ʽΪ' ABC SUBS[Expr1,Expr2,Expr3] '
  begin
    i:=POS('SUBS[',Input_str);
    j:=POS(',',COPY(Input_str,i+5,length(Input_str)-5-i+1)); //��ȡ'subs['���һ��','��λ��
    j0:=POS(',',COPY(Input_str,i+5+j,length(Input_str)-j-5-i+1)); //��ȡ'subs['��ڶ���','��λ��
    j1:=POS(']',copy(Input_str,i+5+j+j0,length(Input_str)-j0-j-5-i+1)); //��ȡ'subs['���1��']'��λ��



    Expr1:= copy(Input_str,i+5,j-1); //��ȡ'Subs['���һ��','֮ǰ�ı��ʽ����
    Expr2:= copy(Input_str,i+5+j,j0-1); //��ȡ'Subs['��ڶ���','֮ǰ�ı��ʽ����
    Expr3:= copy(Input_str,i+5+j+j0,j1-1); //��ȡ'Subs['�ں����','֮��ı��ʽ����
//�жϵ�һ�����ʽ�Ƿ���Ч ��VFP��֤��

    if not Check_VFP_Sql('select * from key where '+Expr1+'>''a''') then //���ʽ����
    begin
      Input_str:= '1+x'; //���⸳������ȷ�ı��ʽ
      result := Input_str;
      exit;
    end;
//�жϵڶ������ʽ�Ƿ���Ч
    if not Check_VFP_Sql('SELECT '+Expr2+' as vqty from key') then //���ʽ����
    begin
      Input_str:= '1+x'; //���⸳������ȷ�ı��ʽ
      result := Input_str;
      exit;
    end;

//�жϵ��������ʽ�Ƿ���Ч
    if not Check_VFP_Sql('SELECT '+Expr3+' as vqty from key') then //���ʽ����
    begin
      Input_str:= '1+x'; //���⸳������ȷ�ı��ʽ
      result := Input_str;
      exit;
    end;
//���ַ���Ϊ2����A+B����A"X"B����ʽ�����
    Input_Str:=copy(Input_Str,1,i-1)+'''x'''+copy(Input_str,i+5+j+j0+j1,length(Input_str)-i-j-j0-j1-5+1);
  end;

 //�򿪹��̱�����֤

  if not aqTmp2.Active then
  aqTmp2.Open ;
  aqTmp2.first;
  with aqTmp2 do
//  Tmp_str:=
  for i:=0 to recordcount-1 do
  begin
    while pos(trim(fieldbyname('Eng_table_name').asstring)+'(',Input_Str)>0 do//���һ�����������˶�ξ�ͨ�����ѭ����һ����
    begin
      j:=pos(trim(fieldbyname('Eng_table_name').asstring)+'(',Input_Str); //��ȡ��һ������+'('��λ�ã��磺'2���('
      j0:=pos('(',copy(Input_Str,j,length(Input_Str)-j));  //��ȡ��һ���������'('λ��
      j1:=pos(',',copy(Input_Str,j,length(Input_Str)-j));  //��ȡ��һ���������','��λ��
      j2:=pos(')',copy(Input_Str,j,length(Input_Str)-j)); //��ȡ��һ���������')'��λ��
      vstring1:=copy(Input_Str,1,j-1);           //��ȡ����������߲����磺   'AAA 2���('��'AAA'����
      vstring2:=copy(Input_Str,j+j2,500-j-j2);      //��ȡ���������ұ߲���
      if fieldbyname('data_type').asInteger=1 then
      //�ѹ�ʽ�ֽ�Ϊ3���֣�ǰһ����Ϊ������߲��֣��м��ټ���' 2+ '���Լ��������'BBB'����
      //Sum(BBB,DDD); ' 2+ BBB+DDD
        Input_Str:=vstring1+' 2+ '+copy(Input_Str,j+j0,j1-j0-1)+'+'+copy(Input_Str,j+j1,j2-j1-1)+vstring2
      else
      if fieldbyname('data_type').asInteger=2 then
      begin
//        �Ա�BBB���ֵģ���һB���͵����һ��B�Ƿ��ǿ�ֵ
        if (copy(trim(copy(Input_Str,j+j0,j1-j0-1)),1,1)='''') and (copy(trim(copy(Input_Str,j+j0,j1-j0-1)),length(trim(copy(Input_Str,j+j0,j1-j0-1))),1)='''') then
        //�Ա�DDD���ֵĵ�һ��D,�͵����һ��D�Ƿ��ǿ�ֵ
          if (copy(trim(copy(Input_Str,j+j1,j2-j1-1)),1,1)='''') and (copy(trim(copy(Input_Str,j+j1,j2-j1-1)),length(trim(copy(Input_Str,j+j1,j2-j1-1))),1)='''') then
            Input_Str:=vstring1+' 2 '+vstring2
          else
            Input_Str:=vstring1+' 2+ ''2''+'+copy(Input_Str,j+j1,j2-j1-1)+vstring2
        else
            Input_Str:=vstring1+' 2+ ''2''+'+copy(Input_Str,j+j1,j2-j1-1)+vstring2;
      end else
      if fieldbyname('data_type').asInteger=3 then
        Input_Str:=vstring1+' ''2''+ '+copy(Input_Str,j+j0,j1-j0-1)+'+'+copy(Input_Str,j+j1,j2-j1-1)+vstring2;
    end;
    next;
  end;

  if POS('IF(',Input_Str)>0 then
    result :=Verify_IF(Input_Str)
  else
    result := Input_Str;
end;

function TFormula_Verify.Verify_IF(vstring: string): string;
//var
//  i,j,j0,j1:integer;
begin
{  vstring:=' '+vstring+' ';
  while POS('IF(',vstring)>0 do
  begin
    i:=POS('IF(',vstring);
    j:=POSSS(i,',',vstring);
    j0:=POSS(',',vstring)-j;
    j1:=POS(')',copy(vstring,j+j0+1,length(vstring)-j-j0));
    try    //����IF������������ֵ1������ֵ2���������������ʽ�Ƿ�Ϸ�
      Check_VFP_Sql('select * from key where '+copy(vstring,i+3,j-i-3));
    except
      result := '';//������֤��
      exit;
    end;
    if not Query1.IsEmpty then
    begin
      try    //����IF������������ֵ1������ֵ2�������ķ���ֵ1�Ƿ���Ч
        Check_VFP_Sql('SELECT '+copy(vstring,j+1,j0-1)+' as vqty from key');
      except
        result := '';//������֤��
        exit;
      end;
    end else
    begin
      try    //����IF������������ֵ1������ֵ2�������ķ���ֵ1�Ƿ���Ч
        Check_VFP_Sql('SELECT '+copy(vstring,j+1,j0-1)+' as vqty from key');
      except
        result := '';//������֤��
        exit;
      end;
    end;
    vstring:=copy(vstring,1,i-1)+Query1.fieldbyname('vqty').asstring+copy(vstring,j+j0+j1+1,length(vstring)-j-j0-j1);
  end;
  result := 'SELECT '+vstring+' as vqty from key';}
end;

function TFormula_Verify.poss(vstr1, vstr2: string): integer;
var i:integer;
  vstr:string;
begin
  //�ú����Ĳ�����vstr1��û���õ�����ע��
  //������������ֵΪ��vstr2='AB,CDE)'����ô����AAA���֣�
  //���ţ���AB,CDE�жϣ����֮����','��ô�ͷ��ش��ұ����ĵ�һ��λ��
  vstr:=copy(vstr2,1,pos(')',vstr2)-1);
  for i:= length(vstr) downto 1 do
  if copy(vstr,i,1)=',' then
  begin
    Break;
  end;
  Result:=i;
end;

function TFormula_Verify.posss(vs: integer; vstr1, vstr2: string): integer;
var i:integer;
  vstr:string;
begin
  //����vstr2����ָ��λ�õ�')'֮ǰ����.�磺ABC,DE),��2��ʼ�Ĳ���:BC,DE
  vstr:=copy(vstr2,vs,pos(')',vstr2)-1);
  for i:= length(vstr) downto 1 do
  //���ƴ����ҵģ�һֱ�����һ��')'֮ǰ����,�磺BC
    if copy(vstr,i,1)=',' then
    begin
      vstr:=copy(vstr,1,i-1);
      break;
    end;
  //
  for i:= length(vstr) downto 1 do
    if copy(vstr,i,1)=',' then
    begin
      Break;
    end;
  Result:=i+vs-1;
end;

function TFormula_Verify.Check_VFP_Sql(Sqlstr: string): boolean;
begin
//  try
//    Query1.Close;
//    Query1.SQL.Clear;
//    Query1.SQL.Add(sqlstr);
//    Query1.Open;
//    result := true;
//  except
    result := false;
//  end;
end;

function TFormula_Verify.Get_If_Expr(strExpr: string): string;
var
  i,P3:integer;
  StrTmp,strLeft,strRight,TmpExpr:string;
begin
  //AB if(C>D,2,3)*if(E>F,4,5)/6+2
//If�Ϸ����ʽ: IF(<Expr>,A,B),���Expr����Ϊtrue������A,����ΪB,Ŀǰ��ʽ��֤�ķ����ǣ�
//1�������Ƿ���If������У���ô���ƴ�If��ʼ�ĺ�����ַ�������¼Ifǰ�Ĳ���
//2���������һ��IF'('���ֺ��λ�ã�ȡ��һ���͵ڶ���','��λ�ã�����ȡ��Ӧ���ֵ���ֵ
//3����ȡ�ڶ���','��ĵ�һ��')'�ŵ���ֵ���Լ�֮����ַ���
//4�������һ��Expr������дһ������������Expr�����������ֵΪtrue������A,���򷵻�B
//5���ϲ�If֮ǰ��if���ʽ������ַ����ϲ�if���ʽ����ַ�������
//6�����If���滹��һ��if����ô�ݹ���㡣
//  strExpr:=StringReplace(uppercase(strExpr),' ','',[rfReplaceAll]);
  i:=Get_Last_Phrase_Pos('IF',strExpr);
  if i >0 then //�ҵ���IF
  begin
    strLeft:= copy(strExpr,1,i-1); //��ȡIf��ߵ��ַ�
    strTmp:= copy(strExpr,i,100000); //��ȡif�ұߵ��ַ�
//    P3:= Get_PosOfPhrase_Num(')',copy(strTmp,P2+1,100000),1)+P2;//��ȡ��һ��')'��λ��
    P3:=Get_PosOfbracket(copy(strTmp,Pos('(',strTmp)+1,100000))+Pos('(',strTmp);

    strRight:=Copy(strTmp,P3+1,100000);//��ȡIF(<Expr>,A,B)�������

    TmpExpr:=copy(strTmp,1,P3);//��ȡIF(<Expr>,A,B)���ʽ������
    if Pos('IF(',TmpExpr)=0 then
    begin
      Application.MessageBox('IF���ʽ����,"IF"��"("֮�䲻���пո�','��ʾ',mb_OK);
      abort;
    end;
    strExpr:=strLeft+' ' +Calc_If_Expr(TmpExpr)+' '+strRight;
    if Get_Last_Phrase_Pos('IF',uppercase(strExpr))>0 then
      result := Get_If_Expr(strExpr)
    else
      result := strExpr;
  end
  else
  begin
    result := strExpr;
    exit;
  end;
end;

function TFormula_Verify.Calc_If_Expr(strExpr: string): string;
var
  i,j,P1,P2,P3:integer;
  strLeft,TmpExpr,partA,partB:string;
  DataType:byte;//��������1:���֣�2:�ַ�
  Rslt:boolean;
begin
  P1:= Get_PosOfPhrase_Num(',',strExpr,1);//��ȡ��һ��','��λ��
  P2:= Get_PosOfPhrase_Num(',',strExpr,2);//��ȡ�ڶ���','��λ��
//  P3:= Get_PosOfPhrase_Num(')',copy(strExpr,P2+1,100000),1)+P2;//��ȡ��һ��')'��λ��
  P3:=Get_PosOfbracket(copy(strExpr,Pos('(',strExpr)+1,100000))+Pos('(',strExpr);
  j:=Get_PosOfPhrase_Num('(',strExpr,1);//��ȡ��һ��'('λ��
  TmpExpr:=copy(strExpr,j+1,P1-j-1);//��ȡExpr����
  partA:=copy(strExpr,P1+1,P2-1-P1); //��ȡIF(<Expr>,A,B)���ʽ A������
  partB:=copy(strExpr,P2+1,P3-P2-1);//��ȡIF(<Expr>,A,B)���ʽ B������
  i:=Pos_OF_Operator(tmpExpr);
  if i > 0 then
  begin
    StrLeft:=trim(copy(TmpExpr,1,i-1));
{    Rslt := ((StrLeft = trim(Int_Type)) or  (StrLeft = trim(Str_Type)));
    if not rslt then
    begin
      Application.MessageBox(PChar(strLeft+'������ȷ�Ĳ���,����'),'��ʾ',mb_OK);
      abort;
    end;}
    
  end
  else
  begin
    Application.MessageBox(Pchar(TmpExpr+'������ȷ�ı��ʽ,����'),'��ʾ',mb_OK);
    abort;
  end;
  rslt :=MyDataClass.IsExists('select 2 where '+TmpExpr);
  (*
  intLen := 1;
  N:=0;
  while (n <= Length(TmpExpr))  do
  begin
    case TmpExpr[N] of
      '<' : begin
              if TmpExpr[N + 1] = '>' then
              begin
                Op := opUnequal;
                intLen := 2;
              end else
                if TmpExpr[N + 1] = '=' then
                begin
                  Op := opLessOrEqual;
                  intLen := 2;
                end else
                  Op := opLess;
                break;
              end;
      '>' : begin
              if TmpExpr[N + 1] = '=' then
              begin
                Op := opGreaterOrEqual;
                intLen := 2;
              end else
                Op := opGreater;
              break;
            end;
      '=' : begin
              Op := opEqual;
              break;
            end;
    end;
    inc(N);
  end;

//
  if N = Length(TmpExpr)+1 then
  begin
    Application.MessageBox(Pchar('IF���ʽ����,ȱ���߼��������,����'),'��ʾ',mb_Ok);
    abort;
  end;
  strLeft:=De_Bracket(uppercase(trim(copy(TmpExpr,1,N-1))));
  strRight:=De_Bracket(uppercase(trim(copy(TmpExpr,N+IntLen,100000))));

{  if trim(strLeft) = trim(Int_Type) then
    DataType:= 1
  else if trim(strLeft) = trim(Str_Type) then
    DataType:= 2
  else
  begin
    Application.MessageBox(Pchar('����: '+strLeft+' ��Ч,��ȷ��'),'��ʾ',1);
    abort;
  end;}
//�ж��ֶ��������ͻ����ַ���  //�ж�strleft�����������ͣ�
  DataType :=Judge_Data_Type(strLeft);
  if DataType = 3 then
  begin
    Application.MessageBox(Pchar('���ʽ '+strLeft+' ��Ч,����'),'��ʾ',mb_Ok);
    abort;
  end;

  DataType2 :=Judge_Data_Type(strRight);
  if DataType = 3 then
  begin
    Application.MessageBox(Pchar('���ʽ '+strRight+' ��Ч,����'),'��ʾ',mb_Ok);
    abort;
  end;
  if DataType <> DataType2 then
  begin
    Application.MessageBox(Pchar('�������Ͳ�һ��,����'),'��ʾ',mb_Ok);
    abort;
  end;

//�������������֣���ô���ʽ����Ҫ����һ��
  if DataType = 1 then
  begin
    strLeft:= ExprCalc.PublicExplain(strleft);
    strRight:= ExprCalc.PublicExplain(strRight);
  end
  else
  begin
{    if trim(strLeft) = trim(Int_Type) then
      DataType:= 1
    else }if (trim(strLeft) = trim(Str_Type)) or (trim(strRight) = trim(Str_Type)) then
      DataType:= 2
    else
    begin
      Application.MessageBox(Pchar(strLeft+' �� '+strRight+' ������һ��Ϊ����,��ȷ��'),'��ʾ',mb_OK);
      abort;
    end;
  end;

  case Op of
    opGreater : case DataType of
                       1: Rslt := (StrToFloat(strLeft) > StrToFloat(strRight));
                       2: Rslt := strLeft > strRight;
                end;

    opGreaterOrEqual : case DataType of
                       1: Rslt := StrToFloat(strLeft) >= StrToFloat(strRight);
                       2: Rslt := strLeft >= strRight;
                end;
    opLess : case DataType of
                       1: Rslt := StrToFloat(strLeft) < StrToFloat(strRight);
                       2: Rslt := strLeft < strRight;
                end;
    opLessOrEqual : case DataType of
                       1: Rslt := StrToFloat(strLeft) <= StrToFloat(strRight);
                       2: Rslt := strLeft <= strRight;
                end;
    opEqual : case DataType of
                       1: Rslt := StrToFloat(strLeft) = StrToFloat(strRight);
                       2: Rslt := strLeft = strRight;
                end;
    opUnequal : case DataType of
                       1: Rslt := StrToFloat(strLeft) <> StrToFloat(strRight);
                       2: Rslt := strLeft <> strRight;
                end;
  end;
  *)
  DataType :=Judge_Data_Type(partA); 

  if DataType = 1 then  //�ж���������
  begin
    if not MyDataClass.OpenQuery('select 1.0*'+ PartA + ' AS Ret') then
      Exit;
    partA:= MyDataClass.aqTmp.FieldByName('Ret').AsString;

    if not  MyDataClass.OpenQuery('select 1.0*'+ PartB + ' AS Ret') then
      exit;
    partB:= MyDataClass.aqTmp.FieldByName('Ret').AsString;
    //----�������IF��������ԭ��δ֪ ע�͵�2017-7-28
//    partA:= ExprCalc.PublicExplain(partA);
//    partB:= ExprCalc.PublicExplain(partB);

  end;
  if Rslt then
    result := partA
  else
    result := partB;
end;

function TFormula_Verify.Get_Last_Phrase_Pos(strPhrase,
  strExpr: string): integer;
var
  i:integer;
  A:Char;
begin
  i:=0;
  A:=' ';
  strExpr:=uppercase(strExpr);
  while Pos(strPhrase,strExpr)>0 do
  begin
    i := Pos(strPhrase,strExpr);
    strExpr:=stringReplace(strExpr,strPhrase,stringofChar(A,Length(strPhrase)),[]);
  end;
  result := i;  
end;

function TFormula_Verify.Get_PosOfPhrase_Num(strPhrase, strExpr: string;
  Num: integer): integer;
  var
  i,j:integer;
  A:Char;
begin
  i:=0;j:=1;
  A:=' ';
  strExpr:=uppercase(strExpr);
  while Pos(strPhrase,strExpr)>0 do
  begin
    i := Pos(strPhrase,strExpr);
    strExpr:=stringReplace(strExpr,strPhrase,stringofChar(A,Length(strPhrase)),[]);
    if j= Num then //�ڼ��γ���
      break;
    inc(j);
  end;
  result := i;  
end;

function TFormula_Verify.Get_PosOfbracket(strExpr: string): integer;
var
  TmpInc,n:integer;
begin
  n:=1;
  result :=-1;
  TmpInc:=1;
  while n <= Length(strExpr) do
  begin
    case strExpr[N] of
      '(' : inc(TmpInc);
      ')' : dec(TmpInc);
    end;
    if TmpInc=0 then
    begin
      result := n;
      break;
    end;
    Inc(n);
  end;
  if TmpInc<>0 then
    result :=-1;//û�ҵ�

end;

//----------------------- ExprCalc---------------------------


constructor TPUSHPOP.Create;
begin
inherited create;
end;

function TBdsProc.IsCalcFh(c: char): boolean;
begin
  if c in ['+','-','*','/'] then
    Result := True
  else
    Result := False;
end;

function TBdsProc.CopyRight(abds: String;start: Integer):String;//��ȡ�ַ������ʽ
begin
  Result := Copy(abds,start,(length(abds)-1));
end;

function TBdsProc.BdsItm(var abds: String): Double;//��ȡ���ʽ�е�һ������
var
  i,j,k,OldJ,iPoint,KHCount: integer;
  sCount : real;
  IsInt: boolean;
  sValue: Array[0..20] of string;
  sXiShu: Array[0..20] of real;
  s,c,HSName,HSIn: string;
  fArray : Array[1..20] of real;
  fMin,fMax,fAll : real;
begin
  //����Ϊ����ʱ
  iPoint:=0;
  c := abds[1];
  if ((c>='a') and (c<='z')) or ((c>='A') and (c<= 'Z')) then
  begin
    k := 0;

    HSName := Copy(abds,1,3);
   //Jacky Zhong 2007-1-27:�����жϣ�������� Min,Max,avg��������ô����
    if (LowerCase(HSName) = LowerCase('Min')) or ( LowerCase(HSName) = LowerCase('Max') ) or( LowerCase(HSName) = LowerCase('Avg') ) then
    begin

      abds := copy(abds,5,length(abds)-4);
      While abds <> '' do
      begin
        c := abds[1];
        i := 1;
        KHCount := 0;
        while c <> ',' do
        begin
          if c='(' then inc(KHCount);
          if c=')' then dec(KHCount);
          if KHCount = -1 then Break;   //��ȡ���������һ������ʱ,����������')'ʱ�˳���ѭ��
          inc(i);
          c := copy(abds,i,1);
        end;
        inc(k);
        HSIn := '('+Copy(abds,1,i-1)+')';
        fArray[k] := BdsSs(HSIn);    //```````````` ����չ������Ƕ�׺���
        abds := copy(abds,i+1,length(abds)-i);
        if c <>',' then break;      //cΪ�����ŵ�ʱ�� �˳���ѭ��
      end;

      fMin := fArray[1];
      fMax := fArray[1];
      fAll := 0;
      for i:= 1 to k do
      begin
        if fArray[i] < fMin then fMin := fArray[i];
        if fArray[i] > fMax then fMax := fArray[i];
        fAll := fAll + fArray[i];
      end;
      if LowerCase(HSName) = LowerCase('Min') then Result := fMin
      else if LowerCase(HSName) = LowerCase('Max') then Result := fMax
      else if LowerCase(HSName) = LowerCase('Avg') then Result := StrToFloat(FormatFloat('#.0000',(fAll/k)))
      else raise Exception.Create('����������');
      Exit;
    end
    else
    begin
      raise Exception.Create('����������');
      Exit;
    end;
  end;

  //����Ϊ��ֵʱ````````````````````````
  j := 0;
  IsInt := True;
  for i:= 1 to Length(abds) do
  begin
    if ((abds[i] >= '0') and (abds[i] <= '9')) or (abds[i]='.') then
    begin
      j := j+1;
      if abds[i]= '.' then
      begin
        IsInt := False;
        iPoint := j;       //С��������λ��
      end;

      sValue[j] := copy(abds,i,1);
    end
    else
      break;
  end;

  OldJ := j;
  if IsInt then   //����Ϊ����
  begin
    k := 0;
    While j <> 0 do
    begin
      s:= '1';
      for i := 1 to j-1 do
      begin
        s := s + '0';
      end;
      K := k+1;
      sXiShu[k] := StrToFloat(s);
      j := j-1;
    end;
    sCount := 0;
    for j:=OldJ downto 1 do
    begin
      sCount := sXiShu[j]*strtoint(sValue[j]) + sCount;
    end;
    Result := sCount;
  end
  else
  begin
    j := OldJ;      //����Ϊ������
    While j <> 0 do
    begin
      if j > iPoint then
      begin
        s:= '1';
        for i:=1 to (j-iPoint-1) do
        begin
          s := '0' + s;
        end;
        s := '0.' + s;
      end;
      //if j = iPoint then k := k+1;
      if j < iPoint then
      begin
        s:= '1';
        for i:=1 to (iPoint-j-1) do
        begin
          s := s+ '0' ;
        end;  
      end;
      if j<>iPoint then sXiShu[j] := StrToFloat(s);
      j := j-1;
    end;
    sCount := 0;
    for j:=OldJ downto 1 do
    begin
      if j = iPoint then Continue;
      sCount := sXiShu[j]*strtoint(sValue[j]) +sCount;
    end;
    Result := sCount;
  end;
  abds := Copy(abds,(OldJ+1),(Length(abds)-OldJ));
end;

function TBdsProc.BdsSs(var abds: String): Double;
var
  c: Char;
  lpp: TPushPop;
begin
  lpp := TPushPop.Create;//�������ݼ������
  lpp.value[0] := 0;
  lpp.ffh[0] := '+';
  lpp.EndStep := False;
  while abds<>'' do
  begin
    c := abds[1];
    if IsCalcFh(c) then//�Ƿ������
    begin
      lpp.PushFh(c);//���������
      abds := CopyRight(abds,2);
    end
    else
    begin
      if c=')' then
      begin
        Dec(Fghpd);//����ƥ��
        abds := CopyRight(abds,2);
        if Fghpd < 0 then Raise Exception.Create('���Ų����');
        Result := lpp.CalcValue;
        //���������е�����ֵ��������һ������
        lpp.Free;
        Exit;
      end
      else
      begin
        if c='(' then Inc(Fghpd);//�����Ų�����ʶ
        lpp.PushValue(BdsYz(abds));//ȡ��һ���ֵ��
      end;
    end;
  end;
  if Fghpd<>0 then Raise Exception.Create('���Ų����');

  lpp.EndStep :=True;
  lpp.Calccur;
  Result := lpp.Value[1];
  lpp.Free;
end;

function TBdsProc.BdsYZ(var abds: String): Double;
begin
  Result:=0;
  if abds<>'' then
  begin
    if abds[1]='(' then
    begin
      abds := CopyRight(abds,2);
      Result := BdsSs(abds);//�ݹ���ã��������е�ֵ
    end
    else
      Result := BdsItm(abds);//��һ��������
  end;
end;

procedure TPUSHPOP.PushValue(avalue: Double);
begin
  if fisfh=True then Raise Exception.Create('ȱ�������');

  inc(flevel);//����λ��ָ���1
  value[flevel] := avalue;//����ֵ
  if flevel >2 then Calccur;//���ݸ����ﵽ4�������м�����

  fisfh := True;//������ſɼ�
end;

procedure TPUSHPOP.PushFh(afh: Char);
begin
  ffh[flevel] := afh;//���������
  fisfh := False;// ����ֵ�ɼ�
end;

procedure TPUSHPOP.Calccur;
begin
  if IsCcFh(ffh[1]) then//���������
  begin
    value[1] := Calcsj(value[1],value[2],ffh[1]);//����2��3���ֵ
    ffh[1] := ffh[2];//�����˷���ֵǰ��
    value[2] := value[3];
  end
  else//һ�������
  begin
    value[0] := Calcsj(value[0],value[1],ffh[0]);//����1��2���ֵ
    value[1] := value[2];
    value[2] := value[3];
    ffh[0] := ffh[1];
    ffh[1] := ffh[2];
  end;
  Dec(flevel);//����λ��ָ���1
  if EndStep then
  begin
    Value[1] := Calcsj(value[0],value[1],ffh[0]);
  end;
end;

function TPUSHPOP.Calcsj(av1,av2: Double;fh: Char): Double;//ִ��������ֵ����������
begin
  result := 0;
  if fh='+' then result := av1 + av2;
  if fh='-' then result := av1 - av2;
  if fh='*' then result := av1 * av2;
  if fh='/' then
  begin
    if av2 = 0 then
    begin
      Raise Exception.Create('��������Ϊ0');
      Exit;
    end
    else
      result := StrToFloat(FormatFloat('#.00000000',(av1 / av2)));
  end;
end;

function TPUSHPOP.IsCcFH(fh: Char): Boolean;// һ�����ų˳���ģ�����
begin
  if (fh='*') or (fh= '/') then
    Result := True
  else
    Result := False;
end;

function TPUSHPOP.CalcValue: Double;//���㲢����ֵ
begin
  if ffh[1] = '' then
  begin
    result := Calcsj(value[0],value[1],ffh[0]);   
    exit;
  end;
  if IsCcFh(ffh[1]) then//���������
  begin
    value[1] := Calcsj(value[1],value[2],ffh[1]);//����2��3���ֵ
    result := Calcsj(value[0],value[1],ffh[0]);
  end
  else
  begin
    value[1] := Calcsj(value[0],value[1],ffh[0]);
    result := Calcsj(value[1],value[2],ffh[1]);
  end;
end;

function TBdsProc.PublicExplain(sSource: string): String; //`````````````````�ӿ�```````````````
var
  TestClass: TBdsProc;
  First,Second,Primary: char;
begin
  if trim(sSource)='' then
    result :=''
  else
  begin
    sSource:= StringReplace(sSource,' ','',[rfReplaceAll]);
    TestClass := TBdsProc.Create;
    sNew := sSource;
    sEnd := sSource;
    NowPoint := 1;
    //�ȴ����һ���ַ�
    if (IsChar(sNew[1]) and (not IsChar(sNew[2]))) then
    begin
      ChangeString(sEnd,sNew,NowPoint,sNew[1]);
    end
    else
    begin
      Inc(NowPoint);
      //sNew := copy(sEnd,NowPoint,Length(sEnd)-NowPoint+1);
    end;

    While sNew <> '' do
    begin
      if Length(sNew)=2 then //�������һ���ַ�
      begin
        if IsChar(sNew[2]) then ChangeString(sEnd,sNew,NowPoint,sNew[2]);
        Break;
      end;
      // �����м���ַ�
      Primary := sNew[1];
      First := sNew[2];
      Second := sNew[3];
      if ((not IsChar(Primary)) and IsChar(First) and (not IsChar(Second))) then
      begin
        ChangeString(sEnd,sNew,NowPoint,First);
      end
      else
      begin
        Inc(NowPoint);
        sNew := copy(sEnd,NowPoint-1,Length(sEnd)-NowPoint+2);
      end;
    end;

    Result := format('%8.12f',[(TestClass.BdsSs(sEnd))]);
    TestClass.Free;
  end;
end;
//�ж��Ƿ���ĸ
function TBdsProc.IsChar(c: char):Boolean;
begin
  if ((c>='a') and (c<='z')) or ((c>='A') and (c<= 'Z')) then
    Result := True
  else
    Result := False;
end;




procedure TBdsProc.ChangeString(var sEnd, sNew: string; var Point: integer;
  sChar: char);
var
  i:integer;
begin
//i have no the original code of this function, below is filled up by myself
  if IsChar(sChar) then //�ַ�
  begin
    i:=Pos(sNew,sEnd);
    sNew:=copy(sNew,1,Point-i-1-1)+'2'+copy(sNew,point-i,length(sNew)-100000);
  end;
end;

function TBdsProc.CalcExpr(strExpr: string): double;
var
  TestClass: TBdsProc;
  First,Second,Primary: char;
begin
  strExpr:= StringReplace(strExpr,' ','',[rfReplaceAll]);
  TestClass := TBdsProc.Create;
  sNew := strExpr;
  sEnd := strExpr;
  NowPoint := 1;
  //�ȴ����һ���ַ�    
  if (IsChar(sNew[1]) and (not IsChar(sNew[2]))) then
  begin
    ChangeString(sEnd,sNew,NowPoint,sNew[1]);
  end
  else
  begin
    Inc(NowPoint);
    //sNew := copy(sEnd,NowPoint,Length(sEnd)-NowPoint+1);
  end;

  While sNew <> '' do
  begin
    if Length(sNew)=2 then //�������һ���ַ�
    begin
      if IsChar(sNew[2]) then ChangeString(sEnd,sNew,NowPoint,sNew[2]);
      Break;
    end;
    // �����м���ַ�
    Primary := sNew[1];
    First := sNew[2];
    Second := sNew[3];
    if ((not IsChar(Primary)) and IsChar(First) and (not IsChar(Second))) then
    begin
      ChangeString(sEnd,sNew,NowPoint,First);
    end
    else
    begin
      Inc(NowPoint);
      sNew := copy(sEnd,NowPoint-1,Length(sEnd)-NowPoint+2);
    end;
  end;

  Result := TestClass.BdsSs(sEnd);
  TestClass.Free;
end;

function TFormula_Verify.Judge_Data_Type(strExpr: string): integer;
var
  n : integer;
  booFound : boolean;
//  intParenteses : integer;
begin
  if Is_Logic_Operator(strExpr) then
  begin
    result := 4;
    exit;
  end;
  n := 1;
//  intParenteses := 0;
  result := 0;
  booFound := false;
  while (n <= Length(strExpr)) and (not booFound) do begin
    case StrExpr[N] of
      '(' : begin
//              inc(intParenteses);
              if strExpr[n+1] <> '(' then
                if strExpr[n+1] in ['0'..'9'] then
                begin
                  result := 1;//
                  booFound:= true;
                end
            end;
      ')' : ;// dec(intParenteses);
      '''': begin
              booFound:= true;
              result := 2;
            end;
      'A'..'Z', 'a'..'z' :
            begin
              booFound:= true;
              result := 3;
            end;
      '0'..'9': 
            begin
              booFound:= true;
              result := 1;
            end;
    end;
    Inc(n);
  end;
end;

function TFormula_Verify.De_Bracket(strExpr: string): string;
var
  n : integer;
  booFound : boolean;
  intParenteses : integer;
begin
  n := 1;
  intParenteses := 0;
  booFound := false;
  while (n <= Length(strExpr)) and (not booFound) do
  begin
    case StrExpr[N] of
      '(' : inc(intParenteses);
      ')' : dec(intParenteses);
    end;
    Inc(n);
  end;
  if intParenteses <>0 then
  begin
    strExpr := Stringreplace(strExpr,'(','',[rfReplaceAll]);
    strExpr := Stringreplace(strExpr,')','',[rfReplaceAll]);
  end;
  result :=strExpr;
end;

function TFormula_Verify.Replace_Expr_Factor(Input_str: string): string;
begin

  Input_str:= StringReplace(Input_str, #$D#$A, '', [rfReplaceAll]);

  Input_str:=' '+uppercase(Input_str)+' ';

  Input_str:= StringReplace(Input_str,' PROJECT ',Str_Type,[rfReplaceAll]);

  Input_str:= StringReplace(Input_str,' CP_REV ',Str_Type,[rfReplaceAll]);

  Input_str:= StringReplace(Input_str,' CUST_CODE ',Str_Type,[rfReplaceAll]);

 //�򿪹��̱����滻��ʽ�е���ֵ
//  Input_str:= StringReplace(Input_str,' ','',[rfReplaceAll]);
  if not aqTmp2.Active then
  aqTmp2.Open ;
  aqTmp2.first;
  while not aqTmp2.Eof do begin
    if aqTmp2.FieldByName('data_type').AsInteger=1 then
      Input_str:= StringReplace(Input_str,' '+trim(Is_Null(uppercase(aqTmp2.fieldbyname('FXY').asstring),''))+' ',Int_Type,[rfReplaceAll])
    else
      Input_str:= StringReplace(Input_str,' '+trim(Is_Null(uppercase(aqTmp2.fieldbyname('FXY').asstring),''))+' ',Str_Type,[rfReplaceAll]);

    aqTmp2.next;
  end;
  aqTmp2.close;


  //��֤���̲�����
  aqTmp1.Open;
  aqTmp1.First;
  while not aqTmp1.Eof do
  begin
  //���������������ֵ�ͣ���ô���� ' 2' ���滻������������ַ��ͣ���ô�� ' ''X'' '�������
    if aqTmp1.FieldByName('data_type').AsInteger=1 then
      Input_str:= StringReplace(Input_str,' '+trim(Is_Null(uppercase(aqTmp1.fieldbyname('parameter_name').asstring),''))+' ',Int_Type,[rfReplaceAll])
    else
      Input_str:= StringReplace(Input_str,' '+trim(Is_Null(uppercase(aqTmp1.fieldbyname('parameter_name').asstring),''))+' ',Str_Type,[rfReplaceAll]);

    aqTmp1.next;
  end;
  aqTmp1.close;

  result := Input_Str;
end;

function TFormula_Verify.Verify_Formula(Input_str: string;var output_str:string): boolean;
begin
  result := false;
  if trim(Input_str)<>'' then
  begin
    if pos(' XXXXYYYY ',Input_str)>0 then
    begin
      Application.MessageBox('XXXXYYYY'+'��ϵͳ��������,�벻Ҫʹ�ø�������Ϊ�û���������','��ʾ',mb_ok);
      exit;
    end;
    Input_str:= Replace_Expr_Factor(Input_str);
    try
      Input_str:= Get_If_Expr(Input_str);
//������if�������ٴ��������Ĳ��֡�
//      ExprCalc.PublicExplain(Input_str);
//�ж�ÿ�������Ƿ�Ϸ�

      result := MyDataClass.OpenQuery(' select '+input_str);
      output_str:=Input_str;
//      ShowMessage(Input_str);
    except
      result := false;
    end;
    if result = false then
      Application.MessageBox('���㹫ʽ�趨����ȷ! ','��ʾ',mb_ok);
  end
  else  //*************���ַ�����ʱͨ����֤****************
    result := true;
end;



function TFormula_Verify.Assign_Formula_Param_Value(
  DataSet: TDataSet;var str_expr:string): boolean;
var

Str_Eng_Spec:string;// = '''pX3f7Nj0wjg''';
str_Eng_Table:string; //= 'ebuo7k6y29jp';
//�����滻�Ͳ���������ͬ���ַ���
  str_tmp,
  str_Param:string;
begin
//������
//1�������ʽ�������˺Ͳ���������ͬ���ַ�������ô����һ�������ַ��滻��
//2���ѹ�ʽ�еĲ���ȫ����ֵ�����滻����
  str_Eng_Spec:= QuotedStr('pX3f7Nj0w8jg'+formatdatetime('yymmddhhnnss',now));
  str_Eng_Table:= 'eb3o7k6y2a9jp'+formatdatetime('yymmddhhnnss',now);
  DataSet.First;
  Result:=False;
  while not DataSet.Eof do begin
    str_Param:=trim(DataSet.fieldByName('parameter_name').AsString);
    str_tmp:= QuotedStr(str_Param);
//1���Ȱѹ�ʽ�кͲ�������һ�����ַ����滻
    str_expr:= StringReplace(str_expr,str_tmp,Str_Eng_Spec,[rfReplaceAll]);
//2.�ٰѹ�ʽ�б����ƺͲ���һ�����ַ����滻
    str_expr:= StringReplace(str_expr,str_Param+'(',Str_Eng_Table,[rfReplaceAll]);

//2���ٸ���ʽ�еĲ�����ֵ
    if DataSet.FieldByName('Data_type').Value = 1 then //������
      str_expr:= StringReplace(str_expr,str_Param,trim(DataSet.FieldByName('Unit_Value').AsString),[rfReplaceAll])
    else //�ַ���
      str_expr:= StringReplace(str_expr,str_Param,QuotedStr(trim(DataSet.FieldByName('Unit_Value').AsString)),[rfReplaceAll]);
//3���ٰѹ�ʽ�еĲ�������һ�����ַ�����ԭ
    str_expr:= StringReplace(str_expr,Str_Eng_Spec,str_tmp,[rfReplaceAll]);
    str_expr:= StringReplace(str_expr,Str_Eng_Table,str_Param+'(',[rfReplaceAll]);
    DataSet.next;
    result := True;
  end;
end;

function TFormula_Verify.Calc_Expr(str_Expr: string): double;
begin
  result:= ExprCalc.CalcExpr(str_expr);
//  CalcExpr(
end;

function TFormula_Verify.Calc_Eng_Table(var str_expr: string): boolean;
//�����滻�Ͳ���������ͬ���ַ���
var
  Str_Eng_Table ,
  str_tmp,
  str_Param:string;
  Eng_Expr,X,Y,sLeft,sRight,sValue:string;
  P1,P2,P3:integer;
begin
  try
    result := true;
//������ F(X,Y)
//1�������ʽ�������˺͹��̱�������ͬ���ַ�������ô����һ�������ַ��滻��
//2���ѹ�ʽ�еĲ���ȫ����ֵ�����滻����
    str_Eng_Table:= 'ebuo7k6y29jp'+formatdatetime('yyyymmddhhnnss',now);
    aqTmp2.Open;
    aqTmp2.First;
    while not aqTmp2.Eof do begin
      str_Param:=trim(aqTmp2.fieldByName('Eng_table_Name').AsString);
      str_tmp:= QuotedStr(str_Param);
      while Pos(str_Param,str_expr)>0 do begin
        P1:=Pos(str_Param,str_expr);
  //1���Ȱѹ�ʽ�кͱ�����һ�����ַ����滻
        str_expr:= StringReplace(str_expr,str_tmp,Str_Eng_Table,[rfReplaceAll]);
  //2�����㹤�̱�
        P2:=Pos('(',copy(str_expr,P1,length(str_expr)-P1))+P1-1;//ȡ�õ�һ��'('��λ��
        P3:=Get_PosOfbracket(copy(str_expr,P2+1,100000))+P2;//��ñ�')'��λ��
        Eng_Expr:=copy(str_expr,P1,P3); //��ù��̱����ʽ
        sLeft:=copy(str_expr,1,P1-1);
        sRight:=copy(str_expr,P3+1,Length(str_expr)-P3);
        //1���ȴ������л��X,Y��ֵ�����Y=NULL,��ô
        DeCode_FXY(Eng_Expr,x,y);
        sValue:=Calc_FX(aqTmp2.fieldByName('rKey').AsInteger,aqTmp2.fieldByName('Data_type').AsInteger,x,y);
        str_expr:=sLeft+sValue+sRight;

  //3���ٰѹ�ʽ�еĲ�������һ�����ַ�����ԭ
        str_expr:= StringReplace(str_expr,Str_Eng_Table,str_tmp,[rfReplaceAll]);
      end;
      aqTmp2.next;
    end;
  except
    result := false;
  end;
end;

procedure TFormula_Verify.DeCode_FXY(strExpr: string; var X, Y: string);
var
  P1,P2,P3:integer; //F(X,Y);
begin
  P1:= Pos('(',strExpr);
  P2:= Pos(',',strExpr);
  P3:= Pos(')',strExpr);
  x:= copy(strExpr,P1+1,P2-P1-1);
  y:= copy(strExpr,P2+1,P3-P2-1);
end;

function TFormula_Verify.Calc_FX(rKey, DataType: integer; sX, sY: string): string;
var
  Sqlstr:string;
  dX, dY: Double;
begin
  dx:=0;dy:=0;
  if DataType = 1 then
  begin
    dx:=StrToFloat(sx);
    dy:=StrToFloat(sY);
  end;
  Sqlstr:= 'exec autocal85 '+ IntToStr(DataType)+ ', '+IntToStr(rKey) +','+QuotedStr(sy)+','+QuotedStr(sx)+','+FloatToStr(dY)+','+FloatToStr(dX);
  MyDataClass.OpenQuery(sqlstr);
  result := MyDataClass.aqTmp.Fields[0].value;
  MyDataClass.aqTmp.close;
end;

function TFormula_Verify.Calc_Formula(dsParam:TDataSet;str_Expr: string): double;
begin
  if Formula_Verify.Assign_Formula_Param_Value(dsParam,str_expr) then
  str_expr:= Formula_Verify.Get_If_Expr(str_expr);
  if Formula_Verify.Calc_Eng_Table(str_expr) then
    result := Formula_Verify.Calc_Expr(str_expr)
  else
    result := -99999999.99;
end;



function TFormula_Verify.Check_Param(strExpr: string): boolean;
//var
//  i,j:integer;
//  Tmpstr,sLeft:string;
begin
  Result:=False;
//  if (trim(strExpr) = trim(Str_Type)) or (trim(strExpr) = trim(Str_Type)) then
//    result := true
//  j:=1;
//  Tmpstr:=strExpr;
//  for i :=1 to Length(Tmpstr) do
//  begin
//    if Is_Operator(Tmpstr[i]) then
//      sLeft:= copy(Tmpstr,
//  end;
end;

function TFormula_Verify.Is_Operator(C: Char): Boolean;
begin
  if c in ['+','-','*','/'] then
    Result := True
  else
    Result := False;
end;

function TFormula_Verify.Verify_Logic_Formula(Input_str: string;
  var output_str: string): boolean;
begin
  result := false;
  if trim(Input_str)<>'' then
  begin
    if pos(' XXXXYYYY ',Input_str)>0 then
    begin
      Application.MessageBox('XXXXYYYY'+'��ϵͳ��������,�벻Ҫʹ�ø�������Ϊ�û���������','��ʾ',mb_ok);
      exit;
    end;
    Input_str:= Replace_Expr_Factor(Input_str);
    try
      Input_str:= Get_If_Expr(Input_str);
//������if�������ٴ��������Ĳ��֡�
//      ExprCalc.PublicExplain(Input_str);
//�ж�ÿ�������Ƿ�Ϸ�

      result := MyDataClass.OpenQuery(' select 2 where '+input_str);
      if result then // ʹ��OR������SQL�жϳ��߼����ʽ�����Ƿ�����һ��,�����﷨���
        result := MyDataClass.OpenQuery(' select 2 where '+StringReplace(uppercase(input_str),'AND','OR',[rfReplaceAll]));
      output_str:=Input_str;
//      ShowMessage(Input_str);
    except
      result := false;
    end;
    if result = false then
      Application.MessageBox('���㹫ʽ����ȷ,���ܲ����������Ͳ�ƥ����߲����߼����ʽ! ','��ʾ',mb_ok);
  end
  else  //*************���ַ�����ʱͨ����֤****************
    result := true;
end;

function TFormula_Verify.Calc_Logic_Expr(str_Expr: string): boolean;
begin
Result:=False;
end;

function TFormula_Verify.Get_Logic_Expr(str_Expr: string): string;
var
  Prase:string;
  i:integer;
  strLeft,strRight,TmpExpr,Div_A,Div_B:string;
  n : integer;
  Op : TOperator;
  DataType,DataType2:byte;//��������1:���֣�2:�ַ�
  intLen : integer;
  Rslt:boolean;
begin
//1.�����Ƿ��� >,<,>=,<=,<>,+����,�����,                if( A>B or A> C,
//2.�ֽ�2�ߵı��ʽ,������� NOT,AND,(,),','��ô���Դ�Ϊ���,ȡֵ,����ȫ��ȡֵ
//�Ƚ�2�ߵ���ֵ,����һ����������ֵ
  rslt:=False;
  i:= Pos_AndOR_Prase(str_Expr,Prase);
  if i >0 then //�ҵ���' AND ���� OR '
  begin
    TmpExpr:= copy(str_expr,1,i-(Length(Prase)));
  end;
  Op := opEqual;
  intLen := 1;
  N:=0;
  while (n <= Length(TmpExpr))  do
  begin
    case TmpExpr[N] of
      '<' : begin
              if TmpExpr[N + 1] = '>' then
              begin
                Op := opUnequal;
                intLen := 2;
              end else
                if TmpExpr[N + 1] = '=' then
                begin
                  Op := opLessOrEqual;
                  intLen := 2;
                end else
                  Op := opLess;
                break;
              end;
      '>' : begin
              if TmpExpr[N + 1] = '=' then
              begin
                Op := opGreaterOrEqual;
                intLen := 2;
              end else
                Op := opGreater;
              break;
            end;
      '=' : begin
              Op := opEqual;
              break;
            end;
    end;
    inc(N);
  end;

//
  if N = 0 then
  begin
    result := TmpExpr;
    exit;
  end;
  
  strLeft:= De_Logic_Prase(copy(TmpExpr,1,N-1),1,Div_A);
  strRight:= De_Logic_Prase(copy(tmpExpr,N+IntLen,100000),2,Div_B);

//�ж��ֶ��������ͻ����ַ���  //�ж�strleft�����������ͣ�
  DataType :=Judge_Data_Type(strLeft);
  if DataType = 3 then
  begin
    Application.MessageBox(Pchar('���ʽ '+strLeft+' ��Ч,����'),'��ʾ',mb_Ok);
    abort;
  end;

  DataType2 :=Judge_Data_Type(strRight);
  if DataType = 3 then
  begin
    Application.MessageBox(Pchar('���ʽ '+strRight+' ��Ч,����'),'��ʾ',mb_Ok);
    abort;
  end;
  if DataType <> DataType2 then
  begin
    Application.MessageBox(Pchar('�������Ͳ�һ��,����'),'��ʾ',mb_Ok);
    abort;
  end;

//�������������֣���ô���ʽ����Ҫ����һ��
  if DataType = 1 then
  begin
    strLeft:= ExprCalc.PublicExplain(strleft);
    strRight:= ExprCalc.PublicExplain(strRight);
  end
  else
  begin
{    if trim(strLeft) = trim(Int_Type) then
      DataType:= 1
    else }if (trim(strLeft) = trim(Str_Type)) or (trim(strRight) = trim(Str_Type)) then
      DataType:= 2
    else
    begin
      Application.MessageBox(Pchar(strLeft+' �� '+strRight+' ������һ��Ϊ����,��ȷ��'),'��ʾ',mb_OK);
      abort;
    end;
  end;

  case Op of
    opGreater : case DataType of
                       1: Rslt := (StrToFloat(strLeft) > StrToFloat(strRight));
                       2: Rslt := strLeft > strRight;
                end;

    opGreaterOrEqual : case DataType of
                       1: Rslt := StrToFloat(strLeft) >= StrToFloat(strRight);
                       2: Rslt := strLeft >= strRight;
                end;
    opLess : case DataType of
                       1: Rslt := StrToFloat(strLeft) < StrToFloat(strRight);
                       2: Rslt := strLeft < strRight;
                end;
    opLessOrEqual : case DataType of
                       1: Rslt := StrToFloat(strLeft) <= StrToFloat(strRight);
                       2: Rslt := strLeft <= strRight;
                end;
    opEqual : case DataType of
                       1: Rslt := StrToFloat(strLeft) = StrToFloat(strRight);
                       2: Rslt := strLeft = strRight;
                end;
    opUnequal : case DataType of
                       1: Rslt := StrToFloat(strLeft) <> StrToFloat(strRight);
                       2: Rslt := strLeft <> strRight;
                end;
  end;
  if rslt then

end;

function TFormula_Verify.Pos_AndOR_Prase(str_Expr: string;Prase:string): integer;
var i,j:integer;
begin
  i:= Pos('AND',uppercase(str_expr));
  j:= Pos('OR',uppercase(str_expr));
  if i < j then
  begin
    result := i;
    Prase:='AND';
  end
  else
  begin
    result := j;
    Prase := 'OR';
  end;
end;

function TFormula_Verify.De_Logic_Prase(str_Expr: string;iType:byte;var Div_Expr:string): string;
var
  tmp_Expr:string;
  i:integer;
begin
   i:=0;
  if iType = 1 then //���
  begin
    tmp_Expr:= str_Expr;
    if Pos(',',tmp_Expr)>0 then
      i:= Pos(',',tmp_Expr)
    else if Pos('(',tmp_Expr)>0 then
      i:= Pos('(',tmp_Expr)+1;  //������','
    if i > 0 then
    begin
      result := copy(str_expr,i,10000);
      Div_Expr:= copy(str_expr,1,i-1);
    end
    else
      result := str_expr;
  end
  else if iType = 2 then //�ұ�
  begin
    tmp_Expr:= str_Expr;
    if Pos('AND',tmp_Expr)>0 then
    begin
      i:= Pos('AND',tmp_Expr);
      Div_Expr:= copy(str_expr,i+3,10000);
    end
    else if Pos('OR',tmp_Expr)>0 then
    begin
      i:= Pos('OR',tmp_Expr);
      Div_Expr:= copy(str_expr,i+2,10000);
    end  
    else if Pos('NOT',tmp_Expr)>0 then
    begin
      i:= Pos('NOT',tmp_Expr);
      Div_Expr:= copy(str_expr,i+3,10000);
    end
    else if Pos(',',tmp_Expr)>0 then
    begin
      i:= Pos(',',tmp_Expr);
      Div_Expr:= copy(str_expr,i+1,10000);
    end;
    if i > 0 then
      result := copy(str_expr,1,i-1)
    else
      result := str_expr;
  end;
end;

function TFormula_Verify.Is_Logic_Operator(C: string): Boolean;
begin
  if POS('<',uppercase(C)) > 0 then 
    Result := True
  else if POS('=',uppercase(C)) > 0 then 
    Result := True
  else if POS('>',uppercase(C)) > 0 then 
    Result := True
  else
    Result := False;
end;

function TFormula_Verify.Verify_Part_Cost_Formula(Cost_Dept,Part_Group:integer;Input_str: string;
  var output_str: string): boolean;
begin
  result := false;
  if trim(Input_str)<>'' then
  begin
    if pos(' XXXXYYYY ',Input_str)>0 then
    begin
      Application.MessageBox('XXXXYYYY'+'��ϵͳ��������,�벻Ҫʹ�ø�������Ϊ�û���������','��ʾ',mb_ok);
      exit;
    end;
    Input_str:= Replace_Factor_Part_Cost(Cost_Dept,Part_Group,Input_str);
    try
      Input_str:= Get_If_Expr(Input_str);
//������if�������ٴ��������Ĳ��֡�
//      ExprCalc.PublicExplain(Input_str);
//�ж�ÿ�������Ƿ�Ϸ�

      result := MyDataClass.OpenQuery(' select '+input_str);
      output_str:=Input_str;
//      ShowMessage(Input_str);
    except
      result := false;
    end;
    if result = false then
      Application.MessageBox('���㹫ʽ�趨����ȷ! ','��ʾ',mb_ok);
  end
  else  //*************���ַ�����ʱͨ����֤****************
    result := true;
end;

function TFormula_Verify.Replace_Factor_Part_Cost(Cost_Dept,Part_Group:integer;
  Input_str: string): string;
begin
  Input_str:= StringReplace(Input_str, #$D#$A, '', [rfReplaceAll]);

  Input_str:=' '+uppercase(Input_str)+' ';

  Input_str:= StringReplace(Input_str,' PROJECT ',Str_Type,[rfReplaceAll]);

  Input_str:= StringReplace(Input_str,' CP_REV ',Str_Type,[rfReplaceAll]);

  Input_str:= StringReplace(Input_str,' CUST_CODE ',Str_Type,[rfReplaceAll]);

  Input_str:= StringReplace(Input_str,' BOM.',' ',[rfReplaceAll]);
  Input_str:= StringReplace(Input_str,' PD.',' ',[rfReplaceAll]);
 //�򿪹��̱����滻��ʽ�е���ֵ
//  Input_str:= StringReplace(Input_str,' ','',[rfReplaceAll]);
  if not aqTmp2.Active then
  aqTmp2.Open ;
  aqTmp2.first;
  while not aqTmp2.Eof do begin
    if aqTmp2.FieldByName('data_type').AsInteger=1 then
      Input_str:= StringReplace(Input_str,' '+trim(Is_Null(uppercase(aqTmp2.fieldbyname('FXY').asstring),''))+' ',Int_Type,[rfReplaceAll])
    else
      Input_str:= StringReplace(Input_str,' '+trim(Is_Null(uppercase(aqTmp2.fieldbyname('FXY').asstring),''))+' ',Str_Type,[rfReplaceAll]);

    aqTmp2.next;
  end;
  aqTmp2.close;


  //��֤���̲�����
  aqTmp1.close;
  aqTmp1.SQL.Clear;
  aqTmp1.SQL.Add(' select p.rKey,P.parameter_name,P.Data_Type from data0506 m left join data0278 p on m.PARAMETER_PTR=p.rkey where ttype =3 and source_ptr='+IntToStr(Cost_Dept));
  aqTmp1.SQL.Add(' union select p.rKey,P.parameter_name,P.Data_Type  from data0499 M inner join data0278 p on m.Parameter_ptr=p.rKey where m.Inv_Group_ptr= '+IntToStr(Part_group));
  aqTmp1.SQL.Add(' union select M.rkey,M.PARAMETER_NAME,M.Data_Type from Data0278 M,Data0277 D where M.category_ptr=D.rkey and D.Category_type<=2 '); 
  aqTmp1.Open;
  aqTmp1.First;
  while not aqTmp1.Eof do begin
  //���������������ֵ�ͣ���ô���� ' 2' ���滻������������ַ��ͣ���ô�� ' ''X'' '�������
    if aqTmp1.FieldByName('data_type').AsInteger=1 then
      Input_str:= StringReplace(Input_str,' '+trim(Is_Null(uppercase(aqTmp1.fieldbyname('parameter_name').asstring),''))+' ',Int_Type,[rfReplaceAll])
    else
      Input_str:= StringReplace(Input_str,' '+trim(Is_Null(uppercase(aqTmp1.fieldbyname('parameter_name').asstring),''))+' ',Str_Type,[rfReplaceAll]);

    aqTmp1.next;
  end;
  aqTmp1.close;

  result := Input_Str;
end;

function TFormula_Verify.Calc_Expr_Parma(var str_Expr: string;out Out_Value:double): boolean;
begin
  result := true;
  if trim(str_expr) <> '' then
  begin
    str_expr:= Get_If_Expr(str_expr);
    try
      str_expr:= Get_If_Expr(str_expr);
      Out_Value := MyDataClass.Get_Sql_Value(' select 1.0*'+str_expr);//Calc_Expr(str_expr);
    except
      result := false;
      Application.MessageBox('����ʧ��,���鹫ʽ�����Ƿ��Ѿ���ֵ! ','��ʾ',mb_ok);
      Out_Value:=0;
    end;
  end
  else
    Out_Value:=0;
end;

{--------------------MyTree Class---------------------}

constructor TMyTreeClass.Create(AdoConnection: TAdoConnection);
begin
  FAdoConnection := AdoConnection;
  qryTmpItem := TAdoQuery.Create(application);
  qryTmpItem.Connection := FAdoConnection;
  qryTmpItem.CursorLocation := clUseClient;
  qryTmpItem.CursorType := ctStatic;
  qryTmpItem.LockType := ltBatchOptimistic;
end;

procedure TMyTreeClass.Create_Tree_List(TreeView: TTreeView);
var
  Node : array [0..10] of TTreeNode;
  tmp : String;
begin
  TreeView.Items.Clear;
  qryTmpItem.First;
  tmp := trim(qryTmpItem.FieldByName('ItemName').AsString);
  Node[qryTmpItem.FieldByName('LevNo').asinteger] := TreeView.Items.Add(nil,tmp);
  qryTmpItem.Next;

  while not qryTmpItem.Eof do
  begin
    tmp := trim(qryTmpItem.FieldByName('ItemName').AsString);
    Node[qryTmpItem.FieldByName('LevNo').asinteger] := TreeView.Items.AddChild(Node[qryTmpItem.FieldByName('LevNo').asinteger-1] ,tmp);
    qryTmpItem.next;
  end;
  TreeView.FullExpand;
end;

destructor TMyTreeClass.Destroy;
begin
  qryTmpItem.Close;
  qryTmpItem.Free;
  inherited;
end;

procedure TMyTreeClass.Expand_My_Tree_Down(TreeView: TTReeView;
  TopNo,SqlStr,TreeTitle: String);
begin
  qryTmpItem.Close;
  qryTmpItem.SQL.Clear;
  qryTmpItem.SQL.Add('select * from tmp_TreeList where SeqNo=0');
  qryTmpItem.open;

  Sel_Sql := SqlStr;
  qryTmpItem.close;
  qryTmpItem.open;
  SeqNo := 0;
  SetLength(FieldName,4);
  FieldName[0] := 'ItemNo';
  FieldName[1] := 'SeqNo';
  FieldName[2] := 'ItemName';
  FieldName[3] := 'LevNo';

  SetLength(FieldValue,4);
  FieldValue[0] := '0';
  FieldValue[1] := 0;
  FieldValue[2] := TreeTitle;
  FieldValue[3] := 0;
  Write_Tree_Item(qryTmpItem);
  Get_Tree_List_Data(TopNo,1);
  Create_Tree_List(TreeView);
end;

procedure TMyTreeClass.Expand_My_Tree_Down(TreeView: TTReeView;
  TopNo: integer; SqlStr, TreeTitle: String);
begin
  qryTmpItem.Close;
  qryTmpItem.SQL.Clear;
  qryTmpItem.SQL.Add('select * from tmp_TreeList where SeqNo=0');
  qryTmpItem.open;

  Sel_Sql := SqlStr;
  qryTmpItem.close;
  qryTmpItem.open;
  SeqNo := 0;
  SetLength(FieldName,4);
  FieldName[0] := 'ItemNo';
  FieldName[1] := 'SeqNo';
  FieldName[2] := 'ItemName';
  FieldName[3] := 'LevNo';

  SetLength(FieldValue,4);
  FieldValue[0] := '0';
  FieldValue[1] := 0;
  FieldValue[2] := TreeTitle;
  FieldValue[3] := 0;
  Write_Tree_Item(qryTmpItem);
  Get_Tree_List_Data(TopNo,1);
  Create_Tree_List(TreeView);
end;

procedure TMyTreeClass.GetFieldValue(DataSet: TDataSet);
begin
//  for i := Low(FieldName) to High(FieldName) do
//  begin
   FieldValue[0]:=  DATASET.FieldByName('ItemNo').Value;
   FieldValue[1]:= SeqNo;
   FieldValue[2]:= DATASET.FieldByName('ItemName').Value;
//   FieldValue[3]:= LevNo;
end;

procedure TMyTreeClass.Get_My_Tree_Data(TopNo, SqlStr, TreeTitle: String;DataSet:TCustomAdoDATASET);
begin
  qryTmpItem.Close;
  qryTmpItem.SQL.Clear;
  qryTmpItem.SQL.Add('select * from tmp_TreeList where SeqNo=0');
  qryTmpItem.open;

  Sel_Sql := SqlStr;
  qryTmpItem.close;
  qryTmpItem.open;
  SeqNo := 0;
  SetLength(FieldName,4);
  FieldName[0] := 'ItemNo';
  FieldName[1] := 'SeqNo';
  FieldName[2] := 'ItemName';
  FieldName[3] := 'LevNo';

  SetLength(FieldValue,4);
  FieldValue[0] := '0';
  FieldValue[1] := 0;
  FieldValue[2] := TreeTitle;
  FieldValue[3] := 0;
  Write_Tree_Item(qryTmpItem);
  Get_Tree_List_Data(TopNo,1);
  DataSet.Clone(qryTmpItem);
end;

procedure TMyTreeClass.Get_Tree_List_Data(TopNo: String; LevNo: integer);
var
  MSql : String;
  qrytmpMB :TAdoQuery;
begin
  Inc(SeqNo);
  MSql := Sel_Sql+QuotedStr(TopNo);
    qrytmpMB := TADOQuery.Create(nil);
    qrytmpMB.Connection :=FAdoConnection;
    qrytmpMB.close;
    qrytmpMB.SQL.Clear;
    qrytmpMB.Sql.Add(MSql);
    qrytmpMB.Open;
    qrytmpMB.first;
    while not qrytmpMB.eof do
    begin
//      GetFieldValue(qrytmpMB);
       FieldValue[0]:=  qrytmpMB.FieldByName('ItemNo').Value;
       FieldValue[1]:= SeqNo;
       FieldValue[2]:= qrytmpMB.FieldByName('ItemName').Value;
       FieldValue[3]:= LevNo;
      Write_Tree_Item(qryTmpItem);
      Get_Tree_List_Data(qrytmpMB.FieldByName('ItemNo').ASString,LevNo+1);
      qrytmpMB.Next;
    end;
    qrytmpMB.Cancel;
    qrytmpMB.Close;
    qrytmpMB.free;
end;

procedure TMyTreeClass.Get_Tree_List_Data(TopNo, LevNo: integer);
var
  MSql : String;
  qrytmpMB :TAdoQuery;
begin
  Inc(SeqNo);
  MSql := Sel_Sql+IntToStr(TopNo);
    qrytmpMB := TADOQuery.Create(nil);
    qrytmpMB.Connection :=FAdoConnection;
    qrytmpMB.close;
    qrytmpMB.SQL.Clear;
    qrytmpMB.Sql.Add(MSql);
    qrytmpMB.Open;
    qrytmpMB.first;
    while not qrytmpMB.eof do
    begin
//      GetFieldValue(qrytmpMB);
       FieldValue[0]:=  qrytmpMB.FieldByName('ItemNo').Value;
       FieldValue[1]:= SeqNo;
       FieldValue[2]:= qrytmpMB.FieldByName('ItemName').Value;
       FieldValue[3]:= LevNo;
      Write_Tree_Item(qryTmpItem);
      Get_Tree_List_Data(qrytmpMB.FieldByName('ItemNo').ASString,LevNo+1);
      qrytmpMB.Next;
    end;
    qrytmpMB.Cancel;
    qrytmpMB.Close;
    qrytmpMB.free;
end;

procedure TMyTreeClass.Get_Tree_List_Data_Up(TopNo: String;
  LevNo: integer);
begin
//
end;

procedure TMyTreeClass.Write_Tree_Item(DATASET: TDATASET);
var
  i:integer;
begin
  DATASET.append;
  for i := Low(FieldName) to High(FieldName) do
    DATASET.FieldByName(FieldName[i]).Value := FieldValue[i];
  DATASET.Post;
end;

function TFormula_Verify.Pos_OF_Operator(C: string): integer;
var
  i:integer;
begin
  if POS('<',uppercase(C)) > 0 then
    i:=POS('<',uppercase(C))
  else if POS('=',uppercase(C)) > 0 then 
    i:=POS('=',uppercase(C))
  else if POS('>',uppercase(C)) > 0 then
    i:=POS('>',uppercase(C))
  else
    i:=0;
  result := i;
end;

end.







