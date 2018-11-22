unit detail;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, DBCtrls, Mask,ADODB,DB,Math;

type
  Tdetail_form = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
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
    Bevel1: TBevel;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    DBCheckBox1: TDBCheckBox;
    DBCheckBox2: TDBCheckBox;
    Label17: TLabel;
    DBEdit1: TDBEdit;
    DBEdit2: TDBEdit;
    DBEdit3: TDBEdit;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    DBEdit7: TDBEdit;
    DBEdit8: TDBEdit;
    DBEdit9: TDBEdit;
    DBEdit10: TDBEdit;
    MaskEdit1: TMaskEdit;
    MaskEdit2: TMaskEdit;
    Edit1: TEdit;
    ComboBox1: TComboBox;
    ComboBox2: TComboBox;
    ComboBox3: TComboBox;
    MaskEdit3: TMaskEdit;
    BitBtn3: TBitBtn;
    Label18: TLabel;
    BitBtn4: TBitBtn;
    procedure BitBtn3Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormActivate(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure DBCheckBox1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
    procedure Edit1Exit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn4Click(Sender: TObject);
  private
    { Private declarations }
    v_close:byte; //���Ʊ��������Ƿ������˳�
    procedure update_04(v_seed: string);  //���¿��Ʊ���
    function check_before_save:boolean;   //����ǰ���
  public
    { Public declarations }
    dept_ptr:integer;  //����ָ��
    procedure ready_new;  //����ǰ׼������
  end;

var
  detail_form: Tdetail_form;

implementation
uses main,common,damo,pick_item_single,constvar, empl;

{$R *.dfm}

procedure Tdetail_form.ready_new;
begin
  dm.ads05.Append;
  dm.ads05active_flag.value:='Y';
  dm.ads05buyer_flag.value:='N';
  edit1.Text:='';
  label18.Caption:='';
  combobox1.ItemIndex:=0;
  combobox2.Text:='';
  combobox3.Text:='';
  maskedit2.Text:='';
end;

function Tdetail_form.check_before_save:boolean;
begin
  result:=true;
  dm.aq04.Close;
  dm.aq04.Open;
  if (dm.aq04.FieldValues['seed_flag']<>1) and (not (maskedit1.Text[length(trim(maskedit1.Text))] in ['0'..'9'])) then
  begin
    showmessage('��Ա���������һλ����Ϊ������');
    maskedit1.SetFocus;
    result:=false;
    exit;
  end;
  dm.aq04.Close;

  if trim(maskedit1.Text)='' then
  begin
    showmessage('��Ա���벻����Ϊ�գ�');
    maskedit1.SetFocus;
    result:=false;
    exit;
  end;

  if trim(dbedit1.Text)='' then
  begin
    showmessage('��Ա����������Ϊ�գ�');
    dbedit1.SetFocus;
    result:=false;
    exit;
  end;

  if trim(dbedit2.Text)='' then
  begin
    showmessage('������д������Ϊ�գ�');
    dbedit2.SetFocus;
    result:=false;
    exit;
  end;

  if trim(edit1.Text)='' then
  begin
    showmessage('��Ա���Ų�����Ϊ�գ�');
    edit1.SetFocus;
    result:=false;
    exit;
  end;
end;

procedure Tdetail_form.update_04(v_seed: string);
var
  i,v_length:integer;
  v_last,new_seed:string;
begin
  v_length := length(v_seed);
  for i := v_length downto 1 do
  begin
    if not (v_seed[i] in ['0'..'9']) then   //�����������
     begin
      v_last := floattostr(power(10,v_length-1)+strtofloat(copy(v_seed,i+1,v_length-i))+1); //��׺��1
      new_seed := copy(v_seed,1,i)+copy(v_last,i+1,v_length-i);
      dm.aq04.Edit; //ʹǰ׺�����׺��1
      dm.aq04SEED_VALUE.Value := new_seed;
      dm.aq04.Post;
      exit;
     end;

    if (i=1) then //�����һλ��Ȼ������
    begin 
     v_last := floattostr(power(10,v_length)+strtofloat(v_seed)+1);
     new_seed := copy(v_last,2,v_length);
     dm.aq04.Edit;
     dm.aq04SEED_VALUE.Value := new_seed;
     dm.aq04.Post;
    end;
  end;
end;

procedure Tdetail_form.BitBtn3Click(Sender: TObject);
var inputvar: PDlgInput;
begin
  frmpick_item_single:=Tfrmpick_item_single.Create(application);
  try
    inputvar.Fields:='dept_code/���Ŵ���/130,dept_name/��������/240,ctype/����/100';
    inputvar.Sqlstr:='select rkey,dept_code,dept_name, '+
                     'CASE ttype WHEN 4 THEN ''��������'' '+
          'WHEN 5 THEN ''��������'' ELSE ''��������'' END AS ctype '+
          'from data0034 where (ttype=4) '+
          'or ((IS_cost_dept = 1) and (COST_DEPT_PTR=RKEY))'+
          'order by ttype,dept_code';
    inputvar.InPut_value:=edit1.Text;
    inputvar.KeyField:='dept_code';
    inputvar.AdoConn:=dm.ADOConnection1;
    frmpick_item_single.InitForm_New(inputvar); //��ʼ������
    if frmpick_item_single.ShowModal=mrok then
     begin
      edit1.Text:=trim(frmpick_item_single.adsPick.FieldValues['dept_code']);
      label18.Caption:=trim(frmpick_item_single.adsPick.FieldValues['dept_name']);
      dept_ptr:=frmpick_item_single.adsPick.FieldValues['rkey']; //��ò��ŵ�rkeyֵ
     end
    else
     edit1.SetFocus;
  finally
    frmpick_item_single.adsPick.Close;
    frmpick_item_single.Free;
  end;
end;

procedure Tdetail_form.FormCloseQuery(Sender: TObject;var CanClose: Boolean);
begin
  if v_close<>1 then dm.ads05.Cancel;
end;

procedure Tdetail_form.FormActivate(Sender: TObject);
begin
  v_close:=0; //�Ƿ������˳�Ĭ��Ϊ0(�������˳�)
  combobox1.ItemIndex:=dm.ads05popedom.Value;
  if dm.ads05gender.Value='��' then combobox2.ItemIndex:=0;
  if dm.ads05gender.Value='Ů' then combobox2.ItemIndex:=1;
  combobox3.Text:=dm.ads05school_age.Value;
  if not dm.ads05born.IsNull then
    maskedit2.Text:=formatdatetime('YYYY-MM-DD',dm.ads05born.value)
  else
    maskedit2.Text:='';
  if not dbcheckbox1.Checked then
    maskedit3.Text:=formatdatetime('YYYY-MM-DD',dm.ads05INACTIVE_DATE.Value)
  else
   maskedit3.Text:='';
end;

procedure Tdetail_form.FormShow(Sender: TObject);
begin
  dm.aq04.Open;
  if dm.ads05.State=dsedit then //�༭״̬
  with dm.aq34 do
  begin
    maskedit1.Text:=dm.ads05EMPL_CODE.Value;
    close;
    parameters[0].Value:=dm.ads05employee_id.Value;
    open;
    detail_form.Edit1.Text:=dm.aq34dept_code.Value;
    detail_form.label18.Caption:=dm.aq34dept_name.Value;
    dept_ptr:=dm.aq34RKEY.Value;
  end
  else
  with dm.aq04 do //����״̬(�����½��͸���)
  if FieldValues['seed_flag']<>1 then  //��04�ж�ȡ������
   begin
    maskedit1.text := trim(Fieldvalues['seed_value']);
    if FieldValues['seed_flag']=4 then
     maskedit1.Enabled := false
    else
     maskedit1.SetFocus;
   end
  else
   begin
    maskedit1.Text := '';
    maskedit1.SetFocus;
   end;  //seed_flag=1��ȫ�ֹ�������
  dm.aq04.Close;
end;

procedure Tdetail_form.BitBtn2Click(Sender: TObject);
begin
  if dm.ads05.State=dsinsert then dm.ads05.Cancel; //����ǲ��������
  if dm.ads05.Modified then  //��������޸���ʾ�Ƿ񱣴�
    if messagedlg('�����Ѿ����ģ��Ƿ�Ҫ���̣�',mtconfirmation,[mbyes,mbno],0)=mryes then
      bitbtn1click(sender)
    else dm.ads05.Cancel;
  v_close:=1;
  close;
end;

procedure Tdetail_form.BitBtn1Click(Sender: TObject);
begin
  if check_before_save then
  begin
    if not dbcheckbox1.Checked then dm.ads05inactive_date.AsString:=maskedit3.Text
    else dm.ads05inactive_date.AsVariant:=null; //���¼����û�����ղ������
    if maskedit2.Text>='1900-01-01' then dm.ads05born.AsString:=maskedit2.Text
    else dm.ads05born.AsVariant:=null; //����δ�����������ʱ��������
    dm.ads05gender.AsString:=trim(combobox2.Text);
    dm.ads05school_age.AsString:=trim(combobox3.Text);
    dm.ads05empl_code.Value:=maskedit1.Text;
    dm.ads05popedom.Value:=combobox1.ItemIndex; //�г�ְλ����combobox1������ֵ
    dm.ads05employee_id.value:=dept_ptr;
    dm.ads05LAST_UPDT.Value:=common.getsystem_date(dm.aqtmp,0);

    if dm.ads05.State=dsinsert then //����״̬
    begin
      dm.ads05comein_date.Value:=getsystem_date(dm.aqtmp,1);
      dm.ads05.Post;
      mainform.bk:=dm.ads05.GetBookmark(); //�õ��±�ǩ
      dm.aq04.Close;
      dm.aq04.Open;
      if dm.aq04SEED_FLAG.Value<>1 then
         self.update_04(dm.aq04SEED_VALUE.Value); //����04�еĿ�����

      if mainform.is_new then  //������½������Ǹ�������������
      begin
        ready_new;
        if dm.aq04seed_flag.Value<>1 then
        begin
          maskedit1.Text := trim(dm.aq04seed_value.AsString);
          dbedit1.SetFocus;
        end
        else begin maskedit1.Text := ''; maskedit1.SetFocus; end; //����ʵ��������½�����������
      end
      else begin v_close:=1; close; end; //����Ǹ����򱣴�������˳�
      dm.aq04.Close;
    end

    else begin dm.ads05.Post; v_close:=1; close; end; //�༭״̬�����˳�
  end;
end;

procedure Tdetail_form.DBCheckBox1Click(Sender: TObject);
begin
  label17.Enabled:=not label17.Enabled;
  if dbcheckbox1.Checked then
  begin
    maskedit3.Text:='';
    maskedit3.Enabled:=false;
  end
  else
  begin
    maskedit3.Text:=datetostr(date());
    maskedit3.Enabled:=true;
  end;
end;

procedure Tdetail_form.FormCreate(Sender: TObject);
begin
  KeyPreview:=true; //ģ�ⰴ��
end;

procedure Tdetail_form.FormKeyDown(Sender: TObject; var Key: Word;Shift: TShiftState);
begin
  if key=vk_return then perform(WM_NEXTDLGCTL,0,0); //���س�����Զ�����
end;

procedure Tdetail_form.Edit1Exit(Sender: TObject);
begin
  if trim(edit1.Text)<>'' then
  with dm.aqtmp do
  begin
    sql.Clear;
    sql.Add('select rkey,dept_code,dept_name from data0034 where dept_code='''+trim(edit1.Text)+'''');// )quotedstr(tmpstr));
    open;
    if not isempty then
    begin
      label18.Caption:=fieldbyname('dept_name').AsString;
      dept_ptr:=fieldbyname('rkey').AsInteger;
    end
    else
    begin
      showmessage('���Ŵ�������������������룡');
      edit1.Text:='';
      edit1.SetFocus;
    end;
    close;
  end
end;

procedure Tdetail_form.FormClose(Sender: TObject;var Action: TCloseAction);
begin
  maskedit1.EditMask:='';
  mainform.Show;
end;

procedure Tdetail_form.BitBtn4Click(Sender: TObject);
begin 
    empl_search:=Templ_search.Create(application);
    if empl_search.ShowModal=mrok then
  begin
    MaskEdit1.Text:=empl_search.ADOQuery1employeecode.Value;
    DBEdit1.Text:=empl_search.ADOQuery1chinesename.Value;
    DBEdit2.Text:=empl_search.ADOQuery1employeecode.Value;
  end;
   empl_search.Free;
 end; 
end.
