unit mul_report;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, ExtCtrls;

type
  TForm_mulreport = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    StG1: TStringGrid;
    StG2: TStringGrid;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    procedure Button5Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_mulreport: TForm_mulreport;

implementation

uses  damo;

{$R *.dfm}

procedure TForm_mulreport.Button5Click(Sender: TObject);
begin
if stg2.RowCount>=3 then
 ModalResult:=mrok
else
 showmessage('��ѡ��Ҫ��ӡ����ⵥ!');
end;

procedure TForm_mulreport.FormActivate(Sender: TObject);
var
 i,rkey209:integer;
begin
stg1.Cells[0,0]:='��Ʒ����';
stg1.Cells[1,0]:='��Ӧ��';
stg2.Cells[0,0]:='��Ʒ����';
stg2.Cells[1,0]:='��Ӧ��';

rkey209:=dm.ADS209Rkey.Value;

//stg1.RowCount:=dm.aqwz456.RecordCount+2;
stg1.RowCount:=2;
dm.ADS209.DisableControls;
dm.ADS209.First;

for i:=1 to dm.ADS209.RecordCount do
 begin
//  if dm.Aqwz456PRINTED.Value='N' then
//  begin
   stg1.RowCount:=stg1.RowCount+1;
   stg1.Cells[0,stg1.RowCount-2]:=dm.ADS209goods_name.Value;
   stg1.Cells[1,stg1.RowCount-2]:=dm.ADS209ABBR_NAME.Value;
   stg1.Cells[2,stg1.RowCount-2]:=dm.ADS209Rkey.AsString;
   stg1.Cells[3,stg1.RowCount-2]:=inttostr(stg1.RowCount-2);
//  end;
  dm.ADS209.Next;
 end;
dm.ADS209.Locate('rkey',rkey209,[]);
dm.ADS209.EnableControls;
if stg1.RowCount<=18 then stg1.ColWidths[1]:=88;

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

procedure TForm_mulreport.Button2Click(Sender: TObject);
var
 i,rkey209:integer;
begin
if stg1.RowCount>2 then
begin
rkey209:=dm.ADS209Rkey.Value;
stg2.RowCount:=2;

dm.ADS209.DisableControls;
dm.ADS209.First;
for i:=1 to dm.ADS209.RecordCount do
 begin
//  if dm.Aqwz456PRINTED.Value='N' then
//  begin
   stg2.RowCount:=stg2.RowCount+1;
   stg2.Cells[0,stg2.RowCount-2]:=dm.ADS209goods_name.Value;
   stg2.Cells[1,stg2.RowCount-2]:=dm.ADS209ABBR_NAME.Value;
   stg2.Cells[2,stg2.RowCount-2]:=dm.ADS209Rkey.AsString;
   stg2.Cells[3,stg2.RowCount-2]:=inttostr(stg2.RowCount-2);
//  end;
  dm.ADS209.Next;
 end;
dm.ADS209.Locate('rkey',rkey209,[]);
dm.ADS209.EnableControls;

 for i:=1 to stg1.RowCount-2 do stg1.Rows[i].Clear;
 stg1.RowCount:=2;
 stg1.ColWidths[1]:=88;
if stg2.RowCount>=19 then
 stg2.ColWidths[1]:=75
else
 stg2.ColWidths[1]:=92;

end;
end;

procedure TForm_mulreport.Button4Click(Sender: TObject);
var
 i,rkey209:integer;
begin
if stg2.RowCount>2 then
 begin
  rkey209:=dm.ADS209Rkey.Value;
  stg1.RowCount:=2;

  dm.ADS209.DisableControls;
  dm.ADS209.First;
 for i:=1 to dm.ADS209.RecordCount do
  begin
//   if dm.Aqwz456PRINTED.Value='N' then
//   begin
    stg1.RowCount:=stg1.RowCount+1;
    stg1.Cells[0,stg1.RowCount-2]:=dm.ADS209goods_name.Value;
    stg1.Cells[1,stg1.RowCount-2]:=dm.ADS209ABBR_NAME.Value;
    stg1.Cells[2,stg1.RowCount-2]:=dm.ADS209Rkey.AsString;
    stg1.Cells[3,stg1.RowCount-2]:=inttostr(stg1.RowCount-2);
//   end;
   dm.ADS209.Next;
  end;
 dm.ADS209.Locate('rkey',rkey209,[]);
 dm.ADS209.EnableControls;

 for i:=1 to stg2.RowCount-2 do stg2.Rows[i].Clear;
 stg2.RowCount:=2;
 stg2.ColWidths[1]:=92;

 if stg1.RowCount<=18 then
  stg1.ColWidths[1]:=88
 else
  stg1.ColWidths[1]:=74;

 end;
end;

end.
