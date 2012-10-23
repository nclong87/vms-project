ALTER TABLE TRAM 
DROP COLUMN KHUVUC_ID;

ALTER TABLE TRAM
ADD CONSTRAINT TRAM_UK1 UNIQUE 
(
  MATRAM 
)
ENABLE;

INSERT INTO "THUEKENH"."MENU" (ID, NAMEMENU, ACTION, ACTIVE, IDROOTMENU) VALUES ('26', 'Trạm đầu cuối', '/danhmuc/tram.action', '1', '8');

CREATE SEQUENCE SEQ_TRAM INCREMENT BY 1 START WITH 1 MAXVALUE 99999 MINVALUE 1;

--------------------------------------------------------
--  DDL for Function FIND_TRAM
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FIND_TRAM" (
iDisplayStart IN NUMBER,   
iDisplayLength IN NUMBER, 
matram_ in varchar2,
diachi_ in varchar2
) RETURN SYS_REFCURSOR AS
l_cursor SYS_REFCURSOR;
v_vcsql VARCHAR2(2000);
v_vcsqlwhere VARCHAR2(1000);
i NUMBER;
BEGIN
	v_vcsqlwhere := ' t.DELETED = 0 ';
	if(matram_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t.MATRAM like '''||replace(matram_, '*', '%')||'%'' ';
	end if;
	if(diachi_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t.DIACHI like '''||replace(diachi_, '*', '%')||'%'' ';
	end if;
	v_vcsql := 'select rownum as rn,dulieu.* from (SELECT t.* FROM TRAM t WHERE ' || v_vcsqlwhere || ' order by t.ID desc) dulieu ';
	v_vcsql := 'SELECT * FROM (' || v_vcsql || ') WHERE rn > ' || iDisplayStart || ' and rn <= ' || (iDisplayStart+iDisplayLength);
	--dbms_output.put_line(v_vcsql);
 --test(v_vcsql);
	OPEN l_cursor FOR v_vcsql;
	RETURN l_cursor;
END FIND_TRAM;

/

--------------------------------------------------------
--  DDL for Function SAVE_TRAM
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."SAVE_TRAM" (
id_ in VARCHAR2,
matram_ in VARCHAR2,
diachi_ in VARCHAR2
) RETURN NUMBER AS
i INTEGER := 0;
BEGIN
	if(id_ is not null and id_>0) then --update
		update TRAM set MATRAM = matram_, DIACHI = diachi_ where ID = id_;
		i := id_;
	else --insert
		i:= SEQ_TRAM.nextval;
		insert into TRAM(ID, MATRAM, DIACHI, DELETED) values (i, matram_, diachi_, 0);
	end if;
	return i;
END SAVE_TRAM;

/


