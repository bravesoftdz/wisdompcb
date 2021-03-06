--exec EP100;120 24344

DECLARE @vptr INT

SET @vptr = 24344  /* ��Ʒ�ͺ�RKEY */

DECLARE @vptr2 INT
SELECT @vptr2 = rkey
FROM   data0273
WHERE  customer_part_ptr = @vptr

SELECT TOP 10 data0273.[RKEY],
       [CUSTOMER_PART_PTR],
       [COPYFROMCUST_PTR],
       [ENTERED_BY],
       [VERIFIED_BY],
       data0050.qty_on_hand,
       [ENTERED_DATE],
       [VERIFIED_DATE],
       [STATUS],
       [SOURCE],
       [TEXT1],
       RTRIM(a.customer_part_number) + ' ' + a.cp_rev AS TEXT2,
       [TEXT3],
       [TEXT4],
       [ECN_NO],
       [text],
       data0273.[remark],
       [Tooling_close],
       [last_modi_by_ptr],
       [last_modi_date],
       [DEPT1],
       [DEPT2],
       [DEPT3],
       [DEPT4],
       [DEPT5],
       [DEPT6],
       [DEPT7],
       [DEPT8],
       [DEPT9],
       [DEPT10],
       [DEPT11],
       [DEPT12],
       [DEPT13],
       [DEPT14],
       [DEPT15],
       [ECNB1],
       [ECNB2],
       [ECNB3],
       [ECNB4],
       [ECNB5],
       [ECNB6],
       [ECNB7],
       [ECNB8],
       [ECNB9],
       [ECNB10],
       [ECNA1],
       [ECNA2],
       [ECNA3],
       [ECNA4],
       [ECNA5],
       [ECNA6],
       [ECNA7],
       [ECNA8],
       [ECNA9],
       [ECNA10],
       [ECNSTART],
       [del],
       [del_empl_ptr],
       [del_date],
       tooling_1_flag,
       tooling_2_flag,
       tooling_3_flag,
       tooling_4_flag,
       tooling_5_flag,
       tooling_6_flag,
       tooling_7_flag,
       tooling_8_flag,
       tooling_9_flag,
       tooling_10_flag,
       tooling_11_flag,
       tooling_12_flag,
       tooling_13_flag,
       tooling_14_flag,
       tooling_15_flag,
       tooling_16_flag,
       tooling_17_flag,
       tooling_18_flag,
       tooling_19_flag,
       tooling_20_flag,
       tooling_21_flag,
       tooling_22_flag,
       tooling_23_flag,
       tooling_24_flag,
       tooling_25_flag,
       tooling_26_flag,
       tooling_27_flag,
       tooling_28_flag,
       tooling_29_flag,
       tooling_30_flag,
       tooling_31_flag,
       tooling_32_flag,
       tooling_33_flag,
       tooling_34_flag,
       tooling_35_flag,
       tooling_36_flag,
       tooling_1_rev_flag,
       tooling_2_rev_flag,
       tooling_3_rev_flag,
       tooling_4_rev_flag,
       tooling_5_rev_flag,
       tooling_6_rev_flag,
       tooling_7_rev_flag,
       tooling_8_rev_flag,
       tooling_9_rev_flag,
       tooling_10_rev_flag,
       tooling_11_rev_flag,
       tooling_12_rev_flag,
       tooling_13_rev_flag,
       tooling_14_rev_flag,
       tooling_15_rev_flag,
       tooling_16_rev_flag,
       tooling_17_rev_flag,
       tooling_18_rev_flag,
       tooling_19_rev_flag,
       tooling_20_rev_flag,
       tooling_21_rev_flag,
       tooling_22_rev_flag,
       tooling_23_rev_flag,
       tooling_24_rev_flag,
       tooling_25_rev_flag,
       tooling_26_rev_flag,
       tooling_27_rev_flag,
       tooling_28_rev_flag,
       tooling_29_rev_flag,
       tooling_30_rev_flag,
       tooling_31_rev_flag,
       tooling_32_rev_flag,
       tooling_33_rev_flag,
       tooling_34_rev_flag,
       tooling_35_rev_flag,
       tooling_36_rev_flag,
       data0050.customer_part_number,
       data0050.ALLOW_EDIT_FLAG,
       data0273.status,
       data0050.cp_rev,
       data0050.catalog_number,
       data0050.Last_modified_date,
       data0050.Last_modified_by_ptr,
       b.employee_name             AS audited_by_name_1,
       Data0273.checked_by_date    AS audited_by_date_1,
       c.employee_name             AS audited_by_name_2,
       Data0273.audited_by_date    AS audited_by_date_2,
       d.employee_name             AS audited_by_name_3,
       Data0273.audited_by_date_2  AS audited_by_date_3,
       e.employee_name             AS audited_by_name_4,
       Data0273.audited_by_date_3  AS audited_by_date_4,
       f.employee_name             AS creator_name,
       DATA0050.RKEY               AS RKEY50,
       data0005.employee_name
FROM   data0273
       LEFT OUTER JOIN data0050
            ON  data0273.customer_part_ptr = data0050.rkey
       LEFT OUTER JOIN data0050 a
            ON  data0273.COPYFROMCUST_PTR = a.rkey
       LEFT OUTER JOIN data0005
            ON  data0273.VERIFIED_BY = data0005.rkey
       LEFT OUTER JOIN data0005 b
            ON  data0273.checked_by_ptr = b.rkey
       LEFT OUTER JOIN data0005 c
            ON  data0273.audited_by_ptr = c.rkey
       LEFT OUTER JOIN data0005 d
            ON  data0273.audited_by_ptr_2 = d.rkey
       LEFT OUTER JOIN data0005 e
            ON  data0273.audited_by_ptr_3 = e.rkey
       LEFT OUTER JOIN data0005 f
            ON  data0273.ENTERED_BY = f.rkey
WHERE  data0273.rkey = @vptr2
