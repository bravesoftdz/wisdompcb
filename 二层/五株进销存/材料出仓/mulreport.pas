unit mulreport;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, DB, ADODB;

type
  TForm_mulreport = class(TForm)
    StG1: TStringGrid;
    StG2: TStringGrid;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    Label1: TLabel;
    Label2: TLabel;
    procedure FormActivate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_mulreport: TForm_mulreport;

implementation

uses DM_u;

{$R *.dfm}

procedure TForm_mulreport.FormActivate(Sender: TObject);
var
 i:integer;
 keynum:string;
begin
stg1.Cells[0,0]:='��ֱ��';
stg2.Cells[0,0]:='��ֱ��';
keynum:=dm.ADOnumgon_number.Value;
dm.ADOnum.DisableControls;
dm.ADOnum.First;
stg1.RowCount:=2;
for i:=1 to dm.ADOnum.RecordCount do
begin
stg1.RowCount:=stg1.RowCount+1;
stg1.Cells[0,stg1.RowCount-2]:=dm.ADOnumGON_NUMBER.Value;
stg1.Cells[1,stg1.RowCount-2]:=inttostr(stg1.RowCount-2);
dm.ADOnum.Next;
end;
dm.ADOnum.Locate('gon_number',keynum,[]);
dm.ADOnum.EnableControls;
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
     if strtoint(stg2.Cells[1,ii])>strtoint(stg1.Cells[1,i]) then
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
 i:integer;
 key:string;
begin
if stg1.RowCount>2 then
begin
key:=dm.ADOnumgon_number.Value;
stg2.RowCount:=2;

dm.ADOnum.DisableControls;
dm.ADOnum.First;
for i:=1 to dm.ADOnum.RecordCount do
  begin
   stg2.RowCount:=stg2.RowCount+1;
   stg2.Cells[0,stg2.RowCount-2]:=dm.ADOnumgon_number.Value;
   stg2.Cells[1,stg2.RowCount-2]:=inttostr(stg2.RowCount-2);
  dm.ADOnum.Next;
 end;
dm.ADOnum.Locate('gon_number',key,[]);
dm.ADOnum.EnableControls;

 for i:=1 to stg1.RowCount-2 do stg1.Rows[i].Clear;
 stg1.RowCount:=2;
 stg1.ColWidths[1]:=88;
if stg2.RowCount>=19 then
 stg2.ColWidths[1]:=75
else
 stg2.ColWidths[1]:=92;

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
     if strtoint(stg1.Cells[1,ii])>strtoint(stg2.Cells[1,i]) then
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
 i:integer;
 key:string;
begin
if stg2.RowCount>2 then
 begin
  key:=dm.ADOnumgon_number.Value;
  stg1.RowCount:=2;

  dm.ADOnum.DisableControls;
  dm.ADOnum.First;
 for i:=1 to dm.ADOnum.RecordCount do
  begin
    stg1.RowCount:=stg1.RowCount+1;
    stg1.Cells[0,stg1.RowCount-2]:=dm.ADOnumgon_number.Value;
    stg1.Cells[1,stg1.RowCount-2]:=inttostr(stg1.RowCount-2);
    dm.ADOnum.Next;
  end;
 dm.ADOnum.Locate('gon_number',key,[]);
 dm.ADOnum.EnableControls;

 for i:=1 to stg2.RowCount-2 do stg2.Rows[i].Clear;
 stg2.RowCount:=2;
 stg2.ColWidths[1]:=92;

 if stg1.RowCount<=18 then
  stg1.ColWidths[1]:=88
 else
  stg1.ColWidths[1]:=74;

 end;
end;

procedure TForm_mulreport.Button5Click(Sender: TObject);
begin
if stg2.RowCount>=3 then
 ModalResult:=mrok
else
 showmessage('��ѡ��Ҫ��ӡ����ⵥ!');
end;


end.
