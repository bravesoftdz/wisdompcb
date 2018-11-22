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
    CheckBox1: TCheckBox;
    StringGrid1: TStringGrid;
    CheckBox2: TCheckBox;
    cbx1: TCheckBox;
    cbx2: TCheckBox;
    procedure Button5Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }

    procedure MoveItem(stg1,Stg2:TStringGrid);
  public
    { Public declarations }
  end;

var
  Form_mulreport: TForm_mulreport;

implementation

uses  Dm;

{$R *.dfm}

procedure TForm_mulreport.Button5Click(Sender: TObject);
begin
if stg2.RowCount>=3 then
 ModalResult:=mrok
else
 showmessage('��ѡ��Ҫ��ӡ����ҵ��!');
end;

procedure TForm_mulreport.FormActivate(Sender: TObject);
var
 i,rkey439,j:integer;
// str_filter:string;
// bl_filtered:boolean;
begin
  stg1.Cells[0,0]:='��ҵ����';
  stg1.Cells[1,0]:='�������';
  stg2.Cells[0,0]:='��ҵ����';
  stg2.Cells[1,0]:='�������';
  stg1.ColWidths[2]:=-1;
  stg1.ColWidths[3]:=-1;
  stg1.ColWidths[4]:=-1;
  stg2.ColWidths[2]:=-1;
  stg2.ColWidths[3]:=-1;
  stg2.ColWidths[4]:=-1;


  rkey439:=dmcon.adsWOCtrlList.FieldByName('rKey').Asinteger;
  dmcon.adsWOCtrlList.DisableControls;
 
  j:=1;
  dmcon.adsWOCtrlList.First;
  for i:=1 to dmcon.adsWOCtrlList.RecordCount do
  begin
    if (dmcon.adsWOCtrlList.fieldByName('prod_Status').AsInteger=3 ) or
      (dmcon.adsWOCtrlList.fieldByName('prod_Status').AsInteger=4 ) or
      (dmcon.adsWOCtrlList.fieldByName('prod_Status').AsInteger=5 ) or
      (dmcon.adsWOCtrlList.fieldByName('prod_Status').AsInteger=6 ) then
    begin
      stg1.RowCount:=stg1.RowCount+1;
      stg1.Cells[0,j]:=dmcon.adsWOCtrlList.fieldByName('Work_order_Number').AsString;
      stg1.Cells[1,j]:=dmcon.adsWOCtrlList.fieldByName('MANU_PART_NUMBER').AsString;
      stg1.Cells[2,j]:=dmcon.adsWOCtrlList.fieldByName('rkey').AsString;
      stg1.Cells[3,j]:=inttostr(j);
      stg1.Cells[4,j]:=dmcon.adsWOCtrlList.fieldByName('bom_ptr').AsString;
      inc(j);
    end;
    dmcon.adsWOCtrlList.Next;
  end;
  
  MoveItem(stg1,stringgrid1);

  dmcon.adsWOCtrlList.Locate('rkey',rkey439,[]);
  dmcon.adsWOCtrlList.EnableControls;
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
//    InitAllItemsToGrid(stg2);
    for i:=1 to stg1.RowCount-2 do stg1.Rows[i].Clear;
    MoveItem(stringgrid1,stg2);
      stg1.RowCount:=2;
  end;
end;

procedure TForm_mulreport.Button4Click(Sender: TObject);
var
 i:integer;
begin
  if stg2.RowCount>2 then
  begin
//    InitAllItemsToGrid(stg1);
    for i:=1 to stg2.RowCount-2 do
     stg2.Rows[i].Clear;
    MoveItem(stringgrid1,stg1);
    stg2.RowCount:=2;
  end;
end;



procedure TForm_mulreport.MoveItem(stg1,stg2: TStringGrid);
var
 i,j:integer;
begin
  stg2.RowCount:= stg1.RowCount;
  stg2.ColCount := stg1.ColCount;
  for i := 0 to Stg1.RowCount - 1 do
  begin
    stg2.Rows[i].Clear;
    for j:= 0 to stg1.ColCount - 1 do
      stg2.Cells[j,i]:= stg1.Cells[j,i];
  end;
end;

end.
