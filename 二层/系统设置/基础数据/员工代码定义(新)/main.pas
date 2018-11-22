unit main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, Grids, DBGrids, ComCtrls, Menus,
  DBGridEh,DB;

type
  Tmainform = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn5: TBitBtn;
    Edit1: TEdit;
    PM1: TPopupMenu;
    new: TMenuItem;
    edit: TMenuItem;
    copy: TMenuItem;
    delete: TMenuItem;
    PM2: TPopupMenu;
    Eh1: TDBGridEh;
    procedure Eh1TitleClick(Column: TColumnEh);
    procedure Edit1Change(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure newClick(Sender: TObject);
    procedure editClick(Sender: TObject);
    procedure deleteClick(Sender: TObject);
    procedure copyClick(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
    precolumn:Tcolumneh;
    sql_text:string;
    procedure item_click(sender:Tobject);
  public
    { Public declarations }
    is_new:boolean;
    bk:tbookmark;
  end;

var
  mainform: Tmainform;

implementation
uses detail,condition,damo,common,empl;

{$R *.dfm}

procedure Tmainform.FormCreate(Sender: TObject);
var i:integer;
    item:Tmenuitem;
begin
  if not App_init_2(dm.ADOConnection1) then
  begin
    showmsg('��������ʧ�ܣ�����ϵϵͳ����Ա��','��ʾ',1);
    application.Terminate;
  end;
  self.Caption:=application.Title;
  dm.ads05.Close;
  dm.ads05.Open;
  sql_text:=dm.ads05.CommandText;  //��¼ads05Ĭ��sql���
  precolumn:=eh1.Columns[0]; //��precolumn����ʼֵ
  for i:=1 to eh1.columns.Count do
  begin //��̬�����������ֶβ˵���
    item:=Tmenuitem.Create(self);
    item.Caption:=eh1.columns[i-1].Title.caption;
    if eh1.Columns[i-1].Visible then
      item.Checked:=true;
    item.onClick:=item_click;
    self.PM2.Items.Add(item);
  end;
end;

procedure tmainform.item_click(sender:Tobject);
var i:byte;
begin
  (sender as Tmenuitem).Checked:=not ((sender as Tmenuitem).Checked);
  if (sender as Tmenuitem).Checked then
    for i:=0 to eh1.Columns.Count-1 do
       if (sender as Tmenuitem).Caption=eh1.Columns[i].Title.Caption then
        begin
         eh1.Columns[i].Visible:=true;
         break;
        end;
  if not (sender as Tmenuitem).Checked then
    for i:=0 to eh1.Columns.Count-1 do
      if (sender as Tmenuitem).Caption=eh1.Columns[i].Title.Caption then
      begin
        eh1.Columns[i].Visible:=false;
        break;
      end;
end;

procedure Tmainform.Eh1TitleClick(Column: TColumnEh);
begin
  if column.Title.Caption<>'��������' then  //�Գ�"��������"�����ֶ�����
    if column.Title.SortMarker=smupeh then
    begin
      column.Title.SortMarker:=smdowneh;
      dm.ads05.IndexFieldNames:=column.FieldName+' DESC';
    end
    else
    begin
      column.Title.SortMarker:=smupeh;
      dm.ads05.IndexFieldNames:=column.FieldName;
    end
  else  //��"��������"�ֶ�����
  if column.Title.SortMarker=smupeh then
  begin
    column.Title.SortMarker:=smdowneh;
    dm.ads05.IndexFieldNames:='employee_id DESC';
  end
  else
  begin
    column.Title.SortMarker:=smupeh;
    dm.ads05.IndexFieldNames:='employee_id';
  end;

  if (column.ReadOnly) and (precolumn.FieldName<>column.FieldName) then
  begin //�Ȱѷ��ַ��͵�column��readonly������Ϊfalse,��Ϊ���ַ��Ͳ�����edit����
    label1.Caption:='������'+column.Title.Caption;
    precolumn.Title.Color:=clbtnface;
    column.Title.Color:=clred;
    precolumn:=column;
    edit1.Text:='';
  end;
  edit1.SetFocus;
end;

procedure Tmainform.Edit1Change(Sender: TObject);
begin
  if (trim(edit1.Text)<>'') and (precolumn.title.Caption<>'��������') then
    dm.ads05.Filter:=precolumn.FieldName+' like ''%'+trim(edit1.text)+'%'''
  else dm.ads05.Filter:='';
end;

procedure Tmainform.BitBtn1Click(Sender: TObject);
begin
  close;
  application.Terminate;
end;

procedure Tmainform.BitBtn2Click(Sender: TObject);
begin
  dm.ads05.Close;
  dm.ads05.Open;
end;

procedure Tmainform.BitBtn3Click(Sender: TObject);
var i:byte;
begin
  if condition_form.ShowModal=mrok then
  with dm.ads05 do
  begin
    close;
    commandtext:=sql_text;
    for i:=1 to condition_form.SGrid1.RowCount-1 do
      dm.ads05.CommandText:=dm.ads05.CommandText+condition_form.SGrid1.cells[2,i];
    open;
  end;
end;

procedure Tmainform.BitBtn4Click(Sender: TObject);
begin
  export_dbgrideh_to_excel(eh1,self.Caption);
end;

procedure Tmainform.BitBtn5Click(Sender: TObject);
begin
  pm2.Popup(mouse.CursorPos.X,mouse.CursorPos.Y);
end;

procedure Tmainform.newClick(Sender: TObject);
begin
   if (strtoint(vprev)=1) or (strtoint(vprev)=3) then
    messagedlg('�Բ���!��û�иó���Ŀ�дȨ��',mtconfirmation,[mbcancel],0)
  else
  begin
    detail_form:=Tdetail_form.Create(application);
    try
      is_new:=true;
      bk:=dm.ads05.GetBookmark();
      mainform.Hide;
      detail_form.ready_new;
      if detail_form.showmodal<>mrok then
         dm.ads05.GotoBookmark(bk);
    finally
      detail_form.Free;
      dm.ads05.FreeBookmark(bk);
    end;

  end;
end;

procedure Tmainform.editClick(Sender: TObject);
begin
  if (strtoint(vprev)=1) or (strtoint(vprev)=3) then
    messagedlg('�Բ���!��û�иó���Ŀ�дȨ��',mtconfirmation,[mbcancel],0)
  else
  begin
    detail_form:=Tdetail_form.Create(application);
    try
      dm.ads05.Edit;
      mainform.Hide;
      detail_form.ShowModal;
    finally
      detail_form.Free;
    end;
  end;
end;

procedure Tmainform.copyClick(Sender: TObject);
var tmp_array:array [1..20] of variant;
    i:word;
begin
  if (strtoint(vprev)=1) or (strtoint(vprev)=3) then
    messagedlg('�Բ���!��û�иó���Ŀ�дȨ��',mtconfirmation,[mbcancel],0)
  else
  begin
    detail_form:=Tdetail_form.Create(application);
    try
      is_new:=false;
      mainform.Hide;
      bk:=dm.ads05.GetBookmark();
      detail_form.ComboBox1.Text:=dm.ads05popedom_.Value;
      for i:=1 to 20 do //�ѵ�ǰ��¼���ݸ��Ƶ����� (��Ա���벻����)
        tmp_array[i]:=dm.ads05.Fields[i].Value;
      dm.ads05.Append;
      for i:=1 to 20 do //���������ݸ��Ƶ�������¼
        dm.ads05.FieldValues[dm.ads05.Fields[i].FieldName]:=tmp_array[i];
      with dm.aq34 do  //��ʾ������Ϣ
      begin
        close;
        parameters[0].Value:=dm.ads05employee_id.Value;
        open;
        detail_form.Edit1.Text:=dm.aq34dept_code.Value;
        detail_form.label18.Caption:=dm.aq34dept_name.Value;
        detail_form.dept_ptr:=dm.aq34rkey.Value;
      end;
      if detail_form.showmodal<>mrok then
        dm.ads05.GotoBookmark(bk); //����������������ԭ��¼
    finally
      detail_form.Free; //�ͷŴ�����Դ
    end;
  end;
end;

procedure Tmainform.deleteClick(Sender: TObject);
begin
  if (strtoint(vprev)=1) or (strtoint(vprev)=3) then
    messagedlg('�Բ���!��û�иó���Ŀ�дȨ��',mtconfirmation,[mbcancel],0)
  else
  begin
    if dm.ads05employee_name.Value='ϵͳ����Ա' then
    begin
      messagedlg('ϵͳ����Ա����ɾ����',mtwarning,[mbok],0);
      exit;
    end;
    if messagedlg('��ȷ��Ҫɾ��������¼��',mtconfirmation,[mbyes,mbno],0)=mryes then
      dm.ads05.Delete;
  end;
end;



end.
