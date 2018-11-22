unit USel17Materialfrm_Mod38;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs,uBaseSinglePickListFrm,uCommFunc,
  DBGridEhGrouping, ToolCtrlsEh, DBGridEhToolCtrls, DynVarsEh, Vcl.StdCtrls,
  Data.DB, Datasnap.DBClient, EhLibVCL, GridsEh, DBAxisGridsEh, DBGridEh,
  Vcl.ExtCtrls;

type
  TfrmSel17Material_Mod38 = class;
  TFrmCallBack_Mod38 = procedure(AFrm: TfrmSel17Material_Mod38) of object;

  TfrmSel17Material_Mod38 = class(TfrmSinglePickList)
    lbl1: TLabel;
    cbbWH: TComboBox;
    cdstemp: TClientDataSet;
    procedure FormCreate(Sender: TObject);
    procedure btnOKClick(Sender: TObject);
    procedure cbbWHChange(Sender: TObject);
    procedure edtFilterChange(Sender: TObject);
  private
    { Private declarations }
    whouse_ptr:Tstringlist;
  public
    { Public declarations }
    FFlag: integer;
    FParentCallBack :TFrmCallBack_Mod38;
     Fqty:double;
  end;

var
  frmSel17Material_Mod38: TfrmSel17Material_Mod38;

implementation
    uses UPutOutFrm_mod38;
{$R *.dfm}

procedure TfrmSel17Material_Mod38.btnOKClick(Sender: TObject);
 var
   LFrm: TfrmPutOut_mod38;
begin
   //inherited;
   if cdspick.IsEmpty then  exit;

   if cbbWH.text='' then
   begin
    showmessage('����ѡ�񹤳�!');
   exit;
   end;

    LFrm := TfrmPutOut_mod38.Create(Self);
    try
      //�Ƚ��ȳ�

     if FFlag=1 then
      begin 
      cdstemp.Close;
      cdstemp.Data:=cdspick.Data;                                             //�Ե�ǰ�����ݽ��и��Ʋ�����
      cdstemp.Filter:='INV_PART_NUMBER='+QuotedStr(Trim(cdspick.FieldByName('INV_PART_NUMBER').AsString));
      cdstemp.Filtered:=True;

      cdstemp.First;
      while not cdstemp.Eof do
      begin            //   ����ڸ��Ƶ�����������Ч��С�� csdpick�ļ�¼ ��������ʾ
      if  (cdstemp.FieldByName('EXPIRE_DATE').AsDateTime<cdspick.FieldByName('EXPIRE_DATE').AsDateTime) and  (cdspick.FieldByName('EXPIRE_DATE').AsDateTime>0) then
      begin
        if messagedlg('���бȵ�ǰ��Ч�ڸ���Ŀ���¼����ȷ��Ҫ������?',mtconfirmation,[mbyes,mbno],1)=mrNO then
        begin
          Exit;
        end
        else
          Break;
      end;
      cdstemp.Next;
      end;
      cdstemp.Close;
      end;


    LFrm.edtQtyOnHnad.text:= cdspick.FieldByName('QUAN_ON_HAND').value;
    LFrm.edtUnitName.text:= cdspick.FieldByName('unit_name').value;
    LFrm.edtThisQty.text:=cdspick.FieldByName('QUAN_ON_HAND').value;

    if LFrm.showmodal=mrok then
    begin
      Fqty:=StrToFloat(LFrm.edtThisQty.Text);

      if FFlag=1 then //��������
      begin
        if  (cdspick.FieldByName('EXPIRE_DATE').value<gfunc.GetSvrDateTime) and (cdspick.FieldByName('EXPIRE_DATE').value>0) then
        begin
        showmessage('�Բ���,����������Ч���ѹ�,�뷢�ϵ����ϼ�������ȷ����Ч��!');
        exit;
        end;
      end;

      if Assigned(FParentCallBack) then
       FParentCallBack(Self);
       cdsPick.ReadOnly:=false;
       cdsPick.Delete;
       cdsPick.ReadOnly:= true;
    end
    finally
      LFrm.free;
    end;
end;

procedure TfrmSel17Material_Mod38.cbbWHChange(Sender: TObject);
begin
  inherited;
 cdsPick.FILTER:='warehouse_ptr='+whouse_ptr.Strings[cbbWH.itemindex];
 cdsPick.filtered:=true;
 end;

procedure TfrmSel17Material_Mod38.edtFilterChange(Sender: TObject);
var
  fDate: Tdatetime;
begin

 if (FHotColumn.Field.DataType in [ftDate, ftDateTime]) and (trim(edtFilter.text)<>'') then
    if not TryStrToDate(trim(edtFilter.text), fDate) then
    begin
      Showmessage(trim(edtFilter.text) + '�������ڸ�ʽ��');
      exit;
    end;
  inherited;
end;

procedure TfrmSel17Material_Mod38.FormCreate(Sender: TObject);
var
Lsql:string;
begin
  inherited;
 Lsql:='select rkey,ABBR_NAME from data0015 order by rkey';
   gSvrintf.IntfGetDataBySql(Lsql,cdsTemp);
    whouse_ptr:=tstringlist.Create;
   cdsTemp.First;
    while not cdsTemp.eof do
    begin
     cbbWH.Items.Add(cdsTemp.fieldbyname('ABBR_NAME').AsString);
     whouse_ptr.Add(cdsTemp.fieldbyname('rkey').AsString);
     cdsTemp.next;
    end;
    cbbWH.itemindex:=0;

end;

end.
