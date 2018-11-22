unit PublicFunc;
interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,StrUtils,
  Dialogs, ImgList, StdCtrls, Buttons, ToolWin, DBCtrls, ComCtrls, DB, Grids,ADODB,
    DBGrids, ExtCtrls ,DBGridEh,DBCtrlsEh ,DBClient,DBGridEhImpExp;
type
  TDropDownInfo=class
  private
  protected
  public
    L_GridName               :TDBGridEh;     //��������б��������ĸ��������
    L_DropdownColumn         :string;        //��������б�ı������ //Ҳ�����ڷ����ı��¼����ֶ�
    L_ListDataSetName        :TClientDataSet;//�����б����ݼ���
    L_ListDataSetFilterField :string;        //���б����ݼ������ֶ�����//
    L_GetValueField          :string;        //��ȡֵ���ֶ���
    L_ListResultField        :string;        //�����б����ݼ����ص��ֶ��� //���ı��¼�����ʱ���͸�ֵ���ж�λ
    L_FormWidth              :Integer;       //��������Ŀ��
    L_FormHeight             :Integer;       //��������ĸ߶�
    L_FormType               :Integer;       //������������� 1:��ѡ���ڣ�2����ѡ����
    L_AddPickList            :array of string;//
    L_PickListResultValues   :array of string;//
    L_SourceDataSet          :TClientDataSet; //�������÷����ı��¼������ݼ�
    L_SourceField            :array of string;// DEPT_CODE,DEPT_NAME  �ı䷢���󣬻�ȡֵ���ֶ�
    L_ResultField            :array of string;        //DEPT_CODE,DEPT_NAME   �ı䷢���󣬴���Щ�ֶλ�ȡֵ
    L_FieldNotNull           :Boolean;                //�������Ϊ�棬��L_DropdownColumn�ֶε�ֵΪ��ʱ����ʾ
//    L_FK            : string;
//    L_PK            : string;
  end;

type
  TQueryInfo=class
  private
  protected
  public
    L_ListDataSetName  :TDataSet;          //�����б����ݼ���
    L_AddPickList      :array of string;   //
    L_DropdownColumn   :string;            //��������б���ֶ���
    L_ListResultField  :string;            //�����б����ݼ����ص��ֶ���     AnsiString
    L_FormWidth              :Integer;       //��������Ŀ��
    L_FormHeight             :Integer;       //��������ĸ߶�
  end;
  Function IsNumeric(Str:string):Boolean;
  Function IsDateTime(Str:string):Boolean;    //����Ч������ʱ��
  procedure MsgError(msg:string);
  var
    DropDown_Info:array of TDropDownInfo;
    Query_Info:array of TQueryInfo;
    frmFindOutSQL:string;
    FindNotDisplayFields  :array of string;
    FindDisplayFields     :array of string;
    FindFieldsName        :array of string;
    FindQueryFieldsName   :array of string;
    Find_Def_FieldName    :array of String;
    Find_Def_Oper         :array of String;
    Find_Def_FieldValue  :array of String;
    Find_Def_Field2Value  :array of String;
    FindFormHeight        :Integer;
    Find_Curr_Date:TDate;
implementation

Function IsDateTime(Str:string):Boolean;    //����Ч������ʱ��
var
  mDateTime: TDateTime;
begin
  Result:=False;
  if TryStrToDateTime(Str,mDateTime) then
  Result:=True;
end;

Function IsNumeric(Str:string):Boolean;
var
  i: integer;
  f: Double;
begin
  Result:=False;
  if TryStrToInt(Str,i) or TryStrToFloat(Str, f) then
    Result:=True;
end;
procedure MsgError(msg:string);
begin
  messagedlg(msg,mterror,[mbok],0);
end;
end.
