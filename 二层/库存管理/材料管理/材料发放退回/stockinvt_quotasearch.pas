unit stockinvt_quotasearch;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Grids, DBGrids, ExtCtrls, StdCtrls,DB;

type
  TForm7 = class(TForm)
    Panel1: TPanel;
    DBGrid1: TDBGrid;
    Button1: TButton;
    Button2: TButton;
    Label2: TLabel;
    ComboBox1: TComboBox;
    procedure Button1Click(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
  private
    { Private declarations }
      whouse_ptr:Tstringlist; 
  public
    { Public declarations }
    v_type:byte;
  end;

var
  Form7: TForm7;

implementation

uses damo, main, purout_invt, putoutinvt_quota, putoutinvt_linliao, common;

{$R *.dfm}

procedure TForm7.Button1Click(Sender: TObject);
begin
  with DM.TempDataSet do
  begin
    Close;
    Clone(DM.aq22);                                         //�Ե�ǰ��aq22�����ݽ��п�¡����
    Filter:=DM.aq22.Filter; {�ر�˵�������ݼ���¡��ʱ�򣬰�ԭ���ݼ����˵�����Ҳ���ƹ����ˣ�������ԭ���Ĺ��������ڽ���һ�ι���}
    Filtered:=True;

    First;
    while not Eof do
    begin            //   ����ڸ��Ƶ�����������Ч��С�� aq22�ļ�¼ ��������ʾ
      if (FieldByName('EXPIRE_DATE').AsDateTime<DM.aq22.FieldByName('EXPIRE_DATE').AsDateTime) and  (FieldByName('EXPIRE_DATE').AsDateTime>0)
       and  (FieldByName('quan_on_hand').asfloat>0)  then
      begin
        if messagedlg('���бȵ�ǰ��Ч�ڸ���Ŀ���¼����ȷ��Ҫ������?',mtconfirmation,[mbyes,mbno],1)=mrNO then
        begin
          Exit;
        end
        else
          Break;
//          ShowMessage('���бȵ�ǰ��Ч�ڸ���Ŀ���¼, ��Ҫ�Ƚ��ȳ���');
//          exit;

      end;



//      if FieldByName('�Ƿ�ɷ���').AsString='��'  then
//      begin
//       ShowMessage('������δ�������鲻�ϸ��ܷ���!');
//      exit;
//      end;


      Next;
    end;
    Close;
  end;

  if dm.aq22.IsEmpty  then  exit;
  
   if ((dm.aq22EXPIRE_DATE.Value < common.getsystem_date(dm.ADOQuery1,1) )  and  (dm.aq22EXPIRE_DATE.AsDateTime>0) ) then
    if messagedlg('�Բ���,���������ѹ���Ч�ڣ���ȷ��Ҫ������?',mtconfirmation,[mbyes,mbno],1)=mrNO then
    Exit ;


      if dm.aq22.FieldByName('�Ƿ�ɷ���').AsString='��'  then
      begin
       ShowMessage('������δ�������鲻�ϸ��ܷ���!');
      exit;
      end;

    form_putout:=tform_putout.Create(application);
    with form_putout do
    begin
      tag:=1;
      edit1.Text:=dm.aq22quan_hand.AsString;
      edit2.Text:=dm.aq22UNIT_NAME.Value;
      checkbox1.Visible:=true;
      label4.Visible:=true;
      edit4.Visible:=true;
      label5.Visible:=True;
      edit5.Visible:=True;
      if self.v_type=0 then  //����
      begin
        edit4.Text:=dm.ads468QUAN_BOM.AsString;
        edit5.Text:=dm.ads468QUAN_ISSUED.AsString;
        if dm.ads468QUAN_BOM.Value-dm.ads468QUAN_ISSUED.Value>0 then
          if dm.ads468QUAN_BOM.Value-dm.ads468QUAN_ISSUED.Value<
          dm.aq22quan_hand.Value then
            edit3.Text:=formatfloat
               ('0.00',dm.ads468QUAN_BOM.value-dm.ads468QUAN_ISSUED.Value)
          else
          edit3.Text:=dm.aq22quan_hand.AsString
        else
        edit3.Text:='0';
      end
      else             //�����ϵ���
      begin
        edit4.Text:=dm.ads468_268QUAN_BOM.AsString;
        edit5.Text:=dm.ads468_268QUAN_ISSUED.AsString;
        if dm.ads468_268QUAN_BOM.Value-dm.ads468_268QUAN_ISSUED.Value>0 then
        if dm.ads468_268QUAN_BOM.Value-dm.ads468_268QUAN_ISSUED.Value<
          dm.aq22quan_hand.Value then
          edit3.Text:=formatfloat
             ('0.00',dm.ads468_268QUAN_BOM.value-dm.ads468_268QUAN_ISSUED.Value)
        else
        edit3.Text:=dm.aq22quan_hand.AsString
        else
        edit3.Text:='0';
      end;
    end;

    if form_putout.ShowModal=mrok then
    begin
      if self.v_type=0 then   //����
      with form6 do
      begin
        sgrid1.Cells[0,sgrid1.RowCount-1]:=dm.aq22INV_PART_NUMBER.Value;
        sgrid1.Cells[1,sgrid1.RowCount-1]:=dm.aq22INV_NAME.Value;
        sgrid1.Cells[2,sgrid1.RowCount-1]:=dm.aq22INV_DESCRIPTION.Value;
        sgrid1.Cells[3,sgrid1.RowCount-1]:=dm.aq22rohs.Value;
        sgrid1.Cells[4,sgrid1.RowCount-1]:=dm.aq22unit_name.Value;
        sgrid1.Cells[5,sgrid1.RowCount-1]:=form_putout.Edit3.Text;
        sgrid1.Cells[6,sgrid1.RowCount-1]:=dm.aq22ABBR_NAME.Value;
        sgrid1.Cells[7,sgrid1.RowCount-1]:=dm.aq22SUPPLIER2.Value;
        sgrid1.Cells[8,sgrid1.RowCount-1]:=dm.ads468cut_no.Value;

        sgrid2.Cells[0,sgrid2.RowCount-1]:=dm.aq22INVENTORY_PTR.AsString;
        sgrid2.Cells[1,sgrid2.RowCount-1]:=dm.aq22RKEY.AsString;
        sgrid2.Cells[2,sgrid2.RowCount-1]:=dm.aq22STD_COST.AsString;
        sgrid2.Cells[3,sgrid2.RowCount-1]:=dm.ads468RKEY.AsString;
        sgrid1.RowCount:=sgrid1.RowCount+1;
        sgrid2.RowCount:=sgrid2.RowCount+1;
        dm.aq22.Edit;
        dm.aq22QUAN_ON_HAND.Value:=dm.aq22QUAN_ON_HAND.Value-
                                  strtocurr(form_putout.edit3.Text);
        dm.aq22.Post;

        dm.ads468.Edit;
        dm.ads468QUAN_ISSUED.Value:=dm.ads468QUAN_ISSUED.Value+
                                strtocurr(form_putout.edit3.Text);

        if (form_putout.CheckBox1.Checked) or
          (dm.ads468QUAN_ISSUED.Value>=dm.ads468QUAN_BOM.Value) then
        dm.ads468STATUS.Value:=1;      //468�������״̬
        dm.ads468.Post;
      end
      else
      with form8 do
      begin
        sgrid1.Cells[0,sgrid1.RowCount-1]:=dm.aq22INV_PART_NUMBER.Value;
        sgrid1.Cells[1,sgrid1.RowCount-1]:=dm.aq22INV_NAME.Value;
        sgrid1.Cells[2,sgrid1.RowCount-1]:=dm.aq22INV_DESCRIPTION.Value;
        sgrid1.Cells[3,sgrid1.RowCount-1]:=dm.aq22rohs.Value;
        sgrid1.Cells[4,sgrid1.RowCount-1]:=dm.aq22unit_name.Value;
        sgrid1.Cells[5,sgrid1.RowCount-1]:=form_putout.Edit3.Text;
        sgrid1.Cells[6,sgrid1.RowCount-1]:=dm.aq22ABBR_NAME.Value;
        sgrid1.Cells[7,sgrid1.RowCount-1]:=dm.aq22SUPPLIER2.Value;

        sgrid2.Cells[0,sgrid2.RowCount-1]:=dm.aq22INVENTORY_PTR.AsString;
        sgrid2.Cells[1,sgrid2.RowCount-1]:=dm.aq22RKEY.AsString;
        sgrid2.Cells[2,sgrid2.RowCount-1]:=dm.aq22STD_COST.AsString;
        sgrid2.Cells[3,sgrid2.RowCount-1]:=dm.ads468_268RKEY.AsString;
        sgrid1.RowCount:=sgrid1.RowCount+1;
        sgrid2.RowCount:=sgrid2.RowCount+1;
        dm.aq22.Edit;
        dm.aq22QUAN_ON_HAND.Value:=dm.aq22QUAN_ON_HAND.Value-
                                  strtocurr(form_putout.edit3.Text);
        dm.aq22.Post;

        dm.ads468_268.Edit;
        dm.ads468_268QUAN_ISSUED.Value:=dm.ads468_268QUAN_ISSUED.Value+
                                strtocurr(form_putout.edit3.Text);

        if (form_putout.CheckBox1.Checked) or
          (dm.ads468_268QUAN_ISSUED.Value>=dm.ads468_268QUAN_BOM.Value) then
        dm.ads468_268STATUS.Value:=1;      //468�������״̬
        dm.ads468_268.Post;
      end;

      self.ModalResult:=mrok;
     end;
    form_putout.free;


 // else
//  messagedlg('�Բ������������Ч���ѹ�,�뷢�ϵ����ϼ�������ȷ����Ч��!!!',
//  mterror,[mbcancel],0);

end;

procedure TForm7.DBGrid1DblClick(Sender: TObject);
begin
if not dm.aq22.IsEmpty then
 button1.OnClick(sender);
end;

procedure TForm7.FormCreate(Sender: TObject);
begin
 whouse_ptr:=tstringlist.Create;
 combobox1.OnChange:=nil;

 with dm.ADOQuery1 do
  begin
   close;
   sql.Text:='select rkey,ABBR_NAME from data0015 order by rkey';
   open;
   while not eof do
    begin
     combobox1.Items.Add(fieldbyname('ABBR_NAME').AsString);
     whouse_ptr.Add(fieldbyname('rkey').AsString);
     next;
    end;
  end;
 combobox1.OnChange:= ComboBox1Change;
end;

procedure TForm7.ComboBox1Change(Sender: TObject);
begin
  if v_type=1 then
    dm.aq22.Filter:='warehouse_ptr='+whouse_ptr.Strings[combobox1.itemindex]
    +' and INVENTORY_PTR = '+dm.ads468_268INVENT_PTR.AsString
  else
  begin
   if dm.ads468supplier_ptr.asstring<>''  then
  dm.aq22.Filter:='warehouse_ptr='+whouse_ptr.Strings[combobox1.itemindex]
  +' and SUPP_PTR='+dm.ads468supplier_ptr.asstring
  +' and INVENTORY_PTR = '+dm.ads468invent_ptr.AsString
  else
    dm.aq22.Filter:='warehouse_ptr='+whouse_ptr.Strings[combobox1.itemindex]
  +' and INVENTORY_PTR = '+dm.ads468invent_ptr.AsString


  end;
end;

procedure TForm7.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if (chr(key)='V') and (ssalt in shift) then
  showmessage(dm.aq22.CommandText);
end;

end.
