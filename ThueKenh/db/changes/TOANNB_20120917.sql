ALTER TABLE SUCOKENH 
DROP COLUMN FILESCAN_ID;

ALTER TABLE SUCOKENH 
ADD (FILENAME VARCHAR2(200) );

ALTER TABLE SUCOKENH 
ADD (FILEPATH VARCHAR2(200) );

ALTER TABLE SUCOKENH 
ADD (FILESIZE NUMBER );

create or replace
FUNCTION "FN_FIND_SUCO" (
iDisplayStart IN NUMBER,   
iDisplayLength IN NUMBER, 
tuyenkenh_id_ in varchar2,
diemdau_ in varchar2,
diemcuoi_ in varchar2,
dungluong_ in varchar2,
thoidiembatdau_ in varchar2,
thoidiemketthuc_ in varchar2,
nguoixacnhan_ in varchar2,
loaisuco_ in varchar2
) RETURN SYS_REFCURSOR AS
l_cursor SYS_REFCURSOR;
v_vcsql VARCHAR2(2000);
v_vcsqlwhere VARCHAR2(1000);
i NUMBER;
BEGIN
	v_vcsqlwhere := ' sc.DELETED = 0 ';
	if(tuyenkenh_id_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' AND sc.TUYENKENH_ID = '||tuyenkenh_id_||' ';
	end if;
	if(diemdau_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' AND t.MADIEMDAU = '||diemdau_||' ';
	end if;
	if(diemcuoi_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' AND t.MADIEMCUOI = '||diemcuoi_||' ';
	end if;
	if(dungluong_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t.DUNGLUONG = '||dungluong_ ||' ';
	end if;
	if(thoidiembatdau_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and sc.THOIDIEMBATDAU = TO_DATE('''||thoidiembatdau_||''',''DD-MM-RRRR'') ';
	end if;
	if(thoidiemketthuc_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and sc.THOIDIEMKETTHUC = TO_DATE('''||thoidiemketthuc_||''',''DD-MM-RRRR'') ';
	end if;
	if(nguoixacnhan_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and sc.NGUOIXACNHAN like '''||replace(nguoixacnhan_, '*', '%')||''' ';
	end if;
	if(loaisuco_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and sc.LOAISUCO like '''||replace(loaisuco_, '*', '%')||''' ';
	end if;
	v_vcsql := 'select rownum as rn,dulieu.* from (SELECT sc.id suco_id,t.ID tuyekenh_id,t.MADIEMDAU,t.MADIEMCUOI,gt.LOAIGIAOTIEP,t.DUNGLUONG,t.SOLUONG,sc.THOIDIEMBATDAU,sc.THOIDIEMKETTHUC,
                                                        sc.THOIGIANMLL,sc.NGUYENNHAN,sc.PHUONGANXULY,sc.NGUOIXACNHAN,sc.USERCREATE,sc.TIMECREATE
                                                 FROM SUCOKENH sc 
                                                      LEFT JOIN TUYENKENH t ON sc.TUYENKENH_ID = t.ID 
                                                      LEFT JOIN LOAIGIAOTIEP gt ON t.GIAOTIEP_ID=gt.ID
                                                 WHERE ' || v_vcsqlwhere || ' ORDER BY sc.THOIDIEMBATDAU desc) dulieu ';
	v_vcsql := 'SELECT * FROM (' || v_vcsql || ') WHERE rn >= ' || iDisplayStart || ' and rn <= ' || (iDisplayStart+iDisplayLength);
	dbms_output.put_line(v_vcsql);
 --test(v_vcsql);
	OPEN l_cursor FOR v_vcsql;
	RETURN l_cursor;
END FN_FIND_SUCO;
