unit mul_report;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids;

type
  TForm_mulreport = class(TForm)
    StG1: TStringGrid;
    StG2: TStringGrid;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Label1: TLabel;
    Label2: TLabel;
    Button5: TButton;
    Button6: TButton;
    procedure FormActivate(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_mulreport: TForm_mulreport;

implementation

uses damo;

{$R *.dfm}

procedure TForm_mulreport.FormActivate(Sender: TObject);
var
 i,rkey70:integer;
begin
stg1.Cells[0,0]:='�ɹ�������';
stg1.Cells[1,0]:='��Ӧ��';
stg2.Cells[0,0]:='�ɹ�������';
stg2.Cells[1,0]:='��Ӧ��';
rkey70:=dm.aq0070rkey.Value;
stg1.RowCount:=dm.AQ0070.RecordCount+2;
if stg1.RowCount<=18 then stg1.ColWidths[1]:=88;

dm.AQ0070.DisableControls;
dm.AQ0070.First;
for i:=1 to dm.AQ0070.RecordCount do
 begin
  stg1.Cells[0,i]:=dm.AQ0070po_number.Value;
  stg1.Cells[1,i]:=dm.AQ0070supp_abbrname.Value;
  stg1.Cells[2,i]:=dm.AQ0070rkey.AsString;
  stg1.Cells[3,i]:=inttostr(i);
  dm.AQ0070.Next;
 end;
dm.AQ0070.Locate('rkey',rkey70,[]);
dm.AQ0070.EnableControls;
end;

procedure TForm_mulreport.Button5Click(Sender: TObject);
begin
if stg2.RowCount>=3 then
 ModalResult:=mrok
else
 showmessage('��ѡ����Ҫ��ӡ��PO');
end;

procedure TForm_mulreport.Button1Click(Sender: TObject);
var
 i,j,ii,jj:integer;
begin                             //��һ��ʵ��stg2�Ĳ���
for i:=stg1.Selection.Top to stg1.Selection.Bottom do
 if i<>stg1.RowCount-1 then       //�����ǰ�в������һ��
  begin
   if stg2.RowCount=2 then        //���STG2��ǰ�ǿ���
    stg2.Rows[1].Text := stg1.Rows[i].Text
   else
    for ii:=1 to stg2.RowCount-2 do  //����Ѱ�Ҳ����λ�� ���ڵ�ǰ��
     if strtoint(stg2.Cells[3,ii])>strtoint(stg1.Cells[3,i]) then
      begin
       for jj:=stg2.RowCount-1 downto ii do
        if jj<>ii then
         stg2.Rows[jj].Text := stg2.Rows[jj-1].Text
        else
         stg2.Rows[jj].Text := stg1.Rows[i].Text;
       break;   //�����������ѭ��
      end
     else
      if ii=stg2.RowCount-2 then                //С�ڵ�ǰ�в��������һ��
       stg2.Rows[ii+1].Text := stg1.Rows[i].Text;
   stg2.RowCount := stg2.RowCount+1;
  end;
                                  //�ڶ���ʵ��stg1��ɾ��
 for i:=stg1.Selection.Top to stg1.Selection.Bottom do
  begin
   for j:=stg1.Selection.Top to stg1.RowCount-2 do
    stg1.Rows[j].Text:=stg1.Rows[j+1].Text;
   if stg1.Selection.Top<=stg1.RowCount-2 then
    stg1.RowCount:=stg1.RowCount-1;
  end;

if stg2.RowCount>=19 then stg2.ColWidths[1]:=75;
if stg1.RowCount<=18 then stg1.ColWidths[1]:=88;
end;

procedure TForm_mulreport.Button2Click(Sender: TObject);
var
 i,rkey70:integer;
begin
if stg1.RowCount>2 then
begin
rkey70:=dm.aq0070rkey.Value;
stg2.RowCount:=dm.AQ0070.RecordCount+2;
if stg2.RowCount>=19 then
 stg2.ColWidths[1]:=75
else
 stg2.ColWidths[1]:=92;

dm.AQ0070.DisableControls;
dm.AQ0070.First;
for i:=1 to dm.AQ0070.RecordCount do
 begin
  stg2.Cells[0,i]:=dm.AQ0070po_number.Value;
  stg2.Cells[1,i]:=dm.AQ0070supp_abbrname.Value;
  stg2.Cells[2,i]:=dm.AQ0070rkey.AsString;
  stg2.Cells[3,i]:=inttostr(i);
  dm.AQ0070.Next;
 end;
dm.AQ0070.Locate('rkey',rkey70,[]);
dm.AQ0070.EnableControls;

 for i:=1 to stg1.RowCount-2 do stg1.Rows[i].Clear;
 stg1.RowCount:=2;
 stg1.ColWidths[1]:=88;

end;
end;

procedure TForm_mulreport.Button3Click(Sender: TObject);
var
 i,ii,j,jj:integer;
begin                               //��һ��ʵ��stg1�Ĳ���
for i:=stg2.Selection.Top to stg2.Selection.Bottom do
 if i<>stg2.RowCount-1 then //�����ǰ�в������һ��
  begin
   if stg1.RowCount=2 then  //���STG1��ǰ�ǿ���
    stg1.Rows[1].Text := stg2.Rows[i].Text
   else
    for ii:=1 to stg1.RowCount-2 do //����Ѱ�Ҳ����λ��
     if strtoint(stg1.Cells[3,ii])>strtoint(stg2.Cells[3,i]) then
      begin
       for jj:=stg1.RowCount-1 downto ii do
        if jj<>ii then
         stg1.Rows[jj].Text := stg1.Rows[jj-1].Text
        else
         stg1.Rows[jj].Text := stg2.Rows[i].Text;
       break;   //�����������ѭ��
      end
     else                                                         //����
      if ii=stg1.RowCount-2 then//С�ڵ�ǰ�в��������һ��
       stg1.Rows[ii+1].Text := stg2.Rows[i].Text;
   stg1.RowCount := stg1.RowCount+1;
  end;
//******************************************************************************
for i:=stg2.Selection.Top to stg2.Selection.Bottom do//�ڶ���ʵ��stringgrid2��ɾ��
 begin
  for j:=stg2.Selection.Top to stg2.RowCount-2 do stg2.Rows[j].Text:=stg2.Rows[j+1].Text;
  if stg2.Selection.Top<=stg2.RowCount-2 then stg2.RowCount:=stg2.RowCount-1;
 end;
if stg2.RowCount<19 then stg2.ColWidths[1]:=92;
if stg1.RowCount>=19 then stg1.ColWidths[1]:=74;
end;

procedure TForm_mulreport.Button4Click(Sender: TObject);
var
 i,rkey70:integer;
begin
if stg2.RowCount>2 then
 begin
rkey70:=dm.aq0070rkey.Value;
stg1.RowCount:=dm.AQ0070.RecordCount+2;
if stg1.RowCount<=18 then
 stg1.ColWidths[1]:=88
else
 stg1.ColWidths[1]:=74;
dm.AQ0070.DisableControls;
dm.AQ0070.First;
for i:=1 to dm.AQ0070.RecordCount do
 begin
  stg1.Cells[0,i]:=dm.AQ0070po_number.Value;
  stg1.Cells[1,i]:=dm.AQ0070supp_abbrname.Value;
  stg1.Cells[2,i]:=dm.AQ0070rkey.AsString;
  stg1.Cells[3,i]:=inttostr(i);
  dm.AQ0070.Next;
 end;
dm.AQ0070.Locate('rkey',rkey70,[]);
dm.AQ0070.EnableControls;

 for i:=1 to stg2.RowCount-2 do stg2.Rows[i].Clear;
 stg2.RowCount:=2;
 stg2.ColWidths[1]:=92;
 end;
end;

end.
