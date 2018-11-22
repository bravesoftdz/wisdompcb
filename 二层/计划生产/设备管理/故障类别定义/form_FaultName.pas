unit form_FaultName;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, MC_unt,  ppDB,
  ppDBPipe, ppBands, ppPrnabl, ppClass, ppCtrls, ppCache, ppRelatv, ppProd,
  ppReport, ppComm, ppEndUsr, ImgList, ActnList, DB,
  DBClient, cds, Provider, ADODB, Grids, DBGridEh, ToolWin, ComCtrls,
  StdCtrls, RzPanel, ExtCtrls,  Mask, DBCtrls,
  Menus, RzButton;

type
  Tfrm_FaultName = class(TMC_frm)
    cdsMainrkey: TAutoIncField;
    cdsMainFaultDesc: TStringField;
    cdsChildrkey: TAutoIncField;
    cdsChildD845_ptr: TIntegerField;
    cdsChildFaultName: TStringField;
    cdsChildstdDate: TBCDField;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    function SaveBeforeCheck ():Boolean  ; override;
//    procedure ChildDataSetOpen ; override;
 //   procedure FindData();        override;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_FaultName: Tfrm_FaultName;

implementation

uses  PublicFile, DM_unt;

{$R *.dfm}

function Tfrm_FaultName.SaveBeforeCheck ():Boolean  ;
var
  strSQL,strMsg:string;
  I_Row :Integer;
begin
  Result:=True;
  with cdsMain do
  begin
    if State in [dsEdit ,dsInsert] then
    Post;

    if FieldByName('FaultDesc').IsNull then
      strMsg:=strMsg+'�ֶΣ���'+FieldByName('FaultDesc').DisplayLabel+'����ֵ����Ϊ�գ�����'+#13
    else
    begin
      if UpdateStatus=usInserted then
      begin
        strSQL:='SELECT rkey FROM [dbo].[data0845] where FaultDesc='+QuotedStr(trim(FieldByName('FaultDesc').NewValue));
        if RecordExists(strSQL,cdsRead)then
        begin
          strMsg:=strMsg+'�ֶΣ���'+FieldByName('FaultDesc').DisplayLabel+'����ֵ��'+trim(FieldByName('FaultDesc').NewValue)+'���Ѿ����ڣ�����'+#13
        end;
      end;
    end;
  end;

  with cdsChild do
  begin
    if cdsChild.State in [dsEdit ,dsInsert] then
    Post;
  end;
  DM_frm.cdsRead1.CloneCursor(cdsChild,False);
  with  DM_frm.cdsRead1 do
  begin
    try
      DisableControls ;
      First;
      for I_Row:=0 to RecordCount-1 do
      begin
        if FieldByName('FaultName').IsNull then //
          strMsg:=strMsg+'��ϸ���'+IntToStr(I_Row+1)+'�У��ֶΣ���'+cdsChild.FieldByName('FaultName').DisplayLabel+'����ֵ����Ϊ�գ�����'+#13;
        if (FieldByName('stdDate').IsNull)or(FieldByName('stdDate').Value<=0) then //��������
          strMsg:=strMsg+'��ϸ���'+IntToStr(I_Row+1)+'�У��ֶΣ���'+cdsChild.FieldByName('stdDate').DisplayLabel+'����ֵ�������0������'+#13;
        if (cdsMain.UpdateStatus<>usInserted)and(UpdateStatus=usInserted) then
        begin
          strSQL:='SELECT rkey FROM [dbo].[data0846] where D845_ptr='+string(FieldByName('D845_ptr').NewValue )
          +' and FaultName='+ QuotedStr(trim(FieldByName('FaultName').NewValue))  ;
         // ShowMessage(strSQL);
          if RecordExists(strSQL,cdsRead)then
          begin
            strMsg:=strMsg+'��ǰ��������ֶΣ���'+cdsChild.FieldByName('FaultName').DisplayLabel+'����ֵ��'+trim(FieldByName('FaultName').NewValue)+'���Ѿ����ڣ�����'+#13
          end;
        end;
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

procedure Tfrm_FaultName.FormCreate(Sender: TObject);
begin
  {  }
  if not App_init_2(DM_frm.ADOConnection1 ) then
  begin
    ShowMessage('��������ʧ�ܣ�����ϵϵͳ����Ա��');
    application.Terminate;
    exit;
  end;     
  self.Caption:=application.Title;
  
 { DM_frm.ADOConnection1.Close;
  DM_frm.ADOConnection1.ConnectionString:='Provider=SQLOLEDB.1;Password=wisdomtopcb1077;Persist Security Info=True;User ID=wzsa;Initial Catalog=sj_v20_live;Data Source=172.16.68.8';
  DM_frm.ADOConnection1.Open;
  UserRKEY := 2522;
  vprev:='2'; }
  inherited;
  
  cdsMain.Open;


end;

procedure Tfrm_FaultName.FormShow(Sender: TObject);
begin
  inherited;
  windowstate := wsnormal ;
  self.width := 900;
  self.height := 650;
end;

end.
