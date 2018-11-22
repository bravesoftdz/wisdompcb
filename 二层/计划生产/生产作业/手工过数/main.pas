//****************************************************************************//
//****                                                                    ****//
//**** Programer: Jacky Zhong                                             ****//
//**** Date: Aug. 2007                                                    ****//
//****                                                                    ****//
//****                                                                    ****//
//****************************************************************************//
unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGridEh, ExtCtrls, StdCtrls, Mask, DBCtrls, Buttons,
  Menus;

type
  TfrmMain = class(TForm)
    Panel1: TPanel;
    DBGridEh1: TDBGridEh;
    Panel2: TPanel;
    Label5: TLabel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    Label12: TLabel;
    Label15: TLabel;
    DBEdit5: TDBEdit;
    Label4: TLabel;
    DBEdit4: TDBEdit;
    Label7: TLabel;
    DBEdit7: TDBEdit;
    Label2: TLabel;
    Label3: TLabel;
    DBEdit8: TDBEdit;
    Label6: TLabel;
    DBEdit3: TDBEdit;
    Label1: TLabel;
    edtWoNo: TEdit;
    SpeedButton1: TSpeedButton;
    btnExit: TSpeedButton;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    Edit1: TEdit;
    procedure edtWoNoKeyPress(Sender: TObject; var Key: Char);
    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
  private
    { Private declarations }
    FBGoON: Boolean;
    function Update_Data(FromStep,OrgStep:integer):boolean;//�������
    function Update_0048(From_Dept,Next_Dept,UserId,WType,PutType,Wo_ptr,StepNo:integer;ACTION_REF:string):boolean;//������ת��¼48��
    procedure MoveToNextDept;//
  public
    { Public declarations }
  end;

var
  frmMain: TfrmMain;

implementation
uses dm,common,MyClass,WO_Count;
{$R *.dfm}

procedure TfrmMain.FormCreate(Sender: TObject);
begin
  if not App_Init(dmcon.ADOConnection1) then
  begin
    ShowMsg('��������ʧ�ܣ�����ϵϵͳ����Ա��','��ʾ',1);
    application.Terminate;
  end;
  self.Caption :=Application.Title;

//  user_ptr:='3';
//  vprev:='4';
//  dmcon.ADOConnection1.Open;
end;

procedure TfrmMain.edtWoNoKeyPress(Sender: TObject; var Key: Char);
begin
  if trim(edtWoNo.Text) = '' then exit;
  if key = #13 then
   begin
    if dmcon.Check_WO(edtWoNo.Text) then
    begin
      MyDataclass.OpenDataSetByPara(edtWoNo.Text,dmcon.adsWOInfo);
    end
    else
      FBGoON := False;
      dmcon.tmp.Close;
      dmcon.tmp.SQL.Text:='select empl_code from data0005 where rkey='+user_ptr;
      dmcon.tmp.Open;
      edit1.Text:=dmcon.tmp.Fields[0].AsString;
   end;
end;

procedure TfrmMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  MyDataClass.Free;
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  dmcon.aqBasicParam.Close;
  dmcon.aqBasicParam.open;
  MyDataClass :=TMyDataClass.Create(dmcon.ADOConnection1);
  if IS_Stock_Inventorying then
  begin
    ShowMsg('����Ʒ�����̵㣬���ܹ��������飡',1);
    close;
  end;
end;

function TfrmMain.Update_0048(From_Dept, Next_Dept, UserId, WType, PutType,
  Wo_ptr,StepNo: integer;ACTION_REF:string): boolean;
var
  sqlstr:string;
begin
  sqlstr:=' insert into data0048(WO_PTR, FM_DEPT_PTR, TO_DEPT_PTR, INTIME, '+
          ' OUTTIME, QTY_PROD, PANELS, STEP_NO, EMPL_PTR, WTYPE, put_type,warehouse_ptr,ACTION_REF) '+
          ' select Wo_ptr,'+IntToStr(From_Dept)+','+IntToStr(Next_Dept)+',getdate(),getdate(),Qty_BackLog,Panels,'+IntToStr(StepNo)+','+IntToStr(UserId)+
          ' ,'+IntToStr(WType)+','+IntToStr(PutType)+
          ',loc_ptr, '''+ACTION_REF+
          ''' from data0056 where Wo_ptr='+IntToStr(Wo_ptr);

  result := MyDataClass.ExecSql(sqlstr);
  if not result then
    ShowMsg('����48�����!',1); 
end;

function TfrmMain.Update_Data(FromStep,OrgStep:integer): boolean;
var
  sqlstr:string;
  WType,PutType:integer;
  FromDept,NextDept,tmpStep,To_Step:integer;
  Is_Last_Step:boolean;
  sACTION_REF:string;
begin
//�ִ���48,����56
//1.������Ʒ��ת��¼48,  �жϵ�ǰ�����������һ������֮���Ƿ���ڲ���Ҫ�����Ĺ���
//����У���ôÿ�����򶼲���һ��48�ļ�¼��
//�ж���ҵ��Ͷ��״̬,���ж����ϵ�492,���״̬����MRB����,������
  result := false;
  with dmcon do begin
    wType:=0;
    if (adsWOInfo.FieldByName('prod_status').AsInteger = 4)  then //�ⷢ����
      wType:=3;
    if (adsWOInfo.FieldByName('TType').AsInteger=3) or (adsWOInfo.FieldByName('WType').AsInteger >0) then //MRB����,��ô���ڷ���״̬
      wType:=2;

    sqlstr:='SELECT top 1 ACTION_REF from data0048 where wo_ptr='+dmcon.adsWOInfo.fieldbyname('wo_ptr').AsString+' order by rkey desc';
    MyDataClass.OpenQuery(aqTmp,sqlstr);
    sACTION_REF:=aqTmp.Fields[0].AsString;  //��������


    aqNextStepNO.Close;
    aqNextStepNO.Parameters.ParamByName('F01').Value :=adsWOInfo.fieldByname('Bom_ptr').Value;
    aqNextStepNO.Parameters.ParamByName('F02').Value :=OrgStep;
    aqNextStepNO.open;
    Is_Last_Step:= aqNextStepNO.IsEmpty; //�����Ĺ��������һ������
    if Is_Last_Step then
      To_Step:= OrgStep
    else
      To_Step:= aqNextStepNO.FieldByName('STEP_NUMBER').AsInteger;

    sqlstr:=' SELECT D34.rKey,D34.DEPT_CODE, D34.DEPT_NAME, D38.STEP_NUMBER '+
            ' FROM dbo.Data0038 D38 INNER JOIN dbo.Data0034 D34 ON D38.DEPT_PTR = D34.RKEY '+
            ' WHERE D38.Source_ptr='+adsWOInfo.fieldByname('Bom_ptr').Asstring+' and D38.Step_Number>'+IntToStr(FromStep)+
            ' and D38.Step_Number <= '+IntToStr(To_Step)+
            ' order by Step_Number asc ';
    MyDataClass.OpenQuery(aqTmp,sqlstr);
    fromDept:=adsWoInfo.fieldbyName('dept_ptr').AsInteger;
    aqTmp.First;
    while not aqTmp.Eof do
    begin
      NextDept:=aqTmp.fieldbyName('rKey').AsInteger;
      sqlstr:=' select big_dept_ptr from data0034 where rkey in('+IntToStr(fromDept)+','+IntToStr(NextDept)+')'+
              ' group by big_dept_ptr ';
      MydataClass.OpenQuery(aqTmp2,sqlstr);
      if aqTmp2.RecordCount >1 then //��ͬ�İ���
        PutType:=1
      else
        PutType:=0;

      result := Update_0048(fromDept,nextDept,StrToInt(User_ptr),wType,PutType,dmcon.adsWOInfo.FieldbyName('rKey06').AsInteger,aqTmp.fieldbyName('Step_Number').AsInteger-1,sACTION_REF);
      if not result then break;
      fromDept:=aqTmp.fieldbyName('rKey').AsInteger;
      aqTmp.Next;
    end;
    if not result then exit;
    

//2.��������56�� DEPT_PTR��Ϊ��һ������ָ��,STEP��Ϊ��һ�������,INTIME��Ϊ��ǰ�Ĺ���ʱ��
    if not adsFlowList.Locate('Step_Number',To_Step,[]) then
    begin
      ShowMsg('�����쳣,û�ж�λ����¼!',1);
      exit;
    end;

    sqlstr:=' update data0056 set dept_ptr='+adsFlowList.fieldByName('dept_ptr').AsString+
            ' ,Step='+IntToStr(To_Step)+
            ' ,InTime=getdate() where Wo_ptr='+dmcon.adsWOInfo.FieldbyName('rKey06').Asstring;

    sqlstr:= sqlstr +' update Data0056'
           +' set Data0056.WTYPE = 0'
           +' FROM Data0006 INNER JOIN'
                 +' Data0056 ON Data0006.RKEY = Data0056.WO_PTR INNER JOIN'
                 +' Data0025 ON Data0006.BOM_PTR = Data0025.RKEY'
           +' WHERE ('+IntToStr(To_Step) +' IN'
                     +' (SELECT MAX(step_number)'
                    +' FROM data0038 INNER JOIN'
                          +' data0034 ON data0038.dept_ptr = data0034.rkey'
                    +' WHERE data0038.source_ptr = data0025.rkey AND'
                          +' data0034.barcode_entry_flag = ''Y'' AND'
                          +' data0038.flow_no = data0056.flow_no)) AND (Data0006.RKEY ='+ dmcon.adsWOInfo.FieldbyName('rKey06').Asstring +')';

    result := MyDataClass.ExecSql(sqlstr);
    if not result then
    begin
      ShowMsg('����56��ʧ��!',1);
      exit;
    end;

//3.������ҵ��06��:����������Ϊ���һ������ʱ��������ڲ��Ʒ���Ͱ���ҵ��06״̬����Ϊ"������"��prod_status=6�������������Ʒ����ҵ��״̬����Ϊ"�����"��prod_status=5��
    sqlstr:=' SELECT 1 FROM dbo.Data0038 D38 INNER JOIN dbo.Data0034 D34 ON D38.DEPT_PTR = D34.RKEY '+
            ' WHERE D34.BARCODE_ENTRY_FLAG = '+QuotedStr('Y')+' and D38.Source_ptr='+adsWOInfo.fieldByname('Bom_ptr').Asstring+
            ' and D38.Step_Number>'+ IntToStr(To_Step);
    if not MyDataClass.IsExists(sqlstr) then//��������һ�����������һ��������,��ôҪ����ҵ��״̬�ı�
    begin
      if adsWoInfo.FieldByName('Parent_ptr').AsInteger >0 then //�ڲ��Ʒ
        sqlstr:= ' Update data0006 set prod_status = 6 where rKey='+dmcon.adsWOInfo.FieldbyName('rKey06').Asstring
      else                                            //����Ʒ
        sqlstr:= ' Update data0006 set prod_status = 5 where rKey='+dmcon.adsWOInfo.FieldbyName('rKey06').Asstring;
      result := myDataClass.ExecSql(sqlstr);
      if not result then
      begin
        ShowMsg('������ҵ��״̬ʧ��!',1);
        exit;
      end;
    end;
  end;
end;

procedure TfrmMain.PopupMenu1Popup(Sender: TObject);
begin
 with dmcon do
 begin
  if dsFlowList.DataSet=adsFlowList then
    begin
     if adsFlowList.isempty then exit;
     if trim(adsFlowList.Fieldbyname('BARCODE_ENTRY_FLAG').Asstring)<>'Y' then
     begin
      N1.Enabled := false;
      N2.Enabled := false;
     end
     else
     begin
      N1.Enabled := ADs0056.Fieldbyname('step').asinteger=adsFlowList.Fieldbyname('step_number').asinteger ;
      N2.Enabled := ADs0056.Fieldbyname('step').asinteger<adsFlowList.Fieldbyname('step_number').asinteger ;
     end;
    end
  else
  begin
   if ads238FlowList.isempty then exit;
   if trim(ads238FlowList.Fieldbyname('BARCODE_ENTRY_FLAG').Asstring)<>'Y' then
   begin
    N1.Enabled := false;
    N2.Enabled := false;
   end
   else
   begin
    N1.Enabled := ADs0056.Fieldbyname('step').asinteger=ads238FlowList.Fieldbyname('step_number').asinteger ;
    N2.Enabled := ADs0056.Fieldbyname('step').asinteger<ads238FlowList.Fieldbyname('step_number').asinteger ;
   end;
  end;
 end;
end;

procedure TfrmMain.N2Click(Sender: TObject);
var
  OrgStep:integer;
  LNowStep: Integer;
  LMoveToStep: Integer;
  I,J: Integer;
  LChar: Char;
  LFrm: TfrmWO_Count;
begin
  if dmcon.aqBasicParam.FieldByName('ppc_control23').AsInteger = 1 then //�ƹ�����
  if not Msg_Dlg_Ask('�ƶ������޷�����Ա��������,ȷ��������?','��ʾ',1) then exit;
  FBGoON := True;
  LNowStep := dmcon.ADs0056.Fieldbyname('step').asinteger;
  with dmcon.tmp do
  begin
    close;
    sql.Clear;
    sql.Add('select * from data0238 inner join data0006');
    sql.Add('on data0238.wo_ptr=data0006.rkey');
    sql.Add('where data0006.work_order_number='+quotedstr(edtWoNo.Text));
    Open;
  end;
  if dmcon.tmp.IsEmpty then
  begin
    LMoveToStep := dmcon.adsFlowList.Fieldbyname('step_number').asinteger;
    J:=0;
  end
  else
  begin
    LMoveToStep := dmcon.ads238FlowList.Fieldbyname('step_number').asinteger;
    J:=1;
  end;
  LChar := #13;
  if J=0 then
  begin
   for I := LNowStep to LMoveToStep do
   begin
    if dmcon.adsWOInfo.FieldByName('step').Value<=LMoveToStep then
    begin
    edtWoNoKeyPress(Self,LChar);
    if not FBGoON then Break;
    if trim(dmcon.adsFlowList.Fieldbyname('BARCODE_ENTRY_FLAG').Asstring)<>'Y' then Continue;
    LFrm := TfrmWO_Count.Create(Application);
    try
      LFrm.enter(False);
      LFrm.btnOkClick(Self);
    finally
      LFrm.Free;
    end;
     MyDataclass.OpenDataSetByPara(edtWoNo.Text,dmcon.adsWOInfo);
    end
    else
    Exit;
   end;
  end
  else
  begin
   for I := LNowStep to LMoveToStep do
   begin
    if dmcon.adsWOInfo.FieldByName('step').Value<=LMoveToStep then
    begin
    edtWoNoKeyPress(Self,LChar);
    if not FBGoON then Break;
    if trim(dmcon.ads238FlowList.Fieldbyname('BARCODE_ENTRY_FLAGr').Asstring)<>'Y' then Continue;
    LFrm := TfrmWO_Count.Create(Application);
    try
      LFrm.enter(False);
      LFrm.btnOkClick(Self);
    finally
      LFrm.Free;
    end;
     MyDataclass.OpenDataSetByPara(edtWoNo.Text,dmcon.adsWOInfo);
    end
    else
    Exit;
   end;
  end;
end;

procedure TfrmMain.N1Click(Sender: TObject);
var
  tmpstr:string;
begin
  tmpstr:=DBEdit1.Text;
  if not dmcon.Check_WO(edtWoNo.Text) then Exit;
  //if not dmcon.Check_WO_Son(edtWoNo.Text) then Exit;//�ж���ҵ���Ƿ����ӹ������ڵȴ�״̬���еĻ��Ͳ��������
  with TfrmWO_Count.Create(Application)do
  try
    enter;
  finally
    free;
  end;
  MyDataclass.OpenDataSetByPara(tmpstr,dmcon.adsWOInfo);
end;

procedure TfrmMain.MoveToNextDept;
var
  str_Flag:string;
begin
  with dmcon do begin
    aqNextStepNO.Close;
    aqNextStepNO.Parameters.ParamByName('F01').Value :=adsWOInfo.fieldByname('Bom_ptr').Value;
    aqNextStepNO.Parameters.ParamByName('F02').Value :=dmcon.adsFlowList.FieldByName('STEP_NUMBER').AsInteger;
    aqNextStepNO.open;
    if aqNextStepNO.IsEmpty then //��������һ������,��ô����Ҫ���ض�λ����һ���Ĺ�������.
    begin
    //  dmcon.adsFlowList.prior;
    end
    else
    begin
    //�ƶ���¼����һ��������¼֮ǰһ����¼,
      if dmcon.adsFlowList.Eof then exit;
      dmcon.adsFlowList.next;
      while not dmcon.adsFlowList.eof do begin
        str_Flag := trim(dmcon.adsFlowList.fieldbyName('BARCODE_ENTRY_FLAG').Asstring);
        if str_Flag ='Y' then
        begin
          dmcon.adsFlowList.Prior;
          break;
        end;
        dmcon.adsFlowList.next;
      end;
    end;
  end;
end;

procedure TfrmMain.btnExitClick(Sender: TObject);
begin
  close;
end;

procedure TfrmMain.SpeedButton1Click(Sender: TObject);
var
  tmp_str:string;
  Key:char;
begin
  tmp_str:= Pick_Work_Order(edtWoNo.Text,dmcon.ADOConnection1,2);
  if tmp_str <> '' then
  begin
    Key:=#13;
    edtWoNo.Text := tmp_str;
    edtWoNoKeyPress(sender,Key);
  end;
end;

end.
