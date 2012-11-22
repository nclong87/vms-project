--------------------------------------------------------
--  DDL for Function FIND_SUCOIMPORT
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FIND_SUCOIMPORT" (
iDisplayStart IN NUMBER,   
iDisplayLength IN NUMBER
) RETURN SYS_REFCURSOR AS
l_cursor SYS_REFCURSOR;
v_vcsql VARCHAR2(2000);
i NUMBER;
BEGIN
	v_vcsql := 'select rownum as rn,dulieu.* from (SELECT t.ID,t.STT, t.MADIEMDAU, t.MADIEMCUOI,t.DUNGLUONG, t.MAGIAOTIEP, t.THOIDIEMBATDAU, t.THOIDIEMKETTHUC, t.NGUYENNHAN, t.PHUONGANXULY, t.TUYENKENH_ID,t.NGUOIXACNHAN,t.LOAISUCO,t0.LOAIGIAOTIEP,t.PHULUC_ID,pl.TENPHULUC 
                                                 FROM SUCO_IMPORT t left join LOAIGIAOTIEP t0 on t.MAGIAOTIEP = t0.MA
                                                 left join PHULUC pl on pl.id=t.PHULUC_ID
                                                 order by t.STT) dulieu ';
	v_vcsql := 'SELECT * FROM (' || v_vcsql || ') WHERE rn > ' || iDisplayStart || ' and rn <= ' || (iDisplayStart+iDisplayLength);
	--dbms_output.put_line(v_vcsql);
 --test(v_vcsql);
	OPEN l_cursor FOR v_vcsql;
	RETURN l_cursor;
END FIND_SUCOIMPORT;

/

