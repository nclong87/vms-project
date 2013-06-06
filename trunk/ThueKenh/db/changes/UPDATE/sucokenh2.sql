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

