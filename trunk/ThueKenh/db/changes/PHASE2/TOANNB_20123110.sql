--------------------------------------------------------
--  DDL for Function FIND_HOPDONG
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FIND_HOPDONG" (
iDisplayStart IN NUMBER,   
iDisplayLength IN NUMBER, 
doitac_id_ in varchar2,
sohopdong_ in varchar2,
loaihopdong_ in varchar2,
ngaykytu_ in varchar2,
ngaykyden_ in varchar2,
ngayhethantu_ in varchar2,
ngayhethanden_ in varchar2
) RETURN SYS_REFCURSOR AS
l_cursor SYS_REFCURSOR;
v_vcsql VARCHAR2(2000);
v_vcsqlwhere VARCHAR2(1000);
i NUMBER;
BEGIN
	v_vcsqlwhere := ' t.DELETED = 0 ';
	if(doitac_id_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t.DOITAC_ID = '||doitac_id_||' ';
	end if;
	if(sohopdong_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t.SOHOPDONG like ''%'||sohopdong_||'%'' ';
	end if;
	if(loaihopdong_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t.LOAIHOPDONG = '||loaihopdong_||' ';
	end if;
	if(ngaykytu_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t.NGAYKY >= TO_DATE('''||ngaykytu_||''',''DD-MM-RRRR'') ';
	end if;
  if(ngaykyden_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t.NGAYKY <= TO_DATE('''||ngaykyden_||''',''DD-MM-RRRR'') ';
	end if;
	if(ngayhethantu_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t.NGAYHETHAN >= TO_DATE('''||ngayhethantu_||''',''DD-MM-RRRR'') ';
	end if;
  if(ngayhethanden_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t.NGAYHETHAN <= TO_DATE('''||ngayhethanden_||''',''DD-MM-RRRR'') ';
	end if;
	v_vcsql := 'select rownum as rn,dulieu.* from (SELECT t.*,t0.TENDOITAC FROM HOPDONG t left join DOITAC t0 on t.DOITAC_ID = t0.ID WHERE ' || v_vcsqlwhere || ' order by t.ID desc) dulieu ';
	v_vcsql := 'SELECT * FROM (' || v_vcsql || ') WHERE rn > ' || iDisplayStart || ' and rn <= ' || (iDisplayStart+iDisplayLength);
	--dbms_output.put_line(v_vcsql);
 --test(v_vcsql);
	OPEN l_cursor FOR v_vcsql;
	RETURN l_cursor;
END FIND_HOPDONG;

/

