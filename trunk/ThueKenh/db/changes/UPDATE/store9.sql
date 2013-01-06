--------------------------------------------------------
--  DDL for Function FN_EXPORT_TUYENKENH
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FN_EXPORT_TUYENKENH" (
select_ in varchar2,
flag_ in number
) RETURN SYS_REFCURSOR AS
l_cursor SYS_REFCURSOR;
v_vcsql VARCHAR2(2000);
v_join VARCHAR2(2000);
BEGIN
  v_vcsql := 'select '||select_||' from (select rownum as rn,t.ID,MADIEMDAU,t.MADIEMCUOI,t.DUNGLUONG,t.SOLUONG,t.GIAOTIEP_ID,t.DUAN_ID,t.PHONGBAN_ID,t.DOITAC_ID,TENDUAN,TENDOITAC,LOAIGIAOTIEP,TENPHONGBAN,FN_GETTRANGTHAI(t.ID,t.TRANGTHAI) as TRANGTHAI from TUYENKENH t left join LOAIGIAOTIEP t0 on t.GIAOTIEP_ID = t0.ID left join DUAN t1 on t.DUAN_ID = t1.ID left join PHONGBAN t2 on t.PHONGBAN_ID = t2.ID left join DOITAC t3 on t.DOITAC_ID = t3.ID where t.DELETED = 0) ds1';
  if(flag_ = 1) then
    v_vcsql := v_vcsql || ' left join (select TENPHULUC,SOHOPDONG,TUYENKENH_ID from phuluc t left join chitietphuluc_tuyenkenh t1 on t.CHITIETPHULUC_ID = t1.CHITIETPHULUC_ID left join hopdong t2 on t.HOPDONG_ID = t2.ID
where t.deleted = 0 and ( (t.ngayhethieuluc is null and t.ngayhieuluc  < sysdate + 1 ) or (t.ngayhethieuluc is not null and t.ngayhethieuluc >= sysdate and t.ngayhieuluc < sysdate + 1 ) )) ds2 on ds1.ID=ds2.TUYENKENH_ID';
  end if;
  OPEN l_cursor FOR v_vcsql;
  RETURN l_cursor;
END FN_EXPORT_TUYENKENH;

/

