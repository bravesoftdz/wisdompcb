unit frm_main_u;

interface


uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Menus, Grids, DBGridEh, StdCtrls, Buttons, ExtCtrls, DBCtrls,
  ActnList;

type
    Tfrm_main = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    Panel3: TPanel;
    BtClose: TBitBtn;
    BtBrush: TBitBtn;
    BtQry: TBitBtn;
    BtFlds: TBitBtn;
    Label1: TLabel;
    Edit1: TEdit;
    Grd1: TDBGridEh;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N13: TMenuItem;
    N2: TMenuItem;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    N20: TMenuItem;
    BitBtn1: TBitBtn;
    Panel4: TPanel;
    N27: TMenuItem;
    PopupMenu3: TPopupMenu;
    DBGridEh1: TDBGridEh;
    DBMemo1: TDBMemo;
    DBMemo2: TDBMemo;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N14: TMenuItem;
    N17: TMenuItem;
    N10: TMenuItem;
    procedure FormCreate(Sender: TObject);
    procedure BtCloseClick(Sender: TObject);
    procedure BtBrushClick(Sender: TObject);
    procedure BtQryClick(Sender: TObject);
    procedure Grd1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure N1Click(Sender: TObject);
    procedure Grd1KeyPress(Sender: TObject; var Key: Char);
    procedure Grd1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Grd1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormDestroy(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Grd1TitleClick(Column: TColumnEh);
    procedure FormActivate(Sender: TObject);
    procedure Grd1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure N21Click(Sender: TObject);
    procedure N22Click(Sender: TObject);
    procedure N23Click(Sender: TObject);
    procedure N24Click(Sender: TObject);
    procedure N25Click(Sender: TObject);
    procedure N26Click(Sender: TObject); 
    procedure N9Click(Sender: TObject);
    procedure N17Click(Sender: TObject);
    procedure N18Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure N31Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure BtFldsClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Grd1Enter(Sender: TObject);
    procedure DBGridEh1Enter(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure DBGridEh1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure PopupMenu3Popup(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure Action1Execute(Sender: TObject);
    procedure Grd1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure DBGridEh1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure N10Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
 // private
    private
    PreColumn: TColumnEh;
    field_name:string;
    sSql :string;
    ssql_filter :string;
    FsCheck,FsSearch:string;
    paixu2:string;
    procedure item_click(sender:TObject);
    procedure init;
    procedure operation_charge;
  public
    { Public declarations }
  end;

var
  frm_main: Tfrm_main;
  rkey,rkey541: Integer;

const
 TmpFileDir = 'c:\tmp\';

implementation
 uses common, demo,shellAPI, frm_edit_u, Frm_QrySet_u,PubFunc, frm_check_u,
  frm_report_u, u_frmbusinessprocess, u_frmcpedit;
{$R *.dfm}
procedure TFrm_main.init;
var  i:byte;
  item:TMenuItem;
begin
  field_name := Grd1.Columns[1].FieldName;
  PreColumn := Grd1.Columns[1];
  Grd1.Columns[1].Title.Color := clred ;
  for i := 1 to Grd1.Columns.Count do
    begin
      item := TmenuItem.Create(self);
      item.Caption := Grd1.Columns[i - 1].Title.Caption;
      item.Checked :=Grd1.Columns[i - 1].Visible ;
      item.OnClick := item_click ;
    //showmessage('ok');
  end;
end;

procedure tfrm_main.operation_charge; //����Ȩ�������ض�λ
begin

end;

procedure Tfrm_main.BtCloseClick(Sender: TObject);
begin
  close;
end;

procedure Tfrm_main.BtBrushClick(Sender: TObject);
var
  rkey0: integer;
  paixu: string;
begin
  if not dm.ADO541.IsEmpty then
    begin
      rkey0 := demo.rkey541;
      paixu := dm.ADO541.Sort;
      dm.ADO541.Active:=false;
      dm.ADO541.Active:=true;
      dm.ADO541.Sort:=paixu;
      dm.ADO541.Locate('���',rkey0,[]);
    end;
end;

procedure Tfrm_main.BtQryClick(Sender: TObject);
var i: integer;
    Sqlstr:string;
begin

  if Frm_QrySet = nil then     Frm_QrySet:=TFrm_QrySet.Create(Application);

  if Frm_QrySet.ShowModal = mrok then
  begin

    if Frm_QrySet.sgrid1.RowCount-2>0 then
    begin
      for i:=1 to Frm_QrySet.sgrid1.RowCount-2
     do
      if  Frm_QrySet.sgrid1.Cells[2,i]<> '' then Sqlstr:=sqlstr+Frm_QrySet.sgrid1.Cells[2,i];
     end;

      FsSearch:=' and submit_date>='''+formatdatetime('YYYY-MM-DD',Frm_QrySet.DateTimePicker1.Date)+
                ''' and  submit_date-1<='''+formatdatetime('YYYY-MM-DD',Frm_QrySet.DateTimePicker2.Date)+''' '+Sqlstr;


      dm.ADO541.Close;
      dm.ADO541.SQL.Text:=sSql+FsSearch;
      dm.ADO541.Open;
  end;

end;

procedure TFrm_main.item_click(sender: TObject);
var
  i:byte;
begin
  (sender as tmenuItem).Checked := not ((sender as tmenuItem).Checked);
  if (sender as tmenuItem).Checked then
    begin
      for i := 0 to Grd1.FieldCount - 1 do
        if Grd1.Columns[i].Title.Caption = (sender as tmenuItem).Caption then
          begin
            Grd1.Columns[i].Visible := true;
            break;
          end;
    end
    else
    begin
      for i := 0 to Grd1.FieldCount - 1 do
        if Grd1.Columns[i].Title.Caption = (sender as tmenuItem).Caption then
          begin
            Grd1.Columns[i].Visible := false;
            break;
          end;
    end;
end;

procedure Tfrm_main.Grd1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  operation_charge;
end;

procedure Tfrm_main.Grd1KeyPress(Sender: TObject; var Key: Char);
begin
  operation_charge;
end;

procedure Tfrm_main.Grd1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
  operation_charge;
end;

procedure Tfrm_main.Grd1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  operation_charge;
end;
procedure Tfrm_main.N1Click(Sender: TObject);
var xuhao : Integer;
    circle :Integer;
    bptype: integer;
begin
//    xuhao := dm.ADO541DSDesigner.AsInteger;
    circle := dm.ADO541circle.AsInteger;
    bptype := dm.ADO541check_type.AsInteger;

  if  (Tmenuitem(Sender).Tag in [1]) then
    begin
      try
        Frm_Edit:=TFrm_Edit.Create(nil);

        dm.ADOD04.Active:=false;
        dm.ADOD04.Active:=true;
        Frm_Edit.edit1.Text:=dm.ADOD04.FieldValues['seed_value'];
        if dm.ADOD04SEED_FLAG.Value=3 then Frm_Edit.Edit1.ReadOnly:=false;
        if Frm_Edit.ShowModal=mrok then
          begin
            dm.ADO541.Close;
            dm.ADO541.Open;
            dm.ADO541.Locate('�����������',Frm_Edit.Edit1.Text,[]);
          end;
      finally
        Frm_Edit.Free;
      end;
//      Frm_Edit.rkey25.Caption:=dm.ADO541d025_rkey.AsString;
    end;
  if (Tmenuitem(Sender).Tag in [2]) then
    begin
      if MessageBox(Handle,'ȷ��ɾ���˱����?','��ʾ',MB_YESNO+MB_ICONWARNING+MB_DEFBUTTON2)=IDNO	then exit;
      rkey541:=demo.rkey541;
      dm.ADO541.Active:=false;
      dm.ADOTMP1.SQL.Text:='delete from   data0545   from data0545 where d541_ptr='+quotedstr(inttostr(rkey541));
      dm.ADOTMP1.ExecSQL;
      dm.ADOTMP1.SQL.Clear;
      dm.ADO541.Active:=false;
      dm.ADOTMP1.SQL.Text:='delete from   data0541   from data0541 where rkey='+quotedstr(inttostr(rkey541));
      dm.ADOTMP1.ExecSQL;
      dm.ADOTMP1.SQL.Text:='';
      dm.ADO541.Active:=true;
      if not dm.ADO541.IsEmpty  then
        begin
          rkey541:=demo.rkey541;
          dm.ADO541.Locate('���',xuhao,[]);
        end;
    end;
 
  if (Tmenuitem(Sender).Tag in [3]) then
    begin
      try
        frm_check:=Tfrm_check.Create(nil);
        frm_check.Caption :='�ύȷ��';
        frm_check.Label2.Caption:=dm.ADO541.FieldValues['�����������'];
        frm_check.Label6.Caption:=dm.ADO541.FieldValues['��������'];
        frm_check.Label8.Caption:=dm.ADO541.FieldValues['�ͻ�����'];
        frm_check.Label4.Caption:='�����ύ';
        frm_check.RichEdit1.Text:=dm.ADO541.fieldvalues['���������'];
        if frm_check.ShowModal=mrok then
          begin
            rkey541:=demo.rkey541;
            dm.ADOTMP1.SQL.Clear;
            dm.ADO541.Active:=false;


            if circle=1 then
            dm.ADOTMP1.SQL.Text:=' insert into data0545(d541_ptr,d34_index,d34_ptr,check_status) '+
                   ' select '+inttostr(rkey541)+',d34_index,d34_ptr ,0 from data0542  a join data0544 b on a.rkey=b.d542_ptr '+
                   ' where  a.rkey='+inttostr(bptype) +
                   ' and not  exists (select * from data0545 where d541_ptr='+inttostr(rkey541)+')'+
                 ' update  data0541 set check_status=1 '+
                 ', submit_date=getdate() '+
                 ', submit_suggestion='+quotedstr(frm_check.RichEdit1.Text)+
                 '  from data0541 where rkey='+quotedstr(inttostr(rkey541))
            else
               dm.ADOTMP1.SQL.Text:=' update  data0541 set check_status=1 '+
                 ', submit_date=getdate() '+
                 ', submit_suggestion='+quotedstr(frm_check.RichEdit1.Text)+
                 '  from data0541 where rkey='+quotedstr(inttostr(rkey541));


            dm.ADOTMP1.ExecSQL;
            dm.ADOTMP1.SQL.Text:='';
            dm.ADO541.Active:=true;
            dm.ADO541.Sort:=paixu2;
            dm.ADO541.Locate('���',xuhao,[]);
          end;
      finally
        frm_check.Free;
      end;
    end;
  if (Tmenuitem(Sender).Tag in [4]) then
    begin
      rkey541:=demo.rkey541;
      dm.ADOTMP1.SQL.Clear;
      dm.ADO541.Active:=false;
      dm.ADOTMP1.SQL.Text:='update  data0541 set check_status=0  from data0541 '+
        ' where rkey='+quotedstr(inttostr(rkey541));
      dm.ADOTMP1.ExecSQL;
      dm.ADOTMP1.SQL.Text:='';
      dm.ADO541.Active:=true;
      dm.ADO541.Sort:=paixu2;
      dm.ADO541.Locate('���',xuhao,[]);
      dm.ADOTMP1.SQL.Clear;

    end;
  if (Tmenuitem(Sender).Tag in [5])   then
    try
    Frm_Edit:=TFrm_Edit.Create(application);
    Frm_Edit.edit1.Text:=dm.ADO541.FieldValues['�����������'];
    Frm_Edit.Edit3.Text:=dm.ADO541.FieldValues['���ϱ���'];
    Frm_Edit.Edit2.Text:=dm.ADO541.FieldValues['��������'];
    Frm_Edit.Edit9.Text:=dm.ADO541.FieldValues['���Ϲ��'];
    Frm_Edit.Edit6.Text:=dm.ADO541MANU_PART_NUMBER.Value;
    Frm_Edit.Edit8.Text:=dm.ADO541QUAN_ON_HAND.AsString;
    Frm_Edit.Label15.Caption:=dm.ADO541beizhu.AsString;
    Frm_Edit.RichEdit1.Text:=dm.ADO541reason.AsString;
    Frm_Edit.RichEdit2.Text:=dm.ADO541remark.AsString;
      dm.ads494.Close;
      dm.ads494.CommandText:=dm.ads494SQL+' and data0038.dept_ptr=:dept_ptr';                      //�Ƴ̲���
      dm.ads494.Parameters[0].Value:=dm.ADO541d025_rkey.Value;
      dm.ads494.Parameters[1].Value:=dm.ADO541R34_ptr.Value;
//      ShowMessage(dm.ads494.CommandText);
      dm.ads494.Open;


  with Frm_Edit do
  begin
    SpeedButton3.Enabled:=False;
    BitBtn6.Enabled:=False;
    BitBtn3.Enabled:=False;
    SpeedButton4.Enabled:=False;
    Edit8.ReadOnly:=True;
    RichEdit2.ReadOnly:=True;
    SpeedButton1.Enabled:=False;
  end;
  Frm_Edit.ShowModal;
 finally
  Frm_Edit.Free;
 end;

end;
procedure Tfrm_main.FormDestroy(Sender: TObject);
var sr: TSearchRec;
begin
  if FindFirst(TmpFileDir+'*.*', faAnyFile, sr) = 0 then
  begin
    repeat
      setfileattributes(pchar(TmpFileDir+sr.name),file_attribute_normal);
      DeleteFile(TmpFileDir+sr.Name);
    until FindNext(sr) <> 0;
    FindClose(sr);
 end;
end;

procedure Tfrm_main.Edit1Change(Sender: TObject);
begin
  if Grd1.DataSource.DataSet.FieldByName(field_name).FieldKind = fkCalculated then  exit;
  if Grd1.DataSource.DataSet.FieldByName(field_name).DataType in [ftString,ftWideString,ftSmallint,ftInteger]  then
  begin
    if trim(Edit1.text) <> '' then
      begin
        if Grd1.DataSource.DataSet.FieldByName(field_name).DataType in  [ftString, ftWideString]  then
          Grd1.DataSource.DataSet.Filter:=' (' +  field_name + ' like ''%' + trim(edit1.text) + '%'')'
        else if Grd1.DataSource.DataSet.FieldByName(field_name).DataType in  [ftSmallint, ftInteger]  then
          Grd1.DataSource.DataSet.Filter:=' (' + field_name+' >= ' + inttostr(strtointdef(edit1.text,0))+')';
      end
    else
      Grd1.DataSource.DataSet.Filter:='';
  end;
end;

procedure Tfrm_main.Grd1TitleClick(Column: TColumnEh);
begin
  if Grd1.DataSource.DataSet.FieldByName(Column.FieldName).FieldKind = fkCalculated then  exit ;
  if (column.Title.SortMarker =smDownEh) or (column.Title.SortMarker =smNoneEh) then
    begin
      column.Title.SortMarker:=smUpEh;
      DM.ADO541.Sort:=Column.FieldName;
    end
  else
    begin
      column.Title.SortMarker:=smDownEh;
      DM.ADO541.Sort:=Column.FieldName+' DESC';
    end;
//  DM.ADO541AfterScroll(DM.ADO541);
  if Grd1.DataSource.DataSet.FieldByName(Column.FieldName).DataType in [ftDate, ftTime, ftDateTime] then exit;
  if (field_name <> column.FieldName) then
    begin
      label1.Caption := column.Title.Caption ;
      field_name := column.FieldName ;
      edit1.SetFocus;
      PreColumn.Title.Color := clBtnFace ;
      Column.Title.Color := clred ;
      PreColumn := column ;
      Edit1Change(Edit1);
    end
  else
    edit1.SetFocus;
end;

procedure Tfrm_main.FormActivate(Sender: TObject);
begin
  DM.ADO541.SQL.Text:=DM.ADO541.SQL.Text+
    ' and  submit_date>='''+formatdatetime('YYYY-MM-DD',date-10)+
    ''' and  submit_date-1<='''+formatdatetime('YYYY-MM-DD',date)+''' ';
    //Memo1.Text:=('�������»');
  DM.ADO541.Prepared;
  DM.ADO541.Open;
  if not dm.ADO541.IsEmpty then
  DM.ADO541.Sort:=grd1.Columns[0].FieldName;
end;

procedure Tfrm_main.FormCreate(Sender: TObject);
begin
 if not app_init(dm.ADOConnection1) then
  begin
    common.ShowMsg('��������ʧ��,����ϵϵͳ����Ա',1);
    application.Terminate;
  end;
  self.Caption :=Application.Title;
  dm.ADS541.Close;
  dm.ADS541.Open;
  dm.ADS541.Edit;
   dm.ADS541d05_ptr.AsInteger:=demo.op_people;
//   user_ptr:='686'; //��ԱID
//   vprev:='4';    //Ȩ��
//   rkey73:='9';   //

   dm.ADOConnection1.Open;

    DateSeparator := '-';
    ShortDateFormat := 'yyyy-mm-dd';
    field_name := Grd1.Columns[1].FieldName;
    PreColumn := Grd1.Columns[1];
    dm.ADODataSet_ud.CommandText:='select employee_id from data0005 where rkey='+quotedstr(user_ptr);
    dm.ADODataSet_ud.Active:=true;
    demo.people_department:=dm.ADODataSet_ud.FieldValues['employee_id'];//���� -------->>>
    dm.ADODataSet_ud.Active:=false;
    demo.people_right:=strtoint(vprev);//Ȩ��
    demo.op_people:=strtoint(user_ptr);//��ǰ����Ա --------->>>>>
    if  strtoint(vprev) <> 4  then //ֻ��д���Ĳ��ܶ��屨��
    begin
      bitbtn1.Visible := false;
    end;
//    dm.ADO541.SQL.Text:=dm.ADO541.SQL.Text+ssql_filter;
    sSql:=dm.ADO541.SQL.Text;
//    showmessage('0k');
    init;
end;
procedure Tfrm_main.Grd1DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
begin
    if dm.ADO541check_status.AsInteger=0
   then  grd1.Canvas.Font.Color := clFuchsia;
    if dm.ADO541check_status.AsInteger=1
   then  grd1.Canvas.Font.Color := clGreen;
      if dm.ADO541check_status.AsInteger=2
   then  grd1.Canvas.Font.Color := clolive;
  grd1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;







procedure Tfrm_main.N21Click(Sender: TObject);
begin
      try
        frm_check:=Tfrm_check.Create(nil);
        frm_check.Caption := 'һ��';
        frm_check.Label2.Caption:=dm.ADO541.FieldValues['�����������'];
        frm_check.Label6.Caption:=dm.ADO541.FieldValues['��������'];
        frm_check.Label8.Caption:=dm.ADO541.FieldValues['�ͻ�����'];
        frm_check.Label4.Caption:=dm.ADO541.FieldValues['״̬'];
        dm.ADOTMP1.SQL.Clear;
        dm.ADOTMP1.SQL.Text := ' select check_suggestion_1'+
          ' as shyj from data0541 where rkey= '+inttostr(demo.rkey541);
        dm.ADOTMP1.Open;
        frm_check.RichEdit1.Text:=dm.ADOTMP1.FieldValues['shyj'];
        dm.ADOTMP1.Close;
        dm.ADOTMP1.SQL.Clear;
        if frm_check.ShowModal=mrok then
        begin
          rkey541:=demo.rkey541;
          dm.ADOTMP1.SQL.Clear;
          dm.ADOTMP1.SQL.Text:='select [check_status] from data0541 where rkey='+
            quotedstr(inttostr(rkey541));
          dm.ADOTMP1.Open;
          if (dm.ADOTMP1.FieldByName('check_status').AsInteger = demo.rkey541_status) then
            begin
              dm.ADOTMP1.Close;

              dm.ADO541.Active:=false;
              dm.ADOTMP1.SQL.Text:='update  data0541 '+
                  ' set check_status=check_status+2'+
                  ', check_person_1 ='+user_ptr+
                  ', check_date_1=getdate()'+
                  ', check_suggestion_1'+
                  '='+quotedstr(frm_check.RichEdit1.Text)+
                  ' from data0541 where rkey='+quotedstr(inttostr(rkey541));
              dm.ADOTMP1.ExecSQL;
              dm.ADOTMP1.SQL.Text:='';
              dm.ADO541.Active:=true;
              dm.ADO541.Sort:=paixu2;
              dm.ADO541.Locate('���',rkey541,[]);
            end
            else
              begin
                dm.ADOTMP1.Close;
                showmessage('���״̬�Ѿ������ı�');
                dm.ADO541.Active:=false;
                dm.ADO541.Active:=true;
               exit;
              end;
        end;
      finally
        frm_check.Free;
      end;

end;

procedure Tfrm_main.N22Click(Sender: TObject);
var orginal_str: string;
begin
        orginal_str := dm.DS1.DataSet.FieldValues['��ͬһ�����'];
        dm.ADOTMP1.Close;
        dm.ADOTMP1.SQL.Clear;
        rkey541:=demo.rkey541;
        dm.ADOTMP1.SQL.Clear;
        dm.ADOTMP1.SQL.Text:='select [check_status] from data0541 where rkey='+
            quotedstr(inttostr(rkey541));
        dm.ADOTMP1.Open;
          if (dm.ADOTMP1.FieldByName('check_status').AsInteger = demo.rkey541_status) then
            begin
              dm.ADOTMP1.Close;

              dm.ADO541.Active:=false;
              dm.ADOTMP1.SQL.Text:='update  data0541 '+
                  ' set check_status=check_status-2'+
                  ', d05_ptr_1 ='+user_ptr+
                  ', check_date_1=getdate()'+
                  ', check_suggestion_��='+#39+'ԭ���飺��'+orginal_str+'����ȡ��һ��'+#39+
                  ' from data0541 where rkey='+quotedstr(inttostr(rkey541));
              dm.ADOTMP1.ExecSQL;
              dm.ADOTMP1.SQL.Text:='';
              dm.ADO541.Active:=true;
              dm.ADO541.Sort:=paixu2;
              dm.ADO541.Locate('���',rkey541,[]);
            end
            else
              begin
                dm.ADOTMP1.Close;
                showmessage('���״̬�Ѿ������ı�');
                dm.ADO541.Active:=false;
                dm.ADO541.Active:=true;
                exit;
              end; 
      end;


procedure Tfrm_main.N23Click(Sender: TObject);
begin
      try
        frm_check:=Tfrm_check.Create(nil);
        frm_check.Caption := '���';
        frm_check.Label2.Caption:=dm.ADO541.FieldValues['�����������'];
        frm_check.Label6.Caption:=dm.ADO541.FieldValues['��������'];
        frm_check.Label8.Caption:=dm.ADO541.FieldValues['�ͻ�����'];
        frm_check.Label4.Caption:=dm.ADO541.FieldValues['״̬'];
        dm.ADOTMP1.SQL.Clear;
        dm.ADOTMP1.SQL.Text := ' select check_suggestion_2'+
          ' as shyj from data0541 where rkey= '+inttostr(demo.rkey541);
        dm.ADOTMP1.Open;
        frm_check.RichEdit1.Text:=dm.ADOTMP1.FieldValues['shyj'];
        dm.ADOTMP1.Close;
        dm.ADOTMP1.SQL.Clear;
        if frm_check.ShowModal=mrok then
        begin
          rkey541:=demo.rkey541;
          dm.ADOTMP1.SQL.Clear;
          dm.ADOTMP1.SQL.Text:='select [check_status] from data0541 where rkey='+
            quotedstr(inttostr(rkey541));
          dm.ADOTMP1.Open;
          if (dm.ADOTMP1.FieldByName('check_status').AsInteger = demo.rkey541_status) then
            begin
              dm.ADOTMP1.Close;
              dm.ADO541.Active:=false;
              dm.ADOTMP1.SQL.Text:='update  data0541 '+
                  ' set check_status=check_status+4'+
                  ', d05_ptr_2 ='+user_ptr+
                  ', check_date_2=getdate()'+
                  ', check_suggestion_2'+
                  '='+quotedstr(frm_check.RichEdit1.Text)+
                  ' from data0541 where rkey='+quotedstr(inttostr(rkey541));
              dm.ADOTMP1.ExecSQL;
              dm.ADOTMP1.SQL.Text:='';
              dm.ADO541.Active:=true;
              dm.ADO541.Sort:=paixu2;
              dm.ADO541.Locate('���',rkey541,[]);
            end
            else
              begin
                dm.ADOTMP1.Close;
                showmessage('���״̬�Ѿ������ı�');
                dm.ADO541.Active:=false;
                dm.ADO541.Active:=true;
                exit;
              end;
        end;
      finally
        frm_check.Free;
      end;
end;

procedure Tfrm_main.N24Click(Sender: TObject);
var orginal_str: string;
begin
        orginal_str := dm.DS1.DataSet.FieldValues['��ͬ�������'];
  dm.ADOTMP1.Close;
        dm.ADOTMP1.SQL.Clear;
        rkey541:=demo.rkey541;
        dm.ADOTMP1.SQL.Clear;
        dm.ADOTMP1.SQL.Text:='select [check_status] from data0541 where rkey='+
            quotedstr(inttostr(rkey541));
        dm.ADOTMP1.Open;
          if (dm.ADOTMP1.FieldByName('check_status').AsInteger = demo.rkey541_status) then
            begin
              dm.ADOTMP1.Close;
              dm.ADO541.Active:=false;
              dm.ADOTMP1.SQL.Text:='update  data0541 '+
                  ' set check_status=check_status-4'+
                  ', d05_ptr_2 ='+user_ptr+
                  ', check_date_2=getdate()'+
                  ', check_suggestion_2='+#39+'ԭ���飺��'+orginal_str+'����ȡ������'+#39+
                  ' from data0541 where rkey='+quotedstr(inttostr(rkey541));
              dm.ADOTMP1.ExecSQL;
              dm.ADOTMP1.SQL.Text:='';
              dm.ADO541.Active:=true;

              dm.ADO541.Sort:=paixu2;
              dm.ADO541.Locate('���',rkey541,[]);
            end
            else
              begin
                dm.ADOTMP1.Close;
                showmessage('���״̬�Ѿ������ı�');
                dm.ADO541.Active:=false;
                dm.ADO541.Active:=true;
                exit;
              end;
end;

procedure Tfrm_main.N25Click(Sender: TObject);
begin
      try
        frm_check:=Tfrm_check.Create(nil);
        frm_check.Caption := '���';
        frm_check.Label2.Caption:=dm.ADO541.FieldValues['�����������'];
        frm_check.Label6.Caption:=dm.ADO541.FieldValues['��������'];
        frm_check.Label8.Caption:=dm.ADO541.FieldValues['�ͻ�����'];
        frm_check.Label4.Caption:=dm.ADO541.FieldValues['״̬'];
        dm.ADOTMP1.SQL.Clear;
        dm.ADOTMP1.SQL.Text := ' select check_suggestion_3'+
          ' as shyj from data0541 where rkey= '+inttostr(demo.rkey541);
        dm.ADOTMP1.Open;
        frm_check.RichEdit1.Text:=dm.ADOTMP1.FieldValues['shyj'];
        dm.ADOTMP1.Close;
        dm.ADOTMP1.SQL.Clear;
        if frm_check.ShowModal=mrok then
        begin
          rkey541:=demo.rkey541;
          dm.ADOTMP1.SQL.Clear;
          dm.ADOTMP1.SQL.Text:='select [check_status] from data0541 where rkey='+
            quotedstr(inttostr(rkey541));
          dm.ADOTMP1.Open;
          if (dm.ADOTMP1.FieldByName('check_status').AsInteger = demo.rkey541_status) then
            begin
              dm.ADOTMP1.Close;
              dm.ADO541.Active:=false;
              dm.ADOTMP1.SQL.Text:='update  data0541 '+
                  ' set check_status=check_status+8'+
                  ', d05_ptr_3 ='+user_ptr+
                  ', check_date_3=getdate()'+
                  ', check_suggestion_3'+
                  '='+quotedstr(frm_check.RichEdit1.Text)+
                  ' from data0541 where rkey='+quotedstr(inttostr(rkey541));
              dm.ADOTMP1.ExecSQL;
              dm.ADOTMP1.SQL.Text:='';
              dm.ADO541.Active:=true;

              dm.ADO541.Sort:=paixu2;
              dm.ADO541.Locate('���',rkey541,[]);
            end
            else
              begin
                dm.ADOTMP1.Close;
                showmessage('���״̬�Ѿ������ı�');
                dm.ADO541.Active:=false;
                dm.ADO541.Active:=true;

                exit;
              end;
        end;
      finally
        frm_check.Free;
      end;
end;

procedure Tfrm_main.N26Click(Sender: TObject);
var orginal_str: string;
begin
        orginal_str := dm.DS1.DataSet.FieldValues['��ͬ�������'];
        dm.ADOTMP1.Close;
        dm.ADOTMP1.SQL.Clear;
        rkey541:=demo.rkey541;
        dm.ADOTMP1.SQL.Clear;
        dm.ADOTMP1.SQL.Text:='select [check_status] from data0541 where rkey='+
            quotedstr(inttostr(rkey541));
        dm.ADOTMP1.Open;
          if (dm.ADOTMP1.FieldByName('check_status').AsInteger = demo.rkey541_status) then
            begin
              dm.ADOTMP1.Close;
              dm.ADO541.Active:=false;
              dm.ADOTMP1.SQL.Text:='update  data0541 '+
                  ' set check_status=check_status-8'+
                  ', d05_ptr_3 ='+user_ptr+
                  ', check_date_3=getdate()'+
                  ', check_suggestion_3='+#39+'ԭ���飺��'+orginal_str+'����ȡ������'+#39+
                  ' from data0541 where rkey='+quotedstr(inttostr(rkey541));
              dm.ADOTMP1.ExecSQL;
              dm.ADOTMP1.SQL.Text:='';
              dm.ADO541.Active:=true;
              dm.ADO541.Sort:=paixu2;
              dm.ADO541.Locate('���',rkey541,[]);
            end
            else
              begin
                dm.ADOTMP1.Close;
                showmessage('���״̬�Ѿ������ı�');
                dm.ADO541.Active:=false;
                dm.ADO541.Active:=true;
                exit;
              end; 
end;



procedure Tfrm_main.N9Click(Sender: TObject);
var orginal_str: string;
begin
          orginal_str := dm.DS1.DataSet.FieldValues['��ͬ�������'];
          dm.ADOTMP1.Close;
          dm.ADOTMP1.SQL.Clear;
          rkey541:=demo.rkey541;
          dm.ADOTMP1.SQL.Clear;
          dm.ADOTMP1.SQL.Text:='select [check_status] from data0541 where rkey='+
          quotedstr(inttostr(rkey541));
          dm.ADOTMP1.Open;
          if (dm.ADOTMP1.FieldByName('check_status').AsInteger = demo.rkey541_status) then
            begin
              dm.ADOTMP1.Close;
              dm.ADO541.Active:=false;
              dm.ADOTMP1.SQL.Text:='update  data0541 '+
                  ' set check_status=check_status-16'+
                  ', d05_ptr_4 ='+user_ptr+
                  ', check_date_4=getdate()'+
                  ', check_suggestion_4='+#39+'ԭ���飺��'+orginal_str+'����ȡ������'+#39+
                  ' from data0541 where rkey='+quotedstr(inttostr(rkey541));
              dm.ADOTMP1.ExecSQL;
              dm.ADOTMP1.SQL.Text:='';
              dm.ADO541.Active:=true;
              dm.ADO541.Sort:=paixu2;
              dm.ADO541.Locate('���',rkey541,[]);
            end
            else
              begin
                dm.ADOTMP1.Close;
                showmessage('���״̬�Ѿ������ı�');
                dm.ADO541.Active:=false;
                dm.ADO541.Active:=true;
                exit;
              end;
end;

procedure Tfrm_main.N17Click(Sender: TObject);
begin
        try
        frm_check:=Tfrm_check.Create(nil);
        frm_check.Caption := '���';
        frm_check.Label2.Caption:=dm.ADO541.FieldValues['�����������'];
        frm_check.Label6.Caption:=dm.ADO541.FieldValues['��������'];
        frm_check.Label8.Caption:=dm.ADO541.FieldValues['�ͻ�����'];
        frm_check.Label4.Caption:=dm.ADO541.FieldValues['״̬'];
        dm.ADOTMP1.SQL.Clear;
        dm.ADOTMP1.SQL.Text := ' select check_suggestion_5'+
          ' as shyj from data0541 where rkey= '+inttostr(demo.rkey541);
        dm.ADOTMP1.Open;
        frm_check.RichEdit1.Text:=dm.ADOTMP1.FieldValues['shyj'];
        dm.ADOTMP1.Close;
        dm.ADOTMP1.SQL.Clear;
        if frm_check.ShowModal=mrok then
        begin
          rkey541:=demo.rkey541;
          dm.ADOTMP1.SQL.Clear;
          dm.ADOTMP1.SQL.Text:='select [check_status] from data0541 where rkey='+
            quotedstr(inttostr(rkey541));
          dm.ADOTMP1.Open;
          if (dm.ADOTMP1.FieldByName('check_status').AsInteger = demo.rkey541_status) then
            begin
              dm.ADOTMP1.Close;
              dm.ADO541.Active:=false;
              dm.ADOTMP1.SQL.Text:='update  data0541 '+
                  ' set check_status=check_status+32'+
                  ', d05_ptr_5 ='+user_ptr+
                  ', check_date_5=getdate()'+
                  ', check_suggestion_5'+
                  '='+quotedstr(frm_check.RichEdit1.Text)+
                  ' from data0541 where rkey='+quotedstr(inttostr(rkey541));
              dm.ADOTMP1.ExecSQL;
              dm.ADOTMP1.SQL.Text:='';
              dm.ADO541.Active:=true;
              dm.ADO541.Sort:=paixu2;
              dm.ADO541.Locate('���',rkey541,[]);
            end
            else
              begin
                dm.ADOTMP1.Close;
                showmessage('���״̬�Ѿ������ı�');
                dm.ADO541.Active:=false;
                dm.ADO541.Active:=true;
                exit;
              end; 
        end;
      finally
        frm_check.Free;
      end;
end;

procedure Tfrm_main.N18Click(Sender: TObject);
var orginal_str: string;
begin
        orginal_str := dm.DS1.DataSet.FieldValues['��ͬ�������'];
        dm.ADOTMP1.Close;
        dm.ADOTMP1.SQL.Clear;
        rkey541:=demo.rkey541;
        dm.ADOTMP1.SQL.Clear;
        dm.ADOTMP1.SQL.Text:='select [check_status] from data0541 where rkey='+
            quotedstr(inttostr(rkey541));
        dm.ADOTMP1.Open;
          if (dm.ADOTMP1.FieldByName('check_status').AsInteger = demo.rkey541_status) then
            begin
              dm.ADOTMP1.Close;
              dm.ADO541.Active:=false;
              dm.ADOTMP1.SQL.Text:='update  data0541 '+
                  '  set check_status=check_status-32'+
                  ', d05_ptr_5 ='+user_ptr+
                  ', check_date_5=getdate()'+
                  ', check_suggestion_5='+#39+'ԭ���飺��'+orginal_str+'����ȡ������'+#39+
                  ' from data0541 where rkey='+quotedstr(inttostr(rkey541));
              dm.ADOTMP1.ExecSQL;
              dm.ADOTMP1.SQL.Text:='';
              dm.ADO541.Active:=true;
              dm.ADO541.Sort:=paixu2;
              dm.ADO541.Locate('���',rkey541,[]);
            end
            else
              begin
                dm.ADOTMP1.Close;
                showmessage('���״̬�Ѿ������ı�');
                dm.ADO541.Active:=false;
                dm.ADO541.Active:=true;
                exit;
              end;
end;

procedure Tfrm_main.N7Click(Sender: TObject);
begin
    try
      frm_check:=Tfrm_check.Create(nil);
      frm_check.Caption :='�����˻�������';
      frm_check.Label2.Caption:=dm.ADO541.FieldValues['�����������'];
      frm_check.Label6.Caption:=dm.ADO541.FieldValues['��������'];
      frm_check.Label8.Caption:=dm.ADO541.FieldValues['�ͻ�����'];
      frm_check.Label4.Caption:=dm.ADO541.FieldValues['״̬'];
      //Frm_Edit.Ftag:=Tmenuitem(Sender).Tag;
      //Frm_Edit.init;
        dm.ADOTMP1.SQL.Clear;
        dm.ADOTMP1.SQL.Text := ' select check_suggestion_5'+
          ' as shyj from data0541 where rkey= '+inttostr(demo.rkey541);
        dm.ADOTMP1.Open;
        frm_check.RichEdit1.Text:=dm.ADOTMP1.FieldValues['shyj'];
        dm.ADOTMP1.Close;
        dm.ADOTMP1.SQL.Clear;
      if frm_check.ShowModal=mrok then
      begin
        rkey541:=demo.rkey541;
        dm.ADOTMP1.SQL.Clear;
        dm.ADOTMP1.SQL.Text:='select [check_status] from data0541 where rkey='+
          quotedstr(inttostr(rkey541));
        dm.ADOTMP1.Open;
        if (dm.ADOTMP1.FieldByName('check_status').AsInteger =demo.rkey541_status) then
          begin
            dm.ADOTMP1.Close;
            dm.ADOTMP1.SQL.Clear;
            dm.ADO541.Active:=false;
            dm.ADOTMP1.SQL.Text:='update  data0541 '+
              'set check_status=check_status-1'+
              ', d05_ptr_5='+user_ptr+
              ', check_date_5=getdate()'+
              ', check_suggestion_5'+
              ' ='+quotedstr(frm_check.RichEdit1.Text)+
              ', circle=circle+1 '+
              ' from data0541 where rkey='+quotedstr(inttostr(rkey541));
            dm.ADOTMP1.ExecSQL;
            dm.ADOTMP1.SQL.Text:='';
            dm.ADO541.Active:=true;
            dm.ADO541.Sort:=paixu2;
            dm.ADO541.Locate('���',rkey541,[]);
          end
        else
          begin
            dm.ADOTMP1.Close;
            showmessage('���״̬�Ѿ������ı�');
            dm.ADO541.Active:=false;
            dm.ADO541.Active:=true;
            exit;
          end;
      end;
    finally
      frm_check.Free;
    end;
end;

procedure Tfrm_main.N31Click(Sender: TObject);
begin
dm.ADOTMP1.Close;
        dm.ADOTMP1.SQL.Clear;
        rkey541:=demo.rkey541;
        dm.ADOTMP1.SQL.Clear;
        dm.ADOTMP1.SQL.Text:='select [check_status] from data0541 where rkey='+
            quotedstr(inttostr(rkey541));
        dm.ADOTMP1.Open;
          if (dm.ADOTMP1.FieldByName('check_status').AsInteger = demo.rkey541_status) then
            begin
              dm.ADOTMP1.Close;
              dm.ADO541.Active:=false;
              dm.ADOTMP1.SQL.Text:='update  data0541 '+
               'set check_status=check_status+1'+
               ', d05_ptr_5='+user_ptr+
               ', check_date_5=getdate()'+
                  //', check_suggestion_5=NULL'+
               ' from data0541 where rkey='+quotedstr(inttostr(rkey541));
              dm.ADOTMP1.ExecSQL;
              dm.ADOTMP1.SQL.Text:='';
              dm.ADO541.Active:=true;
              dm.ADO541.Sort:=paixu2;
              dm.ADO541.Locate('���',rkey541,[]);
            end
            else
              begin
                dm.ADOTMP1.Close;
                showmessage('���״̬�Ѿ������ı�');
                dm.ADO541.Active:=false;
                dm.ADO541.Active:=true;
                exit;
              end;
end;

procedure Tfrm_main.N5Click(Sender: TObject);
begin
        try
        frm_check:=Tfrm_check.Create(nil);
        frm_check.Caption := '����᰸';
        frm_check.Label2.Caption:=dm.ADO541.FieldValues['�����������'];
        frm_check.Label6.Caption:=dm.ADO541.FieldValues['��������'];
        frm_check.Label8.Caption:=dm.ADO541.FieldValues['�ͻ�����'];
        frm_check.Label4.Caption:=dm.ADO541.FieldValues['״̬'];
        dm.ADOTMP1.SQL.Clear;
        dm.ADOTMP1.SQL.Text := ' select check_suggestion_5'+
          ' as shyj from data0541 where rkey= '+inttostr(demo.rkey541);
        dm.ADOTMP1.Open;
        frm_check.RichEdit1.Text:=dm.ADOTMP1.FieldValues['shyj'];
        dm.ADOTMP1.Close;
        dm.ADOTMP1.SQL.Clear;
        if frm_check.ShowModal=mrok then
        begin
          rkey541:=demo.rkey541;
          dm.ADOTMP1.SQL.Clear;
          dm.ADOTMP1.SQL.Text:='select [check_status] from data0541 where rkey='+
            quotedstr(inttostr(rkey541));
          dm.ADOTMP1.Open;
          if (dm.ADOTMP1.FieldByName('check_status').AsInteger = demo.rkey541_status) then
            begin
              dm.ADOTMP1.Close;
              dm.ADO541.Active:=false;
              dm.ADOTMP1.SQL.Text:='update  data0541 '+
                  ' set check_status=63'+
                  ', d05_ptr_5 ='+user_ptr+
                  ', check_date_5=getdate()'+
                  ', check_suggestion_5'+
                  '='+quotedstr(frm_check.RichEdit1.Text)+
                  ' from data0541 where rkey='+quotedstr(inttostr(rkey541));
              dm.ADOTMP1.ExecSQL;
              dm.ADOTMP1.SQL.Text:='';
              dm.ADO541.Active:=true;

              dm.ADO541.Sort:=paixu2;
              dm.ADO541.Locate('���',rkey541,[]);
            end
            else
              begin
                dm.ADOTMP1.Close;
                showmessage('���״̬�Ѿ������ı�');

                dm.ADO541.Active:=false;
                dm.ADO541.Active:=true;

                exit;
              end; 
        end;
      finally
        frm_check.Free;
      end;
end;

procedure Tfrm_main.BtFldsClick(Sender: TObject);
begin
  //Tfrm_cpedit
//    dm.ADOTMP1.SQL.Clear;
//    dm.ADOTMP1.SQL.Text :='select  top 1 * from data0034 where ttype=4 and  dept_name like '+#39+'%��%'+#39;
//    //     showmessage(dm.ADOTMP1.SQL.Text);
//    dm.ADOTMP1.ExecSQL;
//    dm.ADOTMP1.Open;
//    if not dm.ADOTMP1.Eof then
//      begin
//        if demo.people_department <> dm.ADOTMP1.FieldByName('rkey').AsInteger  then
//        begin
//          showmessage('ֻ�з�ز���Ա�ſ��Զ����������');
//          exit;
//        end;
//      end;
//    dm.ADOTMP1.Close;
//
//      if (vprev <>'4') then  Exit;

      try
          frmbusinessprocess:=Tfrmbusinessprocess.Create(nil);
        if frmbusinessprocess.ShowModal=mrok then
          begin
          end;
      finally

          frmbusinessprocess.Free;
      end;
end;

procedure Tfrm_main.FormShow(Sender: TObject);
begin
 dm.ADO541.Close;
  DM.ADO541.Open;
 DM.ads494SQL:=dm.ads494.commandText;
end;

procedure Tfrm_main.Grd1Enter(Sender: TObject);
begin
   DBMemo2.Align := alNone;
   DBMemo2.Visible := false;
   DBMemo1.Align := alBottom ;
   DBMemo1.Visible := true;

end;

procedure Tfrm_main.DBGridEh1Enter(Sender: TObject);
begin
   DBMemo2.Align := alBottom ;
   DBMemo2.Visible := true;
   DBMemo1.Align := alNone;
   DBMemo1.Visible := false;
end;

procedure Tfrm_main.N6Click(Sender: TObject);
var rkey_545 :Integer;
    data541status : integer;
begin
  rkey_545 :=dm.ADO545rkey.AsInteger;
  rkey541:=demo.rkey541;
  paixu2:=dm.ADO541.Sort;
  if (Tmenuitem(Sender).Tag in [1]) then
    begin
      try
        frm_check:=Tfrm_check.Create(nil);
        frm_check.Caption := inttostr(dm.ADO545d34_index.Value)+'��,��˲���:'+dm.ADO545dept_name.AsString;
        frm_check.Label2.Caption:=dm.ADO541.FieldValues['�����������'];
        frm_check.Label6.Caption:=dm.ADO541.FieldValues['��������'];
        frm_check.Label8.Caption:=dm.ADO541.FieldValues['�ͻ�����'];
        frm_check.Label4.Caption:='�� '+inttostr(dm.ADO545d34_index.AsInteger)+' ��';
        if dm.ADO545check_suggestion.AsString =''  then
        frm_check.RichEdit1.Text:=inttostr(dm.ADO545d34_index.Value)+'��:'+#13
        else
         frm_check.RichEdit1.Text:= dm.ADO545check_suggestion.AsString;


        if frm_check.ShowModal=mrok then
        begin
          dm.ADOTMP1.SQL.Clear;
          dm.ADOTMP1.SQL.Text:='select [check_status] from data0545 where rkey='+quotedstr(inttostr(rkey_545));
          dm.ADOTMP1.Open;
          if (dm.ADOTMP1.FieldByName('check_status').AsInteger = dm.ADO545check_status.AsInteger) then
            begin
              dm.ADOTMP1.Close;
              dm.ADO545.Active:= False;
              dm.ADOTMP1.SQL.Text:='update  data0545 '+
                  ' set check_status=1 '+
                  ', check_person='+user_ptr+
                  ', check_time=getdate()'+
                  ', check_suggestion='+quotedstr(frm_check.RichEdit1.Text)+
                  ' from data0545 where rkey='+inttostr(rkey_545);
              dm.ADOTMP1.ExecSQL;

              dm.ADOTMP1.SQL.Text:='';
              //��Ҫ�ж��Ƿ�������
              dm.ADOTMP1.Close;
              dm.ADOTMP1.SQL.Clear;
              dm.ADOTMP1.SQL.Text:='select * from  data0545 '+
                  ' where check_status=0 and d541_ptr='+inttostr(rkey541);
              dm.ADOTMP1.ExecSQL;
              dm.ADOTMP1.Open;
              if dm.ADOTMP1.Eof then
              begin
                dm.ADO541.Active := false;
                dm.ADOTMP2.SQL.Text :='update data0541 set check_status=2 from data0541 where rkey='+inttostr(rkey541);
                dm.ADOTMP2.ExecSQL;
                dm.ADO541.Active := True;
                dm.ADO541.Sort:=paixu2;
                dm.ADO541.Locate('rkey',rkey541,[]);
              end;

              dm.ADO545.Active := true;
              dm.ADO545.Locate('rkey',rkey_545,[]);
              DBGridEh1.SetFocus;
            end
            else
              begin
                dm.ADOTMP1.Close;
                showmessage('���״̬�Ѿ������ı�');
                dm.ADO545.Active:= False;
               dm.ADO545.Locate('rkey',rkey_545,[]);
                dm.ADO545.Active := true;
                exit;
              end;

        end;
      finally
        frm_check.Free;
      end;
  end;

   if (Tmenuitem(Sender).Tag in [2]) then
  begin


    dm.ADOTMP1.SQL.Clear;
    dm.ADOTMP1.SQL.Text:='select [check_status] from data0541 where rkey='+quotedstr(inttostr(rkey541));
    dm.ADOTMP1.Open;
    data541status := dm.ADOTMP1.FieldByName('check_status').AsInteger;
    if ((dm.ADOTMP1.FieldByName('check_status').AsInteger =2) and (dm.ADO545d34_ptr.AsInteger <>demo.last_check_dept) ) then
     begin
        ShowMessage('��˹����Ѿ�ȫ�����,�����Ĳ��Ų���ȡ�����,�����ͬ��˼�ܲ�����Ա��ϵ');
        exit;
     end;

    dm.ADOTMP1.SQL.Clear;
    dm.ADOTMP1.SQL.Text:='select [check_status] from data0545 where rkey='+quotedstr(inttostr(rkey_545));
    dm.ADOTMP1.Open;

      if (dm.ADOTMP1.FieldByName('check_status').AsInteger = dm.ADO545check_status.AsInteger) then
      begin
          dm.ADOTMP1.Close;
          dm.ADO545.Active:= False;
          dm.ADOTMP1.SQL.Text:='update  data0545 '+
              ' set check_status=0 '+
              ', check_time=getdate()'+
              ' from data0545 where rkey='+inttostr(rkey_545);
          dm.ADOTMP1.ExecSQL;
      dm.ADOTMP1.SQL.Text:='';

      if data541status=2 then
      begin
          //ShowMessage('');
          dm.ADO541.Active := false;
          dm.ADOTMP1.SQL.Clear;
          dm.ADOTMP1.SQL.Text:=' update data0541 '+
                  ' set check_status=1'+
                  ' from data0541 where rkey='+inttostr(rkey541);
           dm.ADOTMP1.ExecSQL;
           dm.ADO541.Active := True;
           dm.ADO541.Sort:=paixu2;
           dm.ADO541.Locate('rkey',rkey541,[]);
      end;

      dm.ADO545.Active := true;
      dm.ADO545.Locate('rkey',rkey_545,[]);
      DBGridEh1.SetFocus;

      end
      else
      begin
        dm.ADOTMP1.Close;
        showmessage('���״̬�Ѿ������ı�');
        dm.ADO545.Active:= False;
        dm.ADO545.Locate('rkey',rkey_545,[]);
        dm.ADO545.Active := true;
        exit;
      end;
    end;

  if (Tmenuitem(Sender).Tag in [3]) then
  begin
   if MessageBox(Handle,'ȷ���˻���������?'+#13+#13+'�˲����Ὣ������ͨ������˱�ʶΪδ���'+#13+#13+'���Ҵ˲���������','��ʾ',MB_YESNO+MB_ICONWARNING+MB_DEFBUTTON2)=IDNO	then exit;
         dm.ADO541.Active := false;
        dm.ADO545.Active := false;
              dm.ADOTMP1.Close;

              dm.ADOTMP1.SQL.Text:='update  data0545 '+
                  ' set check_status=0 '+
                  ' from data0545 where d541_ptr='+inttostr(rkey541)+
                  ' update  data0545 '+
                  ' set check_person='+user_ptr+
                  ', check_time=getdate()'+
                  ' from data0545 where rkey='+inttostr(demo.last_d545_rkey)+
                  ' update data0541 '+
                  ' set check_status=0,circle=circle+1 '+
                  ' from data0541 where rkey='+inttostr(rkey541);
              dm.ADOTMP1.ExecSQL;
        dm.ADOTMP1.SQL.Text:='';

        dm.ADO541.Active := True;
        dm.ADO541.Sort:=paixu2;
        dm.ADO541.Locate('rkey',rkey541,[]);

        dm.ADO545.Active := true;
        dm.ADO545.Locate('rkey',rkey_545,[]);
        DBGridEh1.SetFocus;
  end;

end;

procedure Tfrm_main.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
begin
  if dm.DS545.DataSet.FieldByName('check_status').AsInteger = 1
  then DBGridEh1.Canvas.Font.Color := clmaroon;
  DBGridEh1.DefaultDrawColumnCell(Rect,DataCol,Column,State);
     {
if dm.DS1.DataSet.FieldByName('״̬').Value = 'ͨ��ȫ�����'
   then  grd1.Canvas.Font.Color := clolive; //clmaroon ;
  grd1.DefaultDrawColumnCell(Rect, DataCol, Column, State);}
end;

procedure Tfrm_main.PopupMenu3Popup(Sender: TObject);
var max_index: Integer;
begin
 N6.Enabled := False; //���
 N8.Enabled := false;       //ȡ�����
 N14.Enabled := false;      //�˻�������

  if not  dm.ADO541.IsEmpty then
  begin
    dm.ADOTMP1.SQL.Clear;
    dm.ADOTMP1.SQL.Text := 'select top 1 rkey,d541_ptr,d34_index,d34_ptr,check_person,check_time,check_suggestion,check_status  from data0545 where d541_ptr='+inttostr(demo.rkey541)+' order by d34_index desc ';
    dm.ADOTMP1.Open;
     if not  dm.ADOTMP1.IsEmpty   then
     begin
       max_index := dm.ADOTMP1.FieldByName('d34_index').AsInteger;
       demo.last_check_dept:= dm.ADOTMP1.FieldByName('d34_ptr').AsInteger;
       demo.last_check_deptindex := dm.ADOTMP1.FieldByName('d34_index').AsInteger;
       demo.last_d545_rkey := dm.ADOTMP1.FieldByName('rkey').AsInteger;
     end;
     dm.ADOTMP1.Close;
     dm.ADOTMP1.SQL.Clear;

    if not dm.ADO545.IsEmpty then begin
          //���״̬Ϊ0 ,���ŶԵ���,��4Ȩ��,
       if (dm.ADO541check_status.AsInteger=1) and
          (dm.ADO545check_status.AsInteger=0) and
          (dm.ADO545d34_ptr.AsInteger =  demo.people_department) and
          ( (vprev ='4'))
          then N6.Enabled := true;

        //���״̬Ϊ1 ,���ŶԵ���,��4Ȩ��,
       if (dm.ADO545check_status.AsInteger=1) and
          (dm.ADO545d34_ptr.AsInteger =  demo.people_department) and
          ((vprev ='4')) and
          (dm.ADO545check_person.AsString = user_ptr)
          then N8.Enabled := true;


         //���״̬Ϊ0 ,���ŶԵ���,4Ȩ��,���һ������,��������
       if (dm.ADO541check_status.AsInteger=1) and
          (dm.ADO545check_status.AsInteger=0) and
          (dm.ADO545d34_ptr.AsInteger =  demo.people_department) and
          (vprev ='4') and
          (dm.ADO545d34_index.AsInteger = max_index)
          then N14.Enabled := true;
    end;


  end;



end;

procedure Tfrm_main.PopupMenu1Popup(Sender: TObject);
var cancle_flag :Integer;

begin
  cancle_flag := 0;
  N1.Enabled := False;
  N2.Enabled := False;
  N3.Enabled := False;
  N4.Enabled := False;
  if not dm.ADO545.Eof  then
  begin
    dm.ADOTMP1.Close;
    dm.ADOTMP1.SQL.Clear;
    dm.ADOTMP1.SQL.Text :='select * from data0545 where check_status=1 and d541_ptr='+inttostr(demo.rkey541);
    dm.ADOTMP1.ExecSQL;
    dm.ADOTMP1.Open;
    if not dm.ADOTMP1.Eof then cancle_flag := 0 else  cancle_flag := 1;
  end;
  //�½�Ȩ��
  if  ((vprev ='4')or (vprev ='2')) then
     N1.Enabled := true;

  //�ύȨ��
  //��״̬�� 0,������ǲ�����,�����ύ,����ɾ��
  if ((dm.ADO541check_status.AsInteger = 0) )
  then N2.Enabled := True;

    if ((dm.ADO541check_status.AsInteger = 0) and (dm.ADO541d05_ptr.AsInteger=demo.op_people))
  then N3.Enabled := True;

   if    (  (cancle_flag=1)and (dm.ADO541check_status.AsInteger = 1) and (dm.ADO541d05_ptr.AsInteger=demo.op_people) )
   then N4.Enabled := true;

end;

procedure Tfrm_main.Action1Execute(Sender: TObject);
begin
  BtFlds.Visible := True;
end;

procedure Tfrm_main.Grd1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if (ssAlt in Shift)  and  (Key=86) then
   showmessage(DM.ADO541.SQL.Text);
end;



procedure Tfrm_main.DBGridEh1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
   if (ssAlt in Shift)  and  (Key=86) then
   showmessage(DM.ADO545.SQL.Text);
end;





procedure Tfrm_main.N10Click(Sender: TObject);
begin
  Form_report:=TForm_report.Create(application);
//  ShowMessage(dm.ADO541rkey.asstring);
 Form_report.ADODataSet1.Close;
 Form_report.ADODataSet1.Parameters[0].Value:= dm.ADO541rkey.Value;
 Form_report.ADODataSet1.Open;
//ShowMessage(IntToStr(Form_report.ADODataSet1.RecordCount));
 Form_report.ppReport1.Reset;
 Form_report.ppReport1.Template.FileName:=
   StringReplace(UpperCase(extractfilepath(paramstr(0))),'EXEC\','NIERP\REPORT\',[rfReplaceAll])+'tiliaodan.rtm';
 Form_report.ppReport1.Template.LoadFromFile;
 Form_report.ppReport1.SaveAsTemplate:=False;
 Form_report.ppReport1.Print;
 Form_report.Free;
end;

procedure Tfrm_main.BitBtn1Click(Sender: TObject);
begin
  if (strtoint(vprev)=1) or (strtoint(vprev)=3) then
  begin
    messagedlg('�Բ���!��û�иó���Ŀ�дȨ��',mtinformation,[mbok],0);
    exit;
  end;
        try
         Form_report:= TForm_report.Create(application);
         Form_report.ppReport1.Reset;
         Form_report.ppReport1.Template.FileName :=
         stringReplace(GetCurrentDir,'EXEC','NIERP\REPORT\',[rfReplaceAll])+
         'tiliaodan.rtm';
         Form_report.ppReport1.Template.LoadFromFile;
         Form_report.ppReport1.SaveAsTemplate:=true;
         Form_report.ppdesigner1.ShowModal;
        finally
         Form_report.ADODataSet1.Close;
         Form_report.ADODataSet2.Close;
         Form_report.Free;
        end;
end;



end.





