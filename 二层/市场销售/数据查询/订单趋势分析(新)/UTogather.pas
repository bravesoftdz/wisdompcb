unit UTogather;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls, ComCtrls, Grids, DBGridEh, DB,
  ADODB;

type
  TfrmTotather = class(TForm)
    pnl1: TPanel;
    pnl2: TPanel;
    pnl3: TPanel;
    BitBtn1: TBitBtn;
    btn1: TSpeedButton;
    Label4: TLabel;
    cbb1: TComboBox;
    pgc1: TPageControl;
    ts1: TTabSheet;
    ts2: TTabSheet;
    qry60_detail: TADOQuery;
    ds60_Detail: TDataSource;
    dsV: TDataSource;
    qryV: TADOQuery;
    dsH: TDataSource;
    qryH: TADOQuery;
    eh60: TDBGridEh;
    sg1: TStringGrid;
    procedure FormActivate(Sender: TObject);
    procedure cbb1Change(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure pgc1Change(Sender: TObject);
    procedure eh60KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
   function return_row(AField:Variant;AValue:Variant):integer;
   function return_col(AField:Variant;AValue:Variant):integer;
  public
    { Public declarations }
  end;

var
  frmTotather: TfrmTotather;

implementation
  uses common;
{$R *.dfm}

procedure TfrmTotather.FormActivate(Sender: TObject);
var
 i,m,n:integer;
begin

 cbb1.ItemIndex:=0;
  pgc1.ActivePageIndex:=0;

sg1.RowCount:=qryV.RecordCount+2;
sg1.ColCount:=qryH.RecordCount+2;

for i:=0 to eh60.Columns.Count-1 do
  eh60.Columns[i].Width:=100;

 qryV.First;  //1.��
 for i:=1 to qryV.RecordCount do
 begin
  sg1.Cells[0,i]:=qryV.Fields[0].asstring;//��һ������
        //���һ�еĻ���
  if cbb1.ItemIndex=0 then   //  ����
   sg1.Cells[sg1.ColCount-1,i]:=qryV.fieldbyname('����').AsString
  else if cbb1.ItemIndex=1 then   //  ���
   sg1.Cells[sg1.ColCount-1,i]:=qryV.fieldbyname('���').AsString
  else if cbb1.ItemIndex=2 then   //  ����˰���
   sg1.Cells[sg1.ColCount-1,i]:=qryV.fieldbyname('����˰���').AsString
  else if cbb1.ItemIndex=3 then   //  ��˰���
   sg1.Cells[sg1.ColCount-1,i]:=qryV.fieldbyname('��˰���').AsString;
  qryV.Next;
 end;
  ///////////////////////////////////
 qryH.First;     //��
for i:=1 to qryH.RecordCount do
 begin
    sg1.Cells[i,0]:=qryH.Fields[0].asstring;     //��һ��ֵ
        //���һ�еĻ���
    if cbb1.ItemIndex=0 then   //  ����
     sg1.Cells[i,sg1.RowCount-1]:=qryH.fieldbyname('����').AsString
    else if cbb1.ItemIndex=1 then   //  ���
     sg1.Cells[i,sg1.RowCount-1]:=qryH.fieldbyname('���').AsString
    else if cbb1.ItemIndex=2 then   //  ����˰���
     sg1.Cells[i,sg1.RowCount-1]:=qryH.fieldbyname('����˰���').AsString
    else if cbb1.ItemIndex=3 then   //  ��˰���
   sg1.Cells[i,sg1.RowCount-1]:=qryH.fieldbyname('��˰���').AsString;

  qryH.Next;
 end;

 ///////////////////////////////////////////////���м��ֵ
qry60_detail.DisableControls;
qry60_detail.First;
 while not qry60_detail.Eof do  
 begin
    if cbb1.ItemIndex=0 then   //  ����
    begin
     sg1.Cells[return_col(qry60_detail.fields[1].FieldName,qry60_detail.fields[1].value),
                  return_row(qry60_detail.fields[0].FieldName,qry60_detail.fields[0].value)]:=
                  qry60_detail.fieldbyname('����').asstring
    end             
    else  if cbb1.ItemIndex=1 then  // ���
     sg1.Cells[return_col(qry60_detail.fields[1].FieldName,qry60_detail.fields[1].value),
                  return_row(qry60_detail.fields[0].FieldName,qry60_detail.fields[0].value)]:=
                  qry60_detail.fieldbyname('���').asstring
    else  if cbb1.ItemIndex=2 then  // ����˰���
     sg1.Cells[return_col(qry60_detail.fields[1].FieldName,qry60_detail.fields[1].value),
                  return_row(qry60_detail.fields[0].FieldName,qry60_detail.fields[0].value)]:=
                  qry60_detail.fieldbyname('����˰���').asstring
      else  if cbb1.ItemIndex=3 then  //   ��˰���
     sg1.Cells[return_col(qry60_detail.fields[1].FieldName,qry60_detail.fields[1].value),
                  return_row(qry60_detail.fields[0].FieldName,qry60_detail.fields[0].value)]:=
                  qry60_detail.fieldbyname('��˰���').asstring;

  qry60_detail.Next;
 end;
  qry60_detail.First;
  qry60_detail.EnableControls;

    //����������
  sg1.Cells[0,0]:=qryV.Fields[0].FieldName;
  sg1.Cells[sg1.ColCount-1,0]:='����';
  sg1.Cells[0,sg1.RowCount-1]:='����';

end;

procedure TfrmTotather.cbb1Change(Sender: TObject);
var i:integer;
begin
qryV.First;  //1.��
 for i:=1 to qryV.RecordCount do
 begin
  sg1.Cells[0,i]:=qryV.Fields[0].asstring;//��һ������
        //���һ�еĻ���
  if cbb1.ItemIndex=0 then   //  ����
   sg1.Cells[sg1.ColCount-1,i]:=qryV.fieldbyname('����').AsString
  else if cbb1.ItemIndex=1 then   //  ���
   sg1.Cells[sg1.ColCount-1,i]:=qryV.fieldbyname('���').AsString
  else if cbb1.ItemIndex=2 then   //  ����˰���
   sg1.Cells[sg1.ColCount-1,i]:=qryV.fieldbyname('����˰���').AsString
  else if cbb1.ItemIndex=3 then   //  ��˰���
   sg1.Cells[sg1.ColCount-1,i]:=qryV.fieldbyname('��˰���').AsString;
  qryV.Next;
 end;
  ///////////////////////////////////
 qryH.First;     //��
for i:=1 to qryH.RecordCount do
 begin
    sg1.Cells[i,0]:=qryH.Fields[0].asstring;     //��һ��ֵ
        //���һ�еĻ���
    if cbb1.ItemIndex=0 then   //  ����
     sg1.Cells[i,sg1.RowCount-1]:=qryH.fieldbyname('����').AsString
    else if cbb1.ItemIndex=1 then   //  ���
     sg1.Cells[i,sg1.RowCount-1]:=qryH.fieldbyname('���').AsString
    else if cbb1.ItemIndex=2 then   //  ����˰���
     sg1.Cells[i,sg1.RowCount-1]:=qryH.fieldbyname('����˰���').AsString
    else if cbb1.ItemIndex=3 then   //  ��˰���
   sg1.Cells[i,sg1.RowCount-1]:=qryH.fieldbyname('��˰���').AsString;

  qryH.Next;
 end;

 ///////////////////////////////////////////////���м��ֵ
qry60_detail.DisableControls;
qry60_detail.First;
 while not qry60_detail.Eof do  
 begin
    if cbb1.ItemIndex=0 then   //  ����
    begin
     sg1.Cells[return_col(qry60_detail.fields[1].FieldName,qry60_detail.fields[1].value),
                  return_row(qry60_detail.fields[0].FieldName,qry60_detail.fields[0].value)]:=
                  qry60_detail.fieldbyname('����').asstring
    end             
    else  if cbb1.ItemIndex=1 then  // ���
     sg1.Cells[return_col(qry60_detail.fields[1].FieldName,qry60_detail.fields[1].value),
                  return_row(qry60_detail.fields[0].FieldName,qry60_detail.fields[0].value)]:=
                  qry60_detail.fieldbyname('���').asstring
    else  if cbb1.ItemIndex=2 then  // ����˰���
     sg1.Cells[return_col(qry60_detail.fields[1].FieldName,qry60_detail.fields[1].value),
                  return_row(qry60_detail.fields[0].FieldName,qry60_detail.fields[0].value)]:=
                  qry60_detail.fieldbyname('����˰���').asstring
      else  if cbb1.ItemIndex=3 then  //   ��˰���
     sg1.Cells[return_col(qry60_detail.fields[1].FieldName,qry60_detail.fields[1].value),
                  return_row(qry60_detail.fields[0].FieldName,qry60_detail.fields[0].value)]:=
                  qry60_detail.fieldbyname('��˰���').asstring;
  qry60_detail.Next;
 end;
  qry60_detail.First;
  qry60_detail.EnableControls;
end;

function TfrmTotather.return_col(AField, AValue: Variant): integer;
begin
 if qryH.Locate(afield,AValue,[]) then
 result:=qryH.RecNo
else
 result:=0;
end;

function TfrmTotather.return_row(AField, AValue: Variant): integer;
//var
// s:string;
begin
  //s:=  afield;
  if qryV.Locate(afield,AValue,[]) then
 result:=qryV.RecNo
else
 result:=0;
end;

procedure TfrmTotather.btn1Click(Sender: TObject);
begin
  if  pgc1.ActivePageIndex=0 then
  begin
    if (not qry60_detail.IsEmpty) then Export_dbGridEH_to_Excel(eh60,ts1.Caption);
  end
  else
  begin
    if  sg1.RowCount>2 then
    common.Export_Grid_to_Excel(sg1,ts2.Caption);
  end;
end;

procedure TfrmTotather.BitBtn1Click(Sender: TObject);
begin
close;
end;

procedure TfrmTotather.pgc1Change(Sender: TObject);
begin
  if pgc1.activepageindex=1 then
  begin
  cbb1.Enabled:=True;
  //btn1.Enabled:=false;
  end
  else
  begin
  cbb1.Enabled:=false;
  //btn1.Enabled:=true;
  end
end;

procedure TfrmTotather.eh60KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if (chr(key)='V') and (ssalt in shift) then showmessage(qry60_detail.SQL.Text);
end;

procedure TfrmTotather.FormShow(Sender: TObject);
begin
  eh60.Columns[0].Field:=qry60_detail.Fields[0];
  eh60.Columns[1].Field:=qry60_detail.Fields[1];
  eh60.Columns[0].Footer.FieldName:=qry60_detail.Fields[0].FieldName;
  eh60.Columns[1].Footer.FieldName:=qry60_detail.Fields[1].FieldName;
  eh60.Columns[0].Title.caption:= qry60_detail.Fields[0].FieldName;
  eh60.Columns[1].Title.caption:=qry60_detail.Fields[1].FieldName;

end;

end.
