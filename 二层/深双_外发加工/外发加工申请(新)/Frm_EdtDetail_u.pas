unit Frm_EdtDetail_u;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, Mask, DBCtrls, DB, ADODB, ExtCtrls, ComCtrls,
  Grids, DBGridEh;

type
  TFrm_EdtDetail = class(TForm)
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    BitBtn3: TBitBtn;
    DBEdit1: TDBEdit;
    BtSave: TButton;
    Button2: TButton;
    Label13: TLabel;
    DBEdit5: TDBEdit;
    DBEdit6: TDBEdit;
    Label15: TLabel;
    DBText4: TDBText;
    DBComboBox1: TDBComboBox;
    Label1: TLabel;
    DBEdit3: TDBEdit;
    Label3: TLabel;
    DBEdit4: TDBEdit;
    Label6: TLabel;
    DBEdit8: TDBEdit;
    Label8: TLabel;
    DBEdit9: TDBEdit;
    DBComboBox2: TDBComboBox;
    Label9: TLabel;
    DBEdit7: TDBEdit;
    ADO279: TADOQuery;
    ADO279SPEC_RKEY: TStringField;
    ADO279PARAMETER_VALUE: TStringField;
    ADOMIN_aperture: TADOQuery;
    ADOMIN_aperturePARAMETER_VALUE: TStringField;
    DateTimePicker1: TDateTimePicker;
    Grd: TDBGridEh;
    DataSource1: TDataSource;
    ADOWk_sel: TADOQuery;
    ADOWk_selOUTSOURCE: TBooleanField;
    ADOWk_selWORK_ORDER_NUMBER: TStringField;
    ADOWk_selpcs: TFloatField;
    ADOWk_selPNLS: TIntegerField;
    ADOWk_selWO_PTR: TIntegerField;
    EdtPart: TEdit;
    ADOWk_selsets: TFloatField;
    procedure BitBtn3Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure BtSaveClick(Sender: TObject);
    procedure DBEdit1Exit(Sender: TObject);
    procedure DBComboBox2Change(Sender: TObject);
    procedure ADOWk_selOUTSOURCEChange(Sender: TField);
    procedure DBComboBox1Change(Sender: TObject);
    procedure EdtPartExit(Sender: TObject);
    procedure FormKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure GrdKeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ADOWk_selBeforeInsert(DataSet: TDataSet);
    procedure ADOWk_selBeforeDelete(DataSet: TDataSet);
  private

  public
    mainsql:string;
    FWHOUSE_PTR,FDept_ptr:integer;
    strkey:string;
    function getkey():string;

  end;

var
  Frm_EdtDetail: TFrm_EdtDetail;

implementation
 uses DM_u, inv_search;
{$R *.dfm}

procedure TFrm_EdtDetail.BitBtn3Click(Sender: TObject);
var
 pnl_l,pnl_w:double;

begin
 try
  form_inv := tform_inv.Create(application);
  form_inv.init(FWHOUSE_PTR,FDept_ptr);

  mainsql:=form_inv.ADOQuery1.SQL.Text;
//  form_inv.ADOQuery1.Close;
//  if strkey <> ''then
//    form_inv.ADOQuery1.SQL.Text:=mainsql+' and manu_part_number not in ('+ strkey +
//    ') order by manu_part_number asc';
//  form_inv.ADOQuery1.Open;

  if form_inv.ShowModal = mrok then
  begin
    if not DBEdit1.Enabled then
    begin
      ADOWk_sel.Close;
      ADOWk_sel.Parameters[0].Value:=form_inv.ADOQuery1rkey.Value;
      ADOWk_sel.Parameters[1].Value:=FWHOUSE_PTR;
      ADOWk_sel.Parameters[2].Value:=FDept_ptr;
      ADOWk_sel.Open;
    end;

    dm.ADO301CUSTPART_PTR.Value:=form_inv.ADOQuery1rkey.Value;
    dm.ADO301LAYER.Value:=form_inv.ADOQuery1LAYERS.Value; //厚数
    self.ADO279.Close;                    //打开全局参数
    self.ADO279.Parameters[0].Value:=dm.ADO301CUSTPART_PTR.Value;
    self.ADO279.Open;
    dbcombobox2.Items.Clear;
    if ado279.Locate('SPEC_RKEY','H',[]) then   //Ａ板尺寸
     dbcombobox2.Items.Add(trim(self.ADO279PARAMETER_VALUE.Value));
    if ado279.Locate('SPEC_RKEY','I',[]) then    //b板尺寸
     dbcombobox2.Items.Add(trim(self.ADO279PARAMETER_VALUE.Value));

    {if ado279.Locate('SPEC_RKEY','S',[]) then    //c板尺寸
     dbcombobox2.Items.Add(trim(self.ADO279PARAMETER_VALUE.Value));
    if ado279.Locate('SPEC_RKEY','T',[]) then    //d板尺寸
     dbcombobox2.Items.Add(trim(self.ADO279PARAMETER_VALUE.Value));
      }
    dbcombobox2.ItemIndex:=0;
    dm.ADO301STANDARD.Value:=dbcombobox2.Items[0];
    if ado279.Locate('SPEC_RKEY','TK',[]) then    //完成板厚
     try
      dm.ADO301THINK.Value:=strtofloat(self.ADO279PARAMETER_VALUE.Value);
     except
      dm.ADO301THINK.Value:=0;
     end;
    pnl_l:=0;
    pnl_w:=0;
    if ado279.Locate('SPEC_RKEY','6',[]) then
     try
      pnl_l:=strtofloat(self.ADO279PARAMETER_VALUE.Value);
     except
     end;
    if ado279.Locate('SPEC_RKEY','7',[]) then
     try
      pnl_w:=strtofloat(self.ADO279PARAMETER_VALUE.Value);
     except
     end;
     dm.ADO301AREA_SQM.Value := pnl_l*pnl_w/1000000;         //平方米
     dm.ADO301AREA_SQF.Value := dm.ADO301AREA_SQM.Value*10.7639; //平方英尺

     self.ADOMIN_aperture.Close;
     self.ADOMIN_aperture.Parameters[0].Value:=dm.ADO301CUSTPART_PTR.Value;
     self.ADOMIN_aperture.Open;
     if not ADOMIN_aperture.IsEmpty then
      try
       dm.ADO301MIN_aperture.Value:=strtofloat(self.ADOMIN_aperturePARAMETER_VALUE.Value);
      except
       dm.ADO301MIN_aperture.Value:=0;
      end;
     if dbedit1.Enabled then dbedit1.SetFocus;
   end;
 finally
  EdtPart.Text:=DM.ADO301PART_NUMBER.Value;
  form_inv.free;
 end;
end;

procedure TFrm_EdtDetail.Button2Click(Sender: TObject);
begin
  if Button2.Caption='关闭' then close else  dm.ADO301.Cancel;
end;

function TFrm_EdtDetail.getkey: string;
var
  str:string;
begin
    str:='';
    DM.ADO301.First;
    while not dm.ADO301.Eof do
    begin

      str:= QuotedStr(DM.ADO301PART_NUMBER.AsString)+ ','+str;
      DM.ADO301.Next;
    end;
    str:=Copy(str,0,Length(str)-1);
    Result:=str;
end;

procedure TFrm_EdtDetail.BtSaveClick(Sender: TObject);
begin
  if Grd.Visible then
  begin

    ADOWk_sel.First;
    while not ADOWk_sel.Eof do
    begin
      DM.ADO305.Filtered:= False;
//      with DM.Tmp do
//      begin
//        Close;
//        SQL.Text :='select * from wzdata305 inner join wzdata301 on WZDATA305.EPIBOLY_PTR=WZDATA301.EPIBOLY_PTR'+
//        ' and WZDATA305.seq_no= WZDATA301.seq_no and wzdata305.wo_ptr='+ ADOWk_selWO_PTR.AsString;
//        Open;
//      end;
//      if not DM.Tmp.IsEmpty then
//      begin
//            ShowMessage('此工单已在其他外发编号外发');
//            DM.ADO305.Filtered:=True;
//            Exit;
//      end;
        DM.ADO305.First;
        while not DM.ADO305.eof do
        begin
          if (ADOWk_selWORK_ORDER_NUMBER.AsString=DM.ADO305WORK_ORDER_NUMBER.AsString) and (ADOWk_selOUTSOURCE.Value=True) then
          begin
            ShowMessage('在此外发编号中已外发该工单');
            DM.ADO305.Filtered:=True;
            Exit;
          end;
  //        ShowMessage(DM.ADO305WORK_ORDER_NUMBER.AsString);
          DM.ADO305.Next;
        end;
      ADOWk_sel.Next;

    end;
    DM.ADO305.Filtered:=True;
  end;
  dm.qry1Tmp.Close;
  dm.qry1Tmp.Parameters[0].Value := EdtPart.text;
  dm.qry1Tmp.Parameters[1].Value := dm.adowz300dept_ptr.value;
  dm.qry1Tmp.Open;

  if (dm.qry1Tmp.IsEmpty) then
  begin
//    ShowMessage(DM.qry1Tmp.SQL.Text);
//    ShowMessage(dm.qry1Tmp.Parameters[0].Value);
//    ShowMessage(dm.qry1Tmp.Parameters[1].Value);
    if MessageBox(Handle,'MI工艺流程没有此工序，是否继续','提示',MB_YesNO) = IDNO then
    begin
      exit;
    end;
  end;
  if dm.ADO301QUANTITY.Value<=0 then
   begin
    showmessage('请输入正确的外发数量');
    EdtPart.SetFocus;
   end
  else
  if dm.ADO301.State=dsinsert then
   begin
    dm.ADO301REQ_DATE.Value:=self.DateTimePicker1.Date;

//    if dm.adowz300rkey.Value>0 then
      DM.ADO301seq_no.Value := DM.ADO301.RecordCount+1;

    dm.ADO301.Post;

    if iFlag=1 then
    begin
      ADOWk_sel.First;
      while not ADOWk_sel.Eof do
      begin
        if ADOWk_selOUTSOURCE.AsBoolean then
        begin

          DM.ADO305.Append;






          DM.ADO305wo_ptr.Value:=ADOWk_selWO_PTR.Value;

          if DM.ADO301seq_no.AsInteger >0 then
          begin
            DM.ADO305EPIBOLY_PTR.Value:=DM.adowz300rkey.Value;
            DM.ADO305seq_no.Value := DM.ADO301seq_no.Value;
          end
          else
          begin
            DM.ADO305seq_no.Value:=dm.ADO301rec.Value;
          end;
//           ShowMessage(DM.ADO305seq_no.AsString);
//           ShowMessage(DM.ADO301seq_no.AsString);
          if DBComboBox1.ItemIndex=0 then
            DM.ADO305Quantity.Value:=ADOWk_selPNLS.AsInteger
          else
           if DBComboBox1.ItemIndex=1 then
            DM.ADO305Quantity.Value:=ADOWk_selsets.AsInteger
           else
            DM.ADO305Quantity.Value:=ADOWk_selPCS.AsInteger;

          DM.ADO305.Post;
          
        end;


        ADOWk_sel.Next;
      end;
      ADOWk_sel.Close;
    end;
     strkey:=getkey;
    dm.ADO301.Append;
    dm.ADO301UNIT_NAME.Value:='PNL';
    dbedit6.SetFocus;
    EdtPart.Text:='';
   end
  else
   begin
    if not (dm.ADO301.State in[dsEdit]) then dm.ADO301.Edit;
    dm.ADO301.Post;
    self.ModalResult:=mrok;
   end;
end;

procedure TFrm_EdtDetail.DBEdit1Exit(Sender: TObject);
begin
 if trim(dbedit1.Text) = '' then dbedit1.Field.Value := 0;
end;

procedure TFrm_EdtDetail.DBComboBox2Change(Sender: TObject);
var
 pnl_l,pnl_w:double;
begin
  DBComboBox1.ItemIndex:=0;
case dbcombobox2.ItemIndex of
 0:     //A板
  begin
    pnl_l:=0;
    pnl_w:=0;
    if ado279.Locate('SPEC_RKEY','6',[]) then
     try
      pnl_l:=strtofloat(self.ADO279PARAMETER_VALUE.Value);
     except
     end;
    if ado279.Locate('SPEC_RKEY','7',[]) then
     try
      pnl_w:=strtofloat(self.ADO279PARAMETER_VALUE.Value);
     except
     end;
     dm.ADO301AREA_SQM.Value := pnl_l*pnl_w/1000000;         //平方米
     dm.ADO301AREA_SQF.Value := dm.ADO301AREA_SQM.Value*10.7639; //平方英尺
  end;
 1:     //B板
  begin
    pnl_l:=0;
    pnl_w:=0;
    if ado279.Locate('SPEC_RKEY','8',[]) then
     try
      pnl_l:=strtofloat(self.ADO279PARAMETER_VALUE.Value);
     except
     end;
    if ado279.Locate('SPEC_RKEY','9',[]) then
     try
      pnl_w:=strtofloat(self.ADO279PARAMETER_VALUE.Value);
     except
     end;
     dm.ADO301AREA_SQM.Value := pnl_l*pnl_w/1000000;         //平方米
     dm.ADO301AREA_SQF.Value := dm.ADO301AREA_SQM.Value*10.7639; //平方英尺
  end;
{ 2:
  begin
    pnl_l:=0;
    pnl_w:=0;
    if ado279.Locate('SPEC_RKEY','14',[]) then
     try
      pnl_l:=strtofloat(self.ADO279PARAMETER_VALUE.Value);
     except
     end;
    if ado279.Locate('SPEC_RKEY','15',[]) then
     try
      pnl_w:=strtofloat(self.ADO279PARAMETER_VALUE.Value);
     except
     end;
     dm.ADO301AREA_SQM.Value := pnl_l*pnl_w/1000000;         //平方米
     dm.ADO301AREA_SQF.Value := dm.ADO301AREA_SQM.Value*10.7639; //平方英尺
  end;
 3:
  begin
    pnl_l:=0;
    pnl_w:=0;
    if ado279.Locate('SPEC_RKEY','17',[]) then
     try
      pnl_l:=strtofloat(self.ADO279PARAMETER_VALUE.Value);
     except
     end;
    if ado279.Locate('SPEC_RKEY','18',[]) then
     try
      pnl_w:=strtofloat(self.ADO279PARAMETER_VALUE.Value);
     except
     end;
     dm.ADO301AREA_SQM.Value := pnl_l*pnl_w/1000000;         //平方米
     dm.ADO301AREA_SQF.Value := dm.ADO301AREA_SQM.Value*10.7639; //平方英尺
  end;   }
end;
end;

procedure TFrm_EdtDetail.ADOWk_selOUTSOURCEChange(Sender: TField);
begin
  if DBComboBox1.ItemIndex=0 then
  begin
    if Sender.AsBoolean then
      DM.ADO301.FieldByName('quantity').AsInteger:=DM.ADO301.FieldByName('quantity').AsInteger+ADOWk_selPNLS.Value
    else
      DM.ADO301.FieldByName('quantity').AsInteger:=DM.ADO301.FieldByName('quantity').AsInteger-ADOWk_selPNLS.Value;
  end else if DBComboBox1.ItemIndex=1 then begin
    if Sender.AsBoolean then
      DM.ADO301.FieldByName('quantity').AsInteger:=DM.ADO301.FieldByName('quantity').AsInteger+ADOWk_selsets.AsInteger
    else
      DM.ADO301.FieldByName('quantity').AsInteger:=DM.ADO301.FieldByName('quantity').AsInteger-ADOWk_selsets.AsInteger;
  end else begin
    if Sender.AsBoolean then
      DM.ADO301.FieldByName('quantity').AsInteger:=DM.ADO301.FieldByName('quantity').AsInteger+ADOWk_selPCS.AsInteger
    else
      DM.ADO301.FieldByName('quantity').AsInteger:=DM.ADO301.FieldByName('quantity').AsInteger-ADOWk_selPCS.AsInteger;
  end;
end;

procedure TFrm_EdtDetail.DBComboBox1Change(Sender: TObject);
begin
  if  DBEdit6.Text='' then exit;
  if DBComboBox1.ItemIndex=2 then    //pcs
  begin
    DM.Tmp2.Close;
    DM.Tmp2.SQL.Text:='select pcs_sq,analysis_code_5 from data0025 where rkey='+dm.ADO301CUSTPART_PTR.AsString;
    DM.Tmp2.Open;
    DBComboBox2.Field.Value:=DM.Tmp2.Fields[1].AsString;
    DBEdit3.Field.Value:=DM.Tmp2.Fields[0].asfloat;
    DBEdit4.Field.Value:=DM.Tmp2.Fields[0].AsFloat*10.7639; //平方英尺
  end else if DBComboBox1.ItemIndex=1 then    //set
  begin
    DM.Tmp2.Close;
    DM.Tmp2.SQL.Text:='select unit_sq,analysis_code_1 from data0025 where rkey='+dm.ADO301CUSTPART_PTR.AsString;
    DM.Tmp2.Open;
    DBComboBox2.Field.Value:=DM.Tmp2.Fields[1].AsString;
    DBEdit3.Field.Value:=DM.Tmp2.Fields[0].asfloat;
    DBEdit4.Field.Value:=DM.Tmp2.Fields[0].AsFloat*10.7639; //平方英尺
  end else begin                //pnl
     DBComboBox2.ItemIndex:=0;
     dm.ADO301STANDARD.Value:=dbcombobox2.Items[0];
     DBComboBox2Change(DBComboBox2);
  end;


  if iFlag=0 then exit;
  ADOWk_sel.First;
  DM.ADO301.FieldByName('quantity').AsInteger:=0;
  while not ADOWk_sel.Eof do
  begin
    if DBComboBox1.ItemIndex=0 then      //PNLs
    begin
      if ADOWk_selOUTSOURCE.AsBoolean then
        DM.ADO301.FieldByName('quantity').AsInteger:=DM.ADO301.FieldByName('quantity').AsInteger+ADOWk_selPNLS.AsInteger
    end else if DBComboBox1.ItemIndex=1 then begin         //set
      if ADOWk_selOUTSOURCE.AsBoolean then
        DM.ADO301.FieldByName('quantity').AsInteger:=DM.ADO301.FieldByName('quantity').AsInteger+ADOWk_selsets.AsInteger
    end else begin         //pcs
      if ADOWk_selOUTSOURCE.AsBoolean then
        DM.ADO301.FieldByName('quantity').AsInteger:=DM.ADO301.FieldByName('quantity').AsInteger+ADOWk_selPCS.AsInteger
    end;
    ADOWk_sel.Next;
  end;
end;

procedure TFrm_EdtDetail.EdtPartExit(Sender: TObject);
var
 pnl_l,pnl_w:double;
begin
  if (EdtPart.Text='') or (self.ActiveControl=Button2)  then  exit;

    DM.tmp2.Close;
    if iFlag=0 then
      DM.tmp2.SQL.Text:='select rkey,manu_part_number,manu_part_desc,customer_ptr,analysis_code_2,'+
                        'case data0025.ttype when 0 then ''批量'' when 1 then ''样板'' end as bath_former,'+
                        'case when parent_ptr is null then ''外层'' else ''内层'' end as out_in,'+
                        'LAYERS from data0025 '+
                        'WHERE  dbo.Data0025.MANU_PART_NUMBER='''+EdtPart.Text+''''
    else
      DM.tmp2.SQL.Text:='SELECT top 1 dbo.Data0025.RKEY, dbo.Data0025.MANU_PART_NUMBER, dbo.Data0025.MANU_PART_DESC,'+
                      'dbo.Data0025.ANALYSIS_CODE_2, dbo.Data0025.LAYERS '+
                      'FROM dbo.Data0056 INNER JOIN '+
                      'dbo.Data0006 ON dbo.Data0056.WO_PTR = dbo.Data0006.RKEY INNER JOIN '+
                      'dbo.Data0025 ON dbo.Data0006.BOM_PTR = dbo.Data0025.RKEY INNER JOIN '+
                      'dbo.data0492 ON dbo.Data0006.CUT_NO = dbo.data0492.CUT_NO '+
                      'WHERE dbo.data0056.LOC_PTR ='+inttostr(FWHOUSE_PTR) +' and dbo.Data0025.MANU_PART_NUMBER='''+EdtPart.Text+
                      ''' AND dbo.Data0056.DEPT_PTR = '+inttostr(FDept_ptr)+' and data0006.prod_status=4' ;

    DM.tmp2.Open;
    if DM.tmp2.IsEmpty then
    begin
      showmessage('产品编码错误...');
      EdtPart.SetFocus;
      abort;
    end else begin
      if not DBEdit1.Enabled then
      begin
        ADOWk_sel.Close;
        ADOWk_sel.Parameters[0].Value:=DM.tmp2.fieldbyname('rkey').AsInteger;
        ADOWk_sel.Parameters[1].Value:=FWHOUSE_PTR;
        ADOWk_sel.Parameters[2].Value:=FDept_ptr;
        ADOWk_sel.Open;
      end;

      dm.ADO301CUSTPART_PTR.Value:=DM.tmp2.fieldbyname('rkey').AsInteger;
      dm.ADO301LAYER.Value:=DM.tmp2.fieldbyname('LAYERS').Value; //厚数
      self.ADO279.Close;                    //打开全局参数
      self.ADO279.Parameters[0].Value:=dm.ADO301CUSTPART_PTR.Value;
      self.ADO279.Open;
      dbcombobox2.Items.Clear;
      if ado279.Locate('SPEC_RKEY','H',[]) then   //Ａ板尺寸
         dbcombobox2.Items.Add(trim(self.ADO279PARAMETER_VALUE.Value));
      if ado279.Locate('SPEC_RKEY','I',[]) then    //b板尺寸
         dbcombobox2.Items.Add(trim(self.ADO279PARAMETER_VALUE.Value));

      dbcombobox2.ItemIndex:=0;
      dm.ADO301STANDARD.Value:=dbcombobox2.Items[0];
      if ado279.Locate('SPEC_RKEY','TK',[]) then    //完成板厚
      try
        dm.ADO301THINK.Value:=strtofloat(self.ADO279PARAMETER_VALUE.Value);
      except
        dm.ADO301THINK.Value:=0;
      end;
      pnl_l:=0;
      pnl_w:=0;
      if ado279.Locate('SPEC_RKEY','6',[]) then
      try
        pnl_l:=strtofloat(self.ADO279PARAMETER_VALUE.Value);
      except
      end;
      if ado279.Locate('SPEC_RKEY','7',[]) then
      try
        pnl_w:=strtofloat(self.ADO279PARAMETER_VALUE.Value);
      except
      end;

      dm.ADO301AREA_SQM.Value := pnl_l*pnl_w/1000000;         //平方米
      dm.ADO301AREA_SQF.Value := dm.ADO301AREA_SQM.Value*10.7639; //平方英尺
      self.ADOMIN_aperture.Close;
      self.ADOMIN_aperture.Parameters[0].Value:=dm.ADO301CUSTPART_PTR.Value;
      self.ADOMIN_aperture.Open;
      if not ADOMIN_aperture.IsEmpty then
      try
        dm.ADO301MIN_aperture.Value:=strtofloat(self.ADOMIN_aperturePARAMETER_VALUE.Value);
      except
        dm.ADO301MIN_aperture.Value:=0;
      end;
      if dbedit1.Enabled then dbedit1.SetFocus;
    end;

end;

procedure TFrm_EdtDetail.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key=vk_return then
    SelectNext(self.ActiveControl,true,true);
end;

procedure TFrm_EdtDetail.GrdKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (ssAlt in Shift)  and  (Key=86) then
     showmessage(ADOWk_sel.SQL.Text);
end;

procedure TFrm_EdtDetail.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
    Self.Button2Click(Sender);
    
end;

procedure TFrm_EdtDetail.ADOWk_selBeforeInsert(DataSet: TDataSet);
begin
  Abort;
end;

procedure TFrm_EdtDetail.ADOWk_selBeforeDelete(DataSet: TDataSet);
begin
  Abort;
end;



end.
