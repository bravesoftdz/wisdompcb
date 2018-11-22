unit MainUNIT1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, Grids, DBGrids, Menus, DB, ADODB,DateUtils,
  ToolWin, ComCtrls, DBCtrls, Mask, RzEdit, RzDBEdit
  ;

type
  TMainForm1 = class(TForm)
    ToolBar1: TToolBar;
    BitBtn1: TBitBtn;
    BitBtn6: TBitBtn;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    TabSheet7: TTabSheet;
    DBCheckBox_aptaxontax: TDBCheckBox;
    DataSource1: TDataSource;
    DBCheckBox_artaxontax: TDBCheckBox;
    DBCheckBox_ppc_control15: TDBCheckBox;
    DBCheckBox_custcitool: TDBCheckBox;
    DBCheckBox_custciprod: TDBCheckBox;
    DBCheckBox_suplcimat: TDBCheckBox;
    DBCheckBox_custciship: TDBCheckBox;
    DBCheckBox_ENG_CONTROL1: TDBCheckBox;
    DBCheckBox_ENG_CONTROL2: TDBCheckBox;
    DBCheckBox_ENG_CONTROL16: TDBCheckBox;
    DBCheckBox_PPC_CONTROL9: TDBCheckBox;
    Panel1: TPanel;
    Label2: TLabel;
    DBEdit_cut_l1_max: TDBEdit;
    Label1: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    DBEdit_cut_l1_min: TDBEdit;
    DBEdit_cut_w1_max: TDBEdit;
    DBEdit_cut_w1_min: TDBEdit;
    Label6: TLabel;
    DBEdit4_cut_l2_max: TDBEdit;
    DBEdit_cut_l2_min: TDBEdit;
    DBEdit_cut_w2_max: TDBEdit;
    DBEdit_cut_w2_min: TDBEdit;
    Label7: TLabel;
    DBEdit_space_l_min: TDBEdit;
    DBEdit_space_w_min: TDBEdit;
    Label8: TLabel;
    Label9: TLabel;
    DBEdit_Border_L_Min: TDBEdit;
    Label10: TLabel;
    DBEdit_Border_W_Min: TDBEdit;
    DBCheckBox_suplstamat: TDBCheckBox;
    DBCheckBox_SUPLSTAMISC: TDBCheckBox;
    DBCheckBox_custcoship: TDBCheckBox;
    Edit1: TEdit;
    Label11: TLabel;
    BitBtn2: TBitBtn;
    Label12: TLabel;
    DBCheckBox_PPC_BY_CustP: TDBCheckBox;
    DBCheckBox_PPC_CONTROL13: TDBCheckBox;
    DBCheckBox_PPC_CONTROL18: TDBCheckBox;
    DBCheckBox_PPC_CONTROL6: TDBCheckBox;
    DBCheckBox_PPC_CONTROL7: TDBCheckBox;
    DBCheckBox_PPC_CONTROL8: TDBCheckBox;
    DBCheckBox_PPC_CONTROL10: TDBCheckBox;
    DBCheckBox_PPC_control22: TDBCheckBox;
    DBCheckBox_COST_CONTROL1: TDBCheckBox;
    DBCheckBox_ppc_control12: TDBCheckBox;
    DBCheckBox_ppc_control23: TDBCheckBox;
    Label13: TLabel;
    Edit2: TEdit;
    BitBtn3: TBitBtn;
    Label14: TLabel;
    Label19: TLabel;
    DBEdit_EP000: TDBEdit;
    DBRadioGroup2: TDBRadioGroup;
    Label20: TLabel;
    Edit3: TEdit;
    BitBtn4: TBitBtn;
    Label21: TLabel;
    Label22: TLabel;
    DBEdit_SUPLFEDSHIP: TDBEdit;
    DBEdit_SUPLFEDMAT: TDBEdit;
    Label23: TLabel;
    Label24: TLabel;
    DBEdit_SUPLFEDMISC: TDBEdit;
    DBEdit_SUPLSTASHIP: TDBEdit;
    Label25: TLabel;
    LbTrans_pl: TLabel;
    CmbTrans_pl: TComboBox; //��ҽ��㷽ʽ 2008-05-27 BY ����
    Label15: TLabel;
    Label16: TLabel;
    EdtBala_days: TEdit;
    Label17: TLabel;
    DBEdt_PPC_CONTROL25: TDBEdit;
    Label18: TLabel;
    DBEdt_PPC_CONTROL26: TDBEdit;
    DBCheckBox_suplcimisc: TDBCheckBox;
    DBCheckBox1: TDBCheckBox;
    DBCheckBox2: TDBCheckBox;
    DBCheckBox3: TDBCheckBox;
    DBckCUSTCOTOOL: TDBCheckBox;
    DBCheckBox4: TDBCheckBox;
    DBRadioGroup1: TDBRadioGroup;
    DBEdit2: TDBEdit;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBCheckBox5: TDBCheckBox;
    DBCheckBox6: TDBCheckBox;
    Label30: TLabel;
    DBEdit5: TDBEdit;
    Label31: TLabel;
    Label26: TLabel;
    Label33: TLabel;
    DBCheckBox7: TDBCheckBox;
    Label34: TLabel;
    Label35: TLabel;
    Edit4: TEdit;
    Edit5: TEdit;
    BitBtn5: TBitBtn;
    BitBtn7: TBitBtn;
    Label36: TLabel;
    Label37: TLabel;
    DBEdit1: TDBEdit;
    Label38: TLabel;
    DBCheckBox8: TDBCheckBox;
    DBCheckBox9: TDBCheckBox;
    DBCheckBox10: TDBCheckBox; //��Ʒ����Ͷ�� 2008-05-27 BY ����

    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure DBEdtBALA_DAYSKeyPress(Sender: TObject; var Key: Char);
    procedure EdtBala_daysExit(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure Edit5Exit(Sender: TObject);
    procedure Edit4Exit(Sender: TObject);

  private
    { Private declarations }
    vunit_ptr,vcustfedship,vfg_scp_dept_ptr:integer; //װ�䵥������Ĭ��װ��������λ02.rkey

{    user_ptrCaption,vprevCaption,db_ptrCaption :string;
    hMapFile: THandle;
    MapFilePointer: Pointer;
}
  public
    { Public declarations }
  end;

var
  MainForm1: TMainForm1;

implementation

uses
  DmUnit1

  ,common
  ,Pick_Item_Single
  ,ConstVar


  ;

{$R *.dfm}

procedure TMainForm1.FormCreate(Sender: TObject);
begin
  if not App_Init(dm.ADOConnection1) then
  begin
    ShowMsg('������ʧ������ϵ����Ա',1);
    application.Terminate;
  end;
  Caption := application.Title;


  DateSeparator := '-';
  ShortDateFormat := 'yyyy-mm-dd';

end;

procedure TMainForm1.FormShow(Sender: TObject);
begin
  try
   if not dm.ADOConnection1.Connected then
     application.Terminate;
  except
     application.Terminate ;
  end ;
  dm.ADOQuery1.Close;
  dm.ADOQuery1.Open ;
  dm.ADOQuery1.Edit;

  CmbTrans_pl.ItemIndex:=dm.ADOQuery1.fieldbyname('trans_pl').AsInteger;
  EdtBala_days.Text:=dm.ADOQuery1.fieldbyname('BALA_DAYS').AsString;

  if not dm.ADOQuery1unit_ptr.IsNull then
      begin
          vunit_ptr := dm.ADOQuery1unit_ptr.AsInteger ;
          if dm.TemADOQuery2.Active then dm.TemADOQuery2.Close ;
          dm.TemADOQuery2.SQL.Clear ;
          dm.TemADOQuery2.SQL.Add('select RKEY,UNIT_CODE,UNIT_NAME from data0002 where rkey ='+inttostr(vunit_ptr));
          dm.TemADOQuery2.Prepared ;
          dm.TemADOQuery2.Open ;
          if not dm.TemADOQuery2.IsEmpty then
              begin
                  vunit_ptr := dm.TemADOQuery2.FieldValues['RKEY'];
                  Edit1.Text := dm.TemADOQuery2.FieldValues['UNIT_CODE'];
                  Label12.Caption := dm.TemADOQuery2.FieldValues['UNIT_NAME'];
              end ;
          dm.TemADOQuery2.Close ;
      end;

  if not dm.ADOQuery1custfedship.IsNull then
      begin
          vcustfedship := dm.ADOQuery1custfedship.AsInteger ;
          if dm.TemADOQuery2.Active then dm.TemADOQuery2.Close ;
          dm.TemADOQuery2.SQL.Clear ;
          dm.TemADOQuery2.SQL.Add('select rkey,REJ_CODE,REJECT_DESCRIPTION from data0039 where rkey ='+inttostr(vcustfedship));
          dm.TemADOQuery2.Prepared ;
          dm.TemADOQuery2.Open ;
          if not dm.TemADOQuery2.IsEmpty then
              begin
                  vcustfedship := dm.TemADOQuery2.FieldValues['RKEY'];
                  Edit2.Text := dm.TemADOQuery2.FieldValues['REJ_CODE'];
                  Label14.Caption := dm.TemADOQuery2.FieldValues['REJECT_DESCRIPTION'];
              end ;
          dm.TemADOQuery2.Close ;
      end;

  if not dm.ADOQuery1fg_scp_dept_ptr.IsNull then
      begin
          vfg_scp_dept_ptr := dm.ADOQuery1fg_scp_dept_ptr.AsInteger ;
          if dm.TemADOQuery2.Active then dm.TemADOQuery2.Close ;
          dm.TemADOQuery2.SQL.Clear ;
          dm.TemADOQuery2.SQL.Add('select RKEY,DEPT_CODE,DEPT_NAME from data0034 where rkey ='+inttostr(vfg_scp_dept_ptr));
          dm.TemADOQuery2.Prepared ;
          dm.TemADOQuery2.Open ;
          if not dm.TemADOQuery2.IsEmpty then
              begin
                  vfg_scp_dept_ptr := dm.TemADOQuery2.FieldValues['RKEY'];
                  Edit3.Text := dm.TemADOQuery2.FieldValues['DEPT_CODE'];
                  Label21.Caption := dm.TemADOQuery2.FieldValues['DEPT_NAME'];
              end ;
          dm.TemADOQuery2.Close ;
      end;
  if not dm.ADOQuery1CLOSE_HOURTH.IsNull then
      begin
          if dm.TemADOQuery2.Active then dm.TemADOQuery2.Close ;
          dm.TemADOQuery2.SQL.Clear ;
          dm.TemADOQuery2.SQL.Add('select RKEY,GROUP_NAME,GROUP_DESC from data0496 where rkey ='+
                                  dm.ADOQuery1CLOSE_HOURTH.AsString);
          dm.TemADOQuery2.Prepared ;
          dm.TemADOQuery2.Open ;
          if not dm.TemADOQuery2.IsEmpty then
              begin
                  Edit5.Text := dm.TemADOQuery2.FieldValues['GROUP_NAME'];
                  Label37.Caption := dm.TemADOQuery2.FieldValues['GROUP_DESC'];
              end ;
          dm.TemADOQuery2.Close ;
      end;
  if not dm.ADOQuery1CLOSE_DAYTH.IsNull then
      begin
          if dm.TemADOQuery2.Active then dm.TemADOQuery2.Close ;
          dm.TemADOQuery2.SQL.Clear ;
          dm.TemADOQuery2.SQL.Add('select RKEY,DEPT_CODE,DEPT_NAME from data0034 where rkey ='+
          dm.ADOQuery1CLOSE_DAYTH.AsString);
          dm.TemADOQuery2.Prepared ;
          dm.TemADOQuery2.Open ;
          if not dm.TemADOQuery2.IsEmpty then
              begin
                  Edit4.Text := dm.TemADOQuery2.FieldValues['DEPT_CODE'];
                  Label36.Caption := dm.TemADOQuery2.FieldValues['DEPT_NAME'];
              end ;
          dm.TemADOQuery2.Close ;
      end;
  PageControl1.ActivePageIndex:=0;

end;

procedure TMainForm1.BitBtn1Click(Sender: TObject);
begin
  close;
end;

procedure TMainForm1.BitBtn6Click(Sender: TObject);
begin
  if Edit1.Text = '' then
   begin
    showmessage(Label11.Caption + ' ������Ϊ��!');
    exit;
   end;
  if Edit2.Text = '' then
   begin
    showmessage(Label13.Caption + ' ������Ϊ��!');
    exit;
   end;

  if vunit_ptr <> dm.ADOQuery1unit_ptr.AsVariant then
    dm.ADOQuery1unit_ptr.Value := vunit_ptr ;
  if vcustfedship <> dm.ADOQuery1custfedship.AsVariant then
    dm.ADOQuery1custfedship.Value := vcustfedship ;
  if vfg_scp_dept_ptr <> dm.ADOQuery1fg_scp_dept_ptr.Value  then
   dm.ADOQuery1fg_scp_dept_ptr.Value:= vfg_scp_dept_ptr;
  dm.ADOQuery1.FieldByName('trans_pl').AsInteger:=CmbTrans_pl.ItemIndex;
                               //������ʼ���

  try
    dm.ADOQuery1.Post;
    showmessage('����ɹ�!');
  except
    on e :exception do
      begin
          dm.ADOConnection1.RollbackTrans ;
          showmessage(e.Message);
      end;
  end

end;

procedure TMainForm1.BitBtn2Click(Sender: TObject);
var
  InputVar: PDlgInput ;
  s:string;
  frmPick_Item_Single2 :TfrmPick_Item_Single;
begin
  frmPick_Item_Single2 := TfrmPick_Item_Single.Create(application) ;
  try
      s := 'select RKEY,UNIT_CODE,UNIT_NAME from data0002 order by unit_code';
      //frmPick_Item_Single.Height := 600;
      //frmPick_Item_Single.Width := 800;
      InputVar.Fields := 'UNIT_CODE/��λ����/200,UNIT_NAME/��λ����/200';
      //InputVar.KeyField
      InputVar.Sqlstr := s ;
      //InputVar.InPut_value
      InputVar.AdoConn := DM.ADOConnection1 ;
      frmPick_Item_Single2.InitForm_New(InputVar) ;
      if frmPick_Item_Single2.ShowModal = mrok then
       begin
        if not frmPick_Item_Single2.adsPick.IsEmpty then
         begin
          vunit_ptr := frmPick_Item_Single2.adsPick.FieldValues['RKEY'];
          Edit1.Text := frmPick_Item_Single2.adsPick.FieldValues['UNIT_CODE'];
          Label12.Caption := frmPick_Item_Single2.adsPick.FieldValues['UNIT_NAME'];
         end;
       end;
  finally
      frmPick_Item_Single2.adsPick.Close;
      frmPick_Item_Single2.Free ;
  end;
end;

procedure TMainForm1.BitBtn3Click(Sender: TObject);
var
  InputVar: PDlgInput ;
  s:string;
  frmPick_Item_Single2 :TfrmPick_Item_Single;
begin
  frmPick_Item_Single2 := TfrmPick_Item_Single.Create(application) ;
  try
      s := 'select RKEY,REJ_CODE,REJECT_DESCRIPTION from data0039 order by REJ_CODE';
      //frmPick_Item_Single.Height := 600;
      //frmPick_Item_Single.Width := 800;
      InputVar.Fields := 'REJ_CODE/ȱ�ݴ���/200,REJECT_DESCRIPTION/ȱ������/200';
      //InputVar.KeyField
      InputVar.Sqlstr := s ;
      //InputVar.InPut_value
      InputVar.AdoConn := DM.ADOConnection1 ;
      frmPick_Item_Single2.InitForm_New(InputVar) ;
      if frmPick_Item_Single2.ShowModal = mrok then
          begin
              if not frmPick_Item_Single2.adsPick.IsEmpty then
                  begin
                      vcustfedship := frmPick_Item_Single2.adsPick.FieldValues['RKEY'];
                      Edit2.Text := frmPick_Item_Single2.adsPick.FieldValues['REJ_CODE'];
                      Label14.Caption := frmPick_Item_Single2.adsPick.FieldValues['REJECT_DESCRIPTION'];
                  end;
          end;
  finally
      frmPick_Item_Single2.adsPick.Close;
      frmPick_Item_Single2.Free ;
  end;
end;

procedure TMainForm1.BitBtn4Click(Sender: TObject);
var
  InputVar: PDlgInput ;
  s:string;
  frmPick_Item_Single2 :TfrmPick_Item_Single;
begin
  try
      frmPick_Item_Single2 := TfrmPick_Item_Single.Create(application) ;
      s := 'select RKEY,DEPT_CODE,DEPT_NAME,case ttype when 1 then ''����'' when 5 then ''����'' when 4 then ''����'' end as Myttype  from data0034 where ttype in (1,4,5) order by DEPT_CODE';
      //frmPick_Item_Single.Height := 600;
      //frmPick_Item_Single.Width := 800;
      InputVar.Fields := 'DEPT_CODE/�������/200,DEPT_NAME/��������/200,Myttype/����/100';
      //InputVar.KeyField
      InputVar.Sqlstr := s ;
      //InputVar.InPut_value
      InputVar.AdoConn := DM.ADOConnection1 ;
      frmPick_Item_Single2.InitForm_New(InputVar) ;
      if frmPick_Item_Single2.ShowModal = mrok then
        begin
          if not frmPick_Item_Single2.adsPick.IsEmpty then
            begin
              vfg_scp_dept_ptr := frmPick_Item_Single2.adsPick.FieldValues['RKEY'];
              Edit3.Text := frmPick_Item_Single2.adsPick.FieldValues['DEPT_CODE'];
              Label21.Caption := frmPick_Item_Single2.adsPick.FieldValues['DEPT_NAME'];
            end;
        end;
  finally
      frmPick_Item_Single2.adsPick.Close;
      frmPick_Item_Single2.Free ;
  end;
end;

procedure TMainForm1.FormKeyPress(Sender: TObject; var Key: Char);
begin
  if key = #13 then
      begin
          key := #0;
          perform(wm_nextdlgctl,0,0);
      end;
end;

procedure TMainForm1.DBEdtBALA_DAYSKeyPress(Sender: TObject;
  var Key: Char);
begin
  if key='-' then  key:=#0;
end;

procedure TMainForm1.EdtBala_daysExit(Sender: TObject); //ֻ��������0-200��ʵ��
var
  InputValue:Double;
begin
  try
    InputValue:=strtofloat(EdtBala_days.Text);
    if (InputValue<0) then  // or (InputValue>200) then
    begin
      showmessage('���峬Ͷ���������!'+#13+#10+'���������븺���Ҳ��ܴ���200!');
      EdtBala_days.SetFocus;
      EdtBala_days.Text:=dm.ADOQuery1.fieldbyname('BALA_DAYS').AsString;
      EdtBala_days.SelectAll;
      exit;
    end;
    dm.ADOQuery1.Edit;
    dm.ADOQuery1.FieldByName('BALA_DAYS').AsVariant:=InputValue;
  except
    showmessage('���峬Ͷ�������������!'+#13+#10+'��������ȷ����ֵ!');
    EdtBala_days.SetFocus;
    EdtBala_days.Text:=dm.ADOQuery1.fieldbyname('BALA_DAYS').AsString;
    EdtBala_days.SelectAll;
  end;
end;

procedure TMainForm1.BitBtn7Click(Sender: TObject);
var
  InputVar: PDlgInput ;
  s:string;
  frmPick_Item_Single2 :TfrmPick_Item_Single;
begin
    frmPick_Item_Single2 := TfrmPick_Item_Single.Create(application) ;
  try
      s := 'select RKEY,GROUP_NAME,GROUP_DESC from data0496 order by GROUP_NAME';

      InputVar.Fields := 'GROUP_NAME/����������/200,GROUP_DESC/�����������/200';
      InputVar.KeyField :='group_name';
      InputVar.Sqlstr := s ;
      InputVar.InPut_value:=Edit5.Text;
      InputVar.AdoConn := DM.ADOConnection1 ;
      frmPick_Item_Single2.InitForm_New(InputVar) ;
      if frmPick_Item_Single2.ShowModal = mrok then
          begin
            if not frmPick_Item_Single2.adsPick.IsEmpty then
              begin
                dm.ADOQuery1CLOSE_HOURTH.Value
                := frmPick_Item_Single2.adsPick.FieldValues['RKEY'];
                Edit5.Text := frmPick_Item_Single2.adsPick.FieldValues['GROUP_NAME'];
                Label37.Caption := frmPick_Item_Single2.adsPick.FieldValues['GROUP_DESC'];
              end;
          end;
  finally
      frmPick_Item_Single2.adsPick.Close;
      frmPick_Item_Single2.Free ;
  end;
end;

procedure TMainForm1.BitBtn5Click(Sender: TObject);
var
  InputVar: PDlgInput ;
  s:string;
  frmPick_Item_Single2 :TfrmPick_Item_Single;
begin
   frmPick_Item_Single2 := TfrmPick_Item_Single.Create(application) ;
  try
    s := 'select RKEY,DEPT_CODE,DEPT_NAME,case ACTIVE_FLAG '+
    'when 0 then ''��'' when 1 then ''��Ч'' end as ACTIVEFLAG,'+
    'case IS_COST_DEPT when 1 then ''Y'' when 0 then ''N'' end as ISCOSTDEPT '+
    'from data0034 where  (ACTIVE_FLAG = 0) AND (IS_COST_DEPT = 1) ';

     InputVar.Fields := 'DEPT_CODE/�������/150,DEPT_NAME/��������/150,'+
      'ISCOSTDEPT/�ɱ�����/100,ACTIVEFLAG/�Ƿ���Ч/100';
      
      InputVar.Sqlstr := s ;
      InputVar.KeyField:='dept_code';
      InputVar.InPut_value:=Edit4.Text;

      InputVar.AdoConn := DM.ADOConnection1 ;
      frmPick_Item_Single2.InitForm_New(InputVar) ;
      if frmPick_Item_Single2.ShowModal = mrok then
        begin
          if not frmPick_Item_Single2.adsPick.IsEmpty then
            begin
              dm.ADOQuery1CLOSE_DAYTH.Value:=
                 frmPick_Item_Single2.adsPick.FieldValues['RKEY'];
              Edit4.Text := frmPick_Item_Single2.adsPick.FieldValues['DEPT_CODE'];
              Label36.Caption := frmPick_Item_Single2.adsPick.FieldValues['DEPT_NAME'];
            end;
        end;
  finally
   frmPick_Item_Single2.adsPick.Close;
   frmPick_Item_Single2.Free ;
  end;
end;


procedure TMainForm1.Edit5Exit(Sender: TObject);
begin
 if trim(edit5.Text)<>'' then
  with dm.TemADOQuery2 do
   begin
    close;
    sql.Text:='select rkey,GROUP_NAME,GROUP_DESC from data0496'+#13+
             'where GROUP_NAME='''+trim(edit5.Text)+'''';
    open;
   if IsEmpty then
    begin
     messagedlg('���ϱ����������!!',mterror,[mbcancel],0);
     edit5.SetFocus;
    end
   else
    if FieldValues['rkey']<>dm.ADOQuery1CLOSE_HOURTH.Value then
    begin
     label37.Caption:=FieldValues['GROUP_DESC'];
     dm.ADOQuery1CLOSE_HOURTH.Value:=FieldValues['rkey'];
    end;
   end
 else
  begin
     label37.Caption:='';
     dm.ADOQuery1CLOSE_HOURTH.AsVariant:=null;
  end;
end ;


procedure TMainForm1.Edit4Exit(Sender: TObject);
begin
 if trim(edit4.Text)<>'' then
  with dm.TemADOQuery2 do
   begin
    close;
    sql.Text:='select rkey,DEPT_CODE,DEPT_NAME ,case ACTIVE_FLAG '+
    'when 0 then ''��'' when 1 then ''��Ч'' end as ACTIVEFLAG,'+
    'case IS_COST_DEPT when 1 then ''Y'' when 0 then ''N'' end as ISCOSTDEPT from data0034'+#13+
             'where DEPT_CODE='''+trim(edit4.Text)+''''+
             ' and (ACTIVE_FLAG = 0) AND (IS_COST_DEPT = 1) ';
    open;

   if IsEmpty then
    begin
     messagedlg('���ϱ����������!!',mterror,[mbcancel],0);
     edit4.SetFocus;
    end
   else
    if FieldValues['rkey']<>dm.ADOQuery1CLOSE_DAYTH.Value then
    begin
     Label36.Caption:=FieldValues['DEPT_NAME'];
     dm.ADOQuery1CLOSE_DAYTH.Value:=FieldValues['rkey'];
    end;
   end
 else
  begin
    label36.Caption:='';
    dm.ADOQuery1CLOSE_DAYTH.AsVariant:=null;
  end;
end;

end.
