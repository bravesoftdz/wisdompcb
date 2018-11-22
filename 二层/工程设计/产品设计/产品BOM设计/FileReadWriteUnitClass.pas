//Hole_information_1:=THole_information.Create;������
//Hole_information_1.initialization_Result_Drill_Hole_information ;��ʹ���������
// Hole_information_1.Result_Drill_Hole_information[n].Hole_Number  ȡ�ÿ���
//Hole_information_1.Result_Drill_Hole_information[n].Hole_denotation �׷���
//Hole_information_1.Result_Drill_Hole_information[n].Hole_Size �״�С
//Hole_information_1.Result_Drill_Hole_information[n].Hole_Size_Unit ��λ
//n���100��,��һ��ʼ,���Ϊ0ʱ,���ü����ڽ�ȥ,����T���������
//������ļ��������  ��Ϊ��
unit FileReadWriteUnitClass;

interface
uses
  Messages,SysUtils,StdCtrls,Dialogs,ExtCtrls,math,Graphics;
  
  type
    Hole_information =record
       Hole_denotation:string;   //�׷���
       Hole_Number:integer;     //����
       Hole_Size:currency;//�״�С
       Hole_Size_Unit:string//�׵�λ
  end;
   THole_information= CLASS(Tobject)
   private
   { Private declarations }
     Drill_File_content_1:string;
     Drill_Hole_Type_Count_1,Drill_Hole_Type_Count_3,Drill_Hole_Type_Count_5:integer;
     Drill_Hole_Type_Count_2,Drill_Hole_Type_Count_4:array[1..100] of integer;
     Drill_Hole_information:arrAY[0..100] OF Hole_information;
    function IsDigit(ch: string):boolean;
    function Get_Drill_Hole_information(Index: Integer): Hole_information;
    function Get_Drill_Hole_Type_Count: integer;
    procedure Set_Drill_File_content(const Value: string);
    function manage_String(s1:string):boolean;
   public
   { Public declarations }
     //��ʹ��
     procedure initialization_Result_Drill_Hole_information();
     function calculate():boolean;
     //�õ��ַ���
     property Drill_File_content:string write Set_Drill_File_content;
     //���������
     property Drill_Hole_Type_Count:integer read Get_Drill_Hole_Type_Count;

     //���ؼ�����
     property Result_Drill_Hole_information[Index: Integer]: Hole_information read Get_Drill_Hole_information;

   END;


implementation

{ THole_information }

function THole_information.calculate: boolean;
begin
 Result:= manage_String(Drill_File_content_1);
end;

function THole_information.Get_Drill_Hole_information(Index: Integer): Hole_information;
begin
  Result:=Drill_Hole_information[Index];
end;

function THole_information.Get_Drill_Hole_Type_Count: integer;
begin
   Result:=Drill_Hole_Type_Count_1;
end;

procedure THole_information.initialization_Result_Drill_Hole_information;
var
  i:integer;
begin
   //����ǰ��������Ϊ�� // Drill_File_content_1:string;
 Drill_Hole_Type_Count_1:=0;
 for i:=low(Drill_Hole_information) to high(Drill_Hole_information) do
  begin
    Drill_Hole_information[i].Hole_denotation:='';    //:arrAY[0..100] OF Hole_information;
    Drill_Hole_information[i].Hole_Number:=0;
    Drill_Hole_information[i].Hole_Size:=0;
    Drill_Hole_information[i].Hole_Size_Unit:='';
  end;
end;

function THole_information.IsDigit(ch: string): boolean;
begin
    result:=false;
   if (ch='0') or (ch='1') or (ch='2') or (ch='3') or (ch='4') or (ch='5') or (ch='6') or (ch='7') or (ch='8') or (ch='9') or (ch='.') then
   begin
     result:=true;
   end;
end;

function THole_information.manage_String(s1: string):boolean;
var
  i,j,i1,Pos_1,Pos_2:integer;
  Tem_string:string;
begin
   tem_string:=LowerCase(s1);  //���ַ���תΪСд
   if s1='' then Result:=false; //�ַ���Ϊ��ʱ,������
  try
   if s1<>'' then //�ַ�����Ϊ��ʱ����
   begin
      //showmessage(tem_string);
      //����METRIC,LZ����METRIC,TZ��
      if  pos('metric',tem_string)>0 then
      begin
         //��METRIC��,��λ
         i:=low(Drill_Hole_information);
         Drill_Hole_information[i].Hole_Size_Unit:='Metric';  //��׵�λmm����
      end;
      //����INCH,LZ����INCH,TZ��
      if  pos('inch',tem_string)>0 then
      begin
         //��INCH��,��λ
         i:=low(Drill_Hole_information);
         Drill_Hole_information[i].Hole_Size_Unit:='Inch'; // ��׵�λINCHӢ��
      end;

       //����T__C__F__S__��
      //ȡ����״�С
      //if  (pos('t',tem_string)=1) and (pos(' ',tem_string)<length(tem_string)) and (pos('f',tem_string)=0) and (pos('i',tem_string)=0)  and (pos('e',tem_string)=0) and (pos('atc',tem_string)=0)) then
      {
      if  (pos('t',tem_string)=1) and (pos(' ',tem_string)>0) and (pos(' ',tem_string)<length(tem_string)) and  (pos('i',tem_string)=0) and ((pos('metric',tem_string)=0) and (pos('detect',tem_string)=0) and (pos('atc',tem_string)=0)) then
      begin
        //��TXX��CXX��,�׵Ĵ�С
        // showmessage(copy(tem_string,pos_1+1,pos_2-2));
          Pos_1:=pos('t',tem_string);
          Pos_2:=pos(' ',tem_string);
         //i:=strtoint(copy(trim(tem_string,pos_1+1,pos_2-2))); //������
         i:=strtoint(copy(tem_string,pos_1+1,pos_2-2)); //������
         //Drill_Hole_information[i].Hole_Number :=i;
         Drill_Hole_information[i].Hole_denotation:=trim(copy(tem_string,pos_1,pos_2-1));
         j:=low(Drill_Hole_information);
         Drill_Hole_information[i].Hole_Size_Unit:=Drill_Hole_information[j].Hole_Size_Unit ;
         i1:=0;
      //  for j:=pos_2+1 to length(tem_string)-pos_2 do
        //
         for j:=pos_2+1 to length(tem_string) do
         begin
           //if copy(tem_string,j,1)='  ' then
          // begin
             //if IsDigit(copy(tem_string,j,1))=false then
            // if copy(tem_string,j,1) in ['0'..'9','.'] then
             //begin
            //   i1:=i1+11;

               //break;
             //end;
           //end;
         end;

        Drill_Hole_information[i].Hole_Size:=StrToCurr(trim(copy(tem_string,pos_2+1,j-pos_2-i1))); //
         // showmessage(currtostr(Drill_Hole_information[i].Hole_Size));
      end;
      }
      //����T����C����FS
      {
      if  (pos('t',tem_string)=1) and (pos('c',tem_string)>0)  and  (pos('i',tem_string)=0) and ((pos('metric',tem_string)=0) and (pos('detect',tem_string)=0) and (pos('inch',tem_string)=0) and (pos('atc',tem_string)=0)) then
      begin
        //��TXX��CXX��,�׵Ĵ�С
        // showmessage(copy(tem_string,pos_1+1,pos_2-2));
          Pos_1:=pos('t',tem_string);
          Pos_2:=pos('c',tem_string);
         //i:=strtoint(copy(trim(tem_string,pos_1+1,pos_2-2))); //������
         i:=strtoint(copy(tem_string,pos_1+1,pos_2-2)); //������
         //Drill_Hole_information[i].Hole_Number :=i;
         Drill_Hole_information[i].Hole_denotation:=trim(copy(tem_string,pos_1,pos_2-1));
         j:=low(Drill_Hole_information);
         Drill_Hole_information[i].Hole_Size_Unit:=Drill_Hole_information[j].Hole_Size_Unit ;
         i1:=0;
        //for j:=pos_2+1 to length(tem_string)-pos_2 do

         for j:=pos_2+1 to length(tem_string) do
         begin
           //if copy(tem_string,j,1)='  ' then
           //begin
             if IsDigit(copy(tem_string,j,1))=false then
             //if copy(tem_string,j,1) in ['0'..'9','.'] then
             begin
               i1:=i1+11;

               break;
             end;
           //end;
         end;

        Drill_Hole_information[i].Hole_Size:=StrToCurr(trim(copy(tem_string,pos_2+1,j-pos_2-i1))); //
         // showmessage(currtostr(Drill_Hole_information[i].Hole_Size));
      end;
      }




       ////����T__��,ȥ��DETECT,ON��ATC,ON��fmat��T__C__F__S__,����T����,����T���������,û������������
      if  (pos('t',tem_string)=1) then //��һ����T  and (pos('c',tem_string)=0) and (pos(' ',tem_string)=0) and  (pos('i',tem_string)=0) and ((pos('metric',tem_string)=0) and (pos('detect',tem_string)=0) and (pos('atc',tem_string)=0)) then
      begin
          Pos_1:=pos('t',tem_string);
         //��TXX�� ,�ڼ�������
         IF (pos('c',tem_string)>0) then //��C,ȡ������������С
         begin

           Pos_2:=pos('c',tem_string);
           i1:=0;
           for j:=pos_2+1 to length(tem_string) do
           begin
             if IsDigit(copy(tem_string,j,1))=false then
             begin
                i1:=1;
                break;
             end;
           end;
            i:=strtoint(trim(copy(tem_string,2,Pos_2-2)));
        //    showmessage(inttostr(i));
           Drill_Hole_information[i].Hole_Size:=StrToCurr(trim(copy(tem_string,pos_2+1,j-pos_2-i1)));//�׾���С
         END;//��T����C������

         IF (pos(' ',tem_string)>0) and ((pos('i',tem_string)=0)) then //���ո�,ȡ������������С,�����С�ɿո����
         begin

           Pos_2:=pos(' ',tem_string);
           //i1:=0;
          // for j:=pos_2+1 to length(tem_string) do
          // begin
          //   if IsDigit(copy(tem_string,j,1))=false then
          //   begin
          //      i1:=1;
          //      break;
          //   end;
          // end;
         // showmessage(trim(copy(tem_string,pos_2+1,length(tem_string)-pos_2)));
           i:=strtoint(trim(copy(tem_string,2,Pos_2-2)));
          // showmessage(inttostr(i));
           Drill_Hole_information[i].Hole_Size:=StrToCurr(trim(copy(tem_string,pos_2+1,length(tem_string)-pos_2)));//j-pos_2-i1)));//�׾���С
         END;//��T����C������


           I1:=0;
           for j:=2 to length(tem_string) do   // ֻ��T��������
           begin
             if IsDigit(copy(tem_string,j,1))=false then
             begin
                i1:=1;
                break;
             end;
           end;
           IF I1=0 THEN
           BEGIN
             Drill_Hole_Type_Count_1:=Drill_Hole_Type_Count_1+1;
             Drill_Hole_information[Drill_Hole_Type_Count_1].Hole_denotation:=tem_string;//trim(copy(tem_string,pos_1,pos_2-1)); //��׷���
             Drill_Hole_Type_Count_3:=strtoint(trim(copy(tem_string,pos_1+1,length(tem_string)-pos_1)));//pos_2-1-pos_1)));
           END;








      end;

      //����M25��
      if pos('m25',tem_string)>0 then
      begin
           //M25��
           Drill_Hole_Type_Count_2[Drill_Hole_Type_Count_3]:=0;
           Drill_Hole_Type_Count_4[Drill_Hole_Type_Count_3]:=0;
           Drill_Hole_Type_Count_5:=1; //�����ظ���־,1���ظ�,0���ظ�
      end;
      //����M08��
      if pos('m08',tem_string)>0 then
      begin
           //M08��
           Drill_Hole_Type_Count_5:=0;//�������ظ���־ֵ��Ϊ0,��־�ظ�����
      end;
      //����R__M02X__Y__��
      if   ((pos('x',tem_string)>0) or (pos('y',tem_string)>0))  and (pos('m',tem_string)=0) then //or ((pos('y',tem_string)=0)) and (pos('m',tem_string)=0) then
      begin
         //ֻ��X,Y����
         //���ظ�,ֱ�Ӽ������,���������Drill_Hole_information[Drill_Hole_Type_Count_3].Hole_Number
         //���ظ�ʱ,���ظ����������,�����������Drill_Hole_Type_Count_2[Drill_Hole_Type_Count_3]
         if Drill_Hole_Type_Count_5=0 then
         begin
            Drill_Hole_information[Drill_Hole_Type_Count_3].Hole_Number:=Drill_Hole_information[Drill_Hole_Type_Count_3].Hole_Number +1;
         end
         else
         begin
           Drill_Hole_Type_Count_2[Drill_Hole_Type_Count_3]:=Drill_Hole_Type_Count_2[Drill_Hole_Type_Count_3]+1;
         end;
      end;
      //����M01��
      if   pos('m01',tem_string)>0 then
      begin
          //�ظ�����,��M01
          //�����ظ�������,��ֵ����Drill_Hole_Type_Count_4[Drill_Hole_Type_Count_3],�Ա���M01�����ж��M02ʱ��
          Drill_Hole_Type_Count_4[Drill_Hole_Type_Count_3]:= Drill_Hole_Type_Count_2[Drill_Hole_Type_Count_3];
      end;
      //����M02��
      if   pos('m02',tem_string)>0 then
      begin
         //�ظ�����,��M02
         //�����ܿ���,��ֵ����Drill_Hole_information[Drill_Hole_Type_Count_3].Hole_Number
          Pos_1:=pos('r',tem_string); //�����ظ�������
          Pos_2:=pos('m',tem_string); //�����ظ�������
         if pos_1=0 then
         begin
           Drill_Hole_Type_Count_2[Drill_Hole_Type_Count_3]:=Drill_Hole_Type_Count_4[Drill_Hole_Type_Count_3]*2;
         end
         else
         begin
           Drill_Hole_Type_Count_2[Drill_Hole_Type_Count_3]:= Drill_Hole_Type_Count_4[Drill_Hole_Type_Count_3]*strtoint(copy(tem_string,pos_1+1,pos_2-2));
         end;
         Drill_Hole_information[Drill_Hole_Type_Count_3].Hole_Number:=Drill_Hole_Type_Count_2[Drill_Hole_Type_Count_3]+Drill_Hole_information[Drill_Hole_Type_Count_3].Hole_Number;
      end;


     Result:=true;
   end;
  except
  end;
end;

procedure THole_information.Set_Drill_File_content(const Value: string);
begin//������ַ���
   Drill_File_content_1:=Value;
end;

end.
