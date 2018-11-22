unit apend_so;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Mask;

type
  TForm7 = class(TForm)
    Edit1: TEdit;
    Label1: TLabel;
    Edit2: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    MaskEdit1: TMaskEdit;
    Label4: TLabel;
    MaskEdit2: TMaskEdit;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Edit3: TEdit;
    Label5: TLabel;
    procedure Edit2KeyPress(Sender: TObject; var Key: Char);
    procedure Edit1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit3KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure MaskEdit1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure MaskEdit2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit2Exit(Sender: TObject);
    procedure Edit3Exit(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure Edit1Exit(Sender: TObject);
    procedure MaskEdit1Exit(Sender: TObject);
    procedure MaskEdit2Exit(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    qty:Integer;
  end;

var
  Form7: TForm7;

implementation

uses fencai_so, damo;

{$R *.dfm}

procedure TForm7.Edit2KeyPress(Sender: TObject; var Key: Char);
begin
if not (key in ['0'..'9',#8,#13]) then  //�ж��Ƿ���������
     abort;
end;

procedure TForm7.Edit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key=13 then edit2.SetFocus;
end;

procedure TForm7.Edit2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key=13 then edit3.SetFocus;
end;

procedure TForm7.Edit3KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key=13 then maskedit1.SetFocus;
end;

procedure TForm7.MaskEdit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key=13 then maskedit2.SetFocus;
end;

procedure TForm7.MaskEdit2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key=13 then bitbtn1.SetFocus;
end;

procedure TForm7.Edit2Exit(Sender: TObject);
begin
 if trim(edit2.Text)='' then edit2.Text := '0';
  edit3.Text:=inttostr(strtoint(edit2.Text)*form6.set_qty);
end;

procedure TForm7.Edit3Exit(Sender: TObject);
begin
 if trim(edit3.Text) = '' then edit3.Text := '0';

if (strtoint(edit3.Text) mod form6.set_qty) <> 0 then
 if messagedlg('������PCS��������,pcs���ǳ�������set�ı���!�Ƿ����?',mtconfirmation,[mbyes,mbno],0)=mryes then
  edit2.Text:=inttostr(round(strtoint(edit3.Text)/form6.set_qty))
 else
  edit3.SetFocus
else
 edit2.Text:=floattostr(strtoint(edit3.Text)/form6.set_qty);
end;

procedure TForm7.BitBtn1Click(Sender: TObject);
begin
  IF STRTOint(EDIT2.Text)=0 then
  begin
    showmessage('��ֵĶ�����������Ϊ��!');
    edit2.SetFocus;
  end
  else if strtoint(edit3.Text)>strtoint(form6.edit1.Text)-dm.ADOQuery3PARTS_SHIPPED.AsInteger then
  begin
    showmessage('��ֵĶ����������ܴ���ԭ������Ƿ����!');
    edit2.SetFocus;
  end
  else
    form7.ModalResult:=mrok;
end;

procedure TForm7.Edit1Exit(Sender: TObject);
begin
if trim(edit1.text)='' then
 begin
  showmessage('������Ų���Ϊ��!');
  edit1.SetFocus;
 end
else
 if pos('-',trim(edit1.Text))=0 then
  begin
   showmessage('������ű�����'' - ''������Ϊ�ֽ��!');
   edit1.SetFocus;
  end
 else
  if (copy(trim(edit1.Text),length(trim(edit1.Text)),1) < '0') or
     (copy(trim(edit1.Text),length(trim(edit1.Text)),1) > '9') then
   begin
    showmessage('������ű�����ֵ������!');
    edit1.SetFocus;
   end;
end;

procedure TForm7.MaskEdit1Exit(Sender: TObject);
begin
try
 maskedit2.Text := datetostr(strtodate(maskedit1.text)-dm.ADOQuery3rush_charge_pct_used.Value);
except
 messagedlg('�ͻ����������ʽ����,����ϸ���!',mtwarning,[mbok],0);
 maskedit1.SetFocus;
end;
end;

procedure TForm7.MaskEdit2Exit(Sender: TObject);
begin
try
 maskedit1.Text := datetostr(strtodate(maskedit2.text)+dm.ADOQuery3rush_charge_pct_used.Value);
except
 messagedlg('�ͻ����������ʽ����,����ϸ���!',mtwarning,[mbok],0);
 maskedit2.SetFocus;
end;
end;

end.
