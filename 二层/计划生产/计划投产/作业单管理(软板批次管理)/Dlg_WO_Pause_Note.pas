unit Dlg_WO_Pause_Note;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls,AdoDB;

type
  TfrmDlg_WO_Pause_Note = class(TForm)
    Memo1: TMemo;
    Label1: TLabel;
    Label2: TLabel;
    Memo2: TMemo;
    btnYes: TButton;
    btnCancel: TButton;
  private
    { Private declarations }
  public
    { Public declarations }
    procedure InitForm(WOrKey,iType:integer);
  end;

var
  frmDlg_WO_Pause_Note: TfrmDlg_WO_Pause_Note;

implementation

uses Dm;

{$R *.dfm}

{ TfrmDlg_WO_Pause_Note }

procedure TfrmDlg_WO_Pause_Note.InitForm(WOrKey, iType: integer);
var
  sqlstr,tmpFlag:string;
  AdoqryTmp:TAdoQuery;
begin
  sqlstr:='';
  Memo1.Clear;
  if iType = 1 then//�ݻ�,�ָ�
    tmpFlag:=' (1,2) '
  else
    tmpFlag:=' (1,2,3,4,5,6,7) ';
  sqlstr:= ' select data0117.*,data0005.employee_name from data0005,data0117 '+
           ' where data0117.source_type=2 and data0117.source_ptr='+IntToStr(WORkey)+' and Action in '+tmpFlag+
           ' and data0117.empl_ptr=data0005.rkey';
   try
     AdoqryTmp:=TAdoQuery.Create(nil);
     AdoqryTmp.Connection := dmcon.ADOConnection1;
     AdoqryTmp.SQL.Clear;
     AdoqryTmp.SQL.Add(sqlstr);
     AdoqryTmp.Open;
     AdoqryTmp.First;
     with AdoqryTmp do
     while not AdoqryTmp.Eof do begin
        case Fieldbyname('action').asinteger of
        0:   Memo1.Lines.Add('=== �ӱ����д�����'+fieldbyname('tdate').asstring+'   ����:'+fieldbyname('employee_name').asstring+' ===');
        1:   Memo1.Lines.Add('=== ��ͣ������'+fieldbyname('tdate').asstring+'   ����:'+fieldbyname('employee_name').asstring+' ===');
        2:   Memo1.Lines.Add('=== �ָ�������'+fieldbyname('tdate').asstring+'   ����:'+fieldbyname('employee_name').asstring+' ===');
        3:   Memo1.Lines.Add('=== ȡ����ҵ����'+fieldbyname('tdate').asstring+'   ����:'+fieldbyname('employee_name').asstring+' ===');
        4:   Memo1.Lines.Add('=== �ָ���ҵ����'+fieldbyname('tdate').asstring+'   ����:'+fieldbyname('employee_name').asstring+' ===');
        5:   Memo1.Lines.Add('=== ��ҵ�������'+fieldbyname('tdate').asstring+'   ����:'+fieldbyname('employee_name').asstring+' ===');
        6:   Memo1.Lines.Add('=== �����ֲ���'+fieldbyname('tdate').asstring+'   ����:'+fieldbyname('employee_name').asstring+' ===');
        end;
        if trim(fieldbyname('remark').asstring)<>'' then
          Memo1.Lines.Add(fieldbyname('remark').asstring);
        next;
     end;
   finally
     AdoqryTmp.Close;
     AdoqryTmp.Free;
   end;
end;

end.
