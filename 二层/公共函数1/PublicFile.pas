unit PublicFile;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,StrUtils,
  Dialogs, ImgList, StdCtrls, Buttons, comobj,ToolWin, DBCtrls, ComCtrls, DB, Grids,ADODB,
    DBGrids, ExtCtrls ,DBGridEh,DBCtrlsEh ,DBClient,DBGridEhImpExp,cds,DBButtonEdit,dxStatusBar;


type
  TDropDownInfo=class
  private
  protected
  public
    L_GridName               :TDBGridEh;     //��������б��������ĸ��������
    L_DropdownColumn         :string;        //��������б�ı������ //Ҳ�����ڷ����ı��¼����ֶ�
    L_ListDataSet            :TDataSet;      //¼������������б����ݼ�������Ϊ�գ�
    L_FindDataSet            :TDataSet;      //���Ҵ����õ��������б����ݼ��������Ժ������б����ݼ���ͬ,��Ϊ��,���Ϊ�գ�����L_ListDataSetName���ã����L_ListDataSetΪ�գ��õ�������ֻ�����ڲ��ҶԻ�����
    L_ListDataSetFilterField :string;        //���б����ݼ������ֶ�����//
    L_GetValueField          :string;        //��ȡֵ���ֶ���
    L_ListResultField        :string;        //�����б����ݼ����ص��ֶ��� //���ı��¼�����ʱ���͸�ֵ���ж�λ
    L_FormWidth              :Integer;       //��������Ŀ��
    L_FormHeight             :Integer;       //��������ĸ߶�
    L_FormType               :Integer;       //������������� 1:��ѡ���ڣ�2����ѡ����
    L_AddPickList            :array of string;//���ַ���������ӵ�����PickList��
    L_PickListResultValues   :array of string;//����PickList�з��ص�ֵ
    L_SourceDataSet          :TClientDataSet; //�������÷����ı��¼������ݼ�
    L_SourceField            :array of string;// DEPT_CODE,DEPT_NAME  �ı䷢���󣬻�ȡֵ���ֶ�
    L_ResultField            :array of string;        //DEPT_CODE,DEPT_NAME   �ı䷢���󣬴���Щ�ֶλ�ȡֵ
    L_FieldNotNull           :Boolean;                //�������Ϊ�棬��L_DropdownColumn�ֶε�ֵΪ��ʱ����ʾ
    L_ColsInfo               :string;
  end;

  procedure DghReadOnlyFocus(Sender :TDBGridEh);
  procedure ColNotReadOnlyFocus(F:TForm;Ds:TDataSet);
  procedure KeyPressDBGridEH(Sender: TDBGridEh; var Key: Char;F:TForm) ;
//  Function  GetDataBaseDateTime(var cds:TClientDataSet):TDateTime;
  Function  GetDataBaseDate(var cds:TClientDataSet;TType:Byte=0):TDateTime;
//  Function  GetDataBaseSmallDate(cds:TClientDataSet):TDateTime;
  procedure CLS(AForm:TForm);
  Function  RecordExists(SQL:string; cds:TClientDataSet):boolean;
  procedure MsgInfo(msg:string);
  procedure MsgError(msg:string);
  procedure MsgWarning(msg:string);
  function Msg_Ask(info:string; AMsgDlgBtn :TMsgDlgButtons;FormCaption:string='ѯ��'):Integer;
  Function  SQLResultValue(cds:TClientDataSet;SQL:string):string;
  procedure NewNumb(Qry0004:TClientDataSet);
  procedure OutputExcelStd(AForm:TForm;ADBGridEh:TDBGridEh);
  function App_init_2(AdoConn: TADoConnection): boolean;
  Function AddSQL(S:String):String;
  procedure ColumnAddList(DghName:TDBGridEH;DghColName:string;SQL: string);
  procedure AddDefaultValues(cdsDataSet:TClientDataSet;ATableName:string;frm:TForm);
  procedure FieldsNotNull(ADataSet: TDataSet;FieldName:array of string);
  procedure ControlsSetReadOnly(Win_Controls:array of TControl ;IsReadOnly:Boolean=True;ReadOnlyColor:TColor=clSilver);// cl3DLight
  procedure SetColsReadOnly(AGrid:TDBGridEh;Cols:array of string ;IsReadOnly:Boolean=True;ReadOnlyColor:TColor=cl3DDkShadow);
//  procedure SetEmployeeInfo;
  procedure SetEmployeeInfo(ADataSet:TDataSet); overload;
  procedure SetEmployeeInfo(ADataSet:TDataSet;AStatusBar:TdxStatusBar); overload;
  Function IsNumeric(Str:string):Boolean;
  Function IsDateTime(Str:string):Boolean;    //����Ч������ʱ��
  function IsInt(Vaule:String):Boolean; //�ж�Vaule�ǲ���������ֵ
  Function IsEffectiveTime(Str:string):Boolean;
  function checkchar(const pstr:string;const pkey:char):boolean;
  function MinutesDiff(Adatetime1,Adatetime2:TDateTime):Real;
  function GetPCName: string; //��õ�������
  procedure cdsReadData(ACds:TClientDataSet;str_SQL:string='');
  var
    FontName:pchar='����';
    FontCharset:Integer=GB2312_CHARSET;
    FontSize:integer=9;
    hMapFile: THandle;   
    MapFilePointer: Pointer;
    IsDevelop:Boolean;
    UserRKEY:Integer;
    USER_FULL_NAME:string[40];
    USER_LOGIN_NAME:string[40];
    UserName:string[40];
    EmplRKEY:Integer;
    EMPL_CODE:string[40];
    EmplName:string[40];
    ProgRkey:Integer;
    fRight:string[20];
    vprev:string[2];
    Curr_Date:TDate;

implementation

uses  DM_f;

procedure SetColsReadOnly(AGrid:TDBGridEh;Cols:array of string ;
         IsReadOnly:Boolean=True;ReadOnlyColor:TColor=cl3DDkShadow); // clSilver
var
  i:integer;
begin
  for I := 0 to High(Cols) do
  begin
    if AGrid.FieldColumns[Cols[i]]<>nil then
    begin
      AGrid.FieldColumns[Cols[i]] .ReadOnly:= IsReadOnly;
      if IsReadOnly=False then
        AGrid.FieldColumns[Cols[i]].Title.Color:= clBtnFace
      else
        AGrid.FieldColumns[Cols[i]].Title.Color:=clScrollBar ;    // ReadOnlyColor
    end
  end;
end;

procedure SetEmployeeInfo(ADataSet:TDataSet);
var
  str_SQL:string;
begin
  str_SQL:= 'select d3.USER_FULL_NAME,d3.USER_LOGIN_NAME,d3.EMPLOYEE_PTR,d5.EMPLOYEE_NAME,d5.EMPL_CODE '
        +' from data0073 d3 left join data0005 d5 on d3.EMPLOYEE_PTR=d5.rkey where d3.rkey='+IntToStr(UserRKEY);
  if ADataSet is TADODataSet then
  with ADataSet as TADODataSet do
  begin
    Close;
    CommandText:=str_SQL;
    Open;
  end
  else
  if ADataSet is TADOQuery then
  with ADataSet as TADOQuery do
  begin
    Close;
    SQL.Text:=str_SQL;
    Open;
  end;
  with  ADataSet do
  if IsEmpty=False then
  begin
    UserName       := FieldByName('USER_FULL_NAME').Value ;
    USER_FULL_NAME := FieldByName('USER_FULL_NAME').Value ;
    USER_LOGIN_NAME:= FieldByName('USER_LOGIN_NAME').Value ;
    EmplRKEY       := FieldByName('EMPLOYEE_PTR').AsInteger ;
    EMPL_CODE      := FieldByName('EMPL_CODE').Value ;
    EmplName       := FieldByName('EMPLOYEE_NAME').Value ;
  end;
  ADataSet.Close;
end;

procedure SetEmployeeInfo(ADataSet:TDataSet;AStatusBar:TdxStatusBar);
var
  str_SQL:string;
begin
  str_SQL:= 'select d3.USER_FULL_NAME,d3.USER_LOGIN_NAME,d3.EMPLOYEE_PTR,d5.EMPLOYEE_NAME,d5.EMPL_CODE '
        +' from data0073 d3 left join data0005 d5 on d3.EMPLOYEE_PTR=d5.rkey where d3.rkey='+IntToStr(UserRKEY);
  if ADataSet is TADODataSet then
  with ADataSet as TADODataSet do
  begin
    Close;
    CommandText:=str_SQL;
    Open;
  end
  else
  if ADataSet is TADOQuery then
  with ADataSet as TADOQuery do
  begin
    Close;
    SQL.Text:=str_SQL;
    Open;
  end;
  with  ADataSet do
  if IsEmpty=False then
  begin
    UserName       := FieldByName('USER_FULL_NAME').Value ;
    USER_FULL_NAME := FieldByName('USER_FULL_NAME').Value ;
    USER_LOGIN_NAME:= FieldByName('USER_LOGIN_NAME').Value ;
    EmplRKEY       := FieldByName('EMPLOYEE_PTR').AsInteger ;
    EMPL_CODE      := FieldByName('EMPL_CODE').Value ;
    EmplName       := FieldByName('EMPLOYEE_NAME').Value ;
    AStatusBar.Panels[1].Text:='�û�����'+trim(USER_FULL_NAME)+' ('+trim(USER_LOGIN_NAME)+')';
  end;
  ADataSet.Close;
end;

procedure cdsReadData(ACds:TClientDataSet;str_SQL:string='');
begin
  DM.cdsRead.Close;
  if str_SQL='' then
  begin
    DM.cdsRead.CommandText:=ACds.CommandText;
    DM.cdsRead.Open;
    ACds.Data:=  DM.cdsRead.Data;
  end
  else
  begin
    DM.cdsRead.CommandText:=str_SQL;
    DM.cdsRead.Open;
    ACds.Data:=  DM.cdsRead.Data;
  end;
  DM.cdsRead.Close;
end;

function GetPCName: string; //��õ�������
var
  CNameBuffer: Pchar;
  fl_loaded: Boolean;
  CLen: ^DWord;
begin
  try
    GetMem(CNameBuffer, 255);
    New(CLen);
    CLen^ := 255;
    fl_loaded := GetComputerName(CNameBuffer, CLen^);
    if fl_loaded then
      result := CNameBuffer
    else
      result := 'Unkown';
  finally
    FreeMem(CNameBuffer, 255);
    Dispose(CLen);
  end;
//  result:='That is very funny';
end;

function MinutesDiff(Adatetime1,Adatetime2:TDateTime):Real;
var
TimeStamp : TTimeStamp;
time1, time2 : TDateTime;
timeDiff : Real;//Double;//integer;
begin
  //StrToFloat()
//  time1 := StrToDateTime(edit1.text); // ת����ʱ���ʽ
//  time2 := StrToDateTime(edit2.text);
  TimeStamp := DateTimeToTimeStamp(Adatetime2 - Adatetime1); // ������ֵ
  Dec(TimeStamp.Date, TTimeStamp(DateTimeToTimeStamp(0)).Date);// ����
  timeDiff := (TimeStamp.Date*24*60)+(TimeStamp.Time div 1000);
  timeDiff := round(timeDiff/60)/60;   // ת���ɷ���
  Result:= timeDiff;
  //showmessage('Diff in min = '+Floattostr(timeDiff)); // ��ʾ
//  showmessage(DateTimeToStr(TimeStampToDateTime(TimeStamp))); // ��ʾ
end;

function IsInt(Vaule:String):Boolean; //�ж�Vaule�ǲ�������
var
  i:integer;
begin
  result:=true; //���÷���ֵΪ �ǣ��棩
  Vaule:=trim(Vaule); //ȥ�ո�
  for i:=1 to length(Vaule) do //׼��ѭ��
  begin
    if not (Vaule[i] in ['0'..'9'] )then //���Vaule�ĵ�i���ֲ���0-9�е���һ��
    begin
      result:=false; //����ֵ ���ǣ��٣�
      exit; //�˳�����
    end;
  end;
end;

function checkchar(const pstr:string;const pkey:char):boolean;
begin
  result:=true;
  if not (pkey in ['0'..'9','.',#8]) then  //�ж��Ƿ���������
  begin
    result:=false
  end
  else
  if pkey = chr(46) then      //�ж��Ƿ��ظ�����С����'.'
  if pos('.',pstr)>0  then
    begin
      result:=false;
    end
  else
    result:=true;
end;

Function IsEffectiveTime(Str:string):Boolean;    //����Ч��ʱ��
begin
  try
    result:=True;
    StrToTime(Str);
  except
    result:=false;
  end;
end;

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
//
//procedure SetEmployeeInfo;
//begin
//  DM.cdsRead.CommandText:='select d3.USER_FULL_NAME,d3.USER_LOGIN_NAME,d3.EMPLOYEE_PTR,d5.EMPLOYEE_NAME,d5.EMPL_CODE '
//        +' from data0073 d3 left join data0005 d5 on d3.EMPLOYEE_PTR=d5.rkey where d3.rkey='+IntToStr(UserRKEY);
//  DM.cdsRead.Open;
//  if DM.cdsRead.IsEmpty=False then
//  begin
//    UserName := DM.cdsRead.FieldByName('USER_FULL_NAME').Value ;
//    USER_FULL_NAME := DM.cdsRead.FieldByName('USER_FULL_NAME').Value ;
//    USER_LOGIN_NAME:= DM.cdsRead.FieldByName('USER_LOGIN_NAME').Value ;
//    EmplRKEY := DM.cdsRead.FieldByName('EMPLOYEE_PTR').AsInteger ;
//    EMPL_CODE:= DM.cdsRead.FieldByName('EMPL_CODE').Value ;
//    EmplName := DM.cdsRead.FieldByName('EMPLOYEE_NAME').Value ;
//  end;
//end;

procedure ControlsSetReadOnly(Win_Controls:array of TControl ;IsReadOnly:Boolean=True;ReadOnlyColor:TColor=clSilver);//  cl3DLight
var
  i:integer;
begin   //�贰���ϵ�����Edit��Combobox��ؼ����á�
  for i:=0 to High(Win_Controls)  do
  begin
    if (Win_Controls[i] is TDBDateTimeEditEh) then
      begin
        TDBDateTimeEditEh(Win_Controls[i]).ReadOnly:=IsReadOnly ;
        if  IsReadOnly then
          TDBDateTimeEditEh(Win_Controls[i]).Color:=ReadOnlyColor
        else
          TDBDateTimeEditEh(Win_Controls[i]).Color:=clWindow;
      end
    else
    if (Win_Controls[i] is TDBButtonEdit) then
      begin
        TDBButtonEdit(Win_Controls[i]).ReadOnly:=IsReadOnly ;
        if  IsReadOnly then
          TDBButtonEdit(Win_Controls[i]).Color:=ReadOnlyColor
        else
          TDBButtonEdit(Win_Controls[i]).Color:=clWindow;
      end
    else
    if (Win_Controls[i] is TEdit) then
      begin
        TEdit(Win_Controls[i]).ReadOnly:=IsReadOnly ;
        if  IsReadOnly then
          TEdit(Win_Controls[i]).Color:=ReadOnlyColor
        else
          TEdit(Win_Controls[i]).Color:=clWindow;
      end
    else
    if (Win_Controls[i] is TDBEdit) then
      begin
        TDBEdit(Win_Controls[i]).ReadOnly:=IsReadOnly ;
        if  IsReadOnly then
          TDBEdit(Win_Controls[i]).Color:=ReadOnlyColor
        else
          TDBEdit(Win_Controls[i]).Color:=clWindow;
      end
    else
    if (Win_Controls[i] is TDBComboBox) then
      begin
        TDBComboBox(Win_Controls[i]).ReadOnly:=IsReadOnly ;
        if  IsReadOnly then
          TDBComboBox(Win_Controls[i]).Color:=ReadOnlyColor
        else
          TDBComboBox(Win_Controls[i]).Color:=clWindow;
      end
    else
    if (Win_Controls[i] is TDBRadioGroup) then
      begin
        TDBRadioGroup(Win_Controls[i]).ReadOnly:=IsReadOnly;
        if  IsReadOnly then
          TDBRadioGroup(Win_Controls[i]).Color:=ReadOnlyColor
        else
          TDBRadioGroup(Win_Controls[i]).Color:=clWindow;
      end
    else
//    if (self.Components[i] is TDBButtonEdit) then
//      begin
//        TDBButtonEdit(self.Components[i]).ReadOnly:=True;
//        TDBButtonEdit(self.Components[i]).Color:=clInactiveCaptionText ;
//      end
//    else
    if (Win_Controls[i] is TDBMemo) then
      begin
        TDBMemo(Win_Controls[i]).ReadOnly:=IsReadOnly ;
        if  IsReadOnly then
          TDBMemo(Win_Controls[i]).Color:=ReadOnlyColor
        else
          TDBMemo(Win_Controls[i]).Color:=clWindow;
      end
    else
    if (Win_Controls[i] is TDBCheckBox) then
      begin
        TDBCheckBox(Win_Controls[i]).ReadOnly:=IsReadOnly;
       // TDBCheckBox(self.Components[i]).Color:=clInactiveCaptionText ;
      end
    else
    if (Win_Controls[i] is TSpeedButton) then
      begin
        TSpeedButton(Win_Controls[i]).Enabled:= not IsReadOnly;
       // TDBCheckBox(self.Components[i]).Color:=clInactiveCaptionText ;
      end                 ;
  end;
end;

procedure FieldsNotNull(ADataSet: TDataSet;FieldName:array of string);
var
  i:Integer;
begin
  for i:=0 to High( FieldName) do
  begin
    if (ADataSet.FieldByName(FieldName[i]).IsNull)
        or(ADataSet.FieldByName(FieldName[i]).AsString='') then
     begin
       MsgError(ADataSet.FieldByName(FieldName[i]).DisplayLabel+': ���ֶβ���Ϊ�գ�');
     //  Exit;
       Abort;
     end;
  end;
end;

procedure AddDefaultValues(cdsDataSet:TClientDataSet;ATableName:string;frm:TForm);
var
//  i :Integer;
  DtDefaultValues:TClientDataSet;
 // DtDefaultValues:TADODataSet;
begin   {�ù���������ͬһ���ݴ��ڲ�ͬ�����ݼ��ϵ��ö�Σ��������ӱ�ṹ�����ݴ��ڣ���
        ͬһ�ű����ı�ᴴ����Ϊ TableName+'DtForeignKeyFieldQty'�����ݼ����������ʹ�ã����÷����򿪱��Ӷ����Ч�ʡ� }
  if frm.FindComponent(ATableName+'DefaultValues')=nil then   //������ݼ������ھʹ�����
  begin
    DtDefaultValues:=TClientDataSet.Create(frm);
    DtDefaultValues.ReadOnly:=True;
    DtDefaultValues.Name:= ATableName+'DefaultValues' ;
    DtDefaultValues.ProviderName:=DM.cdsRead.ProviderName;
    DtDefaultValues.CommandText:= 'select t.name as DataType,object_name(a.constid)as constName, '
                +' c.name as colName,SUBSTRING ( b.[text] , 3 , len(b.[text])-4 ) as DefaultValue '
                +' from sysconstraints a join syscomments b on a.constid=b.id '
                +' join syscolumns  c on a.id=c.id and a.colid=c.colid '
                +' join systypes t on c.xtype=t.xtype  '
                +' where a.id=object_id('+QuotedStr(ATableName)+') and object_name(a.constid) like ''%df%''';
    DtDefaultValues.Open;
  end ;

  with frm.FindComponent(ATableName+'DefaultValues')as TClientDataSet do
  begin
    if  IsEmpty then
      Exit;//�����¼Ϊ�㣬�˳�
    if not( cdsDataSet.State in [dsEdit,dsInsert]) then
      cdsDataSet.Edit ;
    First;
    while not Eof do
    begin
      cdsDataSet.FieldByName(FieldByName('colName').AsString).Value:=FieldByName('DefaultValue').Value;
      Next;
    end;
  end;
end;

//uses formSelectMultiItem,SelectItemUnit;

//procedure DBGridEHColumnsButtonClick(Sender: TObject;var Handled: Boolean);  //
//var
////  frmSelect: TfrmSelect;
//  i:Integer;
//  L,T,W,X,H:Integer;
//  Vpoint:   Tpoint;
//begin
//  with ((Sender as TControl).Parent).Parent as TDBGridEh do
//  begin     //   ShowMessage(DataSource.DataSet.Name );
//    if  DataSource.DataSet is TClientDataSet then
//    if ((((Sender as TControl).Parent).Parent as TDBGridEh).DataSource.DataSet as TClientDataSet).ReadOnly then
//    Exit;
//    if  DataSource.DataSet is TCustomADODataSet then
//    if (DataSource.DataSet as TCustomADODataSet).LockType=ltReadOnly then
//    Exit;
//    if ReadOnly then        //�����ǰ���ؼ���ֻ�����˳���
//    Exit;
////    if SelectedField.ReadOnly then    //�����ǰ���ѡ����ֶ���ֻ��
////    Exit;
//  end;
// // ((Sender as TControl).Parent as TColumnEh).
//
//
//  with ((Sender as TControl).Parent).Parent as TDBGridEh do  //Button�ĸ���EDIT��EDIT�ĸ�����DBGRIDEH�ؼ�
//  begin
//    try
//      begin
//        for i:=0 to High( DropDown_Info) do
//        begin
//          if UpperCase(DropDown_Info[i].L_DropdownColumn)=UpperCase(SelectedField.FieldName)  then
//          with DropDown_Info[i] do
//          begin
//             Vpoint   := (Sender as TControl).Parent.ClientToScreen(Point((Sender as TControl).Left,(Sender as TControl).Top));
//             t:= Vpoint.y+(Sender as TControl).Height;
//             if L_FormWidth  =0 then
//               w:=400
//             else
//               w:=L_FormWidth;
//             if L_FormHeight  =0 then
//               H:=240
//             else
//               H:=L_FormHeight;
//             x:=Screen.Width- Vpoint.X-w- (Sender as TControl).Parent.Width;
//             if x<0 then
//               L:=Screen.Width -w- (Sender as TControl).Parent.Width
//             else
//               L:= Vpoint.X- (Sender as TControl).Parent.Width;
//               //��Ļ�ĸ߶�-�ؼ���ť���ڵĸ߶�  С�ڵ������ڵĸ߶�
//             if  (Screen.Height-t)<   h then t:=Screen.Height-h;
//
//            if L_ListDataSetName.Active=False then
//            L_ListDataSetName.Open;                  //
//            //DataSource.DataSet.FieldByName(L_DropdownColumn).OnChange(DataSource.DataSet.FieldByName(L_DropdownColumn))
//            if L_FormType=1 then
//            begin
//              if ShowAddListForm(Self.Handle,L_ListDataSetName,L_ListDataSetFilterField,
//                        Trim(L_GridName.FieldColumns[L_DropdownColumn].Field.Value),
//                        L,T,L_FormWidth) then   //
//              begin
//                if not (L_GridName.DataSource.DataSet.State in [dsEdit,dsInsert]) then
//                  L_GridName.DataSource.DataSet.Edit;
//                L_GridName.DataSource.DataSet.FieldByName(L_GetValueField).Value :=
//                              L_ListDataSetName.FieldByName(L_ListResultField).value;
//                if L_GridName.DataSource.DataSet.Filtered then
//                L_GridName.DataSource.DataSet.Filtered :=False;
//              end  ;
//            end
//            else
//            if L_FormType=2 then
//            begin
//              if ShowfrmSelectMultiItem(Self.Handle,L_ListDataSetName,'',
//                        L,T,L_FormWidth) then   //
//              begin
//                if  L_ListDataSetName.FieldByName('selected').AsBoolean then
//                begin
//                  if L_GridName.DataSource.DataSet.State <> dsInsert then
//                    L_GridName.DataSource.DataSet.Insert;
//                  L_GridName.DataSource.DataSet.FieldByName(L_GetValueField).Value :=
//                                L_ListDataSetName.FieldByName(L_ListResultField).value;
//                  L_ListDataSetName.FieldByName('selected').AsBoolean:=False;
//                  L_ListDataSetName.Next;
//                end;
////                if not (L_GridName.DataSource.DataSet.State in [dsEdit,dsInsert]) then
////                  L_GridName.DataSource.DataSet.Edit;
////                L_GridName.DataSource.DataSet.FieldByName(L_GetValueField).Value :=
////                              L_ListDataSetName.FieldByName(L_ListResultField).value;
//                if L_GridName.DataSource.DataSet.Filtered then
//                L_GridName.DataSource.DataSet.Filtered :=False;
//              end  ;
//            end;
//          end;
//        end;
//      end;
//    finally
//    //  frmSelect.Free;
//    end;
//  end;
//end;

procedure ColumnAddList(DghName:TDBGridEH;DghColName:string;SQL: string);
var
  DtAddList:TADODataSet;
begin
  DtAddList:=TADODataSet.Create(nil);
  with  DtAddList  do
  begin
    Connection:=DM.ADOConnection1;
    CommandText:=SQL;
    LockType:= ltReadOnly;
    Open;   //��Ҫ��ӵļ�¼��

    if   RecordCount>0 then
    begin
      DghName.FieldColumns[DghColName].AutoDropDown:=True;  //�б���Զ�����
      while not  Eof do
      begin
        DghName.FieldColumns[DghColName].PickList.Add( Fields[0].AsString);
        Next;
      end;
    end;
    Close;
  end;
end;

Function AddSQL(S:String):String;
begin//���ܣ����ڶ�̬SQL��ѯ�����������SQL����ǿգ�����WHERE ���򷵻�AND��
  if S='' then
    AddSQL:=' where '
  else  //ע�⣺һ��Ҫ�пո�
    AddSQL:=' and ';
end;
      { }
Function  GetDataBaseSmallDate(cds:TClientDataSet):TDateTime;
begin
  cds.Close;
  cds.CommandText:='select cast(getdate()as smallDatetime)'  ;
  cds.Open;
//  ShowMessage(cds.FieldList[0].FieldName);
  Result:=cds.FieldList[0].AsDateTime;
end; 

procedure OutputExcelStd(AForm:TForm;ADBGridEh:TDBGridEh);
var
  ExpClass:TDBGridEhExportClass  ;
  Ext:String;
  FFileName:string;
  SaveDialog1:TSaveDialog;
begin
  SaveDialog1:=TSaveDialog.Create(AForm);
  SaveDialog1.Filter:='*.xls|*.xls|*.csv|*.csv|*.htm|*.htm|*.txt|*.txt';
  SaveDialog1.FileName := AForm.Caption;
 // if (ActiveControl is TDBGridEh) then
  if SaveDialog1.Execute then
  begin
    case SaveDialog1.FilterIndex of
      1: begin ExpClass := TDBGridEhExportAsXLS;  Ext := 'xls'; end;
      2: begin ExpClass := TDBGridEhExportAsCSV;  Ext := 'csv'; end;
      3: begin ExpClass := TDBGridEhExportAsHTML; Ext := 'htm'; end;
      4: begin ExpClass := TDBGridEhExportAsText; Ext := 'txt'; end;
    else
      ExpClass := nil; Ext := '';
    end;

    if ExpClass <> nil then
    begin
      if UpperCase(Copy(SaveDialog1.FileName,Length(SaveDialog1.FileName)-2,3)) <>
          UpperCase(Ext) then
        FFileName := SaveDialog1.FileName + '.' + Ext;
      if   FileExists(FFileName)   then
      if messagedlg('�ļ���'+FFileName+'���Ѿ�����,��Ҫ������?',mtconfirmation,[mbyes,mbno],0)=mrNo then
        Exit;
      try
        Screen.Cursor := crHourGlass;
        ADBGridEh.DataSource.DataSet.DisableControls;
        if ADBGridEh.DataSource.DataSet is Tcds then
        (ADBGridEh.DataSource.DataSet as Tcds).F_IsBatchOperating:=True;
        SaveDBGridEhToExportFile(ExpClass,ADBGridEh,FFileName,True);    //����ȫ�����ݡ�
      finally
        if ADBGridEh.DataSource.DataSet is Tcds then
        (ADBGridEh.DataSource.DataSet as Tcds).F_IsBatchOperating:=False;
        ADBGridEh.DataSource.DataSet.EnableControls;
        Screen.Cursor := crDefault;
      end;
      
    //��SaveDBGridEhToExportFile(ExpClass,TDBGridEh(ActiveControl),pExpFile,False);  //����ѡ������
    end;
  end;
end;

function App_init_2(AdoConn: TADoConnection): boolean;
var
  ZAppName: array[0..127] of char;
  db_ptr,s,title_name,data_name: String;
  Found: HWND;
  vprog: pchar;
begin
  try
    result := true;
    hMapFile := CreateFileMapping($FFFFFFFF, nil, page_ReadWrite, 0, 100, 'coimasp20');
    MapFilePointer := MapViewOfFile(hMapFile, File_Map_All_Access, 0, 0, 0);
    S := PAnsiChar(MapFilePointer);   //
    UserRKEY := StrToInt(copy(S,1,pos(' ',s)-1));
    vprev := copy(S, pos(' ', s) + 1, 1);
    data_name:=copy(S, pos('/', s) + 1, pos(',', s)-pos('/', s)-1);
    db_ptr := trim(copy(S, pos(',', s) + 1, length(s) - pos(',', s)));
    if trim(db_ptr) = '' then
    begin
      result := false;
      exit;
    end;

    title_name := application.Title+' '+data_name;
    application.Title := 'OnlyOne' + IntToStr(HInstance);
    vprog := pchar(title_name);

    strpcopy(ZAppName, vprog);
    Found := FindWindow(nil, ZAppName);
    if Found <> 0 then
    begin
      ShowWindow(Found, SW_SHOWMINIMIZED);
      ShowWindow(Found, SW_SHOWNORMAL);
      application.Terminate;
    end;
    application.Title := title_name;

    AdoConn.Connected := false;
    AdoConn.ConnectionString := db_ptr;
    AdoConn.Connected := true;
    SetEmployeeInfo(DM.dtRead) ;
  except
    result := false;
  end;
end;

procedure NewNumb(Qry0004:TClientDataSet);        //DT�Ǵ�Data0004������ݼ������ҹ��������ǵ�ǰ�򿪵ı�
var                       {1���ݼ�����ɹ��󣬵��øù����Զ���1��}
  i:Integer;
  Num:Integer;
  OldID:string;
  NewID:string;
begin
  if Qry0004.RecordCount=1 then
  begin
    OldID:=Qry0004.FieldByName('SEED_VALUE').AsString  ;
    for i:=Length(OldID) downto 1 do
    begin
      if (Copy(OldID,i,1 )<'0')  or (Copy(OldID,i,1 )>'9')  then   //�����������
        begin
          Num:=StrToInt(copy(OldID,i+1,Length(OldID)-i))+1;   //��׺���ּ�1

          NewID:= Copy(OldID,1,i);  //��ֵǰ׺
          NewID:=NewID+copy(OldID,Length(NewID)+1,Length(OldID)-length(NewID)-Length(inttostr(Num)))+inttostr(Num);
          Qry0004.Edit;       //ÿ����һ�Σ������ھɱ�ŵĺ������1
          Qry0004.FieldByName('SEED_VALUE').AsString:=NewID;
          Qry0004.Post;
          Qry0004.ApplyUpdates(0) ;
          Exit;
        end
      else
      if I=1 then  //�����һλ��Ȼ������
      begin
        Num:=StrToInt(copy(OldID,i+1,Length(OldID)-i))+1;
        NewID:= copy(OldID,1,Length(OldID)-Length(inttostr(Num)))+inttostr(Num) ;
        //  NewID:= IntToStr(StrToInt(OldID)+1);
        Qry0004.Edit;
        Qry0004.FieldByName('SEED_VALUE').AsString:=NewID;
        Qry0004.Post;
        Qry0004.ApplyUpdates(0) ;
      end;
    end;
  end;
end;

Function  SQLResultValue(cds:TClientDataSet;SQL:string):string;
begin
  Result:='';
  with cds do
  begin
    Close;
    CommandText:=SQL;
    Open;
    if FieldList[0].IsNull  then
      Result:=''
    else
      Result:=FieldList[0].Value;
  end;
end;

procedure MsgError(msg:string);
begin
  messagedlg(msg,mterror,[mbok],0);
end;
procedure MsgWarning(msg:string);
begin
  messagedlg(msg,mtwarning,[mbok],0);
end;
procedure MsgInfo(msg:string);
begin
  messagedlg(msg,mtinformation,[mbok],0);
end;

function Msg_Ask(info:string; AMsgDlgBtn :TMsgDlgButtons;FormCaption:string='ѯ��'):Integer;
var
  FMessageDialog: TForm;
begin
  FMessageDialog := CreateMessageDialog(info,mtConfirmation,AMsgDlgBtn);
  with   FMessageDialog do
  begin
    Caption:=FormCaption;
    ShowModal;
    Result:=ModalResult ;
  end;

  //Result:=Dlg(s_Confirmation,info,mtConfirmation,AMsgDlgBtn);
end;

Function RecordExists(SQL:string; cds:TClientDataSet):boolean;
begin
  Result:=False;
  with  cds do
  begin
    Close;
    CommandText:= SQL;
    Open;              //���ܣ�ͨ��ִ��SQL��䣨�����Ƕ���Ӳ��ң���������ر����Ƿ������ؼ�¼�������ڲ��ҡ�����ҵ�������ֵ�����򷵻ؼ�ֵ��
                      //�÷���if RecordExists('select * from GongYingShang where ��Ӧ�̱��='+ quotedstr(trim(ADODateSet1.FieldByName('��Ӧ�̱��').AsString )))=false then showmessage('������');
    if IsEmpty=False then
      Result:=true;
    close;
  end;
end;

procedure CLS(AForm:TForm);  //���ã�cls(self);��CLS��MYFORMNAME��
var
  i:integer;
begin
  with   AForm  do
  for i:=ComponentCount-1 downto 0  do
  begin
    if (Components[i] is Tedit) then //�����TEDIT����ͽ�����ա�
      TEdit(Components[i]).Clear
    else
    if (Components[i] is Tcombobox) then  //�����TCOMBOBOX����ͽ�����ա�
    begin
      TCombobox(Components[i]).ItemIndex:=-1;
      TCombobox(Components[i]).Text:='';
    end;
  end;
end;

Function  GetDataBaseDate(var cds:TClientDataSet;TType:Byte=0):TDateTime;
var
  str_SQL:string;
begin
  if TType=0 then
    str_SQL:='select GetDate()'
  else
  if TType=1 then
    str_SQL:='select cast(getdate()as smallDatetime)'
  else
  if TType=2 then
    str_SQL:='select convert(char(10),GetDate(),120)' ;

  with  cds do
  begin
    Close;
    CommandText:=str_SQL;
    Open;
    Result:=FieldList[0].AsDateTime;
    Close;
  end;
end;
  {
Function  GetDataBaseDateTime(var cds:TClientDataSet):TDateTime;
begin
  with  cds do
  begin
    Close;
    CommandText:='select GetDate()';
    Open;
    Result:=FieldList[0].AsDateTime;
    Close;
  end;
end;  }

procedure KeyPressDBGridEH(Sender: TDBGridEH; var Key: Char;F:TForm);
var
i:integer;
begin
  if Key = #13 then
  if f.ActiveControl = Sender then
  begin
    if TDBGridEH(f.ActiveControl).SelectedIndex= TDBGridEH(f.ActiveControl).FieldCount-1 then  //���ѡ�������һ�С�
    begin
      DghReadOnlyFocus(Sender as TDBGridEh);
      //TDBGridEH(f.ActiveControl).SelectedIndex:=0 ;      //�������ص�һ�С�
      Key := #0;
    end
    else
    begin
      for i:=TDBGridEH(f.ActiveControl).SelectedIndex+1 to TDBGridEH(f.ActiveControl).FieldCount-1 do //
      begin
        if (TDBGridEH(f.ActiveControl).Columns[i].ReadOnly=false) and (TDBGridEH(f.ActiveControl).Columns[i].Visible=true) then
          begin
            TDBGridEH(f.ActiveControl).SelectedIndex :=i; //TDBGridEH(f.ActiveControl).SelectedIndex+1
            Key := #0;
            exit;
          end
        else
        if I=TDBGridEH(f.ActiveControl).FieldCount-1  then
          begin
            DghReadOnlyFocus(Sender as TDBGridEh);
             //TDBGridEH(f.ActiveControl).SelectedIndex:=0 ;      //�������ص�һ�С�
            Key := #0;
          end;
      end;
    end;
  end;
end;

procedure ColNotReadOnlyFocus(F:TForm;Ds:TDataSet);
var
  i:Integer;
begin
  for i:=0 to F.ComponentCount-1 do
  begin
    if (F.Components[i] is TDBGridEh) then
    if (F.Components[i] as TDBGridEh).DataSource.DataSet=Ds then
    begin
      DghReadOnlyFocus(F.Components[i] as TDBGridEh);
      Exit;
    end;
  end;
end;

procedure DghReadOnlyFocus(Sender :TDBGridEh);
var
  i:Integer;
begin
  for i:=0 to   (Sender as TDBGridEh).FieldCount-1   do
  begin
    if ((Sender as TDBGridEh).Columns[i].ReadOnly=false)and ((Sender as TDBGridEh).Columns[i].Visible=True ) then   //������ֶε�ֻ��Ϊ��
    begin
      (Sender as TDBGridEh).SelectedIndex:=i;            //���ֶλ�ý��㡣
      Exit;
    end;
  end;
end;

//{procedure MsgError(AHandle:THandle;Msg:string);
//begin
//  messagebox(AHandle,PChar(Msg),'����',MB_ok+MB_iconStop)  ;
//  {  s:=messagebox(0,'���ݻ�û�б��棬��Ҫ������','��ʾ',MB_yesnocancel+MB_iconquestion)  ;
//    if s=idyes then
//    ds.Post
//    else if s=idcancel then
//    abort;   }
////messagebox(0,'��Ҫ�˳���','',MB_yesnocancel+MB_iconStop);
////MB_iconquestion          ѯ��
////MB_iconinformation      ��Ϣ
////MB_iconStop             ����
//// messagebox(0,'��Ҫ�˳���','',MB_ok+MB_iconinformation);
//{
//if (ADODataSet1.State=dsinsert) or (ADODataSet1.State= dsedit) then
//   }
////end;    }

//procedure MsgWarning(AHandle:THandle;Msg:string);
//begin
//
//end;
//
//procedure MsgInfo(AHandle:THandle;Msg:string);
//begin
//
//end;

end.
