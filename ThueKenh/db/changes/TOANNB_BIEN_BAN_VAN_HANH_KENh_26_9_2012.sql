--------------------------------------------------------
--  DDL for Table BIENBANVANHANH
--------------------------------------------------------

  ALTER TABLE BIENBANVANHANH 
ADD (FILENAME VARCHAR2(200) );

ALTER TABLE BIENBANVANHANH 
ADD (FILEPATH VARCHAR2(200) );

ALTER TABLE BIENBANVANHANH 
ADD (FILESIZE NUMBER );


  --------------------------------------------------------
--  DDL for Function FN_FIND_BIENBANVANHANHKENH
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FN_FIND_BIENBANVANHANHKENH" 
(
  iDisplayStart IN NUMBER,   
  iDisplayLength IN NUMBER, 
  sobienban_ in varchar2
) 
RETURN SYS_REFCURSOR AS l_cursor SYS_REFCURSOR;
v_vcsql VARCHAR2(2000);
v_vcsqlwhere VARCHAR2(1000);
i NUMBER;
BEGIN
	v_vcsqlwhere := ' DELETED = 0 ';
	if(sobienban_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' AND SOBIENBAN = '''||sobienban_||''' ';
	end if;
	v_vcsql := 'select rownum as rn,dulieu.* from (SELECT *
                                                 FROM BIENBANVANHANH   
                                                 WHERE ' || v_vcsqlwhere || ' ORDER BY TIMECREATE desc) dulieu ';
	v_vcsql := 'SELECT * FROM (' || v_vcsql || ') WHERE rn >= ' || iDisplayStart || ' and rn <= ' || (iDisplayStart+iDisplayLength);
	--dbms_output.put_line(v_vcsql);
  --test(v_vcsql);
	OPEN l_cursor FOR v_vcsql;
	RETURN l_cursor;
END FN_FIND_BIENBANVANHANHKENH;

/

--------------------------------------------------------
--  DDL for Function SAVE_BIENBANVANHANH
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."SAVE_BIENBANVANHANH" 
(
  id_ in varchar2,
  sobienban_ in varchar2,
  usercreate_ in varchar2,
  timecreate_ in varchar2,
  deleted_ in varchar2,
  filename_ in varchar2,
  filepath_ in varchar2,
  filesize_ in varchar2
)
RETURN NUMBER AS i INTEGER :=0; 
BEGIN
  IF(id_ IS NOT NULL AND id_ >0) THEN --update
    UPDATE BIENBANVANHANH 
    SET 
        SOBIENBAN= sobienban_, 
        USERCREATE= usercreate_,
        TIMECREATE= timecreate_,
        DELETED= deleted_,
        FILENAME= filename_,
        FILEPATH= filepath_,
        FILESIZE= filesize_
    WHERE ID= id_;
    i:= id_;
  ELSE -- insert
    i:=SEQ_SUCO.nextval;
    INSERT INTO BIENBANVANHANH(ID,SOBIENBAN,USERCREATE,TIMECREATE,DELETED,FILENAME,FILEPATH,FILESIZE) VALUES (i,sobienban_, usercreate_, timecreate_, 0,filename_, filepath_, filesize_);
  END IF;
  RETURN i;
END SAVE_BIENBANVANHANH;

/

--------------------------------------------------------
--  DDL for Function FN_FIND_BIENBANVANHANHKENH
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FN_FIND_BIENBANVANHANHKENH" 
(
  iDisplayStart IN NUMBER,   
  iDisplayLength IN NUMBER, 
  sobienban_ in varchar2
) 
RETURN SYS_REFCURSOR AS l_cursor SYS_REFCURSOR;
v_vcsql VARCHAR2(2000);
v_vcsqlwhere VARCHAR2(1000);
i NUMBER;
BEGIN
	v_vcsqlwhere := ' DELETED = 0 ';
	if(sobienban_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' AND SOBIENBAN = '''||sobienban_||''' ';
	end if;
	v_vcsql := 'select rownum as rn,dulieu.* from (SELECT *
                                                 FROM BIENBANVANHANH   
                                                 WHERE ' || v_vcsqlwhere || ' ORDER BY TIMECREATE desc) dulieu ';
	v_vcsql := 'SELECT * FROM (' || v_vcsql || ') WHERE rn > ' || iDisplayStart || ' and rn <= ' || (iDisplayStart+iDisplayLength);
	--dbms_output.put_line(v_vcsql);
  --test(v_vcsql);
	OPEN l_cursor FOR v_vcsql;
	RETURN l_cursor;
END FN_FIND_BIENBANVANHANHKENH;

/

--------------------------------------------------------
--  DDL for Function FN_FIND_SUCO
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FN_FIND_SUCO" 
(
  iDisplayStart IN NUMBER,   
  iDisplayLength IN NUMBER, 
  tuyenkenh_id_ in varchar2,
  diemdau_ in varchar2,
  diemcuoi_ in varchar2,
  dungluong_ in varchar2,
  thoidiembatdau_ in varchar2,
  thoidiemketthuc_ in varchar2,
  nguoixacnhan_ in varchar2,
  bienbanvanhhanh_id_ in varchar2
) 
RETURN SYS_REFCURSOR AS l_cursor SYS_REFCURSOR;
v_vcsql VARCHAR2(2000);
v_vcsqlwhere VARCHAR2(1000);
i NUMBER;
BEGIN
	v_vcsqlwhere := ' sc.DELETED = 0 ';
	if(tuyenkenh_id_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' AND sc.TUYENKENH_ID = '||tuyenkenh_id_||' ';
	end if;
  dbms_output.put_line(diemdau_);
	if(diemdau_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' AND t.MADIEMDAU = '''||diemdau_||''' ';
	end if;
	if(diemcuoi_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' AND t.MADIEMCUOI = '''||diemcuoi_||''' ';
	end if;
	if(dungluong_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t.DUNGLUONG = '||dungluong_ ||' ';
	end if;
	if(thoidiembatdau_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and sc.THOIDIEMBATDAU = TO_DATE('''||thoidiembatdau_||''',''DD/MM/YYYY HH24:MI:SS'') ';
	end if;
	if(thoidiemketthuc_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and sc.THOIDIEMKETTHUC = TO_DATE('''||thoidiemketthuc_||''',''DD/MM/YYYY HH24:MI:SS'') ';
	end if;
	if(nguoixacnhan_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and sc.NGUOIXACNHAN like ''%'||replace(nguoixacnhan_, '*', '%')||'%'' ';
	end if;
  if(bienbanvanhhanh_id_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and vs.BIENBAN_ID='||bienbanvanhhanh_id_||' ';
	end if;
	v_vcsql := 'select rownum as rn,dulieu.* from (SELECT sc.id suco_id,t.ID tuyenkenh_id,t.MADIEMDAU,t.MADIEMCUOI,gt.LOAIGIAOTIEP,t.DUNGLUONG,t.SOLUONG,sc.THOIDIEMBATDAU,sc.THOIDIEMKETTHUC,
                                                        sc.THOIGIANMLL,sc.NGUYENNHAN,sc.PHUONGANXULY,sc.NGUOIXACNHAN,sc.FILENAME,sc.FILEPATH,sc.FILESIZE,sc.USERCREATE,sc.TIMECREATE
                                                 FROM VANHANH_SUCOKENH vs RIGHT JOIN SUCOKENH sc ON vs.sucokenh_id=sc.id 
                                                      LEFT JOIN TUYENKENH t ON sc.TUYENKENH_ID = t.ID 
                                                      LEFT JOIN LOAIGIAOTIEP gt ON t.GIAOTIEP_ID=gt.ID
                                                 WHERE ' || v_vcsqlwhere || ' ORDER BY sc.THOIDIEMBATDAU desc) dulieu ';
	v_vcsql := 'SELECT * FROM (' || v_vcsql || ') WHERE rn > ' || iDisplayStart || ' and rn <= ' || (iDisplayStart+iDisplayLength);
	--dbms_output.put_line(v_vcsql);
  --test(v_vcsql);
	OPEN l_cursor FOR v_vcsql;
	RETURN l_cursor;
END FN_FIND_SUCO;

/


