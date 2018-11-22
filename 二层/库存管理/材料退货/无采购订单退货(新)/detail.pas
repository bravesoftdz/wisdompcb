unit detail;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Grids, Menus, Mask,Math, DBCtrls, DBGridEh;

type
  Tfm_detail = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    Label9: TLabel;
    PM1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    Label10: TLabel;
    Label3: TLabel;
    Label8: TLabel;
    Label12: TLabel;
    DBEdit4: TDBEdit;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    DBEdit8: TDBEdit;
    DBEdit9: TDBEdit;
    DBText1: TDBText;
    DBText2: TDBText;
    DBText3: TDBText;
    DBGridEh1: TDBGridEh;
    DBEdit10: TDBEdit;
    DBEdit11: TDBEdit;
    BitBtn1: TBitBtn;
    procedure FormActivate(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure PM1Popup(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;   

var
  fm_detail: Tfm_detail;

implementation
uses damo,common, add_detail;

{$R *.dfm}

procedure Tfm_detail.FormActivate(Sender: TObject);
begin
 dm.AQ96.Close;
 dm.AQ96.Parameters[0].Value:=dm.ADS22rkey.Value;
 dm.AQ96.Open;
end;

procedure Tfm_detail.N1Click(Sender: TObject);
begin
 if (strtoint(vprev)=1) or (strtoint(vprev)=3) then
  messagedlg('�Բ���,��ֻ�б������ֻ��Ȩ��',mtinformation,[mbok],0)
 else begin
  if fm_add.check_stock then exit;   //�̵�״̬������������
  fm_add:=Tfm_add.Create(application);
  fm_add.Edit1.Text := formatfloat('0.000',dm.AQ22quan_on_hand.Value);
  if fm_add.ShowModal=mrok then begin end;
  fm_add.free;
 end;
end;

procedure Tfm_detail.N2Click(Sender: TObject);
begin
 if (strtoint(vprev)=1) or (strtoint(vprev)=3) then
  messagedlg('�Բ���,��ֻ�б������ֻ��Ȩ��',mtinformation,[mbok],0)
 else begin
  if fm_add.check_stock then exit;  //�̵�״̬������������
  with dm.aqtmp do
  begin //ˢ�²��жϵ�ǰ�˻��Ƿ�װ��
   Close;
   SQL.Text:='select status from data0096 where rkey='+dm.AQ96.Fieldbyname('rkey').asstring;
   open;
   if fieldvalues['status']=1 then
   begin
    dm.AQ96.Close;
    dm.AQ96.Open;
    showmessage('����ɾ������ǰ�˻���¼�Ѿ�װ�ˡ�');
    exit;
   end;
  end;

  dm.ADOConnection1.BeginTrans;
  try
   dm.AQ22.Edit;
   dm.AQ22quan_to_be_shipped.Value:=dm.AQ22quan_to_be_shipped.Value-dm.aq96quan_rejd.Value;
   dm.AQ22quan_on_hand.Value:=dm.AQ22quan_on_hand.Value+dm.aq96quan_rejd.Value;
   dm.AQ22.Post;
   with dm.aqtmp do
   begin
    close;
    sql.Text:='update data0017 set QUAN_ON_HAND=QUAN_ON_HAND+:hand '+
              'where rkey='+dm.AQ22inventory_ptr.AsString;
    Parameters[0].Value:=dm.aq96quan_rejd.Value;
    execsql;
   end;

   with dm.aqtmp do
   begin
    close;
    sql.Text:='delete from data0096 where rkey='+dm.aq96.fieldbyname('rkey').AsString;
    ExecSQL;
   end;
  except
   dm.ADOConnection1.RollbackTrans;
   showmessage('ɾ�����ɹ������ܶ��û�ͬʱ�����������ѷ����仯��');
   exit;
  end; //end try
  dm.ADOConnection1.CommitTrans;
  dm.aq96.Close;
  dm.aq96.Open;
 end;
end;

procedure Tfm_detail.PM1Popup(Sender: TObject);
begin
 if dm.AQ22QUAN_ON_HAND.Value<=0 then
  n1.Enabled:=false
 else n1.Enabled:=true;
 if (not dm.AQ96.IsEmpty) and (dm.AQ96v_status.Value='δװ��') then
  n2.Enabled:=true
 else n2.Enabled:=false;
end;

end.

