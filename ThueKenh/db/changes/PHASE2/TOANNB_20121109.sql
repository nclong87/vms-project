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
	v_vcsql := 'select rownum as rn,dulieu.* from (SELECT t.*,t0.SOHOPDONG,t0.LOAIHOPDONG,t0.DOITAC_ID,t2.TENDOITAC,FIND_PHULUC_BITHAYTHE(t.ID) as PHULUCBITHAYTHE FROM PHULUC t 
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

--------------------------------------------------------
--  DDL for Function FIND_HOSOTHANHTOAN
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FIND_HOSOTHANHTOAN" (
iDisplayStart IN NUMBER,   
iDisplayLength IN NUMBER, 
sohoso_ in varchar2,
ngaychuyenhosotu_ in varchar2,
ngaychuyenhosoden_ in varchar2,
trangthai_ in varchar2
) RETURN SYS_REFCURSOR AS
l_cursor SYS_REFCURSOR;
v_vcsql VARCHAR2(2000);
v_vcsqlwhere VARCHAR2(1000);
i NUMBER;
BEGIN
	v_vcsqlwhere := ' DELETED =0 ';
	if(sohoso_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and SOHOSO = '''||sohoso_||''' ';
	end if;
	if(ngaychuyenhosotu_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and NGAYCHUYENKT >= TO_DATE('''||ngaychuyenhosotu_||''',''DD-MM-RRRR'') ';
	end if;
  if(ngaychuyenhosoden_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and NGAYCHUYENKT <= TO_DATE('''||ngaychuyenhosoden_||''',''DD-MM-RRRR'') ';
	end if;
  if(trangthai_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and TRANGTHAI = '||trangthai_||' ';
	end if;
	v_vcsql := 'select rownum as rn,dulieu.* from (SELECT * FROM THANHTOAN WHERE ' || v_vcsqlwhere || ' order by TIMECREATE desc) dulieu ';
	v_vcsql := 'SELECT * FROM (' || v_vcsql || ') WHERE rn > ' || iDisplayStart || ' and rn <= ' || (iDisplayStart+iDisplayLength);
	--dbms_output.put_line(v_vcsql);
 --test(v_vcsql);
	OPEN l_cursor FOR v_vcsql;
	RETURN l_cursor;
END FIND_HOSOTHANHTOAN;

/

--------------------------------------------------------
--  DDL for Sequence SEQ_THANHTOAN
--------------------------------------------------------

   CREATE SEQUENCE  "THUEKENH"."SEQ_THANHTOAN"  MINVALUE 1 MAXVALUE 9999 INCREMENT BY 1 START WITH 41 CACHE 20 NOORDER  NOCYCLE ;
--------------------------------------------------------
--  DDL for Function SAVE_THANHTOAN_PHUCLUC
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."SAVE_THANHTOAN_PHUCLUC" 
(
  thanhtoan_id_ in varchar2,
  phuluc_id_ in varchar2
)
RETURN NUMBER AS i INTEGER :=0; 
BEGIN
    INSERT INTO THANHTOAN_PHULUC(THANHTOAN_ID,PHULUC_ID) VALUES (thanhtoan_id_,phuluc_id_);
END SAVE_THANHTOAN_PHUCLUC;

/

--------------------------------------------------------
--  DDL for Function SAVE_HOPDONG
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."SAVE_HOPDONG" (
id_ in VARCHAR2,
doitac_id_ in VARCHAR2,
sohopdong_ in VARCHAR2,
loaihopdong_ in VARCHAR2,
ngayky_ in VARCHAR2,
ngayhethan_ in VARCHAR2,
usercreate_ in VARCHAR2,
timecreate_ in VARCHAR2,
history_ in VARCHAR2
) RETURN NUMBER AS
i INTEGER := 0;
BEGIN
	if(id_ is not null) then --update
		update HOPDONG set DOITAC_ID = doitac_id_,SOHOPDONG = sohopdong_,LOAIHOPDONG = loaihopdong_,NGAYKY = ngayky_,NGAYHETHAN = ngayhethan_,HISTORY = history_ where ID = id_;
		i := id_;
	else --insert
		i:=SEQ_HOPDONG.nextval;
		
		insert into HOPDONG(ID,DOITAC_ID,SOHOPDONG,LOAIHOPDONG,NGAYKY,NGAYHETHAN,TRANGTHAI,USERCREATE,TIMECREATE,HISTORY,DELETED) values (i, doitac_id_, sohopdong_, loaihopdong_, ngayky_, ngayhethan_,0, usercreate_, timecreate_, history_,0);
	end if;
	return i;
END SAVE_HOPDONG;

/

--------------------------------------------------------
--  DDL for Function FN_FIND_SUCO_BY_THANHTOAN
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FN_FIND_SUCO_BY_THANHTOAN" 
(
  thanhtoan_id_ in varchar2
) 
RETURN SYS_REFCURSOR AS l_cursor SYS_REFCURSOR;
v_vcsql VARCHAR2(2000);
v_vcsqlwhere VARCHAR2(1000);
i NUMBER;
BEGIN
	v_vcsqlwhere := ' DELETED = 0 ';
  if(thanhtoan_id_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and THANHTOAN_ID='||thanhtoan_id_||' ';
	end if;
	v_vcsql := 'select rownum as rn,dulieu.* from (SELECT *
                                                 FROM SUCOKENH 
                                                 WHERE ' || v_vcsqlwhere || ') dulieu ';
	v_vcsql := 'SELECT * FROM (' || v_vcsql || ')';
	--dbms_output.put_line(v_vcsql);
  --test(v_vcsql);
	OPEN l_cursor FOR v_vcsql;
	RETURN l_cursor;
END FN_FIND_SUCO_BY_THANHTOAN;

/

--------------------------------------------------------
--  DDL for Function FN_FIND_PHULUCBY_THANHTOAN
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FN_FIND_PHULUCBY_THANHTOAN" 
(
  thanhtoan_id_ in varchar2,
  hopdong_id_ in varchar2
) 
RETURN SYS_REFCURSOR AS l_cursor SYS_REFCURSOR;
v_vcsql VARCHAR2(2000);
i NUMBER;
BEGIN
	v_vcsql := 'select rownum as rn,dulieu.* from (SELECT tp.PHULUC_ID
                                                 FROM THANHTOAN_PHULUC tp INNER JOIN PHULUC p ON tp.PHULUC_ID=p.ID   
                                                 WHERE tp.THANHTOAN_ID=' || thanhtoan_id_ || ' AND p.HOPDONG_ID=' || hopdong_id_ || ') dulieu ';
	OPEN l_cursor FOR v_vcsql;
	RETURN l_cursor;
END FN_FIND_PHULUCBY_THANHTOAN;

/

--------------------------------------------------------
--  DDL for Function FN_FIND_HOPDONGBY_THANHTOAN
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FN_FIND_HOPDONGBY_THANHTOAN" 
(
  thanhtoan_id_ in varchar2
) 
RETURN SYS_REFCURSOR AS l_cursor SYS_REFCURSOR;
v_vcsql VARCHAR2(2000);
i NUMBER;
BEGIN
	v_vcsql := 'select rownum as rn,dulieu.* from (SELECT DISTINCT hd.*,dt.TENDOITAC
                                                 FROM THANHTOAN_PHULUC tp INNER JOIN PHULUC p ON tp.PHULUC_ID=p.ID 
                                                 INNER JOIN HOPDONG hd ON hd.ID=p.HOPDONG_ID 
                                                 INNER JOIN DOITAC dt ON hd.DOITAC_ID=dt.ID
                                                 WHERE tp.THANHTOAN_ID=' || thanhtoan_id_ || ') dulieu ';
	OPEN l_cursor FOR v_vcsql;
	RETURN l_cursor;
END FN_FIND_HOPDONGBY_THANHTOAN;

/

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
	v_vcsql := 'select rownum as rn,dulieu.* from (SELECT t.*,t0.SOHOPDONG,t0.LOAIHOPDONG,t0.DOITAC_ID,t2.TENDOITAC,FIND_PHULUC_BITHAYTHE(t.ID) as PHULUCBITHAYTHE FROM PHULUC t 
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

--------------------------------------------------------
--  DDL for Function FIND_HOSOTHANHTOAN
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FIND_HOSOTHANHTOAN" (
iDisplayStart IN NUMBER,   
iDisplayLength IN NUMBER, 
sohoso_ in varchar2,
ngaychuyenhosotu_ in varchar2,
ngaychuyenhosoden_ in varchar2,
trangthai_ in varchar2
) RETURN SYS_REFCURSOR AS
l_cursor SYS_REFCURSOR;
v_vcsql VARCHAR2(2000);
v_vcsqlwhere VARCHAR2(1000);
i NUMBER;
BEGIN
	v_vcsqlwhere := ' DELETED =0 ';
	if(sohoso_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and SOHOSO = '''||sohoso_||''' ';
	end if;
	if(ngaychuyenhosotu_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and NGAYCHUYENKT >= TO_DATE('''||ngaychuyenhosotu_||''',''DD-MM-RRRR'') ';
	end if;
  if(ngaychuyenhosoden_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and NGAYCHUYENKT <= TO_DATE('''||ngaychuyenhosoden_||''',''DD-MM-RRRR'') ';
	end if;
  if(trangthai_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and TRANGTHAI = '||trangthai_||' ';
	end if;
	v_vcsql := 'select rownum as rn,dulieu.* from (SELECT * FROM THANHTOAN WHERE ' || v_vcsqlwhere || ' order by TIMECREATE desc) dulieu ';
	v_vcsql := 'SELECT * FROM (' || v_vcsql || ') WHERE rn > ' || iDisplayStart || ' and rn <= ' || (iDisplayStart+iDisplayLength);
	--dbms_output.put_line(v_vcsql);
 --test(v_vcsql);
	OPEN l_cursor FOR v_vcsql;
	RETURN l_cursor;
END FIND_HOSOTHANHTOAN;

/

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


