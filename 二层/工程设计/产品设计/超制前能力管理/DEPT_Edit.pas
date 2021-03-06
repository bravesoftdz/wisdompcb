unit DEPT_Edit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, DBCtrls, Mask, Buttons,ConstVar;

type
  TForm3 = class(TForm)
    DBEdit1: TDBEdit;
    Button1: TButton;
    Button2: TButton;
    BitBtn3: TBitBtn;
    DBMemo2: TDBMemo;
    DBMemo3: TDBMemo;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
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
  Form3: TForm3;

implementation

uses uNew,uDM, Pick_Item_Single, DEPT_Main;

{$R *.dfm}

procedure TForm3.Button2Click(Sender: TObject);
begin
    Close;
    v_close:=1;
    dm.ADOTable1.Cancel;
    FormNew.Show;

end;

procedure TForm3.Button1Click(Sender: TObject);
var
   flag:Integer;
begin
  if DbEdit1.Text='' then
  begin
    MessageDlg('��ѡ�������',mtinformation,[mbOk],0);
    DbEdit1.SetFocus;
    exit;
  end;
  {if DbMemo1.Text='' then
  begin
    MessageDlg('����������',mtinformation,[mbok],0);
    DbMemo1.SetFocus;
    exit;
  end; }

  

  try
    if dm.ADOTable1.Modified then
    begin
         dm.ADOTable1.Post;
    end;
  except
    MessageDlg('����ʧ�ܣ���������Ƿ��ظ�',mtwarning,[mbok],0);
    exit;
    end;
   close;
   v_close:=1;
   //FormNew.Show;
end;

procedure TForm3.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  {if v_close<>1 then
  begin
    Form1.ADOTable1.Cancel;
    Form1.Show;
  end;   }close;
end;

procedure TForm3.BitBtn3Click(Sender: TObject);
var
  rkey25:Integer;
  InputVar: PDlgInput ;
begin
   frmPick_Item_Single := TfrmPick_Item_Single.Create(application) ;
   try
   rkey25:=dm.ADO0738RKEY25.Value;
   with dm.ADOQuery1 do
   begin
   close;
   sql.Clear;
   SQL.Text:='select RKEY as rkey25,MANU_PART_NUMBER,MANU_PART_DESC from data0025 where RKEY='+quotedstr(inttostr(rkey25));
   open;
   end;

    InputVar.Fields :='DEPT_CODE/�������/110,DEPT_NAME/��������/251,'+
                        'STEP_NUMBER/����/80';

      InputVar.Sqlstr :='SELECT TOP 100 PERCENT Data0034.DEPT_CODE, Data0034.DEPT_NAME,'+#13+
      'Data0038.STEP_NUMBER, Data0034.RKEY'+#13+
      'FROM         dbo.Data0038 INNER JOIN'+#13+
      ' dbo.Data0034 ON dbo.Data0038.DEPT_PTR = dbo.Data0034.RKEY'+#13+
      'WHERE  (dbo.Data0034.IS_COST_DEPT = 1) and'+#13+
      '(dbo.Data0038.SOURCE_PTR ='+dm.ADOQuery1.fieldbyname('rkey25').AsString+')'+#13+
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
