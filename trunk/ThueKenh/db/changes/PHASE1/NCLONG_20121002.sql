--------------------------------------------------------
--  DDL for Table TUYENKENH_IMPORT
--------------------------------------------------------

  CREATE TABLE "THUEKENH"."TUYENKENH_IMPORT" 
   (	"STT" NUMBER, 
	"MADIEMDAU" VARCHAR2(50 BYTE), 
	"MADIEMCUOI" VARCHAR2(50 BYTE), 
	"GIAOTIEP_MA" VARCHAR2(200 BYTE), 
	"DUAN_MA" VARCHAR2(200 BYTE), 
	"PHONGBAN_MA" VARCHAR2(200 BYTE), 
	"KHUVUC_MA" VARCHAR2(200 BYTE), 
	"DUNGLUONG" NUMBER, 
	"SOLUONG" NUMBER, 
	"DATEIMPORT" DATE, 
	"ID" NUMBER, 
	"DUPLICATE" NUMBER DEFAULT 0
   ) ;
--------------------------------------------------------
--  DDL for Index TUYENKENH_IMPORT_PK
--------------------------------------------------------

  CREATE UNIQUE INDEX "THUEKENH"."TUYENKENH_IMPORT_PK" ON "THUEKENH"."TUYENKENH_IMPORT" ("ID");
--------------------------------------------------------
--  Constraints for Table TUYENKENH_IMPORT
--------------------------------------------------------

  ALTER TABLE "THUEKENH"."TUYENKENH_IMPORT" MODIFY ("STT" NOT NULL ENABLE);
 
  ALTER TABLE "THUEKENH"."TUYENKENH_IMPORT" MODIFY ("ID" NOT NULL ENABLE);
 
  ALTER TABLE "THUEKENH"."TUYENKENH_IMPORT" ADD CONSTRAINT "TUYENKENH_IMPORT_PK" PRIMARY KEY ("ID");

  ALTER TABLE SUCOKENH  
MODIFY (FILESIZE VARCHAR(20) );

ALTER TABLE SUCO_IMPORT  
MODIFY (THOIDIEMBATDAU NUMBER );

ALTER TABLE SUCO_IMPORT  
MODIFY (THOIDIEMKETTHUC NUMBER );

--------------------------------------------------------
--  DDL for Procedure SAVE_SUCO_IMPORT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "THUEKENH"."SAVE_SUCO_IMPORT" (
stt_ in NUMBER,
madiemdau_ in VARCHAR2,
madiemcuoi_ in VARCHAR2,
magiaotiep_ in VARCHAR2,
thoidiembatdau_ in NUMBER,
thoidiemketthuc_ in NUMBER,
nguyennhan_ in VARCHAR2,
phuonganxuly_ in VARCHAR2,
nguoixacnhan_ in VARCHAR2,
tuyenkenh_id_ in VARCHAR2,
phuluc_id_ in VARCHAR2,
thoigianmll_ in VARCHAR2,
giamtrumll_ in VARCHAR2
) AS
i INTEGER := 0;
BEGIN
    i:=SEQ_SUCOIMPORT.nextval;
    --test(to_char(thoidiembatdau_,'DD-MON-YYYY HH24:MI'));
    insert into SUCO_IMPORT(STT,MADIEMDAU,MADIEMCUOI,MAGIAOTIEP,THOIDIEMBATDAU,THOIDIEMKETTHUC,NGUYENNHAN,PHUONGANXULY,NGUOIXACNHAN,ID,TUYENKENH_ID,PHULUC_ID,THOIGIANMLL,GIAMTRUMLL) 
    values (stt_,madiemdau_,madiemcuoi_,magiaotiep_,thoidiembatdau_,thoidiemketthuc_,nguyennhan_,phuonganxuly_,nguoixacnhan_,i,tuyenkenh_id_,phuluc_id_,thoigianmll_,giamtrumll_);
END SAVE_SUCO_IMPORT;

/


