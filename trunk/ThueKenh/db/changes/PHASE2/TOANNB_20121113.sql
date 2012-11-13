--------------------------------------------------------
--  DDL for Function FIND_DOISOATCUOC
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FIND_DOISOATCUOC" (
iDisplayStart IN NUMBER,   
iDisplayLength IN NUMBER, 
tenbangdoisoatcuoc_ in varchar2
) RETURN SYS_REFCURSOR AS
l_cursor SYS_REFCURSOR;
v_vcsql VARCHAR2(2000);
v_vcsqlwhere VARCHAR2(1000);
i NUMBER;
BEGIN
	v_vcsqlwhere := ' t.DELETED = 0 ';
	if(tenbangdoisoatcuoc_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t.TENDOISOATCUOC like ''%'||tenbangdoisoatcuoc_||'%'' ';
	end if;
	v_vcsql := 'select rownum as rn,dulieu.* from (SELECT t.* FROM DOISOATCUOC t WHERE ' || v_vcsqlwhere || ' order by t.ID desc) dulieu ';
	v_vcsql := 'SELECT * FROM (' || v_vcsql || ') WHERE rn > ' || iDisplayStart || ' and rn <= ' || (iDisplayStart+iDisplayLength);
	--dbms_output.put_line(v_vcsql);
 --test(v_vcsql);
	OPEN l_cursor FOR v_vcsql;
	RETURN l_cursor;
END FIND_DOISOATCUOC;

/

--------------------------------------------------------
--  DDL for Function FN_FIND_HOPDONGBY_DSCUOC
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FN_FIND_HOPDONGBY_DSCUOC" 
(
  doisoatcuoc_id_ in varchar2
) 
RETURN SYS_REFCURSOR AS l_cursor SYS_REFCURSOR;
v_vcsql VARCHAR2(2000);
i NUMBER;
BEGIN
	v_vcsql := 'select rownum as rn,dulieu.* from (SELECT DISTINCT hd.*,dt.TENDOITAC
                                                 FROM DOISOATCUOC_PHULUC dp INNER JOIN PHULUC p ON dp.PHULUC_ID=p.ID 
                                                 INNER JOIN HOPDONG hd ON hd.ID=p.HOPDONG_ID 
                                                 INNER JOIN DOITAC dt ON hd.DOITAC_ID=dt.ID
                                                 WHERE dp.DOISOATCUOC_ID=' || doisoatcuoc_id_ || ') dulieu ';
	OPEN l_cursor FOR v_vcsql;
	RETURN l_cursor;
END FN_FIND_HOPDONGBY_DSCUOC;

/

--------------------------------------------------------
--  DDL for Function FN_FIND_PHULUCBY_DSCUOC_HD
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FN_FIND_PHULUCBY_DSCUOC_HD" 
(
  doisoatcuoc_id_ in varchar2,
  hopdong_id_ in varchar2
) 
RETURN SYS_REFCURSOR AS l_cursor SYS_REFCURSOR;
v_vcsql VARCHAR2(2000);
i NUMBER;
BEGIN
	v_vcsql := 'select rownum as rn,dulieu.* from (SELECT tp.PHULUC_ID
                                                 FROM DOISOATCUOC_PHULUC tp INNER JOIN PHULUC p ON tp.PHULUC_ID=p.ID   
                                                 WHERE tp.DOISOATCUOC_ID=' || doisoatcuoc_id_ || ' AND p.HOPDONG_ID=' || hopdong_id_ || ') dulieu ';
	OPEN l_cursor FOR v_vcsql;
	RETURN l_cursor;
END FN_FIND_PHULUCBY_DSCUOC_HD;

/
--------------------------------------------------------
--  DDL for Function FN_FIND_SUCO
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FN_FIND_SUCO" 
(
  iDisplayStart IN NUMBER,   
  iDisplayLength IN NUMBER, 
  tuyenkenh_id_ in varchar2,
  loaisuco_ in varchar2,
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
  if(loaisuco_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' AND sc.LOAISUCO = '||loaisuco_||' ';
	end if;
	if(diemdau_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' AND t.MADIEMDAU like '''||replace(diemdau_, '*', '%')||''' ';
	end if;
	if(diemcuoi_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' AND t.MADIEMCUOI like '''||replace(diemcuoi_, '*', '%')||''' ';
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
		v_vcsqlwhere := v_vcsqlwhere ||' and sc.NGUOIXACNHAN like '''||replace(nguoixacnhan_, '*', '%')||''' ';
	end if;
  if(bienbanvanhanh_id_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and sc.BIENBANVANHANH_ID='||bienbanvanhanh_id_||' ';
	end if;
	v_vcsql := 'select rownum as rn,dulieu.* from (SELECT sc.id ,t.ID tuyenkenh_id,t.MADIEMDAU,t.MADIEMCUOI,sc.LOAISUCO,t.GIAOTIEP_ID,gt.LOAIGIAOTIEP,t.DUNGLUONG,t.SOLUONG,sc.THOIDIEMBATDAU,sc.THOIDIEMKETTHUC,
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

--------------------------------------------------------
--  DDL for Function FN_FIND_SUCO_BY_DSCUOC
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FN_FIND_SUCO_BY_DSCUOC" 
(
  iDisplayStart IN NUMBER,   
  iDisplayLength IN NUMBER, 
  doisoatcuoc_id_ in varchar2
) 
RETURN SYS_REFCURSOR AS l_cursor SYS_REFCURSOR;
v_vcsql VARCHAR2(2000);
v_vcsqlwhere VARCHAR2(1000);
i NUMBER;
BEGIN
	v_vcsqlwhere := ' sc.DELETED = 0 ';
  if(doisoatcuoc_id_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and ds.DOISOATCUOC_ID='||doisoatcuoc_id_||' ';
	end if;
	v_vcsql := 'select rownum as rn,dulieu.* from (SELECT sc.id ,t.ID tuyenkenh_id,t.MADIEMDAU,t.MADIEMCUOI,sc.LOAISUCO,t.GIAOTIEP_ID,gt.LOAIGIAOTIEP,t.DUNGLUONG,t.SOLUONG,sc.THOIDIEMBATDAU,sc.THOIDIEMKETTHUC,
                                                        sc.THOIGIANMLL,sc.NGUYENNHAN,sc.PHUONGANXULY,sc.NGUOIXACNHAN,sc.FILENAME,sc.FILEPATH,sc.FILESIZE,sc.USERCREATE,sc.TIMECREATE,sc.BIENBANVANHANH_ID
                                                 FROM SUCOKENH sc  
                                                      LEFT JOIN TUYENKENH t ON sc.TUYENKENH_ID = t.ID 
                                                      LEFT JOIN LOAIGIAOTIEP gt ON t.GIAOTIEP_ID=gt.ID
                                                      LEFT JOIN DOISOATCUOC_SUCO ds ON ds.SUCO_ID=sc.ID
                                                 WHERE ' || v_vcsqlwhere || ' ORDER BY sc.THOIDIEMBATDAU desc) dulieu ';
	v_vcsql := 'SELECT * FROM (' || v_vcsql || ') WHERE rn > ' || iDisplayStart || ' and rn <= ' || (iDisplayStart+iDisplayLength);
	--dbms_output.put_line(v_vcsql);
  --test(v_vcsql);
	OPEN l_cursor FOR v_vcsql;
	RETURN l_cursor;
END FN_FIND_SUCO_BY_DSCUOC;

/

--------------------------------------------------------
--  DDL for Function SAVE_HOSOTHANHTOAN
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."SAVE_HOSOTHANHTOAN" 
(
  id_ in varchar2,
  ngaychuyenketoan_ in varchar2,
  trangthai_ in varchar2,
  usercreate_ in varchar2,
  timecreate_ in varchar2,
  deleted_ in varchar2,
  filename_ in varchar2,
  filepath_ in varchar2,
  filesize_ in varchar2,
  sohoso_ in varchar2,
  doisoatcuoc_id_ in varchar2
)
RETURN NUMBER AS i INTEGER :=0; 
BEGIN
  IF(id_ IS NOT NULL AND id_ >0) THEN --update
    UPDATE THANHTOAN 
    SET NGAYCHUYENKT= ngaychuyenketoan_, 
        TRANGTHAI= trangthai_,
        DELETED= deleted_,
        FILENAME= filename_,
        FILEPATH= filepath_,
        FILESIZE= filesize_,
        SOHOSO= sohoso_,
        DOISOATCUOC_ID=doisoatcuoc_id
    WHERE ID= id_;
    i:= id_;
  ELSE -- insert
    i:=SEQ_THANHTOAN.nextval;
    INSERT INTO THANHTOAN(ID,NGAYCHUYENKT,TRANGTHAI,USERCREATE,TIMECREATE,DELETED,FILENAME,FILEPATH,FILESIZE,SOHOSO,DOISOATCUOC_ID) 
    VALUES (i, ngaychuyenketoan_, trangthai_, usercreate_, timecreate_, 0,filename_, filepath_, filesize_,sohoso_,doisoatcuoc_id_);
  END IF;
  RETURN i;
END SAVE_HOSOTHANHTOAN;

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
	v_vcsqlwhere := ' tt.DELETED =0 ';
	if(sohoso_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and tt.SOHOSO = '''||sohoso_||''' ';
	end if;
	if(ngaychuyenhosotu_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and tt.NGAYCHUYENKT >= TO_DATE('''||ngaychuyenhosotu_||''',''DD-MM-RRRR'') ';
	end if;
  if(ngaychuyenhosoden_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and tt.NGAYCHUYENKT <= TO_DATE('''||ngaychuyenhosoden_||''',''DD-MM-RRRR'') ';
	end if;
  if(trangthai_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and tt.TRANGTHAI = '||trangthai_||' ';
	end if;
	v_vcsql := 'select rownum as rn,dulieu.* from (SELECT tt.*,dsc.thanhtien giatritt,dsc.giamtrumll 
                                                 FROM THANHTOAN tt INNER JOIN DOISOATCUOC dsc ON tt.DOISOATCUOC_ID=dsc.ID 
                                                 WHERE ' || v_vcsqlwhere || ' order by tt.TIMECREATE desc) dulieu ';
	v_vcsql := 'SELECT * FROM (' || v_vcsql || ') WHERE rn > ' || iDisplayStart || ' and rn <= ' || (iDisplayStart+iDisplayLength);
	--dbms_output.put_line(v_vcsql);
 --test(v_vcsql);
	OPEN l_cursor FOR v_vcsql;
	RETURN l_cursor;
END FIND_HOSOTHANHTOAN;

/

--------------------------------------------------------
--  DDL for Function FIND_DOISOATCUOC
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FIND_DOISOATCUOC" (
iDisplayStart IN NUMBER,   
iDisplayLength IN NUMBER, 
id_ in varchar2,
tenbangdoisoatcuoc_ in varchar2
) RETURN SYS_REFCURSOR AS
l_cursor SYS_REFCURSOR;
v_vcsql VARCHAR2(2000);
v_vcsqlwhere VARCHAR2(1000);
i NUMBER;
BEGIN
	v_vcsqlwhere := ' t.DELETED = 0 ';
  if(id_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t.ID = '||id_||' ';
  end if;
	if(tenbangdoisoatcuoc_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t.TENDOISOATCUOC like ''%'||tenbangdoisoatcuoc_||'%'' ';
	end if;
	v_vcsql := 'select rownum as rn,dulieu.* from (SELECT t.* FROM DOISOATCUOC t WHERE ' || v_vcsqlwhere || ' order by t.ID desc) dulieu ';
	v_vcsql := 'SELECT * FROM (' || v_vcsql || ') WHERE rn > ' || iDisplayStart || ' and rn <= ' || (iDisplayStart+iDisplayLength);
	--dbms_output.put_line(v_vcsql);
 --test(v_vcsql);
	OPEN l_cursor FOR v_vcsql;
	RETURN l_cursor;
END FIND_DOISOATCUOC;

/

--------------------------------------------------------
--  DDL for Function FIND_PHULUC_BY_HD_DSC
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FIND_PHULUC_BY_HD_DSC" (
iDisplayStart IN NUMBER,   
iDisplayLength IN NUMBER, 
doisoatcuoc_id_ in varchar2,
hopdong_id_ in varchar2
) RETURN SYS_REFCURSOR AS
l_cursor SYS_REFCURSOR;
v_vcsql VARCHAR2(2000);
v_vcsqlwhere VARCHAR2(1000);
i NUMBER;
BEGIN
	v_vcsqlwhere := ' t.DELETED = 0 ';
	if(doisoatcuoc_id_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and dp.DOISOATCUOC_ID = '||doisoatcuoc_id_||' ';
	end if;
	if(hopdong_id_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t.HOPDONG_ID = '||hopdong_id_||' ';
	end if;
	v_vcsql := 'select rownum as rn,dulieu.* from (SELECT t.*,t0.SOHOPDONG,t0.LOAIHOPDONG,t0.DOITAC_ID,t2.TENDOITAC,FIND_PHULUC_BITHAYTHE(t.ID) as PHULUCBITHAYTHE FROM PHULUC t 
		left join HOPDONG t0 on t.HOPDONG_ID = t0.ID 
    left join DOISOATCUOC_PHULUC dp on dp.PHULUC_ID=t.ID
		left join DOITAC t2 on t0.DOITAC_ID = t2.ID  WHERE ' || v_vcsqlwhere || ' order by t.ID desc) dulieu ';
	v_vcsql := 'SELECT * FROM (' || v_vcsql || ') WHERE rn > ' || iDisplayStart || ' and rn <= ' || (iDisplayStart+iDisplayLength);
	--dbms_output.put_line(v_vcsql);
--test(v_vcsql);
	OPEN l_cursor FOR v_vcsql;
	RETURN l_cursor;
END FIND_PHULUC_BY_HD_DSC;

/



--------------------------------------------------------
--  DDL for Function SAVE_HOSOTHANHTOAN
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."SAVE_HOSOTHANHTOAN" 
(
  id_ in varchar2,
  ngaychuyenketoan_ in varchar2,
  trangthai_ in varchar2,
  usercreate_ in varchar2,
  timecreate_ in varchar2,
  deleted_ in varchar2,
  filename_ in varchar2,
  filepath_ in varchar2,
  filesize_ in varchar2,
  sohoso_ in varchar2,
  doisoatcuoc_id_ in varchar2
)
RETURN NUMBER AS i INTEGER :=0; 
BEGIN
  IF(id_ IS NOT NULL AND id_ >0) THEN --update
    UPDATE THANHTOAN 
    SET NGAYCHUYENKT= ngaychuyenketoan_, 
        TRANGTHAI= trangthai_,
        DELETED= deleted_,
        FILENAME= filename_,
        FILEPATH= filepath_,
        FILESIZE= filesize_,
        SOHOSO= sohoso_,
        DOISOATCUOC_ID=doisoatcuoc_id_
    WHERE ID= id_;
    i:= id_;
  ELSE -- insert
    i:=SEQ_THANHTOAN.nextval;
    INSERT INTO THANHTOAN(ID,NGAYCHUYENKT,TRANGTHAI,USERCREATE,TIMECREATE,DELETED,FILENAME,FILEPATH,FILESIZE,SOHOSO,DOISOATCUOC_ID) 
    VALUES (i, ngaychuyenketoan_, trangthai_, usercreate_, timecreate_, 0,filename_, filepath_, filesize_,sohoso_,doisoatcuoc_id_);
  END IF;
  RETURN i;
END SAVE_HOSOTHANHTOAN;

/


ALTER TABLE THANHTOAN  
MODIFY (DELETED NUMBER );




