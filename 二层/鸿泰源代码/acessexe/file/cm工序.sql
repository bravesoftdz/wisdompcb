SELECT rkey,* FROM data0034 WHERE dept_name LIKE '����%'

SELECT rkey,* FROM data0034 WHERE dept_ptr in (SELECT rkey FROM data0034 WHERE dept_name LIKE '����%')--�����顢����

SELECT * FROM data0505 WHERE DEPT_PTR IN (SELECT rkey FROM data0034 WHERE dept_ptr in(SELECT rkey FROM data0034 WHERE dept_name LIKE '����%')) --ģ��

SELECT * FROM data0038 WHERE dept_ptr IN(SELECT rkey FROM data0034 WHERE dept_name LIKE '����%')--���ù���MI��Ĺ���

SELECT * FROM data0494 WHERE ROUTE_STEP_PTR IN (SELECT rkey FROM data0038 WHERE dept_ptr IN(SELECT rkey FROM data0034 WHERE dept_name LIKE '����%'))--���ù���MI��Ĺ������

SELECT * FROM data0048 WHERE FM_DEPT_PTR IN (SELECT rkey FROM data0034 WHERE dept_ptr in(SELECT rkey FROM data0034 WHERE dept_name LIKE '����%')) OR TO_DEPT_PTR IN (SELECT rkey FROM data0034 WHERE dept_ptr in(SELECT rkey FROM data0034 WHERE dept_name LIKE '����%'))--������¼

SELECT qty_backlog, * FROM data0056 WHERE DEPT_PTR IN (SELECT rkey FROM data0038 WHERE dept_ptr IN(SELECT rkey FROM data0034 WHERE dept_name LIKE '����%')) --���ߵ�,Ҫ����û����

SELECT * FROM data0207 WHERE DEPT_PTR IN (SELECT rkey FROM data0038 WHERE dept_ptr IN(SELECT rkey FROM data0034 WHERE dept_name LIKE '����%'))

