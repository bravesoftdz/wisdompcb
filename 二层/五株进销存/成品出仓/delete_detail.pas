unit delete_detail;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ComCtrls;

type
  TForm3 = class(TForm)
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    Label1: TLabel;
    Label2: TLabel;
    Button1: TButton;
    Button2: TButton;
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

uses damo, main;

{$R *.dfm}

procedure TForm3.Button1Click(Sender: TObject);
begin
   if MessageBox(Handle,'ȷ��ɾ��������¼��?','��ʾ',MB_YESNO+MB_ICONWARNING+MB_DEFBUTTON2)=IDNO	then exit;
       //DM.ADOConnection1.BeginTrans;
       try
          DM.tmp.Close;
          DM.tmp.SQL.Text:='delete from product_issue where DATE_SHIPPED>='+quotedstr(FormatDateTime('yyyy-mm-dd hh:mm:ss',DateTimePicker1.Date))+
                           ' and DATE_SHIPPED<='+quotedstr(FormatDateTime('yyyy-mm-dd hh:mm:ss',DateTimePicker2.Date));
          if DateTimePicker2.Date>DateTimePicker1.Date+30 then
          begin
            if MessageBox(Handle,'����ѡ�����ڷ�Χ�ѳ���30�죬ȷ��Ҫɾ����','��ʾ',MB_YESNO+MB_ICONWARNING+MB_DEFBUTTON2)=IDYES then
            begin
              DM.tmp.ExecSQL;
              //DM.ADOConnection1.CommitTrans;
              showmessage('����ѡ�����ڷ�Χ�ڵ����ݱ��ɹ�ɾ��!');
            end;

          end
          else
          begin
            DM.tmp.ExecSQL;
            //DM.ADOConnection1.CommitTrans;
            showmessage('����ѡ�����ڷ�Χ�ڵ����ݱ��ɹ�ɾ��!');
          end;
          form1.BitBtn2Click(nil);

       except
         //DM.ADOConnection1.RollbackTrans;
       end;


end;

end.
