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
    procedure add_strgrid(grid:tstringgrid);
  public
    { Public declarations }
  end;

var
  Form_mulreport: TForm_mulreport;

implementation

uses damo;

{$R *.dfm}

procedure TForm_mulreport.Button5Click(Sender: TObject);
begin
if stg2.RowCount>=3 then
 ModalResult:=mrok
else
 showmessage('��ѡ��Ҫ��ӡ��װ�䵥!');
end;

procedure TForm_mulreport.add_strgrid(grid: tstringgrid);
var
 i,rkey439:integer;
begin

rkey439:=dm.ADO0439rkey.Value;
dm.ADO0439.DisableControls;
dm.ADO0439.First;
for i:=1 to dm.ADO0439.RecordCount do
 begin
  if (dm.ADO0439cod_flag.Value = 'Y') and //(V_pk - V_defi > 0.1) then
   (dm.sql_codflag(dm.ADO0439rkey.Value)) then
  else
  begin
   grid.Cells[0,grid.RowCount-1]:=dm.ADO0439delivery_no.Value;
   grid.Cells[1,grid.RowCount-1]:=dm.ADO0439cust_code.Value;
   grid.Cells[2,grid.RowCount-1]:=dm.ADO0439rkey.AsString;
   grid.Cells[3,grid.RowCount-1]:=inttostr(i);
   grid.RowCount:=grid.RowCount+1;
  end;
  dm.ADO0439.Next;
 end;
dm.ADO0439.Locate('rkey',rkey439,[]);
dm.ADO0439.EnableControls;

end;

procedure TForm_mulreport.FormActivate(Sender: TObject);

begin
stg1.Cells[0,0]:='װ�˱��';
stg1.Cells[1,0]:='�ͻ�����';
stg1.ColWidths[2]:=-1;
stg1.ColWidths[3]:=-1;

stg2.Cells[0,0]:='װ�˱��';
stg2.Cells[1,0]:='�ͻ�����';
stg2.ColWidths[2]:=-1;
stg2.ColWidths[3]:=-1;

//stg1.RowCount:=dm.ADO0439.RecordCount+2;
//if stg1.RowCount<=18 then stg1.ColWidths[1]:=88;

add_strgrid(stg1);
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

end;

procedure TForm_mulreport.Button2Click(Sender: TObject);
var
 i:integer;
begin
if stg1.RowCount>2 then
begin

 for i:=1 to stg2.RowCount-2 do stg2.Rows[i].Clear;
 stg2.RowCount:=2;

 self.add_strgrid(stg2);

 for i:=1 to stg1.RowCount-2 do stg1.Rows[i].Clear;
 stg1.RowCount:=2;


end;
end;

procedure TForm_mulreport.Button4Click(Sender: TObject);
var
 i:integer;
begin
if stg2.RowCount>2 then
 begin

 for i:=1 to stg1.RowCount-2 do stg1.Rows[i].Clear;
 stg1.RowCount:=2;

 self.add_strgrid(stg1);

 for i:=1 to stg2.RowCount-2 do stg2.Rows[i].Clear;
 stg2.RowCount:=2;

 end;
end;


end.
