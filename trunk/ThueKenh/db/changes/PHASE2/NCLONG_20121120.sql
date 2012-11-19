ALTER TABLE TUYENKENH_HISTORY 
RENAME TO LICHSU_TUYENKENH;

ALTER TABLE LICHSU_TUYENKENH 
DROP COLUMN ACTION;

ALTER TABLE LICHSU_TUYENKENH  
MODIFY (TIMEACTION NUMBER );

ALTER TABLE LICHSU_TUYENKENH 
DROP CONSTRAINT TUYENKENH_HISTORY_PK;

ALTER TABLE LICHSU_TUYENKENH 
DROP COLUMN ID;

ALTER TABLE LICHSU_TUYENKENH  
MODIFY (TIMEACTION DATE );

ALTER TABLE LICHSU_TUYENKENH 
ADD (ACTION NUMBER );

--------------------------------------------------------
--  DDL for Procedure PROC_INSERT_LICHSU_TUYENKENH
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "THUEKENH"."PROC_INSERT_LICHSU_TUYENKENH" (
useraction_ in varchar2,
tuyenkenh_id_ in varchar2,
action_ in varchar2,
info_ in varchar2
) AS 
BEGIN
	insert into LICHSU_TUYENKENH(TIMEACTION,USERACTION,INFO,TUYENKENH_ID,ACTION) values (sysdate,useraction_,info_,tuyenkenh_id_,action_);
END PROC_INSERT_LICHSU_TUYENKENH;

/

--------------------------------------------------------
--  DDL for Procedure PROC_UPDATE_THANHTOAN
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "THUEKENH"."PROC_UPDATE_THANHTOAN" (
pSoHoSo in varchar2,
pNgayKyUNC in date,
pNgayChuyenKhoan in date
) AS 
vThanhToanId  number;
vThang  number;
vNam  number;
vDoiSoatCuocID  number;
i number;
BEGIN
	select t.ID,extract(year from t1.DENNGAY),extract(month from t1.DENNGAY),t1.ID into vThanhToanId,vNam,vThang,vDoiSoatCuocID FROM THANHTOAN t left join DOISOATCUOC t1 on t.DOISOATCUOC_ID = t1.ID where t.DELETED = 0 and t.SOHOSO = pSoHoSo;
	--test(vDoiSoatCuocID||'sas');commit;
  if(vThanhToanId is not null) then
		update THANHTOAN set NGAYKYUNC = pNgayKyUNC,NGAYCHUYENKHOAN = pNgayChuyenKhoan,TRANGTHAI = 1 where ID = vThanhToanId;
		update SUCOKENH SET TRANGTHAI = 1 WHERE THANHTOAN_ID = vThanhToanId;
    for rec in (select t.* from PHULUC t left join DOISOATCUOC_PHULUC t1 on t.ID = t1.PHULUC_ID where DOISOATCUOC_ID = vDoiSoatCuocID) loop
      if(rec.NGAYHETHIEULUC is not null) then
        i := extract(month from rec.NGAYHETHIEULUC);
        if(i >= vThang) then
          i := vThang;
        end if;
        if(i <= vThang) then --cap nhat trang thai cua phu luc nay la het hieu luc
         update PHULUC set TRANGTHAI = 1 where ID = rec.ID;
        end if;
      else
        i := vThang;
      end if;
      update PHULUC set THANG = i,NAM = vNam where ID = rec.ID;
      for rec2 in (select * from CHITIETPHULUC_TUYENKENH where PHULUC_ID = rec.ID) loop
        PROC_INSERT_LICHSU_TUYENKENH('SYSTEM',rec2.TUYENKENH_ID,5,vThanhToanId);
      end loop;
    end loop;
	end if;
  NULL;
END PROC_UPDATE_THANHTOAN;

/

--------------------------------------------------------
--  DDL for Function FN_FIND_LICHSUTUYENKENH
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FN_FIND_LICHSUTUYENKENH" (
iDisplayStart IN NUMBER,   
iDisplayLength IN NUMBER, 
makenh_ in varchar2
) RETURN SYS_REFCURSOR AS
l_cursor SYS_REFCURSOR;
v_vcsql VARCHAR2(2000);
i NUMBER;
BEGIN
	v_vcsql := 'select rownum as rn,dulieu.* from (SELECT * FROM LICHSU_TUYENKENH t where t.TUYENKENH_ID='''||makenh_||''' order by t.TIMEACTION desc) dulieu ';
	v_vcsql := 'SELECT * FROM (' || v_vcsql || ') WHERE rn > ' || iDisplayStart || ' and rn <= ' || (iDisplayStart+iDisplayLength);
	OPEN l_cursor FOR v_vcsql;
	RETURN l_cursor;
END FN_FIND_LICHSUTUYENKENH;

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
  for rec in (select * from CHITIETPHULUC_TUYENKENH where CHITIETPHULUC_ID = chitietphuluc_id_) loop
    PROC_INSERT_LICHSU_TUYENKENH(usercreate_,rec.TUYENKENH_ID,4,tenphuluc_);
  end loop;
	return i;
END SAVE_PHULUC;

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
) RETURN VARCHAR2 AS
i INTEGER := 0;
madoitac varchar2(50);
matuyenkenh varchar2(20);
BEGIN
	if(id_ is not null) then --update
		update TUYENKENH set GIAOTIEP_ID=giaotiep_id_, DUAN_ID = duan_id_,PHONGBAN_ID = phongban_id_,DOITAC_ID = doitac_id_,DUNGLUONG = dungluong_,SOLUONG = soluong_,TRANGTHAI = trangthai_ where ID = id_;
		matuyenkenh := id_;
    PROC_INSERT_LICHSU_TUYENKENH(usercreate_,matuyenkenh,3,'');
	else --insert
    select ma into madoitac from doitac where id = doitac_id_;
		i:=GET_SOTUYENKENH(doitac_id_) + 1;
		matuyenkenh := madoitac||'_'||TRIM(to_char(i,'0009'));
		insert into TUYENKENH(ID, MADIEMDAU, MADIEMCUOI, GIAOTIEP_ID, DUAN_ID, PHONGBAN_ID, DOITAC_ID, DUNGLUONG, SOLUONG, TRANGTHAI, USERCREATE, TIMECREATE, DELETED) values (matuyenkenh, diemdau_id_, diemcuoi_id_, giaotiep_id_, duan_id_, phongban_id_, doitac_id_, dungluong_, soluong_, trangthai_, usercreate_, timecreate_, 0);
    UPDATE DOITAC SET SOTUYENKENH = SOTUYENKENH + 1 WHERE ID = doitac_id_;
    PROC_INSERT_LICHSU_TUYENKENH(usercreate_,matuyenkenh,1,'');
  end if;
	return matuyenkenh;
END SAVE_TUYENKENH;

/


