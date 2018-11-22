unit Bom_Edit;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB, Grids, DBGridEh, ExtCtrls, ComCtrls, Buttons,
  StdCtrls, DBCtrls, DBGrids, Menus;

type
  TfrmBom_Edit = class(TForm)
    Panel1: TPanel;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    Panel3: TPanel;
    DBGridEh1: TDBGridEh;
    DBGridEh2: TDBGridEh;
    Splitter1: TSplitter;
    Panel5: TPanel;
    btnExecBOM: TSpeedButton;
    btnGetParams: TSpeedButton;
    btnExit: TSpeedButton;
    spbtnSave: TSpeedButton;
    DBGrid1: TDBGrid;
    SpeedButton1: TSpeedButton;
    PopupMenu1: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    SpeedButton2: TSpeedButton;
    SpeedButton3: TSpeedButton;
    procedure btnGetParamsClick(Sender: TObject);
    procedure btnExitClick(Sender: TObject);
    procedure btnExecBOMClick(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure DBGridEh1CellClick(Column: TColumnEh);
    procedure DBGridEh1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure spbtnSaveClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure N1Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure PopupMenu1Popup(Sender: TObject);
    procedure DBGrid1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure SpeedButton2Click(Sender: TObject);
    procedure PageControl1Change(Sender: TObject);
    procedure DBGridEh2DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumnEh; State: TGridDrawState);
    procedure DBGridEh2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormShow(Sender: TObject);
  private
    v_rkey25:integer;
    StepIncNum:integer;
    procedure LoadParams; //�������
    procedure InheriteParams(DrillPms:boolean); //�̳в���
    procedure GenerateBOM(DATASET:TADoDataSet);//����BOM,DATASET:���BOM0026��DATASET
    function CalcBomPartQty(var ExprStr:string;AStepNumber: Integer):double;//����BOM��������
    function Update_Expr_Param_Value(DAtaSet:TCustomADODataSet;var Exprstr:string;AStep: Integer = -1):boolean;
  public
    v_Batch_State:Boolean;//�������±�־��Ĭ��Ϊfalse��ֻ�е��ڼ̳в���������BOM��ʱ�򣬲�Ϊtrue��Ϊ�����������������ʱ����ص�DataSet��Щ�¼�����Ҫ������
    v_EnterMode:byte; 
    procedure Enter(EditMode:byte;rKey25:integer);
  end;

var
  frmBom_Edit: TfrmBom_Edit;

implementation
uses main_127,common,ConstVar,MyClass,ProcessShow, Dm,PickBomPart;
{$R *.dfm}

{ TfrmBom_Edit }

procedure TfrmBom_Edit.Enter(EditMode: byte; rKey25: integer);
begin
  try
    frmProcessShow := TfrmProcessShow.Create(Application);
    frmProcessShow.Show;
    StepIncNum := 100 div 10;
    frmProcessShow.IncStep(StepIncNum,'���ڼ�������...');
    v_rkey25:=rkey25;
    v_EnterMode:=EditMode;
    v_Batch_State:=false;
    //1.�����еĹ���BOM�����������,���û��,����ʾ
    //��BOM��������
    with dmcon do begin
      frmProcessShow.IncStep(StepIncNum,'�����ж�BOM����...');
      adsMatrlGroupList.Close;
      adsMatrlGroupList.Parameters[0].Value := rKey25;
      adsMatrlGroupList.Open;
      if adsMatrlGroupList.IsEmpty then
      begin
        ShowMsg('�ò�Ʒû�н���BOM����,��ע��!',1);
        abort;
      end;
      //��ȡ����ֵ���
      frmProcessShow.IncStep(StepIncNum,'���ڼ��ز���ֵ���...');
      aqParamValueList.Close;
      aqParamValueList.Open;
      //��BOM������497
      frmProcessShow.IncStep(StepIncNum,'���ڼ���BOM������...');
      adsBOMParams.Close;
      adsBOMParams.Parameters[0].Value := rkey25;
      adsBOMParams.Open;
    //��ȡ����BOM�������Ĳ���
      frmProcessShow.IncStep(StepIncNum,'���ڼ���BOM�������Ĳ���...');
      aqGroupParam.Close;
      aqGroupParam.Parameters[0].Value := v_rKey25;
      aqGroupParam.open;
      //��ȡ�����Ƴ̲���
      frmProcessShow.IncStep(StepIncNum,'���ڼ��ع����Ƴ̲���...');
      aqIESParams.Close;
      aqIESParams.Parameters[0].Value := v_rKey25;
      aqIESParams.open;
      //��ȡ���������
      frmProcessShow.IncStep(StepIncNum,'���ڼ��ػ�ȡ���������...');
      aqDrillersValue.Close;
      aqDrillersValue.Parameters[0].Value := v_rKey25;
      aqDrillersValue.open;
      //��ȡ����������
      frmProcessShow.IncStep(StepIncNum,'���ڼ��ز�����...');
      adsParamsInfo.Close;
      adsParamsInfo.Open;
      //��BOM�Ĳ�����Ϣ��
      frmProcessShow.IncStep(StepIncNum,'���ڼ���BOM���ϱ�...');
      aqBOMCalcTmp.Close;
      aqBOMCalcTmp.Parameters[0].Value := rKey25;
      aqBOMCalcTmp.Open;
      aqBOMCalcTmp.FieldByName('Mrkey').ReadOnly := false;
      aqBOMCalcTmp.FieldByName('INV_Name').ReadOnly := false;
      //��BOM���ϱ�0026
      frmProcessShow.IncStep(StepIncNum,'���ڼ���BOM���ϱ�...');
      adsBOM.Close;
      adsBOM.Parameters[0].Value := rKey25;
      adsBOM.open;
    end;

    if EditMode = em_edit then //��BOM,Ҫ����
    begin
     //1.��������BOM������data0497��
      if dmcon.adsProdLists.IsEmpty then
      begin
         frmProcessShow.IncStep(StepIncNum,'���ڼ���BOM����...');
         LoadParams;
      end;
    end;
    dmcon.adsBOMParams.Sort:='Route_step_ptr,Seq_no ASC ';
    btnGetParams.Enabled := v_EnterMode <> em_browse;
    SpeedButton3.Enabled:=btnGetParams.Enabled;
    btnExecBOM.Enabled := v_EnterMode <> em_browse;
    DBGrid1.ReadOnly := not btnExecBOM.Enabled;
    DBGridEh1.ReadOnly:=DBGrid1.ReadOnly;
  finally
    frmProcessShow.hide;
    frmProcessShow.Free;
    frmProcessShow:= nil;
  end;
  ShowModal;
end;

procedure TfrmBom_Edit.LoadParams;
var
  Driller_Rec_NO:integer;
begin
  with dmcon do begin
    adsMatrlGroupList.DisableControls;
    try
      Driller_Rec_NO:=0;
      adsMatrlGroupList.First;
  //1.ÿ������ѭ��,
      while not adsMatrlGroupList.Eof do begin
      //2.����ÿ������Ĳ������,�Ӳ�������Ĳ�����499�и��Ʋ�����497��
        aqGroupParam.Filtered := false;
        aqGroupParam.Filter := 'Inv_Group_Ptr='+adsMatrlGroupList.FieldByName('INV_GROUP_PTR').AsString;
        aqGroupParam.Filtered := true;
        if adsMatrlGroupList.FieldByName('Spec_rKey').AsInteger = 1 then //�ò������������,��ôҪ��������л�ȡ����
        begin
          Inc(Driller_Rec_NO);
          aqDrillersValue.MoveBy(Driller_Rec_NO-aqDrillersValue.RecNo);
        end;
        while not aqGroupParam.Eof do
        begin
          if not adsBOMParams.Locate('PARAMETER_PTR',aqGroupParam.FieldByName('PARAMETER_PTR').AsString,[]) then
          begin
            adsBOMParams.Append;
            adsBOMParams.FieldByName('PARAMETER_PTR').AsString := aqGroupParam.FieldByName('PARAMETER_PTR').AsString;
            adsBOMParams.FieldByName('SEQ_NO').AsString := aqGroupParam.FieldByName('SEQ_NO').AsString;
            adsBOMParams.FieldByName('PARAMETER_VALUE').AsString := aqGroupParam.FieldByName('DEF_Value').AsString;
            adsBOMParams.Post;
          end;
          aqGroupParam.next;
        end;
        adsMatrlGroupList.Next;
      end;
    finally
      adsMatrlGroupList.first;
      adsMatrlGroupList.EnableControls;
    end;
  end;
end;

procedure TfrmBom_Edit.btnGetParamsClick(Sender: TObject);
begin
  if not MSG_Dlg_ASK('�̳в������������в���ֵ��������','��ʾ',1) then exit;
  try
    v_Batch_State:=true;
    frmProcessShow := TfrmProcessShow.Create(Application);
    frmProcessShow.Show;
    StepIncNum := 100 div dmcon.adsMatrlGroupList.RecordCount;
    InheriteParams(Boolean(TComponent(Sender).Tag));
  finally
    v_Batch_State:=false;
    frmProcessShow.hide;
    frmProcessShow.Free;
    frmProcessShow:= nil;
  end;
end;

procedure TfrmBom_Edit.InheriteParams(DrillPms:boolean);
var
  Driller_Rec_NO:integer;
  bFind:boolean;
begin
  with dmcon do begin
    frmProcessShow.IncStep(StepIncNum,'���ڴ�������������������...');
    adsMatrlGroupList.DisableControls;
    try
      DBGridEh1.DataSource:=nil; 
      Driller_Rec_NO:=0;
      if DrillPms then adsMatrlGroupList.Filter:='Spec_rKey=1';   
      adsMatrlGroupList.First;
  //1.ÿ������ѭ��,
      while not adsMatrlGroupList.Eof do begin
      //2.����ÿ������Ĳ������,�Ӳ�������Ĳ�����499�и��Ʋ�����497��
        frmProcessShow.IncStep(StepIncNum,'���ڴ���'+adsMatrlGroupList.FieldByName('DEPT_CODE').asstring+','+adsMatrlGroupList.FieldByName('BOM_NAME').asstring+'����������...');
        aqGroupParam.Filtered := false;
        aqGroupParam.Filter := 'Inv_Group_Ptr='+adsMatrlGroupList.FieldByName('INV_GROUP_PTR').AsString;
        aqGroupParam.Filtered := true;
        if adsMatrlGroupList.FieldByName('Spec_rKey').Asstring = '1' then //�ò������������,��ôҪ��������л�ȡ����
        begin
          Inc(Driller_Rec_NO);
          aqDrillersValue.MoveBy(Driller_Rec_NO-aqDrillersValue.RecNo);
        end;

        while not aqGroupParam.Eof do begin
          bFind:=false;
          if adsBOMParams.IsEmpty then
            bFind:= false
          else
            bFind:= adsBOMParams.Locate('SOURCE_PTR;ROUTE_STEP_PTR;PARAMETER_PTR',VarArrayOf([adsMatrlGroupList.fieldByName('MGRkey').AsString,adsMatrlGroupList.fieldByName('EFRkey').AsString,aqGroupParam.FieldByName('PARAMETER_PTR').AsString]),[loCaseInsensitive]);
          if not bFind then
          begin
            adsBOMParams.Append;
            adsBOMParams.FieldByName('PARAMETER_PTR').AsString := aqGroupParam.FieldByName('PARAMETER_PTR').AsString;
            adsBOMParams.FieldByName('SEQ_NO').AsString := aqGroupParam.FieldByName('SEQ_NO').AsString;
            adsBOMParams.FieldByName('PARAMETER_VALUE').AsString := aqGroupParam.FieldByName('DEF_Value').AsString;
           //3.���������,�ٶ�ÿ������������Ӧ�Ĺ����Ƴ̲���494,�����,��Ѳ���ֵȡ����.
//            if aqIESParams.Locate('PARAMETER_PTR',VarArrayOf([aqGroupParam.FieldByName('PARAMETER_PTR').AsString]),[loCaseInsensitive]) then
//              adsBOMParams.FieldByName('PARAMETER_VALUE').AsString := aqIESParams.FieldByName('PARAMETER_VALUE').AsString;

              if aqIESParams.Locate('Parameter_ptr;step_number',VarArrayOf([aqGroupParam.FieldByName('PARAMETER_PTR').AsInteger,adsMatrlGroupList.fieldbyname('step_number').AsInteger]),[loCaseInsensitive]) then //�Ƴ̲���
                adsBOMParams.FieldByName('PARAMETER_VALUE').AsString := aqIESParams.FieldByName('PARAMETER_VALUE').AsString;

            //4.�������������,��ô�ʹ�������ȡ��ֵ
            if uppercase(trim(adsBOMParams.FieldByName('spec_rKey').AsString)) = 'X' then //����ֱ��
              if aqDrillersValue.RecNo <> aqDrillersValue.RecordCount then //���һ����¼˵�������������ķ�Χ
                if IS_Float(aqDrillersValue.FieldByName('DRILL_DIA').AsString) then
                  adsBOMParams.FieldByName('PARAMETER_VALUE').AsString := aqDrillersValue.FieldByName('DRILL_DIA').AsString;
            if uppercase(trim(adsBOMParams.FieldByName('spec_rKey').AsString)) = 'Y' then //�������
              if aqDrillersValue.RecNo <> aqDrillersValue.RecordCount then //���һ����¼˵�������������ķ�Χ
              begin
                if not (Pos('TOTAL',UpperCase(aqDrillersValue.FieldByName('unit').AsString)) > 0 ) then
                begin
                  if (trim(aqDrillersValue.FieldByName('Panel_A').AsString)<>'') and IS_Float(aqDrillersValue.FieldByName('DRILL_DIA').AsString) then
                    adsBOMParams.FieldByName('PARAMETER_VALUE').AsString := aqDrillersValue.FieldByName('Panel_A').AsString
                  else if (trim(aqDrillersValue.FieldByName('Panel_B').AsString)<>'') and IS_Float(aqDrillersValue.FieldByName('DRILL_DIA').AsString) then
                    adsBOMParams.FieldByName('PARAMETER_VALUE').AsString := aqDrillersValue.FieldByName('Panel_B').AsString ;  //B��Ҫ���µĲ�Ʒ����
                end;
              end;
               // if IS_Float(aqDrillersValue.FieldByName('DRILL_DIA').AsString) then   //�ɱ���A���ÿPCS����Ϊ��׼
                //  adsBOMParams.FieldByName('PARAMETER_VALUE').AsString := aqDrillersValue.FieldByName('Panel_A').AsString;
            adsBOMParams.Post;
          end
          else //�Ѿ����ڵĲ���
          begin
            //�޸ı�ע��ԭ�������Ѿ����ڵĲ����Ͳ����»�ü̳еĲ���ֵ�����ڸ�Ϊ���в�����Ҫ���´�499���
            begin
              adsBOMParams.edit;
              if adsBOMParams.FieldByName('SEQ_NO').IsNull then
                adsBOMParams.FieldByName('SEQ_NO').Asinteger:= aqGroupParam.FieldByName('SEQ_NO').Asinteger;
              //��ò���������
              adsBOMParams.FieldByName('PARAMETER_VALUE').Asstring := aqGroupParam.FieldByName('DEF_Value').AsString;
              //����Ƴ̲�����,���ȡ�Ƴ̲���
              if aqIESParams.Locate('Parameter_ptr;step_number',VarArrayOf([adsBOMParams.FieldByName('PARAMETER_PTR').AsInteger,adsMatrlGroupList.fieldbyname('step_number').AsInteger]),[loCaseInsensitive]) then //�Ƴ̲���
                adsBOMParams.FieldByName('PARAMETER_VALUE').AsString := aqIESParams.FieldByName('PARAMETER_VALUE').AsString;
              //���������,��ô�ʹ��������ȡ��
              if uppercase(trim(adsBOMParams.FieldByName('spec_rKey').AsString)) = 'X' then //����ֱ��
                if aqDrillersValue.RecNo <> aqDrillersValue.RecordCount then //���һ����¼˵�������������ķ�Χ
                  if IS_Float(aqDrillersValue.FieldByName('DRILL_DIA').AsString) then
                    adsBOMParams.FieldByName('PARAMETER_VALUE').AsString := aqDrillersValue.FieldByName('DRILL_DIA').AsString;
              if uppercase(trim(adsBOMParams.FieldByName('spec_rKey').AsString)) = 'Y' then //�������
                if aqDrillersValue.RecNo <> aqDrillersValue.RecordCount then //���һ����¼˵�������������ķ�Χ
                begin
                  if not (Pos('TOTAL',UpperCase(aqDrillersValue.FieldByName('unit').AsString)) >0 ) then
                  begin
                    if (trim(aqDrillersValue.FieldByName('Panel_A').AsString)<>'') and IS_Float(aqDrillersValue.FieldByName('DRILL_DIA').AsString) then
                      adsBOMParams.FieldByName('PARAMETER_VALUE').AsString := aqDrillersValue.FieldByName('Panel_A').AsString
                    else if (trim(aqDrillersValue.FieldByName('Panel_B').AsString)<>'') and IS_Float(aqDrillersValue.FieldByName('DRILL_DIA').AsString) then
                      adsBOMParams.FieldByName('PARAMETER_VALUE').AsString := aqDrillersValue.FieldByName('Panel_B').AsString ;
                  end;
                end;
              adsBOMParams.Post;
            end ;
          end;
          aqGroupParam.next;
        end;
        adsMatrlGroupList.Next;
      end;
    finally
      adsMatrlGroupList.Filter:='';
      aqGroupParam.Filter := '';
      aqGroupParam.Filtered := false;
      DBGridEh1.DataSource:=dsBOMParams;
      adsMatrlGroupList.first;
      adsMatrlGroupList.EnableControls;
    end;
  end;
end;

procedure TfrmBom_Edit.btnExitClick(Sender: TObject);
begin
  if dmcon.adsBOM.State in dsEditModes then
    dmcon.adsBOM.Cancel;
  close;
end;

procedure TfrmBom_Edit.btnExecBOMClick(Sender: TObject);
begin
  try
    frmProcessShow := TfrmProcessShow.Create(Application);
    frmProcessShow.Show;
    StepIncNum := 100 div (dmcon.adsMatrlGroupList.RecordCount+3);

    v_Batch_State:=true;
    dmcon.aqEngTable.Close;
    dmcon.aqEngTable.Open;
  //ȫ�ֲ���
    dmcon.aqPubParams.Close;
    dmcon.aqPubParams.Parameters[0].Value := v_rKey25;
    dmcon.aqPubParams.Open;
    dmcon.aqGroupParam.Filter := '';
    dmcon.aqGroupParam.Filtered := false;
    spbtnSave.Enabled:=true;
    GenerateBOM(dmcon.adsBOM);
  finally
    v_Batch_State:=false;
    frmProcessShow.hide;
    frmProcessShow.Free;
    frmProcessShow:= nil;
    if not dmcon.adsBOM.IsEmpty then
    begin
      dmcon.adsBOM.Edit;//Ϊ�˴�����ʾ�����ֶ�
      dmcon.adsBOM.Post;
    end;
    PageControl1.ActivePageIndex :=1;
  end;
end;

procedure TfrmBom_Edit.GenerateBOM(DATASET:TADoDataSet);
var
  sqlstr,subSql,ExprStr,F01,F02,F03:string;
  RecNO,istep:integer;
begin
//����:
//���0026��,
  frmProcessShow.IncStep(StepIncNum,'���ڲ��ҹ������...');
  MyDataClass.DeleteTable(DataSet);

//1.ѭ������,
//3.������ÿ���������
  with dmcon do begin
    adsMatrlGroupList.DisableControls;
    adsBOMParams.DisableControls;
    try
  //1.ÿ������ѭ��,
      try
        adsMatrlGroupList.First;
        istep:=1;
        while not adsMatrlGroupList.Eof do
        begin
          if trim(adsMatrlGroupList.fieldbyName('FORMULA').Asstring)='' then
          begin
            showmessage(inttostr(istep)+'���裺'+#13+'�������Ϲ�ʽ����Ϊ��,����...');
            abort;
          end;

          frmProcessShow.IncStep(StepIncNum,'���ڴ�����'+adsMatrlGroupList.fieldByName('INV_GROUP_PTR').Asstring+'...');

          //2.����ÿ���������õĲ���,�����ϱ�0017�ж�λÿ�����,
          adsBOMParams.First;
          RecNO:=0;
          Sqlstr:='select rkey,inv_part_number from data0017 where group_ptr='+QuotedStr(adsMatrlGroupList.fieldByName('INV_GROUP_PTR').Asstring);
          //ѭ��BOM�Ĳ���
          subSql:='';
          while not adsBOMParams.eof do
          begin
           if trim(adsBOMParams.FieldByName('parameter_value').AsString) <> '' then
            begin
              if aqGroupParam.Locate('INV_Group_ptr;SEQ_NO;Parameter_Ptr',varArrayOf([adsMatrlGroupList.FieldByName('INV_GROUP_PTR').value,adsBOMParams.FieldByName('Seq_no').value,adsBOMParams.FieldByName('Parameter_Ptr').value]),[loCaseInsensitive]) then
              begin
                if aqGroupParam.FieldByName('ttype').Asinteger= 0 then //0���ϲ���,1��Ʒ����
                begin
                  inc(RecNo);
                  Subsql:= Subsql + ' and ies_parameter_value'+IntToStr(RecNo)+'='+QuotedStr(trim(adsBOMParams.FieldByName('parameter_value').AsString));
                end;
              end;
            end;
            adsBOMParams.Next;
          end;

          if (adsMatrlGroupListrequired.Value='Y') and (SubSql='') then
          begin
            showmessage(inttostr(istep)+'��������в���,����ֵ����Ϊ��...');
            abort;
          end;

          if SubSql <>'' then
          begin
            aqMaterials.close;
            aqMaterials.SQL.Clear;
            aqMaterials.SQL.Add(sqlstr+SubSql);

            try
            aqMaterials.open;
            except
              showmessage(inttostr(istep)+'����'+'-'+inttostr(RecNo)+'����ֵ����'+#13+sqlstr+SubSql);
              abort;
            end;
            //0017���Ҳ���
            if aqMaterials.IsEmpty then
            begin
              ShowMsg(trim(adsMatrlGroupList.fieldbyName('Dept_Code').AsString)+'-'+trim(adsMatrlGroupList.fieldbyName('BOM_NAME').AsString)+ ' û���ҵ�ƥ��Ĳ���,���������ֵ!',1);
              abort;
            end
            else if aqMaterials.RecordCount > 1 then
            begin
              ShowMsg('�ʺ� '+trim(adsMatrlGroupList.fieldbyName('Dept_Code').AsString)+'-'+trim(adsMatrlGroupList.fieldbyName('BOM_NAME').AsString)+ ' �Ĳ��ϲ�ֹһ��,����!',1);
              abort;
            end
            else
            begin
              DataSet.Append;
              DataSet.FieldByName('Manu_BOM_Ptr').Value := v_rKey25;
              DataSet.FieldByName('Dept_Ptr').Value := adsMatrlGroupList.fieldbyName('rKey').value;
              DataSet.FieldByName('Inventory_Ptr').Value := aqMaterials.fieldbyName('rKey').value;
              DataSet.FieldByName('Route_Step_No').Value := adsMatrlGroupList.fieldbyName('STEP_NUMBER').value;
              DataSet.FieldByName('Doc_Flag').Value := adsMatrlGroupList.fieldbyName('Doc_Flag').value;
              frmProcessShow.IncStep(StepIncNum,'���ڼ���BOM��������...');
              ExprStr:=' '+trim(adsMatrlGroupList.fieldbyName('FORMULA').Asstring)+' ';
              try
                try
//                  aqIESParams.Filter := 'step_number=' + adsMatrlGroupList.fieldbyname('step_number').AsString;
//                  aqIESParams.Filtered := True;
                  DataSet.FieldByName('Qty_Bom').Value := CalcBomPartQty(ExprStr,adsMatrlGroupList.fieldbyname('step_number').AsInteger);
                finally
                  //aqIESParams.Filtered := False;
                end;
              except
                ShowMsg(inttostr(istep)+'����������ʽ�������:'+trim(adsMatrlGroupList.fieldbyName('FORMULA').Asstring),1);
                abort;
              end;
              DataSet.Post;
            end;
          end;
          adsMatrlGroupList.Next;
          inc(istep);
        end;
      except
        try
          if DataSet.RecordCount > 0 then DataSet.CancelBatch(arAll);
        except
        end;
        if spbtnSave.Enabled then  spbtnSave.Enabled:= false;
        ShowMsg('����BOMʧ��!',1);
      end;
    finally
      adsMatrlGroupList.first;
      adsMatrlGroupList.EnableControls;
      adsBOMParams.EnableControls;
    end;
  end;
end;

function TfrmBom_Edit.CalcBomPartQty(var ExprStr:string;AStepNumber: Integer): double;
var
  i,j:integer;
  X,Y:string;
  rkey,s_Y,s_X,d_Y,d_X:String;
  x_DataType,y_DataType:byte;
  TmpDataSet:TAdoDataSet;
  rslt_value:variant;
  Tmpstr:string;
begin
//���̱�
  with dmcon do begin
    Tmpstr:=ExprStr;
    //�ӹ�ʽ���滻��BOM,PD�ַ������ڼ��㹫ʽ.
    ExprStr:= StringReplace(ExprStr,' BOM.',' ',[rfReplaceAll]);
    ExprStr:= StringReplace(ExprStr,' PD.',' ',[rfReplaceAll]);
    try
      TmpDataSet:= TADoDataSet.Create(self);
      TmpDataSet.LockType := ltBatchOptimistic;
      TmpDataSet.Clone(adsParamsInfo);
    //1.����ʽ�еĹ��̱�,
      aqEngTable.First;
      while not aqEngTable.Eof do
      begin
        i:= Pos(' '+trim(aqEngTable.fieldbyName('FXY').AsString)+' ',ExprStr);
        if i > 0 then //�ڹ�ʽ���ҵ��˹��̱�
        begin
          rKey:= aqEngTable.fieldbyName('rKey').AsString;
//          if rkey = '79' then
//          begin
//            aqIESParams.First;
//            while not aqIESParams.Eof do
//            begin
//              ShowMessage(aqIESParams.FieldByName('Parameter_ptr').AsString +'   ' + aqIESParams.FieldByName('Parameter_value').AsString);
//              aqIESParams.Next;
//            end;
//
//if aqIESParams.Locate('Parameter_ptr',581,[loCaseInsensitive]) then //�Ƴ̲���
//ShowMessage(aqIESParams.FieldByName('Parameter_ptr').AsString +'   ' + aqIESParams.FieldByName('Parameter_value').AsString);
//
//            Sleep(1);
//          end;
          x:= aqEngTable.fieldbyName('FX').AsString;
          y:= aqEngTable.fieldbyName('FY').AsString;
          s_x:='';s_y:='';d_x:='1';d_y:='1';
          if x <> '' then
          begin
            if TmpDataSet.Locate('rKey',x,[loCaseInsensitive]) then
              x_DataType:= TmpDataSet.fieldByName('Data_Type').AsInteger
            else
            begin
              ShowMsg('û���ҵ����̱�:'+trim(aqEngTable.fieldbyName('FXY').AsString)+'��X��������ֵ',1);
              abort;
            end;
            if aqPubParams.Locate('Parameter_ptr',x,[loCaseInsensitive]) then  //ȫ�ֲ���
              s_x:= aqPubParams.FieldByName('Parameter_value').AsString
            else if adsBOMParams.Locate('Parameter_ptr',x,[loCaseInsensitive]) then //���ϲ���
              s_x:= adsBOMParams.FieldByName('Parameter_value').AsString
            else if aqIESParams.Locate('Parameter_ptr;step_number',VarArrayOf([x,AStepNumber]),[loCaseInsensitive]) then //�Ƴ̲���
              s_x:= aqIESParams.FieldByName('Parameter_value').AsString
            else begin
               dmcon.tmp1.Close;
               dmcon.tmp1.SQL.Text:='select parameter_name+'' ''+parameter_desc from data0278 where rkey='+x;
               dmcon.tmp1.Open;
               ShowMsg('���󹤳̲���:'+trim(dmcon.tmp1.fields[0].AsString)+'�ڱ���Ʒ�в�����',1);
               dmcon.tmp1.Close;
               abort;
            end;
            if trim(s_x) = '' then
            begin
              ShowMsg(trim(aqIESParams.fieldbyName('Parameter_Name').AsString)+'����û�и�ֵ',1);
              abort;
            end;
            if x_DataType= 1 then //����
            begin
              d_x:=s_x;
              s_x:='';
            end;
          end;
          if y <> '' then
          begin
            if TmpDataSet.Locate('rKey',y,[loCaseInsensitive]) then
              y_DataType:= TmpDataSet.fieldByName('Data_Type').AsInteger
            else
            begin
              ShowMsg('û���ҵ����̱�:'+trim(aqEngTable.fieldbyName('Eng_Table_Desc').AsString)+'��y��������ֵ',1);
              abort;
            end;
            if aqPubParams.Locate('Parameter_ptr',y,[loCaseInsensitive]) then  //ȫ�ֲ���
              s_y:= aqPubParams.FieldByName('Parameter_value').AsString
            else if aqIESParams.Locate('Parameter_ptr',y,[loCaseInsensitive]) then //�Ƴ̲���
              s_y:= aqIESParams.FieldByName('Parameter_value').AsString
            else if adsBOMParams.Locate('Parameter_ptr',y,[loCaseInsensitive]) then //BOM����
              s_y:= adsBOMParams.FieldByName('Parameter_value').AsString
            else begin
               dmcon.tmp1.Close;
               dmcon.tmp1.SQL.Text:='select parameter_name+'' ''+parameter_desc from data0278 where rkey='+y;
               dmcon.tmp1.Open;
               ShowMsg('���󹤳̲���:'+trim(dmcon.tmp1.fields[0].AsString)+'�ڱ���Ʒ�в�����',1);
               dmcon.tmp1.Close;
               abort;
            end;
            if trim(s_y) = '' then
            begin
              ShowMsg(trim(aqIESParams.fieldbyName('Parameter_Name').AsString)+'����û�и�ֵ',1);
              abort;
            end;
            if y_DataType= 1 then //����
            begin
              d_y:=s_y;
              s_y:='';
            end;
          end;

          rslt_value:=Calc_Eng_Table(rKey,s_x,s_y,d_x,d_y);//���㲢���ع��̱���ֵ

        //  rslt_value:=MyDataClass.Get_Sql_Value('Exec WZPR085 ' + rKey + ',' + QuotedStr(s_x) + ',' + QuotedStr(s_y) + ',' + d_x + ',' + d_y;);

          if rslt_value = NULL then
          begin
            ShowMsg('�����쳣��û��ȡ�����̱���Ӧ����ֵ��'+trim(aqEngTable.fieldbyName('FXY').AsString),1);
            abort;
          end;

          if aqEngTable.FieldByName('data_type').AsInteger=1 then//������
            ExprStr:= StringReplace(ExprStr,' '+trim(aqEngTable.fieldbyName('FXY').AsString)+' ',rslt_value,[rfReplaceAll])
          else
            ExprStr:= StringReplace(ExprStr,' '+trim(aqEngTable.fieldbyName('FXY').AsString)+' ',QuotedStr(rslt_value),[rfReplaceAll])
        end;
        aqEngTable.next;
      end;

  //4.����ȫ�ֲ���
      Update_Expr_Param_Value(aqPubParams,ExprStr,-1);
  //3.������� ����
      Update_Expr_Param_Value(adsBOMParams,ExprStr,-1);
  //2.�����Ƴ̲���
      Update_Expr_Param_Value(aqIESParams,ExprStr,AStepNumber);
  //5.���㹫ʽ
      if not Calc_Expr_Parma(ExprStr,adsMatrlGroupList.Connection,result) then
      begin
        ShowMsg('�������,��ʽ:'+tmpstr+#13+#10+',��ֵ��:'+ExprStr,1);
        abort;
      end;
    finally
      TmpDataSet.Close;
      TmpDataSet.free;
    end;
  end;
end;

function TfrmBom_Edit.Update_Expr_Param_Value(DAtaSet:TCustomADODataSet;var Exprstr:string;AStep: Integer = -1):boolean;
begin
  DAtaSet.first;
  while not DAtaSet.eof do
  begin
    if Pos(' '+trim(DAtaSet.fieldbyName('Parameter_name').AsString)+' ',ExprStr) > 0 then
    begin
      if AStep <> - 1 then
      begin
        if DAtaSet.FieldByName('step_number').AsInteger <> AStep then
        begin
          DAtaSet.next;
          Continue;
        end;
      end;
      if trim(DAtaSet.fieldbyName('Parameter_value').AsString)='' then
      begin
        if DAtaSet.fieldbyName('Data_Type').AsInteger = 1 then //����
          ExprStr:= StringReplace(ExprStr,' '+trim(DAtaSet.fieldbyName('Parameter_name').AsString)+' ',' '+'0'+' ',[rfReplaceAll])
        else
          ExprStr:= StringReplace(ExprStr,' '+trim(DAtaSet.fieldbyName('Parameter_name').AsString)+' ',' '+QuotedStr('')+' ',[rfReplaceAll]);
      end;

       if DAtaSet.fieldbyName('Data_Type').AsInteger = 1 then //����
         ExprStr:= StringReplace(ExprStr,' '+trim(DAtaSet.fieldbyName('Parameter_name').AsString)+' ',' '+trim(DAtaSet.FieldByName('Parameter_value').AsString)+' ',[rfReplaceAll])
       else
         ExprStr:= StringReplace(ExprStr,' '+trim(DAtaSet.fieldbyName('Parameter_name').AsString)+' ',' '''+trim(DAtaSet.FieldByName('Parameter_value').AsString)+''' ',[rfReplaceAll]);
      // break;
    end;
    DAtaSet.next;
  end;
end;

procedure TfrmBom_Edit.SpeedButton1Click(Sender: TObject);
begin
  Export_dbGrid_to_Excel(dbGrid1,'����')
end;

procedure TfrmBom_Edit.DBGridEh1CellClick(Column: TColumnEh);
var
  sDataType:string;
begin
  if Column.Index <> 5 then DBGridEh1.SelectedIndex := 5; //Column. .Index :=5;
{  aqParamValueList.Filtered := false;
  aqParamValueList.Filter := 'parameter_ptr='+adsBOMParams.fieldByName('parameter_ptr').AsString;
  aqParamValueList.Filtered := true;
  DBGridEh1.Columns[5].PickList.clear;
  aqParamValueList.first;
  while not aqParamValueList.Eof do begin
    DBGridEh1.Columns[5].PickList.Add(trim(aqParamValueList.FieldByName('TValue').AsString));
    aqParamValueList.next;
  end;}
end;

procedure TfrmBom_Edit.DBGridEh1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (ssCtrl in Shift) and (Key = VK_DELETE) then
    abort;
  if Key = VK_Insert then
    abort;
  if Key=VK_DOWN then
  begin
    Key:=0;
    TDBGridEH(Sender).DataSource.DataSet.Next
  end
end;

procedure TfrmBom_Edit.spbtnSaveClick(Sender: TObject);
begin
  //�Ƿ���������û�з�������ʾ
  dmcon.adsBOM.DisableControls;
  try
    dmcon.adsBOM.First;
    while not dmcon.adsBOM.Eof do
    begin
      if dmcon.adsBOM.FieldByName('INVENTORY_PTR').AsInteger <> 0 then
      begin
        dmcon.tmp.Close;
        dmcon.tmp.SQL.Clear;
        dmcon.tmp.SQL.Add('select 1 from data0207 where INVENTORY_PTR = '+ dmcon.adsBOM.FieldByName('INVENTORY_PTR').AsString );
        dmcon.tmp.SQL.Add(' and TDATE > (getdate() - 92)');
        dmcon.tmp.Open;
        if dmcon.tmp.IsEmpty then
        begin
          ShowMessage('��ʾ:  ���� ' + dmcon.adsBOM.fieldbyname('PartName').AsString + ' ������������ ���Ϸ��ż�¼');
        end;
      end;
      dmcon.adsBOM.Next;
    end;
  finally
    dmcon.adsBOM.EnableControls;
  end;

  if not dmcon.SaveData then
    ShowMsg('����BOM����ʧ��!',1);
  close;
end;

procedure TfrmBom_Edit.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  frmBom_Edit:= nil;
end;

procedure TfrmBom_Edit.N1Click(Sender: TObject);
begin
  with TfrmPickBOMPart.Create(Application)do
  try
    Enter('',v_rkey25);
//    ComboBox1.ItemIndex:= ComboBox1.Items.IndexOf(trim(dmcon.adsBOM.FieldByName('DEPT_Code').Asstring));
    if Showmodal = mrok then
    begin
      dmcon.adsBOM.Append;
      spbtnSave.Enabled:= true;
      dmcon.adsBOM.FieldByName('INVENTORY_PTR').Value :=edtPartNo.Tag;
      dmcon.adsBOM.FieldByName('QTY_BOM').Value :=edtQty.Text;
      if adsRoute.Locate('DEPT_CODE',ComboBox1.Text,[loCaseInsensitive]) then
      begin
        dmcon.adsBOM.FieldByName('DEPT_PTR').Value :=adsRoute.FieldByName('rKey').AsString;
        dmcon.adsBOM.FieldByName('Route_Step_No').Value :=adsRoute.fieldbyName('Step_Number').value;
        if CheckBox1.Checked then
          dmcon.adsBOM.FieldByName('Doc_Flag').Value :='Y'
        else
          dmcon.adsBOM.FieldByName('Doc_Flag').Value :='N';
        dmcon.adsBOM.FieldByName('Manu_BOM_Ptr').Value := v_rKey25;
      end;
    end;
  finally
    free;
    N2.Enabled:=not DBGrid1.DataSource.DataSet.IsEmpty;
    N3.Enabled:=N2.Enabled;
  end;
end;

procedure TfrmBom_Edit.N3Click(Sender: TObject);
begin
  with TfrmPickBOMPart.Create(Application)do
  try
    Enter(dmcon.adsBOM.FieldByName('PartNo').Value,-1);
    labelroute.Caption := '����:'+dmcon.adsBOM.FieldByName('DeptName').Asstring+'      ����:'+ dmcon.adsBOM.FieldByName('ROUTE_STEP_NO').Asstring;
    CheckBox1.Checked := dmcon.adsBOM.FieldByName('Doc_Flag').Value ='Y';
    edtQty.text := dmcon.adsBOM.FieldByName('QTY_BOM').Asstring;
    if Showmodal = mrok then
    begin
      if not adsPart.IsEmpty then
      begin
        if not dmcon.adsBOM.IsEmpty then
        begin
          dmcon.adsBOM.edit;
          spbtnSave.Enabled:= true;
          dmcon.adsBOM.FieldByName('INVENTORY_PTR').Value :=edtPartNo.Tag;
          dmcon.adsBOM.FieldByName('QTY_BOM').Value :=edtQty.Text;
          if CheckBox1.Checked then
            dmcon.adsBOM.FieldByName('Doc_Flag').Value :='Y'
          else
            dmcon.adsBOM.FieldByName('Doc_Flag').Value :='N';
        end;
      end;
    end;
  finally
    free;
  end;
end;

procedure TfrmBom_Edit.N2Click(Sender: TObject);
begin
  if Msg_Dlg_Ask('ȷ��ɾ����?','��ʾ',1) then
  begin
    dmcon.adsBOM.Delete;
    spbtnSave.Enabled:= true;
    N2.Enabled:=not DBGrid1.DataSource.DataSet.IsEmpty;
    N3.Enabled:=N2.Enabled;
  end
end;

procedure TfrmBom_Edit.PopupMenu1Popup(Sender: TObject);
begin
  if dmcon.Ftag = 5 then abort;
end;

procedure TfrmBom_Edit.DBGrid1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if ([ssShift, ssAlt]=Shift) and (key=83) then
    showmessage(dmcon.adsBOM.CommandText)

  else if (ssCtrl in Shift) and (Key = VK_DELETE) then
    abort;
  if Key = VK_Insert then
    abort;
  if Key=VK_DOWN then
  begin
    Key:=0;
    TDBGrid(Sender).DataSource.DataSet.Next
  end
end;

procedure TfrmBom_Edit.SpeedButton2Click(Sender: TObject);
var
  filter:string;
begin
  try
    dmcon.adsBOMParams.DisableControls;
    dmcon.adsBOMParams.Filtered:=false;
    if dmcon.adsBOMParams.State in dsEditModes then
      dmcon.adsBOMParams.Post;
    dmcon.adsBOMParams.UpdateBatch(arAll);
    dmcon.adsBOMParams.Filtered:=true;
    dmcon.adsBOMParams.EnableControls;
  except
    dmcon.adsBOMParams.Filtered:=true;
    dmcon.adsBOMParams.EnableControls;
    ShowMsg('�������ʧ��,����!',1);
  end;
end;

procedure TfrmBom_Edit.PageControl1Change(Sender: TObject);
begin
  N2.Enabled:=not DBGrid1.DataSource.DataSet.IsEmpty;
  N3.Enabled:=N2.Enabled;
end;

procedure TfrmBom_Edit.DBGridEh2DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumnEh;
  State: TGridDrawState);
begin
  if dmcon.adsMatrlGroupListrequired.Value='Y' then   //��ѡ����
    DBGridEh2.Canvas.Font.Color:=Clred;
  DBGridEh2.DefaultDrawColumnCell(Rect,DataCol,Column,State);
end;

procedure TfrmBom_Edit.DBGridEh2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if ([ssShift, ssAlt]=Shift) and (key=83) then
    showmessage(dmcon.adsMatrlGroupList.CommandText);
end;

procedure TfrmBom_Edit.FormShow(Sender: TObject);
begin
  if dmcon.FTag=5 then
  begin
    btnGetParams.Enabled:=false;
    SpeedButton3.Enabled:=false;
    SpeedButton2.Enabled:=false;
    btnExecBOM.Enabled:=false;
    spbtnSave.Enabled:=false;
  end;
end;

end.
