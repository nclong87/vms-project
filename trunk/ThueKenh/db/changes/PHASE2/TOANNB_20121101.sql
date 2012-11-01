--------------------------------------------------------
--  DDL for Sequence SEQ_THANHTOAN
--------------------------------------------------------

   CREATE SEQUENCE  "THUEKENH"."SEQ_THANHTOAN"  MINVALUE 1 MAXVALUE 9999 INCREMENT BY 1 START WITH 1 CACHE 20 NOORDER  NOCYCLE ;

--------------------------------------------------------
--  DDL for Function SAVE_HOSOTHANHTOAN
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."SAVE_HOSOTHANHTOAN" 
(
  id_ in varchar2,
  ngaychuyenketoan_ in varchar2,
  thang_ in varchar2,
  nam_ in varchar2,
  giatrithanhtoan_ in varchar2,
  trangthai_ in varchar2,
  usercreate_ in varchar2,
  timecreate_ in varchar2,
  deleted_ in varchar2,
  filename_ in varchar2,
  filepath_ in varchar2,
  filesize_ in varchar2
)
RETURN NUMBER AS i INTEGER :=0; 
BEGIN
  IF(id_ IS NOT NULL AND id_ >0) THEN --update
    UPDATE THANHTOAN 
    SET NGAYCHUYENKT= ngaychuyenketoan_, 
        THANG=thang_,
        NAM= nam_, 
        GIATRITT= giatrithanhtoan_, 
        TRANGTHAI= trangthai_,
        DELETED= deleted_,
        FILENAME= filename_,
        FILEPATH= filepath_,
        FILESIZE= filesize_
    WHERE ID= id_;
    i:= id_;
  ELSE -- insert
    i:=SEQ_THANHTOAN.nextval;
    INSERT INTO THANHTOAN(ID,NGAYCHUYENKT,THANG,NAM,GIATRITT,TRANGTHAI,USERCREATE,TIMECREATE,DELETED,FILENAME,FILEPATH,FILESIZE) 
    VALUES (i, ngaychuyenketoan_,thang_, nam_, giatrithanhtoan_, trangthai_, usercreate_, timecreate_, 0,filename_, filepath_, filesize_);
  END IF;
  RETURN i;
END SAVE_HOSOTHANHTOAN;

/

