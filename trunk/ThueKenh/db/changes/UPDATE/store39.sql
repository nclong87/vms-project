--------------------------------------------------------
--  DDL for Function FIND_SUCOBYPHULUC2
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FIND_SUCOBYPHULUC2" (
pPhuLucId in varchar2
) RETURN SYS_REFCURSOR AS
l_cursor SYS_REFCURSOR;
-- lay ra danh sach su co ko thuoc phu luc pPhuLucId sau khi edit
BEGIN
  OPEN l_cursor FOR select t0.ID,t0.TUYENKENH_ID,t0.thoigianmll,thoidiembatdau,t1.PHULUC_ID,t1.DONGIA from sucokenh t0 left join chitietphuluc_tuyenkenh t1 on t0.TUYENKENH_ID = t1.TUYENKENH_ID left join phuluc t on t.CHITIETPHULUC_ID = t1.CHITIETPHULUC_ID where t0.deleted =0 and t0.PHULUC_ID = pPhuLucId and t.ID != t0.PHULUC_ID and t.deleted = 0 and ( (t.ngayhethieuluc is null and t.ngayhieuluc  < MILISECOND2DATE(t0.THOIDIEMBATDAU) + 1 ) or (t.ngayhethieuluc is not null and t.ngayhethieuluc >= MILISECOND2DATE(t0.THOIDIEMBATDAU) and t.ngayhieuluc < MILISECOND2DATE(t0.THOIDIEMBATDAU) + 1 ) );
  RETURN l_cursor;
END FIND_SUCOBYPHULUC2;

/

