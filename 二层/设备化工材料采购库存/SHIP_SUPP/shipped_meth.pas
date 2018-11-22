unit shipped_meth;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, DBCtrls, Mask;

type
  TForm2 = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBText1: TDBText;
    DBEdit4: TDBEdit;
    DBText2: TDBText;
    DBEdit5: TDBEdit;
    Edit1: TEdit;
    BitBtn4: TBitBtn;
    Edit2: TEdit;
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure Edit1Enter(Sender: TObject);
    procedure Edit1Exit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn2Click(Sender: TObject);
    procedure save_note();
    procedure report_print();
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
   retn_quan:double;
  public
    { Public declarations }
  end;

var
  Form2: TForm2;
  edit_notex: tstringlist;
implementation
uses damo, shipmeth_search, note, main, report_r;
{$R *.dfm}

procedure TForm2.BitBtn3Click(Sender: TObject);
begin
 close;
end;

procedure TForm2.BitBtn4Click(Sender: TObject);
begin
 try
  form_shipmethod:=tform_shipmethod.Create(application);
  if form_shipmethod.ShowModal=mrok then
   begin
    edit1.Text :=form_shipmethod.ADOQuery1.fieldbyname('description').AsString;
    edit1.Font.Color := clwindowtext;
    edit2.SetFocus;
   end
  else
   edit1.SetFocus;
 finally
  form_shipmethod.free;
 end;
end;

procedure TForm2.Edit1Enter(Sender: TObject);
begin
 edit1.Font.Color := clblue;
end;

procedure TForm2.Edit1Exit(Sender: TObject);
begin
 edit1.Font.Color := clwindowtext;
end;

procedure TForm2.FormCreate(Sender: TObject);
var
 i:byte;
begin
 edit_notex:=tstringlist.Create;
 with dm.ADO2211 do
  begin
   active:=false;
   Parameters[2].Value := dm.ADO22rkey.Value;
   active:=true;
   if not isempty then
    for i:=1 to 4 do
     edit_notex.Add(fieldbyname('note_pad_line_'+inttostr(i)).AsString);
  end;
  dm.ADO95.Open;
  dm.ado210.open;
end;

procedure TForm2.FormDestroy(Sender: TObject);
begin
 edit_notex.Free;
end;

procedure TForm2.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 dm.ADO2211.Close;
 if dm.ADO22ttype.Value=2 then
 dm.ado210.close;
 dm.ADO95.Close;
end;

procedure TForm2.BitBtn2Click(Sender: TObject);
begin
 try
  edit_note:=tedit_note.Create(application);
  edit_note.Memo1.Lines.Assign(edit_notex);
 if edit_note.ShowModal=mrok then
   edit_notex.Text:=edit_note.Memo1.Text;
 finally
  edit_note.free;
 end;
end;

procedure TForm2.save_note();
var
 i:byte;
begin
 if (not dm.ADO2211.IsEmpty) and (trim(edit_notex.Text)<>'') then
  begin //ԭ��¼�м��±�
   dm.ADO2211.Edit;
   for i:=1 to edit_notex.Count do
    dm.ADO2211.fieldbyname('note_pad_line_'+inttostr(i)).asstring:=edit_notex.Strings[i-1];
    dm.ADO2211.Post;
  end
 else
  if (not dm.ADO2211.IsEmpty) and (trim(edit_notex.Text)='') then
   dm.ADO2211.Delete   //���ԭ��¼�м��±�����ɾ����
  else
   if (dm.ADO2211.IsEmpty) and (trim(edit_notex.Text)<>'') then
    begin           //���ԭ��¼û�м��±����������˼��±�
     dm.ADO2211.Append;
     dm.ADO2211.FieldByName('file_pointer').AsString:=dm.ADO22.fieldbyname('rkey').AsString;
     dm.ADO2211.Fieldvalues['source_type']:=22;
     for i:=1 to edit_notex.Count do
      dm.ADO2211.fieldbyname('note_pad_line_'+inttostr(i)).asstring:=edit_notex.Strings[i-1];
      dm.ADO2211.Post;
    end;
end;


procedure TForm2.BitBtn1Click(Sender: TObject);
begin
 dm.ADOConnection1.BeginTrans;
 try
 save_note();                     //����11���±�
//^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 dm.ADO22.Edit;
 dm.ADO22quan_returned.Value :=
 dm.ADO22quan_returned.Value+dm.ADO22quan_to_be_shipped.Value;
 
 retn_quan:=dm.ADO22quan_to_be_shipped.Value;
 dm.ADO22quan_to_be_shipped.Value := 0;
 dm.ADO22.Post;                           //����22
//^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 with dm.ADO95 do
  begin
   append;
   fieldvalues['tran_tp'] := 21;
   fieldvalues['invt_ptr'] := dm.ADO22inventory_ptr.Value;
   fieldvalues['srce_ptr'] := dm.ADO22rkey.Value;
   fieldbyname('user_ptr').AsString := form1.csi_rkey.caption;
   fieldvalues['quantity'] := retn_quan;
   FieldValues['tran_by'] := strtoint(form1.user_ptr.Caption);
   with dm.ADOQuery1 do
    begin
     active:=false;     //ȡ������ʱ���ֶθ�ֵ
     sql.Clear;
     sql.Add('select getdate() as serve_date');
     active:=true;
     dm.ado95.Fieldvalues['tran_date'] := fieldvalues['serve_date'];
    end;
   FieldByName('shipping_method').AsString := edit1.Text;    //װ�˷���
   FieldByName('reference_number').AsString := edit2.Text;   //barcode
   post;
  end;                                 //����95
//^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

//^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
if dm.ADO22ttype.Value=1 then      //����0071
 with dm.ADOQuery1 do
  begin
   active:= false;
   sql.Clear;
   sql.Add('select quan_retn,conversion_factor from data0071');
   sql.Add('where rkey='+dm.ADO22source_ptr.AsString);
   active:= true;
   edit;
   if fieldvalues['conversion_factor'] then
    fieldvalues['quan_retn']:=fieldvalues['quan_retn']+retn_quan/fieldvalues['conversion_factor']
   else
    fieldvalues['quan_retn']:=fieldvalues['quan_retn']+self.retn_quan;
   post;                         //�ɹ���λ�˻�
  end;
                   //ԭ�����˻�����Ϊ��POʱ�������޸�210
 with dm.ADO210 do  //����210 //2002.10.31�޸ĳ�210��������һ����¼
  begin
   append;
   fieldvalues['invt_ptr'] := dm.ADO22inventory_ptr.Value;   //17.rkey
   fieldvalues['po_link_ptr'] := dm.ADO22source_ptr.Value; //71.rkey
   fieldvalues['D0022_PTR'] := DM.ADO22rkey.Value;

   if dm.ADO22ttype.Value=1 then     //PO����
    if dm.ADOQuery1.FieldValues['conversion_factor']>0 then
     fieldvalues['quantity'] := retn_quan/dm.ADOQuery1.FieldValues['conversion_factor']
    else
     fieldvalues['quantity'] := retn_quan
   else                             //ֱ�ӽ���
    fieldvalues['quantity'] := retn_quan;

   fieldvalues['tdate'] := dm.ADO95.FieldValues['tran_date'];
   post;
  end;
//^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
  dm.ADOConnection1.CommitTrans;
 except
  dm.ADOConnection1.RollbackTrans;
  showmessage('���ݱ����������������,����û�гɹ�,�������Ա��ϵ!');
  exit;
 end;
 if messagedlg('�Ƿ��ӡװ�䵥?',mtconfirmation,[mbyes,mbno],0)=mryes then
  form2.report_print();
//^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
 ModalResult:=mrok;
end;

procedure TForm2.report_print();
begin
 try
  form_report:=tform_report.Create(application);
  form_report.ADO22.Close;
  form_report.ADO22.Parameters[0].Value := dm.ADO22rkey.Value;
  form_report.ADO22.Open;
  form_report.ADO95.Close;
  form_report.ADO95.Parameters[0].Value := dm.ADO95.FieldValues['rkey'];
  form_report.ADO95.Open;

  with dm.ADO2211 do
   begin
    active:=false;
    Parameters[2].Value := dm.ADO22rkey.Value;
    active:=true;
   end;

  form_report.ppReport1.Print;
 finally
  form_report.free;
 end;
end;

end.
