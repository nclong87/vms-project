ALTER TABLE TUYENKENH
ADD CONSTRAINT TUYENKENH_UK1 UNIQUE 
(
  MADIEMDAU 
, MADIEMCUOI 
, GIAOTIEP_ID 
, DUNGLUONG 
, DELETED 
)
ENABLE;

--------------------------------------------------------
--  DDL for Procedure SAVE_TUYENKENH_IMPORT
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "THUEKENH"."SAVE_TUYENKENH_IMPORT" (
stt_ in NUMBER,
madiemdau_ in VARCHAR2,
madiemcuoi_ in VARCHAR2,
giaotiep_ma_ in VARCHAR2,
duan_ma_ in VARCHAR2,
phongban_ma_ in VARCHAR2,
doitac_ma_ in VARCHAR2,
dungluong_ in VARCHAR2,
soluong_ in VARCHAR2,
trangthai_ in VARCHAR2,
dateimport_ in DATE
) AS
i INTEGER := 0;
type r_cursor is REF CURSOR;
cursor_ r_cursor;
tuyenkenh_ TUYENKENH%rowtype;
BEGIN
  /*open cursor_ for select * from TUYENKENH_IMPORT where MADIEMDAU=madiemdau_ and MADIEMCUOI = madiemcuoi_ and GIAOTIEP_MA = giaotiep_ma_;
  fetch cursor_ into tuyenkenh_import_;
  if(cursor_%notfound = false) then --update
		update TUYENKENH_IMPORT set MADIEMDAU = madiemdau_, MADIEMCUOI = madiemcuoi_, GIAOTIEP_MA = giaotiep_ma_, DUAN_MA = duan_ma_, PHONGBAN_MA = phongban_ma_, KHUVUC_MA = khuvuc_ma_, DUNGLUONG = dungluong_, SOLUONG = soluong_,DATEIMPORT = dateimport_ where ID = tuyenkenh_import_.ID;
	else --insert
		i := SEQ_TUYENKENH_IMPORT.nextval;
		insert into TUYENKENH_IMPORT(STT,MADIEMDAU,MADIEMCUOI,GIAOTIEP_MA,DUAN_MA,PHONGBAN_MA,KHUVUC_MA,DUNGLUONG,SOLUONG,DATEIMPORT,ID) values (stt_,madiemdau_,madiemcuoi_,giaotiep_ma_,duan_ma_,phongban_ma_,khuvuc_ma_,dungluong_,soluong_,dateimport_,i);
	end if;
  close cursor_;*/
  open cursor_ for select t.* from TUYENKENH t left join LOAIGIAOTIEP t0 on t0.ID = t.GIAOTIEP_ID where t.DELETED = 0 and MADIEMDAU=madiemdau_ and MADIEMCUOI = madiemcuoi_ and t0.MA = giaotiep_ma_ and t.DUNGLUONG = dungluong_;
  i := SEQ_TUYENKENH_IMPORT.nextval;
  fetch cursor_ into tuyenkenh_;
  if(cursor_%notfound = false) then --duplicate tuyen kenh
		insert into TUYENKENH_IMPORT(STT,MADIEMDAU,MADIEMCUOI,GIAOTIEP_MA,DUAN_MA,PHONGBAN_MA,DOITAC_MA,DUNGLUONG,SOLUONG,DATEIMPORT,ID,DUPLICATE,TRANGTHAI) values (stt_,madiemdau_,madiemcuoi_,giaotiep_ma_,duan_ma_,phongban_ma_,doitac_ma_,dungluong_,soluong_,dateimport_,i,tuyenkenh_.ID,trangthai_);
	else --
		insert into TUYENKENH_IMPORT(STT,MADIEMDAU,MADIEMCUOI,GIAOTIEP_MA,DUAN_MA,PHONGBAN_MA,DOITAC_MA,DUNGLUONG,SOLUONG,DATEIMPORT,ID,TRANGTHAI) values (stt_,madiemdau_,madiemcuoi_,giaotiep_ma_,duan_ma_,phongban_ma_,doitac_ma_,dungluong_,soluong_,dateimport_,i,trangthai_);
	end if;
  close cursor_;
END SAVE_TUYENKENH_IMPORT;

/

