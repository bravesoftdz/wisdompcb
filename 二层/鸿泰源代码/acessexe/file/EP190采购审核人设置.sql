select user_login_name,user_full_name,data0077.*
from data0077 inner join data0073 on data0077.user_ptr=data0073.rkey
where ttype=1
order by seq_no

--ttype=0���ɹ���1���ⷢ�ɹ���2�������˻����̣�4:���ϵ�������