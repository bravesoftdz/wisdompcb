unit spell2;

interface
uses
  Messages,SysUtils,StdCtrls,Dialogs,ExtCtrls,math,Graphics,wintypes,ComCtrls;

TYPE
   //��������ĳߴ�
   TParam_PCB2=record
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

        PNLB_Long_Max:currency;//PNLB������
        PNLB_Width_Max:currency;//PNLB������
        PNLB_Long_Min:currency;//PNLB������
        PNLB_Width_Min:currency;//PNLB������
     end;

     PAParam_Sheet2=^TAParam_Sheet2;
     PAResult_MakeUp2=^TAResult_MakeUp2;

   //���ڴ��������
   TParam_Sheet2=record
       Sheet_Long:currency;
       Sheet_Width:currency;
   end;
   TAParam_Sheet2=array of TParam_Sheet2;
   
    //��������Ľ��
   TResult_MakeUp2=record
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
        //���ڴ�PNLB�Ű���Ϣ
        PNLB_Unit_Long:currency;//PNLB��Ԫ��
        PNLB_Unit_Width:currency;//PNLB��Ԫ��
        PNLB_Unit_Long_Space:currency;//PNLB��Ԫ�����
        PNLB_Unit_Width_Space:currency;//PNLB��Ԫ����
        PNLB_Unit_Long_ToPNL:currency;//PNLB��Ԫ�����߾���
        PNLB_Unit_Width_ToPNL:currency;//PNLB��Ԫ���߾���
        PNLB_Unit_Long_Number:integer;//PNLB��Ԫ�� ����
        PNLB_Unit_Width_Number:integer;//PNLB��Ԫ�����
        PNLB_Long:currency;//PNLB��
        PNLB_Width:currency;//PNLB��
        //���ڴ濪����Ϣ
        One_Section_Long:currency;//һ���峤 ,һ������������PNLA��PNLB��ǰ���PNLA,PNLB��һ��,�������ڻ�ͼ
        One_Section_Width:currency;//һ�����
        One_Section_Long_Number:integer;//һ���峤����
        One_Section_Width_Number:integer;//һ��������
        One_Section_Unit_Number:integer;//һ���ܵ�Ԫ����

        Two_Section_LongA:currency;//�����峤a
        Two_Section_WidthA:currency;//�������a
        Two_Section_Long_NumberA:integer;//�����峤���� a
        Two_Section_Width_NumberA:integer;//���������� a
        Two_Section_LongB:currency;//�����峤 b
        Two_Section_WidthB:currency;//�������b
        Two_Section_Long_NumberB:integer;//�����峤���� b
        Two_Section_Width_NumberB:integer;//���������� b
        Two_Section_Longc:currency;//�����峤 c
        Two_Section_Widthc:currency;//�������c
        Two_Section_Long_Numberc:integer;//�����峤���� c
        Two_Section_Width_Numberc:integer;//���������� c
        Two_Section_Unit_Number:integer;//�����ܵ�Ԫ����
        Two_Section_Array_type:integer;//�����ŷ�ʽ.1,��ʾPNLA���ڳ��߲���,PNLB��PNLA��X��ͬ,2��ʾPNLA���ڿ��,PNLB��PNLA��Y��ͬ

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

        One_Section_PNLA_number:integer; //һ��PNLA����
        One_Section_PNLB_number:integer; //һ��PNLB����
        Two_Section_PNLA_number:integer; //����PNLA����
        Two_Section_PNLB_number:integer; //����PNLB����
        Three_Section_PNLA_number:integer;//����PNLA����
        Three_Section_PNLB_number:integer;//����PNLB����

        PNLA_number_Per_Sheet:integer; //��PNLA����
        PNLB_number_Per_Sheet:integer; //��PNLB����

        Sheet_Long:currency;//���ϳ�
        Sheet_Width:currency;//���Ͽ�

        Using_Rate:currency;//������������
        Unit_Using_Rate:currency;//��Ԫ������
        Pnl_Using_Rate:currency;//PNL����

        Draw_type:integer;
      end;
      TAResult_MakeUp2=array of TResult_MakeUp2;

   //��ʱ���PNL���,���ڴ�ź����ķ���ֵ
    TResult_PNL2=record
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
        //���ڴ�PNLB�Ű���Ϣ
        PNLB_Unit_Long:currency;//PNLB��Ԫ��
        PNLB_Unit_Width:currency;//PNLB��Ԫ��
        PNLB_Unit_Long_Space:currency;//PNLB��Ԫ�����
        PNLB_Unit_Width_Space:currency;//PNLB��Ԫ����
        PNLB_Unit_Long_ToPNL:currency;//PNLB��Ԫ�����߾���
        PNLB_Unit_Width_ToPNL:currency;//PNLB��Ԫ���߾���
        PNLB_Unit_Long_Number:integer;//PNLB��Ԫ�� ����
        PNLB_Unit_Width_Number:integer;//PNLB��Ԫ�����
        PNLB_Long:currency;//PNLB��
        PNLB_Width:currency;//PNLB��
      end;


   TCutSheet2 = class
   private
       Echange_Unit_To_Unit_Space1:boolean ; //����Ԫ��������� Ĭ��Ϊ������
       Echange_Unit_To_PNL_Space1:boolean;  //����Ԫ�߾���� Ĭ��Ϊ������
       tsa:string;
      Leave_Section_falchion_number1:integer;//ʣ�¿�������,=2ֻ����������=3����������
      Summation_rate:Double	;//��������
      Tem_Calculate_Rate_Type1:Integer;//���������ʵķ���,1�õ�Ԫ�ߴ����,��Ԫ�ߴ���Ե�Ԫ�����ٳ��Դ��ϳߴ�;2��PNL�ߴ����,PNL�ߴ����PNL�ܸ����ٳ��Դ��ϳߴ�
      Param_Sheet2:PAParam_Sheet2;  //�������Ĵ�������
      Param_PCB2:TParam_PCB2;//�������ĳߴ�,Ϊ��¼��,��Ԫ��,��,���,�߿�,������
      Result_MakeUp2:PAResult_MakeUp2; //��ż����Ľ��ֵ
      Tem_TProgressBar1:TProgressBar;//���ڴ��TProgressBar�ؼ�,Ҫ��ʾ�Ľ�����
      Tem_Calculate_Array_Complete_Time_Display:boolean;//�Ƿ���ʾ������Ҫ��ʱ��
      Falchion_Number1:INTEGER;//��������
      Calculate_Falchion_Number_Equality_Hold_1:boolean;//���ڶ����Ƿ�����ȵĿ�������
      Calculate_Flag1:integer;//�Ƿ�������,���ɷ�����ų�һ����һ�������Ű�
      Change_PNL_Long_Width1:boolean;  //�����PNL����������
      No_Calculate_Falchion_Number1:boolean;  //�����㵶��
      MaxPnlNumber2:integer;//���ڼ���PNL����ÿ�Ŵ��ϵ�

      FResultCountPerSheet:integer;
      FResultCount,FA:integer;

     procedure Sort_Result;
     function Calculate_Unit_TwoPNL(var VALUE:TParam_PCB2):BOOLEAN; //�ӵ�Ԫ��PNL
     //���ڼ����,����PNLA��PNLB�ĸ���
     function Change_pnla_pnlb_number1(const  PnlA2, PnlB2,valuen1,valuen2: integer; var Two_pnlA2,Two_PnlB2: integer):boolean;
           //��������PNLA�ĳߴ�ٸ�Ϊ��һ���ĳ�����ȵ�����
     function Echange_Two_And_Three_Section_Data(var value1:ARRAY OF TResult_MakeUp2):boolean;
     function Calculate_TwoPNL_Sheet_1(const value2:TResult_PNL2;const value22:TParam_Sheet2;const value_pnla:integer;iSheet:integer=0):boolean;//��PNL��SHEET
     function Calculate_TwoPNL_Sheet_2(const value332,Two_Section_PNLvalue33,Three_Section_PNLvalue33:TResult_PNL2;const value333_sheet,Two_Section_value333,Three_Section_value333:TParam_Sheet2;pnl_long_number3331,pnl_width_number3331,type333,Two_Section_Draw_value333,Three_Section_Draw_value333,value_pnla2,Two_value_pnla2,Three_value_pnla2:integer;iSheet:integer=0):boolean;//��PNL��SHEET

      //��ʱ��,����PNLA��PNLB����
     function Pnla_PnlB_number(var value1:array of TResult_MakeUp2):boolean;

    //���ڷ��ؼ���Ľ������
    function Get_Calculate_Result_Number: integer;
    function Get_Input_PCB_SIZE_TwoPNL_1: TParam_PCB2;
    function Get_Input_Sheet_Size_TwoPNL_1(Index: integer): TParam_Sheet2;
    procedure Set_Input_PCB_SIZE_TwoPNL_1(const Value: TParam_PCB2);
    procedure Set_Input_Sheet_Size_TwoPNL_1(Index: integer;const Value: TParam_Sheet2);
    procedure Set_tresult_makeup_using_Sheet_TwoPNL_1(index: integer;const Value: TResult_MakeUp2);
    function Get_tresult_makeup_using_Sheet_TwoPNL_1(index: integer): TResult_MakeUp2;
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
    function Get_Change_PNL_Long_Width: boolean;
    function Get_No_Calculate_Falchion_Number: boolean;
    procedure Set_Change_PNL_Long_Width(const Value: boolean);
    procedure Set_No_Calculate_Falchion_Number(const Value: boolean);
   public
      constructor Create(ASheet:PAParam_Sheet2;AResult_MakeUp:PAResult_MakeUp2;iResultCountPerSheet:integer); overload;
       procedure Calculate_Array();
       //ʣ�µ���������ּ�����,2:������;3:������,
       property Leave_Section_falchion_number:integer read Get_Leave_Section_falchion_number write Set_Leave_Section_falchion_number1;
       //���ϳߴ�����,���50,��0��ʼ
       property  Input_Sheet_Size[Index:integer]:TParam_Sheet2 Read Get_Input_Sheet_Size_TwoPNL_1 Write Set_Input_Sheet_Size_TwoPNL_1;
       //�������ĳߴ�,Ϊ��¼��,��Ԫ��,��,���,�߿�,������
       property Input_PCB_SIZE:TParam_PCB2 read Get_Input_PCB_SIZE_TwoPNL_1 WRITE Set_Input_PCB_SIZE_TwoPNL_1;
       //���ڷ��ؼ�����
       property Calculate_Result[index:integer]:TResult_MakeUp2 Read Get_tresult_makeup_using_Sheet_TwoPNL_1 Write Set_tresult_makeup_using_Sheet_TwoPNL_1;
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
       PROPerty Calculate_Rate_Type:integer read Get_Tem_Calculate_Rate_Type1 write Set_Tem_Calculate_Rate_Type1;
       //�Ƿ񱣴浶����ȵ�
       property   Calculate_Falchion_Number_Equality_Hold:boolean READ Get_Calculate_Falchion_Number_Equality_Hold write Set_Calculate_Falchion_Number_Equality_Hold;
       //�����PNL����������
       property  Change_PNL_Long_Width:boolean read  Get_Change_PNL_Long_Width write Set_Change_PNL_Long_Width;
       //�����㵶��
       property    No_Calculate_Falchion_Number:boolean  read Get_No_Calculate_Falchion_Number write Set_No_Calculate_Falchion_Number;
   end;

var
  CutSheet2:TCutSheet2;

implementation

procedure TCutSheet2.Calculate_Array;//�����Ű�,����
var
  function_resule1:boolean;
  tem_Param_PCB2:TParam_PCB2;
  tem_timeTime1,tem_timeTime2,tem_timeTime3: TDateTime;
  iStep,tem1:integer;
begin
   tem_timeTime1:=Time;
   MaxPnlNumber2:=0;
   Summation_rate:=0;
   Falchion_Number1:=100;//��������
   Tem_TProgressBar1.Min:=0;
   Tem_TProgressBar1.max:=100;
   Calculate_Flag1:=0;
   iStep:=4;
   if Echange_Unit_To_Unit_Space1 then iStep:=4+iStep;
   if Echange_Unit_To_PNL_Space1 then   iStep:=4+iStep;
   if (Echange_Unit_To_PNL_Space1) and (Echange_Unit_To_Unit_Space1) then  iStep:=4+iStep;
   tem1:=0;
   if Leave_Section_falchion_number1=0 then Leave_Section_falchion_number1:=2; //û�������Ű淽��ʱ,Ĭ��Ϊ:2,������ֻ������������
   Tem_TProgressBar1.Position:=1;
   //if Tem_Calculate_Rate_Type1=0 then Tem_Calculate_Rate_Type1:=1;//û��������������ʵķ���ʱ,Ĭ��Ϊ:1,�Ե�Ԫ����.
   tem_Param_PCB2:=Param_PCB2;
   function_resule1:=Calculate_Unit_TwoPNL(tem_Param_PCB2);
   tem1:=tem1+1;
   Tem_TProgressBar1.Position:=trunc(tem1*100/iStep);

    //��������������
   if Change_PNL_Long_Width1 then
   begin
      tem_Param_PCB2:=Param_PCB2;
      tem_Param_PCB2.PNLA_Long_Max :=Param_PCB2.PNLA_Width_Max;
      tem_Param_PCB2.PNLA_long_Min :=Param_PCB2.PNLA_width_Min;
      tem_Param_PCB2.PNLA_width_Max :=Param_PCB2.PNLA_long_Max;
      tem_Param_PCB2.PNLA_width_Min :=Param_PCB2.PNLA_long_Min;
      function_resule1:=Calculate_Unit_TwoPNL(tem_Param_PCB2);
      tem1:=tem1+1;
      Tem_TProgressBar1.Position:=trunc(tem1*100/iStep);
   end;

   tem_Param_PCB2:=Param_PCB2;
   tem_Param_PCB2.PNLb_Long_Max :=Param_PCB2.PNLb_Width_Max;
   tem_Param_PCB2.PNLb_long_Min :=Param_PCB2.PNLb_width_Min;
   tem_Param_PCB2.PNLb_width_Max :=Param_PCB2.PNLb_long_Max;
   tem_Param_PCB2.PNLb_width_Min :=Param_PCB2.PNLb_long_Min;
   function_resule1:=Calculate_Unit_TwoPNL(tem_Param_PCB2);
   tem1:=tem1+1;
   Tem_TProgressBar1.Position:=trunc(tem1*100/iStep);

   tem_Param_PCB2:=Param_PCB2;
   tem_Param_PCB2.PNLA_Long_Max :=Param_PCB2.PNLA_Width_Max;
   tem_Param_PCB2.PNLA_long_Min :=Param_PCB2.PNLA_width_Min;
   tem_Param_PCB2.PNLA_width_Max :=Param_PCB2.PNLA_long_Max;
   tem_Param_PCB2.PNLA_width_Min :=Param_PCB2.PNLA_long_Min;
   tem_Param_PCB2.PNLb_Long_Max :=Param_PCB2.PNLb_Width_Max;
   tem_Param_PCB2.PNLb_long_Min :=Param_PCB2.PNLb_width_Min;
   tem_Param_PCB2.PNLb_width_Max :=Param_PCB2.PNLb_long_Max;
   tem_Param_PCB2.PNLb_width_Min :=Param_PCB2.PNLb_long_Min;
   function_resule1:=Calculate_Unit_TwoPNL(tem_Param_PCB2);
   tem1:=tem1+1;
   Tem_TProgressBar1.Position:=trunc(tem1*100/iStep);

   //����Ԫ��������� Ĭ��Ϊ������  ����Ԫ��ཻ���ٵ�������ĺ���
   if Echange_Unit_To_Unit_Space1 then
   begin
     tem_Param_PCB2:=Param_PCB2;
     tem_Param_PCB2.Unit_Long_Space:=Param_PCB2.Unit_Width_Space;
     tem_Param_PCB2.Unit_Width_Space:=Param_PCB2.Unit_Long_Space;
     function_resule1:=Calculate_Unit_TwoPNL(tem_Param_PCB2);
     tem1:=tem1+1;
     Tem_TProgressBar1.Position:=trunc(tem1*100/iStep);

     if Change_PNL_Long_Width1 then  //��������������
     begin
       tem_Param_PCB2:=Param_PCB2;
       tem_Param_PCB2.Unit_Long_Space:=Param_PCB2.Unit_Width_Space;
       tem_Param_PCB2.Unit_Width_Space:=Param_PCB2.Unit_Long_Space;
       tem_Param_PCB2.PNLA_Long_Max :=Param_PCB2.PNLA_Width_Max;
       tem_Param_PCB2.PNLA_long_Min :=Param_PCB2.PNLA_width_Min;
       tem_Param_PCB2.PNLA_width_Max :=Param_PCB2.PNLA_long_Max;
       tem_Param_PCB2.PNLA_width_Min :=Param_PCB2.PNLA_long_Min;
       function_resule1:=Calculate_Unit_TwoPNL(tem_Param_PCB2);
       tem1:=tem1+1;
       Tem_TProgressBar1.Position:=trunc(tem1*100/iStep);
     end;

     tem_Param_PCB2:=Param_PCB2;
     tem_Param_PCB2.Unit_Long_Space:=Param_PCB2.Unit_Width_Space;
     tem_Param_PCB2.Unit_Width_Space:=Param_PCB2.Unit_Long_Space;
     tem_Param_PCB2.PNLb_Long_Max :=Param_PCB2.PNLb_Width_Max;
     tem_Param_PCB2.PNLb_long_Min :=Param_PCB2.PNLb_width_Min;
     tem_Param_PCB2.PNLb_width_Max :=Param_PCB2.PNLb_long_Max;
     tem_Param_PCB2.PNLb_width_Min :=Param_PCB2.PNLb_long_Min;
     function_resule1:=Calculate_Unit_TwoPNL(tem_Param_PCB2);
     tem1:=tem1+1;
     Tem_TProgressBar1.Position:=trunc(tem1*100/iStep);

     tem_Param_PCB2:=Param_PCB2;
     tem_Param_PCB2.Unit_Long_Space:=Param_PCB2.Unit_Width_Space;
     tem_Param_PCB2.Unit_Width_Space:=Param_PCB2.Unit_Long_Space;
     tem_Param_PCB2.PNLA_Long_Max :=Param_PCB2.PNLA_Width_Max;
     tem_Param_PCB2.PNLA_long_Min :=Param_PCB2.PNLA_width_Min;
     tem_Param_PCB2.PNLA_width_Max :=Param_PCB2.PNLA_long_Max;
     tem_Param_PCB2.PNLA_width_Min :=Param_PCB2.PNLA_long_Min;
     tem_Param_PCB2.PNLb_Long_Max :=Param_PCB2.PNLb_Width_Max;
     tem_Param_PCB2.PNLb_long_Min :=Param_PCB2.PNLb_width_Min;
     tem_Param_PCB2.PNLb_width_Max :=Param_PCB2.PNLb_long_Max;
     tem_Param_PCB2.PNLb_width_Min :=Param_PCB2.PNLb_long_Min;
     function_resule1:=Calculate_Unit_TwoPNL(tem_Param_PCB2);
     tem1:=tem1+1;
     Tem_TProgressBar1.Position:=trunc(tem1*100/iStep);
   end;

   //����Ԫ�߾���� Ĭ��Ϊ������   ���߾�����ٵ�������ĺ���
   if Echange_Unit_To_PNL_Space1 then
   begin
     tem_Param_PCB2:=Param_PCB2;
     tem_Param_PCB2.Unit_Long_ToPNL:=Param_PCB2.Unit_Width_ToPNL ;
     tem_Param_PCB2.Unit_Width_ToPNL:=Param_PCB2.Unit_Long_ToPNL;
     function_resule1:=Calculate_Unit_TwoPNL(tem_Param_PCB2);
     tem1:=tem1+1;
     Tem_TProgressBar1.Position:=trunc(tem1*100/iStep);

     if Change_PNL_Long_Width1 then  //��������������
     begin
       tem_Param_PCB2:=Param_PCB2;
       tem_Param_PCB2.Unit_Long_ToPNL:=Param_PCB2.Unit_Width_ToPNL ;
       tem_Param_PCB2.Unit_Width_ToPNL:=Param_PCB2.Unit_Long_ToPNL;
       tem_Param_PCB2.PNLA_Long_Max :=Param_PCB2.PNLA_Width_Max;
       tem_Param_PCB2.PNLA_long_Min :=Param_PCB2.PNLA_width_Min;
       tem_Param_PCB2.PNLA_width_Max :=Param_PCB2.PNLA_long_Max;
       tem_Param_PCB2.PNLA_width_Min :=Param_PCB2.PNLA_long_Min;
       function_resule1:=Calculate_Unit_TwoPNL(tem_Param_PCB2);
       tem1:=tem1+1;
       Tem_TProgressBar1.Position:=trunc(tem1*100/iStep);
     end;

     tem_Param_PCB2:=Param_PCB2;
     tem_Param_PCB2.Unit_Long_ToPNL:=Param_PCB2.Unit_Width_ToPNL ;
     tem_Param_PCB2.Unit_Width_ToPNL:=Param_PCB2.Unit_Long_ToPNL;
     tem_Param_PCB2.PNLb_Long_Max :=Param_PCB2.PNLb_Width_Max;
     tem_Param_PCB2.PNLb_long_Min :=Param_PCB2.PNLb_width_Min;
     tem_Param_PCB2.PNLb_width_Max :=Param_PCB2.PNLb_long_Max;
     tem_Param_PCB2.PNLb_width_Min :=Param_PCB2.PNLb_long_Min;
     function_resule1:=Calculate_Unit_TwoPNL(tem_Param_PCB2);
     tem1:=tem1+1;
     Tem_TProgressBar1.Position:=trunc(tem1*100/iStep);

     tem_Param_PCB2:=Param_PCB2;
     tem_Param_PCB2.Unit_Long_ToPNL:=Param_PCB2.Unit_Width_ToPNL ;
     tem_Param_PCB2.Unit_Width_ToPNL:=Param_PCB2.Unit_Long_ToPNL;
     tem_Param_PCB2.PNLA_Long_Max :=Param_PCB2.PNLA_Width_Max;
     tem_Param_PCB2.PNLA_long_Min :=Param_PCB2.PNLA_width_Min;
     tem_Param_PCB2.PNLA_width_Max :=Param_PCB2.PNLA_long_Max;
     tem_Param_PCB2.PNLA_width_Min :=Param_PCB2.PNLA_long_Min;
     tem_Param_PCB2.PNLb_Long_Max :=Param_PCB2.PNLb_Width_Max;
     tem_Param_PCB2.PNLb_long_Min :=Param_PCB2.PNLb_width_Min;
     tem_Param_PCB2.PNLb_width_Max :=Param_PCB2.PNLb_long_Max;
     tem_Param_PCB2.PNLb_width_Min :=Param_PCB2.PNLb_long_Min;
     function_resule1:=Calculate_Unit_TwoPNL(tem_Param_PCB2);
     tem1:=tem1+1;
     Tem_TProgressBar1.Position:=trunc(tem1*100/iStep);
   end;

   //����Ԫ�߾����������Ԫ���������
   if Echange_Unit_To_Unit_Space1 and Echange_Unit_To_PNL_Space1 then //������ѡ��ʱ
   begin
     tem_Param_PCB2:=Param_PCB2;
     tem_Param_PCB2.Unit_Long_Space:=Param_PCB2.Unit_Width_Space;
     tem_Param_PCB2.Unit_Width_Space:=Param_PCB2.Unit_Long_Space;
     tem_Param_PCB2.Unit_Long_ToPNL:=Param_PCB2.Unit_Width_ToPNL ;
     tem_Param_PCB2.Unit_Width_ToPNL:=Param_PCB2.Unit_Long_ToPNL;
     function_resule1:=Calculate_Unit_TwoPNL(tem_Param_PCB2);
     tem1:=tem1+1;
     Tem_TProgressBar1.Position:=trunc(tem1*100/iStep);

     if Change_PNL_Long_Width1 then
     begin
       //��������������
       tem_Param_PCB2:=Param_PCB2;
       tem_Param_PCB2.Unit_Long_Space:=Param_PCB2.Unit_Width_Space;
       tem_Param_PCB2.Unit_Width_Space:=Param_PCB2.Unit_Long_Space;
       tem_Param_PCB2.Unit_Long_ToPNL:=Param_PCB2.Unit_Width_ToPNL ;
       tem_Param_PCB2.Unit_Width_ToPNL:=Param_PCB2.Unit_Long_ToPNL;
       tem_Param_PCB2.PNLA_Long_Max :=Param_PCB2.PNLA_Width_Max;
       tem_Param_PCB2.PNLA_long_Min :=Param_PCB2.PNLA_width_Min;
       tem_Param_PCB2.PNLA_width_Max :=Param_PCB2.PNLA_long_Max;
       tem_Param_PCB2.PNLA_width_Min :=Param_PCB2.PNLA_long_Min;
       function_resule1:=Calculate_Unit_TwoPNL(tem_Param_PCB2);
       tem1:=tem1+1;
       Tem_TProgressBar1.Position:=trunc(tem1*100/iStep);
     end;

     tem_Param_PCB2:=Param_PCB2;
     tem_Param_PCB2.Unit_Long_Space:=Param_PCB2.Unit_Width_Space;
     tem_Param_PCB2.Unit_Width_Space:=Param_PCB2.Unit_Long_Space;
     tem_Param_PCB2.Unit_Long_ToPNL:=Param_PCB2.Unit_Width_ToPNL ;
     tem_Param_PCB2.Unit_Width_ToPNL:=Param_PCB2.Unit_Long_ToPNL;
     tem_Param_PCB2.PNLb_Long_Max :=Param_PCB2.PNLb_Width_Max;
     tem_Param_PCB2.PNLb_long_Min :=Param_PCB2.PNLb_width_Min;
     tem_Param_PCB2.PNLb_width_Max :=Param_PCB2.PNLb_long_Max;
     tem_Param_PCB2.PNLb_width_Min :=Param_PCB2.PNLb_long_Min;
     function_resule1:=Calculate_Unit_TwoPNL(tem_Param_PCB2);
     tem1:=tem1+1;
     Tem_TProgressBar1.Position:=trunc(tem1*100/iStep);

     tem_Param_PCB2:=Param_PCB2;
     tem_Param_PCB2.Unit_Long_Space:=Param_PCB2.Unit_Width_Space;
     tem_Param_PCB2.Unit_Width_Space:=Param_PCB2.Unit_Long_Space;
     tem_Param_PCB2.Unit_Long_ToPNL:=Param_PCB2.Unit_Width_ToPNL ;
     tem_Param_PCB2.Unit_Width_ToPNL:=Param_PCB2.Unit_Long_ToPNL;
     tem_Param_PCB2.PNLA_Long_Max :=Param_PCB2.PNLA_Width_Max;
     tem_Param_PCB2.PNLA_long_Min :=Param_PCB2.PNLA_width_Min;
     tem_Param_PCB2.PNLA_width_Max :=Param_PCB2.PNLA_long_Max;
     tem_Param_PCB2.PNLA_width_Min :=Param_PCB2.PNLA_long_Min;
     tem_Param_PCB2.PNLb_Long_Max :=Param_PCB2.PNLb_Width_Max;
     tem_Param_PCB2.PNLb_long_Min :=Param_PCB2.PNLb_width_Min;
     tem_Param_PCB2.PNLb_width_Max :=Param_PCB2.PNLb_long_Max;
     tem_Param_PCB2.PNLb_width_Min :=Param_PCB2.PNLb_long_Min;
     function_resule1:=Calculate_Unit_TwoPNL(tem_Param_PCB2);
     tem1:=tem1+1;
     Tem_TProgressBar1.Position:=trunc(tem1*100/iStep);
   end;

   function_resule1:=Echange_Two_And_Three_Section_Data(Result_MakeUp2^);//������������PNLA��PNLBλ��
   function_resule1:=Pnla_PnlB_number(Result_MakeUp2^);                  //��ʱ�ü���PNLA��PNLB����
   if Calculate_Flag1=0 then   showmessage('��Ĵ������޷�Χ!����!') else Sort_Result;
   Tem_TProgressBar1.Position:=Tem_TProgressBar1.Max;
end;

procedure TCutSheet2.Calculate_Array_Complete_Percent_2(
  V_ProgressBar1: TProgressBar; V_ProgressBar1_Position: INTEGER);
begin
  V_ProgressBar1.Position:=V_ProgressBar1_Position;
end;

procedure TCutSheet2.Calculate_Array_Complete_Percent_1(
  V_ProgressBar1: TProgressBar; V_ProgressBar1_Min,
  V_ProgressBar1_MAX: INTEGER);
begin
  V_ProgressBar1.Min:=V_ProgressBar1_Min;
  V_ProgressBar1.Max:=V_ProgressBar1_MAX;
end;

function TCutSheet2.Calculate_TwoPNL_Sheet_1(const value2: TResult_PNL2;//PNLA��PNLBֵ
                      const value22:TParam_Sheet2  //���ϳ���
                      ;const value_pnla:integer;//���ڴ�PNLA����PNLB,1����PNLA;2����PNLB
                      iSheet:integer=0): boolean;
var
  i10,j10 ,n10,n11 :integer;  //���ڼ�¼�������PNL����
  function_result001:boolean;
  tepvalue2,tepvalue3:TResult_PNL2;
  tem_Sheet_Size_TwoPNL2,tem_Sheet_Size_TwoPNL3:TParam_Sheet2;
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
           //���з������ŷ�   type=1 ��type=2 ,��ʣ�µ����ֳߴ����� ���ú���Calculate_TwoPNL_Sheet_2
                                       // |--------|-------|
           //��һ���ŷ�,��һ�����ƽ�п�  |        |       |
//--------------------------              |--------|       |
//                                        |        |       |
           //����, ����                   |--------|-------|
           tem_Sheet_Size_TwoPNL2.Sheet_Long:=value22.Sheet_Long-i10*value2.PNLA_Long;//������
           tem_Sheet_Size_TwoPNL2.Sheet_Width:=value22.Sheet_Width ;//������
           tem_Sheet_Size_TwoPNL3.Sheet_Long:=i10*value2.PNLA_Long;//������
           tem_Sheet_Size_TwoPNL3.Sheet_Width:=value22.Sheet_Width-j10*value2.PNLA_Width;//������
           tepvalue2:=value2; //���ڶԵ�
           tepvalue3:=value2;
           function_result001:=Calculate_TwoPNL_Sheet_2(value2,tepvalue2,tepvalue3,value22,tem_Sheet_Size_TwoPNL2,tem_Sheet_Size_TwoPNL3,i10,j10,1,1,1,value_pnla,1,1,iSheet);
           //�Ե���������
           tem_Sheet_Size_TwoPNL2.Sheet_Long:=value22.Sheet_Width;//������
           tem_Sheet_Size_TwoPNL2.Sheet_Width:= value22.Sheet_Long-i10*value2.PNLA_Long;//������
           tem_Sheet_Size_TwoPNL3.Sheet_Long:=i10*value2.PNLA_Long;//������
           tem_Sheet_Size_TwoPNL3.Sheet_Width:=value22.Sheet_Width-j10*value2.PNLA_Width;//������
           function_result001:=Calculate_TwoPNL_Sheet_2(value2,tepvalue2,tepvalue3,value22,tem_Sheet_Size_TwoPNL2,tem_Sheet_Size_TwoPNL3,i10,j10,1,2,1,value_pnla,1,1,iSheet);
           //�Ե���������
           tem_Sheet_Size_TwoPNL2.Sheet_Long:=value22.Sheet_Long-i10*value2.PNLA_Long;//������
           tem_Sheet_Size_TwoPNL2.Sheet_Width:=value22.Sheet_Width ;//������
           tem_Sheet_Size_TwoPNL3.Sheet_Long:=value22.Sheet_Width-j10*value2.PNLA_Width;//������
           tem_Sheet_Size_TwoPNL3.Sheet_Width:=i10*value2.PNLA_Long;//������
           function_result001:=Calculate_TwoPNL_Sheet_2(value2,tepvalue2,tepvalue3,value22,tem_Sheet_Size_TwoPNL2,tem_Sheet_Size_TwoPNL3,i10,j10,1,1,2,value_pnla,1,1,iSheet);
           //�Ե�����,��������
           tem_Sheet_Size_TwoPNL2.Sheet_Long:=value22.Sheet_Width;//������
           tem_Sheet_Size_TwoPNL2.Sheet_Width:= value22.Sheet_Long-i10*value2.PNLA_Long;//������
           tem_Sheet_Size_TwoPNL3.Sheet_Long:=value22.Sheet_Width-j10*value2.PNLA_Width;//������
           tem_Sheet_Size_TwoPNL3.Sheet_Width:=i10*value2.PNLA_Long;//������
           function_result001:=Calculate_TwoPNL_Sheet_2(value2,tepvalue2,tepvalue3,value22,tem_Sheet_Size_TwoPNL2,tem_Sheet_Size_TwoPNL3,i10,j10,1,2,2,value_pnla,1,1,iSheet);

           //�Ե�����PNLB��PNLA
           tem_Sheet_Size_TwoPNL2.Sheet_Long:=value22.Sheet_Long-i10*value2.PNLA_Long;//������
           tem_Sheet_Size_TwoPNL2.Sheet_Width:=value22.Sheet_Width ;//������
           tem_Sheet_Size_TwoPNL3.Sheet_Long:=i10*value2.PNLA_Long;//������
           tem_Sheet_Size_TwoPNL3.Sheet_Width:=value22.Sheet_Width-j10*value2.PNLA_Width;//������

           tepvalue2.PNLA_Unit_Long_Number :=value2.PNLb_Unit_Width_Number ;
           tepvalue2.PNLA_Unit_Width_Number :=value2.PNLb_Unit_Long_Number ;
           tepvalue2.PNLA_Long :=value2.PNLb_Width;
           tepvalue2.PNLA_Width :=value2.PNLb_Long;
           tepvalue2.PNLb_Unit_Long_Number :=value2.PNLa_Unit_Width_Number ;
           tepvalue2.PNLb_Unit_Width_Number :=value2.PNLa_Unit_Long_Number ;
           tepvalue2.PNLb_Long :=value2.PNLa_Width;
           tepvalue2.PNLb_Width :=value2.PNLa_Long;
           tepvalue3:=value2;
           function_result001:=Calculate_TwoPNL_Sheet_2(value2,tepvalue2,tepvalue3,value22,tem_Sheet_Size_TwoPNL2,tem_Sheet_Size_TwoPNL3,i10,j10,1,1,1,value_pnla,2,1,iSheet);
           //�Ե���������
           tem_Sheet_Size_TwoPNL2.Sheet_Long:=value22.Sheet_Width;//������
           tem_Sheet_Size_TwoPNL2.Sheet_Width:= value22.Sheet_Long-i10*value2.PNLA_Long;//������
           tem_Sheet_Size_TwoPNL3.Sheet_Long:=i10*value2.PNLA_Long;//������
           tem_Sheet_Size_TwoPNL3.Sheet_Width:=value22.Sheet_Width-j10*value2.PNLA_Width;//������
           function_result001:=Calculate_TwoPNL_Sheet_2(value2,tepvalue2,tepvalue3,value22,tem_Sheet_Size_TwoPNL2,tem_Sheet_Size_TwoPNL3,i10,j10,1,2,1,value_pnla,2,1,iSheet);
           //�Ե���������
           tem_Sheet_Size_TwoPNL2.Sheet_Long:=value22.Sheet_Long-i10*value2.PNLA_Long;//������
           tem_Sheet_Size_TwoPNL2.Sheet_Width:=value22.Sheet_Width ;//������
           tem_Sheet_Size_TwoPNL3.Sheet_Long:=value22.Sheet_Width-j10*value2.PNLA_Width;//������
           tem_Sheet_Size_TwoPNL3.Sheet_Width:=i10*value2.PNLA_Long;//������
           function_result001:=Calculate_TwoPNL_Sheet_2(value2,tepvalue2,tepvalue3,value22,tem_Sheet_Size_TwoPNL2,tem_Sheet_Size_TwoPNL3,i10,j10,1,1,2,value_pnla,2,1,iSheet);
           //�Ե�����,��������
           tem_Sheet_Size_TwoPNL2.Sheet_Long:=value22.Sheet_Width;//������
           tem_Sheet_Size_TwoPNL2.Sheet_Width:= value22.Sheet_Long-i10*value2.PNLA_Long;//������
           tem_Sheet_Size_TwoPNL3.Sheet_Long:=value22.Sheet_Width-j10*value2.PNLA_Width;//������
           tem_Sheet_Size_TwoPNL3.Sheet_Width:=i10*value2.PNLA_Long;//������
           function_result001:=Calculate_TwoPNL_Sheet_2(value2,tepvalue2,tepvalue3,value22,tem_Sheet_Size_TwoPNL2,tem_Sheet_Size_TwoPNL3,i10,j10,1,2,2,value_pnla,2,1,iSheet);

               //�Ե�����PNLB��PNLA
              tem_Sheet_Size_TwoPNL2.Sheet_Long:=value22.Sheet_Long-i10*value2.PNLA_Long;//������
              tem_Sheet_Size_TwoPNL2.Sheet_Width:=value22.Sheet_Width ;//������
              tem_Sheet_Size_TwoPNL3.Sheet_Long:=i10*value2.PNLA_Long;//������
              tem_Sheet_Size_TwoPNL3.Sheet_Width:=value22.Sheet_Width-j10*value2.PNLA_Width;//������
              tepvalue3:=value2;
              tepvalue3.PNLA_Unit_Long_Number :=value2.PNLb_Unit_Width_Number ;
              tepvalue3.PNLA_Unit_Width_Number :=value2.PNLb_Unit_Long_Number ;
              tepvalue3.PNLA_Long :=value2.PNLb_Width;
              tepvalue3.PNLA_Width :=value2.PNLb_Long;
              tepvalue3.PNLb_Unit_Long_Number :=value2.PNLa_Unit_Width_Number ;
              tepvalue3.PNLb_Unit_Width_Number :=value2.PNLa_Unit_Long_Number ;
              tepvalue3.PNLb_Long :=value2.PNLa_Width;
              tepvalue3.PNLb_Width :=value2.PNLa_Long;
              tepvalue2:=value2;
             function_result001:=Calculate_TwoPNL_Sheet_2(value2,tepvalue2,tepvalue3,value22,tem_Sheet_Size_TwoPNL2,tem_Sheet_Size_TwoPNL3,i10,j10,1,1,1,value_pnla,1,2,iSheet);
              //�Ե���������
              tem_Sheet_Size_TwoPNL2.Sheet_Long:=value22.Sheet_Width;//������
              tem_Sheet_Size_TwoPNL2.Sheet_Width:= value22.Sheet_Long-i10*value2.PNLA_Long;//������
              tem_Sheet_Size_TwoPNL3.Sheet_Long:=i10*value2.PNLA_Long;//������
              tem_Sheet_Size_TwoPNL3.Sheet_Width:=value22.Sheet_Width-j10*value2.PNLA_Width;//������
              function_result001:=Calculate_TwoPNL_Sheet_2(value2,tepvalue2,tepvalue3,value22,tem_Sheet_Size_TwoPNL2,tem_Sheet_Size_TwoPNL3,i10,j10,1,2,1,value_pnla,1,2,iSheet);
              //�Ե���������
             tem_Sheet_Size_TwoPNL2.Sheet_Long:=value22.Sheet_Long-i10*value2.PNLA_Long;//������
             tem_Sheet_Size_TwoPNL2.Sheet_Width:=value22.Sheet_Width ;//������
             tem_Sheet_Size_TwoPNL3.Sheet_Long:=value22.Sheet_Width-j10*value2.PNLA_Width;//������
             tem_Sheet_Size_TwoPNL3.Sheet_Width:=i10*value2.PNLA_Long;//������
             function_result001:=Calculate_TwoPNL_Sheet_2(value2,tepvalue2,tepvalue3,value22,tem_Sheet_Size_TwoPNL2,tem_Sheet_Size_TwoPNL3,i10,j10,1,1,2,value_pnla,1,2,iSheet);
             //�Ե�����,��������
             tem_Sheet_Size_TwoPNL2.Sheet_Long:=value22.Sheet_Width;//������
             tem_Sheet_Size_TwoPNL2.Sheet_Width:= value22.Sheet_Long-i10*value2.PNLA_Long;//������
             tem_Sheet_Size_TwoPNL3.Sheet_Long:=value22.Sheet_Width-j10*value2.PNLA_Width;//������
             tem_Sheet_Size_TwoPNL3.Sheet_Width:=i10*value2.PNLA_Long;//������
             function_result001:=Calculate_TwoPNL_Sheet_2(value2,tepvalue2,tepvalue3,value22,tem_Sheet_Size_TwoPNL2,tem_Sheet_Size_TwoPNL3,i10,j10,1,2,2,value_pnla,1,2,iSheet);
             //�Ե���������PNLB��PNLA

                //�Ե�����,����PNLB��PNLA
               tem_Sheet_Size_TwoPNL2.Sheet_Long:=value22.Sheet_Long-i10*value2.PNLA_Long;//������
               tem_Sheet_Size_TwoPNL2.Sheet_Width:=value22.Sheet_Width ;//������
               tem_Sheet_Size_TwoPNL3.Sheet_Long:=i10*value2.PNLA_Long;//������
               tem_Sheet_Size_TwoPNL3.Sheet_Width:=value22.Sheet_Width-j10*value2.PNLA_Width;//������
               tepvalue2:=value2;
               tepvalue2.PNLA_Unit_Long_Number :=value2.PNLb_Unit_Width_Number ;
               tepvalue2.PNLA_Unit_Width_Number :=value2.PNLb_Unit_Long_Number ;
               tepvalue2.PNLA_Long :=value2.PNLb_Width;
               tepvalue2.PNLA_Width :=value2.PNLb_Long;
               tepvalue2.PNLb_Unit_Long_Number :=value2.PNLa_Unit_Width_Number ;
               tepvalue2.PNLb_Unit_Width_Number :=value2.PNLa_Unit_Long_Number ;
               tepvalue2.PNLb_Long :=value2.PNLa_Width;
               tepvalue2.PNLb_Width :=value2.PNLa_Long;
               tepvalue3:=value2;
               tepvalue3.PNLA_Unit_Long_Number :=value2.PNLb_Unit_Width_Number ;
               tepvalue3.PNLA_Unit_Width_Number :=value2.PNLb_Unit_Long_Number ;
               tepvalue3.PNLA_Long :=value2.PNLb_Width;
               tepvalue3.PNLA_Width :=value2.PNLb_Long;
               tepvalue3.PNLb_Unit_Long_Number :=value2.PNLa_Unit_Width_Number ;
               tepvalue3.PNLb_Unit_Width_Number :=value2.PNLa_Unit_Long_Number ;
               tepvalue3.PNLb_Long :=value2.PNLa_Width;
               tepvalue3.PNLb_Width :=value2.PNLa_Long;
               function_result001:=Calculate_TwoPNL_Sheet_2(value2,tepvalue2,tepvalue3,value22,tem_Sheet_Size_TwoPNL2,tem_Sheet_Size_TwoPNL3,i10,j10,1,1,1,value_pnla,2,2,iSheet);
               //�Ե���������
               tem_Sheet_Size_TwoPNL2.Sheet_Long:=value22.Sheet_Width;//������
               tem_Sheet_Size_TwoPNL2.Sheet_Width:= value22.Sheet_Long-i10*value2.PNLA_Long;//������
               tem_Sheet_Size_TwoPNL3.Sheet_Long:=i10*value2.PNLA_Long;//������
               tem_Sheet_Size_TwoPNL3.Sheet_Width:=value22.Sheet_Width-j10*value2.PNLA_Width;//������

               function_result001:=Calculate_TwoPNL_Sheet_2(value2,tepvalue2,tepvalue3,value22,tem_Sheet_Size_TwoPNL2,tem_Sheet_Size_TwoPNL3,i10,j10,1,2,1,value_pnla,2,2,iSheet);
               //�Ե���������
              tem_Sheet_Size_TwoPNL2.Sheet_Long:=value22.Sheet_Long-i10*value2.PNLA_Long;//������
              tem_Sheet_Size_TwoPNL2.Sheet_Width:=value22.Sheet_Width ;//������
              tem_Sheet_Size_TwoPNL3.Sheet_Long:=value22.Sheet_Width-j10*value2.PNLA_Width;//������
              tem_Sheet_Size_TwoPNL3.Sheet_Width:=i10*value2.PNLA_Long;//������

              function_result001:=Calculate_TwoPNL_Sheet_2(value2,tepvalue2,tepvalue3,value22,tem_Sheet_Size_TwoPNL2,tem_Sheet_Size_TwoPNL3,i10,j10,1,1,2,value_pnla,2,2,iSheet);
              //�Ե�����,��������
              tem_Sheet_Size_TwoPNL2.Sheet_Long:=value22.Sheet_Width;//������
              tem_Sheet_Size_TwoPNL2.Sheet_Width:= value22.Sheet_Long-i10*value2.PNLA_Long;//������
              tem_Sheet_Size_TwoPNL3.Sheet_Long:=value22.Sheet_Width-j10*value2.PNLA_Width;//������
              tem_Sheet_Size_TwoPNL3.Sheet_Width:=i10*value2.PNLA_Long;//������
              function_result001:=Calculate_TwoPNL_Sheet_2(value2,tepvalue2,tepvalue3,value22,tem_Sheet_Size_TwoPNL2,tem_Sheet_Size_TwoPNL3,i10,j10,1,2,2,value_pnla,2,2,iSheet);
              //�Ե���������,����PNLB��PNLA
           //,���³���Ե�����,��������
//------------------------------------------------
                                              //  |-------------|--------------|
                                              //  |             |              |
                                              //  |             |              |
           //�ڶ����ŷ�,��һ���볤ƽ�п�      //  |-------------|--------------|
                                              //  |                            |
                                              //  |                            |
                                              //  |----------------------------|

           tem_Sheet_Size_TwoPNL2.Sheet_Long:=value22.Sheet_Long-i10*value2.PNLA_Long;//������
           tem_Sheet_Size_TwoPNL2.Sheet_Width:=j10*value2.PNLA_Width ;//������ value22.Sheet_Width
           tem_Sheet_Size_TwoPNL3.Sheet_Long:=value22.Sheet_Long;//i10*value2.PNLA_Long;//������
           tem_Sheet_Size_TwoPNL3.Sheet_Width:=value22.Sheet_Width-j10*value2.PNLA_Width;//������
           tepvalue2:=value2; //���ڶԵ�
           tepvalue3:=value2;
           function_result001:=Calculate_TwoPNL_Sheet_2(value2,tepvalue2,tepvalue3,value22,tem_Sheet_Size_TwoPNL2,tem_Sheet_Size_TwoPNL3,i10,j10,2,1,1,value_pnla,1,1,iSheet);
           //�Ե���������
           tem_Sheet_Size_TwoPNL2.Sheet_Long:=j10*value2.PNLA_Width;//������
           tem_Sheet_Size_TwoPNL2.Sheet_Width:=value22.Sheet_Long-i10*value2.PNLA_Long ;//������ value22.Sheet_Width
           tem_Sheet_Size_TwoPNL3.Sheet_Long:=value22.Sheet_Long;//i10*value2.PNLA_Long;//������
           tem_Sheet_Size_TwoPNL3.Sheet_Width:=value22.Sheet_Width-j10*value2.PNLA_Width;//������

           function_result001:=Calculate_TwoPNL_Sheet_2(value2,tepvalue2,tepvalue3,value22,tem_Sheet_Size_TwoPNL2,tem_Sheet_Size_TwoPNL3,i10,j10,2,2,1,value_pnla,1,1,iSheet);
           //�Ե���������
           tem_Sheet_Size_TwoPNL2.Sheet_Long:=value22.Sheet_Long-i10*value2.PNLA_Long;//������
           tem_Sheet_Size_TwoPNL2.Sheet_Width:=j10*value2.PNLA_Width ;//������ value22.Sheet_Width
           tem_Sheet_Size_TwoPNL3.Sheet_Long:=value22.Sheet_Width-j10*value2.PNLA_Width;//i10*value2.PNLA_Long;//������
           tem_Sheet_Size_TwoPNL3.Sheet_Width:=value22.Sheet_Long;//������

           function_result001:=Calculate_TwoPNL_Sheet_2(value2,tepvalue2,tepvalue3,value22,tem_Sheet_Size_TwoPNL2,tem_Sheet_Size_TwoPNL3,i10,j10,2,1,2,value_pnla,1,1,iSheet);
           //�Ե�����,��������
           tem_Sheet_Size_TwoPNL2.Sheet_Long:=j10*value2.PNLA_Width ;//������
           tem_Sheet_Size_TwoPNL2.Sheet_Width:=value22.Sheet_Long-i10*value2.PNLA_Long;//������ value22.Sheet_Width
           tem_Sheet_Size_TwoPNL3.Sheet_Long:=value22.Sheet_Width-j10*value2.PNLA_Width;//i10*value2.PNLA_Long;//������
           tem_Sheet_Size_TwoPNL3.Sheet_Width:=value22.Sheet_Long;//������
           function_result001:=Calculate_TwoPNL_Sheet_2(value2,tepvalue2,tepvalue3,value22,tem_Sheet_Size_TwoPNL2,tem_Sheet_Size_TwoPNL3,i10,j10,2,2,2,value_pnla,1,1,iSheet);

           //�Ե�����PNLB��PNLA
           tem_Sheet_Size_TwoPNL2.Sheet_Long:=value22.Sheet_Long-i10*value2.PNLA_Long;//������
           tem_Sheet_Size_TwoPNL2.Sheet_Width:=j10*value2.PNLA_Width ;//������ value22.Sheet_Width
           tem_Sheet_Size_TwoPNL3.Sheet_Long:=value22.Sheet_Long;//i10*value2.PNLA_Long;//������
           tem_Sheet_Size_TwoPNL3.Sheet_Width:=value22.Sheet_Width-j10*value2.PNLA_Width;//������

           tepvalue2.PNLA_Unit_Long_Number :=value2.PNLb_Unit_Width_Number ;
           tepvalue2.PNLA_Unit_Width_Number :=value2.PNLb_Unit_Long_Number ;
           tepvalue2.PNLA_Long :=value2.PNLb_Width;
           tepvalue2.PNLA_Width :=value2.PNLb_Long;
           tepvalue2.PNLb_Unit_Long_Number :=value2.PNLa_Unit_Width_Number ;
           tepvalue2.PNLb_Unit_Width_Number :=value2.PNLa_Unit_Long_Number ;
           tepvalue2.PNLb_Long :=value2.PNLa_Width;
           tepvalue2.PNLb_Width :=value2.PNLa_Long;
           tepvalue3:=value2;
           function_result001:=Calculate_TwoPNL_Sheet_2(value2,tepvalue2,tepvalue3,value22,tem_Sheet_Size_TwoPNL2,tem_Sheet_Size_TwoPNL3,i10,j10,2,1,1,value_pnla,2,1,iSheet);
           //�Ե���������
           tem_Sheet_Size_TwoPNL2.Sheet_Long:=j10*value2.PNLA_Width;//������
           tem_Sheet_Size_TwoPNL2.Sheet_Width:=value22.Sheet_Long-i10*value2.PNLA_Long ;//������ value22.Sheet_Width
           tem_Sheet_Size_TwoPNL3.Sheet_Long:=value22.Sheet_Long;//i10*value2.PNLA_Long;//������
           tem_Sheet_Size_TwoPNL3.Sheet_Width:=value22.Sheet_Width-j10*value2.PNLA_Width;//������
           function_result001:=Calculate_TwoPNL_Sheet_2(value2,tepvalue2,tepvalue3,value22,tem_Sheet_Size_TwoPNL2,tem_Sheet_Size_TwoPNL3,i10,j10,2,2,1,value_pnla,2,1,iSheet);
           //�Ե���������
           tem_Sheet_Size_TwoPNL2.Sheet_Long:=value22.Sheet_Long-i10*value2.PNLA_Long;//������
           tem_Sheet_Size_TwoPNL2.Sheet_Width:=j10*value2.PNLA_Width ;//������ value22.Sheet_Width
           tem_Sheet_Size_TwoPNL3.Sheet_Long:=value22.Sheet_Width-j10*value2.PNLA_Width;//i10*value2.PNLA_Long;//������
           tem_Sheet_Size_TwoPNL3.Sheet_Width:=value22.Sheet_Long;//������

           function_result001:=Calculate_TwoPNL_Sheet_2(value2,tepvalue2,tepvalue3,value22,tem_Sheet_Size_TwoPNL2,tem_Sheet_Size_TwoPNL3,i10,j10,2,1,2,value_pnla,2,1,iSheet);
           //�Ե�����,��������
            tem_Sheet_Size_TwoPNL2.Sheet_Long:=j10*value2.PNLA_Width;//������
           tem_Sheet_Size_TwoPNL2.Sheet_Width:=value22.Sheet_Long-i10*value2.PNLA_Long ;//������ value22.Sheet_Width
           tem_Sheet_Size_TwoPNL3.Sheet_Long:=value22.Sheet_Width-j10*value2.PNLA_Width;//i10*value2.PNLA_Long;//������
           tem_Sheet_Size_TwoPNL3.Sheet_Width:=value22.Sheet_Long;//������
           function_result001:=Calculate_TwoPNL_Sheet_2(value2,tepvalue2,tepvalue3,value22,tem_Sheet_Size_TwoPNL2,tem_Sheet_Size_TwoPNL3,i10,j10,2,2,2,value_pnla,2,1,iSheet);

               //�Ե�����PNLB��PNLA
              tem_Sheet_Size_TwoPNL2.Sheet_Long:=value22.Sheet_Long-i10*value2.PNLA_Long;//������
              tem_Sheet_Size_TwoPNL2.Sheet_Width:=j10*value2.PNLA_Width ;//������ value22.Sheet_Width
              tem_Sheet_Size_TwoPNL3.Sheet_Long:=value22.Sheet_Long;//i10*value2.PNLA_Long;//������
              tem_Sheet_Size_TwoPNL3.Sheet_Width:=value22.Sheet_Width-j10*value2.PNLA_Width;//������
              tepvalue3:=value2;
              tepvalue3.PNLA_Unit_Long_Number :=value2.PNLb_Unit_Width_Number ;
              tepvalue3.PNLA_Unit_Width_Number :=value2.PNLb_Unit_Long_Number ;
              tepvalue3.PNLA_Long :=value2.PNLb_Width;
              tepvalue3.PNLA_Width :=value2.PNLb_Long;
              tepvalue3.PNLb_Unit_Long_Number :=value2.PNLa_Unit_Width_Number ;
              tepvalue3.PNLb_Unit_Width_Number :=value2.PNLa_Unit_Long_Number ;
              tepvalue3.PNLb_Long :=value2.PNLa_Width;
              tepvalue3.PNLb_Width :=value2.PNLa_Long;
              tepvalue2:=value2;
              function_result001:=Calculate_TwoPNL_Sheet_2(value2,tepvalue2,tepvalue3,value22,tem_Sheet_Size_TwoPNL2,tem_Sheet_Size_TwoPNL3,i10,j10,2,1,1,value_pnla,1,2,iSheet);
              //�Ե���������
              tem_Sheet_Size_TwoPNL2.Sheet_Long:=j10*value2.PNLA_Width;//������
              tem_Sheet_Size_TwoPNL2.Sheet_Width:=value22.Sheet_Long-i10*value2.PNLA_Long ;//������ value22.Sheet_Width
              tem_Sheet_Size_TwoPNL3.Sheet_Long:=value22.Sheet_Long;//i10*value2.PNLA_Long;//������
              tem_Sheet_Size_TwoPNL3.Sheet_Width:=value22.Sheet_Width-j10*value2.PNLA_Width;//������
              function_result001:=Calculate_TwoPNL_Sheet_2(value2,tepvalue2,tepvalue3,value22,tem_Sheet_Size_TwoPNL2,tem_Sheet_Size_TwoPNL3,i10,j10,2,2,1,value_pnla,1,2,iSheet);
              //�Ե���������
              tem_Sheet_Size_TwoPNL2.Sheet_Long:=value22.Sheet_Long-i10*value2.PNLA_Long;//������
              tem_Sheet_Size_TwoPNL2.Sheet_Width:=j10*value2.PNLA_Width ;//������
              tem_Sheet_Size_TwoPNL3.Sheet_Long:=value22.Sheet_Width-j10*value2.PNLA_Width;//������
              tem_Sheet_Size_TwoPNL3.Sheet_Width:=value22.Sheet_Long;//������
             function_result001:=Calculate_TwoPNL_Sheet_2(value2,tepvalue2,tepvalue3,value22,tem_Sheet_Size_TwoPNL2,tem_Sheet_Size_TwoPNL3,i10,j10,2,1,2,value_pnla,1,2,iSheet);
             //�Ե�����,��������
              tem_Sheet_Size_TwoPNL2.Sheet_Long:=j10*value2.PNLA_Width;//������
              tem_Sheet_Size_TwoPNL2.Sheet_Width:=value22.Sheet_Long-i10*value2.PNLA_Long ;//������
              tem_Sheet_Size_TwoPNL3.Sheet_Long:=value22.Sheet_Width-j10*value2.PNLA_Width;//������
              tem_Sheet_Size_TwoPNL3.Sheet_Width:=value22.Sheet_Long;//������
             function_result001:=Calculate_TwoPNL_Sheet_2(value2,tepvalue2,tepvalue3,value22,tem_Sheet_Size_TwoPNL2,tem_Sheet_Size_TwoPNL3,i10,j10,2,2,2,value_pnla,1,2,iSheet);
             //�Ե���������PNLB��PNLA

                //�Ե�����,����PNLB��PNLA
              tem_Sheet_Size_TwoPNL2.Sheet_Long:=value22.Sheet_Long-i10*value2.PNLA_Long;//������
              tem_Sheet_Size_TwoPNL2.Sheet_Width:=j10*value2.PNLA_Width ;//������
              tem_Sheet_Size_TwoPNL3.Sheet_Long:=value22.Sheet_Long;//������
              tem_Sheet_Size_TwoPNL3.Sheet_Width:=value22.Sheet_Width-j10*value2.PNLA_Width;//������
               tepvalue2:=value2;
               tepvalue2.PNLA_Unit_Long_Number :=value2.PNLb_Unit_Width_Number ;
               tepvalue2.PNLA_Unit_Width_Number :=value2.PNLb_Unit_Long_Number ;
               tepvalue2.PNLA_Long :=value2.PNLb_Width;
               tepvalue2.PNLA_Width :=value2.PNLb_Long;
               tepvalue2.PNLb_Unit_Long_Number :=value2.PNLa_Unit_Width_Number ;
               tepvalue2.PNLb_Unit_Width_Number :=value2.PNLa_Unit_Long_Number ;
               tepvalue2.PNLb_Long :=value2.PNLa_Width;
               tepvalue2.PNLb_Width :=value2.PNLa_Long;
               tepvalue3:=value2;
               tepvalue3.PNLA_Unit_Long_Number :=value2.PNLb_Unit_Width_Number ;
               tepvalue3.PNLA_Unit_Width_Number :=value2.PNLb_Unit_Long_Number ;
               tepvalue3.PNLA_Long :=value2.PNLb_Width;
               tepvalue3.PNLA_Width :=value2.PNLb_Long;
               tepvalue3.PNLb_Unit_Long_Number :=value2.PNLa_Unit_Width_Number ;
               tepvalue3.PNLb_Unit_Width_Number :=value2.PNLa_Unit_Long_Number ;
               tepvalue3.PNLb_Long :=value2.PNLa_Width;
               tepvalue3.PNLb_Width :=value2.PNLa_Long;
               function_result001:=Calculate_TwoPNL_Sheet_2(value2,tepvalue2,tepvalue3,value22,tem_Sheet_Size_TwoPNL2,tem_Sheet_Size_TwoPNL3,i10,j10,2,1,1,value_pnla,2,2,iSheet);
               //�Ե���������
               tem_Sheet_Size_TwoPNL2.Sheet_Long:=j10*value2.PNLA_Width ;//������
               tem_Sheet_Size_TwoPNL2.Sheet_Width:=value22.Sheet_Long-i10*value2.PNLA_Long;//������
               tem_Sheet_Size_TwoPNL3.Sheet_Long:=value22.Sheet_Long;//������
               tem_Sheet_Size_TwoPNL3.Sheet_Width:=value22.Sheet_Width-j10*value2.PNLA_Width;//������
               function_result001:=Calculate_TwoPNL_Sheet_2(value2,tepvalue2,tepvalue3,value22,tem_Sheet_Size_TwoPNL2,tem_Sheet_Size_TwoPNL3,i10,j10,2,2,1,value_pnla,2,2,iSheet);
               //�Ե���������
              tem_Sheet_Size_TwoPNL2.Sheet_Long:=value22.Sheet_Long-i10*value2.PNLA_Long;//������
              tem_Sheet_Size_TwoPNL2.Sheet_Width:=j10*value2.PNLA_Width ;//������
              tem_Sheet_Size_TwoPNL3.Sheet_Long:=value22.Sheet_Width-j10*value2.PNLA_Width;//������
              tem_Sheet_Size_TwoPNL3.Sheet_Width:= value22.Sheet_Long;//������
              function_result001:=Calculate_TwoPNL_Sheet_2(value2,tepvalue2,tepvalue3,value22,tem_Sheet_Size_TwoPNL2,tem_Sheet_Size_TwoPNL3,i10,j10,2,1,2,value_pnla,2,2,iSheet);
              //�Ե�����,��������
              tem_Sheet_Size_TwoPNL2.Sheet_Long:=j10*value2.PNLA_Width ;//������
              tem_Sheet_Size_TwoPNL2.Sheet_Width:=value22.Sheet_Long-i10*value2.PNLA_Long;//������
              tem_Sheet_Size_TwoPNL3.Sheet_Long:=value22.Sheet_Width-j10*value2.PNLA_Width;//������
              tem_Sheet_Size_TwoPNL3.Sheet_Width:=value22.Sheet_Long;//������
              function_result001:=Calculate_TwoPNL_Sheet_2(value2,tepvalue2,tepvalue3,value22,tem_Sheet_Size_TwoPNL2,tem_Sheet_Size_TwoPNL3,i10,j10,2,2,2,value_pnla,2,2,iSheet);
              //�Ե���������,����PNLB��PNLA
//-----------------------------
       end;
    end;
    Result:=true;//�������ؼ�
  end;

end;

function TCutSheet2.Calculate_TwoPNL_Sheet_2(
  const value332,Two_Section_PNLvalue33,Three_Section_PNLvalue33: TResult_PNL2; //value32���һ����PNLA��Ϣ,��PNLB��Ϣ,value3��Ŷ�,������PNLA��PNLB��Ϣ
  const  value333_sheet,Two_Section_value333, Three_Section_value333: TParam_Sheet2;  //value33_sheet���ϳ���,Two_Section_value, Three_Section_value:��,��������
  pnl_long_number3331, pnl_width_number3331,type333,Two_Section_Draw_value333,Three_Section_Draw_value333,value_pnla2,Two_value_pnla2,Three_value_pnla2: integer // pnl_long_number33һ��PNLA������,pnl_width_number33һ��PNLA�����,�ŷ�
  ;iSheet:integer=0): boolean;//���ú���ʱ,value3ֵ�кͳ���Ҫ�Ե�,Two_Section_value����Ҫ�Ե�
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
    Section_PNLA_number:integer; //��PNLA����
    Section_PNLB_number:integer; //��PNLB����
  end;
var
    j21,i21,i31,j31,pnl_long_number333, pnl_width_number333,i221,t_n
    ,n201,n202,n21,n22,n231,n241,n232,n242,n233,n243
    ,n301,n302,n31,n32,n331,n341,n332,n342,n333,n343
    ,N231A1,N231A2,N232A1,N232A2,N233A1,N233A2,N234A1,N234A2
    ,N231B1,N231B2,N232B1,N232B2,N233B1,N233B2,N234B1,N234B2
    ,N221A1,N221A2,N222A1,N222A2,N223A1,N223A2,N224A1,N224A2
    ,N221B1,N221B2,N222B1,N222B2,N223B1,N223B2,N224B1,N224B2
    ,TEM_Falchion_Number1,TEM_Falchion_Number2,tv31,tv32:integer;
     rate20,rate21,rate22,rate23,max21,rate30,rate31,rate32,rate33,max31,
     tem_rate3,tem_rate2,rate_10
    ,rate200,rate201,rate202,rate203,rate204,rate205,rate206,rate207,rate208,rate209,rate210,rate211,rate212,rate213
    ,rate221,rate222,rate223,rate224,rate225,rate226,rate227,rate228,rate229,rate230,rate231,rate232,rate233
   :Double	;//���ڼ����ܵ�Ԫ����
  function_result,result_1:boolean;//���ú����Ƿ�ɹ�
  array_type2,array_type3:integer;//���ڼ�¼�������ŷ�,2,3����23��
  tempnl_sheet22,tempnl_sheet33:tempnl_sheet333;
  t_c:currency;
  TemMaxPnlNumber2,k:integer;
begin
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
  if (Two_Section_value333.Sheet_Long>=Two_Section_PNLvalue33.PNLA_Long) and (Two_Section_value333.Sheet_Width >=Two_Section_PNLvalue33.PNLA_Width)   then
  begin  //1
     if Leave_Section_falchion_number1=2 then //ֻ��������,�ŷ�ֻ��AB��һ�߹̶�����
     begin //2
       n21:=trunc(Two_Section_value333.Sheet_Long/Two_Section_PNLvalue33.PNLA_Long);//��A,��󳤸���
       n22:=trunc(Two_Section_value333.Sheet_Width/Two_Section_PNLvalue33.PNLA_Width);//��A,�������

       n201:=n21; //PNLA������Ϊn201*n202
       n202:=n22;
       rate20:=n201*n202*Two_Section_PNLvalue33.PNLA_Unit_Long_Number*Two_Section_PNLvalue33.PNLA_Unit_Width_Number;
       if Tem_Calculate_Rate_Type1=1 then  //�õ�Ԫ����
       begin
          rate20:=n201*n202*Two_Section_PNLvalue33.PNLA_Unit_Long_Number*Two_Section_PNLvalue33.PNLA_Unit_Width_Number*Two_Section_PNLvalue33.PNLA_Unit_Long*Two_Section_PNLvalue33.PNLA_Unit_Width;
          rate20:=rate20/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
       end;
       if Tem_Calculate_Rate_Type1=2 then //��PNL����
       begin
         rate20:=n201*n202*Two_Section_PNLvalue33.PNLA_Long*Two_Section_PNLvalue33.PNLA_Width;//PNL��������볤��
         rate20:=rate20/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
       end;
       for j21:=1 to n22 do //���1�����
       begin  //3
          //ʣ�²�����A,����ɵ���
           n231:=0;
           n241:=0;
           rate21:=0;
           if (Two_Section_value333.Sheet_Long>=Two_Section_PNLvalue33.PNLA_Width) and
              ((Two_Section_value333.Sheet_Width-j21*Two_Section_PNLvalue33.PNLA_Width)>=Two_Section_PNLvalue33.PNLA_Long) then//ʣ�²����Ƿ����A,
           begin
              n231:=trunc(Two_Section_value333.Sheet_Long/Two_Section_PNLvalue33.PNLA_Width);
              n241:=trunc((Two_Section_value333.Sheet_Width-j21*Two_Section_PNLvalue33.PNLA_Width)/Two_Section_PNLvalue33.PNLA_Long);
              rate21:=(n21*j21+n231*n241)*Two_Section_PNLvalue33.PNLA_Unit_Long_Number*Two_Section_PNLvalue33.PNLA_Unit_Width_Number;
              if Tem_Calculate_Rate_Type1=1 then  //�õ�Ԫ����
              begin
                 rate21:=(n21*j21+n231*n241)*Two_Section_PNLvalue33.PNLA_Unit_Long_Number*Two_Section_PNLvalue33.PNLA_Unit_Width_Number*Two_Section_PNLvalue33.PNLA_Unit_Long*Two_Section_PNLvalue33.PNLA_Unit_Width;
                 rate21:=rate21/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
              end;

              if Tem_Calculate_Rate_Type1=2 then //��PNL����
              begin
                 rate21:=(n21*j21+n231*n241)*Two_Section_PNLvalue33.PNLA_Width*Two_Section_PNLvalue33.PNLA_Long;
                 rate21:=rate21/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               end;
           end;
          //ʣ�²�����B,���������,����������
            n232:=0;
            n242:=0;
            rate22:=0;
           if (Two_Section_value333.Sheet_Long>=Two_Section_PNLvalue33.PNLb_Long) and    //��������PNLB��
              ((Two_Section_value333.Sheet_Width-j21*Two_Section_PNLvalue33.PNLA_Width)>=Two_Section_PNLvalue33.PNLb_Width) then//ʣ�²����Ƿ����b,
           begin
              n232:=trunc(Two_Section_value333.Sheet_Long/Two_Section_PNLvalue33.PNLb_Long);
              n242:=trunc((Two_Section_value333.Sheet_Width-j21*Two_Section_PNLvalue33.PNLA_Width)/Two_Section_PNLvalue33.PNLb_Width);
              rate22:=n21*j21*Two_Section_PNLvalue33.PNLA_Unit_Long_Number*Two_Section_PNLvalue33.PNLA_Unit_Width_Number+n232*n242*Two_Section_PNLvalue33.PNLb_Unit_Long_Number*Two_Section_PNLvalue33.PNLb_Unit_Width_Number;
              if Tem_Calculate_Rate_Type1=1 then  //�õ�Ԫ����
              begin
                 rate22:=n21*j21*Two_Section_PNLvalue33.PNLA_Unit_Long_Number*Two_Section_PNLvalue33.PNLA_Unit_Width_Number*Two_Section_PNLvalue33.PNLA_Unit_Long*Two_Section_PNLvalue33.PNLA_Unit_Width
                        +n232*n242*Two_Section_PNLvalue33.PNLb_Unit_Long_Number*Two_Section_PNLvalue33.PNLb_Unit_Width_Number*Two_Section_PNLvalue33.PNLb_Unit_Long*Two_Section_PNLvalue33.PNLb_Unit_Width;
                 rate22:=rate22/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
              end;

              if Tem_Calculate_Rate_Type1=2 then //��PNL����
              begin
                 rate22:=n21*j21*Two_Section_PNLvalue33.PNLA_Width*Two_Section_PNLvalue33.PNLA_Long
                         +n232*n242*Two_Section_PNLvalue33.PNLb_Width*Two_Section_PNLvalue33.PNLb_Long;
                 rate22:=rate22/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
              end;

           end;
           n233:=0;
           n243:=0;
           rate23:=0;
           if (Two_Section_value333.Sheet_Long>=Two_Section_PNLvalue33.PNLb_Width) and //��������PNLB��
              ((Two_Section_value333.Sheet_Width-j21*Two_Section_PNLvalue33.PNLA_Width)>=Two_Section_PNLvalue33.PNLb_Long) then//ʣ�²����Ƿ����b,
           begin
              n233:=trunc(Two_Section_value333.Sheet_Long/Two_Section_PNLvalue33.PNLb_Width);//ȡ��
              n243:=trunc((Two_Section_value333.Sheet_Width-j21*Two_Section_PNLvalue33.PNLA_Width)/Two_Section_PNLvalue33.PNLb_Long);
              rate23:=n21*j21*Two_Section_PNLvalue33.PNLA_Unit_Long_Number*Two_Section_PNLvalue33.PNLA_Unit_Width_Number+n233*n243*Two_Section_PNLvalue33.PNLb_Unit_Long_Number*Two_Section_PNLvalue33.PNLb_Unit_Width_Number;
              if Tem_Calculate_Rate_Type1=1 then  //�õ�Ԫ����
              begin
                 rate23:=n21*j21*Two_Section_PNLvalue33.PNLA_Unit_Long_Number*Two_Section_PNLvalue33.PNLA_Unit_Width_Number*Two_Section_PNLvalue33.PNLA_Unit_Long*Two_Section_PNLvalue33.PNLA_Unit_Width
                       +n233*n243*Two_Section_PNLvalue33.PNLb_Unit_Long_Number*Two_Section_PNLvalue33.PNLb_Unit_Width_Number*Two_Section_PNLvalue33.PNLb_Unit_Long*Two_Section_PNLvalue33.PNLb_Unit_Width;
                 rate23:=rate23/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
              end;

              if Tem_Calculate_Rate_Type1=2 then //��PNL����
              begin
                  rate23:=n21*j21*Two_Section_PNLvalue33.PNLA_Width*Two_Section_PNLvalue33.PNLA_Long
                          +n233*n243*Two_Section_PNLvalue33.PNLb_Width*Two_Section_PNLvalue33.PNLb_Long;
                  rate23:=rate23/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
              end;

           end;
           //�� rate1,rate2,rate3���ҳ�����
           max21:=max(max(max(rate20,rate21),rate22),rate23);
           if (max21>=tem_rate2)  then
           begin //3
             tem_rate2:=max21;
             if rate23=max21 then
             begin //4
              array_type2:=3;   //��PNLA�󻹿���PNLB,��ų���
              tempnl_sheet22.Section_LongA:=Two_Section_PNLvalue33.PNLA_Long;
              tempnl_sheet22.Section_WidthA:=Two_Section_PNLvalue33.PNLA_Width;
              tempnl_sheet22.Section_Long_NumberA:=n21;
              tempnl_sheet22.Section_Width_NumberA:=j21;
              tempnl_sheet22.Section_LongB:=Two_Section_PNLvalue33.PNLb_Width;
              tempnl_sheet22.Section_WidthB:=Two_Section_PNLvalue33.PNLb_Long;
              tempnl_sheet22.Section_Long_NumberB:=n233;
              tempnl_sheet22.Section_Width_NumberB:=n243;
              tempnl_sheet22.Section_Unit_Number:=n21*j21*Two_Section_PNLvalue33.PNLA_Unit_Long_Number*Two_Section_PNLvalue33.PNLA_Unit_Width_Number+n233*n243*Two_Section_PNLvalue33.PNLb_Unit_Long_Number*Two_Section_PNLvalue33.PNLb_Unit_Width_Number;

               tv31:=n21*j21;
               tv32:=n233*n243;
               tempnl_sheet22.Section_PNLA_number:=0;
               tempnl_sheet22.Section_PNLB_number:=0;
               function_result:=Change_pnla_pnlb_number1(value_pnla2,TWO_value_pnla2,tv31,tv32,tempnl_sheet22.Section_PNLA_number,tempnl_sheet22.Section_PNLB_number);

             end;
             if rate22=max21 then
             begin
              array_type2:=2; //��PNLA�󻹿���PNLB,���ų���
              tempnl_sheet22.Section_LongA:=Two_Section_PNLvalue33.PNLA_Long;
              tempnl_sheet22.Section_WidthA:=Two_Section_PNLvalue33.PNLA_Width;
              tempnl_sheet22.Section_Long_NumberA:=n21;
              tempnl_sheet22.Section_Width_NumberA:=j21;
              tempnl_sheet22.Section_LongB:=Two_Section_PNLvalue33.PNLb_Long;
              tempnl_sheet22.Section_WidthB:=Two_Section_PNLvalue33.PNLb_Width;
              tempnl_sheet22.Section_Long_NumberB:=n232;
              tempnl_sheet22.Section_Width_NumberB:=n242;
              tempnl_sheet22.Section_Unit_Number:=n21*j21*Two_Section_PNLvalue33.PNLA_Unit_Long_Number*Two_Section_PNLvalue33.PNLA_Unit_Width_Number+n232*n242*Two_Section_PNLvalue33.PNLb_Unit_Long_Number*Two_Section_PNLvalue33.PNLb_Unit_Width_Number;
              tv31:=n21*j21;
              tv32:=n232*n242;
              tempnl_sheet22.Section_PNLA_number:=0;
              tempnl_sheet22.Section_PNLB_number:=0;
              function_result:=Change_pnla_pnlb_number1(value_pnla2,TWO_value_pnla2,tv31,tv32,tempnl_sheet22.Section_PNLA_number,tempnl_sheet22.Section_PNLB_number);

             end;
             if rate21=max21 then
             begin
              array_type2:=1;  //��PNLA�󻹿���PNLA,��ų���
              tempnl_sheet22.Section_LongA:=Two_Section_PNLvalue33.PNLA_Long;
              tempnl_sheet22.Section_WidthA:=Two_Section_PNLvalue33.PNLA_Width;
              tempnl_sheet22.Section_Long_NumberA:=n21;
              tempnl_sheet22.Section_Width_NumberA:=j21;
              tempnl_sheet22.Section_LongB:=Two_Section_PNLvalue33.PNLA_Width;
              tempnl_sheet22.Section_WidthB:=Two_Section_PNLvalue33.PNLA_Long;
              tempnl_sheet22.Section_Long_NumberB:=n231;
              tempnl_sheet22.Section_Width_NumberB:=n241;
              tempnl_sheet22.Section_Unit_Number:=(n21*j21+n231*n241)*Two_Section_PNLvalue33.PNLA_Unit_Long_Number*Two_Section_PNLvalue33.PNLA_Unit_Width_Number;
              tv31:=n21*j21;
               tv32:=n231*n241;
               tempnl_sheet22.Section_PNLA_number:=0;
               tempnl_sheet22.Section_PNLB_number:=0;
               function_result:=Change_pnla_pnlb_number1(value_pnla2,TWO_value_pnla2,tv31,tv32,tempnl_sheet22.Section_PNLA_number,tempnl_sheet22.Section_PNLa_number);

             end;
             if rate20=max21 then
             begin
              array_type2:=0;  //ֻ��PNLA
              tempnl_sheet22.Section_LongA:=Two_Section_PNLvalue33.PNLA_Long;
              tempnl_sheet22.Section_WidthA:=Two_Section_PNLvalue33.PNLA_Width;
              tempnl_sheet22.Section_Long_NumberA:=n201;
              tempnl_sheet22.Section_Width_NumberA:=n202;
              tempnl_sheet22.Section_LongB:=0;
              tempnl_sheet22.Section_WidthB:=0;
              tempnl_sheet22.Section_Long_NumberB:=0;
              tempnl_sheet22.Section_Width_NumberB:=0;
              tempnl_sheet22.Section_Unit_Number:=n201*n202*Two_Section_PNLvalue33.PNLA_Unit_Long_Number*Two_Section_PNLvalue33.PNLA_Unit_Width_Number ;
              tv31:=n201*n202;
              tv32:=0;
              tempnl_sheet22.Section_PNLA_number:=0;
              tempnl_sheet22.Section_PNLB_number:=0;
              function_result:=Change_pnla_pnlb_number1(value_pnla2,TWO_value_pnla2,tv31,tv32,tempnl_sheet22.Section_PNLA_number,tempnl_sheet22.Section_PNLB_number);

             end;
           end; //4
       end; //3
     end;  //2
//3333333
   {}
     if Leave_Section_falchion_number1=3 then  //��������
     begin
       n21:=trunc(Two_Section_value333.Sheet_Long/Two_Section_PNLvalue33.PNLA_Long);//��A,��󳤸���
       n22:=trunc(Two_Section_value333.Sheet_Width/Two_Section_PNLvalue33.PNLA_Width);//��A,�������

       n201:=n21; //PNLA������Ϊn201*n202
       n202:=n22;
       rate200:=n201*n202*Two_Section_PNLvalue33.PNLA_Unit_Long_Number*Two_Section_PNLvalue33.PNLA_Unit_Width_Number;
       if Tem_Calculate_Rate_Type1=1 then  //�õ�Ԫ����
       begin
          rate200:=n201*n202*Two_Section_PNLvalue33.PNLA_Unit_Long_Number
                   *Two_Section_PNLvalue33.PNLA_Unit_Width_Number
                   *Two_Section_PNLvalue33.PNLA_Unit_Long
                   *Two_Section_PNLvalue33.PNLA_Unit_Width;
          rate200:=rate200/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
       end;
       if Tem_Calculate_Rate_Type1=2 then //��PNL����
       begin
         rate200:=n201*N202*Two_Section_PNLvalue33.PNLA_Long*Two_Section_PNLvalue33.PNLA_Width;//PNL��������볤��
         rate200:=rate200/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
       end;
        for i21:=1 to n21 do
        begin
          for j21:=1 to n22 do //���1����� ,Сһ����PNLA,���ų���,���ſ��
          begin  //3   �д���
                                       // |--------|-------|
           //��һ���ŷ�,��һ�����ƽ�п�  | Сһ�� |       |
//--------------------------              |--------|С���� |
         //                               |С����  |       |
           //����, ����                   |--------|-------|

             //�˴��ֶ������1:С������PNLA,С����Ҳ��PNLA;2:С������PNLA,С������PNLB;3:С������PNLB,С������PNLA;4:С����,С������PNLB
             //1:С������PNLA,С����Ҳ��PNLA,�ֶ������:С���������ſ�,С���������ų�;С���������ſ�,С���������ų���;С���������ų�,С���������ſ�

             //С����PNLA���ų���
             n221A1:=0;
             n222A1:=0;
             if (Two_Section_value333.Sheet_long-i21*Two_Section_PNLvalue33.PNLA_Long>=Two_Section_PNLvalue33.PNLA_Width)
               and (Two_Section_value333.Sheet_Width>=Two_Section_PNLvalue33.PNLA_Long) then
               begin
                 n221A1:=trunc((Two_Section_value333.Sheet_long-i21*Two_Section_PNLvalue33.PNLA_Long)/Two_Section_PNLvalue33.PNLA_Width);
                 n222A1:=trunc(Two_Section_value333.Sheet_Width/Two_Section_PNLvalue33.PNLA_Long);
              end;
              //С����PNLA���ų���
               n231A1:=0;
               n232A1:=0;
              if (i21*Two_Section_PNLvalue33.PNLA_Long>=Two_Section_PNLvalue33.PNLA_Width)
               and ((Two_Section_value333.Sheet_Width-j21*Two_Section_PNLvalue33.PNLA_Width)>=Two_Section_PNLvalue33.PNLA_Long) then
               begin
                 n231A1:=trunc(i21*Two_Section_PNLvalue33.PNLA_Long/Two_Section_PNLvalue33.PNLA_Width);
                 n232A1:=trunc((Two_Section_value333.Sheet_Width-j21*Two_Section_PNLvalue33.PNLA_Width)/Two_Section_PNLvalue33.PNLA_Long);
              end;
              //С����PNLA���ų���
              n233A1:=0;
              n234A1:=0;
              if (i21*Two_Section_PNLvalue33.PNLA_Long>=Two_Section_PNLvalue33.PNLA_Long)
               and ((Two_Section_value333.Sheet_Width-j21*Two_Section_PNLvalue33.PNLA_Width)>=Two_Section_PNLvalue33.PNLA_Width) then
               begin
                 n233A1:=trunc(i21*Two_Section_PNLvalue33.PNLA_Long/Two_Section_PNLvalue33.PNLA_Long);
                 n234A1:=trunc((Two_Section_value333.Sheet_Width-j21*Two_Section_PNLvalue33.PNLA_Width)/Two_Section_PNLvalue33.PNLA_Width);
              end;
              //С����PNLA���ų���
              n223A1:=0;
              n224A1:=0;
              if (Two_Section_value333.Sheet_long-i21*Two_Section_PNLvalue33.PNLA_Long>=Two_Section_PNLvalue33.PNLA_Long)
               and (Two_Section_value333.Sheet_Width>=Two_Section_PNLvalue33.PNLA_Width) then
               begin
                 n223A1:=trunc((Two_Section_value333.Sheet_long-i21*Two_Section_PNLvalue33.PNLA_Long)/Two_Section_PNLvalue33.PNLA_Long);
                 n224A1:=trunc(Two_Section_value333.Sheet_Width/Two_Section_PNLvalue33.PNLA_Width);
              end;


              //С����PNLB���ų���
              n221B1:=0;
              n222B1:=0;
              if (Two_Section_value333.Sheet_long-i21*Two_Section_PNLvalue33.PNLA_Long>=Two_Section_PNLvalue33.PNLB_Width)
               and (Two_Section_value333.Sheet_Width>=Two_Section_PNLvalue33.PNLB_Long) then
               begin
                 n221B1:=trunc((Two_Section_value333.Sheet_long-i21*Two_Section_PNLvalue33.PNLA_Long)/Two_Section_PNLvalue33.PNLB_Width);
                 n222B1:=trunc(Two_Section_value333.Sheet_Width/Two_Section_PNLvalue33.PNLB_Long);
              end;
              //С����PNLB���ų���
              n231B1:=0;
              n232B1:=0;
              if (i21*Two_Section_PNLvalue33.PNLA_Long>=Two_Section_PNLvalue33.PNLB_Width)
               and ((Two_Section_value333.Sheet_Width-j21*Two_Section_PNLvalue33.PNLA_Width)>=Two_Section_PNLvalue33.PNLB_Long) then
               begin
                 n231B1:=trunc(i21*Two_Section_PNLvalue33.PNLA_Long/Two_Section_PNLvalue33.PNLB_Width);
                 n232B1:=trunc((Two_Section_value333.Sheet_Width-j21*Two_Section_PNLvalue33.PNLA_Width)/Two_Section_PNLvalue33.PNLB_Long);
              end;
              //С����PNLB���ų���
              n233B1:=0;
              n234B1:=0;
              if (i21*Two_Section_PNLvalue33.PNLA_Long>=Two_Section_PNLvalue33.PNLB_Long)
               and ((Two_Section_value333.Sheet_Width-j21*Two_Section_PNLvalue33.PNLA_Width)>=Two_Section_PNLvalue33.PNLB_Width) then
               begin
                 n233B1:=trunc(i21*Two_Section_PNLvalue33.PNLA_Long/Two_Section_PNLvalue33.PNLB_Long);
                 n234B1:=trunc((Two_Section_value333.Sheet_Width-j21*Two_Section_PNLvalue33.PNLA_Width)/Two_Section_PNLvalue33.PNLB_Width);
              end;
              //С����PNLB���ų���
              n223B1:=0;
              n224B1:=0;
              if (Two_Section_value333.Sheet_long-i21*Two_Section_PNLvalue33.PNLA_Long>=Two_Section_PNLvalue33.PNLB_Long)
               and (Two_Section_value333.Sheet_Width>=Two_Section_PNLvalue33.PNLB_Width) then
               begin
                 n223B1:=trunc((Two_Section_value333.Sheet_long-i21*Two_Section_PNLvalue33.PNLA_Long)/Two_Section_PNLvalue33.PNLB_Long);
                 n224B1:=trunc(Two_Section_value333.Sheet_Width/Two_Section_PNLvalue33.PNLB_Width);
              end;
              //С��������PNLA��,С��������PNLA,��ֻһ��

               rate201:=(n221A1*N222A1+N233A1*N234a1)*Two_Section_PNLvalue33.PNLA_Unit_Long_Number*Two_Section_PNLvalue33.PNLA_Unit_Width_Number;
               if Tem_Calculate_Rate_Type1=1 then  //�õ�Ԫ����
               begin
                  rate201:=(n221A1*N222A1+N233A1*N234a1)*Two_Section_PNLvalue33.PNLA_Unit_Long_Number*Two_Section_PNLvalue33.PNLA_Unit_Width_Number
                         *Two_Section_PNLvalue33.PNLA_Unit_Long*Two_Section_PNLvalue33.PNLA_Unit_Width;
                  rate201:=rate201/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               end;
               if Tem_Calculate_Rate_Type1=2 then //��PNL����
               begin
                  rate201:=(n221A1*N222A1+N233A1*N234a1)
                         *Two_Section_PNLvalue33.PNLA_Long *Two_Section_PNLvalue33.PNLA_Width;
                  rate201:=rate201/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               END;
              //С��������PNLA��,С��������PNLA,��ֻһ��
              rate202:=(n223A1*N224A1+N231A1*N232a1)*Two_Section_PNLvalue33.PNLA_Unit_Long_Number*Two_Section_PNLvalue33.PNLA_Unit_Width_Number;
              if Tem_Calculate_Rate_Type1=1 then  //�õ�Ԫ����
               begin
                  rate202:=(n223A1*N224A1+N231A1*N232a1)*Two_Section_PNLvalue33.PNLA_Unit_Long_Number*Two_Section_PNLvalue33.PNLA_Unit_Width_Number
                         *Two_Section_PNLvalue33.PNLA_Unit_Long*Two_Section_PNLvalue33.PNLA_Unit_Width;
                  rate202:=rate202/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               end;
               if Tem_Calculate_Rate_Type1=2 then //��PNL����
               begin
                  rate202:=(n223A1*N224A1+N231A1*N232a1)
                         *Two_Section_PNLvalue33.PNLA_Long *Two_Section_PNLvalue33.PNLA_Width;
                  rate202:=rate203/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               END;
              rate203:=(n223A1*N224A1+N233A1*N234a1)*Two_Section_PNLvalue33.PNLA_Unit_Long_Number*Two_Section_PNLvalue33.PNLA_Unit_Width_Number;
              if Tem_Calculate_Rate_Type1=1 then  //�õ�Ԫ����
               begin
                  rate203:=(n223A1*N224A1+N233A1*N234a1)*Two_Section_PNLvalue33.PNLA_Unit_Long_Number*Two_Section_PNLvalue33.PNLA_Unit_Width_Number
                         *Two_Section_PNLvalue33.PNLA_Unit_Long*Two_Section_PNLvalue33.PNLA_Unit_Width;
                  rate203:=rate203/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               end;
               if Tem_Calculate_Rate_Type1=2 then //��PNL����
               begin
                  rate203:=(n223A1*N224A1+N233A1*N234a1)
                         *Two_Section_PNLvalue33.PNLA_Long *Two_Section_PNLvalue33.PNLA_Width;
                  rate203:=rate203/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               END;
               //С��������PNLA��,С��������PNLb,��ֻ����
              rate204:=n221A1*N222A1*Two_Section_PNLvalue33.PNLA_Unit_Long_Number*Two_Section_PNLvalue33.PNLA_Unit_Width_Number
                       +N231B1*N232B1*Two_Section_PNLvalue33.PNLB_Unit_Long_Number*Two_Section_PNLvalue33.PNLB_Unit_Width_Number;
              if Tem_Calculate_Rate_Type1=1 then  //�õ�Ԫ����
               begin
                  rate204:=n221A1*N222A1*Two_Section_PNLvalue33.PNLA_Unit_Long_Number*Two_Section_PNLvalue33.PNLA_Unit_Width_Number
                                          *Two_Section_PNLvalue33.PNLA_Unit_Long*Two_Section_PNLvalue33.PNLA_Unit_Width
                         +N231B1*N232B1*Two_Section_PNLvalue33.PNLb_Unit_Long_Number*Two_Section_PNLvalue33.PNLb_Unit_Width_Number
                                        *Two_Section_PNLvalue33.PNLb_Unit_Long*Two_Section_PNLvalue33.PNLb_Unit_Width;
                  rate204:=rate204/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               end;
               if Tem_Calculate_Rate_Type1=2 then //��PNL����
               begin
                  rate204:=n221A1*N222A1*Two_Section_PNLvalue33.PNLA_Long *Two_Section_PNLvalue33.PNLA_Width
                           +N231B1*N232B1*Two_Section_PNLvalue33.PNLb_Long *Two_Section_PNLvalue33.PNLb_Width;
                  rate204:=rate204/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               END;

              rate205:=n221A1*N222A1*Two_Section_PNLvalue33.PNLA_Unit_Long_Number*Two_Section_PNLvalue33.PNLA_Unit_Width_Number
                      +N233B1*N234B1*Two_Section_PNLvalue33.PNLB_Unit_Long_Number*Two_Section_PNLvalue33.PNLB_Unit_Width_Number;

               if Tem_Calculate_Rate_Type1=1 then  //�õ�Ԫ����
               begin
                  rate205:=n221A1*N222A1*Two_Section_PNLvalue33.PNLA_Unit_Long_Number*Two_Section_PNLvalue33.PNLA_Unit_Width_Number
                                          *Two_Section_PNLvalue33.PNLA_Unit_Long*Two_Section_PNLvalue33.PNLA_Unit_Width
                         +N233B1*N234B1*Two_Section_PNLvalue33.PNLb_Unit_Long_Number*Two_Section_PNLvalue33.PNLb_Unit_Width_Number
                                        *Two_Section_PNLvalue33.PNLb_Unit_Long*Two_Section_PNLvalue33.PNLb_Unit_Width;
                  rate205:=rate205/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               end;
               if Tem_Calculate_Rate_Type1=2 then //��PNL����
               begin
                  rate205:=n221A1*N222A1*Two_Section_PNLvalue33.PNLA_Long *Two_Section_PNLvalue33.PNLA_Width
                           +N233B1*N234B1*Two_Section_PNLvalue33.PNLb_Long *Two_Section_PNLvalue33.PNLb_Width;
                  rate205:=rate205/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               END;
              //С��������PNLB��,С��������PNLA,��ֻ����
              rate206:=n221B1*N222B1*Two_Section_PNLvalue33.PNLB_Unit_Long_Number*Two_Section_PNLvalue33.PNLB_Unit_Width_NumbeR
                      +N231A1*N232A1*Two_Section_PNLvalue33.PNLA_Unit_Long_Number*Two_Section_PNLvalue33.PNLA_Unit_Width_Number;
               if Tem_Calculate_Rate_Type1=1 then  //�õ�Ԫ����
               begin
                  rate206:=N231A1*N232A1*Two_Section_PNLvalue33.PNLA_Unit_Long_Number*Two_Section_PNLvalue33.PNLA_Unit_Width_Number
                                          *Two_Section_PNLvalue33.PNLA_Unit_Long*Two_Section_PNLvalue33.PNLA_Unit_Width
                         +n221B1*N222B1*Two_Section_PNLvalue33.PNLb_Unit_Long_Number*Two_Section_PNLvalue33.PNLb_Unit_Width_Number
                                        *Two_Section_PNLvalue33.PNLb_Unit_Long*Two_Section_PNLvalue33.PNLb_Unit_Width;
                  rate206:=rate206/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               end;
               if Tem_Calculate_Rate_Type1=2 then //��PNL����
               begin
                  rate206:=N231A1*N232A1*Two_Section_PNLvalue33.PNLA_Long *Two_Section_PNLvalue33.PNLA_Width
                           +n221B1*N222B1*Two_Section_PNLvalue33.PNLb_Long *Two_Section_PNLvalue33.PNLb_Width;
                  rate206:=rate206/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               END;
              rate207:=n221B1*N222B1*Two_Section_PNLvalue33.PNLB_Unit_Long_Number*Two_Section_PNLvalue33.PNLB_Unit_Width_NumbeR
                       +N233A1*N234A1*Two_Section_PNLvalue33.PNLA_Unit_Long_Number*Two_Section_PNLvalue33.PNLA_Unit_Width_NumbeR;
              if Tem_Calculate_Rate_Type1=1 then  //�õ�Ԫ����
               begin
                  rate207:=N233A1*N234A1*Two_Section_PNLvalue33.PNLA_Unit_Long_Number*Two_Section_PNLvalue33.PNLA_Unit_Width_Number
                                          *Two_Section_PNLvalue33.PNLA_Unit_Long*Two_Section_PNLvalue33.PNLA_Unit_Width
                         +n221B1*N222B1*Two_Section_PNLvalue33.PNLb_Unit_Long_Number*Two_Section_PNLvalue33.PNLb_Unit_Width_Number
                                        *Two_Section_PNLvalue33.PNLb_Unit_Long*Two_Section_PNLvalue33.PNLb_Unit_Width;
                  rate207:=rate207/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               end;
               if Tem_Calculate_Rate_Type1=2 then //��PNL����
               begin
                  rate207:=N233A1*N234A1*Two_Section_PNLvalue33.PNLA_Long *Two_Section_PNLvalue33.PNLA_Width
                           +n221B1*N222B1*Two_Section_PNLvalue33.PNLb_Long *Two_Section_PNLvalue33.PNLb_Width;
                  rate207:=rate207/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               END;
              //С��������PNLB��,С��������PNLA,��ֻ����
              rate208:=n223B1*N224B1*Two_Section_PNLvalue33.PNLB_Unit_Long_Number*Two_Section_PNLvalue33.PNLB_Unit_Width_Number
                       +N231A1*N232A1*Two_Section_PNLvalue33.PNLA_Unit_Long_Number*Two_Section_PNLvalue33.PNLA_Unit_Width_NumbeR;

              if Tem_Calculate_Rate_Type1=1 then  //�õ�Ԫ����
               begin
                  rate208:=N231A1*N232A1*Two_Section_PNLvalue33.PNLA_Unit_Long_Number*Two_Section_PNLvalue33.PNLA_Unit_Width_Number
                                          *Two_Section_PNLvalue33.PNLA_Unit_Long*Two_Section_PNLvalue33.PNLA_Unit_Width
                         +n223B1*N224B1*Two_Section_PNLvalue33.PNLb_Unit_Long_Number*Two_Section_PNLvalue33.PNLb_Unit_Width_Number
                                        *Two_Section_PNLvalue33.PNLb_Unit_Long*Two_Section_PNLvalue33.PNLb_Unit_Width;
                  rate208:=rate208/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               end;
               if Tem_Calculate_Rate_Type1=2 then //��PNL����
               begin
                  rate208:=N231A1*N232A1*Two_Section_PNLvalue33.PNLA_Long *Two_Section_PNLvalue33.PNLA_Width
                           +n223B1*N224B1*Two_Section_PNLvalue33.PNLb_Long *Two_Section_PNLvalue33.PNLb_Width;
                  rate208:=rate208/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               END;


              rate209:=n223B1*N224B1*Two_Section_PNLvalue33.PNLB_Unit_Long_Number*Two_Section_PNLvalue33.PNLB_Unit_Width_Number
                       +N233A1*N234A1*Two_Section_PNLvalue33.PNLA_Unit_Long_Number*Two_Section_PNLvalue33.PNLA_Unit_Width_NumbeR;

              if Tem_Calculate_Rate_Type1=1 then  //�õ�Ԫ����
               begin
                  rate209:=N233A1*N234A1*Two_Section_PNLvalue33.PNLA_Unit_Long_Number*Two_Section_PNLvalue33.PNLA_Unit_Width_Number
                                          *Two_Section_PNLvalue33.PNLA_Unit_Long*Two_Section_PNLvalue33.PNLA_Unit_Width
                         +n223B1*N224B1*Two_Section_PNLvalue33.PNLb_Unit_Long_Number*Two_Section_PNLvalue33.PNLb_Unit_Width_Number
                                        *Two_Section_PNLvalue33.PNLb_Unit_Long*Two_Section_PNLvalue33.PNLb_Unit_Width;
                  rate209:=rate209/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               end;
               if Tem_Calculate_Rate_Type1=2 then //��PNL����
               begin
                  rate209:=N233A1*N234A1*Two_Section_PNLvalue33.PNLA_Long *Two_Section_PNLvalue33.PNLA_Width
                           +n223B1*N224B1*Two_Section_PNLvalue33.PNLb_Long *Two_Section_PNLvalue33.PNLb_Width;
                  rate209:=rate209/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               END;
              //С��������PNLB��,С��������PNLB,��ֻ����
              rate210:=(n221B1*N222B1+N231B1*N232B1)*Two_Section_PNLvalue33.PNLB_Unit_Long_Number*Two_Section_PNLvalue33.PNLB_Unit_Width_Number;
              if Tem_Calculate_Rate_Type1=1 then  //�õ�Ԫ����
               begin
                  rate210:=(n221B1*N222B1+N231B1*N232B1)*Two_Section_PNLvalue33.PNLb_Unit_Long_Number*Two_Section_PNLvalue33.PNLb_Unit_Width_Number
                         *Two_Section_PNLvalue33.PNLb_Unit_Long*Two_Section_PNLvalue33.PNLb_Unit_Width;
                  rate210:=rate210/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               end;
               if Tem_Calculate_Rate_Type1=2 then //��PNL����
               begin
                  rate210:=(n221B1*N222B1+N231B1*N232B1)
                         *Two_Section_PNLvalue33.PNLb_Long *Two_Section_PNLvalue33.PNLb_Width;
                  rate210:=rate210/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               END;
              rate211:=(n221B1*N222B1+N233B1*N234B1)*Two_Section_PNLvalue33.PNLB_Unit_Long_Number*Two_Section_PNLvalue33.PNLB_Unit_Width_Number;
              if Tem_Calculate_Rate_Type1=1 then  //�õ�Ԫ����
               begin
                  rate211:=(n221B1*N222B1+N233B1*N234B1)*Two_Section_PNLvalue33.PNLb_Unit_Long_Number*Two_Section_PNLvalue33.PNLb_Unit_Width_Number
                         *Two_Section_PNLvalue33.PNLb_Unit_Long*Two_Section_PNLvalue33.PNLb_Unit_Width;
                  rate211:=rate211/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               end;
               if Tem_Calculate_Rate_Type1=2 then //��PNL����
               begin
                  rate211:=(n221B1*N222B1+N233B1*N234B1)
                         *Two_Section_PNLvalue33.PNLb_Long *Two_Section_PNLvalue33.PNLb_Width;
                  rate211:=rate211/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               END;
              //С��������PNLB��,С��������PNLB,��ֻ����
              rate212:=(n223B1*N224B1+N231B1*N232B1)*Two_Section_PNLvalue33.PNLB_Unit_Long_Number*Two_Section_PNLvalue33.PNLB_Unit_Width_Number;
              if Tem_Calculate_Rate_Type1=1 then  //�õ�Ԫ����
               begin
                  rate212:=(n223B1*N224B1+N231B1*N232B1)*Two_Section_PNLvalue33.PNLb_Unit_Long_Number*Two_Section_PNLvalue33.PNLb_Unit_Width_Number
                         *Two_Section_PNLvalue33.PNLb_Unit_Long*Two_Section_PNLvalue33.PNLb_Unit_Width;
                  rate212:=rate212/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               end;
               if Tem_Calculate_Rate_Type1=2 then //��PNL����
               begin
                  rate212:=(n223B1*N224B1+N231B1*N232B1)
                         *Two_Section_PNLvalue33.PNLb_Long *Two_Section_PNLvalue33.PNLb_Width;
                  rate212:=rate212/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               END;

              rate213:=(n223B1*N224B1+N233B1*N234B1)*Two_Section_PNLvalue33.PNLB_Unit_Long_Number*Two_Section_PNLvalue33.PNLB_Unit_Width_Number;

              if Tem_Calculate_Rate_Type1=1 then  //�õ�Ԫ����
               begin
                  rate213:=(n223B1*N224B1+N233B1*N234B1)*Two_Section_PNLvalue33.PNLb_Unit_Long_Number*Two_Section_PNLvalue33.PNLb_Unit_Width_Number
                         *Two_Section_PNLvalue33.PNLb_Unit_Long*Two_Section_PNLvalue33.PNLb_Unit_Width;
                  rate213:=rate213/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               end;
               if Tem_Calculate_Rate_Type1=2 then //��PNL����
               begin
                  rate213:=(n223B1*N224B1+N233B1*N234B1)
                         *Two_Section_PNLvalue33.PNLb_Long *Two_Section_PNLvalue33.PNLb_Width;
                  rate213:=rate213/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               END;

             //2:С������PNLA,С������PNLB;�ֶ������:С���������ſ�,С���������ų�;С���������ſ�,С���������ſ�;

             //3:С������PNLB,С������PNLA;

             //4:С����,С������PNLB

//---------------------------
            //                            |--------|-------|
           //��һ���ŷ�,��һ�����ƽ�п�  |Сһ��  |С���� |
            //                            |----------------|
           //                             | С����         |
           //                             |----------------|

           //С����PNLA���ų���   Two_Section_value333.Sheet_Width
             n221A2:=0;
             n222A2:=0;
             if (Two_Section_value333.Sheet_long-i21*Two_Section_PNLvalue33.PNLA_Long>=Two_Section_PNLvalue33.PNLA_Width)
               and (J21*Two_Section_PNLvalue33.PNLA_Width>=Two_Section_PNLvalue33.PNLA_Long) then
               begin
                 n221A2:=trunc((Two_Section_value333.Sheet_long-i21*Two_Section_PNLvalue33.PNLA_Long)/Two_Section_PNLvalue33.PNLA_Width);
                 n222A2:=trunc(J21*Two_Section_PNLvalue33.PNLA_Width/Two_Section_PNLvalue33.PNLA_Long);
              end;
              //С����PNLA���ų���  i21*Two_Section_PNLvalue33.PNLA_Long
              n231A2:=0;
              n232A2:=0;
              if (Two_Section_value333.Sheet_long>=Two_Section_PNLvalue33.PNLA_Width)
               and ((Two_Section_value333.Sheet_Width-j21*Two_Section_PNLvalue33.PNLA_Width)>=Two_Section_PNLvalue33.PNLA_Long) then
               begin
                 n231A2:=trunc(Two_Section_value333.Sheet_long/Two_Section_PNLvalue33.PNLA_Width);
                 n232A2:=trunc((Two_Section_value333.Sheet_Width-j21*Two_Section_PNLvalue33.PNLA_Width)/Two_Section_PNLvalue33.PNLA_Long);
              end;
              //С����PNLA���ų���
              n233A2:=0;
              n234A2:=0;
              if (Two_Section_value333.Sheet_long>=Two_Section_PNLvalue33.PNLA_Long)
               and ((Two_Section_value333.Sheet_Width-j21*Two_Section_PNLvalue33.PNLA_Width)>=Two_Section_PNLvalue33.PNLA_Width) then
               begin
                 n233A2:=trunc(Two_Section_value333.Sheet_long/Two_Section_PNLvalue33.PNLA_Long);
                 n234A2:=trunc((Two_Section_value333.Sheet_Width-j21*Two_Section_PNLvalue33.PNLA_Width)/Two_Section_PNLvalue33.PNLA_Width);
              end;
              //С����PNLA���ų���
              n223A2:=0;
              n224A2:=0;
              if (Two_Section_value333.Sheet_long-i21*Two_Section_PNLvalue33.PNLA_Long>=Two_Section_PNLvalue33.PNLA_Long)
               and (J21*Two_Section_PNLvalue33.PNLA_Width>=Two_Section_PNLvalue33.PNLA_Width) then
               begin
                 n223A2:=trunc((Two_Section_value333.Sheet_long-i21*Two_Section_PNLvalue33.PNLA_Long)/Two_Section_PNLvalue33.PNLA_Long);
                 n224A2:=trunc(J21*Two_Section_PNLvalue33.PNLA_Width/Two_Section_PNLvalue33.PNLA_Width);
              end;


              //С����PNLB���ų���
              n221B2:=0;
              n222B2:=0;
             if (Two_Section_value333.Sheet_long-i21*Two_Section_PNLvalue33.PNLA_Long>=Two_Section_PNLvalue33.PNLB_Width)
               and (J21*Two_Section_PNLvalue33.PNLA_Width>=Two_Section_PNLvalue33.PNLB_Long) then
               begin
                 n221B2:=trunc((Two_Section_value333.Sheet_long-i21*Two_Section_PNLvalue33.PNLA_Long)/Two_Section_PNLvalue33.PNLB_Width);
                 n222B2:=trunc(J21*Two_Section_PNLvalue33.PNLA_Width/Two_Section_PNLvalue33.PNLB_Long);
              end;
              //С����PNLB���ų���
              n231B2:=0;
              n232B2:=0;
              if (Two_Section_value333.Sheet_long>=Two_Section_PNLvalue33.PNLB_Width)
               and ((Two_Section_value333.Sheet_Width-j21*Two_Section_PNLvalue33.PNLA_Width)>=Two_Section_PNLvalue33.PNLB_Long) then
               begin
                 n231B2:=trunc(Two_Section_value333.Sheet_long/Two_Section_PNLvalue33.PNLB_Width);
                 n232B2:=trunc((Two_Section_value333.Sheet_Width-j21*Two_Section_PNLvalue33.PNLA_Width)/Two_Section_PNLvalue33.PNLB_Long);
              end;
              //С����PNLB���ų���
              n233B2:=0;
              n234B2:=0;
              if (Two_Section_value333.Sheet_long>=Two_Section_PNLvalue33.PNLB_Long)
               and ((Two_Section_value333.Sheet_Width-j21*Two_Section_PNLvalue33.PNLA_Width)>=Two_Section_PNLvalue33.PNLB_Width) then
               begin
                 n233B2:=trunc(Two_Section_value333.Sheet_long/Two_Section_PNLvalue33.PNLB_Long);
                 n234B2:=trunc((Two_Section_value333.Sheet_Width-j21*Two_Section_PNLvalue33.PNLA_Width)/Two_Section_PNLvalue33.PNLB_Width);
              end;
              //С����PNLB���ų���
              n223B2:=0;
              n224B2:=0;
              if (Two_Section_value333.Sheet_long-i21*Two_Section_PNLvalue33.PNLA_Long>=Two_Section_PNLvalue33.PNLB_Long)
               and (J21*Two_Section_PNLvalue33.PNLA_Width>=Two_Section_PNLvalue33.PNLB_Width) then
               begin
                 n223B2:=trunc((Two_Section_value333.Sheet_long-i21*Two_Section_PNLvalue33.PNLA_Long)/Two_Section_PNLvalue33.PNLB_Long);
                 n224B2:=trunc(J21*Two_Section_PNLvalue33.PNLA_Width/Two_Section_PNLvalue33.PNLB_Width);
              end;
              //С��������PNLA��,С��������PNLA,��ֻһ��

              rate221:=(n221A2*N222A2+N233A2*N234a2)*Two_Section_PNLvalue33.PNLA_Unit_Long_Number*Two_Section_PNLvalue33.PNLA_Unit_Width_Number;
              if Tem_Calculate_Rate_Type1=1 then  //�õ�Ԫ����
               begin
                  rate221:=(n221A2*N222A2+N233A2*N234a2)*Two_Section_PNLvalue33.PNLA_Unit_Long_Number*Two_Section_PNLvalue33.PNLA_Unit_Width_Number
                                          *Two_Section_PNLvalue33.PNLA_Unit_Long*Two_Section_PNLvalue33.PNLA_Unit_Width ;
                  rate221:=rate221/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               end;
               if Tem_Calculate_Rate_Type1=2 then //��PNL����
               begin
                  rate221:=(n221A2*N222A2+N233A2*N234a2)*Two_Section_PNLvalue33.PNLA_Long *Two_Section_PNLvalue33.PNLA_Width;
                  rate221:=rate221/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               END;
                //С��������PNLA��,С��������PNLA,��������
              rate222:=(n223A2*N224A2+N231A2*N232a2)*Two_Section_PNLvalue33.PNLA_Unit_Long_Number*Two_Section_PNLvalue33.PNLA_Unit_Width_Number;
              if Tem_Calculate_Rate_Type1=1 then  //�õ�Ԫ����
               begin
                  rate222:=(n223A2*N224A2+N231A2*N232a2)*Two_Section_PNLvalue33.PNLA_Unit_Long_Number*Two_Section_PNLvalue33.PNLA_Unit_Width_Number
                                          *Two_Section_PNLvalue33.PNLA_Unit_Long*Two_Section_PNLvalue33.PNLA_Unit_Width;
                  rate222:=rate222/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               end;
               if Tem_Calculate_Rate_Type1=2 then //��PNL����
               begin
                  rate222:=(n223A2*N224A2+N231A2*N232a2)*Two_Section_PNLvalue33.PNLA_Long *Two_Section_PNLvalue33.PNLA_Width ;
                  rate222:=rate222/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               END;
              rate223:=(n223A2*N224A2+N233A2*N234a2)*Two_Section_PNLvalue33.PNLA_Unit_Long_Number*Two_Section_PNLvalue33.PNLA_Unit_Width_Number;
              if Tem_Calculate_Rate_Type1=1 then  //�õ�Ԫ����
               begin
                  rate223:=(n223A2*N224A2+N233A2*N234a2)*Two_Section_PNLvalue33.PNLA_Unit_Long_Number*Two_Section_PNLvalue33.PNLA_Unit_Width_Number
                                          *Two_Section_PNLvalue33.PNLA_Unit_Long*Two_Section_PNLvalue33.PNLA_Unit_Width ;
                  rate223:=rate223/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               end;
               if Tem_Calculate_Rate_Type1=2 then //��PNL����
               begin
                  rate223:=(n223A2*N224A2+N233A2*N234a2)*Two_Section_PNLvalue33.PNLA_Long *Two_Section_PNLvalue33.PNLA_Width;
                  rate223:=rate223/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               END;

               //С��������PNLA��,С��������PNLb,��ֻ����
              rate224:=n221A2*N222A2*Two_Section_PNLvalue33.PNLA_Unit_Long_Number*Two_Section_PNLvalue33.PNLA_Unit_Width_Number
                     +N231B2*N232B2*Two_Section_PNLvalue33.PNLb_Unit_Long_Number*Two_Section_PNLvalue33.PNLb_Unit_Width_Number;
               if Tem_Calculate_Rate_Type1=1 then  //�õ�Ԫ����
               begin
                  rate224:=n221A2*N222A2*Two_Section_PNLvalue33.PNLA_Unit_Long_Number*Two_Section_PNLvalue33.PNLA_Unit_Width_Number
                                          *Two_Section_PNLvalue33.PNLA_Unit_Long*Two_Section_PNLvalue33.PNLA_Unit_Width
                         +N231B2*N232B2*Two_Section_PNLvalue33.PNLb_Unit_Long_Number*Two_Section_PNLvalue33.PNLb_Unit_Width_Number
                                        *Two_Section_PNLvalue33.PNLb_Unit_Long*Two_Section_PNLvalue33.PNLb_Unit_Width;
                  rate224:=rate224/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               end;
               if Tem_Calculate_Rate_Type1=2 then //��PNL����
               begin
                  rate224:=n221A2*N222A2*Two_Section_PNLvalue33.PNLA_Long *Two_Section_PNLvalue33.PNLA_Width
                           +N231B2*N232B2*Two_Section_PNLvalue33.PNLb_Long *Two_Section_PNLvalue33.PNLb_Width;
                  rate224:=rate224/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               END;

              rate225:=n221A2*N222A2*Two_Section_PNLvalue33.PNLA_Unit_Long_Number*Two_Section_PNLvalue33.PNLA_Unit_Width_Number
                     +N233B2*N234B2*Two_Section_PNLvalue33.PNLb_Unit_Long_Number*Two_Section_PNLvalue33.PNLb_Unit_Width_Number;
              if Tem_Calculate_Rate_Type1=1 then  //�õ�Ԫ����
               begin
                  rate225:=n221A2*N222A2*Two_Section_PNLvalue33.PNLA_Unit_Long_Number*Two_Section_PNLvalue33.PNLA_Unit_Width_Number
                                          *Two_Section_PNLvalue33.PNLA_Unit_Long*Two_Section_PNLvalue33.PNLA_Unit_Width
                         +N233B2*N234B2*Two_Section_PNLvalue33.PNLb_Unit_Long_Number*Two_Section_PNLvalue33.PNLb_Unit_Width_Number
                                        *Two_Section_PNLvalue33.PNLb_Unit_Long*Two_Section_PNLvalue33.PNLb_Unit_Width;
                  rate225:=rate225/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               end;
               if Tem_Calculate_Rate_Type1=2 then //��PNL����
               begin
                  rate225:=n221A2*N222A2*Two_Section_PNLvalue33.PNLA_Long *Two_Section_PNLvalue33.PNLA_Width
                           +N233B2*N234B2*Two_Section_PNLvalue33.PNLb_Long *Two_Section_PNLvalue33.PNLb_Width;
                  rate225:=rate225/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               END;

              //С��������PNLB��,С��������PNLA,��ֻ����
              rate226:=n221B2*N222B2*Two_Section_PNLvalue33.PNLb_Unit_Long_Number*Two_Section_PNLvalue33.PNLb_Unit_Width_Number
                       +N231A2*N232A2*Two_Section_PNLvalue33.PNLA_Unit_Long_Number*Two_Section_PNLvalue33.PNLA_Unit_Width_Number;
               if Tem_Calculate_Rate_Type1=1 then  //�õ�Ԫ����
               begin
                  rate226:=N231A2*N232A2*Two_Section_PNLvalue33.PNLA_Unit_Long_Number*Two_Section_PNLvalue33.PNLA_Unit_Width_Number
                                          *Two_Section_PNLvalue33.PNLA_Unit_Long*Two_Section_PNLvalue33.PNLA_Unit_Width
                         +n221B2*N222B2*Two_Section_PNLvalue33.PNLb_Unit_Long_Number*Two_Section_PNLvalue33.PNLb_Unit_Width_Number
                                        *Two_Section_PNLvalue33.PNLb_Unit_Long*Two_Section_PNLvalue33.PNLb_Unit_Width;
                  rate226:=rate226/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               end;
               if Tem_Calculate_Rate_Type1=2 then //��PNL����
               begin
                  rate226:=N231A2*N232A2*Two_Section_PNLvalue33.PNLA_Long *Two_Section_PNLvalue33.PNLA_Width
                           +n221B2*N222B2*Two_Section_PNLvalue33.PNLb_Long *Two_Section_PNLvalue33.PNLb_Width;
                  rate226:=rate226/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               END;

              rate227:=n221B2*N222B2*Two_Section_PNLvalue33.PNLb_Unit_Long_Number*Two_Section_PNLvalue33.PNLb_Unit_Width_Number
                       +N233A2*N234A2*Two_Section_PNLvalue33.PNLA_Unit_Long_Number*Two_Section_PNLvalue33.PNLA_Unit_Width_Number;
              if Tem_Calculate_Rate_Type1=1 then  //�õ�Ԫ����
               begin
                  rate227:=N233A2*N234A2*Two_Section_PNLvalue33.PNLA_Unit_Long_Number*Two_Section_PNLvalue33.PNLA_Unit_Width_Number
                                          *Two_Section_PNLvalue33.PNLA_Unit_Long*Two_Section_PNLvalue33.PNLA_Unit_Width
                         +n221B2*N222B2*Two_Section_PNLvalue33.PNLb_Unit_Long_Number*Two_Section_PNLvalue33.PNLb_Unit_Width_Number
                                        *Two_Section_PNLvalue33.PNLb_Unit_Long*Two_Section_PNLvalue33.PNLb_Unit_Width;
                  rate227:=rate227/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               end;
               if Tem_Calculate_Rate_Type1=2 then //��PNL����
               begin
                  rate227:=N233A2*N234A2*Two_Section_PNLvalue33.PNLA_Long *Two_Section_PNLvalue33.PNLA_Width
                           +n221B2*N222B2*Two_Section_PNLvalue33.PNLb_Long *Two_Section_PNLvalue33.PNLb_Width;
                  rate227:=rate227/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               END;

              //С��������PNLB��,С��������PNLA,��ֻ����
              rate228:=n223B2*N224B2*Two_Section_PNLvalue33.PNLb_Unit_Long_Number*Two_Section_PNLvalue33.PNLb_Unit_Width_Number
                       +N231A2*N232A2*Two_Section_PNLvalue33.PNLA_Unit_Long_Number*Two_Section_PNLvalue33.PNLA_Unit_Width_Number;
              if Tem_Calculate_Rate_Type1=1 then  //�õ�Ԫ����
               begin
                  rate228:=N231A2*N232A2*Two_Section_PNLvalue33.PNLA_Unit_Long_Number*Two_Section_PNLvalue33.PNLA_Unit_Width_Number
                                          *Two_Section_PNLvalue33.PNLA_Unit_Long*Two_Section_PNLvalue33.PNLA_Unit_Width
                         +n223B2*N224B2*Two_Section_PNLvalue33.PNLb_Unit_Long_Number*Two_Section_PNLvalue33.PNLb_Unit_Width_Number
                                        *Two_Section_PNLvalue33.PNLb_Unit_Long*Two_Section_PNLvalue33.PNLb_Unit_Width;
                  rate228:=rate228/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               end;
               if Tem_Calculate_Rate_Type1=2 then //��PNL����
               begin
                  rate228:=N231A2*N232A2*Two_Section_PNLvalue33.PNLA_Long *Two_Section_PNLvalue33.PNLA_Width
                           +n223B2*N224B2*Two_Section_PNLvalue33.PNLb_Long *Two_Section_PNLvalue33.PNLb_Width;
                  rate228:=rate228/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               END;

              rate229:=n223B2*N224B2*Two_Section_PNLvalue33.PNLb_Unit_Long_Number*Two_Section_PNLvalue33.PNLb_Unit_Width_Number
                       +N233A2*N234A2*Two_Section_PNLvalue33.PNLA_Unit_Long_Number*Two_Section_PNLvalue33.PNLA_Unit_Width_Number;
              if Tem_Calculate_Rate_Type1=1 then  //�õ�Ԫ����
               begin
                  rate229:=N233A2*N234A2*Two_Section_PNLvalue33.PNLA_Unit_Long_Number*Two_Section_PNLvalue33.PNLA_Unit_Width_Number
                                          *Two_Section_PNLvalue33.PNLA_Unit_Long*Two_Section_PNLvalue33.PNLA_Unit_Width
                         +n223B2*N224B2*Two_Section_PNLvalue33.PNLb_Unit_Long_Number*Two_Section_PNLvalue33.PNLb_Unit_Width_Number
                                        *Two_Section_PNLvalue33.PNLb_Unit_Long*Two_Section_PNLvalue33.PNLb_Unit_Width;
                  rate229:=rate229/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               end;
               if Tem_Calculate_Rate_Type1=2 then //��PNL����
               begin
                  rate229:=N233A2*N234A2*Two_Section_PNLvalue33.PNLA_Long *Two_Section_PNLvalue33.PNLA_Width
                           +n223B2*N224B2*Two_Section_PNLvalue33.PNLb_Long *Two_Section_PNLvalue33.PNLb_Width;
                  rate229:=rate229/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               END;

              //С��������PNLB��,С��������PNLB,��ֻ����
              rate230:=(n221B2*N222B2+N231B2*N232B2)*Two_Section_PNLvalue33.PNLB_Unit_Long_Number*Two_Section_PNLvalue33.PNLB_Unit_Width_Number;
              if Tem_Calculate_Rate_Type1=1 then  //�õ�Ԫ����
               begin
                  rate230:=(n221B2*N222B2+N231B2*N232B2)*Two_Section_PNLvalue33.PNLb_Unit_Long_Number*Two_Section_PNLvalue33.PNLb_Unit_Width_Number
                                        *Two_Section_PNLvalue33.PNLb_Unit_Long*Two_Section_PNLvalue33.PNLb_Unit_Width;
                  rate230:=rate230/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               end;
               if Tem_Calculate_Rate_Type1=2 then //��PNL����
               begin
                  rate230:=(n221B2*N222B2+N231B2*N232B2)*Two_Section_PNLvalue33.PNLb_Long *Two_Section_PNLvalue33.PNLb_Width;
                  rate230:=rate230/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               END;

              rate231:=(n221B2*N222B2+N233B2*N234B2)*Two_Section_PNLvalue33.PNLB_Unit_Long_Number*Two_Section_PNLvalue33.PNLB_Unit_Width_Number;
              if Tem_Calculate_Rate_Type1=1 then  //�õ�Ԫ����
               begin
                  rate231:=(n221B2*N222B2+N233B2*N234B2)*Two_Section_PNLvalue33.PNLb_Unit_Long_Number*Two_Section_PNLvalue33.PNLb_Unit_Width_Number
                                        *Two_Section_PNLvalue33.PNLb_Unit_Long*Two_Section_PNLvalue33.PNLb_Unit_Width;
                  rate231:=rate231/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               end;
               if Tem_Calculate_Rate_Type1=2 then //��PNL����
               begin
                  rate231:=(n221B2*N222B2+N233B2*N234B2)*Two_Section_PNLvalue33.PNLb_Long *Two_Section_PNLvalue33.PNLb_Width;
                  rate231:=rate231/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               END;

              //С��������PNLB��,С��������PNLB,��ֻ����
              rate232:=(n223B2*N224B2+N231B2*N232B2)*Two_Section_PNLvalue33.PNLB_Unit_Long_Number*Two_Section_PNLvalue33.PNLB_Unit_Width_Number;
              if Tem_Calculate_Rate_Type1=1 then  //�õ�Ԫ����
               begin
                  rate232:=(n223B2*N224B2+N231B2*N232B2)*Two_Section_PNLvalue33.PNLb_Unit_Long_Number*Two_Section_PNLvalue33.PNLb_Unit_Width_Number
                                        *Two_Section_PNLvalue33.PNLb_Unit_Long*Two_Section_PNLvalue33.PNLb_Unit_Width;
                  rate232:=rate232/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               end;
               if Tem_Calculate_Rate_Type1=2 then //��PNL����
               begin
                  rate223:=(n223B2*N224B2+N231B2*N232B2)*Two_Section_PNLvalue33.PNLb_Long *Two_Section_PNLvalue33.PNLb_Width;
                  rate232:=rate232/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               END;

              rate233:=(n223B2*N224B2+N233B2*N234B2)*Two_Section_PNLvalue33.PNLB_Unit_Long_Number*Two_Section_PNLvalue33.PNLB_Unit_Width_Number;
              if Tem_Calculate_Rate_Type1=1 then  //�õ�Ԫ����
               begin
                  rate233:=(n223B2*N224B2+N233B2*N234B2)*Two_Section_PNLvalue33.PNLb_Unit_Long_Number*Two_Section_PNLvalue33.PNLb_Unit_Width_Number
                                        *Two_Section_PNLvalue33.PNLb_Unit_Long*Two_Section_PNLvalue33.PNLb_Unit_Width;
                  rate233:=rate233/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               end;
               if Tem_Calculate_Rate_Type1=2 then //��PNL����
               begin
                  rate233:=(n223B2*N224B2+N233B2*N234B2)*Two_Section_PNLvalue33.PNLb_Long *Two_Section_PNLvalue33.PNLb_Width;
                  rate233:=rate233/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               END;
             //2:С������PNLA,С������PNLB;�ֶ������:С���������ſ�,С���������ų�;С���������ſ�,С���������ſ�;

             //3:С������PNLB,С������PNLA;

             //4:С����,С������PNLB



            //���ҳ�����������    200        201   213    221  233
             max21:=MAX(MAX(MAX(MAX(MAX(MAX(MAX(MAX(MAX(MAX(MAX(MAX(MAX(MAX(MAX(MAX(MAX(MAX(MAX(MAX(MAX(MAX(MAX(rate231,rate230),rate229),rate228),rate227),rate226),rate225),rate224),rate223),rate222),rate221),rate213),rate211),rate210),rate209),rate208),rate207),rate206),rate205),rate204),rate203),rate202),rate201),rate200);
             tem_rate2:=max21;
             if  rate233=max21 then //(n223B2*N224B2+N233B2*N234B2)
             begin  //N��ĵ���λ���ֱ�ʾ�������Ƿ����,��Ϊ3,4�����,�������ĸ��ʾ�ǵ�һ�ֻ��ǵڶ����ŷ�,A��ʾ��һ���ŷ�;B��ʾ�ڶ����ŷ�
                array_type2:=33;   //С��������PNLB��;С��������PNLB��
                tempnl_sheet22.Section_LongA:=Two_Section_PNLvalue33.PNLA_Long;
                tempnl_sheet22.Section_WidthA:=Two_Section_PNLvalue33.PNLA_Width;
                tempnl_sheet22.Section_Long_NumberA:=i21;
                tempnl_sheet22.Section_Width_NumberA:=j21;
                tempnl_sheet22.Section_LongB:=Two_Section_PNLvalue33.PNLb_Width;
                tempnl_sheet22.Section_WidthB:=Two_Section_PNLvalue33.PNLb_Long;
                tempnl_sheet22.Section_Long_NumberB:=n223B2;
                tempnl_sheet22.Section_Width_NumberB:=N224B2;
                tempnl_sheet22.Section_LongB:=Two_Section_PNLvalue33.PNLb_Width;
                tempnl_sheet22.Section_WidthB:=Two_Section_PNLvalue33.PNLb_Long;
                tempnl_sheet22.Section_Long_NumberB:=N233B2;
                tempnl_sheet22.Section_Width_NumberB:=N234B2;
                tempnl_sheet22.Section_Unit_Number:=(n223B2*N224B2+N233B2*N234B2)*Two_Section_PNLvalue33.PNLB_Unit_Long_Number*Two_Section_PNLvalue33.PNLB_Unit_Width_Number+I21*J21*Two_Section_PNLvalue33.PNLA_Unit_Long_Number*Two_Section_PNLvalue33.PNLA_Unit_Width_Number;
             end;
             if  rate232=max21 then 
             begin  //N��ĵ���λ���ֱ�ʾ�������Ƿ����,��Ϊ3,4�����,�������ĸ��ʾ�ǵ�һ�ֻ��ǵڶ����ŷ�,A��ʾ��һ���ŷ�;B��ʾ�ڶ����ŷ�
                array_type2:=32;   //С��������PNLB��;С��������PNLB��
                tempnl_sheet22.Section_LongA:=Two_Section_PNLvalue33.PNLA_Long;
                tempnl_sheet22.Section_WidthA:=Two_Section_PNLvalue33.PNLA_Width;
                tempnl_sheet22.Section_Long_NumberA:=i21;
                tempnl_sheet22.Section_Width_NumberA:=j21;
                tempnl_sheet22.Section_LongB:=Two_Section_PNLvalue33.PNLb_Width;
                tempnl_sheet22.Section_WidthB:=Two_Section_PNLvalue33.PNLb_Long;
                tempnl_sheet22.Section_Long_NumberB:=n223B2;
                tempnl_sheet22.Section_Width_NumberB:=N224B2;
                tempnl_sheet22.Section_LongB:=Two_Section_PNLvalue33.PNLb_Long;
                tempnl_sheet22.Section_WidthB:=Two_Section_PNLvalue33.PNLb_Width;
                tempnl_sheet22.Section_Long_NumberB:=N231B2;
                tempnl_sheet22.Section_Width_NumberB:=N232B2;
                tempnl_sheet22.Section_Unit_Number:=(n223B2*N224B2+N231B2*N232B2)*Two_Section_PNLvalue33.PNLB_Unit_Long_Number*Two_Section_PNLvalue33.PNLB_Unit_Width_Number+I21*J21*Two_Section_PNLvalue33.PNLA_Unit_Long_Number*Two_Section_PNLvalue33.PNLA_Unit_Width_Number;
             end;
             //С��������PNLB��,С��������PNLB,��ֻ����
             if  rate230=max21 then
             begin  //N��ĵ���λ���ֱ�ʾ�������Ƿ����,��Ϊ3,4�����,�������ĸ��ʾ�ǵ�һ�ֻ��ǵڶ����ŷ�,A��ʾ��һ���ŷ�;B��ʾ�ڶ����ŷ�
                array_type2:=30;   //С��������PNLB��;С��������PNLB��
                tempnl_sheet22.Section_LongA:=Two_Section_PNLvalue33.PNLA_Long;
                tempnl_sheet22.Section_WidthA:=Two_Section_PNLvalue33.PNLA_Width;
                tempnl_sheet22.Section_Long_NumberA:=i21;
                tempnl_sheet22.Section_Width_NumberA:=j21;
                tempnl_sheet22.Section_LongB:=Two_Section_PNLvalue33.PNLb_Long;
                tempnl_sheet22.Section_WidthB:=Two_Section_PNLvalue33.PNLb_Width;
                tempnl_sheet22.Section_Long_NumberB:=n221B2;
                tempnl_sheet22.Section_Width_NumberB:=N222B2;
                tempnl_sheet22.Section_LongB:=Two_Section_PNLvalue33.PNLb_Long;
                tempnl_sheet22.Section_WidthB:=Two_Section_PNLvalue33.PNLb_Width;
                tempnl_sheet22.Section_Long_NumberB:=N231B2;
                tempnl_sheet22.Section_Width_NumberB:=N232B2;
                tempnl_sheet22.Section_Unit_Number:=(n221B2*N222B2+N231B2*N232B2)*Two_Section_PNLvalue33.PNLB_Unit_Long_Number*Two_Section_PNLvalue33.PNLB_Unit_Width_Number+I21*J21*Two_Section_PNLvalue33.PNLA_Unit_Long_Number*Two_Section_PNLvalue33.PNLA_Unit_Width_Number;
             end;
             if  rate231=max21 then
             begin  //N��ĵ���λ���ֱ�ʾ�������Ƿ����,��Ϊ3,4�����,�������ĸ��ʾ�ǵ�һ�ֻ��ǵڶ����ŷ�,A��ʾ��һ���ŷ�;B��ʾ�ڶ����ŷ�
                array_type2:=31;   //С��������PNLB��;С��������PNLB��
                tempnl_sheet22.Section_LongA:=Two_Section_PNLvalue33.PNLA_Long;
                tempnl_sheet22.Section_WidthA:=Two_Section_PNLvalue33.PNLA_Width;
                tempnl_sheet22.Section_Long_NumberA:=i21;
                tempnl_sheet22.Section_Width_NumberA:=j21;
                tempnl_sheet22.Section_LongB:=Two_Section_PNLvalue33.PNLb_Long ;
                tempnl_sheet22.Section_WidthB:=Two_Section_PNLvalue33.PNLb_Width;
                tempnl_sheet22.Section_Long_NumberB:=n221B2;
                tempnl_sheet22.Section_Width_NumberB:=N222B2;
                tempnl_sheet22.Section_LongB:=Two_Section_PNLvalue33.PNLb_Long;
                tempnl_sheet22.Section_WidthB:=Two_Section_PNLvalue33.PNLb_Width;
                tempnl_sheet22.Section_Long_NumberB:=N231B2;
                tempnl_sheet22.Section_Width_NumberB:=N232B2;
                tempnl_sheet22.Section_Unit_Number:=(n221B2*N222B2+N233B2*N234B2)*Two_Section_PNLvalue33.PNLB_Unit_Long_Number*Two_Section_PNLvalue33.PNLB_Unit_Width_Number+I21*J21*Two_Section_PNLvalue33.PNLA_Unit_Long_Number*Two_Section_PNLvalue33.PNLA_Unit_Width_Number;
             end;
            //С��������PNLB��,С��������PNLA,��ֻ����
            if  rate229=max21 then //rate229:=n223B2*N224B2+N233A2*N234A2
             begin  //N��ĵ���λ���ֱ�ʾ�������Ƿ����,��Ϊ3,4�����,�������ĸ��ʾ�ǵ�һ�ֻ��ǵڶ����ŷ�,A��ʾ��һ���ŷ�;B��ʾ�ڶ����ŷ�
                array_type2:=29;   //С��������PNLB��;С��������PNLB��
                tempnl_sheet22.Section_LongA:=Two_Section_PNLvalue33.PNLA_Long;
                tempnl_sheet22.Section_WidthA:=Two_Section_PNLvalue33.PNLA_Width;
                tempnl_sheet22.Section_Long_NumberA:=i21;
                tempnl_sheet22.Section_Width_NumberA:=j21;
                tempnl_sheet22.Section_LongB:=Two_Section_PNLvalue33.PNLb_Width;
                tempnl_sheet22.Section_WidthB:=Two_Section_PNLvalue33.PNLb_Long;
                tempnl_sheet22.Section_Long_NumberB:=n223B2;
                tempnl_sheet22.Section_Width_NumberB:=N224B2;
                tempnl_sheet22.Section_LongB:=Two_Section_PNLvalue33.PNLa_Width;
                tempnl_sheet22.Section_WidthB:=Two_Section_PNLvalue33.PNLa_Long;
                tempnl_sheet22.Section_Long_NumberB:=N233A2;
                tempnl_sheet22.Section_Width_NumberB:=N234A2;
               tempnl_sheet22.Section_Unit_Number:=N233A2*N234A2*Two_Section_PNLvalue33.PNLa_Unit_Long_Number*Two_Section_PNLvalue33.PNLa_Unit_Width_Number+n223B2*N224B2*Two_Section_PNLvalue33.PNLB_Unit_Long_Number*Two_Section_PNLvalue33.PNLB_Unit_Width_Number+I21*J21*Two_Section_PNLvalue33.PNLA_Unit_Long_Number*Two_Section_PNLvalue33.PNLA_Unit_Width_Number;
             end;

             if  rate228=max21 then
             begin  //N��ĵ���λ���ֱ�ʾ�������Ƿ����,��Ϊ3,4�����,�������ĸ��ʾ�ǵ�һ�ֻ��ǵڶ����ŷ�,A��ʾ��һ���ŷ�;B��ʾ�ڶ����ŷ�
                array_type2:=28;   //С��������PNLB��;С��������PNLB��
                tempnl_sheet22.Section_LongA:=Two_Section_PNLvalue33.PNLA_Long;
                tempnl_sheet22.Section_WidthA:=Two_Section_PNLvalue33.PNLA_Width;
                tempnl_sheet22.Section_Long_NumberA:=i21;
                tempnl_sheet22.Section_Width_NumberA:=j21;
                tempnl_sheet22.Section_LongB:=Two_Section_PNLvalue33.PNLb_Width;
                tempnl_sheet22.Section_WidthB:=Two_Section_PNLvalue33.PNLb_Long;
                tempnl_sheet22.Section_Long_NumberB:=n223B2;
                tempnl_sheet22.Section_Width_NumberB:=N224B2;
                tempnl_sheet22.Section_LongB:=Two_Section_PNLvalue33.PNLa_Long;
                tempnl_sheet22.Section_WidthB:=Two_Section_PNLvalue33.PNLa_Width;
                tempnl_sheet22.Section_Long_NumberB:=N231A2;
                tempnl_sheet22.Section_Width_NumberB:=N232A2;
                tempnl_sheet22.Section_Unit_Number:=N231A2*N232A2*Two_Section_PNLvalue33.PNLa_Unit_Long_Number*Two_Section_PNLvalue33.PNLa_Unit_Width_Number
                                                   +n223B2*N224B2*Two_Section_PNLvalue33.PNLB_Unit_Long_Number*Two_Section_PNLvalue33.PNLB_Unit_Width_Number
                                                   +I21*J21*Two_Section_PNLvalue33.PNLA_Unit_Long_Number*Two_Section_PNLvalue33.PNLA_Unit_Width_Number;
             end;

             //С��������PNLB��,С��������PNLA,��ֻ����
             if  rate227=max21 then
             begin  //N��ĵ���λ���ֱ�ʾ�������Ƿ����,��Ϊ3,4�����,�������ĸ��ʾ�ǵ�һ�ֻ��ǵڶ����ŷ�,A��ʾ��һ���ŷ�;B��ʾ�ڶ����ŷ�
                array_type2:=27;   //С��������PNLB��;С��������PNLB��
                tempnl_sheet22.Section_LongA:=Two_Section_PNLvalue33.PNLA_Long;
                tempnl_sheet22.Section_WidthA:=Two_Section_PNLvalue33.PNLA_Width;
                tempnl_sheet22.Section_Long_NumberA:=i21;
                tempnl_sheet22.Section_Width_NumberA:=j21;
                tempnl_sheet22.Section_LongB:=Two_Section_PNLvalue33.PNLb_Long;
                tempnl_sheet22.Section_WidthB:=Two_Section_PNLvalue33.PNLb_Width;
                tempnl_sheet22.Section_Long_NumberB:=n221B2;
                tempnl_sheet22.Section_Width_NumberB:=N222B2;
                tempnl_sheet22.Section_LongB:=Two_Section_PNLvalue33.PNLa_Width;
                tempnl_sheet22.Section_WidthB:=Two_Section_PNLvalue33.PNLa_Long;
                tempnl_sheet22.Section_Long_NumberB:=N233A2;
                tempnl_sheet22.Section_Width_NumberB:=N234A2;
                tempnl_sheet22.Section_Unit_Number:=N233A2*N234A2*Two_Section_PNLvalue33.PNLa_Unit_Long_Number*Two_Section_PNLvalue33.PNLa_Unit_Width_Number
                                                   +n221B2*N222B2*Two_Section_PNLvalue33.PNLB_Unit_Long_Number*Two_Section_PNLvalue33.PNLB_Unit_Width_Number
                                                   +I21*J21*Two_Section_PNLvalue33.PNLA_Unit_Long_Number*Two_Section_PNLvalue33.PNLA_Unit_Width_Number;
             end;

             if  rate226=max21 then
             begin  //N��ĵ���λ���ֱ�ʾ�������Ƿ����,��Ϊ3,4�����,�������ĸ��ʾ�ǵ�һ�ֻ��ǵڶ����ŷ�,A��ʾ��һ���ŷ�;B��ʾ�ڶ����ŷ�
                array_type2:=26;   //С��������PNLB��;С��������PNLB��
                tempnl_sheet22.Section_LongA:=Two_Section_PNLvalue33.PNLA_Long;
                tempnl_sheet22.Section_WidthA:=Two_Section_PNLvalue33.PNLA_Width;
                tempnl_sheet22.Section_Long_NumberA:=i21;
                tempnl_sheet22.Section_Width_NumberA:=j21;
                tempnl_sheet22.Section_LongB:=Two_Section_PNLvalue33.PNLb_Long;
                tempnl_sheet22.Section_WidthB:=Two_Section_PNLvalue33.PNLb_Width;
                tempnl_sheet22.Section_Long_NumberB:=n221B2;
                tempnl_sheet22.Section_Width_NumberB:=N222B2;
                tempnl_sheet22.Section_LongB:=Two_Section_PNLvalue33.PNLa_Long;
                tempnl_sheet22.Section_WidthB:=Two_Section_PNLvalue33.PNLa_Width;
                tempnl_sheet22.Section_Long_NumberB:=N231A2;
                tempnl_sheet22.Section_Width_NumberB:=N232A2;
                tempnl_sheet22.Section_Unit_Number:=N231A2*N232A2*Two_Section_PNLvalue33.PNLa_Unit_Long_Number*Two_Section_PNLvalue33.PNLa_Unit_Width_Number
                                                   +n221B2*N222B2*Two_Section_PNLvalue33.PNLB_Unit_Long_Number*Two_Section_PNLvalue33.PNLB_Unit_Width_Number
                                                   +I21*J21*Two_Section_PNLvalue33.PNLA_Unit_Long_Number*Two_Section_PNLvalue33.PNLA_Unit_Width_Number;
             end;

             //С��������PNLA��,С��������PNLb,��ֻ����
             if  rate225=max21 then // rate225:=n221A2*N222A2+N233B2*N234B2
             begin  //N��ĵ���λ���ֱ�ʾ�������Ƿ����,��Ϊ3,4�����,�������ĸ��ʾ�ǵ�һ�ֻ��ǵڶ����ŷ�,A��ʾ��һ���ŷ�;B��ʾ�ڶ����ŷ�
                array_type2:=25;   //С��������PNLB��;С��������PNLB��
                tempnl_sheet22.Section_LongA:=Two_Section_PNLvalue33.PNLA_Long;
                tempnl_sheet22.Section_WidthA:=Two_Section_PNLvalue33.PNLA_Width;
                tempnl_sheet22.Section_Long_NumberA:=i21;
                tempnl_sheet22.Section_Width_NumberA:=j21;
                tempnl_sheet22.Section_LongB:=Two_Section_PNLvalue33.PNLa_Long ;
                tempnl_sheet22.Section_WidthB:=Two_Section_PNLvalue33.PNLa_Width ;
                tempnl_sheet22.Section_Long_NumberB:=n221A2;
                tempnl_sheet22.Section_Width_NumberB:=N222A2;
                tempnl_sheet22.Section_LongB:=Two_Section_PNLvalue33.PNLb_Width;
                tempnl_sheet22.Section_WidthB:=Two_Section_PNLvalue33.PNLb_Long;
                tempnl_sheet22.Section_Long_NumberB:=N233B2;
                tempnl_sheet22.Section_Width_NumberB:=N234B2;
                tempnl_sheet22.Section_Unit_Number:=n221A2*N222A2*Two_Section_PNLvalue33.PNLa_Unit_Long_Number*Two_Section_PNLvalue33.PNLa_Unit_Width_Number
                                                   +N233B2*N234B2*Two_Section_PNLvalue33.PNLB_Unit_Long_Number*Two_Section_PNLvalue33.PNLB_Unit_Width_Number
                                                   +I21*J21*Two_Section_PNLvalue33.PNLA_Unit_Long_Number*Two_Section_PNLvalue33.PNLA_Unit_Width_Number;
             end;

             if  rate224=max21 then 
             begin  //N��ĵ���λ���ֱ�ʾ�������Ƿ����,��Ϊ3,4�����,�������ĸ��ʾ�ǵ�һ�ֻ��ǵڶ����ŷ�,A��ʾ��һ���ŷ�;B��ʾ�ڶ����ŷ�
                array_type2:=24;   //С��������PNLB��;С��������PNLB��
                tempnl_sheet22.Section_LongA:=Two_Section_PNLvalue33.PNLA_Long;
                tempnl_sheet22.Section_WidthA:=Two_Section_PNLvalue33.PNLA_Width;
                tempnl_sheet22.Section_Long_NumberA:=i21;
                tempnl_sheet22.Section_Width_NumberA:=j21;
                tempnl_sheet22.Section_LongB:=Two_Section_PNLvalue33.PNLa_Long;
                tempnl_sheet22.Section_WidthB:=Two_Section_PNLvalue33.PNLa_Width;
                tempnl_sheet22.Section_Long_NumberB:=n221A2;
                tempnl_sheet22.Section_Width_NumberB:=N222A2;
                tempnl_sheet22.Section_LongB:=Two_Section_PNLvalue33.PNLb_Long;
                tempnl_sheet22.Section_WidthB:=Two_Section_PNLvalue33.PNLb_Width;
                tempnl_sheet22.Section_Long_NumberB:=N231B2;
                tempnl_sheet22.Section_Width_NumberB:=N232B2;
                tempnl_sheet22.Section_Unit_Number:=n221A2*N222A2*Two_Section_PNLvalue33.PNLa_Unit_Long_Number*Two_Section_PNLvalue33.PNLa_Unit_Width_Number
                                                   +N231B2*N232B2*Two_Section_PNLvalue33.PNLB_Unit_Long_Number*Two_Section_PNLvalue33.PNLB_Unit_Width_Number
                                                   +I21*J21*Two_Section_PNLvalue33.PNLA_Unit_Long_Number*Two_Section_PNLvalue33.PNLA_Unit_Width_Number;
             end;

             if  rate223=max21 then //rate223:=(n223A2*N224A2+N233A2*N234a2)
             begin  //N��ĵ���λ���ֱ�ʾ�������Ƿ����,��Ϊ3,4�����,�������ĸ��ʾ�ǵ�һ�ֻ��ǵڶ����ŷ�,A��ʾ��һ���ŷ�;B��ʾ�ڶ����ŷ�
                array_type2:=23;   //С��������PNLB��;С��������PNLB��
                tempnl_sheet22.Section_LongA:=Two_Section_PNLvalue33.PNLA_Long;
                tempnl_sheet22.Section_WidthA:=Two_Section_PNLvalue33.PNLA_Width;
                tempnl_sheet22.Section_Long_NumberA:=i21;
                tempnl_sheet22.Section_Width_NumberA:=j21;
                tempnl_sheet22.Section_LongB:=Two_Section_PNLvalue33.PNLa_Width;
                tempnl_sheet22.Section_WidthB:=Two_Section_PNLvalue33.PNLa_Long;
                tempnl_sheet22.Section_Long_NumberB:=n223A2;
                tempnl_sheet22.Section_Width_NumberB:=N224A2;
                tempnl_sheet22.Section_LongB:=Two_Section_PNLvalue33.PNLa_Width;
                tempnl_sheet22.Section_WidthB:=Two_Section_PNLvalue33.PNLa_Long;
                tempnl_sheet22.Section_Long_NumberB:=N233A2;
                tempnl_sheet22.Section_Width_NumberB:=N234a2;
                tempnl_sheet22.Section_Unit_Number:=(n223A2*N224A2+N233A2*N234a2)*Two_Section_PNLvalue33.PNLa_Unit_Long_Number*Two_Section_PNLvalue33.PNLa_Unit_Width_Number
                                                 //  +n223B2*N224B2*Two_Section_PNLvalue33.PNLB_Unit_Long_Number*Two_Section_PNLvalue33.PNLB_Unit_Width_Number
                                                   +I21*J21*Two_Section_PNLvalue33.PNLA_Unit_Long_Number*Two_Section_PNLvalue33.PNLA_Unit_Width_Number;
             end;

             if  rate222=max21 then //rate222:=(n223A2*N224A2+N231A2*N232a2)
             begin  //N��ĵ���λ���ֱ�ʾ�������Ƿ����,��Ϊ3,4�����,�������ĸ��ʾ�ǵ�һ�ֻ��ǵڶ����ŷ�,A��ʾ��һ���ŷ�;B��ʾ�ڶ����ŷ�
                array_type2:=22;   //С��������PNLB��;С��������PNLB��
                tempnl_sheet22.Section_LongA:=Two_Section_PNLvalue33.PNLA_Long;
                tempnl_sheet22.Section_WidthA:=Two_Section_PNLvalue33.PNLA_Width;
                tempnl_sheet22.Section_Long_NumberA:=i21;
                tempnl_sheet22.Section_Width_NumberA:=j21;
                tempnl_sheet22.Section_LongB:=Two_Section_PNLvalue33.PNLa_Width;
                tempnl_sheet22.Section_WidthB:=Two_Section_PNLvalue33.PNLa_Long;
                tempnl_sheet22.Section_Long_NumberB:=n223A2;
                tempnl_sheet22.Section_Width_NumberB:=N224A2;
                tempnl_sheet22.Section_LongB:=Two_Section_PNLvalue33.PNLa_Long;
                tempnl_sheet22.Section_WidthB:=Two_Section_PNLvalue33.PNLa_Width;
                tempnl_sheet22.Section_Long_NumberB:=N231A2;
                tempnl_sheet22.Section_Width_NumberB:=N232a2;
                tempnl_sheet22.Section_Unit_Number:=(n223A2*N224A2+N231A2*N232a2)*Two_Section_PNLvalue33.PNLa_Unit_Long_Number*Two_Section_PNLvalue33.PNLa_Unit_Width_Number
                                                  // +n223B2*N224B2*Two_Section_PNLvalue33.PNLB_Unit_Long_Number*Two_Section_PNLvalue33.PNLB_Unit_Width_Number
                                                   +I21*J21*Two_Section_PNLvalue33.PNLA_Unit_Long_Number*Two_Section_PNLvalue33.PNLA_Unit_Width_Number;
             end;

             if  rate221=max21 then //rate221:=(n221A2*N222A2+N233A2*N234a2)
             begin  //N��ĵ���λ���ֱ�ʾ�������Ƿ����,��Ϊ3,4�����,�������ĸ��ʾ�ǵ�һ�ֻ��ǵڶ����ŷ�,A��ʾ��һ���ŷ�;B��ʾ�ڶ����ŷ�
                array_type2:=21;   //С��������PNLB��;С��������PNLB��
                tempnl_sheet22.Section_LongA:=Two_Section_PNLvalue33.PNLA_Long;
                tempnl_sheet22.Section_WidthA:=Two_Section_PNLvalue33.PNLA_Width;
                tempnl_sheet22.Section_Long_NumberA:=i21;
                tempnl_sheet22.Section_Width_NumberA:=j21;
                tempnl_sheet22.Section_LongB:=Two_Section_PNLvalue33.PNLa_Long;
                tempnl_sheet22.Section_WidthB:=Two_Section_PNLvalue33.PNLa_Width;
                tempnl_sheet22.Section_Long_NumberB:=n221A2;
                tempnl_sheet22.Section_Width_NumberB:=N222A2;
                tempnl_sheet22.Section_LongB:=Two_Section_PNLvalue33.PNLa_Width;
                tempnl_sheet22.Section_WidthB:=Two_Section_PNLvalue33.PNLa_Long;
                tempnl_sheet22.Section_Long_NumberB:=N233A2;
                tempnl_sheet22.Section_Width_NumberB:=N234a2;
                tempnl_sheet22.Section_Unit_Number:=(n221A2*N222A2+N233A2*N234a2)*Two_Section_PNLvalue33.PNLa_Unit_Long_Number*Two_Section_PNLvalue33.PNLa_Unit_Width_Number
                                                   //+n223B2*N224B2*Two_Section_PNLvalue33.PNLB_Unit_Long_Number*Two_Section_PNLvalue33.PNLB_Unit_Width_Number
                                                   +I21*J21*Two_Section_PNLvalue33.PNLA_Unit_Long_Number*Two_Section_PNLvalue33.PNLA_Unit_Width_Number;
             end;
             {���µ�һ���ŷ�,���ϵڶ����ŷ�}
             if  rate213=max21 then // rate213:=(n223B1*N224B1+N233B1*N234B1)
             begin  //N��ĵ���λ���ֱ�ʾ�������Ƿ����,��Ϊ3,4�����,�������ĸ��ʾ�ǵ�һ�ֻ��ǵڶ����ŷ�,A��ʾ��һ���ŷ�;B��ʾ�ڶ����ŷ�
                array_type2:=13;   //С��������PNLB��;С��������PNLB��
                tempnl_sheet22.Section_LongA:=Two_Section_PNLvalue33.PNLA_Long;
                tempnl_sheet22.Section_WidthA:=Two_Section_PNLvalue33.PNLA_Width;
                tempnl_sheet22.Section_Long_NumberA:=i21;
                tempnl_sheet22.Section_Width_NumberA:=j21;
                tempnl_sheet22.Section_LongB:=Two_Section_PNLvalue33.PNLb_Width;
                tempnl_sheet22.Section_WidthB:=Two_Section_PNLvalue33.PNLb_Long;
                tempnl_sheet22.Section_Long_NumberB:=n223B1;
                tempnl_sheet22.Section_Width_NumberB:=N224B1;
                tempnl_sheet22.Section_LongB:=Two_Section_PNLvalue33.PNLb_Width;
                tempnl_sheet22.Section_WidthB:=Two_Section_PNLvalue33.PNLb_Long;
                tempnl_sheet22.Section_Long_NumberB:=N233B1;
                tempnl_sheet22.Section_Width_NumberB:=N234B1;
                tempnl_sheet22.Section_Unit_Number:=(n223B1*N224B1+N233B1*N234B1)*Two_Section_PNLvalue33.PNLB_Unit_Long_Number*Two_Section_PNLvalue33.PNLB_Unit_Width_Number
                                                   +I21*J21*Two_Section_PNLvalue33.PNLA_Unit_Long_Number*Two_Section_PNLvalue33.PNLA_Unit_Width_Number;
             end;

             if  rate212=max21 then //  rate212:=(n223B1*N224B1+N231B1*N232B1)
             begin  //N��ĵ���λ���ֱ�ʾ�������Ƿ����,��Ϊ3,4�����,�������ĸ��ʾ�ǵ�һ�ֻ��ǵڶ����ŷ�,A��ʾ��һ���ŷ�;B��ʾ�ڶ����ŷ�
                array_type2:=12;   //С��������PNLB��;С��������PNLB��
                tempnl_sheet22.Section_LongA:=Two_Section_PNLvalue33.PNLA_Long;
                tempnl_sheet22.Section_WidthA:=Two_Section_PNLvalue33.PNLA_Width;
                tempnl_sheet22.Section_Long_NumberA:=i21;
                tempnl_sheet22.Section_Width_NumberA:=j21;
                tempnl_sheet22.Section_LongB:=Two_Section_PNLvalue33.PNLb_Width;
                tempnl_sheet22.Section_WidthB:=Two_Section_PNLvalue33.PNLb_Long;
                tempnl_sheet22.Section_Long_NumberB:=n223B1;
                tempnl_sheet22.Section_Width_NumberB:=N224B1;
                tempnl_sheet22.Section_LongB:=Two_Section_PNLvalue33.PNLb_Long;
                tempnl_sheet22.Section_WidthB:=Two_Section_PNLvalue33.PNLb_Width;
                tempnl_sheet22.Section_Long_NumberB:=N231B1;
                tempnl_sheet22.Section_Width_NumberB:=N232B1;
                tempnl_sheet22.Section_Unit_Number:=(n223B1*N224B1+N231B1*N232B1)*Two_Section_PNLvalue33.PNLB_Unit_Long_Number*Two_Section_PNLvalue33.PNLB_Unit_Width_Number
                                                   +I21*J21*Two_Section_PNLvalue33.PNLA_Unit_Long_Number*Two_Section_PNLvalue33.PNLA_Unit_Width_Number;
             end;

             if  rate211=max21 then // rate211:=(n221B1*N222B1+N233B1*N234B1)
             begin  //N��ĵ���λ���ֱ�ʾ�������Ƿ����,��Ϊ3,4�����,�������ĸ��ʾ�ǵ�һ�ֻ��ǵڶ����ŷ�,A��ʾ��һ���ŷ�;B��ʾ�ڶ����ŷ�
                array_type2:=11;   //С��������PNLB��;С��������PNLB��
                tempnl_sheet22.Section_LongA:=Two_Section_PNLvalue33.PNLA_Long;
                tempnl_sheet22.Section_WidthA:=Two_Section_PNLvalue33.PNLA_Width;
                tempnl_sheet22.Section_Long_NumberA:=i21;
                tempnl_sheet22.Section_Width_NumberA:=j21;
                tempnl_sheet22.Section_LongB:=Two_Section_PNLvalue33.PNLb_Long;
                tempnl_sheet22.Section_WidthB:=Two_Section_PNLvalue33.PNLb_Width;
                tempnl_sheet22.Section_Long_NumberB:=n221B1;
                tempnl_sheet22.Section_Width_NumberB:=N222B1;
                tempnl_sheet22.Section_LongB:=Two_Section_PNLvalue33.PNLb_Width;
                tempnl_sheet22.Section_WidthB:=Two_Section_PNLvalue33.PNLb_Long;
                tempnl_sheet22.Section_Long_NumberB:=N233B1;
                tempnl_sheet22.Section_Width_NumberB:=N234B1;
                tempnl_sheet22.Section_Unit_Number:=//(n221A2*N222A2+N233A2*N234a2)*Two_Section_PNLvalue33.PNLa_Unit_Long_Number*Two_Section_PNLvalue33.PNLa_Unit_Width_Number
                                                   (n221B1*N222B1+N233B1*N234B1)*Two_Section_PNLvalue33.PNLB_Unit_Long_Number*Two_Section_PNLvalue33.PNLB_Unit_Width_Number
                                                   +I21*J21*Two_Section_PNLvalue33.PNLA_Unit_Long_Number*Two_Section_PNLvalue33.PNLA_Unit_Width_Number;
             end;

             if  rate210=max21 then // rate210:=(n221B1*N222B1+N231B1*N232B1)
             begin  //N��ĵ���λ���ֱ�ʾ�������Ƿ����,��Ϊ3,4�����,�������ĸ��ʾ�ǵ�һ�ֻ��ǵڶ����ŷ�,A��ʾ��һ���ŷ�;B��ʾ�ڶ����ŷ�
                array_type2:=10;   //С��������PNLB��;С��������PNLB��
                tempnl_sheet22.Section_LongA:=Two_Section_PNLvalue33.PNLA_Long;
                tempnl_sheet22.Section_WidthA:=Two_Section_PNLvalue33.PNLA_Width;
                tempnl_sheet22.Section_Long_NumberA:=i21;
                tempnl_sheet22.Section_Width_NumberA:=j21;
                tempnl_sheet22.Section_LongB:=Two_Section_PNLvalue33.PNLb_Width;
                tempnl_sheet22.Section_WidthB:=Two_Section_PNLvalue33.PNLb_Long;
                tempnl_sheet22.Section_Long_NumberB:=n221B1;
                tempnl_sheet22.Section_Width_NumberB:=N222B1;
                tempnl_sheet22.Section_LongB:=Two_Section_PNLvalue33.PNLb_Width;
                tempnl_sheet22.Section_WidthB:=Two_Section_PNLvalue33.PNLb_Long;
                tempnl_sheet22.Section_Long_NumberB:=N231B1;
                tempnl_sheet22.Section_Width_NumberB:=N232B1;
                tempnl_sheet22.Section_Unit_Number:=//(n221A2*N222A2+N233A2*N234a2)*Two_Section_PNLvalue33.PNLa_Unit_Long_Number*Two_Section_PNLvalue33.PNLa_Unit_Width_Number
                                                   (n221B1*N222B1+N231B1*N232B1)*Two_Section_PNLvalue33.PNLB_Unit_Long_Number*Two_Section_PNLvalue33.PNLB_Unit_Width_Number
                                                   +I21*J21*Two_Section_PNLvalue33.PNLA_Unit_Long_Number*Two_Section_PNLvalue33.PNLA_Unit_Width_Number;
             end;

             if  rate209=max21 then //   rate209:=n223B1*N224B1+N233A1*N234A1
             begin  //N��ĵ���λ���ֱ�ʾ�������Ƿ����,��Ϊ3,4�����,�������ĸ��ʾ�ǵ�һ�ֻ��ǵڶ����ŷ�,A��ʾ��һ���ŷ�;B��ʾ�ڶ����ŷ�
                array_type2:=9;   //С��������PNLB��;С��������PNLB��
                tempnl_sheet22.Section_LongA:=Two_Section_PNLvalue33.PNLA_Long;
                tempnl_sheet22.Section_WidthA:=Two_Section_PNLvalue33.PNLA_Width;
                tempnl_sheet22.Section_Long_NumberA:=i21;
                tempnl_sheet22.Section_Width_NumberA:=j21;
                tempnl_sheet22.Section_LongB:=Two_Section_PNLvalue33.PNLb_Width;
                tempnl_sheet22.Section_WidthB:=Two_Section_PNLvalue33.PNLb_Long;
                tempnl_sheet22.Section_Long_NumberB:=n223B1;
                tempnl_sheet22.Section_Width_NumberB:=N224B1;
                tempnl_sheet22.Section_LongB:=Two_Section_PNLvalue33.PNLa_Width;
                tempnl_sheet22.Section_WidthB:=Two_Section_PNLvalue33.PNLa_Long;
                tempnl_sheet22.Section_Long_NumberB:=N233A2;
                tempnl_sheet22.Section_Width_NumberB:=N234a2;
                tempnl_sheet22.Section_Unit_Number:=N233A1*N234A1*Two_Section_PNLvalue33.PNLa_Unit_Long_Number*Two_Section_PNLvalue33.PNLa_Unit_Width_Number
                                                   +n223B1*N224B1*Two_Section_PNLvalue33.PNLB_Unit_Long_Number*Two_Section_PNLvalue33.PNLB_Unit_Width_Number
                                                   +I21*J21*Two_Section_PNLvalue33.PNLA_Unit_Long_Number*Two_Section_PNLvalue33.PNLA_Unit_Width_Number;
             end;

             if  rate208=max21 then //   rate208:=n223B1*N224B1+N231A1*N232A1
             begin  //N��ĵ���λ���ֱ�ʾ�������Ƿ����,��Ϊ3,4�����,�������ĸ��ʾ�ǵ�һ�ֻ��ǵڶ����ŷ�,A��ʾ��һ���ŷ�;B��ʾ�ڶ����ŷ�
                array_type2:=8;   //С��������PNLB��;С��������PNLB��
                tempnl_sheet22.Section_LongA:=Two_Section_PNLvalue33.PNLA_Long;
                tempnl_sheet22.Section_WidthA:=Two_Section_PNLvalue33.PNLA_Width;
                tempnl_sheet22.Section_Long_NumberA:=i21;
                tempnl_sheet22.Section_Width_NumberA:=j21;
                tempnl_sheet22.Section_LongB:=Two_Section_PNLvalue33.PNLb_Width;
                tempnl_sheet22.Section_WidthB:=Two_Section_PNLvalue33.PNLb_Long;
                tempnl_sheet22.Section_Long_NumberB:=n223B1;
                tempnl_sheet22.Section_Width_NumberB:=N224B1;
                tempnl_sheet22.Section_LongB:=Two_Section_PNLvalue33.PNLa_Long;
                tempnl_sheet22.Section_WidthB:=Two_Section_PNLvalue33.PNLa_Width;
                tempnl_sheet22.Section_Long_NumberB:=N231A1;
                tempnl_sheet22.Section_Width_NumberB:=N232A1;
                tempnl_sheet22.Section_Unit_Number:=N231A1*N232A1*Two_Section_PNLvalue33.PNLa_Unit_Long_Number*Two_Section_PNLvalue33.PNLa_Unit_Width_Number
                                                   +n223B1*N224B1*Two_Section_PNLvalue33.PNLB_Unit_Long_Number*Two_Section_PNLvalue33.PNLB_Unit_Width_Number
                                                   +I21*J21*Two_Section_PNLvalue33.PNLA_Unit_Long_Number*Two_Section_PNLvalue33.PNLA_Unit_Width_Number;
             end;

             if  rate207=max21 then // rate207:=n221B1*N222B1+N233A1*N234A1
             begin  //N��ĵ���λ���ֱ�ʾ�������Ƿ����,��Ϊ3,4�����,�������ĸ��ʾ�ǵ�һ�ֻ��ǵڶ����ŷ�,A��ʾ��һ���ŷ�;B��ʾ�ڶ����ŷ�
                array_type2:=7;   //С��������PNLB��;С��������PNLB��
                tempnl_sheet22.Section_LongA:=Two_Section_PNLvalue33.PNLA_Long;
                tempnl_sheet22.Section_WidthA:=Two_Section_PNLvalue33.PNLA_Width;
                tempnl_sheet22.Section_Long_NumberA:=i21;
                tempnl_sheet22.Section_Width_NumberA:=j21;
                tempnl_sheet22.Section_LongB:=Two_Section_PNLvalue33.PNLb_Long;
                tempnl_sheet22.Section_WidthB:=Two_Section_PNLvalue33.PNLb_Width;
                tempnl_sheet22.Section_Long_NumberB:=n221B1;
                tempnl_sheet22.Section_Width_NumberB:=N222B1;
                tempnl_sheet22.Section_LongB:=Two_Section_PNLvalue33.PNLa_Width;
                tempnl_sheet22.Section_WidthB:=Two_Section_PNLvalue33.PNLa_Long;
                tempnl_sheet22.Section_Long_NumberB:=N233A2;
                tempnl_sheet22.Section_Width_NumberB:=N234a2;
                tempnl_sheet22.Section_Unit_Number:=N233A1*N234A1*Two_Section_PNLvalue33.PNLa_Unit_Long_Number*Two_Section_PNLvalue33.PNLa_Unit_Width_Number
                                                   +n221B1*N222B1*Two_Section_PNLvalue33.PNLB_Unit_Long_Number*Two_Section_PNLvalue33.PNLB_Unit_Width_Number
                                                   +I21*J21*Two_Section_PNLvalue33.PNLA_Unit_Long_Number*Two_Section_PNLvalue33.PNLA_Unit_Width_Number;
             end;


             if  rate206=max21 then //  rate206:=n221B1*N222B1+N231A1*N232A1
             begin  //N��ĵ���λ���ֱ�ʾ�������Ƿ����,��Ϊ3,4�����,�������ĸ��ʾ�ǵ�һ�ֻ��ǵڶ����ŷ�,A��ʾ��һ���ŷ�;B��ʾ�ڶ����ŷ�
                array_type2:=6;   //С��������PNLB��;С��������PNLB��
                tempnl_sheet22.Section_LongA:=Two_Section_PNLvalue33.PNLA_Long;
                tempnl_sheet22.Section_WidthA:=Two_Section_PNLvalue33.PNLA_Width;
                tempnl_sheet22.Section_Long_NumberA:=i21;
                tempnl_sheet22.Section_Width_NumberA:=j21;
                tempnl_sheet22.Section_LongB:=Two_Section_PNLvalue33.PNLb_Long;
                tempnl_sheet22.Section_WidthB:=Two_Section_PNLvalue33.PNLb_Width;
                tempnl_sheet22.Section_Long_NumberB:=n221B1;
                tempnl_sheet22.Section_Width_NumberB:=N222B1;
                tempnl_sheet22.Section_LongB:=Two_Section_PNLvalue33.PNLa_Long;
                tempnl_sheet22.Section_WidthB:=Two_Section_PNLvalue33.PNLa_Width;
                tempnl_sheet22.Section_Long_NumberB:=N231A1;
                tempnl_sheet22.Section_Width_NumberB:=N232A1;
                tempnl_sheet22.Section_Unit_Number:=N231A1*N232A1*Two_Section_PNLvalue33.PNLa_Unit_Long_Number*Two_Section_PNLvalue33.PNLa_Unit_Width_Number
                                                   +n221B1*N222B1*Two_Section_PNLvalue33.PNLB_Unit_Long_Number*Two_Section_PNLvalue33.PNLB_Unit_Width_Number
                                                   +I21*J21*Two_Section_PNLvalue33.PNLA_Unit_Long_Number*Two_Section_PNLvalue33.PNLA_Unit_Width_Number;
             end;

              if  rate205=max21 then //  rate205:=n221A1*N222A1+N233B1*N234B1
             begin  //N��ĵ���λ���ֱ�ʾ�������Ƿ����,��Ϊ3,4�����,�������ĸ��ʾ�ǵ�һ�ֻ��ǵڶ����ŷ�,A��ʾ��һ���ŷ�;B��ʾ�ڶ����ŷ�
                array_type2:=5;   //С��������PNLB��;С��������PNLB��
                tempnl_sheet22.Section_LongA:=Two_Section_PNLvalue33.PNLA_Long;
                tempnl_sheet22.Section_WidthA:=Two_Section_PNLvalue33.PNLA_Width;
                tempnl_sheet22.Section_Long_NumberA:=i21;
                tempnl_sheet22.Section_Width_NumberA:=j21;
                tempnl_sheet22.Section_LongB:=Two_Section_PNLvalue33.PNLa_Long;
                tempnl_sheet22.Section_WidthB:=Two_Section_PNLvalue33.PNLa_Width;
                tempnl_sheet22.Section_Long_NumberB:=n221A2;
                tempnl_sheet22.Section_Width_NumberB:=N222A2;
                tempnl_sheet22.Section_LongB:=Two_Section_PNLvalue33.PNLb_Width;
                tempnl_sheet22.Section_WidthB:=Two_Section_PNLvalue33.PNLb_Long;
                tempnl_sheet22.Section_Long_NumberB:=N233B1;
                tempnl_sheet22.Section_Width_NumberB:=N234B1;
                tempnl_sheet22.Section_Unit_Number:=n221A1*N222A1*Two_Section_PNLvalue33.PNLa_Unit_Long_Number*Two_Section_PNLvalue33.PNLa_Unit_Width_Number
                                                   +N233B1*N234B1*Two_Section_PNLvalue33.PNLB_Unit_Long_Number*Two_Section_PNLvalue33.PNLB_Unit_Width_Number
                                                   +I21*J21*Two_Section_PNLvalue33.PNLA_Unit_Long_Number*Two_Section_PNLvalue33.PNLA_Unit_Width_Number;
             end;

             if  rate204=max21 then //  rate204:=n221A1*N222A1+N231B1*N232B1
             begin  //N��ĵ���λ���ֱ�ʾ�������Ƿ����,��Ϊ3,4�����,�������ĸ��ʾ�ǵ�һ�ֻ��ǵڶ����ŷ�,A��ʾ��һ���ŷ�;B��ʾ�ڶ����ŷ�
                array_type2:=4;   //С��������PNLB��;С��������PNLB��
                tempnl_sheet22.Section_LongA:=Two_Section_PNLvalue33.PNLA_Long;
                tempnl_sheet22.Section_WidthA:=Two_Section_PNLvalue33.PNLA_Width;
                tempnl_sheet22.Section_Long_NumberA:=i21;
                tempnl_sheet22.Section_Width_NumberA:=j21;
                tempnl_sheet22.Section_LongB:=Two_Section_PNLvalue33.PNLa_Long;
                tempnl_sheet22.Section_WidthB:=Two_Section_PNLvalue33.PNLa_Width;
                tempnl_sheet22.Section_Long_NumberB:=n221A2;
                tempnl_sheet22.Section_Width_NumberB:=N222A2;
                tempnl_sheet22.Section_LongB:=Two_Section_PNLvalue33.PNLb_Long;
                tempnl_sheet22.Section_WidthB:=Two_Section_PNLvalue33.PNLb_Width;
                tempnl_sheet22.Section_Long_NumberB:=N231B1;
                tempnl_sheet22.Section_Width_NumberB:=N232B1;
                tempnl_sheet22.Section_Unit_Number:=n221A1*N222A1*Two_Section_PNLvalue33.PNLa_Unit_Long_Number*Two_Section_PNLvalue33.PNLa_Unit_Width_Number
                                                   +N231B1*N232B1*Two_Section_PNLvalue33.PNLB_Unit_Long_Number*Two_Section_PNLvalue33.PNLB_Unit_Width_Number
                                                   +I21*J21*Two_Section_PNLvalue33.PNLA_Unit_Long_Number*Two_Section_PNLvalue33.PNLA_Unit_Width_Number;
             end;

             if  rate203=max21 then // rate203:=(n223A1*N224A1+N233A1*N234a1)
             begin  //N��ĵ���λ���ֱ�ʾ�������Ƿ����,��Ϊ3,4�����,�������ĸ��ʾ�ǵ�һ�ֻ��ǵڶ����ŷ�,A��ʾ��һ���ŷ�;B��ʾ�ڶ����ŷ�
                array_type2:=3;   //С��������PNLB��;С��������PNLB��
                tempnl_sheet22.Section_LongA:=Two_Section_PNLvalue33.PNLA_Long;
                tempnl_sheet22.Section_WidthA:=Two_Section_PNLvalue33.PNLA_Width;
                tempnl_sheet22.Section_Long_NumberA:=i21;
                tempnl_sheet22.Section_Width_NumberA:=j21;
                tempnl_sheet22.Section_LongB:=Two_Section_PNLvalue33.PNLa_Width;
                tempnl_sheet22.Section_WidthB:=Two_Section_PNLvalue33.PNLa_Long;
                tempnl_sheet22.Section_Long_NumberB:=n223A1;
                tempnl_sheet22.Section_Width_NumberB:=N224A1;
                tempnl_sheet22.Section_LongB:=Two_Section_PNLvalue33.PNLa_Width;
                tempnl_sheet22.Section_WidthB:=Two_Section_PNLvalue33.PNLa_Long;
                tempnl_sheet22.Section_Long_NumberB:=N233A1;
                tempnl_sheet22.Section_Width_NumberB:=N234a1;
                tempnl_sheet22.Section_Unit_Number:=(n223A1*N224A1+N233A1*N234a1)*Two_Section_PNLvalue33.PNLa_Unit_Long_Number*Two_Section_PNLvalue33.PNLa_Unit_Width_Number
                                                   +I21*J21*Two_Section_PNLvalue33.PNLA_Unit_Long_Number*Two_Section_PNLvalue33.PNLA_Unit_Width_Number;
             end;

            if  rate202=max21 then //rate202:=(n223A1*N224A1+N231A1*N232a1)
             begin  //N��ĵ���λ���ֱ�ʾ�������Ƿ����,��Ϊ3,4�����,�������ĸ��ʾ�ǵ�һ�ֻ��ǵڶ����ŷ�,A��ʾ��һ���ŷ�;B��ʾ�ڶ����ŷ�
                array_type2:=2;   //С��������PNLB��;С��������PNLB��
                tempnl_sheet22.Section_LongA:=Two_Section_PNLvalue33.PNLA_Long;
                tempnl_sheet22.Section_WidthA:=Two_Section_PNLvalue33.PNLA_Width;
                tempnl_sheet22.Section_Long_NumberA:=i21;
                tempnl_sheet22.Section_Width_NumberA:=j21;
                tempnl_sheet22.Section_LongB:=Two_Section_PNLvalue33.PNLa_Width;
                tempnl_sheet22.Section_WidthB:=Two_Section_PNLvalue33.PNLa_Long;
                tempnl_sheet22.Section_Long_NumberB:=n223A1;
                tempnl_sheet22.Section_Width_NumberB:=N224A1;
                tempnl_sheet22.Section_LongB:=Two_Section_PNLvalue33.PNLa_Width;
                tempnl_sheet22.Section_WidthB:=Two_Section_PNLvalue33.PNLa_Long;
                tempnl_sheet22.Section_Long_NumberB:=N231A1;
                tempnl_sheet22.Section_Width_NumberB:=N232a1;
                tempnl_sheet22.Section_Unit_Number:=(n223A1*N224A1+N231A1*N232a1)*Two_Section_PNLvalue33.PNLa_Unit_Long_Number*Two_Section_PNLvalue33.PNLa_Unit_Width_Number
                                                   +I21*J21*Two_Section_PNLvalue33.PNLA_Unit_Long_Number*Two_Section_PNLvalue33.PNLA_Unit_Width_Number;
             end;

            if  rate201=max21 then //rate201:=(n221A1*N222A1+N233A1*N234a1)
             begin  //N��ĵ���λ���ֱ�ʾ�������Ƿ����,��Ϊ3,4�����,�������ĸ��ʾ�ǵ�һ�ֻ��ǵڶ����ŷ�,A��ʾ��һ���ŷ�;B��ʾ�ڶ����ŷ�
                array_type2:=1;   //С��������PNLB��;С��������PNLB��
                tempnl_sheet22.Section_LongA:=Two_Section_PNLvalue33.PNLA_Long;
                tempnl_sheet22.Section_WidthA:=Two_Section_PNLvalue33.PNLA_Width;
                tempnl_sheet22.Section_Long_NumberA:=i21;
                tempnl_sheet22.Section_Width_NumberA:=j21;
                tempnl_sheet22.Section_LongB:=Two_Section_PNLvalue33.PNLa_Long;
                tempnl_sheet22.Section_WidthB:=Two_Section_PNLvalue33.PNLa_Width;
                tempnl_sheet22.Section_Long_NumberB:=n221A1;
                tempnl_sheet22.Section_Width_NumberB:=N222A1;
                tempnl_sheet22.Section_LongB:=Two_Section_PNLvalue33.PNLa_Long ;
                tempnl_sheet22.Section_WidthB:=Two_Section_PNLvalue33.PNLa_Width;
                tempnl_sheet22.Section_Long_NumberB:=N233A1;
                tempnl_sheet22.Section_Width_NumberB:=N234a1;
                tempnl_sheet22.Section_Unit_Number:=(n221A1*N222A1+N233A1*N234a1)*Two_Section_PNLvalue33.PNLa_Unit_Long_Number*Two_Section_PNLvalue33.PNLa_Unit_Width_Number
                                                   +I21*J21*Two_Section_PNLvalue33.PNLA_Unit_Long_Number*Two_Section_PNLvalue33.PNLA_Unit_Width_Number;
             end;
             if  rate200=max21 then //
             begin  //N��ĵ���λ���ֱ�ʾ�������Ƿ����,��Ϊ3,4�����,�������ĸ��ʾ�ǵ�һ�ֻ��ǵڶ����ŷ�,A��ʾ��һ���ŷ�;B��ʾ�ڶ����ŷ�
                array_type2:=0;   //С��������PNLB��;С��������PNLB��
                tempnl_sheet22.Section_LongA:=Two_Section_PNLvalue33.PNLA_Long;
                tempnl_sheet22.Section_WidthA:=Two_Section_PNLvalue33.PNLA_Width;
                tempnl_sheet22.Section_Long_NumberA:=n201;
                tempnl_sheet22.Section_Width_NumberA:=n202;
                tempnl_sheet22.Section_LongB:=0;
                tempnl_sheet22.Section_WidthB:=0;
                tempnl_sheet22.Section_Long_NumberB:=0;
                tempnl_sheet22.Section_Width_NumberB:=0;
                tempnl_sheet22.Section_LongB:=0;
                tempnl_sheet22.Section_WidthB:=0;
                tempnl_sheet22.Section_Long_NumberB:=0;
                tempnl_sheet22.Section_Width_NumberB:=0;
                tempnl_sheet22.Section_Unit_Number:=n201*n202*Two_Section_PNLvalue33.PNLA_Unit_Long_Number*Two_Section_PNLvalue33.PNLA_Unit_Width_Number;
             end;

          end;
        end;
     end;       {}
//333333333
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

       for j31:=1 to n32 do //
       begin
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
            n332:=0;
            n342:=0;
            rate32:=0;
           if (Three_Section_value333.Sheet_Long>=Three_Section_PNLvalue33.PNLb_Long) and    //��������PNLB��
              ((Three_Section_value333.Sheet_Width-j31*Three_Section_PNLvalue33.PNLA_Width)>=Three_Section_PNLvalue33.PNLb_Width) then//ʣ�²����Ƿ����b,
           begin
              n332:=trunc(Three_Section_value333.Sheet_Long/Three_Section_PNLvalue33.PNLb_Long);
              n342:=trunc((Three_Section_value333.Sheet_Width-j31*Three_Section_PNLvalue33.PNLA_Width)/Three_Section_PNLvalue33.PNLb_Width);
              rate32:=n31*j31*Three_Section_PNLvalue33.PNLA_Unit_Long_Number*Three_Section_PNLvalue33.PNLA_Unit_Width_Number+n332*n342*Three_Section_PNLvalue33.PNLb_Unit_Long_Number*Three_Section_PNLvalue33.PNLb_Unit_Width_Number;
              if Tem_Calculate_Rate_Type1=1 then  //�õ�Ԫ����
              begin
                  rate32:=n31*j31*Three_Section_PNLvalue33.PNLA_Unit_Long_Number*Three_Section_PNLvalue33.PNLA_Unit_Width_Number*Three_Section_PNLvalue33.PNLA_Unit_Long*Three_Section_PNLvalue33.PNLA_Unit_Width
                         +n332*n342*Three_Section_PNLvalue33.PNLb_Unit_Long_Number*Three_Section_PNLvalue33.PNLb_Unit_Width_Number*Three_Section_PNLvalue33.PNLb_Unit_Long*Three_Section_PNLvalue33.PNLb_Unit_Width;
                  rate32:=rate32/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
              end;

              if Tem_Calculate_Rate_Type1=2 then //��PNL����
              begin
                  rate32:=n31*j31*Three_Section_PNLvalue33.PNLA_Long*Three_Section_PNLvalue33.PNLA_Width
                          +n332*n342*Three_Section_PNLvalue33.PNLb_Long*Three_Section_PNLvalue33.PNLb_Width;
                  rate32:=rate32/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
              end

           end;
           n333:=0;
           n343:=0;
           rate33:=0;
           if (Three_Section_value333.Sheet_Long>=Three_Section_PNLvalue33.PNLb_Width) and //��������PNLB��
              ((three_Section_value333.Sheet_Width-j31*Three_Section_PNLvalue33.PNLA_Width)>=Three_Section_PNLvalue33.PNLb_Long) then//ʣ�²����Ƿ����b,
           begin
              n333:=trunc(Three_Section_value333.Sheet_Long/Three_Section_PNLvalue33.PNLb_Width);
              n343:=trunc((Three_Section_value333.Sheet_Width-j31*Three_Section_PNLvalue33.PNLA_Width)/Three_Section_PNLvalue33.PNLb_Long);
              rate33:=n31*j31*Three_Section_PNLvalue33.PNLA_Unit_Long_Number*Three_Section_PNLvalue33.PNLA_Unit_Width_Number+n333*n343*Three_Section_PNLvalue33.PNLb_Unit_Long_Number*Three_Section_PNLvalue33.PNLb_Unit_Width_Number;

              if Tem_Calculate_Rate_Type1=1 then  //�õ�Ԫ����
              begin
                 rate33:=n31*j31*Three_Section_PNLvalue33.PNLA_Unit_Long_Number*Three_Section_PNLvalue33.PNLA_Unit_Width_Number*Three_Section_PNLvalue33.PNLA_Unit_Long*Three_Section_PNLvalue33.PNLA_Unit_Width
                       +n333*n343*Three_Section_PNLvalue33.PNLb_Unit_Long_Number*Three_Section_PNLvalue33.PNLb_Unit_Width_Number*Three_Section_PNLvalue33.PNLb_Unit_Long*Three_Section_PNLvalue33.PNLb_Unit_Width;//PNL����
                 rate33:=rate33/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
              end;

              if Tem_Calculate_Rate_Type1=2 then //��PNL����
              begin
                 rate33:=n31*j31*Three_Section_PNLvalue33.PNLA_Long*Three_Section_PNLvalue33.PNLA_Width
                        +n333*n343*Three_Section_PNLvalue33.PNLb_Long*Three_Section_PNLvalue33.PNLb_Width;
                 rate33:=rate33/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
              end

           end;
           //�� rate1,rate2,rate3���ҳ�����
           max31:=max(max(max(rate30,rate31),rate32),rate33);
           if (max31>=tem_rate3)  then
           begin
             tem_rate3:=max31;

             if rate33=max31 then
             begin
              array_type3:=3;
              tempnl_sheet33.Section_LongA:=Three_Section_PNLvalue33.PNLA_Long;
              tempnl_sheet33.Section_WidthA:=Three_Section_PNLvalue33.PNLA_Width;
              tempnl_sheet33.Section_Long_NumberA:=n31;
              tempnl_sheet33.Section_Width_NumberA:=j31;
              tempnl_sheet33.Section_LongB:=Three_Section_PNLvalue33.PNLb_Width;
              tempnl_sheet33.Section_WidthB:=Three_Section_PNLvalue33.PNLb_Long;
              tempnl_sheet33.Section_Long_NumberB:=n333;
              tempnl_sheet33.Section_Width_NumberB:=n343;
              tempnl_sheet33.Section_Unit_Number:=n31*j31*Three_Section_PNLvalue33.PNLA_Unit_Long_Number*Three_Section_PNLvalue33.PNLA_Unit_Width_Number+n333*n343*Three_Section_PNLvalue33.PNLb_Unit_Long_Number*Three_Section_PNLvalue33.PNLb_Unit_Width_Number;

              tv31:=n31*j31; //���ڼ���PNLA��PNLB�ĸ�������
              tv32:=n333*n343;
              tempnl_sheet33.Section_PNLA_number:=0;
              tempnl_sheet33.Section_PNLB_number:=0;
              function_result:=Change_pnla_pnlb_number1(value_pnla2,TWO_value_pnla2,tv31,tv32,tempnl_sheet33.Section_PNLA_number,tempnl_sheet33.Section_PNLB_number);

             end;
             if rate32=max31 then
             begin
              array_type3:=2;
              tempnl_sheet33.Section_LongA:=Three_Section_PNLvalue33.PNLA_Long;
              tempnl_sheet33.Section_WidthA:=Three_Section_PNLvalue33.PNLA_Width;
              tempnl_sheet33.Section_Long_NumberA:=n31;
              tempnl_sheet33.Section_Width_NumberA:=j31;
              tempnl_sheet33.Section_LongB:=Three_Section_PNLvalue33.PNLb_Long;
              tempnl_sheet33.Section_WidthB:=Three_Section_PNLvalue33.PNLb_Width;
              tempnl_sheet33.Section_Long_NumberB:=n332;
              tempnl_sheet33.Section_Width_NumberB:=n342;
              tempnl_sheet33.Section_Unit_Number:=n31*j31*Three_Section_PNLvalue33.PNLA_Unit_Long_Number*Three_Section_PNLvalue33.PNLA_Unit_Width_Number+n332*n342*Three_Section_PNLvalue33.PNLb_Unit_Long_Number*Three_Section_PNLvalue33.PNLb_Unit_Width_Number;
              tv31:=n31*j31; //���ڼ���PNLA��PNLB�ĸ�������
              tv32:=n332*n342;
              tempnl_sheet33.Section_PNLA_number:=0;
              tempnl_sheet33.Section_PNLB_number:=0;
              function_result:=Change_pnla_pnlb_number1(value_pnla2,TWO_value_pnla2,tv31,tv32,tempnl_sheet33.Section_PNLA_number,tempnl_sheet33.Section_PNLB_number);

             end;
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
              tv31:=n31*j31; //���ڼ���PNLA��PNLB�ĸ�������
              tv32:=n331*n341;
              tempnl_sheet33.Section_PNLA_number:=0;
              tempnl_sheet33.Section_PNLB_number:=0;
              function_result:=Change_pnla_pnlb_number1(value_pnla2,TWO_value_pnla2,tv31,tv32,tempnl_sheet33.Section_PNLA_number,tempnl_sheet33.Section_PNLa_number);

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
              tv31:=n301*n302; //���ڼ���PNLA��PNLB�ĸ�������
              tv32:=0;
              tempnl_sheet33.Section_PNLA_number:=0;
              tempnl_sheet33.Section_PNLB_number:=0;
              function_result:=Change_pnla_pnlb_number1(value_pnla2,TWO_value_pnla2,tv31,tv32,tempnl_sheet33.Section_PNLA_number,tempnl_sheet33.Section_PNLB_number);

             end;

           end;
       end;
     end;
    //3333333
  end;
//--------------����


  //�����ܵ�Ԫ��
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
      Summation_rate:=Result_MakeUp2^[(iSheet+1)*FResultCountPerSheet-1].Using_Rate;
      k:=(iSheet+1)*FResultCountPerSheet-1;
      if Result_MakeUp2^[(iSheet+1)*FResultCountPerSheet-2].Using_Rate<Summation_rate then
      begin
        Summation_rate:=Result_MakeUp2^[(iSheet+1)*FResultCountPerSheet-2].Using_Rate;
        k:=(iSheet+1)*FResultCountPerSheet-2;
      end;
      if Result_MakeUp2^[(iSheet+1)*FResultCountPerSheet-3].Using_Rate<Summation_rate then
      begin
        Summation_rate:=Result_MakeUp2^[(iSheet+1)*FResultCountPerSheet-3].Using_Rate;
        k:=(iSheet+1)*FResultCountPerSheet-3;
      end;
   end else
      k:=iSheet;

  if (Leave_Section_falchion_number1=2) and (FResultCount>FResultCountPerSheet) then
  begin
    result_1:=(round(Summation_rate*10000)<round((tem_rate2+tem_rate3+rate_10)*10000)) or
              ( (round(Summation_rate*10000)=round((tem_rate2+tem_rate3+rate_10)*10000)) and
                  ( ((value_pnla2=1) and (pnl_long_number333*pnl_width_number333+tempnl_sheet22.Section_PNLA_number+tempnl_sheet33.Section_PNLA_number+
                     tempnl_sheet22.Section_PNLb_number+tempnl_sheet33.Section_PNLb_number<Result_MakeUp2^[K].PNLA_number_Per_Sheet+Result_MakeUp2^[K].PNLb_number_Per_Sheet)) or
                    ((value_pnla2=2) and (tempnl_sheet22.Section_PNLA_number+tempnl_sheet33.Section_PNLA_number+
                    pnl_long_number333*pnl_width_number333+tempnl_sheet22.Section_PNLb_number+tempnl_sheet33.Section_PNLb_number<Result_MakeUp2^[K].PNLA_number_Per_Sheet+Result_MakeUp2^[K].PNLb_number_Per_Sheet
                    ))
                   )
              ) ;

    if FResultCountPerSheet>1 then
      result_1:=result_1 and
                (  ( ( (round((tem_rate2+tem_rate3+rate_10)*10000)<>round(Result_MakeUp2^[(iSheet+1)*FResultCountPerSheet-1].Using_Rate*10000)) and
                       (round((tem_rate2+tem_rate3+rate_10)*10000)<>round(Result_MakeUp2^[(iSheet+1)*FResultCountPerSheet-2].Using_Rate*10000)) and
                       (round((tem_rate2+tem_rate3+rate_10)*10000)<>round(Result_MakeUp2^[(iSheet+1)*FResultCountPerSheet-3].Using_Rate*10000)) //or
                     ) or (
                           ( (round((tem_rate2+tem_rate3+rate_10)*10000)=round(Result_MakeUp2^[(iSheet+1)*FResultCountPerSheet-1].Using_Rate*10000)) or
                             (round((tem_rate2+tem_rate3+rate_10)*10000)=round(Result_MakeUp2^[(iSheet+1)*FResultCountPerSheet-2].Using_Rate*10000)) or
                             (round((tem_rate2+tem_rate3+rate_10)*10000)=round(Result_MakeUp2^[(iSheet+1)*FResultCountPerSheet-3].Using_Rate*10000))
                           ) and
                             ( ((value_pnla2=1) and (pnl_long_number333*pnl_width_number333+tempnl_sheet22.Section_PNLA_number+tempnl_sheet33.Section_PNLA_number+
                                tempnl_sheet22.Section_PNLb_number+tempnl_sheet33.Section_PNLb_number<Result_MakeUp2^[K].PNLA_number_Per_Sheet+Result_MakeUp2^[K].PNLb_number_Per_Sheet)) or
                               ((value_pnla2=2) and (tempnl_sheet22.Section_PNLA_number+tempnl_sheet33.Section_PNLA_number+
                                pnl_long_number333*pnl_width_number333+tempnl_sheet22.Section_PNLb_number+tempnl_sheet33.Section_PNLb_number<Result_MakeUp2^[K].PNLA_number_Per_Sheet+Result_MakeUp2^[K].PNLb_number_Per_Sheet)
                             )
                   )
                          )
                   )
                );

  end else if (Leave_Section_falchion_number1=2) and (FResultCountPerSheet=1) then
    result_1:=(round(Summation_rate*10000)<round((tem_rate2+tem_rate3+rate_10)*10000)) or
              ( (round(Summation_rate*10000)=round((tem_rate2+tem_rate3+rate_10)*10000)) and
                  ( ((value_pnla2=1) and (pnl_long_number333*pnl_width_number333+tempnl_sheet22.Section_PNLA_number+tempnl_sheet33.Section_PNLA_number+
                     tempnl_sheet22.Section_PNLb_number+tempnl_sheet33.Section_PNLb_number<Result_MakeUp2^[K].PNLA_number_Per_Sheet+Result_MakeUp2^[K].PNLb_number_Per_Sheet)) or
                    ((value_pnla2=2) and (tempnl_sheet22.Section_PNLA_number+tempnl_sheet33.Section_PNLA_number+
                    pnl_long_number333*pnl_width_number333+tempnl_sheet22.Section_PNLb_number+tempnl_sheet33.Section_PNLb_number<Result_MakeUp2^[K].PNLA_number_Per_Sheet+Result_MakeUp2^[K].PNLb_number_Per_Sheet
                    ))
                   )
              ) ;




   if ((FResultCount<=FResultCountPerSheet) and (FResultCountPerSheet>1)) or result_1 then //�����ʱ���ǰ�Ĵ�,��ȡ���ڵ�
   begin
     if (FResultCountPerSheet>1) and (FResultCount<=FResultCountPerSheet) then
     begin
       if (round(Summation_rate*10000)=round((tem_rate2+tem_rate3+rate_10)*10000)) and
          (value332.PNLA_Unit_Long*value332.PNLA_Unit_Width=Result_MakeUp2^[iSheet*FResultCountPerSheet+FResultCount-2].PNLA_Unit_Long*Result_MakeUp2^[iSheet*FResultCountPerSheet+FResultCount-2].PNLA_Unit_Width)
        then exit;
       K:=iSheet*FResultCountPerSheet+FResultCount-1;
       FResultCount:=FResultCount+1;
     end ;
     Summation_rate:=tem_rate2+tem_rate3+rate_10;

       { MaxPnlNumber2:=temMaxPnlNumber2;
        Summation_rate:=tem_rate2+tem_rate3+rate_10;
        TEM_Falchion_Number2:=Falchion_Number1;//
        Falchion_Number1:=TEM_Falchion_Number1;//��������
        }
     if  value_pnla2=1  then
     begin
       Result_MakeUp2^[K].PNLA_number_Per_Sheet:=pnl_long_number333*pnl_width_number333+tempnl_sheet22.Section_PNLA_number+tempnl_sheet33.Section_PNLA_number ;
       Result_MakeUp2^[K].PNLb_number_Per_Sheet:=tempnl_sheet22.Section_PNLb_number+tempnl_sheet33.Section_PNLb_number;
     end;
     if  value_pnla2=2  then
     begin
       Result_MakeUp2^[K].PNLA_number_Per_Sheet:=tempnl_sheet22.Section_PNLA_number+tempnl_sheet33.Section_PNLA_number ;
       Result_MakeUp2^[K].PNLb_number_Per_Sheet:=pnl_long_number333*pnl_width_number333+tempnl_sheet22.Section_PNLb_number+tempnl_sheet33.Section_PNLb_number;
     end;
     //��������,һ����value32,������value3,������value3,�������PNLA��PNLB����
     Result_MakeUp2^[K].Draw_type:=type333;//���ڻ�ͼ
     Result_MakeUp2^[K].PNLA_Unit_Long:=value332.PNLA_Unit_Long ;
     Result_MakeUp2^[K].PNLA_Unit_Width :=value332.PNLA_Unit_Width ;
     Result_MakeUp2^[K].PNLA_Unit_Long_Space :=value332.PNLA_Unit_Long_Space ;
     Result_MakeUp2^[K].PNLA_Unit_Width_Space :=value332.PNLA_Unit_Width_Space ;
     Result_MakeUp2^[K].PNLA_Unit_Long_ToPNL :=value332.PNLA_Unit_Long_ToPNL ;
     Result_MakeUp2^[K].PNLA_Unit_Width_ToPNL :=value332.PNLA_Unit_Width_ToPNL ;
     Result_MakeUp2^[K].PNLA_Unit_Long_Number :=value332.PNLA_Unit_Long_Number ;
     Result_MakeUp2^[K].PNLA_Unit_Width_Number :=value332.PNLA_Unit_Width_Number ;
     Result_MakeUp2^[K].PNLA_Long :=value332.PNLA_Long  ;
     Result_MakeUp2^[K].PNLA_Width :=value332.PNLA_Width ;

     Result_MakeUp2^[K].PNLb_Unit_Long:=value332.PNLb_Unit_Long ;
     Result_MakeUp2^[K].PNLb_Unit_Width :=value332.PNLb_Unit_Width ;
     Result_MakeUp2^[K].PNLb_Unit_Long_Space :=value332.PNLb_Unit_Long_Space ;
     Result_MakeUp2^[K].PNLb_Unit_Width_Space :=value332.PNLb_Unit_Width_Space ;
     Result_MakeUp2^[K].PNLb_Unit_Long_ToPNL :=value332.PNLb_Unit_Long_ToPNL ;
     Result_MakeUp2^[K].PNLb_Unit_Width_ToPNL :=value332.PNLb_Unit_Width_ToPNL ;
     Result_MakeUp2^[K].PNLb_Unit_Long_Number :=value332.PNLb_Unit_Long_Number ;
     Result_MakeUp2^[K].PNLb_Unit_Width_Number :=value332.PNLb_Unit_Width_Number ;
     Result_MakeUp2^[K].PNLb_Long :=value332.PNLb_Long  ;
     Result_MakeUp2^[K].PNLb_Width :=value332.PNLb_Width ;
     //һ��,����һ������,
     Result_MakeUp2^[K].One_Section_Long:=value332.PNLA_Long;
     Result_MakeUp2^[K].One_Section_Width:=value332.PNLA_Width;
     Result_MakeUp2^[K].One_Section_Long_Number:=pnl_long_number333;
     Result_MakeUp2^[K].One_Section_Width_Number:=pnl_width_number333;
     Result_MakeUp2^[K].One_Section_Unit_Number:=pnl_long_number333*pnl_width_number333*value332.PNLa_Unit_Long_Number*value332.PNLa_Unit_Width_Number;
      if Two_Section_Draw_value333=2 then
      begin     //���������볤�����
         //����,���¶�������
        Result_MakeUp2^[K].Two_Section_LongA:=tempnl_sheet22.Section_Widtha;  //
        Result_MakeUp2^[K].Two_Section_WidthA:=tempnl_sheet22.Section_Longa ;
        Result_MakeUp2^[K].Two_Section_Long_NumberA:=tempnl_sheet22.Section_Width_Numbera;
        Result_MakeUp2^[K].Two_Section_Width_NumberA:=tempnl_sheet22.Section_Long_Numbera ;
        Result_MakeUp2^[K].Two_Section_LongB:=tempnl_sheet22.Section_Widthb ;
        Result_MakeUp2^[K].Two_Section_WidthB:=tempnl_sheet22.Section_Longb ;
        Result_MakeUp2^[K].Two_Section_Long_NumberB:=tempnl_sheet22.Section_Width_NumberB;
        Result_MakeUp2^[K].Two_Section_Width_NumberB:=tempnl_sheet22.Section_Long_NumberB;
        Result_MakeUp2^[K].Two_Section_Longc:=tempnl_sheet22.Section_Widthc ;
        Result_MakeUp2^[K].Two_Section_Widthc:=tempnl_sheet22.Section_Longc ;
        Result_MakeUp2^[K].Two_Section_Long_Numberc:=tempnl_sheet22.Section_Width_Numberc;
        Result_MakeUp2^[K].Two_Section_Width_Numberc:=tempnl_sheet22.Section_Long_Numberc;
        Result_MakeUp2^[K].Two_Section_Unit_Number:=tempnl_sheet22.Section_Unit_Number;

        Result_MakeUp2^[K].Two_Section_Array_type:=Two_Section_Draw_value333;
      end else  if Two_Section_Draw_value333=1 then
      begin
        //����,���¶�������
        Result_MakeUp2^[K].Two_Section_LongA:=tempnl_sheet22.Section_LongA ;
        Result_MakeUp2^[K].Two_Section_WidthA:=tempnl_sheet22.Section_WidthA ;
        Result_MakeUp2^[K].Two_Section_Long_NumberA:=tempnl_sheet22.Section_Long_NumberA ;
        Result_MakeUp2^[K].Two_Section_Width_NumberA:=tempnl_sheet22.Section_Width_NumberA;
        Result_MakeUp2^[K].Two_Section_LongB:=tempnl_sheet22.Section_LongB ;
        Result_MakeUp2^[K].Two_Section_WidthB:=tempnl_sheet22.Section_WidthB ;
        Result_MakeUp2^[K].Two_Section_Long_NumberB:=tempnl_sheet22.Section_Long_NumberB;
        Result_MakeUp2^[K].Two_Section_Width_NumberB:=tempnl_sheet22.Section_Width_NumberB;
        Result_MakeUp2^[K].Two_Section_Longc:=tempnl_sheet22.Section_Longc ;
        Result_MakeUp2^[K].Two_Section_Widthc:=tempnl_sheet22.Section_Widthc ;
        Result_MakeUp2^[K].Two_Section_Long_Numberc:=tempnl_sheet22.Section_Long_NumberB;
        Result_MakeUp2^[K].Two_Section_Width_Numberc:=tempnl_sheet22.Section_Width_Numberc;

        Result_MakeUp2^[K].Two_Section_Unit_Number:=tempnl_sheet22.Section_Unit_Number;
        Result_MakeUp2^[K].Two_Section_Array_type:=Two_Section_Draw_value333;//array_type2;
      end;
      if Three_Section_Draw_value333=2 then
      begin   // �Ե������볤�����
        Result_MakeUp2^[K].three_Section_LongA:=  tempnl_sheet33.Section_WidthA ;
        Result_MakeUp2^[K].three_Section_WidthA:=tempnl_sheet33.Section_LongA ;
        Result_MakeUp2^[K].three_Section_Long_NumberA:=tempnl_sheet33.Section_Width_NumberA;
        Result_MakeUp2^[K].three_Section_Width_NumberA:= tempnl_sheet33.Section_Long_NumberA ;

        Result_MakeUp2^[K].three_Section_LongB:=tempnl_sheet33.Section_WidthB ;
        Result_MakeUp2^[K].three_Section_WidthB:= tempnl_sheet33.Section_LongB ;
        Result_MakeUp2^[K].three_Section_Long_NumberB:=tempnl_sheet33.Section_Width_NumberB;
        Result_MakeUp2^[K].three_Section_Width_NumberB:=tempnl_sheet33.Section_Long_NumberB;

        Result_MakeUp2^[K].three_Section_Longc:=tempnl_sheet33.Section_Widthc ;
        Result_MakeUp2^[K].three_Section_Widthc:= tempnl_sheet33.Section_Longc ;
        Result_MakeUp2^[K].three_Section_Long_Numberc:=tempnl_sheet33.Section_Width_Numberc;
        Result_MakeUp2^[K].three_Section_Width_Numberc:=tempnl_sheet33.Section_Long_Numberc;

        Result_MakeUp2^[K].three_Section_Unit_Number:=tempnl_sheet33.Section_Unit_Number;
        Result_MakeUp2^[K].Three_Section_Array_type:=Three_Section_Draw_value333;//array_type3;
      end else  if Three_Section_Draw_value333=1 then
      begin
        //����,������������
        Result_MakeUp2^[K].three_Section_LongA:=tempnl_sheet33.Section_LongA ;
        Result_MakeUp2^[K].three_Section_WidthA:=tempnl_sheet33.Section_WidthA ;
        Result_MakeUp2^[K].three_Section_Long_NumberA:=tempnl_sheet33.Section_Long_NumberA ;
        Result_MakeUp2^[K].three_Section_Width_NumberA:=tempnl_sheet33.Section_Width_NumberA;
        Result_MakeUp2^[K].three_Section_LongB:=tempnl_sheet33.Section_LongB ;
        Result_MakeUp2^[K].three_Section_WidthB:=tempnl_sheet33.Section_WidthB ;
        Result_MakeUp2^[K].three_Section_Long_NumberB:=tempnl_sheet33.Section_Long_NumberB;
        Result_MakeUp2^[K].three_Section_Width_NumberB:=tempnl_sheet33.Section_Width_NumberB;

        Result_MakeUp2^[K].three_Section_Longc:=tempnl_sheet33.Section_Longc ;
        Result_MakeUp2^[K].three_Section_Widthc:=tempnl_sheet33.Section_Widthc ;
        Result_MakeUp2^[K].three_Section_Long_Numberc:=tempnl_sheet33.Section_Long_Numberc;
        Result_MakeUp2^[K].three_Section_Width_Numberc:=tempnl_sheet33.Section_Width_Numberc;

        Result_MakeUp2^[K].three_Section_Unit_Number:=tempnl_sheet33.Section_Unit_Number;
        Result_MakeUp2^[K].Three_Section_Array_type:=Three_Section_Draw_value333;
      end;
     Result_MakeUp2^[K].Sheet_Long:=value333_sheet.Sheet_Long;//���ϳ�
     Result_MakeUp2^[K].Sheet_Width:=value333_sheet.Sheet_Width;//���Ͽ�


     if Tem_Calculate_Rate_Type1=1 then //�õ�Ԫ����
     begin
       Result_MakeUp2^[K].Pnl_Using_Rate:=Summation_rate;
       Result_MakeUp2^[K].Unit_Using_Rate:=Summation_rate;
       Result_MakeUp2^[K].Using_Rate:=Summation_rate;
     end;
     if Tem_Calculate_Rate_Type1=2 then //��PNL����
     begin
       Result_MakeUp2^[K].Unit_Using_Rate:=Result_MakeUp2^[K].One_Section_Unit_Number*Result_MakeUp2^[K].two_Section_Unit_Number*Result_MakeUp2^[K].three_Section_Unit_Number*value332.PNLA_Unit_Long*value332.PNLA_Unit_Width/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
       Result_MakeUp2^[K].Pnl_Using_Rate:=Summation_rate;
       Result_MakeUp2^[K].Using_Rate:=Summation_rate;
     end;

     if Tem_Calculate_Rate_Type1=0 then
     begin
          Result_MakeUp2^[K].Pnl_Using_Rate:=Summation_rate;
          Result_MakeUp2^[K].Using_Rate:=Summation_rate*value332.PNLA_Unit_Long*value332.PNLA_Unit_Width/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
          Result_MakeUp2^[K].unit_Using_Rate:=Result_MakeUp2^[K].Using_Rate;
     end;
  end; //1
end;

function TCutSheet2.Calculate_Unit_TwoPNL(var VALUE: TParam_PCB2): BOOLEAN;
VAR
 i1,i1_1,I2,j1,J2,i101,
 n1,n2,n3,n4,N5,N6,N7,N8 :integer;  //������ŵ�Ԫ����

 Result_Unit_size,tem_Result_Unit_size:TResult_PNL2;//���A,B����Ű����
 function_resul22:boolean;
 sheet_size0:TParam_Sheet2;
 X,Y:currency;
begin

   Result:=false;
   if (VALUE.PNLA_Long_Max<=VALUE.PNLA_Long_Min) or (VALUE.PNLA_Width_Max<=VALUE.PNLA_Width_Min) then
   begin
     showmessage('�������������!');
     exit;
   end;
   if (VALUE.PNLb_Long_Max<=VALUE.PNLb_Long_Min) or (VALUE.PNLb_Width_Max<=VALUE.PNLb_Width_Min) then
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
       n1:=trunc((VALUE.PNLA_Long_Min -2*VALUE.Unit_Long_ToPNL+value.Unit_Long_Space ) / (VALUE.Unit_Long+value.Unit_Long_Space) );
       n2:=trunc((VALUE.PNLA_Long_MAX -2*VALUE.Unit_Long_ToPNL+value.Unit_Long_Space ) / (VALUE.Unit_Long+value.Unit_Long_Space) );
       n3:=trunc((VALUE.PNLA_WIDTH_Min -2*VALUE.Unit_Width_ToPNL +value.Unit_Width_Space ) / (VALUE.Unit_Width+value.Unit_Width_Space) );
       n4:=trunc((VALUE.PNLA_WIDTH_MAX -2*VALUE.Unit_Width_ToPNL+value.Unit_Width_Space ) / (VALUE.Unit_Width+value.Unit_Width_Space) );

       n5:=trunc((VALUE.PNLb_Long_Min -2*VALUE.Unit_Long_ToPNL+value.Unit_Long_Space ) / (VALUE.Unit_Long+value.Unit_Long_Space) );

       n6:=trunc((VALUE.PNLb_Long_MAX -2*VALUE.Unit_Long_ToPNL+value.Unit_Long_Space ) / (VALUE.Unit_Long+value.Unit_Long_Space) );
       n7:=trunc((VALUE.PNLb_WIDTH_Min -2*VALUE.Unit_Width_ToPNL+value.Unit_Width_Space ) / (VALUE.Unit_Width+value.Unit_Width_Space) );
       n8:=trunc((VALUE.PNLb_WIDTH_MAX -2*VALUE.Unit_Width_ToPNL+value.Unit_Width_Space ) / (VALUE.Unit_Width+value.Unit_Width_Space) );

       if (VALUE.PNLA_Long_Min -2*VALUE.Unit_Long_ToPNL+value.Unit_Long_Space ) / (VALUE.Unit_Long+value.Unit_Long_Space)-n1>0 then  n1:=n1+1;

       if (VALUE.PNLA_WIDTH_Min -2*VALUE.Unit_Width_ToPNL+value.Unit_Width_Space ) / (VALUE.Unit_Width+value.Unit_Width_Space)-n3>0 then  n3:=n3+1;

       if (VALUE.PNLb_Long_Min -2*VALUE.Unit_Long_ToPNL+value.Unit_Long_Space ) / (VALUE.Unit_Long+value.Unit_Long_Space)-n5>0 then  n5:=n5+1;

       if (VALUE.PNLb_WIDTH_Min -2*VALUE.Unit_Width_ToPNL+value.Unit_Width_Space ) / (VALUE.Unit_Width+value.Unit_Width_Space)-n7>0 then  n7:=n7+1;

       if  (n1>n2) or (n3>n4) or (n5>n6) or (n7>n8) then
       begin
         i101:=0;
       end  else
       begin
         i101:=1;
       end;
       Calculate_Flag1:=Calculate_Flag1+i101;//���ڼ����Ƿ���ų������ŷ�
       if (n1<0)or (n3<0)then
       begin
         showmessage('����������޴���!');
         exit;
       end;
       if (n5<0)or (n7<0)then
       begin
         showmessage('��������޴���!');
         exit;
       end;
       for i1:=n1 to n2 do
       begin  //1
         for i2:=n3 to n4 do
         begin   //2
               for j1:=n5 to n6 do
               begin  //3
                  for j2:=n7 to n8 do
                  begin  //4
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

                     Result_Unit_size.PNLb_Unit_Long:=value.Unit_Long;
                     Result_Unit_size.PNLb_Unit_Width:=value.Unit_Width ;
                     Result_Unit_size.PNLb_Unit_Long_Space:=value.Unit_Long_Space ;
                     Result_Unit_size.PNLb_Unit_Width_Space:=value.Unit_Width_Space;
                     Result_Unit_size.PNLb_Unit_Long_ToPNL:=value.Unit_Long_ToPNL ;
                     Result_Unit_size.PNLb_Unit_Width_ToPNL:=value.Unit_Width_ToPNL;
                     Result_Unit_size.PNLb_Unit_Long_Number:=j1;
                     Result_Unit_size.PNLb_Unit_Width_Number:=j2;
                     Result_Unit_size.PNLb_Long:=value.Unit_Long*j1+(j1-1)*value.Unit_Long_Space+2*value.Unit_Long_ToPNL;
                     Result_Unit_size.PNLb_Width:=value.Unit_Width*j2+(j2-1)*value.Unit_Width_Space+2*value.Unit_Width_ToPNL;

                     for i1_1:=low(Param_Sheet2^) to high(Param_Sheet2^) do
                     begin
                       IF (Param_Sheet2^[i1_1].Sheet_Long>0) and (Param_Sheet2^[i1_1].Sheet_Width>0) then //���ϳ������0,�Ŵ���
                       begin
                         //�˴�������PNL����, Calculate_TwoPNL_Sheet_1,���������:
                         //1.���ϳ���Ե�;2.PNLA��PNLB���гߴ�Ե�;3.���ϳ���Ե���PNLA��PNLB���гߴ�Ե�
                         if  FResultCountPerSheet=1 then
                             Summation_rate:=Result_MakeUp2^[i1_1].Using_Rate
                         else if Result_MakeUp2^[i1_1].Using_Rate=0 then
                            FResultCount:=1;  //һ�ִ������״�
                         tem_Result_Unit_size:=Result_Unit_size;
                         sheet_size0.Sheet_Long:=Param_Sheet2^[i1_1].Sheet_Long;
                         sheet_size0.Sheet_Width:=Param_Sheet2^[i1_1].Sheet_Width;
                         if (sheet_size0.Sheet_Long>=Result_Unit_size.PNLA_Long ) and (sheet_size0.Sheet_Width>Result_Unit_size.PNLA_Width)then
                              function_resul22:=Calculate_TwoPNL_Sheet_1(tem_Result_Unit_size,sheet_size0,1,i1_1);

                          //�Ե����ϳ���
                          sheet_size0.Sheet_Long:=Param_Sheet2^[i1_1].Sheet_Width ;
                          sheet_size0.Sheet_Width:=Param_Sheet2^[i1_1].Sheet_Long;
                          if (sheet_size0.Sheet_Long>=Result_Unit_size.PNLA_Long ) and (sheet_size0.Sheet_Width>Result_Unit_size.PNLA_Width)then
                              function_resul22:=Calculate_TwoPNL_Sheet_1(tem_Result_Unit_size,sheet_size0,1,i1_1);
                             //�Ե�pnla,pnlb
                             tem_Result_Unit_size.PNLA_Unit_Long:=Result_Unit_size.PNLB_Unit_Long;
                             tem_Result_Unit_size.PNLA_Unit_Width:=Result_Unit_size.PNLb_Unit_Width;
                             tem_Result_Unit_size.PNLA_Unit_Long_Space:=Result_Unit_size.PNLb_Unit_Long_Space;
                             tem_Result_Unit_size.PNLA_Unit_Width_Space:=Result_Unit_size.PNLb_Unit_Width_Space;
                             tem_Result_Unit_size.PNLA_Unit_Long_ToPNL:=Result_Unit_size.PNLb_Unit_Long_ToPNL;
                             tem_Result_Unit_size.PNLA_Unit_Width_ToPNL:=Result_Unit_size.PNLb_Unit_Width_ToPNL;
                             tem_Result_Unit_size.PNLA_Unit_Long_Number:=Result_Unit_size.PNLb_Unit_Long_Number;
                             tem_Result_Unit_size.PNLA_Unit_Width_Number:=Result_Unit_size.PNLb_Unit_Width_Number;
                             tem_Result_Unit_size.PNLA_Long:=Result_Unit_size.PNLB_Long;
                             tem_Result_Unit_size.PNLA_Width:=Result_Unit_size.PNLb_Width;

                             tem_Result_Unit_size.PNLb_Unit_Long:=Result_Unit_size.PNLa_Unit_Long;
                             tem_Result_Unit_size.PNLb_Unit_Width:=Result_Unit_size.PNLA_Unit_Width;
                             tem_Result_Unit_size.PNLb_Unit_Long_Space:=Result_Unit_size.PNLA_Unit_Long_Space;
                             tem_Result_Unit_size.PNLb_Unit_Width_Space:=Result_Unit_size.PNLA_Unit_Width_Space;
                             tem_Result_Unit_size.PNLb_Unit_Long_ToPNL:=Result_Unit_size.PNLA_Unit_Long_ToPNL;
                             tem_Result_Unit_size.PNLb_Unit_Width_ToPNL:=Result_Unit_size.PNLA_Unit_Width_ToPNL;
                             tem_Result_Unit_size.PNLb_Unit_Long_Number:=Result_Unit_size.PNLA_Unit_Long_Number;
                             tem_Result_Unit_size.PNLb_Unit_Width_Number:=Result_Unit_size.PNLA_Unit_Width_Number;
                             tem_Result_Unit_size.PNLb_Long:=Result_Unit_size.PNLa_Long;
                             tem_Result_Unit_size.PNLb_Width:=Result_Unit_size.PNLA_Width;

                             sheet_size0.Sheet_Long:=Param_Sheet2^[i1_1].Sheet_Long;
                             sheet_size0.Sheet_Width:=Param_Sheet2^[i1_1].Sheet_Width;
                             if (sheet_size0.Sheet_Long>=Result_Unit_size.PNLA_Long ) and (sheet_size0.Sheet_Width>Result_Unit_size.PNLA_Width)then
                                 function_resul22:=Calculate_TwoPNL_Sheet_1(tem_Result_Unit_size,sheet_size0,2,i1_1);

                              //�Ե�pnla,pnlb,��Ե����ϳ���

                              sheet_size0.Sheet_Long:=Param_Sheet2^[i1_1].Sheet_Width ;
                              sheet_size0.Sheet_Width:=Param_Sheet2^[i1_1].Sheet_Long;
                              if (sheet_size0.Sheet_Long>=Result_Unit_size.PNLA_Long ) and (sheet_size0.Sheet_Width>Result_Unit_size.PNLA_Width)then
                                 function_resul22:=Calculate_TwoPNL_Sheet_1(tem_Result_Unit_size,sheet_size0,2,i1_1);


                       end;
                     end;
                  end; //4
               end; //3
         end; //2
       end; //1
       VALUE.Unit_Width_ToPNL:=VALUE.Unit_Width_ToPNL-1;
     end;
     VALUE.Unit_Width_ToPNL:=Y;
     VALUE.Unit_Long_ToPNL:=VALUE.Unit_Long_ToPNL-1;
   end;
   VALUE.Unit_Long_ToPNL:=X;
   VALUE.Unit_Width_ToPNL:=Y;
end;

function TCutSheet2.Get_Calculate_Result_Number: integer;
begin
   Result:=0;
end;

function TCutSheet2.Get_Echange_Unit_To_PNL_Space: boolean;
begin
   Result:=Echange_Unit_To_PNL_Space1;
end;

function TCutSheet2.Get_Echange_Unit_To_Unit_Space: boolean;
begin
    Result:=Echange_Unit_To_Unit_Space1;
end;

function TCutSheet2.Get_Input_PCB_SIZE_TwoPNL_1: TParam_PCB2;
begin
  Result:=Param_PCB2;
end;

function TCutSheet2.Get_Input_Sheet_Size_TwoPNL_1(Index: integer): TParam_Sheet2;
begin
   Result:=Param_Sheet2^[index];
end;

function TCutSheet2.Get_Leave_Section_falchion_number: integer;
begin
   Result:=Leave_Section_falchion_number1;
end;

function TCutSheet2.Get_tresult_makeup_using_Sheet_TwoPNL_1(index: integer): TResult_MakeUp2;
begin
  Result:=Result_MakeUp2^[index];
end;

procedure TCutSheet2.Set_Echange_Unit_To_PNL_Space(
  const Value: boolean);
begin
  Echange_Unit_To_PNL_Space1:=value;
end;

procedure TCutSheet2.Set_Echange_Unit_To_Unit_Space(
  const Value: boolean);
begin
   Echange_Unit_To_Unit_Space1:=value;
end;

procedure TCutSheet2.Set_Input_PCB_SIZE_TwoPNL_1(const Value: TParam_PCB2);
begin
  Param_PCB2:=Value;
end;

procedure TCutSheet2.Set_Input_Sheet_Size_TwoPNL_1(Index: integer; const Value: TParam_Sheet2);
begin
   Param_Sheet2^[index]:=value;
end;

procedure TCutSheet2.Set_Leave_Section_falchion_number1(const Value: integer);
begin
 Leave_Section_falchion_number1:=value;
end;

procedure TCutSheet2.Set_tresult_makeup_using_Sheet_TwoPNL_1(index: integer; const Value: TResult_MakeUp2);
begin
   Result_MakeUp2^[index]:=value;
end;

function TCutSheet2.Get_Calculate_Array_Complete_Percent: TProgressBar;
begin
   Result:=Tem_TProgressBar1;
end;

procedure TCutSheet2.Set_Calculate_Array_Complete_Percent(const Value: TProgressBar);
begin
   Tem_TProgressBar1:=Value;
end;

function TCutSheet2.Get_Calculate_Array_Complete_Time: boolean;
begin
   Result:=Tem_Calculate_Array_Complete_Time_Display;
end;

procedure TCutSheet2.Set_Calculate_Array_Complete_Time(const Value: boolean);
begin
   Tem_Calculate_Array_Complete_Time_Display:=Value;
end;

function TCutSheet2.Get_Tem_Calculate_Rate_Type1: integer;
begin
  Result:=Tem_Calculate_Rate_Type1;
end;

procedure TCutSheet2.Set_Tem_Calculate_Rate_Type1(const Value: integer);
begin
   Tem_Calculate_Rate_Type1:=value;
end;

function TCutSheet2.Get_Calculate_Falchion_Number_Equality_Hold: boolean;
begin
   Result:=Calculate_Falchion_Number_Equality_Hold_1;
end;

procedure TCutSheet2.Set_Calculate_Falchion_Number_Equality_Hold(
  const Value: boolean);
begin
   Calculate_Falchion_Number_Equality_Hold_1:=Value;
end;

function TCutSheet2.Echange_Two_And_Three_Section_Data(var value1: array of TResult_MakeUp2): boolean;
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

function TCutSheet2.Pnla_PnlB_number(var value1: array of TResult_MakeUp2): boolean;
var
i: integer;
begin
   for i:=low(value1) to high(value1) do
   begin
     value1[i].PNLA_number_Per_Sheet:=0;
     value1[i].PNLb_number_Per_Sheet:=0;

     if ((value1[i].one_Section_Long=value1[i].PNLA_Long)  and (value1[i].one_Section_width=value1[i].PNLA_width))
       or ((value1[i].one_Section_Long=value1[i].PNLA_width)  and (value1[i].one_Section_width=value1[i].PNLA_Long))
     then
     begin
        value1[i].PNLA_number_Per_Sheet:=value1[i].one_Section_Long_Number*value1[i].one_Section_width_Number+ value1[i].PNLA_number_Per_Sheet;
     end
     else if ((value1[i].one_Section_Long=value1[i].PNLb_Long)  and (value1[i].one_Section_width=value1[i].PNLb_width))
       or ((value1[i].one_Section_Long=value1[i].PNLb_width)  and (value1[i].one_Section_width=value1[i].PNLb_Long))
     then
     begin
        value1[i].PNLb_number_Per_Sheet:=value1[i].one_Section_Long_Number*value1[i].one_Section_width_Number+ value1[i].PNLb_number_Per_Sheet;
     end;

     if ((value1[i].Two_Section_LongA=value1[i].PNLA_Long)  and (value1[i].Two_Section_WidthA=value1[i].PNLA_width))
       or ((value1[i].Two_Section_LongA=value1[i].PNLA_width)  and (value1[i].Two_Section_WidthA=value1[i].PNLA_Long))
     then
     begin
        value1[i].PNLA_number_Per_Sheet:=value1[i].Two_Section_Long_NumberA*value1[i].Two_Section_width_NumberA+ value1[i].PNLA_number_Per_Sheet;
     end
     else if ((value1[i].Two_Section_LongA=value1[i].PNLb_Long)  and (value1[i].Two_Section_WidthA=value1[i].PNLb_width))
       or ((value1[i].Two_Section_LongA=value1[i].PNLb_width)  and (value1[i].Two_Section_WidthA=value1[i].PNLb_Long))
     then
     begin
        value1[i].PNLb_number_Per_Sheet:=value1[i].Two_Section_Long_NumberA*value1[i].Two_Section_width_NumberA+ value1[i].PNLb_number_Per_Sheet;
     end;
     if ((value1[i].Two_Section_Longb=value1[i].PNLA_Long)  and (value1[i].Two_Section_Widthb=value1[i].PNLA_width))
       or ((value1[i].Two_Section_Longb=value1[i].PNLA_width)  and (value1[i].Two_Section_Widthb=value1[i].PNLA_Long))
     then
     begin
        value1[i].PNLA_number_Per_Sheet:=value1[i].Two_Section_Long_Numberb*value1[i].Two_Section_width_Numberb+ value1[i].PNLA_number_Per_Sheet;
     end
     else if ((value1[i].Two_Section_Longb=value1[i].PNLb_Long)  and (value1[i].Two_Section_Widthb=value1[i].PNLb_width))
       or ((value1[i].Two_Section_Longb=value1[i].PNLb_width)  and (value1[i].Two_Section_Widthb=value1[i].PNLb_Long))
     then
     begin
        value1[i].PNLb_number_Per_Sheet:=value1[i].Two_Section_Long_Numberb*value1[i].Two_Section_width_Numberb+ value1[i].PNLb_number_Per_Sheet;
     end;

     if ((value1[i].Three_Section_LongA=value1[i].PNLA_Long)  and (value1[i].Three_Section_WidthA=value1[i].PNLA_width))
       or ((value1[i].Three_Section_LongA=value1[i].PNLA_width)  and (value1[i].Three_Section_WidthA=value1[i].PNLA_Long))
     then
     begin
        value1[i].PNLA_number_Per_Sheet:=value1[i].Three_Section_Long_NumberA*value1[i].Three_Section_width_NumberA+ value1[i].PNLA_number_Per_Sheet;
     end
     else if ((value1[i].Three_Section_LongA=value1[i].PNLb_Long)  and (value1[i].Three_Section_WidthA=value1[i].PNLb_width))
       or ((value1[i].Three_Section_LongA=value1[i].PNLb_width)  and (value1[i].Three_Section_WidthA=value1[i].PNLb_Long))
     then
     begin
        value1[i].PNLb_number_Per_Sheet:=value1[i].Three_Section_Long_NumberA*value1[i].Three_Section_width_NumberA+ value1[i].PNLb_number_Per_Sheet;
     end;
     if ((value1[i].Three_Section_Longb=value1[i].PNLA_Long)  and (value1[i].Three_Section_Widthb=value1[i].PNLA_width))
       or ((value1[i].Three_Section_Longb=value1[i].PNLA_width)  and (value1[i].Three_Section_Widthb=value1[i].PNLA_Long))
     then
     begin
        value1[i].PNLA_number_Per_Sheet:=value1[i].Three_Section_Long_Numberb*value1[i].Three_Section_width_Numberb+ value1[i].PNLA_number_Per_Sheet;
     end
     else if ((value1[i].Three_Section_Longb=value1[i].PNLb_Long)  and (value1[i].Three_Section_Widthb=value1[i].PNLb_width))
       or ((value1[i].Three_Section_Longb=value1[i].PNLb_width)  and (value1[i].Three_Section_Widthb=value1[i].PNLb_Long))
     then
     begin
        value1[i].PNLb_number_Per_Sheet:=value1[i].Three_Section_Long_Numberb*value1[i].Three_Section_width_Numberb+ value1[i].PNLb_number_Per_Sheet;
     end;
   end;
end;


function TCutSheet2.Change_pnla_pnlb_number1(const  PnlA2, PnlB2,valuen1,valuen2: integer; var Two_pnlA2,Two_PnlB2: integer): BOOLEAN;
begin
   Result:=FALSE;
    if PnlA2=1 then //һ��ΪPNLA  ����
    begin
        if PnlB2=1 then
        begin
             Two_pnlA2:=Two_pnlA2+valuen1;
             Two_PnlB2:=Two_PnlB2+valuen2;
        end;
        if PnlB2=2 then
        begin
             Two_pnlA2:=Two_pnlA2+valuen2;
             Two_PnlB2:=Two_PnlB2+valuen1;
        end;
    end;
    if PnlA2=2 then //һ��ΪPNLB ����
    begin
        if PnlB2=1 THEN
        BEGIN
             Two_pnlA2:=Two_pnlA2+valuen2;
             Two_PnlB2:=Two_PnlB2+valuen1;
        end;
        if PnlB2=2 THEN
        BEGIN
             Two_pnlA2:=Two_pnlA2+valuen1;
             Two_PnlB2:=Two_PnlB2+valuen2;
        end;
    end;
    Result:=true;
end;

function TCutSheet2.Get_Change_PNL_Long_Width: boolean;
begin
    result:=Change_PNL_Long_Width1;
end;

function TCutSheet2.Get_No_Calculate_Falchion_Number: boolean;
begin
    result:=No_Calculate_Falchion_Number1;
end;

procedure TCutSheet2.Set_Change_PNL_Long_Width(const Value: boolean);
begin
   Change_PNL_Long_Width1:=value;
end;

procedure TCutSheet2.Set_No_Calculate_Falchion_Number(const Value: boolean);
begin
   No_Calculate_Falchion_Number1:=value;
end;

constructor TCutSheet2.Create(ASheet: PAParam_Sheet2;
  AResult_MakeUp: PAResult_MakeUp2;iResultCountPerSheet:integer);
begin
  inherited Create;
  Param_Sheet2:=ASheet;
  Result_MakeUp2:=AResult_MakeUp;
  FResultCountPerSheet:=iResultCountPerSheet;
end;

procedure TCutSheet2.Sort_Result;
  procedure QuickSort(var A:TAResult_MakeUp2; iLo, iHi: Integer;AscOrd:boolean=true);
  var
    Lo, Hi: Integer;
    Mid:currency;
    T: TResult_MakeUp2;
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
  QuickSort(Result_MakeUp2^,Low(Result_MakeUp2^), High(Result_MakeUp2^));
end;

end.
