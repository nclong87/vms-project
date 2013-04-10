--------------------------------------------------------
--  DDL for Function FN_ISLOCK_CTPL
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FN_ISLOCK_CTPL" (p_chitietphuluc_id IN NUMBER) RETURN NUMBER AS 
v_num NUMBER := 0;
BEGIN
    select count(*) into v_num from PHULUC where NAM is not null and DELETED = 0 and chitietphuluc_id = p_chitietphuluc_id;
    if(v_num > 0) then
        return 1;
  end if;
    RETURN 0;
END FN_ISLOCK_CTPL;

/

--------------------------------------------------------
--  DDL for Function FIND_PHULUC
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FIND_PHULUC" (
iDisplayStart IN NUMBER,
iDisplayLength IN NUMBER,
tenhopdong_ in varchar2,
tenphuluc_ in varchar2,
loaiphuluc_ in varchar2,
trangthai_ in varchar2,
ngayky_from in varchar2,
ngayky_end in varchar2,
ngayhieuluc_from in varchar2,
ngayhieuluc_end in varchar2,
hopdong_id_ in varchar2,
ischeckAvailable_ in varchar2,
ngayDSC_ in varchar2
) RETURN SYS_REFCURSOR AS
l_cursor SYS_REFCURSOR;
v_vcsql VARCHAR2(2000);
v_vcsqlwhere VARCHAR2(1000);
i NUMBER;
vDate date;
BEGIN
  v_vcsqlwhere := ' t.DELETED = 0 ';
  if(tenhopdong_ is not null) then
    v_vcsqlwhere := v_vcsqlwhere ||' and t0.ID = '''||tenhopdong_||''' ';
  end if;
  if(tenphuluc_ is not null) then
    v_vcsqlwhere := v_vcsqlwhere ||' and t.TENPHULUC like ''%'||tenphuluc_||'%'' ';
  end if;
  if(loaiphuluc_ is not null) then
    v_vcsqlwhere := v_vcsqlwhere ||' and t.LOAIPHULUC = '||loaiphuluc_||' ';
  end if;
  if(trangthai_ is not null) then
    v_vcsqlwhere := v_vcsqlwhere ||' and t.TRANGTHAI = '||trangthai_||' ';
  end if;
  if(ngayky_from is not null) then
    v_vcsqlwhere := v_vcsqlwhere ||' and t.NGAYKY >= TO_DATE('''||ngayky_from||''',''DD-MM-RRRR'') ';
  end if;
  if(ngayky_end is not null) then
    v_vcsqlwhere := v_vcsqlwhere ||' and t.NGAYKY <= TO_DATE('''||ngayky_end||''',''DD-MM-RRRR'') ';
  end if;
  if(ngayhieuluc_from is not null) then
    v_vcsqlwhere := v_vcsqlwhere ||' and t.NGAYHIEULUC >= TO_DATE('''||ngayhieuluc_from||''',''DD-MM-RRRR'') ';
  end if;
  if(ngayhieuluc_end is not null) then
    v_vcsqlwhere := v_vcsqlwhere ||' and t.NGAYHIEULUC <= TO_DATE('''||ngayhieuluc_end||''',''DD-MM-RRRR'') ';
  end if;
  if(hopdong_id_ is not null) then
    v_vcsqlwhere := v_vcsqlwhere ||' and t.HOPDONG_ID = '||hopdong_id_||' ';
  end if;
  if(ischeckavailable_ is not null) then
    v_vcsqlwhere := v_vcsqlwhere ||' and FN_PHULUC_AVAILABLE(t.ID,'''|| ngaydsc_ ||''')>0';
  end if;
  v_vcsql := 'select rownum as rn,dulieu.* from (SELECT t.*,t0.SOHOPDONG,t0.LOAIHOPDONG,t0.DOITAC_ID,t2.TENDOITAC,FIND_PHULUC_BITHAYTHE(t.ID) as PHULUCBITHAYTHE,case when NAM is null then 0 else 1 end as ISLOCK FROM PHULUC t
    left join HOPDONG t0 on t.HOPDONG_ID = t0.ID
    left join DOITAC t2 on t0.DOITAC_ID = t2.ID  WHERE ' || v_vcsqlwhere || ' order by t.ID desc) dulieu ';
  v_vcsql := 'SELECT * FROM (' || v_vcsql || ') WHERE rn > ' || iDisplayStart || ' and rn <= ' || (iDisplayStart+iDisplayLength);
  --dbms_output.put_line(v_vcsql);
 --test(v_vcsql);
  OPEN l_cursor FOR v_vcsql;
  RETURN l_cursor;
END FIND_PHULUC;

/

--------------------------------------------------------
--  DDL for Procedure PROC_DELETE_PHULUC
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "THUEKENH"."PROC_DELETE_PHULUC" (
pi_array in TABLE_VARCHAR,
usercreate_ in varchar2,
timeaction_ in number
) AS 
i INTEGER := 1;
BEGIN
	--for i in pi_array.first .. pi_array.last loop
	for rec in (SELECT *  FROM PHULUC  where DELETED = 0 and ID in (select * from table(pi_array))) loop
		update PHULUC set DELETED = timeaction_ where ID = rec.ID;
		PROC_INSERT_LICHSU_PHULUC(usercreate_,rec.ID,3,'');
    update SUCOKENH set PHULUC_ID = null where PHULUC_ID = rec.ID;
	end loop;
END PROC_DELETE_PHULUC;

/

