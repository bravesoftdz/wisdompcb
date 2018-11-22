unit putprod;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, Grids, Menus,math,StrUtils,DB, ADODB,DateUtils;

type
  TForm_putprod = class(TForm)
    stg1: TStringGrid;
    Label1: TLabel;
    Panel2: TPanel;
    Label2: TLabel;
    stg2: TStringGrid;
    stg3: TStringGrid;
    Label3: TLabel;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Splitter1: TSplitter;
    ComboBox1: TComboBox;
    Label4: TLabel;
    Label9: TLabel;
    Edit1: TEdit;
    SpeedButton1: TSpeedButton;
    PopupMenu2: TPopupMenu;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    Splitter2: TSplitter;
    PopupMenu3: TPopupMenu;
    N6: TMenuItem;
    procedure FormActivate(Sender: TObject);
    procedure stg1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure PopupMenu2Popup(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure PopupMenu3Popup(Sender: TObject);
    procedure N6Click(Sender: TObject);
  private
    { Private declarations }
   Q_Date6:String;
   ct_reson:string;    //��Ͷԭ��
   function cutno(rkey25:integer;_type:byte):string;
   function partin(rkey25:integer):byte;
   function new_wo(rkey25: integer): byte;
 //  function returen_maxLOTNUM(rkey25: integer):integer;
   procedure update_04(v_seed: string);
   function maxstep(rkey25,step:integer):boolean;
   function if_waichen(rkey25:integer):boolean;
   function returen_pnlnumber(rkey25,pnlab:string):integer;
   function isnum(str:string):boolean;
   FunCtion GetNewKeyNo(Const Tablename,FieldName,FString,whereTxt:String;NoLen:Integer):String;
   function GetRkey(const TableName,FieldName,WhereTxt:string):Integer;
  public
    { Public declarations }
   whouseptr,mrbptr,deptptr,CUSTOMER_PTR:integer; //����15,�˻�mrb414ָ��,��������34.rkey,�ͻ�ָ��
   so_number:string;      //���۶���
   ikey60,MANU_NUMBER:string;  //60RKey,�������
 //  apnl_size,bpnl_size:string;
   begin_step,parts_count:byte; //����Ͷ����ʼ���裬��Ʒ��������
  end;

var
  Form_putprod: TForm_putprod;

implementation

uses damo,common, bominvt;

{$R *.dfm}
function TForm_putprod.GetRkey(const TableName,FieldName,WhereTxt:string):Integer;
var tmpAdoQry:TAdoQuery;
begin
  tmpAdoQry:=TAdoQuery.Create(Application);
  try
    tmpAdoQry.Connection:=DM.ADOConnection1;
    tmpAdoQry.SQL.Text:='select '+FieldName+' from '+Tablename+' where '+WhereTxt+'';
    tmpAdoQry.Open;
    if not tmpadoQry.IsEmpty then
    begin
      Result:=tmpAdoQry.FieldBYName(''+FieldName+'').asinteger;
    end else Result:=-1;
  finally
   tmpAdoQry.Connection:=nil;
   tmpAdoQry.Free;
  end;
end;

FunCtion TForm_putprod.GetNewKeyNo(Const Tablename,FieldName,FString,whereTxt:String;NoLen:Integer):String;
var tmpAdoQry:TAdoQuery;
     cmdStr,BegStr,ReturnNo,tmpNo:String;
     Len:Integer;
Begin
   tmpAdoQry:=TAdoQuery.Create(Application);
   try
        Len:=Length(FString);
        BegStr:='0000000000000000000000';
        BegStr:=Copy(BegStr,Len,(NoLen-Len));
        if FString<>'' then
           cmdStr:='Select '+FieldName+' from '+Tablename
            +' where '+FieldName+' Like '''+FString+'%'' Order by '+FieldName
        else
           cmdStr:='Select '+FieldName+' from '+Tablename+' Order by '+FieldName;
        tmpAdoQry.Connection:=DM.ADOConnection1;
        tmpAdoQry.SQL.Text:=cmdStr;
        tmpAdoQry.Open;
        tmpAdoQry.Last;
        if Trim(tmpAdoQry.FieldByName(FieldName).AsString)='' then
        begin
             Len:=Length(BegStr);
             BegStr:=Copy(BegStr,1,Len-1);
             BegStr:=BegStr+'1';
             ReturnNo:=BegStr;
        end
        else
        begin
            tmpNo:=Trim(tmpAdoQry.FieldByname(FieldName).AsString);
            tmpNo:=Copy(tmpNo,Len+1,NoLen-Len);
            if tmpNO<>'' then
            begin
            try
            tmpNo:=IntToStr(StrToInt(tmpNO)+1);
            Len:=Length(BegStr)-Length(tmpNO);
            BegStr:=Copy(BegStr,1,Len);
            ReturnNo:=BegStr+tmpNo;
            except
              ReturnNo:=tmpNO;
            end;
            end
            else
            ReturnNo:='01';
        end;
        Result:=FString+ReturnNo;
   finally
     tmpAdoQry.Connection:=nil;
     tmpAdoQry.Free;
   end;
end;

function TForm_putprod.cutno(rkey25: integer;_type:byte): string;
var
 i:integer;
begin
result:='';
 for i:=1 to stg1.RowCount-1 do
  if strtoint(stg1.Cells[11,i])= rkey25 then
   begin
    result:=stg1.Cells[_type,i];
    break;
   end;
end;

function TForm_putprod.new_wo(rkey25: integer): byte;
var
 sql_str:string;
begin
 sql_str:='select rkey from data0006 '+
          'where PROD_STATUS<>202 '+
          'and bom_ptr='+inttostr(rkey25);
 openquery(dm.ADOQuery1,sql_str);
 if dm.ADOQuery1.IsEmpty then
  result:=1
 else
  result:=0;
 dm.ADOQuery1.Close;
end;

{
function TForm_putprod.returen_maxLOTNUM(rkey25: integer): integer;
var
 sql_str:string;
begin
 sql_str:='select MAX(LOT_NUMBER) AS LOTNUMBER from data0006 '+
          'WHERE bom_ptr='+inttostr(rkey25);
 openquery(dm.ADOQuery1,sql_str);
 try
 if dm.ADOQuery1.FieldByName('LOTNUMBER').IsNull then
  result:=0
 else
  if dm.ADOQuery1.FieldByName('LOTNUMBER').Asinteger>=9999 then
   result:=0
  else
   result:=dm.ADOQuery1.FieldByName('LOTNUMBER').Asinteger;
 except
   result:=0
 end;
 dm.ADOQuery1.Close;
end; }

function TForm_putprod.partin(rkey25: integer): byte; //�����ǰ��Ʒ�����Ƿ��ж���
var                                     //�κ�һ�����ӵ�ѹ�ϲ����Ƿ�Ϊ��ǰ��Ʒ��һ����������
 sql_str:string;                        //��ǰ��Ʒ��һ����������һ���ǵ�һ������
begin
  result:=1;
 sql_str:='select rkey,BOM_STEP from data0025 '+
          'where PARENT_PTR='+inttostr(rkey25);
 openquery(dm.ADOQuery1,sql_str);
 if not dm.ADOQuery1.IsEmpty then     //���Ӳ���
  begin
   sql_str:=' select min(data0038.step_number) as step'+#13+
    'from data0038 inner join data0034'+#13+
    'on data0038.dept_ptr=data0034.rkey'+#13+
    'where source_ptr='+inttostr(rkey25)+#13+
    'and BARCODE_ENTRY_FLAG=''Y''';
    openquery(dm.ADOQuery2,sql_str);
    while not dm.ADOQuery1.Eof do
     begin
       if dm.ADOQuery1.FieldByName('BOM_STEP').AsInteger=
          dm.ADOQuery2.FieldByName('step').AsInteger  then
        begin
          result:=0;
          break;
        end;
      dm.ADOQuery1.Next;
     end;
  end;
 dm.ADOQuery1.Close;
end;

procedure TForm_putprod.update_04(v_seed: string);
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

function TForm_putprod.if_waichen(rkey25:integer): boolean;
var
 sql_str:string;
begin                //�����ǰ��Ʒ�Ƿ�Ϊ���
 sql_str:='select PARENT_PTR from data0025 '+
          'where rkey='+inttostr(rkey25)+
          ' and PARENT_PTR is null';
 openquery(dm.ADOQuery1,sql_str);
 if not dm.ADOQuery1.IsEmpty then
  result:=true       //��Ϊ�ռ�¼�ҵ����
 else
  result:=false;
 dm.ADOQuery1.Close;
end;

function TForm_putprod.maxstep(rkey25, step: integer): boolean;
var
 sql_str:string;
begin
sql_str:=
    'SELECT max(Data0038.STEP_NUMBER) as maxstep'+#13+
    'FROM   Data0038 INNER JOIN'+#13+
    'Data0034 ON Data0038.DEPT_PTR = Data0034.RKEY'+#13+
    'WHERE  (Data0034.BARCODE_ENTRY_FLAG = ''Y'') and'+#13+
    '(Data0038.SOURCE_PTR ='+inttostr(rkey25)+')';
openquery(dm.ADOQuery1,sql_str);
if dm.ADOQuery1.FieldByName('maxstep').AsInteger=step then
 result:=true
else
 result:=false;
dm.ADOQuery1.Close;
end;

procedure TForm_putprod.FormActivate(Sender: TObject);
begin
with stg1 do
 begin
  cells[0,0]:='���ϵ���';
  cells[1,0]:='�������';
  cells[2,0]:='�깤����';
  cells[3,0]:='���ƻ���';
  cells[4,0]:='�ƻ���';
  cells[5,0]:='Ͷ����';
  cells[6,0]:='ͶA����';
  cells[7,0]:='ͶB����';
  cells[8,0]:='��Ͷ��%';
  cells[9,0]:='��ע';
  cells[10,0]:='���Ϲ��';
  cells[11,0]:='rkey25';
  ColWidths[11]:=-1;
  cells[12,0]:='A��PCS';
  cells[13,0]:='B��PCS';
  cells[14,0]:='A��ߴ�';
  cells[15,0]:='B��ߴ�';
 end;
with stg2 do
 begin
  cells[0,0]:='���ϵ���';
  cells[1,0]:='�������';
  cells[2,0]:='�������';
  cells[3,0]:='����';
  cells[4,0]:='���ϱ���';
  cells[5,0]:='��������';
  cells[6,0]:='���Ϲ��';
  cells[7,0]:='��λ';
  cells[8,0]:='��ǰ���';
  cells[9,0]:='���';
  cells[10,0]:='����';
  cells[11,0]:='�Ƿ�Ϊ��ͨ���';
  cells[12,0]:='��ע';
  cells[13,0]:='rkey25';
  cells[14,0]:='rkey34';
  cells[15,0]:='rkey17';
  cells[16,0]:='rkey23';
  ColWidths[13]:=-1;
  ColWidths[14]:=-1;
  ColWidths[15]:=-1;
  ColWidths[16]:=-1;
  cells[17,0]:='�˱�������';
 end;
with stg3 do
 begin
  cells[0,0]:='���ϵ���';
  cells[1,0]:='�������';
  cells[2,0]:='��ҵ����';
  cells[3,0]:='�ƻ�����';
  cells[4,0]:='PNL��';
  cells[5,0]:='PCS��/PNL';
  cells[6,0]:='�깤����';
  cells[7,0]:='PNL��';
  cells[8,0]:='PNL��';
  cells[9,0]:='PNL�ߴ�';
  cells[10,0]:='rkey25';
  cells[11,0]:='ABPNL';
  ColWidths[10]:=-1;
  ColWidths[11]:=-1;
  cells[12,0]:='�����̶�';
  cells[13,0]:='�����̶�code';
  ColWidths[13]:=-1;
 end;
 
self.ct_reson:='';//��Ͷԭ��
speedbutton1.Enabled:=edit1.Text='��Ͷ';

if speedbutton1.Enabled then
 edit1.Color:=clfuchsia
else
 edit1.Color:=claqua;

if strtoint(vprev)=4 then
 stg2.PopupMenu:=popupmenu2
else
 stg2.PopupMenu:=nil;
 
if combobox1.ItemIndex=3 then //����Ͷ��
 begin
  self.Splitter1.Visible:=false;
  label2.Visible:=false;
  stg2.Visible:=false;
  panel2.Height:=126;
  stg1.Align:=alclient;
 end;

end;

procedure TForm_putprod.stg1MouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
var
  column, row: longint; //�Ҽ�ѡ��stringgrid�ؼ��ķ���
begin
 if button = mbright then
  begin
   (Sender as tstringgrid).MouseToCell(x, y, column, row);
   if row <> 0 then
    begin
     (Sender as tstringgrid).Row := row;
    end;
  end;
end;

procedure TForm_putprod.N1Click(Sender: TObject);
begin
stg1.Cells[9,stg1.Row]:= InputBox('��ע��Ϣ', '�����뱸ע��Ϣ      ', stg1.Cells[9,stg1.Row]);
end;

procedure TForm_putprod.N2Click(Sender: TObject);
begin
stg1.Cells[10,stg1.Row]:= InputBox('���Ϲ��', '��������Ϲ��      ', stg1.Cells[10,stg1.Row]);
end;

procedure TForm_putprod.SpeedButton1Click(Sender: TObject);
begin
self.ct_reson:=
 InputBox('��Ϣ����', '��Ͷԭ��:      ', self.ct_reson);
end;

procedure TForm_putprod.PopupMenu2Popup(Sender: TObject);
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

procedure TForm_putprod.N3Click(Sender: TObject);
var
 i:integer;
begin
 try
 with   TForm_bominvt.Create(application) do
  begin
   for i:=1 to self.stg1.RowCount-1 do
    begin
     combobox1.Items.Add(stg1.Cells[0,i]);
     cutno_part.Add(stg1.Cells[1,i]+';'+stg1.Cells[11,i]);
    end;
    combobox1.ItemIndex:=0;
    edit1.Text:=copy(cutno_part.Strings[0],1,
                     pos(';',cutno_part.Strings[0])-1);
    rkey25.Caption:=copy(cutno_part.Strings[0],
                         pos(';',cutno_part.Strings[0])+1,
                         length(cutno_part.Strings[0])-
                         pos(';',cutno_part.Strings[0]));


    dm.ADOQuery5.close;
    dm.ADOQuery5.Parameters.ParamByName('MANU_PART_NUMBER').Value:=edit1.Text;
    dm.ADOQuery5.open;
    edit16.Text:= dm.ADOQuery5PARAMETER_VALUE.Value;


    dm.ADOQuery6.close;
    dm.ADOQuery6.Parameters.ParamByName('MANU_PART_NUMBER').Value:=edit1.Text;
    dm.ADOQuery6.open;
    edit17.Text:=dm.ADOQuery6PARAMETER_VALUE.Value;

   if ShowModal=mrok then
    begin
     stg2.cells[0,stg2.RowCount-1]:=combobox1.Text; //'���ϵ���';
     stg2.cells[1,stg2.RowCount-1]:=edit1.Text; //'�������';
     stg2.cells[2,stg2.RowCount-1]:=edit2.Text; //'�������';
     stg2.cells[3,stg2.RowCount-1]:=edit9.Text; //'����';
     stg2.cells[4,stg2.RowCount-1]:=edit3.Text; //'���ϱ���';
     stg2.cells[5,stg2.RowCount-1]:=edit4.Text; //'��������';
     stg2.cells[6,stg2.RowCount-1]:=edit5.Text; //'���Ϲ��';
     stg2.cells[7,stg2.RowCount-1]:=edit8.Text; //'��λ';
     stg2.cells[8,stg2.RowCount-1]:=edit10.Text; //'��ǰ���';
     stg2.cells[9,stg2.RowCount-1]:=edit6.text; //'���';
     stg2.cells[10,stg2.RowCount-1]:=combobox2.Text; //'����';
     if Label18.Caption='��ͨ���' then
     begin
      stg2.cells[11,stg2.RowCount-1]:='Y'
     end;

     if Label18.Caption='���Ͽ��' then
     begin
      stg2.cells[11,stg2.RowCount-1]:='Y'
     end;


     if Label18.Caption='VMI���' then
     begin
      stg2.cells[11,stg2.RowCount-1]:='N'
     end;

     stg2.cells[12,stg2.RowCount-1]:=edit7.Text; //'��ע';
     stg2.cells[13,stg2.RowCount-1]:=rkey25.Caption; //'rkey25';
     stg2.cells[14,stg2.RowCount-1]:=rkey34.caption; //'rkey34';
     stg2.cells[15,stg2.RowCount-1]:=rkey17.Caption; //'rkey17';
     stg2.cells[16,stg2.RowCount-1]:=IntToStr(BitBtn5.Tag); //rkey34
     stg2.Cells[17,stg2.RowCount-1]:=Trim(Edit14.Text);   //�˱���
     stg2.RowCount:=stg2.RowCount+1;
     stg2.Row:=stg2.RowCount-2;
    end;
  end;
 finally
  Form_bominvt.Free;
 end;
end;

procedure TForm_putprod.N4Click(Sender: TObject);
var
 i:integer;
begin
 try
 with   TForm_bominvt.Create(application) do
  begin
    combobox1.Items.Add(cutno(strtoint(stg2.cells[13,stg2.row]),0));  //'���ϵ���';
    combobox1.ItemIndex:=0;
    edit1.Text:=cutno(strtoint(stg2.cells[13,stg2.row]),1);    //'�������';
    edit9.Text:=stg2.cells[3,stg2.row]; //'����';
    edit3.Text:=stg2.cells[4,stg2.row]; //'���ϱ���';
    edit4.Text:=stg2.cells[5,stg2.row]; //'��������';
    edit5.Text:=stg2.cells[6,stg2.row]; //'���Ϲ��';
    edit8.Text:=stg2.cells[7,stg2.row]; //'��λ';
    edit7.Text:=stg2.cells[12,stg2.row]; //'��Ӧ��';
    edit6.text:=stg2.cells[9,stg2.row]; //'���';


    dm.ADOQuery5.close;
    dm.ADOQuery5.Parameters.ParamByName('MANU_PART_NUMBER').Value:=edit1.Text;
    dm.ADOQuery5.open;
    edit16.Text:= dm.ADOQuery5PARAMETER_VALUE.Value;


    dm.ADOQuery6.close;
    dm.ADOQuery6.Parameters.ParamByName('MANU_PART_NUMBER').Value:=edit1.Text;
    dm.ADOQuery6.open;
    edit17.Text:=dm.ADOQuery6PARAMETER_VALUE.Value;







    if stg2.Cells[17,stg2.row]='' then Edit14.Text:='0'
    ELSE Edit14.Text:=stg2.Cells[17,stg2.row]; //�˱���
    combobox2.ItemIndex:= //'����';
      combobox2.Items.IndexOf(stg2.cells[10,stg2.row]);
    if (stg2.cells[11,stg2.row]='Y') and (stg2.cells[10,stg2.row]='��׼') then //'';
     begin
     label18.Caption:='��ͨ���'
     end;

    if (stg2.cells[11,stg2.row]='Y') and (stg2.cells[10,stg2.row]='����') then //'';
     begin
     label18.Caption:='���Ͽ��'
     end;

    if (stg2.cells[11,stg2.row]='N') and (stg2.cells[10,stg2.row]='��׼') then //'';
     begin
     label18.Caption:='VMI���'
     end;

    edit10.Text:=stg2.cells[8,stg2.row]; //'��ǰ���';
    rkey25.Caption:=stg2.cells[13,stg2.row]; //'rkey25';
    rkey34.caption:=stg2.cells[14,stg2.row]; //'rkey34';
    rkey17.Caption:=stg2.cells[15,stg2.row]; //'rkey17';
    BitBtn5.Tag:=StrToIntDef(stg2.Cells[16,stg2.row],0); //rkey23
    combobox1.Enabled:=false;
    combobox2.Enabled:=false;
   if ShowModal=mrok then
    begin
      stg2.cells[0,stg2.row]:=combobox1.Text; //'���ϵ���';
      stg2.cells[1,stg2.row]:=edit1.Text;  //'�������';
      stg2.cells[2,stg2.row]:=edit2.Text;  //'�������';
      stg2.cells[3,stg2.row]:=edit9.Text;  //'����';
      stg2.cells[4,stg2.row]:=edit3.Text;  //'���ϱ���';
      stg2.cells[5,stg2.row]:=edit4.Text;  //'��������';
      stg2.cells[6,stg2.row]:=edit5.Text;  //'���Ϲ��';
      stg2.cells[7,stg2.row]:=edit8.Text;  //'��λ';
      stg2.cells[12,stg2.row]:=edit7.Text; //'��Ӧ��';
      stg2.cells[9,stg2.row]:=edit6.text;  //'���';
      stg2.cells[10,stg2.row]:=combobox2.Text; //'����';
      if Label18.Caption='��ͨ���' then
       stg2.cells[11,stg2.row]:='Y'
      else
       stg2.cells[11,stg2.row]:='N'; //'��ӡ';
      stg2.cells[8,stg2.row]:=edit10.Text; //'��ǰ���';
      stg2.cells[13,stg2.row]:=rkey25.Caption; //'rkey25';
      stg2.cells[14,stg2.row]:=rkey34.caption; //'rkey34';
      stg2.cells[15,stg2.row]:=rkey17.Caption; //'rkey17';
      stg2.cells[16,stg2.row]:=IntToStr(BitBtn5.Tag); //'rkey23';
      stg2.Cells[17,stg2.row]:=Trim(Edit14.Text);  //�˱���
    end;
  end;
 finally
  Form_bominvt.Free;
 end;
end;



procedure TForm_putprod.N5Click(Sender: TObject);
var
 i:integer;
begin
 for i:=stg2.Row to stg2.RowCount-2 do
  stg2.Rows[i].Text:=stg2.Rows[i+1].Text;
 stg2.RowCount:=stg2.RowCount-1;
end;

procedure TForm_putprod.BitBtn1Click(Sender: TObject);
var
 i,i_j:integer;
// Max_lot:integer;
 wip_code:string;
 lsql: string;
 LManuPartNUmber: string;
 LDia: string;
 lrkey14: string;
 LnowTIme: TDateTime;
 iTmp34,iTmp584,itmp05,iday:Integer;
 IsCheck:Integer;   //add by zsp 2017-05-04
begin
 if (combobox1.ItemIndex=3) then //����Ͷ����Ҫ����Ƿ������̵�
 begin
 wip_code:=dm.find_wip_code;
 if wip_code<>'' then
 begin
  showmsg('����Ʒ�����̵㲻����Ͷ��,�̵����:'+wip_code,1);
  exit;
 end;
 end;

 if (combobox1.ItemIndex=0) then  //������Ͷ��
 with dm.ADOQuery1 do
  begin
   close;
   sql.Text:='select prod_rel,to_be_planned,qty_plannned,issued_qty'+#13+
              'from data0060 where sales_order='+quotedstr(self.so_number);
   open;
   if (FieldByName('to_be_planned').AsInteger<>dm.ADS60TO_BE_PLANNED.Value) or
      (FieldByName('prod_rel').AsInteger<>2) then
    begin
     showmsg('�������ƻ��������仯Ͷ��ʧ��,���ܶ���ͬʱ��ͬһ����Ͷ��',1);
     exit;
    end;
  end
 else
 if (combobox1.ItemIndex=2) or (combobox1.ItemIndex=3) then
 with dm.ADOQuery1 do
  begin
   close;
      sql.Text:='select qty_to_be_reworked,qty_reworked,'+#13+
                'qty_to_be_remaked,qty_remaked,status'+#13+
                'from data0414 where rkey='+inttostr(self.mrbptr);
   open;
   if (combobox1.ItemIndex=2) then       //mrb��Ͷ
    if FieldByName('qty_remaked').AsInteger<>0 then
    begin
     showmsg('MRB�������������仯Ͷ��ʧ��,���ܶ���ͬʱ��ͬһ����Ͷ��',1);
     exit;
    end
    else
   else                           //mrb����
    if FieldByName('qty_reworked').AsInteger<>0 then
    begin
     showmsg('MRB�������������仯Ͷ��ʧ��,���ܶ���ͬʱ��ͬһ����Ͷ��',1);
     exit;
    end
  end;

dm.aqy04.Close;
dm.aqy04.Open;

if copy(stg1.Cells[0,1],1,
        pos('-',stg1.Cells[0,1])-1)<>dm.aqy04SEED_VALUE.Value then
 begin
  showmsg('���ϵ�����,���ܶ���ͬʱͶ��,��ǰ׺�����³�:'+dm.aqy04SEED_VALUE.Value,1);
  for i:=1 to stg1.RowCount-1 do
   begin
    for i_j:=1 to stg3.RowCount-2 do
     if strtoint(stg3.Cells[10,i_j])=strtoint(stg1.cells[11,i]) then
      stg3.Cells[2,i_j]:=StringReplace(stg3.Cells[2,i_j],stg1.Cells[0,i],
                        dm.aqy04SEED_VALUE.Value+'-'+inttostr(i-1),
                        [rfReplaceAll]);
    stg1.Cells[0,i]:=dm.aqy04SEED_VALUE.Value+'-'+inttostr(i-1);
   end;
 end;

if (self.Edit1.Text='��Ͷ') and (trim(self.ct_reson)='') then
 begin
  showmsg('����Ͷ����Ͷ,�����볬Ͷԭ��',1);
  edit1.SetFocus;
  exit;
 end;

 if (self.Edit1.Text='��Ͷ') then
 begin
   with dm.ADOQuery1 do
   begin
     Close;
     SQL.Text:= 'SELECT ppc_control22 from data0192';
     Open;
     if not IsEmpty then
     begin
       IsCheck:= Fields[0].AsInteger;
     end;
   end;
 end;

dm.ADOConnection1.BeginTrans;
try
 dm.AQY492.Close;
 dm.AQY492.Open;
 dm.AQY468.Close;
 dm.AQY468.Open;
 dm.AQY06.Close;
 dm.AQY06.Open;
// Max_lot:=0;
for i:=1 to stg1.RowCount-1 do
begin
 dm.AQY492.Append;
 dm.AQY492TTYPE.Value:=combobox1.ItemIndex;
 dm.AQY492CUT_NO.Value:=stg1.Cells[0,i];
 if (combobox1.ItemIndex=0) or (combobox1.ItemIndex=1)  or (combobox1.ItemIndex=3) then
  if Self.so_number<>'' then DM.AQY492SO_NO.Value:=self.so_number;
 dm.AQY492BOM_PTR.Value:=strtoint(stg1.cells[11,i]);
 dm.AQY492ORD_REQ_QTY.Value:=strtoint(stg1.cells[3,i]);
 dm.AQY492PLANNED_QTY.Value:=strtoint(stg1.cells[4,i]);
 dm.AQY492ISSUED_QTY.Value:=strtoint(stg1.cells[5,i]);
 dm.AQY492SCH_COMPL_DATE.Value:=StrToDate(FormatDateTime('yyyy-MM-dd',strtodatetime(stg1.Cells[2,i])));
 dm.AQY492ISSUE_DATE.Value:=getsystem_date(dm.ADOQuery1,0);
 dm.AQY492CREATED_BY_PTR.Value:=strtoint(user_ptr);
 dm.AQY492UPANEL1.Value:=strtoint(stg1.cells[12,i]);  //A��PCS��
 dm.AQY492PANEL_1_QTY.Value:=strtoint(stg1.cells[6,i]); //A�����
 dm.AQY492UPANEL2.Value:=strtoint(stg1.cells[13,i]);
 dm.AQY492PANEL_2_QTY.Value:=strtoint(stg1.cells[7,i]);
 dm.AQY492remark.Value:=stg1.Cells[9,i];
 dm.AQY492analysis_code_3.Value:=stg1.Cells[10,i];
 if (self.Edit1.Text='��Ͷ') and (IsCheck = 1) then
  dm.AQY492TSTATUS.Value:=1  //δ���
 else
  dm.AQY492TSTATUS.Value:=2;
 dm.AQY492Con_Flag.Value:=0;
 dm.AQY492WHOUSE_PTR.Value:=self.whouseptr;
 if (combobox1.ItemIndex=2) or (combobox1.ItemIndex=3) then
  dm.AQY492mrb_ptr.Value:=self.mrbptr;
 dm.AQY492pnl1_size.Value:=stg1.cells[14,i];
 dm.AQY492pnl2_size.Value:=stg1.cells[15,i];
 if combobox1.ItemIndex<>3 then      //���Ƿ���Ͷ��
  begin
   dm.AQY492waitfor_release.Value := dm.AQY492ISSUED_QTY.Value;
 //  if self.if_waichen(dm.AQY492BOM_PTR.Value) then //���������Ʒ
  //  Max_lot:=self.returen_maxLOTNUM(dm.AQY492BOM_PTR.Value);
  end
 else        //����Ͷ��
  dm.AQY492wip_qty.Value := dm.AQY492ISSUED_QTY.Value;
 dm.AQY492COMPLETED.Value:=self.CUSTOMER_PTR;   //�ͻ�����10.rkey
 dm.AQY492.Post;

 if dm.AQY492TSTATUS.Value=1 then   //��Ͷ��Ҫ���������˱�
  with dm.ADOQuery2 do
  begin
   close;
   sql.Text:='INSERT INTO Data0491 (MO_PTR, APP_QUAN, remark)'+#13+
             'values('+dm.AQY492rkey.AsString+','+#13+
             inttostr(dm.AQY492ISSUED_QTY.Value-dm.AQY492ORD_REQ_QTY.Value)+#13+
             ','+quotedstr(self.ct_reson)+')';
   ExecSQL;
  end;

 for i_j:=1 to stg2.RowCount-2 do
  if  strtoint(stg2.Cells[13,i_j])=dm.AQY492BOM_PTR.Value then
  begin
   dm.AQY468.Append;
   dm.AQY468CUT_NO.Value:=dm.AQY492CUT_NO.Value;
   if (combobox1.ItemIndex=0) or (combobox1.ItemIndex=1) then
    dm.AQY468SO_NO.Value:=dm.AQY492SO_NO.Value;
   dm.AQY468STEP.Value:=strtoint(stg2.cells[3,i_j]);
   dm.AQY468DEPT_PTR.Value:=strtoint(stg2.cells[14,i_j]);
   dm.AQY468INVENT_PTR.Value:=strtoint(stg2.cells[15,i_j]);
   dm.AQY468QUAN_BOM.Value:=strtofloat(stg2.cells[9,i_j]);
   dm.AQY468STATUS.Value:=0;
   dm.AQY468VENDOR.Value:=stg2.Cells[12,i_j];
   if stg2.Cells[10,i_j]='����' then
    dm.AQY468Invent_or.Value:=1
   else
    dm.AQY468Invent_or.Value:=0;
   dm.AQY468printit.Value:=stg2.Cells[11,i_j];
   if StrToIntDef(stg2.Cells[16,i_j],0)>0 then
   dm.AQY468supplier_ptr.Value:=StrToIntDef(stg2.Cells[16,i_j],0);
   DM.AQY468offcut_qty.Value:=StrToIntDEF(stg2.Cells[17,i_j],0);

   dm.AQY468.Post;
  end; //end for i_j

 for i_j:=1 to stg3.RowCount-2 do
  if  strtoint(stg3.Cells[10,i_j])=dm.AQY492BOM_PTR.Value then
   begin
    dm.AQY06.Append;
    dm.AQY06WORK_ORDER_NUMBER.Value:=stg3.Cells[2,i_j];
    dm.AQY06CUT_NO.Value:=dm.AQY492CUT_NO.Value;
    dm.AQY06PANEL_A_B.Value:=strtoint(stg3.Cells[11,i_j]);
    dm.AQY06BOM_PTR.Value:=strtoint(stg3.Cells[10,i_j]);
    if dm.AQY492TTYPE.Value<>3 then     //���Ƿ���Ͷ�� (��Ҫ��������)
     begin
      dm.AQY06PROD_STATUS.Value:=2;  //������
      dm.AQY06WIPMAT_STATUS.Value:=self.partin(dm.AQY06BOM_PTR.Value);
      if self.if_waichen(dm.AQY492BOM_PTR.Value) then //���������Ʒ
       begin
        // dm.AQY06LOT_NUMBER.Value:=rightstr('000'+inttostr(i_j+Max_lot),4);
         if (copy(stg3.Cells[2,i_j],Pos('-',stg3.Cells[2,i_j])+2,1)='A') or   //��A,Bƴ�����ҵ��ʱ
            (copy(stg3.Cells[2,i_j],Pos('-',stg3.Cells[2,i_j])+2,1)='B') then
          dm.AQY06CUTNO_WO.Value:=LeftStr(Trim(dm.AQY06CUT_NO.Value),
                                         Length(Trim(dm.AQY06CUT_NO.Value))-2)+
                        copy(stg3.Cells[2,i_j],Pos('-',stg3.Cells[2,i_j])+2,1)+
           RightStr(stg3.Cells[2,i_j],Pos('-',ReverseString(stg3.Cells[2,i_j])))
         ELSE
          dm.AQY06CUTNO_WO.Value:=LeftStr(Trim(dm.AQY06CUT_NO.Value),
                                         Length(Trim(dm.AQY06CUT_NO.Value))-2)+
           RightStr(stg3.Cells[2,i_j],Pos('-',ReverseString(stg3.Cells[2,i_j])));
       end;
     end
    else
     begin       //����Ͷ��ֱ�ӷ��Ź���    ����Ͷ������û�����κ�
      if self.maxstep(dm.AQY06BOM_PTR.Value,self.begin_step) then
       dm.AQY06PROD_STATUS.Value:=5  //�����
      else
       dm.AQY06PROD_STATUS.Value:=3;//������
      dm.AQY06WIPMAT_STATUS.Value:=1;  //�ڲ��ѷ���   (��������״̬)
      dm.AQY06employee_ptr.Value:=strtoint(user_ptr);
      dm.AQY06RELEASE_DATE.Value:=dm.AQY492ISSUE_DATE.Value;
     end;
    dm.AQY06QUAN_SCH.Value:=strtofloat(stg3.Cells[3,i_j]);
    dm.AQY06PANELS.Value:=strtoint(stg3.Cells[4,i_j]);
    dm.AQY06remark_pnls.Value:=dm.AQY06PANELS.Value;
    dm.AQY06PARTS_PER_PANEL.Value:=strtofloat(stg3.Cells[5,i_j]);
    dm.AQY06SCH_COMPL_DATE.Value:=StrToDate(FormatDateTime('yyyy-MM-dd',StrToDateTime(stg3.Cells[6,i_j])));
    dm.AQY06ENT_DATETIME.Value:=dm.AQY492ISSUE_DATE.Value;
    dm.AQY06panel_ln.Value:=strtofloat(stg3.Cells[7,i_j]);
    dm.AQY06panel_wd.Value:=strtofloat(stg3.Cells[8,i_j]);
    dm.AQY06pnl_size.Value:=stg3.Cells[9,i_j];

    dm.AQY06BEGIN_STEP_NO.Value:=self.begin_step;
    dm.AQY06ppc_flag.Value:=self.new_wo(dm.AQY06BOM_PTR.Value); //�Ƿ��һ��Ͷ����һ�Ź���0��1��
    dm.AQY06WHOUSE_PTR.Value:=self.whouseptr;
    DM.AQY06PRIORITY_CODE.Value:= StrToInt(stg3.cells[13,i_j]);
    dm.AQY06.Post;

    if dm.AQY492TTYPE.Value=3 then //����Ͷ��,����56������ҵ��
      with dm.ADOQuery2 do  //
       begin
        close;
        sql.Text:='SELECT  WO_PTR, DEPT_PTR, STEP, QTY_BACKLOG, PANELS, INTIME, '+
                  'TDATE,LOC_PTR FROM  Data0056 where rkey is null';
        open;
        dm.ADOQuery2.AppendRecord([dm.AQY06rkey.Value,
                                   self.deptptr,
                                   self.begin_step,
                                   dm.AQY06QUAN_SCH.Value,
                                   0,                         //����PANEL����
                                   dm.AQY06ENT_DATETIME.Value,
                                   dm.AQY06ENT_DATETIME.Value,
                                   dm.AQY06WHOUSE_PTR.Value]);
       end;
   end; //end for i_j

end; //end for i
 self.update_04(trim(dm.aqy04SEED_VALUE.Value));

 //20160614tang���Ͷ���ɹ���Ѳ���һ��data0585���¼
 //ClaimOutDateҪ�����ʱ��=Ͷ��ʱ��+data0584����������-------------------
//  if dm.ADOConnection1.InTransaction then
//    dm.ADOConnection1.CommitTrans;
  if (ikey60<>'') then //���ɵ�û�����۱�ŵ�Ͷ��
  begin
    DM.aqTmp.Close;
    dm.aqTmp.SQL.Clear;
    dm.aqTmp.SQL.Text:='SELECT STEP_NUMBER,DEPT_CODE,DEPT_NAME,Data0025.RKEY as rkey25,Data0038.DEF_ROUT_INST,data0034.rkey as rkey34, '
                       +' data0038.rkey as rkey38,data0060.Rkey as Rkey60  FROM Data0038'
                       +' INNER JOIN Data0025 ON SOURCE_PTR = Data0025.RKEY'
                       +' INNER JOIN Data0034 ON Data0038.DEPT_PTR = Data0034.RKEY'
                       +' INNER JOIN data0060 on data0060.CUST_PART_PTR=Data0025.RKEY'
                       +' WHERE data0060.Rkey ='+ikey60+' and DEPT_NAME like ''%���%''';
    dm.aqTmp.Open;
    if not dm.aqTmp.IsEmpty then //��Ʒ�����е�⹤��
    begin
      iTmp34:=dm.aqTmp.FieldByName('rkey34').AsInteger;
      dm.qrytmp.Close;
      dm.qrytmp.SQL.Clear;
      DM.qrytmp.SQL.Text:= 'select Data0585.rkey60,data0584.dayNum,data0585.OrderDate'
                         +' from Data0585 left join data0584 on Data0585.Rkey584=Data0584.Rkey '
                         +' left join data0034 on  data0034.Rkey=data0584.Rkey34'
                         +' where data0034.TTYPE=1 and data0034.ACTIVE_FLAG=0 and data0034.Rkey='+inttostr(iTmp34)+' '
                         +' and (data0585.iStatus<>3) and (data0585.iStatus<>4) and Data0585.MANU_PART_NUMBER='''+Trim(MANU_NUMBER)+'''';
      dm.qrytmp.Open;
      if dm.qrytmp.IsEmpty then //585���в�����״̬��Ϊ3����4ͣ�õļ�¼
      begin
//        if ((DM.ADS60so_oldnew.AsString='�µ�') and (DM.ADS60ttype.AsInteger=0) and (dm.ads60ANCESTOR_PTR.AsInteger=0)) then //�µ����������ֹ��������Զ�����һ����¼�����������585
        if (DM.ADS60ttype.AsInteger=0) then //20160811�޸��е�⹤���ޱ����������û�й����Զ�����һ����¼�����������585
        begin
          dm.qrytmp.Close;
          dm.qrytmp.SQL.Clear;
          dm.qrytmp.SQL.Text:='select data0494.PARAMETER_VALUE from data0494 inner join data0278 on data0494.PARAMETER_PTR=data0278.Rkey inner join'
                              +' data0025 on data0494.custpart_ptr=data0025.rkey inner join data0038 on data0025.Rkey=data0038.SOURCE_PTR'
                              +' where data0278.CATEGORY_PTR=3 and data0278.PARAMETER_DESC like ''%���ò��Լ�%'' and data0025.Rkey='+dm.aqTmp.FieldBYName('rkey25').AsString+' and data0494.step_number='+dm.aqTmp.FieldBYName('STEP_NUMBER').AsString;
          dm.qrytmp.Open;
          if not dm.qrytmp.IsEmpty then
          begin
            if (dm.qrytmp.FieldByName('PARAMETER_VALUE').AsString='') then
            begin
              Q_Date6:=FormatDateTime('yyMMdd',getsystem_date(DM.qrytmp,1));
              iTmp584:=GetRkey('data0584','Rkey','dayNum=(select MAX(daynum) from data0584 where Rkey34='+Inttostr(iTmp34)+')');
              itmp05:=GetRkey('data0005','Rkey',' data0005.EMPLOYEE_NAME like ''%ϵͳ����Ա%''');
              if (iTmp34<>-1) and (iTmp584<>-1) then
              begin
                iday:=GetRkey('data0584','dayNum','Rkey='+InttoStr(iTmp584)+'');
                dm.aqTmp.Close;
                dm.aqTmp.SQL.Clear;
                dm.aqTmp.SQL.Text:='Insert into data0585 (Tool_No,MANU_PART_NUMBER,Rkey60,iStatus,Rkey584,Rkey34,Generate_Ren,Generate_Date,PlusOpen,OrderDate,ClaimOutDate) '
                +'Values (:Tool_No,:MANU_PART_NUMBER,:Rkey60,:iStatus,:Rkey584,:Rkey34,:Generate_Ren,:Generate_Date,:PlusOpen,:OrderDate,:ClaimOutDate)';
                dm.aqTmp.Parameters.ParamByName('Tool_No').Value:=GetNewKeyNo('data0585','Tool_No',Q_Date6,'',8);
                dm.aqTmp.Parameters.ParamByName('MANU_PART_NUMBER').Value:=Trim(MANU_NUMBER);
                dm.aqTmp.Parameters.ParamByName('Rkey60').Value:=ikey60;
                dm.aqTmp.Parameters.ParamByName('iStatus').Value:=0;
                dm.aqTmp.Parameters.ParamByName('Rkey584').Value:=iTmp584;
                dm.aqTmp.Parameters.ParamByName('Rkey34').Value:=iTmp34;
                dm.aqTmp.Parameters.ParamByName('Generate_Ren').Value:=itmp05;
                dm.aqTmp.Parameters.ParamByName('Generate_Date').Value:=getsystem_date(DM.qrytmp,0);//��ʱ���ʽ
                dm.aqTmp.Parameters.ParamByName('PlusOpen').Value:=0;
                dm.aqTmp.Parameters.ParamByName('OrderDate').Value:=getsystem_date(DM.qrytmp,0);//��ʱ���ʽ
                dm.aqTmp.Parameters.ParamByName('ClaimOutDate').Value:=IncDay(getsystem_date(DM.qrytmp,0),iday);//��ʱ���ʽ
                dm.aqTmp.ExecSQL;
              end;
            end;
          end else
          begin
            Q_Date6:=FormatDateTime('yyMMdd',getsystem_date(DM.qrytmp,1));
            iTmp584:=GetRkey('data0584','Rkey','dayNum=(select MAX(daynum) from data0584 where Rkey34='+Inttostr(iTmp34)+')');
            itmp05:=GetRkey('data0005','Rkey',' data0005.EMPLOYEE_NAME like ''%ϵͳ����Ա%''');
            if (iTmp34<>-1) and (iTmp584<>-1) then
            begin
              iday:=GetRkey('data0584','dayNum','Rkey='+InttoStr(iTmp584)+'');
              dm.aqTmp.Close;
              dm.aqTmp.SQL.Clear;
              dm.aqTmp.SQL.Text:='Insert into data0585 (Tool_No,MANU_PART_NUMBER,Rkey60,iStatus,Rkey584,Rkey34,Generate_Ren,Generate_Date,PlusOpen,OrderDate,ClaimOutDate) '
              +'Values (:Tool_No,:MANU_PART_NUMBER,:Rkey60,:iStatus,:Rkey584,:Rkey34,:Generate_Ren,:Generate_Date,:PlusOpen,:OrderDate,:ClaimOutDate)';
              dm.aqTmp.Parameters.ParamByName('Tool_No').Value:=GetNewKeyNo('data0585','Tool_No',Q_Date6,'',8);
              dm.aqTmp.Parameters.ParamByName('MANU_PART_NUMBER').Value:=Trim(MANU_NUMBER);
              dm.aqTmp.Parameters.ParamByName('Rkey60').Value:=ikey60;
              dm.aqTmp.Parameters.ParamByName('iStatus').Value:=0;
              dm.aqTmp.Parameters.ParamByName('Rkey584').Value:=iTmp584;
              dm.aqTmp.Parameters.ParamByName('Rkey34').Value:=iTmp34;
              dm.aqTmp.Parameters.ParamByName('Generate_Ren').Value:=itmp05;
              dm.aqTmp.Parameters.ParamByName('Generate_Date').Value:=getsystem_date(DM.qrytmp,0);//��ʱ���ʽ
              dm.aqTmp.Parameters.ParamByName('PlusOpen').Value:=0;
              dm.aqTmp.Parameters.ParamByName('OrderDate').Value:=getsystem_date(DM.qrytmp,0);//��ʱ���ʽ
              dm.aqTmp.Parameters.ParamByName('ClaimOutDate').Value:=IncDay(getsystem_date(DM.qrytmp,0),iday);//��ʱ���ʽ
              dm.aqTmp.ExecSQL;
            end;
          end;
        end;
      end;
    end;
  end;
 //end 20160614tang-------------------------------------------------------

 self.ModalResult:=mrok;
 if combobox1.ItemIndex = 0 then
 begin
   //�����С��λ����3λ����������ʾ
   lsql := ' SELECT d25.MANU_PART_NUMBER,d29.DRILL_DIA,getdate() as nowtime FROM data0029 d29 ' +
           ' INNER JOIN data0492 d492 ON d492.BOM_PTR = d29.SOURCE_PTR ' +
           ' INNER JOIN data0060 d60 ON d492.SO_NO = d60.SALES_ORDER ' +
           ' inner join data0025 d25 on d25.rkey = d29.source_ptr ' +
           ' WHERE cast(d29.DRILL_DIA  as varchar(20)) like ' + QuotedStr('%.__[23456789]') +
           ' AND so_oldnew = ' + QuotedStr('�µ�') +
           ' and d492.rkey = ' + IntToStr(DM.AQY492rkey.AsInteger);
   DM.qrytmp.Close;
   DM.qrytmp.SQL.Clear;
   DM.qrytmp.SQL.Add(lsql);
   DM.qrytmp.Open;
   if not DM.qrytmp.IsEmpty then
   begin
     //14��д��Ϣ
     LManuPartNUmber := DM.qrytmp.fieldbyname('MANU_PART_NUMBER').AsString;
     LDia := DM.qrytmp.fieldbyname('DRILL_DIA').AsString;
     LnowTIme := dm.qrytmp.fieldbyname('nowtime').AsDateTime;
     
     DM.qrytmp.Close;
     DM.qrytmp.SQL.Clear;
     dm.qrytmp.SQL.Add('select * from data0014 where rkey = -1');
     DM.qrytmp.Open;
     DM.qrytmp.Append;
     DM.qrytmp.FieldByName('MESSAGE').AsString :=  '�������Ϊ ' + LManuPartNUmber + ' �Ĳ�Ʒ�� ' + LDia + ' �����졣';
     DM.qrytmp.FieldByName('senddate').AsDateTime := LnowTIme;
     DM.qrytmp.FieldByName('whosend').AsString := rkey73;
     DM.qrytmp.Post;
     lrkey14 := DM.qrytmp.fieldbyname('rkey').AsString;

     //д�������
     lsql := 'INSERT INTO data0314 (emp_ptr,d14_ptr) SELECT rkey73,' + lrkey14+ ' from data0537';
     dm.qrytmp.Close;
     DM.qrytmp.SQL.Clear;
     DM.qrytmp.SQL.Add(lsql);
     DM.qrytmp.ExecSQL;

   end;           
 end;

except
 on E: Exception do
  begin
   dm.ADOConnection1.RollbackTrans;
   messagedlg(E.Message,mterror,[mbcancel],0);
  end;
end;

end;


procedure TForm_putprod.PopupMenu3Popup(Sender: TObject);
begin
if (stg3.Cells[10,stg3.Row] = stg3.Cells[10,stg3.Row-1]) and  //��Ʒ�빤��PNL(A����B)һ��
   (stg3.Cells[11,stg3.Row] = stg3.Cells[11,stg3.Row-1]) then
 n6.Enabled:=true
else
 n6.Enabled:=false;
end;

function TForm_putprod.returen_pnlnumber(rkey25, pnlab: string): integer;
var
 i,pnlnumber:integer;
begin
pnlnumber:=0;
for i:=1 to stg3.RowCount-2 do
 if (stg3.Cells[10,i]=rkey25) and
    (stg3.Cells[11,i]=pnlab)   then
   inc(pnlnumber);
 result:=pnlnumber;
end;

function TForm_putprod.isnum(str:string):boolean;
var 
  i:integer;
begin
  for i:=1 to length(str) do
   if not (str[i] in ['0'..'9']) then
    begin
      result:=false;
      exit;
    end;
  result:=true;
end;

procedure TForm_putprod.N6Click(Sender: TObject);
var
 i:integer;
 pnl_number:integer;
 oldstr,newstr:string;
begin
 stg3.cells[3,stg3.Row-1]:= inttostr(strtoint(stg3.cells[3,stg3.Row-1]) +
                            strtoint(stg3.cells[3,stg3.Row]));     //'�ƻ�����';

 stg3.cells[4,stg3.Row-1]:= inttostr(strtoint(stg3.cells[4,stg3.Row-1])+
                            strtoint(stg3.cells[4,stg3.Row]));    //'PNL��';

 pnl_number:=self.returen_pnlnumber(stg3.Cells[10,stg3.Row],stg3.Cells[11,stg3.Row]);
 oldstr:='-'+inttostr(pnl_number)+'-';
 newstr:='-'+inttostr(pnl_number-1)+'-';

for i:=1 to stg3.RowCount-2 do
 if (stg3.Cells[10,i]=stg3.Cells[10,stg3.Row]) and
    (stg3.Cells[11,i]=stg3.Cells[11,stg3.Row])   then
  begin
     //ȡ����ҵ��'-'��ǰ����ַ�����'-'�ź����ַ������к��ַ���Ҫ�滻������ҵ�������滻ԭ�ַ���
   stg3.Cells[2,i]:=Copy(stg3.Cells[2,i],1,Pos('-',stg3.Cells[2,stg3.row])+1)+
   StringReplace(Copy(stg3.Cells[2,i],Pos('-',stg3.Cells[2,stg3.row])+2,
                      Length(stg3.Cells[2,i])-Pos('-',stg3.Cells[2,stg3.row])-1
                      ),
   oldstr,newstr,[rfIgnoreCase]);

   if i > stg3.Row then
    begin
     if isnum(copy(stg3.Cells[2,i],length(stg3.Cells[2,i])-2,3)) then       //�����λ������
      stg3.Cells[2,i]:=copy(stg3.Cells[2,i],1,length(stg3.Cells[2,i])-3)+
                             copy(inttostr(1000+
                             strtoint(copy(stg3.Cells[2,i],length(stg3.Cells[2,i])-2,3)
                                      )-1),
                                  2,3)
     else
      if isnum(copy(stg3.Cells[2,i],length(stg3.Cells[2,i])-1,2)) then       //�����λ������
       stg3.Cells[2,i]:=copy(stg3.Cells[2,i],1,length(stg3.Cells[2,i])-2)+
                             copy(inttostr(100+
                             strtoint(copy(stg3.Cells[2,i],length(stg3.Cells[2,i])-1,2)
                                      )-1),
                                  2,2)
      else
       if isnum(copy(stg3.Cells[2,i],length(stg3.Cells[2,i]),1)) then       //���һλ������
        stg3.Cells[2,i]:=copy(stg3.Cells[2,i],1,length(stg3.Cells[2,i])-1)+
                               copy(inttostr(10+
                               strtoint(copy(stg3.Cells[2,i],length(stg3.Cells[2,i]),1)
                                        )-1),
                                    2,1);
    end;
  end;

 for i:=stg3.Row to stg3.RowCount-2 do
  stg3.Rows[i].Text:=stg3.Rows[i+1].Text;
 stg3.RowCount:=stg3.RowCount-1;

end;

end.
