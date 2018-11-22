unit addEquipment;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls, Grids, DBGrids, ExtCtrls, DB,
  ADODB, DBGridEh, Menus,ShellAPI, DBClient,  Mask, DBCtrls;

type
  TFrm_addEquipment = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
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
    Label16: TLabel;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Label21: TLabel;
    Label22: TLabel;
    Label15: TLabel;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit_FASSET_DESC: TEdit;
    Edit_machine_number: TEdit;
    ComboBox1: TComboBox;
    Edit5: TEdit;
    BitBtn3: TBitBtn;
    Edit_LOCATION: TEdit;
    DateTimePicker1: TDateTimePicker;
    ComboBox2: TComboBox;
    Edit7: TEdit;
    Edit8: TEdit;
    Memo1: TMemo;
    Edit9: TEdit;
    Edit10: TEdit;
    Edit11: TEdit;
    Edit12: TEdit;
    Edit13: TEdit;
    Edit14: TEdit;
    Edit15: TEdit;
    Panel1: TPanel;
    btn1: TButton;
    btn2: TButton;
    btn3: TButton;
    DBGrid1: TDBGrid;
    ComboBox3: TComboBox;
    Label23: TLabel;
    cbb_DeviType: TComboBox;
    DBGrid2: TDBGrid;
    PopupMenu2: TPopupMenu;
    N_Open: TMenuItem;
    N_Upload: TMenuItem;
    N_Download: TMenuItem;
    N_Delete: TMenuItem;
    SaveDialog1: TSaveDialog;
    OpenDialog1: TOpenDialog;
    DataSource1: TDataSource;
    Panel2: TPanel;
    Panel3: TPanel;
    Panel4: TPanel;
    DBGridEh1: TDBGridEh;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    CheckBox1: TCheckBox;
    Label24: TLabel;
    bit_FaultDesc: TBitBtn;
    edt_FaultDesc1: TDBEdit;
    Label25: TLabel;
    btn_Location: TSpeedButton;
    edt_Location: TEdit;
    cb_EquiType: TCheckBox;
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure BitBtn1Enter(Sender: TObject);
    procedure Edit5Exit(Sender: TObject);
    procedure btn3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure N_OpenClick(Sender: TObject);
    procedure N_UploadClick(Sender: TObject);
    procedure N_DownloadClick(Sender: TObject);
    procedure N_DeleteClick(Sender: TObject);
    procedure PopupMenu2Popup(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure bit_FaultDescClick(Sender: TObject);
    procedure btn_LocationClick(Sender: TObject);
    procedure edt_LocationDblClick(Sender: TObject);
  private
    { Private declarations }
    req:Integer;

    procedure ADODataSetAddToComboboxItems(DataSet:TCustomADODataSet;
                             ComboBox:TCustomComboBox;FFieldName:string);
  public
    FormState    :string[10];
    { Public declarations }
  end;

var
  Frm_addEquipment: TFrm_addEquipment;
  const
  TmpFileDir = 'c:\tmp\';

implementation
                           //    
uses dept, dmo, common,addDetail, PubFunc, formMultiSelectedItem,
  SelectItemUnit;

{$R *.dfm}

procedure TFrm_addEquipment.ADODataSetAddToComboboxItems(DataSet:TCustomADODataSet;
                             ComboBox:TCustomComboBox;FFieldName:string);
begin
  try
    DataSet.DisableControls;
    DataSet.First;
    while not( DataSet.Eof )   do
    begin
        ComboBox.Items.Add(trim(DataSet.FieldByName(FFieldName).asstring));
        DataSet.Next;
    end;
  finally
    DataSet.EnableControls;
  end;
end;


procedure TFrm_addEquipment.BitBtn3Click(Sender: TObject);
begin
  Frm_dept:=TFrm_dept.Create(Application);
  Frm_dept.ADO34.Parameters[0].Value:='';
  with Frm_dept.ADO34 do
  begin
    Close;
    if Trim(Edit5.Text)<>'' then
      Parameters[0].Value:=Trim(Edit5.Text)
    else
      Parameters[0].Value:='';
    Open;
    if IsEmpty then
    begin
      ShowMessage('��������ȷ�Ĳ��Ŵ���');
      Edit5.SetFocus;
      Exit;
    end;
  end;
  if Frm_dept.ShowModal=mrok then
  begin
    Edit5.Text:=Frm_dept.ADO34dept_code.Value;
    Label13.Caption:=Frm_dept.ADO34dept_name.Value;
    Label14.Caption:=Frm_dept.ADO34rkey.Text
  end;
end;

procedure TFrm_addEquipment.BitBtn2Click(Sender: TObject);
begin
  DM.ADO417.Cancel;
  Close;
end;

procedure TFrm_addEquipment.BitBtn1Click(Sender: TObject);
begin
  PageControl1.TabIndex:=0;

  if Trim(Edit1.Text)='' then
  begin
    ShowMessage('�豸���벻��Ϊ��');
    Edit1.SetFocus;
    Exit;
  end;
  if Trim(Edit2.Text)='' then
  begin
    ShowMessage('�豸���Ʋ���Ϊ��');
    Edit2.SetFocus;
    Exit;
  end;
  if Trim(Edit5.Text)='' then
  begin
    ShowMessage('ʹ�ò��Ų���Ϊ��');
    Edit5.SetFocus;
    Exit;
  end;
  if Trim(ComboBox3.Text)='' then
  begin
    ShowMessage('�豸������Ϊ��');
    ComboBox3.SetFocus;
    Exit;
  end;
  if Trim(cbb_DeviType.Text)=''then
  begin
    ShowMessage('�������Ͳ���Ϊ��');
    cbb_DeviType.SetFocus;
    Exit;
  end;
  if Trim(edt_FaultDesc1.Text )='' then
  begin
    ShowMessage('��������𡱲���Ϊ��');
    Exit;
  end;
 { if Trim(edt_Location.Text )='' then
  begin
    ShowMessage('������С�顱����Ϊ��');
    Exit;
  end;  }
  if CheckBox1.Checked=False then    //�������=��
  if DBGridEh1.DataSource.DataSet.IsEmpty=False then      //������ݼ����ǿ�
  begin
    ShowMessage('����ü�¼�����豸�飬��������������豸��');
    Exit;
  end;

  if cb_EquiType.Checked then
  if edt_Location.Text='' then
  begin
    ShowMessage('������豸���ͣ�����С�鲻��Ϊ�ա�');
    Exit;
  end;
  ModalResult:=mrOk;
end;

procedure TFrm_addEquipment.btn1Click(Sender: TObject);
begin
  Frm_addDetail:=TFrm_addDetail.Create(Application);
  Frm_addDetail.Edit2.Text:=IntToStr(req);
  req:=req+1;
  
  if Frm_addDetail.ShowModal=mrOk then
  begin
    DM.ADO418.Append;
    DM.ADO418fasset_ptr.Value:=0;
    DM.ADO418name.Value:=Trim(Frm_addDetail.Edit1.Text);
    DM.ADO418seq_no.Value:=StrToInt(Trim(Frm_addDetail.Edit2.Text));
    DM.ADO418unit_ptr.Value:=Frm_addDetail.Edit4.Tag;
    DM.ADO418unit_name.Value:=Trim(Frm_addDetail.Edit4.Text);
    DM.ADO418qty.Value:=StrToInt(Trim(Frm_addDetail.Edit3.Text));
    DM.ADO418remark.Value:=Trim(Frm_addDetail.Edit5.Text);
    DM.ADO418.Post;
  end;
end;

procedure TFrm_addEquipment.btn2Click(Sender: TObject);
begin
  Frm_addDetail:=TFrm_addDetail.Create(Application);
  with Frm_addDetail do
  begin
    Edit1.Text:=DM.ADO418name.Value;
    Edit2.Text:=DM.ADO418seq_no.Text;
    Edit3.Text:=DM.ADO418qty.Text;
    Edit4.Text:=DM.ADO418unit_name.Value;
    Edit4.Tag:=dm.ADO418unit_ptr.Value;
    Edit5.Text:=DM.ADO418remark.Value;
  end;
  if Frm_addDetail.ShowModal=mrOk then
  begin
    dm.ADO418.Edit;
    dm.ADO418name.Value:=Frm_addDetail.Edit1.Text;
    dm.ADO418seq_no.Value:=StrToInt(Frm_addDetail.Edit2.Text);
    DM.ADO418qty.Value:=StrToInt(Frm_addDetail.Edit3.Text);
    dm.ADO418unit_ptr.Value:=Frm_addDetail.Edit4.Tag;
    dm.ADO418unit_name.Value:=Frm_addDetail.Edit4.Text;
    dm.ADO418remark.Value:=Frm_addDetail.Edit5.Text;
    dm.ADO418.Post;
  end;
end;

procedure TFrm_addEquipment.BitBtn1Enter(Sender: TObject);
begin
//  PageControl1.TabIndex:=0;
//
//  if Trim(Edit1.Text)='' then
//  begin
//    ShowMessage('�豸���벻��Ϊ��');
//    Edit1.SetFocus;
//    Exit;
//  end;
//  if Trim(Edit2.Text)='' then
//  begin
//    ShowMessage('�豸���Ʋ���Ϊ��');
//    Edit2.SetFocus;
//    Exit;
//  end;
//  if Trim(Edit5.Text)='' then
//  begin
//    ShowMessage('ʹ�ò��Ų���Ϊ��');
//    Edit5.SetFocus;
//    Exit;
//  end;
//  if Trim(ComboBox3.Text)='' then
//  begin
//    ShowMessage('�豸������Ϊ��');
//    ComboBox3.SetFocus;
//    Exit;
//  end;
//  if Trim(cbb_DeviType.Text)=''then
//  begin
//    ShowMessage('�������Ͳ���Ϊ��');
//    cbb_DeviType.SetFocus;
//    Exit;
//  end;
//  if Trim(edt_FaultDesc1.Text )='' then
//  begin
//    ShowMessage('��������𡱲���Ϊ��');
//    Exit;
//  end;
//
//  if CheckBox1.Checked=False then    //�������=��
//  if DBGridEh1.DataSource.DataSet.IsEmpty=False then      //������ݼ����ǿ�
//  begin
//    ShowMessage('����ü�¼�����豸�飬��������������豸��');
//    Exit;
//  end;
end;

procedure TFrm_addEquipment.Edit5Exit(Sender: TObject);
begin
  if Trim(Edit5.Text)<>'' then
  begin
    with DM.ADOQuery1 do
    begin
      Active:=False;
      SQL.Clear;
      SQL.Add('select rkey,dept_code,dept_name from data0034 where dept_code='''+trim(Edit5.Text)+'''');
      Active:=True;
      if IsEmpty then
      begin
        ShowMessage('��������ȷ�Ĳ��Ŵ���');
        Edit5.SetFocus;
        Exit;
      end
      else
      begin
        Edit5.Text:=FieldValues['dept_code'];
        Label13.Caption:=FieldValues['dept_name'];
        Label14.Caption:=FieldValues['rkey'];
      end;
    end;
  end;
end;

procedure TFrm_addEquipment.btn3Click(Sender: TObject);
begin
  if not dm.ADO418.IsEmpty then
    DM.ADO418.Delete;
end;

procedure TFrm_addEquipment.FormShow(Sender: TObject);
begin
  req:=1;
  PageControl1.TabIndex:=0;

  
  with DM.cds0417 do
  begin
    Close;
    if FormState<>'i' then
      Params.ParamByName('vrkey').Value:=DM.ADO417RKEY.Value
    else
      Params.ParamByName('vrkey').Value:=0;
    Open;
  end;
end;

procedure TFrm_addEquipment.FormCreate(Sender: TObject);
begin
  with DM.Read0811 do
  if Active=False then
    Open;
  ADODataSetAddToComboboxItems(DM.Read0811,cbb_DeviType,'DeviType');

  with DM.cds0417 do
  begin
    FieldByName('Rkey').Visible:=False;

    FieldByName('FASSET_CODE').DisplayLabel:='�豸����';
    FieldByName('FASSET_CODE').DisplayWidth:=12;
    FieldByName('FASSET_NAME').DisplayLabel:='�豸����';
    FieldByName('FASSET_NAME').DisplayWidth:=18;
    FieldByName('FASSET_DESC').DisplayLabel:='����ͺ�';
    FieldByName('FASSET_DESC').DisplayWidth:=10;
    FieldByName('equipment_grade').DisplayLabel:='�豸����';
    FieldByName('equipment_grade').DisplayWidth:=10;
    FieldByName('FASSET_TYPE').DisplayLabel:='�豸���';
    FieldByName('FASSET_TYPE').DisplayWidth:=10;
    FieldByName('DeviType').DisplayLabel:='��������';
    FieldByName('DeviType').DisplayWidth:=8;
    FieldByName('DEPT_NAME').DisplayLabel:='ʹ�ò���';
    FieldByName('DEPT_NAME').DisplayWidth:=10;
    FieldByName('LOCATION').DisplayLabel:='����λ��';
    FieldByName('LOCATION').DisplayWidth:=10;
    FieldByName('active_flag').DisplayLabel:='״̬';
    FieldByName('active_flag').DisplayWidth:=8;
    FieldByName('ABBR_NAME').DisplayLabel:='����';
    FieldByName('ABBR_NAME').DisplayWidth:=8;

  end;
end;

procedure TFrm_addEquipment.N_OpenClick(Sender: TObject);
var
//  filename,
  f: string;
  fs: TMemoryStream;
begin
  with   dm.qryTemp do
  begin
    Close;
    SQL.Clear;
    SQL.Text:='select VCUT_BMP,file_name from data0813 where [file_name]='+quotedstr(dm.qry0813file_name.AsString)
    +' and  fasset_ptr='+inttostr(DM.qry0813FASSET_PTR.value);
    Open;
    
    fs:=TMemoryStream.Create;
    TBlobfield(FieldByName('VCUT_BMP')).SaveToStream(fs);
    if not DirectoryExists(TmpFileDir) then
      if not CreateDir(TmpFileDir) then
        raise Exception.Create('������ʱ�ļ�Ŀ¼����: '+TmpFileDir);
    UnPackStream(fs);
    f:=TmpFileDir+FieldByName('file_name').AsString;
    fs.SaveToFile(f);
    fs.Free;
    ShellExecute(0,'open',pchar(f),nil,nil,SW_SHOWNORMAL);
  end;
end;

procedure TFrm_addEquipment.N_UploadClick(Sender: TObject);
var i:integer;
//    y:integer;
    s:string;
    fs: TMemoryStream;
begin
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
      with DBGrid2.DataSource.DataSet do
      begin
        if Locate('file_name',s,[]) then  //����ϴ����ļ��Ѿ����ڡ�
          begin
            if Messagedlg('�ļ���:'+S+'�Ѿ�����,ȷ����Ҫ������',mtconfirmation,[mbYES,mbNO],0)=mrNo  then
              Exit;
            begin
              try
                DM.ADOConn.BeginTrans;
                  with DM.qryTemp do
                  begin
                    SQL.Clear;
                    SQL.Add('update data0813 '+
                    'set VCUT_BMP=:file_data_s from data0813 where [file_name]= '''+s+''' and FASSET_PTR='+inttostr(DM.ADO417RKEY.Value) );
                    Parameters.ParamByName('file_data_s').LoadFromStream(fs,ftBlob);
                    ExecSQL;
                  end;
                  Edit;
                  FieldByName('user_ptr').Value:=user_ptr;
                  FieldByName('in_date') .Value:=GetSystem_Date(DM.qryTemp,0);
                  Post;
                DM.ADOConn.CommitTrans;
                  Refresh;
                  fs.Free;
                  showmessage('�ļ��޸ĳɹ�!!!');

              except
                on e: exception do
                begin
                  DM.ADOConn.RollbackTrans;         //�ع�����
                  Cancel;
                  showmessage('�ļ��ϴ�ʧ��,ԭ���ǣ�'+e.message);
                  fs.Free;
                end;
              end;
            end ;
          end
        else     //��������ڣ����
          begin

            try

              try
                if State <>dsInsert then
                  Append;
                FieldByName('FASSET_PTR').Value:=DM.ADO417RKEY.Value;
                FieldByName('user_ptr').Value:=user_ptr;
                FieldByName('in_date') .Value:=GetSystem_Date(DM.qryTemp,0);
                FieldByName('file_name') .Value:=s;
                Post;

                with DM.qryTemp do
                begin
                SQL.Clear;
                SQL.Add('update data0813 '+
                'set VCUT_BMP=:file_data_s from data0813 where [file_name]= '''+s+''' and FASSET_PTR='+inttostr(DM.ADO417RKEY.Value) );
                Parameters.ParamByName('file_data_s').LoadFromStream(fs,ftBlob);
                ExecSQL;
                end;
              except
                on e: exception do
                begin
                  Cancel;
                  showmessage('�½��ļ�Ŀ¼ʧ��,ԭ���ǣ�'+e.message);
                  Exit;
                end;
              end;
              fs.Free;
              Refresh;
              showmessage('�ļ��ϴ��ɹ�!!!');
            except
              on e: exception do
              begin
                DM.ADOConn.RollbackTrans;         //�ع�����
                Cancel;
                showmessage('�ļ��ϴ�ʧ��,ԭ���ǣ�'+e.message);
                fs.Free;
              end;
            end;

          end;
      end;
      if s='' then showmessage('�ļ�Ϊ��');
  end;
end;


procedure TFrm_addEquipment.N_DownloadClick(Sender: TObject);
var      //  filename,
  f: string;
  fs: TMemoryStream;
begin
  with   dm.qryTemp do
  begin
    Close;
    SQL.Clear;
    SQL.Text:='select VCUT_BMP,file_name from data0813 where [file_name]='+quotedstr(dm.qry0813file_name.AsString)
    +' and  fasset_ptr='+inttostr(DM.qry0813FASSET_PTR.value);
    Open;
      fs:=TMemoryStream.Create;
      TBlobfield(FieldByName('VCUT_BMP')).SaveToStream(fs);
      savedialog1.FileName:=FieldByName('file_name').AsString;
      SaveDialog1.Filter :='*.*';
      if SaveDialog1.Execute then
      begin
        UnPackStream(fs);
        f:=savedialog1.FileName;
        fs.SaveToFile(f);
        application.MessageBox('�ļ�����ɹ�!','��ʾ!',64);
      end;
      fs.Free;
  end;
end;

procedure TFrm_addEquipment.N_DeleteClick(Sender: TObject);
//var
//  f,k: string;
begin
  if MessageBox(Handle,'ȷ��ɾ�����ĵ���?','��ʾ',MB_YESNO+MB_ICONWARNING+MB_DEFBUTTON2)=IDNO	then
    exit;
  with DBGrid2.DataSource.DataSet do
  begin
    Delete;
  end;
end;

procedure TFrm_addEquipment.PopupMenu2Popup(Sender: TObject);
begin
  if StrToInt(vprev)  in [1,3] then
  begin
    N_Open    .Enabled:=False;
    N_Upload  .Enabled:=False;
    N_Download.Enabled:=False;
    N_Delete  .Enabled:=False;
  end;

  if DBGrid2.DataSource.DataSet.IsEmpty then
  begin
    N_Open     .Enabled:=False;
    N_Download .Enabled:=False;
    
    N_Delete   .Enabled:=False;
  end
  else
  begin
    N_Open     .Enabled:=True;
    N_Download .Enabled:=True;
    if FormState<>  's' then
    N_Delete   .Enabled:=True;
  end;
  {����ǲ���״̬���ϴ���ť�����á�ΪʲôҪ����д�أ�
  ��Ϊ�ϴ���ʱ��Ҫ��ȡ0417���RKEY��ֵ��0417����뻹û����ǰRKEY��û��ֵ��   }
  if FormState='i' then   //����ǲ���
  begin
    N_Upload.Enabled:=False;
    N_Delete.Enabled:=False;
  end;

end;

procedure TFrm_addEquipment.FormDestroy(Sender: TObject);
var
  sr: TSearchRec;
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

procedure TFrm_addEquipment.Button1Click(Sender: TObject);
var
  FilterStr:string;
  vRkey:Integer;
begin
  if Assigned(frmMultiSelectedItem) =False then
    Application.CreateForm(TfrmMultiSelectedItem, frmMultiSelectedItem);

  with DBGridEh1.DataSource.DataSet  do
  begin
    if IsEmpty=False then
    begin
      try
        FilterStr:='';
        vrkey:= FieldByName('rkey').Value;
        DisableControls ;
        First;
        while not Eof do      //��ѭ������ȡ�����ڵ�ǰRKEY��ֵ��
        begin
          FilterStr:=FilterStr+'rkey <> '+fieldByName('rkey').AsString+' and ';
          Next;
        end;
        FilterStr:=Copy(FilterStr,0,Length(FilterStr)-4);//ȥ������
      finally
        Locate('rkey',vRkey,[])   ;//���¶�λ
        EnableControls;
      end;
    end;
  end;

  with frmMultiSelectedItem do
  begin
    with Dgh1.DataSource.DataSet as TADOQuery do
    begin
      Close;
      Parameters.ParamByName('vrkey').Value:=DM.ADO417RKEY.Value;
      Open;

      if FilterStr<>'' then
      begin
        Filter:= FilterStr;
      //  ShowMessage(Filter);
        Filtered:=True;
      end;
    end;

    if frmMultiSelectedItem.ShowModal=mrOk then
    begin
      with  frmMultiSelectedItem.Dgh1.DataSource.DataSet as TADOQuery do
      begin
        if State   =dsEdit then
        Post;
        First;
        while not Eof do
        begin
          if FieldByName('selected').AsBoolean  then
          begin
            DM.cds0417.Append;
            DM.cds0417.FieldByName('RKEY').Value:= FieldByName('RKEY').Value;
            DM.cds0417.FieldByName('FASSET_CODE').Value:= FieldByName('FASSET_CODE').Value;
            DM.cds0417.FieldByName('FASSET_NAME').Value:= FieldByName('FASSET_NAME').Value;
            DM.cds0417.FieldByName('FASSET_DESC').Value:= FieldByName('FASSET_DESC').Value;
            DM.cds0417.FieldByName('FASSET_TYPE').Value:= FieldByName('FASSET_TYPE').Value;
            DM.cds0417.FieldByName('equipment_grade').Value:= FieldByName('equipment_grade').Value;
            DM.cds0417.FieldByName('DEPT_NAME').Value:= FieldByName('DEPT_NAME').Value;
            DM.cds0417.FieldByName('LOCATION').Value:= FieldByName('LOCATION').Value;
            DM.cds0417.FieldByName('active_flag').Value:= FieldByName('active_flag').Value;
            DM.cds0417.FieldByName('ABBR_NAME').Value:= FieldByName('ABBR_NAME').Value;
            DM.cds0417.FieldByName('DeviType').Value:= FieldByName('DeviType').Value;
            DM.cds0417.Post;
          end;
          Next;
        end;
      end;
    end;
  end;
end;

procedure TFrm_addEquipment.Button2Click(Sender: TObject);
begin
  with DBGrideh1.DataSource.DataSet do
  if IsEmpty=False then
  Delete;
end;

procedure TFrm_addEquipment.Button3Click(Sender: TObject);
begin
  with DBGrideh1.DataSource.DataSet as tclientdataset do
  CancelUpdates ;
end;

procedure TFrm_addEquipment.CheckBox1Click(Sender: TObject);
begin
  if CheckBox1.Checked then
    Button1.Enabled:=True
  else
    Button1.Enabled:=False  ;

end;

procedure TFrm_addEquipment.bit_FaultDescClick(Sender: TObject);
var
  Vpoint:Tpoint;
begin
  with  edt_FaultDesc1  do
  begin
    Vpoint:= Parent.ClientToScreen(Point(Left,Top));
    if ShowAddListForm(Frm_addEquipment.Handle,DM.dt_D0845,'FaultDesc',Text,Vpoint.x,Vpoint.y+Height,400)then
    begin
      if not(DM.ADO417.State in [dsEdit,dsInsert]) then
      DM.ADO417.Edit;

      DM.ADO417.FieldByName('D845_ptr').Value:= DM.dt_D0845.FieldByName('rkey').Value;
//      edt_FaultDesc.Text:=  DM.dt_D0845.FieldByName('FaultDesc').Value;
//      edt_FaultDesc.Tag:=   DM.dt_D0845.FieldByName('rkey').AsInteger;
    end;
  end
end;

procedure TFrm_addEquipment.btn_LocationClick(Sender: TObject);
var
  Vpoint:Tpoint;
begin
  with  edt_Location  do
  begin
    Vpoint:= Parent.ClientToScreen(Point(Left,Top));
    if ShowAddListForm(self.Handle,DM.QryD840,'Location',Text,Vpoint.x,Vpoint.y+Height,400)then
    begin
      edt_Location.Text:= DM.QryD840.FieldByName('Location').Value;
      edt_Location.Tag := DM.QryD840.FieldByName('rkey').Value;
//      if not (DM.cDS567.State in [dsEdit,dsInsert]) then
//      DM.cDS567.Edit;
//
//      dm.cDS567Location.value:=   DM.QryD840.FieldByName('Location').Value;
//
//      DM.cDS567.Post;
//      DM.cDS567.ApplyUpdates(0)  ;
//      mo_maintain_text.SetFocus;
    end;
  end;
end;

procedure TFrm_addEquipment.edt_LocationDblClick(Sender: TObject);
begin
  edt_Location.Text:='';
  edt_Location.Tag:=0;
end;

end.
