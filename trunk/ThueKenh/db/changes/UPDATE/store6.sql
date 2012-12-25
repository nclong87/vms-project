--------------------------------------------------------
--  DDL for Function FN_GETTRANGTHAI
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FN_GETTRANGTHAI" 
(
  p_tuyenkenh_id IN varchar2,
  p_trangthai in number
) RETURN NUMBER AS 
v_num number := 0;
v_trangthai number := p_trangthai;
BEGIN
  if(v_trangthai is null) then
    select TRANGTHAI into v_trangthai from TUYENKENH where deleted = 0 and id = p_tuyenkenh_id;
  end if;
	select count(*) into v_num from phuluc t left join chitietphuluc_tuyenkenh t1 on t.CHITIETPHULUC_ID = t1.CHITIETPHULUC_ID
where t.deleted = 0 and t1.tuyenkenh_id = p_tuyenkenh_id and ( (t.ngayhethieuluc is null and t.ngayhieuluc  < sysdate + 1 ) or (t.ngayhethieuluc is not null and t.ngayhethieuluc >= sysdate and t.ngayhieuluc < sysdate + 1 ) );
	if(v_num > 0) then
		return 4;
	end if;
	RETURN v_trangthai;
END FN_GETTRANGTHAI;

/

--------------------------------------------------------
--  DDL for Function FN_GETPHULUC
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FN_GETPHULUC" 
(
  p_tuyenkenh_id IN varchar2
) RETURN VARCHAR2 AS 
v_phuluc_id number := 0;
BEGIN
	select t.ID into v_phuluc_id from phuluc t left join chitietphuluc_tuyenkenh t1 on t.CHITIETPHULUC_ID = t1.CHITIETPHULUC_ID
where t.deleted = 0 and t1.tuyenkenh_id = p_tuyenkenh_id and ( (t.ngayhethieuluc is null and t.ngayhieuluc  < sysdate + 1 ) or (t.ngayhethieuluc is not null and t.ngayhethieuluc >= sysdate and t.ngayhieuluc < sysdate + 1 ) );
	RETURN v_phuluc_id;
END FN_GETPHULUC;

/

--------------------------------------------------------
--  DDL for Function FN_FIND_TUYENKENH
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FN_FIND_TUYENKENH" (
iDisplayStart IN NUMBER,
iDisplayLength IN NUMBER,
makenh_ in varchar2,
loaigiaotiep_ in varchar2,
madiemdau_ in varchar2,
madiemcuoi_ in varchar2,
duan_ in varchar2,
doitac_ in varchar2,
phongban_ in varchar2,
ngaydenghibangiao_ in varchar2,
ngayhenbangiao_ in varchar2,
trangthai_ in varchar2,
flag_ in varchar2,
phuluc_id_ in varchar2
) RETURN SYS_REFCURSOR AS
l_cursor SYS_REFCURSOR;
v_vcsql VARCHAR2(2000);
v_vcsqlwhere VARCHAR2(1000);
i NUMBER;
BEGIN
  v_vcsqlwhere := ' t0.DELETED = 0 ';
  if(makenh_ is not null) then
    v_vcsqlwhere := v_vcsqlwhere ||' and t0.ID like '''||replace(makenh_, '*', '%')||'%'' ';
  end if;
  if(loaigiaotiep_ is not null) then
    v_vcsqlwhere := v_vcsqlwhere ||' and GIAOTIEP_ID = '||loaigiaotiep_||' ';
  end if;
  if(duan_ is not null) then
    v_vcsqlwhere := v_vcsqlwhere ||' and DUAN_ID = '||duan_||' ';
  end if;
  if(flag_ is not null) then
    v_vcsqlwhere := v_vcsqlwhere ||' and t0.FLAG = '||flag_||' ';
  end if;
  if(doitac_ is not null) then
    v_vcsqlwhere := v_vcsqlwhere ||' and t0.DOITAC_ID = '||doitac_||' ';
  end if;
  if(phongban_ is not null) then
    v_vcsqlwhere := v_vcsqlwhere ||' and PHONGBAN_ID = '||phongban_||' ';
  end if;
  if(trangthai_ is not null) then
    v_vcsqlwhere := v_vcsqlwhere ||' and FN_GETTRANGTHAI(t0.ID,t0.TRANGTHAI) = '||trangthai_||' ';
  end if;
  if(madiemdau_ is not null) then

    v_vcsqlwhere := v_vcsqlwhere ||' and MADIEMDAU like '''||replace(madiemdau_, '*', '%')||''' ';
  end if;
  if(madiemcuoi_ is not null) then
    v_vcsqlwhere := v_vcsqlwhere ||' and MADIEMCUOI like '''||replace(madiemcuoi_, '*', '%')||''' ';
  end if;
  if(ngaydenghibangiao_ is not null) then
    v_vcsqlwhere := v_vcsqlwhere ||' and NGAYDENGHIBANGIAO = TO_DATE('''||ngaydenghibangiao_||''',''DD-MM-RRRR'') ';
  end if;
  if(ngayhenbangiao_ is not null) then
    v_vcsqlwhere := v_vcsqlwhere ||' and NGAYHENBANGIAO = TO_DATE('''||ngayhenbangiao_||''',''DD-MM-RRRR'') ';
  end if;
   if(phuluc_id_ is not null) then
    v_vcsqlwhere := v_vcsqlwhere ||' and FN_GETPHULUC(t0.ID) = '||phuluc_id_||' ';
  end if;
  v_vcsql := 'select rownum as rn,dulieu.* from (SELECT t0.ID,MADIEMDAU,MADIEMCUOI,t1.LOAIGIAOTIEP,t0.DUNGLUONG,t0.SOLUONG,t2.TENDUAN,t0.GIAOTIEP_ID,t0.DUAN_ID,t0.PHONGBAN_ID,t0.DOITAC_ID,t3.TENPHONGBAN,t4.TENDOITAC,FN_GETTRANGTHAI(t0.ID,t0.TRANGTHAI) as TRANGTHAI FROM TUYENKENH t0 left join LOAIGIAOTIEP t1 on t0.GIAOTIEP_ID = t1.ID left join DUAN t2 on t0.DUAN_ID = t2.ID left join PHONGBAN t3 on t0.PHONGBAN_ID = t3.ID left join DOITAC t4 on t0.DOITAC_ID=t4.ID WHERE ' || v_vcsqlwhere || ' order by t0.TIMECREATE desc) dulieu ';
  v_vcsql := 'SELECT * FROM (' || v_vcsql || ') WHERE rn > ' || iDisplayStart || ' and rn <= ' || (iDisplayStart+iDisplayLength);
  --dbms_output.put_line(v_vcsql);
 --test(v_vcsql);
  OPEN l_cursor FOR v_vcsql;
  RETURN l_cursor;
END FN_FIND_TUYENKENH;

/

--------------------------------------------------------
--  DDL for Function FN_EXPORT_TUYENKENH
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FN_EXPORT_TUYENKENH" (
select_ in varchar2
) RETURN SYS_REFCURSOR AS
l_cursor SYS_REFCURSOR;
v_vcsql VARCHAR2(2000);
BEGIN
  v_vcsql := 'select '||select_||' from (select rownum as rn,t.ID,MADIEMDAU,t.MADIEMCUOI,t.DUNGLUONG,t.SOLUONG,t.GIAOTIEP_ID,t.DUAN_ID,t.PHONGBAN_ID,t.DOITAC_ID,TENDUAN,TENDOITAC,LOAIGIAOTIEP,TENPHONGBAN,FN_GETTRANGTHAI(t.ID,t.TRANGTHAI) as TRANGTHAI from TUYENKENH t left join LOAIGIAOTIEP t0 on t.GIAOTIEP_ID = t0.ID left join DUAN t1 on t.DUAN_ID = t1.ID left join PHONGBAN t2 on t.PHONGBAN_ID = t2.ID left join DOITAC t3 on t.DOITAC_ID = t3.ID where t.DELETED = 0) dulieu';
  OPEN l_cursor FOR v_vcsql;
  RETURN l_cursor;
END FN_EXPORT_TUYENKENH;

/

