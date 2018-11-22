unit VMIrucang_mod33;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uBaseEditFrm,ucommfunc,uBaseSinglePickListFrm,uLookupDM,
  Vcl.StdCtrls, Vcl.Buttons, Vcl.ExtCtrls, Vcl.Grids, Data.DB, Datasnap.DBClient,
  Vcl.ComCtrls;

type
  LgetRefreshClick=procedure (cds:TClientDataSet) of object;
  TfrmVMIrucang_mod33 = class(TfrmBaseEdit)
    Panel1: TPanel;
    Label4: TLabel;
    Edit1: TEdit;
    BitBtn3: TBitBtn;
    Label1: TLabel;
    Label5: TLabel;
    Edit2: TEdit;
    Edit3: TEdit;
    Label2: TLabel;
    Label12: TLabel;
    Label6: TLabel;
    Label11: TLabel;
    Label9: TLabel;
    Label3: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    Edit8: TEdit;
    Edit9: TEdit;
    Edit10: TEdit;
    Edit11: TEdit;
    Label10: TLabel;
    Edit12: TEdit;
    Label13: TLabel;
    Label14: TLabel;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    Panel2: TPanel;
    StringGrid1: TStringGrid;
    CBloc: TComboBox;
    ComboBox3: TComboBox;
    cds456: TClientDataSet;
    cds22: TClientDataSet;
    cds04: TClientDataSet;
    cds16: TClientDataSet;
    cds17: TClientDataSet;
    dtpReqDate: TDateTimePicker;
    cds724: TClientDataSet;
    cds149: TClientDataSet;
    cds134: TClientDataSet;
    cds04_724: TClientDataSet;
    cds04_456: TClientDataSet;
    Label15: TLabel;
    procedure btnCloseClick(Sender: TObject);
    procedure StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure BitBtn3Click(Sender: TObject);
    procedure CBlocExit(Sender: TObject);
    procedure CBlocKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ComboBox3Exit(Sender: TObject);
    procedure ComboBox3KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnSaveClick(Sender: TObject);
    procedure StringGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure StringGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure StringGrid1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
    function find_rkey134():boolean;//����������¼����
    function find_shuliang_Error(TType:Integer;Rkey456:Integer):Boolean;
    function IfWarehouse: Boolean;
    function IfDateNow: Boolean;//�༭��������Ƿ����仯
    procedure UpdatePrice(ARow:Integer;ASupp,AInvt:string);
  public
    refresh:LgetRefreshClick;
    FEditType: Integer;//�˵�
    str_list:TStringList;
    LGRName456,LGRName724:string; //04���º�
    NewDate:TDateTime;
    { Public declarations }
    function update04(table_name:string;var LsName:string;cds:TClientDataSet):string;
    procedure init;
    procedure get_location;
    procedure GetData(ARkey,ARkey724: string);
    function Power(x, y : extended) : extended;
  end;

var
  frmVMIrucang_mod33: TfrmVMIrucang_mod33;

implementation

{$R *.dfm}

uses pasVMIpiciMX;

function TfrmVMIrucang_mod33.IfDateNow: Boolean;
var i:Integer;
begin
  Result:=False;
  for I := 1 to StringGrid1.RowCount-1 do
  begin
    if (Trim(StringGrid1.Cells[str_list.IndexOfName('��������'),i])<>'') and (strtofloat(StringGrid1.Cells[str_list.IndexOfName('��ǰ����'),i])>0) and (StrToDateTime(StringGrid1.Cells[str_list.IndexOfName('��������'),i])>gFunc.GetSvrDateTime)  then
    begin
      Result:=True;
      Break;
    end;
  end;
end;

function TfrmVMIrucang_mod33.IfWarehouse: Boolean;//�ж��������Ĳֿⲻ������
var i:Integer;
begin
  Result:=False;
  for I := 1 to StringGrid1.RowCount-1 do
  begin
    if (StringGrid1.Cells[str_list.IndexOfName('�ֿ�λ��'),i]='') and (strtofloat(StringGrid1.Cells[str_list.IndexOfName('��ǰ����'),i])>0) then
    begin
      Result:=True;
      Break;
    end;
  end;
  for i:=1 to StringGrid1.RowCount-1 do
  begin
    if (strtofloat(StringGrid1.Cells[str_list.IndexOfName('��ǰ����'),i])>0) then
      break//������һ���������
    else
    if (i=StringGrid1.RowCount-1) then Result:=true;
  end;
end;

procedure TfrmVMIrucang_mod33.BitBtn3Click(Sender: TObject);
var
  i,j:Integer;
  LSelType:Integer;
begin
  inherited;
  frm_VMIpiciMX := Tfrm_VMIpiciMX.Create(Self);
  frm_VMIpiciMX.GetData;
  if frm_VMIpiciMX.ShowModal = mrOk then
  begin
  //���StringGrid
    for j :=StringGrid1.RowCount  downto 1  do
    begin
      for i:=0 to StringGrid1.ColCount do
      begin
        StringGrid1.Cells[i,j]:='';
      end;
      stringgrid1.rowcount := stringgrid1.rowcount - 1;
    end;
    stringgrid1.rowcount:=2;
  //���VMI��ϸ
    Edit1.Text:=frm_VMIpiciMX.cdsMain.FieldByName('GRN_NUMBER').AsString;
    edit5.Text:=frm_VMIpiciMX.cdsMain.FieldByName('DELIVER_NUMBER').AsString;
    edit6.Text:=frm_VMIpiciMX.cdsMain.FieldByName('ship_BY').AsString;
    edit7.Text:=frm_VMIpiciMX.cdsMain.FieldByName('PO_NUMBER').AsString;
    Edit7.Tag:=frm_VMIpiciMX.cdsMain.FieldByName('PO_PTR').AsInteger;//70Rkey
    edit8.Text:=frm_VMIpiciMX.cdsMain.FieldByName('CURR_NAME').AsString;
    Edit8.Tag:=frm_VMIpiciMX.cdsMain.FieldByName('currency_ptr').AsInteger; //01rkey
    edit9.Text:=frm_VMIpiciMX.cdsMain.FieldByName('EXCH_RATE').AsString;
    Edit10.Text:=frm_VMIpiciMX.cdsMain.FieldByName('CODE').AsString;
    Edit10.Tag:=frm_VMIpiciMX.cdsMain.FieldByName('SUPP_PTR').AsInteger;//��Ӧ��23rkey
    edit11.Text:=frm_VMIpiciMX.cdsMain.FieldByName('WAREHOUSE_CODE').AsString;
    Edit11.Tag:=frm_VMIpiciMX.cdsMain.FieldByName('WAREHOUSE_PTR').AsInteger;//����15Rkey
    Edit12.Text:=frm_VMIpiciMX.cdsMain.FieldByName('REF_NUMBER').AsString;
    Label13.Caption:=frm_VMIpiciMX.cdsMain.FieldByName('SUPPLIER_NAME').AsString;
    Label14.Caption:=frm_VMIpiciMX.cdsMain.FieldByName('WAREHOUSE_NAME').AsString;
    if (frm_VMIpiciMX.cdsMain.FieldByName('SECOND_WHSE_PTR').AsString='') then
      LSelType:=0
    else
      LSelType:= frm_VMIpiciMX.cdsMain.FieldByName('SECOND_WHSE_PTR').Value;
    i:=0;
  //���StringGrid1
    if not frm_VMIpiciMX.cdsDetail.IsEmpty then
    begin
      frm_VMIpiciMX.cdsDetail.First;
      while not frm_VMIpiciMX.cdsDetail.Eof do
      begin
        for j := 0 to str_list.Count -1 do
        begin
          if (frm_VMIpiciMX.cdsDetail.FieldByName(str_list.Values[StringGrid1.Cells[j,0]]).IsNull = False) then
            StringGrid1.Cells[j,i+1] := frm_VMIpiciMX.cdsDetail.FieldByName(str_list.Values[StringGrid1.Cells[j,0]]).Value;
        end;
        StringGrid1.Cells[str_list.IndexOfName('�ֿ�λ��'),i+1] :='';
        StringGrid1.Cells[str_list.IndexOfName('��ϸλ��'),i+1] :='';
        i:=i+1;
        //add by zsp 2017-03-27  begin              //VMI��ʱ���ļ۸�
//        ShowMessage(IntToStr(str_list.IndexOfName('VMI���۸�(��˰)')));
        StringGrid1.Cells[str_list.IndexOfName('VMI���۸�(��˰)'),i] :=frm_VMIpiciMX.cdsDetail.FieldByName('TAX_PRICE').AsString;
        if LSelType = 0 then
        begin
          UpdatePrice(i,frm_VMIpiciMX.cdsMain.FieldByName('SUPP_PTR').AsString
                      ,frm_VMIpiciMX.cdsDetail.FieldByName('inventory_ptr').AsString);
        end;
        // end

        StringGrid1.RowCount:=StringGrid1.RowCount+1;
        frm_VMIpiciMX.cdsDetail.Next;
      end;
    end;
    StringGrid1.RowCount:=StringGrid1.RowCount-1;
    get_location;
  end;
end;

procedure TfrmVMIrucang_mod33.btnCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmVMIrucang_mod33.btnSaveClick(Sender: TObject);
var Lcds:TClientDataSet;
    LsName456,LsName724:string;
    LPostData: OleVariant;
    i,LiTmp:Integer;
    Lrk134s,Lsql134:string;
    Lstr17,Lsq17:string;
    LfSL22,LfSL22r:Double;
begin
  inherited;
  NewDate:=gFunc.GetSvrDateTime;
  Lcds:=TClientDataSet.Create(Self);
  try
    Lrk134s:='';
    Lstr17:='';
    LiTmp:=0;
    if (Trim(Edit2.Text)='') then
    begin
      showmessage('��ֵ���Ϊ�գ�����ϵ����Ա!');
      exit;
    end;
    if (Trim(Edit3.Text)='') then
    begin
      showmessage('VMI���ֵ���Ϊ�գ�����ϵ����Ա!');
      exit;
    end;
    //�������Ĳֿⲻ�ܶ�Ϊ��
    if IfWarehouse() then
    begin
      showmessage('������Ҫһ����ּ�¼���������λ��!');
      exit;
    end;
    if IfDateNow() then
    begin
      ShowMessage('������һ����ּ�¼�������ڴ��ڵ�ǰ����,������Ҫ��,���޸������������');
      Exit;
    end;
    case FEditType of
      0:  //����
      begin
        if find_rkey134 then
        begin
          ShowMessage('������ֲ��ɹ�������¼�����仯!������ѡ���淢��');
          exit;
        end;
        gSvrIntf.IntfGetDataBySql('select * from data0724 where GON_NUMBER = ''' + Trim(Edit3.Text)+'''',cds724);
        if not cds724.IsEmpty then
        begin
          if messagedlg('�������ظ�,�����ж�̨�����ͬʱ����,�Ƿ��Զ����±��?',mtConfirmation,[mbYes,mbNo],0)=mrYes  then
          begin
            LGRName724:=update04('data0724',LsName724,cds04_724);
            Edit3.Text:=LsName724;
          end;
        end;
        gSvrIntf.IntfGetDataBySql('select * from data0456 where GRN_NUMBER = ''' + Trim(Edit2.Text)+'''',cds456);
        if not cds456.IsEmpty then
        begin
          if messagedlg('��ֵ����ظ�,�����ж�̨�����ͬʱ����,�Ƿ��Զ����±��?',mtConfirmation,[mbYes,mbNo],0)=mrYes  then
          begin
            LGRName456:=update04('data0456',LsName456,cds04_456);
            Edit2.Text:=LsName456;
          end;
        end;

        for I := 1 to StringGrid1.RowCount-1 do
        begin
          if (StrToFloat(StringGrid1.Cells[str_list.IndexOfName('��ǰ����'),i])>0) then
          begin
            Lrk134s:=Lrk134s+StringGrid1.Cells[str_list.IndexOfName('134rkey'),i]+',';
            if (StringGrid1.Cells[str_list.IndexOfName('17rkey'),i]<>'') then
            begin
              Lstr17:=Lstr17+StringGrid1.Cells[str_list.IndexOfName('17rkey'),i]+',';
            end;
            LiTmp:=LiTmp+1;
          end;
        end;
        Lsql134:='select * from data0134 where Rkey in (' + Lrk134s+'-1)';
        Lsq17:='select * from data0017 where rkey in (' + Lstr17+'-1)';
        if not gSvrIntf.IntfGetDataBySqlArr(VarArrayOf([Lsq17,Lsql134]),[cds17,cds134])then
        begin
          ShowMessage('ȡ������ʧ��');
          Exit;
        end;
//        gSvrIntf.IntfGetDataBySql('select * from data0134 where Rkey in (' + Lrk134s+'-1)',cds134);

        cds724.Append;
        cds724.FieldByName('GON_NUMBER').Value:=Trim(Edit3.Text);//���ֵ���
        cds724.FieldByName('warehouse_ptr').Value:=Edit11.Tag;//����
        cds724.FieldByName('TTYPE').Value:=1; //1���ϳ���
        cds724.FieldByName('CREATE_BY').Value:=gVar.rkey05; //������Ա
        cds724.FieldByName('CREATE_DATE').Value:=NewDate; //��������
        cds724.FieldByName('REF_NUMBER').Value:=Trim(Edit12.Text);//��ע
        cds724.FieldByName('RECD_BY').Value:=gVar.rkey05;//�˻���Ա
        cds724.FieldByName('supplier_ptr').Value:=Edit10.Tag; //��Ӧ��
        cds724.FieldByName('status').Value:=0;
        cds724.FieldByName('idkey').Value := gFunc.CreateIDKey;
        cds724.Post;

        //����456
        cds456.append;
        cds456.FieldByName('GRN_NUMBER').Value:=Trim(Edit2.Text);//��ֵ���
        cds456.FieldByName('DELIVER_NUMBER').Value:=Trim(Edit5.Text); //�ͻ�����
        cds456.FieldByName('warehouse_ptr').Value:=Edit11.Tag;//15Rkey
        cds456.FieldByName('SUPP_PTR').Value:=Edit10.Tag;//23Rkey
        cds456.FieldByName('currency_ptr').Value:=Edit8.Tag;//01Rkey
        cds456.FieldByName('exch_rate').Value:=StrToFloat(Edit9.Text); //����
        if Edit7.Tag = 0 then cds456.FieldByName('PO_PTR').AsVariant := null
        else cds456.FieldByName('PO_PTR').Value:=Edit7.Tag; //70Rkey
        cds456.FieldByName('TTYPE').Value:=5;//VMI
        cds456.FieldByName('CREATE_DATE').Value:=NewDate; //��������(��)
        cds456.FieldByName('CREATE_BY').Value:=gVar.rkey05;//
        cds456.FieldByName('ship_DATE').Value:=dtpReqDate.DateTime; //�ͻ�����(��)
        cds456.FieldByName('ship_BY').Value:=Trim(Edit6.Text);
        cds456.FieldByName('REF_NUMBER').Value:=Trim(Edit12.Text);//��ע
        cds456.FieldByName('STATUS').Value:=1;  //δ�ύ
        cds456.FieldByName('idkey').Value := gFunc.CreateIDKey;
        if checkbox2.Checked then
          cds456.FieldByName('PRINTED').Value:='Y'
        else
          cds456.FieldByName('PRINTED').Value:='N';
        cds456.FieldByName('D724_IDKey').Value:=cds724.FieldByName('idkey').Value;
        cds456.Post;

        //����149
        for I := 1 to StringGrid1.RowCount-1 do
        begin
          if (StrToFloat(StringGrid1.Cells[str_list.IndexOfName('��ǰ����'),i])>0) then
          begin
            cds22.Append;
            cds22.FieldByName('INVENTORY_PTR').Value:=StringGrid1.Cells[str_list.IndexOfName('17rkey'),i]; //ԭ����ָ��0017
            if StringGrid1.Cells[str_list.IndexOfName('71rkey'),i] = '' then cds22.FieldByName('SOURCE_PTR').AsVariant := null
            else cds22.FieldByName('SOURCE_PTR').Value:=StringGrid1.Cells[str_list.IndexOfName('71rkey'),i]; //data0071.rkey
            cds22.FieldByName('LOCATION_PTR').Value:=StringGrid1.Cells[str_list.IndexOfName('16rkey'),i]; //�ֿ�λ��data0016
            cds22.FieldByName('LOCATION_PTR_FROM').Value:=StringGrid1.Cells[str_list.IndexOfName('02Rkey'),i]; //�����λ02
            cds22.FieldByName('QUANTITY').Value:=StringGrid1.Cells[str_list.IndexOfName('��ǰ����'),i]; //�ѽ��յ�����
            cds22.FieldByName('QUAN_ON_HAND').Value:=StringGrid1.Cells[str_list.IndexOfName('��ǰ����'),i];//�ֳ�������
            cds22.FieldByName('tax_price').Value:=StringGrid1.Cells[str_list.IndexOfName('�۸�˰'),i];//�۸�˰
            cds22.FieldByName('PRICE').Value:=StrToCurr(StringGrid1.Cells[str_list.IndexOfName('�۸�˰'),i])/(1+strtofloat(StringGrid1.Cells[str_list.IndexOfName('˰��'),i])*0.01); // �۸񲻺�˰
            cds22.FieldByName('TAX_2').Value:=StringGrid1.Cells[str_list.IndexOfName('˰��'),i]; //˰��
            cds22.FieldByName('BARCODE_ID').Value:=StringGrid1.Cells[str_list.IndexOfName('��ע'),i];//�ر�Ҫ��
            cds22.FieldByName('spec_place').Value:=StringGrid1.Cells[str_list.IndexOfName('��ϸλ��'),i]; //��ϸλ��
            if Trim(StringGrid1.Cells[str_list.IndexOfName('��Ч��'),i]) = '' then  cds22.FieldByName('EXPIRE_DATE').AsVariant:=null
            else cds22.FieldByName('EXPIRE_DATE').Value:=StrToDate(StringGrid1.Cells[str_list.IndexOfName('��Ч��'),i]);//��Ч��(��)
//            cds22.FieldByName('EXPIRE_DATE').Value:=StrToDate(StringGrid1.Cells[str_list.IndexOfName('��Ч��'),i]);//��Ч��(��)
            cds22.FieldByName('rohs').Value:=StringGrid1.Cells[str_list.IndexOfName('������ʶ'),i]; //����ROHS
            cds22.FieldByName('TDATE').Value:=StringGrid1.Cells[str_list.IndexOfName('��������'),i]; //��������
            cds22.FieldByName('D456_IDKey').Value:=cds456.FieldByName('idkey').Value;
            cds22.FieldByName('TTYPE').Value:=3;//����PO�ջ�
            cds22.FieldByName('STOCK_BASE').Value:=StrToFloat(StringGrid1.Cells[str_list.IndexOfName('���ϵ���KG'),i]); //��������
            cds22.FieldByName('cust_decl').Value:=StringGrid1.Cells[str_list.IndexOfName('���ص���'),i];//���ص���
            cds22.FieldByName('QUAN_RTNED_FM_FACT').Value:=StringGrid1.Cells[str_list.IndexOfName('VMI���۸�(��˰)'),i];//VMI���ʱ�ļ۸�
            cds22.FieldByName('D0134_PTR').Value:=StringGrid1.Cells[str_list.IndexOfName('134rkey'),i];//134Rkey
            cds22.Post;

          //�޸�17�ܿ����
            cds17.Filtered:=False;
            cds17.Filter:='';
            cds17.Filter:='Rkey ='+StringGrid1.Cells[str_list.IndexOfName('17rkey'),i];
            cds17.Filtered:=True;
            if not cds17.IsEmpty then
            begin
              cds17.Edit;
              cds17.FieldByName('QUAN_ON_HAND').Value:=cds17.FieldByName('QUAN_ON_HAND').Value + cds22.FieldByName('QUANTITY').Value; //17�ܿ����
              cds17.Post;
            end;

            cds149.Append;
            cds149.FieldByName('D0134_PTR').Value:=StringGrid1.Cells[str_list.IndexOfName('134rkey'),i];
            cds149.FieldByName('INVENTORY_PTR').Value:=StringGrid1.Cells[str_list.IndexOfName('17rkey'),i];
            cds149.FieldByName('QUANTITY').Value:=StringGrid1.Cells[str_list.IndexOfName('��ǰ����'),i];
            cds149.FieldByName('tax_price').Value:=StringGrid1.Cells[str_list.IndexOfName('�۸�˰'),i];
            cds149.FieldByName('TAX_2').Value:=StringGrid1.Cells[str_list.IndexOfName('˰��'),i];
            cds149.FieldByName('D724_IDKey').Value:=cds724.FieldByName('idkey').Value;
            cds149.Post;

            cds134.Filtered:=False;
            cds134.Filter:='';
            cds134.Filter:='Rkey ='+StringGrid1.Cells[str_list.IndexOfName('134rkey'),i];
            cds134.Filtered:=True;
            if not cds134.IsEmpty then
            begin
              if abs(cds134.FieldByName('QUAN_ON_HAND').Value-StrToFloat(StringGrid1.Cells[str_list.IndexOfName('VMI�����'),i]))>0.01 then //134���С�ڷ��ſ��
              begin
                ShowMessage('���ʧ��,���ܶ��û�ͬʱ�����ͬһ�������ҵ��¿����ָ���!���ط�');
                Exit;
              end else
              begin
                cds134.Edit;
                cds134.FieldByName('QUAN_ON_HAND').Value:=cds134.FieldByName('QUAN_ON_HAND').Value-StrToFloat(StringGrid1.Cells[str_list.IndexOfName('��ǰ����'),i]);
                cds134.Post;
              end;
            end;
          end;
        end;

        //����22
//        for I := 1 to StringGrid1.RowCount-1 do
//        begin
//          if (StrToFloat(StringGrid1.Cells[str_list.IndexOfName('��ǰ����'),i])>0) then
//          begin
//            cds22.Append;
//            cds22.FieldByName('INVENTORY_PTR').Value:=StringGrid1.Cells[str_list.IndexOfName('17rkey'),i]; //ԭ����ָ��0017
//            cds22.FieldByName('SOURCE_PTR').Value:=StringGrid1.Cells[str_list.IndexOfName('71rkey'),i]; //data0071.rkey
//            cds22.FieldByName('LOCATION_PTR').Value:=StringGrid1.Cells[str_list.IndexOfName('16rkey'),i]; //�ֿ�λ��data0016
//            cds22.FieldByName('LOCATION_PTR_FROM').Value:=StringGrid1.Cells[str_list.IndexOfName('02Rkey'),i]; //�����λ02
//            cds22.FieldByName('QUANTITY').Value:=StringGrid1.Cells[str_list.IndexOfName('��ǰ����'),i]; //�ѽ��յ�����
//            cds22.FieldByName('QUAN_ON_HAND').Value:=StringGrid1.Cells[str_list.IndexOfName('��ǰ����'),i];//�ֳ�������
//            cds22.FieldByName('tax_price').Value:=StringGrid1.Cells[str_list.IndexOfName('�۸�˰'),i];//�۸�˰
//            cds22.FieldByName('PRICE').Value:=StrToCurr(StringGrid1.Cells[str_list.IndexOfName('�۸�˰'),i])/(1+strtofloat(StringGrid1.Cells[str_list.IndexOfName('˰��'),i])*0.01); // �۸񲻺�˰
//            cds22.FieldByName('TAX_2').Value:=StringGrid1.Cells[str_list.IndexOfName('˰��'),i]; //˰��
//            cds22.FieldByName('BARCODE_ID').Value:=StringGrid1.Cells[str_list.IndexOfName('��ע'),i];//�ر�Ҫ��
//            cds22.FieldByName('spec_place').Value:=StringGrid1.Cells[str_list.IndexOfName('��ϸλ��'),i]; //��ϸλ��
//            cds22.FieldByName('EXPIRE_DATE').Value:=StrToDate(StringGrid1.Cells[str_list.IndexOfName('��Ч��'),i]);//��Ч��(��)
//            cds22.FieldByName('rohs').Value:=StringGrid1.Cells[str_list.IndexOfName('������ʶ'),i]; //����ROHS
//            cds22.FieldByName('TDATE').Value:=StringGrid1.Cells[str_list.IndexOfName('��������'),i]; //��������
//            cds22.FieldByName('D456_IDKey').Value:=cds456.FieldByName('idkey').Value;
//            cds22.FieldByName('TTYPE').Value:=3;//����PO�ջ�
//            cds22.FieldByName('STOCK_BASE').Value:=StrToFloat(StringGrid1.Cells[str_list.IndexOfName('���ϵ���KG'),i]); //��������
//            cds22.FieldByName('cust_decl').Value:=StringGrid1.Cells[str_list.IndexOfName('���ص���'),i];//���ص���
//            cds22.FieldByName('QUAN_RTNED_FM_FACT').Value:=StringGrid1.Cells[str_list.IndexOfName('VMI���۸�(��˰)'),i];//VMI���ʱ�ļ۸�
//            cds22.FieldByName('D0134_PTR').Value:=StringGrid1.Cells[str_list.IndexOfName('134rkey'),i];//134Rkey
//            cds22.Post;
//            ShowMessage(StringGrid1.Cells[str_list.IndexOfName('VMI���۸�(��˰)'),i]);
//            if (StringGrid1.Cells[str_list.IndexOfName('17rkey'),i]<>'') then
//            begin
//              Lstr17:=Lstr17+StringGrid1.Cells[str_list.IndexOfName('17rkey'),i]+',';
//            end;
//            LiTmp:=LiTmp+1;
//          end;
//        end;
        if (LiTmp>0) then
        begin

//          for i:=1 to StringGrid1.RowCount-1 do
//          begin
//            if (StrToFloat(StringGrid1.Cells[str_list.IndexOfName('��ǰ����'),i])>0) then
//            begin
//              cds22.Append;
//              cds22.FieldByName('INVENTORY_PTR').Value:=StringGrid1.Cells[str_list.IndexOfName('17rkey'),i]; //ԭ����ָ��0017
//              cds22.FieldByName('SOURCE_PTR').Value:=StringGrid1.Cells[str_list.IndexOfName('71rkey'),i]; //data0071.rkey
//              cds22.FieldByName('LOCATION_PTR').Value:=StringGrid1.Cells[str_list.IndexOfName('16rkey'),i]; //�ֿ�λ��data0016
//              cds22.FieldByName('LOCATION_PTR_FROM').Value:=StringGrid1.Cells[str_list.IndexOfName('02Rkey'),i]; //�����λ02
//              cds22.FieldByName('QUANTITY').Value:=StringGrid1.Cells[str_list.IndexOfName('��ǰ����'),i]; //�ѽ��յ�����
//              cds22.FieldByName('QUAN_ON_HAND').Value:=StringGrid1.Cells[str_list.IndexOfName('��ǰ����'),i];//�ֳ�������
//              cds22.FieldByName('tax_price').Value:=StringGrid1.Cells[str_list.IndexOfName('�۸�˰'),i];//�۸�˰
//              cds22.FieldByName('PRICE').Value:=StrToCurr(StringGrid1.Cells[str_list.IndexOfName('�۸�˰'),i])/(1+strtofloat(StringGrid1.Cells[str_list.IndexOfName('˰��'),i])*0.01); // �۸񲻺�˰
//              cds22.FieldByName('TAX_2').Value:=StringGrid1.Cells[str_list.IndexOfName('˰��'),i]; //˰��
//              cds22.FieldByName('BARCODE_ID').Value:=StringGrid1.Cells[str_list.IndexOfName('��ע'),i];//�ر�Ҫ��
//              cds22.FieldByName('spec_place').Value:=StringGrid1.Cells[str_list.IndexOfName('��ϸλ��'),i]; //��ϸλ��
//              cds22.FieldByName('EXPIRE_DATE').Value:=StrToDate(StringGrid1.Cells[str_list.IndexOfName('��Ч��'),i]);//��Ч��(��)
//              cds22.FieldByName('rohs').Value:=StringGrid1.Cells[str_list.IndexOfName('������ʶ'),i]; //����ROHS
//              cds22.FieldByName('TDATE').Value:=StringGrid1.Cells[str_list.IndexOfName('��������'),i]; //��������
//              cds22.FieldByName('D456_IDKey').Value:=cds456.FieldByName('idkey').Value;
//              cds22.FieldByName('TTYPE').Value:=3;//����PO�ջ�
//              cds22.FieldByName('STOCK_BASE').Value:=StrToFloat(StringGrid1.Cells[str_list.IndexOfName('���ϵ���KG'),i]); //��������
//              cds22.FieldByName('cust_decl').Value:=StringGrid1.Cells[str_list.IndexOfName('���ص���'),i];//���ص���
//              cds22.FieldByName('QUAN_RTNED_FM_FACT').Value:=StringGrid1.Cells[str_list.IndexOfName('VMI���۸�(��˰)'),i];//VMI���ʱ�ļ۸�
//              cds22.FieldByName('D0134_PTR').Value:=StringGrid1.Cells[str_list.IndexOfName('134rkey'),i];//134Rkey
//              cds22.Post;
//
//            //�޸�17�ܿ����
//              cds17.Filtered:=False;
//              cds17.Filter:='';
//              cds17.Filter:='Rkey ='+StringGrid1.Cells[str_list.IndexOfName('17rkey'),i];
//              cds17.Filtered:=True;
//              if not cds17.IsEmpty then
//              begin
//                cds17.Edit;
//                cds17.FieldByName('QUAN_ON_HAND').Value:=cds17.FieldByName('QUAN_ON_HAND').Value + cds22.FieldByName('quan_on_hand').Value; //17�ܿ����
//                cds17.Post;
//              end;
//            end;
//          end;
          //����04_724
          cds04_724.Edit;
          cds04_724.FieldByName('SEED_VALUE').Value:=LGRName724;
          cds04_724.Post;
          //����04_456
          cds04_456.Edit;
          cds04_456.FieldByName('SEED_VALUE').Value:=LGRName456;
          cds04_456.Post;

          if cds724.State in [dsEdit,dsInsert] then cds724.Post;
          if cds149.State in [dsEdit,dsInsert] then cds149.Post;
          if cds456.State in [dsEdit,dsInsert] then cds456.Post;
          if cds22.State in [dsEdit,dsInsert] then cds22.Post;
          if cds04_724.State in [dsEdit,dsInsert] then cds04_724.Post;
          if cds04_456.State in [dsEdit,dsInsert] then cds04_456.Post;
          if cds17.State in [dsEdit,dsInsert] then cds17.Post;
          if cds134.State in [dsEdit,dsInsert] then cds134.Post;

          LPostData := VarArrayCreate([0,7],varVariant);
          if cds724.ChangeCount > 0 then
            LPostData[0] := cds724.Delta;
          if cds149.ChangeCount > 0 then
            LPostData[1] := cds149.Delta;
          if cds456.ChangeCount > 0 then
            LPostData[2] := cds456.Delta;
          if cds22.ChangeCount > 0 then
            LPostData[3] := cds22.Delta;
          if cds04_724.ChangeCount > 0 then
            LPostData[4] := cds04_724.Delta;
          if cds04_456.ChangeCount > 0 then
            LPostData[5] := cds04_456.Delta;
          if cds17.ChangeCount > 0 then
            LPostData[6] := cds17.Delta;
          if cds134.ChangeCount>0 then
            LPostData[7] := cds134.Delta;
          if gSvrIntf.IntfPostModData('��������',33,LPostData,4) then
          begin
            cds724.MergeChangeLog;
            cds149.MergeChangeLog;
            cds456.MergeChangeLog;
            cds22.MergeChangeLog;
            cds04_724.MergeChangeLog;
            cds04_456.MergeChangeLog;
            cds17.MergeChangeLog;
            cds134.MergeChangeLog;
            ShowMessage('����ɹ�');
            if Assigned(refresh) then
              refresh(nil);
            Close;
          end else
          begin
            ShowMessage('����ʧ��,724IDRkey:'+cds724.FieldByName('idkey').AsString);
            Close;
            Exit;
          end;
        end;
      end;
      1: //�༭
      begin
        if find_shuliang_Error(cds456.FieldByName('TType').AsInteger,cds456.FieldByName('Rkey').AsInteger) then
        begin
          ShowMessage('����¼�����仯�����з���,�����ٱ༭!');
          Exit;
        end;
        for I := 1 to StringGrid1.RowCount-1 do
        begin
          Lrk134s:=Lrk134s+StringGrid1.Cells[str_list.IndexOfName('134rkey'),i]+',';
          Lstr17:=Lstr17+StringGrid1.Cells[str_list.IndexOfName('17rkey'),i]+',';
        end;
        Lsql134:='select * from data0134 where rkey in (' + Lrk134s+'-1)';
        Lsq17:='select * from data0017 where rkey in (' + Lstr17+'-1)';
        if not gSvrIntf.IntfGetDataBySqlArr(VarArrayOf([Lsql134,Lsq17]),[cds134,cds17]) then Exit;

        cds456.Edit;
        cds456.FieldByName('DELIVER_NUMBER').Value:=Trim(Edit5.Text);
        cds456.FieldByName('ship_DATE').Value:=dtpReqDate.Date;
        cds456.FieldByName('ship_BY').Value:=Trim(Edit6.Text);
        cds456.FieldByName('REF_NUMBER').Value:=Trim(Edit12.Text);
        cds456.FieldByName('STATUS').Value:=1;
        cds456.Post;

        for I := 1 to StringGrid1.RowCount-1 do
        begin
        //�޸�134
          cds134.Filtered:=False;
          cds134.Filter:='';
          cds134.Filter:='Rkey ='+Trim(StringGrid1.Cells[str_list.IndexOfName('134rkey'),i]);
          cds134.Filtered:=True;
          if not cds134.IsEmpty then
          begin
            if (cds134.FieldByName('QUAN_ON_HAND').Value<>StrToFloat(StringGrid1.Cells[str_list.IndexOfName('VMI�����'),i])) then //134���С�ڷ��ſ��
            begin
              ShowMessage('�в��Ͽ�淢���仯,���˳����±༭!');
              Exit;
            end else
            begin
              cds134.Edit;
              cds134.FieldByName('QUAN_ON_HAND').Value:=cds134.FieldByName('QUAN_ON_HAND').Value
                                          + StrToFloat(StringGrid1.Cells[str_list.IndexOfName('����������'),i])
                                          - StrToFloat(StringGrid1.Cells[str_list.IndexOfName('��ǰ����'),i]);
              cds134.Post;
            end;
          end;
        //�޸�149
          cds149.Filtered:=False;
          cds149.Filter:='';
          cds149.Filter:='D0134_PTR='+Trim(StringGrid1.Cells[str_list.IndexOfName('134rkey'),i]);
          cds149.Filtered:=True;
          if not cds149.IsEmpty then
          begin
            cds149.Edit;
            cds149.FieldByName('QUANTITY').Value:=StringGrid1.Cells[str_list.IndexOfName('��ǰ����'),i];
            cds149.FieldByName('tax_price').Value:=StringGrid1.Cells[str_list.IndexOfName('�۸�˰'),i];
            cds149.FieldByName('TAX_2').Value:=StringGrid1.Cells[str_list.IndexOfName('˰��'),i];
            cds149.Post;
          end;
        //����22�ѽ�������
          LfSL22:=0;
          LfSL22r:=0;
          cds22.Filtered:=False;
          cds22.Filter:='';
          cds22.Filter:='Rkey ='+StringGrid1.Cells[str_list.IndexOfName('rkey'),i];
          cds22.Filtered:=True;
          if not cds22.IsEmpty then
          begin
            cds22.Edit;
            cds22.FieldByName('LOCATION_PTR').Value:=StringGrid1.Cells[str_list.IndexOfName('16rkey'),i]; //�ֿ�λ��data0016
            cds22.FieldByName('QUANTITY').Value:=StringGrid1.Cells[str_list.IndexOfName('��ǰ����'),i]; //�ѽ��յ�����
            cds22.FieldByName('QUAN_ON_HAND').Value:=StringGrid1.Cells[str_list.IndexOfName('��ǰ����'),i];//�ֳ�������
            cds22.FieldByName('BARCODE_ID').Value:=StringGrid1.Cells[str_list.IndexOfName('��ע'),i];//�ر�Ҫ��
            cds22.FieldByName('spec_place').Value:=StringGrid1.Cells[str_list.IndexOfName('��ϸλ��'),i]; //��ϸλ��
            if Trim(StringGrid1.Cells[str_list.IndexOfName('��Ч��'),i]) = '' then  cds22.FieldByName('EXPIRE_DATE').AsVariant:=null
            else cds22.FieldByName('EXPIRE_DATE').Value:=StrToDate(StringGrid1.Cells[str_list.IndexOfName('��Ч��'),i]);//��Ч��(��)
            cds22.FieldByName('TDATE').Value:=StringGrid1.Cells[str_list.IndexOfName('��������'),i]; //��������
            cds22.Post;
//            if (cds22.RecordCount>1) then
//            begin
//              while not cds22.Eof do
//              begin
//                LfSL22:=LfSL22+StrToFloat(StringGrid1.Cells[str_list.IndexOfName('��ǰ����'),i]);
//                LfSL22r:=LfSL22r+StrToFloat(StringGrid1.Cells[str_list.IndexOfName('��������2'),i]);
//                cds22.Next;
//              end;
//            end else
//            begin
              LfSL22:=StrToFloat(StringGrid1.Cells[str_list.IndexOfName('��ǰ����'),i]);
              LfSL22r:=StrToFloat(StringGrid1.Cells[str_list.IndexOfName('��������2'),i]);
//            end;
          end;
        //�޸�17
          cds17.Filtered:=False;
          cds17.Filter:='';
          cds17.Filter:='Rkey ='+Trim(StringGrid1.Cells[str_list.IndexOfName('17rkey'),i]);
          cds17.Filtered:=True;
          if not cds17.IsEmpty then
          begin
            cds17.Edit;
            cds17.FieldByName('QUAN_ON_HAND').Value:=cds17.FieldByName('QUAN_ON_HAND').Value+(LfSL22-LfSL22r); //17�ܿ����
            cds17.Post;
          end;
        end;

        if cds724.State in [dsEdit,dsInsert] then cds724.Post;
        if cds149.State in [dsEdit,dsInsert] then cds149.Post;
        if cds456.State in [dsEdit,dsInsert] then cds456.Post;
        if cds22.State in [dsEdit,dsInsert] then cds22.Post;
        if cds04_724.State in [dsEdit,dsInsert] then cds04_724.Post;
        if cds04_456.State in [dsEdit,dsInsert] then cds04_456.Post;
        if cds17.State in [dsEdit,dsInsert] then cds17.Post;
        if cds134.State in [dsEdit,dsInsert] then cds134.Post;

        LPostData := VarArrayCreate([0,7],varVariant);
        if cds724.ChangeCount > 0 then
          LPostData[0] := cds724.Delta;
        if cds149.ChangeCount > 0 then
          LPostData[1] := cds149.Delta;
        if cds456.ChangeCount > 0 then
          LPostData[2] := cds456.Delta;
        if cds22.ChangeCount > 0 then
          LPostData[3] := cds22.Delta;
        if cds04_724.ChangeCount > 0 then
          LPostData[4] := cds04_724.Delta;
        if cds04_456.ChangeCount > 0 then
          LPostData[5] := cds04_456.Delta;
        if cds17.ChangeCount > 0 then
          LPostData[6] := cds17.Delta;
        if cds134.ChangeCount>0 then
          LPostData[7] := cds134.Delta;
        if gSvrIntf.IntfPostModData('��������',33,LPostData,4) then
        begin
          if cds724.ChangeCount > 0 then cds724.MergeChangeLog;
          if cds149.ChangeCount > 0 then cds149.MergeChangeLog;
          if cds456.ChangeCount > 0 then cds456.MergeChangeLog;
          if cds22.ChangeCount > 0 then cds22.MergeChangeLog;
          if cds04_724.ChangeCount > 0 then cds04_724.MergeChangeLog;
          if cds04_456.ChangeCount > 0 then cds04_456.MergeChangeLog;
          if cds17.ChangeCount > 0 then cds17.MergeChangeLog;
          if cds134.ChangeCount>0 then cds134.MergeChangeLog;
          ShowMessage('����ɹ�');
          if Assigned(refresh) then
            refresh(nil);
          Close;
        end;
      end;
    end;
  finally
    Lcds.Free;
  end;
end;

procedure TfrmVMIrucang_mod33.CBlocExit(Sender: TObject);
begin
  inherited;
  if (CBloc.itemindex<>-1) then
  begin
    StringGrid1.Cells[str_list.IndexOfName('�ֿ�λ��'),StringGrid1.Row]:=CBLoc.Text;
    StringGrid1.Cells[str_list.IndexOfName('16rkey'),StringGrid1.Row]:=IntToStr(integer(CBloc.items.objects[CBloc.itemindex]));
  end;
end;

procedure TfrmVMIrucang_mod33.CBlocKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if key=112 then CBloc.DroppedDown:=true;    //f2
  if key=13 then StringGrid1.SetFocus;
end;

procedure TfrmVMIrucang_mod33.ComboBox3Exit(Sender: TObject);
begin
  inherited;
  StringGrid1.Cells[str_list.IndexOfName('��ϸλ��'),StringGrid1.Row]:=combobox3.Text;
  if (combobox3.itemindex<>-1) then
  begin
    ComboBox3.Items.Clear;
  end;
end;

procedure TfrmVMIrucang_mod33.ComboBox3KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if key=112 then ComboBox3.DroppedDown:=true;    //f2
  if key=13 then StringGrid1.SetFocus;
end;

function TfrmVMIrucang_mod33.find_rkey134: boolean;
var Lcds:TClientDataSet;
    i:Integer;
    rkey134,Lsql:string;
begin
  Result:=False;
  rkey134:='';
  Lcds:=TClientDataSet.Create(Self);
  try
    for i:=1 to StringGrid1.RowCount-1 do
    begin
      rkey134:=rkey134+StringGrid1.Cells[str_list.IndexOfName('134rkey'),i]+',';
    end;
    Lsql:='select rkey,QUAN_on_hand from data0134 where rkey in (' + rkey134+'-1)';
    gSvrIntf.IntfGetDataBySql(Lsql,Lcds);
    if not Lcds.IsEmpty  then
    begin
      for i:=1 to StringGrid1.RowCount-1 do
      begin
        Lcds.Filtered:=False;
        Lcds.Filter:='';
        Lcds.Filter:='Rkey ='+StringGrid1.Cells[str_list.IndexOfName('134rkey'),i];
        Lcds.Filtered:=True;
        if not Lcds.IsEmpty then
        begin
          if (abs(Lcds.FieldByName('QUAN_on_hand').Value-StrToFloat(StringGrid1.Cells[str_list.IndexOfName('VMI�����'),i]))>0.01) then
          Result:=True;
        end;
      end;
    end
  finally
    Lcds.Free;
  end;
end;


function TfrmVMIrucang_mod33.find_shuliang_Error(TType,
  Rkey456: Integer): Boolean;
var Lcds:TClientDataSet;
begin
  Result:=False;
  Lcds:=TClientDataSet.Create(Self);
  try
    if (TType<>2) then
    begin
      gSvrIntf.IntfGetDataBySql('select rkey from data0022 where quantity<>quan_on_hand and grn_ptr='+inttostr(Rkey456),Lcds);
      if not Lcds.IsEmpty then Result:=True;
    end else
    begin
      gSvrIntf.IntfGetDataBySql('select rkey from data0235 where quan_recd<>quan_on_hand and grn_ptr='+inttostr(Rkey456),Lcds);
      if not Lcds.IsEmpty then Result:=True;
    end;
  finally
    LCds.Free;
  end;
end;

procedure TfrmVMIrucang_mod33.GetData(ARkey,ARkey724: string);
var
  LSq456,LSq22,LSq724,LSq149: string;
begin
  // data0456
  LSq456 := 'select * from data0456 where rkey = ' + ARkey;
  // data0022
  LSq22 := 'select * from data0022 where GRN_PTR = ' + ARkey;
  // data0724
  LSq724 := 'select * from data0724 where Rkey = '+ ARkey724;
  // data0149
  LSq149 := 'select * from data0149 where GON_PTR = '+ ARkey724;
  if not gSvrIntf.IntfGetDataBySqlArr(VarArrayOf([LSq456,LSq22,LSq724,LSq149]),[cds456,cds22,cds724,cds149]) then Exit;

  if (FEditType=0) or (FEditType=1) then
  begin
    if (not cds456.IsEmpty) and (cds456.FieldByName('IDKEY').AsString = '') then
    begin
      cds456.Edit;
      cds456.FieldByName('IDKEY').AsString := gFunc.CreateIDKey;
      cds456.Post;
    end;
    //22
    cds22.DisableControls;
    try
      cds22.First;
      while not cds22.Eof do
      begin
        cds22.Edit;
        cds22.FieldByName('D456_IDKey').AsString := cds456.FieldByName('IDKEY').AsString;
        cds22.Post;
        cds22.Next;
      end;
      cds22.First;
    finally
      cds22.EnableControls;
    end;

    if (not cds724.IsEmpty) and (cds724.FieldByName('IDKEY').AsString = '') then
    begin
      cds724.Edit;
      cds724.FieldByName('IDKEY').AsString := gFunc.CreateIDKey;
      cds724.Post;
    end;
    cds149.DisableControls;
    try
      cds149.First;
      while not cds149.Eof do
      begin
        cds149.Edit;
        cds149.FieldByName('D724_IDKey').AsString := cds724.FieldByName('IDKEY').AsString;
        cds149.Post;
        cds149.Next;
      end;
      cds149.First;
    finally
      cds149.EnableControls;
    end;
  end;
end;

procedure TfrmVMIrucang_mod33.get_location;
var Lsql:string;
begin
  if checkbox3.Checked then
    Lsql:='select rkey,LOCATION from data0016 '+
    'where LOCATION_TYPE = 0 and '+
    'whouse_ptr='+cds456.FieldByName('warehouse_ptr').AsString+
    ' order by rkey'
  else
     Lsql:='select rkey,LOCATION from data0016 '+
    'where LOCATION_TYPE=0 order by rkey';
  if not gSvrIntf.IntfGetDataBySql(Lsql,cds16) then Exit;
  cbloc.Items.Clear;
  while not cds16.Eof do
   begin
    cbloc.Items.AddObject(cds16.fieldBYName('LOCATION').AsString,Pointer(cds16.fieldBYName('Rkey').AsInteger));
    cds16.Next;
   end;
  cbloc.ItemIndex:=cbloc.Items.IndexOf(cds16.fieldBYName('LOCATION').AsString);
end;

procedure TfrmVMIrucang_mod33.init;
var j,i:integer;
begin
  for j :=StringGrid1.RowCount  downto 1  do
  begin
    for i:=0 to StringGrid1.ColCount do
    begin
      StringGrid1.Cells[i,j]:='';
    end;
    stringgrid1.rowcount := stringgrid1.rowcount - 1;
  end;
  str_list := TStringList.Create;
  str_list.Add('���ϱ���=INV_PART_NUMBER');
  str_list.Add('��������=INV_NAME');
  str_list.Add('���Ϲ��=INV_DESCRIPTION');
  str_list.Add('������ʶ=rohs');
  str_list.Add('��浥λ=UNIT_NAME');
  str_list.Add('VMI�����=VMI_ON_HAND');
  str_list.Add('��ǰ����=QUANTITY');
  str_list.Add('�۸�˰=TAX_PRICE');
  str_list.Add('˰��=TAX_2');
  str_list.Add('�ֿ�λ��=LOCATION');
  str_list.Add('��ϸλ��=spec_place');
  str_list.Add('��Ч��=EXPIRE_DATE');
  str_list.Add('��������=TDATE');
  str_list.Add('��ע=BARCODE_ID');
  str_list.Add('����������=SHELF_LIFE');
  str_list.Add('VMI���۸�(��˰)=QUAN_RTNED_FM_FACT');
  str_list.Add('17rkey=INVENTORY_PTR');
  str_list.Add('16rkey=LOCATION_PTR');
  str_list.Add('02rkey=LOCATION_PTR_FROM');
  str_list.Add('���ϵ���KG=STOCK_BASE');
  str_list.Add('����������=QUAN_ON_HAND2');
  str_list.Add('71rkey=SOURCE_PTR');
  str_list.Add('���ص���=cust_decl');
  str_list.Add('��������2=QUANTITY');
  str_list.Add('Rkey=Rkey');
  str_list.Add('134rkey=rkey134');
  StringGrid1.ColCount:=str_list.Count;
  for j := 0 to str_list.Count-1  do    //SGrd��ӵ�һ�е��ֶ���
  begin
    StringGrid1.Cells[j,0] := str_list.Names[j];
  end;
  StringGrid1.RowCount:=2;
  StringGrid1.FixedRows:=1;
  StringGrid1.ColWidths[str_list.IndexOfName('17rkey')]:=-1;
  StringGrid1.ColWidths[str_list.IndexOfName('16rkey')]:=-1;
  StringGrid1.ColWidths[str_list.IndexOfName('02rkey')]:=-1;
  StringGrid1.ColWidths[str_list.IndexOfName('���ϵ���KG')]:=-1;
  StringGrid1.ColWidths[str_list.IndexOfName('����������')]:=-1;
  StringGrid1.ColWidths[str_list.IndexOfName('71rkey')]:=-1;
  StringGrid1.ColWidths[str_list.IndexOfName('���ص���')]:=-1;
  StringGrid1.ColWidths[str_list.IndexOfName('��������2')]:=-1;
  StringGrid1.ColWidths[str_list.IndexOfName('Rkey')]:=-1;
  StringGrid1.ColWidths[str_list.IndexOfName('134rkey')]:=-1;
end;

function TfrmVMIrucang_mod33.Power(x, y: extended): extended;
begin
  result := exp(y*ln(x));
end;

procedure TfrmVMIrucang_mod33.StringGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
 if (key=112) and (CBLoc.Visible) then
  begin
   if CBLoc.Enabled then
   begin
     CBLoc.SetFocus;
     CBLoc.DroppedDown:=true;
   end;
  end;
 if (key=112) and (combobox3.Visible) then
  begin
   if combobox3.Enabled then
   begin
     combobox3.SetFocus;
     combobox3.DroppedDown:=true;
   end;
  end;
end;

procedure TfrmVMIrucang_mod33.StringGrid1KeyPress(Sender: TObject;
  var Key: Char);
begin
  inherited;
  if (StringGrid1.Col = 6 ) then
  begin
    if not CharInSet(key ,['0'..'9','.',#8,#13]) then  //�ж��Ƿ��������ֺ�С����
      abort
    else
    if key = chr(46) then
    begin      //�ж��Ƿ��ظ�����С����'.'
      if pos('.',StringGrid1.Cells[6,StringGrid1.Row])>0  then abort;
    end;
  end;
end;

procedure TfrmVMIrucang_mod33.StringGrid1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if StringGrid1.Col=6 then
  begin
    if StringGrid1.Cells[6,StringGrid1.Row]='' then StringGrid1.Cells[6,StringGrid1.Row]:='0';
    if self.FEditType=0 then//����ʱ�û�������������
    begin
      if strtofloat(StringGrid1.Cells[6,StringGrid1.Row])-strtofloat(StringGrid1.Cells[5,StringGrid1.row])>0 then
      StringGrid1.Cells[6,StringGrid1.Row]:=StringGrid1.Cells[5,StringGrid1.row];
    end;
    if self.FEditType=1 then //�༭ʱ�û�������������
    begin
      if strtofloat(StringGrid1.Cells[6,StringGrid1.Row])-(strtofloat(StringGrid1.Cells[5,StringGrid1.Row])
                + strtofloat(StringGrid1.Cells[str_list.IndexOfName('��������2'),StringGrid1.Row]))>0 then
        StringGrid1.Cells[6,StringGrid1.Row]:=
            floattostr((strtofloat(StringGrid1.Cells[5,StringGrid1.Row]) + strtofloat(StringGrid1.Cells[str_list.IndexOfName('��������2'),StringGrid1.Row])));
    end;
  end;
end;

procedure TfrmVMIrucang_mod33.StringGrid1SelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
var Lcds:TClientDataSet;
begin
  inherited;
  Lcds:=TClientDataSet.Create(Self);
  try
    if (ACol = 9 ) then
    begin
      CBLoc.Width := StringGrid1.DefaultColWidth;
      CBLoc.Height := StringGrid1.DefaultRowHeight;
      CBLoc.Left := StringGrid1.Left+(ACol-StringGrid1.LeftCol+1)*CBLoc.Width+10;
      if (ARow<StringGrid1.TopRow)  then
      CBLoc.Top := StringGrid1.Top+(ARow - StringGrid1.TopRow)* StringGrid1.DefaultRowHeight+ (ARow - StringGrid1.TopRow)
      else
      CBLoc.Top := StringGrid1.Top+(ARow - StringGrid1.TopRow+1)* StringGrid1.DefaultRowHeight+ (ARow - StringGrid1.TopRow+1);

      CBLoc.Visible := True;
      if StringGrid1.Cells[acol,arow]<>'' then
      begin
       CBLoc.ItemIndex:=CBLoc.Items.IndexOf(StringGrid1.Cells[acol,arow]);
      end else
       CBLoc.ItemIndex:=-1;
    end
    else
      CBLoc.Visible :=false;

    if (ACol = 10 ) then
    begin
      ComboBox3.Width := StringGrid1.DefaultColWidth;
      ComboBox3.Height := StringGrid1.DefaultRowHeight;
      ComboBox3.Left := StringGrid1.Left+(ACol-StringGrid1.LeftCol+1)*CBLoc.Width+10;
      if (ARow<StringGrid1.TopRow)  then
      ComboBox3.Top := StringGrid1.Top+(ARow - StringGrid1.TopRow)* StringGrid1.DefaultRowHeight+ (ARow - StringGrid1.TopRow)
      else
      ComboBox3.Top := StringGrid1.Top+(ARow - StringGrid1.TopRow+1)* StringGrid1.DefaultRowHeight+ (ARow - StringGrid1.TopRow+1);
      ComboBox3.Visible := True;
      if (StringGrid1.Cells[acol,arow]<>'') and (ComboBox3.Items.IndexOf(StringGrid1.Cells[acol,arow])=-1) then
        ComboBox3.Text:=StringGrid1.Cells[acol,arow]
      else if (StringGrid1.Cells[acol,arow]<>'') and (ComboBox3.Items.IndexOf(StringGrid1.Cells[acol,arow])<>-1) then
        ComboBox3.ItemIndex:=ComboBox3.Items.IndexOf(StringGrid1.Cells[acol,arow])
      else
      begin
        combobox3.Items.Clear;
        combobox3.Text:='';
      end;
      if ((ComboBox3.Visible=True) and (StringGrid1.Cells[9,ARow]<>'')) then
      begin
        gSvrIntf.IntfGetDataBySql('select * from Data0176 where rkey_16 = ' + IntToStr(integer(CBLoc.items.objects[CBLoc.Items.IndexOf(StringGrid1.Cells[9,aRow])]))+'',Lcds);
        if not Lcds.IsEmpty then
        begin
          Lcds.First;
          combobox3.Items.Clear;
          while not Lcds.Eof do
          begin
            combobox3.Items.Add(Trim(Lcds.FieldByName('LOCATION').Value));
            Lcds.Next;
          end;
        end;
      end else
      if (StringGrid1.Cells[9,ARow]='') then
      begin
        combobox3.Items.Clear;
        combobox3.Text:='';
      end;
    end
    else
      ComboBox3.Visible :=false;
  finally
    Lcds.Free;
  end;

  if (FEditType=3) then
    StringGrid1.Options:=StringGrid1.Options-[goEditing]
  else
  if ((FEditType =0) or (FEditType =1)) then
  begin
    if (acol=6) or (acol=9) or (ACol=10) then
      StringGrid1.Options:=StringGrid1.Options+[goEditing]
    else
      StringGrid1.Options:=StringGrid1.Options-[goEditing];
  end;
end;

function TfrmVMIrucang_mod33.update04(table_name: string;
  var LsName: string;cds:TClientDataSet): string;
var
  i,v_length:integer;
  v_last,v_seed,new_seed:string;
begin
  if not gSvrIntf.IntfGetDataBySql('select * from data0004 where table_name='''+table_name+'''',cds) then Exit;
  if not cds.IsEmpty then
  begin
    v_seed:=cds.FieldByName('SEED_VALUE').AsString;
    LsName:=v_seed;
    if cds.FieldByName('SEED_FLAG').Value<>1 then
    begin
      v_length := length(v_seed);
      for i := v_length downto 1 do
      if (copy(v_seed,i,1)<'0') or (copy(v_seed,i,1)>'9') then  //�����������
      begin
        v_last := floattostr(power(10,v_length)+strtofloat(copy(v_seed,i+1,v_length-i))+1); //��׺��1
        new_seed := copy(v_seed,1,i)+copy(v_last,i+2,v_length-i); //ʹǰ׺�����׺��1
        break;
      end
      else
      if i=1 then //�����һλ��Ȼ������
        begin
         v_last := floattostr(power(10,v_length)+strtofloat(v_seed)+1);
         new_seed := copy(v_last,2,v_length);
        end;
    end;
  end;
  result:=new_seed;
end;

procedure TfrmVMIrucang_mod33.UpdatePrice(ARow:Integer;ASupp,AInvt:string);
var
  LSql:string;
  LCds:TClientDataSet;
begin
  LSql:= 'SELECT price_1,TAX_2,tax_flag FROM data0028 ' +
         ' Where supplier_ptr= ' + Asupp + ' and inventory_ptr=' + AInvt;
  LCds:= TClientDataSet.Create(Self);
  try
    if not gSvrIntf.IntfGetDataBySql(LSql,LCds) then exit;
    if not LCds.IsEmpty then
    begin
      if LCds.FieldByName('tax_flag').AsString = 'N' then
      begin
        StringGrid1.Cells[str_list.IndexOfName('�۸�˰'),ARow]:=floattostr(LCds.FieldByName('PRICE_1').value * (1+ LCds.FieldByName('TAX_2').value*0.01)); //
        StringGrid1.Cells[str_list.IndexOfName('˰��'),ARow]:=LCds.FieldByName('TAX_2').AsString;
      end
      else
      begin
        StringGrid1.Cells[str_list.IndexOfName('�۸�˰'),ARow]:=LCds.FieldByName('PRICE_1').AsString;
        StringGrid1.Cells[str_list.IndexOfName('˰��'),ARow]:=LCds.FieldByName('TAX_2').AsString;
      end;
    end;
  finally
    LCds.Free;
  end;
end;

end.
