unit auto_deploy;

interface

uses
   Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
   Dialogs, Grids, DBGridEh, ExtCtrls, StdCtrls, Buttons,Unit1;

type
  TForm_auto_deploy = class(TForm)
    Panel2: TPanel;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    Label1: TLabel;
    Label2: TLabel;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    DBGridEh2: TDBGridEh;
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
     v_ReqQty:double;
     procedure MY_MESSAGE8(var Msg: TMessage);message  MYMESSAGE8;
    { Private declarations }
  public
    { Public declarations }
  function Enter(prodrKey:integer;ReqQty:integer;pa_b:integer=0):boolean;
  end;

var
  Form_auto_deploy: TForm_auto_deploy;

implementation

uses DM,MyClass,common,ConstVar;

{$R *.dfm}

procedure TForm_auto_deploy.SpeedButton1Click(Sender: TObject);
begin
MyDataClass.UpdateValueToField(dmcon.cdsWorkOrderList,true,'IsSelected');
end;

function TForm_auto_deploy.Enter(prodrKey:integer;ReqQty: integer;pa_b:integer=0):boolean;
begin
  v_ReqQty:=ReqQty;
  Label1.Caption := '��������: '+FloatToStr(v_ReqQty);
  dmcon.adsWorkOrderList.Close;
  dmcon.adsWorkOrderList.Parameters[0].Value := prodrKey;
  dmcon.adsWorkOrderList.Parameters[1].Value := pa_b;
  dmcon.adsWorkOrderList.open;
  result:=ShowModal=mrok;
end;

procedure TForm_auto_deploy.SpeedButton2Click(Sender: TObject);
begin
MyDataClass.UpdateValueToField(dmcon.cdsWorkOrderList,false,'IsSelected');
end;

procedure TForm_auto_deploy.Button1Click(Sender: TObject);
var
  old_filter,WO_List,Qty_List:string;
  i:integer;
  qty:double;
begin
  with dmcon do
  try
    old_filter:= cdsWorkOrderList.Filter;
    cdsWorkOrderList.Filter := 'IsSelected=1';
    cdsWorkOrderList.Filtered := true;
    i:=cdsWorkOrderList.RecordCount;
    if i =0 then
    begin
      ShowMsg('��ѡ����ҵ��!',1);
      abort;
    end;
    //������������ҵ�������ܱ��η�������������¼����������ҵ��rkeyֵ
    Qty:=0;
    cdsWorkOrderList.First;
    while not cdsWorkOrderList.Eof do
    begin
      Qty:=Qty+cdsWorkOrderList.FieldByName('TransQty').ASFloat;
      if WO_List = '' then
        WO_List:=cdsWorkOrderList.FieldByName('rKey').AsString
      else
        WO_List:=WO_List+','+cdsWorkOrderList.FieldByName('rKey').AsString;
      if Qty_List= '' then
        Qty_List:=cdsWorkOrderList.FieldByName('TransQty').AsString
      else
        Qty_List:=Qty_List+','+cdsWorkOrderList.FieldByName('TransQty').AsString;

      tmpQry.Close;
      tmpQry.SQL.Text:='select D06.rkey from data0006 D06 inner join data0056 D56 on D56.WO_Ptr=D06.rKey '+
                       'where d06.PROD_STATUS=6 and D06.rkey='+cdsWorkOrderList.FieldByName('rKey').AsString+
                       ' and D56.Qty_BackLog-d06.quan_allrej='+cdsWorkOrderList.FieldByName('Qty_BackLog').AsString;
      tmpQry.Open;
      if tmpQry.IsEmpty then
      begin
        ShowMsg('��ҵ��:'+cdsWorkOrderList.FieldByName('WORK_ORDER_NUMBER').AsString+'����������״̬�����ı�,����!',1);
        adsSubProds.Close;
        adsSubProds.Open;
        self.Close;
        exit;
      end;
      cdsWorkOrderList.next;
    end;

    Label2.Caption := '��������: '+FloatToStr(Qty);
    if Qty <=0 then
    begin
      ShowMsg('���ŵ��������������,��ȷ��!',1);
      exit;
    end
    else if Qty > v_ReqQty then
    begin
      ShowMsg('���ŵ�����������������,��ȷ��!',1);
      exit;
    end else  begin
      tmpQry.Close;
      tmpQry.SQL.Text:='select ceiling(Data0025.Qty_bom*Data0006.quan_sch/(QTY_PARENTBOM+0.0))-IsNULL(data0488.quan_issued,0),data0006.work_order_number '+
                        'from data0006 inner join data0025 on data0006.bom_ptr=data0025.parent_ptr '+
                        'left outer join data0488 on data0488.WO_Ptr=data0006.rKey and data0488.bom_ptr=data0025.rkey '+
                        'where (Data0006.prod_status=3 OR Data0006.Prod_Status = 4) and data0006.rkey='+dmcon.adsProdList.fieldbyname('rkey').AsString+
                        ' and data0025.rkey='+adsSubProds.fieldbyname('rkey').AsString;
      tmpQry.Open;
      if tmpQry.IsEmpty or (tmpQry.Fields[0].AsInteger<>v_ReqQty) then
      begin
        ShowMsg('��ҵ��:'+tmpQry.FieldByName('WORK_ORDER_NUMBER').AsString+'����������״̬�����ı�,����!',1);
        adsSubProds.Close;
        adsSubProds.Open;
        self.Close;
        exit;
      end else if Qty <= v_ReqQty then
      begin                           //�������������ҵ���ź�������������ҵ������
        if not dmcon.DeployWO(dmcon.adsProdList.fieldByName('rKey').AsInteger,WO_List,Qty_List) then
        begin
          ShowMsg('��ҵ������ʧ��,��ȷ��!',1);
          self.ModalResult:=mrcancel;
          exit;
        end else
          self.ModalResult:=mrok;
      end;
    end;
  finally
    cdsWorkOrderList.Filtered := false;
  end;
end;

procedure TForm_auto_deploy.FormShow(Sender: TObject);
begin
dmcon.vhwnd_TfrmDeployWO := self.Handle  ;
end;

procedure TForm_auto_deploy.MY_MESSAGE8(var Msg: TMessage);
begin
  Label2.Caption :=  '��������:' +  inttostr( Msg.WParam);
end;

procedure TForm_auto_deploy.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
dmcon.vTransQty := 0;
dmcon.vTransQtyfr := 0;
end;

end.
