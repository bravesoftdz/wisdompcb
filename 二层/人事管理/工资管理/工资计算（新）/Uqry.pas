unit Uqry;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, Grids, StdCtrls, ComCtrls, Buttons, ExtCtrls,ConstVar,DateUtils;


type
  TFrmQry = class(TForm)
    Label3: TLabel;
    GroupBox6: TGroupBox;
    lbl_field: TLabel;
    lbl_f: TLabel;
    lbl_t: TLabel;
    rg_sign: TRadioGroup;
    rg_condi: TRadioGroup;
    rg_yesno: TRadioGroup;
    edtValue: TEdit;
    btn_add: TButton;
    lst_fields: TListBox;
    StaticText7: TStaticText;
    btn_del: TButton;
    dtp_f: TDateTimePicker;
    cbb_rank: TComboBox;
    btn_qry: TBitBtn;
    StaticText2: TStaticText;
    sg1: TStringGrid;
    dtp1: TDateTimePicker;
    dtp2: TDateTimePicker;
    btn_OK: TButton;
    btn_cancel: TButton;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    procedure FormShow(Sender: TObject);
    procedure btn_qryClick(Sender: TObject);
    procedure lst_fieldsClick(Sender: TObject);
    procedure btn_delClick(Sender: TObject);
    procedure btn_cancelClick(Sender: TObject);
    procedure btn_addClick(Sender: TObject);
    procedure rg_signClick(Sender: TObject);
    procedure N1Click(Sender: TObject);
  private
    { Private declarations }
     v_Field_List_CN,v_Field_List_EN:Variant;
    procedure  updateSG(sgrid_row: integer);

  public
    { Public declarations }
  end;

var
  FrmQry: TFrmQry;

implementation

uses  udm,common,Pick_Item_Single;

{$R *.dfm}


procedure TFrmQry.FormShow(Sender: TObject);
var i:integer;
ssql: string;
begin

   dtp_f.Date:=Now;
   dtp1.Date:=StartOfTheMonth(Now);
   dtp2.Date:=endoftheMonth(now);

 lst_fields.Items.Clear;
  v_Field_List_CN := VarArrayOf(['����',
  '����','ְ��','����','��ְ����','��ְ����',
   '��ֵ����','���','�Ƿ���ְ']);
  v_Field_List_EN := VarArrayOf(['d.item',
  'b.departmentid',
  'e.item','b.chinesename','b.ondutytime',
  'b.outdutytime','a.can_change_flag','a.ischecked','b.status']);
  for i:= VarArrayLowBound(v_Field_List_CN,1)
  to VarArrayHighBound(v_Field_List_CN,1) do
    lst_fields.Items.Add(v_Field_List_CN[i]);
  sg1.Cells[0,0]:='������';
  sg1.Cells[1,0]:='����ֵ';
  lst_fields.ItemIndex := 0;

   Self.cbb_rank.Items.Clear;
     try
       ssql:='SELECT   rkey, dictid, item '+
           ' FROM  dbo.datadetail WHERE dictid = 2 '+#13;
       dm.OpenQry(DM.qry_temp,ssql);

        if not dm.qry_temp.IsEmpty then
        begin
          DM.qry_temp.first;
          while not DM.qry_temp.Eof do
          begin
                cbb_rank.Items.AddObject(DM.qry_temp.FieldByName('item').AsString,TObject(DM.qry_temp.FieldByName('rkey').AsString));
                DM.qry_temp.Next;
          end;
         end;

       except on e:exception do
       begin
       ShowMessage('����'+e.Message);
       exit;
       end;
      end;


        dtp_f.DateTime := now;

    lst_fieldsClick(nil);
end;

procedure TFrmQry.btn_qryClick(Sender: TObject);
var
  InputVar: PDlgInput ;
begin
    try

   frmpick_item_single:=Tfrmpick_item_single.Create(application);

    case lst_fields.ItemIndex  of

    1://����
     begin
      InputVar.Fields := 'departmentname/����/400';
      InputVar.Sqlstr := ' select  rkey,departmentname, dbo.get_departments(rkey)as departmentstring  from datadepartment';
      inputvar.KeyField:='departmentname';
      InputVar.AdoConn := DM.con1;
      frmPick_Item_Single.InitForm_New(InputVar);

      if frmPick_Item_Single.ShowModal=mrok then
      begin
        edtValue.Tag :=  frmPick_Item_Single.adsPick.FieldValues['RKEY'];
        edtValue.Text := frmPick_Item_Single.adsPick.FieldValues['departmentname'];
        label3.Caption := frmPick_Item_Single.adsPick.FieldValues['departmentstring'];   //�ò��ŵ�������������
      end;
     end;

    2://ְ��:
      begin
      InputVar.Fields := 'item/ְ��/400';
      InputVar.Sqlstr :='select rkey,item  from datadetail  where dictid=2';
      inputvar.KeyField:='item';
      InputVar.AdoConn := DM.con1;
      frmPick_Item_Single.InitForm_New(InputVar);
      if frmPick_Item_Single.ShowModal=mrok then
      begin
        edtValue.Tag :=  frmPick_Item_Single.adsPick.FieldValues['RKEY'];
        edtValue.Text := frmPick_Item_Single.adsPick.FieldValues['item'];
      end;
      end;
    3: //����:
      begin
      InputVar.Fields := 'chineseName/����/200,employeecode/����/200';
      InputVar.Sqlstr :='select rkey,  employeecode,chineseName    from employeemsg ';
      inputvar.KeyField:='chineseName';
      InputVar.AdoConn := DM.con1;
      frmPick_Item_Single.InitForm_New(InputVar);
      if frmPick_Item_Single.ShowModal=mrok then
      begin
        edtValue.Tag :=  frmPick_Item_Single.adsPick.FieldValues['rkey'];
        edtValue.Text := frmPick_Item_Single.adsPick.FieldValues['chineseName'];
      end;
      end;

   end;
  finally
    frmPick_Item_Single.adsPick.Close;
    frmPick_Item_Single.Free ;
  end;

end;

procedure TFrmQry.lst_fieldsClick(Sender: TObject);
begin
  lbl_field.Caption:=' '+lst_fields.Items[lst_fields.itemindex]+':  ';
  edtValue.Text:='';

  edtValue.Visible := false;
  btn_qry.Visible := False;
  cbb_rank.Visible := False;
  dtp_f.Visible := False;
  dtp1.Visible:=false;
  dtp2.Visible:=false;
  rg_sign.Visible := False;
  rg_condi.Visible := False;
  rg_yesno.Visible := False;
  lbl_f.Visible:=false;
  lbl_t.Visible:=false;

  if lst_fields.ItemIndex = 0 then   //����//
  begin
    cbb_rank.Visible:=true;
  end;
  if lst_fields.ItemIndex in  [1,2,3] then    //���� ��ְ������
  begin
      btn_qry.Visible:=True;
      edtValue.Visible:=true;
      rg_condi.Visible:=true;
  end;
    
  if lst_fields.ItemIndex in [4,5] then
  begin
    dtp_f.Visible:=true;
   // dtp1.Visible:=true;
   // dtp2.Visible:=true;
    lbl_f.Visible:=true;
    lbl_t.Visible:=true;
    dtp1.Visible:=true;
    dtp2.Visible:=true;
    rg_sign.Visible:=true;
    rg_sign.ItemIndex:=3;
  end;
  if lst_fields.ItemIndex in [6,7,8] then
  begin
    rg_yesno.Visible:=true;
  end;
end;

procedure TFrmQry.btn_delClick(Sender: TObject);
var i :integer;
begin
 
 for i:=1 to sg1.RowCount-2 do
 sg1.Rows[i].Clear;
 sg1.RowCount:=2;

end;

procedure TFrmQry.btn_cancelClick(Sender: TObject);
begin
close;
end;

procedure TFrmQry.btn_addClick(Sender: TObject);
var
  i:integer;
begin
  //����ǲ������м���sgrid1�е����ݣ�û�о�����
  for i:=1 to sg1.RowCount-2 do
     if (sg1.Cells[0,i]=lst_fields.Items[lst_fields.ItemIndex]) and
        (sg1.Cells[1,i]<>lst_fields.Items[lst_fields.ItemIndex]) then
         begin
             updateSG(i);
             exit;
         end;
  //����0�м�¼
  sg1.Cells[0,sg1.RowCount-1]:=lst_fields.Items[lst_fields.itemindex];
  updateSG(sg1.RowCount-1);
  //����һ�пյļ�¼
  sg1.RowCount :=sg1.RowCount +1;

end;

procedure  TFrmQry.updateSG(sgrid_row: integer);
begin
  sg1.Cells[0,sgrid_row]:=lst_fields.Items[lst_fields.itemindex];
  case lst_fields.ItemIndex of
 0:    //����
  begin
        sg1.Cells[1,sgrid_row]:=trim(cbb_rank.Text);
        case rg_condi.ItemIndex of
        0:sg1.Cells[2,sgrid_row]:='and d.item = '''+trim(cbb_rank.Text)+'''';
        1:sg1.Cells[2,sgrid_row]:='and d.item like ''%'+trim(cbb_rank.Text)+'%''';
        end;
   end;
 1:   //����
  begin
        sg1.Cells[1,sgrid_row]:=trim(edtValue.Text);
        case rg_condi.ItemIndex of
        0:sg1.Cells[2,sgrid_row]:='and b.departmentid = '''+inttostr(edtValue.tag)+'''';
        1:sg1.Cells[2,sgrid_row]:='and b.departmentid in '+label3.Caption;
        end;
  end;

  2:  //ְ��
   begin
        sg1.Cells[1,sgrid_row]:=trim(edtValue.Text);
        case rg_condi.ItemIndex of
        0:sg1.Cells[2,sgrid_row]:='and e.item = '''+edtValue.Text+'''';
        1:sg1.Cells[2,sgrid_row]:='and e.item like ''%'+edtValue.Text+'%''';
        end;
    end;
 3:  //��������
  begin
        sg1.Cells[1,sgrid_row]:=trim(edtValue.Text);
        case rg_condi.ItemIndex of
        0:sg1.Cells[2,sgrid_row]:='and b.chinesename = '''+edtValue.Text+'''';
        1:sg1.Cells[2,sgrid_row]:='and b.chinesename like ''%'+edtValue.Text+'%''';
        end;
    end;
 4:  //��ְ����
 begin
      if rg_sign.ItemIndex = 3 then
      sg1.Cells[1,sgrid_row]:='��'+DateToStr(dtp1.Date)+'��'+DateToStr(dtp2.Date)
      else
      sg1.Cells[1,sgrid_row]:=rg_sign.Items.Strings[rg_sign.ItemIndex]+DateToStr(dtp_f.Date);
      case rg_sign.ItemIndex of
      0:sg1.Cells[2,sgrid_row]:='and replace(convert(char(10),b.ondutytime,111),'+#39+'/'+#39+','+#39+'-'+#39+')  = '''+formatdatetime('yyyy-mm-dd',dtp_f.Date)+'''';
      1:sg1.Cells[2,sgrid_row]:='and replace(convert(char(10),b.ondutytime,111),'+#39+'/'+#39+','+#39+'-'+#39+')  > '''+formatdatetime('yyyy-mm-dd',dtp_f.Date)+'''';
      2:sg1.Cells[2,sgrid_row]:='and replace(convert(char(10),b.ondutytime,111),'+#39+'/'+#39+','+#39+'-'+#39+')  < '''+formatdatetime('yyyy-mm-dd',dtp_f.Date)+'''';
      3:sg1.Cells[2,sgrid_row]:='and replace(convert(char(10),b.ondutytime,111),'+#39+'/'+#39+','+#39+'-'+#39+')  between '''+formatdatetime('yyyy-mm-dd',dtp1.Date)+''' and '''+formatdatetime('yyyy-mm-dd',dtp2.Date)+''' ';
      end;
    end;
 5:  //��ְ����
 begin
      if rg_sign.ItemIndex = 3 then
      sg1.Cells[1,sgrid_row]:='��'+DateToStr(dtp1.Date)+'��'+DateToStr(dtp2.Date)
      else
      sg1.Cells[1,sgrid_row]:=rg_sign.Items.Strings[rg_sign.ItemIndex]+DateToStr(dtp_f.Date);
      case rg_sign.ItemIndex of
      0:sg1.Cells[2,sgrid_row]:='and  replace(convert(char(10),b.outdutytime,111),'+#39+'/'+#39+','+#39+'-'+#39+')  = '''+formatdatetime('yyyy-mm-dd',dtp_f.Date)+'''';
      1:sg1.Cells[2,sgrid_row]:='and replace(convert(char(10),b.outdutytime,111),'+#39+'/'+#39+','+#39+'-'+#39+')  > '''+formatdatetime('yyyy-mm-dd',dtp_f.Date)+'''';
      2:sg1.Cells[2,sgrid_row]:='and replace(convert(char(10),b.outdutytime,111),'+#39+'/'+#39+','+#39+'-'+#39+')  < '''+formatdatetime('yyyy-mm-dd',dtp_f.Date)+'''';
      3:sg1.Cells[2,sgrid_row]:='and replace(convert(char(10),b.outdutytime,111),'+#39+'/'+#39+','+#39+'-'+#39+')  between '''+formatdatetime('yyyy-mm-dd',dtp1.Date)+''' and '''+formatdatetime('yyyy-mm-dd',dtp2.Date)+'''';
      end;
    end;
 6: //��ֵ��
    begin
          sg1.Cells[1,sgrid_row]:= rg_yesno.Items[rg_yesno.ItemIndex];
          sg1.Cells[2,sgrid_row]:='and a.can_change_flag = '''+inttostr((Self.rg_yesno.ItemIndex+1) mod 2)+'''';
    end;
 7: //�����
    begin
          sg1.Cells[1,sgrid_row]:= rg_yesno.Items[rg_yesno.ItemIndex];
          sg1.Cells[2,sgrid_row]:='and a.ischecked = '''+inttostr((Self.rg_yesno.ItemIndex+1) mod 2)+'''';
    end;
 8: //�Ƿ���ְ
    begin
          sg1.Cells[1,sgrid_row]:= rg_yesno.Items[rg_yesno.ItemIndex];
          sg1.Cells[2,sgrid_row]:='and b.status = '''+inttostr(Self.rg_yesno.ItemIndex+1)+'''';
    end;

 end;  //end case
end;


procedure TFrmQry.rg_signClick(Sender: TObject);
begin
   case rg_sign.ItemIndex of
0,1,2:
  begin
   dtp1.Visible := false;
   dtp2.Visible := false;
   lbl_f.Visible := false;
   lbl_t.Visible := false;
  end;
3:
  begin
  dtp1.Visible := true;
   dtp2.Visible := true;
   lbl_f.Visible := true;
   lbl_t.Visible := true;
   dtp_f.Visible:=False;
  end;
end;
end;
             //del
procedure TFrmQry.N1Click(Sender: TObject);
var i :integer;
begin
  if sg1.RowCount <= 2 then exit;
  for i:=sg1.Row to sg1.RowCount-2 do sg1.Rows[i].Text:=sg1.Rows[i+1].Text;
  sg1.RowCount:=sg1.RowCount-1;
end;

end.
