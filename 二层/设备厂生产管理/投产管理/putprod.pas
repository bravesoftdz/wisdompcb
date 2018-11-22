unit putprod;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, Grids, Menus,math;

type
  Tputprod_Form = class(TForm)
    Panel1: TPanel;
    Label4: TLabel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    ComboBox1: TComboBox;
    stg1: TStringGrid;
    Label1: TLabel;
    Label2: TLabel;
    stg2: TStringGrid;
    BitBtn3: TBitBtn;
    PopupMenu2: TPopupMenu;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    stg3: TStringGrid;
    procedure FormActivate(Sender: TObject);
    procedure stg1KeyPress(Sender: TObject; var Key: Char);
    procedure stg1SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure stg1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure BitBtn3Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure PopupMenu2Popup(Sender: TObject);
    procedure stg2MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure N5Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
  private
    { Private declarations }
    function cutno(cut_no:string;v_byte:byte): string;
    function find_chaotou(var row:integer):boolean;
    function find_468error(var row:integer):boolean;
    function find_468edit(cut_no:string):boolean;
    function findcut_noerror(var row:Integer):boolean;
    function find468cutno_error(var row:Integer):Boolean;
    function findcut_no(cut_no:string):Boolean;

    procedure update_04(v_seed: string);
  public
    { Public declarations }
    aded_flag:byte;   //1����2�༭3���
  end;

var
  putprod_Form: Tputprod_Form;

implementation

uses DAMO, Pick_Item_Single ,ConstVar, bominvt,common, DB;

{$R *.dfm}
procedure Tputprod_Form.update_04(v_seed: string);
var
  i,v_length:integer;
  v_last,new_seed:string;
begin
  if dm.aqy04SEED_FLAG.Value<>1 then
  begin
    v_length := length(v_seed);
    for i := v_length downto 1 do
    if (copy(v_seed,i,1)<'0') or (copy(v_seed,i,1)>'9') then  //�����������
    begin
      v_last := floattostr(power(10,v_length-1)+strtofloat(copy(v_seed,i+1,v_length-i))+1); //��׺��1
      new_seed := copy(v_seed,1,i)+copy(v_last,i+1,v_length-i);
      dm.aqy04.Edit; //ʹǰ׺�����׺��1
      dm.aqy04SEED_VALUE.Value := new_seed;
      dm.aqy04.Post;
      break;
    end
    else
    if i=1 then //�����һλ��Ȼ������
    begin
      v_last := floattostr(power(10,v_length)+strtofloat(v_seed)+1);
      new_seed := copy(v_last,2,v_length);
      dm.aqy04.Edit;
      dm.aqy04SEED_VALUE.Value := new_seed;
      dm.aqy04.Post;
    end;
  end;
end;

function Tputprod_Form.cutno(cut_no:string;v_byte:byte): string;
var
  i:integer;
begin
  result:='';
  for i:=1 to stg1.RowCount-1 do
  if stg1.Cells[0,i] = cut_no then
  begin
    if v_byte=0 then
      result:=stg1.Cells[2,i]
    else
      result:=stg1.Cells[15,i];
    break;
  end;
end;

function Tputprod_Form.find_chaotou(var row:integer): boolean;
var
 i,totol_qty:integer;
begin
  result:=false;
  totol_qty:=0;
  for i:=1 to stg1.RowCount-1 do
  begin
    if (trim(stg1.cells[4,i])<>'') then
      totol_qty:=totol_qty + strtoint(stg1.cells[4,i]);

    if combobox1.ItemIndex=0 then
      if (trim(stg1.cells[4,i])<>'') and (strtoint(stg1.cells[4,i]) > strtoint(stg1.cells[3,i])) and (trim(stg1.cells[9,i])='') then
      begin
       row:=i;
       result:=true;
       break;
      end
      else
    else
      if (trim(stg1.cells[4,i])<>'') and (strtoint(stg1.cells[4,i]) > 0) and (trim(stg1.cells[9,i])='') then
      begin
        row:=i;
        result:=true;
        break;
      end;
  end;
  if totol_qty<=0 then
  begin
    row:=0;
    result:=true;
  end;
end;

function Tputprod_Form.find_468error(var row: integer): boolean;
var
 i,i_j:integer;
begin
  result:=false;                   //������468���ϼ�¼,������492û��Ͷ����¼�����
  for i:=1 to stg2.RowCount-2 do
  begin
    for i_j:=1 to stg1.RowCount-1 do
    if stg2.Cells[0,i]=stg1.Cells[0,i_j] then
      if (trim(stg1.Cells[4,i_j])='') or (strtoint(stg1.Cells[4,i_j])<=0) then
      begin
        row:=i;
        result:=true;
        break;
      end;
    if row > 0 then break;
  end;
end;

procedure Tputprod_Form.FormActivate(Sender: TObject);
var
 i,stg2rowcount:integer;
begin
  with stg1 do
  begin
    cells[0,0]:='��������';
    cells[1,0]:='���۶���';
    cells[2,0]:='��Ʒ����';
    cells[3,0]:='��������';
    cells[4,0]:='Ͷ������';
    cells[5,0]:='���첿��';
    cells[6,0]:='Ͷ������';
    cells[7,0]:='�깤����';
    cells[8,0]:='��������';
    cells[9,0]:='��ע';

    cells[10,0]:='rkey15';
    cells[11,0]:='rkey08';
    cells[12,0]:='rkey34';
    cells[13,0]:='';    //���õ�Ԫ��
    cells[14,0]:='rkeycp71';
    cells[15,0]:='��Ʒ����';
    cells[16,0]:='��Ʒ���';

    ColWidths[10]:=-1;
    ColWidths[11]:=-1;
    ColWidths[12]:=-1;
    ColWidths[13]:=-1;
    ColWidths[14]:=-1;
  end;

  if self.aded_flag=2 then //�༭
  with stg1 do
  begin
    cells[0,1]:=dm.ADS492CUT_NO.Value; //'���ϵ���';
    cells[1,1]:=dm.ADS492SO_NO.Value; //'���۶���';
    cells[2,1]:=dm.ADS492PROD_CODE.Value; //'��Ʒ����';
    cells[3,1]:=dm.ADS492PLANNED_QTY.AsString; //'��������';
    cells[4,1]:=dm.ADS492ISSUED_QTY.AsString; //'Ͷ������';
    cells[5,1]:=dm.ADS492DEPT_NAME.Value; //'���첿��';
    cells[6,1]:=dm.ADS492ISSUE_DATE.AsString;// 'Ͷ������';
    cells[7,1]:=dm.ADS492SCH_COMPL_DATE.AsString; //'�깤����';
    cells[8,1]:=dm.ADS492warehouse_code.Value; //'��������';
    cells[9,1]:=dm.ADS492REMARK.Value; //'��ע';

    cells[10,1]:=dm.ADS492WHOUSE_PTR.AsString; //'rkey15';
    cells[11,1]:=dm.ADS492BOM_PTR.AsString; //'rkey08';
    cells[12,1]:=dm.ADS492mrb_ptr.AsString; //'rkey34';
    cells[13,1]:='';    //���õ�Ԫ��
    cells[14,1]:=dm.ADS492PRINTED_BY_PTR.AsString; //'rkeycp71';
    cells[15,1]:=dm.ADS492PRODUCT_NAME.Value; //'��Ʒ����';
    cells[16,1]:=dm.ADS492PRODUCT_DESC.Value; //'��Ʒ���';
  end;

  with stg2 do
  begin
    cells[0,0]:='��������';
    cells[1,0]:='���۶���';
    cells[2,0]:='���첿��';
    cells[3,0]:='';     //���õ�Ԫ��
    ColWidths[3]:=-1;
    cells[4,0]:='���ϱ���';
    cells[5,0]:='��������';
    cells[6,0]:='���Ϲ��';
    cells[7,0]:='��λ';
    cells[8,0]:='��ǰ���';
    cells[9,0]:='���';
    cells[10,0]:='����';
    cells[11,0]:='��ӡ';
    cells[12,0]:='��ע';
    cells[13,0]:='״̬';
    cells[14,0]:='';   //����
    cells[15,0]:='rkey17';
    ColWidths[14]:=-1;
    ColWidths[15]:=-1;
  end;

  if self.aded_flag=2 then //�༭
  begin


    stg2rowcount:=stg2.RowCount-2;

    with dm.ADOQuery1 do
    begin
      close;
      sql.Text:='SELECT data0468.rkey,Data0468.CUT_NO,Data0468.SO_NO,Data0002.UNIT_NAME,'+#13+
                'Data0468.QUAN_BOM,Data0468.PRINTIT,Data0468.VENDOR,'+#13+
                'CASE data0468.status WHEN 2 THEN ''��ȷ��'' WHEN 3 THEN ''���˻�'' END AS v_status,'+#13+
                'data0468.status,Data0468.INVENT_PTR,Data0008.PROD_CODE,'+#13+
                'Data0008.PRODUCT_NAME,Data0008.PRODUCT_DESC,Data0008.qty_onhand,data0008.rkey as rk08'+#13+
                'FROM Data0468 left JOIN'+#13+
                'Data0008 ON Data0468.INVENT_PTR = Data0008.RKEY left JOIN'+#13+
                'Data0002 ON Data0008.unit_ptr = Data0002.RKEY'+#13+
                'WHERE (Data0468.STATUS IN (2, 3)) AND (Data0468.invent_or = 1)'+#13+
                'and data0468.cut_no='+quotedstr(dm.ADS492CUT_NO.Value);
//      ShowMessage(sql.Text) ;
      open;
    end;
    stg2.RowCount:=stg2.RowCount+dm.ADOQuery1.RecordCount;
    stg3.RowCount:=stg2.RowCount;
    for i:=1 to dm.ADOQuery1.RecordCount do
    begin
      with stg2 do
      begin
        cells[0,i+stg2rowcount] := dm.ADOQuery1.fieldbyname('CUT_NO').AsString;          //'���ϵ���';
        cells[1,i+stg2rowcount] := dm.ADOQuery1.fieldbyname('SO_NO').AsString;           //'���۶���';
        cells[2,i+stg2rowcount] := dm.ADS492DEPT_NAME.Value;                             //'���첿��';
        cells[3,i+stg2rowcount] := dm.ADOQuery1.fieldbyname('rk08').AsString;
        cells[4,i+stg2rowcount] := dm.ADOQuery1.fieldbyname('PROD_CODE').AsString;       //'���ϱ���';
        cells[5,i+stg2rowcount] := dm.ADOQuery1.fieldbyname('PRODUCT_NAME').AsString;    //'��������';
        cells[6,i+stg2rowcount] := dm.ADOQuery1.fieldbyname('PRODUCT_DESC').AsString;    //'���Ϲ��';
        cells[7,i+stg2rowcount] := dm.ADOQuery1.fieldbyname('UNIT_NAME').AsString;       //'��λ';
        cells[8,i+stg2rowcount]:=dm.ADOQuery1.fieldbyname('qty_onhand').AsString;        //'��ǰ���';
        cells[9,i+stg2rowcount]:=dm.ADOQuery1.fieldbyname('QUAN_BOM').AsString;          //'���';
        cells[10,i+stg2rowcount]:='���Ʒ'; //'����';
        cells[11,i+stg2rowcount]:=dm.ADOQuery1.fieldbyname('PRINTIT').AsString;       //'��ӡ';
        cells[12,i+stg2rowcount]:=dm.ADOQuery1.fieldbyname('VENDOR').AsString;        //'��ע';
        cells[13,i+stg2rowcount]:=dm.ADOQuery1.fieldbyname('v_status').AsString;      //'״̬';
        cells[14,i+stg2rowcount]:='';   //����
        cells[15,i+stg2rowcount]:=dm.ADOQuery1.fieldbyname('INVENT_PTR').AsString;    //'rkey17';
      end;
      stg3.Cells[0,i+stg2rowcount]:=dm.ADOQuery1.fieldbyname('rkey').AsString;
      stg3.Cells[1,i+stg2rowcount]:=dm.ADOQuery1.fieldbyname('status').AsString;
      dm.ADOQuery1.Next;
    end;
  end;
end;

procedure Tputprod_Form.stg1KeyPress(Sender: TObject; var Key: Char);
begin                                                  
  if stg1.Col=4 then
    if not (key in ['0'..'9',#8,#13]) then  //�ж��Ƿ���������
      abort;
end;

procedure Tputprod_Form.stg1SelectCell(Sender: TObject; ACol,
  ARow: Integer; var CanSelect: Boolean);
begin
  if (acol=9) then // or  ((acol=4) and (aded_flag=1))
    stg1.Options:= stg1.Options+[goediting]
  else
   stg1.Options:= stg1.Options-[goediting];


  if  (acol=0) and (self.aded_flag=1) then
   if dm.aqy04SEED_FLAG.Value<>4 then
    stg1.Options:= stg1.Options+[goediting]
   else
    stg1.Options:= stg1.Options-[goediting];


   //����༭����Ͷ���������޸�
  if (combobox1.ItemIndex=1) and (self.aded_flag=2) then
    stg1.Options:= stg1.Options-[goediting];
end;

procedure Tputprod_Form.stg1DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
begin
  if (gdSelected  in State) then
  begin
    if (ACol = 8 ) then
    begin
      bitbtn3.Left := Rect.Right-bitbtn3.Width+1;
      bitbtn3.Top := Rect.Top+14;
      bitbtn3.Height := Rect.Bottom - Rect.Top;
      bitbtn3.Visible := True;
    end
    else
      bitbtn3.Visible :=false;
  end;
end;

procedure Tputprod_Form.BitBtn3Click(Sender: TObject);
var InputVar: PDlgInput ;
begin
  try
    frmPick_Item_Single:=TfrmPick_Item_Single.Create(application);
    InputVar.Fields:='WAREHOUSE_CODE/��������/110,WAREHOUSE_NAME/��������/200,abbr_name/���/100';
    InputVar.Sqlstr:='SELECT rkey,Data0015.WAREHOUSE_CODE, dbo.Data0015.WAREHOUSE_NAME,'+
                     'data0015.ABBR_NAME FROM dbo.Data0015 order  by WAREHOUSE_CODE';
    inputvar.KeyField:='WAREHOUSE_CODE';
    inputvar.InPut_value:='';
    InputVar.AdoConn := dm.ADOConnection1 ;
    frmPick_Item_Single.InitForm_New(InputVar);
    if frmPick_Item_Single.ShowModal=mrok then
    begin
      stg1.cells[10,stg1.Row] := frmPick_Item_Single.adsPick.Fieldbyname('RKEY').AsString;
      stg1.cells[8,stg1.Row]:=frmPick_Item_Single.adsPick.FieldValues['WAREHOUSE_CODE'];
    end;
  finally
    frmPick_Item_Single.adsPick.Close;
    frmPick_Item_Single.Free ;
   end; //end try
end;

procedure Tputprod_Form.N3Click(Sender: TObject);      //����
var
  i:integer;
begin
  try
    with   TForm_bominvt.Create(application) do
    begin
      for i:=1 to self.stg1.RowCount-1 do
      if (stg1.Cells[4,i] <> '') and (strtoint(stg1.Cells[4,i])>0) then
      begin
        combobox1.Items.Add(stg1.Cells[0,i]);
        cutno_part.Add(stg1.Cells[2,i]+';'+stg1.Cells[15,i]);   //���Ӳ�Ʒ����+����
      end;
      Hint:='0';
      for i:=1 to stg2.RowCount-1 do
      if (Trim(stg2.Cells[3,i]) <> '') then
        Hint:=Hint+','+stg2.Cells[3,i];

      if (stg1.Cells[4,stg1.row] <> '') and (strtoint(stg1.Cells[4,stg1.row])>0) then
      begin
        combobox1.ItemIndex := combobox1.Items.IndexOf(stg1.Cells[0,stg1.row]);
        edit1.Text:=stg1.Cells[2,stg1.row];           //��Ʒ����
        label12.Caption:=stg1.Cells[15,stg1.row];     //��Ʒ����
      end;
    
      edit2.Text:=stg1.Cells[5,1];                  //���첿��
      if ShowModal=mrok then
      begin
        stg2.cells[0,stg2.RowCount-1]:=combobox1.Text;  //'���ϵ���';
        stg2.cells[1,stg2.RowCount-1]:=stg1.Cells[1,1]; //'���۶���';
        stg2.cells[2,stg2.RowCount-1]:=edit2.Text;      //'���첿��';
        stg2.Cells[3,stg2.RowCount-1]:=rkey17.Caption;  //��¼�ù��Ĳ���
        stg2.cells[4,stg2.RowCount-1]:=edit3.Text;      //'���ϱ���';
        stg2.cells[5,stg2.RowCount-1]:=edit4.Text;      //'��������';
        stg2.cells[6,stg2.RowCount-1]:=edit5.Text;      //'���Ϲ��';
        stg2.cells[7,stg2.RowCount-1]:=edit8.Text;      //'��λ';
        stg2.cells[8,stg2.RowCount-1]:=edit10.Text;     //'��ǰ���';
        stg2.cells[9,stg2.RowCount-1]:=edit6.text;      //'���';
        stg2.cells[10,stg2.RowCount-1]:=combobox2.Text; //'����';
        if checkbox1.Checked then
          stg2.cells[11,stg2.RowCount-1]:='Y'
        else
          stg2.cells[11,stg2.RowCount-1]:='N';        //'��ӡ';
        stg2.cells[12,stg2.RowCount-1]:=edit7.Text;  //'��ע';
        stg2.cells[13,stg2.RowCount-1]:='��ȷ��';          //״̬
        stg2.cells[14,stg2.RowCount-1]:='';          //'rkey34';
        stg2.cells[15,stg2.RowCount-1]:=rkey17.Caption; //'rkey17';
        stg2.RowCount:=stg2.RowCount+1;
        stg2.Row:=stg2.RowCount-2;
      end;
    end;
   finally
     Form_bominvt.Free;
   end;
end;


procedure Tputprod_Form.PopupMenu2Popup(Sender: TObject);
begin
  if stg2.Row=stg2.RowCount-1 then
  begin
    n4.Enabled:=false;
    n5.Enabled:=false;
  end
  else
  begin
    n4.Enabled:=true;
    n5.Enabled:=true;
  end;
end;

procedure Tputprod_Form.stg2MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
 column,row:longint;//�Ҽ�ѡ��stringgrid�ؼ��ķ���
begin
  if button=mbright then
  begin
    stg2.MouseToCell(x,y,column,row);
    if row<>0 then stg2.Row:=row;
  end;
end;


procedure Tputprod_Form.N5Click(Sender: TObject);
var
 i:integer;
begin
  for i:=stg2.Row to stg2.RowCount-2 do
    stg2.Rows[i].Text:=stg2.Rows[i+1].Text;
  stg2.RowCount:=stg2.RowCount-1;
end;

procedure Tputprod_Form.N4Click(Sender: TObject);  //�༭
var
 i:integer;
begin
  try
    with  TForm_bominvt.Create(application) do
    begin
      combobox1.Items.Add(stg2.cells[0,stg2.row]);  //'���ϵ���';
      combobox1.ItemIndex:=0;
      edit1.Text:=self.cutno(stg1.Cells[0,stg2.row],0); //��Ʒ����
      label12.Caption:=cutno(stg1.Cells[0,stg2.row],1); //��Ʒ����
      edit2.Text:=stg2.cells[2,stg2.row];  //'���ϱ���';
      edit3.Text:=stg2.cells[4,stg2.row];  //'���ϱ���';
      edit4.Text:=stg2.cells[5,stg2.row];  //'��������';
      edit5.Text:=stg2.cells[6,stg2.row];  //'���Ϲ��';
      edit8.Text:=stg2.cells[7,stg2.row];  //'��λ';
      edit7.Text:=stg2.cells[12,stg2.row]; //'��Ӧ��';
      edit6.text:=stg2.cells[9,stg2.row];  //'���';

      combobox2.ItemIndex:= //'����';
      combobox2.Items.IndexOf(stg2.cells[10,stg2.row]);

      checkbox1.Checked:=
      stg2.cells[11,stg2.row]='Y'; //'��ӡ';

      edit10.Text:=stg2.cells[8,stg2.row]; //'��ǰ���';

      rkey17.Caption:=stg2.cells[15,stg2.row]; //'rkey17';
      combobox1.Enabled:=false;
      combobox2.Enabled:=false;
      if ShowModal=mrok then
      begin
        stg2.cells[0,stg2.row]:=combobox1.Text; //'���ϵ���';
        stg2.cells[1,stg2.row]:=stg1.Cells[1,1]; //'���۶���';
        stg2.cells[2,stg2.row]:=edit2.Text;     //'���첿��';

        stg2.cells[4,stg2.row]:=edit3.Text;      //'���ϱ���';
        stg2.cells[5,stg2.row]:=edit4.Text;      //'��������';
        stg2.cells[6,stg2.row]:=edit5.Text;      //'���Ϲ��';
        stg2.cells[7,stg2.row]:=edit8.Text;      //'��λ';
        stg2.cells[8,stg2.row]:=edit10.Text;     //'��ǰ���';
        stg2.cells[9,stg2.row]:=edit6.text;      //'���';
        stg2.cells[10,stg2.row]:=combobox2.Text; //'����';

        if checkbox1.Checked then
          stg2.cells[11,stg2.row]:='Y'
        else
          stg2.cells[11,stg2.row]:='N'; //'��ӡ';
        stg2.cells[12,stg2.row]:=edit7.Text; //'��Ӧ��';

        stg2.cells[14,stg2.row]:=''; //'rkey34';
        stg2.cells[15,stg2.row]:=rkey17.Caption; //'rkey17';
      end;
    end;
  finally
    Form_bominvt.Free;
  end;
end;

function Tputprod_Form.find_468edit(cut_no: string): boolean;
var
 i:integer;
begin
  result:=false;
  with dm.ADOQuery1 do
  begin
    close;
    sql.Text:='select rkey,status from data0468 '+
              'WHERE (Data0468.STATUS IN (2, 3) and (Data0468.invent_or = 1))  '+#13+
              'and (data0468.cut_no='+quotedstr(cut_no)+')';
    open;
  end;
  if dm.ADOQuery1.RecordCount <> stg3.RowCount-2 then
    result:=true
  else
  for i:=1 to  stg3.RowCount-2 do
  if not dm.ADOQuery1.Locate('rkey;status',vararrayof([stg3.cells[0,i],stg3.Cells[1,i]]),[]) then
  begin
    result:=true;
    break;
  end;
end;

function Tputprod_Form.findcut_noerror(var row:Integer):boolean;
var
  i:Integer;
begin
 result := false;

 for i:=1 to stg1.RowCount-1 do
 begin
  with dm.ADOQuery1 do
  begin
   close;
   sql.Clear;
   sql.Add('select rkey from data0492');
   sql.Add('where CUT_NO='+QuotedStr(Trim(stg1.Cells[0,i])));
   open;
   if not IsEmpty then
   begin
    row:=i;
    result := true;
    Break;
   end;
  end;
 end;
end;

function Tputprod_Form.findcut_no(cut_no: string): Boolean;
var
  i:Integer;
begin
 Result:=False;
 for i:=1 to stg1.RowCount-1 do
 begin
  if Trim(stg1.Cells[0,i])=cut_no then
  begin
   Result:=True;
   Break;
  end;
 end;
end;


function Tputprod_Form.find468cutno_error(var row:Integer): Boolean;
var
  i:Integer;
begin
 Result:=False;
 for i:=1 to stg2.RowCount-2 do
 begin
  if not self.findcut_no(Trim(stg2.Cells[0,i])) then
  begin
   row:=i;
   Result:=True;
   Break;
  end;
 end;
end;

procedure Tputprod_Form.BitBtn1Click(Sender: TObject);
var
 row,i,i_j:integer;
begin
  if (self.aded_flag=2) and (find_468edit(stg1.Cells[0,1])) then  //�༭
  begin
    showmsg('�༭ʧ��,����ͬʱ������ͬһ���ϵ�,���˳�����!',1);
    exit;
  end;

  if Trim(stg1.Cells[8,1]) = '' then 
  begin
    showmsg('�������벻��Ϊ�գ���ѡ�񹤳���',1);
    exit;
  end;

  if self.find_chaotou(row) then
  begin
    if row > 0 then
    begin
      showmsg('����Ͷ����Ͷ,�����볬Ͷԭ��',1);
      stg1.Row:=row;
    end
    else
      showmsg('����û��Ͷ������',1);
    stg1.SetFocus;
    exit;
  end;

  if self.find_468error(row) then
  begin
    showmsg('Ͷ����Ͷ����������,��������������ϸ!',1);
    stg2.Row:=row;
    stg2.SetFocus;
    exit;
  end;

  if (combobox1.ItemIndex=0) and (self.aded_flag=1) then  //������Ͷ��+����
  with dm.ADOQuery1 do
  begin
    close;
    sql.Text:='select rkey'+#13+
              'from wzcp0070 where sales_order='+quotedstr(stg1.Cells[1,1])+
              ' and status=3';
    open;
    if IsEmpty then
    begin
      showmsg('���ܶ���ͬʱ��ͬһ����Ͷ��,Ͷ������ʧ��',1);
      exit;
    end;
  end;

  if (self.aded_flag=1) then  //����
  begin
    dm.aqy04.Close;
    dm.aqy04.Open;

    if self.findcut_noerror(row) then
    begin
       showmsg('��'+inttostr(row)+'�����������ظ�,���ֶ��޸Ļ��˳���Ͷ',1);
       stg1.Row:=row;
       stg1.SetFocus;
       exit;
    end;

    if self.find468cutno_error(row) then
    begin
       showmsg('��'+inttostr(row)+'�а��Ʒ���ϺŴ���,���ֶ��޸Ļ��˳���Ͷ',1);
       stg2.Row:=row;
       stg2.SetFocus;
       exit;
    end;

  end;

  if (self.aded_flag=1) then  //����
  try
    dm.ADOConnection1.BeginTrans;
    with dm.ADOQuery1 do
    begin
      close;
      sql.Text:='SELECT rkey,TTYPE,CUT_NO,SO_NO,BOM_PTR,PLANNED_QTY,ISSUED_QTY,'+#13+
               'SCH_COMPL_DATE, ISSUE_DATE, CREATED_BY_PTR, PRINTED_BY_PTR, TSTATUS,'+#13+
               'REMARK, WIP_QTY, mrb_ptr, WHOUSE_PTR'+#13+
               'FROM  dbo.data0492 where rkey is null';
      open;
    end;

    for i:=1 to stg1.RowCount-1 do
    if (trim(stg1.cells[4,i])<>'') and (strtoint(stg1.cells[4,i]) > 0) then   //Ͷ��������
    begin
      dm.ADOQuery1.Append;
      dm.ADOQuery1.FieldValues['TTYPE']:=combobox1.ItemIndex;
      dm.ADOQuery1.FieldValues['CUT_NO']:=stg1.Cells[0,i];
      dm.ADOQuery1.FieldValues['SO_NO']:=stg1.Cells[1,i];
      dm.ADOQuery1.FieldValues['BOM_PTR']:=stg1.cells[11,i];
      dm.ADOQuery1.FieldValues['PLANNED_QTY']:=stg1.cells[3,i];
      dm.ADOQuery1.FieldValues['ISSUED_QTY']:=stg1.cells[4,i];
      dm.ADOQuery1.FieldValues['SCH_COMPL_DATE']:=stg1.cells[7,i];
      dm.ADOQuery1.FieldValues['ISSUE_DATE']:=stg1.cells[6,i];
      dm.ADOQuery1.FieldValues['CREATED_BY_PTR']:=user_ptr;
      dm.ADOQuery1.FieldValues['PRINTED_BY_PTR']:=stg1.cells[14,i];
      //2018/5/2ע��Ͷ��������Ͷ��Ҫ�������
//      if  (strtoint(stg1.cells[4,i]) > strtoint(stg1.cells[3,i])) or (combobox1.ItemIndex=1) then   //��Ͷ
//        dm.ADOQuery1.FieldValues['TSTATUS']:=1
//      else
//        dm.ADOQuery1.FieldValues['TSTATUS']:=2;
      dm.ADOQuery1.FieldValues['TSTATUS']:=1;  

      dm.ADOQuery1.FieldValues['REMARK']:=stg1.cells[9,i];
      dm.ADOQuery1.FieldValues['WIP_QTY']:=stg1.cells[3,i];
      dm.ADOQuery1.FieldValues['mrb_ptr']:=stg1.cells[12,i];
      dm.ADOQuery1.FieldValues['WHOUSE_PTR']:=stg1.cells[10,i];
      dm.ADOQuery1.Post;

      if  combobox1.ItemIndex=1 then  //��Ͷ
        i_j := dm.ADOQuery1.Fieldbyname('ISSUED_QTY').AsInteger
      else
        i_j := dm.ADOQuery1.Fieldbyname('ISSUED_QTY').AsInteger-dm.ADOQuery1.Fieldbyname('PLANNED_QTY').AsInteger;

      if dm.ADOQuery1.Fieldbyname('TSTATUS').AsInteger=1 then   //��Ͷ��Ҫ���������˱�
      with dm.ADOQuery2 do
      begin
        close;
        sql.Text:='INSERT INTO Data0491 (MO_PTR, APP_QUAN, remark)'+#13+
                  'values('+dm.ADOQuery1.Fieldbyname('rkey').AsString+','+#13+
                  inttostr(i_j)+#13+
                  ','+quotedstr(dm.ADOQuery1.Fieldbyname('REMARK').AsString)+')';
        ExecSQL;
      end;

      with dm.ADOQuery2 do
      begin
        close;
        sql.Text:='update wzcp0071'+#13+
                  'set QTY_PLANED=QTY_PLANED+data0492.ISSUED_QTY'+#13+
                  'FROM data0492 INNER JOIN'+#13+
                  'WZCP0071 ON data0492.PRINTED_BY_PTR = WZCP0071.rkey'+#13+
                  'where data0492.cut_no='+quotedstr(stg1.Cells[0,i]);
       ExecSQL;
      end;

    //************�´��븴��BOM�еĲ��ϼ�¼ ************//
     with DM.ADOCommand1 do
     begin
      CommandText := 'insert into wzcp0492([D492_ptr],wzcp0495_ptr,[D017_ptr],[STD_QTY],App_QTY,Con_QTY,QUAN_ASSIGN) '+#13     //D148_PTR  lisa
                     +'select data0492.rkey,wzcp0495.rkey,wzcp0495.INVENT_PTR,wzcp0495.QUAN_BOM * data0492.ISSUED_QTY as std_qty,0,0,0'+#13
                     +'from wzcp0495 inner join wzcp0494 on wzcp0495.[PARTBOM_PTR]=wzcp0494.rkey'+#13
                     +'inner join data0017 on wzcp0495.INVENT_PTR=data0017.rkey'+#13
                     +'inner join data0492 on wzcp0494.part_ptr = data0492.BOM_PTR '+#13
                     +'where (data0492.rkey = '+dm.ADOQuery1.FieldByName('rkey').AsString+')'+#13
                     +' and (wzcp0494.status = 1) ';    //and (DATA0148.Invent_or = 0)
      // ShowMessage(CommandText);
      Execute;
     end;
    //********************************************************************

    end;

    with dm.ADOQuery2 do
    begin
      close;
      sql.Text:='SELECT CUT_NO,SO_NO,DEPT_PTR,INVENT_PTR,QUAN_BOM,STATUS,PRINTIT,'+
                'VENDOR,invent_or FROM  Data0468 where rkey is null';
      open;
    end;
    for i:=1 to stg2.RowCount-2 do
    begin
      dm.ADOQuery2.Append;
      dm.ADOQuery2.FieldValues['CUT_NO']:=stg2.Cells[0,i];
      dm.ADOQuery2.FieldValues['SO_NO']:=stg2.Cells[1,i];
      dm.ADOQuery2.FieldValues['DEPT_PTR']:=dm.ADOQuery1.FieldValues['mrb_ptr'];
      dm.ADOQuery2.FieldValues['INVENT_PTR']:=stg2.Cells[15,i];
      dm.ADOQuery2.FieldValues['QUAN_BOM']:=stg2.Cells[9,i];
      dm.ADOQuery2.FieldValues['STATUS']:=2;          //��ȷ��
      dm.ADOQuery2.FieldValues['PRINTIT']:=stg2.Cells[11,i];
      dm.ADOQuery2.FieldValues['VENDOR']:=stg2.Cells[12,i];
      if stg2.Cells[10,i]='ԭ����' then   //��׼���� lisa
        dm.ADOQuery2.FieldValues['invent_or']:=0
      else
        dm.ADOQuery2.FieldValues['invent_or']:=1;
      dm.ADOQuery2.Post;
    end;

    if dm.aqy04SEED_FLAG.Value<>1 then
    self.update_04(trim(dm.aqy04SEED_VALUE.Value));

    self.ModalResult:=mrok;
  except
    on E: Exception do
    begin
      dm.ADOConnection1.RollbackTrans;
      messagedlg(E.Message,mterror,[mbcancel],0);
    end;
  end
  else  //�༭
  try
    dm.ADOConnection1.BeginTrans;
    with dm.ADOQuery1 do
    begin
      close;
      sql.Text:='SELECT rkey, TTYPE, CUT_NO, SO_NO, BOM_PTR, PLANNED_QTY, ISSUED_QTY,'+#13+
                ' SCH_COMPL_DATE, ISSUE_DATE, CREATED_BY_PTR, PRINTED_BY_PTR, TSTATUS,'+#13+
                'REMARK, WIP_QTY, mrb_ptr, WHOUSE_PTR'+#13+
                'FROM  dbo.data0492 where CUT_NO='+quotedstr(stg1.Cells[0,1]);
      open;
    end;

    dm.ADOQuery1.Edit;;
    dm.ADOQuery1.FieldValues['CREATED_BY_PTR']:=user_ptr;
    dm.ADOQuery1.FieldValues['REMARK']:=stg1.cells[9,1];
    dm.ADOQuery1.FieldValues['WHOUSE_PTR']:=stg1.cells[10,1];
    dm.ADOQuery1.Post;

    with dm.ADOQuery2 do
    begin
      close;
      sql.Text:='update wzcp0071'+#13+
                'set QTY_PLANED=QTY_PLANED-'+dm.ADS492ISSUED_QTY.AsString+'+'+stg1.cells[4,1]+#13+
                'where  wzcp0071.rkey='+quotedstr(stg1.Cells[14,1]);
      ExecSQL;
    end;

    with dm.ADOQuery2 do
    begin
      close;
      sql.Text:='delete data0468 '+
                'where (status in (2,3)) and (cut_no='+quotedstr(stg1.Cells[0,1])+')';
      ExecSQL;
    end;

    with dm.ADOQuery2 do
    begin
      close;
      sql.Text:='SELECT CUT_NO, SO_NO, DEPT_PTR, INVENT_PTR, QUAN_BOM, STATUS, PRINTIT,'+
                'VENDOR, invent_or FROM  dbo.Data0468 where rkey is null';
      open;
    end;
    for i:=1 to stg2.RowCount-2 do
    begin
      dm.ADOQuery2.Append;
      dm.ADOQuery2.FieldValues['CUT_NO']:=stg2.Cells[0,i];
      dm.ADOQuery2.FieldValues['SO_NO']:=stg2.Cells[1,i];
      dm.ADOQuery2.FieldValues['DEPT_PTR']:=
                       dm.ADOQuery1.FieldValues['mrb_ptr'];
      dm.ADOQuery2.FieldValues['INVENT_PTR']:=stg2.Cells[15,i];
      dm.ADOQuery2.FieldValues['QUAN_BOM']:=stg2.Cells[9,i];
      dm.ADOQuery2.FieldValues['STATUS']:=2;          //��ȷ��
      dm.ADOQuery2.FieldValues['PRINTIT']:=stg2.Cells[11,i];
      dm.ADOQuery2.FieldValues['VENDOR']:=stg2.Cells[12,i];
      if stg2.Cells[10,i]='��׼����' then
        dm.ADOQuery2.FieldValues['invent_or']:=0
      else
        dm.ADOQuery2.FieldValues['invent_or']:=1;
      dm.ADOQuery2.Post;
    end;

   self.ModalResult:=mrok;
  except
    on E: Exception do
    begin
      dm.ADOConnection1.RollbackTrans;
      messagedlg(E.Message,mterror,[mbcancel],0);
    end;
  end;
end;



end.
