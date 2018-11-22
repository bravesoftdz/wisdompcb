unit formMainCycl;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, MC_unt,
  Menus, ppEndUsr, ppBands, ppPrnabl, ppClass, ppCtrls, ppCache, ppProd,
  ppReport, ppComm, ppRelatv, ppDB, ppDBPipe, DB, DBClient, cds, Provider,
  ADODB,  ImgList, ActnList, Grids, DBGridEh, ToolWin,
  ComCtrls, StdCtrls, RzPanel, ExtCtrls,
   RzButton;

type
  TfrmMainCycl = class(TMC_frm)
    cdsMainDeviType: TStringField;
    cdsMainTypeName: TStringField;
    cdsMainTypeDesc: TStringField;
    cdsChildDeviType: TStringField;
    cdsChildMainCycl: TStringField;
    dtMainDeviType: TStringField;
    dtMainTypeName: TStringField;
    dtMainTypeDesc: TStringField;
    dtChildDeviType: TStringField;
    dtChildMainCycl: TStringField;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  protected
    function SaveBeforeCheck ():Boolean  ; override;
    
  public
    { Public declarations }
  end;

var
  frmMainCycl: TfrmMainCycl;

implementation

uses DM_unt, PublicFile;

{$R *.dfm}

function TfrmMainCycl.SaveBeforeCheck():Boolean  ;
var
  strMsg,strSQL:string;
  I_Row :Integer;
begin
  Result:=True;
  with cdsMain do
  begin
    if State in [dsEdit ,dsInsert] then
    Post;
    if FieldByName('DeviType').IsNull then
      strMsg:=strMsg+'�ֶΣ���'+FieldByName('DeviType').DisplayLabel+'����ֵ����Ϊ�գ�����'+#13;
    if FieldByName('TypeName').IsNull then
      strMsg:=strMsg+'�ֶΣ���'+FieldByName('TypeName').DisplayLabel+'����ֵ����Ϊ�գ�����'+#13;

    if (FieldByName('DeviType').IsNull=False)then
    if (UpdateStatus=usInserted)
         or((UpdateStatus=usModified) and ((UpperCase(FieldByName('DeviType').NewValue)<>UpperCase(FieldByName('DeviType').OldValue)))
           ) then
    begin
      strSQL:='select * from data0811 where DeviType='+QuotedStr(FieldByName('DeviType').NewValue);
    //  ShowMessage(strSQL);
      if RecordExists(strSQL,DM_frm.cdsRead)then
      begin
        strMsg:=strMsg+'�ֶΣ���'+FieldByName('DeviType').DisplayLabel+'����ֵ��'+trim(FieldByName('DeviType').NewValue)
          +'���Ѿ����ڣ�����'+#13
      end;
    end;
  end;

  if cdsChild.State in [dsEdit ,dsInsert] then
  cdsChild.Post;
  if cdsChild.IsEmpty then
    strMsg:=strMsg+'��ϸ������Ҫ��һ�м�¼������'+#13
  else
  begin
    cdsRead.CloneCursor(cdsChild,True);
    with cdsRead do
    try
      DisableControls ;
      First;
      for I_Row:=0 to RecordCount-1 do
      begin
        if FieldByName('MainCycl').IsNull then
          strMsg:=strMsg+'��ϸ���'+IntToStr(I_Row+1)+'�У��ֶΣ���'+cdsChild.FieldByName('MainCycl').DisplayLabel+'����ֵ����Ϊ�գ�����'+#13;
        Next;
      end;
    finally
      EnableControls;
      Close;
    end;
  end;

  if strMsg<>'' then
  begin
    MsgError(Copy(strMsg,0,Length(strMsg)-1));
    Result:=False;
  end;
end;

procedure TfrmMainCycl.FormCreate(Sender: TObject);
begin
if not App_init_2(DM_frm.ADOConnection1 ) then
  begin
    ShowMessage('��������ʧ�ܣ�����ϵϵͳ����Ա��');
    application.Terminate;
    exit;
  end;                   { }
  Caption:=application.Title ;

   {DM_frm.ADOConnection1.Close;
  DM_frm.ADOConnection1.ConnectionString:='Provider=SQLOLEDB.1;Password=wisdomtopcb1077;Persist Security Info=True;User ID=wzsa;Initial Catalog=sj_v20_live;Data Source=172.16.68.8';
  DM_frm.ADOConnection1.Open;
  UserRKEY := 2522;
  vprev:='4';  }

  inherited;
  cdsMain.Open;
  ColumnAddList(DghChild,'MainCycl','select MainCycl from Data0816 order by rkey');
end;

end.
