--------------------------------------------------------
--  DDL for Function FN_FIND_SUCO_FOR_TT
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FN_FIND_SUCO_FOR_TT" 
(
  iDisplayStart IN NUMBER,
  iDisplayLength IN NUMBER,
  tungay_ in varchar2,
  denngay_ in varchar2,
  phulucids_ in varchar2
)
RETURN SYS_REFCURSOR AS l_cursor SYS_REFCURSOR;
v_vcsql VARCHAR2(2000);
v_vcsqlwhere VARCHAR2(1000);
i NUMBER;
BEGIN
  v_vcsqlwhere := ' sc.DELETED = 0 ';
  if(tungay_ is not null) then
    v_vcsqlwhere := v_vcsqlwhere ||' and sc.THOIDIEMBATDAU >= '||tungay_||' ';
  end if;
  if(denngay_ is not null) then
    v_vcsqlwhere := v_vcsqlwhere ||' and sc.THOIDIEMBATDAU <= '||denngay_||' ';
  end if;
  if(phulucids_ is not null) then
    v_vcsqlwhere := v_vcsqlwhere ||' and (sc.PHULUC_ID in ('||phulucids_||') or sc.PHULUC_ID in (SELECT ID FROM PHULUC WHERE DELETED = 0 and PHULUCTHAYTHE_ID in ('||phulucids_||') and PARSE_UNIXTIME(NGAYHETHIEULUC)*1000 >= '||tungay_||' and PARSE_UNIXTIME(NGAYHETHIEULUC)*1000<='||denngay_||')) ';
  end if;
  
  v_vcsql := 'select rownum as rn,dulieu.* from (SELECT sc.id ,sc.phuluc_id,t.ID tuyenkenh_id,t.MADIEMDAU,t.MADIEMCUOI,sc.LOAISUCO,t.GIAOTIEP_ID,gt.LOAIGIAOTIEP,t.DUNGLUONG,t.SOLUONG,sc.THOIDIEMBATDAU,sc.THOIDIEMKETTHUC,
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
END FN_FIND_SUCO_FOR_TT;

/

