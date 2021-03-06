unit Umain;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, StdCtrls, Buttons, ExtCtrls, Grids, DBGridEh, DB, ADODB;

type
  TForm_main = class(TForm)
    DBGridEh2: TDBGridEh;
    Splitter1: TSplitter;
    DBGridEh1: TDBGridEh;
    Panel1: TPanel;
    Label1: TLabel;
    BitBtn1: TBitBtn;
    BitBtn4: TBitBtn;
    Edit1: TEdit;
    BitBtn2: TBitBtn;
    PopupMenu1: TPopupMenu;
    mni_new: TMenuItem;
    N_Edit: TMenuItem;
    N_Check: TMenuItem;
    N4: TMenuItem;
    N_Del: TMenuItem;
    dsMain: TDataSource;
    qry_594: TADOQuery;
    ds594: TDataSource;
    qry_Main: TADOQuery;
    qry_Maininvt_ttyename: TWideStringField;
    qry_Mainrkey593: TIntegerField;
    qry_Mainguizhe: TWordField;
    qry_Mainlength: TWordField;
    qry_MainPARAMETER_PTR: TIntegerField;
    qry_594rkey593: TIntegerField;
    qry_594rec_no: TIntegerField;
    qry_594type_name: TStringField;
    qry_594type_code: TStringField;
    qry_594filter_name: TStringField;
    qry_MainPARAMETER_NAME: TStringField;
    qry_MainPARAMETER_DESC: TStringField;
    qry_Mainname: TWideStringField;
    qry_Mainstrguizhe: TStringField;
    qry_Mainrkey: TAutoIncField;
    procedure mni_newClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure DBGridEh1TitleClick(Column: TColumnEh);
    procedure Edit1Change(Sender: TObject);
    procedure qry_MainAfterScroll(DataSet: TDataSet);
    procedure N_EditClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure N_CheckClick(Sender: TObject);
    procedure N_DelClick(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
  private

    Frkey:integer;
    PreColumn: TColumnEh;
    field_name:string;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_main: TForm_main;


implementation

uses Unew, UDM,common;

{$R *.dfm}

procedure TForm_main.mni_newClick(Sender: TObject);


begin
 if (strtoint(vprev)=1) or (strtoint(vprev)=3) then
    messagedlg('对不起!您没有该程序的可写权限',mtinformation,[mbok],0)
    
 else
 begin

  try
    Form_edit:=TForm_edit.Create(Application);

    Form_edit.status:=0;
    DM.qry594.Close;
    DM.qry594.Parameters[0].Value :=0; //sql赋值
    DM.qry594.Open;

    if Form_edit.ShowModal=mrok then
    begin

    BitBtn2Click(BitBtn2);

    //ShowMsg('新增操作成功!',1);

     qry_Main.Locate('rkey',Form_edit.Frkey,[]);

    end;
  finally
    Form_edit.Free;
  end;
 end;
end;



procedure TForm_main.FormCreate(Sender: TObject);
begin
//if not app_init_2(DM.con1) then
// begin
//  showmsg('程序启动失败,请与管理员联系!',1);
//  application.Terminate;
// end;
  self.Caption:=application.Title;

  dm.con1.Open;
  rkey73:='851';
  user_ptr := '963';
  vprev := '4';
//
  PreColumn := DBGridEh1.Columns[0];
  field_name := DBGridEh1.Columns[0].FieldName;
  DBGridEh1.Columns[0].Title.Color:=clRed;

end;

procedure TForm_main.BitBtn2Click(Sender: TObject);
begin
 qry_Main.Close;
 qry_Main.Open;
 //qry_594.Close;
 //qry_594.Open;
end;

procedure TForm_main.BitBtn1Click(Sender: TObject);
begin
 Application.Terminate;
end;

procedure TForm_main.BitBtn4Click(Sender: TObject);
begin
 begin
 if not qry_Main.IsEmpty then
 if MessageDlg('您确认导出数据到Excel吗?',mtConfirmation,[mbYes, mbNo],0) =mryes then
  Export_dbGridEH_to_Excel(self.DBGridEh1,self.Caption);
end;
end;

procedure TForm_main.DBGridEh1TitleClick(Column: TColumnEh);
begin
  if DBGridEh1.DataSource.DataSet.Active then
  begin
    if DBGridEh1.DataSource.DataSet.FieldByName(Column.FieldName).FieldKind = fkCalculated then exit ; //=计算字段

      Frkey:=qry_Mainrkey.Value;

      if column.Title.SortMarker =smDownEh then
      begin
        column.Title.SortMarker:=smUpEh;
        qry_Main.Sort:=Column.FieldName;
      end
      else
      begin
        column.Title.SortMarker:=smDownEh;
        qry_Main.Sort:=Column.FieldName+' DESC';
      end;

   if Frkey<>-1 then  qry_Main.Locate('rkey',Frkey,[]);


  if (PreColumn.FieldName <> column.FieldName)
     and  (column.Field.DataType in [ftString,ftWideString]) then
   begin
    edit1.Text:='';
    edit1.SetFocus;
    label1.Caption := column.Title.Caption ;
    PreColumn.Title.Color := clBtnFace ;
    Column.Title.Color := clred ;
    PreColumn := column ;
   end
  else
    edit1.SetFocus;
end;


end;

procedure TForm_main.Edit1Change(Sender: TObject);
begin

  if Trim(Edit1.Text)<>'' then
  begin
    qry_Main.Filtered:=False;
    qry_Main.Filter:= PreColumn.FieldName + ' like ''%' + Trim(Edit1.Text)+ '%''';
    qry_Main.Filtered:=True;
  end
  else
  begin
    qry_Main.Filter:='';
  end;

end;

procedure TForm_main.qry_MainAfterScroll(DataSet: TDataSet);
begin
 if qry_main.isempty then exit;
 qry_594.Close;
 qry_594.Parameters.ParamByName('rkey593').Value:=qry_Main.FieldValues['rkey'];
 qry_594.open;


end;

procedure TForm_main.N_EditClick(Sender: TObject);
begin

  DM.qry594.Close;
  DM.qry594.Parameters[0].Value := qry_Main.FieldValues['rkey']; //2
  dm.qry594.Open;


  if (strtoint(vprev)=1) or (strtoint(vprev)=3) then

    messagedlg('对不起!您没有该程序的可写权限',mtinformation,[mbok],0)
   else
 begin

  try
     Form_edit:=TForm_edit.Create(Application);
    // Form_edit.edt_SChName.Enabled:=False;
     Form_edit.qry_Save593.Close;
     Form_edit.qry_Save593.Parameters[0].Value := qry_Main.FieldValues['rkey'];
     Form_edit.qry_Save593.open;
     Form_edit.status:=1; //编辑
     Form_edit.edt_SChName.Text:= qry_Maininvt_ttyename.Value;
     Form_edit.edt_rkey693.Text:= qry_Mainname.AsString;
     Form_edit.edt_rkey693.Tag:= qry_Mainrkey593.AsInteger;
     Form_edit.etd_Lenth.Text:= qry_Mainlength.AsString;
     Form_edit.edt_278.Text:= qry_MainPARAMETER_PTR.AsString;
     Form_edit.edt_278.Tag:= qry_MainPARAMETER_PTR.AsInteger;
     if  qry_Main.FieldByName('guizhe').Value = 1 then
     begin
       Form_edit.cbb_GH.ItemIndex:= 1
     end
     else
      Form_edit.cbb_GH.ItemIndex:= 0 ;
      qry_Main.Edit;
      qry_594.Edit;
    if Form_edit.ShowModal=mrok then

    begin
     //ShowMsg('操作成功!',1);
     qry_Main.Close;
     qry_Main.Open;
     qry_Main.Locate('rkey',Form_edit.Frkey,[]);
    end;
  finally
    Form_edit.Free;
  end;
 end;
 end;

procedure TForm_main.FormShow(Sender: TObject);
begin
    qry_Main.Close;
    qry_Main.Open;
    qry_594.Close;
    qry_594.Open;
end;

procedure TForm_main.N_CheckClick(Sender: TObject);
begin

  DM.qry594.Close;
  DM.qry594.Parameters[0].Value := qry_Main.FieldValues['rkey']; //2
  dm.qry594.Open;


     Form_edit:=TForm_edit.Create(Application);
     Form_edit.edt_SChName.Text:= qry_Maininvt_ttyename.Value;
     Form_edit.edt_rkey693.Text:= qry_Mainrkey593.AsString;
     Form_edit.etd_Lenth.Text:= qry_Mainlength.AsString;
     Form_edit.edt_278.Text:= qry_MainPARAMETER_PTR.AsString;
     if  qry_Main.FieldByName('guizhe').Value = 1 then
     begin
       Form_edit.cbb_GH.ItemIndex:= 1
     end
     else
     Form_edit.cbb_GH.ItemIndex:= 0 ;

     Form_edit.BitBtn2.Enabled:=False;
     Form_edit.Panel1.Enabled:=False;
     Form_edit.Panel4.Enabled:=False;


    if Form_edit.ShowModal=mrok then
    begin

    end;



end;

procedure TForm_main.N_DelClick(Sender: TObject);
begin
  if (strtoint(vprev)=1) or (strtoint(vprev)=3) then
  begin
   messagedlg('对不起!您没有该程序的可写权限',mtinformation,[mbok],0);
  end
  else
   if messagedlg('你确定要删除这条记录吗?',mtConfirmation,[mbyes,mbno],0)=mryes then
   try
     DM.con1.BeginTrans;

     DM.ADOQuery1.Close;
//     DM.ADOQuery1.SQL.Text:='delete from data0594 where  rkey593='+qry_Mainrkey.AsString;
//     DM.ADOQuery1.ExecSQL;

     DM.ADOQuery1.SQL.Text:='delete from data0593 where rkey='+qry_Mainrkey.AsString;
     DM.ADOQuery1.ExecSQL;


     DM.con1.CommitTrans;
     messagedlg('删除操作成功',mtinformation,[mbok],0);
     qry_Main.Close;
     qry_Main.Open;
     qry_594.Close;
     qry_594.Open;

   except
     DM.con1.RollbackTrans;

   end;

end;







procedure TForm_main.PopupMenu1Popup(Sender: TObject);
begin
  if qry_Main.IsEmpty then
  begin
    mni_new.Enabled:=False;
    N_Edit.Enabled:=False;
    N_Check.Enabled:=False;
    N_Del.Enabled:=False;
  end
  else
  begin
    mni_new.Enabled:=True;
    N_Edit.Enabled:=True;
    N_Check.Enabled:=True;
    N_Del.Enabled:=True;
   end;
end;

end.
