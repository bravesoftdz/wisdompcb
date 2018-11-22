unit UAdEd;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Mask, DBCtrls, Buttons, DBCtrlsEh, ComCtrls,
  Grids;

type
  TAdEd_form = class(TForm)
    Panel3: TPanel;
    Label8: TLabel;
    SpeedButton5: TSpeedButton;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    GroupBox1: TGroupBox;
    Label4: TLabel;
    SpeedButton2: TSpeedButton;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    DBEditEh9: TDBEditEh;
    DBEditEh4: TDBEditEh;
    DBEditEh5: TDBEditEh;
    DBEditEh7: TDBEditEh;
    DBEditEh8: TDBEditEh;
    RadioGroup1: TRadioGroup;
    Panel1: TPanel;
    Label3: TLabel;
    Label1: TLabel;
    Label2: TLabel;
    ComboBox1: TComboBox;
    DBEditEh1: TDBEditEh;
    DBEditEh2: TDBEditEh;
    Panel2: TPanel;
    BtnSave: TBitBtn;
    BitBtn9: TBitBtn;
    SGrid: TStringGrid;
    DBDateTimeEditEh1: TDBDateTimeEditEh;
    DateTimePicker1: TDateTimePicker;
    Edit1: TEdit;
    Label12: TLabel;
    procedure FormShow(Sender: TObject);
    procedure SGridSelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure DateTimePicker1Change(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  AdEd_form: TAdEd_form;

implementation

uses Udm,COMMON,Pick_Item_Single,ConstVar;

{$R *.dfm}

procedure TAdEd_form.FormShow(Sender: TObject);
var
  TempRect: TRect;
begin
   // SGrid.RowHeights[0]:= 50;
    SGrid.Cells[0,0]:='��ҵ��ʼʱ��';
    SGrid.Cells[1,0]:='��ҵ����ʱ��';
    SGrid.Cells[2,0]:='PNL����';
    SGrid.Cells[3,0]:='PCS����';
    SGrid.Cells[4,0]:='PCS��Ʒ����';
    SGrid.Cells[5,0]:='��·';
    SGrid.Cells[6,0]:='��·';
    SGrid.Cells[7,0]:='ȱ��';
    SGrid.Cells[8,0]:='��ͭ';
    SGrid.Cells[9,0]:='ƫ��';
    SGrid.Cells[10,0]:='����';
    SGrid.Cells[11,0]:='�عⲻ��';
    SGrid.Cells[12,0]:='ʴ�̲���';
    SGrid.Cells[13,0]:='���㿪·';
    SGrid.Cells[14,0]:='����ȱ��';
    SGrid.Cells[15,0]:='�����·';
    SGrid.Cells[16,0]:='��������';
    Self.DateTimePicker1.Parent:=Self.SGrid;
    Self.DateTimePicker1.Visible:=False;
    ComboBox1.SetFocus;
end;

procedure TAdEd_form.SGridSelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
var
  R:TRect;
begin
  if (ACol = 0) or (ACol = 1)  then
  begin
          R:=TStringGrid(Sender).CellRect(ACol,ARow);
          Self.DateTimePicker1.Date:=StrToDateDef(TStringGrid(Sender).Cells[ACol,ARow],Now);
          Self.DateTimePicker1.Left:=R.Left;
          Self.DateTimePicker1.Top:=R.Top;
          Self.DateTimePicker1.Width:=R.Right-R.Left;
          Self.DateTimePicker1.Height:=R.Bottom-R.Top;
          Self.DateTimePicker1.Visible:=True;
          Self.DateTimePicker1.SetFocus;
  end else begin
       Self.DateTimePicker1.SetFocus;
  end;
end;

procedure TAdEd_form.DateTimePicker1Change(Sender: TObject);
begin
     Self.SGrid.Cells[Self.SGrid.Col,Self.SGrid.Row]:=DateToStr(TDateTimePicker(Sender).DateTime);
end;

procedure TAdEd_form.SpeedButton2Click(Sender: TObject);
var
  InputVar: PDlgInput ;
begin
 frmpick_item_single:=Tfrmpick_item_single.Create(application);
  try
    InputVar.Fields := 'MANU_PART_NUMBER/�������/150,PRODUCT_NAME/��������/150,ttype25/����/50';
    InputVar.Sqlstr := ' SELECT     dbo.Data0025.RKEY, dbo.Data0025.MANU_PART_NUMBER, dbo.Data0008.PRODUCT_NAME, '+#13+
                      ' CASE dbo.Data0025.ttype WHEN 0 THEN ''����'' WHEN 1 THEN ''����'' END AS ttype25 '+#13+
                      ' FROM         dbo.Data0025 INNER JOIN '+#13+
                      ' dbo.Data0008 ON dbo.Data0025.PROD_CODE_PTR = dbo.Data0008.RKEY '+#13+
                      ' WHERE     (dbo.Data0025.TSTATUS = 1) AND (dbo.Data0025.ONHOLD_SALES_FLAG = 0)'+#13;
    InputVar.AdoConn := DM.ADOConnection1;
    frmPick_Item_Single.InitForm_New(InputVar);
    if frmPick_Item_Single.ShowModal=mrok then
    begin
      Label12.Caption :=  frmPick_Item_Single.adsPick.FieldValues['RKEY'];
      Edit1.Text := frmPick_Item_Single.adsPick.FieldValues['MANU_PART_NUMBER'];
    end;
  finally
    frmPick_Item_Single.adsPick.Close;
    frmPick_Item_Single.Free ;
  end;
end;

procedure TAdEd_form.ComboBox1Change(Sender: TObject);
begin
     if ComboBox1.ItemIndex = 0 then
     begin
                SGrid.ColWidths[11] := -1;
                SGrid.ColWidths[12] := -1;
                SGrid.ColWidths[13] := -1;
                SGrid.ColWidths[14] := -1;
                SGrid.ColWidths[15] := -1;
                //SGrid.ColWidths[16] := -1;
     end else begin
                SGrid.ColWidths[11] := 50;
                SGrid.ColWidths[12] := 50;
                SGrid.ColWidths[13] := 50;
                SGrid.ColWidths[14] := 50;
                SGrid.ColWidths[15] := 50;
                //SGrid.ColWidths[16] := 50;
     end;
end;

end.
