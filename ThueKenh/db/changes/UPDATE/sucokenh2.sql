ALTER TABLE SUCOKENH 
ADD (THOIGIANMLLCHUAGIAMTRU NUMBER );

--------------------------------------------------------
--  DDL for Function SAVE_SUCOKENH
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."SAVE_SUCOKENH" 
(
  id_ in varchar2,
  tuyenkenh_id_ in varchar2,
  loaisuco_ in varchar2,
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
  bienbanvanhanh_id_ in varchar2,
  cuocthang_ in varchar2,
  thoigianmllchuagiamtru_ in varchar2
)
RETURN NUMBER AS i INTEGER :=0; 
BEGIN
  IF(id_ IS NOT NULL AND id_ >0) THEN --update
    UPDATE SUCOKENH 
    SET TUYENKENH_ID= tuyenkenh_id_, 
        LOAISUCO=loaisuco_,
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
        BIENBANVANHANH_ID=bienbanvanhanh_id_,
        cuocthang=cuocthang_,
        thoigianmllchuagiamtru=thoigianmllchuagiamtru_
    WHERE ID= id_;
    i:= id_;
  ELSE -- insert
    i:=SEQ_SUCO.nextval;
    INSERT INTO SUCOKENH(ID,TUYENKENH_ID,LOAISUCO,PHULUC_ID,THANHTOAN_ID,THOIDIEMBATDAU,THOIDIEMKETTHUC,THOIGIANMLL,NGUYENNHAN,PHUONGANXULY,NGUOIXACNHAN,GIAMTRUMLL,TRANGTHAI,USERCREATE,TIMECREATE,DELETED,FILENAME,FILEPATH,FILESIZE,BIENBANVANHANH_ID,cuocthang,thoigianmllchuagiamtru) 
    VALUES (i, tuyenkenh_id_,loaisuco_, phuluc_id_, thanhtoan_id_, thoidiembatdau_, thoidiemketthuc_, thoigianmll_, nguyennhan_, phuonganxuly_, nguoixacnhan_, giamtrumll_, trangthai_, usercreate_, timecreate_, 0,filename_, filepath_, filesize_,bienbanvanhanh_id_,cuocthang_,thoigianmllchuagiamtru_);
  END IF;
  RETURN i;
END SAVE_SUCOKENH;

/

ALTER TABLE SUCO_IMPORT 
ADD (THOIGIANMLLCHUAGIAMTRU NUMBER DEFAULT 0 );

--------------------------------------------------------
--  DDL for Procedure PROC_IMPORT_SUCO
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "THUEKENH"."PROC_IMPORT_SUCO" (
pi_array in TABLE_NUMBER,
usercreate_ in varchar2,
timecreate_ in date
) AS 
i INTEGER := 1;
BEGIN
	for rec in (SELECT *  FROM SUCO_IMPORT  where ID in (select * from table(pi_array))) loop
      i := SEQ_SUCO.nextval;
			insert into SUCOKENH(ID,TUYENKENH_ID,PHULUC_ID,THANHTOAN_ID,THOIDIEMBATDAU,THOIDIEMKETTHUC,THOIGIANMLL,NGUYENNHAN,PHUONGANXULY,NGUOIXACNHAN,GIAMTRUMLL,TRANGTHAI,USERCREATE,TIMECREATE,DELETED,BIENBANVANHANH_ID,LOAISUCO,CUOCTHANG,THOIGIANMLLCHUAGIAMTRU) 
      values (i,rec.TUYENKENH_ID,rec.PHULUC_ID,null,rec.THOIDIEMBATDAU,rec.THOIDIEMKETTHUC,rec.THOIGIANMLL,rec.NGUYENNHAN,rec.PHUONGANXULY,rec.NGUOIXACNHAN,rec.GIAMTRUMLL,0,usercreate_,timecreate_,0,0,rec.LOAISUCO,rec.CUOCTHANG,rec.THOIGIANMLLCHUAGIAMTRU);
    delete from SUCO_IMPORT where ID = rec.ID;
	end loop;
END PROC_IMPORT_SUCO;

/

--------------------------------------------------------
--  DDL for Procedure SAVE_SUCO_IMPORT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "THUEKENH"."SAVE_SUCO_IMPORT" (
stt_ in NUMBER,
madiemdau_ in VARCHAR2,
madiemcuoi_ in VARCHAR2,
dungluong_ in VARCHAR2,
magiaotiep_ in VARCHAR2,
thoidiembatdau_ in NUMBER,
thoidiemketthuc_ in NUMBER,
nguyennhan_ in VARCHAR2,
phuonganxuly_ in VARCHAR2,
nguoixacnhan_ in VARCHAR2,
tuyenkenh_id_ in VARCHAR2,
phuluc_id_ in VARCHAR2,
thoigianmll_ in VARCHAR2,
giamtrumll_ in VARCHAR2,
loaisuco_ in NUMBER,
cuocthang_ in varchar2,
thoigianmllchuagiamtru_ in VARCHAR2
) AS
i INTEGER := 0;
BEGIN
    i:=SEQ_SUCOIMPORT.nextval;
    --test(to_char(thoidiembatdau_,'DD-MON-YYYY HH24:MI'));
    insert into SUCO_IMPORT(STT,MADIEMDAU,MADIEMCUOI,DUNGLUONG,MAGIAOTIEP,THOIDIEMBATDAU,THOIDIEMKETTHUC,NGUYENNHAN,PHUONGANXULY,NGUOIXACNHAN,ID,TUYENKENH_ID,PHULUC_ID,THOIGIANMLL,GIAMTRUMLL,LOAISUCO,CUOCTHANG,THOIGIANMLLCHUAGIAMTRU) 
    values (stt_,madiemdau_,madiemcuoi_,dungluong_,magiaotiep_,thoidiembatdau_,thoidiemketthuc_,nguyennhan_,phuonganxuly_,nguoixacnhan_,i,tuyenkenh_id_,phuluc_id_,thoigianmll_,giamtrumll_,loaisuco_,cuocthang_,thoigianmllchuagiamtru_);
END SAVE_SUCO_IMPORT;

/




