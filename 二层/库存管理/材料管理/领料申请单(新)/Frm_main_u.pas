unit Frm_main_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, Grids, DBGridEh, StdCtrls, Buttons, Menus, DB,ComObj, Excel97,
  ADODB, ppDB, ppBands, ppCtrls, ppPrnabl, ppClass, ppCache, ppEndUsr,
  ppProd, ppReport, ppComm, ppRelatv, ppDBPipe, ppModule, raCodMod,
  ppStrtch, ppMemo, ppSubRpt, daDataModule;

type
  TFrm_main = class(TForm)
    Panel1: TPanel;
    Label1: TLabel;
    BtClose: TBitBtn;
    BtBrush: TBitBtn;
    BtQry: TBitBtn;
    Edit1: TEdit;
    Panel3: TPanel;
    Grd1: TDBGridEh;
    Splitter1: TSplitter;
    Grd2: TDBGridEh;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N12: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    BitBtn6: TBitBtn;
    N7: TMenuItem;
    N8: TMenuItem;
    N10: TMenuItem;
    N9: TMenuItem;
    N11: TMenuItem;
    BitBtn1: TBitBtn;
    N13: TMenuItem;
    mniN14: TMenuItem;
    mniN15: TMenuItem;
    N14: TMenuItem;
    prprtTest: TppReport;
    procedure FormCreate(Sender: TObject);
    procedure BtCloseClick(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure BtBrushClick(Sender: TObject);
    procedure Grd1TitleClick(Column: TColumnEh);
    procedure Grd1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure BtQryClick(Sender: TObject);
    procedure Grd1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure N1Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Grd2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure N11Click(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure N13Click(Sender: TObject);
    procedure Grd2DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure N14Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
  private
    PreColumn: TColumnEh;
    field_name:string;
    sSql :string;
    result136,result137:Integer;
    procedure init;
   procedure check_exist;
   procedure check_final(control_ptr:string;quan_Bom:Single; stan_consume:Single;rkey468:string);
   procedure FillKZXM;
  public

  end;

var
  Frm_main: TFrm_main;

implementation
 uses common,DM_u,Frm_QrySet_u,Frm_detail_u,Frm_authInfo_u,math, URep,UVMIForm;
{$R *.dfm}

procedure TFrm_main.FormCreate(Sender: TObject);
begin

  rkey73:= '2207';
  user_ptr := '1630';
  vprev := '4';

  if not App_Init_2(dm.ADOCon ) then
  begin
    ShowMsg('������ʧ������ϵ����Ա',1);
    application.Terminate;
    exit;
  end;

  Caption := application.Title;

  DateSeparator := '-';
  ShortDateFormat := 'yyyy-mm-dd';
  init;
  
end;

procedure TFrm_main.BtCloseClick(Sender: TObject);
begin
  Frm_QrySet.Free;
  close;
end;

procedure TFrm_main.Edit1Change(Sender: TObject);
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
    end else
      Grd1.DataSource.DataSet.Filter:='';
  end;
end;

procedure TFrm_main.BtBrushClick(Sender: TObject);
var
  i:integer;
begin
  if DM.ADO268.IsEmpty then exit;
  i := DM.ADO268rkey.AsInteger ;
  DM.ADO268.Close;
  DM.ADO268.Open;
  DM.ADO268.Locate('rkey',i,[]);
end;

procedure TFrm_main.Grd1TitleClick(Column: TColumnEh);
begin
  if Grd1.DataSource.DataSet.FieldByName(Column.FieldName).FieldKind = fkCalculated then  exit ;
  if (column.Title.SortMarker =smDownEh) or (column.Title.SortMarker =smNoneEh) then
  begin
    column.Title.SortMarker:=smUpEh;
    DM.ADO268.Sort:=Column.FieldName;
  end
  else
  begin
    column.Title.SortMarker:=smDownEh;
    DM.ADO268.Sort:=Column.FieldName+' DESC';
  end;
  DM.ADO268AfterScroll(DM.ADO268);
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
  end else
    edit1.SetFocus;
end;

procedure TFrm_main.init;
begin
  field_name := Grd1.Columns[0].FieldName;
  PreColumn := Grd1.Columns[0];
  Grd1.Columns[0].Title.Color := clred ;

  with dm.tmp do
  begin
    close;
    sql.text:='SELECT Data0034.DEPT_CODE,Data0034.dept_name,Data0005.RKEY rkey05,Data0034.rkey,data0034.ttype,data0034.is_cost_dept '+
              'FROM Data0005 INNER JOIN '+
              'Data0034 ON Data0005.EMPLOYEE_ID = Data0034.RKEY INNER JOIN '+
              'Data0073 ON Data0005.RKEY = Data0073.EMPLOYEE_PTR '+
              'where data0073.rkey= '+ rkey73;
    open;
    if (fieldbyname('ttype').AsInteger=4) or (fieldbyname('ttype').AsInteger=5) or (fieldbyname('is_cost_dept').AsInteger=1) then
    begin
      dept_rkey := fieldvalues['rkey'];
      dept_code := fieldvalues['dept_code'];        //��Ա����
      dept_name := fieldvalues['dept_name'];
    end;                                                          
    rkey05 := fieldvalues['rkey05'];                //��Աid
  end;

  sSql:=DM.ADO268.SQL.Text;
  DM.ADO268.SQL.Text:=DM.ADO268.SQL.Text+' where data0268.ttype in (0,1) and dbo.DATA0268.dept_ptr = ' + IntToStr(dept_rkey) + ' and data0268.date>getdate()-1 order by number';
  DM.ADO268.Open;
  
end;

procedure TFrm_main.Grd1DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
begin
  if dm.ADO268status.Value = 3 then
     Grd1.Canvas.Font.Color := clred
  else if dm.ADO268status.Value = 2 then
     Grd1.Canvas.Font.Color := clTeal //cllime
  else if dm.ADO268status.Value = 1 then
     Grd1.Canvas.Font.Color := clfuchsia
  else if dm.ADO268status.Value = 4 then
     Grd1.Canvas.Font.Color := clGreen;
  Grd1.DefaultDrawColumnCell(Rect, DataCol, Column, State);
end;


procedure TFrm_main.PopupMenu1Popup(Sender: TObject);
begin
  if DM.ADO268.IsEmpty then
  begin
    n2.Enabled:=false;    //�༭
    n3.Enabled:=false;    //���
    n4.Enabled:=false;    //�ύ����
    n5.Enabled:=false;    //ɾ��
    n6.Enabled:=false;    //prt
    n8.Enabled:=false;    //aut
    n10.Enabled:=false;    //copy
    n11.Enabled:=false;
    n9.Enabled:=false;    //cancel
     n13.Enabled:=false; 
  end
  else
  begin
    n2.Enabled:=(dm.ADO268status.AsInteger in [0,3])  and (Dm.ADO268EMPL_PTR.AsString=rkey05) ;
    n3.Enabled := true;
   //�ύ����
    n4.Enabled := (dm.ADO268status.AsInteger=0);   //and (((dm.ADO268ismsgsended.AsInteger =0) and (dm.ADO268allow_submit.AsInteger =1 ) )  or  (dm.ADO268allow_submit.AsInteger in [0,2])  )    ;    //�ύ����        //and (dm.ADO268allow_submit.AsInteger in [0,1,2])
    n5.Enabled:=(dm.ADO268status.AsInteger in [0,3]) and (Dm.ADO268EMPL_PTR.AsString=rkey05);
    //��ӡ
    n6.Enabled := (dm.ADO268status.AsInteger in [2,4]) and ((vprev='3') or not DM.ADO268Prted.AsBoolean);
    n14.Enabled := (dm.ADO268status.AsInteger in [2,4]) and ((vprev='4') or  DM.ADO268Prted.AsBoolean);   //��ӡ
    n8.Enabled:=true;                            //������Աֻ�ܴ�ӡһ��,�ֿ���Ա�ɶ�δ�ӡ
    n10.Enabled:=true;
   n9.Enabled:=dm.ADO268status.AsInteger in [1];                   //ȡ������
   //�����ύ
   n13.Enabled :=(dm.ADO268allow_submit.AsInteger in [1,3]) and (dm.ADO268status.AsInteger=2);
  end;
end;

procedure TFrm_main.BtQryClick(Sender: TObject);
var i:integer;
    Sqlstr:string;
begin
  if Frm_QrySet=nil then  Frm_QrySet:=TFrm_QrySet.Create(Application);
  if Frm_QrySet.ShowModal=mrok then
  begin
    for i:=1 to Frm_QrySet.sgrid1.RowCount-2 do
      if Frm_QrySet.sgrid1.Cells[2,i]<> '' then Sqlstr:=sqlstr+Frm_QrySet.sgrid1.Cells[2,i];
    DM.ADO268.SQL.Text:=sSql+' where data0268.ttype in (0,1) and  data0268.date>='''+formatdatetime('YYYY/MM/DD',Frm_QrySet.DateTimePicker1.Date)+
                           ''' and data0268.date-1<='''+formatdatetime('YYYY/MM/DD',Frm_QrySet.DateTimePicker2.Date)+''' '+Sqlstr+
                           ' order by data0268.number';
    DM.ADO268.Close;
    DM.ADO268.Open;
  end;
end;



procedure TFrm_main.Grd1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (ssAlt in Shift)  and  (Key=86) then
  showmessage(DM.ADO268.SQL.Text);
end;

procedure TFrm_main.N1Click(Sender: TObject);
var
  iRank: integer;
  showmessage1,messages: string;
  Ltime: string;
  LSql,ssql: string;
  LProductAre, LUse, LTmp: Single;
  Lstan_consume: Single;
  sl:Double;
begin
  if (Tmenuitem(Sender).Tag in [0, 1, 3, 4, 10, 11]) and
    ((strtoint(vprev) = 1) or (strtoint(vprev) = 3)) then
  begin
    messagedlg('�Բ���!��û�иó���Ŀ�дȨ��', mtinformation, [mbok], 0);
    abort;
  end;

  case Tmenuitem(Sender).Tag of
    0, // �½�
    1, // �༭
    2, // ���

    10: // ����
      begin
        Frm_detail := TFrm_detail.Create(nil);


        dm.ADO468.First;
        if Tmenuitem(Sender).Tag <> 0 then
        begin
          while not dm.ADO468.Eof do
          begin
            FillKZXM;
            dm.ADO468.Next;
          end;
        end;
        with Frm_detail do
          try
            Ftag := Tmenuitem(Sender).Tag;
            FGrd := Grd2;
            initd;

            if Tmenuitem(Sender).Tag = 0 then
            begin
              DM.qrytmp.Close;
              dm.qrytmp.SQL.Clear;
              DM.qrytmp.SQL.Add('select abbr_name from data0073 inner join data0015 on warehouse_ptr = data0015.rkey where data0073.rkey = ' + rkey73);
              dm.qrytmp.Open;
              if not dm.qrytmp.IsEmpty then
              begin
                if Frm_detail.CBFac.Items.IndexOf(dm.qrytmp.fieldbyname('abbr_name').AsString) <> -1 then
                begin
                  Frm_detail.CBFac.ItemIndex := Frm_detail.CBFac.Items.IndexOf(dm.qrytmp.fieldbyname('abbr_name').AsString);
                  Frm_detail.CBFacChange(Frm_detail.CBFac);
                end;
              end;
            end;

            if showmodal = mrok then
            begin
              dm.ADO268.Close;
              dm.ADO268.Open;
              dm.ADO268.Locate('rkey', Frkey268, []);
            end;
          finally
            free;
            dm.ADO268_1.Close;
            dm.ADO268_1.Close;
          end;
      end;
    3: // �ύ����
      begin
        // ��ȷ��
       { if dm.ADO268allow_submit.Value = 2 then
        begin
          try
            dm.ADOCon.BeginTrans;
            dm.tmp.Close;
            dm.tmp.SQL.Text :=
              'update data0268 set status=1,auth_emplptr=null,auth_date=null where rkey='
              + dm.ADO268rkey.AsString + ' and status=0';
             if dm.tmp.ExecSQL = 0 then
            begin
              dm.ADOCon.RollbackTrans;
              showmessage('���뵥״̬�����ı��δ�ܳɹ��ύ!');
              BtBrushClick(nil);
              exit;
            end;

            dm.tmp.Close;
            dm.tmp.SQL.Text := 'delete from data0368  where apply_ptr=' +
              dm.ADO268rkey.AsString;
            dm.tmp.ExecSQL;

            dm.tmp1.Close;
            dm.tmp1.SQL.Text := 'select * from data0275 where AUTH_GROUP_PTR=' +
              dm.ADO268AUTH_ptr.AsString + ' order by rkey';
            dm.tmp1.Open;
            iRank := 1;
            while not dm.tmp1.Eof do
            begin
              dm.tmp.Close;
              if iRank = 1 then
                dm.tmp.SQL.Text :=
                  'insert into data0368(apply_ptr,user_ptr,ranking,auth_flag) '
                  + 'values(' + dm.ADO268rkey.AsString + ',' +
                  dm.tmp1.fieldbyname('user_ptr').AsString + ',' +
                  inttostr(iRank) + ',''Y'')'
              else
                dm.tmp.SQL.Text :=
                  'insert into data0368(apply_ptr,user_ptr,ranking,auth_flag) '
                  + 'values(' + dm.ADO268rkey.AsString + ',' +
                  dm.tmp1.fieldbyname('user_ptr').AsString + ',' +
                  inttostr(iRank) + ',''N'')';
              dm.tmp.ExecSQL;
              inc(iRank);
              dm.tmp1.Next;
            end;
            dm.ADOCon.CommitTrans;
            BtBrushClick(nil);
          except
            dm.ADOCon.RollbackTrans;
            showmessage('�����ύ���ִ���,�������Ա��ϵ!!!');
          end;
        end
        else if  dm.ADO268allow_submit.Value = 1 then    // ��ȷ�� lisa1024
        begin
         try
          // if not  DM.ADO268.FieldByName('allow_submit').AsInteger in [1,3] then 

           if  DM.ADO268.FieldByName('IsMsgSended').AsInteger=1  then    //�ѷ���ȷ����Ϣ�ȴ�ȷ��
           begin
           ShowMessage('�����ϵ������ϳ����Ѹ������Ա���Ͷ���,��ȴ�ȷ��!');
           Exit;
           end;

         if MessageDlg('�������ѳ��첻���ύ����Ҫ���Ͷ�����ʾ�������Աȥȷ����',mtInformation,[mbyes,mbno],0)=mrno then
           exit;

           ssql:='select distinct  d268.number, d468.remark,isnull(d136.control_name,'''') as control_name '+
          ' from data0268 d268                                                  '+
          ' inner join data0468  d468  on d268.rkey=d468.flow_no                  '+
          ' left join data0136 d136  on d468.control_ptr = d136.rkey                '+
          ' where left(d468.remark,1)=''X'' and  d268.number='''+ DM.ADO268.FieldByName('number').asstring+''' ';

          DM.OpenQry(DM.qry_temp,ssql);
          //Msglst:=TStringList.Create(nil);
          messages:='�������쵥�� '+DM.ADO268.FieldByName('number').asstring+ ' ������������г���: '+#13;
           if not DM.qry_temp.IsEmpty then
           begin
           DM.qry_temp.First;
           while not DM.qry_temp.eof do
           begin
           messages:=messages+'������ĿΪ '+DM.qry_temp.FieldByName('control_name').asstring +' ������:'+DM.qry_temp.FieldByName('remark').asstring + #13  ;
            DM.qry_temp.next;
           end;
           end;

           if not DM.ADO14_1.active then  DM.ADO14_1.open;

              DM.ADO14_1.append;
              DM.ado14_1.FieldByName('message').AsString:= messages;
              DM.ado14_1.FieldByName('senddate').Value :=now;
              DM.ado14_1.FieldByName('whosend').Value:= rkey73;
              DM.ado14_1.Post;
        
           // DM.ADOCon.BeginTrans;

            DM.ado14_1.UpdateBatch(arAll);
           // DM.ADOCon.CommitTrans;

         // DM.ADOCon.BeginTrans;
          ssql:= 'select isnull(d139.csi_ptr,0)csi_ptr ,d05.PHONE'+     //, d73.USER_FULL_NAME
          '  from data0468 d468   '+
           ' left join data0139  d139 on d468.control_ptr =d139.rkey136 '+
             '  INNER JOIN   dbo.Data0073  d73 ON d139.csi_ptr =d73.RKEY  '+#13+
          '  INNER JOIN  dbo.Data0005  d05 ON d73.EMPLOYEE_PTR = d05.RKEY    '+#13+
          ' AND  d73.EMPLOYEE_PTR = d05.RKEY '+#13+
            ' where d468.flow_no=' +DM.ADO268.FieldByName('rkey').asstring;
           DM.OpenQry(DM.qry_temp,ssql);

           ssql:='select user_full_name from data0073 where rkey = ' +rkey73;
           DM.OpenQry(DM.qry_temp3,ssql);

           if not DM.qry_temp.IsEmpty then
           begin
             DM.qry_temp.first;
             while not  DM.qry_temp.eof do
             begin
               if not DM.ado314_1.Active then DM.ado314_1.Open;

               // ����314��
              DM.ado314_1.append;
              DM.ado314_1.FieldByName('emp_ptr').AsString:= DM.qry_temp.fieldbyname('csi_ptr').asstring;
              DM.ado314_1.FieldByName('d14_ptr').AsInteger :=  DM.ado14_1.fieldbyname('rkey').AsInteger;
              DM.ado314_1.FieldByName('hread').Value:= 'F';
              DM.ado314_1.FieldByName('deleted').Value:= 'N';
              DM.ado314_1.FieldByName('if_note').Value:= 1;
              DM.ado314_1.post;

              //

               ssql:='select SUPLFEDSHIP,SUPLFEDMAT,SUPLFEDMISC from data0192';
               DM.OpenQry(DM.qry_temp2,ssql);

              if Trim(dm.qry_temp2.FieldByName('SUPLFEDSHIP').AsString) <> '' then
              begin

                          ssql:='insert ['+DM.qry_temp2.FieldValues['SUPLFEDSHIP']+'].'+DM.qry_temp2.FieldValues['SUPLFEDMAT']+'.dbo.'+DM.qry_temp2.FieldValues['SUPLFEDMISC']+
                                    '(phonenumber,messagecontent,sendername,companyid) '+
                                    'values ('''+DM.qry_temp.Fieldbyname('phone').asstring+''','''+messages+''','''+DM.qry_temp3.Fieldbyname('USER_FULL_NAME').asstring+''',9)';

                         dm.execsql(dm.qrytmp,ssql);
              end;

              DM.qry_temp.next;
             end;

              DM.ado314_1.UpdateBatch(arAll);
           end;

             ssql:='update data0268 set IsMsgSended =1  where number='''+dm.ADO268.fieldbyname('number').asstring+''' ' ;
            dm.execsql(dm.qry_temp,ssql);
           // DM.ADOCon.CommitTrans;
             BtBrushClick(nil);
            except  on e:exception do
            begin
            ShowMessage('����'+e.message+ssql);
            exit;
            end;
         end;
        end
        else // ��ȷ��
        begin
          begin
            try
              dm.ADOCon.BeginTrans;
              dm.tmp.Close;
              dm.tmp.SQL.Text :=
                'update data0268 set status=1,auth_emplptr=null,auth_date=null where rkey='
                + dm.ADO268rkey.AsString + ' and status=0';
              if dm.tmp.ExecSQL = 0 then
              begin
                dm.ADOCon.RollbackTrans;
                showmessage('���뵥״̬�����ı��δ�ܳɹ��ύ!');
                BtBrushClick(nil);
                exit;
              end;

              dm.tmp.Close;
              dm.tmp.SQL.Text := 'delete from data0368  where apply_ptr=' +
                dm.ADO268rkey.AsString;
              dm.tmp.ExecSQL;

              dm.tmp1.Close;
              dm.tmp1.SQL.Text :=
                'select * from data0275 where AUTH_GROUP_PTR=' +
                dm.ADO268AUTH_ptr.AsString + ' order by rkey';
              dm.tmp1.Open;
              iRank := 1;
              while not dm.tmp1.Eof do
              begin
                dm.tmp.Close;
                if iRank = 1 then
                  dm.tmp.SQL.Text :=
                    'insert into data0368(apply_ptr,user_ptr,ranking,auth_flag) '
                    + 'values(' + dm.ADO268rkey.AsString + ',' +
                    dm.tmp1.fieldbyname('user_ptr').AsString + ',' +
                    inttostr(iRank) + ',''Y'')'
                else
                  dm.tmp.SQL.Text :=
                    'insert into data0368(apply_ptr,user_ptr,ranking,auth_flag) '
                    + 'values(' + dm.ADO268rkey.AsString + ',' +
                    dm.tmp1.fieldbyname('user_ptr').AsString + ',' +
                    inttostr(iRank) + ',''N'')';
                dm.tmp.ExecSQL;
                inc(iRank);
                dm.tmp1.Next;
              end;
              dm.ADOCon.CommitTrans;
              BtBrushClick(nil);
            except
              dm.ADOCon.RollbackTrans;
              showmessage('�����ύ���ִ���,�������Ա��ϵ!!!');
            end;
          end;
        end; }
      end;

    4: //ɾ��
      begin
        if MessageBox(Handle, 'ȷ��ɾ�������뵥��?', '��ʾ', MB_YESNO + MB_ICONWARNING +
          MB_DEFBUTTON2) = IDNO then
          exit;
        dm.ADOCon.BeginTrans;
        try
          dm.tmp.Close;
          dm.tmp.SQL.Text := 'delete from data0468  where flow_no=' +
            dm.ADO268rkey.AsString + ' and quan_issued=0';
          if dm.tmp.ExecSQL <> dm.ADO468.RecordCount then
          begin
            dm.ADOCon.RollbackTrans;
            showmessage('ɾ������ʧ��,����״̬�ѷ����仯...');
          end
          else
          begin
            dm.tmp.SQL.Text := 'delete from data0368  where apply_ptr=' +
              dm.ADO268rkey.AsString;
            dm.tmp.ExecSQL;
            dm.tmp.SQL.Text := 'delete from data0268 where rkey=' +
              dm.ADO268rkey.AsString + ' and status in (0,3)';
            if dm.tmp.ExecSQL = 0 then
            begin
              dm.ADOCon.RollbackTrans;
              showmessage('ɾ������ʧ��,����״̬�ѷ����仯...');
            end;

            //����wzcp0492����������
            if dm.intgrfldADO468wzcp0492_ptr.AsString<>'' then
            begin
             DM.ADO468.First;
              sl:=0;
              while not dm.ADO468.Eof do
              begin
                dm.tmp1.Close;
                dm.tmp1.SQL.Clear;
                DM.tmp1.SQL.Text:='select * from wzcp0492 where rkey='+dm.intgrfldADO468wzcp0492_ptr.AsString;
                dm.tmp1.Open;
                if not dm.tmp1.IsEmpty then
                begin
                  sl:=DM.tmp1.FieldByName('App_QTY').AsFloat;
                  sl:=sl-dm.ADO468QUAN_BOM.AsFloat;
                  dm.tmp2.Close;
                  dm.tmp2.SQL.Clear;
                  DM.tmp2.SQL.Text:='update wzcp0492 set App_QTY='+floattostr(sl)+' where rkey='+dm.intgrfldADO468wzcp0492_ptr.AsString;
                  dm.tmp2.ExecSQL;
                end;
                dm.ADO468.Next;
              end;
            end;
              dm.ADOCon.CommitTrans;
          end;
          BtBrushClick(nil);
        except
          dm.ADOCon.RollbackTrans;
          showmessage('ɾ������ʧ��...');
        end;
      end;
    11: //ȡ���ύ
      begin
        if MessageBox(Handle, 'ȷ��ȡ���ύ�����뵥��?', '��ʾ', MB_YESNO + MB_ICONWARNING +
          MB_DEFBUTTON2) = IDNO then
          exit;
        dm.ADOCon.BeginTrans;
        try
          dm.tmp.Close;
//          dm.tmp.SQL.Text:=  ' update data0268 set status=0,auth_emplptr=null,auth_date=null where rkey = '
//            + dm.ADO268rkey.AsString + ' and status=1 and ismsgsended ';
          dm.tmp.SQL.Text :=
            ' update data0268 set status=0,auth_emplptr=null,auth_date=null where rkey = '
            + dm.ADO268rkey.AsString + ' and status=1 ';
          // not exists(select rkey from data0468 where flow_no='+DM.ADO268rkey.AsString+
          // ' and QUAN_ISSUED>0)';
          if dm.tmp.ExecSQL <> 1 then
          begin
            dm.ADOCon.RollbackTrans;
            showmessage('ȡ���ύ�����뵥ʧ��,����״̬�ѷ����仯...');
          end
          else
          begin
            dm.tmp.SQL.Text := 'delete from data0368  where apply_ptr=' +
              dm.ADO268rkey.AsString;
            dm.tmp.ExecSQL;
            dm.ADOCon.CommitTrans;
          end;
          BtBrushClick(nil);
        except
          dm.ADOCon.RollbackTrans;
          showmessage('ȡ���ύ�����뵥ʧ��...');
        end;
      end;
  end;
end;


procedure TFrm_main.N6Click(Sender: TObject);
begin
   BtBrushClick(nil);
  if DM.ADO268Prted.AsBoolean and (vprev<>'3') then
  begin
    showmessage('�����뵥�Ѿ���ӡ,����Ȩ�ظ���ӡ...');
    exit;
  end;

  if dm.ADO268allow_submit.value=1 then
  begin
  ShowMessage('�г��죬�����ѷ��ͣ���ȴ��쵼�����ٴ�ӡ��');
  exit;
  end;
     SetCurrentDir(extractfilepath(paramstr(0)));
        try
                Report_Frm:= TReport_Frm.Create(self);
                Report_Frm.ADS268.Close;
                Report_Frm.ADS268.Parameters[0].Value:=DM.ADO268rkey.Value;
                Report_Frm.ADS268.Open;
                Report_Frm.ppReport1.Reset;
                Report_Frm.ppReport1.Template.FileName :=
                stringReplace(UpperCase(extractfilepath(paramstr(0))),'EXEC\','NIERP\REPORT\',[rfReplaceAll])+'Rep268_1.rtm';
                Report_Frm.ppReport1.Template.LoadFromFile;
                Report_Frm.ppReport1.SaveAsTemplate:=False;
                Report_Frm.ppReport1.Print;
        finally
                Report_Frm.ADS468.Close;
                Report_Frm.ADS268.Close;
                Report_Frm.Free;
        end;
end;

procedure TFrm_main.BitBtn6Click(Sender: TObject);
begin
  if (strtoint(vprev)=1) or (strtoint(vprev)=3) then
  begin
    messagedlg('�Բ���!��û�иó���Ŀ�дȨ��',mtinformation,[mbok],0);
    exit;
  end;

  SetCurrentDir(extractfilepath(paramstr(0)));

        try
              Report_Frm:= TReport_Frm.Create(application);
              Report_Frm.ppReport1.Reset;
              Report_Frm.ppReport1.Template.FileName :=
               // stringReplace(GetCurrentDir,'EXEC','NIERP\REPORT\',[rfReplaceAll])+'Rep268_1.rtm';
               stringReplace(UpperCase(extractfilepath(paramstr(0))),'EXEC\','NIERP\REPORT\',[rfReplaceAll])+'Rep268_1.rtm';
              Report_Frm.ppReport1.Template.LoadFromFile;
              Report_Frm.ppReport1.SaveAsTemplate:=true;   
              Report_Frm.ppdesigner1.ShowModal;
        finally
              Report_Frm.ADS468.Close;
              Report_Frm.ADS268.Close;
              Report_Frm.Free;
        end;
end;


procedure TFrm_main.N8Click(Sender: TObject);
begin
   try     //���inf
     Frm_authInfo:=TFrm_authInfo.Create(nil);
     DM.tmp.Close;
     DM.tmp.SQL.Text:='SELECT Data0073.user_login_name USER_ID,Data0073.USER_FULL_NAME,data0368.user_ptr,'+
                      'data0368.auth_date,data0368.ranking,data0368.auth_flag FROM dbo.Data0073 INNER JOIN dbo.data0368 '+
                      'ON dbo.Data0073.RKEY = dbo.data0368.user_ptr '+
                      'WHERE dbo.data0368.apply_ptr='+dm.ADO268rkey.asstring+
                      ' order by dbo.data0368.ranking';
     DM.tmp.Open;
     Frm_authInfo.DataSource1.DataSet:=DM.tmp;
     Frm_authInfo.ShowModal;
   finally
     Frm_authInfo.Free;
     DM.tmp.Close;
   end;
end;

procedure TFrm_main.FormShow(Sender: TObject);
begin
  Grd1TitleClick(PreColumn);
end;

procedure TFrm_main.check_exist;
begin
  DM.tmp2.Close;
  DM.tmp2.SQL.Text :=
    'select RKEY, CUT_NO, SO_NO, FLOW_NO, STEP, DEPT_PTR, INVENT_PTR,  ' + #13 +
    ' round(QUAN_BOM,2) as QUAN_BOM1, QUAN_ISSUED, STATUS, PRINTIT,  ' + #13 +
    ' VENDOR, Invent_or, quan_alloc, overproof ' + #13 +
    ' from data0468  where flow_no=' + DM.ADO268rkey.AsString;
  DM.tmp2.Open;

  while not DM.tmp2.Eof do
  begin
    DM.tmp3.Close;
    DM.tmp3.SQL.Text :=
      ' SELECT     dbo.DATA0136.rkey, dbo.DATA0136.control_name, ' + #13 +
      ' dbo.DATA0136.unit_ptr, dbo.DATA0136.warehouse_ptr, ' + #13 +
      ' dbo.DATA0136.stan_consume, dbo.DATA0155.invt_ptr ' + #13 +
      ' FROM         dbo.DATA0136 INNER JOIN   ' + #13 +
      ' dbo.DATA0155 ON dbo.DATA0136.rkey = dbo.DATA0155.control_ptr  ' + #13 +
      ' where warehouse_ptr = ' + DM.ADO268warehouse_ptr.AsString + #13 +
      ' and rkey = ' + DM.ado268control_ptr.AsString;
    DM.tmp3.Open;
    if not DM.tmp3.IsEmpty then
    begin
      result136 := 5;
      // ������Ŀ                  ���������             ��׼����                   ���ϵ��Ĳ���
      check_final(DM.tmp3.Fields[0].AsString, DM.tmp2.Fields[7].Value,
        DM.tmp3.Fields[4].Value, DM.tmp3.Fields[5].Value);
    end;
    DM.tmp2.Next;
  end;
end;

procedure TFrm_main.check_final(control_ptr: string; quan_Bom: Single;
  stan_consume: Single; rkey468: string);
var
  compile: Single;
  Ltime: string;
  LSql: string;
  LProductAre, LUse, LTmp: Single;
begin
  dm.qrytmp.Close;
  dm.qrytmp.SQL.Clear;
  dm.qrytmp.SQL.Add('SELECT group_id FROM data0136 WHERE RKey = ' +
    control_ptr);
  dm.qrytmp.Open;
  if dm.qrytmp.FieldByName('group_id').AsInteger = 0 then
    Ltime := '30'
  else
    Ltime := dm.qrytmp.FieldByName('group_id').AsString;

  LSql := 'select top ' + Ltime + ' * from data0137 where control_ptr = ' +
    control_ptr + ' and  warehouse_ptr = ' + dm.ADO268warehouse_ptr.AsString +
    ' order by curr_date desc';
  dm.ADO137.Close;
  dm.ADO137.SQL.Text := LSql;
  dm.ADO137.Open;
  LProductAre := 0;
  LUse := 0;
  while not dm.ADO137.Eof do
  begin
    LProductAre := LProductAre + dm.ADO137.FieldByName
      ('production_area').AsFloat;
    LUse := LUse + dm.ADO137.FieldByName('take_out').AsFloat;
    dm.ADO137.Next;
  end;
  if LUse = 0 then
    LUse := 1;
  LTmp := LProductAre / LUse;
  dm.ADO192.Close;
  dm.ADO192.Open;
  // DM.ado137.Close;
  // DM.ADO137.SQL.Text :=  'SELECT  '+#13
  // +' sum(dbo.DATA0137.production_area) as total_area ,'+#13
  // +' sum(dbo.DATA0137.take_out) AS total_takeout,'+#13
  // +' case sum(dbo.DATA0137.take_out)  when 0 then 0 else'+#13
  // +' (sum(dbo.DATA0137.production_area)/(sum(dbo.DATA0137.take_out) )) end as actual_consume '+#13
  // +'FROM       DATA0137 '+#13
  // +'WHERE     (dbo.DATA0137. control_ptr = '+control_ptr+
  // ' ) AND ( dbo.DATA0137.curr_date >= DATEADD(mm,   DATEDIFF(mm,0,getdate()),   0)+''08:00:00'') '+#13
  // +' AND ( dbo.DATA0137.curr_date <=  dateadd(ms,0,DATEADD(mm,DATEDIFF(m,0,getdate())+1,0)+''08:00:00'' )) '+#13
  // // +DM.ADO192ppc_control3.AsString+'))'+#13
  // // +Ltime+')+''08:00:00'')'+#13
  // +'AND (warehouse_ptr = '+DM.ADO268warehouse_ptr.AsString+' ) '+#13
  // +'GROUP BY  dbo.DATA0137.control_ptr'+#13;
  // DM.ado137.Open;
  if not dm.ADO137.IsEmpty then
  begin
    // opValue:=(RoundTo(stan_consume,-2)) > (RoundTo(( DM.ado137.Fields[1].AsInteger / (DM.ado137.Fields[2].AsInteger + (RoundTo(quan_Bom,-2)))),-2));

    if RoundTo(LTmp, -2) > 0.05 then
    begin
      // ShowMessage(DM.ado137.Fields[2].AsString);
      // ShowMessage(FloatToStr(stan_consume));
      if RoundTo(LTmp, -2) < RoundTo(stan_consume, -2) then
      begin
        compile := RoundTo(LTmp, -2);
        // compile := RoundTo(( DM.ado137.Fields[1].Value / DM.ado137.Fields[2].Value),-2);
        if rkey468 <> '' then
        begin
          try
            dm.ADOCon.BeginTrans;
            dm.tmp.Close;
            dm.tmp.SQL.Clear;
            dm.tmp.SQL.Text :=
              'update data0468 set overproof = 1 ,quan_alloc = ' +
              FloatToStr(compile) + ' where flow_no =' + dm.ADO268rkey.AsString
              + ' AND  (overproof = 0) and ( INVENT_PTR = ' + rkey468 + ')';
            // ShowMessage(DM.tmp.SQL.Text);
            if dm.tmp.ExecSQL = 0 then
            begin
              dm.ADOCon.RollbackTrans;
              Exit;
            end;
            result137 := 5;
            dm.ADOCon.CommitTrans;
            BtBrushClick(nil);
          except
            dm.ADOCon.RollbackTrans;
            showmessage('�����ύ���ִ���,�������Ա��ϵ!!!');
          end;
        end;

      end;
    end;
  end;
  dm.ADO192.Close;
end;

procedure TFrm_main.Grd2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (ssAlt in Shift)  and  (Key=86) then
  begin
      showmessage(DM.ADO468.SQL.Text);
  end;
end;



procedure TFrm_main.N11Click(Sender: TObject);
var
    v_message,i,j:integer;
    sms_message,sendername,phonenumber,
    StartTime,EndTime,Result1,QUAN_BOM468,number268,sendDateTime,UNIT_NAME468,showmessage1 :string;
    QueryTmp1,QueryTmp2,QueryTmp3,QueryTmp4:TADOQuery;
    rkey14 : array[0..128] of Integer;

begin
    QueryTmp1:=TADOQuery.Create(Self);
    QueryTmp1.Connection := DM.ADOCon;
    QueryTmp2:=TADOQuery.Create(Self);
    QueryTmp2.Connection := DM.ADOCon;
    QueryTmp3:=TADOQuery.Create(Self);
    QueryTmp3.Connection := DM.ADOCon;
    QueryTmp4:=TADOQuery.Create(Self);
    QueryTmp4.Connection := DM.ADOCon;

  if strtoint(vprev)<>4 then
  begin
    messagedlg('�Բ���!��û�������ύ��Ȩ��',mtinformation,[mbok],0);
    exit;
  end else
   if  dm.ADO268allow_submit.AsInteger=1 then
    begin

            v_message:=messagedlg('�Ƿ����ֻ�����֪ͨ?',mtConfirmation,[mbyes,mbno,mbcancel],0);
            // v_message:=6;
           {   if v_message=6 then
            begin
                      with QueryTmp1 do
                        begin
                                Close;
                                SQL.Clear;
                                SQL.Text:=  '   SELECT     dbo.Data0073.USER_FULL_NAME, dbo.Data0005.PHONE   '+#13+
                                            ' FROM    dbo.Data0005 INNER JOIN  '+#13+
                                            '    dbo.Data0073 ON dbo.Data0005.RKEY = dbo.Data0073.EMPLOYEE_PTR AND  '+#13+
                                            '    dbo.Data0005.RKEY = dbo.Data0073.EMPLOYEE_PTR where dbo.Data0073.rkey = '+rkey73;
                                Open;
                                phonenumber := Fieldbyname('PHONE').AsString;
                                sendername := Fieldbyname('user_full_name').AsString;
                        end;
                       i :=0;

                       DM.sms1.Close;
                       dm.sms1.SQL.Clear;
                       dm.sms1.SQL.Text :=  'SELECT      dbo.DATA0268.rkey, dbo.Data0015.ABBR_NAME, dbo.Data0034.DEPT_NAME, '+#13+
                                            ' dbo.Data0017.INV_NAME,getdate() AS SENDTIME,dbo.Data0468.INVENT_PTR,dbo.Data0468.quan_alloc,  '+#13+
                                            ' dbo.Data0002.UNIT_NAME, dbo.DATA0136.rkey AS rkey136 , dbo.DATA0136.stan_consume,dbo.DATA0136.control_name, '+#13+
                                            ' month(getdate()) AS MONTH1  '+#13+
                                            ' FROM         dbo.DATA0268 INNER JOIN '+#13+
                                            ' dbo.Data0034 ON dbo.DATA0268.dept_ptr = dbo.Data0034.RKEY INNER JOIN '+#13+
                                            ' dbo.Data0015 ON dbo.DATA0268.warehouse_ptr = dbo.Data0015.RKEY INNER JOIN  '+#13+
                                            ' dbo.Data0468 ON dbo.DATA0268.rkey = dbo.Data0468.FLOW_NO INNER JOIN '+#13+
                                            ' dbo.Data0017 ON dbo.Data0468.INVENT_PTR = dbo.Data0017.RKEY INNER JOIN  '+#13+
                                            ' dbo.Data0002 ON dbo.Data0017.PURCH_UNIT_PTR = dbo.Data0002.RKEY AND    '+#13+
                                            ' dbo.Data0017.STOCK_UNIT_PTR = dbo.Data0002.RKEY INNER JOIN  '+#13+
                                            ' dbo.DATA0136 ON dbo.Data0015.RKEY = dbo.DATA0136.warehouse_ptr AND dbo.DATA0268.control_ptr = dbo.DATA0136.rkey ' +#13+
                                            ' WHERE     (dbo.DATA0268.allow_submit = 1) AND ( dbo.Data0468.overproof = 1 ) '+#13+
                                            ' AND (dbo.DATA0268.rkey = '+DM.ADO268rkey.AsString+')' +#13;
                   //   ShowMessage(dm.sms1.SQL.Text);
                      DM.sms1.Open;

                      DM.ado137.Close;
                      DM.ADO137.SQL.Text :=  'SELECT  '+#13
                                         +' sum(dbo.DATA0137.production_area) as total_area ,'+#13
                                         +' sum(dbo.DATA0137.take_out) AS total_takeout,'+#13
                                         +' case sum(dbo.DATA0137.take_out)  when 0 then 0 else'+#13
                                         +' (sum(dbo.DATA0137.production_area)/(sum(dbo.DATA0137.take_out) )) end as actual_consume '+#13
                                         +'FROM       DATA0137 '+#13
                                         +'WHERE     (dbo.DATA0137. control_ptr = '+DM.ADO268control_ptr.AsString+
                                         ' ) AND ( dbo.DATA0137.curr_date >= DATEADD(mm,   DATEDIFF(mm,0,getdate()),   0)+''08:00:00'') '+#13
                                         +' AND ( dbo.DATA0137.curr_date <=  dateadd(ms,0,DATEADD(mm,DATEDIFF(m,0,getdate())+1,0)+''08:00:00'' )) '+#13
                                         // +DM.ADO192ppc_control3.AsString+'))'+#13
                                        // +Ltime+')+''08:00:00'')'+#13
                                         +'AND (warehouse_ptr = '+DM.ADO268warehouse_ptr.AsString+' ) '+#13
                                         +'GROUP BY  dbo.DATA0137.control_ptr'+#13;
                      DM.ado137.Open;
                      if not DM.ado137.IsEmpty then
                      begin
                        showmessage1 := '������:'+DM.ado137.fieldbyname('total_takeout').AsString+
                        dm.sms1.fieldbyname('UNIT_NAME').AsString+',';
                      end;

                      if not DM.sms1.IsEmpty then
                      begin
                          while not DM.sms1.Eof do
                          begin
                            sms_message :=  DM.sms1.Fields[1].asstring +' '+ DM.sms1.Fields[2].asstring+' '+DM.sms1.fieldByName('MONTH1').AsString+
                                            '�� ������ '+ DM.sms1.Fields[3].asstring+DM.ado137.fieldbyname('total_takeout').AsString+dm.sms1.fieldbyname('UNIT_NAME').AsString+','+
                                            'ƽ������ '+DM.sms1.Fields[6].asstring+'�O/'+DM.sms1.Fields[7].asstring+'),δ�ﵽ��׼('+
                                            DM.sms1.Fields[9].asstring+'�O/'+DM.sms1.Fields[7].asstring+'),��֪Ϥ!(ERP����)';
                                            
                                 ShowMessage(sms_message);
                                try

                                        DM.ado14_1.Close;
                                        DM.ado14_1.Open;
                                        DM.ado14_1.Edit;
                                        DM.ado14_1.FieldByName('message').AsString:= sms_message;
                                        DM.ado14_1.FieldByName('senddate').Value := DM.sms1.Fields[4].asstring;
                                        DM.ado14_1.FieldByName('whosend').Value:= rkey73;
                                         DM.ADOCon.BeginTrans;
                                        DM.ado14_1.Post;
                                        DM.ado14_1.UpdateBatch(arAll);
                                        DM.ADOCon.CommitTrans;
                                        rkey14[i] :=DM.ado14_1.FieldByName('rkey').asinteger;
                                        Inc(i);
                                 except
                                      DM.ADOCon.RollbackTrans;
                                      showmessage('ϵͳ��������, �������Ա��ϵ!!!');
                                 end;

                               DM.sms1.Next;
                          end;

                         

                            dm.sms_ToWhom.Close;
                            DM.sms_ToWhom.SQL.Clear;
                            DM.sms_ToWhom.SQL.Text := ' SELECT     dbo.DATA0139.rkey136, dbo.DATA0139.csi_ptr, dbo.Data0005.PHONE  '+#13+
                                                      '    FROM         dbo.DATA0139 INNER JOIN    '+#13+
                                                      '    dbo.DATA0136 ON dbo.DATA0139.rkey136 = dbo.DATA0136.rkey INNER JOIN    '+#13+
                                                      '    dbo.Data0073 ON dbo.DATA0139.csi_ptr = dbo.Data0073.RKEY INNER JOIN  '+#13+
                                                      '     dbo.Data0005 ON dbo.Data0073.EMPLOYEE_PTR = dbo.Data0005.RKEY AND   '+#13+
                                                      '  dbo.Data0073.EMPLOYEE_PTR = dbo.Data0005.RKEY '+#13+
                                                      'where dbo.DATA0139.rkey136 = '+DM.sms1.Fields[8].asstring;
                            dm.sms_ToWhom.Open;
                            if not DM.sms_ToWhom.IsEmpty then
                             begin
                                while not DM.sms_ToWhom.Eof do
                                begin
                                      for j:=0 to i-1 do
                                      begin
                                          try
                                            DM.ado314_1.Close;
                                            DM.ado314_1.Open;
                                            DM.ado314_1.Edit;
                                            DM.ado314_1.FieldByName('emp_ptr').AsString:= DM.sms_ToWhom.Fields[1].asstring;
                                            DM.ado314_1.FieldByName('d14_ptr').AsInteger := rkey14[j];
                                            DM.ado314_1.FieldByName('hread').Value:= 'F';
                                            DM.ado314_1.FieldByName('deleted').Value:= 'N';
                                            DM.ado314_1.FieldByName('if_note').Value:= 0;

                                             with QueryTmp2 do
                                              begin
                                                  Close;
                                                  SQL.Clear;
                                                  SQL.Text:='select SUPLFEDSHIP,SUPLFEDMAT,SUPLFEDMISC from data0192';
                                                  Open;
                                              end;
                                                if Trim(QueryTmp2.FieldByName('SUPLFEDSHIP').AsString) <> '' then
                                              begin
                                                    with QueryTmp1 do
                                                    begin
                                                          Close;
                                                          SQL.Text:='insert ['+QueryTmp2.FieldValues['SUPLFEDSHIP']+'].'+QueryTmp2.FieldValues['SUPLFEDMAT']+'.dbo.'+QueryTmp2.FieldValues['SUPLFEDMISC']+
                                                                    '(phonenumber,messagecontent,sendername,companyid) '+
                                                                    'values (:phonenumber,:messagecontent,:sendername,9)';
                                                          Parameters[0].Value:=DM.sms_ToWhom.Fields[2].asstring;
                                                          Parameters[1].Value:= sms_message;
                                                          Parameters[2].Value:=sendername;
                                                          ExecSQL;
                                                    end;
                                              end;

                                            DM.ADOCon.BeginTrans;
                                            DM.ado314_1.Post;
                                            DM.ado314_1.UpdateBatch(arAll);
                                            DM.ADOCon.CommitTrans;
                                          except
                                          DM.ADOCon.RollbackTrans;
                                          showmessage('ϵͳ��������, �������Ա��ϵ!!!');
                                          end;
                                      end;
                                  DM.sms_ToWhom.Next;
                                end;
                            end; 
                      end else showmessage('û�п��Է��Ͷ��ŵļ�¼...');
                      dm.sms1.Close;
                      DM.sms_ToWhom.Close;
            end;}

            try
               DM.ADOCon.BeginTrans;
               DM.tmp.Close;
               DM.tmp.SQL.Text:=' update data0268 set allow_submit=2 , allow_submit_person = '+rkey05+' , allow_submit_time = getdate() where rkey='+DM.ADO268rkey.AsString+' and allow_submit=1 '+#13+#13
                                +' update data0468 set overproof =2 , quan_alloc = 0  where flow_no = '+DM.ADO268rkey.AsString+' and overproof=1';

               if DM.tmp.ExecSQL=0 then
               begin
                 DM.ADOCon.RollbackTrans;
                 showmessage('���뵥״̬�����ı��δ�ܳɹ�ȷ��!');
                 BtBrushClick(nil);
                 exit;
               end;
               DM.ADOCon.CommitTrans;
               DM.tmp.Close;
             except
               DM.ADOCon.RollbackTrans;
               showmessage('�����ύ���ִ���,�������Ա��ϵ!!!');
             end;
//        end
//        else begin
//             showmessage('ȷ��״̬����ȷ���޷�ȷ��...');
//             Exit;
//        end;
    BtBrushClick(nil);
 end;
end;

procedure TFrm_main.btn1Click(Sender: TObject);
begin
   // ShowMessage(DM.ADO268rkey.AsString);
end;

procedure TFrm_main.BitBtn1Click(Sender: TObject);
begin
 with TVMIForm.Create(nil) do
 try
         if showmodal=mrok then
         begin
          // DM.ADO268.Close;
          // DM.ADO268.Open;
           //DM.ADO268.Locate('rkey',Frkey268,[]);
         end;
 finally
         free;
        // DM.ADO268_1.Close;
        // DM.ADO268_1.Close;
 end;
end;

procedure TFrm_main.N13Click(Sender: TObject);
var
  Lsql:string;
begin
  Lsql:='select  warehouse_ptr from data0073  where rkey='+rkey73;
  dm.OpenQry(dm.qrytmp,Lsql);

  if DM.qrytmp.FieldByName('warehouse_ptr').asinteger>0  then
  begin
   if DM.qrytmp.FieldByName('warehouse_ptr').AsString<>DM.ADO268.FieldByName('warehouse_ptr').AsString  then
   begin
   ShowMessage('��û��Ȩ���ύ�𳧵����ϣ�');
   exit;
   end;
  end ;




  if strtoint(vprev)<>4 then
  begin
    messagedlg('�Բ���!��û�������ύ��Ȩ��',mtinformation,[mbok],0);
    exit;
  end;

        if (dm.ADO268allow_submit.AsInteger<>3)  and (dm.ADO268allow_submit.AsInteger<>1) then
        begin
             showmessage('ȷ��״̬����ȷ���޷�ȷ��...');
             Exit;
        end else begin

            try
               DM.ADOCon.BeginTrans;
               DM.tmp.Close;
               DM.tmp.SQL.Text:=' update data0268 set allow_submit=2 , allow_submit_person = '+rkey05+' , allow_submit_time = getdate() where rkey='+DM.ADO268rkey.AsString+' '+#13+#13
                                +' update data0468 set overproof =2 , quan_alloc = 0  where flow_no = '+DM.ADO268rkey.AsString+' and overproof=1';                       // and allow_submit=3

               if DM.tmp.ExecSQL=0 then
               begin
                 DM.ADOCon.RollbackTrans;
                 showmessage('���뵥״̬�����ı��δ�ܳɹ�ȷ��!');
                 BtBrushClick(nil);
                 exit;
               end;
               
               // add by lisa 20160706   Ĭ��Ϊ0���룬 ����Ϊ1 IsIn
//             if MessageDlg('�ñ����ϳ����������Ҫ���뵱�������ۼ���',mtInformation, [mbYes,mbNo],0)= mryes then
//
//             else
//             begin
//                  ssql := '   update  b set IsIn=1  from  data0268 a  '+
//                       '     inner join data0468 b  on a.rkey=b.flow_no '+
//                       '   where  a.rkey='+DM.ADO268.fieldbyname('rkey').AsString+' and  left(b.remark,1)=''X''  ';
//                       dm.execsql(dm.qrytmp,ssql);
//                      // showmessage(ssql);
//             end;
               // modi end

               DM.ADOCon.CommitTrans;
               DM.tmp.Close;
             except
               DM.ADOCon.RollbackTrans;
               showmessage('�����ύ���ִ���,�������Ա��ϵ!!!');
             end;
        end;
    BtBrushClick(nil);
end;

procedure TFrm_main.FillKZXM;
var
  LS: TStringList;
  I: Integer;
  tmpIndex: Integer;
begin
  DM.adsKZXM.Close;
  DM.adsKZXM.Parameters.ParamByName('PRKey17').Value := dm.ADO468.fieldbyname('INVENT_PTR').AsInteger;
  DM.adsKZXM.Parameters.ParamByName('PRKey15').Value := dm.ADO268.fieldbyname('warehouse_ptr').AsInteger;
  DM.adsKZXM.Parameters.ParamByName('PRKey34').Value := DM.ADO268.fieldbyname('dept_ptr').AsInteger;
  DM.adsKZXM.Open;
  if DM.adsKZXM.IsEmpty then Exit;
  if Frm_detail.cbbKZXM.Items.Count = 0 then
  begin
    while not DM.adsKZXM.Eof do
    begin
      Frm_detail.cbbKZXM.AddItem(DM.adsKZXM.fieldbyname('control_name').AsString,Pointer(DM.adsKZXM.fieldbyname('RKey').asInteger));
      DM.adsKZXM.Next;
    end;
    Frm_detail.cbbKZXM.ItemIndex := 0;
  end else
  begin
    LS := TStringList.Create;
    try
    while not DM.adsKZXM.Eof do
    begin
      for I := 0 to Frm_detail.cbbKZXM.Items.Count - 1 do
      begin
        if Integer(Frm_detail.cbbKZXM.Items.Objects[I]) = DM.adsKZXM.fieldbyname('RKey').asInteger then
        begin
          LS.AddObject(Frm_detail.cbbKZXM.Items[I],Frm_detail.cbbKZXM.Items.Objects[I]);
        end;
      end;
      DM.adsKZXM.Next;
    end;
    if LS.Count = 0 then
    begin
      //ShowMessage('һ�����ϵ��в�����2�ֲ�ͬ������Ŀ�Ĳ���');
      Frm_detail.cbbKZXM.Items.Clear;
    end else
    begin
      tmpIndex := Frm_detail.cbbKZXM.ItemIndex;
      Frm_detail.cbbKZXM.Items.Clear;
      Frm_detail.cbbKZXM.Items.Assign(LS);
      if Frm_detail.cbbKZXM.Items.Count -1 >= tmpIndex then
      begin
        Frm_detail.cbbKZXM.ItemIndex := tmpIndex;
      end else
        Frm_detail.cbbKZXM.ItemIndex := 0;
    end;
    finally
      LS.Free;
    end;
  end;
end;

procedure TFrm_main.Grd2DrawColumnCell(Sender: TObject; const Rect: TRect;
  DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
begin
  if  dm.ADO468.isempty then  exit;
  if (dm.ADO468.FieldByName('remark').Value=null) or (dm.ADO468.FieldByName('remark').Value='') then exit;
  If Copy(dm.ADO468.FieldByName('remark').Value,0,1) = 'X'  then
  Begin
    Grd2.Canvas.Font.Color := clRed;
    Grd2.DefaultDrawColumnCell(Rect, DataCol, Column, [gdFixed,gdFocused,gdSelected]);
  End
end;

procedure TFrm_main.N14Click(Sender: TObject);
begin
   if strtoint(vprev)<>4 then
  begin
    messagedlg('�Բ���!��û��������ӡ��Ȩ��',mtinformation,[mbok],0);
    exit;
  end;

  if  DM.ADO268Prted.AsBoolean then
  begin
  DM.ADO268.Edit;
  DM.ADO268Prted.Value:=false;
  DM.ADO268.Post;
  end;
end;

//�ύ������
procedure TFrm_main.N4Click(Sender: TObject);
var
  ssql,messages,messages2: string;
  iRank: integer;
begin
//
  if  ((strtoint(vprev) = 1) or (strtoint(vprev) = 3)) then
  begin
    messagedlg('�Բ���!��û�иó����Ȩ��', mtinformation, [mbok], 0);
    abort;
  end;
  try


     //������Ŀ
   ssql:='select distinct d468.control_ptr'+
    ' from data0268 d268                                                  '+
    ' inner join data0468  d468  on d268.rkey=d468.flow_no                  '+
    ' left join data0136 d136  on d468.control_ptr = d136.rkey                '+
    ' where left(d468.remark,1)=''X'' and  isnull(d136.control_name,'''')<>'''' and  d268.number='''+ DM.ADO268.FieldByName('number').asstring+''' ';
    DM.OpenQry(DM.qry_temp33,ssql);


    messages2:=' '+ DM.ADO268.FieldByName('fac_name').asstring+' '+ DM.ADO268.FieldByName('dept_name').asstring+' ���ϵ���'+ DM.ADO268.FieldByName('number').asstring+': '+#13;
    if not DM.qry_temp33.IsEmpty then
    begin
       DM.qry_temp33.First;
     while not DM.qry_temp33.eof do
     begin
        //������Ŀ�µ�����
       ssql:='select distinct d17.inv_name,d268.number, d468.remark '+    //,isnull(d136.control_name,'''') as control_name
        ' from data0268 d268                                                  '+
        ' inner join data0468  d468  on d268.rkey=d468.flow_no                  '+
        ' inner join data0017  d17 on d468.INVENT_PTR=d17.rkey'+
        ' left join data0136 d136  on d468.control_ptr = d136.rkey                '+
        ' where left(d468.remark,1)=''X'' and  d468.control_ptr='+DM.qry_temp33.FieldByName('control_ptr').asstring+'  '+
        ' and  d268.number='''+ DM.ADO268.FieldByName('number').asstring+''' ';
        DM.OpenQry(DM.qry_temp,ssql);


     if not DM.qry_temp.IsEmpty then
      begin
       DM.qry_temp.First;
       messages:='';
       while not DM.qry_temp.eof do    //messages+'����:'
       begin
         if  messages='' then
           messages:=DM.qry_temp.FieldByName('inv_name').asstring
         else
         messages:=messages+'��'+DM.qry_temp.FieldByName('inv_name').asstring ;   //+' '+DM.qry_temp.FieldByName('remark').asstring +'; '
       DM.qry_temp.next; //����
      end;
       messages:=messages2+'���ϣ�'+messages+' '+DM.qry_temp.FieldByName('remark').asstring  ;

       if not DM.ADO14_1.active then  DM.ADO14_1.open;

          DM.ADO14_1.append;
          DM.ado14_1.FieldByName('message').AsString:= messages;
          DM.ado14_1.FieldByName('senddate').Value :=now;
          DM.ado14_1.FieldByName('whosend').Value:= rkey73;
          DM.ado14_1.Post;
        
       // DM.ADOCon.BeginTrans;

        DM.ado14_1.UpdateBatch(arAll);
       // DM.ADOCon.CommitTrans;

     // DM.ADOCon.BeginTrans;
      ssql:= 'select distinct isnull(d139.csi_ptr,0)csi_ptr ,d05.PHONE'+     //, d73.USER_FULL_NAME
      '  from data0468 d468   '+
       ' left join data0139  d139 on d468.control_ptr =d139.rkey136 '+
         '  INNER JOIN   dbo.Data0073  d73 ON d139.csi_ptr =d73.RKEY  '+#13+
      '  INNER JOIN  dbo.Data0005  d05 ON d73.EMPLOYEE_PTR = d05.RKEY    '+#13+
      ' AND  d73.EMPLOYEE_PTR = d05.RKEY '+#13+
        ' where  left(d468.remark,1)=''X'' and  d468.control_ptr='+DM.qry_temp33.FieldByName('control_ptr').asstring+' and  d468.flow_no=' +DM.ADO268.FieldByName('rkey').asstring;
       DM.OpenQry(DM.qry_temp2,ssql);

       ssql:='select user_full_name from data0073 where rkey = ' +rkey73;
       DM.OpenQry(DM.qry_temp3,ssql);

       if not DM.qry_temp2.IsEmpty then
       begin
         DM.qry_temp2.first;
         while not  DM.qry_temp2.eof do
         begin
           if not DM.ado314_1.Active then DM.ado314_1.Open;

           // ����314��
          DM.ado314_1.append;
          DM.ado314_1.FieldByName('emp_ptr').AsString:= DM.qry_temp2.fieldbyname('csi_ptr').asstring;
          DM.ado314_1.FieldByName('d14_ptr').AsInteger :=  DM.ado14_1.fieldbyname('rkey').AsInteger;
          DM.ado314_1.FieldByName('hread').Value:= 'F';
          DM.ado314_1.FieldByName('deleted').Value:= 'N';
          DM.ado314_1.FieldByName('if_note').Value:= 1;
          DM.ado314_1.post;

          //

           ssql:='select SUPLFEDSHIP,SUPLFEDMAT,SUPLFEDMISC from data0192';
           DM.OpenQry(DM.qry_temp22,ssql);

          if Trim(dm.qry_temp22.FieldByName('SUPLFEDSHIP').AsString) <> '' then
          begin

                      ssql:='insert ['+DM.qry_temp22.FieldValues['SUPLFEDSHIP']+'].'+DM.qry_temp22.FieldValues['SUPLFEDMAT']+'.dbo.'+DM.qry_temp22.FieldValues['SUPLFEDMISC']+
                                '(phonenumber,messagecontent,sendername,companyid) '+
                                'values ('''+DM.qry_temp2.Fieldbyname('phone').asstring+''','''+messages+''','''+DM.qry_temp3.Fieldbyname('USER_FULL_NAME').asstring+''',9)';

                     dm.execsql(dm.qrytmp,ssql);
          end;

          DM.qry_temp2.next;
         end;

          DM.ado314_1.UpdateBatch(arAll);
       end;

     end;
     messages:='';
     DM.qry_temp33.next;//������Ŀ
    end;
     
       ssql:='update data0268 set IsMsgSended =1  where number='''+dm.ADO268.fieldbyname('number').asstring+''' ' ;
        dm.execsql(dm.qry_temp,ssql);
       // DM.ADOCon.CommitTrans;
         BtBrushClick(nil);


   end;
   /////////���ŷ������

  //   if  dm.ADO268allow_submit.Value = 1 then    // ��ȷ�� lisa1024
  //   begin
//      showmessage('�������ѳ��첻���ύ����Ҫ�������Աȷ��.');
//       exit;
   //  end
    // else
     if dm.ADO268allow_submit.Value= 2 then    //��ȷ��
      begin
        try
          dm.ADOCon.BeginTrans;
          dm.tmp.Close;
          dm.tmp.SQL.Text :=
            'update data0268 set status=1,auth_emplptr=null,auth_date=null where rkey='
            + dm.ADO268rkey.AsString + ' and status=0';
           if dm.tmp.ExecSQL = 0 then
          begin
            dm.ADOCon.RollbackTrans;
            showmessage('���뵥״̬�����ı��δ�ܳɹ��ύ!');
            BtBrushClick(nil);
            exit;
          end;

          dm.tmp.Close;
          dm.tmp.SQL.Text := 'delete from data0368  where apply_ptr=' +
            dm.ADO268rkey.AsString;
          dm.tmp.ExecSQL;

          dm.tmp1.Close;
          dm.tmp1.SQL.Text := 'select * from data0275 where AUTH_GROUP_PTR=' +
            dm.ADO268AUTH_ptr.AsString + ' order by rkey';
          dm.tmp1.Open;
          iRank := 1;
          while not dm.tmp1.Eof do
          begin
            dm.tmp.Close;
            if iRank = 1 then
              dm.tmp.SQL.Text :=
                'insert into data0368(apply_ptr,user_ptr,ranking,auth_flag) '
                + 'values(' + dm.ADO268rkey.AsString + ',' +
                dm.tmp1.fieldbyname('user_ptr').AsString + ',' +
                inttostr(iRank) + ',''Y'')'
            else
              dm.tmp.SQL.Text :=
                'insert into data0368(apply_ptr,user_ptr,ranking,auth_flag) '
                + 'values(' + dm.ADO268rkey.AsString + ',' +
                dm.tmp1.fieldbyname('user_ptr').AsString + ',' +
                inttostr(iRank) + ',''N'')';
            dm.tmp.ExecSQL;
            inc(iRank);
            dm.tmp1.Next;
          end;
          dm.ADOCon.CommitTrans;
          BtBrushClick(nil);
        except
          dm.ADOCon.RollbackTrans;
          showmessage('�����ύ���ִ���,�������Ա��ϵ!!!');
        end;
      end
    else // ��ȷ��
    begin
      begin
        try
          dm.ADOCon.BeginTrans;
          dm.tmp.Close;
          dm.tmp.SQL.Text :=
            'update data0268 set status=1,auth_emplptr=null,auth_date=null where rkey='
            + dm.ADO268rkey.AsString + ' and status=0';
          if dm.tmp.ExecSQL = 0 then
          begin
            dm.ADOCon.RollbackTrans;
            showmessage('���뵥״̬�����ı��δ�ܳɹ��ύ!');
            BtBrushClick(nil);
            exit;
          end;

          dm.tmp.Close;
          dm.tmp.SQL.Text := 'delete from data0368  where apply_ptr=' +
            dm.ADO268rkey.AsString;
          dm.tmp.ExecSQL;

          dm.tmp1.Close;
          dm.tmp1.SQL.Text :=
            'select * from data0275 where AUTH_GROUP_PTR=' +
            dm.ADO268AUTH_ptr.AsString + ' order by rkey';
          dm.tmp1.Open;
          iRank := 1;
          while not dm.tmp1.Eof do
          begin
            dm.tmp.Close;
            if iRank = 1 then
              dm.tmp.SQL.Text :=
                'insert into data0368(apply_ptr,user_ptr,ranking,auth_flag) '
                + 'values(' + dm.ADO268rkey.AsString + ',' +
                dm.tmp1.fieldbyname('user_ptr').AsString + ',' +
                inttostr(iRank) + ',''Y'')'
            else
              dm.tmp.SQL.Text :=
                'insert into data0368(apply_ptr,user_ptr,ranking,auth_flag) '
                + 'values(' + dm.ADO268rkey.AsString + ',' +
                dm.tmp1.fieldbyname('user_ptr').AsString + ',' +
                inttostr(iRank) + ',''N'')';
            dm.tmp.ExecSQL;
            inc(iRank);
            dm.tmp1.Next;
          end;
          dm.ADOCon.CommitTrans;
          BtBrushClick(nil);
        except
          dm.ADOCon.RollbackTrans;
          showmessage('�����ύ���ִ���,�������Ա��ϵ!!!');
        end;
      end;
    end;

  
  except  on e:exception do
  begin
  ShowMessage('����'+e.message+ssql);
  exit;
  end;
  end;
end;

end.
