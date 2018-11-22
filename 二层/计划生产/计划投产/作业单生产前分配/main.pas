unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Grids, DBGridEh, StdCtrls, Buttons, DB, ComCtrls, ADODB,
  DBGrids, Menus;

type
  TX= Record
        A_BOM_PTR: Integer;
        B_TransQty: Double;
        C_TransPNLQty: Double;
        D_PARTS_PER_PANEL: Double;
        E_DiffQty: Double;
  End;
  TfrmMain = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    Panel5: TPanel;
    DBGridEh1: TDBGridEh;
    DBGridEh2: TDBGridEh;
    btnExit: TBitBtn;
    btnRefresh: TBitBtn;
    btnQuery: TBitBtn;
    edtBarCode: TEdit;
    Label1: TLabel;
    sbtPress: TSpeedButton;
    pnlQty: TPanel;
    Label2: TLabel;
    edtPCS: TEdit;
    Label3: TLabel;
    edtPNL: TEdit;
    Panel6: TPanel;
    TreeView1: TTreeView;
    Label4: TLabel;
    Label5: TLabel;
    pm1: TPopupMenu;
    N1: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DBGridEh1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure edtBarCodeEnter(Sender: TObject);
    procedure edtBarCodeKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnExitClick(Sender: TObject);
    procedure btnRefreshClick(Sender: TObject);
    procedure btnQueryClick(Sender: TObject);
    procedure sbtPressClick(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure edtPCSKeyPress(Sender: TObject; var Key: Char);
    procedure N1Click(Sender: TObject);
    procedure pm1Popup(Sender: TObject);
  private
    HotKey: Integer;
    function UpdateWOStatus(WORkey:integer;iStatus:byte):boolean;//������ҵ����״̬,Ϊ�ر�
    function ChangeWOQty(WoRkey:integer):boolean;                //������ҵ������
    function UpdateWOPriority(WORkey:integer):boolean;//���������ҵ�������ȼ�
    function Check_Before_Release:boolean;        //����ǰ�����ҵ��״̬
    function ReleaseWO(prod_status:Integer=3):boolean;  //��ҵ������
    procedure AllOperation(WO_List,Qty_List,PNLQty_List:string; NeedChgQnty:Boolean=False);
    procedure WMHotKeyHandle(var msg:TMessage); message wm_hotkey; //��Ӧ�ȼ���Ϣ
    function IsAuth(cut_no: string):Boolean;

  public
    ExistBef: Boolean;  //����˳������ȵ���ҵ��
    PRIORITY_CODE:Integer;//��㹤�������̶�
    function get_date0025toprkey(rkey25: integer):integer;
    procedure get_treedate(rkey25:integer;treeview:Ttreeview);    
  end;

var
  frmMain: TfrmMain;
  LList,RList: TStrings;
implementation

uses MyClass, common, uDM, Qnty;

{$R *.dfm}

procedure TfrmMain.FormCreate(Sender: TObject);
begin
{$IFDEF Release}
  if not App_init(DM.adoConn) then
  begin
    showmsg('��������ʧ�ܣ�����ϵ����Ա��',1);
    application.Terminate;
  end;
{$ENDIF}
{$IFDEF Debug}
  DM.adoConn.Connected:= False;
  DM.adoConn.Connected:= True;
  vprev:= '4';  //4д��
  rkey73:= '2444';
  user_ptr:= '1513';
{$ENDIF}
  self.caption:= Application.Title;
  DateSeparator:= '-';
  ShortDateFormat:= 'yyyy-mm-dd';
  LongDateFormat:='YYYY-MM-DD HH:NN:SS';
  
  LList:= TStringList.Create;
  RList:= TStringList.Create;
  ExistBef:= False;
  HotKey:=GlobalAddAtom('HotKey');
  RegisterHotKey(handle,HotKey,0,VK_F9);
end;

procedure TfrmMain.FormShow(Sender: TObject);
begin
  MyDataClass :=TMyDataClass.Create(DM.adoConn);
  DM.cdsIn.Close;
  DM.cdsIn.Open;
  DBGridEh1.FrozenCols:=11;
  PRIORITY_CODE:=0;
end;

procedure TfrmMain.DBGridEh1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if not (Sender as TDBGridEh).DataSource.DataSet.Active then Abort;
  if key = 45 then Abort;  //Insert
  if Key = 46 then Abort;
  if ((key = 40) and ((Sender as TDBGridEh).DataSource.DataSet.RecNo =
                      (Sender as TDBGridEh).DataSource.DataSet.RecordCount)) then
    Abort;  //��
  if ((key = 46) and (ssCtrl in shift)) then Abort;  //Ctrl+Delete
end;

procedure TfrmMain.edtBarCodeEnter(Sender: TObject);
begin
  edtBarCode.Text:= '';
end;

procedure TfrmMain.edtBarCodeKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 13 then
  begin
    if DM.cdsIn.Locate('WORK_ORDER_NUMBER',edtBarCode.Text,[loCaseInsensitive]) then
    begin
      DBGridEh1.SetFocus;
      if not (DM.cdsIn.State in [dsEdit]) then
        DM.cdsIn.Edit;
      DM.cdsIn.FieldByName('IsSelected').AsInteger:= 1;
      edtBarCode.SetFocus;
    end
    else
      edtBarCode.SelectAll;
  end;
end;

procedure TfrmMain.btnExitClick(Sender: TObject);
begin
  Close;
end;

procedure TfrmMain.btnRefreshClick(Sender: TObject);
var
  rkey:integer;
begin
  rkey:= dm.cdsInRKEY.Value;
  dm.cdsIn.Close;
  dm.cdsIn.Open;
  dm.cdsIn.Filter := '';
  dm.cdsIn.Filtered := false;
  if rkey>0 then dm.cdsIn.Locate('rkey',rkey,[]);
  LList.Clear;
  RList.Clear;
  ExistBef:= False;
end;

procedure TfrmMain.btnQueryClick(Sender: TObject);
begin
  { TODO -oAdministrator -c : ��ѯ 2013-03-19 14:16:28 }
end;

procedure TfrmMain.sbtPressClick(Sender: TObject);
var i,j,k: Integer;
  LStr,RStr,LMANU_PART_NUMBER,RMANU_PART_NUMBER: string;
  WO_List,Qty_List,PNLQty_List:string;
  Qty,PNLQty,MinTransQty,MaxTransQty:double;
  vtg:Boolean;
  a: array of TX;  //��Ÿ��ڲ㱾�η�������
  PANEL_AB: Integer;
begin

  with DM.aqTmp do
  begin
    Close;
    SQL.Text:='select 1 from data0400 where status=0';
    Open;
    if RecordCount > 0 then
    begin
      ShowMsg('���߲�Ʒ�����̵㣬��������䣡',1);
      Abort;
    end;
  end;
  with DM.aqTmp do
  begin
    Close;
    SQL.Text:=' select TStatus=isnull(D492.TStatus,1),D06.WIPMAT_STATUS,D06.PROD_STATUS,D25.ONHOLD_RELEASE_FLAG,D492.cut_no FROM Data0006 D06(nolock) '+
              ' INNER JOIN DATA0025 D25(nolock) ON D25.RKEY=D06.BOM_PTR '+
              ' LEFT  JOIN DATA0492 D492(nolock) ON D06.CUT_NO=D492.CUT_NO '+
              ' Where D06.RKEY=' + DM.cdsOut.FieldByName('RKEY').AsString;
    Open;
    if FieldByName('ONHOLD_RELEASE_FLAG').AsInteger = 1 then
    begin
      ShowMsg('�������ݻ������������&���ţ����飡',1);
      Abort;
    end;
    if FieldByName('TSTATUS').AsInteger in [1,3] then
    begin
      ShowMsg('���ϵ������ڻ�δ��˻���ȡ�������������&���ţ����飡',1);
      Abort;
    end;
  end;
  if ExistBef then
  begin
    if MessageBox(Handle, '���������ȷ������ҵ����,ȷ������������?', '����', MB_OKCANCEL +
      MB_ICONQUESTION) = IDCANCEL then Abort;
  end;
  try
    if (strtoint(vprev) in [1,3]) then
    begin
      ShowMsg('�Բ���!��û�иó���Ŀ�дȨ��',1);
      exit;
    end;
//    DM.AddStings;
    for i:= 0 to LList.Count-1 do
    begin
      if i = 0 then
        LStr:= LList[i]
      else
        LStr:= LStr + ',' + LList[i];
    end;
    for j:= 0 to RList.Count-1 do
    begin
      if j = 0 then
        RStr:= RList[j]
      else
        RStr:= RStr + ',' + RList[j];
    end;
    if ((LStr = '') or (RStr = '')) then
    begin
      MessageBox(Handle, '��ѡ���ڲ����㣡', '����', MB_OK + MB_ICONSTOP);
      Exit;
    end;
    with DM.aqTmp do
    begin
      Close;
      SQL.Clear;

      SQL.Add('select distinct d25_1.MANU_PART_NUMBER,d6.PANEL_A_B');
      SQL.Add('from dbo.Data0006 d6(nolock) inner join dbo.Data0025 d25(nolock) on d6.BOM_PTR=d25.RKEY');
      SQL.Add('inner join dbo.Data0025 d25_1(nolock) on d25.PARENT_PTR = d25_1.rkey');
      SQL.Add('where d6.RKEY in('+LStr+')');
      Open;
      if RecordCount <> 1 then
      begin
        MessageBox(Handle, '��ѡ�ڲ�����(��ͬһ������ŵ��ڲ�����AB��)�����飡', '����', MB_OK + MB_ICONSTOP);
        Exit;
      end;
      LMANU_PART_NUMBER:= FieldByName('MANU_PART_NUMBER').AsString;
      PANEL_AB:= FieldByName('PANEL_A_B').AsInteger;
    end;
    with DM.aqTmp do
    begin
      Close;
      SQL.Clear;
      SQL.Add('select d25.MANU_PART_NUMBER');
      SQL.Add('from dbo.Data0006 d6(nolock) inner join dbo.Data0025 d25(nolock) on d6.BOM_PTR=d25.RKEY');
      SQL.Add('where d6.RKEY in('+RStr+')');
      Open;
      if RecordCount <> 1 then
      begin
        MessageBox(Handle, '��ѡ����������飡', '����', MB_OK + MB_ICONSTOP);
        Exit;
      end;
      RMANU_PART_NUMBER:= FieldByName('MANU_PART_NUMBER').AsString;
    end;
    if LMANU_PART_NUMBER <> RMANU_PART_NUMBER then
    begin
      MessageBox(Handle, '����㲻ƥ��(��ͬһ�������) �����ԣ�', '����', MB_OK + MB_ICONSTOP);
      Exit;
    end;
    with DM.aqTmp do
    begin
      Close;
      SQL.Clear;
      SQL.Add('select 1 from data0025 d25(nolock) where PARENT_PTR in(select BOM_PTR from data0006 d06(nolock) where d06.RKEY in('+RStr+'))');
      SQL.Add('and not exists(select * from data0006 d06_1(nolock) where RKEY in('+LStr+') and d25.rkey = d06_1.BOM_PTR)');
      Open;
      if RecordCount <> 0 then
      begin
        MessageBox(Handle, 'ȱ���ڲ㣬���飡', '����', MB_OK + MB_ICONSTOP);
        Exit;
      end;
    end;
    with DM.aqTmp do
    begin
      Close;
      SQL.Clear;
      SQL.Add('select 1 from data0006 d06_1(nolock) where RKEY in('+LStr+')');
      SQL.Add('and not exists(select * from data0025 d25(nolock) where PARENT_PTR in(select BOM_PTR from data0006 d06(nolock) where d06.RKEY in('+RStr+')) and d25.rkey = d06_1.BOM_PTR)');
      Open;
      if RecordCount <> 0 then
      begin
        MessageBox(Handle, '�ڲ����(��ͬ�������)�����飡', '����', MB_OK + MB_ICONSTOP);
        Exit;
      end;
    end;

////////////////////////////////////////////////////////////
    with DM do
    try
      PRIORITY_CODE:=0;    //add by zsp   2017-03-27
      Qty:=0;
      PNLQty:=0;
      k:=0;
      SetLength(a,1);
      cdsIn.Filter := 'IsSelected=1';
      cdsIn.Filtered := True;
      //������������ҵ�������ܱ��η�������������¼����������ҵ��rkeyֵ
      cdsIn.First;
      while not cdsIn.Eof do
      begin
        if k=0 then
        begin
          a[0].A_BOM_PTR:=cdsIn.FieldByName('BOM_PTR').AsInteger;
          a[0].B_TransQty:=cdsIn.FieldByName('TransQty').ASFloat;
          a[0].C_TransPNLQty:=cdsIn.FieldByName('TransPNLQty').ASFloat;
          a[0].D_PARTS_PER_PANEL:=cdsIn.FieldByName('PARTS_PER_PANEL').ASFloat;
          if a[0].C_TransPNLQty*a[0].D_PARTS_PER_PANEL < a[0].B_TransQty then
            a[0].E_DiffQty:=0
          else
            a[0].E_DiffQty:=a[0].C_TransPNLQty*a[0].D_PARTS_PER_PANEL-a[0].B_TransQty;
        end
        else
        begin
          vtg:=True;
          for i:=0 to Length(a)-1 do
          begin
            if cdsIn.FieldByName('BOM_PTR').AsInteger = a[i].A_BOM_PTR then
            begin
              a[i].B_TransQty:=a[i].B_TransQty+cdsIn.FieldByName('TransQty').AsInteger;  //ͬһ��Ʒ����,�����ۼ�
              a[i].C_TransPNLQty:=a[i].C_TransPNLQty+cdsIn.FieldByName('TransPNLQty').AsInteger;
              a[i].D_PARTS_PER_PANEL:=cdsIn.FieldByName('PARTS_PER_PANEL').ASFloat;
              if cdsIn.FieldByName('TransPNLQty').AsInteger*cdsIn.FieldByName('PARTS_PER_PANEL').ASFloat > cdsIn.FieldByName('TransQty').AsInteger then
                a[i].E_DiffQty:=a[i].E_DiffQty+
                     cdsIn.FieldByName('TransPNLQty').AsInteger*cdsIn.FieldByName('PARTS_PER_PANEL').ASFloat-cdsIn.FieldByName('TransQty').AsInteger;
              vtg:=False;
            end;
          end;
          if vtg then
          begin
            SetLength(a,length(a)+1);
            a[length(a)-1].A_BOM_PTR:=cdsIn.FieldByName('BOM_PTR').AsInteger;
            a[length(a)-1].B_TransQty:=cdsIn.FieldByName('TransQty').ASFloat;
            a[length(a)-1].C_TransPNLQty:=cdsIn.FieldByName('TransPNLQty').ASFloat;
            a[length(a)-1].D_PARTS_PER_PANEL:=cdsIn.FieldByName('PARTS_PER_PANEL').ASFloat;
            if cdsIn.FieldByName('TransPNLQty').AsInteger*cdsIn.FieldByName('PARTS_PER_PANEL').ASFloat < cdsIn.FieldByName('TransQty').AsInteger then
              a[length(a)-1].E_DiffQty:=0
            else
              a[length(a)-1].E_DiffQty:=
                cdsIn.FieldByName('TransPNLQty').AsInteger*cdsIn.FieldByName('PARTS_PER_PANEL').ASFloat-cdsIn.FieldByName('TransQty').AsInteger;
          end;
        end;

        Qty:=Qty+cdsIn.FieldByName('TransQty').ASFloat;
        PNLQty:=PNLQty+cdsIn.FieldByName('TransPNLQty').ASFloat;

        if WO_List = '' then
          WO_List:=cdsIn.FieldByName('rKey').AsString
        else
          WO_List:=WO_List+','+cdsIn.FieldByName('rKey').AsString;
        if Qty_List= '' then
          Qty_List:=cdsIn.FieldByName('TransQty').AsString
        else
          Qty_List:=Qty_List+','+cdsIn.FieldByName('TransQty').AsString;
        if PNLQty_List= '' then
          PNLQty_List:=cdsIn.FieldByName('TransPNLQty').AsString
        else
          PNLQty_List:=PNLQty_List+','+cdsIn.FieldByName('TransPNLQty').AsString;
        if PRIORITY_CODE<cdsIn.FieldByName('PRIORITY_CODE').AsInteger then
         PRIORITY_CODE:=cdsIn.FieldByName('PRIORITY_CODE').AsInteger
        else
        PRIORITY_CODE:=PRIORITY_CODE;

        aqTmp.Close;
        aqTmp.SQL.Text:='select D06.rkey from data0006 D06 inner join data0056 D56 on D56.WO_Ptr=D06.rKey '+
                         'where d06.PROD_STATUS=6 and D06.rkey='+cdsIn.FieldByName('rKey').AsString+
                         ' and D56.Qty_BackLog-d06.quan_allrej='+cdsIn.FieldByName('Qty_BackLog').AsString;
        aqTmp.Open;
        if aqTmp.IsEmpty then
        begin
          ShowMsg('��ҵ��:'+cdsIn.FieldByName('WORK_ORDER_NUMBER').AsString+'����������״̬�����ı�,����!',1);
          exit;
        end;
        Inc(k);
        cdsIn.next;
      end;
      for i:=1 to Length(a)-1 do
      begin
        if a[i-1].C_TransPNLQty <> a[i].C_TransPNLQty then
        begin
          MessageBox(Handle, '���ڲ�PNL������һ�£����飡', '����', MB_OK + MB_ICONSTOP);
          Abort;
        end;
      end;
      cdsOut.Locate('IsSelected',1,[]);
      with aqTmp do
      begin
        Close;
        SQL.Text:='select rkey,PANEL_A_B from dbo.Data0006(nolock) '+
                   'where WIPMAT_STATUS=0 and PROD_STATUS=2 and rkey='+cdsOut.FieldByName('RKEY').AsString;
        Open;
        if IsEmpty then
        begin
          ShowMsg('��ҵ��:'+cdsOut.FieldByName('WORK_ORDER_NUMBER').AsString+'�ѷ����״̬�����ı䣬���飡',1);
          Exit;
        end;
        if PANEL_AB <> aqTmp.FieldByName('PANEL_A_B').AsInteger then
        begin
          ShowMsg('�������ҵ������ͬΪA���B�壬���飡',1);
          Exit;
        end;
      end;
      if a[0].C_TransPNLQty > cdsOut.FieldByName('PANELS').AsFloat then
      begin
        MessageBox(Handle, '�ڲ㷢��PNL�����������ƻ�PNL�������飡', '����', MB_OK + MB_ICONSTOP);
        Exit;
      end;
      if a[0].C_TransPNLQty < cdsOut.FieldByName('PANELS').AsFloat then
      begin
        MessageBox(Handle, '�ڲ㷢��PNL����С�����ƻ�PNL�������������ҵ�����ܼ���������', '����', MB_OK + MB_ICONSTOP);
        Exit;
      end;
      MinTransQty:=0;
      MaxTransQty:=0;
      for i:=0 to Length(a)-1 do
      begin
        MinTransQty:= MinTransQty+a[i].E_DiffQty;
        if i=0 then
          MaxTransQty:= a[i].E_DiffQty
        else
        begin
          if MaxTransQty < a[i].E_DiffQty then
            MaxTransQty:= a[i].E_DiffQty;
        end;
      end;
      MinTransQty:= a[0].C_TransPNLQty*a[0].D_PARTS_PER_PANEL-MinTransQty;
      MaxTransQty:= a[0].C_TransPNLQty*a[0].D_PARTS_PER_PANEL-MaxTransQty;
      if ((MinTransQty > MaxTransQty) or (MinTransQty > a[0].C_TransPNLQty*a[0].D_PARTS_PER_PANEL)) then
      begin
        MessageBox(Handle, 'δ֪��������ϵϵͳ����Ա��', '����', MB_OK + MB_ICONSTOP);
        Exit;
      end;
      edtPNL.Text:= FloatToStr(a[0].C_TransPNLQty);
//        if ((MinTransQty=MaxTransQty) and (MinTransQty=a[0].C_TransPNLQty*a[0].D_PARTS_PER_PANEL)) then
      if MinTransQty=MaxTransQty then
      begin
        edtPCS.Text:= FloatToStr(MinTransQty);
        //AllOperation(WO_List,Qty_List,PNLQty_List);
        AllOperation(WO_List,Qty_List,PNLQty_List,True);  //2014.07.25 ���ڲ�PNL�������PNL��һ��,���ڲ�PCS�������PCS����һ��ʱ,��Update���PCS��
      end
      else
      with TFrmQnty.Create(Application) do
      try
        edtPCS.Text:= FloatToStr(MaxTransQty);
        MinQty:= MinTransQty;
        MaxQty:= MaxTransQty;
        edt_PCS.Text:= edtPCS.Text;
        edt_PNL.Text:= edtPNL.Text;
        if ShowModal = mrok then
        begin
          edtPCS.Text:= edt_PCS.Text;
          AllOperation(WO_List,Qty_List,PNLQty_List,True);
        end;
      finally
        Free;
      end;
    finally
      edtPNL.Text:= '';
      edtPCS.Text:= '';
    end;
  finally
    btnRefresh.Click;
    edtBarCode.SetFocus;
  end;
end;

procedure TfrmMain.FormDestroy(Sender: TObject);
begin
  if Assigned(LList) then LList.Free;
  if Assigned(RList) then RList.Free;
  unregisterhotkey(handle,HotKey);
  DeleteAtom(HotKey);
end;

procedure TfrmMain.edtPCSKeyPress(Sender: TObject; var Key: Char);
begin
  if not (Key in['0'..'9',#8]) then Key:= #0;
end;

function TfrmMain.UpdateWOStatus(WORkey: integer; iStatus: byte): boolean;
var
  sqlstr:string;
begin
  sqlstr:='update data0006 set wipmat_status='+IntToStr(iStatus)+' where rkey='+IntToStr(WorKey);
  result:= MyDataClass.ExecSql(sqlstr);
end;

function TfrmMain.UpdateWOPriority(WORkey: integer): boolean;
var
  sqlstr:string;
begin
  sqlstr:='update data0006 set PRIORITY_CODE='+IntToStr(PRIORITY_CODE)+' where rkey='+IntToStr(WorKey);
  result:= MyDataClass.ExecSql(sqlstr);
end;

function TfrmMain.ChangeWOQty(WoRkey: integer): boolean;
var
  Sqlstr:string;
  Qty_Diff:integer;
begin
  Result:= true;
  Qty_Diff:= DM.cdsOut.Fieldbyname('QUAN_SCH').asInteger - strtoint(edtPCS.Text);
  if Qty_Diff<>0 then
  begin              
    Sqlstr:=' update data0006 set QUAN_SCH= '+edtPCS.Text+',PANELS='+edtPNL.Text+' where rKey='+DM.cdsOut.FieldByName('RKEY').AsString
            +#13+' Update data0492 set Issued_Qty=Issued_Qty-'+IntToStr(Qty_Diff)+',waitfor_release=waitfor_release-'+IntToStr(Qty_Diff)+' where CUT_NO='+QuotedStr(DM.cdsOut.FieldByName('CUT_NO').AsString)
            +#13+' insert into data0117(SOURCE_TYPE,SOURCE_PTR,EMPL_PTR,TDATE,ACTION,remark) '
            +'values(2,'+IntToStr(WorKey)+','+user_ptr+',getdate()'+',8,''����ҵ������ǰ�����д���:��ҵ�������޸�ԭPCS:'+DM.cdsOut.Fieldbyname('QUAN_SCH').AsString+' ��PCS:'+edtPCS.Text+''')';
    try
      with dm.aqTmp do
      begin
        Close;
        SQL.Clear;
        SQL.Add(Sqlstr);
        ExecSQL;
      end;
    except
      Result := false;                    //492�����������ڴ˴��޷���ȡ,δ�ҵ�ԭ��2014.07.26 by lrl
      ShowMsg('��������ʧ��',1);
      Abort;
    end;
  end; 
end;

procedure TfrmMain.AllOperation(WO_List,Qty_List,PNLQty_List:string; NeedChgQnty:Boolean);
begin
  dm.adoConn.BeginTrans;
  try
    if dm.DeployWO(dm.cdsOut.FieldByName('rKey').AsInteger,WO_List,Qty_List,PNLQty_List) then
    begin
      if NeedChgQnty then ChangeWOQty(dm.cdsOut.FieldByName('rKey').AsInteger);//���������ҵ��PCS����
      if not UpdateWoPriority(dm.cdsOut.FieldByName('rKey').AsInteger) then
      begin
        if dm.adoConn.InTransaction then dm.adoConn.RollbackTrans;
        ShowMsg('���������ҵ�������̶�ʧ��!����',1);
        Abort;
      end;
      if not UpdateWOStatus(dm.cdsOut.FieldByName('rKey').AsInteger,1) then
      begin
        if dm.adoConn.InTransaction then dm.adoConn.RollbackTrans;
        ShowMsg('�ر���ҵ��ʧ��!����',1);
        Abort;
      end;
      if not Check_Before_Release then Abort;
      if not ReleaseWO then
      begin
        if DM.adoConn.InTransaction then dm.adoConn.RollbackTrans;
        ShowMsg('������ҵ��: '+dm.cdsOut.FieldbyName('WORK_ORDER_NUMBER').AsString+'ʧ��,����',1);
        Abort;
      end;
      if dm.adoConn.InTransaction then dm.adoConn.CommitTrans;
      ShowMsg('�����ɹ���',1);
    end
    else
    begin
      if DM.adoConn.InTransaction then DM.adoConn.RollbackTrans;
      ShowMsg('����ʧ�ܣ�',1);
    end;
  except
    if dm.adoConn.InTransaction then dm.adoConn.RollbackTrans;
  end;
end;

function TfrmMain.get_date0025toprkey(rkey25: integer): integer;
var
 rkey:integer;
begin
  with dm.aqTmp1 do
  begin
    close;
    sql.Text:='select parent_ptr from data0025(nolock) where rkey='+inttostr(rkey25);
    open;
    rkey := fieldbyname('parent_ptr').AsInteger; //���ڸ�ֵ
  end;

  if rkey <= 0 then
    rkey:=rkey25       //������Ƕ�������Լ�
  else
  with dm.aqTmp1 do
  begin
    close;
    sql.Text:='select parent_ptr from data0025(nolock) where rkey='+inttostr(rkey);
    open;
    if FieldByName('parent_ptr').AsInteger > 0 then
    rkey := fieldbyname('parent_ptr').AsInteger;  //�����үү����үүֵ
  end;
  result:=rkey;
end;

procedure TfrmMain.get_treedate(rkey25: integer; treeview: Ttreeview);
var
  node:ttreenode;   //treeview�ؼ��Ľڵ����
  rkey0025:^integer;
begin
  treeview.Items.Clear;
  with dm.aqTmp do
  begin
    close;
    sql.Text:='select rkey,MANU_PART_NUMBER from data0025(nolock) where rkey='+
                inttostr(get_date0025toprkey(rkey25));
    open;
    new(rkey0025);
    rkey0025^:=FieldByName('rkey').AsInteger;
    node:=treeview.Items.AddObject
    (nil,fieldbyname('MANU_PART_NUMBER').AsString,rkey0025); //���Ӷ���ڵ�
    node.ImageIndex:=0;  //Ϊ��һ��ڵ㶨��ͼ��
  end;

  with dm.aqTmp do
  begin
    close;
    sql.Text:='select rkey,MANU_PART_NUMBER from data0025(nolock) where parent_ptr='+
                inttostr(get_date0025toprkey(rkey25));
    open;
    while not dm.aqTmp.Eof do
    begin
      new(rkey0025);
      rkey0025^:= dm.aqTmp.fieldvalues['rkey'];
      node:=treeview.Items.AddChildObject
        (node,fieldbyname('MANU_PART_NUMBER').AsString,rkey0025);
      node.ImageIndex := 1;
      with dm.aqTmp1 do
      begin
        close;
        sql.Text:='select rkey,MANU_PART_NUMBER from data0025(nolock) where parent_ptr='+
                dm.aqTmp.fieldbyname('rkey').AsString;
        open;
        while not dm.aqTmp1.Eof do
        begin
          new(rkey0025);
          rkey0025^:= dm.aqTmp1.fieldvalues['rkey'];
          node:=treeview.Items.AddChildObject
           (node, dm.aqTmp1.fieldbyname('MANU_PART_NUMBER').AsString,rkey0025);

          node.ImageIndex := 2;
          node:=node.Parent;
          dm.aqTmp1.Next;
        end;
      end;
      node:=node.Parent; //�ڵ�ָ���丸�ڵ�ֵ
      dm.aqTmp.Next;
    end;
  end;
  treeview.FullExpand; //ȫ��չ��
  treeview.Items[0].Selected:=true;
end;

procedure TfrmMain.WMHotKeyHandle(var msg: TMessage);
var
  hdw: HWND;
begin
  if msg.WParam = HotKey then
  begin
    hdw:= FindWindow('TfrmMain',nil);
    if GetForegroundWindow <> hdw then
    begin
      if IsIconic(hdw) then  //����ô�����С����ָ�
        ShowWindow(hdw, SW_RESTORE)
      else  //��������ں�̨����ŵ�ǰ̨
        SetForegroundWindow(hdw);
    end;
    sbtPress.Click;
  end;
end;

function TfrmMain.Check_Before_Release: boolean;
begin
  with DM.aqTmp do
  begin
    Close;
    SQL.Text:=' select D492.TStatus,D06.WIPMAT_STATUS,D06.PROD_STATUS,D25.ONHOLD_RELEASE_FLAG,D492.cut_no FROM Data0006 D06(nolock) '+
              ' INNER JOIN DATA0492 D492(nolock) ON D492.CUT_NO=D06.CUT_NO '+
              ' INNER JOIN DATA0025 D25(nolock) ON D25.RKEY=D06.BOM_PTR '+
              ' Where D06.RKEY=' + DM.cdsOut.FieldByName('RKEY').AsString;
    Open;
    if IsEmpty then
    begin
      Result := False;
      ShowMsg('��ǰ��ҵ��û���ҵ��������Ѿ�����״̬��������飡',1);
    end
    else
    if FieldByName('TStatus').AsInteger = 1 then
    begin
      Result := False;
      ShowMsg('����ҵ�������ϵ�δ��ˣ��������ţ����飡',1);
    end
    else
    if FieldByName('WIPMAT_STATUS').AsInteger = 0 then
    begin
      Result := False;
      ShowMsg('����ҵ�����ڲ�û�з��䣬�������ţ����飡',1);
    end
    else
    if FieldByName('PROD_STATUS').AsInteger <> 2 then
    begin
      Result := False;
      ShowMsg('����ҵ�����Ǵ�����״̬���������ţ����飡',1);
    end
//    else
//    if FieldByName('ONHOLD_RELEASE_FLAG').AsInteger = 1 then
//    begin
//      Result := False;
//      ShowMsg('�������ݻ����������ţ����飡',1);
//    end
    else
      Result := True;
  end;
end;

function TfrmMain.ReleaseWO(prod_status:Integer=3): boolean;//prod_status 3:������; 4:�ⷢ����
var
  sqlstr:string;
  i,j:integer;
  sysdate: TDateTime;
begin
  Result:= False;
  with DM.aqTmp do
  begin
    Close;
    SQL.Text:=' select D492.TStatus,D06.WIPMAT_STATUS,D06.PROD_STATUS,D25.ONHOLD_RELEASE_FLAG FROM Data0006 D06(nolock) '+
              ' INNER JOIN DATA0492 D492(nolock) ON D492.CUT_NO=D06.CUT_NO '+
              ' INNER JOIN DATA0025 D25(nolock) ON D25.RKEY=D06.BOM_PTR '+
              ' Where D06.RKEY=' + DM.cdsOut.FieldByName('RKEY').AsString;
    Open;
    if FieldByName('ONHOLD_RELEASE_FLAG').AsInteger = 1 then
    begin
      Result:= True;
      ShowMsg('�������ݻ����������ţ����飡',1);            //�˴�����������,������������
      Exit;
    end;
  end;
  with DM do
  begin
    with aqTmp do
    begin
      Close;
      SQL.Text:='select * from data0056(nolock) where wo_ptr=' + cdsOut.FieldByName('RKEY').AsString;
      Open;
      if RecordCount<>0 then
      begin
        ShowMsg('�����ҵ���Ѿ������������ߣ����飡',1);
        Abort;
      end;
    end;
    with aqENGFlow do
    begin
      Close;
      SQL.Text:='select t38.dept_ptr,t38.step_number, t34.barcode_entry_flag '+
                'from Data0038 t38(nolock) inner join Data0034 t34(nolock) on t38.dept_ptr=t34.rkey '+
                'where t38.step_number>=1 '+
                'and t38.source_ptr=' + cdsOut.FieldByName('RKEY25').AsString+
                ' order by t38.step_number';
      Open;
      if RecordCount=0 then
      begin
        ShowMsg('��㹤������δ���������ܷ��ţ�',1);
        Abort;
      end;
    end;
    with aqTmp do
    begin
      Close;
      SQL.Text:=
      'select D06.PROD_STATUS,barcode_flag,D06.RKEY,D06.WORK_ORDER_NUMBER,D06.BOM_PTR,D06.QUAN_SCH,D06.WIPMAT_STATUS, '+
      'D06.ENT_DATETIME,D06.SCH_COMPL_DATE,D06.PARTS_PER_PANEL,D06.cut_no,D06.quan_rej,D06.quan_prod,D06.panels, '+
      'D492.SO_NO,D10.CUST_CODE, D25.CUSTOMER_PTR, D25.MANU_PART_NUMBER,D25.MANU_PART_DESC,D492.TType,D08.PROD_CODE, '+
      'dateadd(day,(0-D25.SHELF_LIFE),D06.SCH_COMPL_DATE) AS AdvicePordDate,D06.wtype,D06.put_type,D492.WHOUSE_PTR '+
      'FROM dbo.Data0025 D25(nolock) INNER JOIN '+
      '      dbo.Data0010 D10(nolock) ON D25.CUSTOMER_PTR=D10.RKEY '+
      'INNER JOIN Data0006 D06(nolock) on D06.BOM_PTR=D25.RKEY '+
      'INNER JOIN DATA0492 D492(nolock) ON D492.CUT_NO=D06.CUT_NO '+
      'INNER JOIN DATA0008 D08(nolock) ON D08.RKEY=D25.PROD_CODE_PTR '+
      'Where D06.WIPMAT_STATUS = 1 and D06.PROD_STATUS=2 and D492.TSTATUS <>1 '+
      'and D06.RKEY=' + cdsOut.FieldByName('RKEY').AsString +
      ' ORDER BY D06.WORK_ORDER_NUMBER ';
      Open;
      if RecordCount=0 then
      begin
        ShowMsg('�����ҵ�����󣬲��ܷ��ţ�',1);
        Abort;
      end;
    end;
    //try
      //if not adoConn.InTransaction then adoConn.BeginTrans;{20130927}
      aqENGFlow.First;
      aqENGFlow.Locate('barcode_entry_flag','Y',[]) ;
      sqlstr:= 'Insert into data0056(wo_ptr,dept_ptr,intime,qty_backlog,panels,step,employee_ptr,loc_ptr,wtype,put_type,TDate)'+
               ' values('+cdsOut.FieldByName('RKEY').AsString+','+aqENGFlow.FieldByName('dept_ptr').AsString+',getdate(),'+
               IntToStr(aqTmp.fieldbyname('quan_sch').AsInteger-aqTmp.fieldbyname('quan_rej').AsInteger-aqTmp.fieldbyname('quan_prod').AsInteger)+','+
               aqTmp.fieldbyname('panels').AsString+','+aqENGFlow.fieldbyname('step_number').AsString+','+ User_ptr+','+aqTmp.fieldbyname('WHOUSE_PTR').AsString+','
               +'0,'+aqTmp.fieldbyname('put_type').AsString+',getdate())';
      if not MyDataClass.ExecSql(sqlstr) then
      begin
        ShowMsg('������Ԥ�ڴ���,����������ҵ�����߼�¼ʧ�ܣ�����ϵϵͳ����Ա!',1);
        Abort;
      end;

      aqTmp1.Close;
      aqTmp1.SQL.Text:='select count(data0038.step_number),getdate() from data0034 inner join data0038 on '+
                       'data0038.dept_ptr=data0034.rkey where data0038.source_ptr='+aqTmp.fieldbyname('bom_ptr').AsString+
                       ' and data0034.barcode_entry_flag=''Y''';
      aqTmp1.Open;
      sysdate:=aqTmp1.fields[1].AsDateTime;
      if aqTmp1.fields[0].AsInteger>1 then  //������ҵ��״̬Ϊ:������,�ͷ�������
        sqlstr:='update data0006 set prod_status = '+inttostr(prod_status)+',release_date=getdate() where rKey='+cdsOut.FieldByName('RKEY').AsString
      else
      if aqTmp1.fields[0].AsInteger=1 then
      begin  //��������ֻ��һ������
        aqTmp1.Close;
        aqTmp1.SQL.Text:='select parent_ptr from data0025 where rkey='+aqTmp.fieldbyname('bom_ptr').AsString;
        aqTmp1.Open;
        if aqTmp1.Fields[0].AsInteger>0 then     //is son ,������
          sqlstr:='update data0006 set prod_status = 6,release_date=getdate() where rKey='+cdsOut.FieldByName('RKEY').AsString
        else                                           //has not son �����
          sqlstr:='update data0006 set prod_status = 5,release_date=getdate() where rKey='+cdsOut.FieldByName('RKEY').AsString;
      end
      else
      begin
        ShowMsg('δ������������,������!',1);
        Abort;
      end;
      aqTmp1.Close;

      if not MyDataClass.ExecSql(sqlstr)then
      begin
        ShowMsg('������Ԥ�ڴ���,������ҵ��״̬ʧ�ܣ�����ϵϵͳ����Ա!',1);
        Abort;
      end;
  //5.�������ϵ�492:Waitfor_release������������ WIP_Qty����
      sqlstr:=' update data0492 set waitfor_release=IsNULL(waitfor_release,0)-'+IntToStr(aqTmp.fieldbyname('quan_sch').AsInteger-aqTmp.fieldbyname('quan_rej').AsInteger-aqTmp.fieldbyname('quan_prod').AsInteger)+
              ' ,WIP_Qty=ISNULL(WIP_QTY,0)+'+ IntToStr(aqTmp.fieldbyname('quan_sch').AsInteger-aqTmp.fieldbyname('quan_rej').AsInteger-aqTmp.fieldbyname('quan_prod').AsInteger)+
              ' FROM dbo.Data0006 INNER JOIN dbo.data0492 ON dbo.Data0006.CUT_NO = dbo.data0492.CUT_NO where Data0006.rKey= '+cdsOut.FieldByName('RKEY').AsString;
      if not MyDataClass.ExecSql(sqlstr)then
      begin
        ShowMsg('������Ԥ�ڴ���,�������ϵ���������ʧ�ܣ�����ϵϵͳ����Ա!',1);
        Abort;
      end;
  //6.�����һ����Ҫ�����Ĺ��������1,��ô,ǰ�漸����Ҫ�����Ĺ�����Ҫ��48������֮ǰ�������ת��¼
      j:= aqENGFlow.Fieldbyname('step_number').asinteger;
      if j > 1 then
      begin
        aqENGFlow.first;
        aq48.close;
        aq48.open;
        for i:= 1 to j - 1 do
        begin
          aq48.Append;
          aq48.FieldByName('wo_ptr').Asinteger:= aqTmp.fieldbyname('rkey').Asinteger ;
          aq48.FieldByName('fm_dept_ptr').Asinteger:= aqENGFlow.fieldbyname('dept_ptr').Asinteger ;
          aq48.FieldByName('step_no').AsString:= aqENGFlow.fieldbyname('step_number').AsString ;
          aqENGFlow.Next;
          aq48.FieldByName('to_dept_ptr').AsString:= aqENGFlow.fieldbyname('dept_ptr').AsString ;
          aq48.FieldByName('intime').value := sysdate;
          aq48.FieldByName('outtime').value := sysdate;
          aq48.FieldByName('qty_prod').AsString:= aqTmp.fieldbyname('quan_sch').AsString ;
          aq48.FieldByName('panels').AsString:= aqTmp.fieldbyname('panels').AsString ;
          aq48.FieldByName('empl_ptr').value := user_ptr;
          aq48.FieldByName('put_type').AsInteger:= aqTmp.fieldbyname('put_type').AsInteger  ;
          if prod_status<>4 then  //not�ⷢ
            aq48.FieldByName('wtype').AsInteger:= aqTmp.fieldbyname('wtype').AsInteger
          else
            aq48.FieldByName('wtype').AsInteger:=3;
          aq48.FieldByName('qty_reject').AsInteger:= 0 ;
          aq48.FieldByName('warehouse_ptr').AsInteger:=aqTmp.fieldbyname('WHOUSE_PTR').AsInteger;
          aq48.Post;
        end;
        aq48.UpdateBatch(arAll);
      end;
      //adoConn.CommitTrans;{20130927}
      Result:= True;
    //except
      //adoConn.RollbackTrans;{20130927}
    //end;
  end;
end;

procedure TfrmMain.N1Click(Sender: TObject);
begin
//  if MessageBox(Handle, '���������ɻָ���ȷ���ر���ҵ����', '����', MB_OKCANCEL +
//    MB_ICONQUESTION) = IDCANCEL then Abort;
//  if DM.cdsOut.FieldByName('IsSelected').AsInteger = 1 then  //�����رյ���ҵ���ѹ�ѡ,�Ȱѹ�ѡȥ��
//  begin
//    if not (DM.cdsOut.State in [dsEdit]) then DM.cdsOut.Edit;
//    DM.cdsOut.FieldByName('IsSelected').AsInteger:= 0;
//  end;
//  if not UpdateWOStatus(dm.cdsOut.FieldByName('rKey').AsInteger,1) then
//  begin
//    ShowMsg('�ر���ҵ��ʧ��!����',1);
//    Abort;
//  end
//  else
//  begin
//    ShowMsg('�����ɹ�!',1);
//    dm.cdsOutRefresh;
//  end;
end;

procedure TfrmMain.pm1Popup(Sender: TObject);
begin
//  if (strtoint(vprev) in [4]) then  //���Ȩ��4�ſ��Թر���ҵ��
//    N1.Visible:= dm.cdsOut.RecordCount > 0
//  else
//    N1.Visible:= False;
end;

function TfrmMain.IsAuth(cut_no: string): Boolean;
var
  new_no:string;
  LQry:TADOQuery;
begin
  Result:= False;
  new_no:= Copy(cut_no,1,Pos('-',cut_no))+ '0';
  LQry:= TADOQuery.Create(nil);
  try
    LQry.Connection:= DM.adoConn;
    LQry.close;
    LQry.sql.Text:='SELECT TSTATUS FROM DATA0492 WHERE CUT_NO = ' + QuotedStr(new_no);
    LQry.Open;
    if not LQry.IsEmpty then
    begin
      if (LQry.FieldByName('TSTATUS').Value = 0)
            or (LQry.FieldByName('TSTATUS').Value = 2) then Result:= True;
    end;
  finally
    LQry.free;
  end;
end;

end.
