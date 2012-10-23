ALTER TABLE TUYENKENH_IMPORT  
MODIFY (DUPLICATE VARCHAR(20) );

ALTER TABLE TUYENKENH_IMPORT  
MODIFY (DUPLICATE DEFAULT NULL );

--------------------------------------------------------
--  DDL for Procedure PROC_IMPORT_TUYENKENH
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "THUEKENH"."PROC_IMPORT_TUYENKENH" (
pi_array in TABLE_NUMBER,
usercreate_ in varchar2,
timecreate_ in date
) AS 
i INTEGER := 1;
madoitac varchar2(50);
matuyenkenh varchar2(20);
BEGIN
	for rec in (SELECT t.ID,t.MADIEMDAU, t.MADIEMCUOI, t0.ID as GIAOTIEP_ID, t1.ID as DUAN_ID, t2.ID as PHONGBAN_ID, t3.ID as DOITAC_ID, t.DUNGLUONG, t.SOLUONG,DUPLICATE,DOITAC_MA,t.TRANGTHAI FROM TUYENKENH_IMPORT t left join LOAIGIAOTIEP t0 on t.GIAOTIEP_MA = t0.MA left join DUAN t1 on t.DUAN_MA = t1.MA left join PHONGBAN t2 on t.PHONGBAN_MA = t2.MA left join DOITAC t3 on t.DOITAC_MA=t3.MA where t.ID in (select * from table(pi_array))) loop
		if(rec.DUPLICATE is not null) then --duplicate => update tuyenkenh
			update TUYENKENH set MADIEMDAU = rec.MADIEMDAU, MADIEMCUOI = rec.MADIEMCUOI, GIAOTIEP_ID = rec.GIAOTIEP_ID, DUAN_ID = rec.DUAN_ID, PHONGBAN_ID = rec.PHONGBAN_ID, DOITAC_ID = rec.DOITAC_ID, DUNGLUONG = rec.DUNGLUONG, SOLUONG = rec.SOLUONG, TRANGTHAI = rec.TRANGTHAI where ID = rec.DUPLICATE;
		else --insert
      i:=GET_SOTUYENKENH(rec.DOITAC_ID) + 1;
      matuyenkenh := rec.DOITAC_MA||'_'||TRIM(to_char(i,'0009'));
			insert into TUYENKENH(ID,MADIEMDAU,MADIEMCUOI,GIAOTIEP_ID,DUAN_ID,PHONGBAN_ID,DOITAC_ID,DUNGLUONG,TRANGTHAI,USERCREATE,TIMECREATE,DELETED,SOLUONG,TRANGTHAI_BAK) values (matuyenkenh,rec.MADIEMDAU,rec.MADIEMCUOI,rec.GIAOTIEP_ID,rec.DUAN_ID,rec.PHONGBAN_ID,rec.DOITAC_ID,rec.DUNGLUONG,rec.TRANGTHAI,usercreate_,timecreate_,0,rec.SOLUONG,0);
		end if;
    delete from TUYENKENH_IMPORT where ID = rec.ID;
	end loop;
END PROC_IMPORT_TUYENKENH;

/

--------------------------------------------------------
--  DDL for Function FIND_DEXUAT
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FIND_DEXUAT" (
iDisplayStart IN NUMBER,   
iDisplayLength IN NUMBER, 
doitac_id_ in varchar2,
tenvanban_ in varchar2,
ngaygui_ in varchar2,
ngaydenghibangiao_ in varchar2,
trangthai_ in varchar2
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
	if(trangthai_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t.TRANGTHAI = '||trangthai_||' ';
	end if;
	if(tenvanban_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t.TENVANBAN like ''%'||tenvanban_||'%'' ';
	end if;
	if(ngaydenghibangiao_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t.NGAYDENGHIBANGIAO = TO_DATE('''||ngaydenghibangiao_||''',''DD-MM-RRRR'') ';
	end if;
	if(ngaygui_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t.NGAYGUI = TO_DATE('''||ngaygui_||''',''DD-MM-RRRR'') ';
	end if;
	v_vcsql := 'select rownum as rn,dulieu.* from (SELECT t.ID,t.DOITAC_ID,t0.TENDOITAC,TENVANBAN,NGAYGUI,NGAYDENGHIBANGIAO,TRANGTHAI FROM DEXUAT t left join DOITAC t0 on t.DOITAC_ID = t0.ID WHERE ' || v_vcsqlwhere || ' order by t0.ID desc) dulieu ';
	v_vcsql := 'SELECT * FROM (' || v_vcsql || ') WHERE rn > ' || iDisplayStart || ' and rn <= ' || (iDisplayStart+iDisplayLength);
	--dbms_output.put_line(v_vcsql);
 --test(v_vcsql);
	OPEN l_cursor FOR v_vcsql;
	RETURN l_cursor;
END FIND_DEXUAT;

/

