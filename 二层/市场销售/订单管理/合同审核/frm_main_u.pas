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
    Grd2: TDBGridEh;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N13: TMenuItem;
    N2: TMenuItem;
    PopupMenu2: TPopupMenu;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    N15: TMenuItem;
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
    Button1: TButton;
    N16: TMenuItem;
    N18: TMenuItem;
    Splitter1: TSplitter;
    N19: TMenuItem;
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
    procedure PopupMenu2Popup(Sender: TObject);
    procedure N10Click(Sender: TObject);
    procedure N15Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure N11Click(Sender: TObject);
    procedure N12Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure Grd1TitleClick(Column: TColumnEh);
    procedure FormActivate(Sender: TObject);
    procedure Grd1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure N20Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
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
    procedure Button1Click(Sender: TObject);
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
  rkey0696: Integer;
  
const
 TmpFileDir = 'c:\tmp\';

implementation
 uses common, demo,shellAPI, frm_edit_u, Frm_QrySet_u,PubFunc, frm_check_u,
  frm_report_u, u_frmbusinessprocess, u_frmcpedit, PasAuthentic;
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
  rkey0 := 0;
  if not dm.ADO0696.IsEmpty then
    begin
      rkey0 := demo.rkey696;
      paixu := dm.ADO0696.Sort;
      dm.ADO0696.Active:=false;
      dm.ADO0696.Active:=true;
      dm.ADO0696.Sort:=paixu;
      dm.ADO0696.Locate('���',rkey0,[]);
    end;
end;

procedure Tfrm_main.BtQryClick(Sender: TObject);
var i: integer;
    Sqlstr,paixu:string;
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
      //paixu:=dm.ADO0696.Sort;
      //demo.rkey696:=0;
   //ShowMessage('ss2');
      dm.ADO0697.Close;
      dm.ADO0696.Close;
      dm.ADO0696.SQL.Text:=sSql+FsSearch;
      dm.ADO0696.Open;
      if not dm.ADO0696.IsEmpty then
        begin
          dm.ADO0697.Active:=true;
          dm.ADO0696.Sort:=paixu;
        end;
        // BtBrushClick(nil);
      if dm.ADO0696.IsEmpty then
        begin
          dm.ADO0697.Active:=false;
        end;
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
    send_msg:Tstringlist;
    rkey14,IsEmpty:Integer;
begin
    xuhao := dm.ADO0696DSDesigner.AsInteger;
    circle := dm.ADO0696circle.AsInteger;
    bptype := dm.ADO0696check_type.AsInteger;

  if  (Tmenuitem(Sender).Tag in [1]) then
    begin
      try
        Frm_Edit:=TFrm_Edit.Create(nil);
        Frm_Edit.pnl2.Enabled:=True;
        Frm_Edit.SpeedButton1.Enabled:=True;
         //frm_edit.Button1.Click;
        dm.ADOD04.Active:=false;
        dm.ADOD04.Active:=true;
        Frm_Edit.edit1.Text:=dm.ADOD04.FieldValues['seed_value'];
        if dm.ADOD04SEED_FLAG.Value=3 then Frm_Edit.Edit1.ReadOnly:=false;
        if Frm_Edit.ShowModal=mrok then
          begin
            dm.ADO0696.Close;
            dm.ADO0696.Open;
            dm.ado0696.Locate('��ͬ���',Frm_Edit.Edit1.Text,[]);
          end;
      finally
        Frm_Edit.Free;
      end;
    end;
  if (Tmenuitem(Sender).Tag in [2]) then
    begin
      if MessageBox(Handle,'ȷ��ɾ���˱����?','��ʾ',MB_YESNO+MB_ICONWARNING+MB_DEFBUTTON2)=IDNO	then exit;
      rkey0696:=demo.rkey696;
      dm.ADOTMP1.SQL.Clear;
      dm.ADO0696.Active:=false;
      dm.ADO0697.Active:=false;
      dm.ADOTMP1.SQL.Text:='delete from   data0696   from data0696 where rkey='+quotedstr(inttostr(rkey0696));
      dm.ADOTMP1.ExecSQL;
      dm.ADOTMP1.SQL.Text:='';
      dm.ADO0696.Active:=true;
      if not dm.ADO0696.IsEmpty  then
        begin
          rkey0696:=demo.rkey696;
          dm.ADO0696.Locate('���',xuhao,[]);
          dm.ADO0697.Active:=true;
        end;
    end;
//2017-11-20tang�����ˡ�ȡ����˹���---
//--���ύ��Ϊ��ˣ��ύ�����ı�״̬--
  if (Tmenuitem(Sender).Tag in [3]) then
    begin
      try
        frm_check:=Tfrm_check.Create(nil);
        frm_check.Caption :='�ύ��ͬ';
        frm_check.Label2.Caption:=dm.ADO0696.FieldValues['��ͬ���'];
        frm_check.Label6.Caption:=dm.ADO0696.FieldValues['��ͬ����'];
        frm_check.Label8.Caption:=dm.ADO0696.FieldValues['�׷����ͻ�������'];
        frm_check.Label4.Caption:='��ͬ�ύ';
        frm_check.RichEdit1.Text:=dm.ADO0696.fieldvalues['���������'];
        Frm_check.Button1.Caption:='�ύ';
        if frm_check.ShowModal=mrok then
          begin
            rkey0696:=demo.rkey696;
            dm.ADOTMP1.SQL.Clear;
            dm.ADO0696.Active:=false;
            dm.ADO0697.Active:=false;
            dm.ADOTMP1.SQL.Text:='update  data0696 set check_status=5,submit_person='+user_ptr+',submit_date=getdate(),submit_suggestion='
            +quotedstr(frm_check.RichEdit1.Text)+'  from data0696 where rkey='+quotedstr(inttostr(rkey0696));
            dm.ADOTMP1.ExecSQL;
            dm.ADOTMP1.SQL.Text:='';
            dm.ADO0696.Active:=true;
            dm.ADO0697.Active:=true;
            dm.ADO0696.Sort:=paixu2;
            dm.ADO0696.Locate('���',xuhao,[]);
          end;
      finally
        frm_check.Free;
      end;
    end;
  if (Tmenuitem(Sender).Tag in [4]) then
    begin
      rkey0696:=demo.rkey696;
      dm.ADOTMP1.SQL.Clear;
      dm.ADO0696.Active:=false;
      dm.ADO0697.Active:=false;
      dm.ADOTMP1.SQL.Text:='update  data0696 set check_status=0 from data0696 '+
        ' where rkey='+quotedstr(inttostr(rkey0696));
      dm.ADOTMP1.ExecSQL;
      dm.ADOTMP1.SQL.Text:='';
      dm.ADO0696.Active:=true;
      dm.ADO0697.Active:=true;
      dm.ADO0696.Sort:=paixu2;
      dm.ADO0696.Locate('���',xuhao,[]);
    end;  
//end 2017-11-20
  if (Tmenuitem(Sender).Tag in [5]) then
    begin
      try
        frm_check:=Tfrm_check.Create(nil);
        frm_check.Caption :='��������ȷ��';
        frm_check.Label2.Caption:=dm.ADO0696.FieldValues['��ͬ���'];
        frm_check.Label6.Caption:=dm.ADO0696.FieldValues['��ͬ����'];
        frm_check.Label8.Caption:=dm.ADO0696.FieldValues['�׷����ͻ�������'];
        frm_check.Label4.Caption:='�����ύ';
        frm_check.RichEdit1.Text:=dm.ADO0696.fieldvalues['���������'];
        if frm_check.ShowModal=mrok then
          begin
            rkey0696:=demo.rkey696;
            //20171106tang-- �����ظ����Ͷ���
            dm.ADOTMP1.Close;
            dm.ADOTMP1.SQL.Text:='select * from data0693 where d696_ptr='+inttostr(rkey0696);
            dm.ADOTMP1.Open;
            if not dm.ADOTMP1.IsEmpty then
              IsEmpty:=1
            else
              IsEmpty:=0;
            //end 20171106--
            dm.ADOTMP1.SQL.Clear;
            dm.ADO0696.Active:=false;
            dm.ADO0697.Active:=false;

            if circle=1 then
            dm.ADOTMP1.SQL.Text:=' insert into data0693(d696_ptr,d34_index,d34_ptr) '+
                   ' select '+inttostr(rkey0696)+',d34_index,d34_ptr from data0691  a join data0692 b on a.rkey=b.d691_ptr '+
                   ' where  a.rkey='+inttostr(bptype) +
                   ' and not  exists (select * from data0693 where d696_ptr='+inttostr(rkey0696)+')'+
                 ' update  data0696 set check_status=1 ,submit_suggestion='+quotedstr(frm_check.RichEdit1.Text)+
                 ', Audit_Date=getdate() '+
                 ', Audit_Prt='+user_ptr+
                 '  from data0696 where rkey='+quotedstr(inttostr(rkey0696))
            else
               dm.ADOTMP1.SQL.Text:=' update  data0696 set check_status=1 ,submit_suggestion='+quotedstr(frm_check.RichEdit1.Text)+
                 ', Audit_Date=getdate() '+
                 ', Audit_Prt='+user_ptr+
                 '  from data0696 where rkey='+quotedstr(inttostr(rkey0696));


            dm.ADOTMP1.ExecSQL;
            dm.ADOTMP1.SQL.Text:='';
          //20171103tang���ύ��������˶���
            if (IsEmpty=0) then
            begin
              send_msg:=Tstringlist.Create;
              send_msg.Text:='';
              send_msg.Add('��һ�ݺ�ͬ��š�'+frm_check.Label2.Caption+'����ͬ���ơ�'+frm_check.Label6.Caption+'���׷��ͻ����ơ�'+frm_check.Label8.Caption+'���ύ��������ز�����Ա��ˣ�');
              with dm.ADOTMP1 do
              begin
                close;
                sql.Clear;
                sql.Add('select * from data0014 where rkey is null');
                open;
                append;
                fieldvalues['MESSAGE'] := send_msg.Text;
                fieldvalues['whosend']:= rkey73;
                post;
                rkey14:=fieldvalues['rkey'];
              end;
              dm.ADOTMP2.Close;
              dm.ADOTMP2.SQL.Text:='insert into data0314 (emp_ptr,d14_ptr) select XX.USER_PTR,'+inttostr(rkey14)+' from (SELECT dbo.Data0074.USER_PTR'
                                  +' FROM dbo.Data0074 INNER JOIN '
                                  +'      dbo.Data0073 ON dbo.Data0074.USER_PTR = dbo.Data0073.RKEY INNER JOIN '
                                  +'      dbo.Data0005 ON dbo.Data0073.EMPLOYEE_PTR = dbo.Data0005.RKEY INNER JOIN '
                                  +'      dbo.Data0419 ON dbo.Data0074.FUNCTION_ID = dbo.Data0419.RKEY INNER JOIN '
                                  +'      dbo.data0693 ON dbo.Data0005.EMPLOYEE_ID = dbo.data0693.d34_ptr '
                                  +' WHERE (dbo.Data0419.PROGRAME = ''contract_control.exe'') AND (dbo.Data0074.USER_RIGHTS = 4)'
                                  +' AND (dbo.data0693.d696_ptr = '+inttostr(rkey0696)+')) as XX ';
              dm.ADOTMP2.ExecSQL;
            end;
          //end 20171103tang
            dm.ADO0696.Active:=true;
            dm.ADO0697.Active:=true;
            dm.ADO0696.Sort:=paixu2;
            dm.ADO0696.Locate('���',xuhao,[]);
          end;
      finally
        frm_check.Free;
      end;
    end;
  if (Tmenuitem(Sender).Tag in [6]) then
    begin
      rkey0696:=demo.rkey696;
      dm.ADOTMP1.SQL.Clear;
      dm.ADO0696.Active:=false;
      dm.ADO0697.Active:=false;
      dm.ADOTMP1.SQL.Text:='update  data0696 set check_status=0,Audit_Date=null,Audit_Prt=null from data0696 '+
        ' where rkey='+quotedstr(inttostr(rkey0696));
      dm.ADOTMP1.ExecSQL;
      dm.ADOTMP1.SQL.Text:='';
      dm.ADO0696.Active:=true;
      dm.ADO0697.Active:=true;
      dm.ADO0696.Sort:=paixu2;
      dm.ADO0696.Locate('���',xuhao,[]);
    end;  
  if (Tmenuitem(Sender).Tag in [7]) then
  begin
    try
      Frm_Edit:=TFrm_Edit.Create(Self);
      Frm_Edit.pnl2.Enabled:=False;
      Frm_Edit.Edit1.Text:=dm.ADO0696.FieldValues['��ͬ���'];
      Frm_Edit.Edit2.Text:=dm.ADO0696.FieldValues['��ͬ����'];
      Frm_Edit.Edit3.Text:=dm.ADO0696.FieldValues['�׷����ͻ�������'];
      Frm_Edit.Edit9.Text:=dm.ADO0696.FieldValues['�׷����ͻ�������en'];
      Frm_Edit.Edit4.Text:=dm.ADO0696.FieldValues['�׷����ͻ�������'];
      Frm_Edit.RichEdit1.Text:=dm.ADO0696.fieldvalues['���������'];
      Frm_Edit.RichEdit2.Text:=dm.ADO0696.fieldvalues['Remark'];
      Frm_Edit.SpeedButton1.Enabled:=False;
      Frm_Edit.ShowModal;
    finally
      Frm_Edit.Free;
    end;
  end;
end;

procedure Tfrm_main.PopupMenu2Popup(Sender: TObject);
var lastcheckflag,max_index : Integer;
begin
  n10.Enabled:=false;   //shangchuang
  n11.Enabled:=false;   // xiazai
  n12.Enabled:=false;    //shanchu
  n15.Enabled:=false;  //dakai
  lastcheckflag:=1;
 if not  dm.ADO0696.IsEmpty then
  begin
    dm.ADOTMP1.SQL.Clear;
    dm.ADOTMP1.SQL.Text := 'select top 1 rkey,d696_ptr,d34_index,d34_ptr,check_person,check_time,check_suggestion,check_status  from data0693 where d696_ptr='+inttostr(demo.rkey696)+' order by d34_index desc ';
    dm.ADOTMP1.Open;
    if not  dm.ADOTMP1.IsEmpty   then
    begin
      max_index := dm.ADOTMP1.FieldByName('d34_index').AsInteger;
      demo.last_check_dept:= dm.ADOTMP1.FieldByName('d34_ptr').AsInteger;
      demo.last_check_deptindex := dm.ADOTMP1.FieldByName('d34_index').AsInteger;
      demo.last_d0693_rkey := dm.ADOTMP1.FieldByName('rkey').AsInteger;
      if not dm.ADOTMP1.FieldByName('check_time').IsNull then
      demo.last_checktime :=dm.ADOTMP1.FieldByName('check_time').AsDateTime
      else  lastcheckflag :=0 ;

    end;
    dm.ADOTMP1.Close;
    dm.ADOTMP1.SQL.Clear;
    //�ϴ�Ȩ��  ,δ�ύ δ�����ж�֮ǰ���ϴ�,������ɾ��
    //�ϴ��ļ�
    //ɾ���ļ�

    {        //���״̬Ϊ1 ,���ŶԵ���,��4Ȩ��,
       if (dm.ADO0693check_status.AsInteger=1) and
          (dm.ADO0693d34_ptr.AsInteger =  demo.people_department) and
          ((vprev ='4')) and
          (dm.ADO0693check_person.AsString = user_ptr)
          then N8.Enabled := true;
}
    if ((dm.ADO0696check_status.AsInteger = 0 ) and
       (dm.ADO0696submit_person.AsString = user_ptr ) )
       then
       begin
         N10.Enabled := True;
             if  not  dm.ADO0697.IsEmpty then
         begin
            if dm.ADO0696circle.AsInteger=1 then N12.Enabled := True;
            if  (lastcheckflag=1) and (dm.ADO0697submit_date.AsDateTime>demo.last_checktime) then N12.Enabled := True; //N12ɾ������
          end;
       end;

       if demo.people_department <> demo.last_check_dept  then
       begin
          dm.ADOTMP2.SQL.Clear;
          dm.ADOTMP2.SQL.Text := 'select * from data0693 where d696_ptr='+inttostr(demo.rkey696)+' and d34_ptr='+inttostr(demo.people_department);
          dm.ADOTMP2.ExecSQL;
          dm.ADOTMP2.Open;
           if not dm.ADOTMP2.IsEmpty   then
           begin
             if ((vprev ='4') and (dm.ADO0696circle.AsInteger=1)) then  N10.Enabled := true;  //N10�ϴ�����
           end;


       end;


    if  ( (demo.people_department = demo.last_check_dept) and  (dm.ADO0696check_status.AsInteger <>2 ) and (vprev ='4'))
    then
    begin
        N10.Enabled := True;
        if  not  dm.ADO0697.IsEmpty then
        begin
            N12.Enabled := True;
        end;
    end;

    if  not  dm.ADO0697.IsEmpty then
    begin
      n11.Enabled:=true;// �����ļ�
     n15.Enabled:=true; //���ļ�
    end;

    end;
end;

procedure Tfrm_main.N10Click(Sender: TObject);
var i:integer;
    y:integer;
    s:string;
    fs: TMemoryStream;
begin
  y:=demo.rkey696;
  OpenDialog1.DefaultExt :='*.*';
  OpenDialog1.Filter :='';
  if OpenDialog1.Execute then
  begin
    for i:=length(OpenDialog1.FileName) downto 1 do
    begin
      if OpenDialog1.FileName[i]<>'\' then
        s:=OpenDialog1.FileName[i]+s
      else
        break;
      end;
      fs := TMemoryStream.Create;
      fs.LoadFromFile(OpenDialog1.FileName);
      if fs.Size>10*1024*1024 then
      begin
        showmessage('�ļ���С���ܳ���10M,�����������ļ��ٱ���...');
        fs.Free;
        exit;
      end;
      PackStream(fs);
      if s <> '' then
      begin
        dm.ADOTMP1.Close;
        dm.ADOTMP1.SQL.Clear;
        dm.ADOTMP1.SQL.Text:='select [file_name] from data0697 where [file_name]= '''+s+''' and contract_rkey='+inttostr(demo.rkey696);
        dm.ADOTMP1.Open;
        if not DM.ADOTMP1.IsEmpty then
          begin

            if Messagedlg('�Ѿ����ڸ��ļ���'+#13+'��Ҫ�������'+#39+'��'+#39,mtWarning,[mbYES,mbNO],0)=6  then
              begin
                dm.ADO0697.Locate('file_name',s,[]);
                dm.ADO0697.Edit;
                dm.ADO0697modify_person.Value:=demo.op_people;
                dm.ADO0697modify_date.Value:=now();
                dm.ADO0697flag.Value:=3;
                try
                  dm.ADOTMP1.SQL.Clear;
                  dm.ADOTMP1.SQL.Add('update data0697 '+
                    'set file_data=:file_data_s from data0697 where [file_name]= '''+s+''' and contract_rkey='+inttostr(demo.rkey696) );
                  dm.ADOTMP1.Parameters.ParamByName('file_data_s').LoadFromStream(fs,ftBlob);
                  dm.ADOTMP1.ExecSQL;
                  dm.ADOTMP1.SQL.Clear;
                  dm.ADO0697.Post;
                  fs.Free;
                  showmessage('�ļ��޸ĳɹ�');
                  dm.ADO0697.Close;
                  if not dm.ADO0696.IsEmpty then dm.ADO0697.Open;
                except
                  dm.ADOTMP1.CanModify;
                  showmessage('�ļ��ϴ�ʧ��');
                  fs.Free;
                end;
              end
            else
              begin
                showmessage('�������ļ���������ѡ�����ļ�');
                abort;
              end;
          end
        else
          begin
            dm.ADO0697.Append;
            dm.ADO0697contract_rkey.Value:=demo.rkey696;
            dm.ADO0697submit_person.Value:=demo.op_people;
            dm.ADO0697file_name.Value:=s;
            dm.ADO0697submit_date.Value:=now();
            dm.ADO0697flag.Value:=0;
            try
              dm.ADO0697.Post;
            except
              dm.ADO0697.Cancel;
              showmessage('�½��ļ�Ŀ¼ʧ��');
            end;
            try
              dm.ADOTMP1.SQL.Clear;
              dm.ADOTMP1.SQL.Add('update data0697 '+
                'set flag=1,file_data=:file_data_s from data0697 where [file_name]= '''+
                s+''' and contract_rkey='+inttostr(demo.rkey696) );
              dm.ADOTMP1.Parameters.ParamByName('file_data_s').LoadFromStream(fs,ftBlob);
              dm.ADOTMP1.ExecSQL;
              dm.ADOTMP1.SQL.Clear;
              fs.Free;
              showmessage('�ļ��ϴ��ɹ�');
            except
              dm.ADOTMP1.CancelUpdates;
              showmessage('�ļ��ϴ�ʧ��');
              fs.Free;
            end;
            dm.ADO0697.Active:=false;
            dm.ADO0697.Active:=true;
            //file_name.Add(OpenDialog1.FileName+';'+'0');
          end;
      end;
      if s='' then showmessage('�ļ�Ϊ��');
  end;
end;

procedure Tfrm_main.N15Click(Sender: TObject);
var
  filename,f: string;
  fs: TMemoryStream;
begin
 dm.ADOTMP1.SQL.Clear;
 dm.ADOTMP1.SQL.Text:='select file_data from data0697 where [file_name]='+quotedstr(dm.ADO0697file_name.AsString)+' and  contract_rkey='+inttostr(demo.rkey696);
 dm.adotmp1.Open;
 if dm.ADOTMP1.FieldByName('file_data').IsNull then
  begin
    showmessage('���ĵ�Ϊ��');
    exit;
  end
 else
  begin
    fs:=TMemoryStream.Create;
    TBlobfield(dm.ADOTMP1.fieldbyname('file_data')).SaveToStream(fs);
    if not DirectoryExists(TmpFileDir) then
      if not CreateDir(TmpFileDir) then
        raise Exception.Create('������ʱ�ļ�Ŀ¼����: '+TmpFileDir);
    UnPackStream(fs);
    f:=TmpFileDir+dm.ADO0697file_name.AsString;
    fs.SaveToFile(f);
    fs.Free;
    dm.ADOTMP1.Close;
    dm.ADOTMP1.SQL.Clear;
    // setfileattributes(pchar(f),FILE_ATTRIBUTE_READONLY);
    ShellExecute(0,'open',pchar(f),nil,nil,SW_SHOWNORMAL);
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

procedure Tfrm_main.N11Click(Sender: TObject);
var
  filename,f: string;
  fs: TMemoryStream;
begin
  dm.ADOTMP1.SQL.Clear;
  dm.ADOTMP1.SQL.Text:='select file_data from data0697 where [file_name]='+
    quotedstr(dm.ADO0697file_name.AsString)+' and  contract_rkey='+inttostr(demo.rkey696);
  dm.adotmp1.Open;
  if dm.ADOTMP1.FieldByName('file_data').IsNull then
    begin
      showmessage('���ĵ�Ϊ��');
      exit;
    end
  else
    begin
      fs:=TMemoryStream.Create;
      TBlobfield(dm.ADOTMP1.fieldbyname('file_data')).SaveToStream(fs);
      savedialog1.FileName:=dm.ADO0697file_name.AsString;
      SaveDialog1.Filter :='*.*';
      if SaveDialog1.Execute then
      begin
        UnPackStream(fs);
        f:=savedialog1.FileName;
        fs.SaveToFile(f);
        application.MessageBox('�ļ�����ɹ�!','��ʾ!',64);
      end;
      fs.Free;
      dm.ADOTMP1.Close;
      dm.ADOTMP1.SQL.Clear;
      // setfileattributes(pchar(f),FILE_ATTRIBUTE_READONLY);
    end;
end;

procedure Tfrm_main.N12Click(Sender: TObject);
var
  f,k: string;
begin
  if MessageBox(Handle,'ȷ��ɾ�����ĵ���?','��ʾ',MB_YESNO+MB_ICONWARNING+MB_DEFBUTTON2)=IDNO	then exit;
  f:=dm.ADO0697file_name.AsString;
  k:=inttostr(demo.rkey696);
  dm.ADOTMP1.SQL.Clear;
  dm.ADO0696.Active:=false;
  dm.ADO0697.Active:=false;
  dm.ADOTMP1.SQL.Text:='delete from   data0697   from data0697 where [file_name]='+quotedstr(f)+' and  contract_rkey='+k;
  dm.ADOTMP1.ExecSQL;
  dm.ADOTMP1.SQL.Text:='';
  dm.ADO0696.Active:=true;
  if not dm.ADO0696.IsEmpty then dm.ADO0697.Active:=true;
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
      DM.ADO0696.Sort:=Column.FieldName;
    end
  else
    begin
      column.Title.SortMarker:=smDownEh;
      DM.ADO0696.Sort:=Column.FieldName+' DESC';
    end;
  DM.ADO0696AfterScroll(DM.ADO0696);
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
  DM.ADO0696.SQL.Text:=DM.ADO0696.SQL.Text+
    ' and  submit_date>='''+formatdatetime('YYYY-MM-DD',date-30)+
    ''' and  submit_date-1<='''+formatdatetime('YYYY-MM-DD',date)+''' ';
    //Memo1.Text:=('�������»');
  DM.ADO0696.Prepared;
    //memo1.Text:=DM.ADO0696.SQL.Text;
    //showmessage('sss');
  DM.ADO0696.Open;
  if not dm.ADO0696.IsEmpty then
  DM.ADO0696.Sort:=grd1.Columns[0].FieldName;
end;

procedure Tfrm_main.FormCreate(Sender: TObject);
begin
 if not app_init_2(dm.ADOConnection1) then
  begin
    common.ShowMsg('��������ʧ��,����ϵϵͳ����Ա',1);
    application.Terminate;
  end;
  self.Caption :=Application.Title;

//   user_ptr:='2427'; //��ԱID  '1752'
//   vprev:='4';    //Ȩ��
//   rkey73:='4113';   //'1593'
//   dm.ADOConnection1.Open;

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
    if (vprev ='1') or (vprev ='2')  then
      ssql_filter:=' and submit_person='+user_ptr
    else
      ssql_filter:=' and  ( (submit_person='+user_ptr
      + ') or (data0696.rkey in (select d696_ptr  from data0693 where d34_ptr='+inttostr(demo.people_department)
      +')) or ((submit_department=(select EMPLOYEE_ID from Data0005 where rkey='+quotedstr(user_ptr)+' )) and data0696.check_status=5) ) ';
      //dm.ADO0696.Filter:=ssql_filter;
    if  strtoint(vprev) <> 4  then //ֻ��д���Ĳ��ܶ��屨��
    begin
      bitbtn1.Visible := false;
    end;
    dm.ADO0696.SQL.Text:=dm.ADO0696.SQL.Text+ssql_filter;
    sSql:=dm.ADO0696.SQL.Text;
//    showmessage(dm.ADO0696.SQL.Text);
    init;
end;
procedure Tfrm_main.Grd1DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
begin
    if dm.ADO0696check_status.AsInteger=0
   then  grd1.Canvas.Font.Color := clFuchsia;
    if dm.ADO0696check_status.AsInteger=1
   then  grd1.Canvas.Font.Color := clGreen;
      if dm.ADO0696check_status.AsInteger=2
   then  grd1.Canvas.Font.Color := clolive;
   if dm.ADO0696check_status.AsInteger=5
   then  grd1.Canvas.Font.Color := clRed;

   //clolive; //clmaroon//clmaroon ;


  grd1.DefaultDrawColumnCell(Rect, DataCol, Column, State); 
end;

procedure Tfrm_main.N20Click(Sender: TObject);
begin
if ((demo.rkey696 = 0) or (dm.ADO0696.IsEmpty) )
  then
    begin
      showmessage('��ѡ����Ҫ��ӡ�ļ�¼');
      abort;
    end;
 form_report := tform_report.Create(application);
 form_report.ADODataSet1.Close;
 form_report.ADODataSet1.Parameters[0].Value := demo.rkey696;
 form_report.ADODataSet1.open;
 //form_report.ADODataSet2.Parameters[0].Value := demo.rkey696;
 //form_report.ADODataSet2.open;
 Form_report.ppReport1.Reset;
 Form_report.ppReport1.Template.FileName :=
     StringReplace(GetCurrentDir,'EXEC','NIERP\REPORT\',[rfReplaceAll])+
         'contract_control_rpt.rtm';
 Form_report.ppReport1.Template.LoadFromFile;
 form_report.ppReport1.SaveAsTemplate:=false;
 form_report.ppReport1.Print;
 //bitbtn3click(sender);
 form_report.free;
end;

procedure Tfrm_main.BitBtn1Click(Sender: TObject);
begin
  if (strtoint(vprev) <> 4) then
  begin
    messagedlg('�Բ���!��û�иó���Ŀ�дȨ��',mtinformation,[mbok],0);
    exit;
  end;
        form_report := tform_report.Create(application);
        Form_report.ppReport1.Reset;
        Form_report.ppReport1.Template.FileName :=
        stringReplace(GetCurrentDir,'EXEC','NIERP\REPORT\',[rfReplaceAll])+
        'contract_control_rpt.rtm';
        Form_report.ppReport1.Template.LoadFromFile;
        Form_report.ppReport1.SaveAsTemplate:=true;
        Form_report.ppdesigner1.ShowModal;
        form_report.free;
end;



procedure Tfrm_main.N21Click(Sender: TObject);
begin
      try
        frm_check:=Tfrm_check.Create(nil);
        frm_check.Caption := 'һ��';
        frm_check.Label2.Caption:=dm.ADO0696.FieldValues['��ͬ���'];
        frm_check.Label6.Caption:=dm.ADO0696.FieldValues['��ͬ����'];
        frm_check.Label8.Caption:=dm.ADO0696.FieldValues['�׷����ͻ�������'];
        frm_check.Label4.Caption:=dm.ADO0696.FieldValues['״̬'];
        dm.ADOTMP1.SQL.Clear;
        dm.ADOTMP1.SQL.Text := ' select check_suggestion_1'+
          ' as shyj from data0696 where rkey= '+inttostr(demo.rkey696);
        dm.ADOTMP1.Open;
        frm_check.RichEdit1.Text:=dm.ADOTMP1.FieldValues['shyj'];
        dm.ADOTMP1.Close;
        dm.ADOTMP1.SQL.Clear;
        if frm_check.ShowModal=mrok then
        begin
          rkey0696:=demo.rkey696;
          dm.ADOTMP1.SQL.Clear;
          dm.ADOTMP1.SQL.Text:='select [check_status] from data0696 where rkey='+
            quotedstr(inttostr(rkey0696));
          dm.ADOTMP1.Open;
          if (dm.ADOTMP1.FieldByName('check_status').AsInteger = demo.rkey696_status) then
            begin
              dm.ADOTMP1.Close;
              dm.ADO0697.Active:=false;
              dm.ADO0696.Active:=false;
              dm.ADOTMP1.SQL.Text:='update  data0696 '+
                  ' set check_status=check_status+2'+
                  ', check_person_1 ='+user_ptr+
                  ', check_date_1=getdate()'+
                  ', check_suggestion_1'+
                  '='+quotedstr(frm_check.RichEdit1.Text)+
                  ' from data0696 where rkey='+quotedstr(inttostr(rkey0696));
              dm.ADOTMP1.ExecSQL;
              dm.ADOTMP1.SQL.Text:='';
              dm.ADO0696.Active:=true;
              if not dm.ADO0696.IsEmpty then dm.ADO0697.Active:=true;
              dm.ADO0696.Sort:=paixu2;
              dm.ADO0696.Locate('���',rkey0696,[]);
            end
            else
              begin
                dm.ADOTMP1.Close;
                showmessage('���״̬�Ѿ������ı�');
                dm.ADO0697.Active:=false;
                dm.ADO0696.Active:=false;
                dm.ADO0696.Active:=true;
                if not dm.ADO0696.IsEmpty then dm.ADO0697.Active:=true;
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
        rkey0696:=demo.rkey696;
        dm.ADOTMP1.SQL.Clear;
        dm.ADOTMP1.SQL.Text:='select [check_status] from data0696 where rkey='+
            quotedstr(inttostr(rkey0696));
        dm.ADOTMP1.Open;
          if (dm.ADOTMP1.FieldByName('check_status').AsInteger = demo.rkey696_status) then
            begin
              dm.ADOTMP1.Close;
              dm.ADO0697.Active:=false;
              dm.ADO0696.Active:=false;
              dm.ADOTMP1.SQL.Text:='update  data0696 '+
                  ' set check_status=check_status-2'+
                  ', check_person_1 ='+user_ptr+
                  ', check_date_1=getdate()'+
                  ', check_suggestion_��='+#39+'ԭ���飺��'+orginal_str+'����ȡ��һ��'+#39+
                  ' from data0696 where rkey='+quotedstr(inttostr(rkey0696));
              dm.ADOTMP1.ExecSQL;
              dm.ADOTMP1.SQL.Text:='';
              dm.ADO0696.Active:=true;
              if not dm.ADO0696.IsEmpty then dm.ADO0697.Active:=true;
              dm.ADO0696.Sort:=paixu2;
              dm.ADO0696.Locate('���',rkey0696,[]);
            end
            else
              begin
                dm.ADOTMP1.Close;
                showmessage('���״̬�Ѿ������ı�');
                dm.ADO0697.Active:=false;
                dm.ADO0696.Active:=false;
                dm.ADO0696.Active:=true;
                if not dm.ADO0696.IsEmpty then dm.ADO0697.Active:=true;
                exit;
              end; 
      end;


procedure Tfrm_main.N23Click(Sender: TObject);
begin
      try
        frm_check:=Tfrm_check.Create(nil);
        frm_check.Caption := '���';
        frm_check.Label2.Caption:=dm.ADO0696.FieldValues['��ͬ���'];
        frm_check.Label6.Caption:=dm.ADO0696.FieldValues['��ͬ����'];
        frm_check.Label8.Caption:=dm.ADO0696.FieldValues['�׷����ͻ�������'];
        frm_check.Label4.Caption:=dm.ADO0696.FieldValues['״̬'];
        dm.ADOTMP1.SQL.Clear;
        dm.ADOTMP1.SQL.Text := ' select check_suggestion_2'+
          ' as shyj from data0696 where rkey= '+inttostr(demo.rkey696);
        dm.ADOTMP1.Open;
        frm_check.RichEdit1.Text:=dm.ADOTMP1.FieldValues['shyj'];
        dm.ADOTMP1.Close;
        dm.ADOTMP1.SQL.Clear;
        if frm_check.ShowModal=mrok then
        begin
          rkey0696:=demo.rkey696;
          dm.ADOTMP1.SQL.Clear;
          dm.ADOTMP1.SQL.Text:='select [check_status] from data0696 where rkey='+
            quotedstr(inttostr(rkey0696));
          dm.ADOTMP1.Open;
          if (dm.ADOTMP1.FieldByName('check_status').AsInteger = demo.rkey696_status) then
            begin
              dm.ADOTMP1.Close;
              dm.ADO0697.Active:=false;
              dm.ADO0696.Active:=false;
              dm.ADOTMP1.SQL.Text:='update  data0696 '+
                  ' set check_status=check_status+4'+
                  ', check_person_2 ='+user_ptr+
                  ', check_date_2=getdate()'+
                  ', check_suggestion_2'+
                  '='+quotedstr(frm_check.RichEdit1.Text)+
                  ' from data0696 where rkey='+quotedstr(inttostr(rkey0696));
              dm.ADOTMP1.ExecSQL;
              dm.ADOTMP1.SQL.Text:='';
              dm.ADO0696.Active:=true;
              if not dm.ADO0696.IsEmpty then dm.ADO0697.Active:=true;
              dm.ADO0696.Sort:=paixu2;
              dm.ADO0696.Locate('���',rkey0696,[]);
            end
            else
              begin
                dm.ADOTMP1.Close;
                showmessage('���״̬�Ѿ������ı�');
                dm.ADO0697.Active:=false;
                dm.ADO0696.Active:=false;
                dm.ADO0696.Active:=true;
                if not dm.ADO0696.IsEmpty then dm.ADO0697.Active:=true;
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
        rkey0696:=demo.rkey696;
        dm.ADOTMP1.SQL.Clear;
        dm.ADOTMP1.SQL.Text:='select [check_status] from data0696 where rkey='+
            quotedstr(inttostr(rkey0696));
        dm.ADOTMP1.Open;
          if (dm.ADOTMP1.FieldByName('check_status').AsInteger = demo.rkey696_status) then
            begin
              dm.ADOTMP1.Close;
              dm.ADO0697.Active:=false;
              dm.ADO0696.Active:=false;
              dm.ADOTMP1.SQL.Text:='update  data0696 '+
                  ' set check_status=check_status-4'+
                  ', check_person_2 ='+user_ptr+
                  ', check_date_2=getdate()'+
                  ', check_suggestion_2='+#39+'ԭ���飺��'+orginal_str+'����ȡ������'+#39+
                  ' from data0696 where rkey='+quotedstr(inttostr(rkey0696));
              dm.ADOTMP1.ExecSQL;
              dm.ADOTMP1.SQL.Text:='';
              dm.ADO0696.Active:=true;
              if not dm.ADO0696.IsEmpty then dm.ADO0697.Active:=true;
              dm.ADO0696.Sort:=paixu2;
              dm.ADO0696.Locate('���',rkey0696,[]);
            end
            else
              begin
                dm.ADOTMP1.Close;
                showmessage('���״̬�Ѿ������ı�');
                dm.ADO0697.Active:=false;
                dm.ADO0696.Active:=false;
                dm.ADO0696.Active:=true;
                if not dm.ADO0696.IsEmpty then dm.ADO0697.Active:=true;
                exit;
              end;
end;

procedure Tfrm_main.N25Click(Sender: TObject);
begin
      try
        frm_check:=Tfrm_check.Create(nil);
        frm_check.Caption := '���';
        frm_check.Label2.Caption:=dm.ADO0696.FieldValues['��ͬ���'];
        frm_check.Label6.Caption:=dm.ADO0696.FieldValues['��ͬ����'];
        frm_check.Label8.Caption:=dm.ADO0696.FieldValues['�׷����ͻ�������'];
        frm_check.Label4.Caption:=dm.ADO0696.FieldValues['״̬'];
        dm.ADOTMP1.SQL.Clear;
        dm.ADOTMP1.SQL.Text := ' select check_suggestion_3'+
          ' as shyj from data0696 where rkey= '+inttostr(demo.rkey696);
        dm.ADOTMP1.Open;
        frm_check.RichEdit1.Text:=dm.ADOTMP1.FieldValues['shyj'];
        dm.ADOTMP1.Close;
        dm.ADOTMP1.SQL.Clear;
        if frm_check.ShowModal=mrok then
        begin
          rkey0696:=demo.rkey696;
          dm.ADOTMP1.SQL.Clear;
          dm.ADOTMP1.SQL.Text:='select [check_status] from data0696 where rkey='+
            quotedstr(inttostr(rkey0696));
          dm.ADOTMP1.Open;
          if (dm.ADOTMP1.FieldByName('check_status').AsInteger = demo.rkey696_status) then
            begin
              dm.ADOTMP1.Close;
              dm.ADO0697.Active:=false;
              dm.ADO0696.Active:=false;
              dm.ADOTMP1.SQL.Text:='update  data0696 '+
                  ' set check_status=check_status+8'+
                  ', check_person_3 ='+user_ptr+
                  ', check_date_3=getdate()'+
                  ', check_suggestion_3'+
                  '='+quotedstr(frm_check.RichEdit1.Text)+
                  ' from data0696 where rkey='+quotedstr(inttostr(rkey0696));
              dm.ADOTMP1.ExecSQL;
              dm.ADOTMP1.SQL.Text:='';
              dm.ADO0696.Active:=true;
              if not dm.ADO0696.IsEmpty then dm.ADO0697.Active:=true;
              dm.ADO0696.Sort:=paixu2;
              dm.ADO0696.Locate('���',rkey0696,[]);
            end
            else
              begin
                dm.ADOTMP1.Close;
                showmessage('���״̬�Ѿ������ı�');
                dm.ADO0697.Active:=false;
                dm.ADO0696.Active:=false;
                dm.ADO0696.Active:=true;
                if not dm.ADO0696.IsEmpty then dm.ADO0697.Active:=true;
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
        rkey0696:=demo.rkey696;
        dm.ADOTMP1.SQL.Clear;
        dm.ADOTMP1.SQL.Text:='select [check_status] from data0696 where rkey='+
            quotedstr(inttostr(rkey0696));
        dm.ADOTMP1.Open;
          if (dm.ADOTMP1.FieldByName('check_status').AsInteger = demo.rkey696_status) then
            begin
              dm.ADOTMP1.Close;
              dm.ADO0697.Active:=false;
              dm.ADO0696.Active:=false;
              dm.ADOTMP1.SQL.Text:='update  data0696 '+
                  ' set check_status=check_status-8'+
                  ', check_person_3 ='+user_ptr+
                  ', check_date_3=getdate()'+
                  ', check_suggestion_3='+#39+'ԭ���飺��'+orginal_str+'����ȡ������'+#39+
                  ' from data0696 where rkey='+quotedstr(inttostr(rkey0696));
              dm.ADOTMP1.ExecSQL;
              dm.ADOTMP1.SQL.Text:='';
              dm.ADO0696.Active:=true;
              if not dm.ADO0696.IsEmpty then dm.ADO0697.Active:=true;
              dm.ADO0696.Sort:=paixu2;
              dm.ADO0696.Locate('���',rkey0696,[]);
            end
            else
              begin
                dm.ADOTMP1.Close;
                showmessage('���״̬�Ѿ������ı�');
                dm.ADO0697.Active:=false;
                dm.ADO0696.Active:=false;
                dm.ADO0696.Active:=true;
                if not dm.ADO0696.IsEmpty then dm.ADO0697.Active:=true;
                exit;
              end; 
end;



procedure Tfrm_main.N9Click(Sender: TObject);
var orginal_str: string;
begin
          orginal_str := dm.DS1.DataSet.FieldValues['��ͬ�������'];
          dm.ADOTMP1.Close;
          dm.ADOTMP1.SQL.Clear;
          rkey0696:=demo.rkey696;
          dm.ADOTMP1.SQL.Clear;
          dm.ADOTMP1.SQL.Text:='select [check_status] from data0696 where rkey='+
          quotedstr(inttostr(rkey0696));
          dm.ADOTMP1.Open;
          if (dm.ADOTMP1.FieldByName('check_status').AsInteger = demo.rkey696_status) then
            begin
              dm.ADOTMP1.Close;
              dm.ADO0697.Active:=false;
              dm.ADO0696.Active:=false;
              dm.ADOTMP1.SQL.Text:='update  data0696 '+
                  ' set check_status=check_status-16'+
                  ', check_person_4 ='+user_ptr+
                  ', check_date_4=getdate()'+
                  ', check_suggestion_4='+#39+'ԭ���飺��'+orginal_str+'����ȡ������'+#39+
                  ' from data0696 where rkey='+quotedstr(inttostr(rkey0696));
              dm.ADOTMP1.ExecSQL;
              dm.ADOTMP1.SQL.Text:='';
              dm.ADO0696.Active:=true;
              if not dm.ADO0696.IsEmpty then dm.ADO0697.Active:=true;
              dm.ADO0696.Sort:=paixu2;
              dm.ADO0696.Locate('���',rkey0696,[]);
            end
            else
              begin
                dm.ADOTMP1.Close;
                showmessage('���״̬�Ѿ������ı�');
                dm.ADO0697.Active:=false;
                dm.ADO0696.Active:=false;
                dm.ADO0696.Active:=true;
                if not dm.ADO0696.IsEmpty then dm.ADO0697.Active:=true;
                exit;
              end;
end;

procedure Tfrm_main.N17Click(Sender: TObject);
begin
        try
        frm_check:=Tfrm_check.Create(nil);
        frm_check.Caption := '���';
        frm_check.Label2.Caption:=dm.ADO0696.FieldValues['��ͬ���'];
        frm_check.Label6.Caption:=dm.ADO0696.FieldValues['��ͬ����'];
        frm_check.Label8.Caption:=dm.ADO0696.FieldValues['�׷����ͻ�������'];
        frm_check.Label4.Caption:=dm.ADO0696.FieldValues['״̬'];
        dm.ADOTMP1.SQL.Clear;
        dm.ADOTMP1.SQL.Text := ' select check_suggestion_5'+
          ' as shyj from data0696 where rkey= '+inttostr(demo.rkey696);
        dm.ADOTMP1.Open;
        frm_check.RichEdit1.Text:=dm.ADOTMP1.FieldValues['shyj'];
        dm.ADOTMP1.Close;
        dm.ADOTMP1.SQL.Clear;
        if frm_check.ShowModal=mrok then
        begin
          rkey0696:=demo.rkey696;
          dm.ADOTMP1.SQL.Clear;
          dm.ADOTMP1.SQL.Text:='select [check_status] from data0696 where rkey='+
            quotedstr(inttostr(rkey0696));
          dm.ADOTMP1.Open;
          if (dm.ADOTMP1.FieldByName('check_status').AsInteger = demo.rkey696_status) then
            begin
              dm.ADOTMP1.Close;
              dm.ADO0697.Active:=false;
              dm.ADO0696.Active:=false;
              dm.ADOTMP1.SQL.Text:='update  data0696 '+
                  ' set check_status=check_status+32'+
                  ', check_person_5 ='+user_ptr+
                  ', check_date_5=getdate()'+
                  ', check_suggestion_5'+
                  '='+quotedstr(frm_check.RichEdit1.Text)+
                  ' from data0696 where rkey='+quotedstr(inttostr(rkey0696));
              dm.ADOTMP1.ExecSQL;
              dm.ADOTMP1.SQL.Text:='';
              dm.ADO0696.Active:=true;
              if not dm.ADO0696.IsEmpty then dm.ADO0697.Active:=true;
              dm.ADO0696.Sort:=paixu2;
              dm.ADO0696.Locate('���',rkey0696,[]);
            end
            else
              begin
                dm.ADOTMP1.Close;
                showmessage('���״̬�Ѿ������ı�');
                dm.ADO0697.Active:=false;
                dm.ADO0696.Active:=false;
                dm.ADO0696.Active:=true;
                if not dm.ADO0696.IsEmpty then dm.ADO0697.Active:=true;
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
        rkey0696:=demo.rkey696;
        dm.ADOTMP1.SQL.Clear;
        dm.ADOTMP1.SQL.Text:='select [check_status] from data0696 where rkey='+
            quotedstr(inttostr(rkey0696));
        dm.ADOTMP1.Open;
          if (dm.ADOTMP1.FieldByName('check_status').AsInteger = demo.rkey696_status) then
            begin
              dm.ADOTMP1.Close;
              dm.ADO0697.Active:=false;
              dm.ADO0696.Active:=false;
              dm.ADOTMP1.SQL.Text:='update  data0696 '+
                  '  set check_status=check_status-32'+
                  ', check_person_5 ='+user_ptr+
                  ', check_date_5=getdate()'+
                  ', check_suggestion_5='+#39+'ԭ���飺��'+orginal_str+'����ȡ������'+#39+
                  ' from data0696 where rkey='+quotedstr(inttostr(rkey0696));
              dm.ADOTMP1.ExecSQL;
              dm.ADOTMP1.SQL.Text:='';
              dm.ADO0696.Active:=true;
              if not dm.ADO0696.IsEmpty then dm.ADO0697.Active:=true;
              dm.ADO0696.Sort:=paixu2;
              dm.ADO0696.Locate('���',rkey0696,[]);
            end
            else
              begin
                dm.ADOTMP1.Close;
                showmessage('���״̬�Ѿ������ı�');
                dm.ADO0697.Active:=false;
                dm.ADO0696.Active:=false;
                dm.ADO0696.Active:=true;
                if not dm.ADO0696.IsEmpty then dm.ADO0697.Active:=true;
                exit;
              end;
end;

procedure Tfrm_main.N7Click(Sender: TObject);
begin
    try
      frm_check:=Tfrm_check.Create(nil);
      frm_check.Caption :='�����˻�������';
      frm_check.Label2.Caption:=dm.ADO0696.FieldValues['��ͬ���'];
      frm_check.Label6.Caption:=dm.ADO0696.FieldValues['��ͬ����'];
      frm_check.Label8.Caption:=dm.ADO0696.FieldValues['�׷����ͻ�������'];
      frm_check.Label4.Caption:=dm.ADO0696.FieldValues['״̬']; 
      //Frm_Edit.Ftag:=Tmenuitem(Sender).Tag;
      //Frm_Edit.init;
        dm.ADOTMP1.SQL.Clear;
        dm.ADOTMP1.SQL.Text := ' select check_suggestion_5'+
          ' as shyj from data0696 where rkey= '+inttostr(demo.rkey696);
        dm.ADOTMP1.Open;
        frm_check.RichEdit1.Text:=dm.ADOTMP1.FieldValues['shyj'];
        dm.ADOTMP1.Close;
        dm.ADOTMP1.SQL.Clear;
      if frm_check.ShowModal=mrok then
      begin
        rkey0696:=demo.rkey696;
        dm.ADOTMP1.SQL.Clear;
        dm.ADOTMP1.SQL.Text:='select [check_status] from data0696 where rkey='+
          quotedstr(inttostr(rkey0696));
        dm.ADOTMP1.Open;
        if (dm.ADOTMP1.FieldByName('check_status').AsInteger =demo.rkey696_status) then
          begin
            dm.ADOTMP1.Close;
            dm.ADOTMP1.SQL.Clear;
            dm.ADO0696.Active:=false;
            dm.ADO0697.Active:=false;
            dm.ADOTMP1.SQL.Text:='update  data0696 '+
              'set check_status=check_status-1'+
              ', check_person_5='+user_ptr+
              ', check_date_5=getdate()'+
              ', check_suggestion_5'+
              ' ='+quotedstr(frm_check.RichEdit1.Text)+
              ', circle=circle+1 '+
              ' from data0696 where rkey='+quotedstr(inttostr(rkey0696));
            dm.ADOTMP1.ExecSQL;
            dm.ADOTMP1.SQL.Text:='';
            dm.ADO0696.Active:=true;
            if not dm.ADO0696.IsEmpty then dm.ADO0697.Active:=true;
            dm.ADO0696.Sort:=paixu2;
            dm.ADO0696.Locate('���',rkey0696,[]);
          end
        else
          begin
            dm.ADOTMP1.Close;
            showmessage('���״̬�Ѿ������ı�');
            dm.ADO0697.Active:=false;
            dm.ADO0696.Active:=false;
            dm.ADO0696.Active:=true;
            if not dm.ADO0696.IsEmpty then dm.ADO0697.Active:=true;
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
        rkey0696:=demo.rkey696;
        dm.ADOTMP1.SQL.Clear;
        dm.ADOTMP1.SQL.Text:='select [check_status] from data0696 where rkey='+
            quotedstr(inttostr(rkey0696));
        dm.ADOTMP1.Open;
          if (dm.ADOTMP1.FieldByName('check_status').AsInteger = demo.rkey696_status) then
            begin
              dm.ADOTMP1.Close;
              dm.ADO0697.Active:=false;
              dm.ADO0696.Active:=false;
              dm.ADOTMP1.SQL.Text:='update  data0696 '+
               'set check_status=check_status+1'+
               ', check_person_5='+user_ptr+
               ', check_date_5=getdate()'+
                  //', check_suggestion_5=NULL'+
               ' from data0696 where rkey='+quotedstr(inttostr(rkey0696));
              dm.ADOTMP1.ExecSQL;
              dm.ADOTMP1.SQL.Text:='';
              dm.ADO0696.Active:=true;
              if not dm.ADO0696.IsEmpty then dm.ADO0697.Active:=true;
              dm.ADO0696.Sort:=paixu2;
              dm.ADO0696.Locate('���',rkey0696,[]);
            end
            else
              begin
                dm.ADOTMP1.Close;
                showmessage('���״̬�Ѿ������ı�');
                dm.ADO0697.Active:=false;
                dm.ADO0696.Active:=false;
                dm.ADO0696.Active:=true;
                if not dm.ADO0696.IsEmpty then dm.ADO0697.Active:=true;
                exit;
              end;
end;

procedure Tfrm_main.N5Click(Sender: TObject);
begin
        try
        frm_check:=Tfrm_check.Create(nil);
        frm_check.Caption := '����᰸';
        frm_check.Label2.Caption:=dm.ADO0696.FieldValues['��ͬ���'];
        frm_check.Label6.Caption:=dm.ADO0696.FieldValues['��ͬ����'];
        frm_check.Label8.Caption:=dm.ADO0696.FieldValues['�׷����ͻ�������'];
        frm_check.Label4.Caption:=dm.ADO0696.FieldValues['״̬'];
        dm.ADOTMP1.SQL.Clear;
        dm.ADOTMP1.SQL.Text := ' select check_suggestion_5'+
          ' as shyj from data0696 where rkey= '+inttostr(demo.rkey696);
        dm.ADOTMP1.Open;
        frm_check.RichEdit1.Text:=dm.ADOTMP1.FieldValues['shyj'];
        dm.ADOTMP1.Close;
        dm.ADOTMP1.SQL.Clear;
        if frm_check.ShowModal=mrok then
        begin
          rkey0696:=demo.rkey696;
          dm.ADOTMP1.SQL.Clear;
          dm.ADOTMP1.SQL.Text:='select [check_status] from data0696 where rkey='+
            quotedstr(inttostr(rkey0696));
          dm.ADOTMP1.Open;
          if (dm.ADOTMP1.FieldByName('check_status').AsInteger = demo.rkey696_status) then
            begin
              dm.ADOTMP1.Close;
              dm.ADO0697.Active:=false;
              dm.ADO0696.Active:=false;
              dm.ADOTMP1.SQL.Text:='update  data0696 '+
                  ' set check_status=63'+
                  ', check_person_5 ='+user_ptr+
                  ', check_date_5=getdate()'+
                  ', check_suggestion_5'+
                  '='+quotedstr(frm_check.RichEdit1.Text)+
                  ' from data0696 where rkey='+quotedstr(inttostr(rkey0696));
              dm.ADOTMP1.ExecSQL;
              dm.ADOTMP1.SQL.Text:='';
              dm.ADO0696.Active:=true;
              if not dm.ADO0696.IsEmpty then dm.ADO0697.Active:=true;
              dm.ADO0696.Sort:=paixu2;
              dm.ADO0696.Locate('���',rkey0696,[]);
            end
            else
              begin
                dm.ADOTMP1.Close;
                showmessage('���״̬�Ѿ������ı�');
                dm.ADO0697.Active:=false;
                dm.ADO0696.Active:=false;
                dm.ADO0696.Active:=true;
                if not dm.ADO0696.IsEmpty then dm.ADO0697.Active:=true;
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
    dm.ADOTMP1.SQL.Clear;
    dm.ADOTMP1.SQL.Text :='select  top 1 * from data0034 where ttype=4 and  dept_name like '+#39+'%��%'+#39;
    //     showmessage(dm.ADOTMP1.SQL.Text);
    dm.ADOTMP1.ExecSQL;
    dm.ADOTMP1.Open;
    if not dm.ADOTMP1.Eof then
      begin
        if demo.people_department <> dm.ADOTMP1.FieldByName('rkey').AsInteger  then
        begin
          showmessage('ֻ�з�ز���Ա�ſ��Զ����������');
          exit;
        end;
      end;
    dm.ADOTMP1.Close;

      if (vprev <>'4') then  Exit;
      
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

   //Self.WindowState := wsMaximized;
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
var rkey_0693 :Integer;
    data0696status : integer;
begin
  rkey_0693 :=dm.ADO0693rkey.AsInteger;
  rkey0696:=demo.rkey696;
  paixu2:=dm.ADO0696.Sort;
  if (Tmenuitem(Sender).Tag in [1]) then
    begin
      try
        frm_check:=Tfrm_check.Create(nil);
        frm_check.Caption := inttostr(dm.ADO0693d34_index.Value)+'��,��˲���:'+dm.ADO0693dept_name.AsString;
        frm_check.Label2.Caption:=dm.ADO0696.FieldValues['��ͬ���'];
        frm_check.Label6.Caption:=dm.ADO0696.FieldValues['��ͬ����'];
        frm_check.Label8.Caption:=dm.ADO0696.FieldValues['�׷����ͻ�������'];
        frm_check.Label4.Caption:='�� '+inttostr(dm.ADO0693d34_index.AsInteger)+' ��';
        if dm.ADO0693check_suggestion.AsString =''  then
        frm_check.RichEdit1.Text:=inttostr(dm.ADO0693d34_index.Value)+'��:'+#13
        else
         frm_check.RichEdit1.Text:= dm.ADO0693check_suggestion.AsString;


        if frm_check.ShowModal=mrok then
        begin
          dm.ADOTMP1.SQL.Clear;
          dm.ADOTMP1.SQL.Text:='select [check_status] from data0693 where rkey='+quotedstr(inttostr(rkey_0693));
          dm.ADOTMP1.Open;
          if (dm.ADOTMP1.FieldByName('check_status').AsInteger = dm.ADO0693check_status.AsInteger) then
            begin
              dm.ADOTMP1.Close;
              dm.ADO0693.Active:= False;
              dm.ADOTMP1.SQL.Text:='update  data0693 '+
                  ' set check_status=1 '+
                  ', check_person='+user_ptr+
                  ', check_time=getdate()'+
                  ', check_suggestion='+quotedstr(frm_check.RichEdit1.Text)+
                  ' from data0693 where rkey='+inttostr(rkey_0693);
              dm.ADOTMP1.ExecSQL;

              dm.ADOTMP1.SQL.Text:='';
              //��Ҫ�ж��Ƿ�������
              dm.ADOTMP1.Close;
              dm.ADOTMP1.SQL.Clear;
              dm.ADOTMP1.SQL.Text:='select * from  data0693 '+
                  ' where check_status=0 and d696_ptr='+inttostr(rkey0696);
              dm.ADOTMP1.ExecSQL;
              dm.ADOTMP1.Open;
              if dm.ADOTMP1.Eof then
              begin
                dm.ADO0696.Active := false;
                dm.ADOTMP2.SQL.Text :='update data0696 set check_status=2 from data0696 where rkey='+inttostr(rkey0696);
                dm.ADOTMP2.ExecSQL;
                dm.ADO0696.Active := True;
                dm.ADO0696.Sort:=paixu2;
                dm.ADO0696.Locate('rkey',rkey0696,[]); 
              end;

              dm.ADO0693.Active := true;
              dm.ADO0693.Locate('rkey',rkey_0693,[]);
              DBGridEh1.SetFocus;
            end
            else
              begin
                dm.ADOTMP1.Close;
                showmessage('���״̬�Ѿ������ı�');
                dm.ADO0693.Active:= False;
                dm.ADO0693.Locate('rkey',rkey_0693,[]);
                dm.ADO0693.Active := true;
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
    dm.ADOTMP1.SQL.Text:='select [check_status] from data0696 where rkey='+quotedstr(inttostr(rkey0696));
    dm.ADOTMP1.Open;
    data0696status := dm.ADOTMP1.FieldByName('check_status').AsInteger;
    if ((dm.ADOTMP1.FieldByName('check_status').AsInteger =2) and (dm.ADO0693d34_ptr.AsInteger <>demo.last_check_dept) ) then
     begin
        ShowMessage('��˹����Ѿ�ȫ�����,�����Ĳ��Ų���ȡ�����,�����ͬ��˼�ܲ�����Ա��ϵ');
        exit;
     end;

    dm.ADOTMP1.SQL.Clear;
    dm.ADOTMP1.SQL.Text:='select [check_status] from data0693 where rkey='+quotedstr(inttostr(rkey_0693));
    dm.ADOTMP1.Open;

      if (dm.ADOTMP1.FieldByName('check_status').AsInteger = dm.ADO0693check_status.AsInteger) then
      begin
          dm.ADOTMP1.Close;
          dm.ADO0693.Active:= False;
          dm.ADOTMP1.SQL.Text:='update  data0693 '+
              ' set check_status=0 '+
              ', check_time=getdate()'+
              ' from data0693 where rkey='+inttostr(rkey_0693);
          dm.ADOTMP1.ExecSQL;
      dm.ADOTMP1.SQL.Text:='';

      if data0696status=2 then
      begin
          //ShowMessage('');
          dm.ADO0696.Active := false;
          dm.ADOTMP1.SQL.Clear;
          dm.ADOTMP1.SQL.Text:=' update data0696 '+
                  ' set check_status=1'+
                  ' from data0696 where rkey='+inttostr(rkey0696);
           dm.ADOTMP1.ExecSQL;
           dm.ADO0696.Active := True;
           dm.ADO0696.Sort:=paixu2;
           dm.ADO0696.Locate('rkey',rkey0696,[]);
      end;

      dm.ADO0693.Active := true;
      dm.ADO0693.Locate('rkey',rkey_0693,[]);
      DBGridEh1.SetFocus;

      end
      else
      begin
        dm.ADOTMP1.Close;
        showmessage('���״̬�Ѿ������ı�');
        dm.ADO0693.Active:= False;
        dm.ADO0693.Locate('rkey',rkey_0693,[]);
        dm.ADO0693.Active := true;
        exit;
      end;
    end;

  if (Tmenuitem(Sender).Tag in [3]) then
  begin
   if MessageBox(Handle,'ȷ���˻���������?'+#13+#13+'�˲����Ὣ������ͨ������˱�ʶΪδ���'+#13+#13+'���Ҵ˲���������','��ʾ',MB_YESNO+MB_ICONWARNING+MB_DEFBUTTON2)=IDNO	then exit;
         dm.ADO0696.Active := false;
        dm.ADO0693.Active := false;
              dm.ADOTMP1.Close;

              dm.ADOTMP1.SQL.Text:='update  data0693 '+
                  ' set check_status=0 '+
                  ' from data0693 where d696_ptr='+inttostr(rkey0696)+
                  ' update  data0693 '+
                  ' set check_person='+user_ptr+
                  ', check_time=getdate()'+
                  ' from data0693 where rkey='+inttostr(demo.last_d0693_rkey)+
                  ' update data0696 '+
                  ' set check_status=0,circle=circle+1 '+
                  ' from data0696 where rkey='+inttostr(rkey0696);
              dm.ADOTMP1.ExecSQL;
        dm.ADOTMP1.SQL.Text:='';
         {if not dm.ADO0696.IsEmpty then dm.ADO0697.Active:=true;

              dm.ADO0696.Locate('rkey',rkey0696,[]); }
        dm.ADO0696.Active := True;
        dm.ADO0696.Sort:=paixu2;
        dm.ADO0696.Locate('rkey',rkey0696,[]);

        dm.ADO0693.Active := true;
        dm.ADO0693.Locate('rkey',rkey_0693,[]);
        DBGridEh1.SetFocus;
  end;




end;

procedure Tfrm_main.DBGridEh1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
begin
  if dm.DS693.DataSet.FieldByName('check_status').AsInteger = 1
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
  {  last_check_dept :Integer;
  last_check_deptindex :Integer;
  last_d0693_rkey :Integer;
  last_checktime :TDateTime;
  last_checkperson : Integer;}
  if not  dm.ADO0696.IsEmpty then
  begin
    dm.ADOTMP1.SQL.Clear;
    dm.ADOTMP1.SQL.Text := 'select top 1 rkey,d696_ptr,d34_index,d34_ptr,check_person,check_time,check_suggestion,check_status  from data0693 where d696_ptr='+inttostr(demo.rkey696)+' order by d34_index desc ';
    dm.ADOTMP1.Open;
     if not  dm.ADOTMP1.IsEmpty   then
     begin
       max_index := dm.ADOTMP1.FieldByName('d34_index').AsInteger;
       demo.last_check_dept:= dm.ADOTMP1.FieldByName('d34_ptr').AsInteger;
       demo.last_check_deptindex := dm.ADOTMP1.FieldByName('d34_index').AsInteger;
       demo.last_d0693_rkey := dm.ADOTMP1.FieldByName('rkey').AsInteger;
     end;
     dm.ADOTMP1.Close;
     dm.ADOTMP1.SQL.Clear;

    if not dm.ADO0693.IsEmpty then begin
          //���״̬Ϊ0 ,���ŶԵ���,��4Ȩ��,
       if (dm.ADO0696check_status.AsInteger=1) and
          (dm.ADO0693check_status.AsInteger=0) and
          (dm.ADO0693d34_ptr.AsInteger =  demo.people_department) and
          ( (vprev ='4'))
          then N6.Enabled := true;

        //���״̬Ϊ1 ,���ŶԵ���,��4Ȩ��,
       if (dm.ADO0693check_status.AsInteger=1) and
          (dm.ADO0693d34_ptr.AsInteger =  demo.people_department) and
          ((vprev ='4')) and
          (dm.ADO0693check_person.AsString = user_ptr)
          then N8.Enabled := true;

          //ShowMessage(IntToStr(dm.ADO0693check_status.AsInteger));
           //ShowMessage(IntToStr(dm.ADO0693d34_ptr.AsInteger));
           //ShowMessage(IntToStr(demo.people_department));
            // ShowMessage(IntToStr(dm.ADO0693d34_ptr.AsInteger));
         //���״̬Ϊ0 ,���ŶԵ���,4Ȩ��,���һ������,��������
       if (dm.ADO0696check_status.AsInteger=1) and
          (dm.ADO0693check_status.AsInteger=0) and
          (dm.ADO0693d34_ptr.AsInteger =  demo.people_department) and
          (vprev ='4') and
          (dm.ADO0693d34_index.AsInteger = max_index)
          then N14.Enabled := true;
    end;


  end;



end;

procedure Tfrm_main.PopupMenu1Popup(Sender: TObject);
var cancle_flag :Integer;

begin
  cancle_flag := 0;
  N1.Enabled := False;//�½�
  N2.Enabled := False;// ɾ��
  N3.Enabled := False; //�ύȷ��
  N4.Enabled := False;// ȡ���ύȷ��
  N16.Enabled := False;//��������
  N18.Enabled := False; //ȡ����������
  if not dm.ADO0696.Eof  then
  begin
    dm.ADOTMP1.Close;
    dm.ADOTMP1.SQL.Clear;
    dm.ADOTMP1.SQL.Text :='select * from data0693 where check_status=1 and d696_ptr='+inttostr(demo.rkey696);
    dm.ADOTMP1.ExecSQL;
    dm.ADOTMP1.Open;
    if not dm.ADOTMP1.Eof then cancle_flag := 0 else  cancle_flag := 1;
  end;
  //�½�Ȩ��
  if  ((vprev ='4')or (vprev ='2')) then    N1.Enabled := true;

  //�ύȨ��
  //��״̬�� 0,������ǲ�����,�����ύ,����ɾ��
  if ((dm.ADO0696check_status.AsInteger = 0) and (dm.ADO0696submit_person.AsInteger=demo.op_people))
  then N2.Enabled := True;

    if ((dm.ADO0696check_status.AsInteger = 0) and (dm.ADO0696submit_person.AsInteger=demo.op_people))
  then N3.Enabled := True;

   if    (  (cancle_flag=1)and (dm.ADO0696check_status.AsInteger = 5) and (dm.ADO0696submit_person.AsInteger=demo.op_people) )
   then N4.Enabled := true;
//2017-11-20tang 2017-12-14tang �����������˱�����Ȩ��4�Ҳ���������
    if ((vprev ='4') and (dm.ADO0696check_status.AsInteger = 5) and (dm.ADO0696submit_person.AsInteger<>demo.op_people))
  then N16.Enabled := True;

   if    ((vprev ='4') and (cancle_flag=1)and (dm.ADO0696check_status.AsInteger = 1)) // and (dm.ADO0696Audit_Prt.AsInteger=demo.op_people) 
   then N18.Enabled := true;

end;

procedure Tfrm_main.Action1Execute(Sender: TObject);
begin
  BtFlds.Visible := True;
end;

procedure Tfrm_main.Grd1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if (ssAlt in Shift)  and  (Key=86) then
   showmessage(DM.ADO0696.SQL.Text);
end;

procedure Tfrm_main.Button1Click(Sender: TObject);
begin
  Form1:=TForm1.Create(application);
  Form1.ShowModal;
  Form1.Free;
end;

end.





