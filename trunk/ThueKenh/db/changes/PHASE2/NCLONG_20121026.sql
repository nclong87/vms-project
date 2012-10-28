ALTER TABLE CHITIETPHULUC_TUYENKENH RENAME COLUMN PHUCLUCCHITIET_ID TO CHITIETPHULUC_ID;

ALTER TABLE CONGTHUC 
ADD (ISDEFAULT NUMBER DEFAULT 0 );

create table "THUEKENH".CHITIETPHULUC_TUYENKENH_TMP as select * from "THUEKENH"."CHITIETPHULUC_TUYENKENH" where '1' = '';

ALTER TABLE CHITIETPHULUC_TUYENKENH_TMP 
DROP COLUMN CHITIETPHULUC_ID;
ALTER TABLE CHITIETPHULUC_TUYENKENH_TMP  
MODIFY (TUYENKENH_ID NULL);

--------------------------------------------------------
--  DDL for Procedure PROC_SAVE_CTPL_TUYENKENH_TMP
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "THUEKENH"."PROC_SAVE_CTPL_TUYENKENH_TMP" (
tuyenkenh_id_ in VARCHAR2,
congthuc_id_ in VARCHAR2,
soluong_ in NUMBER,
cuoccong_ in NUMBER,
cuocdaunoi_ in NUMBER,
dongia_ in NUMBER,
giamgia_ in NUMBER,
thanhtien_ in NUMBER
) AS 
BEGIN
	insert into CHITIETPHULUC_TUYENKENH_TMP(TUYENKENH_ID,CONGTHUC_ID,SOLUONG,CUOCCONG,CUOCDAUNOI,DONGIA,GIAMGIA,THANHTIEN) VALUES(tuyenkenh_id_,congthuc_id_,soluong_,cuoccong_,cuocdaunoi_,dongia_,giamgia_,thanhtien_);
END PROC_SAVE_CTPL_TUYENKENH_TMP;

/


