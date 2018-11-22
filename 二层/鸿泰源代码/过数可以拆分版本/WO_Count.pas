unit WO_Count;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Menus, StdCtrls, Mask, DBCtrls, Buttons, Grids,math,StrUtils,
  DBGrids,AdoDB, ppComm, ppRelatv, ppProd, ppClass, ppReport, DBGridEh, DB,
  ComCtrls;

type
  TfrmWO_Count = class(TForm)
    Panel1: TPanel;
    Label15: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label12: TLabel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    Panel2: TPanel;
    SpeedButton2: TSpeedButton;
    Label14: TLabel;
    Label8: TLabel;
    DBEdit9: TDBEdit;
    DBEdit10: TDBEdit;
    Label4: TLabel;
    DBEdit11: TDBEdit;
    Label1: TLabel;
    DBEdit6: TDBEdit;
    Label2: TLabel;
    Label3: TLabel;
    EdtPNL: TDBEdit;
    EdtPcs: TDBEdit;
    rgType: TRadioGroup;
    btnOk: TBitBtn;
    Label11: TLabel;
    DBEdit12: TDBEdit;
    Label13: TLabel;
    DBEdit13: TDBEdit;
    Label16: TLabel;
    ComboBox1: TComboBox;
    GroupBox2: TGroupBox;
    edtNewPCS: TEdit;
    Label17: TLabel;
    edtNewPNL: TEdit;
    CheckBox3: TCheckBox;
    edtDiscardQty: TDBEdit;
    Label19: TLabel;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    Label10: TLabel;
    Label18: TLabel;
    ComboBox2: TComboBox;
    Label20: TLabel;
    ComboBox3: TComboBox;
    Label21: TLabel;
    Label22: TLabel;
    lv1: TListView;
    CheckBox4: TCheckBox;
    procedure SpeedButton2Click(Sender: TObject);
    procedure btnOkClick(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure edtNewPCSKeyPress(Sender: TObject; var Key: Char);
    procedure edtNewPCSExit(Sender: TObject);
    procedure edtNewPNLExit(Sender: TObject);
    procedure lv1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure lv1SelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure lv1Exit(Sender: TObject);
    procedure CheckBox4Click(Sender: TObject);

  private
    //FType:integer;
    v_Pcs,v_PNL:integer;
    PCS_PER_PNL:integer;
    r_type,clamp06:Integer;
    sNWkNo:string;
    function Update_Data(rkey06:integer):boolean;
    function Update_0048(From_Dept,Next_Dept,UserId,WType,PutType,Wo_ptr,StepNo,rkey25:Integer):boolean;
    function Update_0048_2(From_Dept,Next_Dept,UserId,WType,PutType,Wo_ptr,StepNo:integer):boolean;
    //function Update_0041(rkey06:integer):boolean; //����Ա��������
    function savAlid:boolean;
    procedure Update_WIPMAT_STATUS(rKey06: Integer);
  public
    FaFct:array of integer;
    procedure enter(rKey_User:integer;WoNo:string);
    function Get_Max_Number(strWoNO:String):string;
    function WoClamp(rkey06,clamp06:Integer):boolean;//�ϲ���ҵ��
    function check_woclamp(rkey06,clamp06:Integer):boolean;//�ж��Ƿ���ԺϿ�
    function INQCLocked(ARkey06,ARkey34,AQty: Integer): Boolean;//�Ƿ���QC�ܿ���
    function INSPCLocked(ARkey06,ARkey34: Integer;var ErrStr: string): Boolean;//�Ƿ���SPC�ܿ���

  end;

var
  frmWO_Count: TfrmWO_Count;

implementation
uses dm,MyClass,common,Dlg_Wo_Qty,report_data;
{$R *.dfm}

procedure TfrmWO_Count.enter(rKey_User: integer;WoNo:string);
var
  FX:char;
    tmpstr:string;
    i,L:integer;
    //b:boolean;
    Item: TListItem;
    select_number: string;
begin
  if not dmcon.Check_WO(WoNo) then  abort; //�ж���ҵ���Ƿ��������л����ⷢ����״̬,�����������
//  if not dmcon.Check_WO_Son(WoNo) then Abort;//�ж���ҵ���Ƿ����ӹ������ڵȴ�״̬���еĻ��Ͳ��������
  MyDataClass.OpenDataSetByPara(WoNo,dmcon.adsWOInfo); //����ҵ��
  //����һ�������
//  if not dmcon.Check_User_Factory(rKey_User,dmcon.adsWOInfo.FieldByName('rkey06').AsInteger) then
//  begin
//    ShowMsg('������Ա�����幤���뵱ǰ��ҵ���Ĺ�����һ��,���������!',1);
//    abort;
//  end;
  if not dmcon.Check_User_Auth(rKey_User,WoNo) then   //(ֻ�ǶԵ��й������)�жϹ�����Ա�Ƿ���Ȩ�޶Ե�ǰ��ҵ��������
  begin
    ShowMsg('��û�е�ǰ����Ĺ���Ȩ��,����ϵϵͳ����Ա!',1);
    abort;
  end;
  if dmcon.adsWOInfo.fieldByname('SETUP_TIME_PER_LOT').AsString<>'' then
    ComboBox3.Items.Append(dmcon.adsWOInfo.fieldByname('SETUP_TIME_PER_LOT').AsString);
  if dmcon.adsWOInfo.fieldByname('QUEUE_TIME').AsString<>'' then
    ComboBox3.Items.Append(dmcon.adsWOInfo.fieldByname('QUEUE_TIME').AsString);
  if dmcon.adsWOInfo.fieldByname('PROCESS_TIME').AsString<>'' then
    ComboBox3.Items.Append(dmcon.adsWOInfo.fieldByname('PROCESS_TIME').AsString);
  if dmcon.adsWOInfo.fieldByname('PROCESS_TIME_B').AsString<>'' then
    ComboBox3.Items.Append(dmcon.adsWOInfo.fieldByname('PROCESS_TIME_B').AsString);
  if ComboBox3.Items.Count>0 then ComboBox3.ItemIndex:=-1;
  with dmcon.ADOQuery1 do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select * from data0238 where wo_ptr='+dmcon.adsWOInfo.FieldByName('rkey06').AsString);
    Open;
  end;
  if (not dmcon.ADOQuery1.IsEmpty) and (dmcon.adsWOInfo.FieldByName('Wtype06').Value=3)and(dmcon.adsWOInfo.FieldByName('wtype').AsInteger>0) then //��ҵ��Ϊ����״̬�ҷ�����û����
  begin //�߷�������238
   rgType.ItemIndex:=1;
   rgType.Enabled:=False;
   dmcon.NextStep_238.Close;
   dmcon.NextStep_238.Parameters.ParamByName('F01').Value :=dmcon.adsWOInfo.fieldByname('rkey06').Value;
   dmcon.NextStep_238.Parameters.ParamByName('F02').Value :=dmcon.adsWOInfo.fieldByname('STEP').Value;
   dmcon.NextStep_238.Open;
   GroupBox2.Caption:='�¹��� ��'+trim(dmcon.NextStep_238.fieldByName('DEPT_CODE').AsString)+'-'+trim(dmcon.NextStep_238.fieldByName('DEPT_NAME').AsString)+'-'+trim(dmcon.NextStep_238.fieldByName('STEP_NUMBER').AsString);
  end
  else
  begin //����������38
   with dmcon.ADOQuery1 do
   begin
     Close;
     SQL.Clear;
     sql.Add('select DEPT_PTR from data0038 where SOURCE_PTR='+dmcon.adsWOInfo.fieldByname('Bom_ptr').AsString);
     sql.Add('and STEP_NUMBER='+dmcon.adsWOInfo.fieldByname('STEP').AsString);
     Open;
   end;
   if dmcon.ADOQuery1.FieldByName('dept_ptr').Value<>dmcon.adsWOInfo.FieldByName('DEPT_PTR').Value then
   begin
    MessageDlg('��ǰ�����跢���仯,��Ʒ�����иĶ�,���ܹ���!',mtInformation,[mbOK],1);
    Exit;
   end;
   dmcon.aqNextStepNO.Close;
   dmcon.aqNextStepNO.Parameters.ParamByName('F01').Value :=dmcon.adsWOInfo.fieldByname('Bom_ptr').Value;
   dmcon.aqNextStepNO.Parameters.ParamByName('F02').Value :=dmcon.adsWOInfo.fieldByname('STEP').Value;
   dmcon.aqNextStepNO.open;
   GroupBox2.Caption:='�¹��� ��'+trim(dmcon.aqNextStepNO.fieldByName('DEPT_CODE').AsString)+'-'+trim(dmcon.aqNextStepNO.fieldByName('DEPT_NAME').AsString)+'-'+trim(dmcon.aqNextStepNO.fieldByName('STEP_NUMBER').AsString);
  end;
//��ʾ
  checkbox2.Checked:=not dmcon.adsWOInfo.fieldByName('ALLOW_SPLIT_LOTS').IsNull and
                        (dmcon.adsWOInfo.fieldByName('ALLOW_SPLIT_LOTS').AsString='Y');  //PNL��0
                        
  if  not checkbox2.Checked then checkbox2.Enabled:=false;

  v_Pcs:= dmcon.adsWOInfo.fieldByname('QTY_BACKLOG').Asinteger;
  v_PNL:= dmcon.adsWOInfo.fieldByname('PANELS').Asinteger;
  if (dmcon.adsWOInfo.FieldByName('prod_status').AsInteger = 4)  then //�ⷢ����
    rgType.ItemIndex :=2;
  if (dmcon.adsWOInfo.FieldByName('TType').AsInteger=3) or (dmcon.adsWOInfo.FieldByName('WType').AsInteger >0) then //MRB����,��ô���ڷ���״̬
    rgType.ItemIndex :=1;        //��������

  dmcon.tmp.Close;
  dmcon.tmp.SQL.Text:='select rkey,abbr_name from data0015 where active_flag='+quotedstr('Y')+' order by rkey';
  dmcon.tmp.Open;
  SetLength(fafct,dmcon.tmp.RecordCount);

  for i:=0 to dmcon.tmp.RecordCount-1 do
  begin
    FaFct[i]:=dmcon.tmp.Fields[0].AsInteger;
    ComboBox1.Items.Append(dmcon.tmp.Fields[1].asstring);
    ComboBox2.Items.Append(dmcon.tmp.Fields[1].asstring);
    dmcon.tmp.Next;
  end;

  dmcon.tmp.Close;
  dmcon.tmp.SQL.Text:='select data0056.loc_ptr,data0015.abbr_name from data0056 inner join data0015'+
  ' on data0056.loc_ptr=data0015.rkey'+
  ' where data0056.Wo_ptr='+dmcon.adsWOInfo.FieldbyName('rKey06').Asstring;
  dmcon.tmp.Open;

  ComboBox1.ItemIndex:=ComboBox1.Items.IndexOf(dmcon.tmp.FieldByName('abbr_name').AsString);

  if dmcon.adsUserInfo.FieldByName('warehouse_ptr').AsInteger > 0 then
  for i:=Low(fafct) to High(fafct) do    //���������Ա�����˹���
   begin
    if FaFct[i]=dmcon.adsUserInfo.FieldByName('warehouse_ptr').AsInteger then
     ComboBox2.ItemIndex:=i  ;//�¹�����������
   end
  else
  for i:=Low(fafct) to High(fafct) do
   begin
    //if FaFct[i]=dmcon.tmp.Fields[0].AsInteger then
      //ComboBox1.ItemIndex:=i  ;//��������
    if FaFct[i]=dmcon.adsWOInfo.FieldbyName('whouse_ptr').AsInteger then
     ComboBox2.ItemIndex:=i  ;//�¹���Ͷ������
   end;
  combobox1.Enabled:=false;
  edtNewPCS.Text:=EdtPcs.Text;
  edtNewPNL.Text:=EdtPNL.Text;

  tmpstr:=trim(DBEdit1.Text);
  //c:=s[length(S)];

  begin
    dmcon.tmp.Close;
    dmcon.tmp.SQL.Text:='select 1  from data0034 where PERMIT_SPLIT_LOT=1 and rKey= '+dmcon.adsWOInfo.FieldByName('Dept_ptr').Asstring;
    dmcon.tmp.Open;
    if dmcon.tmp.IsEmpty then
    begin

      edtNewPCS.Enabled:=false;
      edtNewPNL.Enabled:=false;
      CheckBox3.Enabled:=false;
      edtNewPCS.Color:=clGray;
      edtNewPNL.Color:=clGray;

    end else
    begin
       FX:=UpCase(tmpstr[length(tmpstr)]);
       if FX in ['A'..'Z'] then //˵�������Ѿ���ֹ���
        select_number := copy(tmpstr,1,length(tmpstr)-1)
       else
        select_number := tmpstr;

        tmpstr:=Get_Max_Number(select_number);  //�õ���ǰ������ҵ�����
        FX:=UpCase(tmpstr[length(tmpstr)]);

        if FX in ['A'..'Y'] then
          sNWkNo := Copy(tmpstr,1,Length(tmpstr)-1)+succ(FX) //ͨ����ĸ��ASCII������,���ı�A,B,C��ֵ
        else             //��������ҵ�������һλ��'Z',����������,�������ҵ�������ĸ:A
          sNWkNo := tmpstr + 'A';
    end;

  end;




  PCS_PER_PNL:=dmcon.adsWOInfo.fieldbyname('PARTS_PER_PANEL').AsInteger;
  CheckBox1.Enabled:= dmcon.adsUserInfo.fieldByName('OutSource').AsBoolean;
  checkbox1.Checked:=CheckBox1.Enabled;
  r_type:=0;//��������(�޺ϲ�����)
  if (dmcon.adsWOInfo.FieldByName('cutno_wo').Value='') or (dmcon.adsWOInfo.FieldByName('parent_ptr').Value>0) then//�Ͽ������ж�(�ڲ㹤��������㹤���޿�ӡ����)
  begin
   L:=Length(WoNo);
   with dmcon.WoClampIn do
   begin
    Close;
    if (dmcon.adsWOInfo.FieldByName('Wtype06').Value=3)and(dmcon.adsWOInfo.FieldByName('wtype').AsInteger>0) then //��ҵ��Ϊ����״̬�ҷ�����û����
    begin
     with dmcon.tmp do
     begin
      Close;
      sql.Clear;
      SQL.Add('select max(step_number) as mstep from data0238 ');
      sql.Add('where data0238.wo_ptr='+dmcon.adsWOInfo.FieldbyName('rKey06').AsString);
      Open;
     end;
     if dmcon.NextStep_238.FieldByName('step_number').Value=dmcon.tmp.FieldByName('mstep').Value then //����Ϊ���һ������ʱ������ᷢ���仯
      Parameters[0].Value:=dmcon.adsWOInfo.FieldValues['wtype']
     else
      Parameters[0].Value:=dmcon.NextStep_238.FieldValues['step_number'];
    end
    else
    begin
     Parameters[0].Value:=dmcon.aqNextStepNO.FieldValues['step_number'];
    end;
    Open;
    if (WoNo[L] in ['0'..'9']) then
    begin
     //dmcon.WoClampIn.SQL.Text:=dmcon.WoClampIn.SQL.Text+'and data0006.work_order_number'+' like ''%'+LeftStr(WoNo, L)+'%''';
     dmcon.WoClampIn.Filter:='work_order_number'+' like ''%'+LeftStr(WoNo, L)+'%''';
    end
    else
    begin
     dmcon.WoClampIn.Filter:='work_order_number'+' like ''%'+LeftStr(WoNo, L-1)+'%''';
    end;
    if not dmcon.WoClampIn.IsEmpty then
    begin
     dmcon.WoClampIn.First;
     if (dmcon.WoClampInPROD_STATUS.Value=5) or (dmcon.WoClampInPROD_STATUS.Value=6) then
     begin
     CheckBox4.Enabled:=True;
     CheckBox4.Checked:=false;
     end
     else
     begin
     CheckBox4.Enabled:=True;
     CheckBox4.Checked:=false;
     end;
     r_type:=1;
     for i:=1 to dmcon.WoClampIn.RecordCount do
     begin
     item:=lv1.Items.Add;
     Item.SubItems.Add(dmcon.WoClampInWORK_ORDER_NUMBER.Value);
     Item.SubItems.Add(dmcon.WoClampInCUTNO_WO.Value);
     Item.SubItems.Add(dmcon.WoClampInQTY_BACKLOG.AsString);
     Item.SubItems.Add(dmcon.WoClampInPANELS.AsString);
     Item.SubItems.Add(dmcon.WoClampInSTEP.AsString);
     Item.SubItems.Add(dmcon.WoClampInrkey06.AsString);
     dmcon.WoClampIn.Next;
     end;
    end;
   end;
  end
  else
  begin
   with dmcon.WoClamp do //��ӡ���ݲ�Ϊ�վ͵ø��ݿ�ӡ�����ǽ����ж���
   begin
   Close;
   Parameters[0].Value:=dmcon.adsWOInfo.FieldValues['cutno_wo'];
    if (dmcon.adsWOInfo.FieldByName('Wtype06').Value=3)and(dmcon.adsWOInfo.FieldByName('wtype').AsInteger>0) then //��ҵ��Ϊ����״̬�ҷ�����û����
    begin
     with dmcon.tmp do
     begin
      Close;
      sql.Clear;
      SQL.Add('select max(step_number) as mstep from data0238 ');
      sql.Add('where data0238.wo_ptr='+dmcon.adsWOInfo.FieldbyName('rKey06').AsString);
      Open;
     end;
     if dmcon.NextStep_238.FieldByName('step_number').Value=dmcon.tmp.FieldByName('mstep').Value then //����Ϊ���һ������ʱ������ᷢ���仯
      Parameters[1].Value:=dmcon.adsWOInfo.FieldValues['wtype']
     else
      Parameters[1].Value:=dmcon.NextStep_238.FieldValues['step_number'];
    end
    else
    begin
     Parameters[1].Value:=dmcon.aqNextStepNO.FieldValues['step_number'];
    end;
    Open;
   end;
   if not dmcon.WoClamp.IsEmpty then
   begin
     dmcon.WoClamp.First;
     if (dmcon.WoClampPROD_STATUS.Value=5) or (dmcon.WoClampPROD_STATUS.Value=6) then
     begin
     CheckBox4.Enabled:=True;
     CheckBox4.Checked:=false;
     end
     else
     begin
     CheckBox4.Enabled:=True;
     CheckBox4.Checked:=False;//Ĭ�϶����Ͽ��ɹ���Ա�Լ�ѡ�����
     end;
    r_type:=1;
    for i:=1 to dmcon.WoClamp.RecordCount do
    begin
     item:=lv1.Items.Add;
     Item.SubItems.Add(dmcon.WoClampWORK_ORDER_NUMBER.Value);
     Item.SubItems.Add(dmcon.WoClampCUTNO_WO.Value);
     Item.SubItems.Add(dmcon.WoClampQTY_BACKLOG.AsString);
     Item.SubItems.Add(dmcon.WoClampPANELS.AsString);
     Item.SubItems.Add(dmcon.WoClampSTEP.AsString);
     Item.SubItems.Add(dmcon.WoClamprkey06.AsString);
     dmcon.WoClamp.Next;
    end;
   end;
  end;
  lv1.Enabled:=CheckBox4.Checked;
  ShowModal;
end;

procedure TfrmWO_Count.SpeedButton2Click(Sender: TObject);
begin
  close;
end;

procedure TfrmWO_Count.btnOkClick(Sender: TObject);
var
 sql_text:string;
 rkey06:integer;
 i:Integer;
 lsresult:Boolean;
 LErrStr: string;
begin
  //*****************
  //*���������ܿأ�chengtx����
  if INQCLocked(dmcon.adsWOInfo.FieldbyName('rKey06').AsInteger,dmcon.adsWoInfo.fieldbyName('dept_ptr').AsInteger,dmcon.adsWoInfo.fieldbyName('QTY_BACKLOG').AsInteger) then
  begin
    ShowMessage('�Ĺ����յ�Ʒ�ʲ��Źܿأ���ֹ��ת������ϵƷ�ʲ���');
    Exit;
  end;
  //*****************


  //*****************
  //*SPC�ܿأ�chengtx����
  if INSPCLocked(dmcon.adsWOInfo.FieldbyName('rKey06').AsInteger,dmcon.adsWoInfo.fieldbyName('dept_ptr').AsInteger,LErrStr) then
  begin
    ShowMessage(LErrStr + ' SPC�����Ϣ�ܹܿأ�����ϵSPC Ʒ�ʲ���');
    Exit;
  end;
  //*****************


  if IS_Stock_Inventorying then
  begin
   ShowMsg('����Ʒ�����̵㣬���ܹ��������飡',1);
   Exit;
  end;
  rkey06:=dmcon.adsWOInfo.FieldbyName('rKey06').AsInteger;
  lsresult:=True;
  if (ComboBox3.Items.Count>0) and (trim(ComboBox3.Text)='') then
  begin
    ShowMsg('����ѡ��������߻��豸!',1);
    ComboBox3.SetFocus;
    exit;
  end;
  sql_text:='select step from data0056 where rkey='+dmcon.adsWOInfo.FieldByName('rkey').AsString;
  OpenQuery(dmcon.aqTmp,sql_text);

  if dmcon.aqTmp.FieldByName('step').AsInteger<>dmcon.adsWOInfo.FieldByName('step').AsInteger then
  begin
    ShowMsg('��������ҵ����ǰ�����Ѿ�����ȷ,���������Ѿ�����!',1);
    exit;
  end;
  with dmcon.ADOQuery1 do
  begin
    Close;
    sql.Clear;
    sql.Add('select * from data0238 where wo_ptr='+dmcon.adsWOInfo.FieldByName('rkey06').AsString);
    Open;
  end;
  if dmcon.ADOQuery1.IsEmpty then
  begin
  sql_text:='select DEPT_PTR from data0038 where SOURCE_PTR='+dmcon.adsWOInfo.fieldByname('Bom_ptr').AsString+
            'and STEP_NUMBER='+dmcon.adsWOInfo.fieldByname('STEP').AsString;
  OpenQuery(dmcon.aqTmp,sql_text);
   if dmcon.aqTmp.FieldByName('dept_ptr').Value<>dmcon.adsWOInfo.FieldByName('dept_ptr').Value then
   begin
    MessageDlg('��ǰ�����跢���仯,��Ʒ�����иĶ�,���ܹ���!',mtInformation,[mbOK],1);
    Exit;
   end;
  end;

  sql_text:='select prod_status from data0006 where rkey='+dmcon.adsWOInfo.FieldbyName('rKey06').AsString;
  OpenQuery(dmcon.aqTmp,sql_text);

  if dmcon.aqTmp.FieldByName('prod_status').AsInteger in [102,103] then
  begin
    ShowMsg('��������ҵ�����ݻ�!',1);
    exit;
  end;

  sql_text:='select wipmat_status from data0006 where rkey='+dmcon.adsWOInfo.FieldbyName('rKey06').AsString;
  OpenQuery(dmcon.aqTmp,sql_text);
  
  if dmcon.aqTmp.FieldByName('WIPMAT_STATUS').AsInteger=0 then
  begin
   ShowMsg('��������ҵ����û������,���ܹ���!',1);
   exit;
  end;
  if (r_type=1) and (CheckBox4.Checked) then //�кϿ�����Ҫ�ж��Ƿ�ѡ����һ���������кϿ�
  begin
   for i:=0 to lv1.Items.Count-1 do
   begin
     if lv1.Items[I].Checked = true then
     begin
       clamp06:=StrToInt(lv1.Selected.SubItems.Strings[5]);//��ȡ�Ͽ�ĸ����rkeyֵ
       lsresult:=True;
       Break;
     end
     else
     begin
       lsresult:=False;
     end;
   end;
  end;
  if lsresult=False then
  begin
    MessageDlg('��ѡ��һ�������Ͽ���',mtInformation,[mbOK],1);
    Exit;
  end;
//  if dmcon.aqBasicParam.FieldByName('ppc_control23').AsInteger = 1 then //�ƹ�����
//  if not dmcon.adsEmployee.IsEmpty then
//  begin
//    if v_Pcs=dmcon.adsWOInfo.FieldByName('QTY_BACKLOG').AsInteger then
//      if not Msg_Dlg_Ask('����û�з���,ȷ����������!','��ʾ',1) then  exit;
//    if v_Pcs <> dmcon.adsWOInfo.FieldByName('QTY_BACKLOG').AsInteger then
//      if v_PNL>0 then
//      begin
//        ShowMsg('����û�з�����,��ȷ��!',1);
//        exit;
//      end;
//  end;
  try
    if not dmcon.ADOConnection1.InTransaction then
      dmcon.ADOConnection1.BeginTrans;

    if edtNewPCS.Text=EdtPcs.Text then
      rkey06:=dmcon.adsWOInfo.FieldbyName('rKey06').AsInteger
    else
    if savAlid then
    begin  //���
      dmcon.aspWO_Split.Parameters.ParamByName('@OrgRkey').Value :=dmcon.adsWOInfo.FieldbyName('rKey06').AsInteger;
      dmcon.aspWO_Split.Parameters.ParamByName('@WONO').Value :=sNWkNo;
      dmcon.aspWO_Split.Parameters.ParamByName('@PCS').Value :=strtoint(EdtPcs.Text) - strtoint(edtNewPCS.Text);
      dmcon.aspWO_Split.Parameters.ParamByName('@PNL').Value :=strtoint('0'+edtpnl.Text) - strtoint('0'+edtNewPNL.Text);
      dmcon.aspWO_Split.Parameters.ParamByName('@User_ptr').Value :=dmcon.adsUserInfo.fieldbyName('empl_ptr').Asinteger;
      dmcon.aspWO_Split.Parameters.ParamByName('@Remark').Value :='�������'+edtNewPCS.Text+'PCS';
      dmcon.aspWO_Split.Parameters.ParamByName('@type').Value := 1;
      dmcon.aspWO_Split.Parameters.ParamByName('@NeedTrans').Value :=0;
      dmcon.aspWO_Split.ExecProc;
      if dmcon.aspWO_Split.Parameters.ParamByName('@RETURN_VALUE').Value=0 then
      begin
//        dmcon.tmp.Close;
//        dmcon.tmp.SQL.Text:='select rkey from data0006 where work_order_number='''+sNWkNo+'''';
//        dmcon.tmp.Open;
//        rkey06:=dmcon.tmp.Fields[0].AsInteger;
      end else begin
        if dmcon.ADOConnection1.InTransaction then dmcon.ADOConnection1.RollbackTrans;
        showmessage('��ҵ����ֲ��ɹ�,����ʧ��...');
        modalresult:=mrok;
        exit;
      end;
    end
    else
      exit;
   if Update_Data(rkey06) then  //����
    begin
    
      dmcon.ADOConnection1.CommitTrans ;
      if (edtNewPCS.Text<>EdtPcs.Text) and not CheckBox3.Checked then showmessage('��ֹ����ɹ�,�²�������ҵ����Ϊ��'+sNWkNo);
      if  CheckBox3.Checked then
      with  TForm_report.Create(nil) do
      try
        ADS25.Parameters[0].Value:=dmcon.adsWOInfo.fieldbyname('bom_ptr').AsInteger;
        ADS25.Open;
        ADS06.Parameters[0].Value:=rkey06;
        ADS06.Open;
        ppReport1.Print;
      finally
        free;
      end;
    end
   else
      dmcon.ADOConnection1.RollbackTrans;
  except
    on E: Exception do
    begin
     dmcon.ADOConnection1.RollbackTrans;
     messagedlg(E.Message,mterror,[mbcancel],0);
    end;
  end;
  //����Ʒ����ϢERP��ʾ
  dmcon.adsWOInfo.Close;
  dmcon.adsWOInfo.Open;
  with dmcon.ADOQuery1 do
  begin
    Close;
    sql.Clear;
    sql.Add('select data0073.rkey from data0245 inner join data0005 on data0245.user_ptr=data0005.rkey');
    sql.Add('inner join data0073 on data0073.employee_ptr=data0005.rkey');
    sql.Add('where data0245.dept_ptr='+dmcon.adsWOInfo.fieldbyname('DEPT_PTR').AsString);
    Open;
  end;
  dmcon.ADO101.Close;
  dmcon.ADO101.Parameters[0].Value:=dmcon.adsWOInfo.fieldbyname('DEPT_PTR').Value;
  dmcon.ADO101.Parameters[1].Value:=dmcon.adsWOInfo.fieldbyname('bom_ptr').Value;
  dmcon.ADO101.Open;
  if (not dmcon.ADOQuery1.IsEmpty) and (dmcon.ADO101names_value.Value<>'') then
  begin
    with dmcon.ADOQuery3 do
    begin
     Close;
     sql.Clear;
     SQL.Add('select data0073.rkey from data0073 inner join data0005');
     sql.Add('on data0073.employee_ptr=data0005.rkey where data0005.rkey='+dmcon.adsUserInfo.fieldbyname('empl_ptr').AsString);
     Open;
    end;
    dmcon.ADO014.Close;
    dmcon.ADO014.Open;
    dmcon.ADO014.Append;
    dmcon.ADO014MESSAGE.Value:=dmcon.ADO101names_value.AsString;
    dmcon.ADO014whosend.Value:=dmcon.ADOQuery3.fieldbyname('rkey').AsInteger;
    dmcon.ADO014.Post;
    dmcon.ADOQuery1.First;
    while not dmcon.ADOQuery1.Eof  do
    begin
    dmcon.ADO314.Close;
    dmcon.ADO314.Open;
    dmcon.ADO314.Append;
    dmcon.ADO314d14_ptr.Value:=dmcon.ADO014rkey.Value;
    dmcon.ADO314emp_ptr.Value:=dmcon.ADOQuery1.fieldbyname('rkey').Value;
    dmcon.ADO314.Post;
    dmcon.ADOQuery1.MoveBy(1);
    end;
   with dmcon.ADOQuery1 do
   begin
    Close;
    sql.Add('update data0101 set if_send=1 from data0101 inner join data0118 on data0118.SOURCE_PTR=data0101.rkey');
    SQL.Add('where data0118.RESP_DEPT_PTR='+dmcon.adsWOInfo.fieldbyname('DEPT_PTR').AsString);
    SQL.Add('and data0101.CUSTOMER_PART_PTR='+dmcon.adsWOInfo.fieldbyname('bom_ptr').AsString);
    Open;
   end;
  end;
  //��ҵ���Ͽ�
  if (r_type=1) and (CheckBox4.Checked=true) then
  begin
   with dmcon.ADOQuery1 do
   begin
     Close;
     SQL.Clear;
     SQL.Add('select from_wo_ptr from data0006');
     SQL.Add('where rkey='+inttostr(clamp06));
     Open;
   end;
   with dmcon.ADOQuery2 do
   begin
     Close;
     SQL.Clear;
     sql.Add('select from_wo_ptr from data0006');
     sql.Add('where rkey='+inttostr(rkey06));
     Open;
   end;
   if (rkey06=dmcon.ADOQuery1.FieldByName('from_wo_ptr').Value) or (dmcon.ADOQuery2.IsEmpty) then
   begin
     with dmcon.ADOQuery2 do
     begin
       Close;
       sql.Clear;
       sql.Add('select * from data0056 where wo_ptr='+inttostr(clamp06));
       Open;
     end;
     with dmcon.ADOQuery3 do
     begin
       Close;
       sql.Clear;
       SQL.Add('select * from data0006 where rkey='+inttostr(clamp06));
       Open;
     end;
    if (dmcon.ADOQuery2.FieldByName('TO_BE_STOCKED').Value>0) or (dmcon.ADOQuery3.FieldByName('QUAN_PROD').Value>0) then
    begin
      MessageDlg('�����ӹ����д����������û��˻��в������깤,���ܺϿ�!',mtInformation,[mbOK],1);
      Close;
      Exit;
    end;
    if WoClamp(clamp06,rkey06) then
    begin
     with dmcon.ADOQuery1 do
     begin
      Close;
      sql.Clear;
      sql.Text:=' insert into data0117(Source_ptr,Source_Type,NOTEPAD_PTR,Empl_ptr,Tdate,Action,Remark) '+
          ' values ('+IntToStr(rkey06)+',2,0,'+dmcon.adsUserInfo.fieldbyName('empl_ptr').AsString+',getdate(),'+IntToStr(8)+','+QuotedStr('��ҵ��'+dmcon.adsWOInfo.FieldValues['work_order_number']+'����ҵ��'+lv1.Selected.SubItems.Strings[0]+'�ϲ�'+' '+'����Ϊ��'+edtpcs.Text)+')';
      ExecSQL;
     end;
     ShowMessage('�ϲ���ҵ���ɹ����ϲ������ҵ����Ϊ��'+dmcon.adsWOInfo.FieldValues['work_order_number']);
    end;
   end
   else
   begin
    if WoClamp(rkey06,clamp06) then
    begin
     with dmcon.ADOQuery1 do
     begin
      Close;
      sql.Clear;
      sql.Text:=' insert into data0117(Source_ptr,Source_Type,NOTEPAD_PTR,Empl_ptr,Tdate,Action,Remark) '+
          ' values ('+IntToStr(clamp06)+',2,0,'+dmcon.adsUserInfo.fieldbyName('empl_ptr').AsString+',getdate(),'+IntToStr(8)+','+QuotedStr('��ҵ��'+dmcon.adsWOInfo.FieldValues['work_order_number']+'����ҵ��'+lv1.Selected.SubItems.Strings[0]+'�ϲ�'+' '+'����Ϊ��'+edtpcs.Text)+')';
      ExecSQL;
     end;
     ShowMessage('�ϲ���ҵ���ɹ����ϲ������ҵ����Ϊ��'+lv1.Selected.SubItems.Strings[0]);
    end;
   end;
  end;
  modalresult:=mrok;
end;

function TfrmWO_Count.Update_Data(rkey06:integer): boolean;
var
  sqlstr,s:string;
  WType,PutType:Integer;
  FromDept,NextDept,rkey51,rkey54,jhzq:integer;
  jv:Extended;
  paigong:Boolean;
begin
  Result:=False;
  jhzq:=dmcon.adsWOInfo.FieldByName('��������').Value;
  if (dmcon.adsWOInfo.FieldByName('Wtype06').Value=3)and(dmcon.adsWOInfo.FieldByName('wtype').AsInteger>0) then //��������
  begin
   with dmcon do
   begin
    if rgType.ItemIndex=0 then
      wType:= 0
    else
    if rgType.ItemIndex=1 then
      wType:= 2
    else
      wType:=3;
    sqlstr:=' SELECT D34.rKey,D34.DEPT_CODE, D34.DEPT_NAME,D238.STEP_NUMBER'+
            ' FROM dbo.Data0238 D238 INNER JOIN dbo.Data0034 D34 ON D238.DEPT_PTR = D34.RKEY '+
            ' WHERE D238.wo_ptr='+adsWOInfo.fieldByname('rkey06').Asstring+' and D238.Step_Number>'+adsWOInfo.fieldByname('STEP').Asstring+
            ' and D238.Step_Number <= '+dmcon.NextStep_238.fieldByName('STEP_NUMBER').AsString+
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
      result := Update_0048_2(fromDept,nextDept,dmcon.adsUserInfo.fieldbyName('empl_ptr').Asinteger,wType,PutType,rkey06,aqTmp.fieldbyName('Step_Number').AsInteger-1);
      if not result then break;
      fromDept:=aqTmp.fieldbyName('rKey').AsInteger;
      aqTmp.Next;
    end;
    if not result then exit;
//2.��������56�� DEPT_PTR��Ϊ��һ������ָ��,STEP��Ϊ��һ�������,INTIME��Ϊ��ǰ�Ĺ���ʱ��,������ͣСʱ��Ҳ��0
    if CheckBox2.Checked then s:=',panels=0' else s:='';
    sqlstr:=' update data0056 set dept_ptr='+NextStep_238.fieldByName('rKey').AsString+
            ' ,Step='+NextStep_238.fieldByName('STEP_NUMBER').AsString+s+
            ' ,loc_ptr='+inttostr(FaFct[ComboBox2.ItemIndex])+ //��һ���򹤳�
            ' ,if_paigong=0,assign_cycle=0,assign_date=null,datevalue=0'+ //��ʼ���ɹ������Ϣ
            ' ,InTime=getdate(),if_message=0,flow_no=0 where Wo_ptr='+inttostr(rkey06);

    sqlstr:= sqlstr +' update Data0056'
           +' set Data0056.step=Data0056.wtype'  //�������������һ������ɷ������������뵽�������̹���
           +' FROM Data0006 INNER JOIN'
                 +' Data0056 ON Data0006.RKEY = Data0056.WO_PTR '
           +' WHERE ('+NextStep_238.fieldByName('STEP_NUMBER').AsString +' IN'
                     +' (SELECT MAX(step_number)'
                    +' FROM data0238 INNER JOIN'
                          +' data0034 ON data0238.dept_ptr = data0034.rkey'
                    +' WHERE data0238.wo_ptr = data0006.rkey AND'
                          +' data0034.barcode_entry_flag = ''Y'')) AND'
                          +' (Data0006.RKEY ='+ inttostr(rkey06)+')';
    result := MyDataClass.ExecSql(sqlstr);
    if not result then
    begin
      ShowMsg('����56��ʧ��!',1);
      exit;
    end;
    //56�����ɹ������Ϣ
     with ADOQuery1 do
     begin
      Close;
      SQL.Clear;
      sql.Add('select top 1 isnull(rkey,0) as rkey from data0051 where ' +inttostr(jhzq)+ '>minvalue and '+inttostr(jhzq)+'<=maxvalue');
      Open;
     end;
     if ADOQuery1.IsEmpty then
     rkey51:=0
     else
     rkey51:=dmcon.ADOQuery1.fieldbyname('rkey').Value;
    if rkey51>0 then
    begin
     with ADOQuery2 do
     begin
      Close;
      SQL.Clear;
      sql.Add('select top 1 isnull(rkey,0) as rkey ,isnull(dateValue,0) as datevalue from data0054 where dept_ptr='+NextStep_238.fieldByName('rKey').AsString);
      SQL.Add('and d051_ptr='+inttostr(rkey51));
      Open;
     end;
     if ADOQuery2.IsEmpty then
     begin
     rkey54:=0;
     jv:=0;
     end
     else
     begin
     rkey54:=ADOQuery2.fieldbyname('rkey').Value;
     jv:=ADOQuery2.fieldbyname('datevalue').Value;
     end;
     if rkey54>0 then
     begin
     sqlstr:=' update data0056 set if_paigong=1'+
            ' ,assign_cycle='+inttostr(jhzq)+
            ' ,assign_date=getdate()'+
            ' ,datevalue='+FloatToStr(jv)+' where Wo_ptr='+inttostr(rkey06);
      result := MyDataClass.ExecSql(sqlstr);
      if not result then
      begin
      ShowMsg('����56���ɹ���Ϣʧ��!',1);
      exit;
      end;
     end;
    end;
    //3.������ҵ��״̬
    if CheckBox1.Checked then//��һ���������ⷢ����ôҪ����ҵ��״̬��Ϊ�ⷢ״̬
      sqlstr:='update data0006 set prod_status=4 where rKey='+inttostr(rkey06)
    else                     //��һ���������ⷢ����ôҪ����ҵ��״̬��Ϊ����״̬
      sqlstr:='update data0006 set prod_status=3 where rKey='+inttostr(rkey06);
    result := myDataClass.ExecSql(sqlstr);
    if not result then
    begin
      ShowMsg('������ҵ��״̬ʧ��!',1);
      exit;
    end;
    with dmcon.tmp do
    begin
      Close;
      sql.Clear;
      SQL.Add('select max(step_number) as mstep from data0238 ');
      sql.Add('where data0238.wo_ptr='+inttostr(rkey06));
      Open;
    end;
    if NextStep_238.fieldByName('STEP_NUMBER').Value=dmcon.tmp.FieldByName('mstep').Value then//�ж��Ƿ񷵹��Ѿ�����
    begin
      with dmcon.ADOQuery1 do
      begin
       Close;
       sql.Clear;
       SQL.Add('select max(step_number) as mstep from data0038 inner join');
       SQL.Add('data0034 ON data0038.dept_ptr = data0034.rkey');
       sql.Add('WHERE data0038.source_ptr ='+adsWOInfo.fieldByName('bom_ptr').AsString+'AND');
       sql.Add('data0034.barcode_entry_flag = ''Y''');
       Open;
      end;
      if dmcon.ADOQuery1.FieldByName('mstep').Value=adsWOInfo.FieldByName('wtype').Value then //�ж��Ƿ�����һ��������
      begin
       if adsWoInfo.FieldByName('Parent_ptr').AsInteger >0 then //�ڲ��Ʒ
       begin
        with dmcon.ADOQuery2 do
        begin
         Close;
         SQL.Clear;
         sql.Text:='update data0006 set prod_status=6 where rkey='+inttostr(rkey06);
         ExecSQL;
        end;
       end
       else                                                     //����Ʒ
       begin
        with dmcon.ADOQuery3 do
        begin
         Close;
         SQL.Clear;
         sql.Text:='update data0006 set prod_status=5 where rkey='+IntToStr(rkey06);
         ExecSQL;
        end;
       end;
      end;
      with dmcon.tmp do
      begin
        Close;
        sql.Clear;
        sql.Text:='delete from data0238 where wo_ptr='+inttostr(rkey06);
        ExecSQL;
      end;
      with dmcon.tmp do
      begin
        Close;
        SQL.Clear;
        sql.Text:='update data0056 set wtype=0 where wo_ptr='+inttostr(rkey06);
        ExecSQL;
      end;
    end;
    //Update_WIPMAT_STATUS(rkey06);
   end;
  end
  else
  begin
  if dmcon.aqNextStepNO.IsEmpty then exit;//δ���ҵ���һ��,˵�������Ĺ���
//�ȴ���48,����56
//1.������Ʒ��ת��¼48,  �жϵ�ǰ�����������һ������֮���Ƿ���ڲ���Ҫ�����Ĺ���
//����У���ôÿ�����򶼲���һ��48�ļ�¼��
//�ж���ҵ��Ͷ��״̬,���ж����ϵ�492,���״̬����MRB����,������
   with dmcon do
   begin
    if rgType.ItemIndex=0 then
      wType:= 0
    else
    if rgType.ItemIndex=1 then
      wType:= 2
    else
      wType:=3;

    sqlstr:=' SELECT D34.rKey,D34.DEPT_CODE, D34.DEPT_NAME, D38.STEP_NUMBER '+
            ' FROM dbo.Data0038 D38 INNER JOIN dbo.Data0034 D34 ON D38.DEPT_PTR = D34.RKEY '+
            ' WHERE D38.Source_ptr='+adsWOInfo.fieldByname('Bom_ptr').Asstring+' and D38.Step_Number>'+adsWOInfo.fieldByname('STEP').Asstring+
            ' and D38.Step_Number <= '+aqNextStepNO.fieldByName('STEP_NUMBER').AsString+
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
      result := Update_0048(fromDept,nextDept,dmcon.adsUserInfo.fieldbyName('empl_ptr').Asinteger,wType,PutType,rkey06,aqTmp.fieldbyName('Step_Number').AsInteger-1,dmcon.adsWOInfo.FieldByName('BOM_PTR').Value);
      if not result then break;
      fromDept:=aqTmp.fieldbyName('rKey').AsInteger;
      aqTmp.Next;
    end;
    if not result then exit;
//2.��������56�� DEPT_PTR��Ϊ��һ������ָ��,STEP��Ϊ��һ�������,INTIME��Ϊ��ǰ�Ĺ���ʱ��
    if CheckBox2.Checked then s:=',panels=0' else s:='';
    sqlstr:=' update data0056 set dept_ptr='+aqNextStepNO.fieldByName('rKey').AsString+
            ' ,Step='+aqNextStepNO.fieldByName('STEP_NUMBER').AsString+s+
            ' ,loc_ptr='+inttostr(FaFct[ComboBox2.ItemIndex])+ //�¹��򹤳�
            ' ,if_paigong=0,assign_cycle=0,assign_date=null,datevalue=0'+//��ʼ���ɹ���Ϣ
            ' ,InTime=getdate() ,if_message=0,flow_no=0 where Wo_ptr='+inttostr(rkey06);

    sqlstr:= sqlstr +' update Data0056'
           +' set Data0056.WTYPE = 0'  //�������һ����������PACK,��Ϊ��������״̬
           +' FROM Data0006 INNER JOIN'
                 +' Data0056 ON Data0006.RKEY = Data0056.WO_PTR INNER JOIN'
                 +' Data0025 ON Data0006.BOM_PTR = Data0025.RKEY'
           +' WHERE ('+aqNextStepNO.fieldByName('STEP_NUMBER').AsString +' IN'
                     +' (SELECT MAX(step_number)'
                    +' FROM data0038 INNER JOIN'
                          +' data0034 ON data0038.dept_ptr = data0034.rkey'
                    +' WHERE data0038.source_ptr = data0025.rkey AND'
                          +' data0034.barcode_entry_flag = ''Y'' AND'
                          +' data0038.flow_no = data0056.flow_no)) AND (Data0006.RKEY ='+ inttostr(rkey06)+')';

    result := MyDataClass.ExecSql(sqlstr);
    if not result then
    begin
      ShowMsg('����56��ʧ��!',1);
      exit;
    end;
    //56�����ɹ������Ϣ
     with ADOQuery1 do
     begin
      Close;
      SQL.Clear;
      sql.Add('select top 1 isnull(rkey,0) as rkey from data0051 where ' +inttostr(jhzq)+ '>minvalue and '+inttostr(jhzq)+'<=maxvalue');
      Open;
     end;
     if ADOQuery1.IsEmpty then
     rkey51:=0
     else
     rkey51:=dmcon.ADOQuery1.fieldbyname('rkey').Value;
     if rkey51>0 then
     begin
      with ADOQuery2 do
      begin
      Close;
      SQL.Clear;
      sql.Add('select top 1 isnull(rkey,0) as rkey,isnull(dateValue,0) as datevalue from data0054 where dept_ptr='+aqNextStepNO.fieldByName('rKey').AsString);
      SQL.Add('and d051_ptr='+inttostr(rkey51));
      Open;
      end;
      if ADOQuery2.IsEmpty then
      begin
      rkey54:=0;
      jv:=0;
      end
      else
      begin
      rkey54:=ADOQuery2.fieldbyname('rkey').Value;
      jv:=ADOQuery2.fieldbyname('datevalue').Value;
      end;
      if rkey54>0 then
      begin
      sqlstr:=' update data0056 set if_paigong=1'+
             ' ,assign_cycle='+inttostr(jhzq)+
             ' ,assign_date=getdate()'+
             ' ,datevalue='+FloatToStr(jv)+' where Wo_ptr='+inttostr(rkey06);
                  result := MyDataClass.ExecSql(sqlstr);
       if not result then
       begin
        ShowMsg('����56���ɹ���Ϣʧ��!',1);
        exit;
       end;
      end;
     end;
    //3.������ҵ��״̬
    if CheckBox1.Checked then//��һ���������ⷢ����ôҪ����ҵ��״̬��Ϊ�ⷢ״̬
      sqlstr:='update data0006 set prod_status=4 where rKey='+inttostr(rkey06)
    else                     //��һ���������ⷢ����ôҪ����ҵ��״̬��Ϊ����״̬
      sqlstr:='update data0006 set prod_status=3 where rKey='+inttostr(rkey06);
    result := myDataClass.ExecSql(sqlstr);
    if not result then
    begin
      ShowMsg('������ҵ��״̬ʧ��!',1);
      exit;
    end;
   //4.������ҵ��06��:����������Ϊ���һ������ʱ��������ڲ��Ʒ���Ͱ���ҵ��06״̬����Ϊ"������"��prod_status=6�������������Ʒ����ҵ��״̬����Ϊ"�����"��prod_status=5��
    sqlstr:=' SELECT 1 FROM dbo.Data0038 D38 INNER JOIN dbo.Data0034 D34 ON D38.DEPT_PTR = D34.RKEY '+
            ' WHERE D34.BARCODE_ENTRY_FLAG = '+QuotedStr('Y')+' and D38.Source_ptr='+adsWOInfo.fieldByname('Bom_ptr').Asstring+
            ' and D38.Step_Number>'+ dmcon.aqNextStepNO.FieldByName('STEP_NUMBER').AsString;
    if not MyDataClass.IsExists(sqlstr) then//��������һ�����������һ��������,��ôҪ����ҵ��״̬�ı�
    begin
      if adsWoInfo.FieldByName('Parent_ptr').AsInteger >0 then //�ڲ��Ʒ
        sqlstr:= ' Update data0006 set prod_status = 6 where rKey='+inttostr(rkey06)
      else                                                     //����Ʒ
        sqlstr:= ' Update data0006 set prod_status = 5 where rKey='+inttostr(rkey06);
      result := myDataClass.ExecSql(sqlstr);
      if not result then
      begin
        ShowMsg('������ҵ��״̬ʧ��!',1);
        exit;
      end;
    end;
    //Update_WIPMAT_STATUS(rkey06);
   end;
  end;
end;

function TfrmWO_Count.Update_0048(From_Dept,Next_Dept,UserId,WType,PutType,Wo_ptr,StepNo,rkey25:integer):boolean;
var
  sqlstr:string;
  para_value:string;
  flow_no:Integer;
  jv:Extended; 
  paigong:Boolean;
begin
 paigong:=dmcon.adsWOInfo.FieldByName('if_paigong').Value;
 jv:=dmcon.adsWOInfo.FieldByName('datevalue').Value;
 dmcon.Para_Value.Close;
 dmcon.Para_Value.Parameters[0].Value:=rkey25;
 dmcon.Para_Value.Parameters[1].Value:=StepNo;
 dmcon.Para_Value.Open;
 para_value:=dmcon.Para_Valuenames_value.Value;
 if Length(para_value)>50 then
 begin
 para_value:='';
 end;
 with dmcon.tmp do
 begin
  close;
  SQL.Clear;
  SQL.Add('select Flow_No from data0056 where data0056.wo_ptr='+inttostr(Wo_ptr));
  Open;
 end;
 flow_no:=dmcon.tmp.FieldValues['flow_no'];
 sqlstr:=' insert into data0048(WO_PTR, FM_DEPT_PTR, TO_DEPT_PTR, INTIME, '+            //��������
          ' OUTTIME, QTY_PROD, PANELS, STEP_NO, EMPL_PTR, WTYPE, put_type,warehouse_ptr,PARAMETER_VALUE,ACTION_REF,if_paigong,datevalue,flow_no) '+
          ' select Wo_ptr,'+IntToStr(From_Dept)+','+IntToStr(Next_Dept)+',case when assign_date is not null then assign_date ELSE INTIME end,getdate(),Qty_BackLog,Panels,'+IntToStr(StepNo)+','+IntToStr(UserId)+
          ' ,'+IntToStr(WType)+','+IntToStr(PutType)+','+inttostr(FaFct[ComboBox1.ItemIndex])+','''+para_value+''','''+ComboBox3.Text+''','+booltostr(paigong)+','+FloatToStr(jv)+','+inttostr(flow_no)+' from data0056 where Wo_ptr='+IntToStr(Wo_ptr);
 result := MyDataClass.ExecSql(sqlstr);
 if not result then
 ShowMsg('����48�����!',1);
end;

function TfrmWO_Count.Update_0048_2(From_Dept,Next_Dept,UserId,WType,PutType,Wo_ptr,StepNo:integer):boolean;
var
  sqlstr:string;
  flow_no:Integer;
  jv:Extended;
  paigong:Boolean;
begin
  paigong:=dmcon.adsWOInfo.FieldByName('if_paigong').Value;
  jv:=dmcon.adsWOInfo.FieldByName('datevalue').Value;
 with dmcon.ADOQuery1 do
 begin
   Close;
   sql.Clear;
   sql.Add('select old_step_no from data0238 where wo_ptr='+inttostr(Wo_ptr));
   SQL.Add('and dept_ptr='+inttostr(From_Dept));
   sql.Add('and step_number='+inttostr(StepNo));
   Open;
 end;
 if (not dmcon.ADOQuery1.IsEmpty)then
 begin
   StepNo:=dmcon.ADOQuery1.FieldByName('old_step_no').Value;
 end;
 with dmcon.tmp do
 begin
  close;
  SQL.Clear;
  SQL.Add('select Flow_No from data0056 where data0056.wo_ptr='+inttostr(Wo_ptr));
  Open;
 end;
 flow_no:=dmcon.tmp.FieldValues['flow_no'];
 sqlstr:=' insert into data0048(WO_PTR, FM_DEPT_PTR, TO_DEPT_PTR, INTIME, '+            //��������
          ' OUTTIME, QTY_PROD, PANELS, STEP_NO, EMPL_PTR, WTYPE, put_type,warehouse_ptr,ACTION_REF,if_paigong,datevalue,flow_no) '+
          ' select Wo_ptr,'+IntToStr(From_Dept)+','+IntToStr(Next_Dept)+',case when assign_date is not null then assign_date ELSE INTIME end,getdate(),Qty_BackLog,Panels,'+IntToStr(StepNo)+','+IntToStr(UserId)+
          ' ,'+IntToStr(WType)+','+IntToStr(PutType)+','+inttostr(FaFct[ComboBox1.ItemIndex])+','''+ComboBox3.Text+''','+booltostr(paigong)+','+FloatToStr(jv)+','+inttostr(flow_no)+' from data0056 where Wo_ptr='+IntToStr(Wo_ptr);
 result := MyDataClass.ExecSql(sqlstr);
 if not result then
 ShowMsg('����48�����!',1);
end;

procedure TfrmWO_Count.SpeedButton4Click(Sender: TObject);
begin
  dmcon.adsEmployee.Filter := 'rKey34='+dmcon.adsWOInfo.fieldbyName('Dept_ptr').AsString;
  dmcon.adsEmployee.filtered := true;
end;

procedure TfrmWO_Count.SpeedButton5Click(Sender: TObject);
begin
  dmcon.adsEmployee.Filter := '';
  dmcon.adsEmployee.filtered := false;
end;

//function TfrmWO_Count.Update_0041(rkey06:integer): boolean;
//var
//  i,j:integer;
//begin
//  dmcon.ads0041.close;
//  dmcon.ads0041.open;
//  result := true;
//  if sg1.RowCount > 2 then
//  begin
//    for i:=1 to sg1.RowCount -2 do
//    begin
//      dmcon.ads0041.Append;
//      dmcon.ads0041.FieldByName('source_ptr').AsInteger := rkey06;
//      dmcon.ads0041.FieldByName('Dept_ptr').AsInteger := dmcon.adsWOInfo.FieldByName('Dept_ptr').AsInteger;
//      dmcon.ads0041.FieldByName('empl_ptr').AsString := sg1.Cells[3,i];
//      dmcon.ads0041.FieldByName('prod_pcs').AsString  := sg1.Cells[1,i];
//      dmcon.ads0041.FieldByName('prod_pnls').AsString := sg1.Cells[2,i];
//      dmcon.ads0041.Post;
//    end;
//  end;
//  try
//    dmcon.ads0041.UpdateBatch(arAll);
//    result := true;
//  except
//    result := false;
//  end;
//end;

procedure TfrmWO_Count.edtNewPCSKeyPress(Sender: TObject; var Key: Char);
begin
  if not (key in ['0'..'9',#8]) then abort;
end;

procedure TfrmWO_Count.edtNewPCSExit(Sender: TObject);
var
  PNLQty:integer;
begin
  if (trim(edtNewPCS.text)='') or (edtNewPNL.Enabled=false) then exit;
  PNLQty:=Ceil(StrToInt(edtNewPCS.Text) / PCS_PER_PNL);
  edtNewPNL.Text := IntToStr(PNLQty);
end;

procedure TfrmWO_Count.edtNewPNLExit(Sender: TObject);
begin
  if trim(edtNewPNL.text)='' then exit;
  if StrToInt('0'+edtNewPcs.Text) > 0 then exit;
  edtNewPCS.Text := IntToStr(StrToInt(edtNewPNL.text) * PCS_PER_PNL);
end;

function TfrmWO_Count.savAlid: boolean;
begin
  result:=false;
  if strtoint('0'+edtNewPCS.text)=0 then
  begin
    ShowMsg('���PCS��������Ϊ0,��ע��',1);
    edtNewPCS.SetFocus;
    exit;
  end;

  if (edtPNL.Text<>'0') and (strtoint('0'+edtNewPNL.text)=0) then
  begin
    ShowMsg('���PNL����Ϊ0,��ע��',1);
    edtNewPNL.SetFocus;
    exit;
  end;

  if strtoint('0'+edtNewPNL.Text)>strtoint('0'+edtNewPCS.Text) then
  begin
    showmessage('���PNL�����ܳ������PCS��');
    edtNewPCS.SetFocus;
    exit;
  end;

  if StrToInt(edtNewPCS.text)>StrToInt(edtPCS.Text)-StrToInt(edtDiscardQty.Text) then
  begin
    ShowMsg('�����������С��ԭ��ҵ��������ȥ�����뱨������,��ע��',1);
    edtNewPCS.SetFocus;
    exit;
  end;

  if (edtNewPNL.text<>'') and (StrToInt(edtNewPNL.text)>StrToIntdef(edtPNL.Text,0)) then
  begin
    ShowMsg('���PNL������С��ԭ��ҵ��PNL��,��ע��',1);
    edtNewPNL.SetFocus;
    exit;
  end;

  Dmcon.tmp.Close;
  Dmcon.tmp.SQL.Text:='SELECT a.QTY_BACKLOG,b.QUAN_ALLREJ, '+
                   'a.PANELS,b.QUAN_ALLpnl '+
                   'FROM dbo.Data0056 a inner join data0006 b '+
                   'on a.wo_ptr=b.rkey WHERE a.WO_PTR ='+dmcon.adsWOInfo.fieldbyName('rKey06').AsString;

  Dmcon.tmp.Open;
  if Dmcon.tmp.IsEmpty then
  begin
    ShowMsg('������ҵ���Ѳ�����...',1);
    exit;
  end;
  if (edtPCS.Field.AsInteger<>Dmcon.tmp.Fields[0].AsInteger) or (edtDiscardQty.Field.AsInteger<>Dmcon.tmp.Fields[1].AsInteger) then
  begin
    ShowMsg('��ҵ������״̬�����仯,�����˳��ٹ���...',1);
    exit;
  end;

 if Dmcon.tmp.Fields[0].AsInteger-Dmcon.tmp.Fields[1].AsInteger<strtoint(edtNewPCS.Text) then
  begin
    showmessage('���PCS�������߿ɲ��������'+inttostr(Dmcon.tmp.Fields[0].AsInteger-Dmcon.tmp.Fields[1].AsInteger)+',���޸�!');
    edtNewPCS.SetFocus;
    exit;
  end;

//  if CheckBox4.Checked then
//  begin
//    result:=true;
//    exit;
//  end;

  if Dmcon.tmp.Fields[2].AsInteger-Dmcon.tmp.Fields[3].AsInteger<strtoint('0'+edtNewPNL.Text) then
  begin
    showmessage('���PNLS�������߿ɲ��PNLS��'+inttostr(Dmcon.tmp.Fields[2].AsInteger-Dmcon.tmp.Fields[3].AsInteger)+',���޸�!');
    edtNewPCS.SetFocus;
    exit;
  end;

  if (edtPNL.Text<>'0') and (Dmcon.tmp.Fields[0].AsInteger-Dmcon.tmp.Fields[1].AsInteger-strtoint(edtNewPCS.Text)<Dmcon.tmp.Fields[2].AsInteger-Dmcon.tmp.Fields[3].AsInteger-strtoint('0'+edtNewPNL.Text)) then
  begin
    showmessage('��ֺ�����PNLS��������PCS,���޸�!');
    edtNewPCS.SetFocus;
    exit;
  end;

//  if (edtPNL.Text<>'0') and ((Dmcon.tmp.Fields[0].AsInteger-Dmcon.tmp.Fields[1].AsInteger-strtoint(edtNewPCS.Text))/PCS_PER_PNL>Dmcon.tmp.Fields[2].AsInteger-Dmcon.tmp.Fields[3].AsInteger-strtoint('0'+edtNewPNL.Text)) then
//  begin
//    showmessage('��ֺ�����PNLS������PCS�������߼�,���޸�!');
//    edtNewPCS.SetFocus;
//    exit;
//  end;
  result:=True;
end;

procedure TfrmWO_Count.Update_WIPMAT_STATUS(rKey06: Integer);
type
  IntArr = array of Integer;

  procedure SetWIPMAT_STATUSFalse(ARkey06: Integer);
  var
    LS: TStringList;
    LQry: TADOQuery;
  begin
    LS := TStringList.Create;
    LQry := TADOQuery.Create(Self);
    try
      LS.Add('UPDATE Data0006 SET WIPMAT_STATUS = 0 WHERE RKey = ');
      LS.Add(IntToStr(ARkey06));
      dmcon.SQLExec(LQry,LS);
    finally
      LS.Free;
      LQry.Close;
      LQry.Free;
    end;
  end;
  function GetNowStep(ARkey06: Integer): Integer;
  var
    LS: TStringList;
    LQry: TADOQuery;
  begin
    Result := -1;
    LS := TStringList.Create;
    LQry := TADOQuery.Create(Self);
    try
      LS.Add('SELECT STEP FROM Data0056 WHERE WO_PTR = ');
      LS.Add(IntToStr(ARkey06));
      if not dmcon.SQLOpen(LQry,LS) then Exit;
      if LQry.IsEmpty then Exit;
      Result := LQry.fieldByName('STEP').AsInteger;
    finally
      LS.Free;
      LQry.Close;
      LQry.Free;
    end;
  end;
  procedure GetChildCombinStep(var Arr: IntArr; AParentRkey: Integer);
  var
    LS: TStringList;
    LQry: TADOQuery;
    I: Integer;
  begin
    LS := TStringList.Create;
    LQry := TADOQuery.Create(Self);
    try
      LS.Add('SELECT D06.BOM_PTR ,D25.BOM_STEP FROM Data0006 D06 ');
      LS.Add(' INNER JOIN Data0025 D25 ON D25.PARENT_PTR = D06.BOM_PTR ');
      LS.Add(' WHERE D06.RKey = ');
      LS.Add(IntToStr(AParentRkey));
      if not dmcon.SQLOpen(LQry,LS) then Exit;
      if LQry.IsEmpty then Exit;
      SetLength(Arr,LQry.RecordCount);
      LQry.First;
      for I := 0 to LQry.RecordCount - 1 do
      begin
        Arr[I] := LQry.fieldByName('BOM_STEP').AsInteger;
        LQry.Next;
      end;  
    finally
      LS.Free;
      LQry.Close;
      LQry.Free;
    end;
  end;
var
  LChildStep: IntArr;
  LParentNowStep: Integer;
  I: Integer;
begin
  LParentNowStep := GetNowStep(rKey06);
  if LParentNowStep = -1 then ShowMsg('06��û���ҵ���¼',1);
  GetChildCombinStep(LChildStep,rKey06);
  for I := 0 to High(LChildStep) do
  begin
    if LParentNowStep = LChildStep[I] then
    begin
      SetWIPMAT_STATUSFalse(rKey06);
      Exit;
    end;
  end;
end;

function TfrmWO_Count.WoClamp(rkey06,clamp06:Integer):Boolean;
begin
  Result:=False;
 if check_woclamp(rkey06,clamp06) then
 begin
 dmcon.ADOConnection1.BeginTrans;
 try
  with dmcon.ADOQuery1 do //�޸����źϲ�����06��
  begin
   Close;
   sql.Clear;
   SQL.Add('select * from data0006 where rkey='+IntToStr(rkey06));
   Open;
  end;
  with dmcon.ADOQuery2 do
  begin
   Close;
   sql.Clear;
   SQL.Add('select * from data0006 where rkey='+IntToStr(clamp06));
   Open;
  end;
  dmcon.ADOQuery2.Edit;//�ϲ�ĸ����������
  dmcon.ADOQuery2.FieldByName('quan_sch').Value:=dmcon.ADOQuery2.FieldByName('quan_sch').Value+dmcon.ADOQuery1.FieldByName('quan_sch').Value;
  dmcon.ADOQuery2.FieldByName('quan_rej').Value:=dmcon.ADOQuery2.FieldByName('quan_rej').Value+dmcon.ADOQuery1.FieldByName('quan_rej').Value;
  dmcon.ADOQuery2.FieldByName('QUAN_PROD').Value:=dmcon.ADOQuery2.FieldByName('quan_prod').Value+dmcon.ADOQuery1.FieldByName('quan_prod').Value;
  dmcon.ADOQuery2.FieldByName('panels').Value:=dmcon.ADOQuery2.FieldByName('panels').Value+dmcon.ADOQuery1.FieldByName('panels').Value;
  dmcon.ADOQuery2.Post;
  dmcon.ADOQuery1.Edit;//�ӵ�������0
  dmcon.ADOQuery1.FieldByName('prod_status').Value:=202;
  dmcon.ADOQuery1.FieldByName('quan_sch').Value:=0;
  dmcon.ADOQuery1.FieldByName('quan_rej').Value:=0;
  dmcon.ADOQuery1.FieldByName('quan_prod').Value:=0;
  dmcon.ADOQuery1.FieldByName('panels').Value:=0;
  dmcon.ADOQuery1.Post;
  with dmcon.ADOQuery1 do//�޸ı��ϼ�¼����ָ��
  begin
   Close;
   sql.Clear;
   sql.Add('update data0058 set wo_ptr='+IntToStr(clamp06)+' where wo_ptr='+IntToStr(rkey06));
   ExecSQL;
  end;
  with dmcon.ADOQuery1 do//�޸ĳ�Ʒ���ָ��
  begin
   Close;
   sql.Clear;
   sql.Add('update data0053 set WORK_ORDER_PTR='+IntToStr(clamp06)+' where WORK_ORDER_PTR='+IntToStr(rkey06));
   ExecSQL;
  end;
  with dmcon.ADOQuery1 do //�޸�ĸ��56�����������������ӵ�����������ɾ���ӵ�������ҵ��
  begin
   Close;
   sql.Clear;
   SQL.Add('select * from data0056 where wo_ptr='+IntToStr(rkey06));
   Open;
  end;
 with dmcon.ADOQuery2 do
 begin
  Close;
  sql.Clear;
  SQL.Add('select * from data0056 where wo_ptr='+IntToStr(clamp06));
  Open;
 end;
 dmcon.ADOQuery2.Edit; //ĸ���������ϵ������������
 dmcon.ADOQuery2.FieldByName('QTY_BACKLOG').Value:=dmcon.ADOQuery2.FieldByName('QTY_BACKLOG').Value+dmcon.ADOQuery1.FieldByName('QTY_BACKLOG').Value;
 dmcon.ADOQuery2.FieldByName('TO_BE_STOCKED').Value:=dmcon.ADOQuery2.FieldByName('TO_BE_STOCKED').Value+dmcon.ADOQuery1.FieldByName('TO_BE_STOCKED').Value;
 dmcon.ADOQuery2.FieldByName('panels').Value:=dmcon.ADOQuery2.FieldByName('panels').Value+dmcon.ADOQuery1.FieldByName('panels').Value;
 dmcon.ADOQuery2.FieldByName('TO_BE_CANCD').Value:=dmcon.ADOQuery2.FieldByName('TO_BE_CANCD').Value+dmcon.ADOQuery1.FieldByName('TO_BE_CANCD').Value;
 dmcon.ADOQuery2.Post;
 with dmcon.ADOQuery3 do //�ӵ����߹���ɾ��
 begin
  Close;
  sql.Clear;
  SQL.Add('delete from data0056 where WO_PTR='+inttostr(rkey06));
  ExecSQL;
 end;
   with dmcon.ADOQuery3 do   //���Ĺ�����¼48���ӹ����ϲ�ʱ����ҵ��ָ�루�ϲ�������¼��
   begin
     Close;
     sql.Clear;
     sql.Add('update data0048 set wo_ptr='+inttostr(clamp06));
     SQL.Add('where wo_ptr='+inttostr(rkey06));
     ExecSQL;
   end;
  with dmcon.ADOQuery2 do //�ϲ���ҵ������0488��
  begin
    Close;
    sql.Clear;
    sql.Add('select * from data0488 where wo_ptr='+IntToStr(clamp06)+'order by rkey');
    Open;
  end;
  with dmcon.ADOQuery1 do
  begin
    Close;
    sql.Clear;
    sql.Add('select * from data0488 where wo_ptr='+IntToStr(rkey06)+'order by rkey');
    Open;
  end;
  if dmcon.ADOQuery2.IsEmpty=False then
  begin
    dmcon.ADOQuery2.First;
    dmcon.ADOQuery1.First;
    while not dmcon.ADOQuery2.Eof do
    begin
     dmcon.ADOQuery2.Edit;
     dmcon.ADOQuery2.FieldByName('quan_req').Value:=dmcon.ADOQuery2.FieldByName('quan_req').Value+dmcon.ADOQuery1.FieldValues['quan_req'];
     dmcon.ADOQuery2.FieldByName('quan_issued').Value:=dmcon.ADOQuery2.FieldByName('quan_issued').Value+dmcon.ADOQuery1.FieldValues['quan_issued'];
     dmcon.ADOQuery2.Post;
     dmcon.ADOQuery2.MoveBy(1);
     dmcon.ADOQuery1.MoveBy(1);
    end;
  end;
  with dmcon.ADOQuery3 do
  begin
    Close;
    sql.Clear;
    SQL.Add('delete from data0488 where wo_ptr='+IntToStr(rkey06));
    ExecSQL;
  end;
  with dmcon.ADOQuery2 do //�ϲ���ҵ������0489��
  begin
    close;
    SQL.Clear;
    sql.Add('select * from data0489 where wo_ptr='+IntToStr(clamp06)+'order by TDATE');
    Open;
  end;
  with dmcon.ADOQuery1 do
  begin
    close;
    SQL.Clear;
    sql.Add('select * from data0489 where wo_ptr='+IntToStr(rkey06)+'order by TDATE');
    Open;
  end;
  if dmcon.ADOQuery2.IsEmpty=False then
  begin
    dmcon.ADOQuery2.First;
    dmcon.ADOQuery1.First;
    while not dmcon.ADOQuery2.Eof do
    begin
      dmcon.ADOQuery2.Edit;
      dmcon.ADOQuery2.FieldByName('QTY').Value:=dmcon.ADOQuery2.FieldByName('QTY').Value+dmcon.ADOQuery1.FieldByName('QTY').Value;
      dmcon.ADOQuery2.Post;
      dmcon.ADOQuery2.MoveBy(1);
      dmcon.ADOQuery1.MoveBy(1);
    end;
  end;
  with dmcon.ADOQuery3 do
  begin
    Close;
    SQL.Clear;
    SQL.Add('delete from data0489 where wo_ptr='+inttostr(rkey06));
    ExecSQL;
  end;
  //�ϲ�410��
//  with dmcon.ADOQuery1 do
//  begin
//    Close;
//    sql.Clear;
//    sql.Add('select * from data0410 where wo_ptr='+inttostr(clamp06));
//    Open;
//  end;
  with dmcon.ADOQuery2 do
  begin
    Close;
    sql.Clear;
    sql.Add('select * from data0410 where wo_ptr='+inttostr(rkey06));
    Open;
  end;
  if not dmcon.ADOQuery2.IsEmpty then
  begin
    dmcon.ADOQuery2.First;
    while not dmcon.ADOQuery2.Eof do
    begin
     with dmcon.ADOQuery1 do
     begin
       Close;
       sql.Clear;
       SQL.Add('select * from data0410 where wo_ptr='+inttostr(clamp06));
       SQL.Add('and D0451_ptr='+dmcon.ADOQuery2.FieldByName('D0451_ptr').AsString);
       SQL.Add('and step='+dmcon.ADOQuery2.FieldByName('step').AsString);
       sql.Add('and dept_ptr='+dmcon.ADOQuery2.FieldByName('dept_ptr').AsString);
       Open;
     end;
     if not dmcon.ADOQuery1.IsEmpty then
     begin
       dmcon.ADOQuery1.Edit;
       dmcon.ADOQuery1.FieldByName('QTY').Value:=dmcon.ADOQuery1.FieldByName('QTY').Value+dmcon.ADOQuery2.FieldByName('QTY').Value;
       dmcon.ADOQuery1.FieldByName('MATL_AMOUNT').Value:=dmcon.ADOQuery1.FieldByName('MATL_AMOUNT').Value+dmcon.ADOQuery2.FieldByName('MATL_AMOUNT').Value;
       dmcon.ADOQuery1.FieldByName('ovhd1_AMOUNT').Value:=dmcon.ADOQuery1.FieldByName('ovhd1_AMOUNT').Value+dmcon.ADOQuery2.FieldByName('ovhd1_AMOUNT').Value;
       dmcon.ADOQuery1.FieldByName('ovhd2_AMOUNT').Value:=dmcon.ADOQuery1.FieldByName('ovhd2_AMOUNT').Value+dmcon.ADOQuery2.FieldByName('ovhd2_AMOUNT').Value;
       dmcon.ADOQuery1.FieldByName('ovhd3_AMOUNT').Value:=dmcon.ADOQuery1.FieldByName('ovhd3_AMOUNT').Value+dmcon.ADOQuery2.FieldByName('ovhd3_AMOUNT').Value;
       dmcon.ADOQuery1.Post;
     end
     else
     begin
      dmcon.ADOQuery2.Edit;
      dmcon.ADOQuery2.FieldByName('wo_ptr').Value:=clamp06;
      dmcon.ADOQuery2.Post;
     end;
     dmcon.ADOQuery2.MoveBy(1);
    end;
  end;
  with dmcon.ADOQuery3 do
  begin
    Close;
    sql.Clear;
    sql.Add('delete from data0410 where wo_ptr='+inttostr(rkey06));
    ExecSQL;
  end;
  dmcon.ADOConnection1.CommitTrans;
  Result:=True;
 except
  on E: Exception do
  begin
   Result:=False;
   if dmcon.ADOConnection1.InTransaction then
   dmcon.ADOConnection1.RollbackTrans;
   ShowMessage('��ҵ���ڴ˹���ϲ�ʧ��,���飡');
  end;
 end;
 end;
end;

procedure TfrmWO_Count.lv1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  LItem: TListItem;
  I: Integer;
begin
  LItem := lv1.GetItemAt(x,y);
  if LItem = nil then Exit;
  if LItem <> nil then
  begin
    for I := 0 to lv1.Items.Count - 1 do
    begin
      if lv1.Items[I] <> LItem then
        lv1.Items[I].Checked := False;
    end;
  end;
  LItem.Selected := True;
end;

procedure TfrmWO_Count.lv1SelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
var
  LItem: TListItem;
  I: Integer;
begin
  LItem := Item;
  if LItem <> nil then
  begin
    for I := 0 to lv1.Items.Count - 1 do
    begin
      if lv1.Items[I] <> LItem then
        lv1.Items[I].Checked := False;
    end;
  end;
  LItem.Checked := not LItem.Checked;
end;

function TfrmWO_Count.check_woclamp(rkey06,clamp06:Integer):Boolean;//�жϺϲ����������Ƿ����������
begin
  Result:=True;
  with dmcon.ADOQuery1 do
  begin
    Close;
    sql.Clear;
    sql.Add('select * from data0006 where rkey='+IntToStr(rkey06));
    Open;
  end;
  if (dmcon.ADOQuery1.FieldByName('wtype').Value=0) or  (dmcon.ADOQuery1.FieldByName('wtype').Value=1)  then
  begin
   Result:=True;
  end
  else
  begin
   MessageDlg('���Ϲ���״̬�����仯�����ܺϲ������飡',mtInformation,[mbok],1);
   Result:=False;
   Exit;
  end;

    with dmcon.ADOQuery2 do //�ж���ҵ������0488���Ƿ���Ժϲ�
  begin
    Close;
    sql.Clear;
    sql.Add('select * from data0488 where wo_ptr='+IntToStr(clamp06)+'order by rkey');
    Open;
  end;
  with dmcon.ADOQuery1 do
  begin
    Close;
    sql.Clear;
    sql.Add('select * from data0488 where wo_ptr='+IntToStr(rkey06)+'order by rkey');
    Open;
  end;
  if (dmcon.ADOQuery1.IsEmpty=False) and (dmcon.ADOQuery1.RecordCount<>dmcon.ADOQuery2.RecordCount) then
  begin
   MessageDlg('488��¼���ڲ��죬���ܺϲ������飡',mtInformation,[mbok],1);
   Result:=False;
   Exit;
  end;
    with dmcon.ADOQuery2 do //�ж�0489���Ƿ���Ժϲ�
  begin
    close;
    SQL.Clear;
    sql.Add('select * from data0489 where wo_ptr='+IntToStr(clamp06)+'order by TDATE');
    Open;
  end;
  with dmcon.ADOQuery1 do
  begin
    close;
    SQL.Clear;
    sql.Add('select * from data0489 where wo_ptr='+IntToStr(rkey06)+'order by TDATE');
    Open;
  end;
  if (dmcon.ADOQuery1.IsEmpty=False) and (dmcon.ADOQuery1.RecordCount<>dmcon.ADOQuery2.RecordCount) then
  begin
   MessageDlg('489��¼���ڲ��죬���ܺϲ������飡',mtInformation,[mbok],1);
   Result:=False;
   Exit;
  end;
end;

procedure TfrmWO_Count.lv1Exit(Sender: TObject);
var i,rkey06:Integer;
begin
 rkey06:=dmcon.adsWOInfo.FieldbyName('rKey06').AsInteger;
 for i:=0 to lv1.Items.Count-1 do
 begin
  if lv1.Items[I].Checked = true then
  begin
   clamp06:=StrToInt(lv1.Selected.SubItems.Strings[5]);//��ȡ�Ͽ�ĸ����rkeyֵ
  end;
 end;
 with dmcon.ADOQuery1 do
 begin
  Close;
  SQL.Clear;
  SQL.Add('select from_wo_ptr from data0006');
  SQL.Add('where rkey='+inttostr(clamp06));
  Open;
 end;
 with dmcon.ADOQuery2 do
 begin
  Close;
  SQL.Clear;
  sql.Add('select from_wo_ptr from data0006');
  sql.Add('where rkey='+inttostr(rkey06));
  Open;
 end;
 if (rkey06=dmcon.ADOQuery1.FieldByName('from_wo_ptr').Value) or (dmcon.ADOQuery2.IsEmpty) then
 begin
  with dmcon.tmpQry do
  begin
    Close;
    sql.Clear;
    SQL.Add('select rkey from data0448 where wo_ptr='+inttostr(clamp06));
    Open;
  end;
  if not dmcon.tmpQry.IsEmpty then
  begin
    lv1.Selected.Checked:=False;
   ShowMessage('��ǰ��ѡ�Ͽ���������ĩ����Ʒ�����ڲ��ܺϿ�,��ѡ����������!');
  end;
 end
 else
 begin
 with dmcon.tmpQry do
  begin
    Close;
    sql.Clear;
    SQL.Add('select rkey from data0448 where wo_ptr='+inttostr(rkey06));
    Open;
  end;
  if not dmcon.tmpQry.IsEmpty then
  begin
    lv1.Selected.Checked:=False;
   ShowMessage('��ǰ������������ĩ����Ʒ�����ڲ��ܺϿ�!');
  end;
 end;

end;

procedure TfrmWO_Count.CheckBox4Click(Sender: TObject);
begin
if CheckBox4.Checked=False then
 begin
  lv1.Selected.Checked:=False;
  lv1.Enabled:=False;
 end
 else
 begin
  lv1.Enabled:=True;
 end;
end;

function TfrmWO_Count.INQCLocked(ARkey06, ARkey34, AQty: Integer): Boolean;
var
  LSql: string;
begin
  Result := False;

  LSql := 'if object_id(N''dbo.QC_PassNumCheck'',N''U'') is not null begin select 1 end else select 0';
  if not OpenQuery(dmcon.aqTmp,LSql) then Exit;
  if dmcon.aqTmp.Fields[0].AsInteger = 0 then
  begin
    Exit;
  end;

  LSql := ' SELECT PassNum FROM qc_passNumCheck WHERE Enable = 1 AND Rkey06 = ' + IntToStr(ARkey06) +
          ' AND D34_ptr = ' + IntToStr(ARkey34);
  if not OpenQuery(dmcon.aqTmp,LSql) then exit;
  if not dmcon.aqTmp.IsEmpty then
  begin
    if AQty > dmcon.aqTmp.FieldByName('PassNum').AsInteger then
    begin
      Result := True;
    end;
  end;

end;

function TfrmWO_Count.INSPCLocked(ARkey06, ARkey34: Integer;var ErrStr: string): Boolean;
var
  LSql: string;
  LQryDef,LQrySpcCheck: TADOQuery;
  LCon: TADOConnection;
  LWONumber: string;
  LWHOUSE_PTR: string;
begin
  Result := False;

  LSql := 'if object_id(N''dbo.SPC_LockDeptDef'',N''U'') is not null begin select 1 end else select 0';
  if not OpenQuery(dmcon.aqTmp,LSql) then Exit;
  if dmcon.aqTmp.Fields[0].AsInteger = 0 then
  begin
    Exit;
  end;


  LQryDef := TADOQuery.Create(Self);
  LQrySpcCheck := TADOQuery.Create(Self);
  LCon := TADOConnection.Create(Self);
  LCon.LoginPrompt := False;
  LQrySpcCheck.Connection := LCon;
  try
    LQryDef.Connection := dmcon.ADOConnection1;
    dmcon.aqTmp.Close;
    dmcon.aqTmp.SQL.Text := 'select WHOUSE_PTR from data0006 where rkey = ' + IntToStr(ARkey06);
    dmcon.aqTmp.Open;
    LWHOUSE_PTR := dmcon.aqTmp.fieldbyname('WHOUSE_PTR').AsString;

    //ȡ��spc�������Ŀ
    LSql := 'SELECT * FROM SPC_LockDeptDef WHERE Active = 1 and D34_Ptr = ' + IntToStr(ARkey34) + ' and WHOUSE_PTR = ' + LWHOUSE_PTR;
    LQryDef.SQL.Text := LSql;
    LQryDef.Open;

    if LQryDef.IsEmpty then
    begin
      Exit;
    end;


    dmcon.aqTmp.Close;
    dmcon.aqTmp.SQL.Text := 'select work_order_number from data0006 where rkey = ' + IntToStr(ARkey06);
    dmcon.aqTmp.Open;
    LWONumber := dmcon.aqTmp.fieldbyname('work_order_number').AsString;


    //ȡ��spc����ϸ
    LQryDef.First;
    while not LQryDef.Eof do
    begin
      LSql := 'select 1 from ' + LQryDef.fieldbyname('SPCTableName').AsString + ' where ' + LQryDef.fieldbyname('WOCol').AsString + ' = ' + QuotedStr(LWONumber);
      LCon.Close;
      LCon.ConnectionString := LQryDef.FieldByName('ConStr').AsString;
      LCon.Open;
      LQrySpcCheck.Close;
      LQrySpcCheck.SQL.Text := LSql;
      LQrySpcCheck.Open;
      if LQrySpcCheck.IsEmpty then
      begin
        Result := True;
        ErrStr := LQryDef.fieldbyname('SPC_TestName').AsString;
        Exit;
      end;
      LQryDef.Next;
    end;

  finally
    LQryDef.Free;
    LQrySpcCheck.Free;
    LCon.Free;
  end;

end;

function TfrmWO_Count.Get_Max_Number(strWoNO: String): string;
  var
    AdoqryTmp:TAdoQuery;
    sqlstr: string;
  begin
    try
      AdoqryTmp:=TAdoQuery.Create(nil);
      AdoqryTmp.Connection := dmcon.ADOConnection1;
      sqlstr:='select Max(work_order_number) as F01 from data0006 where work_order_number like '''+strWoNO+'%''';
      AdoqryTmp.SQL.Clear;
      AdoqryTmp.SQL.Add(sqlstr);
      AdoqryTmp.Open;
      result := trim(AdoqryTmp.FieldByName('F01').AsString);
    finally
      AdoqryTmp.Close;
      AdoqryTmp.Free;
    end;
  end;

end.
