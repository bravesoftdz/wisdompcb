EP405�������Ϊ����
ԭ��������һ��BUG
�߹�  14:52:18
������  15:19:03������ʱ
delete data0056 where data0056.QTY_BACKLOG=0 and data0056.TO_BE_STOCKED=0

--��������56��������������������TO_BE_STOCKED 20130517 
update  data0056 set TO_BE_STOCKED= a.qty 
      from data0056  
        inner join ( Select sum(Data0053.quantity) as qty,data0056.rkey 
        From Data0053 
         inner join Data0056 on Data0053.d0056_ptr=Data0056.Rkey 
         inner join  Data0416 on Data0053.NPAD_PTR=Data0416.Rkey  
         Where isnull(data0053.dept_ptr,0)<>0  and Data0416.tStatus<>2  
          group by Data0056.Rkey  
          ) a  on data0056.rkey=a.rkey 
        where data0056.TO_BE_STOCKED<>a.qty 


--select  qty_backlog,to_be_stocked,*  from data0056 
     

��Ŀ�ʼ 23:24:29 
�Ѿ�����ˣ�����Ҳ��ʾ��������56��QTY_BACKLOG=0,������������ʼ�¼����ʱ����TO_BE_STOCKEDΪ����
��Ĭ�ǽ� 10:01:23 
 detailaq56['to_be_stocked']:=detailaq56['to_be_stocked']- Form1.ADOQuery1['quantity']; 
��Ĭ�ǽ� 10:02:09 
�����Ӧ�������Ӱ�
��Ĭ�ǽ� 10:03:14 
���ܵ�ʱû���������ֶε���˼
��Ĭ�ǽ� 10:06:02 
       begin
          detailaq56.Edit;
          detailaq56['to_be_stocked']:=detailaq56['to_be_stocked']- Form1.ADOQuery1['quantity'];  // �˵�������Ҫ�����������
          detailaq56['QTY_BACKLOG']:= detailaq56['QTY_BACKLOG']+ Form1.ADOQuery1['quantity'];  //�˵�������Ҫ������������ 
          detailaq56['to_be_cancd']:= detailaq56['to_be_cancd']- Form1.ADOQuery1['to_be_cancd'];  //�˵�������Ҫ��������β�� 
          detailaq56.Post;
        end;
��Ĭ�ǽ� 10:58:55 
EP405�ĵ�����ϸ�˻ص�WIPʱ��to_be_stocked���������⣬�ѷŵ��������ϣ����Ҹ���һ�� 



