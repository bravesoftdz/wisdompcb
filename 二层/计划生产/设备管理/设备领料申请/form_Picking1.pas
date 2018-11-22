unit form_Picking1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, SingleDataSet_unt, ppDB,
  ppDBPipe, ppBands, ppPrnabl, ppClass, ppCtrls, ppCache, ppRelatv, ppProd,
  ppReport, ppComm, ppEndUsr, ImgList,  DB,
  DBClient, cds, Provider, ADODB, Grids, DBGridEh, ToolWin, ComCtrls,
  StdCtrls, RzPanel, ExtCtrls,  Menus, Buttons, RzButton;

type
  Tfrm_Picking1 = class(TSingleDataSet_frm)
    cds0034: TClientDataSet;
    cds0005: TClientDataSet;
    cds0094: TClientDataSet;
    cds0015: TClientDataSet;
    cds0417: TClientDataSet;
    cds0831: TClientDataSet;
    cds835: TClientDataSet;
    cds0017: TClientDataSet;
    cds0034CDSDesigner: TStringField;
    cds0034CDSDesigner2: TStringField;
    cds0005CDSDesigner: TStringField;
    cds0005CDSDesigner2: TStringField;
    cds0094CDSDesigner: TStringField;
    cds0094CDSDesigner2: TStringField;
    cds0015CDSDesigner: TStringField;
    cds0417CDSDesigner2: TStringField;
    cds0017CDSDesigner: TStringField;
    cds0017CDSDesigner2: TStringField;
    cds835CDSDesigner: TStringField;
    cds835CDSDesigner2: TStringField;
    cds0417CDSDesigner: TStringField;
    cdsMainCDSDesigner: TStringField;
    cdsMainCDSDesigner2: TDateTimeField;
    cdsMainCDSDesigner3: TDateTimeField;
    cdsMainCDSDesigner4: TStringField;
    cdsMainCDSDesigner5: TStringField;
    cdsMainCDSDesigner6: TStringField;
    cdsMainCDSDesigner7: TStringField;
    cdsMainCDSDesigner8: TStringField;
    cdsMainCDSDesigner9: TStringField;
    cdsMainCDSDesigner10: TStringField;
    cdsMainCDSDesigner11: TStringField;
    cdsMainCDSDesigner12: TStringField;
    cdsMainCDSDesigner13: TStringField;
    cdsMainCDSDesigner14: TStringField;
    cdsMainCDSDesigner15: TBooleanField;
    cdsMainCDSDesigner16: TStringField;
    cdsMainCDSDesigner17: TStringField;
    cdsMainCDSDesigner18: TStringField;
    cdsMainCDSDesigner19: TStringField;
    cdsMainCDSDesigner20: TDateTimeField;
    cdsMainCDSDesigner21: TStringField;
    cdsMainCDSDesigner22: TStringField;
    cdsMainCDSDesigner23: TStringField;
    cdsMainDEPT_PTR: TIntegerField;
    cdsMainCDSDesigner25: TStringField;
    cdsMainCDSDesigner26: TStringField;
    cdsMainCDSDesigner27: TStringField;
    cdsMainCDSDesigner28: TFloatField;
    cdsMainCDSDesigner30: TStringField;
    cdsMainCDSDesigner31: TStringField;
    cdsMainCDSDesigner32: TStringField;
    cdsMainCDSDesigner33: TStringField;
    cdsMainVMI: TStringField;
    cdsMainCDSDesigner34: TBCDField;
    cdsMainCDSDesigner35: TBCDField;
    cdsMainCDSDesigner36: TStringField;
    cdsMainCDSDesigner24: TStringField;
    cdsMainCDSDesigner29: TFloatField;
    Label13: TLabel;
    Label12: TLabel;
    BtFind: TSpeedButton;
    dteEnd: TDateTimePicker;
    dteBegin: TDateTimePicker;
    procedure FormCreate(Sender: TObject);
    procedure actFindExecute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure dteBeginChange(Sender: TObject);
    procedure dteEndChange(Sender: TObject);
    procedure BtFindClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
  private
    procedure RightsSetDataSetReadOnly;  override;
    { Private declarations }
  public
    { Public declarations }
  end;

var
  frm_Picking1: Tfrm_Picking1;

implementation

uses  DM_unt, PublicFile, form_Picking;//

{$R *.dfm}

procedure Tfrm_Picking1.RightsSetDataSetReadOnly;
begin

  begin
    cdsMain.ReadOnly:=True;
    DghMain.ReadOnly:=True;
  end;
end;

procedure Tfrm_Picking1.FormCreate(Sender: TObject);
begin
  inherited;
  dteBegin.Date:=Date-30;
  dteEnd  .Date:=Date;
  dteBeginChange(nil);
  dteEndChange(nil);
  BtFind.Click;
  NeedSave:=False;

  Find_DisplayFields:= VarArrayOf(['���쵥��','�������','���첿��','����',
  '��������','�����˴���','����Ա������','���״̬','����','���Ա������', '���Ա������',
  '�豸����С��','��Ӧ��','���ϱ���','��������/���','��������', '�յ���ҵ����������',
  'ά�޵�����','��������','��������','�豸���','�豸����','ʹ������','�Ƿ�VMI','��ע']);
  Find_FieldsName       := VarArrayOf(['��������/���']);
  Find_QueryFieldsName  := VarArrayOf(['[��������/���]']);

end;

procedure Tfrm_Picking1.actFindExecute(Sender: TObject);
begin
//  FindFormHeight:=520;

 inherited;                                          // '��ӡ��','���״̬','��������','��λ','ȷ��״̬'
 { if ShowfrmFindcds(Self,cdsMain,frmFindOutSQL,[],[],[],[],600) then
  begin
    cdsMain.Close;
    cdsMain.CommandText:=cdsMain.F_SQLSelectFrom+#13+'where '+ frmFindOutSQL;
    //ShowMessage(cdsMain.CommandText);
    cdsMain.Open;
  end; }

end;

procedure Tfrm_Picking1.FormShow(Sender: TObject);
begin
  inherited;
//  SetLength(Query_Info,11);
//  Query_Info[0]:=TQueryInfo.Create();
//  with Query_Info[0] do
//  begin
//    L_ListDataSetName       :=cds0005;
//    L_DropdownColumn        :='����Ա������';   //��Ա
//    L_ListResultField       :='Ա������';
//  end;
  var_DropDown_Info:=TDropDownInfo.Create();
  with var_DropDown_Info do
  begin
    L_SourceDataSet         :=cdsMain;
    L_GridName              :=DghMain;
    L_FindDataSet           :=cds0005;
    L_ColsInfo              :='Ա������/Ա������/100,Ա������/Ա������/150';
    L_DropdownColumn        :='�����˴���';   //�������̴���
    L_ListDataSetFilterField:='Ա������';
    L_ListResultField       :='Ա������';
    L_GetValueField         :='�����˴���';
    DropDownInfo_Init(var_DropDown_Info);
  end;
  DropDown_Info_List.Add(var_DropDown_Info) ;

  var_DropDown_Info:=TDropDownInfo.Create();
  with var_DropDown_Info do
  begin
    L_SourceDataSet         :=cdsMain;
    L_GridName              :=DghMain;
    L_FindDataSet           :=cds0005;
    L_ColsInfo              :='Ա������/Ա������/100,Ա������/Ա������/150';
    L_DropdownColumn        :='���Ա������';   //�������̴���
    L_ListDataSetFilterField:='Ա������';
    L_ListResultField       :='Ա������';
    L_GetValueField         :='���Ա������';
    DropDownInfo_Init(var_DropDown_Info);
  end;
  DropDown_Info_List.Add(var_DropDown_Info) ;
//  Query_Info[1]:=TQueryInfo.Create();
//  with Query_Info[1] do
//  begin
//    L_ListDataSetName       :=cds0005;
//    L_DropdownColumn        :='���Ա������';   //��Ա����
//    L_ListResultField       :='Ա������';
//  end;
  var_DropDown_Info:=TDropDownInfo.Create();
  with var_DropDown_Info do
  begin
    L_SourceDataSet         :=cdsMain;
    L_GridName              :=DghMain;
    L_FindDataSet           :=cds0034;
    L_ColsInfo              :='���첿��/���첿��/100,��������/��������/150';
    L_DropdownColumn        :='��������';   //�������̴���
    L_ListDataSetFilterField:='��������';
    L_ListResultField       :='��������';
    L_GetValueField         :='��������';
    DropDownInfo_Init(var_DropDown_Info);
  end;
  DropDown_Info_List.Add(var_DropDown_Info) ;
//  Query_Info[2]:=TQueryInfo.Create();
//  with Query_Info[2] do
//  begin
//    L_ListDataSetName       :=cds0034;
//    L_DropdownColumn        :='��������';
//    L_ListResultField       :='��������';
//  end;
  var_DropDown_Info:=TDropDownInfo.Create();
  with var_DropDown_Info do
  begin
    L_SourceDataSet         :=cdsMain;
    L_GridName              :=DghMain;
    L_FindDataSet           :=cds0094;
    L_ColsInfo              :='�������̴���/�������̴���/100,��������/��������/150';
    L_DropdownColumn        :='�������̴���';   //�������̴���
    L_ListDataSetFilterField:='�������̴���';
    L_ListResultField       :='�������̴���';
    L_GetValueField         :='�������̴���';
    DropDownInfo_Init(var_DropDown_Info);
  end;
  DropDown_Info_List.Add(var_DropDown_Info) ;
//  Query_Info[3]:=TQueryInfo.Create();
//  with Query_Info[3] do
//  begin
//    L_ListDataSetName       :=cds0094;
//    L_DropdownColumn        :='�������̴���';
//    L_ListResultField       :='�������̴���';
//  end;
  var_DropDown_Info:=TDropDownInfo.Create();
  with var_DropDown_Info do
  begin
    L_SourceDataSet         :=cdsMain;
    L_GridName              :=DghMain;
    L_FindDataSet           :=cds0015;
    L_ColsInfo              :='����/����/150';
    L_DropdownColumn        :='����';   //�������̴���
    L_ListDataSetFilterField:='����';
    L_ListResultField       :='����';
    L_GetValueField         :='����';
    DropDownInfo_Init(var_DropDown_Info);
  end;
  DropDown_Info_List.Add(var_DropDown_Info) ;
//  Query_Info[4]:=TQueryInfo.Create();
//  with Query_Info[4] do
//  begin
//    L_ListDataSetName       :=cds0015;
//    L_DropdownColumn        :='����';
//    L_ListResultField       :='����';
//  end;
  var_DropDown_Info:=TDropDownInfo.Create();
  with var_DropDown_Info do
  begin
    L_SourceDataSet         :=cdsMain;
    L_GridName              :=DghMain;
    L_FindDataSet           :=cds0417;
    L_ColsInfo              :='�豸���/�豸���/120,�豸����/�豸����/200';
    L_DropdownColumn        :='�豸���';   //�������̴���
    L_ListDataSetFilterField:='�豸���';
    L_ListResultField       :='�豸���';
    L_GetValueField         :='�豸���';
    DropDownInfo_Init(var_DropDown_Info);
  end;
  DropDown_Info_List.Add(var_DropDown_Info) ;
//  Query_Info[5]:=TQueryInfo.Create();
//  with Query_Info[5] do
//  begin
//    L_ListDataSetName       :=cds0417;
//    L_DropdownColumn        :='�豸����';
//    L_ListResultField       :='�豸����';
//  end;
  var_DropDown_Info:=TDropDownInfo.Create();
  with var_DropDown_Info do
  begin
    L_SourceDataSet         :=cdsMain;
    L_GridName              :=DghMain;
    L_FindDataSet           :=cds0017;
    L_ColsInfo              :='���ϱ���/���ϱ���/120,�������ƹ��/�������ƹ��/250';
    L_DropdownColumn        :='���ϱ���';   //�������̴���
    L_ListDataSetFilterField:='���ϱ���';
    L_ListResultField       :='���ϱ���';
    L_GetValueField         :='���ϱ���';
    DropDownInfo_Init(var_DropDown_Info);
  end;
  DropDown_Info_List.Add(var_DropDown_Info) ;
//  Query_Info[6]:=TQueryInfo.Create();
//  with Query_Info[6] do
//  begin
//    L_ListDataSetName       :=cds0017;
//    L_DropdownColumn        :='���ϱ���';   //��Ա����
//    L_ListResultField       :='���ϱ���';
//  end;
  var_DropDown_Info:=TDropDownInfo.Create();
  with var_DropDown_Info do
  begin
    L_SourceDataSet         :=cdsMain;
    L_GridName              :=DghMain;
    L_FindDataSet           :=cds835;
    L_ColsInfo              :='�յ���ҵ����������/�յ���ҵ����������/150,��������˵��/��������˵��/200';
    L_DropdownColumn        :='�յ���ҵ����������';   //�������̴���
    L_ListDataSetFilterField:='�յ���ҵ����������';
    L_ListResultField       :='�յ���ҵ����������';
    L_GetValueField         :='�յ���ҵ����������';
    DropDownInfo_Init(var_DropDown_Info);
  end;
  DropDown_Info_List.Add(var_DropDown_Info) ;
//  Query_Info[7]:=TQueryInfo.Create();
//  with Query_Info[7] do
//  begin
//    L_ListDataSetName       :=cds835;
//    L_DropdownColumn        :='�յ���ҵ����������';   //��Ա����
//    L_ListResultField       :='�յ���ҵ����������';
//  end;

  var_DropDown_Info:=TDropDownInfo.Create();
  with var_DropDown_Info do
  begin
    L_SourceDataSet         :=cdsMain;
    L_GridName              :=DghMain;
    L_FindDataSet           :=frm_Picking.cds0840;
    L_ColsInfo              :='Location/�豸����С��/150';
    L_DropdownColumn        :='�豸����С��';   //�������̴���
    L_ListDataSetFilterField:='Location';
    L_ListResultField       :='Location';
    L_GetValueField         :='�豸����С��';
    DropDownInfo_Init(var_DropDown_Info);
  end;
  DropDown_Info_List.Add(var_DropDown_Info) ;
//  Query_Info[9]:=TQueryInfo.Create();
//  with Query_Info[9] do
//  begin
//    L_ListDataSetName       :=frm_Picking.cds0840;
//    L_DropdownColumn        :='�豸����С��';
//    L_ListResultField       :='Location';
//  end;
  var_DropDown_Info:=TDropDownInfo.Create();
  with var_DropDown_Info do
  begin
//    L_SourceDataSet         :=cdsMain;
//    L_GridName              :=DghMain;
//    L_ListDataSet           :=cds0094;
//    L_ColsInfo              :='Ա������/Ա������/100,Ա������/Ա������/150';
//    L_DropdownColumn        :='';   //�������̴���
//    L_ListDataSetFilterField:='';
//    L_ListResultField       :='';
//    L_GetValueField         :='';
    L_DropdownColumn        :='����';
    L_AddPickList           :=varArrayOf(['ά��','ά��','����','����']);
    DropDownInfo_Init(var_DropDown_Info);
  end;
  DropDown_Info_List.Add(var_DropDown_Info) ;
//  Query_Info[10]:=TQueryInfo.Create();
//  with Query_Info[10] do
//  begin
//    //L_ListDataSetName       :=frm_Picking.cds0840;
//    L_DropdownColumn        :='����';
//    L_AddPickList           :=varArrayOf(['ά��','ά��','����','����']);
//  end;
end;

procedure Tfrm_Picking1.dteBeginChange(Sender: TObject);
begin
  inherited;
  cdsMain.Params.ParamByName('SD').Value:=  DateToStr(dteBegin.Date);
end;

procedure Tfrm_Picking1.dteEndChange(Sender: TObject);
begin
  inherited;
  cdsMain.Params.ParamByName('ED').Value:=  DateToStr(dteEnd.Date+1);
end;

procedure Tfrm_Picking1.BtFindClick(Sender: TObject);
begin
  inherited;
  cdsMain.Close;
  cdsMain.CommandText:=cdsMain.F_SQLSelectFrom;
  cdsMain.Open;
end;

procedure Tfrm_Picking1.FormActivate(Sender: TObject);
begin
  inherited;
  WindowState := wsMaximized  ;
end;

end.
