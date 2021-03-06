unit DEPT_Add;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DBCtrls, Mask, Buttons,ConstVar, ComCtrls,common;

type
  TForm2 = class(TForm)
    DBEdit1: TDBEdit;
    Button1: TButton;
    Button2: TButton;
    Label1: TLabel;
    BitBtn3: TBitBtn;
    Label2: TLabel;
    DBMemo2: TDBMemo;
    Label3: TLabel;
    DBMemo3: TDBMemo;
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure BitBtn3Click(Sender: TObject);

  private
     v_close:byte;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

uses uDM,uNew,Pick_Item_Single;

{$R *.dfm}

procedure TForm2.Button2Click(Sender: TObject);
begin
    Close;
    v_close:=1;
    dm.ADOQuery2.Cancel;
    FormNew.Show;

end;

procedure TForm2.Button1Click(Sender: TObject);
var
   flag:Integer;
begin
  if DbEdit1.Text='' then
  begin
    MessageDlg('��ѡ�������',mtinformation,[mbOk],0);
    DbEdit1.SetFocus;
    exit;
  end;
 { if DbMemo1.Text='' then
  begin
    MessageDlg('����������',mtinformation,[mbok],0);
    DbMemo1.SetFocus;
    exit;
  end;  }
  try
    if dm.ADOQuery2.Modified then
    begin
      flag:=MessageDlg('�˼�¼���޸ģ��Ƿ����',mtinformation,[mbyes,mbno,mbcancel],0);
      if flag=7 then
         dm.ADOQuery2.Cancel
      else if flag=6 then
         dm.ADOQuery2.Post
      else
         exit;
    end;
  except
    MessageDlg('����ʧ�ܣ���������Ƿ��ظ�',mtwarning,[mbok],0);
    exit;
    end;
   close;
   v_close:=1;
   //FormNew.Show;
end;

procedure TForm2.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  if v_close<>1 then
  begin
    dm.ADOQuery2.Cancel;
    FormNew.Show;
  end;
end;

procedure TForm2.BitBtn3Click(Sender: TObject);
var
  InputVar: PDlgInput ;
begin
   frmPick_Item_Single := TfrmPick_Item_Single.Create(application) ;
   try
    InputVar.Fields :='DEPT_CODE/�������/110,DEPT_NAME/��������/251,'+
                        'STEP_NUMBER/����/80';

      InputVar.Sqlstr :='SELECT TOP 100 PERCENT Data0034.DEPT_CODE, Data0034.DEPT_NAME,'+#13+
      'Data0038.STEP_NUMBER, Data0034.RKEY'+#13+
      'FROM         dbo.Data0038 INNER JOIN'+#13+
      ' dbo.Data0034 ON dbo.Data0038.DEPT_PTR = dbo.Data0034.RKEY'+#13+
      'WHERE  (dbo.Data0034.IS_COST_DEPT = 1) and'+#13+
      'dbo.Data0038.SOURCE_PTR ='+quotedstr(dm.ADO0738.fieldbyname('RKEY25').Value)+#13+
      'ORDER BY dbo.Data0038.STEP_NUMBER';

    InputVar.AdoConn := dm.ADOConnection1;
    frmPick_Item_Single.InitForm_New(InputVar) ;

    if frmPick_Item_Single.ShowModal=mrok then
    begin
    DBEdit1.Text:=frmPick_Item_Single.adsPick.FieldValues['DEPT_CODE'];
    end;


   finally
   frmPick_Item_Single.adsPick.Close;
   frmPick_Item_Single.Free ;
  end;
  end;

end.
