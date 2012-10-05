ALTER TABLE SUCOKENH  
MODIFY (THOIDIEMBATDAU NUMBER );

ALTER TABLE SUCOKENH  
MODIFY (THOIDIEMKETTHUC NUMBER );

ALTER TABLE SUCOKENH 
ADD (BIENBANVANHANH_ID NUMBER);

ALTER TABLE BIENBANVANHANH  
MODIFY (FILESIZE VARCHAR2(200) );

--------------------------------------------------------
--  DDL for Function SAVE_SUCOKENH
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."SAVE_SUCOKENH" 
(
  id_ in varchar2,
  tuyenkenh_id_ in varchar2,
  phuluc_id_ in varchar2,
  thanhtoan_id_ in varchar2,
  thoidiembatdau_ in varchar2,
  thoidiemketthuc_ in varchar2,
  thoigianmll_ in varchar2,
  nguyennhan_ in varchar2,
  phuonganxuly_ in varchar2,
  nguoixacnhan_ in varchar2,
  giamtrumll_ in varchar2,
  trangthai_ in varchar2,
  usercreate_ in varchar2,
  timecreate_ in varchar2,
  deleted_ in varchar2,
  filename_ in varchar2,
  filepath_ in varchar2,
  filesize_ in varchar2,
  bienbanvanhanh_id_ in varchar2
)
RETURN NUMBER AS i INTEGER :=0; 
BEGIN
  IF(id_ IS NOT NULL AND id_ >0) THEN --update
    UPDATE SUCOKENH 
    SET TUYENKENH_ID= tuyenkenh_id_, 
        PHULUC_ID= phuluc_id_, 
        THANHTOAN_ID= thanhtoan_id_, 
        THOIDIEMBATDAU= thoidiembatdau_, 
        THOIDIEMKETTHUC= thoidiemketthuc_,
        THOIGIANMLL= thoigianmll_,
        NGUYENNHAN= nguyennhan_,
        PHUONGANXULY= phuonganxuly_,
        NGUOIXACNHAN= nguoixacnhan_,
        GIAMTRUMLL= giamtrumll_,
        TRANGTHAI= trangthai_,
        USERCREATE= usercreate_,
        TIMECREATE= timecreate_,
        DELETED= deleted_,
        FILENAME= filename_,
        FILEPATH= filepath_,
        FILESIZE= filesize_,
        BIENBANVANHANH_ID=bienbanvanhanh_id_
    WHERE ID= id_;
    i:= id_;
  ELSE -- insert
    i:=SEQ_SUCO.nextval;
    INSERT INTO SUCOKENH(ID,TUYENKENH_ID,PHULUC_ID,THANHTOAN_ID,THOIDIEMBATDAU,THOIDIEMKETTHUC,THOIGIANMLL,NGUYENNHAN,PHUONGANXULY,NGUOIXACNHAN,GIAMTRUMLL,TRANGTHAI,USERCREATE,TIMECREATE,DELETED,FILENAME,FILEPATH,FILESIZE,BIENBANVANHANH_ID) 
    VALUES (i, tuyenkenh_id_, phuluc_id_, thanhtoan_id_, thoidiembatdau_, thoidiemketthuc_, thoigianmll_, nguyennhan_, phuonganxuly_, nguoixacnhan_, giamtrumll_, trangthai_, usercreate_, timecreate_, 0,filename_, filepath_, filesize_,bienbanvanhanh_id_);
  END IF;
  RETURN i;
END SAVE_SUCOKENH;

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
        DELETED= deleted_,
        FILENAME= filename_,
        FILEPATH= filepath_,
        FILESIZE= filesize_
    WHERE ID= id_;
    i:= id_;
  ELSE -- insert
    i:=SEQ_BIENBANVANHANH.nextval;
    INSERT INTO BIENBANVANHANH(ID,SOBIENBAN,USERCREATE,TIMECREATE,DELETED,FILENAME,FILEPATH,FILESIZE) VALUES (i,sobienban_, usercreate_, timecreate_, 0,filename_, filepath_, filesize_);
  END IF;
  RETURN i;
END SAVE_BIENBANVANHANH;

/

--------------------------------------------------------
--  DDL for Function SAVE_SUCOKENH
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."SAVE_SUCOKENH" 
(
  id_ in varchar2,
  tuyenkenh_id_ in varchar2,
  phuluc_id_ in varchar2,
  thanhtoan_id_ in varchar2,
  thoidiembatdau_ in varchar2,
  thoidiemketthuc_ in varchar2,
  thoigianmll_ in varchar2,
  nguyennhan_ in varchar2,
  phuonganxuly_ in varchar2,
  nguoixacnhan_ in varchar2,
  giamtrumll_ in varchar2,
  trangthai_ in varchar2,
  usercreate_ in varchar2,
  timecreate_ in varchar2,
  deleted_ in varchar2,
  filename_ in varchar2,
  filepath_ in varchar2,
  filesize_ in varchar2,
  bienbanvanhanh_id_ in varchar2
)
RETURN NUMBER AS i INTEGER :=0; 
BEGIN
  IF(id_ IS NOT NULL AND id_ >0) THEN --update
    UPDATE SUCOKENH 
    SET TUYENKENH_ID= tuyenkenh_id_, 
        PHULUC_ID= phuluc_id_, 
        THANHTOAN_ID= thanhtoan_id_, 
        THOIDIEMBATDAU= thoidiembatdau_, 
        THOIDIEMKETTHUC= thoidiemketthuc_,
        THOIGIANMLL= thoigianmll_,
        NGUYENNHAN= nguyennhan_,
        PHUONGANXULY= phuonganxuly_,
        NGUOIXACNHAN= nguoixacnhan_,
        GIAMTRUMLL= giamtrumll_,
        TRANGTHAI= trangthai_,
        DELETED= deleted_,
        FILENAME= filename_,
        FILEPATH= filepath_,
        FILESIZE= filesize_,
        BIENBANVANHANH_ID=bienbanvanhanh_id_
    WHERE ID= id_;
    i:= id_;
  ELSE -- insert
    i:=SEQ_SUCO.nextval;
    INSERT INTO SUCOKENH(ID,TUYENKENH_ID,PHULUC_ID,THANHTOAN_ID,THOIDIEMBATDAU,THOIDIEMKETTHUC,THOIGIANMLL,NGUYENNHAN,PHUONGANXULY,NGUOIXACNHAN,GIAMTRUMLL,TRANGTHAI,USERCREATE,TIMECREATE,DELETED,FILENAME,FILEPATH,FILESIZE,BIENBANVANHANH_ID) 
    VALUES (i, tuyenkenh_id_, phuluc_id_, thanhtoan_id_, thoidiembatdau_, thoidiemketthuc_, thoigianmll_, nguyennhan_, phuonganxuly_, nguoixacnhan_, giamtrumll_, trangthai_, usercreate_, timecreate_, 0,filename_, filepath_, filesize_,bienbanvanhanh_id_);
  END IF;
  RETURN i;
END SAVE_SUCOKENH;

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
  thoidiembatdautu_ in varchar2,
  thoidiembatdauden_ in varchar2,
  thoidiemketthuctu_ in varchar2,
  thoidiemketthucden_ in varchar2,
  nguoixacnhan_ in varchar2,
  bienbanvanhanh_id_ in varchar2
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
	if(thoidiembatdautu_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and sc.THOIDIEMBATDAU >= '||thoidiembatdautu_||' ';
	end if;
	if(thoidiembatdauden_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and sc.THOIDIEMBATDAU <= '||thoidiembatdauden_||' ';
	end if;
  if(thoidiemketthuctu_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and sc.THOIDIEMKETTHUC >= '||thoidiemketthuctu_||' ';
	end if;
	if(thoidiemketthucden_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and sc.THOIDIEMKETTHUC <= '||thoidiemketthucden_||' ';
	end if;
	if(nguoixacnhan_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and sc.NGUOIXACNHAN like ''%'||replace(nguoixacnhan_, '*', '%')||'%'' ';
	end if;
  if(bienbanvanhanh_id_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and sc.BIENBANVANHANH_ID='||bienbanvanhanh_id_||' ';
	end if;
	v_vcsql := 'select rownum as rn,dulieu.* from (SELECT sc.id suco_id,t.ID tuyenkenh_id,t.MADIEMDAU,t.MADIEMCUOI,gt.LOAIGIAOTIEP,t.DUNGLUONG,t.SOLUONG,sc.THOIDIEMBATDAU,sc.THOIDIEMKETTHUC,
                                                        sc.THOIGIANMLL,sc.NGUYENNHAN,sc.PHUONGANXULY,sc.NGUOIXACNHAN,sc.FILENAME,sc.FILEPATH,sc.FILESIZE,sc.USERCREATE,sc.TIMECREATE,sc.BIENBANVANHANH_ID
                                                 FROM SUCOKENH sc  
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



