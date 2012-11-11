ALTER TABLE PHULUC  
MODIFY (TIMECREATE NUMBER );

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
		update PHULUC set PHULUCTHAYTHE_ID = null,NGAYHETHIEULUC = null where PHULUCTHAYTHE_ID = i;
		update CHITIETPHULUC_TUYENKENH set PHULUC_ID = null where PHULUC_ID = i;
	else --insert
		i:=SEQ_PHULUC.nextval;	
		insert into PHULUC(ID,CHITIETPHULUC_ID,HOPDONG_ID,TENPHULUC,LOAIPHULUC,NGAYKY,NGAYHIEULUC,THANG,NAM,TRANGTHAI,USERCREATE,TIMECREATE,DELETED,NGAYHETHIEULUC,FILENAME,FILEPATH,FILESIZE,PHULUCTHAYTHE_ID,CUOCDAUNOI,GIATRITRUOCTHUE,GIATRISAUTHUE,SOLUONGKENH) values (i,chitietphuluc_id_,hopdong_id_,tenphuluc_,loaiphuluc_,ngayky_,ngayhieuluc_,null,null,0,usercreate_,timecreate_,0,null,filename_,filepath_,filesize_,null,cuocdaunoi_,giatritruocthue_,giatrisauthue_,soluongkenh_);
	end if;
	update CHITIETPHULUC_TUYENKENH set PHULUC_ID = i where CHITIETPHULUC_ID = chitietphuluc_id_;
	return i;
END SAVE_PHULUC;

/

ALTER TABLE BANGIAO 
ADD (NGAYKY DATE );

ALTER TABLE TUYENKENH 
ADD (FLAG NUMBER DEFAULT 0 );

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
ngayky_ in date
) RETURN NUMBER AS
i INTEGER := 0;
BEGIN
	if(id_ is not null and id_>0) then --update
		update BANGIAO set SOBIENBAN = sobienban_,FILENAME = filename_,FILEPATH = filepath_,FILESIZE = filesize_, NGAYKY = ngayky_ where ID = id_;
		i := id_;
		update TUYENKENH set TRANGTHAI = 1,FLAG = 0 where ID in (select TUYENKENH_ID from TUYENKENHDEXUAT where BANGIAO_ID = id_);
		update TUYENKENHDEXUAT set BANGIAO_ID = null,TRANGTHAI = 1 where BANGIAO_ID = id_;
	else --insert
		i:=SEQ_BANGIAO.nextval;
		
		insert into BANGIAO(ID,SOBIENBAN,USERCREATE,TIMECREATE,DELETED,FILENAME,FILEPATH,FILESIZE,NGAYKY) values (i,sobienban_,usercreate_,timecreate_,0,filename_,filepath_,filesize_,ngayky_);
	end if;
	return i;
END SAVE_BANGIAO;

/

--------------------------------------------------------
--  DDL for Function FN_FIND_TUYENKENH
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FN_FIND_TUYENKENH" (
iDisplayStart IN NUMBER,   
iDisplayLength IN NUMBER, 
makenh_ in varchar2,
loaigiaotiep_ in varchar2,
madiemdau_ in varchar2,
madiemcuoi_ in varchar2,
duan_ in varchar2,
doitac_ in varchar2,
phongban_ in varchar2,
ngaydenghibangiao_ in varchar2,
ngayhenbangiao_ in varchar2,
trangthai_ in varchar2,
flag_ in varchar2
) RETURN SYS_REFCURSOR AS
l_cursor SYS_REFCURSOR;
v_vcsql VARCHAR2(2000);
v_vcsqlwhere VARCHAR2(1000);
i NUMBER;
BEGIN
	v_vcsqlwhere := ' t0.DELETED = 0 ';
	if(makenh_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t0.ID like '''||replace(makenh_, '*', '%')||'%'' ';
	end if;
	if(loaigiaotiep_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and GIAOTIEP_ID = '||loaigiaotiep_||' ';
	end if;
	if(duan_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and DUAN_ID = '||duan_||' ';
	end if;
  if(flag_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and FLAG = '||flag_||' ';
	end if;
	if(doitac_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t0.DOITAC_ID = '||doitac_||' ';
	end if;
	if(phongban_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and PHONGBAN_ID = '||phongban_||' ';
	end if;
	if(trangthai_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and TRANGTHAI = '||trangthai_||' ';
	end if;
	if(madiemdau_ is not null) then
    
		v_vcsqlwhere := v_vcsqlwhere ||' and MADIEMDAU like '''||replace(madiemdau_, '*', '%')||''' ';
	end if;
	if(madiemcuoi_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and MADIEMCUOI like '''||replace(madiemcuoi_, '*', '%')||''' ';
	end if;
	if(ngaydenghibangiao_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and NGAYDENGHIBANGIAO = TO_DATE('''||ngaydenghibangiao_||''',''DD-MM-RRRR'') ';
	end if;
	if(ngayhenbangiao_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and NGAYHENBANGIAO = TO_DATE('''||ngayhenbangiao_||''',''DD-MM-RRRR'') ';
	end if;
	v_vcsql := 'select rownum as rn,dulieu.* from (SELECT t0.ID,MADIEMDAU,MADIEMCUOI,t1.LOAIGIAOTIEP,t0.DUNGLUONG,t0.SOLUONG,t2.TENDUAN,t0.GIAOTIEP_ID,t0.DUAN_ID,t0.PHONGBAN_ID,t0.DOITAC_ID,t3.TENPHONGBAN,t4.TENDOITAC,t0.TRANGTHAI FROM TUYENKENH t0 left join LOAIGIAOTIEP t1 on t0.GIAOTIEP_ID = t1.ID left join DUAN t2 on t0.DUAN_ID = t2.ID left join PHONGBAN t3 on t0.PHONGBAN_ID = t3.ID left join DOITAC t4 on t0.DOITAC_ID=t4.ID WHERE ' || v_vcsqlwhere || ' order by t0.ID desc) dulieu ';
	v_vcsql := 'SELECT * FROM (' || v_vcsql || ') WHERE rn > ' || iDisplayStart || ' and rn <= ' || (iDisplayStart+iDisplayLength);
	--dbms_output.put_line(v_vcsql);
 --test(v_vcsql);
	OPEN l_cursor FOR v_vcsql;
	RETURN l_cursor;
END FN_FIND_TUYENKENH;

/

--------------------------------------------------------
--  DDL for Function FN_SAVEDOISOATCUOC
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."FN_SAVEDOISOATCUOC" (
doitac_id_ in varchar2,
tungay_ in date,
denngay_ in date,
phulucs in TABLE_VARCHAR,
sucos in TABLE_VARCHAR,
timecreate_ in number
)  RETURN SYS_REFCURSOR AS
l_cursor SYS_REFCURSOR;
-- Bien dung cho bang DOISOATCUOC
vDoiSoatCuocId number;
vDSCThanhTien number := 0;
vGiamTruMLL number := 0;
-- Bien dung cho bang DOISOATCUOC_PHULUC
vSoNgay number;
vTuNgay date;
vDenNgay date;
vThanhTien number;
vDauNoiHoaMang number;
vDaThanhToan number;
vConThanhToan number;
BEGIN
  vDoiSoatCuocId := SEQ_DOISOATCUOC.nextval;
	insert into DOISOATCUOC(ID,DOITAC_ID,TUNGAY,DENNGAY,TIMECREATE,DELETED) values (vDoiSoatCuocId,doitac_id_,tungay_,denngay_,timecreate_,timecreate_);
	for rec in (select * from PHULUC where DELETED = 0 and ID in ((select * from table(phulucs)))) loop
		if(rec.THANG is null) then -- phu luc ke khai thanh toan lan dau
			vTuNgay := rec.NGAYHIEULUC;
			vDauNoiHoaMang := rec.CUOCDAUNOI;
		else
			vTuNgay := tungay_;
			vDauNoiHoaMang := 0;
		end if;
		
		if(rec.NGAYHETHIEULUC < denngay_) then
			vDenNgay := rec.NGAYHETHIEULUC;
		else
			vDenNgay := denngay_;
		end if;
		vSoNgay := vDenNgay - vTuNgay;
		vThanhTien := floor(rec.GIATRISAUTHUE / 30) * vSoNgay;
		vDaThanhToan := 0;
		vConThanhToan := vThanhTien + vDauNoiHoaMang - vDaThanhToan;
		insert into DOISOATCUOC_PHULUC(DOISOATCUOC_ID,PHULUC_ID,TUNGAY,DENNGAY,SOTHANG,SONGAY,THANHTIEN,DAUNOIHOAMANG,DATHANHTOAN,CONTHANHTOAN) values (vDoiSoatCuocId,rec.ID,vTuNgay,vDenNgay,floor(vSoNgay/30),MOD(vSoNgay,30),vThanhTien,vDauNoiHoaMang,vDaThanhToan,vConThanhToan);
		
		vDSCThanhTien:= vDSCThanhTien + vThanhTien;
	end loop;
	
	--Tinh gia tri giam tru mat lien lac
	for rec in (select * from SUCOKENH where DELETED = 0 and ID in ((select * from table(sucos)))) loop
    insert into DOISOATCUOC_SUCO(DOISOATCUOC_ID,SUCO_ID) values (vDoiSoatCuocId,rec.ID);
		vGiamTruMLL := vGiamTruMLL + rec.GIAMTRUMLL;
	end loop;
	
	-- Cap nhat lai bang doi soat cuoc
	update DOISOATCUOC SET GIAMTRUMLL = vGiamTruMLL, THANHTIEN = vDSCThanhTien where ID = vDoiSoatCuocId;
  open l_cursor for select vDoiSoatCuocId as ID,vDSCThanhTien as THANHTIEN,vGiamTruMLL as GIAMTRUMLL from dual;
  return l_cursor;
END FN_SAVEDOISOATCUOC;

/

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
      commit;
		end if;
    delete from TUYENKENH_IMPORT where ID = rec.ID;
	end loop;
END PROC_IMPORT_TUYENKENH;

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
    update TUYENKENH set FLAG = 1 where ID in (SELECT TUYENKENH_ID FROM CHITIETPHULUC_TUYENKENH where PHULUC_ID = i);
		update PHULUC set PHULUCTHAYTHE_ID = null,NGAYHETHIEULUC = null where PHULUCTHAYTHE_ID = i;
		update CHITIETPHULUC_TUYENKENH set PHULUC_ID = null where PHULUC_ID = i;
	else --insert
		i:=SEQ_PHULUC.nextval;	
		insert into PHULUC(ID,CHITIETPHULUC_ID,HOPDONG_ID,TENPHULUC,LOAIPHULUC,NGAYKY,NGAYHIEULUC,THANG,NAM,TRANGTHAI,USERCREATE,TIMECREATE,DELETED,NGAYHETHIEULUC,FILENAME,FILEPATH,FILESIZE,PHULUCTHAYTHE_ID,CUOCDAUNOI,GIATRITRUOCTHUE,GIATRISAUTHUE,SOLUONGKENH) values (i,chitietphuluc_id_,hopdong_id_,tenphuluc_,loaiphuluc_,ngayky_,ngayhieuluc_,null,null,0,usercreate_,timecreate_,0,null,filename_,filepath_,filesize_,null,cuocdaunoi_,giatritruocthue_,giatrisauthue_,soluongkenh_);
	end if;
  update TUYENKENH set FLAG = 0 where ID in (SELECT TUYENKENH_ID FROM CHITIETPHULUC_TUYENKENH where CHITIETPHULUC_ID = chitietphuluc_id_);
	update CHITIETPHULUC_TUYENKENH set PHULUC_ID = i where CHITIETPHULUC_ID = chitietphuluc_id_;
	return i;
END SAVE_PHULUC;

/

--------------------------------------------------------
--  DDL for Function BC_CHUABANGIAO
--------------------------------------------------------

  CREATE OR REPLACE FUNCTION "THUEKENH"."BC_CHUABANGIAO" (
doitac_id_ in varchar2
) RETURN SYS_REFCURSOR AS
l_cursor SYS_REFCURSOR;
v_vcsql VARCHAR2(2000);
v_vcsqlwhere VARCHAR2(1000);
BEGIN
	v_vcsqlwhere := ' t.DELETED = 0 and t.TRANGTHAI = 0 ';
	if(doitac_id_ is not null) then
		v_vcsqlwhere := v_vcsqlwhere ||' and t1.DOITAC_ID = '||doitac_id_||' ';
	end if;
	v_vcsql := 'select t1.*,t.NGAYDENGHIBANGIAO,t.NGAYHENBANGIAO,t.SOLUONG as SOLUONGDEXUAT,t.TIENDO from TUYENKENHDEXUAT t left join TUYENKENH t1 on t.TUYENKENH_ID = t1.ID WHERE ' || v_vcsqlwhere || ' order by t.ID desc';
	OPEN l_cursor FOR v_vcsql;
	RETURN l_cursor;
END BC_CHUABANGIAO;

/

--------------------------------------------------------
--  DDL for Procedure CLEAR_DATA
--------------------------------------------------------
set define off;

  CREATE OR REPLACE PROCEDURE "THUEKENH"."CLEAR_DATA" AS 
BEGIN
  execute immediate 'truncate table "THUEKENH"."TUYENKENH" drop storage';
  execute immediate 'truncate table "THUEKENH"."BANGIAO" drop storage';
  execute immediate 'truncate table "THUEKENH"."BIENBANVANHANH" drop storage';
  execute immediate 'truncate table "THUEKENH"."DEXUAT" drop storage';
  execute immediate 'truncate table "THUEKENH"."SUCO_IMPORT" drop storage';
  execute immediate 'truncate table "THUEKENH"."SUCOKENH" drop storage';
  execute immediate 'truncate table "THUEKENH"."TUYENKENH_IMPORT" drop storage';
  execute immediate 'truncate table "THUEKENH"."TUYENKENH_TIEUCHUAN" drop storage';
  execute immediate 'truncate table "THUEKENH"."TUYENKENHDEXUAT" drop storage';
  execute immediate 'truncate table "THUEKENH"."VANHANH_SUCOKENH" drop storage';
  execute immediate 'truncate table "THUEKENH"."CHITIETPHULUC" drop storage';
  execute immediate 'truncate table "THUEKENH"."CHITIETPHULUC_TUYENKENH" drop storage';
  execute immediate 'truncate table "THUEKENH"."DOISOATCUOC" drop storage';
  execute immediate 'truncate table "THUEKENH"."DOISOATCUOC_PHULUC" drop storage';
  execute immediate 'truncate table "THUEKENH"."DOISOATCUOC_SUCO" drop storage';
  execute immediate 'truncate table "THUEKENH"."HOPDONG" drop storage';
  execute immediate 'truncate table "THUEKENH"."PHULUC" drop storage';
   execute immediate 'truncate table "THUEKENH"."THANHTOAN" drop storage';
  reset_seq('SEQ_BANGIAO');
  reset_seq('SEQ_BIENBANVANHANH');
  reset_seq('SEQ_DEXUAT');
  reset_seq('SEQ_SUCO');
  reset_seq('SEQ_SUCOIMPORT');
  reset_seq('SEQ_TUYENKENH');
  reset_seq('SEQ_TUYENKENH_IMPORT');
  reset_seq('SEQ_TUYENKENHDEXUAT');
  reset_seq('SEQ_DOISOATCUOC');
  reset_seq('SEQ_HOPDONG');
  reset_seq('SEQ_PHULUC');
  reset_seq('SEQ_THANHTOAN');
  update DOITAC set SOTUYENKENH = 0;
END CLEAR_DATA;

/

CREATE TABLE LOG_TABLE 
(
  ID NUMBER NOT NULL 
, OBJECT VARCHAR2(20) 
, PROPERTY VARCHAR2(20) 
, OLDVALUE VARCHAR2(200) 
, NEWVALUE VARCHAR2(200) 
, TRANSACTION_ID NUMBER 
, CONSTRAINT LOG_TABLE_PK PRIMARY KEY 
  (
    ID 
  )
  ENABLE 
);

CREATE TABLE LOG_TRANSACTION 
(
  ID NUMBER NOT NULL 
, USER_ID VARCHAR2(20) 
, TRANSACTION_DATE NUMBER 
, CONSTRAINT LOG_TRANSACTION_PK PRIMARY KEY 
  (
    ID 
  )
  ENABLE 
);

ALTER TABLE LOG_TABLE 
RENAME TO LOG_CHANGE;
ALTER TABLE LOG_CHANGE 
DROP COLUMN OBJECT;

ALTER TABLE LOG_CHANGE RENAME COLUMN TRANSACTION_ID TO LOG_TABLE_ID;
ALTER TABLE LOG_TRANSACTION 
RENAME TO LOG_TABLE;
ALTER TABLE LOG_TABLE 
ADD (TABLE_NAME VARCHAR2(20) );

ALTER TABLE LOG_TABLE RENAME COLUMN TRANSACTION_DATE TO CREATETIME;
ALTER TABLE LOG_TABLE RENAME COLUMN CREATETIME TO LOGTIME;
ALTER TABLE LOG_TABLE 
ADD (CREATETIME DATE );