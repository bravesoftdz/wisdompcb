unit Storage;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, Grids, Menus, ComCtrls;

type
  Tfrm_Storage = class(TForm)
    Panel1: TPanel;
    Label2: TLabel;
    Label1: TLabel;
    Label3: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    Edit2: TEdit;
    BtSave: TBitBtn;
    BtClose: TBitBtn;
    Edit1: TEdit;
    BitBtn3: TBitBtn;
    Edit4: TEdit;
    EdtSum: TEdit;
    cbb_Abbr_Name: TComboBox;
    StringGrid1: TStringGrid;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    DateTimePicker4: TDateTimePicker;
    DateTimePicker3: TDateTimePicker;
    Label4: TLabel;
    procedure FormShow(Sender: TObject);
    procedure BtSaveClick(Sender: TObject);
    procedure StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure BitBtn3Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure cbb_Abbr_NameChange(Sender: TObject);
  private
    quantity:Integer;
    rkey58list:string;
    function invo_number_error(number: string): boolean;
    { Private declarations }
  public
     v_status,rkey416:Integer;
     function returen_rkey58list():string;
    { Public declarations }
  end;

var
  frm_Storage: Tfrm_Storage;

implementation

uses damo,Pick_Item_Single,ConstVar,common,MyClass, Scrap,StrUtils;

{$R *.dfm}

procedure Tfrm_Storage.FormShow(Sender: TObject);
var
  i:Integer;
begin
  MyDataClass :=TMyDataClass.Create(dm.ADOConnection1);

  with DM.tmp do
  begin
    Close;
    SQL.Clear;
    SQL.Add('select rkey,abbr_name from data0015');
    open;
  end;
  DM.tmp.First;
  Cbb_ABBR_NAME.Items.Clear;
  while not DM.tmp.Eof do
  begin
    Cbb_ABBR_NAME.Items.AddObject(DM.tmp.FieldValues['abbr_name'],Pointer(DM.tmp.FieldByName('rkey').AsInteger));
    DM.tmp.Next;
  end;

  StringGrid1.Cells[0,0] := '序号';
  StringGrid1.Cells[1,0] :='本厂编号';
  StringGrid1.Cells[2,0] :='客户型号';
  StringGrid1.Cells[3,0] :='工单号';
  StringGrid1.Cells[4,0] :='工厂简称';

  StringGrid1.Cells[5,0] :='入仓数';
  StringGrid1.Cells[6,0] :='持有数';
  StringGrid1.ColWidths[6]:=-1;
  StringGrid1.Cells[7,0] :='具体位置';
  StringGrid1.Cells[8,0] :='参考号码';
  StringGrid1.Cells[9,0]:='rkey';
  StringGrid1.Cells[10,0]:='WORK_ORDER_PTR';
  StringGrid1.Cells[11,0]:='CUST_PART_PTR';
  StringGrid1.Cells[12,0] :='审核日期';
  StringGrid1.ColWidths[9]:=-1;
  StringGrid1.ColWidths[10]:=-1;
  StringGrid1.ColWidths[11]:=-1;

  if v_status=0 then
  begin
    DM.tmp.Close;
    DM.tmp.SQL.Text:='select  CONTROL_NO_LENGTH, SEED_VALUE, SEED_FLAG '+
                     'from Data0004 where rkey=5';
    DM.tmp.Open;
    if DM.tmp.FieldByName('SEED_FLAG').AsInteger <>1 then
      Edit2.Text := DM.tmp.FieldByName('SEED_VALUE').AsString;
    if DM.tmp.FieldByName('SEED_FLAG').AsInteger =4 then
     Edit2.ReadOnly := True;
    quantity :=0;
    DateTimePicker3.Date := getsystem_date(DM.tmp,0);
    DateTimePicker4.Time := getsystem_date(DM.tmp,0);
  end
  else
  if v_status=1 then
  begin
    BtSave.Enabled:= False;
    cbb_Abbr_Name.Enabled := False;
    Edit4.Enabled := False;
    N1.Enabled := False;
    N2.Enabled := False;
    Edit2.Text := DM.ADS416number.Value;
    Edit1.Text := DM.ADS53LOCATION.Value;
    cbb_Abbr_Name.ItemIndex := cbb_Abbr_Name.Items.IndexOf(DM.ADS53.FieldByName('ABBR_NAME').AsString);
    EdtSum.Text := DM.ADS416quantity.AsString;
    Edit4.Text := DM.ADS416reference.AsString;
    BitBtn3.Enabled := False;
    Label4.Caption := '入库日期';
    DateTimePicker3.Date := dm.ADS416sys_date.Value;
    DateTimePicker4.Time := DM.ADS416sys_date.Value;
    DateTimePicker4.Enabled :=False;
    DateTimePicker3.Enabled := False;
    with DM.ADS53 do
    begin
      First;
      while not Eof do
      begin
        StringGrid1.Cells[1,StringGrid1.RowCount-1] := DM.ADS53MANU_PART_NUMBER.Value;
        StringGrid1.Cells[2,StringGrid1.RowCount-1] := DM.ADS53MANU_PART_DESC.Value;
        StringGrid1.Cells[3,StringGrid1.RowCount-1] := DM.ADS53WORK_ORDER_NUMBER.Value;
        StringGrid1.Cells[4,StringGrid1.RowCount-1] := DM.ADS53ABBR_NAME.Value;
        StringGrid1.Cells[5,StringGrid1.RowCount-1] := DM.ADS53QTY_ON_HAND.AsString;
        StringGrid1.Cells[6,StringGrid1.RowCount-1] := DM.ADS53QTY_ON_HAND.AsString;
        StringGrid1.Cells[7,StringGrid1.RowCount-1] := DM.ADS53spec_place.Value;
        StringGrid1.Cells[8,StringGrid1.RowCount-1] := DM.ADS53REFERENCE_NUMBER.AsString;
        StringGrid1.Cells[0,StringGrid1.RowCount-1]:=IntToStr(StringGrid1.RowCount-1);
        with DM.tmp do
        begin
          Close;
          SQL.Text := ' select rkey,AUDIT_DATETIME from data0058 where rkey='+dm.ADS53rkey58.AsString;
          Open;
        end;
        StringGrid1.Cells[12,StringGrid1.RowCount-1] := DM.tmp.FieldByName('AUDIT_DATETIME').Value;
        StringGrid1.RowCount := StringGrid1.RowCount+1;
        Next;
      end;

    end;
  end;

  for i := 1 to StringGrid1.RowCount-2 do
  begin
    StringGrid1.Cells[0,i] := IntToStr(i);
  end;


end;

function Tfrm_Storage.invo_number_error(number: string): boolean;
begin
  result:=false;
  with dm.tmp do
  begin
    close;
    SQL.Text:='select rkey, number from Data0416 where number='+QuotedStr(number);
    open;
    if not IsEmpty then
    result:=true;
  end;
end;

procedure Tfrm_Storage.BtSaveClick(Sender: TObject);
var
  SEED_VALUE:string;
  SEED_FLAG,i:Integer;
  sys_date:TDateTime;
begin
  if Edit2.Text ='' then
  begin
    messagedlg('入库单号不能为空',mtinformation,[mbcancel],0);
    exit;
  end;
  if cbb_Abbr_Name.ItemIndex =-1 then
  begin
    messagedlg('工厂不能为空',mtinformation,[mbcancel],0);
    cbb_Abbr_Name.SetFocus;
    exit;
  end;
  if Edit1.Text ='' then
  begin
    messagedlg('仓库不能为空',mtinformation,[mbcancel],0);
    exit;
  end;
  if Edit1.Text ='' then
  begin
    messagedlg('入库总数不能为空',mtinformation,[mbcancel],0);
    exit;
  end;
  if StringGrid1.RowCount-2 <= 0 then
  begin
    messagedlg('请添加入库记录',mtinformation,[mbcancel],0);
    exit;
  end;
  sys_date:= getsystem_date(DM.tmp,0);

  DM.tmp.Close;
  DM.tmp.SQL.Text:='select  CONTROL_NO_LENGTH, SEED_VALUE, SEED_FLAG '+
                   'from Data0004 where rkey=5';
  DM.tmp.Open;
  SEED_VALUE:=DM.tmp.FieldByName('SEED_VALUE').AsString;
  SEED_FLAG:= DM.tmp.FieldByName('SEED_FLAG').AsInteger;
  if self.invo_number_error(trim(edit2.Text)) then
  begin
    if SEED_FLAG <>1 then
    begin
      Edit2.Text:=SEED_VALUE;
      messagedlg('入库单号重复可能多人同时新增,系统已自动更新编号!',mterror,[mbcancel],0);
    end
    else
    begin
      messagedlg('入库单号重复!请手工重新输入',mterror,[mbok],0);
      Edit1.SetFocus;
      exit;
    end;
  end;

  try
    DM.ADOConnection1.BeginTrans;
    if (SEED_FLAG <>1) then        //新增保存之后处理04初始值加1
    common.Update_Seed(5);
    with DM.tmp do
    begin
      Close;
      SQL.Text := 'select rkey,number,type,empl_ptr,sys_date,quantity,reference from data0416 where rkey is null';
      Open;
      Append;
      FieldByName('number').Value := edit2.Text;
      FieldByName('type').Value := 6;
      FieldByName('empl_ptr').Value := user_ptr;
      FieldByName('sys_date').Value := sys_date;
      FieldByName('quantity').Value := edtsum.Text;
      FieldByName('reference').Value := edit4.Text;
      Post;
      rkey416 := DM.tmp.FieldValues['rkey'];


      if StringGrid1.RowCount-2 >0 then
      begin
        for i:=1 to StringGrid1.RowCount-2 do
        begin
          Close;
          SQL.Text :='insert into data0053(QUANTITY,QTY_ON_HAND,MFG_DATE,RMA_PTR,REFERENCE_NUMBER,spec_place,WHSE_PTR,LOC_PTR,'+
                  'WORK_ORDER_PTR,CUST_PART_PTR,NPAD_PTR,rkey58) values('+StringGrid1.Cells[5,i]+','+StringGrid1.Cells[6,i]+','+
                  QuotedStr(FormatDateTime('yyyy-MM-dd H:mm:ss',sys_date))+',8,'+QuotedStr(StringGrid1.Cells[8,i])+','+QuotedStr(StringGrid1.Cells[7,i])+
                  ','+IntToStr(integer(Cbb_ABBR_NAME.Items.Objects[Cbb_ABBR_NAME.ItemIndex]))+','+IntToStr(Edit1.Tag)+
                  ','+StringGrid1.Cells[10,i]+','+StringGrid1.Cells[11,i]+','+IntToStr(rkey416)+','+StringGrid1.Cells[9,i]+')' ;

          ExecSQL;

  {        Close;
          SQL.Text := 'update data0058 set if_stock =1 where rkey='+ StringGrid1.Cells[9,i];
          ExecSQL;

          Close;
          SQL.Text :='update data0025 set QTY_ON_HAND=QTY_ON_HAND+'+StringGrid1.Cells[5,i]+' where rkey ='+StringGrid1.Cells[11,i];
          ExecSQL;
    }
        end;
      end;

       Close;
       SQL.Text := 'update data0058 set if_stock =1 from data0058 inner join data0053 on data0058.rkey=data0053.rkey58'+
          ' where data0053.NPAD_PTR='+ IntToStr(rkey416);
       ExecSQL;

       Close;
       SQL.Text :=
         ' update data0025 set QTY_ON_HAND=QTY_ON_HAND+derivedtbl_1.qty '+
         ' FROM         dbo.Data0025 INNER JOIN'+
         '                 (SELECT  CUST_PART_PTR, SUM(QTY_ON_HAND) AS qty'+
         '                   FROM   dbo.Data0053' +
         '                   WHERE (NPAD_PTR = '+IntToStr(rkey416)+')'+
         '                   GROUP BY CUST_PART_PTR) AS derivedtbl_1 ON dbo.Data0025.RKEY = derivedtbl_1.CUST_PART_PTR';
       ExecSQL;
    end;
    DM.ADOConnection1.CommitTrans;
    ModalResult := mrOk;
  except
    on  E:Exception do
    begin
      DM.ADOConnection1.RollbackTrans;
      MessageDlg(E.Message,mtError,[mbCancel],0);
    end;
  end;

end;



procedure Tfrm_Storage.StringGrid1SelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if (ARow<>StringGrid1.RowCount-1) and ((ACol=8) or (ACol=7)) and (v_status<>1) then
  begin
    StringGrid1.Options := StringGrid1.Options-[goRowSelect];
    StringGrid1.Options := StringGrid1.Options+[goEditing];
  end
  else
  begin
    StringGrid1.Options := StringGrid1.Options+[goRowSelect];
    StringGrid1.Options := StringGrid1.Options-[goEditing];
  end;
end;

procedure Tfrm_Storage.BitBtn3Click(Sender: TObject);
var
  InputVar: PDlgInput;
begin
  if cbb_Abbr_Name.ItemIndex = -1 then
  begin
    showmessage('请先选择工厂');
    exit;
  end;
  try
    frmPick_Item_Single:=TfrmPick_Item_Single.Create(nil);
    InputVar.Fields := 'CODE/部门代码/180,LOCATION/部门名称/250';
    InputVar.Sqlstr := 'SELECT Data0016.CODE, Data0016.LOCATION, Data0016.Rkey '+
    'FROM  dbo.Data0016 where allow_putout=0 and location_type=1 and '+
    ' Data0016.whouse_ptr='+inttostr(integer(Cbb_ABBR_NAME.Items.Objects[Cbb_ABBR_NAME.ItemIndex]));
    Inputvar.KeyField:='';
    InputVar.AdoConn := dm.ADOConnection1 ;
    frmPick_Item_Single.InitForm_New(InputVar);
    if frmPick_Item_Single.ShowModal=mrok then
    begin
      edit1.Text:=frmPick_Item_Single.adsPick.fieldbyname('LOCATION').AsString;
      Edit1.Tag:= frmPick_Item_Single.adsPick.fieldbyname('rkey').asinteger;
//      StringGrid1.Cells[5,StringGrid1.RowCount-1] := Edit1.Text ;
    end;

  finally
    frmPick_Item_Single.Free;
  end

end;

function Tfrm_Storage.returen_rkey58list: string;
var
  i:Integer;
begin
  rkey58list :='(';
  for i:=1 to StringGrid1.RowCount-2 do
  if i = StringGrid1.RowCount-2 then
    rkey58list := rkey58list + StringGrid1.Cells[9,i]+')'
  else
    rkey58list := rkey58list + StringGrid1.Cells[9,i]+',';
  returen_rkey58list := rkey58list;

end;

procedure Tfrm_Storage.N1Click(Sender: TObject);
var
  Max_date:string;
begin
  try
    if cbb_Abbr_Name.ItemIndex = -1 then
    begin
      showmessage('请先选择工厂');
      Exit;
    end;
    
    frm_scrap:=Tfrm_Scrap.Create(Application);
    with dm.tmp do
    begin
      close;
      sql.Text:='SELECT ISNULL(MAX(dbo.Data0444.TDATE), 0) as max_date FROM  dbo.Data0451 INNER JOIN'+
                ' dbo.Data0444 ON dbo.Data0451.END_DATE = dbo.Data0444.CUT_DATE';
      Open;
      Max_date:=FormatDateTime('YYYY-MM-DD HH:mm:ss',FieldValues['max_date']);
    end;


     frm_Scrap.ADS58.CommandText := frm_Scrap.ADS58.CommandText
        + ' and Data0058.AUDIT_DATETIME>'+quotedstr(Max_date)+#13;    //2016-12-8注释
//          +' and Data0058.AUDIT_DATETIME>''2016-11-1'' and Data0058.AUDIT_DATETIME<''2016-11-30''';
    if StringGrid1.RowCount > 2 then
    begin
      frm_Scrap.ADS58.CommandText := frm_Scrap.ADS58.CommandText
        + ' and Data0058.rkey not in' + Self.returen_rkey58list+#13;
    end;


    frm_scrap.ADS58.CommandText :=frm_scrap.ADS58.CommandText+' and data0058.warehouse_ptr='+
    inttostr(integer(Cbb_ABBR_NAME.Items.Objects[Cbb_ABBR_NAME.ItemIndex]));


    if frm_scrap.ShowModal=mrok then
    begin
      frm_scrap.ADS58.First;
      while not  frm_scrap.ADS58.Eof do
      begin
        StringGrid1.Cells[1,StringGrid1.RowCount-1] := frm_scrap.ADS58MANU_PART_NUMBER.Value;
        StringGrid1.Cells[2,StringGrid1.RowCount-1] := frm_scrap.ADS58MANU_PART_DESC.Value;
        StringGrid1.Cells[3,StringGrid1.RowCount-1] := frm_scrap.ADS58WORK_ORDER_NUMBER.Value;
        StringGrid1.Cells[4,StringGrid1.RowCount-1] := cbb_Abbr_Name.Text;
//        StringGrid1.Cells[5,StringGrid1.RowCount-1] := Edit1.Text ;
        StringGrid1.Cells[5,StringGrid1.RowCount-1] := frm_scrap.ADS58QTY_REJECT.AsString;
        StringGrid1.Cells[6,StringGrid1.RowCount-1] := frm_scrap.ADS58QTY_REJECT.AsString;
        StringGrid1.Cells[9,StringGrid1.RowCount-1] := frm_scrap.ADS58RKEY.AsString;
        StringGrid1.Cells[0,StringGrid1.RowCount-1]:=IntToStr(StringGrid1.RowCount-1);
        StringGrid1.Cells[10,StringGrid1.RowCount-1] := frm_scrap.ADS58WORK_ORDER_ptr.AsString;
        StringGrid1.Cells[11,StringGrid1.RowCount-1] := frm_scrap.ADS58CUST_PART_ptr.AsString;
        StringGrid1.Cells[12,StringGrid1.RowCount-1] := frm_scrap.ADS58AUDIT_DATETIME.AsString;
        StringGrid1.RowCount := StringGrid1.RowCount+1;
        quantity := quantity+frm_scrap.ADS58QTY_REJECT.AsInteger;
        frm_scrap.ADS58.Next;
      end;
    end;
    EdtSum.Text :=IntToStr(quantity);
    if StringGrid1.RowCount >2 then
      cbb_Abbr_Name.Enabled := False
    else
      cbb_Abbr_Name.Enabled := True;
  finally
    frm_scrap.Free;
  end;

end;



procedure Tfrm_Storage.N2Click(Sender: TObject);
var
  i:Integer;
begin
//此代码为去除 rkey58list里面的值重复添加。leftstr函数要引用StrUtils
//  returen_rkey58list;
//  rkeysg:=StringGrid1.Cells[9,StringGrid1.row];
//  y := Pos(rkeysg,rkey58list);
//  rkey58list := leftstr(rkey58list,y)+copy(rkey58list,(y+length(rkeysg)+1),Length(rkey58list));

//  if Trim(rkey58)=''then
//    rkey58 := StringGrid1.Cells[9,StringGrid1.row]
//  else
//  begin
//   if Pos(rkeysg,rkey58)>0  then
//     rkey58 :=rkey58
//   else
//     rkey58 :=rkey58+','+StringGrid1.Cells[9,StringGrid1.row];
//  end;

  if StringGrid1.RowCount <= 2 then exit;
  quantity :=quantity-StrToInt(StringGrid1.Cells[5,StringGrid1.Row]);
    
  for i:=StringGrid1.Row to StringGrid1.RowCount-2 do
  begin
    StringGrid1.Rows[i].Text:=StringGrid1.Rows[i+1].Text;
    if i<> StringGrid1.RowCount-2 then
    StringGrid1.Cells[0,i]:=IntToStr(i);
  end;
  EdtSum.Text :=IntToStr(quantity);
  StringGrid1.RowCount:=StringGrid1.RowCount-1;
  if StringGrid1.Row=StringGrid1.RowCount-1 then
  StringGrid1.Row :=1;
  if StringGrid1.RowCount >2 then
    cbb_Abbr_Name.Enabled := False
  else
    cbb_Abbr_Name.Enabled := True;
end;

procedure Tfrm_Storage.PopupMenu1Popup(Sender: TObject);
begin
  if stringgrid1.Row= stringgrid1.RowCount-1 then
   n2.Enabled:=false
  else
   n2.Enabled:=true;
end;

procedure Tfrm_Storage.cbb_Abbr_NameChange(Sender: TObject);
begin
  Edit1.Text :='';
  Edit1.Tag :=0  ;
end;

end.
