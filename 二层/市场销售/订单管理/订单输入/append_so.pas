unit append_so;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, Mask, StdCtrls, ComCtrls, ExtCtrls, Grids, Menus;

type
  TContractInfo = record
    ContractNo: string;
    Qnty: Integer;
    EngAmount: Double;
    TestAmount: Double;
    AftDiscountAmount: Double;
  end;

  TForm3 = class(TForm)
    Button1: TButton;
    Button2: TButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    Edit5: TEdit;
    Edit9: TEdit;
    MaskEdit1: TMaskEdit;
    MaskEdit2: TMaskEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Bevel1: TBevel;
    Bevel2: TBevel;
    Label10: TLabel;
    Label11: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    StringGrid1: TStringGrid;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    StringGrid2: TStringGrid;
    Edit11: TEdit;
    Edit12: TEdit;
    Edit13: TEdit;
    Label29: TLabel;
    Label30: TLabel;
    Label32: TLabel;
    Label33: TLabel;
    Label34: TLabel;
    Label35: TLabel;
    Label36: TLabel;
    PopupMenu1: TPopupMenu;
    add_rep: TMenuItem;
    edit_rep: TMenuItem;
    del_rep: TMenuItem;
    Edit16: TEdit;
    Edit18: TEdit;
    Label26: TLabel;
    Label27: TLabel;
    Label39: TLabel;
    Label40: TLabel;
    Label_qteptr: TLabel;
    Edit10: TEdit;
    SpeedButton1: TSpeedButton;
    Label22: TLabel;
    Label41: TLabel;
    Label4: TLabel;
    Label16: TLabel;
    ComboBox1: TComboBox;
    Label28: TLabel;
    Label31: TLabel;
    Label12: TLabel;
    MaskEdit3: TMaskEdit;
    Edit4: TEdit;
    Label20: TLabel;
    Label21: TLabel;
    Edit7: TEdit;
    btnFindContract: TBitBtn;
    Bevel3: TBevel;
    Label37: TLabel;
    Label38: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    btn1: TBitBtn;
    ComboBox2: TComboBox;
    procedure Button1Click(Sender: TObject);
    procedure Edit2KeyPress(Sender: TObject; var Key: Char);
    procedure Edit3KeyPress(Sender: TObject; var Key: Char);
    procedure Edit3Exit(Sender: TObject);
    procedure Edit5KeyPress(Sender: TObject; var Key: Char);
    procedure Edit5Exit(Sender: TObject);
    procedure MaskEdit1Exit(Sender: TObject);
    procedure MaskEdit2Exit(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure StringGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure StringGrid1Exit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure StringGrid2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure add_repClick(Sender: TObject);
    procedure edit_repClick(Sender: TObject);
    procedure StringGrid2DblClick(Sender: TObject);
    procedure del_repClick(Sender: TObject);
    procedure TabSheet2Exit(Sender: TObject);
    procedure Edit2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit3KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit5KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit6KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure MaskEdit1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure MaskEdit2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit16KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit16Exit(Sender: TObject);
    procedure Edit18Exit(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure Edit9KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormDestroy(Sender: TObject);
    procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure ComboBox1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ComboBox1Change(Sender: TObject);
    procedure MaskEdit3KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure MaskEdit3Exit(Sender: TObject);
    procedure btnFindContractClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    function return_vifrkey(sgrid: tstringgrid;col: integer): string;
    procedure btn1Click(Sender: TObject);
  private

   flag: Byte;
   ContractInfo: TContractInfo;

   function cacl_deficiency(rkey10:integer; nowAmount: currency):currency;//����ͻ���Ƿ���

  public
    { Public declarations }
   rkey213:Integer;
   FBp06_ptr: string;
   FBomBuHanShuiJiaGe: string;
  end;

var
  Form3: TForm3;
  v_row:byte;
implementation
uses damo, addsa_order, soprice_sea, edit_rep, main, quote_price,COMMON,
  FindContract, FindBook, ConstVar, Pick_Item_Single;
{$R *.dfm}

procedure TForm3.Button1Click(Sender: TObject);

begin
if ((strtoint(edit2.Text) mod form2.set_qty) <> 0) and
   (messagedlg('��������pcs���ǳ�������set�ı���,�Ƿ����?',mtconfirmation,[mbYes,mbNo],0)=mrno) then
 begin
  edit2.SetFocus;
  exit;
 end;

if (edit1.Visible=true) and (trim(edit1.Text)='') then
 begin
  showmessage('���۶�����Ų���Ϊ��');
  edit1.SetFocus;
  exit;
 end;

//20161018tang��ѡ��Ԥ����״̬���޸ĵ��µ��������ܳ���Ԥ��������֮��
  if (BitBtn2.Tag>0) then
  if ((StrToInt(Edit2.Text)+edit2.Tag)>BitBtn1.Tag) then
  begin
    showmessage('��������֮�Ͳ��ܴ���Ԥ����������');
    edit2.SetFocus;
    exit;
  end;
//end 20161018---
if (strtoint(edit2.Text)=0) then      //����Ϊ0
 begin
 if messagedlg('��������Ϊ��,�Ƿ����?',mtconfirmation,[mbYes,mbNo],0) = mrNo then
  begin
   edit2.SetFocus;
   exit;
  end;
 end;
if (dm.aq192suplcimat.Value<>'Y') and   //���弰��Ʒ���������SO���۲�����Ϊ��
   (form2.v_part_num<>1) and            //��������
   (form2.ComboBox2.ItemIndex<>1) and   //���Ǳ�Ʒ
   (strtofloat(edit3.Text)=0) then      //����Ϊ��
 begin
  showmessage('���弰��Ʒ���������SO���۲�����Ϊ��');
  edit3.SetFocus;
  exit;
 end;
  if FBp06_ptr = '' then
  if not ((ContractInfo.ContractNo<>'') or (Form2.checkRFQContractNo(form2.Edit7.Text)))  then  //������RFQ��ͬ��
  begin
    if (form2.quote_flag) and   //��Ʒ�뱨�۵�����
       (label_qteptr.Caption='0') and      //û�б��۵�
       (form2.ComboBox2.ItemIndex=0) and    //��ʽ
       (form2.RadioGroup1.ItemIndex=0) and   //����
       (Form2.customer_quote) then        //�ͻ��۸�ǿ�ƹ������۵�
    begin
      showmessage('�����Ѿ��뱨�۵�ǿ�ƹ���,��ѡ��һ�����۵���');
      bitbtn2.SetFocus;
      exit;
    end;
  end;
 with dm.aqTmp do
 begin
   Close;
   SQL.Clear;
   SQL.Add('SELECT 1 FROM Data0192 WHERE CUSTSTAPROD=''Y''');
   Open;
 end;
 IF dm.aqTmp.RecordCount>0 then
 begin
   if form2.credit_rating = 3 then
    begin
     messagedlg('�ͻ�:'+form2.edit3.Text+'���õȼ�̫��,�����޷�����!',mtwarning,[mbok],0);
     exit;
    end
   else
    if form2.credit_rating = 1 then //���õȼ�Ϊ�ţ������޶������ʾ����Ȼ����
     begin                               //��������
      if cacl_deficiency(strtoint(form2.lab_rkey10.Caption),
                  StrToCurr(Label34.Caption)/StrtoCurr(form2.Edit9.Text))>form2.credit_limit+1 then
      if messagedlg('�ͻ�:'+form2.edit3.Text+'δ����������������޶��Ƿ����?',
       mtconfirmation,[mbyes,mbno],0)=mrno then
       begin
        ModalResult:=mrcancel;
        exit;
       end;
     end
    else //���õȼ�Ϊ����ֻ�����޶����ڿ������۶���
     begin
      if cacl_deficiency(strtoint(form2.lab_rkey10.Caption),
                  StrToCurr(Label34.Caption)/StrtoCurr(form2.Edit9.Text))>form2.credit_limit+1 then
       begin
        messagedlg('�ͻ�:'+form2.edit3.Text+'δ����������������޶��޷�����!',mtwarning,[mbok],0);
        ModalResult:=mrcancel;
        exit;
       end;
     end;
 end;


  edit3exit(sender);     //���¼���'�ϼ�'ҳ����������
 if ((flag = 1) and Form2.checkRFQContractNo(Form2.Edit7.Text)) then
   Form2.Edit7.Text:= '';
 if flag = 2 then Form2.Edit7.Text:= ContractInfo.ContractNo;
 if flag = 3 then Form2.Edit7.Text:= '';

 Form2.Lab283.Tag:=integer(combobox2.items.objects[combobox2.itemindex]);
 ModalResult:=mrok;
end;

procedure TForm3.Edit2KeyPress(Sender: TObject; var Key: Char);
begin
if not (key in ['0'..'9',#8,#13]) then  //�ж��Ƿ���������
 abort;
end;

procedure TForm3.Edit3KeyPress(Sender: TObject; var Key: Char);
begin
 if not (key in ['0'..'9','.',#8,#13]) then  //�ж��Ƿ���������
  abort
 else
 if key = chr(46) then      //�ж��Ƿ��ظ�����С����'.'
  if pos('.',(sender as tedit).Text)>0 then
   abort;
end;

procedure TForm3.Edit3Exit(Sender: TObject);
begin
  if (form2.Edit2.text='') then form2.Edit2.text:='0';
//  if (strtofloat(form2.Edit2.text)=0) then form2.Edit2.text:='1';

 if edit2.Text='' then edit2.Text:='0';   //����pcs
 if edit3.Text='' then edit3.Text:='0';  //�۸�pcs

if (strtoint(edit2.Text) mod form2.set_qty) <> 0 then
 edit16.Text:=inttostr(round(strtoint(edit2.Text)/form2.set_qty))
else
 edit16.Text:=floattostr(strtoint(edit2.Text)/form2.set_qty);

 edit3.Text :=formatfloat('0.00000000',strtofloat(edit3.Text));
 edit18.Text:=formatfloat('0.00000000',strtofloat(edit3.Text)*form2.set_qty);

 if form2.RadioGroup2.ItemIndex=0 then //�۸񲻺�˰
  label30.caption:=formatfloat('0.0000',strtofloat(edit3.text)*strtofloat(edit2.text))
 else
  label30.caption:=formatfloat('0.0000',strtofloat(edit3.text)*strtofloat(edit2.text)
                                        /(1+strtofloat(form2.Edit2.text)*0.01));
     //˰��
label16.Caption:=formatfloat('0.000',strtofloat(label30.Caption)*strtofloat(form2.Edit2.text)*0.01);
     //�ۿ�
label32.caption:=formatfloat('0.000',strtofloat(label30.caption)*strtofloat(edit5.text)*0.01);
     //�ܼ�
if form2.RadioGroup2.ItemIndex=0 then //�۸񲻺�˰
 label34.Caption:=formatfloat('0.0000',strtofloat(label30.Caption)+
                                      strtofloat(label16.Caption)+
                                      strtofloat(label33.Caption)+
                                      strtofloat(label31.Caption)-
                                      strtofloat(label32.Caption)) //�ۿ�
else
 label34.Caption:=formatfloat('0.0000',strtofloat(label30.Caption)+
                                      strtofloat(label33.Caption)+
                                      strtofloat(label16.Caption)-
                                      strtofloat(label32.Caption)); //�ۿ�
label41.Caption:=formatfloat('0.0000',strtofloat(edit2.text)*form2.unit_sq);//���
end;

procedure TForm3.Edit5KeyPress(Sender: TObject; var Key: Char);
begin

 if edit5.Text<>'' then  //�������ֲ��ܴ���100
 if (strtofloat(edit5.Text)>=100) and (key <> chr(8)) then
   abort;
 if not (key in ['0'..'9','.',#8,#13]) then  //�ж��Ƿ���������
  abort
 else
  if pos('.',edit5.Text)>0 then     //�ж��Ƿ��ظ�����С����'.'
   if key = chr(46)  then abort;

end;

procedure TForm3.Edit5Exit(Sender: TObject);
begin
if edit5.Text='' then edit5.Text:='0';
 edit5.Text:=formatfloat('0.00',strtofloat(edit5.Text));

label32.caption:=formatfloat('0.000',strtofloat(label30.caption)*strtofloat(edit5.text)*0.01);

if form2.RadioGroup2.ItemIndex=0 then //�۸񲻺�˰
 label34.Caption:=formatfloat('0.0000',strtofloat(label30.Caption)+
                                      strtofloat(label16.Caption)+
                                      strtofloat(label33.Caption)+
                                      strtofloat(label31.Caption)-
                                      strtofloat(label32.Caption)) //�ۿ�
else
 label34.Caption:=formatfloat('0.0000',strtofloat(label30.Caption)+
                                      strtofloat(label33.Caption)+
                                      strtofloat(label16.Caption)-
                                      strtofloat(label32.Caption)); //�ۿ�
end;

procedure TForm3.MaskEdit1Exit(Sender: TObject);
begin
try
 maskedit2.Text := datetostr(strtodate(maskedit1.text)-strtoint(form2.label49.caption));
 if strtodate(maskedit2.Text)<getsystem_date(DM.ADOQuery5,1)+form2.shelf_life then
  IF  messagedlg('�ƻ�װ������Ҫ���ڲ�Ʒ��������֮ǰ,���ܵ��²��ܰ�ʱ����,������?',
      mtConfirmation,[mbyes,mbcancel],0)=mrcancel then
   maskedit1.SetFocus;
except
 messagedlg('�ͻ����������ʽ����,����ϸ���!',mtwarning,[mbok],0);
 maskedit1.SetFocus;
end;
end;

procedure TForm3.MaskEdit2Exit(Sender: TObject);
begin
try
 if strtodate(maskedit2.Text) < getsystem_date(DM.ADOQuery5,1)+form2.shelf_life then
  IF  messagedlg('�ƻ�װ������Ҫ���ڲ�Ʒ��������֮ǰ,���ܵ��²��ܰ�ʱ����,������?',
      mtConfirmation,[mbyes,mbcancel],0)=mrcancel then
   maskedit2.SetFocus;
except
 messagedlg('�ƻ���װ�����ڸ�ʽ��������ϸ���!',mtwarning,[mbok],0);
 maskedit2.SetFocus;
end;
end;

procedure TForm3.BitBtn1Click(Sender: TObject);
begin
 try
  form4:=tform4.Create(application);
  with dm.ADOQuery2 do
   begin
    if active=true then active:=false;
    sql.Clear;
    sql.Add('select sales_order,ent_date,po_number,parts_ordered,part_price,');
    sql.Add('case data0060.so_tp when 0 then ''����'' when 1 then ''�ⷢ'' when 2 then ''���Ƴ�'' end as sotp,data0023.code');
    sql.Add('from data0060 inner join data0097 on data0060.purchase_order_ptr=data0097.rkey ');
    sql.Add('left outer join data0023 on Data0060.supplier_ptr = data0023.RKEY');
    sql.Add('where data0060.cust_part_ptr='+form2.lab_rkey50.Caption);
    sql.Add('and data0060.part_price<>0');
    sql.Add('order by ent_date desc');   //��ʱ�併������
    active:=true;
   end;
  form4.ShowModal;
 finally
  form4.free;
 end;
end;

procedure TForm3.FormActivate(Sender: TObject);
begin
PageControl1.ActivePageIndex:=0;
if edit16.Visible=true then
 edit16.SetFocus
else
 if edit2.Visible=true then
  edit2.SetFocus
 else
  edit3.SetFocus;

stringgrid1.Cells[0,0]:='���߷������';
stringgrid1.Cells[1,0]:='���';
stringgrid1.Cells[2,0]:='���ʽ��';
stringgrid1.Cells[3,0]:='���ս��';
stringgrid1.Cells[4,0]:='��˰';
stringgrid1.ColWidths[5]:=-1;

stringgrid2.Cells[0,0]:='����';
stringgrid2.Cells[1,0]:='����';
stringgrid2.Cells[2,0]:='Ӷ��%';
stringgrid2.Cells[3,0]:='����%';

label40.Caption:=inttostr(form2.set_qty);//�����巽ʽ

end;

procedure TForm3.StringGrid1SelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin

if (ARow=stringgrid1.RowCount-1) then
 CanSelect:=false
else
 CanSelect:=true;

 if stringgrid1.Row<>stringgrid1.RowCount-1 then
  begin
   if stringgrid1.Cells[1,stringgrid1.Row]='' then
    stringgrid1.Cells[1,stringgrid1.Row]:='0';
   if stringgrid1.Cells[2,stringgrid1.Row]='' then
    stringgrid1.Cells[2,stringgrid1.Row]:='0';
   stringgrid1.Cells[1,stringgrid1.Row]:=
   formatfloat('0.0000',strtofloat(stringgrid1.Cells[1,stringgrid1.Row]));
   stringgrid1.Cells[2,stringgrid1.Row]:=
   formatfloat('0.0000',strtofloat(stringgrid1.Cells[2,stringgrid1.Row]));
  end;

end;

procedure TForm3.StringGrid1KeyPress(Sender: TObject; var Key: Char);
begin
 if not (key in ['0'..'9','.',#8,#13]) then  //�ж��Ƿ���������
  abort
 else
 if (pos('.',stringgrid1.Cells[stringgrid1.col,stringgrid1.row])>0)  then     //�ж��Ƿ��ظ�����С����'.'
  if key = chr(46)  then abort;

if (key <> chr(9)) then    //û�а�tab��
 begin
  if (stringgrid1.Col=4) and (combobox1.Enabled) then
   begin
    ComboBox1.SetFocus;
    SendMessage(ComboBox1.Handle,WM_Char,word(Key),0);
   end;
 end;

end;

procedure TForm3.StringGrid1Exit(Sender: TObject);
begin
 if stringgrid1.Row<>stringgrid1.RowCount-1 then
  begin
   if stringgrid1.Cells[1,stringgrid1.Row]='' then
    stringgrid1.Cells[1,stringgrid1.Row]:='0';
   if stringgrid1.Cells[2,stringgrid1.Row]='' then
    stringgrid1.Cells[2,stringgrid1.Row]:='0';
   if stringgrid1.Cells[3,stringgrid1.Row]='' then
    stringgrid1.Cells[3,stringgrid1.Row]:='0';

   stringgrid1.Cells[1,stringgrid1.Row]:=
    formatfloat('0.0000',strtofloat(stringgrid1.Cells[1,stringgrid1.Row]));
   stringgrid1.Cells[2,stringgrid1.Row]:=
    formatfloat('0.0000',strtofloat(stringgrid1.Cells[2,stringgrid1.Row]));
   stringgrid1.Cells[3,stringgrid1.Row]:=
    formatfloat('0.0000',strtofloat(stringgrid1.Cells[3,stringgrid1.Row]));
  end;
end;

procedure TForm3.FormCreate(Sender: TObject);
var
i:byte;
begin
dm.ADOSPprice.Close;
dm.ADOSPprice.Parameters[1].Value:=form2.lab_rkey50.Caption;
dm.ADOSPprice.Open;
if not dm.ADOSPprice.IsEmpty then  //�������һ�β�Ʒ���ۼ۸�
label35.Caption:=formatfloat('0.00000000',dm.ADOSPprice.FieldValues['part_price']);

if trim(form2.Lab_rkey97.Caption)<>'' then
begin
dm.ADOSPpoprice.Close;
dm.ADOSPpoprice.Parameters.ParamByName('@rkey50').Value:=form2.lab_rkey50.Caption;
dm.ADOSPpoprice.Parameters.ParamByName('@rkey97').Value:=form2.Lab_rkey97.Caption;
dm.ADOSPpoprice.Open;
if not dm.ADOSPpoprice.IsEmpty then
Label36.Caption:=formatfloat('0.00000000',dm.ADOSPpoprice.fieldvalues['part_price']);
end;

 WITH dm.ADOQuery3 DO
  begin
   active:=false;
   sql.Clear;            //���ҹ��߷������
   sql.Add('select rkey,category,TAX_FLAG from data0061 order by rkey');
   active:=true;
   stringgrid1.RowCount:=recordcount+2;
   for i:=1 to RecordCount do
   begin
    stringgrid1.Cells[0,i]:=fieldbyname('category').AsString;
    StringGrid1.Cells[1,i]:='0.0000';
    StringGrid1.Cells[2,i]:='0.0000';
    StringGrid1.Cells[3,i]:='0.0000';
    StringGrid1.Cells[4,i]:=fieldbyname('TAX_FLAG').AsString;
    stringgrid1.Cells[5,i]:=fieldbyname('rkey').AsString;
    next;
   end;
  end;

 if (form2.quote_flag) and (Form2.customer_quote) then       //�뱨�۵�����
  begin
   if form2.RadioGroup1.ItemIndex=0 then  //�ӹ���ʽ����
    begin
     edit3.ReadOnly := true;
     edit18.ReadOnly := true;
     edit3.Color := cl3dlight;
     edit18.Color := cl3dlight;
    end;
   if form2.ComboBox2.ItemIndex=1 then //��Ʒ����
    bitbtn2.Enabled:=false;
  end;

 if dm.aq192custcitool.Value='Y' then //��������set����
  begin
   label2.Visible:=true;
   label3.Visible:=true;
   edit16.Visible:=true;
   edit18.Visible:=true;
   label26.Left:=226;
   edit2.Left:=303
  end;
  flag:= 0;
end;

procedure TForm3.PopupMenu1Popup(Sender: TObject);
begin
if stringgrid2.RowCount=7 then
  add_rep.Enabled:=false
 else
  add_rep.Enabled:=true;
 if stringgrid2.Row=stringgrid2.RowCount-1 then
  begin
   edit_rep.Enabled:=false;
   del_rep.Enabled:=false;
  end
 else
  begin
   edit_rep.Enabled:=TRUE;
   del_rep.Enabled:=TRUE;
  end;
end;

procedure TForm3.StringGrid2MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  column,row:integer;
begin
if button=mbright then
 begin
  stringgrid2.MouseToCell(x,y,column,row);
   if row<>0 then
  stringgrid2.Row:=row;
 end;

end;

procedure TForm3.add_repClick(Sender: TObject);
var
i:byte;
begin
 try
  form5:=tform5.Create(application);
  if form5.ShowModal=mrok  then
    begin
     for i := 1 to stringgrid2.RowCount-2 do //�Ƚ��Ƿ��ظ�
      if comparetext(stringgrid2.Cells[0,i],form5.Edit1.Text)=0 then
         begin
          messagedlg('���۴����ظ�!',mtwarning,[mbok],0);
          exit;
         end;
     stringgrid2.Cells[0,stringgrid2.RowCount-1]:=form5.Edit1.Text;
     stringgrid2.Cells[1,stringgrid2.RowCount-1]:=form5.Label4.Caption;
     stringgrid2.Cells[2,stringgrid2.RowCount-1]:=form5.Edit2.Text;
     stringgrid2.Cells[3,stringgrid2.RowCount-1]:=form5.Edit3.Text;
     stringgrid2.Cells[4,stringgrid2.RowCount-1]:=form5.Label7.Caption;
     stringgrid2.RowCount:=stringgrid2.RowCount+1;
    end;
 finally
  form5.Free;
 end;
end;

procedure TForm3.edit_repClick(Sender: TObject);
var
i:byte;
begin
 try
  form5:=tform5.Create(application);
  form5.Edit1.Text:=stringgrid2.Cells[0,stringgrid2.row];
  form5.Edit2.Text:=stringgrid2.Cells[2,stringgrid2.row];
  form5.Edit3.Text:=stringgrid2.Cells[3,stringgrid2.row];
  form5.Label4.Caption:=stringgrid2.Cells[1,stringgrid2.row];
  form5.Label7.Caption:=stringgrid2.Cells[4,stringgrid2.row];
  if form5.ShowModal=mrok then
   begin
    for i := 1 to stringgrid2.RowCount-2 do //�Ƚ��Ƿ��ظ�
     if i <> stringgrid2.Row then
      if comparetext(stringgrid2.Cells[0,i],form5.Edit1.Text)=0 then
       begin
        messagedlg('���۴����ظ�!',mtwarning,[mbok],0);
        exit;
       end;
     stringgrid2.Cells[0,stringgrid2.row]:=form5.Edit1.Text;
     stringgrid2.Cells[2,stringgrid2.row]:=form5.Edit2.Text;
     stringgrid2.Cells[3,stringgrid2.row]:=form5.Edit3.Text;
     stringgrid2.Cells[1,stringgrid2.row]:=form5.Label4.Caption;
     stringgrid2.Cells[4,stringgrid2.row]:=form5.Label7.Caption;
   end;
 finally
  form5.free;
 end;
end;

procedure TForm3.StringGrid2DblClick(Sender: TObject);
begin
 if trim(stringgrid2.Cells[0,stringgrid2.Row])<>'' then
    edit_repclick(sender);
end;

procedure TForm3.del_repClick(Sender: TObject);
var
 i:byte;
begin
 for i:=stringgrid2.Row to stringgrid2.RowCount-2 do
  stringgrid2.Rows[i].Text:=stringgrid2.Rows[i+1].Text;
  stringgrid2.RowCount:=stringgrid2.RowCount-1;
end;

procedure TForm3.TabSheet2Exit(Sender: TObject);
var
tool,tax_amount:single;
i:byte;
begin
 tool:=0;
 tax_amount:=0;
for i:=1 to stringgrid1.RowCount-2 do
if strtocurr(stringgrid1.Cells[1,i])>0 then
 begin
  tool:=tool+strtocurr(stringgrid1.Cells[1,i]);
  if form2.RadioGroup2.ItemIndex=0 then //�۸񲻺�˰
   if stringgrid1.Cells[4,i]='Y' then
    tax_amount:=tax_amount+strtocurr(floattostrf(
                           strtocurr(stringgrid1.Cells[1,i])*
                           strtocurr(form2.Edit2.text)*0.01,ffFixed,10,4))
   else
  else   //����˰
   if stringgrid1.Cells[4,i]='Y' then
    tax_amount:=tax_amount+strtocurr(floattostrf(
            strtocurr(stringgrid1.Cells[1,i])*strtocurr(form2.Edit2.text)*0.01/
                       (1+strtocurr(form2.Edit2.text)*0.01),ffFixed,10,4));
 end;

 label33.Caption:=formatfloat('0.0000',tool);
 label31.Caption:=formatfloat('0.0000',tax_amount);

if form2.RadioGroup2.ItemIndex=0 then //�۸񲻺�˰
 label34.Caption:=formatfloat('0.0000',strtofloat(label30.Caption)+
                                      strtofloat(label16.Caption)+
                                      strtofloat(label33.Caption)+
                                      strtofloat(label31.Caption)-
                                      strtofloat(label32.Caption)) //�ۿ�
else
 label34.Caption:=formatfloat('0.0000',strtofloat(label30.Caption)+
                                       strtofloat(label16.Caption)+
                                      strtofloat(label33.Caption)-
                                      strtofloat(label32.Caption)); //�ۿ�
end;

procedure TForm3.Edit2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if key=13 then edit3.SetFocus;
end;

procedure TForm3.Edit3KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key=13 then edit5.SetFocus;
end;

procedure TForm3.Edit5KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key=13 then ComboBox2.SetFocus;
end;

procedure TForm3.Edit6KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if (key=13) and (maskedit1.Visible) then MaskEdit1.SetFocus
else
 if key=13 then edit9.SetFocus;
end;

procedure TForm3.MaskEdit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key=13 then MaskEdit2.SetFocus;
end;

procedure TForm3.MaskEdit2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key=13 then Edit9.SetFocus;
end;

procedure TForm3.Edit16KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if key=13 then edit18.SetFocus;
end;

procedure TForm3.Edit16Exit(Sender: TObject);
begin
 if trim(edit16.Text)='' then edit16.Text := '0';
  edit2.Text:=inttostr(strtoint(edit16.Text)*form2.set_qty);
 edit3exit(sender);
end;

procedure TForm3.Edit18Exit(Sender: TObject);
begin
 if trim(edit18.Text)='' then edit18.Text := '0';
  edit18.Text :=formatfloat('0.00000000',strtofloat(edit18.Text));
  edit3.Text:=formatfloat('0.00000000',strtofloat(edit18.Text)/form2.set_qty);
 edit3exit(sender);
end;

procedure TForm3.BitBtn2Click(Sender: TObject);
begin
try
form12:=tform12.Create(application);
form12.Aq85.Close;
form12.Aq85.Parameters[1].Value:=trim(form2.Label34.Caption);
form12.Aq85.Open;
if form12.ShowModal=mrok then
 begin
  if (trim(form12.aq85ref_part_no.Value)<>'') and
     (comparetext(trim(form12.aq85ref_part_no.Value),trim(form2.Edit4.Text))<>0) then
  if messagedlg('���۵��б�����������۶����ж���Ĳ�һ�¼���?',mtconfirmation,[mbyes,mbno],0)=mrno then
   begin
    exit;
   end;

  if strtoint(form2.Lab_rkey01.Caption)<>form12.aq85CURR_PTR.Value then
  begin
   messagedlg('���۵��ж���Ļ��������۶����ж���Ļ��Ҳ�һ��!',mterror,[mbcancel],0);
   exit;
  end;

  with dm.ADOQuery5 do
  begin
   close;
   sql.Clear;
   sql.Add('SELECT Data0253.RKEY');
   sql.Add('FROM Data0028 INNER JOIN');
   sql.Add('Data0253 ON Data0028.RKEY = Data0253.d0028_ptr ');
   sql.Add('where Data0028.qte_price - Data0253.d0028_price > 0.01');
   sql.Add('and data0253.quote_ptr='+form12.Aq85RKEY.AsString);
   open;
  end;
  
  if not dm.ADOQuery5.IsEmpty then
    showmessage('���۵��۸��б䶯��������ѡ��������±��ۺ����룡')
  else
  if form12.aq85VATAX.AsString  <> form2.tax then
    showmessage('���۵���ͻ���Ϣ�ж����˰�ʲ�һ�²��ܼ���'+form12.aq85VATAX.AsString+':'+form2.Edit3.text)
  else
  begin
   if ((form12.aq85Quote_type.Value=1) and (not form2.CheckBox1.Checked)) or
      ((form12.aq85Quote_type.Value=0) and (form2.CheckBox1.Checked)) then
    showmessage('���۵���ͻ���Ϣ�ж�����Ƿ�ת�����ݲ�һ�²��ܼ���')
   else
    begin //���ݿͻ���Ϣѡ��۸��Ƿ�˰
     if form2.RadioGroup2.ItemIndex = 0 then  //����˰
      if form12.aq85QTE_UNIT_PTR.Value=1 then //��PCS����
       edit3.Text := form12.aq85quote_price.AsString
      else
       edit3.Text := formatfloat('0.00000000',form12.aq85quote_price.Value/
                                             form12.aq85TUNITS.Value)
     else                                     //�۸�˰
      if form12.aq85QTE_UNIT_PTR.Value=1 then
       edit3.Text := form12.aq85quote_taxprice.AsString
      else
       edit3.Text := formatfloat('0.00000000',form12.aq85quote_taxprice.Value/
                                             form12.Aq85TUNITS.Value);
     edit3exit(sender);
     edit10.Text := form12.Aq85TNUMBER.Value;
     label_qteptr.Caption := form12.Aq85RKEY.AsString;
     form1.get_quotetools(form12.Aq85RKEY.Value,stringgrid1);
    end;
  end;
  flag:= 1;
  ContractInfo.ContractNo:= '';
  //>>���BOM���۹���
  FBp06_ptr := '';
  //<<
 end;
finally
 form12.Free;
end;
end;

procedure TForm3.SpeedButton1Click(Sender: TObject);
begin
edit10.Text:='';
label_qteptr.Caption:='0';
end;

procedure TForm3.Edit9KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key=13 then button1.SetFocus;
end;

procedure TForm3.FormDestroy(Sender: TObject);
begin
if dm.ADOSPprice.Active then dm.ADOSPprice.Close;
if dm.ADOSPpoprice.Active then dm.ADOSPpoprice.Close;
end;

function TForm3.cacl_deficiency(rkey10: integer; nowAmount: currency): currency;
var
  V_defi:currency;
begin
  with dm.ADOQuery5 do
  begin
    close;
    sql.Clear;
    sql.Add('SELECT SUM((INVOICE_TOTAL - amount_paid - CASH_DISC)*EXCHANGE_RATE)');
    sql.Add('AS total_amount FROM dbo.Data0112');
    sql.Add('where customer_ptr='+inttostr(rkey10));
    sql.Add('and invoice_status=1');
    sql.Add('group by customer_ptr');
    open;
    v_defi:= FieldByName('total_amount').AsCurrency;
  end;  //�����û���������Ʊ����Ƿ���

  with dm.ADOQuery5 do
  begin
    close;
    sql.Clear;
    sql.Add('select Sum(t60.PARTS_ALLOC*t64.QUAN_SHIPPED*(1+t60.RUSH_CHARGE*0.01)/t60.EXCH_RATE) as total_amount ');
    sql.Add('from data0060 t60 inner join data0064 t64 on t64.SO_PTR = t60.RKEY ');
    sql.Add('left join data0439 t439 on t64.packing_list_ptr = t439.RKEY ');
    sql.Add('WHERE ((t64.packing_list_ptr is null) OR (t439.invoice_ptr is null)) ');
    sql.Add('and t60.STATUS in (1,2,4) ');
    sql.Add('and t60.CUSTOMER_PTR = '+inttostr(rkey10));
    open;
    v_defi:= v_defi+FieldByName('total_amount').AsCurrency;
  end;  //��ָ��δ�������� Add

  with dm.ADOQuery5 do
  begin
    close;
    sql.Clear;
    sql.Add('select Sum(t60.PARTS_ALLOC*(t60.PARTS_ORDERED-t60.PARTS_SHIPPED)*(1+t60.RUSH_CHARGE*0.01)/t60.EXCH_RATE)');
    sql.Add('as total_amount from data0060 t60');
    //sql.Add('where not exists(select 1 from data0064 t64 where t64.SO_PTR = t60.RKEY)');
    sql.Add('Where t60.STATUS in (1,2,4,6)');
    sql.Add('and t60.CUSTOMER_PTR = '+inttostr(rkey10));
    open;
    v_defi:= v_defi+FieldByName('total_amount').AsCurrency;
  end;  //δָ�� Add

  with dm.ADOQuery5 do
  begin
    close;
    sql.Clear;
    sql.Add('select Sum((TOTAL_ADD_L_PRICE-INVD_ADD_L_PRICE)*(1+RUSH_CHARGE*0.01)/EXCH_RATE)');
    sql.Add('as total_amount from data0060');
    sql.Add('where STATUS in (1,2,4,6)');
    sql.Add('and TOTAL_ADD_L_PRICE <> 0');
    sql.Add('and INVD_ADD_L_PRICE = 0');
    sql.Add('and CUSTOMER_PTR = '+inttostr(rkey10));
    open;
    v_defi:= v_defi+FieldByName('total_amount').AsCurrency;
  end;  //���߷��� Add

  with dm.ADOQuery5 do
  begin
    close;
    sql.Clear;
    sql.Add('SELECT SUM(AVL_AMT * EX_RATE)');
    sql.Add('AS total_amount FROM dbo.Data0116');
    sql.Add('where CUST_PTR='+inttostr(rkey10));
    sql.Add('and memo_status=1');
    sql.Add('group by CUST_PTR');
    open;
    v_defi:= v_defi-FieldByName('total_amount').AsCurrency;
  end;  //�����û������

  with dm.ADOQuery5 do
  begin
    close;
    sql.Clear;
    sql.Add('select Sum(t60.PARTS_ALLOC*t98.QTY_RECD*(1+t60.RUSH_CHARGE*0.01)/t60.EXCH_RATE)');
    sql.Add('as total_amount from data0098 t98, data0060 t60');
    sql.Add('where t98.SO_PTR = t60.RKEY');
    sql.Add('and t98.srce_ptr is null');
    sql.Add('and t98.CUSTOMER_PTR = '+inttostr(rkey10));
    open;
    v_defi:= v_defi-FieldByName('total_amount').AsCurrency;
  end;  //���˻�δ���ɴ���� Add

  result:= v_defi + nowAmount;  //�������ܶ�Add
end;

procedure TForm3.StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
begin
if (gdSelected  in State) then
 begin
  if (ACol = 4) then
   begin
    ComboBox1.Left := Rect.Left;
    ComboBox1.Top := Rect.Top;
    ComboBox1.Width := Rect.Right - Rect.Left+3;
    ComboBox1.Height := Rect.Bottom - Rect.Top;
    ComboBox1.Visible := True;
    combobox1.ItemIndex:=combobox1.Items.IndexOf(StringGrid1.Cells[acol,arow])
   end
  else
    ComboBox1.Visible :=false;
 end;
end;

procedure TForm3.ComboBox1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key=13 then stringgrid1.SetFocus;
end;

procedure TForm3.ComboBox1Change(Sender: TObject);
begin
 stringgrid1.Cells[4,stringgrid1.Row]:=combobox1.Text;
end;

procedure TForm3.MaskEdit3KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key=13 then MaskEdit1.SetFocus;
end;

procedure TForm3.MaskEdit3Exit(Sender: TObject);
begin
try
{ if strtodate(maskedit3.Text) < getsystem_date(DM.ADOQuery5,1)+form2.shelf_life then
  IF  messagedlg('ԭʼ�ͻ�����Ҫ���ڲ�Ʒ��������֮ǰ,���ܵ��²��ܰ�ʱ����,������?',
      mtConfirmation,[mbyes,mbcancel],0)=mrcancel then
   maskedit3.SetFocus;
}
 strtodate(maskedit3.Text);
except
 messagedlg('ԭʼ�ͻ����������ʽ����,����ϸ���!',mtwarning,[mbok],0);
 maskedit3.SetFocus;
end;
end;

procedure TForm3.btnFindContractClick(Sender: TObject);
var
  i: Byte;
begin
  Application.CreateForm(TfrmFindContract, frmFindContract);
  try
    with dm.aqFindContract do
    begin
      Close;
      Parameters.Items[0].Value:= form2.Edit4.Text;
      Open;
    end;
    if frmFindContract.ShowModal = mrok then
    begin
      //>>���BOM���۹���
      FBp06_ptr := '';
      //<<
     //��տ��ٱ��۹���
     label_qteptr.Caption := '0';
     //<<
      with ContractInfo do
      begin
        ContractNo:= dm.aqFindContract.FieldValues['ContractNo'];
        Qnty:= dm.aqFindContract.FieldValues['Qnty'];
        EngAmount:= dm.aqFindContract.FieldValues['EngAmount'];
        TestAmount:= dm.aqFindContract.FieldValues['TestAmount'];
        AftDiscountAmount:= dm.aqFindContract.FieldValues['AftDiscountAmount'];
      end;
      Edit2.Text:= IntToStr(ContractInfo.Qnty);
      if form2.RadioGroup2.ItemIndex = 0 then  //����˰
        Edit3.Text:= formatfloat('0.00000000',
                    ((ContractInfo.AftDiscountAmount-ContractInfo.EngAmount-ContractInfo.TestAmount)
                    /(1+StrToFloat(form2.Edit2.text)*0.01))/ContractInfo.Qnty)
      else                                     //��˰
        Edit3.Text:= formatfloat('0.00000000',
                    (ContractInfo.AftDiscountAmount-ContractInfo.EngAmount-ContractInfo.TestAmount)
                    /ContractInfo.Qnty);

      for i:= 0 to stringgrid1.RowCount-1 do
      begin
        if stringgrid1.Cells[0,i]= '���̷�' then stringgrid1.Cells[1,i]:= formatfloat('0.0000',ContractInfo.EngAmount/(1+StrToFloat(form2.Edit2.text)*0.01));
        if stringgrid1.Cells[0,i]= '���Լܷ�' then stringgrid1.Cells[1,i]:= formatfloat('0.0000',ContractInfo.TestAmount/(1+StrToFloat(form2.Edit2.text)*0.01));
      end;
      flag:= 2;
      edit3exit(sender);
      TabSheet2Exit(sender);
    end;

  finally
    frmFindContract.Free;
  end;
end;

procedure TForm3.FormShow(Sender: TObject);
begin
  if form2.credit_rating = 3 then
    Label43.Caption:= '��'
  else if form2.credit_rating = 1 then
    Label43.Caption:= '��'
  else
    Label43.Caption:= '��';
  Label44.Caption:= formatfloat('0.0000',form2.credit_limit);
  Label45.Caption:= formatfloat('0.0000',cacl_deficiency(strtoint(form2.lab_rkey10.Caption),0));
//20161114tang�޸����ȴ�283ȡ
  dm.qrytmp.Close;
  dm.qrytmp.SQL.Text:='select * from data0283';
  dm.qrytmp.Open;
  ComboBox2.Items.Clear;
  if not DM.qrytmp.IsEmpty then
  begin
    while not dm.qrytmp.Eof do
    begin
      ComboBox2.Items.AddObject(dm.qrytmp.fieldBYName('PRIORITY_name').AsString,Pointer(dm.qrytmp.fieldBYName('PRIORITY_CODE').AsInteger));
      dm.qrytmp.Next;
    end;
  end;
  ComboBox2.ItemIndex:=ComboBox2.Items.IndexOf(dm.qrytmp.fieldBYName('PRIORITY_name').AsString);
  ComboBox2.ItemIndex:=0;
end;

function TForm3.return_vifrkey(sgrid: tstringgrid;
  col: integer): string;
var
 i:integer;
 rkey_list:string;
begin
 result:='';
if sgrid.RowCount > 2 then
 begin
   rkey_list:='(';
   for i:=1 to sgrid.RowCount-2 do
     rkey_list:=rkey_list+ sgrid.Cols[col].Strings[i]+',';
   if length(rkey_list) > 1 then
    result:= copy(rkey_list,1,length(rkey_list)-1)+')'
   else
    result:='';
 end;
end;


procedure TForm3.btn1Click(Sender: TObject);
var
  LInput: PDlgInput;
  LFrm: TfrmPick_Item_Single;
begin
  LInput.Sqlstr :=' SELECT BP06.d01_ptr,BP06.IDKEY,BP06.BPNO,BP06.BPTime,BP06.buhanshuijiage_Pcs,BP06.hanshuijiage_Pcs,d10.CUST_CODE,' +
          ' d25.MANU_PART_NUMBER,d25.MANU_PART_DESC,bp00.bpname,d01.CURR_NAME,d05_1.EMPLOYEE_NAME as SMan,d05_2.EMPLOYEE_NAME as CMan FROM BOMPrice06 BP06 ' +
          ' LEFT JOIN data0010 d10 ON d10.RKEY = BP06.d10_Ptr ' +
          ' LEFT JOIN data0025 d25 ON d25.RKEY = BP06.D25_Ptr ' +
          ' left JOIN bomprice00 bp00 ON bp00.idkey = BP06.bp00_ptr ' +
          ' left JOIN data0001 d01 ON d01.RKEY = BP06.D01_Ptr ' +
          ' left JOIN data0005 d05_1 on d05_1.RKEY = BP06.SaleMan ' +
          ' left JOIN data0005 d05_2 on d05_2.Rkey = BP06.CreateMan ' +
          ' where BP06.AuthStatus = 3 AND dateadd(day,BP06.EnableDays,BP06.BPTime) > getdate() ';

  if Trim(form2.label34.Caption) = '' then
    LInput.Sqlstr := LInput.Sqlstr + ' and d25.manu_part_number = ' + QuotedStr(form2.Edit4.Text)
  else
    LInput.Sqlstr := LInput.Sqlstr + ' and d25.MANU_PART_DESC = ' + QuotedStr(form2.label34.Caption);
  LInput.Sqlstr := LInput.Sqlstr + ' order by BPTime Desc';

  LInput.AdoConn := dm.ADOConnection1;
  LInput.Fields := 'BPNO/���۵�/90,BPTime/��������/120,MANU_PART_NUMBER/�������/100,MANU_PART_DESC/�ͻ��ͺ�/100,buhanshuijiage_Pcs/����˰��/80,hanshuijiage_Pcs/��˰��/80';
  LFrm := TfrmPick_Item_Single.Create(Self);
  try
    LFrm.adsPick1.EnableBCD := False;
    LFrm.InitForm_New(LInput);
    if LFrm.ShowModal = mrok then
    begin
      if strtoint(form2.Lab_rkey01.Caption)<>LFrm.adsPick1.FieldByName('d01_ptr').AsInteger then
      begin
       messagedlg('���۵��ж���Ļ��������۶����ж���Ļ��Ҳ�һ��!',mterror,[mbcancel],0);
       exit;
      end;

      if form2.RadioGroup2.ItemIndex = 0 then  //����˰
        Edit3.Text := LFrm.adsPick1.fieldbyname('buhanshuijiage_Pcs').AsString
      else                                     //��˰
        Edit3.Text := LFrm.adsPick1.fieldbyname('hanshuijiage_Pcs').AsString;
      FBp06_ptr := LFrm.adsPick1.fieldbyname('idkey').AsString;
      FBomBuHanShuiJiaGe := LFrm.adsPick1.fieldbyname('buhanshuijiage_Pcs').AsString;
     //>>���rfq����
     ZeroMemory(@ContractInfo,SizeOf(ContractInfo));
     Form2.Edit7.Text:= '';

     //��տ��ٱ��۹���
     label_qteptr.Caption := '0';
     //<<
     flag := 3;       //bom����

     Edit3Exit(Edit3);
     TabSheet2Exit(sender);

    end;

  finally
    LFrm.Free;
  end;
end;

end.
