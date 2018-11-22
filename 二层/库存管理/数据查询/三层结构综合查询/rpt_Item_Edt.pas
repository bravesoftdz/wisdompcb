unit rpt_Item_Edt;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,StrUtils;

type
  Tfrmrpt_Item_Edt = class(TForm)
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    edtRptName: TEdit;
    edtRptTitle: TEdit;
    edtFileName: TEdit;
    btnSave: TButton;
    btnCancel: TButton;
    procedure btnSaveClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frmrpt_Item_Edt: Tfrmrpt_Item_Edt;

implementation
uses pubfunc,constVar,Client_Func;
{$R *.dfm}

procedure Tfrmrpt_Item_Edt.btnSaveClick(Sender: TObject);
begin
  if trim(edtRptName.Text)= '' then
  begin
    ShowMsg('�������Ʋ���Ϊ��,����������','��ʾ',1);
    abort;
  end
  else if trim(edtRptTitle.Text)='' then
  begin
    ShowMsg('������ⲻ��Ϊ��,����������','��ʾ',1);
    abort;
  end
  else if trim(edtFileName.Text)='' then
  begin
    ShowMsg('������ⲻ��Ϊ��,����������','��ʾ',1);
    abort;
  end;
  if uppercase(AnsiRightStr(trim(edtFileName.Text),4))<>'.FR3' then
  begin
    ShowMsg('�����ļ����ƴ���,��ʽΪ:XXX.fr3,����������','��ʾ',1);
    abort;
  end;
  if not coMyQuery.Check_Record_Unique('select rptId from rpt_main where is__Group=1 and rptName='+QuotedStr(trim(edtRptName.Text))) then
  begin
    ShowMsg('���������ظ�,����������','��ʾ',1);
    abort;
  end;
  ModalResult := mrok;
end;

end.
