--------------------------------------------------------
--  DDL for Function SAVE_HOSOTHANHTOAN
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."SAVE_HOSOTHANHTOAN" 
(
  id_ in varchar2,
  ngaychuyenketoan_ in varchar2,
  trangthai_ in varchar2,
  usercreate_ in varchar2,
  timecreate_ in varchar2,
  deleted_ in varchar2,
  filename_ in varchar2,
  filepath_ in varchar2,
  filesize_ in varchar2,
  sohoso_ in varchar2,
  doisoatcuoc_id_ in varchar2
)
RETURN NUMBER AS i INTEGER :=0; 
str varchar2(500) := '';
BEGIN
  IF(id_ IS NOT NULL AND id_ >0) THEN --update
    UPDATE THANHTOAN 
    SET NGAYCHUYENKT= ngaychuyenketoan_, 
        --TRANGTHAI= trangthai_,
        DELETED= deleted_,
        FILENAME= filename_,
        FILEPATH= filepath_,
        FILESIZE= filesize_,
        SOHOSO= sohoso_,
        DOISOATCUOC_ID=doisoatcuoc_id_
    WHERE ID= id_;
    i:= id_;
  ELSE -- insert
    i:=SEQ_THANHTOAN.nextval;
    INSERT INTO THANHTOAN(ID,NGAYCHUYENKT,TRANGTHAI,USERCREATE,TIMECREATE,DELETED,FILENAME,FILEPATH,FILESIZE,SOHOSO,DOISOATCUOC_ID) 
    VALUES (i, ngaychuyenketoan_, trangthai_, usercreate_, timecreate_, 0,filename_, filepath_, filesize_,sohoso_,doisoatcuoc_id_);
  END IF;
  str := '<root><element><id>'||i||'</id><sohoso>'||sohoso_||'</sohoso></element></root>';
  for rec in (select PHULUC_ID from DOISOATCUOC t left join DOISOATCUOC_PHULUC t1 on t.id = t1.doisoatcuoc_id
where t.id = doisoatcuoc_id_) loop
    PROC_INSERT_LICHSU_PHULUC(usercreate_,rec.PHULUC_ID,5,str);
  end loop;
  RETURN i;
END SAVE_HOSOTHANHTOAN;

/

