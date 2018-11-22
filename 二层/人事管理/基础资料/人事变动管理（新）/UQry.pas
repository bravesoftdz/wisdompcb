unit UQry;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, Grids, StdCtrls, ComCtrls, Buttons, ExtCtrls,common,constvar,dateutils;

type
  TFrmQry = class(TForm)
    bbt_cancel: TBitBtn;
    bbt_submit: TBitBtn;
    GroupBox1: TGroupBox;
    lb_item: TLabel;
    lb_display: TLabel;
    lb_end: TLabel;
    dtp_start: TDateTimePicker;
    edt_find: TEdit;
    dtp_end: TDateTimePicker;
    btn_add: TButton;
    btn_find: TBitBtn;
    GroupBox2: TGroupBox;
    sg_find: TStringGrid;
    bbt_reset: TBitBtn;
    lst_field: TListBox;
    btn_del: TButton;
    rg_audit: TRadioGroup;
    procedure FormShow(Sender: TObject);
    procedure bbt_cancelClick(Sender: TObject);
    procedure bbt_resetClick(Sender: TObject);
    procedure btn_delClick(Sender: TObject);
    procedure lst_fieldClick(Sender: TObject);
    procedure btn_addClick(Sender: TObject);
    procedure bbt_submitClick(Sender: TObject);
    procedure btn_findClick(Sender: TObject);
  private
    { Private declarations }

   procedure UpdateSGrid(irow: integer);

  public
    { Public declarations }
   QrySql: string;

  end;

var
  FrmQry: TFrmQry;
   FN:array[0..10] of string=('��������','�������','�¹���','�ɹ���','�²���','�ɲ���','��ְ��','��ְ��','�º�ͬ����','�ɺ�ͬ����','�Ƿ���Ч');
   FF:array[0..10] of string=('oper_date','alterdate','new_employeecode','orginal_employeecode','ndept.departmentname','odept.departmentname','npdet.item','opdet.item','nhdet.item','ohdet.item','status');
 

implementation

uses UDM,Pick_Item_Single;

{$R *.dfm}

procedure TFrmQry.FormShow(Sender: TObject);
var
  i : Integer;
begin
  //
  for i:=Low(ff) to high(ff) do
  begin
   self.lst_field.AddItem(FN[i],TObject(FN[i]));
  end;
     lst_field.ItemIndex:=0;

  self.sg_find.Cells[0,0]:='������';
  self.sg_find.Cells[0,1]:='����ֵ';

  edt_find.Visible:=false;
  btn_find.Visible:=false;
   rg_audit.Visible:=false;
   
  Self.lb_display.Caption:=Self.lst_field.Items[0];
  dtp_start.date:=now;
  dtp_end.date:=now;


end;

procedure TFrmQry.bbt_cancelClick(Sender: TObject);
begin
close;
end;

procedure TFrmQry.bbt_resetClick(Sender: TObject);
begin

   sg_find.RowCount:=2;
   sg_find.Rows[1].Clear;

end;

procedure TFrmQry.btn_delClick(Sender: TObject);
var
  i: integer;
begin
//ɾ��һ��������

if sg_find.rowcount=2  then exit;
for i := sg_find.row to sg_find.rowcount-2  do
 begin
  sg_find.Rows[i].Text:=sg_find.Rows[i+1].text ;

 end;
 sg_find.RowCount:=sg_find.RowCount-1 ;


end;

procedure TFrmQry.lst_fieldClick(Sender: TObject);
begin
//
  self.edt_find.Visible:=false;
  self.dtp_start.Visible:=False;
  self.dtp_end.Visible:=false;
  self.btn_find.Visible:=false;
  self.lb_end.Visible:=false;
  rg_audit.Visible:=false;

  lb_display.caption:=lst_field.items.Strings[lst_field.itemindex];

  if  lst_field.ItemIndex  in [0,1] then
     begin
       self.dtp_start.Visible:=true;
       self.dtp_end.Visible:=true;
       self.lb_end.Visible:=true;
      end
  else  if  lst_field.ItemIndex=10 then  rg_audit.Visible:=true
  else 
  begin
   self.edt_find.Visible:=true;
   self.btn_find.Visible:=true;
  end;

end;

procedure TFrmQry.btn_addClick(Sender: TObject);
var
  i:Integer;
begin
  //
    if (Trim(self.edt_find.text)='' ) and (self.edt_find.visible=true ) then
   begin
    ShowMessage('�ף�������������ֵ��');
    exit;
   end;

     for i:=1  to  self.sg_find.RowCount-2 do
    begin
      if  (self.lst_field.items[self.lst_field.ItemIndex]= sg_find.Cells[0,i])  and
         (self.lst_field.items[self.lst_field.ItemIndex]<> sg_find.Cells[1,i] )  then

        begin
          //�Ѽ�����ֶ�������һ���ģ�����һ��������sql

          UpdateSGrid(i);
          exit;
        end;

    end;
    
       sg_find.Cells[0,sg_find.RowCount-1]:= self.lst_field.Items[self.lst_field.itemindex];

       UpdateSGrid(sg_find.RowCount-1);    //�������е�&  ���� sql ��striggrid
       
        sg_find.RowCount :=sg_find.RowCount +1; 



end;

 procedure TFrmQry.UpdateSGrid(irow: integer);
 var
   Dt_f, dt_t: string;
 begin

  self.sg_find.cells[0,irow]:=self.lst_field.Items[self.lst_Field.itemindex]; // ���µڶ���


  dt_f := formatdatetime('yyyy-mm-dd',dtp_start.date);
  dt_t := formatdatetime('yyyy-mm-dd',incday(dtp_end.date,1));


  case self.lst_field.ItemIndex of

     0:      //��������
    begin
    sg_find.cells[1,irow]:='���ڴ�'+formatdatetime('yyyy-mm-dd',dtp_start.date)+'�� '+formatdatetime('yyyy-mm-dd',dtp_end.date)+'  ' ;
    sg_find.cells[2,irow]:=' and convert(varchar(10),oper_date,120) >=''' +dt_f+ '''  and oper_date <=''' +dt_t+ '''   '  ;
    end;

    1:      //�������
     begin
      sg_find.cells[1,irow]:='���ڴ�'+dt_f+'�� '+dt_t  ;
      sg_find.cells[2,irow]:=' and alterdate >='''+dt_f+'''  and alterdate <='''+dt_t+'''   '  ;
      end ;



   2:      //�¹���
    begin
      sg_find.cells[1,irow]:= trim(self.edt_find.text);
     sg_find.cells[2,irow]:=' and new_employeecode ='''+trim(self.edt_find.text)+'''   '

     end;

     3:      //�ɹ���
    begin
      sg_find.cells[1,irow]:= trim(self.edt_find.text);
     sg_find.cells[2,irow]:=' and orginal_employeecode ='''+trim(self.edt_find.text)+'''   '

     end;

    4:      //�²���
    begin
      sg_find.cells[1,irow]:= trim(self.edt_find.text);
     sg_find.cells[2,irow]:=' and ndept.departmentname ='''+trim(self.edt_find.text)+'''   '

     end;

    5:      //�ɲ���
    begin
      sg_find.cells[1,irow]:= trim(self.edt_find.text);
     sg_find.cells[2,irow]:=' and odept.departmentname ='''+trim(self.edt_find.text)+'''   '

     end;


     6:      //��ְ��
    begin
      sg_find.cells[1,irow]:= trim(self.edt_find.text);
     sg_find.cells[2,irow]:=' and npdet.item ='''+trim(self.edt_find.text)+'''   '

     end;

    7:      //��ְ��
    begin
      sg_find.cells[1,irow]:= trim(self.edt_find.text);
     sg_find.cells[2,irow]:=' and opdet.item ='''+trim(self.edt_find.text)+'''   '

     end;


    8:      //�º�ͬ����
    begin
      sg_find.cells[1,irow]:= trim(self.edt_find.text);
     sg_find.cells[2,irow]:=' and nhdet.item ='''+trim(self.edt_find.text)+'''   '

     end;

    9:      //�ɺ�ͬ����
    begin
      sg_find.cells[1,irow]:= trim(self.edt_find.text);
     sg_find.cells[2,irow]:=' and ohdet.item ='''+trim(self.edt_find.text)+'''   '

     end;

    10:      //�Ƿ���Ч
    begin
      if rg_audit.ItemIndex=0  then
      begin
      sg_find.cells[1,irow]:= '��Ч';
      sg_find.cells[2,irow]:=' and active =1  ';
      end
      else
      begin
      sg_find.cells[1,irow]:= 'δ��Ч';
      sg_find.cells[2,irow]:=' and active =0  ' ;
      end

     end;


   end;
  end;


procedure TFrmQry.bbt_submitClick(Sender: TObject);
var
  i:integer;
begin
  QrySql:='';
  for i:=1 to sg_find.RowCount-1 do
  begin
   QrySql:=QrySql+ sg_find.cells[2,i];
  end;


end;

procedure TFrmQry.btn_findClick(Sender: TObject);
var
  InputVar: PDlgInput ;
begin
  frmPick_Item_Single := TfrmPick_Item_Single.Create(application) ;
  try
    if (lb_display.Caption = '�¹���') or (lb_display.Caption ='�ɹ���') then
    begin
      InputVar.Fields := 'employeecode/Ա������/100,chinesename/Ա������/100,ondutytime/��ְʱ��/120,';
      InputVar.Sqlstr := 'select employeecode,chinesename,ondutytime from employeemsg';
      InputVar.AdoConn := dm.con1;
      frmPick_Item_Single.InitForm_New(InputVar) ;
      if frmPick_Item_Single.ShowModal=mrok then
      begin
        edt_find.Text := frmPick_Item_Single.adsPick.FieldValues['employeecode'];
      end;
    end;

    if (lb_display.Caption = '�²���') or (lb_display.Caption ='�ɲ���') then
    begin
      InputVar.Fields := 'departmentcode/���Ŵ���/120,departmentname/��������/250,';
      InputVar.Sqlstr := 'select * from datadepartment';
      InputVar.AdoConn := dm.con1;
      frmPick_Item_Single.InitForm_New(InputVar) ;
      if frmPick_Item_Single.ShowModal=mrok then
      begin
        edt_find.Text := frmPick_Item_Single.adsPick.FieldValues['departmentname'];
      end
    end;

    if (lb_display.Caption = '��ְ��') or (lb_display.Caption ='��ְ��') then
    begin
      InputVar.Fields := 'item/ְ��/380,';
      InputVar.Sqlstr := 'SELECT * from datadetail where [dictid]=1';
      InputVar.AdoConn := dm.con1;
      frmPick_Item_Single.InitForm_New(InputVar) ;
      if frmPick_Item_Single.ShowModal=mrok then
      begin
        edt_find.Text := frmPick_Item_Single.adsPick.FieldValues['item'];
      end
    end;

    if (lb_display.Caption = '�º�ͬ����') or (lb_display.Caption ='�ɺ�ͬ����') then
    begin
      InputVar.Fields := 'item/ְ��/380,,';
      InputVar.Sqlstr := 'SELECT * from datadetail where [dictid]=5';
      InputVar.AdoConn := dm.con1;
      frmPick_Item_Single.InitForm_New(InputVar) ;
      if frmPick_Item_Single.ShowModal=mrok then
      begin
        edt_find.Text := frmPick_Item_Single.adsPick.FieldValues['item'];
      end
    end;
  finally
    frmPick_Item_Single.adsPick.Close;
    frmPick_Item_Single.Free ;
  end;
end;

end.
