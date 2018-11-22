unit edit_return;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Grids, DBGrids, DB, ADODB, ComCtrls;

type
  TForm3 = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    DBGrid1: TDBGrid;
    ado95: TADOQuery;
    DataSource1: TDataSource;
    Label3: TLabel;
    Edit3: TEdit;
    Bar1: TStatusBar;
    ADOQuery1: TADOQuery;
    ado95rkey: TAutoIncField;
    ado95tdate: TDateTimeField;
    ado95QUAN_REJD: TFloatField;
    ado95EMPL_PTR: TIntegerField;
    ado95employee_name: TStringField;
    ADOQuery1rkey: TIntegerField;
    ADOQuery1empl_code: TStringField;
    ADOQuery1employee_name: TStringField;
    procedure FormActivate(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure save_note();
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
   v_close:byte;
  public
    { Public declarations }
  end;

var
  Form3: TForm3;
  edit_notex: tstringlist;
implementation
uses main,note;
{$R *.dfm}

procedure TForm3.FormActivate(Sender: TObject);
var
 i:byte;
begin
 adoquery1.Active := true;
 ado95.Active := true;
 if bitbtn1.Visible = true then
  bar1.SimpleText:= 'Ctrl+Del����ɾ��һ����¼'
 else
  bar1.SimpleText:= '���';

 with form1.ADOQuery2 do
  begin
   active:=false;
   sql.Clear;
   sql.Add('select * from data0011 where source_type=22 and');
   sql.Add('file_pointer='+form1.ADOQuery1.fieldbyname('rkey').AsString);
   active:=true;
   if not isempty then
    for i:=1 to 4 do
     edit_notex.Add(fieldbyname('note_pad_line_'+inttostr(i)).AsString);
  end;
end;

procedure TForm3.BitBtn3Click(Sender: TObject);
begin
 v_close:=1;
 ado95.CancelBatch();
 form1.ADOQuery2.Close;
 close;
end;

procedure TForm3.BitBtn1Click(Sender: TObject);
var
 return_total:single;
begin
 return_total:=0;
 ado95.First;

 while not ado95.Eof do
  begin
   if ado95QUAN_REJD.Value<=0 then
    begin
     messagedlg('�˻��������������ڵ�����!',mterror,[mbcancel],0);
     dbgrid1.SetFocus;
     exit;
    end
   else
    return_total:=return_total+self.ado95QUAN_REJD.Value;
   ado95.Next;
  end;

 if return_total>form1.adoquery1.FieldValues['quan_on_hand']+
                 form1.adoquery1.FieldValues['quan_to_be_shipped'] then
  begin
   messagedlg('�˻����������ܴ��ڿ���������!',mterror,[mbcancel],0);
   dbgrid1.SetFocus;
  end
 else
  begin
   save_note();
   ado95.UpdateBatch();
   form1.ADOQuery1.Edit;
   form1.adoquery1.FieldValues['quan_on_hand']:=
                     form1.adoquery1.FieldValues['quan_on_hand']+
                     form1.adoquery1.FieldValues['quan_to_be_shipped']-
                     return_total;
   form1.adoquery1.FieldValues['quan_to_be_shipped']:=return_total;
   form1.ADOQuery1.Post;
   v_close:=1;
   ModalResult := mrok;
  end;
end;

procedure TForm3.FormCreate(Sender: TObject);
begin
 edit_notex:=tstringlist.Create;
end;

procedure TForm3.FormDestroy(Sender: TObject);
begin
 edit_notex.Free;
end;

procedure TForm3.BitBtn2Click(Sender: TObject);
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

procedure TForm3.save_note();
var
 i:byte;
begin
 if (not form1.ADOQuery2.IsEmpty) and (trim(edit_notex.Text)<>'') then
  begin //ԭ��¼�м��±�
   form1.ADOQuery2.Edit;
   for i:=1 to edit_notex.Count do
    form1.ADOQuery2.fieldbyname('note_pad_line_'+inttostr(i)).asstring:=edit_notex.Strings[i-1];
    form1.ADOQuery2.Post;
  end
 else
  if (not form1.ADOQuery2.IsEmpty) and (trim(edit_notex.Text)='') then
   form1.ADOQuery2.Delete   //���ԭ��¼�м��±�����ɾ����
  else
   if (form1.ADOQuery2.IsEmpty) and (trim(edit_notex.Text)<>'') then
    begin           //���ԭ��¼û�м��±����������˼��±�
     form1.ADOQuery2.Append;
     form1.ADOQuery2.FieldByName('file_pointer').AsString:=form1.ADOQuery1.fieldbyname('rkey').AsString;
     form1.ADOQuery2.Fieldvalues['source_type']:=22;
     for i:=1 to edit_notex.Count do
      form1.ADOQuery2.fieldbyname('note_pad_line_'+inttostr(i)).asstring:=edit_notex.Strings[i-1];
      form1.ADOQuery2.Post;
    end;
end;

procedure TForm3.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if key=40 then              //������¼�ͷ��������һ����¼
 if ado95.RecNo=ado95.RecordCount then abort;
end;

procedure TForm3.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
 if v_close<>1 then
  begin
   ado95.CancelBatch();
   form1.ADOQuery2.Close;
  end;
end;

end.
