��������qty_allocԤ��������qty_allocated

--------------------------------
��������qty_alloc
select * from data0053 where qty_alloc<0

select data0415.status,data0465.* from data0465 join data0415 on data0465.heard_ptr=data0415.rkey 
where data0415.status in (1,2,5)


select d0053_ptr,sum(data0465.quantity) to_be_out from data0465 join data0415 on data0465.heard_ptr=data0415.rkey 
where data0415.status in (1,2,5)   --״̬1,2,3,4,5���ύ,������,�ѳ���,���ؼ�,���˻�
group by d0053_ptr

��ʼ��������ִ�������
update data0053 set qty_alloc=a. to_be_out
from data0053 ,(
select d0053_ptr,sum(data0465.quantity) to_be_out from data0465 join data0415 on data0465.heard_ptr=data0415.rkey 
where data0415.status in (1,2,5)  --״̬1,2,3,4,5���ύ,������,�ѳ���,���ؼ�,���˻�
group by d0053_ptr) a
where a.d0053_ptr=data0053.rkey and data0053.qty_alloc<0

update data0053 set qty_alloc=0 where qty_alloc<0

------------------------
Ԥ��������qty_allocated


update data0053 set qty_allocated=0
UPDATE data0053
SET qty_allocated =
          (SELECT SUM(QUAN_ALLOCATED)
         FROM data0063
         GROUP BY data0063.part_batch_ptr
         HAVING data0053.rkey = data0063.part_batch_ptr)
FROM data0053, data0063
WHERE data0053.rkey = data0063.part_batch_ptr



-------------------------------------

--��������56��������������������TO_BE_STOCKED 20130517 
update  data0056 set TO_BE_STOCKED= a.qty 
      from data0056  
        inner join ( Select sum(Data0053.quantity) as qty,data0056.rkey 
        From Data0053 
         inner join Data0056 on Data0053.d0056_ptr=Data0056.Rkey 
         inner join  Data0416 on Data0053.NPAD_PTR=Data0416.Rkey  
         Where isnull(data0053.dept_ptr,0)<>0  and Data0416.tStatus<>2  --1�����2�����3���˻�
          group by Data0056.Rkey  
          ) a  on data0056.rkey=a.rkey 
        where data0056.TO_BE_STOCKED<>a.qty 
