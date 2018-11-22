unit AddAttendance;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Buttons, ExtCtrls, Grids,DB, ADODB, Menus;

type
  TForm_AddAttendance = class(TForm)
    ADOEmployeeMsg: TADODataSet;
    ADOEmployeeMsgrkey: TAutoIncField;
    ADOEmployeeMsgemployeecode: TWideStringField;
    ADOEmployeeMsgchinesename: TWideStringField;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Edit5: TEdit;
    Popup1: TPopupMenu;
    N1: TMenuItem;
    PageControl1: TPageControl;
    TabSheet2: TTabSheet;
    Label5: TLabel;
    Label6: TLabel;
    Label4: TLabel;
    Label3: TLabel;
    Edit3: TEdit;
    Edit4: TEdit;
    BitBtn4: TBitBtn;
    SGrd: TStringGrid;
    dtpk1: TDateTimePicker;
    dtpk2: TDateTimePicker;
    Button1: TButton;
    Label1: TLabel;
    procedure BitBtn2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn1Enter(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure Edit3KeyPress(Sender: TObject; var Key: Char);
    procedure N1Click(Sender: TObject);
    procedure Edit4KeyPress(Sender: TObject; var Key: Char);
    procedure Button1Enter(Sender: TObject);
  private
    { Private declarations }
    sql_Text:string;
    n:Byte;
    k:Byte;
    m:Byte;
    i:Byte;
  public
    { Public declarations }
  end;

var
  Form_AddAttendance: TForm_AddAttendance;

implementation

uses dmo, StaffList, common, DBGridEh;

{$R *.dfm}

procedure TForm_AddAttendance.BitBtn2Click(Sender: TObject);
begin
  DM.ADOEmployeecardMsg.Cancel;
  Close;
end;

procedure TForm_AddAttendance.FormShow(Sender: TObject);
begin
  SGrd.Cells[0,0]:='Ա������';
  SGrd.Cells[1,0]:='Ա������';
  SGrd.Cells[2,0]:='���ڿ���';
  sql_Text:=DM.ADOEmployeeMsg.CommandText;
  Label3.Visible:=False;
  dtpk2.Visible:=False;
  m:=0;
  i:=0;
end;

procedure TForm_AddAttendance.BitBtn1Click(Sender: TObject);
var
  i:Byte;
begin
  try
    DM.ADO73.Close;
    DM.ADO73.Parameters[0].Value:=rkey73;
    DM.ADO73.Open;
    if SGrd.RowCount-2<1 then
    begin
      ShowMessage('��û��ѡ��һ��Ա������ѡ��һ��������Ա��');
      Exit;
    end;
    for i := 1 to SGrd.RowCount-2 do
    begin
      with dm.ADOQuery1 do
      begin
        Close;
        SQL.Clear;
        SQL.Add('select isnull(cardno,'''') as cardno from employeemsg where employeecode='''+SGrd.Cells[0,i]+'''');
        Open;
        if FieldValues['cardno']<>'' then
        begin
          ShowMessage('����ͬʱ�ٸ�'+SGrd.Cells[1,i]+'����');
          Exit;
        end;
      end;
    end;
    DM.ADOConn.BeginTrans;
    for i := 1 to SGrd.RowCount-2 do
    begin
      DM.ADOEmployeecardMsgcardno_dec.Value:=SGrd.Cells[2,i];
      DM.ADOEmployeecardMsgemployeeid.Value:=StrToInt(SGrd.Cells[3,i]);
      DM.ADOEmployeecardMsgbegin_time.Value:=dtpk1.DateTime;
      DM.ADOEmployeecardMsgstatus.Value:=1;
      DM.ADOEmployeecardMsgoper_person.Value:=DM.ADO73employee_ptr.Value;
//      DM.ADOEmployeecardMsgoper_person.Value:=781;
      DM.ADOEmployeecardMsgoper_date.Value:=DM.ADOEmployeecardMsgbegin_time.Value;
      with DM.ADOEmployeeMsg do
      begin
        Close;
        CommandText:='select * from employeemsg where 1=1'+' and rkey='+SGrd.Cells[3,i];
        Open;
        Edit;
        FieldValues['Cardno']:=SGrd.Cells[2,i];
      end;
      DM.ADOEmployeecardMsg.Post;
      DM.ADOEmployeeMsg.Post;
      DM.ADOEmployeecardMsg.Append;
    end;
    DM.ADOConn.CommitTrans;
    DM.ADOEmployeeMsg.Close;
    ModalResult:=mrOk;
  except
    on e: exception do
    begin
      DM.ADOConn.RollbackTrans;
//      DM.ADOQuery1.cancel;
      ModalResult:=mrCancel;
      messagedlg(e.message,mterror,[mbcancel],0);
    end;
  end;
end;

procedure TForm_AddAttendance.BitBtn1Enter(Sender: TObject);
var
  i,l,k:Byte;
begin
//  with DM.ADOEmployeeMsg do
//  begin
//    Close;
//    CommandText:=sql_Text+' and employeecode in(''';
//    for l := 0 to SGrd.RowCount-3 do
//    begin
//      if l=SGrd.RowCount-3 then
//        CommandText:=CommandText+ SGrd.Cells[0,l+1]
//      else
//        CommandText:=CommandText+ SGrd.Cells[0,l+1]+''','+'''';
//    end;
//    CommandText:=CommandText+''')';
//    DM.ADOEmployeeMsg.Open;
//    while not Eof do
//    begin
//      SGrd.Cells[3,k+1]:=FieldValues['rkey'];
//      k:=k+1;
//      Next;
//    end;
//  end;
  for i := 0 to SGrd.RowCount-2 do
  begin
    if DM.ADOEmployeecardMsgCardno.Value<>'' then
    begin
      MessageDlg('���ܶ���ͬʱ����Ա�����������Ժ����',mtInformation,[mbOK],0);
      Exit;
    end;
  end;
end;

procedure TForm_AddAttendance.BitBtn4Click(Sender: TObject);
begin
  Form_StaffList:=TForm_StaffList.Create(Application);
  with Form_StaffList.ADOEmployeeMsg do
  begin
    Close;
    if Trim(Edit4.Text)<>'' then
      Parameters[0].Value:=Trim(Edit4.Text)
    else
      Parameters[0].Value:='';
    Open;
    if IsEmpty then
    begin
      MessageDlg('��������ȷ��Ա������',mtInformation,[mbok],0);
      Edit4.SetFocus;
    end;
  end;
  if Form_StaffList.ShowModal=mrok then
  begin
    Edit4.Text:=Form_StaffList.ADOEmployeeMsgemployeecode.Value;
    Label1.Caption:=Form_StaffList.ADOEmployeeMsgchinesename.Value;
    Edit3.SetFocus;
  end;
end;

procedure TForm_AddAttendance.Edit3KeyPress(Sender: TObject;
  var Key: Char);
var
  i:Byte;
begin
  if not (Key in ['0'.. '9','a'.. 'z','A'.. 'Z',#8,#13]) then Key:=#0;
  if Key=#13 then
  begin
    if Trim(Edit3.Text)='' then
    begin
      ShowMessage('���ڿ��Ų���Ϊ��');
      Edit3.SetFocus;
      Exit;
    end
    else
    begin
      with DM.ADOEmployeeMsg do
      begin
        Close;
        CommandText:=sql_Text+' and cardno='''+trim(Edit3.Text)+'''';
        Open;
        if not IsEmpty then
        begin
          MessageDlg('�˿��ѱ�����ʹ��',mtInformation,[mbOK],0);
          Edit3.Text:='';
          Edit3.SetFocus;
          Exit;
        end;
      end;
      for i := 0 to SGrd.RowCount-2 do
      begin
        if Trim(Edit3.Text)=SGrd.Cells[2,i+1] then
        begin
          ShowMessage('��������ͬʱʹ��һ�ſ�');
          Edit3.Text:='';
          Exit;
        end;
      end;
      with DM.ADOQuery1 do
      begin
        Active:=False;
        SQL.Clear;
        SQL.Add('select * from employeecardmsg where cardno_dec='''+trim(Edit3.Text)+''' and (status=2 or status=4)');
        Active:=True;
        if not IsEmpty then
        begin
          ShowMessage('�˿�������Ч��');
          Edit3.Text:='';
          Exit;
        end
        else
          Button1.SetFocus;
      end;
    end;
  end;
end;

procedure TForm_AddAttendance.N1Click(Sender: TObject);
var
  i:Byte;
begin
  if SGrd.RowCount>2 then
  begin
    for i := SGrd.Row to SGrd.RowCount-2 do
      SGrd.Rows[i]:=SGrd.Rows[i+1];
    SGrd.RowCount:=SGrd.RowCount-1;
  end
  else
    SGrd.Rows[SGrd.Row].Clear;
end;

procedure TForm_AddAttendance.Edit4KeyPress(Sender: TObject;
  var Key: Char);
begin
  if Key=#13 then
  begin
    Form_StaffList:=TForm_StaffList.Create(Application);
    with ADOEmployeeMsg do
    begin
      Close;
      if Trim(Edit4.Text)<>'' then
        Parameters[0].Value:=Trim(Edit4.Text)
      else
        Parameters[0].Value:='';
      Open;
      if IsEmpty then
      begin
        ShowMessage('��������ȷ��Ա������');
        Edit4.Text:='';
        Edit4.SetFocus;
        Exit;
      end
      else
      begin
        Edit4.Text:=FieldByName('employeecode').AsString;
        Label1.Caption:=FieldByName('chinesename').AsString;
        Edit3.SetFocus;
      end;
    end;
  end;
end;

procedure TForm_AddAttendance.Button1Enter(Sender: TObject);
var
  y:Byte;
  rkey:Integer;
begin
  if Trim(Edit4.Text)='' then
  begin
    ShowMessage('Ա�����Ų���Ϊ��');
    Edit4.SetFocus;
    Exit;
  end;
  if Trim(Edit3.Text)='' then
  begin
    ShowMessage('���ڿ��Ų���Ϊ��');
    Edit3.SetFocus;
    Exit;
  end;
  with DM.ADOQuery1 do
  begin
    Active:=False;
    SQL.Clear;
    SQL.Add('select isnull(end_time,'''') as end_time,status from employeecardmsg where employeeid = (select rkey from employeemsg where employeecode='''+Trim(Edit4.Text)+''')');
    Active:=True;
    if not IsEmpty then
    begin
      if (DateTimeToStr(FieldValues['end_time'])='') and (StrToInt(FieldValues['status'])=1) then
      begin
        ShowMessage('��Ա�����п��ڿ�');
        Edit4.SetFocus;
        Edit4.SelectAll;
        Exit;
      end
      else
        Edit3.SetFocus;
    end;
  end;
  with DM.ADOQuery1 do
  begin
    Close;
    SQL.Clear;
    SQL.Text:='select isnull(end_time,'''') AS end_time,status from employeecardmsg where cardno_dec='''+trim(Edit3.Text)+'''';
    Open;
    if not IsEmpty then
    begin
      if (DateToStr(FieldValues['end_time'])<>'') and (StrToInt(FieldValues['status'])<>3) then
      begin
        ShowMessage('�˿��������������˿������������뿨��');
        Edit3.SetFocus;
        Exit;
      end;
    end;
  end;
//  if SGrd.RowCount-2>=1 then
  begin
    for y := 0 to SGrd.RowCount-2 do
    begin
      if SGrd.Cells[0,y+1]=Trim(Edit4.Text) then
      begin
        ShowMessage('��Ա���ѱ���ӵ�����������');
        Edit4.Text:='';
        Label1.Caption:='';
        Edit4.SetFocus;
        Exit;
      end;
      if SGrd.Cells[2,y+1]=Trim(Edit3.Text) then
      begin
        ShowMessage('�˿��ڿ����ѱ�����ӵ�����������');
        Edit3.Text:='';
        Edit3.SetFocus;
        Exit;
      end;
    end;
    SGrd.Cells[0,i+1]:=Trim(Edit4.Text);
    SGrd.Cells[1,i+1]:=Trim(Label1.Caption);
    SGrd.Cells[2,i+1]:=Trim(Edit3.Text);
    with DM.ADOQuery1 do
    begin
      Close;
      SQL.Clear;
      SQL.Text:='select rkey from employeemsg where employeecode='''+SGrd.Cells[0,i+1]+'''';
      Open;
      rkey:=FieldValues['rkey'];
    end;
    SGrd.Cells[3,i+1]:=IntToStr(rkey);
    SGrd.RowCount:=SGrd.RowCount+1;
    inc(i);
  end;
  Edit4.Text:='';
  Label1.Caption:='';
  Edit3.Text:='';
  Edit4.SetFocus;
end;

end.
