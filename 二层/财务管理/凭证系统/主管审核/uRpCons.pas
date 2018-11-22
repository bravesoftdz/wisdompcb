unit uRpCons;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Grids, ExtCtrls;

type
  Tmul_Rp = class(TForm)
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
    procedure FormActivate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
  private
    { Private declarations }
    procedure setCol1With();//�����п�
    procedure setCol2With();
  public
    { Public declarations }
  end;

var
  mul_Rp: Tmul_Rp;

implementation

uses uDM;

{$R *.dfm}
//
procedure Tmul_Rp.setCol1With();
begin
if stg1.RowCount>18 then
 begin
  stg1.ColWidths[0]:=round(stg1.Width/5)*2;
  stg1.ColWidths[1]:=round(stg1.Width/5)*3-23;
 end
 else
  begin
   stg1.ColWidths[0]:=round(stg1.Width/5)*2;
   stg1.ColWidths[1]:=stg1.Width-round(stg1.Width/5)*2-7;
 end
end;


procedure Tmul_Rp.setCol2With();
begin
if stg2.RowCount>18 then
 begin
  stg2.ColWidths[0]:=round(stg2.Width/5)*2;
  stg2.ColWidths[1]:=round(stg2.Width/5)*3-23;
 end
else
 begin
  stg2.ColWidths[0]:=round(stg2.Width/5)*2;

  stg2.ColWidths[1]:=stg2.Width-round(stg2.Width/5)*2-7;
 end;

end;
procedure Tmul_Rp.FormActivate(Sender: TObject);
var
 i,rkey:integer;
begin
stg1.Cells[0,0]:='ƾ֤���';
stg1.Cells[1,0]:='ҵ������';
stg2.Cells[0,0]:='ƾ֤���';
stg2.Cells[1,0]:='ҵ������';
rkey:=dm.ADOQ105rkey.Value;
stg1.RowCount:=dm.ADOQ105.RecordCount+2;

if stg1.RowCount>18 then
 begin
  stg1.ColWidths[0]:=round(stg1.Width/5)*2;
  stg1.ColWidths[1]:=round(stg1.Width/5)*3-23;
 end;

dm.ADOQ105.DisableControls;
dm.ADOQ105.First;
for i:=1 to dm.ADOQ105.RecordCount do
 begin
  stg1.Cells[0,i]:=dm.ADOQ105voucher.Value;
  stg1.Cells[1,i]:=dm.ADOQ105ctype.Value;
  stg1.Cells[2,i]:=dm.ADOQ105rkey.AsString;
  stg1.Cells[3,i]:=inttostr(i);
  dm.ADOQ105.Next;
 end;
dm.ADOQ105.Locate('rkey',rkey,[]);
dm.ADOQ105.EnableControls;

end;

procedure Tmul_Rp.Button1Click(Sender: TObject);
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
 setCol2With //�����п�
end;
//ȫ�������ұ�
procedure Tmul_Rp.Button2Click(Sender: TObject);
var
 i,rkey:integer;
begin
if stg1.RowCount>2 then
begin
rkey:=dm.ADOQ105rkey.Value;
stg2.RowCount:=dm.ADOQ105.RecordCount+2;

setCol2With; //�����п�

dm.ADOQ105.DisableControls;
dm.ADOQ105.First;


for i:=1 to dm.ADOQ105.RecordCount do
 begin
  stg2.Cells[0,i]:=dm.ADOQ105voucher.Value;
  stg2.Cells[1,i]:=dm.ADOQ105ctype.Value;
  stg2.Cells[2,i]:=dm.ADOQ105rkey.AsString;
  stg2.Cells[3,i]:=inttostr(i);
  dm.ADOQ105.Next;
 end;
dm.ADOQ105.Locate('rkey',rkey,[]);
dm.ADOQ105.EnableControls;

 for i:=1 to stg1.RowCount-2 do stg1.Rows[i].Clear;
 stg1.RowCount:=2;
 stg1.ColWidths[1]:=88;
end;
end;
//һ�������
procedure Tmul_Rp.Button3Click(Sender: TObject);
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
setCol2With();
setCol1With();
end;
//ȫ���������
procedure Tmul_Rp.Button4Click(Sender: TObject);
var
 i,rkey:integer;
begin
if stg2.RowCount>2 then
begin
 rkey:=dm.ADOQ105rkey.Value;
 stg1.RowCount:=dm.ADOQ105.RecordCount+2;
 
 self.setCol1With;   
 dm.ADOQ105.DisableControls;
 dm.ADOQ105.First;
 for i:=1 to dm.ADOQ105.RecordCount do
  begin
   stg1.Cells[0,i]:=dm.ADOQ105voucher.Value;
   stg1.Cells[1,i]:=dm.ADOQ105ctype.Value;
   stg1.Cells[2,i]:=dm.ADOQ105rkey.AsString;
   stg1.Cells[3,i]:=inttostr(i);

   dm.ADOQ105.Next;
  end;
 dm.ADOQ105.Locate('rkey',rkey,[]);
 dm.ADOQ105.EnableControls;

 for i:=1 to stg2.RowCount-2 do stg2.Rows[i].Clear;
 
 stg2.RowCount:=2;
 stg2.ColWidths[1]:=92;
end;

end;

procedure Tmul_Rp.Button5Click(Sender: TObject);
begin
 if stg2.RowCount>=3 then
  ModalResult:=mrok
 else
  showmessage('��ѡ��Ҫ��ӡ�ĵ���!');
end;

end.
