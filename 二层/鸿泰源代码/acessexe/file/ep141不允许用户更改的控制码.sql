 ep141�������û����ĵĿ�����
 
 if (adoquery1rkey.Value=63) ����������
 or (adoquery1rkey.Value=55) ���ϵ���
 or (adoquery1rkey.Value=18) ���ϵ����
 or (adoquery1rkey.Value=17) ���۶�������
 or (adoquery1rkey.Value=26) װ�䵥����
 or (adoquery1rkey.Value=56) ����/�˲ֵ���
 or (adoquery1rkey.Value=57) �ջ����� 
 or (adoquery1rkey.Value=2)  �ͻ�Ͷ�ߴ���
 then  //�ջ�����
   begin             //�������û����ĵĿ�����
            //�������û����ĵĿ�����
    n1.Enabled:=false;
    n2.Enabled:=false;
    n3.Enabled:=false;
    n4.Enabled:=false;
   end
 else
   begin
    n1.Enabled:=true;
    n2.Enabled:=true;
    n3.Enabled:=true;
    n4.Enabled:=true;
   END
   
   SELECT * FROM data0004 WHERE rkey IN (2,17,18,26,55,56,57,63)