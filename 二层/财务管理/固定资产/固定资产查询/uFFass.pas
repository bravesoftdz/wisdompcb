unit uFFass;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ExtCtrls, StdCtrls, Buttons, Mask, DBCtrls, Grids,
  DBGrids, DB, ADODB, Spin;

type
  TFrmFass = class(TForm)
    Panel1: TPanel;
    Splitter1: TSplitter;
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    BitBtn1: TBitBtn;
    BitBtn3: TBitBtn;
    Label1: TLabel;
    Label3: TLabel;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label11: TLabel;
    GroupBox1: TGroupBox;
    Label9: TLabel;
    BitBtn5: TBitBtn;
    BitBtn2: TBitBtn;
    Label10: TLabel;
    GroupBox3: TGroupBox;
    GroupBox4: TGroupBox;
    Label13: TLabel;
    DateTimePicker1: TDateTimePicker;
    Label18: TLabel;
    Edit4: TEdit;
    Label19: TLabel;
    Edit5: TEdit;
    Label20: TLabel;
    Edit6: TEdit;
    Label21: TLabel;
    Label22: TLabel;
    Label23: TLabel;
    Label24: TLabel;
    Label25: TLabel;
    Label26: TLabel;
    Edit7: TEdit;
    Edit8: TEdit;
    Edit9: TEdit;
    Edit11: TEdit;
    Edit12: TEdit;
    Edit13: TEdit;
    Edit16: TEdit;
    Edit17: TEdit;
    Label29: TLabel;
    Label30: TLabel;
    GroupBox7: TGroupBox;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    StrGrd: TStringGrid;
    StrGrd1: TStringGrid;
    Edit14: TEdit;
    Edit15: TEdit;
    Edit18: TEdit;
    ComBoxFasTyp: TComboBox;
    GroupBox5: TGroupBox;
    StrGrdOrig1: TStringGrid;
    Button4: TButton;
    Button5: TButton;
    Button6: TButton;
    StrGrdOrig2: TStringGrid;
    ComBoxFasAlt: TComboBox;
    ComBoxFasStat: TComboBox;
    Edit1: TEdit;
    Qery514: TADOQuery;
    Qery515: TADOQuery;
    Qery516: TADOQuery;
    ComboBox2: TComboBox;
    Label12: TLabel;
    Label14: TLabel;
    Edit2: TEdit;
    SpinEdit1: TSpinEdit;
    Memo1: TMemo;
    Label15: TLabel;
    Edit3: TEdit;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);

   // procedure TabSheet2Show(Sender: TObject);



    procedure TabSheet1Show(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ComBoxFasTypSelect(Sender: TObject);
    procedure ComBoxFasAltSelect(Sender: TObject);
    procedure ComBoxFasStatSelect(Sender: TObject);
    procedure Edit7KeyPress(Sender: TObject; var Key: Char);
    procedure ComboBox2Select(Sender: TObject);
    procedure Edit7Change(Sender: TObject);
    procedure Edit4Change(Sender: TObject);
    procedure Edit9Change(Sender: TObject);
    procedure TabSheet2Show(Sender: TObject);


  private
    { Private declarations }
    _Tpkey: array of integer;
    _Altkey: array of integer;
    _Statkey: array of integer;  //״̬
    //_Glkey: array of integer;
    //_DepAckey: array of integer;
    function GetOrigVal():currency; //��ȡԭֵ
    function CaluMDepr(const pI:integer):boolean;//���۾���
    function CalDepCurr(const pY:integer;const pI:integer;const pIniCurr:currency):currency;//�����۾����
    function New517Rec():boolean;      //�����̶��ʲ�
    function Edit517Rec(const pRkey:integer):boolean;     //�޸Ĺ̶��ʲ�
    function New325Rec(const prkey:integer):boolean;      //�����̶��ʲ�ԭֵ
    function Edit325Rec(const prkey:integer):boolean;     //�޸Ĺ̶��ʲ�ԭֵ
    function New326Rec(const prkey:integer):boolean;      //�����̶��ʲ��۾ɷ���
    function Edit326Rec(const prkey:integer):boolean;     //�޸Ĺ̶��ʲ��۾ɷ���
    function ishasID(const pID:string):boolean;     //�Ƿ�ID��ռ��
    function CheckMust():boolean;     //�������ֶ��Ƿ���д
    function GetPercents():currency;     //�����÷�̲�Ƿ�100%
    function SetFassGlVal(const prkey:integer):boolean; //�̶��ʲ���
    function SetDeprGlVal(const prkey:integer):boolean;  //�ۼ��۾ɿ�Ŀ

  public
    { Public declarations }
    _FasTpkey :integer;    //�̶��ʲ����Rkey
    _FasAltkey:integer;    //�̶��ʲ�������ʽrkey
    _FasStatkey:integer;   //�̶��ʲ�״̬rkey
    _FasGlkey:integer;     //�̶��ʲ���Ŀrkey
    _FasDepAckey:integer;  //�ۼ��۾ɿ�Ŀrkey
    _isEdit:boolean;       //
    function checkchar(const pstr:string;const pkey:char):boolean;
    function GetID():string;       //��ȡID��
  end;

var
  FrmFass: TFrmFass;

implementation

uses uMD, math;

{$R *.dfm}
//�̶��ʲ��ۼ��۾ɿ�Ŀ
function TFrmFass.SetFassGlVal(const prkey:integer):boolean;
var
  vsql:string;
begin
  dm.Qery.Close ;
  dm.Qery.SQL.Clear ;
//  vsql:='SELECT CASE WHEN data0103_1.parent_ptr = 0 THEN data0103_1.GL_DESCRIPTION ELSE Data0103_2.GL_DESCRIPTION';
//  vsql:=vsql+'+'+''''+'��'+''''+'+' + 'Data0103_1.GL_DESCRIPTION  END AS description_2,';
//  vsql:=vsql+' Data0103_1.GL_ACC_NUMBER';
//  vsql:=vsql+' FROM Data0103 Data0103_2 RIGHT OUTER JOIN ';
//  vsql:=vsql+' Data0103 Data0103_1 ON Data0103_2.RKEY = Data0103_1.PARENT_PTR';
//  vsql:=vsql+' WHERE ';
//  vsql:=vsql+' (Data0103_1.rkey='+inttostr(prkey)+')';
  vsql := 'select GL_DESCRIPTION,GL_ACC_NUMBER from data0103 where rkey = ' + inttostr(prkey);
  dm.Qery.SQL.Text :=vsql;
  dm.Qery.Open ;
  
  Edit16.Text:=dm.Qery.fieldbyname('GL_ACC_NUMBER').value;  //��Ŀ����
  label29.Caption:=dm.Qery.fieldbyname('GL_DESCRIPTION').AsString;  //��Ŀ����

  result:=true;
end;
//�ۼ��۾ɿ�Ŀ
function TFrmFass.SetDeprGlVal(const prkey:integer):boolean;
var
  vsql:string;
begin
  dm.Qery.Close ;
  dm.Qery.SQL.Clear ;
//  vsql:='SELECT CASE WHEN data0103_1.parent_ptr = 0 THEN data0103_1.GL_DESCRIPTION ELSE Data0103_2.GL_DESCRIPTION';
//  vsql:=vsql+'+'+''''+'��'+''''+'+' + 'Data0103_1.GL_DESCRIPTION  END  AS description_2,';
//  vsql:=vsql+' Data0103_1.GL_ACC_NUMBER';
//  vsql:=vsql+' FROM Data0103 Data0103_2 RIGHT OUTER JOIN ';
//  vsql:=vsql+' Data0103 Data0103_1 ON Data0103_2.RKEY = Data0103_1.PARENT_PTR';
//  vsql:=vsql+' WHERE ';
//  vsql:=vsql+' (Data0103_1.rkey='+inttostr(prkey)+')';
  vsql := 'select GL_DESCRIPTION,GL_ACC_NUMBER from data0103 where rkey = ' + inttostr(prkey);
  dm.Qery.SQL.Text :=vsql;
  dm.Qery.Open ;
  Edit17.Text:=dm.Qery.fieldbyname('GL_ACC_NUMBER').value;  //��Ŀ����
  label30.Caption:=dm.Qery.fieldbyname('GL_DESCRIPTION').AsString;  //��Ŀ����
  
 result:=true;
end;
function TFrmFass.GetPercents():currency;     //�����÷�̲�Ƿ�100%
var
  i:integer;
  vCurr:currency;
begin
vCurr:=0;
if StrGrd.Row = StrGrd.Rowcount-1 then
   begin
    vCurr:=0;
   end;

  for i:=1 to StrGrd.Rowcount-2 do
    begin
      vCurr:=vCurr+strtofloat(StrGrd.Cells[1,i]);
    end;
  result:=vCurr;

end;
//�������ֶ��Ƿ���д
function TFrmFass.CheckMust():boolean;
var
  vRes:boolean;
begin

 if trim(Edit15.text)='' then
   begin
    messagedlg('�ʲ����Ʊ�����д��',mtinformation,[mbok],0);
    TabSheet1.Show;
    Edit15.SetFocus;
    vRes:=false;
    exit;
   end;
 if _FasTpkey=0 then
   begin
    messagedlg('�ʲ���������д��',mtinformation,[mbok],0);
    TabSheet1.Show ;
    ComBoxFasTyp.SetFocus;
    vRes:=false;
    exit;
   end;
 if ComBoxFasStat.text='' then
   begin
    messagedlg('�ʲ�״��������д��',mtinformation,[mbok],0);
    TabSheet1.Show ;
    ComBoxFasStat.SetFocus;
    vRes:=false;
    exit;
   end;
 if _FasGlkey=0 then
   begin
    messagedlg('�ʲ���Ŀ������д��',mtinformation,[mbok],0);
    edit17.SetFocus;
    vRes:=false;
    exit;
   end;
 if _FasDepAckey=0 then
   begin
    messagedlg('�ۼ��۾ɿ�Ŀ������д��',mtinformation,[mbok],0);
    edit16.SetFocus;
    vRes:=false;
    exit;
   end;
 if getorigval()=0 then
   begin
    messagedlg('�ʲ�ԭֵ������д��',mtinformation,[mbok],0);
    StrGrdOrig1.SetFocus;
    vRes:=false;
    exit;
   end;
 if ComboBox2.Text='' then
   begin
    messagedlg('�۾ɷ���������д��',mtinformation,[mbok],0);
    TabSheet2.Show ;
    ComboBox2.SetFocus ;
    vRes:=false;
    exit;
   end;
 if trim(edit9.Text)='' then
   begin
    messagedlg('Ԥ��ʹ�����ޱ�����д��',mtinformation,[mbok],0);
    edit9.SetFocus ;
    vRes:=false;
    exit;
   end;
 if trim(StrGrd.Cells[0,1])='' then
  begin
   messagedlg('�۾ɷ��ñ�����д��',mtinformation,[mbok],0);
   StrGrd.SetFocus ;
   vRes:=false;
   exit;
  end;
 if GetPercents()<>100 then
  begin
   messagedlg('�۾ɷ��÷�̲����',mtinformation,[mbok],0);
   StrGrd.SetFocus ;
   vRes:=false;
   exit;
  end;
   
 result:=vRes;
end;

function TFrmFass.ishasID(const pID:string):boolean;     //�Ƿ�ID��ռ��
begin
 dm.Qery.Close;
 dm.Qery.SQL.Clear ;
 dm.Qery.SQL.Text :=' select FASSET_CODE from data0517 where FASSET_CODE='+''''+pID+'''';
 dm.Qery.Open;
 if dm.Qery.RecordCount =0 then
  result:=false
 else
  result:=true;

end;
//��ȡID��
function TFrmFass.GetID():string;
var
  vID:string;
  vPow:currency;
begin
 dm.Qery.Close;
 dm.Qery.SQL.Clear ;
 dm.Qery.SQL.Text :=' select top 1 FASSET_CODE from data0517 ORDER BY FASSET_CODE DESC';
 dm.Qery.Open ;
 if dm.Qery.RecordCount =0 then
  vID:='00001'
 else
  begin
   vID:=dm.Qery.fieldbyname('FASSET_CODE').value;
   vPow:=power(10,length(vID))+1;
   vID:=floattostr(vPow+strtoint(vID));
   vID:=copy(vID,2,length(vID));
  end;
 result:=vid; 
end;
//�����۾����
function TFrmFass.CalDepCurr( const pY:integer;const pI:integer;const pIniCurr:currency):currency;
var
  vi,vCurr:currency;
  i:integer;
begin
  vi:=1-2/pY;
  vCurr:=pIniCurr;
  for i:=1 to pI do
    vCurr:=vCurr*vi;

 result:=vCurr;
end;
//�������۾��ʣ����۾ɶ�
function TFrmFass.CaluMDepr(const pI:integer):boolean ;
var
   vNetV:currency;
   vY:currency;
   vM:currency;
   vOrVal:currency;//ԭֵ
begin
  if (trim(edit7.Text)<>'') and (trim(edit9.Text)<>'') then
    if (strtofloat(trim(edit7.Text))<>0) and (strtofloat(trim(edit9.Text))<>0) then
      begin
       vOrVal:=GetOrigVal();
       vNetV:=vOrVal-(vOrVal*strtofloat(trim(edit7.Text))/100);    //�����۾ɶ�
       case pi of
        1:begin  //ƽ������
           vY:=strtofloat(trim(edit9.Text));        //Ԥ���۾�����
           vM:=vNetV/vY;                            //���۾ɶ�
           edit12.Text :=floattostr(vM);            //���۾ɶ�
           edit11.Text :=floattostr(vM*100);        //���۾���
          end;
        2:begin  //��������
           vY:=strtofloat(trim(edit9.Text));        //Ԥ��ʹ���ܹ�����
           vM:=vNetV/vY;                            //��λ�������۾ɶ�
           edit12.Text :=floattostr(vM);            //��λ�������۾ɶ�
          end;
        3:begin  //˫�����ݼ���
           if strtofloat(trim(edit9.Text))-strtofloat(SpinEdit1.Text)>2 then
            begin
             if strtofloat(SpinEdit1.Text)<>0 then
               vNetV:=CalDepCurr(strtoint(trim(edit9.Text)),strtoint(SpinEdit1.Text),vNetV);
              
             vY:=strtofloat(trim(edit9.Text));        //Ԥ���۾�����
             vM:=2/vY;                                //���۾���
             edit11.Text :=floattostr(vM/12*100);     //���۾���
             edit12.Text :=floattostr(vNetV*vM/12);   //���۾ɶ�
            end
           else
            begin
              vNetV:=CalDepCurr(strtoint(trim(edit9.Text)),strtoint(SpinEdit1.Text),vNetV);
              vM:=(vNetV-vOrVal*strtofloat(trim(edit7.Text))/100)/2;    //���۾ɶ�
              edit11.Text :=floattostr(vM/12*100);      //���۾���
              edit12.Text :=floattostr(vM/12);          //���۾ɶ�
            end;
          end;
        4:begin  //�����ܺͷ�
            vY:=strtofloat(trim(edit9.Text));                           //Ԥ���۾�����
            vM:=(vY-strtofloat(SpinEdit1.Text))/((vY*(vY+1))/2)*100/100;     //���۾���
            edit11.Text :=floattostr(vM/12);                            //���۾���
            edit12.Text :=floattostr(vNetV*vM/12);                      //���۾ɶ�
          end;
       end; //end case
      end;
end;
 //��ȡԭֵ
function TFrmFass.GetOrigVal():currency;
var
  i:integer;
  vCurr:currency;
begin
vCurr:=0;
if StrGrdOrig1.Row = StrGrdOrig1.Rowcount-1 then
   begin
    vCurr:=0;
   end;

  for i:=1 to StrGrdOrig1.Rowcount-2 do
    begin
      vCurr:=vCurr+strtofloat(StrGrdOrig1.Cells[3,i]);
    end;
  result:=vCurr;
end;
//�����̶��ʲ�
function TFrmFass.New517Rec():boolean;
begin
 try
  dm.DS517.Close ;
  dm.DS517.CommandText:='select * from Data0517 where rkey is null';
  dm.DS517.Open ;
  if ishasID(trim(edit13.Text)) then
   edit13.Text := getID();

  dm.DS517.Append ;
  dm.DS517.FieldByName('FASSET_CODE').Value:=trim(edit13.Text);        //ID��
  dm.DS517.FieldByName('FASSET_NAME').Value:=trim(edit15.Text);        //����
  dm.DS517.FieldByName('FASSET_DESC').Value:=trim(edit18.Text);        //���
  dm.DS517.FieldByName('FASSET_TYPE_PTR').Value:=_FasTpkey;             //���
  dm.DS517.FieldByName('ALT_TYPE_PTR').Value:=_FasAltkey;               //������ʽ
  dm.DS517.FieldByName('STATUS_PTR').Value:=_FasStatkey;                //ʹ��״̬
  dm.DS517.FieldByName('ORIGINAL_VALUE').Value:=getorigVal();           //ԭֵ
  dm.DS517.FieldByName('LOCATION').Value:=trim(edit1.Text);             //λ��
  dm.DS517.FieldByName('BOOK_DATE').Value:=datetostr(datetimepicker1.Date); //��������
  dm.DS517.FieldByName('SURPLUS_RATE').Value:=strtoint(trim(edit7.Text))/100; //Ԥ�ƾ���ֵ��(%)
  dm.DS517.FieldByName('SURPLUS').Value:=strtofloat(trim(edit8.Text));  //Ԥ�ƾ���ֵ
  dm.DS517.FieldByName('DEPRE_MTHD_PTR').Value:=combobox2.ItemIndex;    //�̶��ʲ��۾ɷ���(012345)
  dm.DS517.FieldByName('EXPECTED_LIFE_MONTHS').Value:=strtoint(trim(edit9.Text));  //Ԥ��ʹ���·�
  dm.DS517.FieldByName('LOADING_UNIT').Value:=''''+trim(edit2.Text)+'''';         //��������λ
  dm.DS517.FieldByName('MONTH_DEPRE_RATE').Value:=strtofloat(trim(edit11.Text));   //���۾���
  dm.DS517.FieldByName('MONTH_DEPRE_AMT').Value:=strtofloat(trim(edit12.Text));    //���۾ɶ�
  dm.DS517.FieldByName('DEPRE_ACCT_PTR').Value:=_FasDepAckey;           //�ۼ��۾ɿ�Ŀָ��103
  dm.DS517.FieldByName('fasset_gl_ptr').Value:=_FasGlkey;               //�̲���ƿ�Ŀָ��0103
  dm.DS517.FieldByName('id_code').Value:=trim(edit14.Text);             //�̶��ʲ����
  dm.DS517.FieldByName('REMARK').Value:=trim(Memo1.Text);              //��ע

  dm.DS517.Post ;

  result:=true;
 except
   on E: Exception do
     begin
      result:=false;
      messagedlg(E.Message,mtinformation,[mbok],0);
     end;
 end;
end;
//�޸Ĺ̶��ʲ�
function TFrmFass.Edit517Rec(const pRkey:integer):boolean;
begin
 try
  dm.DS517.Close ;
  dm.DS517.CommandText:='select * from Data0517 where rkey='+inttostr(pRkey);
  dm.DS517.Open ;

  dm.DS517.edit ;
  dm.DS517.FieldByName('FASSET_CODE').Value:=trim(edit13.Text);        //ID��
  dm.DS517.FieldByName('FASSET_NAME').Value:=trim(edit15.Text);        //����
  dm.DS517.FieldByName('FASSET_DESC').Value:=trim(edit18.Text);        //���
  dm.DS517.FieldByName('FASSET_TYPE_PTR').Value:=_FasTpkey;             //���
  dm.DS517.FieldByName('ALT_TYPE_PTR').Value:=_FasAltkey;               //������ʽ
  dm.DS517.FieldByName('STATUS_PTR').Value:=_FasStatkey;                //ʹ��״̬
  dm.DS517.FieldByName('ORIGINAL_VALUE').Value:=getorigVal();           //ԭֵ
  dm.DS517.FieldByName('LOCATION').Value:=trim(edit1.Text);             //λ��
  dm.DS517.FieldByName('BOOK_DATE').Value:=datetostr(datetimepicker1.Date); //��������
  dm.DS517.FieldByName('SURPLUS_RATE').Value:=strtoint(trim(edit7.Text))/100; //Ԥ�ƾ���ֵ��(%)
  dm.DS517.FieldByName('SURPLUS').Value:=strtofloat(trim(edit8.Text));  //Ԥ�ƾ���ֵ
  dm.DS517.FieldByName('DEPRE_MTHD_PTR').Value:=combobox2.ItemIndex;    //�̶��ʲ��۾ɷ���(012345)
  dm.DS517.FieldByName('EXPECTED_LIFE_MONTHS').Value:=strtoint(trim(edit9.Text));  //Ԥ��ʹ���·�
  dm.DS517.FieldByName('LOADING_UNIT').Value:=trim(edit2.Text);         //��������λ
  dm.DS517.FieldByName('MONTH_DEPRE_RATE').Value:=strtofloat(trim(edit11.Text));   //���۾���
  dm.DS517.FieldByName('MONTH_DEPRE_AMT').Value:=strtofloat(trim(edit12.Text));    //���۾ɶ�
  dm.DS517.FieldByName('DEPRE_ACCT_PTR').Value:=_FasDepAckey;           //�ۼ��۾ɿ�Ŀָ��103
  dm.DS517.FieldByName('fasset_gl_ptr').Value:=_FasGlkey;               //�̲���ƿ�Ŀָ��0103
  dm.DS517.FieldByName('id_code').Value:=trim(edit14.Text);             //�̶��ʲ����
  dm.DS517.Post ;

  result:=true;
 except
   on E: Exception do
     begin
      messagedlg(E.Message,mtinformation,[mbok],0);
     end;
 end;
end;
//�����̶��ʲ�ԭֵ
function TFrmFass.New325Rec(const prkey:integer):boolean;
var
  i:integer;
begin
 if dm.ds325.active=false then dm.ds325.Open;
 with dm.ds325 do
  begin
   for i:=1 to StrGrdOrig1.Rowcount-2 do
    begin
     append;
     fieldbyname('fasset_ptr').Value:=prkey;
     fieldbyname('curr_ptr').Value:=strtoint(StrGrdOrig2.Cells[0,i]); //����ָ��
     fieldbyname('ex_rate').Value:=strtoint(StrGrdOrig1.Cells[1,i]);  //����
     fieldbyname('orig_curr_orig_value').Value:=strtofloat(StrGrdOrig1.Cells[2,i]);  //ԭ��
    end;
   UpdateBatch();
  end;
 result:=true;
end;
//�޸Ĺ̶��ʲ�ԭֵ
function TFrmFass.Edit325Rec(const prkey:integer):boolean;
begin
 dm.Qery.Close;
 dm.Qery.SQL.Clear ;
 dm.Qery.SQL.Text :='delete from data0325 where fasset_ptr='+inttostr(prkey);
 dm.Qery.ExecSQL;
 if not new325rec(prkey) then
  result:=false
 else
  result:=true;

end;
//�����̶��ʲ��۾ɷ���
function TFrmFass.New326Rec(const prkey:integer):boolean;
var
  i:integer;
begin
 if dm.ds326.active=false then dm.ds326.Open;
 with dm.ds326 do
  begin
   for i:=1 to StrGrd.Rowcount-2 do
    begin
     append;
     fieldbyname('fasset_ptr').Value:=prkey;
     fieldbyname('dept_ptr').Value:=strtoint(StrGrd1.Cells[1,i]);   //����ָ��
     fieldbyname('FACCU_DEPT_GL_PTR').Value:=strtoint(StrGrd1.Cells[2,i]);  //�۾ɷ��ÿ�Ŀָ��
     fieldbyname('PERCENTS').Value:=strtofloat(StrGrd.Cells[1,i]);  //�ٷֱ�
    end;
   UpdateBatch();
  end;
 result:=true;
end;
//�޸Ĺ̶��ʲ��۾ɷ���
function TFrmFass.Edit326Rec(const prkey:integer):boolean;
begin
 dm.Qery.Close;
 dm.Qery.SQL.Clear ;
 dm.Qery.SQL.Text :='delete from data0326 where fasset_ptr='+inttostr(prkey);
 dm.Qery.ExecSQL;
 if not new326rec(prkey) then
  result:=false
 else
  result:=true;

end;

function TFrmFass.checkchar(const pstr:string;const pkey:char):boolean;
begin
if not (pkey in ['0'..'9','.',#8]) then  //�ж��Ƿ���������
  begin
    result:=false
  end
 else
  if pkey = chr(46) then      //�ж��Ƿ��ظ�����С����'.'
   if pos('.',pstr)>0  then
      begin
        result:=false;
      end
   else
      result:=true;
end;
//����
procedure TFrmFass.BitBtn1Click(Sender: TObject);
begin
 try
  if not CheckMust() then exit;

  Edit7Change(nil);   //���㾻��ֵ
  Edit4Change(nil);   //���㾻ֵ
  ComboBox2Select(nil);//�������۾��ʣ����۾ɶ�
  dm.Conn.BeginTrans;
  if _isEdit then     //�޸�
   begin
    if not Edit517Rec(dm.Qery517.fieldbyname('rkey').Value) then
     begin
      dm.Conn.RollbackTrans;
      exit;
     end;
    if not Edit325Rec(dm.Qery517.fieldbyname('rkey').Value) then
     begin
      dm.Conn.RollbackTrans;
      exit;
     end;
    if not Edit326Rec(dm.Qery517.fieldbyname('rkey').Value) then
     begin
      dm.Conn.RollbackTrans;
      exit;
     end;
   end
  else                //����
   begin
    if not New517Rec() then
     begin
      dm.Conn.RollbackTrans;
      exit;
     end;
    if not new325rec(dm.DS517.fieldbyname('rkey').value) then
     begin
      dm.Conn.RollbackTrans;
      exit;
     end;
    if not new326rec(dm.DS517.fieldbyname('rkey').value) then
     begin
      dm.Conn.RollbackTrans;
      exit;
     end;
   end;
  dm.Conn.CommitTrans;
  FrmFass.close;
 except
   on E: Exception do
     begin
      messagedlg(E.Message,mtinformation,[mbok],0);
     end;
 end;
end;
//�˳�
procedure TFrmFass.BitBtn3Click(Sender: TObject);
begin
 FrmFass.Close ;
end;


//ԭֵ
procedure TFrmFass.TabSheet1Show(Sender: TObject);
begin
StrGrdOrig1.Cells[0,0]:='����';
StrGrdOrig1.Cells[1,0]:='����';
StrGrdOrig1.Cells[2,0]:='ԭ�ҽ��';
StrGrdOrig1.Cells[3,0]:='���ҽ��';

end;

//��ʼ��
procedure TFrmFass.FormShow(Sender: TObject);
begin
 if Qery514.Active =false then Qery514.open;

 SetLength(_Tpkey,Qery514.RecordCount);
 while not Qery514.Eof do
  begin
   ComBoxFasTyp.Items.Add(Qery514.fieldbyname('FASSET_TYPE').value);     //�ʲ����
   _Tpkey[Qery514.RecNo-1]:=Qery514.fieldbyname('rkey').value;
   Qery514.Next;
  end;
 if Qery515.Active =false then Qery515.open;
 SetLength(_Altkey,Qery515.RecordCount);
 while not Qery515.Eof do
  begin
   ComBoxFasAlt.Items.Add(Qery515.fieldbyname('FASSET_ALT_TYPE').value); //�ʲ�������ʽ
   _Altkey[Qery515.RecNo-1]:=Qery515.fieldbyname('rkey').value;
   Qery515.Next;
  end;
 if Qery516.Active =false then Qery516.open;
 SetLength(_Statkey,Qery516.RecordCount);
 while not Qery516.Eof do
  begin
   ComBoxFasStat.Items.Add(Qery516.fieldbyname('FASSET_STATUS').value); //�ʲ�״̬
   _Statkey[Qery516.RecNo-1]:=Qery516.fieldbyname('rkey').value;
   Qery516.Next;
  end;


  if not Qery514.Locate('rkey',_FasTpkey,[]) then  //�ʲ����
   ComBoxFasTyp.ItemIndex :=0
  else
   ComBoxFasTyp.ItemIndex :=Qery514.RecNo-1;
  if not Qery515.Locate('rkey',_FasAltkey,[]) then  //�ʲ�������ʽ
   ComBoxFasAlt.ItemIndex :=0
  else
   ComBoxFasAlt.ItemIndex :=Qery515.RecNo-1;
  if not Qery516.Locate('rkey',_FasStatkey,[]) then  //�ʲ�״̬
   ComBoxFasStat.ItemIndex :=0
  else
   ComBoxFasStat.ItemIndex :=Qery516.RecNo-1;

  SetFassGlVal(_FasGlkey);                     //�̶��ʲ�
  setDeprGlVal(_FasDepAckey);                     //�ۼ��۾�
end;
//�̶��ʲ����
procedure TFrmFass.ComBoxFasTypSelect(Sender: TObject);
begin
 _FasTpkey:=_Tpkey[ComBoxFasTyp.ItemIndex];
end;
//������ʽ
procedure TFrmFass.ComBoxFasAltSelect(Sender: TObject);
begin
  _FasAltkey:=_Altkey[ComBoxFasAlt.ItemIndex];
end;
//�̲�״̬
procedure TFrmFass.ComBoxFasStatSelect(Sender: TObject);
begin
 _FasStatkey:=_Statkey[ComBoxFasStat.ItemIndex];
end;
//��������
procedure TFrmFass.Edit7KeyPress(Sender: TObject; var Key: Char);
begin
 if  checkchar(TEdit(Sender).Text, key)=false then
    begin
      showmessage('�������ݲ��ԣ�����');
      abort;
    end;
end;
//�۾ɷ���
procedure TFrmFass.ComboBox2Select(Sender: TObject);
begin
 case combobox2.ItemIndex of
  0:begin                               //���۾�
    
    end;
  1:begin         //ƽ�����޷�
     label23.Caption :='Ԥ��ʹ���·ݣ�';
     label26.Caption :='���۾ɶ�';
     label24.Caption :='��ǰ�Ѽ����·ݣ�';
     label25.Visible :=true;
     edit11.Visible :=true;
     label14.Visible :=false;
     edit2.Visible :=false;
     CaluMDepr(1);
    end;
  2:begin         //��������
     label23.Caption :='Ԥ���ܹ�������';
     label26.Caption :='��λ�������۾ɶ�';
     label24.Caption :='��ǰ�Ѽ��Ṥ������';
     label25.Visible :=false;
     edit11.Visible :=false;
     label14.Visible :=true;
     edit2.Visible :=true;
     CaluMDepr(2);
    end;
  3:begin         //˫�����ݼ���
     label23.Caption :='Ԥ��ʹ�����ޣ�';
     label26.Caption :='���۾ɶ�';
     label24.Caption :='��ǰ�Ѽ���������';
     label25.Visible :=true;
     edit11.Visible :=true;
     label14.Visible :=false;
     edit2.Visible :=false;
     CaluMDepr(3);
    end;
  4:begin         //�����ܺͷ�
     label23.Caption :='Ԥ��ʹ�����ޣ�';
     label26.Caption :='���۾ɶ�';
     label24.Caption :='��ǰ�Ѽ���������';
     label25.Visible :=true;
     edit11.Visible :=true;
     label14.Visible :=false;
     edit2.Visible :=false;
     CaluMDepr(4);
    end;
 end;
end;
//���㾻��ֵ
procedure TFrmFass.Edit7Change(Sender: TObject);
var
 vCurr,vR:currency;
begin
  if trim(edit7.Text)<>'' then
   begin
     vCurr:=getorigval();
     vR:=strtofloat(trim(edit7.Text))/100;
     edit8.Text :=floattostr(vCurr*vR);
   end;
end;
//���㾻ֵ
procedure TFrmFass.Edit4Change(Sender: TObject);
var
 vCurr,vTota:currency;
begin
  if trim(edit4.Text)<>'' then
   begin
     vCurr:=getorigval();
     vTota:=strtofloat(trim(edit4.Text));
     edit5.Text :=floattostr(vCurr-vTota);
   end;

end;
 //�������
procedure TFrmFass.Edit9Change(Sender: TObject);
begin
 SpinEdit1.MaxValue :=strtoint(trim(edit9.Text));
end;

procedure TFrmFass.TabSheet2Show(Sender: TObject);
begin
StrGrd.Cells[0,0]:='ʹ�ò���';
StrGrd.Cells[1,0]:='�ٷֱ�%';
StrGrd.Cells[2,0]:='�۾ɷ��ÿ�Ŀ';
StrGrd.Cells[3,0]:='��ƿ�Ŀ����';
end;

end.
