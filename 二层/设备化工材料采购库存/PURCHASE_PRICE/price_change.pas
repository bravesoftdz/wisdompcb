unit price_change;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Grids, DBGrids, DB, ADODB, ExtCtrls,
  ComObj, Excel2000,ClipBrd, TeEngine, Series, TeeProcs, Chart, TeeFunci,
  ExtDlgs, Buttons;

type
  TForm3 = class(TForm)
    Button1: TButton;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Aqd328: TADODataSet;
    DataSource1: TDataSource;
    DBGrid1: TDBGrid;
    Aqd328EMPLOYEE_NAME: TStringField;
    Aqd328sys_longdate: TDateTimeField;
    Aqd328old_price: TFloatField;
    Aqd328new_price: TFloatField;
    Aqd328reason: TStringField;
    Aqd328sys_sortdate: TDateTimeField;
    Aqd328change: TFloatField;
    Aqd328rand: TFloatField;
    Panel1: TPanel;
    Button2: TButton;
    Chart1: TChart;
    Series1: TLineSeries;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    UpDown1: TUpDown;
    Edit2: TEdit;
    PrintDialog1: TPrintDialog;
    SavePictureDialog1: TSavePictureDialog;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
  private
    { Private declarations }
   v_colwidth: array of integer; 
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

uses damo;

{$R *.dfm}

procedure TForm3.FormCreate(Sender: TObject);
begin
self.Aqd328.Open;
end;

procedure TForm3.FormShow(Sender: TObject);
var
 i:byte;
begin
setlength(v_colwidth,dbgrid1.FieldCount);
for i:=0 to high(v_colwidth) do v_colwidth[i]:=dbgrid1.Columns[i].Width;
end;

procedure TForm3.FormResize(Sender: TObject);
var
 i:byte;
begin
for i:=low(v_colwidth) to high(v_colwidth) do
  dbgrid1.Columns[i].Width:=v_colwidth[i]+round((dbgrid1.Width-689)*v_colwidth[i]/660);
end;

procedure TForm3.Button2Click(Sender: TObject);
 var
   bm: TBookmark;
   col, row: Integer;
   sline: String;
   mem: TStringList;
   ExcelApp: Variant;
 begin
    if self.Aqd328.IsEmpty then exit;
    Screen.Cursor := crHourglass;
    DBGrid1.DataSource.DataSet.DisableControls;
    bm := DBGrid1.DataSource.DataSet.GetBookmark;
    DBGrid1.DataSource.DataSet.First;

    // create the Excel object
     ExcelApp := CreateOleObject('Excel.Application');
     ExcelApp.WorkBooks.Add(xlWBatWorkSheet);
     ExcelApp.WorkBooks[1].WorkSheets[1].Name := '价格变动信息';

    // First we send the data to a memo
    // works faster than doing it directly to Excel
    mem := TStringList.Create;
    sline := '';

    // add the info for the column names
    for col := 0 to DBGrid1.FieldCount-1 do
      sline := sline + DBGrid1.Fields[col].DisplayLabel + #9;
    mem.Add(sline);

    // get the data into the memo
    for row := 0 to DBGrid1.DataSource.DataSet.RecordCount-1 do
    begin
      sline := '';
      for col := 0 to DBGrid1.FieldCount-1 do
        sline := sline + DBGrid1.Fields[col].AsString + #9;
      mem.Add(sline);
      DBGrid1.DataSource.DataSet.Next;
    end;

    // we copy the data to the clipboard
    clipboard.Clear;
    Clipboard.AsText:=mem.Text;

    // if needed, send it to Excel
    // if not, we already have it in the clipboard
    ExcelApp.Workbooks[1].WorkSheets['价格变动信息'].Paste;
    ExcelApp.Visible := true;
    mem.Free;
    clipboard.Clear;
  //  FreeAndNil(ExcelApp);
    DBGrid1.DataSource.DataSet.GotoBookmark(bm);
    DBGrid1.DataSource.DataSet.FreeBookmark(bm);
    DBGrid1.DataSource.DataSet.EnableControls;
    Screen.Cursor := crDefault;
  end;

procedure TForm3.FormActivate(Sender: TObject);
begin
self.Aqd328.DisableControls;
 while not self.Aqd328.Eof do
  begin
   self.Series1.Add(self.Aqd328new_price.Value,self.Aqd328sys_sortdate.AsString);
   self.Aqd328.Next;
  end;
 Aqd328.First;
 self.Aqd328.EnableControls;
self.Chart1.Title.Text[0]:=dm.aq0028abbr_name.value+' '+
                           dm.aq0028inv_part_description.Value+
                           '价格变动曲线';
self.Chart1.LeftAxis.Title.Caption:='价格'+' ('+dm.aq0028curr_name.Value+')';                           
end;

procedure TForm3.Edit2Change(Sender: TObject);
begin
self.Chart1.MaxPointsPerPage:=updown1.Position;
end;

procedure TForm3.SpeedButton2Click(Sender: TObject);
begin
chart1.NextPage;
end;

procedure TForm3.SpeedButton1Click(Sender: TObject);
begin
chart1.PreviousPage;
end;

procedure TForm3.SpeedButton3Click(Sender: TObject);
begin
if self.SavePictureDialog1.Execute then
chart1.SaveToBitmapFile(self.SavePictureDialog1.FileName+'.bmp');
end;

procedure TForm3.SpeedButton4Click(Sender: TObject);
begin
if self.PrintDialog1.Execute then
self.Chart1.Print;
end;

end.
