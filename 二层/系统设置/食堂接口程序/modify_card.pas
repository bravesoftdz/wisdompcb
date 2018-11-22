unit modify_card;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, Buttons,StrUtils;

type
  TForm_modify_card = class(TForm)
    Label_empcode_cx: TLabel;
    Label_cardtime1_cx: TLabel;
    Label_empname_cx: TLabel;
    Label_cardtime2_xg: TLabel;
    MaskEdit_modify_cardtime: TMaskEdit;
    BitBtn_cardxg: TBitBtn;
    BitBtn_cardqx: TBitBtn;
    cx_empcode: TLabel;
    cx_empname: TLabel;
    cx_empcardtime: TLabel;
    BitBtn_cardadd: TButton;
    procedure BitBtn_cardxgClick(Sender: TObject);
    procedure BitBtn_cardqxClick(Sender: TObject);
    procedure BitBtn_cardaddClick(Sender: TObject);

  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form_modify_card: TForm_modify_card;

implementation

uses UDM, MainU;


{$R *.dfm}



procedure TForm_modify_card.BitBtn_cardxgClick(Sender: TObject);
var
modify_card_time :TDateTime;
DateTime,MyDate,MyTime : TDateTime;
DateStr,TimeStr:string;
begin
 if MaskEdit_modify_cardtime.Text='    -  -     :  :  ' then
begin
showmessage('ʱ��Ϊ��');
end ;
if MaskEdit_modify_cardtime.Text<>'    -  -     :  :  ' then
begin
  try
   modify_card_time:=strtodatetime(MaskEdit_modify_cardtime.Text)
   except
        ShowMessage('��ʽ����ȷ����������ȷ������ʱ��');
     end;
     // showmessage('ʱ���ʽ��ȷ33');
       // modify_card_time:= MyDate + MyTime;
       // showmessage(MaskEdit_modify_cardtime.Text);
       // showmessage('��ʼ�޸�33');

       if   modify_card_time<>strtodatetime('1899-12-30 00:00:00') then
       begin
       ShowMessage('����ʱ����'+datetimetostr(modify_card_time));
       //��ʼ����
       dm.ADOupdate_cx.SQL.Clear;
       dm.ADOupdate_cx.SQL.Text:='exec dbo.sp_ADOupdate_cx'+' '+
       quotedstr(leftstr(main_form.ComboBox1.Text,2))+' , '+
       trim(quotedstr(cx_empcode.Caption))+', '+
       quotedstr(cx_empcardtime.Caption)+' , '+
       quotedstr(maskedit_modify_cardtime.EditText);
       try
       dm.ADOupdate_cx.ExecSQL;
   //DM.ADODataSet_cx.Locate(dm.ADODataSet_cx.IndexFieldNames,dm.ADODataSet_cx.f)
   //locate('yourfield','Ҫ��λ��ֵ',[])
  //Form_modify_card:=Form_modify_card.Create(nil);
  //aSQLClientDataSet.Locate('City;District', VarArrayOf(['̨��,����']),[]);
       Form_modify_card.Close;
    //ˢ��
       //dm.ADODataSet_cx.Lookup()
       dm.ADODataSet_cx.Active:=false;
      dm.ADODataSet_cx.Active:=true;
      main_form.label_count1.Caption:=inttostr(dm.DataSource_cx.DataSet.RecordCount);
       //dm.ADODataSet_cx.DataSource.DataSet) )
    dm.ADODataSet_cx.Locate('����;��ʱ��',VarArrayOf([cx_empcode.Caption,maskedit_modify_cardtime.EditText]),[]);
     //exec dbo.sp_ADOupdate_cx 04 , '80411     ' , '2011-04-14 12:07:16' , '2011-04-14 12:47:16'
    // showmessage('�ض�λ���');
      //dmclient.ClientDataSet1.Locate('����;�Ա�;����',VarArrayOf([trim(edit2.Text),trim(ComboBox1.Text),trim(edit2.Text)]),[])
        except
       showmessage('�����޸�ʧ�ܣ��������޸�'); 
       end;

       end ;
       if   modify_card_time=strtodatetime('1899-12-30 00:00:00') then
       begin
       ShowMessage('����������ʱ��');
       end;

end;

end;



procedure TForm_modify_card.BitBtn_cardaddClick(Sender: TObject);
var
modify_card_time :TDateTime;
DateTime,MyDate,MyTime : TDateTime;
DateStr,TimeStr:string;
begin
 if MaskEdit_modify_cardtime.Text='    -  -     :  :  ' then
begin
showmessage('ʱ��Ϊ��');
end ;
if MaskEdit_modify_cardtime.Text<>'    -  -     :  :  ' then
begin
  try
   modify_card_time:=strtodatetime(MaskEdit_modify_cardtime.Text)
   except
        ShowMessage('��ʽ����ȷ����������ȷ������ʱ��');
     end;
     // showmessage('ʱ���ʽ��ȷ33');
       // modify_card_time:= MyDate + MyTime;
       // showmessage(MaskEdit_modify_cardtime.Text);
       // showmessage('��ʼ�޸�33');

       if   modify_card_time<>strtodatetime('1899-12-30 00:00:00') then
       begin
       ShowMessage('������ʱ����'+datetimetostr(modify_card_time));
       //��ʼ����
       dm.ADOupdate_cx.SQL.Clear;
       dm.ADOupdate_cx.SQL.Text:='exec dbo.sp_ADOupdate_cx_addcard'+' '+
       quotedstr(leftstr(main_form.ComboBox1.Text,2))+' , '+
       trim(quotedstr(cx_empcode.Caption))+', '+
       //quotedstr(cx_empcardtime.Caption)+' , '+
       quotedstr(maskedit_modify_cardtime.EditText);
       try
       dm.ADOupdate_cx.ExecSQL;
   //DM.ADODataSet_cx.Locate(dm.ADODataSet_cx.IndexFieldNames,dm.ADODataSet_cx.f)
   //locate('yourfield','Ҫ��λ��ֵ',[])
  //Form_modify_card:=Form_modify_card.Create(nil);
  //aSQLClientDataSet.Locate('City;District', VarArrayOf(['̨��,����']),[]);
       Form_modify_card.Close;
    //ˢ��
       //dm.ADODataSet_cx.Lookup()
       dm.ADODataSet_cx.Active:=false;
      dm.ADODataSet_cx.Active:=true;
      main_form.label_count1.Caption:=inttostr(dm.DataSource_cx.DataSet.RecordCount);
       //dm.ADODataSet_cx.DataSource.DataSet) )
    dm.ADODataSet_cx.Locate('����;��ʱ��',VarArrayOf([cx_empcode.Caption,maskedit_modify_cardtime.EditText]),[]);
     //exec dbo.sp_ADOupdate_cx 04 , '80411     ' , '2011-04-14 12:07:16' , '2011-04-14 12:47:16'
    // showmessage('�ض�λ���');
      //dmclient.ClientDataSet1.Locate('����;�Ա�;����',VarArrayOf([trim(edit2.Text),trim(ComboBox1.Text),trim(edit2.Text)]),[])
        except
       showmessage('�������ʧ�ܣ��������޸�'); 
       end;

       end ;
       if   modify_card_time=strtodatetime('1899-12-30 00:00:00') then
       begin
       ShowMessage('����������ʱ��');
       end;

end;

end;


procedure TForm_modify_card.BitBtn_cardqxClick(Sender: TObject);
begin
Form_modify_card.Close;
end;

end.
