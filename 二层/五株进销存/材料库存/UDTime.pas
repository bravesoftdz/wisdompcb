unit UDTime;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls, Buttons,DateUtils;

type
  TTime_Form = class(TForm)
    DTPK1: TDateTimePicker;
    Label1: TLabel;
    BitBtn3: TBitBtn;
    BitBtn2: TBitBtn;
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Time_Form: TTime_Form;

implementation

uses UDM,MainF;

function   LDOM(Date:   TDateTime):   TDateTime;   
      var   
          Year,   Month,   Day:   Word;   
      begin   
          DecodeDate(Date,   Year,   Month,   Day);   
          if   Month   <   12   then   inc(Month)   
          else   begin   Month   :=   1;   inc(Year)   end;   
          Result   :=   EncodeDate(Year,   Month,   1)   -   1;   
      end;

{$R *.dfm}

procedure TTime_Form.BitBtn2Click(Sender: TObject);
begin
  modalresult:=mrCancel;
end;

procedure TTime_Form.BitBtn3Click(Sender: TObject);
var
    v_message,i:Integer;
begin
    for i:= 1 to Main_Form.SGrid1.RowCount-1 do
    begin
         if DTPK1.Date<= StrToDate(Main_Form.SGrid1.Cells[1,i]) then
         begin
            ShowMessage('��ѡ������ڲ���ȷ��������ѡ��');
            Abort;
         end;
    end;

    if DTPK1.Date<> LDOM(DTPK1.Date) then
    begin
          v_message:=messagedlg('��ѡ��Ĳ��ǵ�ǰ�·ݵ����һ��������Ƿ����?',mtConfirmation,[mbyes,mbno],0);
          if v_message=6 then
               modalresult:=mrok;
    end else
      modalresult:=mrok;
end;

procedure TTime_Form.FormShow(Sender: TObject);
begin
  if dm.ADOConnection1.Connected then
  begin
     with dm.ADOTmp2 do
      begin
        close;
        sql.Text:='SELECT dateadd(ms,-3,DATEADD(mm, DATEDIFF(mm,0,getdate()), 0))  as last_date';
        open;
        dtpk1.Date:=DateOf(fieldvalues['last_date']);
        Close;
     end;
  end;
end;

end.
