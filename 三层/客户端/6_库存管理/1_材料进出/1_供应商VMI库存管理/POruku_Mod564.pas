unit POruku_Mod564;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, uBaseEditFrm,ucommfunc, Vcl.Grids,
  Vcl.StdCtrls, Vcl.Mask, RzEdit, RzBtnEdt, uRKeyBtnEdit, Vcl.Buttons,
  Vcl.ExtCtrls, Data.DB, Datasnap.DBClient, Vcl.ComCtrls, Vcl.Menus;

type
  LgetRefreshClick=procedure (cds:TClientDataSet) of object;
  TfrmPOruku_Mod564 = class(TfrmBaseEdit)
    Panel1: TPanel;
    Panel2: TPanel;
    Label1: TLabel;
    Label5: TLabel;
    Label12: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    Label11: TLabel;
    Label14: TLabel;
    CheckBox3: TCheckBox;
    Label3: TLabel;
    Label13: TLabel;
    Label16: TLabel;
    redt1: TRKeyRzBtnEdit;
    redt2: TRKeyRzBtnEdit;
    redt3: TRKeyRzBtnEdit;
    redt4: TRKeyRzBtnEdit;
    redt5: TRKeyRzBtnEdit;
    redt7: TRKeyRzBtnEdit;
    redt8: TRKeyRzBtnEdit;
    redt9: TRKeyRzBtnEdit;
    Button1: TButton;
    StringGrid1: TStringGrid;
    cds133: TClientDataSet;
    ds133: TDataSource;
    cds134: TClientDataSet;
    ds134: TDataSource;
    dtpReqDate: TDateTimePicker;
    redt6: TRKeyRzBtnEdit;
    cds04: TClientDataSet;
    Button2: TButton;
    CBloc: TComboBox;
    dtpk1: TDateTimePicker;
    cds16: TClientDataSet;
    PopupMenu1: TPopupMenu;
    IQC1: TMenuItem;
    cds70: TClientDataSet;
    cds391: TClientDataSet;
    cds71: TClientDataSet;
    ComboBox3: TComboBox;
    N1: TMenuItem;
    N2: TMenuItem;
    procedure StringGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure dtpk1KeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure CBlocKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure IQC1Click(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure StringGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure CBlocExit(Sender: TObject);
    procedure StringGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure StringGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure ComboBox3Exit(Sender: TObject);
    procedure ComboBox3KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure btnCloseClick(Sender: TObject);
    procedure dtpk1Exit(Sender: TObject);
    procedure StringGrid1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure N2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    refresh:LgetRefreshClick;
    FEditType: Integer;//�˵�
    str_list:TStringList;
    LGRName:string; //04���º�
    procedure GetData(ARkey: string);
    function update04(table_name:string;var LsName:string):string;
    function Power(x, y : extended) : extended;
    procedure init;
    procedure get_location();
    procedure EnableEdit;
    function IfWarehouse():Boolean; //�ж��������Ĳֿⲻ������
    function IfDateNow():Boolean; //�������ڲ��ܴ��ڵ�ǰ����
  end;

var
  frmPOruku_Mod564: TfrmPOruku_Mod564;

implementation

{$R *.dfm}

uses SeleIQC;
procedure TfrmPOruku_Mod564.get_location;
var Lsql:string;
begin
  if checkbox3.Checked then
    Lsql:='select rkey,LOCATION from data0016 '+
    'where LOCATION_TYPE = 0 and '+
    'whouse_ptr='+cds133.FieldByName('warehouse_ptr').AsString+
    ' order by rkey'
  else
     Lsql:='select rkey,LOCATION from data0016 '+
    'where LOCATION_TYPE=0 order by rkey';
  if not gSvrIntf.IntfGetDataBySql(Lsql,cds16) then Exit;
  cbloc.Items.Clear;
  while not cds16.Eof do
   begin
    cbloc.Items.AddObject(cds16.fieldBYName('LOCATION').AsString,Pointer(cds16.fieldBYName('Rkey').AsInteger));
    cds16.Next;
   end;
  cbloc.ItemIndex:=cbloc.Items.IndexOf(cds16.fieldBYName('LOCATION').AsString);
end;

function TfrmPOruku_Mod564.IfDateNow: Boolean;
var i:Integer;
begin
  Result:=False;
  for I := 1 to StringGrid1.RowCount-1 do
  begin
    if (Trim(StringGrid1.Cells[str_list.IndexOfName('��������'),i])<>'') and (strtofloat(StringGrid1.Cells[str_list.IndexOfName('��ǰ����'),i])>0) and (StrToDateTime(StringGrid1.Cells[str_list.IndexOfName('��������'),i])>gFunc.GetSvrDateTime)  then
    begin
      Result:=True;
      Break;
    end;
  end;
end;

function TfrmPOruku_Mod564.IfWarehouse: Boolean;//�ж��������Ĳֿⲻ������
var i:Integer;
begin
  Result:=False;
  for I := 1 to StringGrid1.RowCount-1 do
  begin
    if (StringGrid1.Cells[str_list.IndexOfName('�ֿ�λ��'),i]='') and (strtofloat(StringGrid1.Cells[str_list.IndexOfName('��ǰ����'),i])>0) then
    begin
      Result:=True;
      Break;
    end;
  end;
  for i:=1 to StringGrid1.RowCount-1 do
  begin
    if (strtofloat(StringGrid1.Cells[str_list.IndexOfName('��ǰ����'),i])>0) then
      break//������һ���������
    else
    if (i=StringGrid1.RowCount-1) then Result:=true;
  end;
end;

procedure TfrmPOruku_Mod564.init;
var j,i:integer;
begin
  StringGrid1.Update;
  for j :=StringGrid1.RowCount-1  downto 1  do
  begin
    for i:=0 to StringGrid1.ColCount do
    begin
      StringGrid1.Cells[i,j]:='';
    end;
    stringgrid1.rowcount := stringgrid1.rowcount - 1;
  end;
  str_list := TStringList.Create;
  str_list.Add('���ϱ���=INV_PART_NUMBER');
  str_list.Add('��������=INV_NAME');
  str_list.Add('���Ϲ��=INV_DESCRIPTION');
  str_list.Add('��������=QUAN_ORD');
  str_list.Add('ת����=CONVERSION_FACTOR');
  str_list.Add('�ѽ���=QUAN_RECD');
  str_list.Add('�����λ=pr_unitname');
  str_list.Add('��ǰ����=QUANTITY');
  str_list.Add('�ֿ�λ��=LOCATION');
  str_list.Add('����������=SUPPLIER3');
  str_list.Add('��ϸλ��=SUPPLIER2');
  str_list.Add('�ر�Ҫ��=BARCODE_ID');
  str_list.Add('IF���=avl_flag');
  str_list.Add('��������=manu_date');
  str_list.Add('������ʶ=rohs');
  str_list.Add('IQC�Ѽ�������=QUAN_IN_INSP');
  str_list.Add('71rkey=SOURCE_PTR');
  str_list.Add('17rkey=INVT_PTR');
  str_list.Add('�����λ02=WO_PTR');
  str_list.Add('��˰��=tax_PRICE');
  str_list.Add('˰��=TAX_2');
  str_list.Add('16rkey=LOCATION_PTR');
  str_list.Add('������Ч��=SHELF_LIFE');
  str_list.Add('���ϵ���KG=STOCK_BASE');
  str_list.Add('mark=mark');
  str_list.Add('Rkey391=Rkey391');
  str_list.Add('extra_req=extra_req');
  str_list.Add('�ֳ�����=QUAN_ON_HAND');
  str_list.Add('��ǰ����2=QUANTITY');
  str_list.Add('Rkey=Rkey');
  StringGrid1.ColCount:=str_list.Count;
  for j := 0 to str_list.Count-1  do    //SGrd��ӵ�һ�е��ֶ���
  begin
    StringGrid1.Cells[j,0] := str_list.Names[j];
  end;
  StringGrid1.RowCount:=2;
  StringGrid1.FixedRows:=1;
  StringGrid1.ColWidths[str_list.IndexOfName('IQC�Ѽ�������')]:=-1;
  StringGrid1.ColWidths[str_list.IndexOfName('71rkey')]:=-1;
  StringGrid1.ColWidths[str_list.IndexOfName('17rkey')]:=-1;
  StringGrid1.ColWidths[str_list.IndexOfName('�����λ02')]:=-1;
  StringGrid1.ColWidths[str_list.IndexOfName('��˰��')]:=-1;
  StringGrid1.ColWidths[str_list.IndexOfName('˰��')]:=-1;
  StringGrid1.ColWidths[str_list.IndexOfName('16rkey')]:=-1;
  StringGrid1.ColWidths[str_list.IndexOfName('������Ч��')]:=-1;
  StringGrid1.ColWidths[str_list.IndexOfName('���ϵ���KG')]:=-1;
  StringGrid1.ColWidths[str_list.IndexOfName('mark')]:=-1;
  StringGrid1.ColWidths[str_list.IndexOfName('Rkey391')]:=-1;
  StringGrid1.ColWidths[str_list.IndexOfName('�ر�Ҫ��')]:=-1;
  StringGrid1.ColWidths[str_list.IndexOfName('�ֳ�����')]:=-1;
  StringGrid1.ColWidths[str_list.IndexOfName('extra_req')]:=-1;
  StringGrid1.ColWidths[str_list.IndexOfName('��ǰ����2')]:=-1;
  StringGrid1.ColWidths[str_list.IndexOfName('Rkey')]:=-1;
end;

procedure TfrmPOruku_Mod564.IQC1Click(Sender: TObject);
var
  LFrm: TfrmSeleIQC;
begin
  inherited;
   //��Ӧ����IQC�������391
  LFrm := TfrmSeleIQC.Create(Self);
  try
    LFrm.GetData(StringGrid1.Cells[str_list.IndexOfName('71rkey'),StringGrid1.Row],StringGrid1.Cells[str_list.IndexOfName('17rkey'),StringGrid1.Row]);
    if LFrm.ShowModal = mrOk then
    begin
      StringGrid1.Cells[str_list.IndexOfName('��ǰ����'),StringGrid1.Row]:=LFrm.cds391.FieldByName('rece_qty').AsString;
      StringGrid1.Cells[str_list.IndexOfName('��������'),StringGrid1.Row]:=LFrm.cds391.FieldByName('manufacture_TDATE').AsString;
      StringGrid1.Cells[str_list.IndexOfName('����������'),StringGrid1.Row]:=LFrm.cds391.FieldByName('barch_no').AsString;
      StringGrid1.Cells[str_list.IndexOfName('Rkey391'),StringGrid1.Row]:=LFrm.cds391.FieldByName('Rkey').AsString;
      StringGrid1.Cells[str_list.IndexOfName('�ر�Ҫ��'),StringGrid1.Row]:=LFrm.cds391.FieldByName('extra_req').AsString;
    end;
  finally
    LFrm.Free;
  end;
end;

procedure TfrmPOruku_Mod564.N2Click(Sender: TObject);
begin
  inherited;
  StringGrid1.Cells[str_list.IndexOfName('��ǰ����'),StringGrid1.Row]:='0';
//  StringGrid1.Cells[str_list.IndexOfName('��������'),StringGrid1.Row]:='';
  StringGrid1.Cells[str_list.IndexOfName('����������'),StringGrid1.Row]:='';
//  StringGrid1.Cells[str_list.IndexOfName('Rkey391'),StringGrid1.Row]:='';
  StringGrid1.Cells[str_list.IndexOfName('�ر�Ҫ��'),StringGrid1.Row]:='';
end;

procedure TfrmPOruku_Mod564.PopupMenu1Popup(Sender: TObject);
begin
  inherited;
  if (StrToInt(StringGrid1.Cells[str_list.IndexOfName('mark'),StringGrid1.Row])>1) then
  IQC1.Enabled:=True else IQC1.Enabled:=False;
end;

function TfrmPOruku_Mod564.Power(x, y : extended) : extended;
begin
  result := exp(y*ln(x));
end;

procedure TfrmPOruku_Mod564.StringGrid1DrawCell(Sender: TObject; ACol,
  ARow: Integer; Rect: TRect; State: TGridDrawState);
begin
  inherited;
  if (gdSelected  in State) then
  begin
    if (ACol = 13 ) then
    begin
      dtpk1.Left := Rect.Left;
      dtpk1.Top := Rect.Top;
      dtpk1.Width := Rect.Right - Rect.Left+3;
      dtpk1.Height := Rect.Bottom - Rect.Top;
      dtpk1.Visible := True;
      if trim(StringGrid1.Cells[acol,arow])<>'' then
        dtpk1.Date:=strtodate(StringGrid1.Cells[acol,arow]);
    end
    else
      dtpk1.Visible :=false;
  end;
end;

procedure TfrmPOruku_Mod564.StringGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if (key=112) and (CBLoc.Visible) then
  begin
    if CBLoc.Enabled then
    begin
      CBLoc.SetFocus;
      CBLoc.DroppedDown:=true;
    end;
  end;
end;

procedure TfrmPOruku_Mod564.StringGrid1KeyPress(Sender: TObject; var Key: Char);
begin
  inherited;
  if (key <> chr(9)) then    //û�а�tab��
  begin
    if (StringGrid1.Col=8) then
     begin
      CBLoc.SetFocus;
      SendMessage(CBLoc.Handle,WM_Char,word(Key),0);
     end;
  end;
  if (StringGrid1.Col = 7 ) then
  begin
    if not CharInSet(Key,['0'..'9','.',#8,#13]) then  //�ж��Ƿ��������ֺ�С����
      abort
    else
    if key = chr(46) then
    begin      //�ж��Ƿ��ظ�����С����'.'
      if pos('.',StringGrid1.Cells[7,StringGrid1.Row])>0  then abort;
    end;
  end;
end;

procedure TfrmPOruku_Mod564.StringGrid1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
if StringGrid1.Col=str_list.IndexOfName('��ǰ����') then
 begin
  if StringGrid1.Cells[str_list.IndexOfName('��ǰ����'),StringGrid1.Row]='' then StringGrid1.Cells[str_list.IndexOfName('��ǰ����'),StringGrid1.Row]:='0';
  if (StringGrid1.Cells[str_list.IndexOfName('IF���'),StringGrid1.Row]='N') then   //�����������ܴ��ڶ�������
  if strtofloat(StringGrid1.Cells[4,StringGrid1.Row])>0 then//ת���ʴ���0
   begin
    if strtofloat(StringGrid1.Cells[7,StringGrid1.Row])>
      (strtofloat(StringGrid1.Cells[3,StringGrid1.Row])-strtofloat(StringGrid1.Cells[5,StringGrid1.Row]))*
       strtofloat(StringGrid1.Cells[4,StringGrid1.Row])  then
     StringGrid1.Cells[7,StringGrid1.Row]:=floattostr(
                                     (strtofloat(StringGrid1.Cells[3,StringGrid1.Row])-
                                      strtofloat(StringGrid1.Cells[5,StringGrid1.Row]))*
                                      strtofloat(StringGrid1.Cells[4,StringGrid1.Row])
                                                );
   end
  else
   begin
    if strtofloat(StringGrid1.Cells[7,StringGrid1.Row])>
     (strtofloat(StringGrid1.Cells[3,StringGrid1.Row])-strtofloat(StringGrid1.Cells[5,StringGrid1.Row])) then
     StringGrid1.Cells[7,StringGrid1.Row]:=floattostr(
                                      strtofloat(StringGrid1.Cells[3,StringGrid1.Row])-
                                      strtofloat(StringGrid1.Cells[5,StringGrid1.Row])
                                                );
   end;
 end;
end;

procedure TfrmPOruku_Mod564.StringGrid1SelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
var Lcds:TClientDataSet;
begin
  inherited;
  Lcds:=TClientDataSet.Create(Self);
  try
    if (ACol = 8 ) then
    begin
      CBLoc.Width := StringGrid1.DefaultColWidth;
      CBLoc.Height := StringGrid1.DefaultRowHeight;
      CBLoc.Left := StringGrid1.Left+(ACol-StringGrid1.LeftCol+1)*CBLoc.Width+10;
      if (ARow<StringGrid1.TopRow)  then
      CBLoc.Top := StringGrid1.Top+(ARow - StringGrid1.TopRow+2)* StringGrid1.DefaultRowHeight+ (ARow - StringGrid1.TopRow+5)
      else if (((ARow + 3 - StringGrid1.TopRow ) * StringGrid1.DefaultRowHeight) > StringGrid1.Height) then
      CBLoc.Top := StringGrid1.Top+(ARow - StringGrid1.TopRow)* StringGrid1.DefaultRowHeight+ (ARow - StringGrid1.TopRow+4)
      else
      CBLoc.Top := StringGrid1.Top+(ARow - StringGrid1.TopRow+1)* StringGrid1.DefaultRowHeight+ (ARow - StringGrid1.TopRow+4);
//      if (ARow<StringGrid1.TopRow)  then
//      CBLoc.Top := StringGrid1.Top+(ARow - StringGrid1.TopRow)* StringGrid1.DefaultRowHeight+ (ARow - StringGrid1.TopRow)
//      else
//      CBLoc.Top := StringGrid1.Top+(ARow - StringGrid1.TopRow+1)* StringGrid1.DefaultRowHeight+ (ARow - StringGrid1.TopRow+1);
      CBLoc.Visible := True;
      if StringGrid1.Cells[acol,arow]<>'' then
      begin
       CBLoc.ItemIndex:=CBLoc.Items.IndexOf(StringGrid1.Cells[acol,arow]);
      end else
       CBLoc.ItemIndex:=-1;
    end
    else
      CBLoc.Visible :=false;

    if (ACol = 10 ) then
    begin
      ComboBox3.Width := StringGrid1.DefaultColWidth;
      ComboBox3.Height := StringGrid1.DefaultRowHeight;
      ComboBox3.Left := StringGrid1.Left+(ACol-StringGrid1.LeftCol+1)*CBLoc.Width+10;
      if (ARow<StringGrid1.TopRow)  then
      ComboBox3.Top := StringGrid1.Top+(ARow - StringGrid1.TopRow+2)* StringGrid1.DefaultRowHeight+ (ARow - StringGrid1.TopRow+5)
      else if ((ARow + 3 - StringGrid1.TopRow ) * StringGrid1.DefaultRowHeight) > StringGrid1.Height  then
      ComboBox3.Top := StringGrid1.Top+(ARow - StringGrid1.TopRow)* StringGrid1.DefaultRowHeight+ (ARow - StringGrid1.TopRow+4)
      else
      ComboBox3.Top := StringGrid1.Top+(ARow - StringGrid1.TopRow+1)* StringGrid1.DefaultRowHeight+ (ARow - StringGrid1.TopRow+4);
//      if (ARow<StringGrid1.TopRow)  then
//      ComboBox3.Top := StringGrid1.Top+(ARow - StringGrid1.TopRow)* StringGrid1.DefaultRowHeight+ (ARow - StringGrid1.TopRow)
//      else
//      ComboBox3.Top := StringGrid1.Top+(ARow - StringGrid1.TopRow+1)* StringGrid1.DefaultRowHeight+ (ARow - StringGrid1.TopRow+1);
      ComboBox3.Visible := True;
      if (StringGrid1.Cells[acol,arow]<>'') and (ComboBox3.Items.IndexOf(StringGrid1.Cells[acol,arow])=-1) then
        ComboBox3.Text:=StringGrid1.Cells[acol,arow]
      else if (StringGrid1.Cells[acol,arow]<>'') and (ComboBox3.Items.IndexOf(StringGrid1.Cells[acol,arow])<>-1) then
        ComboBox3.ItemIndex:=ComboBox3.Items.IndexOf(StringGrid1.Cells[acol,arow])
      else
      begin
        combobox3.Items.Clear;
        combobox3.Text:='';
      end;
      if ((ComboBox3.Visible=True) and (StringGrid1.Cells[8,ARow]<>'')) then
      begin
        gSvrIntf.IntfGetDataBySql('select * from Data0176 where rkey_16 = ' + IntToStr(integer(CBLoc.items.objects[CBLoc.Items.IndexOf(StringGrid1.Cells[8,aRow])]))+'',Lcds);
        if not Lcds.IsEmpty then
        begin
          Lcds.First;
          combobox3.Items.Clear;
          while not Lcds.Eof do
          begin
            combobox3.Items.Add(Lcds.FieldByName('LOCATION').Value);
            Lcds.Next;
          end;
        end;
      end;
      if (StringGrid1.Cells[8,ARow]='') then
      begin
        combobox3.Items.Clear;
        combobox3.Text:='';
      end;
    end
    else
      ComboBox3.Visible :=false;
  finally
    Lcds.Free;
  end;

  if (FEditType=3) then
    StringGrid1.Options:=StringGrid1.Options-[goEditing]
  else
  if ((FEditType =0) or (FEditType =1)) and (StringGrid1.Cells[str_list.IndexOfName('IF���'),ARow]='Y') then
  begin
    if (acol<=8) or (ACol=12) or (ACol>=14) then
      StringGrid1.Options:=StringGrid1.Options-[goEditing]
    else
      StringGrid1.Options:=StringGrid1.Options+[goEditing];
  end else
  if ((FEditType =0) or (FEditType =1)) and (StringGrid1.Cells[str_list.IndexOfName('IF���'),ARow]='N') then
  begin
    if (acol<=6) or (ACol=12) or (ACol>=14) then
      StringGrid1.Options:=StringGrid1.Options-[goEditing]
    else
      StringGrid1.Options:=StringGrid1.Options+[goEditing];
  end else
  begin
    if (acol<7) or (ACol=12) or (ACol>=14) then
      StringGrid1.Options:=StringGrid1.Options-[goEditing]
    else
      StringGrid1.Options:=StringGrid1.Options+[goEditing];
  end;
end;


procedure TfrmPOruku_Mod564.btnCloseClick(Sender: TObject);
begin
  inherited;
  Close;
end;

procedure TfrmPOruku_Mod564.btnSaveClick(Sender: TObject);
var Lcds:TClientDataSet;
    LsName,Lsql28:string;
    i,LiTmp:Integer;
    LPostData: OleVariant;
    Lstr391,Lstr71:string;
    Lsq391,Lsq71,Lsq04,Lsq70_2:string;
    LCaseSL:Boolean;
    LCase70:Boolean;
begin
  inherited;
  Lcds:=TClientDataSet.Create(Self);
  try
    if trim(redt9.Text)='' then
    begin
      showmessage('�ͻ����Ų���Ϊ��...');
      exit;
    end;
    //�������Ĳֿⲻ�ܶ�Ϊ��
    if IfWarehouse() then
    begin
      showmessage('������Ҫһ����ּ�¼���������λ��!');
      exit;
    end;
    if IfDateNow() then
    begin
      ShowMessage('������һ����ּ�¼�������ڴ��ڵ�ǰ����,������Ҫ��,���޸������������');
      Exit;
    end;
    LCaseSL:=False;
    LCase70:=False;
    case FEditType of
      0:  //����
      begin
        Lsql28:='';
        Lstr391:='';
        Lstr71:='';
        LiTmp:=0;
        if trim(redt1.Text)='' then
        begin
          showmessage('���Ų���Ϊ��...');
          exit;
        end;
        cds133.Edit;
        gSvrIntf.IntfGetDataBySql('select * from data0133 where GRN_NUMBER = ''' + Trim(redt1.Text)+'''',Lcds);
        if not Lcds.IsEmpty then
        begin
          if messagedlg('��ֱ���ظ�,�����ж�̨�����ͬʱ����,�Ƿ��Զ����±��?',mtConfirmation,[mbYes,mbNo],0)=mrYes  then
          begin
            LGRName:=update04('data0133',LsName);
            cds133.FieldByName('GRN_NUMBER').Value:=LsName;
          end;
        end;
        cds133.FieldByName('ship_BY').Value:=redt8.Text;
        cds133.FieldByName('DELIVER_NUMBER').Value:=redt9.Text;
        cds133.FieldByName('ship_DATE').Value:=dtpReqDate.DateTime;
        cds133.FieldByName('REF_NUMBER').Value:=redt4.Text;
        cds133.Post;

        if not cds134.IsEmpty then
          while not cds134.Eof  do cds134.Delete;
          
        for I := 1 to StringGrid1.RowCount-1 do
        begin
          if (StrToFloat(StringGrid1.Cells[str_list.IndexOfName('��ǰ����'),i])>0) then
          begin
            cds134.Append;
            cds134.FieldByName('INVENTORY_PTR').Value:=StringGrid1.Cells[str_list.IndexOfName('17rkey'),i]; //ԭ����ָ��0017
            cds134.FieldByName('SOURCE_PTR').Value:=StringGrid1.Cells[str_list.IndexOfName('71rkey'),i]; //data0071.rkey
            cds134.FieldByName('LOCATION_PTR').Value:=StringGrid1.Cells[str_list.IndexOfName('16rkey'),i]; //�ֿ�λ��data0016
            cds134.FieldByName('UNIT_PTR').Value:=StringGrid1.Cells[str_list.IndexOfName('�����λ02'),i]; //�����λ02
            cds134.FieldByName('QUANTITY').Value:=StringGrid1.Cells[str_list.IndexOfName('��ǰ����'),i]; //�ѽ��յ�����
            cds134.FieldByName('QUAN_ON_HAND').Value:=StringGrid1.Cells[str_list.IndexOfName('��ǰ����'),i];//�ֳ�������
            cds134.FieldByName('tax_price').Value:=StringGrid1.Cells[str_list.IndexOfName('��˰��'),i];//�۸�˰
            cds134.FieldByName('PRICE').Value:=StrToCurr(StringGrid1.Cells[str_list.IndexOfName('��˰��'),i])/(1+strtofloat(StringGrid1.Cells[str_list.IndexOfName('˰��'),i])*0.01); // �۸񲻺�˰
            cds134.FieldByName('TAX_2').Value:=StringGrid1.Cells[str_list.IndexOfName('˰��'),i]; //˰��
            cds134.FieldByName('BARCODE_ID').Value:=StringGrid1.Cells[str_list.IndexOfName('�ر�Ҫ��'),i];//�ر�Ҫ��
            cds134.FieldByName('SUPPLIER2').Value:=StringGrid1.Cells[str_list.IndexOfName('��ϸλ��'),i]; //��ϸλ��
            Lsql28:='select qte_price2 from data0028 where inventory_ptr = '
            + Trim(StringGrid1.Cells[str_list.IndexOfName('17rkey'),i])
            +' and supplier_ptr='+cds133.FieldByName('SUPP_PTR').AsString;
            gSvrIntf.IntfGetDataBySql(Lsql28,Lcds);
            if not Lcds.IsEmpty then
            begin
              if Lcds.FieldByName('qte_price2').AsInteger = 0 then cds134.FieldByName('EXPIRE_DATE').AsVariant:= null
              else cds134.FieldByName('EXPIRE_DATE').Value:=StrToDate(StringGrid1.Cells[str_list.IndexOfName('��������'),i])+Lcds.FieldByName('qte_price2').AsInteger//��Ч��(��)
            end
            else
            begin
              if StrToInt(StringGrid1.Cells[str_list.IndexOfName('������Ч��'),i]) = 0 then cds134.FieldByName('EXPIRE_DATE').AsVariant:= null
              else cds134.FieldByName('EXPIRE_DATE').Value:=StrToDate(StringGrid1.Cells[str_list.IndexOfName('��������'),i])+StrToInt(StringGrid1.Cells[str_list.IndexOfName('������Ч��'),i]);//��Ч��(��)
            end;
            cds134.FieldByName('rohs').Value:=StringGrid1.Cells[str_list.IndexOfName('������ʶ'),i]; //����ROHS
            cds134.FieldByName('MANU_DATE').Value:=StringGrid1.Cells[str_list.IndexOfName('��������'),i]; //��������
            cds134.FieldByName('SUPPLIER3').Value:=StringGrid1.Cells[str_list.IndexOfName('����������'),i];//ԭ������
            cds134.FieldByName('D133_IDKey').Value:=cds133.FieldByName('idkey').Value;
            cds134.FieldByName('rkey391').Value:=StringGrid1.Cells[str_list.IndexOfName('Rkey391'),i];//391
            cds134.FieldByName('QUAN_RETURNED').Value:=0;
            cds134.Post;
            LiTmp:=LiTmp+1;
          end;
          if (StringGrid1.Cells[str_list.IndexOfName('IF���'),i]='Y') and (StringGrid1.Cells[str_list.IndexOfName('Rkey391'),i]<>'') then
          begin
            Lstr391:=Lstr391+StringGrid1.Cells[str_list.IndexOfName('Rkey391'),i]+',';
          end;
          if (StringGrid1.Cells[str_list.IndexOfName('71rkey'),i]<>'') then
          begin
            Lstr71:=Lstr71+StringGrid1.Cells[str_list.IndexOfName('71rkey'),i]+',';
          end;
        end;
        if (LiTmp>0) then
        begin
          Lsq391:='select * from data0391 where rkey in (' + Lstr391+'-1)';
          Lsq71:='select * from data0071 where rkey in (' + Lstr71+'-1)';
          Lsq04:='select * from data0004 where table_name=''data0133''';
          Lsq70_2:='select * from Data0070 where rkey='+cds133.FieldByName('PO_PTR').AsString+'';
          if not gSvrIntf.IntfGetDataBySqlArr(VarArrayOf([Lsq391,Lsq71,Lsq04,Lsq70_2]),[cds391,cds71,cds04,cds70]) then
          begin
            ShowMessage('ȡ������ʧ�ܣ�����ϵ����Ա');
            exit;
          end;

          for I := 1 to StringGrid1.RowCount-1 do
          begin
            if (StrToFloat(StringGrid1.Cells[str_list.IndexOfName('��ǰ����'),i])>0) then
            begin
            //�޸�391״̬��391
              cds391.Filtered:=False;
              cds391.Filter:='';
              cds391.Filter:='Rkey ='+StringGrid1.Cells[str_list.IndexOfName('Rkey391'),i];
              cds391.Filtered:=True;
              if not cds391.IsEmpty then
              begin
                cds391.Edit;
                cds391.FieldByName('stock_over').Value:=1;
                cds391.Post;
              end;
            //�޸�71�ѽ�����
              cds71.Filtered:=False;
              cds71.Filter:='';
              cds71.Filter:='Rkey ='+StringGrid1.Cells[str_list.IndexOfName('71rkey'),i];
              cds71.Filtered:=True;
              if not cds71.IsEmpty then
              begin
                cds71.Edit;
                cds71.FieldByName('QUAN_RECD').Value:=cds71.FieldByName('QUAN_RECD').Value+StrToFloat(StringGrid1.Cells[str_list.IndexOfName('��ǰ����'),i])*StrtoFloat(StringGrid1.Cells[str_list.IndexOfName('ת����'),i]); //�ѽ��յ�����
                cds71.FieldByName('recd_DATE').Value:=dtpReqDate.DateTime; //�������������
                cds71.Post;
              end;
            end;
          end;

          //����04
          cds04.Edit;
          cds04.FieldByName('SEED_VALUE').Value:=LGRName;
          cds04.Post;
          //���ж������������.����70
          for I := 1 to StringGrid1.RowCount-1 do
          begin
            cds71.Filtered:=False;
            cds71.Filter:='';
            cds71.Filter:='Rkey ='+StringGrid1.Cells[str_list.IndexOfName('71rkey'),i];
            cds71.Filtered:=True;
            if not cds71.IsEmpty then
            begin
//              if ((cds71.FieldByName('QUAN_IN_INSP').Value > 0) and (cds71.FieldByName('QUAN_RECD').Value>cds71.FieldByName('QUAN_IN_INSP').Value) and (cds71.FieldByName('avl_flag').Value='Y')) then LCaseSL:=True;
              if (cds71.FieldByName('QUAN_RECD').Value<cds71.FieldByName('QUAN_ORD').Value) then LCase70:=True;
            end;
          end;
          //���������Ƿ����ͨ����
//          if LCaseSL then
//          begin
//            ShowMessage('��������ʧ��,����������˼��ͨ����!');
//            Exit;
//          end;

          //���ж������������.����70
          if (LCase70=False) then
          begin
            cds70.Edit;
            cds70.FieldByName('STATUS').Value:=6;
            cds70.Post;
          end;
          if cds133.State in [dsEdit,dsInsert] then cds133.Post;
          if cds134.State in [dsEdit,dsInsert] then cds134.Post;
          if cds71.State in [dsEdit,dsInsert] then cds71.Post;
          if cds391.State in [dsEdit,dsInsert] then cds391.Post;
          if cds04.State in [dsEdit,dsInsert] then cds04.Post;
          if cds70.State in [dsEdit,dsInsert] then cds70.Post;

          LPostData := VarArrayCreate([0,5],varVariant);
          if cds133.ChangeCount > 0 then
            LPostData[0] := cds133.Delta;
          if cds134.ChangeCount > 0 then
            LPostData[1] := cds134.Delta;
          if cds04.ChangeCount > 0 then
            LPostData[2] := cds04.Delta;
          if cds70.ChangeCount > 0 then
            LPostData[3] := cds70.Delta;
          if cds391.ChangeCount > 0 then
            LPostData[4] := cds391.Delta;
          if cds71.ChangeCount > 0 then
            LPostData[5] := cds71.Delta;
          if gSvrIntf.IntfPostModData('��������',564,LPostData) then
          begin
            cds133.MergeChangeLog;
            cds134.MergeChangeLog;
            cds04.MergeChangeLog;
            cds70.MergeChangeLog;
            cds391.MergeChangeLog;
            cds71.MergeChangeLog;
            ShowMessage('����ɹ�');
            if Assigned(refresh) then
              refresh(nil);
            Close;
          end;
        end;
      end;
      1: //�༭���������޸Ĵ�391��ȡ������
      begin
        gSvrIntf.IntfGetDataBySql('select rkey from data0134 where quantity<>quan_on_hand and GRN_PTR='+cds133.FieldByName('Rkey').AsString,Lcds);
        if not Lcds.IsEmpty then //
        begin
          ShowMessage('����¼�����仯,�����ٱ༭!');
          exit;
        end;
        cds133.Edit;
        cds133.FieldByName('ship_BY').Value:=redt8.Text;//�ͻ���Ա
        cds133.FieldByName('DELIVER_NUMBER').Value:=redt9.Text; // ��Ӧ���ͻ�����
        cds133.FieldByName('REF_NUMBER').Value:=redt4.Text; // ��ע
        cds133.FieldByName('ship_DATE').Value:=dtpReqDate.DateTime; //�ͻ�����
        cds133.Post;

        for I := 1 to StringGrid1.RowCount-1 do
        begin
//          if (StringGrid1.Cells[str_list.IndexOfName('IF���'),i]='N') then
//          begin
            Lstr71:=Lstr71+StringGrid1.Cells[str_list.IndexOfName('71rkey'),i]+',';
            Lstr391:=Lstr391+StringGrid1.Cells[str_list.IndexOfName('Rkey391'),i]+',';
//          end;
        end;
        Lsq71:='select * from data0071 where rkey in (' + Lstr71+'-1)';
        Lsq391:='select * from data0391 where rkey in (' + Lstr391+'-1)';
        gSvrIntf.IntfGetDataBySqlArr(VarArrayOf([Lsq71,Lsq391]),[cds71,cds391]);

        //����134
        for I := 1 to StringGrid1.RowCount-1 do
        begin
            cds71.Filtered:=False;
            cds71.Filter:='';
            cds71.Filter:='Rkey ='+StringGrid1.Cells[str_list.IndexOfName('71rkey'),i];
            cds71.Filtered:=True;
            if not cds71.IsEmpty then
            begin
              cds71.Edit;
              cds71.FieldByName('QUAN_RECD').Value:=cds71.FieldByName('QUAN_RECD').Value+(StrToFloat(StringGrid1.Cells[str_list.IndexOfName('��ǰ����'),i])-StrToFloat(StringGrid1.Cells[str_list.IndexOfName('��ǰ����2'),i]))*StrtoFloat(StringGrid1.Cells[str_list.IndexOfName('ת����'),i]); //�ѽ��յ�����
              cds71.FieldByName('recd_DATE').Value:=dtpReqDate.DateTime; //�������������
              cds71.Post;
            end;

//          if (StrToFloat(StringGrid1.Cells[str_list.IndexOfName('��ǰ����'),i])>0) then
//          begin
            cds134.Filtered:=False;
            cds134.Filter:='';
            cds134.Filter:='Rkey ='+StringGrid1.Cells[str_list.IndexOfName('rkey'),i];
            cds134.Filtered:=True;
            if not cds134.IsEmpty then
            begin
              cds134.Edit;
              cds134.FieldByName('LOCATION_PTR').Value:=StringGrid1.Cells[str_list.IndexOfName('16rkey'),i]; //�ֿ�λ��data0016
              cds134.FieldByName('QUANTITY').Value:=StringGrid1.Cells[str_list.IndexOfName('��ǰ����'),i]; //�ѽ��յ�����
              cds134.FieldByName('QUAN_ON_HAND').Value:=StringGrid1.Cells[str_list.IndexOfName('��ǰ����'),i];//�ֳ�������
              cds134.FieldByName('BARCODE_ID').Value:=StringGrid1.Cells[str_list.IndexOfName('�ر�Ҫ��'),i];//�ر�Ҫ��
              cds134.FieldByName('SUPPLIER2').Value:=StringGrid1.Cells[str_list.IndexOfName('��ϸλ��'),i]; //��ϸλ��
              Lsql28:='select qte_price2 from data0028 where inventory_ptr = '
              + Trim(StringGrid1.Cells[str_list.IndexOfName('17rkey'),i])
              +' and supplier_ptr='+cds133.FieldByName('SUPP_PTR').AsString;
              gSvrIntf.IntfGetDataBySql(Lsql28,Lcds);
              if not Lcds.IsEmpty then
              begin
                if Lcds.FieldByName('qte_price2').AsInteger = 0 then cds134.FieldByName('EXPIRE_DATE').AsVariant:= null
                else cds134.FieldByName('EXPIRE_DATE').Value:=StrToDate(StringGrid1.Cells[str_list.IndexOfName('��������'),i])+Lcds.FieldByName('qte_price2').AsInteger//��Ч��(��)
              end
              else
              begin
                if StrToInt(StringGrid1.Cells[str_list.IndexOfName('������Ч��'),i]) = 0 then cds134.FieldByName('EXPIRE_DATE').AsVariant:= null
                else cds134.FieldByName('EXPIRE_DATE').Value:=StrToDate(StringGrid1.Cells[str_list.IndexOfName('��������'),i])+StrToInt(StringGrid1.Cells[str_list.IndexOfName('������Ч��'),i]);//��Ч��(��)
              end;
//              if not Lcds.IsEmpty then
//              begin
//                cds134.FieldByName('EXPIRE_DATE').Value:=StrToDate(StringGrid1.Cells[str_list.IndexOfName('��������'),i])+Lcds.FieldByName('qte_price2').AsInteger//��Ч��(��)
//              end else
//                cds134.FieldByName('EXPIRE_DATE').Value:=StrToDate(StringGrid1.Cells[str_list.IndexOfName('��������'),i])+StrToInt(StringGrid1.Cells[str_list.IndexOfName('������Ч��'),i]);//��Ч��(��)
              cds134.FieldByName('MANU_DATE').Value:=StringGrid1.Cells[str_list.IndexOfName('��������'),i]; //��������
              cds134.FieldByName('SUPPLIER3').Value:=StringGrid1.Cells[str_list.IndexOfName('����������'),i];//ԭ������
              if (StrToFloat(StringGrid1.Cells[str_list.IndexOfName('��ǰ����'),i])>0) then
                cds134.FieldByName('rkey391').Value:= StringGrid1.Cells[str_list.IndexOfName('rkey391'),i]//391
              else
                cds134.FieldByName('rkey391').AsVariant:= null;
              cds134.Post;
            end;

            cds391.Filtered:=False;
            cds391.Filter:='';
            cds391.Filter:='Rkey ='+StringGrid1.Cells[str_list.IndexOfName('Rkey391'),i];
            cds391.Filtered:=True;
            if not cds391.IsEmpty then
            begin
              cds391.Edit;
              if (StrToFloat(StringGrid1.Cells[str_list.IndexOfName('��ǰ����'),i])=0) then
                  cds391.FieldByName('stock_over').Value:=0
              else  if (StrToFloat(StringGrid1.Cells[str_list.IndexOfName('��ǰ����'),i])>0) then
                  cds391.FieldByName('stock_over').Value:=1;
              cds391.Post;
            end;
//          end;
          //�ж�71�Ƿ�ȫ�����
          if (StrToFloat(StringGrid1.Cells[str_list.IndexOfName('��������'),i])<>(StrToFloat(StringGrid1.Cells[str_list.IndexOfName('�ѽ���'),i])+(StrToFloat(StringGrid1.Cells[str_list.IndexOfName('��ǰ����'),i])))) then LCase70:=True;
        end;
        //���ж������������.����70
        if (LCase70=False) then
        begin
//          gSvrIntf.IntfGetDataBySql('select * from Data0070 where rkey='+cds133.FieldByName('PO_PTR').AsString+'',cds70);
//          cds70.Edit;
//          cds70.FieldByName('status').Value:=6;
//          cds70.Post;
        end else
        begin
          gSvrIntf.IntfGetDataBySql('select * from Data0070 where rkey='+cds133.FieldByName('PO_PTR').AsString+'',cds70);
          cds70.Edit;
          cds70.FieldByName('status').Value:=5;
          cds70.Post;
        end;

        if cds133.State in [dsEdit,dsInsert] then cds133.Post;
        if cds134.State in [dsEdit,dsInsert] then cds134.Post;
        if cds71.State in [dsEdit,dsInsert] then cds71.Post;
        if cds391.State in [dsEdit,dsInsert] then cds391.Post;
        if cds04.State in [dsEdit,dsInsert] then cds04.Post;
        if cds70.State in [dsEdit,dsInsert] then cds70.Post;

        LPostData := VarArrayCreate([0,5],varVariant);
        if cds133.ChangeCount > 0 then
          LPostData[0] := cds133.Delta;
        if cds134.ChangeCount > 0 then
          LPostData[1] := cds134.Delta;
        if cds04.ChangeCount > 0 then
          LPostData[2] := cds04.Delta;
        if cds70.ChangeCount > 0 then
          LPostData[3] := cds70.Delta;
        if cds391.ChangeCount > 0 then
          LPostData[4] := cds391.Delta;
        if cds71.ChangeCount > 0 then
          LPostData[5] := cds71.Delta;
        if gSvrIntf.IntfPostModData('��������',564,LPostData) then
        begin
          if cds133.ChangeCount > 0 then cds133.MergeChangeLog;
          if cds134.ChangeCount > 0 then cds134.MergeChangeLog;
          if cds04.ChangeCount > 0 then cds04.MergeChangeLog;
          if cds70.ChangeCount > 0 then cds70.MergeChangeLog;
          if cds391.ChangeCount > 0 then cds391.MergeChangeLog;
          if cds71.ChangeCount > 0 then cds71.MergeChangeLog;
          ShowMessage('����ɹ�');
          if Assigned(refresh) then
              refresh(nil);
          Close;
        end;
      end;
    end;
  finally
    Lcds.Free;
  end;
end;

procedure TfrmPOruku_Mod564.Button1Click(Sender: TObject);
var i,iCount:Integer;
    Lcds:TClientDataSet;
begin
  inherited;
  Lcds:=TClientDataSet.Create(Self);
  try
    if (FEditType=0) then
    begin
  //ֻҪ�Ǽ����ϣ����ձ����391IQC�ж�ȡ��Ϣ----
      iCount:=0;
      for I := 1 to StringGrid1.RowCount-1 do
      begin
        if (StringGrid1.Cells[str_list.IndexOfName('IF���'),i]='Y') and (StrToFloat(StringGrid1.Cells[str_list.IndexOfName('��������'),i])>StrToFloat(StringGrid1.Cells[str_list.IndexOfName('�ѽ���'),i])) then
        begin
          if not gSvrIntf.IntfGetDataBySql('select * from data0391 where Rkey71='+StringGrid1.Cells[str_list.IndexOfName('71rkey'),i]+' and Rkey17='+StringGrid1.Cells[str_list.IndexOfName('17rkey'),i]+' and stock_over=0 and ( status=2 or status=1 ) order by auth_date',LCds) then Exit;
          if (not Lcds.IsEmpty) then  //��Ӧһ��IQC�������391
          begin
            iCount:=iCount+1;
            StringGrid1.Cells[str_list.IndexOfName('��ǰ����'),i]:=LCds.FieldByName('rece_qty').AsString;
            StringGrid1.Cells[str_list.IndexOfName('��������'),i]:=LCds.FieldByName('manufacture_TDATE').AsString;
            StringGrid1.Cells[str_list.IndexOfName('����������'),i]:=LCds.FieldByName('barch_no').AsString;
            StringGrid1.Cells[str_list.IndexOfName('mark'),i]:=IntToStr(Lcds.RecordCount);
            StringGrid1.Cells[str_list.IndexOfName('Rkey391'),i]:=Lcds.FieldByName('Rkey').AsString;
            StringGrid1.Cells[str_list.IndexOfName('�ر�Ҫ��'),i]:=LCds.FieldByName('supplier_model').AsString;
          end;
        end else if (StringGrid1.Cells[str_list.IndexOfName('IF���'),i]='N') then
        begin
          StringGrid1.Cells[str_list.IndexOfName('��ǰ����'),i]:=StringGrid1.Cells[str_list.IndexOfName('�ѽ���'),i];
        end;// else StringGrid1.Cells[str_list.IndexOfName('��ǰ����'),i]:='0';
      end;
      if (iCount=0) then
      begin
        ShowMessage('��ǰICQû��ͨ������');
      end;
    end else
    if (FEditType=2) then
    begin
      for I := 1 to StringGrid1.RowCount-1 do
      begin
        if (StringGrid1.Cells[str_list.IndexOfName('IF���'),i]='N') then
        StringGrid1.Cells[str_list.IndexOfName('��ǰ����'),i]:=StringGrid1.Cells[str_list.IndexOfName('�ѽ���'),i];
      end;
    end;
  finally
    LCds.Free;
  end;
end;

procedure TfrmPOruku_Mod564.Button2Click(Sender: TObject);
var i,iCount:Integer;
    Lcds:TClientDataSet;
begin
  inherited;
  Lcds:=TClientDataSet.Create(Self);
  iCount:=0;
  try
//ֻҪ�Ǽ����ϣ����ձ����391IQC�ж�ȡ��Ϣ----
    for I := 1 to StringGrid1.RowCount-1 do
    begin
      if (StringGrid1.Cells[str_list.IndexOfName('IF���'),i]='Y') and (StrToFloat(StringGrid1.Cells[str_list.IndexOfName('��������'),i])>StrToFloat(StringGrid1.Cells[str_list.IndexOfName('�ѽ���'),i])) then
      begin
        if not gSvrIntf.IntfGetDataBySql('select * from data0391 where Rkey71='+StringGrid1.Cells[str_list.IndexOfName('71rkey'),i]+' and Rkey17='+StringGrid1.Cells[str_list.IndexOfName('17rkey'),i]+' and stock_over=0 and ( status=2 or status=1 ) order by auth_date',LCds) then Exit;
        if (not Lcds.IsEmpty) then  //��Ӧһ��IQC�������391
        begin
          iCount:=iCount+1;
          StringGrid1.Cells[str_list.IndexOfName('��ǰ����'),i]:=LCds.FieldByName('rece_qty').AsString;
          StringGrid1.Cells[str_list.IndexOfName('��������'),i]:=LCds.FieldByName('manufacture_TDATE').AsString;
          StringGrid1.Cells[str_list.IndexOfName('����������'),i]:=LCds.FieldByName('barch_no').AsString;
          StringGrid1.Cells[str_list.IndexOfName('�ر�Ҫ��'),i]:=LCds.FieldByName('supplier_model').AsString;
          StringGrid1.Cells[str_list.IndexOfName('mark'),i]:=IntToStr(Lcds.RecordCount);
          StringGrid1.Cells[str_list.IndexOfName('Rkey391'),i]:=Lcds.FieldByName('Rkey').AsString;
        end;
      end else Continue;
    end;
    if (iCount=0) then
    begin
      ShowMessage('��ǰICQû��ͨ������');
    end;
  finally
    LCds.Free;
  end;
end;

procedure TfrmPOruku_Mod564.CBlocExit(Sender: TObject);
begin
  inherited;
  if (CBloc.itemindex<>-1) then
  begin
    StringGrid1.Cells[str_list.IndexOfName('�ֿ�λ��'),StringGrid1.Row]:=CBLoc.Text;
    StringGrid1.Cells[str_list.IndexOfName('16rkey'),StringGrid1.Row]:=IntToStr(integer(CBloc.items.objects[CBloc.itemindex]));
  end;
end;

procedure TfrmPOruku_Mod564.CBlocKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if key=112 then CBLoc.DroppedDown:=true;    //f2
  if key=13 then StringGrid1.SetFocus;
end;

procedure TfrmPOruku_Mod564.ComboBox3Exit(Sender: TObject);
begin
  inherited;
  StringGrid1.Cells[str_list.IndexOfName('��ϸλ��'),StringGrid1.Row]:=combobox3.Text;
  if (combobox3.itemindex<>-1) then
  begin
    ComboBox3.Items.Clear;
  end;
end;

procedure TfrmPOruku_Mod564.ComboBox3KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if key=112 then ComboBox3.DroppedDown:=true;    //f2
  if key=13 then StringGrid1.SetFocus;
end;

procedure TfrmPOruku_Mod564.dtpk1Exit(Sender: TObject);
begin
  inherited;
  StringGrid1.Cells[str_list.IndexOfName('��������'),StringGrid1.Row]:=datetostr(dtpk1.Date);
end;

procedure TfrmPOruku_Mod564.dtpk1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  inherited;
  if key=13 then StringGrid1.SetFocus;
end;

procedure TfrmPOruku_Mod564.EnableEdit;
begin
  redt1.ReadOnly:=True;
  redt2.ReadOnly:=True;
  redt3.ReadOnly:=True;
  redt5.ReadOnly:=True;
  redt6.ReadOnly:=True;
  redt7.ReadOnly:=True;
end;

procedure TfrmPOruku_Mod564.GetData(ARkey: string);
var
  LSql33,LSql34: string;
begin
  // data0133
  LSql33 := 'select * from data0133 where rkey = ' + ARkey;

  // data0134
  LSql34 := 'select * from data0134 where GRN_PTR = ' + ARkey;

  if not gSvrIntf.IntfGetDataBySqlArr(VarArrayOf([LSql33,LSql34]),[cds133,cds134]) then Exit;
  if (FEditType=0) or (FEditType=1) then
  begin
    if (not cds133.IsEmpty) and (cds133.FieldByName('IDKEY').AsString = '') then
    begin
      cds133.Edit;
      cds133.FieldByName('IDKEY').AsString := gFunc.CreateIDKey;
      cds133.Post;
    end;
    cds134.DisableControls;
    try
      cds134.First;
      while not cds134.Eof do
      begin
        cds134.Edit;
        cds134.FieldByName('D133_IDKey').AsString := cds133.FieldByName('IDKEY').AsString;
        cds134.Post;
        cds134.Next;
      end;
      cds134.First;
    finally
      cds134.EnableControls;
    end;
  end;
end;
function TfrmPOruku_Mod564.update04(table_name: string;var LsName:string):string;
var
  i,v_length:integer;
  v_last,v_seed,new_seed:string;
begin
  if not gSvrIntf.IntfGetDataBySql('select * from data0004 where table_name='''+table_name+'''',cds04) then Exit;
  if not cds04.IsEmpty then
  begin
    v_seed:=cds04.FieldByName('SEED_VALUE').AsString;
    LsName:=v_seed;
    if cds04.FieldByName('SEED_FLAG').Value<>1 then
    begin
      v_length := length(v_seed);
      for i := v_length downto 1 do
      if (copy(v_seed,i,1)<'0') or (copy(v_seed,i,1)>'9') then  //�����������
      begin
        v_last := floattostr(power(10,v_length)+strtofloat(copy(v_seed,i+1,v_length-i))+1); //��׺��1
        new_seed := copy(v_seed,1,i)+copy(v_last,i+2,v_length-i); //ʹǰ׺�����׺��1
        break;
      end
      else
      if i=1 then //�����һλ��Ȼ������
        begin
         v_last := floattostr(power(10,v_length)+strtofloat(v_seed)+1);
         new_seed := copy(v_last,2,v_length);
        end;
    end;
  end;
  result:=new_seed;
end;

end.
