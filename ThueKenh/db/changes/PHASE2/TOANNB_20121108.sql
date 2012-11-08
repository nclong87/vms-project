--------------------------------------------------------
--  DDL for Function FIND_PHULUC_BY_HD_TT
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FIND_PHULUC_BY_HD_TT" (
iDisplayStart IN NUMBER,   
iDisplayLength IN NUMBER, 
thanhtoan_id_ in varchar2,
hopdong_id_ in varchar2
) RETURN SYS_REFCURSOR AS
l_cursor SYS_REFCURSOR;
v_vcsql VARCHAR2(2000);
v_vcsqlwhere VARCHAR2(1000);
i NUMBER;
BEGIN
	v_vcsqlwhere := ' t.DELETED = 0 ';
	if(thanhtoan_id_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and tp.THANHTOAN_ID = '||thanhtoan_id_||' ';
	end if;
	if(hopdong_id_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t.HOPDONG_ID = '||hopdong_id_||' ';
	end if;
	v_vcsql := 'select rownum as rn,dulieu.* from (SELECT t.*,t0.SOHOPDONG,t0.LOAIHOPDONG,t0.DOITAC_ID,t2.TENDOITAC FROM PHULUC t 
		left join HOPDONG t0 on t.HOPDONG_ID = t0.ID 
    left join THANHTOAN_PHULUC tp on tp.PHULUC_ID=t.ID
		left join DOITAC t2 on t0.DOITAC_ID = t2.ID  WHERE ' || v_vcsqlwhere || ' order by t.ID desc) dulieu ';
	v_vcsql := 'SELECT * FROM (' || v_vcsql || ') WHERE rn > ' || iDisplayStart || ' and rn <= ' || (iDisplayStart+iDisplayLength);
	--dbms_output.put_line(v_vcsql);
 --test(v_vcsql);
	OPEN l_cursor FOR v_vcsql;
	RETURN l_cursor;
END FIND_PHULUC_BY_HD_TT;

/

