unit MC;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Toolbar, cxGraphics, cxControls, cxLookAndFeels,
  cxLookAndFeelPainters, dxSkinsCore, dxSkinsDefaultPainters,
  dxSkinsdxStatusBarPainter, dxSkinsdxBarPainter, DB, DBClient, cds, dxBar,
  dxBarExtItems, cxClasses, ImgList, ActnList, dxStatusBar, dxSkinscxPCPainter,
  DBGridEh, ToolWin, ComCtrls, cxPC, StdCtrls,
  RzPanel, ExtCtrls, ppDB, ppDBPipe,  ppRelatv, ppProd, ppClass,
  ppReport, ppComm, ppEndUsr, Provider, ADODB,
  ppBands, ppPrnabl, ppCtrls, ppCache, Grids, Mask, DBCtrls, DBEditBit,
  RzEdit, RzDBEdit, RzDBBnEd, DBButtonEdit, Menus,
   ToolCtrlsEh;

type
  TMC_f = class(TToolbar_f)
    cxTabControl1: TcxTabControl;
    Splitter1: TSplitter;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel4: TPanel;
    cxPageControl1: TcxPageControl;
    cxTabSheetMain1: TcxTabSheet;
    ToolBar2: TToolBar;
    cxTabSheetMain2: TcxTabSheet;
    Panel6: TPanel;
    Panel3: TPanel;
    Panel5: TPanel;
    Panel7: TPanel;
    Panel8: TPanel;
    Panel9: TPanel;
    Panel10: TPanel;
    Panel11: TPanel;
    cxPageControl2: TcxPageControl;
    cxTabSheetChild1: TcxTabSheet;
    ToolBar1: TToolBar;
    cxTabSheetChild2: TcxTabSheet;
    dlgOpen1: TOpenDialog;
    dsChild: TDataSource;
    dspChild: TDataSetProvider;
    cdsChild: Tcds;
    dtChild: TADODataSet;
    RzToolbar2: TRzToolbar;
    btn1: TButton;
    MainGrid_PopupMenu: TPopupMenu;
    DghMain: TDBGridEh;
    dghChild: TDBGridEh;
    RzToolbar3: TRzToolbar;
    btn2: TButton;
    N_Relogin: TMenuItem;
    N_ResetColumns: TMenuItem;
    N_SeeLog: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    procedure actExportExecute(Sender: TObject);
    procedure actAddExecute(Sender: TObject);
    procedure actEditExecute(Sender: TObject);
    procedure actSaveExecute(Sender: TObject);
    procedure actCancelExecute(Sender: TObject);
    procedure actDeleteExecute(Sender: TObject);
    procedure actRefreshExecute(Sender: TObject);
    procedure DghMainTitleClick(Column: TColumnEh);
    procedure DghMainKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCreate(Sender: TObject);
    procedure cdsMainAfterInsert(DataSet: TDataSet);
    procedure dsMainStateChange(Sender: TObject);
    procedure DghMainEnter(Sender: TObject);
    procedure dghChildEnter(Sender: TObject);
    procedure DghMainGetCellParams(Sender: TObject; Column: TColumnEh;
      AFont: TFont; var Background: TColor; State: TGridDrawState);
    procedure DghMainDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure dghChildDrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure dghChildGetCellParams(Sender: TObject; Column: TColumnEh;
      AFont: TFont; var Background: TColor; State: TGridDrawState);
    procedure cdsMainReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
    procedure cdsMainAfterScroll(DataSet: TDataSet);
    procedure actFirstExecute(Sender: TObject);
    procedure actPriorExecute(Sender: TObject);
    procedure actNextExecute(Sender: TObject);
    procedure actLastExecute(Sender: TObject);
    procedure actFilterExecute(Sender: TObject);
    procedure actCancelFilterExecute(Sender: TObject);
    procedure cdsChildAfterScroll(DataSet: TDataSet);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cdsMainAfterCancel(DataSet: TDataSet);
    procedure cxTabSheetMain2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure cxTabSheetChild2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure cdsMainBeforeScroll(DataSet: TDataSet);
    procedure cdsMainBeforeCancel(DataSet: TDataSet);
    procedure DghMainKeyPress(Sender: TObject; var Key: Char);
    procedure dghChildKeyPress(Sender: TObject; var Key: Char);
    procedure cdsChildAfterInsert(DataSet: TDataSet);
    procedure cdsMainAfterClose(DataSet: TDataSet);
    procedure dspChildAfterUpdateRecord(Sender: TObject;
      SourceDS: TDataSet; DeltaDS: TCustomClientDataSet;
      UpdateKind: TUpdateKind);
    procedure dspChildBeforeUpdateRecord(Sender: TObject;
      SourceDS: TDataSet; DeltaDS: TCustomClientDataSet;
      UpdateKind: TUpdateKind; var Applied: Boolean);
    procedure cdsChildBeforeClose(DataSet: TDataSet);
    procedure cdsMainBeforeClose(DataSet: TDataSet);
    procedure FormShow(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure cdsChildReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
    procedure dghChildKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DghMainMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure N_ReloginClick(Sender: TObject);
    procedure MainGrid_PopupMenuPopup(Sender: TObject);
    procedure N_ResetColumnsClick(Sender: TObject);
    procedure cdsChildNewRecord(DataSet: TDataSet);
    procedure cdsMainNewRecord(DataSet: TDataSet);
    procedure dghChildMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure N_SeeLogClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure cdsMainAfterOpen(DataSet: TDataSet);
  private

    { Private declarations }
  protected
    IsMC:Boolean  ;  {�����ӱ�ṹ��ֻ�������ӱ�ṹ��ʱ�����ӱ�ֻ��һ�м�¼��ʱ��
                     ����Ҳһͬɾ�����ñ�����DeleteSaveData������ʹ�ã� }
    function SaveBeforeCheck ():Boolean;             override;
    function SaveData():Boolean;                     override;
    function DeleteSaveData():Boolean;               override;
    procedure ChildDataSetOpen;                      virtual;
    procedure SetToolbarButtonStatus(Flag: Boolean); override;
    function DeleteBeforeCheck():Boolean;            override;
    procedure RightsSetDataSetReadOnly;              override; //����Ȩ�����ֵ���������ݼ��Ƿ���ֻ�������Ը�����Ҫ����
    procedure Edit_Enter(Sender: TObject);
  public
    ActiveGridEH:TDBGridEh;
    
    { Public declarations }
  end;

var
  MC_f: TMC_f;
const
  Msg_Delete_0='��ȷ��Ҫɾ����ǰѡ�����ŵ�����?ɾ���󽫲��ָܻ���';
  Msg_Delete_1='��ȷ��Ҫɾ����ǰ�����ѡ����¼��?ɾ���󽫲��ָܻ���';

implementation


uses DM_f,  PublicFile, ColsDisplaySet_unt, LogWriteform;

{$R *.dfm}

procedure TMC_f.Edit_Enter(Sender: TObject);
begin
  inherited;
  if Sender is TWinControl then
  with Sender as TWinControl do
  if Parent=cxTabSheetMain2 then
    begin
    ActiveGridEH:=DghMain  ;
    dsMainStateChange(nil);
    DghReadOnlyFocus(DghMain);
    end
  else
  if Parent=cxTabSheetChild2 then
    begin
    ActiveGridEH:=dghChild;
    dsMainStateChange(nil);
    DghReadOnlyFocus(dghChild);
    end;
end;

procedure TMC_f.RightsSetDataSetReadOnly;
begin
  if (StrToInt(vprev) in [2,3,4]) then    //
  begin
    cdsMain  .ReadOnly:=False;
    cdsChild .ReadOnly:=False;
  end
  else
  begin
    cdsMain  .ReadOnly:=True;
    cdsChild .ReadOnly:=True;
  end  ;
  if (StrToInt(vprev) in [2,4]) then    //
  begin
    DghMain  .ReadOnly:=False;
    dghChild .ReadOnly:=False;
  end
  else
  begin
    DghMain  .ReadOnly:=True;
    dghChild .ReadOnly:=True;
  end ;
end;

function TMC_f.DeleteBeforeCheck():Boolean;
var
  i :Integer;
  SQL,Msg,ConstID,FTableName:string;   //
begin
  Result:=True;
  if cdsMain.F_TableName<>'' then
  begin
       {�ù���������ͬһ���ݴ��ڲ�ͬ�����ݼ��ϵ��ö�Σ��������ӱ�ṹ�����ݴ��ڣ���
        �������ʹ�ã����÷����򿪱��Ӷ����Ч�ʡ�����Ƿ������������ }
    if DtForeignKeyFieldQty.Active=False then
    begin
      DtForeignKeyFieldQty.CommandText:=
      'select co.ConstID ,o.name as FTableName, c.name as FFieldName,o1.name as RTableName,c1.name as RFieldName, '
      +'Cast(isnull(g.[value],'''') as varchar(50))+Cast(o.name as varchar(50)) as TableDescription '
      +'from sysforeignkeys f join sysconstraints co on f.constid=co.constid  '
      +'join dbo.syscolumns c on f.fkeyid=c.id and f.fkey=c.colid  '
      +'join dbo.sysObjects  o on  c.id =o.id and o.id =co.id  '
      +'join dbo.syscolumns c1 on f.rkeyid=c1.id and f.rkey=c1.colid '
      +'join dbo.sysObjects  o1 on  c1.id =o1.id '
      +'left join sys.extended_properties g  on (o.id = g.major_id AND g.minor_id = 0) '
      +'where o1.name=  '+QuotedStr( cdsMain.F_TableName)+' and o.name not in('+QuotedStr( cdsChild.F_TableName)+') '
      +' order by f.constid, rkey';
      DtForeignKeyFieldQty.Open;
    end ;

    SQL:=''; //��ʼ��ֵ��
    Msg:='';
    ConstID:='';
    FTableName:='' ;
    with   DtForeignKeyFieldQty do
    begin
      if  IsEmpty then Exit;//�����¼Ϊ�㣬�˳�
      First;
      ConstID:= FieldByName('ConstID').AsString ;
      FTableName:=FieldByName('FTableName').AsString;
      SQL:=SQL+AddSql(SQL)+ FieldByName('FFieldName').Value+' = '
           +QuotedStr(cdsMain.FieldByName(FieldByName('RFieldName').asstring).Value); //���޸ĵ�����

      if  cdsMain.F_UniqueKey='' then
        Msg:=Msg+ '�ֶΣ���'+cdsMain.FieldByName(FieldByName('RFieldName').asString).DisplayLabel+'����ֵ'
             + '��'+ cdsMain.FieldByName(FieldByName('RFieldName').asString).asString +'����'+#10#13
      else
        Msg:=Msg+ '�ֶΣ���'+cdsMain.FieldByName(cdsMain.F_UniqueKey).DisplayLabel+'����ֵ'
             + '��'+ cdsMain.FieldByName(cdsMain.F_UniqueKey).asString +'����'+#10#13  ;
      Next;
      for I:=0 to RecordCount-1 do
      begin
        if ConstID<>'' then
        if (ConstID<> FieldByName('ConstID').AsString )or(Eof) then
        begin
          if  RecordExists('select * from '+FTableName+#10#13+SQL,cdsRead) then   //  PrimKeyExists()���Զ���FUNCTION�������¼���ڣ������棬���򷵻ؼ�
          begin
            msgerror(Msg+'�Ѿ�����'+FieldByName('TableDescription').AsString +'�������ã��ֲ�����ɾ����');   //
            Result:=False;        //������ǰ�û��Ĳ�����
          end;
          SQL:=''; //��ʼ��ֵ��
          Msg:='';
        end;
        ConstID:= FieldByName('ConstID').AsString ;
        FTableName:=FieldByName('FTableName').AsString;
        SQL:=SQL+AddSql(SQL)+ FieldByName('FFieldName').Value+' = '
             +QuotedStr(cdsMain.FieldByName(FieldByName('RFieldName').Value).Value); //���޸ĵ�����
        if  cdsMain.F_UniqueKey='' then
          Msg:=Msg+ '�ֶΣ���'+cdsMain.FieldByName(FieldByName('RFieldName').asString).DisplayLabel+'����ֵ'
               + '��'+ cdsMain.FieldByName(FieldByName('RFieldName').asString).asString +'����'+#10#13
        else
          Msg:=Msg+ '�ֶΣ���'+cdsMain.FieldByName(cdsMain.F_UniqueKey).DisplayLabel+'����ֵ'
               + '��'+ cdsMain.FieldByName(cdsMain.F_UniqueKey).asString +'����'+#10#13  ;
        Next;
      end ;
    end;
  end;
end;

function TMC_f.SaveBeforeCheck():Boolean  ;
var
  strMsg:string;
//  I_Row :Integer;
begin
  Result:=True;
  with cdsMain do
  begin
    if State in [dsEdit ,dsInsert] then
    Post;
//    if (FieldByName('DeviType').IsNull=False)then
//    if (UpdateStatus=usInserted)
//         or((UpdateStatus=usModified) and ((UpperCase(FieldByName('DeviType').NewValue)<>UpperCase(FieldByName('DeviType').OldValue)))
//           ) then
//    begin
//      strSQL:='select * from data0811 where DeviType='+QuotedStr(FieldByName('DeviType').NewValue);
//    //  ShowMessage(strSQL);
//      if RecordExists(strSQL,DM.cdsRead)then
//      begin
//        strMsg:=strMsg+'�ֶΣ���'+FieldByName('DeviType').DisplayLabel+'����ֵ��'+trim(FieldByName('DeviType').NewValue)
//          +'���Ѿ����ڣ�����'+#13
//      end;
//    end;
//    if FieldByName('number').IsNull then //���쵥��
//      strMsg:=strMsg+'�ֶΣ���'+FieldByName('number').DisplayLabel+'����ֵ����Ϊ�գ�����'+#13;
  end;

//  if cdsChild.State in [dsEdit ,dsInsert] then     //usModified
//  cdsChild.Post;
//  if cdsChild.IsEmpty then
//    strMsg:=strMsg+'��ϸ������Ҫ��һ�м�¼������'+#13
//  else
//  begin
//    with DM.cdsClone do
//    try
//      Close;
//      Data:= cdsChild.Data;
//      DisableControls ;
//      First;
//      for I_Row:=0 to RecordCount-1 do
//      begin
//        if FieldByName('FileType').IsNull then //���ϱ���
//          strMsg:=strMsg+'��ϸ���'+IntToStr(I_Row+1)+'�У��ֶΣ���'+cdsChild.FieldByName('FileType').DisplayLabel+'����ֵ����Ϊ�գ�����'+#13 ;
//        Next;
//      end;
//
//      if FieldByName('FileType').IsNull=False then  // ��ʾ�ظ���¼����
//      begin
//        DM.cdsTemp.data:=Data;
//        Last;
//        for I_Row:=RecordCount-1 downto 0 do
//        begin
//          str_Filter:= 'FileType='+FieldByName('FileType').AsString;
//          DM.cdsTemp.Filter:= str_Filter;
//          DM.cdsTemp.Filtered:=True;
//
//          if DM.cdsTemp.RecordCount >=2 then
//          begin
//            strMsg:=strMsg+'��ϸ���'+IntToStr(I_Row+1)+'�У��ֶΣ���'
//            +cdsChild.FieldByName('FileType').DisplayLabel+'����ֵ���ظ�������'+#13 ;
//          end;
//          while not DM.cdsTemp.Eof do    //�����ļ�¼�����Ǽ���ж����ظ��ļ�¼ȫ��ɾ����
//          DM.cdsTemp.Delete;
//          DM.cdsTemp.Filtered:=False;
//          Prior;
//        end;
//      end;
//    finally
//      Close;
//      DM.cdsTemp.Close;
//    end;
//  end;

  if strMsg<>'' then
  begin
    MsgError(Copy(strMsg,0,Length(strMsg)-1));
    Result:=False;
  end;
end;

procedure TMC_f.SetToolbarButtonStatus(Flag: Boolean);
begin
  dxBarManager.LockUpdate:=True;
  with   ActiveGridEH.DataSource.DataSet as TClientDataSet do
  begin
    tblAdd.Enabled:=Flag and (StrToInt(vprev)in [2,4]);
    actAdd.Enabled:=Flag and (StrToInt(vprev)in [2,4]);

    tblEdit.Enabled:=Flag and (StrToInt(vprev)in [2,4])and(IsEmpty=False);
    actEdit.Enabled:=Flag and (StrToInt(vprev)in [2,4])and(IsEmpty=False);

    tblDelete.Enabled:=( Flag)and(IsEmpty=False) and (StrToInt(vprev)in [2,4]);
    actDelete.Enabled:=( Flag)and(IsEmpty=False) and (StrToInt(vprev)in [2,4]);

    if ActiveGridEH=DghMain then
    begin
      if cdsMain.Active then       //(cdsMain.UpdateStatus=usModified)
      if (cdsMain.ChangeCount>0)or(cdsMain.State in [dsEdit,dsInsert])    then
      begin
        tblCancel.Enabled:=True;
        actCancel.Enabled:=True;
      end
      else
      begin
        tblCancel.Enabled:=False;
        actCancel.Enabled:=False;
      end;
    end
    else
    if ActiveGridEH=dghChild then
    begin
      if (cdsChild.ChangeCount>0)or(cdsChild.State in [dsEdit,dsInsert])    then
      begin
        tblCancel.Enabled:=True;
        actCancel.Enabled:=True;
      end
      else
      begin
        tblCancel.Enabled:=False;
        actCancel.Enabled:=False;
      end;
    end;

    if ((cdsMain.State  in [dsEdit,dsInsert])or(cdsMain.ChangeCount>0))
                or((cdsChild.State  in [dsEdit,dsInsert])or(cdsChild.ChangeCount>0))and(StrToInt(vprev)in [2,4])  then
      begin
        tblSave.Enabled:=True;
        actSave.Enabled:=True;
        tblfind.Enabled:=False;
        actFind.Enabled:= False;
        tblRefresh.Enabled:=False;
        actRefresh .Enabled:= False;
        tblExport.Enabled:=False;
        actExport.Enabled:=False; //����
        tblExit.Enabled:=False;   //�˳�
        tblPrint.Enabled:= False;      //��ӡ
        tblDesign.Enabled:=False ;      //�������
        tblFilter.Enabled:= False;
        tblReject.Enabled:=False ;   //���ύ
        tblExpand.Enabled:=False ;   //�ύ
        tblConfirm.Enabled:=False;   //���
        tblUConfirm.Enabled:=False;  //�����
      end
    else
      begin
        tblSave.Enabled:=False;
        actSave.Enabled:=False;
        tblfind.Enabled:= True;
        actFind.Enabled:= True;
        tblRefresh .Enabled:=True;
        actRefresh .Enabled:=True;
        tblExport.Enabled:=True;
        actExport.Enabled:=True;
        tblExit.Enabled:=True;
        tblPrint.Enabled:= True   and (StrToInt(vprev)in [2,4]);      //��ӡ
        tblDesign.Enabled:=True   and (StrToInt(vprev)in [2,4]) ;      //�������
        tblFilter.Enabled:= True;
        tblReject.Enabled:=True   and (StrToInt(vprev)in [2,4]) ;   //���ύ
        tblExpand.Enabled:=True   and (StrToInt(vprev)in [2,4]) ;   //�ύ
        tblConfirm.Enabled:=True  and (StrToInt(vprev)in [2,4]);   //���
        tblUConfirm.Enabled:=True and (StrToInt(vprev)in [2,4]);  //�����
      end ;
  end;

 { with cdsMainstatus do    //����һ������,����״ֵ̬��Ȩ���룬���ô��ڵ���Щ����ɱ༭��
  if (AsInteger in [8,2])and (StrToInt(vprev) in [2,4]) then
  begin
    ControlsSetReadOnly([edt_code,edt_ware_name,edt_PO_REV_NO,edt_DEPT_NAME,
        edt_FOB,edt_CURR_CODE],False);
    DghMain .ReadOnly:=False;
    dghChild.ReadOnly:=False;
  end
  else
  begin
    ControlsSetReadOnly([edt_code,edt_ware_name,edt_PO_REV_NO,edt_DEPT_NAME,
        edt_FOB,edt_CURR_CODE]);
    DghMain .ReadOnly:=True;
    dghChild.ReadOnly:=True;
  end; }

  with ActiveGridEH do
  begin
    if  DataSource.DataSet.Eof  then
    begin
    tblNext.Enabled:=False ;
    tblLast.Enabled:=False ;
    end
    else
    begin
    tblNext.Enabled:=True ;
    tblLast.Enabled:=True ;
    end;

    if  DataSource.DataSet.Bof  then
    begin
    tblPrior.Enabled:=False     ;
    tblFirst.Enabled:=False     ;
    end
    else
    begin
    tblPrior.Enabled:=True     ;
    tblFirst.Enabled:=True     ;
    end;
  end;

  if tblExit.Enabled then
     actClose.ImageIndex:=102
  else
     actClose.ImageIndex:=107;

  if tblAdd.Enabled then
     actAdd.ImageIndex:=3
  else
     actAdd.ImageIndex:=58;

  if tblEdit.Enabled then
     actEdit.ImageIndex:=4
  else
     actEdit.ImageIndex:=62;

  if tblSave.Enabled then
     actSave.ImageIndex:=137
  else
     actSave.ImageIndex:=60; // 60

  if tblCancel.Enabled then
     actCancel.ImageIndex:=5
  else
     actCancel.ImageIndex:=55;

  if tblDelete.Enabled then
     actDelete.ImageIndex:=6
  else
     actDelete.ImageIndex:=57;

  if tblFind.Enabled then
     actFind.ImageIndex:=17
  else
     actFind.ImageIndex:=64;

  if tblRefresh.Enabled then
     actRefresh.ImageIndex:=103
  else
     actRefresh.ImageIndex:=106;

  if tblFirst.Enabled then
     actFirst.ImageIndex:=99
  else
     actFirst.ImageIndex:=96;

  if tblPrior.Enabled then
     actPrior.ImageIndex:=95
  else
     actPrior.ImageIndex:=94;

  if tblNext.Enabled then
     actNext.ImageIndex:=100
  else
     actNext.ImageIndex:=101;

  if tblLast.Enabled then
     actlast.ImageIndex:=97
  else
     actLast.ImageIndex:=98;

  if tblDesign.Enabled then
     actDesign.ImageIndex:=127
  else
     actDesign.ImageIndex:=132;

  if tblExpand.Enabled then
     actExpand.ImageIndex:=131
  else
     actExpand.ImageIndex:=135;

  if tblReject.Enabled then
     actReject.ImageIndex:=130
  else
     actReject.ImageIndex:=136;

  if tblPrint.Enabled then
     actPrint.ImageIndex:=19
  else
     actPrint.ImageIndex:=66;

  if tblExport.Enabled then   //����EXCEL��ť
     actExport.ImageIndex:=119
  else
     actExport.ImageIndex:=120;

  if tblCancelFilter.Enabled then
     actCancelFilter.ImageIndex:= 128
  else
     actCancelFilter.ImageIndex:=133;

  if tblFilter.Enabled then
     actFilter.ImageIndex:=    129
  else
     actFilter.ImageIndex:= 134;

  if tblConfirm.Enabled then
     actConfirm.ImageIndex:=114
  else
     actConfirm.ImageIndex:= 116; //actUConfirm

  if tblUConfirm.Enabled then
     actUConfirm.ImageIndex:=115
  else
     actUConfirm.ImageIndex:= 117;

  dxBarManager.LockUpdate:=False;
end;

procedure TMC_f.ChildDataSetOpen;
begin          
  if (cdsChild.F_Foreignkey<>'') and(cdsChild.F_Primarykey<>'')then
  with  cdsChild do
  begin
    Close;
    if cdsMain.FieldByName(F_Primarykey).DataType in [ftString,ftMemo,ftWideString ] then
    begin
      if  F_SQLWhere='' then
        CommandText:= F_SQLSelectFrom+#13+'where '+F_Foreignkey+'='+QuotedStr(Trim(cdsMain.FieldByName(F_Primarykey).AsString ))
      else
        CommandText:= F_SQLSelectFrom+#13+F_SQLWhere+#13+'and '+F_Foreignkey+'='+QuotedStr(Trim(cdsMain.FieldByName(F_Primarykey).AsString));
    end
    else
    if cdsMain.FieldByName(F_Primarykey).DataType in [ftSmallint,ftInteger,ftWord,ftCurrency,ftFloat,ftAutoInc] then
    begin
      if  F_SQLWhere='' then
        begin
          if cdsMain.FieldByName(F_Primarykey).IsNull then
            CommandText:= F_SQLSelectFrom+#13+'where '+F_Foreignkey+'= null'
          else
           CommandText:= F_SQLSelectFrom+#13+'where '+F_Foreignkey+'='+IntToStr(cdsMain.FieldByName(F_Primarykey).AsInteger)
        end
      else
        begin
          if cdsMain.FieldByName(F_Primarykey).IsNull then
            CommandText:= F_SQLSelectFrom+#13+F_SQLWhere+#13+'and '+F_Foreignkey+' = null'
          else
            CommandText:= F_SQLSelectFrom+#13+F_SQLWhere+#13+'and '+F_Foreignkey+' = '+IntToStr(cdsMain.FieldByName(F_Primarykey).AsInteger);
        end;
    end;
    if  F_SQLOrderBy<>'' then
    CommandText:=CommandText+#13+F_SQLOrderBy;
    Open;
  end;
end;

function TMC_f.DeleteSaveData():Boolean;
  function AllDelete():Boolean;
  begin
    Result:=True;
    try
      Screen.Cursor := crHourGlass;
      try
        DM.ADOConnection1.BeginTrans;
        try
          cdsMain.F_IsBatchOperating :=True;
          cdsChild.F_IsBatchOperating:=True;
          while cdsChild.IsEmpty=false do
          cdsChild.Delete;

          cdsMain.Delete;
          if IsLog then
          Log_Add(Data_Info) ;
          if cdsChild.ApplyUpdates(0)=0 then    //=0��������ɹ�
          begin
            with cdsMain do
            begin
              if ChangeCount >0 then
              if ApplyUpdates(0)=0 then     //����0������ʧ��
              begin
                if IsLog then
                begin
                  if Log_Save then
                    begin
                      DM.ADOConnection1.CommitTrans ;
                    end
                  else
                    begin
                      DM.ADOConnection1.RollbackTrans;
                      Result:=False;
                    end;
                end
                else
                DM.ADOConnection1.CommitTrans;

              end
              else
              begin
                DM.ADOConnection1.RollbackTrans;
                Result:=False;
              end;
            end;
          end
          else
            begin
            DM.ADOConnection1.RollbackTrans;
            Result:=False;
            end;

          
          ChildDataSetOpen;
        finally
          cdsChild.F_IsBatchOperating:=False;
          cdsMain.F_IsBatchOperating:=False;
        end;
      except
        if  DM.ADOConnection1.InTransaction then
        DM.ADOConnection1.RollbackTrans;
        Result:=False;
        cdsMain.CancelUpdates;
        cdsChild.CancelUpdates;
        ChildDataSetOpen;
      end;
    finally
      Screen.Cursor := crDefault;
    end;
  end;
var
  i:integer;
  Msg_Delete:string;
begin
  Result:=True;
  with ActiveGridEH.DataSource.DataSet as Tcds  do
  if Active and (not IsEmpty) then
  begin
    if IsMC then
      Msg_Delete:=Msg_Delete_0
    else
      Msg_Delete:=Msg_Delete_1;

    if (ActiveGridEH= dghchild)then    //������ӱ��
    begin
      if(dghchild.DataSource.DataSet.RecordCount=1) then   //����ӱ�ֻ��һ�м�¼
      begin
        if IsMC then
        begin
          if  messagebox(Self.Handle,'�ӱ��ֻ��һ�м�¼����Ҫɾ����ǰ���ŵ�����?ɾ���󽫲��ָܻ���','ѯ��',MB_YESNO+MB_iconquestion)=idyes then
          begin
             if AllDelete =False then
             Result:=False;
          end;
        end
        else
          Delete;
      end
      else          //����ӱ����һ�м�¼
      begin
        try
          if ActiveGridEH.SelectedRows.Count >1 then  //����û�ѡ�����������1�������С�
          begin
            F_IsBatchOperating:=True;         //���ѡ����Ƕ��У�������һ��ɾ������״̬FIsBatchOperating����Ϊ��
            for i:= ActiveGridEH.SelectedRows.Count -1 downto 0 do
            begin
              GotoBookmark(pointer(ActiveGridEH.SelectedRows.Items[i]));
              Delete;        //ɾ�����С�
            end;
          end
          else      //  //����û�ѡ�������=1��
            Delete;
        finally
          F_IsBatchOperating:=False;   //ɾ�������󣬸�λ
        end;
      end;
    end
    else
    if (ActiveGridEH= dghMain)then     //��������������
    if DeleteBeforeCheck then
    begin
      if messagebox(Self.Handle,PChar(Msg_Delete),'ѯ��',MB_YESNO+MB_iconquestion)=idYes then
      if AllDelete =False then
        Result:=False;
    end;
  end;
  dsMainStateChange(nil);
end;

function TMC_f.SaveData():Boolean;
begin
  Result:=False;
  try
    Screen.Cursor := crHourGlass;
    try
      DM.ADOConnection1.BeginTrans;
      with cdsMain do
      begin
        if F_AutoNumb and(UpdateStatus=usInserted) then
        begin
          if RecordExists('select * from '+f_TableName+' where ' +f_AutoNumbField
            +' = '+quotedStr(fieldByName(F_AutoNumbField).AsString),DM.cdsRead)  then//�����ǰ�Զ���ű�ʹ��,��������ڱ�����û��򿪲�¼��������ͻᷢ����
          begin
            DM.cds0004.Refresh;   //��ȡ�Զ���ŵ�����ֵ
            while RecordExists('select * from '+f_TableName+' where ' +f_AutoNumbField
              +' = '+quotedStr(DM.cds0004.FieldByName('SEED_VALUE').AsString),DM.cdsRead)  do  //�������ֵ���Զ���Ż��Ǵ���
            begin
              NewNumb(DM.cds0004);  //���ù����ڵ�ǰ����ϼ�1
            end;
            if not(State in[dsEdit,dsInsert]) then
            Edit;
            FieldByName(F_AutoNumbField).Value:=DM.cds0004.FieldByName('SEED_VALUE').Value;
            Post;
          end;
          NewNumb(DM.cds0004);  //���ù����ڵ�ǰ����ϼ�1��
        end;

        if State in [dsEdit,dsInsert] then
          Post;
        if cdsChild.State in [dsEdit,dsInsert] then
          cdsChild.Post;

        if (IsLog) then
        if Log_Add(Data_Info)=False  then
          Exit;

        if ApplyUpdates(0)=0 then    //=0��������ɹ�
        begin
          with cdsChild do
          begin
            if State in [dsEdit,dsInsert] then
              Post;

            if ApplyUpdates(0)=0 then     //����0������ʧ��
            begin
              if IsLog then
              begin
                if Log_Save() then
                begin
                  DM.ADOConnection1.CommitTrans;    //����1
                  Result:=True;
                end
                else
                begin
                  DM.ADOConnection1.RollbackTrans;
                end;
              end
              else
              begin
                DM.ADOConnection1.CommitTrans;         //����2
                Result:=True;
              end;
            end
            else
            begin
              DM.ADOConnection1.RollbackTrans;
            end;
          end;
        end
        else
        begin
          DM.ADOConnection1.RollbackTrans;
        end
      end;

    except
      DM.ADOConnection1.RollbackTrans;
    end;
    dsMainStateChange(nil);
  finally
    Screen.Cursor := crDefault;
  end;
end;

procedure TMC_f.dghChildDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
begin
  inherited;
  with  (Sender as TDBGridEh)do
  begin
    if ((State=[gdSelected]))then
      Canvas.Brush.Color:=clInactiveCaption;           //���ñ��ѡ���������ɫ
    DefaultDrawColumnCell(Rect,datacol,Column,state);
  end;
end;

procedure TMC_f.dghChildEnter(Sender: TObject);
begin
  inherited;
  ActiveGridEH:=(Sender as TDBGridEh);
  dsMainStateChange(nil);
  DghReadOnlyFocus(Sender As TDBGridEh);
end;

procedure TMC_f.dghChildGetCellParams(Sender: TObject; Column: TColumnEh;
  AFont: TFont; var Background: TColor; State: TGridDrawState);
begin
  inherited;
  if (Sender as TDBGridEh).SumList.RecNo mod 2 = 1 then
   Background := $00FFC4C4;
end;

procedure TMC_f.actAddExecute(Sender: TObject);
begin
  inherited;
  with ActiveGridEH.DataSource.DataSet as TClientDataSet do
  Append;
end;

procedure TMC_f.actCancelExecute(Sender: TObject);
begin
  inherited;
  with ActiveGridEH.DataSource.DataSet as Tcds do
  if Active then
  begin
    if ActiveGridEH.DataSource.DataSet=cdsMain then
    begin
      if (cdsMain.UpdateStatus=usInserted)or(cdsMain.State=dsInsert) then    //���������״̬�ǲ��룬���ӱ��ȫ��ȡ��
      begin
        cdsChild.Cancel;
        cdsChild.CancelUpdates;

        cdsMain.Cancel;
        cdsMain.CancelUpdates;
      end
      else
      if (cdsMain.UpdateStatus=usModified)or(cdsMain.State=dsEdit) then
      begin
        cdsMain.Cancel;
        cdsMain.CancelUpdates;
      end;
    end
    else
    if ActiveGridEH.DataSource.DataSet=cdsChild then
    begin
      if cdsChild.State in [dsInsert,dsEdit] then    //����ӱ���״̬�ǲ�����޸ģ��ӱ��ǰ��¼ȡ��
        cdsChild.Cancel
      else
        cdsChild.UndoLastChange(True)  ;  
    end;
    dsMainStateChange(dsMain);
  end;
end;

procedure TMC_f.actCancelFilterExecute(Sender: TObject);
begin
  inherited;
  dxBarManager.LockUpdate:=True;
  if tblCancelFilter.Enabled then
     actCancelFilter.ImageIndex:= 128
  else
     actCancelFilter.ImageIndex:=133;

  if tblFilter.Enabled then
     actFilter.ImageIndex:=    129
  else
     actFilter.ImageIndex:= 134;
  dxBarManager.LockUpdate:=False;
end;

procedure TMC_f.actDeleteExecute(Sender: TObject);
begin
  inherited;
  if ActiveGridEH.DataSource.DataSet=cdsChild then
  if cdsChild.State=dsInsert then
  cdsChild.Cancel;
  DeleteSaveData  ;
end;

procedure TMC_f.actEditExecute(Sender: TObject);
begin
  inherited;
  with ActiveGridEH.DataSource.DataSet as TClientDataSet do
  if Active and IsEmpty=False then
    Edit;
end;

procedure TMC_f.actExportExecute(Sender: TObject);
begin
  OutputExcelStd(Self,ActiveGridEH);
end;

procedure TMC_f.actFilterExecute(Sender: TObject);
begin
  inherited;
  dxBarManager.LockUpdate:=True;
  if tblCancelFilter.Enabled then
     actCancelFilter.ImageIndex:= 128
  else
     actCancelFilter.ImageIndex:=133;

  if tblFilter.Enabled then
     actFilter.ImageIndex:=    129
  else
     actFilter.ImageIndex:= 134;
  dxBarManager.LockUpdate:=False;
end;

procedure TMC_f.actFirstExecute(Sender: TObject);
begin
  inherited;
  with ActiveGridEH.DataSource.DataSet do
  begin
    First;
  end;
end;

procedure TMC_f.actLastExecute(Sender: TObject);
begin
  inherited;
  with ActiveGridEH.DataSource.DataSet do
  begin
    Last;
  end;
end;

procedure TMC_f.actNextExecute(Sender: TObject);
begin
  inherited;
  with ActiveGridEH.DataSource.DataSet do
  begin
    Next;
  end;
end;

procedure TMC_f.actPriorExecute(Sender: TObject);
begin
  inherited;
  with ActiveGridEH.DataSource.DataSet do
  begin
    Prior;
  end;
end;

procedure TMC_f.actRefreshExecute(Sender: TObject);
var
  bm_M:Pointer;
  I_rkey:Integer;
  str_AutoNumb:string;
begin
  inherited;
  with  cdsMain  do
  if ((F_AutoIncrField<>'')and (FieldByName(F_AutoIncrField).IsNull  =False)or
     (F_AutoNumbField<>'')and (FieldByName(F_AutoNumbField).IsNull  =False)
     )then
    begin
      if  (F_AutoIncrField<>'')and (FieldByName(F_AutoIncrField).IsNull  =False) then
      begin
        I_rkey := cdsMain.FieldByName(cdsMain.F_AutoIncrField).Value;
        cdsMain.Close;
        cdsChild.Close;
        cdsMain.Open;
        cdsMain.Locate(cdsMain.F_AutoIncrField,I_rkey,[]) ;
        ChildDataSetOpen;
      end
      else
      begin
        str_AutoNumb:= cdsMain.FieldByName(cdsMain.F_AutoNumbField).Value;
        cdsMain.Close;
        cdsChild.Close;
        cdsMain.Open;
        cdsMain.Locate(cdsMain.F_AutoIncrField,str_AutoNumb,[]) ;
        ChildDataSetOpen;
      end;
    end
  else
  begin
    try
      try
        bm_M:=cdsMain.GetBookmark;
        cdsMain.Close;
        cdsChild.Close;
        cdsMain.Open;
        ChildDataSetOpen;
        cdsMain.GotoBookmark(bm_M);
      except

      end;
      cdsMainAfterScroll(cdsMain   ) ;
    finally
      cdsMain.FreeBookmark(bm_M);
    end;
  end;
end;

procedure TMC_f.actSaveExecute(Sender: TObject);
begin
  inherited;
  if SaveBeforeCheck then
    SaveData
  else
    Abort;
end;

procedure TMC_f.cdsChildAfterScroll(DataSet: TDataSet);
begin
  inherited;
  with(DataSet as Tcds)   do
  if (F_IsBatchOperating =False)and(DghMain.SelectedRows.Count<=1) then
  begin
    if ActiveGridEH.DataSource.DataSet=DataSet then
    begin
      dxBarManager.LockUpdate:=True;
      if  DataSet.Eof  then
      begin
        tblNext.Enabled:=False ;
        actNext.Enabled:=False ;
        tblLast.Enabled:=False ;
        actLast.Enabled:=False ;
      end
      else
      begin
        tblNext.Enabled:=True ;
        actNext.Enabled:=True ;
        tblLast.Enabled:=True ;
        actLast.Enabled:=True ;
      end;
      if  DataSet.Bof  then
      begin
        tblPrior.Enabled:=False     ;
        actPrior.Enabled:=False     ;
        tblFirst.Enabled:=False     ;
        actFirst.Enabled:=False     ;
      end
      else
      begin
        tblPrior.Enabled:=True     ;
        actPrior.Enabled:=True     ;
        tblFirst.Enabled:=True     ;
        actFirst.Enabled:=True     ;
      end;

      if tblFirst.Enabled then
         actFirst.ImageIndex:=99
      else
         actFirst.ImageIndex:=96;

      if tblPrior.Enabled then
         actPrior.ImageIndex:=95
      else
         actPrior.ImageIndex:=94;

      if tblNext.Enabled then
         actNext.ImageIndex:=100
      else
         actNext.ImageIndex:=101;

      if tblLast.Enabled then
         actlast.ImageIndex:=97
      else
         actLast.ImageIndex:=98;

      if tblDownload.Enabled then
        actDownload.ImageIndex:=0
      else
        actDownload.ImageIndex:=59 ;

      dxBarManager.LockUpdate:=False;
    end;
    dsMainStateChange(dsMain);
    SetButtonStatus;
  end;
end;

procedure TMC_f.cdsMainAfterCancel(DataSet: TDataSet);
begin
  inherited;
  cdsMain.F_IsCancel:=False;
end;

procedure TMC_f.cdsMainAfterInsert(DataSet: TDataSet);
begin
  inherited;
  {  ��δ��룬���Ǵӻ����Ƶ���Ҫ��Ӧ�ó����аɣ���Ϊ����ÿһ��������Ҫ�����Ĺ��ܡ�
  if cxTabSheetMain2.TabVisible  then
  begin
    if cxPageControl1.ActivePageIndex=0 then
      cxPageControl1.ActivePageIndex:=1;
    if  FirstControl<>nil then
      FirstControl.SetFocus;
  end; }
  ColNotReadOnlyFocus(Self,DataSet);
end;

procedure TMC_f.cdsMainAfterScroll(DataSet: TDataSet);
begin
  inherited;
  try
    Screen.Cursor := crHourGlass;

    if cdsMain.F_IsBatchOperating=False then
    ChildDataSetOpen;
    with(DataSet as Tcds)   do
    if (F_IsBatchOperating =False)and(DghMain.SelectedRows.Count<=1) then
    begin
      dxStatusBar1.Panels[0].Text:='��ǰ��¼��:'+IntToStr(RecNo)+'/�ܼ�¼��:'+ IntToStr(RecordCount);
      if ActiveGridEH.DataSource.DataSet=DataSet then
      begin
        dxBarManager.LockUpdate:=True;
        if  DataSet.Eof  then
        begin
          tblNext.Enabled:=False ;
          actNext.Enabled:=False ;
          tblLast.Enabled:=False ;
          actLast.Enabled:=False ;
        end
        else
        begin
          tblNext.Enabled:=True ;
          actNext.Enabled:=True ;
          tblLast.Enabled:=True ;
          actLast.Enabled:=True ;
        end;
        if  DataSet.Bof  then
        begin
          tblPrior.Enabled:=False     ;
          actPrior.Enabled:=False     ;
          tblFirst.Enabled:=False     ;
          actFirst.Enabled:=False     ;
        end
        else
        begin
          tblPrior.Enabled:=True     ;
          actPrior.Enabled:=True     ;
          tblFirst.Enabled:=True     ;
          actFirst.Enabled:=True     ;
        end;

        if tblFirst.Enabled then
           actFirst.ImageIndex:=99
        else
           actFirst.ImageIndex:=96;

        if tblPrior.Enabled then
           actPrior.ImageIndex:=95
        else
           actPrior.ImageIndex:=94;

        if tblNext.Enabled then
           actNext.ImageIndex:=100
        else
           actNext.ImageIndex:=101;

        if tblLast.Enabled then
           actlast.ImageIndex:=97
        else
           actLast.ImageIndex:=98;

        if tblDownload.Enabled then
          actDownload.ImageIndex:=0
        else
          actDownload.ImageIndex:=59 ;

        dxBarManager.LockUpdate:=False;
      end;
      dsMainStateChange(nil);
      SetButtonStatus;
    end;
  finally    
    Screen.Cursor := crDefault;
  end;
end;

procedure TMC_f.cdsMainReconcileError(DataSet: TCustomClientDataSet;
  E: EReconcileError; UpdateKind: TUpdateKind; var Action: TReconcileAction);
begin
  inherited;
  MsgError('����ʧ�ܣ�ԭ���ǣ�'+E.Message);
  actCancelExecute(nil);
end;

procedure TMC_f.cxTabSheetChild2MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  cxTabSheetChild2.SetFocus;
  ActiveGridEH:=dghChild;
  dsMainStateChange(nil);
end;

procedure TMC_f.cxTabSheetMain2MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  cxTabSheetMain2.SetFocus;
  ActiveGridEH:=DghMain;
  dsMainStateChange(nil);
end;

procedure TMC_f.DghMainDrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
begin
  inherited;
  with  (Sender as TDBGridEh)do
  begin                      //   or (State=[gdSelected,gdFocused] )
    if ((State=[gdSelected]))then
      Canvas.Brush.Color:=clInactiveCaption;           //���ñ��ѡ���������ɫ
    DefaultDrawColumnCell(Rect,datacol,Column,state);
  end;
end;

procedure TMC_f.DghMainEnter(Sender: TObject);
begin
  inherited;
  ActiveGridEH:=(Sender as TDBGridEh);
  dsMainStateChange(nil);
  DghReadOnlyFocus(Sender As TDBGridEh);
end;

procedure TMC_f.DghMainGetCellParams(Sender: TObject; Column: TColumnEh;
  AFont: TFont; var Background: TColor; State: TGridDrawState);
begin
  inherited;
  if (Sender as TDBGridEh).SumList.RecNo mod 2 = 1 then     // .SumList
   Background := $00FFC4C4;
end;

procedure TMC_f.DghMainKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key in[VK_INSERT,VK_delete] then   //  , VK_down
  begin
    Key:=0;
  end;

  if (ssAlt in Shift)  and  (Key=86) then       //Alt+V
  with   (Sender as TDBGridEh).DataSource do
  begin
    if   DataSet is TADOQuery then
      showmessage((DataSet as  TADOQuery).SQL.Text)
    else
    if  DataSet is TADODataSet then
       showmessage((DataSet as  TADODataSet).CommandText)
    else
    if   DataSet is TClientDataSet then
      showmessage((DataSet as  TClientDataSet).CommandText)  ;
  end;
  if (ssCtrl in Shift)  and  (Key=67) then //67 C
  begin
  
  end;
end;

procedure TMC_f.DghMainTitleClick(Column: TColumnEh);
var
  OldIndex: string;
begin
  inherited;
  if  Column.Grid.DataSource.DataSet.Active then
  if  Column.Field<>nil then
  begin
    if ( Column.Field.DataType <> ftBlob)and(Column.Field.FieldKind=fkData) then
    with (Column.Grid.DataSource.DataSet as TClientDataSet) do
    begin
      OldIndex:= cdsMain.IndexName;
      if OldIndex <> '' then
      begin
        IndexName:= '';
        DeleteIndex(OldIndex);
      end;
      case Column.Title.SortMarker of
        smNoneEh,smUpEh  :
        begin
          AddIndex(column.Field.FieldName, Column.Field.FieldName, [ixDescending]);
          Column.Title.SortMarker:= smDownEh;
        end;
        smDownEh:
        begin
          AddIndex(column.Field.FieldName, Column.Field.FieldName, [ixPrimary]);
          Column.Title.SortMarker:= smUpEh;
        end;
      end;
      IndexName:= column.Field.FieldName;
    end;
  end;
end;

procedure TMC_f.dsMainStateChange(Sender: TObject);
begin
  inherited;
  if  NeedSave then //1108���޸ģ�����Ҫ���д���ֻ����Ҫ�������棬��ִ�����еĴ��룬����20141030�����
  //20141118��������ע�͵Ĵ�������Ϊ��Ч��ԭ����PpCutting3_frm���и���ԭ�򣬵���Ч����ִ�й�������ť��ˢ�¡�
  if (cdsMain.F_IsBatchOperating<>True)
              or(cdsChild.F_IsBatchOperating<>True) then              //ֻ��������=false ��ʱ�򣬲�ִ�а�ťˢ�¡�
  begin
    SetToolbarButtonStatus(ActiveGridEH.DataSource.DataSet.State in[dsEdit,dsInsert]=False)
  end;
  SetButtonStatus;    //���ݼ���״̬��������ʱ�����������ұ�����������״̬��20141116���
end;

procedure TMC_f.FormClose(Sender: TObject; var Action: TCloseAction);
var
  s:integer;
begin
  inherited;
  if (cdsMain.Active)and(cdsChild.Active)and(NeedSave) then
  if (cdsMain.ChangeCount>0)or(cdsMain.State in [dsInsert,dsEdit])
     or(cdsChild.ChangeCount>0)or(cdsChild.State in [dsInsert,dsEdit])then
  begin
    s:=messagebox(Self.Handle,'���ݻ�û�б��棬��Ҫ������','ѯ��',MB_yesnocancel+MB_iconquestion)  ;
    if s=idyes then
      begin
        if SaveBeforeCheck then
          SaveData
        else
          Abort;
      end
    else
    if s=idCancel then
    begin
      Abort;
    end
    else
    if s=idNo then
    begin
      cdsChild.Cancel;
      cdsChild.CancelUpdates;
      cdsMain.Cancel;
      cdsMain.CancelUpdates;
      if DghMain.SumList.Active then
      DghMain.SumList.Active:=False;
    end;
  end;
  if DghMain.SumList.Active then
  DghMain.SumList.Active:=False;
  if dghChild.SumList.Active then
  dghChild.SumList.Active:=False;
end;

procedure TMC_f.FormCreate(Sender: TObject);
begin
  if IsLog    then
  begin
    SetLength(Data_Info,2);
    Data_Info[0]:=TDataInfo.Create();
    with Data_Info[0] do
    begin
      L_DataSetName :=cdsMain;
      L_Rkey        :='rkey';     //Ĭ��Ϊ rkey,�����޸�
      L_TableName   :=cdsMain.F_TableName;
      L_IsWrite     :=True;
    end;
    Data_Info[1]:=TDataInfo.Create();
    with Data_Info[1] do
    begin
      L_DataSetName :=cdsChild;
      L_Rkey        :='rkey';     //Ĭ��Ϊ rkey,�����޸�
      L_TableName   :=cdsChild.F_TableName;
      L_IsWrite     :=True;
    end;
    PCName:=getpcName;
    N_SeeLog.Visible:=True;
  end;
  inherited;
  cxPageControl1.ActivePageIndex :=0 ;
  cxPageControl2.ActivePageIndex :=0 ;
  IsMC:=True;
  ActiveControl:=DghMain;
  ActiveGridEH:=DghMain;
  RightsSetDataSetReadOnly ;
  ResetGridColumns(Self,dm.ADOConnection1,UserRKEY,StrToInt(vprev)=2);
end;

procedure TMC_f.FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  inherited;
  if Key = vk_return then
  begin
    if self.ActiveControl=LastControl then
      dghChild.SetFocus
    else
      if (self.ActiveControl<>DghMain)and(self.ActiveControl<>dghChild)then
      SelectNext(ActiveControl, True, True)
  end;
end;

procedure TMC_f.cdsMainBeforeScroll(DataSet: TDataSet);
begin
  inherited;  //���ݼ����ǰ������������ݼ����޸Ļ���룬���档
  if cdsMain.F_AutoSave then
  if cdsMain.F_IsBatchOperating=False then
  if NeedSave then
  if (cdsMain.State  in [dsEdit,dsInsert])or(cdsMain.ChangeCount>0)
              or(cdsChild.State  in [dsEdit,dsInsert])or(cdsChild.ChangeCount>0)then
  if cdsMain.F_IsCancel=False then
  begin
    if SaveBeforeCheck then
      SaveData
    else
      Abort;
  end;
end;

procedure TMC_f.cdsMainBeforeCancel(DataSet: TDataSet);
begin
  inherited;
  cdsMain.F_IsCancel:=True;
end;

procedure TMC_f.DghMainKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  KeyPressDBGridEH(Sender as TDBGridEh, key,self);
end;

procedure TMC_f.dghChildKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  KeyPressDBGridEH(Sender as TDBGridEh, key,self);
end;

procedure TMC_f.cdsChildAfterInsert(DataSet: TDataSet);
begin
  inherited;
  ColNotReadOnlyFocus(Self,DataSet);
end;

procedure TMC_f.cdsMainAfterClose(DataSet: TDataSet);
begin
  inherited;
  cdsChild.Close;
end;

procedure TMC_f.dspChildAfterUpdateRecord(Sender: TObject;
  SourceDS: TDataSet; DeltaDS: TCustomClientDataSet;
  UpdateKind: TUpdateKind);
begin
  inherited;
  if cdsChild.F_AutoIncrField<>'' then
  if UpdateKind= ukInsert then      //��δ���������ǿͻ��˻�ȡ�Զ���ŵ�ֵ��
  begin
     with dtRead  do
     begin
       Close;
       CommandText:='select @@identity';
       Open;
       DeltaDS.FieldByName(cdsChild.F_AutoIncrField).ReadOnly:=False;
       DeltaDS.FieldByName(cdsChild.F_AutoIncrField).NewValue:=dtRead.Fields[0].Value;
       Close;
     end;
  end;
end;

procedure TMC_f.dspChildBeforeUpdateRecord(Sender: TObject;
  SourceDS: TDataSet; DeltaDS: TCustomClientDataSet;
  UpdateKind: TUpdateKind; var Applied: Boolean);
begin
  inherited;
  if (cdsChild.F_Foreignkey<>'') and (cdsChild.F_Primarykey<>'')then
  begin
    if cdsMain.F_AutoIncrField<>'' then
    begin
      if(UpdateKind = ukInsert)and(DeltaDS.FieldByName(cdsChild.F_Foreignkey).AsInteger<=0)then
      begin
        if DeltaDS.BOF then               //ֻ���ǵ�һ�е�ʱ�򣬲���Ҫִ�в�ѯ��ȡ@@identity
        begin
          with    DM.dtReadRkey do
          begin
            Close;
            CommandText:='select @@identity';  // @@identity
            Open;
          end;
        end;
        DeltaDS.FieldByName(cdsChild.F_Foreignkey).NewValue := DM.dtReadRkey.Fields[0].AsInteger;
      end;
    end
    else
    begin
      DeltaDS.FieldByName(cdsChild.F_Foreignkey).NewValue:=cdsMain.FieldByName(cdsChild.F_Primarykey).Value;
    end;
  end;
end;

procedure TMC_f.cdsChildBeforeClose(DataSet: TDataSet);
begin
  inherited;
  with DataSet as TClientDataSet do
  if ((State in [dsInsert,dsEdit])or(ChangeCount>0))
    and (NeedSave) then
  if messagebox(Self.Handle,'���ݻ�û�б��棬��Ҫ������','��ʾ',MB_yesno+MB_iconquestion)  =mrYes then
  actSaveExecute(nil);
end;

procedure TMC_f.cdsMainBeforeClose(DataSet: TDataSet);
var
  i:Integer;
begin
  inherited;
  with   (DataSet as TClientDataSet) do
  if  IndexName<>'' then
  DeleteIndex(IndexName) ;               //����Ѵ��ڵ�����

  with   DghMain    do
  for i:=0 to Columns.Count-1  do      //�������е�����״̬
  begin
    if  Columns[i].Title.SortMarker<> smNoneEh   then
    Columns[i].Title.SortMarker:= smNoneEh;
  end;
end;

procedure TMC_f.FormShow(Sender: TObject);
var
  i:Integer;
begin
  inherited;
  
  cxPageControl1.ActivePageIndex:=0;
  cxPageControl2.ActivePageIndex:=0;
  for I := 0 to cxTabSheetMain2.ControlCount - 1 do
  begin
    if cxTabSheetMain2.Controls[i] is  TDBEdit then
      (cxTabSheetMain2.Controls[i]as TDBEdit).OnEnter:=Edit_Enter
    else
    if cxTabSheetMain2.Controls[i] is  TDBComboBox then
      (cxTabSheetMain2.Controls[i]as TDBComboBox).OnEnter:=Edit_Enter
    else
    if cxTabSheetMain2.Controls[i] is TDBRadioGroup  then
      (cxTabSheetMain2.Controls[i]as TDBRadioGroup).OnEnter:=Edit_Enter
    else
    if cxTabSheetMain2.Controls[i] is TDBButtonEdit  then
      (cxTabSheetMain2.Controls[i]as TDBButtonEdit).OnEnter:=Edit_Enter
    else
    if cxTabSheetMain2.Controls[i] is  TDBMemo then
      (cxTabSheetMain2.Controls[i]as TDBMemo).OnEnter:=Edit_Enter
    else
    if cxTabSheetMain2.Controls[i] is  TDBCheckBox then
      (cxTabSheetMain2.Controls[i]as TDBCheckBox).OnEnter:=Edit_Enter;
  end;

  with DM.cds0004  do
  begin
    if Active=False then
    begin
      CommandText:='select * from data0004 where Table_Name='+QuotedStr(cdsMain.F_TableName)  ;
      Open;

      if FieldByName('SEED_FLAG').AsInteger=4 then
      begin
        cdsMain.F_AutoNumb:=True;
        SetColsReadOnly(DghMain,[cdsMain.F_AutoNumbField]);
        //DghMain.FieldColumns[cdsMain.F_AutoNumbField].ReadOnly:=True;
        if  AutoNumb_Edit<>nil then
        begin
          AutoNumb_Edit.ReadOnly:=True;
          ControlsSetReadOnly([AutoNumb_Edit]);
          //AutoNumb_Edit.Color:=clInactiveCaptionText;

        end;
      end;
    end;
  end;  
end;

procedure TMC_f.N_ReloginClick(Sender: TObject);
begin
  inherited;
  Relogin;
end;

procedure TMC_f.cdsChildReconcileError(DataSet: TCustomClientDataSet;
  E: EReconcileError; UpdateKind: TUpdateKind;
  var Action: TReconcileAction);
begin
  inherited;
  MsgError('����ʧ�ܣ�ԭ���ǣ�'+E.Message);
  cdsChild.CancelUpdates;
  cdsChild.Refresh;
  cdsMain.CancelUpdates;
  cdsMain.Refresh;
end;

procedure TMC_f.dghChildKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if Key in[VK_INSERT,VK_delete] then
  begin
    Key:=0;
  end;
    
  if (ssAlt in Shift)  and  (Key=86) then       //Alt+V
  with   (Sender as TDBGridEh).DataSource do
  begin
    if   DataSet is TADOQuery then
      showmessage((DataSet as  TADOQuery).SQL.Text)
    else
    if  DataSet is TADODataSet then
       showmessage((DataSet as  TADODataSet).CommandText)
    else
    if   DataSet is TClientDataSet then
      showmessage((DataSet as  TClientDataSet).CommandText)  ;
  end;
end;

procedure TMC_f.DghMainMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  SetMultiSelectButtonStatus;
end;

procedure TMC_f.MainGrid_PopupMenuPopup(Sender: TObject);
begin
  inherited;   // ActiveControl
  if ActiveControl is TDBGridEh then
    N_ResetColumns.Visible:=True
  else
    N_ResetColumns.Visible:=False;
end;

procedure TMC_f.N_ResetColumnsClick(Sender: TObject);
begin
  inherited;
  show_ColsDisplaySet_frm (Self,ActiveGridEH,UserRKEY) ;
end;

procedure TMC_f.cdsChildNewRecord(DataSet: TDataSet);
begin
  inherited;
  if (cdsMain.State <>dsInsert)and(cdsMain.UpdateStatus<>usInserted)then      //���ӱ�����ֶθ�ֵ
  if (cdsChild.F_Foreignkey<>'') and(cdsChild.F_Primarykey<>'')then
  cdsChild.FieldByName(cdsChild.F_Foreignkey).Value:=cdsMain.FieldByName(cdsChild.F_Primarykey).AsString  ;
end;

procedure TMC_f.cdsMainNewRecord(DataSet: TDataSet);
begin
  inherited;
  with  DataSet as Tcds do
  begin
    if F_AutoNumb then
    begin
      FieldByName(F_AutoNumbField).Value:=DM.cds0004.FieldByName('SEED_VALUE').Value;
    end;
  end;
end;

procedure TMC_f.dghChildMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  SetMultiSelectButtonStatus;
end;

procedure TMC_f.N_SeeLogClick(Sender: TObject);
begin
  inherited;
  if ActiveGridEH =DghMain then
    Log_See(cdsMain.F_TableName,cdsMain.fieldByName('rkey').AsInteger)
  else
    Log_See(cdsChild.F_TableName,cdsChild.fieldByName('rkey').AsInteger);
end;

procedure TMC_f.FormDestroy(Sender: TObject);
var
  i:Integer;
begin
  inherited;
  for i:=0 to High(Data_Info) do
  Data_Info[i].Free;
end;

procedure TMC_f.N2Click(Sender: TObject);
begin
  inherited;
  SetFrozenField(Self,ActiveGridEH,ActiveGridEH.SelectedField.FieldName,UserRKEY);
end;

procedure TMC_f.N3Click(Sender: TObject);
begin
  inherited;
  CancelFrozenField(Self,ActiveGridEH,UserRKEY);
end;

procedure TMC_f.cdsMainAfterOpen(DataSet: TDataSet);
begin
  inherited;
  ChildDataSetOpen;
end;

end.
