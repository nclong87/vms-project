CREATE SEQUENCE SEQ_DEXUAT INCREMENT BY 1 START WITH 1 MAXVALUE 9999 MINVALUE 1;

ALTER TABLE FILESCAN 
ADD (FILESIZE NUMBER DEFAULT 0 );

ALTER TABLE DEXUAT 
DROP COLUMN FILESCAN_ID;

ALTER TABLE DEXUAT 
ADD (FILENAME VARCHAR2(200) );

ALTER TABLE DEXUAT 
ADD (FILEPATH VARCHAR2(500) );

ALTER TABLE DEXUAT 
ADD (FILESIZE NUMBER );

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
		v_vcsqlwhere := v_vcsqlwhere ||' and t.TENVANBAN like '''||replace(tenvanban_, '*', '%')||''' ';
	end if;
	if(ngaydenghibangiao_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t.NGAYDENGHIBANGIAO = TO_DATE('''||ngaydenghibangiao_||''',''DD-MM-RRRR'') ';
	end if;
	if(ngaygui_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t.NGAYGUI = TO_DATE('''||ngaygui_||''',''DD-MM-RRRR'') ';
	end if;
	v_vcsql := 'select rownum as rn,dulieu.* from (SELECT t.ID,t.DOITAC_ID,t0.TENDOITAC,TENVANBAN,NGAYGUI,NGAYDENGHIBANGIAO,TRANGTHAI FROM DEXUAT t left join DOITAC t0 on t.DOITAC_ID = t0.ID WHERE ' || v_vcsqlwhere || ' order by t0.ID desc) dulieu ';
	v_vcsql := 'SELECT * FROM (' || v_vcsql || ') WHERE rn >= ' || iDisplayStart || ' and rn <= ' || (iDisplayStart+iDisplayLength);
	--dbms_output.put_line(v_vcsql);
 --test(v_vcsql);
	OPEN l_cursor FOR v_vcsql;
	RETURN l_cursor;
END FIND_DEXUAT;

/

--------------------------------------------------------
--  DDL for Function SAVE_DEXUAT
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."SAVE_DEXUAT" (
id_ in VARCHAR2,
doitac_id_ in VARCHAR2,
filename_ in VARCHAR2,
tenvanban_ in VARCHAR2,
ngaygui_ in VARCHAR2,
ngaydenghibangiao_ in VARCHAR2,
thongtinthem_ in VARCHAR2,
usercreate_ in VARCHAR2,
timecreate_ in VARCHAR2,
trangthai_ in VARCHAR2,
filepath_ in VARCHAR2,
filesize_ in VARCHAR2
) RETURN NUMBER AS
i INTEGER := 0;
BEGIN
	if(id_ is not null and id_>0) then --update
		update DEXUAT set DOITAC_ID = doitac_id_,FILENAME = filename_,FILEPATH = filepath_,FILESIZE = filesize_,TENVANBAN = tenvanban_,NGAYGUI = ngaygui_,NGAYDENGHIBANGIAO = ngaydenghibangiao_,THONGTINTHEM = thongtinthem_,TRANGTHAI = trangthai_ where ID = id_;
		i := id_;
	else --insert
		i:=SEQ_DEXUAT.nextval;
		
		insert into DEXUAT(ID, DOITAC_ID, TENVANBAN, NGAYGUI, NGAYDENGHIBANGIAO, THONGTINTHEM, HISTORY, USERCREATE, TIMECREATE, DELETED, TRANGTHAI,FILENAME,FILEPATH,FILESIZE) values (i, doitac_id_, tenvanban_, ngaygui_, ngaydenghibangiao_, thongtinthem_, '', usercreate_, timecreate_, 0, trangthai_,filename_,filepath_,filesize_);
	end if;
	return i;
END SAVE_DEXUAT;

/


