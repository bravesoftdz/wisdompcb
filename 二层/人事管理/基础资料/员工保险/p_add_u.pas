unit p_add_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, ToolWin, ComCtrls, StdCtrls, Mask, DBCtrls,
  ExtCtrls,Pick_Item_Single,ConstVar,common,
  DB, ADODB, DBCtrlsEh, Grids, DBGridEh, DBClient,StrUtils;
type
  TDropDownInfo=class
  private
  protected
  public
    L_GridName:       TDBGridEh;         //��������б��������ĸ��������
    L_ListDataSetName:TDataSet;    //�����б����ݼ���
    L_DropdownColumn:string;             //��������б�ı������
    L_ListDataSetFilterField:string;     // �����б����ݼ������ֶ�����
    L_GetValueField :string;             //��ȡֵ���ֶ���
    L_ListResultField :string;           //�����б����ݼ����ص��ֶ���     AnsiString
    L_FormWidth:Integer;                 //��������Ŀ��
    L_FormHeight:Integer;                //��������ĸ߶�
    L_FormType:Integer;                  //������������� 1:��ѡ���ڣ�2����ѡ����
  end;
type
  Tfrm_p_add = class(TForm)
    DataSource1: TDataSource;
    dbgrdh1: TDBGridEh;
    tlb1: TToolBar;
    btInsert: TSpeedButton;
    btEdit: TSpeedButton;
    btPost: TSpeedButton;
    btCancel: TSpeedButton;
    btDelete: TSpeedButton;
    btFilter: TSpeedButton;
    btRefresh: TSpeedButton;
    btOut: TSpeedButton;
    btPrior: TSpeedButton;
    btNext: TSpeedButton;
    btUpload: TSpeedButton;
    btDownload: TSpeedButton;
    SpeedButton1: TSpeedButton;
    btPrint: TSpeedButton;
    btClose: TSpeedButton;
    lbl1: TLabel;
    procedure btInsertClick(Sender: TObject);
    procedure btPostClick(Sender: TObject);
    procedure DataSource1StateChange(Sender: TObject);
    procedure btCancelClick(Sender: TObject);
    procedure btDeleteClick(Sender: TObject);
    procedure btRefreshClick(Sender: TObject);
    procedure btPriorClick(Sender: TObject);
    procedure btNextClick(Sender: TObject);
    procedure dbgrdh1KeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
private
    DropDown_Info:array of TDropDownInfo;
    procedure DBGridEHColumnsButtonClick(Sender: TObject;var Handled: Boolean);
    Function PrimKeyExists(AQ:TADOQuery;Sql:string):boolean;
    procedure DghReadOnlyFocus(Sender :TDBGridEh);
  procedure ColNotReadOnlyFocus(F:TForm;Ds:TDataSet);
  procedure KeyPressDBGridEH(Sender: TDBGridEh; var Key: Char;F:TForm) ;
    { Private declarations }
  public
    procedure ColumnAddPickList(ADBGridEH:TDBGridEH;ColumnName:string;ADataSet:TDataSet;AFieldName:string); overload;
    procedure ColumnAddPickList(ADBGridEH:TDBGridEH;ColumnName:string;AList:array of string); overload;
    function SaveCheck():Boolean;
  end;

var
  frm_p_add: Tfrm_p_add;

implementation

uses damo, SelectItemUnit;

{$R *.dfm}
procedure Tfrm_p_add.DBGridEHColumnsButtonClick(Sender: TObject;var Handled: Boolean);  //
var
  i:Integer;
  L,T,W,X,H:Integer;
  Vpoint:   Tpoint;
begin
  with ((Sender as TControl).Parent).Parent as TDBGridEh do
  begin
    if  DataSource.DataSet is TClientDataSet then
    if ((((Sender as TControl).Parent).Parent as TDBGridEh).DataSource.DataSet as TClientDataSet).ReadOnly then
    Exit;
    if  DataSource.DataSet is TCustomADODataSet then
    if (DataSource.DataSet as TCustomADODataSet).LockType=ltReadOnly then
    Exit;
    if ReadOnly then        //�����ǰ���ؼ���ֻ�����˳���
    Exit;

  end;  
  with ((Sender as TControl).Parent).Parent as TDBGridEh do  //Button�ĸ���EDIT��EDIT�ĸ�����DBGRIDEH�ؼ�
  begin
    try
      begin
        for i:=0 to High( DropDown_Info) do
        begin
          if UpperCase(DropDown_Info[i].L_DropdownColumn)=UpperCase(SelectedField.FieldName)  then
          with DropDown_Info[i] do
          begin
             Vpoint   := (Sender as TControl).Parent.ClientToScreen(Point((Sender as TControl).Left,(Sender as TControl).Top));
             t:= Vpoint.y+(Sender as TControl).Height;
             if L_FormWidth  =0 then
               w:=400
             else
               w:=L_FormWidth;
             if L_FormHeight  =0 then
               H:=240
             else
               H:=L_FormHeight;
             x:=Screen.Width- Vpoint.X-w- (Sender as TControl).Parent.Width;
             if x<0 then
               L:=Screen.Width -w- (Sender as TControl).Parent.Width
             else
               L:= Vpoint.X- (Sender as TControl).Parent.Width;
               //��Ļ�ĸ߶�-�ؼ���ť���ڵĸ߶�  С�ڵ������ڵĸ߶�
             if  (Screen.Height-t)<   h then t:=Screen.Height-h;

            if L_ListDataSetName.Active=False then
            L_ListDataSetName.Open;                  //
            //DataSource.DataSet.FieldByName(L_DropdownColumn).OnChange(DataSource.DataSet.FieldByName(L_DropdownColumn))
            //ShowMessage(IntToStr(w));
            if L_FormType<=1 then
            begin
              if ShowAddListForm(Self.Handle,L_ListDataSetName,L_ListDataSetFilterField,
                        Trim(L_GridName.FieldColumns[L_DropdownColumn].Field.asstring),
                        L,T,w) then   //
              begin
               if not (L_GridName.DataSource.DataSet.State in [dsEdit,dsInsert]) then
               L_GridName.DataSource.DataSet.Edit;
                L_GridName.DataSource.DataSet.FieldByName(L_GetValueField).Value :=
                L_ListDataSetName.FieldByName(L_ListResultField).value;
                if L_GridName.DataSource.DataSet.Filtered then
                L_GridName.DataSource.DataSet.Filtered :=False;
              end  ;
              //
            end;
          end;
        end;
      end;
    finally
    //  frmSelect.Free;
    end;
  end;
end;

Function Tfrm_p_add.PrimKeyExists(AQ:TADOQuery;Sql:string):boolean;
//var
//  myqu:TADOquery;
begin
  try
    Result:=False;
    AQ.Close;
    AQ.SQL.Clear;
    AQ.SQL.Add(sql);
    AQ.Open; //���ܣ�ͨ��ִ��SQL��䣨�����Ƕ���Ӳ��ң���������ر����Ƿ������ؼ�¼�������ڲ��ҡ�����ҵ�������ֵ�����򷵻ؼ�ֵ��
//�÷���if PrimKeyExists('select * from GongYingShang where ��Ӧ�̱��='+ quotedstr(trim(ADODateSet1.FieldByName('��Ӧ�̱��').AsString )))=false then showmessage('������');
    if AQ.IsEmpty=False then
    Result:=true ;
  finally
   // myqu.Free;
  end;
end;
procedure Tfrm_p_add.DghReadOnlyFocus(Sender :TDBGridEh);
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

procedure Tfrm_p_add.ColNotReadOnlyFocus(F:TForm;Ds:TDataSet);
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

procedure Tfrm_p_add.KeyPressDBGridEH(Sender: TDBGridEH; var Key: Char;F:TForm);
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
procedure Tfrm_p_add.ColumnAddPickList(ADBGridEH:TDBGridEH;ColumnName:string;AList:array of string);
var
  i:Integer;
begin
  if  High(AList )>0 then
  begin
    ADBGridEH.FieldColumns[ColumnName].AutoDropDown:=True;  //�б���Զ�����
    for i:=0 to High(AList ) do
    begin
      ADBGridEH.FieldColumns[ColumnName].PickList.Add( AList[i]);
    end;
  end;
end;

procedure Tfrm_p_add.ColumnAddPickList(ADBGridEH:TDBGridEH;ColumnName:string;ADataSet:TDataSet;AFieldName:string);
begin
  with  ADataSet  do
  begin
    if Active=False then
    Open;   //��Ҫ��ӵļ�¼��

    if   RecordCount>0 then
    begin
      ADBGridEH.FieldColumns[ColumnName].AutoDropDown:=True;  //�б���Զ�����
//      ADBGridEH.FieldColumns[ColumnName].ButtonStyle:=cbsDropDown;
//      ADBGridEH.FieldColumns[ColumnName].AlwaysShowEditButton:=true;
      while not  Eof do
      begin
        ADBGridEH.FieldColumns[ColumnName].PickList.Add( FieldByName(AFieldName).AsString);
        Next;
      end;
    end;
  end;
end;
 function Tfrm_p_add.SaveCheck():Boolean;
var
  strMsg,strSQL,date_s:string;
  I_Row:Integer;
  date_e: TDateTime;
begin
  Result:=False;
  strMsg:='';

  with DM.ds4 do
  begin
    if State in [dsEdit ,dsInsert] then
    Post;
//    if IsEmpty then
//      strMsg:=strMsg+'��ϸ������Ҫ��һ�м�¼������'+#13
//    else
    begin
      try
        DisableControls ;
        First;
        for I_Row:=0 to RecordCount-1 do
        begin
          if FieldByName('employeeid') .IsNull then
          strMsg:=strMsg+'��'+IntToStr(I_Row+1)+'�У��ֶΣ�'+FieldByName('chinesename').DisplayLabel +'����ֵ����Ϊ�գ�����'+#13;
          if FieldByName('yearmonth') .IsNull then
          begin
          strMsg:=strMsg+'��'+IntToStr(I_Row+1)+'�У��ֶΣ�'
          +FieldByName('yearmonth').DisplayLabel +'����ֵ����Ϊ�գ�����'+#13;
          end
          else
          begin
            date_s:=FieldByName('yearmonth').AsString; 
            if    length(date_s)= 6  then
            date_s := LeftStr(FieldByName('yearmonth').AsString,4)+'-'
                      +rightStr(FieldByName('yearmonth').AsString,2)+'-01'
            else date_s :='';  
            if  not   TryStrTodate(date_s,date_e)   then
            strMsg:=strMsg+'��'+IntToStr(I_Row+1)+'�У��ֶΣ�'
            +FieldByName('yearmonth').DisplayLabel +'����ֵ��ʽ���ԣ�����'+#13;
          end;
          if FieldByName('insurance_type').IsNull  then
          strMsg:=strMsg+'��'+IntToStr(I_Row+1)+'�У��ֶΣ�'+FieldByName('item').DisplayLabel +'����ֵ����Ϊ�գ�����'+#13;
          if (UpdateStatus=usInserted)and(FieldByName('employeeid').AsString<>'')
            and(FieldByName('insurance_type').AsString<>'')
            and (FieldByName('yearmonth').AsString<>'')  then
          begin
            strSQL:='select * from dbo.employee_insurance where employeeid='+FieldByName('employeeid').AsString
               +' and insurance_type='+FieldByName('insurance_type').AsString
               +' and yearmonth='+FieldByName('yearmonth').AsString;
            //ShowMessage(strSQL)   ;
            if PrimKeyExists(DM.ADOQuery1,strSQL)   then
            strMsg:=strMsg+'��'+IntToStr(I_Row+1)+'�У�'+FieldByName('chinesename').DisplayLabel+'��'+FieldByName('chinesename').AsString +'��'
                          +FieldByName('item').DisplayLabel+'��'+FieldByName('item').AsString
                          +FieldByName('yearmonth').DisplayLabel+'��'+FieldByName('yearmonth').AsString
                          +'���ü�¼�Ѿ����ڣ�����'+#13;
          end;
          Next;  
        end;
      finally
        EnableControls;
      end;

    end;
  end;   

  if strMsg<>'' then
  begin
    strMsg:=Copy(strMsg,0,Length(strMsg)-1);
    ShowMessage(strMsg);
    Result:=True;
  end;
end;

procedure Tfrm_p_add.btInsertClick(Sender: TObject);
begin
  with DM.ds4 do
  if Active then
  Append;
end;

procedure Tfrm_p_add.btPostClick(Sender: TObject);
begin
  with DM.ds4 do
  begin
    if  State in [dsEdit,dsInsert ]  then
    Post;
    if SaveCheck=False then
    begin
      if changeCount >0 then
      ApplyUpdates(0);
    end
    else
    Abort;
  end;
  DataSource1StateChange(DataSource1);
end;

procedure Tfrm_p_add.DataSource1StateChange(Sender: TObject);
begin
  if DM.ds4.Active then
  lbl1.Caption := '       ��������������:'+inttostr(dm.ds4.RecordCount);
  
  begin
    if  (dm.ds4.State in[dsEdit,dsInsert])or(DM.ds4.ChangeCount>0) then
    begin
      btInsert.Enabled:=False;
      btEdit.Enabled:=False;
      btPost.Enabled:=True;
      btCancel.Enabled:=True;
      btRefresh.Enabled:=False;
      btNext.Enabled:=False;
      btPrior.Enabled:=False;
    end
    else
    begin
      btInsert.Enabled:=True;
      btEdit.Enabled:=True;
      btPost.Enabled:=False;
      btCancel.Enabled:=False;
      btRefresh.Enabled:=True;
      btNext.Enabled:=True;
      btPrior.Enabled:=True;
    end;
  end;

end;

procedure Tfrm_p_add.btCancelClick(Sender: TObject);
begin
  with DM.ds4 do
  if Active=True then
  begin
    Cancel;
    CancelUpdates;
  end;
  DataSource1StateChange(DataSource1);
end;

procedure Tfrm_p_add.btDeleteClick(Sender: TObject);
var i : Integer;
begin
  with DM.ds4 do
  if Active and (not IsEmpty) then
  with dbgrdh1 do
  begin
    if SelectedRows.Count >1 then  //����û�ѡ�����������1�������С�
      begin
        try
          with   DataSource.DataSet   do
          for i:= SelectedRows.Count -1 downto 0 do
          begin
          GotoBookmark(pointer(SelectedRows.Items[i]));
          Delete;        //ɾ�����С�
          end;
        finally
        end;
      end
    else
     DataSource.DataSet.Delete; //�����û�ѡ����ǵ��У�ɾ����
  end ;

  DataSource1StateChange(DataSource1);
end;

procedure Tfrm_p_add.btRefreshClick(Sender: TObject);
var
  i_employeeid,i_datadetail_ptr :Integer;
  D_inputdate:TDateTime;
begin
  //i_employeeid     := DM.cdsHrcertificate1.fieldByName('employeeid').Value;
  //i_datadetail_ptr := DM.cdsHrcertificate1.fieldByName('datadetail_ptr').Value;
  //D_inputdate      := DM.cdsHrcertificate1.fieldByName('inputdate').Value;
  DM.ds4.Refresh;
  //DM.ds4.Locate('employeeid;datadetail_ptr;inputdate',VarArrayOf([i_employeeid,i_datadetail_ptr,D_inputdate]),[]) ;
end;

procedure Tfrm_p_add.btPriorClick(Sender: TObject);
begin
  with DM.ds4 do
  if Active then
  Prior;
end;

procedure Tfrm_p_add.btNextClick(Sender: TObject);
begin
  with DM.ds4 do
  if Active then
  Next;
end;

procedure Tfrm_p_add.dbgrdh1KeyPress(Sender: TObject; var Key: Char);
begin
 //KeyPressDBGridEH(Sender as TDBGridEh, key,self);
end;

procedure Tfrm_p_add.FormCreate(Sender: TObject);
var
  i:Integer;
begin  
  SetLength(DropDown_Info,1);
  DropDown_Info[0]:=TDropDownInfo.Create();
  with DropDown_Info[0] do
  begin
    L_GridName              :=dbgrdh1;
    L_ListDataSetName       :=DM.dt_v_employeemsg;
    L_DropdownColumn        :='idcard';
    L_ListDataSetFilterField:='idcard';
    L_ListResultField       :='idcard';
    L_GetValueField         :='idcard';
  end;

  for i:=0 to High(DropDown_Info) do
  begin
    with (DropDown_Info[i].L_GridName) do
    begin
      FieldColumns[DropDown_Info[i].L_DropdownColumn].ButtonStyle:=cbsDropDown;
      FieldColumns[DropDown_Info[i].L_DropdownColumn].AlwaysShowEditButton:=true;
      FieldColumns[DropDown_Info[i].L_DropdownColumn].OnEditButtonClick:= DBGridEHColumnsButtonClick;
    end;
  end;
  
  dm.dt_v_employeemsg.Open;
  dm.dt_0005.Open;
  ColumnAddPickList(dbgrdh1,'idcard',DM.dt_v_employeemsg,'idcard');
 // ColumnAddPickList(dbgrdh1,'chinesename',DM.dt_v_employeemsg,'chinesename');

  if DM.dt_dictid.Active=False then DM.dt_dictid.Active:=True;
  dm.dt_dictid.Open;
  dm.dt_dictid.First;
  ColumnAddPickList(dbgrdh1,'item',DM.dt_dictid,'item');
  dbgrdh1.DataSource.DataSet.Open;

end;

procedure Tfrm_p_add.FormClose(Sender: TObject; var Action: TCloseAction);
var
  s:integer;
begin
  with DM.ds4 do
  if Active then
  if  (State in [dsInsert,dsEdit])or (ChangeCount>0 )then
  begin
     S:= messagedlg('���ݻ�û�б���,��Ҫ������?',mtconfirmation,[mbyes,mbno,mbcancel],0);
     if S = mryes  then
       begin
         if  (State in [dsInsert,dsEdit]) then
         Post  ;
         if SaveCheck then
         Abort;
         ApplyUpdates(0);
       end
     else
     if S = mrcancel then
         abort
     else
     if s=mrNo then
       begin
         Cancel    ;
         CancelUpdates;
       end;
  end;

end;

end.
