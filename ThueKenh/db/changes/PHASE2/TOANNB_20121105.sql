ALTER TABLE THANHTOAN 
ADD (SOHOSO VARCHAR2(20) );

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
  bienbanvanhanh_id_ in varchar2,
  thanhtoan_id_ in varchar2
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
  if(thanhtoan_id_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and sc.THANHTOAN_ID='||thanhtoan_id_||' ';
	end if;
	v_vcsql := 'select rownum as rn,dulieu.* from (SELECT sc.id suco_id,t.ID tuyenkenh_id,t.MADIEMDAU,t.MADIEMCUOI,sc.LOAISUCO,t.GIAOTIEP_ID,gt.LOAIGIAOTIEP,t.DUNGLUONG,t.SOLUONG,sc.THOIDIEMBATDAU,sc.THOIDIEMKETTHUC,
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

