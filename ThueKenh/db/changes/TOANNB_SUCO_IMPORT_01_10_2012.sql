ALTER TABLE PHULUC 
ADD (NGAYHETHIEULUC DATE );

CREATE TABLE SUCO_IMPORT 
(
  STT NUMBER 
, MADIEMDAU VARCHAR2(20) 
, MADIEMCUOI VARCHAR2(20) 
, GIAOTIEP_MA VARCHAR2(20) 
, THOIDIEMBATDAU DATE 
, THOIDIEMKETTHUC DATE 
, NGUYENNHAN VARCHAR2(2000) 
, PHUONGANXULY VARCHAR2(2000) 
, NGUOIXACNHAN VARCHAR2(100) 
, ID NUMBER NOT NULL 
, CONSTRAINT SUCO_IMPORT_PK PRIMARY KEY 
  (
    ID 
  )
  ENABLE 
);

ALTER TABLE SUCO_IMPORT 
ADD (TUYENKENH_ID NUMBER );

ALTER TABLE SUCO_IMPORT RENAME COLUMN GIAOTIEP_MA TO MAGIAOTIEP;

CREATE SEQUENCE SEQ_SUCOIMPORT INCREMENT BY 1 START WITH 1 MAXVALUE 9999 MINVALUE 1;

ALTER TABLE SUCO_IMPORT 
ADD (PHULUC_ID NUMBER );

ALTER TABLE SUCO_IMPORT 
ADD (THOIGIANMLL NUMBER );

ALTER TABLE SUCO_IMPORT 
ADD (GIAMTRUMLL NUMBER );

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
	v_vcsql := 'select rownum as rn,dulieu.* from (SELECT t.ID,t.STT, t.MADIEMDAU, t.MADIEMCUOI, t.MAGIAOTIEP, t.THOIDIEMBATDAU, t.THOIDIEMKETTHUC, t.NGUYENNHAN, t.PHUONGANXULY, t.TUYENKENH_ID,t.NGUOIXACNHAN,t0.LOAIGIAOTIEP FROM SUCO_IMPORT t left join LOAIGIAOTIEP t0 on t.MAGIAOTIEP = t0.MA  order by t.STT) dulieu ';
	v_vcsql := 'SELECT * FROM (' || v_vcsql || ') WHERE rn > ' || iDisplayStart || ' and rn <= ' || (iDisplayStart+iDisplayLength);
	--dbms_output.put_line(v_vcsql);
 --test(v_vcsql);
	OPEN l_cursor FOR v_vcsql;
	RETURN l_cursor;
END FIND_SUCOIMPORT;

/

--------------------------------------------------------
--  DDL for Procedure SAVE_SUCO_IMPORT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "THUEKENH"."SAVE_SUCO_IMPORT" (
stt_ in NUMBER,
madiemdau_ in VARCHAR2,
madiemcuoi_ in VARCHAR2,
magiaotiep_ in VARCHAR2,
thoidiembatdau_ in DATE,
thoidiemketthuc_ in DATE,
nguyennhan_ in VARCHAR2,
phuonganxuly_ in VARCHAR2,
tuyenkenh_id_ in VARCHAR2
) AS
i INTEGER := 0;
type r_cursor is REF CURSOR;
cursor_ r_cursor;
BEGIN
    i:=SEQ_SUCOIMPORT.nextval;
		insert into SUCO_IMPORT(STT,MADIEMDAU,MADIEMCUOI,MAGIAOTIEP,THOIDIEMBATDAU,THOIDIEMKETTHUC,NGUYENNHAN,PHUONGANXULY,ID,TUYENKENH_ID) 
    values (stt_,madiemdau_,madiemcuoi_,magiaotiep_,thoidiembatdau_,thoidiemketthuc_,nguyennhan_,phuonganxuly_,i,tuyenkenh_id_);
END SAVE_SUCO_IMPORT;

/



