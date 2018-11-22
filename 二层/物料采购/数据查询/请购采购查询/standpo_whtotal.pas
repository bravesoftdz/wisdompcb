unit standpo_whtotal;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, StdCtrls, ExtCtrls, Grids, DBGrids,ComObj, Excel2000,ClipBrd,
  ComCtrls, MXPIVSRC, MXDB, MXGRID, Mxstore, TeEngine, Series, TeeProcs,
  Chart, Buttons, ExtDlgs;

type
  TForm_whdate = class(TForm)
    DBGrid1: TDBGrid;
    DataSource1: TDataSource;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    ADOanalysis: TADOStoredProc;
    ADOanalysisgroup_name: TStringField;
    ADOanalysisABBR_NAME: TStringField;
    ADOanalysispurch_quan: TFloatField;
    ADOanalysispurch_amount: TFloatField;
    ADOanalysispurch_total_qty: TFloatField;
    ADOanalysispurch_total_amount: TFloatField;
    ADOanalysisqty_percent: TFloatField;
    ADOanalysismoney_percent: TFloatField;
    DataSource2: TDataSource;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    DBGrid2: TDBGrid;
    DecisionCube1: TDecisionCube;
    DecisionGrid1: TDecisionGrid;
    DecisionSource1: TDecisionSource;
    DecisionPivot1: TDecisionPivot;
    Edit1: TEdit;
    Label1: TLabel;
    Label2: TLabel;
    TabSheet4: TTabSheet;
    Chart1: TChart;
    Series1: TBarSeries;
    ComboBox1: TComboBox;
    Label3: TLabel;
    Label4: TLabel;
    ComboBox2: TComboBox;
    ADOquery1: TADOStoredProc;
    ADObalan: TADOStoredProc;
    CheckBox1: TCheckBox;
    UpDown1: TUpDown;
    Edit2: TEdit;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SavePictureDialog1: TSavePictureDialog;
    SpeedButton4: TSpeedButton;
    PrintDialog1: TPrintDialog;
    SpeedButton5: TSpeedButton;
    SpeedButton6: TSpeedButton;
    Aq19: TADOQuery;
    Aq19rkey: TIntegerField;
    Aq19inv_group_name: TStringField;
    Aq19inv_group_desc: TStringField;
    TabSheet5: TTabSheet;
    ADOgroup_balan: TADOStoredProc;
    Chart2: TChart;
    Series2: TBarSeries;
    ComboBox3: TComboBox;
    Label5: TLabel;
    Label6: TLabel;
    ComboBox4: TComboBox;
    ADOgroup_balanABBR_NAME: TStringField;
    ADOgroup_balanpurch_quan: TFloatField;
    ADOgroup_balanpurch_amount: TFloatField;
    ADOgroup_balanqty_percent: TFloatField;
    ADOgroup_balanamoney_percent: TFloatField;
    SpeedButton7: TSpeedButton;
    SpeedButton8: TSpeedButton;
    SpeedButton9: TSpeedButton;
    SpeedButton10: TSpeedButton;
    SpeedButton11: TSpeedButton;
    SpeedButton12: TSpeedButton;
    Edit3: TEdit;
    UpDown2: TUpDown;
    ADOquery1GRN_NUMBER: TStringField;
    ADOquery1INV_PART_NUMBER: TStringField;
    ADOquery1INV_NAME: TStringField;
    ADOquery1INV_DESCRIPTION: TStringField;
    ADOquery1GROUP_NAME: TStringField;
    ADOquery1code16: TStringField;
    ADOquery1SUPPLIER2: TStringField;
    ADOquery1PO_NUMBER: TStringField;
    ADOquery1code23: TStringField;
    ADOquery1QUANTITY: TFloatField;
    ADOquery1price_22: TFloatField;
    ADOquery1CURR_CODE: TStringField;
    ADOquery1total_price: TFloatField;
    ADOquery1inv_group_name: TStringField;
    ADOquery1UNIT_NAME: TStringField;
    ADOquery1TDATE: TDateTimeField;
    ADOquery1EMPLOYEE_NAME: TStringField;
    ADOquery1TAX_2: TBCDField;
    ADOanalysispici: TIntegerField;
    ADOquery1DELIVER_NUMBER: TStringField;
    procedure Button2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure DBGrid1TitleClick(Column: TColumn);
    procedure DBGrid2TitleClick(Column: TColumn);
    procedure CheckBox1Click(Sender: TObject);
    procedure ComboBox2Change(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpeedButton6Click(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure ComboBox3Change(Sender: TObject);
    procedure ComboBox4Change(Sender: TObject);
    procedure Edit3Change(Sender: TObject);
    procedure SpeedButton12Click(Sender: TObject);
    procedure SpeedButton11Click(Sender: TObject);
    procedure SpeedButton10Click(Sender: TObject);
    procedure SpeedButton9Click(Sender: TObject);
    procedure SpeedButton8Click(Sender: TObject);
    procedure SpeedButton7Click(Sender: TObject);
  private
    { Private declarations }
    po_fieldname,pota_fieldname:string;
    v_colwidth: array of integer;
  public
    { Public declarations }
  end;

var
  Form_whdate: TForm_whdate;

implementation

uses main,common;

{$R *.dfm}

procedure TForm_whdate.Button2Click(Sender: TObject);
var
 iCount, jCount: Integer;
 XLApp: Variant;
 Sheet: Variant;
begin
if self.PageControl1.ActivePageIndex=0 then
 begin
  common.Export_dbGrid_to_Excel(dbgrid1,pagecontrol1.ActivePage.Caption);
 end
else
 if self.PageControl1.ActivePageIndex=1 then
  begin
  common.Export_dbGrid_to_Excel(dbgrid2,pagecontrol1.ActivePage.Caption);
  end
 else
  begin
 Screen.Cursor := crHourGlass;
 if not VarIsEmpty(XLApp) then
  begin
   XLApp.DisplayAlerts := False;
   XLApp.Quit;
   VarClear(XLApp);
  end;

  try
   XLApp := CreateOleObject('Excel.Application');
  except
   Screen.Cursor := crDefault;
   Exit;
  end;

  XLApp.WorkBooks.Add;
  XLApp.SheetsInNewWorkbook := 1;

  XLApp.WorkBooks[1].WorkSheets[1].Name := pagecontrol1.ActivePage.Caption;
  Sheet := XLApp.Workbooks[1].WorkSheets[pagecontrol1.ActivePage.Caption];

   for iCount := 0 to decisiongrid1.ColCount-2 do   //����
    Sheet.Cells[1, iCount + 1 ] := decisiongrid1.Cells[iCount-2,-2];
              //1��1��                                //-2����-2��


   for jcount :=0 to decisiongrid1.RowCount-2 do    //��
    for iCount := 0 to decisiongrid1.ColCount-2 do  //��
     Sheet.Cells[jCount + 2, iCount + 1] := decisiongrid1.Cells[iCount-1,jcount-1];
                      //2��1��  
   XlApp.Visible := True;
   Screen.Cursor := crDefault;
  end;
end;

procedure TForm_whdate.FormShow(Sender: TObject);
var
 i:byte;
begin
setlength(v_colwidth,dbgrid2.FieldCount);
for i:=0 to high(v_colwidth) do v_colwidth[i]:=dbgrid2.Columns[i].Width;
end;

procedure TForm_whdate.FormResize(Sender: TObject);
var
 i:byte;
begin
for i:=low(v_colwidth) to high(v_colwidth) do
 dbgrid2.Columns[i].Width:=v_colwidth[i]+round((dbgrid2.Width-774)*v_colwidth[i]/748);
end;

procedure TForm_whdate.FormActivate(Sender: TObject);
begin
self.po_fieldname:='GRN_NUMBER';
self.pota_fieldname:='group_name';

self.Series1.Clear;
while not self.ADObalan.Eof do
 begin
  Series1.Add(ADObalan.FieldValues['purch_amount'],ADObalan.Fields[0].value);
  ADObalan.Next;
 end;
while not self.ADOgroup_balan.Eof do
 begin
  Series2.Add(self.ADOgroup_balanpurch_amount.Value,self.ADOgroup_balanABBR_NAME.Value);
  self.ADOgroup_balan.Next;
 end;
chart2.Title.Text[0]:=combobox3.Text+combobox4.Text+'��Ӧ�̶Ա�ͼ';

pagecontrol1.ActivePageIndex:=0;
end;

procedure TForm_whdate.Edit1Change(Sender: TObject);
begin
if trim(edit1.Text)<>'' then
 begin
  if pagecontrol1.ActivePageIndex=0 then
   adoquery1.Filter:=self.po_fieldname+' like ''%'+trim(edit1.Text)+'%'' '
  else
   adoanalysis.Filter:=self.pota_fieldname+' like ''%'+trim(edit1.Text)+'%'' ';
 end
else
 begin
  if pagecontrol1.ActivePageIndex=0 then
   adoquery1.Filter:=''
  else
   adoanalysis.Filter:='';
 end;
end;

procedure TForm_whdate.PageControl1Change(Sender: TObject);
begin
 edit1.Enabled:=true;
 combobox1.Enabled:=false;
 combobox2.Enabled:=false;
 checkbox1.Enabled:=false;
 button2.Enabled:=true;
 if edit1.Text<>'' then edit1.Text:='';
if pagecontrol1.ActivePageIndex=0 then
 begin
  label2.Visible:=false;
  label1.Visible:=true;
 end
else
 if pagecontrol1.ActivePageIndex=1 then
  begin
   label2.Visible:=true;
   label1.Visible:=false;
  end
 else
  if pagecontrol1.ActivePageIndex=2 then
   begin
    edit1.Enabled:=false;
   end
  else
   if pagecontrol1.ActivePageIndex=3 then
   begin
    combobox1.Enabled:=true;
    combobox2.Enabled:=true;
    checkbox1.Enabled:=true;
    edit1.Enabled:=false;
    button2.Enabled:=false;
   end
   else
    begin
     checkbox1.Enabled:=true;
     edit1.Enabled:=false;
     button2.Enabled:=false;
    end;
end;

procedure TForm_whdate.DBGrid1TitleClick(Column: TColumn);
begin
if (po_fieldname<>column.FieldName) and
   (column.ReadOnly) then
 begin
  self.po_fieldname := column.FieldName;
  self.Label1.Caption := column.Title.Caption;
  edit1.SetFocus;
 end;
end;

procedure TForm_whdate.DBGrid2TitleClick(Column: TColumn);
begin
if (pota_fieldname<>column.FieldName) and
   (column.ReadOnly) then
 begin
  self.pota_fieldname:=column.FieldName;
  self.Label2.Caption:=column.Title.Caption;
  edit1.SetFocus;
 end;
end;

procedure TForm_whdate.CheckBox1Click(Sender: TObject);
begin
chart1.View3D:=self.CheckBox1.Checked;
chart2.View3D:=self.CheckBox1.Checked;
end;

procedure TForm_whdate.ComboBox2Change(Sender: TObject);
begin
case combobox2.ItemIndex of
0:begin
   self.Series1.Clear;
   self.ADObalan.First;
   while not self.ADObalan.Eof do
    begin
     Series1.Add(ADObalan.FieldValues['purch_amount'],ADObalan.Fields[0].value);
     ADObalan.Next;
    end;
   self.Series1.ValueFormat:='0.00';
   self.Chart1.LeftAxis.AxisValuesFormat:='0';
   chart1.LeftAxis.Title.Caption:=combobox2.Text;
   chart1.Title.Text[0]:=combobox1.Text+combobox2.Text+'�Ա�ͼ';
  end;
1:begin
   self.Series1.Clear;
   self.ADObalan.First;
   while not self.ADObalan.Eof do
    begin
     Series1.Add(ADObalan.FieldValues['purch_quan'],ADObalan.Fields[0].value);
     ADObalan.Next;
    end;
   self.Series1.ValueFormat:='0.00';
   self.Chart1.LeftAxis.AxisValuesFormat:='0';
   chart1.LeftAxis.Title.Caption:=combobox2.Text;
   chart1.Title.Text[0]:=combobox1.Text+combobox2.Text+'�Ա�ͼ';
  end;
2:begin
   self.Series1.Clear;
   self.ADObalan.First;
   while not self.ADObalan.Eof do
    begin
     Series1.Add(ADObalan.FieldValues['amoney_percent'],ADObalan.Fields[0].value);
     ADObalan.Next;
    end;
   self.Series1.ValueFormat:='0.0000%';
   self.Chart1.LeftAxis.AxisValuesFormat:='0%';
   chart1.LeftAxis.Title.Caption:=combobox2.Text;
   chart1.Title.Text[0]:=combobox1.Text+combobox2.Text+'�Ա�ͼ';
  end;
3:begin
   self.Series1.Clear;
   self.ADObalan.First;
   while not self.ADObalan.Eof do
    begin
     Series1.Add(ADObalan.FieldValues['qty_percent'],ADObalan.Fields[0].value);
     ADObalan.Next;
    end;
   self.Series1.ValueFormat:='0.0000%';
   self.Chart1.LeftAxis.AxisValuesFormat:='0%';
   chart1.LeftAxis.Title.Caption:=combobox2.Text;
   chart1.Title.Text[0]:=combobox1.Text+combobox2.Text+'�Ա�ͼ';
  end;
end;
end;

procedure TForm_whdate.ComboBox1Change(Sender: TObject);
begin
self.ADObalan.Close;
self.ADObalan.Parameters[4].Value:=combobox1.ItemIndex;
self.ADObalan.Open;
self.ComboBox2Change(sender);
end;

procedure TForm_whdate.Edit2Change(Sender: TObject);
begin
self.Chart1.MaxPointsPerPage:=updown1.Position;
end;

procedure TForm_whdate.SpeedButton2Click(Sender: TObject);
begin
chart1.NextPage;

end;

procedure TForm_whdate.SpeedButton1Click(Sender: TObject);
begin
chart1.PreviousPage;
end;

procedure TForm_whdate.SpeedButton3Click(Sender: TObject);
begin
if self.SavePictureDialog1.Execute then
chart1.SaveToBitmapFile(self.SavePictureDialog1.FileName+'.bmp');
end;

procedure TForm_whdate.SpeedButton4Click(Sender: TObject);
begin
if self.PrintDialog1.Execute then
self.Chart1.Print;
end;

procedure TForm_whdate.SpeedButton6Click(Sender: TObject);
begin
  IF Chart1.view3doptions.Zoom>1 THEN
    Chart1.view3doptions.Zoom := Chart1.view3doptions.Zoom-2;
end;

procedure TForm_whdate.SpeedButton5Click(Sender: TObject);
begin
  IF Chart1.view3doptions.Zoom<300 THEN
    Chart1.view3doptions.Zoom := Chart1.view3doptions.Zoom+2;
end;

procedure TForm_whdate.ComboBox3Change(Sender: TObject);
begin
self.Aq19.MoveBy(combobox3.ItemIndex+1-aq19.RecNo);
self.ADOgroup_balan.Close;
self.ADOgroup_balan.Parameters[4].Value:=self.Aq19rkey.Value;
self.ADOgroup_balan.Open;
self.ComboBox4Change(sender);
end;

procedure TForm_whdate.ComboBox4Change(Sender: TObject);
begin
case combobox4.ItemIndex of
0:begin                             //�ɹ����
   self.Series2.Clear;
   self.ADOgroup_balan.First;
   while not self.ADOgroup_balan.Eof do
    begin
     Series2.Add(ADOgroup_balanpurch_amount.Value,ADOgroup_balanABBR_NAME.Value);
     ADOgroup_balan.Next;
    end;
   self.Series2.ValueFormat:='0.00';
   self.Chart2.LeftAxis.AxisValuesFormat:='0';
   chart2.LeftAxis.Title.Caption:=combobox4.Text;
   chart2.Title.Text[0]:=combobox3.Text+combobox4.Text+'��Ӧ�̶Ա�ͼ';
  end;
1:begin                            //�ɹ�����
   self.Series2.Clear;
   self.ADOgroup_balan.First;
   while not self.ADOgroup_balan.Eof do
    begin
     Series2.Add(self.ADOgroup_balanpurch_quan.Value,ADOgroup_balanABBR_NAME.Value);
     ADOgroup_balan.Next;
    end;
   self.Series2.ValueFormat:='0.00';
   self.Chart2.LeftAxis.AxisValuesFormat:='0';
   chart2.LeftAxis.Title.Caption:=combobox4.Text;
   chart2.Title.Text[0]:=combobox3.Text+combobox4.Text+'��Ӧ�̶Ա�ͼ';
  end;
2:begin                                //���ٷֱ�
   self.Series2.Clear;
   self.ADOgroup_balan.First;
   while not self.ADOgroup_balan.Eof do
    begin
     Series2.Add(self.ADOgroup_balanamoney_percent.Value,ADOgroup_balanABBR_NAME.Value);
     ADOgroup_balan.Next;
    end;
   self.Series2.ValueFormat:='0.0000%';
   self.Chart2.LeftAxis.AxisValuesFormat:='0%';
   chart2.LeftAxis.Title.Caption:=combobox4.Text;
   chart2.Title.Text[0]:=combobox3.Text+combobox4.Text+'��Ӧ�̶Ա�ͼ';
  end;
3:begin                              //�����ٷֱ�
   self.Series2.Clear;
   self.ADOgroup_balan.First;
   while not self.ADOgroup_balan.Eof do
    begin
     Series2.Add(self.ADOgroup_balanqty_percent.Value,ADOgroup_balanABBR_NAME.Value);
     ADOgroup_balan.Next;
    end;
   self.Series2.ValueFormat:='0.0000%';
   self.Chart2.LeftAxis.AxisValuesFormat:='0%';
   chart2.LeftAxis.Title.Caption:=combobox4.Text;
   chart2.Title.Text[0]:=combobox3.Text+combobox4.Text+'��Ӧ�̶Ա�ͼ';
  end;
end;
end;

procedure TForm_whdate.Edit3Change(Sender: TObject);
begin
self.Chart2.MaxPointsPerPage:=updown2.Position;
end;

procedure TForm_whdate.SpeedButton12Click(Sender: TObject);
begin
chart2.NextPage;
end;

procedure TForm_whdate.SpeedButton11Click(Sender: TObject);
begin
chart2.PreviousPage;
end;

procedure TForm_whdate.SpeedButton10Click(Sender: TObject);
begin
  IF Chart2.view3doptions.Zoom>1 THEN
    Chart2.view3doptions.Zoom := Chart2.view3doptions.Zoom-2;
end;

procedure TForm_whdate.SpeedButton9Click(Sender: TObject);
begin
  IF Chart2.view3doptions.Zoom<300 THEN
    Chart2.view3doptions.Zoom := Chart2.view3doptions.Zoom+2;
end;

procedure TForm_whdate.SpeedButton8Click(Sender: TObject);
begin
if self.SavePictureDialog1.Execute then
chart2.SaveToBitmapFile(self.SavePictureDialog1.FileName+'.bmp');
end;

procedure TForm_whdate.SpeedButton7Click(Sender: TObject);
begin
if self.PrintDialog1.Execute then
self.Chart2.Print;
end;

end.
