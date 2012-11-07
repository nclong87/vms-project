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
hopdong_id_ in varchar2
) RETURN SYS_REFCURSOR AS
l_cursor SYS_REFCURSOR;
v_vcsql VARCHAR2(2000);
v_vcsqlwhere VARCHAR2(1000);
i NUMBER;
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
	v_vcsql := 'select rownum as rn,dulieu.* from (SELECT t.*,t0.SOHOPDONG,t0.LOAIHOPDONG,t0.DOITAC_ID,t2.TENDOITAC,FIND_PHULUC_BITHAYTHE(t.ID) as PHULUCBITHAYTHE FROM PHULUC t 
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
--  DDL for Function FIND_PHULUC_BITHAYTHE
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FIND_PHULUC_BITHAYTHE" (phuluc_id_ in varchar2) RETURN CLOB AS 
v_clob CLOB := '<root>';
BEGIN
  for rec in (select ID,TENPHULUC from PHULUC where DELETED = 0 and PHULUCTHAYTHE_ID = phuluc_id_) loop
	DBMS_LOB.append (v_clob,'<element>');
	DBMS_LOB.append (v_clob,'<id>'||rec.ID||'</id>');
	DBMS_LOB.append (v_clob,'<tenphuluc>'||rec.TENPHULUC||'</tenphuluc>');
	DBMS_LOB.append (v_clob,'</element>');
  end loop;
  DBMS_LOB.append (v_clob,'</root>');
  RETURN v_clob;
END FIND_PHULUC_BITHAYTHE;

/

