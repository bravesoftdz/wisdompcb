unit add_po;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Mask, ExtCtrls;

type
  TForm2 = class(TForm)
    Label1: TLabel;
    Edit1: TEdit;
    BitBtn1: TBitBtn;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Edit2: TEdit;
    Edit3: TEdit;
    BitBtn2: TBitBtn;
    BitBtn3: TBitBtn;
    Label5: TLabel;
    Label6: TLabel;
    Button1: TButton;
    Button2: TButton;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    MaskEdit1: TMaskEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    rkey17: TLabel;
    avl_flag: TLabel;
    rkey23: TLabel;
    rkey15: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    rkey02: TLabel;
    rkey01: TLabel;
    Label14: TLabel;
    Edit8: TEdit;
    rkey103: TLabel;
    edit9: TComboBox;
    Label15: TLabel;
    Label16: TLabel;
    Edit10: TEdit;
    Label18: TLabel;
    Label19: TLabel;
    Edit11: TEdit;
    BitBtn4: TBitBtn;
    RadioGroup1: TRadioGroup;
    Label17: TLabel;
    procedure Edit1Click(Sender: TObject);
    procedure change_color(v_comp: TEdit);
    procedure Edit3Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure Edit4KeyPress(Sender: TObject; var Key: Char);
    procedure Edit4Exit(Sender: TObject);
    procedure Edit4KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit5Exit(Sender: TObject);
    procedure Edit6KeyPress(Sender: TObject; var Key: Char);
    procedure Edit6Exit(Sender: TObject);
    procedure save_inv();
    procedure Edit3Exit(Sender: TObject);
    procedure Edit1Exit(Sender: TObject);
    procedure Edit8KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Button1Click(Sender: TObject);
    procedure active_inv();
    procedure Edit6Click(Sender: TObject);
    procedure Edit7Click(Sender: TObject);
    procedure Edit7KeyPress(Sender: TObject; var Key: Char);
    procedure Edit7Exit(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Edit11Click(Sender: TObject);
    procedure Edit11Exit(Sender: TObject);
    procedure BitBtn4MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure BitBtn4Exit(Sender: TObject);
    procedure MaskEdit1Exit(Sender: TObject);
  private
    { Private declarations }

  public
    { Public declarations }
   add_new_type:byte;
  end;

var
  Form2: TForm2;

implementation

uses inv_search,damo, supp_price_search, warehouse_search, 
  supp_search, Unit_search;

{$R *.dfm}

procedure TForm2.Edit1Click(Sender: TObject);
begin
 change_color(edit1);
end;

procedure TForm2.change_color(v_comp: TEdit);
begin
 IF v_comp.Font.Color=clwindowtext then
  begin
   v_comp.Font.Color := clblue;
   v_comp.SelectAll;
  end;
end;

procedure TForm2.Edit3Click(Sender: TObject);
begin
 change_color(edit3);
end;

procedure TForm2.BitBtn1Click(Sender: TObject);
begin
 try
  form_inv:=tform_inv.Create(application);
  active_inv;
//========================================================================
  form_inv.Edit1.Text := trim(edit1.Text);
  if form_inv.ADOQuery1.IsEmpty then
   begin
    messagedlg('没有找到相关记录!',mtinformation,[mbcancel],0);
    edit1.SetFocus;
   end
  else
  if form_inv.ShowModal=mrok then
   if bitbtn2.Enabled=true then    //如果是全新新增
    begin
     self.save_inv();
     if (activecontrol.Name='BitBtn1')  then
      bitbtn2.SetFocus;
    end
   else                             //如果在确定供应商的前题下新增
    begin
     with dm.ADOQuery1 do
      begin
       active:=false;
       sql.Clear;
       sql.Add('select rkey from data0018');
       sql.Add('where invent_ptr='+form_inv.ADOQuery1RKEY.AsString);
       sql.Add('and whouse_ptr='+rkey15.Caption);
       active:=true;
       if IsEmpty then //如果该仓库没有这个原材料
       begin
        messagedlg('材料:'+trim(form_inv.ADOQuery1INV_PART_NUMBER.Value)+'没有在仓库:'+Edit3.Text+'中定义',
        mterror,[mbcancel],0);
        edit1.SetFocus;
        exit;
       end;
      end;
     if form_inv.ADOQuery1stop_purch.Value='Y' then //停止采购标识为真
      begin
       messagedlg('材料:'+trim(form_inv.ADOQuery1INV_PART_NUMBER.Value)+
       '已停止采购!',mtinformation,[mbcancel],0);
       edit1.SetFocus;
      end
     else
      with dm.ADOQuery2 do
       begin
        active := false;
        sql.Clear;        //查找最近一次定单价格
        sql.Add('select price from data0071');
        sql.Add('where invt_ptr='+form_inv.ADOQuery1RKEY.AsString);
        sql.Add('order by del_date desc');
        active := true;
        if not IsEmpty then
        edit7.Text := formatfloat('0.00',fieldvalues['price']);
        edit1.Text := form_inv.ADOQuery1INV_PART_NUMBER.Value;
        edit1.Font.Color := clwindowtext;
        label2.Caption := form_inv.ADOQuery1INV_PART_DESCRIPTION.Value;
        rkey17.Caption := form_inv.ADOQuery1RKEY.AsString;
        maskedit1.SetFocus;
       end;
    end
  else
   edit1.SetFocus;
 finally
  form_inv.free;
 end;
end;

procedure TForm2.BitBtn2Click(Sender: TObject);
begin
if edit8.Visible=true then  //是新增杂项采购
 begin
  try
   form_supp:=tform_supp.Create(application);
   if form_supp.ShowModal=mrok then
    begin
     edit2.Text := form_supp.ADOQuery1.FieldValues['code'];
     label5.Caption := form_supp.ADOQuery1.FieldValues['supplier_name'];
     rkey23.Caption := form_supp.ADOQuery1.fieldbyname('rkey').AsString;
     rkey01.Caption := form_supp.ADOQuery1.fieldbyname('currency_ptr').AsString;
    end;
  finally
   form_supp.free;
  end;
 end
else //新增标准
 if edit1.Font.Color = clblue then
  begin
   messagedlg('请先输入原材料!',mtinformation,[mbok],0);
   edit1.SetFocus;
  end
 else
 try
  form3:=tform3.Create(application);
  with form3.ADOQuery1 do
   begin
    close;
    Parameters[0].Value := rkey17.Caption;
    open;
   end;
  if form3.ShowModal=mrok then
   begin
    edit2.Text := form3.ADOQuery1code.Value;
    label5.Caption := form3.ADOQuery1supplier_name.value;
    rkey23.Caption := form3.ADOQuery1rkey23.AsString;
    rkey01.Caption := form3.ADOQuery1.fieldbyname('currency_ptr').AsString;
    rkey02.Caption := form3.ADOQuery1.fieldbyname('purchase_unit_ptr').AsString;
    label13.Caption :=form3.ADOQuery1.fieldbyname('unit_code').AsString;
    edit3.SetFocus;
   end;           //采购单位，货币单位
 finally
  form3.free;
 end;
end;

procedure TForm2.FormActivate(Sender: TObject);
begin
 maskedit1.Text := datetostr(date());
 if edit8.Visible=true then
  begin
   Bitbtn2.Enabled := false;
   bitbtn3.Enabled := false;
   edit3.Enabled := false;
  end;
end;

procedure TForm2.BitBtn3Click(Sender: TObject);
begin
 try
  form_wh:=tform_wh.Create(application);
  if edit1.Visible=true then //标准采购
   begin
    if edit1.Font.Color = clblue then
     begin
      messagedlg('请先输入原材料!',mtinformation,[mbok],0);
      edit1.SetFocus;
      exit;
     end
    else
     with form_wh.ADOQuery1 do
      begin
       active:=false;
       sql.Clear;
       sql.Add('select data0015.rkey,warehouse_code,warehouse_name');
       sql.Add('from data0018,data0015 where data0018.whouse_ptr=data0015.rkey');
       sql.Add('and data0018.invent_ptr='+rkey17.Caption);
       sql.Add('order by warehouse_code');
       active:=true;
      end;
   end
  else                          //杂项采购
   with form_wh.ADOQuery1 do
    begin
     active:=false;
     sql.Clear;
     sql.Add('select rkey,warehouse_code,warehouse_name');
     sql.Add('from data0015');
     sql.Add('order by warehouse_code');
     active:=true;
    end;
  form_wh.Edit1.Text := trim(edit3.Text);
  if form_wh.ADOQuery1.IsEmpty then
   begin
    messagedlg('没有找到相关记录!',mtinformation,[mbok],0);
    edit3.SetFocus;
   end
  else
   if form_wh.ShowModal=mrok then
    begin
     edit3.Text := form_wh.ADOQuery1.fieldvalues['warehouse_code'];
     edit3.Font.Color := clwindowtext;
     label6.Caption := form_wh.ADOQuery1.fieldvalues['warehouse_name'];
     rkey15.Caption := form_wh.ADOQuery1.fieldbyname('rkey').AsString;
     maskedit1.SetFocus;
    end
   else
    edit3.SetFocus;
 finally
  form_wh.free;
 end;
end;

procedure TForm2.Edit4KeyPress(Sender: TObject; var Key: Char);
begin
 if not (key in ['0'..'9',#8]) then  //判断是否输入数字
    abort;
end;

procedure TForm2.Edit4Exit(Sender: TObject);
begin
 if (trim(edit4.Text)='') or (trim(edit4.Text)='0') then
  edit4.Text := '1';
end;

procedure TForm2.Edit4KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if (trim(edit4.Text)<>'') then
  if strtoint(edit4.Text)>1 then
   begin
    edit5.ReadOnly := false;
    edit5.Color := clwindow;
   end
  else
   begin
    edit5.ReadOnly := true;
    edit5.Color := cl3dlight;
    edit5.Text := '0';
   end
 else
  begin
   edit5.ReadOnly := true;
   edit5.Color := cl3dlight;
   edit5.Text := '0';
  end;
end;

procedure TForm2.Edit5Exit(Sender: TObject);
begin
 if (trim(edit5.Text)='') then
  edit5.Text := '0';
end;

procedure TForm2.Edit6KeyPress(Sender: TObject; var Key: Char);
begin
 if not (key in ['0'..'9','.',#8]) then  //判断是否输入数字
  abort
 else
  if (key = chr(46)) then
   if pos('.',edit6.Text)>0 //小数点不能重复
    then abort;
end;

procedure TForm2.Edit6Exit(Sender: TObject);
begin
 if trim(edit6.Text)='' then edit6.Text:='0';
 edit6.Text := formatfloat('0.00',strtofloat(edit6.Text));
 edit6.Font.Color := clwindowtext;
end;

procedure TForm2.save_inv();
begin
 if form_inv.ADOQuery1stop_purch.Value='Y' then //停止采购标识为真
  begin
   messagedlg('材料:'+trim(form_inv.ADOQuery1INV_PART_NUMBER.Value)+
    '已停止采购!',mtinformation,[mbcancel],0);
   edit1.SetFocus;
  end
 else
  with dm.ADOQuery1 do
   begin
    active := false;
    sql.Clear;
    sql.Add('select data0028.supplier_ptr,data0023.code,data0023.supplier_name,');
    sql.Add('data0028.avl_flag,data0028.purchase_unit_ptr,unit_code,unit_name,');
    sql.Add('data0028.currency_ptr,curr_code,curr_name');
    sql.Add('from data0028,data0023,data0002,data0001');
    sql.Add('where data0028.supplier_ptr=data0023.rkey and');
    sql.Add('data0028.purchase_unit_ptr=data0002.rkey and');
    sql.Add('data0028.currency_ptr=data0001.rkey and');
    sql.Add('data0028.inventory_ptr='+form_inv.ADOQuery1RKEY.AsString);
    active := true;    //查找材料是否有供应商价格表
    if isempty then    //如果没有
     begin
      messagedlg('材料:'+trim(form_inv.ADOQuery1INV_PART_NUMBER.Value)+
        '未定义供应商价格',mtinformation,[mbcancel],0);
      edit1.SetFocus;
     end
    else               //如果有
     begin
      edit1.Text := form_inv.ADOQuery1INV_PART_NUMBER.Value;
      edit1.Font.Color := clwindowtext;
      label2.Caption := form_inv.ADOQuery1INV_PART_DESCRIPTION.Value;
      rkey17.Caption := form_inv.ADOQuery1RKEY.AsString;
      avl_flag.Caption := form_inv.ADOQuery1avl_flag.Value;//供应商是否已认可
      if dm.ADOQuery1.RecordCount=1 then //如果有但只有一个供应商价格表
       if avl_flag.Caption = 'Y' then    //材料是否需要认可供应商
        if fieldvalues['avl_flag'] <> 'N' then
         begin                     //供应商是否已认可
          edit2.Text := fieldvalues['code'];
          label5.Caption := fieldvalues['supplier_name'];
          rkey23.Caption := fieldbyname('supplier_ptr').AsString;
          rkey01.Caption := fieldbyname('currency_ptr').AsString;
          rkey02.Caption := fieldbyname('purchase_unit_ptr').AsString;
          label13.Caption := fieldbyname('unit_code').AsString; //采购单位
         end;
      with dm.ADOQuery2 do
       begin
        active := false; //查找原材料仓库如果是唯一那幺直接赋值
        sql.Clear;
        sql.Add('select data0015.rkey,warehouse_code,warehouse_name');
        sql.Add('from data0018,data0015 where data0018.whouse_ptr=data0015.rkey');
        sql.Add('and data0018.invent_ptr='+form_inv.ADOQuery1RKEY.AsString);
        active := true;
        if dm.ADOQuery2.RecordCount=1 then
         begin
          edit3.Text := fieldvalues['warehouse_code'];
          edit3.Font.Color := clwindowtext;
          label6.Caption := fieldvalues['warehouse_name'];
          rkey15.Caption := fieldbyname('rkey').AsString;
         end;
       end;
      with dm.ADOQuery2 do
       begin
        active := false;
        sql.Clear;        //查找最近一次定单价格
        sql.Add('select price from data0071');
        sql.Add('where invt_ptr='+form_inv.ADOQuery1RKEY.AsString);
        sql.Add('order by del_date desc');
        active := true;
        if not IsEmpty then
        edit7.Text := formatfloat('0.00',fieldvalues['price']);
       end;
    end;
  end;
end;

procedure TForm2.Edit3Exit(Sender: TObject);
begin
if (activecontrol.Name<>'BitBtn3') and (activecontrol.Name<>'button2')
   and (trim(edit3.Text)<>'') then
 try
  form_wh:=tform_wh.Create(application);
  if edit1.Visible=true then //标准采购
   if edit1.Font.Color = clblue then
    begin
     messagedlg('请先输入原材料!',mtinformation,[mbok],0);
     edit1.SetFocus;
     exit;
    end
   else
    with form_wh.ADOQuery1 do
    begin
     active:=false;
     sql.Clear;
     sql.Add('select data0015.rkey,warehouse_code,warehouse_name');
     sql.Add('from data0018,data0015 where data0018.whouse_ptr=data0015.rkey');
     sql.Add('and data0018.invent_ptr='+rkey17.Caption);
     sql.Add('order by warehouse_code');
     active:=true;
    end
  else                          //杂项采购
   with form_wh.ADOQuery1 do
    begin
     active:=false;
     sql.Clear;
     sql.Add('select rkey,warehouse_code,warehouse_name');
     sql.Add('from data0015');
     sql.Add('order by warehouse_code');
     active:=true;
    end;
  form_wh.Edit1.Text := trim(edit3.Text);
 if comparetext(trim(edit3.text),trim(form_wh.ADOQuery1.Fieldbyname('warehouse_code').AsString))=0 then
  begin
   edit3.Text := form_wh.ADOQuery1.FieldValues['warehouse_code'];
   edit3.Font.Color := clwindowtext;
   label6.Caption := form_wh.ADOQuery1.fieldvalues['warehouse_name'];
   rkey15.Caption := form_wh.ADOQuery1.fieldbyname('rkey').AsString;
  end
 else
  begin
   messagedlg('工厂代码不正确,请重新输入或选择',mtinformation,[mbok],0);
   label6.Caption := '';
   edit3.SetFocus;
  end;
 finally
  form_wh.Free;
 end;
end;

procedure TForm2.Edit1Exit(Sender: TObject);
begin
if (activecontrol.Name<>'BitBtn1') and (activecontrol.Name<>'Button2')
   and (trim(edit1.Text)<>'') then
 try
  form_inv:=tform_inv.Create(application);
  form2.active_inv;
  form_inv.Edit1.Text := trim(edit1.Text);
 if comparetext(trim(edit1.text),trim(form_inv.ADOQuery1.Fieldbyname('inv_part_number').AsString))=0 then
  begin
   if bitbtn2.Enabled=true then
    form2.save_inv()
   else
    begin
     if form_inv.ADOQuery1stop_purch.Value='Y' then //停止采购标识为真
      begin
       messagedlg('材料:'+trim(form_inv.ADOQuery1INV_PART_NUMBER.Value)+
       '已停止采购!',mtinformation,[mbcancel],0);
       edit1.SetFocus;
      end
     else
      with dm.ADOQuery2 do
       begin
        active := false;
        sql.Clear;        //查找最近一次定单价格
        sql.Add('select price from data0071');
        sql.Add('where invt_ptr='+form_inv.ADOQuery1RKEY.AsString);
        sql.Add('order by del_date desc');
        active := true;
        if not IsEmpty then
        edit7.Text := formatfloat('0.00',fieldvalues['price']);
        edit1.Text := form_inv.ADOQuery1INV_PART_NUMBER.Value;
        edit1.Font.Color := clwindowtext;
        label2.Caption := form_inv.ADOQuery1INV_PART_DESCRIPTION.Value;
        rkey17.Caption := form_inv.ADOQuery1RKEY.AsString;
       end;
    end;
  end
 else
  begin
   messagedlg('原材料号码不正确,请重新输入或选择',mtinformation,[mbok],0);
   label2.Caption := '';
   edit1.SetFocus;
  end;
 finally
  form_inv.Free;
 end;
end;

procedure TForm2.Edit8KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if trim(edit8.Text)= '' then
  begin
   Bitbtn2.Enabled := false;
   bitbtn3.Enabled := false;
   edit3.Enabled := false;
  end
 else
  if self.add_new_type<>1 then  //全新的情况下新增=1代表在有供应商的情况下新增
  begin
   Bitbtn2.Enabled := true;
   bitbtn3.Enabled := true;
   edit3.Enabled := true;
  end;
end;

procedure TForm2.Button1Click(Sender: TObject);
begin
if edit1.Visible=false then  //杂项采购
 begin
  if trim(edit8.Text)='' then
   begin
    messagedlg('物品名称不能为空!',mtinformation,[mbcancel],0);
    edit8.SetFocus;
    exit;
   end;
  if trim(edit10.Text)='' then
   begin
    messagedlg('物品规格不能为空!',mtinformation,[mbcancel],0);
    edit10.SetFocus;
    exit;
   end;
  if trim(edit9.Text)='' then
   begin
    messagedlg('采购类别不能为空!',mtinformation,[mbcancel],0);
    edit9.SetFocus;
    exit;
   end;
 end
else                   //标准采购
 begin
  if trim(rkey17.Caption) = '' then
   begin
    messagedlg('请输入或选择正确的原材料!',mtinformation,[mbcancel],0);
    edit1.SetFocus;
    exit;
   end;
  with dm.ADOQuery2 do
  begin
   close;
   sql.Clear;
   sql.Add('SELECT Data0019.inv_group_desc');
   sql.Add('FROM Data0019 INNER JOIN');
   sql.Add('Data0496 ON Data0019.rkey = Data0496.group_ptr INNER JOIN');
   sql.Add('Data0017 ON Data0496.RKEY = Data0017.GROUP_PTR');
   sql.Add('where data0017.rkey='+trim(rkey17.Caption));
   open;
  end;
  label17.Caption:=trim(dm.ADOQuery2.fieldbyname('inv_group_desc').AsString);
 end;

 if rkey23.Caption = '' then
  begin
   messagedlg('请选择正确的供应商代码!',mtinformation,[mbcancel],0);
   bitbtn2.SetFocus;
   exit;
  end;

 if trim(edit3.Text) = '' then
  begin
   messagedlg('请输入或选择正确的仓库代码!',mtinformation,[mbcancel],0);
   edit3.SetFocus;
   exit;
  end
 else
  if (dm.AQ0015.Active=true) and (strtoint(rkey15.Caption)<>dm.AQ0015RKEY.Value) then
   begin
    messagedlg('同一次采购不能为不同工厂采购!',mtinformation,[mbcancel],0);
    edit3.SetFocus;
    exit;
   end;

 if strtodate(maskedit1.Text)<date() then
  begin
   messagedlg('要求供应商出货日期不能少于当前日期',mterror,[mbcancel],0);
   maskedit1.SetFocus;
   exit;
  end;

 if strtofloat(edit6.Text)=0 then
  begin
   messagedlg('采购数量不能为0!',mtinformation,[mbcancel],0);
   edit6.SetFocus;
   exit;
  end;

 ModalResult:=mrok;
end;

procedure TForm2.active_inv();
begin
 if bitbtn2.Enabled=true then    //如果是左上角全新新增
  with form_inv.ADOQuery1 do
   begin
    active:=false;
    sql.Clear;
    sql.Add('SELECT RKEY,stop_purch,avl_flag,');
    sql.Add('INV_PART_NUMBER,INV_PART_DESCRIPTION,');
    sql.Add('manufacturer_name');
    sql.Add('FROM Data0017 WHERE Data0017.P_M = ''P''');
    sql.Add('ORDER BY INV_PART_NUMBER');
    active:=true;
   end
 else                      //如果是在已确定供应商的情况下新增
  with form_inv.ADOQuery1 do
   begin
    active:=false;
    sql.Clear;
    sql.Add('SELECT data0017.RKEY,stop_purch,data0017.avl_flag,');
    sql.Add('INV_PART_NUMBER,INV_PART_DESCRIPTION,');
    sql.Add('manufacturer_name');
    sql.Add('FROM Data0017,data0028 WHERE Data0017.P_M = ''P'' and');
    sql.Add('data0028.inventory_ptr=data0017.rkey and');
    sql.Add('data0028.supplier_ptr='+rkey23.Caption);
    sql.Add('ORDER BY INV_PART_NUMBER');
    active:=true;
   end;
end;

procedure TForm2.Edit6Click(Sender: TObject);
begin
if edit6.Font.Color=clwindowtext then
 begin
  edit6.Font.Color:=clblue;
  edit6.SelectAll;
 end;
end;

procedure TForm2.Edit7Click(Sender: TObject);
begin
if edit7.Font.Color=clwindowtext then
 begin
  edit7.Font.Color:=clblue;
  edit7.SelectAll;
 end;
end;

procedure TForm2.Edit7KeyPress(Sender: TObject; var Key: Char);
begin
 if (key = chr(46)) then
 if pos('.',edit7.Text)>0 //小数点不能重复
    then abort;
 if not (key in ['0'..'9','.',#8]) then  //判断是否输入数字
    abort;
end;

procedure TForm2.Edit7Exit(Sender: TObject);
begin
 if trim(edit7.Text)='' then edit7.Text:='0';
  edit7.Text := formatfloat('0.000',strtofloat(edit7.Text));
  edit7.Font.Color := clwindowtext;
end;

procedure TForm2.FormCreate(Sender: TObject);
begin
 with dm.ADOQuery2 do
  begin
   close;
   sql.Clear;
   sql.Add('select * from data0075');
   sql.Add('order by DESCRIPTION');
   open;
   while not eof do
    begin
     edit9.Items.Add(fieldvalues['DESCRIPTION']);
     Next;
    end;
  end;
 dm.ADOQuery2.Close;
end;

procedure TForm2.Edit11Click(Sender: TObject);
begin
if edit11.Font.Color = clwindowtext then
 begin
  edit11.Font.Color :=clblue;
  edit11.SelectAll;
 end;
end;

procedure TForm2.Edit11Exit(Sender: TObject);
begin
if (activecontrol.Name<>'BitBtn4') and (activecontrol.Name<>'Button2') then
 try
  form_unit:=tform_unit.Create(application);
  form_unit.Edit1.Text :=trim(edit11.Text);
 if comparetext(trim(edit11.text),trim(form_unit.ADOQuery1.Fieldbyname('unit_code').AsString))=0 then
   begin
    edit11.Text := form_unit.ADOQuery1.FieldValues['unit_code'];
    edit11.Font.Color := clwindowtext;
    rkey02.Caption := form_unit.ADOQuery1.fieldbyname('rkey').AsString;
    label19.Caption := form_unit.ADOQuery1.FieldValues['unit_name'];
   end
  else
   begin
    messagedlg('采购单位不能为空,请重新输入或选择',mtinformation,[mbok],0);
    label19.Caption := '';
    edit11.SetFocus;
   end;
 finally
  form_unit.free;
 end;
end;

procedure TForm2.BitBtn4MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  form_unit:=tform_unit.Create(application);
  form_unit.Edit1.Text :=trim(edit11.Text);
  if form_unit.ADOQuery1.IsEmpty then
   begin
    messagedlg('没有找符合条件的记录!',mtwarning,[mbok],0);
    edit11.SetFocus;
   end
  else
  if form_unit.ShowModal=mrok then
   begin
    edit11.Text := form_unit.ADOQuery1.FieldValues['unit_code'];
    edit11.Font.Color := clwindowtext;
    rkey02.Caption :=form_unit.ADOQuery1.fieldbyname('rkey').AsString;
    label19.Caption := form_unit.ADOQuery1.FieldValues['unit_name'];
    if bitbtn2.Enabled=true then bitbtn2.SetFocus
     else edit8.SetFocus;
   end
  else
   edit11.SetFocus;
end;

procedure TForm2.BitBtn4Exit(Sender: TObject);
begin
  form_unit.free;
end;

procedure TForm2.MaskEdit1Exit(Sender: TObject);
begin
 try
  strtodate(maskedit1.Text);
 except
  messagedlg('日期格式输入不正确,请重新输入!',mtwarning,[mbok],0);
  maskedit1.SetFocus;
 end;
end;

end.
