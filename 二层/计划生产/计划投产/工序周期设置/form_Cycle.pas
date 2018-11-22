unit form_Cycle;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, SingleDataSet_unt, ppDB,
  ppDBPipe, ppBands, ppPrnabl, ppClass, ppCtrls, ppCache, ppRelatv, ppProd,
  ppReport, ppComm, ppEndUsr, ImgList, ActnList, DB,
  DBClient, cds, Provider, ADODB, Grids, DBGridEh, ToolWin, ComCtrls,
  StdCtrls, RzPanel, ExtCtrls,  Menus, RzButton;

type
  Tfrm_Cycle = class(TSingleDataSet_frm)
    cdsMainrkey: TAutoIncField;
    cdsMainDescription: TStringField;
    cdsMainMinValue: TBCDField;
    cdsMainMaxValue: TBCDField;
    dtMainrkey: TAutoIncField;
    dtMainDescription: TStringField;
    dtMainMinValue: TBCDField;
    dtMainMaxValue: TBCDField;
    procedure FormCreate(Sender: TObject);
  private
    function SaveBeforeCheck():Boolean; override;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_Cycle: Tfrm_Cycle;

implementation

uses PublicFile;

{$R *.dfm}

procedure Tfrm_Cycle.FormCreate(Sender: TObject);
begin
  inherited;
  cdsMain.Open;
  TabSheet2.TabVisible:=False;
end;

function Tfrm_Cycle.SaveBeforeCheck():Boolean;
var
  strMsg,strSQL:string;
begin
  Result:=True;
  with cdsMain do
  begin
    if State in [dsEdit ,dsInsert] then
    Post;
    if FieldByName('Description').IsNull then //��������
      strMsg:=strMsg+'�ֶΣ���'+FieldByName('Description').DisplayLabel+'����ֵ����Ϊ�գ�����'+#13;
                                      // or(FieldByName('MinValue').AsFloat<=0)
    if (FieldByName('MinValue').IsNull) then
      strMsg:=strMsg+'�ֶΣ���'+FieldByName('MinValue').DisplayLabel+'����ֵ����Ϊ�գ�����'+#13;
                                      //  or(FieldByName('MaxValue').AsFloat<=0)
    if (FieldByName('MaxValue').IsNull) then
      strMsg:=strMsg+'�ֶΣ���'+FieldByName('MaxValue').DisplayLabel+'����ֵ����Ϊ�գ�����'+#13;

    if (FieldByName('MinValue').AsFloat>=FieldByName('MaxValue').AsFloat) then
      strMsg:=strMsg+'�ֶΣ���'+FieldByName('MinValue').DisplayLabel+'����ֵ���ܴ��ڻ���ڡ�'+FieldByName('MaxValue').DisplayLabel+'����ֵ������'+#13;

    if (UpdateStatus=usInserted)or((UpdateStatus=usModified)and(UpperCase(FieldByName('Description').NewValue)<>UpperCase(FieldByName('Description').OldValue))) then
    begin
      strSQL:='SELECT rkey FROM [dbo].[data0051] where Description='+QuotedStr(trim(FieldByName('Description').NewValue));
      if RecordExists(strSQL,cdsRead)then
      begin
        strMsg:=strMsg+'�ֶΣ���'+FieldByName('Description').DisplayLabel+'����ֵ��'+trim(FieldByName('Description').NewValue)+'���Ѿ����ڣ�����'+#13
      end;
    end;
  end;

  if strMsg<>'' then
  begin
    MsgError(Copy(strMsg,0,Length(strMsg)-1));
    Result:=False;
  end;
end;

end.
