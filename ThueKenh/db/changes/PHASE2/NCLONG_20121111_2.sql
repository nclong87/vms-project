ALTER TABLE TUYENKENHDEXUAT 
ADD (FLAG NUMBER DEFAULT 0 );

COMMENT ON COLUMN TUYENKENHDEXUAT.FLAG IS 'Luu tam phu luc ID';

ALTER TABLE BANGIAO RENAME COLUMN NGAYKY TO NGAYBANGIAO;
alter trigger "THUEKENH"."INSERT_TUYENKENH" disable;

--------------------------------------------------------
--  DDL for Procedure PROC_IMPORT_TUYENKENH
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "THUEKENH"."PROC_IMPORT_TUYENKENH" (
pi_array in TABLE_NUMBER,
usercreate_ in varchar2,
timecreate_ in date
) AS 
i INTEGER := 1;
madoitac varchar2(50);
matuyenkenh varchar2(20);
BEGIN
	for rec in (SELECT t.ID,t.MADIEMDAU, t.MADIEMCUOI, t0.ID as GIAOTIEP_ID, t1.ID as DUAN_ID, t2.ID as PHONGBAN_ID, t3.ID as DOITAC_ID, t.DUNGLUONG, t.SOLUONG,DUPLICATE,DOITAC_MA,t.TRANGTHAI FROM TUYENKENH_IMPORT t left join LOAIGIAOTIEP t0 on t.GIAOTIEP_MA = t0.MA left join DUAN t1 on t.DUAN_MA = t1.MA left join PHONGBAN t2 on t.PHONGBAN_MA = t2.MA left join DOITAC t3 on t.DOITAC_MA=t3.MA where t.ID in (select * from table(pi_array))) loop
		if(rec.DUPLICATE is not null) then --duplicate => update tuyenkenh
			update TUYENKENH set MADIEMDAU = rec.MADIEMDAU, MADIEMCUOI = rec.MADIEMCUOI, GIAOTIEP_ID = rec.GIAOTIEP_ID, DUAN_ID = rec.DUAN_ID, PHONGBAN_ID = rec.PHONGBAN_ID, DOITAC_ID = rec.DOITAC_ID, DUNGLUONG = rec.DUNGLUONG, SOLUONG = rec.SOLUONG, TRANGTHAI = rec.TRANGTHAI where ID = rec.DUPLICATE;
		else --insert
      i:=GET_SOTUYENKENH(rec.DOITAC_ID) + 1;
      matuyenkenh := rec.DOITAC_MA||'_'||TRIM(to_char(i,'0009'));
			insert into TUYENKENH(ID,MADIEMDAU,MADIEMCUOI,GIAOTIEP_ID,DUAN_ID,PHONGBAN_ID,DOITAC_ID,DUNGLUONG,TRANGTHAI,USERCREATE,TIMECREATE,DELETED,SOLUONG,TRANGTHAI_BAK) values (matuyenkenh,rec.MADIEMDAU,rec.MADIEMCUOI,rec.GIAOTIEP_ID,rec.DUAN_ID,rec.PHONGBAN_ID,rec.DOITAC_ID,rec.DUNGLUONG,rec.TRANGTHAI,usercreate_,timecreate_,0,rec.SOLUONG,0);
      UPDATE DOITAC SET SOTUYENKENH = SOTUYENKENH + 1 WHERE ID = rec.DOITAC_ID;
		end if;
    delete from TUYENKENH_IMPORT where ID = rec.ID;
	end loop;
END PROC_IMPORT_TUYENKENH;

/

--------------------------------------------------------
--  DDL for Function SAVE_TUYENKENH
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."SAVE_TUYENKENH" (
id_ in VARCHAR2,
diemdau_id_ in VARCHAR2,
diemcuoi_id_ in VARCHAR2,
giaotiep_id_ in VARCHAR2,
duan_id_ in VARCHAR2,
phongban_id_ in VARCHAR2,
doitac_id_ in VARCHAR2,
dungluong_ in VARCHAR2,
soluong_ in VARCHAR2,
trangthai_ in VARCHAR2,
usercreate_ in VARCHAR2,
timecreate_ in VARCHAR2,
deleted_ in VARCHAR2
) RETURN NUMBER AS
i INTEGER := 0;
madoitac varchar2(50);
matuyenkenh varchar2(20);
BEGIN
	if(id_ is not null) then --update
		update TUYENKENH set GIAOTIEP_ID=giaotiep_id_, DUAN_ID = duan_id_,PHONGBAN_ID = phongban_id_,DOITAC_ID = doitac_id_,DUNGLUONG = dungluong_,SOLUONG = soluong_,TRANGTHAI = trangthai_ where ID = id_;
		matuyenkenh := id_;
	else --insert
    select ma into madoitac from doitac where id = doitac_id_;
		i:=GET_SOTUYENKENH(doitac_id_) + 1;
		matuyenkenh := madoitac||'_'||TRIM(to_char(i,'0009'));
		insert into TUYENKENH(ID, MADIEMDAU, MADIEMCUOI, GIAOTIEP_ID, DUAN_ID, PHONGBAN_ID, DOITAC_ID, DUNGLUONG, SOLUONG, TRANGTHAI, USERCREATE, TIMECREATE, DELETED) values (matuyenkenh, diemdau_id_, diemcuoi_id_, giaotiep_id_, duan_id_, phongban_id_, doitac_id_, dungluong_, soluong_, trangthai_, usercreate_, timecreate_, 0);
    UPDATE DOITAC SET SOTUYENKENH = SOTUYENKENH + 1 WHERE ID = doitac_id_;
  end if;
	return i;
END SAVE_TUYENKENH;

/

--------------------------------------------------------
--  DDL for Function SAVE_BANGIAO
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."SAVE_BANGIAO" (
id_ in VARCHAR2,
sobienban_ in VARCHAR2,
usercreate_ in VARCHAR2,
timecreate_ in VARCHAR2,
filename_ in VARCHAR2,
filepath_ in VARCHAR2,
filesize_ in VARCHAR2,
ngaybangiao_ in varchar2
) RETURN NUMBER AS
i INTEGER := 0;
BEGIN
	if(id_ is not null and id_>0) then --update
		update BANGIAO set SOBIENBAN = sobienban_,FILENAME = filename_,FILEPATH = filepath_,FILESIZE = filesize_,NGAYBANGIAO = ngaybangiao_ where ID = id_;
		i := id_;
		update TUYENKENH set TRANGTHAI = 1 where ID in (select TUYENKENH_ID from TUYENKENHDEXUAT where BANGIAO_ID = id_);
		update TUYENKENHDEXUAT set BANGIAO_ID = null,TRANGTHAI = 1 where BANGIAO_ID = id_;
	else --insert
		i:=SEQ_BANGIAO.nextval;
		
		insert into BANGIAO(ID,SOBIENBAN,USERCREATE,TIMECREATE,DELETED,FILENAME,FILEPATH,FILESIZE,NGAYBANGIAO) values (i,sobienban_,usercreate_,timecreate_,0,filename_,filepath_,filesize_,ngaybangiao_);
	end if;
	return i;
END SAVE_BANGIAO;

/

--------------------------------------------------------
--  DDL for Function SAVE_PHULUC
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."SAVE_PHULUC" (
id_ in VARCHAR2,
chitietphuluc_id_ in VARCHAR2,
hopdong_id_ in VARCHAR2,
tenphuluc_ in VARCHAR2,
loaiphuluc_ in VARCHAR2,
ngayky_ in VARCHAR2,
ngayhieuluc_ in VARCHAR2,
usercreate_ in VARCHAR2,
timecreate_ in VARCHAR2,
filename_ in VARCHAR2,
filepath_ in VARCHAR2,
filesize_ in VARCHAR2,
cuocdaunoi_ in VARCHAR2,
giatritruocthue_ in VARCHAR2,
giatrisauthue_ in VARCHAR2,
soluongkenh_ in VARCHAR2
) RETURN NUMBER AS
i INTEGER := 0;
ngayhethan_ DATE := null;
BEGIN
	--select NGAYHETHAN into ngayhethan_ from HOPDONG where ID = hopdong_id_;
	if(id_ is not null) then --update
		update PHULUC set CHITIETPHULUC_ID = chitietphuluc_id_,HOPDONG_ID = hopdong_id_,TENPHULUC = tenphuluc_,LOAIPHULUC = loaiphuluc_,NGAYKY = ngayky_,NGAYHIEULUC = ngayhieuluc_,FILENAME = filename_,FILEPATH = filepath_,FILESIZE = filesize_,CUOCDAUNOI = cuocdaunoi_,GIATRITRUOCTHUE = giatritruocthue_, GIATRISAUTHUE = giatrisauthue_, SOLUONGKENH = soluongkenh_ where ID = id_;
		i := id_;
    update TUYENKENHDEXUAT set FLAG = 0 where TUYENKENH_ID in (SELECT TUYENKENH_ID FROM CHITIETPHULUC_TUYENKENH where PHULUC_ID = i);
		update PHULUC set PHULUCTHAYTHE_ID = null,NGAYHETHIEULUC = null where PHULUCTHAYTHE_ID = i;
		update CHITIETPHULUC_TUYENKENH set PHULUC_ID = null where PHULUC_ID = i;
	else --insert
		i:=SEQ_PHULUC.nextval;	
		insert into PHULUC(ID,CHITIETPHULUC_ID,HOPDONG_ID,TENPHULUC,LOAIPHULUC,NGAYKY,NGAYHIEULUC,THANG,NAM,TRANGTHAI,USERCREATE,TIMECREATE,DELETED,NGAYHETHIEULUC,FILENAME,FILEPATH,FILESIZE,PHULUCTHAYTHE_ID,CUOCDAUNOI,GIATRITRUOCTHUE,GIATRISAUTHUE,SOLUONGKENH) values (i,chitietphuluc_id_,hopdong_id_,tenphuluc_,loaiphuluc_,ngayky_,ngayhieuluc_,null,null,0,usercreate_,timecreate_,0,null,filename_,filepath_,filesize_,null,cuocdaunoi_,giatritruocthue_,giatrisauthue_,soluongkenh_);
	end if;
  update TUYENKENHDEXUAT set FLAG = i where TUYENKENH_ID in (SELECT TUYENKENH_ID FROM CHITIETPHULUC_TUYENKENH where CHITIETPHULUC_ID = chitietphuluc_id_);
	update CHITIETPHULUC_TUYENKENH set PHULUC_ID = i where CHITIETPHULUC_ID = chitietphuluc_id_;
	return i;
END SAVE_PHULUC;

/

