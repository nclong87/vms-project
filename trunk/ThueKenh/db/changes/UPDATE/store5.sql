--------------------------------------------------------
--  DDL for Function FN_EXPORT_TUYENKENH
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FN_EXPORT_TUYENKENH" (
select_ in varchar2
) RETURN SYS_REFCURSOR AS
l_cursor SYS_REFCURSOR;
v_vcsql VARCHAR2(2000);
BEGIN
  v_vcsql := 'select '||select_||' from (select rownum as rn,t.*,TENDUAN,TENDOITAC,LOAIGIAOTIEP,TENPHONGBAN from TUYENKENH t left join LOAIGIAOTIEP t0 on t.GIAOTIEP_ID = t0.ID left join DUAN t1 on t.DUAN_ID = t1.ID left join PHONGBAN t2 on t.PHONGBAN_ID = t2.ID left join DOITAC t3 on t.DOITAC_ID = t3.ID where t.DELETED = 0) dulieu';
  OPEN l_cursor FOR v_vcsql;
  RETURN l_cursor;
END FN_EXPORT_TUYENKENH;

/

