unit formPlanMain02;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, SingleDataSet, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, dxSkinsCore, dxSkinsDefaultPainters,
  dxSkinsdxStatusBarPainter, dxSkinscxPCPainter, dxSkinsdxBarPainter,
  ppEndUsr, ppBands, ppPrnabl, ppClass, ppCtrls, ppCache, ppProd, ppReport,
  ppComm, ppRelatv, ppDB, ppDBPipe, DB, DBClient, cds, Provider, ADODB,
  dxBar, cxClasses, ImgList, ActnList, Grids, DBGridEh, ToolWin, ComCtrls,
  cxPC, StdCtrls, RzPanel, ExtCtrls, dxStatusBar, Menus;

type
  TfrmPlanMain02 = class(TSingleDataSet_f)
    cdsMainRkey: TAutoIncField;
    cdsMainrkey831: TIntegerField;
    cdsMainstop_begin_date: TDateTimeField;
    cdsMainstop_end_date: TDateTimeField;
    cdsMainremark: TWideStringField;
    Button2: TButton;
    Button3: TButton;
    dtMainRkey: TAutoIncField;
    dtMainrkey831: TIntegerField;
    dtMainstop_begin_date: TDateTimeField;
    dtMainstop_end_date: TDateTimeField;
    dtMainremark: TWideStringField;
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  protected
    procedure RightsSetDataSetReadOnly;  override;
 //   function SaveBeforeCheck():Boolean;  override;
//    function SaveData():Boolean;         override;
 //   procedure SetButtonStatus;           override;
  public
    { Public declarations }
  end;

var
  frmPlanMain02: TfrmPlanMain02;

implementation

uses PublicFile, formPlanMain, DM_f;

{$R *.dfm}

procedure TfrmPlanMain02.RightsSetDataSetReadOnly;
begin
  cdsMain.ReadOnly:=True;
  DghMain.ReadOnly:=True;
end;
 {
procedure TfrmPlanMain02.SetButtonStatus;
begin
  if frmPlanMain.cdsMainRKEY832.AsInteger=3  then   //3 =ִ����
  begin
    Button2.Enabled:=True ;
    Button3.Enabled:=False;
  end
  else
  if frmPlanMain.cdsMainRKEY832.AsInteger=6  then
  begin
    Button2.Enabled:=False ;
    Button3.Enabled:=True;
  end
end;

function TfrmPlanMain02.SaveBeforeCheck():Boolean;
var
  strMsg:string;
begin
  Result:=True;
  with cdsMain do
  begin
    if State in [dsEdit ,dsInsert] then
    Post;
//    if FieldByName('number').IsNull then //���쵥��
//      strMsg:=strMsg+'�ֶΣ���'+FieldByName('number').DisplayLabel+'����ֵ����Ϊ�գ�����'+#13;
  end;

  if strMsg<>'' then
  begin
    MsgError(Copy(strMsg,0,Length(strMsg)-1));
    Result:=False;
  end;
end; }
{
function TfrmPlanMain02.SaveData():Boolean;
var
  isPause:Boolean;   //����ͣ
  NowDate:TDateTime;
  b_Processing:Integer;
begin                       //����й�Ա��¼��ȫ����ͣ��
  Result:=True;
//  with cdsMain do
  begin
//    if cdsMain.ChangeCount >0 then
    if SaveBeforeCheck then
    begin
      DM.ADOConnection1.BeginTrans;
      if Self.cdsMain.State in [dsEdit,dsInsert] then
        Self.cdsMain.Post;
      isPause:=False;
      b_Processing:=0;
      with  cdsRead do
      begin
        data:=(cdsMain.Data);
        while not Eof do
        begin
          if fieldByName('stop_end_date').isnull then    //�����ǰ��¼�У�ֻҪ��һ�м�¼��stop_end_dateΪ�� ��
          begin
            isPause:=True;
            Break;
          end;
          Next;
        end;
        cdsRead.Close;
      end;

      frmPlanMain.cdsMain.Edit;
      NowDate:=GetDataBaseSmallDate(DM.cdsRead);

      if isPause=True then     //�������ͣ
      begin
        frmPlanMain.cdsMainRKEY832.AsInteger:=6 ;               //�޸�״̬Ϊ����ͣ
        with  frmPlanMain.cdsChild   do
        begin
          try
            DisableControls ;
            First;
            while not Eof do
            begin
              if FieldByName('Status').AsInteger=3 then    //���״̬��ִ����
              begin
               // with cdsRead do
                begin
                  DM.cdsRead.Close;                                                     //FormatDateTime('yyyy-m-d h:n:s',NowDate)
                  DM.cdsRead.CommandText:='insert into DATA0849([Work_ptr],[stop_begin_date],[remark]) '
                  +' values('+FieldByName('rkey').AsString+','+QuotedStr(FormatDateTime('yyyy-m-d h:n:s',NowDate))+','
                  +QuotedStr(cdsMainremark.AsString)+')';

                  DM.cdsRead.Execute;
                end;
                Edit;
                FieldByName('Status').Value:=6;     //��״̬��Ϊ������ͣ ��     6	����ͣ
                Post;
                if  ApplyUpdates(0)<> 0 then
                DM.ADOConnection1.RollbackTrans;
              end;
              Next;
            end;
          finally
            EnableControls;
          end;
        end;
      end
      else
      begin
        frmPlanMain.cdsMainRKEY832.AsInteger:=3;               //�޸�״̬Ϊִ����
//        with  frmPlanMain.cdsChild   do
//        begin
//          try
//            DisableControls ;
//            First;
//            while not Eof do
//            begin
//              if FieldByName('Status').AsInteger=6 then
//              begin
//                if b_Processing=0 then
//                if messagedlg('ά����Ա��״̬Ҳ����ͣ��Ҫ�Զ�ͬ����ͣ������',mtconfirmation,[mbyes,mbno],0)=mrYes then
//                  b_Processing:=1
//                else
//                  b_Processing:=2;
//                if b_Processing=1 then   //ֻ���û��ڵ����Ҫͬ������ά����Ա����ͣ��¼ʱ����ִ�����д��롣
//                begin       ?
//                  //with cdsRead do
//                  begin
//                    DM.cdsRead.Close;
//                    DM.cdsRead.CommandText:='update DATA0849 set [stop_end_date]= '+QuotedStr(FormatDateTime('yyyy-m-d h:n:s',NowDate))
//                    +' where Work_ptr=' +FieldByName('rkey').AsString
//                    +' and [stop_end_date] is null ';
//                   // ShowMessage(SQL.Text);
//                    DM.cdsRead.Execute;
//                  end;
//
//                 // with cdsRead do
//                  begin
//                    DM.cdsRead.Close;
//                    DM.cdsRead.CommandText:='select isnull(cast(sum(datediff(minute,[stop_begin_date],[stop_end_date]))as dec(10,2))/60,0)'
//                    +' from DATA0849 where Work_ptr=' +FieldByName('rkey').AsString;
//                    DM.cdsRead.Open;
//                  end;
//                  Edit;
//                  FieldByName('Status').Value:=3;     //��״̬��Ϊ��ִ���� ��     3	ִ����
//                  FieldByName('TimeCons').Value := cdsRead.Fields[0].Value;  //��ͣʱ��
//                  Post;
//                  DM.cdsRead.Close;
//                  if  ApplyUpdates(0)<> 0 then
//                  DM.ADOConnection1.RollbackTrans;
//                end;
//              end;
//              Next;
//            end;
//          finally
//            EnableControls;
//          end;
//        end;
      end;
      frmPlanMain.cdsMain.Post;

//      with  frmPlanMain  do
//      begin
//        cdsMain.Edit;
// //       if (DtMainstop_end_date.IsNull)or(DtMainstop_end_date.AsString='') then  //�����ͣ����ʱ��=''
////        begin
////          if cdsMainRKEY832.AsInteger=3 then         //���״̬��ִ����
////            cdsMainRKEY832.AsInteger:=6                //�޸�״̬Ϊ����ͣ
////          else
////          if cdsMainRKEY832.AsInteger=6 then     //���״̬������ͣ
////            cdsMainRKEY832.AsInteger:=3;           //�޸�״̬Ϊִ����
////        end;
//        cdsMain.Post;
//      end;
      if frmPlanMain.cdsMain.ApplyUpdates(0)=0 then
      begin
        if cdsMain.ApplyUpdates(0)=0 then
        begin
          DM.ADOConnection1.CommitTrans;
          dsMainStateChange(dsMain);
          frmPlanMain.dsMainStateChange(dsMain);
          frmPlanMain.SetButtonStatus;
          Self.SetButtonStatus;
          dxStatusBar1.Panels[0].Text:='��ǰ��¼��:'+IntToStr(cdsMain.RecNo)+'/�ܼ�¼��:'+ IntToStr(cdsMain.RecordCount);
          //Abort;
        end
        else
        begin
          DM.ADOConnection1.RollbackTrans;
          Result:=False;
        end ;
      end
      else
      begin
        DM.ADOConnection1.RollbackTrans;
        Result:=False;
      end;
    end;

  end;
end;      }

procedure TfrmPlanMain02.Button2Click(Sender: TObject);
begin
  inherited;
  if (frmPlanMain.cdsMainRKEY832.AsInteger=3) then
  begin
    with cdsMain do
    begin
      if  State   <>dsInsert  then
        Append;
      FieldByName('rkey831').Value           := frmPlanMain. cdsMainRkey.Value;
      FieldByName('stop_begin_date').Value   := GetDataBaseDate(cdsRead,1);
 //     Post;
    end;
  end;
end;

procedure TfrmPlanMain02.Button3Click(Sender: TObject);
begin
  inherited;
  with cdsMain do
  begin
    Last;
    if  FieldByName('stop_end_date').IsNull then
    begin
      if  State   <>dsEdit  then
        Edit;
      FieldByName('stop_end_date').Value   := GetDataBaseDate(cdsRead,1);
      Post;
    end;
  end;
end;

procedure TfrmPlanMain02.FormShow(Sender: TObject);
begin
  inherited;
//  SetButtonStatus;
end;

procedure TfrmPlanMain02.FormCreate(Sender: TObject);
begin

  inherited;
//  cdsMain.ReadOnly:=True;
//  DghMain.ReadOnly:=True;
end;

end.
