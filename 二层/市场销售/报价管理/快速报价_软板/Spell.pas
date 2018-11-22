unit Spell;

interface
uses
  Messages,SysUtils,StdCtrls,Dialogs,ExtCtrls,math,Graphics,wintypes,ComCtrls;

TYPE

   TParam_Set=record//�����SET��Ϣ
       Unit_Long:currency;//SET�ڵĵ�Ԫ��
       Unit_Width:currency;//SET�ڵĵ�Ԫ��
       Unit_Long_Space_ToUnit:currency;//SET�ڵĵ�Ԫ�����
       Unit_Width_Space_ToUnit:currency;//SET�ڵĵ�Ԫ����
       Unit_Long_Space_Toset_1:currency;//SET�ڵĵ�Ԫ����SET�߾� ,���2Ϊ0��߾����
       Unit_Width_Space_Toset_1:currency;//SET�ڵĵ�Ԫ��SET�߾�,���2Ϊ0��߾����
       Unit_Long_Space_Toset_2:currency;//SET�ڵĵ�Ԫ����SET�߾�,���2Ϊ0��߾����
       Unit_Width_Space_Toset_2:currency;//SET�ڵĵ�Ԫ��SET�߾�,���2Ϊ0��߾����
       Set_Long_Max:currency;//SET������
       Set_Long_Min:currency;//SET������
       Set_Width_Max:currency;//SET������
       Set_Width_Min:currency;//SET������
   end;

   TParam_PNLInfo=record //֪��PNL����
        Unit_Long:currency;//��Ԫ��
        Unit_Width:currency;//��Ԫ��
        Unit_Long_Space:currency;//��Ԫ�����
        Unit_Width_Space:currency;//��Ԫ����
        Unit_Long_ToPNL:currency;//��Ԫ�����߾���
        Unit_Width_ToPNL:currency;//��Ԫ���߾���
        Unit_Long_Number:integer;//��Ԫ������
        Unit_Width_Number:integer;//��Ԫ�����
        PNLA_Long:currency;//PNLA��
        PNLA_Width:currency;//PNLA��
   end;
   //��������ĳߴ�
   TParam_PCB=record
        Unit_Long:currency;//��Ԫ��
        Unit_Width:currency;//��Ԫ��
        Unit_Long_Space:currency;//��Ԫ�����
        Unit_Width_Space:currency;//��Ԫ����

        Unit_Long_ToPNL:currency;//��Ԫ�����߾���
        Unit_Width_ToPNL:currency;//��Ԫ���߾���
        Unit_Long_ToPNL_min:currency;//��Ԫ�����߾���
        Unit_Width_ToPNL_min:currency;//��Ԫ���߾���

        PNLA_Long_Max:currency;//PNLA������
        PNLA_Width_Max:currency;//PNLA������
        PNLA_Long_Min:currency;//PNLA������
        PNLA_Width_Min:currency;//PNLA������
     end;


     PAParam_Sheet=^TAParam_Sheet;
     PAResult_MakeUp=^TAResult_MakeUp;

   //���ڴ��������
   TParam_Sheet=record
       Sheet_Long:currency;
       Sheet_Width:currency;
   end;
   TAParam_Sheet=array of TParam_Sheet;

    //��������Ľ��
   TResult_MakeUp=record
      //���ڴ�PNLA�Ű���Ϣ
        PNLA_Unit_Long:currency;//PNLA��Ԫ��
        PNLA_Unit_Width:currency;//PNLA��Ԫ��
        PNLA_Unit_Long_Space:currency;//PNLA��Ԫ�����
        PNLA_Unit_Width_Space:currency;//PNLA��Ԫ����
        PNLA_Unit_Long_ToPNL:currency;//PNLA��Ԫ�����߾���
        PNLA_Unit_Width_ToPNL:currency;//PNLA��Ԫ���߾���
        PNLA_Unit_Long_Number:integer;//PNLA��Ԫ������
        PNLA_Unit_Width_Number:integer;//PNLA��Ԫ�����
        PNLA_Long:currency;//PNLA��
        PNLA_Width:currency;//PNLA��

        //���ڴ濪����Ϣ
        One_Section_Long:currency;//һ���峤
        One_Section_Width:currency;//һ�����
        One_Section_Long_Number:integer;//һ���峤����
        One_Section_Width_Number:integer;//һ��������
        One_Section_Unit_Number:integer;//һ���ܵ�Ԫ����

        Two_Section_LongA:currency;//�����峤a
        two_Section_WidthA:currency;//�������a
        two_Section_Long_NumberA:integer;//�����峤���� a
        two_Section_Width_NumberA:integer;//���������� a
        two_Section_LongB:currency;//�����峤 b
        two_Section_WidthB:currency;//�������b
        two_Section_Long_NumberB:integer;//�����峤���� b
        two_Section_Width_NumberB:integer;//���������� b
        two_Section_Longc:currency;//�����峤 c
        two_Section_Widthc:currency;//�������c
        two_Section_Long_Numberc:integer;//�����峤���� c
        two_Section_Width_Numberc:integer;//���������� c
        two_Section_Unit_Number:integer;//�����ܵ�Ԫ����
        two_Section_Array_type:integer;//�����ŷ�ʽ.1,��ʾPNLA���ڳ��߲���,PNLB��PNLA��X��ͬ,2��ʾPNLA���ڿ��,PNLB��PNLA��Y��ͬ

        Three_Section_LongA:currency;//�����峤a
        Three_Section_WidthA:currency;//�������a
        Three_Section_Long_NumberA:integer;//�����峤���� a
        Three_Section_Width_NumberA:integer;//���������� a
        Three_Section_LongB:currency;//�����峤 b
        Three_Section_WidthB:currency;//�������b
        Three_Section_Long_NumberB:integer;//�����峤���� b
        Three_Section_Width_NumberB:integer;//���������� b
        Three_Section_Longc:currency;//�����峤 c
        Three_Section_Widthc:currency;//�������c
        Three_Section_Long_Numberc:integer;//�����峤���� c
        Three_Section_Width_Numberc:integer;//���������� c

        Three_Section_Unit_Number:integer;//�����ܵ�Ԫ����
        Three_Section_Array_type:integer;//�����ŷ�ʽ

        Sheet_Long:currency;//���ϳ�
        Sheet_Width:currency;//���Ͽ�

        Using_Rate:currency;//������������
        Unit_Using_Rate:currency;//��Ԫ������
        Pnl_Using_Rate:currency;//PNL����

        Unit_Long:currency;//SET�ڵĵ�Ԫ��
        Unit_Width:currency;//SET�ڵĵ�Ԫ��
        Unit_Long_Space_ToUnit:currency;//SET�ڵĵ�Ԫ�����
        Unit_Width_Space_ToUnit:currency;//SET�ڵĵ�Ԫ����
        Unit_Long_Space_Toset_1:currency;//SET�ڵĵ�Ԫ����SET�߾� ,���2Ϊ0��߾����
        Unit_Width_Space_Toset_1:currency;//SET�ڵĵ�Ԫ��SET�߾�,���2Ϊ0��߾����
        Unit_Long_Space_Toset_2:currency;//SET�ڵĵ�Ԫ����SET�߾�,���2Ϊ0��߾����
        Unit_Width_Space_Toset_2:currency;//SET�ڵĵ�Ԫ��SET�߾�,���2Ϊ0��߾����
        Long_SET:CURRENCY;//SET��
        Width_SET:CURRENCY;//SET��

        Draw_type:integer;
      end;
      TAResult_MakeUp=array of TResult_MakeUp;

   //��ʱ���PNL���,���ڴ�ź����ķ���ֵ
    TResult_PNL=record
        //���ڴ�PNLA�Ű���Ϣ
        PNLA_Unit_Long:currency;//PNLA��Ԫ��
        PNLA_Unit_Width:currency;//PNLA��Ԫ��
        PNLA_Unit_Long_Space:currency;//PNLA��Ԫ�����
        PNLA_Unit_Width_Space:currency;//PNLA��Ԫ����
        PNLA_Unit_Long_ToPNL:currency;//PNLA��Ԫ�����߾���
        PNLA_Unit_Width_ToPNL:currency;//PNLA��Ԫ���߾���
        PNLA_Unit_Long_Number:integer;//PNLA��Ԫ������
        PNLA_Unit_Width_Number:integer;//PNLA��Ԫ�����
        PNLA_Long:currency;//PNLA��
        PNLA_Width:currency;//PNLA��
      end;

   TCutSheet= class(Tobject)
   private
       unit_to_set_pnl_sheet1:integer;//���ڼ����Ƿ���Ҫ����ӵ�Ԫ��SET����PNL����ſ���ͼ,1ʱ��
       PNL_Informat33:TParam_PNLInfo;//���ڴ�֪��PNL���ݵı���
       Input_Set_Size_OnePNL_1:TParam_Set;//���ڴ�SET����,���,�߾�,����������
       Echange_Unit_To_Unit_Space1:boolean ;  //����Ԫ��������� Ĭ��Ϊ������
       Echange_Unit_To_PNL_Space1:boolean;    //����Ԫ�߾���� Ĭ��Ϊ������
       Leave_Section_falchion_number1:integer;//ʣ�¿�������,=2ֻ����������=3����������
       Summation_rate:real;                 //��������
       Tem_Calculate_Rate_Type1:Integer;//���������ʵķ���,1�õ�Ԫ�ߴ����,��Ԫ�ߴ���Ե�Ԫ�����ٳ��Դ��ϳߴ�;2��PNL�ߴ����,PNL�ߴ����PNL�ܸ����ٳ��Դ��ϳߴ�
       Input_Sheet_Size_OnePNL:PAParam_Sheet;  //�������Ĵ�������
       Input_PCB_SIZE_OnePNL:TParam_PCB;//�������ĳߴ�,Ϊ��¼��,��Ԫ��,��,���,�߿�,������
       PAResult_MakeUp:PAResult_MakeUp; //��ż����Ľ��ֵ
       Tem_TProgressBar1:TProgressBar;//���ڴ��TProgressBar�ؼ�,Ҫ��ʾ�Ľ�����
       Tem_Calculate_Array_Complete_Time_Display:boolean;//�Ƿ���ʾ������Ҫ��ʱ��
       Falchion_Number1:INTEGER;//��������
       Calculate_Falchion_Number_Equality_Hold_1:boolean;//���ڶ����Ƿ�����ȵĿ�������
       Calculate_Flag1:integer;//�Ƿ�������,���ɷ�����ų�һ����һ�������Ű�
       Change_PNL_Long_Width1:boolean;         //��������PNL�����Ӧ��ϵ
       No_Calculate_Falchion_Number1:boolean;         //�����㵶��

       FResultCountPerSheet:integer;
       FResultCount,FA:integer;

     procedure Sort_Result;
     function Calculate_Unit_To_Set(const Value_Input_Set_Size_OnePNL_1:TParam_Set;VAR Value_Input_PCB_SIZE_OnePNL_1:TParam_PCB):boolean;//�ӵ�Ԫ��SET
     function PNL_To_SHEET_999():Boolean;//����PNL�ſ���ͼ,PNLһ��,�����ڿ�����

     //��������PNLA�ĳߴ�ٸ�Ϊ��һ���ĳ�����ȵ�����
     function Echange_Two_And_Three_Section_Data(var value1:ARRAY OF TResult_MakeUp):boolean;

     function Calculate_Unit_OnePNL(var VALUE:TParam_PCB):BOOLEAN; //�ӵ�Ԫ��PNL
     function Calculate_OnePNL_Sheet_1(const value2:TResult_PNL;const value22:TParam_Sheet;iSheet:integer=0):boolean;//��PNL��SHEET
     function Calculate_OnePNL_Sheet_2(const value332,One_Section_PNLvalue33,Three_Section_PNLvalue33:TResult_PNL;const value333_sheet,Two_Section_value333,Three_Section_value333:TParam_Sheet;pnl_long_number3331,pnl_width_number3331,type333,Two_Section_Draw_value333,Three_Section_Draw_value333:integer;iSheet:integer=0):boolean;//��PNL��SHEET

      //���ڷ��ؼ���Ľ������
    function Get_Calculate_Result_Number: integer;
    function Get_Input_PCB_SIZE_OnePNL_1: TParam_PCB;
    function Get_Input_Sheet_Size_OnePNL_1(Index: integer): TParam_Sheet;
    procedure Set_Input_PCB_SIZE_OnePNL_1(const Value: TParam_PCB);
    procedure Set_Input_Sheet_Size_OnePNL_1(Index: integer;const Value: TParam_Sheet);
    procedure Set_tresult_makeup_using_Sheet_OnePNL_1(index: integer;const Value: TResult_MakeUp);
    function Get_tresult_makeup_using_Sheet_OnePNL_1(index: integer): TResult_MakeUp;
    function Get_Leave_Section_falchion_number: integer;
    procedure Set_Leave_Section_falchion_number1(const Value: integer);
    function Get_Echange_Unit_To_Unit_Space: boolean;
    procedure Set_Echange_Unit_To_Unit_Space(const Value: boolean);
    function Get_Echange_Unit_To_PNL_Space: boolean;
    procedure Set_Echange_Unit_To_PNL_Space(const Value: boolean);
    procedure Calculate_Array_Complete_Percent_1(V_ProgressBar1:TProgressBar;V_ProgressBar1_Min,V_ProgressBar1_MAX:INTEGER);
    procedure Calculate_Array_Complete_Percent_2(V_ProgressBar1:TProgressBar;V_ProgressBar1_Position:INTEGER);
    function Get_Calculate_Array_Complete_Percent: TProgressBar;
    procedure Set_Calculate_Array_Complete_Percent(const Value: TProgressBar);
    function Get_Calculate_Array_Complete_Time: boolean;
    procedure Set_Calculate_Array_Complete_Time(const Value: boolean);
    function Get_Tem_Calculate_Rate_Type1: integer;
    procedure Set_Tem_Calculate_Rate_Type1(const Value: integer);
    function Get_Calculate_Falchion_Number_Equality_Hold: boolean;
    procedure Set_Calculate_Falchion_Number_Equality_Hold(const Value: boolean);
    function Get_PNL_Informat3311: TParam_PNLInfo;
    procedure Set_PNL_Informat3311(const Value: TParam_PNLInfo);
    function Get_Input_Set_Size_OnePNL_1111: TParam_Set;
    procedure Set_Input_Set_Size_OnePNL_1111(const Value: TParam_Set);
    function Get_Change_PNL_Long_Width: boolean;
    procedure Set_Change_PNL_Long_Width(const Value: boolean);
    function Get_No_Calculate_Falchion_Number: boolean;
    procedure Set_No_Calculate_Falchion_Number(const Value: boolean);
   public
      constructor Create(ASheet:PAParam_Sheet;AResult_MakeUp:PAResult_MakeUp;iResultCountPerSheet:integer); overload;
      procedure Calculate_SetToPnlToSheet_Array;
      procedure Calculate_PnlToSheet_Array();
      procedure Calculate_Array();
       //ʣ�µ���������ּ�����,2:������;3:������,
       property Leave_Section_falchion_number:integer read Get_Leave_Section_falchion_number write Set_Leave_Section_falchion_number1;
       //���ϳߴ�����,���50,��0��ʼ
       property  Input_Sheet_Size[Index:integer]:TParam_Sheet Read Get_Input_Sheet_Size_OnePNL_1 Write Set_Input_Sheet_Size_OnePNL_1;
       //�������ĳߴ�,Ϊ��¼��,��Ԫ��,��,���,�߿�,������
       property Input_PCB_SIZE:TParam_PCB read Get_Input_PCB_SIZE_OnePNL_1 WRITE Set_Input_PCB_SIZE_OnePNL_1;
       //���ڷ��ؼ�����
       property Calculate_Result[index:integer]:TResult_MakeUp Read Get_tresult_makeup_using_Sheet_OnePNL_1 Write Set_tresult_makeup_using_Sheet_OnePNL_1;
       //���ڷ��ؼ���Ľ������
       property Calculate_Result_Number:integer read Get_Calculate_Result_Number;

       //����Ԫ��������� Ĭ��Ϊ������  ����Ԫ��ཻ���ٵ�������ĺ���
       property Echange_Unit_To_Unit_Space:boolean Read Get_Echange_Unit_To_Unit_Space write Set_Echange_Unit_To_Unit_Space;
       //����Ԫ�߾���� Ĭ��Ϊ������   ���߾�����ٵ�������ĺ���
       property Echange_Unit_To_PNL_Space:boolean   read Get_Echange_Unit_To_PNL_Space write Set_Echange_Unit_To_PNL_Space;

       //��Ҫ��ʾ�Ľ�����,������ʾ������Ϣ
       property  Calculate_Array_Complete_Percent:TProgressBar read Get_Calculate_Array_Complete_Percent write Set_Calculate_Array_Complete_Percent;
       //�Ƿ���ʾ������ʱ
       property  Calculate_Array_Complete_Time_Display:boolean read Get_Calculate_Array_Complete_Time WRITE Set_Calculate_Array_Complete_Time;

       //���������ʵķ���;1�õ�Ԫ����;2��PNL����
       property Calculate_Rate_Type:integer read Get_Tem_Calculate_Rate_Type1 write Set_Tem_Calculate_Rate_Type1;
       //�Ƿ񱣴浶����ȵ�
       property   Calculate_Falchion_Number_Equality_Hold:boolean READ Get_Calculate_Falchion_Number_Equality_Hold write Set_Calculate_Falchion_Number_Equality_Hold;
       //�õ�PNL������
       property   PNL_Informat:TParam_PNLInfo read Get_PNL_Informat3311 WRITE Set_PNL_Informat3311;
       //�õ�SET��Ҫ��
       property Input_Set_Size_OnePNL:TParam_Set Read Get_Input_Set_Size_OnePNL_1111 write Set_Input_Set_Size_OnePNL_1111;
       //�����PNL����������
       property  Change_PNL_Long_Width:boolean read  Get_Change_PNL_Long_Width write Set_Change_PNL_Long_Width;
       //�����㵶��
       property  No_Calculate_Falchion_Number:boolean  read Get_No_Calculate_Falchion_Number write Set_No_Calculate_Falchion_Number;
   end;
   
var
  CutSheet:TCutSheet;


implementation

procedure TCutSheet.Calculate_Array;
var
  tem_Input_PCB_SIZE_OnePNL:TParam_PCB;
  TProgressBar1_Position1,tem1:integer;
begin
   Summation_rate:=0;
   Falchion_Number1:=100;//��������
   Tem_TProgressBar1.Min:=0;
   Tem_TProgressBar1.max:=100;
   TProgressBar1_Position1:=2;
   if Change_PNL_Long_Width1=false then TProgressBar1_Position1:=1;
   Calculate_Flag1:=0;
   if Echange_Unit_To_Unit_Space1 then
   begin
      if Change_PNL_Long_Width1=false then
        TProgressBar1_Position1:=1+TProgressBar1_Position1
      else
        TProgressBar1_Position1:=2+TProgressBar1_Position1;
   end;
   if Echange_Unit_To_PNL_Space1 then
   begin
      if Change_PNL_Long_Width1=false then
        TProgressBar1_Position1:=1+TProgressBar1_Position1
      else
        TProgressBar1_Position1:=2+TProgressBar1_Position1;
   end;
   if (Echange_Unit_To_PNL_Space1) and (Echange_Unit_To_Unit_Space1) then
   begin
      if Change_PNL_Long_Width1=false then
        TProgressBar1_Position1:=1+TProgressBar1_Position1
      else
        TProgressBar1_Position1:=2+TProgressBar1_Position1;
   end;
   tem1:=0;
   if Leave_Section_falchion_number1=0 then Leave_Section_falchion_number1:=2; //û�������Ű淽��ʱ,Ĭ��Ϊ:2,������ֻ������������
   Tem_TProgressBar1.Position:=1;
   //if Tem_Calculate_Rate_Type1=0 then Tem_Calculate_Rate_Type1:=1;//û��������������ʵķ���ʱ,Ĭ��Ϊ:1,�Ե�Ԫ����.

   tem_Input_PCB_SIZE_OnePNL:=Input_PCB_SIZE_OnePNL;
   Calculate_Unit_OnePNL(tem_Input_PCB_SIZE_OnePNL);

   tem1:=tem1+1;
   Tem_TProgressBar1.Position:=trunc(tem1*100/TProgressBar1_Position1);

   if Change_PNL_Long_Width1 then
   begin
     //��������������
     tem_Input_PCB_SIZE_OnePNL:=Input_PCB_SIZE_OnePNL;
     tem_Input_PCB_SIZE_OnePNL.PNLA_Long_Max :=Input_PCB_SIZE_OnePNL.PNLA_Width_Max;
     tem_Input_PCB_SIZE_OnePNL.PNLA_long_Min :=Input_PCB_SIZE_OnePNL.PNLA_width_Min;
     tem_Input_PCB_SIZE_OnePNL.PNLA_width_Max :=Input_PCB_SIZE_OnePNL.PNLA_long_Max;
     tem_Input_PCB_SIZE_OnePNL.PNLA_width_Min :=Input_PCB_SIZE_OnePNL.PNLA_long_Min;
     Calculate_Unit_OnePNL(tem_Input_PCB_SIZE_OnePNL);
     tem1:=tem1+1;
     Tem_TProgressBar1.Position:=trunc(tem1*100/TProgressBar1_Position1);
   end;
   //����Ԫ��������� Ĭ��Ϊ������  ����Ԫ��ཻ���ٵ�������ĺ���
   if Echange_Unit_To_Unit_Space1 then
   begin
     tem_Input_PCB_SIZE_OnePNL:=Input_PCB_SIZE_OnePNL;
     tem_Input_PCB_SIZE_OnePNL.Unit_Long_Space:=Input_PCB_SIZE_OnePNL.Unit_Width_Space;
     tem_Input_PCB_SIZE_OnePNL.Unit_Width_Space:=Input_PCB_SIZE_OnePNL.Unit_Long_Space;
     Calculate_Unit_OnePNL(tem_Input_PCB_SIZE_OnePNL);
     tem1:=tem1+1;
    Tem_TProgressBar1.Position:=trunc(tem1*100/TProgressBar1_Position1);
     if Change_PNL_Long_Width1 then
     begin
       //��������������
       tem_Input_PCB_SIZE_OnePNL:=Input_PCB_SIZE_OnePNL;
       tem_Input_PCB_SIZE_OnePNL.Unit_Long_Space:=Input_PCB_SIZE_OnePNL.Unit_Width_Space;
       tem_Input_PCB_SIZE_OnePNL.Unit_Width_Space:=Input_PCB_SIZE_OnePNL.Unit_Long_Space;
       tem_Input_PCB_SIZE_OnePNL.PNLA_Long_Max :=Input_PCB_SIZE_OnePNL.PNLA_Width_Max;
       tem_Input_PCB_SIZE_OnePNL.PNLA_long_Min :=Input_PCB_SIZE_OnePNL.PNLA_width_Min;
       tem_Input_PCB_SIZE_OnePNL.PNLA_width_Max :=Input_PCB_SIZE_OnePNL.PNLA_long_Max;
       tem_Input_PCB_SIZE_OnePNL.PNLA_width_Min :=Input_PCB_SIZE_OnePNL.PNLA_long_Min;
       Calculate_Unit_OnePNL(tem_Input_PCB_SIZE_OnePNL);
       tem1:=tem1+1;
       Tem_TProgressBar1.Position:=trunc(tem1*100/TProgressBar1_Position1);
     end;
   end;
   //����Ԫ�߾���� Ĭ��Ϊ������   ���߾�����ٵ�������ĺ���
   if Echange_Unit_To_PNL_Space1 then
   begin
     tem_Input_PCB_SIZE_OnePNL:=Input_PCB_SIZE_OnePNL;
     tem_Input_PCB_SIZE_OnePNL.Unit_Long_ToPNL:=Input_PCB_SIZE_OnePNL.Unit_Width_ToPNL ;
     tem_Input_PCB_SIZE_OnePNL.Unit_Width_ToPNL:=Input_PCB_SIZE_OnePNL.Unit_Long_ToPNL;
     Calculate_Unit_OnePNL(tem_Input_PCB_SIZE_OnePNL);
     tem1:=tem1+1;
     Tem_TProgressBar1.Position:=trunc(tem1*100/TProgressBar1_Position1);
     if Change_PNL_Long_Width1 then
     begin
       //��������������
       tem_Input_PCB_SIZE_OnePNL:=Input_PCB_SIZE_OnePNL;
       tem_Input_PCB_SIZE_OnePNL.Unit_Long_ToPNL:=Input_PCB_SIZE_OnePNL.Unit_Width_ToPNL ;
       tem_Input_PCB_SIZE_OnePNL.Unit_Width_ToPNL:=Input_PCB_SIZE_OnePNL.Unit_Long_ToPNL;
       tem_Input_PCB_SIZE_OnePNL.PNLA_Long_Max :=Input_PCB_SIZE_OnePNL.PNLA_Width_Max;
       tem_Input_PCB_SIZE_OnePNL.PNLA_long_Min :=Input_PCB_SIZE_OnePNL.PNLA_width_Min;
       tem_Input_PCB_SIZE_OnePNL.PNLA_width_Max :=Input_PCB_SIZE_OnePNL.PNLA_long_Max;
       tem_Input_PCB_SIZE_OnePNL.PNLA_width_Min :=Input_PCB_SIZE_OnePNL.PNLA_long_Min;
       Calculate_Unit_OnePNL(tem_Input_PCB_SIZE_OnePNL);
       tem1:=tem1+1;
       Tem_TProgressBar1.Position:=trunc(tem1*100/TProgressBar1_Position1);
     end;
   end;
   //����Ԫ�߾����������Ԫ���������
   if Echange_Unit_To_Unit_Space1 and Echange_Unit_To_PNL_Space1 then //������ѡ��ʱ
   begin
     tem_Input_PCB_SIZE_OnePNL:=Input_PCB_SIZE_OnePNL;
     tem_Input_PCB_SIZE_OnePNL.Unit_Long_Space:=Input_PCB_SIZE_OnePNL.Unit_Width_Space;
     tem_Input_PCB_SIZE_OnePNL.Unit_Width_Space:=Input_PCB_SIZE_OnePNL.Unit_Long_Space;
     tem_Input_PCB_SIZE_OnePNL.Unit_Long_ToPNL:=Input_PCB_SIZE_OnePNL.Unit_Width_ToPNL ;
     tem_Input_PCB_SIZE_OnePNL.Unit_Width_ToPNL:=Input_PCB_SIZE_OnePNL.Unit_Long_ToPNL;
     Calculate_Unit_OnePNL(tem_Input_PCB_SIZE_OnePNL);
     tem1:=tem1+1;
     Tem_TProgressBar1.Position:=trunc(tem1*100/TProgressBar1_Position1);
     if Change_PNL_Long_Width1 then
     begin
     //��������������
     tem_Input_PCB_SIZE_OnePNL:=Input_PCB_SIZE_OnePNL;
     tem_Input_PCB_SIZE_OnePNL.Unit_Long_Space:=Input_PCB_SIZE_OnePNL.Unit_Width_Space;
     tem_Input_PCB_SIZE_OnePNL.Unit_Width_Space:=Input_PCB_SIZE_OnePNL.Unit_Long_Space;
     tem_Input_PCB_SIZE_OnePNL.Unit_Long_ToPNL:=Input_PCB_SIZE_OnePNL.Unit_Width_ToPNL ;
     tem_Input_PCB_SIZE_OnePNL.Unit_Width_ToPNL:=Input_PCB_SIZE_OnePNL.Unit_Long_ToPNL;
     tem_Input_PCB_SIZE_OnePNL.PNLA_Long_Max :=Input_PCB_SIZE_OnePNL.PNLA_Width_Max;
     tem_Input_PCB_SIZE_OnePNL.PNLA_long_Min :=Input_PCB_SIZE_OnePNL.PNLA_width_Min;
     tem_Input_PCB_SIZE_OnePNL.PNLA_width_Max :=Input_PCB_SIZE_OnePNL.PNLA_long_Max;
     tem_Input_PCB_SIZE_OnePNL.PNLA_width_Min :=Input_PCB_SIZE_OnePNL.PNLA_long_Min;
     Calculate_Unit_OnePNL(tem_Input_PCB_SIZE_OnePNL);
     tem1:=tem1+1;
     Tem_TProgressBar1.Position:=trunc(tem1*100/TProgressBar1_Position1);
     end;
   end;
   Echange_Two_And_Three_Section_Data(PAResult_MakeUp^);
   if Calculate_Flag1=0 then  showmessage('��Ĵ������޷�Χ!����!') else Sort_Result;

end;

procedure TCutSheet.Calculate_Array_Complete_Percent_2(
  V_ProgressBar1: TProgressBar; V_ProgressBar1_Position: INTEGER);
begin
  V_ProgressBar1.Position:=V_ProgressBar1_Position;
end;

procedure TCutSheet.Calculate_Array_Complete_Percent_1(
          V_ProgressBar1: TProgressBar; V_ProgressBar1_Min,V_ProgressBar1_MAX: INTEGER);
begin
  V_ProgressBar1.Min:=V_ProgressBar1_Min;
  V_ProgressBar1.Max:=V_ProgressBar1_MAX;
end;

function TCutSheet.Calculate_OnePNL_Sheet_1(const value2: TResult_PNL;//PNLA��PNLBֵ
                      const value22:TParam_Sheet;iSheet:integer=0): boolean;  //���ϳ���
var
  i10,j10,n10,n11:integer;   //���ڼ�¼�������PNL����
  function_result001:boolean;
  tepvalue2,tepvalue3:TResult_PNL;
  tem_Sheet_Size_OnePNL2,tem_Sheet_Size_OnePNL3:TParam_Sheet;
begin
  Result:=false;//�������ؼ�
  if (value2.PNLA_Long<=value22.Sheet_Long) and (value2.PNLA_Width<=value22.Sheet_Width)   then //PNL�����ڴ�����,������һ������
  begin
    n10:=trunc(value22.Sheet_Long/value2.PNLA_Long);  //���ϳ���PNL������
    n11:=trunc(value22.Sheet_Width/value2.PNLA_Width);//���Ͽ���PNL�����
    for i10:=1 to n10 do   //���Ŵ��ϳ���
    begin
      for j10:=1 to n11 do //���Ŵ��Ͽ��
       begin
           //���з������ŷ�   type=1 ��type=2 ,��ʣ�µ����ֳߴ����� ���ú���Calculate_OnePNL_Sheet_2
                                       // |--------|-------|
           //��һ���ŷ�,��һ�����ƽ�п�  |        |       |
//--------------------------              |--------|       |
//                                        |        |       |
           //����, ����                   |--------|-------|
           tem_Sheet_Size_OnePNL2.Sheet_Long:=value22.Sheet_Long-i10*value2.PNLA_Long;//������
           tem_Sheet_Size_OnePNL2.Sheet_Width:=value22.Sheet_Width ;//������
           tem_Sheet_Size_OnePNL3.Sheet_Long:=i10*value2.PNLA_Long;//������
           tem_Sheet_Size_OnePNL3.Sheet_Width:=value22.Sheet_Width-j10*value2.PNLA_Width;//������
           tepvalue2:=value2; //���ڶԵ�
           tepvalue3:=value2;
           function_result001:=Calculate_OnePNL_Sheet_2(value2,tepvalue2,tepvalue3,value22,tem_Sheet_Size_OnePNL2,tem_Sheet_Size_OnePNL3,i10,j10,1,1,1,iSheet);

           //�Ե���������
           tem_Sheet_Size_OnePNL2.Sheet_Long:=value22.Sheet_Width;//������
           tem_Sheet_Size_OnePNL2.Sheet_Width:= value22.Sheet_Long-i10*value2.PNLA_Long;//������
           tem_Sheet_Size_OnePNL3.Sheet_Long:=i10*value2.PNLA_Long;//������
           tem_Sheet_Size_OnePNL3.Sheet_Width:=value22.Sheet_Width-j10*value2.PNLA_Width;//������
           tepvalue2:=value2; //���ڶԵ�
           tepvalue3:=value2;
           function_result001:=Calculate_OnePNL_Sheet_2(value2,tepvalue2,tepvalue3,value22,tem_Sheet_Size_OnePNL2,tem_Sheet_Size_OnePNL3,i10,j10,1,2,1,iSheet);
           //�Ե���������
           tem_Sheet_Size_OnePNL2.Sheet_Long:=value22.Sheet_Long-i10*value2.PNLA_Long;//������
           tem_Sheet_Size_OnePNL2.Sheet_Width:=value22.Sheet_Width ;//������
           tem_Sheet_Size_OnePNL3.Sheet_Long:=value22.Sheet_Width-j10*value2.PNLA_Width;//������
           tem_Sheet_Size_OnePNL3.Sheet_Width:=i10*value2.PNLA_Long;//������
           tepvalue2:=value2; //���ڶԵ�
           tepvalue3:=value2;
           function_result001:=Calculate_OnePNL_Sheet_2(value2,tepvalue2,tepvalue3,value22,tem_Sheet_Size_OnePNL2,tem_Sheet_Size_OnePNL3,i10,j10,1,1,2,iSheet);
           //�Ե�����,��������
           tem_Sheet_Size_OnePNL2.Sheet_Long:=value22.Sheet_Width;//������
           tem_Sheet_Size_OnePNL2.Sheet_Width:= value22.Sheet_Long-i10*value2.PNLA_Long;//������
           tem_Sheet_Size_OnePNL3.Sheet_Long:=value22.Sheet_Width-j10*value2.PNLA_Width;//������
           tem_Sheet_Size_OnePNL3.Sheet_Width:=i10*value2.PNLA_Long;//������
           tepvalue2:=value2; //���ڶԵ�
           tepvalue3:=value2;
           function_result001:=Calculate_OnePNL_Sheet_2(value2,tepvalue2,tepvalue3,value22,tem_Sheet_Size_OnePNL2,tem_Sheet_Size_OnePNL3,i10,j10,1,2,2,iSheet);

           //,���³���Ե�����,��������
//------------------------------------------------
                                              //  |-------------|--------------|
                                              //  |             |              |
                                              //  |             |              |
           //�ڶ����ŷ�,��һ���볤ƽ�п�      //  |-------------|--------------|
                                              //  |                            |
                                              //  |                            |
                                              //  |----------------------------|

           tem_Sheet_Size_OnePNL2.Sheet_Long:=value22.Sheet_Long-i10*value2.PNLA_Long;//������
           tem_Sheet_Size_OnePNL2.Sheet_Width:=j10*value2.PNLA_Width ;//������ value22.Sheet_Width
           tem_Sheet_Size_OnePNL3.Sheet_Long:=value22.Sheet_Long;//i10*value2.PNLA_Long;//������
           tem_Sheet_Size_OnePNL3.Sheet_Width:=value22.Sheet_Width-j10*value2.PNLA_Width;//������
           tepvalue2:=value2; //���ڶԵ�
           tepvalue3:=value2;
           function_result001:=Calculate_OnePNL_Sheet_2(value2,tepvalue2,tepvalue3,value22,tem_Sheet_Size_OnePNL2,tem_Sheet_Size_OnePNL3,i10,j10,2,1,1,iSheet);
           //�Ե���������
           tem_Sheet_Size_OnePNL2.Sheet_Long:=j10*value2.PNLA_Width;//������
           tem_Sheet_Size_OnePNL2.Sheet_Width:=value22.Sheet_Long-i10*value2.PNLA_Long ;//������ value22.Sheet_Width
           tem_Sheet_Size_OnePNL3.Sheet_Long:=value22.Sheet_Long;//i10*value2.PNLA_Long;//������
           tem_Sheet_Size_OnePNL3.Sheet_Width:=value22.Sheet_Width-j10*value2.PNLA_Width;//������

           tepvalue2:=value2; //���ڶԵ�
           tepvalue3:=value2;
           function_result001:=Calculate_OnePNL_Sheet_2(value2,tepvalue2,tepvalue3,value22,tem_Sheet_Size_OnePNL2,tem_Sheet_Size_OnePNL3,i10,j10,2,2,1,iSheet);
           //�Ե���������
           tem_Sheet_Size_OnePNL2.Sheet_Long:=value22.Sheet_Long-i10*value2.PNLA_Long;//������
           tem_Sheet_Size_OnePNL2.Sheet_Width:=j10*value2.PNLA_Width ;//������ value22.Sheet_Width
           tem_Sheet_Size_OnePNL3.Sheet_Long:=value22.Sheet_Width-j10*value2.PNLA_Width;//i10*value2.PNLA_Long;//������
           tem_Sheet_Size_OnePNL3.Sheet_Width:=value22.Sheet_Long;//������

           tepvalue2:=value2; //���ڶԵ�
           tepvalue3:=value2;
           function_result001:=Calculate_OnePNL_Sheet_2(value2,tepvalue2,tepvalue3,value22,tem_Sheet_Size_OnePNL2,tem_Sheet_Size_OnePNL3,i10,j10,2,1,2,iSheet);
           //�Ե�����,��������
           tem_Sheet_Size_OnePNL2.Sheet_Long:=j10*value2.PNLA_Width ;//������
           tem_Sheet_Size_OnePNL2.Sheet_Width:=value22.Sheet_Long-i10*value2.PNLA_Long;//������ value22.Sheet_Width
           tem_Sheet_Size_OnePNL3.Sheet_Long:=value22.Sheet_Width-j10*value2.PNLA_Width;//i10*value2.PNLA_Long;//������
           tem_Sheet_Size_OnePNL3.Sheet_Width:=value22.Sheet_Long;//������

           tepvalue2:=value2; //���ڶԵ�
           tepvalue3:=value2;
           function_result001:=Calculate_OnePNL_Sheet_2(value2,tepvalue2,tepvalue3,value22,tem_Sheet_Size_OnePNL2,tem_Sheet_Size_OnePNL3,i10,j10,2,2,2,iSheet);
//-----------------------------
       end;
    end;
    Result:=true;//�������ؼ�
  end;
end;

function TCutSheet.Calculate_OnePNL_Sheet_2(
  const value332,One_Section_PNLvalue33,Three_Section_PNLvalue33: TResult_PNL; //value32���һ����PNLA��Ϣ,��PNLB��Ϣ,value3��Ŷ�,������PNLA��PNLB��Ϣ
   const  value333_sheet,Two_Section_value333, Three_Section_value333: TParam_Sheet;  //value33_sheet���ϳ���,One_Section_value, Three_Section_value:��,��������
  pnl_long_number3331, pnl_width_number3331,type333,Two_Section_Draw_value333,Three_Section_Draw_value333: integer; // pnl_long_number33һ��PNLA������,pnl_width_number33һ��PNLA�����,�ŷ�
  iSheet:integer=0): boolean;//���ú���ʱ,value3ֵ�кͳ���Ҫ�Ե�,One_Section_value����Ҫ�Ե�
type
  tempnl_sheet333 =record
        Section_LongA:currency;//���峤a
        Section_WidthA:currency;//�����a
        Section_Long_NumberA:integer;//���峤���� a
        Section_Width_NumberA:integer;//�������� a
        Section_LongB:currency;//���峤 b
        Section_WidthB:currency;//�����b
        Section_Long_NumberB:integer;//���峤���� b
        Section_Width_NumberB:integer;//�������� b
        Section_LongC:currency;//���峤 C
        Section_WidthC:currency;//�����C
        Section_Long_NumberC:integer;//���峤���� C
        Section_Width_NumberC:integer;//�������� C
        Section_Unit_Number:integer;//���ܵ�Ԫ����
  end;
var
   j21,i21,i31,j31,pnl_long_number333, pnl_width_number333,i221,t_n
    ,n201,n202,n21,n22,n231,n241,n232,n242,n233,n243
    ,n301,n302,n31,n32,n331,n341,n332,n342,n333,n343
    ,N231A1,N231A2,N232A1,N232A2,N233A1,N233A2,N234A1,N234A2
    ,N231B1,N231B2,N232B1,N232B2,N233B1,N233B2,N234B1,N234B2
    ,N221A1,N221A2,N222A1,N222A2,N223A1,N223A2,N224A1,N224A2
    ,N221B1,N221B2,N222B1,N222B2,N223B1,N223B2,N224B1,N224B2
    ,TEM_Falchion_Number1,TEM_Falchion_Number2:integer;
    rate20,rate21,rate22,rate23,max21,rate30,rate31,rate32,rate33,max31,
    tem_rate3,tem_rate2,rate_10
    ,rate200,rate201,rate202,rate203,rate204,rate205,rate206,rate207,rate208,rate209,rate210,rate211,rate212,rate213
    ,rate221,rate222,rate223,rate224,rate225,rate226,rate227,rate228,rate229,rate230,rate231,rate232,rate233
   :real	;//���ڼ����ܵ�Ԫ����
  function_result,result_1:boolean;//���ú����Ƿ�ɹ�
  array_type2,array_type3:integer;//���ڼ�¼�������ŷ�,2,3����23��
  tempnl_sheet22,tempnl_sheet33:tempnl_sheet333;
  t_c:currency;
  k:integer;
begin
   unit_to_set_pnl_sheet1:=0;
   rate20:=0;
   rate21:=0;//��ʹ����Ԫ����
   rate22:=0;
   rate23:=0;
   pnl_long_number333:=pnl_long_number3331;
   pnl_width_number333:=pnl_width_number3331;
  //��������PNKB��PNLA       ������A��ʼ��
  tempnl_sheet22.Section_LongA:=0;
  tempnl_sheet22.Section_WidthA:=0;
  tempnl_sheet22.Section_Long_NumberA:=0;
  tempnl_sheet22.Section_Width_NumberA:=0;
  tempnl_sheet22.Section_LongB:=0;
  tempnl_sheet22.Section_WidthB:=0;
  tempnl_sheet22.Section_Long_NumberB:=0;
  tempnl_sheet22.Section_Width_NumberB:=0;
  tempnl_sheet22.Section_Unit_Number:=0;
  array_type2:=-1;
  tem_rate2:=0;
  if (Two_Section_value333.Sheet_Long>=One_Section_PNLvalue33.PNLA_Long) and (Two_Section_value333.Sheet_Width >=One_Section_PNLvalue33.PNLA_Width)   then
  begin  //1
     if Leave_Section_falchion_number1=2 then //ֻ��������,�ŷ�ֻ��AB��һ�߹̶�����
     begin //2
       n21:=trunc(Two_Section_value333.Sheet_Long/One_Section_PNLvalue33.PNLA_Long);//��A,��󳤸���
       n22:=trunc(Two_Section_value333.Sheet_Width/One_Section_PNLvalue33.PNLA_Width);//��A,�������

       n201:=n21; //PNLA������Ϊn201*n202
       n202:=n22;
       rate20:=n201*n202*One_Section_PNLvalue33.PNLA_Unit_Long_Number*One_Section_PNLvalue33.PNLA_Unit_Width_Number;
       if Tem_Calculate_Rate_Type1=1 then  //�õ�Ԫ����
       begin //
          rate20:=n201*n202*One_Section_PNLvalue33.PNLA_Unit_Long_Number*One_Section_PNLvalue33.PNLA_Unit_Width_Number*One_Section_PNLvalue33.PNLA_Unit_Long*One_Section_PNLvalue33.PNLA_Unit_Width;
          rate20:=rate20/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
       end; //
       if Tem_Calculate_Rate_Type1=2 then //��PNL����
       begin //
         rate20:=n201*n202*One_Section_PNLvalue33.PNLA_Long*One_Section_PNLvalue33.PNLA_Width;//PNL��������볤��
         rate20:=rate20/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
       end; //
       for j21:=1 to n22 do //���1�����
       begin  //3
          //ʣ�²�����A,����ɵ���
           n231:=0;
           n241:=0;
           rate21:=0;
           if (Two_Section_value333.Sheet_Long>=One_Section_PNLvalue33.PNLA_Width) and
              ((Two_Section_value333.Sheet_Width-j21*One_Section_PNLvalue33.PNLA_Width)>=One_Section_PNLvalue33.PNLA_Long) then//ʣ�²����Ƿ����A,
           begin //
              n231:=trunc(Two_Section_value333.Sheet_Long/One_Section_PNLvalue33.PNLA_Width);
              n241:=trunc((Two_Section_value333.Sheet_Width-j21*One_Section_PNLvalue33.PNLA_Width)/One_Section_PNLvalue33.PNLA_Long);
              rate21:=(n21*j21+n231*n241)*One_Section_PNLvalue33.PNLA_Unit_Long_Number*One_Section_PNLvalue33.PNLA_Unit_Width_Number;
              if Tem_Calculate_Rate_Type1=1 then  //�õ�Ԫ����
              begin //
                 rate21:=(n21*j21+n231*n241)*One_Section_PNLvalue33.PNLA_Unit_Long_Number*One_Section_PNLvalue33.PNLA_Unit_Width_Number*One_Section_PNLvalue33.PNLA_Unit_Long*One_Section_PNLvalue33.PNLA_Unit_Width;
                 rate21:=rate21/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
              end; //

              if Tem_Calculate_Rate_Type1=2 then //��PNL����
              begin //
                 rate21:=(n21*j21+n231*n241)*One_Section_PNLvalue33.PNLA_Width*One_Section_PNLvalue33.PNLA_Long;
                 rate21:=rate21/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               end; //
           end; //
            n232:=0;
            n242:=0;
            rate22:=0;
            n233:=0;
            n243:=0;
            rate23:=0;

           //�� rate1,rate2,rate3���ҳ�����
            max21:=max(rate20,rate21);
            if (max21>=tem_rate2)  then
            begin //
             tem_rate2:=max21;
             if rate21=max21 then
             begin //
              array_type2:=1;  //��PNLA�󻹿���PNLA,��ų���
              tempnl_sheet22.Section_LongA:=One_Section_PNLvalue33.PNLA_Long;
              tempnl_sheet22.Section_WidthA:=One_Section_PNLvalue33.PNLA_Width;
              tempnl_sheet22.Section_Long_NumberA:=n21;
              tempnl_sheet22.Section_Width_NumberA:=j21;
              tempnl_sheet22.Section_LongB:=One_Section_PNLvalue33.PNLA_Width;
              tempnl_sheet22.Section_WidthB:=One_Section_PNLvalue33.PNLA_Long;
              tempnl_sheet22.Section_Long_NumberB:=n231;
              tempnl_sheet22.Section_Width_NumberB:=n241;
              tempnl_sheet22.Section_Unit_Number:=(n21*j21+n231*n241)*One_Section_PNLvalue33.PNLA_Unit_Long_Number*One_Section_PNLvalue33.PNLA_Unit_Width_Number;
             end; //
             if rate20=max21 then
             begin //
              array_type2:=0;  //ֻ��PNLA
              tempnl_sheet22.Section_LongA:=One_Section_PNLvalue33.PNLA_Long;
              tempnl_sheet22.Section_WidthA:=One_Section_PNLvalue33.PNLA_Width;
              tempnl_sheet22.Section_Long_NumberA:=n201;
              tempnl_sheet22.Section_Width_NumberA:=n202;
              tempnl_sheet22.Section_LongB:=0;
              tempnl_sheet22.Section_WidthB:=0;
              tempnl_sheet22.Section_Long_NumberB:=0;
              tempnl_sheet22.Section_Width_NumberB:=0;
              tempnl_sheet22.Section_Unit_Number:=n201*n202*One_Section_PNLvalue33.PNLA_Unit_Long_Number*One_Section_PNLvalue33.PNLA_Unit_Width_Number ;
             end; //
           end; //4
       end; //3
     end;  //2

  end;//1
//--------------����
//����
   rate30:=0;
   rate31:=0;//��ʹ����Ԫ����
   rate32:=0;
   rate33:=0;
   //��������PNKB��PNLA       ������A��ʼ��
   tempnl_sheet33.Section_LongA:=0;
   tempnl_sheet33.Section_WidthA:=0;
   tempnl_sheet33.Section_Long_NumberA:=0;
   tempnl_sheet33.Section_Width_NumberA:=0;
   tempnl_sheet33.Section_LongB:=0;
   tempnl_sheet33.Section_WidthB:=0;
   tempnl_sheet33.Section_Long_NumberB:=0;
   tempnl_sheet33.Section_Width_NumberB:=0;
   tempnl_sheet33.Section_Unit_Number:=0;
   array_type3:=-1;
   tem_rate3:=0;
  if (Three_Section_value333.Sheet_Long>=Three_Section_PNLvalue33.PNLA_Long) and (Three_Section_value333.Sheet_Width >=Three_Section_PNLvalue33.PNLA_Width)   then
  begin
     if Leave_Section_falchion_number1=2 then //ֻ��������,�ŷ�ֻ��AB��һ�߹̶�����
     begin 
       n31:=trunc(Three_Section_value333.Sheet_Long/Three_Section_PNLvalue33.PNLA_Long);//��A����
       n32:=trunc(Three_Section_value333.Sheet_Width/Three_Section_PNLvalue33.PNLA_Width);//��A����
       n301:=n31;
       n302:=n32;
       rate30:=n301*n302*Three_Section_PNLvalue33.PNLA_Unit_Long_Number*Three_Section_PNLvalue33.PNLA_Unit_Width_Number;
       if Tem_Calculate_Rate_Type1=1 then  //�õ�Ԫ����
       begin
         rate30:=n301*n302*Three_Section_PNLvalue33.PNLA_Unit_Long_Number*Three_Section_PNLvalue33.PNLA_Unit_Width_Number*Three_Section_PNLvalue33.PNLA_Unit_Long*Three_Section_PNLvalue33.PNLA_Unit_Width;
         rate30:=rate30/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
       end;

       if Tem_Calculate_Rate_Type1=2 then //��PNL����
       begin
         rate30:=n301*n302*Three_Section_PNLvalue33.PNLA_Long*Three_Section_PNLvalue33.PNLA_Width;
         rate30:=rate30/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
       end;

       for j31:=1 to n32 do
       begin //
          //ʣ�²�����A,����ɵ���
           n331:=0;
           n341:=0;
           rate31:=0;
           if (Three_Section_value333.Sheet_Long>=Three_Section_PNLvalue33.PNLA_Width) and
              ((Three_Section_value333.Sheet_Width-j31*Three_Section_PNLvalue33.PNLA_Width)>=Three_Section_PNLvalue33.PNLA_Long) then//ʣ�²����Ƿ����A,
           begin
              n331:=trunc(Three_Section_value333.Sheet_Long/Three_Section_PNLvalue33.PNLA_Width);
              n341:=trunc((Three_Section_value333.Sheet_Width-j31*Three_Section_PNLvalue33.PNLA_Width)/Three_Section_PNLvalue33.PNLA_Long);
              rate31:=(n31*j31+n331*n341)*Three_Section_PNLvalue33.PNLA_Unit_Long_Number*Three_Section_PNLvalue33.PNLA_Unit_Width_Number;
              if Tem_Calculate_Rate_Type1=1 then  //�õ�Ԫ����
              begin
                 rate31:=(n31*j31+n331*n341)*Three_Section_PNLvalue33.PNLA_Unit_Long_Number*Three_Section_PNLvalue33.PNLA_Unit_Width_Number*Three_Section_PNLvalue33.PNLA_Unit_Long*Three_Section_PNLvalue33.PNLA_Unit_Width;
                 rate31:=rate31/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
              end;

              if Tem_Calculate_Rate_Type1=2 then //��PNL����
              begin
                  rate31:=(n31*j31+n331*n341)*Three_Section_PNLvalue33.PNLA_Long*Three_Section_PNLvalue33.PNLA_Width;
                  rate31:=rate31/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
              end
           end;

          //ʣ�²�����B,���������,����������

           max31:=max(rate30,rate31);

           if (max31>=tem_rate3)  then
           begin
             tem_rate3:=max31;
             if rate31=max31 then
             begin
              array_type3:=1;
              tempnl_sheet33.Section_LongA:=Three_Section_PNLvalue33.PNLA_Long;
              tempnl_sheet33.Section_WidthA:=Three_Section_PNLvalue33.PNLA_Width;
              tempnl_sheet33.Section_Long_NumberA:=n31;
              tempnl_sheet33.Section_Width_NumberA:=j31;
              tempnl_sheet33.Section_LongB:=Three_Section_PNLvalue33.PNLA_Width;
              tempnl_sheet33.Section_WidthB:=Three_Section_PNLvalue33.PNLA_Long;
              tempnl_sheet33.Section_Long_NumberB:=n331;
              tempnl_sheet33.Section_Width_NumberB:=n341;
              tempnl_sheet33.Section_Unit_Number:=(n31*j31+n331*n341)*Three_Section_PNLvalue33.PNLA_Unit_Long_Number*Three_Section_PNLvalue33.PNLA_Unit_Width_Number;
             end;
             if rate30=max31 then
             begin
              array_type3:=0;
              tempnl_sheet33.Section_LongA:=Three_Section_PNLvalue33.PNLA_Long;
              tempnl_sheet33.Section_WidthA:=Three_Section_PNLvalue33.PNLA_Width;
              tempnl_sheet33.Section_Long_NumberA:=n301;
              tempnl_sheet33.Section_Width_NumberA:=n302;
              tempnl_sheet33.Section_LongB:=0;
              tempnl_sheet33.Section_WidthB:=0;
              tempnl_sheet33.Section_Long_NumberB:=0;
              tempnl_sheet33.Section_Width_NumberB:=0;
              tempnl_sheet33.Section_Unit_Number:=n301*n302*Three_Section_PNLvalue33.PNLA_Unit_Long_Number*Three_Section_PNLvalue33.PNLA_Unit_Width_Number ;
             end;

           end;
       end;
     end;

  end;

//--------------����

  rate_10:=pnl_long_number333*pnl_width_number333*value332.PNLA_Unit_Long_Number*value332.PNLA_Unit_Width_Number;
  if Tem_Calculate_Rate_Type1=1 then  //�õ�Ԫ����
  begin
     rate_10:=pnl_long_number333*pnl_width_number333*value332.PNLA_Unit_Long_Number*value332.PNLA_Unit_Width_Number*value332.PNLA_Unit_Long*value332.PNLA_Unit_Width;
     rate_10:=rate_10/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
  end;

  if Tem_Calculate_Rate_Type1=2 then //��PNL����
  begin
     rate_10:=pnl_long_number333*pnl_width_number333*value332.PNLA_Long*value332.PNLA_Width;
     rate_10:=rate_10/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
  end;

   if (FResultCountPerSheet>1) and (FResultCount>FResultCountPerSheet) then
   begin
      Summation_rate:=PAResult_MakeUp^[(iSheet+1)*FResultCountPerSheet-1].Using_Rate;
      k:=(iSheet+1)*FResultCountPerSheet-1;
      if round(PAResult_MakeUp^[(iSheet+1)*FResultCountPerSheet-2].Using_Rate*100000)<round(Summation_rate*10000) then
      begin
        Summation_rate:=PAResult_MakeUp^[(iSheet+1)*FResultCountPerSheet-2].Using_Rate;
        k:=(iSheet+1)*FResultCountPerSheet-2;
      end;
      if round(PAResult_MakeUp^[(iSheet+1)*FResultCountPerSheet-3].Using_Rate*10000)<round(Summation_rate*10000) then
      begin
        Summation_rate:=PAResult_MakeUp^[(iSheet+1)*FResultCountPerSheet-3].Using_Rate;
        k:=(iSheet+1)*FResultCountPerSheet-3;
      end;
   end else
      k:=iSheet;

  if (Leave_Section_falchion_number1=2) and (FResultCountPerSheet>1) and (FResultCount>FResultCountPerSheet) then
  begin
     result_1:=(round((tem_rate2+tem_rate3+rate_10)*10000)>round(Summation_rate*10000)) or
        ((round((tem_rate2+tem_rate3+rate_10)*10000)=round(Summation_rate*10000)) and (value332.PNLA_Long*value332.PNLA_Width>PAResult_MakeUp^[k].PNLA_Long*PAResult_MakeUp^[k].PNLA_Width)) ;

     if FResultCountPerSheet>1 then
     result_1:=result_1 and (((round((tem_rate2+tem_rate3+rate_10)*10000)<>round(PAResult_MakeUp^[(iSheet+1)*FResultCountPerSheet-1].Using_Rate*10000))
                        and (round((tem_rate2+tem_rate3+rate_10)*10000)<>round(PAResult_MakeUp^[(iSheet+1)*FResultCountPerSheet-2].Using_Rate*10000))
                        and (round((tem_rate2+tem_rate3+rate_10)*10000)<>round(PAResult_MakeUp^[(iSheet+1)*FResultCountPerSheet-3].Using_Rate*10000))) or

                        (((round((tem_rate2+tem_rate3+rate_10)*10000)=round(PAResult_MakeUp^[(iSheet+1)*FResultCountPerSheet-1].Using_Rate*10000)) or
                        (round((tem_rate2+tem_rate3+rate_10)*10000)=round(PAResult_MakeUp^[(iSheet+1)*FResultCountPerSheet-2].Using_Rate*10000)) or
                         (round((tem_rate2+tem_rate3+rate_10)*10000)=round(PAResult_MakeUp^[(iSheet+1)*FResultCountPerSheet-3].Using_Rate*10000))
                          )
                        and (value332.PNLA_Long*value332.PNLA_Width>PAResult_MakeUp^[k].PNLA_Long*PAResult_MakeUp^[k].PNLA_Width))
                        );

  end else if (Leave_Section_falchion_number1=2) and (FResultCountPerSheet=1) then
     result_1:=(round((tem_rate2+tem_rate3+rate_10)*10000)>round(Summation_rate*10000)) or
        ((round((tem_rate2+tem_rate3+rate_10)*10000)=round(Summation_rate*10000)) and (value332.PNLA_Long*value332.PNLA_Width>PAResult_MakeUp^[k].PNLA_Long*PAResult_MakeUp^[k].PNLA_Width)) ;




   if ((FResultCount<=FResultCountPerSheet) and (FResultCountPerSheet>1)) or result_1   then //�����ʱ���ǰ�Ĵ�,��ȡ���ڵ�
   begin
     if (FResultCountPerSheet>1) and (FResultCount<=FResultCountPerSheet) then
     begin
       if (round(Summation_rate*10000)=round((tem_rate2+tem_rate3+rate_10)*10000)) and
          (value332.PNLA_Unit_Long*value332.PNLA_Unit_Width=PAResult_MakeUp^[iSheet*FResultCountPerSheet+FResultCount-2].PNLA_Unit_Long*PAResult_MakeUp^[iSheet*FResultCountPerSheet+FResultCount-2].PNLA_Unit_Width)
        then exit;
       K:=iSheet*FResultCountPerSheet+FResultCount-1;
       FResultCount:=FResultCount+1;
     end ;
     Summation_rate:=tem_rate2+tem_rate3+rate_10;

     //��������,һ����value32,������value3,������value3,�������PNLA��PNLB����
     PAResult_MakeUp^[K].Draw_type:=type333;//���ڻ�ͼ
     PAResult_MakeUp^[k].PNLA_Unit_Long:=value332.PNLA_Unit_Long ;
     PAResult_MakeUp^[k].PNLA_Unit_Width :=value332.PNLA_Unit_Width ;
     PAResult_MakeUp^[k].PNLA_Unit_Long_Space :=value332.PNLA_Unit_Long_Space ;
     PAResult_MakeUp^[k].PNLA_Unit_Width_Space :=value332.PNLA_Unit_Width_Space ;

     PAResult_MakeUp^[k].PNLA_Unit_Long_ToPNL :=value332.PNLA_Unit_Long_ToPNL ;
     PAResult_MakeUp^[k].PNLA_Unit_Width_ToPNL :=value332.PNLA_Unit_Width_ToPNL ;

     PAResult_MakeUp^[k].PNLA_Unit_Long_Number :=value332.PNLA_Unit_Long_Number ;
     PAResult_MakeUp^[k].PNLA_Unit_Width_Number :=value332.PNLA_Unit_Width_Number ;
     PAResult_MakeUp^[k].PNLA_Long :=value332.PNLA_Long  ;
     PAResult_MakeUp^[k].PNLA_Width :=value332.PNLA_Width ;

     //һ��,����һ������,
     PAResult_MakeUp^[k].One_Section_Long:=value332.PNLA_Long;
     PAResult_MakeUp^[k].One_Section_Width:=value332.PNLA_Width;
     PAResult_MakeUp^[k].One_Section_Long_Number:=pnl_long_number333;
     PAResult_MakeUp^[k].One_Section_Width_Number:=pnl_width_number333;
     PAResult_MakeUp^[k].One_Section_Unit_Number:=pnl_long_number333*pnl_width_number333*value332.PNLa_Unit_Long_Number*value332.PNLa_Unit_Width_Number;

      if Two_Section_Draw_value333=2 then
      begin     //���������볤�����
         //����,���¶�������
        PAResult_MakeUp^[k].Two_Section_LongA:=tempnl_sheet22.Section_Widtha;  //
        PAResult_MakeUp^[k].Two_Section_WidthA:=tempnl_sheet22.Section_Longa ;
        PAResult_MakeUp^[k].Two_Section_Long_NumberA:=tempnl_sheet22.Section_Width_Numbera;
        PAResult_MakeUp^[k].Two_Section_Width_NumberA:=tempnl_sheet22.Section_Long_Numbera ;
        PAResult_MakeUp^[k].Two_Section_LongB:=tempnl_sheet22.Section_Widthb ;
        PAResult_MakeUp^[k].Two_Section_WidthB:=tempnl_sheet22.Section_Longb ;
        PAResult_MakeUp^[k].Two_Section_Long_NumberB:=tempnl_sheet22.Section_Width_NumberB;
        PAResult_MakeUp^[k].Two_Section_Width_NumberB:=tempnl_sheet22.Section_Long_NumberB;
        PAResult_MakeUp^[k].Two_Section_Longc:=tempnl_sheet22.Section_Widthc ;
        PAResult_MakeUp^[k].Two_Section_Widthc:=tempnl_sheet22.Section_Longc ;
        PAResult_MakeUp^[k].Two_Section_Long_Numberc:=tempnl_sheet22.Section_Width_Numberc;
        PAResult_MakeUp^[k].Two_Section_Width_Numberc:=tempnl_sheet22.Section_Long_Numberc;
        PAResult_MakeUp^[k].Two_Section_Unit_Number:=tempnl_sheet22.Section_Unit_Number;

        PAResult_MakeUp^[k].Two_Section_Array_type:=TWO_Section_Draw_value333;
      end else  if Two_Section_Draw_value333=1 then
      begin
        //����,���¶�������
        PAResult_MakeUp^[k].Two_Section_LongA:=tempnl_sheet22.Section_LongA ;
        PAResult_MakeUp^[k].Two_Section_WidthA:=tempnl_sheet22.Section_WidthA ;
        PAResult_MakeUp^[k].Two_Section_Long_NumberA:=tempnl_sheet22.Section_Long_NumberA ;
        PAResult_MakeUp^[k].Two_Section_Width_NumberA:=tempnl_sheet22.Section_Width_NumberA;
        PAResult_MakeUp^[k].Two_Section_LongB:=tempnl_sheet22.Section_LongB ;
        PAResult_MakeUp^[k].Two_Section_WidthB:=tempnl_sheet22.Section_WidthB ;
        PAResult_MakeUp^[k].Two_Section_Long_NumberB:=tempnl_sheet22.Section_Long_NumberB;
        PAResult_MakeUp^[k].Two_Section_Width_NumberB:=tempnl_sheet22.Section_Width_NumberB;
        PAResult_MakeUp^[k].Two_Section_Longc:=tempnl_sheet22.Section_Longc ;
        PAResult_MakeUp^[k].Two_Section_Widthc:=tempnl_sheet22.Section_Widthc ;
        PAResult_MakeUp^[k].Two_Section_Long_Numberc:=tempnl_sheet22.Section_Long_NumberB;
        PAResult_MakeUp^[k].Two_Section_Width_Numberc:=tempnl_sheet22.Section_Width_Numberc;

        PAResult_MakeUp^[k].Two_Section_Unit_Number:=tempnl_sheet22.Section_Unit_Number;
        PAResult_MakeUp^[k].Two_Section_Array_type:=Two_Section_Draw_value333;
      end;
      if Three_Section_Draw_value333=2 then
      begin   // �Ե������볤�����
        PAResult_MakeUp^[k].three_Section_LongA:=  tempnl_sheet33.Section_WidthA ;
        PAResult_MakeUp^[k].three_Section_WidthA:=tempnl_sheet33.Section_LongA ;
        PAResult_MakeUp^[k].three_Section_Long_NumberA:=tempnl_sheet33.Section_Width_NumberA;
        PAResult_MakeUp^[k].three_Section_Width_NumberA:= tempnl_sheet33.Section_Long_NumberA ;

        PAResult_MakeUp^[k].three_Section_LongB:=tempnl_sheet33.Section_WidthB ;
        PAResult_MakeUp^[k].three_Section_WidthB:= tempnl_sheet33.Section_LongB ;
        PAResult_MakeUp^[k].three_Section_Long_NumberB:=tempnl_sheet33.Section_Width_NumberB;
        PAResult_MakeUp^[k].three_Section_Width_NumberB:=tempnl_sheet33.Section_Long_NumberB;

        PAResult_MakeUp^[k].three_Section_Longc:=tempnl_sheet33.Section_Widthc ;
        PAResult_MakeUp^[k].three_Section_Widthc:= tempnl_sheet33.Section_Longc ;
        PAResult_MakeUp^[k].three_Section_Long_Numberc:=tempnl_sheet33.Section_Width_Numberc;
        PAResult_MakeUp^[k].three_Section_Width_Numberc:=tempnl_sheet33.Section_Long_Numberc;

        PAResult_MakeUp^[k].three_Section_Unit_Number:=tempnl_sheet33.Section_Unit_Number;
        PAResult_MakeUp^[k].Three_Section_Array_type:=Three_Section_Draw_value333;//array_type3;
      end else  if Three_Section_Draw_value333=1 then
      begin
        //����,������������
        PAResult_MakeUp^[k].three_Section_LongA:=tempnl_sheet33.Section_LongA ;
        PAResult_MakeUp^[k].three_Section_WidthA:=tempnl_sheet33.Section_WidthA ;
        PAResult_MakeUp^[k].three_Section_Long_NumberA:=tempnl_sheet33.Section_Long_NumberA ;
        PAResult_MakeUp^[k].three_Section_Width_NumberA:=tempnl_sheet33.Section_Width_NumberA;
        PAResult_MakeUp^[k].three_Section_LongB:=tempnl_sheet33.Section_LongB ;
        PAResult_MakeUp^[k].three_Section_WidthB:=tempnl_sheet33.Section_WidthB ;
        PAResult_MakeUp^[k].three_Section_Long_NumberB:=tempnl_sheet33.Section_Long_NumberB;
        PAResult_MakeUp^[k].three_Section_Width_NumberB:=tempnl_sheet33.Section_Width_NumberB;

        PAResult_MakeUp^[k].three_Section_Longc:=tempnl_sheet33.Section_Longc ;
        PAResult_MakeUp^[k].three_Section_Widthc:=tempnl_sheet33.Section_Widthc ;
        PAResult_MakeUp^[k].three_Section_Long_Numberc:=tempnl_sheet33.Section_Long_Numberc;
        PAResult_MakeUp^[k].three_Section_Width_Numberc:=tempnl_sheet33.Section_Width_Numberc;

        PAResult_MakeUp^[k].three_Section_Unit_Number:=tempnl_sheet33.Section_Unit_Number;
        PAResult_MakeUp^[k].Three_Section_Array_type:=Three_Section_Draw_value333;//array_type3;       //Three_Section_Draw_value333
      end;
     PAResult_MakeUp^[k].Sheet_Long:=value333_sheet.Sheet_Long;//���ϳ�
     PAResult_MakeUp^[k].Sheet_Width:=value333_sheet.Sheet_Width;//���Ͽ�

     PAResult_MakeUp^[k].Using_Rate:=Summation_rate;

    { if Tem_Calculate_Rate_Type1=1 then //�õ�Ԫ����
     begin
       PAResult_MakeUp^[k].Pnl_Using_Rate:=Summation_rate;
       PAResult_MakeUp^[k].Unit_Using_Rate:=Summation_rate;
       PAResult_MakeUp^[k].Using_Rate:=Summation_rate;
     end;
     if Tem_Calculate_Rate_Type1=2 then //��PNL����
     begin
       PAResult_MakeUp^[k].Unit_Using_Rate:=PAResult_MakeUp^[iSheet].One_Section_Unit_Number*PAResult_MakeUp^[0].One_Section_Unit_Number*PAResult_MakeUp^[0].three_Section_Unit_Number*value332.PNLA_Unit_Long*value332.PNLA_Unit_Width/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
       PAResult_MakeUp^[k].Pnl_Using_Rate:=Summation_rate;
       PAResult_MakeUp^[k].Using_Rate:=Summation_rate;
     end;

     if Tem_Calculate_Rate_Type1=0 then
     begin
          PAResult_MakeUp^[k].Pnl_Using_Rate:=Summation_rate;
          PAResult_MakeUp^[k].Using_Rate:=Summation_rate*value332.PNLA_Unit_Long*value332.PNLA_Unit_Width/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
          PAResult_MakeUp^[k].unit_Using_Rate:=PAResult_MakeUp^[iSheet].Using_Rate;
     end;  }
     unit_to_set_pnl_sheet1:=1;
  end;
end;

function TCutSheet.Calculate_Unit_OnePNL(var VALUE: TParam_PCB): BOOLEAN; //���㵥Ԫ��PNL
VAR
 i1,i1_1,I2,j1,J2,i101,n1,n2,n3,n4:integer; //������ŵ�Ԫ����
 Result_Unit_size,tem_Result_Unit_size:TResult_PNL;//���A,B����Ű����
 function_resul22:boolean;
 sheet_size0:TParam_Sheet;
 X,Y:currency;
begin
   Result:=false;
   if (VALUE.PNLA_Long_Max<=VALUE.PNLA_Long_Min) or (VALUE.PNLA_Width_Max<=VALUE.PNLA_Width_Min) then
   begin
     showmessage('�������������!');
     exit;
   end;
   X:=VALUE.Unit_Long_ToPNL;
   Y:=VALUE.Unit_Width_ToPNL;
   while VALUE.Unit_Long_ToPNL>=VALUE.Unit_Long_ToPNL_min  do
   begin
     while VALUE.Unit_Width_ToPNL>=VALUE.Unit_Width_ToPNL_min  do
     begin
       //������ŵ�Ԫ����
       n1:=trunc((VALUE.PNLA_Long_Min -2*VALUE.Unit_Long_ToPNL+value.Unit_Long_Space )
                 /(VALUE.Unit_Long+value.Unit_Long_Space) );
       n2:=trunc((VALUE.PNLA_Long_MAX -2*VALUE.Unit_Long_ToPNL+value.Unit_Long_Space )
                 / (VALUE.Unit_Long+value.Unit_Long_Space) );
       n3:=trunc((VALUE.PNLA_WIDTH_Min -2*VALUE.Unit_Width_ToPNL +value.Unit_Width_Space )
                 / (VALUE.Unit_Width+value.Unit_Width_Space) );
       n4:=trunc((VALUE.PNLA_WIDTH_MAX -2*VALUE.Unit_Width_ToPNL+value.Unit_Width_Space )
                / (VALUE.Unit_Width+value.Unit_Width_Space) );

       if (VALUE.PNLA_Long_Min -2*VALUE.Unit_Long_ToPNL+value.Unit_Long_Space ) / (VALUE.Unit_Long+value.Unit_Long_Space)-n1>0 then  n1:=n1+1;

       if (VALUE.PNLA_WIDTH_Min -2*VALUE.Unit_Width_ToPNL+value.Unit_Width_Space ) / (VALUE.Unit_Width+value.Unit_Width_Space)-n3>0 then  n3:=n3+1;


       if  (n1>n2) or (n3>n4)  then
       begin
         i101:=0;
       end  else
       begin
         i101:=1;
       end;
       Calculate_Flag1:=Calculate_Flag1+i101;//���ڼ����Ƿ���ų������ŷ�
       if (n1<0)or (n3<0)then
       begin
         showmessage('��������޴���!');
         exit;
       end;
       for i1:=n1 to n2 do
       begin
         for i2:=n3 to n4 do
         begin
                     Result:=true; //����������

                     Result_Unit_size.PNLA_Unit_Long:=value.Unit_Long;
                     Result_Unit_size.PNLA_Unit_Width:=value.Unit_Width ;
                     Result_Unit_size.PNLA_Unit_Long_Space:=value.Unit_Long_Space ;
                     Result_Unit_size.PNLA_Unit_Width_Space:=value.Unit_Width_Space;
                     Result_Unit_size.PNLA_Unit_Long_ToPNL:=value.Unit_Long_ToPNL ;
                     Result_Unit_size.PNLA_Unit_Width_ToPNL:=value.Unit_Width_ToPNL;
                     Result_Unit_size.PNLA_Unit_Long_Number:=i1;
                     Result_Unit_size.PNLA_Unit_Width_Number:=i2;
                     Result_Unit_size.PNLA_Long:=value.Unit_Long*i1+(i1-1)*value.Unit_Long_Space+2*value.Unit_Long_ToPNL;
                     Result_Unit_size.PNLA_Width:=value.Unit_Width*i2+(i2-1)*value.Unit_Width_Space+2*value.Unit_Width_ToPNL;

                     for i1_1:=low(Input_Sheet_Size_OnePNL^) to high(Input_Sheet_Size_OnePNL^) do
                     begin
                       if (Input_Sheet_Size_OnePNL^[i1_1].Sheet_Long>0) and (Input_Sheet_Size_OnePNL^[i1_1].Sheet_Width>0) then //���ϳ������0,�Ŵ���
                       begin
                         //1.���ϳ���Ե�;2.PNLA��PNLB���гߴ�Ե�;3.���ϳ���Ե���PNLA��PNLB���гߴ�Ե�
                         if  FResultCountPerSheet=1 then
                            Summation_rate:=PAResult_MakeUp^[i1_1].Using_Rate
                         else if PAResult_MakeUp^[i1_1].Using_Rate=0 then
                            FResultCount:=1;  //һ�ִ������״�

                         tem_Result_Unit_size:=Result_Unit_size;
                         sheet_size0.Sheet_Long:=Input_Sheet_Size_OnePNL^[i1_1].Sheet_Long;
                         sheet_size0.Sheet_Width:=Input_Sheet_Size_OnePNL^[i1_1].Sheet_Width;
                         if (sheet_size0.Sheet_Long>=Result_Unit_size.PNLA_Long ) and (sheet_size0.Sheet_Width>Result_Unit_size.PNLA_Width)then
                              function_resul22:=Calculate_OnePNL_Sheet_1(tem_Result_Unit_size,sheet_size0,i1_1);

                          //�Ե����ϳ���
                          tem_Result_Unit_size:=Result_Unit_size;
                          sheet_size0.Sheet_Long:=Input_Sheet_Size_OnePNL^[i1_1].Sheet_Width ;
                          sheet_size0.Sheet_Width:=Input_Sheet_Size_OnePNL^[i1_1].Sheet_Long;
                          if (sheet_size0.Sheet_Long>=Result_Unit_size.PNLA_Long ) and (sheet_size0.Sheet_Width>Result_Unit_size.PNLA_Width)then
                              function_resul22:=Calculate_OnePNL_Sheet_1(tem_Result_Unit_size,sheet_size0,i1_1);
                       end else
                         break;
                     end;

         end;
       end;
       VALUE.Unit_Width_ToPNL:=VALUE.Unit_Width_ToPNL-0.2;
     end;
     VALUE.Unit_Width_ToPNL:=Y;
     VALUE.Unit_Long_ToPNL:=VALUE.Unit_Long_ToPNL-0.2;
   end;
   VALUE.Unit_Long_ToPNL:=X;
   VALUE.Unit_Width_ToPNL:=Y;
end;

function TCutSheet.Get_Calculate_Result_Number: integer;
begin
   Result:=0;
end;

function TCutSheet.Get_Echange_Unit_To_PNL_Space: boolean;
begin
   Result:=Echange_Unit_To_PNL_Space1;
end;

function TCutSheet.Get_Echange_Unit_To_Unit_Space: boolean;
begin
    Result:=Echange_Unit_To_Unit_Space1;
end;

function TCutSheet.Get_Input_PCB_SIZE_OnePNL_1: TParam_PCB;
begin
  Result:=Input_PCB_SIZE_OnePNL;
end;

function TCutSheet.Get_Input_Sheet_Size_OnePNL_1(Index: integer): TParam_Sheet;
begin
   Result:=Input_Sheet_Size_OnePNL^[index];
end;

function TCutSheet.Get_Leave_Section_falchion_number: integer;
begin
   Result:=Leave_Section_falchion_number1;
end;

function TCutSheet.Get_tresult_makeup_using_Sheet_OnePNL_1(index: integer): TResult_MakeUp;
begin
  Result:=PAResult_MakeUp^[index];
end;

procedure TCutSheet.Set_Echange_Unit_To_PNL_Space(const Value: boolean);
begin
  Echange_Unit_To_PNL_Space1:=value;
end;

procedure TCutSheet.Set_Echange_Unit_To_Unit_Space(const Value: boolean);
begin
   Echange_Unit_To_Unit_Space1:=value;
end;

procedure TCutSheet.Set_Input_PCB_SIZE_OnePNL_1(const Value: TParam_PCB);
begin
  Input_PCB_SIZE_OnePNL:=Value;
end;

procedure TCutSheet.Set_Input_Sheet_Size_OnePNL_1(Index: integer; const Value: TParam_Sheet);
begin
   Input_Sheet_Size_OnePNL^[index]:=value;
end;

procedure TCutSheet.Set_Leave_Section_falchion_number1(const Value: integer);
begin
 Leave_Section_falchion_number1:=value;
end;

procedure TCutSheet.Set_tresult_makeup_using_Sheet_OnePNL_1(index: integer; const Value: TResult_MakeUp);
begin
   PAResult_MakeUp^[index]:=value;
end;

function TCutSheet.Get_Calculate_Array_Complete_Percent: TProgressBar;
begin
   Result:=Tem_TProgressBar1;
end;

procedure TCutSheet.Set_Calculate_Array_Complete_Percent(const Value: TProgressBar);
begin
   Tem_TProgressBar1:=Value;
end;

function TCutSheet.Get_Calculate_Array_Complete_Time: boolean;
begin
   Result:=Tem_Calculate_Array_Complete_Time_Display;
end;

procedure TCutSheet.Set_Calculate_Array_Complete_Time(const Value: boolean);
begin
   Tem_Calculate_Array_Complete_Time_Display:=Value;
end;

function TCutSheet.Get_Tem_Calculate_Rate_Type1: integer;
begin
  Result:=Tem_Calculate_Rate_Type1;
end;

procedure TCutSheet.Set_Tem_Calculate_Rate_Type1(const Value: integer);
begin
   Tem_Calculate_Rate_Type1:=value;
end;

function TCutSheet.Get_Calculate_Falchion_Number_Equality_Hold: boolean;
begin
   Result:=Calculate_Falchion_Number_Equality_Hold_1;
end;

procedure TCutSheet.Set_Calculate_Falchion_Number_Equality_Hold(const Value: boolean);
begin
   Calculate_Falchion_Number_Equality_Hold_1:=Value;
end;



function TCutSheet.Echange_Two_And_Three_Section_Data(var
  value1: array of TResult_MakeUp): boolean;//������������PNLB��һ��ֵ��ȵ������������PNLA����һ��
var
  i,j,tem1:integer;
  tem2:currency;
begin
  Result:=false;
  for i:=low(value1) to high(value1) do
  begin
    if value1[i].two_Section_LongB>0 then //������PNLB��Ϊ0
    begin
       //�������ŷ�Ϊ1,Ϊ2���ı�
        if (value1[i].two_Section_LongB=value1[i].One_Section_Long) and (value1[i].two_Section_widthB=value1[i].One_Section_width) then //�����ĳ�����һ���ĳ������
        begin
          //����PNLA��PNLB��ֵ
          tem1:=value1[i].two_Section_Long_NumberA;
          value1[i].two_Section_Long_NumberA:=value1[i].two_Section_Long_Numberb;
          value1[i].two_Section_Long_Numberb:=tem1;

          tem1:=value1[i].two_Section_width_NumberA;
          value1[i].two_Section_width_NumberA:=value1[i].two_Section_width_Numberb;
          value1[i].two_Section_width_Numberb:=tem1;

          tem2:=value1[i].Two_Section_longA;
          value1[i].two_Section_LongA:=value1[i].two_Section_Longb;
          value1[i].two_Section_Longb:=tem2;

          tem2:=value1[i].Two_Section_widthA;
          value1[i].two_Section_widthA:=value1[i].two_Section_widthb;
          value1[i].two_Section_widthb:=tem2;

        end;
    end;
    if value1[i].three_Section_LongB>0 then //������PNLB��Ϊ0
    begin
       //�������ŷ�Ϊ1,Ϊ2���ı�
        if (value1[i].three_Section_LongB=value1[i].One_Section_Long) and (value1[i].three_Section_widthB=value1[i].One_Section_width) then //�����ĳ�����һ���ĳ������
        begin
          //����PNLA��PNLB��ֵ
          tem1:=value1[i].three_Section_Long_NumberA;
          value1[i].three_Section_Long_NumberA:=value1[i].three_Section_Long_Numberb;
          value1[i].three_Section_Long_Numberb:=tem1;

          tem1:=value1[i].three_Section_width_NumberA;
          value1[i].three_Section_width_NumberA:=value1[i].three_Section_width_Numberb;
          value1[i].three_Section_width_Numberb:=tem1;

          tem2:=value1[i].three_Section_LongA;
          value1[i].three_Section_LongA:=value1[i].three_Section_Longb;
          value1[i].three_Section_Longb:=tem2;

          tem2:=value1[i].three_Section_widthA;
          value1[i].three_Section_widthA:=value1[i].three_Section_widthb;
          value1[i].three_Section_widthb:=tem2;

        end;
    end;
    for j:=1 to 8 do  //��������PNLA��һ���ĳ��������ȵĽ�����һ����
    begin //�ֻ�ͼ��1��2�������
        if value1[i].Draw_type=1 then//��һ�����=1,�ڶ������=2
        begin //��������PNLA���������Ƿ���һ����ͬ,��ͬ��д��һ��
            if (value1[i].One_Section_Long=value1[i].Three_Section_LongA) and (value1[i].One_Section_Width=value1[i].Three_Section_WidthA)  and (value1[i].One_Section_Long_Number=value1[i].Three_Section_Long_NumberA)  then
            begin//��D������PNLA����һ��,������PNLB����������PNLA
                value1[i].One_Section_Width_Number:=value1[i].One_Section_Width_Number+value1[i].Three_Section_Width_NumberA;
                value1[i].three_Section_LongA:=value1[i].Three_Section_Longb;
                value1[i].three_Section_widthA:=value1[i].three_Section_widthb;
                value1[i].three_Section_Longb:=0;
                value1[i].three_Section_widthb:=0;
                value1[i].three_Section_Long_NumberA:=value1[i].three_Section_Long_Numberb;
                value1[i].three_Section_width_NumberA:=value1[i].three_Section_width_Numberb;
                value1[i].three_Section_Long_Numberb:=0;
                value1[i].three_Section_width_Numberb:=0;
            end;
            if (value1[i].One_Section_Long=value1[i].TWO_Section_LongA) and (value1[i].One_Section_Width=value1[i].TWO_Section_WidthA)  and (value1[i].One_Section_Long_Number=value1[i].TWO_Section_Long_NumberA)
               and (value1[i].three_Section_Long_NumberA=0) and (value1[i].three_Section_Long_Numberb=0) then
            begin//��D������PNLA����һ��,������PNLB����������PNLA
                value1[i].One_Section_LONG_Number:=value1[i].One_Section_long_Number+value1[i].TWO_Section_long_NumberA;
                value1[i].TWO_Section_LongA:=value1[i].TWO_Section_Longb;
                value1[i].TWO_Section_widthA:=value1[i].TWO_Section_widthb;
                value1[i].TWO_Section_Longb:=0;
                value1[i].TWO_Section_widthb:=0;
                value1[i].TWO_Section_Long_NumberA:=value1[i].TWO_Section_Long_Numberb;
                value1[i].TWO_Section_width_NumberA:=value1[i].TWO_Section_width_Numberb;
                value1[i].TWO_Section_Long_Numberb:=0;
                value1[i].TWO_Section_width_Numberb:=0;
            end;
        end;
        if value1[i].Draw_type=2 then//��һ�����=1,�ڶ������=2
        begin //�ڶ�����PNLA���������Ƿ���һ����ͬ,��ͬ��д��һ��
            if (value1[i].One_Section_Long=value1[i].TWO_Section_LongA) and (value1[i].One_Section_Width=value1[i].TWO_Section_WidthA)  and (value1[i].One_Section_Long_Number=value1[i].TWO_Section_Long_NumberA)  then
            begin//��D������PNLA����һ��,������PNLB����������PNLA
                value1[i].One_Section_LONG_Number:=value1[i].One_Section_long_Number+value1[i].TWO_Section_long_NumberA;
                value1[i].TWO_Section_LongA:=value1[i].TWO_Section_Longb;
                value1[i].TWO_Section_widthA:=value1[i].TWO_Section_widthb;
                value1[i].TWO_Section_Longb:=0;
                value1[i].TWO_Section_widthb:=0;
                value1[i].TWO_Section_Long_NumberA:=value1[i].TWO_Section_Long_Numberb;
                value1[i].TWO_Section_width_NumberA:=value1[i].TWO_Section_width_Numberb;
                value1[i].TWO_Section_Long_Numberb:=0;
                value1[i].TWO_Section_width_Numberb:=0;
            end;
            if (value1[i].One_Section_Long=value1[i].Three_Section_LongA) and (value1[i].One_Section_Width=value1[i].Three_Section_WidthA)  and (value1[i].One_Section_Long_Number=value1[i].Three_Section_Long_NumberA)
               and (value1[i].TWO_Section_Long_Numbera=0) and (value1[i].TWO_Section_Long_Numberb=0) then
            begin//��D������PNLA����һ��,������PNLB����������PNLA
                value1[i].One_Section_Width_Number:=value1[i].One_Section_Width_Number+value1[i].Three_Section_Width_NumberA;
                value1[i].three_Section_LongA:=value1[i].Three_Section_Longb;
                value1[i].three_Section_widthA:=value1[i].three_Section_widthb;
                value1[i].three_Section_Longb:=0;
                value1[i].three_Section_widthb:=0;
                value1[i].three_Section_Long_NumberA:=value1[i].three_Section_Long_Numberb;
                value1[i].three_Section_width_NumberA:=value1[i].three_Section_width_Numberb;
                value1[i].three_Section_Long_Numberb:=0;
                value1[i].three_Section_width_Numberb:=0;
            end;
        end;
    end;

  end;
  Result:=true;
end;

function TCutSheet.Get_PNL_Informat3311: TParam_PNLInfo;
begin
   Result:=PNL_Informat33;
end;

procedure TCutSheet.Set_PNL_Informat3311(const Value: TParam_PNLInfo);
begin
   PNL_Informat33:=value;
end;

function TCutSheet.PNL_To_SHEET_999(): Boolean;  //���ڼ���֪��PNL���ݵĴ������ϣ�������
var
  i1,i1_1,I2,j1,J2,i101:integer;
  Result_Unit_size,tem_Result_Unit_size:TResult_PNL;//���A,B����Ű����
  sheet_size0:TParam_Sheet;
  function_resul22:boolean;
begin
   Result_Unit_size.PNLA_Unit_Long:=PNL_Informat33.Unit_Long;
   Result_Unit_size.PNLA_Unit_Width:=PNL_Informat33.Unit_Width ;
   Result_Unit_size.PNLA_Unit_Long_Space:=PNL_Informat33.Unit_Long_Space ;
   Result_Unit_size.PNLA_Unit_Width_Space:=PNL_Informat33.Unit_Width_Space;
   Result_Unit_size.PNLA_Unit_Long_ToPNL:=PNL_Informat33.Unit_Long_ToPNL ;
   Result_Unit_size.PNLA_Unit_Width_ToPNL:=PNL_Informat33.Unit_Width_ToPNL;
   Result_Unit_size.PNLA_Unit_Long_Number:=PNL_Informat33.Unit_Long_Number ;
   Result_Unit_size.PNLA_Unit_Width_Number:=PNL_Informat33.Unit_Width_Number ;
   Result_Unit_size.PNLA_Long:=PNL_Informat33.PNLA_Long;
   Result_Unit_size.PNLA_Width:=PNL_Informat33.PNLA_Width;

   Summation_rate:=0;
     for i1_1:=low(Input_Sheet_Size_OnePNL^) to high(Input_Sheet_Size_OnePNL^) do
     begin
         IF (Input_Sheet_Size_OnePNL^[i1_1].Sheet_Long>0) and (Input_Sheet_Size_OnePNL^[i1_1].Sheet_Width>0) then //���ϳ������0,�Ŵ���
         begin
              tem_Result_Unit_size:=Result_Unit_size;
              sheet_size0.Sheet_Long:=Input_Sheet_Size_OnePNL^[i1_1].Sheet_Long;
              sheet_size0.Sheet_Width:=Input_Sheet_Size_OnePNL^[i1_1].Sheet_Width;
              if (sheet_size0.Sheet_Long>=Result_Unit_size.PNLA_Long ) and (sheet_size0.Sheet_Width>Result_Unit_size.PNLA_Width)then
                 function_resul22:=Calculate_OnePNL_Sheet_1(tem_Result_Unit_size,sheet_size0,i1_1);

                      //�Ե����ϳ���
              sheet_size0.Sheet_Long:=Input_Sheet_Size_OnePNL^[i1_1].Sheet_Width ;
              sheet_size0.Sheet_Width:=Input_Sheet_Size_OnePNL^[i1_1].Sheet_Long;
              if (sheet_size0.Sheet_Long>=Result_Unit_size.PNLA_Long ) and (sheet_size0.Sheet_Width>Result_Unit_size.PNLA_Width)then
                 function_resul22:=Calculate_OnePNL_Sheet_1(tem_Result_Unit_size,sheet_size0,i1_1);
         end;
     end;
end;

procedure TCutSheet.Calculate_PnlToSheet_Array;
var
  function_resule1:boolean;
begin
   Summation_rate:=0;
   Falchion_Number1:=100;//��������
   Calculate_Flag1:=0;
   if Leave_Section_falchion_number1=0 then Leave_Section_falchion_number1:=2; //û�������Ű淽��ʱ,Ĭ��Ϊ:2,������ֻ������������
   PNL_To_SHEET_999;
   function_resule1:=Echange_Two_And_Three_Section_Data(PAResult_MakeUp^);
end;

procedure TCutSheet.Calculate_SetToPnlToSheet_Array;
var //�ӵ�Ԫ��SET��PNL��SHEET
  i,j:integer;
  function_resule1:boolean;
  tem_timeTime1,tem_timeTime2,tem_timeTime3: TDateTime;
  TProgressBar1_Position1,tem1:integer;
begin
   tem_timeTime1:=Time;
   Summation_rate:=0;
   Falchion_Number1:=100;//��������
   Tem_TProgressBar1.Min:=0;
   Tem_TProgressBar1.max:=100;
   TProgressBar1_Position1:=2;
   Calculate_Flag1:=0;
   if Echange_Unit_To_Unit_Space1 then
      TProgressBar1_Position1:=2+TProgressBar1_Position1;
   if Echange_Unit_To_PNL_Space1 then
     TProgressBar1_Position1:=2+TProgressBar1_Position1;
   if (Echange_Unit_To_PNL_Space1) and (Echange_Unit_To_Unit_Space1) then
    TProgressBar1_Position1:=2+TProgressBar1_Position1;
   tem1:=0;
   if Leave_Section_falchion_number1=0 then Leave_Section_falchion_number1:=2; //û�������Ű淽��ʱ,Ĭ��Ϊ:2,������ֻ������������
   //û�������Ƿ���㿪������һ��Ҫ����ʱ
   Tem_TProgressBar1.Position:=1;
   //if Tem_Calculate_Rate_Type1=0 then Tem_Calculate_Rate_Type1:=1;//û��������������ʵķ���ʱ,Ĭ��Ϊ:1,�Ե�Ԫ����.
   tem1:=tem1+1;
   Tem_TProgressBar1.Position:=trunc(tem1*100/TProgressBar1_Position1);
   function_resule1:=Echange_Two_And_Three_Section_Data(PAResult_MakeUp^);
end;

function TCutSheet.Get_Input_Set_Size_OnePNL_1111: TParam_Set;
begin
   Result:=Input_Set_Size_OnePNL_1;
end;

procedure TCutSheet.Set_Input_Set_Size_OnePNL_1111(const Value: TParam_Set);
begin
  Input_Set_Size_OnePNL_1:=value;
end;

function TCutSheet.Calculate_Unit_To_Set(
  const Value_Input_Set_Size_OnePNL_1: TParam_Set;
  var Value_Input_PCB_SIZE_OnePNL_1: TParam_PCB): boolean;
var
 i,j,n10,n11,n12,n13:integer; //n10,n11,n12,n13�浥Ԫ����
 tem_long ,tem_width:currency;//���ڴ�SET����
 function_resule1:boolean;
begin
   Result:=false;
   //�����������С���ŵ�SET�ڵĵ�Ԫ����
   n10:=trunc((Value_Input_Set_Size_OnePNL_1.Set_Long_Min+Value_Input_Set_Size_OnePNL_1.Unit_Long_Space_ToUnit-Value_Input_Set_Size_OnePNL_1.Unit_Long_Space_Toset_1-Value_Input_Set_Size_OnePNL_1.Unit_Long_Space_Toset_2)/Value_Input_Set_Size_OnePNL_1.Unit_Long);

   n11:=trunc((Value_Input_Set_Size_OnePNL_1.Set_Long_Max+Value_Input_Set_Size_OnePNL_1.Unit_Long_Space_ToUnit-Value_Input_Set_Size_OnePNL_1.Unit_Long_Space_Toset_1-Value_Input_Set_Size_OnePNL_1.Unit_Long_Space_Toset_2)/Value_Input_Set_Size_OnePNL_1.Unit_Long);

   n12:=trunc((Value_Input_Set_Size_OnePNL_1.Set_width_Max+Value_Input_Set_Size_OnePNL_1.Unit_width_Space_ToUnit-Value_Input_Set_Size_OnePNL_1.Unit_width_Space_Toset_1-Value_Input_Set_Size_OnePNL_1.Unit_width_Space_Toset_2)/Value_Input_Set_Size_OnePNL_1.Unit_width);

   n13:=trunc((Value_Input_Set_Size_OnePNL_1.Set_width_Min+Value_Input_Set_Size_OnePNL_1.Unit_width_Space_ToUnit-Value_Input_Set_Size_OnePNL_1.Unit_width_Space_Toset_1-Value_Input_Set_Size_OnePNL_1.Unit_width_Space_Toset_2)/Value_Input_Set_Size_OnePNL_1.Unit_width);

   if   n10<>(Value_Input_Set_Size_OnePNL_1.Set_Long_Min+Value_Input_Set_Size_OnePNL_1.Unit_Long_Space_ToUnit-Value_Input_Set_Size_OnePNL_1.Unit_Long_Space_Toset_1-Value_Input_Set_Size_OnePNL_1.Unit_Long_Space_Toset_2)/Value_Input_Set_Size_OnePNL_1.Unit_Long then
      n10:=n10+1;
   if    n12<>(Value_Input_Set_Size_OnePNL_1.Set_width_Max+Value_Input_Set_Size_OnePNL_1.Unit_width_Space_ToUnit-Value_Input_Set_Size_OnePNL_1.Unit_width_Space_Toset_1-Value_Input_Set_Size_OnePNL_1.Unit_width_Space_Toset_2)/Value_Input_Set_Size_OnePNL_1.Unit_width then
      n12:=n12+1;

   if (n10>0) and (n11>0) and (n12>0) and (n13>0) then
   begin
     for i:=n10 to n11 do
     begin
       for j:=n12 to n13 do
       begin
         //����SET����
         tem_long:=Value_Input_Set_Size_OnePNL_1.Unit_Long*i+Value_Input_Set_Size_OnePNL_1.Unit_Long_Space_ToUnit*(i-1)+Value_Input_Set_Size_OnePNL_1.Unit_Long_Space_Toset_1+Value_Input_Set_Size_OnePNL_1.Unit_Long_Space_Toset_2  ;
         tem_width:=Value_Input_Set_Size_OnePNL_1.Unit_width*j+Value_Input_Set_Size_OnePNL_1.Unit_width_Space_ToUnit*(j-1)+Value_Input_Set_Size_OnePNL_1.Unit_width_Space_Toset_1+Value_Input_Set_Size_OnePNL_1.Unit_width_Space_Toset_2  ;

         Value_Input_PCB_SIZE_OnePNL_1:=Input_PCB_SIZE_OnePNL;
         Value_Input_PCB_SIZE_OnePNL_1.Unit_Long:=tem_long;
         Value_Input_PCB_SIZE_OnePNL_1.Unit_Width:=tem_width;
         function_resule1:=Calculate_Unit_OnePNL(Value_Input_PCB_SIZE_OnePNL_1);
         if unit_to_set_pnl_sheet1=1 then
            PAResult_MakeUp^[0].Long_SET:=0;
       end;
     end;
   end;
   Result:=true;
end;

function TCutSheet.Get_Change_PNL_Long_Width: boolean;
begin
  Result:=Change_PNL_Long_Width1;
end;

procedure TCutSheet.Set_Change_PNL_Long_Width(  const Value: boolean);
begin
   Change_PNL_Long_Width1:=value;
end;

function TCutSheet.Get_No_Calculate_Falchion_Number: boolean;
begin
  result:=No_Calculate_Falchion_Number1;
end;

procedure TCutSheet.Set_No_Calculate_Falchion_Number(const Value: boolean);
begin
  No_Calculate_Falchion_Number1:=value;
end;

constructor TCutSheet.Create(ASheet:PAParam_Sheet;AResult_MakeUp:PAResult_MakeUp;iResultCountPerSheet:integer);
begin
  inherited Create;
  Input_Sheet_Size_OnePNL:=ASheet;
  PAResult_MakeUp:=AResult_MakeUp;
  FResultCountPerSheet:=iResultCountPerSheet;
end;

procedure TCutSheet.Sort_Result;
  procedure QuickSort(var A:TAResult_MakeUp; iLo, iHi: Integer;AscOrd:boolean=true);
  var
    Lo, Hi: Integer;
    Mid:currency;
    T: TResult_MakeUp;
  begin
    Lo := iLo;
    Hi := iHi;
    Mid := A[(Lo + Hi) div 2].Using_Rate;
    repeat
      if AscOrd then
      begin
        while A[Lo].Using_Rate > Mid do Inc(Lo);
        while A[Hi].Using_Rate < Mid do  Dec(Hi);
      end else begin
        while A[Lo].Using_Rate < Mid do Inc(Lo);
        while A[Hi].Using_Rate > Mid do  Dec(Hi);
      end;
      if Lo <= Hi then
      begin
        T := A[Lo];
        A[Lo]:= A[Hi];
        A[Hi]:= T;
        Inc(Lo);
        Dec(Hi);
      end;
    until Lo > Hi;
    if Hi > iLo then QuickSort(A, iLo, Hi);
    if Lo < iHi then QuickSort(A, Lo, iHi);
  end;
begin
  QuickSort(PAResult_MakeUp^,Low(PAResult_MakeUp^), High(PAResult_MakeUp^));
end;


end.
