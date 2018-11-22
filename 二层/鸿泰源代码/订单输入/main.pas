unit main;

interface                                       

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Menus, Grids, DBGrids, ComCtrls, Mask,
  DBCtrls, DB, ADODB, ToolWin, ExtCtrls, Excel2000,  ComObj;

type
  TForm1 = class(TForm)
    DBGrid1: TDBGrid;
    GroupBox1: TGroupBox;
    CheckBox1: TCheckBox;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    PopupMenu1: TPopupMenu;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    N4: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    enter_empl_ptr: TLabel;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    CheckBox6: TCheckBox;
    N3: TMenuItem;
    N16: TMenuItem;
    N17: TMenuItem;
    N18: TMenuItem;
    N19: TMenuItem;
    N20: TMenuItem;
    N22: TMenuItem;
    N23: TMenuItem;
    N24: TMenuItem;
    N25: TMenuItem;
    Label1: TLabel;
    Edit2: TEdit;
    N13: TMenuItem;
    N14: TMenuItem;
    BitBtn3: TBitBtn;
    N15: TMenuItem;
    Edit3: TEdit;
    Label3: TLabel;
    BitBtn4: TBitBtn;
    Edit1: TEdit;
    Label4: TLabel;
    BitBtn2: TBitBtn;
    BtFlds: TBitBtn;
    PMFlds: TPopupMenu;
    BitBtn5: TBitBtn;
    PopupMenu3: TPopupMenu;
    MenuItem1: TMenuItem;
    MenuItem2: TMenuItem;
    BitBtn6: TBitBtn;
    N21: TMenuItem;
    N26: TMenuItem;
    N27: TMenuItem;
    BitBtn7: TBitBtn;
    BitBtn8: TBitBtn;
    StringGrid1: TStringGrid;
    OpenDialog1: TOpenDialog;
    procedure checkvar();
    procedure aq97update();
    procedure pact_auth();
    procedure note_information(title,value: string; v_type: word);
    procedure N5Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure DBGrid1DblClick(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure N9Click(Sender: TObject);
    procedure N10Click(Sender: TObject);
    procedure N11Click(Sender: TObject);
    procedure N12Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure N16Click(Sender: TObject);
    procedure N18Click(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure N22Click(Sender: TObject);
    procedure N23Click(Sender: TObject);
    procedure N24Click(Sender: TObject);
    procedure N25Click(Sender: TObject);
    procedure N13Click(Sender: TObject);
    procedure N14Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure N15Click(Sender: TObject);
    procedure CheckBox6Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure BitBtn2Click(Sender: TObject);
    procedure BtFldsClick(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem2Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure N21Click(Sender: TObject);
    procedure N26Click(Sender: TObject);
    procedure N27Click(Sender: TObject);
    procedure PMFldsPopup(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
  private
    { Private declarations }
    PreColumn: TColumn;
    field_name,sql_text,total_sqltext:string;
    OldGridWnd : TWndMethod;
    procedure item_click(sender: TObject);
    procedure NewGridWnd (var Message : TMessage);
  public
    { Public declarations }
    cust_set:string;
    v_con:byte;
    procedure get_quotetools(rkey85:integer;sgrid:Tstringgrid);
    procedure ExcelToDB;
  end;

var
  Form1: TForm1;
  
const
  TmpFileDir = 'c:\tmp\';

implementation
 uses damo, addsa_order, edit_so, note, stop_po, active_po, cust_search,
  deptauth_info, so_report, note_information, Mreport, much_report, term,
  COMMON, ViewCredit, SCPO_reports, PubFunc, ShellAPI;
{$R *.dfm}

procedure TForm1.FormCreate(Sender: TObject);
begin
 if not app_init_2(dm.ADOConnection1) then
  begin
   ShowMessage('��������ʧ�ܣ�����ϵϵͳ����Ա��');
   application.Terminate;
  end;
 self.Caption:=application.Title;

// rkey73:= '2636';
//  user_ptr := '3116';
//  vprev := '4';
//  dm.ADOConnection1.Open;

 DateSeparator := '-';
 ShortDateFormat := 'yyyy-mm-dd';
 OldGridWnd := DBGrid1.WindowProc;
 DBGrid1.WindowProc := NewGridWnd;
end;

procedure TForm1.get_quotetools(rkey85: integer;sgrid:Tstringgrid);
var
 i:integer;
begin
with dm.ADOQuery2 do
begin
 close;
 sql.Text:='select ADDL_CAT_PTR, AMOUNT, FREE_AMOUNT, TAX_FLAG'+#13+
   'from data0432'+#13+
   'where qte_ptr = '+inttostr(rkey85)+#13+
   'and addl_cat_ptr is not null';
 open;
 while not eof do
  begin
   for i:=1 to sgrid.RowCount-2 do
   if FieldValues['ADDL_CAT_PTR']=strtoint(sgrid.Cells[5,i]) then
    begin
     sgrid.Cells[1,i]:=fieldbyname('AMOUNT').AsString;
     sgrid.Cells[3,i]:=fieldbyname('FREE_AMOUNT').AsString;
     sgrid.Cells[4,i]:=fieldbyname('TAX_FLAG').AsString;
     break;
    end;
   Next;
  end;
end;
end;

procedure TForm1.NewGridWnd(var Message: TMessage);
var
 IsNeg : Boolean;
begin
 if Message.Msg = WM_MOUSEWHEEL then
 begin
   IsNeg := Short(Message.WParamHi) < 0;
   if IsNeg then
     DBGrid1.DataSource.DataSet.MoveBy(1)
   else
     DBGrid1.DataSource.DataSet.MoveBy(-1)
 end
 else
   OldGridWnd(Message);
end;


procedure tform1.checkvar();
begin
 dm.ADOQuery1.Close;
 dm.ADOQuery6.Close;
if not checkbox1.Checked then
 begin
  dm.ADOQuery1.Parameters[0].Value:=1;      //��Ч��
  dm.ADOQuery6.Parameters[0].Value:=1;
 end
else
 begin
  dm.ADOQuery1.Parameters[0].Value:=0;
  dm.ADOQuery6.Parameters[0].Value:=0;
 end;
if not checkbox2.Checked then             //�ݻ�
 begin
  dm.ADOQuery1.Parameters[1].Value:=2;
  dm.ADOQuery6.Parameters[1].Value:=2;
 end
else
 begin
  dm.ADOQuery1.Parameters[1].Value:=0;
  dm.ADOQuery6.Parameters[1].Value:=0;
 end;
if not checkbox3.Checked then           //�ѽ���
 begin
  dm.ADOQuery1.Parameters[2].Value:=3;
  dm.ADOQuery6.Parameters[2].Value:=3;
 end
else
 begin
  dm.ADOQuery1.Parameters[2].Value:=0;
  dm.ADOQuery6.Parameters[2].Value:=0;
 end;
if not checkbox4.Checked then           //�����
 begin
  dm.ADOQuery1.Parameters[3].Value:=4;
  dm.ADOQuery6.Parameters[3].Value:=4;
 end
else
 begin
  dm.ADOQuery1.Parameters[3].Value:=0;
  dm.ADOQuery6.Parameters[3].Value:=0;
 end;
//if not checkbox5.Checked then           //��ȡ��
// begin
//  dm.ADOQuery1.Parameters[4].Value:=5;
//  dm.ADOQuery6.Parameters[4].Value:=5;
// end
//else
// begin
//  dm.ADOQuery1.Parameters[4].Value:=0;
//  dm.ADOQuery6.Parameters[4].Value:=0;
// end;
if not checkbox6.Checked then           //δ�ύ
 begin
  dm.ADOQuery1.Parameters[5].Value:=6;
  dm.ADOQuery6.Parameters[5].Value:=6;
 end
else
 begin
  dm.ADOQuery1.Parameters[5].Value:=0;
  dm.ADOQuery6.Parameters[5].Value:=0;
 end;

 DM.adoquery1.open;
 DM.adoquery6.open;
end;

procedure TForm1.N5Click(Sender: TObject);

begin
if (strtoint(vprev)=1) or (strtoint(vprev)=3) then
 begin
  messagedlg('�Բ���!��û�иó���Ŀ�дȨ��',mtinformation,[mbok],0);
 end
ELSE
 try
  form2:=tform2.Create(application);
  form2.ShowModal;
 finally
  form2.free;

 end;
end;

procedure TForm1.N6Click(Sender: TObject);   //�༭
begin
  if (strtoint(vprev)=1) or (strtoint(vprev)=3) then
  begin
   messagedlg('�Բ���!��û�иó���Ŀ�дȨ��',mtinformation,[mbok],0);
   exit;
  end;
  if dm.ADOQuery1D60STATUS.Value<>4 then  //����û�б�����״̬
  begin
    with dm.ADOQuery5 do
    begin
      close;
      sql.Clear;
      sql.Add('select rkey from data0090');
      sql.Add('where auth_date is not null and');
      sql.Add('pact_ptr='+dm.ADOQuery1D60RKEY.AsString);
      open;
    end;
    if (not dm.ADOQuery5.IsEmpty ) and (dm.ADOQuery1QUOTE_PRICE.AsInteger<>2) then
    begin
      MessageDlg('�ö����ĺ�ͬ����������Ա,������༭',mtInformation,[mbCancel],0);
      Exit;
    end
    else
    begin
      v_con:=0;
      dm.Aq0060.Close;
      dm.Aq0060.Parameters.ParamByName('@d60rkey').Value:=dm.ADOQuery1D60RKEY.Value;
      dm.Aq0060.Open;
      dm.ADOQuery4.Close;
      dm.ADOQuery4.Parameters[0].Value:= dm.ADOQuery1D60RKEY.Value;
//      dm.ADOQuery4.Parameters[1].Value:=dm.ADOQuery1D60RKEY.Value;//�洢����
      dm.ADOQuery4.Open;
      dm.ADOQuery4.Edit;
      Form8:=Tform8.Create(Application);
      if dm.ADOQuery1D60PROD_REL.Value<>'1' then //������ȷ�ϻ�Ͷ��
      begin
        form8.Edit4.Enabled := false;      //�ͻ�����
        form8.BitBtn3.Enabled := false;
        form8.Label67.Enabled := false;
        Form8.Label104.Enabled:=False;//�ͻ����Ϻ�
        form8.DBEdit13.Enabled := false;   //����
        form8.DBEdit12.Enabled := false;   //����set
        form8.DBEdit14.Enabled := false;
        form8.DBEdit25.Enabled := false;
        form8.MaskEdit1.Enabled := false;  //������
        form8.MaskEdit2.Enabled := false;
        form8.MaskEdit4.Enabled := false;
      end;
      form8.rkey213_old:=dm.ADOQuery1rkey213.Value;
      Form8.rkey213_new:=Form8.rkey213_old;
      form8.old213Num:=dm.ADOQuery1PARTS_ORDERED.Value;
      //20161019tang��
      if (dm.ADOQuery1.fieldbyname('BPNO').AsString<>'') then
      Form8.Label49.Caption:='Bom���۱�ţ�'+dm.ADOQuery1.fieldbyname('BPNO').AsString;
      form8.Edit14.Text:=dm.adoquery1CPJS.AsString;
      //end20161019
      if dm.ADOQuery1rkey213.Value>0 then
      begin
        Form8.BitBtn3.Enabled:=False;
        Form8.BitBtn4.Enabled:=False;
        Form8.DBEdit13.ReadOnly:=True;
        Form8.DBEdit14.ReadOnly:=True;
        Form8.DBEdit25.ReadOnly:=True;
        form8.BitBtn13.Enabled:=False;
      end;
      form8.ShowModal;
      form8.free;
      dm.Aq0060.Close;
    end;
  end
  else
  if messagedlg('���۶��������,��Ҫ�༭���±���?',mtConfirmation,[mbyes,mbno],0)=mryes then
  begin
    try
      edit_note:=Tedit_note.Create(application);
      edit_note.Caption:='���۶������±�:'+dm.ADOQuery1D60SALES_ORDER.Value;
      with dm.ADOQuery3 do
      begin
        if active=true then active:=false;
        sql.Clear;
        sql.Add('select RemarkSO from data0060 where Rkey='+dm.ADOQuery1.fieldbyname('D60RKEY').AsString);
        active:=true;
        if not isempty then
          edit_note.Memo1.Lines.Add(fieldbyname('RemarkSO').AsString);
      end;
      if edit_note.ShowModal=mrok then
      begin
        if (not dm.ADOQuery3.IsEmpty) and (trim(edit_note.Memo1.Text)<>'') then
        begin             //ԭ��¼�м��±������޸���
          dm.ADOQuery3.Edit;
          dm.ADOQuery3.fieldbyname('RemarkSO').asstring:=edit_note.Memo1.Lines.Text;
          dm.ADOQuery3.Post;
//        end
//        else
//        if (not dm.AQ9711.IsEmpty) and (trim(edit_note.Memo1.Text)='') then   //���ԭ��¼�м��±�����ɾ����
//          dm.AQ9711.Delete
//        else
//        if (dm.AQ9711.IsEmpty) and  (trim(edit_note.memo1.Text)<>'') then    //���ԭ��¼û�м��±����������˼��±�
//        begin
//          dm.AQ9711.Append;
//          dm.AQ9711.FieldByName('file_pointer').AsString:=dm.ADOQuery1.fieldbyname('d60rkey').AsString;
//          dm.AQ9711.Fieldvalues['source_type']:=60;
//          dm.AQ9711.fieldbyname('memo_text').asstring:=edit_note.Memo1.Lines.Text;
//          dm.AQ9711.post;
        end;
      end;
    finally
      edit_note.free;
    end;
  end;
end;

procedure TForm1.PopupMenu1Popup(Sender: TObject);
begin
 N3.Enabled := false;  //�ݻ�
 N8.Enabled := true; //���ݻ����ͷ�
 N6.Enabled := true;  //�༭
 n13.Enabled := false;      //�᰸
 n14.Enabled := true;   //�ӽ᰸����
 n7.Enabled := true; //���
 n16.Enabled := false; //�ύ
 n18.Enabled := true;
 n19.Enabled := true;
 n22.Enabled := true;
 n23.Enabled := false;  //ɾ��
case dm.ADOQuery1D60STATUS.Value of
1:
 begin//��Ч
  n3.Enabled := true;   //�ݻ�
  N8.Enabled := false;  //���ݻ����ͷ�
  n13.Enabled := true;
  n14.Enabled:=false;
  if dm.ADOQuery1D60PROD_REL.Value='1' then
   n23.Enabled :=true
  else
   n23.Enabled :=false;
 end;
2:
 begin //�ݻ�
  n14.Enabled := false;
  N6.Enabled := false;
 end;
3:
 begin   //�ر�
  N8.Enabled := false;   //���ݻ����ͷ�
  N6.Enabled := false;
 end;
4:
 begin //���
  n14.Enabled := false;
  N8.Enabled := false;   //���ݻ����ͷ�
 end;
5:
 begin //ȡ��
  n6.Enabled := false;   //�༭
  n14.Enabled := false;
  N8.Enabled := false;   //���ݻ����ͷ�
 end;
6:
 begin//δ�ύ
  n3.Enabled := true;   //�ݻ�
  N8.Enabled := false;  //���ݻ����ͷ�
  n14.Enabled:=false;  
  n13.Enabled := true;
  n16.Enabled := true;
  n23.Enabled := true;  //ɾ��
 end;
else
 begin //�ռ�¼
  N8.Enabled := false;  //���ݻ����ͷ�
  N6.Enabled := false;  //�༭
  n14.Enabled:=false;
  n7.Enabled := false;  //���
  n16.Enabled := false; //�ύ
  n18.Enabled := false; //������Ϣ
  n19.Enabled := false; //����
  n22.Enabled := false;  //���۶������
  n23.Enabled := false;  //ɾ��
 end;
end;
  
end;

procedure TForm1.DBGrid1DblClick(Sender: TObject);
var
 info:string;
begin
 if (dm.ADOQuery1quote_price.Value=2)  then
  begin
   with dm.ADOQuery3 do
    begin
     close;
     sql.Clear;
     sql.Add('select employee_name from data0005');
     sql.Add('where rkey='+dm.ADOQuery1rma_ptr.AsString);
     open;
     info := '�����۶�����Ա��:'+trim(fieldvalues['employee_name'])+'  ������'+#13;
     info := info+dm.ADOQuery1mfg_order_date.AsString+'�˻�,�˻�ԭ������:'+#13;
    end;
   with dm.ADOQuery3 do
    begin           //���Ҽ��±�
     if active = true then active := false;
     sql.Clear;
     sql.Add('select * from data0011 where source_type=97');
     sql.Add('and file_pointer='+dm.ADOQuery1PURCHASE_ORDER_PTR.AsString);
     active := true;
     if not isempty then
      info:=info+Fieldbyname('memo_text').AsString+#13;
    end;
   showmessage(info);
   dm.ADOQuery3.Close;
  end
 else
  begin
   N7Click(Sender);
  end;
end;


procedure TForm1.N3Click(Sender: TObject);
var
 rkey60:integer;

begin
if (strtoint(vprev)=1) or (strtoint(vprev)=3) then
 begin
  messagedlg('�Բ���!��û�иó���Ŀ�дȨ��',mtinformation,[mbok],0);
 end
 else
  begin
   try
    edit_note:=Tedit_note.Create(application);
    edit_note.Label9.Caption:=' �����ļ���/��ͣԭ��:';
    edit_note.iMenu:=0;// ��ͣ
    edit_note.Caption:='���۶������±�,�����ݻ�:'+dm.ADOQuery1D60SALES_ORDER.Value;
    
    with dm.ADOQuery3 do
     begin
      if active=true then active:=false;
      sql.Clear;
      sql.Add('select RemarkSO from data0060 where Rkey='+dm.ADOQuery1.fieldbyname('D60RKEY').AsString);
      active:=true;
      if not isempty then edit_note.Memo1.Text := fieldvalues['RemarkSO']; //memo_text
     end;
    if edit_note.ShowModal=mrok then
     begin
      if (not dm.ADOQuery3.IsEmpty) and (trim(edit_note.Memo1.Text)<>'') then
       begin             //ԭ��¼�м��±������޸���
        dm.ADOQuery3.Edit;
        dm.ADOQuery3.FieldValues['RemarkSO']:=edit_note.Memo1.Text;
        dm.ADOQuery3.Post;
//       end
//      else
//       if (not dm.AQ9711.IsEmpty) and (trim(edit_note.Memo1.Text)='') then   //���ԭ��¼�м��±�����ɾ����
//        dm.AQ9711.Delete
//       else
//        if (dm.AQ9711.IsEmpty) and  (trim(edit_note.memo1.Text)<>'') then    //���ԭ��¼û�м��±����������˼��±�
//         begin
//          dm.AQ9711.Append;
//          dm.AQ9711.FieldByName('file_pointer').AsString:=dm.ADOQuery1.fieldbyname('d60rkey').AsString;
//          dm.AQ9711.Fieldvalues['source_type']:=60;
//          dm.AQ9711.FieldValues['memo_text']:=edit_note.Memo1.Text;
//          dm.AQ9711.post;
         end;

     dm.ADOQuery4.Close;
      dm.ADOQuery4.Parameters[0].Value:=dm.ADOQuery1D60RKEY.Value;
//     dm.ADOQuery4.Parameters[1].Value:=dm.ADOQuery1D60RKEY.Value;
     dm.ADOQuery4.Open;

     dm.ADOQuery4.Edit;
     dm.ADOQuery4.FieldValues['status']:=2;  //�ݻ�
     dm.adoquery4.post;

    with dm.ADOQuery5 do
    begin
     close;                  //��¼���۶���״̬����(��־�ļ�)
     sql.Clear;
     sql.Add('insert into data0318 (SALES_ORDER_PTR,TRANS_TYPE,TRANS_DESCRIPTION,');
     sql.Add('FROM_string,TO_string,USER_PTR,TRANS_DATE,PROGRAM_SOURCE,file_number)');
     sql.Add('values ('+dm.ADOQuery1D60RKEY.AsString+',10,''�������۶���״̬Ϊ����'',');
     sql.Add(''''+dm.ADOQuery1status.Value+''',''�ݻ�'','+rkey73+',getdate(),');
     sql.Add('32,'''+trim(edit_note.Edit1.Text)+''')');
     ExecSQL;
    end;

   with dm.ado06 do
    begin
     close;
     Parameters.ParamByName('@v_flag').Value:=1;
     Parameters.ParamByName('@d60sales_order').Value:=dm.ADOQuery1D60SALES_ORDER.Value;
     open;
     while not eof do
      begin
       if dm.ado06PROD_STATUS.Value=4 then
        with dm.ADOQuery5 do
         begin
         close;
         sql.Clear;
         sql.Text:='insert into data0117(Source_ptr,Source_Type,Empl_ptr,Tdate,Action,Remark) '+
          ' values ('+dm.ado06rkey.AsString+',2,'+User_ptr+',getdate(),1,'+QuotedStr('�г������ݻ������ⷢ�����ݻ�')+')';
         ExecSQL;
         end
        else
         with dm.ADOQuery5 do
         begin
         close;
         sql.Clear;
         sql.Text:='insert into data0117(Source_ptr,Source_Type,Empl_ptr,Tdate,Action,Remark) '+
          ' values ('+dm.ado06rkey.AsString+',2,'+User_ptr+',getdate(),1,'+QuotedStr('�г������ݻ����¹����ݻ�')+')';
         ExecSQL;
         end;
       edit;
       if dm.ado06PROD_STATUS.Value=2 then
        dm.ado06PROD_STATUS.Value:=102
       else
        dm.ado06PROD_STATUS.Value:=103;
       post;
       next;
      end;
     close;
    end;

     rkey60:=dm.ADOQuery1d60rkey.Value;
     dm.ADOQuery1.Close;
     dm.ADOQuery1.Open;
     dm.ADOQuery1.Locate('d60rkey',rkey60,[]);
    end;
   finally
    edit_note.free;
   end;
  end;
end;

procedure TForm1.N8Click(Sender: TObject);
var
 rkey60:integer;
begin
if (strtoint(vprev)=1) or (strtoint(vprev)=3) then
 messagedlg('�Բ���!��û�иó���Ŀ�дȨ��',mtinformation,[mbok],0)
else
 begin
  try
   edit_note:=Tedit_note.Create(application);
   edit_note.Label9.Caption:=' �ļ���/�ݻ�����ԭ��:';
   edit_note.iMenu:=1;//����
   edit_note.Caption:='���ݻ����ͷ�:'+dm.ADOQuery1D60SALES_ORDER.Value;
   with dm.ADOQuery3 do
    begin
     if active = true then active := false;
     sql.Clear;
     sql.Add('select RemarkSO from data0060 where  Rkey='+dm.ADOQuery1.fieldbyname('D60RKEY').AsString);
     active:=true;
     if not isempty then edit_note.Memo1.Text := fieldvalues['RemarkSO'];
    end;
     if edit_note.ShowModal=mrok then
      begin
       if (not dm.ADOQuery3.IsEmpty) and (trim(edit_note.Memo1.Text)<>'') then
        begin             //ԭ��¼�м��±������޸���
         dm.ADOQuery3.Edit;
         dm.ADOQuery3.FieldValues['RemarkSO']:=edit_note.Memo1.Text;
         dm.ADOQuery3.Post;
//        end
//       else
//        if (not dm.AQ9711.IsEmpty) and (trim(edit_note.Memo1.Text)='') then   //���ԭ��¼�м��±�����ɾ����
//         dm.AQ9711.Delete
//        else
//         if (dm.AQ9711.IsEmpty) and  (trim(edit_note.memo1.Text)<>'') then    //���ԭ��¼û�м��±����������˼��±�
//          begin
//          dm.AQ9711.Append;
//          dm.AQ9711.FieldByName('file_pointer').AsString:=dm.ADOQuery1.fieldbyname('d60rkey').AsString;
//          dm.AQ9711.Fieldvalues['source_type']:=60;
//          dm.AQ9711.FieldValues['memo_text']:=edit_note.Memo1.Text;
//          dm.AQ9711.post;
          end;
     dm.ADOQuery4.Close;
      dm.ADOQuery4.Parameters[0].Value:=dm.ADOQuery1D60RKEY.Value;
//     dm.ADOQuery4.Parameters[1].Value:=dm.ADOQuery1D60RKEY.Value;
     dm.ADOQuery4.Open;
     dm.ADOQuery4.Edit;
     dm.ADOQuery4.FieldValues['status']:=1;   //��Ч
     dm.adoquery4.post;

    with dm.ADOQuery5 do
     begin
      close;                  //��¼���۶�״̬�������(��־�ļ�)
      sql.Clear;
      sql.Add('insert into data0318 (SALES_ORDER_PTR,TRANS_TYPE,TRANS_DESCRIPTION,');
      sql.Add('FROM_string,TO_string,USER_PTR,TRANS_DATE,PROGRAM_SOURCE,file_number)');
      sql.Add('values ('+dm.ADOQuery1D60RKEY.AsString+',10,''�������۶���״̬Ϊ��Ч'',');
      sql.Add(''''+dm.ADOQuery1status.Value+''',''��Ч��'','+rkey73+',');
      sql.add('getdate(),32,'''+trim(edit_note.Edit1.Text)+''')');
      ExecSQL;
     end;

   with dm.ado06 do
    begin
     close;
     Parameters.ParamByName('@v_flag').Value:=2;
     Parameters.ParamByName('@d60sales_order').Value:=dm.ADOQuery1D60SALES_ORDER.Value;
     open;
     while not eof do
      begin
       edit;
       if dm.ado06PROD_STATUS.Value=102 then
        dm.ado06PROD_STATUS.Value:=2
       else
        dm.ado06PROD_STATUS.Value:=3;
       post;
       with dm.ADOQuery5 do
        begin
         close;
         sql.Clear;
         sql.Text:='insert into data0117(Source_ptr,Source_Type,Empl_ptr,Tdate,Action,Remark) '+
          ' values ('+dm.ado06rkey.AsString+',2,'+User_ptr+',getdate(),2,'+QuotedStr('�г����ָ����¹����ָ�')+')';
         ExecSQL;
        end;
       next;
      end;
     close;
    end;
     rkey60:=dm.ADOQuery1d60rkey.Value;
     dm.ADOQuery1.Close;
     dm.ADOQuery1.Open;
     dm.ADOQuery1.Locate('d60rkey',rkey60,[]);
    end;
   finally
    edit_note.free;
   end;
  end;
end;

procedure TForm1.N1Click(Sender: TObject);
begin
//20160308Tang�޸�ȥ���˵�
//if (strtoint(vprev)=1) or (strtoint(vprev)=3) then
// begin
//  messagedlg('�Բ���!��û�иó���Ŀ�дȨ��',mtinformation,[mbok],0);
//  exit;
// end;
// try
//  form9:=Tform9.Create(Application);
//  if form9.ShowModal=mrok then
//   begin
//    dm.ADOQuery1.Close;
//    dm.ADOQuery1.Open;
//   end;
// finally
//  form9.free;
// end;
end;

procedure TForm1.N2Click(Sender: TObject);
begin
//20160308Tang�޸�ȥ���˵�
//if (strtoint(vprev)=1) or (strtoint(vprev)=3) then
// begin
//  messagedlg('�Բ���!��û�иó���Ŀ�дȨ��',mtinformation,[mbok],0);
//  exit;
// end;
// try
//  form10:=Tform10.Create(Application);
//  if form10.ShowModal=mrok then
//   begin
//    dm.ADOQuery1.Close;
//    dm.ADOQuery1.Open;
//   end;
// finally
//  form10.free;
// end;
end;

procedure TForm1.N9Click(Sender: TObject);
begin
 dm.ADOQuery1.First;
end;

procedure TForm1.N10Click(Sender: TObject);
begin
 dm.ADOQuery1.Last;
end;

procedure TForm1.N11Click(Sender: TObject);
begin
 dm.ADOQuery1.Prior;
end;

procedure TForm1.N12Click(Sender: TObject);
begin
 dm.ADOQuery1.next;
end;

procedure TForm1.N7Click(Sender: TObject);

begin
if not dm.ADOQuery1.IsEmpty then
 try
   dm.ADOQuery4.Close;
      dm.ADOQuery4.Parameters[0].Value:=dm.ADOQuery1D60RKEY.Value;
//   dm.ADOQuery4.Parameters[1].Value:=dm.ADOQuery1D60RKEY.Value;
   dm.ADOQuery4.Open;
   dm.ADO360.Parameters[0].Value:=dm.ADOQuery1D60RKEY.Value;
   Form8:=Tform8.Create(Application);
   form8.Edit4.ReadOnly := true;   //�������
   form8.Edit2.Enabled := false;
   form8.BitBtn11.Enabled := false; //��������
   form8.BitBtn2.Enabled := false;
   form8.BitBtn3.Enabled := false;
   form8.BitBtn4.Enabled := false;
   form8.BitBtn5.Enabled := false; //ʹ�����۸񲻿��޸�
   form8.BitBtn13.Enabled:=False;  //Ԥ������ѡ��
   form8.BitBtn6.Enabled := false;
   form8.Label67.Enabled := false;
   form8.Label104.Enabled:=False;//�ͻ����Ϻ�
   form8.DBEdit13.ReadOnly := true;
   form8.MaskEdit1.Enabled := false;
   form8.MaskEdit2.Enabled := false;
   form8.MaskEdit4.Enabled := false;
   form8.Button1.Visible := false;
   form8.Button2.Visible := false;
   form8.Button3.Visible := true;
   form8.Edit6.ReadOnly := true;     //�ɹ��������
   form8.ComboBox1.Enabled := false;
   form8.DBEdit11.ReadOnly := true;
   form8.MaskEdit3.ReadOnly := true;
   form8.Edit8.Enabled := false;
   form8.DBEdit7.ReadOnly := true;
   form8.DBEdit8.ReadOnly := true;
   form8.DBEdit9.ReadOnly := true;
   form8.DBEdit10.ReadOnly := true;

   form8.DBCheckBox2.ReadOnly := true;
   form8.DBCheckBox3.ReadOnly := true;
   form8.DBEdit12.ReadOnly := true;
   form8.DBEdit25.ReadOnly := true;
   form8.DBEdit14.ReadOnly := true;
   form8.DBEdit15.ReadOnly := true;
   form8.DBEdit16.ReadOnly := true;
//20161114tang�޸�
//   form8.DBEdit17.ReadOnly := true;
   Form8.ComboBox3.Enabled:=false;
   form8.DBEdit18.ReadOnly := true;
   form8.DBEdit19.Enabled := false;
   form8.DBEdit20.Enabled := false;
   form8.DBEdit21.Enabled := false;
   form8.DBCheckBox4.ReadOnly := true;
   //form8.stringgrid1.Enabled := false;
   form8.stringgrid2.Enabled := false;
   form8.DBEdit1.ReadOnly := true;
   form8.DBEdit2.ReadOnly := true;
   form8.DBEdit3.ReadOnly := true;
   form8.DBEdit4.ReadOnly := true;
   form8.DBEdit5.ReadOnly := true;
   form8.BitBtn8.Enabled := false;  //���Ļ���
   form8.DBGrid1.ReadOnly := TRUE;
   form8.DBComboBox1.ReadOnly := true;
   form8.Memo1.Enabled:=false;
   form8.Memo2.Enabled:=false;
   form8.SpeedButton1.Enabled:=false;
   form8.DBEdit24.Enabled:=false;
   form8.BitBtn9.Enabled:=false;
   form8.SpeedButton2.Enabled:=false;
   form8.Edit9.Enabled:=false;
   form8.DBRadioGroup1.Enabled:=false;
   form8.BitBtn10.Enabled:=false;
   form8.DBRadioGroup2.ReadOnly:=true;
   form8.DBComboBox2.Enabled:=false;
  //20161019tang��
    if (dm.ADOQuery1.fieldbyname('BPNO').AsString<>'') then
    Form8.Label49.Caption:='Bom���۱�ţ�'+dm.ADOQuery1.fieldbyname('BPNO').AsString;
    form8.Edit14.Text:=dm.adoquery1CPJS.AsString;
  //end20161019
//   Form8.BitBtn7.Enabled:=False;    //������״̬�±༭���±�20160309tang
//   form8.Memo3.Enabled:=False;
    form8.Edit17.Enabled:=False;
    form8.BitBtn14.Enabled:=False;
   form8.ShowModal;
 finally
  form8.free;
 end
end;

procedure TForm1.BitBtn4Click(Sender: TObject);
var
 i:byte;
begin
//form_condition:=tform_condition.Create(application);
form_condition.dtpk1.Date:=dm.adoquery1.Parameters.ParamValues['dtpk1'];
form_condition.dtpk2.Date:=dm.adoquery1.Parameters.ParamValues['dtpk2']-1;

if form_condition.ShowModal=mrok then
 begin
  checkvar;
  dm.adoquery1.Close;
  dm.adoquery1.CommandText:=sql_text;
  dm.ADOQuery6.Close;
  dm.ADOQuery6.SQL.Text:=total_sqltext;

  for i:=1 to form_condition.SGrid1.RowCount-2 do
  begin
   dm.adoquery1.CommandText:=dm.adoquery1.CommandText+
   form_condition.SGrid1.Cells[2,i]+#13;
   dm.adoquery6.SQL.Text:=dm.adoquery6.sql.Text+
   form_condition.SGrid1.Cells[2,i]+#13;
  end;
  dm.adoquery1.Parameters.ParamByName('dtpk1').Value:=form_condition.dtpk1.Date;
  dm.adoquery1.Parameters.ParamByName('dtpk2').Value:=form_condition.dtpk2.Date+1;
  dm.adoquery6.Parameters.ParamByName('dtpk1').Value:=form_condition.dtpk1.Date;
  dm.adoquery6.Parameters.ParamByName('dtpk2').Value:=form_condition.dtpk2.Date+1;
  dm.ADOQuery1.Prepared;
  dm.ADOQuery6.Prepared;  
  dm.adoquery1.Open;
  dm.adoquery6.Open;
 end;
//form_condition.Free;
end;

procedure TForm1.item_click(sender: TObject);
var
  i:byte;
begin
  (sender as tmenuItem).Checked := not ((sender as tmenuItem).Checked);
  if (sender as tmenuItem).Checked then
  begin
    for i := 0 to dbGrid1.FieldCount - 1 do
    if dbGrid1.Columns[i].Title.Caption = (sender as tmenuItem).Caption then
    begin
      dbGrid1.Columns[i].Visible := true;
      break;
    end;
  end else begin
    for i := 0 to dbGrid1.FieldCount - 1 do
    if dbGrid1.Columns[i].Title.Caption = (sender as tmenuItem).Caption then
    begin
      dbGrid1.Columns[i].Visible := false;
      break;
    end;
  end;
end;

procedure TForm1.FormShow(Sender: TObject);
var
 v_date:string;
 i:integer;
 item:TMenuItem;
begin
if DM.Adoconnection1.Connected then
 begin

  field_name := DBGrid1.Columns[0].FieldName;
  PreColumn := DBGrid1.Columns[0];
  with dm.adoquery5 do
   begin
    close;
    sql.Clear;
    sql.Add('select EMPLOYEE_PTR from data0073');
    sql.Add('where rkey='+rkey73);
    open;
    enter_empl_ptr.Caption := fieldbyname('employee_ptr').asstring;
    user_ptr:=fieldbyname('employee_ptr').asstring;
   end;

  v_date:= datetostr(getsystem_date(DM.ADOQuery5,1));
  dm.AQ04.Close;    //���ݵ�ǰ�����ж��Ƿ��޸Ķ�����ų�ʼֵ
  dm.AQ04.Open;
  if copy(dm.AQ04.FieldByName('SEED_VALUE').AsString,1,6)<>
         (copy(v_date,3,2)+
          copy(v_date,6,2)+
          copy(v_date,9,2)) then
   begin
    dm.AQ04.Edit;
    dm.AQ04.FieldByName('SEED_VALUE').AsString:=(copy(v_date,3,2)+copy(v_date,6,2)+copy(v_date,9,2))+'001';
    dm.AQ04.Post;
   end;
  dm.AQ04.Close;
  
if (strtoint(vprev)=1) or (strtoint(vprev)=3) then
 begin
  dm.ADOQuery1.CommandText:= dm.ADOQuery1.CommandText+
  'and data0060.customer_ptr in (SELECT customer_ptr from DATA0100 WHERE csi_ptr='+rkey73+')'+#13;
  dm.ADOQuery6.SQL.Text:=dm.ADOQuery6.SQL.Text+
  'and data0060.customer_ptr in (SELECT customer_ptr from DATA0100 WHERE csi_ptr='+rkey73+')'+#13;
 end;
  checkvar;
  dm.ADOQuery1.Close;
  dm.ADOQuery6.Close;
  dm.ADOQuery1.Parameters[6].Value:=getsystem_date(DM.ADOQuery5,1);
  dm.ADOQuery6.Parameters[6].Value:=getsystem_date(DM.ADOQuery5,1);
  dm.ADOQuery1.Parameters[7].Value:=getsystem_date(DM.ADOQuery5,1)+1;
  dm.ADOQuery6.Parameters[7].Value:=getsystem_date(DM.ADOQuery5,1)+1;
  dm.ADOQuery1.Prepared;
  dm.ADOQuery6.Prepared;
  dm.ADOQuery1.Open;
  dm.ADOQuery6.Open;
  sql_text := dm.ADOQuery1.CommandText;
  total_sqltext:=dm.ADOQuery6.SQL.Text;

  for i := 1 to dbGrid1.Columns.Count do
  begin
    item := TmenuItem.Create(self);
    item.Caption := dbGrid1.Columns[i - 1].Title.Caption;
    item.Checked :=dbGrid1.Columns[i - 1].Visible ;
    item.OnClick := item_click ;
    PMFlds.Items.Add(item) ;
  end;

  with StringGrid1 do
  begin
    StringGrid1.ColCount:=10;
    StringGrid1.RowCount:=2;
    Cells[0,0]:='�ͻ��ͺ�';
    Cells[1,0]:='�ͻ�������';
    Cells[2,0]:='�ͻ����Ϻ�';
    Cells[3,0]:='��������';
    Cells[4,0]:='��������';
    Cells[5,0]:='���۶�����';
    Cells[6,0]:='�������(��)';
    Cells[7,0]:='�ͻ�����(��)';
    Cells[8,0]:='�ָⷢ����Ӧ��(��)';
    Cells[9,0]:='����(��)';
    StringGrid1.ColWidths[0]:=150;
    StringGrid1.ColWidths[1]:=120;
    StringGrid1.ColWidths[2]:=130;
    StringGrid1.ColWidths[3]:=60;
    StringGrid1.ColWidths[4]:=100;
    StringGrid1.ColWidths[5]:=80;
  end;
end;
end;

procedure TForm1.BitBtn1Click(Sender: TObject);
begin
 Application.Terminate;
end;

procedure TForm1.DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumn; State: TGridDrawState);
begin
 if (COlumn.FieldName = 'D60SCH_DATE') and
    (dm.ADOQuery1D60SCH_DATE.AsVariant<>null) and
    (dm.ADOQuery1D60SCH_DATE.Value>dm.ADOQuery1ORIG_SCHED_SHIP_DATE.Value) then
  begin
    dbgrid1.Canvas.Brush.color:=clyellow;
    dbgrid1.Canvas.Font.Color :=clblue;
    dbgrid1.Canvas.pen.mode:=pmmask;
    dbgrid1.DefaultDrawColumnCell(Rect,DataCol,Column,State);
  end;

 if (dm.ADOQuery1D60STATUS.Value = 1) and (dm.ADOQuery1quote_price.Value=2) then
  DBGrid1.Canvas.Font.Color := clred
 else
  if dm.ADOQuery1D60STATUS.Value = 6 then     //δ�ύ
  begin
   DBGrid1.Canvas.Font.Color :=clLime;
  end else
   if (dm.ADOQuery1D60STATUS.Value=2) or (dm.ADOQuery1D60STATUS.Value=3) or
   (dm.ADOQuery1D60STATUS.Value=5) then      //�ݻ�,�ر�,ȡ��
     DBGrid1.Canvas.Font.Color := clfuchsia;
  DBGrid1.DefaultDrawColumnCell(Rect, DataCol, Column, State);

end;

procedure TForm1.N16Click(Sender: TObject);  //�ύ����
var
 v_prod:byte;
 v_amt_ltd:integer;
 v_amount:double;
 sName:string;
begin
 if (strtoint(vprev)=1) or (strtoint(vprev)=3) then
  begin
   messagedlg('�Բ���!��û�иó���Ŀ�дȨ��',mtinformation,[mbok],0);
   exit;
  end;
 //20161219tang�޸��ύ֮ǰ�鿴�����汾�Ƿ���Ч������ʾ�°汾---
  dm.qrytmp.Close;
  dm.qrytmp.SQL.Text:='select ONHOLD_SALES_FLAG from data0025 where rkey='+dm.ADOQuery1CUST_PART_PTR.AsString;
  dm.qrytmp.Open;
  if (dm.qrytmp.FieldByName('ONHOLD_SALES_FLAG').AsInteger=1) then
  begin
    dm.Ado273_25.Close;
    dm.Ado273_25.Parameters.ParamByName('Rkey25').Value:=dm.ADOQuery1CUST_PART_PTR.Value;
    dm.Ado273_25.Open;
    if not dm.Ado273_25.IsEmpty then
    begin
      sName:=Trim(dm.Ado273_25.FieldByName('MANU_PART_NUMBER').AsString);
    end else
    begin
      sName:='��';
    end;
    if messagedlg('��ǰ���۵�����ͣ���ۣ������ı������Ϊ��'+sName+'�����Ƿ����?',mtConFirmation,[mbYes,mbNo],0)= mrNo then Exit;
  end;

  //20170619zgp�������δ�ύ�������޷��ύ---
  dm.qrytmp.Close;
  dm.qrytmp.SQL.Text:='select TSTATUS from data0025 where rkey='+dm.ADOQuery1CUST_PART_PTR.AsString;
  dm.qrytmp.Open;
    if (dm.qrytmp.FieldByName('TSTATUS').AsInteger=6) then
  begin
     Application.MessageBox('�������δ�ύ�������޷��ύ','��ʾ',0+64);
      Exit;
  end;

 //end 20161219tang
 dm.aq192.Open;
 v_prod:=2;
 v_amt_ltd:=0;
 v_amount:=0;
 with dm.ADOQuery5 do
 begin
  close;
  sql.Clear;
  sql.Add('select prod_conf,so_amt_ltd from data0119');
  sql.Add('where CUST_PART_PTR='+dm.ADOQuery1CUST_PART_PTR.AsString);
  open;
  if not IsEmpty then
   begin
    if fieldvalues['prod_conf']<>null then
     v_prod:=fieldvalues['prod_conf'];
    if fieldvalues['so_amt_ltd']<>null then
     v_amt_ltd:=fieldvalues['so_amt_ltd'];
   end;
 end;
with dm.ADOQuery5 do
 begin
  close;
  sql.Clear;
  sql.Add('SELECT CUST_PART_PTR, PURCHASE_ORDER_PTR,');
  sql.Add('ROUND(SUM(PARTS_ORDERED * (PART_PRICE * (1 - DISCOUNT * 0.01))');
  sql.Add('/ EXCH_RATE), 4) AS amount');
  sql.Add('FROM Data0060');
  sql.Add('where CUST_PART_PTR ='+dm.ADOQuery1CUST_PART_PTR.AsString);
  sql.Add('and PURCHASE_ORDER_PTR ='+dm.ADOQuery1PURCHASE_ORDER_PTR.AsString);
  sql.Add('GROUP BY CUST_PART_PTR, PURCHASE_ORDER_PTR');
  open;
  if not isempty then v_amount:=fieldvalues['amount'];
 end;

if (dm.aq192ppc_control15.Value=1) then
 begin
  if v_prod=2 then
   self.pact_auth()
  else
   if v_prod=0 then
    showmessage('�ö����޷��ύ,��Ϊ���û��ͨ��ת��ȷ��!')
   else
    begin
     if v_amount <= v_amt_ltd then
      self.pact_auth()
     else
      showmessage('�ö����޷��ύ,��Ϊ�����ܽ������˰�ſ�ת�����ܽ��!');
    end;
 end
else
 self.pact_auth();

end;

procedure TForm1.N18Click(Sender: TObject);
begin
 form_deptinfo := tform_deptinfo.Create(application);
 dm.Aqinfor90.Close;
 dm.Aqinfor90.Parameters.ParamByName('@d60rkey').Value:=dm.ADOQuery1D60RKEY.Value;
 dm.Aqinfor90.Open;
 form_deptinfo.ShowModal;
 form_deptinfo.Free;
end;

procedure TForm1.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if key=13 then dbgrid1dblclick(sender);
 if (chr(key)='S') and (ssalt in shift) then
  showmessage(dm.adoquery1.CommandText);
end;

procedure tform1.note_information(title,value:string; v_type:word);
begin
form11:=tform11.Create(application);
form11.Caption := title+value+'�����¼';
with dm.ADOQuery5 do
 begin
  close;
  sql.Clear;
  sql.Add('select user_login_name as USER_ID,USER_FULL_NAME,TRANS_DATE,TRANS_DESCRIPTION, ');
  sql.Add('FROM_STRING,TO_STRING,file_number');
  sql.Add('from data0318 inner join data0073 on');
  sql.Add('data0318.user_ptr=data0073.rkey');
  if v_type=60 then
   sql.Add('where sales_ORDER_PTR='+dm.ADOQuery1D60RKEY.AsString)
  else
   if v_type=97 then
    sql.Add('where work_ORDER_PTR='+dm.ADOQuery1PURCHASE_ORDER_PTR.AsString);
  open;
 end;
while not dm.ADOQuery5.Eof do
 begin
  form11.Memo1.Lines.Add(dm.ADOQuery5.fieldbyname('trans_date').AsString+
  ' ϵͳ�û�:'+dm.ADOQuery5.fieldbyname('user_id').AsString+' '+
  dm.ADOQuery5.fieldbyname('user_full_name').AsString+
  dm.ADOQuery5.fieldbyname('TRANS_DESCRIPTION').AsString);
  form11.Memo1.Lines.Add(' ԭֵ: '+dm.ADOQuery5.fieldbyname('from_string').AsString+
  ' �����: '+dm.ADOQuery5.fieldbyname('to_string').AsString+
  '   �ļ���/ԭ��:'+dm.ADOQuery5.fieldbyname('file_number').AsString);

  dm.ADOQuery5.Next;
 end;
form11.ShowModal;
form11.Free;
end;

procedure TForm1.N22Click(Sender: TObject);
begin
self.note_information('���۶���: ',dm.ADOQuery1D60SALES_ORDER.Value,60);
end;

procedure TForm1.N23Click(Sender: TObject);
begin
   dm.ADOQuery4.Close;
   dm.ADOQuery4.Parameters[0].Value:=dm.ADOQuery1D60RKEY.Value;
//   dm.ADOQuery4.Parameters[1].Value:=dm.ADOQuery1D60RKEY.Value;
   dm.ADOQuery4.Open;
if (strtoint(vprev)=1) or
   (strtoint(vprev)=3) or
   (strtoint(rkey73)<>dm.ADOQuery4.FieldValues['CSI_USER_PTR']) then
 begin
  messagedlg('�Բ���,��û�п�дȨ��!���߸ö��������������',mtinformation,[mbok],0);
  dm.ADOQuery4.Close;
 end
else
if messagedlg('��ȷ��Ҫɾ��������¼��?',mtConfirmation,[mbYes,mbNo],0)= mrYes then
 begin
  dm.ADOConnection1.BeginTrans;
//20160308tang�޸�ȡ��11�� ״̬��(SOURCE_TYPE=60) or (SOURCE_TYPE=1060)
//  with dm.ADOQuery3 do
//   begin
//    close;
//    sql.Clear;
//    sql.Add('select * from data0011');
//    sql.Add('where ((SOURCE_TYPE=60) or (SOURCE_TYPE=1060))');
//    sql.Add('and FILE_POINTER='+dm.ADOQuery1D60RKEY.AsString);
//    open;
//   end;
//  while not dm.ADOQuery3.Eof do dm.ADOQuery3.Delete;
  try
   if dm.ADOQuery1rkey213.Value>0 then //��Ԥ��������Ϣ�µ���ʽ����
   begin
    with dm.ADOQuery5 do
    begin
      Close;
      sql.Clear;
      sql.Add('update data0213 set status=3,UsedQuantity=isNull(UsedQuantity,0)-'+dm.ADOQuery1PARTS_ORDERED.AsString+' where rkey='+dm.ADOQuery1rkey213.AsString);
      ExecSQL;
    end;
   end;
   dm.ADOQuery4.Delete;
   dm.ADOConnection1.CommitTrans;
   showmessage('���ݳɹ�ɾ��!!!');
   dm.ADOQuery1.Close;
   dm.ADOQuery6.Close;
   dm.ADOQuery1.Open;
   dm.ADOQuery6.Open;
   dm.ADOQuery4.Close;
  except
   dm.ADOConnection1.RollbackTrans;
   showmessage('����ɾ�����ɹ�,�������Ѿ���Ͷ����¼���������ϵ�492');
  end;
 end
else
 dm.ADOQuery4.Close; 
end;

procedure TForm1.aq97update;  //׼�����Ӻ�ͬ�����Ĳ����ӱ�
begin
 with dm.ado90 do
  begin
   close;
   Parameters[1].Value := dm.ADOQuery1d60rkey.Value;
   open;
   while not eof do Delete;
  end;

 with dm.ADOQuery5 do
  begin
   close;
   sql.Clear;
   sql.Add('SELECT data0091.dept_ptr,data0091.if_puthdate,data0091.puth_info');
   sql.Add('FROM data0091 INNER JOIN');
   sql.Add('Data0007 ON data0091.group_ptr = Data0007.RKEY INNER JOIN');
   sql.Add('Data0008 ON Data0007.RKEY = Data0008.PR_GRP_POINTER INNER JOIN');
   sql.Add('Data0025 ON Data0008.RKEY = Data0025.PROD_CODE_PTR');
   sql.Add('where data0025.rkey='+dm.ADOQuery1CUST_PART_PTR.AsString);
   sql.Add('order by data0091.rkey');
   open;
  end;

 while not DM.ADOQuery5.Eof do
  begin
   dm.ado90.Append;
   dm.ado90pact_ptr.Value := dm.ADOQuery1d60rkey.Value;
   dm.ado90dept_ptr.Value := DM.ADOQUERY5.fieldvalues['dept_ptr'];
   dm.ado90if_puthdate.Value:= dm.ADOQuery5.FieldValues['if_puthdate'];
   dm.ado90puth_info.AsVariant := dm.ADOQuery5.FieldValues['puth_info'];
   DM.ado90.Post;
   DM.ADOQuery5.Next;
  end;

end;

procedure TForm1.N24Click(Sender: TObject);
var
 i:word;
 s:string;
begin
 form_report := tform_report.Create(application);

 dm.ado89.close;
 dm.ado89.Parameters[1].Value := dm.ADOQuery1CUST_PART_PTR.Value;
 dm.ado89.Open;

 dm.ado60.Close;
 dm.ado60.Parameters.ParamByName('@purchase_order_ptr').Value:=dm.ADOQuery1PURCHASE_ORDER_PTR.Value;
 dm.ado60.Parameters.ParamByName('@cust_part_ptr').Value:=dm.ADOQuery1CUST_PART_PTR.Value;
 dm.ado60.Open;

 dm.Aqinfor90.Close;//�������ӱ�
 dm.Aqinfor90.Parameters.ParamByName('@d60rkey').Value:=dm.ADOQuery1D60RKEY.Value;
 dm.Aqinfor90.Open;


  form_report.ppReport1.Reset;
  form_report.ppReport1.Template.FileName :=
    stringReplace(UpperCase(extractfilepath(paramstr(0))),'EXEC\','NIERP\REPORT\',[rfReplaceAll])+
      'sales_order.rtm';
  form_report.ppReport1.Template.LoadFromFile;


 s:='                     ';

 for i:=1 to dm.ado89.RecordCount do
  begin
   if odd(dm.ado89.RecordCount) then
//   if odd(i) then
   if i<=(dm.ado89.RecordCount+1)/2 then
    begin
     form_report.ppMemo1.Lines.Add(' '+trim(dm.ado89parameter_desc.Value)+
     copy(s,1,21-length(trim(dm.ado89parameter_desc.Value)))+
     trim(dm.ado89tvalue.Value)+
     copy(s,1,20-length(trim(dm.ado89tvalue.Value)))+
      dm.ado89unit_name.Value);
    end
   else
    begin
     form_report.ppMemo2.Lines.Add(trim(dm.ado89parameter_desc.Value)+
     copy(s,1,21-length(trim(dm.ado89parameter_desc.Value)))+
     trim(dm.ado89tvalue.Value)+
     copy(s,1,20-length(trim(dm.ado89tvalue.Value)))+
     dm.ado89unit_name.Value);
    end
  else
   if i<=(dm.ado89.RecordCount)/2 then
    begin
     form_report.ppMemo1.Lines.Add(' '+trim(dm.ado89parameter_desc.Value)+
     copy(s,1,21-length(trim(dm.ado89parameter_desc.Value)))+
     trim(dm.ado89tvalue.Value)+
     copy(s,1,20-length(trim(dm.ado89tvalue.Value)))+
      dm.ado89unit_name.Value);
    end
   else
    begin
     form_report.ppMemo2.Lines.Add(trim(dm.ado89parameter_desc.Value)+
     copy(s,1,21-length(trim(dm.ado89parameter_desc.Value)))+
     trim(dm.ado89tvalue.Value)+
     copy(s,1,20-length(trim(dm.ado89tvalue.Value)))+
     dm.ado89unit_name.Value);
    end;
   dm.ado89.Next;
  end;

  form_report.ppReport1.SaveAsTemplate:=false;
  form_report.ppReport1.Print;

 dm.ado89.Close;
 dm.ado60.Close;
 dm.AQ0493.Close;
 dm.ado0278.Close;
 dm.Aqinfor90.Close;
 form_report.Free;
end;

procedure TForm1.N25Click(Sender: TObject);
begin
{ form_mreport:=tform_mreport.Create(application);
 dm.AQ0493.open;
 form_mreport.ADO12.Open;
 form_mreport.ADO60.Open;
 form_mreport.ADO97.Open;
 form_mreport.ADO50.Open;
 form_mreport.ShowModal;
 form_mreport.Free;
} 
end;

procedure TForm1.pact_auth;
begin
 with dm.ADOQuery5 do
  begin
   close;
   sql.Clear;
   sql.Add('SELECT data0091.rkey');
   sql.Add('FROM data0091 INNER JOIN');
   sql.Add('Data0007 ON data0091.group_ptr = Data0007.RKEY INNER JOIN');
   sql.Add('Data0008 ON Data0007.RKEY = Data0008.PR_GRP_POINTER INNER JOIN');
   sql.Add('Data0025 ON Data0008.RKEY = Data0025.PROD_CODE_PTR');
   sql.Add('where data0025.rkey='+dm.ADOQuery1CUST_PART_PTR.AsString);
   sql.Add('order by data0091.rkey');
   open;
  end;
  if not dm.ADOQuery5.IsEmpty then
  begin
    dm.ADOQuery1.Edit;
    dm.ADOQuery1D60STATUS.Value := 1;
    if dm.ADOQuery1quote_price.Value=0 then
    begin
      //jacky zhong 2015-11-14 ��������Ĭ����Ҫ�ύ��δ�������ύ��ʱ���жϣ��Ƿ���Ҫ����
      if ((dm.ADOQuery1.FieldByName('ttype').AsInteger=0) and (dm.aq192aptaxontax.Value='Y'))  //������Ҫ����
        or ((dm.ADOQuery1.FieldByName('ttype').AsInteger=1) and (dm.aq192artaxontax.Value='Y')) then //������Ҫ����
      begin

        if messagedlg('����δ�����Ƿ���Ҫ�ύ������ȷ��?',mtConFirmation,[mbYes,mbNo],0)= mryes then
          self.aq97update()
        else
        begin
          dm.ADOQuery1quote_price.Value:=3;
          dm.ADOQuery1D60SCH_DATE.Value:=dm.ADOQuery1ORIG_SCHED_SHIP_DATE.Value;
        end;
      end
      else
      begin
        dm.ADOQuery1quote_price.Value:=3;
        dm.ADOQuery1D60SCH_DATE.Value:=dm.ADOQuery1ORIG_SCHED_SHIP_DATE.Value;
      end;
    end;
    dm.ADOQuery1.Post;
  end
  else
    showmessage('�ύ����������ɹ�,���������ò�Ʒ����������!');
end;

procedure TForm1.N13Click(Sender: TObject);
var
 rkey60:integer;
 status:string;
begin
if (strtoint(vprev) <> 4) then
  messagedlg('�Բ���!��û�иö����رյ�Ȩ��',mtinformation,[mbok],0)
else
 if messagedlg('��ȷ��Ҫ�ֹ��᰸�����۶�����',mtconfirmation,[mbyes,mbno],0)=mryes then
  try
  edit_note:=Tedit_note.Create(application);
  edit_note.Caption:='���۶������±�,�ر�:'+dm.ADOQuery1D60SALES_ORDER.Value;
//20160308tang�޸�            
  edit_note.Label9.Caption:=' �����ļ���/�ر�ԭ��:';
  edit_note.iMenu:=2;// �ر�
   with dm.ADOQuery3 do
   begin
    if active=true then active:=false;
    sql.Clear;
    sql.Add('select RemarkSO from data0060 where  Rkey='+dm.ADOQuery1.fieldbyname('D60RKEY').AsString);
    active:=true;
    if not isempty then edit_note.Memo1.Text := fieldvalues['RemarkSO'];
   end;
//end 20160308
  if edit_note.ShowModal=mrok then
   begin
    if (not dm.ADOQuery3.IsEmpty) and (trim(edit_note.Memo1.Text)<>'') then
     begin             //ԭ��¼�м��±������޸���
      dm.ADOQuery3.Edit;
      dm.ADOQuery3.FieldValues['RemarkSO']:=edit_note.Memo1.Text;
      dm.ADOQuery3.Post;
//     end
//    else
//     if (not dm.AQ9711.IsEmpty) and (trim(edit_note.Memo1.Text)='') then   //���ԭ��¼�м��±�����ɾ����
//      dm.AQ9711.Delete
//     else
//      if (dm.AQ9711.IsEmpty) and  (trim(edit_note.memo1.Text)<>'') then    //���ԭ��¼û�м��±����������˼��±�
//       begin
//        dm.AQ9711.Append;
//        dm.AQ9711.FieldByName('file_pointer').AsString:=dm.ADOQuery1.fieldbyname('d60rkey').AsString;
//        dm.AQ9711.Fieldvalues['source_type']:=60;
//        dm.AQ9711.FieldValues['memo_text']:=edit_note.Memo1.Text;
//        dm.AQ9711.post;
       end;

     status:=dm.ADOQuery1status.Value;
     dm.ADOQuery1.Edit;
     dm.ADOQuery1D60STATUS.Value:=3;    //����ر�
     dm.ADOQuery1.Post;
     with dm.ADOQuery5 do
      begin
       close;                  //��¼���۶��������������(��־�ļ�)
       sql.Clear;
       sql.Add('insert into data0318 (SALES_ORDER_PTR,TRANS_TYPE,TRANS_DESCRIPTION,');
       sql.Add('FROM_string,TO_string,USER_PTR,TRANS_DATE,PROGRAM_SOURCE,file_number)');
       sql.Add('values ('+dm.ADOQuery1D60RKEY.AsString+',11,''�ֹ������۶����᰸'',');
       sql.Add(''''+status+''','''+dm.ADOQuery1status.AsString+''','+rkey73+',');
       sql.add('getdate(),32,'''+trim(edit_note.Edit1.Text)+''')');
       ExecSQL;
      end;

     with dm.ado06 do
      begin
       close;
       Parameters.ParamByName('@v_flag').Value:=1;
       Parameters.ParamByName('@d60sales_order').Value:=dm.ADOQuery1D60SALES_ORDER.Value;
       open;
      end;
    if (not dm.ado06.IsEmpty)  and
      (messagedlg('�رն�����ͬʱ�ݻ���������ҵ����?',mtConfirmation,[mbYes,mbNo],0)= mrYes) then
       while not dm.ado06.Eof do
        begin
         if dm.ado06PROD_STATUS.Value=4 then
          with dm.ADOQuery5 do
           begin
           close;
           sql.Clear;
           sql.Text:='insert into data0117(Source_ptr,Source_Type,Empl_ptr,Tdate,Action,Remark) '+
            ' values ('+dm.ado06rkey.AsString+',2,'+User_ptr+',getdate(),1,'+QuotedStr('�г������ݻ������ⷢ�����ݻ�')+')';
           ExecSQL;
           end
         else
          with dm.ADOQuery5 do
           begin
           close;
           sql.Clear;
           sql.Text:='insert into data0117(Source_ptr,Source_Type,Empl_ptr,Tdate,Action,Remark) '+
            ' values ('+dm.ado06rkey.AsString+',2,'+User_ptr+',getdate(),1,'+QuotedStr('�г������ݻ����¹����ݻ�')+')';
           ExecSQL;
           end;
         dm.ado06.Edit;
         if dm.ado06PROD_STATUS.Value=2 then
          dm.ado06PROD_STATUS.Value:=102    //����ǰ�ݻ�
         else
          dm.ado06PROD_STATUS.Value:=103;  //�������ݻ�
         dm.ado06.Post;
         dm.ado06.Next;
        end;
     rkey60 := dm.ADOQuery1D60RKEY.Value;
     dm.ADOQuery1.Close;
     dm.ADOQuery6.Close;
     dm.ADOQuery1.Open;
     dm.ADOQuery6.Open;
     dm.ADOQuery1.Locate('d60rkey',rkey60,[]);
    end;

   finally
    edit_note.free;
   end;

end;

procedure TForm1.N14Click(Sender: TObject);
var
 rkey60:integer;
 status:string;
begin
if (strtoint(vprev)=1) or (strtoint(vprev)=3) then
  messagedlg('�Բ���!��û�иó���Ŀ�дȨ��',mtinformation,[mbok],0)
else
 if messagedlg('��ȷ��Ҫ�ӽ᰸�������𶯴����۶�����',mtconfirmation,[mbyes,mbno],0)=mryes then
  begin
   status:=dm.ADOQuery1status.Value;
   dm.ADOQuery1.Edit;
   dm.ADOQuery1D60STATUS.Value := 1;
   dm.ADOQuery1.Post;
   with dm.ADOQuery5 do
   begin
    close;                  //��¼���۶��������������(��־�ļ�)               `
    sql.Clear;
    sql.Add('insert into data0318 (SALES_ORDER_PTR,TRANS_TYPE,TRANS_DESCRIPTION,');
    sql.Add('FROM_string,TO_string,USER_PTR,TRANS_DATE,PROGRAM_SOURCE)');
    sql.Add('values ('+dm.ADOQuery1D60RKEY.AsString+',11,''�ֹ������۶����ӽ᰸��������'',');
    sql.Add(''''+status+''','''+dm.ADOQuery1status.AsString+''','+rkey73+',');
    sql.add('getdate(),32)');
    ExecSQL;
   end;
   rkey60 := dm.ADOQuery1d60rkey.Value;
   dm.ADOQuery1.Close;
   dm.ADOQuery6.Close;
   dm.ADOQuery1.Open;
   dm.ADOQuery6.Open;
   dm.ADOQuery1.Locate('d60rkey',rkey60,[]);
  end;
end;

procedure TForm1.BitBtn3Click(Sender: TObject);
var
 rkey:integer;
begin
 rkey:=dm.ADOQuery1D60RKEY.Value;
 dm.ADOQuery1.Close;
 dm.ADOQuery6.Close;
 dm.ADOQuery1.Open;
 dm.ADOQuery6.Open;
 if rkey>0 then dm.ADOQuery1.Locate('d60rkey',rkey,[]);
end;

procedure TForm1.N15Click(Sender: TObject);
begin
form13:=tform13.Create(application);
form13.dtpk1.Date:=dm.adoquery1.Parameters.ParamValues['dtpk1'];
form13.dtpk2.Date:=dm.adoquery1.Parameters.ParamValues['dtpk2']-1;
if not dm.ADOQuery1.IsEmpty then
 form13.Edit1.Text := dm.ADOQuery1D60SALES_ORDER.Value;
form13.ShowModal;
form13.Free;
end;

procedure TForm1.CheckBox6Click(Sender: TObject);
begin
checkvar
end;


procedure TForm1.Edit1Change(Sender: TObject);
begin
 if trim(Edit1.text)<>'' then
  dm.adoquery1.Filter := field_name+' like ''%'+trim(edit1.text)+'%'''
 else
  dm.adoquery1.filter := '';
end;

procedure TForm1.DBGrid1TitleClick(Column: TColumn);
begin
if (column.FieldName <> dm.adoquery1.IndexFieldNames) and
   (column.FieldName <> 'status') and
   (column.FieldName <> 'quote_auth') and
   (column.FieldName <> 'Prod_rel') then
 dm.adoquery1.IndexFieldNames:=column.FieldName;

if (column.ReadOnly) and (field_name<>column.FieldName) then
 begin
  label4.Caption:=column.Title.Caption;
  self.field_name:=column.FieldName;
  edit1.SetFocus;
  PreColumn.Title.Color := clBtnFace;
  Column.Title.Color := clred;
  PreColumn := column;
 end
else
 edit1.SetFocus;
 
end;

procedure TForm1.BitBtn2Click(Sender: TObject);
begin
Export_dbGrid_to_Excel(dbgrid1,self.Caption);
end;

procedure TForm1.BtFldsClick(Sender: TObject);
begin
PMFlds.Popup(mouse.CursorPos.x,mouse.CursorPos.y);
end;

procedure TForm1.BitBtn5Click(Sender: TObject);
begin
PopupMenu3.Popup(mouse.CursorPos.x,mouse.CursorPos.y);
end;

procedure TForm1.MenuItem1Click(Sender: TObject);
begin
try
form_report:= Tform_report.Create(application);
form_report.ppReport1.Reset;
form_report.ppReport1.Template.FileName :=
  stringReplace(UpperCase(extractfilepath(paramstr(0))),'EXEC\','NIERP\REPORT\',[rfReplaceAll])+
    'sales_order.rtm';
form_report.ppReport1.Template.LoadFromFile;
form_report.ppReport1.SaveAsTemplate:=true;
form_report.ppdesigner1.ShowModal;
finally
form_report.Free;
end;
end;

procedure TForm1.MenuItem2Click(Sender: TObject);
begin
try
  form13:= Tform13.Create(application);
  form13.ppReport1.Reset;
  form13.ppReport1.Template.FileName :=
      stringReplace(UpperCase(extractfilepath(paramstr(0))),'EXEC\','NIERP\REPORT\',[rfReplaceAll])+
        'much_Asoreport.rtm';
  form13.ppReport1.Template.LoadFromFile;
  form13.ppReport1.SaveAsTemplate:=true;
  form13.ppdesigner1.ShowModal;
finally
  form13.Free;
end;
end;

procedure TForm1.BitBtn6Click(Sender: TObject);
begin
  if (strtoint(vprev)=1) then
  begin
    messagedlg('�Բ���!��û�иó���Ŀ�дȨ��',mtinformation,[mbok],0);
  end
  else
  try
    frmViewCredit:= TfrmViewCredit.Create(Application);
    frmViewCredit.prev:= strtoint(vprev);
    frmViewCredit.ShowModal;
  finally
    frmViewCredit.free;
  end;


end;

procedure TForm1.N21Click(Sender: TObject);
begin
  frmSCPOrpt:=TfrmSCPOrpt.Create(application);
  try
    frmSCPOrpt.dtpk1.Date:=dm.adoquery1.Parameters.ParamValues['dtpk1'];
    frmSCPOrpt.dtpk2.Date:=dm.adoquery1.Parameters.ParamValues['dtpk2']-1;
    if not dm.ADOQuery1.IsEmpty then
    begin
//     frmSCPOrpt.Edit1.Text := dm.ADOQuery1D60SALES_ORDER.Value;
     frmSCPOrpt.Edit3.Text := dm.ADOQuery1D97PO_NUMBER.Value;
     frmSCPOrpt.Edit11.Text:= dm.ADOQuery1code.Value;
     frmSCPOrpt.label85.Caption:= dm.ADOQuery1ABBR_NAME.Value;
    end;
    frmSCPOrpt.ShowModal;
  finally
    frmSCPOrpt.Free;
  end;
end;

procedure TForm1.N26Click(Sender: TObject);
begin
  try
    frmSCPOrpt:= TfrmSCPOrpt.Create(application);
    frmSCPOrpt.ppReport1.Reset;
    frmSCPOrpt.ppReport1.Template.FileName :=
        stringReplace(UpperCase(extractfilepath(paramstr(0))),'EXEC\','NIERP\REPORT\',[rfReplaceAll])+
          'SCPurPOrpt.rtm';
    frmSCPOrpt.ppReport1.Template.LoadFromFile;
    frmSCPOrpt.ppReport1.SaveAsTemplate:=true;
    frmSCPOrpt.ppdesigner1.ShowModal;
  finally
    frmSCPOrpt.Free;
  end;
end;

procedure TForm1.N27Click(Sender: TObject);
var
  f:string;
  fs: TMemoryStream;
begin
   with dm.aqTmp do
   begin
     close;
     sql.Clear;
     sql.Add('SELECT file_content,filename FROM Data0097 WHERE (file_content is not null) and RKEY =  '+dm.ADOQuery1.FieldByName('PURCHASE_ORDER_PTR').AsString);
     open;
   end;
  if dm.aqTmp.RecordCount=0 then
  begin
    ShowMessage('�ĵ�δ�ϴ�');
    Abort;
  end;
  fs := TMemoryStream.Create;
  TBlobfield(dm.aqTmp.fieldbyname('file_content')).SaveToStream(fs);
  UnPackStream(fs);
  if not DirectoryExists(TmpFileDir) then
    if not CreateDir(TmpFileDir) then  raise Exception.Create('������ʱ�ļ�Ŀ¼����: '+TmpFileDir);
  f:=TmpFileDir+dm.aqTmp.fieldbyname('filename').AsString;
  fs.SaveToFile(f);
  fs.Free;
  ShellExecute(self.Handle,nil,pchar(f),nil,nil,SW_SHOWNORMAL);   
end;

procedure TForm1.PMFldsPopup(Sender: TObject);
begin
  if (strtoint(vprev) <= 3)  then
   begin
   (sender as TPopupmenu).Items[9].Enabled:=false;
   (sender as TPopupmenu).Items[11].Enabled:=false;
   end;
end;

procedure TForm1.BitBtn7Click(Sender: TObject);
var i:Integer;
begin
  if not dm.ADOQuery1.IsEmpty then
  begin
    i:=1;
    dm.ADOQuery1.DisableControls;
    dm.ADOQuery1.First;
    while not dm.ADOQuery1.Eof do
    begin
      StringGrid1.RowCount:=StringGrid1.RowCount+1;
      StringGrid1.Cells[0,i]:=dm.ADOQuery1.FieldByName('MANU_PART_DESC').AsString;
      StringGrid1.Cells[1,i]:=dm.ADOQuery1.FieldByName('D97PO_NUMBER').AsString;
      StringGrid1.Cells[2,i]:=dm.ADOQuery1.FieldByName('ANALYSIS_CODE_2').AsString;
      StringGrid1.Cells[3,i]:=dm.ADOQuery1.FieldByName('PARTS_ORDERED').AsString;
      StringGrid1.Cells[4,i]:=dm.ADOQuery1.FieldByName('ENT_DATE').AsString;
      StringGrid1.Cells[5,i]:=dm.ADOQuery1.FieldByName('D60SALES_ORDER').AsString;
      dm.ADOQuery1.Next;
      i:=i+1;
    end;
    dm.ADOQuery1.EnableControls;
    Export_Grid_to_Excel(StringGrid1,Self.Caption,False);
  end;
end;

procedure TForm1.BitBtn8Click(Sender: TObject);
begin
 if (strtoint(vprev)=1) or (strtoint(vprev)=3) then
 begin
  messagedlg('�Բ���!��û�иó���Ŀ�дȨ��',mtinformation,[mbok],0);
  exit;
 end
 else
 begin
  ExcelToDB;
  BitBtn3Click(Sender);
 end;
end;

procedure TForm1.ExcelToDB;
var
  fileName:String;
  iCount, jCount,i: Integer;
  XLApp: variant;
  Sheet: Variant;
  AdoCon:TADOConnection;
  AdoTmps,AdoTmp:TADOQuery;
  Rkey25,Rkey23,Rkey15,rkey04,rkey97:string;
  exch_rate:Double;
  tax_2:Currency;
  dDate:TDateTime;
 v_seed,v_last,new_seed,invoice:string;
 v_length,control_no:byte;
begin
  if OpenDialog1.Execute then  fileName:=OpenDialog1.FileName else exit;
  Screen.Cursor := crHourGlass;
  if not VarIsEmpty(XLApp) then
   begin
    XLApp.DisplayAlerts := False;
    XLApp.Quit;
    VarClear(XLApp);
   end;
  try
   XLApp := CreateOleObject('Excel.Application');
  except
   Screen.Cursor := crDefault;
   Exit;
  end;
  dDate:=getsystem_date(dm.aqTmp,0);
  AdoTmps:=TADOQuery.Create(Application);
  AdoTmp:=TADOQuery.Create(Application);
  AdoCon:=TADOConnection.Create(Application);
  AdoCon.ConnectionString:='Provider=SQLOLEDB.1;Password=62ddf8f60269678;Persist Security Info=True;User ID=WZPCBConnect;Initial Catalog=wisdompcb;Data Source=172.18.0.8';
  AdoCon.LoginPrompt:=False;
  AdoCon.Connected:=True;
  AdoTmps.Connection:=AdoCon;
  AdoTmp.Connection:=dm.ADOConnection1;
   try
     XLApp.workBooks.Open(fileName);
     Sheet := XLApp.Workbooks[1].WorkSheets[1];
     DM.ADOQuery1.DisableControls;
     for iCount:=2 to 65535 do
     begin
       if (trim(XLApp.workbooks[1].sheets[1].cells[iCount,6]) = '') then Break;
       if (trim(XLApp.workbooks[1].sheets[1].cells[iCount,7]) = '') then
       begin
         ShowMessage('�������۵���Ӧ�ı������δ��д���������');
         exit;
       end;
       if (trim(XLApp.workbooks[1].sheets[1].cells[iCount,8]) = '') then
       begin
         ShowMessage('�������۵���Ӧ�Ŀͻ�����δ��д���������');
         exit;
       end;
       if (trim(XLApp.workbooks[1].sheets[1].cells[iCount,9]) = '') then
       begin
         ShowMessage('�������۵���Ӧ���ָⷢ����Ӧ��δ��д���������');
         exit;
       end;
       if (trim(XLApp.workbooks[1].sheets[1].cells[iCount,10]) = '') then
       begin
         ShowMessage('�������۵���Ӧ�Ĺ���δ��д���������');
         exit;
       end;
     end;
     for iCount:=2 to 65535 do
     begin
       if (trim(XLApp.workbooks[1].sheets[1].cells[iCount,6]) = '') then Break;
       dm.qrytmp.Close;
       dm.qrytmp.SQL.Clear;
       dm.qrytmp.SQL.Text:='select * from data0097 where PO_NUMBER ='''+trim(XLApp.workbooks[1].sheets[1].cells[iCount,2])+''' ';
       dm.qrytmp.Open;
       if dm.qrytmp.IsEmpty then
       begin
         MessageDlg('��'+inttostr(iCount)+'�пͻ���������ϵͳ�в����ڻ�״̬������,��ȷ���ͻ��������Ƿ���ȷ!',mtInformation,[mbok],1);
         Exit;
       end;
       Rkey97:=dm.qrytmp.FieldByName('Rkey').AsString;
       AdoTmps.Close;
       AdoTmps.SQL.Clear;
       AdoTmps.SQL.Text:='select data0060.*,data0005.EMPLOYEE_NAME from data0060 inner join data0005 '
       +'on data0060.COMM_ASSIGNED_BY_E_P=data0005.rkey where SALES_ORDER='''+Trim(XLApp.workbooks[1].sheets[1].cells[iCount,6])+'''';
       AdoTmps.Open;
       if AdoTmps.IsEmpty then
       begin
         MessageDlg('��'+inttostr(iCount)+'�����۶����ڵ���ϵͳ�в�����,��ȷ�����۶����Ƿ����!',mtInformation,[mbok],1);
         Exit;
       end;
       dm.qrytmp.Close;
       dm.qrytmp.SQL.Clear;
       dm.qrytmp.SQL.Text:='select Rkey from data0025 where MANU_PART_NUMBER='''+trim(XLApp.workbooks[1].sheets[1].cells[iCount,7])+'''';
       dm.qrytmp.Open;
       if dm.qrytmp.IsEmpty then
       begin
         MessageDlg('��'+inttostr(iCount)+'�б��������ϵͳ�в�����,��ȷ����������Ƿ��ѽ�����!',mtInformation,[mbok],1);
         Continue;
       end;
       Rkey25:=dm.qrytmp.FieldByName('Rkey').AsString;
       AdoTmp.Close;
       AdoTmp.SQL.Clear;
       AdoTmp.SQL.Text:='select data0010.Rkey,data0012.RKey,data0010.CURRENCY_PTR,data0010.CONTACT_NAME_1,data0001.exch_rate,'
       +'data0012.rkey as Rkey12,data0012.LOCATION,data0012.ship_to_contact,data0012.ship_shipping_method,data0012.ship_to_phone,data0012.SHIP_FOB from data0010 '
       +' inner join data0012 on data0010.Rkey=data0012.CUSTOMER_PTR inner join data0001 on data0010.CURRENCY_PTR=data0001.Rkey '
       +' where data0010.CUST_CODE='''+trim(XLApp.workbooks[1].sheets[1].cells[iCount,8])+''' and data0010.CUSTOMER_TYPE<>4';
       AdoTmp.Open;
       if AdoTmp.IsEmpty then
       begin
         MessageDlg('��'+inttostr(iCount)+'�пͻ�������ϵͳ�в�����,��ȷ���ͻ������Ƿ���ȷ!',mtInformation,[mbok],1);
         Continue;
       end;
       dm.qrytmp.Close;
       dm.qrytmp.SQL.Clear;
       dm.qrytmp.SQL.Text:='select Rkey,TAX_2 from data0023 where CODE='''+trim(XLApp.workbooks[1].sheets[1].cells[iCount,9])+'''';
//       dm.qrytmp.SQL.Text:='select Rkey,TAX_2 from data0023 where CODE='''+trim(XLApp.workbooks[1].sheets[1].cells[iCount,9])+''' and ttype<>0 and status=0';
       dm.qrytmp.Open;
       if dm.qrytmp.IsEmpty then
       begin
         MessageDlg('��'+inttostr(iCount)+'�й�Ӧ�̴�����ϵͳ�в����ڻ�״̬������,��ȷ���ⷢ��Ӧ�̴����Ƿ���ȷ!',mtInformation,[mbok],1);
         Continue;
       end;
       Rkey23:=dm.qrytmp.FieldByName('Rkey').AsString;
       TAX_2:=dm.qrytmp.FieldByName('TAX_2').Value;
       dm.qrytmp.Close;
       dm.qrytmp.SQL.Clear;
       dm.qrytmp.SQL.Text:='select Rkey from data0015 where WAREHOUSE_CODE='''+trim(XLApp.workbooks[1].sheets[1].cells[iCount,10])+''' ';
       dm.qrytmp.Open;
       if dm.qrytmp.IsEmpty then
       begin
         MessageDlg('��'+inttostr(iCount)+'�й�����ϵͳ�в����ڻ�״̬������,��ȷ�����������Ƿ���ȷ!',mtInformation,[mbok],1);
         Continue;
       end;
       Rkey15:=dm.qrytmp.FieldByName('Rkey').AsString;
      //============================ �������ﴦ��=====================================
       if not dm.ADOConnection1.InTransaction then dm.ADOConnection1.BeginTrans;
     //*****************************************��ʼ����data0060�������ӱ�
       with dm.ADOQuery3 do
       begin
        if active=true then active:=false;
        sql.Clear;
        sql.Add('select * from data0060 where Rkey is NULL');
        active:=true;
          append;
          fieldbyname('ship_reg_tax_id').AsString := Rkey15;        //����ָ��
          fieldbyname('customer_ptr').AsString := AdoTmp.FieldByName('Rkey').AsString;        //�ͻ�ָ��
          fieldbyname('cust_part_ptr').AsString := Rkey25;       //��Ʒ�ͺ�ָ��
          fieldbyname('purchase_order_ptr').AsString :=Rkey97;  //�ɹ�����ָ��
          fieldbyname('CUST_SHIP_ADDR_PTR').AsString :=AdoTmp.FieldByName('Rkey12').AsString;  //װ�˵�ַָ��
          fieldbyname('CURRENCY_PTR').AsString :=AdoTmp.FieldByName('CURRENCY_PTR').AsString;        //��������
          fieldbyname('CUSTOMER_CONTACT').AsString :=AdoTmp.FieldByName('CONTACT_NAME_1').AsString;        //�ͻ�������
          fieldbyname('EXCH_RATE').AsString :=AdoTmps.fieldbyname('EXCH_RATE').AsString;                   //����
          fieldbyname('SHIPPING_CONTACT').AsString := AdoTmp.FieldBYName('ship_to_contact').AsString;           //װ��������
          fieldbyname('SHIP_CONTACT_PHONE').AsString := AdoTmp.FieldBYName('ship_to_phone').AsString;         //װ�������˵绰
          fieldbyname('SHIPPING_METHOD').AsString :=AdoTmp.FieldBYName('ship_shipping_method').AsString;            //װ�˷���
          fieldbyname('FOB').AsString := AdoTmp.FieldBYName('ship_fob').AsString;                         //�밶�۸�
          fieldbyname('COD_FLAG').AsString :=AdoTmps.fieldbyname('COD_FLAG').AsString;               //�����տ�
          fieldbyname('reg_tax_fixed_unused').AsString := '0';   //�Ϲ����ü��㷽��
          fieldbyname('CSI_USER_PTR').AsString := rkey73;      //ϵͳ�û�ָ��
          fieldbyname('ENTERED_BY_EMPL_PTR').AsString := user_ptr; //������Աָ��
          fieldbyname('comm_assigned_by_e_p').AsString := user_ptr;//ӵ��ָ����Ա
          fieldbyname('rush_charge_pct_used').AsString :=AdoTmps.fieldbyname('rush_charge_pct_used').AsString;//�������������깤���ڲ��
          fieldbyname('so_style').AsInteger :=AdoTmps.fieldbyname('so_style').AsInteger;        //�������
          fieldvalues['so_tp'] := 1;                  //�ӹ���ʽ1�ⷢ
          fieldbyname('SO_OLDNEW').AsString :=AdoTmps.fieldbyname('SO_OLDNEW').AsString;     //�����¾�
          fieldbyname('RUSH_CHARGE').AsString :=AdoTmps.fieldbyname('RUSH_CHARGE').AsString;     //��ֵ˰%;
          dm.qrytmp.Close;
          dm.qrytmp.SQL.Clear;
          dm.qrytmp.SQL.Text:='select D5_2.Rkey from data0005 D5_1 inner join data0005 as D5_2 '
          +'on D5_1.EMPLOYEE_NAME=D5_2.EMPLOYEE_NAME where D5_1.EMPLOYEE_NAME='''+Trim(AdoTmps.fieldbyname('EMPLOYEE_NAME').AsString)+'''';
          dm.qrytmp.Open;
          fieldbyname('COMM_ASSIGNED_BY_E_P').AsString :=dm.qrytmp.FieldBYName('Rkey').AsString;   //ҵ��Ա
          Fieldvalues['SUPPLIER_PTR']:=rkey23;  //�ָⷢ����Ӧ��
          Fieldvalues['TAX_2']:=tax_2;  //�ⷢ��Ӧ�����ɱ�����
          fieldbyname('STATE_PROD_TAX_FLAG').AsString :=AdoTmps.fieldbyname('STATE_PROD_TAX_FLAG').AsString;

           fieldbyname('STATE_TOOL_TAX_FLAG').AsString :=AdoTmps.fieldbyname('STATE_TOOL_TAX_FLAG').AsString;      //�Ƿ�Թ��߷�����˰

           fieldbyname('COMMISION_ON_TOOLING').AsString :=AdoTmps.fieldbyname('COMMISION_ON_TOOLING').AsString;      //�����Ƿ�ת��

           fieldbyname('TAX_IN_PRICE').AsString:=AdoTmps.fieldbyname('TAX_IN_PRICE').AsString;               //�۸��Ƿ�˰

         dm.qrytmp.Close;
         dm.qrytmp.SQL.Clear;
         dm.qrytmp.SQL.Text:='select SEED_VALUE from data0004 where table_name=''data0060''';
         dm.qrytmp.Open;
         Rkey04:=dm.qrytmp.FieldByName('SEED_VALUE').AsString+'-01';
          fieldbyname('SALES_ORDER').AsString := Rkey04;     //���۶���;
          fieldbyname('PARTS_ORDERED').AsString :=AdoTmps.fieldbyname('PARTS_ORDERED').AsString;   //����;
          FieldByName('to_be_planned').asstring :=AdoTmps.FieldByName('to_be_planned').asstring;   //�����ƻ�
          FieldByName('to_be_confirmed').asstring := AdoTmps.FieldByName('to_be_confirmed').asstring; //����ȷ��
          fieldbyname('PART_PRICE').AsString :=formatfloat('0.00000000',AdoTmps.fieldbyname('PART_PRICE').Value/0.95);      //�۸�;
          fieldbyname('REFERENCE_NUMBER').AsString :=AdoTmps.fieldbyname('REFERENCE_NUMBER').AsString;      //�ο���ע
          fieldbyname('DISCOUNT').AsString := '0';        //�ۿ�%;
          fieldbyname('P_CODE').AsString :=AdoTmps.fieldbyname('P_CODE').AsString;          //����;
          fieldbyname('ORIG_REQUEST_DATE').AsString :=AdoTmps.fieldbyname('ORIG_REQUEST_DATE').AsString;  //�ͻ�����
          fieldbyname('ORIG_SCHED_SHIP_DATE').AsString :=AdoTmps.fieldbyname('ORIG_SCHED_SHIP_DATE').AsString;//�ƻ�����
          fieldbyname('DUE_DATE').AsString :=AdoTmps.fieldbyname('DUE_DATE').AsString;         //ԭʼ�ͻ�����
          fieldbyname('CONSUME_FORECASTS').AsString := '0';    //Ԥ��ķ�
          fieldbyname('BACKWARD_DAYS').AsString := '0';        //�������
          fieldbyname('FORWARD_DAYS').AsString := '0';         //��ǰ����
          fieldbyname('ANALYSIS_CODE_1').AsString := AdoTmps.fieldbyname('ANALYSIS_CODE_1').AsString;
          fieldbyname('ANALYSIS_CODE_2').AsString := AdoTmps.fieldbyname('ANALYSIS_CODE_2').AsString;
          fieldbyname('ANALYSIS_CODE_3').AsString := AdoTmps.fieldbyname('ANALYSIS_CODE_3').AsString;
          fieldbyname('ANALYSIS_CODE_4').AsString := AdoTmps.fieldbyname('ANALYSIS_CODE_4').AsString;
          fieldbyname('ANALYSIS_CODE_5').AsString := AdoTmps.fieldbyname('ANALYSIS_CODE_5').AsString;
          fieldbyname('set_ordered').AsString := AdoTmps.fieldbyname('set_ordered').AsString;
          fieldbyname('set_price').AsString := AdoTmps.fieldbyname('set_price').AsString;
          fieldbyname('TOTAL_ADD_L_PRICE').AsString := AdoTmps.fieldbyname('TOTAL_ADD_L_PRICE').AsString;    //���߷����ܼ�
          fieldbyname('ent_date').AsString:=FormatDateTime('yyyy-MM-dd HH:mm:ss',dDate);//�������� ϵͳ������ʱ��
          Fieldvalues['status']:=1;      //״̬Ϊδ�ύ(040207�޸�)
          Fieldvalues['prod_rel']:='2';  //�������ű����ȷ�ϵ�
          FieldByName('parts_alloc').AsString :=formatfloat('0.00000000',AdoTmps.FieldByName('parts_alloc').Value/0.95); //����˰�۸�

          fieldvalues['quote_price']:=3;      //��ʾso������
          fieldbyname('RemarkSO').asstring:=AdoTmps.fieldbyname('RemarkSO').asstring; //���۶������±�
          fieldvalues['RemarkAudit']:=AdoTmps.fieldvalues['RemarkAudit']; //������±�
//          fieldbyname('ORIG_CUSTOMER').asstring:=AdoTmps.fieldbyname('ORIG_CUSTOMER').asstring;
          try
           post;
          except
//           on E: Exception do
//            begin
              dm.ADOConnection1.RollbackTrans;
//              messagedlg(E.Message,mterror,[mbcancel],0);
//              exit;
//            end;
           messagedlg('���ݱ���ʧ��,�������������û�ͬʱ������������֮ǰ�ύ,���Ժ�����!',mtwarning,[mbok],0);
           exit;
          end;

         dm.Ado04.Close;
         dm.Ado04.Open;
         v_seed := trim(dm.Ado04.FieldValues['seed_value']);
         v_length := length(trim(dm.Ado04.FieldValues['seed_value'])); //���г���
         control_no := dm.Ado04CONTROL_NO_LENGTH.Value;  //������󳤶�
         for i := v_length downto 1 do         //����data0004
         if (copy(v_seed,i,1)<'0') or (copy(v_seed,i,1)>'9') then  //�����������
          begin                               //��׺��1
           v_last := floattostr(100000000+strtofloat(copy(v_seed,i+1,v_length-i))+1);
           new_seed := copy(v_seed,1,i)+copy(v_last,control_no-(v_length-i)+1,v_length-i);
           dm.Ado04.Edit;            //ʹǰ׺�����׺��1
           dm.Ado04.FieldValues['seed_value'] := new_seed;
           dm.Ado04.Post;
           break;
          end
         else
          if i=1 then //�����һλ��Ȼ������
           begin
            v_last := floattostr(1000000000+strtofloat(v_seed)+1);
            new_seed := copy(v_last,control_no+1-v_length+1,v_length);
            dm.Ado04.Edit;
            dm.Ado04.FieldValues['seed_value'] := new_seed;
            dm.Ado04.Post;
           end;

//          dm.aQ62.Append;
//          dm.aQ62.Fieldvalues['so_ptr'] := stringgrid1.RowCount-1;
//          dm.aQ62.FieldByName('addl_cat_ptr').asstring := form3.StringGrid1.Cells[5,i];
//          dm.AQ62.FieldByName('amount').asstring := form3.StringGrid1.Cells[1,i];
//          dm.AQ62.FieldByName('free_amount').asstring := form3.StringGrid1.Cells[2,i];
//          dm.AQ62.FieldByName('costfree_amount').asstring := form3.StringGrid1.Cells[3,i];
//          dm.AQ62TAX_FLAG.Value:=form3.StringGrid1.Cells[4,i];
//          dm.AQ62.post;
//          dm.ADO360.Close;
//          dm.ADO360.Parameters[0].Value:=fieldvalues['rkey'];
//          dm.ADO360.Open;
//          dm.ADO360.Append;
//          dm.ADO360so_ptr.Value:=fieldvalues['rkey'];
//          dm.ADO360quantity.Value:=fieldvalues['PARTS_ORDERED'];
//          dm.ADO360sch_date.Value:=fieldvalues['ORIG_SCHED_SHIP_DATE'];
//          dm.ADO360.Post;
          try
            dm.ADOConnection1.CommitTrans;   //�����ύ
            dm.ADOQuery6.Close;
            dm.ADOQuery6.Open;
          except
            dm.ADOConnection1.RollbackTrans;
            messagedlg('���ݱ���ʧ��,���������Ա��ϵ!',mtwarning,[mbok],0);
          end;
       end;
     end;
     XLApp.workbooks[1].close;
   finally
     XLApp.quit;
     Screen.Cursor := crDefault;
     DM.ADOQuery1.EnableControls;
     AdoCon.Connected:=False;
     AdoCon.Free;
     AdoTmps.Connection:=nil;
     AdoTmps.Close;
     AdoTmps.Free;
     AdoTmp.Connection:=nil;
     AdoTmp.Close;
     AdoTmp.Free;
   end
end;

end.

