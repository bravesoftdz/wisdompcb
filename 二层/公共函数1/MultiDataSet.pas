unit MultiDataSet;

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
  RzEdit, RzDBEdit, RzDBBnEd, DBButtonEdit, Menus;

type
  TMultiDataSet_f = class(TToolbar_f)
    cxTabControl1: TcxTabControl;
    Panel1: TPanel;
    Panel2: TPanel;
    Panel4: TPanel;
    cxPageControl1: TcxPageControl;
    cxTabSheetMain1: TcxTabSheet;
    ToolBar2: TToolBar;
    cxTabSheetMain2: TcxTabSheet;
    Panel6: TPanel;
    dlgOpen1: TOpenDialog;
    dsChild: TDataSource;
    dspChild: TDataSetProvider;
    cdsChild: Tcds;
    dtChild: TADODataSet;
    MainGrid_PopupMenu: TPopupMenu;
    DghMain: TDBGridEh;
    dghChild: TDBGridEh;
    Panel5: TPanel;
    RzToolbar1: TRzToolbar;
    Button1: TButton;
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
    procedure cdsChildReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
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
    procedure cdsChildBeforeEdit(DataSet: TDataSet);
    procedure cdsChildBeforeInsert(DataSet: TDataSet);
    procedure cdsReadReconcileError(DataSet: TCustomClientDataSet;
      E: EReconcileError; UpdateKind: TUpdateKind;
      var Action: TReconcileAction);
    procedure cdsMainBeforeInsert(DataSet: TDataSet);
    procedure cdsMainBeforeScroll(DataSet: TDataSet);
    procedure cdsMainBeforeCancel(DataSet: TDataSet);
    procedure DghMainKeyPress(Sender: TObject; var Key: Char);
    procedure dghChildKeyPress(Sender: TObject; var Key: Char);
    procedure cdsChildAfterInsert(DataSet: TDataSet);
    procedure cdsMainAfterClose(DataSet: TDataSet);
    procedure dspChildAfterUpdateRecord(Sender: TObject;
      SourceDS: TDataSet; DeltaDS: TCustomClientDataSet;
      UpdateKind: TUpdateKind);
    procedure cdsMainBeforeOpen(DataSet: TDataSet);
    procedure cdsChildBeforeOpen(DataSet: TDataSet);
    procedure dspChildBeforeUpdateRecord(Sender: TObject;
      SourceDS: TDataSet; DeltaDS: TCustomClientDataSet;
      UpdateKind: TUpdateKind; var Applied: Boolean);
    procedure cdsChildBeforeClose(DataSet: TDataSet);
//    procedure FormKeyDown(Sender: TObject; var Key: Word;
//      Shift: TShiftState);
//    procedure WinControlKeyDown(Sender: TObject; var Key: Word;
//          Shift: TShiftState);
    procedure cdsMainBeforeClose(DataSet: TDataSet);
    procedure dghChildTitleClick(Column: TColumnEh);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  protected
    MainDataSetRkey:Integer;
 //   procedure DBEditKeyPress(Sender: TObject; var Key: Char);virtual;
    function SaveBeforeCheck ():Boolean  ; virtual;// override;
    function SaveData():Boolean; virtual;
    function DeleteSaveData():Boolean  ;virtual;
    procedure ChildDataSetOpen;virtual;
    procedure SetToolbarButtonStatus(Flag: Boolean); virtual;
    
//    procedure WinControlKeyPress(Sender: TObject; var Key: Char) ;
  public
    ActiveGridEH:TDBGridEh;
    { Public declarations }
  end;

var
  MultiDataSet_f: TMultiDataSet_f;

implementation

uses DM_f,  PublicFile;
// formSelect,

{$R *.dfm}
function TMultiDataSet_f.SaveBeforeCheck():Boolean  ;
var
  strMsg:string;
//  I_Row :Integer;
begin
  Result:=True;
  with cdsMain do
  begin
    if State in [dsEdit ,dsInsert] then
    Post;
//    if FieldByName('number').IsNull then //���쵥��
//      strMsg:=strMsg+'�ֶΣ���'+FieldByName('number').DisplayLabel+'����ֵ����Ϊ�գ�����'+#13;
  end;

  with cdsChild do
  begin
    if State in [dsEdit ,dsInsert] then
    Post;
//    if IsEmpty then
//      strMsg:=strMsg+'��ϸ������Ҫ��һ�м�¼������'+#13
//    else
    begin
//      try
//        DisableControls ;
//        First;
//        for I_Row:=0 to RecordCount-1 do
//        begin
//          if FieldByName('INVENT_PTR').IsNull then //���ϱ���
//            strMsg:=strMsg+'��ϸ���'+IntToStr(I_Row+1)+'�У��ֶΣ���'+FieldByName('INV_PART_NUMBER').DisplayLabel+'����ֵ����Ϊ�գ�����'+#13;
//          if (FieldByName('QUAN_BOM').IsNull)or(FieldByName('QUAN_BOM').Value<=0) then //��������
//            strMsg:=strMsg+'��ϸ���'+IntToStr(I_Row+1)+'�У��ֶΣ���'+FieldByName('QUAN_BOM').DisplayLabel+'����ֵ�������0������'+#13;
//          Next;
//        end;
//      finally
//        EnableControls;
//      end;
    end;
  end;

  if strMsg<>'' then
  begin
    MsgError(Copy(strMsg,0,Length(strMsg)-1));
    Result:=False;
  end;
end;

procedure TMultiDataSet_f.SetToolbarButtonStatus(Flag: Boolean);
begin
//vprev��LABLE������Ȩ�޿ؼ�����3λ������4�޸ģ�5ɾ����6�ύ��7��ˣ�8�˻أ�9������10��ӡ��11������ƣ�����5λ��չ��
 // fRight:='111111111111111111';
  dxBarManager.LockUpdate:=True;
  with   ActiveGridEH.DataSource.DataSet as TClientDataSet do
  begin
    tblAdd.Enabled:=Flag and (StrToInt(vprev)in [2,4]);
    actAdd.Enabled:=Flag and (StrToInt(vprev)in [2,4]);

    tblEdit.Enabled:=Flag and (StrToInt(vprev)in [2,4]);
    actEdit.Enabled:=Flag and (StrToInt(vprev)in [2,4]);

    tblDelete.Enabled:=( Flag)and(IsEmpty=False) and (StrToInt(vprev)in [2,4]);
    actDelete.Enabled:=( Flag)and(IsEmpty=False) and (StrToInt(vprev)in [2,4]);

    tblCancel.Enabled:=not Flag;
    actCancel.Enabled:=not Flag;
    if ActiveGridEH=DghMain then
    begin
      if cdsMain.Active then
      if (cdsMain.UpdateStatus=usModified)or(cdsMain.State in [dsEdit,dsInsert])    then
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

procedure TMultiDataSet_f.ChildDataSetOpen;
begin
  if (cdsChild.IndexFieldNames<>'') and(cdsChild.MasterFields<>'')then
  with  cdsChild do
  begin
    Close;
    if cdsMain.FieldByName(MasterFields).DataType in [ftString,ftMemo,ftWideString ] then
    begin
      if  F_SQLWhere='' then
        CommandText:= F_SQLSelectFrom+#13+'where '+IndexFieldNames+'='+cdsMain.FieldByName(MasterFields).AsString
      else
        CommandText:= F_SQLSelectFrom+#13+F_SQLWhere+#13+'and '+IndexFieldNames+'='+cdsMain.FieldByName(MasterFields).AsString;
    end
    else
    if cdsMain.FieldByName(MasterFields).DataType in [ftSmallint,ftInteger,ftWord,ftCurrency,ftFloat,ftAutoInc] then
    begin
      if  F_SQLWhere='' then
        CommandText:= F_SQLSelectFrom+#13+'where '+IndexFieldNames+'='+IntToStr(cdsMain.FieldByName(MasterFields).AsInteger)
      else
        CommandText:= F_SQLSelectFrom+#13+F_SQLWhere+#13+'and '+IndexFieldNames+'='+IntToStr(cdsMain.FieldByName(MasterFields).AsInteger);
    end;
    if  F_SQLOrderBy<>'' then
    CommandText:=CommandText+#13+F_SQLOrderBy;
    //ShowMessage(CommandText);
    Open;
  end;
end;

{procedure TMC_f.WinControlKeyPress(Sender: TObject; var Key: Char) ;
var
  i:Integer;
begin
  if key=#13 then
  begin
    if  Sender is TDBEditBit then
    begin
      with (Sender as TDBEditBit) do
      if  tag=1 then
      if  Trim(Text)='' then
      begin
        (Sender as TDBEditBit).ClickForm((Sender as TDBEditBit).FButton);
        Exit;
      end;
    end
    else
    if  Sender is TDBComboBox then
    begin
      with (Sender as TDBComboBox) do
      if  tag=1 then
      if  Trim(Text)='' then
      begin
        (Sender as TDBComboBox).DroppedDown := true;
        Key:=Char( 0);
        Exit;
      end;
    end
    else
    if  Sender is TDBEdit then
    begin
      with (Sender as TDBEdit) do
      if  tag=1 then
      if  Trim(Text)='' then
        Exit;
    end
    else
    if  Sender is TDBMemo then
    begin
      with (Sender as TDBMemo) do
      if  tag=1 then
      if  Trim(Text)='' then
        Exit;
    end    ;

    if Sender   =LastControl then
    begin
      dghChild.SetFocus;
      Exit;
    end;

    with (Sender as TWinControl).Parent do
    for   i:=0 to ControlCount-1 do
    begin
//        if (Controls[i] is TCustomRadioGroup) then
//        begin
//          postmessage(self.handle,wm_keydown,vk_tab,0);
//        end
//        else
        if (Controls[i] is TWinControl)then
        begin
          if (Controls[i] as TWinControl).Visible then
          if (Controls[i] as TWinControl).TabOrder= (Sender as TWinControl).TabOrder+1 then
          begin
           // ShowMessage(Controls[i].Name+':'+inttostr(i));
            (Controls[i] as TWinControl).SetFocus;
            Exit;
          end ;
        end;
    end;  
   // postmessage(self.handle,wm_keydown,vk_tab,0);
  end
end;    }
   {
procedure TMC_f.DBEditKeyPress(Sender: TObject; var Key: Char) ;
var
  i:Integer;
begin
  if key=#13 then
  begin
    if  Sender is TDBEditBit then
    begin
      with (Sender as TDBEditBit) do
      if  Field.Required then
      if  Trim(Text)='' then
      begin
        (Sender as TDBEditBit).ClickForm((Sender as TDBEditBit).FButton);
        Exit;
      end;
    end
    else
    if  Sender is TDBComboBox then
    begin
      with (Sender as TDBComboBox) do
      if  Field.Required then
      if  Trim(Text)='' then
      begin
        (Sender as TDBComboBox).DroppedDown := true;
        Key:=Char( 0);
        Exit;
      end;
    end
    else
    if  Sender is TDBEdit then
    begin
      with (Sender as TDBEdit) do
      if  Field.Required then
      if  Trim(Text)='' then
        Exit;
    end
    else
    if  Sender is TDBMemo then
    begin
      with (Sender as TDBMemo) do
      if  Field.Required then
      if  Trim(Text)='' then
        Exit;
    end    ;

    if Sender   =LastControl then
    begin
      dghChild.SetFocus;
//      actSave.OnExecute(nil);
//      actAdd.OnExecute(nil);
//      FirstControl.SetFocus;
      Exit;
    end;
    with (Sender as TWinControl).Parent do
    for   i:=0 to ControlCount-1 do
    begin
//        if (Controls[i] is TCustomRadioGroup) then
//        begin
//          postmessage(self.handle,wm_keydown,vk_tab,0);
//        end
//        else
        if (Controls[i] is TWinControl)then
        begin
          if (Controls[i] as TWinControl).Visible then
          if (Controls[i] as TWinControl).TabOrder= (Sender as TWinControl).TabOrder+1 then
          begin
            ShowMessage(Controls[i].Name+':'+inttostr(i));
            (Controls[i] as TWinControl).SetFocus;
            Exit;
          end ;
        end;
    end;
   // postmessage(self.handle,wm_keydown,vk_tab,0);
  end

 // TWinControl(LasControl).SetFocus;
//1.�ڿؼ���keypress�¼��м���
//if key=#13 then        postmessage(self.handle,wm_keydown,vk_tab,0);
//2.formKeyDown�¼���
//if key = #13 then  SelectNext(ActiveControl, True, True);
////3.form.keydown�¼�
//if key=#13 then    postmessage(handle,wm_nextdlgctl,0,0);
////4. keypress�¼�   begin
//if key=#13 then     perform(WM_NEXTDLGCTL,0,0);
////5.keypress�¼�
//  if key=#13 then
//  begin
//
//    if  LastControl<>nil then
//    begin
//      if  (Sender as TWinControl)= LastControl then
//        dghChild.SetFocus
//      else
//        postmessage(self.handle,wm_keydown,vk_tab,0);
//    end
//    else
//      postmessage(self.handle,wm_keydown,vk_tab,0);
//  end

//6.keydown�¼�
//if ( Key = VK_RETURN )  then         keybd_event(VK_TAB,0x0ff,0,0);
end;   }

function TMultiDataSet_f.DeleteSaveData():Boolean;
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
          if cdsChild.ApplyUpdates(0)=0 then    //=0��������ɹ�
          begin
            with cdsMain do
            begin
              if ChangeCount >0 then
              if ApplyUpdates(0)=0 then     //����0������ʧ��
              begin
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
        cdsMain.CancelUpdates;
        cdsChild.CancelUpdates;
        ChildDataSetOpen;
      end;
    finally
      Screen.Cursor := crDefault;
    end;
  end;
var // s,
  i:integer;
begin
  Result:=True;
  with ActiveGridEH.DataSource.DataSet as Tcds  do
  if Active and (not IsEmpty) then
  begin
    if (ActiveGridEH= dghchild)then    //������ӱ��
    begin
      if(dghchild.DataSource.DataSet.RecordCount=1) then   //����ӱ�ֻ��һ�м�¼
      begin
        if  messagebox(Self.Handle,'�ӱ�ֻ��һ�м�¼����Ҫɾ����ǰ���ŵ�����?ɾ���󽫲��ָܻ���','ѯ��',MB_YESNO+MB_iconquestion)=idyes then
        begin
           AllDelete;
        end;
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
    begin
      if messagebox(Self.Handle,'��ȷ��Ҫɾ����ǰѡ�����ŵ�����?ɾ���󽫲��ָܻ���','ѯ��',MB_YESNO+MB_iconquestion)=idYes then
      if AllDelete =False then
        Result:=False;
    end;
  end;
  dsMainStateChange(nil);
end;

function TMultiDataSet_f.SaveData():Boolean;
begin
  Result:=True;
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

        if ApplyUpdates(0)=0 then    //=0��������ɹ�
        begin
          with cdsChild do
          begin
            if State in [dsEdit,dsInsert] then
              Post;

            if ApplyUpdates(0)=0 then     //����0������ʧ��
            begin
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

procedure TMultiDataSet_f.dghChildDrawColumnCell(Sender: TObject; const Rect: TRect;
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

procedure TMultiDataSet_f.dghChildEnter(Sender: TObject);
begin
  inherited;
  ActiveGridEH:=(Sender as TDBGridEh);
  dsMainStateChange(nil);
  DghReadOnlyFocus(Sender As TDBGridEh);
end;

procedure TMultiDataSet_f.dghChildGetCellParams(Sender: TObject; Column: TColumnEh;
  AFont: TFont; var Background: TColor; State: TGridDrawState);
begin
  inherited;
  if (Sender as TDBGridEh).SumList.RecNo mod 2 = 1 then     // .SumList
   Background := $00FFC4C4;
end;

procedure TMultiDataSet_f.actAddExecute(Sender: TObject);
begin
  inherited;
  with ActiveGridEH.DataSource.DataSet as TClientDataSet do
  Append;
end;

procedure TMultiDataSet_f.actCancelExecute(Sender: TObject);
begin
  inherited;
  with ActiveGridEH.DataSource.DataSet as Tcds do
  if Active then
  begin
    if ActiveGridEH.DataSource.DataSet=cdsMain then
    begin
//      if cdsMain.State in [dsInsert,dsEdit] then    //����ӱ���״̬�ǲ�����޸ģ��ӱ��ǰ��¼ȡ��
//        cdsMain.Cancel;
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
        cdsChild.Cancel;
    end;
//    F_IsCancel:=True;
//    Cancel;
//    CancelUpdates;

    dsMainStateChange(dsMain);
 //   ChildDataSetOpen;
  end;
end;

procedure TMultiDataSet_f.actCancelFilterExecute(Sender: TObject);
begin
  inherited;
  with ActiveGridEH do
  begin
//    if  STFilter.Visible then
//    begin
//      STFilter.Visible := false ;
//      ClearFilter;
//      DataSource.DataSet.Filtered:=false;//��ʾȫ������
//      tblCancelFilter.Enabled:=False;
//      tblFilter.Enabled:=true;
//    end;
  end;

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

procedure TMultiDataSet_f.actDeleteExecute(Sender: TObject);
begin
  inherited;
  if ActiveGridEH.DataSource.DataSet=cdsChild then
  if cdsChild.State=dsInsert then
  cdsChild.Cancel;
  DeleteSaveData  ;
end;

procedure TMultiDataSet_f.actEditExecute(Sender: TObject);
begin
  inherited;
  with ActiveGridEH.DataSource.DataSet as TClientDataSet do
  if Active and IsEmpty=False then
    Edit;
end;

procedure TMultiDataSet_f.actExportExecute(Sender: TObject);
begin
  OutputExcelStd(Self,ActiveGridEH);
end;

procedure TMultiDataSet_f.actFilterExecute(Sender: TObject);
begin
  inherited;
  with ActiveGridEH do
  begin
    begin
//      if STFilter.Local=False then
//        STFilter.Local:=True;
////
//      if  STFilter.Visible=false then
//      begin
//        STFilter.Visible := True ;      //�����Զ�����
//        tblCancelFilter.Enabled:=True;
//        actCancelFilter.Enabled:=True;
//        tblFilter.Enabled:=False;
//      end ;
    end;
  end;
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

procedure TMultiDataSet_f.actFirstExecute(Sender: TObject);
begin
  inherited;
  with ActiveGridEH.DataSource.DataSet do
  begin
    First;
  end;
end;

procedure TMultiDataSet_f.actLastExecute(Sender: TObject);
begin
  inherited;
  with ActiveGridEH.DataSource.DataSet do
  begin
    Last;
  end;
end;

procedure TMultiDataSet_f.actNextExecute(Sender: TObject);
begin
  inherited;
  with ActiveGridEH.DataSource.DataSet do
  begin
    Next;
  end;
end;

procedure TMultiDataSet_f.actPriorExecute(Sender: TObject);
begin
  inherited;
  with ActiveGridEH.DataSource.DataSet do
  begin
    Prior;
  end;
end;

procedure TMultiDataSet_f.actRefreshExecute(Sender: TObject);
begin
  inherited;
  if ActiveGridEH.DataSource.DataSet = cdsMain then
  begin
    if Active then
    begin
      Refresh;
      cdsMainAfterScroll(cdsMain   ) ;
    end;
  end
  else
  if ActiveGridEH.DataSource.DataSet = cdsChild then
  begin
    if Active then
    begin
      Refresh;
      cdsChildAfterScroll(cdsChild   ) ;
    end;
  end;

//  with ActiveGridEH.DataSource.DataSet as TClientDataSet do
//  if Active then
//  if ActiveGridEH = dghChild then
//  begin
//    if (cdsMain.UpdateStatus<>usInserted)and(cdsMain.F_AutoIncrField<>'')and(cdsMain.FieldByName(cdsMain.F_AutoIncrField).IsNull)then
//    cdsMain.Refresh;
//    cdsMainAfterScroll(cdsMain   ) ;
//  end
//  else
//  begin
//    Refresh;
//  end;
end;

procedure TMultiDataSet_f.actSaveExecute(Sender: TObject);
begin
  inherited;
  if SaveBeforeCheck then
    SaveData
  else
    Abort;
end;

procedure TMultiDataSet_f.cdsChildAfterScroll(DataSet: TDataSet);
begin
  inherited;
  with(DataSet as Tcds)   do    //
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

procedure TMultiDataSet_f.cdsChildBeforeEdit(DataSet: TDataSet);
//var
//  BM:Pointer;
begin
  inherited;
//  if actEdit.Enabled=False then   //����޸İ�ť���ɵ�������ܽ����޸�״̬��
//  Abort;
end;

procedure TMultiDataSet_f.cdsChildBeforeInsert(DataSet: TDataSet);

begin
  inherited;
//  if actAdd.Enabled=False then   //����޸İ�ť���ɵ�������ܽ����޸�״̬��
//  Abort;
end;

procedure TMultiDataSet_f.cdsChildReconcileError(DataSet: TCustomClientDataSet;
  E: EReconcileError; UpdateKind: TUpdateKind; var Action: TReconcileAction);
begin
  inherited;
 // HandleReconcileError(DataSet,UpdateKind,e);
  MsgError('����ʧ�ܣ�ԭ���ǣ�'+E.Message);
  cdsChild.CancelUpdates;
  cdsChild.Refresh;
  cdsMain.CancelUpdates;
  cdsMain.Refresh;

end;

procedure TMultiDataSet_f.cdsMainAfterCancel(DataSet: TDataSet);
begin
  inherited;
  cdsMain.F_IsInsert:=False;
  cdsMain.F_IsCancel:=False;
end;

procedure TMultiDataSet_f.cdsMainAfterInsert(DataSet: TDataSet);
begin
  inherited;
  with  DataSet as Tcds do
  begin
    if F_AutoNumb then
    begin
      FieldByName(F_AutoNumbField).Value:=DM.cds0004.FieldByName('SEED_VALUE').Value;
      F_IsInsert:=True;
    end;
  end;

  if cxTabSheetMain2.TabVisible  then
  begin
    if cxPageControl1.ActivePageIndex=0 then
      cxPageControl1.ActivePageIndex:=1;
    if  FirstControl<>nil then
      FirstControl.SetFocus;
  end;
  ColNotReadOnlyFocus(Self,DataSet);
end;

procedure TMultiDataSet_f.cdsMainAfterScroll(DataSet: TDataSet);
begin
  inherited;
  try
    Screen.Cursor := crHourGlass;

    if cdsMain.F_IsBatchOperating=False then
    ChildDataSetOpen;
    with(DataSet as Tcds)   do    //
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

procedure TMultiDataSet_f.cdsMainReconcileError(DataSet: TCustomClientDataSet;
  E: EReconcileError; UpdateKind: TUpdateKind; var Action: TReconcileAction);
begin
  inherited;
  MsgError('����ʧ�ܣ�ԭ���ǣ�'+E.Message);
  actCancelExecute(nil);
end;

procedure TMultiDataSet_f.cdsReadReconcileError(DataSet: TCustomClientDataSet;
  E: EReconcileError; UpdateKind: TUpdateKind; var Action: TReconcileAction);
begin
  inherited;
  MsgError('����ʧ�ܣ�ԭ���ǣ�'+E.Message);
end;

procedure TMultiDataSet_f.cxTabSheetChild2MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;

  ActiveGridEH:=dghChild;
  dsMainStateChange(nil);
end;

procedure TMultiDataSet_f.cxTabSheetMain2MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  inherited;
  cxTabSheetMain2.SetFocus;
  ActiveGridEH:=DghMain;
  dsMainStateChange(nil);
end;

procedure TMultiDataSet_f.DghMainDrawColumnCell(Sender: TObject; const Rect: TRect;
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

procedure TMultiDataSet_f.DghMainEnter(Sender: TObject);
begin
  inherited;
  ActiveGridEH:=(Sender as TDBGridEh);
  dsMainStateChange(nil);
  DghReadOnlyFocus(Sender As TDBGridEh);
end;

procedure TMultiDataSet_f.DghMainGetCellParams(Sender: TObject; Column: TColumnEh;
  AFont: TFont; var Background: TColor; State: TGridDrawState);
begin
  inherited;
  if (Sender as TDBGridEh).SumList.RecNo mod 2 = 1 then     // .SumList
   Background := $00FFC4C4;
end;

procedure TMultiDataSet_f.DghMainKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
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

procedure TMultiDataSet_f.DghMainTitleClick(Column: TColumnEh);
var
  OldIndex: string;
begin
  inherited;
//  if not( Column.Field.DataType = ftBlob) then                            //Tblobfield����������������
//  (Column.Grid.DataSource.DataSet as TClientDataSet).IndexFieldNames
//  :=column.Field.FieldName;
  if  Column.Grid.DataSource.DataSet.Active then
  if not( Column.Field.DataType = ftBlob) then
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

procedure TMultiDataSet_f.dsMainStateChange(Sender: TObject);
begin
  inherited;
  
  if (cdsMain.F_IsBatchOperating<>True)
              or(cdsChild.F_IsBatchOperating<>True) then              //ֻ��������=false ��ʱ�򣬲�ִ�а�ťˢ�¡�
  begin
    SetToolbarButtonStatus(ActiveGridEH.DataSource.DataSet.State in[dsEdit,dsInsert]=False)
  end;
end;

procedure TMultiDataSet_f.FormClose(Sender: TObject; var Action: TCloseAction);
var
  s:integer;
begin
  if (cdsMain.Active)and(cdsChild.Active) then
  if (cdsMain.ChangeCount>0)or(cdsMain.State in [dsInsert,dsEdit])
     or(cdsChild.ChangeCount>0)or(cdsChild.State in [dsInsert,dsEdit])then
  begin
    s:=messagebox(Self.Handle,'���ݻ�û�б��棬��Ҫ������','��ʾ',MB_yesnocancel+MB_iconquestion)  ;
    if s=idyes then
      SaveData()
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
    end;
  end;
end;

procedure TMultiDataSet_f.FormCreate(Sender: TObject);
//var
//  I:Integer;
begin
  inherited;
  ActiveGridEH:=DghMain;
  if not(StrToInt(vprev) in [2,4]) then    //����������Ȩ�ޣ�����������ݼ��������޸ġ�
  begin
    cdsMain.ReadOnly:=True;
    cdsChild.ReadOnly:=True;
  end;
end;

procedure TMultiDataSet_f.cdsMainBeforeInsert(DataSet: TDataSet);
begin
  inherited;
  if actAdd.Enabled=False then   //����޸İ�ť���ɵ�������ܽ����޸�״̬��
  Abort;
end;

procedure TMultiDataSet_f.cdsMainBeforeScroll(DataSet: TDataSet);
begin
  inherited;  //���ݼ����ǰ������������ݼ����޸Ļ���룬���档
  if cdsMain.F_AutoSave then
  if cdsMain.F_IsBatchOperating=False then
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

procedure TMultiDataSet_f.cdsMainBeforeCancel(DataSet: TDataSet);
begin
  inherited;
  cdsMain.F_IsCancel:=True;
end;

procedure TMultiDataSet_f.DghMainKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  KeyPressDBGridEH(Sender as TDBGridEh, key,self);
end;

procedure TMultiDataSet_f.dghChildKeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  KeyPressDBGridEH(Sender as TDBGridEh, key,self);
end;

procedure TMultiDataSet_f.cdsChildAfterInsert(DataSet: TDataSet);
begin
  inherited;
  ColNotReadOnlyFocus(Self,DataSet);

  if (cdsMain.State <>dsInsert)and(cdsMain.UpdateStatus<>usInserted)then      //���ӱ�����ֶθ�ֵ
  if (cdsChild.IndexFieldNames<>'') and(cdsChild.MasterFields<>'')then
  cdsChild.FieldByName(cdsChild.IndexFieldNames).Value:=cdsMain.FieldByName(cdsChild.MasterFields).AsString  ;
end;

procedure TMultiDataSet_f.cdsMainAfterClose(DataSet: TDataSet);
begin
  inherited;
  cdsChild.Close;
end;

procedure TMultiDataSet_f.dspChildAfterUpdateRecord(Sender: TObject;
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

procedure TMultiDataSet_f.cdsMainBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  if StrToInt(vprev) in [1,3] then
  cdsMain.ReadOnly:=True;
end;

procedure TMultiDataSet_f.cdsChildBeforeOpen(DataSet: TDataSet);
begin
  inherited;
  if StrToInt(vprev) in [1,3] then
  cdsChild.ReadOnly:=True;
end;

procedure TMultiDataSet_f.dspChildBeforeUpdateRecord(Sender: TObject;
  SourceDS: TDataSet; DeltaDS: TCustomClientDataSet;
  UpdateKind: TUpdateKind; var Applied: Boolean);
begin
  inherited;
  if (cdsChild.IndexFieldNames<>'') and (cdsChild.MasterFields<>'')then
  begin
    if(UpdateKind = ukInsert)and(DeltaDS.FieldByName(cdsChild.IndexFieldNames).AsInteger<=0)then
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
      DeltaDS.FieldByName(cdsChild.IndexFieldNames).NewValue := DM.dtReadRkey.Fields[0].AsInteger;
    end;
  end;  
end;

procedure TMultiDataSet_f.cdsChildBeforeClose(DataSet: TDataSet);
//var
//  i:Integer;
begin
  inherited;
{  with   (DataSet as TClientDataSet) do
  if  IndexName<>'' then
  DeleteIndex(IndexName) ;               //����Ѵ��ڵ�����

  with   dghChild    do
  for i:=0 to Columns.Count-1  do      //�������е�����״̬
  begin
    if  Columns[i].Title.SortMarker<> smNoneEh   then
    Columns[i].Title.SortMarker:= smNoneEh;
  end;   }

  with DataSet as TClientDataSet do
  if (State in [dsInsert,dsEdit])or(ChangeCount>0) then
  if messagebox(Self.Handle,'���ݻ�û�б��棬��Ҫ������','��ʾ',MB_yesno+MB_iconquestion)  =mrYes then
  actSaveExecute(nil);
end;

{procedure TMC_f.WinControlKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = vk_return then
//  if  (Sender as TWinControl ).Tag=1 then
  begin
    if  Sender is TDBEditBit then
    begin
      with (Sender as TDBEditBit) do
      if  tag=1 then
      if  Trim(Text)='' then
      begin
        (Sender as TDBEditBit).ClickForm((Sender as TDBEditBit).FButton);
        Exit;
      end;
    end
    else
    if  Sender is TDBComboBox then
    begin
      with (Sender as TDBComboBox) do
      if  tag=1 then
      if  Trim(Text)='' then
      begin
        (Sender as TDBComboBox).DroppedDown := true;
 //       Key:=Char( 0);
        Exit;
      end;
    end
    else
    if  Sender is TDBEdit then
    begin
      with (Sender as TDBEdit) do
      if  tag=1 then
      if  Trim(Text)='' then
        Exit;
    end
    else
    if  Sender is TDBMemo then
    begin
      Key:=0;
      with (Sender as TDBMemo) do
      if  tag=1 then
      if  Trim(Text)='' then
      begin
        //
        Exit;
      end;
//    end
//    else
//    if  Sender is DBButtonEdit then
//    begin
//      with (Sender as DBButtonEdit) do
//      if  tag=1 then
//      if  Trim(Text)='' then
//        Exit;
    end    ;
    Postmessage(handle,WM_KEYDOWN,VK_TAB,0);
  end;

  if Key = vk_f1 then
  begin
    if  Sender is TDBButtonEdit then
    begin
      (Sender as TDBButtonEdit).ClickForm(nil);
    end;
  end;
end;   }

procedure TMultiDataSet_f.cdsMainBeforeClose(DataSet: TDataSet);
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

procedure TMultiDataSet_f.dghChildTitleClick(Column: TColumnEh);
//var
//  OldIndex: string;
begin
  inherited;
{  if  Column.Grid.DataSource.DataSet.Active then
  if not( Column.Field.DataType = ftBlob) then
  with (Column.Grid.DataSource.DataSet as TClientDataSet) do
  begin
    OldIndex:= IndexName;
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
  end;  }
end;

procedure TMultiDataSet_f.FormShow(Sender: TObject);
begin
  inherited;
  cxPageControl1.ActivePageIndex:=0;
end;

end.
