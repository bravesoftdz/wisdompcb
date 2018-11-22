unit ADED_RECE;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, StdCtrls, Buttons, ComCtrls, DB, ADODB, ExtCtrls,DateUtils,Math,
  Menus;

type
  TForm2 = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn3: TBitBtn;
    StrGrid1: TStringGrid;
    Label1: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Label2: TLabel;
    Edit4: TEdit;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Edit5: TEdit;
    Label6: TLabel;
    Label7: TLabel;
    BitBtn4: TBitBtn;
    Edit6: TEdit;
    Label8: TLabel;
    Edit7: TEdit;
    Edit8: TEdit;
    Label9: TLabel;
    Edit9: TEdit;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Edit3: TEdit;
    Label13: TLabel;
    Edit10: TEdit;
    Label14: TLabel;
    StrGrid2: TStringGrid;
    ComboBox1: TComboBox;
    Edit11: TEdit;
    CheckBox2: TCheckBox;
    Panel1: TPanel;
    StrGrid3: TStringGrid;
    ComboBox2: TComboBox;
    dtpk1: TDateTimePicker;
    CheckBox3: TCheckBox;
    ComboBox3: TComboBox;
    Button2: TButton;
    PopupMenu1: TPopupMenu;
    IQC1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure StrGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure StrGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure StrGrid1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BitBtn1Enter(Sender: TObject);
    procedure StrGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure StrGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ComboBox1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ComboBox1Change(Sender: TObject);
    function location_over():boolean;
    function datecheck():Boolean;
    procedure update_04(v_seed:string);
    procedure print_ininvt(rkey456:integer);
    procedure print_misc(rkey456: integer);
    function find_soerror(number:string):boolean;
    procedure StrGrid3DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure ComboBox2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ComboBox2Change(Sender: TObject);
    procedure StrGrid3SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure StrGrid3KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure StrGrid3KeyPress(Sender: TObject; var Key: Char);
    procedure StrGrid3KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure get_location();
    procedure data0022_post(rkey456:integer);
    procedure data0235_post(rkey456:integer);
    procedure Edit11Exit(Sender: TObject);
    procedure dtpk1Change(Sender: TObject);
    procedure dtpk1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CheckBox3Click(Sender: TObject);
    procedure ComboBox3KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ComboBox3Exit(Sender: TObject);
    procedure IQC1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure N2Click(Sender: TObject);

  private
    { Private declarations }
   function pucher_releced():boolean;
   function Iqc_avlflag(var row:integer):boolean;
   function find_quan_error(ttype, rkey456: integer): boolean;
   function recevied_over(rkey70,vtype:Integer):Boolean;

  public    { Public declarations }
   aded_flag,ttype:byte;//1��po����,2ֱ������,3�༭,4���,5vmi����,ttypeָ����������
   po_ptr,supp_ptr,warehouse_ptr,curr_ptr:integer;
   exch_rate:double;
   po_type:string;
  // FisEdtRemark:boolean;
  end;

var
  Form2: TForm2;
  function Power(x, y : extended) : extended;
implementation

uses data_module, main, po_search, invtin_report, misc_report,common,Pick_Item_Single,ConstVar;

{$R *.dfm}

function TForm2.Iqc_avlflag(var row:integer): boolean;
var
 i:integer;
begin
result := false;
for i:=1 to strgrid1.RowCount-1 do
 if (StrToCurr(strgrid1.Cells[7,i])/StrToCurr(strgrid1.Cells[4,i])+        //���ν�������
    StrToCurr(strgrid1.Cells[5,i])-        //�ѽ�������
    StrToCurr(strgrid1.Cells[17,i])>0.01) and  //���ν��������������������������ͨ������
    (strgrid1.Cells[12,i]='Y') then         //�ɹ���ϸ��ҪIQC���
  begin
   row:=i;
   result := true;
   break;
  end;
end;

function tform2.find_quan_error(ttype, rkey456: integer): boolean;
begin
result:=false;
if ttype=1 then
with dm.adoquery1 do
 begin
  close;
  sql.Text:='select rkey from data0022'+#13+
            'where quantity<>quan_on_hand'+#13+
            'and grn_ptr='+inttostr(rkey456);
  open;
  if not IsEmpty then result:=true;
 end
else
with dm.adoquery1 do
 begin
  close;
  sql.Text:='select rkey from data0235'+#13+
            'where quan_recd<>quan_on_hand'+#13+
            'and grn_ptr='+inttostr(rkey456);
  open;
  if not IsEmpty then result:=true;
 end
end;

procedure tform2.data0235_post(rkey456:integer);
var
 i:integer;
begin
    dm.ADO235.Close;
    dm.ADO235.Parameters[0].Value:=rkey456;
    dm.ADO235.Open;

   for i:=1 to strgrid3.RowCount-1 do
   if strtofloat(strgrid3.Cells[6,i])>0 then
    begin
     dm.ado235.Append;
     dm.ADO235GRN_PTR.Value:=rkey456;     //456.rkey
     dm.ADO235QUAN_RECD.AsString:=strgrid3.Cells[6,i];        //��������
     dm.ADO235QUAN_ON_HAND.Value:=dm.ADO235QUAN_RECD.Value;   //��ǰ�������
     dm.ADO235D0072_PTR.Value:=strtoint(strgrid2.Cells[0,i]);  //72.rkey
     dm.ADO235unit_ptr.Value:=strtoint(strgrid2.Cells[2,i]);  //�����λ
     dm.ADO235unit_price.AsString:=strgrid2.Cells[3,i];       //�۸�
     dm.ADO235state_tax.AsString:=strgrid2.Cells[4,i];        //˰��
     dm.ADO235location_ptr.Value:=strtoint(strgrid2.Cells[5,i]);    //16.rkey
     dm.ADO235rohs.Value:= strgrid3.Cells[8,i];               //������ʶ
     dm.ADO235REF_NUMBER.Value:=strgrid3.Cells[9,i];          //��ע
     dm.ADO235goods_name.Value:= strgrid3.Cells[0,i];// := '��Ʒ����';
     dm.ADO235goods_guige.Value:= strgrid3.Cells[1,i];// := '��Ʒ���';
     dm.ADO235goods_type.Value:= strgrid3.Cells[2,i];// := '��Ʒ���';
     dm.ADO235EMPL_PTR.Value:=dm.ADO456CREATE_BY.Value;
     dm.ADO235DATE_RECD.Value:=dm.ADO456ship_DATE.Value;
     dm.ADO235avl_flag.AsString:=strgrid3.Cells[10,i]; //�Ƿ�IQC;
     dm.ado235.Post;
    end;

    with dm.ADOQuery2 do         //����72���ջ�����,����ջ�����
    begin
     close;
     sql.Clear;
     sql.Add('update data0072');
     sql.Add('set QUANTITY_RECEIVED=QUANTITY_RECEIVED+data0235.QUAN_RECD,');
     sql.Add('recd_DATE='''+edit11.Text+'''');
     sql.Add('from data0235 inner join data0072');
     sql.Add('on data0235.D0072_PTR=data0072.rkey');
     sql.Add('where data0235.GRN_PTR='+inttostr(rkey456));
     ExecSQL;
    end;
end;

procedure tform2.data0022_post(rkey456:integer);
VAR
i:integer;
BEGIN
  dm.ADO22.Close;
  dm.ADO22.Parameters[0].Value:=rkey456;
  dm.ADO22.Open;
  for i:=1 to strgrid1.RowCount-1 do
  if strtofloat(strgrid1.Cells[7,i])>0 then
   begin
    dm.ADO22.Append;
    dm.ADO22GRN_PTR.Value:=rkey456;     //456.rkey
    dm.ADO22SOURCE_PTR.Value:=strtoint(strgrid2.Cells[0,i]);  //71.rkey
    dm.ADO22INVENTORY_PTR.Value:=strtoint(strgrid2.Cells[1,i]);   //17.rkey
    dm.ADO22LOCATION_PTR.Value:=strtoint(strgrid2.Cells[5,i]);    //16.rkey
    dm.ADO22LOCATION_PTR_FROM.Value:=strtoint(strgrid2.Cells[2,i]);//�����λ
    dm.ADO22tax_PRICE.AsString:=strgrid2.Cells[3,i];           //��˰�۸�
    dm.ADO22TAX_2.AsString:=strgrid2.Cells[4,i];               //˰��
    dm.ADO22PRICE.Value:=dm.ADO22tax_price.Value/(1+dm.ADO22TAX_2.Value*0.01);//����˰��

    dm.ADO22QUANTITY.AsString:=strgrid1.Cells[7,i];       //��������
    dm.ADO22QUAN_ON_HAND.Value:=dm.ADO22QUANTITY.Value;   //��ǰ�������
    dm.ADO22SUPPLIER2.Value:=strgrid1.Cells[9,i];         //��������
    dm.ADO22spec_place.Value:=strgrid1.Cells[10,i];       //��ϸλ��
    dm.ADO22rohs.Value:=strgrid1.Cells[14,i];            //������ʶ
    dm.ADO22BARCODE_ID.Value:=strgrid1.Cells[11,i];      //��ע(�ر�Ҫ��)
    dm.ADO22TDATE.Value:=StrToDate(strgrid1.Cells[13,i]); //��������

    if (Trim(strgrid1.Cells[18,i])<>'') then
    dm.ADO22rkey391.AsString:=strgrid1.Cells[18,i]; //rkey391

    //20170426tang��Ч������Ϊ0�����洢��Ч��
    if (Trim(strgrid1.Cells[15,i])<>'') and (Trim(strgrid1.Cells[15,i])<>'0') then
    dm.ADO22EXPIRE_DATE.Value:=strtodate(strgrid1.Cells[13,i])+strtoint(strgrid1.Cells[15,i]);

    dm.ADO22PACKING_SLIP_FLAG.Value:=strgrid1.Cells[16,i];  //��CAF

    dm.ADO22TTYPE.Value:=2;
    if Trim(StrGrid1.Cells[20,i])<> '' then
      dm.ADO22ORIG_ABBRNAME.AsString:= Trim(StrGrid1.Cells[20,i]);   //Ʒ�ƹ�Ӧ��

    dm.ADO22STOCK_BASE.AsString := strgrid2.Cells[7,i];  //��������
    dm.ADO22.Post;
    //20170428tang����391״̬
    if (Trim(strgrid1.Cells[18,i])<>'') then
    begin
      dm.ADOQuery2.Close;
      dm.ADOQuery2.SQL.Clear;
      dm.ADOQuery2.SQL.Text:='update data0391 set stock_over=1 where Rkey='+strgrid1.Cells[18,i];
      dm.ADOQuery2.ExecSQL;
    end;
   end;

  with dm.ADOQuery2 do         //����71���ջ�����,����ջ�����
  begin
    close;
    sql.Clear;
    sql.Add('update data0071');
    sql.Add('set QUAN_RECD=QUAN_RECD+data0022.quantity/data0071.CONVERSION_FACTOR,');
    sql.Add('recd_DATE='''+edit11.Text+'''');
    sql.Add('from data0022 inner join data0071');
    sql.Add('on data0022.SOURCE_PTR=data0071.rkey');
    sql.Add('where data0022.GRN_PTR='+inttostr(rkey456));
    ExecSQL;
  end;

  with dm.ADOQuery2 do         //����17��ǰ���������
  begin
    close;
    sql.Clear;
    sql.Add('update data0017');
    sql.Add('set data0017.QUAN_ON_HAND=data0017.QUAN_ON_HAND+d1.qty');
    sql.Add('from data0017 inner join');
    sql.Add('(select inventory_ptr,sum(quan_on_hand) as qty');
    sql.Add('from data0022');
    sql.Add('where data0022.GRN_PTR='+inttostr(rkey456));
    sql.Add('group by inventory_ptr) d1');
    sql.Add('on data0017.rkey=d1.INVENTORY_PTR');
    ExecSQL;
  end;

END;



procedure TForm2.get_location();
begin
  dm.aq16.Close;
  if checkbox3.Checked then
  dm.aq16.SQL.Text:='select rkey,LOCATION from data0016 '+
    'where LOCATION_TYPE = 0 and '+
    'whouse_ptr='+inttostr(self.warehouse_ptr)+
    ' order by rkey'
  else
  dm.aq16.SQL.Text:='select rkey,LOCATION from data0016 '+
    'where LOCATION_TYPE=0 order by rkey';
  dm.aq16.Open;
  combobox1.Items.Clear;
  combobox2.Items.Clear;
  while not dm.aq16.Eof do
   begin
    combobox1.Items.AddObject(dm.aq16LOCATION.Value,Pointer(dm.aq16rkey.Value));
    combobox2.Items.AddObject(dm.aq16LOCATION.Value,Pointer(dm.aq16rkey.Value));
    dm.aq16.Next;
   end;
  dm.aq16.First;

end;

procedure TForm2.FormShow(Sender: TObject);
begin
 strgrid1.Cells[0,0] := '���ϱ���';
 strgrid1.Cells[1,0] := '��������';
 strgrid1.Cells[2,0] := '���Ϲ��';
 strgrid1.Cells[3,0] := '��������';
 strgrid1.Cells[4,0] := 'ת����';
 strgrid1.Cells[5,0] := '�ѽ���';
 strgrid1.Cells[6,0] := '�����λ';
 strgrid1.Cells[7,0] := '��ǰ����';
 strgrid1.Cells[8,0] := '�ֿ�λ��';
 strgrid1.Cells[9,0] := '��������';
 strgrid1.Cells[10,0] := '��ϸλ��';
 strgrid1.Cells[11,0] := '��ע';
 strgrid1.Cells[12,0] := 'IF���';
 strgrid1.ColWidths[12] := -1;
 strgrid1.Cells[13,0] := '��������';
 strgrid1.Cells[14,0] := '������ʶ';
 StrGrid1.Cells[15,0] :='��Ч������';
 StrGrid1.Cells[16,0] :='��CAF';
 StrGrid1.Cells[17,0] :='IQC�Ѽ�������';
 StrGrid1.Cells[18,0] :='Rkey391';
 StrGrid1.Cells[19,0] :='Recount';
 StrGrid1.Cells[20,0] :='Ʒ�ƹ�Ӧ��';
 strgrid1.ColWidths[17] := -1;
 strgrid1.ColWidths[18] := -1;
 strgrid1.ColWidths[19] := -1;

 strgrid3.Cells[0,0] := '��Ʒ����';
 strgrid3.Cells[1,0] := '��Ʒ���';
 strgrid3.Cells[2,0] := '��Ʒ���';
 strgrid3.Cells[3,0] := '��������';
 strgrid3.Cells[4,0] := '�ѽ���';
 strgrid3.Cells[5,0] := '�ɹ���λ';
 strgrid3.Cells[6,0] := '��ǰ����';
 strgrid3.Cells[7,0] := 'λ��';
 strgrid3.Cells[8,0] := '������ʶ';
 strgrid3.Cells[9,0] := '��ע';
 StrGrid3.Cells[10,0]:='�Ƿ�IQC';

 strgrid2.Cells[0,0] := '71rkey/72rkey';
 strgrid2.Cells[1,0] := '17rkey';
 strgrid2.Cells[2,0] := '�����λ02';
 strgrid2.Cells[3,0] := '��˰��';
 strgrid2.Cells[4,0] := '˰��';
 strgrid2.Cells[5,0] := '16rkey';
 strgrid2.Cells[6,0] := '������Ч��';
 strgrid2.Cells[7,0] := '���ϵ���KG';
end;

procedure TForm2.FormActivate(Sender: TObject);
var
 i:word;
begin
  if (aded_flag=1) or (aded_flag=2) then //���������� �� �Ǳ�������
  begin
    edit11.Text:=formatdatetime('yyyy-mm-dd HH:mm:ss',common.getsystem_date(dm.ADOQuery1,0));
    dm.ado04.Close;
    dm.ado04.Open;
    if dm.ado04SEED_FLAG.Value<>1 then
      edit6.Text:=dm.ado04SEED_VALUE.Value;
    if dm.ado04SEED_FLAG.Value=4 then
      edit6.ReadOnly:=true;
    self.get_location;
    with dm.ADOQuery1 do
    begin
      close;
      sql.Clear;
      sql.Add('select NOTE_PAD_LINE_1 from data0011');
      sql.Add('where SOURCE_TYPE=70 and');
      sql.Add('FILE_POINTER='+inttostr(self.po_ptr));
      open;
      if not isempty then edit7.Text:=fieldvalues['NOTE_PAD_LINE_1'];
      close;
    end;
  end
  else     //�༭���
  begin
    dm.ado04.Close;
    dm.ado04.Open;
    if dm.ado04SEED_FLAG.Value=4 then
      edit6.ReadOnly:=true;

    edit6.Text:=dm.Aqwz456GRN_NUMBER.Value;
    edit1.Text:=dm.Aqwz456DELIVER_NUMBER.Value;
    edit2.Text:=dm.Aqwz456PO_NUMBER.Value;
    edit4.Text:=dm.Aqwz456DEPT_NAME.Value;
    edit5.Text:=dm.Aqwz456ship_BY.Value;
    edit11.Text:=
    formatdatetime('yyyy-mm-dd HH:mm:ss',dm.Aqwz456ship_DATE.Value);

    edit9.Text:=dm.Aqwz456CODE.Value;
    label11.Caption:=dm.Aqwz456SUPPLIER_NAME.Value;
    edit8.Text:=dm.Aqwz456WAREHOUSE_CODE.Value;
    label10.Caption:=dm.Aqwz456WAREHOUSE_NAME.Value;
    edit3.Text:=dm.Aqwz456CURR_CODE.Value;
    label13.Caption:=dm.Aqwz456CURR_NAME.Value;
    edit10.Text:=dm.Aqwz456EXCH_RATE.AsString;
    curr_ptr:=dm.Aqwz456CURRENCY_PTR.Value;
    warehouse_ptr := dm.Aqwz456warehouse_ptr.Value; //����15.rkey
    po_ptr := dm.Aqwz456PO_PTR.Value;                  //�ɹ�70.rkey
    supp_ptr := dm.Aqwz456SUPP_PTR.value;    //��Ӧ��23.rkey
    edit7.Text:=dm.Aqwz456REF_NUMBER.Value;

    self.get_location;   //�õ����λ��
    if dm.Aqwz456TTYPE.Value=1 then     //��׼�������
    begin
      strgrid1.Visible := true;
      strgrid3.Visible := false;
      combobox1.Visible := true;
      combobox2.Visible := false;
      dm.Aq22.Open;
      strgrid1.RowCount:=dm.Aq22.RecordCount+1;
      strgrid2.RowCount:=dm.Aq22.RecordCount+1;
      for i:=1 to dm.Aq22.RecordCount do
      begin
        strgrid1.Cells[0,i] := dm.Aq22INV_PART_NUMBER.Value;
        strgrid1.Cells[1,i] := dm.Aq22INV_NAME.Value;
        strgrid1.Cells[2,i] := dm.Aq22INV_DESCRIPTION.Value;
        strgrid1.Cells[3,i] := dm.Aq22QUAN_ORD.AsString;
        strgrid1.Cells[4,i] := dm.Aq22CONVERSION_FACTOR.AsString;

        strgrid1.Cells[6,i] := dm.Aq22pr_unitname.Value;
        strgrid1.Cells[5,i] := floattostr(
                               dm.Aq22QUAN_RECD.Value-
                               dm.Aq22QUANTITY.Value/dm.Aq22CONVERSION_FACTOR.Value);

        strgrid2.Cells[2,i] := dm.Aq22WO_PTR.AsString; //�����λ
        strgrid2.Cells[3,i] :=formatfloat('0.0000',
                               dm.Aq22tax_PRICE.value/dm.Aq22CONVERSION_FACTOR.Value
                                              );

        strgrid1.Cells[7,i] := dm.Aq22QUANTITY.AsString;  //��ǰ����
        if strgrid1.Cells[7,i]='' then
         strgrid1.Cells[7,i] :='0';

        strgrid1.Cells[8,i] := dm.Aq22LOCATION.Value;    //λ������
        strgrid1.Cells[9,i] := dm.Aq22SUPPLIER2.Value;   //ԭ������
        strgrid1.Cells[10,i] := dm.Aq22spec_place.Value; //��ϸλ��


        strgrid1.Cells[11,i] := dm.Aq22BARCODE_ID.Value; //��ע
        strgrid1.Cells[12,i] := dm.Aq22avl_flag.Value;   //�Ƿ���Ҫ���
        StrGrid1.Cells[17,i] := dm.Aq22QUAN_IN_INSP.AsString;//�Ѽ���ͨ������
        StrGrid1.Cells[18,i]:=dm.Aq22rkey391.AsString;//391Rkey
        StrGrid1.Cells[20,i]:=dm.Aq22ORIG_ABBRNAME.AsString;//Ʒ�ƹ�Ӧ��

        if not dm.Aq22Tdate.IsNull then     //��������ϸ
         begin
          strgrid1.Cells[13,i] := FormatDateTime('yyyy-mm-dd',dm.Aq22Tdate.Value);//��������
          StrGrid1.Cells[15,i] := IntToStr(DaysBetween(dm.Aq22Tdate.Value,dm.Aq22EXPIRE_DATE.Value));//��Ч������
          strgrid1.Cells[14,i] := dm.Aq22rohs22.Value;       //������ʶ
          strgrid1.Cells[16,i] := dm.Aq22PACKING_SLIP_FLAG.Value;       //��CAF
         end
        else                              //���������û�д�71�ļ�¼
         begin
          strgrid1.Cells[13,i] := datetostr(common.getsystem_date(dm.ADOQuery1,1));
          strgrid1.Cells[14,i] := dm.Aq22rohs.Value;       //������ʶ
          strgrid1.Cells[16,i] := dm.Aq22if_caf.Value;       //��CAF
            with dm.ADOQuery1 do
            begin
              Close;
              sql.Clear;
              sql.Add('select data0028.qte_price2 from data0028');
              sql.Add('where SUPPLIER_PTR='+inttostr(supp_ptr));
              SQL.Add('and INVENTORY_PTR='+dm.Aq22INVT_PTR.AsString);
              Open;
            end;
            if (dm.ADOQuery1.RecordCount>0) then
            begin
             StrGrid1.Cells[15,i]:=dm.ADOQuery1.Fieldbyname('qte_price2').AsString;
            end
            else
            with dm.ADOQuery1 do
             begin
               Close;
               SQL.Clear;
               sql.Add('select SHELF_LIFE from data0017');
               SQL.Add('where data0017.rkey='+dm.Aq22INVT_PTR.AsString);
               Open;
                StrGrid1.Cells[15,i]:=dm.ADOQuery1.Fieldbyname('shelf_life').AsString;
             end;
         end;
        strgrid2.Cells[0,i] := dm.Aq22RKEY.AsString;     //71
        strgrid2.Cells[1,i] := dm.Aq22INVT_PTR.AsString; //17

        strgrid2.Cells[4,i] := dm.Aq22TAX_2.AsString;       //˰��%
        strgrid2.Cells[5,i] := dm.Aq22LOCATION_PTR.AsString;//λ��ָ�� 16.rkey
        strgrid2.Cells[6,i] := dm.Aq22SHELF_LIFE.AsString;  //��Ч��
        strgrid2.Cells[7,i] := dm.Aq22STOCK_BASE.AsString;  //��λ����KG

        dm.Aq22.Next;
      end;
      dm.Aq22.Close;
      strgrid1.SetFocus;
      strgrid1.Col:=7;
      if edit6.Enabled then edit6.SetFocus;
    end
    else
    begin
      strgrid1.Visible:=false;
      strgrid3.Visible:=true;
      combobox1.Visible := false;
      combobox2.Visible := true;
      combobox3.Visible:=false;
      dtpk1.Visible:=false;
      dm.Aq235.Open;
      strgrid3.RowCount:=dm.Aq235.RecordCount+1;
      strgrid2.RowCount:=dm.Aq235.RecordCount+1;
      for i:=1 to dm.Aq235.RecordCount do
      begin
        strgrid3.Cells[0,i] := dm.aq235DESCRIPTION.Value;
        strgrid3.Cells[1,i] := dm.aq235GUI_GE.Value;
        strgrid3.Cells[2,i] := dm.aq235DESCRIPTION2.Value;
        strgrid3.Cells[3,i] := dm.aq235QUAN_ORD.AsString;
        strgrid3.Cells[4,i] := floattostr(
                               dm.aq235QUANTITY_RECEIVED.Value-
                               dm.aq235QUAN_RECD.Value);


        strgrid3.Cells[5,i] := dm.aq235UNIT_NAME.Value;
        strgrid3.Cells[6,i] := dm.aq235QUAN_RECD.AsString; //��ǰ����
        if strgrid3.Cells[6,i]='' then
         strgrid3.Cells[6,i] :='0';
        strgrid3.Cells[7,i] := dm.aq235LOCATION.Value;     //λ������
        strgrid3.Cells[8,i] := dm.Aq235rohs.Value;         //������ʶ
        strgrid3.Cells[9,i] := dm.aq235REF_NUMBER.Value;   //��ע
        StrGrid3.Cells[10,i]:=dm.aq235avl_flag.AsString;//20170913tang���Ƿ�IQC��ʶ

        strgrid2.Cells[0,i] := dm.Aq235RKEY.AsString;      //72
        strgrid2.Cells[2,i] := dm.aq235UNIT_PTR.AsString;  //�����λ
        strgrid2.Cells[3,i] :=formatfloat('0.000',dm.aq235tax_price.value); //��˰��
        strgrid2.Cells[4,i] := dm.aq235STATE_TAX.AsString;     //˰��%
        strgrid2.Cells[5,i] := dm.Aq235LOCATION_PTR.AsString;  //λ��ָ��
        dm.Aq235.Next;
      end;
      dm.Aq235.Close;
      strgrid3.SetFocus;
      strgrid3.Col:=6;
      if edit6.Enabled then edit6.SetFocus;
    end;
  end;
end;

function TForm2.pucher_releced: boolean;
var
 i:word;
begin
 Result:=false;

 for i:=1 to strgrid2.RowCount-1 do
 if self.ttype=1 then     //����������
  with dm.ADOQuery1 do
   begin
    close;
    sql.Clear;
    sql.Text:='select rkey from data0071 where rkey='+strgrid2.Cells[0,i]+
               'and abs(QUAN_RECD-'+strgrid1.Cells[5,i]+') < 0.01';
    open;
    if IsEmpty then
    begin
     Result:=true;
     break;
    end;
   end
  else               //�����������
   with dm.ADOQuery1 do
   begin
    close;
    sql.Clear;
    sql.Text:='select rkey from data0072 where rkey='+strgrid2.Cells[0,i]+
               'and abs(QUANTITY_RECEIVED-'+ strgrid3.Cells[4,i]+') < 0.01';
    open;
    if IsEmpty then
    begin
      Result:=true;
      break;
    end;
   end

end;

function TForm2.recevied_over(rkey70,vtype: Integer): Boolean;
begin
if vtype=1 then
 with dm.ADOQuery1 do
 begin
   close;
   sql.Text:=
    'SELECT rkey '+
    'FROM  dbo.Data0071 '+
    'WHERE (QUAN_RECD < QUAN_ORD) '+
    'and (PO_PTR='+inttostr(rkey70)+')';
   open;
   if IsEmpty then   //û�д�����¼�����ж������������
    Result:=True
   else
    result:=False;
 end
else
 with dm.ADOQuery1 do
 begin
   close;
   sql.Text:=
    'SELECT rkey '+
    'FROM  dbo.Data0072 '+
    'WHERE (QUANTITY_RECEIVED < QUAN_ORD) '+
    'and (POPTR='+inttostr(rkey70)+')';
   open;
   if IsEmpty then   //û�д�����¼�����ж������������
    Result:=True
   else
    result:=False;
 end;
end;

procedure TForm2.BitBtn1Click(Sender: TObject);
var
  i,iRkey14:integer;
  isInf:boolean;
  smsstring1,smsstring2,phonenumber,msg,sendername:string;
begin
  if (aded_flag=1) or (aded_flag=2) then //����
  begin
    if pucher_releced then
    begin
      showmsg('����¼�����䷢,�����ж��ͬʱ���!',1);
      exit;
    end;

    if self.find_soerror(trim(edit6.Text)) then
    if messagedlg('��ֱ���ظ�,�����ж�̨�����ͬʱ����,�Ƿ��Զ����±��?',mtConfirmation,[mbYes,mbNo],0)=mrYes  then
    begin
      dm.ado04.Close;
      dm.ado04.Open;
      edit6.Text:=dm.ado04SEED_VALUE.Value;
    end
    else
    begin
      edit6.SetFocus;
      exit;
    end;

    dm.ADOConnection1.BeginTrans;
    try
      dm.ADO456.Close;
      dm.ADO456.Parameters[0].Value:=null;
      dm.ADO456.Open;
      dm.ADO456.Append;
      dm.ADO456GRN_NUMBER.Value:=edit6.Text;                //��ⵥ��
      dm.ADO456DELIVER_NUMBER.Value:=edit1.Text;            //�ͻ�����
      dm.ADO456ship_BY.Value:=edit5.Text;                   //�ͻ���Ա

      dm.ADO456ship_DATE.Value:=strtodatetime(edit11.Text); //�ͻ�����

      dm.ADO456CREATE_BY.Value:=strtoint(user_ptr);           //�ջ�Ա��
      dm.ADO456CREATE_DATE.Value:=common.getsystem_date(dm.ADOQuery1,0);     //�ջ�����
      dm.ADO456warehouse_ptr.Value:=self.warehouse_ptr;   //����
      dm.ADO456SUPP_PTR.Value:=self.supp_ptr;             //��Ӧ��
      dm.ADO456PO_PTR.Value:=self.po_ptr;                 //�ɹ�����
      dm.ADO456REF_NUMBER.Value:=edit7.Text;              //��ע
      dm.ADO456STATUS.Value:=1;                           //״̬
      dm.ADO456CURRENCY_PTR.Value:=self.curr_ptr;         //����
      dm.ADO456EXCH_RATE.AsString:=edit10.Text;           //����
      dm.ADO456TTYPE.Value:=self.ttype;                   //����

      if checkbox2.Checked then
        dm.ADO456PRINTED.Value:='Y'
      else
        dm.ADO456PRINTED.Value:='N';
      dm.ADO456.Post;

      dm.ado04.Close;
      dm.ado04.Open;
      self.update_04(trim(dm.ado04SEED_VALUE.Value));             //���¿�����

      if dm.ADO456ttype.Value=1 then       //�����������
        self.data0022_post(dm.ADO456RKEY.Value)
      else                                 //�������������
        self.data0235_post(dm.ADO456RKEY.Value);

//      if dm.ADO456ttype.Value=1 then       //�����������
//      with dm.ADOQuery1 do
//      begin
//        close;
//        sql.Text:='SELECT  rkey '+
//                  'FROM  Data0071 '+
//                  'WHERE (avl_flag =''Y'') AND (QUAN_RECD > QUAN_IN_INSP) '+
//                  'and (PO_PTR='+dm.ADO456PO_PTR.AsString+')';
//        open;
//        if not IsEmpty then
//        begin
//          dm.ADOConnection1.RollbackTrans;
//          messagedlg('��������ʧ��,����������˼��ͨ����!',mterror,[mbcancel],0);
//          edit6.SetFocus;
//          Exit;
//        end;
//      end;

      if self.recevied_over(dm.ADO456PO_PTR.Value,dm.ADO456TTYPE.Value) then
      with dm.adoquery2 do
      begin
        close;
        sql.clear;
        sql.Add('update data0070');
        sql.Add('set status=6');
        sql.Add('where rkey='+dm.ADO456PO_PTR.AsString);
        execsql;
      end;

      dm.ADOConnection1.CommitTrans;
      if checkbox2.Checked then
      IF dm.ADO456ttype.Value=1 THEN
        self.print_ininvt(dm.ADO456RKEY.Value)
      else
        self.print_misc(dm.ADO456RKEY.Value);

//      with dm.tmp1 do
//      begin
//        dm.tmp1.Close;
//        dm.tmp1.SQL.Clear;
//        dm.tmp1.SQL.Add('SELECT Data0456.GRN_NUMBER, data0068.po_req_number,data0068.user_ptr,data0068.user_name,data0068.user_phone,data0070.PO_NUMBER,data0073.rkey ');
//        dm.tmp1.SQL.Add('FROM Data0456 INNER JOIN Data0070 ON Data0456.PO_PTR = Data0070.RKEY INNER JOIN ');
//        dm.tmp1.SQL.Add('data0068 on data0070.fob = data0068.po_req_number ');
//        dm.tmp1.SQL.Add('INNER JOIN data0073 on data0068.user_name=data0073.user_full_name  ');
//        dm.tmp1.SQL.Add('where Data0456.GRN_NUMBER='+quotedstr(Trim(Edit6.Text)));
//        dm.tmp1.Open;
//        phonenumber:=dm.tmp1.FieldByName('user_phone').AsString;
//      end;
/////////////////////hcc add by 2018-10-17
      with dm.tmp1 do
      begin
        dm.tmp1.Close;
        dm.tmp1.SQL.Clear;
        dm.tmp1.SQL.Add('SELECT dbo.Data0073.RKEY, dbo.Data0068.RKEY AS rkey68, dbo.Data0068.PO_REQ_NUMBER ');
        dm.tmp1.SQL.Add('FROM dbo.Data0022 INNER JOIN ');
        dm.tmp1.SQL.Add('dbo.Data0071 ON dbo.Data0022.SOURCE_PTR = dbo.Data0071.RKEY INNER JOIN ');
        dm.tmp1.SQL.Add('dbo.Data0070 ON dbo.Data0071.PO_PTR = dbo.Data0070.RKEY INNER JOIN  ');
        dm.tmp1.SQL.Add('dbo.Data0068 ON dbo.Data0070.FOB = dbo.Data0068.PO_REQ_NUMBER INNER JOIN ');
        dm.tmp1.SQL.Add('dbo.Data0073 ON dbo.Data0068.user_name = dbo.Data0073.USER_FULL_NAME ');
        dm.tmp1.SQL.Add('WHERE dbo.Data0022.GRN_PTR ='+dm.ADO456RKEY.AsString);
        dm.tmp1.SQL.Add(' GROUP BY dbo.Data0073.RKEY, dbo.Data0068.RKEY, dbo.Data0068.PO_REQ_NUMBER');
        dm.tmp1.Open;
      end;
      isInf:=messagedlg('�Ƿ����֪ͨʹ����Ա�������������?',mtconfirmation,[mbYes,mbNo],0)=mrYes;
      if isInf then
      begin
       if not dm.tmp1.IsEmpty then
       begin
        dm.tmp1.First;
        while not dm.tmp1.Eof do
        begin
         smsstring1:= '';
         smsstring2:= '';
         DM.tmp.Close;
         DM.tmp.SQL.Text:='select * from data0014 where rkey is null';
         DM.tmp.Open;
         DM.tmp.append;
         with dm.ADOtemp do
         begin
          Close;
          sql.Clear;
          sql.Add('SELECT  dbo.Data0073.RKEY, dbo.Data0068.RKEY AS rkey68, dbo.Data0068.PO_REQ_NUMBER, dbo.Data0017.INV_NAME, dbo.Data0017.INV_DESCRIPTION ');
          sql.Add(',dbo.Data0068.user_name,dbo.Data0017.INV_PART_NUMBER FROM  dbo.Data0022 INNER JOIN ');
          SQL.Add('dbo.Data0071 ON dbo.Data0022.SOURCE_PTR = dbo.Data0071.RKEY INNER JOIN ');
          SQL.Add('dbo.Data0070 ON dbo.Data0071.PO_PTR = dbo.Data0070.RKEY INNER JOIN ');
          SQL.Add('dbo.Data0068 ON dbo.Data0070.FOB = dbo.Data0068.PO_REQ_NUMBER INNER JOIN ');
          SQL.Add('dbo.Data0073 ON dbo.Data0068.user_name = dbo.Data0073.USER_FULL_NAME INNER JOIN ');
          SQL.Add('dbo.Data0017 ON dbo.Data0022.INVENTORY_PTR = dbo.Data0017.RKEY ');
          SQL.Add('WHERE (dbo.Data0022.GRN_PTR = '+dm.ADO456RKEY.AsString+') AND (dbo.Data0068.RKEY ='+dm.tmp1.fieldbyname('rkey68').AsString+')');
          Open;
         end;
         if not dm.ADOtemp.IsEmpty then
         begin
          dm.ADOtemp.First;
          while not dm.ADOtemp.Eof do
          begin
           if dm.ADO456TTYPE.Value = 1 then  //��������
           begin
            for i:=1 to strgrid1.RowCount-1 do
              if (strgrid1.Cells[0,i]=dm.ADOtemp.FieldByName('INV_PART_NUMBER').AsString) and (strtofloat(strgrid1.Cells[7,i])>0) then
                smsstring1:=smsstring1+strgrid1.Cells[0,i]+';'+strgrid1.Cells[1,i]+';';
           end;
           if dm.ADO456TTYPE.Value = 2 then  //�Ǳ�������
           begin
            for i:=1 to strgrid3.RowCount-1 do
              if strtofloat(strgrid3.Cells[6,i])>0 then
                smsstring2:=smsstring2+strgrid3.Cells[0,i]+';'+strgrid3.Cells[1,i]+';';
           end;
           dm.ADOtemp.Next;
          end;
          if dm.ADO456TTYPE.Value=1 then //��������
          begin
           DM.tmp.fieldvalues['MESSAGE'] := '��һ�����������,ʹ����Ա:'+
           dm.ADOtemp.fieldbyname('user_name').AsString+':'+'��������:'+smsstring1+'��֪Ϥ!';
          end;
          if dm.ADO456TTYPE.Value=2 then //�Ǳ�������
          begin
            DM.tmp.fieldvalues['MESSAGE'] := '��һ�����������,ʹ����Ա:'+
            dm.ADOtemp.fieldbyname('user_name').AsString+':'+'������������:'+smsstring2+'��֪Ϥ!';
          end;
         end;
          msg:=dm.tmp.FieldValues['MESSAGE'];
          DM.tmp.fieldvalues['whosend']:= strtoint(rkey73);
          DM.tmp.post;
          iRkey14:=DM.tmp.FieldValues['rkey'];

          DM.tmp.Close;
          DM.tmp.SQL.Text:='insert into data0314(d14_ptr,emp_ptr,if_note) '+
                            'values('+inttostr(iRkey14)+','+dm.tmp1.fieldbyname('rkey').AsString+',0'+')';
          DM.tmp.ExecSQL;
          dm.tmp1.Next;
        end;
       end;
      end;
////////////////////////// end by hcc 2018-10-17
//      if (dm.tmp1.FieldByName('user_name').AsString<>'') and (dm.tmp1.FieldByName('user_phone').AsString<>'') then
//      begin
//        isInf:=messagedlg('�Ƿ����֪ͨʹ����Ա�������������?',mtconfirmation,[mbYes,mbNo],0)=mrYes;
//        if isInf then
//        begin
//          smsstring1:= '';
//          smsstring2:= '';
//          DM.tmp.Close;
//          DM.tmp.SQL.Text:='select * from data0014 where rkey is null';
//          DM.tmp.Open;
//          DM.tmp.append;
//
//          if dm.ADO456TTYPE.Value = 1 then  //��������
//          begin
//            for i:=1 to strgrid1.RowCount-1 do
//              if strtofloat(strgrid1.Cells[7,i])>0 then
//                smsstring1:=smsstring1+strgrid1.Cells[0,i]+';'+strgrid1.Cells[1,i]+';';
//
//            DM.tmp.fieldvalues['MESSAGE'] := '��һ�����������,ʹ����Ա:'+
//                     dm.tmp1.fieldbyname('user_name').AsString+':'+'��������:'+smsstring1+'��֪Ϥ!';
//          end;
//          if dm.ADO456TTYPE.Value = 2 then  //�Ǳ�������
//          begin
//            for i:=1 to strgrid3.RowCount-1 do
//              if strtofloat(strgrid3.Cells[6,i])>0 then
//                smsstring2:=smsstring2+strgrid3.Cells[0,i]+';'+strgrid3.Cells[1,i]+';';
//
//            DM.tmp.fieldvalues['MESSAGE'] := '��һ�����������,ʹ����Ա:'+
//                    dm.tmp1.fieldbyname('user_name').AsString+':'+'������������:'+smsstring2+'��֪Ϥ!';
//          end;
//          msg:=dm.tmp.FieldValues['MESSAGE'];
//          DM.tmp.fieldvalues['whosend']:= strtoint(rkey73);
//          DM.tmp.post;
//          iRkey14:=DM.tmp.FieldValues['rkey'];
//
//          DM.tmp.Close;
//          DM.tmp.SQL.Text:='insert into data0314(d14_ptr,emp_ptr,if_note) '+
//                            'values('+inttostr(iRkey14)+','+dm.tmp1.fieldbyname('rkey').AsString+',0'+')';
//          DM.tmp.ExecSQL;
//
//          with dm.tmp1 do           //���·��Ͷ���
//          begin
//            Close;
//            SQL.Clear;
//            SQL.Text:='select user_full_name from data0073 where rkey='+rkey73;
//            Open;
//            sendername:= dm.tmp1.Fieldbyname('user_full_name').AsString;
//          end;
//          with dm.tmp do
//          begin
//            Close;
//            SQL.Clear;
//            SQL.Text:='select SUPLFEDSHIP,SUPLFEDMAT,SUPLFEDMISC from data0192';
//            Open;
//          end;
//          if Trim(dm.tmp.FieldByName('SUPLFEDSHIP').AsString) <> '' then
//          begin
//            with dm.tmp1 do
//            begin
//              Close;
//              SQL.Text:='insert ['+dm.tmp.FieldValues['SUPLFEDSHIP']+'].'+dm.tmp.FieldValues['SUPLFEDMAT']+'.dbo.'+dm.tmp.FieldValues['SUPLFEDMISC']+
//                        '(phonenumber,messagecontent,sendername,companyid) '+
//                        'values (:phonenumber,:messagecontent,:sendername,9)';
//              Parameters[0].Value:=phonenumber;
//              Parameters[1].Value:=Copy(Application.Title,24,Length(Application.Title)-23)+msg;
//              Parameters[2].Value:=sendername;
//              ExecSQL;
//              ShowMessage('�����ѷ���');
//            end;
//          end;
//        end;
//      end;

     self.ModalResult:=mrok;

    except
     on E: Exception do
      begin
       dm.ADOConnection1.RollbackTrans;
       messagedlg(E.Message,mterror,[mbcancel],0);
       edit6.SetFocus;
      end;
    end

  end
  else         //�༭
  begin
    if find_quan_error(dm.Aqwz456TTYPE.Value,dm.Aqwz456RKEY.Value) then
    begin
      showmsg('����¼�����䷢,�����ٱ༭!',1);
      exit;
    end;

    dm.ADOConnection1.BeginTrans;
    try
      dm.ADO456.Close;
      dm.ADO456.Parameters[0].Value:=dm.Aqwz456RKEY.Value;
      dm.ADO456.Open;
      dm.ADO456.Edit;
      dm.ADO456GRN_NUMBER.Value:=edit6.Text;
      dm.ADO456DELIVER_NUMBER.Value:=edit1.Text;
      dm.ADO456ship_DATE.Value:=strtodatetime(edit11.text);
      dm.ADO456ship_BY.Value:=edit5.Text;
      dm.ADO456REF_NUMBER.Value:=edit7.Text;
      dm.ADO456STATUS.Value:=1;
      dm.ADO456.Post;
      if dm.ADO456TTYPE.Value=1 then//�������
      begin
        with dm.ADOQuery2 do         //����71���ջ�����,����ջ�����
        begin
          close;
          sql.Clear;
          sql.Add('update data0071');
          sql.Add('set QUAN_RECD=QUAN_RECD-data0022.quantity/data0071.CONVERSION_FACTOR');
          sql.Add('from data0022 inner join data0071');
          sql.Add('on data0022.SOURCE_PTR=data0071.rkey');
          sql.Add('where data0022.GRN_PTR='+dm.ADO456rkey.AsString);
          ExecSQL;
        end;

        with dm.ADOQuery2 do         //����17��ǰ���������
        begin
          close;
          sql.Clear;
          sql.Add('update data0017');
          sql.Add('set data0017.QUAN_ON_HAND=data0017.QUAN_ON_HAND-d1.qty');
          sql.Add('from data0017 inner join');
          sql.Add('(select inventory_ptr,sum(quan_on_hand) as qty');
          sql.Add('from data0022');
          sql.Add('where data0022.GRN_PTR='+dm.ADO456rkey.AsString);
          sql.Add('group by inventory_ptr) d1');
          sql.Add('on data0017.rkey=d1.INVENTORY_PTR');
          ExecSQL;
        end;
        //20170428tang����391
        dm.ADOQuery2.Close;
        dm.ADOQuery2.SQL.Clear;
        dm.ADOQuery2.SQL.Text:='update data0391 set data0391.stock_over=0 '
        +'from data0022 inner join data0391 on data0022.rkey391=data0391.rkey where data0022.GRN_PTR='+dm.ADO456rkey.AsString;
        dm.ADOQuery2.ExecSQL;

        with dm.ADOQuery2 do  //�޸�207��22ָ��ΪNULL
        begin
          Close;
          SQL.Clear;
          sql.Text:=' update data0207 set D0022_PTR = null    '+#13+
                    ' from data0207  '+#13+
                    ' inner join data0022 on data0207.D0022_ptr = data0022.rkey  '+#13+
                    ' where data0022.GRN_PTR = ' + dm.Aqwz456RKEY.AsString;
          ExecSQL;
        end;

        with dm.ADOQuery2 do
        begin
          close;
          sql.Clear;
          sql.Add('delete from data0022');
          sql.Add('where data0022.GRN_PTR='+dm.ADO456rkey.AsString);
          ExecSQL;
        end;
        self.data0022_post(dm.ADO456RKEY.Value);

        with dm.ADOQuery1 do
        begin
          close;
          sql.Text:='SELECT  rkey '+
                    'FROM  Data0071 '+
                    'WHERE (QUAN_IN_INSP > 0) AND (QUAN_RECD > QUAN_IN_INSP) '+
                    'and (PO_PTR='+dm.ADO456PO_PTR.AsString+')';
          open;
          if not IsEmpty then
          begin
            dm.ADOConnection1.RollbackTrans;
            messagedlg('�༭����ʧ��,����������˼��ͨ����!',mterror,[mbcancel],0);
            edit6.SetFocus;
            Exit;
          end;
        end;
      end
      else                         //�������
      begin
        with dm.ADOQuery2 do         //����72���ջ�����
        begin
          close;
          sql.Clear;
          sql.Add('update data0072');
          sql.Add('set QUANTITY_RECEIVED=QUANTITY_RECEIVED-data0235.QUAN_RECD');
          sql.Add('from data0235 inner join data0072');
          sql.Add('on data0235.D0072_PTR=data0072.rkey');
          sql.Add('where data0235.GRN_PTR='+dm.ADO456rkey.AsString);
          ExecSQL;
        end;
        with dm.ADOQuery2 do  //�޸�208��235ָ��ΪNULL
        begin
          Close;
          SQL.Clear;
          sql.Text:=' update data0208 set SOURCE_PTR = null   '+#13+
                    ' from data0208  '+#13+
                    ' inner join data0235 on data0208.SOURCE_PTR = data0235.rkey  '+#13+
                    ' where data0235.GRN_PTR= ' + dm.Aqwz456RKEY.AsString ;
          ExecSQL;
        end;
        with dm.ADOQuery2 do
        begin
          close;
          sql.Clear;
          sql.Add('delete from data0235');
          sql.Add('where data0235.GRN_PTR='+dm.ADO456rkey.AsString);
          ExecSQL;
        end;
        self.data0235_post(dm.ADO456RKEY.Value);
      end;

   //  if (checkbox1.Checked)  then
      if self.recevied_over(dm.ADO456PO_PTR.Value,dm.ADO456TTYPE.Value) then
        with dm.adoquery2 do
        begin
          close;
          sql.clear;
          sql.Add('update data0070');
          sql.Add('set status=6');
          sql.Add('where rkey='+dm.ADO456PO_PTR.AsString);
          execsql;
        end
      else
      with dm.adoquery2 do
      begin
        close;
        sql.clear;
        sql.Add('update data0070');
        sql.Add('set status=5');
        sql.Add('where rkey='+dm.ADO456PO_PTR.AsString);
        execsql;
      end;

      dm.ADOConnection1.CommitTrans;

      if checkbox2.Checked then
      IF (dm.ADO456ttype.Value=1) and (dm.ADO456PRINTED.Value='N') THEN
        self.print_ininvt(dm.ADO456RKEY.Value)
      else
        IF (dm.ADO456ttype.Value=2) and (dm.ADO456PRINTED.Value='N') then
          self.print_misc(dm.ADO456RKEY.Value);

      self.ModalResult:=mrok;
    except
     on E: Exception do
      begin
       dm.ADOConnection1.RollbackTrans;
       messagedlg(E.Message,mterror,[mbcancel],0);
       edit6.SetFocus;
      end;
    end; //except_end
  end;//�༭_enc
end;

procedure TForm2.BitBtn4Click(Sender: TObject);
var i,iCount:Integer;
    tmpAdo:TADOQuery;
begin
if self.aded_flag=1 then
begin
////2017-04-26tang�޸�ͨ���ؼ�����������IQC���������ֹ�����
// for i:=1 to strgrid1.RowCount-1 do
//  if strtofloat(strgrid1.Cells[4,i])>0 then
//  strgrid1.Cells[7,i]:=
//  floattostr((strtofloat(strgrid1.Cells[3,i])-strtofloat(strgrid1.Cells[5,i]))*
//  strtofloat(strgrid1.Cells[4,i]))
//  else
//  strgrid1.Cells[7,i]:=
//  floattostr(strtofloat(strgrid1.Cells[3,i])-strtofloat(strgrid1.Cells[5,i]));

  iCount:=0;
  tmpAdo:=TADOQuery.Create(Application);
  try
    tmpAdo.Connection:=dm.ADOConnection1;
//ֻҪ�Ǽ����ϣ����ձ����391IQC�ж�ȡ��Ϣ----
    for I := 1 to StrGrid1.RowCount-1 do
    begin
      if (StrGrid1.Cells[12,i]='Y') and (StrToFloat(StrGrid1.Cells[3,i])>StrToFloat(StrGrid1.Cells[5,i])) then
      begin
        tmpAdo.Close;
        tmpAdo.SQL.Text:='select * from data0391 where Rkey71='+StrGrid2.Cells[0,i]+' and Rkey17='+StrGrid2.Cells[1,i]+' and stock_over=0 and (status=1 or status=2) order by auth_date';
        tmpAdo.Open;
        if (not tmpAdo.IsEmpty) then  //��Ӧһ��IQC�������391
        begin
          iCount:=iCount+1;
          StrGrid1.Cells[7,i]:=floattostr(tmpAdo.FieldByName('rece_qty').asFloat*strtofloat(StrGrid1.Cells[4,i]));//�������� *ת����
          StrGrid1.Cells[13,i]:=tmpAdo.FieldByName('manufacture_TDATE').AsString;//��������
          StrGrid1.Cells[9,i]:=tmpAdo.FieldByName('barch_no').AsString;//ԭ������
          StrGrid1.Cells[11,i]:=tmpAdo.FieldByName('supplier_model').AsString; //����Ҫ��
          StrGrid1.Cells[19,i]:=IntToStr(tmpAdo.RecordCount);
          StrGrid1.Cells[18,i]:=tmpAdo.FieldByName('Rkey').AsString; //391Rkey
        end;
      end else if (StrGrid1.Cells[12,i]='N') or (Trim(StrGrid1.Cells[12,i])='') then
      begin
        StrGrid1.Cells[7,i]:=FloatToStr(StrToFloat(StrGrid1.Cells[3,i])-StrToFloat(StrGrid1.Cells[5,i]));
        iCount:=1;
      end;
    end;
    if (iCount=0) then
    begin
      ShowMessage('��ǰICQû��ͨ������');
    end;
  finally
    tmpAdo.connection:=nil;
    tmpAdo.close;
    tmpAdo.free;
  end;
end
else
if self.aded_flag=2 then
 begin
 for i:=1 to strgrid3.RowCount-1 do
  strgrid3.Cells[6,i]:=
  floattostr(strtofloat(strgrid3.Cells[3,i]) - strtofloat(strgrid3.Cells[4,i]));

 end;
end;

function tform2.datecheck:Boolean;
var
  i:Word;
begin
 datecheck:=False;
 if Self.aded_flag=1 then
 begin
 for i:=1 to StrGrid1.RowCount-1 do
  if  (strtofloat(strgrid1.Cells[7,i])>0) and (StrToDate(strgrid1.Cells[13,i])>common.getsystem_date(dm.tmp,1))  then
  begin                    //�������ڲ��ܴ��ڵ�ǰ����
   datecheck:=true;
   break;
  end;
 end;
end;

function TForm2.location_over: boolean;
var
 i:word;
begin
 location_over:=false;
if self.aded_flag=1 then
begin
 for i:=1 to strgrid1.RowCount-1 do
  if (strgrid1.Cells[8,i]='') and (strtofloat(strgrid1.Cells[7,i])>0) then
  begin                    //�����������λ��
   location_over:=true;
   break;
  end;

 for i:=1 to strgrid1.RowCount-1 do
  if (strtofloat(strgrid1.Cells[7,i])>0) then
   begin                   //������һ���������
    break;
   end
  else
   if (i=strgrid1.RowCount-1) then
   begin
    location_over:=true;
   end;
end
else
if self.aded_flag=2 then
begin
 for i:=1 to strgrid3.RowCount-1 do
  if (strgrid3.Cells[7,i]='') and (strtofloat(strgrid3.Cells[6,i])>0) then
   begin                    //�����������λ��
    location_over:=true;
    break;
   end;
 for i:=1 to strgrid3.RowCount-1 do
  if (strtofloat(strgrid3.Cells[6,i])>0) then
   begin                    //������һ���������
    break;
   end
  else
   if (i=strgrid3.RowCount-1) then
    location_over:=true;
end;
end;

procedure TForm2.StrGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
  if self.aded_flag=4 then
    strgrid1.Options:=strgrid1.Options-[goEditing]
  else
  begin
    if ((aded_flag =1) or (aded_flag =3)) and (strgrid1.Cells[12,ARow]='Y') then
    begin
      if (acol<=8) or (ACol=12) or (ACol>=14) then
        strgrid1.Options:=strgrid1.Options-[goEditing]
      else
        strgrid1.Options:=strgrid1.Options+[goEditing];
    end else
    if ((aded_flag =1) or (aded_flag =3)) and (strgrid1.Cells[12,ARow]='N') then
    begin
      if (acol<=6) or (ACol=12) or (ACol>=14) then
        strgrid1.Options:=strgrid1.Options-[goEditing]
      else
        strgrid1.Options:=strgrid1.Options+[goEditing];
    end else
    begin
      if (acol<7) or (ACol=12) or (ACol>=14) then
        strgrid1.Options:=strgrid1.Options-[goEditing]
      else
        strgrid1.Options:=strgrid1.Options+[goEditing];
    end;
  end;
// if (acol<8) or (acol>=15) then
//  strgrid1.Options:=strgrid1.Options-[goEditing]
// else
//  strgrid1.Options:=strgrid1.Options+[goEditing];
end;

procedure TForm2.StrGrid1KeyPress(Sender: TObject; var Key: Char);
begin

 if strgrid1.Col=7 then
 if not (key in ['0'..'9','.',#8,#13]) then  //�ж��Ƿ���������
  abort
 else
  if key = chr(46) then      //�ж��Ƿ��ظ�����С����'.'
   if pos('.',strgrid1.Cells[7,strgrid1.Row])>0  then abort;

if (key <> chr(9)) then    //û�а�tab��
 begin
  if (strgrid1.Col=8) and (combobox1.Enabled) then
   begin
    ComboBox1.SetFocus;
    SendMessage(ComboBox1.Handle,WM_Char,word(Key),0);
   end;
  if (strgrid1.Col=10) and (combobox3.Enabled) then
   begin
    ComboBox3.SetFocus;
    SendMessage(ComboBox3.Handle,WM_Char,word(Key),0);
   end;
end;

end;

procedure TForm2.StrGrid1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if strgrid1.Col=7 then
 begin
  if strgrid1.Cells[7,strgrid1.Row]='' then strgrid1.Cells[7,strgrid1.Row]:='0';
  if form1.stock_flag='N' then   //�����������ܴ��ڶ�������
  if strtofloat(strgrid1.Cells[4,strgrid1.Row])>0 then//ת���ʴ���0
   begin
    if strtofloat(strgrid1.Cells[7,strgrid1.Row])>
      (strtofloat(strgrid1.Cells[3,strgrid1.Row])-strtofloat(strgrid1.Cells[5,strgrid1.Row]))*
       strtofloat(strgrid1.Cells[4,strgrid1.Row])  then
     strgrid1.Cells[7,strgrid1.Row]:=floattostr(
                                     (strtofloat(strgrid1.Cells[3,strgrid1.Row])-
                                      strtofloat(strgrid1.Cells[5,strgrid1.Row]))*
                                      strtofloat(strgrid1.Cells[4,strgrid1.Row])
                                                );
   end
  else
   begin
    if strtofloat(strgrid1.Cells[7,strgrid1.Row])>
     (strtofloat(strgrid1.Cells[3,strgrid1.Row])-strtofloat(strgrid1.Cells[5,strgrid1.Row])) then
     strgrid1.Cells[7,strgrid1.Row]:=floattostr(
                                      strtofloat(strgrid1.Cells[3,strgrid1.Row])-
                                      strtofloat(strgrid1.Cells[5,strgrid1.Row])
                                                );
   end;
 end;
end;

procedure TForm2.BitBtn1Enter(Sender: TObject);
var
 row:integer;
begin
if trim(edit6.Text)='' then
 begin
  showmessage('��ⵥ�Ų�����Ϊ��!');
  edit6.SetFocus;
  exit;
 end;

if not dm.Ado04.Active then dm.ado04.Open;
if (dm.ado04SEED_FLAG.Value<>1) and
  (not (edit6.Text[length(trim(edit6.Text))] in ['0'..'9'])) then
 begin
  messagedlg('��������һλ������һ������!',mtinformation,[mbok],0);
  edit6.SetFocus;
  exit;
 end;

if self.location_over then
 begin
  showmsg('������Ҫһ����ּ�¼���������λ��!',1);
  if self.aded_flag=1 then
  begin
   strgrid1.SetFocus;
   strgrid1.Col:=7;
  end
  else
   begin
    strgrid3.SetFocus;
    strgrid3.Col:=6;
   end;
  exit;
 end;

if self.datecheck then
 begin
  showmsg('������һ����ּ�¼�������ڴ��ڵ�ǰ����,������Ҫ��,���޸������������!',1);
  strgrid1.SetFocus;
  strgrid1.Col:=13;
  exit;
 end;

//if (strgrid1.Visible) and (self.Iqc_avlflag(row)) then
// begin
//  showmsg('����û��ͨ��IQC��鲻�����!',1);
//  strgrid1.SetFocus;
//  strgrid1.Row:=row;
//  exit;
// end;

if strtodatetime(edit11.Text) < dm.find_maxdate then
 begin
  messagedlg('�ͻ����ڱ�����ڲ���������������!',mterror,[mbok],0);
  edit11.SetFocus;
  exit;
 end;

end;

procedure TForm2.StrGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
begin
  if (gdSelected  in State) then
  begin
    if (ACol = 8 ) then
    begin
      ComboBox1.Left := Rect.Left;
      ComboBox1.Top := Rect.Top;
      ComboBox1.Width := Rect.Right - Rect.Left+3;
      ComboBox1.Height := Rect.Bottom - Rect.Top;
      if aded_flag = 4 then         //���״̬����Ҫ��ʾ
        ComboBox1.Visible := False
      else
        ComboBox1.Visible := True;
      if strgrid1.Cells[acol,arow]<>'' then
        combobox1.ItemIndex:=combobox1.Items.IndexOf(strgrid1.Cells[acol,arow])
      else
        combobox1.ItemIndex:=-1;
    end
    else
      ComboBox1.Visible :=false;

    if (ACol = 10 ) then
    begin
      ComboBox3.Left := Rect.Left;
      ComboBox3.Top := Rect.Top;
      ComboBox3.Width := Rect.Right - Rect.Left+3;
      ComboBox3.Height := Rect.Bottom - Rect.Top;
      if aded_flag = 4 then
      begin
        ComboBox3.Visible := False;
      end else
      begin
        ComboBox3.Visible := True;
      end;
      if (strgrid1.Cells[acol,arow]<>'') and (ComboBox3.Items.IndexOf(strgrid1.Cells[acol,arow])=-1) then
        ComboBox3.Text:=strgrid1.Cells[acol,arow]
      else if (strgrid1.Cells[acol,arow]<>'') and (ComboBox3.Items.IndexOf(strgrid1.Cells[acol,arow])<>-1) then
        ComboBox3.ItemIndex:=ComboBox3.Items.IndexOf(strgrid1.Cells[acol,arow])
      else
      begin
        combobox3.Items.Clear;
        combobox3.Text:='';
      end;
      if ((ComboBox3.Visible=True) and (StrGrid1.Cells[8,ARow]<>'')) then
      begin
        dm.aq176.Close;
        dm.aq176.Parameters[0].Value:= integer(combobox1.items.objects[ComboBox1.Items.IndexOf(StrGrid1.Cells[8,aRow])]);
        dm.aq176.Open;
        dm.aq176.First;
        combobox3.Items.Clear;
        while not dm.aq176.Eof do
        begin
          combobox3.Items.Add(dm.aq176LOCATION.Value);
          dm.aq176.Next;
        end;
      end;
      if (StrGrid1.Cells[8,ARow]='') then
      begin
        combobox3.Items.Clear;
        combobox3.Text:='';
      end;
    end
    else
      ComboBox3.Visible :=false;

    if (ACol = 13 ) then
    begin
      dtpk1.Left := Rect.Left;
      dtpk1.Top := Rect.Top;
      dtpk1.Width := Rect.Right - Rect.Left+3;
      dtpk1.Height := Rect.Bottom - Rect.Top;
      dtpk1.Visible := True;
      if trim(strgrid1.Cells[acol,arow])<>'' then
        dtpk1.Date:=strtodate(strgrid1.Cells[acol,arow]);
    end
    else
      dtpk1.Visible :=false;
  end;
end;

procedure TForm2.StrGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if (key=112) and (combobox1.Visible) then
  begin
   if combobox1.Enabled then
   begin
   combobox1.SetFocus;
   combobox1.DroppedDown:=true;
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

procedure TForm2.ComboBox1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key=112 then combobox1.DroppedDown:=true;    //f2
if key=13 then strgrid1.SetFocus;
end;

procedure TForm2.ComboBox1Change(Sender: TObject);
begin
 //dm.aq16.MoveBy(combobox1.ItemIndex+1-dm.aq16.RecNo);

 strgrid1.Cells[8,strgrid1.Row]:=combobox1.Text;
 strgrid2.Cells[5,strgrid1.Row]:=        //�ֿ�λ��16.rkey
  inttostr(Integer(ComboBox1.Items.Objects[ComboBox1.ItemIndex]));
end;


function Power(x, y : extended) : extended;
begin
 result := exp(y*ln(x));
end;


procedure TForm2.update_04(v_seed: string);
var
 i,v_length:integer;
 v_last,new_seed:string;
begin
 if dm.ado04SEED_FLAG.Value<>1 then
 begin
 v_length := length(v_seed);
 for i := v_length downto 1 do
  if (copy(v_seed,i,1)<'0') or (copy(v_seed,i,1)>'9') then  //�����������
   begin
    v_last := floattostr(power(10,v_length-1)+strtofloat(copy(v_seed,i+1,v_length-i))+1); //��׺��1
    new_seed := copy(v_seed,1,i)+copy(v_last,i+1,v_length-i);
    dm.ado04.Edit; //ʹǰ׺�����׺��1
    dm.ado04SEED_VALUE.Value := new_seed;
    dm.ado04.Post;
    break;
   end
  else
   if i=1 then //�����һλ��Ȼ������
    begin
     v_last := floattostr(power(10,v_length)+strtofloat(v_seed)+1);
     new_seed := copy(v_last,2,v_length);
     dm.ado04.Edit;
     dm.ado04SEED_VALUE.Value := new_seed;
     dm.ado04.Post;
    end;
 end;
end;

procedure TForm2.print_misc(rkey456: integer);
begin
 Form_miscreport:=tForm_miscreport.Create(application);
 Form_miscreport.Aqwz456.close;
 Form_miscreport.Aqwz456.Parameters[0].Value:=rkey456;
 Form_miscreport.Aqwz456.open;
 Form_miscreport.Aqwz235.Open;
 Form_miscreport.Aq493.Open;
 Form_miscreport.ppReport1.Print;
 Form_miscreport.free;
end;

procedure TForm2.print_ininvt(rkey456: integer);
begin
 form_report:=tform_report.Create(application);
 form_report.Aqwz456.close;
 form_report.Aqwz456.Parameters[0].Value:=rkey456;
 form_report.Aqwz456.open;
 FORM_REPORT.Aqwz22.Open;
 FORM_report.Aq493.Open;
 form_report.ppReport1.Print;
 form_report.free;
end;

function tform2.find_soerror(number:string):boolean;

begin
 result := false;
 with dm.ADOQuery1 do
  begin
   close;
   sql.Clear;
   sql.Add('select rkey from data0456');
   sql.Add('where GRN_NUMBER='''+number+'''');
   open;
   if not IsEmpty then result := true;
  end;

end;

procedure TForm2.StrGrid3DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
begin
if (gdSelected  in State) then
 begin
  if (ACol = 7 ) then
   begin
    ComboBox2.Left := Rect.Left;
    ComboBox2.Top := Rect.Top;
    ComboBox2.Width := Rect.Right - Rect.Left+3;
    ComboBox2.Height := Rect.Bottom - Rect.Top;
    ComboBox2.Visible := True;
    if strgrid3.Cells[acol,arow]<>'' then
     combobox2.ItemIndex:=combobox2.Items.IndexOf(strgrid3.Cells[acol,arow])
    else
     combobox2.ItemIndex:=-1;
   end
  else
    ComboBox2.Visible :=false;
 end;
end;

procedure TForm2.ComboBox2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key=112 then combobox2.DroppedDown:=true;
if key=13 then strgrid3.SetFocus;
end;

procedure TForm2.ComboBox2Change(Sender: TObject);
begin
 dm.aq16.MoveBy(combobox2.ItemIndex+1-dm.aq16.RecNo);
 strgrid3.Cells[7,strgrid3.Row]:=combobox2.Text;
 strgrid2.Cells[5,strgrid3.Row]:=dm.aq16rkey.AsString;
end;

procedure TForm2.StrGrid3SelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
if self.aded_flag=4 then
 strgrid3.Options:=strgrid3.Options-[goEditing]
else
 if (acol<6) or (ACol=10) or (ACol=8) then
  strgrid3.Options:=strgrid3.Options-[goEditing]
 else
  strgrid3.Options:=strgrid3.Options+[goEditing];
end;

procedure TForm2.StrGrid3KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if (key=112) and (combobox2.Visible) then
  begin
   if combobox2.Enabled then
   begin
   combobox2.SetFocus;
   combobox2.DroppedDown:=true;
   end;
  end;
end;

procedure TForm2.StrGrid3KeyPress(Sender: TObject; var Key: Char);
begin
 if strgrid3.Col=6 then
 if not (key in ['0'..'9','.',#8,#13]) then  //�ж��Ƿ���������
  abort
 else
  if key = chr(46) then      //�ж��Ƿ��ظ�����С����'.'
   if pos('.',strgrid3.Cells[6,strgrid1.Row])>0  then abort;

if (key <> chr(9)) then    //û�а�tab��
 begin
  if (strgrid3.Col=7) and (combobox2.Enabled) then
   begin
    ComboBox2.SetFocus;
    SendMessage(ComboBox2.Handle,WM_Char,word(Key),0);
   end;
 end;
end;

procedure TForm2.StrGrid3KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if strgrid3.Col=6 then
 begin
  if strgrid3.Cells[6,strgrid3.Row]='' then strgrid3.Cells[6,strgrid3.Row]:='0';
  if form1.stock_flag='N' then   //�����������ܴ��ڶ�������

   begin
    if strtofloat(strgrid3.Cells[6,strgrid3.Row])>
      (strtofloat(strgrid3.Cells[3,strgrid3.Row])-
      strtofloat(strgrid3.Cells[4,strgrid3.Row]))  then
     strgrid3.Cells[6,strgrid3.Row]:=floattostr(
                                     (strtofloat(strgrid3.Cells[3,strgrid3.Row])-
                                      strtofloat(strgrid3.Cells[4,strgrid3.Row])
                                      )
                                                );
   end;
 end;
end;

procedure TForm2.Edit11Exit(Sender: TObject);
begin
 try
  strtodatetime(edit11.Text);
 except
  messagedlg('�ͻ����ڸ�ʽ����!',mterror,[mbok],0);
  edit11.SetFocus;
 end;
end;

procedure TForm2.dtpk1Change(Sender: TObject);
begin
strgrid1.Cells[13,strgrid1.Row]:=datetostr(dtpk1.Date);
end;

procedure TForm2.dtpk1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key=13 then strgrid1.SetFocus;
end;

procedure TForm2.CheckBox3Click(Sender: TObject);
begin
self.get_location;
end;

procedure TForm2.ComboBox3KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key=112 then combobox3.DroppedDown:=true;    //f2  //112��F1tang
if key=13 then strgrid1.SetFocus;
end;

procedure TForm2.ComboBox3Exit(Sender: TObject);
begin
 strgrid1.Cells[10,strgrid1.Row]:=combobox3.Text;
end;

procedure TForm2.IQC1Click(Sender: TObject);
var InputVar: PDlgInput ;
    s71,s17:string;
    tmpAdo:TADOQuery;
begin
  tmpAdo:=TADOQuery.Create(Application);
  try
    tmpAdo.Connection:=dm.ADOConnection1;
    tmpAdo.Close;
    tmpAdo.SQL.Text:='select * from data0391 where Rkey71='+StrGrid2.Cells[0,StrGrid1.Row]+' and Rkey17='+StrGrid2.Cells[1,StrGrid1.Row]+' and stock_over=0 and (status=1 or status=2) order by auth_date';
    tmpAdo.Open;
    if (not tmpAdo.IsEmpty) and (StrGrid1.Cells[12,StrGrid1.Row]='Y') and (StrToFloat(StrGrid1.Cells[3,StrGrid1.Row])>StrToFloat(StrGrid1.Cells[5,StrGrid1.Row])) then
    if (tmpAdo.RecordCount=1) then
    begin
      StrGrid1.Cells[7,StrGrid1.Row]:=floattostr(tmpAdo.FieldByName('rece_qty').asFloat*strtofloat(StrGrid1.Cells[4,StrGrid1.Row]));//�������� *ת����
      StrGrid1.Cells[13,StrGrid1.Row]:=tmpAdo.FieldByName('manufacture_TDATE').AsString;//��������
      StrGrid1.Cells[9,StrGrid1.Row]:=tmpAdo.FieldByName('barch_no').AsString; //ԭ������
      StrGrid1.Cells[11,StrGrid1.Row]:=tmpAdo.FieldByName('supplier_model').AsString; //����Ҫ��
      StrGrid1.Cells[18,StrGrid1.Row]:=tmpAdo.FieldByName('Rkey').AsString; //391Rkey
    end else
    if (tmpAdo.RecordCount>1) then
    begin
      try
        s71:=Trim(StrGrid2.Cells[0,StrGrid1.Row]);
        s17:=Trim(StrGrid2.Cells[1,StrGrid1.Row]);
        frmPick_Item_Single := TfrmPick_Item_Single.Create(application) ;
        InputVar.Fields := 'iqc_number/�����/100,barch_no/���κ�/120,supplier_model/��Ӧ���ͺ�/100,rece_qty/�������/60,auth_date/�������/120,manufacture_TDATE/��������/120';
        InputVar.Sqlstr := 'SELECT  DATA0391.rkey, iqc_number, rkey71, rkey17, supplier_model, sgs_no, sgs_date, rece_qty, iqc_qty, barch_no, appl_user_ptr, appl_date, appr_user_ptr,'
              +' appr_date, auth_user_ptr, auth_date, if_halogen, appearance, part_size, part_thickness, tong_thickness, thick_tolerance, ht_remark, if_standard,'
              +' extrl_date, judge_result, remark, DATA0391.status, manufacture_TDATE, package_qualified, qty_qualified, hasheepreport, stock_over,data0071.extra_req'
              +' FROM DATA0391 inner join data0071 on data0391.rkey71=data0071.rkey inner join data0017 on data0391.rkey17=data0017.rkey where data0071.Rkey= '+s71+' AND data0017.rkey='+s17+' and stock_over=0 and DATA0391.status<>3 order by data0391.auth_date';
        InputVar.AdoConn := DM.ADOConnection1;
        frmPick_Item_Single.InitForm_New(InputVar)  ;
        if frmPick_Item_Single.ShowModal=mrok then
        begin
          StrGrid1.Cells[7,StrGrid1.Row]:=floattostr(frmPick_Item_Single.adsPick1.FieldByName('rece_qty').asFloat*strtofloat(StrGrid1.Cells[4,StrGrid1.Row]));//�������� *ת����
          StrGrid1.Cells[13,StrGrid1.Row]:=frmPick_Item_Single.adsPick1.FieldByName('manufacture_TDATE').AsString;
          StrGrid1.Cells[9,StrGrid1.Row]:=frmPick_Item_Single.adsPick1.FieldByName('barch_no').AsString;
          StrGrid1.Cells[11,StrGrid1.Row]:=frmPick_Item_Single.adsPick1.FieldByName('supplier_model').AsString;
          StrGrid1.Cells[18,StrGrid1.Row]:=frmPick_Item_Single.adsPick1.FieldByName('Rkey').AsString;
        end;
      finally
        frmPick_Item_Single.adsPick.Close;
        frmPick_Item_Single.Free ;
      end;
    end;
  finally
    tmpAdo.connection:=nil;
    tmpAdo.close;
    tmpAdo.free;
  end;
end;

procedure TForm2.Button2Click(Sender: TObject);
var i,iCount:Integer;
    tmpAdo:TADOQuery;
begin
  iCount:=0;
  tmpAdo:=TADOQuery.Create(Application);
  try
    tmpAdo.Connection:=dm.ADOConnection1;
//ֻҪ�Ǽ����ϣ����ձ����391IQC�ж�ȡ��Ϣ----
    for I := 1 to StrGrid1.RowCount-1 do
    begin
      if (StrGrid1.Cells[12,i]='Y') and (StrToFloat(StrGrid1.Cells[3,i])>StrToFloat(StrGrid1.Cells[5,i])) then
      begin
        tmpAdo.Close;
        tmpAdo.SQL.Text:='select * from data0391 where Rkey71='+StrGrid2.Cells[0,i]+' and Rkey17='+StrGrid2.Cells[1,i]+' and stock_over=0 and (status=1 or status=2) order by auth_date';
        tmpAdo.Open;
        if (not tmpAdo.IsEmpty) then  //��Ӧһ��IQC�������391
        begin
          iCount:=iCount+1;    
          StrGrid1.Cells[7,i]:=floattostr(tmpAdo.FieldByName('rece_qty').asFloat*strtofloat(StrGrid1.Cells[4,i]));//�������� *ת����
          StrGrid1.Cells[13,i]:=tmpAdo.FieldByName('manufacture_TDATE').AsString;//��������
          StrGrid1.Cells[9,i]:=tmpAdo.FieldByName('barch_no').AsString; //ԭ������
          StrGrid1.Cells[11,i]:=tmpAdo.FieldByName('supplier_model').AsString; //����Ҫ��
          StrGrid1.Cells[19,i]:=IntToStr(tmpAdo.RecordCount);
          StrGrid1.Cells[18,i]:=tmpAdo.FieldByName('Rkey').AsString; //391Rkey
        end;
      end else Continue;
    end;
    if (iCount=0) then
    begin
      ShowMessage('��ǰIQCû��ͨ������');
    end;
  finally
    tmpAdo.connection:=nil;
    tmpAdo.close;
    tmpAdo.free;
  end;
end;

procedure TForm2.PopupMenu1Popup(Sender: TObject);
begin
//  if (Trim(StrGrid1.Cells[19,StrGrid1.Row])<>'') and (StrToInt(StrGrid1.Cells[19,StrGrid1.Row])>1) then
//  IQC1.Enabled:=True else IQC1.Enabled:=False;
end;

procedure TForm2.N2Click(Sender: TObject);
begin
  StrGrid1.Cells[7,StrGrid1.Row]:='0';
  StrGrid1.Cells[13,StrGrid1.Row]:='';
  StrGrid1.Cells[9,StrGrid1.Row]:='';
  StrGrid1.Cells[11,StrGrid1.Row]:='';
  StrGrid1.Cells[18,StrGrid1.Row]:='';
end;

end.
