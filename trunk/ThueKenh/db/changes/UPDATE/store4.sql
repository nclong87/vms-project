--------------------------------------------------------
--  DDL for Function FIND_CHITIETPHULUC
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FIND_CHITIETPHULUC" (
iDisplayStart IN NUMBER,   
iDisplayLength IN NUMBER, 
tenchitietphuluc_ in varchar2
) RETURN SYS_REFCURSOR AS
l_cursor SYS_REFCURSOR;
v_vcsql VARCHAR2(2000);
v_vcsqlwhere VARCHAR2(1000);
i NUMBER;
BEGIN
	v_vcsqlwhere := ' t.DELETED = 0 ';
	if(tenchitietphuluc_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t.TENCHITIETPHULUC like ''%'||tenchitietphuluc_||'%'' ';
	end if;
	v_vcsql := 'select rownum as rn,dulieu.*,FN_ISLOCK_CTPL(dulieu.ID) as ISBLOCK from (SELECT t.* FROM CHITIETPHULUC t WHERE ' || v_vcsqlwhere || ' order by t.ID desc) dulieu ';
	v_vcsql := 'SELECT * FROM (' || v_vcsql || ') WHERE rn > ' || iDisplayStart || ' and rn <= ' || (iDisplayStart+iDisplayLength);
	--dbms_output.put_line(v_vcsql);
 --test(v_vcsql);
	OPEN l_cursor FOR v_vcsql;
	RETURN l_cursor;
END FIND_CHITIETPHULUC;

/

--------------------------------------------------------
--  DDL for Function FN_ISLOCK_CTPL
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FN_ISLOCK_CTPL" (p_chitietphuluc_id IN NUMBER) RETURN NUMBER AS 
v_num NUMBER := 0;
BEGIN
	select count(*) into v_num from PHULUC where DELETED = 0 and chitietphuluc_id = p_chitietphuluc_id;
	if(v_num > 0) then
		return 1;
  end if;
	RETURN 0;
END FN_ISLOCK_CTPL;

/

