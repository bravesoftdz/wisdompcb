//����2014-8-1//
unit ColsDisplaySet_unt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ADODB, Provider, DB, DBClient, Grids, DBGridEh, Buttons,
  ToolWin, ComCtrls, StdCtrls, DBGrids;

type
  TFieldsCanNotSeeInfo=class
  public
    F_GridName   :TDBGridEh;     //������ĸ��������
    F_Fields     :array of string;// ������鿴���ֶ�
  end;

type
  TColsDisplaySet_frm = class(TForm)
    tlb1: TToolBar;
    btPost: TSpeedButton;
    btCancel: TSpeedButton;
    bt_Reset: TSpeedButton;
    btPrior: TSpeedButton;
    btNext: TSpeedButton;
    btClose: TSpeedButton;
    DBGridEh1: TDBGridEh;
    dsColsSetM: TDataSource;
    cdsRead: TClientDataSet;
    dspRead: TDataSetProvider;
    dtRead: TADODataSet;
    cdsColsSetM: TClientDataSet;
    dspColsSetM: TDataSetProvider;
    dtColsSetM: TADODataSet;
    cdsColsSetMRkey: TAutoIncField;
    cdsColsSetMColsSet_ptr: TIntegerField;
    cdsColsSetMFieldName: TStringField;
    cdsColsSetMDisplayOrder: TIntegerField;
    cdsColsSetMDisplayWidth: TIntegerField;
    cdsColsSetMIsDisplay: TBooleanField;
    dtColsSet: TADODataSet;
    dspColsSet: TDataSetProvider;
    cdsColsSet: TClientDataSet;
    cdsColsSetMFormName: TStringField;
    cdsColsSetMGridName: TStringField;
    dtColsSetMFormName: TStringField;
    dtColsSetMGridName: TStringField;
    dtColsSetMRkey: TAutoIncField;
    dtColsSetMColsSet_ptr: TIntegerField;
    dtColsSetMFieldName: TStringField;
    dtColsSetMDisplayOrder: TIntegerField;
    dtColsSetMDisplayWidth: TIntegerField;
    dtColsSetMIsDisplay: TBooleanField;
    cdsColsSetRkey: TIntegerField;
    cdsColsSetD419_ptr: TIntegerField;
    cdsColsSetD073_ptr: TIntegerField;
    cdsColsSetFormName: TStringField;
    cdsColsSetGridName: TStringField;
    cdsColsSetFrozenField: TStringField;
    cdsColsSetMDisplayLabel: TStringField;
    cdsLabel: TClientDataSet;
    dtReadRkey: TADODataSet;
    cds_ColsOriginal: TClientDataSet;
    cds_ColsOriginalFormName: TStringField;
    cds_ColsOriginalGridName: TStringField;
    cds_ColsOriginalRkey: TAutoIncField;
    cds_ColsOriginalColsSet_ptr: TIntegerField;
    cds_ColsOriginalFieldName: TStringField;
    cds_ColsOriginalDisplayOrder: TIntegerField;
    cds_ColsOriginalDisplayWidth: TIntegerField;
    cds_ColsOriginalIsDisplay: TBooleanField;
    cds_Grid: TClientDataSet;
    cds_GridFormName: TStringField;
    cds_GridGridName: TStringField;
    cds_GridFrozenField: TStringField;
    procedure cdsColsSetMDisplayOrderChange(Sender: TField);
    procedure cdsColsSetMAfterScroll(DataSet: TDataSet);
    procedure DBGridEh1GetCellParams(Sender: TObject; Column: TColumnEh;
      AFont: TFont; var Background: TColor; State: TGridDrawState);
    procedure btPostClick(Sender: TObject);
    procedure bt_ResetClick(Sender: TObject);
    procedure btNextClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure DBGridEh1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btCloseClick(Sender: TObject);
    procedure dsColsSetMStateChange(Sender: TObject);
    procedure btCancelClick(Sender: TObject);
    procedure btPriorClick(Sender: TObject);
    procedure dspColsSetAfterUpdateRecord(Sender: TObject;
      SourceDS: TDataSet; DeltaDS: TCustomClientDataSet;
      UpdateKind: TUpdateKind);
    procedure dspColsSetMAfterUpdateRecord(Sender: TObject;
      SourceDS: TDataSet; DeltaDS: TCustomClientDataSet;
      UpdateKind: TUpdateKind);
    procedure cdsColsSetMAfterOpen(DataSet: TDataSet);
    procedure cdsColsSetMBeforeClose(DataSet: TDataSet);
    procedure dspColsSetMBeforeUpdateRecord(Sender: TObject;
      SourceDS: TDataSet; DeltaDS: TCustomClientDataSet;
      UpdateKind: TUpdateKind; var Applied: Boolean);
    procedure FormDestroy(Sender: TObject);
  private
    Operat_bool:Boolean;           //�����ֶ��Ƿ���Ҫ���
    Int_data0419_Rkey:Integer;    //D419��RKEYֵ
    OperatingGrid:TDBGridEh;         //��ǰ���ڸı������Եı�����
    function  GetD419Rkey(): Integer;
    procedure SetStatus ;
    Function  AllowedSee(vprev_bool:Boolean;CheckField,GridName:string):Boolean;
    { Private declarations }
  public
    { Public declarations }
  end;
                                                                       //�����������ļ����������ñ���У���Create��SHOW�¼��е���
  procedure ResetGridColumns(SetForm:TForm;var AConn:TADOConnection;D073_ptr:Integer;SeeRight:Boolean);//StdCall;
                                                                       //��ʾ��������ô��壬�ɵ������Ƿ�ɼ�
  Function  show_ColsDisplaySet_frm(SetForm:TForm;AGridEh:TDBGridEh;D073_ptr:Integer):Boolean;
                                                                       //�������иı�λ�û��ȣ��ڴ���ر�ʱѯ���Ƿ񱣴浽�����ļ��У��ڴ����Close�¼��е���
  procedure SaveColsInfo(SetForm:TForm;D073_ptr:Integer);
                                                                       //���ö������
  Function     SetFrozenField(SetForm:TForm;AGridEh:TDBGridEh;ColName:string;D073_ptr:Integer):Boolean;    //
  Function  CancelFrozenField(SetForm:TForm;AGridEh:TDBGridEh;D073_ptr:Integer):Boolean;    //
  function CountVisibleCol(ADgh:TDBGridEh;AColName:string):Integer;//�����ַ����ڱ��Ŀɿ��к�
var
  ColsDisplaySet_frm: TColsDisplaySet_frm;

  FieldsCanNotSee_Info: array of TFieldsCanNotSeeInfo;
{ �����ֶε����÷���,Ҫ��ResetGridColumns֮ǰִ�С�
  SetLength( FieldsCanNotSee_Info,1)  ;
  FieldsCanNotSee_Info[0]:=TFieldsCanNotSeeInfo.Create();
  FieldsCanNotSee_Info[0].F_GridName:=dghChild;
  FieldsCanNotSee_Info[0].F_Fields:=VarArrayOF(['EMPLOYEE_NAME']);}

implementation

uses damo;


{$R *.dfm}

Function CancelFrozenField(SetForm:TForm;AGridEh:TDBGridEh;D073_ptr:Integer):Boolean;
begin
  Result:=False;
  with  ColsDisplaySet_frm do
  begin
    cdsColsSet.Filtered:=False ;
    cdsColsSet.Filter:='FormName='+QuotedStr(SetForm.Name)+' and GridName='+QuotedStr(AGridEh.Name);
    cdsColsSet.Filtered:=True ;
    if cdsColsSet.IsEmpty then
    begin
      cdsColsSet.Append;
      cdsColsSet.FieldByName('D419_ptr').Value    := Int_data0419_Rkey;
      cdsColsSet.FieldByName('D073_ptr').Value    := D073_ptr;
      cdsColsSet.FieldByName('FormName').Value    := SetForm.Name;
      cdsColsSet.FieldByName('GridName').Value    := AGridEh.Name;
      cdsColsSet.FieldByName('FrozenField').Value := null;
      if cdsColsSet.ApplyUpdates(0)=0 then
        Result:=True;
    end
    else
    begin
      cdsColsSet.Edit;
      cdsColsSet.FieldByName('FrozenField').Value := null;
      if cdsColsSet.ApplyUpdates(0)=0 then
        Result:=True;
    end;
    AGridEh.FrozenCols:= 0;
  end;
end;

Function SetFrozenField(SetForm:TForm;AGridEh:TDBGridEh;ColName:string;D073_ptr:Integer):Boolean;
begin
  Result:=False;
  with  ColsDisplaySet_frm do
  begin
    cdsColsSet.Filtered  :=False ;
    cdsColsSet.Filter    :='FormName='+QuotedStr(SetForm.Name)+' and GridName='+QuotedStr(AGridEh.Name);
    cdsColsSet.Filtered  :=True ;
    if cdsColsSet.IsEmpty then
    begin
      cdsColsSet.Append;
      cdsColsSet.FieldByName('D419_ptr').Value    := Int_data0419_Rkey;
      cdsColsSet.FieldByName('D073_ptr').Value    := D073_ptr;
      cdsColsSet.FieldByName('FormName').Value    := SetForm.Name;
      cdsColsSet.FieldByName('GridName').Value    := AGridEh.Name;
      cdsColsSet.FieldByName('FrozenField').Value := ColName;
      if cdsColsSet.ApplyUpdates(0)=0 then
        Result:=True;
    end
    else
    begin
      cdsColsSet.Edit;
      cdsColsSet.FieldByName('FrozenField').Value := ColName;
      if cdsColsSet.ApplyUpdates(0)=0 then
        Result:=True;
    end;
    AGridEh.FrozenCols:= CountVisibleCol(AGridEh,ColName);
   // AGridEh.FrozenCols:= AGridEh.FieldColumns[ColName].Index+1;
  end;
end;

function CountVisibleCol(ADgh:TDBGridEh;AColName:string):Integer;
var
  i,j:Integer;
begin
  Result:=0;
  j:=0;
  for i:=0 to   ADgh.Columns.Count-1 do
  begin
    if ADgh.Columns[i].Visible then
    j:=j+1;
    if  UpperCase(ADgh.Columns[i].FieldName)=UpperCase(AColName)then
    begin
      Result:=j;
      Exit;
    end;
  end;
end;

procedure SaveColsInfo(SetForm:TForm;D073_ptr:Integer);
var
  colsCount:Integer;
  AGridEh:TDBGridEh;
  SaveChange:Boolean;  //����ı�ı������
begin
  with  ColsDisplaySet_frm do
  try
    SaveChange:=False;
    Screen.Cursor := crHourGlass;

    cds_Grid.First;
    while not cds_Grid.Eof do
    begin
      if (SetForm.FindComponent(cds_Grid.FieldByName('GridName').AsString))is TDBGridEh then
      begin
        AGridEh:= SetForm.FindComponent(cds_Grid.FieldByName('GridName').AsString)as TDBGridEh  ;
        with AGridEh do
        begin
          cdsColsSet.Filtered:=False ;
          cdsColsSet.Filter:='FormName='+QuotedStr(SetForm.Name)+' and GridName='+QuotedStr(AGridEh.Name);
          cdsColsSet.Filtered:=True ;
          if cdsColsSet.IsEmpty then    //���cdsColsSet�ļ�¼�ǿգ�����һ�α��棬���
          begin
            cdsColsSet.Append;
            cdsColsSet.FieldByName('D419_ptr').Value :=Int_data0419_Rkey;
            cdsColsSet.FieldByName('D073_ptr').Value :=D073_ptr;
            cdsColsSet.FieldByName('FormName').Value :=SetForm.Name;
            cdsColsSet.FieldByName('GridName').Value :=AGridEh.Name;
            cdsColsSet.Post;
          end;

          for colsCount:=0 to AGridEh.Columns.Count -1 do
          begin
            cdsColsSetM.Filtered:=False ;
            cdsColsSetM.Filter:='FormName='+QuotedStr(cdsColsSet.FieldByName('FormName').AsString)
                          +' and GridName='+QuotedStr(cdsColsSet.FieldByName('GridName').AsString)
                          +' and FieldName='+QuotedStr(Columns[colsCount].FieldName) ;
            cdsColsSetM.Filtered:=True ;
            if  cdsColsSetM.IsEmpty=False then           //������е����ü�¼�Ѿ����ڣ��Һ��ֱ��������ò�һ�£��޸�
            begin                                         {�����Ȳ�ͬ��˳��ͬ��(���ɼ���ͬ���ͣ���)}
              if (Columns[colsCount].Width<>cdsColsSetM.FieldByName('DisplayWidth').Value)
               or(Columns[colsCount].index<>cdsColsSetM.FieldByName('DisplayOrder').Value)
               or( (Columns[colsCount].Visible<>cdsColsSetM.FieldByName('IsDisplay').Value)and
                   (Columns[colsCount].Visible<>(AllowedSee(Operat_bool,Columns[colsCount].FieldName,cdsColsSet.FieldByName('GridName').AsString))) ) then
              begin
                cdsColsSetM.Edit;
                cdsColsSetM.FieldByName('DisplayOrder').Value:=Columns[colsCount].index;
                cdsColsSetM.FieldByName('DisplayWidth').Value:=Columns[colsCount].Width;
                cdsColsSetM.FieldByName('IsDisplay').   Value:=Columns[colsCount].Visible;
                cdsColsSetM.Post;
              end;
            end
            else  //������е����ü�¼�����ڣ��Һ��ֱ��������ú�ԭʼ���һ�£����
            begin
              cds_ColsOriginal.Filtered:=False;
              cds_ColsOriginal.Filter:= cdsColsSetM.Filter;
              cds_ColsOriginal.Filtered:=True;
              if cds_ColsOriginal.IsEmpty=False then
              if (Columns[colsCount].Width<>cds_ColsOriginal.FieldByName('DisplayWidth').Value)
               or(Columns[colsCount].index<>cds_ColsOriginal.FieldByName('DisplayOrder').Value)
               or( (Columns[colsCount].Visible<>cds_ColsOriginal.FieldByName('IsDisplay').AsBoolean)and
                   (Columns[colsCount].Visible<>(AllowedSee(Operat_bool,Columns[colsCount].FieldName,cdsColsSet.FieldByName('GridName').AsString)))
                   )  then
              begin
                cdsColsSetM.Append;
                cdsColsSetM.FieldByName('ColsSet_ptr').Value  := cdsColsSet.FieldByName('rkey').Value;
                cdsColsSetM.FieldByName('FormName').Value     := cdsColsSet.FieldByName('FormName').Value;
                cdsColsSetM.FieldByName('GridName').Value     := cdsColsSet.FieldByName('GridName').Value;
                cdsColsSetM.FieldByName('FieldName').Value    := Columns[colsCount].FieldName;
                cdsColsSetM.FieldByName('DisplayOrder').Value := Columns[colsCount].index;
                cdsColsSetM.FieldByName('DisplayWidth').Value := Columns[colsCount].Width;
                cdsColsSetM.FieldByName('IsDisplay').   Value := Columns[colsCount].Visible;
                cdsColsSetM.Post;
              end;
            end;
          end;

          //����������ж���������û������������У�����Ի����е�"��"�����еı䶯������,�����˳�
          if cdsColsSetM.ChangeCount>0 then
          begin
            if SaveChange or
            (messagebox(SetForm.Handle,'��ǰ�����ݱ���Ѿ���������Ҫ������Щ������',
                       '��ʾ',MB_yesno+MB_iconquestion) =mrYes) then
              begin
                cdsColsSet.ApplyUpdates(0);
                cdsColsSetM.ApplyUpdates(0);
                SaveChange:=True;
              end
            else
              begin
                cdsColsSetM.Cancel;
                cdsColsSetM.CancelUpdates;
                cdsColsSet.Cancel;
                cdsColsSet.CancelUpdates;
                Exit;
              end;
          end;
        end;
      end;
      cds_Grid.Next;
    end;
  finally
    Screen.Cursor := crDefault;
  end;    
end;
//procedure SaveColsInfo(SetForm:TForm;D073_ptr:Integer);
//var
//  i,colsCount:Integer;
//  AGridEh:TDBGridEh;
//  HasChanged:Boolean;  //������Ѿ��ı�
//  vCDS:TClientDataSet;
//begin
//  with  ColsDisplaySet_frm do
//  try
//    Screen.Cursor := crHourGlass;
//    vCDS:=TClientDataSet.Create(Application);
//    vCDS.Data:=  cds_ColsOriginal.Data ;
//    vCDS.Filtered:=False ;
//    vCDS.Filter:= 'FormName ='+QuotedStr(SetForm.Name);
//    vCDS.Filtered:=True ;                          //����֮��ļ�¼�������������ı������
//    while not vCDS.Eof do
//    begin
//      if (SetForm.FindComponent(vCDS.FieldByName('GridName').AsString))is TDBGridEh then
//      begin
//        AGridEh:= SetForm.FindComponent(vCDS.FieldByName('GridName').AsString)as TDBGridEh  ;
//        with AGridEh do
//        begin
//          cdsColsSet.Filtered:=False ;
//          cdsColsSet.Filter:='FormName='+QuotedStr(SetForm.Name)+' and GridName='+QuotedStr(AGridEh.Name);
//          cdsColsSet.Filtered:=True ;
//          if cdsColsSet.IsEmpty then    //���cdsColsSet�ļ�¼�ǿգ�����һ�α��棬���
//          begin
//            cdsColsSet.Append;
//            cdsColsSet.FieldByName('D419_ptr').Value :=Int_data0419_Rkey;
//            cdsColsSet.FieldByName('D073_ptr').Value :=D073_ptr;
//            cdsColsSet.FieldByName('FormName').Value :=SetForm.Name;
//            cdsColsSet.FieldByName('GridName').Value :=F_DBGridEh;
//            cdsColsSet.ApplyUpdates(0);
//          end;
//
//
//            with AGridEh.FieldColumns[F_ColFieldName[colsCount]] do
//            begin
//              cdsColsSetM.Filtered:=False ;
//              cdsColsSetM.Filter:='FormName='+cdsColsSet.FieldByName('FormName').AsString
//                +' and GridName='+ cdsColsSet.FieldByName('GridName').AsString
//                +' and FieldName='+QuotedStr(F_ColFieldName[colsCount]);
//              cdsColsSetM.Filtered:=True ;
//              cds_ColsOriginal.Filtered:=False ;
//              cds_ColsOriginal.Filter:= cdsColsSetM.Filter;
//              cds_ColsOriginal.Filtered:=True ;
//
//              //������е����ü�¼�Ѿ����ڣ��Һ��ֱ��������ò�һ�£��޸�
//              if  cdsColsSetM.IsEmpty=False then
//              begin                                     {�����Ȳ�ͬ��˳��ͬ��(���ɼ���ͬ���ͣ���)}
//                if (Width<>cdsColsSetM.FieldByName('DisplayWidth').Value)
//                 or(index<>cdsColsSetM.FieldByName('DisplayOrder').Value)
//                 or( (Visible<>cdsColsSetM.FieldByName('IsDisplay').Value)and
//                     (Visible<>(AllowedSee(Operat_bool,F_ColFieldName[colsCount],F_DBGridEh))) ) then
//                begin
////                  ShowMessage(IntToStr(Width)+':'+cdsColsSetM.FieldByName('DisplayWidth').AsString+#13
////                              +IntToStr(index)+':'+cdsColsSetM.FieldByName('DisplayOrder').AsString+#13
////                              +BoolToStr(Visible)+':'+ cdsColsSetM.FieldByName('IsDisplay').AsString+#13
////                              +BoolToStr(Visible)+':'+BoolToStr(AllowedSee(Operat_bool,F_ColFieldName[colsCount],F_DBGridEh)));
//                  cdsColsSetM.Edit;
////                  ColsDisplaySet_frm.cdsColsSetM.FieldByName('ColsSet_ptr').Value:=ColsDisplaySet_frm.cdsColsSet.FieldByName('rkey').Value;
////                  ColsDisplaySet_frm.cdsColsSetM.FieldByName('FieldName').Value:=F_ColFieldName[colsCount];
//                  cdsColsSetM.FieldByName('DisplayOrder').Value:=index;
//                  cdsColsSetM.FieldByName('DisplayWidth').Value:=Width;
//                  cdsColsSetM.FieldByName('IsDisplay').Value:=Visible;
//                  cdsColsSetM.Post;
//                end;
//              end
//              else  //������е����ü�¼�����ڣ��Һ��ֱ��������ò�һ�£����
//              begin
//                if (Width<>  F_ColDisplayWidth[colsCount])or
//                   (index<>  F_ColDisplayOrder[colsCount])or
//                   ( (Visible<>F_ColIsDisplay[colsCount]) and
//                     (Visible<>(AllowedSee(Operat_bool,F_ColFieldName[colsCount],F_DBGridEh))) )then
//                begin
//                  if ColsDisplaySet_frm.cdsColsSetM.IsEmpty then
//                  begin
//                    cdsColsSetM.Append;
//                    cdsColsSetM.FieldByName('ColsSet_ptr').Value:=ColsDisplaySet_frm.cdsColsSet.FieldByName('rkey').Value;
//                    cdsColsSetM.FieldByName('FormName').Value:=ColsDisplaySet_frm.cdsColsSet.FieldByName('FormName').Value;
//                    cdsColsSetM.FieldByName('GridName').Value:=ColsDisplaySet_frm.cdsColsSet.FieldByName('GridName').Value;
//                    cdsColsSetM.FieldByName('FieldName').Value:=F_ColFieldName[colsCount];
//                    cdsColsSetM.FieldByName('DisplayOrder').Value:=index;
//                    cdsColsSetM.FieldByName('DisplayWidth').Value:=Width;
//                    cdsColsSetM.FieldByName('IsDisplay').Value:=Visible;
//                    cdsColsSetM.Post;
//                   // ShowMessage(cdsColsSetM.FieldByName('FieldName').AsString+':'+cdsColsSetM.FieldByName('GridName').AsString);
//                  end;
//                end;
//              end;  
//            end;
////          end;
//          if cdsColsSetM.ChangeCount>0 then
//          begin
//            if  messagebox(ColsDisplaySet_frm.Handle,'��ǰ�����ݱ���Ѿ���������Ҫ������Щ������','��ʾ',MB_yesno+MB_iconquestion) =mrYes then
//            cdsColsSetM.ApplyUpdates(0);
//          end;
//        end;
//      end;
//    end;
//  finally
//    Screen.Cursor := crDefault;
//  end;    
//end;

Function TColsDisplaySet_frm.AllowedSee(vprev_bool:Boolean;CheckField,GridName:string):Boolean;
var          //  ���vprev_bool���棬���CheckField�� NoPermissionSeeField_Info��Ϣ���ҵ�������Ϊfalst,��������,û�ҵ�Ϊ��
  i,j:Integer;
begin    
  Result:= True  ;
  if (vprev_bool)and ( TFieldsCanNotSeeInfo   <>nil) then
  begin
    for i:=0 to High(FieldsCanNotSee_Info) do
    begin
      if UpperCase(FieldsCanNotSee_Info[i].F_GridName.Name)=UpperCase(GridName) then
      begin
        for j:=0 to High(FieldsCanNotSee_Info[i].F_Fields)do
        begin
          if UpperCase(CheckField) =UpperCase(FieldsCanNotSee_Info[i].F_Fields[j]) then
          begin
            Result:= False;
            Exit;
          end;
        end;
        Exit;
      end;
    end;
  end;
end;

Function show_ColsDisplaySet_frm(SetForm:TForm;AGridEh:TDBGridEh;D073_ptr:Integer):Boolean;
var
  i:Integer;
  StrFilter:string;
begin
  Result:=False;
  with  ColsDisplaySet_frm do
  begin
    if Int_data0419_Rkey=0 then
    begin
      ShowMessage('�ó�����Data0419����û���ҵ���ؼ�¼������');
      Exit;
    end;
    OperatingGrid:= AGridEh;
    with AGridEh do
    begin
      if    cdsColsSet.Active=False then
      cdsColsSet.Open;
      cdsColsSet.Filtered:=False ;
      StrFilter:='FormName='+QuotedStr(SetForm.Name)+' and GridName='+QuotedStr(AGridEh.Name);
      cdsColsSet.Filter:=StrFilter;
      cdsColsSet.Filtered:=True ;
      if cdsColsSet.IsEmpty then
      begin
        cdsColsSet.Append;
        cdsColsSet.FieldByName('D419_ptr').Value :=Int_data0419_Rkey;
        cdsColsSet.FieldByName('D073_ptr').Value :=D073_ptr;
        cdsColsSet.FieldByName('FormName').Value :=SetForm.Name;
        cdsColsSet.FieldByName('GridName').Value :=AGridEh.Name;
        cdsColsSet.Post;
      end;

      //�����������ı����˳����п�ȵ�������������ʾʱ�����»�ȡ�����п����ݡ�
//      cdsColsSetM.Filtered:=False ;                         //�ô������ͱ���������ݽ��й���
//      StrFilter:='FormName='+QuotedStr(SetForm.Name)
//                      +' and GridName=' +QuotedStr(AGridEh.Name)
//                      +' and ColsSet_ptr = '+IntToStr(cdsColsSet.FieldByName('rkey').AsInteger);
//      cdsColsSetM.Filter:= StrFilter;
//      cdsColsSetM.Filtered:=True;

      cdsLabel.Close;     //��¼�ֶ������ֶ���ʾ�������ֶ�����Lookup���õ���
      cdsLabel.Open;
      for i:=0 to Columns.Count-1  do
      begin
        cdsLabel.Append;
        cdsLabel.FieldByName('FieldName').Value:=AGridEh.Columns[i].Field.FieldName;
        cdsLabel.FieldByName('DisplayLabel').Value:=AGridEh.Columns[i].Title.Caption;
        cdsLabel.Post;

        cdsColsSetM.Filtered:=False;               //Ȼ���cdsColsSetM���м�¼���������й���
        cdsColsSetM.Filter:=StrFilter+' and FieldName='+ QuotedStr(Columns[i].Field.FieldName);
        cdsColsSetM.Filtered:=True;
        if  cdsColsSetM.IsEmpty then               //�����cdsColsSetM���¼�в����ڣ����
        begin
          cdsColsSetM.Append;
          cdsColsSetM.FieldByName('FormName')      .Value:= SetForm.Name ;
          cdsColsSetM.FieldByName('GridName')      .Value:= AGridEh.Name   ;
          cdsColsSetM.FieldByName('ColsSet_ptr')   .Value:= cdsColsSet.FieldByName('rkey').AsInteger;
          cdsColsSetM.FieldByName('FieldName')     .Value:= AGridEh.Columns[i].Field.FieldName;
          cdsColsSetM.FieldByName('DisplayOrder')  .Value:=i;
          cdsColsSetM.FieldByName('DisplayWidth')  .Value:=AGridEh.Columns[i].Width;
          if AGridEh.Columns[i].Visible then
            cdsColsSetM.FieldByName('IsDisplay').Value:=True
          else
            cdsColsSetM.FieldByName('IsDisplay').Value:=False;
          cdsColsSetM.Post;
        end
        else                             //�����data0849���¼�д���
        begin
          cdsColsSetM.Edit;
          if ((cdsColsSetM.FieldByName('DisplayOrder').Value<>i)       // �����˳������иı�, �޸�
               or(cdsColsSetM.FieldByName('DisplayWidth').Value<>AGridEh.Columns[i].Width))and(cdsColsSetM.FieldByName('IsDisplay').AsBoolean)then   //�����˳������иı�,������ֶ�����ʾ���޸�
          begin                
            if (cdsColsSetM.FieldByName('DisplayOrder').Value<>i)and(cdsColsSetM.FieldByName('IsDisplay').AsBoolean) then
              cdsColsSetM.FieldByName('DisplayOrder').Value:=i ;
            if cdsColsSetM.FieldByName('DisplayWidth').Value<>AGridEh.Columns[i].Width then
            begin
              cdsColsSetM.FieldByName('DisplayWidth').Value:=AGridEh.Columns[i].Width ;
            end;
          end;
          cdsColsSetM.Post;
        end;
      end;
    end;
    cdsColsSetM.Filtered:=False;
    cdsColsSetM.Filter:= StrFilter;
    cdsColsSetM.Filtered:=True;
    if ShowModal=mrOk then
    begin
      Result:=True;
    end;
  end ;
end;

procedure ResetGridColumns(SetForm:TForm;var AConn:TADOConnection;D073_ptr:Integer;SeeRight:Boolean) ;
var
  i,ColsCount:Integer;
  StrFilter:string;
begin
  if not Assigned(ColsDisplaySet_frm)then
  begin            
    ColsDisplaySet_frm:=TColsDisplaySet_frm.Create(Application);
    ColsDisplaySet_frm.Font.Size    := SetForm.Font.Size;
    ColsDisplaySet_frm.Font.Charset := SetForm.Font.Charset;
    ColsDisplaySet_frm.Font.Name    := SetForm.Font.Name;
    with ColsDisplaySet_frm do
    begin
      Operat_bool:=SeeRight;
      dtRead     .Connection:=AConn;
      dtColsSetM .Connection:=AConn;
      dtColsSet  .Connection:=AConn;
      dtReadRkey .Connection:=AConn;
      Int_data0419_Rkey:=GetD419Rkey();
    end;
  end;

  with ColsDisplaySet_frm do
  begin
    if cdsColsSet.Active=False then
    begin
      cdsColsSet.Params.ParamByName('D419_ptr').Value:=Int_data0419_Rkey;
      cdsColsSet.Params.ParamByName('D073_ptr').Value:=D073_ptr;
      cdsColsSet.Open;
      //ShowMessage(IntToStr(D073_ptr)+':'+IntToStr(cdsColsSet.RecordCount));

      cdsColsSetM.Params.ParamByName('D419_ptr').Value:=Int_data0419_Rkey;
      cdsColsSetM.Params.ParamByName('D073_ptr').Value:=D073_ptr;
      cdsColsSetM.Open;

      cds_Grid.Open;
      cds_ColsOriginal.Open;
    end;

    for i:=0 to SetForm.ComponentCount-1 do
    begin
      if SetForm.Components[i] is TDBGridEh then
      with SetForm.Components[i] as TDBGridEh do
      begin
        cds_Grid.Append;
        cds_Grid.FieldByName('FormName').Value:=SetForm.Name;
        cds_Grid.FieldByName('GridName').Value:=Name;
        if FrozenCols>0 then
          cds_Grid.FieldByName('FrozenField').Value:= Columns[FrozenCols-1].FieldName;
        cds_Grid.Post;

        for ColsCount:=0 to Columns.Count-1 do        //��¼DBGridEh����ԭʼ�����ԡ�
        begin
          if Columns[ColsCount].Visible then
          Columns[ColsCount].Visible:=
             AllowedSee(SeeRight,Columns[ColsCount].FieldName,(SetForm.Components[i] as TDBGridEh).Name) ;
          cds_ColsOriginal.Append;
          cds_ColsOriginal.FieldByName('FormName').Value:=SetForm.Name;
          cds_ColsOriginal.FieldByName('GridName').Value:=Name;
          if   Columns[ColsCount].Field<>nil then
          cds_ColsOriginal.FieldByName('FieldName').Value:=Columns[ColsCount].Field.FieldName;
          cds_ColsOriginal.FieldByName('DisplayOrder').Value:=ColsCount;
          cds_ColsOriginal.FieldByName('DisplayWidth').Value:=Columns[ColsCount].Width;
          cds_ColsOriginal.FieldByName('IsDisplay').Value:=Columns[ColsCount].Visible;
          cds_ColsOriginal.Post;
        end;


        cdsColsSet.Filtered:=False ;                         //�ô������ͱ���������ݽ��й���
        StrFilter:='FormName='+QuotedStr(SetForm.Name)
                  +' and GridName=' +QuotedStr((SetForm.Components[i] as TDBGridEh).Name);
        cdsColsSet.Filter:= StrFilter;
        cdsColsSet.Filtered:=True;

        cdsColsSetM.Filtered:=False ;
        cdsColsSetM.Filter:= StrFilter;
        cdsColsSetM.Filtered:=True;
//
        cdsColsSetM.Last;
        while not cdsColsSetM.Bof do     // ����cdsColsSetM�ļ�¼������б���в�����У�ɾ����
        begin
          for ColsCount:=0 to Columns.Count-1  do
          begin
            if UpperCase(Trim(Columns[ColsCount].FieldName))=UpperCase(Trim(cdsColsSetM.FieldByName('FieldName').AsString))then
              begin
                Break  ;
              end
            else                                         //���û���ҵ�
              begin
                if ColsCount=Columns.Count-1 then   //�Ѿ������һ��
                begin
                  cdsColsSetM.Delete   ;
                end;
              end;
          end;
          cdsColsSetM.Prior;
        end;

        with cdsColsSetM do        //��cdsColsSetM��¼����ֵ�������Խ�������
        begin
          First;
          while not Eof do
          begin
            FieldColumns[FieldByName('FieldName').AsString].Width   :=  FieldByName('DisplayWidth').Value;
            FieldColumns[FieldByName('FieldName').AsString].Index   :=  FieldByName('DisplayOrder').Value;
            FieldColumns[FieldByName('FieldName').AsString].Visible :=  FieldByName('IsDisplay').AsBoolean
              and AllowedSee(SeeRight,FieldByName('FieldName').AsString,(SetForm.Components[i] as TDBGridEh).Name) ;
            Next;
            //ShowMessage('');
          end;
          Filtered:=False;
        end;

        if (cdsColsSet.IsEmpty=False)then
        if (cdsColsSet.FieldByName('FrozenField').IsNull=False)and(cdsColsSet.FieldByName('FrozenField').AsString<>'')  then         //���ö�����
        begin
          if  FieldColumns[cdsColsSet.FieldByName('FrozenField').AsString].Visible then
          FrozenCols:= CountVisibleCol((SetForm.Components[i] as TDBGridEh),
                        cdsColsSet.FieldByName('FrozenField').AsString);
         // FrozenCols:= FieldColumns[cdsColsSet.FieldByName('FrozenField').AsString].Index+1;  ?
        end
        else
          FrozenCols:=0;
      end;
    end;
  end;
end;

function TColsDisplaySet_frm.GetD419Rkey: Integer;
begin
  with dtRead do
  begin
    Close;
    CommandText:='select * from data0419 where programe='+QuotedStr(Extractfilename(application.exename));
    Open;
    Result:=FieldByName('rkey').AsInteger;
    Close;
  end;
end;

procedure TColsDisplaySet_frm.SetStatus ;
begin
  with dsColsSetM.DataSet as TClientDataSet do
  if  (State in[dsEdit,dsInsert])or(ChangeCount>0) then
    begin
      btPost  .Enabled:=True;
      btCancel.Enabled:=True;
      btNext.Enabled:=False;
      btPrior.Enabled:=False;
      btClose.Enabled:=False;
      bt_Reset.Enabled:=False;
    end
  else
    begin
      btPost  .Enabled:=False;
      btCancel.Enabled:=False;
      btNext.Enabled:=True;
      btPrior.Enabled:=True;
      btClose.Enabled:=True;
      bt_Reset.Enabled:=True;
    end;
end;

procedure TColsDisplaySet_frm.cdsColsSetMDisplayOrderChange(
  Sender: TField);
var
  i:Integer;
begin
  if Self.Showing then
  with dsColsSetM.DataSet do
  begin
    if UpperCase(Sender.FieldName )=UpperCase('DisplayOrder') then
    begin
      for i:=0 to OperatingGrid.Columns.Count-1 do
      begin
        if UpperCase(FieldByName('FieldName').AsString)
              = UpperCase(OperatingGrid.Columns[i].Field.FieldName)  then
        begin
          OperatingGrid.Columns[i].Index:=Sender.AsInteger;
          Break;
        end;
      end;
    end
    else
    if UpperCase(Sender.FieldName )=UpperCase('DisplayWidth') then
    begin
      for i:=0 to OperatingGrid.Columns.Count-1 do
      begin
        if UpperCase(FieldByName('FieldName').AsString)
              = UpperCase(OperatingGrid.Columns[i].Field.FieldName)  then
        begin
          OperatingGrid.Columns[i].Width:=Sender.AsInteger;
          Break;
        end;
      end;
    end
    else
    if UpperCase(Sender.FieldName )=UpperCase('IsDisplay') then
    begin
      for i:=0 to OperatingGrid.Columns.Count-1 do
      begin
        if UpperCase(FieldByName('FieldName').AsString)
              = UpperCase(OperatingGrid.Columns[i].Field.FieldName)  then
        begin
          OperatingGrid.Columns[i].Visible:=Sender.AsBoolean;
          Break;
        end;
      end;
    end  ;
  end;

end;

procedure TColsDisplaySet_frm.cdsColsSetMAfterScroll(DataSet: TDataSet);
begin
  if Self.Showing then
  with  cdsColsSetM  do
  DBGridEh1.readonly:=AllowedSee(Operat_bool,FieldByName('FieldName').AsString  , OperatingGrid .Name)=False;
end;

procedure TColsDisplaySet_frm.DBGridEh1GetCellParams(Sender: TObject;
  Column: TColumnEh; AFont: TFont; var Background: TColor;
  State: TGridDrawState);
begin
  with  dsColsSetM.DataSet  do
  begin
    if AllowedSee(Operat_bool,FieldByName('FieldName').AsString  , OperatingGrid .Name)=False then
    AFont.Color:= clMedGray;   //  clRed
  end;
end;

procedure TColsDisplaySet_frm.btPostClick(Sender: TObject);
begin
  try
    Screen.Cursor := crHourGlass;
    with cdsColsSet do
    begin
      if State in[dsEdit ,dsInsert] then
      Post;
      ApplyUpdates(0);
    end;

    with cdsColsSetM do
    begin
      if State in[dsEdit ,dsInsert] then
      Post;
      ApplyUpdates(0);
    end;
    SetStatus;
  finally    
    Screen.Cursor := crDefault;
  end;
end;

procedure TColsDisplaySet_frm.bt_ResetClick(Sender: TObject);
begin
  try
    Screen.Cursor := crHourGlass;
    with dsColsSetM.DataSet as TClientDataSet do
    if Active  then
    begin
      with cds_ColsOriginal do             //�ñ��ԭʼ�������ݻָ���
      begin
        Filtered:=False;
        Filter:='FormName='+QuotedStr(cdsColsSet.FieldByName('FormName').AsString)
                            +' and GridName='+QuotedStr(cdsColsSet.FieldByName('GridName').AsString) ;
        Filtered:=True;
        while not eof do
        begin
          with OperatingGrid  do
          begin
            FieldColumns[FieldByName('FieldName').AsString].Width   :=  FieldByName('DisplayWidth').Value;
            FieldColumns[FieldByName('FieldName').AsString].Index   :=  FieldByName('DisplayOrder').Value;
            FieldColumns[FieldByName('FieldName').AsString].Visible :=  FieldByName('IsDisplay').AsBoolean
              and AllowedSee(Operat_bool,FieldByName('FieldName').AsString,cdsColsSet.FieldByName('GridName').AsString) ;
          end;
          Next;
        end;
      end;
      with cds_Grid do
      begin
        Filtered:=False;
        Filter:=cds_ColsOriginal.Filter ;
        Filtered:=True;
        if (cds_Grid.FieldByName('FrozenField').IsNull=False)and(cds_Grid.FieldByName('FrozenField').AsString<>'')then
          OperatingGrid.FrozenCols:= OperatingGrid.FieldColumns[cds_Grid.FieldByName('FrozenField').AsString].Index+1
        else
          OperatingGrid.FrozenCols:=0;
      end;

      if State in [dsEdit,dsInsert] then Cancel;
      if UpdateStatus in[usInserted,usModified]then CancelUpdates;
      while not Eof do
      if IsEmpty =False then
      Delete;
     // ShowMessage(cdsColsSet.Filter);
      if cdsColsSet.IsEmpty =False then
      cdsColsSet.Delete;
      ApplyUpdates(0);
      cdsColsSet. ApplyUpdates(0);

      SetStatus;
    end ;
  finally    
    Screen.Cursor := crDefault;
  end;
end;

procedure TColsDisplaySet_frm.btNextClick(Sender: TObject);
begin
  with DBGridEh1.DataSource.DataSet do
  if Active then
  begin
    Next;
  end  ;
end;

procedure TColsDisplaySet_frm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
var
  s:Integer;
begin
  with DBGridEh1.DataSource.DataSet as TClientDataSet do
  if Active and (state in [dsInsert,dsEdit])or (changeCount>0)then
  begin
    S:= messagedlg('��������Ѿ�����,��Ҫ������?',mtconfirmation,[mbyes,mbno,mbcancel],0);
    if S = mryes  then
      begin
        if (state in [dsInsert,dsEdit]) then
        Post ;
        ApplyUpdates(0)  ;
        CanClose:=True;
      end
    else
    if S = mrNo then
      begin
        cdsColsSetM.Cancel;
        cdsColsSetM.CancelUpdates;
        CanClose:=True;
      end
    else
    if S = mrcancel then
      begin
        //abort;
        CanClose:=False;
      end;
  end ;
end;

procedure TColsDisplaySet_frm.DBGridEh1KeyDown(Sender: TObject;
  var Key: Word; Shift: TShiftState);
begin
  if Key in[VK_INSERT,VK_delete] then   //  , VK_down
  begin
    Key:=0;
  end
  else
  with   (Sender as TDBGridEh ).DataSource.DataSet  do
  if (Key in[VK_down])and(RecNo=RecordCount ) then    //��������¼����ҵ�ǰ��¼�ŵ����ܼ�¼��
  begin
    Key:=0;
  end;
end;

procedure TColsDisplaySet_frm.btCloseClick(Sender: TObject);
begin
  Close;
end;

procedure TColsDisplaySet_frm.dsColsSetMStateChange(Sender: TObject);
begin
  SetStatus;
end;

procedure TColsDisplaySet_frm.btCancelClick(Sender: TObject);
begin
  with dsColsSetM.DataSet as TClientDataSet do
  if Active then
  begin
    Cancel;
    CancelUpdates;
    SetStatus;
  end;
end;

procedure TColsDisplaySet_frm.btPriorClick(Sender: TObject);
begin
  with DBGridEh1.DataSource.DataSet do
  if Active then
  begin
    Prior;
  end
end;

procedure TColsDisplaySet_frm.dspColsSetAfterUpdateRecord(Sender: TObject;
  SourceDS: TDataSet; DeltaDS: TCustomClientDataSet;
  UpdateKind: TUpdateKind);
begin
  if UpdateKind= ukInsert then      //��δ���������ǿͻ��˻�ȡ�Զ���ŵ�ֵ��
  begin
    with dtRead  do
    begin
      Close;
      CommandText:='select @@identity';
      Open;
      DeltaDS.FieldByName('rkey').ReadOnly:=False;
      DeltaDS.FieldByName('rkey').NewValue:=dtRead.Fields[0].Value;
      Close;
    end;
  end;
end;

procedure TColsDisplaySet_frm.dspColsSetMAfterUpdateRecord(Sender: TObject;
  SourceDS: TDataSet; DeltaDS: TCustomClientDataSet;
  UpdateKind: TUpdateKind);
begin
  if UpdateKind= ukInsert then      //��δ���������ǿͻ��˻�ȡ�Զ���ŵ�ֵ��
  begin
    with dtRead  do
    begin
      Close;
      CommandText:='select @@identity';
      Open;
      DeltaDS.FieldByName('rkey').ReadOnly:=False;
      DeltaDS.FieldByName('rkey').NewValue:=dtRead.Fields[0].Value;
      Close;
    end;
  end;
end;

procedure TColsDisplaySet_frm.cdsColsSetMAfterOpen(DataSet: TDataSet);
begin
  cdsColsSetM.AddIndex('px', 'DisplayOrder', [ixPrimary]);
  DBGridEh1.FieldColumns['DisplayOrder'].Title.SortMarker:= smUpEh;
  cdsColsSetM.IndexName:= 'px';
end;

procedure TColsDisplaySet_frm.cdsColsSetMBeforeClose(DataSet: TDataSet);
begin
  with   (DataSet as TClientDataSet) do
  if  IndexName<>'' then
  DeleteIndex(IndexName) ;               //����Ѵ��ڵ�����
end;

procedure TColsDisplaySet_frm.dspColsSetMBeforeUpdateRecord(
  Sender: TObject; SourceDS: TDataSet; DeltaDS: TCustomClientDataSet;
  UpdateKind: TUpdateKind; var Applied: Boolean);
begin
  if(UpdateKind = ukInsert)and(DeltaDS.FieldByName('ColsSet_ptr').AsInteger<=0)then
  begin
    if DeltaDS.BOF then               //ֻ���ǵ�һ�е�ʱ�򣬲���Ҫִ�в�ѯ��ȡ@@identity
    begin
      with    dtReadRkey do
      begin
        Close;
        CommandText:='select @@identity';  // @@identity
        Open;
      end;
    end;
  //  DeltaDS.FieldByName('rkey').ReadOnly:=False;
    DeltaDS.FieldByName('ColsSet_ptr').NewValue := dtReadRkey.Fields[0].AsInteger;
  end;
end;

procedure TColsDisplaySet_frm.FormDestroy(Sender: TObject);
var
  i:Integer;
begin
  for i:=High( FieldsCanNotSee_Info) downto 0  do
  FieldsCanNotSee_Info[i].Free;
end;

end.
