unit edit_add_po;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, StdCtrls, Buttons, Grids, DBGrids, Mask,
  DBCtrls, Menus, DB, ADODB;

type
  TForm4 = class(TForm)
    Panel1: TPanel;
    TC1: TTabControl;
    StatusBar1: TStatusBar;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    Button2: TButton;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    DBText1: TDBText;
    Bevel1: TBevel;
    Label16: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label21: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    DBGrid1: TDBGrid;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    BitBtn8: TBitBtn;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    DBComboBox1: TDBComboBox;
    DBEdit7: TDBEdit;
    DBEdit8: TDBEdit;
    DBEdit9: TDBEdit;
    DBEdit10: TDBEdit;
    DBCheckBox1: TDBCheckBox;
    DBEdit11: TDBEdit;
    DBEdit12: TDBEdit;
    DBEdit15: TDBEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    BitBtn9: TBitBtn;
    BitBtn10: TBitBtn;
    BitBtn11: TBitBtn;
    Edit4: TEdit;
    DBEdit16: TDBEdit;
    DBEdit17: TDBEdit;
    Label25: TLabel;
    Label26: TLabel;
    DBEdit18: TDBEdit;
    PopupMenu2: TPopupMenu;
    N4: TMenuItem;
    N5: TMenuItem;
    DBGrid2: TDBGrid;
    PopupMenu3: TPopupMenu;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    DBEdit13: TDBEdit;
    Label17: TLabel;
    Edit7: TEdit;
    DBRadioGroup1: TDBRadioGroup;
    Label20: TLabel;
    Label22: TLabel;
    Label27: TLabel;
    DBEdit14: TDBEdit;
    DBEdit19: TDBEdit;
    DBEdit20: TDBEdit;
    DBEdit21: TDBEdit;
    Label29: TLabel;
    BitBtn6: TBitBtn;
    ComboBox1: TComboBox;
    Label28: TLabel;
    DBCheckBox2: TDBCheckBox;
    DBRadioGroup2: TDBRadioGroup;
    Label30: TLabel;
    dbchk_CP: TDBCheckBox;
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn9Click(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure DBCheckBox1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure BitBtn10Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn11Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);

    procedure change_seed_value(po_number:string);
    procedure change_tax_total();
    procedure change_sim_tax_total();
    procedure change72_sim_tax_total();
    procedure change_data0070(rkey70:integer);
    procedure change_data0071(rkey70:integer);
    procedure change_data0072(rkey70:integer);
    procedure add_misc_visible();
    procedure update_data0028();
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    function find_supplier(supplier_name:string;curr_ptr:integer):boolean;
    function find_po_error():boolean;
    function find_pr_number():boolean;
    function invtory_type(invt_ptr:string):string;
    procedure save_cate_note(adoquery:TADOQuery;source_type:integer;var_caption:string);
    procedure TC1Change(Sender: TObject);
    procedure DBEdit9KeyPress(Sender: TObject; var Key: Char);
    procedure DBEdit9KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBEdit9Click(Sender: TObject);
    procedure DBEdit9Exit(Sender: TObject);
    procedure PopupMenu2Popup(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure PopupMenu3Popup(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure DBEdit11Click(Sender: TObject);
    procedure DBEdit11Exit(Sender: TObject);
    procedure DBEdit13Click(Sender: TObject);
    procedure DBEdit12Exit(Sender: TObject);
    procedure DBEdit12Click(Sender: TObject);
    procedure DBEdit15Exit(Sender: TObject);
    procedure DBEdit15Click(Sender: TObject);
    procedure BitBtn2Enter(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure DBGrid2DblClick(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure DBEdit16Exit(Sender: TObject);
    procedure TC1Changing(Sender: TObject; var AllowChange: Boolean);
    procedure BitBtn6Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure DBCheckBox2Click(Sender: TObject);
    procedure DBEdit1KeyPress(Sender: TObject; var Key: Char);
    procedure DBEdit1Exit(Sender: TObject);
    procedure dbchk_CPClick(Sender: TObject);
  private
    { Private declarations }
   v_close:byte;
   procedure get_approve_type(rkey15:Integer);
   procedure update_69_204(rkey:integer;v_type:Byte);
   procedure update_69_68(rkey70:Integer);
   procedure update_69_68_post(rkey70: Integer);
   procedure update_204_68(rkey70: Integer);
   procedure update_204_68_post(rkey70: Integer);
   procedure po_value();
   procedure add_0070(); //�ֹ�ֱ������
   procedure add_0071();
   procedure add_0072();
   procedure append_0070();
   procedure append_0071();  //��PR��������
   procedure append_0072();

   procedure appendprlist_0070();
  public
    { Public declarations }
   po_type:char;      //�ֹ������Ĳɹ���������
   v_new_type:byte;   //����ð�������0,1,9,10
  end;

var
  Form4: TForm4;
  function Power(x, y : extended) : extended;
implementation
uses damo, shipmeoth_search, ssadd_search, supplier, edit_misc,
  state_tax, edit_std_inv, add_po, main, supp_search, account_search,
  edit_misc_po, note, annotation, PR_search, dpment_search,common;
{$R *.dfm}

procedure TForm4.BitBtn5Click(Sender: TObject);
var
 v_message:byte;
begin
if tc1.Tabs.Count>0 then
 begin
  v_message:=messagedlg('�Ƿ�����ݴ���?',mtConfirmation,[mbyes,mbno,mbcancel],0);
  if v_message=7 then   //NO ����
   begin
    IF v_new_type<>10 THEN dm.AQ0015.CancelBatch();
     dm.ADO70.CancelBatch();
     dm.ADO7011.CancelBatch();
     dm.ADO107011.CancelBatch();
     dm.ADO200.CancelBatch();
     dm.ADO0450.CancelBatch();
    if dbgrid1.Visible=true then
     dm.ADO71.CancelBatch()
    else
     dm.ADO72.CancelBatch();
    v_close:=1; //�����˳�
    close;
   end
  else
   if v_message=6 then     //yes���޸ĵļ�¼����
    begin
     bitbtn2.SetFocus;
     bitbtn2click(sender);
    end
   else                    //cancel������Ҳ������
    exit;
 end
else
 begin
  v_close:=1; //�����˳�
  close;
 end;
end;

procedure TForm4.BitBtn9Click(Sender: TObject);
begin
 try
  form_shipmethod:=tform_shipmethod.Create(application);
 if form_shipmethod.ShowModal=mrok then
  begin
   dbedit4.Field.Value:=form_shipmethod.ADOQuery1.Fieldbyname('description').AsString;
   dbcheckbox1.SetFocus;
  end
 else
  dbedit4.SetFocus;
 finally
  form_shipmethod.free;
 end;
end;

procedure TForm4.BitBtn8Click(Sender: TObject);
begin
 try
  form_address:=tform_address.Create(application);
  form_address.ADOQuery1.Close;
  form_address.ADOQuery1.Parameters[1].Value := dm.ADO70SUPPLIER_POINTER.Value;
  form_address.ADOQuery1.Open;
  if form_address.ShowModal=mrok then
   begin
    dm.ADO70SUPP_FAC_ADD_PTR.Value := form_address.ADOQuery1.FieldValues['rkey'];
    dm.ADO70FEDERAL_TAX.Value := form_address.ADOQuery1.FieldValues['state_tax'];
    dm.ADO70STATE_SHIP_TAX_FLAG.Value := form_address.ADOQuery1.FieldValues['STATE_SHIP_TAX_FLAG'];
    dm.ADO70STATE_MISC_TAX_FLAG.Value := form_address.ADOQuery1.FieldValues['STATE_MISC_TAX_FLAG'];
    dbedit2.SetFocus;
   end
  else
   dbedit17.SetFocus;
 finally
  form_address.free;
 end;
end;



procedure TForm4.FormShow(Sender: TObject);
var
 i:byte;
 v_total,v_tax:real;
begin
  with dm.ADO200 do    //����PO���������
   begin
    active:=false;
    Parameters[0].Value := dm.ADO70rkey.Value;
    active:=true;
   end;
  with dm.ado7011 do      //�������±�
   begin
    active:=false;
    Parameters[0].Value := dm.ADO70rkey.Value;
    active:=true;
   end;
  with dm.ado107011 do       //�������±�
   begin
    active:=false;
    Parameters[0].Value := dm.ADO70rkey.Value;
    active:=true;
   end;
  with dm.ado0450 do       //ע��
   begin
    active:=false;
    Parameters[0].Value := dm.ADO70rkey.Value;
    active:=true;
   end;
if v_new_type = 10 then //�༭
 begin      //��ʼ..1
  with dm.ADOQuery1 do
   begin
    active:=false;
    sql.Clear;
    sql.Add('select data0023.code,');
    sql.Add('CONTACT_NAME_1,CONTACT_NAME_2,CONTACT_NAME_3,');
    sql.Add('CONTACT_NAME_4,CONTACT_NAME_5,CONTACT_NAME_6');
    sql.Add('from data0070,data0023');
    sql.Add('where data0070.supplier_pointer=data0023.rkey and');
    sql.Add('data0070.rkey='+dm.ADO70RKEY.AsString);
    active:=true;
    tc1.Tabs.Add(fieldvalues['code']);             //���ҹ�Ӧ��
    for i:=1 to 6 do     //�ͻ�������
     dbcombobox1.Items.Add(fieldbyname('contact_name_'+inttostr(i)).asstring);
   end;

  self.get_approve_type(DM.ADO70WAREHOUSE_POINTER.Value);
  ComboBox1.ItemIndex := ComboBox1.Items.IndexOf(DM.ADO70PURCHASE_TYPE.Value);

  edit7.Text:=dm.AQ0070warehouse_name.Value;

  if (dm.ADO70PO_TYPE.Value = 'S')  then  //��ȡ��׼�ɹ�
   with dm.ADO71 do
   begin
    active:=false;
    sql.Clear;
    sql.Add('SELECT * FROM data0071');
    sql.Add('where po_ptr='+dm.ADO70RKEY.AsString);
    active:=true;
    if dm.ADO71.Filter <> '' then dm.ADO71.Filter := '';
    v_total := 0;
    v_tax := 0;
    while not eof do
     begin
      v_total := v_total+dm.ADO71taxprice_total.Value;
      v_tax := v_tax+dm.ADO71tax_total.Value;
      next;
     end;
    edit2.Text := formatfloat('0.00',v_total);
    edit3.Text := formatfloat('0.00',v_tax);
    first;
    dm.AQ71.Close;
    dm.AQ71.Parameters[1].Value:=dm.ADO70RKEY.Value;
    dm.AQ71.Open;
    DBRadioGroup2.Enabled:=DBCheckBox2.Checked;
   end
  else
  with dm.ADO72 do   //��ȡ����ɹ�
   begin
    active:=false;
    sql.Clear;
    sql.Add('SELECT * FROM data0072');
    sql.Add('where poptr='+dm.ADO70RKEY.AsString);
    active:=true;
    if dm.ADO72.Filter <> '' then dm.ADO72.Filter := '';
    v_total:=0;
    v_tax:=0;
    while not eof do
     begin
      v_total:=v_total+dm.ADO72taxprice_total.Value;
      v_tax:=v_tax+dm.ADO72tax_total.Value;
      next;
     end;
    edit2.Text := formatfloat('0.00',v_total);
    edit3.Text := formatfloat('0.00',v_tax);
    first;
    dm.AQ72.Close;
    dm.AQ72.Parameters[1].Value:=dm.ADO70RKEY.Value;
    dm.AQ72.Open;
    dbgrid1.Visible:=false;
    dbgrid2.Visible:=true;
    self.DBCheckBox2.Visible:=false; //����ɹ���VMI�ɹ�
    DBRadioGroup2.Visible:=false; //����ɹ�VMI�۸�ȡ����
   end;                  //�������Ϊ��׼���Ҳ��ܱ༭����
   if dm.ADO70CURRENCY_PTR.Value =1 then
    begin
     dbedit5.ReadOnly:=true;
     dbedit5.Color := cl3dlight;
    end;
   change_tax_total;    //�ı���������������˰��ϼ�
   if dm.ADO70PURCHASE_ORDER_TYPE.Value = 1 then
    begin
     dbedit1.Color := clwindow;  //�ֹ�����ʱ���������빺����
     dbedit1.ReadOnly := false;
     dbedit3.Color := clwindow;  //�ֹ�����ʱ���������빺���
     dbedit3.ReadOnly := false;
     bitbtn6.Enabled := true;
    end;
 end;     //�༭����..1

end;

procedure TForm4.DBCheckBox1Click(Sender: TObject);
begin
 if dbcheckbox1.Checked then
  begin
   dbedit11.Enabled := false;
   dbedit12.Enabled := false;
   dbedit15.Enabled := false;
  end
 else
  begin
   dbedit11.Enabled := true;
   dbedit12.Enabled := true;
   dbedit15.Enabled := true;
  end;
end;

procedure TForm4.Button2Click(Sender: TObject);
begin
 try
  form6:=tform6.Create(application);//��ʾ��Ӧ����Ϣ
  form6.Caption := '��Ӧ������:'+tc1.Tabs[tc1.tabindex];
  form6.ShowModal;
 finally
  form6.free;
 end;
end;

procedure TForm4.BitBtn10Click(Sender: TObject);
var
 i:byte;
 search_option:tlocateoptions;
 mic_total:real;
 locatesuccess:boolean;
begin
 try
  search_option := [lopartialkey];
  form7:=tform7.Create(application);
  if v_new_type<>10 then         //����PO
   dm.ADO200.Filter := 'poptr= '+inttostr(dm.ADO70.RecNo);
  dm.ADO200.First;
  while not dm.ADO200.Eof do   //�����������
   begin
    for i:=1 to form7.StringGrid1.RowCount-2 do
     if trim(form7.StringGrid1.Cells[4,i])=trim(dm.ADO200.fieldbyname('MISC_CHARGE_PTR').asstring) then
      begin
       form7.StringGrid1.Cells[3,i]:=formatfloat('0.00',dm.ADO200.FieldValues['amount']);
       break;
      end;
      dm.Ado200.Next;
   end;

  dm.ADO200.First;
  if form7.ShowModal=mrok then
   begin
    mic_total:=0;
     for i:=1 to form7.StringGrid1.RowCount-2 do
      begin
       if v_new_type<>10 then //����
        locatesuccess:=dm.ado200.Locate('misc_charge_ptr;poptr',vararrayof([strtoint(form7.StringGrid1.Cells[4,i]),dm.ADO70.recno]),search_option)
       else                   //�༭
        locatesuccess:=dm.ado200.Locate('misc_charge_ptr;poptr',vararrayof([strtoint(form7.StringGrid1.Cells[4,i]),dm.ADO70RKEY.value]),search_option);
       if locatesuccess then
        begin               //���ԭ���м�¼
         if strtofloat(form7.StringGrid1.Cells[3,i])>0 then
         begin
          dm.ADO200.Edit;
          dm.ADO200.FieldByName('amount').AsString := form7.StringGrid1.Cells[3,i];
          dm.ado200.post;
         end
         else
          dm.ADO200.Delete;
        end
       else //û���ҵ�
        if strtofloat(form7.StringGrid1.Cells[3,i])>0 then
        begin
         dm.ADO200.Append;
         dm.ADO200.FieldByName('amount').AsString := form7.StringGrid1.Cells[3,i];
         if v_new_type=10 then
          dm.ADO200.Fieldvalues['poptr'] := dm.ADO70RKEY.Value
         else
          dm.ADO200.Fieldvalues['poptr'] := dm.ADO70.RecNo;
         dm.ADO200.FieldByName('misc_charge_ptr').AsString := form7.StringGrid1.Cells[4,i];
         dm.ADO200.Post;
        end;
        mic_total:=mic_total+strtofloat(form7.StringGrid1.Cells[3,i]);
      end;
    dbedit10.Field.Value := mic_total; //�޸���������Ӷ�
    self.change_tax_total;
   end;
 finally
  form7.free;
 end;
end;

procedure TForm4.update_69_204(rkey: integer; v_type: Byte);
begin
 with dm.ADOQuery2 do
 begin
   close;
   if v_type=0 then   //0���±��������빺�������·Ǳ��������빺
    sql.Text:='update data0069 set status=1 where rkey='+inttostr(rkey)
   else
    sql.Text:='update data0204 set status=1 where rkey='+inttostr(rkey);
   ExecSQL;
 end;
end;

procedure TForm4.update_69_68(rkey70: Integer);
begin

 with dm.ADOQuery2 do
 begin
   close;
   sql.Text:='update data0069 set status=0 '+
   'from data0069 inner join data0071 on '+
   'data0069.rkey=data0071.rkey69 '+
   'where data0071.po_ptr='+inttostr(rkey70);
   ExecSQL;
 end;

 with dm.ADOQuery2 do
 begin
   close;
   sql.Text:='update data0068 set status=2 '+
   'where EXISTS(select data0069.PURCH_REQ_PTR '+
   'from data0069 inner join data0071 on '+
   'data0069.rkey=data0071.rkey69 '+
   'where data0071.po_ptr='+inttostr(rkey70)+
   'and data0069.PURCH_REQ_PTR=data0068.rkey '+
   'group by data0069.PURCH_REQ_PTR)';
   ExecSQL;
 end;

end;


procedure TForm4.update_69_68_post(rkey70: Integer);
begin

 with dm.ADOQuery2 do
 begin
   close;
   sql.Text:='update data0069 set status=1 '+
   'from data0069 inner join data0071 on '+
   'data0069.rkey=data0071.rkey69 '+
   'where data0071.po_ptr='+inttostr(rkey70);
   ExecSQL;
 end;

 with dm.ADOQuery2 do
  begin
   close;
   sql.Text:=
   'update data0068 set status=6'+#13+
   'where EXISTS(SELECT dbo.Data0069.PURCH_REQ_PTR'+#13+
       'FROM  dbo.Data0071 INNER JOIN'+#13+
       ' dbo.Data0069 ON dbo.Data0071.rkey69 = dbo.Data0069.RKEY'+#13+
       'where (data0071.po_ptr='+inttostr(rkey70)+')'+#13+
       'and (data0069.PURCH_REQ_PTR=data0068.rkey)'+#13+
       'GROUP BY dbo.Data0069.PURCH_REQ_PTR)'+#13+
   ' and not EXISTS('+#13+
   'SELECT  dbo.Data0069.PURCH_REQ_PTR'+#13+
   'FROM  dbo.Data0069 INNER JOIN'+#13+
   '(SELECT  Data0069_1.PURCH_REQ_PTR FROM dbo.Data0071 INNER JOIN'+#13+
   ' dbo.Data0069 AS Data0069_1 ON dbo.Data0071.rkey69 = Data0069_1.RKEY'+#13+
   'where (data0071.po_ptr='+inttostr(rkey70)+')'+#13+
   ' GROUP BY Data0069_1.PURCH_REQ_PTR) AS derivedtbl_1 ON'+#13+
   'dbo.Data0069.PURCH_REQ_PTR = derivedtbl_1.PURCH_REQ_PTR'+#13+
   'WHERE  (dbo.Data0069.status = 0)'+#13+
   'and (data0069.PURCH_REQ_PTR=data0068.rkey)'+#13+
   'GROUP BY dbo.Data0069.PURCH_REQ_PTR)';
   ExecSQL;
  end
end;

procedure TForm4.update_204_68(rkey70: Integer);
begin

 with dm.ADOQuery2 do
 begin
   close;
   sql.Text:='update data0204 set status=0 '+
   'from data0204 inner join data0072 on '+
   'data0204.rkey=data0072.rkey204 '+
   'where data0072.poptr='+inttostr(rkey70);
   ExecSQL;
 end;

 with dm.ADOQuery2 do
 begin
   close;
   sql.Text:='update data0068 set status=2 '+
   'where EXISTS(select data0204.PURCHASE_REQ_PTR '+
   'from data0204 inner join data0072 on '+
   'data0204.rkey=data0072.rkey204 '+
   'where data0072.poptr='+inttostr(rkey70)+
   'and data0204.PURCHASE_REQ_PTR=data0068.rkey '+
   'group by data0204.PURCHASE_REQ_PTR)';
   ExecSQL;
 end;

end;

procedure TForm4.update_204_68_post(rkey70: Integer);
begin
 with dm.ADOQuery2 do
 begin
   close;
   sql.Text:='update data0204 set status=1 '+
   'from data0204 inner join data0072 on '+
   'data0204.rkey=data0072.rkey204 '+
   'where data0072.poptr='+inttostr(rkey70);
   ExecSQL;
 end;

 with dm.ADOQuery2 do
  begin
   close;
   sql.Text:=
   'update data0068 set status=6'+#13+
   'where EXISTS(SELECT dbo.data0204.PURCHASE_REQ_PTR'+#13+
       'FROM  dbo.Data0072 INNER JOIN'+#13+
       ' dbo.data0204 ON dbo.Data0072.rkey204 = dbo.data0204.RKEY'+#13+
       'where (data0072.poptr='+inttostr(rkey70)+')'+#13+
       'and (data0204.PURCHASE_REQ_PTR=data0068.rkey)'+#13+
       'GROUP BY dbo.data0204.PURCHASE_REQ_PTR)'+#13+
   'and not EXISTS('+#13+
   'SELECT  dbo.data0204.PURCHASE_REQ_PTR'+#13+
   'FROM  dbo.data0204 INNER JOIN'+#13+
   '(SELECT  data0204_1.PURCHASE_REQ_PTR FROM dbo.Data0072 INNER JOIN'+#13+
   ' dbo.data0204 AS data0204_1 ON dbo.Data0072.rkey204 = data0204_1.RKEY'+#13+
   'where (data0072.poptr='+inttostr(rkey70)+')'+#13+
   ' GROUP BY data0204_1.PURCHASE_REQ_PTR) AS derivedtbl_1 ON'+#13+
   'dbo.data0204.PURCHASE_REQ_PTR = derivedtbl_1.PURCHASE_REQ_PTR'+#13+
   'WHERE  (dbo.data0204.status = 0)'+#13+
   'and (data0204.PURCHASE_REQ_PTR=data0068.rkey)'+#13+
   'GROUP BY dbo.data0204.PURCHASE_REQ_PTR)';
   ExecSQL;
  end
end;

procedure TForm4.BitBtn2Click(Sender: TObject);
var
 sub_total:real;
begin
if v_new_type=10 then   //����Ǳ༭״̬���浥����¼
 begin
   if trim(dbedit16.Text)='' then
   begin
    messagedlg('�ɹ�������Ų���Ϊ��!',mtinformation,[mbcancel],0);
    dbedit16.SetFocus;
    exit;
   end;

  dm.ADOConnection1.BeginTrans; //�������ﴦ��
  dm.ADO70PRINT_DATE.AsVariant:=null;
  dm.ADO70EDIT_BY_EMPL_PTR.Value := StrToInt(user_ptr);  //�༭��Ա
  dm.ADO70EMPLOYEE_POINTER.Value := StrToInt(user_ptr); //���༭��ԱҲ�����ı�050125

  if trim(dm.ADO70FOB.Value) = '' then dm.ADO70FOB.AsVariant := null;    //�빺���

 if (dm.ADO70STATUS.Value <> 8) then dm.ADO70STATUS.Value:=8;
  change_data0070(dm.ADO70RKEY.Value); //��¼�޸��˼�¼����Щ�ؼ��ֶ�
  try
   dm.ADO70.UpdateBatch();
//   with dm.ADOQuery3 do  //���¹�Ӧ����Ϣ
//    begin
//     close;
//     Parameters.ParamByName('supp_ptr').Value := dm.ADO70SUPPLIER_POINTER.Value;
//     open;
//     edit;
//     dm.ADOQuery3tax_id_number.Value:= trim(dm.ADO70ANALYSIS_CODE_5.Value);  //�����
//     dm.ADOQuery3analysis_code1.Value := trim(dm.ADO70ANALYSIS_CODE_4.Value);//Ʊ������
//     post;
//    end;
  except
   dm.ADOConnection1.RollbackTrans;
   messagedlg('��������ʧ��,����ɹ����,�빺���,�Ƿ���ȷ!',mtinformation,[mbcancel],0);
   dm.ADO70.Edit;
   dbedit16.SetFocus;
   exit;
  end;

  if dbgrid1.Visible=true then
   begin
    self.update_69_68(dm.ADO70RKEY.Value);
    dm.ADO71.UpdateBatch();
    change_data0071(dm.ADO70RKEY.Value); //��¼�޸�����Щ��׼�ɹ���Ŀ,ͬʱ���½����ų�
    self.update_69_68_post(dm.ADO70RKEY.Value);
   end
  else
   begin
    SELF.update_204_68(DM.ADO70RKEY.Value);
    dm.ADO72.UpdateBatch();
    change_data0072(dm.ADO70RKEY.Value);   //��¼�޸�����Щ����ɹ���Ŀ
    Self.update_204_68_post(dm.ADO70RKEY.Value);
   end;
  try
   dm.ADO200.UpdateBatch();
   dm.ADO7011.UpdateBatch();
   dm.ADO107011.UpdateBatch();
   dm.ADO0450.UpdateBatch();

   dm.ADOConnection1.CommitTrans;
   v_close:=1;   //��ʾ�����˳�
   ModalResult:=mrok;
  except
   on E: Exception do
    begin
     dm.ADOConnection1.RollbackTrans;
     messagedlg(E.Message,mterror,[mbcancel],0);
    end;
  end;

 end
else//<>10Ϊ����״̬
 if not self.find_po_error() then //���û���ҵ�������Ҫ��������PO�ı���Ƿ��ظ�
 begin
   dm.ADOConnection1.BeginTrans;
   try
    dm.ADO70.UpdateBatch();
   except
    dm.ADOConnection1.RollbackTrans;
    messagedlg('���ݱ���ʧ��,��������ɹ����,�빺���,�Ƿ���ȷ!',mtinformation,[mbcancel],0);
    dm.ADO70.Edit;
    exit;
   end;
  dm.ADO70.First;       //�ƶ�ָ�뵽������¼׼����������ӱ�
  sub_total:=0;         //׼����¼�ɹ��������ܽ��(����λ�Ҽ���)
  while not dm.ADO70.Eof do //+++++++++++++++++++++++++++++++++++++++++++++
  begin
    dm.ADO200.Filter := 'poptr= '+inttostr(dm.ADO70.RecNo);
    dm.ADO200.First;              //����������ñ�
    while not dm.ADO200.Eof do
     begin
      dm.ADO200.Edit;
      dm.ADO200POPTR.Value :=dm.ADO70RKEY.Value;
      dm.ADO200.Post;
      if dm.ADO70RKEY.Value=dm.ADO70.RecNo then
       dm.ADO200.Next;
     end;
    dm.ADO7011.Filter := 'file_pointer= '+inttostr(dm.ADO70.RecNo);
    if not dm.ADO7011.IsEmpty then //���¼��±��������±�
     begin
      dm.ADO7011.Edit;
      dm.ADO7011.FieldValues['file_pointer'] :=dm.ADO70RKEY.Value;
      dm.ADO7011.Post;
     end;
    dm.ADO107011.Filter := 'file_pointer= '+inttostr(dm.ADO70.RecNo);
    if not dm.ADO107011.IsEmpty then //���¼��±������������±�
     begin
      dm.ADO107011.Edit;
      dm.ADO107011.FieldValues['file_pointer'] :=dm.ADO70RKEY.Value;
      dm.ADO107011.Post;
     end;
    dm.ADO0450.Filter := 'file_pointer= '+inttostr(dm.ADO70.RecNo);
    if not dm.ADO0450.IsEmpty then    //���¶��м��±�
     begin
      dm.ADO0450.Edit;
      dm.ADO0450.FieldValues['file_pointer'] :=dm.ADO70RKEY.Value;
      dm.ADO0450.Post;
     end;

   if dbgrid1.Visible = true then
    begin              //������������2003-12-04������dm.ado71���θ�ֵ
     dm.ADO71.Filter := 'po_ptr= '+inttostr(dm.ADO70.RecNo);
     dm.ADO71.First;   //�������ֻ�ڵ�70.rkey=dm.ADO70.RecNoʱ�ᷢ��
     while not dm.ADO71.Eof do
      begin
       dm.ADO71.Edit;
       dm.ADO71.FieldValues['po_ptr'] := dm.ADO70RKEY.Value;
       dm.ADO71.Post;          //ʹ��filter���˺�post���Զ��Ƶ���һ����¼
       if dm.ADO70RKEY.Value = dm.ADO70.RecNo then dm.ADO71.Next;
      end;
    end
   else
    begin
     dm.ADO72.Filter := 'poptr= '+inttostr(dm.ADO70.RecNo);
     dm.ADO72.First;                           //��������ɹ��ӱ�
     while not dm.ADO72.Eof do
      begin
       dm.ADO72.Edit;
       dm.ADO72.FieldValues['poptr'] := dm.ADO70RKEY.Value;
       dm.ADO72.Post;
       if dm.ADO70RKEY.Value = dm.ADO70.RecNo then dm.ADO72.Next;
      end;
    end;
   with dm.ADO0339 do             //��¼�����˲ɹ�����
    begin
     active:=false;
     Parameters.ParamValues['po_ptr'] := dm.ADO70RKEY.Value;
     Parameters.ParamValues['edit_empl_ptr'] := dm.ADO70EMPLOYEE_POINTER.Value;
     Parameters.ParamValues['tran_type'] := 10;
     Parameters.ParamValues['tran_desc'] := '�����ɹ�����';
     Parameters.ParamValues['tran_from'] := null;
     Parameters.ParamValues['tran_to'] := null;
     Parameters.ParamValues['data0071_ptr'] := null;
     Parameters.ParamValues['data0072_ptr'] := null;
     ExecSQL;
    end;
   sub_total:=sub_total+dm.ADO70SUB_TOTAL.Value*dm.ADO70EXCHANGE_RATE.Value;
//   with dm.ADOQuery3 do
//    begin
//     close;
//     Parameters.ParamByName('supp_ptr').Value := dm.ADO70SUPPLIER_POINTER.Value;
//     open;
//     edit;
//     dm.ADOQuery3tax_id_number.Value:= trim(dm.ADO70ANALYSIS_CODE_5.Value);
//     dm.ADOQuery3analysis_code1.Value := trim(dm.ADO70ANALYSIS_CODE_4.Value);
////     dm.ADOQuery3analysis_code2.Value := trim(dm.ADO70ANALYSIS_CODE_3.Value);
//     post;
//    end;
   dm.ADO70.Next;
  end;//++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

   dm.ADO200.Filter := '';
   dm.ADO7011.Filter := '';
   dm.ADO107011.Filter := '';
   dm.ADO0450.Filter := '';
  if dbgrid1.Visible=true then
   dm.ADO71.Filter := ''
  else
   dm.ADO72.Filter := '';

 try
  dm.ADO200.UpdateBatch();
  dm.ADO7011.UpdateBatch();
  dm.ADO107011.UpdateBatch();
  dm.ADO0450.UpdateBatch();

  if dbgrid1.Visible=true then
   begin
    dm.ADO71.UpdateBatch();  //�ύ��׼�빺����
    dm.ADO71.First;
    while not dm.ADO71.Eof do
     begin
      with dm.ADO0339 do
       begin
        active:=false;
        Parameters.ParamValues['po_ptr'] := dm.ADO71PO_PTR.Value;
        Parameters.ParamValues['edit_empl_ptr'] := dm.ADO70EMPLOYEE_POINTER.Value;
        Parameters.ParamValues['tran_type'] := 6;
        Parameters.ParamValues['tran_desc'] := '����һ����׼�ɹ���Ŀ';
        Parameters.ParamValues['tran_from'] := null;
        Parameters.ParamValues['tran_to'] := null;
        Parameters.ParamValues['data0071_ptr'] := dm.ADO71RKEY.Value;
        Parameters.ParamValues['data0072_ptr'] := null;
        ExecSQL;
       end;
      Self.update_69_204(dm.ADO71rkey69.Value,0);
      dm.ADO71.Next;
     end;
   end
  else
   begin
    dm.ADO72.UpdateBatch();  //��Ч�����빺����
    dm.ADO72.First;
    while not dm.ADO72.Eof do
     begin
      with dm.ADO0339 do
       begin
        active:=false;
        Parameters.ParamValues['po_ptr'] := dm.ADO72POPTR.Value;
        Parameters.ParamValues['edit_empl_ptr'] := dm.ADO70EMPLOYEE_POINTER.Value;
        Parameters.ParamValues['tran_type'] := 6;
        Parameters.ParamValues['tran_desc'] := '����һ������ɹ���Ŀ';
        Parameters.ParamValues['tran_from'] := null;
        Parameters.ParamValues['tran_to'] := null;
        Parameters.ParamValues['data0071_ptr'] := null;
        Parameters.ParamValues['data0072_ptr'] := dm.ADO72RKEY.Value;
        ExecSQL;
       end;
      Self.update_69_204(dm.ADO72rkey204.Value,1);
      dm.ADO72.Next;
     end;
   end;

  if (v_new_type=9) and (dm.ADO70FOB.Value='') then //����ǵ��������޸�data0068�ɹ������״̬
  begin
   if dbgrid1.Visible=true then //����ɹ�
    with dm.ADOQuery2 do
    begin
     close;
     sql.Text:=
     'update data0068'+#13+
     'set status=6'+#13+      //�����빺�Ѵ���
     'where rkey in(SELECT dbo.Data0069.PURCH_REQ_PTR'+#13+
         'FROM  dbo.Data0071 INNER JOIN'+#13+
         ' dbo.Data0069 ON dbo.Data0071.rkey69 = dbo.Data0069.RKEY'+#13+
         'where (data0071.po_ptr='+dm.ADO70RKEY.AsString+')'+#13+
         'GROUP BY dbo.Data0069.PURCH_REQ_PTR)'+#13+
     ' and rkey not in('+#13+
     'SELECT  dbo.Data0069.PURCH_REQ_PTR'+#13+
     'FROM  dbo.Data0069 INNER JOIN'+#13+
     '(SELECT  Data0069_1.PURCH_REQ_PTR FROM dbo.Data0071 INNER JOIN'+#13+
     ' dbo.Data0069 AS Data0069_1 ON dbo.Data0071.rkey69 = Data0069_1.RKEY'+#13+
     'where (data0071.po_ptr='+dm.ADO70RKEY.AsString+')'+#13+
     ' GROUP BY Data0069_1.PURCH_REQ_PTR) AS derivedtbl_1 ON'+#13+
     'dbo.Data0069.PURCH_REQ_PTR = derivedtbl_1.PURCH_REQ_PTR'+#13+
     'WHERE  (dbo.Data0069.status = 0)'+#13+
     'GROUP BY dbo.Data0069.PURCH_REQ_PTR)';
     ExecSQL;
    end
   else
    with dm.ADOQuery2 do  //�Ǳ���ɹ�
    begin
     close;
     sql.Text:=
     'update data0068'+#13+
     'set status=6'+#13+      //�����빺�Ѵ���
     'where rkey in(SELECT dbo.Data0204.PURCHASE_REQ_PTR'+#13+
         'FROM  dbo.Data0072 INNER JOIN'+#13+
         ' dbo.Data0204 ON dbo.Data0072.rkey204 = dbo.Data0204.RKEY'+#13+
         'where (data0072.poptr='+dm.ADO70RKEY.AsString+')'+#13+
         'GROUP BY dbo.Data0204.PURCHASE_REQ_PTR)'+#13+
     ' and rkey not in('+#13+
     'SELECT  Data0204.PURCHASE_REQ_PTR'+#13+
     'FROM  data0204 INNER JOIN'+#13+
     '(SELECT  Data0204_1.PURCHASE_REQ_PTR FROM dbo.Data0072 INNER JOIN'+#13+
     ' Data0204 AS Data0204_1 ON Data0072.rkey204 = Data0204_1.RKEY'+#13+
     'where (data0072.poptr='+dm.ADO70RKEY.AsString+')'+#13+
     ' GROUP BY Data0204_1.PURCHASE_REQ_PTR) AS derivedtbl_1 ON'+#13+
     'dbo.Data0204.PURCHASE_REQ_PTR = derivedtbl_1.PURCHASE_REQ_PTR'+#13+
     'WHERE  (dbo.Data0204.status = 0)'+#13+
     'GROUP BY dbo.Data0204.PURCHASE_REQ_PTR)';
     ExecSQL;
    end
  end
  else
   if (v_new_type=9) and (dm.ADO70FOB.Value<>'') then //����ǵ��������޸�data0068�ɹ������״̬
   begin                //ͬʱ�޸��빺����Ӧ��Ԥ����
    dm.asp362.Edit;     //����Ԥ���ʹ���������ɹ����ŵ�ʵ�ʲɹ�Ϊ׼��
    dm.asp362.fieldvalues['used_period_'+inttostr(dm.asp362v_month.Value)] :=
    formatfloat('0.00',dm.asp362.fieldvalues['used_period_'+inttostr(dm.asp362v_month.Value)]+
     (dm.asp362TOTAL.Value-sub_total));  //Ԥ��ʹ�ý��������ʱ���޸��ˣ�����ֻ���Ӳ��
    dm.asp362.Post;     //�����޸�ʱ��Ϊ030328��Ҫ�����޸�

    if dbgrid1.Visible=true then //����ɹ�
    with dm.ADOQuery2 do
    begin
      close;
      sql.Text:='update data0068 set status=6 '+
      'where po_req_number='+quotedstr((dm.ADO70FOB.Value))+' and '+
      'not EXISTS(select rkey from data0069 where status=0 and data0069.purch_req_ptr=data0068.rkey)';
      ExecSQL;
    end
    else
    with dm.ADOQuery2 do
    begin
      close;
      sql.Text:='update data0068 set status=6 '+
      'where po_req_number='+quotedstr((dm.ADO70FOB.Value))+' and '+
      'not EXISTS(select rkey from data0204 where status=0 and data0204.purchase_req_ptr=data0068.rkey)';
      ExecSQL;
    end;
   end;

  if form1.if_suplst='Y' then
   dm.ADO04.UpdateBatch()
  else
   dm.aq0015.UpdateBatch(); //���������

  dm.ADOConnection1.CommitTrans;
  v_close:=1; //�����˳�
  ModalResult :=mrok;
 except
   on E: Exception do
    begin
     dm.ADOConnection1.RollbackTrans;
     messagedlg(E.Message,mterror,[mbcancel],0);
    end;
 end;

 end;
end;

procedure TForm4.BitBtn11Click(Sender: TObject);
var
 ship_flag,misc_flag:string;
begin
try
 form8:=tform8.Create(application);
 ship_flag:=dm.ADO70STATE_SHIP_TAX_FLAG.Value;
 misc_flag:=dm.ADO70STATE_MISC_TAX_FLAG.Value;
  with dm.ADOQuery2 do
   begin
    active := false;
    sql.Clear;
    sql.Add('select data0189.state_id from data0189,data0024');
    sql.Add('where data0024.city_tax_ptr=data0189.rkey and');
    sql.Add('data0024.rkey='+dm.ADO70SUPP_FAC_ADD_PTR.AsString);
    active := true;
    form8.Edit1.Text := fieldvalues['state_id'];
   end;
 if form8.ShowModal=mrok then
  self.change_tax_total()
 else
  begin
   dm.ADO70STATE_SHIP_TAX_FLAG.Value:=ship_flag;
   dm.ADO70STATE_MISC_TAX_FLAG.Value:=misc_flag;
  end;
finally
 form8.free;
end;
end;

procedure TForm4.N3Click(Sender: TObject);
var
 v_total,v_tax:real;
begin
 try
  form9 := tform9.Create(application);
  v_total := dm.ADO71taxprice_total.Value;
  v_tax := dm.ADO71tax_total.Value;

  dm.ADO71.Edit;
  form9.MaskEdit1.Text := dm.ADO71REQ_DATE.AsString;

  if form9.ShowModal=mrok then
   begin
    dm.ADO71REQ_DATE.AsString:=form9.MaskEdit1.Text;

    edit2.text := formatfloat('0.00',strtofloat(edit2.Text)-v_total+dm.ADO71taxprice_total.Value);

    edit3.Text := formatfloat('0.00',strtofloat(edit3.Text)-v_tax+dm.ADO71tax_total.Value);

    dbedit7.Field.Value := dbedit7.Field.Value-v_total+dm.ADO71taxprice_total.Value;

    dm.ADO71.Post;
   end;
 finally
  form9.free;
 end;
end;

procedure TForm4.N1Click(Sender: TObject);
begin
try
 form2:=tform2.Create(application);
 form2.BitBtn2.Enabled := false;
 form2.BitBtn3.Enabled := false;
 form2.Edit3.Enabled := false;
 form2.RadioGroup1.Visible := false;
 with dm.ADOQuery1 do
  begin
   active := false;
   sql.Clear;
   sql.Add('select rkey,code,supplier_name from data0023');
   sql.Add('where rkey='+dm.ADO70SUPPLIER_POINTER.AsString);
   active := true;
   form2.edit2.Text := fieldvalues['code'];
   form2.Label5.Caption := fieldvalues['supplier_name'];
   form2.rkey23.Caption := dm.ADO70SUPPLIER_POINTER.AsString;
  end;
 with dm.ADOQuery1 do
  begin
   active:=false;
   sql.Clear;
   sql.Add('select rkey,warehouse_code,warehouse_name from data0015');
   sql.Add('where rkey='+dm.ADO70WAREHOUSE_POINTER.AsString);
   active:=true;
   form2.edit3.Text := fieldvalues['warehouse_code'];
   form2.Label6.Caption := fieldvalues['warehouse_name'];
   form2.rkey15.Caption := dm.ADO70WAREHOUSE_POINTER.AsString;
  end;
 if form2.ShowModal = mrok then
  begin
   with dm.ADOQuery1 do
    begin
     active:=false;
     sql.Clear;
     sql.Add('select currency_ptr from data0028');
     sql.Add('where inventory_ptr='+form2.rkey17.Caption);
     sql.Add('and supplier_ptr='+form2.rkey23.Caption);
     active:=true;
    end;
   if dm.ADOQuery1.FieldValues['currency_ptr']=dm.ADO70CURRENCY_PTR.Value then
    form4.add_0071                             //������׼�ɹ��ӱ�
   else
    messagedlg('ͬһ�ɹ�������,������Ҫ����Ҳ�ͬ�Ĳɹ�!',mtinformation,[mbcancel],0);
  end;
finally
 form2.free;
end;
end;

procedure TForm4.N2Click(Sender: TObject);
begin
 edit2.Text := formatfloat('0.00',strtofloat(edit2.Text)-dm.ADO71taxprice_total.Value);
 edit3.Text := formatfloat('0.00',strtofloat(edit3.Text)-dm.ADO71tax_total.Value);
 dbedit7.Field.Value := dbedit7.Field.Value-dm.ADO71taxprice_total.Value;
    //�ܽ��ϼ�
 dm.ADO71.Delete;
end;

procedure TForm4.appendprlist_0070;
var
 i:byte;
begin
 with dm.ADO70 do
  begin                //70������ʼ
   append;
  if form1.if_suplst='Y' then
   if dm.ADO04SEED_FLAG.Value<>1 then
    dm.ADO70PO_NUMBER.Value := dm.ADO04SEED_VALUE.Value
   else
  else
   if form_req.ClientDataSet1o_i_flag.value = 0 then   //��ʽһ
    dm.ADO70PO_NUMBER.Value := dm.AQ0015purchase_order.Value
   else
    dm.ADO70PO_NUMBER.Value := dm.AQ0015o_purchase_order.Value;

   if form_req.ClientDataSet1o_i_flag.value = 0 then //��ʽһ
    dm.ADO70SHIPTO_ADDRESS.Value := dm.AQ0015ADDRESS_LINE_3.Value
   else                                     //��ʽ��
    dm.ADO70SHIPTO_ADDRESS.Value := dm.AQ0015o_address_3.Value;

   dm.ADO70EMPLOYEE_POINTER.AsString:= common.user_ptr;  //2Ա��
   dm.ADO70PO_TYPE.Value :=form_req.ClientDataSet1FLAG.value;  //��׼��������

   dm.ADO70SUPPLIER_POINTER.Value := Form_req.ClientDataSet1SUPP_PTR.Value;   //3��Ӧ��
   dm.ADO70CURRENCY_PTR.Value := Form_req.ClientDataSet1PO_LINK_PTR.Value;    //5����
   dm.ADO70EXCHANGE_RATE.Value := Form_req.ClientDataSet1BASE_TO_OTHER.Value;//.20���һ���
   dm.ADO70DISCOUNT2_DAYS.Value := Form_req.ClientDataSet1o_i_flag.Value;    //�����ʽ

   if (form_req.ADOQuery1FLAG.value = 'S')  then//�������
     dm.ADO70ANALYSIS_CODE_2.Value:= self.invtory_type(Form_req.ClientDataSet1INVT_PTR.AsString)
   else
    dm.ADO70ANALYSIS_CODE_2.Value:= Form_req.ClientDataSet1INV_DESCRIPTION.Value; //�������
   tc1.Tabs.Add(trim(Form_req.ClientDataSet1CODE.Value));

   with dm.ADOQuery1 do//��������,�绰��ֵ,�������Ʊ�����࣬����ص�
    begin
     active:=false;
     sql.Clear;
     sql.Add('select CONTACT_NAME_1,CONTACT_NAME_2,CONTACT_NAME_3,');
     sql.Add('CONTACT_NAME_4,CONTACT_NAME_5,CONTACT_NAME_6,EDI_OUT_NEW_PO,');
     sql.Add('discount,discount2,discount_days,discount2_days,payment_terms,');
     sql.Add('PHONE,fax,TAX_ID_NUMBER,ANALYSIS_CODE1,ANALYSIS_CODE2,EDI_FLAG_FOR_PO');
     sql.Add('from data0023 where rkey='+dm.ADO70SUPPLIER_POINTER.AsString);
     active :=true;
     dbCombobox1.Clear;
     for i:=1 to 6 do     //������
      dbcombobox1.Items.Add(fieldbyname('contact_name_'+inttostr(i)).asstring);
     dm.ADO70SUPPIER_CONTACT.Value := fieldbyname('CONTACT_NAME_1').AsString; //5 �ͻ�������
     dm.ADO70CONTACT_PHONE.Value := trim(fieldbyname('PHONE').AsString)+'/'+
     trim(fieldbyname('fax').AsString); //4�ͻ������˵绰
     dm.ADO70PAYMENT_TERMS.Value := fieldvalues['payment_terms'];     //13 ����������
     dm.ADO70CASH_DISCOUNT.Value := fieldvalues['discount'];      //14 ��������
     dm.ADO70CASH_DISCOUNT2.Value := fieldvalues['discount2'];    //15 ��������
     dm.ADO70DISCOUNT_DAYS.Value := fieldvalues['discount_days']; //16 ��������
     dm.ADO70ANALYSIS_CODE_5.Value :=trim(fieldbyname('tax_id_number').AsString); //�����
     dm.ADO70ANALYSIS_CODE_4.Value :=trim(fieldbyname('ANALYSIS_CODE1').AsString);//Ʊ������
     dm.ADO70ANALYSIS_CODE_3.Value :=trim(fieldbyname('ANALYSIS_CODE2').AsString);//����ص�
     if dm.ADO70PO_TYPE.Value='S' then
     if fieldbyname('EDI_OUT_NEW_PO').AsInteger=0 then
      dm.ADO70STATE_INVT_TAX_FLAG.Value:='N'
     else
      dm.ADO70STATE_INVT_TAX_FLAG.Value:='Y';  //VMI�ɹ�
     dm.ADO70SECOND_WHSE_PTR.Value:=fieldbyname('EDI_FLAG_FOR_PO').AsInteger;
    end;
   with dm.ADOQuery1 do//����װ�˵�ַ�е�ֵ
    begin
     active:=false;
     sql.Clear;
     sql.Add('SELECT Data0024.RKEY,data0024.SHIPPING_LEAD_TIME,factory_location,');
     sql.Add('data0024.state_misc_tax_flag,data0024.state_ship_tax_flag,');
     sql.Add('data0189.state_tax,shipping_method');
     sql.Add('FROM Data0024,data0189');
     sql.Add('WHERE data0024.city_tax_ptr=data0189.rkey and');
     sql.Add('Data0024.SUPPLIER_PTR ='+dm.ADO70SUPPLIER_POINTER.AsString);
     active:=true;
     dm.ADO70SUPP_FAC_ADD_PTR.Value := FieldValues['rkey'];  //..6��Ӧ��װ�˵�ַ
     dm.ADO70FEDERAL_TAX.Value := FieldValues['state_tax'];  //..7��ֵ˰��
     dm.ADO70STATE_SHIP_TAX_FLAG.Value := FieldValues['STATE_SHIP_TAX_FLAG']; //8װ�˼�˰
     dm.ADO70STATE_MISC_TAX_FLAG.Value := FieldValues['STATE_MISC_TAX_FLAG']; //9�����˰
     dm.ADO70SHIPPING_METHOD.Value := fieldbyname('shipping_method').AsString;
    end;
     dm.ADO70WAREHOUSE_POINTER.value :=form_req.ClientDataSet1WHSE_PTR.Value; //10 ����

     if ComboBox1.Items.Count=0 then
     Self.get_approve_type(dm.ADO70WAREHOUSE_POINTER.Value);  //�õ���������

     dm.ADO70STATUS.Value := 8;                            //11  ״̬δ���
     dm.ADO70PO_DATE.Value := form1.sys_date;               //12  �ɹ��������ڶ̸�ʽ
     dm.ADO70COLLECT_PREPAID.Value := 'C';                 //13  �󸶿�
     if dm.ADO70CURRENCY_PTR.Value =1 then
      begin
       dbedit5.ReadOnly:=true;
       dbedit5.Color := cl3dlight;  //�������Ϊ��׼���Ҳ��ܱ༭����
      end;

     dm.ADO70SHIPPING_COST.Value := 0;                          //.21װ�˷�
     dm.ADO70MISC_CHARGE.Value := 0;                            //.22�����
     dm.ADO70SUB_TOTAL.Value := 0;                              //..24 ���ϼ�
     dm.ADO70DISCOUNT_AMOUNT.Value := 0;                        //..25 �۸��ۿۺϼ�
//     dm.ADO70FOB.Value :=form_req.ClientDataSet1PO_REQ_NUMBER.Value; //..26�빺���030327�޸�
     dm.ADO70PO_REV_NO.Value := form_req.ClientDataSet1DEPARTMENT_NAME.Value; //27�빺����
     dm.ADO70ANALYSIS_CODE_1.Value := trim(form_req.ClientDataSet1EMPLOYEE_NAME.Value); //28�빺��Ա
     dm.ADO70PURCHASE_ORDER_TYPE.Value :=0;             //29��������
     dm.ADO70.Post;
     if (dm.ADO70PO_TYPE.Value='S') then
      dm.ADO71.Filter := 'po_ptr= '+inttostr(dm.ADO70.RecNo)
     else
      dm.ADO72.Filter := 'poptr= '+inttostr(dm.ADO70.RecNo);

     dm.ADO70.Edit;

     self.change_seed_value(trim(dm.ADO70PO_NUMBER.Value));   //�ı�data0015����04����PO��ŵĳ�ʼֵ
     edit7.Text := form_req.ClientDataSet1warehouse_name.value+':'+
                   form_req.ClientDataSet1abbr_name15.value ;

  end;                    //70��������
end;

procedure TForm4.FormActivate(Sender: TObject);
begin
if (v_new_type=0) or (v_new_type=1) then //������½���׼�ɹ���������ɹ�
 try

  form2:=tform2.Create(application);
  if v_new_type=0 then  //׼��������׼�ɹ���Ŀ
   with dm.ADO71 do
    begin
     if active=true then active:=false;
     sql.Clear;
     sql.Add('select * from data0071 where rkey is null');
     active:=true;
    end
  else              //׼����������ɹ���Ŀ
   with dm.ADO72 do
    begin
     if active=true then active:=false;
     sql.Clear;
     sql.Add('select * from data0072 where rkey is null');
     active:=true;
     dbgrid1.Visible:=false;
     dbgrid2.Visible:=true;
     self.add_misc_visible(); //ʹһЩ�ؼ����ɼ�
     self.DBCheckBox2.Visible:=false;
    end;

  dbedit1.Color := clwindow;  //�ֹ�����ʱ���������빺������
  dbedit1.ReadOnly := True;
  dbedit3.Color := clwindow;  //�ֹ�����ʱ���������빺���
  dbedit3.ReadOnly := false;
  bitbtn6.Enabled := true;

 if form2.ShowModal=mrok then
  begin
   if form1.if_suplst='Y' then
    begin
     dm.ADO04.Close;
     dm.ADO04.Open;
    end;
   dm.AQ0015.Close;
   dm.AQ0015.Parameters[0].Value := strtoint(form2.rkey15.Caption);
   dm.AQ0015.Open;            //�򿪹����ɹ�������ʼֵ

   tc1.Visible := true;
   add_0070;
   edit7.Text := form2.label6.Caption;
   if v_new_type = 0 then
    add_0071  //��һ�����ӱ�׼�ɹ��ӱ���
   else
    add_0072; //��һ����������ɹ��ӱ���
  end;
 finally
  form2.free;
 end
else
 if v_new_type=9 then //����ǵ�������
 try
  form_req:=tform_req.Create(application);
  if form_req.ADOQuery1.IsEmpty then
   messagedlg('�˴�����û���ҵ�����!',mtinformation,[mbcancel],0)
  else
 if form_req.ShowModal=mrok then
  begin
   if Form_req.PageControl1.ActivePageIndex=0 then
   begin
     tc1.Visible:=true;
     with dm.asp362 do   //�ɹ���ʹ�õ�Ԥ���׼�������޸�Ԥ��
     begin
      active := false;
      Parameters[1].Value := form_req.ADOQuery1PO_REQ_NUMBER.Value;
      active := true;
     end;
     if form1.if_suplst='Y' then
     begin
      dm.ADO04.Close;
      dm.ADO04.Open;
     end;
     dm.AQ0015.Close;
     dm.AQ0015.Parameters[0].Value := form_req.ADOQuery1WHSE_PTR.Value;
     dm.AQ0015.Open;         //�򿪹����ɹ�������ʼֵ

     if (form_req.ADOQuery1FLAG.Value = 'S')  then //�����׼�빺
      begin
       with dm.ADO71 do     //׼�������׼�ɹ���Ŀ
        begin
         active:=false;
         sql.Clear;
         sql.Add('select * from data0071 where rkey is null');
         active:=true;
        end;
       dm.ADO0069.First;
       while not dm.ADO0069.Eof do
       begin
        if find_supplier(trim(dm.ADO0069.FieldValues['code']),dm.ADO0069PO_LINK_PTR.Value) then
         self.append_0071()
        else
         begin
          self.append_0070();
          self.append_0071();
          tc1.TabIndex := tc1.Tabs.Count-1;
          if dbedit16.Enabled=true then dbedit16.SetFocus;
          edit4.Text := '0.00';   //��������˰
         end;
        dm.ADO0069.Next;
       end;
      end
     else  //���������빺flag='M'
     begin
      dbgrid1.Visible:=false;
      dbgrid2.Visible:=true;
      DBCheckBox2.Visible:=false;
      with dm.ADO72 do
      begin
       active:=false;
       sql.Clear;           //׼����������ɹ���Ŀ
       sql.Add('select * from data0072 where rkey is null');
       active:=true;
      end;
      dm.ADO0204.First;
      while not dm.ADO0204.Eof do
       begin
       if find_supplier(trim(dm.ADO0204.FieldValues['code']),dm.ADO0204PO_LINK_PTR.Value) then
        self.append_0072()
       else
        begin
         self.append_0070();
         self.append_0072();
         tc1.TabIndex := tc1.Tabs.Count-1;
        end;
        dm.ADO0204.Next;
       end;
      if dbedit16.Enabled=true then dbedit16.SetFocus;
     end;
     edit7.Text := form_req.adoquery1warehouse_name.value;
   // end; //����..2
   end
   else    //���빺��ϸ����
   begin
     tc1.Visible:=true;
     if form1.if_suplst='Y' then
     begin
      dm.ADO04.Close;
      dm.ADO04.Open;
     end;
     
     dm.AQ0015.Close;
     dm.AQ0015.Parameters[0].Value :=Form_req.ClientDataSet1WHSE_PTR.Value;
     dm.AQ0015.Open;         //�򿪹����ɹ�������ʼֵ

     self.appendprlist_0070();
  //
     if (form_req.ClientDataSet1FLAG.Value = 'S')  then //�����׼�빺
      begin
       with dm.ADO71 do     //׼�������׼�ɹ���Ŀ
        begin
         active:=false;
         sql.Clear;
         sql.Add('select * from data0071 where rkey is null');
         active:=true;
        end;
        Form_req.ClientDataSet1.First;
        while not Form_req.ClientDataSet1.Eof do
        begin
         dm.ADO71.Append;
         dm.ADO71PO_PTR.Value := dm.ADO70.RecNo;               //POָ��
         dm.ADO71INVT_PTR.Value := Form_req.ClientDataSet1INVT_PTR.Value;   //����ָ��
         dm.ADO71QUAN_ORD.Value := Form_req.ClientDataSet1QUANTITY.Value;   //����
         dm.ADO71REQ_DATE.Value := Form_req.ClientDataSet1reply_date.Value; //����������װ������
         dm.ADO71PURCHASE_UNIT_PTR.Value := Form_req.ClientDataSet1UNIT_PTR.Value; //�ɹ���λ
         dm.ADO71PRICE.Value := Form_req.ClientDataSet1UNIT_PRICE.Value;    //����˰�۸�
         dm.ADO71tax_price.Value := Form_req.ClientDataSet1tax_price.Value; //��˰��
         dm.ADO71TAX_2.Value := Form_req.ClientDataSet1tax.Value;           //˰��
         dm.ADO71CONVERSION_FACTOR.Value := Form_req.ClientDataSet1CONVERSION_FACTOR.Value; //ת����
         dm.ADO71reason.Value := Form_req.ClientDataSet1reason.Value;       //�빺ԭ��
         dm.ADO71extra_req.Value := Form_req.ClientDataSet1extra_req.Value; //�ر�Ҫ��
         dm.ado71avl_flag.value := Form_req.ClientDataSet1avl_flag.value;   //�Ƿ���Ҫ���ϼ��
         dm.ADO71rohs.Value:=Form_req.ClientDataSet1rohs.Value;             //������ʶ
         dm.ADO71WO_PTR.Value:=Form_req.ClientDataSet1req_unit_ptr.Value;   //�����λ
         dm.ADO71IF_CAF.Value:=Form_req.ClientDataSet1IF_CAF.Value; //caf
         dm.ado71rkey69.Value:=Form_req.ClientDataSet1RKEY.Value;  //�빺��ϸ�⽡
         dm.ADO71IF_urgency.Value := Form_req.ClientDataSet1IF_urgency.Value; //�Ƿ��������
         dm.ADO71ORIG_ABBRNAME.AsVariant :=  Form_req.ClientDataSet1ORIG_ABBRNAME.AsVariant;//Ʒ�ƹ�Ӧ��
         dm.ADO71.Post;

         dm.ADO70SUB_TOTAL.AsString := formatfloat('0.00',
           dm.ADO70SUB_TOTAL.Value+dm.ADO71taxprice_total.Value);
         edit2.Text := formatfloat('0.00',StrToCurr(edit2.Text)+dm.ADO71taxprice_total.Value);
         edit3.Text := formatfloat('0.00',StrToCurr(edit3.Text)+dm.ADO71tax_total.Value);
         Form_req.ClientDataSet1.Next;
        end;
      end
     else  //����Ǳ����빺flag='M'
     begin
      dbgrid1.Visible:=false;
      dbgrid2.Visible:=true;
      DBCheckBox2.Visible:=false;  //�Ǳ���ɹ�����ʹ��VMI
      with dm.ADO72 do
      begin
       active:=false;
       sql.Clear;           //׼����������ɹ���Ŀ
       sql.Add('select * from data0072 where rkey is null');
       active:=true;
      end;
       Form_req.ClientDataSet1.First;
       while not Form_req.ClientDataSet1.Eof do
       begin
        dm.ADO72.Append;
        dm.ADO72POPTR.Value := dm.ADO70.RecNo;          //POָ��
        dm.ADO72DESCRIPTION.Value := Form_req.ClientDataSet1INV_PART_NUMBER.Value;   //��Ʒ����
        dm.ADO72GUI_GE.Value := Form_req.ClientDataSet1INV_NAME.Value;               //��Ʒ���
        dm.ADO72DESCRIPTION2.Value := Form_req.ClientDataSet1INV_DESCRIPTION.Value;  //���
        dm.ADO72QUAN_ORD.Value := Form_req.ClientDataSet1QUANTITY.Value;  //����
        dm.ADO72UNIT_PRICE.Value := Form_req.ClientDataSet1UNIT_PRICE.Value;       //�����۸�
        dm.ADO72DEL_DATE.Value := Form_req.ClientDataSet1reply_date.Value;         //��������
        dm.ADO72UNIT_PTR.Value := Form_req.ClientDataSet1UNIT_PTR.value;            //�ɹ���λ
        dm.ADO72STATE_TAX.Value := Form_req.ClientDataSet1tax.Value;               //��ֵ˰
        DM.ADO72tax_price.Value :=Form_req.ClientDataSet1tax_price.Value;          //��˰��
        dm.ADO72rohs.Value := Form_req.ClientDataSet1rohs.Value;  //������ʶ
        dm.ADO72reason.Value := Form_req.ClientDataSet1reason.Value;
        dm.ADO72rkey204.Value:= Form_req.ClientDataSet1RKEY.Value; //�빺��ϸ�⽡
        dm.ADO72IF_urgency.Value := Form_req.ClientDataSet1IF_urgency.Value; //�Ƿ��������        
        dm.ADO72.Post;

        dm.ADO70SUB_TOTAL.AsString := formatfloat('0.00',
        dm.ADO70SUB_TOTAL.Value+dm.ADO72taxprice_total.Value);
         edit2.Text := formatfloat('0.00',StrToCurr(edit2.Text)+dm.ADO72taxprice_total.Value);
         edit3.Text := formatfloat('0.00',StrToCurr(edit3.Text)+dm.ADO72tax_total.Value);
        Form_req.ClientDataSet1.Next;
       end;
     end;
     if dbedit16.Enabled=true then dbedit16.SetFocus;
  //
   end;
  end;
 finally
  form_req.Free;
 end;
end;

procedure TForm4.PopupMenu1Popup(Sender: TObject);
begin
 if dm.ADO71.IsEmpty then
  begin
   n2.Enabled := false;
   n3.Enabled := false;
  end
 else
  begin
   if dm.ADO71QUAN_RECD.Value>0 then
    n2.Enabled :=false
   else
   n2.Enabled := true;
   n3.Enabled := true;
  end;
end;

procedure tform4.po_value();
begin
  if form1.if_suplst='Y' then
   if dm.ADO04SEED_FLAG.Value<>1 then
    dm.ADO70PO_NUMBER.Value := dm.ADO04SEED_VALUE.Value
   else
  else
   if form_req.ADOQuery1FLAG.value = 'S' then
     if  dm.ADO0069o_i_flag.Value = 0 then
      dm.ADO70PO_NUMBER.Value := dm.AQ0015purchase_order.Value
     else
      dm.ADO70PO_NUMBER.Value := dm.AQ0015o_purchase_order.Value
   else
    if  dm.ADO0204o_i_flag.Value = 0 then
      dm.ADO70PO_NUMBER.Value := dm.AQ0015purchase_order.Value
    else
      dm.ADO70PO_NUMBER.Value := dm.AQ0015o_purchase_order.Value;


 if form_req.ADOQuery1FLAG.value = 'S' then //��׼�ɹ�
  if dm.ADO0069o_i_flag.Value = 0 then     //���ڲɹ�
   begin
    dm.ADO70SHIPTO_ADDRESS.Value := dm.AQ0015ADDRESS_LINE_3.Value;
   end
  else                                     //����ɹ�
   begin
    dm.ADO70SHIPTO_ADDRESS.Value := dm.AQ0015o_address_3.Value;
   end
 else     //����ɹ�
  if dm.ADO0204o_i_flag.Value = 0 then       //���ڲɹ�
   begin
    dm.ADO70SHIPTO_ADDRESS.Value := dm.AQ0015ADDRESS_LINE_3.Value;
   end
  else                                     //����ɹ�
   begin
    dm.ADO70SHIPTO_ADDRESS.Value := dm.AQ0015o_address_3.Value;
   end;
end;

procedure tform4.add_0071();
var
 i:word;
 v_sim_total,v_tax_total:single;
begin
for i:=1 to strtoint(form2.edit4.Text) do  //��ηż�¼����
 begin
  dm.ADO71.Append;
  if v_new_type=10 then            //����Ǳ�Ӽ�״̬������
   dm.ADO71PO_PTR.Value := dm.ADO70RKEY.Value
  else
   dm.ADO71PO_PTR.Value := dm.ADO70.RecNo;             //POָ��
  dm.ADO71INVT_PTR.AsString := form2.rkey17.caption;   //����ָ��
  dm.ADO71QUAN_ORD.AsString := form2.Edit6.Text;       //����
  dm.ADO71extra_req.AsString := form2.Edit12.Text;     //�ر�Ҫ��
  dm.ADO71REQ_DATE.Value := strtodatetime(form2.MaskEdit1.Text)+(i-1)*strtoint(form2.Edit5.text);
  if  Form2.CheckBox3.Checked then
   dm.ADO71avl_flag.Value :='Y'
  else
   dm.ADO71avl_flag.Value :='N';
 // dm.ADO71avl_flag.Value := form2.po_avlflag.Caption;  //�Ƿ���Ҫ���ϼ��

  dm.ADO71PRICE.Value := strtofloat(form2.Edit7.Text);              //����˰��
  dm.ADO71tax_price.Value := strtofloat(form2.Edit13.Text);          //��˰��
  dm.ADO71TAX_2.Value := strtofloat(form2.Edit14.Text);              //��ֵ˰
  dm.ADO71PURCHASE_UNIT_PTR.Value := strtoint(form2.rkey02.Caption); //�ɹ���λ
  dm.ADO71CONVERSION_FACTOR.Value := strtofloat(form2.Edit15.Text);  //ת����
  dm.ADO71rohs.Value := form2.ComboBox1.Text;
  dm.ADO71IF_CAF.Value:=form2.Edit16.Text;
  dm.ADO71WO_PTR.Value:= strtoint(form2.req_unitptr.Caption);
  dm.ADO71IF_urgency.Value:=Form2.CheckBox2.Checked;  //�Ƿ��������
  if Form2.Edit19.Text<>'' then
  dm.ADO71ORIG_ABBRNAME.Value := Form2.Edit19.Text;    //Ʒ�ƹ�Ӧ��

  dm.ADO71.Post;

  dm.ADO70SUB_TOTAL.AsString := formatfloat('0.00',
  dm.ADO70SUB_TOTAL.Value+dm.ADO71taxprice_total.Value);
 end;  //�������ط��ŵ�ѭ��
  dm.ADO71.First;
  v_sim_total :=0;
  v_tax_total :=0;
 while not dm.ADO71.Eof do
  begin
   v_sim_total :=v_sim_total+dm.ADO71taxprice_total.Value;
   v_tax_total :=v_tax_total+dm.ADO71tax_total.Value;
   dm.ADO71.Next;
  end;
 edit2.Text := formatfloat('0.00',v_sim_total);
 edit3.Text := formatfloat('0.00',v_tax_total);
 dm.ADO71.First;                    //���»��ܽ��ϼƺ�˰��ϼ�
end;

procedure TForm4.BitBtn1Click(Sender: TObject);
begin
try
 form2 := tform2.Create(application);
 if v_new_type=1 then  self.add_misc_visible();  //�������������ɹ�
 if form2.ShowModal=mrok then
  begin
   if find_supplier(trim(form2.Edit2.Text),strtoint(form2.rkey01.Caption)) then
    begin
     if strtoint(form2.rkey15.Caption)<>dm.ADO70WAREHOUSE_POINTER.Value then
      messagedlg('ͬһ�ɹ�������,�����й�Ӧ����ͬ��������ͬ�Ĳɹ�!',mtinformation,[mbcancel],0)
     else
      if v_new_type = 0 then
       self.add_0071
      else
       self.add_0072;
    end
   else  //��Ӧ����ǰû��������
    begin

     if (form1.if_suplst='Y') and (dm.ADO04.Active=false) then
      dm.ADO04.Open;

     if dm.AQ0015.Active=false then
      begin
       dm.AQ0015.Parameters[0].Value := strtoint(form2.rkey15.Caption);
       dm.AQ0015.Active:=true;            //�򿪹����ɹ�������ʼֵ
      end;

     if tc1.Visible=false then tc1.Visible := true;
      self.add_0070;                      //������������
     if v_new_type=0 then
      self.add_0071   //Ȼ�������ӱ�
     else
      self.add_0072;
     tc1.TabIndex := tc1.Tabs.Count-1;
     if dbedit16.Enabled=true then dbedit16.SetFocus;
     edit4.Text := '0.00';
    end;
  end;
finally
 form2.Free;
end;
end;

procedure TForm4.BitBtn3Click(Sender: TObject);
begin
 popupmenu2.Popup(mouse.CursorPos.x,mouse.CursorPos.y);
end;

procedure TForm4.BitBtn4Click(Sender: TObject);
begin
if tc1.Tabs.Count>0 then
 try
  form11:=tform11.Create(application);
  form11.Caption := '�ɹ�����ע��: '+dm.ADO70PO_NUMBER.Value;
  if v_new_type<>10 then      //���Ǳ༭״̬
   dm.ado0450.Filter := 'file_pointer= '+inttostr(dm.ADO70.RecNo);

  if not dm.ADO0450.IsEmpty then
   form11.Memo1.Text:=dm.ADO0450.FieldValues['memo_text'];

  if form11.ShowModal = mrok then
   begin
 if (dm.ADO0450.IsEmpty) and (trim(form11.Memo1.Text)<>'') then
  begin
   dm.ADO0450.append;
   if v_new_type=10 then
    dm.ADO0450.FieldValues['file_pointer'] := dm.ADO70RKEY.Value
   else
    dm.ADO0450.FieldValues['file_pointer'] := dm.ADO70.RecNo;
   dm.ADO0450.FieldValues['source_type'] := 2070;
   dm.ADO0450.FieldValues['memo_text'] := form11.Memo1.Text;
   dm.ADO0450.Post;
  end
 else
  if (not dm.ADO0450.IsEmpty) and (trim(form11.Memo1.Text)<>'') then
   begin
    dm.ADO0450.Edit;
    dm.ADO0450.FieldValues['memo_text']:=form11.Memo1.Text;
    dm.ADO0450.Post;
   end
  else
   if (not dm.ADO0450.IsEmpty) and (trim(form11.Memo1.Text)='') then
    dm.ADO0450.Delete;
   end;
 finally
  form11.free;
 end;
end;

function tform4.find_supplier(supplier_name:string;curr_ptr:integer):boolean;
var
 i:byte;
begin
 find_supplier := false;
 for i:=1 to tc1.Tabs.Count do
  if comparetext(supplier_name,tc1.Tabs[i-1])=0 then //�����Ӧ���Ѿ�������
   begin
    dm.ADO70.MoveBy(i-dm.ADO70.RecNo);         //����Ҫ��Ӧ����ͬ����Ҫ��
    tc1.TabIndex := i-1;
    if dm.ADO70CURRENCY_PTR.Value = curr_ptr then //������ͬ
     begin
      dm.ADO70.Edit;
      if dm.ADO70PO_TYPE.Value = 'S' then
       dm.ADO71.Filter := 'po_ptr= '+inttostr(dm.ADO70.RecNo)
      else                    //�����빺��0072
       dm.ADO72.Filter := 'poptr= '+inttostr(dm.ADO70.RecNo);
       find_supplier := true;
      break;
     end;
   end;
end;

procedure tform4.add_0070();   //�ֹ�ֱ������PO
var
 i:byte;
begin
 with dm.ADO70 do
  begin    //70������ʼ
   append;
   if form1.if_suplst='Y' then     //�ӿ�����04�ж�ȡ���
    if dm.ADO04SEED_FLAG.Value<>1 then
     dm.ADO70PO_NUMBER.Value := dm.ADO04SEED_VALUE.Value;

   if form2.RadioGroup1.ItemIndex=0 then       //���ڲɹ�
    begin
     if form1.if_suplst='N' then     //���ӿ�����04�ж�ȡ���,��15�ж�ȡ
      dm.ADO70PO_NUMBER.Value := dm.AQ0015purchase_order.Value; //��PO_number��ֵ
     dm.ADO70SHIPTO_ADDRESS.Value := dm.AQ0015ADDRESS_LINE_3.Value;
    end
   else                                                         //����ɹ�
    begin
     if form1.if_suplst='N' then
      dm.ADO70PO_NUMBER.Value := dm.AQ0015o_purchase_order.Value;
     dm.ADO70SHIPTO_ADDRESS.Value := dm.AQ0015o_address_3.Value;  //�ͻ���ַ
    end;

   dm.ADO70STATE_INVT_TAX_FLAG.Value := form2.Label_vmi.caption;  //1VMI�ɹ�
   dm.ADO70EMPLOYEE_POINTER.Value := StrToInt(common.user_ptr);  //2�ɹ���Ա
   dm.ADO70SUPPLIER_POINTER.AsString := form2.rkey23.Caption;     //3��Ӧ��
   dm.ADO70SECOND_WHSE_PTR.Value:=Form2.SECOND_WHSE_PTR; //VMI�۸�ȡ��
   with dm.ADOQuery1 do
    begin
     active := false;
     sql.Clear;           //��������,�绰��ֵ
     sql.Add('select CONTACT_NAME_1,CONTACT_NAME_2,CONTACT_NAME_3,');
     sql.Add('CONTACT_NAME_4,CONTACT_NAME_5,CONTACT_NAME_6,PHONE,');
     sql.Add('discount,discount2,discount_days,discount2_days,payment_terms,');
     sql.Add('tax_id_number,ANALYSIS_CODE1,ANALYSIS_CODE2,fax');
     sql.Add('from data0023 where rkey='+form2.rkey23.Caption);
     active :=true;
     dbCombobox1.Clear;
     for i:=1 to 6 do     //������
      dbcombobox1.Items.Add(fieldbyname('contact_name_'+inttostr(i)).asstring);
     dm.ADO70SUPPIER_CONTACT.Value := fieldbyname('CONTACT_NAME_1').AsString;  //5 �ͻ�������

     dm.ADO70CONTACT_PHONE.Value := trim(fieldbyname('PHONE').AsString)+'/'+
     trim(fieldbyname('fax').AsString); //4�ͻ������˵绰

     dm.ADO70PAYMENT_TERMS.Value := fieldvalues['payment_terms'];  //13 ����������
     dm.ADO70CASH_DISCOUNT.Value := fieldvalues['discount'];      //14 ��������
     dm.ADO70CASH_DISCOUNT2.Value := fieldvalues['discount2'];    //15 ��������
     dm.ADO70DISCOUNT_DAYS.Value := fieldvalues['discount_days']; //16 ��������
     dm.ADO70ANALYSIS_CODE_5.Value := trim(fieldbyname('tax_id_number').AsString);//�����
     dm.ADO70ANALYSIS_CODE_4.Value := trim(fieldbyname('ANALYSIS_CODE1').AsString);//Ʊ������
     dm.ADO70ANALYSIS_CODE_3.Value := trim(fieldbyname('ANALYSIS_CODE2').AsString);//����ص�
    end;

   with dm.ADOQuery1 do
    begin
     active:=false;
     sql.Clear;             //����װ�˵�ַ�е�ֵ
     sql.Add('SELECT Data0024.RKEY,data0024.SHIPPING_LEAD_TIME,factory_location,');
     sql.Add('data0024.state_misc_tax_flag,data0024.state_ship_tax_flag,');
     sql.Add('data0189.state_tax,data0024.shipping_method');
     sql.Add('FROM Data0024,data0189');
     sql.Add('WHERE data0024.city_tax_ptr=data0189.rkey and');
     sql.Add('Data0024.SUPPLIER_PTR ='+form2.rkey23.Caption);
      sql.Add('order by data0024.rkey');
     active:=true;
     dm.ADO70SUPP_FAC_ADD_PTR.Value := FieldValues['rkey'];  //..6��Ӧ��װ�˵�ַ
     dm.ADO70FEDERAL_TAX.Value := FieldValues['state_tax'];  //..7��ֵ˰��
     dm.ADO70STATE_SHIP_TAX_FLAG.Value := FieldValues['STATE_SHIP_TAX_FLAG']; //8װ�˼�˰
     dm.ADO70STATE_MISC_TAX_FLAG.Value := FieldValues['STATE_MISC_TAX_FLAG']; //9�����˰
     dm.ADO70SHIPPING_METHOD.Value := fieldbyname('shipping_method').AsString; //10װ�˷���
    end;
     dm.ADO70WAREHOUSE_POINTER.AsString := form2.rkey15.Caption; //11 ����
     
     if ComboBox1.Items.Count=0 then
     Self.get_approve_type(dm.ADO70WAREHOUSE_POINTER.Value);

     dm.ADO70DISCOUNT2_DAYS.Value := form2.RadioGroup1.ItemIndex; //����/����ɹ�
     dm.ADO70STATUS.Value := 8;                  //12 ״̬δ���
     dm.ADO70PO_DATE.Value := form1.sys_date;    //13 �ɹ���������
     dm.ADO70COLLECT_PREPAID.Value := 'C';                       //18  �󸶿�
     dm.ADO70CURRENCY_PTR.AsString := form2.rkey01.Caption;      //19  ����
     if dm.ADO70CURRENCY_PTR.Value =1 then //�������Ϊ��׼���Ҳ��ܱ༭����
      begin
       dbedit5.ReadOnly:=true;
       dbedit5.Color := cl3dlight;
      end;
    with dm.ADOQuery1 do
     begin
      active:=false;
      sql.Clear;
      sql.Add('select exch_rate,BASE_TO_OTHER from data0001');
      sql.Add('where rkey='+form2.rkey01.Caption);
      active:=true;
      dm.ADO70EXCHANGE_RATE.Value := fieldvalues['BASE_TO_OTHER'];   //.20���һ���
     end;
     dm.ADO70SHIPPING_COST.Value := 0;                           //.21װ�˷�
     dm.ADO70MISC_CHARGE.Value := 0;                             //.22�����
     dm.ADO70PO_TYPE.Value := self.po_type;                      //23po����
     if v_new_type=0 then
      dm.ADO70ANALYSIS_CODE_2.Value := form2.Label17.Caption  //27�������
     else
      dm.ADO70ANALYSIS_CODE_2.Value := trim(form2.edit9.Text);  //28�������
     dm.ADO70SUB_TOTAL.Value := 0;                               //..24 ���ϼ�
     dm.ADO70DISCOUNT_AMOUNT.Value := 0;                         //..25 �۸��ۿۺϼ�
     dm.ADO70PURCHASE_ORDER_TYPE.Value :=1;                      //..26��ʾΪ�ֹ�����
     dm.ADO70.Post;
     if v_new_type=0 then
      dm.ADO71.Filter := 'po_ptr= '+inttostr(dm.ADO70.RecNo)
     else
      dm.ADO72.Filter := 'poptr= '+inttostr(dm.ADO70.RecNo);
     self.change_seed_value(trim(dm.ADO70PO_NUMBER.Value));      //�ı�data0015��PO��ŵĳ�ʼֵ
     dm.ADO70.Edit;
     tc1.Tabs.Add(form2.Edit2.Text);
  end;//70��������
end;

procedure TForm4.TC1Change(Sender: TObject);
var
 i:word;
 v_supp_contact:string;
begin
 dm.ADO70.MoveBy(tc1.TabIndex+1-dm.ADO70.RecNo);   //�ƶ�������¼
 v_supp_contact:=dm.ADO70SUPPIER_CONTACT.Value;
  with dm.ADOQuery1 do
   begin
    active:=false;
    sql.Clear;                      //��������,�绰��ֵ
    sql.Add('select CONTACT_NAME_1,CONTACT_NAME_2,CONTACT_NAME_3,');
    sql.Add('CONTACT_NAME_4,CONTACT_NAME_5,CONTACT_NAME_6');
    sql.Add('from data0023 where rkey='+dm.ADO70SUPPLIER_POINTER.AsString);
    active :=true;
    dbCombobox1.Clear;
    for i:=1 to 6 do                //������
     dbcombobox1.Items.Add(fieldbyname('contact_name_'+inttostr(i)).asstring);
   end;
 if dm.ADO70.State<>dsedit then dm.ADO70.Edit;
  dbcombobox1.Field.Value := v_supp_contact;

  ComboBox1.ItemIndex := ComboBox1.Items.IndexOf(DM.ADO70PURCHASE_TYPE.Value);

 if dbgrid1.Visible=true then       //��׼�ɹ�
  change_sim_tax_total   //�ı��ӱ�˰��ϼ�edit2,edit3
 else
  change72_sim_tax_total;     //�ı������빺��0072���ϼ���˰��ϼ�
  change_tax_total;           //�ı�����������˰�ϼ�
end;                          //ͬʱ�ı����ܼ��ֶε�ֵ

procedure tform4.change_seed_value(po_number:string);
var
 v_last,new_seed:string;
 i,control_no:word;
begin
  control_no := length(po_number);
if form1.if_suplst='Y' then
 begin
 if dm.ADO04SEED_FLAG.Value<>1 then
 begin
  for i := control_no downto 1 do
  if (copy(po_number,i,1)<'0') or (copy(po_number,i,1)>'9') then  //�����������
   begin
    v_last := floattostr(power(10,control_no-1)+strtofloat(copy(po_number,i+1,control_no-i))+1); //��׺��1
    new_seed := copy(po_number,1,i)+copy(v_last,i+1,control_no-i);
    dm.Ado04.Edit; //ʹǰ׺�����׺��1
    dm.ADO04SEED_VALUE.Value := new_seed;
    dm.Ado04.Post;
    break;
   end
  else
   if i=1 then //�����һλ��Ȼ������
    begin
     v_last := floattostr(power(10,control_no)+strtofloat(po_number)+1);
     new_seed := copy(v_last,2,control_no);
     dm.ADO04.Edit;
     dm.ADO04SEED_VALUE.Value := new_seed;
     dm.Ado04.Post;
    end;
 end;
 end
else
  for i := control_no downto 1 do
   if (copy(po_number,i,1)<'0') or (copy(po_number,i,1)>'9') then
    begin
     v_last := floattostr(100000000000000+strtofloat(copy(PO_NUMBER,i+1,control_no-i))+1); //��׺��1
     new_seed := copy(PO_NUMBER,1,i)+copy(v_last,15-(control_no-i)+1,control_no-i);
     dm.AQ0015.edit;
     if dm.ADO70DISCOUNT2_DAYS.Value=0 then
      dm.AQ0015purchase_order.value := new_seed
     else
      dm.AQ0015o_purchase_order.value := new_seed;
     dm.AQ0015.Post;
     break;
    end
   else
    if i=1 then //�����һλ��Ȼ������
     begin
      v_last := floattostr(1000000000000000+strtofloat(PO_NUMBER)+1);
      new_seed := copy(v_last,16-control_no+1,control_no);
      dm.AQ0015.edit;
      if dm.ADO70DISCOUNT2_DAYS.Value=0 then
       dm.AQ0015purchase_order.value := new_seed
      else
       dm.AQ0015o_purchase_order.value := new_seed;
      dm.AQ0015.Post;
     end;
end;

function Power(x, y : extended) : extended;
begin
 result := exp(y*ln(x));
end;

procedure TForm4.DBEdit9KeyPress(Sender: TObject; var Key: Char);
begin
 if (key = chr(46)) then
 if pos('.',dbedit9.Text)>0  //С���㲻���ظ�
  then abort;
end;

procedure tform4.change_tax_total(); //�ı������������õ�˰�ƺϼ�
var
 v_ship_tax,v_misc_tax,misc_base:single;
begin
 v_ship_tax:=0;
 v_misc_tax:=0;
 misc_base:=0;
if dm.ADO70STATE_SHIP_TAX_FLAG.Value='Y' then
 v_ship_tax :=strtofloat(dbedit9.Text)*dm.ADO70FEDERAL_TAX.Value*0.01;
if v_new_type<>10 then //Ϊ����
 dm.ADO200.Filter := 'poptr= '+inttostr(dm.ADO70.RecNo);
if dm.ADO70STATE_MISC_TAX_FLAG.Value='Y' then
 begin
  dm.ado200.First;
  while not dm.ADO200.Eof do
   begin
    if dm.ADO200TAXABLE.Value='Y' then
     misc_base := misc_base+ dm.ADO200AMOUNT.Value;
    dm.ADO200.Next;
   end;
  v_misc_tax := misc_base*dm.ADO70FEDERAL_TAX.Value*0.01;
  dm.ADO200.First;
 end;
edit4.Text := formatfloat('0.00',v_ship_tax+v_misc_tax);

dm.ADO70SUB_TOTAL.AsString :=formatfloat('0.00',
                       strtofloat(edit2.Text)+
                       strtofloat(edit4.Text)+dbedit10.Field.Value+
                       strtofloat(dbedit9.Text));
end;

procedure TForm4.DBEdit9KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key<>9 then //������Tab��
 begin
  if trim(dbedit9.Text)='' then dbedit9.Field.Value:=0;
  change_tax_total;
 end;
end;

procedure TForm4.DBEdit9Click(Sender: TObject);
begin
if dbedit9.Font.Color=clwindowtext then
 begin
  dbedit9.Font.Color:=clblue;
  dbedit9.SelectAll;
 end;
end;

procedure TForm4.DBEdit9Exit(Sender: TObject);
begin
 dbedit9.Font.Color := clwindowtext;
end;

procedure tform4.change_sim_tax_total();
var
 v_sim_total,v_tax_total:single;
begin
 dm.ADO71.Filter := 'po_ptr= '+inttostr(dm.ADO70.RecNo);
 dm.ADO71.First;
 v_sim_total :=0;
 v_tax_total :=0;
 while not dm.ADO71.Eof do
  begin
   v_sim_total :=v_sim_total+dm.ADO71taxprice_total.Value;
   v_tax_total :=v_tax_total+dm.ADO71tax_total.Value;
   dm.ADO71.Next;
  end;
 edit2.Text := formatfloat('0.00',v_sim_total);
 edit3.Text := formatfloat('0.00',v_tax_total);
 dm.ADO71.First;
end;

procedure TForm4.PopupMenu2Popup(Sender: TObject);
begin
 if dm.ADO70.IsEmpty then
  begin
   n4.Enabled := false;
   n5.Enabled := false;
  end
 else
  begin
   n4.Enabled := true;
   n5.Enabled := true;
  end;
end;

procedure TForm4.DBGrid1DblClick(Sender: TObject);
begin
 if not dm.ADO71.IsEmpty then
  n3click(sender);
end;

procedure TForm4.PopupMenu3Popup(Sender: TObject);
begin
 if dm.ADO72.IsEmpty then
  begin
   n7.Enabled := false;
   n8.Enabled := false;
  end
 else
  begin
   n7.Enabled := true;
   if dm.ADO72QUANTITY_RECEIVED.Value>0 then
   n8.Enabled :=false
   else
   n8.Enabled := true;
  end;
end;

procedure tform4.add_0072();
var
 i:byte;
 v_sim_total,v_tax_total:single;
begin
 for i:=1 to strtoint(form2.edit4.Text) do  //��ηż�¼����
  begin
   dm.ADO72.Append;
   if v_new_type=10 then            //����Ǳ༭״̬������
    dm.ADO72POPTR.Value := dm.ADO70RKEY.Value
   else
    dm.ADO72POPTR.Value := dm.ADO70.RecNo;           //POָ��
   dm.ADO72DESCRIPTION.Value := form2.Edit8.Text;    //��Ʒ����
   dm.ADO72DESCRIPTION2.Value := form2.Edit9.Text;   //���
   dm.ADO72GUI_GE.Value := form2.Edit10.Text; //���
   dm.ADO72QUAN_ORD.AsString := form2.Edit6.Text;   //����
   dm.ADO72UNIT_PRICE.AsString := form2.Edit7.Text; //����˰�۸�
   dm.ADO72tax_price.AsString :=form2.Edit13.Text;  //��˰�۸�
   dm.ADO72DEL_DATE.Value :=strtodatetime(form2.MaskEdit1.Text)+(i-1)*strtoint(form2.Edit5.text);
   dm.ADO72UNIT_PTR.Value := strtoint(form2.rkey02.Caption);        //��λ
   dm.ADO72STATE_TAX.AsString := form2.Edit14.Text; //��ֵ˰
   dm.ADO72rohs.Value := form2.ComboBox1.Text;
   dm.ADO72IF_urgency.Value := Form2.CheckBox2.Checked; //�Ƿ��������
   if  Form2.CheckBox3.Checked then   //��ҪIQC���
    dm.ADO72avl_flag.Value :='Y'
   else
    dm.ADO72avl_flag.Value :='N';
   dm.ADO72.Post;
   dm.ADO70SUB_TOTAL.AsString := formatfloat('0.00',
    dm.ADO70SUB_TOTAL.Value+dm.ADO72taxprice_total.Value);
  end;
 dm.ADO72.First;
 v_sim_total :=0;
 v_tax_total :=0;
 while not dm.ADO72.Eof do
  begin
   v_sim_total :=v_sim_total+dm.ADO72taxprice_total.Value;
   v_tax_total :=v_tax_total+dm.ADO72tax_total.Value;
   dm.ADO72.Next;
  end;
 edit2.Text := formatfloat('0.00',v_sim_total);
 edit3.Text := formatfloat('0.00',v_tax_total);
 dm.ADO72.First;        //���»��ܽ��ϼƺ�˰��ϼ�
end;

procedure TForm4.N6Click(Sender: TObject);
begin
try
 form2:=tform2.Create(application);
 self.add_misc_visible();
 form2.add_new_type:=1;
 form2.rkey01.Caption := dm.ADO70CURRENCY_PTR.AsString;
 form2.RadioGroup1.Visible := false;
 form2.edit14.Text:=dm.ADO70FEDERAL_TAX.AsString;
 with dm.ADOQuery1 do
  begin
   active:=false;
   sql.Clear;
   sql.Add('select rkey,code,supplier_name from data0023');
   sql.Add('where rkey='+dm.ADO70SUPPLIER_POINTER.AsString);
   active:=true;
   form2.edit2.Text := fieldvalues['code'];
   form2.Label5.Caption := fieldvalues['supplier_name'];
   form2.rkey23.Caption := dm.ADO70SUPPLIER_POINTER.AsString;
  end;
 with dm.ADOQuery1 do
  begin
   active:=false;
   sql.Clear;
   sql.Add('select rkey,warehouse_code,warehouse_name from data0015');
   sql.Add('where rkey='+dm.ADO70WAREHOUSE_POINTER.AsString);
   active:=true;
   form2.edit3.Text := fieldvalues['warehouse_code'];
   form2.Label6.Caption := fieldvalues['warehouse_name'];
   form2.rkey15.Caption := dm.ADO70WAREHOUSE_POINTER.AsString;
  end;
 if form2.ShowModal = mrok then
  begin
   form4.add_0072;                             //�����ӹ��ɹ���Ŀ
  end;
finally
 form2.free;
end;
end;

procedure TForm4.N8Click(Sender: TObject);
begin
 edit2.Text := formatfloat('0.00',strtofloat(edit2.Text)-dm.ADO72taxprice_total.Value);
 edit3.Text := formatfloat('0.00',strtofloat(edit3.Text)-dm.ADO72tax_total.Value);
 dbedit7.Field.Value := dbedit7.Field.Value-dm.ADO72taxprice_total.Value;
 dm.ADO72.Delete;
end;

procedure tform4.change72_sim_tax_total();
var
 v_sim_total,v_tax_total:single;
begin
 dm.ADO72.Filter := 'poptr= '+inttostr(dm.ADO70.RecNo);
 dm.ADO72.First;
 v_sim_total :=0;
 v_tax_total :=0;
 while not dm.ADO72.Eof do
  begin
   v_sim_total :=v_sim_total+dm.ADO72taxprice_total.Value;
   v_tax_total :=v_tax_total+dm.ADO72tax_total.Value;
   dm.ADO72.Next;
  end;
 dm.ADO72.First;
 edit2.Text := formatfloat('0.00',v_sim_total);
 edit3.Text := formatfloat('0.00',v_tax_total);
end;

procedure TForm4.N7Click(Sender: TObject);   //�༭
 var
 v_total,v_tax:real;
begin
try
 form10:=tform10.Create(application);
 v_total := dm.ADO72taxprice_total.Value;
 v_tax := dm.ADO72tax_total.Value;
 form10.MaskEdit1.Text := dm.ADO72del_DATE.AsString;
 dm.ADO72.Edit;
 if form10.ShowModal=mrok then
  begin
   dm.ADO72del_DATE.AsString:=form10.MaskEdit1.Text;
   edit2.text := formatfloat('0.00',strtofloat(edit2.Text)-v_total+dm.ADO72taxprice_total.Value);
   edit3.Text := formatfloat('0.00',strtofloat(edit3.Text)-v_tax+dm.ADO72tax_total.Value);
   dbedit7.Field.Value := dbedit7.Field.Value-v_total+dm.ADO72taxprice_total.Value;
   dm.ADO72.Post;
  end;
finally
 form10.free;
end;
end;

procedure TForm4.N4Click(Sender: TObject);
begin
 save_cate_note(dm.ADO7011,70,'�ɹ��������±�: ');
end;

procedure TForm4.N5Click(Sender: TObject);
begin
 save_cate_note(dm.ADO107011,1070,'�ɹ������������±�: ');
end;

procedure TForm4.save_cate_note(adoquery:TADOQuery;source_type:integer;var_caption:string);
var
 i:word;
begin
 try
  edit_note:=tedit_note.Create(application);
  edit_note.Caption := var_caption+dm.ADO70PO_NUMBER.Value;
  if v_new_type<>10 then            //������Ǳ༭״̬  (�������ߵ�������)
   adoquery.Filter := 'file_pointer= '+inttostr(dm.ADO70.RecNo);
  if not adoquery.IsEmpty then
   for i:=1 to 4 do
    if adoquery.fieldbyname('note_pad_line_'+inttostr(i)).AsString <> '' then
    edit_note.Memo1.Lines.Add(adoquery.fieldbyname('note_pad_line_'+inttostr(i)).AsString);
 if edit_note.ShowModal=mrok then
  begin
   if (not adoquery.IsEmpty) and (trim(edit_note.Memo1.Text)<>'') then
    begin //ԭ��¼�м��±�
     adoquery.Edit;
     for i:=1 to 4 do
      if edit_note.Memo1.Lines.Count>=i then
       ADOquery.fieldbyname('note_pad_line_'+inttostr(i)).asstring:=edit_note.Memo1.Lines[i-1]
      else
       ADOquery.fieldbyname('note_pad_line_'+inttostr(i)).asstring:='';
      ADOquery.Post;
    end
   else
    if (not ADOquery.IsEmpty) and (trim(edit_note.Memo1.Text)='') then
     ADOquery.Delete   //���ԭ��¼�м��±�����ɾ����
    else
     if (ADOquery.IsEmpty) and (trim(edit_note.Memo1.Text)<>'') then
      begin    //���ԭ��¼û�м��±����������˼��±�
       ADOquery.Append;
       if v_new_type=10 then
        ADOquery.fieldvalues['file_pointer'] := dm.ADO70RKEY.Value
       else
        ADOquery.fieldvalues['file_pointer'] := dm.ADO70.RecNo;
       ADOquery.Fieldvalues['source_type']:=source_type;
       for i:=1 to edit_note.Memo1.Lines.Count do
       ADOquery.fieldbyname('note_pad_line_'+inttostr(i)).asstring:=edit_note.memo1.lines[i-1];
       ADOquery.Post;
      end;
  end;
 finally
  edit_note.free;
 end;
end;

procedure TForm4.DBEdit11Click(Sender: TObject);
begin
if dbedit11.Font.Color=clwindowtext then
 begin
  dbedit11.Font.Color:=clnone;
  dbedit11.SelectAll;
 end;
end;

procedure TForm4.DBEdit11Exit(Sender: TObject);
begin
if trim(dbedit11.Text)='' then dbedit11.Field.Value:='0';
 dbedit11.Font.Color := clwindowtext;
end;

procedure TForm4.DBEdit13Click(Sender: TObject);
begin
if dbedit13.Font.Color=clwindowtext then
 begin
  dbedit13.Font.Color:=clnone;
  dbedit13.SelectAll;
 end;
end;

procedure TForm4.DBEdit12Exit(Sender: TObject);
begin
if trim(dbedit12.Text)='' then dbedit12.Field.Value:='0';
 dbedit12.Font.Color := clwindowtext;
end;

procedure TForm4.DBEdit12Click(Sender: TObject);
begin
if dbedit12.Font.Color=clwindowtext then
 begin
  dbedit12.Font.Color:=clnone;
  dbedit12.SelectAll;
 end;
end;

procedure TForm4.DBEdit15Exit(Sender: TObject);
begin
if trim(dbedit15.Text)='' then dbedit15.Field.Value:='0';
 dbedit15.Font.Color := clwindowtext;
end;

procedure TForm4.DBEdit15Click(Sender: TObject);
begin
if dbedit15.Font.Color=clwindowtext then
 begin
  dbedit15.Font.Color:=clnone;
  dbedit15.SelectAll;
 end;
end;

procedure TForm4.BitBtn2Enter(Sender: TObject);
begin
 if tc1.Tabs.Count=0 then
  begin
   messagedlg('û�����ݲ��ܱ��棡',mterror,[mbcancel],0);
   bitbtn5.SetFocus;
   exit;
  end;
end;

function tform4.find_po_error():boolean;
var
 popo_number:array of string;
 bk:tbookmark;
 i,j:byte;
 v_error:boolean;
begin
 find_po_error:=false; //��ʼ��ʶΪû�д���
 v_error:=false;
 setlength(popo_number,dm.ADO70.RecordCount);//���������±����
 bk:=dm.ADO70.GetBookmark();
 dm.ADO70.First;
//==============================================================================
 while not dm.ADO70.Eof do
  begin
   if trim(dm.ADO70PURCHASE_TYPE.Value)='' then  //����½�PO�����������Ƿ�Ϊ��
    begin
     messagedlg('��'+inttostr(dm.ADO70.RecNo)+'���ɹ������������Ͳ���Ϊ��',mterror,[mbcancel],0);
     dm.ADO70.GotoBookmark(bk);
     find_po_error := true;
     v_error := true;
     break;
    end;
   if trim(dm.ADO70PO_NUMBER.Value)='' then
    begin
     messagedlg('��'+inttostr(dm.ADO70.RecNo)+'���ɹ��������벻��Ϊ��',mterror,[mbcancel],0);
     dm.ADO70.GotoBookmark(bk);
     find_po_error := true;
     v_error := true;
     break;
    end
   else
    with dm.ADOQuery1 do
     begin
      active:=false;
      sql.Clear;
      sql.Add('select rkey from data0070 where po_number='''+dm.ADO70PO_NUMBER.Value+'''');
      active:=true;
      if not isempty then
       begin
        messagedlg('��'+inttostr(dm.ADO70.RecNo)+'���ɹ����������ظ�',mterror,[mbcancel],0);
        dm.ADO70.GotoBookmark(bk);
        find_po_error := true;
        v_error := true;
        break;
       end
      else
       popo_number[dm.ado70.RecNo-1]:=dm.ADO70PO_NUMBER.Value;
     end;
   dm.ADO70.Next;
  end;
//=====================================================================================
 dm.ADO70.FreeBookmark(bk);
if (v_error = false) and (dm.ADO70.RecordCount>=2) then
for i:=0 to dm.ADO70.RecordCount-2 do  //����ڲ������Ƿ��ظ�
 for j:=i+1 to dm.ADO70.RecordCount-1 do
  if popo_number[i]=popo_number[j] then
   begin
    messagedlg('��'+inttostr(i+1)+'���ɹ�����������'+inttostr(j+1)+'���ظ�',mterror,[mbcancel],0);
    find_po_error:=true;
    break;
   end;
end;

procedure tform4.append_0070();  //��������ʱ����PO
var
 i:byte;
begin
 with dm.ADO70 do
  begin                //70������ʼ
   append;
   po_value;           //��PO_number��ֵ
   dm.ADO70EMPLOYEE_POINTER.AsString:= common.user_ptr;  //2Ա��
   dm.ADO70PO_TYPE.Value :=form_req.ADOQuery1FLAG.value;  //��׼��������

   if (form_req.ADOQuery1FLAG.value = 'S')  then
    begin
     dm.ADO70SUPPLIER_POINTER.Value := dm.ADO0069SUPP_PTR.Value;   //3��Ӧ��
     dm.ADO70CURRENCY_PTR.Value := dm.ADO0069PO_LINK_PTR.Value;    //5����
     dm.ADO70EXCHANGE_RATE.Value := dm.ado0069BASE_TO_OTHER.Value;//.20���һ���
     dm.ADO70DISCOUNT2_DAYS.Value := dm.ADO0069o_i_flag.Value;    //������ڲɹ�
     dm.ADO70ANALYSIS_CODE_2.Value:= self.invtory_type(dm.ADO0069INVT_PTR.AsString);//�������
     tc1.Tabs.Add(trim(dm.ADO0069code.Value));
    end
   else
    begin
     dm.ADO70SUPPLIER_POINTER.Value := dm.ADO0204SUPPLIER_PTR.Value;  //��Ӧ��
     dm.ADO70CURRENCY_PTR.Value := dm.ADO0204PO_LINK_PTR.Value;      //19 ����
     dm.ADO70EXCHANGE_RATE.Value := dm.ADO0204BASE_TO_OTHER.Value;  //.20���һ���
     dm.ADO70DISCOUNT2_DAYS.Value := dm.ADO0204o_i_flag.Value;      //������ڲɹ�
     dm.ADO70ANALYSIS_CODE_2.Value:= dm.ADO0204DESCRIPTION_2.Value; //�������
     tc1.Tabs.Add(trim(dm.ADO0204code.Value));
    end;
   with dm.ADOQuery1 do//��������,�绰��ֵ,�������Ʊ�����࣬����ص�
    begin
     active:=false;
     sql.Clear;
     sql.Add('select CONTACT_NAME_1,CONTACT_NAME_2,CONTACT_NAME_3,');
     sql.Add('CONTACT_NAME_4,CONTACT_NAME_5,CONTACT_NAME_6,EDI_OUT_NEW_PO,');
     sql.Add('discount,discount2,discount_days,discount2_days,payment_terms,');
     sql.Add('PHONE,fax,TAX_ID_NUMBER,ANALYSIS_CODE1,ANALYSIS_CODE2,EDI_FLAG_FOR_PO');
     sql.Add('from data0023 where rkey='+dm.ADO70SUPPLIER_POINTER.AsString);
     active :=true;
     dbCombobox1.Clear;
     for i:=1 to 6 do     //������
      dbcombobox1.Items.Add(fieldbyname('contact_name_'+inttostr(i)).asstring);
     dm.ADO70SUPPIER_CONTACT.Value := fieldbyname('CONTACT_NAME_1').AsString; //5 �ͻ�������
     dm.ADO70CONTACT_PHONE.Value := trim(fieldbyname('PHONE').AsString)+'/'+
     trim(fieldbyname('fax').AsString); //4�ͻ������˵绰
     dm.ADO70PAYMENT_TERMS.Value := fieldvalues['payment_terms'];         //13 ����������
     dm.ADO70CASH_DISCOUNT.Value := fieldvalues['discount'];      //14 ��������
     dm.ADO70CASH_DISCOUNT2.Value := fieldvalues['discount2'];    //15 ��������
     dm.ADO70DISCOUNT_DAYS.Value := fieldvalues['discount_days']; //16 ��������
     dm.ADO70ANALYSIS_CODE_5.Value :=trim(fieldbyname('tax_id_number').AsString); //�����
     dm.ADO70ANALYSIS_CODE_4.Value :=trim(fieldbyname('ANALYSIS_CODE1').AsString);//Ʊ������
     dm.ADO70ANALYSIS_CODE_3.Value :=trim(fieldbyname('ANALYSIS_CODE2').AsString);//����ص�
     if dm.ADO70PO_TYPE.Value='S' then
     if fieldbyname('EDI_OUT_NEW_PO').AsInteger=0 then
      dm.ADO70STATE_INVT_TAX_FLAG.Value:='N'
     else
      dm.ADO70STATE_INVT_TAX_FLAG.Value:='Y';  //VMI�ɹ�  ����ΪVMI���۸�ȡ��
     dm.ADO70SECOND_WHSE_PTR.Value:= fieldbyname('EDI_FLAG_FOR_PO').AsInteger;
    end;
   with dm.ADOQuery1 do//����װ�˵�ַ�е�ֵ
    begin
     active:=false;
     sql.Clear;
     sql.Add('SELECT Data0024.RKEY,data0024.SHIPPING_LEAD_TIME,factory_location,');
     sql.Add('data0024.state_misc_tax_flag,data0024.state_ship_tax_flag,');
     sql.Add('data0189.state_tax,shipping_method');
     sql.Add('FROM Data0024,data0189');
     sql.Add('WHERE data0024.city_tax_ptr=data0189.rkey and');
     sql.Add('Data0024.SUPPLIER_PTR ='+dm.ADO70SUPPLIER_POINTER.AsString);
     active:=true;
     dm.ADO70SUPP_FAC_ADD_PTR.Value := FieldValues['rkey'];  //..6��Ӧ��װ�˵�ַ
     dm.ADO70FEDERAL_TAX.Value := FieldValues['state_tax'];  //..7��ֵ˰��
     dm.ADO70STATE_SHIP_TAX_FLAG.Value := FieldValues['STATE_SHIP_TAX_FLAG']; //8װ�˼�˰
     dm.ADO70STATE_MISC_TAX_FLAG.Value := FieldValues['STATE_MISC_TAX_FLAG']; //9�����˰
     dm.ADO70SHIPPING_METHOD.Value := fieldbyname('shipping_method').AsString;
    end;
     dm.ADO70WAREHOUSE_POINTER.value :=form_req.adoquery1WHSE_PTR.Value; //10 ����
     if ComboBox1.Items.Count=0 then
     Self.get_approve_type(dm.ADO70WAREHOUSE_POINTER.Value);  //�õ���������
     dm.ADO70STATUS.Value := 8;                            //11  ״̬δ���
     dm.ADO70PO_DATE.Value := form1.sys_date;               //12  �ɹ��������ڶ̸�ʽ
     dm.ADO70COLLECT_PREPAID.Value := 'C';                 //13  �󸶿�
     if dm.ADO70CURRENCY_PTR.Value =1 then
      begin
       dbedit5.ReadOnly:=true;
       dbedit5.Color := cl3dlight;  //�������Ϊ��׼���Ҳ��ܱ༭����
      end;
     dm.ADO70SHIPPING_COST.Value := 0;                          //.21װ�˷�
     dm.ADO70MISC_CHARGE.Value := 0;                            //.22�����
     dm.ADO70SUB_TOTAL.Value := 0;                              //..24 ���ϼ�
     dm.ADO70DISCOUNT_AMOUNT.Value := 0;                        //..25 �۸��ۿۺϼ�
     dm.ADO70FOB.Value :=form_req.ADOQuery1PO_REQ_NUMBER.Value; //..25�빺���030327�޸�
     dm.ADO70PO_REV_NO.Value := form_req.ADOQuery1DEPARTMENT_NAME.Value; //�빺����
     dm.ADO70ANALYSIS_CODE_1.Value := trim(form_req.ADOQuery1EMPLOYEE_NAME.Value);
     dm.ADO70PURCHASE_ORDER_TYPE.Value :=0;             //�빺��Ա�͵�������
     dm.ADO70.Post;
     if (dm.ADO70PO_TYPE.Value='S') then
      dm.ADO71.Filter := 'po_ptr= '+inttostr(dm.ADO70.RecNo)
     else
      dm.ADO72.Filter := 'poptr= '+inttostr(dm.ADO70.RecNo);
      self.change_seed_value(trim(dm.ADO70PO_NUMBER.Value));   //�ı�data0015��PO��ŵĳ�ʼֵ
     dm.ADO70.Edit;

    with dm.ADOQuery2 do
     begin
      close;
      SQL.Clear;
      sql.Add('select * from data0011 where source_type=68');
      sql.Add('and FILE_POINTER='+form_req.ADOQuery1RKEY.AsString);
      open;
     end;
    if not dm.ADOQuery2.IsEmpty then
     with dm.ADO7011 do
      begin
       append;
       fieldvalues['file_pointer'] := dm.ADO70.RecNo;
       Fieldvalues['source_type']:=70;
       for i:=1 to 4 do
        fieldvalues['note_pad_line_'+inttostr(i)]:=dm.ADOQuery2.FieldValues['note_pad_line_'+inttostr(i)];
       Post;
      end;
   end;                    //70��������
end;

procedure tform4.append_0071(); //��������ʱ������׼�ɹ���Ŀ
//var
// v_sim_total,v_tax_total:single;
begin
 dm.ADO71.Append;
 dm.ADO71PO_PTR.Value := dm.ADO70.RecNo;               //POָ��
 dm.ADO71INVT_PTR.Value := dm.ADO0069INVT_PTR.Value;   //����ָ��
 dm.ADO71QUAN_ORD.Value := dm.ADO0069QUANTITY.Value;   //����
 dm.ADO71REQ_DATE.Value := dm.ADO0069reply_date.Value; //����������װ������
 dm.ADO71PURCHASE_UNIT_PTR.Value := dm.ADO0069UNIT_PTR.Value; //�ɹ���λ
 dm.ADO71PRICE.Value := dm.ADO0069UNIT_PRICE.Value;    //����˰�۸�
 dm.ADO71tax_price.Value := dm.ADO0069tax_price.Value; //��˰��
 dm.ADO71TAX_2.Value := dm.ADO0069tax.Value;           //˰��
 dm.ADO71CONVERSION_FACTOR.Value := dm.ADO0069CONVERSION_FACTOR.Value; //ת����
 dm.ADO71reason.Value := dm.ADO0069reason.Value;       //�빺ԭ��
 dm.ADO71extra_req.Value := dm.ADO0069extra_req.Value; //�ر�Ҫ��
 dm.ado71avl_flag.value := dm.ado0069avl_flag.value;   //�Ƿ���Ҫ���ϼ��
 dm.ADO71rohs.Value:=dm.ADO0069rohs.Value;             //������ʶ
 dm.ADO71WO_PTR.Value:=dm.ADO0069req_unit_ptr.Value;   //�����λ
 dm.ADO71IF_CAF.Value:=dm.ADO0069IF_CAF.Value; //caf
 dm.ado71rkey69.Value:=dm.ADO0069RKEY.Value;  //�빺��ϸ�⽡
 dm.ADO71IF_urgency.Value := dm.ADO0069IF_urgency.Value; //�Ƿ��������
 dm.ADO71ORIG_ABBRNAME.AsVariant := dm.ADO0069ORIG_ABBRNAME.AsVariant; //Ʒ�ƹ�Ӧ��
 dm.ADO71.Post;

 dm.ADO70SUB_TOTAL.AsString := formatfloat('0.00',
   dm.ADO70SUB_TOTAL.Value+dm.ADO71taxprice_total.Value);

{ dm.ADO71.First;
  v_sim_total :=0;
  v_tax_total :=0;
  while not dm.ADO71.Eof do
   begin
    v_sim_total :=v_sim_total+dm.ADO71taxprice_total.Value;
    v_tax_total :=v_tax_total+dm.ADO71tax_total.Value;
    dm.ADO71.Next;
   end; }
  edit2.Text := formatfloat('0.00',StrToCurr(edit2.Text)+dm.ADO71taxprice_total.Value);
  edit3.Text := formatfloat('0.00',StrToCurr(edit3.Text)+dm.ADO71tax_total.Value);
 // dm.ADO71.First;        //���»��ܽ��ϼƺ�˰��ϼ�
end;

procedure tform4.append_0072(); //��������ʱ�����������
//var
// v_sim_total,v_tax_total:single;
begin
   dm.ADO72.Append;
   dm.ADO72POPTR.Value := dm.ADO70.RecNo;                        //POָ��
   dm.ADO72DESCRIPTION.Value := dm.ADO0204DESCRIPTION_1.Value;   //��Ʒ����
   dm.ADO72GUI_GE.Value := dm.ADO0204GUI_GE.Value;               //��Ʒ���
   dm.ADO72DESCRIPTION2.Value := dm.ADO0204DESCRIPTION_2.Value;  //���
   dm.ADO72QUAN_ORD.Value := dm.ADO0204QUANTITY_REQUIRED.Value;  //����
   dm.ADO72UNIT_PRICE.Value := dm.ADO0204UNIT_PRICE.Value;       //�۸�
   dm.ADO72DEL_DATE.Value := dm.ADO0204reply_date.Value;         //��������
   dm.ADO72UNIT_PTR.Value := dm.ADO0204G_L_PTR.value;            //�ɹ���λ
   dm.ADO72STATE_TAX.Value := dm.ADO0204tax.Value;               //��ֵ˰
   DM.ADO72tax_price.Value :=DM.ADO0204tax_price.Value;          //��˰��
   dm.ADO72rohs.Value := dm.ADO0204rohs.Value;  //������ʶ
   dm.ADO72reason.Value := dm.ADO0204reason.Value;
   dm.ADO72rkey204.Value:= dm.ADO0204RKEY.Value; //�빺��ϸ�⽡
   dm.ADO72IF_urgency.Value := dm.ADO0204IF_urgency.Value; //�Ƿ��������
   dm.ADO72.Post;

   dm.ADO70SUB_TOTAL.AsString := formatfloat('0.00',
    dm.ADO70SUB_TOTAL.Value+dm.ADO72taxprice_total.Value);
{ dm.ADO72.First;
 v_sim_total :=0;
 v_tax_total :=0;
 while not dm.ADO72.Eof do
  begin
   v_sim_total :=v_sim_total+dm.ADO72taxprice_total.Value;
   v_tax_total :=v_tax_total+dm.ADO72tax_total.Value;
   dm.ADO72.Next;
  end;
 edit2.Text := formatfloat('0.00',v_sim_total);
 edit3.Text := formatfloat('0.00',v_tax_total);
 dm.ADO72.First;        //���»��ܽ��ϼƺ�˰��ϼ�
 }
  edit2.Text := formatfloat('0.00',StrToCurr(edit2.Text)+dm.ADO72taxprice_total.Value);
  edit3.Text := formatfloat('0.00',StrToCurr(edit3.Text)+dm.ADO72tax_total.Value);

end;

procedure TForm4.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 dm.ADO200.Close;
 dm.ado7011.Close;
 dm.ado107011.Close;
 dm.ado0450.Close;
 if dm.AQ71.Active then dm.AQ71.Close;
 if dm.AQ72.Active then dm.AQ72.Close;
 if dm.AQ0015.Active = true then dm.AQ0015.Close;
 if dbgrid1.Visible = true then
  begin
   dm.ADO71.Filter := '';
   dm.ADO71.Close;
  end
 else
  begin
   if dm.AQ72.Active = true then
    begin
     dm.ADO72.Filter := '';
     dm.ADO72.Close;
    end; 
  end;
 if dm.ADOConnection1.InTransaction then dm.ADOConnection1.RollbackTrans; 
end;

procedure TForm4.DBGrid2DblClick(Sender: TObject);
begin
 if not dm.ADO72.IsEmpty then n7click(sender);
end;

procedure TForm4.change_data0070(rkey70:integer);
begin
 if dm.AQ0070PAYMENT_TERMS.Value<>dm.ADO70PAYMENT_TERMS.Value then
  with dm.ADO0339 do
   begin
    active:=false;
    Parameters.ParamValues['po_ptr'] := rkey70;
    Parameters.ParamValues['edit_empl_ptr'] := dm.ADO70EDIT_BY_EMPL_PTR.Value;
    Parameters.ParamValues['tran_type'] := 4;
    Parameters.ParamValues['tran_desc'] := '�������������������Ѹ�';
    Parameters.ParamValues['tran_from'] := dm.AQ0070PAYMENT_TERMS.AsString;
    Parameters.ParamValues['tran_to'] := dm.ADO70PAYMENT_TERMS.AsString;
    Parameters.ParamValues['data0071_ptr'] := null;
    Parameters.ParamValues['data0072_ptr'] := null;
    ExecSQL;
   end;
 if dm.AQ0070SUPP_FAC_ADD_PTR.Value<>dm.ADO70SUPP_FAC_ADD_PTR.Value then
  with dm.ADO0339 do
   begin
    active:=false;
    Parameters.ParamValues['po_ptr'] := rkey70;
    Parameters.ParamValues['edit_empl_ptr'] := dm.ADO70EDIT_BY_EMPL_PTR.Value;
    Parameters.ParamValues['tran_type'] := 5;
    Parameters.ParamValues['tran_desc'] := 'װ�˵ص��Ѹ�';
    Parameters.ParamValues['tran_from'] := dm.AQ0070SUPP_FAC_ADD_PTR.AsString;
    Parameters.ParamValues['tran_to'] := dm.ADO70SUPP_FAC_ADD_PTR.AsString;
    Parameters.ParamValues['data0071_ptr'] := null;
    Parameters.ParamValues['data0072_ptr'] := null;
    ExecSQL;
   end;
 if dm.AQ0070MISC_CHARGE.Value<>dm.ADO70MISC_CHARGE.Value then
  with dm.ADO0339 do
   begin
    active:=false;
    Parameters.ParamValues['po_ptr'] := rkey70;
    Parameters.ParamValues['edit_empl_ptr'] := dm.ADO70EDIT_BY_EMPL_PTR.Value;
    Parameters.ParamValues['tran_type'] := 8;
    Parameters.ParamValues['tran_desc'] := '�����շ��Ѹ�';
    Parameters.ParamValues['tran_from'] := dm.AQ0070MISC_CHARGE.AsString;
    Parameters.ParamValues['tran_to'] := dm.ADO70MISC_CHARGE.AsString;
    Parameters.ParamValues['data0071_ptr'] := null;
    Parameters.ParamValues['data0072_ptr'] := null;
    ExecSQL;
   end;
 if dm.AQ0070shipping_cost.Value<>dm.ADO70SHIPPING_COST.Value then
  with dm.ADO0339 do
   begin
    active:=false;
    Parameters.ParamValues['po_ptr'] := rkey70;
    Parameters.ParamValues['edit_empl_ptr'] := dm.ADO70EDIT_BY_EMPL_PTR.Value;
    Parameters.ParamValues['tran_type'] := 9;
    Parameters.ParamValues['tran_desc'] := 'װ�˷����Ѹ�';
    Parameters.ParamValues['tran_from'] := dm.AQ0070shipping_cost.AsString;
    Parameters.ParamValues['tran_to'] := dm.ADO70SHIPPING_COST.AsString;
    Parameters.ParamValues['data0071_ptr'] := null;
    Parameters.ParamValues['data0072_ptr'] := null;
    ExecSQL;
   end;

 if dm.AQ0070sub_total.Value<>dm.ADO70sub_total.Value then
 with dm.ASP362 do
  begin
   close;
   Parameters[1].Value:=dm.aq0070fob.value;
   open;
   if not isempty then
    begin
     edit;
     fieldvalues['used_period_'+inttostr(dm.ASP362v_month.Value)]:=
     formatfloat('0.00',fieldvalues['used_period_'+inttostr(dm.ASP362v_month.Value)]+
     (dm.ADO70SUB_TOTAL.Value-dm.aq0070sub_total.value)*dm.Aq0070EXCHANGE_RATE.Value);
     post;
    end;
   Close;
  end;
end;

procedure TForm4.change_data0071(rkey70:integer);
var
 search_option:tlocateoptions;
begin
 search_option := [lopartialkey];
 dm.ADO71.First;
 while not dm.ADO71.Eof do
  begin
   if dm.aq71.Locate('rkey',dm.ADO71RKEY.value,search_option) then
    begin     //����Щ�ֶα��޸�
     if dm.AQ71REQ_DATE.Value<>dm.ADO71REQ_DATE.Value then
      with dm.ADO0339 do
       begin
        active:=false;
        Parameters.ParamValues['po_ptr'] := rkey70;
        Parameters.ParamValues['edit_empl_ptr'] := dm.ADO70EDIT_BY_EMPL_PTR.Value;
        Parameters.ParamValues['tran_type'] := 1;
        Parameters.ParamValues['tran_desc'] := '�ɹ���ĿҪ�󵽻������Ѹ�';
        Parameters.ParamValues['tran_from'] := dm.AQ71REQ_DATE.AsString;
        Parameters.ParamValues['tran_to'] := dm.ADO71REQ_DATE.AsString;
        Parameters.ParamValues['data0071_ptr'] := dm.ADO71RKEY.Value;
        Parameters.ParamValues['data0072_ptr'] := null;
        ExecSQL;
       end;
     if dm.AQ71QUAN_ORD.Value<>dm.ADO71QUAN_ORD.Value then
      with dm.ADO0339 do
       begin
        active:=false;
        Parameters.ParamValues['po_ptr'] := rkey70;
        Parameters.ParamValues['edit_empl_ptr'] := dm.ADO70EDIT_BY_EMPL_PTR.Value;
        Parameters.ParamValues['tran_type'] := 2;
        Parameters.ParamValues['tran_desc'] := '�ɹ���Ŀ���������Ѹ�';
        Parameters.ParamValues['tran_from'] := dm.AQ71quan_ord.AsString;
        Parameters.ParamValues['tran_to'] := dm.ADO71quan_ord.AsString;
        Parameters.ParamValues['data0071_ptr'] := dm.ADO71RKEY.Value;
        Parameters.ParamValues['data0072_ptr'] := null;
        ExecSQL;
       end;
     if dm.AQ71PRICE.Value<>dm.ADO71price.Value then
      with dm.ADO0339 do
       begin
        active:=false;
        Parameters.ParamValues['po_ptr'] := rkey70;
        Parameters.ParamValues['edit_empl_ptr'] := dm.ADO70EDIT_BY_EMPL_PTR.Value;
        Parameters.ParamValues['tran_type'] := 3;
        Parameters.ParamValues['tran_desc'] := '�ɹ���Ŀ�����Ѹ�';
        Parameters.ParamValues['tran_from'] := dm.AQ71price.AsString;
        Parameters.ParamValues['tran_to'] := dm.ADO71price.AsString;
        Parameters.ParamValues['data0071_ptr'] := dm.ADO71RKEY.Value;
        Parameters.ParamValues['data0072_ptr'] := null;
        ExecSQL;
       end;
    end
   else //��ԭ�ɹ�����û�����۾��������Ĳɹ���Ŀ
    with dm.ADO0339 do
     begin
      active:=false;
      Parameters.ParamValues['po_ptr'] := rkey70;
      Parameters.ParamValues['edit_empl_ptr'] := dm.ADO70EDIT_BY_EMPL_PTR.Value;
      Parameters.ParamValues['tran_type'] := 6;
      Parameters.ParamValues['tran_desc'] := '����һ����׼�ɹ���Ŀ';
      Parameters.ParamValues['tran_from'] := null;
      Parameters.ParamValues['tran_to'] := null;
      Parameters.ParamValues['data0071_ptr'] := dm.ADO71RKEY.Value;
      Parameters.ParamValues['data0072_ptr'] := null;
      ExecSQL;
     end;

   dm.ADO71.Next;
  end;

 dm.ADO71.First;
 dm.AQ71.First;
 while not dm.AQ71.Eof do
  begin
   if not dm.ADO71.Locate('rkey',dm.Aq71RKEY.value,search_option) then
    with dm.ADO0339 do
     begin
      active:=false;
      Parameters.ParamValues['po_ptr'] := rkey70;
      Parameters.ParamValues['edit_empl_ptr'] := dm.ADO70EDIT_BY_EMPL_PTR.Value;
      Parameters.ParamValues['tran_type'] := 7;
      Parameters.ParamValues['tran_desc'] := 'ɾ����һ����׼�ɹ���Ŀ';
      Parameters.ParamValues['tran_from'] := null;
      Parameters.ParamValues['tran_to'] := null;
      Parameters.ParamValues['data0071_ptr'] := dm.aq71RKEY.Value;
      Parameters.ParamValues['data0072_ptr'] := null;
      ExecSQL;
     end;
   dm.AQ71.Next;
  end;
 dm.ADO71.First;
end;

procedure TForm4.change_data0072(rkey70:integer);
var
 search_option:tlocateoptions;
begin
 search_option := [lopartialkey];
 dm.ADO72.First;
 while not dm.ADO72.Eof do
  begin
   if dm.aq72.Locate('rkey',dm.ADO72RKEY.value,search_option) then
    begin     //����Щ�ֶα��޸�
      if dm.AQ72DEL_DATE.Value <> dm.ADO72DEL_DATE.Value then
      with dm.ADO0339 do
       begin
        active:=false;
        Parameters.ParamValues['po_ptr'] := rkey70;
        Parameters.ParamValues['edit_empl_ptr'] := dm.ADO70EDIT_BY_EMPL_PTR.Value;
        Parameters.ParamValues['tran_type'] := 1;
        Parameters.ParamValues['tran_desc'] := '����ɹ���ĿҪ�󵽻������Ѹ�';
        Parameters.ParamValues['tran_from'] := dm.AQ72del_DATE.AsString;
        Parameters.ParamValues['tran_to'] := dm.ADO72del_DATE.AsString;
        Parameters.ParamValues['data0071_ptr'] := null;
        Parameters.ParamValues['data0072_ptr'] := dm.ADO72RKEY.Value;
        ExecSQL;
       end;
     if dm.AQ72QUAN_ORD.Value<>dm.ADO72QUAN_ORD.Value then
      with dm.ADO0339 do
       begin
        active:=false;
        Parameters.ParamValues['po_ptr'] := rkey70;
        Parameters.ParamValues['edit_empl_ptr'] := dm.ADO70EDIT_BY_EMPL_PTR.Value;
        Parameters.ParamValues['tran_type'] := 2;
        Parameters.ParamValues['tran_desc'] := '����ɹ���Ŀ���������Ѹ�';
        Parameters.ParamValues['tran_from'] := dm.AQ72quan_ord.AsString;
        Parameters.ParamValues['tran_to'] := dm.ADO72quan_ord.AsString;
        Parameters.ParamValues['data0071_ptr'] := null;
        Parameters.ParamValues['data0072_ptr'] := dm.ADO72RKEY.Value;
        ExecSQL;
       end;
     if dm.AQ72UNIT_PRICE.value<>dm.ADO72UNIT_PRICE.Value then
      with dm.ADO0339 do
       begin
        active:=false;
        Parameters.ParamValues['po_ptr'] := rkey70;
        Parameters.ParamValues['edit_empl_ptr'] := dm.ADO70EDIT_BY_EMPL_PTR.Value;
        Parameters.ParamValues['tran_type'] := 3;
        Parameters.ParamValues['tran_desc'] := '����ɹ���Ŀ�����Ѹ�';
        Parameters.ParamValues['tran_from'] := dm.AQ72unit_price.AsString;
        Parameters.ParamValues['tran_to'] := dm.ADO72unit_price.AsString;
        Parameters.ParamValues['data0071_ptr'] := null;
        Parameters.ParamValues['data0072_ptr'] := dm.ADO72RKEY.Value;
        ExecSQL;
       end;
    end
   else //��ԭ�ɹ�����û�����۾��������Ĳɹ���Ŀ
    with dm.ADO0339 do
     begin
      active:=false;
      Parameters.ParamValues['po_ptr'] := rkey70;
      Parameters.ParamValues['edit_empl_ptr'] := dm.ADO70EDIT_BY_EMPL_PTR.Value;
      Parameters.ParamValues['tran_type'] := 6;
      Parameters.ParamValues['tran_desc'] := '����һ������ɹ���Ŀ';
      Parameters.ParamValues['tran_from'] := null;
      Parameters.ParamValues['tran_to'] := null;
      Parameters.ParamValues['data0071_ptr'] := null;
      Parameters.ParamValues['data0072_ptr'] := dm.ADO72RKEY.Value;
      ExecSQL;
     end;
   dm.ADO72.Next;
  end;

 dm.ADO72.First;
 dm.AQ72.First;
 while not dm.AQ72.Eof do
  begin
   if not dm.ADO72.Locate('rkey',dm.Aq72RKEY.value,search_option) then
     with dm.ADO0339 do //�����༭���������ɹ�û��ԭ���Ĳɹ���Ŀ
      begin             //���۾�ɾ����
       active:=false;
       Parameters.ParamValues['po_ptr'] := rkey70;
       Parameters.ParamValues['edit_empl_ptr'] := dm.ADO70EDIT_BY_EMPL_PTR.Value;
       Parameters.ParamValues['tran_type'] := 7;
       Parameters.ParamValues['tran_desc'] := 'ɾ����һ������ɹ���Ŀ';
       Parameters.ParamValues['tran_from'] := null;
       Parameters.ParamValues['tran_to'] := null;
       Parameters.ParamValues['data0071_ptr'] := null;
       Parameters.ParamValues['data0072_ptr'] := dm.aq72RKEY.Value;
       ExecSQL;
      end;
   dm.AQ72.Next;
  end;
  dm.ADO72.First;
end;

procedure TForm4.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
 if v_close<>1 then  //��ʾ�������˳�
  begin
   if dm.AQ0015.Active = true then dm.AQ0015.CancelBatch();
   if dm.ADO70.Active = true then dm.ADO70.CancelBatch();
   if dm.ADO7011.Active = true then dm.ADO7011.CancelBatch();
   if dm.ADO107011.Active = true then dm.ADO107011.CancelBatch();
   if dm.ADO200.Active = true then dm.ADO200.CancelBatch();
   if dm.ADO0450.Active = true then dm.ADO0450.CancelBatch();
  end;
end;


procedure tform4.add_misc_visible();
begin
 with form2 do
  begin
   label14.Visible := true;
   edit8.Visible := true;
   edit9.Visible := true;
   combobox1.Enabled := true;
   label15.Caption := '���:';
   label16.Visible:=true;
   edit12.visible := false;
   label1.Visible := false;
   label2.Visible := false;
   edit1.Visible := false;
   bitbtn1.Visible := false;
   label11.Caption := '�۸�:';
   label1.Caption := '��Ʒ����:';
   edit7.ReadOnly := false;
   edit7.Color := clwindow;
   edit10.Visible:=true;
   label18.Visible:=true;
   label19.Visible:=true;
   edit11.Visible:=true;
   bitbtn4.Visible:=true;
   button3.Visible:=false;
   edit14.Enabled:=true;   //˰��
   edit7.Enabled:=false;  //����˰��
   CheckBox3.Enabled:=true; //��ҪIQC
   edit15.Visible:=false;
   label23.Visible:=false;
   Label30.Visible:=false;
   Edit19.Visible:=false;
   BitBtn5.Visible:=False;

   label21.Top:=340;
   edit14.Top:=336;
   label22.Top:=340;      
  end;
end;

procedure TForm4.DBEdit16Exit(Sender: TObject);
var
 v_end:string;
begin
   v_end:=copy(dbedit16.Text,length(trim(dbedit16.Text)),1);
   if (v_end<'0') or (v_end>'9') then
   begin
    application.MessageBox('���һλ������һ������','���ƺ���',mb_ok);
    dbedit16.SetFocus;
   end;
end;

procedure TForm4.TC1Changing(Sender: TObject; var AllowChange: Boolean);
var
 v_end:string;
begin
 v_end:=copy(dbedit16.Text,length(trim(dbedit16.Text)),1);
 if (v_end<'0') or (v_end>'9') then
  begin
   application.MessageBox('���һλ������һ������','���ƺ���',mb_ok);
   AllowChange:=false;
   dbedit16.SetFocus;
  end
 else
  allowchange:=true;
end;

function tform4.invtory_type(invt_ptr:string):string;
begin
 with dm.ADOQuery2 do
  begin
   close;
   sql.Clear;
   sql.Add('SELECT Data0019.inv_group_desc');
   sql.Add('FROM Data0019 INNER JOIN');
   sql.Add('Data0496 ON Data0019.rkey = Data0496.group_ptr INNER JOIN');
   sql.Add('Data0017 ON Data0496.RKEY = Data0017.GROUP_PTR');
   sql.Add('where data0017.rkey='+invt_ptr);
   open;
  end;
 invtory_type:=trim(dm.ADOQuery2.fieldbyname('inv_group_desc').AsString);
end;

function tform4.find_pr_number():boolean;
begin
 find_pr_number:=false;
 with dm.ADOQuery1 do
  begin
   close;
   sql.Clear;
   sql.Add('select rkey,PURCHASE_ORDER_TYPE from data0070');
   sql.Add('where fob='''+trim(form_req.ADOQuery1PO_REQ_NUMBER.Value)+'''');
   open;
  end;
 if not dm.ADOQuery1.IsEmpty then find_pr_number:=true;
end;

procedure TForm4.update_data0028;
begin
 dm.ADO28.Close;
 dm.ADO28.Parameters[0].Value:=dm.ADO70SUPPLIER_POINTER.Value;
 dm.ADO28.Parameters[1].Value:=dm.ADO71INVT_PTR.Value;
 dm.ADO28.Open;
 if dm.ADO71PRICE.Value<>dm.ADO28PRICE_1.Value then
  begin
   dm.ADO28.Edit;
   dm.ADO28PRICE_1.Value:=dm.ADO71PRICE.Value;
   dm.ADO28.Post;
  end;
end;

procedure TForm4.BitBtn6Click(Sender: TObject);
begin
 form_dept:=tform_dept.Create(application);
 if form_dept.ShowModal=mrok then
  begin
   dm.ADO70PO_REV_NO.Value:=form_dept.ADOQuery1dept_code.Value;
   Label30.Caption := Form_dept.ADOQuery1dept_name.Value;
  end;
 form_dept.Free;
end;

procedure TForm4.ComboBox1Change(Sender: TObject);
begin
if dm.ADO70.State<>dsEdit then  dm.ADO70.Edit;

 dm.ADO70PURCHASE_TYPE.Value:=ComboBox1.Text;

end;

procedure TForm4.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
 if dm.ADO71CRITICAL_MATL.Value='��' then
  DBGrid1.Canvas.Font.Color := clRed;

  DBGrid1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;

procedure TForm4.get_approve_type(rkey15: Integer);
begin
  ComboBox1.Items.Clear;
  with dm.ADOQuery1 do
  begin
    Close;
    sql.Text:='select purchase_type from data0077 '+
     'where warehouse_ptr='+inttostr(rkey15)+
     ' group by purchase_type';
    open;
    while not Eof do
     begin
      ComboBox1.Items.Add(fieldbyname('purchase_type').AsString);
      Next;
     end;
  end;
end;

procedure TForm4.DBCheckBox2Click(Sender: TObject);
begin
DBRadioGroup2.Enabled:=DBCheckBox2.Checked;
end;

procedure TForm4.DBEdit1KeyPress(Sender: TObject; var Key: Char);
begin
  if not (key in [#8]) then
  begin
    DBEdit1.ReadOnly:=True;
  end
  else
  begin
    DBEdit1.ReadOnly :=False;
  end;
end;

procedure TForm4.DBEdit1Exit(Sender: TObject);
begin
  if Trim(DBEdit1.Text)='' then
  begin
    Label30.Caption :='';
  end;
end;

procedure TForm4.dbchk_CPClick(Sender: TObject);
begin
if  (dbchk_CP.Checked) and (dm.ADO70.State in [dsedit,dsInsert]) then
 begin
  DBEdit15.Field.Value:=0;
  DBEdit13.Field.Value:='';
 end;
end;

end.
