--------------------------------------------------------
--  DDL for Function FIND_PHULUC_HIEULUC
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FIND_PHULUC_HIEULUC" (
tuyenkenh_id_ in varchar2,
date_ in date
) RETURN SYS_REFCURSOR AS
l_cursor SYS_REFCURSOR;
BEGIN
	OPEN l_cursor FOR select t.*,t1.DONGIA,t1.THANHTIEN from phuluc t left join chitietphuluc_tuyenkenh t1 on t.CHITIETPHULUC_ID = t1.CHITIETPHULUC_ID
where t.deleted = 0 and t1.tuyenkenh_id = tuyenkenh_id_ and ( (t.ngayhethieuluc is null and t.ngayhieuluc  < date_ + 1 ) or (t.ngayhethieuluc is not null and t.ngayhethieuluc >= date_ and t.ngayhieuluc < date_ + 1 ) );
	RETURN l_cursor;
END FIND_PHULUC_HIEULUC;

/

