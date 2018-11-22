unit POruku_Mod33;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uBaseEditFrm,ucommfunc, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.Mask, RzEdit, RzBtnEdt, uRKeyBtnEdit, Vcl.Buttons,
  Vcl.ExtCtrls, Vcl.Grids, Data.DB, Datasnap.DBClient, Vcl.Menus, SeleIQC_Mod33;

type
  LgetRefreshClick=procedure (cds:TClientDataSet) of object;
  TfrmPOruku_Mod33 = class(TfrmBaseEdit)
    Panel1: TPanel;
    Label1: TLabel;
    Label5: TLabel;
    Label12: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    Label11: TLabel;
    Label14: TLabel;
    Label3: TLabel;
    Label13: TLabel;
    Label16: TLabel;
    CheckBox3: TCheckBox;
    redt1: TRKeyRzBtnEdit;
    redt2: TRKeyRzBtnEdit;
    redt3: TRKeyRzBtnEdit;
    redt4: TRKeyRzBtnEdit;
    redt5: TRKeyRzBtnEdit;
    redt7: TRKeyRzBtnEdit;
    redt8: TRKeyRzBtnEdit;
    redt9: TRKeyRzBtnEdit;
    Button1: TButton;
    dtpReqDate: TDateTimePicker;
    redt6: TRKeyRzBtnEdit;
    Button2: TButton;
    Label4: TLabel;
    redt10: TRKeyRzBtnEdit;
    StringGrid1: TStringGrid;
    StringGrid2: TStringGrid;
    cds04: TClientDataSet;
    cds16: TClientDataSet;
    cds70: TClientDataSet;
    cds391: TClientDataSet;
    cds71: TClientDataSet;
    cds72: TClientDataSet;
    cds456: TClientDataSet;
    cds22: TClientDataSet;
    cds235: TClientDataSet;
    ds456: TDataSource;
    CBloc: TComboBox;
    dtpk1: TDateTimePicker;
    CheckBox2: TCheckBox;
    ComboBox3: TComboBox;
    Panel2: TPanel;
    cds17: TClientDataSet;
    cds14: TClientDataSet;
    cds314: TClientDataSet;
    cds192: TClientDataSet;
    PopupMenu1: TPopupMenu;
    IQC1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    cds71_2: TClientDataSet;
    cds72_2: TClientDataSet;
    procedure CBlocKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ComboBox3KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure StringGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure StringGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure CBlocExit(Sender: TObject);
    procedure ComboBox3Exit(Sender: TObject);
    procedure dtpk1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure btnSaveClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure StringGrid2SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure btnCloseClick(Sender: TObject);
    procedure StringGrid2KeyPress(Sender: TObject; var Key: Char);
    procedure StringGrid2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dtpk1Exit(Sender: TObject);
    procedure StringGrid1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure StringGrid2KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure IQC1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    { Private declarations }
    function IfWarehouse(TType:Integer):Boolean; //�ж��������Ĳֿⲻ������
    function IfDateNow():Boolean; //�������ڲ��ܴ��ڵ�ǰ����
    function pucher_releced():boolean; //����¼�Ƿ����仯
    function find_quan_error(TType, Rkey456: Integer): boolean;//�༭״̬�±�������������Ƿ�ı�
//    function recevied_over(rkey70,vtype: Integer): Boolean;//�Ƿ��޸�70״̬
  public
    stock_flag:string;//�����������ܴ��ڶ�������
    LGRName:string; //04���º�
    FEditType: Integer;//�˵�
    if22or235:Integer;//�������ϻ����������
    str_list,str_list2:TStringList; //�����б�
    { Public declarations }
    refresh:LgetRefreshClick;
    function Power(x, y : extended) : extended;
    procedure GetData(ARkey: string);
    procedure init;
    procedure init2;
    function update04(table_name:string;var LsName:string):string;
    procedure get_location();
    procedure EnableEdit;
    function find_maxdate():TDatetime; //����������������
    procedure EnableButton(Fool:Boolean);//��ť�Ƿ����
  end;

var
  frmPOruku_Mod33: TfrmPOruku_Mod33;

implementation
{$R *.dfm}

{ TfrmPOruku_Mod33 }

procedure TfrmPOruku_Mod33.btnCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmPOruku_Mod33.btnSaveClick(Sender: TObject);
var Lcds:TClientDataSet;
    LsName,Lstr,smsstring,msg,LSql14,LSql314:string;
    i,LiTmp:Integer;
    LPostData: OleVariant;
    Lstr391,Lstr71,Lstr17,Lstr72:string;
    Lsq391,Lsq71,Lsq04,Lsq70_2,Lsq17,Lsq72:string;
    LmaxDate:TDateTime;
    LCase70:Boolean;
//    LCaseSL:Boolean;
begin
  inherited;
  Lcds:=TClientDataSet.Create(Self);
  try
    if trim(redt9.Text)='' then
    begin
      showmessage('�ͻ����Ų���Ϊ��...');
      exit;
    end;
    //�������Ĳֿⲻ�ܶ�Ϊ��
    if IfWarehouse(if22or235) then
    begin
      showmessage('������Ҫһ����ּ�¼���������λ�û��������Ϊ0!');
      exit;
    end;
    LmaxDate:=find_maxdate;
    if LmaxDate<>Null then
    if dtpReqDate.DateTime < LmaxDate then
    begin
      ShowMessage('�ͻ����ڱ�����ڲ���������������!');
      exit;
    end;
    if (if22or235=22) then
    begin
      if IfDateNow() then
      begin
        ShowMessage('������һ����ּ�¼�������ڴ��ڵ�ǰ����,������Ҫ��,���޸������������');
        Exit;
      end;
    end;
    Lstr391:='';
    Lstr71:='';
    Lstr17:='';
    LiTmp:=0;
    LCase70:=False;
//    LCaseSL:=False;
    case FEditType of
      0:  //����
      begin
        if pucher_releced then
        begin
          ShowMessage('����¼�����䷢,�����ж��ͬʱ���!');
          exit;
        end;
        if trim(redt1.Text)='' then
        begin
          showmessage('���Ų���Ϊ��...');
          exit;
        end;
        cds456.Edit;
        gSvrIntf.IntfGetDataBySql('select * from data0456 where GRN_NUMBER = ''' + Trim(redt1.Text)+'''',Lcds);
        if not Lcds.IsEmpty then
        begin
          if messagedlg('��ֱ���ظ�,�����ж�̨�����ͬʱ����,�Ƿ��Զ����±��?',mtConfirmation,[mbYes,mbNo],0)=mrYes  then
          begin
            LGRName:=update04('data0456',LsName);
            cds456.FieldByName('GRN_NUMBER').Value:=LsName;
          end;
        end;
        cds456.FieldByName('ship_BY').Value:=redt8.Text;
        cds456.FieldByName('DELIVER_NUMBER').Value:=redt9.Text;
        cds456.FieldByName('ship_DATE').Value:=dtpReqDate.DateTime;
        cds456.FieldByName('REF_NUMBER').Value:=redt4.Text;
        cds456.Post;
        if (if22or235=22) then
        begin
          for I := 1 to StringGrid1.RowCount-1 do
          begin
//            if (StrToFloat(StringGrid1.Cells[str_list.IndexOfName('��ǰ����'),i])>0) then
//            begin
//              cds22.Append;
//              cds22.FieldByName('INVENTORY_PTR').Value:=StringGrid1.Cells[str_list.IndexOfName('17rkey'),i]; //ԭ����ָ��0017
//              cds22.FieldByName('SOURCE_PTR').Value:=StringGrid1.Cells[str_list.IndexOfName('71rkey'),i]; //data0071.rkey
//              cds22.FieldByName('LOCATION_PTR').Value:=StringGrid1.Cells[str_list.IndexOfName('16rkey'),i]; //�ֿ�λ��data0016
//              cds22.FieldByName('LOCATION_PTR_FROM').Value:=StringGrid1.Cells[str_list.IndexOfName('�����λ02'),i]; //�����λ02
//              cds22.FieldByName('QUANTITY').Value:=StringGrid1.Cells[str_list.IndexOfName('��ǰ����'),i]; //�ѽ��յ�����
//              cds22.FieldByName('QUAN_ON_HAND').Value:=StringGrid1.Cells[str_list.IndexOfName('��ǰ����'),i];//�ֳ�������
//              cds22.FieldByName('tax_price').Value:=StringGrid1.Cells[str_list.IndexOfName('��˰��'),i];//�۸�˰
//              cds22.FieldByName('PRICE').Value:=StrToCurr(StringGrid1.Cells[str_list.IndexOfName('��˰��'),i])/(1+strtofloat(StringGrid1.Cells[str_list.IndexOfName('˰��'),i])*0.01); // �۸񲻺�˰
//              cds22.FieldByName('TAX_2').Value:=StringGrid1.Cells[str_list.IndexOfName('˰��'),i]; //˰��
//              cds22.FieldByName('BARCODE_ID').Value:=StringGrid1.Cells[str_list.IndexOfName('��ע'),i];//ԭ������
//              cds22.FieldByName('spec_place').Value:=StringGrid1.Cells[str_list.IndexOfName('��ϸλ��'),i]; //��ϸλ��
//              cds22.FieldByName('EXPIRE_DATE').Value:=StrToDate(StringGrid1.Cells[str_list.IndexOfName('��������'),i])+StrToInt(StringGrid1.Cells[str_list.IndexOfName('������Ч��'),i]);//��Ч��(��)
//              cds22.FieldByName('rohs').Value:=StringGrid1.Cells[str_list.IndexOfName('������ʶ'),i]; //����ROHS
//              cds22.FieldByName('TDATE').Value:=StringGrid1.Cells[str_list.IndexOfName('��������'),i]; //��������
//              cds22.FieldByName('SUPPLIER2').Value:=StringGrid1.Cells[str_list.IndexOfName('�ر�Ҫ��'),i];//�ر�Ҫ��
//              cds22.FieldByName('D456_IDKey').Value:=cds456.FieldByName('idkey').Value;
//              cds22.FieldByName('rkey391').Value:=StringGrid1.Cells[str_list.IndexOfName('Rkey391'),i];//391
//              if (StringGrid1.Cells[str_list.IndexOfName('��CAF'),i]<>'') then
//              cds22.FieldByName('PACKING_SLIP_FLAG').Value:=StringGrid1.Cells[str_list.IndexOfName('��CAF'),i]; //��CAF
//              cds22.FieldByName('TTYPE').Value:=2;//2��PO�ջ�3�Ӳ���PO�ջ�
//              cds22.FieldByName('STOCK_BASE').Value:=StrToFloat(StringGrid1.Cells[str_list.IndexOfName('���ϵ���KG'),i]); //��������
//              cds22.Post;
//
              if (StringGrid1.Cells[str_list.IndexOfName('IF���'),i]='Y') and (StringGrid1.Cells[str_list.IndexOfName('Rkey391'),i]<>'') then
              begin
                Lstr391:=Lstr391+StringGrid1.Cells[str_list.IndexOfName('Rkey391'),i]+',';
              end;
              if (StringGrid1.Cells[str_list.IndexOfName('71rkey'),i]<>'') then
              begin
                Lstr71:=Lstr71+StringGrid1.Cells[str_list.IndexOfName('71rkey'),i]+',';
              end;
              if (StringGrid1.Cells[str_list.IndexOfName('17rkey'),i]<>'') then
              begin
                Lstr17:=Lstr17+StringGrid1.Cells[str_list.IndexOfName('17rkey'),i]+',';
              end;
              LiTmp:=LiTmp+1;
//            end;
          end;
          if (LiTmp>0) then
          begin
            Lsq391:='select * from data0391 where rkey in (' + Lstr391+'-1)';
            Lsq71:='select * from data0071 where rkey in (' + Lstr71+'-1)';
            Lsq04:='select * from data0004 where table_name=''data0456''';
            Lsq70_2:='select * from Data0070 where rkey='+cds456.FieldByName('PO_PTR').AsString+'';
            Lsq17:='select * from data0017 where rkey in (' + Lstr17+'-1)';
            if not gSvrIntf.IntfGetDataBySqlArr(VarArrayOf([Lsq391,Lsq71,Lsq04,Lsq70_2,Lsq17]),[cds391,cds71,cds04,cds70,cds17]) then Exit;
            if not cds22.IsEmpty then
            while not cds22.Eof do cds22.Delete;

            for i:=1 to StringGrid1.RowCount-1 do
            begin
              if (StrToFloat(StringGrid1.Cells[str_list.IndexOfName('��ǰ����'),i])>0) then
              begin
              //�޸�391״̬��391
                cds391.Filtered:=False;
                cds391.Filter:='';
                cds391.Filter:='Rkey ='+StringGrid1.Cells[str_list.IndexOfName('Rkey391'),i];
                cds391.Filtered:=True;
                if not cds391.IsEmpty then
                begin
                  cds391.Edit;
                  cds391.FieldByName('stock_over').Value:=1;
                  cds391.Post;
                end;
              //�޸�71�ѽ�����
                cds71.Filtered:=False;
                cds71.Filter:='';
                cds71.Filter:='Rkey ='+StringGrid1.Cells[str_list.IndexOfName('71rkey'),i];
                cds71.Filtered:=True;
                if not cds71.IsEmpty then
                begin
                  cds71.Edit;
                  cds71.FieldByName('QUAN_RECD').Value:=cds71.FieldByName('QUAN_RECD').Value+StrToFloat(StringGrid1.Cells[str_list.IndexOfName('��ǰ����'),i])/StrtoFloat(StringGrid1.Cells[str_list.IndexOfName('ת����'),i]); //�ѽ��յ�����
                  cds71.FieldByName('recd_DATE').Value:=dtpReqDate.DateTime; //�������������
                  cds71.Post;
//                  if ((cds71.FieldByName('QUAN_RECD').Value>cds71.FieldByName('QUAN_IN_INSP').Value) and (cds71.FieldByName('avl_flag').Value='Y')) then LCaseSL:=True;
//                  if (cds71.FieldByName('QUAN_RECD').Value<cds71.FieldByName('QUAN_ORD').Value) then LCase70:=True;
                end;
//                cds22.Filter:= '';
                cds22.Append;
                cds22.FieldByName('INVENTORY_PTR').Value:=StringGrid1.Cells[str_list.IndexOfName('17rkey'),i]; //ԭ����ָ��0017
                cds22.FieldByName('SOURCE_PTR').Value:=StringGrid1.Cells[str_list.IndexOfName('71rkey'),i]; //data0071.rkey
                cds22.FieldByName('LOCATION_PTR').Value:=StringGrid1.Cells[str_list.IndexOfName('16rkey'),i]; //�ֿ�λ��data0016
                cds22.FieldByName('LOCATION_PTR_FROM').Value:=StringGrid1.Cells[str_list.IndexOfName('�����λ02'),i]; //�����λ02
                cds22.FieldByName('QUANTITY').Value:=StringGrid1.Cells[str_list.IndexOfName('��ǰ����'),i]; //�ѽ��յ�����
                cds22.FieldByName('QUAN_ON_HAND').Value:=StringGrid1.Cells[str_list.IndexOfName('��ǰ����'),i];//�ֳ�������
                cds22.FieldByName('tax_price').Value:=StringGrid1.Cells[str_list.IndexOfName('��˰��'),i];//�۸�˰
                cds22.FieldByName('PRICE').Value:=StrToCurr(StringGrid1.Cells[str_list.IndexOfName('��˰��'),i])/(1+strtofloat(StringGrid1.Cells[str_list.IndexOfName('˰��'),i])*0.01); // �۸񲻺�˰
                cds22.FieldByName('TAX_2').Value:=StringGrid1.Cells[str_list.IndexOfName('˰��'),i]; //˰��
                cds22.FieldByName('BARCODE_ID').Value:=StringGrid1.Cells[str_list.IndexOfName('��ע'),i];//ԭ������
                cds22.FieldByName('spec_place').Value:=StringGrid1.Cells[str_list.IndexOfName('��ϸλ��'),i]; //��ϸλ��
                if StrToInt(StringGrid1.Cells[str_list.IndexOfName('������Ч��'),i]) = 0 then cds22.FieldByName('EXPIRE_DATE').AsVariant:= null
                else cds22.FieldByName('EXPIRE_DATE').Value:=StrToDate(StringGrid1.Cells[str_list.IndexOfName('��������'),i])+StrToInt(StringGrid1.Cells[str_list.IndexOfName('������Ч��'),i]);//��Ч��(��)
                cds22.FieldByName('rohs').Value:=StringGrid1.Cells[str_list.IndexOfName('������ʶ'),i]; //����ROHS
                cds22.FieldByName('TDATE').Value:=StringGrid1.Cells[str_list.IndexOfName('��������'),i]; //��������
                cds22.FieldByName('SUPPLIER2').Value:=StringGrid1.Cells[str_list.IndexOfName('�ر�Ҫ��'),i];//�ر�Ҫ��
                cds22.FieldByName('D456_IDKey').Value:=cds456.FieldByName('idkey').Value;
                cds22.FieldByName('rkey391').Value:=StringGrid1.Cells[str_list.IndexOfName('Rkey391'),i];//391
                if (StringGrid1.Cells[str_list.IndexOfName('��CAF'),i]<>'') then
                cds22.FieldByName('PACKING_SLIP_FLAG').Value:=StringGrid1.Cells[str_list.IndexOfName('��CAF'),i]; //��CAF
                cds22.FieldByName('TTYPE').Value:=2;//2��PO�ջ�3�Ӳ���PO�ջ�
                cds22.FieldByName('STOCK_BASE').Value:=StrToFloat(StringGrid1.Cells[str_list.IndexOfName('���ϵ���KG'),i]); //��������
                cds22.Post;

              //�޸�17�ܿ����
                cds17.Filtered:=False;
                cds17.Filter:='';
                cds17.Filter:='Rkey ='+StringGrid1.Cells[str_list.IndexOfName('17rkey'),i];
                cds17.Filtered:=True;
                if not cds17.IsEmpty then
                begin
                  cds17.Edit;
                  cds17.FieldByName('QUAN_ON_HAND').Value:=cds17.FieldByName('QUAN_ON_HAND').Value + cds22.FieldByName('quan_on_hand').Value; //17�ܿ����
                  cds17.Post;
                end;
              end;
            end;

            //����04
            cds04.Edit;
            cds04.FieldByName('SEED_VALUE').Value:=LGRName;
            cds04.Post;

            //���ж������������.����70
            for i:=1 to StringGrid1.RowCount-1 do
            begin
              cds71.Filtered:=False;
              cds71.Filter:='';
              cds71.Filter:='Rkey ='+StringGrid1.Cells[str_list.IndexOfName('71rkey'),i];
              cds71.Filtered:=True;
              if not cds71.IsEmpty then
              begin
//                if ((cds71.FieldByName('QUAN_RECD').Value>cds71.FieldByName('QUAN_IN_INSP').Value) and (cds71.FieldByName('avl_flag').Value='Y')) then LCaseSL:=True;
                if (cds71.FieldByName('QUAN_RECD').Value<cds71.FieldByName('QUAN_ORD').Value) then LCase70:=True;
              end;
            end;
            //���������Ƿ����ͨ����
//            if LCaseSL then
//            begin
//              ShowMessage('��������ʧ��,����������˼��ͨ����!');
//              Exit;
//            end;

            if (LCase70=False) then
            begin
              cds70.Edit;
              cds70.FieldByName('STATUS').Value:=6;
              cds70.Post;
            end;
            if cds456.State in [dsEdit,dsInsert] then cds456.Post;
            if cds22.State in [dsEdit,dsInsert] then cds22.Post;
            if cds71.State in [dsEdit,dsInsert] then cds71.Post;
            if cds391.State in [dsEdit,dsInsert] then cds391.Post;
            if cds04.State in [dsEdit,dsInsert] then cds04.Post;
            if cds70.State in [dsEdit,dsInsert] then cds70.Post;
            if cds17.State in [dsEdit,dsInsert] then cds17.Post;

            LPostData := VarArrayCreate([0,6],varVariant);
            if cds456.ChangeCount > 0 then
              LPostData[0] := cds456.Delta;
            if cds22.ChangeCount > 0 then
              LPostData[1] := cds22.Delta;
            if cds04.ChangeCount > 0 then
              LPostData[2] := cds04.Delta;
            if cds70.ChangeCount > 0 then
              LPostData[3] := cds70.Delta;
            if cds391.ChangeCount > 0 then
              LPostData[4] := cds391.Delta;
            if cds71.ChangeCount > 0 then
              LPostData[5] := cds71.Delta;
            if cds17.ChangeCount > 0 then
              LPostData[6] := cds17.Delta;
            if gSvrIntf.IntfPostModData('��������',33,LPostData) then
            begin
              cds456.MergeChangeLog;
              cds22.MergeChangeLog;
              cds04.MergeChangeLog;
              cds70.MergeChangeLog;
              cds391.MergeChangeLog;
              cds71.MergeChangeLog;
              cds17.MergeChangeLog;
              ShowMessage('����ɹ�');
              if Assigned(refresh) then
                refresh(nil);
              //��������
              Lstr:='SELECT Data0456.GRN_NUMBER, data0068.po_req_number,data0068.user_ptr,data0068.user_name,'
              +'data0068.user_phone,data0070.PO_NUMBER,data0073.rkey '
              +'FROM Data0456 INNER JOIN Data0070 ON Data0456.PO_PTR = Data0070.RKEY INNER JOIN '
              +'data0068 on data0070.fob = data0068.po_req_number '
              +'INNER JOIN data0073 on data0068.user_name=data0073.user_full_name  '
              +'where Data0456.GRN_NUMBER='+quotedstr(Trim(redt1.Text));
              LSql14:= 'SELECT * FROM data0014 WHERE 1=0';
              LSql314:= 'SELECT * FROM DATA0314 WHERE 1=0';
              if not gSvrIntf.IntfGetDataBySqlArr(VarArrayOf([Lstr,LSql14,LSql314]),[Lcds,cds14,cds314]) then Exit;
              if (not Lcds.IsEmpty) and (Lcds.FieldByName('user_name').AsString<>'') and (Lcds.FieldByName('user_phone').AsString<>'') then
              begin
                if messagedlg('�Ƿ����֪ͨʹ����Ա�������������?',mtConfirmation,[mbYes,mbNo],0)=mrYes  then
                begin
                  for i:=1 to StringGrid1.RowCount-1 do
                  begin
                    if (StrToFloat(StringGrid1.Cells[str_list.IndexOfName('��ǰ����'),i])>0) then
                      smsstring:=smsstring+StringGrid1.Cells[0,i]+';'+StringGrid1.Cells[1,i]+';';
                  end;
                  msg:= '��һ�����������,ʹ����Ա:'+lcds.FieldByName('user_name').AsString+':'+'��������:'+smsstring+'��֪Ϥ!';
                  cds14.Append;
                  cds14.FieldByName('MESSAGE').Value:=msg;
                  cds14.FieldByName('whosend').Value:= StrToInt(gVar.rkey73);
                  cds14.FieldByName('IDKey').Value:= gFunc.CreateIDKey;
                  cds14.Post;
                  cds314.Append;
                  cds314.FieldByName('emp_ptr').Value:= Lcds.FieldByName('Rkey').Value;
                  cds314.FieldByName('D14_IDKey').Value:= gFunc.CreateIDKey;
                  cds314.Post;
                  if cds14.State in [dsEdit,dsInsert] then cds14.Post;
                  if cds314.State in [dsEdit,dsInsert] then cds314.Post;

                  LPostData := VarArrayCreate([0,1],varVariant);
                  if cds14.ChangeCount > 0 then
                    LPostData[0] := cds14.Delta;
                  if cds314.ChangeCount > 0 then
                    LPostData[1] := cds314.Delta;
                  if gSvrIntf.IntfPostModData('��������',33,LPostData,9) then
                  begin
                    if cds14.ChangeCount > 0 then cds14.MergeChangeLog;
                    if cds314.ChangeCount > 0 then cds314.MergeChangeLog;
                    LPostData := VarArrayCreate([0,3],varVariant);
                    LPostData[1] :=Lcds.FieldByName('user_phone').AsString;
                    LPostData[2] :=msg;
                    LPostData[3] :=Lcds.FieldByName('user_full_name').AsString;
                    if not gSvrIntf.IntfspExec('POruku_Mod33',LPostData) then Exit;
                  end;
                end;
              end;
              //end��������
              Close;
            end;
          end;
        end;
        if (if22or235=235) then
        begin
          if not cds235.IsEmpty then
            while not cds235.Eof do cds235.Delete;
          for I := 1 to StringGrid2.RowCount-1 do
          begin
            if (StrToFloat(StringGrid2.Cells[str_list2.IndexOfName('��ǰ����'),i])>0) then
            begin
              cds235.Append;
              cds235.FieldByName('goods_name').Value:=StringGrid2.Cells[str_list2.IndexOfName('��Ʒ����'),i]; //��Ʒ����
              cds235.FieldByName('goods_guige').Value:=StringGrid2.Cells[str_list2.IndexOfName('��Ʒ���'),i]; //��Ʒ���
              cds235.FieldByName('goods_type').Value:=StringGrid2.Cells[str_list2.IndexOfName('��Ʒ���'),i]; //��Ʒ���
              cds235.FieldByName('D0072_PTR').Value:=StringGrid2.Cells[str_list2.IndexOfName('72rkey'),i]; //data0072.rkey
              cds235.FieldByName('location_ptr').Value:=StringGrid2.Cells[str_list2.IndexOfName('16rkey'),i]; //�ֿ�λ��data0016
              cds235.FieldByName('unit_ptr').Value:=StringGrid2.Cells[str_list2.IndexOfName('�����λ02'),i]; //�����λ02
              cds235.FieldByName('QUAN_RECD').Value:=StrToFloat(StringGrid2.Cells[str_list2.IndexOfName('��ǰ����'),i]); //�ѽ��յ�����
              cds235.FieldByName('QUAN_ON_HAND').Value:=StrToFloat(StringGrid2.Cells[str_list2.IndexOfName('��ǰ����'),i]);//�ֳ�������
              cds235.FieldByName('unit_price').Value:=StringGrid2.Cells[str_list2.IndexOfName('��˰��'),i];//�۸�˰
              cds235.FieldByName('state_tax').Value:=StringGrid2.Cells[str_list2.IndexOfName('˰��'),i]; //˰��
              cds235.FieldByName('rohs').Value:=StringGrid2.Cells[str_list2.IndexOfName('������ʶ'),i]; //����ROHS
              cds235.FieldByName('DATE_RECD').Value:=dtpReqDate.Date;
              cds235.FieldByName('EMPL_PTR').Value:=gVar.rkey05; //��������
              cds235.FieldByName('REF_NUMBER').Value:=StringGrid2.Cells[str_list2.IndexOfName('��ע'),i];//ԭ������
              cds235.FieldByName('D456_IDKey').Value:=cds456.FieldByName('idkey').Value;
              cds235.FieldByName('quan_to_ship').Value:=0;
              cds235.FieldByName('quan_returned').Value:=0;
              cds235.FieldByName('GLPTR_STATUS').Value:=0;
              cds235.Post;
            end;
            if (StringGrid2.Cells[str_list2.IndexOfName('72rkey'),i]<>'') then
            begin
              Lstr72:=Lstr72+StringGrid2.Cells[str_list2.IndexOfName('72rkey'),i]+',';
            end;
            LiTmp:=LiTmp+1;
          end;
          if (LiTmp>0) then
          begin
            Lsq72:='select * from data0072 where rkey in (' + Lstr72+'-1)';
            Lsq04:='select * from data0004 where table_name=''data0456''';
            Lsq70_2:='select * from Data0070 where rkey='+cds456.FieldByName('PO_PTR').AsString+'';
            if not gSvrIntf.IntfGetDataBySqlArr(VarArrayOf([Lsq72,Lsq04,Lsq70_2]),[cds72,cds04,cds70]) then Exit;
            for i:=1 to StringGrid2.RowCount-1 do
            begin
            //�޸�72�ѽ�����
              cds72.Filtered:=False;
              cds72.Filter:='';
              cds72.Filter:='Rkey ='+StringGrid2.Cells[str_list2.IndexOfName('72rkey'),i];
              cds72.Filtered:=True;
              if (StrToFloat(StringGrid2.Cells[str_list2.IndexOfName('��ǰ����'),i])>0) then
              begin
                if not cds72.IsEmpty then
                begin
                  cds72.Edit;
                  cds72.FieldByName('QUANTITY_RECEIVED').Value:=cds72.FieldByName('QUANTITY_RECEIVED').Value+StrToFloat(StringGrid2.Cells[str_list2.IndexOfName('��ǰ����'),i]); //�ѽ��յ�����
                  cds72.FieldByName('recd_DATE').Value:=dtpReqDate.DateTime; //�������������
                  cds72.Post;
                end;
              end;
              if (cds72.FieldByName('QUANTITY_RECEIVED').Value<cds72.FieldByName('QUAN_ORD').Value) then LCase70:=True;
            end;
            //����04
            cds04.Edit;
            cds04.FieldByName('SEED_VALUE').Value:=LGRName;
            cds04.Post;
            //���ж������������.����70
            if (LCase70=False) then
            begin
              cds70.Edit;
              cds70.FieldByName('STATUS').Value:=6;
              cds70.Post;
            end;
            if cds456.State in [dsEdit,dsInsert] then cds456.Post;
            if cds235.State in [dsEdit,dsInsert] then cds235.Post;
            if cds72.State in [dsEdit,dsInsert] then cds72.Post;
            if cds04.State in [dsEdit,dsInsert] then cds04.Post;
            if cds70.State in [dsEdit,dsInsert] then cds70.Post;

            LPostData := VarArrayCreate([0,4],varVariant);
            if cds456.ChangeCount > 0 then
              LPostData[0] := cds456.Delta;
            if cds235.ChangeCount > 0 then
              LPostData[1] := cds235.Delta;
            if cds04.ChangeCount > 0 then
              LPostData[2] := cds04.Delta;
            if cds70.ChangeCount > 0 then
              LPostData[3] := cds70.Delta;
            if cds72.ChangeCount > 0 then
              LPostData[4] := cds72.Delta;
            if gSvrIntf.IntfPostModData('��������',33,LPostData,1) then
            begin
              cds456.MergeChangeLog;
              cds235.MergeChangeLog;
            if cds04.ChangeCount > 0 then
              cds04.MergeChangeLog;
            if cds70.ChangeCount > 0 then
              cds70.MergeChangeLog;
            if cds72.ChangeCount > 0 then
              cds72.MergeChangeLog;
              ShowMessage('����ɹ�');
              if Assigned(refresh) then
              begin
                refresh(nil);
              end;
              //��������
              Lstr:='SELECT Data0456.GRN_NUMBER, data0068.po_req_number,data0068.user_ptr,data0068.user_name,'
              +'data0068.user_phone,data0070.PO_NUMBER,data0073.rkey,data0073.user_full_name '
              +'FROM Data0456 INNER JOIN Data0070 ON Data0456.PO_PTR = Data0070.RKEY INNER JOIN '
              +'data0068 on data0070.fob = data0068.po_req_number '
              +'INNER JOIN data0073 on data0068.user_name=data0073.user_full_name  '
              +'where Data0456.GRN_NUMBER='+quotedstr(Trim(redt1.Text));
              LSql14:= 'SELECT * FROM data0014 WHERE 1=0';
              LSql314:= 'SELECT * FROM DATA0314 WHERE 1=0';
              if not gSvrIntf.IntfGetDataBySqlArr(VarArrayOf([Lstr,LSql14,LSql314]),[Lcds,cds14,cds314]) then Exit;
              if (not Lcds.IsEmpty) and (Lcds.FieldByName('user_name').AsString<>'') and (Lcds.FieldByName('user_phone').AsString<>'') then
              begin
                if messagedlg('�Ƿ����֪ͨʹ����Ա�������������?',mtConfirmation,[mbYes,mbNo],0)=mrYes  then
                begin
                  for i:=1 to StringGrid2.RowCount-1 do
                  begin
                    if (StrToFloat(StringGrid2.Cells[str_list2.IndexOfName('��ǰ����'),i])>0) then
                      smsstring:=smsstring+StringGrid2.Cells[0,i]+';'+StringGrid2.Cells[1,i]+';';
                  end;
                  msg:= '��һ�����������,ʹ����Ա:'+lcds.FieldByName('user_name').AsString+':'+'��������:'+smsstring+'��֪Ϥ!';
                  cds14.Append;
                  cds14.FieldByName('MESSAGE').Value:=msg;
                  cds14.FieldByName('whosend').Value:= StrToInt(gVar.rkey73);
                  cds14.FieldByName('IDKey').Value:= gFunc.CreateIDKey;
                  cds14.Post;
                  cds314.Append;
                  cds314.FieldByName('emp_ptr').Value:= Lcds.FieldByName('Rkey').Value;
                  cds314.FieldByName('D14_IDKey').Value:= gFunc.CreateIDKey;
                  cds314.Post;
                  if cds14.State in [dsEdit,dsInsert] then cds14.Post;
                  if cds314.State in [dsEdit,dsInsert] then cds314.Post;

                  LPostData := VarArrayCreate([0,1],varVariant);
                  if cds14.ChangeCount > 0 then
                    LPostData[0] := cds14.Delta;
                  if cds314.ChangeCount > 0 then
                    LPostData[1] := cds314.Delta;
                  if gSvrIntf.IntfPostModData('��������',33,LPostData,9) then
                  begin
                    if cds14.ChangeCount > 0 then cds14.MergeChangeLog;
                    if cds314.ChangeCount > 0 then cds314.MergeChangeLog;
                    LPostData := VarArrayCreate([0,2],varVariant);
                    LPostData[0] :=Lcds.FieldByName('user_phone').AsString;
                    LPostData[1] :=msg;
                    LPostData[2] :=Lcds.FieldByName('user_full_name').AsString;
                    if not gSvrIntf.IntfspExec('POruku_Mod33',LPostData) then Exit;
                  end;
                end;
              end;
              //end��������
              Close;
            end;
          end;
        end;
      end;
      1: //�༭���������޸Ĵ�391��ȡ��������
      begin
        LCase70:=False;
        if find_quan_error(if22or235,cds456.FieldByName('Rkey').AsInteger) then
        begin
          ShowMessage('����¼�����䷢,�����ٱ༭!');
          exit;
        end;
        if (if22or235=22) then
        begin
          gSvrIntf.IntfGetDataBySql('select rkey from data0022 where quantity<>quan_on_hand and GRN_PTR='+cds456.FieldByName('Rkey').AsString,Lcds);
          if not Lcds.IsEmpty then //
          begin
            ShowMessage('����¼�����仯,�����ٱ༭!');
            exit;
          end;
          cds456.Edit;
          cds456.FieldByName('ship_BY').Value:=redt8.Text;//�ͻ���Ա
          cds456.FieldByName('DELIVER_NUMBER').Value:=redt9.Text; // ��Ӧ���ͻ�����
          cds456.FieldByName('REF_NUMBER').Value:=redt4.Text; // ��ע
          cds456.FieldByName('ship_DATE').Value:=dtpReqDate.DateTime; //�ͻ�����
          cds456.Post;

//          for I := 1 to StringGrid1.RowCount-1 do
//          begin
//            if (StringGrid1.Cells[str_list.IndexOfName('IF���'),i]='N') then
//            begin
//              Lstr71:=Lstr71+StringGrid1.Cells[str_list.IndexOfName('71rkey'),i]+',';
//            end;
//          end;
//          Lsq71:='select * from data0071 where rkey in (' + Lstr71+'-1)';
//          gSvrIntf.IntfGetDataBySql(Lsq71,cds71);
//          if not cds71.IsEmpty then
//          begin
//            for I := 1 to StringGrid1.RowCount-1 do
//            begin
//              cds71.Filtered:=False;
//              cds71.Filter:='';
//              cds71.Filter:='Rkey ='+StringGrid1.Cells[str_list.IndexOfName('71rkey'),i];
//              cds71.Filtered:=True;
//              if not cds71.IsEmpty then
//              begin
//                cds71.Edit;
//                cds71.FieldByName('QUAN_RECD').Value:=cds71.FieldByName('QUAN_RECD').Value+(StrToFloat(StringGrid1.Cells[str_list.IndexOfName('��ǰ����'),i])-StrToFloat(StringGrid1.Cells[str_list.IndexOfName('��ǰ����2'),i]))/StrtoFloat(StringGrid1.Cells[str_list.IndexOfName('ת����'),i]); //�ѽ��յ�����
//                cds71.FieldByName('recd_DATE').Value:=dtpReqDate.DateTime; //�������������
//                cds71.Post;
//              end;
//            end;
//          end;

          Lstr71:='';
          Lstr17:='';
          for I := 1 to StringGrid1.RowCount-1 do
          begin
//            if (StrToFloat(StringGrid1.Cells[str_list.IndexOfName('��ǰ����'),i])>0) then
//            begin
              Lstr71:=Lstr71+StringGrid1.Cells[str_list.IndexOfName('71rkey'),i]+',';
              Lstr17:=Lstr17+StringGrid1.Cells[str_list.IndexOfName('17rkey'),i]+',';
              Lstr391:=Lstr391+StringGrid1.Cells[str_list.IndexOfName('Rkey391'),i]+',';
//            end;
          end;

          //�޸�17�ܿ����
          Lsq17:='select * from data0017 where rkey in (' + Lstr17+'-1)';
          Lsq71:='select * from data0071 where rkey in (' + Lstr71+'-1)';
          Lsq391:='select * from data0391 where rkey in (' + Lstr391+'-1)';
          if not gSvrIntf.IntfGetDataBySqlArr(VarArrayOf([Lsq17,Lsq71,Lsq391]),[cds17,cds71,cds391]) then
          begin
            ShowMessage('ȡ������ʧ�ܣ�');
            Exit;
          end;
          for i:=1 to StringGrid1.RowCount-1 do
          begin
//            if (StrToFloat(StringGrid1.Cells[str_list.IndexOfName('��ǰ����'),i])>0) then
//            begin
            //����22�ѽ�������
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
                cds22.FieldByName('BARCODE_ID').Value:=StringGrid1.Cells[str_list.IndexOfName('�ر�Ҫ��'),i];//�ر�Ҫ��
                cds22.FieldByName('spec_place').Value:=StringGrid1.Cells[str_list.IndexOfName('��ϸλ��'),i]; //��ϸλ��
                if StrToInt(StringGrid1.Cells[str_list.IndexOfName('������Ч��'),i]) = 0 then cds22.FieldByName('EXPIRE_DATE').AsVariant:= null
                else cds22.FieldByName('EXPIRE_DATE').Value:=StrToDate(StringGrid1.Cells[str_list.IndexOfName('��������'),i])+StrToInt(StringGrid1.Cells[str_list.IndexOfName('������Ч��'),i]);//��Ч��(��)
//                cds22.FieldByName('EXPIRE_DATE').Value:=StrToDate(StringGrid1.Cells[str_list.IndexOfName('��������'),i])+StrToInt(StringGrid1.Cells[str_list.IndexOfName('������Ч��'),i]);//��Ч��(��)
                cds22.FieldByName('TDATE').Value:=StringGrid1.Cells[str_list.IndexOfName('��������'),i]; //��������
                cds22.FieldByName('SUPPLIER2').Value:=StringGrid1.Cells[str_list.IndexOfName('��ע'),i];//ԭ������
                if (StrToFloat(StringGrid1.Cells[str_list.IndexOfName('��ǰ����'),i])>0) then
                  cds22.FieldByName('rkey391').Value:= StringGrid1.Cells[str_list.IndexOfName('rkey391'),i]//391
                else
                  cds22.FieldByName('rkey391').AsVariant:= null;
                cds22.Post;
//                if (cds22.RecordCount>1) then                     str_list.IndexOfName('��ǰ����2')
//                begin
//                  while not cds22.Eof do
//                  begin
//                    LfSL22:=LfSL22+cds22.FieldByName('quan_on_hand').Value;
//                    cds22.Next;
//                  end;
//                end else
//                begin
//                  LfSL22:=cds22.FieldByName('quan_on_hand').Value;
//                end;
              end;

              cds71.Filtered:=False;
              cds71.Filter:='';
              cds71.Filter:='Rkey ='+StringGrid1.Cells[str_list.IndexOfName('71rkey'),i];
              cds71.Filtered:=True;
              if not cds71.IsEmpty then
              begin
                cds71.Edit;
                cds71.FieldByName('QUAN_RECD').Value:=cds71.FieldByName('QUAN_RECD').Value+(StrToFloat(StringGrid1.Cells[str_list.IndexOfName('��ǰ����'),i])-StrToFloat(StringGrid1.Cells[str_list.IndexOfName('��ǰ����2'),i]))/StrtoFloat(StringGrid1.Cells[str_list.IndexOfName('ת����'),i]); //�ѽ��յ�����
                cds71.FieldByName('recd_DATE').Value:=dtpReqDate.DateTime; //�������������
                cds71.Post;
              end;

              cds17.Filtered:=False;
              cds17.Filter:='';
              cds17.Filter:='Rkey ='+StringGrid1.Cells[str_list.IndexOfName('17rkey'),i];
              cds17.Filtered:=True;
              if not cds17.IsEmpty then
              begin
                cds17.Edit;
                cds17.FieldByName('QUAN_ON_HAND').Value:=cds17.FieldByName('QUAN_ON_HAND').Value
                            + cds22.FieldByName('QUANTITY').Value - StrToCurr(StringGrid1.Cells[str_list.IndexOfName('��ǰ����2'),i]); //17�ܿ����
                cds17.Post;
              end;

              cds391.Filtered:=False;
              cds391.Filter:='';
              cds391.Filter:='Rkey ='+StringGrid1.Cells[str_list.IndexOfName('Rkey391'),i];
              cds391.Filtered:=True;
              if not cds391.IsEmpty then
              begin
                cds391.Edit;
                if (StrToFloat(StringGrid1.Cells[str_list.IndexOfName('��ǰ����'),i])=0) then
                    cds391.FieldByName('stock_over').Value:=0
                else  if (StrToFloat(StringGrid1.Cells[str_list.IndexOfName('��ǰ����'),i])>0) then
                    cds391.FieldByName('stock_over').Value:=1;
                cds391.Post;
              end;
//            end;
            //�ж�71�Ƿ�ȫ�����
            if (StrToFloat(StringGrid1.Cells[str_list.IndexOfName('��������'),i])<>(StrToFloat(StringGrid1.Cells[str_list.IndexOfName('�ѽ���'),i])+(StrToFloat(StringGrid1.Cells[str_list.IndexOfName('��ǰ����'),i])))) then LCase70:=True;
          end;

          if (LCase70=False) then
          begin
            Lsq71:='select * from data0071 where PO_PTR='+Trim(cds456.FieldByName('PO_PTR').AsString)+' and rkey not in (' + Lstr71+'-1)';
            gSvrIntf.IntfGetDataBySql(Lsq71,cds71_2);
            if not cds71_2.IsEmpty then
            begin
              cds71_2.First;
              while not cds71_2.Eof do
              begin
                if cds71_2.FieldByName('QUAN_ORD').Value<>cds71_2.FieldByName('QUAN_RECD').Value then LCase70:=True;
                cds71_2.Next;
              end;
            end;
          end;
          //���ж������������.����70

          if (LCase70=False) then
          begin
//            gSvrIntf.IntfGetDataBySql('select * from Data0070 where rkey='+cds456.FieldByName('PO_PTR').AsString+'',cds70);
//            cds70.Edit;
//            cds70.FieldByName('status').Value:=6;
//            cds70.Post;
          end else
          begin
            gSvrIntf.IntfGetDataBySql('select * from Data0070 where rkey='+cds456.FieldByName('PO_PTR').AsString+'',cds70);
            cds70.Edit;
            cds70.FieldByName('status').Value:=5;
            cds70.Post;
          end;

          if cds456.State in [dsEdit,dsInsert] then cds456.Post;
          if cds22.State in [dsEdit,dsInsert] then cds22.Post;
          if cds71.State in [dsEdit,dsInsert] then cds71.Post;
          if cds391.State in [dsEdit,dsInsert] then cds391.Post;
          if cds04.State in [dsEdit,dsInsert] then cds04.Post;
          if cds70.State in [dsEdit,dsInsert] then cds70.Post;
          if cds17.State in [dsEdit,dsInsert] then cds17.Post;

          LPostData := VarArrayCreate([0,6],varVariant);
          if cds456.ChangeCount > 0 then
            LPostData[0] := cds456.Delta;
          if cds22.ChangeCount > 0 then
            LPostData[1] := cds22.Delta;
          if cds04.ChangeCount > 0 then
            LPostData[2] := cds04.Delta;
          if cds70.ChangeCount > 0 then
            LPostData[3] := cds70.Delta;
          if cds391.ChangeCount > 0 then
            LPostData[4] := cds391.Delta;
          if cds71.ChangeCount > 0 then
            LPostData[5] := cds71.Delta;
          if cds17.ChangeCount > 0 then
            LPostData[6] := cds17.Delta;
          if gSvrIntf.IntfPostModData('��������',33,LPostData) then
          begin
            if cds456.ChangeCount > 0 then  cds456.MergeChangeLog;
            if cds22.ChangeCount > 0 then  cds22.MergeChangeLog;
            if cds04.ChangeCount > 0 then  cds04.MergeChangeLog;
            if cds70.ChangeCount > 0 then  cds70.MergeChangeLog;
            if cds391.ChangeCount > 0 then  cds391.MergeChangeLog;
            if cds71.ChangeCount > 0 then  cds71.MergeChangeLog;
            if cds17.ChangeCount > 0 then  cds17.MergeChangeLog;
            ShowMessage('����ɹ�');
              if Assigned(refresh) then
              begin
                refresh(nil);
              end;
            Close;
          end;
        end;
        if (if22or235=235) then
        begin
          Lstr72:='';
          cds456.Edit;
          cds456.FieldByName('ship_BY').Value:=redt8.Text;//�ͻ���Ա
          cds456.FieldByName('DELIVER_NUMBER').Value:=redt9.Text; // ��Ӧ���ͻ�����
          cds456.FieldByName('REF_NUMBER').Value:=redt4.Text; // ��ע
          cds456.FieldByName('ship_DATE').Value:=dtpReqDate.DateTime; //�ͻ�����
          cds456.FieldByName('STATUS').Value:=1;
          cds456.Post;
          //72����������Ϊ��ǰ��������
          for I := 1 to StringGrid2.RowCount-1 do
          begin
            if (StringGrid2.Cells[str_list2.IndexOfName('72rkey'),i]<>'') then
            Lstr72:=Lstr72+StringGrid2.Cells[str_list2.IndexOfName('72rkey'),i]+',';
          end;
          Lsq72:='select * from data0072 where rkey in (' + Lstr72+'-1)';
          gSvrIntf.IntfGetDataBySql(Lsq72,cds72);
          if not cds72.IsEmpty then
          begin
            for I := 1 to StringGrid2.RowCount-1 do
            begin
              cds72.Filtered:=False;
              cds72.Filter:='';
              cds72.Filter:='Rkey ='+StringGrid2.Cells[str_list2.IndexOfName('72rkey'),i];
              cds72.Filtered:=True;
              if not cds72.IsEmpty then
              begin
                cds72.Edit;
                cds72.FieldByName('QUANTITY_RECEIVED').Value:=cds72.FieldByName('QUANTITY_RECEIVED').Value+(Strtofloat(StringGrid2.Cells[str_list2.IndexOfName('��ǰ����'),i])-Strtofloat(StringGrid2.Cells[str_list2.IndexOfName('��ǰ����2'),i])); //�ѽ��յ�����
                cds72.Post;
              end;
              if (cds72.FieldByName('QUANTITY_RECEIVED').Value<cds72.FieldByName('QUAN_ORD').Value) then LCase70:=True;
            end;
          end;
          //����235
          for I := 1 to StringGrid2.RowCount-1 do
          begin
            if (StrToFloat(StringGrid2.Cells[str_list2.IndexOfName('��ǰ����'),i])>0) then
            begin
              cds235.Filtered:=False;
              cds235.Filter:='';
              cds235.Filter:='Rkey ='+StringGrid2.Cells[str_list2.IndexOfName('rkey'),i];
              cds235.Filtered:=True;
              if not cds235.IsEmpty then
              begin
                cds235.Edit;
                cds235.FieldByName('location_ptr').Value:=StringGrid2.Cells[str_list2.IndexOfName('16rkey'),i]; //�ֿ�λ��data0016
                cds235.FieldByName('QUAN_RECD').Value:=StrToFloat(StringGrid2.Cells[str_list2.IndexOfName('��ǰ����'),i]); //�ѽ��յ�����
                cds235.FieldByName('QUAN_ON_HAND').Value:=StrToFloat(StringGrid2.Cells[str_list2.IndexOfName('��ǰ����'),i]);//�ֳ�������
                cds235.FieldByName('rohs').Value:=StringGrid2.Cells[str_list2.IndexOfName('������ʶ'),i]; //����ROHS
                cds235.FieldByName('REF_NUMBER').Value:=StringGrid2.Cells[str_list2.IndexOfName('��ע'),i];//ԭ������
                cds235.Post;
              end;
            end;
          end;

          if (LCase70=False) then
          begin
            Lsq72:='select * from data0072 where POPTR='+Trim(cds456.FieldByName('PO_PTR').AsString)+' and rkey not in (' + Lstr72+'-1)';
            gSvrIntf.IntfGetDataBySql(Lsq72,cds72_2);
            if not cds72_2.IsEmpty then
            begin
              cds72_2.First;
              while not cds72_2.Eof do
              begin
                if cds72_2.FieldByName('QUAN_ORD').Value<>cds72_2.FieldByName('QUANTITY_RECEIVED').Value then LCase70:=True;
                cds72_2.Next;
              end;
            end;
          end;

          //�޸�70״̬
          if (LCase70=False) then
          begin
            gSvrIntf.IntfGetDataBySql('select * from Data0070 where rkey='+cds456.FieldByName('PO_PTR').AsString+'',cds70);
            cds70.Edit;
            cds70.FieldByName('status').Value:=6;
            cds70.Post;
          end else
          begin
            gSvrIntf.IntfGetDataBySql('select * from Data0070 where rkey='+cds456.FieldByName('PO_PTR').AsString+'',cds70);
            cds70.Edit;
            cds70.FieldByName('status').Value:=5;
            cds70.Post;
          end;

            if cds456.State in [dsEdit,dsInsert] then cds456.Post;
            if cds235.State in [dsEdit,dsInsert] then cds235.Post;
            if cds72.State in [dsEdit,dsInsert] then cds72.Post;
            if cds04.State in [dsEdit,dsInsert] then cds04.Post;
            if cds70.State in [dsEdit,dsInsert] then cds70.Post;

            LPostData := VarArrayCreate([0,4],varVariant);
            if cds456.ChangeCount > 0 then
              LPostData[0] := cds456.Delta;
            if cds235.ChangeCount > 0 then
              LPostData[1] := cds235.Delta;
            if cds04.ChangeCount > 0 then
              LPostData[2] := cds04.Delta;
            if cds70.ChangeCount > 0 then
              LPostData[3] := cds70.Delta;
            if cds72.ChangeCount > 0 then
              LPostData[4] := cds72.Delta;
            if gSvrIntf.IntfPostModData('��������',33,LPostData,1) then
            begin
              cds456.MergeChangeLog;
              cds235.MergeChangeLog;
            if cds04.ChangeCount > 0 then
              cds04.MergeChangeLog;
            if cds70.ChangeCount > 0 then
              cds70.MergeChangeLog;
            if cds72.ChangeCount > 0 then
              cds72.MergeChangeLog;
              ShowMessage('����ɹ�');
              if Assigned(refresh) then
                refresh(nil);
              Close;
            end;
        end;
      end;
    end;
  finally
    Lcds.Free;
  end;
end;

procedure TfrmPOruku_Mod33.Button1Click(Sender: TObject);
var i,iCount:Integer;
    Lcds:TClientDataSet;
begin
  inherited;
  Lcds:=TClientDataSet.Create(Self);
  try
//ֻҪ�Ǽ����ϣ����ձ����391IQC�ж�ȡ��Ϣ----
      if (if22or235=22) then
      begin
        if (FEditType=0) then
        begin
          iCount:=0;
          for I := 1 to StringGrid1.RowCount-1 do
          begin
            if (StringGrid1.Cells[str_list.IndexOfName('IF���'),i]='Y') and (StrToFloat(StringGrid1.Cells[str_list.IndexOfName('��������'),i])>StrToFloat(StringGrid1.Cells[str_list.IndexOfName('�ѽ���'),i])) then
            begin
              if not gSvrIntf.IntfGetDataBySql('select * from data0391 where Rkey71='+StringGrid1.Cells[str_list.IndexOfName('71rkey'),i]+' and Rkey17='+StringGrid1.Cells[str_list.IndexOfName('17rkey'),i]+' and stock_over=0 and ( status=2 or status=1 ) order by auth_date',LCds) then Exit;
              if (not Lcds.IsEmpty) then  //��Ӧһ��IQC�������391
              begin
                iCount:=iCount+1;
                StringGrid1.Cells[str_list.IndexOfName('��ǰ����'),i]:= CurrToStr(LCds.FieldByName('rece_qty').Value * StrtoFloat(StringGrid1.Cells[str_list.IndexOfName('ת����'),i]));
                StringGrid1.Cells[str_list.IndexOfName('��������'),i]:=LCds.FieldByName('manufacture_TDATE').AsString;
                StringGrid1.Cells[str_list.IndexOfName('��ע'),i]:=LCds.FieldByName('barch_no').AsString;
                StringGrid1.Cells[str_list.IndexOfName('mark'),i]:=IntToStr(Lcds.RecordCount);
                StringGrid1.Cells[str_list.IndexOfName('Rkey391'),i]:=Lcds.FieldByName('Rkey').AsString;
                StringGrid1.Cells[str_list.IndexOfName('�ر�Ҫ��'),i]:=LCds.FieldByName('supplier_model').AsString;
              end;
            end else if (StringGrid1.Cells[str_list.IndexOfName('IF���'),i]='N') then
            begin
              StringGrid1.Cells[str_list.IndexOfName('��ǰ����'),i]:=StringGrid1.Cells[str_list.IndexOfName('�ѽ���'),i];
            end;
          end;
          if (iCount=0) then
          begin
            ShowMessage('��ǰICQû��ͨ������');
          end;
        end else
        if (FEditType=2) then
        begin
          for I := 1 to StringGrid1.RowCount-1 do
          begin
            if (StringGrid1.Cells[str_list.IndexOfName('IF���'),i]='N') then
            StringGrid1.Cells[str_list.IndexOfName('��ǰ����'),i]:=StringGrid1.Cells[str_list.IndexOfName('�ѽ���'),i];
          end;
        end;
      end else
      if (if22or235=235) then
      begin
        for I := 1 to StringGrid2.RowCount-1 do
        begin
          StringGrid2.Cells[str_list2.IndexOfName('��ǰ����'),i]:=FloatToStr(StrToFloat(StringGrid2.Cells[str_list2.IndexOfName('��������'),i])-StrToFloat(StringGrid2.Cells[str_list2.IndexOfName('�ѽ���'),i]));
        end;
      end;
  finally
    LCds.Free;
  end;
end;

procedure TfrmPOruku_Mod33.Button2Click(Sender: TObject);
var i,iCount:Integer;
    Lcds:TClientDataSet;
begin
  inherited;
  Lcds:=TClientDataSet.Create(Self);
  iCount:=0;
  try
//ֻҪ�Ǽ����ϣ����ձ����391IQC�ж�ȡ��Ϣ----
    for I := 1 to StringGrid1.RowCount-1 do
    begin
      if (StringGrid1.Cells[str_list.IndexOfName('IF���'),i]='Y') and (StrToFloat(StringGrid1.Cells[str_list.IndexOfName('��������'),i])>StrToFloat(StringGrid1.Cells[str_list.IndexOfName('�ѽ���'),i])) then
      begin
        if not gSvrIntf.IntfGetDataBySql('select * from data0391 where Rkey71='+StringGrid1.Cells[str_list.IndexOfName('71rkey'),i]+' and Rkey17='+StringGrid1.Cells[str_list.IndexOfName('17rkey'),i]+' and stock_over=0 and ( status=2 or status=1 ) order by auth_date',LCds) then Exit;
        if (not Lcds.IsEmpty) then  //��Ӧһ��IQC�������391
        begin
          iCount:=iCount+1;
          StringGrid1.Cells[str_list.IndexOfName('��ǰ����'),i]:= CurrToStr(LCds.FieldByName('rece_qty').Value * StrtoFloat(StringGrid1.Cells[str_list.IndexOfName('ת����'),i]));
          StringGrid1.Cells[str_list.IndexOfName('��������'),i]:=LCds.FieldByName('manufacture_TDATE').AsString;
          StringGrid1.Cells[str_list.IndexOfName('��ע'),i]:=LCds.FieldByName('barch_no').AsString;
          StringGrid1.Cells[str_list.IndexOfName('�ر�Ҫ��'),i]:=LCds.FieldByName('supplier_model').AsString;
          StringGrid1.Cells[str_list.IndexOfName('mark'),i]:=IntToStr(Lcds.RecordCount);
          StringGrid1.Cells[str_list.IndexOfName('Rkey391'),i]:=Lcds.FieldByName('Rkey').AsString;
        end;
      end else Continue;
    end;
    if (iCount=0) then
    begin
      ShowMessage('��ǰICQû��ͨ������');
    end;
  finally
    LCds.Free;
  end;
end;

procedure TfrmPOruku_Mod33.CBlocExit(Sender: TObject);
begin
  inherited;
  if (if22or235=22) then
  begin
    if (CBloc.itemindex<>-1) then
    begin
    StringGrid1.Cells[str_list.IndexOfName('�ֿ�λ��'),StringGrid1.Row]:=CBLoc.Text;
    StringGrid1.Cells[str_list.IndexOfName('16rkey'),StringGrid1.Row]:=IntToStr(integer(CBloc.items.objects[CBloc.itemindex]));
    end;
  end;
  if (if22or235=235) then
  begin
    if (CBloc.itemindex<>-1) then
    begin
    StringGrid2.Cells[str_list2.IndexOfName('�ֿ�λ��'),StringGrid2.Row]:=CBLoc.Text;
    StringGrid2.Cells[str_list2.IndexOfName('16rkey'),StringGrid2.Row]:=IntToStr(integer(CBloc.items.objects[CBloc.itemindex]));
    end;
  end;
end;

procedure TfrmPOruku_Mod33.CBlocKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if key=112 then CBloc.DroppedDown:=true;    //f2
  if key=13 then StringGrid1.SetFocus;
end;

procedure TfrmPOruku_Mod33.ComboBox3Exit(Sender: TObject);
begin
  inherited;
  StringGrid1.Cells[str_list.IndexOfName('��ϸλ��'),StringGrid1.Row]:=combobox3.Text;
  if (combobox3.itemindex<>-1) then
  begin
    ComboBox3.Items.Clear;
  end;
end;

procedure TfrmPOruku_Mod33.ComboBox3KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if key=112 then ComboBox3.DroppedDown:=true;    //f2
  if key=13 then StringGrid1.SetFocus;
end;

procedure TfrmPOruku_Mod33.dtpk1Exit(Sender: TObject);
begin
  inherited;
  StringGrid1.Cells[str_list.IndexOfName('��������'),StringGrid1.Row]:=datetostr(dtpk1.Date);
end;

procedure TfrmPOruku_Mod33.dtpk1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if key=13 then StringGrid1.SetFocus;
end;

procedure TfrmPOruku_Mod33.EnableButton(Fool: Boolean);
begin
  btnSave.Enabled:=Fool;
  StringGrid1.Enabled:=Fool;
  StringGrid2.Enabled:=Fool;
  CheckBox3.Enabled:=Fool;
  CheckBox2.Enabled:=Fool;
  Button1.Enabled:=Fool;
end;

procedure TfrmPOruku_Mod33.EnableEdit;
begin
  redt1.ReadOnly:=True;
  redt2.ReadOnly:=True;
  redt3.ReadOnly:=True;
  redt5.ReadOnly:=True;
  redt6.ReadOnly:=True;
  redt7.ReadOnly:=True;
end;

function TfrmPOruku_Mod33.find_maxdate: TDatetime;
var Lcds:TClientDataSet;
begin
  Lcds:=TClientDataSet.Create(Self);
  try
    gSvrIntf.IntfGetDataBySql('SELECT isnull(MAX(MATL_DATE),0) AS MATL_DATE FROM Data0444',Lcds);
    if not Lcds.IsEmpty  then
      Result:=Lcds.fieldbyname('MATL_DATE').AsDateTime
    else Result:=Null;
  finally
    Lcds.Free;
  end;
end;

function TfrmPOruku_Mod33.find_quan_error(TType, Rkey456: Integer): boolean;
var Lcds:TClientDataSet;
begin
  result:=false;
  Lcds:=TClientDataSet.Create(Self);
  try
    if (TType=22) then
    begin
      gSvrIntf.IntfGetDataBySql('select rkey from data0022 where quantity<>quan_on_hand and grn_ptr='+IntToStr(Rkey456),Lcds);
      if not Lcds.IsEmpty then Result:=True;
    end else
    if (TType=235) then
    begin
      gSvrIntf.IntfGetDataBySql('select rkey from data0235 where quan_recd<>quan_on_hand and grn_ptr='+IntToStr(Rkey456),Lcds);
      if not Lcds.IsEmpty then Result:=True;
    end;
  finally
    Lcds.Free;
  end;
end;

procedure TfrmPOruku_Mod33.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  inherited;
  Action := caFree;
  frmPOruku_Mod33 := nil;
end;

procedure TfrmPOruku_Mod33.GetData(ARkey: string);
var
  LSq456,LSq22,Lsq235: string;
begin
  // data0456
  LSq456 := 'select * from data0456 where rkey = ' + ARkey;
  // data0022
  LSq22 := 'select * from data0022 where GRN_PTR = ' + ARkey;
  // data0235
  Lsq235 := 'select * from data0235 where GRN_PTR = ' + ARkey;

  if not gSvrIntf.IntfGetDataBySqlArr(VarArrayOf([LSq456,LSq22,Lsq235]),[cds456,cds22,cds235]) then Exit;

  if (FEditType=0)or (FEditType=1) then
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
    //235
    cds235.DisableControls;
    try
      cds235.First;
      while not cds235.Eof do
      begin
        cds235.Edit;
        cds235.FieldByName('D456_IDKey').AsString := cds456.FieldByName('IDKEY').AsString;
        cds235.Post;
        cds235.Next;
      end;
      cds235.First;
    finally
      cds235.EnableControls;
    end;
  end;
end;

procedure TfrmPOruku_Mod33.get_location;
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

function TfrmPOruku_Mod33.IfDateNow(): Boolean;
var i:Integer;
begin
  Result:=False;
  for I := 1 to StringGrid1.RowCount-1 do
  begin
    if (strtofloat(StringGrid1.Cells[str_list.IndexOfName('��ǰ����'),i])>0) and (StrToDateTime(StringGrid1.Cells[str_list.IndexOfName('��������'),i])>gFunc.GetSvrDateTime)  then
    begin
      Result:=True;
      Break;
    end;
  end;
end;

function TfrmPOruku_Mod33.IfWarehouse(TType:Integer): Boolean;
var i:Integer;
begin
  Result:=False;
  if (TType=22) then
  begin
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
  end else
  if (TType=235) then
  begin
    for I := 1 to StringGrid2.RowCount-1 do
    begin
      if (StringGrid2.Cells[str_list2.IndexOfName('�ֿ�λ��'),i]='') and (strtofloat(StringGrid2.Cells[str_list2.IndexOfName('��ǰ����'),i])>0) then
      begin
        Result:=True;
        Break;
      end;
    end;
    for i:=1 to StringGrid2.RowCount-1 do
    begin
      if (strtofloat(StringGrid2.Cells[str_list2.IndexOfName('��ǰ����'),i])>0) then
        break//������һ���������
      else
      if (i=StringGrid2.RowCount-1) then Result:=true;
    end;
  end;
end;

procedure TfrmPOruku_Mod33.init;
var j,i:integer;
begin
  StringGrid1.Update;
  for j :=StringGrid1.RowCount  downto 0  do
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
  str_list.Add('��������=QUAN_ORD');
  str_list.Add('ת����=CONVERSION_FACTOR');
  str_list.Add('�ѽ���=QUAN_RECD');
  str_list.Add('�����λ=pr_unitname');
  str_list.Add('��ǰ����=QUANTITY');
  str_list.Add('�ֿ�λ��=LOCATION');
//  str_list.Add('����������=SUPPLIER2');
  str_list.Add('��ע=BARCODE_ID');
  str_list.Add('��ϸλ��=spec_place');
  str_list.Add('�ر�Ҫ��=SUPPLIER2');
  str_list.Add('IF���=avl_flag');
  str_list.Add('��������=TDATE');
  str_list.Add('������ʶ=rohs');
  str_list.Add('��CAF=IF_CAF');
  str_list.Add('IQC�Ѽ�������=QUAN_IN_INSP');
  str_list.Add('71rkey=SOURCE_PTR');
  str_list.Add('17rkey=INVT_PTR');
  str_list.Add('�����λ02=WO_PTR');
  str_list.Add('��˰��=tax_PRICE');
  str_list.Add('˰��=TAX_2');
  str_list.Add('16rkey=LOCATION_PTR');
  str_list.Add('������Ч��=SHELF_LIFE');
  str_list.Add('���ϵ���KG=STOCK_BASE');
  str_list.Add('mark=mark');
  str_list.Add('Rkey391=Rkey391');
  str_list.Add('extra_req=extra_req');
  str_list.Add('�ֳ�����=QUAN_ON_HAND');
  str_list.Add('��ǰ����2=QUANTITY');
  str_list.Add('Rkey=Rkey');
  StringGrid1.ColCount:=str_list.Count;
  for j := 0 to str_list.Count-1  do    //SGrd��ӵ�һ�е��ֶ���
  begin
    StringGrid1.Cells[j,0] := str_list.Names[j];
  end;
  StringGrid1.RowCount:=2;
  StringGrid1.FixedRows:=1;
  StringGrid1.ColWidths[str_list.IndexOfName('IQC�Ѽ�������')]:=-1;
  StringGrid1.ColWidths[str_list.IndexOfName('71rkey')]:=-1;
  StringGrid1.ColWidths[str_list.IndexOfName('17rkey')]:=-1;
  StringGrid1.ColWidths[str_list.IndexOfName('�����λ02')]:=-1;
  StringGrid1.ColWidths[str_list.IndexOfName('��˰��')]:=-1;
  StringGrid1.ColWidths[str_list.IndexOfName('˰��')]:=-1;
  StringGrid1.ColWidths[str_list.IndexOfName('16rkey')]:=-1;
  StringGrid1.ColWidths[str_list.IndexOfName('������Ч��')]:=-1;
  StringGrid1.ColWidths[str_list.IndexOfName('���ϵ���KG')]:=-1;
  StringGrid1.ColWidths[str_list.IndexOfName('mark')]:=-1;
  StringGrid1.ColWidths[str_list.IndexOfName('Rkey391')]:=-1;
  StringGrid1.ColWidths[str_list.IndexOfName('�ر�Ҫ��')]:=-1;
  StringGrid1.ColWidths[str_list.IndexOfName('�ֳ�����')]:=-1;
  StringGrid1.ColWidths[str_list.IndexOfName('extra_req')]:=-1;
  StringGrid1.ColWidths[str_list.IndexOfName('��ǰ����2')]:=-1;
  StringGrid1.ColWidths[str_list.IndexOfName('Rkey')]:=-1;
//  StringGrid1.ColWidths[str_list.IndexOfName('�ֿ�λ��')]:=100;
end;

procedure TfrmPOruku_Mod33.init2;
var j,i:integer;
begin
  StringGrid2.Update;
  for j :=StringGrid2.RowCount  downto 1  do
  begin
    for i:=0 to StringGrid2.ColCount do
    begin
      StringGrid2.Cells[i,j]:='';
    end;
    StringGrid2.rowcount := StringGrid2.rowcount - 1;
  end;
  str_list2 := TStringList.Create;
  str_list2.Add('��Ʒ����=goods_name');
  str_list2.Add('��Ʒ���=goods_guige');
  str_list2.Add('��Ʒ���=goods_type');
  str_list2.Add('��������=QUAN_ORD');
  str_list2.Add('�ѽ���=QUANTITY_RECEIVED');
  str_list2.Add('�ɹ���λ=UNIT_NAME');
  str_list2.Add('��ǰ����=QUAN_RECD');
  str_list2.Add('�ֿ�λ��=LOCATION');
  str_list2.Add('������ʶ=rohs');
  str_list2.Add('��ע=REF_NUMBER');
  str_list2.Add('72rkey=SOURCE_PTR');
  str_list2.Add('�����λ02=unit_ptr');
  str_list2.Add('��˰��=unit_price');
  str_list2.Add('˰��=state_tax');
  str_list2.Add('16rkey=location_ptr');
  str_list2.Add('������Ч��=DATE_RECD');
  str_list2.Add('��ǰ���=QUAN_ON_HAND');
  str_list2.Add('��ǰ����2=QUAN_RECD');
  str_list2.Add('Rkey=Rkey');
  StringGrid2.ColCount:=str_list2.Count;
  for j := 0 to str_list2.Count-1  do    //SGrd��ӵ�һ�е��ֶ���
  begin
    StringGrid2.Cells[j,0] := str_list2.Names[j];
  end;
  StringGrid2.RowCount:=2;
  StringGrid2.FixedRows:=1;
  StringGrid2.ColWidths[str_list2.IndexOfName('72rkey')]:=-1;
  StringGrid2.ColWidths[str_list2.IndexOfName('�����λ02')]:=-1;
  StringGrid2.ColWidths[str_list2.IndexOfName('��˰��')]:=-1;
  StringGrid2.ColWidths[str_list2.IndexOfName('˰��')]:=-1;
  StringGrid2.ColWidths[str_list2.IndexOfName('16rkey')]:=-1;
  StringGrid2.ColWidths[str_list2.IndexOfName('������Ч��')]:=-1;
  StringGrid2.ColWidths[str_list2.IndexOfName('��ǰ���')]:=-1;
  StringGrid2.ColWidths[str_list2.IndexOfName('��ǰ����2')]:=-1;
  StringGrid2.ColWidths[str_list2.IndexOfName('Rkey')]:=-1;
//  StringGrid2.ColWidths[str_list2.IndexOfName('�ֿ�λ��')]:=100;
end;

procedure TfrmPOruku_Mod33.IQC1Click(Sender: TObject);
var
  LFrm: TfrmSeleIQC_Mod33;
begin
  inherited;
   //��Ӧ����IQC�������391
  LFrm := TfrmSeleIQC_Mod33.Create(Self);
  try
    LFrm.GetData(StringGrid1.Cells[str_list.IndexOfName('71rkey'),StringGrid1.Row],StringGrid1.Cells[str_list.IndexOfName('17rkey'),StringGrid1.Row]);
    if LFrm.ShowModal = mrOk then
    begin
      StringGrid1.Cells[str_list.IndexOfName('��ǰ����'),StringGrid1.Row]:=LFrm.cds391.FieldByName('rece_qty').AsString;
      StringGrid1.Cells[str_list.IndexOfName('��������'),StringGrid1.Row]:=LFrm.cds391.FieldByName('manufacture_TDATE').AsString;
      StringGrid1.Cells[str_list.IndexOfName('��ע'),StringGrid1.Row]:=LFrm.cds391.FieldByName('barch_no').AsString;
      StringGrid1.Cells[str_list.IndexOfName('Rkey391'),StringGrid1.Row]:=LFrm.cds391.FieldByName('Rkey').AsString;
      StringGrid1.Cells[str_list.IndexOfName('�ر�Ҫ��'),StringGrid1.Row]:=LFrm.cds391.FieldByName('supplier_model').AsString;
    end;
  finally
    LFrm.Free;
  end;
end;

procedure TfrmPOruku_Mod33.N2Click(Sender: TObject);
begin
  inherited;
  if Trim(StringGrid1.Cells[1,StringGrid1.Row])<>'' then
  begin
    StringGrid1.Cells[str_list.IndexOfName('��ǰ����'),StringGrid1.Row]:='0';
//    StringGrid1.Cells[str_list.IndexOfName('��������'),StringGrid1.Row]:='';
    StringGrid1.Cells[str_list.IndexOfName('��ע'),StringGrid1.Row]:='';
//    StringGrid1.Cells[str_list.IndexOfName('Rkey391'),StringGrid1.Row]:='';
    StringGrid1.Cells[str_list.IndexOfName('�ر�Ҫ��'),StringGrid1.Row]:='';
  end;
end;

procedure TfrmPOruku_Mod33.PopupMenu1Popup(Sender: TObject);
begin
  inherited;
  if (StrToInt(StringGrid1.Cells[str_list.IndexOfName('mark'),StringGrid1.Row])>1) then
  IQC1.Enabled:=True else IQC1.Enabled:=False;
  if (StrToFloat(StringGrid1.Cells[str_list.IndexOfName('��������'),StringGrid1.Row])>
            (StrToFloat(StringGrid1.Cells[str_list.IndexOfName('�ѽ���'),StringGrid1.Row]))) then
  N2.Enabled:=True else N2.Enabled:=false;
end;

function TfrmPOruku_Mod33.Power(x, y: extended): extended;
begin
  result := exp(y*ln(x));
end;

function TfrmPOruku_Mod33.pucher_releced: boolean;
var Lcds:TClientDataSet;
    Lsq:string;
    i:integer;
begin
  Result:=False;
  Lcds:=TClientDataSet.Create(Self);
  try
    if (if22or235=22) then
    begin
      for i := 1 to StringGrid1.RowCount-1 do
      begin
        if (StrToFloat(StringGrid1.Cells[str_list.IndexOfName('��ǰ����'),i])>0) then
        begin
        Lsq:='select rkey from data0071 where rkey='+StringGrid1.Cells[str_list.IndexOfName('71rkey'),i]+
               ' and abs(QUAN_RECD-'+StringGrid1.Cells[str_list.IndexOfName('�ѽ���'),i]+') < 0.01';
        gSvrIntf.IntfGetDataBySql(Lsq,Lcds);
        if Lcds.IsEmpty then
        begin
          Result:=true;
          break;
        end;
        end;
      end;
    end else
    if (if22or235=235) then
    begin
      for i := 1 to StringGrid2.RowCount-1 do
      begin
        if (StrToFloat(StringGrid2.Cells[str_list2.IndexOfName('��ǰ����'),i])>0) then
        begin
        Lsq:='select rkey from data0072 where rkey='+StringGrid2.Cells[str_list2.IndexOfName('72rkey'),i]+
               ' and abs(QUANTITY_RECEIVED-'+StringGrid2.Cells[str_list2.IndexOfName('�ѽ���'),i]+') < 0.01';
        gSvrIntf.IntfGetDataBySql(Lsq,Lcds);
        if Lcds.IsEmpty then
        begin
          Result:=true;
          break;
        end;
        end;
      end;
    end;
  finally
    Lcds.Free;
  end;
end;

//function TfrmPOruku_Mod33.recevied_over(rkey70, vtype: Integer): Boolean;
//var Lcds:TClientDataSet;
//    Lsq:string;
//begin
//  Lcds:=TClientDataSet.Create(Self);
//  try
//    if (if22or235=22) then
//    begin
//        Lsq:='SELECT rkey FROM  dbo.Data0071 WHERE (QUAN_RECD < QUAN_ORD) and (PO_PTR='+inttostr(rkey70)+')';
//        gSvrIntf.IntfGetDataBySql(Lsq,Lcds);
//        if Lcds.IsEmpty then
//        begin
//          Result:=true;
//        end else Result:=False;
//    end else
//    if (if22or235=235) then
//    begin
//        Lsq:='SELECT rkey FROM  dbo.Data0072 WHERE (QUANTITY_RECEIVED < QUAN_ORD) and (POPTR='+inttostr(rkey70)+')';
//        gSvrIntf.IntfGetDataBySql(Lsq,Lcds);
//        if Lcds.IsEmpty then
//        begin
//          Result:=true;
//        end else Result:=False;
//    end;
//  finally
//    Lcds.Free;
//  end;
//end;

procedure TfrmPOruku_Mod33.StringGrid1DrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
  inherited;
  if (gdSelected  in State) then
  begin
    if (ACol = 13 ) then
    begin
      dtpk1.Left := Rect.Left;
      dtpk1.Top := Rect.Top+3;
      dtpk1.Width := Rect.Right - Rect.Left+3;
      dtpk1.Height := Rect.Bottom - Rect.Top;
      dtpk1.Visible := True;
      if trim(StringGrid1.Cells[acol,arow])<>'' then
      dtpk1.Date:=strtodate(StringGrid1.Cells[acol,arow]);
    end
    else
      dtpk1.Visible :=false;
  end;
end;

procedure TfrmPOruku_Mod33.StringGrid1KeyDown(Sender: TObject; var Key: Word;
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

procedure TfrmPOruku_Mod33.StringGrid1KeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if (key <> chr(9)) then    //û�а�tab��
  begin
    if (StringGrid1.Col=8) and (CBloc.Enabled) then
    begin
      CBloc.SetFocus;
      SendMessage(CBloc.Handle,WM_Char,word(Key),0);
    end;
    if (StringGrid1.Col=10) and (combobox3.Enabled) then
    begin
      ComboBox3.SetFocus;
      SendMessage(ComboBox3.Handle,WM_Char,word(Key),0);
    end;
  end;
end;

procedure TfrmPOruku_Mod33.StringGrid1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if StringGrid1.Col=str_list.IndexOfName('��ǰ����') then
  begin
    if StringGrid1.Cells[str_list.IndexOfName('��ǰ����'),StringGrid1.Row]='' then StringGrid1.Cells[str_list.IndexOfName('��ǰ����'),StringGrid1.Row]:='0';
    if (StringGrid1.Cells[str_list.IndexOfName('IF���'),StringGrid1.Row]='N') then   //�����������ܴ��ڶ�������
    if strtofloat(StringGrid1.Cells[4,StringGrid1.Row])>0 then//ת���ʴ���0
     begin
      if strtofloat(StringGrid1.Cells[7,StringGrid1.Row])>
        (strtofloat(StringGrid1.Cells[3,StringGrid1.Row])-strtofloat(StringGrid1.Cells[5,StringGrid1.Row]))*
         strtofloat(StringGrid1.Cells[4,StringGrid1.Row])  then
       StringGrid1.Cells[7,StringGrid1.Row]:=floattostr(
                                       (strtofloat(StringGrid1.Cells[3,StringGrid1.Row])-
                                        strtofloat(StringGrid1.Cells[5,StringGrid1.Row]))*
                                        strtofloat(StringGrid1.Cells[4,StringGrid1.Row])
                                                  );
     end
    else
     begin
      if strtofloat(StringGrid1.Cells[7,StringGrid1.Row])>
       (strtofloat(StringGrid1.Cells[3,StringGrid1.Row])-strtofloat(StringGrid1.Cells[5,StringGrid1.Row])) then
       StringGrid1.Cells[7,StringGrid1.Row]:=floattostr(
                                        strtofloat(StringGrid1.Cells[3,StringGrid1.Row])-
                                        strtofloat(StringGrid1.Cells[5,StringGrid1.Row])
                                                  );
     end;
  end;
end;

procedure TfrmPOruku_Mod33.StringGrid1SelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
var Lcds:TClientDataSet;
begin
  inherited;
  Lcds:=TClientDataSet.Create(Self);
  try
    if (ACol = 8 ) then
    begin
//      CBLoc.Width := StringGrid1.ColWidths[acol];
      CBLoc.Width := StringGrid1.DefaultColWidth;
      CBLoc.Height := StringGrid1.DefaultRowHeight;
      CBLoc.Left := StringGrid1.Left+(ACol-StringGrid1.LeftCol+1)*StringGrid1.DefaultColWidth+10;
      if (ARow<StringGrid1.TopRow)  then
      CBLoc.Top := StringGrid1.Top+(ARow - StringGrid1.TopRow+2)* StringGrid1.DefaultRowHeight+ (ARow - StringGrid1.TopRow+5)
      else if (((ARow + 3 - StringGrid1.TopRow ) * StringGrid1.DefaultRowHeight) > StringGrid1.Height) then
      CBLoc.Top := StringGrid1.Top+(ARow - StringGrid1.TopRow)* StringGrid1.DefaultRowHeight+ (ARow - StringGrid1.TopRow+4)
      else
      CBLoc.Top := StringGrid1.Top+(ARow - StringGrid1.TopRow+1)* StringGrid1.DefaultRowHeight+ (ARow - StringGrid1.TopRow+4);
//      if (ARow<StringGrid1.TopRow)  then
//      CBLoc.Top := StringGrid1.Top+(ARow - StringGrid1.TopRow)* StringGrid1.DefaultRowHeight+ (ARow - StringGrid1.TopRow)
//      else
//      CBLoc.Top := StringGrid1.Top+(ARow - StringGrid1.TopRow+1)* StringGrid1.DefaultRowHeight+ (ARow - StringGrid1.TopRow+1);
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
      ComboBox3.Top := StringGrid1.Top+(ARow - StringGrid1.TopRow+2)* StringGrid1.DefaultRowHeight+ (ARow - StringGrid1.TopRow+5)
      else if ((ARow + 3 - StringGrid1.TopRow ) * StringGrid1.DefaultRowHeight) > StringGrid1.Height  then
      ComboBox3.Top := StringGrid1.Top+(ARow - StringGrid1.TopRow)* StringGrid1.DefaultRowHeight+ (ARow - StringGrid1.TopRow+4)
      else
      ComboBox3.Top := StringGrid1.Top+(ARow - StringGrid1.TopRow+1)* StringGrid1.DefaultRowHeight+ (ARow - StringGrid1.TopRow+4);
//      if (ARow<StringGrid1.TopRow)  then
//      ComboBox3.Top := StringGrid1.Top+(ARow - StringGrid1.TopRow)* StringGrid1.DefaultRowHeight+ (ARow - StringGrid1.TopRow)
//      else
//      ComboBox3.Top := StringGrid1.Top+(ARow - StringGrid1.TopRow+1)* StringGrid1.DefaultRowHeight+ (ARow - StringGrid1.TopRow+1);
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
      if ((ComboBox3.Visible=True) and (StringGrid1.Cells[8,ARow]<>'')) then
      begin
        gSvrIntf.IntfGetDataBySql('select * from Data0176 where rkey_16 = ' + IntToStr(integer(CBLoc.items.objects[CBLoc.Items.IndexOf(StringGrid1.Cells[8,aRow])]))+'',Lcds);
        if not Lcds.IsEmpty then
        begin
          Lcds.First;
          combobox3.Items.Clear;
          while not Lcds.Eof do
          begin
            combobox3.Items.Add(Lcds.FieldByName('LOCATION').Value);
            Lcds.Next;
          end;
        end;
      end;
      if (StringGrid1.Cells[8,ARow]='') then
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
  if ((FEditType =0) or (FEditType =1)) and (StringGrid1.Cells[str_list.IndexOfName('IF���'),ARow]='Y') then
  begin
    if (acol<=8) or (ACol=12) or (ACol>=14) then
      StringGrid1.Options:=StringGrid1.Options-[goEditing]
    else
      StringGrid1.Options:=StringGrid1.Options+[goEditing];
  end else
  if ((FEditType =0) or (FEditType =1)) and (StringGrid1.Cells[str_list.IndexOfName('IF���'),ARow]='N') then
  begin
    if (acol<=6) or (ACol=12) or (ACol>=14) then
      StringGrid1.Options:=StringGrid1.Options-[goEditing]
    else
      StringGrid1.Options:=StringGrid1.Options+[goEditing];
  end else
  begin
    if (acol<7) or (ACol=12) or (ACol>=14) then
      StringGrid1.Options:=StringGrid1.Options-[goEditing]
    else
      StringGrid1.Options:=StringGrid1.Options+[goEditing];
  end;
end;

procedure TfrmPOruku_Mod33.StringGrid2KeyDown(Sender: TObject; var Key: Word;
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
end;

procedure TfrmPOruku_Mod33.StringGrid2KeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if (key <> chr(9)) then    //û�а�tab��
  begin
    if (StringGrid2.Col=7) then
     begin
      CBLoc.SetFocus;
      SendMessage(CBLoc.Handle,WM_Char,word(Key),0);
     end;
  end;
  if (StringGrid2.Col = 6 ) then
  begin
    if not CharInSet(key ,['0'..'9','.',#8,#13]) then  //�ж��Ƿ��������ֺ�С����
      abort
    else
    if key = chr(46) then
    begin      //�ж��Ƿ��ظ�����С����'.'
      if pos('.',StringGrid2.Cells[6,StringGrid2.Row])>0  then abort;
    end;
  end;
end;

procedure TfrmPOruku_Mod33.StringGrid2KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if StringGrid2.Col=6 then
  begin
    if StringGrid2.Cells[6,StringGrid2.Row]='' then StringGrid2.Cells[6,StringGrid2.Row]:='0';
    if stock_flag='N' then   //�����������ܴ��ڶ�������
     begin
      if strtofloat(StringGrid2.Cells[6,StringGrid2.Row])>
        (strtofloat(StringGrid2.Cells[3,StringGrid2.Row])-
        strtofloat(StringGrid2.Cells[4,StringGrid2.Row]))  then
       StringGrid2.Cells[6,StringGrid2.Row]:=floattostr(
                                       (strtofloat(StringGrid2.Cells[3,StringGrid2.Row])-
                                        strtofloat(StringGrid2.Cells[4,StringGrid2.Row])
                                        )
                                                  );
     end;
  end;
end;

procedure TfrmPOruku_Mod33.StringGrid2SelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  inherited;

  if (ACol = 7 ) then
  begin
//  CBLoc.Width := StringGrid2.ColWidths[acol];
    CBLoc.Width := StringGrid2.DefaultColWidth;
    CBLoc.Height := StringGrid2.DefaultRowHeight;
    CBLoc.Left := StringGrid2.Left+(ACol-StringGrid2.LeftCol+1)*StringGrid2.DefaultColWidth+10;
    if (ARow<StringGrid2.TopRow)  then
    CBLoc.Top := StringGrid2.Top+(ARow - StringGrid2.TopRow+2)* StringGrid2.DefaultRowHeight+ (ARow - StringGrid2.TopRow+5)
    else if ((ARow + 3 - StringGrid2.TopRow ) * StringGrid2.DefaultRowHeight) > StringGrid2.Height  then
    CBLoc.Top := StringGrid2.Top+(ARow - StringGrid2.TopRow)* StringGrid2.DefaultRowHeight+ (ARow - StringGrid2.TopRow+4)
    else
    CBLoc.Top := StringGrid2.Top+(ARow - StringGrid2.TopRow+1)* StringGrid2.DefaultRowHeight+ (ARow - StringGrid2.TopRow+4);

    CBLoc.Visible := True;
    if StringGrid2.Cells[acol,arow]<>'' then
    begin
     CBLoc.ItemIndex:=CBLoc.Items.IndexOf(StringGrid2.Cells[acol,arow]);
    end else
     CBLoc.ItemIndex:=-1;
  end
  else
    CBLoc.Visible :=false;

  if (FEditType=3) then
    StringGrid2.Options:=StringGrid2.Options-[goEditing]
  else
   if (acol=6) or (ACol=7) or (ACol=9) then
    StringGrid2.Options:=StringGrid2.Options+[goEditing]
   else
    StringGrid2.Options:=StringGrid2.Options-[goEditing];
end;

function TfrmPOruku_Mod33.update04(table_name: string;
  var LsName: string): string;
var
  i,v_length:integer;
  v_last,v_seed,new_seed:string;
begin
  if not gSvrIntf.IntfGetDataBySql('select * from data0004 where table_name='''+table_name+'''',cds04) then Exit;
  if not cds04.IsEmpty then
  begin
    v_seed:=cds04.FieldByName('SEED_VALUE').AsString;
    LsName:=v_seed;
    if cds04.FieldByName('SEED_FLAG').Value<>1 then
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

end.
