--------------------------------------------------------
--  DDL for Function BC_GIAMTRUMLL
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."BC_GIAMTRUMLL" (
pDoiTacId in varchar2,
pFrom in number,
pEnd in number
) RETURN SYS_REFCURSOR AS
l_cursor SYS_REFCURSOR;
BEGIN
  OPEN l_cursor FOR select t3.*,t.*,loaigiaotiep,t4.thanhtien,t5.tenphuluc,t6.sohopdong
    from sucokenh t 
      left join tuyenkenh t3 on t.tuyenkenh_id = t3.id
	  left join loaigiaotiep t2 on t3.giaotiep_id=t2.id
	  left join phuluc t5 on t5.id = t.PHULUC_ID
	  left join chitietphuluc_tuyenkenh t4 on t4.PHULUC_ID = t5.ID
	  left join hopdong t6 on t6.id = t5.hopdong_id
      where t4.tuyenkenh_id = t.TUYENKENH_ID and t.deleted = 0 and t.phuluc_id is not null and t.thoidiembatdau >= pFrom and t.thoidiembatdau < pEnd and t3.doitac_id = pDoiTacId;
  RETURN l_cursor;
END BC_GIAMTRUMLL;

/

