unit bominvt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, Grids, DBGrids, DB, ADODB, DBCtrls;

type
  TForm_bominvt = class(TForm)
    Panel1: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Panel3: TPanel;
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
    rkey34: TLabel;
    rkey17: TLabel;
    rkey25: TLabel;
    ComboBox1: TComboBox;
    Edit1: TEdit;
    Edit2: TEdit;
    BitBtn3: TBitBtn;
    Edit3: TEdit;
    Edit4: TEdit;
    Edit5: TEdit;
    Edit6: TEdit;
    Edit7: TEdit;
    BitBtn4: TBitBtn;
    Edit8: TEdit;
    ComboBox2: TComboBox;
    Edit9: TEdit;
    Edit10: TEdit;
    Panel2: TPanel;
    Label14: TLabel;
    Label15: TLabel;
    Edit11: TEdit;
    Edit12: TEdit;
    RadioGroup1: TRadioGroup;
    group_ptr: TLabel;
    Panel4: TPanel;
    DBGrid1: TDBGrid;
    Panel5: TPanel;
    DBGrid3: TDBGrid;
    StringGrid1: TStringGrid;
    Splitter1: TSplitter;
    btn1: TButton;
    CheckBox2: TCheckBox;
    CheckBox3: TCheckBox;
    CheckBox4: TCheckBox;
    CheckBox5: TCheckBox;
    Edit13: TEdit;
    Label16: TLabel;
    BitBtn5: TBitBtn;
    Label17: TLabel;
    Label18: TLabel;
    Label19: TLabel;
    Label20: TLabel;
    Edit14: TEdit;
    Label21: TLabel;
    Edit15: TEdit;
    Label22: TLabel;
    Label23: TLabel;
    Edit16: TEdit;
    Edit17: TEdit;
    Label24: TLabel;
    Edit18: TEdit;
    Label25: TLabel;
    Edit19: TEdit;
    Label26: TLabel;
    Edit20: TEdit;
    BitBtn6: TBitBtn;
    Label27: TLabel;
    Label28: TLabel;
    Label29: TLabel;
    Edit21: TEdit;
    Edit22: TEdit;
    rkey17_1: TLabel;
    rkey556: TLabel;
    Label30: TLabel;
    Edit23: TEdit;
    Label31: TLabel;
    procedure Edit6KeyPress(Sender: TObject; var Key: Char);
    procedure Edit6KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BitBtn3Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure FormShow(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure Edit14KeyPress(Sender: TObject; var Key: Char);
    procedure Edit14KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BitBtn6Click(Sender: TObject);
    procedure Edit15Change(Sender: TObject);
    procedure Edit13Change(Sender: TObject);
    procedure Edit13DblClick(Sender: TObject);
  private
    procedure get_value(rkey278: integer);
    procedure ShowSG(const sGroup_ptr,strRkey:string);
    function Get17Group_ptr(const strRkey: string): Integer;
    { Private declarations }
  public
    { Public declarations }

  end;
type
 TMyDBGrid=class(TDBGrid);

var
  Form_bominvt: TForm_bominvt;

implementation

uses dmunit1,Pick_Item_Single2 ,ConstVar,common, CutViewFrm,Math, EditBom;

{$R *.dfm}
function TForm_bominvt.Get17Group_ptr(const strRkey:string):Integer;
var tmpAdo:TADOQuery;
begin
   try
     try
       tmpAdo:=TADOQuery.Create(Application);
       tmpAdo.Connection:=DM.ADOConnection1;
       tmpAdo.Close;
       tmpAdo.SQL.Clear;
       tmpAdo.SQL.Add('select * from dbo.data0017 where Rkey=:Rkey');
       tmpAdo.Parameters.ParamByName('Rkey').Value:=strRkey;
       tmpAdo.Open;
       if (tmpAdo.RecordCount>0) then
       begin
         Result:=tmpAdo.FieldByName('GROUP_PTR').AsInteger;
       end else Result:=0;
     except
       Result:=0;
       tmpAdo.Close;
       tmpAdo.Connection:=nil;
       tmpAdo.Free;
     end;
   finally
     tmpAdo.Close;
     tmpAdo.Connection:=nil;
     tmpAdo.Free;
   end;
end;

procedure TForm_bominvt.ShowSG(const sGroup_ptr,strRkey:string);
var tmpAdo:TADOQuery;
    sGp_Prt,s17Rkey:string;
    i:Integer;
begin
   sGp_Prt:=sGroup_ptr;
   s17Rkey:= strRkey;
   StringGrid1.RowCount:=2;
   StringGrid1.Rows[1].Clear;
   stringgrid1.Cells[0,0] := '���';
   StringGrid1.ColWidths[0]:=30;
   stringgrid1.Cells[1,0] := '��������';
   StringGrid1.ColWidths[1]:=60;
   stringgrid1.Cells[2,0] := '����ֵ';
   StringGrid1.ColWidths[2]:=60;
   StringGrid1.Cells[3,0] := '��λ';
   StringGrid1.ColWidths[3]:=40;
   StringGrid1.Cells[4,0] := 'd278RKey';
   StringGrid1.ColWidths[4]:=-1;
   try
     try
       tmpAdo:=TADOQuery.Create(Application);
       tmpAdo.Connection:=DM.ADOConnection1;
       tmpAdo.Close;
       tmpAdo.SQL.Clear;
       tmpAdo.SQL.Text:='SELECT dbo.Data0499.PARAMETER_PTR, dbo.Data0499.DEF_VALUE, dbo.Data0499.SEQ_NO, dbo.Data0278.PARAMETER_NAME,'
        +'dbo.Data0278.PARAMETER_DESC, dbo.Data0002.UNIT_NAME,dbo.data0499.inv_group_ptr,dbo.data0278.Rkey as d278RKey'
        +' FROM dbo.Data0499'
        +' INNER JOIN dbo.Data0278 ON dbo.Data0499.PARAMETER_PTR = dbo.Data0278.RKEY'
        +' INNER JOIN dbo.Data0002 ON dbo.Data0278.UNIT_PTR = dbo.Data0002.RKEY'
        +' where  data0499.ttype=0 and data0499.inv_group_ptr =:group_ptr'
        +' order by data0499.seq_no';
       tmpAdo.Parameters.ParamByName('group_ptr').Value:=sGp_Prt;
       tmpAdo.Open;
       if (tmpAdo.RecordCount>0) then
       begin
         while not tmpAdo.Eof do
         begin
           stringgrid1.Cells[0,StringGrid1.RowCount-1] := tmpAdo.FieldByName('seq_no').AsString;
           stringgrid1.Cells[1,StringGrid1.RowCount-1] := tmpAdo.FieldByName('PARAMETER_NAME').AsString;
           StringGrid1.Cells[3,StringGrid1.RowCount-1] := tmpAdo.FieldByName('UNIT_NAME').AsString;
           StringGrid1.Cells[4,StringGrid1.RowCount-1] := tmpAdo.FieldByName('d278RKey').AsString;
           StringGrid1.RowCount:=StringGrid1.RowCount+1;
           tmpAdo.Next;
         end;
         StringGrid1.RowCount:=StringGrid1.RowCount-1;
       end;
       tmpAdo.Close;
       tmpAdo.SQL.Clear;
       tmpAdo.SQL.Add('select * from dbo.data0017 where Rkey=:INV_PART_NUMBER');
       tmpAdo.Parameters.ParamByName('INV_PART_NUMBER').Value:=s17Rkey;
       tmpAdo.Open;
       if (tmpAdo.RecordCount>0) then
       begin
         for  i:=1  to 10 do
         begin
           sGp_Prt:=tmpAdo.FieldByName('IES_PARAMETER_VALUE'+IntTostr(i)).AsString;
           if ((sGp_Prt='') or (sGp_Prt=null)) then Break;
             stringgrid1.Cells[2,i] := tmpAdo.FieldByName('IES_PARAMETER_VALUE'+IntTostr(i)).AsString;
         end;
       end;
      except
       tmpAdo.Close;
       tmpAdo.Connection:=nil;
       tmpAdo.Free;
     end;
   finally
     tmpAdo.Close;
     tmpAdo.Connection:=nil;
     tmpAdo.Free;
   end;
end;

procedure  TForm_bominvt.get_value(rkey278:integer);
begin
  with dm.ADOQuery1 do
   begin
    close;
    sql.Clear;
    sql.Add('select tvalue from data0338 where parameter_ptr='+inttostr(rkey278));
    open;
   end;
  if not dm.adoquery1.IsEmpty then
   begin
    dbgrid1.Columns[5].PickList.Clear;
    while not dm.adoquery1.eof do
     begin
     dbgrid1.Columns[5].PickList.Add(trim(dm.adoquery1.FieldValues['tvalue']));
      dm.adoquery1.Next;
     end;
   end
  else
   dbgrid1.Columns[5].PickList.Clear;
end;

procedure TForm_bominvt.Edit6KeyPress(Sender: TObject; var Key: Char);
begin
 if not (key in ['0'..'9','.',#13,#8]) then  //�ж��Ƿ���������
  abort
 else
  if key = chr(46) then      //�ж��Ƿ��ظ�����С����'.'
   if pos('.',Edit6.Text)>0  then abort;
end;

procedure TForm_bominvt.Edit6KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if trim((sender as tedit).Text)='' then
 (sender as tedit).Text:='0';
end;

procedure TForm_bominvt.BitBtn3Click(Sender: TObject);
var
  InputVar: PDlgInput ;
begin
   try
    frmPick_Item_Single2 := TfrmPick_Item_Single2.Create(application) ;
    InputVar.Fields := 'DEPT_CODE/�������/110,DEPT_NAME/��������/251,'+
                        'STEP_NUMBER/����/80';
    InputVar.Sqlstr :=
    'SELECT TOP 100 PERCENT Data0034.DEPT_CODE, Data0034.DEPT_NAME,'+#13+
    'Data0038.STEP_NUMBER, Data0034.RKEY'+#13+
    'FROM         dbo.Data0038 INNER JOIN'+#13+
    ' dbo.Data0034 ON dbo.Data0038.DEPT_PTR = dbo.Data0034.RKEY'+#13+
    'WHERE  (dbo.Data0034.IS_COST_DEPT = 1) and'+#13+
    '(dbo.Data0038.SOURCE_PTR ='+rkey25.caption+')'+#13+
    'ORDER BY dbo.Data0038.STEP_NUMBER';

    inputvar.InPut_value:=edit2.Text;
    inputvar.KeyField:='DEPT_CODE';
    InputVar.AdoConn := dm.ADOConnection1;
    frmPick_Item_Single2.InitForm_New(InputVar);
    if frmPick_Item_Single2.ShowModal=mrok then
     begin
      edit2.Text := trim(frmPick_Item_Single2.adsPick1.FieldValues['DEPT_CODE']);
      label4.Caption := frmPick_Item_Single2.adsPick1.Fieldbyname('DEPT_NAME').AsString;
      rkey34.Caption := frmPick_Item_Single2.adsPick1.Fieldbyname('rkey').AsString;
      edit9.Text:=frmPick_Item_Single2.adsPick1.Fieldbyname('STEP_NUMBER').AsString;
//2013-01-21��ӹ���ע��������ʾ---------------------------------------------------
//      DBGrid1.Visible:=True;
//      StringGrid1.Visible:=False;
//      dm.ads494.Filter:='step_number='+edit9.Text;
      dm.ads494.Close;
      dm.ads494.CommandText:=dm.ads494SQL+' and data0494.step_number=:step_number';                      //�Ƴ̲���
      dm.ads494.Parameters[0].Value:=rkey25.Caption;
      dm.ads494.Parameters[1].Value:=edit9.Text;
      dm.ads494.Open;
//end-------------------------------------------------------------------------------
      combobox1.Enabled:=false;
     end;
  finally
      frmPick_Item_Single2.adsPick1.Close;
      frmPick_Item_Single2.Free ;
  end;
end;

procedure TForm_bominvt.BitBtn4Click(Sender: TObject);
var
  InputVar: PDlgInput ;
begin
 if combobox2.ItemIndex=0 then
 begin  //��׼����
  try
    frmPick_Item_Single2 := TfrmPick_Item_Single2.Create(application) ;
    frmPick_Item_Single2.BorderStyle:=bsSizeable;

    if RadioGroup1.ItemIndex=0  then
    begin
     InputVar.Fields := 'INV_PART_NUMBER/���ϱ���/100,INV_NAME/��������/100,'+          //,���Ϲ��/���Ϲ��/200,
                        'INV_DESCRIPTION/���Ϲ��/120,QUAN_ON_HAND2/��ǰ���/55,'+
                        'unit_name/��λ/30,ABBR_NAME/��Ӧ��/80,LOCATION/�ֿ�/45,SUPPLIER2/ԭ��Ӧ��/50,BARCODE_ID/��ע/80,'+
                        'XY_1/�������/80,all_QUAN_ON_HAND/��ǰ�ܿ��/60,LEN_SIZE/���Ͼ���/60,WEI_SIZE/����γ��/60,�Ƿ�ɷ���/�Ƿ�ɷ���/80';
     InputVar.Sqlstr :=
      'SELECT TOP (100) PERCENT dbo.Data0017.RKEY, dbo.Data0017.INV_PART_NUMBER,'+#13+
      ' Data0017.INV_NAME,data0017.INV_DESCRIPTION,data0017.GROUP_PTR,data0023.code ,Data0023.RKEY as rkey23,'+#13+
      'SUM(dbo.Data0022.QUAN_ON_HAND - dbo.Data0022.QUAN_TO_BE_STOCKED) AS QUAN_ON_HAND2,'+#13+
      'dbo.Data0002.UNIT_NAME, dbo.Data0023.ABBR_NAME,dbo.Data0016.LOCATION,'+#13+
      'data0022.SUPPLIER2,data0022.BARCODE_ID,''��ͨ���'' AS XY_1,dbo.Data0017.QUAN_ON_HAND as all_QUAN_ON_HAND,0 as LEN_SIZE,0 as WEI_SIZE'+#13+
       ' , (case when (d391.status=2) or (d391.status is null )  then ''��''  else ''��''  end )  as  ''�Ƿ�ɷ���'' '+#13+
      'FROM         dbo.Data0017 INNER JOIN'+#13+
      '    dbo.Data0022 ON dbo.Data0017.RKEY = dbo.Data0022.INVENTORY_PTR INNER JOIN'+#13+
      '    dbo.Data0456 ON dbo.Data0022.GRN_PTR = dbo.Data0456.RKEY INNER JOIN'+#13+
      '    dbo.Data0016 ON dbo.Data0022.LOCATION_PTR = dbo.Data0016.RKEY INNER JOIN'+#13+
      '    dbo.Data0023 ON dbo.Data0456.SUPP_PTR = dbo.Data0023.RKEY INNER JOIN'+#13+
      '    dbo.Data0002 ON dbo.Data0022.LOCATION_PTR_FROM = dbo.Data0002.RKEY INNER JOIN '+#13+
      '    dbo.Data0496 ON dbo.Data0017.GROUP_PTR = dbo.Data0496.RKEY '+#13+
      ' left join data0391 d391 on data0022.rkey391=d391.rkey '+#13+
      'WHERE   (dbo.Data0022.QUAN_ON_HAND - dbo.Data0022.QUAN_TO_BE_STOCKED > 0)'+#13+
      '          and dbo.Data0496.quote_flag=1'+#13+
      'GROUP BY dbo.Data0017.RKEY, dbo.Data0017.INV_PART_NUMBER, dbo.Data0017.INV_NAME,'+#13+
      ' dbo.Data0002.UNIT_NAME, dbo.Data0023.ABBR_NAME,dbo.Data0016.LOCATION,data0017.INV_DESCRIPTION,data0017.GROUP_PTR,'+#13+
      'data0022.SUPPLIER2,data0022.BARCODE_ID,data0023.code,Data0023.RKEY,dbo.Data0017.QUAN_ON_HAND,d391.status'+#13+

      'union all'+#13+
    'SELECT     dbo.Data0017.RKEY, dbo.Data0017.INV_PART_NUMBER, dbo.Data0017.INV_NAME,'+#13+
    '  dbo.Data0017.INV_DESCRIPTION, dbo.Data0017.GROUP_PTR,'+#13+
    '  dbo.Data0023.CODE, dbo.Data0023.RKEY AS rkey23,'+#13+
    '  SUM(dbo.DATA0134.QUAN_ON_HAND) AS Qty, dbo.Data0002.UNIT_NAME, dbo.Data0023.ABBR_NAME,'+#13+
    '  dbo.Data0016.LOCATION, dbo.DATA0134.SUPPLIER2, dbo.DATA0134.BARCODE_ID,''VMI���'' AS XY_1,SUM(dbo.DATA0134.QUAN_ON_HAND) AS Qty,0 as LEN_SIZE ,0 as WEI_SIZE '+#13+
     ' , (case when (d391.status=2) or (d391.status is null )  then ''��''  else ''��''  end )  as  ''�Ƿ�ɷ���'' '+#13+
    'FROM         dbo.DATA0134 INNER JOIN'+#13+
    '      dbo.DATA0133 ON dbo.DATA0134.GRN_PTR = dbo.DATA0133.RKEY INNER JOIN'+#13+
    '      dbo.Data0017 ON dbo.DATA0134.INVENTORY_PTR = dbo.Data0017.RKEY INNER JOIN'+#13+
    '      dbo.Data0016 ON dbo.DATA0134.LOCATION_PTR = dbo.Data0016.RKEY INNER JOIN'+#13+
    '      dbo.Data0002 ON dbo.DATA0134.UNIT_PTR = dbo.Data0002.RKEY INNER JOIN'+#13+
    '      dbo.Data0023 ON dbo.DATA0133.SUPP_PTR = dbo.Data0023.RKEY INNER JOIN'+#13+
    '      dbo.Data0001 ON dbo.DATA0133.currency_ptr = dbo.Data0001.RKEY INNER JOIN'+#13+
    '      dbo.Data0496 ON dbo.Data0017.GROUP_PTR = dbo.Data0496.RKEY'+#13+
     ' left join data0391 d391 on data0134.rkey391=d391.rkey '+#13+
    'WHERE     (dbo.DATA0134.QUAN_ON_HAND > 0)'+#13+
    '          and dbo.Data0496.quote_flag=1'+#13+
    'GROUP BY dbo.Data0017.RKEY, dbo.Data0017.INV_PART_NUMBER, dbo.Data0017.INV_NAME,'+#13+
    ' dbo.Data0017.INV_DESCRIPTION, dbo.Data0017.GROUP_PTR,'+#13+
    ' dbo.Data0023.CODE, dbo.Data0023.RKEY, dbo.Data0002.UNIT_NAME,'+#13+
    ' dbo.Data0023.ABBR_NAME, dbo.Data0016.LOCATION, dbo.DATA0134.SUPPLIER2, dbo.DATA0134.BARCODE_ID,dbo.Data0017.QUAN_ON_HAND,d391.status'+#13+

    'union all'+#13+
    'SELECT  dbo.Data0556.RKEY, dbo.Data0017.INV_PART_NUMBER,'+#13+
    'Data0017.INV_NAME,data0017.INV_DESCRIPTION,data0017.GROUP_PTR,data0023.code,Data0023.RKEY as rkey23,'+#13+
    'dbo.Data0556.QUAN_ON_HAND as QUAN_ON_HAND2 ,'+#13+
    'dbo.Data0002.UNIT_NAME, dbo.Data0023.ABBR_NAME,''ͭ�����ϲ�'','+#13+
    'Data0556.REMARK,'''',''���Ͽ��'' AS XY_1,dbo.Data0556.QUAN_ON_HAND as QUAN_ON_HAND2,dbo.Data0556.LEN_SIZE,dbo.Data0556.WEI_SIZE'+#13+
    ' , ''��'' as ''�Ƿ�ɷ���'' '+#13+
    'FROM         dbo.Data0017 INNER JOIN'+#13+
    'dbo.Data0556 ON dbo.Data0017.RKEY = dbo.Data0556.RKEY17 left JOIN'+#13+
    'dbo.Data0023 ON dbo.data0556.SUPP_PTR = dbo.Data0023.RKEY INNER JOIN'+#13+
    'dbo.Data0002 ON data0017.stock_unit_ptr=dbo.Data0002.rkey'+#13+
    'WHERE   (dbo.Data0556.QUAN_ON_HAND > 0) and dbo.Data0556.Status=1'+#13+
    'GROUP BY dbo.Data0556.RKEY, dbo.Data0017.INV_PART_NUMBER, dbo.Data0017.INV_NAME,'+#13+
    'dbo.Data0002.UNIT_NAME, dbo.Data0023.ABBR_NAME,data0017.INV_DESCRIPTION,data0017.GROUP_PTR,'+#13+
    'Data0556.REMARK,data0023.code,Data0023.RKEY,dbo.Data0556.QUAN_ON_HAND,dbo.Data0017.QUAN_ON_HAND,dbo.Data0556.LEN_SIZE,dbo.Data0556.WEI_SIZE'+#13+
    'ORDER BY dbo.Data0017.INV_PART_NUMBER' ;
     //ShowMessage(InputVar.Sqlstr);
    end;
    if RadioGroup1.ItemIndex=1 then
    begin

       InputVar.Fields := 'INV_PART_NUMBER/���ϱ���/100,INV_NAME/��������/100,'+
                          'INV_DESCRIPTION/���Ϲ��/120,all_QUAN_ON_HAND/��ǰ���/60,'+
                          'unit_name/��λ/40,MANUFACTURER_NAME/�ر�Ҫ��/80';
       InputVar.Sqlstr :=
        'SELECT dbo.Data0017.RKEY, dbo.Data0017.INV_PART_NUMBER, dbo.Data0017.INV_NAME,'+#13+
        'dbo.Data0017.INV_DESCRIPTION, dbo.Data0002.UNIT_NAME,data0017.GROUP_PTR,'+#13+
        'dbo.Data0017.QUAN_ON_HAND - dbo.Data0017.QUAN_ASSIGN AS all_QUAN_ON_HAND,'+#13+
        'dbo.Data0017.MANUFACTURER_NAME, '''' as ABBR_NAME'+#13+
        'FROM         dbo.Data0017 INNER JOIN'+#13+
        'dbo.Data0002 ON dbo.Data0017.STOCK_UNIT_PTR = dbo.Data0002.RKEY'+#13+
        'WHERE     (dbo.Data0017.STOP_PURCH <> ''Y'')'+#13+
        'ORDER BY dbo.Data0017.INV_PART_NUMBER';
      end;
      {
    if RadioGroup1.ItemIndex=2 then
    begin

     InputVar.Fields := 'INV_PART_NUMBER/���ϱ���/100,INV_NAME/��������/100,'+
                        'INV_DESCRIPTION/���Ϲ��/120,QUAN_ON_HAND2/��ǰ���/55,'+
                        'unit_name/��λ/30,ABBR_NAME/��Ӧ��/80,LOCATION/�ֿ�/45,SUPPLIER2/ԭ��Ӧ��/50,BARCODE_ID/��ע/80,'+
                        'XY_1/�������/80,all_QUAN_ON_HAND/��ǰ�ܿ��/60,LEN_SIZE/���Ͼ���/60,WEI_SIZE/����γ��/60';
     InputVar.Sqlstr :=
     'SELECT  dbo.Data0556.RKEY  , dbo.Data0017.INV_PART_NUMBER,'+#13+
     'Data0017.INV_NAME,data0017.INV_DESCRIPTION,data0017.GROUP_PTR,data0023.code,Data0023.RKEY as rkey23,'+#13+
     'dbo.Data0556.QUAN_ON_HAND as QUAN_ON_HAND2 ,'+#13+
     'dbo.Data0002.UNIT_NAME, dbo.Data0023.ABBR_NAME,dbo.Data0016.LOCATION,'+#13+
     'Data0556.REMARK as SUPPLIER2 ,Data0558.remark as BARCODE_ID ,''���Ͽ��'' AS XY_1,dbo.Data0556.QUAN_ON_HAND as all_QUAN_ON_HAND,dbo.Data0556.LEN_SIZE,dbo.Data0556.WEI_SIZE'+#13+
     'FROM         dbo.Data0017 INNER JOIN'+#13+
     'dbo.Data0556 ON dbo.Data0017.RKEY = dbo.Data0556.RKEY17 INNER JOIN'+#13+
     'dbo.Data0557 ON dbo.Data0557.D556_PTR = dbo.Data0556.RKEY INNER JOIN'+#13+
     'dbo.Data0558 ON dbo.Data0557.D558_PTR = dbo.Data0558.RKEY INNER JOIN'+#13+
     'dbo.Data0016 ON dbo.Data0558.RKEY16 = dbo.Data0016.RKEY INNER JOIN'+#13+
     'dbo.Data0023 ON dbo.data0556.SUPP_PTR = dbo.Data0023.RKEY INNER JOIN'+#13+
     'dbo.Data0002 ON data0017.stock_unit_ptr=dbo.Data0002.rkey'+#13+
     'WHERE   (dbo.Data0556.QUAN_ON_HAND > 0) and dbo.Data0556.Status=1'+#13+
     'GROUP BY dbo.Data0556.RKEY, dbo.Data0017.INV_PART_NUMBER, dbo.Data0017.INV_NAME,'+#13+
     'dbo.Data0002.UNIT_NAME, dbo.Data0023.ABBR_NAME,dbo.Data0016.LOCATION,data0017.INV_DESCRIPTION,data0017.GROUP_PTR,'+#13+
     'Data0556.REMARK,Data0558.remark,data0023.code,Data0023.RKEY,dbo.Data0556.QUAN_ON_HAND,dbo.Data0017.QUAN_ON_HAND,dbo.Data0556.LEN_SIZE,dbo.Data0556.WEI_SIZE'+#13+
     'ORDER BY dbo.Data0017.INV_PART_NUMBER' ;
    end;   }

    inputvar.InPut_value:=edit3.Text;
    inputvar.KeyField:='INV_PART_NUMBER';
    InputVar.AdoConn := dm.ADOConnection1;
    frmPick_Item_Single2.adsPick1.LockType:=Ltreadonly;
    frmPick_Item_Single2.InitForm_New(InputVar);
    if frmPick_Item_Single2.ShowModal=mrok then
     begin
      if  (RadioGroup1.ItemIndex=0) then
      if (frmPick_Item_Single2.adsPick1.Fieldbyname('�Ƿ�ɷ���').AsString='��')   then
      begin
      ShowMessage('�������ϻ�δ�������鲻�ϸ�!');
      exit;
      end;

      edit3.Text := trim(frmPick_Item_Single2.adsPick1.FieldValues['INV_PART_NUMBER']);
      edit4.Text := frmPick_Item_Single2.adsPick1.Fieldbyname('INV_NAME').AsString;
      edit5.Text := frmPick_Item_Single2.adsPick1.Fieldbyname('INV_DESCRIPTION').AsString;
      edit8.Text := frmPick_Item_Single2.adsPick1.Fieldbyname('unit_name').AsString;
      edit10.Text :=frmPick_Item_Single2.adsPick1.Fieldbyname('all_QUAN_ON_HAND').AsString;

      if  (RadioGroup1.ItemIndex=0) then
      begin

      dm.ADOQuery15.Close;
      dm.ADOQuery15.Parameters.ParamByName('INV_PART_NUMBER').Value:=Edit3.text;
      dm.ADOQuery15.Parameters.ParamByName('Code_2').Value:=frmPick_Item_Single2.adsPick1.Fieldbyname('code').AsString;
      dm.ADOQuery15.open;
      edit23.Text:=dm.ADOQuery15.Fieldbyname('QUAN_ON_HAND_ABBR_NAME').AsString;
      end
      else
      edit23.Text:=frmPick_Item_Single2.adsPick1.Fieldbyname('all_QUAN_ON_HAND').AsString;
     // 0:edit10.Text := frmPick_Item_Single2.adsPick1.Fieldbyname('all_QUAN_ON_HAND').AsString;
     // 1:edit10.Text := frmPick_Item_Single2.adsPick1.Fieldbyname('Qty').AsString;
     // 2:edit10.Text := frmPick_Item_Single2.adsPick1.Fieldbyname('QUAN_ON_HAND2').AsString;
     // end;
      //edit15.Text := frmPick_Item_Single2.adsPick1.Fieldbyname('XY_1').AsString;

      {dm.ADOQuery13.Close;
      dm.ADOQuery13.Parameters.ParamByName('INV_PART_NUMBER').Value:=frmPick_Item_Single2.adsPick1.Fieldbyname('INV_PART_NUMBER').AsString;
      dm.ADOQuery13.open; }

      if  (Label18.Caption='���Ͽ��') and (RadioGroup1.ItemIndex=0)  then
      begin
      rkey556.Caption := frmPick_Item_Single2.adsPick1.Fieldbyname('rkey').AsString;
      end
      else
      begin
      rkey17.Caption := frmPick_Item_Single2.adsPick1.Fieldbyname('rkey').AsString;
      end;
      //rkey17.Caption :=dm.ADOQuery13.Fieldbyname('RKEY').AsString;
      if (RadioGroup1.ItemIndex=0) or (RadioGroup1.ItemIndex=2) then
       begin
        Edit7.Text := frmPick_Item_Single2.adsPick1.Fieldbyname('ABBR_NAME').AsString+
                      frmPick_Item_Single2.adsPick1.Fieldbyname('SUPPLIER2').AsString+':'+
                      frmPick_Item_Single2.adsPick1.Fieldbyname('BARCODE_ID').AsString;
        Edit13.Text:=frmPick_Item_Single2.adsPick1.Fieldbyname('code').AsString;
        label17.Caption:=frmPick_Item_Single2.adsPick1.Fieldbyname('ABBR_NAME').AsString;
        BitBtn5.Tag:=frmPick_Item_Single2.adsPick1.Fieldbyname('rkey23').AsInteger;
       // Label18.Caption:=frmPick_Item_Single2.adsPick1.Fieldbyname('XY_1').AsString;
        Label18.visible:=False;
        edit15.Text := frmPick_Item_Single2.adsPick1.Fieldbyname('XY_1').AsString;
       end;

       if edit15.Text='���Ͽ��' then
       begin
        Label28.Visible:=True;
        Label29.Visible:=True;
        edit21.Visible:=True;
        edit22.Visible:=True;
        BitBtn6.Enabled:=False;
        edit21.Text:=frmPick_Item_Single2.adsPick1.Fieldbyname('LEN_SIZE').AsString;;
        edit22.Text:=frmPick_Item_Single2.adsPick1.Fieldbyname('WEI_SIZE').AsString;;
       end
       else
       begin
        Label28.Visible:=false;
        Label29.Visible:=false;
        edit21.Visible:=false;
        edit22.Visible:=false;
        BitBtn6.Enabled:=True;
       end;



      group_ptr.Caption:=frmPick_Item_Single2.adsPick1.Fieldbyname('GROUP_PTR').AsString;

      combobox2.Enabled:=false;
//2013-01-21��ӹ���ע��������ʾ---------------------------------------------------

      if Label18.Caption='���Ͽ��' then
      begin
      ShowSG(group_ptr.Caption,rkey556.Caption);
      end
      else
      begin
      ShowSG(group_ptr.Caption,rkey17.Caption);
      end;






     end;
  finally
      frmPick_Item_Single2.adsPick1.Close;
      frmPick_Item_Single2.Free ;
  end;
  //      StringGrid1.Visible:=True;
  //      DBGrid1.Visible:=False;
  //      dm.AQ0499.Filter:='step_number='+edit9.Text;
  //      dm.AQ0499.Close;                      //�Ƴ̲���
  //      dm.AQ0499.Parameters.ParamByName('group_ptr').Value:=group_ptr.Caption;
  //      dm.AQ0499.Open;
  //end-------------------------------------------------------------------------------
end
else
 begin
  try
    frmPick_Item_Single2 := TfrmPick_Item_Single2.Create(application) ;
    frmPick_Item_Single2.BorderStyle:=bsSizeable;
    InputVar.Fields := 'MAT_CODE/���ϱ���/110,INV_DESCRIPTION/���Ϲ��/200,mat_desc/��������/200,REMARK/��Ӧ��/100,'+
                        'all_QUAN_ON_HAND/��ǰ���/80,unit_name/��λ/40,'+
                        'LEN_SIZE/���Ͼ���/60,WEI_SIZE/����γ��/60';
     InputVar.Sqlstr :=
      'SELECT  TOP 100 PERCENT DATA0556.MAT_CODE,Data0017.INV_DESCRIPTION, DATA0556.mat_desc,DATA0556.REMARK,'+#13+
      'DATA0556.QUAN_ON_HAND as all_QUAN_ON_HAND, dbo.DATA0556.LEN_SIZE,'+#13+
      'DATA0556.WEI_SIZE, DATA0556.RKEY, Data0002.UNIT_NAME,data0017.GROUP_PTR'+#13+
      'FROM   DATA0556 INNER JOIN'+#13+
      'Data0017 ON DATA0556.RKEY17 = Data0017.RKEY INNER JOIN'+#13+
      'Data0002 ON Data0017.STOCK_UNIT_PTR = Data0002.RKEY'+#13+
      'ORDER BY DATA0556.MAT_CODE';






    inputvar.InPut_value:=edit3.Text;
    inputvar.KeyField:='MAT_CODE';
    InputVar.AdoConn := dm.ADOConnection1;
    frmPick_Item_Single2.InitForm_New(InputVar);
    if frmPick_Item_Single2.ShowModal=mrok then
     begin
      edit3.Text := trim(frmPick_Item_Single2.adsPick1.FieldValues['MAT_CODE']);
      edit4.Text := trim(frmPick_Item_Single2.adsPick1.FieldValues['mat_desc']);
      edit5.Text := frmPick_Item_Single2.adsPick1.Fieldbyname('INV_DESCRIPTION').AsString;
      edit8.Text := frmPick_Item_Single2.adsPick1.Fieldbyname('unit_name').AsString;
      edit10.Text := frmPick_Item_Single2.adsPick1.Fieldbyname('all_QUAN_ON_HAND').AsString;
      if  (RadioGroup1.ItemIndex=0) then
      begin
      dm.ADOQuery15.Close;
      dm.ADOQuery15.Parameters.ParamByName('INV_PART_NUMBER').Value:=Edit3.text;
      dm.ADOQuery15.Parameters.ParamByName('Code_2').Value:=Edit13.text;
      dm.ADOQuery15.open;
      edit23.Text:=dm.ADOQuery15.Fieldbyname('QUAN_ON_HAND_ABBR_NAME').AsString;
      end
      else
      edit23.Text:=frmPick_Item_Single2.adsPick1.Fieldbyname('all_QUAN_ON_HAND').AsString;
      Label18.Caption := '���Ͽ��';

      {dm.ADOQuery13.Close;
      dm.ADOQuery13.Parameters.ParamByName('INV_PART_NUMBER').Value:=frmPick_Item_Single2.adsPick1.Fieldbyname('INV_PART_NUMBER').AsString;
      dm.ADOQuery13.open;}

      rkey17.Caption :=  frmPick_Item_Single2.adsPick1.Fieldbyname('rkey').AsString;
      //rkey17.Caption :=dm.ADOQuery13.Fieldbyname('RKEY').AsString;
      edit11.Text := frmPick_Item_Single2.adsPick1.Fieldbyname('LEN_SIZE').AsString;
      edit12.Text := frmPick_Item_Single2.adsPick1.Fieldbyname('WEI_SIZE').AsString;
      edit15.Text :='���Ͽ��';
      //group_ptr.Caption:=frmPick_Item_Single2.adsPick1.Fieldbyname('GROUP_PTR').AsString;
      combobox2.Enabled:=false;
  //2013-01-21��ӹ���ע��������ʾ---------------------------------------------------
      ShowSG(group_ptr.Caption,rkey17.Caption);
     end;




  finally
      frmPick_Item_Single2.adsPick1.Close;
      frmPick_Item_Single2.Free ;
  end;
  //      StringGrid1.Visible:=True;
  //      DBGrid1.Visible:=False;
  //      dm.AQ0499.Filter:='step_number='+edit9.Text;
  //      ShowMessage(group_ptr.Caption);
  //      dm.AQ0499.Close;                      //�Ƴ̲���
  //      dm.AQ0499.Parameters.ParamByName('group_ptr').Value:=group_ptr.Caption;
  //      dm.AQ0499.Open;
  //end-------------------------------------------------------------------------------
 end;

   {
   if  Edit15.caption='���Ͽ��' then
      begin
           Edit14.Enabled:=False;
      end
      else
         Edit14.Enabled:=True;       }





end;

procedure TForm_bominvt.BitBtn1Click(Sender: TObject);
var i:Integer;
    sName:string;
    tmpAdo:TADOQuery;
    tmpInt:Double;
    i_j:integer;
    sql_str:string;
begin

   dm.ADOQuery5.Close;
   dm.ADOQuery5.Parameters.ParamByName('INV_PART_NUMBER').Value:=Edit3.text;
   dm.ADOQuery5.open;

   dm.ADOQuery8.Close;
   dm.ADOQuery8.Parameters.ParamByName('MANU_PART_NUMBER').Value:=Edit1.text;
   dm.ADOQuery8.open;

 {
 for i_j:=1 to FrmEditBom.stg2.RowCount-2 do
  begin
  { dm.ADOQuery7.Close;
   dm.ADOQuery7.Parameters.ParamByName('INV_PART_NUMBER').Value:=Edit3.text;
   dm.ADOQuery7.Parameters.ParamByName('INV_PART_NUMBER_1').Value:=FrmEditBom.stg2.cells[2,i_j];
   dm.ADOQuery7.Parameters.ParamByName('CUT_NO').Value:=ComboBox1.text;
   dm.ADOQuery7.open;


     if  (dm.ADOQuery5.RecordCount>0) and (FrmEditBom.stg2.cells[2,i_j]=Edit3.text) and (Edit15.text='��ͨ���') then
   begin
        if    FrmEditBom.stg2.cells[8,i_j]='��׼'   then
        begin
        showmessage('������ʹ�����Ͽ��!');
        exit;
        end;
   end;

  end;    }

     with dm.TemADOQuery1 do
     begin
     close;
     sql.Clear;
     SQL.Text:='select PPC_CONTROL4 from data0192';
     open;
     end;

     ////////////////////////////////////////////////////////////////////////////////////
     sql_str:='select Data0023.CODE, Data0023.abbr_NAME from data0023 '+
    'where rkey='+inttostr(BitBtn5.tag);
    openquery(dm.TemADOQuery2,sql_str);

    dm.ADOQuery15.Close;
    dm.ADOQuery15.Parameters.ParamByName('INV_PART_NUMBER').Value:=Edit3.Text; //'���ϱ���';
    dm.ADOQuery15.Parameters.ParamByName('Code_2').Value:=dm.TemADOQuery2.fieldbyname('CODE').AsString;
    dm.ADOQuery15.open;





     ////////////////////////////////////////////////////////////////////////////////////

    if (Edit13.Text<>'') then
    begin
    if (strtofloat(Edit6.Text)>(dm.ADOQuery15.fieldbyname('QUAN_ON_HAND_ABBR_NAME').Value))  then
    begin
    showmessage('����������ܳ����ù�Ӧ�̿������!');
    exit;
    end;
    end;


    if (dm.TemADOQuery1.fieldbyname('PPC_CONTROL4').Value=1) and (Edit13.Text='')then
    begin
    if (strtofloat(Edit6.Text)>strtofloat(Edit10.Text))  then
    begin
    showmessage('����������ܳ����ܿ������!');
    exit;
    end;
    end;


   ////////////////////////////////////////////////////////////////////////////////////////////////

   if  (DM.ADOQuery5.FieldByName('LEN_SIZE').Value>DM.ADOQuery8.FieldByName('PNL_LEN').Value) and
       (DM.ADOQuery5.FieldByName('WEI_SIZE').Value>DM.ADOQuery8.FieldByName('PNL_WTH').Value)  then

   begin
     if  (dm.ADOQuery5.RecordCount>0) and (FrmEditBom.stg2.cells[8,1]='') and  (Edit15.text='��ͨ���') then
   begin
    showmessage('������ʹ�����Ͽ��!');
   end;
   end;

  ////////////////////////////////////////////////////////////////////////////////////////

if (strtofloat(edit6.Text)=0) then
 begin
  showmessage('�����������Ϊ��!');
  edit6.SetFocus;
  exit;
 end;




if (trim(edit2.Text)='') then
 begin
  showmessage('������벻��Ϊ��!');
  edit2.SetFocus;
  exit;
 end;
if (trim(edit3.Text)='') then
 begin
  showmessage('���ϱ��벻��Ϊ��!');
  edit3.SetFocus;
  exit;
 end;



 //////////////////////////////////////////////////////////////////
  dm.ADOQuery6.close;
  dm.ADOQuery6.Parameters.ParamByName('CUT_NO').Value:=ComboBox1.text;
  dm.ADOQuery6.Parameters.ParamByName('CUT_NO_2').Value:=ComboBox1.text;
  dm.ADOQuery6.Parameters.ParamByName('MANU_PART_NUMBER').Value:=Edit1.text;
  dm.ADOQuery6.Parameters.ParamByName('AddPeiEshu').Value:=StrToFloat(Edit6.text);

  dm.ADOQuery6.open;


  if  (dm.ADOQuery6.fieldbyname('ReturnQ').AsInteger=1) and (dm.TemADOQuery1.fieldbyname('PPC_CONTROL4').Value=1)
  then
  begin
       ShowMessage('�����ϵ�������������������������������');
       Exit;
  end;




  dm.ADOQuery10.Close;
  dm.ADOQuery10.Parameters.ParamByName('MANU_PART_NUMBER').Value:=Edit1.text;
  dm.ADOQuery10.open;



  if  (dm.ADOQuery6.fieldbyname('ReturnQ').AsInteger=1) and  (Edit18.Text='') and (DM.ADOQuery10.fieldbyname('ReturnQ').AsInteger=1) and (Edit15.text<>'���Ͽ��') then
  begin
      showmessage('���ϵ�������������������������������,��ѡ�����ϵ�');
      Exit;
  end;

//----2013.01.28�޸Ĺ����������ϲ�����ͬ����ʾ------------
   while not DM.ads494.Eof do
   begin
     sName:=DM.ads494PARAMETER_NAME.Value;
     for i :=1  to StringGrid1.RowCount do
     begin
       if (sName=Trim(StringGrid1.Cells[1,i])) then
       begin
         if (UpperCase(Trim(DM.ads494PARAMETER_VALUE.AsString))<>UpperCase(Trim(StringGrid1.Cells[2,i]))) then
         begin
           //--2013.07.11�޸Ĺ����������ϲ�����һ��ʱ����ѯ278��PROTECTION_FLAG�Ƿ�Ϊ1��Ϊ1����һ�£�����ͨ��
            try
              tmpAdo:=TADOQuery.Create(Application);
              tmpAdo.Connection:=DM.ADOConnection1;
              tmpAdo.Close;
              tmpAdo.SQL.Clear;
              tmpAdo.SQL.Text:='select * from dbo.data0278 where PROTECTION_FLAG=1 and Rkey='+Trim(StringGrid1.Cells[4,i]);
              tmpAdo.Open;

              if (not tmpAdo.IsEmpty)  then
              begin
                //ShowMsg('������Ϊ��'+sName+'������������ͬ���������',1);

                if  (Edit18.Text='') and (DM.ADOQuery10.fieldbyname('ReturnQ').AsInteger=1) and (Edit15.text<>'���Ͽ��')then
                begin
                ShowMsg('������Ϊ��'+sName+'����һ��,���ϵ�Ϊ�գ�����д���ϵ���',1);
                Exit;
                end;
              end
              else

                if (Application.MessageBox(PChar('������Ϊ��'+sName+'������ֵ��ͬ���Ƿ������飿'), '������ʾ', MB_OKCANCEL + MB_ICONINFORMATION) = IDCANCEL) then Exit;
            finally
              tmpAdo.Close;
              tmpAdo.Connection:=nil;
              tmpAdo.Free;

            end;
           //--end 2013.07.11�޸�-------
         end;
       end;
     end;
     DM.ads494.Next;
   end;
//----end 2013.01.28----------------------------------------
 self.ModalResult:=mrok ;
end;

procedure TForm_bominvt.ComboBox2Change(Sender: TObject);
begin
 panel2.Visible:=combobox2.ItemIndex=1;
end;

procedure TForm_bominvt.FormActivate(Sender: TObject);
var sql_str:string;
begin
 sql_str:='select Data0034.DEPT_CODE, Data0034.DEPT_NAME from data0034 '+
          'where rkey='+rkey34.Caption;
 openquery(dm.TemADOQuery1,sql_str);
 if not dm.TemADOQuery1.IsEmpty then
 begin
  edit2.Text:=dm.TemADOQuery1.fieldbyname('DEPT_CODE').AsString;
  label4.Caption:=dm.TemADOQuery1.fieldbyname('DEPT_NAME').AsString;
 end;

 if BitBtn5.Tag > 0 then
  begin
   sql_str:='select Data0023.CODE, Data0023.abbr_NAME from data0023 '+
            'where rkey='+inttostr(BitBtn5.tag);
   openquery(dm.TemADOQuery1,sql_str);
   if not dm.TemADOQuery1.IsEmpty then
   begin
    Edit13.Text:=dm.TemADOQuery1.fieldbyname('CODE').AsString;
    label17.Caption:=dm.TemADOQuery1.fieldbyname('abbr_NAME').AsString;
   end;
  end;

if combobox2.ItemIndex=1 then
 begin
  sql_str:='select  dbo.DATA0556.LEN_SIZE,DATA0556.WEI_SIZE'+#13+
           'from data0556'+#13+
           'where rkey='+rkey17.Caption;
  openquery(dm.TemADOQuery1,sql_str);
  panel2.Visible:=true;
  edit11.Text := dm.TemADOQuery1.Fieldbyname('LEN_SIZE').AsString;
  edit12.Text := dm.TemADOQuery1.Fieldbyname('WEI_SIZE').AsString;
 end;
dm.TemADOQuery1.Close;
end;

procedure TForm_bominvt.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
begin
 with TMyDBGrid(Sender) do
 begin
  if DataLink.ActiveRecord=Row-1 then
   begin
    Canvas.Font.Color:=clWhite;
    Canvas.Brush.Color:=$00800040;
   end
  else
   begin
    Canvas.Brush.Color:=Color;
    Canvas.Font.Color:=Font.Color;
   end;

  if dm.ads494flow_spfc_flag.Value='Y' then
   Canvas.Font.Color := clred;
   
  DefaultDrawColumnCell(Rect,DataCol,Column,State);
 end;
end;

procedure TForm_bominvt.FormShow(Sender: TObject);
var iGRoup:Integer;
begin
//2013-01-21��ӹ���ע��������ʾ---------------------------------------------------
   if (edit9.Text<>'') then
   begin
//     dm.ads494.Filter:='step_number='+edit9.Text;
     dm.ads494.Close;                      //�Ƴ̲���
     dm.ads494.CommandText:=DM.ads494SQL+' and data0494.step_number=:step_number';                      //�Ƴ̲���
     dm.ads494.Parameters[0].Value:=rkey25.Caption;
     dm.ads494.Parameters[1].Value:=edit9.Text;
     dm.ads494.Open;
   end else
   begin
     dm.ads494.Close;                      //�Ƴ̲���
     dm.ads494.CommandText:=DM.ads494SQL+' and data0494.step_number=:step_number';                      //�Ƴ̲���
     dm.ads494.Parameters[0].Value:=-1;
     dm.ads494.Parameters[1].Value:=-1;
     dm.ads494.Open;
   end;
   if (rkey17.Caption<>'') then
   begin
     iGRoup:=Get17Group_ptr(rkey17.Caption);
     ShowSG(IntToStr(iGRoup),rkey17.Caption);
   end else
   begin
     StringGrid1.RowCount:=2;
     StringGrid1.Rows[1].Clear;
     stringgrid1.Cells[0,0] := '���';
     StringGrid1.ColWidths[0]:=30;
     stringgrid1.Cells[1,0] := '��������';
     StringGrid1.ColWidths[1]:=60;
     stringgrid1.Cells[2,0] := '����ֵ';
     StringGrid1.ColWidths[2]:=60;
     StringGrid1.Cells[3,0] := '��λ';
     StringGrid1.ColWidths[3]:=35;
   end;

   
   

//end-------------------------------------------------------------------------------
end;

procedure TForm_bominvt.btn1Click(Sender: TObject);
begin
  if not Assigned(frmCutView) then
    Application.CreateForm(TfrmCutView,frmCutView);
  frmCutView.Show;
end;

procedure TForm_bominvt.BitBtn5Click(Sender: TObject);
var
  InputVar: PDlgInput ;
begin
  try
    frmPick_Item_Single2 := TfrmPick_Item_Single2.Create(application) ;
    InputVar.Fields := 'CODE/��Ӧ�̴���/110,SUPPLIER_NAME/��Ӧ������/351,'+
                        'ABBR_NAME/���/80';
    InputVar.Sqlstr :=
    'SELECT TOP 100 PERCENT Data0023.CODE, Data0023.SUPPLIER_NAME,'+#13+
    'Data0023.ABBR_NAME, Data0023.RKEY'+#13+
    'FROM         dbo.Data0023'+#13+
    'WHERE  (dbo.Data0023.ttype in(0,2) )'+#13+
    'ORDER BY Data0023.CODE';

    inputvar.InPut_value:=Edit13.Text;
    inputvar.KeyField:='CODE';
    InputVar.AdoConn := dm.ADOConnection1;
    frmPick_Item_Single2.InitForm_New(InputVar);
    if frmPick_Item_Single2.ShowModal=mrok then
     begin
       Edit13.Text:=frmPick_Item_Single2.adsPick1.Fieldbyname('code').AsString;
       label17.Caption:=frmPick_Item_Single2.adsPick1.Fieldbyname('ABBR_NAME').AsString;
       BitBtn5.Tag:=frmPick_Item_Single2.adsPick1.Fieldbyname('rkey').AsInteger;
       if RadioGroup1.ItemIndex=1 then
       Edit7.Text:=Edit7.Text+label17.Caption;
     end;
  finally
      frmPick_Item_Single2.adsPick1.Close;
      frmPick_Item_Single2.Free ;
  end;
end;



procedure TForm_bominvt.Edit14KeyPress(Sender: TObject; var Key: Char);
begin
   if not (key in ['0'..'9','.',#13,#8]) then  //�ж��Ƿ���������
  abort


end;

procedure TForm_bominvt.Edit14KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if trim((sender as tedit).Text)='' then
 (sender as tedit).Text:='0';
end;

procedure TForm_bominvt.BitBtn6Click(Sender: TObject);
var
  InputVar: PDlgInput ;
begin
  try
   dm.ADOQuery9.Close;
   dm.ADOQuery9.Parameters.ParamByName('MANU_PART_NUMBER').Value:=Edit1.text;
   dm.ADOQuery9.open;

   dm.ADOQuery10.Close;
   dm.ADOQuery10.Parameters.ParamByName('MANU_PART_NUMBER').Value:=Edit1.text;
   dm.ADOQuery10.open;

    frmPick_Item_Single2 := TfrmPick_Item_Single2.Create(application) ;
    frmPick_Item_Single2.BorderStyle:=bsSizeable;
     InputVar.Fields := '����������/����������/30,�����������/�����������/100,�������/�������/200,���ϱ���/���ò��ϱ���/300,��������/���ò�������/150,���Ϲ��/���ò��Ϲ��/380,״̬/״̬/80';
     InputVar.Sqlstr := 'select Data0541.rkey as ''����������'',dbo.Data0541.MATERIAL_REPLACE_NO as ''�����������'''+#13+
  ',dbo.Data0025.MANU_PART_NUMBER as ''�������'',dbo.Data0017.INV_PART_NUMBER as ''���ϱ���'' , dbo.Data0017.INV_NAME as ''��������'',Data0017.INV_DESCRIPTION as ''���Ϲ��'','+#13+
  'case when ( check_status=0  and circle=1 ) then''δ�ύ''' +#13+
 'when  ( check_status=0  and circle>1 ) then ''�����ύ'''  +#13+
 'when   check_status=1 then ''�����'''+#13+
 'when  check_status=2 then  ''ȫ��ͨ�����'' end as ''״̬'''+#13+
  'from  Data0541 INNER JOIN'+#13+
  'dbo.Data0017 ON dbo.Data0541.INVT_PTR = dbo.Data0017.RKEY INNER JOIN'+#13+
  'dbo.Data0025 ON dbo.Data0541.d25_rkey = dbo.Data0025.RKEY INNER JOIN'+#13+
  'dbo.Data0010 ON dbo.Data0025.CUSTOMER_PTR = dbo.Data0010.RKEY INNER JOIN'+#13+
  'dbo.Data0005 ON dbo.Data0541.d05_ptr = dbo.Data0005.RKEY'+#13+
  'where (data0541.check_status=2) and'+#13+
  '(dbo.Data0025.MANU_PART_NUMBER like '''+dm.ADOQuery9.Fieldbyname('MANU_PART_NUMBER').AsString+'%'')';


   Inputvar.InPut_value:=edit18.Text;
   Inputvar.KeyField:='�����������';
   InputVar.AdoConn := dm.ADOConnection1;
   frmPick_Item_Single2.adsPick1.LockType:=Ltreadonly;
   frmPick_Item_Single2.InitForm_New(InputVar);
   if frmPick_Item_Single2.ShowModal=mrok then
   begin
      edit18.Text := trim(frmPick_Item_Single2.adsPick1.FieldValues['�����������']);
      edit19.Text := frmPick_Item_Single2.adsPick1.Fieldbyname('���ϱ���').AsString;
      Edit20.Text := frmPick_Item_Single2.adsPick1.Fieldbyname('���Ϲ��').AsString;
      Label27.Caption := frmPick_Item_Single2.adsPick1.Fieldbyname('����������').AsString;

       dm.ADOQuery11.Close;
       dm.ADOQuery11.Parameters.ParamByName('rkey541').Value:=frmPick_Item_Single2.adsPick1.Fieldbyname('����������').AsInteger;
       dm.ADOQuery11.open;
   end;
   finally
      frmPick_Item_Single2.adsPick1.Close;
      frmPick_Item_Single2.Free ;
  end;
  //and (DM.ADOQuery11.recordcount>0)
  if (DM.ADOQuery10.fieldbyname('ReturnQ').AsInteger=1) and (DM.ADOQuery11.fieldbyname('ReturnT').AsInteger=1)  then
  ShowMessage('���ϵ���û�����,��鿴���ϵ�����');
end;

procedure TForm_bominvt.Edit15Change(Sender: TObject);
begin
 if  Edit15.Text='���Ͽ��' then
      begin
           Edit14.Enabled:=False;
      end
      else
         Edit14.Enabled:=True;   
end;

procedure TForm_bominvt.Edit13Change(Sender: TObject);
begin
 if  Edit13.Text='' then
 Edit7.Text:='';

 if  Edit13.Text='' then
 Label17.Caption:='';

dm.ADOQuery15.Close;
dm.ADOQuery15.Parameters.ParamByName('INV_PART_NUMBER').Value:=Edit3.text;
dm.ADOQuery15.Parameters.ParamByName('Code_2').Value:=Edit13.Text;
dm.ADOQuery15.open;
edit23.Text:=dm.ADOQuery15.Fieldbyname('QUAN_ON_HAND_ABBR_NAME').AsString;
 





end;

procedure TForm_bominvt.Edit13DblClick(Sender: TObject);
begin
 Edit13.Text:='';
 Edit7.Text:='';
 Label17.Caption:='';
 Edit23.Text:='';
end;

end.
