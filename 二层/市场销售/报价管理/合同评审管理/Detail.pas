unit Detail;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, DB, Mask, DBCtrls, ADODB, Grids,//syntax,
  DBGridEh, Menus;

const sqltext = 'select CONTROL_NO_LENGTH,SEED_VALUE,SEED_FLAG,Convert(varchar(8),getdate(),112) as StrDate from data0004 where rkey=84';

type
  TfrmDetail = class(TForm)
    pnlAll: TPanel;
    pnlTop: TPanel;
    pnlTop_1: TPanel;
    pnlClient: TPanel;
    Label1: TLabel;
    DBEdit1: TDBEdit;
    pnlTools: TPanel;
    btnSave: TBitBtn;
    btnCancel: TBitBtn;
    btnPrint: TBitBtn;
    Label2: TLabel;
    DBEdit2: TDBEdit;
    Label4: TLabel;
    Label3: TLabel;
    DBEdit4: TDBEdit;
    Label5000: TLabel;
    DBEdit5: TDBEdit;
    btnLookCust: TBitBtn;
    GroupBox1: TGroupBox;
    DBEdit10: TDBEdit;
    DBEdit7: TDBEdit;
    DBEdit9: TDBEdit;
    DBEdit8: TDBEdit;
    DBEdit6: TDBEdit;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    DBMemo1: TDBMemo;
    pnlLeft: TPanel;
    pnlRight: TPanel;
    dbgDetail: TDBGridEh;
    dbgRFQParam: TDBGridEh;
    pnlDtl: TPanel;
    pnlDtlItem: TPanel;
    gbDtl: TGroupBox;
    dbgDtlItem: TDBGridEh;
    sbtnCalc: TSpeedButton;
    Label11: TLabel;
    DBEdit11: TDBEdit;
    Label12: TLabel;
    DBEdit12: TDBEdit;
    Label13: TLabel;
    DBEdit13: TDBEdit;
    Label14: TLabel;
    DBEdit14: TDBEdit;
    Label17: TLabel;
    DBEdit17: TDBEdit;
    Label18: TLabel;
    DBEdit18: TDBEdit;
    Label19: TLabel;
    DBEdit19: TDBEdit;
    Label15: TLabel;
    DBEdit15: TDBEdit;
    Label16: TLabel;
    DBEdit16: TDBEdit;
    Label20: TLabel;
    DBEdit20: TDBEdit;
    Label21: TLabel;
    DBEdit21: TDBEdit;
    Label22: TLabel;
    DBEdit22: TDBEdit;
    Label23: TLabel;
    DBEdit23: TDBEdit;
    Label24: TLabel;
    DBEdit24: TDBEdit;
    Label25: TLabel;
    DBEdit25: TDBEdit;
    Label26: TLabel;
    DBEdit26: TDBEdit;
    Label27: TLabel;
    DBEdit27: TDBEdit;
    Label28: TLabel;
    DBEdit28: TDBEdit;
    Label29: TLabel;
    DBEdit29: TDBEdit;
    Label30: TLabel;
    DBEdit30: TDBEdit;
    Label31: TLabel;
    DBEdit31: TDBEdit;
    Label32: TLabel;
    DBEdit32: TDBEdit;
    Label33: TLabel;
    DBEdit33: TDBEdit;
    pmOp: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    pmSaveItem: TPopupMenu;
    N4: TMenuItem;
    DBComboBox1: TDBComboBox;
    N5: TMenuItem;
    sbtnNotes: TSpeedButton;
    DBText1: TDBText;
    Label5: TLabel;
    DBComboBox2: TDBComboBox;
    N3: TMenuItem;
    N6: TMenuItem;
    procedure btnSaveClick(Sender: TObject);
    procedure btnCancelClick(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure sbtnCalcClick(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure dbgRFQParamDblClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure DBComboBox1DropDown(Sender: TObject);
    procedure btnLookCustClick(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N6Click(Sender: TObject);    
    procedure sbtnNotesClick(Sender: TObject);
    procedure btnPrintClick(Sender: TObject);
    procedure dbgDtlItemKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    IsPost: Byte;
    procedure Update_04(v_seed: string);  //���º�ͬ��
  public
    { Public declarations }
  end;

var
  frmDetail: TfrmDetail;

implementation

uses damo, Contract, common, Math, FindRFQ, FindCust;

{$R *.dfm}

procedure TfrmDetail.btnSaveClick(Sender: TObject);
begin
  IsPost:= 1;
  if frmContract.YY = 1 then  //����
  begin
    frmContract.OpenQuery(dm.aqTmp,[],'select 1 from data0167 where ContractNo='''+DBEdit1.Text+'''');
    if dm.aqTmp.RecordCount>0 then  //����ȡ����
    begin
      frmContract.OpenQuery(dm.aqTmp,[],sqltext);

      //���ͬ���е�������ʵ�����ڲ�ͬ,��ˮ�Ŵ�1��ʼ
      if Copy(dm.aqTmp.FieldByName('SEED_VALUE').Value,1,8)<>dm.aqTmp.FieldByName('StrDate').Value then Update_04(dm.aqTmp.FieldByName('SEED_VALUE').Value);
      DBEdit1.Text:= dm.aqTmp.FieldByName('SEED_VALUE').Value;
    end;
  end;
  dm.ADOConn.BeginTrans;
  try
    sbtnCalc.Click;
    with dm.aqMain do
    begin
      if not (State in [dsinsert, dsedit]) then Edit;
      if frmContract.YY = 1 then
        FieldByName('CreateId').AsString:= USERRKEY;
      FieldByName('LastModifyId').AsString:= USERRKEY;
      FieldByName('LastModifyDate').AsDateTime:= getsystem_date(dm.aqTmp,0);
      UpdateBatch();
    end;
    with dm.aqDetail do
    begin
      DisableControls;
      if frmContract.YY = 1 then
      begin
        First;
        while not Eof do
        begin
          if not (State in [dsEdit]) then Edit;
          FieldByName('PARAMETER_PTR').Value:= dm.aqMainRKEY.Value;
          Next;
        end;
      end;
      UpdateBatch();
      EnableControls;
    end;
    with dm.aqDtlItem do
    begin
      DisableControls;
      if frmContract.YY = 1 then
      begin
        Filter:= '';
        First;
        while not Eof do
        begin
          if not (State in [dsEdit]) then Edit;
          FieldByName('PARAMETER_PTR').Value:= dm.aqMainRKEY.Value;
          Next;
        end;
      end;
      UpdateBatch(arAllChapters);
      EnableControls;
    end;
    if frmContract.YY = 1 then Update_04(trim(DBEdit1.Text));
    dm.ADOConn.CommitTrans;
    ModalResult:= mrok;
  except
    on E:Exception do
    begin
      Showmessage(E.Message+#13+'������!');
      dm.ADOConn.RollbackTrans;
    end;   
  end;
end;

procedure TfrmDetail.btnCancelClick(Sender: TObject);
begin
  ModalResult:= mrCancel;
end;

procedure TfrmDetail.N1Click(Sender: TObject);
var
  Len, Wid, PARAM_DESC, PARAM_Value: string;
begin
  try
    Application.CreateForm(TfrmFindRFQ, frmFindRFQ);
    frmContract.OpenQuery(dm.aqFindRFQ,[DBEdit4.Text,DBEdit4.Text]);
    if frmFindRFQ.ShowModal = mrok then
    begin
      with dm.aqDetail do
      begin
        First;
        while not Eof do
        begin
          if dm.aqDetail.FieldValues['RFQNo'] = dm.aqFindRFQ.FieldValues['RFQNo'] then
          begin
            ShowMessage('����ͬ�������Ѵ��ڴ�RFQ���!');
            Abort;
          end;
          Next;
        end;
      end;
      with dm.aqDetail do
      begin
        frmContract.OpenQuery(dm.aqTmp,[dm.aqFindRFQ.FieldByName('RFQNo').AsString],
          'Select t165.*,t166.Group_Type,t166.Group_Name,t166.SEQ_NO,t166.Param_ptr,t166.Param_Value,t166.MustInput '+
          'From Data0165 t165 Left Join Data0166 t166 On t165.RKEY = t166.PARAMETER_PTR '+
          'Where RFQNo = :RFQNo ');
        if DBEdit4.Text = '' then  //����ͻ���Ϣ
        begin
          if not dm.aqFindCust.Active then
          begin
            dm.aqFindCust.Close;
            dm.aqFindCust.Open;
          end;
          dm.aqFindCust.Filter:= ' CUST_CODE = ' + '''' + dm.aqTmp.FieldByName('Cust_Id').AsString + '''';
          DBEdit4.Text:= dm.aqFindCust.FieldByName('CUST_CODE').AsString;
          DBEdit5.Text:= dm.aqFindCust.FieldByName('SALES_REP_NAME').AsString;
          DBEdit6.Text:= dm.aqFindCust.FieldByName('CUSTOMER_NAME').AsString;
          DBEdit7.Text:= dm.aqFindCust.FieldByName('BILLING_ADDRESS_1').AsString;
          DBEdit8.Text:= dm.aqFindCust.FieldByName('CONTACT_NAME_1').AsString;
          DBEdit9.Text:= dm.aqFindCust.FieldByName('CONT_PHONE_1').AsString;
          DBEdit10.Text:= dm.aqFindCust.FieldByName('FAX').AsString;
          if not (dm.aqMain.State in [dsInsert, dsEdit]) then dm.aqMain.Edit;
          dm.aqMain.FieldValues['CURR_CODE']:= dm.aqFindCust.FieldValues['CURR_CODE'];
          btnLookCust.Enabled:= False;
          dm.aqFindCust.Filter:= '';
        end;
        Append;
        frmContract.OpenQuery(dm.aqRFQParam,[dm.aqTmp.FieldByName('RKEY').AsString]);
        dm.aqRFQParam.First;

        FieldByName('Flag').AsInteger:= 1;
        if dm.aqMain.FieldByName('RKEY').AsString = '' then//�����������ͬ,���ڴ˴�֮ǰ���˼��㰴ť�����aqMainRKEYΪ��ֵ
          FieldByName('PARAMETER_PTR').AsInteger:= 0
        else
          FieldByName('PARAMETER_PTR').AsInteger:= dm.aqMain.FieldByName('RKEY').AsInteger;
        FieldByName('RKEY165').AsString:= dm.aqTmp.FieldByName('RKEY').AsString;
        FieldByName('RFQNo').AsString:= dm.aqTmp.FieldByName('RFQNo').AsString;
        FieldByName('FileName').AsString:= dm.aqTmp.FieldByName('FileName').AsString;
        FieldByName('PartsId').AsString:= dm.aqTmp.FieldByName('PartsId').AsString;
        FieldByName('POType').AsString:= dm.aqTmp.FieldByName('POType').AsString;
        while not dm.aqRFQParam.Eof do
        begin
          PARAM_DESC:= Trim(dm.aqRFQParam.FieldValues['PARAMETER_DESC']);
          PARAM_Value:= dm.aqRFQParam.FieldValues['Param_Value'];

          if PARAM_DESC = '��������' then FieldValues['Qnty']:= PARAM_Value;       //����
          if PARAM_DESC = '��ɰ��' then FieldValues['BoardThick']:= PARAM_Value; //���
          if PARAM_DESC = '����' then FieldValues['Layers']:= PARAM_Value;         //����
          if PARAM_DESC = 'SET����' then Len:= PARAM_Value;
          if PARAM_DESC = 'SET���' then Wid:= PARAM_Value;
          FieldValues['SetSize']:= Len + '*' + Wid;                                //��Ʒ�ߴ�
          if PARAM_DESC = '��������' then FieldValues['LAM2']:= PARAM_Value;       //���
          if PARAM_DESC = '���洦��ʽ' then FieldValues['SurfaceDeal']:= PARAM_Value;//����Ϳ��
          if PARAM_DESC = '�������ͭ��' then FieldValues['WCCPTH']:= PARAM_Value; //�������ͭ��
          if PARAM_DESC = '�ڲ�����ͭ��' then FieldValues['NCCPTH']:= PARAM_Value; //�ڲ�����ͭ��
          dm.aqRFQParam.Next;
        end;
        try
          FieldValues['Area']:= StrToFloat(Len) * StrToFloat(Wid)*0.01;             //���(cm2)
        except
          FieldValues['Area']:= 0;
        end;
        Post;
      end;
      with dm.aqSetItem do
      begin
        Close;
        Open;
        First;
        dm.aqDtlItem.DisableControls;
        dm.dsDtlItem.DataSet:= nil;
        while not Eof do
        begin
          with dm.aqDtlItem do
          begin
            //if not (State in[dsInsert, dsEdit]) then
            Append;
            FieldValues['PARAMETER_PTR']:= dm.aqDetail.FieldValues['PARAMETER_PTR'];
            FieldValues['RKEY165']:= dm.aqDetail.FieldValues['RKEY165'];
            FieldValues['RFQNo']:= dm.aqDetail.FieldValues['RFQNo'];
            FieldValues['Param_ptr']:= dm.aqSetItem.FieldValues['Param_ptr'];
            FieldValues['SEQ_NO']:= dm.aqSetItem.FieldValues['SEQ_NO'];
            dm.aqRFQParam.Filter:= 'Param_ptr = '+ dm.aqSetItem.FieldByName('Param_ptr').AsString;//��ȡ����ֵ
            FieldValues['Param_Value']:= dm.aqRFQParam.FieldValues['Param_Value'];    //��ȡ����ֵ
            FieldValues['Notes']:= dm.aqSetItem.FieldValues['Notes'];
            FieldValues['Add_Type']:= dm.aqSetItem.FieldValues['AddType'];
            FieldValues['Add_Value']:= 0;
            FieldValues['Add_Time']:= 0;
            Post;
          end;
          Next;
        end;
        dm.aqRFQParam.Filter:= '';
        dm.dsDtlItem.DataSet:= dm.aqDtlItem;
        dm.aqDtlItem.EnableControls;
      end;
      dm.aqDetailAfterScroll(nil);
    end;
  finally
    frmFindRFQ.Free;
  end;
end;

procedure TfrmDetail.N2Click(Sender: TObject);
begin
  if not dm.aqDetail.Active then Exit;
  if dm.aqDetail.IsEmpty then Exit;
  dm.aqDetail.Delete;
  if dm.aqDetail.RecordCount > 0 then
    btnLookCust.Enabled:= False
  else
    btnLookCust.Enabled:= True;
end;

procedure TfrmDetail.N3Click(Sender: TObject);
var
  Len, Wid, PARAM_DESC, PARAM_Value: string;
begin
  with dm.aqDetail do
  begin
    if not Active then Exit;
    if FieldByName('RFQNo').AsString <> '' then
    begin
      if not (State in[dsInsert, dsEdit]) then Edit;
      frmContract.OpenQuery(dm.aqTmp,[FieldByName('RFQNo').AsString],
        'Select t165.*,t166.Group_Type,t166.Group_Name,t166.SEQ_NO,t166.Param_ptr,t166.Param_Value,t166.MustInput '+
        'From Data0165 t165 Left Join Data0166 t166 On t165.RKEY = t166.PARAMETER_PTR '+
        'Where RFQNo = :RFQNo ');
      frmContract.OpenQuery(dm.aqRFQParam,[dm.aqTmp.FieldByName('RKEY').AsString]);
      dm.aqRFQParam.First;

      FieldByName('FileName').AsString:= dm.aqTmp.FieldByName('FileName').AsString;
      FieldByName('PartsId').AsString:= dm.aqTmp.FieldByName('PartsId').AsString;
      while not dm.aqRFQParam.Eof do
      begin
        PARAM_DESC:= Trim(dm.aqRFQParam.FieldValues['PARAMETER_DESC']);
        PARAM_Value:= dm.aqRFQParam.FieldValues['Param_Value'];

        if PARAM_DESC = '��������' then FieldValues['Qnty']:= PARAM_Value;       //����
        if PARAM_DESC = '��ɰ��' then FieldValues['BoardThick']:= PARAM_Value; //���
        if PARAM_DESC = '����' then FieldValues['Layers']:= PARAM_Value;         //����
        if PARAM_DESC = 'SET����' then Len:= PARAM_Value;
        if PARAM_DESC = 'SET���' then Wid:= PARAM_Value;
        FieldValues['SetSize']:= Len + '*' + Wid;                                //��Ʒ�ߴ�
        if PARAM_DESC = '��������' then FieldValues['LAM2']:= PARAM_Value;       //���
        if PARAM_DESC = '���洦��ʽ' then FieldValues['SurfaceDeal']:= PARAM_Value;//����Ϳ��
        if PARAM_DESC = '�������ͭ��' then FieldValues['WCCPTH']:= PARAM_Value; //�������ͭ��
        if PARAM_DESC = '�ڲ�����ͭ��' then FieldValues['NCCPTH']:= PARAM_Value; //�ڲ�����ͭ��
        dm.aqRFQParam.Next;
      end;
      try
        FieldValues['Area']:= StrToFloat(Len) * StrToFloat(Wid)*0.01;             //���(cm2)
      except
        FieldValues['Area']:= 0;
      end;
      Post;
    end;
  end;
  sbtnCalc.Click;
end;

procedure TfrmDetail.sbtnCalcClick(Sender: TObject);
var
  i,j,x,y,Z: Double;
  SavePlace: TBookmark;
  m,n: Integer;
  iSetColorTag: Boolean;
  SetColorTag: array of array of string;
  Rate: Double;
begin
  Z:= 0; n:= 0; iSetColorTag:= False;
  if not dm.aqDetail.Active then Exit;
  with dm.aqTmp do
  begin
    SQL.Clear;
    Close;
    SQL.Add('Select CURR_CODE,CURR_NAME,EXCH_RATE From Data0001');
    SQL.Add('Where CURR_CODE = ''' + DBComboBox1.Text + '''');
    Open;
  end;
  Rate:= dm.aqTmp.FieldByName('EXCH_RATE').AsFloat;
  if Rate=0 then Rate:= 1;
  SavePlace:= dm.aqDetail.getBookMark;
  try
    try
      with dm.aqDetail do
      begin
        First;
        while not Eof do
        begin
          i:= 0; j:= 0; x:= 0; y:= 0;
          if FieldByName('Flag').AsInteger = 1 then
          begin
            SetLength(SetColorTag,dm.aqDetail.RecordCount);
            for m:= 0 to High(SetColorTag) do
            begin
               SetLength(SetColorTag[m], 3);
            end;
            if dm.aqDetail.FieldByName('POType').AsInteger=0 then  //�µ����鹤�̷��Ƿ���ڱ�׼
            begin
              with dm.aqRFQParam do
              begin
                First;
                while not Eof do
                begin
                  if dm.aqRFQParam.FieldByName('PARAMETER_DESC').AsString='��������1' then
                  begin
                    SetColorTag[n][1]:= dm.aqRFQParam.FieldByName('Param_Value').AsString;
                    if SetColorTag[n][1]='��ͨ��' then SetColorTag[n][0]:= '0'
                    else
                    if SetColorTag[n][1]='��Ƶ��' then SetColorTag[n][0]:= '1'
                    else
                    if SetColorTag[n][1]='���ְ�' then SetColorTag[n][0]:= '2'
                    else
                      SetColorTag[n][0]:= '-1';
                  end;
                  if dm.aqRFQParam.FieldByName('PARAMETER_DESC').AsString='����' then
                  begin
                    if dm.aqRFQParam.FieldByName('Param_Value').AsString<>'' then
                      SetColorTag[n][2]:= dm.aqRFQParam.FieldByName('Param_Value').AsString
                    else
                      SetColorTag[n][2]:= '-1';
                  end;
                  Next;
                end;
              end;
              with dm.aqTmp do
              begin
                SQL.Clear;
                Close;
                SQL.Add('Select EngAmount,AddEngAmount,stdArea From Data0159');
                SQL.Add('Where BoardType = '+SetColorTag[n][0]);
                SQL.Add('and Layer = '+SetColorTag[n][2]);
                Open;
              end;
              if dm.aqTmp.RecordCount>0 then     
              begin
                if (dm.aqTmp.FieldByName('EngAmount').AsFloat*Rate>dm.aqDetail.FieldByName('StdEngAmount').AsFloat)
                then iSetColorTag:= True;
                if ((dm.aqTmp.FieldByName('stdArea').AsFloat<dm.aqDetail.FieldByName('StdArea').AsFloat) and
                    (dm.aqTmp.FieldByName('AddEngAmount').AsFloat*Rate>dm.aqDetail.FieldByName('StdEngPrice').AsFloat))
                then iSetColorTag:= True;
              end;
            end;
            with dm.aqDtlItem do
            begin
              First;
              while not Eof do
              begin
                case FieldByName('Add_Type').AsInteger of
                  0: i:= i + FieldByName('Add_Value').AsFloat;  //�ư�ѵ��۱����ӳ�
                  1: j:= j + FieldByName('Add_Value').AsFloat;  //�ư�ѵ��۽��ӳ�
                  2: x:= x + FieldByName('Add_Value').AsFloat;  //��ͬ��ֵ�����ӳ�
                  3: y:= y + FieldByName('Add_Value').AsFloat;  //��ͬ��ֵ���ӳ�
                end;
                Next;
              end;
            end;
            if not(State in[dsEdit]) then Edit;
            {�ư��Begin}
            FieldByName('XS_Add').AsFloat:= i;     //ϵ���ӳ�
            FieldByName('Price_Add').AsFloat:= j;  //���ۼӳ�
            FieldByName('AfterPrice').AsFloat:=    //�ӳɺ󵥼�= ��׼����*(1+���۱����ӳ�)+���۽��ӳ�
                 FieldByName('StandardPrice').AsFloat * (1 + i) + j;
            FieldByName('Price').AsFloat:=         //�۸�(Set)=�ӳɺ󵥼�*���(set)
                 FieldByName('AfterPrice').AsFloat * FieldByName('Area').AsFloat;
            FieldByName('MakeAmount').AsFloat:=    //�ư��=�۸�(Set)*����
                 FieldByName('Price').AsFloat * FieldByName('Qnty').AsFloat;
            {�ư��End}

            {���̷�Begin}
            if (FieldByName('POType').AsInteger=0) or (FieldByName('POType').AsInteger=1)or(FieldByName('POType').AsInteger=2) then  //��������=�µ�
            begin
              if FieldByName('Area').AsFloat > FieldByName('StdArea').AsFloat then
                FieldByName('EngAmount').AsFloat:=       //���̷�=��׼���̷�+��׼�ӳɵ���*�������
                     FieldByName('StdEngAmount').AsFloat + FieldByName('StdEngPrice').AsFloat *
                     (FieldByName('Area').AsFloat - FieldByName('StdArea').AsFloat)
              else
                FieldByName('EngAmount').AsFloat:= FieldByName('StdEngAmount').AsFloat;
            end
            else
              FieldByName('EngAmount').AsFloat:= 0;
            {���̷�End}

            {���ӳ�(��������)Begin}
            FieldByName('Add_Percent').AsFloat:= x;      //�������ӳ�
            FieldByName('Add_TotalAmount').AsFloat:= y;  //�����ֵ�ӳ�

            FieldByName('TotalAmount').AsFloat:=         //�ۿ�ǰ�ܽ��
              (FieldByName('MakeAmount').AsFloat + FieldByName('EngAmount').AsFloat +
              FieldByName('FLAmount').AsFloat + FieldByName('TestAmount').AsFloat +
              FieldByName('GoldFingerAmount').AsFloat + FieldByName('UrgentAmount').AsFloat + y)*(1+x);

            FieldByName('OtherAmount').AsFloat:=         //��������(�����ֵ�ӳ���������ӳ�)= �ۿ�ǰ�ܽ��-(�ư��+���̷�+���ַ�+���Է�+����ָ��+�Ӽ���)
                 FieldByName('TotalAmount').AsFloat -
                 (FieldByName('MakeAmount').AsFloat + FieldByName('EngAmount').AsFloat+
                 FieldByName('FLAmount').AsFloat + FieldByName('TestAmount').AsFloat+
                 FieldByName('GoldFingerAmount').AsFloat + FieldByName('UrgentAmount').AsFloat);

            FieldByName('AftDiscountAmount').AsFloat:=   //�ۿۺ��ܽ��
                 FieldByName('TotalAmount').AsFloat - FieldByName('Discount').AsFloat;
            {���ӳ�(��������)End}

            Z:= Z + FieldByName('AftDiscountAmount').AsFloat;  //�����ܽ��
            Post;
            inc(n);
          end;
          Next;
        end;
      end;
      with dm.aqMain do
      begin
        if not (State in[dsInsert, dsEdit]) then Edit;
        FieldByName('ContractAmt').AsFloat:= Z;
        if iSetColorTag then FieldByName('ColorTag').AsInteger:= 1
        else FieldByName('ColorTag').AsInteger:= 0;
        Post;
      end;
      dm.aqDetail.GotoBookmark(SavePlace);
    except
      on E:Exception do
      begin
        ShowMessage(E.Message);
        Abort;
      end;
    end;
  finally
    dm.aqDetail.FreeBookmark(SavePlace);
  end;
end;

procedure TfrmDetail.N4Click(Sender: TObject);
begin
  if MessageDlg('�ò�����������е�Ĭ�ϼӼ���Ŀ,'+#13+#13+'�Ƿ����?',
                mtWarning, [mbYes, mbNo], 0) = mrYes then
  begin
    dm.ADOConn.BeginTrans;
    try
      frmContract.OpenQuery(dm.aqTmp,[],'Truncate Table Data0170',1);
      with dm.aqDtlItem do
      begin
        First;
        while not Eof do
        begin
          with dm.acAddModel do
          begin
            Parameters.ParamByName('Param_ptr').Value:= dm.aqDtlItemParam_ptr.Value;
            Parameters.ParamByName('SEQ_NO').Value:= dm.aqDtlItemSEQ_NO.Value;
            Parameters.ParamByName('Add_Type').Value:= dm.aqDtlItemAdd_Type.Value;
            Parameters.ParamByName('Notes').Value:= dm.aqDtlItemNotes.Value;
            Execute;
          end;
          Next;
        end;
      end;
      dm.ADOConn.CommitTrans;
      ShowMessage('����Ĭ�ϼӼ���Ŀ�ɹ�!');
    except
      dm.ADOConn.RollbackTrans;
      ShowMessage('����Ĭ�ϼӼ���Ŀʧ��!');
    end;
  end;
end;

procedure TfrmDetail.dbgRFQParamDblClick(Sender: TObject);
var
  i: Integer;
begin
  if frmContract.YY = 3 then Exit;
  if not dm.aqRFQParam.Active then Exit;
  if dm.aqRFQParam.IsEmpty then Exit;
  if not dm.aqDetail.Active then Exit;
  if not dm.aqDtlItem.Active then Exit;
  i:= 0;

  with dm.aqDtlItem do
  begin
    First;
    while not Eof do
    begin
      if FieldByName('Param_ptr').Value = dm.aqRFQParam.FieldByName('Param_ptr').Value then
      begin
        ShowMessage('�üӼ���Ŀ�Ѵ���!');
        Abort;
      end;
      if i < FieldByName('SEQ_NO').Value then
        i:= FieldByName('SEQ_NO').Value;  //ȡ������+1
      Next;
    end;
  end;
  Inc(i);

  //����¼Ӽ���Ŀ
  with dm.aqDtlItem do
  begin
    if not (State in [dsInsert]) then Insert;
    FieldByName('PARAMETER_PTR').Value:= dm.aqDetail.FieldByName('PARAMETER_PTR').Value;
    FieldByName('RKEY165').Value:= dm.aqDetail.FieldByName('RKEY165').Value;
    FieldByName('RFQNo').Value:= dm.aqDetail.FieldByName('RFQNo').Value;
    FieldByName('Param_ptr').Value:= dm.aqRFQParam.FieldByName('Param_ptr').Value;
    FieldByName('SEQ_NO').Value:= i;
    FieldByName('Param_Value').Value:= dm.aqRFQParam.FieldByName('Param_Value').Value;
    FieldByName('Notes').Value:= '';
    FieldByName('Add_Type').Value:= 0;
    FieldByName('Add_Value').Value:= 0;
    FieldByName('Add_Time').Value:= 0;
    Post;
  end;
end;

procedure TfrmDetail.FormActivate(Sender: TObject);
var
  i: Byte;
begin
  if frmContract.YY = 1 then  //����
  begin
    frmContract.OpenQuery(dm.aqTmp,[],sqltext);
    frmContract.OpenQuery(dm.aqMain,['0']);
    dm.aqMain.Append;
    dm.aqMain.FieldValues['RKEY']:= 0;
    //���ͬ���е�������ʵ�����ڲ�ͬ,��ˮ�Ŵ�1��ʼ
    if Copy(dm.aqTmp.FieldByName('SEED_VALUE').Value,1,8)<>dm.aqTmp.FieldByName('StrDate').Value
    then Update_04(dm.aqTmp.FieldByName('SEED_VALUE').Value);
      
    DBEdit1.Text:= dm.aqTmp.FieldByName('SEED_VALUE').Value;
  end;
  if frmContract.YY = 2 then  //�༭
  begin
    if not (dm.aqMain.State in [dsInsert, dsEdit]) then dm.aqMain.Edit;
    if not (dm.aqDetail.State in [dsInsert, dsEdit]) then dm.aqDetail.Edit;
    if not (dm.aqDtlItem.State in [dsInsert, dsEdit]) then dm.aqDtlItem.Edit;
  end;
  
  for i:= 0 to pmOp.Items.Count - 1 do
  begin
    if pmOp.Items[i].Tag<>1 then
      pmOp.Items[i].Visible:= frmContract.YY <> 3;
  end;
  for i:= 0 to pmSaveItem.Items.Count - 1 do
    pmSaveItem.Items[i].Visible:= frmContract.YY <> 3;

  if dm.aqDetail.RecordCount > 0 then
    btnLookCust.Enabled:= False
  else
    btnLookCust.Enabled:= True;
end;

procedure TfrmDetail.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if IsPost = 1 then Exit;
  if frmContract.YY <> 3 then
  begin
    if messagedlg('��ȷ���������˳���?', mtconfirmation, [mbyes, mbno],0) = mryes then
    begin
      if dm.aqMain.State in [dsInsert, dsEdit] then dm.aqMain.Cancel;
      if dm.aqDetail.State in [dsInsert, dsEdit] then dm.aqDetail.Cancel;
      if dm.aqDtlItem.State in [dsInsert, dsEdit] then dm.aqDtlItem.Cancel;
      self.ModalResult:= mrCancel;
    end
    else
      CanClose:= False;
  end;
end;

procedure TfrmDetail.Update_04(v_seed: string);
var
  i,v_length:integer;
  v_last,new_seed,new_begin,old_begin:string;
begin
  old_begin:= Copy(v_seed,1,8);
  v_seed:= Copy(v_seed,9,Length(v_seed)-8);  //ȥ��ǰ�������
  frmContract.OpenQuery(dm.aqTmp,[],sqltext);
  new_begin:= dm.aqTmp.FieldByName('StrDate').Value;
  v_length := length(v_seed);

  if old_begin <> new_begin then
  begin
    for i:= v_length-1 downto 1 do
    begin
      new_seed:= new_seed + '0';
    end;
    new_seed:= new_begin + new_seed + '1';    //������ڲ�ͬ,��ˮ�������¿�ʼ
    dm.aqTmp.Edit;
    dm.aqTmp.FieldByName('SEED_VALUE').Value := new_seed;
    dm.aqTmp.Post;
  end
  else
  begin
    for i := v_length downto 1 do
    if not (v_seed[i] in ['0'..'9']) then   //�����������
    begin
      v_last:= floattostr(power(10,v_length-1)+strtofloat(copy(v_seed,i+1,v_length-i))+1); //��׺��1
      new_seed:= new_begin + copy(v_seed,1,i) + copy(v_last,i+1,v_length-i);
      dm.aqTmp.Edit; //ʹǰ׺�����׺��1
      dm.aqTmp.FieldByName('SEED_VALUE').Value := new_seed;
      dm.aqTmp.Post;
      break;
    end
    else
    if i=1 then //�����һλ��Ȼ������
    begin
      v_last := floattostr(power(10,v_length)+strtofloat(v_seed)+1);
      new_seed := new_begin + copy(v_last,2,v_length);
      dm.aqTmp.Edit;
      dm.aqTmp.FieldByName('SEED_VALUE').Value := new_seed;
      dm.aqTmp.Post;
    end;
  end;
end;

procedure TfrmDetail.DBComboBox1DropDown(Sender: TObject);
begin
  frmContract.OpenQuery(dm.aqTmp,[],'Select CURR_CODE+'''+'_'+'''+CURR_NAME As CURR From Data0001');
  dm.aqTmp.First;
  DBComboBox1.Items.Clear;
  while not dm.aqTmp.Eof do
  begin
    DBComboBox1.Items.Add(dm.aqTmp.FieldByName('CURR').Value);
    dm.aqTmp.Next;
  end;
end;

procedure TfrmDetail.btnLookCustClick(Sender: TObject);
begin
  try
    Application.CreateForm(TfrmFindCust, frmFindCust);
    frmContract.OpenQuery(dm.aqFindCust,[]);
    with frmFindCust do
    begin
      rdgCondition.Visible:= True;
      Label1.Caption:= '�ͻ�����';
      DBGridEh1.Visible:= True;
      DBGridEh1.Align:= alClient;
      DBGridEh2.Visible:= False;
      if ShowModal = mrok then
      begin
        DBEdit4.Text:= dm.aqFindCust.FieldByName('CUST_CODE').AsString;
        DBEdit5.Text:= dm.aqFindCust.FieldByName('SALES_REP_NAME').AsString;
        DBEdit6.Text:= dm.aqFindCust.FieldByName('CUSTOMER_NAME').AsString;
        DBEdit7.Text:= dm.aqFindCust.FieldByName('BILLING_ADDRESS_1').AsString;
        DBEdit8.Text:= dm.aqFindCust.FieldByName('CONTACT_NAME_1').AsString;
        DBEdit9.Text:= dm.aqFindCust.FieldByName('CONT_PHONE_1').AsString;
        DBEdit10.Text:= dm.aqFindCust.FieldByName('FAX').AsString;
        if not (dm.aqMain.State in [dsInsert, dsEdit]) then dm.aqMain.Edit;
        dm.aqMain.FieldByName('CURR_CODE').Value:= dm.aqFindCust.FieldByName('CURR_CODE').Value;
      end;
    end;
  finally
    frmFindCust.Free;
  end;
end;

procedure TfrmDetail.N5Click(Sender: TObject);
begin
  if not dm.aqDtlItem.Active then Exit;
  if dm.aqDtlItem.IsEmpty then Exit;
  dm.aqDtlItem.Delete;
end;

procedure TfrmDetail.N6Click(Sender: TObject);
begin
  frmContract.UseReport(dm.aqMainRKEY.Value, 1, dm.aqDetailRFQNo.Value,1);
end;

procedure TfrmDetail.sbtnNotesClick(Sender: TObject);
begin
  MessageDlg('*1. ��ɫ���岿��Ϊ�ֶ�����,��ɫ���岿��Ϊϵͳ����'+#13+
   '*2. Flagδ��ѡ�Ĳ�����'+#13+
   '*3. RFQ�����ж�������Ϊ�µ��Ĳżƹ��̷�,��Ͷ���븴Ͷ��������ƹ��̷�'+#13+#13+

   'a.  �ư�� = �۸�(Set)*��Ʒ����'+#13+
   'a1. �۸�(Set)=�ӳɺ󵥼�*���(set)'+#13+
   'a2. �ӳɺ󵥼�= ��׼����*(1+ϵ���ӳ�)+���ۼӳ�'+#13+#13+

   'b.  ���̷� = ��׼���̷�+��׼�ӳɵ���*�������'+#13+
   'b1. �������=��� - �ӳ��������'+#13+#13+

   'c.  �������� = ��ͬ��ֵ���ӳ�+��ͬ��ֵ�����ӳ�'+#13+#13+

   'd.  �ۿ�ǰ�ܽ�� = �ư��+���̷�+���ַ�+���Է�+��������+����ָ��+�Ӽ���'+#13+
   'd1. �ۿۺ��ܽ�� = �ۿ�ǰ�ܽ�� - �ۿ۽��'+#13+#13+
   
   '*   ���Ͻ���Ϊ(��˰)',    mtInformation, [mbOK], 0);
end;

procedure TfrmDetail.btnPrintClick(Sender: TObject);
begin
  frmContract.UseReport(dm.aqMainRKEY.Value, 1);
end;

procedure TfrmDetail.dbgDtlItemKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key = 45 then abort;  //Insert
  if ((key = 40) and ((Sender as TDBGridEh).DataSource.DataSet.RecNo =
                      (Sender as TDBGridEh).DataSource.DataSet.RecordCount)) then
    abort;  //��
  //if ((key = 46) and (ssCtrl in shift)) then abort;  //Ctrl+Delete
end;

end.
