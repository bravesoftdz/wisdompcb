//���ڼ��㳤�����εĿ���ͼ,ֻ��һ��PNL�ߴ�
{ʹ�÷���     pnl_size_s1:pnl_size;//�����¼ ȫ�ֱ���,�����ܻ�������ƴ��
var
  Input_PCB_SIZE_onePNL22:Input_PCB_SIZE_onePNL_1;//�����¼
  Input_Sheet_Size_15:Input_Sheet_Size_onePNL_1;//�����¼

  var_Sheet_Size_TwoPNL:Sheet_Size_twoPNL_1;//�����¼
begin
  //function TryStrToCurr(const S: string; out Value: Currency): Boolean;
  Input_PCB_SIZE_onePNL22.Unit_Long:=strtocurr(edit1.text); //��Ԫ��
  Input_PCB_SIZE_onePNL22.Unit_Width:=strtocurr(edit2.text); //��Ԫ��
  Input_PCB_SIZE_onePNL22.Unit_Long_Space:=1.5;//��Ԫ�����
  Input_PCB_SIZE_onePNL22.Unit_Width_Space:=1.5;//��Ԫ����
  Input_PCB_SIZE_onePNL22.Unit_Long_ToPNL:=8.05;//��Ԫ�����߾���
  Input_PCB_SIZE_onePNL22.Unit_Width_ToPNL:=5.88;//��Ԫ���߾���
  Input_PCB_SIZE_onePNL22.PNLA_Long_Max:=450;//PNLA������
  Input_PCB_SIZE_onePNL22.PNLA_Width_Max:=400;//PNLA������
  Input_PCB_SIZE_onePNL22.PNLA_Long_Min:=250; //PNLA������
  Input_PCB_SIZE_onePNL22.PNLA_Width_Min:=250;//PNLA������
  Aarray_Rectangle_onePNL1:=TAarray_Rectangle_onePNL1.Create;//������

  Input_Sheet_Size_15.Sheet_Long:=1232;//���ϳ�
  Input_Sheet_Size_15.Sheet_Width:=1080;//���Ͽ�
  Aarray_Rectangle_onePNL1.Input_Sheet_Size[0]:=Input_Sheet_Size_15; //����Ҫ�����Ĵ��ϳߴ�,ע���������ʾ
  //Input_Sheet_Size_15.Sheet_Long:=1030;//���ϳ�
  //Input_Sheet_Size_15.Sheet_Width:=1004;//���Ͽ�
  //Aarray_Rectangle_TwoPNL1.Input_Sheet_Size[1]:=Input_Sheet_Size_15; //����Ҫ�����Ĵ��ϳߴ�,ע���������ʾ

  Aarray_Rectangle_onePNL1.Input_PCB_SIZE:=Input_PCB_SIZE_onePNL22;//����Ҫ�����ĵ�Ԫ�ߴ����Ϣ

  Aarray_Rectangle_onePNL1.Calculate_Array_Complete_Percent:=ProgressBar2; //������ʾ����
  Aarray_Rectangle_onePNL1.Calculate_Array_Complete_Time_Display:=true;//��ʾ����ʱ��
  //Aarray_Rectangle_TwoPNL1.Echange_Unit_To_Unit_Space:=true;//������Ԫ���
  //Aarray_Rectangle_TwoPNL1.Echange_Unit_To_PNL_Space:=true;//���������߾���
  Aarray_Rectangle_onePNL1.Calculate_Rate_Type:=0;//0�õ�Ԫ����������2��PNL����������,��ʱ��������
  Aarray_Rectangle_onePNL1.Calculate_Array;//����

  //���Ű�ͼ
  pnl_size_s1.Long1:=Aarray_Rectangle_onePNL1.Calculate_Result[0].PNLA_Long;//ȡ���,PNLA��
  pnl_size_s1.Width1:=Aarray_Rectangle_onePNL1.Calculate_Result[0].PNLA_Width;//ȡ���,PNLA��
  pnl_size_s1.Unit_Long:=Aarray_Rectangle_onePNL1.Calculate_Result[0].PNLA_Unit_Long;//ȡ���,PNLA��Ԫ��
  pnl_size_s1.Unit_Width:=Aarray_Rectangle_onePNL1.Calculate_Result[0].PNLA_Unit_Width;//ȡ���,PNLA��Ԫ��
  pnl_size_s1.Unit_Long_ToUnit_Space:=Aarray_Rectangle_onePNL1.Calculate_Result[0].PNLA_Unit_Long_Space;//ȡ���,PNLA��Ԫ�����
  pnl_size_s1.Unit_Width_ToUnit_Space:=Aarray_Rectangle_onePNL1.Calculate_Result[0].PNLA_Unit_Width_Space;//ȡ���,PNLA��Ԫ����
  pnl_size_s1.Unit_Long_PNL_Space:=Aarray_Rectangle_onePNL1.Calculate_Result[0].PNLA_Unit_Long_ToPNL;//ȡ���,PNLA��Ԫ�����߾���
  pnl_size_s1.Unit_Width_PNL_Space:=Aarray_Rectangle_onePNL1.Calculate_Result[0].PNLA_Unit_Width_ToPNL;//ȡ���,PNLA��Ԫ���߾���
  pnl_size_s1.Unit_Long_Number:=Aarray_Rectangle_onePNL1.Calculate_Result[0].PNLA_Unit_Long_Number;//ȡ���,PNLA��Ԫ������
  pnl_size_s1.Unit_Width_number:=Aarray_Rectangle_onePNL1.Calculate_Result[0].PNLA_Unit_Width_Number;//ȡ���,PNLA��Ԫ�����
  Draw_Picture1:=TDraw_Picture.Create ;
  Draw_Picture1.Input_pnl_size:=pnl_size_s1; //����PNLA�ߴ�,���ڻ�PNLA�Ű�ͼ

  Image1.Canvas.Rectangle(0,0,Image1.Width,Image1.Height);//�������
  Draw_Picture1.Draw_PNL_Picture(image1.Canvas ,image1.Width ,image1.Height ); //��PNLA�Ű�ͼ,����image1������Ҫ���ĵط�
  Image2.Canvas.Rectangle(0,0,Image2.Width,Image2.Height);//�������
  //������ͼ
  var_Sheet_Size_TwoPNL.One_PNLA_Long:=Aarray_Rectangle_onePNL1.Calculate_Result[0].One_Section_Long;  //300;   //һ��PNLA��
  var_Sheet_Size_TwoPNL.One_PNLA_Width:=Aarray_Rectangle_onePNL1.Calculate_Result[0].One_Section_Width;//  250;  //һ��PNLA��
  var_Sheet_Size_TwoPNL.One_PNLA_Long_Number:=Aarray_Rectangle_onePNL1.Calculate_Result[0].One_Section_Long_Number;//  1;//һ��PNLA������
  var_Sheet_Size_TwoPNL.One_PNLA_Width_Number:=Aarray_Rectangle_onePNL1.Calculate_Result[0].One_Section_Width_Number;//  2;//һ��PNLA�����
  var_Sheet_Size_TwoPNL.Two_PNLA_Long:=Aarray_Rectangle_onePNL1.Calculate_Result[0].One_Section_LongA;//  300;
  var_Sheet_Size_OnePNL.One_PNLA_Width:=Aarray_Rectangle_onePNL1.Calculate_Result[0].One_Section_WidthA;//  150;
  var_Sheet_Size_OnePNL.One_PNLA_Long_Number:=Aarray_Rectangle_onePNL1.Calculate_Result[0].One_Section_Long_NumberA;//  3;
  var_Sheet_Size_OnePNL.One_PNLA_Width_Number:=Aarray_Rectangle_onePNL1.Calculate_Result[0].One_Section_Width_NumberA;//  1 ;
  var_Sheet_Size_OnePNL.One_PNLB_Long:=Aarray_Rectangle_onePNL1.Calculate_Result[0].One_Section_Longb;//  350;
  var_Sheet_Size_OnePNL.One_PNLB_Width:=Aarray_Rectangle_onePNL1.Calculate_Result[0].One_Section_Widthb;//  200;
  var_Sheet_Size_OnePNL.One_PNLB_Long_Number:=Aarray_Rectangle_onePNL1.Calculate_Result[0].One_Section_Long_NumberB;//  2;
  var_Sheet_Size_OnePNL.One_PNLB_Width_Number:=Aarray_Rectangle_onePNL1.Calculate_Result[0].One_Section_Width_NumberB;//  1;
  var_Sheet_Size_OnePNL.Three_PNLA_Long:=Aarray_Rectangle_onePNL1.Calculate_Result[0].Three_Section_LongA;//  230;
  var_Sheet_Size_OnePNL.Three_PNLA_Width:=Aarray_Rectangle_onePNL1.Calculate_Result[0].Three_Section_WidthA;//  240;
  var_Sheet_Size_OnePNL.Three_PNLA_Long_Number:=Aarray_Rectangle_onePNL1.Calculate_Result[0].Three_Section_Long_NumberA; // 5;
  var_Sheet_Size_OnePNL.Three_PNLA_Width_Number:=Aarray_Rectangle_onePNL1.Calculate_Result[0].Three_Section_Width_NumberA;//  1;
  var_Sheet_Size_OnePNL.Three_PNLB_Long:=Aarray_Rectangle_onePNL1.Calculate_Result[0].Three_Section_Longb;//280;
  var_Sheet_Size_OnePNL.Three_PNLB_Width:=Aarray_Rectangle_onePNL1.Calculate_Result[0].Three_Section_Widthb;//190;
  var_Sheet_Size_OnePNL.Three_PNLB_Long_Number:=Aarray_Rectangle_onePNL1.Calculate_Result[0].Three_Section_Long_Numberb; //4;
  var_Sheet_Size_OnePNL.Three_PNLB_Width_Number:=Aarray_Rectangle_onePNL1.Calculate_Result[0].Three_Section_Width_Numberb;//1;
  var_Sheet_Size_OnePNL.Sheet_Long:=Aarray_Rectangle_onePNL1.Calculate_Result[0].Sheet_Long;//  1220;
  var_Sheet_Size_OnePNL.Sheet_Width:=Aarray_Rectangle_onePNL1.Calculate_Result[0].Sheet_Width;//  1040;
  var_Sheet_Size_OnePNL.One_Section_Array_type:=Aarray_Rectangle_onePNL1.Calculate_Result[0].One_Section_Array_type;
  var_Sheet_Size_OnePNL.Three_Section_Array_type:=Aarray_Rectangle_onePNL1.Calculate_Result[0].Three_Section_Array_type;
  var_Sheet_Size_OnePNL.Draw_type:=Aarray_Rectangle_onePNL1.Calculate_Result[0].Draw_type;

  Draw_Picture1.Sheet_Size_OnePNL:=var_Sheet_Size_OnePNL;//���������,���ڻ�����ͼ
  Image3.Canvas.Rectangle(0,0,Image3.Width,Image3.Height);//�������
  Draw_Picture1.Draw_Sheet_onePNL_Picture(image3.Canvas ,image3.Width ,image3.Height);

   //Aarray_Rectangle_OnePNL1.Calculate_Result[0].One_Section_Long_Number

   //showmessage(currtostr(Aarray_Rectangle_OnePNL1.Calculate_Result[0].Unit_Using_Rate));
   //showmessage(inttostr(Aarray_Rectangle_OnePNL1.Calculate_Result[0].One_Section_Long_Number)+'*'+inttostr(Aarray_Rectangle_OnePNL1.Calculate_Result[0].One_Section_Width_Number));
   //showmessage(inttostr(Aarray_Rectangle_OnePNL1.Calculate_Result[0].One_Section_Long_NumberA)+'*'+inttostr(Aarray_Rectangle_OnePNL1.Calculate_Result[0].One_Section_Width_NumberA));
   //showmessage(inttostr(Aarray_Rectangle_OnePNL1.Calculate_Result[0].Three_Section_Long_NumberA)+'*'+inttostr(Aarray_Rectangle_OnePNL1.Calculate_Result[0].Three_Section_Width_NumberA));
          //  Aarray_Rectangle_OnePNL1.Calculate_Result[0].One_Section_LongA

  // Label50.Caption:='��:'+currtostr(Aarray_Rectangle_onePNL1.Calculate_Result[0].One_Section_Long)+'x'+
  // inttostr(Aarray_Rectangle_onePNL1.Calculate_Result[0].One_Section_Long_Number)+
  // '��:'+currtostr(Aarray_Rectangle_onePNL1.Calculate_Result[0].One_Section_Width)+'x'
  // +inttostr(Aarray_Rectangle_onePNL1.Calculate_Result[0].One_Section_Width_Number)+'  '+chr(13)+chr(10);

  // Label50.Caption:=Label50.Caption+ '������:'+currtostr(Aarray_Rectangle_onePNL1.Calculate_Result[0].One_Section_Longa)+'x'
  //   +  inttostr(Aarray_Rectangle_onePNL1.Calculate_Result[0].One_Section_Long_Numbera)+
  //    '��:'+currtostr(Aarray_Rectangle_onePNL1.Calculate_Result[0].One_Section_Widtha)+'x'
  //   +  inttostr(Aarray_Rectangle_onePNL1.Calculate_Result[0].One_Section_Width_Numbera);
  // Label50.Caption:=Label50.Caption+ '������:'+currtostr(Aarray_Rectangle_onePNL1.Calculate_Result[0].One_Section_Longb)+'x'
  //   +  inttostr(Aarray_Rectangle_onePNL1.Calculate_Result[0].One_Section_Long_Numberb)+
  //    '��:'+currtostr(Aarray_Rectangle_onePNL1.Calculate_Result[0].One_Section_Widthb)+'x'
  //   +  inttostr(Aarray_Rectangle_onePNL1.Calculate_Result[0].One_Section_Width_Numberb)+'      '+chr(13)+chr(10);

  // Label50.Caption:=Label50.Caption+ '������:'+currtostr(Aarray_Rectangle_onePNL1.Calculate_Result[0].three_Section_Longa)+'x'
  //     +inttostr(Aarray_Rectangle_onePNL1.Calculate_Result[0].three_Section_Long_Numbera)+
  //    '��:'+currtostr(Aarray_Rectangle_onePNL1.Calculate_Result[0].three_Section_Widtha)+'x'
  //     +   inttostr(Aarray_Rectangle_onePNL1.Calculate_Result[0].three_Section_Width_Numbera);
 // Label50.Caption:=Label50.Caption+ '������:'+currtostr(Aarray_Rectangle_onePNL1.Calculate_Result[0].three_Section_Longb)+'x'
 //      +inttostr(Aarray_Rectangle_onePNL1.Calculate_Result[0].three_Section_Long_Numberb)+
 //     '��:'+currtostr(Aarray_Rectangle_onePNL1.Calculate_Result[0].three_Section_Widthb)+'x'
 //      +   inttostr(Aarray_Rectangle_onePNL1.Calculate_Result[0].three_Section_Width_Numberb)+'  '+chr(13)+chr(10);
 //  // Aarray_Rectangle_OnePNL1.Calculate_Result[0].Draw_type
 // Label50.Caption:=Label50.Caption+'����:'+INTToSTR( Aarray_Rectangle_onePNL1.Calculate_Result[0].Draw_type)
 //      + '������:'+currtostr(Aarray_Rectangle_onePNL1.Calculate_Result[0].Using_Rate);

  Aarray_Rectangle_onePNL1.Free; //�ͷ���
  Draw_Picture1.Free; //�ͷ���
end;
ʹ�÷�������}
unit PNL_Aarray_Rectangle_OnePNL_Unit1;

interface
uses
  Messages,SysUtils,StdCtrls,Dialogs,ExtCtrls,math,Graphics,wintypes,ComCtrls;//raFunc,IdTrivialFTPBase


TYPE

   Input_Set_Size_OnePNL_1111=RECORD//�����SET��Ϣ
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

   PNL_Informat3311=record //֪��PNL����
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
   Input_PCB_SIZE_OnePNL_1=record
        Unit_Long:currency;//��Ԫ��
        Unit_Width:currency;//��Ԫ��
        Unit_Long_Space:currency;//��Ԫ�����
        Unit_Width_Space:currency;//��Ԫ����
        Unit_Long_ToPNL:currency;//��Ԫ�����߾���
        Unit_Width_ToPNL:currency;//��Ԫ���߾���

        PNLA_Long_Max:currency;//PNLA������
        PNLA_Width_Max:currency;//PNLA������
        PNLA_Long_Min:currency;//PNLA������
        PNLA_Width_Min:currency;//PNLA������

     end;
   //���ڴ��������
   Input_Sheet_Size_OnePNL_1=record
       Sheet_Long:currency;
       Sheet_Width:currency;
     end;
    //��������Ľ��
   tresult_makeup_using_Sheet_OnePNL_1=record
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
   //��ʱ���PNL���,���ڴ�ź����ķ���ֵ
    TResult_OnePNL_Information_1=record
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
   TAarray_Rectangle_OnePNL1= CLASS(Tobject)
   private
       { Private declarations }
       unit_to_set_pnl_sheet1:integer;//���ڼ����Ƿ���Ҫ����ӵ�Ԫ��SET����PNL����ſ���ͼ,1ʱ��
       PNL_Informat33:PNL_Informat3311;//���ڴ�֪��PNL���ݵı���

       Input_Set_Size_OnePNL_1:Input_Set_Size_OnePNL_1111;//���ڴ�SET����,���,�߾�,����������
       //����Ԫ��������� Ĭ��Ϊ������
       Echange_Unit_To_Unit_Space1:boolean ;
       //����Ԫ�߾���� Ĭ��Ϊ������
       Echange_Unit_To_PNL_Space1:boolean;
        //tsa:string;
      //ʣ�¿�������,=2ֻ����������=3����������
      Leave_Section_falchion_number1:integer;//ʣ�¿�������,=2ֻ����������=3����������
      //��������
      Summation_rate:real;//��������
      Tem_Calculate_Rate_Type1:Integer;//���������ʵķ���,1�õ�Ԫ�ߴ����,��Ԫ�ߴ���Ե�Ԫ�����ٳ��Դ��ϳߴ�;2��PNL�ߴ����,PNL�ߴ����PNL�ܸ����ٳ��Դ��ϳߴ�

       //�������Ĵ�������
       Input_Sheet_Size_OnePNL:array[0..50] of Input_Sheet_Size_OnePNL_1;  //�������Ĵ�������
       //�������ĳߴ�,Ϊ��¼��,��Ԫ��,��,���,�߿�,������
       Input_PCB_SIZE_OnePNL:Input_PCB_SIZE_OnePNL_1;//�������ĳߴ�,Ϊ��¼��,��Ԫ��,��,���,�߿�,������
       //��ż����Ľ��ֵ
       Result_makeup_using_Sheet_OnePNL:ARRAY[0..20] OF tresult_makeup_using_Sheet_OnePNL_1; //��ż����Ľ��ֵ

       Tem_TProgressBar1:TProgressBar;//���ڴ��TProgressBar�ؼ�,Ҫ��ʾ�Ľ�����
       //
       Tem_Calculate_Array_Complete_Time_Display:boolean;//�Ƿ���ʾ������Ҫ��ʱ��
       Falchion_Number1:INTEGER;//��������
       Calculate_Falchion_Number_Equality_Hold_1:boolean;//���ڶ����Ƿ�����ȵĿ�������
       Calculate_Flag1:integer;//�Ƿ�������,���ɷ�����ų�һ����һ�������Ű�
       //��������PNL�����Ӧ��ϵ
       Change_PNL_Long_Width1:boolean;
       //�����㵶��
       No_Calculate_Falchion_Number1:boolean;
     function Calculate_Unit_To_Set(const Value_Input_Set_Size_OnePNL_1:Input_Set_Size_OnePNL_1111;VAR Value_Input_PCB_SIZE_OnePNL_1:Input_PCB_SIZE_OnePNL_1):boolean;//�ӵ�Ԫ��SET
     function PNL_To_SHEET_999():Boolean;//����PNL�ſ���ͼ,PNLһ��,�����ڿ�����

     //��������PNLA�ĳߴ�ٸ�Ϊ��һ���ĳ�����ȵ�����
     function Echange_Two_And_Three_Section_Data(var value1:ARRAY OF tresult_makeup_using_Sheet_OnePNL_1):boolean;

     //�ӵ�Ԫ��PNL,���뵥Ԫ�ߴ�����,����Χ
     function Calculate_Unit_OnePNL(CONST VALUE:Input_PCB_SIZE_OnePNL_1):BOOLEAN; //�ӵ�Ԫ��PNL


      //��PNL��SHEET,�����źõ�PNL����,Calculate_OnePNL_Sheet_1�е���Calculate_OnePNL_Sheet_2
      function Calculate_OnePNL_Sheet_1(const value2:TResult_OnePNL_Information_1;const value22:Input_Sheet_Size_OnePNL_1):boolean;//��PNL��SHEET
      function Calculate_OnePNL_Sheet_2(const value332,One_Section_PNLvalue33,Three_Section_PNLvalue33:TResult_OnePNL_Information_1;const value333_sheet,Two_Section_value333,Three_Section_value333:Input_Sheet_Size_OnePNL_1;pnl_long_number3331,pnl_width_number3331,type333,Two_Section_Draw_value333,Three_Section_Draw_value333:integer):boolean;//��PNL��SHEET

      //����ת������
      function Calculate_OnePNL_result_exchange():boolean;



      //���ڷ��ؼ���Ľ������
    function Get_Calculate_Result_Number: integer;

    function Get_Input_PCB_SIZE_OnePNL_1: Input_PCB_SIZE_OnePNL_1;

    function Get_Input_Sheet_Size_OnePNL_1(Index: integer): Input_Sheet_Size_OnePNL_1;

    procedure Set_Input_PCB_SIZE_OnePNL_1(const Value: Input_PCB_SIZE_OnePNL_1);

    procedure Set_Input_Sheet_Size_OnePNL_1(Index: integer;const Value: Input_Sheet_Size_OnePNL_1);

    procedure Set_tresult_makeup_using_Sheet_OnePNL_1(index: integer;const Value: tresult_makeup_using_Sheet_OnePNL_1);
    function Get_tresult_makeup_using_Sheet_OnePNL_1(index: integer): tresult_makeup_using_Sheet_OnePNL_1;
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
    function Get_PNL_Informat3311: PNL_Informat3311;
    procedure Set_PNL_Informat3311(const Value: PNL_Informat3311);
    function Get_Input_Set_Size_OnePNL_1111: Input_Set_Size_OnePNL_1111;
    procedure Set_Input_Set_Size_OnePNL_1111(const Value: Input_Set_Size_OnePNL_1111);
    function Get_Change_PNL_Long_Width: boolean;
    procedure Set_Change_PNL_Long_Width(const Value: boolean);
    function Get_No_Calculate_Falchion_Number: boolean;
    procedure Set_No_Calculate_Falchion_Number(const Value: boolean);
  //  procedure Calculate_PnlToSheet_Array;


   public
      { Public declarations }
      //�ź�PNL��SHEET,��PNL�Ŵ���ͼ
      procedure Calculate_SetToPnlToSheet_Array();//�ӵ�Ԫ��SET����PNL�����SHEET

      procedure Calculate_PnlToSheet_Array();//�ź�PNL��SHEET,��PNL�Ŵ���ͼ

      //����,���ú���Calculate_Unit_OnePNL
      procedure Calculate_Array();
       //ʣ�µ���������ּ�����,2:������;3:������,
       property Leave_Section_falchion_number:integer read Get_Leave_Section_falchion_number write Set_Leave_Section_falchion_number1;
       //���ϳߴ�����,���50,��0��ʼ
       property  Input_Sheet_Size[Index:integer]:Input_Sheet_Size_OnePNL_1 Read Get_Input_Sheet_Size_OnePNL_1 Write Set_Input_Sheet_Size_OnePNL_1;
       //�������ĳߴ�,Ϊ��¼��,��Ԫ��,��,���,�߿�,������
       property Input_PCB_SIZE:Input_PCB_SIZE_OnePNL_1 read Get_Input_PCB_SIZE_OnePNL_1 WRITE Set_Input_PCB_SIZE_OnePNL_1;
       //���ڷ��ؼ�����
       property Calculate_Result[index:integer]:tresult_makeup_using_Sheet_OnePNL_1 Read Get_tresult_makeup_using_Sheet_OnePNL_1 Write Set_tresult_makeup_using_Sheet_OnePNL_1;
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
       //�õ�PNL������
       property   PNL_Informat:PNL_Informat3311 read Get_PNL_Informat3311 WRITE Set_PNL_Informat3311;
       //�õ�SET��Ҫ��
       property Input_Set_Size_OnePNL:Input_Set_Size_OnePNL_1111 Read Get_Input_Set_Size_OnePNL_1111 write Set_Input_Set_Size_OnePNL_1111;
       //�����PNL����������
       property  Change_PNL_Long_Width:boolean read  Get_Change_PNL_Long_Width write Set_Change_PNL_Long_Width;
       //�����㵶��
       property    No_Calculate_Falchion_Number:boolean  read Get_No_Calculate_Falchion_Number write Set_No_Calculate_Falchion_Number;

   end;
var
  Aarray_Rectangle_OnePNL1:TAarray_Rectangle_OnePNL1;
implementation

{ TAarray_Rectangle_OnePNL1 }




procedure TAarray_Rectangle_OnePNL1.Calculate_Array;//�����Ű�,����
var
  function_resule1:boolean;
  tem_Input_PCB_SIZE_OnePNL:Input_PCB_SIZE_OnePNL_1;
  tem_timeTime1,tem_timeTime2,tem_timeTime3: TDateTime;
  TProgressBar1_Position1,tem1:integer;
begin
   //��ʹ������
   tem_timeTime1:=Time;
   Summation_rate:=0; //����������,��ʹ��Ϊ0
   Falchion_Number1:=100;//��������
   Tem_TProgressBar1.Min:=0;
   Tem_TProgressBar1.max:=100;
   TProgressBar1_Position1:=2;
   if Change_PNL_Long_Width1=false then
   begin
     TProgressBar1_Position1:=1;
   end;
   Calculate_Flag1:=0;
   if Echange_Unit_To_Unit_Space1 then
   begin
      if Change_PNL_Long_Width1=false then
      begin
        TProgressBar1_Position1:=1+TProgressBar1_Position1;
      end
      else
        TProgressBar1_Position1:=2+TProgressBar1_Position1;

   end;
   if Echange_Unit_To_PNL_Space1 then
   begin
      if Change_PNL_Long_Width1=false then
      begin
        TProgressBar1_Position1:=1+TProgressBar1_Position1;
      end
      else
      TProgressBar1_Position1:=2+TProgressBar1_Position1;
   end;
   if (Echange_Unit_To_PNL_Space1) and (Echange_Unit_To_Unit_Space1) then
   begin
      if Change_PNL_Long_Width1=false then
      begin
        TProgressBar1_Position1:=1+TProgressBar1_Position1;
      end
      else
      TProgressBar1_Position1:=2+TProgressBar1_Position1;
   end;
   tem1:=0;
   if Leave_Section_falchion_number1=0 then Leave_Section_falchion_number1:=2; //û�������Ű淽��ʱ,Ĭ��Ϊ:2,������ֻ������������
   //û�������Ƿ���㿪������һ��Ҫ����ʱ
   //if Calculate_Falchion_Number_Equality_Hold_1 then
   //  showmessage(booltostr(Calculate_Falchion_Number_Equality_Hold_1));
   Tem_TProgressBar1.Position:=1;
   //if Tem_Calculate_Rate_Type1=0 then Tem_Calculate_Rate_Type1:=1;//û��������������ʵķ���ʱ,Ĭ��Ϊ:1,�Ե�Ԫ����.
   tem_Input_PCB_SIZE_OnePNL:=Input_PCB_SIZE_OnePNL;
   function_resule1:=Calculate_Unit_OnePNL(tem_Input_PCB_SIZE_OnePNL);
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
     function_resule1:=Calculate_Unit_OnePNL(tem_Input_PCB_SIZE_OnePNL);
     tem1:=tem1+1;
     Tem_TProgressBar1.Position:=trunc(tem1*100/TProgressBar1_Position1);
   end;
   //����Ԫ��������� Ĭ��Ϊ������  ����Ԫ��ཻ���ٵ�������ĺ���
   if Echange_Unit_To_Unit_Space1 then
   begin
     tem_Input_PCB_SIZE_OnePNL:=Input_PCB_SIZE_OnePNL;
     tem_Input_PCB_SIZE_OnePNL.Unit_Long_Space:=Input_PCB_SIZE_OnePNL.Unit_Width_Space;
     tem_Input_PCB_SIZE_OnePNL.Unit_Width_Space:=Input_PCB_SIZE_OnePNL.Unit_Long_Space;
     function_resule1:=Calculate_Unit_OnePNL(tem_Input_PCB_SIZE_OnePNL);
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
       function_resule1:=Calculate_Unit_OnePNL(tem_Input_PCB_SIZE_OnePNL);
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
     function_resule1:=Calculate_Unit_OnePNL(tem_Input_PCB_SIZE_OnePNL);
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
       function_resule1:=Calculate_Unit_OnePNL(tem_Input_PCB_SIZE_OnePNL);
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
     function_resule1:=Calculate_Unit_OnePNL(tem_Input_PCB_SIZE_OnePNL);
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
     function_resule1:=Calculate_Unit_OnePNL(tem_Input_PCB_SIZE_OnePNL);
     tem1:=tem1+1;
     Tem_TProgressBar1.Position:=trunc(tem1*100/TProgressBar1_Position1);
     end;
   end;


   function_resule1:=Echange_Two_And_Three_Section_Data(Result_makeup_using_Sheet_OnePNL);
   //Tem_TProgressBar1.Position:=0; //�������������
   tem_timeTime3:= Time;
   tem_timeTime2:=tem_timeTime3-tem_timeTime1;
   if Calculate_Flag1=0 then
           showmessage('��Ĵ������޷�Χ!����!');


end;




procedure TAarray_Rectangle_OnePNL1.Calculate_Array_Complete_Percent_2(
  V_ProgressBar1: TProgressBar; V_ProgressBar1_Position: INTEGER);
begin
  V_ProgressBar1.Position:=V_ProgressBar1_Position;
end;

procedure TAarray_Rectangle_OnePNL1.Calculate_Array_Complete_Percent_1(
  V_ProgressBar1: TProgressBar; V_ProgressBar1_Min,
  V_ProgressBar1_MAX: INTEGER);
begin
  V_ProgressBar1.Min:=V_ProgressBar1_Min;
  V_ProgressBar1.Max:=V_ProgressBar1_MAX;
end;

function TAarray_Rectangle_OnePNL1.Calculate_OnePNL_result_exchange: boolean;//��������������
var
  ii,jj:integer;
begin
  Result:=false;//�������ؼ�
  jj:=high(Result_makeup_using_Sheet_OnePNL)-low(Result_makeup_using_Sheet_OnePNL);
  if jj>1 then
  begin
     for ii:=high(Result_makeup_using_Sheet_OnePNL) downto low(Result_makeup_using_Sheet_OnePNL)+1 do
     begin
        Result_makeup_using_Sheet_OnePNL[ii]:=Result_makeup_using_Sheet_OnePNL[ii-1];

     end;
    Result:=true;//�������ؼ�
  end;
end;

function TAarray_Rectangle_OnePNL1.Calculate_OnePNL_Sheet_1(const value2: TResult_OnePNL_Information_1;//PNLA��PNLBֵ
                      const value22:Input_Sheet_Size_OnePNL_1  //���ϳ���
                      ): boolean;
var
  i10,j10
     ,n10,n11   //���ڼ�¼�������PNL����
     :integer;
   function_result001:boolean;
   tepvalue2,tepvalue3:TResult_OnePNL_Information_1;
  tem_Sheet_Size_OnePNL2,tem_Sheet_Size_OnePNL3:Input_Sheet_Size_OnePNL_1;
begin
  Result:=false;//�������ؼ�
  if (value2.PNLA_Long<=value22.Sheet_Long) and (value2.PNLA_Width<=value22.Sheet_Width)   then //PNL�����ڴ�����,������һ������
  begin
    n10:=trunc(value22.Sheet_Long/value2.PNLA_Long);  //���ϳ���PNL������
    n11:=trunc(value22.Sheet_Width/value2.PNLA_Width);//���Ͽ���PNL�����


 //   if Summation_rate>=0.804 then
  //    showmessage('');
    for i10:=1 to n10 do   //���Ŵ��ϳ���
    //for i10:=n10 downto 1 do
    begin
      for j10:=1 to n11 do //���Ŵ��Ͽ��
    //  for j10:=n11 downto 1 do
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
           function_result001:=Calculate_OnePNL_Sheet_2(value2,tepvalue2,tepvalue3,value22,tem_Sheet_Size_OnePNL2,tem_Sheet_Size_OnePNL3,i10,j10,1,1,1);
           //�Ե���������
           tem_Sheet_Size_OnePNL2.Sheet_Long:=value22.Sheet_Width;//������
           tem_Sheet_Size_OnePNL2.Sheet_Width:= value22.Sheet_Long-i10*value2.PNLA_Long;//������
           tem_Sheet_Size_OnePNL3.Sheet_Long:=i10*value2.PNLA_Long;//������
           tem_Sheet_Size_OnePNL3.Sheet_Width:=value22.Sheet_Width-j10*value2.PNLA_Width;//������
           tepvalue2:=value2; //���ڶԵ�
           tepvalue3:=value2;
           function_result001:=Calculate_OnePNL_Sheet_2(value2,tepvalue2,tepvalue3,value22,tem_Sheet_Size_OnePNL2,tem_Sheet_Size_OnePNL3,i10,j10,1,2,1);
           //�Ե���������
           tem_Sheet_Size_OnePNL2.Sheet_Long:=value22.Sheet_Long-i10*value2.PNLA_Long;//������
           tem_Sheet_Size_OnePNL2.Sheet_Width:=value22.Sheet_Width ;//������
           tem_Sheet_Size_OnePNL3.Sheet_Long:=value22.Sheet_Width-j10*value2.PNLA_Width;//������
           tem_Sheet_Size_OnePNL3.Sheet_Width:=i10*value2.PNLA_Long;//������
           tepvalue2:=value2; //���ڶԵ�
           tepvalue3:=value2;
           function_result001:=Calculate_OnePNL_Sheet_2(value2,tepvalue2,tepvalue3,value22,tem_Sheet_Size_OnePNL2,tem_Sheet_Size_OnePNL3,i10,j10,1,1,2);
           //�Ե�����,��������
           tem_Sheet_Size_OnePNL2.Sheet_Long:=value22.Sheet_Width;//������
           tem_Sheet_Size_OnePNL2.Sheet_Width:= value22.Sheet_Long-i10*value2.PNLA_Long;//������
           tem_Sheet_Size_OnePNL3.Sheet_Long:=value22.Sheet_Width-j10*value2.PNLA_Width;//������
           tem_Sheet_Size_OnePNL3.Sheet_Width:=i10*value2.PNLA_Long;//������
           tepvalue2:=value2; //���ڶԵ�
           tepvalue3:=value2;
           function_result001:=Calculate_OnePNL_Sheet_2(value2,tepvalue2,tepvalue3,value22,tem_Sheet_Size_OnePNL2,tem_Sheet_Size_OnePNL3,i10,j10,1,2,2);



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
           function_result001:=Calculate_OnePNL_Sheet_2(value2,tepvalue2,tepvalue3,value22,tem_Sheet_Size_OnePNL2,tem_Sheet_Size_OnePNL3,i10,j10,2,1,1);
           //�Ե���������
           tem_Sheet_Size_OnePNL2.Sheet_Long:=j10*value2.PNLA_Width;//������
           tem_Sheet_Size_OnePNL2.Sheet_Width:=value22.Sheet_Long-i10*value2.PNLA_Long ;//������ value22.Sheet_Width
           tem_Sheet_Size_OnePNL3.Sheet_Long:=value22.Sheet_Long;//i10*value2.PNLA_Long;//������
           tem_Sheet_Size_OnePNL3.Sheet_Width:=value22.Sheet_Width-j10*value2.PNLA_Width;//������

           tepvalue2:=value2; //���ڶԵ�
           tepvalue3:=value2;
           function_result001:=Calculate_OnePNL_Sheet_2(value2,tepvalue2,tepvalue3,value22,tem_Sheet_Size_OnePNL2,tem_Sheet_Size_OnePNL3,i10,j10,2,2,1);
           //�Ե���������
           tem_Sheet_Size_OnePNL2.Sheet_Long:=value22.Sheet_Long-i10*value2.PNLA_Long;//������
           tem_Sheet_Size_OnePNL2.Sheet_Width:=j10*value2.PNLA_Width ;//������ value22.Sheet_Width
           tem_Sheet_Size_OnePNL3.Sheet_Long:=value22.Sheet_Width-j10*value2.PNLA_Width;//i10*value2.PNLA_Long;//������
           tem_Sheet_Size_OnePNL3.Sheet_Width:=value22.Sheet_Long;//������

           tepvalue2:=value2; //���ڶԵ�
           tepvalue3:=value2;
           function_result001:=Calculate_OnePNL_Sheet_2(value2,tepvalue2,tepvalue3,value22,tem_Sheet_Size_OnePNL2,tem_Sheet_Size_OnePNL3,i10,j10,2,1,2);
           //�Ե�����,��������
           tem_Sheet_Size_OnePNL2.Sheet_Long:=j10*value2.PNLA_Width ;//������
           tem_Sheet_Size_OnePNL2.Sheet_Width:=value22.Sheet_Long-i10*value2.PNLA_Long;//������ value22.Sheet_Width
           tem_Sheet_Size_OnePNL3.Sheet_Long:=value22.Sheet_Width-j10*value2.PNLA_Width;//i10*value2.PNLA_Long;//������
           tem_Sheet_Size_OnePNL3.Sheet_Width:=value22.Sheet_Long;//������

           tepvalue2:=value2; //���ڶԵ�
           tepvalue3:=value2;
           function_result001:=Calculate_OnePNL_Sheet_2(value2,tepvalue2,tepvalue3,value22,tem_Sheet_Size_OnePNL2,tem_Sheet_Size_OnePNL3,i10,j10,2,2,2);


//-----------------------------





       end;
    end;
    Result:=true;//�������ؼ�
  end;

end;



function TAarray_Rectangle_OnePNL1.Calculate_OnePNL_Sheet_2(
  const value332,One_Section_PNLvalue33,Three_Section_PNLvalue33: TResult_OnePNL_Information_1; //value32���һ����PNLA��Ϣ,��PNLB��Ϣ,value3��Ŷ�,������PNLA��PNLB��Ϣ
   const  value333_sheet,Two_Section_value333, Three_Section_value333: Input_Sheet_Size_OnePNL_1;  //value33_sheet���ϳ���,One_Section_value, Three_Section_value:��,��������
  pnl_long_number3331, pnl_width_number3331,type333,Two_Section_Draw_value333,Three_Section_Draw_value333: integer // pnl_long_number33һ��PNLA������,pnl_width_number33һ��PNLA�����,�ŷ�
  ): boolean;//���ú���ʱ,value3ֵ�кͳ���Ҫ�Ե�,One_Section_value����Ҫ�Ե�
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
//3333333
    { if Leave_Section_falchion_number1=3 then  //��������
     begin
       n21:=trunc(Two_Section_value333.Sheet_Long/One_Section_PNLvalue33.PNLA_Long);//��A,��󳤸���
       n22:=trunc(Two_Section_value333.Sheet_Width/One_Section_PNLvalue33.PNLA_Width);//��A,�������

       n201:=n21; //PNLA������Ϊn201*n202
       n202:=n22;
       rate200:=n201*n202*One_Section_PNLvalue33.PNLA_Unit_Long_Number*One_Section_PNLvalue33.PNLA_Unit_Width_Number;
       if Tem_Calculate_Rate_Type1=1 then  //�õ�Ԫ����
       begin
          rate200:=n201*n202*One_Section_PNLvalue33.PNLA_Unit_Long_Number
                   *One_Section_PNLvalue33.PNLA_Unit_Width_Number
                   *One_Section_PNLvalue33.PNLA_Unit_Long
                   *One_Section_PNLvalue33.PNLA_Unit_Width;
          rate200:=rate200/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
       end;
       if Tem_Calculate_Rate_Type1=2 then //��PNL����
       begin
         rate200:=n201*N202*One_Section_PNLvalue33.PNLA_Long*One_Section_PNLvalue33.PNLA_Width;//PNL��������볤��
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

             //Two_Section_value333.Sheet_long-i21*One_Section_PNLvalue33.PNLA_Long
             //Two_Section_value333.Sheet_Width-j21*One_Section_PNLvalue33.PNLA_Width
             //С����PNLA���ų���
             n221A1:=0;
             n222A1:=0;
             if (Two_Section_value333.Sheet_long-i21*One_Section_PNLvalue33.PNLA_Long>=One_Section_PNLvalue33.PNLA_Width)
               and (Two_Section_value333.Sheet_Width>=One_Section_PNLvalue33.PNLA_Long) then
               begin
                 n221A1:=trunc((Two_Section_value333.Sheet_long-i21*One_Section_PNLvalue33.PNLA_Long)/One_Section_PNLvalue33.PNLA_Width);
                 n222A1:=trunc(Two_Section_value333.Sheet_Width/One_Section_PNLvalue33.PNLA_Long);
              end;
              //С����PNLA���ų���
               n231A1:=0;
               n232A1:=0;
              if (i21*One_Section_PNLvalue33.PNLA_Long>=One_Section_PNLvalue33.PNLA_Width)
               and ((Two_Section_value333.Sheet_Width-j21*One_Section_PNLvalue33.PNLA_Width)>=One_Section_PNLvalue33.PNLA_Long) then
               begin
                 n231A1:=trunc(i21*One_Section_PNLvalue33.PNLA_Long/One_Section_PNLvalue33.PNLA_Width);
                 n232A1:=trunc((Two_Section_value333.Sheet_Width-j21*One_Section_PNLvalue33.PNLA_Width)/One_Section_PNLvalue33.PNLA_Long);
              end;
              //С����PNLA���ų���
              n233A1:=0;
              n234A1:=0;
              if (i21*One_Section_PNLvalue33.PNLA_Long>=One_Section_PNLvalue33.PNLA_Long)
               and ((Two_Section_value333.Sheet_Width-j21*One_Section_PNLvalue33.PNLA_Width)>=One_Section_PNLvalue33.PNLA_Width) then
               begin
                 n233A1:=trunc(i21*One_Section_PNLvalue33.PNLA_Long/One_Section_PNLvalue33.PNLA_Long);
                 n234A1:=trunc((Two_Section_value333.Sheet_Width-j21*One_Section_PNLvalue33.PNLA_Width)/One_Section_PNLvalue33.PNLA_Width);
              end;
              //С����PNLA���ų���
              n223A1:=0;
              n224A1:=0;
              if (Two_Section_value333.Sheet_long-i21*One_Section_PNLvalue33.PNLA_Long>=One_Section_PNLvalue33.PNLA_Long)
               and (Two_Section_value333.Sheet_Width>=One_Section_PNLvalue33.PNLA_Width) then
               begin
                 n223A1:=trunc((Two_Section_value333.Sheet_long-i21*One_Section_PNLvalue33.PNLA_Long)/One_Section_PNLvalue33.PNLA_Long);
                 n224A1:=trunc(Two_Section_value333.Sheet_Width/One_Section_PNLvalue33.PNLA_Width);
              end;


              //С����PNLB���ų���
              n221B1:=0;
              n222B1:=0;
              if (Two_Section_value333.Sheet_long-i21*One_Section_PNLvalue33.PNLA_Long>=One_Section_PNLvalue33.PNLB_Width)
               and (Two_Section_value333.Sheet_Width>=One_Section_PNLvalue33.PNLB_Long) then
               begin
                 n221B1:=trunc((Two_Section_value333.Sheet_long-i21*One_Section_PNLvalue33.PNLA_Long)/One_Section_PNLvalue33.PNLB_Width);
                 n222B1:=trunc(Two_Section_value333.Sheet_Width/One_Section_PNLvalue33.PNLB_Long);
              end;
              //С����PNLB���ų���
              n231B1:=0;
              n232B1:=0;
              if (i21*One_Section_PNLvalue33.PNLA_Long>=One_Section_PNLvalue33.PNLB_Width)
               and ((Two_Section_value333.Sheet_Width-j21*One_Section_PNLvalue33.PNLA_Width)>=One_Section_PNLvalue33.PNLB_Long) then
               begin
                 n231B1:=trunc(i21*One_Section_PNLvalue33.PNLA_Long/One_Section_PNLvalue33.PNLB_Width);
                 n232B1:=trunc((Two_Section_value333.Sheet_Width-j21*One_Section_PNLvalue33.PNLA_Width)/One_Section_PNLvalue33.PNLB_Long);
              end;

              //С����PNLB���ų���
              n233B1:=0;
              n234B1:=0;

              if (i21*One_Section_PNLvalue33.PNLA_Long>=One_Section_PNLvalue33.PNLB_Long)
               and ((Two_Section_value333.Sheet_Width-j21*One_Section_PNLvalue33.PNLA_Width)>=One_Section_PNLvalue33.PNLB_Width) then
               begin
                 n233B1:=trunc(i21*One_Section_PNLvalue33.PNLA_Long/One_Section_PNLvalue33.PNLB_Long);
                 n234B1:=trunc((Two_Section_value333.Sheet_Width-j21*One_Section_PNLvalue33.PNLA_Width)/One_Section_PNLvalue33.PNLB_Width);
              end;
              //С����PNLB���ų���
              n223B1:=0;
              n224B1:=0;
              if (Two_Section_value333.Sheet_long-i21*One_Section_PNLvalue33.PNLA_Long>=One_Section_PNLvalue33.PNLB_Long)
               and (Two_Section_value333.Sheet_Width>=One_Section_PNLvalue33.PNLB_Width) then
               begin
                 n223B1:=trunc((Two_Section_value333.Sheet_long-i21*One_Section_PNLvalue33.PNLA_Long)/One_Section_PNLvalue33.PNLB_Long);
                 n224B1:=trunc(Two_Section_value333.Sheet_Width/One_Section_PNLvalue33.PNLB_Width);
              end;
              //С��������PNLA��,С��������PNLA,��ֻһ��

               rate201:=(n221A1*N222A1+N233A1*N234a1)*One_Section_PNLvalue33.PNLA_Unit_Long_Number*One_Section_PNLvalue33.PNLA_Unit_Width_Number;
               if Tem_Calculate_Rate_Type1=1 then  //�õ�Ԫ����
               begin
                  rate201:=(n221A1*N222A1+N233A1*N234a1)*One_Section_PNLvalue33.PNLA_Unit_Long_Number*One_Section_PNLvalue33.PNLA_Unit_Width_Number
                         *One_Section_PNLvalue33.PNLA_Unit_Long*One_Section_PNLvalue33.PNLA_Unit_Width;
                  rate201:=rate201/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               end;
               if Tem_Calculate_Rate_Type1=2 then //��PNL����
               begin
                  rate201:=(n221A1*N222A1+N233A1*N234a1)
                         *One_Section_PNLvalue33.PNLA_Long *One_Section_PNLvalue33.PNLA_Width;
                  rate201:=rate201/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               END;
              //С��������PNLA��,С��������PNLA,��ֻһ��
              rate202:=(n223A1*N224A1+N231A1*N232a1)*One_Section_PNLvalue33.PNLA_Unit_Long_Number*One_Section_PNLvalue33.PNLA_Unit_Width_Number;
              if Tem_Calculate_Rate_Type1=1 then  //�õ�Ԫ����
               begin
                  rate202:=(n223A1*N224A1+N231A1*N232a1)*One_Section_PNLvalue33.PNLA_Unit_Long_Number*One_Section_PNLvalue33.PNLA_Unit_Width_Number
                         *One_Section_PNLvalue33.PNLA_Unit_Long*One_Section_PNLvalue33.PNLA_Unit_Width;
                  rate202:=rate202/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               end;
               if Tem_Calculate_Rate_Type1=2 then //��PNL����
               begin
                  rate202:=(n223A1*N224A1+N231A1*N232a1)
                         *One_Section_PNLvalue33.PNLA_Long *One_Section_PNLvalue33.PNLA_Width;
                  rate202:=rate203/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               END;
              rate203:=(n223A1*N224A1+N233A1*N234a1)*One_Section_PNLvalue33.PNLA_Unit_Long_Number*One_Section_PNLvalue33.PNLA_Unit_Width_Number;
              if Tem_Calculate_Rate_Type1=1 then  //�õ�Ԫ����
               begin
                  rate203:=(n223A1*N224A1+N233A1*N234a1)*One_Section_PNLvalue33.PNLA_Unit_Long_Number*One_Section_PNLvalue33.PNLA_Unit_Width_Number
                         *One_Section_PNLvalue33.PNLA_Unit_Long*One_Section_PNLvalue33.PNLA_Unit_Width;
                  rate203:=rate203/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               end;
               if Tem_Calculate_Rate_Type1=2 then //��PNL����
               begin
                  rate203:=(n223A1*N224A1+N233A1*N234a1)
                         *One_Section_PNLvalue33.PNLA_Long *One_Section_PNLvalue33.PNLA_Width;
                  rate203:=rate203/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               END;
               //С��������PNLA��,С��������PNLb,��ֻ����
               {
              rate204:=n221A1*N222A1*One_Section_PNLvalue33.PNLA_Unit_Long_Number*One_Section_PNLvalue33.PNLA_Unit_Width_Number
                       +N231B1*N232B1*One_Section_PNLvalue33.PNLB_Unit_Long_Number*One_Section_PNLvalue33.PNLB_Unit_Width_Number;

              if Tem_Calculate_Rate_Type1=1 then  //�õ�Ԫ����
               begin
                  rate204:=n221A1*N222A1*One_Section_PNLvalue33.PNLA_Unit_Long_Number*One_Section_PNLvalue33.PNLA_Unit_Width_Number
                                          *One_Section_PNLvalue33.PNLA_Unit_Long*One_Section_PNLvalue33.PNLA_Unit_Width
                         +N231B1*N232B1*One_Section_PNLvalue33.PNLb_Unit_Long_Number*One_Section_PNLvalue33.PNLb_Unit_Width_Number
                                        *One_Section_PNLvalue33.PNLb_Unit_Long*One_Section_PNLvalue33.PNLb_Unit_Width;
                  rate204:=rate204/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               end;
               if Tem_Calculate_Rate_Type1=2 then //��PNL����
               begin
                  rate204:=n221A1*N222A1*One_Section_PNLvalue33.PNLA_Long *One_Section_PNLvalue33.PNLA_Width
                           +N231B1*N232B1*One_Section_PNLvalue33.PNLb_Long *One_Section_PNLvalue33.PNLb_Width;
                  rate204:=rate204/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               END;

              rate205:=n221A1*N222A1*One_Section_PNLvalue33.PNLA_Unit_Long_Number*One_Section_PNLvalue33.PNLA_Unit_Width_Number
                      +N233B1*N234B1*One_Section_PNLvalue33.PNLB_Unit_Long_Number*One_Section_PNLvalue33.PNLB_Unit_Width_Number;

               if Tem_Calculate_Rate_Type1=1 then  //�õ�Ԫ����
               begin
                  rate205:=n221A1*N222A1*One_Section_PNLvalue33.PNLA_Unit_Long_Number*One_Section_PNLvalue33.PNLA_Unit_Width_Number
                                          *One_Section_PNLvalue33.PNLA_Unit_Long*One_Section_PNLvalue33.PNLA_Unit_Width
                         +N233B1*N234B1*One_Section_PNLvalue33.PNLb_Unit_Long_Number*One_Section_PNLvalue33.PNLb_Unit_Width_Number
                                        *One_Section_PNLvalue33.PNLb_Unit_Long*One_Section_PNLvalue33.PNLb_Unit_Width;
                  rate205:=rate205/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               end;
               if Tem_Calculate_Rate_Type1=2 then //��PNL����
               begin
                  rate205:=n221A1*N222A1*One_Section_PNLvalue33.PNLA_Long *One_Section_PNLvalue33.PNLA_Width
                           +N233B1*N234B1*One_Section_PNLvalue33.PNLb_Long *One_Section_PNLvalue33.PNLb_Width;
                  rate205:=rate205/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               END;
              //С��������PNLB��,С��������PNLA,��ֻ����
              rate206:=n221B1*N222B1*One_Section_PNLvalue33.PNLB_Unit_Long_Number*One_Section_PNLvalue33.PNLB_Unit_Width_NumbeR
                      +N231A1*N232A1*One_Section_PNLvalue33.PNLA_Unit_Long_Number*One_Section_PNLvalue33.PNLA_Unit_Width_Number;
               if Tem_Calculate_Rate_Type1=1 then  //�õ�Ԫ����
               begin
                  rate206:=N231A1*N232A1*One_Section_PNLvalue33.PNLA_Unit_Long_Number*One_Section_PNLvalue33.PNLA_Unit_Width_Number
                                          *One_Section_PNLvalue33.PNLA_Unit_Long*One_Section_PNLvalue33.PNLA_Unit_Width
                         +n221B1*N222B1*One_Section_PNLvalue33.PNLb_Unit_Long_Number*One_Section_PNLvalue33.PNLb_Unit_Width_Number
                                        *One_Section_PNLvalue33.PNLb_Unit_Long*One_Section_PNLvalue33.PNLb_Unit_Width;
                  rate206:=rate206/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               end;
               if Tem_Calculate_Rate_Type1=2 then //��PNL����
               begin
                  rate206:=N231A1*N232A1*One_Section_PNLvalue33.PNLA_Long *One_Section_PNLvalue33.PNLA_Width
                           +n221B1*N222B1*One_Section_PNLvalue33.PNLb_Long *One_Section_PNLvalue33.PNLb_Width;
                  rate206:=rate206/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               END;
              rate207:=n221B1*N222B1*One_Section_PNLvalue33.PNLB_Unit_Long_Number*One_Section_PNLvalue33.PNLB_Unit_Width_NumbeR
                       +N233A1*N234A1*One_Section_PNLvalue33.PNLA_Unit_Long_Number*One_Section_PNLvalue33.PNLA_Unit_Width_NumbeR;
              if Tem_Calculate_Rate_Type1=1 then  //�õ�Ԫ����
               begin
                  rate207:=N233A1*N234A1*One_Section_PNLvalue33.PNLA_Unit_Long_Number*One_Section_PNLvalue33.PNLA_Unit_Width_Number
                                          *One_Section_PNLvalue33.PNLA_Unit_Long*One_Section_PNLvalue33.PNLA_Unit_Width
                         +n221B1*N222B1*One_Section_PNLvalue33.PNLb_Unit_Long_Number*One_Section_PNLvalue33.PNLb_Unit_Width_Number
                                        *One_Section_PNLvalue33.PNLb_Unit_Long*One_Section_PNLvalue33.PNLb_Unit_Width;
                  rate207:=rate207/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               end;
               if Tem_Calculate_Rate_Type1=2 then //��PNL����
               begin
                  rate207:=N233A1*N234A1*One_Section_PNLvalue33.PNLA_Long *One_Section_PNLvalue33.PNLA_Width
                           +n221B1*N222B1*One_Section_PNLvalue33.PNLb_Long *One_Section_PNLvalue33.PNLb_Width;
                  rate207:=rate207/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               END;
              //С��������PNLB��,С��������PNLA,��ֻ����
              rate208:=n223B1*N224B1*One_Section_PNLvalue33.PNLB_Unit_Long_Number*One_Section_PNLvalue33.PNLB_Unit_Width_Number
                       +N231A1*N232A1*One_Section_PNLvalue33.PNLA_Unit_Long_Number*One_Section_PNLvalue33.PNLA_Unit_Width_NumbeR;

              if Tem_Calculate_Rate_Type1=1 then  //�õ�Ԫ����
               begin
                  rate208:=N231A1*N232A1*One_Section_PNLvalue33.PNLA_Unit_Long_Number*One_Section_PNLvalue33.PNLA_Unit_Width_Number
                                          *One_Section_PNLvalue33.PNLA_Unit_Long*One_Section_PNLvalue33.PNLA_Unit_Width
                         +n223B1*N224B1*One_Section_PNLvalue33.PNLb_Unit_Long_Number*One_Section_PNLvalue33.PNLb_Unit_Width_Number
                                        *One_Section_PNLvalue33.PNLb_Unit_Long*One_Section_PNLvalue33.PNLb_Unit_Width;
                  rate208:=rate208/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               end;
               if Tem_Calculate_Rate_Type1=2 then //��PNL����
               begin
                  rate208:=N231A1*N232A1*One_Section_PNLvalue33.PNLA_Long *One_Section_PNLvalue33.PNLA_Width
                           +n223B1*N224B1*One_Section_PNLvalue33.PNLb_Long *One_Section_PNLvalue33.PNLb_Width;
                  rate208:=rate208/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               END;


              rate209:=n223B1*N224B1*One_Section_PNLvalue33.PNLB_Unit_Long_Number*One_Section_PNLvalue33.PNLB_Unit_Width_Number
                       +N233A1*N234A1*One_Section_PNLvalue33.PNLA_Unit_Long_Number*One_Section_PNLvalue33.PNLA_Unit_Width_NumbeR;

              if Tem_Calculate_Rate_Type1=1 then  //�õ�Ԫ����
               begin
                  rate209:=N233A1*N234A1*One_Section_PNLvalue33.PNLA_Unit_Long_Number*One_Section_PNLvalue33.PNLA_Unit_Width_Number
                                          *One_Section_PNLvalue33.PNLA_Unit_Long*One_Section_PNLvalue33.PNLA_Unit_Width
                         +n223B1*N224B1*One_Section_PNLvalue33.PNLb_Unit_Long_Number*One_Section_PNLvalue33.PNLb_Unit_Width_Number
                                        *One_Section_PNLvalue33.PNLb_Unit_Long*One_Section_PNLvalue33.PNLb_Unit_Width;
                  rate209:=rate209/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               end;
               if Tem_Calculate_Rate_Type1=2 then //��PNL����
               begin
                  rate209:=N233A1*N234A1*One_Section_PNLvalue33.PNLA_Long *One_Section_PNLvalue33.PNLA_Width
                           +n223B1*N224B1*One_Section_PNLvalue33.PNLb_Long *One_Section_PNLvalue33.PNLb_Width;
                  rate209:=rate209/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               END;
              //С��������PNLB��,С��������PNLB,��ֻ����
              rate210:=(n221B1*N222B1+N231B1*N232B1)*One_Section_PNLvalue33.PNLB_Unit_Long_Number*One_Section_PNLvalue33.PNLB_Unit_Width_Number;
              if Tem_Calculate_Rate_Type1=1 then  //�õ�Ԫ����
               begin
                  rate210:=(n221B1*N222B1+N231B1*N232B1)*One_Section_PNLvalue33.PNLb_Unit_Long_Number*One_Section_PNLvalue33.PNLb_Unit_Width_Number
                         *One_Section_PNLvalue33.PNLb_Unit_Long*One_Section_PNLvalue33.PNLb_Unit_Width;
                  rate210:=rate210/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               end;
               if Tem_Calculate_Rate_Type1=2 then //��PNL����
               begin
                  rate210:=(n221B1*N222B1+N231B1*N232B1)
                         *One_Section_PNLvalue33.PNLb_Long *One_Section_PNLvalue33.PNLb_Width;
                  rate210:=rate210/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               END;
              rate211:=(n221B1*N222B1+N233B1*N234B1)*One_Section_PNLvalue33.PNLB_Unit_Long_Number*One_Section_PNLvalue33.PNLB_Unit_Width_Number;
              if Tem_Calculate_Rate_Type1=1 then  //�õ�Ԫ����
               begin
                  rate211:=(n221B1*N222B1+N233B1*N234B1)*One_Section_PNLvalue33.PNLb_Unit_Long_Number*One_Section_PNLvalue33.PNLb_Unit_Width_Number
                         *One_Section_PNLvalue33.PNLb_Unit_Long*One_Section_PNLvalue33.PNLb_Unit_Width;
                  rate211:=rate211/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               end;
               if Tem_Calculate_Rate_Type1=2 then //��PNL����
               begin
                  rate211:=(n221B1*N222B1+N233B1*N234B1)
                         *One_Section_PNLvalue33.PNLb_Long *One_Section_PNLvalue33.PNLb_Width;
                  rate211:=rate211/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               END;
              //С��������PNLB��,С��������PNLB,��ֻ����
              rate212:=(n223B1*N224B1+N231B1*N232B1)*One_Section_PNLvalue33.PNLB_Unit_Long_Number*One_Section_PNLvalue33.PNLB_Unit_Width_Number;
              if Tem_Calculate_Rate_Type1=1 then  //�õ�Ԫ����
               begin
                  rate212:=(n223B1*N224B1+N231B1*N232B1)*One_Section_PNLvalue33.PNLb_Unit_Long_Number*One_Section_PNLvalue33.PNLb_Unit_Width_Number
                         *One_Section_PNLvalue33.PNLb_Unit_Long*One_Section_PNLvalue33.PNLb_Unit_Width;
                  rate212:=rate212/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               end;
               if Tem_Calculate_Rate_Type1=2 then //��PNL����
               begin
                  rate212:=(n223B1*N224B1+N231B1*N232B1)
                         *One_Section_PNLvalue33.PNLb_Long *One_Section_PNLvalue33.PNLb_Width;
                  rate212:=rate212/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               END;

              rate213:=(n223B1*N224B1+N233B1*N234B1)*One_Section_PNLvalue33.PNLB_Unit_Long_Number*One_Section_PNLvalue33.PNLB_Unit_Width_Number;

              if Tem_Calculate_Rate_Type1=1 then  //�õ�Ԫ����
               begin
                  rate213:=(n223B1*N224B1+N233B1*N234B1)*One_Section_PNLvalue33.PNLb_Unit_Long_Number*One_Section_PNLvalue33.PNLb_Unit_Width_Number
                         *One_Section_PNLvalue33.PNLb_Unit_Long*One_Section_PNLvalue33.PNLb_Unit_Width;
                  rate213:=rate213/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               end;
               if Tem_Calculate_Rate_Type1=2 then //��PNL����
               begin
                  rate213:=(n223B1*N224B1+N233B1*N234B1)
                         *One_Section_PNLvalue33.PNLb_Long *One_Section_PNLvalue33.PNLb_Width;
                  rate213:=rate213/value333_sheet.Shet_Long/value333_sheet.Sheet_Width;
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
             if (Two_Section_value333.Sheet_long-i21*One_Section_PNLvalue33.PNLA_Long>=One_Section_PNLvalue33.PNLA_Width)
               and (J21*One_Section_PNLvalue33.PNLA_Width>=One_Section_PNLvalue33.PNLA_Long) then
               begin
                 n221A2:=trunc((Two_Section_value333.Sheet_long-i21*One_Section_PNLvalue33.PNLA_Long)/One_Section_PNLvalue33.PNLA_Width);
                 n222A2:=trunc(J21*One_Section_PNLvalue33.PNLA_Width/One_Section_PNLvalue33.PNLA_Long);
              end;
              //С����PNLA���ų���  i21*One_Section_PNLvalue33.PNLA_Long
              n231A2:=0;
              n232A2:=0;
              if (Two_Section_value333.Sheet_long>=One_Section_PNLvalue33.PNLA_Width)
               and ((Two_Section_value333.Sheet_Width-j21*One_Section_PNLvalue33.PNLA_Width)>=One_Section_PNLvalue33.PNLA_Long) then
               begin
                 n231A2:=trunc(Two_Section_value333.Sheet_long/One_Section_PNLvalue33.PNLA_Width);
                 n232A2:=trunc((Two_Section_value333.Sheet_Width-j21*One_Section_PNLvalue33.PNLA_Width)/One_Section_PNLvalue33.PNLA_Long);
              end;
              //С����PNLA���ų���
              n233A2:=0;
              n234A2:=0;
              if (Two_Section_value333.Sheet_long>=One_Section_PNLvalue33.PNLA_Long)
               and ((Two_Section_value333.Sheet_Width-j21*One_Section_PNLvalue33.PNLA_Width)>=One_Section_PNLvalue33.PNLA_Width) then
               begin
                 n233A2:=trunc(Two_Section_value333.Sheet_long/One_Section_PNLvalue33.PNLA_Long);
                 n234A2:=trunc((Two_Section_value333.Sheet_Width-j21*One_Section_PNLvalue33.PNLA_Width)/One_Section_PNLvalue33.PNLA_Width);
              end;
              //С����PNLA���ų���
              n223A2:=0;
              n224A2:=0;
              if (Two_Section_value333.Sheet_long-i21*One_Section_PNLvalue33.PNLA_Long>=One_Section_PNLvalue33.PNLA_Long)
               and (J21*One_Section_PNLvalue33.PNLA_Width>=One_Section_PNLvalue33.PNLA_Width) then
               begin
                 n223A2:=trunc((Two_Section_value333.Sheet_long-i21*One_Section_PNLvalue33.PNLA_Long)/One_Section_PNLvalue33.PNLA_Long);
                 n224A2:=trunc(J21*One_Section_PNLvalue33.PNLA_Width/One_Section_PNLvalue33.PNLA_Width);
              end;

              {
              //С����PNLB���ų���



              rate221:=(n221A2*N222A2+N233A2*N234a2)*One_Section_PNLvalue33.PNLA_Unit_Long_Number*One_Section_PNLvalue33.PNLA_Unit_Width_Number;
              if Tem_Calculate_Rate_Type1=1 then  //�õ�Ԫ����
               begin
                  rate221:=(n221A2*N222A2+N233A2*N234a2)*One_Section_PNLvalue33.PNLA_Unit_Long_Number*One_Section_PNLvalue33.PNLA_Unit_Width_Number
                                          *One_Section_PNLvalue33.PNLA_Unit_Long*One_Section_PNLvalue33.PNLA_Unit_Width ;
                  rate221:=rate221/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               end;
               if Tem_Calculate_Rate_Type1=2 then //��PNL����
               begin
                  rate221:=(n221A2*N222A2+N233A2*N234a2)*One_Section_PNLvalue33.PNLA_Long *One_Section_PNLvalue33.PNLA_Width;
                  rate221:=rate221/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               END;
                //С��������PNLA��,С��������PNLA,��������
              rate222:=(n223A2*N224A2+N231A2*N232a2)*One_Section_PNLvalue33.PNLA_Unit_Long_Number*One_Section_PNLvalue33.PNLA_Unit_Width_Number;
              if Tem_Calculate_Rate_Type1=1 then  //�õ�Ԫ����
               begin
                  rate222:=(n223A2*N224A2+N231A2*N232a2)*One_Section_PNLvalue33.PNLA_Unit_Long_Number*One_Section_PNLvalue33.PNLA_Unit_Width_Number
                                          *One_Section_PNLvalue33.PNLA_Unit_Long*One_Section_PNLvalue33.PNLA_Unit_Width;
                  rate222:=rate222/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               end;
               if Tem_Calculate_Rate_Type1=2 then //��PNL����
               begin
                  rate222:=(n223A2*N224A2+N231A2*N232a2)*One_Section_PNLvalue33.PNLA_Long *One_Section_PNLvalue33.PNLA_Width ;
                  rate222:=rate222/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               END;
              rate223:=(n223A2*N224A2+N233A2*N234a2)*One_Section_PNLvalue33.PNLA_Unit_Long_Number*One_Section_PNLvalue33.PNLA_Unit_Width_Number;
              if Tem_Calculate_Rate_Type1=1 then  //�õ�Ԫ����
               begin
                  rate223:=(n223A2*N224A2+N233A2*N234a2)*One_Section_PNLvalue33.PNLA_Unit_Long_Number*One_Section_PNLvalue33.PNLA_Unit_Width_Number
                                          *One_Section_PNLvalue33.PNLA_Unit_Long*One_Section_PNLvalue33.PNLA_Unit_Width ;
                  rate223:=rate223/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               end;
               if Tem_Calculate_Rate_Type1=2 then //��PNL����
               begin
                  rate223:=(n223A2*N224A2+N233A2*N234a2)*One_Section_PNLvalue33.PNLA_Long *One_Section_PNLvalue33.PNLA_Width;
                  rate223:=rate223/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               END;




               //С��������PNLA��,С��������PNLb,��ֻ����
              rate224:=n221A2*N222A2*One_Section_PNLvalue33.PNLA_Unit_Long_Number*One_Section_PNLvalue33.PNLA_Unit_Width_Number
                     +N231B2*N232B2*One_Section_PNLvalue33.PNLb_Unit_Long_Number*One_Section_PNLvalue33.PNLb_Unit_Width_Number;
               if Tem_Calculate_Rate_Type1=1 then  //�õ�Ԫ����
               begin
                  rate224:=n221A2*N222A2*One_Section_PNLvalue33.PNLA_Unit_Long_Number*One_Section_PNLvalue33.PNLA_Unit_Width_Number
                                          *One_Section_PNLvalue33.PNLA_Unit_Long*One_Section_PNLvalue33.PNLA_Unit_Width
                         +N231B2*N232B2*One_Section_PNLvalue33.PNLb_Unit_Long_Number*One_Section_PNLvalue33.PNLb_Unit_Width_Number
                                        *One_Section_PNLvalue33.PNLb_Unit_Long*One_Section_PNLvalue33.PNLb_Unit_Width;
                  rate224:=rate224/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               end;
               if Tem_Calculate_Rate_Type1=2 then //��PNL����
               begin
                  rate224:=n221A2*N222A2*One_Section_PNLvalue33.PNLA_Long *One_Section_PNLvalue33.PNLA_Width
                           +N231B2*N232B2*One_Section_PNLvalue33.PNLb_Long *One_Section_PNLvalue33.PNLb_Width;
                  rate224:=rate224/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               END;

              rate225:=n221A2*N222A2*One_Section_PNLvalue33.PNLA_Unit_Long_Number*One_Section_PNLvalue33.PNLA_Unit_Width_Number
                     +N233B2*N234B2*One_Section_PNLvalue33.PNLb_Unit_Long_Number*One_Section_PNLvalue33.PNLb_Unit_Width_Number;
              if Tem_Calculate_Rate_Type1=1 then  //�õ�Ԫ����
               begin
                  rate225:=n221A2*N222A2*One_Section_PNLvalue33.PNLA_Unit_Long_Number*One_Section_PNLvalue33.PNLA_Unit_Width_Number
                                          *One_Section_PNLvalue33.PNLA_Unit_Long*One_Section_PNLvalue33.PNLA_Unit_Width
                         +N233B2*N234B2*One_Section_PNLvalue33.PNLb_Unit_Long_Number*One_Section_PNLvalue33.PNLb_Unit_Width_Number
                                        *One_Section_PNLvalue33.PNLb_Unit_Long*One_Section_PNLvalue33.PNLb_Unit_Width;
                  rate225:=rate225/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               end;
               if Tem_Calculate_Rate_Type1=2 then //��PNL����
               begin
                  rate225:=n221A2*N222A2*One_Section_PNLvalue33.PNLA_Long *One_Section_PNLvalue33.PNLA_Width
                           +N233B2*N234B2*One_Section_PNLvalue33.PNLb_Long *One_Section_PNLvalue33.PNLb_Width;
                  rate225:=rate225/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               END;




              //С��������PNLB��,С��������PNLA,��ֻ����
              rate226:=n221B2*N222B2*One_Section_PNLvalue33.PNLb_Unit_Long_Number*One_Section_PNLvalue33.PNLb_Unit_Width_Number
                       +N231A2*N232A2*One_Section_PNLvalue33.PNLA_Unit_Long_Number*One_Section_PNLvalue33.PNLA_Unit_Width_Number;
               if Tem_Calculate_Rate_Type1=1 then  //�õ�Ԫ����
               begin
                  rate226:=N231A2*N232A2*One_Section_PNLvalue33.PNLA_Unit_Long_Number*One_Section_PNLvalue33.PNLA_Unit_Width_Number
                                          *One_Section_PNLvalue33.PNLA_Unit_Long*One_Section_PNLvalue33.PNLA_Unit_Width
                         +n221B2*N222B2*One_Section_PNLvalue33.PNLb_Unit_Long_Number*One_Section_PNLvalue33.PNLb_Unit_Width_Number
                                        *One_Section_PNLvalue33.PNLb_Unit_Long*One_Section_PNLvalue33.PNLb_Unit_Width;
                  rate226:=rate226/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               end;
               if Tem_Calculate_Rate_Type1=2 then //��PNL����
               begin
                  rate226:=N231A2*N232A2*One_Section_PNLvalue33.PNLA_Long *One_Section_PNLvalue33.PNLA_Width
                           +n221B2*N222B2*One_Section_PNLvalue33.PNLb_Long *One_Section_PNLvalue33.PNLb_Width;
                  rate226:=rate226/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               END;

              rate227:=n221B2*N222B2*One_Section_PNLvalue33.PNLb_Unit_Long_Number*One_Section_PNLvalue33.PNLb_Unit_Width_Number
                       +N233A2*N234A2*One_Section_PNLvalue33.PNLA_Unit_Long_Number*One_Section_PNLvalue33.PNLA_Unit_Width_Number;
              if Tem_Calculate_Rate_Type1=1 then  //�õ�Ԫ����
               begin
                  rate227:=N233A2*N234A2*One_Section_PNLvalue33.PNLA_Unit_Long_Number*One_Section_PNLvalue33.PNLA_Unit_Width_Number
                                          *One_Section_PNLvalue33.PNLA_Unit_Long*One_Section_PNLvalue33.PNLA_Unit_Width
                         +n221B2*N222B2*One_Section_PNLvalue33.PNLb_Unit_Long_Number*One_Section_PNLvalue33.PNLb_Unit_Width_Number
                                        *One_Section_PNLvalue33.PNLb_Unit_Long*One_Section_PNLvalue33.PNLb_Unit_Width;
                  rate227:=rate227/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               end;
               if Tem_Calculate_Rate_Type1=2 then //��PNL����
               begin
                  rate227:=N233A2*N234A2*One_Section_PNLvalue33.PNLA_Long *One_Section_PNLvalue33.PNLA_Width
                           +n221B2*N222B2*One_Section_PNLvalue33.PNLb_Long *One_Section_PNLvalue33.PNLb_Width;
                  rate227:=rate227/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               END;

              //С��������PNLB��,С��������PNLA,��ֻ����
              rate228:=n223B2*N224B2*One_Section_PNLvalue33.PNLb_Unit_Long_Number*One_Section_PNLvalue33.PNLb_Unit_Width_Number
                       +N231A2*N232A2*One_Section_PNLvalue33.PNLA_Unit_Long_Number*One_Section_PNLvalue33.PNLA_Unit_Width_Number;
              if Tem_Calculate_Rate_Type1=1 then  //�õ�Ԫ����
               begin
                  rate228:=N231A2*N232A2*One_Section_PNLvalue33.PNLA_Unit_Long_Number*One_Section_PNLvalue33.PNLA_Unit_Width_Number
                                          *One_Section_PNLvalue33.PNLA_Unit_Long*One_Section_PNLvalue33.PNLA_Unit_Width
                         +n223B2*N224B2*One_Section_PNLvalue33.PNLb_Unit_Long_Number*One_Section_PNLvalue33.PNLb_Unit_Width_Number
                                        *One_Section_PNLvalue33.PNLb_Unit_Long*One_Section_PNLvalue33.PNLb_Unit_Width;
                  rate228:=rate228/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               end;
               if Tem_Calculate_Rate_Type1=2 then //��PNL����
               begin
                  rate228:=N231A2*N232A2*One_Section_PNLvalue33.PNLA_Long *One_Section_PNLvalue33.PNLA_Width
                           +n223B2*N224B2*One_Section_PNLvalue33.PNLb_Long *One_Section_PNLvalue33.PNLb_Width;
                  rate228:=rate228/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               END;

              rate229:=n223B2*N224B2*One_Section_PNLvalue33.PNLb_Unit_Long_Number*One_Section_PNLvalue33.PNLb_Unit_Width_Number
                       +N233A2*N234A2*One_Section_PNLvalue33.PNLA_Unit_Long_Number*One_Section_PNLvalue33.PNLA_Unit_Width_Number;
              if Tem_Calculate_Rate_Type1=1 then  //�õ�Ԫ����
               begin
                  rate229:=N233A2*N234A2*One_Section_PNLvalue33.PNLA_Unit_Long_Number*One_Section_PNLvalue33.PNLA_Unit_Width_Number
                                          *One_Section_PNLvalue33.PNLA_Unit_Long*One_Section_PNLvalue33.PNLA_Unit_Width
                         +n223B2*N224B2*One_Section_PNLvalue33.PNLb_Unit_Long_Number*One_Section_PNLvalue33.PNLb_Unit_Width_Number
                                        *One_Section_PNLvalue33.PNLb_Unit_Long*One_Section_PNLvalue33.PNLb_Unit_Width;
                  rate229:=rate229/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               end;
               if Tem_Calculate_Rate_Type1=2 then //��PNL����
               begin
                  rate229:=N233A2*N234A2*One_Section_PNLvalue33.PNLA_Long *One_Section_PNLvalue33.PNLA_Width
                           +n223B2*N224B2*One_Section_PNLvalue33.PNLb_Long *One_Section_PNLvalue33.PNLb_Width;
                  rate229:=rate229/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               END;

              //С��������PNLB��,С��������PNLB,��ֻ����
              rate230:=(n221B2*N222B2+N231B2*N232B2)*One_Section_PNLvalue33.PNLB_Unit_Long_Number*One_Section_PNLvalue33.PNLB_Unit_Width_Number;
              if Tem_Calculate_Rate_Type1=1 then  //�õ�Ԫ����
               begin
                  rate230:=(n221B2*N222B2+N231B2*N232B2)*One_Section_PNLvalue33.PNLb_Unit_Long_Number*One_Section_PNLvalue33.PNLb_Unit_Width_Number
                                        *One_Section_PNLvalue33.PNLb_Unit_Long*One_Section_PNLvalue33.PNLb_Unit_Width;
                  rate230:=rate230/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               end;
               if Tem_Calculate_Rate_Type1=2 then //��PNL����
               begin
                  rate230:=(n221B2*N222B2+N231B2*N232B2)*One_Section_PNLvalue33.PNLb_Long *One_Section_PNLvalue33.PNLb_Width;
                  rate230:=rate230/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               END;

              rate231:=(n221B2*N222B2+N233B2*N234B2)*One_Section_PNLvalue33.PNLB_Unit_Long_Number*One_Section_PNLvalue33.PNLB_Unit_Width_Number;
              if Tem_Calculate_Rate_Type1=1 then  //�õ�Ԫ����
               begin
                  rate231:=(n221B2*N222B2+N233B2*N234B2)*One_Section_PNLvalue33.PNLb_Unit_Long_Number*One_Section_PNLvalue33.PNLb_Unit_Width_Number
                                        *One_Section_PNLvalue33.PNLb_Unit_Long*One_Section_PNLvalue33.PNLb_Unit_Width;
                  rate231:=rate231/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               end;
               if Tem_Calculate_Rate_Type1=2 then //��PNL����
               begin
                  rate231:=(n221B2*N222B2+N233B2*N234B2)*One_Section_PNLvalue33.PNLb_Long *One_Section_PNLvalue33.PNLb_Width;
                  rate231:=rate231/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               END;

              //С��������PNLB��,С��������PNLB,��ֻ����
              rate232:=(n223B2*N224B2+N231B2*N232B2)*One_Section_PNLvalue33.PNLB_Unit_Long_Number*One_Section_PNLvalue33.PNLB_Unit_Width_Number;
              if Tem_Calculate_Rate_Type1=1 then  //�õ�Ԫ����
               begin
                  rate232:=(n223B2*N224B2+N231B2*N232B2)*One_Section_PNLvalue33.PNLb_Unit_Long_Number*One_Section_PNLvalue33.PNLb_Unit_Width_Number
                                        *One_Section_PNLvalue33.PNLb_Unit_Long*One_Section_PNLvalue33.PNLb_Unit_Width;
                  rate232:=rate232/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               end;
               if Tem_Calculate_Rate_Type1=2 then //��PNL����
               begin
                  rate223:=(n223B2*N224B2+N231B2*N232B2)*One_Section_PNLvalue33.PNLb_Long *One_Section_PNLvalue33.PNLb_Width;
                  rate232:=rate232/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               END;

              rate233:=(n223B2*N224B2+N233B2*N234B2)*One_Section_PNLvalue33.PNLB_Unit_Long_Number*One_Section_PNLvalue33.PNLB_Unit_Width_Number;
              if Tem_Calculate_Rate_Type1=1 then  //�õ�Ԫ����
               begin
                  rate233:=(n223B2*N224B2+N233B2*N234B2)*One_Section_PNLvalue33.PNLb_Unit_Long_Number*One_Section_PNLvalue33.PNLb_Unit_Width_Number
                                        *One_Section_PNLvalue33.PNLb_Unit_Long*One_Section_PNLvalue33.PNLb_Unit_Width;
                  rate233:=rate233/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               end;
               if Tem_Calculate_Rate_Type1=2 then //��PNL����
               begin
                  rate233:=(n223B2*N224B2+N233B2*N234B2)*One_Section_PNLvalue33.PNLb_Long *One_Section_PNLvalue33.PNLb_Width;
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
                tempnl_sheet22.Section_LongA:=One_Section_PNLvalue33.PNLA_Long;
                tempnl_sheet22.Section_WidthA:=One_Section_PNLvalue33.PNLA_Width;
                tempnl_sheet22.Section_Long_NumberA:=i21;
                tempnl_sheet22.Section_Width_NumberA:=j21;
                tempnl_sheet22.Section_LongB:=One_Section_PNLvalue33.PNLb_Width;
                tempnl_sheet22.Section_WidthB:=One_Section_PNLvalue33.PNLb_Long;
                tempnl_sheet22.Section_Long_NumberB:=n223B2;
                tempnl_sheet22.Section_Width_NumberB:=N224B2;
                tempnl_sheet22.Section_LongB:=One_Section_PNLvalue33.PNLb_Width;
                tempnl_sheet22.Section_WidthB:=One_Section_PNLvalue33.PNLb_Long;
                tempnl_sheet22.Section_Long_NumberB:=N233B2;
                tempnl_sheet22.Section_Width_NumberB:=N234B2;
                tempnl_sheet22.Section_Unit_Number:=(n223B2*N224B2+N233B2*N234B2)*One_Section_PNLvalue33.PNLB_Unit_Long_Number*One_Section_PNLvalue33.PNLB_Unit_Width_Number+I21*J21*One_Section_PNLvalue33.PNLA_Unit_Long_Number*One_Section_PNLvalue33.PNLA_Unit_Width_Number;
             end;
             if  rate232=max21 then //(n223B2*N224B2+N231B2*N232B2)
             begin  //N��ĵ���λ���ֱ�ʾ�������Ƿ����,��Ϊ3,4�����,�������ĸ��ʾ�ǵ�һ�ֻ��ǵڶ����ŷ�,A��ʾ��һ���ŷ�;B��ʾ�ڶ����ŷ�
                array_type2:=32;   //С��������PNLB��;С��������PNLB��
                tempnl_sheet22.Section_LongA:=One_Section_PNLvalue33.PNLA_Long;
                tempnl_sheet22.Section_WidthA:=One_Section_PNLvalue33.PNLA_Width;
                tempnl_sheet22.Section_Long_NumberA:=i21;
                tempnl_sheet22.Section_Width_NumberA:=j21;
                tempnl_sheet22.Section_LongB:=One_Section_PNLvalue33.PNLb_Width;
                tempnl_sheet22.Section_WidthB:=One_Section_PNLvalue33.PNLb_Long;
                tempnl_sheet22.Section_Long_NumberB:=n223B2;
                tempnl_sheet22.Section_Width_NumberB:=N224B2;
                tempnl_sheet22.Section_LongB:=One_Section_PNLvalue33.PNLb_Long;
                tempnl_sheet22.Section_WidthB:=One_Section_PNLvalue33.PNLb_Width;
                tempnl_sheet22.Section_Long_NumberB:=N231B2;
                tempnl_sheet22.Section_Width_NumberB:=N232B2;
                tempnl_sheet22.Section_Unit_Number:=(n223B2*N224B2+N231B2*N232B2)*One_Section_PNLvalue33.PNLB_Unit_Long_Number*One_Section_PNLvalue33.PNLB_Unit_Width_Number+I21*J21*One_Section_PNLvalue33.PNLA_Unit_Long_Number*One_Section_PNLvalue33.PNLA_Unit_Width_Number;
             end;
             //С��������PNLB��,С��������PNLB,��ֻ����
             if  rate230=max21 then // rate230:=  (n221B2*N222B2+N231B2*N232B2)
             begin  //N��ĵ���λ���ֱ�ʾ�������Ƿ����,��Ϊ3,4�����,�������ĸ��ʾ�ǵ�һ�ֻ��ǵڶ����ŷ�,A��ʾ��һ���ŷ�;B��ʾ�ڶ����ŷ�
                array_type2:=30;   //С��������PNLB��;С��������PNLB��
                tempnl_sheet22.Section_LongA:=One_Section_PNLvalue33.PNLA_Long;
                tempnl_sheet22.Section_WidthA:=One_Section_PNLvalue33.PNLA_Width;
                tempnl_sheet22.Section_Long_NumberA:=i21;
                tempnl_sheet22.Section_Width_NumberA:=j21;
                tempnl_sheet22.Section_LongB:=One_Section_PNLvalue33.PNLb_Long;
                tempnl_sheet22.Section_WidthB:=One_Section_PNLvalue33.PNLb_Width;
                tempnl_sheet22.Section_Long_NumberB:=n221B2;
                tempnl_sheet22.Section_Width_NumberB:=N222B2;
                tempnl_sheet22.Section_LongB:=One_Section_PNLvalue33.PNLb_Long;
                tempnl_sheet22.Section_WidthB:=One_Section_PNLvalue33.PNLb_Width;
                tempnl_sheet22.Section_Long_NumberB:=N231B2;
                tempnl_sheet22.Section_Width_NumberB:=N232B2;
                tempnl_sheet22.Section_Unit_Number:=(n221B2*N222B2+N231B2*N232B2)*One_Section_PNLvalue33.PNLB_Unit_Long_Number*One_Section_PNLvalue33.PNLB_Unit_Width_Number+I21*J21*One_Section_PNLvalue33.PNLA_Unit_Long_Number*One_Section_PNLvalue33.PNLA_Unit_Width_Number;
             end;
             if  rate231=max21 then //rate231:=(n221B2*N222B2+N233B2*N234B2)
             begin  //N��ĵ���λ���ֱ�ʾ�������Ƿ����,��Ϊ3,4�����,�������ĸ��ʾ�ǵ�һ�ֻ��ǵڶ����ŷ�,A��ʾ��һ���ŷ�;B��ʾ�ڶ����ŷ�
                array_type2:=31;   //С��������PNLB��;С��������PNLB��
                tempnl_sheet22.Section_LongA:=One_Section_PNLvalue33.PNLA_Long;
                tempnl_sheet22.Section_WidthA:=One_Section_PNLvalue33.PNLA_Width;
                tempnl_sheet22.Section_Long_NumberA:=i21;
                tempnl_sheet22.Section_Width_NumberA:=j21;
                tempnl_sheet22.Section_LongB:=One_Section_PNLvalue33.PNLb_Long ;
                tempnl_sheet22.Section_WidthB:=One_Section_PNLvalue33.PNLb_Width;
                tempnl_sheet22.Section_Long_NumberB:=n221B2;
                tempnl_sheet22.Section_Width_NumberB:=N222B2;
                tempnl_sheet22.Section_LongB:=One_Section_PNLvalue33.PNLb_Long;
                tempnl_sheet22.Section_WidthB:=One_Section_PNLvalue33.PNLb_Width;
                tempnl_sheet22.Section_Long_NumberB:=N231B2;
                tempnl_sheet22.Section_Width_NumberB:=N232B2;
                tempnl_sheet22.Section_Unit_Number:=(n221B2*N222B2+N233B2*N234B2)*One_Section_PNLvalue33.PNLB_Unit_Long_Number*One_Section_PNLvalue33.PNLB_Unit_Width_Number+I21*J21*One_Section_PNLvalue33.PNLA_Unit_Long_Number*One_Section_PNLvalue33.PNLA_Unit_Width_Number;
             end;
            //С��������PNLB��,С��������PNLA,��ֻ����
            if  rate229=max21 then //rate229:=n223B2*N224B2+N233A2*N234A2
             begin  //N��ĵ���λ���ֱ�ʾ�������Ƿ����,��Ϊ3,4�����,�������ĸ��ʾ�ǵ�һ�ֻ��ǵڶ����ŷ�,A��ʾ��һ���ŷ�;B��ʾ�ڶ����ŷ�
                array_type2:=29;   //С��������PNLB��;С��������PNLB��
                tempnl_sheet22.Section_LongA:=One_Section_PNLvalue33.PNLA_Long;
                tempnl_sheet22.Section_WidthA:=One_Section_PNLvalue33.PNLA_Width;
                tempnl_sheet22.Section_Long_NumberA:=i21;
                tempnl_sheet22.Section_Width_NumberA:=j21;
                tempnl_sheet22.Section_LongB:=One_Section_PNLvalue33.PNLb_Width;
                tempnl_sheet22.Section_WidthB:=One_Section_PNLvalue33.PNLb_Long;
                tempnl_sheet22.Section_Long_NumberB:=n223B2;
                tempnl_sheet22.Section_Width_NumberB:=N224B2;
                tempnl_sheet22.Section_LongB:=One_Section_PNLvalue33.PNLa_Width;
                tempnl_sheet22.Section_WidthB:=One_Section_PNLvalue33.PNLa_Long;
                tempnl_sheet22.Section_Long_NumberB:=N233A2;
                tempnl_sheet22.Section_Width_NumberB:=N234A2;
               tempnl_sheet22.Section_Unit_Number:=N233A2*N234A2*One_Section_PNLvalue33.PNLa_Unit_Long_Number*One_Section_PNLvalue33.PNLa_Unit_Width_Number+n223B2*N224B2*One_Section_PNLvalue33.PNLB_Unit_Long_Number*One_Section_PNLvalue33.PNLB_Unit_Width_Number+I21*J21*One_Section_PNLvalue33.PNLA_Unit_Long_Number*One_Section_PNLvalue33.PNLA_Unit_Width_Number;
             end;

             if  rate228=max21 then //rate228:=n223B2*N224B2+N231A2*N232A2
             begin  //N��ĵ���λ���ֱ�ʾ�������Ƿ����,��Ϊ3,4�����,�������ĸ��ʾ�ǵ�һ�ֻ��ǵڶ����ŷ�,A��ʾ��һ���ŷ�;B��ʾ�ڶ����ŷ�
                array_type2:=28;   //С��������PNLB��;С��������PNLB��
                tempnl_sheet22.Section_LongA:=One_Section_PNLvalue33.PNLA_Long;
                tempnl_sheet22.Section_WidthA:=One_Section_PNLvalue33.PNLA_Width;
                tempnl_sheet22.Section_Long_NumberA:=i21;
                tempnl_sheet22.Section_Width_NumberA:=j21;
                tempnl_sheet22.Section_LongB:=One_Section_PNLvalue33.PNLb_Width;
                tempnl_sheet22.Section_WidthB:=One_Section_PNLvalue33.PNLb_Long;
                tempnl_sheet22.Section_Long_NumberB:=n223B2;
                tempnl_sheet22.Section_Width_NumberB:=N224B2;
                tempnl_sheet22.Section_LongB:=One_Section_PNLvalue33.PNLa_Long;
                tempnl_sheet22.Section_WidthB:=One_Section_PNLvalue33.PNLa_Width;
                tempnl_sheet22.Section_Long_NumberB:=N231A2;
                tempnl_sheet22.Section_Width_NumberB:=N232A2;
                tempnl_sheet22.Section_Unit_Number:=N231A2*N232A2*One_Section_PNLvalue33.PNLa_Unit_Long_Number*One_Section_PNLvalue33.PNLa_Unit_Width_Number
                                                   +n223B2*N224B2*One_Section_PNLvalue33.PNLB_Unit_Long_Number*One_Section_PNLvalue33.PNLB_Unit_Width_Number
                                                   +I21*J21*One_Section_PNLvalue33.PNLA_Unit_Long_Number*One_Section_PNLvalue33.PNLA_Unit_Width_Number;
             end;

             //С��������PNLB��,С��������PNLA,��ֻ����
             if  rate227=max21 then //rate227:=n221B2*N222B2+N233A2*N234A2
             begin  //N��ĵ���λ���ֱ�ʾ�������Ƿ����,��Ϊ3,4�����,�������ĸ��ʾ�ǵ�һ�ֻ��ǵڶ����ŷ�,A��ʾ��һ���ŷ�;B��ʾ�ڶ����ŷ�
                array_type2:=27;   //С��������PNLB��;С��������PNLB��
                tempnl_sheet22.Section_LongA:=One_Section_PNLvalue33.PNLA_Long;
                tempnl_sheet22.Section_WidthA:=One_Section_PNLvalue33.PNLA_Width;
                tempnl_sheet22.Section_Long_NumberA:=i21;
                tempnl_sheet22.Section_Width_NumberA:=j21;
                tempnl_sheet22.Section_LongB:=One_Section_PNLvalue33.PNLb_Long;
                tempnl_sheet22.Section_WidthB:=One_Section_PNLvalue33.PNLb_Width;
                tempnl_sheet22.Section_Long_NumberB:=n221B2;
                tempnl_sheet22.Section_Width_NumberB:=N222B2;
                tempnl_sheet22.Section_LongB:=One_Section_PNLvalue33.PNLa_Width;
                tempnl_sheet22.Section_WidthB:=One_Section_PNLvalue33.PNLa_Long;
                tempnl_sheet22.Section_Long_NumberB:=N233A2;
                tempnl_sheet22.Section_Width_NumberB:=N234A2;
                tempnl_sheet22.Section_Unit_Number:=N233A2*N234A2*One_Section_PNLvalue33.PNLa_Unit_Long_Number*One_Section_PNLvalue33.PNLa_Unit_Width_Number
                                                   +n221B2*N222B2*One_Section_PNLvalue33.PNLB_Unit_Long_Number*One_Section_PNLvalue33.PNLB_Unit_Width_Number
                                                   +I21*J21*One_Section_PNLvalue33.PNLA_Unit_Long_Number*One_Section_PNLvalue33.PNLA_Unit_Width_Number;
             end;

             if  rate226=max21 then //rate226:=n221B2*N222B2+N231A2*N232A2
             begin  //N��ĵ���λ���ֱ�ʾ�������Ƿ����,��Ϊ3,4�����,�������ĸ��ʾ�ǵ�һ�ֻ��ǵڶ����ŷ�,A��ʾ��һ���ŷ�;B��ʾ�ڶ����ŷ�
                array_type2:=26;   //С��������PNLB��;С��������PNLB��
                tempnl_sheet22.Section_LongA:=One_Section_PNLvalue33.PNLA_Long;
                tempnl_sheet22.Section_WidthA:=One_Section_PNLvalue33.PNLA_Width;
                tempnl_sheet22.Section_Long_NumberA:=i21;
                tempnl_sheet22.Section_Width_NumberA:=j21;
                tempnl_sheet22.Section_LongB:=One_Section_PNLvalue33.PNLb_Long;
                tempnl_sheet22.Section_WidthB:=One_Section_PNLvalue33.PNLb_Width;
                tempnl_sheet22.Section_Long_NumberB:=n221B2;
                tempnl_sheet22.Section_Width_NumberB:=N222B2;
                tempnl_sheet22.Section_LongB:=One_Section_PNLvalue33.PNLa_Long;
                tempnl_sheet22.Section_WidthB:=One_Section_PNLvalue33.PNLa_Width;
                tempnl_sheet22.Section_Long_NumberB:=N231A2;
                tempnl_sheet22.Section_Width_NumberB:=N232A2;
                tempnl_sheet22.Section_Unit_Number:=N231A2*N232A2*One_Section_PNLvalue33.PNLa_Unit_Long_Number*One_Section_PNLvalue33.PNLa_Unit_Width_Number
                                                   +n221B2*N222B2*One_Section_PNLvalue33.PNLB_Unit_Long_Number*One_Section_PNLvalue33.PNLB_Unit_Width_Number
                                                   +I21*J21*One_Section_PNLvalue33.PNLA_Unit_Long_Number*One_Section_PNLvalue33.PNLA_Unit_Width_Number;
             end;

             //С��������PNLA��,С��������PNLb,��ֻ����
             if  rate225=max21 then // rate225:=n221A2*N222A2+N233B2*N234B2
             begin  //N��ĵ���λ���ֱ�ʾ�������Ƿ����,��Ϊ3,4�����,�������ĸ��ʾ�ǵ�һ�ֻ��ǵڶ����ŷ�,A��ʾ��һ���ŷ�;B��ʾ�ڶ����ŷ�
                array_type2:=25;   //С��������PNLB��;С��������PNLB��
                tempnl_sheet22.Section_LongA:=One_Section_PNLvalue33.PNLA_Long;
                tempnl_sheet22.Section_WidthA:=One_Section_PNLvalue33.PNLA_Width;
                tempnl_sheet22.Section_Long_NumberA:=i21;
                tempnl_sheet22.Section_Width_NumberA:=j21;
                tempnl_sheet22.Section_LongB:=One_Section_PNLvalue33.PNLa_Long ;
                tempnl_sheet22.Section_WidthB:=One_Section_PNLvalue33.PNLa_Width ;
                tempnl_sheet22.Section_Long_NumberB:=n221A2;
                tempnl_sheet22.Section_Width_NumberB:=N222A2;
                tempnl_sheet22.Section_LongB:=One_Section_PNLvalue33.PNLb_Width;
                tempnl_sheet22.Section_WidthB:=One_Section_PNLvalue33.PNLb_Long;
                tempnl_sheet22.Section_Long_NumberB:=N233B2;
                tempnl_sheet22.Section_Width_NumberB:=N234B2;
                tempnl_sheet22.Section_Unit_Number:=n221A2*N222A2*One_Section_PNLvalue33.PNLa_Unit_Long_Number*One_Section_PNLvalue33.PNLa_Unit_Width_Number
                                                   +N233B2*N234B2*One_Section_PNLvalue33.PNLB_Unit_Long_Number*One_Section_PNLvalue33.PNLB_Unit_Width_Number
                                                   +I21*J21*One_Section_PNLvalue33.PNLA_Unit_Long_Number*One_Section_PNLvalue33.PNLA_Unit_Width_Number;
             end;

             if  rate224=max21 then // rate224:=n221A2*N222A2+N231B2*N232B2
             begin  //N��ĵ���λ���ֱ�ʾ�������Ƿ����,��Ϊ3,4�����,�������ĸ��ʾ�ǵ�һ�ֻ��ǵڶ����ŷ�,A��ʾ��һ���ŷ�;B��ʾ�ڶ����ŷ�
                array_type2:=24;   //С��������PNLB��;С��������PNLB��
                tempnl_sheet22.Section_LongA:=One_Section_PNLvalue33.PNLA_Long;
                tempnl_sheet22.Section_WidthA:=One_Section_PNLvalue33.PNLA_Width;
                tempnl_sheet22.Section_Long_NumberA:=i21;
                tempnl_sheet22.Section_Width_NumberA:=j21;
                tempnl_sheet22.Section_LongB:=One_Section_PNLvalue33.PNLa_Long;
                tempnl_sheet22.Section_WidthB:=One_Section_PNLvalue33.PNLa_Width;
                tempnl_sheet22.Section_Long_NumberB:=n221A2;
                tempnl_sheet22.Section_Width_NumberB:=N222A2;
                tempnl_sheet22.Section_LongB:=One_Section_PNLvalue33.PNLb_Long;
                tempnl_sheet22.Section_WidthB:=One_Section_PNLvalue33.PNLb_Width;
                tempnl_sheet22.Section_Long_NumberB:=N231B2;
                tempnl_sheet22.Section_Width_NumberB:=N232B2;
                tempnl_sheet22.Section_Unit_Number:=n221A2*N222A2*One_Section_PNLvalue33.PNLa_Unit_Long_Number*One_Section_PNLvalue33.PNLa_Unit_Width_Number
                                                   +N231B2*N232B2*One_Section_PNLvalue33.PNLB_Unit_Long_Number*One_Section_PNLvalue33.PNLB_Unit_Width_Number
                                                   +I21*J21*One_Section_PNLvalue33.PNLA_Unit_Long_Number*One_Section_PNLvalue33.PNLA_Unit_Width_Number;
             end;

             if  rate223=max21 then //rate223:=(n223A2*N224A2+N233A2*N234a2)
             begin  //N��ĵ���λ���ֱ�ʾ�������Ƿ����,��Ϊ3,4�����,�������ĸ��ʾ�ǵ�һ�ֻ��ǵڶ����ŷ�,A��ʾ��һ���ŷ�;B��ʾ�ڶ����ŷ�
                array_type2:=23;   //С��������PNLB��;С��������PNLB��
                tempnl_sheet22.Section_LongA:=One_Section_PNLvalue33.PNLA_Long;
                tempnl_sheet22.Section_WidthA:=One_Section_PNLvalue33.PNLA_Width;
                tempnl_sheet22.Section_Long_NumberA:=i21;
                tempnl_sheet22.Section_Width_NumberA:=j21;
                tempnl_sheet22.Section_LongB:=One_Section_PNLvalue33.PNLa_Width;
                tempnl_sheet22.Section_WidthB:=One_Section_PNLvalue33.PNLa_Long;
                tempnl_sheet22.Section_Long_NumberB:=n223A2;
                tempnl_sheet22.Section_Width_NumberB:=N224A2;
                tempnl_sheet22.Section_LongB:=One_Section_PNLvalue33.PNLa_Width;
                tempnl_sheet22.Section_WidthB:=One_Section_PNLvalue33.PNLa_Long;
                tempnl_sheet22.Section_Long_NumberB:=N233A2;
                tempnl_sheet22.Section_Width_NumberB:=N234a2;
                tempnl_sheet22.Section_Unit_Number:=(n223A2*N224A2+N233A2*N234a2)*One_Section_PNLvalue33.PNLa_Unit_Long_Number*One_Section_PNLvalue33.PNLa_Unit_Width_Number
                                                 //  +n223B2*N224B2*One_Section_PNLvalue33.PNLB_Unit_Long_Number*One_Section_PNLvalue33.PNLB_Unit_Width_Number
                                                   +I21*J21*One_Section_PNLvalue33.PNLA_Unit_Long_Number*One_Section_PNLvalue33.PNLA_Unit_Width_Number;
             end;

             if  rate222=max21 then //rate222:=(n223A2*N224A2+N231A2*N232a2)
             begin  //N��ĵ���λ���ֱ�ʾ�������Ƿ����,��Ϊ3,4�����,�������ĸ��ʾ�ǵ�һ�ֻ��ǵڶ����ŷ�,A��ʾ��һ���ŷ�;B��ʾ�ڶ����ŷ�
                array_type2:=22;   //С��������PNLB��;С��������PNLB��
                tempnl_sheet22.Section_LongA:=One_Section_PNLvalue33.PNLA_Long;
                tempnl_sheet22.Section_WidthA:=One_Section_PNLvalue33.PNLA_Width;
                tempnl_sheet22.Section_Long_NumberA:=i21;
                tempnl_sheet22.Section_Width_NumberA:=j21;
                tempnl_sheet22.Section_LongB:=One_Section_PNLvalue33.PNLa_Width;
                tempnl_sheet22.Section_WidthB:=One_Section_PNLvalue33.PNLa_Long;
                tempnl_sheet22.Section_Long_NumberB:=n223A2;
                tempnl_sheet22.Section_Width_NumberB:=N224A2;
                tempnl_sheet22.Section_LongB:=One_Section_PNLvalue33.PNLa_Long;
                tempnl_sheet22.Section_WidthB:=One_Section_PNLvalue33.PNLa_Width;
                tempnl_sheet22.Section_Long_NumberB:=N231A2;
                tempnl_sheet22.Section_Width_NumberB:=N232a2;
                tempnl_sheet22.Section_Unit_Number:=(n223A2*N224A2+N231A2*N232a2)*One_Section_PNLvalue33.PNLa_Unit_Long_Number*One_Section_PNLvalue33.PNLa_Unit_Width_Number
                                                  // +n223B2*N224B2*One_Section_PNLvalue33.PNLB_Unit_Long_Number*One_Section_PNLvalue33.PNLB_Unit_Width_Number
                                                   +I21*J21*One_Section_PNLvalue33.PNLA_Unit_Long_Number*One_Section_PNLvalue33.PNLA_Unit_Width_Number;
             end;

             if  rate221=max21 then //rate221:=(n221A2*N222A2+N233A2*N234a2)
             begin  //N��ĵ���λ���ֱ�ʾ�������Ƿ����,��Ϊ3,4�����,�������ĸ��ʾ�ǵ�һ�ֻ��ǵڶ����ŷ�,A��ʾ��һ���ŷ�;B��ʾ�ڶ����ŷ�
                array_type2:=21;   //С��������PNLB��;С��������PNLB��
                tempnl_sheet22.Section_LongA:=One_Section_PNLvalue33.PNLA_Long;
                tempnl_sheet22.Section_WidthA:=One_Section_PNLvalue33.PNLA_Width;
                tempnl_sheet22.Section_Long_NumberA:=i21;
                tempnl_sheet22.Section_Width_NumberA:=j21;
                tempnl_sheet22.Section_LongB:=One_Section_PNLvalue33.PNLa_Long;
                tempnl_sheet22.Section_WidthB:=One_Section_PNLvalue33.PNLa_Width;
                tempnl_sheet22.Section_Long_NumberB:=n221A2;
                tempnl_sheet22.Section_Width_NumberB:=N222A2;
                tempnl_sheet22.Section_LongB:=One_Section_PNLvalue33.PNLa_Width;
                tempnl_sheet22.Section_WidthB:=One_Section_PNLvalue33.PNLa_Long;
                tempnl_sheet22.Section_Long_NumberB:=N233A2;
                tempnl_sheet22.Section_Width_NumberB:=N234a2;
                tempnl_sheet22.Section_Unit_Number:=(n221A2*N222A2+N233A2*N234a2)*One_Section_PNLvalue33.PNLa_Unit_Long_Number*One_Section_PNLvalue33.PNLa_Unit_Width_Number
                                                   //+n223B2*N224B2*One_Section_PNLvalue33.PNLB_Unit_Long_Number*One_Section_PNLvalue33.PNLB_Unit_Width_Number
                                                   +I21*J21*One_Section_PNLvalue33.PNLA_Unit_Long_Number*One_Section_PNLvalue33.PNLA_Unit_Width_Number;
             end;
             //���µ�һ���ŷ�,���ϵڶ����ŷ�
             if  rate213=max21 then // rate213:=(n223B1*N224B1+N233B1*N234B1)
             begin  //N��ĵ���λ���ֱ�ʾ�������Ƿ����,��Ϊ3,4�����,�������ĸ��ʾ�ǵ�һ�ֻ��ǵڶ����ŷ�,A��ʾ��һ���ŷ�;B��ʾ�ڶ����ŷ�
                array_type2:=13;   //С��������PNLB��;С��������PNLB��
                tempnl_sheet22.Section_LongA:=One_Section_PNLvalue33.PNLA_Long;
                tempnl_sheet22.Section_WidthA:=One_Section_PNLvalue33.PNLA_Width;
                tempnl_sheet22.Section_Long_NumberA:=i21;
                tempnl_sheet22.Section_Width_NumberA:=j21;
                tempnl_sheet22.Section_LongB:=One_Section_PNLvalue33.PNLb_Width;
                tempnl_sheet22.Section_WidthB:=One_Section_PNLvalue33.PNLb_Long;
                tempnl_sheet22.Section_Long_NumberB:=n223B1;
                tempnl_sheet22.Section_Width_NumberB:=N224B1;
                tempnl_sheet22.Section_LongB:=One_Section_PNLvalue33.PNLb_Width;
                tempnl_sheet22.Section_WidthB:=One_Section_PNLvalue33.PNLb_Long;
                tempnl_sheet22.Section_Long_NumberB:=N233B1;
                tempnl_sheet22.Section_Width_NumberB:=N234B1;
                tempnl_sheet22.Section_Unit_Number:=//(n221A2*N222A2+N233A2*N234a2)*One_Section_PNLvalue33.PNLa_Unit_Long_Number*One_Section_PNLvalue33.PNLa_Unit_Width_Number
                                                   (n223B1*N224B1+N233B1*N234B1)*One_Section_PNLvalue33.PNLB_Unit_Long_Number*One_Section_PNLvalue33.PNLB_Unit_Width_Number
                                                   +I21*J21*One_Section_PNLvalue33.PNLA_Unit_Long_Number*One_Section_PNLvalue33.PNLA_Unit_Width_Number;
             end;

             if  rate212=max21 then //  rate212:=(n223B1*N224B1+N231B1*N232B1)
             begin  //N��ĵ���λ���ֱ�ʾ�������Ƿ����,��Ϊ3,4�����,�������ĸ��ʾ�ǵ�һ�ֻ��ǵڶ����ŷ�,A��ʾ��һ���ŷ�;B��ʾ�ڶ����ŷ�
                array_type2:=12;   //С��������PNLB��;С��������PNLB��
                tempnl_sheet22.Section_LongA:=One_Section_PNLvalue33.PNLA_Long;
                tempnl_sheet22.Section_WidthA:=One_Section_PNLvalue33.PNLA_Width;
                tempnl_sheet22.Section_Long_NumberA:=i21;
                tempnl_sheet22.Section_Width_NumberA:=j21;
                tempnl_sheet22.Section_LongB:=One_Section_PNLvalue33.PNLb_Width;
                tempnl_sheet22.Section_WidthB:=One_Section_PNLvalue33.PNLb_Long;
                tempnl_sheet22.Section_Long_NumberB:=n223B1;
                tempnl_sheet22.Section_Width_NumberB:=N224B1;
                tempnl_sheet22.Section_LongB:=One_Section_PNLvalue33.PNLb_Long;
                tempnl_sheet22.Section_WidthB:=One_Section_PNLvalue33.PNLb_Width;
                tempnl_sheet22.Section_Long_NumberB:=N231B1;
                tempnl_sheet22.Section_Width_NumberB:=N232B1;
                tempnl_sheet22.Section_Unit_Number:=//(n221A2*N222A2+N233A2*N234a2)*One_Section_PNLvalue33.PNLa_Unit_Long_Number*One_Section_PNLvalue33.PNLa_Unit_Width_Number
                                                   (n223B1*N224B1+N231B1*N232B1)*One_Section_PNLvalue33.PNLB_Unit_Long_Number*One_Section_PNLvalue33.PNLB_Unit_Width_Number
                                                   +I21*J21*One_Section_PNLvalue33.PNLA_Unit_Long_Number*One_Section_PNLvalue33.PNLA_Unit_Width_Number;
             end;

             if  rate211=max21 then // rate211:=(n221B1*N222B1+N233B1*N234B1)
             begin  //N��ĵ���λ���ֱ�ʾ�������Ƿ����,��Ϊ3,4�����,�������ĸ��ʾ�ǵ�һ�ֻ��ǵڶ����ŷ�,A��ʾ��һ���ŷ�;B��ʾ�ڶ����ŷ�
                array_type2:=11;   //С��������PNLB��;С��������PNLB��
                tempnl_sheet22.Section_LongA:=One_Section_PNLvalue33.PNLA_Long;
                tempnl_sheet22.Section_WidthA:=One_Section_PNLvalue33.PNLA_Width;
                tempnl_sheet22.Section_Long_NumberA:=i21;
                tempnl_sheet22.Section_Width_NumberA:=j21;
                tempnl_sheet22.Section_LongB:=One_Section_PNLvalue33.PNLb_Long;
                tempnl_sheet22.Section_WidthB:=One_Section_PNLvalue33.PNLb_Width;
                tempnl_sheet22.Section_Long_NumberB:=n221B1;
                tempnl_sheet22.Section_Width_NumberB:=N222B1;
                tempnl_sheet22.Section_LongB:=One_Section_PNLvalue33.PNLb_Width;
                tempnl_sheet22.Section_WidthB:=One_Section_PNLvalue33.PNLb_Long;
                tempnl_sheet22.Section_Long_NumberB:=N233B1;
                tempnl_sheet22.Section_Width_NumberB:=N234B1;
                tempnl_sheet22.Section_Unit_Number:=//(n221A2*N222A2+N233A2*N234a2)*One_Section_PNLvalue33.PNLa_Unit_Long_Number*One_Section_PNLvalue33.PNLa_Unit_Width_Number
                                                   (n221B1*N222B1+N233B1*N234B1)*One_Section_PNLvalue33.PNLB_Unit_Long_Number*One_Section_PNLvalue33.PNLB_Unit_Width_Number
                                                   +I21*J21*One_Section_PNLvalue33.PNLA_Unit_Long_Number*One_Section_PNLvalue33.PNLA_Unit_Width_Number;
             end;

             if  rate210=max21 then // rate210:=(n221B1*N222B1+N231B1*N232B1)
             begin  //N��ĵ���λ���ֱ�ʾ�������Ƿ����,��Ϊ3,4�����,�������ĸ��ʾ�ǵ�һ�ֻ��ǵڶ����ŷ�,A��ʾ��һ���ŷ�;B��ʾ�ڶ����ŷ�
                array_type2:=10;   //С��������PNLB��;С��������PNLB��
                tempnl_sheet22.Section_LongA:=One_Section_PNLvalue33.PNLA_Long;
                tempnl_sheet22.Section_WidthA:=One_Section_PNLvalue33.PNLA_Width;
                tempnl_sheet22.Section_Long_NumberA:=i21;
                tempnl_sheet22.Section_Width_NumberA:=j21;
                tempnl_sheet22.Section_LongB:=One_Section_PNLvalue33.PNLb_Width;
                tempnl_sheet22.Section_WidthB:=One_Section_PNLvalue33.PNLb_Long;
                tempnl_sheet22.Section_Long_NumberB:=n221B1;
                tempnl_sheet22.Section_Width_NumberB:=N222B1;
                tempnl_sheet22.Section_LongB:=One_Section_PNLvalue33.PNLb_Width;
                tempnl_sheet22.Section_WidthB:=One_Section_PNLvalue33.PNLb_Long;
                tempnl_sheet22.Section_Long_NumberB:=N231B1;
                tempnl_sheet22.Section_Width_NumberB:=N232B1;
                tempnl_sheet22.Section_Unit_Number:=//(n221A2*N222A2+N233A2*N234a2)*One_Section_PNLvalue33.PNLa_Unit_Long_Number*One_Section_PNLvalue33.PNLa_Unit_Width_Number
                                                   (n221B1*N222B1+N231B1*N232B1)*One_Section_PNLvalue33.PNLB_Unit_Long_Number*One_Section_PNLvalue33.PNLB_Unit_Width_Number
                                                   +I21*J21*One_Section_PNLvalue33.PNLA_Unit_Long_Number*One_Section_PNLvalue33.PNLA_Unit_Width_Number;
             end;

             if  rate209=max21 then //   rate209:=n223B1*N224B1+N233A1*N234A1
             begin  //N��ĵ���λ���ֱ�ʾ�������Ƿ����,��Ϊ3,4�����,�������ĸ��ʾ�ǵ�һ�ֻ��ǵڶ����ŷ�,A��ʾ��һ���ŷ�;B��ʾ�ڶ����ŷ�
                array_type2:=9;   //С��������PNLB��;С��������PNLB��
                tempnl_sheet22.Section_LongA:=One_Section_PNLvalue33.PNLA_Long;
                tempnl_sheet22.Section_WidthA:=One_Section_PNLvalue33.PNLA_Width;
                tempnl_sheet22.Section_Long_NumberA:=i21;
                tempnl_sheet22.Section_Width_NumberA:=j21;
                tempnl_sheet22.Section_LongB:=One_Section_PNLvalue33.PNLb_Width;
                tempnl_sheet22.Section_WidthB:=One_Section_PNLvalue33.PNLb_Long;
                tempnl_sheet22.Section_Long_NumberB:=n223B1;
                tempnl_sheet22.Section_Width_NumberB:=N224B1;
                tempnl_sheet22.Section_LongB:=One_Section_PNLvalue33.PNLa_Width;
                tempnl_sheet22.Section_WidthB:=One_Section_PNLvalue33.PNLa_Long;
                tempnl_sheet22.Section_Long_NumberB:=N233A2;
                tempnl_sheet22.Section_Width_NumberB:=N234a2;
                tempnl_sheet22.Section_Unit_Number:=N233A1*N234A1*One_Section_PNLvalue33.PNLa_Unit_Long_Number*One_Section_PNLvalue33.PNLa_Unit_Width_Number
                                                   +n223B1*N224B1*One_Section_PNLvalue33.PNLB_Unit_Long_Number*One_Section_PNLvalue33.PNLB_Unit_Width_Number
                                                   +I21*J21*One_Section_PNLvalue33.PNLA_Unit_Long_Number*One_Section_PNLvalue33.PNLA_Unit_Width_Number;
             end;

             if  rate208=max21 then //   rate208:=n223B1*N224B1+N231A1*N232A1
             begin  //N��ĵ���λ���ֱ�ʾ�������Ƿ����,��Ϊ3,4�����,�������ĸ��ʾ�ǵ�һ�ֻ��ǵڶ����ŷ�,A��ʾ��һ���ŷ�;B��ʾ�ڶ����ŷ�
                array_type2:=8;   //С��������PNLB��;С��������PNLB��
                tempnl_sheet22.Section_LongA:=One_Section_PNLvalue33.PNLA_Long;
                tempnl_sheet22.Section_WidthA:=One_Section_PNLvalue33.PNLA_Width;
                tempnl_sheet22.Section_Long_NumberA:=i21;
                tempnl_sheet22.Section_Width_NumberA:=j21;
                tempnl_sheet22.Section_LongB:=One_Section_PNLvalue33.PNLb_Width;
                tempnl_sheet22.Section_WidthB:=One_Section_PNLvalue33.PNLb_Long;
                tempnl_sheet22.Section_Long_NumberB:=n223B1;
                tempnl_sheet22.Section_Width_NumberB:=N224B1;
                tempnl_sheet22.Section_LongB:=One_Section_PNLvalue33.PNLa_Long;
                tempnl_sheet22.Section_WidthB:=One_Section_PNLvalue33.PNLa_Width;
                tempnl_sheet22.Section_Long_NumberB:=N231A1;
                tempnl_sheet22.Section_Width_NumberB:=N232A1;
                tempnl_sheet22.Section_Unit_Number:=N231A1*N232A1*One_Section_PNLvalue33.PNLa_Unit_Long_Number*One_Section_PNLvalue33.PNLa_Unit_Width_Number
                                                   +n223B1*N224B1*One_Section_PNLvalue33.PNLB_Unit_Long_Number*One_Section_PNLvalue33.PNLB_Unit_Width_Number
                                                   +I21*J21*One_Section_PNLvalue33.PNLA_Unit_Long_Number*One_Section_PNLvalue33.PNLA_Unit_Width_Number;
             end;

             if  rate207=max21 then // rate207:=n221B1*N222B1+N233A1*N234A1
             begin  //N��ĵ���λ���ֱ�ʾ�������Ƿ����,��Ϊ3,4�����,�������ĸ��ʾ�ǵ�һ�ֻ��ǵڶ����ŷ�,A��ʾ��һ���ŷ�;B��ʾ�ڶ����ŷ�
                array_type2:=7;   //С��������PNLB��;С��������PNLB��
                tempnl_sheet22.Section_LongA:=One_Section_PNLvalue33.PNLA_Long;
                tempnl_sheet22.Section_WidthA:=One_Section_PNLvalue33.PNLA_Width;
                tempnl_sheet22.Section_Long_NumberA:=i21;
                tempnl_sheet22.Section_Width_NumberA:=j21;
                tempnl_sheet22.Section_LongB:=One_Section_PNLvalue33.PNLb_Long;
                tempnl_sheet22.Section_WidthB:=One_Section_PNLvalue33.PNLb_Width;
                tempnl_sheet22.Section_Long_NumberB:=n221B1;
                tempnl_sheet22.Section_Width_NumberB:=N222B1;
                tempnl_sheet22.Section_LongB:=One_Section_PNLvalue33.PNLa_Width;
                tempnl_sheet22.Section_WidthB:=One_Section_PNLvalue33.PNLa_Long;
                tempnl_sheet22.Section_Long_NumberB:=N233A2;
                tempnl_sheet22.Section_Width_NumberB:=N234a2;
                tempnl_sheet22.Section_Unit_Number:=N233A1*N234A1*One_Section_PNLvalue33.PNLa_Unit_Long_Number*One_Section_PNLvalue33.PNLa_Unit_Width_Number
                                                   +n221B1*N222B1*One_Section_PNLvalue33.PNLB_Unit_Long_Number*One_Section_PNLvalue33.PNLB_Unit_Width_Number
                                                   +I21*J21*One_Section_PNLvalue33.PNLA_Unit_Long_Number*One_Section_PNLvalue33.PNLA_Unit_Width_Number;
             end;


             if  rate206=max21 then //  rate206:=n221B1*N222B1+N231A1*N232A1
             begin  //N��ĵ���λ���ֱ�ʾ�������Ƿ����,��Ϊ3,4�����,�������ĸ��ʾ�ǵ�һ�ֻ��ǵڶ����ŷ�,A��ʾ��һ���ŷ�;B��ʾ�ڶ����ŷ�
                array_type2:=6;   //С��������PNLB��;С��������PNLB��
                tempnl_sheet22.Section_LongA:=One_Section_PNLvalue33.PNLA_Long;
                tempnl_sheet22.Section_WidthA:=One_Section_PNLvalue33.PNLA_Width;
                tempnl_sheet22.Section_Long_NumberA:=i21;
                tempnl_sheet22.Section_Width_NumberA:=j21;
                tempnl_sheet22.Section_LongB:=One_Section_PNLvalue33.PNLb_Long;
                tempnl_sheet22.Section_WidthB:=One_Section_PNLvalue33.PNLb_Width;
                tempnl_sheet22.Section_Long_NumberB:=n221B1;
                tempnl_sheet22.Section_Width_NumberB:=N222B1;
                tempnl_sheet22.Section_LongB:=One_Section_PNLvalue33.PNLa_Long;
                tempnl_sheet22.Section_WidthB:=One_Section_PNLvalue33.PNLa_Width;
                tempnl_sheet22.Section_Long_NumberB:=N231A1;
                tempnl_sheet22.Section_Width_NumberB:=N232A1;
                tempnl_sheet22.Section_Unit_Number:=N231A1*N232A1*One_Section_PNLvalue33.PNLa_Unit_Long_Number*One_Section_PNLvalue33.PNLa_Unit_Width_Number
                                                   +n221B1*N222B1*One_Section_PNLvalue33.PNLB_Unit_Long_Number*One_Section_PNLvalue33.PNLB_Unit_Width_Number
                                                   +I21*J21*One_Section_PNLvalue33.PNLA_Unit_Long_Number*One_Section_PNLvalue33.PNLA_Unit_Width_Number;
             end;

              if  rate205=max21 then //  rate205:=n221A1*N222A1+N233B1*N234B1
             begin  //N��ĵ���λ���ֱ�ʾ�������Ƿ����,��Ϊ3,4�����,�������ĸ��ʾ�ǵ�һ�ֻ��ǵڶ����ŷ�,A��ʾ��һ���ŷ�;B��ʾ�ڶ����ŷ�
                array_type2:=5;   //С��������PNLB��;С��������PNLB��
                tempnl_sheet22.Section_LongA:=One_Section_PNLvalue33.PNLA_Long;
                tempnl_sheet22.Section_WidthA:=One_Section_PNLvalue33.PNLA_Width;
                tempnl_sheet22.Section_Long_NumberA:=i21;
                tempnl_sheet22.Section_Width_NumberA:=j21;
                tempnl_sheet22.Section_LongB:=One_Section_PNLvalue33.PNLa_Long;
                tempnl_sheet22.Section_WidthB:=One_Section_PNLvalue33.PNLa_Width;
                tempnl_sheet22.Section_Long_NumberB:=n221A2;
                tempnl_sheet22.Section_Width_NumberB:=N222A2;
                tempnl_sheet22.Section_LongB:=One_Section_PNLvalue33.PNLb_Width;
                tempnl_sheet22.Section_WidthB:=One_Section_PNLvalue33.PNLb_Long;
                tempnl_sheet22.Section_Long_NumberB:=N233B1;
                tempnl_sheet22.Section_Width_NumberB:=N234B1;
                tempnl_sheet22.Section_Unit_Number:=n221A1*N222A1*One_Section_PNLvalue33.PNLa_Unit_Long_Number*One_Section_PNLvalue33.PNLa_Unit_Width_Number
                                                   +N233B1*N234B1*One_Section_PNLvalue33.PNLB_Unit_Long_Number*One_Section_PNLvalue33.PNLB_Unit_Width_Number
                                                   +I21*J21*One_Section_PNLvalue33.PNLA_Unit_Long_Number*One_Section_PNLvalue33.PNLA_Unit_Width_Number;
             end;

             if  rate204=max21 then //  rate204:=n221A1*N222A1+N231B1*N232B1
             begin  //N��ĵ���λ���ֱ�ʾ�������Ƿ����,��Ϊ3,4�����,�������ĸ��ʾ�ǵ�һ�ֻ��ǵڶ����ŷ�,A��ʾ��һ���ŷ�;B��ʾ�ڶ����ŷ�
                array_type2:=4;   //С��������PNLB��;С��������PNLB��
                tempnl_sheet22.Section_LongA:=One_Section_PNLvalue33.PNLA_Long;
                tempnl_sheet22.Section_WidthA:=One_Section_PNLvalue33.PNLA_Width;
                tempnl_sheet22.Section_Long_NumberA:=i21;
                tempnl_sheet22.Section_Width_NumberA:=j21;
                tempnl_sheet22.Section_LongB:=One_Section_PNLvalue33.PNLa_Long;
                tempnl_sheet22.Section_WidthB:=One_Section_PNLvalue33.PNLa_Width;
                tempnl_sheet22.Section_Long_NumberB:=n221A2;
                tempnl_sheet22.Section_Width_NumberB:=N222A2;
                tempnl_sheet22.Section_LongB:=One_Section_PNLvalue33.PNLb_Long;
                tempnl_sheet22.Section_WidthB:=One_Section_PNLvalue33.PNLb_Width;
                tempnl_sheet22.Section_Long_NumberB:=N231B1;
                tempnl_sheet22.Section_Width_NumberB:=N232B1;
                tempnl_sheet22.Section_Unit_Number:=n221A1*N222A1*One_Section_PNLvalue33.PNLa_Unit_Long_Number*One_Section_PNLvalue33.PNLa_Unit_Width_Number
                                                   +N231B1*N232B1*One_Section_PNLvalue33.PNLB_Unit_Long_Number*One_Section_PNLvalue33.PNLB_Unit_Width_Number
                                                   +I21*J21*One_Section_PNLvalue33.PNLA_Unit_Long_Number*One_Section_PNLvalue33.PNLA_Unit_Width_Number;
             end;

             if  rate203=max21 then // rate203:=(n223A1*N224A1+N233A1*N234a1)
             begin  //N��ĵ���λ���ֱ�ʾ�������Ƿ����,��Ϊ3,4�����,�������ĸ��ʾ�ǵ�һ�ֻ��ǵڶ����ŷ�,A��ʾ��һ���ŷ�;B��ʾ�ڶ����ŷ�
                array_type2:=3;   //С��������PNLB��;С��������PNLB��
                tempnl_sheet22.Section_LongA:=One_Section_PNLvalue33.PNLA_Long;
                tempnl_sheet22.Section_WidthA:=One_Section_PNLvalue33.PNLA_Width;
                tempnl_sheet22.Section_Long_NumberA:=i21;
                tempnl_sheet22.Section_Width_NumberA:=j21;
                tempnl_sheet22.Section_LongB:=One_Section_PNLvalue33.PNLa_Width;
                tempnl_sheet22.Section_WidthB:=One_Section_PNLvalue33.PNLa_Long;
                tempnl_sheet22.Section_Long_NumberB:=n223A1;
                tempnl_sheet22.Section_Width_NumberB:=N224A1;
                tempnl_sheet22.Section_LongB:=One_Section_PNLvalue33.PNLa_Width;
                tempnl_sheet22.Section_WidthB:=One_Section_PNLvalue33.PNLa_Long;
                tempnl_sheet22.Section_Long_NumberB:=N233A1;
                tempnl_sheet22.Section_Width_NumberB:=N234a1;
                tempnl_sheet22.Section_Unit_Number:=(n223A1*N224A1+N233A1*N234a1)*One_Section_PNLvalue33.PNLa_Unit_Long_Number*One_Section_PNLvalue33.PNLa_Unit_Width_Number
                                                   //+n223B2*N224B2*One_Section_PNLvalue33.PNLB_Unit_Long_Number*One_Section_PNLvalue33.PNLB_Unit_Width_Number
                                                   +I21*J21*One_Section_PNLvalue33.PNLA_Unit_Long_Number*One_Section_PNLvalue33.PNLA_Unit_Width_Number;
             end;

            if  rate202=max21 then //rate202:=(n223A1*N224A1+N231A1*N232a1)
             begin  //N��ĵ���λ���ֱ�ʾ�������Ƿ����,��Ϊ3,4�����,�������ĸ��ʾ�ǵ�һ�ֻ��ǵڶ����ŷ�,A��ʾ��һ���ŷ�;B��ʾ�ڶ����ŷ�
                array_type2:=2;   //С��������PNLB��;С��������PNLB��
                tempnl_sheet22.Section_LongA:=One_Section_PNLvalue33.PNLA_Long;
                tempnl_sheet22.Section_WidthA:=One_Section_PNLvalue33.PNLA_Width;
                tempnl_sheet22.Section_Long_NumberA:=i21;
                tempnl_sheet22.Section_Width_NumberA:=j21;
                tempnl_sheet22.Section_LongB:=One_Section_PNLvalue33.PNLa_Width;
                tempnl_sheet22.Section_WidthB:=One_Section_PNLvalue33.PNLa_Long;
                tempnl_sheet22.Section_Long_NumberB:=n223A1;
                tempnl_sheet22.Section_Width_NumberB:=N224A1;
                tempnl_sheet22.Section_LongB:=One_Section_PNLvalue33.PNLa_Width;
                tempnl_sheet22.Section_WidthB:=One_Section_PNLvalue33.PNLa_Long;
                tempnl_sheet22.Section_Long_NumberB:=N231A1;
                tempnl_sheet22.Section_Width_NumberB:=N232a1;
                tempnl_sheet22.Section_Unit_Number:=(n223A1*N224A1+N231A1*N232a1)*One_Section_PNLvalue33.PNLa_Unit_Long_Number*One_Section_PNLvalue33.PNLa_Unit_Width_Number
                                                   //+n223B2*N224B2*One_Section_PNLvalue33.PNLB_Unit_Long_Number*One_Section_PNLvalue33.PNLB_Unit_Width_Number
                                                   +I21*J21*One_Section_PNLvalue33.PNLA_Unit_Long_Number*One_Section_PNLvalue33.PNLA_Unit_Width_Number;
             end;

            if  rate201=max21 then //rate201:=(n221A1*N222A1+N233A1*N234a1)
             begin  //N��ĵ���λ���ֱ�ʾ�������Ƿ����,��Ϊ3,4�����,�������ĸ��ʾ�ǵ�һ�ֻ��ǵڶ����ŷ�,A��ʾ��һ���ŷ�;B��ʾ�ڶ����ŷ�
                array_type2:=1;   //С��������PNLB��;С��������PNLB��
                tempnl_sheet22.Section_LongA:=One_Section_PNLvalue33.PNLA_Long;
                tempnl_sheet22.Section_WidthA:=One_Section_PNLvalue33.PNLA_Width;
                tempnl_sheet22.Section_Long_NumberA:=i21;
                tempnl_sheet22.Section_Width_NumberA:=j21;
                tempnl_sheet22.Section_LongB:=One_Section_PNLvalue33.PNLa_Long;
                tempnl_sheet22.Section_WidthB:=One_Section_PNLvalue33.PNLa_Width;
                tempnl_sheet22.Section_Long_NumberB:=n221A1;
                tempnl_sheet22.Section_Width_NumberB:=N222A1;
                tempnl_sheet22.Section_LongB:=One_Section_PNLvalue33.PNLa_Long ;
                tempnl_sheet22.Section_WidthB:=One_Section_PNLvalue33.PNLa_Width;
                tempnl_sheet22.Section_Long_NumberB:=N233A1;
                tempnl_sheet22.Section_Width_NumberB:=N234a1;
                tempnl_sheet22.Section_Unit_Number:=(n221A1*N222A1+N233A1*N234a1)*One_Section_PNLvalue33.PNLa_Unit_Long_Number*One_Section_PNLvalue33.PNLa_Unit_Width_Number
                                                   //+n223B2*N224B2*One_Section_PNLvalue33.PNLB_Unit_Long_Number*One_Section_PNLvalue33.PNLB_Unit_Width_Number
                                                   +I21*J21*One_Section_PNLvalue33.PNLA_Unit_Long_Number*One_Section_PNLvalue33.PNLA_Unit_Width_Number;
             end;
             if  rate200=max21 then //
             begin  //N��ĵ���λ���ֱ�ʾ�������Ƿ����,��Ϊ3,4�����,�������ĸ��ʾ�ǵ�һ�ֻ��ǵڶ����ŷ�,A��ʾ��һ���ŷ�;B��ʾ�ڶ����ŷ�
                array_type2:=0;   //С��������PNLB��;С��������PNLB��
                tempnl_sheet22.Section_LongA:=One_Section_PNLvalue33.PNLA_Long;
                tempnl_sheet22.Section_WidthA:=One_Section_PNLvalue33.PNLA_Width;
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
                tempnl_sheet22.Section_Unit_Number:=//(n201*n202)*One_Section_PNLvalue33.PNLa_Unit_Long_Number*One_Section_PNLvalue33.PNLa_Unit_Width_Number
                                                   //+n223B2*N224B2*One_Section_PNLvalue33.PNLB_Unit_Long_Number*One_Section_PNLvalue33.PNLB_Unit_Width_Number
                                                   n201*n202*One_Section_PNLvalue33.PNLA_Unit_Long_Number*One_Section_PNLvalue33.PNLA_Unit_Width_Number;
             end;





          end;
        end;
     end;    {}
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
  begin   //
     if Leave_Section_falchion_number1=2 then //ֻ��������,�ŷ�ֻ��AB��һ�߹̶�����
     begin //
       n31:=trunc(Three_Section_value333.Sheet_Long/Three_Section_PNLvalue33.PNLA_Long);//��A����
       n32:=trunc(Three_Section_value333.Sheet_Width/Three_Section_PNLvalue33.PNLA_Width);//��A����
       n301:=n31;
       n302:=n32;
       rate30:=n301*n302*Three_Section_PNLvalue33.PNLA_Unit_Long_Number*Three_Section_PNLvalue33.PNLA_Unit_Width_Number;
       if Tem_Calculate_Rate_Type1=1 then  //�õ�Ԫ����
       begin //
         rate30:=n301*n302*Three_Section_PNLvalue33.PNLA_Unit_Long_Number*Three_Section_PNLvalue33.PNLA_Unit_Width_Number*Three_Section_PNLvalue33.PNLA_Unit_Long*Three_Section_PNLvalue33.PNLA_Unit_Width;
         rate30:=rate30/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
       end; //

       if Tem_Calculate_Rate_Type1=2 then //��PNL����
       begin //
         rate30:=n301*n302*Three_Section_PNLvalue33.PNLA_Long*Three_Section_PNLvalue33.PNLA_Width;
         rate30:=rate30/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
       end; //
      // rate30:=rate30*Three_Section_PNLvalue33.PNLA_Width*Three_Section_PNLvalue33.PNLA_Long/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width ;
       for j31:=1 to n32 do //
       begin //
          //ʣ�²�����A,����ɵ���
           n331:=0;
           n341:=0;
           rate31:=0;
           if (Three_Section_value333.Sheet_Long>=Three_Section_PNLvalue33.PNLA_Width) and
              ((Three_Section_value333.Sheet_Width-j31*Three_Section_PNLvalue33.PNLA_Width)>=Three_Section_PNLvalue33.PNLA_Long) then//ʣ�²����Ƿ����A,
           begin //
              n331:=trunc(Three_Section_value333.Sheet_Long/Three_Section_PNLvalue33.PNLA_Width);
              n341:=trunc((Three_Section_value333.Sheet_Width-j31*Three_Section_PNLvalue33.PNLA_Width)/Three_Section_PNLvalue33.PNLA_Long);
              rate31:=(n31*j31+n331*n341)*Three_Section_PNLvalue33.PNLA_Unit_Long_Number*Three_Section_PNLvalue33.PNLA_Unit_Width_Number;
              if Tem_Calculate_Rate_Type1=1 then  //�õ�Ԫ����
              begin //
                 rate31:=(n31*j31+n331*n341)*Three_Section_PNLvalue33.PNLA_Unit_Long_Number*Three_Section_PNLvalue33.PNLA_Unit_Width_Number*Three_Section_PNLvalue33.PNLA_Unit_Long*Three_Section_PNLvalue33.PNLA_Unit_Width;
                 rate31:=rate31/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
              end;  //

              if Tem_Calculate_Rate_Type1=2 then //��PNL����
              begin //
                  rate31:=(n31*j31+n331*n341)*Three_Section_PNLvalue33.PNLA_Long*Three_Section_PNLvalue33.PNLA_Width;
                  rate31:=rate31/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
              end  //
        //      rate31:=rate31*Three_Section_PNLvalue33.PNLA_Width*Three_Section_PNLvalue33.PNLA_Long/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width ;
           end;  //
          {
          //ʣ�²�����B,���������,����������
            n332:=0;
            n342:=0;
            rate32:=0;
           n333:=0;
           n343:=0;
           rate33:=0;
           }
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

           end; //
       end;//
     end; //
    //3333333
   {
     if Leave_Section_falchion_number1=3 then  //��������
     begin
       n21:=trunc(three_Section_value333.Sheet_Long/three_Section_PNLvalue33.PNLA_Long);//��A,��󳤸���
       n22:=trunc(three_Section_value333.Sheet_Width/three_Section_PNLvalue33.PNLA_Width);//��A,�������

       n201:=n21; //PNLA������Ϊn201*n202
       n202:=n22;
       rate200:=n201*n202*three_Section_PNLvalue33.PNLA_Unit_Long_Number*three_Section_PNLvalue33.PNLA_Unit_Width_Number;
       if Tem_Calculate_Rate_Type1=1 then  //�õ�Ԫ����
       begin
          rate200:=n201*n202*three_Section_PNLvalue33.PNLA_Unit_Long_Number
                   *three_Section_PNLvalue33.PNLA_Unit_Width_Number
                   *three_Section_PNLvalue33.PNLA_Unit_Long
                   *three_Section_PNLvalue33.PNLA_Unit_Width;
          rate200:=rate200/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
       end;
       if Tem_Calculate_Rate_Type1=2 then //��PNL����
       begin
         rate200:=n201*N202*three_Section_PNLvalue33.PNLA_Long*three_Section_PNLvalue33.PNLA_Width;//PNL��������볤��
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

             //three_Section_value333.Sheet_long-i21*three_Section_PNLvalue33.PNLA_Long
             //three_Section_value333.Sheet_Width-j21*three_Section_PNLvalue33.PNLA_Width
             //С����PNLA���ų���
             n221A1:=0;
             n222A1:=0;
             if (three_Section_value333.Sheet_long-i21*three_Section_PNLvalue33.PNLA_Long>=three_Section_PNLvalue33.PNLA_Width)
               and (three_Section_value333.Sheet_Width>=three_Section_PNLvalue33.PNLA_Long) then
               begin
                 n221A1:=trunc((three_Section_value333.Sheet_long-i21*three_Section_PNLvalue33.PNLA_Long)/three_Section_PNLvalue33.PNLA_Width);
                 n222A1:=trunc(three_Section_value333.Sheet_Width/three_Section_PNLvalue33.PNLA_Long);
              end;
              //С����PNLA���ų���
               n231A1:=0;
               n232A1:=0;
              if (i21*three_Section_PNLvalue33.PNLA_Long>=three_Section_PNLvalue33.PNLA_Width)
               and ((three_Section_value333.Sheet_Width-j21*three_Section_PNLvalue33.PNLA_Width)>=three_Section_PNLvalue33.PNLA_Long) then
               begin
                 n231A1:=trunc(i21*three_Section_PNLvalue33.PNLA_Long/three_Section_PNLvalue33.PNLA_Width);
                 n232A1:=trunc((three_Section_value333.Sheet_Width-j21*three_Section_PNLvalue33.PNLA_Width)/three_Section_PNLvalue33.PNLA_Long);
              end;
              //С����PNLA���ų���
              n233A1:=0;
              n234A1:=0;
              if (i21*three_Section_PNLvalue33.PNLA_Long>=three_Section_PNLvalue33.PNLA_Long)
               and ((three_Section_value333.Sheet_Width-j21*three_Section_PNLvalue33.PNLA_Width)>=three_Section_PNLvalue33.PNLA_Width) then
               begin
                 n233A1:=trunc(i21*three_Section_PNLvalue33.PNLA_Long/three_Section_PNLvalue33.PNLA_Long);
                 n234A1:=trunc((three_Section_value333.Sheet_Width-j21*three_Section_PNLvalue33.PNLA_Width)/three_Section_PNLvalue33.PNLA_Width);
              end;
              //С����PNLA���ų���
              n223A1:=0;
              n224A1:=0;
              if (three_Section_value333.Sheet_long-i21*three_Section_PNLvalue33.PNLA_Long>=three_Section_PNLvalue33.PNLA_Long)
               and (three_Section_value333.Sheet_Width>=three_Section_PNLvalue33.PNLA_Width) then
               begin
                 n223A1:=trunc((three_Section_value333.Sheet_long-i21*three_Section_PNLvalue33.PNLA_Long)/three_Section_PNLvalue33.PNLA_Long);
                 n224A1:=trunc(three_Section_value333.Sheet_Width/three_Section_PNLvalue33.PNLA_Width);
              end;


              //С����PNLB���ų���
              n221B1:=0;
              n222B1:=0;
              if (three_Section_value333.Sheet_long-i21*three_Section_PNLvalue33.PNLA_Long>=three_Section_PNLvalue33.PNLB_Width)
               and (three_Section_value333.Sheet_Width>=three_Section_PNLvalue33.PNLB_Long) then
               begin
                 n221B1:=trunc((three_Section_value333.Sheet_long-i21*three_Section_PNLvalue33.PNLA_Long)/three_Section_PNLvalue33.PNLB_Width);
                 n222B1:=trunc(three_Section_value333.Sheet_Width/three_Section_PNLvalue33.PNLB_Long);
              end;
              //С����PNLB���ų���
              n231B1:=0;
              n232B1:=0;
              if (i21*three_Section_PNLvalue33.PNLA_Long>=three_Section_PNLvalue33.PNLB_Width)
               and ((three_Section_value333.Sheet_Width-j21*three_Section_PNLvalue33.PNLA_Width)>=three_Section_PNLvalue33.PNLB_Long) then
               begin
                 n231B1:=trunc(i21*three_Section_PNLvalue33.PNLA_Long/three_Section_PNLvalue33.PNLB_Width);
                 n232B1:=trunc((three_Section_value333.Sheet_Width-j21*three_Section_PNLvalue33.PNLA_Width)/three_Section_PNLvalue33.PNLB_Long);
              end;
              //С����PNLB���ų���
              n233B1:=0;
              n234B1:=0;
              if (i21*three_Section_PNLvalue33.PNLA_Long>=three_Section_PNLvalue33.PNLB_Long)
               and ((three_Section_value333.Sheet_Width-j21*three_Section_PNLvalue33.PNLA_Width)>=three_Section_PNLvalue33.PNLB_Width) then
               begin
                 n233B1:=trunc(i21*three_Section_PNLvalue33.PNLA_Long/three_Section_PNLvalue33.PNLB_Long);
                 n234B1:=trunc((three_Section_value333.Sheet_Width-j21*three_Section_PNLvalue33.PNLA_Width)/three_Section_PNLvalue33.PNLB_Width);
              end;
              //С����PNLB���ų���
              n223B1:=0;
              n224B1:=0;
              if (three_Section_value333.Sheet_long-i21*three_Section_PNLvalue33.PNLA_Long>=three_Section_PNLvalue33.PNLB_Long)
               and (three_Section_value333.Sheet_Width>=three_Section_PNLvalue33.PNLB_Width) then
               begin
                 n223B1:=trunc((three_Section_value333.Sheet_long-i21*three_Section_PNLvalue33.PNLA_Long)/three_Section_PNLvalue33.PNLB_Long);
                 n224B1:=trunc(three_Section_value333.Sheet_Width/three_Section_PNLvalue33.PNLB_Width);
              end;
              //С��������PNLA��,С��������PNLA,��ֻһ��

               rate201:=(n221A1*N222A1+N233A1*N234a1)*three_Section_PNLvalue33.PNLA_Unit_Long_Number*three_Section_PNLvalue33.PNLA_Unit_Width_Number;
               if Tem_Calculate_Rate_Type1=1 then  //�õ�Ԫ����
               begin
                  rate201:=(n221A1*N222A1+N233A1*N234a1)*three_Section_PNLvalue33.PNLA_Unit_Long_Number*three_Section_PNLvalue33.PNLA_Unit_Width_Number
                         *three_Section_PNLvalue33.PNLA_Unit_Long*three_Section_PNLvalue33.PNLA_Unit_Width;
                  rate201:=rate201/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               end;
               if Tem_Calculate_Rate_Type1=2 then //��PNL����
               begin
                  rate201:=(n221A1*N222A1+N233A1*N234a1)
                         *three_Section_PNLvalue33.PNLA_Long *three_Section_PNLvalue33.PNLA_Width;
                  rate201:=rate201/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               END;
              //С��������PNLA��,С��������PNLA,��ֻһ��
              rate202:=(n223A1*N224A1+N231A1*N232a1)*three_Section_PNLvalue33.PNLA_Unit_Long_Number*three_Section_PNLvalue33.PNLA_Unit_Width_Number;
              if Tem_Calculate_Rate_Type1=1 then  //�õ�Ԫ����
               begin
                  rate202:=(n223A1*N224A1+N231A1*N232a1)*three_Section_PNLvalue33.PNLA_Unit_Long_Number*three_Section_PNLvalue33.PNLA_Unit_Width_Number
                         *three_Section_PNLvalue33.PNLA_Unit_Long*three_Section_PNLvalue33.PNLA_Unit_Width;
                  rate202:=rate202/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               end;
               if Tem_Calculate_Rate_Type1=2 then //��PNL����
               begin
                  rate202:=(n223A1*N224A1+N231A1*N232a1)
                         *three_Section_PNLvalue33.PNLA_Long *three_Section_PNLvalue33.PNLA_Width;
                  rate202:=rate203/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               END;
              rate203:=(n223A1*N224A1+N233A1*N234a1)*three_Section_PNLvalue33.PNLA_Unit_Long_Number*three_Section_PNLvalue33.PNLA_Unit_Width_Number;
              if Tem_Calculate_Rate_Type1=1 then  //�õ�Ԫ����
               begin
                  rate203:=(n223A1*N224A1+N233A1*N234a1)*three_Section_PNLvalue33.PNLA_Unit_Long_Number*three_Section_PNLvalue33.PNLA_Unit_Width_Number
                         *three_Section_PNLvalue33.PNLA_Unit_Long*three_Section_PNLvalue33.PNLA_Unit_Width;
                  rate203:=rate203/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               end;
               if Tem_Calculate_Rate_Type1=2 then //��PNL����
               begin
                  rate203:=(n223A1*N224A1+N233A1*N234a1)
                         *three_Section_PNLvalue33.PNLA_Long *three_Section_PNLvalue33.PNLA_Width;
                  rate203:=rate203/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               END;
               //С��������PNLA��,С��������PNLb,��ֻ����
              rate204:=n221A1*N222A1*three_Section_PNLvalue33.PNLA_Unit_Long_Number*three_Section_PNLvalue33.PNLA_Unit_Width_Number
                       +N231B1*N232B1*three_Section_PNLvalue33.PNLB_Unit_Long_Number*three_Section_PNLvalue33.PNLB_Unit_Width_Number;
              if Tem_Calculate_Rate_Type1=1 then  //�õ�Ԫ����
               begin
                  rate204:=n221A1*N222A1*three_Section_PNLvalue33.PNLA_Unit_Long_Number*three_Section_PNLvalue33.PNLA_Unit_Width_Number
                                          *three_Section_PNLvalue33.PNLA_Unit_Long*three_Section_PNLvalue33.PNLA_Unit_Width
                         +N231B1*N232B1*three_Section_PNLvalue33.PNLb_Unit_Long_Number*three_Section_PNLvalue33.PNLb_Unit_Width_Number
                                        *three_Section_PNLvalue33.PNLb_Unit_Long*three_Section_PNLvalue33.PNLb_Unit_Width;
                  rate204:=rate204/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               end;
               if Tem_Calculate_Rate_Type1=2 then //��PNL����
               begin
                  rate204:=n221A1*N222A1*three_Section_PNLvalue33.PNLA_Long *three_Section_PNLvalue33.PNLA_Width
                           +N231B1*N232B1*three_Section_PNLvalue33.PNLb_Long *three_Section_PNLvalue33.PNLb_Width;
                  rate204:=rate204/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               END;

              rate205:=n221A1*N222A1*three_Section_PNLvalue33.PNLA_Unit_Long_Number*three_Section_PNLvalue33.PNLA_Unit_Width_Number
                      +N233B1*N234B1*three_Section_PNLvalue33.PNLB_Unit_Long_Number*three_Section_PNLvalue33.PNLB_Unit_Width_Number;

               if Tem_Calculate_Rate_Type1=1 then  //�õ�Ԫ����
               begin
                  rate205:=n221A1*N222A1*three_Section_PNLvalue33.PNLA_Unit_Long_Number*three_Section_PNLvalue33.PNLA_Unit_Width_Number
                                          *three_Section_PNLvalue33.PNLA_Unit_Long*three_Section_PNLvalue33.PNLA_Unit_Width
                         +N233B1*N234B1*three_Section_PNLvalue33.PNLb_Unit_Long_Number*three_Section_PNLvalue33.PNLb_Unit_Width_Number
                                        *three_Section_PNLvalue33.PNLb_Unit_Long*three_Section_PNLvalue33.PNLb_Unit_Width;
                  rate205:=rate205/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               end;
               if Tem_Calculate_Rate_Type1=2 then //��PNL����
               begin
                  rate205:=n221A1*N222A1*three_Section_PNLvalue33.PNLA_Long *three_Section_PNLvalue33.PNLA_Width
                           +N233B1*N234B1*three_Section_PNLvalue33.PNLb_Long *three_Section_PNLvalue33.PNLb_Width;
                  rate205:=rate205/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               END;
              //С��������PNLB��,С��������PNLA,��ֻ����
              rate206:=n221B1*N222B1*three_Section_PNLvalue33.PNLB_Unit_Long_Number*three_Section_PNLvalue33.PNLB_Unit_Width_NumbeR
                      +N231A1*N232A1*three_Section_PNLvalue33.PNLA_Unit_Long_Number*three_Section_PNLvalue33.PNLA_Unit_Width_Number;
               if Tem_Calculate_Rate_Type1=1 then  //�õ�Ԫ����
               begin
                  rate206:=N231A1*N232A1*three_Section_PNLvalue33.PNLA_Unit_Long_Number*three_Section_PNLvalue33.PNLA_Unit_Width_Number
                                          *three_Section_PNLvalue33.PNLA_Unit_Long*three_Section_PNLvalue33.PNLA_Unit_Width
                         +n221B1*N222B1*three_Section_PNLvalue33.PNLb_Unit_Long_Number*three_Section_PNLvalue33.PNLb_Unit_Width_Number
                                        *three_Section_PNLvalue33.PNLb_Unit_Long*three_Section_PNLvalue33.PNLb_Unit_Width;
                  rate206:=rate206/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               end;
               if Tem_Calculate_Rate_Type1=2 then //��PNL����
               begin
                  rate206:=N231A1*N232A1*three_Section_PNLvalue33.PNLA_Long *three_Section_PNLvalue33.PNLA_Width
                           +n221B1*N222B1*three_Section_PNLvalue33.PNLb_Long *three_Section_PNLvalue33.PNLb_Width;
                  rate206:=rate206/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               END;
              rate207:=n221B1*N222B1*three_Section_PNLvalue33.PNLB_Unit_Long_Number*three_Section_PNLvalue33.PNLB_Unit_Width_NumbeR
                       +N233A1*N234A1*three_Section_PNLvalue33.PNLA_Unit_Long_Number*three_Section_PNLvalue33.PNLA_Unit_Width_NumbeR;
              if Tem_Calculate_Rate_Type1=1 then  //�õ�Ԫ����
               begin
                  rate207:=N233A1*N234A1*three_Section_PNLvalue33.PNLA_Unit_Long_Number*three_Section_PNLvalue33.PNLA_Unit_Width_Number
                                          *three_Section_PNLvalue33.PNLA_Unit_Long*three_Section_PNLvalue33.PNLA_Unit_Width
                         +n221B1*N222B1*three_Section_PNLvalue33.PNLb_Unit_Long_Number*three_Section_PNLvalue33.PNLb_Unit_Width_Number
                                        *three_Section_PNLvalue33.PNLb_Unit_Long*three_Section_PNLvalue33.PNLb_Unit_Width;
                  rate207:=rate207/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               end;
               if Tem_Calculate_Rate_Type1=2 then //��PNL����
               begin
                  rate207:=N233A1*N234A1*three_Section_PNLvalue33.PNLA_Long *three_Section_PNLvalue33.PNLA_Width
                           +n221B1*N222B1*three_Section_PNLvalue33.PNLb_Long *three_Section_PNLvalue33.PNLb_Width;
                  rate207:=rate207/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               END;
              //С��������PNLB��,С��������PNLA,��ֻ����
              rate208:=n223B1*N224B1*three_Section_PNLvalue33.PNLB_Unit_Long_Number*three_Section_PNLvalue33.PNLB_Unit_Width_Number
                       +N231A1*N232A1*three_Section_PNLvalue33.PNLA_Unit_Long_Number*three_Section_PNLvalue33.PNLA_Unit_Width_NumbeR;

              if Tem_Calculate_Rate_Type1=1 then  //�õ�Ԫ����
               begin
                  rate208:=N231A1*N232A1*three_Section_PNLvalue33.PNLA_Unit_Long_Number*three_Section_PNLvalue33.PNLA_Unit_Width_Number
                                          *three_Section_PNLvalue33.PNLA_Unit_Long*three_Section_PNLvalue33.PNLA_Unit_Width
                         +n223B1*N224B1*three_Section_PNLvalue33.PNLb_Unit_Long_Number*three_Section_PNLvalue33.PNLb_Unit_Width_Number
                                        *three_Section_PNLvalue33.PNLb_Unit_Long*three_Section_PNLvalue33.PNLb_Unit_Width;
                  rate208:=rate208/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               end;
               if Tem_Calculate_Rate_Type1=2 then //��PNL����
               begin
                  rate208:=N231A1*N232A1*three_Section_PNLvalue33.PNLA_Long *three_Section_PNLvalue33.PNLA_Width
                           +n223B1*N224B1*three_Section_PNLvalue33.PNLb_Long *three_Section_PNLvalue33.PNLb_Width;
                  rate208:=rate208/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               END;


              rate209:=n223B1*N224B1*three_Section_PNLvalue33.PNLB_Unit_Long_Number*three_Section_PNLvalue33.PNLB_Unit_Width_Number
                       +N233A1*N234A1*three_Section_PNLvalue33.PNLA_Unit_Long_Number*three_Section_PNLvalue33.PNLA_Unit_Width_NumbeR;

              if Tem_Calculate_Rate_Type1=1 then  //�õ�Ԫ����
               begin
                  rate209:=N233A1*N234A1*three_Section_PNLvalue33.PNLA_Unit_Long_Number*three_Section_PNLvalue33.PNLA_Unit_Width_Number
                                          *three_Section_PNLvalue33.PNLA_Unit_Long*three_Section_PNLvalue33.PNLA_Unit_Width
                         +n223B1*N224B1*three_Section_PNLvalue33.PNLb_Unit_Long_Number*three_Section_PNLvalue33.PNLb_Unit_Width_Number
                                        *three_Section_PNLvalue33.PNLb_Unit_Long*three_Section_PNLvalue33.PNLb_Unit_Width;
                  rate209:=rate209/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               end;
               if Tem_Calculate_Rate_Type1=2 then //��PNL����
               begin
                  rate209:=N233A1*N234A1*three_Section_PNLvalue33.PNLA_Long *three_Section_PNLvalue33.PNLA_Width
                           +n223B1*N224B1*three_Section_PNLvalue33.PNLb_Long *three_Section_PNLvalue33.PNLb_Width;
                  rate209:=rate209/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               END;
              //С��������PNLB��,С��������PNLB,��ֻ����
              rate210:=(n221B1*N222B1+N231B1*N232B1)*three_Section_PNLvalue33.PNLB_Unit_Long_Number*three_Section_PNLvalue33.PNLB_Unit_Width_Number;
              if Tem_Calculate_Rate_Type1=1 then  //�õ�Ԫ����
               begin
                  rate210:=(n221B1*N222B1+N231B1*N232B1)*three_Section_PNLvalue33.PNLb_Unit_Long_Number*three_Section_PNLvalue33.PNLb_Unit_Width_Number
                         *three_Section_PNLvalue33.PNLb_Unit_Long*three_Section_PNLvalue33.PNLb_Unit_Width;
                  rate210:=rate210/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               end;
               if Tem_Calculate_Rate_Type1=2 then //��PNL����
               begin
                  rate210:=(n221B1*N222B1+N231B1*N232B1)
                         *three_Section_PNLvalue33.PNLb_Long *three_Section_PNLvalue33.PNLb_Width;
                  rate210:=rate210/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               END;
              rate211:=(n221B1*N222B1+N233B1*N234B1)*three_Section_PNLvalue33.PNLB_Unit_Long_Number*three_Section_PNLvalue33.PNLB_Unit_Width_Number;
              if Tem_Calculate_Rate_Type1=1 then  //�õ�Ԫ����
               begin
                  rate211:=(n221B1*N222B1+N233B1*N234B1)*three_Section_PNLvalue33.PNLb_Unit_Long_Number*three_Section_PNLvalue33.PNLb_Unit_Width_Number
                         *three_Section_PNLvalue33.PNLb_Unit_Long*three_Section_PNLvalue33.PNLb_Unit_Width;
                  rate211:=rate211/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               end;
               if Tem_Calculate_Rate_Type1=2 then //��PNL����
               begin
                  rate211:=(n221B1*N222B1+N233B1*N234B1)
                         *three_Section_PNLvalue33.PNLb_Long *three_Section_PNLvalue33.PNLb_Width;
                  rate211:=rate211/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               END;
              //С��������PNLB��,С��������PNLB,��ֻ����
              rate212:=(n223B1*N224B1+N231B1*N232B1)*three_Section_PNLvalue33.PNLB_Unit_Long_Number*three_Section_PNLvalue33.PNLB_Unit_Width_Number;
              if Tem_Calculate_Rate_Type1=1 then  //�õ�Ԫ����
               begin
                  rate212:=(n223B1*N224B1+N231B1*N232B1)*three_Section_PNLvalue33.PNLb_Unit_Long_Number*three_Section_PNLvalue33.PNLb_Unit_Width_Number
                         *three_Section_PNLvalue33.PNLb_Unit_Long*three_Section_PNLvalue33.PNLb_Unit_Width;
                  rate212:=rate212/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               end;
               if Tem_Calculate_Rate_Type1=2 then //��PNL����
               begin
                  rate212:=(n223B1*N224B1+N231B1*N232B1)
                         *three_Section_PNLvalue33.PNLb_Long *three_Section_PNLvalue33.PNLb_Width;
                  rate212:=rate212/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               END;

              rate213:=(n223B1*N224B1+N233B1*N234B1)*three_Section_PNLvalue33.PNLB_Unit_Long_Number*three_Section_PNLvalue33.PNLB_Unit_Width_Number;

              if Tem_Calculate_Rate_Type1=1 then  //�õ�Ԫ����
               begin
                  rate213:=(n223B1*N224B1+N233B1*N234B1)*three_Section_PNLvalue33.PNLb_Unit_Long_Number*three_Section_PNLvalue33.PNLb_Unit_Width_Number
                         *three_Section_PNLvalue33.PNLb_Unit_Long*three_Section_PNLvalue33.PNLb_Unit_Width;
                  rate213:=rate213/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               end;
               if Tem_Calculate_Rate_Type1=2 then //��PNL����
               begin
                  rate213:=(n223B1*N224B1+N233B1*N234B1)
                         *three_Section_PNLvalue33.PNLb_Long *three_Section_PNLvalue33.PNLb_Width;
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

           //С����PNLA���ų���   three_Section_value333.Sheet_Width
             n221A2:=0;
             n222A2:=0;
             if (three_Section_value333.Sheet_long-i21*three_Section_PNLvalue33.PNLA_Long>=three_Section_PNLvalue33.PNLA_Width)
               and (J21*three_Section_PNLvalue33.PNLA_Width>=three_Section_PNLvalue33.PNLA_Long) then
               begin
                 n221A2:=trunc((three_Section_value333.Sheet_long-i21*three_Section_PNLvalue33.PNLA_Long)/three_Section_PNLvalue33.PNLA_Width);
                 n222A2:=trunc(J21*three_Section_PNLvalue33.PNLA_Width/three_Section_PNLvalue33.PNLA_Long);
              end;
              //С����PNLA���ų���  i21*three_Section_PNLvalue33.PNLA_Long
              n231A2:=0;
              n232A2:=0;
              if (three_Section_value333.Sheet_long>=three_Section_PNLvalue33.PNLA_Width)
               and ((three_Section_value333.Sheet_Width-j21*three_Section_PNLvalue33.PNLA_Width)>=three_Section_PNLvalue33.PNLA_Long) then
               begin
                 n231A2:=trunc(three_Section_value333.Sheet_long/three_Section_PNLvalue33.PNLA_Width);
                 n232A2:=trunc((three_Section_value333.Sheet_Width-j21*three_Section_PNLvalue33.PNLA_Width)/three_Section_PNLvalue33.PNLA_Long);
              end;
              //С����PNLA���ų���
              n233A2:=0;
              n234A2:=0;
              if (three_Section_value333.Sheet_long>=three_Section_PNLvalue33.PNLA_Long)
               and ((three_Section_value333.Sheet_Width-j21*three_Section_PNLvalue33.PNLA_Width)>=three_Section_PNLvalue33.PNLA_Width) then
               begin
                 n233A2:=trunc(three_Section_value333.Sheet_long/three_Section_PNLvalue33.PNLA_Long);
                 n234A2:=trunc((three_Section_value333.Sheet_Width-j21*three_Section_PNLvalue33.PNLA_Width)/three_Section_PNLvalue33.PNLA_Width);
              end;
              //С����PNLA���ų���
              n223A2:=0;
              n224A2:=0;
              if (three_Section_value333.Sheet_long-i21*three_Section_PNLvalue33.PNLA_Long>=three_Section_PNLvalue33.PNLA_Long)
               and (J21*three_Section_PNLvalue33.PNLA_Width>=three_Section_PNLvalue33.PNLA_Width) then
               begin
                 n223A2:=trunc((three_Section_value333.Sheet_long-i21*three_Section_PNLvalue33.PNLA_Long)/three_Section_PNLvalue33.PNLA_Long);
                 n224A2:=trunc(J21*three_Section_PNLvalue33.PNLA_Width/three_Section_PNLvalue33.PNLA_Width);
              end;


              //С����PNLB���ų���
              n221B2:=0;
              n222B2:=0;
             if (three_Section_value333.Sheet_long-i21*three_Section_PNLvalue33.PNLA_Long>=three_Section_PNLvalue33.PNLB_Width)
               and (J21*three_Section_PNLvalue33.PNLA_Width>=three_Section_PNLvalue33.PNLB_Long) then
               begin
                 n221B2:=trunc((three_Section_value333.Sheet_long-i21*three_Section_PNLvalue33.PNLA_Long)/three_Section_PNLvalue33.PNLB_Width);
                 n222B2:=trunc(J21*three_Section_PNLvalue33.PNLA_Width/three_Section_PNLvalue33.PNLB_Long);
              end;
              //С����PNLB���ų���
              n231B2:=0;
              n232B2:=0;
              if (three_Section_value333.Sheet_long>=three_Section_PNLvalue33.PNLB_Width)
               and ((three_Section_value333.Sheet_Width-j21*three_Section_PNLvalue33.PNLA_Width)>=three_Section_PNLvalue33.PNLB_Long) then
               begin
                 n231B2:=trunc(three_Section_value333.Sheet_long/three_Section_PNLvalue33.PNLB_Width);
                 n232B2:=trunc((three_Section_value333.Sheet_Width-j21*three_Section_PNLvalue33.PNLA_Width)/three_Section_PNLvalue33.PNLB_Long);
              end;
              //С����PNLB���ų���
              n233B2:=0;
              n234B2:=0;
              if (three_Section_value333.Sheet_long>=three_Section_PNLvalue33.PNLB_Long)
               and ((three_Section_value333.Sheet_Width-j21*three_Section_PNLvalue33.PNLA_Width)>=three_Section_PNLvalue33.PNLB_Width) then
               begin
                 n233B2:=trunc(three_Section_value333.Sheet_long/three_Section_PNLvalue33.PNLB_Long);
                 n234B2:=trunc((three_Section_value333.Sheet_Width-j21*three_Section_PNLvalue33.PNLA_Width)/three_Section_PNLvalue33.PNLB_Width);
              end;
              //С����PNLB���ų���
              n223B2:=0;
              n224B2:=0;
              if (three_Section_value333.Sheet_long-i21*three_Section_PNLvalue33.PNLA_Long>=three_Section_PNLvalue33.PNLB_Long)
               and (J21*three_Section_PNLvalue33.PNLA_Width>=three_Section_PNLvalue33.PNLB_Width) then
               begin
                 n223B2:=trunc((three_Section_value333.Sheet_long-i21*three_Section_PNLvalue33.PNLA_Long)/three_Section_PNLvalue33.PNLB_Long);
                 n224B2:=trunc(J21*three_Section_PNLvalue33.PNLA_Width/three_Section_PNLvalue33.PNLB_Width);
              end;
              //С��������PNLA��,С��������PNLA,��ֻһ��

              rate221:=(n221A2*N222A2+N233A2*N234a2)*three_Section_PNLvalue33.PNLA_Unit_Long_Number*three_Section_PNLvalue33.PNLA_Unit_Width_Number;
              if Tem_Calculate_Rate_Type1=1 then  //�õ�Ԫ����
               begin
                  rate221:=(n221A2*N222A2+N233A2*N234a2)*three_Section_PNLvalue33.PNLA_Unit_Long_Number*three_Section_PNLvalue33.PNLA_Unit_Width_Number
                                          *three_Section_PNLvalue33.PNLA_Unit_Long*three_Section_PNLvalue33.PNLA_Unit_Width ;
                  rate221:=rate221/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               end;
               if Tem_Calculate_Rate_Type1=2 then //��PNL����
               begin
                  rate221:=(n221A2*N222A2+N233A2*N234a2)*three_Section_PNLvalue33.PNLA_Long *three_Section_PNLvalue33.PNLA_Width;
                  rate221:=rate221/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               END;
                //С��������PNLA��,С��������PNLA,��������
              rate222:=(n223A2*N224A2+N231A2*N232a2)*three_Section_PNLvalue33.PNLA_Unit_Long_Number*three_Section_PNLvalue33.PNLA_Unit_Width_Number;
              if Tem_Calculate_Rate_Type1=1 then  //�õ�Ԫ����
               begin
                  rate222:=(n223A2*N224A2+N231A2*N232a2)*three_Section_PNLvalue33.PNLA_Unit_Long_Number*three_Section_PNLvalue33.PNLA_Unit_Width_Number
                                          *three_Section_PNLvalue33.PNLA_Unit_Long*three_Section_PNLvalue33.PNLA_Unit_Width;
                  rate222:=rate222/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               end;
               if Tem_Calculate_Rate_Type1=2 then //��PNL����
               begin
                  rate222:=(n223A2*N224A2+N231A2*N232a2)*three_Section_PNLvalue33.PNLA_Long *three_Section_PNLvalue33.PNLA_Width ;
                  rate222:=rate222/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               END;
              rate223:=(n223A2*N224A2+N233A2*N234a2)*three_Section_PNLvalue33.PNLA_Unit_Long_Number*three_Section_PNLvalue33.PNLA_Unit_Width_Number;
              if Tem_Calculate_Rate_Type1=1 then  //�õ�Ԫ����
               begin
                  rate223:=(n223A2*N224A2+N233A2*N234a2)*three_Section_PNLvalue33.PNLA_Unit_Long_Number*three_Section_PNLvalue33.PNLA_Unit_Width_Number
                                          *three_Section_PNLvalue33.PNLA_Unit_Long*three_Section_PNLvalue33.PNLA_Unit_Width ;
                  rate223:=rate223/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               end;
               if Tem_Calculate_Rate_Type1=2 then //��PNL����
               begin
                  rate223:=(n223A2*N224A2+N233A2*N234a2)*three_Section_PNLvalue33.PNLA_Long *three_Section_PNLvalue33.PNLA_Width;
                  rate223:=rate223/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               END;




               //С��������PNLA��,С��������PNLb,��ֻ����
              rate224:=n221A2*N222A2*three_Section_PNLvalue33.PNLA_Unit_Long_Number*three_Section_PNLvalue33.PNLA_Unit_Width_Number
                     +N231B2*N232B2*three_Section_PNLvalue33.PNLb_Unit_Long_Number*three_Section_PNLvalue33.PNLb_Unit_Width_Number;
               if Tem_Calculate_Rate_Type1=1 then  //�õ�Ԫ����
               begin
                  rate224:=n221A2*N222A2*three_Section_PNLvalue33.PNLA_Unit_Long_Number*three_Section_PNLvalue33.PNLA_Unit_Width_Number
                                          *three_Section_PNLvalue33.PNLA_Unit_Long*three_Section_PNLvalue33.PNLA_Unit_Width
                         +N231B2*N232B2*three_Section_PNLvalue33.PNLb_Unit_Long_Number*three_Section_PNLvalue33.PNLb_Unit_Width_Number
                                        *three_Section_PNLvalue33.PNLb_Unit_Long*three_Section_PNLvalue33.PNLb_Unit_Width;
                  rate224:=rate224/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               end;
               if Tem_Calculate_Rate_Type1=2 then //��PNL����
               begin
                  rate224:=n221A2*N222A2*three_Section_PNLvalue33.PNLA_Long *three_Section_PNLvalue33.PNLA_Width
                           +N231B2*N232B2*three_Section_PNLvalue33.PNLb_Long *three_Section_PNLvalue33.PNLb_Width;
                  rate224:=rate224/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               END;

              rate225:=n221A2*N222A2*three_Section_PNLvalue33.PNLA_Unit_Long_Number*three_Section_PNLvalue33.PNLA_Unit_Width_Number
                     +N233B2*N234B2*three_Section_PNLvalue33.PNLb_Unit_Long_Number*three_Section_PNLvalue33.PNLb_Unit_Width_Number;
              if Tem_Calculate_Rate_Type1=1 then  //�õ�Ԫ����
               begin
                  rate225:=n221A2*N222A2*three_Section_PNLvalue33.PNLA_Unit_Long_Number*three_Section_PNLvalue33.PNLA_Unit_Width_Number
                                          *three_Section_PNLvalue33.PNLA_Unit_Long*three_Section_PNLvalue33.PNLA_Unit_Width
                         +N233B2*N234B2*three_Section_PNLvalue33.PNLb_Unit_Long_Number*three_Section_PNLvalue33.PNLb_Unit_Width_Number
                                        *three_Section_PNLvalue33.PNLb_Unit_Long*three_Section_PNLvalue33.PNLb_Unit_Width;
                  rate225:=rate225/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               end;
               if Tem_Calculate_Rate_Type1=2 then //��PNL����
               begin
                  rate225:=n221A2*N222A2*three_Section_PNLvalue33.PNLA_Long *three_Section_PNLvalue33.PNLA_Width
                           +N233B2*N234B2*three_Section_PNLvalue33.PNLb_Long *three_Section_PNLvalue33.PNLb_Width;
                  rate225:=rate225/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               END;




              //С��������PNLB��,С��������PNLA,��ֻ����
              rate226:=n221B2*N222B2*three_Section_PNLvalue33.PNLb_Unit_Long_Number*three_Section_PNLvalue33.PNLb_Unit_Width_Number
                       +N231A2*N232A2*three_Section_PNLvalue33.PNLA_Unit_Long_Number*three_Section_PNLvalue33.PNLA_Unit_Width_Number;
               if Tem_Calculate_Rate_Type1=1 then  //�õ�Ԫ����
               begin
                  rate226:=N231A2*N232A2*three_Section_PNLvalue33.PNLA_Unit_Long_Number*three_Section_PNLvalue33.PNLA_Unit_Width_Number
                                          *three_Section_PNLvalue33.PNLA_Unit_Long*three_Section_PNLvalue33.PNLA_Unit_Width
                         +n221B2*N222B2*three_Section_PNLvalue33.PNLb_Unit_Long_Number*three_Section_PNLvalue33.PNLb_Unit_Width_Number
                                        *three_Section_PNLvalue33.PNLb_Unit_Long*three_Section_PNLvalue33.PNLb_Unit_Width;
                  rate226:=rate226/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               end;
               if Tem_Calculate_Rate_Type1=2 then //��PNL����
               begin
                  rate226:=N231A2*N232A2*three_Section_PNLvalue33.PNLA_Long *three_Section_PNLvalue33.PNLA_Width
                           +n221B2*N222B2*three_Section_PNLvalue33.PNLb_Long *three_Section_PNLvalue33.PNLb_Width;
                  rate226:=rate226/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               END;

              rate227:=n221B2*N222B2*three_Section_PNLvalue33.PNLb_Unit_Long_Number*three_Section_PNLvalue33.PNLb_Unit_Width_Number
                       +N233A2*N234A2*three_Section_PNLvalue33.PNLA_Unit_Long_Number*three_Section_PNLvalue33.PNLA_Unit_Width_Number;
              if Tem_Calculate_Rate_Type1=1 then  //�õ�Ԫ����
               begin
                  rate227:=N233A2*N234A2*three_Section_PNLvalue33.PNLA_Unit_Long_Number*three_Section_PNLvalue33.PNLA_Unit_Width_Number
                                          *three_Section_PNLvalue33.PNLA_Unit_Long*three_Section_PNLvalue33.PNLA_Unit_Width
                         +n221B2*N222B2*three_Section_PNLvalue33.PNLb_Unit_Long_Number*three_Section_PNLvalue33.PNLb_Unit_Width_Number
                                        *three_Section_PNLvalue33.PNLb_Unit_Long*three_Section_PNLvalue33.PNLb_Unit_Width;
                  rate227:=rate227/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               end;
               if Tem_Calculate_Rate_Type1=2 then //��PNL����
               begin
                  rate227:=N233A2*N234A2*three_Section_PNLvalue33.PNLA_Long *three_Section_PNLvalue33.PNLA_Width
                           +n221B2*N222B2*three_Section_PNLvalue33.PNLb_Long *three_Section_PNLvalue33.PNLb_Width;
                  rate227:=rate227/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               END;

              //С��������PNLB��,С��������PNLA,��ֻ����
              rate228:=n223B2*N224B2*three_Section_PNLvalue33.PNLb_Unit_Long_Number*three_Section_PNLvalue33.PNLb_Unit_Width_Number
                       +N231A2*N232A2*three_Section_PNLvalue33.PNLA_Unit_Long_Number*three_Section_PNLvalue33.PNLA_Unit_Width_Number;
              if Tem_Calculate_Rate_Type1=1 then  //�õ�Ԫ����
               begin
                  rate228:=N231A2*N232A2*three_Section_PNLvalue33.PNLA_Unit_Long_Number*three_Section_PNLvalue33.PNLA_Unit_Width_Number
                                          *three_Section_PNLvalue33.PNLA_Unit_Long*three_Section_PNLvalue33.PNLA_Unit_Width
                         +n223B2*N224B2*three_Section_PNLvalue33.PNLb_Unit_Long_Number*three_Section_PNLvalue33.PNLb_Unit_Width_Number
                                        *three_Section_PNLvalue33.PNLb_Unit_Long*three_Section_PNLvalue33.PNLb_Unit_Width;
                  rate228:=rate228/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               end;
               if Tem_Calculate_Rate_Type1=2 then //��PNL����
               begin
                  rate228:=N231A2*N232A2*three_Section_PNLvalue33.PNLA_Long *three_Section_PNLvalue33.PNLA_Width
                           +n223B2*N224B2*three_Section_PNLvalue33.PNLb_Long *three_Section_PNLvalue33.PNLb_Width;
                  rate228:=rate228/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               END;

              rate229:=n223B2*N224B2*three_Section_PNLvalue33.PNLb_Unit_Long_Number*three_Section_PNLvalue33.PNLb_Unit_Width_Number
                       +N233A2*N234A2*three_Section_PNLvalue33.PNLA_Unit_Long_Number*three_Section_PNLvalue33.PNLA_Unit_Width_Number;
              if Tem_Calculate_Rate_Type1=1 then  //�õ�Ԫ����
               begin
                  rate229:=N233A2*N234A2*three_Section_PNLvalue33.PNLA_Unit_Long_Number*three_Section_PNLvalue33.PNLA_Unit_Width_Number
                                          *three_Section_PNLvalue33.PNLA_Unit_Long*three_Section_PNLvalue33.PNLA_Unit_Width
                         +n223B2*N224B2*three_Section_PNLvalue33.PNLb_Unit_Long_Number*three_Section_PNLvalue33.PNLb_Unit_Width_Number
                                        *three_Section_PNLvalue33.PNLb_Unit_Long*three_Section_PNLvalue33.PNLb_Unit_Width;
                  rate229:=rate229/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               end;
               if Tem_Calculate_Rate_Type1=2 then //��PNL����
               begin
                  rate229:=N233A2*N234A2*three_Section_PNLvalue33.PNLA_Long *three_Section_PNLvalue33.PNLA_Width
                           +n223B2*N224B2*three_Section_PNLvalue33.PNLb_Long *three_Section_PNLvalue33.PNLb_Width;
                  rate229:=rate229/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               END;

              //С��������PNLB��,С��������PNLB,��ֻ����
              rate230:=(n221B2*N222B2+N231B2*N232B2)*three_Section_PNLvalue33.PNLB_Unit_Long_Number*three_Section_PNLvalue33.PNLB_Unit_Width_Number;
              if Tem_Calculate_Rate_Type1=1 then  //�õ�Ԫ����
               begin
                  rate230:=(n221B2*N222B2+N231B2*N232B2)*three_Section_PNLvalue33.PNLb_Unit_Long_Number*three_Section_PNLvalue33.PNLb_Unit_Width_Number
                                        *three_Section_PNLvalue33.PNLb_Unit_Long*three_Section_PNLvalue33.PNLb_Unit_Width;
                  rate230:=rate230/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               end;
               if Tem_Calculate_Rate_Type1=2 then //��PNL����
               begin
                  rate230:=(n221B2*N222B2+N231B2*N232B2)*three_Section_PNLvalue33.PNLb_Long *three_Section_PNLvalue33.PNLb_Width;
                  rate230:=rate230/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               END;

              rate231:=(n221B2*N222B2+N233B2*N234B2)*three_Section_PNLvalue33.PNLB_Unit_Long_Number*three_Section_PNLvalue33.PNLB_Unit_Width_Number;
              if Tem_Calculate_Rate_Type1=1 then  //�õ�Ԫ����
               begin
                  rate231:=(n221B2*N222B2+N233B2*N234B2)*three_Section_PNLvalue33.PNLb_Unit_Long_Number*three_Section_PNLvalue33.PNLb_Unit_Width_Number
                                        *three_Section_PNLvalue33.PNLb_Unit_Long*three_Section_PNLvalue33.PNLb_Unit_Width;
                  rate231:=rate231/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               end;
               if Tem_Calculate_Rate_Type1=2 then //��PNL����
               begin
                  rate231:=(n221B2*N222B2+N233B2*N234B2)*three_Section_PNLvalue33.PNLb_Long *three_Section_PNLvalue33.PNLb_Width;
                  rate231:=rate231/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               END;

              //С��������PNLB��,С��������PNLB,��ֻ����
              rate232:=(n223B2*N224B2+N231B2*N232B2)*three_Section_PNLvalue33.PNLB_Unit_Long_Number*three_Section_PNLvalue33.PNLB_Unit_Width_Number;
              if Tem_Calculate_Rate_Type1=1 then  //�õ�Ԫ����
               begin
                  rate232:=(n223B2*N224B2+N231B2*N232B2)*three_Section_PNLvalue33.PNLb_Unit_Long_Number*three_Section_PNLvalue33.PNLb_Unit_Width_Number
                                        *three_Section_PNLvalue33.PNLb_Unit_Long*three_Section_PNLvalue33.PNLb_Unit_Width;
                  rate232:=rate232/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               end;
               if Tem_Calculate_Rate_Type1=2 then //��PNL����
               begin
                  rate223:=(n223B2*N224B2+N231B2*N232B2)*three_Section_PNLvalue33.PNLb_Long *three_Section_PNLvalue33.PNLb_Width;
                  rate232:=rate232/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               END;

              rate233:=(n223B2*N224B2+N233B2*N234B2)*three_Section_PNLvalue33.PNLB_Unit_Long_Number*three_Section_PNLvalue33.PNLB_Unit_Width_Number;
              if Tem_Calculate_Rate_Type1=1 then  //�õ�Ԫ����
               begin
                  rate233:=(n223B2*N224B2+N233B2*N234B2)*three_Section_PNLvalue33.PNLb_Unit_Long_Number*three_Section_PNLvalue33.PNLb_Unit_Width_Number
                                        *three_Section_PNLvalue33.PNLb_Unit_Long*three_Section_PNLvalue33.PNLb_Unit_Width;
                  rate233:=rate233/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
               end;
               if Tem_Calculate_Rate_Type1=2 then //��PNL����
               begin
                  rate233:=(n223B2*N224B2+N233B2*N234B2)*three_Section_PNLvalue33.PNLb_Long *three_Section_PNLvalue33.PNLb_Width;
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
                tempnl_sheet22.Section_LongA:=three_Section_PNLvalue33.PNLA_Long;
                tempnl_sheet22.Section_WidthA:=three_Section_PNLvalue33.PNLA_Width;
                tempnl_sheet22.Section_Long_NumberA:=i21;
                tempnl_sheet22.Section_Width_NumberA:=j21;
                tempnl_sheet22.Section_LongB:=three_Section_PNLvalue33.PNLb_Width;
                tempnl_sheet22.Section_WidthB:=three_Section_PNLvalue33.PNLb_Long;
                tempnl_sheet22.Section_Long_NumberB:=n223B2;
                tempnl_sheet22.Section_Width_NumberB:=N224B2;
                tempnl_sheet22.Section_LongB:=three_Section_PNLvalue33.PNLb_Width;
                tempnl_sheet22.Section_WidthB:=three_Section_PNLvalue33.PNLb_Long;
                tempnl_sheet22.Section_Long_NumberB:=N233B2;
                tempnl_sheet22.Section_Width_NumberB:=N234B2;
                tempnl_sheet22.Section_Unit_Number:=(n223B2*N224B2+N233B2*N234B2)*three_Section_PNLvalue33.PNLB_Unit_Long_Number*three_Section_PNLvalue33.PNLB_Unit_Width_Number+I21*J21*three_Section_PNLvalue33.PNLA_Unit_Long_Number*three_Section_PNLvalue33.PNLA_Unit_Width_Number;
             end;
             if  rate232=max21 then //(n223B2*N224B2+N231B2*N232B2)
             begin  //N��ĵ���λ���ֱ�ʾ�������Ƿ����,��Ϊ3,4�����,�������ĸ��ʾ�ǵ�һ�ֻ��ǵڶ����ŷ�,A��ʾ��һ���ŷ�;B��ʾ�ڶ����ŷ�
                array_type2:=32;   //С��������PNLB��;С��������PNLB��
                tempnl_sheet22.Section_LongA:=three_Section_PNLvalue33.PNLA_Long;
                tempnl_sheet22.Section_WidthA:=three_Section_PNLvalue33.PNLA_Width;
                tempnl_sheet22.Section_Long_NumberA:=i21;
                tempnl_sheet22.Section_Width_NumberA:=j21;
                tempnl_sheet22.Section_LongB:=three_Section_PNLvalue33.PNLb_Width;
                tempnl_sheet22.Section_WidthB:=three_Section_PNLvalue33.PNLb_Long;
                tempnl_sheet22.Section_Long_NumberB:=n223B2;
                tempnl_sheet22.Section_Width_NumberB:=N224B2;
                tempnl_sheet22.Section_LongB:=three_Section_PNLvalue33.PNLb_Long;
                tempnl_sheet22.Section_WidthB:=three_Section_PNLvalue33.PNLb_Width;
                tempnl_sheet22.Section_Long_NumberB:=N231B2;
                tempnl_sheet22.Section_Width_NumberB:=N232B2;
                tempnl_sheet22.Section_Unit_Number:=(n223B2*N224B2+N231B2*N232B2)*three_Section_PNLvalue33.PNLB_Unit_Long_Number*three_Section_PNLvalue33.PNLB_Unit_Width_Number+I21*J21*three_Section_PNLvalue33.PNLA_Unit_Long_Number*three_Section_PNLvalue33.PNLA_Unit_Width_Number;
             end;
             //С��������PNLB��,С��������PNLB,��ֻ����
             if  rate230=max21 then // rate230:=  (n221B2*N222B2+N231B2*N232B2)
             begin  //N��ĵ���λ���ֱ�ʾ�������Ƿ����,��Ϊ3,4�����,�������ĸ��ʾ�ǵ�һ�ֻ��ǵڶ����ŷ�,A��ʾ��һ���ŷ�;B��ʾ�ڶ����ŷ�
                array_type2:=30;   //С��������PNLB��;С��������PNLB��
                tempnl_sheet22.Section_LongA:=three_Section_PNLvalue33.PNLA_Long;
                tempnl_sheet22.Section_WidthA:=three_Section_PNLvalue33.PNLA_Width;
                tempnl_sheet22.Section_Long_NumberA:=i21;
                tempnl_sheet22.Section_Width_NumberA:=j21;
                tempnl_sheet22.Section_LongB:=three_Section_PNLvalue33.PNLb_Long;
                tempnl_sheet22.Section_WidthB:=three_Section_PNLvalue33.PNLb_Width;
                tempnl_sheet22.Section_Long_NumberB:=n221B2;
                tempnl_sheet22.Section_Width_NumberB:=N222B2;
                tempnl_sheet22.Section_LongB:=three_Section_PNLvalue33.PNLb_Long;
                tempnl_sheet22.Section_WidthB:=three_Section_PNLvalue33.PNLb_Width;
                tempnl_sheet22.Section_Long_NumberB:=N231B2;
                tempnl_sheet22.Section_Width_NumberB:=N232B2;
                tempnl_sheet22.Section_Unit_Number:=(n221B2*N222B2+N231B2*N232B2)*three_Section_PNLvalue33.PNLB_Unit_Long_Number*three_Section_PNLvalue33.PNLB_Unit_Width_Number+I21*J21*three_Section_PNLvalue33.PNLA_Unit_Long_Number*three_Section_PNLvalue33.PNLA_Unit_Width_Number;
             end;
             if  rate231=max21 then //rate231:=(n221B2*N222B2+N233B2*N234B2)
             begin  //N��ĵ���λ���ֱ�ʾ�������Ƿ����,��Ϊ3,4�����,�������ĸ��ʾ�ǵ�һ�ֻ��ǵڶ����ŷ�,A��ʾ��һ���ŷ�;B��ʾ�ڶ����ŷ�
                array_type2:=31;   //С��������PNLB��;С��������PNLB��
                tempnl_sheet22.Section_LongA:=three_Section_PNLvalue33.PNLA_Long;
                tempnl_sheet22.Section_WidthA:=three_Section_PNLvalue33.PNLA_Width;
                tempnl_sheet22.Section_Long_NumberA:=i21;
                tempnl_sheet22.Section_Width_NumberA:=j21;
                tempnl_sheet22.Section_LongB:=three_Section_PNLvalue33.PNLb_Long ;
                tempnl_sheet22.Section_WidthB:=three_Section_PNLvalue33.PNLb_Width;
                tempnl_sheet22.Section_Long_NumberB:=n221B2;
                tempnl_sheet22.Section_Width_NumberB:=N222B2;
                tempnl_sheet22.Section_LongB:=three_Section_PNLvalue33.PNLb_Long;
                tempnl_sheet22.Section_WidthB:=three_Section_PNLvalue33.PNLb_Width;
                tempnl_sheet22.Section_Long_NumberB:=N231B2;
                tempnl_sheet22.Section_Width_NumberB:=N232B2;
                tempnl_sheet22.Section_Unit_Number:=(n221B2*N222B2+N233B2*N234B2)*three_Section_PNLvalue33.PNLB_Unit_Long_Number*three_Section_PNLvalue33.PNLB_Unit_Width_Number+I21*J21*three_Section_PNLvalue33.PNLA_Unit_Long_Number*three_Section_PNLvalue33.PNLA_Unit_Width_Number;
             end;
            //С��������PNLB��,С��������PNLA,��ֻ����
            if  rate229=max21 then //rate229:=n223B2*N224B2+N233A2*N234A2
             begin  //N��ĵ���λ���ֱ�ʾ�������Ƿ����,��Ϊ3,4�����,�������ĸ��ʾ�ǵ�һ�ֻ��ǵڶ����ŷ�,A��ʾ��һ���ŷ�;B��ʾ�ڶ����ŷ�
                array_type2:=29;   //С��������PNLB��;С��������PNLB��
                tempnl_sheet22.Section_LongA:=three_Section_PNLvalue33.PNLA_Long;
                tempnl_sheet22.Section_WidthA:=three_Section_PNLvalue33.PNLA_Width;
                tempnl_sheet22.Section_Long_NumberA:=i21;
                tempnl_sheet22.Section_Width_NumberA:=j21;
                tempnl_sheet22.Section_LongB:=three_Section_PNLvalue33.PNLb_Width;
                tempnl_sheet22.Section_WidthB:=three_Section_PNLvalue33.PNLb_Long;
                tempnl_sheet22.Section_Long_NumberB:=n223B2;
                tempnl_sheet22.Section_Width_NumberB:=N224B2;
                tempnl_sheet22.Section_LongB:=three_Section_PNLvalue33.PNLa_Width;
                tempnl_sheet22.Section_WidthB:=three_Section_PNLvalue33.PNLa_Long;
                tempnl_sheet22.Section_Long_NumberB:=N233A2;
                tempnl_sheet22.Section_Width_NumberB:=N234A2;
               tempnl_sheet22.Section_Unit_Number:=N233A2*N234A2*three_Section_PNLvalue33.PNLa_Unit_Long_Number*three_Section_PNLvalue33.PNLa_Unit_Width_Number+n223B2*N224B2*three_Section_PNLvalue33.PNLB_Unit_Long_Number*three_Section_PNLvalue33.PNLB_Unit_Width_Number+I21*J21*three_Section_PNLvalue33.PNLA_Unit_Long_Number*three_Section_PNLvalue33.PNLA_Unit_Width_Number;
             end;

             if  rate228=max21 then //rate228:=n223B2*N224B2+N231A2*N232A2
             begin  //N��ĵ���λ���ֱ�ʾ�������Ƿ����,��Ϊ3,4�����,�������ĸ��ʾ�ǵ�һ�ֻ��ǵڶ����ŷ�,A��ʾ��һ���ŷ�;B��ʾ�ڶ����ŷ�
                array_type2:=28;   //С��������PNLB��;С��������PNLB��
                tempnl_sheet22.Section_LongA:=three_Section_PNLvalue33.PNLA_Long;
                tempnl_sheet22.Section_WidthA:=three_Section_PNLvalue33.PNLA_Width;
                tempnl_sheet22.Section_Long_NumberA:=i21;
                tempnl_sheet22.Section_Width_NumberA:=j21;
                tempnl_sheet22.Section_LongB:=three_Section_PNLvalue33.PNLb_Width;
                tempnl_sheet22.Section_WidthB:=three_Section_PNLvalue33.PNLb_Long;
                tempnl_sheet22.Section_Long_NumberB:=n223B2;
                tempnl_sheet22.Section_Width_NumberB:=N224B2;
                tempnl_sheet22.Section_LongB:=three_Section_PNLvalue33.PNLa_Long;
                tempnl_sheet22.Section_WidthB:=three_Section_PNLvalue33.PNLa_Width;
                tempnl_sheet22.Section_Long_NumberB:=N231A2;
                tempnl_sheet22.Section_Width_NumberB:=N232A2;
                tempnl_sheet22.Section_Unit_Number:=N231A2*N232A2*three_Section_PNLvalue33.PNLa_Unit_Long_Number*three_Section_PNLvalue33.PNLa_Unit_Width_Number
                                                   +n223B2*N224B2*three_Section_PNLvalue33.PNLB_Unit_Long_Number*three_Section_PNLvalue33.PNLB_Unit_Width_Number
                                                   +I21*J21*three_Section_PNLvalue33.PNLA_Unit_Long_Number*three_Section_PNLvalue33.PNLA_Unit_Width_Number;
             end;

             //С��������PNLB��,С��������PNLA,��ֻ����
             if  rate227=max21 then //rate227:=n221B2*N222B2+N233A2*N234A2
             begin  //N��ĵ���λ���ֱ�ʾ�������Ƿ����,��Ϊ3,4�����,�������ĸ��ʾ�ǵ�һ�ֻ��ǵڶ����ŷ�,A��ʾ��һ���ŷ�;B��ʾ�ڶ����ŷ�
                array_type2:=27;   //С��������PNLB��;С��������PNLB��
                tempnl_sheet22.Section_LongA:=three_Section_PNLvalue33.PNLA_Long;
                tempnl_sheet22.Section_WidthA:=three_Section_PNLvalue33.PNLA_Width;
                tempnl_sheet22.Section_Long_NumberA:=i21;
                tempnl_sheet22.Section_Width_NumberA:=j21;
                tempnl_sheet22.Section_LongB:=three_Section_PNLvalue33.PNLb_Long;
                tempnl_sheet22.Section_WidthB:=three_Section_PNLvalue33.PNLb_Width;
                tempnl_sheet22.Section_Long_NumberB:=n221B2;
                tempnl_sheet22.Section_Width_NumberB:=N222B2;
                tempnl_sheet22.Section_LongB:=three_Section_PNLvalue33.PNLa_Width;
                tempnl_sheet22.Section_WidthB:=three_Section_PNLvalue33.PNLa_Long;
                tempnl_sheet22.Section_Long_NumberB:=N233A2;
                tempnl_sheet22.Section_Width_NumberB:=N234A2;
                tempnl_sheet22.Section_Unit_Number:=N233A2*N234A2*three_Section_PNLvalue33.PNLa_Unit_Long_Number*three_Section_PNLvalue33.PNLa_Unit_Width_Number
                                                   +n221B2*N222B2*three_Section_PNLvalue33.PNLB_Unit_Long_Number*three_Section_PNLvalue33.PNLB_Unit_Width_Number
                                                   +I21*J21*three_Section_PNLvalue33.PNLA_Unit_Long_Number*three_Section_PNLvalue33.PNLA_Unit_Width_Number;
             end;
             if  rate226=max21 then //rate226:=n221B2*N222B2+N231A2*N232A2
             begin  //N��ĵ���λ���ֱ�ʾ�������Ƿ����,��Ϊ3,4�����,�������ĸ��ʾ�ǵ�һ�ֻ��ǵڶ����ŷ�,A��ʾ��һ���ŷ�;B��ʾ�ڶ����ŷ�
                array_type2:=26;   //С��������PNLB��;С��������PNLB��
                tempnl_sheet22.Section_LongA:=three_Section_PNLvalue33.PNLA_Long;
                tempnl_sheet22.Section_WidthA:=three_Section_PNLvalue33.PNLA_Width;
                tempnl_sheet22.Section_Long_NumberA:=i21;
                tempnl_sheet22.Section_Width_NumberA:=j21;
                tempnl_sheet22.Section_LongB:=three_Section_PNLvalue33.PNLb_Long;
                tempnl_sheet22.Section_WidthB:=three_Section_PNLvalue33.PNLb_Width;
                tempnl_sheet22.Section_Long_NumberB:=n221B2;
                tempnl_sheet22.Section_Width_NumberB:=N222B2;
                tempnl_sheet22.Section_LongB:=three_Section_PNLvalue33.PNLa_Long;
                tempnl_sheet22.Section_WidthB:=three_Section_PNLvalue33.PNLa_Width;
                tempnl_sheet22.Section_Long_NumberB:=N231A2;
                tempnl_sheet22.Section_Width_NumberB:=N232A2;
                tempnl_sheet22.Section_Unit_Number:=N231A2*N232A2*three_Section_PNLvalue33.PNLa_Unit_Long_Number*three_Section_PNLvalue33.PNLa_Unit_Width_Number
                                                   +n221B2*N222B2*three_Section_PNLvalue33.PNLB_Unit_Long_Number*three_Section_PNLvalue33.PNLB_Unit_Width_Number
                                                   +I21*J21*three_Section_PNLvalue33.PNLA_Unit_Long_Number*three_Section_PNLvalue33.PNLA_Unit_Width_Number;
             end;
             //С��������PNLA��,С��������PNLb,��ֻ����
             if  rate225=max21 then // rate225:=n221A2*N222A2+N233B2*N234B2
             begin  //N��ĵ���λ���ֱ�ʾ�������Ƿ����,��Ϊ3,4�����,�������ĸ��ʾ�ǵ�һ�ֻ��ǵڶ����ŷ�,A��ʾ��һ���ŷ�;B��ʾ�ڶ����ŷ�
                array_type2:=25;   //С��������PNLB��;С��������PNLB��
                tempnl_sheet22.Section_LongA:=three_Section_PNLvalue33.PNLA_Long;
                tempnl_sheet22.Section_WidthA:=three_Section_PNLvalue33.PNLA_Width;
                tempnl_sheet22.Section_Long_NumberA:=i21;
                tempnl_sheet22.Section_Width_NumberA:=j21;
                tempnl_sheet22.Section_LongB:=three_Section_PNLvalue33.PNLa_Long ;
                tempnl_sheet22.Section_WidthB:=three_Section_PNLvalue33.PNLa_Width ;
                tempnl_sheet22.Section_Long_NumberB:=n221A2;
                tempnl_sheet22.Section_Width_NumberB:=N222A2;
                tempnl_sheet22.Section_LongB:=three_Section_PNLvalue33.PNLb_Width;
                tempnl_sheet22.Section_WidthB:=three_Section_PNLvalue33.PNLb_Long;
                tempnl_sheet22.Section_Long_NumberB:=N233B2;
                tempnl_sheet22.Section_Width_NumberB:=N234B2;
                tempnl_sheet22.Section_Unit_Number:=n221A2*N222A2*three_Section_PNLvalue33.PNLa_Unit_Long_Number*three_Section_PNLvalue33.PNLa_Unit_Width_Number
                                                   +N233B2*N234B2*three_Section_PNLvalue33.PNLB_Unit_Long_Number*three_Section_PNLvalue33.PNLB_Unit_Width_Number
                                                   +I21*J21*three_Section_PNLvalue33.PNLA_Unit_Long_Number*three_Section_PNLvalue33.PNLA_Unit_Width_Number;
             end;
             if  rate224=max21 then // rate224:=n221A2*N222A2+N231B2*N232B2
             begin  //N��ĵ���λ���ֱ�ʾ�������Ƿ����,��Ϊ3,4�����,�������ĸ��ʾ�ǵ�һ�ֻ��ǵڶ����ŷ�,A��ʾ��һ���ŷ�;B��ʾ�ڶ����ŷ�
                array_type2:=24;   //С��������PNLB��;С��������PNLB��
                tempnl_sheet22.Section_LongA:=three_Section_PNLvalue33.PNLA_Long;
                tempnl_sheet22.Section_WidthA:=three_Section_PNLvalue33.PNLA_Width;
                tempnl_sheet22.Section_Long_NumberA:=i21;
                tempnl_sheet22.Section_Width_NumberA:=j21;
                tempnl_sheet22.Section_LongB:=three_Section_PNLvalue33.PNLa_Long;
                tempnl_sheet22.Section_WidthB:=three_Section_PNLvalue33.PNLa_Width;
                tempnl_sheet22.Section_Long_NumberB:=n221A2;
                tempnl_sheet22.Section_Width_NumberB:=N222A2;
                tempnl_sheet22.Section_LongB:=three_Section_PNLvalue33.PNLb_Long;
                tempnl_sheet22.Section_WidthB:=three_Section_PNLvalue33.PNLb_Width;
                tempnl_sheet22.Section_Long_NumberB:=N231B2;
                tempnl_sheet22.Section_Width_NumberB:=N232B2;
                tempnl_sheet22.Section_Unit_Number:=n221A2*N222A2*three_Section_PNLvalue33.PNLa_Unit_Long_Number*three_Section_PNLvalue33.PNLa_Unit_Width_Number
                                                   +N231B2*N232B2*three_Section_PNLvalue33.PNLB_Unit_Long_Number*three_Section_PNLvalue33.PNLB_Unit_Width_Number
                                                   +I21*J21*three_Section_PNLvalue33.PNLA_Unit_Long_Number*three_Section_PNLvalue33.PNLA_Unit_Width_Number;
             end;
             if  rate223=max21 then //rate223:=(n223A2*N224A2+N233A2*N234a2)
             begin  //N��ĵ���λ���ֱ�ʾ�������Ƿ����,��Ϊ3,4�����,�������ĸ��ʾ�ǵ�һ�ֻ��ǵڶ����ŷ�,A��ʾ��һ���ŷ�;B��ʾ�ڶ����ŷ�
                array_type2:=23;   //С��������PNLB��;С��������PNLB��
                tempnl_sheet22.Section_LongA:=three_Section_PNLvalue33.PNLA_Long;
                tempnl_sheet22.Section_WidthA:=three_Section_PNLvalue33.PNLA_Width;
                tempnl_sheet22.Section_Long_NumberA:=i21;
                tempnl_sheet22.Section_Width_NumberA:=j21;
                tempnl_sheet22.Section_LongB:=three_Section_PNLvalue33.PNLa_Width;
                tempnl_sheet22.Section_WidthB:=three_Section_PNLvalue33.PNLa_Long;
                tempnl_sheet22.Section_Long_NumberB:=n223A2;
                tempnl_sheet22.Section_Width_NumberB:=N224A2;
                tempnl_sheet22.Section_LongB:=three_Section_PNLvalue33.PNLa_Width;
                tempnl_sheet22.Section_WidthB:=three_Section_PNLvalue33.PNLa_Long;
                tempnl_sheet22.Section_Long_NumberB:=N233A2;
                tempnl_sheet22.Section_Width_NumberB:=N234a2;
                tempnl_sheet22.Section_Unit_Number:=(n223A2*N224A2+N233A2*N234a2)*three_Section_PNLvalue33.PNLa_Unit_Long_Number*three_Section_PNLvalue33.PNLa_Unit_Width_Number
                                                 //  +n223B2*N224B2*three_Section_PNLvalue33.PNLB_Unit_Long_Number*three_Section_PNLvalue33.PNLB_Unit_Width_Number
                                                   +I21*J21*three_Section_PNLvalue33.PNLA_Unit_Long_Number*three_Section_PNLvalue33.PNLA_Unit_Width_Number;
             end;
             if  rate222=max21 then //rate222:=(n223A2*N224A2+N231A2*N232a2)
             begin  //N��ĵ���λ���ֱ�ʾ�������Ƿ����,��Ϊ3,4�����,�������ĸ��ʾ�ǵ�һ�ֻ��ǵڶ����ŷ�,A��ʾ��һ���ŷ�;B��ʾ�ڶ����ŷ�
                array_type2:=22;   //С��������PNLB��;С��������PNLB��
                tempnl_sheet22.Section_LongA:=three_Section_PNLvalue33.PNLA_Long;
                tempnl_sheet22.Section_WidthA:=three_Section_PNLvalue33.PNLA_Width;
                tempnl_sheet22.Section_Long_NumberA:=i21;
                tempnl_sheet22.Section_Width_NumberA:=j21;
                tempnl_sheet22.Section_LongB:=three_Section_PNLvalue33.PNLa_Width;
                tempnl_sheet22.Section_WidthB:=three_Section_PNLvalue33.PNLa_Long;
                tempnl_sheet22.Section_Long_NumberB:=n223A2;
                tempnl_sheet22.Section_Width_NumberB:=N224A2;
                tempnl_sheet22.Section_LongB:=three_Section_PNLvalue33.PNLa_Long;
                tempnl_sheet22.Section_WidthB:=three_Section_PNLvalue33.PNLa_Width;
                tempnl_sheet22.Section_Long_NumberB:=N231A2;
                tempnl_sheet22.Section_Width_NumberB:=N232a2;
                tempnl_sheet22.Section_Unit_Number:=(n223A2*N224A2+N231A2*N232a2)*three_Section_PNLvalue33.PNLa_Unit_Long_Number*three_Section_PNLvalue33.PNLa_Unit_Width_Number
                                                  // +n223B2*N224B2*three_Section_PNLvalue33.PNLB_Unit_Long_Number*three_Section_PNLvalue33.PNLB_Unit_Width_Number
                                                   +I21*J21*three_Section_PNLvalue33.PNLA_Unit_Long_Number*three_Section_PNLvalue33.PNLA_Unit_Width_Number;
             end;

             if  rate221=max21 then //rate221:=(n221A2*N222A2+N233A2*N234a2)
             begin  //N��ĵ���λ���ֱ�ʾ�������Ƿ����,��Ϊ3,4�����,�������ĸ��ʾ�ǵ�һ�ֻ��ǵڶ����ŷ�,A��ʾ��һ���ŷ�;B��ʾ�ڶ����ŷ�
                array_type2:=21;   //С��������PNLB��;С��������PNLB��
                tempnl_sheet22.Section_LongA:=three_Section_PNLvalue33.PNLA_Long;
                tempnl_sheet22.Section_WidthA:=three_Section_PNLvalue33.PNLA_Width;
                tempnl_sheet22.Section_Long_NumberA:=i21;
                tempnl_sheet22.Section_Width_NumberA:=j21;
                tempnl_sheet22.Section_LongB:=three_Section_PNLvalue33.PNLa_Long;
                tempnl_sheet22.Section_WidthB:=three_Section_PNLvalue33.PNLa_Width;
                tempnl_sheet22.Section_Long_NumberB:=n221A2;
                tempnl_sheet22.Section_Width_NumberB:=N222A2;
                tempnl_sheet22.Section_LongB:=three_Section_PNLvalue33.PNLa_Width;
                tempnl_sheet22.Section_WidthB:=three_Section_PNLvalue33.PNLa_Long;
                tempnl_sheet22.Section_Long_NumberB:=N233A2;
                tempnl_sheet22.Section_Width_NumberB:=N234a2;
                tempnl_sheet22.Section_Unit_Number:=(n221A2*N222A2+N233A2*N234a2)*three_Section_PNLvalue33.PNLa_Unit_Long_Number*three_Section_PNLvalue33.PNLa_Unit_Width_Number
                                                   //+n223B2*N224B2*three_Section_PNLvalue33.PNLB_Unit_Long_Number*three_Section_PNLvalue33.PNLB_Unit_Width_Number
                                                   +I21*J21*three_Section_PNLvalue33.PNLA_Unit_Long_Number*three_Section_PNLvalue33.PNLA_Unit_Width_Number;
             end;
             //���µ�һ���ŷ�,���ϵڶ����ŷ�
             if  rate213=max21 then // rate213:=(n223B1*N224B1+N233B1*N234B1)
             begin  //N��ĵ���λ���ֱ�ʾ�������Ƿ����,��Ϊ3,4�����,�������ĸ��ʾ�ǵ�һ�ֻ��ǵڶ����ŷ�,A��ʾ��һ���ŷ�;B��ʾ�ڶ����ŷ�
                array_type2:=13;   //С��������PNLB��;С��������PNLB��
                tempnl_sheet22.Section_LongA:=three_Section_PNLvalue33.PNLA_Long;
                tempnl_sheet22.Section_WidthA:=three_Section_PNLvalue33.PNLA_Width;
                tempnl_sheet22.Section_Long_NumberA:=i21;
                tempnl_sheet22.Section_Width_NumberA:=j21;
                tempnl_sheet22.Section_LongB:=three_Section_PNLvalue33.PNLb_Width;
                tempnl_sheet22.Section_WidthB:=three_Section_PNLvalue33.PNLb_Long;
                tempnl_sheet22.Section_Long_NumberB:=n223B1;
                tempnl_sheet22.Section_Width_NumberB:=N224B1;
                tempnl_sheet22.Section_LongB:=three_Section_PNLvalue33.PNLb_Width;
                tempnl_sheet22.Section_WidthB:=three_Section_PNLvalue33.PNLb_Long;
                tempnl_sheet22.Section_Long_NumberB:=N233B1;
                tempnl_sheet22.Section_Width_NumberB:=N234B1;
                tempnl_sheet22.Section_Unit_Number:=//(n221A2*N222A2+N233A2*N234a2)*three_Section_PNLvalue33.PNLa_Unit_Long_Number*three_Section_PNLvalue33.PNLa_Unit_Width_Number
                                                   (n223B1*N224B1+N233B1*N234B1)*three_Section_PNLvalue33.PNLB_Unit_Long_Number*three_Section_PNLvalue33.PNLB_Unit_Width_Number
                                                   +I21*J21*three_Section_PNLvalue33.PNLA_Unit_Long_Number*three_Section_PNLvalue33.PNLA_Unit_Width_Number;
             end;

             if  rate212=max21 then //  rate212:=(n223B1*N224B1+N231B1*N232B1)
             begin  //N��ĵ���λ���ֱ�ʾ�������Ƿ����,��Ϊ3,4�����,�������ĸ��ʾ�ǵ�һ�ֻ��ǵڶ����ŷ�,A��ʾ��һ���ŷ�;B��ʾ�ڶ����ŷ�
                array_type2:=12;   //С��������PNLB��;С��������PNLB��
                tempnl_sheet22.Section_LongA:=three_Section_PNLvalue33.PNLA_Long;
                tempnl_sheet22.Section_WidthA:=three_Section_PNLvalue33.PNLA_Width;
                tempnl_sheet22.Section_Long_NumberA:=i21;
                tempnl_sheet22.Section_Width_NumberA:=j21;
                tempnl_sheet22.Section_LongB:=three_Section_PNLvalue33.PNLb_Width;
                tempnl_sheet22.Section_WidthB:=three_Section_PNLvalue33.PNLb_Long;
                tempnl_sheet22.Section_Long_NumberB:=n223B1;
                tempnl_sheet22.Section_Width_NumberB:=N224B1;
                tempnl_sheet22.Section_LongB:=three_Section_PNLvalue33.PNLb_Long;
                tempnl_sheet22.Section_WidthB:=three_Section_PNLvalue33.PNLb_Width;
                tempnl_sheet22.Section_Long_NumberB:=N231B1;
                tempnl_sheet22.Section_Width_NumberB:=N232B1;
                tempnl_sheet22.Section_Unit_Number:=//(n221A2*N222A2+N233A2*N234a2)*three_Section_PNLvalue33.PNLa_Unit_Long_Number*three_Section_PNLvalue33.PNLa_Unit_Width_Number
                                                   (n223B1*N224B1+N231B1*N232B1)*three_Section_PNLvalue33.PNLB_Unit_Long_Number*three_Section_PNLvalue33.PNLB_Unit_Width_Number
                                                   +I21*J21*three_Section_PNLvalue33.PNLA_Unit_Long_Number*three_Section_PNLvalue33.PNLA_Unit_Width_Number;
             end;

             if  rate211=max21 then // rate211:=(n221B1*N222B1+N233B1*N234B1)
             begin  //N��ĵ���λ���ֱ�ʾ�������Ƿ����,��Ϊ3,4�����,�������ĸ��ʾ�ǵ�һ�ֻ��ǵڶ����ŷ�,A��ʾ��һ���ŷ�;B��ʾ�ڶ����ŷ�
                array_type2:=11;   //С��������PNLB��;С��������PNLB��
                tempnl_sheet22.Section_LongA:=three_Section_PNLvalue33.PNLA_Long;
                tempnl_sheet22.Section_WidthA:=three_Section_PNLvalue33.PNLA_Width;
                tempnl_sheet22.Section_Long_NumberA:=i21;
                tempnl_sheet22.Section_Width_NumberA:=j21;
                tempnl_sheet22.Section_LongB:=three_Section_PNLvalue33.PNLb_Long;
                tempnl_sheet22.Section_WidthB:=three_Section_PNLvalue33.PNLb_Width;
                tempnl_sheet22.Section_Long_NumberB:=n221B1;
                tempnl_sheet22.Section_Width_NumberB:=N222B1;
                tempnl_sheet22.Section_LongB:=three_Section_PNLvalue33.PNLb_Width;
                tempnl_sheet22.Section_WidthB:=three_Section_PNLvalue33.PNLb_Long;
                tempnl_sheet22.Section_Long_NumberB:=N233B1;
                tempnl_sheet22.Section_Width_NumberB:=N234B1;
                tempnl_sheet22.Section_Unit_Number:=//(n221A2*N222A2+N233A2*N234a2)*three_Section_PNLvalue33.PNLa_Unit_Long_Number*three_Section_PNLvalue33.PNLa_Unit_Width_Number
                                                   (n221B1*N222B1+N233B1*N234B1)*three_Section_PNLvalue33.PNLB_Unit_Long_Number*three_Section_PNLvalue33.PNLB_Unit_Width_Number
                                                   +I21*J21*three_Section_PNLvalue33.PNLA_Unit_Long_Number*three_Section_PNLvalue33.PNLA_Unit_Width_Number;
             end;

             if  rate210=max21 then // rate210:=(n221B1*N222B1+N231B1*N232B1)
             begin  //N��ĵ���λ���ֱ�ʾ�������Ƿ����,��Ϊ3,4�����,�������ĸ��ʾ�ǵ�һ�ֻ��ǵڶ����ŷ�,A��ʾ��һ���ŷ�;B��ʾ�ڶ����ŷ�
                array_type2:=10;   //С��������PNLB��;С��������PNLB��
                tempnl_sheet22.Section_LongA:=three_Section_PNLvalue33.PNLA_Long;
                tempnl_sheet22.Section_WidthA:=three_Section_PNLvalue33.PNLA_Width;
                tempnl_sheet22.Section_Long_NumberA:=i21;
                tempnl_sheet22.Section_Width_NumberA:=j21;
                tempnl_sheet22.Section_LongB:=three_Section_PNLvalue33.PNLb_Width;
                tempnl_sheet22.Section_WidthB:=three_Section_PNLvalue33.PNLb_Long;
                tempnl_sheet22.Section_Long_NumberB:=n221B1;
                tempnl_sheet22.Section_Width_NumberB:=N222B1;
                tempnl_sheet22.Section_LongB:=three_Section_PNLvalue33.PNLb_Width;
                tempnl_sheet22.Section_WidthB:=three_Section_PNLvalue33.PNLb_Long;
                tempnl_sheet22.Section_Long_NumberB:=N231B1;
                tempnl_sheet22.Section_Width_NumberB:=N232B1;
                tempnl_sheet22.Section_Unit_Number:=//(n221A2*N222A2+N233A2*N234a2)*three_Section_PNLvalue33.PNLa_Unit_Long_Number*three_Section_PNLvalue33.PNLa_Unit_Width_Number
                                                   (n221B1*N222B1+N231B1*N232B1)*three_Section_PNLvalue33.PNLB_Unit_Long_Number*three_Section_PNLvalue33.PNLB_Unit_Width_Number
                                                   +I21*J21*three_Section_PNLvalue33.PNLA_Unit_Long_Number*three_Section_PNLvalue33.PNLA_Unit_Width_Number;
             end;

             if  rate209=max21 then //   rate209:=n223B1*N224B1+N233A1*N234A1
             begin  //N��ĵ���λ���ֱ�ʾ�������Ƿ����,��Ϊ3,4�����,�������ĸ��ʾ�ǵ�һ�ֻ��ǵڶ����ŷ�,A��ʾ��һ���ŷ�;B��ʾ�ڶ����ŷ�
                array_type2:=9;   //С��������PNLB��;С��������PNLB��
                tempnl_sheet22.Section_LongA:=three_Section_PNLvalue33.PNLA_Long;
                tempnl_sheet22.Section_WidthA:=three_Section_PNLvalue33.PNLA_Width;
                tempnl_sheet22.Section_Long_NumberA:=i21;
                tempnl_sheet22.Section_Width_NumberA:=j21;
                tempnl_sheet22.Section_LongB:=three_Section_PNLvalue33.PNLb_Width;
                tempnl_sheet22.Section_WidthB:=three_Section_PNLvalue33.PNLb_Long;
                tempnl_sheet22.Section_Long_NumberB:=n223B1;
                tempnl_sheet22.Section_Width_NumberB:=N224B1;
                tempnl_sheet22.Section_LongB:=three_Section_PNLvalue33.PNLa_Width;
                tempnl_sheet22.Section_WidthB:=three_Section_PNLvalue33.PNLa_Long;
                tempnl_sheet22.Section_Long_NumberB:=N233A2;
                tempnl_sheet22.Section_Width_NumberB:=N234a2;
                tempnl_sheet22.Section_Unit_Number:=N233A1*N234A1*three_Section_PNLvalue33.PNLa_Unit_Long_Number*three_Section_PNLvalue33.PNLa_Unit_Width_Number
                                                   +n223B1*N224B1*three_Section_PNLvalue33.PNLB_Unit_Long_Number*three_Section_PNLvalue33.PNLB_Unit_Width_Number
                                                   +I21*J21*three_Section_PNLvalue33.PNLA_Unit_Long_Number*three_Section_PNLvalue33.PNLA_Unit_Width_Number;
             end;

             if  rate208=max21 then //   rate208:=n223B1*N224B1+N231A1*N232A1
             begin  //N��ĵ���λ���ֱ�ʾ�������Ƿ����,��Ϊ3,4�����,�������ĸ��ʾ�ǵ�һ�ֻ��ǵڶ����ŷ�,A��ʾ��һ���ŷ�;B��ʾ�ڶ����ŷ�
                array_type2:=8;   //С��������PNLB��;С��������PNLB��
                tempnl_sheet22.Section_LongA:=three_Section_PNLvalue33.PNLA_Long;
                tempnl_sheet22.Section_WidthA:=three_Section_PNLvalue33.PNLA_Width;
                tempnl_sheet22.Section_Long_NumberA:=i21;
                tempnl_sheet22.Section_Width_NumberA:=j21;
                tempnl_sheet22.Section_LongB:=three_Section_PNLvalue33.PNLb_Width;
                tempnl_sheet22.Section_WidthB:=three_Section_PNLvalue33.PNLb_Long;
                tempnl_sheet22.Section_Long_NumberB:=n223B1;
                tempnl_sheet22.Section_Width_NumberB:=N224B1;
                tempnl_sheet22.Section_LongB:=three_Section_PNLvalue33.PNLa_Long;
                tempnl_sheet22.Section_WidthB:=three_Section_PNLvalue33.PNLa_Width;
                tempnl_sheet22.Section_Long_NumberB:=N231A1;
                tempnl_sheet22.Section_Width_NumberB:=N232A1;
                tempnl_sheet22.Section_Unit_Number:=N231A1*N232A1*three_Section_PNLvalue33.PNLa_Unit_Long_Number*three_Section_PNLvalue33.PNLa_Unit_Width_Number
                                                   +n223B1*N224B1*three_Section_PNLvalue33.PNLB_Unit_Long_Number*three_Section_PNLvalue33.PNLB_Unit_Width_Number
                                                   +I21*J21*three_Section_PNLvalue33.PNLA_Unit_Long_Number*three_Section_PNLvalue33.PNLA_Unit_Width_Number;
             end;

             if  rate207=max21 then // rate207:=n221B1*N222B1+N233A1*N234A1
             begin  //N��ĵ���λ���ֱ�ʾ�������Ƿ����,��Ϊ3,4�����,�������ĸ��ʾ�ǵ�һ�ֻ��ǵڶ����ŷ�,A��ʾ��һ���ŷ�;B��ʾ�ڶ����ŷ�
                array_type2:=7;   //С��������PNLB��;С��������PNLB��
                tempnl_sheet22.Section_LongA:=three_Section_PNLvalue33.PNLA_Long;
                tempnl_sheet22.Section_WidthA:=three_Section_PNLvalue33.PNLA_Width;
                tempnl_sheet22.Section_Long_NumberA:=i21;
                tempnl_sheet22.Section_Width_NumberA:=j21;
                tempnl_sheet22.Section_LongB:=three_Section_PNLvalue33.PNLb_Long;
                tempnl_sheet22.Section_WidthB:=three_Section_PNLvalue33.PNLb_Width;
                tempnl_sheet22.Section_Long_NumberB:=n221B1;
                tempnl_sheet22.Section_Width_NumberB:=N222B1;
                tempnl_sheet22.Section_LongB:=three_Section_PNLvalue33.PNLa_Width;
                tempnl_sheet22.Section_WidthB:=three_Section_PNLvalue33.PNLa_Long;
                tempnl_sheet22.Section_Long_NumberB:=N233A2;
                tempnl_sheet22.Section_Width_NumberB:=N234a2;
                tempnl_sheet22.Section_Unit_Number:=N233A1*N234A1*three_Section_PNLvalue33.PNLa_Unit_Long_Number*three_Section_PNLvalue33.PNLa_Unit_Width_Number
                                                   +n221B1*N222B1*three_Section_PNLvalue33.PNLB_Unit_Long_Number*three_Section_PNLvalue33.PNLB_Unit_Width_Number
                                                   +I21*J21*three_Section_PNLvalue33.PNLA_Unit_Long_Number*three_Section_PNLvalue33.PNLA_Unit_Width_Number;
             end;


             if  rate206=max21 then //  rate206:=n221B1*N222B1+N231A1*N232A1
             begin  //N��ĵ���λ���ֱ�ʾ�������Ƿ����,��Ϊ3,4�����,�������ĸ��ʾ�ǵ�һ�ֻ��ǵڶ����ŷ�,A��ʾ��һ���ŷ�;B��ʾ�ڶ����ŷ�
                array_type2:=6;   //С��������PNLB��;С��������PNLB��
                tempnl_sheet22.Section_LongA:=three_Section_PNLvalue33.PNLA_Long;
                tempnl_sheet22.Section_WidthA:=three_Section_PNLvalue33.PNLA_Width;
                tempnl_sheet22.Section_Long_NumberA:=i21;
                tempnl_sheet22.Section_Width_NumberA:=j21;
                tempnl_sheet22.Section_LongB:=three_Section_PNLvalue33.PNLb_Long;
                tempnl_sheet22.Section_WidthB:=three_Section_PNLvalue33.PNLb_Width;
                tempnl_sheet22.Section_Long_NumberB:=n221B1;
                tempnl_sheet22.Section_Width_NumberB:=N222B1;
                tempnl_sheet22.Section_LongB:=three_Section_PNLvalue33.PNLa_Long;
                tempnl_sheet22.Section_WidthB:=three_Section_PNLvalue33.PNLa_Width;
                tempnl_sheet22.Section_Long_NumberB:=N231A1;
                tempnl_sheet22.Section_Width_NumberB:=N232A1;
                tempnl_sheet22.Section_Unit_Number:=N231A1*N232A1*three_Section_PNLvalue33.PNLa_Unit_Long_Number*three_Section_PNLvalue33.PNLa_Unit_Width_Number
                                                   +n221B1*N222B1*three_Section_PNLvalue33.PNLB_Unit_Long_Number*three_Section_PNLvalue33.PNLB_Unit_Width_Number
                                                   +I21*J21*three_Section_PNLvalue33.PNLA_Unit_Long_Number*three_Section_PNLvalue33.PNLA_Unit_Width_Number;
             end;

              if  rate205=max21 then //  rate205:=n221A1*N222A1+N233B1*N234B1
             begin  //N��ĵ���λ���ֱ�ʾ�������Ƿ����,��Ϊ3,4�����,�������ĸ��ʾ�ǵ�һ�ֻ��ǵڶ����ŷ�,A��ʾ��һ���ŷ�;B��ʾ�ڶ����ŷ�
                array_type2:=5;   //С��������PNLB��;С��������PNLB��
                tempnl_sheet22.Section_LongA:=three_Section_PNLvalue33.PNLA_Long;
                tempnl_sheet22.Section_WidthA:=three_Section_PNLvalue33.PNLA_Width;
                tempnl_sheet22.Section_Long_NumberA:=i21;
                tempnl_sheet22.Section_Width_NumberA:=j21;
                tempnl_sheet22.Section_LongB:=three_Section_PNLvalue33.PNLa_Long;
                tempnl_sheet22.Section_WidthB:=three_Section_PNLvalue33.PNLa_Width;
                tempnl_sheet22.Section_Long_NumberB:=n221A2;
                tempnl_sheet22.Section_Width_NumberB:=N222A2;
                tempnl_sheet22.Section_LongB:=three_Section_PNLvalue33.PNLb_Width;
                tempnl_sheet22.Section_WidthB:=three_Section_PNLvalue33.PNLb_Long;
                tempnl_sheet22.Section_Long_NumberB:=N233B1;
                tempnl_sheet22.Section_Width_NumberB:=N234B1;
                tempnl_sheet22.Section_Unit_Number:=n221A1*N222A1*three_Section_PNLvalue33.PNLa_Unit_Long_Number*three_Section_PNLvalue33.PNLa_Unit_Width_Number
                                                   +N233B1*N234B1*three_Section_PNLvalue33.PNLB_Unit_Long_Number*three_Section_PNLvalue33.PNLB_Unit_Width_Number
                                                   +I21*J21*three_Section_PNLvalue33.PNLA_Unit_Long_Number*three_Section_PNLvalue33.PNLA_Unit_Width_Number;
             end;

             if  rate204=max21 then //  rate204:=n221A1*N222A1+N231B1*N232B1
             begin  //N��ĵ���λ���ֱ�ʾ�������Ƿ����,��Ϊ3,4�����,�������ĸ��ʾ�ǵ�һ�ֻ��ǵڶ����ŷ�,A��ʾ��һ���ŷ�;B��ʾ�ڶ����ŷ�
                array_type2:=4;   //С��������PNLB��;С��������PNLB��
                tempnl_sheet22.Section_LongA:=three_Section_PNLvalue33.PNLA_Long;
                tempnl_sheet22.Section_WidthA:=three_Section_PNLvalue33.PNLA_Width;
                tempnl_sheet22.Section_Long_NumberA:=i21;
                tempnl_sheet22.Section_Width_NumberA:=j21;
                tempnl_sheet22.Section_LongB:=three_Section_PNLvalue33.PNLa_Long;
                tempnl_sheet22.Section_WidthB:=three_Section_PNLvalue33.PNLa_Width;
                tempnl_sheet22.Section_Long_NumberB:=n221A2;
                tempnl_sheet22.Section_Width_NumberB:=N222A2;
                tempnl_sheet22.Section_LongB:=three_Section_PNLvalue33.PNLb_Long;
                tempnl_sheet22.Section_WidthB:=three_Section_PNLvalue33.PNLb_Width;
                tempnl_sheet22.Section_Long_NumberB:=N231B1;
                tempnl_sheet22.Section_Width_NumberB:=N232B1;
                tempnl_sheet22.Section_Unit_Number:=n221A1*N222A1*three_Section_PNLvalue33.PNLa_Unit_Long_Number*three_Section_PNLvalue33.PNLa_Unit_Width_Number
                                                   +N231B1*N232B1*three_Section_PNLvalue33.PNLB_Unit_Long_Number*three_Section_PNLvalue33.PNLB_Unit_Width_Number
                                                   +I21*J21*three_Section_PNLvalue33.PNLA_Unit_Long_Number*three_Section_PNLvalue33.PNLA_Unit_Width_Number;
             end;

             if  rate203=max21 then // rate203:=(n223A1*N224A1+N233A1*N234a1)
             begin  //N��ĵ���λ���ֱ�ʾ�������Ƿ����,��Ϊ3,4�����,�������ĸ��ʾ�ǵ�һ�ֻ��ǵڶ����ŷ�,A��ʾ��һ���ŷ�;B��ʾ�ڶ����ŷ�
                array_type2:=3;   //С��������PNLB��;С��������PNLB��
                tempnl_sheet22.Section_LongA:=three_Section_PNLvalue33.PNLA_Long;
                tempnl_sheet22.Section_WidthA:=three_Section_PNLvalue33.PNLA_Width;
                tempnl_sheet22.Section_Long_NumberA:=i21;
                tempnl_sheet22.Section_Width_NumberA:=j21;
                tempnl_sheet22.Section_LongB:=three_Section_PNLvalue33.PNLa_Width;
                tempnl_sheet22.Section_WidthB:=three_Section_PNLvalue33.PNLa_Long;
                tempnl_sheet22.Section_Long_NumberB:=n223A1;
                tempnl_sheet22.Section_Width_NumberB:=N224A1;
                tempnl_sheet22.Section_LongB:=three_Section_PNLvalue33.PNLa_Width;
                tempnl_sheet22.Section_WidthB:=three_Section_PNLvalue33.PNLa_Long;
                tempnl_sheet22.Section_Long_NumberB:=N233A1;
                tempnl_sheet22.Section_Width_NumberB:=N234a1;
                tempnl_sheet22.Section_Unit_Number:=(n223A1*N224A1+N233A1*N234a1)*three_Section_PNLvalue33.PNLa_Unit_Long_Number*three_Section_PNLvalue33.PNLa_Unit_Width_Number
                                                   //+n223B2*N224B2*three_Section_PNLvalue33.PNLB_Unit_Long_Number*three_Section_PNLvalue33.PNLB_Unit_Width_Number
                                                   +I21*J21*three_Section_PNLvalue33.PNLA_Unit_Long_Number*three_Section_PNLvalue33.PNLA_Unit_Width_Number;
             end;

            if  rate202=max21 then //rate202:=(n223A1*N224A1+N231A1*N232a1)
             begin  //N��ĵ���λ���ֱ�ʾ�������Ƿ����,��Ϊ3,4�����,�������ĸ��ʾ�ǵ�һ�ֻ��ǵڶ����ŷ�,A��ʾ��һ���ŷ�;B��ʾ�ڶ����ŷ�
                array_type2:=2;   //С��������PNLB��;С��������PNLB��
                tempnl_sheet22.Section_LongA:=three_Section_PNLvalue33.PNLA_Long;
                tempnl_sheet22.Section_WidthA:=three_Section_PNLvalue33.PNLA_Width;
                tempnl_sheet22.Section_Long_NumberA:=i21;
                tempnl_sheet22.Section_Width_NumberA:=j21;
                tempnl_sheet22.Section_LongB:=three_Section_PNLvalue33.PNLa_Width;
                tempnl_sheet22.Section_WidthB:=three_Section_PNLvalue33.PNLa_Long;
                tempnl_sheet22.Section_Long_NumberB:=n223A1;
                tempnl_sheet22.Section_Width_NumberB:=N224A1;
                tempnl_sheet22.Section_LongB:=three_Section_PNLvalue33.PNLa_Width;
                tempnl_sheet22.Section_WidthB:=three_Section_PNLvalue33.PNLa_Long;
                tempnl_sheet22.Section_Long_NumberB:=N231A1;
                tempnl_sheet22.Section_Width_NumberB:=N232a1;
                tempnl_sheet22.Section_Unit_Number:=(n223A1*N224A1+N231A1*N232a1)*three_Section_PNLvalue33.PNLa_Unit_Long_Number*three_Section_PNLvalue33.PNLa_Unit_Width_Number
                                                   //+n223B2*N224B2*three_Section_PNLvalue33.PNLB_Unit_Long_Number*three_Section_PNLvalue33.PNLB_Unit_Width_Number
                                                   +I21*J21*three_Section_PNLvalue33.PNLA_Unit_Long_Number*three_Section_PNLvalue33.PNLA_Unit_Width_Number;
             end;

            if  rate201=max21 then //rate201:=(n221A1*N222A1+N233A1*N234a1)
             begin  //N��ĵ���λ���ֱ�ʾ�������Ƿ����,��Ϊ3,4�����,�������ĸ��ʾ�ǵ�һ�ֻ��ǵڶ����ŷ�,A��ʾ��һ���ŷ�;B��ʾ�ڶ����ŷ�
                array_type2:=1;   //С��������PNLB��;С��������PNLB��
                tempnl_sheet22.Section_LongA:=three_Section_PNLvalue33.PNLA_Long;
                tempnl_sheet22.Section_WidthA:=three_Section_PNLvalue33.PNLA_Width;
                tempnl_sheet22.Section_Long_NumberA:=i21;
                tempnl_sheet22.Section_Width_NumberA:=j21;
                tempnl_sheet22.Section_LongB:=three_Section_PNLvalue33.PNLa_Long;
                tempnl_sheet22.Section_WidthB:=three_Section_PNLvalue33.PNLa_Width;
                tempnl_sheet22.Section_Long_NumberB:=n221A1;
                tempnl_sheet22.Section_Width_NumberB:=N222A1;
                tempnl_sheet22.Section_LongB:=three_Section_PNLvalue33.PNLa_Long ;
                tempnl_sheet22.Section_WidthB:=three_Section_PNLvalue33.PNLa_Width;
                tempnl_sheet22.Section_Long_NumberB:=N233A1;
                tempnl_sheet22.Section_Width_NumberB:=N234a1;
                tempnl_sheet22.Section_Unit_Number:=(n221A1*N222A1+N233A1*N234a1)*three_Section_PNLvalue33.PNLa_Unit_Long_Number*three_Section_PNLvalue33.PNLa_Unit_Width_Number
                                                   //+n223B2*N224B2*three_Section_PNLvalue33.PNLB_Unit_Long_Number*three_Section_PNLvalue33.PNLB_Unit_Width_Number
                                                   +I21*J21*three_Section_PNLvalue33.PNLA_Unit_Long_Number*three_Section_PNLvalue33.PNLA_Unit_Width_Number;
             end;
             if  rate200=max21 then //
             begin  //N��ĵ���λ���ֱ�ʾ�������Ƿ����,��Ϊ3,4�����,�������ĸ��ʾ�ǵ�һ�ֻ��ǵڶ����ŷ�,A��ʾ��һ���ŷ�;B��ʾ�ڶ����ŷ�
                array_type2:=0;   //С��������PNLB��;С��������PNLB��
                tempnl_sheet22.Section_LongA:=three_Section_PNLvalue33.PNLA_Long;
                tempnl_sheet22.Section_WidthA:=three_Section_PNLvalue33.PNLA_Width;
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
                tempnl_sheet22.Section_Unit_Number:=//(n201*n202)*three_Section_PNLvalue33.PNLa_Unit_Long_Number*three_Section_PNLvalue33.PNLa_Unit_Width_Number
                                                   //+n223B2*N224B2*three_Section_PNLvalue33.PNLB_Unit_Long_Number*three_Section_PNLvalue33.PNLB_Unit_Width_Number
                                                   n201*n202*three_Section_PNLvalue33.PNLA_Unit_Long_Number*three_Section_PNLvalue33.PNLA_Unit_Width_Number;
             end;





          end;
        end;
     end;     {}
//333333333


  end; //

//--------------����

  //�����ܵ�Ԫ�� max21+max31+pnl_long_number33*pnl_width_number33*value3.PNLA_Unit_Long_Number*value3.PNLA_Unit_Width_Number
 // if Summation_rate<=tem_rate2+tem_rate3+pnl_long_number333*pnl_width_number333*value332.PNLA_Unit_Long_Number*value332.PNLA_Unit_Width_Number*Three_Section_PNLvalue33.PNLA_Width*Three_Section_PNLvalue33.PNLA_Long/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width   then //�����ʱ���ǰ�Ĵ�,��ȡ���ڵ�
 // begin  //1
 //    Summation_rate:=tem_rate2+tem_rate3+pnl_long_number333*pnl_width_number333*value332.PNLA_Unit_Long_Number*value332.PNLA_Unit_Width_Number*Three_Section_PNLvalue33.PNLA_Width*Three_Section_PNLvalue33.PNLA_Long/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width ;;
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



  if Leave_Section_falchion_number1=2 then
  begin  //��,������������;���ֻ�Ƴ������ֲ�ͬ�ĳߴ�,����һ�ֳߴ��������

     //���㿪��������,��ʽΪ:��ΪM��N,�����:M+MN-M

     {TEM_Falchion_Number1:=tempnl_sheet22.Section_Long_NumberA*(1+tempnl_sheet22.Section_Width_NumberA)-tempnl_sheet22.Section_Long_NumberA
                        +tempnl_sheet22.Section_Long_Numberb*(1+tempnl_sheet22.Section_Width_Numberb)-tempnl_sheet22.Section_Long_Numberb
                        +tempnl_sheet33.Section_Long_NumberA*(1+tempnl_sheet33.Section_Width_NumberA)-tempnl_sheet33.Section_Long_NumberA
                        +tempnl_sheet33.Section_Long_Numberb*(1+tempnl_sheet33.Section_Width_Numberb)-tempnl_sheet33.Section_Long_Numberb
                        +pnl_long_number333*(1+pnl_width_number333)-pnl_long_number333;      }


     if No_Calculate_Falchion_Number1=false then   //���ǿ�����
     begin
      //���㿪������
      TEM_Falchion_Number1:=pnl_long_number333*pnl_width_number333+1;
      if tempnl_sheet22.Section_Long_NumberA>0  then
         TEM_Falchion_Number1:=tempnl_sheet22.Section_Long_NumberA*tempnl_sheet22.Section_Width_NumberA+TEM_Falchion_Number1+1;

      if tempnl_sheet22.Section_Long_Numberb>0  then
        TEM_Falchion_Number1:=tempnl_sheet22.Section_Long_Numberb*tempnl_sheet22.Section_Width_Numberb+TEM_Falchion_Number1+1;

      if tempnl_sheet33.Section_Long_NumberA>0  then
        TEM_Falchion_Number1:=tempnl_sheet33.Section_Long_NumberA*tempnl_sheet33.Section_Width_NumberA+TEM_Falchion_Number1+1;

      if tempnl_sheet33.Section_Long_Numberb>0  then
        TEM_Falchion_Number1:=tempnl_sheet33.Section_Long_Numberb*tempnl_sheet33.Section_Width_Numberb+TEM_Falchion_Number1+1;

     //����,�����Ƿ�ѡ����ȵ������ʵ��ŷ�,���������ǰ��Сʱ��ѡ��
       if Calculate_Falchion_Number_Equality_Hold_1=false then
       begin
         result_1:=false;
         if Summation_rate<tem_rate2+tem_rate3+rate_10 then result_1:=true;
         if (Summation_rate=tem_rate2+tem_rate3+rate_10) AND (Falchion_Number1>TEM_Falchion_Number1) then result_1:=true;

      end else if Calculate_Falchion_Number_Equality_Hold_1=true then
      begin
          result_1:=false;
          if Summation_rate<tem_rate2+tem_rate3+rate_10 then result_1:=true;
          if (Summation_rate=tem_rate2+tem_rate3+rate_10) AND (Falchion_Number1>=TEM_Falchion_Number1) then result_1:=true;

       end;
     end;
     if No_Calculate_Falchion_Number1 then  //�����ǿ�����
     begin
         result_1:=false;
         if round((tem_rate2+tem_rate3+rate_10)*10000)>=round(Summation_rate*10000) then
         begin
            result_1:=true;

         end;
       // result_1:=true;
     end;

  end;

  if Leave_Section_falchion_number1=3 then
  begin  //��,�����ɷ���������,����PNL����

     //���㿪��������,��ʽΪ:��ΪM��N,�����:M+MN-M
     {TEM_Falchion_Number1:=tempnl_sheet22.Section_Long_NumberA*(1+tempnl_sheet22.Section_Width_NumberA)-tempnl_sheet22.Section_Long_NumberA
                        +tempnl_sheet22.Section_Long_Numberb*(1+tempnl_sheet22.Section_Width_Numberb)-tempnl_sheet22.Section_Long_Numberb
                        +tempnl_sheet22.Section_Long_Numberc*(1+tempnl_sheet22.Section_Width_Numberc)-tempnl_sheet22.Section_Long_Numberc
                        +tempnl_sheet33.Section_Long_NumberA*(1+tempnl_sheet33.Section_Width_NumberA)-tempnl_sheet33.Section_Long_NumberA
                        +tempnl_sheet33.Section_Long_Numberb*(1+tempnl_sheet33.Section_Width_Numberb)-tempnl_sheet33.Section_Long_Numberb
                        +tempnl_sheet33.Section_Long_Numberc*(1+tempnl_sheet33.Section_Width_Numberc)-tempnl_sheet33.Section_Long_Numberc
                        +pnl_long_number333*(1+pnl_width_number333)-pnl_long_number333;  }

      TEM_Falchion_Number1:=pnl_long_number333*pnl_width_number333+1;
    if tempnl_sheet22.Section_Long_NumberA>0  then
        TEM_Falchion_Number1:=tempnl_sheet22.Section_Long_NumberA*tempnl_sheet22.Section_Width_NumberA+TEM_Falchion_Number1+1;

    if tempnl_sheet22.Section_Long_Numberb>0  then
        TEM_Falchion_Number1:=tempnl_sheet22.Section_Long_Numberb*tempnl_sheet22.Section_Width_Numberb+TEM_Falchion_Number1+1;

    if tempnl_sheet33.Section_Long_NumberA>0  then
        TEM_Falchion_Number1:=tempnl_sheet33.Section_Long_NumberA*tempnl_sheet33.Section_Width_NumberA+TEM_Falchion_Number1+1;

    if tempnl_sheet33.Section_Long_Numberb>0  then
        TEM_Falchion_Number1:=tempnl_sheet33.Section_Long_Numberb*tempnl_sheet33.Section_Width_Numberb+TEM_Falchion_Number1+1;

     //����,�����Ƿ�ѡ����ȵ������ʵ��ŷ�,���������ǰ��Сʱ��ѡ��
     if Calculate_Falchion_Number_Equality_Hold_1=false then
     begin
         result_1:=(Summation_rate<tem_rate2+tem_rate3+rate_10) OR ((Summation_rate=tem_rate2+tem_rate3+rate_10) AND (Falchion_Number1>TEM_Falchion_Number1));
     end else
         result_1:=(Summation_rate<tem_rate2+tem_rate3+rate_10) OR ((Summation_rate=tem_rate2+tem_rate3+rate_10) AND (Falchion_Number1>=TEM_Falchion_Number1));
  end;
   //shwomessage(inttostr(TEM_Falchion_Number1));
   if result_1 then //�����ʱ���ǰ�Ĵ�,��ȡ���ڵ�
   begin  //1
        Summation_rate:=tem_rate2+tem_rate3+rate_10;
        TEM_Falchion_Number2:=Falchion_Number1;//
        Falchion_Number1:=TEM_Falchion_Number1;//��������

     if No_Calculate_Falchion_Number1=false then  //���ǿ�����
     begin
      if Calculate_Falchion_Number_Equality_Hold_1=true then
      begin
        //call ת������
        function_result:=Calculate_OnePNL_result_exchange;//����ǰ�Ľ������,��9�Ƶ�10 , ... , 0�Ƶ�1
        if function_result=false  then
        begin
          showmessage('����!');
          exit;
        end;
      end;
      if ((Calculate_Falchion_Number_Equality_Hold_1=false) and (TEM_Falchion_Number2<>TEM_Falchion_Number1) and (Summation_rate=tem_rate2+tem_rate3+rate_10)) or ((Calculate_Falchion_Number_Equality_Hold_1=false) and (Summation_rate<tem_rate2+tem_rate3+rate_10)) then
      begin
        //call ת������
        function_result:=Calculate_OnePNL_result_exchange;//����ǰ�Ľ������,��9�Ƶ�10 , ... , 0�Ƶ�1
        if function_result=false  then
        begin
          showmessage('����!');
          exit;
        end;
      end;
    end;
    if No_Calculate_Falchion_Number1 then  //�����ǿ�����
    begin
        //call ת������
        function_result:=Calculate_OnePNL_result_exchange;//����ǰ�Ľ������,��9�Ƶ�10 , ... , 0�Ƶ�1
        if function_result=false  then
        begin
          showmessage('����!');
          exit;
        end;
         //if tem_rate2+tem_rate3+rate_10>=0.804then
         //      showmessage(floattostr(Summation_rate)+'   '+floattostr(tem_rate2+tem_rate3+rate_10));
    end;
     //��������,һ����value32,������value3,������value3,�������PNLA��PNLB����
     Result_makeup_using_Sheet_OnePNL[0].Draw_type:=type333;//���ڻ�ͼ
     Result_makeup_using_Sheet_OnePNL[0].PNLA_Unit_Long:=value332.PNLA_Unit_Long ;
     Result_makeup_using_Sheet_OnePNL[0].PNLA_Unit_Width :=value332.PNLA_Unit_Width ;
     Result_makeup_using_Sheet_OnePNL[0].PNLA_Unit_Long_Space :=value332.PNLA_Unit_Long_Space ;
     Result_makeup_using_Sheet_OnePNL[0].PNLA_Unit_Width_Space :=value332.PNLA_Unit_Width_Space ;
     Result_makeup_using_Sheet_OnePNL[0].PNLA_Unit_Long_ToPNL :=value332.PNLA_Unit_Long_ToPNL ;
     Result_makeup_using_Sheet_OnePNL[0].PNLA_Unit_Width_ToPNL :=value332.PNLA_Unit_Width_ToPNL ;
     Result_makeup_using_Sheet_OnePNL[0].PNLA_Unit_Long_Number :=value332.PNLA_Unit_Long_Number ;
     Result_makeup_using_Sheet_OnePNL[0].PNLA_Unit_Width_Number :=value332.PNLA_Unit_Width_Number ;
     Result_makeup_using_Sheet_OnePNL[0].PNLA_Long :=value332.PNLA_Long  ;
     Result_makeup_using_Sheet_OnePNL[0].PNLA_Width :=value332.PNLA_Width ;

     //һ��,����һ������,
     Result_makeup_using_Sheet_OnePNL[0].One_Section_Long:=value332.PNLA_Long;
     Result_makeup_using_Sheet_OnePNL[0].One_Section_Width:=value332.PNLA_Width;
     Result_makeup_using_Sheet_OnePNL[0].One_Section_Long_Number:=pnl_long_number333;
     Result_makeup_using_Sheet_OnePNL[0].One_Section_Width_Number:=pnl_width_number333;
     Result_makeup_using_Sheet_OnePNL[0].One_Section_Unit_Number:=pnl_long_number333*pnl_width_number333*value332.PNLa_Unit_Long_Number*value332.PNLa_Unit_Width_Number;
   //   if Two_Section_Draw_value333=0 then
     //   showmessage('');
      if Two_Section_Draw_value333=2 then
      begin     //���������볤�����
         //����,���¶�������
        Result_makeup_using_Sheet_OnePNL[0].Two_Section_LongA:=tempnl_sheet22.Section_Widtha;  //
        Result_makeup_using_Sheet_OnePNL[0].Two_Section_WidthA:=tempnl_sheet22.Section_Longa ;
        Result_makeup_using_Sheet_OnePNL[0].Two_Section_Long_NumberA:=tempnl_sheet22.Section_Width_Numbera;
        Result_makeup_using_Sheet_OnePNL[0].Two_Section_Width_NumberA:=tempnl_sheet22.Section_Long_Numbera ;
        Result_makeup_using_Sheet_OnePNL[0].Two_Section_LongB:=tempnl_sheet22.Section_Widthb ;
        Result_makeup_using_Sheet_OnePNL[0].Two_Section_WidthB:=tempnl_sheet22.Section_Longb ;
        Result_makeup_using_Sheet_OnePNL[0].Two_Section_Long_NumberB:=tempnl_sheet22.Section_Width_NumberB;
        Result_makeup_using_Sheet_OnePNL[0].Two_Section_Width_NumberB:=tempnl_sheet22.Section_Long_NumberB;
        Result_makeup_using_Sheet_OnePNL[0].Two_Section_Longc:=tempnl_sheet22.Section_Widthc ;
        Result_makeup_using_Sheet_OnePNL[0].Two_Section_Widthc:=tempnl_sheet22.Section_Longc ;
        Result_makeup_using_Sheet_OnePNL[0].Two_Section_Long_Numberc:=tempnl_sheet22.Section_Width_Numberc;
        Result_makeup_using_Sheet_OnePNL[0].Two_Section_Width_Numberc:=tempnl_sheet22.Section_Long_Numberc;
        Result_makeup_using_Sheet_OnePNL[0].Two_Section_Unit_Number:=tempnl_sheet22.Section_Unit_Number;

        Result_makeup_using_Sheet_OnePNL[0].Two_Section_Array_type:=TWO_Section_Draw_value333;//array_type2;
      end else  if Two_Section_Draw_value333=1 then
      begin
        //����,���¶�������
        Result_makeup_using_Sheet_OnePNL[0].Two_Section_LongA:=tempnl_sheet22.Section_LongA ;  //
        Result_makeup_using_Sheet_OnePNL[0].Two_Section_WidthA:=tempnl_sheet22.Section_WidthA ;
        Result_makeup_using_Sheet_OnePNL[0].Two_Section_Long_NumberA:=tempnl_sheet22.Section_Long_NumberA ;
        Result_makeup_using_Sheet_OnePNL[0].Two_Section_Width_NumberA:=tempnl_sheet22.Section_Width_NumberA;
        Result_makeup_using_Sheet_OnePNL[0].Two_Section_LongB:=tempnl_sheet22.Section_LongB ;
        Result_makeup_using_Sheet_OnePNL[0].Two_Section_WidthB:=tempnl_sheet22.Section_WidthB ;
        Result_makeup_using_Sheet_OnePNL[0].Two_Section_Long_NumberB:=tempnl_sheet22.Section_Long_NumberB;
        Result_makeup_using_Sheet_OnePNL[0].Two_Section_Width_NumberB:=tempnl_sheet22.Section_Width_NumberB;
        Result_makeup_using_Sheet_OnePNL[0].Two_Section_Longc:=tempnl_sheet22.Section_Longc ;
        Result_makeup_using_Sheet_OnePNL[0].Two_Section_Widthc:=tempnl_sheet22.Section_Widthc ;
        Result_makeup_using_Sheet_OnePNL[0].Two_Section_Long_Numberc:=tempnl_sheet22.Section_Long_NumberB;
        Result_makeup_using_Sheet_OnePNL[0].Two_Section_Width_Numberc:=tempnl_sheet22.Section_Width_Numberc;

        Result_makeup_using_Sheet_OnePNL[0].Two_Section_Unit_Number:=tempnl_sheet22.Section_Unit_Number;
        Result_makeup_using_Sheet_OnePNL[0].Two_Section_Array_type:=Two_Section_Draw_value333;//array_type2;
      end;
      if Three_Section_Draw_value333=2 then
      begin   // �Ե������볤�����
        Result_makeup_using_Sheet_OnePNL[0].three_Section_LongA:=  tempnl_sheet33.Section_WidthA ;
        Result_makeup_using_Sheet_OnePNL[0].three_Section_WidthA:=tempnl_sheet33.Section_LongA ;
        Result_makeup_using_Sheet_OnePNL[0].three_Section_Long_NumberA:=tempnl_sheet33.Section_Width_NumberA;
        Result_makeup_using_Sheet_OnePNL[0].three_Section_Width_NumberA:= tempnl_sheet33.Section_Long_NumberA ;

        Result_makeup_using_Sheet_OnePNL[0].three_Section_LongB:=tempnl_sheet33.Section_WidthB ;
        Result_makeup_using_Sheet_OnePNL[0].three_Section_WidthB:= tempnl_sheet33.Section_LongB ;
        Result_makeup_using_Sheet_OnePNL[0].three_Section_Long_NumberB:=tempnl_sheet33.Section_Width_NumberB;
        Result_makeup_using_Sheet_OnePNL[0].three_Section_Width_NumberB:=tempnl_sheet33.Section_Long_NumberB;

        Result_makeup_using_Sheet_OnePNL[0].three_Section_Longc:=tempnl_sheet33.Section_Widthc ;
        Result_makeup_using_Sheet_OnePNL[0].three_Section_Widthc:= tempnl_sheet33.Section_Longc ;
        Result_makeup_using_Sheet_OnePNL[0].three_Section_Long_Numberc:=tempnl_sheet33.Section_Width_Numberc;
        Result_makeup_using_Sheet_OnePNL[0].three_Section_Width_Numberc:=tempnl_sheet33.Section_Long_Numberc;

        Result_makeup_using_Sheet_OnePNL[0].three_Section_Unit_Number:=tempnl_sheet33.Section_Unit_Number;
        Result_makeup_using_Sheet_OnePNL[0].Three_Section_Array_type:=Three_Section_Draw_value333;//array_type3;
      end else  if Three_Section_Draw_value333=1 then
      begin
        //����,������������
        Result_makeup_using_Sheet_OnePNL[0].three_Section_LongA:=tempnl_sheet33.Section_LongA ;
        Result_makeup_using_Sheet_OnePNL[0].three_Section_WidthA:=tempnl_sheet33.Section_WidthA ;
        Result_makeup_using_Sheet_OnePNL[0].three_Section_Long_NumberA:=tempnl_sheet33.Section_Long_NumberA ;
        Result_makeup_using_Sheet_OnePNL[0].three_Section_Width_NumberA:=tempnl_sheet33.Section_Width_NumberA;
        Result_makeup_using_Sheet_OnePNL[0].three_Section_LongB:=tempnl_sheet33.Section_LongB ;
        Result_makeup_using_Sheet_OnePNL[0].three_Section_WidthB:=tempnl_sheet33.Section_WidthB ;
        Result_makeup_using_Sheet_OnePNL[0].three_Section_Long_NumberB:=tempnl_sheet33.Section_Long_NumberB;
        Result_makeup_using_Sheet_OnePNL[0].three_Section_Width_NumberB:=tempnl_sheet33.Section_Width_NumberB;

        Result_makeup_using_Sheet_OnePNL[0].three_Section_Longc:=tempnl_sheet33.Section_Longc ;
        Result_makeup_using_Sheet_OnePNL[0].three_Section_Widthc:=tempnl_sheet33.Section_Widthc ;
        Result_makeup_using_Sheet_OnePNL[0].three_Section_Long_Numberc:=tempnl_sheet33.Section_Long_Numberc;
        Result_makeup_using_Sheet_OnePNL[0].three_Section_Width_Numberc:=tempnl_sheet33.Section_Width_Numberc;

        Result_makeup_using_Sheet_OnePNL[0].three_Section_Unit_Number:=tempnl_sheet33.Section_Unit_Number;
        Result_makeup_using_Sheet_OnePNL[0].Three_Section_Array_type:=Three_Section_Draw_value333;//array_type3;       //Three_Section_Draw_value333
      end;
     Result_makeup_using_Sheet_OnePNL[0].Sheet_Long:=value333_sheet.Sheet_Long;//���ϳ�
     Result_makeup_using_Sheet_OnePNL[0].Sheet_Width:=value333_sheet.Sheet_Width;//���Ͽ�


     if Tem_Calculate_Rate_Type1=1 then //�õ�Ԫ����
     begin
       Result_makeup_using_Sheet_OnePNL[0].Pnl_Using_Rate:=Summation_rate;
       Result_makeup_using_Sheet_OnePNL[0].Unit_Using_Rate:=Summation_rate;
       Result_makeup_using_Sheet_OnePNL[0].Using_Rate:=Summation_rate;
     end;
     if Tem_Calculate_Rate_Type1=2 then //��PNL����
     begin
       Result_makeup_using_Sheet_OnePNL[0].Unit_Using_Rate:=Result_makeup_using_Sheet_OnePNL[0].One_Section_Unit_Number*Result_makeup_using_Sheet_OnePNL[0].One_Section_Unit_Number*Result_makeup_using_Sheet_OnePNL[0].three_Section_Unit_Number*value332.PNLA_Unit_Long*value332.PNLA_Unit_Width/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
       Result_makeup_using_Sheet_OnePNL[0].Pnl_Using_Rate:=Summation_rate;
       Result_makeup_using_Sheet_OnePNL[0].Using_Rate:=Summation_rate;
     end;
     // Result_makeup_using_Sheet_OnePNL[0].Using_Rate:=Summation_rate*value332.PNLA_Unit_Long*value332.PNLA_Unit_width/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
     if Tem_Calculate_Rate_Type1=0 then
     begin
          Result_makeup_using_Sheet_OnePNL[0].Pnl_Using_Rate:=Summation_rate;
          Result_makeup_using_Sheet_OnePNL[0].Using_Rate:=Summation_rate*value332.PNLA_Unit_Long*value332.PNLA_Unit_Width/value333_sheet.Sheet_Long/value333_sheet.Sheet_Width;
          Result_makeup_using_Sheet_OnePNL[0].unit_Using_Rate:=Result_makeup_using_Sheet_OnePNL[0].Using_Rate;
     end;
     unit_to_set_pnl_sheet1:=1;
     //showmessage(currtostr(Summation_rate));
     { if Summation_rate>=272 then   showmessage(currtostr(Summation_rate)+'  ' +currtostr(max21) +'  ' +currtostr(max31)
       +'  '+inttostr(pnl_long_number333)+'  '+inttostr(pnl_width_number333)
       +'  '+inttostr(Result_makeup_using_Sheet_OnePNL[0].One_Section_Long_NumberB)
       +'  '+inttostr(Result_makeup_using_Sheet_OnePNL[0].One_Section_Width_NumberB)
       +'һ����'+inttostr(Result_makeup_using_Sheet_OnePNL[0].One_Section_Long_Number)+'һ����'+inttostr(Result_makeup_using_Sheet_OnePNL[0].One_Section_Width_Number)
        +'����������'+inttostr(Result_makeup_using_Sheet_OnePNL[0].One_Section_long_Numbera)+'������'+inttostr(Result_makeup_using_Sheet_OnePNL[0].One_Section_Width_Numbera)+'������'+inttostr(Result_makeup_using_Sheet_OnePNL[0].One_Section_long_NumberB)+'������'+inttostr(Result_makeup_using_Sheet_OnePNL[0].One_Section_Width_NumberB)
       +'������'+currtostr( Two_Section_value333.Sheet_Long)+'��'+ currtostr(Two_Section_value333.Sheet_Width)
        +'���ϳ�'+currtostr( value333_sheet.Sheet_Long)+'��'+ currtostr(value333_sheet.Sheet_Width)
        +'  '+inttostr(array_type3)+'  '
        );     }

  end; //1



end;

function TAarray_Rectangle_OnePNL1.Calculate_Unit_OnePNL(
  const VALUE: Input_PCB_SIZE_OnePNL_1): BOOLEAN; //���㵥Ԫ��PNL
VAR

 i1,i1_1,I2,j1,J2,i101, //
 n1,n2,n3,n4 //������ŵ�Ԫ����
     :integer; //
 Result_Unit_size,tem_Result_Unit_size:TResult_OnePNL_Information_1;//���A,B����Ű����
 function_resul22:boolean;
 sheet_size0:Input_Sheet_Size_OnePNL_1;

begin
   Result:=false;//�������ؼ�
   if (VALUE.PNLA_Long_Max<=VALUE.PNLA_Long_Min) or (VALUE.PNLA_Width_Max<=VALUE.PNLA_Width_Min) then
   begin
     showmessage('�������������!');
     exit;
   end;


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
   begin  //1
     for i2:=n3 to n4 do
     begin   //2
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

                 for i1_1:=low(Input_Sheet_Size_OnePNL) to high(Input_Sheet_Size_OnePNL) do
                 begin
                   IF (Input_Sheet_Size_OnePNL[i1_1].Sheet_Long>0) and (Input_Sheet_Size_OnePNL[i1_1].Sheet_Width>0) then //���ϳ������0,�Ŵ���
                   begin
                     //�˴�������PNL����, Calculate_OnePNL_Sheet_1,���������:
                     //1.���ϳ���Ե�;2.PNLA��PNLB���гߴ�Ե�;3.���ϳ���Ե���PNLA��PNLB���гߴ�Ե�
                     //�˴�PNLA��PNLB��ͬ
                     tem_Result_Unit_size:=Result_Unit_size;
                     sheet_size0.Sheet_Long:=Input_Sheet_Size_OnePNL[i1_1].Sheet_Long;
                     sheet_size0.Sheet_Width:=Input_Sheet_Size_OnePNL[i1_1].Sheet_Width;
                     if (sheet_size0.Sheet_Long>=Result_Unit_size.PNLA_Long ) and (sheet_size0.Sheet_Width>Result_Unit_size.PNLA_Width)then
                          function_resul22:=Calculate_OnePNL_Sheet_1(tem_Result_Unit_size,sheet_size0);

                      //�Ե����ϳ���
                      tem_Result_Unit_size:=Result_Unit_size;
                      sheet_size0.Sheet_Long:=Input_Sheet_Size_OnePNL[i1_1].Sheet_Width ;
                      sheet_size0.Sheet_Width:=Input_Sheet_Size_OnePNL[i1_1].Sheet_Long;
                      if (sheet_size0.Sheet_Long>=Result_Unit_size.PNLA_Long ) and (sheet_size0.Sheet_Width>Result_Unit_size.PNLA_Width)then
                          function_resul22:=Calculate_OnePNL_Sheet_1(tem_Result_Unit_size,sheet_size0);


                   end;
                 end;

     end; //2
   end; //1
end;

function TAarray_Rectangle_OnePNL1.Get_Calculate_Result_Number: integer;
begin
   Result:=0;
end;

function TAarray_Rectangle_OnePNL1.Get_Echange_Unit_To_PNL_Space: boolean;
begin
   Result:=Echange_Unit_To_PNL_Space1;
end;

function TAarray_Rectangle_OnePNL1.Get_Echange_Unit_To_Unit_Space: boolean;
begin
    Result:=Echange_Unit_To_Unit_Space1;
end;

function TAarray_Rectangle_OnePNL1.Get_Input_PCB_SIZE_OnePNL_1: Input_PCB_SIZE_OnePNL_1;
begin
  Result:=Input_PCB_SIZE_OnePNL;
end;

function TAarray_Rectangle_OnePNL1.Get_Input_Sheet_Size_OnePNL_1(Index: integer): Input_Sheet_Size_OnePNL_1;
begin
   Result:=Input_Sheet_Size_OnePNL[index];
end;

function TAarray_Rectangle_OnePNL1.Get_Leave_Section_falchion_number: integer;
begin
   Result:=Leave_Section_falchion_number1;
end;

function TAarray_Rectangle_OnePNL1.Get_tresult_makeup_using_Sheet_OnePNL_1(index: integer): tresult_makeup_using_Sheet_OnePNL_1;
begin
  Result:=Result_makeup_using_Sheet_OnePNL[index];
end;

procedure TAarray_Rectangle_OnePNL1.Set_Echange_Unit_To_PNL_Space(
  const Value: boolean);
begin
  Echange_Unit_To_PNL_Space1:=value;
end;

procedure TAarray_Rectangle_OnePNL1.Set_Echange_Unit_To_Unit_Space(
  const Value: boolean);
begin
   Echange_Unit_To_Unit_Space1:=value;
end;

procedure TAarray_Rectangle_OnePNL1.Set_Input_PCB_SIZE_OnePNL_1(const Value: Input_PCB_SIZE_OnePNL_1);
begin
  Input_PCB_SIZE_OnePNL:=Value;
end;

procedure TAarray_Rectangle_OnePNL1.Set_Input_Sheet_Size_OnePNL_1(Index: integer; const Value: Input_Sheet_Size_OnePNL_1);
begin
   Input_Sheet_Size_OnePNL[index]:=value;
end;

procedure TAarray_Rectangle_OnePNL1.Set_Leave_Section_falchion_number1(
  const Value: integer);
begin
 Leave_Section_falchion_number1:=value;
end;

procedure TAarray_Rectangle_OnePNL1.Set_tresult_makeup_using_Sheet_OnePNL_1(index: integer; const Value: tresult_makeup_using_Sheet_OnePNL_1);
begin
   Result_makeup_using_Sheet_OnePNL[index]:=value;
end;

function TAarray_Rectangle_OnePNL1.Get_Calculate_Array_Complete_Percent: TProgressBar;
begin
   Result:=Tem_TProgressBar1;
end;

procedure TAarray_Rectangle_OnePNL1.Set_Calculate_Array_Complete_Percent(const Value: TProgressBar);
begin
   Tem_TProgressBar1:=Value;
end;

function TAarray_Rectangle_OnePNL1.Get_Calculate_Array_Complete_Time: boolean;
begin
   Result:=Tem_Calculate_Array_Complete_Time_Display;
end;

procedure TAarray_Rectangle_OnePNL1.Set_Calculate_Array_Complete_Time(const Value: boolean);
begin
   Tem_Calculate_Array_Complete_Time_Display:=Value;
end;

function TAarray_Rectangle_OnePNL1.Get_Tem_Calculate_Rate_Type1: integer;
begin
  Result:=Tem_Calculate_Rate_Type1;
end;

procedure TAarray_Rectangle_OnePNL1.Set_Tem_Calculate_Rate_Type1(const Value: integer);
begin
   Tem_Calculate_Rate_Type1:=value;
end;

function TAarray_Rectangle_OnePNL1.Get_Calculate_Falchion_Number_Equality_Hold: boolean;
begin
   Result:=Calculate_Falchion_Number_Equality_Hold_1;
end;

procedure TAarray_Rectangle_OnePNL1.Set_Calculate_Falchion_Number_Equality_Hold(
  const Value: boolean);
begin
   Calculate_Falchion_Number_Equality_Hold_1:=Value;
end;



function TAarray_Rectangle_OnePNL1.Echange_Two_And_Three_Section_Data(var
  value1: array of tresult_makeup_using_Sheet_OnePNL_1): boolean;//������������PNLB��һ��ֵ��ȵ������������PNLA����һ��
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

function TAarray_Rectangle_OnePNL1.Get_PNL_Informat3311: PNL_Informat3311;
begin
   Result:=PNL_Informat33;
end;

procedure TAarray_Rectangle_OnePNL1.Set_PNL_Informat3311(
  const Value: PNL_Informat3311);
begin
   PNL_Informat33:=value;
end;

function TAarray_Rectangle_OnePNL1.PNL_To_SHEET_999(): Boolean;  //���ڼ���֪��PNL���ݵĴ������ϣ�������
var
  i:integer;
   i1,i1_1,I2,j1,J2,i101:integer; //
  Result_Unit_size,tem_Result_Unit_size:TResult_OnePNL_Information_1;//���A,B����Ű����
  sheet_size0:Input_Sheet_Size_OnePNL_1;
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

     for i1_1:=low(Input_Sheet_Size_OnePNL) to high(Input_Sheet_Size_OnePNL) do
     begin
         IF (Input_Sheet_Size_OnePNL[i1_1].Sheet_Long>0) and (Input_Sheet_Size_OnePNL[i1_1].Sheet_Width>0) then //���ϳ������0,�Ŵ���
         begin
         //�˴�������PNL����, Calculate_OnePNL_Sheet_1,���������:
         //1.���ϳ���Ե�;2.PNLA��PNLB���гߴ�Ե�;3.���ϳ���Ե���PNLA��PNLB���гߴ�Ե�

              tem_Result_Unit_size:=Result_Unit_size;
              sheet_size0.Sheet_Long:=Input_Sheet_Size_OnePNL[i1_1].Sheet_Long;
              sheet_size0.Sheet_Width:=Input_Sheet_Size_OnePNL[i1_1].Sheet_Width;
              if (sheet_size0.Sheet_Long>=Result_Unit_size.PNLA_Long ) and (sheet_size0.Sheet_Width>Result_Unit_size.PNLA_Width)then
                 function_resul22:=Calculate_OnePNL_Sheet_1(tem_Result_Unit_size,sheet_size0);

                      //�Ե����ϳ���
                      //tem_Result_Unit_size:=Result_Unit_size;
              sheet_size0.Sheet_Long:=Input_Sheet_Size_OnePNL[i1_1].Sheet_Width ;
              sheet_size0.Sheet_Width:=Input_Sheet_Size_OnePNL[i1_1].Sheet_Long;
              if (sheet_size0.Sheet_Long>=Result_Unit_size.PNLA_Long ) and (sheet_size0.Sheet_Width>Result_Unit_size.PNLA_Width)then
                 function_resul22:=Calculate_OnePNL_Sheet_1(tem_Result_Unit_size,sheet_size0);


         end;
     end;
end;

procedure TAarray_Rectangle_OnePNL1.Calculate_PnlToSheet_Array;
var
  function_resule1:boolean;
begin
   //��ʹ������
   Summation_rate:=0;
   Falchion_Number1:=100;//��������
   Calculate_Flag1:=0;
   if Leave_Section_falchion_number1=0 then Leave_Section_falchion_number1:=2; //û�������Ű淽��ʱ,Ĭ��Ϊ:2,������ֻ������������

   PNL_To_SHEET_999;

   function_resule1:=Echange_Two_And_Three_Section_Data(Result_makeup_using_Sheet_OnePNL);

end;

procedure TAarray_Rectangle_OnePNL1.Calculate_SetToPnlToSheet_Array;
var //�ӵ�Ԫ��SET��PNL��SHEET
  i,j:integer;
  function_resule1:boolean;
 
  tem_timeTime1,tem_timeTime2,tem_timeTime3: TDateTime;
  TProgressBar1_Position1,tem1:integer;
begin
  //��ʹ������
   tem_timeTime1:=Time;
   Summation_rate:=0;
   Falchion_Number1:=100;//��������
   Tem_TProgressBar1.Min:=0;
   Tem_TProgressBar1.max:=100;
   TProgressBar1_Position1:=2;
   Calculate_Flag1:=0;
   if Echange_Unit_To_Unit_Space1 then
   begin
      TProgressBar1_Position1:=2+TProgressBar1_Position1;
   end;
   if Echange_Unit_To_PNL_Space1 then
   begin
     TProgressBar1_Position1:=2+TProgressBar1_Position1;
   end;
   if (Echange_Unit_To_PNL_Space1) and (Echange_Unit_To_Unit_Space1) then
   begin
    TProgressBar1_Position1:=2+TProgressBar1_Position1;
   end;
   tem1:=0;
   if Leave_Section_falchion_number1=0 then Leave_Section_falchion_number1:=2; //û�������Ű淽��ʱ,Ĭ��Ϊ:2,������ֻ������������
   //û�������Ƿ���㿪������һ��Ҫ����ʱ
   //if Calculate_Falchion_Number_Equality_Hold_1 then
   //  showmessage(booltostr(Calculate_Falchion_Number_Equality_Hold_1));
   Tem_TProgressBar1.Position:=1;
   //if Tem_Calculate_Rate_Type1=0 then Tem_Calculate_Rate_Type1:=1;//û��������������ʵķ���ʱ,Ĭ��Ϊ:1,�Ե�Ԫ����.
   tem1:=tem1+1;
   Tem_TProgressBar1.Position:=trunc(tem1*100/TProgressBar1_Position1);





   

   function_resule1:=Echange_Two_And_Three_Section_Data(Result_makeup_using_Sheet_OnePNL);


end;

function TAarray_Rectangle_OnePNL1.Get_Input_Set_Size_OnePNL_1111: Input_Set_Size_OnePNL_1111;
begin
   Result:=Input_Set_Size_OnePNL_1;
end;

procedure TAarray_Rectangle_OnePNL1.Set_Input_Set_Size_OnePNL_1111(
  const Value: Input_Set_Size_OnePNL_1111);
begin
  Input_Set_Size_OnePNL_1:=value;
end;

function TAarray_Rectangle_OnePNL1.Calculate_Unit_To_Set(
  const Value_Input_Set_Size_OnePNL_1: Input_Set_Size_OnePNL_1111;
  var Value_Input_PCB_SIZE_OnePNL_1: Input_PCB_SIZE_OnePNL_1): boolean;
var
 i,j,n10,n11,n12,n13:integer; //n10,n11,n12,n13�浥Ԫ����
 tem_long ,tem_width:currency;//���ڴ�SET����
 function_resule1:boolean;
 //tem_Input_PCB_SIZE_OnePNL:Input_PCB_SIZE_OnePNL_1;
begin
   Result:=false;
   //�����������С���ŵ�SET�ڵĵ�Ԫ����
   n10:=trunc((Value_Input_Set_Size_OnePNL_1.Set_Long_Min+Value_Input_Set_Size_OnePNL_1.Unit_Long_Space_ToUnit-Value_Input_Set_Size_OnePNL_1.Unit_Long_Space_Toset_1-Value_Input_Set_Size_OnePNL_1.Unit_Long_Space_Toset_2)/Value_Input_Set_Size_OnePNL_1.Unit_Long);

   n11:=trunc((Value_Input_Set_Size_OnePNL_1.Set_Long_Max+Value_Input_Set_Size_OnePNL_1.Unit_Long_Space_ToUnit-Value_Input_Set_Size_OnePNL_1.Unit_Long_Space_Toset_1-Value_Input_Set_Size_OnePNL_1.Unit_Long_Space_Toset_2)/Value_Input_Set_Size_OnePNL_1.Unit_Long);

   n12:=trunc((Value_Input_Set_Size_OnePNL_1.Set_width_Max+Value_Input_Set_Size_OnePNL_1.Unit_width_Space_ToUnit-Value_Input_Set_Size_OnePNL_1.Unit_width_Space_Toset_1-Value_Input_Set_Size_OnePNL_1.Unit_width_Space_Toset_2)/Value_Input_Set_Size_OnePNL_1.Unit_width);

   n13:=trunc((Value_Input_Set_Size_OnePNL_1.Set_width_Min+Value_Input_Set_Size_OnePNL_1.Unit_width_Space_ToUnit-Value_Input_Set_Size_OnePNL_1.Unit_width_Space_Toset_1-Value_Input_Set_Size_OnePNL_1.Unit_width_Space_Toset_2)/Value_Input_Set_Size_OnePNL_1.Unit_width);
   //
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
         begin
            Result_makeup_using_Sheet_OnePNL[0].Long_SET:=0;

         end;
       end;
     end;
   end;
   Result:=true;
end;

function TAarray_Rectangle_OnePNL1.Get_Change_PNL_Long_Width: boolean;
begin
  Result:=Change_PNL_Long_Width1;
end;

procedure TAarray_Rectangle_OnePNL1.Set_Change_PNL_Long_Width(
  const Value: boolean);
begin
   Change_PNL_Long_Width1:=value;
end;

function TAarray_Rectangle_OnePNL1.Get_No_Calculate_Falchion_Number: boolean;
begin
  result:=No_Calculate_Falchion_Number1;
end;

procedure TAarray_Rectangle_OnePNL1.Set_No_Calculate_Falchion_Number(
  const Value: boolean);
begin
  No_Calculate_Falchion_Number1:=value;
end;

end.
