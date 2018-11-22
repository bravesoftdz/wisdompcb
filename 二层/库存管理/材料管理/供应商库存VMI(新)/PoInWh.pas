unit PoInWh;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Spin, DBCtrls, StdCtrls, Mask, Grids, DBGrids, Buttons, ExtCtrls,
  ComCtrls, DBGridEh, Menus, DB, ADODB, DBCtrlsEh;

type
  TForm_PoIn = class(TForm)
    Panel1: TPanel;
    BitBtn9: TBitBtn;
    BtnSave: TBitBtn;
    Panel2: TPanel;
    Label1: TLabel;
    Label3: TLabel;
    Label7: TLabel;
    Label9: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label16: TLabel;
    LBSale: TLabel;
    Label5: TLabel;
    Label4: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    MaskEdit1: TMaskEdit;
    EdtCurr: TEdit;
    EdtPO: TEdit;
    EdtFac: TEdit;
    EdtVend: TEdit;
    Button1: TButton;
    DataSource1: TDataSource;
    Edit1: TEdit;
    Edit2: TEdit;
    Edit3: TEdit;
    EdtRate: TEdit;
    Edit4: TEdit;
    CheckBox3: TCheckBox;
    Panel3: TPanel;
    StrGrid1: TStringGrid;
    CBloc: TComboBox;
    dtpk1: TDateTimePicker;
    StrGrid2: TStringGrid;
    PopupMenu1: TPopupMenu;
    IQC1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    Button2: TButton;
    procedure BitBtn9Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure BtnSaveClick(Sender: TObject);
    procedure dtpk1Change(Sender: TObject);
    procedure CBLocChange(Sender: TObject);
    procedure StrGrid1TopLeftChanged(Sender: TObject);
    procedure StrGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
      var CanSelect: Boolean);
    procedure StrGrid1KeyPress(Sender: TObject; var Key: Char);
    procedure StrGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
      Rect: TRect; State: TGridDrawState);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure data0134_post(rkey133:integer);
    procedure get_location();
    function find_soerror(number:string):boolean;
    function datecheck():Boolean;
    procedure FormActivate(Sender: TObject);
    procedure StrGrid1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure BtnSaveEnter(Sender: TObject);
    procedure StrGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CBLocKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Edit4Exit(Sender: TObject);
    procedure dtpk1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure CheckBox3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure IQC1Click(Sender: TObject);
  private
    function find_quan_error(rkey133:integer): boolean;
    function recevied_over(rkey70:Integer):Boolean;
    function Iqc_avlflag(var row:integer):boolean;
    function location_over():boolean;
  public
   aded_flag:byte;
   po_ptr,supp_ptr,warehouse_ptr,curr_ptr:integer;
   exch_rate:double;
   po_type:string;
  end;

var
  Form_PoIn: TForm_PoIn;
  function Power(x, y : extended) : extended;
implementation

uses PoSearch,common, Main, form_main_in,demo,Pick_Item_Single,ConstVar;

{$R *.dfm}


procedure TForm_PoIn.BitBtn9Click(Sender: TObject);
begin
close;
end;

procedure TForm_PoIn.Button1Click(Sender: TObject);
var i,iCount:Integer;
    tmpAdo:TADOQuery;
begin
// for i:=1 to strgrid1.RowCount-1 do
//  if strtofloat(strgrid1.Cells[4,i])>0 then
//  strgrid1.Cells[7,i]:=
//  floattostr((strtofloat(strgrid1.Cells[3,i])-strtofloat(strgrid1.Cells[5,i]))*
//  strtofloat(strgrid1.Cells[4,i]))
//  else
//  strgrid1.Cells[7,i]:=
//  floattostr(strtofloat(strgrid1.Cells[3,i])-strtofloat(strgrid1.Cells[5,i]));

//2017-4-21tang�޸Ľ������������ֶ��ģ��ؼ����ֻ����IQC���ͨ������
  tmpAdo:=TADOQuery.Create(Application);
  try
    tmpAdo.Connection:=dm.ADOConnection1;
    if (aded_flag=1) then
    begin
  //ֻҪ�Ǽ����ϣ����ձ����391IQC�ж�ȡ��Ϣ----
      iCount:=0;
      for I := 1 to StrGrid1.RowCount-1 do
      begin
        if (StrGrid1.Cells[12,i]='Y') and (StrToFloat(StrGrid1.Cells[3,i])>StrToFloat(StrGrid1.Cells[5,i])) then
        begin
          tmpAdo.Close;
          tmpAdo.SQL.Text:='select * from data0391 where Rkey71='+StrGrid2.Cells[0,i]+' and Rkey17='+StrGrid2.Cells[1,i]+' and stock_over=0 and (status=1 or status=2) order by auth_date';
          tmpAdo.Open;
          if (not tmpAdo.IsEmpty) then  //��Ӧһ��IQC�������391
          begin
            iCount:=iCount+1;
            StrGrid1.Cells[7,i]:=tmpAdo.FieldByName('rece_qty').AsString;//�������� 
            StrGrid1.Cells[13,i]:=tmpAdo.FieldByName('manufacture_TDATE').AsString;
            StrGrid1.Cells[9,i]:=tmpAdo.FieldByName('barch_no').AsString;
            StrGrid1.Cells[11,i]:=tmpAdo.FieldByName('supplier_model').AsString;
            StrGrid1.Cells[17,i]:=IntToStr(tmpAdo.RecordCount);
            StrGrid1.Cells[16,i]:=tmpAdo.FieldByName('Rkey').AsString;
          end;
          if (iCount=0) then
          begin
            ShowMessage('��ǰICQû��ͨ������');
          end;
        end else if ((StrGrid1.Cells[12,i]='N') or (Trim(StrGrid1.Cells[12,i])='')) then
        begin
          StrGrid1.Cells[7,i]:=floattostr(strtofloat(strgrid1.Cells[3,i])-strtofloat(strgrid1.Cells[5,i]));
        end;
      end;
    end else
    if (aded_flag=2) then
    begin
      for I := 1 to StrGrid1.RowCount-1 do
      begin
        if ((StrGrid1.Cells[12,i]='N') or (Trim(StrGrid1.Cells[12,i])='')) then
        StrGrid1.Cells[7,i]:=floattostr(strtofloat(strgrid1.Cells[3,i])-strtofloat(strgrid1.Cells[5,i]));
      end;
    end;
  finally
    tmpAdo.connection:=nil;
    tmpAdo.close;
    tmpAdo.free;
  end;
//2017-4-21end tang-----
end;

procedure TForm_PoIn.BtnSaveClick(Sender: TObject);
{var
  i,iRkey14:integer;
  isInf:boolean;
  smsstring1,smsstring2:string;}
begin
if aded_flag=1 then //����
begin
  maskedit1.SetFocus;
  if trim(MaskEdit1.Text)='' then
  begin
    showmessage('���Ų���Ϊ��...');
    exit;
  end;
  if trim(Edit2.Text)='' then
  begin
    showmessage('�ͻ����Ų���Ϊ��...');
    exit;
  end;
  if self.find_soerror(trim(maskedit1.Text)) then
  if messagedlg('��ֱ���ظ�,�����ж�̨�����ͬʱ����,�Ƿ��Զ����±��?',
     mtConfirmation,[mbYes,mbNo],0)=mrYes  then
   begin
    dm.ado04.Close;
    dm.ado04.Parameters[0].Value:='data0133';
    dm.ado04.Open;
    maskedit1.Text:=dm.ado04SEED_VALUE.Value;
   end
  else
   begin
    maskedit1.SetFocus;
    exit;
   end;
  dm.ADOConnection1.BeginTrans;
  try
  dm.ADO133.Close;
  dm.ADO133.Parameters[0].Value:=null;
  dm.ADO133.Open;

  dm.ADO133.Append;
  dm.ADO133GRN_NUMBER.Value:=maskedit1.Text;                //��ⵥ��
  dm.ADO133DELIVER_NUMBER.Value:=edit2.Text;            //�ͻ�����
  dm.ADO133ship_BY.Value:=edit1.Text;                   //�ͻ���Ա

  dm.ADO133ship_DATE.Value:=
     strtodatetime(edit4.Text); //�ͻ�����

  dm.ADO133CREATE_BY.Value:=form_main.rkey05;           //�ջ�Ա��
  dm.ADO133CREATE_DATE.Value:=form_main.sys_longdate;     //�ջ�����
  dm.ADO133warehouse_ptr.Value:=self.warehouse_ptr;   //����
  dm.ADO133SUPP_PTR.Value:=self.supp_ptr;             //��Ӧ��
  dm.ADO133PO_PTR.Value:=self.po_ptr;                 //�ɹ�����
  dm.ADO133REF_NUMBER.Value:=edit3.Text;              //��ע
  dm.ADO133CURRENCY_PTR.Value:=self.curr_ptr;         //����
  dm.ADO133EXCH_RATE.AsString:=EdtRate.Text;           //����
  dm.ADO133TTYPE.Value:=1;                   //����
  dm.ADO133.Post;
 dm.update04('data0133');            //���¿�����
 self.data0134_post(dm.ADO133RKEY.Value);
// with dm.ADOQuery1 do
//     begin
//       close;
//       sql.Text:=
//        'SELECT  rkey '+
//        'FROM  Data0071 '+
//        'WHERE (QUAN_IN_INSP > 0) AND (QUAN_RECD > QUAN_IN_INSP) '+
//        'and (PO_PTR='+dm.ADO133PO_PTR.AsString+')';
//       open;
//      if not IsEmpty then
//      begin
//       dm.ADOConnection1.RollbackTrans;
//       messagedlg('��������ʧ��,����������˼��ͨ����!',mterror,[mbcancel],0);
//       maskedit1.SetFocus;
//       Exit;
//      end;
//     end;

    if self.recevied_over(dm.ADO133PO_PTR.Value) then
       with dm.adoquery1 do
        begin
         close;
         sql.clear;
         sql.Add('update data0070');
         sql.Add('set status=6');
         sql.Add('where rkey='+dm.ADO133PO_PTR.AsString);
         execsql;
        end;
 dm.ADOConnection1.CommitTrans;
 dm.ADS133.Close;
 dm.ADS133.Open;
 self.ModalResult:=mrok;
  except
   on E: Exception do
    begin
     dm.ADOConnection1.RollbackTrans;
     messagedlg(E.Message,mterror,[mbcancel],0);
     maskedit1.SetFocus;
    end;
  end

 end
else         //�༭
 begin
  if find_quan_error(dm.ADS133RKEY.Value) then
  begin
   showmsg('����¼�����仯,�����ٱ༭!',1);
   exit;
  end;

  dm.ADOConnection1.BeginTrans;
  try
   dm.ADO133.Close;
   dm.ADO133.Parameters[0].Value:=dm.ADS133RKEY.Value;
   dm.ADO133.Open;
   dm.ADO133.Edit;
   dm.ADO133GRN_NUMBER.Value:=maskedit1.Text;
   dm.ADO133DELIVER_NUMBER.Value:=edit2.Text;
   dm.ADO133ship_DATE.Value:=strtodatetime(edit4.text);
   dm.ADO133ship_BY.Value:=edit1.Text;
   dm.ADO133REF_NUMBER.Value:=edit3.Text;
   dm.ADO133.Post;
    with dm.ADOQuery1 do         //����71���ջ�����,����ջ�����
    begin
     close;
     sql.Clear;
     sql.Add('update data0071');
     sql.Add('set QUAN_RECD=QUAN_RECD-data0134.quantity/data0071.CONVERSION_FACTOR');
     sql.Add('from data0134 inner join data0071');
     sql.Add('on data0134.SOURCE_PTR=data0071.rkey');
     sql.Add('where data0134.GRN_PTR='+dm.ADO133rkey.AsString);
     ExecSQL;
    end;

    //20170428tang����391
    dm.ADOQuery1.Close;
    dm.ADOQuery1.SQL.Clear;
    dm.ADOQuery1.SQL.Text:='update data0391 set data0391.stock_over=0 '
    +'from data0134 inner join data0391 on data0134.RKEY391=data0391.rkey where data0134.GRN_PTR='+dm.ADO133rkey.AsString;
    dm.ADOQuery1.ExecSQL;

    with dm.ADOQuery1 do
    begin
     close;
     sql.Clear;
     sql.Add('delete from data0134');
     sql.Add('where data0134.GRN_PTR='+dm.ADO133rkey.AsString);
     ExecSQL;
    end;
    self.data0134_post(dm.ADO133RKEY.Value);

    with dm.ADOQuery1 do
     begin
       close;
       sql.Text:=
        'SELECT  rkey '+
        'FROM  Data0071 '+
        'WHERE (QUAN_IN_INSP > 0) AND (QUAN_RECD > QUAN_IN_INSP) '+
        'and (PO_PTR='+dm.ADO133PO_PTR.AsString+')';
       open;
      if not IsEmpty then
      begin
       dm.ADOConnection1.RollbackTrans;
       messagedlg('�༭����ʧ��,����������˼��ͨ����!',mterror,[mbcancel],0);
       maskedit1.SetFocus;
       Exit;
      end;
     end;
   if self.recevied_over(dm.ADO133PO_PTR.Value) then
    with dm.adoquery1 do
     begin
      close;
      sql.clear;
      sql.Add('update data0070');
      sql.Add('set status=6');
      sql.Add('where rkey='+dm.ADO133PO_PTR.AsString);
      execsql;
     end
   else
    with dm.adoquery1 do
     begin
      close;
      sql.clear;
      sql.Add('update data0070');
      sql.Add('set status=5');
      sql.Add('where rkey='+dm.ADO133PO_PTR.AsString);
      execsql;
     end;
     
  dm.ADOConnection1.CommitTrans;
  dm.ADS133.Close;
  dm.ADS133.Open;
  self.ModalResult:=mrok;
  except
   on E: Exception do
    begin
     dm.ADOConnection1.RollbackTrans;
     messagedlg(E.Message,mterror,[mbcancel],0);
     maskedit1.SetFocus;
    end;
  end; //except_end
 end;//�༭_enc
end;

procedure TForm_PoIn.dtpk1Change(Sender: TObject);
begin
strgrid1.Cells[13,strgrid1.Row]:=datetostr(dtpk1.Date);
end;


procedure TForm_PoIn.CBLocChange(Sender: TObject);
begin
 dm.aq16.MoveBy(CBLoc.ItemIndex+1-dm.aq16.RecNo);
 strgrid1.Cells[8,strgrid1.Row]:=CBLoc.Text;
 strgrid2.Cells[5,strgrid1.Row]:=dm.aq16rkey.AsString;
end;

procedure TForm_PoIn.StrGrid1TopLeftChanged(Sender: TObject);
begin
 CBLoc.Visible:=false;
end;

procedure TForm_PoIn.StrGrid1SelectCell(Sender: TObject; ACol, ARow: Integer;
  var CanSelect: Boolean);
begin
  if self.aded_flag=4 then
   strgrid1.Options:=strgrid1.Options-[goEditing]
  else
  begin
    if ((aded_flag =1) or (aded_flag =2)) and (strgrid1.Cells[12,ARow]='Y') then
    begin
      if (acol<=8) or (ACol=12) or (ACol>=14) then
        strgrid1.Options:=strgrid1.Options-[goEditing]
      else
        strgrid1.Options:=strgrid1.Options+[goEditing];
    end else
    if ((aded_flag =1) or (aded_flag =2)) and (strgrid1.Cells[12,ARow]='N') then
    begin
      if (acol<=6) or (ACol=12) or (ACol>=14) then
        strgrid1.Options:=strgrid1.Options-[goEditing]
      else
        strgrid1.Options:=strgrid1.Options+[goEditing];
    end else
    begin
      if (acol<7) or (ACol=12) or (ACol>=14) then
        strgrid1.Options:=strgrid1.Options-[goEditing]
      else
        strgrid1.Options:=strgrid1.Options+[goEditing];
    end;
  end;
  // if (acol<7) or (ACol=12) or (ACol=14)  then
  //  strgrid1.Options:=strgrid1.Options-[goEditing]
  // else
  //  strgrid1.Options:=strgrid1.Options+[goEditing];
end;

procedure TForm_PoIn.StrGrid1KeyPress(Sender: TObject; var Key: Char);
begin

 if strgrid1.Col=7 then
 if not (key in ['0'..'9','.',#8,#13]) then  //�ж��Ƿ���������
  abort
 else
  if key = chr(46) then      //�ж��Ƿ��ظ�����С����'.'
   if pos('.',strgrid1.Cells[7,strgrid1.Row])>0  then abort;

if (key <> chr(9)) then    //û�а�tab��
 begin
  if (strgrid1.Col=8) and (CBLoc.Enabled) then
   begin
    CBLoc.SetFocus;
    SendMessage(CBLoc.Handle,WM_Char,word(Key),0);
   end;
 end;

end;


procedure TForm_PoIn.StrGrid1DrawCell(Sender: TObject; ACol, ARow: Integer;
  Rect: TRect; State: TGridDrawState);
begin
if (gdSelected  in State) then
 begin
  if (ACol = 8 ) then
   begin
    CBLoc.Left := Rect.Left;
    CBLoc.Top := Rect.Top;
    CBLoc.Width := Rect.Right - Rect.Left+3;
    CBLoc.Height := Rect.Bottom - Rect.Top;
    CBLoc.Visible := True;
    if strgrid1.Cells[acol,arow]<>'' then
     CBLoc.ItemIndex:=CBLoc.Items.IndexOf(strgrid1.Cells[acol,arow])
    else
     CBLoc.ItemIndex:=-1;
   end
  else
    CBLoc.Visible :=false;

  if (ACol = 13 ) then
   begin
    dtpk1.Left := Rect.Left;
    dtpk1.Top := Rect.Top;
    dtpk1.Width := Rect.Right - Rect.Left+3;
    dtpk1.Height := Rect.Bottom - Rect.Top;
    dtpk1.Visible := True;
    if trim(strgrid1.Cells[acol,arow])<>'' then
    dtpk1.Date:=strtodate(strgrid1.Cells[acol,arow]);
   end
  else
    dtpk1.Visible :=false;

 end;
end;

procedure TForm_PoIn.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  if self.aded_flag in [1,2] then
  CanClose:=(modalresult=mrok) or (Application.MessageBox('ȷ�ϲ������˳���?', PChar('��ʾ'),MB_YESNO)=6);
end;

function tform_poin.find_soerror(number:string):boolean;
begin
 result := false;
 with dm.ADOQuery1 do
  begin
   close;
   sql.Clear;
   sql.Add('select rkey from data0133');
   sql.Add('where GRN_NUMBER='''+number+'''');
   open;
   if not IsEmpty then result := true;
  end;
end;

function TForm_PoIn.find_quan_error(rkey133: integer): boolean;
begin
result:=false;
with dm.adoquery1 do
begin
  close;
  sql.Text:='select rkey from data0134'+#13+
            'where quantity<>quan_on_hand'+#13+
            'and grn_ptr='+inttostr(rkey133);
  open;
  if not IsEmpty then result:=true;
end;
end;

procedure TForm_PoIn.data0134_post(rkey133:integer);
VAR
i:integer;
BEGIN
  dm.ADO134.Close;
  dm.ADO134.Parameters[0].Value:=rkey133;
  dm.ADO134.Open;
  for i:=1 to strgrid1.RowCount-1 do
   if strtofloat(strgrid1.Cells[7,i])>0 then
    begin
     dm.ADO134.Append;
     dm.ADO134GRN_PTR.Value:=rkey133;     //133.rkey
     dm.ADO134SOURCE_PTR.Value:=strtoint(strgrid2.Cells[0,i]);  //71.rkey
     dm.ADO134INVENTORY_PTR.Value:=strtoint(strgrid2.Cells[1,i]);   //17.rkey
     dm.ADO134LOCATION_PTR.Value:=strtoint(strgrid2.Cells[5,i]);    //16.rkey
     dm.ADO134UNIT_PTR.Value:=strtoint(strgrid2.Cells[2,i]);//�����λ
     dm.ADO134tax_PRICE.AsString:=strgrid2.Cells[3,i];           //��˰�۸�
     dm.ADO134TAX_2.AsString:=strgrid2.Cells[4,i];               //˰��
     dm.ADO134PRICE.Value:=dm.ADO134tax_price.Value/(1+dm.ADO134TAX_2.Value*0.01);//����˰��
     dm.ADO134QUANTITY.AsString:=strgrid1.Cells[7,i];       //��������
     dm.ADO134QUAN_ON_HAND.Value:=dm.ADO134QUANTITY.Value;   //��ǰ�������
     dm.ADO134SUPPLIER3.Value:=StrGrid1.Cells[9,i]; //ԭ������
     dm.ADO134SUPPLIER2.Value:=strgrid1.Cells[10,i];         //��ϸλ��
     dm.ADO134rohs.Value:=strgrid1.Cells[14,i];            //������ʶ
     dm.ADO134BARCODE_ID.Value:=strgrid1.Cells[11,i];      //��ע(�ر�Ҫ��)
     dm.ADO134MANU_DATE.Value:=strtodate(strgrid1.Cells[13,i]);//��������
      //ShowMessage(strgrid1.Cells[18,i]);
     if strgrid1.Cells[18,i]<>'' then
     dm.ADO134ORIG_ABBRNAME.value:=strgrid1.Cells[18,i]; //tao 20180613

     //dm.ADO134STOCK_BASE.Value:=StrToFloat(StrGrid2.Cells[7,i]);//��׼��λ����
     //2017-4-21tang��IQC���ͨ�����������޸��ջ�����
     if (Trim(StrGrid1.Cells[16,i])<>'') then
     dm.ADO134rkey391.Value:=StrToInt(StrGrid1.Cells[16,i]);//391Rkey
     //end 20170421tang
     

     with dm.tmpt do
     begin
      close;
      sql.Text:='select qte_price2 from data0028 where inventory_ptr='+#13+
                 strgrid2.Cells[1,i]+'and supplier_ptr='+inttostr(self.supp_ptr);
      Open;
     end;
     if dm.tmpt.RecordCount>0 then//��Ӧ�̼۸񽻸��ų̱��Ʒ��Ч�������������ڲ�Ʒ��Ч�ڵļ���
     begin
       if (dm.tmpt.FieldByName('qte_price2').AsInteger<>0) then
       dm.ADO134EXPIRE_DATE.Value:=strtodate(strgrid1.Cells[13,i])+dm.tmpt.FieldValues['qte_price2'];
     end
     else //�����Ʒ��Ч������Ϊ����ȡ���ϱ������ı����������ֶ�
     begin
      with dm.tmpt do
      begin
      close;
      sql.Text:='select shelf_life from data0017 where rkey='+StrGrid2.Cells[1,i];
      open;
      end;
       if (dm.tmpt.FieldByName('shelf_life').AsInteger<>0) then
        dm.ADO134EXPIRE_DATE.Value:=strtodate(strgrid1.Cells[13,i])+dm.tmpt.FieldValues['shelf_life'];
      end;
      dm.ADO134.Post;

      //20170428tang����391״̬
     if (Trim(StrGrid1.Cells[16,i])<>'') then 
     begin
      dm.ADOQuery1.Close;
      dm.ADOQuery1.SQL.Clear;
      dm.ADOQuery1.SQL.Text:='update data0391 set stock_over=1 where Rkey='+StrGrid1.Cells[16,i];
      dm.ADOQuery1.ExecSQL;
     end;
    end;
    with dm.ADOQuery1 do         //����71���ջ�����,����ջ�����
    begin
     close;
     sql.Clear;
     sql.Add('update data0071');
     sql.Add('set QUAN_RECD=QUAN_RECD+data0134.quantity/data0071.CONVERSION_FACTOR,');
     sql.Add('recd_DATE='''+edit4.Text+'''');
     sql.Add('from data0134 inner join data0071');
     sql.Add('on data0134.SOURCE_PTR=data0071.rkey');
     sql.Add('where data0134.GRN_PTR='+inttostr(rkey133));
     ExecSQL;
    end;
END;

function TForm_PoIn.recevied_over(rkey70: Integer): Boolean;
begin
 with dm.ADOQuery1 do
 begin
   close;
   sql.Text:=
    'SELECT rkey '+
    'FROM  dbo.Data0071 '+
    'WHERE (QUAN_RECD < QUAN_ORD) '+
    'and (PO_PTR='+inttostr(rkey70)+')';
   open;
   if IsEmpty then   //û�д�����¼�����ж������������
    Result:=True
   else
    result:=False;
 end;
end;
function TForm_PoIn.Iqc_avlflag(var row:integer): boolean;
var
 i:integer;
begin
//result := false;
//for i:=1 to strgrid1.RowCount-1 do
// if (strtofloat(strgrid1.Cells[7,i])>0) and  //��������������
//    (strgrid1.Cells[12,i]<>'N') then         //����û��ͨ��IQC���
//  begin                                      //����N�����Ѽ�飬���߲���Ҫ���
//   row:=i;
//   result := true;
//   break;
//  end;
 result := false;
for i:=1 to strgrid1.RowCount-1 do
begin
//  ShowMessage('1:'+strgrid1.Cells[7,i]+'/2:'+strgrid1.Cells[4,i]+'+3:'+strgrid1.Cells[5,i]+'>4:+'+strgrid1.Cells[15,i]+'');
 if (ExRoundTo(StrToCurr(strgrid1.Cells[7,i])/StrToCurr(strgrid1.Cells[4,i])+        //���ν�������
    StrToCurr(strgrid1.Cells[5,i]),4)>        //�ѽ�������
    ExRoundTo(StrToCurr(strgrid1.Cells[15,i]),4)) and  //���ν��������������������������ͨ������
    (strgrid1.Cells[12,i]='Y') and (StrToCurr(strgrid1.Cells[7,i])>0) then         //�ɹ���ϸ��ҪIQC���
  begin
   row:=i;
   result := true;
   break;
  end;
end;
end;
procedure TForm_PoIn.get_location();
begin
  dm.aq16.Close;
  if checkbox3.Checked then
  dm.aq16.SQL.Text:='select rkey,LOCATION from data0016 '+
    'where LOCATION_TYPE = 0 and '+
    'whouse_ptr='+inttostr(self.warehouse_ptr)+
    ' order by rkey'
  else
  dm.aq16.SQL.Text:='select rkey,LOCATION from data0016 '+
    'where LOCATION_TYPE=0 order by rkey';
  dm.aq16.Open;
  cbloc.Items.Clear;
  while not dm.aq16.Eof do
   begin
    cbloc.Items.Add(dm.aq16LOCATION.Value);
    dm.aq16.Next;
   end;
  dm.aq16.First;
end;

procedure TForm_PoIn.FormActivate(Sender: TObject);
var
 i:word;
begin
if aded_flag=1 then //����
 begin
  edit4.Text:=formatdatetime('yyyy-mm-dd HH:mm:ss',form_main.sys_longdate);
  dm.ado04.Close;
  dm.ado04.Parameters[0].Value:='data0133';
  dm.ado04.Open;
  if dm.ado04SEED_FLAG.Value<>1 then
   maskedit1.Text:=dm.ado04SEED_VALUE.Value;
  if dm.ado04SEED_FLAG.Value=4 then
   maskedit1.ReadOnly:=true;
  dm.ado04.Close;
  self.get_location;
  with dm.ADOQuery1 do
   begin
    close;
    sql.Clear;
    sql.Add('select NOTE_PAD_LINE_1 from data0011');
    sql.Add('where SOURCE_TYPE=70 and');
    sql.Add('FILE_POINTER='+inttostr(self.po_ptr));
    open;
    if not isempty then edit3.Text:=fieldvalues['NOTE_PAD_LINE_1'];
    close;
   end;
 end
else     //�༭���
 begin
   dm.ado04.Close;
   dm.ado04.Parameters[0].Value:='data0133';
   dm.ado04.Open;
   if dm.ado04SEED_FLAG.Value=4 then
   maskedit1.ReadOnly:=true;

  maskedit1.Text:=dm.ADS133GRN_NUMBER.Value;
  edit2.Text:=dm.ADS133DELIVER_NUMBER.Value;
  EdtPO.Text:=dm.ADS133po_number.Value;
  edit1.Text:=dm.ADS133ship_BY.Value;
  edit4.Text:=
  formatdatetime('yyyy-mm-dd HH:mm:ss',dm.ADS133ship_DATE.Value);

  EdtVend.Text:=dm.ADS133code.Value;
  label8.Caption:=dm.ADS133supplier_name.Value;
  EdtFac.Text:=dm.ADS133warehouse_code.Value;
  label6.Caption:=dm.ADS133warehouse_name.Value;
  EdtCurr.Text:=dm.ADS133curr_code.Value;
  label4.Caption:=dm.ADS133curr_name.Value;
  EdtRate.Text:=dm.ADS133exch_rate.AsString;
  curr_ptr:=dm.ADS133currency_ptr.Value;
  warehouse_ptr := dm.ADS133warehouse_ptr.Value; //����15.rkey
  po_ptr := dm.ADS133PO_PTR.Value;                  //�ɹ�70.rkey
  supp_ptr := dm.ADS133SUPP_PTR.value;    //��Ӧ��23.rkey
  edit3.Text:=dm.ADS133REF_NUMBER.Value;

  self.get_location;   //�õ����λ��
  dm.Aq134.Open;
  strgrid1.RowCount:=dm.Aq134.RecordCount+1;
  strgrid2.RowCount:=dm.Aq134.RecordCount+1;
  for i:=1 to dm.Aq134.RecordCount do
   begin
    strgrid1.Cells[0,i] := dm.Aq134INV_PART_NUMBER.Value;
    strgrid1.Cells[1,i] := dm.Aq134INV_NAME.Value;
    strgrid1.Cells[2,i] := dm.Aq134INV_DESCRIPTION.Value;
    strgrid1.Cells[3,i] := dm.Aq134QUAN_ORD.AsString;
    strgrid1.Cells[4,i] := dm.Aq134CONVERSION_FACTOR.AsString;

    strgrid1.Cells[6,i] := dm.Aq134pr_unitname.Value;
    strgrid1.Cells[5,i] := floattostr(
                           dm.Aq134QUAN_RECD.Value-
                           dm.Aq134QUANTITY.Value/dm.Aq134CONVERSION_FACTOR.Value);

    strgrid2.Cells[2,i] := dm.Aq134WO_PTR.AsString; //�����λ
    strgrid2.Cells[3,i] :=formatfloat('0.0000',
                           dm.Aq134tax_PRICE.value/dm.Aq134CONVERSION_FACTOR.Value
                                          );

    strgrid1.Cells[7,i] := dm.Aq134QUANTITY.AsString;  //��ǰ����
    if strgrid1.Cells[7,i]='' then
     strgrid1.Cells[7,i] :='0';

    strgrid1.Cells[8,i] := dm.Aq134LOCATION.Value;    //λ������
    StrGrid1.Cells[9,i] := dm.Aq134SUPPLIER3.Value;  //ԭ������
    strgrid1.Cells[10,i] := dm.Aq134SUPPLIER2.Value;   //��ϸλ��
    strgrid1.Cells[14,i] := dm.Aq134rohs.Value;       //������ʶ
    strgrid1.Cells[11,i] := dm.Aq134BARCODE_ID.Value; //�ر�Ҫ��
    strgrid1.Cells[12,i] := dm.Aq134avl_flag.Value;   //�Ƿ���Ҫ���
    strgrid1.Cells[13,i] := dm.Aq134manu_date.AsString;//��������
    StrGrid1.Cells[15,i] := dm.Aq134QUAN_IN_INSP.AsString;//�Ѽ���ͨ������
    //2017-04-24tang���391�ֶ�
    StrGrid1.Cells[16,i] := dm.Aq134RKEY391.AsString;//Rkey391

     StrGrid1.Cells[18,i] := dm.Aq134ORIG_ABBRNAME.AsString; //to0613
     
    strgrid2.Cells[0,i] := dm.Aq134RKEY.AsString;     //71
    strgrid2.Cells[1,i] := dm.Aq134INVT_PTR.AsString; //17

    strgrid2.Cells[3,i] := dm.Aq134tax_PRICE.AsString;   //�۸�
    strgrid2.Cells[4,i] := dm.Aq134TAX_2.AsString;       //˰��%
    strgrid2.Cells[5,i] := dm.Aq134LOCATION_PTR.AsString;//λ��ָ��
    strgrid2.Cells[6,i] := dm.Aq134SHELF_LIFE.AsString;  //��Ч��
    strgrid2.Cells[7,i] := dm.Aq134STOCK_BASE.AsString;  //��λ����KG

    dm.Aq134.Next;
   end;
   dm.Aq134.Close;
   strgrid1.SetFocus;
   strgrid1.Col:=7;
   if maskedit1.Enabled then maskedit1.SetFocus;
 end;
end;

function TForm_PoIn.location_over: boolean;
var
 i:word;
begin
 location_over:=false;
if self.aded_flag=1 then
begin
 for i:=1 to strgrid1.RowCount-1 do
  if (strgrid1.Cells[8,i]='') and (strtofloat(strgrid1.Cells[7,i])>0) then
  begin                    //�����������λ��
   location_over:=true;
   break;
  end;

 for i:=1 to strgrid1.RowCount-1 do
  if (strtofloat(strgrid1.Cells[7,i])>0) then
   begin                   //������һ���������
    break;
   end
  else
   if (i=strgrid1.RowCount-1) then
    location_over:=true;
end;
end;


procedure TForm_PoIn.StrGrid1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if strgrid1.Col=7 then
 begin
  if strgrid1.Cells[7,strgrid1.Row]='' then strgrid1.Cells[7,strgrid1.Row]:='0';
  if form_mainin.stock_flag='N' then   //�����������ܴ��ڶ�������
  if strtofloat(strgrid1.Cells[4,strgrid1.Row])>0 then//ת���ʴ���0
   begin
    if strtofloat(strgrid1.Cells[7,strgrid1.Row])>
      (strtofloat(strgrid1.Cells[3,strgrid1.Row])-strtofloat(strgrid1.Cells[5,strgrid1.Row]))*
       strtofloat(strgrid1.Cells[4,strgrid1.Row])  then
     strgrid1.Cells[7,strgrid1.Row]:=floattostr(
                                     (strtofloat(strgrid1.Cells[3,strgrid1.Row])-
                                      strtofloat(strgrid1.Cells[5,strgrid1.Row]))*
                                      strtofloat(strgrid1.Cells[4,strgrid1.Row])
                                                );
   end
  else
   begin
    if strtofloat(strgrid1.Cells[7,strgrid1.Row])>
     (strtofloat(strgrid1.Cells[3,strgrid1.Row])-strtofloat(strgrid1.Cells[5,strgrid1.Row])) then
     strgrid1.Cells[7,strgrid1.Row]:=floattostr(
                                      strtofloat(strgrid1.Cells[3,strgrid1.Row])-
                                      strtofloat(strgrid1.Cells[5,strgrid1.Row])
                                                );
   end;
 end;
end;

procedure TForm_PoIn.BtnSaveEnter(Sender: TObject);
var
 row:integer;
begin
if trim(maskedit1.Text)='' then
 begin
  showmessage('��ⵥ�Ų�����Ϊ��!');
  maskedit1.SetFocus;
  exit;
 end;
if trim(edit2.Text)='' then
begin
showmessage('�ͻ����Ų���Ϊ��!');
edit2.SetFocus;
exit;
end;
if not dm.Ado04.Active then
begin
dm.ado04.Parameters[0].Value:='data0133';
dm.ado04.Open;
end;
if (dm.ado04SEED_FLAG.Value<>1) and
  (not (maskedit1.Text[length(trim(maskedit1.Text))] in ['0'..'9'])) then
 begin
  messagedlg('��������һλ������һ������!',mtinformation,[mbok],0);
  maskedit1.SetFocus;
  exit;
 end;

if self.location_over then
 begin
  showmsg('������Ҫһ����ּ�¼���������λ��!',1);
  strgrid1.SetFocus;
  strgrid1.Col:=7;
  exit;
 end;

 if self.datecheck then
 begin
  showmsg('������һ����ּ�¼�������ڴ��ڵ�ǰ����,������Ҫ��,���޸������������!',1);
  strgrid1.SetFocus;
  strgrid1.Col:=13;
  exit;
 end;
// ShowMessage(IntToStr(row));
//if (strgrid1.Visible) and (self.Iqc_avlflag(row)) then
// begin
//  showmsg('����û��ͨ��IQC��鲻�����!',1);
//  strgrid1.SetFocus;
//  strgrid1.Row:=row;
//  exit;
// end;
{if strtodatetime(edit4.Text) < dm.find_maxdate then
 begin
  messagedlg('�ͻ����ڱ�����ڲ���������������!',mterror,[mbok],0);
  edit11.SetFocus;
  exit;
 end;}
end;

procedure TForm_PoIn.StrGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
 if (key=112) and (CBLoc.Visible) then
  begin
   if CBLoc.Enabled then
   begin
   CBLoc.SetFocus;
   CBLoc.DroppedDown:=true;
   end;
  end;
end;

procedure TForm_PoIn.CBLocKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key=112 then CBLoc.DroppedDown:=true;    //f2
if key=13 then strgrid1.SetFocus;
end;

function Power(x, y : extended) : extended;
begin
 result := exp(y*ln(x));
end;

procedure TForm_PoIn.Edit4Exit(Sender: TObject);
begin
 try
  strtodatetime(edit4.Text);
 except
  messagedlg('�ͻ����ڸ�ʽ����!',mterror,[mbok],0);
  edit4.SetFocus;
 end;
end;

procedure TForm_PoIn.dtpk1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
if key=13 then strgrid1.SetFocus;
end;

procedure TForm_PoIn.CheckBox3Click(Sender: TObject);
begin
self.get_location;
end;

procedure TForm_PoIn.FormShow(Sender: TObject);
begin
 strgrid1.Cells[0,0] := '���ϱ���';
 strgrid1.Cells[1,0] := '��������';
 strgrid1.Cells[2,0] := '���Ϲ��';
 strgrid1.Cells[3,0] := '��������';
 strgrid1.Cells[4,0] := 'ת����';
 strgrid1.Cells[5,0] := '�ѽ���';
 strgrid1.Cells[6,0] := '�����λ';
 strgrid1.Cells[7,0] := '��ǰ����';
 strgrid1.Cells[8,0] := '�ֿ�λ��';
 strgrid1.Cells[9,0] := '��������';
 strgrid1.Cells[10,0] := '��ϸλ��';
 strgrid1.Cells[11,0] := '�ر�Ҫ��';
 strgrid1.Cells[12,0] := 'IF���';
 strgrid1.Cells[13,0] := '��������';
 strgrid1.Cells[14,0] := '������ʶ';
 StrGrid1.Cells[15,0] :='IQC�Ѽ�������';
 StrGrid1.Cells[16,0] :='Rkey391';
 StrGrid1.Cells[17,0] :='Recount';
 StrGrid1.Cells[18,0] :='Ʒ�ƹ�Ӧ��';       //tao 0613
 strgrid1.ColWidths[15] := -1;
 strgrid1.ColWidths[16] := -1;
 strgrid1.ColWidths[17] := -1;

 strgrid2.Cells[0,0] := '71rkey/72rkey';
 strgrid2.Cells[1,0] := '17rkey';
 strgrid2.Cells[2,0] := '�����λ02';
 strgrid2.Cells[3,0] := '��˰��';
 strgrid2.Cells[4,0] := '˰��';
 strgrid2.Cells[5,0] := '16rkey';
 strgrid2.Cells[6,0] := '������Ч��';
 strgrid2.Cells[7,0] := '���ϵ���KG';
end;

function TForm_PoIn.datecheck:Boolean;
var
  i:Word;
begin
 datecheck:=False;
 for i:=1 to StrGrid1.RowCount-1 do
  if  (strtofloat(strgrid1.Cells[7,i])>0) and (StrToDate(strgrid1.Cells[13,i])>common.getsystem_date(dm.tmp,1))  then
  begin                    //�������ڲ��ܴ��ڵ�ǰ����
   datecheck:=true;
   break;
  end;
end;


procedure TForm_PoIn.N2Click(Sender: TObject);
begin
  StrGrid1.Cells[7,StrGrid1.Row]:='0';
  StrGrid1.Cells[13,StrGrid1.Row]:='';
  StrGrid1.Cells[9,StrGrid1.Row]:='';
  StrGrid1.Cells[16,StrGrid1.Row]:='';
  StrGrid1.Cells[11,StrGrid1.Row]:='';
end;

procedure TForm_PoIn.Button2Click(Sender: TObject);
var i,iCount:Integer;
    tmpAdo:TADOQuery;
begin
  iCount:=0;
  tmpAdo:=TADOQuery.Create(Application);
  try
    tmpAdo.Connection:=dm.ADOConnection1;
//ֻҪ�Ǽ����ϣ����ձ����391IQC�ж�ȡ��Ϣ----
    for I := 1 to StrGrid1.RowCount-1 do
    begin
      if (StrGrid1.Cells[12,i]='Y') and (StrToFloat(StrGrid1.Cells[3,i])>StrToFloat(StrGrid1.Cells[5,i])) then
      begin
        tmpAdo.Close;
        tmpAdo.SQL.Text:='select * from data0391 where Rkey71='+StrGrid2.Cells[0,i]+' and Rkey17='+StrGrid2.Cells[1,i]+' and stock_over=0 and (status=1 or status=2) order by auth_date';
        tmpAdo.Open;
        if (not tmpAdo.IsEmpty) then  //��Ӧһ��IQC�������391
        begin
          iCount:=iCount+1;
          StrGrid1.Cells[7,i]:=tmpAdo.FieldByName('rece_qty').AsString;//�������� 
          StrGrid1.Cells[13,i]:=tmpAdo.FieldByName('manufacture_TDATE').AsString;//��������
          StrGrid1.Cells[9,i]:=tmpAdo.FieldByName('barch_no').AsString;//ԭ������
          StrGrid1.Cells[11,i]:=tmpAdo.FieldByName('supplier_model').AsString; //����Ҫ��
          StrGrid1.Cells[17,i]:=IntToStr(tmpAdo.RecordCount);
          StrGrid1.Cells[16,i]:=tmpAdo.FieldByName('Rkey').AsString;//391Rkey
        end;
      end else Continue;
    end;
    if (iCount=0) then
    begin
      ShowMessage('��ǰIQCû��ͨ������');
    end;
  finally
    tmpAdo.connection:=nil;
    tmpAdo.close;
    tmpAdo.free;
  end;
end;

procedure TForm_PoIn.PopupMenu1Popup(Sender: TObject);
begin
//  if (Trim(StrGrid1.Cells[17,StrGrid1.Row])<>'') and (StrToInt(StrGrid1.Cells[17,StrGrid1.Row])>1) then
//  IQC1.Enabled:=True else IQC1.Enabled:=False;
end;

procedure TForm_PoIn.IQC1Click(Sender: TObject);
var InputVar: PDlgInput ;
    s71,s17:string;
    tmpAdo:TADOQuery;
begin
  tmpAdo:=TADOQuery.Create(Application);
  try
    tmpAdo.Connection:=dm.ADOConnection1;
    tmpAdo.Close;
    tmpAdo.SQL.Text:='select * from data0391 where Rkey71='+StrGrid2.Cells[0,StrGrid1.Row]+' and Rkey17='+StrGrid2.Cells[1,StrGrid1.Row]+' and stock_over=0 and (status=1 or status=2) order by auth_date';
    tmpAdo.Open;
    if (not tmpAdo.IsEmpty) and (StrGrid1.Cells[12,StrGrid1.Row]='Y') and (StrToFloat(StrGrid1.Cells[3,StrGrid1.Row])>StrToFloat(StrGrid1.Cells[5,StrGrid1.Row])) then
    if (tmpAdo.RecordCount=1) then
    begin
      StrGrid1.Cells[7,StrGrid1.Row]:=tmpAdo.FieldByName('rece_qty').AsString;//��������
      StrGrid1.Cells[13,StrGrid1.Row]:=tmpAdo.FieldByName('manufacture_TDATE').AsString;//��������
      StrGrid1.Cells[9,StrGrid1.Row]:=tmpAdo.FieldByName('barch_no').AsString;//ԭ������
      StrGrid1.Cells[11,StrGrid1.Row]:=tmpAdo.FieldByName('supplier_model').AsString; //����Ҫ��
      StrGrid1.Cells[16,StrGrid1.Row]:=tmpAdo.FieldByName('Rkey').AsString;//391Rkey
    end else
    if (tmpAdo.RecordCount>1) then
    begin
      try
        s71:=Trim(StrGrid2.Cells[0,StrGrid1.Row]);
        s17:=Trim(StrGrid2.Cells[1,StrGrid1.Row]);
        frmPick_Item_Single := TfrmPick_Item_Single.Create(application) ;
        InputVar.Fields := 'iqc_number/�����/100,barch_no/���κ�/120,supplier_model/��Ӧ���ͺ�/100,rece_qty/�������/60,auth_date/�������/120,manufacture_TDATE/��������/120';
        InputVar.Sqlstr := 'SELECT  DATA0391.rkey, iqc_number, rkey71, rkey17, supplier_model, sgs_no, sgs_date, rece_qty, iqc_qty, barch_no, appl_user_ptr, appl_date, appr_user_ptr,'
              +' appr_date, auth_user_ptr, auth_date, if_halogen, appearance, part_size, part_thickness, tong_thickness, thick_tolerance, ht_remark, if_standard,'
              +' extrl_date, judge_result, remark, DATA0391.status, manufacture_TDATE, package_qualified, qty_qualified, hasheepreport, stock_over,data0071.extra_req'
              +' FROM DATA0391 inner join data0071 on data0391.rkey71=data0071.rkey inner join data0017 on data0391.rkey17=data0017.rkey where data0071.Rkey= '+s71+' AND data0017.rkey='+s17+' and stock_over=0 and (data0391.status=1 or data0391.status=2) order by data0391.auth_date';
        InputVar.AdoConn := DM.ADOConnection1;
        frmPick_Item_Single.InitForm_New(InputVar)  ;
        if frmPick_Item_Single.ShowModal=mrok then
        begin
          StrGrid1.Cells[7,StrGrid1.Row]:=frmPick_Item_Single.adsPick1.FieldByName('rece_qty').AsString;
          StrGrid1.Cells[13,StrGrid1.Row]:=frmPick_Item_Single.adsPick1.FieldByName('manufacture_TDATE').AsString;
          StrGrid1.Cells[9,StrGrid1.Row]:=frmPick_Item_Single.adsPick1.FieldByName('barch_no').AsString;
          StrGrid1.Cells[11,StrGrid1.Row]:=frmPick_Item_Single.adsPick1.FieldByName('supplier_model').AsString;
          StrGrid1.Cells[16,StrGrid1.Row]:=frmPick_Item_Single.adsPick1.FieldByName('Rkey').AsString;
        end;
      finally
        frmPick_Item_Single.adsPick.Close;
        frmPick_Item_Single.Free ;
      end;
    end;
  finally
    tmpAdo.connection:=nil;
    tmpAdo.close;
    tmpAdo.free;
  end;
end;

end.
