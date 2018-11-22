unit UDetail;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls;

type
  TDetail_Form = class(TForm)
    Panel1: TPanel;
    Panel2: TPanel;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Edit1: TEdit;
    Label1: TLabel;
    Edit2: TEdit;
    Label2: TLabel;
    Label3: TLabel;
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Edit1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure Edit2Exit(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure Edit2Click(Sender: TObject);
    procedure Edit2Change(Sender: TObject);
    procedure Edit2KeyPress(Sender: TObject; var Key: Char);
  private
  v_close:byte;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Detail_Form: TDetail_Form;

implementation
uses UEP121,common;
{$R *.dfm}

procedure TDetail_Form.BitBtn2Click(Sender: TObject);
begin
 v_close:=1;
 Main_Form.ADOQuery1.Cancel;
end;

procedure TDetail_Form.BitBtn1Click(Sender: TObject);
begin
  IF trim(EDIT1.Text)='' then
    begin
        messagedlg('�����Ϊ��1111!',mtwarning,[mbok],0);
        edit1.SetFocus;
    end
else
  begin
    if (trim(edit2.Text)= '') or (strtofloat(trim(Edit2.Text)) = 0) or (strtofloat(trim(Edit2.Text)) = 0.00) then
    begin
       messagedlg('�ֵ���������Ϊ���Ϊ��!',mtwarning,[mbok],0);
        edit2.SetFocus;
         // v_close:=1; //�����˳�
         // ModalResult:=mrok;
    end
    else
     if strtofloat(trim(Edit2.Text)) > 100.00 then
      begin
        ShowMsg('�ֵ����ʲ����Դ���100%',1);
        edit2.Text := '100.00';
        edit2.SetFocus;
        edit2.SelectAll;
      end
      else
      begin
          Main_form.ADOQuery1.FieldValues['CATEGORY'] := edit1.Text;
          Main_form.ADOQuery1.FieldValues['SHARE_scale'] := formatfloat('0.00',strtofloat(trim(edit2.Text)));
          v_close:=1; //�����˳�
          ModalResult:=mrok;
      end;
  end;
end;

procedure TDetail_Form.FormActivate(Sender: TObject);
begin
 edit1.SetFocus;
 v_close:=0;
end;

procedure TDetail_Form.Edit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if key=13 then
  begin
    BitBtn1.SetFocus;
    BitBtn2Click(sender);
  end;
end;

procedure TDetail_Form.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
 if v_close<>1 then
  Main_form.ADOQuery1.Cancel;
end;

procedure TDetail_Form.Edit2Exit(Sender: TObject);
begin
if trim((sender as tedit).Text)='' then
 begin
  (sender as tedit).Text:='0.00';
  Main_form.ADOQuery1.fieldvalues['SHARE_scale']:=null;
  end;
  (sender as tedit).Text:=formatfloat('0.00',strtofloat((sender as tedit).Text));

end;

procedure TDetail_Form.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
 edit1.Text := '';
 edit2.Text := '0.00';
 edit2.Font.Color := clblue;
end;

procedure TDetail_Form.Edit2Click(Sender: TObject);
begin
 if edit2.Font.Color=clwindowtext then
  begin
   edit2.Font.Color:=clblue;
   edit2.SelectAll;
  end;
end;

procedure TDetail_Form.Edit2Change(Sender: TObject);
begin
if Edit2.Text<> '' then
  if strtofloat(trim(Edit2.Text)) > 100.00 then
    begin
        ShowMsg('�ֵ����ʲ����Դ���100%',1);
        edit2.Text := '0.00';
        edit2.SetFocus;
        edit2.SelectAll;
    end;
end;

procedure TDetail_Form.Edit2KeyPress(Sender: TObject; var Key: Char);
begin
 if not (key in ['0'..'9','.',#8]) then  //�ж��Ƿ���������
  abort
 else
  if key = chr(46) then      //�ж��Ƿ��ظ�����С����'.'
   if pos('.',(sender as tedit).Text)>0  then abort;
end;

end.
